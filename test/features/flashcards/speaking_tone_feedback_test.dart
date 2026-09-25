import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/review_stats.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/modes/speaking_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/speaking_feedback_panel.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../support/locale_layout_harness.dart';

/// Removes `//` comments so documenting an idiom is not mistaken for using it.
String _withoutLineComments(String source) =>
    source.split('\n').map((String line) {
      final int index = line.indexOf('//');
      return index == -1 ? line : line.substring(0, index);
    }).join('\n');

/// A canned grader result in the exact shape `GeminiService.gradeAudio`
/// returns: `score`, `accuracy`, `completeness`, `fluency`, the English
/// `overallFeedback`, and one entry per character with its tones.
Map<String, dynamic> _result({
  int score = 84,
  int accuracy = 80,
  int completeness = 100,
  int fluency = 90,
  String hanzi = '难',
  String pinyin = 'nán',
  int expectedTone = 2,
  int actualTone = 4,
}) {
  return <String, dynamic>{
    'score': score,
    'accuracy': accuracy,
    'completeness': completeness,
    'fluency': fluency,
    'overallFeedback': 'English sentence from the grader',
    'words': <Map<String, dynamic>>[
      <String, dynamic>{
        'word': hanzi,
        'pinyin': pinyin,
        'isCorrect': false,
        'isPartial': false,
        'isOmitted': false,
        'feedback': 'Pronunciation was inaccurate.',
        'wordScore': accuracy,
        'accuracy': accuracy,
        'expectedTone': expectedTone,
        'actualTone': actualTone,
        'phonemes': <Map<String, dynamic>>[],
      },
    ],
  };
}

Widget _panelHost(Map<String, dynamic> result,
    {Locale locale = const Locale('en')}) {
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
      body: SingleChildScrollView(
        child: SpeakingFeedbackPanel(result: result),
      ),
    ),
  );
}

Flashcard _card(String hanzi, String pinyin) => Flashcard(
      id: 'card-$hanzi',
      deckId: 'deck-a',
      hanzi: hanzi,
      pinyin: pinyin,
      definition: 'definition',
      hskLevel: 1,
      strokePaths: const <String>[],
      modeStats: const <StudyMode, ReviewStats>{},
    );

Widget _modeHost(Flashcard card, SharedPreferences prefs) {
  return ProviderScope(
    overrides: <Override>[
      sharedPreferencesProvider.overrideWithValue(prefs),
    ],
    child: MaterialApp(
      theme: AppTheme.lightTheme,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: SpeakingModeWidget(card: card),
    ),
  );
}

