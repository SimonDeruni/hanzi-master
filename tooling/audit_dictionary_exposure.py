"""How much of the shipped dictionary is affected by sources we cannot confirm?

Method and its limits, stated up front:

  * There is NO per-row provenance in the database, so nothing here can be exact
    for a MIXED column. Each language is reported as a floor (values behind a
    licence that was actually read and confirmed) and a ceiling (values behind an
    ingest whose licence is unestablished), never as one precise figure.

  * The build records report **column totals at that build**, not increments
    (e.g. "#298 Russian 124,268 = 99.4%" is 124,268/125,009). So where a column's
    shipped count EQUALS a recorded total, that column's provenance is that
    build's ingest and nothing else - the strongest statement the data supports.

  * Where a shipped count EXCEEDS every recorded total, something undocumented was
    added afterwards. That gap is reported: it is itself a finding.

Tiers: A = licence read and confirmed commercial-OK; B = unverified but plausibly
licensable (open dictionary / WordNet family); C = unestablished or NonCommercial.
"""
import sqlite3
import sys

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

WORDS = 125009

# Recorded per-language totals from the repository's own build records.
RECORDED = {
    "ar": [("#297", 6678), ("#298", 6678)],
    "de": [("#297", 99124), ("#298", 63865)],
    "es": [("#297", 10561), ("#298", 96976)],
    "fr": [("#297", 73557), ("#298", 102057)],
    "id": [("#297", 12341), ("#298", 12341), ("#299", 30272)],
    "it": [("#297", 12594), ("#298", 12594), ("#299", 15670)],
    "ja": [("#297", 14508), ("#298", 97256)],
    "ko": [("#298", 96777)],
    "pt": [("#297", 13054), ("#298", 13054), ("#299", 16265)],
    "ru": [("#297", 5293), ("#298", 124268)],
    "th": [("#301", 89754)],
    "vi": [("#297", 12250), ("#298", 99084)],
    "hi": [],  # nothing recorded, ever
}

# What each column was populated from.
SOURCES = {
    "ar": [("Arabic WordNet", "B"), ("Pleco", "C")],
    "de": [("HanDeDict", "B"), ("Pleco", "C")],
    "es": [("WordNet MCR", "B"), ("Pleco", "C")],
    "fr": [("CFDICT", "B"), ("Pleco", "C")],
    "hi": [("UNKNOWN - no source recorded", "C")],
    "id": [("Bahasa WordNet", "B"), ("FreeDict+WikDict TEI", "A"), ("Pleco", "C")],
    "it": [("ItalWordNet", "B"), ("WikDict zho-ita", "A"), ("Pleco", "C")],
    "ja": [("WordNet-JA", "B"), ("Pleco", "C")],
    "ko": [("Pleco", "C")],
    "pt": [("OpenWN-PT", "A"), ("WikDict zho-por", "A"), ("Pleco", "C")],
    "ru": [("BKRS / Liudmila HSK", "B"), ("Pleco + Big BKRS", "C")],
    "th": [("OMW NECTEC", "B"), ("PanLex", "C"), ("Facebook MUSE", "C")],
    "vi": [("Han-Viet DB", "B"), ("Pleco", "C")],
}

# Values behind a licence that was read and permits commercial use.
CONFIRMED_SAFE = {"pt": 13054 + 16265, "id": 82903, "it": 15670}
# Thai's #301 build (OMW + PanLex + MUSE). VERIFIED 2026-09-27: TWO of the three
# are NonCommercial - MUSE is CC BY-NC 4.0 and PanLex is CC BY-NC-SA 4.0 (the
# earlier note here, inherited from dictionary-sources.md, assumed PanLex was
# CC0 and that was wrong). So the whole growth is NC-tainted unless OMW alone
# accounts for it, and the split is not recorded anywhere.
MUSE_FROM = 14552

# Columns whose matching build was populated ENTIRELY from an unestablished
# ingest, so the whole column is exposed. Thai is deliberately NOT here: its
# #301 ingest mixed OMW and PanLex (plausibly fine) with MUSE, so only part of
# that column can be blamed on the NonCommercial source.
WHOLLY_EXPOSED = {"ru", "fr", "vi", "ja", "es", "ko"}


