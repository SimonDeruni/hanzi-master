import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:record/record.dart';
import 'package:flutter_sound/flutter_sound.dart' as fs;
import 'package:hanzi_master/core/services/api_key_pool.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/core/providers/translation_language_provider.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:lpinyin/lpinyin.dart';

enum ShadowingMode { freeFlow, theme, deck, customWord }

class ShadowingMessage {
  final String englishText;
  final String mandarinTranslation;
  final String? pinyin;
  final Map<String, dynamic>? pronunciationGrade;

  ShadowingMessage({required this.englishText, required this.mandarinTranslation, this.pinyin, this.pronunciationGrade});

  ShadowingMessage copyWith({String? englishText, String? mandarinTranslation, String? pinyin, Map<String, dynamic>? pronunciationGrade}) {
    return ShadowingMessage(
      englishText: englishText ?? this.englishText,
      mandarinTranslation: mandarinTranslation ?? this.mandarinTranslation,
      pinyin: pinyin ?? this.pinyin,
      pronunciationGrade: pronunciationGrade ?? this.pronunciationGrade,
    );
  }
}

class ShadowingStudioScreen extends ConsumerStatefulWidget {
  final String? initialHanzi;
  final String? initialPinyin;
  final String? initialTranslation;
  const ShadowingStudioScreen({super.key, this.initialHanzi, this.initialPinyin, this.initialTranslation});

  @override
  ConsumerState<ShadowingStudioScreen> createState() => _ShadowingStudioScreenState();
}

class _ShadowingStudioScreenState extends ConsumerState<ShadowingStudioScreen> with SingleTickerProviderStateMixin {
  final fs.FlutterSoundPlayer _player = fs.FlutterSoundPlayer();
  final AudioRecorder _audioRecorder = AudioRecorder();
  
  WebSocketChannel? _channel;
  StreamSubscription<Uint8List>? _audioSubscription;
  
  String _status = "Initializing...";
  bool _isLive = false;
  bool _hasError = false;

  final List<ShadowingMessage> _transcript = [];

  bool _isSessionStarted = false;
  AnimationController? _pulseController;
  Animation<double>? _pulseAnimation;

  ShadowingMode _selectedMode = ShadowingMode.freeFlow;
  bool _isAiSpeaking = false;
  Timer? _aiSpeechTimer;
  String _selectedTheme = "HSK 1";
  String? _selectedDeckId;
  String _customWordInput = "";

