import 'package:flutter/material.dart';
import '../../domain/models/media_briefing.dart';

class PremiumAiPrepCard extends StatelessWidget {
  final MediaBriefing briefing;
  final Function(String) onWordTapped;

  const PremiumAiPrepCard({
    super.key,
    required this.briefing,
    required this.onWordTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'AI Prep Room',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1C2541),
                  ),
                ),
                Text(
                  'Overview',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'LESSON SUMMARY',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9E9E9E),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              briefing.summary,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Color(0xFF2C2C2C),
              ),
            ),
            if (briefing.hardWords.isNotEmpty) ...[
              const SizedBox(height: 24),
              const Text(
                'KEY VOCABULARY',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9E9E9E),
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: briefing.hardWords.map((w) {
                  return GestureDetector(
                    onTap: () => onWordTapped(w),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBF3F9),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        w,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1C2541),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
