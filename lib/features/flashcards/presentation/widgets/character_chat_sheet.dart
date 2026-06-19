import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/core/utils/pinyin_utils.dart';
import 'package:hanzi_master/shared/widgets/tappable_hanzi_text.dart';

// ---------------------------------------------------------------------------
// Data models
// ---------------------------------------------------------------------------

enum _ChipGroup { history, words, idioms, stroke, grammar, culture, radicals, tone }

class _FollowUpChip {
  final String label;
  final String prompt;
  const _FollowUpChip(this.label, this.prompt);
}

const _allChips = <_ChipGroup, List<_FollowUpChip>>{
  _ChipGroup.history: [
    _FollowUpChip('📜 Origin story', 'What is the oracle bone script origin of this character?'),
    _FollowUpChip('🏺 Ancient form', 'How did the ancient form of this character evolve over time?'),
  ],
  _ChipGroup.words: [
    _FollowUpChip('📖 3 more words', 'Give me 3 common words that contain this character.'),
    _FollowUpChip('🔗 Word family', 'What other characters share the same radical?'),
  ],
  _ChipGroup.idioms: [
    _FollowUpChip('🀄 Idiom', 'Is there a popular Chinese idiom (成语) using this character?'),
    _FollowUpChip('💬 Proverb', 'Is there a Chinese proverb or saying featuring this character?'),
  ],
  _ChipGroup.stroke: [
    _FollowUpChip('✏️ Stroke order', 'Explain the stroke order rules for this character.'),
    _FollowUpChip('🎨 Calligraphy tip', 'Give me one calligraphy tip for writing this character beautifully.'),
  ],
  _ChipGroup.grammar: [
    _FollowUpChip('📝 Grammar note', 'Is there anything tricky about using this grammatically?'),
    _FollowUpChip('🔄 Similar words', 'What words are commonly confused with this one and why?'),
  ],
  _ChipGroup.culture: [
    _FollowUpChip('🏮 Cultural note', 'Does this character carry cultural symbolism in China?'),
    _FollowUpChip('🀄 In media', 'Is this character commonly seen in Chinese movies, songs, or texts?'),
  ],
  _ChipGroup.radicals: [
    _FollowUpChip('🧩 Radical meaning', 'What does the radical of this character mean?'),
    _FollowUpChip('🔍 Component breakdown', 'Break down every component and its meaning.'),
  ],
  _ChipGroup.tone: [
    _FollowUpChip('🎵 Tone tip', 'Give me a trick to remember the correct tone for this character.'),
    _FollowUpChip('👯 Homophones', 'Are there common homophones that are often confused with this?'),
  ],
};

List<_FollowUpChip> _chipsForIndex(int replyIndex) {
  const groups = _ChipGroup.values;
  final group1 = groups[replyIndex % groups.length];
  final group2 = groups[(replyIndex + 1) % groups.length];
  final group3 = groups[(replyIndex + 3) % groups.length];
  return [
    _allChips[group1]![0],
    _allChips[group2]![0],
    _allChips[group3]![0],
  ];
}

class ChatMessage {
  final String text;
  final bool isUser;
  // ignore: library_private_types_in_public_api
  final List<_FollowUpChip> chips;
  ChatMessage({required this.text, required this.isUser, this.chips = const []});
}

// ---------------------------------------------------------------------------
// Markdown → TextSpan renderer now handled by TappableMarkdownHanziText.
// ---------------------------------------------------------------------------

class _InkDots extends StatefulWidget {
  const _InkDots();  // ignore: prefer_const_constructors_in_immutables
  @override
  // ignore: library_private_types_in_public_api
  State<_InkDots> createState() => _InkDotsState();
}

