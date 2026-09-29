import 'package:flutter/material.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/zen_overlay.dart';

/// A lightbulb beside a tone contour that explains how to read it.
///
/// The contour is the one graphic in the tone surfaces whose meaning is not
/// self-evident, and the rule it encodes is invisible unless someone says it:
/// **a second stroke is drawn only on a mismatch**. Because `actualTone == 0` means
/// "not measured" — the convention audit 39 established and
/// `CalligraphicPitchContour`/`SpeakingFeedbackPanel` both honour — a learner
/// looking at a single stroke cannot tell *"I matched the target"* from *"nothing
/// measured this"*, and the second reading is the one that feels like a reprimand
/// when it is not one. The explainer says so in as many words.
///
/// A surface whose graph follows *different* rules adds them through [note] rather
/// than by rewriting the shared text — the phrase graph in the shadowing studio is
/// the case that exists, and its difference (the two strokes are not time-aligned)
/// would be a lie if it were told to someone reading a single character.
class ToneGraphHelpButton extends StatelessWidget {
  const ToneGraphHelpButton({
    super.key,
    this.color,
    this.size = 16,
    this.note,
  });

  /// Matches the caption it sits beside; falls back to the theme when omitted.
  final Color? color;
  final double size;

  /// An extra paragraph appended to the shared explanation, for graphs whose
  /// rules differ from the single-character case.
  final String? note;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final label = l10n?.toneGraphHowToReadTooltip ?? 'How to read this graph';
    return IconButton(
      icon: Icon(Icons.lightbulb_outline, size: size),
      tooltip: label,
      color: color ?? Theme.of(context).colorScheme.onSurfaceVariant,
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
      onPressed: () => showToneGraphHelp(context, note: note),
    );
  }
}

/// Opens the "how to read this graph" explanation, with [note] appended when given.
///
/// Routed through `zenSheet` so the tablet form is a width-capped dialog rather
/// than a phone sheet stretched across a 1366dp window (F5 of
/// `docs/IPAD_ADAPTIVE_PLAN.md`).
Future<void> showToneGraphHelp(BuildContext context, {String? note}) {
  return zenSheet<void>(
    context,
    builder: (sheetContext) {
      final l10n = AppLocalizations.of(sheetContext);
      final theme = Theme.of(sheetContext);
      return Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n?.toneGraphHowToReadTitle ?? 'How to read this graph',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              l10n?.toneGraphHowToReadBody ?? '',
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
            // A surface whose graph follows different rules says so here, in its
            // own words, rather than having the shared explanation rewritten to
            // fit the one case that differs.
            if (note != null && note.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                note,
                style: theme.textTheme.bodySmall?.copyWith(
                  height: 1.5,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      );
    },
  );
}
