import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record/record.dart';
import 'package:hanzi_master/core/services/analytics_service.dart';
import 'package:hanzi_master/core/services/audio_recording_service.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/echo_hall/presentation/widgets/tone_comparison_sheet.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/drawing_canvas.dart';
import 'package:hanzi_master/features/onboarding/domain/voice_activity_detector.dart';

/// A self-contained preview of the app's learning loop. It deliberately does
/// not write lesson progress, SRS data, streaks, or book progress.
class OnboardingMiniLessonScreen extends ConsumerStatefulWidget {
  const OnboardingMiniLessonScreen({
    super.key,
    required this.onComplete,
    this.disableExternalServicesForTesting = false,
  });

  final VoidCallback onComplete;
  final bool disableExternalServicesForTesting;

  @override
  ConsumerState<OnboardingMiniLessonScreen> createState() =>
      _OnboardingMiniLessonScreenState();
}

class _OnboardingMiniLessonScreenState
    extends ConsumerState<OnboardingMiniLessonScreen> {
  static const _passage = '清晨，小雨停了。我打开窗户，听见鸟儿在树上唱歌。新的一天开始了。';
  static const _shadowSentence = '我打开窗户。';
  static const _shadowPinyin = 'wǒ dǎ kāi chuāng hu';
  static const _titles = [
    'Listen',
    'Notice',
    'Shadow',
    'Four tones',
    'Write',
    'Recap'
  ];

  int _step = 0;
  bool _busy = false;
  bool _recording = false;
  String? _message;
  List<Map<String, dynamic>> _words = const [];
  List<String> _strokes = const [];
  late final AudioRecordingService _recorder;
  late final AudioService _audioService;
  final VoiceActivityDetector _voiceActivityDetector = VoiceActivityDetector();
  StreamSubscription<Amplitude>? _amplitudeSubscription;

  @override
  void initState() {
    super.initState();
    _recorder = ref.read(audioRecordingServiceProvider);
    _audioService = ref.read(audioServiceProvider);
    _loadBundledStrokes();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(analyticsServiceProvider)
          .logEvent('onboarding_mini_lesson_started');
    });
  }

  Future<void> _loadBundledStrokes() async {
    try {
      final raw = await rootBundle.loadString('assets/data/hsk1_strokes.json');
      final data = jsonDecode(raw) as Map<String, dynamic>;
      final entry = data['好'] as Map<String, dynamic>?;
      if (mounted && entry != null) {
        setState(() => _strokes = List<String>.from(entry['strokes'] as List));
      }
    } catch (error) {
      debugPrint('Could not load onboarding handwriting data: $error');
    }
  }

  Future<void> _play(String text) async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      if (!widget.disableExternalServicesForTesting) {
        final started =
            await _audioService.playSentence(text, voiceName: 'Fenrir');
        if (!started) throw Exception('Playback did not start');
      }
    } catch (_) {
      if (mounted) {
        setState(() => _message =
            'Audio is unavailable. You can still read and continue.');
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _toggleRecording() async {
    if (_busy) return;
    if (!_recording) {
      setState(() {
        _busy = true;
        _message = null;
      });
      try {
        if (widget.disableExternalServicesForTesting ||
            await _recorder.requestPermission()) {
          if (!widget.disableExternalServicesForTesting) {
            await _recorder.startRecording('onboarding_shadow');
            _voiceActivityDetector.reset();
            _amplitudeSubscription = _recorder.onAmplitudeChanged.listen(
              (amplitude) =>
                  _voiceActivityDetector.addSample(amplitude.current),
            );
          }
          if (mounted) setState(() => _recording = true);
        } else if (mounted) {
          setState(() => _message =
              'Microphone access was not granted. You can use the quiet option below.');
        }
      } catch (_) {
        if (mounted) {
          setState(() => _message = 'Recording is unavailable right now.');
        }
      } finally {
        if (mounted) setState(() => _busy = false);
      }
      return;
    }

    setState(() {
      _recording = false;
      _busy = true;
      _message = 'Listening to your tones…';
    });
    String? path;
    try {
      if (!widget.disableExternalServicesForTesting) {
        await _amplitudeSubscription?.cancel();
        _amplitudeSubscription = null;
        path = await _recorder.stopRecording();
        if (path == null) throw Exception('No recording');

        if (!_voiceActivityDetector.hasDetectedSpeech) {
          if (mounted) {
            setState(() {
              _message = "We didn't catch that. Please try speaking again.";
            });
          }
          return;
        }

        final bytes = await File(path).readAsBytes();
        final grade = await ref
            .read(geminiServiceProvider)
            .gradeAudio(bytes, _shadowSentence, _shadowPinyin);
        _words = (grade['words'] as List<dynamic>? ?? const [])
            .whereType<Map>()
            .map((word) => Map<String, dynamic>.from(word))
            .where((word) => (word['word'] ?? '').toString().isNotEmpty)
            .toList();
        if (_words.isEmpty) {
          throw StateError('Pronunciation assessment returned no words');
        }
      } else {
        _words = _demoWords;
      }
      if (mounted) _goTo(3);
    } catch (error) {
      if (mounted) {
        setState(() {
          _message = isNoSpeechAssessmentError(error)
              ? "We didn't catch that. Please try speaking again."
              : "We couldn't evaluate that recording. Please try speaking again.";
        });
      }
    } finally {
      if (path != null) {
        try {
          await File(path).delete();
        } catch (_) {}
      }
      if (mounted) setState(() => _busy = false);
    }
  }

  List<Map<String, dynamic>> get _demoWords => const [
        {
          'word': '好',
          'pinyin': 'hǎo',
          'expectedTone': 3,
          'actualTone': 2,
          'isCorrect': false,
          'feedback': 'Listen for the low, dipping third tone.',
        }
      ];

  void _quietPath() {
    _words = _demoWords;
    _goTo(3);
  }

  void _goTo(int step) {
    ref.read(analyticsServiceProvider).logEvent(
      'onboarding_mini_lesson_step',
      parameters: {'step': _titles[step].toLowerCase().replaceAll(' ', '_')},
    );
    setState(() {
      _step = step;
      _message = null;
    });
  }

  void _finish() {
    ref
        .read(analyticsServiceProvider)
        .logEvent('onboarding_mini_lesson_completed');
    widget.onComplete();
  }

  @override
  void dispose() {
    _amplitudeSubscription?.cancel();
    if (_recording) _recorder.stopRecording();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ink = isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
      body: CalligraphyBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: Column(
                  children: [
                    Row(children: [
                      Text('${_step + 1} / 6',
                          style: TextStyle(color: ink.withValues(alpha: .55))),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child:
                              LinearProgressIndicator(value: (_step + 1) / 6),
                        ),
                      ),
                    ]),
                    const SizedBox(height: 14),
                    Text(_titles[_step],
                        style: TextStyle(
                            fontFamily: 'Serif', fontSize: 30, color: ink)),
                  ],
                ),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: SingleChildScrollView(
                    key: ValueKey(_step),
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                    child: _buildStep(ink, isDark),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(Color ink, bool isDark) {
    switch (_step) {
      case 0:
        return _lessonColumn(
          ink,
          instruction:
              'First, hear a tiny moment in Mandarin. No memorizing yet.',
          child: _passageCard(ink, showPinyin: false),
          primaryLabel: _busy ? 'Loading audio…' : 'Listen to the passage',
          primaryIcon: Icons.headphones,
          onPrimary: _busy ? null : () => _play(_passage),
          secondaryLabel: 'Continue',
          onSecondary: () => _goTo(1),
        );
      case 1:
        return _lessonColumn(
          ink,
          instruction:
              'Notice how meaning, sound, and characters travel together.',
          child: _passageCard(ink, showPinyin: true),
          primaryLabel: 'Shadow one sentence',
          primaryIcon: Icons.arrow_forward,
          onPrimary: () => _goTo(2),
        );
      case 2:
        return _lessonColumn(
          ink,
          instruction:
              'Listen once, then hold the microphone and say the sentence.',
          child: Column(children: [
            Text(_shadowSentence,
                style: TextStyle(
                    fontFamily: 'NotoSerifSC', fontSize: 34, color: ink)),
            Text(_shadowPinyin,
                style:
                    TextStyle(fontSize: 17, color: ink.withValues(alpha: .6))),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () => _play(_shadowSentence),
              icon: const Icon(Icons.volume_up_outlined),
              label: const Text('Hear it again'),
            ),
          ]),
          primaryLabel:
              _recording ? 'Stop and check my tones' : 'Use microphone',
          primaryIcon: _recording ? Icons.stop_circle_outlined : Icons.mic_none,
          onPrimary: _busy ? null : _toggleRecording,
          secondaryLabel: "I can't speak right now",
          onSecondary: _quietPath,
        );
      case 3:
        return _lessonColumn(
          ink,
          instruction:
              'Tap a character to compare the tone you said with the target, then hear tones 1–4.',
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: _words.map((word) => _toneChip(word, ink)).toList(),
          ),
          primaryLabel: 'Try handwriting',
          primaryIcon: Icons.draw_outlined,
          onPrimary: () => _goTo(4),
        );
      case 4:
        return _lessonColumn(
          ink,
          instruction: 'Trace 好 (hǎo, “good”). Follow the faint stroke guide.',
          child: SizedBox(
            height: 310,
            child: _strokes.isEmpty
                ? Center(
                    child: Text('好',
                        style: TextStyle(
                            fontSize: 150, color: ink.withValues(alpha: .18))))
                : DrawingCanvas(
                    strokePaths: _strokes,
                    showAnimation: false,
                    showReference: true,
                    showGuideLines: true,
                    showGrade: false,
                    showControls: false,
                    strictGrading: false,
                  ),
          ),
          primaryLabel: 'See what you learned',
          primaryIcon: Icons.check,
          onPrimary: () => _goTo(5),
        );
      default:
        return _lessonColumn(
          ink,
          instruction:
              'In a few minutes, you used the same loop that powers your lessons.',
          child: const Column(
            children: [
              _RecapRow(Icons.headphones, 'Listened to Chinese in context'),
              _RecapRow(Icons.record_voice_over, 'Shadowed a sentence'),
              _RecapRow(Icons.graphic_eq, 'Compared Mandarin tones'),
              _RecapRow(Icons.gesture, 'Practiced a real character'),
            ],
          ),
          primaryLabel: 'Continue',
          primaryIcon: Icons.arrow_forward,
          onPrimary: _finish,
        );
    }
  }

  Widget _sourceAttribution(Color ink) => Container(
        margin: const EdgeInsets.only(top: 14),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: ink.withValues(alpha: .04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ink.withValues(alpha: .08)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                'assets/images/books/spring_bajin.jpg',
                width: 28,
                height: 38,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.menu_book,
                  size: 20,
                  color: ink.withValues(alpha: .4),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'From the Grand Library',
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w600,
                      color: ink.withValues(alpha: .5),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '《春》 (Spring) · 巴金 (Ba Jin)',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: ink.withValues(alpha: .85),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _passageCard(Color ink, {required bool showPinyin}) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: ink.withValues(alpha: .055),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(children: [
          Text(_passage,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'NotoSerifSC',
                  fontSize: 23,
                  height: 1.65,
                  color: ink)),
          if (showPinyin) ...[
            const SizedBox(height: 10),
            Text(
                'Qīngchén, xiǎoyǔ tíng le. Wǒ dǎkāi chuānghu, tīngjiàn niǎor zài shù shàng chànggē. Xīn de yì tiān kāishǐ le.',
                textAlign: TextAlign.center,
                style:
                    TextStyle(height: 1.45, color: ink.withValues(alpha: .6))),
          ],
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: ink.withValues(alpha: .035),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '“At dawn, the light rain stopped. I opened the window and heard birds singing in the trees. A new day began.”',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5,
                fontStyle: FontStyle.italic,
                height: 1.45,
                color: ink.withValues(alpha: .75),
              ),
            ),
          ),
          _sourceAttribution(ink),
        ]),
      );

  Widget _toneChip(Map<String, dynamic> word, Color ink) {
    final expected = (word['expectedTone'] as num?)?.toInt() ?? 0;
    final actual = (word['actualTone'] as num?)?.toInt() ?? 0;
    final correct = expected == actual && expected != 0;
    return InkWell(
      key: Key('tone_character_${word['word']}'),
      borderRadius: BorderRadius.circular(16),
      onTap: () => ToneComparisonSheet.show(
        context,
        character: word['word'].toString(),
        pinyin: (word['pinyin'] ?? '').toString(),
        expectedTone: expected,
        actualTone: actual,
        feedback: (word['feedback'] ?? '').toString(),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: correct ? Colors.green : Colors.orange),
        ),
        child: Column(children: [
          Text(word['word'].toString(),
              style: TextStyle(fontSize: 34, color: ink)),
          Text((word['pinyin'] ?? '').toString(),
              style: TextStyle(color: ink.withValues(alpha: .6))),
          Text('You: $actual  ·  Target: $expected',
              style: TextStyle(
                  fontSize: 11, color: correct ? Colors.green : Colors.orange)),
        ]),
      ),
    );
  }

  Widget _lessonColumn(
    Color ink, {
    required String instruction,
    required Widget child,
    required String primaryLabel,
    required IconData primaryIcon,
    required VoidCallback? onPrimary,
    String? secondaryLabel,
    VoidCallback? onSecondary,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(instruction,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16, height: 1.45, color: ink.withValues(alpha: .7))),
        const SizedBox(height: 24),
        child,
        if (_message != null) ...[
          const SizedBox(height: 16),
          Text(_message!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.orange)),
        ],
        const SizedBox(height: 32),
        FilledButton.icon(
          onPressed: onPrimary,
          icon: Icon(primaryIcon),
          label: Text(primaryLabel),
          style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 17)),
        ),
        if (secondaryLabel != null) ...[
          const SizedBox(height: 8),
          TextButton(onPressed: onSecondary, child: Text(secondaryLabel)),
        ],
      ],
    );
  }
}

class _RecapRow extends StatelessWidget {
  const _RecapRow(this.icon, this.label);
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(label),
        trailing: const Icon(Icons.check_circle, color: Colors.green),
      );
}
