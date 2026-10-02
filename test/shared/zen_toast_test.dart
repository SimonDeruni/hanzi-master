import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/widgets/zen_toast.dart';

const String _message = 'Added 汉 to HSK 3';

/// Hosts a button that raises [tone] on the root overlay, with the platform
/// "Reduce Motion" flag controllable.
Widget _host({
  ZenToastTone tone = ZenToastTone.success,
  bool reduceMotion = false,
}) {
  return MaterialApp(
    theme: AppTheme.lightTheme,
    builder: (BuildContext context, Widget? inner) => MediaQuery(
      data: MediaQuery.of(context).copyWith(disableAnimations: reduceMotion),
      child: inner!,
    ),
    home: Scaffold(
      body: Builder(
        builder: (BuildContext context) => Center(
          child: ElevatedButton(
            onPressed: () => ZenToast.show(context, _message, tone: tone),
            child: const Text('show'),
          ),
        ),
      ),
    ),
  );
}

/// Raises a toast and lets its entrance finish.
Future<void> _raise(WidgetTester tester) async {
  await tester.tap(find.text('show'));
  await tester.pump();
  await tester.pump(ZenMotion.swap);
}

/// Leaves no toast (and no pending dwell timer) behind for the next test.
Future<void> _clear(WidgetTester tester) async {
  ZenToast.dismiss();
  await tester.pumpAndSettle();
}

void main() {
  tearDown(ZenToast.dismiss);

  group('ZenToast', () {
    test('sources every duration and curve from ZenMotion', () {
      final String source =
          File('lib/shared/widgets/zen_toast.dart').readAsStringSync();

      expect(source, contains('ZenMotion.swap'),
          reason: 'Entrance and exit use the shared swap token');
      expect(source, contains('ZenMotion.toast'),
          reason: 'The dwell uses the shared toast token');
      expect(source, isNot(contains('Curves.')),
          reason: 'No raw curve may exist outside ZenMotion');
      expect(
        source,
        isNot(contains(RegExp(r'Duration\((milliseconds|seconds):'))),
        reason: 'No raw duration literal',
      );
      expect(source, contains('MotionResolution'),
          reason: 'A controller must honour the platform reduce-motion flag');
      expect(source, contains('_dwell?.cancel()'),
          reason: 'A dismissed toast must not leave a pending timer');
    });

    testWidgets('floats the message above the app, then leaves after the dwell',
        (WidgetTester tester) async {
      await tester.pumpWidget(_host());
      expect(find.text(_message), findsNothing);

      await _raise(tester);
      expect(find.text(_message), findsOneWidget,
          reason: 'The toast is inserted on the root overlay');

      await tester.pump(ZenMotion.toast); // the dwell elapses
      await tester.pumpAndSettle(); // exit leg, then removal
      expect(find.text(_message), findsNothing,
          reason: 'A toast is transient, never permanent');
    });

    testWidgets('tapping dismisses it early', (WidgetTester tester) async {
      await tester.pumpWidget(_host());
      await _raise(tester);

      await tester.tap(find.text(_message));
      await tester.pumpAndSettle();

      expect(find.text(_message), findsNothing);
    });

    testWidgets('a second toast replaces the first',
        (WidgetTester tester) async {
      await tester.pumpWidget(_host());
      await _raise(tester);
      await _raise(tester);

      expect(find.text(_message), findsOneWidget,
          reason: 'Only one toast may be on screen at a time');

      await _clear(tester);
    });

    testWidgets('success wears Jade Green, an error wears Cinnabar',
        (WidgetTester tester) async {
      await tester.pumpWidget(_host());
      await _raise(tester);

      Icon icon = tester.widget<Icon>(find.byIcon(Icons.check_rounded));
      expect(icon.color, const Color(0xFF2E7D32));
      await _clear(tester);

      await tester.pumpWidget(_host(tone: ZenToastTone.error));
      await _raise(tester);

      icon = tester.widget<Icon>(find.byIcon(Icons.error_outline_rounded));
      expect(icon.color, const Color(0xFFC62828));
      await _clear(tester);
    });

    testWidgets('a lost connection wears the wifi glyph, in Emperor\'s Gold',
        (WidgetTester tester) async {
      await tester.pumpWidget(_host(tone: ZenToastTone.offline));
      await _raise(tester);

      // Distinct from the Cinnabar alert on purpose: "no network" is a
      // condition to fix, not a failed attempt to repeat.
      final Icon icon =
          tester.widget<Icon>(find.byIcon(Icons.wifi_off_rounded));
      expect(icon.color, const Color(0xFFB8860B));
      await _clear(tester);
    });

    testWidgets('reduced motion shows it instantly, without a tween',
        (WidgetTester tester) async {
      await tester.pumpWidget(_host(reduceMotion: true));
      await tester.tap(find.text('show'));
      await tester.pump();

      final FadeTransition fade = tester.widget<FadeTransition>(
        find
            .ancestor(
              of: find.text(_message),
              matching: find.byType(FadeTransition),
            )
            .first,
      );
      expect(fade.opacity.value, moreOrLessEquals(1.0),
          reason: 'The toast must rest fully visible, not fade in');

      await _clear(tester);
    });
  });
}
