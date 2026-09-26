@Tags(<String>['locale-sweep'])
library;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/review_stats.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/study_mode_selection_sheet.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

import '../../support/locale_layout_harness.dart';

/// Removes `//` comments so documenting an idiom is not mistaken for using it.
String _withoutLineComments(String source) =>
    source.split('\n').map((String line) {
      final int index = line.indexOf('//');
      return index == -1 ? line : line.substring(0, index);
    }).join('\n');

Flashcard _card({
  required StudyMode mode,
  required int attempts,
  required int successes,
  bool due = true,
}) {
  return Flashcard(
    id: 'card-${mode.name}',
    deckId: 'deck-a',
    hanzi: '汉',
    pinyin: 'hàn',
    definition: 'character',
    hskLevel: 1,
    strokePaths: const <String>[],
    modeStats: <StudyMode, ReviewStats>{
      mode: ReviewStats(
        nextReviewDate: due
            ? DateTime.now().subtract(const Duration(days: 2))
            : DateTime.now().add(const Duration(days: 5)),
        interval: 5,
        easeFactor: 2.5,
        streak: 2,
        attempts: attempts,
        successCount: successes,
        lastAttemptDate: DateTime.now(),
        introducedAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
    },
  );
}

Widget _host({
  List<Flashcard> cards = const <Flashcard>[],
  Locale locale = const Locale('en'),
}) {
  return MaterialApp(
    theme: AppTheme.lightTheme,
    locale: locale,
    localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      body: StudyModeSelectionSheet(
        onModeSelected: (StudyMode mode) {},
        cards: cards,
      ),
    ),
  );
}

/// Opens the sheet from a button so the test can see what it hands back.
Widget _tappedHost({required void Function(StudyMode?) onPicked}) {
  return MaterialApp(
    theme: AppTheme.lightTheme,
    localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: Builder(
      builder: (BuildContext context) => Scaffold(
        body: Center(
          child: ElevatedButton(
            key: const ValueKey<String>('open-mode-sheet'),
            onPressed: () => StudyModeSelectionSheet.show(
              context,
              onModeSelected: onPicked,
            ),
            child: const Text('Open'),
          ),
        ),
      ),
    ),
  );
}

