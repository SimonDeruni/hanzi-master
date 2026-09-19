import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/global_blurred_bottom_sheet.dart';
import 'package:hanzi_master/features/settings/presentation/screens/ai_data_privacy_screen.dart';

/// In-app AI consent and disclosure bottom sheet complying with
/// Apple App Store Review Guidelines 5.1.1(i) and 5.1.2(i).
class AiConsentSheet extends StatelessWidget {
  const AiConsentSheet({super.key});

  static const String prefKey = 'has_agreed_to_ai_privacy';

  /// Ensures user has given consent for third-party AI services.
  /// If already granted, returns true immediately without showing any UI.
  /// Otherwise, presents the AiConsentSheet modal.
  /// Returns true if the user tapped "Agree & Continue", false if dismissed/cancelled.
  static Future<bool> ensureConsent(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(prefKey) == true) {
      return true;
    }

    if (!context.mounted) return false;

    final agreed = await GlobalBlurredBottomSheet.show<bool>(
      context,
      child: const AiConsentSheet(),
    );

    if (agreed == true) {
      await prefs.setBool(prefKey, true);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final primaryText =
        isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    final secondaryText = isDark ? Colors.white70 : Colors.black54;
    final cardBg = isDark
        ? const Color(0xFF2C2C2E)
        : Colors.black.withValues(alpha: 0.035);
    final cardBorder = isDark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.black.withValues(alpha: 0.06);

    const accentGold = Color(0xFFD4AF37);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Header Icon & Title ────────────────────────────────
            Center(
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accentGold.withValues(alpha: isDark ? 0.16 : 0.12),
                  border: Border.all(
                    color: accentGold.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: accentGold,
                  size: 28,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.aiConsentTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'NotoSerifSC',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: primaryText,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.aiConsentSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.4,
                color: secondaryText,
              ),
            ),
            const SizedBox(height: 18),

            // ── Disclosure Cards ──────────────────────────────────
            _ConsentTile(
              icon: Icons.record_voice_over_outlined,
              iconColor: const Color(0xFF0D9488),
              title: l10n.aiConsentDataSentTitle,
              body: l10n.aiConsentDataSentBody,
              cardBg: cardBg,
              cardBorder: cardBorder,
              primaryText: primaryText,
              secondaryText: secondaryText,
            ),
            const SizedBox(height: 10),
            _ConsentTile(
              icon: Icons.cloud_outlined,
              iconColor: const Color(0xFF2563EB),
              title: l10n.aiConsentProvidersTitle,
              body: l10n.aiConsentProvidersBody,
              cardBg: cardBg,
              cardBorder: cardBorder,
              primaryText: primaryText,
              secondaryText: secondaryText,
            ),
            const SizedBox(height: 10),
            _ConsentTile(
              icon: Icons.shield_outlined,
              iconColor: accentGold,
              title: l10n.aiConsentGuaranteesTitle,
              body: l10n.aiConsentGuaranteesBody,
              cardBg: cardBg,
              cardBorder: cardBorder,
              primaryText: primaryText,
              secondaryText: secondaryText,
            ),
            const SizedBox(height: 20),

            // ── Primary Action: Agree & Continue ───────────────────
            FilledButton.icon(
              onPressed: () => Navigator.of(context).pop(true),
              icon: const Icon(Icons.check_rounded, size: 20),
              label: Text(
                l10n.aiConsentAgree,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: accentGold,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
            ),
            const SizedBox(height: 6),

            // ── Secondary Action: Learn More ───────────────────────
            TextButton.icon(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                    builder: (context) => const AiDataPrivacyScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.info_outline_rounded, size: 16),
              label: Text(
                l10n.aiConsentLearnMore,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConsentTile extends StatelessWidget {
  const _ConsentTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.body,
    required this.cardBg,
    required this.cardBorder,
    required this.primaryText,
    required this.secondaryText,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String body;
  final Color cardBg;
  final Color cardBorder;
  final Color primaryText;
  final Color secondaryText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: primaryText,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.35,
                    color: secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
