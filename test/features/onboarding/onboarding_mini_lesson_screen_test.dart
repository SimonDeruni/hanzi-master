import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/core/services/audio_recording_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/drawing_canvas.dart';
import 'package:hanzi_master/features/onboarding/presentation/screens/onboarding_mini_lesson_screen.dart';
import 'package:hanzi_master/features/onboarding/presentation/onboarding_design.dart';
import 'package:hanzi_master/shared/widgets/ai_consent_sheet.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  testWidgets('quiet path completes all six preview steps', (tester) async {
    var completed = false;
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: OnboardingMiniLessonScreen(
            disableExternalServicesForTesting: true,
            onComplete: () => completed = true,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Listen'), findsOneWidget);
    expect(find.byKey(const Key('onboarding_lesson_eyebrow')), findsOneWidget);
    expect(find.text('YOUR FIRST LESSON  •  1 OF 6'), findsOneWidget);
    expect(find.byKey(const Key('onboarding_lesson_progress')), findsOneWidget);
    expect(
      tester.getTopLeft(find.text('Listen')).dx,
      OnboardingDesign.horizontalPadding,
    );
    expect(
      tester.widget<Text>(find.text('Listen')).style?.fontSize,
      OnboardingDesign.titleFontSize,
    );
    expect(
      tester.getSize(find.byKey(const Key('onboarding_primary_button'))).height,
      OnboardingDesign.primaryButtonHeight,
    );
    expect(find.bySemanticsLabel('知彼知己者，百战不殆。'), findsOneWidget);
    expect(find.text('《孙子兵法》'), findsOneWidget);
    expect(find.text('The Art of War · Sun Tzu'), findsOneWidget);
    expect(find.byKey(const Key('onboarding_listen_card')), findsOneWidget);
    await tester.ensureVisible(find.text('Continue'));
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Notice'), findsOneWidget);
    expect(find.text('YOUR FIRST LESSON  •  2 OF 6'), findsOneWidget);
    expect(find.text('zhī bǐ zhī jǐ zhě'), findsOneWidget);
    expect(find.text('YOU’LL PRACTICE THIS'), findsOneWidget);
    expect(find.byKey(const Key('onboarding_notice_card')), findsOneWidget);

    await tester.ensureVisible(find.text('Shadow one sentence'));
    await tester.tap(find.text('Shadow one sentence'));
    await tester.pumpAndSettle();
    expect(find.text('Shadow'), findsOneWidget);
    expect(find.bySemanticsLabel('百战不殆。'), findsOneWidget);
    expect(find.text('bǎi zhàn bù dài'), findsOneWidget);
    expect(find.byKey(const Key('onboarding_shadow_card')), findsOneWidget);
    expect(find.text("I can't speak right now"), findsNothing);

    // Tap Continue to proceed to recording
    await tester.ensureVisible(find.text('Continue'));
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Tap Stop and check my tones to finish shadowing
    expect(find.text('Stop and check my tones'), findsOneWidget);
    expect(find.text("I can't speak right now"), findsOneWidget);
    await tester.ensureVisible(find.text('Stop and check my tones'));
    await tester.tap(find.text('Stop and check my tones'));
    await tester.pumpAndSettle();
    expect(find.text('Four tones'), findsOneWidget);
    expect(
        find.byKey(const Key('onboarding_tone_results_card')), findsOneWidget);
    expect(find.byKey(const Key('onboarding_overall_score_banner')),
        findsOneWidget);
    expect(find.text('Score: 82/100'), findsOneWidget);
    expect(find.text('Great job! A few minor tone inaccuracies.'), findsOneWidget);
    expect(find.text('You: tone 2 · rising  ·  Target: tone 4 · falling'),
        findsOneWidget);
    expect(find.text('Compare tones'), findsOneWidget);

    await tester.ensureVisible(find.text('Try handwriting'));
    await tester.tap(find.text('Try handwriting'));
    await tester.pumpAndSettle();
    expect(find.text('Write'), findsOneWidget);

    await tester.ensureVisible(find.text('See what you learned'));
    await tester.tap(find.text('See what you learned'));
    await tester.pumpAndSettle();
    expect(find.text('Recap'), findsOneWidget);
    expect(find.text('Compared Mandarin tones'), findsOneWidget);

    await tester.ensureVisible(find.text('Continue'));
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(completed, isTrue);
  });

  testWidgets('handwriting preview uses the guided practice canvas',
      (tester) async {
    const strokes = ['M 0 0 L 100 100'];
    const medians = [
      [Offset.zero, Offset(100, 100)],
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox.square(
            dimension: 310,
            child: OnboardingPracticeCanvas(
              strokePaths: strokes,
              medianPaths: medians,
              currentStrokeIndex: 0,
              onStrokeComplete: () {},
            ),
          ),
        ),
      ),
    );

    final practiceCanvas = tester.widget<DrawingCanvas>(
      find.byKey(const ValueKey('onboardingPracticeCanvas')),
    );
    expect(practiceCanvas.strokePaths, strokes);
    expect(practiceCanvas.medianPaths, medians);
    expect(practiceCanvas.showReference, isTrue);
    expect(practiceCanvas.showGuideLines, isTrue);
    expect(practiceCanvas.strokeByStrokeMode, isTrue);
    expect(practiceCanvas.currentStrokeIndex, 0);
    expect(practiceCanvas.showAnimation, isFalse);
    expect(practiceCanvas.showControls, isFalse);
    expect(practiceCanvas.showGrade, isFalse);
    expect(find.byType(CalligraphyBackground), findsOneWidget);
    expect(
      tester.widget<AspectRatio>(find.byType(AspectRatio).first).aspectRatio,
      1,
    );
  });

  testWidgets('spoken character is visually highlighted', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: OnboardingSpeakingText(
            text: '我打开窗户。',
            activeIndex: 2,
            color: Colors.black,
            fontSize: 34,
          ),
        ),
      ),
    );

    final active = tester.widget<AnimatedContainer>(
      find.byKey(const ValueKey('onboarding_spoken_character_2')),
    );
    final inactive = tester.widget<AnimatedContainer>(
      find.byKey(const ValueKey('onboarding_spoken_character_1')),
    );
    final activeDecoration = active.decoration! as BoxDecoration;
    final inactiveDecoration = inactive.decoration! as BoxDecoration;

    expect(activeDecoration.color, isNot(Colors.transparent));
    expect(activeDecoration.boxShadow, isNotEmpty);
    expect(inactiveDecoration.color, Colors.transparent);
    expect(inactiveDecoration.boxShadow, isNull);
  });

  testWidgets(
      'microphone permission denial displays notification, settings link, and allows continuing',
      (tester) async {
    SharedPreferences.setMockInitialValues({
      AiConsentSheet.prefKey: true,
    });
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          audioRecordingServiceProvider.overrideWithValue(
            _FakeDeniedAudioRecordingService(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: OnboardingMiniLessonScreen(
            disableExternalServicesForTesting: false,
            onComplete: () {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Step 0 -> Step 1
    await tester.ensureVisible(find.text('Continue'));
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Step 1 -> Step 2
    await tester.ensureVisible(find.text('Shadow one sentence'));
    await tester.tap(find.text('Shadow one sentence'));
    await tester.pumpAndSettle();

    // Step 2: Ensure pre-permission screen only has "Continue" and NO "I can't speak now" or "Use microphone"
    expect(find.text('Continue'), findsOneWidget);
    expect(find.text("I can't speak right now"), findsNothing);
    expect(find.text('Use microphone'), findsNothing);

    // Tap Continue to request microphone permission
    await tester.ensureVisible(find.text('Continue'));
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // After denial: displays notification that microphone access was not granted and Settings link
    expect(find.text('Microphone access was not granted. You can enable it in Settings.'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);

    // Tapping Continue gracefully advances forward to Four Tones using quiet demo path
    await tester.ensureVisible(find.text('Continue'));
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.text('Four tones'), findsOneWidget);
  });

  testWidgets(
      'shadowing step allows skipping via "I can\'t speak right now" after tapping continue',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: OnboardingMiniLessonScreen(
            disableExternalServicesForTesting: true,
            onComplete: () {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Step 0 -> Step 1
    await tester.ensureVisible(find.text('Continue'));
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Step 1 -> Step 2
    await tester.ensureVisible(find.text('Shadow one sentence'));
    await tester.tap(find.text('Shadow one sentence'));
    await tester.pumpAndSettle();

    // Pre-continue: skip button is not shown
    expect(find.text("I can't speak right now"), findsNothing);

    // Tap Continue -> AI consent / recording mode
    await tester.ensureVisible(find.text('Continue'));
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Skip button is now visible
    expect(find.text("I can't speak right now"), findsOneWidget);

    // Tapping skip immediately advances to Four Tones
    await tester.ensureVisible(find.text("I can't speak right now"));
    await tester.tap(find.text("I can't speak right now"));
    await tester.pumpAndSettle();

    expect(find.text('Four tones'), findsOneWidget);
  });

  testWidgets(
      'AI consent sheet is presented before microphone permission request',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    var permissionRequested = false;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          audioRecordingServiceProvider.overrideWithValue(
            _SpyAudioRecordingService(onRequestPermission: () {
              permissionRequested = true;
            }),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: OnboardingMiniLessonScreen(
            disableExternalServicesForTesting: false,
            onComplete: () {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Step 0 -> Step 1
    await tester.ensureVisible(find.text('Continue'));
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // Step 1 -> Step 2
    await tester.ensureVisible(find.text('Shadow one sentence'));
    await tester.tap(find.text('Shadow one sentence'));
    await tester.pumpAndSettle();

    // Tap Continue on Step 2
    await tester.ensureVisible(find.text('Continue'));
    await tester.tap(find.text('Continue'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // Consent sheet is shown FIRST; mic permission has NOT been requested yet!
    expect(find.byType(AiConsentSheet), findsOneWidget);
    expect(permissionRequested, isFalse);

    // Agree to AI
    final agreeButton = find.text('Agree to Use AI');
    expect(agreeButton, findsOneWidget);
    await tester.tap(agreeButton);
    await tester.pumpAndSettle();

    // After agreeing, microphone permission is requested SECOND!
    expect(permissionRequested, isTrue);
  });
}

class _FakeDeniedAudioRecordingService extends AudioRecordingService {
  @override
  Future<bool> requestPermission() async => false;
}

class _SpyAudioRecordingService extends AudioRecordingService {
  _SpyAudioRecordingService({required this.onRequestPermission});
  final VoidCallback onRequestPermission;

  @override
  Future<bool> requestPermission() async {
    onRequestPermission();
    return true;
  }

  @override
  Future<void> startRecording(String filename) async {}

  @override
  Future<String?> stopRecording() async => null;
}
