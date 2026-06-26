import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../../domain/models/video_transcript.dart';

class PremiumTranscriptLine extends StatelessWidget {
  final TranscriptLine line;
  final bool isCurrent;
  final int highlightedCount;
  final VoidCallback onReplay;
  final VoidCallback onAiExplain;
  final Function(String) onWordTapped;
  final bool showPinyin;
  final bool showEnglish;

  const PremiumTranscriptLine({
    super.key,
    required this.line,
    required this.isCurrent,
    required this.highlightedCount,
    required this.onReplay,
    required this.onAiExplain,
    required this.onWordTapped,
    this.showPinyin = true,
    this.showEnglish = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCurrent 
            ? (isDark ? Colors.indigo.withValues(alpha: 0.2) : Colors.indigo.shade50)
            : (isDark ? const Color(0xFF242526) : Colors.white),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isCurrent 
              ? Colors.indigo.withValues(alpha: 0.3) 
              : Colors.transparent,
          width: 1.5,
        ),
        boxShadow: isCurrent 
            ? [
                BoxShadow(
                  color: Colors.indigo.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Action Buttons
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIconButton(
                icon: Icons.loop, 
                color: isCurrent ? Colors.indigo : Colors.grey, 
                onTap: onReplay,
                isDark: isDark,
              ),
              const SizedBox(height: 8),
              _buildIconButton(
                icon: Icons.auto_awesome, 
                color: Colors.amber.shade600, 
                onTap: onAiExplain,
                isDark: isDark,
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showPinyin && line.pinyin != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      line.pinyin!,
                      style: TextStyle(
                        fontSize: 15, 
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
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
                          color: isHighlighted 
                              ? (isDark ? Colors.indigo.shade300 : Colors.indigo.shade900)
                              : (isDark ? Colors.white : Colors.black87),
                          fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w500,
                          height: 1.5,
                          fontFamily: 'sans-serif',
                        ),
                        recognizer: isChinese 
                            ? (TapGestureRecognizer()..onTap = () => onWordTapped(char))
                            : null,
                      );
                    }).toList(),
                  ),
                ),
                if (showEnglish)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "- translated text placeholder -",
                      style: TextStyle(
                        fontSize: 14, 
                        fontStyle: FontStyle.italic,
                        color: isDark ? Colors.grey[500] : Colors.grey[500],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({required IconData icon, required Color color, required VoidCallback onTap, required bool isDark}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.withValues(alpha: 0.1) : color.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: color),
      ),
    );
  }
}
