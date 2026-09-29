"""Write the CC-CEDICT attribution INTO the database, so the licence travels with
the data rather than living only in the repository.

Run once; safe to re-run (the rows are upserted by key).
"""
import os
import sqlite3
import sys

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

PATH = os.path.join("assets", "data", "dictionary.db")

ROWS = [
    ("cc_cedict_attribution",
     "Chinese headwords, pinyin and English definitions from CC-CEDICT "
     "(https://cc-cedict.org/), used under the Creative Commons "
     "Attribution-ShareAlike 4.0 International License (CC BY-SA 4.0)."),
    ("cc_cedict_license", "CC BY-SA 4.0"),
    ("cc_cedict_license_url", "https://creativecommons.org/licenses/by-sa/4.0/"),
    ("cc_cedict_source_url", "https://cc-cedict.org/wiki/"),
    ("cc_cedict_source_export",
     "https://www.mdbg.net/chinese/export/cedict/cedict_1_0_ts_utf-8_mdbg.txt.gz"),
    ("cc_cedict_is_modified", "1"),
    ("cc_cedict_modifications",
     "Stored in SQLite with a custom schema; definitions translated into 13 "
     "further languages (words.definition_*); a quality score computed per "
     "localised definition (localized_definition_quality); entries filtered and "
     "rearranged. Full list: third_party/cc-cedict-LICENSE"),
    # --- corrected 2026-09-27: this file is a MERGE, not one dictionary ---
    ("dictionary_is_multisource", "1"),
    ("dictionary_sources_open",
     "CC-CEDICT (English, CC BY-SA 4.0); CFDICT (French); HanDeDict (German); "
     "WordNet-JA (Japanese); OpenWN-PT (Portuguese); ItalWordNet (Italian); "
     "Bahasa WordNet (Indonesian); WordNet MCR (Spanish); Arabic WordNet "
     "(Arabic); Han-Viet DB (Vietnamese); BKRS/Liudmila HSK (Russian). Source "
     "counts recorded in CHANGELOG.md builds 296-298."),
    ("dictionary_sources_unverified",
     "UNVERIFIED - LICENCE NOT ESTABLISHED, DO NOT ASSUME REDISTRIBUTABLE: "
     "(1) Facebook MUSE bilingual lexicon, used for Thai - VERIFIED CC BY-NC 4.0 "
     "(Attribution-NonCommercial), i.e. NON-COMMERCIAL and incompatible with "
     "selling the app; (2) 'Multilingual Pleco Database' (286,898 words, build "
     "298) - Pleco is a commercial product selling licensed publisher "
     "dictionaries; (3) 'Big BKRS' (300,000 words, build 298) - data from the "
     "bkrs.info dictionary website, which states no licence. See "
     "third_party/dictionary-sources.md."),
    ("dictionary_sources_unknown",
     "definition_hi holds 117,992 rows and NO build record names a Hindi source; "
     "at least one further source exists that is recorded nowhere in the "
     "repository."),
    ("dictionary_sources_inventory", "third_party/dictionary-sources.md"),
    ("dictionary_provenance_note",
     "Per-row provenance is NOT recorded; which headword came from which source "
     "cannot be determined from this file."),
]

con = sqlite3.connect(PATH)
print("before: %d metadata rows" % con.execute(
    "SELECT COUNT(*) FROM dictionary_metadata").fetchone()[0])

for key, value in ROWS:
    con.execute(
        "INSERT INTO dictionary_metadata (key, value) VALUES (?, ?) "
        "ON CONFLICT(key) DO UPDATE SET value = excluded.value",
        (key, value),
    )
con.commit()

print("after : %d metadata rows" % con.execute(
    "SELECT COUNT(*) FROM dictionary_metadata").fetchone()[0])
print()
for key, value in con.execute(
        "SELECT key, value FROM dictionary_metadata ORDER BY key"):
    print("   %-28s %s" % (key, value[:80]))

# Prove it reads back the way the app would read it.
found = con.execute(
    "SELECT value FROM dictionary_metadata WHERE key = 'cc_cedict_attribution'"
).fetchone()
print()
print("read back: %s" % (found[0] if found else "MISSING"))
con.close()
