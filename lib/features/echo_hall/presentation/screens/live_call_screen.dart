import 'package:hanzi_master/l10n/app_localizations.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/scenario.dart';
import '../../../chat/domain/entities/chat_message.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/core/services/local_translation_service.dart';
import 'package:hanzi_master/shared/widgets/breathing_widget.dart';
import '../widgets/live_call_summary_screen.dart';
import '../widgets/tone_comparison_sheet.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/shared/widgets/tappable_hanzi_text.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:hanzi_master/core/providers/translation_language_provider.dart';
import 'package:hanzi_master/shared/widgets/ai_consent_sheet.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';

enum LiveCallState {
  connecting,
  idle,
  listening,
  thinking,
  speaking,
  error,
}

enum LiveCallStatusKey {
  ready,
  connectedSpeakNow,
  initErrorCheckPermissions,
  listening,
  microphoneErrorRetry,
  thinking,
  speaking,
  connectionInterruptedSpeakAgain,
  callPausedReviewingTones,
  pausedTakeABreak,
}

class LiveCallMessage {
  final String text;
  final String? pinyin;
  final String? translation;
  final ChatRole role;
  final Map<String, dynamic>? grade;
  final String? audioPath;
  final DateTime timestamp;

  LiveCallMessage({
    required this.text,
    this.pinyin,
    this.translation,
    required this.role,
    this.grade,
    this.audioPath,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  LiveCallMessage copyWith({
    String? text,
    String? pinyin,
    String? translation,
    ChatRole? role,
    Map<String, dynamic>? grade,
    String? audioPath,
    DateTime? timestamp,
  }) {
    return LiveCallMessage(
      text: text ?? this.text,
      pinyin: pinyin ?? this.pinyin,
      translation: translation ?? this.translation,
      role: role ?? this.role,
      grade: grade ?? this.grade,
      audioPath: audioPath ?? this.audioPath,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

class LiveCallScreen extends ConsumerStatefulWidget {
  final ConversationScenario scenario;
  final bool disableExternalServicesForTesting;
  final bool simulatePermissionDeniedForTesting;

  const LiveCallScreen({
    super.key,
    required this.scenario,
    this.disableExternalServicesForTesting = false,
    this.simulatePermissionDeniedForTesting = false,
  });

  @override
  ConsumerState<LiveCallScreen> createState() => _LiveCallScreenState();
}

class _LiveCallScreenState extends ConsumerState<LiveCallScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late AnimationController _analyzePulseController;
  bool _isMuted = false;
  bool _isSpeaker = true;
  bool _isEndingCall = false;
  bool _isAnalyzing = false;
  String _analyzeStatusText = '';
  Timer? _analyzeStatusTimer;
  int _subtitleMode =
      0; // 0=full (Chinese+Pinyin+English), 1=Chinese only, 2=hidden

  List<String> get _analyzeStatusMessages => [
        AppLocalizations.of(context)!.analyzing_your_pronunciation,
        AppLocalizations.of(context)!.reviewingYourTones,
        AppLocalizations.of(context)!.preparing_your_scholars_verdict,
      ];

  final AudioPlayer _voicePlayer = AudioPlayer();
  final AudioPlayer _bgPlayer = AudioPlayer();
  StreamSubscription? _playerCompleteSub;
  LiveCallState _callState = LiveCallState.idle;
  LiveCallStatusKey _statusKey = LiveCallStatusKey.ready;
  bool _hasError = false;

  final List<LiveCallMessage> _transcript = [];
  final ScrollController _scrollController = ScrollController();

  // Audio level for visual feedback
  double _audioLevel = 0.0;

  bool _isDisposed = false;
  bool _isStartingListening = false;
  bool _isHandlingTurn = false;
  Timer? _listeningWatchdog;
  Timer? _silenceDebounceTimer;
  StreamSubscription<Amplitude>? _amplitudeSub;
  bool _hasDetectedSpeech = false;
  final AudioRecorder _turnRecorder = AudioRecorder();
  String? _currentTurnAudioPath;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // The repeats are deferred to didChangeDependencies, which is the only
    // place the platform "Reduce Motion" setting can be read.
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: ZenMotion.natural),
    );

    _analyzePulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _initCall();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reduced motion: the call pulse rests at its natural (unscaled) size...
    MotionResolution.resolve(
      context,
      controller: _pulseController,
      loop: true,
      staticValue: 0.0,
    ).apply();
    // ...and the analysing sweep holds a single static frame.
    MotionResolution.resolve(
      context,
      controller: _analyzePulseController,
      loop: true,
      staticValue: 1.0,
    ).apply();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed &&
        _callState == LiveCallState.error &&
        _statusKey == LiveCallStatusKey.initErrorCheckPermissions) {
      _retryInit();
    }
  }

  void _retryInit() {
    if (_isDisposed || !mounted) return;
    _setCallState(LiveCallState.idle, LiveCallStatusKey.ready);
    _initCall();
  }

  void _setCallState(LiveCallState newState, LiveCallStatusKey statusKey) {
    if (_isDisposed || !mounted) return;
    setState(() {
      _callState = newState;
      _statusKey = statusKey;
      _hasError = newState == LiveCallState.error;
    });
  }

  String _getLocalizedCallStatus(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (_statusKey) {
      case LiveCallStatusKey.ready:
        return l10n.ready;
      case LiveCallStatusKey.connectedSpeakNow:
        return l10n.connectedSpeakNow;
      case LiveCallStatusKey.initErrorCheckPermissions:
        return l10n.initializationErrorCheckPermissions;
      case LiveCallStatusKey.listening:
        return l10n.listening;
      case LiveCallStatusKey.microphoneErrorRetry:
        return l10n.microphoneErrorTapToRetry;
      case LiveCallStatusKey.thinking:
        return l10n.thinking;
      case LiveCallStatusKey.speaking:
        return l10n.liveCallSpeaking;
      case LiveCallStatusKey.connectionInterruptedSpeakAgain:
        return l10n.connectionInterruptedPleaseSpeakAga;
      case LiveCallStatusKey.callPausedReviewingTones:
        return l10n.callPausedReviewingTones;
      case LiveCallStatusKey.pausedTakeABreak:
        return l10n.pausedTakeABreak;
    }
  }

