import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/widgets/zen_exit.dart';

/// Hosts [child] with the platform "Reduce Motion" flag controllable.
Widget _host(Widget child, {bool reduceMotion = false}) => MaterialApp(
      builder: (BuildContext context, Widget? inner) => MediaQuery(
        data: MediaQuery.of(context).copyWith(disableAnimations: reduceMotion),
        child: inner!,
      ),
      home: Scaffold(body: Center(child: child)),
    );

/// Drives a [ZenExit] the way a remove button does: a flag it can flip, and a
/// counter of how many times the removal was reported.
class _Harness extends StatefulWidget {
  const _Harness({super.key});

  @override
  State<_Harness> createState() => _HarnessState();
}

class _HarnessState extends State<_Harness> {
  bool _removing = false;
  int removed = 0;

  /// Flips the row to "leaving" without a tap — tapping a button would start an
  /// ink ripple and pollute `transientCallbackCount`.
  void remove() => setState(() => _removing = true);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ZenExit(
            key: const ValueKey<String>('exit'),
            removing: _removing,
            onRemoved: () => setState(() => removed++),
            child: const SizedBox(
              key: ValueKey<String>('row'),
              width: 120,
              height: 48,
            ),
          ),
          const SizedBox(height: 8),
          const Text('keeps the list below in place'),
        ],
      );
}

/// The row's live height as laid out by [ZenExit].
///
/// Measured on the `ZenExit` key rather than on `SizeTransition`: at rest (and
/// under reduce motion) the widget hands its child straight back, so there is no
/// `SizeTransition` in the tree to measure.
double _collapsedHeight(WidgetTester tester) =>
    tester.getSize(find.byKey(const ValueKey<String>('exit'))).height;

void main() {
  testWidgets('the row collapses as it leaves', (WidgetTester tester) async {
    final GlobalKey<_HarnessState> harness = GlobalKey<_HarnessState>();
    await tester.pumpWidget(_host(_Harness(key: harness)));

    expect(_collapsedHeight(tester), 48,
        reason: 'at rest the row is full size');

    harness.currentState!.remove();
    await tester.pump();
    await tester.pump(ZenMotion.exit ~/ 2);

    final double mid = _collapsedHeight(tester);
    expect(mid, lessThan(48));
    expect(mid, greaterThan(0), reason: 'mid-flight, not collapsed yet');
  });

  testWidgets('the removal is reported exactly once',
      (WidgetTester tester) async {
    final GlobalKey<_HarnessState> harness = GlobalKey<_HarnessState>();
    await tester.pumpWidget(_host(_Harness(key: harness)));

    harness.currentState!.remove();
    await tester.pumpAndSettle();

    expect(harness.currentState!.removed, 1);
    expect(_collapsedHeight(tester), lessThan(0.5),
        reason: 'the row ends fully collapsed');
  });

  testWidgets('a row that is never removed never reports',
      (WidgetTester tester) async {
    final GlobalKey<_HarnessState> harness = GlobalKey<_HarnessState>();
    await tester.pumpWidget(_host(_Harness(key: harness)));
    await tester.pump(const Duration(seconds: 1));

    expect(harness.currentState!.removed, 0);
    expect(_collapsedHeight(tester), 48);
  });

  testWidgets('reduce motion settles the data without any travel',
      (WidgetTester tester) async {
    final GlobalKey<_HarnessState> harness = GlobalKey<_HarnessState>();
    await tester.pumpWidget(_host(_Harness(key: harness), reduceMotion: true));

    harness.currentState!.remove();
    await tester.pump();
    await tester.pump();

    expect(harness.currentState!.removed, 1,
        reason: 'the caller must still be told to commit the removal');
    expect(_collapsedHeight(tester), 48,
        reason: 'no collapse under reduce motion');
    expect(tester.binding.transientCallbackCount, 0);
  });
}
