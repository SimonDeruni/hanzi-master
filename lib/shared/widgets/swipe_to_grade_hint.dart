import 'package:flutter/material.dart';

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
            style: TextStyle(
              fontSize: 13,
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
          Icon(icon, size: 14, color: colour),
          const SizedBox(width: 5),
          // Flexible, so a long localized grade name ("Schwierig") wraps
          // inside its chip instead of overflowing the row at 2x text scale.
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
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
