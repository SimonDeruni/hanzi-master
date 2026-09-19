import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/widgets/ltr_sanctuary.dart';
import 'package:hanzi_master/features/echo_hall/presentation/widgets/tone_comparison_sheet.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/drawing_canvas.dart';
import 'package:hanzi_master/features/onboarding/presentation/screens/onboarding_mini_lesson_screen.dart';
import 'package:hanzi_master/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:hanzi_master/features/onboarding/presentation/screens/tutorial_lesson_screen.dart';
import 'package:hanzi_master/features/premium/presentation/screens/custom_paywall_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

Widget _arabicApp({required Widget home}) => ProviderScope(
      child: MaterialApp(
        locale: const Locale('ar'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: home),
      ),
    );

Flashcard _buildMockCard({
  required String id,
  required String hanzi,
  required String pinyin,
  required String definition,
}) {
  return Flashcard(
    id: id,
    hanzi: hanzi,
    pinyin: pinyin,
    definition: definition,
    hskLevel: 1,
    strokePaths: const ['M 0 0 L 100 100'],
    medianPaths: const [
      [Offset.zero, Offset(100, 100)],
    ],
    modeStats: const {},
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Arabic RTL & LtrSanctuary Calligraphic Architecture Tests', () {
    testWidgets(
        'OnboardingScreen adopts TextDirection.rtl while rendering Arabic strings',
        (tester) async {
      await tester.pumpWidget(
        _arabicApp(home: const OnboardingScreen()),
      );
      await tester.pumpAndSettle();

      // Ambient directionality must be RTL
      final BuildContext context =
          tester.element(find.byType(OnboardingScreen));
      expect(Directionality.of(context), TextDirection.rtl);

      // Verify Arabic start button is present
      final l10n = AppLocalizations.of(context)!;
      expect(find.text(l10n.letsBegin), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets(
        'OnboardingMiniLessonScreen preserves LTR sanctuaries under Arabic RTL',
        (tester) async {
      await tester.pumpWidget(
        _arabicApp(
          home: OnboardingMiniLessonScreen(
            disableExternalServicesForTesting: true,
            onComplete: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Ambient screen directionality must be RTL
      final screenContext =
          tester.element(find.byType(OnboardingMiniLessonScreen));
      expect(Directionality.of(screenContext), TextDirection.rtl);

      // Step 0: OnboardingSpeakingText must be enclosed in an LTR sanctuary
      final speakingFinder = find.byType(OnboardingSpeakingText);
      expect(speakingFinder, findsOneWidget);
      final speakingContext = tester.element(speakingFinder);
      expect(Directionality.of(speakingContext), TextDirection.ltr);

      // Advance to Step 1 (Notice)
      final l10n = AppLocalizations.of(screenContext)!;
      await tester.ensureVisible(find.text(l10n.continueAction));
      await tester.tap(find.text(l10n.continueAction));
      await tester.pumpAndSettle();

      // Step 1: Chinese exemplar phrases must be inside LtrSanctuary
      expect(find.text('知彼知己者，'), findsOneWidget);
      final chinesePhraseContext = tester.element(find.text('知彼知己者，'));
      expect(Directionality.of(chinesePhraseContext), TextDirection.ltr);

      // Advance to Step 2 (Shadow)
      await tester.ensureVisible(find.text(l10n.shadowOneSentence));
      await tester.tap(find.text(l10n.shadowOneSentence));
      await tester.pumpAndSettle();

      // Advance through Step 2 (Shadow) via Continue -> Stop and check my tones
      await tester.ensureVisible(find.text(l10n.continueAction));
      await tester.tap(find.text(l10n.continueAction));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text(l10n.stopAndCheckMyTones));
      await tester.tap(find.text(l10n.stopAndCheckMyTones));
      await tester.pumpAndSettle();

      // Step 3: Verify the multi-character tone sentence pill row is protected LTR
      final charPillFinder = find.byKey(const Key('tone_character_百')).first;
      expect(charPillFinder, findsOneWidget);
      final charPillContext = tester.element(charPillFinder);
      expect(Directionality.of(charPillContext), TextDirection.ltr);

      // Advance to Step 4 (Write canvas)
      await tester.ensureVisible(find.text(l10n.tryHandwriting));
      await tester.tap(find.text(l10n.tryHandwriting));
      await tester.pumpAndSettle();

      // Step 4: Verify the practice canvas / character is guarded by LtrSanctuary
      final charHaoFinder = find.text('好');
      expect(charHaoFinder, findsOneWidget);
      final canvasContext = tester.element(charHaoFinder);
      expect(Directionality.of(canvasContext), TextDirection.ltr);
    });

    testWidgets(
        'ToneComparisonSheet enforces LTR sanctuary for pitch contours & Pinyin',
        (tester) async {
      await tester.pumpWidget(
        _arabicApp(
          home: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => const ToneComparisonSheet(
                      character: '好',
                      pinyin: 'hǎo',
                      expectedTone: 3,
                      actualTone: 2,
                      feedback: 'Dipping tone practice',
                    ),
                  );
                },
                child: const Text('Open'),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap to open sheet
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      // Verify the sheet is open
      expect(find.byType(ToneComparisonSheet), findsOneWidget);

      // The character and pinyin in the header must be inside LtrSanctuary
      final headerChar = find.text('好').first;
      expect(Directionality.of(tester.element(headerChar)), TextDirection.ltr);

      final headerPinyin = find.text('hǎo').first;
      expect(
          Directionality.of(tester.element(headerPinyin)), TextDirection.ltr);

      // The pitch contour icons (e.g. Tone 1 '¯', Tone 2 '/', Tone 3 'v', Tone 4 '\') must be LTR
      final pitchV = find.text('v').first;
      expect(Directionality.of(tester.element(pitchV)), TextDirection.ltr);
    });

    testWidgets(
        'TutorialLessonScreen radical decomposition and canvas are LTR protected',
        (tester) async {
      final cardOne = _buildMockCard(
        id: 'mock_1',
        hanzi: '一',
        pinyin: 'yī',
        definition: 'one',
      );
      final cardWater = _buildMockCard(
        id: 'mock_2',
        hanzi: '水',
        pinyin: 'shuǐ',
        definition: 'water',
      );

      await tester.pumpWidget(
        _arabicApp(
          home: TutorialLessonScreen(
            initialCardOneForTesting: cardOne,
            initialCardWaterForTesting: cardWater,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Page 0: Intro Step
      final l10n = AppLocalizations.of(
          tester.element(find.byType(TutorialLessonScreen)))!;
      expect(find.text(l10n.iAmReady), findsOneWidget);

      // Advance to Page 1: Drawing '一'
      await tester.tap(find.text(l10n.iAmReady));
      await tester.pumpAndSettle();

      // Step 1 has drawing canvas wrapped in LtrSanctuary
      final canvasFinder = find.byType(DrawingCanvas);
      expect(canvasFinder, findsOneWidget);
      expect(Directionality.of(tester.element(canvasFinder)), TextDirection.ltr);

      // Advance to Page 2: What are radicals? (氵 + 工 = 江)
      final PageController pageController =
          tester.widget<PageView>(find.byType(PageView)).controller!;
      pageController.jumpToPage(2);
      await tester.pumpAndSettle();

      final waterRadical = find.text('氵');
      expect(waterRadical, findsOneWidget);
      expect(
          Directionality.of(tester.element(waterRadical)), TextDirection.ltr);

      final riverChar = find.text('江');
      expect(riverChar, findsOneWidget);
      expect(Directionality.of(tester.element(riverChar)), TextDirection.ltr);
    });

    testWidgets('CustomPaywallScreen wraps screenshot asset in LtrSanctuary',
        (tester) async {
      await tester.pumpWidget(
        _arabicApp(
          home: const CustomPaywallScreen(
            useMockOfferingsForTesting: true,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Look for screenshot inset
      final screenshotInsetFinder =
          find.byKey(const ValueKey('paywall_screenshot_inset_0'));
      expect(screenshotInsetFinder, findsOneWidget);

      // Find the LtrSanctuary and its inner Image inside the inset
      final ltrSanctuaryFinder = find.descendant(
        of: screenshotInsetFinder,
        matching: find.byType(LtrSanctuary),
      );
      expect(ltrSanctuaryFinder, findsOneWidget);

      final imageFinder = find.descendant(
        of: ltrSanctuaryFinder,
        matching: find.byType(Image),
      );
      expect(imageFinder, findsOneWidget);
      expect(
        Directionality.of(tester.element(imageFinder)),
        TextDirection.ltr,
      );
    });
  });
}
