import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/features/onboarding/presentation/onboarding_design.dart';
import 'package:hanzi_master/features/settings/presentation/screens/ai_data_privacy_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/global_blurred_bottom_sheet.dart';

/// In-app AI consent and disclosure bottom sheet complying with
/// Apple App Store Review Guidelines 5.1.1(i) and 5.1.2(i).
///
/// Dressed as one of the onboarding lesson surfaces (`OnboardingDesign`) rather
/// than as a dialog: the cinnabar tracked eyebrow over a serif title, the 16pt
/// ink body, crisp white / `#2A2A2B` cards behind a hairline border and the
/// lesson's own full-width ink button. The consent interrupts Step 2 of the
/// mini lesson ("Shadow"), so it should read as the next beat of that flow.
class AiConsentSheet extends StatelessWidget {
  const AiConsentSheet({super.key});

  static const String prefKey = 'has_agreed_to_ai_privacy';

  /// Ensures the learner has agreed to third-party AI services.
  ///
  /// Already granted: returns true with no UI at all. Otherwise presents the
  /// sheet and returns true only for "Agree to Use AI" — a barrier tap, a drag
  /// or the system back gesture returns false and persists nothing.
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
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color ink =
        isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    final Color parchment = isDark
        ? OnboardingDesign.backgroundDark
        : OnboardingDesign.backgroundLight;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Disclosures: scrolled only if they outgrow the sheet ──
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                OnboardingDesign.horizontalPadding,
                0,
                OnboardingDesign.horizontalPadding,
                8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Header: eyebrow, serif title, intro (the lesson header) ──
                  Text(
                    l10n.hanziMaster1.toUpperCase(),
                    style: TextStyle(
                      color: Colors.red[700],
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.aiConsentTitle,
                    style: TextStyle(
                      fontFamily: 'NotoSerifSC',
                      fontSize: OnboardingDesign.titleFontSize,
                      height: 1.2,
                      color: ink,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.aiConsentSubtitle,
                    style: TextStyle(
                      fontSize: OnboardingDesign.bodyFontSize,
                      height: 1.45,
                      color: ink.withValues(alpha: .7),
                    ),
                  ),
                  const SizedBox(height: OnboardingDesign.sectionSpacing),
                  // ── Disclosure: what leaves the device, who receives it, the
                  //    guarantees we make about it ────────────────────────────
                  _ConsentTile(
                    icon: Icons.record_voice_over_outlined,
                    tint: Colors.red[700]!,
                    title: l10n.aiConsentDataSentTitle,
                    body: l10n.aiConsentDataSentBody,
                    isDark: isDark,
                    ink: ink,
                  ),
                  const SizedBox(height: 12),
                  _ConsentTile(
                    icon: Icons.cloud_outlined,
                    tint: const Color(0xFF4F46E5),
                    title: l10n.aiConsentProvidersTitle,
                    body: l10n.aiConsentProvidersBody,
                    isDark: isDark,
                    ink: ink,
                  ),
                  const SizedBox(height: 12),
                  _ConsentTile(
                    icon: Icons.shield_outlined,
                    tint: const Color(0xFF2E7D32),
                    title: l10n.aiConsentGuaranteesTitle,
                    body: l10n.aiConsentGuaranteesBody,
                    isDark: isDark,
                    ink: ink,
                  ),
                ],
              ),
            ),
          ),

          // ── Actions: pinned, so consent is always one tap away ──────
          Padding(
            padding: const EdgeInsets.fromLTRB(
              OnboardingDesign.horizontalPadding,
              8,
              OnboardingDesign.horizontalPadding,
              20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: OnboardingDesign.primaryButtonHeight,
                  child: FilledButton.icon(
                    key: const Key('ai_consent_agree'),
                    onPressed: () => Navigator.of(context).pop(true),
                    icon: const Icon(Icons.check_rounded, size: 20),
                    label: Text(
                      l10n.aiConsentAgree,
                      style: const TextStyle(
                        fontSize: OnboardingDesign.bodyFontSize,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: ink,
                      foregroundColor: parchment,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          OnboardingDesign.primaryButtonRadius,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),

                // ── Secondary action: the full disclosure ─────────────
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (context) => const AiDataPrivacyScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.info_outline_rounded, size: 16),
                  label: Text(l10n.aiConsentLearnMore),
                  style: TextButton.styleFrom(
                    foregroundColor: ink.withValues(alpha: .7),
                    padding: const EdgeInsets.symmetric(vertical: 8),
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

/// One disclosure row — a tinted glyph and two lines of ink on a lesson card:
/// white on parchment, `#2A2A2B` in the dark theme, behind the same hairline
/// border and soft lift the lesson's own cards carry.
class _ConsentTile extends StatelessWidget {
  const _ConsentTile({
    required this.icon,
    required this.tint,
    required this.title,
    required this.body,
    required this.isDark,
    required this.ink,
  });

  final IconData icon;
  final Color tint;
  final String title;
  final String body;
  final bool isDark;
  final Color ink;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2B) : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: (isDark ? Colors.white : Colors.black).withValues(alpha: .06),
        ),
        boxShadow: [
          BoxShadow(
            color:
                (isDark ? Colors.white : Colors.black).withValues(alpha: .02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: tint.withValues(alpha: isDark ? .18 : .1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: tint, size: 19),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                    color: ink,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: ink.withValues(alpha: .62),
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
