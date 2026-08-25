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
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lpinyin/lpinyin.dart';

enum LiveCallState {
  connecting,
  idle,
  listening,
  thinking,
  speaking,
  error,
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

  const LiveCallScreen({super.key, required this.scenario});

  @override
  ConsumerState<LiveCallScreen> createState() => _LiveCallScreenState();
}

class _LiveCallScreenState extends ConsumerState<LiveCallScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late AnimationController _analyzePulseController;
  bool _isMuted = false;
  bool _isSpeaker = true;
  bool _isEndingCall = false;
  bool _isAnalyzing = false;
  String _analyzeStatusText = "Analyzing your pronunciation...";
  Timer? _analyzeStatusTimer;
  int _subtitleMode = 0; // 0=full (Chinese+Pinyin+English), 1=Chinese only, 2=hidden

  static const _analyzeStatusMessages = [
    "Analyzing your pronunciation...",
    "Reviewing your tones...",
    "Preparing your Scholar's Verdict...",
  ];

  final AudioPlayer _voicePlayer = AudioPlayer();
  final AudioPlayer _bgPlayer = AudioPlayer();
  LiveCallState _callState = LiveCallState.idle;
  String _callStatus = "Ready";
  bool _hasError = false;

  final List<LiveCallMessage> _transcript = [];
  final ScrollController _scrollController = ScrollController();

  // Audio level for visual feedback
  double _audioLevel = 0.0;

  bool _isDisposed = false;
  bool _isStartingListening = false;
  bool _isHandlingTurn = false;
  String _partialUserText = '';
  Timer? _listeningWatchdog;
  Timer? _silenceDebounceTimer;
  StreamSubscription<Amplitude>? _amplitudeSub;
  bool _hasDetectedSpeech = false;
  final AudioRecorder _turnRecorder = AudioRecorder();
  String? _currentTurnAudioPath;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _analyzePulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _initCall();
  }

  void _setCallState(LiveCallState newState, String statusText) {
    if (_isDisposed || !mounted) return;
    setState(() {
      _callState = newState;
      _callStatus = statusText;
      _hasError = newState == LiveCallState.error;
    });
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
    try {
      await _configureAudioSessionForCall(speaker: _isSpeaker);

      if (widget.scenario.backgroundAudioPath != null) {
        if (widget.scenario.backgroundAudioPath!.startsWith('/') ||
            widget.scenario.backgroundAudioPath!.contains(':\\')) {
          await _bgPlayer.setReleaseMode(ReleaseMode.loop);
          await _bgPlayer.setVolume(0.3); // Ambient volume
          await _bgPlayer
              .play(DeviceFileSource(widget.scenario.backgroundAudioPath!));
        }
      }

      final hasPermission = await _turnRecorder.hasPermission();
      if (!hasPermission) {
        throw StateError('Microphone permission required');
      }

      _voicePlayer.onPlayerComplete.listen((_) {
        if (mounted && !_isDisposed && !_isEndingCall && !_isMuted) {
          _isHandlingTurn = false;
          _startListening();
        }
      });

      _setCallState(LiveCallState.idle, "Connected! Speak now.");
      _startListening();
    } catch (e) {
      debugPrint("LiveCall: Init failed: $e");
      _setCallState(
          LiveCallState.error, "Initialization error. Check permissions.");
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
      final path = '${tempDir.path}/live_call_turn_${DateTime.now().millisecondsSinceEpoch}.wav';
      _currentTurnAudioPath = path;

      // Pure 16kHz PCM WAV Audio Capture for direct Azure Speech & Pronunciation Assessment
      await _turnRecorder.start(
        const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          sampleRate: 16000,
          numChannels: 1,
        ),
        path: path,
      );

      _isStartingListening = false;
      _setCallState(LiveCallState.listening, "Listening...");

      // Monitor voice activity level without running any secondary on-device STT plugin
      _amplitudeSub = _turnRecorder.onAmplitudeChanged(const Duration(milliseconds: 60)).listen((amp) {
        if (!mounted || _isDisposed || _isHandlingTurn || _callState != LiveCallState.listening) return;
        
        final normalized = ((amp.current + 50) / 45).clamp(0.0, 1.0);
        setState(() => _audioLevel = normalized);

        // Voice Activity Detection (VAD)
        if (amp.current > -38) {
          _hasDetectedSpeech = true;
          _silenceDebounceTimer?.cancel();
        } else if (_hasDetectedSpeech && amp.current <= -38) {
          if (_silenceDebounceTimer == null || !_silenceDebounceTimer!.isActive) {
            _silenceDebounceTimer = Timer(const Duration(milliseconds: 1400), () {
              if (mounted && !_isDisposed && !_isHandlingTurn && _hasDetectedSpeech) {
                _finalizeTurnAndRespond();
              }
            });
          }
        }
      });
    } catch (e) {
      debugPrint("LiveCall: Could not start recorder: $e");
      _isStartingListening = false;
      _setCallState(LiveCallState.error, "Microphone error. Tap to retry.");
    }
  }

  Future<void> _finalizeTurnAndRespond() async {
    if (_isDisposed || !mounted || _isHandlingTurn || _isEndingCall) return;
    _isHandlingTurn = true;
    _silenceDebounceTimer?.cancel();
    _amplitudeSub?.cancel();

    _setCallState(LiveCallState.thinking, "Analyzing Voice & Tone...");
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
    if (!file.existsSync() || file.lengthSync() < 2000) {
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

      // Single Unified Call to Azure Cognitive Services Pronunciation & Speech Assessment
      final grade = await geminiService.gradeAudio(bytes, '', '');

      final text = (grade['text'] as String?)?.trim() ?? '';
      if (text.isEmpty || !RegExp(r'[\u4e00-\u9fa5a-zA-Z]').hasMatch(text)) {
        // No intelligible Mandarin speech recognized
        _isHandlingTurn = false;
        if (mounted && !_isDisposed && !_isMuted) {
          _startListening();
        }
        return;
      }

      String? userPinyin;
      try {
        final p = PinyinHelper.getPinyinE(text, separator: ' ', format: PinyinFormat.WITH_TONE_MARK);
        if (p.isNotEmpty) userPinyin = p;
      } catch (_) {}

      String? userTranslation;
      try {
        userTranslation = await ref.read(localTranslationServiceProvider).translate(text).timeout(const Duration(milliseconds: 600));
      } catch (_) {}

      if (!mounted || _isDisposed) return;
      setState(() {
        _transcript.add(LiveCallMessage(
          text: text,
          pinyin: userPinyin,
          translation: userTranslation,
          role: ChatRole.user,
          grade: grade,
          audioPath: audioPath,
        ));
      });
      _scrollToBottom();

      // Trigger AI tutor speech and voice synthesis
      await _handleUserInputAndRespondContinued(text);
    } catch (e) {
      debugPrint("Live call Azure turn evaluation error: $e");
      _isHandlingTurn = false;
      if (mounted && !_isDisposed && !_isMuted) {
        _startListening();
      }
    }
  }

  void _cycleSubtitleMode() {
    setState(() {
      _subtitleMode = (_subtitleMode + 1) % 3;
    });
  }

  Future<void> _handleUserInputAndRespondContinued(String text) async {

    _setCallState(LiveCallState.thinking, "Thinking...");

    try {
      final gemini = ref.read(geminiServiceProvider);

      // Build history for Gemini
      final messages = [
        {
          'role': 'system',
          'content':
              '${widget.scenario.systemPrompt}\n\nKeep your responses concise and conversational (1 to 2 sentences). Use natural spoken Mandarin suitable for your role.\n\nScenario context: ${widget.scenario.description}\n\nCRITICAL FORMAT REQUIREMENT: You MUST format EVERY response with exactly 3 parts separated by "|||":\nChinese Response|||Pinyin Response|||English Translation\nExample: 你好！很高兴见到你。|||nǐ hǎo! hěn gāo xìng jiàn dào nǐ.|||Hello! Very nice to meet you.'
        }
      ];

      for (var t in _transcript) {
        if (t.role == ChatRole.user) {
          messages.add({
            'role': 'user',
            'content': t.text,
          });
        } else {
          final pinyinStr = t.pinyin ?? PinyinHelper.getPinyinE(t.text, separator: ' ', format: PinyinFormat.WITH_TONE_MARK);
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
      )).trim();

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
          final p = PinyinHelper.getPinyinE(aiText, separator: ' ', format: PinyinFormat.WITH_TONE_MARK);
          if (p.isNotEmpty) pinyin = p;
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

      _setCallState(LiveCallState.speaking, "Speaking...");

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
        _setCallState(
            LiveCallState.idle, "Connection interrupted. Please speak again.");
        if (!_isMuted && !_isEndingCall) {
          Future<void>.delayed(
              const Duration(milliseconds: 700), _startListening);
        }
      }
    }
  }

  Future<void> _finishAiTurn({String status = "Connected! Speak now."}) async {
    if (_isDisposed || !mounted || _isEndingCall) return;
    _isHandlingTurn = false;
    _setCallState(LiveCallState.idle, status);
    if (!_isMuted) await _startListening();
  }

  void _startAnalyzeStatusCycle() {
    _analyzeStatusTimer?.cancel();
    int index = 0;
    setState(() => _analyzeStatusText = _analyzeStatusMessages[0]);
    _analyzeStatusTimer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
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
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
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
      setState(() {
        _partialUserText = '';
        _audioLevel = 0;
      });
      _setCallState(LiveCallState.idle, "Call Paused (Reviewing Tones)");
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
    if (mounted && !_isDisposed && !_isEndingCall && !_isMuted && !_isHandlingTurn && _callState != LiveCallState.speaking) {
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
      _setCallState(LiveCallState.idle, "Paused - Take a break");
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
      _setCallState(LiveCallState.idle, "Connected! Speak now.");
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
    _isDisposed = true;
    _silenceDebounceTimer?.cancel();
    _amplitudeSub?.cancel();
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

    final verdict = await _generateFinalVerdict();

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

  Future<String> _generateFinalVerdict() async {
    try {
      final userMessages = _transcript.where((m) => m.role == ChatRole.user).toList();
      if (userMessages.isEmpty) {
        return "A brief encounter to warm the brush. In our next dialogue, speak bold and complete sentences to fully awaken your Mandarin fluency.";
      }

      // If user only spoke a single short word or 1 phrase
      if (userMessages.length == 1 && userMessages.first.text.trim().length <= 4) {
        final word = userMessages.first.text.trim();
        return "A crisp first step with '$word'. As you practice further, expand your responses into complete phrases to let your tones flow like running ink.";
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
      final avgAzureScore = scoredTurns > 0 ? (totalScore / scoredTurns).round() : null;
      final weakWordSummary = weakWords.isNotEmpty ? weakWords.take(4).toSet().join(", ") : null;

      final gemini = ref.read(geminiServiceProvider);
      final transcriptStr = _transcript
          .map((m) => "${m.role == ChatRole.user ? 'STUDENT' : 'MASTER'}: ${m.text}")
          .join("\n");

      const systemPrompt = '''
You are the venerable Chinese Language Master in the Hanzi Master app. You are giving your final "Scholar's Verdict" critique directly to your student.
STRICT MANDATE:
1. ALWAYS stay 100% in character as a wise, encouraging Chinese Calligraphy & Language Master. Speak directly to the student ("You articulated...", "Your rhythm...", "Let your tones...").
2. ABSOLUTELY NEVER mention "transcript", "recordings", "audio", "prompts", "AI", "models", "data", "not enough information", or any technical/system limitations.
3. NEVER complain about the session length or format.
4. Give a warm, inspiring, poetic critique (under 60 words) reflecting their rhythm, tone clarity, and one practical tip to polish their spoken Mandarin.
''';

      final userPrompt = '''
Student's spoken dialogue:
$transcriptStr

${avgAzureScore != null ? 'Acoustic Pronunciation Accuracy: $avgAzureScore%' : ''}
${weakWordSummary != null ? 'Characters Needing Tone Polish: $weakWordSummary' : ''}

Provide your short, inspiring Scholar's Verdict directly to the student:
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
        return "A commendable dialogue. Continue speaking with confidence and focus on sustaining high, steady pitch on 1st tones and decisive drops on 4th tones.";
      }

      return response;
    } catch (e) {
      return "Excellent effort. Continue daily practice to let your tones flow with precision.";
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: (widget.scenario.avatarAssetPath == 'none' ||
                    widget.scenario.avatarAssetPath.isEmpty)
                ? Container(color: Colors.black87)
                : widget.scenario.avatarAssetPath.startsWith('/') ||
                        widget.scenario.avatarAssetPath.contains(':\\')
                    ? Image.file(
                        File(widget.scenario.avatarAssetPath),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(color: Colors.black87),
                      )
                    : Image.asset(
                        widget.scenario.avatarAssetPath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(color: Colors.black87),
                      ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(color: Colors.black.withValues(alpha: 0.7)),
            ),
          ),
          SafeArea(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
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
                                        theme.colorScheme.primary.withValues(alpha: 0.0),
                                        theme.colorScheme.primary.withValues(alpha: 0.4),
                                        Colors.amber.withValues(alpha: 0.6),
                                        theme.colorScheme.primary.withValues(alpha: 0.4),
                                        theme.colorScheme.primary.withValues(alpha: 0.0),
                                      ],
                                      transform: GradientRotation(t * 2 * math.pi),
                                    ),
                                    border: Border.all(
                                      color: theme.colorScheme.primary.withValues(
                                        alpha: 0.5 + 0.3 * (1 + math.sin(t * 2 * math.pi)) / 2,
                                      ),
                                      width: 2.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: theme.colorScheme.primary.withValues(alpha: 0.3),
                                        blurRadius: 30 + 10 * t,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: const SizedBox.shrink(),
                                );
                              },
                            ),
                            const SizedBox(height: 32),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 400),
                              child: Text(
                                _analyzeStatusText,
                                key: ValueKey(_analyzeStatusText),
                                textAlign: TextAlign.center,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.85),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  minHeight: 4,
                                  backgroundColor: Colors.white12,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    theme.colorScheme.primary.withValues(alpha: 0.7),
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
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: [
                          Text(AppLocalizations.of(context)!.geminiLiveCall,
                              style: theme.textTheme.labelMedium?.copyWith(
                                  color: Colors.white54, letterSpacing: 2.0)),
                          const SizedBox(height: 8),
                          Text(widget.scenario.title,
                              style: theme.textTheme.headlineMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(
                            _callStatus,
                            style: TextStyle(
                              color: _callState == LiveCallState.error
                                  ? Colors.redAccent
                                  : _callState == LiveCallState.listening
                                      ? Colors.cyanAccent
                                      : _callState == LiveCallState.thinking
                                          ? Colors.amber
                                          : _callState == LiveCallState.speaking
                                              ? theme.colorScheme.primary
                                              : Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          if (_hasError)
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  elevation: 8,
                                ),
                                icon: const Icon(Icons.arrow_back, size: 20),
                                label: Text(
                                  AppLocalizations.of(context)!.returnToMenu,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // Transcript Overlay
                    Container(
                      height: 300,
                      margin: const EdgeInsets.symmetric(horizontal: 24),
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
                            stops: [0.0, 0.1, 0.9, 1.0],
                          ).createShader(rect);
                        },
                        blendMode: BlendMode.dstIn,
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          itemCount: _transcript.length +
                              (_partialUserText.isNotEmpty ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == _transcript.length) {
                              return _LivePartialTranscriptBubble(
                                  text: _partialUserText,
                                  theme: theme,
                                  subtitleMode: _subtitleMode);
                            }
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

                    AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        final bool isActive =
                            _callState == LiveCallState.listening ||
                                _callState == LiveCallState.speaking;
                        final double baseScale = 1.0 + (_audioLevel * 0.15);
                        final double scale =
                            isActive ? baseScale * _pulseAnimation.value : 1.0;
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
                                        color: glowColor.withValues(alpha: 0.5),
                                        blurRadius: 40 + (_audioLevel * 20),
                                        spreadRadius: 5),
                                ],
                              ),
                              child: ClipOval(
                                child: (widget.scenario.avatarAssetPath ==
                                            'none' ||
                                        widget.scenario.avatarAssetPath.isEmpty)
                                    ? Container(
                                        color: theme.colorScheme.primary,
                                        child: Center(
                                          child: Text(
                                            widget.scenario.personaName.isNotEmpty
                                                ? widget.scenario.personaName[0]
                                                    .toUpperCase()
                                                : '?',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 60,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    : Image.asset(
                                        widget.scenario.avatarAssetPath,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error,
                                                stackTrace) =>
                                            Container(
                                                color: Colors.indigo.shade900),
                                      ),
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
                            label: _isMuted ? "Resume" : "Pause",
                            isActive: _isMuted,
                            onTap: _togglePause,
                          ),
                          _CallControlButton(
                            icon: _subtitleMode == 2 ? Icons.visibility_off : (_subtitleMode == 1 ? Icons.remove_red_eye : Icons.subtitles),
                            label: _subtitleMode == 2 ? "Hidden" : (_subtitleMode == 1 ? "ZH Only" : "CC"),
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
                            label: "Speaker",
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
}

class _LivePartialTranscriptBubble extends StatelessWidget {
  final String text;
  final ThemeData theme;
  final int subtitleMode;

  const _LivePartialTranscriptBubble({
    required this.text, 
    required this.theme,
    this.subtitleMode = 0,
  });

  @override
  Widget build(BuildContext context) {
    if (subtitleMode == 2 || text.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          text,
          textAlign: TextAlign.right,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.white54,
            fontStyle: FontStyle.italic,
            height: 1.4,
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
    // Mode 2 is "Hidden": completely hide all subtitles and transcripts (voice-only)
    if (subtitleMode == 2) {
      return const SizedBox.shrink();
    }

    final isUser = message.role == ChatRole.user;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (isUser && message.grade != null) ...[
            _buildGradedText(message.grade!['words'] ?? [], theme, context),
            const SizedBox(height: 4),
            Builder(builder: (context) {
              final score = message.grade!['score'] ?? message.grade!['overallScore'] ?? 0;
              final isGood = score >= 80;
              final isMedium = score >= 65 && score < 80;
              final badgeColor = isGood
                  ? const Color(0xFF10B981)
                  : (isMedium ? const Color(0xFFF59E0B) : const Color(0xFFEF4444));
              final label = isGood
                  ? "Tone Accurate • $score%"
                  : (isMedium ? "Tone Needs Work • $score%" : "Pronunciation • $score%");
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: badgeColor.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isGood ? Icons.check_circle_outline : Icons.info_outline,
                      size: 11,
                      color: badgeColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      label,
                      style: theme.textTheme.labelSmall?.copyWith(
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
              textAlign: TextAlign.right,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.white70,
                fontWeight: FontWeight.normal,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 9,
                    height: 9,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Azure Acoustic Assessment...",
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.white54,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            TappableMarkdownHanziText(
              message.text,
              textAlign: TextAlign.left,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.primary.withValues(alpha: 0.9),
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
          ],
          
          // Pinyin Subtitles (shown when not hidden, if message has pinyin and not already rendered in graded text)
          if ((subtitleMode == 0 || subtitleMode == 1) &&
              (message.grade == null || !isUser) &&
              message.pinyin != null &&
              message.pinyin!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              message.pinyin!,
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
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
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.white38,
                fontStyle: FontStyle.italic,
              ),
              textAlign: isUser ? TextAlign.right : TextAlign.left,
            ),
          ],
        ],
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
            duration: const Duration(milliseconds: 200),
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
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}