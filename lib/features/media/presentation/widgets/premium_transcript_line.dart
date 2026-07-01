import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../../domain/models/video_transcript.dart';

class PremiumTranscriptLine extends StatelessWidget {
  final TranscriptLine line;
  final bool isCurrent;
  final int highlightedCount;
  final VoidCallback onReplay;
  final VoidCallback? onLineTapped;
  final VoidCallback onAiExplain;
  final Function(String) onWordTapped;
  final bool showPinyin;
  final bool showEnglish;
  final String? simplifiedText;

  const PremiumTranscriptLine({
    super.key,
    required this.line,
    required this.isCurrent,
    required this.highlightedCount,
    required this.onReplay,
    this.onLineTapped,
    required this.onAiExplain,
    required this.onWordTapped,
    this.showPinyin = true,
    this.showEnglish = true,
    this.simplifiedText,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline indicator & play button column
          SizedBox(
            width: 40,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // Vertical Timeline Line
                Container(
                  width: 2,
                  color: const Color(0xFFE0E0E0),
                  margin: const EdgeInsets.only(top: 24, bottom: 0),
                ),
                // Play Icon (Active) or Bullet (Inactive)
                Positioned(
                  top: 12,
                  child: isCurrent
                      ? GestureDetector(
                          onTap: onReplay,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.play_circle_outline,
                              color: Colors.blueAccent,
                              size: 28,
                            ),
                          ),
                        )
                      : Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(top: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xFFE0E0E0),
                            shape: BoxShape.circle,
                          ),
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          
          // Subtitle Content Block
          Expanded(
            child: GestureDetector(
              onTap: onLineTapped,
              behavior: HitTestBehavior.opaque,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isCurrent ? const Color(0xFFE8F0FE) : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: isCurrent 
                      ? Border.all(color: Colors.blueAccent.withValues(alpha: 0.3))
                      : Border.all(color: Colors.transparent),
                  boxShadow: isCurrent 
                      ? [
                          BoxShadow(
                            color: Colors.blueAccent.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 0),
                          )
                        ]
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Hanzi Line
                    RichText(
                      text: TextSpan(
                        children: line.text.split('').asMap().entries.map((entry) {
                          final charIndex = entry.key;
                          final char = entry.value;
                          final isHighlighted = isCurrent && charIndex <= highlightedCount;
                          final isChinese = RegExp(r'[\u4e00-\u9fff]').hasMatch(char);

                          return TextSpan(
                            text: char,
                            style: TextStyle(
                              fontSize: 22,
                              color: isHighlighted ? const Color(0xFF1976D2) : const Color(0xFF2C2C2C),
                              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w500,
                              height: 1.5,
                              fontFamily: 'NotoSerifSC', // fallback if needed
                            ),
                            recognizer: isChinese 
                                ? (TapGestureRecognizer()..onTap = () => onWordTapped(char))
                                : null,
                          );
                        }).toList(),
                      ),
                    ),
                    
                    // 2. Pinyin Line
                    if (showPinyin && line.pinyin != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          line.pinyin!,
                          style: const TextStyle(
                            fontSize: 14, 
                            color: Color(0xFF757575),
                          ),
                        ),
                      ),
                      
                    // 3. English/Local Translation Line + AI Button Row
                    if (showEnglish)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                line.translation ?? "[ Translating... ]",
                                style: const TextStyle(
                                  fontSize: 14, 
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFF9E9E9E),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: onAiExplain,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.amber.withValues(alpha: 0.1),
                                ),
                                child: const Icon(
                                  Icons.auto_awesome,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
