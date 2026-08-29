import 'package:flutter/material.dart';

class ReadingProgressStrip extends StatelessWidget {
  final int totalSentences;
  final int currentSentenceIndex;
  final Color activeColor;
  final Color inactiveColor;

  const ReadingProgressStrip({
    super.key,
    required this.totalSentences,
    required this.currentSentenceIndex,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Wrap(
            spacing: 2,
            runSpacing: 2,
            children: List.generate(totalSentences, (i) {
              if (i < currentSentenceIndex) {
                return _dot(activeColor, 2.0, 6.0);
              } else if (i == currentSentenceIndex) {
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.3, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, child) {
                    return _dot(activeColor.withValues(alpha: value), 3.0, 8.0);
                  },
                );
              } else {
                return _dot(inactiveColor, 2.0, 6.0);
              }
            }),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          'Sent $currentSentenceIndex / $totalSentences',
          style: TextStyle(
            fontSize: 11,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }

  Widget _dot(Color color, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
