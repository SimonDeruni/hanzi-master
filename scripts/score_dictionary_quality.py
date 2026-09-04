#!/usr/bin/env python3
"""Score localized CC-CEDICT definitions and persist expansion eligibility.

This script is deterministic and dependency-free. Run it after localized
definition columns have been populated. It is safe to run repeatedly.
"""

from __future__ import annotations

import argparse
import csv
import hashlib
import json
import re
import sqlite3
from collections import Counter, defaultdict
from pathlib import Path

SCORING_VERSION = "localized-quality-v1"
CONTENT_VERSION = "cc-cedict-localized-v1"
SCHEMA_VERSION = "2"
DEFAULT_THRESHOLD = 55
LANGUAGES = ("fr", "de", "es", "ru", "it", "pt", "ja", "ko", "vi", "id", "ar", "hi", "th")

ENGLISH_WORD = re.compile(r"\b(?:the|and|to|of|for|with|from|abbr|variant|surname)\b", re.I)
PLACEHOLDER = re.compile(r"(?:translation|undefined|null|n/?a|todo|^[-?]+$)", re.I)
LATIN = re.compile(r"[A-Za-z]")
NON_LATIN_LANGUAGES = {"ja", "ko", "ar", "hi", "th"}


def source_hash(definition: str) -> str:
    normalized = " ".join(definition.split())
    return hashlib.sha256(normalized.encode("utf-8")).hexdigest()


def score_definition(english: str, localized: str, language: str) -> tuple[int, list[str]]:
    """Return a 0..100 quality score and stable, machine-readable reasons."""
    english = " ".join((english or "").split())
    localized = " ".join((localized or "").split())
    reasons: list[str] = []
    if not localized:
        return 0, ["missing"]

    score = 100
    english_senses = max(1, len([part for part in english.split(";") if part.strip()]))
    localized_senses = max(1, len([part for part in localized.split(";") if part.strip()]))
    coverage = min(1.0, localized_senses / english_senses)
    if coverage < 0.4:
        score -= 35
        reasons.append("low_sense_coverage")
    elif coverage < 0.7:
        score -= 20
        reasons.append("partial_sense_coverage")

    length_ratio = len(localized) / max(1, len(english))
    if len(localized) < 3:
        score -= 45
        reasons.append("too_short")
    elif length_ratio < 0.18 and len(english) >= 25:
        score -= 25
        reasons.append("low_length_coverage")

    if localized.casefold() == english.casefold():
        score -= 55
        reasons.append("untranslated_copy")
    elif language != "id" and ENGLISH_WORD.search(localized):
        score -= 20
        reasons.append("english_leakage")

    if PLACEHOLDER.search(localized):
        score -= 45
        reasons.append("placeholder")

    parts = [p.strip().casefold() for p in localized.split(";") if p.strip()]
    if len(parts) >= 3 and len(set(parts)) / len(parts) < 0.6:
        score -= 20
        reasons.append("repetition")

    if language in NON_LATIN_LANGUAGES and len(localized) >= 8:
        latin_ratio = len(LATIN.findall(localized)) / len(localized)
        if latin_ratio > 0.65:
            score -= 25
            reasons.append("unexpected_script")

    return max(0, min(100, score)), reasons


