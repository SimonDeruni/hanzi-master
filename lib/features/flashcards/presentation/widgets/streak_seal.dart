import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/streak_controller.dart';

class StreakSeal extends ConsumerWidget {
  const StreakSeal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Note: the streakProvider might return an AsyncValue or an int, let's assume it returns an int directly based on how it was used earlier ("$streak Days"), but wait, the view says "final streak = ref.watch(streakProvider);"
    // Oh, wait, in global_sliver_app_bar.dart I saw "streakProvider.valueOrNull?.streakCount". Wait, in StreakSeal it just uses "$streak". Let's preserve however it was used.
    final streak = ref.watch(streakProvider);
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFDE8E1), // Light peach background
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE89B84), width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Color(0xFFE27C5A),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.local_fire_department, color: Colors.white, size: 12),
          ),
          const SizedBox(width: 6),
          Text(
            "$streak DAYS STREAK",
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: const Color(0xFF90432E),
              letterSpacing: 0.5,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
