import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/widgets/zen_shake.dart';

/// Guard rails for the **feedback layer** - haptics and sound effects.
///
/// Both are user-facing promises: Settings has a "Haptic Feedback" and a
/// "Sound Effects" switch, and a raw `HapticFeedback.*` call or a direct
/// `AssetSource('audio/...')` play is invisible to them. The two source checks
/// below are **shrink-only ratchets** with a zero baseline, in the style of the
/// motion vocabulary's; the group after them pins the *behaviour* of a haptic
/// pattern, which a source scan cannot see.
///
/// See `docs/UI_UX_STANDARDS.md` § Haptic Language.
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

/// Files matching [pattern] outside the one file allowed to hold it.
List<String> _offenders(RegExp pattern, {required String except}) => _libSources()
    .where((File file) => !file.path.endsWith(except))
    .where((File file) =>
        pattern.hasMatch(_withoutLineComments(file.readAsStringSync())))
    .map((File file) => file.path)
    .toList();

/// Advances the clock and then flushes the microtask that delivers the impact.
///
/// `HapticFeedback.*` is a platform-channel message, so a timed pump alone can
/// leave the delivery one microtask behind the assertion.
Future<void> _advance(WidgetTester tester, Duration by) async {
  await tester.pump(by);
  await tester.pump();
}

