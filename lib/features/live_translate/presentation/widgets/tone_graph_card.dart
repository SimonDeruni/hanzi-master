import 'package:flutter/material.dart';
import 'package:hanzi_master/core/widgets/ltr_sanctuary.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/tone_graph_help.dart';

import 'tone_graph_painter.dart';

/// The measured pitch contour drawn against the shape that was asked for.
///
/// Three things make the graph readable, and all three are missing from the bare
/// [ToneGraphPainter]:
///
/// * a **lightbulb** — the rule that a second stroke appears *only* on a mismatch is
///   invisible otherwise, and a learner looking at the dashed stroke with no key
///   reasonably reads it as a reprimand;
/// * a **legend** — a dashed grey line and a solid blue one mean nothing to someone
///   who has never seen a pitch contour, so the key sits under the graph rather than
///   in a tooltip;
/// * an **empty state** — silence draws an empty box, and an empty box reads as a
///   failure. When no frame was voiced the card says so in words and keeps the target
///   stroke, because "we measured nothing" and "you got it wrong" are not the same
///   message and the second is what an empty graph implies.
///
/// The contour is drawn through `LtrSanctuary`: a pitch curve is directional, so under
/// RTL it would be mirrored and show the tone rising where it should fall.
class ToneGraphCard extends StatelessWidget {
  const ToneGraphCard({
    super.key,
    required this.userPitch,
    required this.idealPitch,
    this.height = 120,
    this.helpNote,
    this.caption,
    this.traceProgress = 1.0,
  });

  /// Hz per analysis window, `null` where nothing was voiced. This is the measured one.
  final List<double?> userPitch;

  /// Hz per point, `null` where a syllable has no fixed shape. This one is schematic.
  final List<double?> idealPitch;

  final double height;

  /// Appended to the shared explanation — used by the phrase graph, whose strokes are
  /// not time-aligned.
  final String? helpNote;

  final String? caption;
  final double traceProgress;

  /// The painter divides by `length - 1`, so a single point is not drawable.
  bool get _drawableUser => userPitch.length >= 2;

  bool get _hasPitch => _drawableUser && userPitch.any((p) => p != null && p > 0);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : const Color(0xFFFBFBF9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.brush,
                size: 13,
                color: isDark ? Colors.white60 : Colors.black54,
              ),
              const SizedBox(width: 5),
              // `Expanded` rather than a bare `Text`: with a button in this Row the
              // text-bearing child has to be flexible or a long translation overflows,
              // which is what `locale_layout_guard_test.dart` caught in Echo Hall when
              // this lightbulb was first added.
              Expanded(
                child: Text(
                  caption ?? l10n?.toneGraph ?? 'Tone Graph',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isDark ? Colors.white60 : Colors.black54,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              ToneGraphHelpButton(
                color: isDark ? Colors.white60 : Colors.black54,
                note: helpNote,
              ),
            ],
          ),
          const SizedBox(height: 6),
          LtrSanctuary(
            child: SizedBox(
              height: height,
              width: double.infinity,
              child: CustomPaint(
                painter: ToneGraphPainter(
                  idealPitch: idealPitch,
                  userPitch: _drawableUser ? userPitch : const [],
                  isLive: false,
                  traceProgress: traceProgress,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _LegendSwatch(
                color: Colors.blue.shade600,
                label: l10n?.toneGraphYourVoice ?? 'Your voice',
                style: _legendStyle(theme, isDark),
              ),
              const SizedBox(width: 16),
              _LegendSwatch(
                // Matches the alpha `ToneGraphPainter` draws the dashed target with.
                color: Colors.grey.shade400.withValues(alpha: 0.45),
                label: l10n?.toneGraphTarget ?? 'Target',
                style: _legendStyle(theme, isDark),
              ),
            ],
          ),
          if (!_hasPitch) ...[
            const SizedBox(height: 10),
            Text(
              l10n?.toneGraphNoPitchMeasured ?? '',
              style: theme.textTheme.bodySmall?.copyWith(
                height: 1.4,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }

  TextStyle? _legendStyle(ThemeData theme, bool isDark) =>
      theme.textTheme.labelSmall?.copyWith(
        fontSize: 11,
        color: isDark ? Colors.white60 : Colors.black54,
      );
}

/// A short line in the stroke's own colour, beside its name.
///
/// The swatch colour is taken from the same constants `ToneGraphPainter` draws with, so
/// the key cannot drift away from what it is explaining.
class _LegendSwatch extends StatelessWidget {
  const _LegendSwatch({
    required this.color,
    required this.label,
    this.style,
  });

  final Color color;
  final String label;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 3,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: style),
      ],
    );
  }
}