  Future<void> _configureAudioSessionForCall({bool speaker = true}) async {
    try {
      await AudioPlayer.global.setAudioContext(AudioContext(
        iOS: AudioContextIOS(
          category: AVAudioSessionCategory.playAndRecord,
          options: speaker
              ? const {
                  AVAudioSessionOptions.defaultToSpeaker,
                  AVAudioSessionOptions.allowBluetooth,
                  AVAudioSessionOptions.mixWithOthers,
                }
              : const {
                  AVAudioSessionOptions.allowBluetooth,
                  AVAudioSessionOptions.mixWithOthers,
                },
        ),
        android: AudioContextAndroid(
          isSpeakerphoneOn: speaker,
          stayAwake: true,
          contentType: AndroidContentType.speech,
          usageType: AndroidUsageType.voiceCommunication,
          audioFocus: AndroidAudioFocus.gainTransient,
        ),
      ));
    } catch (e) {
      debugPrint("LiveCall: AudioContext setup error: $e");
    }
  }

  Future<void> _restoreAudioSession() async {
    try {
      await AudioPlayer.global.setAudioContext(AudioContext(
        iOS: AudioContextIOS(
          category: AVAudioSessionCategory.playback,
          options: const {AVAudioSessionOptions.mixWithOthers},
        ),
        android: const AudioContextAndroid(
          isSpeakerphoneOn: false,
          stayAwake: false,
          contentType: AndroidContentType.music,
          usageType: AndroidUsageType.media,
          audioFocus: AndroidAudioFocus.none,
        ),
      ));
    } catch (e) {
      debugPrint("LiveCall: AudioContext restore error: $e");
    }
  }

  Future<void> _initCall() async {
    if (widget.simulatePermissionDeniedForTesting) {
      _setCallState(
          LiveCallState.error, LiveCallStatusKey.initErrorCheckPermissions);
      return;
    }

    if (!widget.disableExternalServicesForTesting) {
      final consent = await AiConsentSheet.ensureConsent(context);
      if (!consent || !mounted) {
        if (mounted) Navigator.of(context).pop();
        return;
      }
    }

    try {
      if (!widget.disableExternalServicesForTesting) {
        await _configureAudioSessionForCall(speaker: _isSpeaker);
      }

      if (widget.scenario.backgroundAudioPath != null &&
          !widget.disableExternalServicesForTesting) {
        if (widget.scenario.backgroundAudioPath!.startsWith('/') ||
            widget.scenario.backgroundAudioPath!.contains(':\\')) {
          try {
            await _bgPlayer.setReleaseMode(ReleaseMode.loop);
            await _bgPlayer.setVolume(0.3); // Ambient volume
            await _bgPlayer
                .play(DeviceFileSource(widget.scenario.backgroundAudioPath!));
          } catch (e) {
            debugPrint("LiveCall: Background audio play error: $e");
          }
        }
      }

      // Proactive permission verification with system dialog request
      bool hasPermission = false;
      if (!widget.disableExternalServicesForTesting) {
        try {
          hasPermission = await _turnRecorder.hasPermission();
        } catch (_) {}

        if (!hasPermission) {
          try {
            final status = await Permission.microphone.request();
            hasPermission = status.isGranted;
          } catch (_) {}
        }
      }

      if (!hasPermission) {
        if (mounted && !_isDisposed) {
          _setCallState(
              LiveCallState.error, LiveCallStatusKey.initErrorCheckPermissions);
        }
        return;
      }

      _playerCompleteSub?.cancel();
      _playerCompleteSub = _voicePlayer.onPlayerComplete.listen((_) {
        if (mounted && !_isDisposed && !_isEndingCall && !_isMuted) {
          _isHandlingTurn = false;
          _startListening();
        }
      });

      _setCallState(LiveCallState.idle, LiveCallStatusKey.connectedSpeakNow);
      if (!widget.disableExternalServicesForTesting) {
        _startListening();
      }
    } catch (e) {
      debugPrint("LiveCall: Init failed: $e");
      _setCallState(
          LiveCallState.error, LiveCallStatusKey.initErrorCheckPermissions);
    }
  }

  Future<void> _toggleSpeaker() async {
    setState(() => _isSpeaker = !_isSpeaker);
    await _configureAudioSessionForCall(speaker: _isSpeaker);
  }

