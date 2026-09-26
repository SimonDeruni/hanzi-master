/// Apple Pencil behaviour of [DrawingCanvas] (Part 2b of
/// `docs/IPAD_ADAPTIVE_PLAN.md`).
///
/// The three stylus features are deliberately *inert without a stylus*, so these
/// tests also assert the phone guarantee: a touch drag behaves exactly as before.
@Tags(<String>['ipad-sweep'])
library;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/drawing_canvas.dart';

/// A single stroke whose SVG parses, so the canvas runs its real (non-scratchpad)
/// drawing path with a reference stroke to grade against.
const List<String> _strokePaths = <String>['M 200 200 L 800 800'];

Future<ValueNotifier<List<Offset?>>> _pumpCanvas(WidgetTester tester) async {
  final ValueNotifier<List<Offset?>> points =
      ValueNotifier<List<Offset?>>(<Offset?>[]);
  addTearDown(points.dispose);
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 400,
            height: 400,
            child: DrawingCanvas(
              strokePaths: _strokePaths,
              showAnimation: false,
              userPointsNotifier: points,
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return points;
}

int _drawnPoints(ValueNotifier<List<Offset?>> points) =>
    points.value.whereType<Offset>().length;

void main() {
  testWidgets('a stylus stroke draws', (WidgetTester tester) async {
    final ValueNotifier<List<Offset?>> points = await _pumpCanvas(tester);
    final Offset centre = tester.getCenter(find.byType(DrawingCanvas));

    final TestGesture stylus = await tester.startGesture(
      centre,
      kind: PointerDeviceKind.stylus,
      pointer: 7,
    );
    await tester.pump(const Duration(milliseconds: 16));
    await stylus.moveBy(const Offset(30, 20));
    await tester.pump(const Duration(milliseconds: 16));
    await stylus.moveBy(const Offset(30, 20));
    await tester.pump(const Duration(milliseconds: 16));
    await stylus.up();
    await tester.pumpAndSettle();

    expect(
      _drawnPoints(points),
      greaterThan(1),
      reason: 'a Pencil stroke must register like any other stroke',
    );
  });

  testWidgets('a touch drag still draws when no stylus is present',
      (WidgetTester tester) async {
    final ValueNotifier<List<Offset?>> points = await _pumpCanvas(tester);
    final Offset centre = tester.getCenter(find.byType(DrawingCanvas));

    final TestGesture finger = await tester.startGesture(centre, pointer: 3);
    await tester.pump(const Duration(milliseconds: 16));
    await finger.moveBy(const Offset(30, 20));
    await tester.pump(const Duration(milliseconds: 16));
    await finger.up();
    await tester.pumpAndSettle();

    expect(
      _drawnPoints(points),
      greaterThan(1),
      reason: 'the phone behaviour must not change',
    );
  });

  testWidgets('a palm is rejected while the Pencil is down',
      (WidgetTester tester) async {
    final ValueNotifier<List<Offset?>> points = await _pumpCanvas(tester);
    final Offset centre = tester.getCenter(find.byType(DrawingCanvas));

    // Pencil down and held.
    final TestGesture stylus = await tester.startGesture(
      centre - const Offset(60, 0),
      kind: PointerDeviceKind.stylus,
      pointer: 11,
    );
    await tester.pump(const Duration(milliseconds: 16));
    await stylus.moveBy(const Offset(40, 0));
    await tester.pump(const Duration(milliseconds: 16));
    final int afterStylus = _drawnPoints(points);
    expect(afterStylus, greaterThan(1));

    // Palm (a plain touch) lands and drags while the Pencil is still down.
    final TestGesture palm = await tester.startGesture(
      centre + const Offset(60, 0),
      pointer: 12,
    );
    await tester.pump(const Duration(milliseconds: 16));
    await palm.moveBy(const Offset(0, 40));
    await tester.pump(const Duration(milliseconds: 16));
    await palm.moveBy(const Offset(0, 40));
    await tester.pump(const Duration(milliseconds: 16));

    expect(
      _drawnPoints(points),
      afterStylus,
      reason: 'the palm must not add points while the stylus is down',
    );

    await palm.up();
    await stylus.up();
    await tester.pumpAndSettle();
  });

  testWidgets('turning the stylus features off restores plain touch handling',
      (WidgetTester tester) async {
    final ValueNotifier<List<Offset?>> points =
        ValueNotifier<List<Offset?>>(<Offset?>[]);
    addTearDown(points.dispose);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 400,
              height: 400,
              child: DrawingCanvas(
                strokePaths: _strokePaths,
                showAnimation: false,
                userPointsNotifier: points,
                stylusInput: false,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final Offset centre = tester.getCenter(find.byType(DrawingCanvas));
    final TestGesture stylus = await tester.startGesture(
      centre,
      kind: PointerDeviceKind.stylus,
      pointer: 21,
    );
    await tester.pump(const Duration(milliseconds: 16));
    await stylus.moveBy(const Offset(30, 20));
    await tester.pump(const Duration(milliseconds: 16));
    await stylus.up();
    await tester.pumpAndSettle();

    expect(
      _drawnPoints(points),
      greaterThan(1),
      reason:
          'with stylusInput: false the canvas keeps drawing from any pointer',
    );
  });
}
