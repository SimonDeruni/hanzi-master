import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/audio_service.dart';
import '../../../../core/utils/pinyin_utils.dart';

class ToneComparisonSheet extends ConsumerStatefulWidget {
  final String character;
  final String pinyin;
  final int expectedTone;
  final int actualTone;
  final String? feedback;

  const ToneComparisonSheet({
    super.key,
    required this.character,
    required this.pinyin,
    required this.expectedTone,
    required this.actualTone,
    this.feedback,
  });

  static Future<T?> show<T>(
    BuildContext context, {
    required String character,
    required String pinyin,
    required int expectedTone,
    required int actualTone,
    String? feedback,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ToneComparisonSheet(
        character: character,
        pinyin: pinyin,
        expectedTone: expectedTone,
        actualTone: actualTone,
        feedback: feedback,
      ),
    );
  }

  @override
  ConsumerState<ToneComparisonSheet> createState() => _ToneComparisonSheetState();
}

class _ToneComparisonSheetState extends ConsumerState<ToneComparisonSheet> {
  int? _playingTone;

  Future<void> _playToneAudio(int tone, String tonePinyin, String? exemplarHanzi) async {
    if (exemplarHanzi == null || exemplarHanzi.isEmpty) return;
    setState(() => _playingTone = tone);
    try {
      final audioService = ref.read(audioServiceProvider);
      // Play native Hanzi exemplar to generate authentic Chinese tone contours
      await audioService.playToneAudition(
        exemplarHanzi,
        pinyin: tonePinyin,
        cacheKey: '${exemplarHanzi}_${tonePinyin}_$tone',
      );
    } catch (e) {
      debugPrint("Error playing tone audio: $e");
    } finally {
      if (mounted) {
        setState(() => _playingTone = null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surfaceColor = theme.colorScheme.surface;
    final onSurface = theme.colorScheme.onSurface;

    final isCorrect = widget.expectedTone == widget.actualTone;
    final toneMap = PinyinUtils.getAllTonesForSyllable(widget.pinyin);

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Header: Character + Syllable
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: isCorrect
                      ? Colors.green.withValues(alpha: 0.15)
                      : (widget.actualTone != 0
                          ? Colors.orange.withValues(alpha: 0.15)
                          : Colors.blue.withValues(alpha: 0.15)),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isCorrect
                        ? Colors.green.withValues(alpha: 0.4)
                        : Colors.orange.withValues(alpha: 0.4),
                  ),
                ),
                child: Center(
                  child: Text(
                    widget.character,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: isCorrect ? Colors.green.shade700 : Colors.orange.shade800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.pinyin,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      PinyinUtils.getToneName(widget.expectedTone),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              // Close Button
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Comparison Banner (Expected vs Said)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.stars, size: 14, color: Color(0xFF10B981)),
                          const SizedBox(width: 4),
                          Text(
                            "Target Tone",
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: const Color(0xFF10B981),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Tone ${widget.expectedTone} (${toneMap[widget.expectedTone] ?? widget.pinyin})",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 36,
                  color: onSurface.withValues(alpha: 0.1),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            isCorrect ? Icons.check_circle : Icons.record_voice_over,
                            size: 14,
                            color: isCorrect ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isCorrect ? "You Spoke (Match!)" : "You Spoke",
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: isCorrect ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Tone ${widget.actualTone} (${toneMap[widget.actualTone] ?? widget.pinyin})",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isCorrect ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Diagnostic Guidance Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isCorrect
                  ? const Color(0xFF10B981).withValues(alpha: isDark ? 0.12 : 0.08)
                  : const Color(0xFFF59E0B).withValues(alpha: isDark ? 0.12 : 0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isCorrect
                    ? const Color(0xFF10B981).withValues(alpha: 0.3)
                    : const Color(0xFFF59E0B).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  isCorrect ? Icons.check_circle_outline : Icons.lightbulb_outline,
                  size: 18,
                  color: isCorrect ? const Color(0xFF10B981) : const Color(0xFFF59E0B),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    PinyinUtils.getToneDiagnostic(widget.expectedTone, widget.actualTone),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isCorrect
                          ? (isDark ? const Color(0xFF34D399) : const Color(0xFF047857))
                          : (isDark ? const Color(0xFFFBBF24) : const Color(0xFFB45309)),
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Text(
            "4-Tone Comparison (Tap to Listen):",
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: onSurface.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 10),

          // 4-Tone Matrix List (Tones 1 to 4)
          for (int tone = 1; tone <= 4; tone++) ...[
            _buildToneCard(
              tone: tone,
              pinyinWithTone: toneMap[tone] ?? '',
              isExpected: tone == widget.expectedTone,
              isActual: tone == widget.actualTone,
              theme: theme,
            ),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildToneCard({
    required int tone,
    required String pinyinWithTone,
    required bool isExpected,
    required bool isActual,
    required ThemeData theme,
  }) {
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final isPlaying = _playingTone == tone;

    final exemplarHanzi = PinyinUtils.getExemplarHanzi(widget.pinyin, tone);
    final bool existsInChinese = exemplarHanzi != null && exemplarHanzi.isNotEmpty;

    Color borderColor = theme.colorScheme.outlineVariant.withValues(alpha: 0.3);
    Color cardBg = isDark ? Colors.white.withValues(alpha: 0.03) : Colors.white;

    if (isExpected && isActual) {
      borderColor = const Color(0xFF10B981);
      cardBg = const Color(0xFF10B981).withValues(alpha: isDark ? 0.12 : 0.06);
    } else if (isExpected) {
      borderColor = const Color(0xFF3B82F6);
      cardBg = const Color(0xFF3B82F6).withValues(alpha: isDark ? 0.12 : 0.06);
    } else if (isActual) {
      borderColor = const Color(0xFFF59E0B);
      cardBg = const Color(0xFFF59E0B).withValues(alpha: isDark ? 0.12 : 0.06);
    } else if (!existsInChinese) {
      borderColor = borderColor.withValues(alpha: 0.15);
      cardBg = isDark ? Colors.white.withValues(alpha: 0.01) : const Color(0xFFF8F9FA);
    }

    final pitchIcon = _getPitchIcon(tone);

    return InkWell(
      onTap: existsInChinese ? () => _playToneAudio(tone, pinyinWithTone, exemplarHanzi) : null,
      borderRadius: BorderRadius.circular(16),
      child: Opacity(
        opacity: existsInChinese ? 1.0 : 0.65,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: (isExpected || isActual) ? 1.5 : 1.0),
          ),
          child: Row(
            children: [
              // Pitch Contour Badge
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: existsInChinese ? borderColor.withValues(alpha: 0.15) : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    pitchIcon,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: !existsInChinese
                          ? onSurface.withValues(alpha: 0.3)
                          : (isExpected
                              ? const Color(0xFF3B82F6)
                              : (isActual ? const Color(0xFFF59E0B) : onSurface.withValues(alpha: 0.6))),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Pinyin + Name + Exemplar Character / Gap Badge
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          existsInChinese ? "$pinyinWithTone  ($exemplarHanzi)" : pinyinWithTone,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: existsInChinese ? null : onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (isExpected)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              "🎯 Expected",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2563EB),
                              ),
                            ),
                          )
                        else if (isActual)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              "🗣️ You Said",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD97706),
                              ),
                            ),
                          )
                        else if (!existsInChinese)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.08)
                                  : Colors.black.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "Does not exist in Chinese",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: onSurface.withValues(alpha: 0.5),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      existsInChinese
                          ? PinyinUtils.getToneDescription(tone)
                          : "This tone does not exist in standard Mandarin.",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: onSurface.withValues(alpha: existsInChinese ? 0.6 : 0.4),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              // Audio Action (Disabled & muted if tone does not exist)
              if (existsInChinese)
                IconButton(
                  onPressed: () => _playToneAudio(tone, pinyinWithTone, exemplarHanzi),
                  icon: Icon(
                    isPlaying ? Icons.volume_up : Icons.volume_down_outlined,
                    color: isPlaying ? const Color(0xFF10B981) : theme.colorScheme.primary,
                    size: 24,
                  ),
                  tooltip: "Play $pinyinWithTone",
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(
                    Icons.volume_off_outlined,
                    color: onSurface.withValues(alpha: 0.25),
                    size: 20,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _getPitchIcon(int tone) {
    switch (tone) {
      case 1:
        return "¯";
      case 2:
        return "/";
      case 3:
        return "v";
      case 4:
        return "\\";
      default:
        return "·";
    }
  }
}