  Future<void> _startListening() async {
    if (_isDisposed ||
        !mounted ||
        _isMuted ||
        _isEndingCall ||
        _isHandlingTurn ||
        _isStartingListening ||
        _callState == LiveCallState.speaking ||
        _callState == LiveCallState.thinking) {
      return;
    }

    _isStartingListening = true;
    _listeningWatchdog?.cancel();
    _silenceDebounceTimer?.cancel();
    _amplitudeSub?.cancel();
    _hasDetectedSpeech = false;

    try {
      if (await _turnRecorder.isRecording()) {
        await _turnRecorder.stop();
      }

      final tempDir = await getTemporaryDirectory();
      final path =
          '${tempDir.path}/live_call_turn_${DateTime.now().millisecondsSinceEpoch}.wav';
      _currentTurnAudioPath = path;

      // Sole 16kHz PCM WAV Audio Capture for Azure STT and Pronunciation Assessment
      await _turnRecorder.start(
        const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          sampleRate: 16000,
          numChannels: 1,
        ),
        path: path,
      );

      _isStartingListening = false;
      _setCallState(LiveCallState.listening, LiveCallStatusKey.listening);

      // Monitor voice activity level without running any secondary on-device STT plugin
      _amplitudeSub = _turnRecorder
          .onAmplitudeChanged(const Duration(milliseconds: 60))
          .listen((amp) {
        if (!mounted ||
            _isDisposed ||
            _isHandlingTurn ||
            _callState != LiveCallState.listening) {
          return;
        }

        final normalized = ((amp.current + 50) / 45).clamp(0.0, 1.0);
        setState(() => _audioLevel = normalized);

        // Voice Activity Detection (VAD)
        if (amp.current > -38) {
          _hasDetectedSpeech = true;
          _silenceDebounceTimer?.cancel();
        } else if (_hasDetectedSpeech && amp.current <= -38) {
          if (_silenceDebounceTimer == null ||
              !_silenceDebounceTimer!.isActive) {
            _silenceDebounceTimer =
                Timer(const Duration(milliseconds: 1400), () {
              if (mounted &&
                  !_isDisposed &&
                  !_isHandlingTurn &&
                  _hasDetectedSpeech) {
                _finalizeTurnAndRespond();
              }
            });
          }
        }
      });
    } catch (e) {
      debugPrint("LiveCall: Could not start recorder: $e");
      _isStartingListening = false;
      _setCallState(LiveCallState.error, LiveCallStatusKey.microphoneErrorRetry);
    }
  }

  Future<void> _finalizeTurnAndRespond() async {
    if (_isDisposed || !mounted || _isHandlingTurn || _isEndingCall) return;
    _isHandlingTurn = true;
    _silenceDebounceTimer?.cancel();
    _amplitudeSub?.cancel();

    _setCallState(LiveCallState.thinking, LiveCallStatusKey.thinking);
    setState(() => _audioLevel = 0);

    String? audioPath = _currentTurnAudioPath;
    try {
      if (await _turnRecorder.isRecording()) {
        audioPath = await _turnRecorder.stop();
      }
    } catch (e) {
      debugPrint("Turn recorder stop error: $e");
    }

    if (audioPath == null) {
      _isHandlingTurn = false;
      _startListening();
      return;
    }

    final file = File(audioPath);
    if (!file.existsSync() || file.lengthSync() < 1000) {
      // Audio snippet too short (ambient tap / noise)
      _isHandlingTurn = false;
      if (mounted && !_isDisposed && !_isMuted) {
        _startListening();
      }
      return;
    }

    try {
      final bytes = await file.readAsBytes();
      final geminiService = ref.read(geminiServiceProvider);

      // 1. Dedicated Azure Speech-to-Text conversion (~300ms)
      final rawText = await geminiService.transcribeAudio(bytes);
      final text = rawText.replaceAll(RegExp(r'[。，！？,.!?]'), '').trim();

      if (text.isEmpty || !RegExp(r'[\u4e00-\u9fa5a-zA-Z]').hasMatch(text)) {
        // No intelligible speech detected (e.g. cough or ambient noise)
        _isHandlingTurn = false;
        if (mounted && !_isDisposed && !_isMuted) {
          _startListening();
        }
        return;
      }

      String? userPinyin;
      try {
        final p = PinyinHelper.getPinyinE(text,
            separator: ' ', format: PinyinFormat.WITH_TONE_MARK);
        if (p.isNotEmpty) userPinyin = p;
      } catch (_) {}

      String? userTranslation;
      try {
        userTranslation = await ref
            .read(localTranslationServiceProvider)
            .translate(text)
            .timeout(const Duration(milliseconds: 600));
      } catch (_) {}

      if (!mounted || _isDisposed) return;

      // 2. Immediately display user message in transcript (0ms UI lag)
      final messageIndex = _transcript.length;
      setState(() {
        _transcript.add(LiveCallMessage(
          text: text,
          pinyin: userPinyin,
          translation: userTranslation,
          role: ChatRole.user,
          grade: null, // Evaluating in background with Azure
          audioPath: audioPath,
        ));
      });
      _scrollToBottom();

      // 3. Concurrently trigger background Azure acoustic pronunciation assessment
      unawaited(_evaluateTurnWithAzure(
        messageIndex: messageIndex,
        audioPath: audioPath,
        fallbackText: text,
      ));

      // 4. Immediately trigger AI Master reply & voice synthesis
      await _handleUserInputAndRespondContinued(text);
    } catch (e) {
      debugPrint("Live call turn evaluation error: $e");
      _isHandlingTurn = false;
      if (mounted && !_isDisposed && !_isMuted) {
        _startListening();
      }
    }
  }

  Future<void> _evaluateTurnWithAzure({
    required int messageIndex,
    required String? audioPath,
    required String fallbackText,
  }) async {
    if (audioPath == null) return;
    final file = File(audioPath);
    if (!file.existsSync() || file.lengthSync() < 1000) return;

    try {
      final bytes = await file.readAsBytes();
      final geminiService = ref.read(geminiServiceProvider);
      final expectedPinyin = PinyinHelper.getPinyinE(fallbackText,
          separator: ' ', format: PinyinFormat.WITH_TONE_MARK);

      // Call genuine Azure Pronunciation Assessment REST API with reference text
      final grade = await geminiService.gradeAudio(
        bytes,
        fallbackText,
        expectedPinyin,
      );

      if (!mounted || _isDisposed) return;
      if (messageIndex >= 0 && messageIndex < _transcript.length) {
        final oldMsg = _transcript[messageIndex];

        setState(() {
          _transcript[messageIndex] = oldMsg.copyWith(
            grade: grade,
            audioPath: audioPath,
          );
        });
      }
    } catch (e) {
      debugPrint("Azure live call background evaluation error: $e");
    }
  }

  void _cycleSubtitleMode() {
    setState(() {
      _subtitleMode = (_subtitleMode + 1) % 3;
    });
  }

  Future<void> _handleUserInputAndRespondContinued(String text) async {
    _setCallState(LiveCallState.thinking, LiveCallStatusKey.thinking);

    try {
      final gemini = ref.read(geminiServiceProvider);
      final targetLang = ref.read(translationLanguageProvider);

      final scenario = widget.scenario;
      final hardenedSystemPrompt = '''${scenario.systemPrompt}

### MANDATORY LIVE ROLEPLAY RULES ###
- Role/Persona: "${scenario.personaName}"
- Scenario Topic: "${scenario.title}"
- Scenario Context: "${scenario.description}"
- Target HSK: HSK ${scenario.targetHskLevel}
- RULE 1: You are currently on a live spoken voice phone call with the user. You MUST STAY 100% in character as "${scenario.personaName}".
- RULE 2: NEVER break character, never act as a generic AI assistant or chatbot.
- RULE 3: Keep your responses conversational, natural, and concise (1-2 spoken sentences) so the audio call flows smoothly.

CRITICAL FORMAT REQUIREMENT: You MUST format EVERY response with exactly 3 parts separated by "|||":
Chinese Response|||Pinyin Response|||$targetLang Translation
CRITICAL TRANSLATION REQUIREMENT: The 3rd part MUST be translated directly into $targetLang (NOT English unless $targetLang is English).
Example: 你好！很高兴见到你。|||nǐ hǎo! hěn gāo xìng jiàn dào nǐ.|||[Natural translation directly in $targetLang]''';

      final messages = [
        {
          'role': 'system',
          'content': hardenedSystemPrompt,
        }
      ];

      for (var t in _transcript) {
        if (t.role == ChatRole.user) {
          messages.add({
            'role': 'user',
            'content': t.text,
          });
        } else {
          final pinyinStr = t.pinyin ??
              PinyinHelper.getPinyinE(t.text,
                  separator: ' ', format: PinyinFormat.WITH_TONE_MARK);
          final transStr = t.translation ?? '';
          messages.add({
            'role': 'assistant',
            'content': '${t.text}|||$pinyinStr|||$transStr',
          });
        }
      }

      final aiTextRaw = (await gemini.makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: messages,
      ))
          .trim();

      if (_isDisposed || !mounted) return;
      if (aiTextRaw.isEmpty) {
        throw StateError('The tutor returned an empty response');
      }

      String aiText = aiTextRaw;
      String? pinyin;
      String? translation;

      if (aiTextRaw.contains('|||')) {
        final parts = aiTextRaw.split('|||');
        if (parts.length >= 3) {
          aiText = parts[0].trim();
          pinyin = parts[1].trim();
          translation = parts[2].trim();
        } else if (parts.length == 2) {
          aiText = parts[0].trim();
          pinyin = parts[1].trim();
        }
      }

      // 🛡️ Fail-safe: If pinyin is ever omitted, compute tone-marked Pinyin so subtitles NEVER disappear!
      if (pinyin == null || pinyin.isEmpty) {
        try {
          final p = PinyinHelper.getPinyinE(aiText,
              separator: ' ', format: PinyinFormat.WITH_TONE_MARK);
          if (p.isNotEmpty) pinyin = p;
        } catch (_) {}
      }

      // 🛡️ Fail-safe: If translation is omitted, translate to target language
      if (translation == null || translation.isEmpty) {
        try {
          translation = await ref
              .read(localTranslationServiceProvider)
              .translate(aiText)
              .timeout(const Duration(milliseconds: 700));
        } catch (_) {}
      }

      // Store the exact text sent to TTS first. This guarantees that the user
      // can read everything the AI says, even if synthesis/playback fails.
      setState(() {
        _transcript.add(LiveCallMessage(
          text: aiText,
          pinyin: pinyin,
          translation: translation,
          role: ChatRole.scholar,
        ));
      });
      _scrollToBottom();

      _setCallState(LiveCallState.speaking, LiveCallStatusKey.speaking);

      await _configureAudioSessionForCall(speaker: _isSpeaker);
      final audioService = ref.read(audioServiceProvider);

      final played = await audioService.playSentence(aiText,
          voiceName: widget.scenario.voiceName);

      if (_isDisposed || !mounted) return;

      if (played) {
        final approxMs = math.max(1500, (aiText.length * 350));
        try {
          await audioService.onPlayerComplete.first
              .timeout(Duration(milliseconds: approxMs + 2000));
        } catch (_) {
          // Timeout reached
        }
        if (!_isDisposed && mounted) {
          unawaited(_finishAiTurn());
        }
      } else {
        await _finishAiTurn();
      }
    } catch (e) {
      debugPrint("LiveCall error: $e");
      if (mounted && !_isDisposed) {
        _isHandlingTurn = false;
        _setCallState(LiveCallState.idle,
            LiveCallStatusKey.connectionInterruptedSpeakAgain);
        if (!_isMuted && !_isEndingCall) {
          Future<void>.delayed(
              const Duration(milliseconds: 700), _startListening);
        }
      }
    }
  }

  Future<void> _finishAiTurn(
      {LiveCallStatusKey status = LiveCallStatusKey.connectedSpeakNow}) async {
    if (_isDisposed || !mounted || _isEndingCall) return;
    _isHandlingTurn = false;
    _setCallState(LiveCallState.idle, status);
    if (!_isMuted) await _startListening();
  }

  void _startAnalyzeStatusCycle() {
    _analyzeStatusTimer?.cancel();
    int index = 0;
    setState(() => _analyzeStatusText = _analyzeStatusMessages[0]);
    _analyzeStatusTimer =
        Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      if (!mounted || _isDisposed || !_isAnalyzing) {
        timer.cancel();
        return;
      }
      index = (index + 1) % _analyzeStatusMessages.length;
      setState(() => _analyzeStatusText = _analyzeStatusMessages[index]);
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: ZenMotion.quick,
          curve: ZenMotion.enter,
        );
      }
    });
  }

  Future<void> _handleCharacterTap({
    required String character,
    required String pinyin,
    required int expectedTone,
    required int actualTone,
    String? feedback,
  }) async {
    // 1. Put the call on a break / pause
    _silenceDebounceTimer?.cancel();
    _amplitudeSub?.cancel();
    _hasDetectedSpeech = false;
    _isStartingListening = false;
    try {
      if (await _turnRecorder.isRecording()) {
        await _turnRecorder.stop();
      }
    } catch (_) {}
    try {
      await _voicePlayer.pause();
    } catch (_) {}
    await ref.read(audioServiceProvider).stop();

    if (mounted) {
      setState(() => _audioLevel = 0);
      _setCallState(LiveCallState.idle, LiveCallStatusKey.callPausedReviewingTones);
    }

    if (!mounted) return;

    // 2. Open Tone Comparison Sheet and wait for user to finish reviewing
    await ToneComparisonSheet.show(
      context,
      character: character,
      pinyin: pinyin,
      expectedTone: expectedTone,
      actualTone: actualTone,
      feedback: feedback,
    );

    // 3. Resume the call seamlessly once sheet is closed
    if (mounted &&
        !_isDisposed &&
        !_isEndingCall &&
        !_isMuted &&
        !_isHandlingTurn &&
        _callState != LiveCallState.speaking) {
      _startListening();
    }
  }

  Future<void> _togglePause() async {
    setState(() {
      _isMuted = !_isMuted;
    });

    if (_isMuted) {
      _silenceDebounceTimer?.cancel();
      _amplitudeSub?.cancel();
      _hasDetectedSpeech = false;
      _isStartingListening = false;
      _setCallState(LiveCallState.idle, LiveCallStatusKey.pausedTakeABreak);
      try {
        if (await _turnRecorder.isRecording()) {
          await _turnRecorder.stop();
        }
      } catch (_) {}
      if (mounted) setState(() => _audioLevel = 0);
      try {
        await _voicePlayer.pause();
      } catch (e) {
        debugPrint('LiveCall: Could not pause tutor audio: $e');
      }
      try {
        await _bgPlayer.pause();
      } catch (e) {
        debugPrint('LiveCall: Could not pause background audio: $e');
      }
    } else {
      _setCallState(LiveCallState.idle, LiveCallStatusKey.connectedSpeakNow);
      try {
        await _voicePlayer.resume();
      } catch (e) {
        debugPrint('LiveCall: Could not resume tutor audio: $e');
      }
      try {
        await _bgPlayer.resume();
      } catch (e) {
        debugPrint('LiveCall: Could not resume background audio: $e');
      }
      _startListening();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _isDisposed = true;
    _playerCompleteSub?.cancel();
    _silenceDebounceTimer?.cancel();
    _amplitudeSub?.cancel();
    _listeningWatchdog?.cancel();
    _turnRecorder.dispose();
    _voicePlayer.stop();
    _voicePlayer.dispose();
    _bgPlayer.stop();
    _bgPlayer.dispose();
    _pulseController.dispose();
    _analyzePulseController.dispose();
    _analyzeStatusTimer?.cancel();
    _scrollController.dispose();
    _restoreAudioSession();
    super.dispose();
  }

  Future<void> _endCall() async {
    _isEndingCall = true;
    _silenceDebounceTimer?.cancel();
    _amplitudeSub?.cancel();
    _listeningWatchdog?.cancel();
    HapticsManager.heavy();
    try {
      if (await _turnRecorder.isRecording()) {
        await _turnRecorder.stop();
      }
    } catch (_) {}
    await _bgPlayer.stop();
    await _voicePlayer.stop();
    await _restoreAudioSession();

    if (!mounted) return;

    if (_transcript.isEmpty) {
      Navigator.pop(context);
      return;
    }

    // Show inline analyzing overlay instead of dialog
    setState(() => _isAnalyzing = true);
    _startAnalyzeStatusCycle();

    final l10n = AppLocalizations.of(context)!;
    final verdict = await _generateFinalVerdict(l10n);

    if (mounted) {
      _analyzeStatusTimer?.cancel();
      setState(() => _isAnalyzing = false);
      Navigator.pushReplacement(
        context,
        SwipeBackPageRoute(
          builder: (context) => LiveCallSummaryScreen(
            transcript: _transcript,
            scholarVerdict: verdict,
          ),
        ),
      );
    }
  }

  Future<String> _generateFinalVerdict(AppLocalizations l10n) async {
    try {
      final userMessages =
          _transcript.where((m) => m.role == ChatRole.user).toList();
      if (userMessages.isEmpty) {
        return l10n.liveCallSessionCompletedFallback;
      }

      // If user only spoke a single short word or 1 phrase
      if (userMessages.length == 1 &&
          userMessages.first.text.trim().length <= 4) {
        final word = userMessages.first.text.trim();
        return l10n.liveCallGoodStartPracticingWord(word);
      }

      // Calculate real Azure pronunciation performance
      int totalScore = 0;
      int scoredTurns = 0;
      final weakWords = <String>[];
      for (final msg in userMessages) {
        if (msg.grade != null && msg.grade!['score'] != null) {
          totalScore += (msg.grade!['score'] as num).toInt();
          scoredTurns++;
          final words = msg.grade!['words'] as List?;
          if (words != null) {
            for (final w in words) {
              if (w['isCorrect'] == false && w['word'] != null) {
                weakWords.add(w['word'].toString());
              }
            }
          }
        }
      }
      final avgAzureScore =
          scoredTurns > 0 ? (totalScore / scoredTurns).round() : null;
      final weakWordSummary =
          weakWords.isNotEmpty ? weakWords.take(4).toSet().join(", ") : null;

      final gemini = ref.read(geminiServiceProvider);
      final targetLang = ref.read(translationLanguageProvider);
      final transcriptStr = _transcript
          .map((m) =>
              "${m.role == ChatRole.user ? 'STUDENT' : 'COACH'}: ${m.text}")
          .join("\n");

      final systemPrompt = '''
You are an expert, professional Mandarin Chinese pronunciation coach and phonetic linguist in the SinoSpark app.
Provide a concise, professional linguistic evaluation (2-3 sentences, under 50 words) directly to the learner in $targetLang.

CRITICAL LANGUAGE REQUIREMENT:
You MUST write your ENTIRE feedback directly in $targetLang.

STRICT GUIDELINES:
1. Tone: Professional, pedagogical, constructive, and direct.
2. DO NOT use archaic metaphors, roleplay tropes, or flowery poetic language (NO "crane soaring", "gentle stream", "brush and ink", "my student", "honored disciple").
3. Give concrete, actionable feedback on their pronunciation, tone accuracy, and rhythm. If specific weak characters were provided, give practical advice on their tone contours (e.g., "Keep your 1st tone high and steady on '三' (sān)").
4. NEVER mention "transcript", "recordings", "audio", "AI", "models", "data", or system limitations.
''';

      final userPrompt = '''
Student's spoken dialogue:
$transcriptStr

${avgAzureScore != null ? 'Acoustic Pronunciation Accuracy: $avgAzureScore%' : ''}
${weakWordSummary != null ? 'Characters Needing Tone Polish: $weakWordSummary' : ''}

Provide your short, professional linguistic analysis directly to the student:
''';

      final response = await gemini.makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: [
          {'role': 'system', 'content': systemPrompt},
          {'role': 'user', 'content': userPrompt}
        ],
      );

      // 4th wall breach safety filter
      final lower = response.toLowerCase();
      if (lower.contains("audio") ||
          lower.contains("transcript") ||
          lower.contains("not enough information") ||
          lower.contains("as an ai") ||
          lower.contains("recording") ||
          lower.contains("intended")) {
        return l10n.liveCallSolidEffortFallback;
      }

      return response;
    } catch (e) {
      return l10n.liveCallGoodPracticeFallback;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0B1120),
      body: Stack(
        children: [
          Positioned.fill(
            child: widget.scenario.hasAvatar
                ? (widget.scenario.resolvedAvatarAssetPath.startsWith('/') ||
                        widget.scenario.resolvedAvatarAssetPath.contains(':\\')
                    ? Image.file(
                        File(widget.scenario.resolvedAvatarAssetPath),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildBlurredPlaceholderBackground(),
                      )
                    : Image.asset(
                        widget.scenario.resolvedAvatarAssetPath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildBlurredPlaceholderBackground(),
                      ))
                : _buildBlurredPlaceholderBackground(),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Container(color: Colors.black.withValues(alpha: 0.2)),
            ),
          ),
          SafeArea(
            child: AnimatedSwitcher(
              duration: ZenMotion.of(context, ZenMotion.entrance),
              child: _isAnalyzing
                  ? Container(
                      key: const ValueKey('analyzing'),
                      color: Colors.transparent,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedBuilder(
                              animation: _analyzePulseController,
                              builder: (context, child) {
                                final t = _analyzePulseController.value;
                                return Container(
                                  width: 160,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: SweepGradient(
                                      colors: [
                                        theme.colorScheme.primary
                                            .withValues(alpha: 0.0),
                                        theme.colorScheme.primary
                                            .withValues(alpha: 0.4),
                                        Colors.amber.withValues(alpha: 0.6),
                                        theme.colorScheme.primary
                                            .withValues(alpha: 0.4),
                                        theme.colorScheme.primary
                                            .withValues(alpha: 0.0),
                                      ],
                                      transform:
                                          GradientRotation(t * 2 * math.pi),
                                    ),
                                    border: Border.all(
                                      color:
                                          theme.colorScheme.primary.withValues(
                                        alpha: 0.5 +
                                            0.3 *
                                                (1 +
                                                    math.sin(t * 2 * math.pi)) /
                                                2,
                                      ),
                                      width: 2.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: theme.colorScheme.primary
                                            .withValues(alpha: 0.3),
                                        blurRadius: 30 + 10 * t,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.psychology_rounded,
                                      size: 56,
                                      color:
                                          Colors.white.withValues(alpha: 0.9),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 32),
                            AnimatedSwitcher(
                              duration: ZenMotion.of(context, ZenMotion.page),
                              child: Text(
                                _analyzeStatusText,
                                key: ValueKey(_analyzeStatusText),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.3,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  minHeight: 4,
                                  backgroundColor: Colors.white12,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    theme.colorScheme.primary
                                        .withValues(alpha: 0.7),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      key: const ValueKey('call_ui'),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Column(
                            children: [
                              Text(AppLocalizations.of(context)!.geminiLiveCall,
                                  style: theme.textTheme.labelMedium?.copyWith(
                                      color: Colors.white54,
                                      letterSpacing: 2.0)),
                              const SizedBox(height: 6),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 28.0),
                                child: Text(
                                  widget.scenario.title,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.titleLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      height: 1.25),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _getLocalizedCallStatus(context),
                                style: TextStyle(
                                  color: _callState == LiveCallState.error
                                      ? Colors.redAccent
                                      : _callState == LiveCallState.listening
                                          ? Colors.cyanAccent
                                          : _callState == LiveCallState.thinking
                                              ? Colors.amber
                                              : _callState ==
                                                      LiveCallState.speaking
                                                  ? theme.colorScheme.primary
                                                  : Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                              if (_hasError) ...[
                                if (_statusKey ==
                                    LiveCallStatusKey
                                        .initErrorCheckPermissions)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 32.0, right: 32.0),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .microphoneAccessWasNotGranted,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    spacing: 12,
                                    runSpacing: 10,
                                    children: [
                                      if (_statusKey ==
                                          LiveCallStatusKey
                                              .initErrorCheckPermissions)
                                        ElevatedButton.icon(
                                          key: const Key(
                                              'live_call_open_settings_button'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFFD4AF37),
                                            foregroundColor: Colors.black,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 12),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            elevation: 6,
                                          ),
                                          icon: const Icon(Icons.settings,
                                              size: 18),
                                          label: Text(
                                            AppLocalizations.of(context)!
                                                .settingsTitle,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          onPressed: () async {
                                            await openAppSettings();
                                          },
                                        ),
                                      ElevatedButton.icon(
                                        key: const Key(
                                            'live_call_retry_button'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white24,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 12),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          elevation: 4,
                                        ),
                                        icon: const Icon(Icons.refresh,
                                            size: 18),
                                        label: Text(
                                          AppLocalizations.of(context)!
                                              .tryAgain,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        onPressed: _retryInit,
                                      ),
                                      ElevatedButton.icon(
                                        key: const Key(
                                            'live_call_return_menu_button'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.redAccent,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 12),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          elevation: 6,
                                        ),
                                        icon: const Icon(Icons.arrow_back,
                                            size: 18),
                                        label: Text(
                                          AppLocalizations.of(context)!
                                              .returnToMenu,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                        const Spacer(),

                        // Transcript Overlay
                        if (!_hasError || _transcript.isNotEmpty) ...[
                          Container(
                            height: 290,
                            margin: const EdgeInsets.symmetric(horizontal: 18),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color:
                                  const Color(0xFF1E293B).withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.12),
                                width: 1.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.25),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ShaderMask(
                              shaderCallback: (rect) {
                                return const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black,
                                    Colors.black,
                                    Colors.transparent
                                  ],
                                  stops: [0.0, 0.08, 0.92, 1.0],
                                ).createShader(rect);
                              },
                              blendMode: BlendMode.dstIn,
                              child: ListView.builder(
                                controller: _scrollController,
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                itemCount: _transcript.length,
                                itemBuilder: (context, index) {
                                  final msg = _transcript[index];
                                  return _LiveTranscriptBubble(
                                    message: msg,
                                    theme: theme,
                                    subtitleMode: _subtitleMode,
                                    onCharacterTap: _handleCharacterTap,
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],

                        AnimatedBuilder(
                          animation: _pulseAnimation,
                          builder: (context, child) {
                            final bool isActive =
                                _callState == LiveCallState.listening ||
                                    _callState == LiveCallState.speaking;
                            final double baseScale = 1.0 + (_audioLevel * 0.15);
                            final double scale = isActive
                                ? baseScale * _pulseAnimation.value
                                : 1.0;
                            final Color glowColor =
                                _callState == LiveCallState.listening
                                    ? Colors.cyanAccent
                                    : _callState == LiveCallState.speaking
                                        ? theme.colorScheme.primary
                                        : _callState == LiveCallState.thinking
                                            ? Colors.amber
                                            : Colors.white24;
                            return BreathingWidget(
                              isBreathing: _callState == LiveCallState.thinking,
                              child: Transform.scale(
                                scale: scale,
                                child: Container(
                                  width: 140,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      if (isActive ||
                                          _callState == LiveCallState.thinking)
                                        BoxShadow(
                                            color: glowColor.withValues(
                                                alpha: 0.5),
                                            blurRadius: 40 + (_audioLevel * 20),
                                            spreadRadius: 5),
                                    ],
                                  ),
                                  child: ClipOval(
                                    child: widget.scenario.hasAvatar
                                        ? Image.asset(
                                            widget.scenario
                                                .resolvedAvatarAssetPath,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error,
                                                    stackTrace) =>
                                                _buildCenterPlaceholder(theme),
                                          )
                                        : _buildCenterPlaceholder(theme),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 48),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _CallControlButton(
                                icon: _isMuted ? Icons.play_arrow : Icons.pause,
                                label: _isMuted
                                    ? AppLocalizations.of(context)!.resume
                                    : AppLocalizations.of(context)!.pause,
                                isActive: _isMuted,
                                onTap: _togglePause,
                              ),
                              _CallControlButton(
                                icon: _subtitleMode == 2
                                    ? Icons.visibility_off
                                    : (_subtitleMode == 1
                                        ? Icons.remove_red_eye
                                        : Icons.subtitles),
                                label: _subtitleMode == 2
                                    ? AppLocalizations.of(context)!.hidden
                                    : (_subtitleMode == 1
                                        ? AppLocalizations.of(context)!.zhOnly
                                        : AppLocalizations.of(context)!.cc),
                                isActive: _subtitleMode != 0,
                                onTap: _cycleSubtitleMode,
                              ),
                              GestureDetector(
                                onTap: _endCall,
                                child: Container(
                                  width: 72,
                                  height: 72,
                                  decoration: const BoxDecoration(
                                      color: Colors.redAccent,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.redAccent,
                                            blurRadius: 20,
                                            offset: Offset(0, 4))
                                      ]),
                                  child: const Icon(Icons.call_end,
                                      color: Colors.white, size: 36),
                                ),
                              ),
                              _CallControlButton(
                                icon: _isSpeaker
                                    ? Icons.volume_up
                                    : Icons.volume_down,
                                label: AppLocalizations.of(context)!.speaker,
                                isActive: _isSpeaker,
                                onTap: _toggleSpeaker,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurredPlaceholderBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0, -0.2),
          radius: 1.35,
          colors: [
            Color(0xFF24344D), // Luminous slate blue
            Color(0xFF162238), // Rich indigo slate
            Color(0xFF0F172A), // Deep navy slate
            Color(0xFF090D16), // Dark carbon
          ],
          stops: [0.0, 0.35, 0.7, 1.0],
        ),
      ),
    );
  }

  Widget _buildCenterPlaceholder(ThemeData theme) {
    final personaName = widget.scenario.localizedPersonaName(
      Localizations.localeOf(context),
    );
    final char = personaName.isNotEmpty
        ? personaName[0]
        : (widget.scenario.title.isNotEmpty ? widget.scenario.title[0] : '悟');
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.18),
            Colors.white.withValues(alpha: 0.05),
            Colors.black.withValues(alpha: 0.4),
          ],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.25),
          width: 1.5,
        ),
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Center(
          child: Text(
            char,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 46,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class _LiveTranscriptBubble extends StatelessWidget {
  final LiveCallMessage message;
  final ThemeData theme;
  final int subtitleMode;
  final Future<void> Function({
    required String character,
    required String pinyin,
    required int expectedTone,
    required int actualTone,
    String? feedback,
  })? onCharacterTap;

  const _LiveTranscriptBubble({
    required this.message,
    required this.theme,
    this.subtitleMode = 0,
    this.onCharacterTap,
  });

  @override
  Widget build(BuildContext context) {
    // Mode 2 is AppLocalizations.of(context)!.hidden: completely hide all subtitles and transcripts (voice-only)
    if (subtitleMode == 2) {
      return const SizedBox.shrink();
    }

    final isUser = message.role == ChatRole.user;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.78,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isUser
                ? const Color(0xFF1D4ED8).withValues(alpha: 0.35)
                : const Color(0xFF1E293B).withValues(alpha: 0.7),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(14),
              topRight: const Radius.circular(14),
              bottomLeft: Radius.circular(isUser ? 14 : 2),
              bottomRight: Radius.circular(isUser ? 2 : 14),
            ),
            border: Border.all(
              color: isUser
                  ? const Color(0xFF60A5FA).withValues(alpha: 0.35)
                  : Colors.white.withValues(alpha: 0.15),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isUser && message.grade != null) ...[
                _buildGradedText(message.grade!['words'] ?? [], theme, context),
                const SizedBox(height: 4),
                Builder(builder: (context) {
                  final score = message.grade!['score'] ??
                      message.grade!['overallScore'] ??
                      0;
                  final isGood = score >= 80;
                  final isMedium = score >= 65 && score < 80;
                  final badgeColor = isGood
                      ? const Color(0xFF10B981)
                      : (isMedium
                          ? const Color(0xFFF59E0B)
                          : const Color(0xFFEF4444));
                  final l10n = AppLocalizations.of(context)!;
                  final label = isGood
                      ? "${l10n.toneAccurate} • $score%"
                      : (isMedium
                          ? "${l10n.toneNeedsWork} • $score%"
                          : "${l10n.pronunciation} • $score%");
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: badgeColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                      border:
                          Border.all(color: badgeColor.withValues(alpha: 0.4)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isGood
                              ? Icons.check_circle_outline
                              : Icons.info_outline,
                          size: 11,
                          color: badgeColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          label,
                          style: TextStyle(
                            color: badgeColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ] else if (isUser) ...[
                TappableMarkdownHanziText(
                  message.text,
                  quickLookPresentation: QuickLookPresentation.readingPopover,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 8,
                        height: 8,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        AppLocalizations.of(context)!.azureAssessment,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 9.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                TappableMarkdownHanziText(
                  message.text,
                  quickLookPresentation: QuickLookPresentation.readingPopover,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.5,
                    fontWeight: FontWeight.bold,
                    height: 1.35,
                  ),
                ),
              ],

              // Pinyin Subtitles (shown when not hidden, if message has pinyin and not already rendered in graded text)
              if ((subtitleMode == 0 || subtitleMode == 1) &&
                  (message.grade == null || !isUser) &&
                  message.pinyin != null &&
                  message.pinyin!.isNotEmpty) ...[
                const SizedBox(height: 3),
                Text(
                  message.pinyin!,
                  style: const TextStyle(
                    color: Color(0xFFE2E8F0),
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: isUser ? TextAlign.right : TextAlign.left,
                ),
              ],

              // English Translation Subtitles (shown in CC mode: subtitleMode == 0)
              if (subtitleMode == 0 &&
                  message.translation != null &&
                  message.translation!.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  message.translation!,
                  style: const TextStyle(
                    color: Color(0xFFCBD5E1),
                    fontSize: 12.5,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: isUser ? TextAlign.right : TextAlign.left,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradedText(
      List<dynamic> words, ThemeData theme, BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.end,
      spacing: 6,
      runSpacing: 4,
      children: words.map((w) {
        final bool correct = w['isCorrect'] ?? true;
        final bool partial = w['isPartial'] ?? false;
        final String feedback = w['feedback'] ?? '';
        final String word = w['word'] ?? '';
        final String pinyin = w['pinyin'] ?? '';
        final int expectedTone = w['expectedTone'] ?? 0;
        final int actualTone = w['actualTone'] ?? 0;

        final Color color = correct
            ? Colors.greenAccent
            : partial
                ? const Color(0xFFF59E0B)
                : Colors.redAccent;

        return GestureDetector(
          onTap: () {
            if (onCharacterTap != null) {
              onCharacterTap!(
                character: word,
                pinyin: pinyin,
                expectedTone: expectedTone,
                actualTone: actualTone,
                feedback: feedback,
              );
            } else {
              ToneComparisonSheet.show(
                context,
                character: word,
                pinyin: pinyin,
                expectedTone: expectedTone,
                actualTone: actualTone,
                feedback: feedback,
              );
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                pinyin,
                style:
                    theme.textTheme.labelSmall?.copyWith(color: Colors.white54),
              ),
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Text(
                    word,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (!correct)
                    Positioned(
                      top: 0,
                      right: -2,
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration:
                            BoxDecoration(color: color, shape: BoxShape.circle),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _CallControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _CallControlButton(
      {required this.icon,
      required this.label,
      required this.isActive,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: ZenMotion.of(context, ZenMotion.swap),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isActive
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon,
                color: isActive ? Colors.black : Colors.white, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        // Constrained to the button width: a longer translation (French
        // "Reprendre", German "Untertitel aus") wraps onto a second line
        // instead of widening and overflowing the whole control row.
        SizedBox(
          width: 64,
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
