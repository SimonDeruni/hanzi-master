/// The tutor's contract, in executable form.
///
/// `docs/AI_TUTOR_CONCEPT.md` makes three promises that are only worth anything if
/// they are enforced in code, and this file is where they are:
///
///  1. **An artefact may only be built from data the app owns** — a widget for a
///     character outside the supplied set is *rejected*, not rendered blank.
///  2. **A citation may only point at something the learner has** — an invented
///     deck, book or video id cannot resolve and is dropped.
///  3. **A `make` may only reference a real deck**, with its item count clamped to
///     what that deck holds, and it is always a proposal.
///
/// Plus the fallback: with no model at all, the local composer still answers in
/// the same envelope — which is what makes the feature usable offline.
library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/tutor/data/tutor_envelope_parser.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_context.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_reply.dart';
import 'package:hanzi_master/features/tutor/domain/logic/local_tutor.dart';
import 'package:hanzi_master/features/tutor/presentation/widgets/tutor_artefacts.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

const TutorContext _context = TutorContext(
  interfaceLanguage: 'en',
  decks: <TutorDeckSummary>[
    TutorDeckSummary(
      id: 'hsk3',
      name: 'HSK 3',
      cardCount: 24,
      dueCount: 9,
      sampleHanzi: <String>['好', '女', '子'],
    ),
  ],
);

TutorReply? _parse(
  String raw, {
  Set<String>? allowedHanzi,
  Map<TutorCiteSource, Set<String>> allowedIds = const {},
}) =>
    TutorEnvelopeParser.parse(
      raw,
      context: _context,
      allowedHanzi: allowedHanzi,
      allowedExternalIds: allowedIds,
    );

