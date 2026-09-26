import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';

/// Guard rails for the **Tier 2 (interface motion)** vocabulary.
///
/// Tier 1 - the stroke/drawing animation and Hero flights - is frozen and is
/// asserted here so a refactor cannot quietly re-time it. See
/// `docs/UI_UX_STANDARDS.md` § Motion and `docs/ANTI_PATTERNS.md`
/// "Frozen Motion (Do Not Touch)".
///
/// The raw-literal counts are **shrink-only ratchets**: they may fall as the
/// remaining screens are swept, never rise.
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

/// Counts a pattern across every shipped source except the definition file.
int _countAcrossLib(RegExp pattern) {
  int total = 0;
  for (final File file in _libSources()) {
    if (file.path.endsWith('zen_motion.dart')) continue;
    total += pattern.allMatches(_withoutLineComments(file.readAsStringSync()))
        .length;
  }
  return total;
}

void main() {
  group('Tier 2 motion vocabulary', () {
    test('tokens match docs/UI_UX_STANDARDS.md', () {
      // Tier 1 - frozen, asserted so no refactor can re-time it.
      expect(ZenMotion.strokeUnit, const Duration(milliseconds: 800));
      expect(ZenMotion.forStrokes(3), const Duration(milliseconds: 2400));

      // Tier 2 durations.
      expect(ZenMotion.swap, const Duration(milliseconds: 180));
      expect(ZenMotion.quick, const Duration(milliseconds: 300));
      expect(ZenMotion.page, const Duration(milliseconds: 500));
      expect(ZenMotion.pageReverse, const Duration(milliseconds: 350));
      expect(ZenMotion.tap, const Duration(milliseconds: 130));
      expect(ZenMotion.toast, const Duration(milliseconds: 2000));
      expect(ZenMotion.ambient, const Duration(seconds: 2));
      expect(ZenMotion.ambientFast, const Duration(milliseconds: 1000));
      expect(ZenMotion.entrance, const Duration(milliseconds: 400));
      expect(ZenMotion.stagger, const Duration(milliseconds: 50));
      expect(ZenMotion.beat, const Duration(milliseconds: 100));
      expect(ZenMotion.shake, const Duration(milliseconds: 500));
      // Added 2026-09-25 with `ZenExit`: the vocabulary had an entrance but no
      // exit, so a button-driven removal was a hard cut.
      expect(ZenMotion.exit, const Duration(milliseconds: 250));

      // The only five permitted curves.
      expect(ZenMotion.natural, Curves.easeInOutQuart);
      expect(ZenMotion.settle, Curves.easeInOutQuart);
      expect(ZenMotion.enter, Curves.easeOutCubic);
      expect(ZenMotion.breathe, Curves.easeInOutSine);
      expect(ZenMotion.arrival, Curves.easeOutBack);
    });

    test('the feel stays calm - nothing untrackably fast or sluggish', () {
      // The standard: interface motion is never faster than the eye can track
      // (>=130ms) nor slower than a breath (<=500ms).
      const List<Duration> interfaceMotions = <Duration>[
        ZenMotion.tap,
        ZenMotion.swap,
        ZenMotion.quick,
        ZenMotion.pageReverse,
        ZenMotion.page,
        ZenMotion.exit,
      ];
      for (final Duration duration in interfaceMotions) {
        expect(duration.inMilliseconds, greaterThanOrEqualTo(130));
        expect(duration.inMilliseconds, lessThanOrEqualTo(500));
      }
    });

    test('raw curve literals never grow', () {
      // Tier 1 (`drawing_canvas.dart`) legitimately holds the single survivor.
      const int baseline = 1;
      final int curved = _countAcrossLib(RegExp(r'Curves\.'));
      expect(
        curved,
        lessThanOrEqualTo(baseline),
        reason: 'Every interface curve must come from ZenMotion '
            '(found $curved, baseline $baseline).',
      );
      final List<String> offenders = _libSources()
          .where((File file) =>
              !file.path.endsWith('zen_motion.dart') &&
              file.readAsStringSync().contains('Curves.'))
          .map((File file) => file.path)
          .toList();
      expect(
        offenders.every((String path) => path.endsWith('drawing_canvas.dart')),
        isTrue,
        reason: 'Only the frozen Tier 1 canvas may hold a raw curve: $offenders',
      );
    });

    test('raw duration literals never grow', () {
      // Included on purpose: timeouts, debounces and save timers are not motion.
      // Shrink-only ratchet, exactly like the MaterialPageRoute baseline.
      const int baseline = 123;
      final int raw = _countAcrossLib(
        RegExp(r'Duration\((milliseconds|seconds):'),
      );
      expect(
        raw,
        lessThanOrEqualTo(baseline),
        reason: 'Interface motion must source its timing from ZenMotion '
            '(found $raw, baseline $baseline).',
      );
    });

    test('the flutter_animate .ms shorthand never grows', () {
      const int baseline = 10;
      final int shorthand =
          _countAcrossLib(RegExp(r'\d+\.ms\b|\d+\.seconds\b'));
      expect(
        shorthand,
        lessThanOrEqualTo(baseline),
        reason: 'Use ZenMotion rather than a second duration dialect '
            '(found $shorthand, baseline $baseline).',
      );
    });

    test('ZenMotion adoption never shrinks', () {
      const int floor = 240;
      int references = 0;
      for (final File file in _libSources()) {
        references +=
            RegExp(r'ZenMotion\.').allMatches(file.readAsStringSync()).length;
      }
      expect(
        references,
        greaterThanOrEqualTo(floor),
        reason: 'The vocabulary is being bypassed again '
            '(found $references, floor $floor).',
      );
    });

    test('Tier 1 stays frozen', () {
      // The Hero flight keeps its collision-proof namespaced tag scheme, which
      // exists because the same card renders in several rails on one screen.
      expect(
        File('lib/shared/utils/hero_transition.dart')
            .readAsStringSync()
            .contains(r"'$scope::$id'"),
        isTrue,
        reason:
            'The Hero tag scheme is frozen - see the standard Motion section.',
      );
      // The drawing canvas owns its own stroke budget. Re-timing it is how the
      // animation was destroyed twice before (docs/ROADMAP.MD).
      expect(
        File('lib/features/flashcards/presentation/widgets/drawing_canvas.dart')
            .readAsStringSync()
            .contains('widget.paths.length * 700'),
        isTrue,
        reason: 'Tier 1 stroke timing is frozen.',
      );
    });

    test('every interface animation honours reduce motion', () {
      // Tier 1 (stroke drawing + Hero flights) is frozen and therefore exempt:
      // the canvas deliberately does not collapse. Excluded, not ratcheted, so
      // this metric is about Tier 2 only and can actually reach zero.
      const Set<String> frozenTier1 = <String>{
        'drawing_canvas.dart',
        'stroke_matcher.dart',
        'character_loader.dart',
        'hero_transition.dart',
        'geometry_utils.dart',
      };
      final List<String> offenders = <String>[];
      for (final File file in _libSources()) {
        if (frozenTier1.contains(file.uri.pathSegments.last)) continue;
        final String source = file.readAsStringSync();
        final bool animates = RegExp(
          r'Animated[A-Za-z]+\(|AnimationController\(|TweenAnimationBuilder<|\.animate\(',
        ).hasMatch(source);
        if (!animates) continue;
        // `ZenMotion.of(context, token)` collapses a one-shot widget;
        // `MotionResolution` / a cached `reduceMotion` flag cover controllers.
        if (source.contains('ZenMotion.of(') ||
            source.contains('reduceMotion') ||
            source.contains('MotionResolution')) {
          continue;
        }
        offenders.add(file.path);
      }
      expect(
        offenders,
        isEmpty,
        reason: 'Every Tier 2 animation must collapse under the platform '
            '"Reduce Motion" setting. Use `ZenMotion.of(context, <token>)` for a '
            'one-shot widget, or gate a controller with `MotionResolution` '
            'from `didChangeDependencies`:\n${offenders.join('\n')}',
      );
    });

    testWidgets('ZenMotion.of passes the token through, or collapses it',
        (WidgetTester tester) async {
      late Duration resolved;

      Widget probe() => Builder(
            builder: (BuildContext context) {
              resolved = ZenMotion.of(context, ZenMotion.swap);
              return const SizedBox.shrink();
            },
          );

      // Motion allowed: the token reaches the widget untouched.
      await tester.pumpWidget(
        MaterialApp(
          builder: (BuildContext context, Widget? inner) => MediaQuery(
            data: MediaQuery.of(context).copyWith(disableAnimations: false),
            child: inner!,
          ),
          home: probe(),
        ),
      );
      expect(resolved, ZenMotion.swap);

      // Reduce motion: the one-shot animation collapses to nothing.
      await tester.pumpWidget(
        MaterialApp(
          builder: (BuildContext context, Widget? inner) => MediaQuery(
            data: MediaQuery.of(context).copyWith(disableAnimations: true),
            child: inner!,
          ),
          home: probe(),
        ),
      );
      expect(resolved, Duration.zero);
    });
  });
}
