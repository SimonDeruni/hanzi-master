"""Build the dictionary asset the app ships, from the merged master database.

`assets/data/dictionary.db` is the file the app copies out of its bundle on first run
(see `global_dictionary_repository.dart`). It is NOT the master copy: the master is
`scratch/dictionary_v2.db`, which additionally carries the source layers
(`cjk_source_translations`, `wikidata_translations`, `unihan_readings`) and every
attribution key. This script derives the shippable asset from the master and, in the
same pass, writes the licence and machine-translation records the sources require.

The asset carries three tables:

  words                            the 13-language dictionary itself
  dictionary_metadata              attribution, licence and provenance keys
  localized_definition_provenance  per cell: which layer produced it, machine or not

The per-cell provenance is recovered by diffing the master against
`scratch/dictionary_v2.db.bak_before_deepseek` - the state of the master immediately
before the DeepSeek gap-fill. A cell counts as machine-translated if and only if it was
empty then and is filled now. That makes the claim checkable rather than asserted,
which is what section 14.3 of docs/TRANSLATION_STRATEGY.md asks for.

Run:
    python tooling/build_dictionary_asset.py
    python tooling/build_dictionary_asset.py --out assets/data/dictionary.db
"""
import argparse
import os
import shutil
import sqlite3
import sys

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MASTER = os.path.join(ROOT, "scratch", "dictionary_v2.db")
BEFORE = os.path.join(ROOT, "scratch", "dictionary_v2.db.bak_before_deepseek")
DEFAULT_OUT = os.path.join(ROOT, "assets", "data", "dictionary.db")
SCHEMA_VERSION = "3"

LANGS = ("ar", "de", "es", "fr", "hi", "id", "it", "ja", "ko", "pt", "ru", "th", "vi")

# ---------------------------------------------------------------------------
# The written notices. These are upserted into dictionary_metadata so the licence
# travels with the data file itself, not only with the repository. Keys follow the
# convention established by tooling/add_dictionary_attribution.py.
# ---------------------------------------------------------------------------
ATTRIBUTION = [
    # --- Tier 1: the headword spine and the English gloss -------------------
    ("cc_cedict_attribution",
     "Chinese headwords, pinyin and the English definitions that this app translates "
     "from come from CC-CEDICT (https://cc-cedict.org/), used under the Creative "
     "Commons Attribution-ShareAlike 4.0 International License (CC BY-SA 4.0)."),
    ("cc_cedict_license", "CC BY-SA 4.0"),
    ("cc_cedict_license_url", "https://creativecommons.org/licenses/by-sa/4.0/"),
    ("cc_cedict_source_url", "https://cc-cedict.org/wiki/"),
    ("cc_cedict_source_export",
     "https://www.mdbg.net/chinese/export/cedict/cedict_1_0_ts_utf-8_mdbg.txt.gz"),
    ("cc_cedict_is_modified", "1"),
    ("cc_cedict_modifications",
     "CC-CEDICT is stored here in SQLite under a custom schema; its entry list was "
     "merged with other dictionaries into one headword list; every English gloss was "
     "additionally translated into 13 languages; overlapping senses were filtered; and "
     "each localised value carries a provenance record. CC BY-SA 4.0 requires that such "
     "modifications be shared under the same licence, and they are."),
    ("dictionary_sources_excluded",
     "DELIBERATELY ABSENT from this build - these were in an earlier version of the app "
     "and have been removed because their licences do not permit this use, so no value "
     "in this database comes from them: 'Multilingual Pleco Database' (commercial "
     "publisher dictionaries), 'Big BKRS' (no licence stated), Facebook MUSE "
     "(CC BY-NC 4.0, non-commercial), PanLex (CC BY-NC-SA 4.0, non-commercial), "
     "LiudmilaLV/json_hsk (no LICENCE file), CFDICT (its own project never stated a "
     "licence), 'Han-Viet DB' (source not identified at all), Hindi WordNet "
     "(commercial use requires the author's permission), RuWordNet (self-contradictory "
     "terms), Taiwan MOE (CC BY-ND forbids merging into a dataset), WenZi. See "
     "third_party/dictionary-sources.md."),
    ("dictionary_provenance_note",
     "Every localised value in this database is attributable to a named source whose "
     "licence was read and confirmed to permit commercial redistribution, or is marked "
     "as machine translation in localized_definition_provenance. Per-cell provenance IS "
     "recorded in this build, unlike the previous one."),
    # --- Tier 3: machine translation ---------------------------------------
    ("translation_method",
     "Machine translation by DeepSeek (model deepseek-flash), one call per batch of 200 "
     "entries, translating the English gloss directly into all 13 target languages at "
     "once."),
    ("translation_source_language", "en"),
    ("translation_input",
     "The CC-CEDICT English gloss for the headword, cleaned of cross-references and "
     "markup."),
    ("translation_is_machine", "1"),
    ("translation_date", "2026-09-29"),
    ("translation_verification",
     "Per-entry gates: every one of the 13 fields must be non-empty; no Chinese "
     "characters may appear outside Japanese and Korean; any Chinese character present "
     "in the English gloss must be copied through verbatim. Failing entries were "
     "re-sent up to three times."),
    ("translation_exclusions",
     "Headwords whose English gloss was empty, one character long, or longer than 40 "
     "characters were not machine-translated; they keep the English gloss and are "
     "labelled as English in the app."),
    ("dictionary_machine_translation_notice",
     "Many localised definitions in this app are machine-generated, not human "
     "translations. Values produced by machine translation are marked as such in "
     "localized_definition_provenance (is_machine = 1) so the app can label them."),
]