class _InkDotsState extends State<_InkDots> with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _anims;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (i) => AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true, period: Duration(milliseconds: 900 + i * 200)));
    _anims = _controllers.map((c) => Tween(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: c, curve: Curves.easeInOut),
    )).toList();
    // Stagger starts
    Future.delayed(const Duration(milliseconds: 0),  () { if (mounted) _controllers[0].forward(); });
    Future.delayed(const Duration(milliseconds: 180), () { if (mounted) _controllers[1].forward(); });
    Future.delayed(const Duration(milliseconds: 360), () { if (mounted) _controllers[2].forward(); });
  }

  @override
  void dispose() {
    for (final c in _controllers) { c.dispose(); }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) => AnimatedBuilder(
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

  const CharacterChatSheet({
    super.key,
    required this.hanzi,
    required this.pinyin,
    required this.definition,
  });

  @override
  ConsumerState<CharacterChatSheet> createState() => _CharacterChatSheetState();
}

class _CharacterChatSheetState extends ConsumerState<CharacterChatSheet> {
  late final AiChatSession _chatSession;
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _aiReplyCount = 0;

  @override
  void initState() {
    super.initState();
    final langCode = Localizations.localeOf(context).languageCode;
    _chatSession = ref.read(geminiServiceProvider).startCharacterChat(widget.hanzi, langCode);
    _messages.add(ChatMessage(
      text: 'Ask me anything about **${widget.hanzi}** — history, usage, culture, or grammar.',
      isUser: false,
      chips: _chipsForIndex(0),
    ));
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _isLoading = true;
    });
    _textController.clear();
    _scrollToBottom();

    try {
      final rawText = await _chatSession.sendMessage(text);
      if (rawText.isEmpty) throw Exception('Empty response');
      _aiReplyCount++;
      setState(() {
        _messages.add(ChatMessage(
          text: rawText,
          isUser: false,
          chips: _chipsForIndex(_aiReplyCount),
        ));
        _isLoading = false;
      });
      _scrollToBottom();
    } catch (e) {
      final errorStr = e.toString();
      String userMessage = 'Error reaching tutor: $errorStr';
      
      if (errorStr.contains('Quota exceeded') || errorStr.contains('429')) {
        userMessage = '⏳ Whoa there! The AI tutor is taking a breather (Google API Free Tier limits). Please wait about 30 seconds before asking another question!';
      }

      setState(() {
        _messages.add(ChatMessage(text: userMessage, isUser: false));
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);
    final aiBubbleColor = isDark ? const Color(0xFF252525) : const Color(0xFFFFF8EE);
    final textColor = isDark ? Colors.white : const Color(0xFF1A1A1B);
    final screenWidth = MediaQuery.of(context).size.width;
    final drawerWidth = screenWidth * 0.88;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: SafeArea(
        top: false,
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
                      : _buildAiBubble(msg, aiBubbleColor, drawerWidth, textColor, isDark);
                },
              ),
            ),

            // ── Input ─────────────────────────────────────────────────────
            _buildInputBar(isDark, textColor),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark, Color textColor) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.indigo.withValues(alpha: 0.12))),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, color: Colors.indigo, size: 18),
          const SizedBox(width: 8),
          Text(
            "Scholar's Desk",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: textColor,
              letterSpacing: 0.3,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.close, size: 20, color: textColor.withValues(alpha: 0.5)),
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
                Text(
                  widget.definition,
                  style: TextStyle(
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

  Widget _buildAiBubble(ChatMessage msg, Color aiBubbleColor, double drawerWidth, Color textColor, bool isDark) {
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
              children: msg.chips.map((chip) => GestureDetector(
                onTap: () => _sendMessage(chip.prompt),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withValues(alpha: isDark ? 0.2 : 0.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.indigo.withValues(alpha: 0.2)),
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
              )).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildUserBubble(ChatMessage msg, double drawerWidth, Color textColor) {
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
          style: const TextStyle(color: Colors.white, fontSize: 14.5, height: 1.45),
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
        border: Border(top: BorderSide(color: Colors.indigo.withValues(alpha: 0.1))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withValues(alpha: 0.07) : Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: Colors.indigo.withValues(alpha: 0.15)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      style: TextStyle(fontSize: 14.5, color: textColor),
                      decoration: InputDecoration(
                        hintText: 'Ask about ${widget.hanzi}...',
                        hintStyle: TextStyle(color: textColor.withValues(alpha: 0.35), fontSize: 14),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
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
                        child: const Icon(Icons.arrow_upward, color: Colors.white, size: 18),
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
