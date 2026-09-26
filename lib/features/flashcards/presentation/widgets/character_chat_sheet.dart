import 'package:flutter/material.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/core/utils/pinyin_utils.dart';
import 'package:hanzi_master/shared/widgets/tappable_hanzi_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:hanzi_master/core/widgets/translated_definition.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/ai_consent_sheet.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';

// ---------------------------------------------------------------------------
// Data models
// ---------------------------------------------------------------------------

enum _ChipGroup {
  history,
  words,
  idioms,
  stroke,
  grammar,
  culture,
  radicals,
  tone,
}

typedef CharacterChatPrompt = ({String label, String prompt});

@visibleForTesting
List<CharacterChatPrompt> characterChatPrompts(AppLocalizations l10n) => [
      (
        label: l10n.originStoryChip,
        prompt: l10n.whatIsTheOracleBoneScriptOriginOfTh
      ),
      (
        label: l10n.ancientFormChip,
        prompt: l10n.howDidTheAncientFormOfThisCharacter
      ),
      (
        label: l10n.threeMoreWordsChip,
        prompt: l10n.giveMe3CommonWordsThatContainThisCh
      ),
      (
        label: l10n.wordFamilyChip,
        prompt: l10n.whatOtherCharactersShareTheSameRadi
      ),
      (
        label: l10n.idiomChip,
        prompt: l10n.isThereAChineseIdiomFeaturingThisCharacter
      ),
      (
        label: l10n.proverbChip,
        prompt: l10n.isThereAChineseProverbOrSayingFeatu
      ),
      (
        label: l10n.strokeOrderChip,
        prompt: l10n.explainTheStrokeOrderRulesForThisCh
      ),
      (
        label: l10n.calligraphyTipChip,
        prompt: l10n.giveMeOneCalligraphyTipForWritingTh
      ),
      (
        label: l10n.grammarNoteChip,
        prompt: l10n.isThereAnythingTrickyAboutUsingThis
      ),
      (
        label: l10n.similarWordsChip,
        prompt: l10n.whatWordsAreCommonlyConfusedWithThi
      ),
      (
        label: l10n.culturalNoteChip,
        prompt: l10n.doesThisCharacterCarryCulturalSymbo
      ),
      (
        label: l10n.inMediaChip,
        prompt: l10n.isThisCharacterCommonlySeenInChines
      ),
      (
        label: l10n.radicalMeaningChip,
        prompt: l10n.whatDoesTheRadicalOfThisCharacterMe
      ),
      (
        label: l10n.componentBreakdownChip,
        prompt: l10n.breakDownEveryComponentAndItsMeanin
      ),
      (
        label: l10n.toneTipChip,
        prompt: l10n.giveMeATrickToRememberTheCorrectTon
      ),
      (
        label: l10n.homophonesChip,
        prompt: l10n.areThereCommonHomophonesThatAreOfte
      ),
    ];

Map<_ChipGroup, List<CharacterChatPrompt>> _allChips(AppLocalizations l10n) {
  final prompts = characterChatPrompts(l10n);
  return {
    for (var i = 0; i < _ChipGroup.values.length; i++)
      _ChipGroup.values[i]: prompts.sublist(i * 2, i * 2 + 2),
  };
}

List<CharacterChatPrompt> _chipsForIndex(
    int replyIndex, AppLocalizations l10n) {
  const groups = _ChipGroup.values;
  final group1 = groups[replyIndex % groups.length];
  final group2 = groups[(replyIndex + 1) % groups.length];
  final group3 = groups[(replyIndex + 3) % groups.length];
  final chips = _allChips(l10n);
  return [
    chips[group1]![0],
    chips[group2]![0],
    chips[group3]![0],
  ];
}

class ChatMessage {
  final String text;
  final bool isUser;
  // ignore: library_private_types_in_public_api
  final List<CharacterChatPrompt> chips;
  ChatMessage(
      {required this.text, required this.isUser, this.chips = const []});
}

// ---------------------------------------------------------------------------
// Markdown → TextSpan renderer now handled by TappableMarkdownHanziText.
// ---------------------------------------------------------------------------

class _InkDots extends StatefulWidget {
  const _InkDots(); // ignore: prefer_const_constructors_in_immutables
  @override
  // ignore: library_private_types_in_public_api
  State<_InkDots> createState() => _InkDotsState();
}

