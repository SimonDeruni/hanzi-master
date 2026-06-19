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
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/waveform_painter.dart';

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
      final path = await ref.read(audioRecordingServiceProvider).stopRecording();
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
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: StudySessionAppBar(
        title: 'Speaking Mode',
        dueCount: widget.dueCount,
        newCount: widget.newCount,
        learningCount: widget.learningCount,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: GestureDetector(
                  onTap: (!_isRevealed && !_isRecording && !_isProcessing) ? _revealAnswer : null,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white.withAlpha(12) : Colors.white,
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
                              child: Text(
                                widget.card.hanzi,
                                style: TextStyle(
                                  fontSize: 120,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (!_isRevealed)
                          const Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "Tap card to Reveal",
                                style: TextStyle(
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
                                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      widget.card.definition,
                                      style: const TextStyle(fontSize: 20),
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
                  ),
                ),
              ).animate()
               .fade(duration: 500.ms, curve: Curves.easeOutCubic)
               .slideY(begin: 0.1, end: 0, duration: 500.ms, curve: Curves.easeOutCubic),
            ),

            if (_error != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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
              const Padding(
                padding: EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Analyzing pronunciation with Gemini AI...'),
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
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: _isRecording
                            ? Colors.red.withAlpha(50)
                            : (isDark ? Colors.blue.withAlpha(25) : Colors.blue.shade50),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _isRecording
                              ? Colors.red
                              : (isDark ? Colors.blue.withAlpha(50) : Colors.blue.shade200),
                          width: _isRecording ? 3 : 1,
                        ),
                      ),
                      child: Icon(
                        Icons.mic,
                        size: 64,
                        color: _isRecording
                            ? Colors.red
                            : (isDark ? Colors.blue.shade200 : Colors.blue.shade700),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 24),
                    child: Text(
                      'Hold to speak (Optional)',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ),
                ],
              ),

            // AI Feedback Results
            if (_feedbackResult != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.green.withAlpha(25) : Colors.green.shade50,
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

            // Anki Grading Buttons
            if (_isRevealed || _feedbackResult != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.ratePronunciationConfidence,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildGradeButton(
                            AppLocalizations.of(context)!.again, 0, Colors.red, AppLocalizations.of(context)!.botchedIt),
                        _buildGradeButton(
                            AppLocalizations.of(context)!.hard, 2, Colors.orange, AppLocalizations.of(context)!.struggledWithTones),
                        _buildGradeButton(
                            AppLocalizations.of(context)!.good, 4, Colors.green, AppLocalizations.of(context)!.acceptable),
                        _buildGradeButton(
                            AppLocalizations.of(context)!.easy, 5, Colors.blue, AppLocalizations.of(context)!.perfectlyNatural),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeButton(String label, int grade, MaterialColor color, String tooltip) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Tooltip(
          message: tooltip,
          child: BouncingButton(
            onPressed: () {
              Navigator.pop(context, grade);
            },
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: color.shade100,
                foregroundColor: color.shade900,
                disabledBackgroundColor: color.shade100,
                disabledForegroundColor: color.shade900,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: color.shade300, width: 1),
                ),
              ),
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