void main() {
  group('the envelope', () {
    test('parses every block kind', () {
      final TutorReply? reply = _parse('''
        {
          "say": "好 is 女 + 子.",
          "artefacts": [{"type":"characterAnatomy","args":{"hanzi":"好"}},
                        {"type":"strokeOrder","args":{"hanzi":"好"}}],
          "cites": [{"source":"deck","id":"hsk3","note":"9 due today"}],
          "make": [{"kind":"examFolder","deckId":"hsk3","items":12}],
          "ask": null
        }
      ''', allowedHanzi: const {'好'});

      expect(reply, isNotNull);
      expect(reply!.say, '好 is 女 + 子.');
      expect(reply.artefacts.length, 2);
      expect(reply.cites.single.source, TutorCiteSource.deck);
      expect(reply.makes.single.items, 12);
      expect(reply.fromModel, isTrue);
    });

    test('reads through a markdown fence', () {
      final TutorReply? reply = _parse(
        'Sure!\n```json\n{"say":"ok"}\n```',
      );
      expect(reply?.say, 'ok');
    });

    test('an unknown widget is dropped and the rest survives', () {
      final TutorReply? reply = _parse(
        '{"say":"hi","artefacts":[{"type":"toneCurve","args":{"hanzi":"好"}},'
        '{"type":"strokeOrder","args":{"hanzi":"好"}}]}',
        allowedHanzi: const {'好'},
      );
      expect(reply!.artefacts.length, 1);
      expect(reply.artefacts.single.type, TutorArtefactType.strokeOrder);
    });

    test('a character the app cannot build is refused (§4.3)', () {
      final TutorReply? reply = _parse(
        '{"say":"here","artefacts":[{"type":"strokeOrder","args":{"hanzi":"龘"}}]}',
        allowedHanzi: const {'好'},
      );
      expect(reply, isNotNull);
      expect(reply!.artefacts, isEmpty,
          reason:
              'A stroke lesson for a character we cannot draw must not render');
    });

    test('a multi-character "hanzi" argument is refused', () {
      final TutorReply? reply = _parse(
        '{"say":"two of them","artefacts":'
        '[{"type":"strokeOrder","args":{"hanzi":"你好"}}]}',
        allowedHanzi: const {'你', '好'},
      );
      expect(reply, isNotNull);
      expect(reply!.artefacts, isEmpty,
          reason:
              'A widget per character: a two-character argument is ambiguous');
    });

    test('an invented citation cannot resolve (§12.2)', () {
      final TutorReply? reply = _parse(
        '{"say":"see this","cites":[{"source":"deck","id":"ghost"},'
        '{"source":"video","id":"invented"},'
        '{"source":"deck","id":"hsk3"}]}',
      );
      expect(reply!.cites.length, 1);
      expect(reply.cites.single.id, 'hsk3');
    });

    test('a citation the caller supplied is allowed', () {
      final TutorReply? reply = _parse(
        '{"cites":[{"source":"video","id":"abc123","why":"slow tones"}]}',
        allowedIds: const <TutorCiteSource, Set<String>>{
          TutorCiteSource.video: <String>{'abc123'},
        },
      );
      expect(reply!.cites.single.why, 'slow tones');
    });

    test('a make is refused for a deck that does not exist', () {
      final TutorReply? reply = _parse(
          '{"make":[{"kind":"examFolder","deckId":"ghost","items":10}]}');
      expect(reply, isNull,
          reason: 'Nothing survives, so the caller falls back');
    });

    test('a make is clamped to the deck and to a sane ceiling', () {
      final TutorReply? big = _parse(
          '{"make":[{"kind":"examFolder","deckId":"hsk3","items":500}]}');
      expect(big!.makes.single.items, 24,
          reason: 'Never more than the deck holds');

      final TutorReply? zero =
          _parse('{"make":[{"kind":"examFolder","deckId":"hsk3","items":0}]}');
      expect(zero!.makes.single.items, 1);
    });

    test('an ask is read with its options', () {
      final TutorReply? reply = _parse(
        '{"ask":{"question":"Which deck?","options":[{"label":"HSK 3","value":"hsk3"}]}}',
      );
      expect(reply!.ask!.options.single.value, 'hsk3');
    });

    test('garbage yields nothing rather than a blank bubble', () {
      expect(_parse('I cannot help with that.'), isNull);
      expect(_parse(''), isNull);
      expect(_parse('{"say":"  "}'), isNull);
    });
  });

  group('the model-free answer', () {
    // The local composer writes in the learner's language, so it is handed the
    // localizations exactly as the screen hands them over.
    final AppLocalizations enL10n = lookupAppLocalizations(const Locale('en'));

    const TutorContext twoDecks = TutorContext(
      decks: <TutorDeckSummary>[
        TutorDeckSummary(id: 'hsk3', name: 'HSK 3', cardCount: 24, dueCount: 0),
        TutorDeckSummary(
            id: 'tones', name: 'Tones', cardCount: 12, dueCount: 0),
      ],
    );

    test('an exam request with a referenced deck builds a paper from it', () {
      final TutorReply reply = LocalTutor.compose(
        message: 'make me an exam on this deck',
        l10n: enL10n,
        context: const TutorContext(
          decks: <TutorDeckSummary>[
            TutorDeckSummary(
                id: 'hsk3', name: 'HSK 3', cardCount: 24, dueCount: 0),
          ],
          references: <TutorReference>[
            TutorReference(
                kind: TutorReferenceKind.deck, id: 'hsk3', label: 'HSK 3'),
          ],
        ),
      );

      expect(reply.makes.single.kind, TutorMakeKind.examPaper,
          reason: 'an exam from the deck the learner picked, not a copy of its '
              'cards');
      expect(reply.makes.single.deckId, 'hsk3');
      expect(reply.makes.single.items, 24, reason: 'the paper covers the deck');
      expect(reply.fromModel, isFalse,
          reason: 'The UI must be able to say this came from local data');
    });

    test('an ambiguous exam request asks instead of guessing', () {
      final TutorReply reply = LocalTutor.compose(
        message: 'build a quiz',
        context: twoDecks,
        l10n: enL10n,
      );

      expect(reply.makes, isEmpty);
      expect(reply.ask!.options.length, 2);
      expect(reply.ask!.options.first.value, 'hsk3');
    });

    test('a small deck is capped at what it holds', () {
      final TutorReply reply = LocalTutor.compose(
        message: 'test me',
        l10n: enL10n,
        context: const TutorContext(
          decks: <TutorDeckSummary>[
            TutorDeckSummary(
                id: 'tiny', name: 'Tiny', cardCount: 6, dueCount: 0),
          ],
        ),
      );
      expect(reply.makes.single.items, 6);
    });

    test('a character in the message becomes anatomy plus stroke order', () {
      final TutorReply reply = LocalTutor.compose(
        message: 'explain 好',
        context: _context,
        l10n: enL10n,
      );

      expect(reply.artefacts.length, 2);
      expect(reply.artefacts.first.type, TutorArtefactType.characterAnatomy);
      expect(reply.artefacts.last.type, TutorArtefactType.strokeOrder);
      expect(reply.artefacts.first.hanzi, '好');
    });

    test('a request it cannot answer says what it can do', () {
      final TutorReply reply = LocalTutor.compose(
        message: 'hello there',
        context: _context,
        l10n: enL10n,
      );

      expect(reply.say, isNotNull);
      expect(reply.artefacts, isEmpty);
      expect(reply.makes, isEmpty);
      expect(reply.isEmpty, isFalse);
    });

    test('the exam keyword is recognised beyond English', () {
      expect(LocalTutor.looksLikeExamRequest('make an exam'), isTrue);
      expect(LocalTutor.looksLikeExamRequest('fais un examen'), isTrue);
      expect(LocalTutor.looksLikeExamRequest('考试'), isTrue);
      expect(LocalTutor.looksLikeExamRequest('tell me about 好'), isFalse);
    });
  });

  group('the artefact builders', () {
    Flashcard card(String hanzi, {bool withStrokes = true}) => Flashcard(
          id: 'card-$hanzi',
          deckId: 'hsk3',
          hanzi: hanzi,
          pinyin: 'hao3',
          definition: 'good',
          hskLevel: 1,
          strokePaths:
              withStrokes ? const <String>['M0 0 L1 1'] : const <String>[],
          modeStats: const {},
        );

    testWidgets('drop a block they cannot build, and build the ones they can',
        (WidgetTester tester) async {
      late BuildContext context;
      await tester.pumpWidget(MaterialApp(
        home: Builder(builder: (BuildContext inner) {
          context = inner;
          return const SizedBox.shrink();
        }),
      ));

      const TutorArtefactData empty = TutorArtefactData();
      expect(
        TutorArtefactRegistry.build(
          context,
          artefact: const TutorArtefact(
              TutorArtefactType.strokeOrder, <String, Object?>{'hanzi': '好'}),
          data: empty,
          isDark: false,
        ),
        isNull,
        reason: 'No strokes for that character means no stroke lesson',
      );

      final TutorArtefactData withCard = TutorArtefactData(
        cardsByHanzi: <String, Flashcard>{'好': card('好')},
      );
      expect(
        TutorArtefactRegistry.build(
          context,
          artefact: const TutorArtefact(
              TutorArtefactType.strokeOrder, <String, Object?>{'hanzi': '好'}),
          data: withCard,
          isDark: false,
        ),
        isNotNull,
      );

      expect(
        TutorArtefactRegistry.build(
          context,
          artefact: const TutorArtefact(TutorArtefactType.characterAnatomy,
              <String, Object?>{'hanzi': '好'}),
          data: withCard,
          isDark: false,
        ),
        isNull,
        reason: 'Anatomy needs the bundled metadata, which this bundle lacks',
      );
    });

    test('the anatomy uses the metadata radical and its components', () {
      const TutorArtefactData data = TutorArtefactData(
        metadata: <String, dynamic>{
          '好': <String, dynamic>{
            'radical': '女',
            'definition': 'good',
            'decomposition': '⿰女子',
          },
          '女': <String, dynamic>{'radical': '女', 'definition': 'woman'},
          '子': <String, dynamic>{'radical': '子', 'definition': 'child'},
        },
        radicals: <String, dynamic>{
          '女': <String, dynamic>{'name': 'Woman', 'meaning': 'A woman.'},
        },
      );

      // 女 (the assigned radical) then 子 (from the decomposition) — the IDS
      // marker ⿰ is not a component.
      expect(TutorArtefactRegistry.componentsOf('好', data).length, 2);

      // The same metadata-first rule as the character sheet: the catalogue is an
      // enrichment, not the assignment table.
      expect(TutorArtefactRegistry.componentsOf('好', const TutorArtefactData()),
          isEmpty);

      expect(data.describableHanzi, containsAll(<String>['好', '女', '子']));
    });
  });

  group('citing a video', () {
    const Map<TutorCiteSource, Set<String>> allowed =
        <TutorCiteSource, Set<String>>{
      TutorCiteSource.video: <String>{'abc123'},
    };

    test('survives when it is an id the app itself fetched', () {
      final TutorReply? reply = _parse(
        '{"say":"Watch this one.","cites":[{"source":"video","id":"abc123",'
        '"why":"A short demonstration"}]}',
        allowedIds: allowed,
      );

      expect(reply!.cites.single.source, TutorCiteSource.video);
      expect(reply.cites.single.id, 'abc123');
      expect(reply.cites.single.why, 'A short demonstration');
    });

    test('an invented video id is dropped and the prose survives', () {
      final TutorReply? reply = _parse(
        '{"say":"Watch this one.","cites":[{"source":"video","id":"invented"}]}',
        allowedIds: allowed,
      );

      expect(reply!.cites, isEmpty);
      expect(reply.say, 'Watch this one.');
    });
  });

  /// A chip that says "Open in YouTube" has to open YouTube. It used to be drawn
  /// with a play glyph and then ignore every tap, because the screen never handed
  /// the model any video ids to cite in the first place.
  group('the video path is wired end to end', () {
    String read(String path) =>
        File(path).readAsStringSync().replaceAll('\r\n', '\n');

    test('the screen shows the model real ids and opens the app player', () {
      final String screen =
          read('lib/features/tutor/presentation/screens/tutor_screen.dart');

      expect(screen, contains('videoIds: videos'),
          reason: 'Without ids the parser drops every video cite on arrival');
      expect(screen, contains('searchVideos('),
          reason: 'The candidates come from the app\'s YouTube repository');
      expect(screen, contains('SmartMediaDeskScreen(video: video)'),
          reason: 'Videos open in the app\'s own fetcher player');
    });

    test('a video chip is tappable, not decorative', () {
      final String view =
          read('lib/features/tutor/presentation/widgets/tutor_reply_view.dart');

      expect(view, contains('onOpenVideo'),
          reason: 'The chip must have something to call');
    });
  });
}
