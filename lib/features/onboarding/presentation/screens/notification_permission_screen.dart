import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/notification_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';

class NotificationPermissionScreen extends ConsumerWidget {
  final VoidCallback onComplete;

  const NotificationPermissionScreen({
    super.key,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.03),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications_active_rounded,
                      size: 64,
                      color: Color(0xFFD4C4A8),
                    ),
                  ),
                ),
                
                const SizedBox(height: 48),
                
                // Title
                Text(
                  "Never Miss a Stroke",
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
                  "Turn on notifications to get your Word of the Day and friendly reminders when your flashcards are due for review.",
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
                BouncingButton(
                  onPressed: () async {
                    final service = ref.read(notificationServiceProvider);
                    await service.init();
                    await service.requestPermissions();
                    // Schedule default daily drop at 9am
                    await service.scheduleDailyDrop(9, 0);
                    onComplete();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1B),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1A1A1B).withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "Enable Notifications",
                        style: TextStyle(
                          color: Color(0xFFFDFCF0),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                TextButton(
                  onPressed: onComplete,
                  style: TextButton.styleFrom(
                    foregroundColor: isDark ? Colors.white60 : Colors.black54,
                  ),
                  child: const Text(
                    "Maybe Later",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
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
            color: const Color(0xFFD4C4A8).withOpacity(0.15),
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