class _InkDotsState extends State<_InkDots> with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _anims;

  /// Cached platform motion preference, refreshed in didChangeDependencies.
  bool _reduceMotion = false;

  @override
  void initState() {
    super.initState();
    // The repeats are deferred to didChangeDependencies, which is the only
    // place the platform "Reduce Motion" setting can be read.
    _controllers = List.generate(
        3,
        (i) => AnimationController(
              vsync: this,
              duration: ZenMotion.page,
            ));
    _anims = _controllers
        .map((c) => Tween(begin: 0.3, end: 1.0).animate(
              CurvedAnimation(parent: c, curve: ZenMotion.natural),
            ))
        .toList();
    // Stagger starts
    Future.delayed(const Duration(milliseconds: 0), () {
      if (mounted && !_reduceMotion) _controllers[0].forward();
    });
    Future.delayed(const Duration(milliseconds: 180), () {
      if (mounted && !_reduceMotion) _controllers[1].forward();
    });
    Future.delayed(const Duration(milliseconds: 360), () {
      if (mounted && !_reduceMotion) _controllers[2].forward();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reduceMotion = context.reduceMotion;
    // Reduced motion: the ink dots rest fully visible instead of cycling.
    for (final c in _controllers) {
      MotionResolution.resolve(
        context,
        controller: c,
        loop: true,
        staticValue: 1.0,
      ).apply();
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
          3,
          (i) => AnimatedBuilder(
                animation: _anims[i],
                builder: (_, __) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.indigo.withValues(alpha: _anims[i].value),
                  ),
                ),
              )),
    );
  }
}

// ---------------------------------------------------------------------------
// Main Drawer Widget
// ---------------------------------------------------------------------------

class CharacterChatSheet extends ConsumerStatefulWidget {
  final String hanzi;
  final String pinyin;
  final String definition;
  final String? definitionLanguage;
  final Future<String> Function(String message)? messageSender;

  const CharacterChatSheet({
    super.key,
    required this.hanzi,
    required this.pinyin,
    required this.definition,
    this.definitionLanguage,
    this.messageSender,
  });

  @override
  ConsumerState<CharacterChatSheet> createState() => _CharacterChatSheetState();
}

