/// Third-party data bundled with the app, and the notices its licence requires.
///
/// Flutter already renders a licences screen — `showLicensePage` — which lists
/// every pub package automatically. Bundled **data** is not a package, so its
/// licence has to be added by hand or it never appears anywhere. That was the
/// state of the dictionary: `assets/data/dictionary.db` is derived from
/// CC-CEDICT, which is CC BY-SA 4.0 and requires attribution, and the string
/// "CEDICT" appeared only in internal code comments.
///
/// Registering here means the notice is visible to users in the app, in every
/// locale (the screen's own chrome comes from `GlobalMaterialLocalizations`,
/// so no new ARB key is needed), and it travels with the data rather than
/// living in a repository file the user never sees.
library;

import 'package:flutter/foundation.dart';

/// Identifies the dictionary in the licences list.
const String dictionaryDataPackageName = 'Dictionary data';

/// Identifies the bundled stroke/character-geometry data in the licences list.
///
/// `assets/data/hsk1_strokes.json`, `hsk1_animcjk.json` and
/// `hsk1_hanzivg.json` are third-party vector data with licences of their own
/// (the Arphic Public License and CC BY-SA 3.0). They are not part of the
/// dictionary, so they are registered under their own name rather than folded
/// into `dictionaryDataNotice` — otherwise the licences screen would imply the
/// dictionary's CC BY-SA notice already covered them, and it did not: these
/// files shipped with no notice at all until this was added.
const String hanziStrokeDataPackageName = 'Hanzi stroke data';

/// The attribution the dictionary's licences require, and the honest statement of
/// what the dictionary actually contains.
///
/// `assets/data/dictionary.db` is a **merge of many dictionaries**, not a copy of
/// one, and it is a **derived work**: CC-CEDICT supplies the headword spine, so the
/// dataset as a whole is shared under CC BY-SA 4.0. Two things therefore have to be
/// stated plainly rather than glossed over — which sources are in it, and which
/// values are machine-generated rather than human translations.
///
/// This notice also records what was *removed* and why. An earlier version of this
/// app shipped localised values from sources whose licences did not permit this use;
/// they are gone, and saying so is more honest than quietly dropping the names.
///
/// The same text is written into `dictionary_metadata` by
/// `tooling/build_dictionary_asset.py`, so the licence travels with the data file
/// itself and not only with this repository.
const String dictionaryDataNotice = '''
Dictionary data in this app is compiled from several dictionaries, and it is a
derived work: the Chinese headwords and the English definitions come from
CC-CEDICT, so the dataset as a whole is distributed under the same licence.

Chinese headwords, pinyin and English definitions:
 - CC-CEDICT (https://cc-cedict.org/), used under the Creative Commons
   Attribution-ShareAlike 4.0 International License (CC BY-SA 4.0) —
   https://creativecommons.org/licenses/by-sa/4.0/ — which supplies the
   headwords, pinyin and the English definitions. (The CC-CEDICT wiki states
   3.0; the MDBG export this app builds from states 4.0, and that export is the
   file actually used.)

Human-curated translations added from open dictionaries:
 - HanDeDict (Chinese-German), Creative Commons Attribution-ShareAlike 2.0 —
   https://creativecommons.org/licenses/by-sa/2.0/
 - WikDict / FreeDict, CC BY-SA 3.0
 - WOLF French WordNet, CeCILL-C
 - MultiWordNet and ItalWordNet, CC BY 3.0 and ODC-BY
 - The Open Multilingual Wordnet (https://github.com/omwn/omw-data), CC BY-SA 3.0
 - Thai WordNet (NECTEC)
 - kengdic (https://github.com/garfieldnate/kengdic), MPL 2.0 or LGPL 2.0+
 - Unihan, Unicode License v3, for the Vietnamese Hán-Việt readings of single
   characters. Note those are Sino-Vietnamese readings, not everyday words.

Translations matched from public knowledge bases:
 - Wikidata, whose structured data is CC0 (no rights reserved).
 - Wikipedia interlanguage links, CC BY-SA 4.0.

Machine translation — please read this part:
 - Most localised definitions in this app were produced by machine translation
   from the English definition. They are NOT human translations and can be
   wrong. Every machine-generated value is marked in the database
   (localized_definition_provenance, is_machine = 1) so the app can label it.

Sources removed from this app, and why:
 - An earlier version of this app shipped values from the "Multilingual Pleco
   Database", "Big BKRS", Facebook MUSE, PanLex, LiudmilaLV/json_hsk, Hindi
   WordNet, RuWordNet, Taiwan MOE and WenZi. Their licences either do not exist,
   do not permit commercial redistribution, or could not be established, so no
   value in this database comes from them. The Hindi and Russian columns were
   rebuilt from other sources as a result.

The bundled database is a MODIFIED, MERGED version of the sources above: it is
stored in SQLite with a custom schema, the sources were combined into one
headword list, definitions were added in 13 further languages, entries were
filtered and reordered, and each localised definition carries a provenance
record stating whether a licensed source or machine translation produced it.
CC BY-SA 4.0 requires attribution and that modifications be shared under the
same licence, and they are.

CC-CEDICT is a continuation of the CEDICT project started by Paul Andrew
Denisowski in October 1997. Thanks to the CC-CEDICT editor team, to the CEDICT,
HanDeDict and WikDict contributors, and to the WordNet projects.

The full inventory of sources is recorded in third_party/dictionary-sources.md,
and the attribution text ships as third_party/cc-cedict-LICENSE.
''';

