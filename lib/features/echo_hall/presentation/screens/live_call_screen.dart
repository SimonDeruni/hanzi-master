import 'package:hanzi_master/l10n/app_localizations.dart';
import 'dart:ui' as ui;
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart' as fs;
import '../../domain/entities/scenario.dart';
import '../../../chat/domain/entities/chat_message.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/core/services/speech_service.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import '../widgets/live_call_summary_screen.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/shared/widgets/tappable_hanzi_text.dart';

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
  final DateTime timestamp;

  LiveCallMessage({
    required this.text,
    this.pinyin,
    this.translation,
    required this.role,
    this.grade,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  LiveCallMessage copyWith({Map<String, dynamic>? grade, String? text, String? pinyin, String? translation}) {
    return LiveCallMessage(
      text: text ?? this.text,
      pinyin: pinyin ?? this.pinyin,
      translation: translation ?? this.translation,
      role: role,
      grade: grade ?? this.grade,
      timestamp: timestamp,
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
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isMuted = false;
  bool _isSpeaker = true;
  bool _isEndingCall = false;

  final fs.FlutterSoundPlayer _player = fs.FlutterSoundPlayer();
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
  int _recognitionSession = 0;
  String _partialUserText = '';
  Timer? _listeningWatchdog;

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

  Future<void> _initCall() async {
    try {
      await _player.openPlayer();

      if (widget.scenario.backgroundAudioPath != null) {
        if (widget.scenario.backgroundAudioPath!.startsWith('/') ||
            widget.scenario.backgroundAudioPath!.contains(':\\\\')) {
          await _bgPlayer.setReleaseMode(ReleaseMode.loop);
          await _bgPlayer.setVolume(0.3); // Ambient volume
          await _bgPlayer
              .play(DeviceFileSource(widget.scenario.backgroundAudioPath!));
        }
      }

      final speechService = ref.read(speechServiceProvider);
      final initialized = await speechService.init();
      if (!initialized) {
        throw StateError('Speech recognition is unavailable');
      }

      _setCallState(LiveCallState.idle, "Connected! Speak now.");
      _startListening();
    } catch (e) {
      debugPrint("LiveCall: Init failed: $e");
      _setCallState(
          LiveCallState.error, "Initialization error. Check permissions.");
    }
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

    final speechService = ref.read(speechServiceProvider);
    if (speechService.isListening) return;

    _isStartingListening = true;
    final session = ++_recognitionSession;
    _listeningWatchdog?.cancel();
    _setCallState(LiveCallState.idle, "Starting microphone...");

    final started = await speechService.startListening(
      pauseFor: const Duration(milliseconds: 1500),
      onPartialResult: (text) {
        if (!_isCurrentRecognitionSession(session) || _isHandlingTurn) return;
        setState(() => _partialUserText = text);
        _scrollToBottom();
      },
      onResult: (text) {
        if (!_isCurrentRecognitionSession(session) || _isHandlingTurn) return;
        final finalText = text.trim();
        if (finalText.isEmpty) {
          _recoverFromRecognitionEnd(session);
          return;
        }
        _isHandlingTurn = true;
        unawaited(_handleUserInputAndRespond(finalText));
      },
      onStatus: (status) {
        if (!_isCurrentRecognitionSession(session) || _isHandlingTurn) return;
        if (status == 'done' || status == 'notListening') {
          _recoverFromRecognitionEnd(session);
        }
      },
      onError: (message, permanent) {
        if (!_isCurrentRecognitionSession(session)) return;
        _handleRecognitionError(message, permanent);
      },
      onSoundLevel: (level) {
        if (_isCurrentRecognitionSession(session)) {
          // Native implementations commonly report roughly -50 to 50.
          setState(() => _audioLevel = ((level + 50) / 100).clamp(0.0, 1.0));
        }
      },
    );

    if (!_isCurrentRecognitionSession(session)) return;
    _isStartingListening = false;

    if (!started) {
      _handleRecognitionError('Could not start speech recognition.', false);
      return;
    }

    _setCallState(LiveCallState.listening, "Listening...");
    _listeningWatchdog = Timer(const Duration(seconds: 32), () {
      if (_isCurrentRecognitionSession(session) && !_isHandlingTurn) {
        unawaited(speechService.cancelListening());
        _recoverFromRecognitionEnd(session);
      }
    });
  }

  bool _isCurrentRecognitionSession(int session) =>
      mounted &&
      !_isDisposed &&
      !_isEndingCall &&
      session == _recognitionSession;

  void _recoverFromRecognitionEnd(int session) {
    if (!_isCurrentRecognitionSession(session) || _isHandlingTurn || _isMuted) {
      return;
    }
    _recognitionSession++;
    _isStartingListening = false;
    _listeningWatchdog?.cancel();
    if (mounted) {
      setState(() {
        _partialUserText = '';
        _audioLevel = 0;
      });
    }
    _setCallState(LiveCallState.idle, "I didn't hear that. Listening again...");
    Future<void>.delayed(const Duration(milliseconds: 500), _startListening);
  }

  void _handleRecognitionError(String message, bool permanent) {
    if (_isDisposed || !mounted || _isEndingCall) return;
    debugPrint('LiveCall speech recognition error: $message');
    _recognitionSession++;
    _isStartingListening = false;
    _listeningWatchdog?.cancel();
    setState(() {
      _partialUserText = '';
      _audioLevel = 0;
    });
    if (permanent || message == 'speech_recognition_unavailable') {
      _setCallState(
          LiveCallState.error, "Microphone or speech recognition unavailable.");
    } else if (!_isMuted) {
      _setCallState(LiveCallState.idle, "Microphone interrupted. Retrying...");
      Future<void>.delayed(const Duration(milliseconds: 700), _startListening);
    }
  }

  Future<void> _handleUserInputAndRespond(String text) async {
    if (_isDisposed || !mounted || _isEndingCall) {
      _isHandlingTurn = false;
      return;
    }

    _recognitionSession++;
    _listeningWatchdog?.cancel();

    // Stop listening while thinking/speaking
    await ref.read(speechServiceProvider).stopListening();

    if (_isDisposed || !mounted || _isEndingCall) return;
    setState(() {
      _partialUserText = '';
      _audioLevel = 0;
      _transcript.add(LiveCallMessage(text: text, role: ChatRole.user));
    });
    _scrollToBottom();

    // Async grade the user audio
    _triggerGradingForLastUserTurn();

    _setCallState(LiveCallState.thinking, "Thinking...");

    try {
      final gemini = ref.read(geminiServiceProvider);

      // Build history for Gemini
      final messages = [
        {
          'role': 'system',
          'content':
              'You are a professional Mandarin tutor named Master Lin. You are patient, wise, and encouraging. Respond naturally in spoken Mandarin. Keep your responses short (under 3 sentences). Scenario: ${widget.scenario.description}\nIMPORTANT: You MUST format your response exactly as follows: Chinese Text|||Pinyin|||English Translation'
        }
      ];

      for (var t in _transcript) {
        messages.add({
          'role': t.role == ChatRole.user ? 'user' : 'assistant',
          'content': t.text // only send the Chinese part to maintain history context
        });
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
        aiText = parts[0].trim();
        if (parts.length > 1) pinyin = parts[1].trim();
        if (parts.length > 2) translation = parts[2].trim();
      }

      // Store the exact text sent to TTS first. This guarantees that the user
      // can read everything the AI says, even if synthesis/playback fails.
      setState(() {
        _transcript.add(LiveCallMessage(
          text: aiText, 
          pinyin: pinyin, 
          translation: translation, 
          role: ChatRole.scholar
        ));
      });
      _scrollToBottom();

      _setCallState(LiveCallState.speaking, "Speaking...");

      final audioService = ref.read(audioServiceProvider);
      final audioBytes = await audioService.getSentenceAudioBytes(aiText,
          voiceName: widget.scenario.voiceName);

      if (_isDisposed || !mounted) return;

      if (audioBytes != null) {
        await _player.startPlayer(
            fromDataBuffer: audioBytes,
            codec: fs.Codec.pcm16WAV,
            whenFinished: () {
              unawaited(_finishAiTurn());
            });
      } else {
        await _finishAiTurn(
            status: "Audio unavailable. You can read the reply above.");
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

  Future<void> _triggerGradingForLastUserTurn() async {
    final lastUserIdx =
        _transcript.lastIndexWhere((m) => m.role == ChatRole.user);
    if (lastUserIdx == -1) return;

    try {
      // For the STT pipeline, we skip Azure audio grading because we don't capture the audio bytes easily from speech_to_text.
      // We will grade text-only for now, or just leave it empty.
      // For this implementation, we will skip grading audio.
    } catch (e) {
      debugPrint("Live grading error: $e");
    }
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

  Future<void> _togglePause() async {
    setState(() {
      _isMuted = !_isMuted;
    });

    if (_isMuted) {
      _recognitionSession++;
      _isStartingListening = false;
      _listeningWatchdog?.cancel();
      _setCallState(LiveCallState.idle, "Paused - Take a break");
      await ref.read(speechServiceProvider).cancelListening();
      if (mounted) setState(() => _partialUserText = '');
      try {
        await _player.pausePlayer();
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
        await _player.resumePlayer();
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
    _recognitionSession++;
    _listeningWatchdog?.cancel();
    ref.read(speechServiceProvider).stopListening();
    _player.closePlayer();
    _bgPlayer.stop();
    _bgPlayer.dispose();
    _pulseController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _endCall() async {
    _isEndingCall = true;
    _recognitionSession++;
    _listeningWatchdog?.cancel();
    HapticsManager.heavy();
    ref.read(speechServiceProvider).stopListening();
    await _bgPlayer.stop();
    await _player.stopPlayer();

    if (!mounted) return;

    if (_transcript.isEmpty) {
      Navigator.pop(context);
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          const Center(child: CircularProgressIndicator(color: Colors.white)),
    );

    final verdict = await _generateFinalVerdict();

    if (mounted) {
      Navigator.pop(context); // Close loading
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
      final gemini = ref.read(geminiServiceProvider);
      final transcriptStr = _transcript
          .map((m) => "${m.role.name.toUpperCase()}: ${m.text}")
          .join("\n");

      final prompt =
          'Analyze this transcript and student\'s pronunciation patterns. Identify top 2 struggle areas. Encouraging, scholarly, <80 words.\n\n$transcriptStr';

      return await gemini.makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: [
          {'role': 'user', 'content': prompt}
        ],
      );
    } catch (e) {
      return "Excellent effort. Continue daily practice to refine tones.";
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
            child: Stack(
              children: [
                Column(
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
                                  text: _partialUserText, theme: theme);
                            }
                            final msg = _transcript[index];
                            return _LiveTranscriptBubble(
                                message: msg, theme: theme);
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
                        return Transform.scale(
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
                            onTap: () =>
                                setState(() => _isSpeaker = !_isSpeaker),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
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

  const _LivePartialTranscriptBubble({required this.text, required this.theme});

  @override
  Widget build(BuildContext context) {
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
  const _LiveTranscriptBubble({required this.message, required this.theme});

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == ChatRole.user;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (isUser && message.grade != null)
            _buildGradedText(message.grade!['words'] ?? [], theme, context)
          else ...[
            TappableMarkdownHanziText(
              message.text,
              textAlign: isUser ? TextAlign.right : TextAlign.left,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isUser
                    ? Colors.white70
                    : theme.colorScheme.primary.withValues(alpha: 0.9),
                fontWeight: isUser ? FontWeight.normal : FontWeight.bold,
                height: 1.4,
              ),
            ),
            if (message.pinyin != null && message.pinyin!.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(message.pinyin!, style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70), textAlign: isUser ? TextAlign.right : TextAlign.left),
            ],
            if (message.translation != null && message.translation!.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(message.translation!, style: theme.textTheme.bodySmall?.copyWith(color: Colors.white38, fontStyle: FontStyle.italic), textAlign: isUser ? TextAlign.right : TextAlign.left),
            ],
          ]
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

        final bool isClickable = !correct && feedback.isNotEmpty;

        return GestureDetector(
          onTap: isClickable
              ? () => _showWordFeedback(context, word, pinyin, expectedTone,
                  actualTone, feedback, partial, color, theme)
              : null,
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
                  if (isClickable)
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

  void _showWordFeedback(
    BuildContext context,
    String word,
    String pinyin,
    int expectedTone,
    int actualTone,
    String feedback,
    bool isPartial,
    Color color,
    ThemeData theme,
  ) {
    const toneNames = ['', '1st ˉ', '2nd ˊ', '3rd ˇ', '4th ˋ', 'neutral'];
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    shape: BoxShape.circle),
                child: Center(
                  child: Text(word,
                      style: theme.textTheme.displaySmall?.copyWith(
                          color: color, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 8),
              Text(pinyin,
                  style: theme.textTheme.titleMedium?.copyWith(
                      color:
                          theme.colorScheme.onSurface.withValues(alpha: 0.6))),
              const SizedBox(height: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  isPartial
                      ? AppLocalizations.of(context)!.pronunciationPartial
                      : AppLocalizations.of(context)!.pronunciationWrong,
                  style: theme.textTheme.labelMedium
                      ?.copyWith(color: color, fontWeight: FontWeight.bold),
                ),
              ),
              if (expectedTone > 0) ...[
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _toneChip(
                        context,
                        AppLocalizations.of(context)!.toneExpected,
                        expectedTone,
                        Colors.green.shade600,
                        theme,
                        toneNames),
                    const SizedBox(width: 12),
                    _toneChip(
                        context,
                        AppLocalizations.of(context)!.toneYouSaid,
                        actualTone,
                        color,
                        theme,
                        toneNames),
                  ],
                ),
              ],
              const SizedBox(height: 16),
              Text(feedback,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(height: 1.5)),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context)!.gotIt),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _toneChip(BuildContext context, String label, int tone, Color color,
      ThemeData theme, List<String> names) {
    return Column(
      children: [
        Text(label,
            style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5))),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            tone > 0 && tone < names.length ? names[tone] : '?',
            style: theme.textTheme.labelLarge
                ?.copyWith(color: color, fontWeight: FontWeight.bold),
          ),
        ),
      ],
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