def score_database(db_path: Path, report_dir: Path, threshold: int) -> dict:
    connection = sqlite3.connect(db_path)
    connection.execute("PRAGMA journal_mode=WAL")
    columns = {row[1] for row in connection.execute("PRAGMA table_info(words)")}
    available = [lang for lang in LANGUAGES if f"definition_{lang}" in columns]
    if not available:
        raise RuntimeError("No localized definition columns were found in words")

    connection.executescript("""
        CREATE TABLE IF NOT EXISTS dictionary_metadata (
          key TEXT PRIMARY KEY,
          value TEXT NOT NULL
        );
        DROP TABLE IF EXISTS localized_definition_quality;
        CREATE TABLE localized_definition_quality (
          word_id INTEGER NOT NULL,
          language_code TEXT NOT NULL,
          score INTEGER NOT NULL CHECK(score BETWEEN 0 AND 100),
          expansion_eligible INTEGER NOT NULL CHECK(expansion_eligible IN (0, 1)),
          source_definition_hash BLOB NOT NULL CHECK(length(source_definition_hash) = 32),
          scoring_version TEXT NOT NULL,
          reasons TEXT NOT NULL,
          PRIMARY KEY (word_id, language_code),
          FOREIGN KEY (word_id) REFERENCES words(id) ON DELETE CASCADE
        ) WITHOUT ROWID;
        CREATE INDEX IF NOT EXISTS idx_quality_eligible
          ON localized_definition_quality(language_code, expansion_eligible, score);
    """)
    select_columns = ", ".join(["id", "definition"] + [f"definition_{lang}" for lang in available])
    insert_sql = """INSERT INTO localized_definition_quality
        (word_id, language_code, score, expansion_eligible,
         source_definition_hash, scoring_version, reasons)
        VALUES (?, ?, ?, ?, ?, ?, ?)"""
    counts: dict[str, Counter] = defaultdict(Counter)
    reason_counts: dict[str, Counter] = defaultdict(Counter)
    batch = []
    for row in connection.execute(f"SELECT {select_columns} FROM words"):
        word_id, english, *localized_values = row
        digest = source_hash(english or "")
        detailed_source = len(english or "") >= 16 or ";" in (english or "")
        for language, localized in zip(available, localized_values):
            score, reasons = score_definition(english or "", localized or "", language)
            eligible = bool(localized and localized.strip() and detailed_source and score < threshold)
            counts[language]["total"] += 1
            counts[language]["eligible"] += int(eligible)
            counts[language]["missing"] += int(not localized or not localized.strip())
            counts[language]["score_sum"] += score
            reason_counts[language].update(reasons)
            # Missing translations have no localized definition to annotate.
            if not localized or not localized.strip():
                continue
            batch.append((word_id, language, score, int(eligible), bytes.fromhex(digest), SCORING_VERSION, json.dumps(reasons)))
        if len(batch) >= 5000:
            connection.executemany(insert_sql, batch)
            batch.clear()
    if batch:
        connection.executemany(insert_sql, batch)

    metadata = {
        "dictionary_schema_version": SCHEMA_VERSION,
        "dictionary_content_version": CONTENT_VERSION,
        "definition_scoring_version": SCORING_VERSION,
        "definition_quality_threshold": str(threshold),
    }
    connection.executemany(
        "INSERT OR REPLACE INTO dictionary_metadata(key, value) VALUES (?, ?)", metadata.items()
    )
    connection.commit()

    report_dir.mkdir(parents=True, exist_ok=True)
    summary = {
        "database": str(db_path),
        "scoringVersion": SCORING_VERSION,
        "threshold": threshold,
        "languages": {},
    }
    for language in available:
        values = counts[language]
        summary["languages"][language] = {
            "total": values["total"],
            "eligible": values["eligible"],
            "missing": values["missing"],
            "averageScore": round(values["score_sum"] / max(1, values["total"]), 2),
            "reasons": dict(reason_counts[language].most_common()),
        }
    (report_dir / "definition_quality_summary.json").write_text(
        json.dumps(summary, indent=2, ensure_ascii=False), encoding="utf-8"
    )
    with (report_dir / "definition_quality_sample.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.writer(handle)
        writer.writerow(("word_id", "hanzi", "language", "english", "localized", "score", "eligible", "reasons"))
        for language in available:
            writer.writerows(connection.execute(f"""
                SELECT w.id, w.simplified, q.language_code, w.definition,
                       w.definition_{language}, q.score, q.expansion_eligible, q.reasons
                FROM localized_definition_quality q JOIN words w ON w.id = q.word_id
                WHERE q.language_code = ? AND w.definition_{language} != ''
                ORDER BY q.score ASC, w.id ASC LIMIT 200
            """, (language,)))
    connection.execute("VACUUM")
    connection.close()
    return summary


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--db", type=Path, default=Path(__file__).parent / "../assets/data/dictionary.db")
    parser.add_argument("--report-dir", type=Path, default=Path(__file__).parent / "reports")
    parser.add_argument("--threshold", type=int, default=DEFAULT_THRESHOLD)
    args = parser.parse_args()
    if not 0 <= args.threshold <= 100:
        parser.error("threshold must be between 0 and 100")
    summary = score_database(args.db.resolve(), args.report_dir.resolve(), args.threshold)
    print(json.dumps(summary, ensure_ascii=False))


if __name__ == "__main__":
    main()