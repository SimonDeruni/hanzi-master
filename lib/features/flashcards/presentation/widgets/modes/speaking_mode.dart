import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record/record.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/core/services/audio_recording_service.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/core/utils/pinyin_utils.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/speaking_feedback_panel.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/study_session_app_bar.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:hanzi_master/shared/widgets/waveform_painter.dart';
import 'package:hanzi_master/shared/widgets/swipeable_flashcard.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';
import 'package:hanzi_master/core/widgets/translated_definition.dart';
import 'package:hanzi_master/shared/widgets/ai_consent_sheet.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';

class SpeakingModeWidget extends ConsumerStatefulWidget {
  final Flashcard card;
  final int reviewedCount;
  final int dueCount;
  final int newCount;
  final int learningCount;

  const SpeakingModeWidget({
    super.key,
    required this.card,
    this.reviewedCount = 0,
    this.dueCount = 0,
    this.newCount = 0,
    this.learningCount = 0,
  });

  @override
  ConsumerState<SpeakingModeWidget> createState() => _SpeakingModeWidgetState();
}

class _SpeakingModeWidgetState extends ConsumerState<SpeakingModeWidget> {
  bool _isRevealed = false;
  bool _isRecording = false;
  bool _isProcessing = false;
  Map<String, dynamic>? _feedbackResult;
  String? _error;

  StreamSubscription<Amplitude>? _amplitudeSubscription;
  final List<double> _userAmplitudes = [];

  @override
  void dispose() {
    _amplitudeSubscription?.cancel();
    super.dispose();
  }

  Future<void> _startRecording() async {
    final consented = await AiConsentSheet.ensureConsent(context);
    if (!consented || !mounted) return;

    final audioService = ref.read(audioRecordingServiceProvider);
    final hasPerm = await audioService.requestPermission();
    if (!hasPerm) {
      setState(() =>
          _error = AppLocalizations.of(context)!.microphonePermissionRequired);
      return;
    }

    setState(() {
      _isRecording = true;
      _error = null;
      _feedbackResult = null;
      _userAmplitudes.clear();
    });

    try {
      await audioService.startRecording('flashcard_speech');
      _amplitudeSubscription = audioService.onAmplitudeChanged.listen((amp) {
        if (mounted && _isRecording) {
          setState(() {
            _userAmplitudes.add(amp.current);
            // keep the last 50 samples to prevent massive lists
            if (_userAmplitudes.length > 50) {
              _userAmplitudes.removeAt(0);
            }
          });
        }
      });
    } catch (e) {
      debugPrint('Speaking mode: could not start recording — $e');
      setState(() {
        _isRecording = false;
        _error = AppLocalizations.of(context)!.recordingErrorPleaseTryAgain;
      });
    }
  }

  Future<void> _stopRecording() async {
    if (!_isRecording) return;

    _amplitudeSubscription?.cancel();

    setState(() {
      _isRecording = false;
      _isProcessing = true;
    });

    try {
      final path =
          await ref.read(audioRecordingServiceProvider).stopRecording();
      if (path != null) {
        final bytes = await File(path).readAsBytes();

        final geminiService = ref.read(geminiServiceProvider);
        final result = await geminiService.gradeAudio(
          bytes,
          widget.card.hanzi,
          widget.card.pinyin,
        );

        if (mounted) {
          setState(() {
            _feedbackResult = result;
            _isProcessing = false;
          });
        }
      } else {
        setState(() {
          _isProcessing = false;
          _error = AppLocalizations.of(context)!.recordingFailedNoFile;
        });
      }
    } catch (e) {
      debugPrint('Speaking mode: could not grade the recording — $e');
      if (mounted) {
        setState(() {
          _isProcessing = false;
          _error =
              AppLocalizations.of(context)!.couldNotProcessYourRecordingPleaseT;
        });
      }
    }
  }

  void _revealAnswer() {
    setState(() {
      _isRevealed = true;
    });
    HapticsManager.light();
  }

