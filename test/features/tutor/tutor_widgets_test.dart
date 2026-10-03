/// The SHOW layer: four widgets, each built from data the app owns.
///
/// Two rules are asserted here, and they are what make a widget worth showing:
///
///  * **The parser checks before the learner sees it.** A grammar table whose
///    examples use characters this build cannot describe loses that row — or the
///    whole table — and a widget type this build does not have never reaches the view.
///  * **A builder returns `null` rather than a half-widget.** No strokes, no
///    examples, no table: the block simply is not there, which the reply view already
///    handles.
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/review_stats.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/tutor/data/tutor_envelope_parser.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_context.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_reply.dart';
import 'package:hanzi_master/features/tutor/presentation/widgets/tutor_artefacts.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

/// A card shaped like the library's: a real stroke path and a saved sentence.
Flashcard _card(String hanzi, {bool strokes = true}) => Flashcard(
      id: 'card-$hanzi',
      deckId: 'deck-1',
      hanzi: hanzi,
      pinyin: 'chá',
      definition: 'tea',
      sourceSentence: '我喝茶。',
      hskLevel: 1,
      strokePaths: strokes ? const <String>['M 0 0 L 10 10'] : const <String>[],
      medianPaths: strokes
          ? const <List<Offset>>[
              <Offset>[Offset(0, 0), Offset(10, 10)],
            ]
          : const <List<Offset>>[],
      modeStats: const <StudyMode, ReviewStats>{},
    );

/// One stroke of the bundled geometry, in the asset's own shape.
Map<String, dynamic> _bundledEntry() => <String, dynamic>{
      'strokes': <String>['M 100 100 L 900 900'],
      'medians': <dynamic>[
        <dynamic>[
          <dynamic>[100, 100],
          <dynamic>[900, 900],
        ],
      ],
    };

TutorArtefactData _data() => TutorArtefactData(
      cardsByHanzi: <String, Flashcard>{'茶': _card('茶')},
      metadata: <String, dynamic>{
        '茶': <String, dynamic>{
          'radical': '艹',
          'definition': 'tea',
          'pinyin': <String>['chá'],
          'decomposition': '艹 余',
        },
        '好': <String, dynamic>{
          'radical': '女',
          'definition': 'good',
          'pinyin': <String>['hǎo'],
        },
      },
      radicals: const <String, dynamic>{},
      hsk1Strokes: <String, dynamic>{'好': _bundledEntry()},
    );

/// The artefacts a reply is allowed to keep, given the data this build has.
List<TutorArtefact> _accepted(String json, TutorArtefactData data) {
  final TutorReply? reply = TutorEnvelopeParser.parse(
    json,
    context: const TutorContext(),
    allowedHanzi: data.describableHanzi,
  );
  return reply?.artefacts ?? const <TutorArtefact>[];
}

