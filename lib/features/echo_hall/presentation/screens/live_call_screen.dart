import 'dart:ui' as ui;
import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:record/record.dart';
import 'package:flutter_sound/flutter_sound.dart' as fs;
import '../../domain/entities/scenario.dart';
import 'conversation_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/core/services/api_key_pool.dart';

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
  
  WebSocketChannel? _channel;
  String _callStatus = "Initializing...";

  final AudioRecorder _audioRecorder = AudioRecorder();
  final fs.FlutterSoundPlayer _player = fs.FlutterSoundPlayer();
  StreamSubscription<Uint8List>? _audioSubscription;
  bool _isLive = false;

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

    _initAudio();
    _connectToGemini();
  }

  Future<void> _initAudio() async {
    await _player.openPlayer();
  }

  Future<void> _connectToGemini() async {
    setState(() => _callStatus = "Connecting via WebSocket...");
    
    final apiKey = ref.read(apiKeyPoolProvider).googleKey;
    if (apiKey.isEmpty) {
      setState(() => _callStatus = "Error: Missing API Key");
      return;
    }

    try {
      final uri = Uri.parse(
        'wss://generativelanguage.googleapis.com/ws/google.ai.generativelanguage.v1beta.GenerativeService.BidiGenerateContent?key=$apiKey'
      );
      
      _channel = WebSocketChannel.connect(uri);

      // 1. Setup Phase
      _channel!.sink.add(jsonEncode({
        "setup": {
          "model": "models/gemini-2.0-flash-exp",
          "generation_config": {
             "response_modalities": ["AUDIO"],
             "speech_config": {
               "voice_config": { "prebuilt_voice_config": { "voice_name": "Puck" } }
             }
          },
          "system_instruction": {
            "parts": [
              {"text": "You are a spoken Mandarin tutor. Limit responses to 2-3 sentences. Your persona is: ${widget.scenario.description}. Respond naturally in Mandarin Chinese."}
            ]
          }
        }
      }));

      // 2. Listen to Gemini responses
      _channel!.stream.listen(
        (message) async {
          if (message is String) {
            final data = jsonDecode(message);
            
            if (data.containsKey('setupComplete')) {
              setState(() => _callStatus = "Connected! Start speaking.");
              _startAudioStreaming();
            }

            if (data.containsKey('serverContent')) {
              final modelTurn = data['serverContent']['modelTurn'];
              if (modelTurn != null && modelTurn['parts'] != null) {
                for (var part in modelTurn['parts']) {
                  if (part.containsKey('inlineData')) {
                    final base64Audio = part['inlineData']['data'];
                    final audioBytes = base64Decode(base64Audio);
                    
                    // Gemini returns 24kHz PCM
                    await _player.startPlayer(
                      fromDataBuffer: Uint8List.fromList(audioBytes),
                      sampleRate: 24000,
                      codec: fs.Codec.pcm16,
                      numChannels: 1,
                    );
                  }
                }
              }
            }
          }
        },
        onDone: () => setState(() => _callStatus = "Call ended."),
        onError: (error) => setState(() => _callStatus = "Connection error: $error"),
      );

    } catch (e) {
      setState(() => _callStatus = "Failed to connect: $e");
    }
  }

  Future<void> _startAudioStreaming() async {
    if (await _audioRecorder.hasPermission()) {
      // Gemini Live expects 16kHz Mono 16-bit PCM
      final stream = await _audioRecorder.startStream(
        const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          sampleRate: 16000,
          numChannels: 1,
        ),
      );

      _audioSubscription = stream.listen((data) {
        if (!_isMuted && _channel != null) {
          // Send 16kHz PCM chunks to Gemini
          _channel!.sink.add(jsonEncode({
            "realtime_input": {
              "media_chunks": [
                {
                  "mime_type": "audio/pcm",
                  "data": base64Encode(data)
                }
              ]
            }
          }));
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
    super.dispose();
  }

  void _endCall() {
    HapticsManager.heavy();
    _channel?.sink.close(status.normalClosure);
    Navigator.pop(context);
  }

  void _toggleMute() {
    HapticsManager.light();
    setState(() => _isMuted = !_isMuted);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      Text("GEMINI LIVE CALL", style: theme.textTheme.labelMedium?.copyWith(color: Colors.white54, letterSpacing: 2.0)),
                      const SizedBox(height: 8),
                      Text(widget.scenario.title, style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(_callStatus, style: const TextStyle(color: Colors.white70, fontSize: 16)),
                    ],
                  ),
                ),

                // Pulsating Avatar
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    final scale = _isLive && !_isMuted ? _pulseAnimation.value : 1.0;
                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        width: 180, height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            if (_isLive && !_isMuted)
                              BoxShadow(color: theme.colorScheme.primary.withValues(alpha: 0.4), blurRadius: 40, spreadRadius: 5),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            widget.scenario.avatarAssetPath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(color: Colors.indigo.shade900),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // Call Controls
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _CallControlButton(
                        icon: _isMuted ? Icons.mic_off : Icons.mic,
                        label: _isMuted ? "Muted" : "Mute",
                        isActive: _isMuted,
                        onTap: _toggleMute,
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
                        onTap: () {
                          HapticsManager.light();
                          setState(() => _isSpeaker = !_isSpeaker);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
