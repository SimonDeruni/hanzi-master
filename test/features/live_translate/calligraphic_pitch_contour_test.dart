import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/features/live_translate/presentation/widgets/calligraphic_pitch_contour.dart';

/// Hosts [child] with the platform "Reduce Motion" flag controllable.
///
/// The override is applied through `MaterialApp.builder` rather than wrapping
/// the whole app: `MaterialApp` installs its own `MediaQuery`, so an outer one
/// would be discarded and the flag would silently read as false.
Widget _host(Widget child, {bool reduceMotion = false}) => MaterialApp(
      builder: (BuildContext context, Widget? inner) => MediaQuery(
        data: MediaQuery.of(context).copyWith(disableAnimations: reduceMotion),
        child: inner!,
      ),
      home: Scaffold(body: Center(child: child)),
    );

/// Number of non-transparent pixels painted inside the boundary at [key].
Future<int> _inkedPixels(WidgetTester tester, Key key) async {
  final RenderRepaintBoundary boundary =
      tester.renderObject<RenderRepaintBoundary>(find.byKey(key));
  late int inked;
  await tester.runAsync(() async {
    final ui.Image image = await boundary.toImage();
    final ByteData? data =
        await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    inked = 0;
    for (int i = 3; i < data!.lengthInBytes; i += 4) {
      if (data.getUint8(i) > 0) inked++;
    }
    image.dispose();
  });
  return inked;
}

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

  group('the contour draws itself', () {
    testWidgets('the reveal really runs on mount, then settles',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _host(const CalligraphicPitchContour(expectedTone: 2, actualTone: 2)),
      );

      expect(
        tester.binding.transientCallbackCount,
        greaterThan(0),
        reason: 'The brush must be tracing, not showing a finished contour',
      );

      await tester.pumpAndSettle();
      expect(tester.binding.transientCallbackCount, 0);
    });

    testWidgets('every painted frame of the trace is exception free',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _host(const CalligraphicPitchContour(expectedTone: 3, actualTone: 4)),
      );

      for (int frame = 0; frame < 6; frame++) {
        await tester.pump(ZenMotion.quick ~/ 6);
        expect(tester.takeException(), isNull);
      }

      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });

    testWidgets('reduce motion paints the finished contour with no ticker',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _host(
          const CalligraphicPitchContour(expectedTone: 4, actualTone: 4),
          reduceMotion: true,
        ),
      );

      // Checked on the very first frame: no ticker may ever have been started.
      expect(tester.binding.transientCallbackCount, 0);
      expect(tester.takeException(), isNull);

      await tester.pump(ZenMotion.quick);
      expect(tester.binding.transientCallbackCount, 0);
    });

    testWidgets('a streaming update with the same contour does not replay',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _host(const CalligraphicPitchContour(expectedTone: 3, actualTone: 3)),
      );
      await tester.pumpAndSettle();
      expect(tester.binding.transientCallbackCount, 0);

      // The parent streams the same contour back (a rebuild that also re-laid
      // the sheet out); the settled stroke must stay settled.
      await tester.pumpWidget(
        _host(
          const CalligraphicPitchContour(
            expectedTone: 3,
            actualTone: 3,
            height: 140,
          ),
        ),
      );

      expect(
        tester.binding.transientCallbackCount,
        0,
        reason: 'An identical contour must not restart the reveal',
      );
    });

    testWidgets('a mid-flight streaming update lets the stroke finish',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _host(const CalligraphicPitchContour(expectedTone: 2, actualTone: 2)),
      );

      // One third of the way in: the stroke is still being laid down.
      await tester.pump(ZenMotion.quick ~/ 3);
      expect(tester.binding.transientCallbackCount, greaterThan(0));

      await tester.pumpWidget(
        _host(const CalligraphicPitchContour(expectedTone: 2, actualTone: 2)),
      );
      expect(tester.binding.transientCallbackCount, greaterThan(0));

      // 100ms + 260ms = 360ms since mount, past the 300ms reveal. A restarted
      // stroke would still be running; an untouched one has settled.
      await tester.pump(ZenMotion.tap * 2);
      expect(
        tester.binding.transientCallbackCount,
        0,
        reason: 'A streaming update must not reset the reveal mid-stroke',
      );
    });

    testWidgets('the ink really is partial while the brush is travelling',
        (WidgetTester tester) async {
      final Key key = UniqueKey();
      await tester.pumpWidget(
        _host(
          RepaintBoundary(
            key: key,
            child: const CalligraphicPitchContour(expectedTone: 1),
          ),
        ),
      );

      // A third of the way in only part of the contour may be inked.
      await tester.pump(ZenMotion.quick ~/ 3);
      final int partial = await _inkedPixels(tester, key);

      await tester.pumpAndSettle();
      final int complete = await _inkedPixels(tester, key);

      expect(
        partial,
        lessThan(complete),
        reason: 'the stroke must be drawn progressively, not pop in complete',
      );
      expect(partial, greaterThan(0), reason: 'the brush must have started');
    });

    testWidgets('a genuinely new contour replays the stroke',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _host(const CalligraphicPitchContour(expectedTone: 1, actualTone: 1)),
      );
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        _host(const CalligraphicPitchContour(expectedTone: 4, actualTone: 4)),
      );

      expect(tester.binding.transientCallbackCount, greaterThan(0));
      await tester.pumpAndSettle();
      expect(tester.binding.transientCallbackCount, 0);
    });
  });
}
