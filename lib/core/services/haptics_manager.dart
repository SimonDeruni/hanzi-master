import 'package:flutter/services.dart';

import 'package:hanzi_master/core/theme/zen_motion.dart';

/// The app's only haptic vocabulary.
///
/// This lives in `core` rather than inside a feature because it is used by
/// `core`, `shared` and ten features; the sound side has the same shape in
/// `core/services/zen_sound_service.dart`. Every buzz in the app must go
/// through here, because this is the single gate that the Settings toggle
/// actually switches off - a raw `HapticFeedback.*` call elsewhere is
/// unfixable from Settings.
///
/// The four primitives map to one meaning each, so the same interaction feels
/// the same everywhere:
/// [selection] for a change of choice (tabs, pills, selection sheets),
/// [light] for a standard button,
/// [medium] for a state change worth noticing (reveal, confirm),
/// [heavy] for a refusal, [success] / [error] for graded outcomes,
/// [milestone] for an achievement big enough to climb, and [destructive] for the
/// one action that cannot be undone.
class HapticsManager {
  // Controlled by the user's settings toggle
  static bool _enabled = true;

  /// Bumped by every new pattern, and by [setEnabled].
  ///
  /// A pattern is a short chain of impacts separated by gaps, so without a
  /// token a burst of outcomes interleaves: three wrong answers in quick
  /// succession used to queue **nine** heavy impacts instead of three.
  static int _token = 0;

  static void setEnabled(bool enabled) {
    _enabled = enabled;
    if (!enabled) {
      // Retire a pattern already in flight, so switching haptics off is
      // immediate rather than "once the current buzz finishes".
      _token++;
    }
  }

  // Light tick for standard buttons (like typing)
  static Future<void> light() async {
    if (!_enabled) return;
    await HapticFeedback.lightImpact();
  }

  // Medium thud for important actions (like revealing a card)
  static Future<void> medium() async {
    if (!_enabled) return;
    await HapticFeedback.mediumImpact();
  }

  // Heavy vibration for errors or "Hard" ratings
  static Future<void> heavy() async {
    if (!_enabled) return;
    await HapticFeedback.heavyImpact();
  }

  // Selection tick
  static Future<void> selection() async {
    if (!_enabled) return;
    await HapticFeedback.selectionClick();
  }

  // Success vibration (double tick)
  static Future<void> success() => _pattern(<Future<void> Function()>[
        HapticFeedback.lightImpact,
        HapticFeedback.lightImpact,
      ]);

  // Error vibration (triple heavy tick)
  static Future<void> error() => _pattern(<Future<void> Function()>[
        HapticFeedback.heavyImpact,
        HapticFeedback.heavyImpact,
        HapticFeedback.heavyImpact,
      ]);

  // Milestone vibration (a rising crescendo: a rank up, a seal earned)
  //
  // Deliberately **rising** - light, medium, heavy - where the refusal is flat
  // and repeated. A crescendo reads as "you climbed"; the same set of impacts in
  // a flat run reads as "no". Use this for an achievement, not for an ordinary
  // award: that is [success].
  static Future<void> milestone() => _pattern(<Future<void> Function()>[
        HapticFeedback.lightImpact,
        HapticFeedback.mediumImpact,
        HapticFeedback.heavyImpact,
      ]);

  // Destructive vibration (a real device buzz: irreversible, and rare)
  //
  // The only impact in this vocabulary that is **not a Taptic tap**: on iOS it is
  // the system vibration (`kSystemSoundID_Vibrate`) rather than an impact, and on
  // Android it maps to `HapticFeedbackConstants.LONG_PRESS` where the taptic
  // styles share a constant. Deliberately a **single** buzz and not a pattern: it
  // marks "this cannot be undone", so it must not read as the refusal's triple -
  // and it must stay rare enough that it always means the same thing.
  static Future<void> destructive() async {
    if (!_enabled) return;
    // A confirmation of something irreversible silences anything still in
    // flight, rather than sharing the moment with a stale outcome.
    _token++;
    await HapticFeedback.vibrate();
  }

  /// Plays [beats] one [ZenMotion.beat] apart as **one** pattern.
  ///
  /// The newest pattern always wins: starting one retires whatever is still in
  /// flight, so an outcome can never stack into a longer buzz than the gesture
  /// earned, and disabling haptics retires the running one too.
  ///
  /// The gap is [ZenMotion.beat] rather than a local literal because the felt
  /// rhythm of the feedback and the rhythm of the motion are supposed to be the
  /// same thing - § Motion, "pair motion with haptics".
  static Future<void> _pattern(List<Future<void> Function()> beats) async {
    if (!_enabled) return;
    final int token = ++_token;
    for (int i = 0; i < beats.length; i++) {
      if (!_enabled || token != _token) return;
      await beats[i]();
      if (i < beats.length - 1) {
        await Future<void>.delayed(ZenMotion.beat);
      }
    }
  }
}
