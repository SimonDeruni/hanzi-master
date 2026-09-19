import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record/record.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/core/services/audio_recording_service.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/study_session_app_bar.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/shared/widgets/waveform_painter.dart';
import 'package:hanzi_master/shared/widgets/swipeable_flashcard.dart';
import 'package:hanzi_master/core/widgets/translated_definition.dart';
import 'package:hanzi_master/shared/widgets/ai_consent_sheet.dart';

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
      setState(() => _error = "Microphone permission required.");
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
      setState(() {
        _isRecording = false;
        _error = "Failed to start recording: $e";
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
          _error = "Recording failed (no file).";
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isProcessing = false;
          _error = "Error analyzing audio: $e";
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
      Color color =
          isCorrect ? Colors.green : (isPartial ? Colors.orange : Colors.red);

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
          fontFamily: 'NotoSerifSC',
        ),
        children: spans,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    final showPinyin = ref.watch(settingsProvider).showPinyinInSpeaking;

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
                  isSwipeEnabled: _isRevealed || _feedbackResult != null,
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
                                child: PinyinText(
                                  text: widget.card.pinyin,
                                  style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
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
                                      child: TranslatedDefinition(
                                        definition: widget.card.definition,
                                        hanzi: widget.card.hanzi,
                                        originalStyle:
                                            const TextStyle(fontSize: 20),
                                        textAlign: TextAlign.center,
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
                        .fade(duration: 500.ms, curve: Curves.easeOutCubic)
                        .slideY(
                            begin: 0.1,
                            end: 0,
                            duration: 500.ms,
                            curve: Curves.easeOutCubic),
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
                    color: Colors.red.withAlpha(25),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Text(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

            if (_isProcessing)
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(AppLocalizations.of(context)!
                        .analyzing_pronunciation_with_gemini_ai),
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
                      duration: const Duration(milliseconds: 150),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: _isRecording
                                ? [Colors.red.shade400, Colors.red.shade700]
                                : (isDark
                                    ? [
                                        Colors.blue.shade700,
                                        Colors.blue.shade900
                                      ]
                                    : [
                                        Colors.blue.shade300,
                                        Colors.blue.shade600
                                      ]),
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              color: (_isRecording ? Colors.red : Colors.blue)
                                  .withAlpha(isDark ? 80 : 120),
                              blurRadius: _isRecording ? 24 : 16,
                              spreadRadius: _isRecording ? 4 : 0,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                                _isRecording
                                    ? Icons.mic
                                    : Icons.mic_none_rounded,
                                color: Colors.white,
                                size: 32),
                            const SizedBox(width: 16),
                            Text(
                              _isRecording
                                  ? 'Listening...'
                                  : 'Hold to speak (Optional)',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
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
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.green.withAlpha(25)
                        : Colors.green.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'AI Score: ${_feedbackResult!['score'] ?? 0}/100',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _feedbackResult!['overallFeedback'] ?? '',
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

            // Swipe Hint
            if (_isRevealed || _feedbackResult != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                child: Column(
                  children: [
                    Text(
                      "Swipe to Grade:",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white54 : Colors.black45,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "⬅️ Again    ➡️ Good    ⬆️ Easy    ⬇️ Hard",
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
}
