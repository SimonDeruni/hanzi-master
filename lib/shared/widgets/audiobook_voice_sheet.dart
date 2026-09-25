import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';

/// One voice a listener can pick for the audiobook narrator.
///
/// Only [id] travels back to the engine; everything else is presentation. The
/// point of this model is what it deliberately leaves out — the provider's own
/// voice identifiers (`zh-CN-XiaoxiaoNeural`), the vendor name, and the weekly
/// allowance bookkeeping. Those used to be printed straight into the picker as
/// subtitles and tooltips, telling the listener nothing they could act on.
class AudiobookVoiceOption {
  const AudiobookVoiceOption({
    required this.id,
    required this.label,
    this.isOnDevice = false,
    this.isLocked = false,
  });

  /// Engine key handed to `AudioService.playSentence(voiceName:)`.
  final String id;

  /// Localized, human description of the voice ("Woman, warm").
  final String label;

  /// The on-device engine: works offline and is never metered.
  final bool isOnDevice;

  /// Cannot be used right now (the weekly studio allowance is spent).
  final bool isLocked;
}

/// The app's single audiobook-voice picker.
///
/// Replaces three divergent implementations: an `AlertDialog` in Settings that
/// printed raw neural-voice IDs, a bottom sheet inside the reader whose labels
/// were hardcoded English, and a chip row inside the audiobook player whose
/// tooltips read "Azure quota exhausted". It is a native-feeling sheet in the
/// app's own vocabulary — Xuan paper/carbon ground, Cinnabar (or amber) accent,
/// gold hairline, 18px ink wells — and it adds the control the flow was missing:
/// **auditioning**. Every row has a ▶ button that speaks a Mandarin sample in that
/// voice, so the choice is made with the ears instead of from a code name.
///
/// Present it with `GlobalBlurredBottomSheet.show`, which supplies the sheet
/// chrome, as the app's other pickers do.
class AudiobookVoiceSheet extends ConsumerStatefulWidget {
  const AudiobookVoiceSheet({
    super.key,
    required this.title,
    required this.options,
    required this.selectedVoiceId,
    required this.onSelected,
    this.onPreview,
    this.notice,
  });

  /// Sheet title, e.g. `l10n.chooseAudiobookVoice`.
  final String title;

  /// Voices to offer, in display order.
  final List<AudiobookVoiceOption> options;

  /// Currently stored voice id.
  final String selectedVoiceId;

  /// Called when the listener commits to a voice (the caller closes the sheet).
  final ValueChanged<AudiobookVoiceOption> onSelected;

  /// Optional audition override. The audiobook player uses it to re-read the
  /// sentence the listener is already on, instead of the canned sample.
  final Future<void> Function(AudiobookVoiceOption option)? onPreview;

  /// Optional one-line notice under the title, e.g. the weekly allowance message.
  final String? notice;

  /// The Mandarin line the voices audition with.
  ///
  /// Deliberately **not** localized: the voices speak Mandarin whichever language
  /// the app is in, so a translated line would misrepresent what is being heard.
  static const String auditionSample = '你好，这是你的有声书。';

  @override
  ConsumerState<AudiobookVoiceSheet> createState() =>
      _AudiobookVoiceSheetState();
}

/// The voice catalogue every audiobook surface offers, in display order.
///
/// One list for Settings, the book reader and the audiobook player, so a voice
/// added here appears in all three under the same human name — the previous three
/// pickers each carried their own copy, which is how they drifted apart.
///
/// Studio voices need the weekly allowance; the on-device voice never does, which
/// is why it is the one option that cannot be locked.
List<AudiobookVoiceOption> audiobookVoiceOptions(
  AppLocalizations l10n, {
  required bool hasStudioQuota,
}) {
  final bool studioLocked = !hasStudioQuota;
  return <AudiobookVoiceOption>[
    AudiobookVoiceOption(
      id: 'Kore',
      label: l10n.voiceFemaleWarm,
      isLocked: studioLocked,
    ),
    AudiobookVoiceOption(
      id: 'Aoede',
      label: l10n.voiceFemaleCheerful,
      isLocked: studioLocked,
    ),
    AudiobookVoiceOption(
      id: 'Fenrir',
      label: l10n.voiceMaleUpbeat,
      isLocked: studioLocked,
    ),
    AudiobookVoiceOption(
      id: 'Charon',
      label: l10n.voiceMaleNewsStyle,
      isLocked: studioLocked,
    ),
    AudiobookVoiceOption(
      id: 'Puck',
      label: l10n.voiceMaleSporty,
      isLocked: studioLocked,
    ),
    AudiobookVoiceOption(
      id: 'local',
      label: l10n.voiceOnDeviceTts,
      isOnDevice: true,
    ),
  ];
}