class _CharacterChatSheetState extends ConsumerState<CharacterChatSheet> {
  late AiChatSession _chatSession;
  bool _isSessionInitialized = false;
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _aiReplyCount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isSessionInitialized) {
      final langCode = Localizations.localeOf(context).languageCode;
      if (widget.messageSender == null) {
        _chatSession = ref
            .read(geminiServiceProvider)
            .startCharacterChat(widget.hanzi, langCode);
      }
      _isSessionInitialized = true;

      final l10n = AppLocalizations.of(context)!;
      _messages.add(ChatMessage(
        text: l10n.askMeAnythingAbout(widget.hanzi),
        isUser: false,
        chips: _chipsForIndex(0, l10n),
      ));
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    final consent = await AiConsentSheet.ensureConsent(context);
    if (!consent || !mounted) return;
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _isLoading = true;
    });
    _textController.clear();
    _scrollToBottom();

    try {
      if (widget.messageSender != null) {
        final rawText = await widget.messageSender!(text);
        if (rawText.isEmpty) throw Exception('Empty response');
        _addAiReply(rawText, l10n);
        return;
      }

      final user = FirebaseAuth.instance.currentUser;
      final userScope =
          (user != null && !user.isAnonymous) ? user.uid : 'guest';
      final cacheKey = '${widget.hanzi}_${userScope}_${text.hashCode}';
      final box = await Hive.openBox<String>('character_chat_cache');

      String rawText = '';
      if (box.containsKey(cacheKey)) {
        rawText = box.get(cacheKey)!;
      } else {
        rawText = await _chatSession.sendMessage(text);
        if (rawText.isEmpty) throw Exception('Empty response');
        await box.put(cacheKey, rawText);
      }

      _addAiReply(rawText, l10n);
    } catch (e) {
      final errorStr = e.toString();
      String userMessage = l10n.aiTutorError(errorStr);

      if (errorStr.contains('Quota exceeded') || errorStr.contains('429')) {
        userMessage = l10n.aiTutorRateLimit;
      }

      setState(() {
        _messages.add(ChatMessage(text: userMessage, isUser: false));
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  void _addAiReply(String text, AppLocalizations l10n) {
    _aiReplyCount++;
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: false,
        chips: _chipsForIndex(_aiReplyCount, l10n),
      ));
      _isLoading = false;
    });
    _scrollToBottom();
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final aiBubbleColor =
        isDark ? const Color(0xFF252525) : const Color(0xFFFFF8EE);
    final textColor = isDark ? Colors.white : const Color(0xFF1A1A1B);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final drawerWidth = screenWidth * 0.88;

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.85,
      child: SafeArea(
        top: false,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              const SizedBox(height: 8),

              // ── Header ────────────────────────────────────────────────────
              _buildHeader(isDark, textColor),

              // ── Character Info Box ─────────────────────────────────────────
              _buildCharacterBox(isDark, aiBubbleColor, textColor),

              // ── Message List ──────────────────────────────────────────────
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                  itemCount: _messages.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _messages.length) {
                      return _buildTypingIndicator(aiBubbleColor);
                    }
                    final msg = _messages[index];
                    return msg.isUser
                        ? _buildUserBubble(msg, drawerWidth, textColor)
                        : _buildAiBubble(
                            msg, aiBubbleColor, drawerWidth, textColor, isDark);
                  },
                ),
              ),

              // ── Input ─────────────────────────────────────────────────────
              _buildInputBar(isDark, textColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark, Color textColor) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: Colors.indigo.withValues(alpha: 0.12))),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, color: Colors.indigo, size: 18),
          const SizedBox(width: 8),
          // Expanded replaces the old Spacer so the localized title can wrap
          // instead of overflowing in longer languages.
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.scholarsDesk,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: textColor,
                letterSpacing: 0.3,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close,
                size: 20, color: textColor.withValues(alpha: 0.5)),
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterBox(bool isDark, Color aiBubbleColor, Color textColor) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 10, 12, 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.indigo.withValues(alpha: isDark ? 0.15 : 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.indigo.withValues(alpha: 0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.hanzi,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w300,
              color: Colors.indigo,
              height: 1,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  PinyinUtils.convertNumericToMarks(widget.pinyin),
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.indigo.withValues(alpha: 0.8),
                    fontStyle: FontStyle.italic,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 2),
                TranslatedDefinition(
                  definition: widget.definition,
                  definitionLanguage: widget.definitionLanguage,
                  hanzi: widget.hanzi,
                  originalStyle: TextStyle(
                    fontSize: 13,
                    color: textColor.withValues(alpha: 0.75),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAiBubble(ChatMessage msg, Color aiBubbleColor,
      double drawerWidth, Color textColor, bool isDark) {
    final bubbleColor = textColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8, bottom: 4),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          constraints: BoxConstraints(maxWidth: drawerWidth * 0.82),
          decoration: BoxDecoration(
            color: aiBubbleColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
              bottomRight: Radius.circular(18),
              bottomLeft: Radius.circular(4),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.06),
                blurRadius: 6,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: TappableMarkdownHanziText(
            msg.text,
            style: TextStyle(fontSize: 14.5, height: 1.5, color: bubbleColor),
          ),
        ),
        // Follow-up chips
        if (msg.chips.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: msg.chips
                  .map((chip) => GestureDetector(
                        onTap: () => _sendMessage(chip.prompt),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.indigo
                                .withValues(alpha: isDark ? 0.2 : 0.08),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Colors.indigo.withValues(alpha: 0.2)),
                          ),
                          child: Text(
                            chip.label,
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: Colors.indigo,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildUserBubble(
      ChatMessage msg, double drawerWidth, Color textColor) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(maxWidth: drawerWidth * 0.72),
        decoration: const BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(4),
          ),
        ),
        child: Text(
          msg.text,
          style: const TextStyle(
              color: Colors.white, fontSize: 14.5, height: 1.45),
        ),
      ),
    );
  }

  Widget _buildTypingIndicator(Color aiBubbleColor) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: aiBubbleColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomRight: Radius.circular(18),
            bottomLeft: Radius.circular(4),
          ),
        ),
        child: const _InkDots(),
      ),
    );
  }

  Widget _buildInputBar(bool isDark, Color textColor) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
        border: Border(
            top: BorderSide(color: Colors.indigo.withValues(alpha: 0.1))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.07)
                    : Colors.white,
                borderRadius: BorderRadius.circular(28),
                border:
                    Border.all(color: Colors.indigo.withValues(alpha: 0.15)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: HanziTextField(
                      controller: _textController,
                      style: TextStyle(fontSize: 14.5, color: textColor),
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!
                            .ask_about(widget.hanzi),
                        hintStyle: TextStyle(
                            color: textColor.withValues(alpha: 0.35),
                            fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 11),
                      ),
                      onSubmitted: _sendMessage,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: GestureDetector(
                      onTap: () => _sendMessage(_textController.text),
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: const BoxDecoration(
                          color: Colors.indigo,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_upward,
                            color: Colors.white, size: 18),
                      ),
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
