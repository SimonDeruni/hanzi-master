import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/core/theme/zen_ink_splash.dart';

/// Hosts [child] on a [Material], which is what an ink feature needs to exist.
Widget _host(Widget child, {ThemeData? theme}) => MaterialApp(
      theme: theme ?? AppTheme.lightTheme,
      home: Scaffold(body: Material(child: child)),
    );

const ValueKey<String> _surface = ValueKey<String>('surface');

/// A well rect, for the cases where the clip must be the well's, not the box's.
Rect _wellRect() => const Rect.fromLTWH(1, 2, 3, 4);

/// The [MaterialInkController] a bleed must be added to, plus the box it is
/// measured against. Captured from a live tree because the controller has no
/// public constructor.
Future<(MaterialInkController, RenderBox)> _captureLayer(
  WidgetTester tester,
) async {
  late MaterialInkController layer;
  await tester.pumpWidget(
    _host(
      Builder(
        builder: (BuildContext context) {
          layer = Material.of(context);
          return const SizedBox(key: _surface, width: 120, height: 48);
        },
      ),
    ),
  );
  return (layer, tester.renderObject<RenderBox>(find.byKey(_surface)));
}

/// A bleed built by hand, so the branches the live tree may not reach (custom
/// border, reduce motion) are covered deterministically.
ZenInkSplash _bleed(
  MaterialInkController layer,
  RenderBox box, {
  bool reduceMotion = false,
  RectCallback? rectCallback,
  BorderRadius? borderRadius,
  ShapeBorder? customBorder,
}) =>
    ZenInkSplash(
      controller: layer,
      referenceBox: box,
      position: const Offset(12, 12),
      ink: const Color(0x1A8B0000),
      targetRadius: 90,
      reduceMotion: reduceMotion,
      textDirection: TextDirection.ltr,
      containedInkWell: true,
      rectCallback: rectCallback,
      borderRadius: borderRadius,
      customBorder: customBorder,
    );

void main() {
  group('theme wiring', () {
    test("both themes bleed ink instead of Flutter's grey ripple", () {
      for (final ThemeData theme in <ThemeData>[
        AppTheme.lightTheme,
        AppTheme.darkTheme,
      ]) {
        expect(theme.splashFactory, isA<ZenInkSplashFactory>());
      }
    });

    test('the tint is cinnabar on paper and amber on ink', () {
      expect(AppTheme.lightTheme.splashColor, AppTheme.accentLight);
      expect(AppTheme.darkTheme.splashColor, AppTheme.accentDark);
    });
  });

  group('reach', () {
    testWidgets('measures to the furthest corner, not the nearest',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _host(const SizedBox(key: _surface, width: 100, height: 60)),
      );
      final RenderBox box = tester.renderObject<RenderBox>(find.byKey(_surface));

      expect(
        ZenInkSplashFactory.reachOf(box, null, Offset.zero),
        closeTo(math.sqrt(100 * 100 + 60 * 60), 0.01),
        reason: 'a touch in one corner must be able to soak to the far one',
      );
      expect(
        ZenInkSplashFactory.reachOf(box, null, const Offset(50, 30)),
        closeTo(math.sqrt(50 * 50 + 30 * 30), 0.01),
      );
    });

    testWidgets('a well rect wins over the whole box',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _host(const SizedBox(key: _surface, width: 100, height: 60)),
      );
      final RenderBox box = tester.renderObject<RenderBox>(find.byKey(_surface));

      expect(
        ZenInkSplashFactory.reachOf(
          box,
          () => const Rect.fromLTWH(0, 0, 10, 10),
          Offset.zero,
        ),
        closeTo(math.sqrt(200), 0.01),
      );
    });
  });

  group('clip', () {
    testWidgets('mirrors Flutter: the well wins, else the box, else open',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _host(const SizedBox(key: _surface, width: 80, height: 40)),
      );
      final RenderBox box = tester.renderObject<RenderBox>(find.byKey(_surface));
      expect(ZenInkSplashFactory.clipOf(box, true, _wellRect), isNotNull);
      expect(
        ZenInkSplashFactory.clipOf(box, true, _wellRect)!.call(),
        _wellRect(),
        reason: 'the well rect must win over the whole box',
      );
      expect(
        ZenInkSplashFactory.clipOf(box, true, null)!(),
        Offset.zero & const Size(80, 40),
      );
      expect(ZenInkSplashFactory.clipOf(box, false, null), isNull);
    });
  });

  group('painting', () {
    testWidgets('a tapped row bleeds, then removes itself',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _host(
          InkWell(
            onTap: () {},
            child: const SizedBox(key: _surface, width: 200, height: 56),
          ),
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 60));

      expect(
        tester.binding.transientCallbackCount,
        greaterThan(0),
        reason: 'the bleed must actually be running, not skipped',
      );
      expect(tester.takeException(), isNull);

      await tester.pumpAndSettle();

      expect(
        tester.binding.transientCallbackCount,
        0,
        reason: 'the ink must take itself out of the layer when it is done',
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('a cancelled gesture disposes without throwing',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _host(
          InkWell(
            onTap: () {},
            child: const SizedBox(key: _surface, width: 200, height: 56),
          ),
        ),
      );

      final TestGesture gesture =
          await tester.startGesture(tester.getCenter(find.byType(InkWell)));
      await tester.pump(const Duration(milliseconds: 40));
      await gesture.cancel();
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(tester.binding.transientCallbackCount, 0);
    });

    testWidgets('a rounded, bordered well paints inside its own shape',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _host(
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(28),
            customBorder: const StadiumBorder(),
            child: const SizedBox(key: _surface, width: 160, height: 48),
          ),
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pump(const Duration(milliseconds: 80));
      expect(tester.takeException(), isNull);

      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });

    testWidgets('every clip branch survives a painted frame',
        (WidgetTester tester) async {
      final (MaterialInkController layer, RenderBox box) =
          await _captureLayer(tester);
      Rect well() => Offset.zero & box.size;

      final ZenInkSplash rounded = _bleed(
        layer,
        box,
        rectCallback: well,
        borderRadius: BorderRadius.circular(24),
      );
      final ZenInkSplash circular = _bleed(
        layer,
        box,
        rectCallback: well,
        customBorder: const CircleBorder(),
      );
      final ZenInkSplash open = _bleed(layer, box);

      await tester.pump(const Duration(milliseconds: 150));
      expect(tester.takeException(), isNull);

      // Taking one out must not disturb the others, and all must still clear.
      rounded.dispose();
      await tester.pump(const Duration(milliseconds: 200));
      expect(tester.takeException(), isNull);
      expect(circular.reduceMotion, isFalse);
      expect(open.reduceMotion, isFalse);

      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(tester.binding.transientCallbackCount, 0);
    });
  });

  group('reduce motion', () {
    testWidgets('the ink is simply put down, and resolves at once',
        (WidgetTester tester) async {
      final (MaterialInkController layer, RenderBox box) =
          await _captureLayer(tester);
      final ZenInkSplash quiet = _bleed(layer, box, reduceMotion: true);

      expect(
        tester.binding.transientCallbackCount,
        0,
        reason: 'the feedback stays, the travel goes',
      );

      await tester.pump(const Duration(milliseconds: 300));
      expect(tester.takeException(), isNull);

      quiet.confirm();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(tester.takeException(), isNull);
      expect(tester.binding.transientCallbackCount, 0);
    });
  });
}