def measure():
    """Shipped counts per column, straight from the database."""
    con = sqlite3.connect("assets/data/dictionary.db")
    live = {}
    for code in RECORDED:
        column = "definition_" + code
        live[code] = con.execute(
            "SELECT COUNT(*) FROM words WHERE %s IS NOT NULL AND TRIM(%s) <> ''"
            % (column, column)).fetchone()[0]
    english = con.execute(
        "SELECT COUNT(*) FROM words WHERE definition IS NOT NULL "
        "AND TRIM(definition) <> ''").fetchone()[0]
    quality = con.execute(
        "SELECT COUNT(*) FROM localized_definition_quality").fetchone()[0]
    con.close()
    return live, english, quality


def report():
    live, english, quality = measure()
    print("headwords                                   : %d" % WORDS)
    print("English values (CC-CEDICT, confirmed)       : %d" % english)
    print("localised values                            : %d"
          % sum(live.values()))
    print("quality-table rows (independent cross-check): %d" % quality)
    print()

    header = ("%-4s %8s %8s %9s %11s  %s"
              % ("lang", "rows", "cover", "explained", "unexplained", "behind it"))
    print(header)
    print("-" * 98)

    wholly = {}
    mixed = {}
    for code in sorted(RECORDED):
        rows = live[code]
        totals = {n for _b, n in RECORDED[code]}
        best = max(totals, default=0)
        exact = rows in totals
        explained = rows if exact else best
        unexplained = rows - explained
        tiers = {t for _s, t in SOURCES[code]}

        # A column is wholly exposed only when the build that produced its exact
        # shipped count was populated entirely from an unestablished ingest.
        if code in WHOLLY_EXPOSED and exact:
            wholly[code] = rows
        else:
            mixed[code] = rows

        print("%-4s %8d %7.1f%% %9d %11d  %s"
              % (code, rows, 100.0 * rows / WORDS, explained, unexplained,
                 ", ".join("%s(%s)" % (s[:24], t) for s, t in SOURCES[code])))

    print("-" * 98)
    print()
    print("WHOLLY EXPOSED - shipped count equals an unestablished ingest's total:")
    for code, rows in sorted(wholly.items(), key=lambda kv: -kv[1]):
        print("   %-3s %7d values  = %5.1f%% of all words"
              % (code, rows, 100.0 * rows / WORDS))
    print("   TOTAL %d values" % sum(wholly.values()))
    print()
    print("MIXED - a confirmed or plausible source contributed as well:")
    for code, rows in sorted(mixed.items(), key=lambda kv: -kv[1]):
        confident = CONFIRMED_SAFE.get(code, 0)
        print("   %-3s %7d values  (of which %d behind a confirmed licence)"
              % (code, rows, confident))
    print("   TOTAL %d values" % sum(mixed.values()))
    print()

    total = english + sum(live.values())
    safe = english + sum(CONFIRMED_SAFE.values())
    print("of %d definition values that ship:" % total)
    print("   %8d (%.0f%%) behind a licence read and confirmed commercial-OK"
          % (safe, 100.0 * safe / total))
    print("   %8d (%.0f%%) behind a source whose licence is unestablished"
          % (total - safe, 100.0 * (total - safe) / total))
    print()
    print("NonCommercial exposure (Thai column): up to %d values"
          % (live["th"] - MUSE_FROM))
    print("   Thai held %d before build #301 and %d after. Build #301 names OMW"
          % (MUSE_FROM, live["th"]))
    print("   (permissive) but ALSO PanLex (CC BY-NC-SA 4.0, verified 2026-09-27)")
    print("   and Facebook MUSE (CC BY-NC 4.0) - TWO NonCommercial sources, and")
    print("   their split is not recorded, so the whole expansion is NC-tainted")
    print("   unless OMW alone accounts for it.")
    print()
    print("words affected - headwords carrying a definition in each wholly")
    print("exposed language, i.e. how many lose one if the column is rebuilt:")
    for code, rows in sorted(wholly.items(), key=lambda kv: -kv[1]):
        print("   %-3s %7d of %d words (%5.1f%%)"
              % (code, rows, WORDS, 100.0 * rows / WORDS))
    return 0


if __name__ == "__main__":
    sys.exit(report())
