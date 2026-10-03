/// The tutor answers **in the learner's language**, in all 14 shipped locales.
///
/// Three ways this broke, all of them live at some point:
///
///  1. **The offline composer wrote its sentences in English.** `LocalTutor` had
///     no localizations at all, so a French learner who asked for a quiz got
///     "I can build a 20-item quiz from HSK 3." — worse than no answer, because it
///     looks like the tutor ignored the language they are learning in.
///  2. **The `make` card glued a number to a lowercased noun.** It read
///     *"3 deck"*, and `.toLowerCase()` on a translated word is wrong in German,
///     where nouns stay capitalised.
///  3. **The folder it created was named after a raw ISO date** (`2026-02-10`),
///     which no ARB ever saw.
///
/// The *sentences* are what this file pins, because a sentence can never
/// legitimately coincide with English — unlike a single word, which some locales
/// really do borrow (`practiceQuiz` is "QUIZ" in French, German, Italian and
/// Portuguese, so that one is deliberately not asserted to differ).
library;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_make_result.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_context.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_reply.dart';
import 'package:hanzi_master/features/tutor/domain/logic/local_tutor.dart';
import 'package:hanzi_master/features/tutor/presentation/widgets/tutor_artefacts.dart';
import 'package:hanzi_master/features/tutor/presentation/widgets/tutor_reply_view.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // A referenced deck with enough cards for a proposal — the state the reply
  // view is tested in.
  const TutorContext focused = TutorContext(
    decks: <TutorDeckSummary>[
      TutorDeckSummary(id: 'hsk3', name: 'HSK 3', cardCount: 24, dueCount: 3),
    ],
    references: <TutorReference>[
      TutorReference(kind: TutorReferenceKind.deck, id: 'hsk3', label: 'HSK 3'),
    ],
  );

  test('every locale writes its own sentences, never the English ones', () {
    final AppLocalizations english = lookupAppLocalizations(const Locale('en'));
    final Set<String> englishText = <String>{
      LocalTutor.compose(message: 'quiz', context: focused, l10n: english).say!,
      LocalTutor.compose(message: 'hello', context: focused, l10n: english)
          .say!,
      LocalTutor.compose(message: '好', context: focused, l10n: english).say!,
      english.tutorChooseDeck,
    };
    expect(englishText.length, 4, reason: 'the four English sentences differ');

    for (final Locale locale in AppLocalizations.supportedLocales) {
      if (locale.languageCode == 'en') continue;
      final AppLocalizations l10n = lookupAppLocalizations(locale);

      final String proposal =
          LocalTutor.compose(message: 'quiz', context: focused, l10n: l10n)
              .say!;
      final String fallback =
          LocalTutor.compose(message: 'hello', context: focused, l10n: l10n)
              .say!;
      final String character =
          LocalTutor.compose(message: '好', context: focused, l10n: l10n).say!;

      for (final String said in <String>[
        proposal,
        fallback,
        character,
        l10n.tutorChooseDeck,
      ]) {
        expect(said.trim(), isNotEmpty,
            reason: '${locale.languageCode}: an empty sentence renders as a '
                'blank bubble');
        expect(englishText.contains(said), isFalse,
            reason: '${locale.languageCode}: still the English text — "$said"');
      }

      // Translating the sentence must not lose what makes it specific.
      expect(proposal, contains('HSK 3'),
          reason: '${locale.languageCode}: the deck name vanished');
      expect(character, contains('好'),
          reason: '${locale.languageCode}: the character vanished');
    }
  });

  test('a deck request in the learner\'s own word is understood', () {
    for (final Locale locale in AppLocalizations.supportedLocales) {
      final AppLocalizations l10n = lookupAppLocalizations(locale);
      // The app's own name for this feature, straight from the ARB, is one of the
      // things a learner is most likely to type.
      expect(
        LocalTutor.looksLikeExamRequest('${l10n.practiceQuiz} HSK 3',
            l10n: l10n),
        isTrue,
        reason: '${locale.languageCode}: "${l10n.practiceQuiz}" is not '
            'recognised, so the offline tutor ignores the request',
      );
    }
  });
  test('the question is asked with the deck as a tappable answer', () {
    // Too many decks to guess from: ask, in the learner's language.
    const TutorContext twoDecks = TutorContext(
      decks: <TutorDeckSummary>[
        TutorDeckSummary(id: 'hsk3', name: 'HSK 3', cardCount: 24, dueCount: 3),
        TutorDeckSummary(
            id: 'tones', name: 'Tones', cardCount: 12, dueCount: 0),
      ],
    );
    final AppLocalizations english = lookupAppLocalizations(const Locale('en'));

    for (final Locale locale in AppLocalizations.supportedLocales) {
      final AppLocalizations l10n = lookupAppLocalizations(locale);
      final TutorReply reply =
          LocalTutor.compose(message: 'quiz', context: twoDecks, l10n: l10n);

      expect(reply.ask!.question, l10n.tutorChooseDeck);
      expect(reply.ask!.options.length, 2);
      expect(reply.makes, isEmpty,
          reason: 'a guess would be worse than a question');
      if (locale.languageCode != 'en') {
        expect(reply.ask!.question, isNot(equals(english.tutorChooseDeck)),
            reason: '${locale.languageCode}: the question is still English');
      }
    }
  });

  testWidgets('a created folder links to itself, and says where it went',
      (WidgetTester tester) async {
    final AppLocalizations l10n = lookupAppLocalizations(const Locale('en'));
    final TutorReply reply =
        LocalTutor.compose(message: 'quiz', context: focused, l10n: l10n);
    String? opened;

    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: const <LocalizationsDelegate<Object>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: SingleChildScrollView(
          child: TutorReplyView(
            reply: reply,
            data: const TutorArtefactData(),
            // What a real `make` returns once the deck exists.
            onMake: (TutorMake make) async => TutorMakeResult.created(
              Deck(
                id: 'folder-1',
                name: 'HSK 3 — Quiz',
                createdAt: DateTime(2026, 2, 10),
              ),
              make.items,
            ),
            onOpenDeck: (String id) => opened = id,
          ),
        ),
      ),
    ));
    await tester.pumpAndSettle();

    // Before the commit there is nothing to open.
    expect(find.text(l10n.tutorOpenQuiz), findsNothing);

    await tester.tap(find.text(l10n.create));
    await tester.pumpAndSettle();

    // After it: the promise kept, the location stated, and the link works.
    expect(find.text(l10n.done), findsOneWidget);
    expect(find.text(l10n.tutorSavedToLibrary), findsOneWidget,
        reason:
            'a learner who just made a folder should not have to hunt for it');
    expect(find.text(l10n.tutorOpenQuiz), findsOneWidget);

    await tester.tap(find.text(l10n.tutorOpenQuiz));
    await tester.pumpAndSettle();
    expect(opened, 'folder-1',
        reason: 'the link must open the folder it is describing');
  });

  for (final Locale locale in AppLocalizations.supportedLocales) {
    testWidgets(
      'the reply view is localized in ${locale.languageCode}',
      (WidgetTester tester) async {
        final AppLocalizations l10n = lookupAppLocalizations(locale);
        final TutorReply reply =
            LocalTutor.compose(message: 'quiz', context: focused, l10n: l10n);
        final int items = reply.makes.single.items;

        await tester.pumpWidget(MaterialApp(
          locale: locale,
          localizationsDelegates: const <LocalizationsDelegate<Object>>[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: TutorReplyView(
                reply: reply,
                data: const TutorArtefactData(),
                onMake: (TutorMake make) async =>
                    const TutorMakeResult.notEnoughCards(3),
              ),
            ),
          ),
        ));
        await tester.pumpAndSettle();

        // The sentence, the item count and the commit action all come from the
        // ARB — none of them is a number glued to a noun in Dart.
        expect(find.text(reply.say!), findsOneWidget,
            reason: '${locale.languageCode}: the answer is not localized');
        expect(find.text(l10n.deckItemsCount(items)), findsOneWidget);
        expect(find.text(l10n.create), findsOneWidget);
        // The provenance footnote: this answer came from the app, not the model.
        expect(find.text(l10n.tutorAnsweredLocally), findsOneWidget,
            reason:
                '${locale.languageCode}: the reply does not say where it came '
                'from');

        // Committing a proposal this deck cannot serve answers with the app's own
        // sentence for that refusal (the one a quiz start shows), not "3 deck".
        await tester.tap(find.text(l10n.create));
        await tester.pumpAndSettle();
        expect(find.text(l10n.notEnoughCardsFor), findsOneWidget,
            reason: '${locale.languageCode}: the refusal is not localized');
      },
    );
  }
}
