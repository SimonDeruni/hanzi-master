import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/legal/third_party_notices.dart';

/// The bundled dictionary is a **merge of many dictionaries**, and the ones that
/// are open source require attribution. It shipped with the string "CEDICT"
/// appearing only in internal code comments, so these tests keep the credit from
/// quietly disappearing again — in the app, in the licence files, and inside the
/// database itself.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('the dictionary notice is registered with the licences screen', () async {
    registerThirdPartyNotices();

    final entries = await LicenseRegistry.licenses
        .where((license) => license.packages.contains(dictionaryDataPackageName))
        .toList();

    expect(entries, isNotEmpty,
        reason: 'the dictionary data must appear on the licences screen');
    final text = entries.first.paragraphs
        .map((paragraph) => paragraph.text)
        .join('\n');
    // Attribution is not just a licence name: the licence requires saying where
    // the data came from, and the notice must not name only one source when the
    // file is a merge.
    expect(text, contains('CC-CEDICT'));
    expect(text, contains('https://cc-cedict.org/'));
    expect(text, contains('CC BY-SA 4.0'));
    expect(text, contains('HanDeDict'));
    // CFDICT supplied the French column of an earlier build and is gone: its own
    // project never stated a licence. It must not be credited as a source, and the
    // notice must say the removed sources were removed rather than silently
    // dropping the names.
    expect(text, isNot(contains('CFDICT')),
        reason: 'a source rejected in the licence audit must not be credited');
    expect(text, contains('Pleco'),
        reason: 'the notice must record what was removed, not just what remains');
    // Most localised values in this build are machine output. CC BY-SA asks a
    // modifier to say what it changed, and honesty asks for the rest.
    expect(text, contains('machine translation'));
    expect(text, contains('localized_definition_provenance'));
    // Share-alike only bites because the file is a modified, merged version.
    expect(text.toLowerCase(), contains('modified'));
    expect(text.toLowerCase(), contains('merged'));
  });

  test('the dictionary source inventory exists and lists every source', () {
    final inventory = File('third_party/dictionary-sources.md');
    expect(inventory.existsSync(), isTrue,
        reason: 'the multi-source inventory must ship with the repo');

    final text = inventory.readAsStringSync();
    for (final source in <String>[
      'CC-CEDICT',
      'CFDICT',
      'HanDeDict',
      'Pleco',
      'BKRS',
      'WordNet',
    ]) {
      expect(text, contains(source), reason: '$source is missing from the inventory');
    }
    // The two sources whose licence is not established must be flagged as such,
    // not quietly listed as open source.
    final lower = text.toLowerCase();
    expect(lower, contains('unverified'));
    expect(lower, contains('not known to be redistributable'));
  });

  test('the CC-CEDICT licence file states the attribution and the licence', () {
    final file = File('third_party/cc-cedict-LICENSE');
    expect(file.existsSync(), isTrue,
        reason: 'the bundled third-party licence must ship with the repo');

    final text = file.readAsStringSync();
    expect(text, contains('CC-CEDICT'));
    expect(text, contains('CC BY-SA 4.0'));
    expect(text, contains('https://cc-cedict.org/'));
    expect(text, contains('https://creativecommons.org/licenses/by-sa/4.0/'));
    expect(text.toLowerCase(), contains('share-alike'));
  });

  test('the shipped database carries its own licence notice', () {
    final file = File('assets/data/dictionary.db');
    expect(file.existsSync(), isTrue);

    // The notice must travel *with the data*, not only with the repository: if
    // someone extracts this file, nothing else tells them where it came from, and
    // nothing tells them which values are machine-generated. Scanned in chunks
    // because the file is well over 100 MB and must not be held in memory.
    final needles = <String>[
      'CC BY-SA 4.0',                    // the licence the derived work is shared under
      'cc-cedict.org',                   // the headword spine and English glosses
      'translation_is_machine',          // the machine-translation disclosure
      'localized_definition_provenance', // where per-value provenance is recorded
    ];
    final missing = _missingNeedles(file, needles.map(utf8.encode).toList());

    expect(missing, isEmpty,
        reason: 'dictionary_metadata is missing: '
            '${missing.map((index) => needles[index]).join(', ')}');
  });

  test('the bundled stroke-data notice is registered with the licences screen',
      () async {
    registerThirdPartyNotices();

    final entries = await LicenseRegistry.licenses
        .where((license) =>
            license.packages.contains(hanziStrokeDataPackageName))
        .toList();

    expect(entries, isNotEmpty,
        reason: 'the stroke/geometry data must appear on the licences screen');
    final text = entries.first.paragraphs
        .map((paragraph) => paragraph.text)
        .join('\n');
    // All three projects, both licences, and the modification statement the
    // Arphic Public License demands. These shipped with no notice at all before
    // this was added, so the test keeps them from disappearing again.
    expect(text, contains('Make Me a Hanzi'));
    expect(text, contains('AnimCJK'));
    expect(text, contains('HanziVG'));
    expect(text, contains('ARPHIC PUBLIC LICENSE'));
    expect(text, contains('CC BY-SA 3.0'));
    expect(text, contains('https://github.com/Connum/hanzivg'));
    expect(text.toUpperCase(), contains('MODIFICATIONS'));
  });

  test('the Arphic Public License ships unaltered with the app', () {
    // Section 1 requires "this license file (ARPHICPL.TXT) unaltered in all
    // copies", so the licence text itself is the compliance artefact — not a
    // summary of it.
    final file = File('third_party/ARPHICPL.TXT');
    expect(file.existsSync(), isTrue,
        reason: 'the Arphic licence file must travel with the data');

    final text = file.readAsStringSync();
    expect(text, contains('ARPHIC PUBLIC LICENSE'));
    expect(text, contains('Copyright (C) 1999 Arphic Technology Co., Ltd.'));
    expect(text, contains('retain this license file (ARPHICPL.TXT) unaltered'));
    // Section 2(b): modified data must be made Freely Available under the same
    // licence, which is what the per-source notices claim.
    expect(text, contains('Freely Available'));
  });

  test('each bundled dataset licence file names its source and its licence', () {
    const licences = <String, List<String>>{
      'third_party/animcjk-LICENSE': <String>[
        'AnimCJK',
        'Arphic Public License',
        'https://github.com/parsimonhi/animCJK',
      ],
      'third_party/hanzivg-LICENSE': <String>[
        'HanziVG',
        'CC BY-SA 3.0',
        'https://github.com/Connum/hanzivg',
      ],
      'third_party/hanzi-writer-data-LICENSE': <String>[
        'Make Me a Hanzi',
        'Arphic Public License',
        'https://github.com/skishore/makemeahanzi',
      ],
    };

    for (final entry in licences.entries) {
      final file = File(entry.key);
      expect(file.existsSync(), isTrue, reason: '${entry.key} must ship');
      final text = file.readAsStringSync();
      for (final needle in entry.value) {
        expect(text, contains(needle),
            reason: '${entry.key} must state "$needle"');
      }
    }
  });

  test('the bundled licence files are declared as assets so they reach users',
      () {
    // A licence file that only exists in the repository never reaches the user,
    // which is exactly the failure this whole audit found.
    final pubspec = File('pubspec.yaml').readAsStringSync();
    for (final path in <String>[
      'third_party/ARPHICPL.TXT',
      'third_party/animcjk-LICENSE',
      'third_party/hanzivg-LICENSE',
      'third_party/hanzi-writer-data-LICENSE',
    ]) {
      expect(pubspec, contains(path),
          reason: '$path must be declared under flutter: assets:');
    }
  });
}