def read_metadata(path):
    """The master's attribution keys - the legal record travels with the data."""
    con = sqlite3.connect("file:%s?mode=ro" % path.replace("\\", "/"), uri=True)
    try:
        return dict(con.execute("SELECT key, value FROM dictionary_metadata").fetchall())
    finally:
        con.close()


def create_asset(out_path):
    """A fresh copy of the master's schema, with the data copied across.

    `localized_definition_quality` is carried too when the master has it: the app
    reads it to decide whether to offer the AI expansion panel
    (`isExpansionEligible`), so dropping it would silently remove that feature.
    It is produced by scripts/score_dictionary_quality.py, which section 3 of
    docs/TRANSLATION_STRATEGY.md says to run after every rebuild.
    """
    tables = []
    master = sqlite3.connect("file:%s?mode=ro" % MASTER.replace("\\", "/"), uri=True)
    try:
        present = {r[0] for r in master.execute(
            "SELECT name FROM sqlite_master WHERE type='table'")}
        for table in ("words", "localized_definition_quality"):
            if table not in present:
                print("note: master has no %s table - not copied" % table)
                continue
            tables.append((table, [r[0] for r in master.execute(
                "SELECT sql FROM sqlite_master WHERE tbl_name=? AND sql IS NOT NULL",
                (table,))]))
    finally:
        master.close()
    if len(tables[0][1]) < 2:
        print("WARNING: expected the words table plus its indexes, found %d object(s)"
              % len(tables[0][1]))

    temp_path = out_path + ".building"
    for suffix in ("", "-wal", "-shm"):
        if os.path.exists(temp_path + suffix):
            os.remove(temp_path + suffix)

    con = sqlite3.connect(temp_path)
    con.execute("ATTACH DATABASE ? AS master", (MASTER,))
    con.execute("ATTACH DATABASE ? AS before", (BEFORE,))
    for table, statements in tables:
        for statement in statements:
            con.execute(statement)
        con.execute('INSERT INTO "%s" SELECT * FROM master."%s"' % (table, table))
        print("%-29s: %d rows" % (table + " copied",
                                  con.execute('SELECT COUNT(*) FROM "%s"' % table).fetchone()[0]))
    return con, temp_path


def build_provenance(con):
    """Record, for every filled cell, whether a machine or a licensed source made it.

    Machine cells are identified by diffing against the pre-merge backup, so the
    count is a fact about the data rather than a note someone typed.
    """
    con.execute("""
        CREATE TABLE localized_definition_provenance (
            word_id       INTEGER NOT NULL,
            language_code TEXT    NOT NULL,
            is_machine    INTEGER NOT NULL,
            source        TEXT    NOT NULL,
            PRIMARY KEY (word_id, language_code)
        )""")

    machine_sql = """
        INSERT OR REPLACE INTO localized_definition_provenance
            (word_id, language_code, is_machine, source)
        SELECT m.id, ?, 1, 'deepseek-flash'
        FROM master.words m JOIN before.words b ON b.id = m.id
        WHERE COALESCE(TRIM(b."definition_{L}"), '') = ''
          AND COALESCE(TRIM(m."definition_{L}"), '') <> ''"""

    # Pre-aggregate the licensed lookups ONCE. Doing this per language with correlated
    # subqueries would rescan the 290k-row wikidata table for every one of the ~1.6M
    # cells, which is quadratic and effectively never finishes.
    con.execute("""
        CREATE TEMP TABLE cjk_source AS
        SELECT word_id, language_code, MIN(source) AS source
        FROM master.cjk_source_translations GROUP BY word_id, language_code""")
    con.execute("""
        CREATE TEMP TABLE wd_source AS
        SELECT word_id, language_code, MIN(layer) AS layer
        FROM master.wikidata_translations GROUP BY word_id, language_code""")

    licensed_sql = """
        INSERT OR IGNORE INTO localized_definition_provenance
            (word_id, language_code, is_machine, source)
        SELECT m.id, ?, 0,
               COALESCE(c.source,
                        CASE WHEN w.layer IS NULL THEN NULL
                             ELSE 'wikidata/' || w.layer END,
                        'licensed')
        FROM master.words m
        LEFT JOIN cjk_source c ON c.word_id = m.id AND c.language_code = ?
        LEFT JOIN wd_source  w ON w.word_id = m.id AND w.language_code = ?
        WHERE COALESCE(TRIM(m."definition_{L}"), '') <> ''"""

    totals = {}
    print("\n%-4s %10s %10s" % ("lang", "machine", "licensed"))
    sys.stdout.flush()
    for lang in LANGS:
        con.execute(machine_sql.format(L=lang), (lang,))
        con.execute(licensed_sql.format(L=lang), (lang, lang, lang))
        row = con.execute(
            "SELECT SUM(is_machine = 1), SUM(is_machine = 0) "
            "FROM localized_definition_provenance WHERE language_code = ?",
            (lang,)).fetchone()
        totals[lang] = (row[0] or 0, row[1] or 0)
        print("%-4s %10d %10d" % (lang, totals[lang][0], totals[lang][1]))
        sys.stdout.flush()
    con.execute("DROP TABLE cjk_source")
    con.execute("DROP TABLE wd_source")
    con.commit()
    return totals


