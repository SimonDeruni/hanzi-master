import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/notification_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/main_navigation_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/premium/presentation/screens/custom_paywall_screen.dart';
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

    final isPremium = await MonetizationService.checkPremiumStatus();
    
    if (mounted) {
      if (isPremium) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const MainNavigationScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      } else {
        _isNavigating = false;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CustomPaywallScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);
    final textColor = isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    const accentColor = Color(0xFFD4C4A8);
    final btnBgColor = isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    final btnTextColor = isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);

    return Scaffold(
      backgroundColor: bgColor,
      body: CalligraphyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                
                // Icon Header
                Center(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      _secretTapCount++;
                      if (_secretTapCount >= 5) {
                        MonetizationService.unlockDeveloperBackdoor();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Developer Backdoor Unlocked!')));
                        _secretTapCount = 0;
                      }
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: textColor.withValues(alpha: 0.05),
                        shape: BoxShape.circle,
                        border: Border.all(color: textColor.withValues(alpha: 0.08)),
                      ),
                      child: Icon(
                        _isRequested ? Icons.check_circle_outline : Icons.notifications_active_outlined,
                        size: 38,
                        color: _isRequested ? Colors.green[600] : accentColor,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Title
                Text(
                  _isRequested ? "Notifications Configured" : "Never Miss a Stroke",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 28,
                    fontFamily: 'Serif',
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Description
                Text(
                  _isRequested
                      ? "Your daily drop and streak alerts are primed."
                      : "Stay consistent with daily ritual drops and timely trial reminders.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor.withValues(alpha: 0.65),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                
                const SizedBox(height: 24),

                // Benefit Cards
                _buildBenefitCard(
                  icon: Icons.auto_awesome,
                  title: "The Daily Spark",
                  description: "A new Word, Article, and Video waiting for your daily ritual.",
                  isDark: isDark,
                  textColor: textColor,
                  accentColor: accentColor,
                ),
                const SizedBox(height: 12),
                _buildBenefitCard(
                  icon: Icons.alarm,
                  title: "Smart Spaced Repetition",
                  description: "Gentle prompts before characters fade from your memory.",
                  isDark: isDark,
                  textColor: textColor,
                  accentColor: accentColor,
                ),
                const SizedBox(height: 12),
                _buildBenefitCard(
                  icon: Icons.shield_outlined,
                  title: "Trial Protection Alert",
                  description: "Receive a reminder 2 days before your free trial ends.",
                  isDark: isDark,
                  textColor: textColor,
                  accentColor: accentColor,
                ),
                
                const Spacer(),
                
                // Action Buttons
                if (!_isRequested)
                  BouncingButton(
                    onPressed: () async {
                      try {
                        final service = ref.read(notificationServiceProvider);
                        await service.init();
                        await service.requestPermissions();
                        await service.scheduleDailyDrop(9, 0);
                      } catch (e) {
                        debugPrint('Error enabling notifications: $e');
                      } finally {
                        if (mounted) {
                          setState(() {
                            _isRequested = true;
                          });
                          // Smoothly advance to paywall after brief delay
                          Future.delayed(const Duration(milliseconds: 600), () {
                            if (mounted) _navigateToApp();
                          });
                        }
                      }
                    },
                    child: Container(
                      height: 54,
                      decoration: BoxDecoration(
                        color: btnBgColor,
                        borderRadius: BorderRadius.circular(27),
                        boxShadow: [
                          BoxShadow(
                            color: btnBgColor.withValues(alpha: 0.1),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Enable Notifications",
                          style: TextStyle(
                            color: btnTextColor,
                            fontSize: 16,
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
                      height: 54,
                      decoration: BoxDecoration(
                        color: btnBgColor,
                        borderRadius: BorderRadius.circular(27),
                        boxShadow: [
                          BoxShadow(
                            color: btnBgColor.withValues(alpha: 0.1),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(
                            color: btnTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                
                if (!_isRequested) ...[
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: _navigateToApp,
                    style: TextButton.styleFrom(
                      foregroundColor: textColor.withValues(alpha: 0.5),
                    ),
                    child: const Text(
                      "Maybe Later",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                ] else ...[
                  const SizedBox(height: 38),
                ],
                const SizedBox(height: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isDark,
    required Color textColor,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2B) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.06),
        ),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: accentColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.3,
                    color: textColor.withValues(alpha: 0.6),
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
