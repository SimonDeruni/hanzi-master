import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import '../../domain/entities/scenario.dart';
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

    // Connect to Gemini Live API
    _connectToGemini();
  }

  Future<void> _connectToGemini() async {
    setState(() => _callStatus = "Connecting via WebSocket...");
    
    // In a real production app, this key should be highly secured or managed via a proxy backend.
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

      // 1. Initial Handshake / Setup
      _channel!.sink.add(jsonEncode({
        "setup": {
          "model": "models/gemini-2.0-flash-exp",
          "generation_config": {
             "response_modalities": ["AUDIO"]
          },
          "system_instruction": {
            "parts": [
              {"text": "You are a spoken Mandarin tutor. Limit responses to 2 sentences. Your persona is: ${widget.scenario.description}"}
            ]
          }
        }
      }));

      setState(() => _callStatus = "Connected! Awaiting Scholar...");

      // 2. Listen to the stream
      _channel!.stream.listen(
        (message) {
          if (message is String) {
            final data = jsonDecode(message);
            if (data.containsKey('serverContent')) {
              setState(() => _callStatus = "Scholar is speaking...");
              // Handle incoming base64 PCM audio data here
              // e.g. decode data['serverContent']['modelTurn']['parts'][0]['inlineData']['data']
            }
          }
        },
        onDone: () {
          setState(() => _callStatus = "Call ended by Scholar.");
        },
        onError: (error) {
          setState(() => _callStatus = "Connection error: $error");
        },
      );

    } catch (e) {
      setState(() => _callStatus = "Failed to connect: $e");
    }
  }

  @override
  void dispose() {
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

  void _toggleSpeaker() {
    HapticsManager.light();
    setState(() => _isSpeaker = !_isSpeaker);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black, // Phone calls usually have a dark, immersive background
      body: Stack(
        children: [
          // Blurred background image
          Positioned.fill(
            child: Image.asset(
              widget.scenario.avatarAssetPath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(color: Colors.black87),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Container(
                color: Colors.black.withValues(alpha: 0.7), // Darken the blur
              ),
            ),
          ),
          
          // Content
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top header
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      Text(
                        "LIVE CALL",
                        style: theme.textTheme.labelMedium?.copyWith(color: Colors.white54, letterSpacing: 2.0),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.scenario.title,
                        style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _callStatus,
                        style: const TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ],
                  ),
                ),

                // Pulsating Avatar
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: theme.colorScheme.primary.withValues(alpha: 0.4),
                            blurRadius: 50 * _pulseAnimation.value,
                            spreadRadius: 10 * _pulseAnimation.value,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          widget.scenario.avatarAssetPath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: theme.colorScheme.primary.withValues(alpha: 0.3),
                            child: const Icon(Icons.person, size: 80, color: Colors.white),
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
                        label: "Mute",
                        isActive: _isMuted,
                        onTap: _toggleMute,
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
                              BoxShadow(color: Colors.redAccent, blurRadius: 20, offset: Offset(0, 4)),
                            ]
                          ),
                          child: const Icon(Icons.call_end, color: Colors.white, size: 36),
                        ),
                      ),
                      _CallControlButton(
                        icon: _isSpeaker ? Icons.volume_up : Icons.volume_down,
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

  const _CallControlButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

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
              color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.black : Colors.white,
              size: 28,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}
