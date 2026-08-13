import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/notification_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/main_navigation_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/premium/presentation/screens/paywall_sheet.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/core/services/monetization_service.dart';

class NotificationPermissionScreen extends ConsumerStatefulWidget {
  const NotificationPermissionScreen({
    super.key,
  });

  @override
  ConsumerState<NotificationPermissionScreen> createState() => _NotificationPermissionScreenState();
}

class _NotificationPermissionScreenState extends ConsumerState<NotificationPermissionScreen> {
  bool _isRequested = false;
  bool _isNavigating = false;
  int _secretTapCount = 0;

  Future<void> _navigateToApp() async {
    if (_isNavigating) return;
    _isNavigating = true;
    try {
      await PaywallSheet.show(context, isHardPaywall: true);
      
      // Enforce paywall: if they aren't premium, don't let them in!
      final isPremium = await MonetizationService.checkPremiumStatus();
      if (!isPremium) {
        _isNavigating = false;
        return; // Stay on the screen, force them to try again
      }
    } catch (e) {
      debugPrint('Paywall error during onboarding: $e');
      // If error occurs, we still enforce the check
      final isPremium = await MonetizationService.checkPremiumStatus();
      if (!isPremium) {
        _isNavigating = false;
        return;
      }
    }

    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const MainNavigationScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF1A1A1B);
    final surfaceColor = isDark ? const Color(0xFF2A2A2B) : const Color(0xFFFDFCF0);
    final buttonBg = isDark ? Colors.white : const Color(0xFF1A1A1B);
    final buttonFg = isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);

    return Scaffold(
      body: CalligraphyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(flex: 1),
                
                // Icon Header
                Center(
                  child: GestureDetector(
                    onTap: () {
                      _secretTapCount++;
                      if (_secretTapCount >= 5) {
                        MonetizationService.unlockDeveloperBackdoor();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Developer Backdoor Unlocked!')));
                        _secretTapCount = 0;
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.03),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isRequested ? Icons.notifications_active : Icons.notifications_active_rounded,
                        size: 64,
                        color: _isRequested ? Colors.green : const Color(0xFFD4C4A8),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 48),
                
                // Title
                Text(
                  _isRequested ? "Notifications Configured" : "Never Miss a Stroke",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    fontFamily: 'NotoSerifSC',
                    color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Description
                Text(
                  _isRequested
                      ? "Notifications have been set up successfully. Click Continue to proceed with your journey."
                      : "Turn on notifications to get your Word of the Day and friendly reminders when your flashcards are due for review.",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    height: 1.6,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
                
                const SizedBox(height: 48),

                // Bullet points
                _buildBenefitItem(
                  context,
                  icon: Icons.calendar_today,
                  title: "The Daily Spark",
                  description: "A new Word, Article, and Video waiting for you every morning.",
                ),
                const SizedBox(height: 24),
                _buildBenefitItem(
                  context,
                  icon: Icons.school,
                  title: "Spaced Repetition",
                  description: "Timely reminders to review your Hanzi before you forget them.",
                ),
                
                const Spacer(flex: 2),
                
                // Action Buttons
                if (!_isRequested)
                  BouncingButton(
                    onPressed: () async {
                      try {
                        final service = ref.read(notificationServiceProvider);
                        await service.init();
                        await service.requestPermissions();
                        // Schedule default daily drop at 9am
                        await service.scheduleDailyDrop(9, 0);
                      } catch (e) {
                        debugPrint('Error enabling notifications: $e');
                      } finally {
                        if (mounted) {
                          setState(() {
                            _isRequested = true;
                          });
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: buttonBg,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: textColor.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Enable Notifications",
                          style: TextStyle(
                            color: buttonFg,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                else
                  BouncingButton(
                    onPressed: _navigateToApp,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: buttonBg,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: textColor.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(
                            color: buttonFg,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                
                if (!_isRequested) ...[
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: _navigateToApp,
                    style: TextButton.styleFrom(
                      foregroundColor: isDark ? Colors.white60 : Colors.black54,
                    ),
                    child: const Text(
                      "Maybe Later",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitItem(BuildContext context, {required IconData icon, required String title, required String description}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFD4C4A8).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFFD4C4A8), size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
