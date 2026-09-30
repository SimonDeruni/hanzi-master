import 'package:flutter/material.dart';

import 'package:hanzi_master/core/layout/zen_layout.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/hanko_seal_stamp.dart';

/// The "Swipe to Grade" legend shown beneath a study card.
///
/// The four grades are the same four Hanko seals [SwipeableFlashcard] stamps
/// mid-swipe, so the legend teaches the gesture with the colours the learner is
/// about to see: Deep Cinnabar for again, Scholar Pine for good, Emperor's Gold
/// for easy and Imperial Ochre for hard. Each entry pairs the seal colour with
/// the direction of the swipe and the localized grade name.
///
/// This replaced a single hardcoded string of emoji arrows
/// (`'⬅️ ${again} ➡️ ${good} …'`): the emoji rendered as empty tofu boxes
/// wherever the emoji font was missing, the names could not be translated
/// independently, and one unbreakable `Text` could not wrap on a 320px screen.
class SwipeToGradeHint extends StatelessWidget {
  const SwipeToGradeHint({super.key});

  /// The strip the legend occupies beneath a study card.
  ///
  /// One value for every host, because this strip is *subtracted from the card's
  /// swipe surface*: the legend is a sibling of the card's `Expanded` in the
  /// screen's column, so whatever the strip takes, the swipeable card loses.
  /// Measured on a 320x568 screen, revealing the answer drops the surface from
  /// 464 to 347 — the legend is 101 of that 117, and this padding is the rest.
  /// At 2x text the clamped chips stop fitting two to a row, so the legend
  /// itself grows to 184 and the surface falls to 264: the row count, not the
  /// text scale, is what drives the strip.
  ///
  /// Four hosts used to pad 32 here and the review screen 16, so the same card
  /// came out two different sizes depending on which screen was grading it.
  ///
  /// Reserving the strip *before* the reveal would remove the resize entirely,
  /// but it buys that by spending the card's height on an empty band for the
  /// whole session — including the pre-reveal state, which is where the learner
  /// is actually reading the character. So the legend stays a revealed-state
  /// hint on every host, and the way to give the card its height back on a wide
  /// window is to move the legend *beside* the card (see IPAD_ADAPTIVE_PLAN.md,
  /// the split bench for rows 14/15) rather than under it.
  static const EdgeInsets stripPadding = EdgeInsets.fromLTRB(16, 0, 16, 16);

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return MediaQuery.withClampedTextScaling(
      // The legend is a gesture hint, not content, so it must never grow into
      // the card. At 2x text on a 320x568 screen the four chips took 373 of the
      // 464 available pixels and squeezed the character into 59px. The card
      // itself still honours the learner's full text scale.
      maxScaleFactor: 1.3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            l10n.swipeToGrade,
            textAlign: TextAlign.center,
            // Ramps on a wide window. Under a phone-width card a 13dp caption
            // reads as the card's legend; under an iPad-width one it was a
            // hairline strip floating at the bottom of the pane, which is what
            // "the Balayez pour noter is a bit weird on iPad" was looking at.
            style: TextStyle(
              fontSize: zenValue(context, compact: 13.0, expanded: 15.0),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
              color: _ink(context).withValues(alpha: 0.55),
            ),
          ),
          const SizedBox(height: 12),
          // A Wrap, never a Row: four chips of localized grade names cannot share
          // one line at 320px with a 2x text scale, and a Wrap only breaks the
          // line instead of overflowing the screen.
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _GradeChip(
                seal: HankoSealData.again,
                icon: Icons.arrow_back_rounded,
                label: l10n.again,
              ),
              _GradeChip(
                seal: HankoSealData.good,
                icon: Icons.arrow_forward_rounded,
                label: l10n.good,
              ),
              _GradeChip(
                seal: HankoSealData.easy,
                icon: Icons.arrow_upward_rounded,
                label: l10n.easy,
              ),
              _GradeChip(
                seal: HankoSealData.hard,
                icon: Icons.arrow_downward_rounded,
                label: l10n.hard,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// The canonical ink for the current brightness. Never a raw Material grey.
Color _ink(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
        ? AppTheme.carbonInkDark
        : AppTheme.carbonInkLight;

/// One legend entry: the seal colour, the swipe direction and the grade name.
class _GradeChip extends StatelessWidget {
  const _GradeChip({
    required this.seal,
    required this.icon,
    required this.label,
  });

  final HankoSealData seal;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final Color colour = seal.primaryColor;

    // Ramp with the heading above; a phone-width card is unchanged.
    final double chipIconSize = zenValue(context, compact: 14.0, expanded: 16.0);
    final double chipLabelSize =
        zenValue(context, compact: 12.0, expanded: 13.5);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: zenValue(context, compact: 10.0, expanded: 12.0),
        vertical: zenValue(context, compact: 6.0, expanded: 7.0),
      ),
      decoration: BoxDecoration(
        // The book screen's chip geometry: a 0.08 wash inside a 0.35 hairline
        // of the same colour.
        color: colour.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colour.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: chipIconSize, color: colour),
          const SizedBox(width: 5),
          // Flexible, so a long localized grade name ("Schwierig") wraps
          // inside its chip instead of overflowing the row at 2x text scale.
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: chipLabelSize,
                fontWeight: FontWeight.w600,
                color: _ink(context).withValues(alpha: 0.75),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
