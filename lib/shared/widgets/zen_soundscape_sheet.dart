import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/zen_ambient_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';

/// Calligraphic modal bottom sheet for managing reading & audiobook ambient soundscapes.
class ZenSoundscapeSheet extends ConsumerWidget {
  const ZenSoundscapeSheet({super.key});

  static Future<void> show(BuildContext context) {
    HapticsManager.light();
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const ZenSoundscapeSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ambientState = ref.watch(zenAmbientServiceProvider);
    final ambientService = ref.read(zenAmbientServiceProvider.notifier);
    final l10n = AppLocalizations.of(context);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF1E1E22) : const Color(0xFFFDFCF0);
    final primaryText = isDark ? Colors.white : const Color(0xFF1A1A1B);
    final secondaryText = isDark ? Colors.white60 : const Color(0xFF6B655B);
    final activeAccent =
        isDark ? Colors.amber.shade400 : const Color(0xFF8B0000);
    final goldBorder =
        isDark ? Colors.amber.shade700 : const Color(0xFFD4AF37);

    return Container(
      padding: EdgeInsets.fromLTRB(
          20, 16, 20, 24 + MediaQuery.of(context).padding.bottom),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(
            color: goldBorder.withValues(alpha: 0.35),
            width: 1.2,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.6 : 0.16),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? Colors.white24 : Colors.black12,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Header Row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: activeAccent.withValues(alpha: isDark ? 0.2 : 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: activeAccent.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Icon(
                  Icons.spa_rounded,
                  size: 22,
                  color: activeAccent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n?.ambientSoundscape ?? 'Ambient Soundscape',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: primaryText,
                        fontFamily: 'NotoSerifSC',
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n?.ambientSoundscapeDesc ??
                          'Soothing background atmosphere for reading & listening',
                      style: TextStyle(
                        fontSize: 12,
                        color: secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              // Master Toggle Switch
              Switch.adaptive(
                value: ambientState.track != SoundscapeTrack.off &&
                    ambientState.isPlaying,
                activeThumbColor:
                    isDark ? Colors.amber.shade400 : const Color(0xFF8B0000),
                activeTrackColor: isDark
                    ? Colors.amber.shade900.withValues(alpha: 0.6)
                    : const Color(0xFFD4AF37).withValues(alpha: 0.5),
                onChanged: (_) {
                  HapticsManager.selection();
                  ambientService.togglePlayPause();
                },
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Track Options List
          _buildTrackOption(
            context: context,
            title: l10n?.soundscapeCourtyardRain ?? 'Courtyard Rain',
            subtitle: '庭院细雨 · Soft rainfall on roof tiles',
            icon: Icons.water_drop_outlined,
            track: SoundscapeTrack.courtyardRain,
            currentTrack: ambientState.track,
            isPlaying: ambientState.isPlaying,
            isDark: isDark,
            activeAccent: activeAccent,
            goldBorder: goldBorder,
            primaryText: primaryText,
            secondaryText: secondaryText,
            onTap: () {
              HapticsManager.selection();
              ambientService.setTrack(SoundscapeTrack.courtyardRain);
            },
          ),
          const SizedBox(height: 8),
          _buildTrackOption(
            context: context,
            title: l10n?.soundscapeGuqinWind ?? 'Guqin & Bamboo Wind',
            subtitle: '古琴清风 · Traditional Chinese zither & breeze',
            icon: Icons.air_rounded,
            track: SoundscapeTrack.guqinWind,
            currentTrack: ambientState.track,
            isPlaying: ambientState.isPlaying,
            isDark: isDark,
            activeAccent: activeAccent,
            goldBorder: goldBorder,
            primaryText: primaryText,
            secondaryText: secondaryText,
            onTap: () {
              HapticsManager.selection();
              ambientService.setTrack(SoundscapeTrack.guqinWind);
            },
          ),
          const SizedBox(height: 8),
          _buildTrackOption(
            context: context,
            title: l10n?.soundscapeMidnightZen ?? 'Midnight Zen Drone',
            subtitle: '静夜钟磐 · 432 Hz warm harmonic resonance',
            icon: Icons.self_improvement_rounded,
            track: SoundscapeTrack.midnightZen,
            currentTrack: ambientState.track,
            isPlaying: ambientState.isPlaying,
            isDark: isDark,
            activeAccent: activeAccent,
            goldBorder: goldBorder,
            primaryText: primaryText,
            secondaryText: secondaryText,
            onTap: () {
              HapticsManager.selection();
              ambientService.setTrack(SoundscapeTrack.midnightZen);
            },
          ),
          const SizedBox(height: 8),
          _buildTrackOption(
            context: context,
            title: l10n?.ambientSoundscapeOff ?? 'Off (Silent)',
            subtitle: 'Silence · No background soundscape',
            icon: Icons.volume_off_outlined,
            track: SoundscapeTrack.off,
            currentTrack: ambientState.track,
            isPlaying: ambientState.isPlaying,
            isDark: isDark,
            activeAccent: activeAccent,
            goldBorder: goldBorder,
            primaryText: primaryText,
            secondaryText: secondaryText,
            onTap: () {
              HapticsManager.selection();
              ambientService.setTrack(SoundscapeTrack.off);
            },
          ),

          const SizedBox(height: 20),

          // Volume Slider (only shown when a track is active)
          if (ambientState.track != SoundscapeTrack.off) ...[
            Row(
              children: [
                Icon(
                  Icons.volume_down_rounded,
                  size: 18,
                  color: secondaryText,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n?.ambientVolume ?? 'Background Volume',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: primaryText,
                  ),
                ),
                const Spacer(),
                Text(
                  '${(ambientState.volume * 100).round()}%',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: activeAccent,
                  ),
                ),
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 3.5,
                thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 7.0),
                overlayShape:
                    const RoundSliderOverlayShape(overlayRadius: 14.0),
                activeTrackColor: activeAccent,
                inactiveTrackColor: isDark ? Colors.white12 : Colors.black12,
                thumbColor: activeAccent,
                overlayColor: activeAccent.withValues(alpha: 0.15),
              ),
              child: Slider(
                value: ambientState.volume,
                min: 0.05,
                max: 0.50,
                divisions: 9,
                onChanged: (val) {
                  ambientService.setVolume(val);
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTrackOption({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required SoundscapeTrack track,
    required SoundscapeTrack currentTrack,
    required bool isPlaying,
    required bool isDark,
    required Color activeAccent,
    required Color goldBorder,
    required Color primaryText,
    required Color secondaryText,
    required VoidCallback onTap,
  }) {
    final isSelected = currentTrack == track;
    final isActivePlaying = isSelected && isPlaying && track != SoundscapeTrack.off;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: ZenMotion.of(context, ZenMotion.swap),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark
                    ? Colors.amber.withValues(alpha: 0.12)
                    : const Color(0xFFF7F3E9))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected
                  ? goldBorder
                  : (isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.06)),
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isSelected
                      ? activeAccent.withValues(alpha: isDark ? 0.25 : 0.12)
                      : (isDark
                          ? Colors.white.withValues(alpha: 0.06)
                          : Colors.black.withValues(alpha: 0.04)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 19,
                  color: isSelected ? activeAccent : secondaryText,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                              color: primaryText,
                            ),
                          ),
                        ),
                        if (isActivePlaying) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 1.5),
                            decoration: BoxDecoration(
                              color: activeAccent.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.graphic_eq,
                                    size: 11, color: activeAccent),
                                const SizedBox(width: 2),
                                Text(
                                  'PLAYING',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    color: activeAccent,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 11.5,
                        color: secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
                size: 20,
                color: isSelected
                    ? activeAccent
                    : (isDark ? Colors.white24 : Colors.black26),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
