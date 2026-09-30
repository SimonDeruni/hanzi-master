/// The practice mode that is only hers: "Notre histoire".
///
/// Three days of hers — the day they met, the day of the first message, the day of
/// Heidelberg — practised as three Chinese sentences, plus `I love you.` None of them is
/// asked of the model: a theme handed to Gemini is a hint, and a *date* is a fact that
/// has to come back unaltered (`HerContent.shadowingBankFor`).
///
/// Two things are pinned here that the content tests cannot see: which bank each
/// `ShadowingMode` settles on (so a mode added later fails instead of quietly
/// practising her sentences), and that the chip itself only exists for her — pumped
/// from the real screen, through the real Riverpod gate.
library;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/personal/her_account.dart';
import 'package:hanzi_master/core/personal/her_content.dart';
import 'package:hanzi_master/features/auth/presentation/providers/auth_controller.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/shadowing_studio_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class _FakeUser extends Fake implements User {
  _FakeUser(this.email);

  @override
  final String? email;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  /// What each mode practises, as the studio asks it: the mode's `toString()`.
  ///
  /// `null` means the model writes the phrase. Adding a `ShadowingMode` without adding
  /// it here fails the first test below — which is the point of writing the table out
  /// rather than trusting a default branch.
  const Map<ShadowingMode, List<Map<String, String>>?> expectedBank =
      <ShadowingMode, List<Map<String, String>>?>{
    ShadowingMode.freeFlow: HerContent.shadowingSentences,
    ShadowingMode.theme: HerContent.shadowingSentences,
    ShadowingMode.deck: HerContent.shadowingSentences,
    ShadowingMode.ourDates: HerContent.shadowingDateSentences,
    ShadowingMode.customWord: null,
    ShadowingMode.customSentence: null,
  };

  Future<void> pumpStudio(WidgetTester tester, String? email) async {
    await tester.binding.setSurfaceSize(const Size(430, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          currentUserProvider.overrideWithValue(
            email == null ? null : _FakeUser(email),
          ),
        ],
        child: const MaterialApp(
          locale: Locale('fr'),
          localizationsDelegates: <LocalizationsDelegate<dynamic>>[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: ShadowingStudioScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('the mode and its bank', () {
    test('every mode has a bank of its own', () {
      // A mode missing from the table is a mode nobody decided about — and the
      // default in `shadowingBankFor` would hand it her love sentences.
      expect(
        expectedBank.keys.toSet(),
        ShadowingMode.values.toSet(),
        reason: 'a new ShadowingMode needs a decision here',
      );
    });

    test('each mode resolves to the bank the table gives it', () {
      for (final MapEntry<ShadowingMode, List<Map<String, String>>?> entry
          in expectedBank.entries) {
        expect(
          HerContent.shadowingBankFor(entry.key.toString()),
          entry.value,
          reason: entry.key.toString(),
        );
      }
    });

    test('the date sentences are the date mode\'s alone', () {
      expect(ShadowingMode.ourDates.toString(), HerContent.shadowingDateMode,
          reason: 'the studio hands the mode over as its toString()');

      for (final ShadowingMode mode in ShadowingMode.values) {
        if (mode == ShadowingMode.ourDates) continue;
        expect(
          identical(
            HerContent.shadowingBankFor(mode.toString()),
            HerContent.shadowingDateSentences,
          ),
          isFalse,
          reason: '${mode.toString()} must not practise her dates',
        );
      }
    });

    test('her dates are facts, not something the model paraphrases', () {
      for (final Map<String, String> sentence
          in HerContent.shadowingDateSentences) {
        expect(
          sentence.keys,
          containsAll(<String>['hanzi', 'pinyin', 'english']),
        );
        expect(sentence['hanzi']!.trim(), isNotEmpty);
        expect(sentence['pinyin']!.trim(), isNotEmpty);
        expect(sentence['english']!.trim(), isNotEmpty);
        // No digits in the Chinese: the studio draws one syllable above each
        // *character*, so a date written in digits would pair the ruby with the
        // wrong ones.
        expect(RegExp('[0-9]').hasMatch(sentence['hanzi']!), isFalse,
            reason: sentence['hanzi']);
      }
    });

    test('she hears each of the four before any of them twice, then starts over',
        () {
      expect(HerContent.shadowingDateSentences, hasLength(4));

      final List<String> heard = <String>[];
      for (int i = 0; i < HerContent.shadowingDateSentences.length; i++) {
        final Map<String, String> next = HerContent.shadowingSentenceAfter(
          heard,
          bank: HerContent.shadowingDateSentences,
        );
        expect(heard, isNot(contains(next['hanzi'])), reason: next['hanzi']);
        heard.add(next['hanzi']!);
      }

      expect(
        HerContent.shadowingSentenceAfter(
          heard,
          bank: HerContent.shadowingDateSentences,
        )['hanzi'],
        HerContent.shadowingDateSentences.first['hanzi'],
      );
    });
  });

  group('the chip in the practice-mode row', () {
    testWidgets('is hers, and opens the three dates',
        (WidgetTester tester) async {
      await pumpStudio(tester, HerAccount.email);

      expect(find.text(HerContent.shadowingDateModeLabel), findsOneWidget);
      // The ordinary modes are still there, next to hers.
      expect(find.text('Flux libre'), findsOneWidget);

      // Selecting it shows what the mode is: the words, and the three days.
      await tester.tap(find.text(HerContent.shadowingDateModeLabel));
      await tester.pumpAndSettle();

      expect(find.text(HerContent.shadowingDateModeDescription), findsOneWidget);
      for (final String date in HerContent.shadowingDateLabels) {
        expect(find.text(date), findsOneWidget, reason: date);
      }
      expect(tester.takeException(), isNull);
    });

    testWidgets('is absent for another account', (WidgetTester tester) async {
      await pumpStudio(tester, 'someone.else@example.com');

      expect(find.text(HerContent.shadowingDateModeLabel), findsNothing);
      expect(find.text('Flux libre'), findsOneWidget);
      for (final String date in HerContent.shadowingDateLabels) {
        expect(find.text(date), findsNothing, reason: date);
      }
      expect(tester.takeException(), isNull);
    });

    testWidgets('is absent when nobody is signed in',
        (WidgetTester tester) async {
      await pumpStudio(tester, null);

      expect(find.text(HerContent.shadowingDateModeLabel), findsNothing);
      expect(find.text('Flux libre'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