void main() {
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    prefs = await SharedPreferences.getInstance();
  });

  group('the feedback panel reports tones, not just a score', () {
    testWidgets('shows the score and every Azure metric', (tester) async {
      await tester.pumpWidget(_panelHost(_result()));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey<String>('speaking-feedback')),
        findsOneWidget,
      );
      expect(find.text('84'), findsOneWidget);
      expect(find.text('/100'), findsOneWidget);
      // The rating reads with the same three metrics the live-call verdict
      // averages — overall, tone accuracy and fluency — so one utterance is
      // legible in both places, under the same header.
      expect(find.text('Overall Score 84'), findsOneWidget);
      expect(find.text('Tone Accuracy 80'), findsOneWidget);
      expect(find.text('Fluency 90'), findsOneWidget);
      expect(find.text('AZURE PRONUNCIATION ASSESSMENT'), findsOneWidget);
      expect(find.text('Tone Accuracy'), findsOneWidget);
    });

    testWidgets('says what you actually said, syllable by syllable',
        (tester) async {
      // The grader reports expectedTone 2 / actualTone 4 for 难 (nán): the row
      // must show the two *syllables*, not "2 against 4".
      await tester.pumpWidget(
        _panelHost(_result(expectedTone: 2, actualTone: 4)),
      );
      await tester.pumpAndSettle();

      expect(find.text('Expected · nán'), findsOneWidget);
      expect(find.text('You Said · nàn'), findsOneWidget);
    });

    testWidgets('marks a tone that landed as the same syllable',
        (tester) async {
      await tester.pumpWidget(
        _panelHost(_result(expectedTone: 3, actualTone: 3, pinyin: 'nǐ')),
      );
      await tester.pumpAndSettle();

      expect(find.text('Expected · nǐ'), findsOneWidget);
      expect(find.text('You Said · nǐ'), findsOneWidget);
    });

    testWidgets('uses the catalogue verdict, never the grader English',
        (tester) async {
      await tester.pumpWidget(_panelHost(_result(score: 84)));
      await tester.pumpAndSettle();

      expect(
        find.text('Great job! A few minor tone inaccuracies.'),
        findsOneWidget,
      );
      expect(find.text('English sentence from the grader'), findsNothing);
    });

    testWidgets('bands the verdict', (tester) async {
      Future<void> pumpWithScore(int score) async {
        await tester.pumpWidget(_panelHost(_result(score: score)));
        await tester.pumpAndSettle();
      }

      await pumpWithScore(95);
      expect(
        find.text('Perfect pronunciation! Sounds like a native speaker.'),
        findsOneWidget,
      );

      await pumpWithScore(70);
      expect(
        find.text('Not bad, but your tones need some work.'),
        findsOneWidget,
      );

      await pumpWithScore(40);
      expect(
        find.text('Keep practicing! Listen to the native audio and try again.'),
        findsOneWidget,
      );

      await pumpWithScore(0);
      expect(find.text('Good effort! Keep practicing.'), findsOneWidget);
    });

    testWidgets('a tone row opens the tone graph for that character',
        (tester) async {
      await tester.pumpWidget(_panelHost(_result()));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey<String>('speaking-tone-难')));
      await tester.pumpAndSettle();

      // The app's existing tone comparison sheet: contours, tone names and the
      // "tone 2 against tone 4" diagnostic.
      expect(find.byType(BottomSheet), findsOneWidget);
    });

    testWidgets('a word with no tone data still renders its row',
        (tester) async {
      final Map<String, dynamic> result = _result();
      final Map<dynamic, dynamic> word =
          (result['words'] as List<dynamic>).first as Map<dynamic, dynamic>;
      word.remove('expectedTone');
      word.remove('actualTone');

      await tester.pumpWidget(_panelHost(result));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey<String>('speaking-tone-难')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('speaking-feedback')),
        findsOneWidget,
      );
      // The row's verdict survives, but nothing pretends to know a tone Azure
      // never reported: no comparison pills, and no graph offered for them.
      expect(find.text('Mispronounced'), findsOneWidget);
      expect(find.textContaining('Expected'), findsNothing);
      expect(find.textContaining('You Said'), findsNothing);
      expect(find.byIcon(Icons.remove_rounded), findsOneWidget);
    });

    testWidgets('every locale fits the tightest viewport', (tester) async {
      await expectNoOverflowAcrossLocales(
        tester,
        (BuildContext context) => _panelHost(_result()),
        locales: const <String>['de', 'ru', 'th', 'hi', 'ja'],
      );
    });
  });

  group('speaking practice shows the target tones', () {
    testWidgets('one pill per syllable, with its tone number', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_modeHost(_card('汉字', 'hàn zì'), prefs));
      await tester.pumpAndSettle();

      // `showPinyinInSpeaking` defaults to true, so the pinyin and its tones are
      // visible before the learner speaks.
      expect(find.text('hàn 4'), findsOneWidget);
      expect(find.text('zì 4'), findsOneWidget);
    });
  });

  group('the speaking screen dropped its English and its rainbow', () {
    late String source;
    late String panel;

    setUpAll(() {
      source = _withoutLineComments(
        File(
          'lib/features/flashcards/presentation/widgets/modes/speaking_mode.dart',
        ).readAsStringSync(),
      );
      panel = _withoutLineComments(
        File(
          'lib/features/flashcards/presentation/widgets/speaking_feedback_panel.dart',
        ).readAsStringSync(),
      );
    });

    test('no hardcoded strings survive in the speaking mode', () {
      for (final String literal in <String>[
        "'AI Score:",
        "'Hold to speak (Optional)'",
        "'Listening...'",
        'Microphone permission required',
        'Failed to start recording',
        'Recording failed (no file).',
        'Error analyzing audio',
      ]) {
        expect(source, isNot(contains(literal)), reason: literal);
      }
      expect(source, contains('holdMicToRecordReleaseToGrade'));
      expect(source, contains('listening'));
      expect(source, contains('recordingFailedNoFile'));
      expect(source, contains('couldNotProcessYourRecordingPleaseT'));
      expect(source, contains('microphonePermissionRequired'));
    });

    test('the screen wears the app palette, not Material hues', () {
      for (final String literal in <String>[
        'Colors.blue',
        'Colors.green',
        'Colors.red.shade',
        'shade900',
        'shade200',
        'shade50',
      ]) {
        expect(source, isNot(contains(literal)), reason: literal);
      }
      expect(source, contains('AppTheme.accentOf(context)'));
      expect(source, contains('AppTheme.carbonInkLight'));
      expect(
        source,
        contains('const ZenLoader()'),
        reason: 'the standard forbids a bare section spinner',
      );
      expect(panel, isNot(contains('Colors.green')));
      expect(panel, contains('PinyinUtils.toneColors'));
    });
  });

  group('the practice exercise reports the rating and the verdicts', () {
    testWidgets('each character carries its own score and verdict',
        (tester) async {
      final Map<String, dynamic> result = _result();
      (result['words'] as List<dynamic>).first['wordScore'] = 62;

      await tester.pumpWidget(_panelHost(result));
      await tester.pumpAndSettle();

      // The per-character score the deck used to drop, and the verdict word the
      // shadowing studio prints for the same error type.
      expect(find.text('62'), findsOneWidget);
      expect(find.text('Mispronounced'), findsOneWidget);
    });

    testWidgets('a character that landed is badged as correct', (tester) async {
      final Map<String, dynamic> result = _result();
      final Map<dynamic, dynamic> word =
          (result['words'] as List<dynamic>).first as Map<dynamic, dynamic>;
      word['isCorrect'] = true;

      await tester.pumpWidget(_panelHost(result));
      await tester.pumpAndSettle();

      expect(find.text('Correct'), findsOneWidget);
      expect(find.text('Mispronounced'), findsNothing);
    });

    testWidgets('the tone section invites the deep analysis', (tester) async {
      await tester.pumpWidget(_panelHost(_result()));
      await tester.pumpAndSettle();

      expect(find.text('Tap to review'), findsOneWidget);
    });
  });

  group('the deck exercise can always be rated', () {
    test('a failed grade unlocks the rating instead of a dead end', () {
      final String source = _withoutLineComments(
        File(
          'lib/features/flashcards/presentation/widgets/modes/speaking_mode.dart',
        ).readAsStringSync(),
      );

      // Revealing the card, a successful grade, or a failed one all unlock the
      // swipe-to-grade, so the learner is never left holding a card they cannot
      // rate.
      expect(source, contains('_error != null'));
      expect(source, contains('isSwipeEnabled: canRate'));
      expect(source, contains('if (canRate)'));
    });
  });
}