/// Human name of a stored voice id, for a summary row ("Woman, warm").
///
/// Falls back to the id itself only if a stored value is unknown, so a future
/// voice cannot render as an empty row.
String audiobookVoiceLabel(AppLocalizations l10n, String voiceId) {
  for (final AudiobookVoiceOption option in audiobookVoiceOptions(
    l10n,
    hasStudioQuota: true,
  )) {
    if (option.id == voiceId) return option.label;
  }
  return voiceId;
}

class _AudiobookVoiceSheetState extends ConsumerState<AudiobookVoiceSheet> {
  late final AudioService _audio;
  StreamSubscription<void>? _completeSub;

  /// The row whose audio is still being fetched (the Azure round-trip).
  String? _loadingId;

  /// The row currently speaking.
  String? _playingId;

  /// Whether an audition was started here, so [dispose] knows the engine has to
  /// be released. An audiobook that was already playing belongs to the player.
  bool _auditioned = false;

  @override
  void initState() {
    super.initState();
    _audio = ref.read(audioServiceProvider);
    // The engine reports the end of the line, so a row can drop back to ▶ without
    // guessing a duration.
    _completeSub = _audio.onPlayerComplete.listen((_) {
      if (!mounted) return;
      setState(() {
        _loadingId = null;
        _playingId = null;
      });
    });
  }

  @override
  void dispose() {
    _completeSub?.cancel();
    // Closing the picker must never leave an audition talking over the screen
    // behind it.
    if (_auditioned) unawaited(_audio.stop());
    super.dispose();
  }

  Future<void> _audition(AudiobookVoiceOption option) async {
    if (option.isLocked) return;
    HapticsManager.light();

    // A second tap on the speaking row is the stop control.
    if (_playingId == option.id || _loadingId == option.id) {
      setState(() {
        _loadingId = null;
        _playingId = null;
      });
      await _audio.stop();
      return;
    }

    setState(() {
      _loadingId = option.id;
      _playingId = null;
    });
    _auditioned = true;

    try {
      final Future<void> Function(AudiobookVoiceOption)? override =
          widget.onPreview;
      if (override != null) {
        await override(option);
      } else {
        await _audio.playSentence(
          AudiobookVoiceSheet.auditionSample,
          voiceName: option.id,
          speechRate: 0.8,
          playbackRate: 1.0,
        );
      }
    } catch (_) {
      // A failed audition must not take the picker down with it.
      if (!mounted) return;
      setState(() {
        _loadingId = null;
        _playingId = null;
      });
      return;
    }

    if (!mounted) return;
    setState(() {
      _loadingId = null;
      _playingId = option.id;
    });
  }

