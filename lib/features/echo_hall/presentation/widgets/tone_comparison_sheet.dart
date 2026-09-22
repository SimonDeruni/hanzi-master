import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/audio_service.dart';
import '../../../../core/utils/pinyin_utils.dart';
import 'package:hanzi_master/core/widgets/ltr_sanctuary.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:hanzi_master/features/live_translate/presentation/widgets/calligraphic_pitch_contour.dart';

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
      useRootNavigator: true,
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
  ConsumerState<ToneComparisonSheet> createState() =>
      _ToneComparisonSheetState();
}

class _ToneComparisonSheetState extends ConsumerState<ToneComparisonSheet> {
  int? _playingTone;

  String get _comparisonPinyin {
    final suppliedPinyin = PinyinUtils.normalizeSyllable(widget.pinyin);
    if (suppliedPinyin.isNotEmpty) return suppliedPinyin;

    try {
      return PinyinHelper.getPinyinE(
        widget.character,
        separator: ' ',
        format: PinyinFormat.WITH_TONE_MARK,
      ).split(' ').first;
    } catch (_) {
      return '';
    }
  }

  Future<void> _playToneAudio(
      int tone, String tonePinyin, String? exemplarHanzi) async {
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

  String _getLocalizedToneName(BuildContext context, int tone) {
    final l10n = AppLocalizations.of(context)!;
    switch (tone) {
      case 1:
        return l10n.onboardingToneOneHigh;
      case 2:
        return l10n.onboardingToneTwoRising;
      case 3:
        return l10n.onboardingToneThreeDipping;
      case 4:
        return l10n.onboardingToneFourFalling;
      default:
        return l10n.neutralToneLight;
    }
  }

  String _getLocalizedToneDescription(BuildContext context, int tone) {
    final l10n = AppLocalizations.of(context)!;
    switch (tone) {
      case 1:
        return l10n.tone1Description;
      case 2:
        return l10n.tone2Description;
      case 3:
        return l10n.tone3Description;
      case 4:
        return l10n.tone4Description;
      default:
        return l10n.toneNeutralDescription;
    }
  }

  String _getLocalizedToneDiagnostic(
      BuildContext context, int expectedTone, int actualTone) {
    final l10n = AppLocalizations.of(context)!;
    if (expectedTone == actualTone && expectedTone > 0) {
      switch (expectedTone) {
        case 1:
          return l10n.toneDiagMatch1;
        case 2:
          return l10n.toneDiagMatch2;
        case 3:
          return l10n.toneDiagMatch3;
        case 4:
          return l10n.toneDiagMatch4;
        default:
          return l10n.toneDiagMatchDefault;
      }
    }

    if (expectedTone == 1 && actualTone == 2) {
      return l10n.toneDiag1vs2;
    } else if (expectedTone == 1 && actualTone == 3) {
      return l10n.toneDiag1vs3;
    } else if (expectedTone == 1 && actualTone == 4) {
      return l10n.toneDiag1vs4;
    } else if (expectedTone == 2 && actualTone == 1) {
      return l10n.toneDiag2vs1;
    } else if (expectedTone == 2 && actualTone == 3) {
      return l10n.toneDiag2vs3;
    } else if (expectedTone == 2 && actualTone == 4) {
      return l10n.toneDiag2vs4;
    } else if (expectedTone == 3 && actualTone == 1) {
      return l10n.toneDiag3vs1;
    } else if (expectedTone == 3 && actualTone == 2) {
      return l10n.toneDiag3vs2;
    } else if (expectedTone == 3 && actualTone == 4) {
      return l10n.toneDiag3vs4;
    } else if (expectedTone == 4 && actualTone == 1) {
      return l10n.toneDiag4vs1;
    } else if (expectedTone == 4 && actualTone == 2) {
      return l10n.toneDiag4vs2;
    } else if (expectedTone == 4 && actualTone == 3) {
      return l10n.toneDiag4vs3;
    }

    return "${l10n.targetTone}: ${_getLocalizedToneName(context, expectedTone)}. ${l10n.toneDiagListenDiff}";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surfaceColor = theme.colorScheme.surface;
    final onSurface = theme.colorScheme.onSurface;

    final isCorrect = widget.expectedTone == widget.actualTone;
    final comparisonPinyin = _comparisonPinyin;
    final toneMap = PinyinUtils.getAllTonesForSyllable(comparisonPinyin);

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
      child: SingleChildScrollView(
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
                  child: LtrSanctuary(
                    child: Text(
                      widget.character,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: isCorrect
                            ? Colors.green.shade700
                            : Colors.orange.shade800,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LtrSanctuary(
                      child: Text(
                        widget.pinyin,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _getLocalizedToneName(context, widget.expectedTone),
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
                          const Icon(Icons.stars,
                              size: 14, color: Color(0xFF10B981)),
                          const SizedBox(width: 4),
                          Text(
                            AppLocalizations.of(context)!.targetTone,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: const Color(0xFF10B981),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${_getLocalizedToneName(context, widget.expectedTone)} (${toneMap[widget.expectedTone] ?? widget.pinyin})",
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
                            isCorrect
                                ? Icons.check_circle
                                : Icons.record_voice_over,
                            size: 14,
                            color: isCorrect
                                ? const Color(0xFF10B981)
                                : const Color(0xFFF59E0B),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              isCorrect
                                  ? "${AppLocalizations.of(context)!.toneYouSaid} (${AppLocalizations.of(context)!.onboardingToneMatched})"
                                  : AppLocalizations.of(context)!.toneYouSaid,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: isCorrect
                                    ? const Color(0xFF10B981)
                                    : const Color(0xFFF59E0B),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${_getLocalizedToneName(context, widget.actualTone)} (${toneMap[widget.actualTone] ?? widget.pinyin})",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isCorrect
                              ? const Color(0xFF10B981)
                              : const Color(0xFFF59E0B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Calligraphic Pitch Contour Waveform Trace (Zen & Ink)
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.04)
                  : const Color(0xFFFBFBF9),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.35),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.brush,
                      size: 13,
                      color: isDark ? Colors.white60 : Colors.black54,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      AppLocalizations.of(context)?.toneGraph ?? "Tone Graph",
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isDark ? Colors.white60 : Colors.black54,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Protected LTR: a pitch contour is a directional curve, so
                // under RTL the graph would be mirrored horizontally and show
                // the tone rising where it should fall. The compact badges below
                // were already wrapped; this header graph was missed.
                LtrSanctuary(
                  child: CalligraphicPitchContour(
                    expectedTone: widget.expectedTone,
                    actualTone: widget.actualTone,
                    height: 110,
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
                  ? const Color(0xFF10B981)
                  .withValues(alpha: isDark ? 0.12 : 0.08)
                  : const Color(0xFFF59E0B)
                  .withValues(alpha: isDark ? 0.12 : 0.08),
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
                  isCorrect
                      ? Icons.check_circle_outline
                      : Icons.lightbulb_outline,
                  size: 18,
                  color: isCorrect
                      ? const Color(0xFF10B981)
                      : const Color(0xFFF59E0B),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _getLocalizedToneDiagnostic(
                        context, widget.expectedTone, widget.actualTone),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isCorrect
                          ? (isDark
                          ? const Color(0xFF34D399)
                          : const Color(0xFF047857))
                          : (isDark
                          ? const Color(0xFFFBBF24)
                          : const Color(0xFFB45309)),
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
            AppLocalizations.of(context)!.k4toneComparisonTapToListen,
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
              comparisonPinyin: comparisonPinyin,
              theme: theme,
            ),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
  }

  Widget _buildToneCard({
    required int tone,
    required String pinyinWithTone,
    required bool isExpected,
    required bool isActual,
    required String comparisonPinyin,
    required ThemeData theme,
  }) {
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final isPlaying = _playingTone == tone;

    final exemplarHanzi = PinyinUtils.getExemplarHanzi(comparisonPinyin, tone);
    final bool existsInChinese =
        comparisonPinyin.isNotEmpty && pinyinWithTone.isNotEmpty;
    final audioExemplar = exemplarHanzi ?? pinyinWithTone;

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
      cardBg = isDark
          ? Colors.white.withValues(alpha: 0.01)
          : const Color(0xFFF8F9FA);
    }

    final pitchIcon = _getPitchIcon(tone);

    return InkWell(
      onTap: existsInChinese
          ? () => _playToneAudio(tone, pinyinWithTone, audioExemplar)
          : null,
      borderRadius: BorderRadius.circular(16),
      child: Opacity(
        opacity: existsInChinese ? 1.0 : 0.65,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: borderColor,
                width: (isExpected || isActual) ? 1.5 : 1.0),
          ),
          child: Row(
            children: [
              // Pitch Contour Badge (Protected LTR so pitch curve orientation never inverts)
              LtrSanctuary(
                child: Container(
                  width: 44,
                  height: 38,
                  decoration: BoxDecoration(
                    color: existsInChinese
                        ? borderColor.withValues(alpha: 0.15)
                        : Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: existsInChinese
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 5),
                            child: CalligraphicPitchContour(
                              expectedTone: tone,
                              height: 28,
                              isCompact: true,
                              autoAnimate: isPlaying,
                            ),
                          )
                        : Text(
                            pitchIcon,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: onSurface.withValues(alpha: 0.3),
                            ),
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
                        LtrSanctuary(
                          child: Text(
                            exemplarHanzi != null
                                ? "$pinyinWithTone  ($exemplarHanzi)"
                                : pinyinWithTone,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: existsInChinese
                                  ? null
                                  : onSurface.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (isExpected)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3B82F6)
                                  .withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "🎯 ${AppLocalizations.of(context)!.toneExpected}",
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2563EB),
                              ),
                            ),
                          )
                        else if (isActual)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF59E0B)
                                  .withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.you_said,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFD97706),
                              ),
                            ),
                          )
                        else if (!existsInChinese)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.08)
                                  : Colors.black.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .doesNotExistInChinese,
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
                          ? _getLocalizedToneDescription(context, tone)
                          : AppLocalizations.of(context)!
                              .toneDoesNotExistInMandarin,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: onSurface.withValues(
                            alpha: existsInChinese ? 0.6 : 0.4),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              // Audio Action (Disabled & muted if tone does not exist)
              if (existsInChinese)
                IconButton(
                  onPressed: () =>
                      _playToneAudio(tone, pinyinWithTone, audioExemplar),
                  icon: Icon(
                    isPlaying ? Icons.volume_up : Icons.volume_down_outlined,
                    color: isPlaying
                        ? const Color(0xFF10B981)
                        : theme.colorScheme.primary,
                    size: 24,
                  ),
                  tooltip: "${AppLocalizations.of(context)!.listen}: $pinyinWithTone",
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