void main() {
  group('Feedback guard rails', () {
    test('no raw haptic call bypasses the one gate', () {
      // Anchored to the real call shapes **and** case-sensitive on purpose:
      // PowerShell's Select-String is case-*insensitive* by default and
      // cheerfully reports the generated comment "No description provided for
      // @hapticFeedback." in lib/l10n as a raw call. Dart's RegExp is not, so
      // this guard is exact where a shell audit would not be.
      final List<String> offenders = _offenders(
        RegExp(r'HapticFeedback\.(lightImpact|mediumImpact|heavyImpact'
            r'|selectionClick|vibrate)'),
        except: 'haptics_manager.dart',
      );
      expect(
        offenders,
        isEmpty,
        reason: 'Every buzz must go through HapticsManager, or the Settings '
            'toggle cannot switch it off: $offenders',
      );
    });

    test('no sound asset is played without the settings gate', () {
      // ZenSoundService checks `_enabled` before every play; anything that
      // reaches for the asset path itself skips that check, which is exactly
      // how the quiz used to grade out loud with sound effects switched off.
      final List<String> offenders = _offenders(
        RegExp(r"AssetSource\('audio/(sfx|zen)_"),
        except: 'zen_sound_service.dart',
      );
      expect(
        offenders,
        isEmpty,
        reason: 'Sound effects must be played by ZenSoundService, the only '
            'place the Settings toggle reaches: $offenders',
      );
    });

    test('the settings switches reach both gates', () {
      final String source = _withoutLineComments(
        File('lib/features/flashcards/presentation/providers/'
                'settings_controller.dart')
            .readAsStringSync(),
      );
      expect(
        source,
        contains('HapticsManager.setEnabled'),
        reason: 'the Haptic Feedback switch must reach HapticsManager',
      );
      expect(
        source,
        contains('ZenSoundService.instance.setEnabled'),
        reason: 'the Sound Effects switch must reach ZenSoundService',
      );
    });
  });

  /// Counts the impacts the platform actually receives.
  ///
  /// A source scan cannot see a *pattern* stack, so these intercept the
  /// platform channel and count what really arrives.
  group('An outcome never stacks into a buzzsaw', () {
    late List<String> impacts;
    late TestDefaultBinaryMessenger messenger;

    setUp(() {
      impacts = <String>[];
      messenger =
          TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
      messenger.setMockMethodCallHandler(SystemChannels.platform,
          (MethodCall call) async {
        if (call.method == 'HapticFeedback.vibrate') {
          impacts.add('${call.arguments}');
        }
        return null;
      });
      HapticsManager.setEnabled(true);
    });

    tearDown(() {
      messenger.setMockMethodCallHandler(SystemChannels.platform, null);
      HapticsManager.setEnabled(true);
    });

    testWidgets('a burst of wrong answers plays one pattern, not a pile-up',
        (WidgetTester tester) async {
      // The old implementation chained `Future.delayed`s with no guard, so
      // three wrong answers queued 3 + 3 + 3 = 9 heavy impacts.
      HapticsManager.error();
      await _advance(tester, Duration.zero);
      expect(impacts.length, 1, reason: 'a pattern leads immediately');

      await _advance(tester, const Duration(milliseconds: 50));
      HapticsManager.error();
      await _advance(tester, Duration.zero);
      expect(impacts.length, 2, reason: 'the newest outcome takes over');

      await _advance(tester, const Duration(milliseconds: 50));
      HapticsManager.error();
      await _advance(tester, Duration.zero);
      expect(impacts.length, 3);

      // Only the surviving pattern may finish: two more impacts, one per beat.
      await _advance(tester, ZenMotion.beat);
      expect(impacts.length, 4);
      await _advance(tester, ZenMotion.beat);
      expect(
        impacts.length,
        5,
        reason: '1 + 1 + 3, never 9: a retired pattern stops after the impact '
            'it had already sent',
      );
      expect(impacts.every((String i) => i.contains('heavyImpact')), isTrue);
    });

    testWidgets('success is two ticks, one ZenMotion.beat apart',
        (WidgetTester tester) async {
      HapticsManager.success();
      await _advance(tester, Duration.zero);
      expect(impacts.length, 1);

      await _advance(tester, ZenMotion.beat - const Duration(milliseconds: 1));
      expect(impacts.length, 1, reason: 'the gap is the shared beat, not a guess');

      await _advance(tester, const Duration(milliseconds: 1));
      expect(impacts.length, 2, reason: 'the second tick lands on the beat');

      await _advance(tester, ZenMotion.beat * 2);
      expect(impacts.length, 2, reason: 'a double tick stays a double tick');
      expect(impacts.every((String i) => i.contains('lightImpact')), isTrue);
    });

    testWidgets('switching haptics off retires a pattern already in flight',
        (WidgetTester tester) async {
      HapticsManager.error();
      await _advance(tester, Duration.zero);
      expect(impacts.length, 1);

      HapticsManager.setEnabled(false);
      await _advance(tester, ZenMotion.beat * 4);

      expect(
        impacts.length,
        1,
        reason: 'the remaining impacts must never arrive once the user has '
            'switched haptics off',
      );
    });

    testWidgets('with haptics off, nothing is sent at all',
        (WidgetTester tester) async {
      HapticsManager.setEnabled(false);
      HapticsManager.light();
      HapticsManager.medium();
      HapticsManager.heavy();
      HapticsManager.selection();
      HapticsManager.success();
      HapticsManager.error();
      await _advance(tester, ZenMotion.beat * 4);

      expect(impacts, isEmpty);
    });

    testWidgets('a milestone climbs: light, then medium, then heavy',
        (WidgetTester tester) async {
      HapticsManager.milestone();
      await _advance(tester, Duration.zero);
      expect(impacts.length, 1);

      await _advance(tester, ZenMotion.beat);
      await _advance(tester, ZenMotion.beat);
      expect(impacts.length, 3, reason: 'a three-beat crescendo');

      // The order *is* the meaning: rising reads as "you climbed", where the
      // refusal is the same weight three times over.
      expect(impacts[0], contains('lightImpact'));
      expect(impacts[1], contains('mediumImpact'));
      expect(impacts[2], contains('heavyImpact'));
    });

    testWidgets('a destructive confirmation is one buzz, not a pattern',
        (WidgetTester tester) async {
      HapticsManager.destructive();
      await _advance(tester, Duration.zero);

      expect(impacts.length, 1, reason: 'it must not read as the refusal triple');
      // `HapticFeedback.vibrate()` is the only call in the vocabulary that
      // carries no style argument - every taptic impact sends a
      // `HapticFeedbackType.*` - which is precisely what makes it a different
      // tier rather than a louder tap.
      expect(
        impacts.single,
        isNot(contains('Impact')),
        reason: 'the destructive tier must not be a re-labelled taptic impact',
      );

      await _advance(tester, ZenMotion.beat * 3);
      expect(
        impacts.length,
        1,
        reason: 'a single buzz: reserved for what cannot be undone',
      );
    });
  });

  /// The widget that owns a feedback moment must fire it itself.
  ///
  /// This is the lesson of the whole sweep: the app had **22** error-toast call
  /// sites and **2** rejection shakes against **one** haptic refusal, because
  /// every call site had to remember to pair it and almost none did.
  group('A feedback moment owns its impact', () {
    late List<String> impacts;
    late TestDefaultBinaryMessenger messenger;

    setUp(() {
      impacts = <String>[];
      messenger =
          TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
      messenger.setMockMethodCallHandler(SystemChannels.platform,
          (MethodCall call) async {
        if (call.method == 'HapticFeedback.vibrate') {
          impacts.add('${call.arguments}');
        }
        return null;
      });
      HapticsManager.setEnabled(true);
    });

    tearDown(() {
      messenger.setMockMethodCallHandler(SystemChannels.platform, null);
      HapticsManager.setEnabled(true);
    });

    testWidgets('ZenShake refuses on a rising trigger, all by itself',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ZenShake(
            trigger: 0,
            child: SizedBox(width: 20, height: 20),
          ),
        ),
      );
      await _advance(tester, Duration.zero);
      expect(impacts, isEmpty, reason: 'rest must stay silent');

      await tester.pumpWidget(
        const MaterialApp(
          home: ZenShake(
            trigger: 1,
            child: SizedBox(width: 20, height: 20),
          ),
        ),
      );
      await _advance(tester, Duration.zero);
      expect(
        impacts.length,
        1,
        reason: 'the widget now owns the refusal, so no caller can forget it',
      );

      await _advance(tester, ZenMotion.beat * 3);
      expect(
        impacts.length,
        3,
        reason: 'a full triple refusal, not a lone tick',
      );
    });
  });
}
