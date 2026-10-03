import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

/// Guards the two ways English text reaches a non-English screen.
///
/// **A key absent from a locale's ARB is not an error to `gen-l10n`** — it writes
/// the template's English text into that locale instead, silently. The seven
/// `toneGraph*` strings (the "how to read this graph" panel) lived only in
/// `app_en.arb`, so all thirteen locales showed English prose there.
///
/// **A key present with the English value** is the other way, and it is what the
/// dock chip in the report showed: Russian still read `Processing…` and
/// `Loading…`, and French read `Focus` while its own `exitFocus` says "Quitter le
/// mode concentration".
///
/// The list below is the interface text a learner reads while the app is
/// thinking, so a regression here is visible on the first screen they touch.
///
/// The tone-graph panel needed a second kind of check, added 2026-09-29: translating
/// it was not enough, because the translation shipped as one 590-character paragraph.
/// The same file now pins its *shape* — four bullets, two for the phrase note, none
/// wider than 130 characters, in every locale (`docs/LOCALIZATION_PIPELINE.md` §5b).
void main() {
  const List<String> codes = <String>[
    'fr',
    'de',
    'es',
    'it',
    'pt',
    'ru',
    'ar',
    'hi',
    'id',
    'ja',
    'ko',
    'th',
    'vi',
  ];

  // Must be translated in every locale: the AI overlay, the dock chip, the
  // tone-graph panel, and the tutor's own sentences. The tutor is included
  // because its offline composer answers with *sentences* — a fallback left in
  // English looks like the tutor ignored the learner's language, and the two
  // that broke were the quiz proposal and the "ask me about a character" intro.
  const List<String> translatedKeys = <String>[
    'processing',
    'loading',
    'focus',
    'aiTools',
    'aiIsThinking',
    'aiSummary',
    'readability',
    'cancelAction',
    'toneGraphHowToReadTitle',
    'toneGraphHowToReadBody',
    'toneGraphHowToReadTooltip',
    'toneGraphHowToReadPhraseNote',
    'toneGraphNoPitchMeasured',
    'toneGraphTarget',
    'toneGraphYourVoice',
    // Sentences, never single words: "Quiz" is a legitimate borrowing in four
    // locales (`tutorQuizFolderName`), but no language shares these by accident.
    'tutorChooseDeck',
    'tutorQuizProposal',
    'tutorCharacterIntro',
    'tutorFallbackIntro',
    'tutorComponentCount',
    // The provenance footnote: a sentence, and one the learner reads whenever the
    // model is unavailable — the worst place to show English.
    'tutorAnsweredLocally',
    // The created folder's link and where it went.
    'tutorOpenQuiz',
    'tutorSavedToLibrary',
    // The exam's sentences: a practise paper the learner sits with a clock on it
    // is the last place to show English, and `examNotOfficial` is the honesty
    // notice that has to be readable.
    'examTitle',
    'examNotOfficial',
    'examPassMark',
    'examQuestionProgress',
    'examTimeUp',
    'examChooseAnAnswer',
    'examPromptAudio',
    'examPromptMeaning',
    'examPromptPinyin',
    'examPromptFill',
    // The instructions for the newer item kinds: an instruction the learner cannot
    // read is an item they cannot answer.
    'examPromptTone',
    'examPromptDictation',
    'examHintPinyin',
    'examPromptOrder',
    'examPromptGrammar',
    // The tutor's newer makers and the exam's own history: labels the learner has to
    // read to act on, and cannot infer from anything else on the screen.
    'tutorOpenStory',
    'tutorStoryQuestions',
    'tutorNothingDue',
    'tutorMakeFailed',
    'examHistory',
    'examPracticeMissed',
    'examPracticeWriting',
    'examPreviousScore',
    'examDropped',
    'examStudyMissed',
    'examAllCorrect',
    'examMissedDeckName',
    // A deck paper says something different about itself, and that difference is
    // the honesty rule: "HSK 3 scope" is not a claim a deck's vocabulary makes.
    'examTitleDeck',
    'examFromDeck',
  ];

  late Map<String, dynamic> english;

  Map<String, dynamic> load(String code) => jsonDecode(
        File('lib/l10n/app_$code.arb')
            .readAsStringSync()
            .replaceFirst('\ufeff', ''),
      ) as Map<String, dynamic>;

  setUpAll(() {
    english = load('en');
  });

  test('every locale file is valid JSON', () {
    for (final String code in codes) {
      expect(() => load(code), returnsNormally,
          reason: 'app_$code.arb must parse: gen-l10n reads all of them');
    }
  });

  test('no locale is missing a key, or it would ship in English', () {
    for (final String code in codes) {
      final Map<String, dynamic> locale = load(code);
      final List<String> missing = english.keys
          .where((key) => !key.startsWith('@') && !locale.containsKey(key))
          .toList()
        ..sort();

      expect(missing, isEmpty,
          reason: 'app_$code.arb is missing ${missing.length} key(s): '
              '${missing.take(8).join(', ')}');
    }
  });

  test('the overlay and tone-graph strings are not left in English', () {
    for (final String code in codes) {
      final Map<String, dynamic> locale = load(code);
      final List<String> untranslated = <String>[
        for (final String key in translatedKeys)
          if (locale[key] == english[key] &&
              // A handful of these are borrowed words in some languages; the
              // point is that they were *chosen*, not that they differ.
              !_knownBorrowings(code, key))
            key,
      ];

      expect(untranslated, isEmpty,
          reason: 'app_$code.arb still shows the English text for '
              '${untranslated.join(', ')}');
    }
  });

  test('the tone-graph panel stays a card, not a wall of text', () {
    // Feedback on the iPad build: "too much text". The body was one 590-character
    // paragraph and the shadowing studio's phrase note added 290 more; both are
    // bullets now, and the line breaks live in the ARB because that is where a
    // translator can see and keep them. This is the budget per locale — a shrink
    // landing in `en` alone would leave twelve locales unreadable, which is the
    // same failure as leaving them in English.
    const Map<String, ({int min, int max})> budget =
        <String, ({int min, int max})>{
      // Four ideas: the axes, the four shapes, the second-stroke rule, and the
      // reassurance that one stroke is not a failure.
      'toneGraphHowToReadBody': (min: 3, max: 4),
      // Why this graph differs: the strokes are not time-aligned.
      'toneGraphHowToReadPhraseNote': (min: 2, max: 2),
    };
    const int maxLineLength = 130;

    for (final String code in <String>['en', ...codes]) {
      final Map<String, dynamic> locale = load(code);
      budget.forEach((String key, ({int min, int max}) lines) {
        final List<String> rendered = (locale[key] as String)
            .split('\n')
            .map((String line) => line.trim())
            .toList();

        expect(rendered.length, lessThanOrEqualTo(lines.max),
            reason:
                'app_$code.arb $key is ${rendered.length} lines, budget is ${lines.max}');
        expect(rendered.length, greaterThanOrEqualTo(lines.min),
            reason: 'app_$code.arb $key collapsed back into prose');
        expect(rendered.where((String line) => line.isEmpty), isEmpty,
            reason: 'app_$code.arb $key contains a blank line');
        for (final String line in rendered) {
          expect(line.length, lessThanOrEqualTo(maxLineLength),
              reason: 'app_$code.arb $key has a ${line.length}-character line '
                  '(budget $maxLineLength): $line');
        }
      });
    }
  });

  test('the shipped locales are exactly the ones the sweep translated', () {
    // A locale added to the app but never translated would fail the checks
    // above the moment it had a file; this keeps that list honest.
    final List<String> files = Directory('lib/l10n')
        .listSync()
        .map((entry) => entry.path.split(RegExp(r'[\\/]')).last)
        .where((name) => name.startsWith('app_') && name.endsWith('.arb'))
        .map((name) => name.substring(4, name.length - 4))
        .toList()
      ..sort();
    final List<String> shipped = (['en'] + codes)..sort();

    expect(files, shipped);
    expect(
        AppLocalizations.supportedLocales
            .map((locale) => locale.languageCode)
            .toSet(),
        containsAll(codes));
  });
}

/// Words a locale deliberately keeps, listed one by one so a new exception has to
/// be argued for rather than inherited.
bool _knownBorrowings(String code, String key) {
  // Indonesian says "target", and it is the word its learners already know.
  if (code == 'id' && key == 'toneGraphTarget') return true;
  // Italian keeps "Focus" — its own `exitFocus` reads "Esci dalla modalità Focus".
  if (code == 'it' && key == 'focus') return true;
  return false;
}
