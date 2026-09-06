import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/settings/presentation/screens/qa_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  for (final locale in AppLocalizations.supportedLocales) {
    testWidgets(
      'knowledge base renders localized content for ${locale.languageCode}',
      (tester) async {
        final l10n = lookupAppLocalizations(locale);

        await tester.pumpWidget(
          MaterialApp(
            locale: locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: const QAScreen(),
          ),
        );

        expect(find.text(l10n.knowledgeBase), findsOneWidget);
        expect(find.text(l10n.howCanWeHelpYou), findsOneWidget);
        expect(
          find.text(l10n.everythingYouNeedToKnowAboutHanziMa),
          findsOneWidget,
        );
        expect(find.text(l10n.privacyAndAudio), findsOneWidget);
        expect(find.text(l10n.speaking_pronunciation), findsOneWidget);
      },
    );
  }

  testWidgets('knowledge base is fully localized in French', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('fr'),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: QAScreen(),
      ),
    );

    expect(find.text('Comment pouvons-nous vous aider ?'), findsOneWidget);
    expect(
      find.text(
        'Tout ce que vous devez savoir sur Hanzi Master, ses fonctionnalités et votre confidentialité.',
      ),
      findsOneWidget,
    );
    expect(find.text('Confidentialité et audio'), findsOneWidget);
    expect(find.text('Expression orale et prononciation'), findsOneWidget);
    expect(find.text('How can we help you?'), findsNothing);

    await tester.drag(find.byType(ListView), const Offset(0, -1000));
    await tester.pumpAndSettle();
    expect(find.text('Lecture & Vocabulaire'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, 500));
    await tester.pumpAndSettle();
    await tester
        .tap(find.text('Que faire si l’IA interprète mal mes propos ?'));
    await tester.pumpAndSettle();

    expect(
      find.textContaining('Si la transcription ne correspond pas'),
      findsOneWidget,
    );
  });

  test('every supported locale has current knowledge-base content', () {
    for (final locale in AppLocalizations.supportedLocales) {
      final l10n = lookupAppLocalizations(locale);
      final content = <String>[
        l10n.knowledgeBase,
        l10n.howCanWeHelpYou,
        l10n.everythingYouNeedToKnowAboutHanziMa,
        l10n.privacyAndAudio,
        l10n.do_you_keep_or_store_my,
        l10n.whatHappensToMyChatHistory,
        l10n.speaking_pronunciation,
        l10n.how_is_my_pronunciation_scored,
        l10n.what_is_shadowing_studio,
        l10n.whoAreTheVoicesSpeakingInTheApp,
        l10n.readingVocabulary,
        l10n.howDoesTheWebExplorerWork,
        l10n.whatIsZenMode,
        l10n.howDoesTheFlashcardSpacedrepetition,
        l10n.no_when_you_use_echo_hall,
        l10n.yourEchoModels,
        l10n.the_ai_evaluates_your_speech_across,
        l10n.whatIfAiMishears,
        l10n.ifTheAgain,
        l10n.shadowingStudioIsADedicated,
        l10n.theVoicesInAIStories,
        l10n.theWebExplorerAllowsYou,
        l10n.zenModeStripsAwayDistracting,
        l10n.weUseAnIntelligentAlgorithm,
      ];

      expect(
        content.every((value) => value.trim().isNotEmpty),
        isTrue,
        reason: '${locale.languageCode} should have complete FAQ content',
      );

      final combined = content.join('\n').toLowerCase();
      expect(
        combined,
        isNot(contains('echo hall')),
        reason:
            '${locale.languageCode} should not use the retired Echo Hall name',
      );
      expect(
        combined,
        isNot(contains("scholar's verdict")),
        reason:
            '${locale.languageCode} should not use the retired Scholar’s Verdict name',
      );
    }
  });
}
