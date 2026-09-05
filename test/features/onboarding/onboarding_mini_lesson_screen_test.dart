import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/drawing_canvas.dart';
import 'package:hanzi_master/features/onboarding/presentation/screens/onboarding_mini_lesson_screen.dart';

void main() {
  testWidgets('quiet path completes all five preview steps', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    var completed = false;
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: OnboardingMiniLessonScreen(
            disableExternalServicesForTesting: true,
            onComplete: () => completed = true,
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Audiobook Reader'), findsOneWidget);
    await tester.ensureVisible(find.text('Next: Shadow this sentence →'));
    await tester.tap(find.text('Next: Shadow this sentence →'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Shadowing & Tones'), findsOneWidget);

    await tester.ensureVisible(find.text("I can't speak right now (Try tone demo)"));
    await tester.tap(find.text("I can't speak right now (Try tone demo)"));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Tone Pitch Contour Evaluation'), findsOneWidget);

    await tester.ensureVisible(find.text('Next: Explore Chinese Web →'));
    await tester.tap(find.text('Next: Explore Chinese Web →'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Web Explorer'), findsOneWidget);

    await tester.ensureVisible(find.text('Next: Discuss with AI Tutor →'));
    await tester.tap(find.text('Next: Discuss with AI Tutor →'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('AI Voice Roleplay'), findsOneWidget);

    await tester.ensureVisible(find.text('Next: Practice Handwriting →'));
    await tester.tap(find.text('Next: Practice Handwriting →'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Guided Handwriting'), findsOneWidget);

    await tester.ensureVisible(find.text('See Your Personalized Plan →'));
    await tester.tap(find.text('See Your Personalized Plan →'));
    await tester.pump(const Duration(milliseconds: 300));
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
  });
}
