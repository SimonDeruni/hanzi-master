import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/monetization_service.dart';
import 'package:hanzi_master/core/services/notification_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/main_navigation_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/onboarding/presentation/onboarding_design.dart';
import 'package:hanzi_master/features/premium/presentation/screens/custom_paywall_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/widgets/zen_toast.dart';

class NotificationPermissionScreen extends ConsumerStatefulWidget {
  const NotificationPermissionScreen({super.key});

  @override
  ConsumerState<NotificationPermissionScreen> createState() =>
      _NotificationPermissionScreenState();
}

class _NotificationPermissionScreenState
    extends ConsumerState<NotificationPermissionScreen> {
  bool _isRequested = false;
  bool _isRequesting = false;
  bool _isNavigating = false;
  int _secretTapCount = 0;

  Future<void> _requestNotifications() async {
    if (_isRequesting) return;
    setState(() => _isRequesting = true);
    try {
      final service = ref.read(notificationServiceProvider);
      await service.init();
      final granted = await service.requestPermissions();
      if (granted) {
        await service.setPracticeReminder(enabled: true, hour: 9, minute: 0);
      }
    } catch (error) {
      debugPrint('Error enabling notifications: $error');
    } finally {
      if (mounted) {
        setState(() {
          _isRequesting = false;
          _isRequested = true;
        });
        Future<void>.delayed(const Duration(milliseconds: 600), () {
          if (mounted) _navigateToApp();
        });
      }
    }
  }

  Future<void> _navigateToApp() async {
    if (_isNavigating) return;
    _isNavigating = true;
    final isPremium = await MonetizationService.checkPremiumStatus();
    if (!mounted) return;

    if (isPremium) {
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder<void>(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MainNavigationScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
        (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder<void>(
          transitionDuration: ZenMotion.of(context, ZenMotion.page),
          reverseTransitionDuration: ZenMotion.pageReverse,
          pageBuilder: (context, animation, secondaryAnimation) =>
              const CustomPaywallScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: ZenMotion.enter,
              reverseCurve: ZenMotion.natural,
            );
            return FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.04),
                  end: Offset.zero,
                ).animate(curved),
                child: child,
              ),
            );
          },
        ),
        (route) => false,
      );
    }
  }

  void _handleSecretTap() {
    _secretTapCount++;
    if (_secretTapCount < 5) return;
    _secretTapCount = 0;
    MonetizationService.unlockDeveloperBackdoor();
    ZenToast.success(
        context, AppLocalizations.of(context)!.developerBackdoorUnlocked);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = _NotificationColors(
      Theme.of(context).brightness == Brightness.dark,
    );

    return Scaffold(
      backgroundColor: colors.background,
      body: CalligraphyBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              padding: OnboardingDesign.screenPadding,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight -
                      OnboardingDesign.topPadding -
                      OnboardingDesign.bottomPadding,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        _isRequested
                            ? l10n.notificationsConfigured
                            : l10n.neverMissAStroke2,
                        key: Key(
                          _isRequested
                              ? 'notifications_configured_title'
                              : 'notification_permission_title',
                        ),
                        style: TextStyle(
                          color: colors.text,
                          fontFamily: 'NotoSerifSC',
                          fontSize: OnboardingDesign.titleFontSize,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _isRequested
                            ? l10n.yourDailyDropAndStreakAlertsArePrim
                            : l10n.stayConsistentWithDailyRitualDropsA,
                        style: TextStyle(
                          color: colors.mutedText,
                          fontSize: OnboardingDesign.bodyFontSize,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: OnboardingDesign.sectionSpacing),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          key: const Key('notification_illustration'),
                          behavior: HitTestBehavior.opaque,
                          onTap: _handleSecretTap,
                          child: _NotificationIllustration(
                            colors: colors,
                            isConfigured: _isRequested,
                          ),
                        ),
                      ),
                      const SizedBox(height: OnboardingDesign.sectionSpacing),
                      _BenefitRow(
                        colors: colors,
                        icon: Icons.auto_stories_rounded,
                        title: l10n.dailyDrop,
                        description: l10n.aNewWordAndStoryWaitingForYourDaily,
                      ),
                      const SizedBox(height: 14),
                      _BenefitRow(
                        colors: colors,
                        icon: Icons.psychology_alt_rounded,
                        title: l10n.reviewReminders,
                        description: l10n.gentlePromptsBeforeCharactersFadeFr,
                      ),
                      const SizedBox(height: 14),
                      _BenefitRow(
                        colors: colors,
                        icon: Icons.event_available_rounded,
                        title: l10n.trialReminder,
                        description: l10n.receiveAReminder2DaysBeforeYourFree,
                      ),
                      const Spacer(),
                      const SizedBox(height: OnboardingDesign.sectionSpacing),
                      SizedBox(
                        height: OnboardingDesign.primaryButtonHeight,
                        child: FilledButton(
                          key: const Key('enable_notifications_button'),
                          onPressed:
                              _isRequesting ? null : _requestNotifications,
                          style: FilledButton.styleFrom(
                            backgroundColor: colors.primary,
                            foregroundColor: colors.onPrimary,
                            disabledBackgroundColor:
                                colors.primary.withValues(alpha: 0.65),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                OnboardingDesign.primaryButtonRadius,
                              ),
                            ),
                          ),
                          child: AnimatedSwitcher(
                            duration: ZenMotion.of(context, ZenMotion.swap),
                            child: _isRequesting
                                ? SizedBox(
                                    key: const ValueKey('loading'),
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.4,
                                      color: colors.onPrimary,
                                    ),
                                  )
                                : Row(
                                    key: const ValueKey('label'),
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        _isRequested
                                            ? Icons.check_rounded
                                            : Icons.notifications_none_rounded,
                                        size: 21,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          _isRequested
                                              ? l10n.continueText
                                              : l10n.enableNotifications,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize:
                                                OnboardingDesign.bodyFontSize,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      if (!_isRequested) ...[
                        const SizedBox(height: 8),
                        TextButton(
                          key: const Key('maybe_later_button'),
                          onPressed: _isNavigating ? null : _navigateToApp,
                          style: TextButton.styleFrom(
                            foregroundColor: colors.mutedText,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            l10n.maybeLater,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NotificationIllustration extends StatelessWidget {
  const _NotificationIllustration({
    required this.colors,
    required this.isConfigured,
  });

  final _NotificationColors colors;
  final bool isConfigured;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: ZenMotion.of(context, ZenMotion.swap),
        width: 88,
        height: 88,
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: colors.border),
        ),
        child: AnimatedSwitcher(
          duration: ZenMotion.of(context, ZenMotion.swap),
          child: Icon(
            isConfigured
                ? Icons.check_circle_outline_rounded
                : Icons.notifications_none_rounded,
            key: ValueKey(isConfigured),
            color: colors.text,
            size: 42,
          ),
        ),
      );
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({
    required this.colors,
    required this.icon,
    required this.title,
    required this.description,
  });

  final _NotificationColors colors;
  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.border, width: 1.5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: colors.mutedText, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: colors.mutedText,
                      fontSize: 13,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

class _NotificationColors {
  _NotificationColors(bool isDark)
      : background = isDark
            ? OnboardingDesign.backgroundDark
            : OnboardingDesign.backgroundLight,
        surface = isDark ? const Color(0xFF242422) : const Color(0xFFFFFFFF),
        text = isDark
            ? OnboardingDesign.backgroundLight
            : OnboardingDesign.backgroundDark,
        mutedText = isDark ? const Color(0xFFA9A59C) : const Color(0xFF706D66),
        primary = isDark
            ? OnboardingDesign.backgroundLight
            : OnboardingDesign.backgroundDark,
        onPrimary =
            isDark ? OnboardingDesign.backgroundDark : const Color(0xFFFFFFFF),
        border = isDark ? const Color(0xFF363532) : const Color(0xFFE8E2D8);

  final Color background;
  final Color surface;
  final Color text;
  final Color mutedText;
  final Color primary;
  final Color onPrimary;
  final Color border;
}
