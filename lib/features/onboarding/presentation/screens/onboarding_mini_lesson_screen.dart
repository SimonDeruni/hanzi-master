import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/character_loader.dart';
import 'package:hanzi_master/core/services/analytics_service.dart';
import 'package:hanzi_master/core/services/audio_recording_service.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/echo_hall/presentation/widgets/tone_comparison_sheet.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/drawing_canvas.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';

/// A self-contained, ultra-guided interactive preview of the 5 core learning tools
/// in SinoSpark / Hanzi Master. It deliberately does not mutate persistent user progress.
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
    extends ConsumerState<OnboardingMiniLessonScreen>
    with SingleTickerProviderStateMixin {
  static const _passage = '清晨，小雨停了。我打开窗户，听见鸟儿在树上唱歌。新的一天开始了。';
  static const _passagePinyin =
      'Qīngchén, xiǎoyǔ tíng le. Wǒ dǎkāi chuānghu, tīngjiàn niǎor zài shù shàng chànggē. Xīn de yì tiān kāishǐ le.';
  static const _passageEnglish =
      '“At dawn, the light rain stopped. I opened the window and heard birds singing in the trees. A new day began.”';
  static const _shadowSentence = '我打开窗户。';
  static const _shadowPinyin = 'wǒ dǎ kāi chuāng hu';

  static const _titles = [
    'Audiobook Reader',
    'Shadowing & Tones',
    'Web Explorer',
    'AI Voice Roleplay',
    'Guided Handwriting',
  ];

  static const _stepCount = 5;

  int _step = 0;
  bool _busy = false;
  bool _recording = false;
  String? _message;

  // Step 1: Audiobook Voice Picker
  String _selectedVoice = 'Fenrir';
  final List<Map<String, String>> _voices = const [
    {'id': 'Fenrir', 'name': 'Yunxi (Fenrir)', 'desc': 'Male · Warm Storyteller'},
    {'id': 'Aoede', 'name': 'Xiaoxiao (Aoede)', 'desc': 'Female · Clear Narrator'},
    {'id': 'Kore', 'name': 'Xiaoyi (Kore)', 'desc': 'Female · Gentle Reading'},
    {'id': 'Charon', 'name': 'Yunjian (Charon)', 'desc': 'Male · Dramatic Audio'},
  ];

  // Step 2: Tone Analysis & Shadowing
  List<Map<String, dynamic>> _words = const [];

  // Step 3: Web Explorer Preview
  bool _hasTappedWebWord = false;

  // Step 4: AI Voice Roleplay
  int _selectedAiReply = -1;
  bool _isPlayingAiVoice = false;

  // Step 5: Handwriting Canvas
  List<String> _strokes = const [];
  List<List<Offset>> _medianPaths = const [];
  int _currentStrokeIndex = 0;

  late final AudioRecordingService _recorder;
  late final AudioService _audioService;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _recorder = ref.read(audioRecordingServiceProvider);
    _audioService = ref.read(audioServiceProvider);
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _loadBundledStrokes();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(analyticsServiceProvider)
          .logEvent('onboarding_mini_lesson_started');
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    if (_recording) _recorder.stopRecording();
    super.dispose();
  }

  Future<void> _loadBundledStrokes() async {
    try {
      final raw = await rootBundle.loadString('assets/data/hsk1_strokes.json');
      final data = jsonDecode(raw) as Map<String, dynamic>;
      final entry = data['好'] as Map<String, dynamic>?;
      if (mounted && entry != null) {
        final medianPaths = (entry['medians'] as List).map((median) {
          final points = (median as List)
              .map((point) => Offset(
                    (point as List)[0].toDouble(),
                    point[1].toDouble(),
                  ))
              .toList();
          return CharacterLoader.flipPoints(points)
              .map(CharacterLoader.transformPoint)
              .toList();
        }).toList();
        setState(() {
          _strokes = List<String>.from(entry['strokes'] as List);
          _medianPaths = medianPaths;
        });
      }
    } catch (error) {
      debugPrint('Could not load onboarding handwriting data: $error');
    }
  }

  Future<void> _play(String text, {String? voice}) async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _message = null;
    });
    try {
      if (!widget.disableExternalServicesForTesting) {
        final started = await _audioService.playSentence(
          text,
          voiceName: voice ?? _selectedVoice,
        );
        if (!started) throw Exception('Playback did not start');
      }
    } catch (_) {
      if (mounted) {
        setState(() => _message =
            'Audio is unavailable offline. You can still tap and explore!');
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
          }
          if (mounted) setState(() => _recording = true);
        } else if (mounted) {
          setState(() => _message =
              'Microphone access not granted. Try the quiet demo path below.');
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
      _message = 'Listening and evaluating your tones…';
    });
    String? path;
    try {
      if (!widget.disableExternalServicesForTesting) {
        path = await _recorder.stopRecording();
        if (path == null) throw Exception('No recording');

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
    } catch (error) {
      _words = _demoWords;
    } finally {
      if (path != null) {
        try {
          await File(path).delete();
        } catch (_) {}
      }
      if (mounted) {
        setState(() {
          _busy = false;
          _message = null;
        });
      }
    }
  }

  List<Map<String, dynamic>> get _demoWords => const [
        {
          'word': '我',
          'pinyin': 'wǒ',
          'expectedTone': 3,
          'actualTone': 3,
          'isCorrect': true,
          'feedback': 'Great dipping third tone contour!',
        },
        {
          'word': '打',
          'pinyin': 'dǎ',
          'expectedTone': 3,
          'actualTone': 3,
          'isCorrect': true,
          'feedback': 'Clear tone articulation.',
        },
        {
          'word': '开',
          'pinyin': 'kāi',
          'expectedTone': 1,
          'actualTone': 1,
          'isCorrect': true,
          'feedback': 'Solid high, level pitch.',
        },
        {
          'word': '窗',
          'pinyin': 'chuāng',
          'expectedTone': 1,
          'actualTone': 1,
          'isCorrect': true,
          'feedback': 'Precise 1st tone duration.',
        },
        {
          'word': '户',
          'pinyin': 'hu',
          'expectedTone': 5,
          'actualTone': 5,
          'isCorrect': true,
          'feedback': 'Natural neutral tone cadence.',
        },
      ];

  void _quietPath() {
    setState(() {
      _words = _demoWords;
      _message = null;
    });
  }

  void _goTo(int step) {
    ref.read(analyticsServiceProvider).logEvent(
      'onboarding_mini_lesson_step',
      parameters: {'step': _titles[step].toLowerCase().replaceAll(' ', '_')},
    );
    setState(() {
      _step = step;
      _message = null;
      if (step == 4) _currentStrokeIndex = 0;
    });
  }

  void _finish() {
    ref
        .read(analyticsServiceProvider)
        .logEvent('onboarding_mini_lesson_completed');
    widget.onComplete();
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
              // Top Progress and Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '${_step + 1} / $_stepCount',
                          style: TextStyle(
                            color: ink.withValues(alpha: .55),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: (_step + 1) / _stepCount,
                              backgroundColor: ink.withValues(alpha: .08),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFFB8860B),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _titles[_step],
                      style: TextStyle(
                        fontFamily: 'Serif',
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: ink,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 260),
                  child: SingleChildScrollView(
                    key: ValueKey(_step),
                    padding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
                    child: _buildCurrentStep(ink, isDark),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentStep(Color ink, bool isDark) {
    switch (_step) {
      case 0:
        return _buildStep1Audiobook(ink, isDark);
      case 1:
        return _buildStep2Shadowing(ink, isDark);
      case 2:
        return _buildStep3WebExplorer(ink, isDark);
      case 3:
        return _buildStep4AiRoleplay(ink, isDark);
      case 4:
      default:
        return _buildStep5Handwriting(ink, isDark);
    }
  }

  // ===========================================================================
  // Step 1: 🎧 Studio Audiobook Reader
  // ===========================================================================
  Widget _buildStep1Audiobook(Color ink, bool isDark) {
    return _lessonColumn(
      ink,
      instructionBanner:
          'Tap any neural voice to hear Ba Jin\'s 《春》 with natural human narration. Tap any character for instant Quick Look.',
      child: Column(
        children: [
          // Voice Selector Chips Row
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ink.withValues(alpha: .04),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ink.withValues(alpha: .08)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.mic, size: 16, color: Color(0xFFB8860B)),
                      const SizedBox(width: 6),
                      Text(
                        'AZURE NEURAL VOICES',
                        style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          color: ink.withValues(alpha: .6),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _voices.map((v) {
                    final isSelected = _selectedVoice == v['id'];
                    return AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        return InkWell(
                          onTap: () {
                            setState(() => _selectedVoice = v['id']!);
                            _play(_passage, voice: v['id']);
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? (isDark
                                      ? const Color(0xFF2A2A2B)
                                      : const Color(0xFFFFF9E6))
                                  : (isDark
                                      ? const Color(0xFF1E1E1F)
                                      : Colors.white),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFFB8860B)
                                    : ink.withValues(alpha: .1),
                                width: isSelected ? 1.5 : 1.0,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: const Color(0xFFB8860B)
                                            .withValues(
                                                alpha: 0.2 +
                                                    0.15 *
                                                        _pulseController.value),
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                      )
                                    ]
                                  : null,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  isSelected
                                      ? Icons.volume_up
                                      : Icons.play_circle_outline,
                                  size: 16,
                                  color: isSelected
                                      ? const Color(0xFFB8860B)
                                      : ink.withValues(alpha: .5),
                                ),
                                const SizedBox(width: 6),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      v['name']!,
                                      style: TextStyle(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected
                                            ? const Color(0xFFB8860B)
                                            : ink,
                                      ),
                                    ),
                                    Text(
                                      v['desc']!,
                                      style: TextStyle(
                                        fontSize: 9.5,
                                        color: ink.withValues(alpha: .55),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Passage Card with Tappable Words
          _passageCard(ink, isDark),
        ],
      ),
      primaryLabel: 'Next: Shadow this sentence →',
      primaryIcon: Icons.arrow_forward,
      onPrimary: () => _goTo(1),
    );
  }

  Widget _passageCard(Color ink, bool isDark) => Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: ink.withValues(alpha: .045),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ink.withValues(alpha: .08)),
        ),
        child: Column(
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              children: _passage.characters.map((char) {
                final isPunctuation = RegExp(r'[，。！？、]').hasMatch(char);
                if (isPunctuation) {
                  return Text(
                    char,
                    style: TextStyle(
                      fontFamily: 'NotoSerifSC',
                      fontSize: 22,
                      color: ink,
                    ),
                  );
                }
                return InkWell(
                  onTap: () {
                    showQuickLook(context, char);
                  },
                  borderRadius: BorderRadius.circular(6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.5, vertical: 2),
                    child: Text(
                      char,
                      style: TextStyle(
                        fontFamily: 'NotoSerifSC',
                        fontSize: 22,
                        fontWeight: char == '窗' || char == '春'
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: char == '窗'
                            ? const Color(0xFF4F46E5)
                            : ink,
                        decoration: char == '窗'
                            ? TextDecoration.underline
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            Text(
              _passagePinyin,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.5,
                height: 1.4,
                color: ink.withValues(alpha: .6),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: ink.withValues(alpha: .03),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _passageEnglish,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.5,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                  color: ink.withValues(alpha: .75),
                ),
              ),
            ),
            _sourceAttribution(ink),
          ],
        ),
      );

  Widget _sourceAttribution(Color ink) => Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: ink.withValues(alpha: .03),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                'assets/images/books/spring_bajin.jpg',
                width: 24,
                height: 32,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.menu_book,
                  size: 18,
                  color: ink.withValues(alpha: .4),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Grand Library · Studio Narration',
                    style: TextStyle(
                      fontSize: 9.5,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w600,
                      color: ink.withValues(alpha: .5),
                    ),
                  ),
                  Text(
                    '《春》 (Spring) · 巴金 (Ba Jin)',
                    style: TextStyle(
                      fontSize: 11.5,
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

  // ===========================================================================
  // Step 2: 🎙️ Sentence Shadowing & 4 Tones Evaluation
  // ===========================================================================
  Widget _buildStep2Shadowing(Color ink, bool isDark) {
    return _lessonColumn(
      ink,
      instructionBanner:
          'Hold the microphone to repeat after the native speaker, or explore tone diagnostics below.',
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ink.withValues(alpha: .04),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: ink.withValues(alpha: .08)),
            ),
            child: Column(
              children: [
                Text(
                  _shadowSentence,
                  style: TextStyle(
                    fontFamily: 'NotoSerifSC',
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: ink,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _shadowPinyin,
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: ink.withValues(alpha: .65),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => _play(_shadowSentence),
                  icon: const Icon(Icons.volume_up_outlined, size: 18),
                  label: const Text('Hear Native Model'),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Tone evaluation chips
          if (_words.isNotEmpty) ...[
            Text(
              'Tone Pitch Contour Evaluation',
              style: TextStyle(
                fontSize: 12,
                letterSpacing: 0.5,
                fontWeight: FontWeight.bold,
                color: ink.withValues(alpha: .6),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: _words.map((w) => _toneChip(w, ink, isDark)).toList(),
            ),
            const SizedBox(height: 16),
          ],

          // Record or Demo Actions
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _toggleRecording,
                  icon: Icon(_recording ? Icons.stop : Icons.mic),
                  label: Text(_recording ? 'Stop & Grade' : 'Hold to Speak'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _recording
                        ? const Color(0xFFDC2626)
                        : const Color(0xFFB8860B),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                key: const ValueKey('onboardingQuietDemoButton'),
                onPressed: _quietPath,
                icon: const Icon(Icons.touch_app_outlined, size: 18),
                label: const Text("I can't speak right now (Try tone demo)"),
              ),
            ],
          ),
          if (_message != null) ...[
            const SizedBox(height: 8),
            Text(
              _message!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: ink.withValues(alpha: .7),
              ),
            ),
          ],
        ],
      ),
      primaryLabel: 'Next: Explore Chinese Web →',
      primaryIcon: Icons.arrow_forward,
      onPrimary: () => _goTo(2),
    );
  }

  Widget _toneChip(Map<String, dynamic> word, Color ink, bool isDark) {
    final hanzi = (word['word'] ?? '').toString();
    final pinyin = (word['pinyin'] ?? '').toString();
    final expected = (word['expectedTone'] ?? 1) as int;
    final actual = (word['actualTone'] ?? expected) as int;
    final isCorrect = (word['isCorrect'] ?? (expected == actual)) as bool;

    return InkWell(
      key: Key('tone_character_$hanzi'),
      onTap: () {
        ToneComparisonSheet.show(
          context,
          character: hanzi,
          pinyin: pinyin,
          expectedTone: expected,
          actualTone: actual,
          feedback: (word['feedback'] ?? '').toString(),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isCorrect
              ? const Color(0xFF10B981).withValues(alpha: .12)
              : const Color(0xFFEF4444).withValues(alpha: .12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isCorrect
                ? const Color(0xFF10B981).withValues(alpha: .4)
                : const Color(0xFFEF4444).withValues(alpha: .4),
          ),
        ),
        child: Column(
          children: [
            Text(
              hanzi,
              style: TextStyle(
                fontFamily: 'NotoSerifSC',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ink,
              ),
            ),
            Text(
              pinyin,
              style: TextStyle(
                fontSize: 11,
                color: ink.withValues(alpha: .7),
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isCorrect ? Icons.check_circle : Icons.error,
                  size: 12,
                  color: isCorrect
                      ? const Color(0xFF10B981)
                      : const Color(0xFFEF4444),
                ),
                const SizedBox(width: 3),
                Text(
                  isCorrect ? 'Tone $expected' : 'T$actual ➔ T$expected',
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                    color: isCorrect
                        ? const Color(0xFF10B981)
                        : const Color(0xFFEF4444),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // Step 3: 🌐 Chinese Web Explorer (Live BBC Chinese Inspection)
  // ===========================================================================
  Widget _buildStep3WebExplorer(Color ink, bool isDark) {
    const webSnippet = '神舟载人飞船成功返回地球，空间站任务取得圆满成功。';
    const webEnglish =
        '“The Shenzhou manned spacecraft successfully returned to Earth, marking a complete success for the space station mission.”';

    return _lessonColumn(
      ink,
      instructionBanner:
          'Tap any Chinese character in the live web article below to open instant dictionary cards and grammar breakdowns.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Browser address bar mockup
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: ink.withValues(alpha: .06),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              border: Border.all(color: ink.withValues(alpha: .1)),
            ),
            child: Row(
              children: [
                Icon(Icons.lock, size: 14, color: ink.withValues(alpha: .5)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'https://bbc.com/zhongwen/simp/space-shenzhou',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'monospace',
                      color: ink.withValues(alpha: .7),
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: .15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'HSK 6 · 88% Readability',
                    style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF10B981),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Browser Page Content
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1E1F) : Colors.white,
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(16)),
              border: Border(
                left: BorderSide(color: ink.withValues(alpha: .1)),
                right: BorderSide(color: ink.withValues(alpha: .1)),
                bottom: BorderSide(color: ink.withValues(alpha: .1)),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDC2626),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'BBC 中文',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '科技前沿 · 航天探索',
                      style: TextStyle(
                        fontSize: 11,
                        color: ink.withValues(alpha: .5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  children: webSnippet.characters.map((char) {
                    final isPunct = RegExp(r'[，。！？、]').hasMatch(char);
                    if (isPunct) {
                      return Text(
                        char,
                        style: TextStyle(
                          fontFamily: 'NotoSerifSC',
                          fontSize: 20,
                          color: ink,
                        ),
                      );
                    }
                    final isHighlight = char == '复' || char == '返';
                    return AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        return InkWell(
                          onTap: () {
                            setState(() => _hasTappedWebWord = true);
                            showQuickLook(context, char);
                          },
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 1.5, vertical: 1),
                            decoration: BoxDecoration(
                              color: isHighlight
                                  ? const Color(0xFF4F46E5).withValues(
                                      alpha: 0.12 +
                                          0.08 * _pulseController.value)
                                  : null,
                              borderRadius: BorderRadius.circular(4),
                              border: isHighlight
                                  ? Border.all(
                                      color: const Color(0xFF4F46E5)
                                          .withValues(alpha: .4),
                                    )
                                  : null,
                            ),
                            child: Text(
                              char,
                              style: TextStyle(
                                fontFamily: 'NotoSerifSC',
                                fontSize: 20,
                                fontWeight: isHighlight
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isHighlight
                                    ? const Color(0xFF4F46E5)
                                    : ink,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                Text(
                  webEnglish,
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: ink.withValues(alpha: .6),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (!_hasTappedWebWord)
            Center(
              child: Text(
                '💡 Tip: Tap highlighted characters like 「返」 to explore instant dictionary popovers.',
                style: TextStyle(
                  fontSize: 11.5,
                  color: ink.withValues(alpha: .6),
                ),
              ),
            ),
        ],
      ),
      primaryLabel: 'Next: Discuss with AI Tutor →',
      primaryIcon: Icons.arrow_forward,
      onPrimary: () => _goTo(3),
    );
  }

  // ===========================================================================
  // Step 4: 🤖 Gemini AI Voice Roleplay
  // ===========================================================================
  Widget _buildStep4AiRoleplay(Color ink, bool isDark) {
    const aiQuestion = '关于这篇文章，你有什么看法？';
    const aiQuestionPinyin = 'Guānyú zhè piān wénzhāng, nǐ yǒu shénme kànfǎ?';
    const replies = [
      {
        'text': '这篇文章很有意思！',
        'pinyin': 'Zhè piān wénzhāng hěn yǒu yìsi!',
        'trans': 'This article is very interesting!',
      },
      {
        'text': '我想了解更多背景。',
        'pinyin': 'Wǒ xiǎng liǎojiě gèng duō bèijǐng.',
        'trans': 'I want to know more background.',
      },
    ];

    return _lessonColumn(
      ink,
      instructionBanner:
          'Interact with your AI Scholar tutor. Listen to the spoken prompt and pick a conversational reply.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI Message Bubble
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF4F46E5).withValues(alpha: .08),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(4),
              ),
              border: Border.all(
                color: const Color(0xFF4F46E5).withValues(alpha: .2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 14,
                      backgroundColor: Color(0xFF4F46E5),
                      child: Icon(Icons.auto_awesome, size: 14, color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'AI Tutor · Gemini Live Voice',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: ink.withValues(alpha: .85),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        _isPlayingAiVoice
                            ? Icons.volume_up
                            : Icons.volume_up_outlined,
                        size: 20,
                        color: const Color(0xFF4F46E5),
                      ),
                      onPressed: () async {
                        setState(() => _isPlayingAiVoice = true);
                        await _play(aiQuestion, voice: 'Fenrir');
                        if (mounted) {
                          setState(() => _isPlayingAiVoice = false);
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  aiQuestion,
                  style: TextStyle(
                    fontFamily: 'NotoSerifSC',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ink,
                  ),
                ),
                Text(
                  aiQuestionPinyin,
                  style: TextStyle(
                    fontSize: 12,
                    color: ink.withValues(alpha: .6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '“What are your thoughts on this article?”',
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: ink.withValues(alpha: .7),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Text(
            'SELECT A GUIDED SPOKEN REPLY',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
              color: ink.withValues(alpha: .6),
            ),
          ),
          const SizedBox(height: 8),

          // Guided Replies
          ...replies.asMap().entries.map((entry) {
            final idx = entry.key;
            final r = entry.value;
            final isSelected = _selectedAiReply == idx;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () {
                  setState(() => _selectedAiReply = idx);
                  _play(r['text']!);
                },
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF10B981).withValues(alpha: .12)
                        : ink.withValues(alpha: .04),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF10B981)
                          : ink.withValues(alpha: .1),
                      width: isSelected ? 1.5 : 1.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        size: 18,
                        color: isSelected
                            ? const Color(0xFF10B981)
                            : ink.withValues(alpha: .4),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              r['text']!,
                              style: TextStyle(
                                fontFamily: 'NotoSerifSC',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ink,
                              ),
                            ),
                            Text(
                              r['pinyin']!,
                              style: TextStyle(
                                fontSize: 11.5,
                                color: ink.withValues(alpha: .6),
                              ),
                            ),
                            Text(
                              r['trans']!,
                              style: TextStyle(
                                fontSize: 11,
                                fontStyle: FontStyle.italic,
                                color: ink.withValues(alpha: .7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.volume_up_outlined, size: 18),
                        onPressed: () => _play(r['text']!),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),

          if (_selectedAiReply != -1)
            Container(
              margin: const EdgeInsets.only(top: 6),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: .1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.verified, size: 16, color: Color(0xFF10B981)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'AI Feedback: Natural phrasing & 98% Tone Match!',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF10B981),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      primaryLabel: 'Next: Practice Handwriting →',
      primaryIcon: Icons.arrow_forward,
      onPrimary: () => _goTo(4),
    );
  }

  // ===========================================================================
  // Step 5: ✍️ Guided Handwriting Canvas (Trace 「好」)
  // ===========================================================================
  Widget _buildStep5Handwriting(Color ink, bool isDark) {
    final hasStrokes = _strokes.isNotEmpty;
    final totalStrokes = _strokes.length;
    final progress = totalStrokes > 0 ? (_currentStrokeIndex / totalStrokes) : 0.0;

    return _lessonColumn(
      ink,
      instructionBanner:
          'Trace the calligraphic stroke guides on the canvas below to master Chinese stroke orders.',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Character: 好 (hǎo · good)',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: ink,
                      ),
                    ),
                    Text(
                      'Stroke ${_currentStrokeIndex + 1} of $totalStrokes',
                      style: TextStyle(
                        fontSize: 12,
                        color: ink.withValues(alpha: .6),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  setState(() => _currentStrokeIndex = 0);
                },
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text('Clear'),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Canvas Box
          Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF222223) : const Color(0xFFFCFBF4),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFB8860B).withValues(alpha: .4),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .08),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: hasStrokes
                ? OnboardingPracticeCanvas(
                    strokePaths: _strokes,
                    medianPaths: _medianPaths,
                    currentStrokeIndex: _currentStrokeIndex,
                    onStrokeComplete: () {
                      if (_currentStrokeIndex < _strokes.length - 1) {
                        setState(() => _currentStrokeIndex++);
                      }
                    },
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          const SizedBox(height: 16),

          // Progress indicator for strokes
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 8,
              backgroundColor: ink.withValues(alpha: .08),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _currentStrokeIndex >= totalStrokes && totalStrokes > 0
                ? '🎉 Excellent calligraphic precision! You\'re ready.'
                : 'Follow the glowing guide line to write each stroke.',
            style: TextStyle(
              fontSize: 12,
              fontWeight: _currentStrokeIndex >= totalStrokes
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: _currentStrokeIndex >= totalStrokes
                  ? const Color(0xFF10B981)
                  : ink.withValues(alpha: .6),
            ),
          ),
        ],
      ),
      primaryLabel: 'See Your Personalized Plan →',
      primaryIcon: Icons.auto_awesome,
      onPrimary: _finish,
    );
  }

  // ===========================================================================
  // Reusable Step Container
  // ===========================================================================
  Widget _lessonColumn(
    Color ink, {
    required String instructionBanner,
    required Widget child,
    required String primaryLabel,
    required IconData primaryIcon,
    required VoidCallback onPrimary,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Instruction banner
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFB8860B).withValues(alpha: .08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFB8860B).withValues(alpha: .25),
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline,
                  size: 18, color: Color(0xFFB8860B)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  instructionBanner,
                  style: TextStyle(
                    fontSize: 12.5,
                    height: 1.35,
                    color: ink.withValues(alpha: .85),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        child,
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: onPrimary,
          icon: Icon(primaryIcon, size: 20),
          label: Text(
            primaryLabel,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB8860B),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
          ),
        ),
      ],
    );
  }
}

class OnboardingPracticeCanvas extends StatelessWidget {
  const OnboardingPracticeCanvas({
    super.key,
    required this.strokePaths,
    required this.medianPaths,
    required this.currentStrokeIndex,
    required this.onStrokeComplete,
  });

  final List<String> strokePaths;
  final List<List<Offset>> medianPaths;
  final int currentStrokeIndex;
  final VoidCallback onStrokeComplete;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CalligraphyBackground(
          child: DrawingCanvas(
            key: const ValueKey('onboardingPracticeCanvas'),
            strokePaths: strokePaths,
            medianPaths: medianPaths,
            showAnimation: false,
            showReference: true,
            showGuideLines: true,
            strokeByStrokeMode: true,
            currentStrokeIndex: currentStrokeIndex,
            showGrade: false,
            showControls: false,
            onStrokeComplete: (_, __) => onStrokeComplete(),
          ),
        ),
      );
}
