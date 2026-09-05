import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/speech_service.dart';
import 'package:hanzi_master/features/live_translate/domain/entities/translation_message.dart';
import 'package:hanzi_master/features/premium/presentation/screens/universal_scanner_screen.dart';
import 'package:hanzi_master/core/providers/translation_language_provider.dart';
import 'package:hanzi_master/shared/widgets/tappable_hanzi_text.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class TravelInterpreterScreen extends ConsumerStatefulWidget {
  const TravelInterpreterScreen({super.key});

  @override
  ConsumerState<TravelInterpreterScreen> createState() =>
      _TravelInterpreterScreenState();
}

class _TravelInterpreterScreenState
    extends ConsumerState<TravelInterpreterScreen>
    with SingleTickerProviderStateMixin {
  late String _status;
  bool _hasError = false;
  String? _recordingSide; // null = idle, 'a' = User mic, 'b' = Partner mic
  bool _isStopping = false;
  String _liveTranscription =
      ''; // tracks latest partial text so stop() can use it

  // Side language state (decoupled from global provider)
  late String _sideALanguage;
  late String _sideBLanguage;

  // Input modes per side
  bool _isSideAKeyboardMode = false;

  final TextEditingController _sideATextController = TextEditingController();
  bool _isTranslatingText = false;

  final List<TranslationMessage> _messages = [];

  // Message filtering by sideId
  List<TranslationMessage> get _sideAMessages =>
      _messages.where((msg) => msg.sideId == 'a').toList();

  List<TranslationMessage> get _sideBMessages =>
      _messages.where((msg) => msg.sideId == 'b').toList();

  bool _isSessionStarted = true;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _status = 'Ready';
    _sideALanguage = 'English';
    _sideBLanguage = 'Mandarin';

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _initAudioAndConnect();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = AppLocalizations.of(context);
    if (l10n != null) {
      if (_status == 'Ready') _status = l10n.ready;
    }
  }

  void _startSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_travel_hub', true);

    if (!mounted) return;
    setState(() => _isSessionStarted = true);
    _initAudioAndConnect();
  }

  Future<void> _initAudioAndConnect() async {
    final speechService = ref.read(speechServiceProvider);
    await speechService.init();
    if (mounted) {
      final l10n = AppLocalizations.of(context);
      setState(() {
        _status = l10n?.readyToInterpret ?? 'Ready to interpret';
      });
    }
  }

  Future<void> _startAudioStreaming(String sideId) async {
    if (_recordingSide != null || _isStopping) return;

    final lang = sideId == 'a' ? _sideALanguage : _sideBLanguage;

    setState(() {
      _recordingSide = sideId;
      _status = sideId == 'b'
          ? AppLocalizations.of(context)!.partnerListening
          : AppLocalizations.of(context)!.listening;

      // Insert an empty draft message for the user's live transcription
      _messages.add(TranslationMessage(
        text: "",
        isUser: true,
        sideId: sideId,
        language: lang,
      ));
    });

    final speechService = ref.read(speechServiceProvider);

    String localeId = 'en_US';
    if (lang == AppLocalizations.of(context)!.mandarin || lang == 'Chinese') {
      localeId = 'zh_CN';
    } else if (lang == 'Spanish') {
      localeId = 'es_ES';
    } else if (lang == 'French') {
      localeId = 'fr_FR';
    } else if (lang == 'German') {
      localeId = 'de_DE';
    } else if (lang == 'Japanese') {
      localeId = 'ja_JP';
    } else if (lang == 'Korean') {
      localeId = 'ko_KR';
    }

    try {
      await speechService.startListening(
        localeId: localeId,
        listenFor: const Duration(seconds: 60),
        pauseFor: const Duration(seconds: 3),
        onResult: (text) {
          // Final result confirmed by the engine
          _liveTranscription = text;
          if (mounted &&
              _messages.isNotEmpty &&
              _messages.last.isUser &&
              _messages.last.sideId == sideId) {
            setState(() {
              _messages[_messages.length - 1] = TranslationMessage(
                text: text,
                isUser: true,
                sideId: sideId,
                language: lang,
              );
            });
          }
        },
        onPartialResult: (text) {
          // Live captions — update draft bubble as the user speaks
          if (text.isEmpty) return;
          _liveTranscription = text;
          if (mounted &&
              _messages.isNotEmpty &&
              _messages.last.isUser &&
              _messages.last.sideId == sideId) {
            setState(() {
              _messages[_messages.length - 1] = TranslationMessage(
                text: text,
                isUser: true,
                sideId: sideId,
                language: lang,
              );
            });
          }
        },
        onError: (errorMsg, permanent) {
          if (mounted) {
            setState(() {
              _hasError = true;
              _status = 'Speech error: $errorMsg';
            });
          }
        },
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _recordingSide = null;
          _status = "Microphone error: $e";
          // Remove draft message on error
          if (_messages.isNotEmpty &&
              _messages.last.isUser &&
              _messages.last.text.isEmpty) {
            _messages.removeLast();
          }
        });
      }
    }
  }

  Future<void> _stopAudioStreaming({bool keepStatus = false}) async {
    if (_isStopping || _recordingSide == null) return;
    _isStopping = true;

    final speechService = ref.read(speechServiceProvider);
    await speechService.stopListening();

    final finalSide = _recordingSide;

    String finalText = "";
    if (_messages.isNotEmpty &&
        _messages.last.isUser &&
        _messages.last.sideId == finalSide) {
      finalText = _messages.last.text.trim();
      if (finalText.isEmpty) {
        // Remove empty drafts
        setState(() {
          _messages.removeLast();
        });
      }
    }

    setState(() {
      _recordingSide = null;
      _isStopping = false;
      if (!keepStatus) _status = "Paused";
    });

    // If finalResult never fired (e.g. session stopped before engine confirmed),
    // use the last known partial text instead so the message isn't silently dropped.
    if (finalText.isEmpty && _liveTranscription.isNotEmpty) {
      finalText = _liveTranscription.trim();
      // Update the draft bubble with the recovered text
      if (_messages.isNotEmpty &&
          _messages.last.isUser &&
          _messages.last.sideId == finalSide &&
          _messages.last.text.isEmpty &&
          finalSide != null) {
        setState(() {
          _messages[_messages.length - 1] = TranslationMessage(
            text: finalText,
            isUser: true,
            sideId: finalSide,
            language: finalSide == 'a' ? _sideALanguage : _sideBLanguage,
          );
        });
      }
    }
    _liveTranscription = '';

    if (finalText.isNotEmpty && finalSide != null) {
      _sendTextTranslation(finalText, sideId: finalSide);
    }
  }

  /// Send a text translation with explicit source→target routing.
  /// [sideId] determines source language: 'a' → _sideALanguage→_sideBLanguage, 'b' → _sideBLanguage→_sideALanguage.
  Future<void> _sendTextTranslation(String text,
      {required String sideId}) async {
    if (text.trim().isEmpty) return;

    final sourceLang = sideId == 'a' ? _sideALanguage : _sideBLanguage;
    final targetLang = sideId == 'a' ? _sideBLanguage : _sideALanguage;

    // Add sender's text immediately
    setState(() {
      _messages.add(TranslationMessage(
        text: text,
        isUser: sideId == 'a',
        sideId: sideId,
        language: sourceLang,
      ));
      _isTranslatingText = true;
      _status = "Translating...";
    });

    try {
      final geminiService = ref.read(geminiServiceProvider);
      final response = await geminiService
          .makeOpenRouterCall(model: 'google/gemini-2.5-flash', messages: [
        {
          "role": "system",
          "content":
              "You are a Real-time Travel Interpreter. Translate the following text from $sourceLang to $targetLang. Be conversational and helpful. Output text ONLY. Do not include pinyin in the main response."
        },
        {"role": "user", "content": text}
      ]);

      if (mounted) {
        setState(() {
          _messages.add(TranslationMessage(
            text: response,
            isUser: false,
            sideId: sideId == 'a' ? 'b' : 'a',
            language: targetLang,
          ));
          _isTranslatingText = false;
          _status = _recordingSide != null
              ? AppLocalizations.of(context)!.listening
              : "Paused";
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isTranslatingText = false;
          _status = "Translation failed";
        });
      }
    }
  }

  /// Shows a full-screen overlay for Side B (partner) to type using the system keyboard.
  void _showPartnerKeyboard() {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final controller = TextEditingController();
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: Container(
            height: MediaQuery.of(ctx).size.height * 0.5,
            decoration: const BoxDecoration(
              color: Color(0xFF1E1313),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              children: [
                // Handle bar
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Label
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Text(
                    "Type in $_sideBLanguage",
                    style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                // Text field
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: HanziTextField(
                      controller: controller,
                      autofocus: true,
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      decoration: InputDecoration(
                        hintText:
                            AppLocalizations.of(context)!.type_your_message_in,
                        hintStyle: const TextStyle(color: Colors.white24),
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.08),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                // Send button
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        final text = controller.text.trim();
                        if (text.isNotEmpty) {
                          _sendTextTranslation(text, sideId: 'b');
                        }
                        Navigator.pop(ctx);
                      },
                      child: Text(AppLocalizations.of(context)!.send,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Widget _buildHubUI(BuildContext context, bool isDark) {
    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back,
                        color: isDark ? Colors.white : Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const Spacer(),
            Icon(Icons.translate,
                size: 80, color: Colors.blueAccent.withValues(alpha: 0.8)),
            const SizedBox(height: 32),
            Text(
              "Travel Interpreter",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Text(
                "Real-time bidirectional translation. Speak English or Mandarin, and it will instantly translate for you and your partner.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? Colors.white70 : Colors.black54,
                  height: 1.5,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: GestureDetector(
                onTap: _startSession,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blueAccent.shade700,
                        Colors.blueAccent.shade400
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "Start Session",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBar(bool isDark) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.8)
                  : Colors.white.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.15)
                      : Colors.black.withValues(alpha: 0.1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Side B (Partner) mic button
                _buildMicButton(
                  sideId: 'b',
                  label: AppLocalizations.of(context)!.partner1,
                  isActive: _recordingSide == 'b',
                  isDark: isDark,
                ),
                // Status text
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _status,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _hasError
                              ? Colors.redAccent
                              : (isDark ? Colors.white70 : Colors.black87),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (_isTranslatingText)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: isDark ? Colors.white54 : Colors.black54,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                // Side A (User) mic button
                _buildMicButton(
                  sideId: 'a',
                  label: AppLocalizations.of(context)!.youLabel,
                  isActive: _recordingSide == 'a',
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMicButton({
    required String sideId,
    required String label,
    required bool isActive,
    required bool isDark,
  }) {
    return GestureDetector(
      onTapDown: (_) {
        if (_recordingSide != null) {
          _stopAudioStreaming();
        }
        _startAudioStreaming(sideId);
      },
      onTapUp: (_) => _stopAudioStreaming(),
      onTapCancel: () => _stopAudioStreaming(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isActive
              ? Colors.redAccent
              : (isDark
                  ? Colors.white.withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: 0.05)),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.redAccent.withValues(alpha: 0.4),
                    blurRadius: 16,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.mic,
              color: isActive
                  ? Colors.white
                  : (isDark ? Colors.white70 : Colors.black54),
              size: 24,
            ),
            Text(
              label,
              style: TextStyle(
                color: isActive
                    ? Colors.white
                    : (isDark ? Colors.white54 : Colors.black87),
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!_isSessionStarted) {
      return _buildHubUI(context, isDark);
    }

    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFFFDFCF0),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              // Top Half (Side B - Partner, Rotated 180 degrees)
              Expanded(
                child: RotatedBox(
                  quarterTurns: 2,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    color: isDark
                        ? (_recordingSide != null
                            ? const Color(0xFF3E1F1F)
                            : const Color(0xFF1E1313))
                        : (_recordingSide != null
                            ? const Color(0xFFFDE8E8)
                            : const Color(0xFFFDFCF0)),
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, bottom: 24, top: 64),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                // Side B language dropdown — locked to Partner (Mandarin/Chinese) only
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _sideBLanguage,
                                    icon: Icon(Icons.language,
                                        color: isDark
                                            ? Colors.white70
                                            : Colors.black87),
                                    dropdownColor: isDark
                                        ? Colors.grey[900]
                                        : Colors.white,
                                    style: TextStyle(
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                    items: supportedPartnerLanguages
                                        .map((lang) => DropdownMenuItem(
                                            value: lang,
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .partnerLang(lang))))
                                        .toList(),
                                    onChanged: (val) {
                                      if (val != null) {
                                        setState(() => _sideBLanguage = val);
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Side B keyboard button → triggers Pass the Phone overlay
                                IconButton(
                                  icon: Icon(
                                    Icons.keyboard,
                                    color: isDark
                                        ? Colors.white54
                                        : Colors.black54,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    if (_recordingSide != null) {
                                      _stopAudioStreaming();
                                    }
                                    _showPartnerKeyboard();
                                  },
                                ),
                              ],
                            ),
                            if (_recordingSide != null)
                              Row(
                                children: [
                                  const Icon(Icons.mic,
                                      color: Colors.redAccent, size: 16),
                                  const SizedBox(width: 8),
                                  Text(
                                      AppLocalizations.of(context)!
                                          .partnerSpeaking,
                                      style: const TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: ListView.builder(
                            reverse: true,
                            padding: const EdgeInsets.only(bottom: 100),
                            itemCount: _sideBMessages.length,
                            itemBuilder: (context, index) {
                              final msg = _sideBMessages[
                                  _sideBMessages.length - 1 - index];
                              final isFromSideB = msg.sideId == 'b';
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  crossAxisAlignment: isFromSideB
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isFromSideB
                                          ? AppLocalizations.of(context)!
                                              .partnerLang(msg.language)
                                          : AppLocalizations.of(context)!
                                              .youLang(msg.language),
                                      style: TextStyle(
                                          color: isDark
                                              ? Colors.white38
                                              : Colors.black38,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 16),
                                      decoration: BoxDecoration(
                                        color: isFromSideB
                                            ? (isDark
                                                ? Colors.blue
                                                    .withValues(alpha: 0.1)
                                                : Colors.blue
                                                    .withValues(alpha: 0.05))
                                            : (isDark
                                                ? Colors.grey
                                                    .withValues(alpha: 0.1)
                                                : Colors.grey
                                                    .withValues(alpha: 0.05)),
                                        borderRadius: BorderRadius.only(
                                          topLeft: const Radius.circular(24),
                                          topRight: const Radius.circular(24),
                                          bottomLeft: Radius.circular(
                                              isFromSideB ? 24 : 4),
                                          bottomRight: Radius.circular(
                                              isFromSideB ? 4 : 24),
                                        ),
                                        border: Border.all(
                                            color: isFromSideB
                                                ? Colors.blue
                                                    .withValues(alpha: 0.3)
                                                : Colors.grey
                                                    .withValues(alpha: 0.2)),
                                      ),
                                      child: TappableMarkdownHanziText(
                                        msg.text,
                                        quickLookPresentation:
                                            QuickLookPresentation
                                                .readingPopover,
                                        style: TextStyle(
                                          color: isFromSideB
                                              ? (isDark
                                                  ? Colors.blue.shade200
                                                  : Colors.blue.shade800)
                                              : (isDark
                                                  ? Colors.white
                                                  : Colors.black87),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom Half (Side A - User)
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  color: isDark
                      ? (_recordingSide != null
                          ? const Color(0xFF152A3B)
                          : const Color(0xFF121A20))
                      : (_recordingSide != null
                          ? const Color(0xFFE3F2FD)
                          : const Color(0xFFF8F9FA)),
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, bottom: 24, top: 64),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              // Side A language dropdown
                              DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _sideALanguage,
                                  icon: Icon(Icons.language,
                                      color: isDark
                                          ? Colors.white70
                                          : Colors.black87),
                                  dropdownColor:
                                      isDark ? Colors.grey[900] : Colors.white,
                                  style: TextStyle(
                                      color:
                                          isDark ? Colors.white : Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  items: supportedTranslationLanguages
                                      .map((lang) => DropdownMenuItem(
                                          value: lang,
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .youLang(lang))))
                                      .toList(),
                                  onChanged: (val) {
                                    if (val != null) {
                                      setState(() => _sideALanguage = val);
                                    }
                                  },
                                ),
                              ),
                              // Side A keyboard toggle
                              IconButton(
                                icon: Icon(
                                  Icons.keyboard,
                                  color: _isSideAKeyboardMode
                                      ? Colors.blueAccent
                                      : (isDark
                                          ? Colors.white54
                                          : Colors.black54),
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isSideAKeyboardMode =
                                        !_isSideAKeyboardMode;
                                    if (_isSideAKeyboardMode &&
                                        _recordingSide != null) {
                                      _stopAudioStreaming();
                                    }
                                  });
                                },
                              ),
                              if (_recordingSide != null)
                                Row(
                                  children: [
                                    const Icon(Icons.circle,
                                        color: Colors.redAccent, size: 12),
                                    const SizedBox(width: 8),
                                    Text(
                                        AppLocalizations.of(context)!
                                            .youAreSpeaking,
                                        style: const TextStyle(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.camera_alt,
                                    color:
                                        isDark ? Colors.white : Colors.black87),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    SwipeBackPageRoute(
                                        builder: (_) =>
                                            const UniversalScannerScreen(
                                                intent: CameraIntent.travelAR)),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.close,
                                    color:
                                        isDark ? Colors.white : Colors.black87),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          padding: const EdgeInsets.only(bottom: 100),
                          itemCount: _sideAMessages.length,
                          itemBuilder: (context, index) {
                            final msg = _sideAMessages[
                                _sideAMessages.length - 1 - index];
                            final isFromSideA = msg.sideId == 'a';
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: isFromSideA
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isFromSideA
                                        ? AppLocalizations.of(context)!
                                            .youLang(msg.language)
                                        : AppLocalizations.of(context)!
                                            .partnerLang(msg.language),
                                    style: TextStyle(
                                        color: isDark
                                            ? Colors.white38
                                            : Colors.black38,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 16),
                                    decoration: BoxDecoration(
                                      color: isFromSideA
                                          ? (isDark
                                              ? Colors.blue
                                                  .withValues(alpha: 0.1)
                                              : Colors.blue
                                                  .withValues(alpha: 0.05))
                                          : (isDark
                                              ? Colors.grey
                                                  .withValues(alpha: 0.1)
                                              : Colors.grey
                                                  .withValues(alpha: 0.05)),
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(24),
                                        topRight: const Radius.circular(24),
                                        bottomLeft: Radius.circular(
                                            isFromSideA ? 24 : 4),
                                        bottomRight: Radius.circular(
                                            isFromSideA ? 4 : 24),
                                      ),
                                      border: Border.all(
                                          color: isFromSideA
                                              ? Colors.blue
                                                  .withValues(alpha: 0.3)
                                              : Colors.grey
                                                  .withValues(alpha: 0.2)),
                                    ),
                                    child: TappableMarkdownHanziText(
                                      msg.text,
                                      quickLookPresentation:
                                          QuickLookPresentation.readingPopover,
                                      style: TextStyle(
                                        color: isFromSideA
                                            ? (isDark
                                                ? Colors.white
                                                : Colors.black87)
                                            : (isDark
                                                ? Colors.blue.shade200
                                                : Colors.blue.shade800),
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      if (_isSideAKeyboardMode)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: HanziTextField(
                            controller: _sideATextController,
                            style: TextStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontSize: 18),
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!.type_in,
                              hintStyle: TextStyle(
                                  color:
                                      isDark ? Colors.white38 : Colors.black38),
                              filled: true,
                              fillColor: isDark
                                  ? Colors.white.withValues(alpha: 0.1)
                                  : Colors.black.withValues(alpha: 0.05),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.send,
                                    color: Colors.blueAccent),
                                onPressed: _isTranslatingText
                                    ? null
                                    : () {
                                        _sendTextTranslation(
                                            _sideATextController.text,
                                            sideId: 'a');
                                        _sideATextController.clear();
                                      },
                              ),
                            ),
                            onSubmitted: _isTranslatingText
                                ? null
                                : (val) {
                                    _sendTextTranslation(val, sideId: 'a');
                                    _sideATextController.clear();
                                  },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // The Floating Center Control Bar (only visible when not in keyboard typing mode)
          if (!_isSideAKeyboardMode) _buildStatusBar(isDark),
        ],
      ),
    );
  }
}
