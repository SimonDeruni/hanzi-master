import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/app_rating_service.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/zen_overlay.dart';

/// Calligraphic bottom sheet modal offering a sentiment check ("Happy Filter")
/// before routing happy learners to the App Store 5-star review dialog
/// and learners needing assistance to private support/feedback.
class ZenRatingSheet extends ConsumerWidget {
  final String trigger;

  const ZenRatingSheet({
    super.key,
    this.trigger = 'milestone',
  });

  /// Presents the calligraphic rating sheet.
  /// Returns `true` if positive, `false` if feedback, or `null` if dismissed.
  static Future<bool?> show(
    BuildContext context, {
    String trigger = 'milestone',
  }) {
    HapticsManager.light();
    return zenSheet<bool>(context,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => ZenRatingSheet(trigger: trigger),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final ratingService = ref.read(appRatingServiceProvider);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF1E1E22) : const Color(0xFFFDFCF0);
    final primaryText = isDark ? Colors.white : const Color(0xFF1A1A1B);
    final secondaryText = isDark ? Colors.white70 : const Color(0xFF6B655B);
    final goldBorder =
        isDark ? Colors.amber.shade700 : const Color(0xFFD4AF37);
    final primaryBtnBg =
        isDark ? Colors.amber.shade700 : const Color(0xFF1A1A1B);
    final primaryBtnText = isDark ? const Color(0xFF1A1A1B) : Colors.white;

    return Container(
      padding: EdgeInsets.fromLTRB(
        24,
        16,
        24,
        24 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(
            color: goldBorder.withValues(alpha: 0.35),
            width: 1.2,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.6 : 0.16),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? Colors.white24 : Colors.black12,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
// Glowing Star Badge
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: isDark ? 0.2 : 0.12),
              shape: BoxShape.circle,
              border: Border.all(
                color: goldBorder.withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.star_rounded,
              color: Colors.amber,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
// Title
          Text(
            l10n.enjoyingAppTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: primaryText,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 8),
// Subtitle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              l10n.enjoyingAppSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: secondaryText,
              ),
            ),
          ),
          const SizedBox(height: 24),
// Primary: "Yes, loving it!" (❤️) -> Triggers Apple App Store Review
          SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton.icon(
              onPressed: () async {
                HapticsManager.medium();
                Navigator.of(context).pop(true);
                await ratingService.onPositiveSentiment(context, trigger: trigger);
              },
              icon: const Icon(Icons.favorite_rounded, size: 18, color: Colors.redAccent),
              label: Text(
                l10n.ratingLovingIt,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: primaryBtnText,
                ),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: primaryBtnBg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
            ),
          ),
          const SizedBox(height: 12),
// Secondary: "Could be better" (💬) -> Opens Private Feedback
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton.icon(
              onPressed: () async {
                HapticsManager.light();
                Navigator.of(context).pop(false);
                await ratingService.onNegativeSentiment(context, trigger: trigger);
              },
              icon: Icon(Icons.chat_bubble_outline_rounded, size: 18, color: secondaryText),
              label: Text(
                l10n.ratingCouldBeBetter,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.5,
                  color: primaryText,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: goldBorder.withValues(alpha: 0.4),
                  width: 1.1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
// Tertiary: "Maybe Later"
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(null);
              await ratingService.onDismissSentiment();
            },
            child: Text(
              l10n.maybeLater,
              style: TextStyle(
                fontSize: 13,
                color: secondaryText.withValues(alpha: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
