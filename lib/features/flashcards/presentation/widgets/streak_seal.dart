import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/streak_controller.dart';

class StreakSeal extends ConsumerWidget {
  const StreakSeal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          Builder(builder: (context) {
            final flame = Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Color(0xFFE27C5A),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.local_fire_department,
                  color: Colors.white, size: 12),
            );

            return streak > 0
                ? flame
                    .animate(
                        onPlay: (controller) =>
                            controller.repeat(reverse: true))
                    .scaleXY(end: 1.1, duration: 1.seconds)
                : flame;
          }),
          const SizedBox(width: 6),
          Text(
            streak > 0 ? "$streak DAYS STREAK" : "START YOUR STREAK",
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
