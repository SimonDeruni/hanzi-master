import 'package:flutter/material.dart';
import '../../domain/models/video_transcript.dart';

class PremiumSubtitlesOverlay extends StatelessWidget {
  final VideoTranscript transcript;
  final int currentIndex;
  final Duration currentPosition;
  final Function(String) onWordTapped;
  final bool showHanzi;
  final bool showPinyin;
  final bool showEnglish;
  final double bgOpacity;

  const PremiumSubtitlesOverlay({
    super.key,
    required this.transcript,
    required this.currentIndex,
    required this.currentPosition,
    required this.onWordTapped,
    required this.showHanzi,
    required this.showPinyin,
    required this.showEnglish,
    this.bgOpacity = 0.4,
  });

  int _getHighlightedCharCount(TranscriptLine line, Duration position) {
    if (position < line.start) return 0;
    if (position >= line.end) return line.text.length;
    
    final elapsed = position - line.start;
    final progress = elapsed.inMilliseconds / line.duration.inMilliseconds;
    return (progress * line.text.length).floor();
  }

  @override
  Widget build(BuildContext context) {
    if (currentIndex < 0 || currentIndex >= transcript.lines.length) {
      return const SizedBox.shrink();
    }

    final line = transcript.lines[currentIndex];
    final highlightedCount = _getHighlightedCharCount(line, currentPosition);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: bgOpacity),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showHanzi)
          Wrap(
            alignment: WrapAlignment.center,
            children: line.text.split('').asMap().entries.map((entry) {
              final charIndex = entry.key;
              final char = entry.value;
              final isHighlighted = charIndex <= highlightedCount;
              final isChinese = RegExp(r'[\u4e00-\u9fff]').hasMatch(char);

              final textWidget = Text(
                char,
                style: TextStyle(
                  fontSize: 36,
                  color: isHighlighted ? Colors.white : Colors.white60,
                  fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w500,
                  shadows: isHighlighted ? const [
                    Shadow(color: Colors.blueAccent, blurRadius: 8, offset: Offset(0, 0)),
                    Shadow(color: Colors.black87, blurRadius: 4, offset: Offset(1, 1)),
                  ] : const [
                    Shadow(color: Colors.black87, blurRadius: 4, offset: Offset(1, 1))
                  ],
                ),
              );

              return isChinese 
                ? GestureDetector(
                    onTap: () => onWordTapped(char),
                    child: textWidget,
                  )
                : textWidget;
            }).toList(),
          ),
          
        if (showPinyin && line.pinyin != null) ...[
          const SizedBox(height: 4),
          Text(
            line.pinyin!,
            style: const TextStyle(
              fontSize: 22, 
              color: Colors.white70,
              shadows: [
                Shadow(color: Colors.black87, blurRadius: 4, offset: Offset(1, 1))
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],

        if (showEnglish && line.translation != null) ...[
          const SizedBox(height: 8),
          Text(
            line.translation!,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
              fontStyle: FontStyle.italic,
              shadows: [
                Shadow(color: Colors.black87, blurRadius: 4, offset: Offset(1, 1))
              ],
            ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