/// The attribution the bundled stroke/character-geometry data requires.
///
/// Three separate projects supply it, under two licences that both *require*
/// the credit to travel with the files (the Arphic Public License is explicit:
/// the licence file must be retained unaltered in all copies). All three are
/// modified, reduced extracts rather than the original distributions, and the
/// Arphic licence additionally demands that a notice of modification be shown
/// and that the modifications be shared under the same licence — both of which
/// this states. `third_party/ARPHICPL.TXT` and the three per-source files are
/// declared as assets so the text genuinely ships with the app.
const String hanziStrokeDataNotice = '''
Stroke and character-geometry data in this app is compiled from three projects.

 - Make Me a Hanzi (https://github.com/skishore/makemeahanzi), distributed as
   "hanzi-writer-data" (https://github.com/chanind/hanzi-writer-data) — the
   stroke outlines and stroke medians in assets/data/hsk1_strokes.json. Used
   under the ARPHIC PUBLIC LICENSE, Copyright (C) 1999 Arphic Technology Co.,
   Ltd., which requires that the licence text be retained; it ships as
   third_party/ARPHICPL.TXT and is included on this screen.
 - AnimCJK (https://github.com/parsimonhi/animCJK) — the outlines and skeletons
   in assets/data/hsk1_animcjk.json, used under the ARPHIC PUBLIC LICENSE (its
   per-character SVG files). AnimCJK's other files are LGPL v3 or later; none of
   those are bundled here.
 - HanziVG (https://github.com/Connum/hanzivg) — the centre-line paths in
   assets/data/hsk1_hanzivg.json, used under the Creative Commons
   Attribution-ShareAlike 3.0 Unported License (CC BY-SA 3.0) —
   https://creativecommons.org/licenses/by-sa/3.0/. HanziVG builds on KanjiVG
   (https://kanjivg.tagaini.net/, also CC BY-SA 3.0) and on the AnimHanzi project
   by François Mizessyn.

MODIFICATIONS: in every case only the vector path data was kept. The SVG wrapper,
stroke numbers, element ids, clip-path definitions, and all non-geometry fields
(pinyin, decomposition, etymology) were discarded; the paths are stored as JSON
keyed by character instead of as .svg files; and only the HSK 1 character subset
is shipped. The Arphic Public License requires that such modifications be made
Freely Available as a whole under the same licence, and that is how they are
offered.

The per-source attribution files are third_party/ARPHICPL.TXT,
third_party/animcjk-LICENSE, third_party/hanzivg-LICENSE and
third_party/hanzi-writer-data-LICENSE; the full inventory is recorded in
third_party/dictionary-sources.md.
''';

/// Registers every bundled data licence. Call once, before `runApp`.
void registerThirdPartyNotices() {
  LicenseRegistry.addLicense(() async* {
    yield const LicenseEntryWithLineBreaks(
      <String>[dictionaryDataPackageName],
      dictionaryDataNotice,
    );
    yield const LicenseEntryWithLineBreaks(
      <String>[hanziStrokeDataPackageName],
      hanziStrokeDataNotice,
    );
  });
}
