import 'dart:async';

import 'package:flutter/material.dart';

import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';

/// The tone of a [ZenToast]: which accent, icon and semantic colour it wears.
enum ZenToastTone { success, error, info }

/// A calligraphic confirmation toast in the Zen & Ink language.
///
/// Replaces bare `SnackBar`s on the "words were saved" path (the deck picker
/// behind *Add to Deck* / *Extract to Deck*): a Material snackbar renders as a
/// grey rectangle pinned to the bottom of the screen **behind** the modal
/// barrier, so from an article it arrives dimmed and half-covered by the sheet
/// that is closing. A [ZenToast] lives on the **root overlay** instead, so it
/// floats crisp above the sheet and above the reader, on Xuan paper with the
/// Emperor's Gold hairline used by the other calligraphic surfaces.
///
/// Motion follows `docs/UI_UX_STANDARDS.md`: entrance and exit are
/// [ZenMotion.swap] on [ZenMotion.enter], the dwell is [ZenMotion.toast], and
/// the platform "Reduce Motion" setting collapses both legs to instant. Tapping
/// the toast dismisses it early. One toast exists at a time.
class ZenToast {
  const ZenToast._();

  static OverlayEntry? _entry;

  /// Shows [message] above everything else, replacing any toast already up.
  static void show(
    BuildContext context,
    String message, {
    ZenToastTone tone = ZenToastTone.info,
  }) =>
      showOn(Overlay.maybeOf(context, rootOverlay: true), message, tone: tone);

  /// Shows [message] on [overlay] — the form to use when the caller may be
  /// disposed by the time an `await` completes.
  ///
  /// The deck picker pops itself as it saves, so its `BuildContext` is already
  /// gone when the confirmation is due; the overlay outlives the sheet, which
  /// is exactly what makes the toast visible instead of half-covered.
  static void showOn(
    OverlayState? overlay,
    String message, {
    ZenToastTone tone = ZenToastTone.info,
  }) {
    // No overlay (a bare widget-test harness) means nothing to attach to.
    if (overlay == null) return;

    dismiss();

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (BuildContext context) => _ZenToastHost(
        message: message,
        tone: tone,
        onDismissed: () {
          if (identical(_entry, entry)) _entry = null;
          if (entry.mounted) entry.remove();
        },
      ),
    );
    _entry = entry;
    overlay.insert(entry);
  }

  /// A saved-to-deck confirmation: Jade Green tick.
  static void success(BuildContext context, String message) =>
      show(context, message, tone: ZenToastTone.success);

  /// A failed action: Cinnabar alert.
  static void error(BuildContext context, String message) =>
      show(context, message, tone: ZenToastTone.error);

  /// A neutral hint: the canonical app accent.
  static void info(BuildContext context, String message) =>
      show(context, message, tone: ZenToastTone.info);

  /// Removes the visible toast immediately, if any.
  static void dismiss() {
    final OverlayEntry? entry = _entry;
    _entry = null;
    if (entry != null && entry.mounted) entry.remove();
  }
}

/// The floating toast surface: seal tile, message, gold hairline.
class _ZenToastHost extends StatefulWidget {
  const _ZenToastHost({
    required this.message,
    required this.tone,
    required this.onDismissed,
  });

  final String message;
  final ZenToastTone tone;
  final VoidCallback onDismissed;

  @override
  State<_ZenToastHost> createState() => _ZenToastHostState();
}

class _ZenToastHostState extends State<_ZenToastHost>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: ZenMotion.swap,
  );
  late final Animation<double> _curved = CurvedAnimation(
    parent: _controller,
    curve: ZenMotion.enter,
  );
  bool _leaving = false;

  /// The dwell, held as a cancellable timer so a dismissed toast never leaves a
  /// pending timer behind (which also keeps widget tests deterministic).
  Timer? _dwell;

  @override
  void initState() {
    super.initState();
    // A toast is a one-shot surface: it dwells for the standard toast duration
    // and then leaves. This is a hold, not an animation timeline.
    _dwell = Timer(ZenMotion.toast, _leave);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // A controller's duration is fixed in initState, which has no BuildContext,
    // so the platform "Reduce Motion" flag is applied here: reduced motion snaps
    // it straight to the fully-visible resting state.
    MotionResolution.resolve(context, controller: _controller).apply();
  }

  @override
  void dispose() {
    _dwell?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _leave() async {
    if (!mounted || _leaving) return;
    _leaving = true;
    _dwell?.cancel();

    if (context.reduceMotion) {
      widget.onDismissed();
      return;
    }
    await _controller.reverse();
    if (!mounted) return;
    widget.onDismissed();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final _ZenToastPalette palette =
        _ZenToastPalette(tone: widget.tone, isDark: isDark);

    return Positioned(
      left: 20,
      right: 20,
      bottom: 24 + MediaQuery.viewPaddingOf(context).bottom,
      // Announced like a snackbar, but on our own surface.
      child: Semantics(
        liveRegion: true,
        container: true,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.08),
            end: Offset.zero,
          ).animate(_curved),
          child: FadeTransition(
            opacity: _curved,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _leave,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color:
                      isDark ? const Color(0xFF232326) : AppTheme.surfaceLight,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: palette.hairline, width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.black.withValues(alpha: isDark ? 0.5 : 0.18),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: palette.tile,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                          Icon(palette.icon, size: 19, color: palette.accent),
                    ),
                    const SizedBox(width: 12),
                    // Flexible so the longest translation (Russian/Vietnamese
                    // ~2x English) wraps instead of overflowing the row.
                    Expanded(
                      child: Text(
                        widget.message,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.5,
                          height: 1.25,
                          fontWeight: FontWeight.w600,
                          color: palette.ink,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Accent vocabulary for a toast, per `docs/UI_UX_STANDARDS.md` § Colours.
class _ZenToastPalette {
  _ZenToastPalette({required ZenToastTone tone, required bool isDark})
      : accent = switch (tone) {
          // Jade Green for success, Cinnabar for an error, otherwise the
          // canonical app accent (Cinnabar in light, Emperor's Gold in dark).
          ZenToastTone.success => const Color(0xFF2E7D32),
          ZenToastTone.error =>
            isDark ? Colors.redAccent : const Color(0xFFC62828),
          ZenToastTone.info =>
            isDark ? AppTheme.accentDark : AppTheme.accentLight,
        },
        icon = switch (tone) {
          ZenToastTone.success => Icons.check_rounded,
          ZenToastTone.error => Icons.error_outline_rounded,
          ZenToastTone.info => Icons.info_outline_rounded,
        },
        ink = isDark ? AppTheme.carbonInkDark : AppTheme.carbonInkLight,
        hairline = (isDark ? Colors.amber.shade700 : const Color(0xFFD4AF37))
            .withValues(alpha: 0.5);

  final Color accent;
  final IconData icon;
  final Color ink;
  final Color hairline;

  Color get tile => accent.withValues(alpha: 0.12);
}
