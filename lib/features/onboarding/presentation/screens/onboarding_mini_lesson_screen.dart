import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hanzi_master/features/onboarding/presentation/onboarding_design.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/core/character_loader.dart';
import 'package:hanzi_master/core/services/analytics_service.dart';
import 'package:hanzi_master/core/services/audio_recording_service.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/echo_hall/presentation/widgets/tone_comparison_sheet.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/drawing_canvas.dart';
import 'package:hanzi_master/features/onboarding/presentation/screens/notification_permission_screen.dart';

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
  List<List<Offset>> _medianPaths = const [];
  bool _isFlipped = false;
  int _currentStrokeIndex = 0;
  final ValueNotifier<List<Offset?>> _userPointsNotifier = ValueNotifier([]);
  late final AudioRecordingService _recorder;
  late final AudioService _audioService;

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
      const initialCard = Flashcard(
        id: 'onboarding_hao',
        hanzi: '好',
        pinyin: 'hǎo',
        definition: 'good',
        deckId: 'onboarding',
        hskLevel: 1,
        strokePaths: [],
        modeStats: {},
      );
      final hydrated = await ref
          .read(flashcardControllerProvider.notifier)
          .loadStrokesFor(initialCard);
      if (mounted && hydrated != null && hydrated.strokePaths.isNotEmpty) {
        setState(() {
          _strokes = hydrated.strokePaths;
          _medianPaths = hydrated.medianPaths;
          _isFlipped = hydrated.isFlipped;
        });
        return;
      }
    } catch (_) {}

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
          _isFlipped = false;
        });
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
      if (mounted) _goTo(3);
    } catch (error) {
      if (mounted) {
        setState(() {
          _message = error.toString().replaceFirst('Exception: ', '');
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
          'word': '我',
          'pinyin': 'wǒ',
          'expectedTone': 3,
          'actualTone': 3,
          'isCorrect': true,
          'feedback': 'Great dipping 3rd tone.',
        },
        {
          'word': '打',
          'pinyin': 'dǎ',
          'expectedTone': 3,
          'actualTone': 2,
          'isCorrect': false,
          'feedback': 'Dip lower before rising for the 3rd tone.',
        },
        {
          'word': '开',
          'pinyin': 'kāi',
          'expectedTone': 1,
          'actualTone': 1,
          'isCorrect': true,
          'feedback': 'High and flat 1st tone.',
        },
        {
          'word': '窗',
          'pinyin': 'chuāng',
          'expectedTone': 1,
          'actualTone': 1,
          'isCorrect': true,
          'feedback': 'Sustained high 1st tone.',
        },
        {
          'word': '户',
          'pinyin': 'hu',
          'expectedTone': 4,
          'actualTone': 4,
          'isCorrect': true,
          'feedback': 'Light falling tone.',
        },
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
      if (step == 4) _currentStrokeIndex = 0;
    });
  }

  Future<void> _finish() async {
    ref
        .read(analyticsServiceProvider)
        .logEvent('onboarding_mini_lesson_completed');
    widget.onComplete();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('has_seen_onboarding', true);
    } catch (_) {}
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(
          builder: (context) => const NotificationPermissionScreen(),
        ),
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    if (_recording) _recorder.stopRecording();
    _userPointsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ink = isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    return Scaffold(
      key: const Key('onboarding_mini_lesson_screen'),
      backgroundColor: isDark
          ? OnboardingDesign.backgroundDark
          : OnboardingDesign.backgroundLight,
      body: CalligraphyBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  OnboardingDesign.horizontalPadding,
                  OnboardingDesign.topPadding,
                  OnboardingDesign.horizontalPadding,
                  8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'YOUR FIRST LESSON  •  ${_step + 1} OF ${_titles.length}',
                      key: const Key('onboarding_lesson_eyebrow'),
                      style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Text(
                        _titles[_step],
                        key: ValueKey('lesson-title-$_step'),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'Serif',
                          fontSize: OnboardingDesign.titleFontSize,
                          height: 1.2,
                          color: ink,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildProgressIndicator(isDark),
                  ],
                ),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  transitionBuilder: (child, animation) {
                    final curvedAnimation = CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOutCubic,
                    );
                    return FadeTransition(
                      opacity: curvedAnimation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.04, 0),
                          end: Offset.zero,
                        ).animate(curvedAnimation),
                        child: child,
                      ),
                    );
                  },
                  child: SingleChildScrollView(
                    key: ValueKey(_step),
                    padding: const EdgeInsets.fromLTRB(
                      OnboardingDesign.horizontalPadding,
                      12,
                      OnboardingDesign.horizontalPadding,
                      OnboardingDesign.bottomPadding,
                    ),
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

  Widget _buildProgressIndicator(bool isDark) {
    return Row(
      key: const Key('onboarding_lesson_progress'),
      children: List.generate(_titles.length, (index) {
        final isReached = index <= _step;
        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 6,
            margin: EdgeInsets.only(
              right: index == _titles.length - 1 ? 0 : 8,
            ),
            decoration: BoxDecoration(
              color: isReached
                  ? Colors.red[700]
                  : isDark
                      ? Colors.white24
                      : Colors.black12,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        );
      }),
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
                : OnboardingPracticeCanvas(
                    strokePaths: _strokes,
                    medianPaths: _medianPaths,
                    isFlipped: _isFlipped,
                    currentStrokeIndex: _currentStrokeIndex,
                    userPointsNotifier: _userPointsNotifier,
                    onStrokeComplete: () {
                      HapticsManager.light();
                      _userPointsNotifier.value = [];
                      final validStrokes = _strokes
                          .where((s) => s != '__CHAR_SEPARATOR__')
                          .toList();
                      if (_currentStrokeIndex < validStrokes.length - 1) {
                        setState(() => _currentStrokeIndex++);
                      } else {
                        HapticsManager.success();
                        if (!widget.disableExternalServicesForTesting) {
                          _audioService.playCharacter('好');
                        }
                        Future.delayed(const Duration(milliseconds: 600), () {
                          if (mounted) {
                            _goTo(5);
                          }
                        });
                      }
                    },
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
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: OnboardingDesign.bodyFontSize,
                height: 1.45,
                color: ink.withValues(alpha: .7))),
        const SizedBox(height: OnboardingDesign.sectionSpacing),
        child,
        if (_message != null) ...[
          const SizedBox(height: 16),
          Text(_message!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.orange)),
        ],
        const SizedBox(height: 32),
        SizedBox(
          height: OnboardingDesign.primaryButtonHeight,
          child: FilledButton.icon(
            key: const Key('onboarding_primary_button'),
            onPressed: onPrimary,
            icon: Icon(primaryIcon),
            label: Text(
              primaryLabel,
              style: const TextStyle(
                fontSize: OnboardingDesign.bodyFontSize,
                fontWeight: FontWeight.w700,
              ),
            ),
            style: FilledButton.styleFrom(
              backgroundColor: ink,
              foregroundColor: Theme.of(context).brightness == Brightness.dark
                  ? OnboardingDesign.backgroundDark
                  : OnboardingDesign.backgroundLight,
              disabledBackgroundColor: ink.withValues(alpha: 0.3),
              disabledForegroundColor:
                  (Theme.of(context).brightness == Brightness.dark
                          ? OnboardingDesign.backgroundDark
                          : OnboardingDesign.backgroundLight)
                      .withValues(alpha: 0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  OnboardingDesign.primaryButtonRadius,
                ),
              ),
            ),
          ),
        ),
        if (secondaryLabel != null) ...[
          const SizedBox(height: 8),
          TextButton(onPressed: onSecondary, child: Text(secondaryLabel)),
        ],
      ],
    );
  }
}

