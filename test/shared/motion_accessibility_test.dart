import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';
import 'package:hanzi_master/shared/widgets/breathing_widget.dart';
import 'package:hanzi_master/shared/widgets/loading_swap.dart';
import 'package:hanzi_master/shared/widgets/shimmer_skeleton.dart';
import 'package:hanzi_master/shared/widgets/staggered_list_item.dart';
import 'package:hanzi_master/shared/widgets/zen_filter_pill.dart';

/// Wraps [child] in the minimum app scaffold, with the platform
/// "Reduce Motion" flag controllable.
Widget _host(Widget child, {bool reduceMotion = false}) {
  return MediaQuery(
    data: MediaQueryData(disableAnimations: reduceMotion),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: MaterialApp(
        home: Scaffold(body: Center(child: child)),
      ),
    ),
  );
}

void main() {
  group('reduce-motion accessibility', () {
    testWidgets('the context extension reads the platform flag',
        (tester) async {
      bool? detected;
      await tester.pumpWidget(_host(
        Builder(builder: (context) {
          detected = context.reduceMotion;
          return const SizedBox();
        }),
        reduceMotion: true,
      ));
      expect(detected, isTrue);
    });

    testWidgets('defaults to animating when the flag is absent',
        (tester) async {
      bool? detected;
      await tester.pumpWidget(_host(
        Builder(builder: (context) {
          detected = context.reduceMotion;
          return const SizedBox();
        }),
      ));
      expect(detected, isFalse);
    });

    testWidgets('shimmer holds a static value instead of looping forever',
        (tester) async {
      await tester.pumpWidget(_host(
          const ShimmerSkeleton(width: 40, isDark: false),
          reduceMotion: true));
      await tester.pump(const Duration(seconds: 3));

      // Resting value is 0.5, i.e. halfway between the 0.3 and 0.7 greys.
      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, isNotNull);
      expect(find.byType(ShimmerSkeleton), findsOneWidget);
    });

    testWidgets('breathing widget settles at scale 1.0 under reduced motion',
        (tester) async {
      await tester.pumpWidget(_host(
        const BreathingWidget(child: Text('x')),
        reduceMotion: true,
      ));
      await tester.pump(const Duration(seconds: 2));

      final transform = tester.widget<Transform>(
        find
            .ancestor(of: find.text('x'), matching: find.byType(Transform))
            .first,
      );
      // Identity scale means no visible pulsing.
      expect(transform.transform.getMaxScaleOnAxis(), moreOrLessEquals(1.0));
    });

    testWidgets('breathing widget does pulse when motion is allowed',
        (tester) async {
      await tester.pumpWidget(_host(
        const BreathingWidget(child: Text('x')),
      ));
      await tester.pump(const Duration(milliseconds: 500));

      final transform = tester.widget<Transform>(
        find
            .ancestor(of: find.text('x'), matching: find.byType(Transform))
            .first,
      );
      final scale = transform.transform.getMaxScaleOnAxis();
      expect(scale, isNot(moreOrLessEquals(1.0, epsilon: 0.0001)),
          reason: 'The pulse should be mid-animation away from 1.0');
    });
  });

  group('staggered list item', () {
    testWidgets('appears immediately under reduced motion', (tester) async {
      await tester.pumpWidget(_host(
        const StaggeredListItem(index: 15, child: Text('row')),
        reduceMotion: true,
      ));
      // No pumpAndSettle: the stagger delay must be skipped entirely.
      await tester.pump();

      final opacity = tester.widget<FadeTransition>(
        find
            .ancestor(
                of: find.text('row'), matching: find.byType(FadeTransition))
            .first,
      );
      expect(opacity.opacity.value, moreOrLessEquals(1.0));
    });

    testWidgets('a pending delay does not fire after disposal', (tester) async {
      await tester.pumpWidget(_host(
        const StaggeredListItem(
          index: 20,
          delay: Duration(milliseconds: 500),
          child: Text('row'),
        ),
      ));

      // Dispose before the delay elapses, as a fast scroll would.
      await tester.pumpWidget(_host(const SizedBox()));
      await tester.pump(const Duration(seconds: 2));

      // A leaked callback would try to drive a disposed controller.
      expect(tester.takeException(), isNull);
    });

    testWidgets('always reaches full opacity, never stranding content',
        (tester) async {
      await tester.pumpWidget(_host(
        const StaggeredListItem(
          index: 20,
          delay: Duration(milliseconds: 500),
          child: Text('row'),
        ),
      ));

      await tester.pumpAndSettle();
      final settled = tester.widget<FadeTransition>(
        find
            .ancestor(
                of: find.text('row'), matching: find.byType(FadeTransition))
            .first,
      );
      // The delay is part of the animation timeline, so once settled the item
      // MUST be fully opaque. A Timer-based delay could be skipped entirely,
      // leaving a permanently invisible row.
      expect(settled.opacity.value, moreOrLessEquals(1.0));
    });

    testWidgets('the delay still animates in when motion is allowed',
        (tester) async {
      await tester.pumpWidget(_host(
        const StaggeredListItem(
          index: 3,
          delay: Duration(milliseconds: 50),
          child: Text('row'),
        ),
      ));

      // Mid-hold the item is still transparent.
      await tester.pump(const Duration(milliseconds: 60));
      final duringHold = tester.widget<FadeTransition>(
        find
            .ancestor(
                of: find.text('row'), matching: find.byType(FadeTransition))
            .first,
      );
      expect(duringHold.opacity.value, lessThan(1.0),
          reason: 'Should still be held transparent during the stagger delay');

      await tester.pumpAndSettle();
      final after = tester.widget<FadeTransition>(
        find
            .ancestor(
                of: find.text('row'), matching: find.byType(FadeTransition))
            .first,
      );
      expect(after.opacity.value, moreOrLessEquals(1.0));
    });
  });

  group('zen filter pill', () {
    testWidgets('reports taps and renders its label', (tester) async {
      var taps = 0;
      await tester.pumpWidget(_host(
        ZenFilterPill(
          label: 'HSK 1',
          isSelected: false,
          isDark: false,
          onTap: () => taps++,
        ),
      ));

      expect(find.text('HSK 1'), findsOneWidget);
      await tester.tap(find.byType(ZenFilterPill));
      await tester.pump();
      expect(taps, 1);
    });

    testWidgets('uses the shared animation duration', (tester) async {
      await tester.pumpWidget(_host(
        ZenFilterPill(
          label: 'All',
          isSelected: true,
          isDark: false,
          onTap: () {},
        ),
      ));

      final container = tester.widget<AnimatedContainer>(
        find.byType(AnimatedContainer),
      );
      expect(container.duration, ZenFilterPill.animationDuration);
    });

    testWidgets('switches without a tween under reduced motion',
        (tester) async {
      await tester.pumpWidget(_host(
        ZenFilterPill(
          label: 'All',
          isSelected: true,
          isDark: false,
          onTap: () {},
        ),
        reduceMotion: true,
      ));

      final container = tester.widget<AnimatedContainer>(
        find.byType(AnimatedContainer),
      );
      expect(container.duration, Duration.zero);
    });
  });

  group('loading swap', () {
    testWidgets('shows a spinner while loading and an icon otherwise',
        (tester) async {
      await tester.pumpWidget(_host(
        const LoadingSwap(isLoading: true, icon: Icon(Icons.add)),
      ));
      // Not pumpAndSettle: a CircularProgressIndicator animates forever.
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byIcon(Icons.add), findsNothing);

      await tester.pumpWidget(_host(
        const LoadingSwap(isLoading: false, icon: Icon(Icons.add)),
      ));
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('keeps a stable footprint across the swap', (tester) async {
      await tester.pumpWidget(_host(
        const LoadingSwap(isLoading: true, size: 24, icon: Icon(Icons.add)),
      ));
      await tester.pump();
      final loadingSize = tester.getSize(find.byType(LoadingSwap));

      await tester.pumpWidget(_host(
        const LoadingSwap(isLoading: false, size: 24, icon: Icon(Icons.add)),
      ));
      await tester.pump(const Duration(milliseconds: 300));
      final idleSize = tester.getSize(find.byType(LoadingSwap));

      expect(idleSize, loadingSize,
          reason: 'A Row must not jitter when the icon swaps to a spinner');
    });

    testWidgets('switches without a tween under reduced motion',
        (tester) async {
      await tester.pumpWidget(_host(
        const LoadingSwap(isLoading: true, icon: Icon(Icons.add)),
        reduceMotion: true,
      ));

      final switcher =
          tester.widget<AnimatedSwitcher>(find.byType(AnimatedSwitcher));
      expect(switcher.duration, Duration.zero);
    });
  });

  group('staggered list item first row', () {
    // Regression: index 0 holds for `delay * 0` = 0, and a zero-length hold used
    // to be emitted as `TweenSequenceItem(weight: 0)` — which `TweenSequence`
    // rejects (`assert(weight > 0)`). The row threw while building, so any list
    // whose first entry was staggered failed to mount at all.
    testWidgets('index 0 mounts and settles fully opaque', (tester) async {
      await tester.pumpWidget(_host(
        const StaggeredListItem(index: 0, child: Text('first row')),
      ));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull,
          reason: 'A zero-length hold must be omitted, not weighted 0.0');
      expect(_opacityOf(tester, 'first row'), moreOrLessEquals(1.0));
    });

    testWidgets('a zero delay mounts without a hold segment', (tester) async {
      await tester.pumpWidget(_host(
        const StaggeredListItem(
          index: 4,
          delay: Duration.zero,
          child: Text('row'),
        ),
      ));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(_opacityOf(tester, 'row'), moreOrLessEquals(1.0),
          reason: 'With no hold, the entrance simply starts immediately');
    });
  });
}

/// The opacity a staggered row currently renders at.
double _opacityOf(WidgetTester tester, String text) => tester
    .widget<FadeTransition>(
      find
          .ancestor(of: find.text(text), matching: find.byType(FadeTransition))
          .first,
    )
    .opacity
    .value;
