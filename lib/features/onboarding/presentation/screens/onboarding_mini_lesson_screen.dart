import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:hanzi_master/features/onboarding/presentation/onboarding_design.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/core/widgets/ltr_sanctuary.dart';
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
import 'package:hanzi_master/shared/widgets/ai_consent_sheet.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

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
  static const _passage = '知彼知己者，百战不殆。';
  static const _shadowSentence = '百战不殆。';
  static const _shadowPinyin = 'bǎi zhàn bù dài';
  static const _onboardingSpeechRate = 0.42;

  List<String> _titles(AppLocalizations l10n) => [
        l10n.listen,
        l10n.notice,
        l10n.shadow,
        l10n.fourTones,
        l10n.write,
        l10n.recap,
      ];

  int _step = 0;
  bool _busy = false;
  bool _recording = false;
  String? _message;
  bool _micPermissionDenied = false;
  List<Map<String, dynamic>> _words = const [];
  List<String> _strokes = const [];
  List<List<Offset>> _medianPaths = const [];
  bool _isFlipped = false;
  int _currentStrokeIndex = 0;
  int _selectedToneIndex = 0;
  final ValueNotifier<List<Offset?>> _userPointsNotifier = ValueNotifier([]);
  late final AudioRecordingService _recorder;
  late final AudioService _audioService;
  StreamSubscription<Map<String, dynamic>>? _wordBoundarySubscription;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<Duration>? _durationSubscription;
  StreamSubscription<void>? _completionSubscription;
  StreamSubscription<String>? _playbackErrorSubscription;
  String? _speakingText;
  int? _speakingCharacterIndex;
  Duration _playbackDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _recorder = ref.read(audioRecordingServiceProvider);
    _audioService = ref.read(audioServiceProvider);
    _wordBoundarySubscription =
        _audioService.onWordBoundary.listen(_handleWordBoundary);
    _positionSubscription =
        _audioService.onPositionChanged.listen(_handlePlaybackPosition);
    _durationSubscription = _audioService.onDurationChanged.listen((duration) {
      _playbackDuration = duration;
    });
    _completionSubscription =
        _audioService.onPlayerComplete.listen((_) => _clearSpeakingCharacter());
    _playbackErrorSubscription =
        _audioService.onPlaybackError.listen((_) => _clearSpeakingCharacter());
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
        id: 'onboarding_zhan',
        hanzi: '战',
        pinyin: 'zhàn',
        definition: 'battle',
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
      final entry = data['战'] as Map<String, dynamic>?;
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
      _speakingText = text;
      _speakingCharacterIndex = 0;
      _playbackDuration = Duration.zero;
    });
    try {
      if (!widget.disableExternalServicesForTesting) {
        final started = await _audioService.playSentence(
          text,
          voiceName: 'Fenrir',
          speechRate: _onboardingSpeechRate,
        );
        if (!started) throw Exception('Playback did not start');
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _speakingText = null;
          _speakingCharacterIndex = null;
          _message = AppLocalizations.of(context)!
              .audioIsUnavailableYouCan;
        });
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _handleWordBoundary(Map<String, dynamic> boundary) {
    final text = _speakingText;
    if (!mounted || text == null) return;
    final start = boundary['start'] ?? boundary['TextOffset'];
    final offset = start is int ? start : int.tryParse(start?.toString() ?? '');
    if (offset != null && offset >= 0 && offset < text.length) {
      setState(() => _speakingCharacterIndex = offset);
    }
  }

  void _handlePlaybackPosition(Duration position) {
    final text = _speakingText;
    if (!mounted || text == null || _playbackDuration <= Duration.zero) return;
    final progress =
        (position.inMilliseconds / _playbackDuration.inMilliseconds)
            .clamp(0.0, 0.999);
    final index = (progress * text.length).floor();
    if (index != _speakingCharacterIndex) {
      setState(() => _speakingCharacterIndex = index);
    }
  }

  void _clearSpeakingCharacter() {
    if (!mounted || _speakingText == null) return;
    setState(() {
      _speakingText = null;
      _speakingCharacterIndex = null;
      _playbackDuration = Duration.zero;
    });
  }

  Future<void> _toggleRecording() async {
    if (_busy) return;
    if (!_recording) {
      setState(() {
        _busy = true;
        _message = null;
      });
      try {
        final hasPerm = widget.disableExternalServicesForTesting ||
            await _recorder.requestPermission();
        if (!hasPerm) {
          if (mounted) {
            setState(() {
              _micPermissionDenied = true;
              _message = AppLocalizations.of(context)!
                  .microphoneAccessWasNotGranted;
            });
          }
          return;
        }
        if (!widget.disableExternalServicesForTesting) {
          if (!mounted) return;
          final consent = await AiConsentSheet.ensureConsent(context);
          if (!consent || !mounted) return;
          await _recorder.startRecording('onboarding_shadow');
        }
        if (mounted) setState(() => _recording = true);
      } catch (_) {
        if (mounted) {
          setState(() => _message =
              AppLocalizations.of(context)!.recordingIsUnavailableRightNow);
        }
      } finally {
        if (mounted) setState(() => _busy = false);
      }
      return;
    }

    setState(() {
      _recording = false;
      _busy = true;
      _message = AppLocalizations.of(context)!.listeningToYourTones;
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
    } catch (_) {
      if (mounted) {
        setState(() {
          _message = AppLocalizations.of(context)!.weCouldNotScoreThat;
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

  List<Map<String, dynamic>> get _demoWords => [
        {
          'word': '百',
          'pinyin': 'bǎi',
          'expectedTone': 3,
          'actualTone': 3,
          'isCorrect': true,
          'feedback':
              AppLocalizations.of(context)!.onboardingFeedbackGreatThirdTone,
        },
        {
          'word': '战',
          'pinyin': 'zhàn',
          'expectedTone': 4,
          'actualTone': 2,
          'isCorrect': false,
          'feedback':
              AppLocalizations.of(context)!.onboardingFeedbackFourthToneFall,
        },
        {
          'word': '不',
          'pinyin': 'bù',
          'expectedTone': 4,
          'actualTone': 4,
          'isCorrect': true,
          'feedback':
              AppLocalizations.of(context)!.onboardingFeedbackClearFourthTone,
        },
        {
          'word': '殆',
          'pinyin': 'dài',
          'expectedTone': 4,
          'actualTone': 4,
          'isCorrect': true,
          'feedback':
              AppLocalizations.of(context)!.onboardingFeedbackStrongFourthTone,
        },
      ];

  void _quietPath() {
    _words = _demoWords;
    _goTo(3);
  }

  void _goTo(int step) {
    ref.read(analyticsServiceProvider).logEvent(
      'onboarding_mini_lesson_step',
      parameters: {'step': step},
    );
    setState(() {
      _step = step;
      _message = null;
      _micPermissionDenied = false;
      if (step == 3) {
        final firstNeedsWork = _words.indexWhere((word) {
          final expected = (word['expectedTone'] as num?)?.toInt() ?? 0;
          final actual = (word['actualTone'] as num?)?.toInt() ?? 0;
          return expected == 0 || expected != actual;
        });
        _selectedToneIndex = firstNeedsWork < 0 ? 0 : firstNeedsWork;
      }
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
    _wordBoundarySubscription?.cancel();
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _completionSubscription?.cancel();
    _playbackErrorSubscription?.cancel();
    _userPointsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final titles = _titles(l10n);
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
                      l10n.onboardingLessonProgress(_step + 1, titles.length),
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
                        titles[_step],
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
      children:
          List.generate(_titles(AppLocalizations.of(context)!).length, (index) {
        final isReached = index <= _step;
        return Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 6,
            margin: EdgeInsets.only(
              right: index == _titles(AppLocalizations.of(context)!).length - 1
                  ? 0
                  : 8,
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
    final l10n = AppLocalizations.of(context)!;
    switch (_step) {
      case 0:
        return _lessonColumn(
          ink,
          instruction: l10n.onboardingListenInstruction,
          child: _listenCard(ink),
          primaryLabel: _busy ? l10n.loadingAudio : l10n.listenToThePassage,
          primaryIcon: Icons.headphones,
          onPrimary: _busy ? null : () => _play(_passage),
          secondaryLabel: l10n.continueAction,
          onSecondary: () => _goTo(1),
        );
      case 1:
        return _lessonColumn(
          ink,
          instruction: l10n.noticeHowMeaningSoundAnd,
          child: _noticeCard(ink),
          primaryLabel: l10n.shadowOneSentence,
          primaryIcon: Icons.arrow_forward,
          onPrimary: () => _goTo(2),
        );
      case 2:
        return _lessonColumn(
          ink,
          instruction: l10n.listenOnceThenHoldThe,
          child: _shadowCard(ink),
          primaryLabel:
              _recording ? l10n.stopAndCheckMyTones : l10n.continueAction,
          primaryIcon:
              _recording ? Icons.stop_circle_outlined : Icons.arrow_forward,
          onPrimary: _busy
              ? null
              : (_micPermissionDenied ? _quietPath : _toggleRecording),
          secondaryLabel: _micPermissionDenied ? l10n.settingsTitle : null,
          onSecondary: _micPermissionDenied ? () => openAppSettings() : null,
        );
      case 3:
        return _lessonColumn(
          ink,
          instruction: l10n.tapACharacterToCompare,
          child: _toneResultsCard(ink),
          primaryLabel: l10n.tryHandwriting,
          primaryIcon: Icons.draw_outlined,
          onPrimary: () => _goTo(4),
        );
      case 4:
        return _lessonColumn(
          ink,
          instruction: l10n.onboardingTraceInstruction('战', 'zhàn', l10n.battle),
          child: SizedBox(
            height: 310,
            child: LtrSanctuary(
              child: _strokes.isEmpty
                  ? Center(
                      child: Text('战',
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
                            _audioService.playCharacter('战');
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
          ),
          primaryLabel: l10n.seeWhatYouLearned,
          primaryIcon: Icons.check,
          onPrimary: () => _goTo(5),
        );
      default:
        return _lessonColumn(
          ink,
          instruction: l10n.inAFewMinutesYou,
          child: Column(
            children: [
              _RecapRow(Icons.headphones, l10n.listenedToChineseInContext),
              _RecapRow(Icons.record_voice_over, l10n.shadowedASentence),
              _RecapRow(Icons.graphic_eq, l10n.comparedMandarinTones),
              _RecapRow(Icons.gesture, l10n.practicedARealCharacter),
            ],
          ),
          primaryLabel: l10n.continueAction,
          primaryIcon: Icons.arrow_forward,
          onPrimary: _finish,
        );
    }
  }

  BoxDecoration _lessonCardDecoration(Color ink) => BoxDecoration(
        color: ink.withValues(alpha: .045),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: ink.withValues(alpha: .09)),
      );

  Widget _sourceAttribution(Color ink) => Container(
        margin: const EdgeInsets.only(top: 22),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ink.withValues(alpha: .04),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ink.withValues(alpha: .08)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.asset(
                'assets/images/books/the_art_of_war.jpg',
                width: 64,
                height: 96,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.menu_book,
                  size: 44,
                  color: ink.withValues(alpha: .4),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.onboardingFromGrandLibrary,
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w700,
                      color: ink.withValues(alpha: .5),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '《孙子兵法》',
                    style: TextStyle(
                      fontFamily: 'NotoSerifSC',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: ink.withValues(alpha: .85),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    AppLocalizations.of(context)!.onboardingArtOfWarTitleAuthor,
                    style: TextStyle(
                      fontSize: 13,
                      color: ink.withValues(alpha: .62),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    AppLocalizations.of(context)!.onboardingArtOfWarChapter,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.red[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _listenCard(Color ink) => Container(
        key: const Key('onboarding_listen_card'),
        padding: const EdgeInsets.all(22),
        decoration: _lessonCardDecoration(ink),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.onboardingClassicLineLabel,
              style: TextStyle(
                color: Colors.red[700],
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 18),
            Center(
              child: LtrSanctuary(
                child: OnboardingSpeakingText(
                  text: _passage,
                  activeIndex:
                      _speakingText == _passage ? _speakingCharacterIndex : null,
                  color: ink,
                  fontSize: 29,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              AppLocalizations.of(context)!.onboardingArtOfWarTranslation,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                height: 1.5,
                color: ink.withValues(alpha: .7),
              ),
            ),
            _sourceAttribution(ink),
          ],
        ),
      );

  Widget _noticeCard(Color ink) => Container(
        key: const Key('onboarding_notice_card'),
        padding: const EdgeInsets.all(22),
        decoration: _lessonCardDecoration(ink),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _noticePhrase(
              ink,
              chinese: '知彼知己者，',
              pinyin: 'zhī bǐ zhī jǐ zhě',
              meaning: AppLocalizations.of(context)!.onboardingNoticeMeaning,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Divider(height: 1, color: ink.withValues(alpha: .1)),
            ),
            _noticePhrase(
              ink,
              chinese: _shadowSentence,
              pinyin: _shadowPinyin,
              meaning: AppLocalizations.of(context)!.onboardingShadowMeaning,
              isPracticeTarget: true,
            ),
            _sourceAttribution(ink),
          ],
        ),
      );

  Widget _noticePhrase(
    Color ink, {
    required String chinese,
    required String pinyin,
    required String meaning,
    bool isPracticeTarget = false,
  }) =>
      Container(
        padding: isPracticeTarget ? const EdgeInsets.all(14) : EdgeInsets.zero,
        decoration: isPracticeTarget
            ? BoxDecoration(
                color: Colors.red.withValues(alpha: .06),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.red.withValues(alpha: .16)),
              )
            : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isPracticeTarget) ...[
              Text(
                AppLocalizations.of(context)!.onboardingPracticeThisLabel,
                style: TextStyle(
                  color: Colors.red[700],
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: .9,
                ),
              ),
              const SizedBox(height: 9),
            ],
            LtrSanctuary(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chinese,
                    style: TextStyle(
                      fontFamily: 'NotoSerifSC',
                      fontSize: 27,
                      height: 1.35,
                      color: ink,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    pinyin,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.red[700],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              meaning,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: ink.withValues(alpha: .68),
              ),
            ),
          ],
        ),
      );

  Widget _shadowCard(Color ink) => Container(
        key: const Key('onboarding_shadow_card'),
        padding: const EdgeInsets.all(22),
        decoration: _lessonCardDecoration(ink),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.onboardingFromArtOfWarLabel,
              style: TextStyle(
                color: Colors.red[700],
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
            LtrSanctuary(
              child: Column(
                children: [
                  OnboardingSpeakingText(
                    text: _shadowSentence,
                    activeIndex: _speakingText == _shadowSentence
                        ? _speakingCharacterIndex
                        : null,
                    color: ink,
                    fontSize: 38,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _shadowPinyin,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.red[700],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 7),
            Text(
              AppLocalizations.of(context)!.onboardingShadowMeaning,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: ink.withValues(alpha: .64)),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: _busy ? null : () => _play(_shadowSentence),
              icon: const Icon(Icons.volume_up_outlined),
              label: Text(AppLocalizations.of(context)!.hearItAgain),
              style: OutlinedButton.styleFrom(
                foregroundColor: ink,
                side: BorderSide(color: ink.withValues(alpha: .22)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              ),
            ),
          ],
        ),
      );

  Widget _toneResultsCard(Color ink) {
    if (_words.isEmpty) return const SizedBox.shrink();
    final selectedIndex = _selectedToneIndex.clamp(0, _words.length - 1);
    final selected = _words[selectedIndex];
    final expected = (selected['expectedTone'] as num?)?.toInt() ?? 0;
    final actual = (selected['actualTone'] as num?)?.toInt() ?? 0;
    final correct = expected == actual && expected != 0;
    final statusColor =
        correct ? Colors.green.shade700 : Colors.orange.shade800;

    return Container(
      key: const Key('onboarding_tone_results_card'),
      padding: const EdgeInsets.all(22),
      decoration: _lessonCardDecoration(ink),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!
                      .onboardingYourPronunciationLabel,
                  style: TextStyle(
                    color: Colors.red[700],
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Icon(Icons.touch_app_outlined,
                  size: 16, color: ink.withValues(alpha: .45)),
              const SizedBox(width: 5),
              Text(
                AppLocalizations.of(context)!.onboardingTapACharacter,
                style: TextStyle(
                  fontSize: 11,
                  color: ink.withValues(alpha: .52),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LtrSanctuary(
            child: Row(
              children: List.generate(_words.length, (index) {
                final word = _words[index];
                final wordExpected = (word['expectedTone'] as num?)?.toInt() ?? 0;
                final wordActual = (word['actualTone'] as num?)?.toInt() ?? 0;
                final wordCorrect =
                    wordExpected == wordActual && wordExpected != 0;
                final isSelected = index == selectedIndex;
                final wordColor =
                    wordCorrect ? Colors.green.shade700 : Colors.orange.shade800;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: index == _words.length - 1 ? 0 : 6,
                    ),
                    child: InkWell(
                      key: Key('tone_character_${word['word']}'),
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => setState(() => _selectedToneIndex = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(vertical: 11),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? wordColor.withValues(alpha: .1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? wordColor.withValues(alpha: .55)
                                : ink.withValues(alpha: .1),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              word['word'].toString(),
                              style: TextStyle(
                                fontFamily: 'NotoSerifSC',
                                fontSize: 29,
                                color: ink,
                              ),
                            ),
                            Text(
                              (word['pinyin'] ?? '').toString(),
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: 12,
                                color: ink.withValues(alpha: .62),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Icon(
                              wordCorrect
                                  ? Icons.check_circle
                                  : Icons.error_outline,
                              size: 17,
                              color: wordColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            key: const Key('onboarding_selected_tone_feedback'),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: .07),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.onboardingWordAndPinyin(
                        selected['word'].toString(),
                        (selected['pinyin'] ?? '').toString(),
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: ink,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      correct
                          ? AppLocalizations.of(context)!.onboardingToneMatched
                          : AppLocalizations.of(context)!.tryAgain,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.youActualTargetExpected(
                    _toneName(actual),
                    _toneName(expected),
                  ),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: ink.withValues(alpha: .7),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  (selected['feedback'] ?? '').toString(),
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: ink.withValues(alpha: .64),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () => ToneComparisonSheet.show(
                      context,
                      character: selected['word'].toString(),
                      pinyin: (selected['pinyin'] ?? '').toString(),
                      expectedTone: expected,
                      actualTone: actual,
                      feedback: (selected['feedback'] ?? '').toString(),
                    ),
                    icon: const Icon(Icons.graphic_eq, size: 18),
                    label: Text(
                        AppLocalizations.of(context)!.onboardingCompareTones),
                    style: TextButton.styleFrom(
                      foregroundColor: statusColor,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _toneName(int tone) => switch (tone) {
        1 => AppLocalizations.of(context)!.onboardingToneOneHigh,
        2 => AppLocalizations.of(context)!.onboardingToneTwoRising,
        3 => AppLocalizations.of(context)!.onboardingToneThreeDipping,
        4 => AppLocalizations.of(context)!.onboardingToneFourFalling,
        _ => AppLocalizations.of(context)!.onboardingToneNotDetected,
      };

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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.orange.withValues(alpha: 0.28)),
            ),
            child: Text(
              _message!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.orange.shade300
                    : Colors.deepOrange.shade800,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
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

class OnboardingSpeakingText extends StatelessWidget {
  const OnboardingSpeakingText({
    super.key,
    required this.text,
    required this.activeIndex,
    required this.color,
    required this.fontSize,
    this.height,
  });

  final String text;
  final int? activeIndex;
  final Color color;
  final double fontSize;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: text,
      child: ExcludeSemantics(
        child: LtrSanctuary(
          child: Text.rich(
            TextSpan(
              children: List.generate(text.length, (index) {
                final isActive = index == activeIndex;
                return WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: AnimatedContainer(
                    key: ValueKey('onboarding_spoken_character_$index'),
                    duration: const Duration(milliseconds: 120),
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.amber.withValues(alpha: 0.42)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: isActive
                          ? [
                              BoxShadow(
                                color: Colors.amber.withValues(alpha: 0.38),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      text[index],
                      style: TextStyle(
                        fontFamily: 'NotoSerifSC',
                        fontSize: fontSize,
                        height: height,
                        color: isActive ? Colors.deepOrange.shade700 : color,
                        fontWeight:
                            isActive ? FontWeight.w700 : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }),
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
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
