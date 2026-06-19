import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/streak_controller.dart';

class StreakSeal extends ConsumerWidget {
  const StreakSeal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streak = ref.watch(streakProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        // The "Seal" Look: Red border, slightly rounded corners
        color: Colors.red.withValues(alpha: 0.1),
        border: Border.all(color: Colors.red.shade800, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // The Character "印" (Seal/Mark) or just an icon
          Icon(Icons.verified_user, color: Colors.red.shade800, size: 20),
          const SizedBox(width: 8),
          Text(
            "$streak Days",
            style: TextStyle(
              color: Colors.red.shade900,
              fontWeight: FontWeight.bold,
              fontFamily: "Courier", // Monospace font looks more like a stamp
            ),
          ),
        ],
      ),
    );
  }
}