  Widget _buildColoredHanzi(bool isDark) {
    const Color jade = Color(0xFF2E7D32);
    final Color gold = isDark ? Colors.amber.shade700 : const Color(0xFFD4AF37);
    final Color alert = isDark ? Colors.redAccent : const Color(0xFFC62828);

    if (_feedbackResult == null || _feedbackResult!['words'] == null) {
      return Text(
        widget.card.hanzi,
        style: TextStyle(
          fontSize: 120,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : Colors.black87,
        ),
      );
    }

    final words = _feedbackResult!['words'] as List<dynamic>;
    List<TextSpan> spans = [];
    String remainingHanzi = widget.card.hanzi;

    for (var w in words) {
      String wordText = w['word'];
      bool isCorrect = w['isCorrect'] == true;
      bool isPartial = w['isPartial'] == true;
      // Jade for a character that landed, gold for a shaky one, Cinnabar for a
      // miss — the same reading the shadowing session gives the same verdicts.
      Color color = isCorrect ? jade : (isPartial ? gold : alert);

      if (remainingHanzi.startsWith(wordText)) {
        spans.add(TextSpan(text: wordText, style: TextStyle(color: color)));
        remainingHanzi = remainingHanzi.substring(wordText.length);
      }
    }

    if (remainingHanzi.isNotEmpty) {
      spans.add(TextSpan(
          text: remainingHanzi,
          style: TextStyle(color: isDark ? Colors.white : Colors.black87)));
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 120,
          fontWeight: FontWeight.bold,
        ),
        children: spans,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final Color accent = AppTheme.accentOf(context);
    final Color muted = isDark ? Colors.white60 : const Color(0xFF6B655B);
    final Color alert = isDark ? Colors.redAccent : const Color(0xFFC62828);

    final showPinyin = ref.watch(settingsProvider).showPinyinInSpeaking;

    // The rating gesture must never be a dead end. A grade can fail (silence,
    // no network, AI consent refused) and the learner is then left staring at a
    // card they cannot rate; revealing the card — or hitting an error — unlocks
    // the same swipe-to-grade the other four modes always have.
    final bool canRate = _isRevealed || _feedbackResult != null || _error != null;

    return Scaffold(
      appBar: StudySessionAppBar(
        title: AppLocalizations.of(context)?.speakingMode ?? 'Speaking Mode',
        dueCount: widget.dueCount,
        newCount: widget.newCount,
        learningCount: widget.learningCount,
        extraActions: [
          IconButton(
            icon: Icon(showPinyin ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              ref
                  .read(settingsProvider.notifier)
                  .togglePinyinSpeaking(!showPinyin);
            },
            tooltip: showPinyin
                ? AppLocalizations.of(context)!.hidePinyin
                : AppLocalizations.of(context)!.showPinyin,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: SwipeableFlashcard(
                  isSwipeEnabled: canRate,
                  onSwiped: (grade) => Navigator.pop(context, grade),
                  child: GestureDetector(
                    onTap: (!_isRevealed && !_isRecording && !_isProcessing)
                        ? _revealAnswer
                        : null,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color:
                            isDark ? Colors.white.withAlpha(12) : Colors.white,
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: isDark ? Colors.white12 : Colors.black12,
                        ),
                        boxShadow: [
                          if (!isDark)
                            BoxShadow(
                              color: Colors.black.withAlpha(12),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: _buildColoredHanzi(isDark),
                              ),
                            ),
                          ),
                          if (!_isRevealed && showPinyin)
                            Expanded(
                              flex: 1,
                              child: Center(
                                // The pinyin and its tone pills shrink together
                                // rather than overflowing the card at 2x text.
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      PinyinText(
                                        text: widget.card.pinyin,
                                        style: const TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 10),
                                      _buildToneStrip(isDark),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          if (!_isRevealed)
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  AppLocalizations.of(context)!.tapCardToReveal,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          if (_isRevealed) ...[
                            const Divider(height: 32),
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  PinyinText(
                                    text: widget.card.pinyin,
                                    style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 16),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          // The tones of the word, then what it
                                          // means: what to aim for, and why.
                                          _buildToneStrip(isDark),
                                          const SizedBox(height: 16),
                                          TranslatedDefinition(
                                            definition: widget.card.definition,
                                            hanzi: widget.card.hanzi,
                                            definitionLanguage:
                                                widget.card.definitionLanguage,
                                            originalStyle:
                                                const TextStyle(fontSize: 20),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    )
                        .animate()
                        .fade(
                            duration: ZenMotion.of(context, ZenMotion.page),
                            curve: ZenMotion.enter)
                        .slideY(
                            begin: 0.1,
                            end: 0,
                            duration: ZenMotion.page,
                            curve: ZenMotion.enter),
                  ),
                ),
              ),
            ),
if (_error != null)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: alert.withValues(alpha: isDark ? 0.16 : 0.08),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: alert.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.error_outline_rounded, size: 16, color: alert),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _error!,
                          style: TextStyle(fontSize: 13, color: alert),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
if (_isProcessing)
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: <Widget>[
                    const ZenLoader(),
                    const SizedBox(height: 16),
                    Text(
                      l10n.analyzing_pronunciation_with_gemini_ai,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13.5, color: muted),
                    ),
                  ],
                ),
              )
            else if (_feedbackResult == null && !_isRevealed)
              // Record Button and Waveform
              Column(
                children: [
                  if (_userAmplitudes.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: CustomPaint(
                          painter: WaveformPainter(
                            amplitudes: _userAmplitudes,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  GestureDetector(
                    onTapDown: (_) => _startRecording(),
                    onTapUp: (_) => _stopRecording(),
                    onTapCancel: () => _stopRecording(),
                    child: AnimatedScale(
                      scale: _isRecording ? 0.95 : 1.0,
                      duration: ZenMotion.of(context, ZenMotion.swap),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 20),
                        decoration: BoxDecoration(
                          // The book-screen primary action, Cinnabar while live:
                          // recording is a state, not a second accent.
                          color: _isRecording
                              ? alert
                              : (isDark
                                  ? Colors.amber.shade700
                                  : AppTheme.carbonInkLight),
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: (_isRecording ? alert : accent)
                                  .withValues(alpha: isDark ? 0.3 : 0.2),
                              blurRadius: _isRecording ? 24 : 16,
                              spreadRadius: _isRecording ? 3 : 0,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              _isRecording ? Icons.mic : Icons.mic_none_rounded,
                              color: _isRecording || !isDark
                                  ? Colors.white
                                  : AppTheme.carbonInkLight,
                              size: 32,
                            ),
                            const SizedBox(width: 16),
                            Flexible(
                              child: Text(
                                _isRecording
                                    ? l10n.listening
                                    : l10n.holdMicToRecordReleaseToGrade,
                                style: TextStyle(
                                  color: _isRecording || !isDark
                                      ? Colors.white
                                      : AppTheme.carbonInkLight,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
// AI Feedback Results
            if (_feedbackResult != null)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: SpeakingFeedbackPanel(result: _feedbackResult!),
              ),
// Swipe Hint
            if (canRate)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.swipeToGrade,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white54 : Colors.black45,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '⬅️ ${AppLocalizations.of(context)!.again} ➡️ ${AppLocalizations.of(context)!.good} ⬆️ ${AppLocalizations.of(context)!.easy} ⬇️ ${AppLocalizations.of(context)!.hard}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// The tones of the word, one pill per syllable, in the app's canonical tone
  /// colours. The pinyin is already tone-marked, but calling the tones out is
  /// what lets a learner *aim* before they speak — and speaking practice was the
  /// one mode that showed nothing about them.
  Widget _buildToneStrip(bool isDark) {
    final List<Map<String, dynamic>> tokens =
        PinyinUtils.tokenize(widget.card.pinyin)
            .where((Map<String, dynamic> token) =>
                (token['text'] as String).trim().isNotEmpty)
            .toList();
    if (tokens.isEmpty) return const SizedBox.shrink();

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 6,
      runSpacing: 6,
      children: <Widget>[
        for (final Map<String, dynamic> token in tokens)
          _buildTargetTonePill(
            syllable: token['text'] as String,
            tone: token['tone'] as int,
            isDark: isDark,
          ),
      ],
    );
  }

  Widget _buildTargetTonePill({
    required String syllable,
    required int tone,
    required bool isDark,
  }) {
    final Color base = PinyinUtils.toneColors[tone] ?? const Color(0xFF1A1A1B);
    // The neutral tone's ink is unreadable on a dark surface.
    final Color colour = isDark && tone == 5 ? Colors.white70 : base;
    final String label = tone >= 1 && tone <= 4 ? '$syllable $tone' : syllable;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: colour.withValues(alpha: isDark ? 0.16 : 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colour.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          color: colour,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