  void _select(AudiobookVoiceOption option) {
    if (option.isLocked) return;
    HapticsManager.selection();
    widget.onSelected(option);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color accent = isDark ? AppTheme.accentDark : AppTheme.accentLight;
    final Color gold = isDark ? Colors.amber.shade700 : const Color(0xFFD4AF37);
    final Color ink = isDark ? Colors.white : const Color(0xFF1A1A1B);
    final Color muted = isDark ? Colors.white60 : const Color(0xFF6B655B);
    final Color card = isDark ? AppTheme.cardBgDark : AppTheme.cardBgLight;
    final bool anyLocked =
        widget.options.any((AudiobookVoiceOption o) => o.isLocked);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.82,
      ),
      // The whole sheet scrolls as one surface: in Russian at 2x text scale the
      // title, notice and six rows no longer fit a 320x568 viewport, and a
      // nested list would make the header unreachable.
      child: ListView(
        key: const ValueKey<String>('audiobook-voice-list'),
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 22),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 2, 24, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: ink,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.tapToHearVoiceSample,
                  style: TextStyle(fontSize: 12.5, color: muted, height: 1.35),
                ),
              ],
            ),
          ),
          Container(height: 1, color: gold.withValues(alpha: 0.3)),
          if (widget.notice != null || anyLocked)
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.lock_clock, size: 14, color: muted),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      widget.notice ?? l10n.weeklyAzureQuotaReachedSwitching,
                      style: TextStyle(
                        fontSize: 11.5,
                        color: muted,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 14),
          for (int index = 0; index < widget.options.length; index++)
            Padding(
              padding: EdgeInsets.fromLTRB(
                16,
                0,
                16,
                index == widget.options.length - 1 ? 0 : 10,
              ),
              child: _buildVoiceRow(
                option: widget.options[index],
                l10n: l10n,
                accent: accent,
                gold: gold,
                ink: ink,
                muted: muted,
                card: card,
                isDark: isDark,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVoiceRow({
    required AudiobookVoiceOption option,
    required AppLocalizations l10n,
    required Color accent,
    required Color gold,
    required Color ink,
    required Color muted,
    required Color card,
    required bool isDark,
  }) {
    final bool isSelected = widget.selectedVoiceId == option.id;
    final bool isPlaying = _playingId == option.id;
    final bool isLoading = _loadingId == option.id;

    return Semantics(
      selected: isSelected,
      button: true,
      label: option.label,
      child: Material(
        color:
            isSelected ? accent.withValues(alpha: isDark ? 0.14 : 0.07) : card,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          key: ValueKey<String>('audiobook-voice-${option.id}'),
          borderRadius: BorderRadius.circular(18),
          onTap: option.isLocked ? null : () => _select(option),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isSelected ? accent : gold.withValues(alpha: 0.28),
                width: isSelected ? 1.6 : 1,
              ),
            ),
            padding: const EdgeInsets.fromLTRB(10, 10, 14, 10),
            child: Row(
              children: <Widget>[
                _buildAuditionButton(
                  option: option,
                  l10n: l10n,
                  accent: accent,
                  isPlaying: isPlaying,
                  isLoading: isLoading,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        option.label,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: option.isLocked ? muted : ink,
                          height: 1.25,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (option.isOnDevice) ...<Widget>[
                        const SizedBox(height: 2),
                        // An offline mark rather than a second copy of the label:
                        // it says why this row can never be locked.
                        Tooltip(
                          message: l10n.onDevice,
                          child: Icon(
                            Icons.offline_bolt_rounded,
                            size: 13,
                            color: muted,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                if (option.isLocked)
                  Icon(Icons.lock_outline, size: 18, color: muted)
                else
                  AnimatedContainer(
                    duration: ZenMotion.of(context, ZenMotion.swap),
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: isSelected ? accent : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            isSelected ? accent : gold.withValues(alpha: 0.5),
                        width: 1.6,
                      ),
                    ),
                    child: isSelected
                        ? Icon(
                            Icons.check_rounded,
                            size: 18,
                            color:
                                isDark ? const Color(0xFF1A1A1B) : Colors.white,
                          )
                        : null,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuditionButton({
    required AudiobookVoiceOption option,
    required AppLocalizations l10n,
    required Color accent,
    required bool isPlaying,
    required bool isLoading,
  }) {
    return Tooltip(
      message: l10n.listen,
      child: Semantics(
        button: true,
        enabled: !option.isLocked,
        label: '${l10n.listen} — ${option.label}',
        child: InkResponse(
          key: ValueKey<String>('audiobook-voice-preview-${option.id}'),
          onTap: option.isLocked ? null : () => _audition(option),
          radius: 26,
          child: Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: option.isLocked
                  ? Colors.transparent
                  : accent.withValues(alpha: isPlaying ? 0.22 : 0.10),
              border: Border.all(
                color: isPlaying
                    ? accent
                    : accent.withValues(alpha: option.isLocked ? 0.25 : 0.4),
                width: 1.4,
              ),
            ),
            child: isLoading
                ? SizedBox(
                    width: 18,
                    height: 18,
                    child: ZenLoader(strokeWidth: 2, color: accent),
                  )
                : Icon(
                    isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded,
                    size: 22,
                    color: option.isLocked
                        ? accent.withValues(alpha: 0.35)
                        : accent,
                  ),
          ),
        ),
      ),
    );
  }
}
