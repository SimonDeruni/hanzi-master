import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/live_translate/presentation/widgets/calligraphic_pitch_contour.dart';

void main() {
  testWidgets('CalligraphicPitchContour renders custom paint for tone 1 to 4',
      (tester) async {
    for (final tone in [1, 2, 3, 4]) {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CalligraphicPitchContour(
              expectedTone: tone,
              actualTone: tone,
              autoAnimate: false,
            ),
          ),
        ),
      );

      expect(find.byType(CustomPaint), findsWidgets);
    }
  });

  testWidgets('CalligraphicPitchContour renders compact mode',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CalligraphicPitchContour(
            expectedTone: 3,
            isCompact: true,
            autoAnimate: false,
          ),
        ),
      ),
    );

    expect(find.byType(CustomPaint), findsWidgets);
  });
}
