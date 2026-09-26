import 'package:flutter/material.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:hanzi_master/core/layout/zen_layout.dart';
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

  String? _getEffectivePinyin(TranscriptLine line) {
    final raw = line.pinyin?.trim();
    final translation = line.translation?.trim().toLowerCase();
    if (raw != null &&
        raw.isNotEmpty &&
        (translation == null || raw.toLowerCase() != translation)) {
      return raw;
    }
    if (RegExp(r'[\u4e00-\u9fff]').hasMatch(line.text)) {
      return PinyinHelper.getPinyinE(line.text,
          separator: ' ', format: PinyinFormat.WITH_TONE_MARK);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (currentIndex < 0 || currentIndex >= transcript.lines.length) {
      return const SizedBox.shrink();
    }

    final line = transcript.lines[currentIndex];
    final highlightedCount = _getHighlightedCharCount(line, currentPosition);
    final effectivePinyin = _getEffectivePinyin(line);

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
                    // A tablet sits further from the eye than a phone, so the
                    // subtitles grow with the window class instead of being a
                    // fixed 36pt at every distance (Phase 3, #50 / #44).
                    fontSize: zenValue(context,
                        compact: 36, medium: 40, expanded: 44),
                    color: isHighlighted ? Colors.white : Colors.white60,
                    fontWeight:
                        isHighlighted ? FontWeight.bold : FontWeight.w500,
                    shadows: isHighlighted
                        ? const [
                            Shadow(
                                color: Colors.blueAccent,
                                blurRadius: 8,
                                offset: Offset(0, 0)),
                            Shadow(
                                color: Colors.black87,
                                blurRadius: 4,
                                offset: Offset(1, 1)),
                          ]
                        : const [
                            Shadow(
                                color: Colors.black87,
                                blurRadius: 4,
                                offset: Offset(1, 1))
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
          if (showPinyin &&
              effectivePinyin != null &&
              effectivePinyin.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              effectivePinyin,
              style: TextStyle(
                fontSize:
                    zenValue(context, compact: 22, medium: 24, expanded: 26),
                color: Colors.white70,
                shadows: const [
                  Shadow(
                      color: Colors.black87,
                      blurRadius: 4,
                      offset: Offset(1, 1))
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
          if (showEnglish && line.translation != null) ...[
            const SizedBox(height: 8),
            Text(
              line.translation!,
              style: TextStyle(
                fontSize:
                    zenValue(context, compact: 16, medium: 17, expanded: 18),
                color: Colors.white70,
                fontStyle: FontStyle.italic,
                shadows: const [
                  Shadow(
                      color: Colors.black87,
                      blurRadius: 4,
                      offset: Offset(1, 1))
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
