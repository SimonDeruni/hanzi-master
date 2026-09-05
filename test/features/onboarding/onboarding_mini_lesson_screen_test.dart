import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/drawing_canvas.dart';
import 'package:hanzi_master/features/onboarding/presentation/screens/onboarding_mini_lesson_screen.dart';

void main() {
  testWidgets('quiet path completes all six preview steps', (tester) async {
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
    await tester.pumpAndSettle();

    expect(find.text('Listen'), findsOneWidget);
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Notice'), findsOneWidget);

    await tester.tap(find.text('Shadow one sentence'));
    await tester.pumpAndSettle();
    expect(find.text('Shadow'), findsOneWidget);
    expect(find.text("I can't speak right now"), findsOneWidget);

    await tester.tap(find.text("I can't speak right now"));
    await tester.pumpAndSettle();
    expect(find.text('Four tones'), findsOneWidget);
    expect(find.text('You: 2  ·  Target: 3'), findsOneWidget);

    await tester.tap(find.text('Try handwriting'));
    await tester.pumpAndSettle();
    expect(find.text('Write'), findsOneWidget);

    await tester.tap(find.text('See what you learned'));
    await tester.pumpAndSettle();
    expect(find.text('Recap'), findsOneWidget);
    expect(find.text('Compared Mandarin tones'), findsOneWidget);

    await tester.tap(find.text('Continue'));
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
    expect(practiceCanvas.showControls, isTrue);
    expect(practiceCanvas.showGrade, isTrue);
    expect(find.byType(CalligraphyBackground), findsOneWidget);
    expect(
      tester.widget<AspectRatio>(find.byType(AspectRatio).first).aspectRatio,
      1,
    );
  });
}