  @override
  void initState() {
    super.initState();
    if (widget.initialHanzi != null) {
      _transcript.add(ShadowingMessage(
        englishText: widget.initialTranslation != null && widget.initialTranslation!.isNotEmpty 
            ? "Practice: ${widget.initialTranslation}" 
            : "Practice: ${widget.initialHanzi}",
        mandarinTranslation: widget.initialHanzi!,
        pinyin: widget.initialPinyin,
      ));
    }
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController!, curve: Curves.easeInOut),
    );
  }

  Future<void> _startSession() async {
    setState(() {
      _isSessionStarted = true;
      _status = "Tap microphone to connect and practice...";
    });
  }

  Future<void> _initAudioAndConnect() async {
    try {
      await _player.openPlayer();
      await _player.startPlayerFromStream(
        codec: fs.Codec.pcm16,
        numChannels: 1,
        sampleRate: 24000,
        bufferSize: 8192,
        interleaved: true,
      );
      await _connectToGemini();
    } catch (e) {
      if (mounted) setState(() { _status = "Init error: $e"; _hasError = true; });
    }
  }

  Future<void> _connectToGemini() async {
    if (!mounted) return;
    setState(() => _status = "Connecting...");
    
    final apiKey = ref.read(apiKeyPoolProvider).googleKey;
    if (apiKey.isEmpty) {
      setState(() { _status = "Missing API Key"; _hasError = true; });
      return;
    }

    try {
      final uri = Uri.parse(
        'wss://generativelanguage.googleapis.com/ws/google.ai.generativelanguage.v1alpha.GenerativeService.BidiGenerateContent?key=$apiKey'
      );
      _channel = WebSocketChannel.connect(uri);

      String systemInstructionText = "You are a Shadowing Practice Studio. The user will speak English. You must instantly translate the English phrase into Mandarin Chinese and speak the Mandarin Chinese back to them so they can shadow your pronunciation. When the user shadows your phrase, ALWAYS use the 'report_pronunciation_grade' tool to evaluate their accuracy.";
      
      if (_selectedMode == ShadowingMode.customWord || widget.initialHanzi != null) {
        final practiceWord = widget.initialHanzi ?? _customWordInput;
        systemInstructionText = "You are a Mandarin pronunciation coach. The user is practicing the word/phrase '$practiceWord' (Pinyin: ${widget.initialPinyin ?? ''}, Meaning: ${widget.initialTranslation ?? ''}). Speak the word out loud so they can shadow it, and wait for them to repeat it. If they struggle, break it down. ALWAYS use the 'report_pronunciation_grade' tool to evaluate their pronunciation when they speak.";
      } else if (_selectedMode == ShadowingMode.theme) {
        systemInstructionText = "You are a Mandarin pronunciation coach. The user wants to practice the topic: $_selectedTheme. Generate a short, simple Mandarin sentence related to this topic, speak it out loud for them to shadow, and wait for them to repeat it. If they repeat it well, give them a new sentence. ALWAYS use the 'report_pronunciation_grade' tool to evaluate their pronunciation when they speak.";
      } else if (_selectedMode == ShadowingMode.deck) {
        systemInstructionText = "You are a Mandarin pronunciation coach. The user is practicing their custom flashcard deck. Generate a Mandarin sentence using common vocabulary, speak it out loud for them to shadow, and wait for them to repeat it. ALWAYS use the 'report_pronunciation_grade' tool to evaluate their pronunciation when they speak.";
      }

      final setupMessage = jsonEncode({
        "setup": {
          "model": "models/gemini-3.1-flash-live-preview",
          "generationConfig": {
             "responseModalities": ["AUDIO"],
             "speechConfig": {
               "voiceConfig": { "prebuiltVoiceConfig": { "voiceName": "Aoede" } }
             }
          },
          "systemInstruction": {
            "parts": [
              {"text": systemInstructionText}
            ]
          },
          "tools": [
            {
              "functionDeclarations": [
                {
                  "name": "report_pronunciation_grade",
                  "description": "Report the user's pronunciation accuracy for the phrase they just shadowed.",
                  "parameters": {
                    "type": "OBJECT",
                    "properties": {
                      "overallScore": { "type": "INTEGER" },
                      "feedback": { "type": "STRING" },
                      "breakdown": {
                        "type": "ARRAY",
                        "items": {
                          "type": "OBJECT",
                          "properties": {
                            "hanzi": { "type": "STRING" },
                            "pinyin": { "type": "STRING" },
                            "isToneCorrect": { "type": "BOOLEAN" }
                          }
                        }
                      }
                    }
                  }
                }
              ]
            }
          ]
        }
      });

      _channel!.sink.add(setupMessage);

      _channel!.stream.listen(
        (message) async {
          if (!mounted) return;
          try {
            String textMessage;
            if (message is List<int>) {
              textMessage = utf8.decode(message);
            } else {
              textMessage = message.toString();
            }
            final data = jsonDecode(textMessage);
            
            if (data.containsKey('error')) {
              if (mounted) setState(() => _status = "Error: ${data['error']['message']}");
            }
            
            if (data.containsKey('setupComplete')) {
              setState(() => _status = "Speak ${ref.read(translationLanguageProvider)} to get started...");
              _startAudioStreaming();
            }

            if (data.containsKey('serverContent')) {
              final content = data['serverContent'];
              
              if (content.containsKey('modelTurn')) {
                final modelTurn = content['modelTurn'];
                if (modelTurn['parts'] != null) {
                  for (var part in modelTurn['parts']) {
                    if (part.containsKey('inlineData')) {
                      final base64Audio = part['inlineData']['data'];
                      final audioBytes = base64Decode(base64Audio);
                      _player.feedUint8FromStream(Uint8List.fromList(audioBytes));
                      
                      _isAiSpeaking = true;
                      _aiSpeechTimer?.cancel();
                      _aiSpeechTimer = Timer(const Duration(milliseconds: 1500), () {
                        if (mounted) _isAiSpeaking = false;
                      });
                    }
                    if (part.containsKey('text')) {
                      _handleTranslatedText(part['text']);
                    }
                  }
                }
              }

              if (content.containsKey('toolCall')) {
                final toolCall = content['toolCall'];
                final functionCalls = toolCall['functionCalls'];
                if (functionCalls != null && functionCalls.isNotEmpty) {
                  for (var call in functionCalls) {
                    if (call['name'] == 'report_pronunciation_grade') {
                      final args = call['args'];
                      setState(() {
                        if (_transcript.isNotEmpty) {
                          final last = _transcript.last;
                          _transcript[_transcript.length - 1] = last.copyWith(pronunciationGrade: args);
                        }
                      });
                      
                      final responseMessage = jsonEncode({
                        "toolResponse": {
                          "functionResponses": [
                            {
                              "id": call['id'],
                              "name": call['name'],
                              "response": { "result": "acknowledged" }
                            }
                          ]
                        }
                      });
                      _channel!.sink.add(responseMessage);
                    }
                  }
                }
              }

              if (content.containsKey('inputTranscription')) {
                final trans = content['inputTranscription'];
                _handleOriginalAudioText(trans['text'] ?? "", trans['finished'] ?? false);
              }
            }
          } catch (e) {}
        },
        onDone: () {
          final code = _channel?.closeCode;
          final reason = _channel?.closeReason;
          debugPrint("ShadowingStudio: Connection closed. Code: $code, Reason: $reason");
          if (mounted) setState(() { _status = "Connection closed ($code): ${reason ?? 'unknown'}"; _hasError = true; });
        },
        onError: (e) {
          if (mounted) setState(() { _status = "Connection Error: $e"; _hasError = true; });
        },
      );
    } catch (e) {
      if (mounted) setState(() { _status = "Fail: $e"; _hasError = true; });
    }
  }

  void _handleTranslatedText(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      if (_transcript.isEmpty || _transcript.last.pronunciationGrade != null) {
        final newPinyin = PinyinHelper.getPinyinE(
          text,
          separator: " ",
          defPinyin: '',
          format: PinyinFormat.WITH_TONE_MARK,
        );
        _transcript.add(ShadowingMessage(
          englishText: _selectedMode == ShadowingMode.freeFlow ? "..." : "Shadow this:",
          mandarinTranslation: text,
          pinyin: newPinyin,
        ));
      } else {
        final last = _transcript.last;
        final newMandarin = last.mandarinTranslation + text;
        final newPinyin = PinyinHelper.getPinyinE(
          newMandarin,
          separator: " ",
          defPinyin: '',
          format: PinyinFormat.WITH_TONE_MARK,
        );
        _transcript[_transcript.length - 1] = last.copyWith(
          mandarinTranslation: newMandarin,
          pinyin: newPinyin,
        );
      }
    });
  }

  void _handleOriginalAudioText(String text, bool finished) {
    if (text.trim().isEmpty) return;
    setState(() {
      if (_transcript.isEmpty || finished) {
        _transcript.add(ShadowingMessage(englishText: text, mandarinTranslation: ""));
      } else {
        final last = _transcript.last;
        _transcript[_transcript.length - 1] = last.copyWith(englishText: text);
      }
    });
  }

  Future<void> _startAudioStreaming() async {
    if (await _audioRecorder.hasPermission()) {
      final stream = await _audioRecorder.startStream(
        const RecordConfig(encoder: AudioEncoder.pcm16bits, sampleRate: 16000, numChannels: 1),
      );
      _audioSubscription = stream.listen((data) {
        if (data.isEmpty || _isAiSpeaking) return;
        if (_channel != null && _channel?.closeCode == null) {
          try {
            _channel!.sink.add(jsonEncode({
              "realtimeInput": {
                "audio": { "mimeType": "audio/pcm;rate=16000", "data": base64Encode(data) }
              }
            }));
          } catch (e) {
            debugPrint("Sink add error: $e");
          }
        }
      });
      setState(() {
        _isLive = true;
        _pulseController?.repeat(reverse: true);
      });
    }
  }

  Future<void> _stopAudioStreaming() async {
    await _audioSubscription?.cancel();
    await _audioRecorder.stop();
    setState(() {
      _isLive = false;
      _status = "Paused...";
      _pulseController?.stop();
      _pulseController?.reset();
    });
  }

  void _toggleMic() {
    if (_isLive) {
      _stopAudioStreaming();
    } else {
      if (_channel == null || _channel?.closeCode != null) {
        _initAudioAndConnect();
      } else {
        _startAudioStreaming();
      }
    }
  }

  @override
  void dispose() {
    _audioSubscription?.cancel();
    _audioRecorder.dispose();
    _player.closePlayer();
    _channel?.sink.close(status.normalClosure);
    _pulseController?.dispose();
    super.dispose();
  }

  Widget _buildHubUI(BuildContext context, bool isDark) {
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
      body: CalligraphyBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : const Color(0xFF1A1A1B)),
                      onPressed: () => Navigator.pop(context),
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: ref.watch(translationLanguageProvider),
                        icon: Icon(Icons.language, color: isDark ? Colors.white70 : Colors.black54),
                        dropdownColor: isDark ? Colors.grey[900] : Colors.white,
                        style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
                        items: supportedTranslationLanguages.map((lang) => DropdownMenuItem(value: lang, child: Text(lang))).toList(),
                        onChanged: (val) {
                          if (val != null) ref.read(translationLanguageProvider.notifier).setLanguage(val);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              
              // Hero Section
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.orange.withValues(alpha: 0.1) : Colors.orange.withValues(alpha: 0.05),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.record_voice_over,
                          size: 80,
                          color: isDark ? Colors.orange.shade300 : Colors.orange.shade600,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        "Shadowing Studio",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Master your Mandarin pronunciation by mimicking native speech in real-time.",
                        style: TextStyle(
                          fontSize: 18,
                          color: isDark ? Colors.white70 : Colors.black54,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      
                      // Mode Selection
                      const SizedBox(height: 24),
                      Text(
                        "PRACTICE MODE",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: isDark ? Colors.white54 : Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        alignment: WrapAlignment.center,
                        children: [
                          ChoiceChip(
                            label: const Text("Free Flow"),
                            selected: _selectedMode == ShadowingMode.freeFlow,
                            onSelected: (val) => setState(() => _selectedMode = ShadowingMode.freeFlow),
                            selectedColor: Colors.orange.shade200,
                            backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
                          ),
                          ChoiceChip(
                            label: const Text("Thematic"),
                            selected: _selectedMode == ShadowingMode.theme,
                            onSelected: (val) => setState(() => _selectedMode = ShadowingMode.theme),
                            selectedColor: Colors.orange.shade200,
                            backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
                          ),
                          ChoiceChip(
                            label: const Text("Deck (Flashcards)"),
                            selected: _selectedMode == ShadowingMode.deck,
                            onSelected: (val) => setState(() => _selectedMode = ShadowingMode.deck),
                            selectedColor: Colors.orange.shade200,
                            backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
                          ),
                          ChoiceChip(
                            label: const Text("Custom Word"),
                            selected: _selectedMode == ShadowingMode.customWord,
                            onSelected: (val) => setState(() => _selectedMode = ShadowingMode.customWord),
                            selectedColor: Colors.orange.shade200,
                            backgroundColor: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
                          ),
                        ],
                      ),
                      if (_selectedMode == ShadowingMode.customWord) ...[
                        const SizedBox(height: 16),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Enter characters (e.g. 欢迎)",
                            filled: true,
                            fillColor: isDark ? Colors.grey[900] : Colors.white,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                          ),
                          style: TextStyle(color: isDark ? Colors.white : Colors.black),
                          onChanged: (val) => setState(() => _customWordInput = val),
                        ),
                      ],
                      if (_selectedMode == ShadowingMode.theme) ...[
                        const SizedBox(height: 16),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedTheme,
                            dropdownColor: isDark ? Colors.grey[900] : Colors.white,
                            items: ["HSK 1", "HSK 2", "HSK 3", "Travel", "Business", "Food"].map((theme) => DropdownMenuItem(value: theme, child: Text(theme))).toList(),
                            onChanged: (val) {
                              if (val != null) setState(() => _selectedTheme = val);
                            },
                          ),
                        ),
                      ],
                      if (_selectedMode == ShadowingMode.deck) ...[
                        const SizedBox(height: 16),
                        ref.watch(deckControllerProvider).when(
                          data: (decks) {
                            if (decks.isEmpty) return const Text("No decks found.");
                            return DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedDeckId ?? decks.first.id,
                                dropdownColor: isDark ? Colors.grey[900] : Colors.white,
                                items: decks.map((d) => DropdownMenuItem(value: d.id, child: Text(d.name))).toList(),
                                onChanged: (val) {
                                  if (val != null) setState(() => _selectedDeckId = val);
                                },
                              ),
                            );
                          },
                          loading: () => const CircularProgressIndicator(strokeWidth: 2),
                          error: (e, st) => const Text("Error loading decks"),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              
              // Start Button Area
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      (isDark ? const Color(0xFF1A1A1A) : const Color(0xFFFDF5E6)).withValues(alpha: 0.0),
                      isDark ? const Color(0xFF1A1A1A) : const Color(0xFFFDF5E6),
                    ],
                  ),
                ),
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF9800), Color(0xFFF57C00)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withValues(alpha: 0.4),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _startSession,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.mic, size: 28, color: Colors.white),
                        SizedBox(width: 12),
                        Text(
                          "START SESSION",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionRow(IconData icon, String title, String subtitle, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: isDark ? Colors.orange.shade300 : Colors.orange.shade600, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white54 : Colors.black54,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    if (!_isSessionStarted) {
      return _buildHubUI(context, isDark);
    }

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.keyboard_arrow_down, size: 32, color: isDark ? Colors.white : const Color(0xFF1A1A1B)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Shadowing Studio",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF1A1A1B)),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                color: _isLive 
                    ? Colors.orange.withValues(alpha: 0.1) 
                    : (isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05)),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: _isLive ? Colors.orange.shade200 : Colors.transparent),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _isLive ? Icons.mic : Icons.mic_off,
                    color: _isLive ? Colors.orange.shade700 : (isDark ? Colors.white54 : Colors.black54),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _status,
                      style: TextStyle(
                        color: _isLive ? Colors.orange.shade900 : (isDark ? Colors.white70 : Colors.black87),
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: _transcript.isEmpty
                  ? Center(
                      child: Text(
                        "Speak English to translate and shadow...",
                        style: TextStyle(color: isDark ? Colors.white54 : Colors.black54, fontSize: 18),
                      ),
                    )
                  : PageView.builder(
                      itemCount: _transcript.length,
                      controller: PageController(initialPage: _transcript.length - 1),
                      itemBuilder: (context, index) {
                        final msg = _transcript[index];
                        return Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                msg.englishText,
                                style: TextStyle(
                                  fontSize: 22,
                                  color: isDark ? Colors.white54 : Colors.black54,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: 'serif',
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 48),
                              if (msg.mandarinTranslation.isNotEmpty) ...[
                                if (msg.pinyin != null && msg.pinyin!.isNotEmpty) ...[
                                  Text(
                                    msg.pinyin!,
                                    style: TextStyle(
                                      fontSize: 28,
                                      color: isDark ? Colors.white70 : Colors.black87,
                                      fontStyle: FontStyle.italic,
                                      letterSpacing: 1.2,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                ],
                                if (msg.pronunciationGrade != null && msg.pronunciationGrade!['breakdown'] != null) ...[
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    spacing: 4,
                                    children: (msg.pronunciationGrade!['breakdown'] as List).map<Widget>((item) {
                                      final isCorrect = item['isToneCorrect'] ?? true;
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            item['pinyin'] ?? "",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: isCorrect ? (isDark ? Colors.white54 : Colors.black54) : Colors.red,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                          Text(
                                            item['hanzi'] ?? "",
                                            style: TextStyle(
                                              fontSize: 64,
                                              color: isCorrect ? (isDark ? Colors.white : const Color(0xFF1A1A1B)) : Colors.red,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'NotoSerifSC',
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(height: 16),
                                  if (msg.pronunciationGrade!['overallScore'] != null)
                                    Text(
                                      "Score: ${msg.pronunciationGrade!['overallScore']}/100",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: msg.pronunciationGrade!['overallScore'] >= 80 ? Colors.green : Colors.orange,
                                      ),
                                    ),
                                  if (msg.pronunciationGrade!['feedback'] != null) ...[
                                    const SizedBox(height: 8),
                                    Text(
                                      msg.pronunciationGrade!['feedback'],
                                      style: TextStyle(fontSize: 16, color: isDark ? Colors.white70 : Colors.black87),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ] else ...[
                                  Text(
                                    msg.mandarinTranslation,
                                    style: TextStyle(
                                      fontSize: 64,
                                      color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'NotoSerifSC',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ] else ...[
                                const CircularProgressIndicator(color: Colors.orange),
                                const SizedBox(height: 16),
                                const Text("Translating...", style: TextStyle(color: Colors.orange)),
                              ]
                            ],
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 48.0, top: 24.0),
              child: GestureDetector(
                onTap: _toggleMic,
                child: AnimatedBuilder(
                  animation: _pulseAnimation ?? const AlwaysStoppedAnimation(1.0),
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation?.value ?? 1.0,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
                          boxShadow: [
                            BoxShadow(
                              color: _isLive 
                                  ? Colors.orange.withValues(alpha: 0.6) 
                                  : (isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.1)),
                              blurRadius: _isLive ? 32 : 16,
                              spreadRadius: _isLive ? 8 : 2,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.mic,
                          size: 36,
                          color: _isLive 
                              ? Colors.orange 
                              : (isDark ? Colors.white : const Color(0xFF1A1A1B)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
