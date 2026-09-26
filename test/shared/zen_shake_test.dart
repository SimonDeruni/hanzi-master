import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/widgets/zen_shake.dart';

/// Hosts [child] with the platform "Reduce Motion" flag controllable.
Widget _host(Widget child, {bool reduceMotion = false}) => MaterialApp(
      builder: (BuildContext context, Widget? inner) => MediaQuery(
        data: MediaQuery.of(context).copyWith(disableAnimations: reduceMotion),
        child: inner!,
      ),
      home: Scaffold(body: Center(child: child)),
    );

/// Drives a [ZenShake] the way a rejection screen does: a counter it can bump
/// and drop, plus a fixed-size surface to measure.
///
/// The trigger is driven through a [GlobalKey] rather than a `TextButton`,
/// because tapping a button starts an ink ripple — and every "no animation is
/// running" assertion below would then be measuring the ripple, not the shake.
class _Harness extends StatefulWidget {
  const _Harness({super.key});

  @override
  State<_Harness> createState() => _HarnessState();
}

class _HarnessState extends State<_Harness> {
  int _trigger = 0;

  void bump() => setState(() => _trigger++);

  void drop() => setState(() => _trigger = 0);

  @override
  Widget build(BuildContext context) => ZenShake(
        trigger: _trigger,
        child: const SizedBox(
          key: ValueKey<String>('surface'),
          width: 40,
          height: 40,
        ),
      );
}

double _surfaceLeft(WidgetTester tester) =>
    tester.getTopLeft(find.byKey(const ValueKey<String>('surface'))).dx;

void main() {
  testWidgets('an increased trigger shakes the surface',
      (WidgetTester tester) async {
    final GlobalKey<_HarnessState> harness = GlobalKey<_HarnessState>();
    await tester.pumpWidget(_host(_Harness(key: harness)));
    final double rest = _surfaceLeft(tester);

    harness.currentState!.bump();
    await tester.pump();
    await tester.pump(ZenMotion.shake ~/ 4);

    expect(
      _surfaceLeft(tester),
      isNot(closeTo(rest, 0.5)),
      reason: 'the rejection must actually travel, not just recolour',
    );
  });

  testWidgets('the shake settles back to its exact rest position',
      (WidgetTester tester) async {
    final GlobalKey<_HarnessState> harness = GlobalKey<_HarnessState>();
    await tester.pumpWidget(_host(_Harness(key: harness)));
    final double rest = _surfaceLeft(tester);

    harness.currentState!.bump();
    await tester.pumpAndSettle();

    expect(_surfaceLeft(tester), closeTo(rest, 0.01));
    expect(tester.binding.transientCallbackCount, 0);
  });

  testWidgets('dropping the trigger back to rest is silent',
      (WidgetTester tester) async {
    final GlobalKey<_HarnessState> harness = GlobalKey<_HarnessState>();
    await tester.pumpWidget(_host(_Harness(key: harness)));
    final double rest = _surfaceLeft(tester);

    harness.currentState!.bump();
    await tester.pumpAndSettle();

    // A tile that stops being the rejected one falls back to 0; that must not
    // replay the shake on the tile that is no longer guilty.
    harness.currentState!.drop();
    await tester.pump();

    expect(_surfaceLeft(tester), closeTo(rest, 0.01));
    expect(tester.binding.transientCallbackCount, 0);
  });

  testWidgets('reduce motion drops the travel entirely',
      (WidgetTester tester) async {
    final GlobalKey<_HarnessState> harness = GlobalKey<_HarnessState>();
    await tester.pumpWidget(_host(_Harness(key: harness), reduceMotion: true));
    final double rest = _surfaceLeft(tester);

    harness.currentState!.bump();
    await tester.pump();
    await tester.pump(ZenMotion.shake ~/ 2);

    expect(_surfaceLeft(tester), closeTo(rest, 0.01));
    expect(tester.binding.transientCallbackCount, 0);
  });
}
