import 'package:flutter/material.dart';
import '../../../../core/models/pronunciation_grade.dart';

class PronunciationReportSheet extends StatelessWidget {
  final PronunciationGrade grade;

  const PronunciationReportSheet({super.key, required this.grade});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Report',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Character Breakdown
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: grade.words.map((w) => _buildCharacterColumn(w)).toList(),
            ),
          ),
          const SizedBox(height: 24),
          
          // Good tag
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    Text(
                      grade.score.toString(),
                      style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_upward, size: 12, color: Colors.orange),
                    const SizedBox(width: 8),
                    const Text(
                      'Good! 😊',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Metrics
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetricDial('Accuracy', grade.accuracy, Colors.orange),
              _buildMetricDial('Completeness', grade.completeness, Colors.green),
              _buildMetricDial('Fluency', grade.fluency, Colors.orange),
            ],
          ),
          const SizedBox(height: 24),

          // Detailed Feedback
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.yellow.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.yellow.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.auto_awesome, size: 16, color: Colors.orange),
                    SizedBox(width: 8),
                    Text(
                      'Good pronunciation, but can be better!',
                      style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(color: Colors.orange, height: 24),
                Text(
                  grade.overallFeedback,
                  style: TextStyle(color: Colors.orange.shade900, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterColumn(SyllableGrade word) {
    final color = word.isCorrect ? Colors.green : Colors.red;
    return Column(
      children: [
        Text(
          word.pinyin,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          word.word,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          word.isCorrect ? '95' : '64', // We don't have individual scores from gemini right now, but we can mock it based on isCorrect
          style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildMetricDial(String label, int value, Color color) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: value / 100,
                color: color,
                backgroundColor: color.withValues(alpha: 0.1),
                strokeWidth: 4,
              ),
            ),
            Text(
              value.toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