class OnboardingPracticeCanvas extends StatelessWidget {
  const OnboardingPracticeCanvas({
    super.key,
    required this.strokePaths,
    required this.medianPaths,
    this.isFlipped = false,
    required this.currentStrokeIndex,
    required this.onStrokeComplete,
    this.userPointsNotifier,
  });

  final List<String> strokePaths;
  final List<List<Offset>> medianPaths;
  final bool isFlipped;
  final int currentStrokeIndex;
  final VoidCallback onStrokeComplete;
  final ValueNotifier<List<Offset?>>? userPointsNotifier;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF2A2A2B)
                : Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: (isDark ? Colors.white : Colors.black)
                  .withValues(alpha: isDark ? 0.10 : 0.06),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.12),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: CalligraphyBackground(
            child: DrawingCanvas(
              key: const ValueKey('onboardingPracticeCanvas'),
              strokePaths: strokePaths,
              medianPaths: medianPaths,
              isFlipped: isFlipped,
              showAnimation: false,
              strokeByStrokeMode: true,
              currentStrokeIndex: currentStrokeIndex,
              onStrokeComplete: (_, __) => onStrokeComplete(),
              masteryLevel: 0,
              showReference: true,
              showGuideLines: true,
              showControls: false,
              showGrade: false,
              autoActiveChar: false,
              userPointsNotifier: userPointsNotifier,
            ),
          ),
        ),
      ),
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
