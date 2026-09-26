import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// One intent type carrying an index, so a single action can dispatch many
/// bindings (Flutter's `Actions` is keyed by Intent *type*, so a map of
/// activator → callback needs this indirection).
class _ZenShortcutIntent extends Intent {
  const _ZenShortcutIntent(this.id);

  final int id;
}

/// Hardware-keyboard bindings for a screen — the iPad-with-a-keyboard and
/// desktop case (Part 2b of `docs/IPAD_ADAPTIVE_PLAN.md`).
///
/// ```dart
/// ZenShortcuts(
///   shortcuts: <ShortcutActivator, VoidCallback>{
///     const SingleActivator(LogicalKeyboardKey.space): _flip,
///     const SingleActivator(LogicalKeyboardKey.digit1): () => _grade(1),
///   },
///   child: Scaffold(...),
/// )
/// ```
///
/// Two details that make it work rather than merely compile:
///
/// * it **autofocuses**, because a `Shortcuts` widget only sees keys pressed
///   while focus is inside it — without the focus node, every binding silently
///   does nothing until the user taps a text field;
/// * it is additive: a text field inside keeps its own bindings, since Flutter
///   resolves shortcuts from the focused node upwards.
///
/// Meta (⌘) and Control variants are both worth binding on a tablet: ⌘ for an
/// iPad with a Magic Keyboard, Ctrl for an Android tablet or ChromeOS device.
class ZenShortcuts extends StatelessWidget {
  const ZenShortcuts({
    super.key,
    required this.shortcuts,
    required this.child,
    this.autofocus = true,
  });

  final Map<ShortcutActivator, VoidCallback> shortcuts;
  final Widget child;
  final bool autofocus;

  /// The same callback under `⌘key` and `Ctrl+key`.
  static Map<ShortcutActivator, VoidCallback> primary(
      LogicalKeyboardKey key, VoidCallback callback) {
    return <ShortcutActivator, VoidCallback>{
      SingleActivator(key, meta: true): callback,
      SingleActivator(key, control: true): callback,
    };
  }

  @override
  Widget build(BuildContext context) {
    if (shortcuts.isEmpty) return child;

    final List<ShortcutActivator> activators =
        shortcuts.keys.toList(growable: false);
    final List<VoidCallback> callbacks =
        shortcuts.values.toList(growable: false);

    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        for (int i = 0; i < activators.length; i++)
          activators[i]: _ZenShortcutIntent(i),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          _ZenShortcutIntent: CallbackAction<_ZenShortcutIntent>(
            onInvoke: (_ZenShortcutIntent intent) {
              callbacks[intent.id]();
              return null;
            },
          ),
        },
        child: Focus(autofocus: autofocus, child: child),
      ),
    );
  }
}