void main() {
  const List<String> labels = <String>[
    'Calligraphy',
    'Reading',
    'Recall',
    'Speaking',
    'Listening',
  ];
  const List<String> descriptions = <String>[
    'Practice stroke order with visual guides.',
    'See the character, recall the Pinyin and Meaning.',
    'See the meaning, draw the character from memory.',
    'Read out loud to test your pronunciation tones.',
    'Listen to the audio and identify the character.',
  ];

  testWidgets('every mode is named and explained from the catalogue',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(_host());
    await tester.pumpAndSettle();

    expect(find.text('How would you like to study?'), findsOneWidget);
    expect(find.text('Practice Modes'), findsOneWidget);
    // The sheet scrolls (it must, on a short screen at 2x text), so each row is
    // scrolled into view before it is read.
    for (int i = 0; i < StudyMode.values.length; i++) {
      final StudyMode mode = StudyMode.values[i];
      await tester.scrollUntilVisible(
        find.byKey(ValueKey<String>('study-mode-${mode.name}')),
        120,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text(labels[i]), findsOneWidget, reason: labels[i]);
      expect(find.text(descriptions[i]), findsOneWidget,
          reason: descriptions[i]);
    }
  });

  testWidgets('a mode row is an ink well with the gold hairline',
      (tester) async {
    await tester.pumpWidget(_host());
    await tester.pumpAndSettle();

    final Material row = tester.widget<Material>(
      find
          .ancestor(
              of: find.text('Calligraphy'), matching: find.byType(Material))
          .first,
    );
    expect(row.color, AppTheme.cardBgLight);
    expect(row.borderRadius, BorderRadius.circular(18));

    final Container bordered = tester.widget<Container>(
      find
          .descendant(
              of: find.byType(InkWell), matching: find.byType(Container))
          .first,
    );
    final BoxDecoration decoration = bordered.decoration! as BoxDecoration;
    expect(decoration.borderRadius, BorderRadius.circular(18));
    expect(
      (decoration.border! as Border).top.color,
      const Color(0xFFD4AF37).withValues(alpha: 0.3),
      reason: "Emperor's Gold hairline",
    );
  });

  testWidgets('rows report what the deck has due, and stay quiet otherwise',
      (tester) async {
    await tester.pumpWidget(
      _host(
        cards: <Flashcard>[
          _card(mode: StudyMode.reading, attempts: 9, successes: 3),
        ],
      ),
    );
    await tester.pumpAndSettle();

    // Reading: one card due, 3 of 9 correct.
    expect(find.text('1 · Due now'), findsOneWidget);
    expect(find.text('Accuracy 33%'), findsOneWidget);
    // Nothing has been practised in the other modes, so they claim nothing.
    expect(find.textContaining('Due now'), findsOneWidget);
    expect(find.textContaining('Accuracy'), findsOneWidget);

    await tester.pumpWidget(_host());
    await tester.pumpAndSettle();
    expect(find.textContaining('Due now'), findsNothing);
    expect(find.textContaining('Accuracy'), findsNothing);
  });

  testWidgets('choosing a mode hands it back and closes the sheet',
      (tester) async {
    StudyMode? picked;
    await tester.pumpWidget(
      _tappedHost(onPicked: (StudyMode? mode) => picked = mode),
    );
    await tester.tap(find.byKey(const ValueKey<String>('open-mode-sheet')));
    await tester.pumpAndSettle();
    expect(
        find.byKey(const ValueKey<String>('study-mode-sheet')), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey<String>('study-mode-recall')));
    await tester.pumpAndSettle();

    expect(picked, StudyMode.recall);
    expect(
        find.byKey(const ValueKey<String>('study-mode-sheet')), findsNothing);
  });

  group('the sheet dropped the old Material vocabulary', () {
    late String source;

    setUpAll(() {
      source = _withoutLineComments(
        File(
          'lib/features/flashcards/presentation/widgets/study_mode_selection_sheet.dart',
        ).readAsStringSync(),
      );
    });

    test('no rainbow, no shade-tinted fills or borders', () {
      // The old rows were blue/green/orange/red/purple with shade50/shade900
      // fills and shade200/shade700 borders — five hues for five rows, none of
      // them from the app palette.
      for (final String hue in <String>[
        'Colors.blue',
        'Colors.green',
        'Colors.orange',
        'Colors.purple',
        'shade900',
        'shade800',
        'shade200',
        'shade50',
      ]) {
        expect(source, isNot(contains(hue)), reason: hue);
      }
      expect(source, contains('AppTheme.accentOf(context)'));
      expect(source, contains('AppTheme.cardBgOf(context)'));
      expect(source, contains('const Color(0xFFD4AF37)'),
          reason: "Emperor's Gold hairline");
    });

    test('labels come from the catalogue, not the domain entity', () {
      // `StudyMode.title` / `.description` are hardcoded English on the entity.
      expect(source, isNot(contains('mode.title')));
      expect(source, isNot(contains('mode.description')));
      expect(source, contains('l10n.practiceStrokeOrderWithVisualGuides'));
      expect(source, contains('l10n.seeTheCharacterRecallThePinyinAndMe'));
      expect(source, contains('l10n.seeTheMeaningDrawTheCharacterFromMe'));
      expect(source, contains('l10n.readOutLoudToTestYourPronunciationT'));
      expect(source, contains('l10n.listenToTheAudioAndIdentifyTheChara'));
    });

    test('the sheet hugs its content instead of filling the screen', () {
      expect(source, contains('MediaQuery.sizeOf(context).height * 0.8'));
      expect(source, contains('shrinkWrap: true'));
      expect(source, contains('HapticsManager.selection()'));
    });
  });

  testWidgets('every mode fits the tightest viewport in every locale',
      (tester) async {
    await expectNoOverflowAcrossLocales(
      tester,
      (BuildContext context) => _host(
        cards: <Flashcard>[
          _card(mode: StudyMode.reading, attempts: 9, successes: 3),
        ],
      ),
      locales: const <String>['de', 'ru', 'th', 'hi', 'ja'],
    );
  });
}
