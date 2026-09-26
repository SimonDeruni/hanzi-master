"""Prints the schema and a few sample rows of assets/data/dictionary.db.

Run from the repository root: python scratch/inspect_dictionary_db.py

Exists because the deck previews should read a word's meaning from storage
instead of hardcoding it, and we need to know what storage actually offers.
"""
import json
import sqlite3

DB = "assets/data/dictionary.db"

conn = sqlite3.connect(DB)
tables = conn.execute(
    "select name, sql from sqlite_master where type in ('table', 'view')"
).fetchall()
print("objects: %d" % len(tables))
for name, sql in tables:
    print("\n== %s" % name)
    print((sql or "")[:400].replace("\n", " "))
    try:
        count = conn.execute("select count(*) from %s" % name).fetchone()[0]
        print("rows: %d" % count)
        cols = [d[0] for d in conn.execute("select * from %s limit 1" % name).description]
        print("columns: %s" % ", ".join(cols))
        for row in conn.execute("select * from %s limit 2" % name):
            values = []
            for col, value in zip(cols, row):
                text = json.dumps(value, ensure_ascii=False) if not isinstance(value, str) else value
                values.append("%s=%s" % (col, text[:60]))
            print("  " + " | ".join(values))
    except Exception as error:  # noqa: BLE001 - diagnostic script
        print("  (could not read: %s)" % error)
