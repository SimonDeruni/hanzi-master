import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/presentation/widgets/ai_progress_bar.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';

/// Every Dart source shipped in the application.
List<File> _libSources() => Directory('lib')
    .listSync(recursive: true)
    .whereType<File>()
    .where((File file) => file.path.endsWith('.dart'))
    .toList();

/// Removes `//` comments so documenting an idiom is not mistaken for using it.
String _withoutLineComments(String source) => source
    .split('\n')
    .map((String line) {
      final int index = line.indexOf('//');
      return index == -1 ? line : line.substring(0, index);
    })
    .join('\n');

/// Hosts [child] with the platform "Reduce Motion" flag controllable.
///
/// The override is applied through `MaterialApp.builder` rather than wrapping
/// the whole app: `MaterialApp` installs its own `MediaQuery`, so an outer one
/// would be discarded and the flag would silently read as false.
Widget _host(Widget child, {bool reduceMotion = false}) => MaterialApp(
      theme: AppTheme.lightTheme,
      builder: (BuildContext context, Widget? inner) => MediaQuery(
        data: MediaQuery.of(context).copyWith(disableAnimations: reduceMotion),
        child: inner!,
      ),
      home: Scaffold(body: Center(child: child)),
    );

void main() {
  group('Zen motion tokens', () {
    test('match the mandated UI/UX standard', () {
      // docs/UI_UX_STANDARDS.md: quick feedback 300ms, stroke animations are
      // strokes * 800ms, and Curves.easeInOutQuart for a natural brush feel.
      expect(ZenMotion.quick, const Duration(milliseconds: 300));
      expect(ZenMotion.strokeUnit, const Duration(milliseconds: 800));
      expect(ZenMotion.forStrokes(3), const Duration(milliseconds: 2400));
      expect(ZenMotion.natural, Curves.easeInOutQuart);
    });

    test('both themes share one Zen page transition', () {
      for (final ThemeData theme in <ThemeData>[
        AppTheme.lightTheme,
        AppTheme.darkTheme,
      ]) {
        final PageTransitionsTheme transitions = theme.pageTransitionsTheme;
        for (final TargetPlatform platform in <TargetPlatform>[
          TargetPlatform.android,
          TargetPlatform.windows,
          TargetPlatform.linux,
        ]) {
          expect(
            transitions.builders[platform],
            isA<ZenPageTransitionsBuilder>(),
            reason: '$platform must share the app page transition',
          );
        }
        // iOS/macOS deliberately keep Cupertino: that builder supplies the
        // interactive edge-swipe back gesture.
        expect(
          transitions.builders[TargetPlatform.iOS],
          isA<CupertinoPageTransitionsBuilder>(),
        );
      }
    });
  });

  group('Motion guard rails', () {
    test('every .repeat() site respects the reduce-motion setting', () {
      // A loop that ignores "Reduce Motion" pulses forever for users with
      // vestibular disorders - the exact defect this guards against.
      final List<String> offenders = <String>[];
      for (final File file in _libSources()) {
        final String source = file.readAsStringSync();
        if (!source.contains('.repeat(')) {
          continue;
        }
        // The file must at least consult the platform preference.
        if (source.contains('reduceMotion') ||
            source.contains('MotionResolution')) {
          continue;
        }
        offenders.add(file.path);
      }
      expect(
        offenders,
        isEmpty,
        reason: 'Wrap the repeat in a reduce-motion check '
            '(context.reduceMotion or MotionResolution.resolve):\n'
            '${offenders.join('\n')}',
      );
    });

    test('the dated FadeUpwards page transition is gone', () {
      final List<String> offenders = <String>[];
      for (final File file in _libSources()) {
        if (_withoutLineComments(file.readAsStringSync())
            .contains('FadeUpwardsPageTransitionsBuilder')) {
          offenders.add(file.path);
        }
      }
      expect(
        offenders,
        isEmpty,
        reason: 'Use ZenPageTransitionsBuilder (or Cupertino on iOS):\n'
            '${offenders.join('\n')}',
      );
    });

    test('bare MaterialPageRoute usage never grows', () {
      // ZenPageTransitionsBuilder styles these correctly, but the app's own
      // SwipeBackPageRoute is the convention. Ratchet: may only go DOWN.
      const int baseline = 23;
      int count = 0;
      for (final File file in _libSources()) {
        count += RegExp(r'MaterialPageRoute')
            .allMatches(file.readAsStringSync())
            .length;
      }
      expect(
        count,
        lessThanOrEqualTo(baseline),
        reason: 'Prefer SwipeBackPageRoute over a bare MaterialPageRoute '
            '(now $count, baseline $baseline)',
      );
    });
  });

  group('Reduce motion is honoured at runtime', () {
    testWidgets('a perpetual sweep schedules no frames when motion is reduced',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _host(const AiProgressBar(label: 'Thinking'), reduceMotion: true),
      );
      await tester.pump(const Duration(seconds: 2));

      expect(
        tester.binding.transientCallbackCount,
        0,
        reason: 'A looping sweep must not keep ticking under reduce motion',
      );
    });

    testWidgets('the same sweep does run when motion is allowed',
        (WidgetTester tester) async {
      await tester.pumpWidget(_host(const AiProgressBar(label: 'Thinking')));
      await tester.pump(const Duration(milliseconds: 300));

      expect(tester.binding.transientCallbackCount, greaterThan(0));
    });
  });
}
