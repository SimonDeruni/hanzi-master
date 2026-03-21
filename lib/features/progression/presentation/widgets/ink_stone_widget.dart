import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/progression_service.dart';

class InkStoneWidget extends ConsumerStatefulWidget {
  const InkStoneWidget({super.key});

  @override
  ConsumerState<InkStoneWidget> createState() => _InkStoneWidgetState();
}

class _InkStoneWidgetState extends ConsumerState<InkStoneWidget> with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  int _lastPoints = 0;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.05), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.05, end: -0.05), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -0.05, end: 0.05), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 0.05, end: 0.0), weight: 1),
    ]).animate(_shakeController);
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progression = ref.watch(progressionProvider);

    // Trigger shake if points increased
    if (progression.inkPoints > _lastPoints && _lastPoints != 0) {
      _shakeController.forward(from: 0.0);
    }
    _lastPoints = progression.inkPoints;

    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _shakeAnimation.value,
          child: child,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFDFCF0), // Xuan Paper
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0x331A1A1B), width: 1), // Deep Carbon Ink, thin
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1A1A1B).withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left: Rank & Progress
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    progression.rank.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1B), // Deep Carbon Ink
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.water_drop, size: 14, color: Colors.indigo),
                      const SizedBox(width: 4),
                      Text(
                        "${progression.inkPoints} / ${progression.rank.index < ScholarRank.values.length - 1 ? ScholarRank.values[progression.rank.index + 1].requiredPoints : 'MAX'}",
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Right: Streak
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: progression.currentStreak > 0 ? Colors.orange.shade100 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: progression.currentStreak > 0 ? Colors.deepOrange : Colors.grey,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "${progression.currentStreak} Days",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: progression.currentStreak > 0 ? Colors.deepOrange.shade900 : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
