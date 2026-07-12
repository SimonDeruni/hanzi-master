import 'package:hanzi_master/l10n/app_localizations.dart';
import 'dart:ui' as ui;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:googleai_dart/googleai_dart.dart' as googleai;
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:record/record.dart';
import 'package:flutter_sound/flutter_sound.dart' as fs;
import '../../domain/entities/scenario.dart';
import '../../../chat/domain/entities/chat_message.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/core/services/api_key_pool.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
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
  final ChatRole role;
  final Map<String, dynamic>? grade; 
  final DateTime timestamp;

  LiveCallMessage({
    required this.text,
    required this.role,
    this.grade,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  LiveCallMessage copyWith({Map<String, dynamic>? grade, String? text}) {
    return LiveCallMessage(
      text: text ?? this.text,
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

class _LiveCallScreenState extends ConsumerState<LiveCallScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isMuted = false;
  bool _isSpeaker = true;
  bool _isEndingCall = false;

  final fs.FlutterSoundPlayer _player = fs.FlutterSoundPlayer();
  final AudioPlayer _bgPlayer = AudioPlayer();
  LiveCallState _callState = LiveCallState.connecting;
  String _callStatus = "Initializing...";
  bool _hasError = false;
  WebSocketChannel? _channel;

  final AudioRecorder _audioRecorder = AudioRecorder();
  StreamSubscription<Uint8List>? _audioSubscription;
  bool _isLive = false;

  // Transcript & Grading State
  final List<LiveCallMessage> _transcript = [];
  final BytesBuilder _userAudioBuffer = BytesBuilder();
  final List<int> _audioBuffer = [];
  final ScrollController _scrollController = ScrollController();

  // VAD / Silence Detection removed, relying on Gemini Server VAD
  DateTime _lastAudioReceived = DateTime.now();
  bool _isModelSpeaking = false;
  DateTime? _firstTranscriptionTime;

  // Audio level for visual feedback
  double _audioLevel = 0.0;

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

    _initAudioAndConnect();
  }

  Future<void> _initAudioAndConnect() async {
    try {
      await _player.openPlayer();

    if (widget.scenario.backgroundAudioPath != null) {
      if (widget.scenario.backgroundAudioPath!.startsWith('/') || widget.scenario.backgroundAudioPath!.contains(':\\')) {
        await _bgPlayer.setReleaseMode(ReleaseMode.loop);
        await _bgPlayer.setVolume(0.3); // Ambient volume
        await _bgPlayer.play(DeviceFileSource(widget.scenario.backgroundAudioPath!));
      }
    }

    // Required for stream playback:
    await _player.startPlayerFromStream(
        codec: fs.Codec.pcm16,
        numChannels: 1,
        sampleRate: 24000,
        bufferSize: 8192,
        interleaved: true,
      );
      await _connectToGemini();
    } catch (e) {
      debugPrint("LiveCall: Init failed: $e");
      if (mounted) {
        setState(() {
          _callStatus = "Initialization error. Check permissions.";
          _hasError = true;
        });
      }
    }
  }

  void _setCallState(LiveCallState newState, String statusText) {
    if (!mounted) return;
    setState(() {
      _callState = newState;
      _callStatus = statusText;
      _hasError = newState == LiveCallState.error;
    });
  }



  double _computeAudioLevel(List<int> samples) {
    if (samples.isEmpty) return 0.0;
    // PCM 16-bit mono: each sample is 2 bytes
    double sum = 0;
    for (int i = 0; i < samples.length - 1; i += 2) {
      final sample = (samples[i + 1] << 8) | samples[i];
      sum += (sample * sample).toDouble();
    }
    final rms = (samples.length ~/ 2) > 0 ? (sum / (samples.length ~/ 2)) : 0.0;
    // Normalize to 0.0–1.0 (typical speech RMS is well below max int16)
    return (rms / 100000000.0).clamp(0.0, 1.0);
  }

  Future<void> _connectToGemini() async {
    if (!mounted) return;
    _setCallState(LiveCallState.connecting, "Connecting to Scholar...");
    
    final apiKey = ref.read(apiKeyPoolProvider).googleKey;
    if (apiKey.isEmpty) {
      setState(() {
        _callStatus = "Error: Missing Google API Key";
        _hasError = true;
      });
      return;
    }

    try {
      // Endpoint for Gemini Multimodal Live API
      final uri = Uri.parse(
        'wss://generativelanguage.googleapis.com/ws/google.ai.generativelanguage.v1alpha.GenerativeService.BidiGenerateContent?key=$apiKey'
      );
      
      _channel = WebSocketChannel.connect(uri);

      // 1. Setup Phase - Updated for June 2026 stable models
      // 1. Setup Phase - Updated for strictly typed Google GenAI Dart SDK
      final setupMessage = jsonEncode(googleai.BidiGenerateContentSetup(
        model: "models/gemini-3.1-flash-live-preview",
        generationConfig: googleai.LiveGenerationConfig(
          responseModalities: const [googleai.ResponseModality.audio],
          speechConfig: googleai.SpeechConfig(
            voiceConfig: googleai.VoiceConfig(
              prebuiltVoiceConfig: googleai.PrebuiltVoiceConfig(
                voiceName: widget.scenario.voiceName,
              ),
            ),
          ),
        ),
        systemInstruction: googleai.Content(parts: [
          googleai.TextPart(
            'You are a professional Mandarin tutor named Master Lin. You are patient, wise, and encouraging. Respond naturally in spoken Mandarin. Keep your responses short (under 3 sentences). Your current scenario: ${widget.scenario.description}',
          )
        ]),
      ).toJson());

      _channel!.sink.add(setupMessage);

      _channel!.stream.listen(
        (message) async {
          debugPrint("GEMINI LIVE RAW: $message");
          if (!mounted) return;
          
          try {
            String textMessage;
            if (message is List<int>) {
              textMessage = utf8.decode(message);
            } else {
              textMessage = message.toString();
            }
            final data = jsonDecode(textMessage);
            
            // Check for raw server errors
            if (data.containsKey('error')) {
              debugPrint("LiveCall: Server returned error: ${data['error']}");
              if (mounted) {
                setState(() {
                  _callStatus = "We're sorry, the call encountered a server error. Please try again later.";
                  _hasError = true;
                });
              }
              return;
            }

            final parsedMessage = googleai.BidiGenerateContentServerMessage.fromJson(data);

            if (parsedMessage is googleai.BidiGenerateContentSetupComplete) {
              _setCallState(LiveCallState.idle, "Connected! Speak now.");
              _startAudioStreaming();
            } else if (parsedMessage is googleai.BidiGenerateContentServerContent) {
              if (parsedMessage.modelTurn != null) {
                // AI is speaking
                _isModelSpeaking = true;
                if (_callState != LiveCallState.speaking) {
                  _setCallState(LiveCallState.speaking, "Speaking...");
                }
                
                for (var part in parsedMessage.modelTurn!.parts) {
                  if (part is googleai.InlineDataPart) {
                    final audioBytes = base64Decode(part.inlineData.data);
                    _player.feedUint8FromStream(Uint8List.fromList(audioBytes));
                  } else if (part is googleai.TextPart) {
                    _handleAiTranscript(part.text);
                  }
                }
              }

              // Handle user transcript if present
              // Wait, googleai_dart doesn't have an inputTranscription typed field directly in BidiGenerateContentServerContent in older versions. 
              // We can still check the raw map for any custom extensions if needed, but it's safe to fallback to raw map reading.
              if (data.containsKey('serverContent') && data['serverContent'].containsKey('inputTranscription')) {
                final trans = data['serverContent']['inputTranscription'];
                _handleUserInputTranscription(trans['text'] ?? "", trans['finished'] ?? false);
              }

              if (parsedMessage.turnComplete == true) {
                _isModelSpeaking = false;
                _firstTranscriptionTime = null;
                _setCallState(LiveCallState.idle, "Connected! Speak now.");
              }

              if (parsedMessage.interrupted == true) {
                 _player.stopPlayer();
                 _userAudioBuffer.clear();
                 _isModelSpeaking = false;
                 _firstTranscriptionTime = null;
              }
            }
          } catch (e) {
            debugPrint("LiveCall: Parse error: $e");
          }
        },
        onDone: () {
          if (_isEndingCall) return;
          final closeCode = _channel?.closeCode;
          final closeReason = _channel?.closeReason;
          debugPrint("LiveCall: Closed. Code: $closeCode, Reason: $closeReason");
          if (mounted) {
            setState(() {
              if (closeCode == 4403 || closeCode == 403) {
                _callStatus = "Access Denied. Your API Key lacks permissions or the region is unsupported.";
              } else if (closeCode != null && closeCode >= 1000) {
                _callStatus = "We're sorry, the call disconnected unexpectedly. Please try again later.";
              } else {
                _callStatus = "Call ended unexpectedly. Please try again.";
              }
              _hasError = true;
            });
          }
        },
        onError: (error) {
          debugPrint("LiveCall: Stream error: $error");
          if (mounted) {
            setState(() {
              _callStatus = "We're sorry, a connection error occurred. Please try again later.";
              _hasError = true;
            });
          }
        },
      );

    } catch (e) {
      debugPrint("LiveCall: Connection fail: $e");
      if (mounted) {
        setState(() {
          _callStatus = "We're sorry, we couldn't connect to the server right now. Please try again later.";
          _hasError = true;
        });
      }
    }
  }

  void _handleAiTranscript(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      if (_transcript.isNotEmpty && _transcript.last.role == ChatRole.scholar) {
        final last = _transcript.removeLast();
        _transcript.add(last.copyWith(text: last.text + text));
      } else {
        _transcript.add(LiveCallMessage(text: text, role: ChatRole.scholar));
      }
    });
    _scrollToBottom();
  }

  void _handleUserInputTranscription(String text, bool finished) {
    if (text.trim().isEmpty) return;

    // Guard: ignore transcriptions while the model is speaking or thinking
    if (_isModelSpeaking || _callState == LiveCallState.thinking || _callState == LiveCallState.speaking) {
      debugPrint("LiveCall: Ignoring inputTranscription — model is active (state: $_callState)");
      return;
    }

    final wasAlreadyListening = _callState == LiveCallState.listening;

    setState(() {
      int lastUserIdx = _transcript.lastIndexWhere((m) => m.role == ChatRole.user);
      if (lastUserIdx != -1 && _transcript[lastUserIdx].grade == null) {
        _transcript[lastUserIdx] = _transcript[lastUserIdx].copyWith(text: text);
      } else {
        _transcript.add(LiveCallMessage(text: text, role: ChatRole.user));
      }
    });

    // Record first transcription time
    if (!wasAlreadyListening) {
      _firstTranscriptionTime = DateTime.now();
    }

    if (finished) {
      // Gemini has declared the utterance complete, trigger grading
      _triggerGradingForLastUserTurn();
    }
    _scrollToBottom();
  }

  Future<void> _triggerGradingForLastUserTurn() async {
    final lastUserIdx = _transcript.lastIndexWhere((m) => m.role == ChatRole.user);
    if (lastUserIdx == -1) return;
    
    final message = _transcript[lastUserIdx];
    final audioData = _userAudioBuffer.takeBytes();
    if (audioData.isEmpty) return;

    try {
      final result = await ref.read(geminiServiceProvider).gradeAudio(audioData, message.text, "");
      if (mounted) {
        setState(() {
          _transcript[lastUserIdx] = message.copyWith(grade: result);
        });
      }
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
      if (_isMuted) {
        _setCallState(LiveCallState.idle, "Paused - Take a break");
      } else {
        _setCallState(LiveCallState.idle, "Connected! Speak now.");
      }
    });
    
    if (_isMuted) {
      try { await _player.pausePlayer(); } catch (e) {}
      try { await _bgPlayer.pause(); } catch (e) {}
    } else {
      try { await _player.resumePlayer(); } catch (e) {}
      try { await _bgPlayer.resume(); } catch (e) {}
    }
  }

  Future<void> _startAudioStreaming() async {
    if (await _audioRecorder.hasPermission()) {
      final stream = await _audioRecorder.startStream(
        const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          sampleRate: 16000,
          numChannels: 1,
        ),
      );

      _audioSubscription = stream.listen((data) {
        if (data.isEmpty) return;
        // Half-duplex mode: do not send audio while the model is speaking to prevent echoing/interrupting itself
        if (!_isMuted && !_isModelSpeaking && _channel != null) {
          _audioBuffer.addAll(data);
          _userAudioBuffer.add(data);

          // Compute audio level for visual feedback
          _audioLevel = _computeAudioLevel(data);

          // Transition to listening state on first audio
          if (_callState == LiveCallState.idle) {
            _setCallState(LiveCallState.listening, "Listening...");
          }

          // removed silence timer logic
          
          // Buffer ~0.5 seconds of audio (16000 bytes/samples at 16kHz 16-bit mono)
          // to prevent websocket congestion and make the connection stable
          if (_audioBuffer.length >= 16000) {
            _channel!.sink.add(jsonEncode(
              googleai.BidiGenerateContentRealtimeInput.audio(
                _audioBuffer.toList()
              ).toJson()
            ));
            _audioBuffer.clear();
          }
        }
      });
      setState(() => _isLive = true);
    }
  }

  @override
  void dispose() {
    _audioSubscription?.cancel();
    _audioRecorder.dispose();
    _player.closePlayer();
    _channel?.sink.close(status.normalClosure);
    _pulseController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _endCall() async {
    _isEndingCall = true;
    HapticsManager.heavy();
    _channel?.sink.close(status.normalClosure);
    await _bgPlayer.stop();
    await _bgPlayer.dispose();

    if (_transcript.isEmpty) {
      Navigator.pop(context);
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator(color: Colors.white)),
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
      final transcriptStr = _transcript.map((m) => "${m.role.name.toUpperCase()}: ${m.text}").join("\n");
      
      final prompt = 'Analyze this transcript and student\'s pronunciation patterns. Identify top 2 struggle areas. Encouraging, scholarly, <80 words.\n\n$transcriptStr';

      return await gemini.makeOpenRouterCall(
        model: 'google/gemini-2.5-flash',
        messages: [{'role': 'user', 'content': prompt}],
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
            child: (widget.scenario.avatarAssetPath == 'none' || widget.scenario.avatarAssetPath.isEmpty)
              ? Container(color: Colors.black87)
              : widget.scenario.avatarAssetPath.startsWith('/') || widget.scenario.avatarAssetPath.contains(':\\')
                ? Image.file(
                    File(widget.scenario.avatarAssetPath),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(color: Colors.black87),
                  )
                : Image.asset(
                    widget.scenario.avatarAssetPath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(color: Colors.black87),
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
                      Text(AppLocalizations.of(context)!.geminiLiveCall, style: theme.textTheme.labelMedium?.copyWith(color: Colors.white54, letterSpacing: 2.0)),
                      const SizedBox(height: 8),
                      Text(widget.scenario.title, style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
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
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              elevation: 8,
                            ),
                            icon: const Icon(Icons.arrow_back, size: 20),
                            label: Text(
                              AppLocalizations.of(context)!.returnToMenu,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                        colors: [Colors.transparent, Colors.black, Colors.black, Colors.transparent],
                        stops: [0.0, 0.1, 0.9, 1.0],
                      ).createShader(rect);
                    },
                    blendMode: BlendMode.dstIn,
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      itemCount: _transcript.length,
                      itemBuilder: (context, index) {
                        final msg = _transcript[index];
                        return _LiveTranscriptBubble(message: msg, theme: theme);
                      },
                    ),
                  ),
                ),

                    const SizedBox(height: 24),

                    AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    final bool isActive = _callState == LiveCallState.listening || _callState == LiveCallState.speaking;
                    final double baseScale = 1.0 + (_audioLevel * 0.15);
                    final double scale = isActive ? baseScale * _pulseAnimation.value : 1.0;
                    final Color glowColor = _callState == LiveCallState.listening
                        ? Colors.cyanAccent
                        : _callState == LiveCallState.speaking
                            ? theme.colorScheme.primary
                            : _callState == LiveCallState.thinking
                                ? Colors.amber
                                : Colors.white24;
                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        width: 140, height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            if (isActive || _callState == LiveCallState.thinking)
                              BoxShadow(color: glowColor.withValues(alpha: 0.5), blurRadius: 40 + (_audioLevel * 20), spreadRadius: 5),
                          ],
                        ),
                        child: ClipOval(
                          child: (widget.scenario.avatarAssetPath == 'none' || widget.scenario.avatarAssetPath.isEmpty)
                            ? Container(
                                color: theme.colorScheme.primary,
                                child: Center(
                                  child: Text(
                                    widget.scenario.personaName.isNotEmpty ? widget.scenario.personaName[0].toUpperCase() : '?',
                                    style: const TextStyle(color: Colors.white, fontSize: 60, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            : Image.asset(
                                widget.scenario.avatarAssetPath,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(color: Colors.indigo.shade900),
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
                              width: 72, height: 72,
                              decoration: const BoxDecoration(
                                color: Colors.redAccent,
                                shape: BoxShape.circle,
                                boxShadow: [BoxShadow(color: Colors.redAccent, blurRadius: 20, offset: Offset(0, 4))]
                              ),
                              child: const Icon(Icons.call_end, color: Colors.white, size: 36),
                            ),
                          ),
                          _CallControlButton(
                            icon: _isSpeaker ? Icons.volume_up : Icons.volume_down,
                            label: "Speaker",
                            isActive: _isSpeaker,
                            onTap: () => setState(() => _isSpeaker = !_isSpeaker),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Positioned(
                  top: 0,
                  right: 8,
                  child:                 ),
              ],
            ),
          ),
        ],
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
        crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (isUser && message.grade != null)
             _buildGradedText(message.grade!['words'] ?? [], theme, context)
          else
            TappableMarkdownHanziText(
              message.text,
              textAlign: isUser ? TextAlign.right : TextAlign.left,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isUser ? Colors.white70 : theme.colorScheme.primary.withValues(alpha: 0.9),
                fontWeight: isUser ? FontWeight.normal : FontWeight.bold,
                height: 1.4,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGradedText(List<dynamic> words, ThemeData theme, BuildContext context) {
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
              ? () => _showWordFeedback(context, word, pinyin, expectedTone, actualTone, feedback, partial, color, theme)
              : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                pinyin,
                style: theme.textTheme.labelSmall?.copyWith(color: Colors.white54),
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
                        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
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
    String word, String pinyin,
    int expectedTone, int actualTone,
    String feedback, bool isPartial,
    Color color, ThemeData theme,
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
                width: 72, height: 72,
                decoration: BoxDecoration(color: color.withValues(alpha: 0.15), shape: BoxShape.circle),
                child: Center(
                  child: Text(word, style: theme.textTheme.displaySmall?.copyWith(color: color, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 8),
              Text(pinyin, style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
                child: Text(
                  isPartial ? AppLocalizations.of(context)!.pronunciationPartial : AppLocalizations.of(context)!.pronunciationWrong,
                  style: theme.textTheme.labelMedium?.copyWith(color: color, fontWeight: FontWeight.bold),
                ),
              ),
              if (expectedTone > 0) ...[
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _toneChip(context, AppLocalizations.of(context)!.toneExpected, expectedTone, Colors.green.shade600, theme, toneNames),
                    const SizedBox(width: 12),
                    _toneChip(context, AppLocalizations.of(context)!.toneYouSaid, actualTone, color, theme, toneNames),
                  ],
                ),
              ],
              const SizedBox(height: 16),
              Text(feedback, textAlign: TextAlign.center, style: theme.textTheme.bodyMedium?.copyWith(height: 1.5)),
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

  Widget _toneChip(BuildContext context, String label, int tone, Color color, ThemeData theme, List<String> names) {
    return Column(
      children: [
        Text(label, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.5))),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
          child: Text(
            tone > 0 && tone < names.length ? names[tone] : '?',
            style: theme.textTheme.labelLarge?.copyWith(color: color, fontWeight: FontWeight.bold),
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

  const _CallControlButton({required this.icon, required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 60, height: 60,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: isActive ? Colors.black : Colors.white, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}