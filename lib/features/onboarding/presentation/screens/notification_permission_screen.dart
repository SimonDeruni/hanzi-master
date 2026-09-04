import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/monetization_service.dart';
import 'package:hanzi_master/core/services/notification_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/main_navigation_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/premium/presentation/screens/custom_paywall_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

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
        MaterialPageRoute<void>(
          builder: (context) => const CustomPaywallScreen(),
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.developerBackdoorUnlocked),
      ),
    );
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
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: constraints.maxHeight - 44),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: _handleSecretTap,
                        child: _NotificationIllustration(colors: colors),
                      ),
                      const SizedBox(height: 28),
                      Text(
                        _isRequested
                            ? l10n.notificationsConfigured
                            : l10n.neverMissAStroke2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colors.text,
                          fontFamily: 'Serif',
                          fontSize: 32,
                          height: 1.12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _isRequested
                            ? l10n.yourDailyDropAndStreakAlertsArePrim
                            : l10n.stayConsistentWithDailyRitualDropsA,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colors.mutedText,
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 28),
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
                      const SizedBox(height: 32),
                      SizedBox(
                        height: 56,
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
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 180),
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
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.notifications_none_rounded,
                                        size: 21,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        _isRequested
                                            ? l10n.continueText
                                            : l10n.enableNotifications,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
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
  const _NotificationIllustration({required this.colors});

  final _NotificationColors colors;

  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          width: 118,
          height: 118,
          decoration: BoxDecoration(
            color: colors.accentSoft,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: 78,
              height: 78,
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(26),
                border: Border.all(color: colors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.notifications_none_rounded,
                    color: colors.accent,
                    size: 38,
                  ),
                  Positioned(
                    right: 16,
                    top: 16,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: colors.accent,
                        shape: BoxShape.circle,
                        border: Border.all(color: colors.surface, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: colors.border),
            ),
            child: Icon(icon, color: colors.accent, size: 21),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 1),
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
                  const SizedBox(height: 3),
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
          ),
        ],
      );
}

class _NotificationColors {
  _NotificationColors(bool isDark)
      : background = isDark ? const Color(0xFF171716) : const Color(0xFFFCFAF5),
        surface = isDark ? const Color(0xFF242422) : const Color(0xFFFFFFFF),
        text = isDark ? const Color(0xFFF7F3E9) : const Color(0xFF20201E),
        mutedText = isDark ? const Color(0xFFA9A59C) : const Color(0xFF706D66),
        primary = isDark ? const Color(0xFFF4EEE1) : const Color(0xFF25231F),
        onPrimary = isDark ? const Color(0xFF25231F) : const Color(0xFFFFFFFF),
        accent = const Color(0xFFC8873E),
        accentSoft = isDark ? const Color(0xFF332A20) : const Color(0xFFF4E8D7),
        border = isDark ? const Color(0xFF363532) : const Color(0xFFE8E2D8);

  final Color background;
  final Color surface;
  final Color text;
  final Color mutedText;
  final Color primary;
  final Color onPrimary;
  final Color accent;
  final Color accentSoft;
  final Color border;
}
