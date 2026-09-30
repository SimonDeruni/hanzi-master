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

  /// Extra lines appended to the shared explanation, for graphs whose rules differ
  /// from the single-character case.
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
///
/// **The content owns the scroll view, and `zenSheet` is not asked to add one.**
/// This is the one panel in the app whose text is not a label: six lines at 2.0x
/// scale are taller than an iPhone SE, and both forms have to survive that — the
/// bottom sheet because `isScrollControlled: true` bounds it to the window, the
/// dialog because `ZenOverlayFrame` caps it at 85% of the window. Nesting the two
/// scroll views (`zenSheet(scrollable: true)`) would hand this one an unbounded
/// viewport instead, which is an assertion, not a layout.
Future<void> showToneGraphHelp(BuildContext context, {String? note}) {
  return zenSheet<void>(
    context,
    builder: (sheetContext) {
      final l10n = AppLocalizations.of(sheetContext);
      final theme = Theme.of(sheetContext);
      return SingleChildScrollView(
        child: Padding(
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
              const SizedBox(height: 12),
              _HelpBullets(
                text: l10n?.toneGraphHowToReadBody ?? '',
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
                bulletColor: theme.colorScheme.primary,
              ),
              // A surface whose graph follows different rules says so here, in its
              // own words, rather than having the shared explanation rewritten to
              // fit the one case that differs.
              if (note != null && note.isNotEmpty) ...[
                const SizedBox(height: 14),
                _HelpBullets(
                  text: note,
                  style: theme.textTheme.bodySmall?.copyWith(
                    height: 1.4,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  bulletColor: theme.colorScheme.outline,
                ),
              ],
            ],
          ),
        ),
      );
    },
  );
}

/// One bullet per `\n` in a translated value.
///
/// The explanation used to reach the screen as a single 590-character paragraph
/// (880 with the shadowing studio's phrase note) behind a lightbulb a learner taps
/// *mid-drill*. It is a reference card, not an essay: the rule that has to land —
/// a second stroke is drawn only on a mismatch, and one stroke never means
/// "wrong" — is one of four short lines now, and the rest is scannable at a
/// glance.
///
/// **The line breaks live in the ARB, not here.** Splitting the string in code
/// would need a delimiter that is not part of any language's prose; a newline is
/// one the translators can see and keep. `l10n_arb_parity_test` pins the budget
/// (four lines of at most 130 characters, plus two for the note) so it cannot
/// quietly grow back into a wall of text in one locale.
///
/// A `Row` per line rather than one `Text` with `\n`: the marker is then placed by
/// `Directionality`, so a bullet sits on the right in Arabic without a second
/// RTL branch here. The text itself is `Expanded`, which is what keeps a
/// translation that expands ~2x (Russian, Vietnamese) from overflowing.
class _HelpBullets extends StatelessWidget {
  const _HelpBullets({
    required this.text,
    this.style,
    this.bulletColor,
  });

  final String text;
  final TextStyle? style;
  final Color? bulletColor;

  @override
  Widget build(BuildContext context) {
    final List<String> lines = text
        .split('\n')
        .map((String line) => line.trim())
        .where((String line) => line.isNotEmpty)
        .toList();
    if (lines.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int index = 0; index < lines.length; index++)
          Padding(
            padding: EdgeInsets.only(top: index == 0 ? 0 : 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // The marker the app already uses for a bullet line (see
                // `tappable_hanzi_text.dart`), so a list looks the same here.
                Text(
                  '•',
                  style: (style ?? const TextStyle()).copyWith(color: bulletColor),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(lines[index], style: style)),
              ],
            ),
          ),
      ],
    );
  }
}