/// Scans [file] once in chunks and returns the indexes of [needles] it did not find.
///
/// One pass rather than one pass per needle, because the dictionary asset is large
/// and re-reading it per assertion would make the test needlessly slow.
List<int> _missingNeedles(File file, List<List<int>> needles) {
  const chunkSize = 4 * 1024 * 1024;
  final found = List<bool>.filled(needles.length, false);
  final windowSize = needles.fold<int>(
      1, (widest, needle) => needle.length > widest ? needle.length : widest);
  var remaining = needles.length;

  final handle = file.openSync();
  try {
    var tail = <int>[];
    while (remaining > 0) {
      final chunk = handle.readSync(chunkSize);
      if (chunk.isEmpty) break;
      final window = <int>[...tail, ...chunk];
      for (var index = 0; index < needles.length; index++) {
        if (!found[index] && _contains(window, needles[index])) {
          found[index] = true;
          remaining--;
        }
      }
      tail = window.length <= windowSize
          ? window
          : window.sublist(window.length - windowSize);
    }
  } finally {
    handle.closeSync();
  }

  return <int>[
    for (var index = 0; index < needles.length; index++)
      if (!found[index]) index,
  ];
}

bool _contains(List<int> haystack, List<int> needle) {
  if (needle.isEmpty || haystack.length < needle.length) return false;
  for (var start = 0; start <= haystack.length - needle.length; start++) {
    var matched = true;
    for (var offset = 0; offset < needle.length; offset++) {
      if (haystack[start + offset] != needle[offset]) {
        matched = false;
        break;
      }
    }
    if (matched) return true;
  }
  return false;
}