Future<BuildContext> _context(WidgetTester tester) async {
  late BuildContext captured;
  await tester.pumpWidget(MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Builder(builder: (BuildContext context) {
      captured = context;
      return const SizedBox.shrink();
    }),
  ));
  return captured;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('the parser checks a widget before the learner sees it', () {
    test('a stroke lesson it can draw is kept; one it cannot is dropped', () {
      final TutorArtefactData data = _data();
      expect(
        _accepted(
          '{"say":"s","artefacts":[{"type":"strokeOrder","args":{"hanzi":"好"}}]}',
          data,
        ).single.type,
        TutorArtefactType.strokeOrder,
        reason: '好 is not in the library, but the HSK 1 bundle can draw it',
      );
      // No metadata and no strokes: nothing to draw, so nothing is shown.
      expect(
        _accepted(
          '{"say":"s","artefacts":[{"type":"strokeOrder","args":{"hanzi":"鑫"}}]}',
          data,
        ),
        isEmpty,
      );
    });

    test('a grammar table is kept only while its examples check out', () {
      final TutorArtefactData data = _data();
      const String valid = '{"say":"s","artefacts":[{"type":"contrastTable",'
          '"args":{"title":"t","left":"茶","right":"好","rows":['
          '{"left":"茶","right":"好"},{"left":"茶茶","right":"好好"}]}}]}';
      final TutorArtefact table = _accepted(valid, data).single;
      expect(table.type, TutorArtefactType.contrastTable);
      expect(table.args['rows'], hasLength(2));

      // One row names a character the app cannot describe: that row goes and the
      // table stays, so the learner still gets the comparison that was checked.
      const String partly = '{"say":"s","artefacts":[{"type":"contrastTable",'
          '"args":{"title":"t","left":"茶","right":"好","rows":['
          '{"left":"茶","right":"好"},{"left":"鑫","right":"好"}]}}]}';
      expect(_accepted(partly, data).single.args['rows'], hasLength(1));

      // Every row fails, so the table fails: an unbacked comparison is not shown.
      expect(
        _accepted(
          '{"say":"s","artefacts":[{"type":"contrastTable","args":{"title":"t",'
          '"left":"茶","right":"好","rows":[{"left":"鑫","right":"鑫"}]}}]}',
          data,
        ),
        isEmpty,
      );
    });

    test('a table cannot grow into a wall of text', () {
      final TutorArtefactData data = _data();
      final String rows =
          List<String>.filled(9, '{"left":"茶","right":"好"}').join(',');
      expect(
        _accepted(
          '{"say":"s","artefacts":[{"type":"contrastTable","args":{"title":"t",'
          '"left":"茶","right":"好","rows":[$rows]}}]}',
          data,
        ).single.args['rows'],
        hasLength(4),
        reason: 'four rows is two examples a side, and no more',
      );
    });
    test('a widget this build does not have is dropped, not rendered', () {
      // A tone graph is in the concept doc's catalogue but deliberately not built:
      // the app's tone graph measures a *recording*, so a reply cannot ask for one.
      final TutorArtefactData data = _data();
      expect(
        _accepted(
          '{"say":"s","artefacts":[{"type":"toneGraph","args":{"hanzi":"茶"}}]}',
          data,
        ),
        isEmpty,
      );
    });
  });

  group('a widget is built from the app\'s own data, or not at all', () {
    testWidgets('stroke order works without the character being in the deck',
        (WidgetTester tester) async {
      final BuildContext context = await _context(tester);
      final TutorArtefactData data = _data();

      expect(
        TutorArtefactRegistry.build(
          context,
          artefact: const TutorArtefact(
            TutorArtefactType.strokeOrder,
            <String, Object?>{'hanzi': '好'},
          ),
          data: data,
          isDark: false,
        ),
        isNotNull,
        reason: 'the bundled HSK 1 outlines are a real lesson',
      );
      // A character in neither the deck nor the bundle: no widget, no spinner.
      expect(
        TutorArtefactRegistry.build(
          context,
          artefact: const TutorArtefact(
            TutorArtefactType.strokeOrder,
            <String, Object?>{'hanzi': '鑫'},
          ),
          data: data,
          isDark: false,
        ),
        isNull,
      );
    });

    testWidgets('examples come from the learner\'s own card',
        (WidgetTester tester) async {
      final BuildContext context = await _context(tester);
      expect(
        TutorArtefactRegistry.build(
          context,
          artefact: const TutorArtefact(
            TutorArtefactType.exampleSet,
            <String, Object?>{'hanzi': '茶'},
          ),
          data: _data(),
          isDark: false,
        ),
        isNotNull,
      );
      // No card and no catalogue entry: no example and no definition exist, so no
      // block is drawn — even though the app could describe plenty of others.
      expect(
        TutorArtefactRegistry.build(
          context,
          artefact: const TutorArtefact(
            TutorArtefactType.exampleSet,
            <String, Object?>{'hanzi': '鑫'},
          ),
          data: _data(),
          isDark: false,
        ),
        isNull,
      );
    });

    testWidgets('a checked table renders, an empty one does not',
        (WidgetTester tester) async {
      final BuildContext context = await _context(tester);
      expect(
        TutorArtefactRegistry.build(
          context,
          artefact: const TutorArtefact(
            TutorArtefactType.contrastTable,
            <String, Object?>{
              'title': 't',
              'left': '茶',
              'right': '好',
              'rows': <Object?>[
                <String, Object?>{'left': '茶', 'right': '好'},
              ],
            },
          ),
          data: _data(),
          isDark: false,
        ),
        isNotNull,
      );
      expect(
        TutorArtefactRegistry.build(
          context,
          artefact: const TutorArtefact(
            TutorArtefactType.contrastTable,
            <String, Object?>{'title': 't', 'left': '茶', 'right': '好'},
          ),
          data: _data(),
          isDark: false,
        ),
        isNull,
      );
    });
  });

  group('the app spells, or says nothing', () {
    test('a reading comes from the catalogue, and never from a guess', () {
      final TutorArtefactData data = _data();
      expect(TutorArtefactRegistry.spellingOf('茶', data), 'chá');
      expect(TutorArtefactRegistry.spellingOf('鑫', data), '',
          reason: 'no reading is better than an invented one');
      expect(data.describableHanzi, contains('好'),
          reason: 'the HSK 1 stroke bundle counts as describable');
    });
  });
}
