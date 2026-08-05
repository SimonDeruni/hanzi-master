import 'package:flutter/material.dart';

class InteractiveGradingText extends StatelessWidget {
  final String text;
  final List<dynamic>? wordScores; // From Azure
  final Function(int charIndex, Map<String, dynamic> scoreData) onCharTap;

  const InteractiveGradingText({
    super.key,
    required this.text,
    this.wordScores,
    required this.onCharTap,
  });

  @override
  Widget build(BuildContext context) {
    if (wordScores == null || wordScores!.isEmpty) {
      return Text(
        text,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      );
    }

    final spans = <TextSpan>[];
    int charCount = 0;

    for (var word in wordScores!) {
      final String wordText = word['Word'] ?? '';
      final double accuracy = (word['PronunciationAssessment']?['AccuracyScore'] ?? 0).toDouble();
      
      Color color;
      if (accuracy >= 80) {
        color = Colors.green.shade700;
      } else if (accuracy >= 60) {
        color = Colors.orange.shade700;
      } else {
        color = Colors.red.shade700;
      }

      for (int i = 0; i < wordText.length; i++) {
        final currentIndex = charCount;
        spans.add(TextSpan(
          text: wordText[i],
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: color,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.dotted,
          ),
          // We can't easily add tap gesture directly to TextSpan in a simple way without GestureRecognizer,
          // so for simplicity in this prototype, we'll just return standard spans here and wrap 
          // the whole text in a gesture detector that finds the word, or we can use WidgetSpans.
        ));
        charCount++;
      }
      
      // Add space between words if needed (for Chinese usually not needed, but Azure splits them)
      spans.add(const TextSpan(text: ' '));
    }

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: spans),
    );
  }
}