def write_metadata(con, totals):
    """Master attribution + the notices for this build + the measured counters."""
    rows = dict(read_metadata(MASTER))
    rows.update(ATTRIBUTION)
    rows["dictionary_schema_version"] = SCHEMA_VERSION
    rows["dictionary_content_version"] = "accepted-sources-v2+deepseek-mt"
    for lang in LANGS:
        rows["translation_coverage_%s" % lang] = str(totals[lang][0])
        rows["licensed_coverage_%s" % lang] = str(totals[lang][1])
    rows["translation_coverage_total"] = str(sum(t[0] for t in totals.values()))
    rows["licensed_coverage_total"] = str(sum(t[1] for t in totals.values()))

    con.execute("CREATE TABLE dictionary_metadata (key TEXT PRIMARY KEY, value TEXT)")
    con.executemany("INSERT OR REPLACE INTO dictionary_metadata (key, value) VALUES (?, ?)",
                    sorted(rows.items()))
    con.commit()
    return rows


def verify(con):
    """Prove the asset matches the master cell for cell, and report coverage."""
    mismatched = 0
    for lang in LANGS:
        column = '"definition_%s"' % lang
        master_n = con.execute(
            "SELECT COUNT(*) FROM master.words WHERE COALESCE(TRIM(%s),'')<>''"
            % column).fetchone()[0]
        asset_n = con.execute(
            "SELECT COUNT(*) FROM words WHERE COALESCE(TRIM(%s),'')<>''"
            % column).fetchone()[0]
        diff = con.execute(
            "SELECT COUNT(*) FROM words a JOIN master.words m ON m.id = a.id "
            "WHERE COALESCE(TRIM(a.%s),'') <> COALESCE(TRIM(m.%s),'')"
            % (column, column)).fetchone()[0]
        mismatched += diff
        print("  %-3s master=%-7d asset=%-7d differing=%d" % (lang, master_n, asset_n, diff))
    total = con.execute("SELECT COUNT(*) FROM words").fetchone()[0]
    full = con.execute(
        "SELECT COUNT(*) FROM words WHERE " + " AND ".join(
            "COALESCE(TRIM(\"definition_%s\"),'')<>''" % L for L in LANGS)
    ).fetchone()[0]
    print("  rows=%d  all-13-filled=%d (%.1f%%)" % (total, full, 100.0 * full / total))
    return mismatched


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--out", default=DEFAULT_OUT)
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args()

    print("master : %s (%.1f MB)" % (MASTER, os.path.getsize(MASTER) / 1024 / 1024))
    print("before : %s (%.1f MB)" % (BEFORE, os.path.getsize(BEFORE) / 1024 / 1024))
    print("out    : %s" % args.out)
    if args.dry_run:
        print("\ndry run - nothing written")
        return 0

    con, temp_path = create_asset(args.out)
    totals = build_provenance(con)
    write_metadata(con, totals)

    print("\nverifying against the master:")
    mismatched = verify(con)

    con.execute("DETACH DATABASE master")
    con.execute("DETACH DATABASE before")
    con.execute("VACUUM")
    con.commit()
    con.close()

    for suffix in ("-wal", "-shm"):
        if os.path.exists(temp_path + suffix):
            os.remove(temp_path + suffix)

    if os.path.exists(args.out):
        shutil.copy2(args.out, args.out + ".prev")
    os.replace(temp_path, args.out)

    print("\nwrote %s (%.1f MB)" % (args.out, os.path.getsize(args.out) / 1024 / 1024))
    if mismatched:
        print("WARNING: %d cells differ from the master" % mismatched)
        return 1
    print("asset matches the master in every one of the %d languages" % len(LANGS))
    return 0


if __name__ == "__main__":
    sys.exit(main())




