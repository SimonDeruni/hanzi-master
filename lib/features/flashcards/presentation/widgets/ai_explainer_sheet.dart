import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/shared/widgets/tappable_hanzi_text.dart';
import 'package:hanzi_master/shared/widgets/global_blurred_bottom_sheet.dart';

class _FollowUpChip {
  final String label;
  final String prompt;
  const _FollowUpChip(this.label, this.prompt);
}

class _ChatMessage {
  final String text;
  final bool isUser;
  final List<_FollowUpChip> chips;
  _ChatMessage({required this.text, required this.isUser, this.chips = const []});
}

class _InkDots extends StatefulWidget {
  const _InkDots();
  @override
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
            color: Colors.blueAccent.withValues(alpha: _anims[i].value),
          ),
        ),
      )),
    );
  }
}

class AiExplainerSheet extends ConsumerStatefulWidget {
  final AiWord word;
  final AiSentence sentence;

  const AiExplainerSheet({super.key, required this.word, required this.sentence});

  static void show(BuildContext context, AiWord word, AiSentence sentence) {
    GlobalBlurredBottomSheet.show(
      context,
      child: AiExplainerSheet(word: word, sentence: sentence),
    );
  }

  @override
  ConsumerState<AiExplainerSheet> createState() => _AiExplainerSheetState();
}

class _AiExplainerSheetState extends ConsumerState<AiExplainerSheet> {
  late final AiChatSession _chatSession;
  final List<_ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _aiReplyCount = 0;

  final List<List<_FollowUpChip>> _grammarChips = [
    [
      const _FollowUpChip('📝 More examples', 'Can you give me two more examples using this word?'),
      const _FollowUpChip('🔄 Similar words', 'What are some similar words and how do they differ?'),
    ],
    [
      const _FollowUpChip('❓ Usage', 'Is this word used in spoken or written Chinese more?'),
      const _FollowUpChip('💬 Translation', 'Are there other ways to translate this word?'),
    ],
    [
      const _FollowUpChip('📚 Collocations', 'What are common words that go together with this word?'),
      const _FollowUpChip('❌ Mistakes', 'What are common mistakes learners make with this word?'),
    ]
  ];

  @override
  void initState() {
    super.initState();
    final langCode = Localizations.localeOf(context).languageCode;
    _chatSession = ref.read(geminiServiceProvider).startGrammarChat(widget.word.hanzi, widget.sentence.chinese, langCode);
    _sendMessage("Explain the grammatical role and usage of the word \"${widget.word.hanzi}\" in the following sentence:\n\"${widget.sentence.chinese}\"", isInitial: true);
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage(String text, {bool isInitial = false}) async {
    if (text.trim().isEmpty) return;
    
    if (!isInitial) {
      setState(() {
        _messages.add(_ChatMessage(text: text, isUser: true));
        _isLoading = true;
      });
      _textController.clear();
      _scrollToBottom();
    } else {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      final rawText = await _chatSession.sendMessage(text);
      if (rawText.isEmpty) throw Exception('Empty response');
      
      final chips = _grammarChips[_aiReplyCount % _grammarChips.length];
      _aiReplyCount++;
      
      setState(() {
        _messages.add(_ChatMessage(
          text: rawText,
          isUser: false,
          chips: chips,
        ));
        _isLoading = false;
      });
      _scrollToBottom();
    } catch (e) {
      setState(() {
        _messages.add(_ChatMessage(text: 'Error getting explanation: $e', isUser: false));
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
            _buildHeader(isDark, textColor),
            _buildContextBox(isDark, textColor),
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
        border: Border(bottom: BorderSide(color: Colors.blueAccent.withValues(alpha: 0.12))),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, color: Colors.blueAccent, size: 18),
          const SizedBox(width: 8),
          Text(
            "AI Grammar Explanation",
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

  Widget _buildContextBox(bool isDark, Color textColor) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 10, 12, 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withValues(alpha: isDark ? 0.15 : 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.sentence.chinese,
            style: TextStyle(
              fontFamily: 'NotoSerifSC',
              fontSize: 16,
              color: textColor.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 13,
                color: textColor.withValues(alpha: 0.6),
              ),
              children: [
                const TextSpan(text: "Explaining: "),
                TextSpan(
                  text: widget.word.hanzi,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAiBubble(_ChatMessage msg, Color aiBubbleColor, double drawerWidth, Color textColor, bool isDark) {
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
            style: TextStyle(fontSize: 14.5, height: 1.5, color: textColor),
          ),
        ),
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
                    color: Colors.blueAccent.withValues(alpha: isDark ? 0.2 : 0.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.2)),
                  ),
                  child: Text(
                    chip.label,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: Colors.blueAccent,
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

  Widget _buildUserBubble(_ChatMessage msg, double drawerWidth, Color textColor) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(maxWidth: drawerWidth * 0.72),
        decoration: const BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(4),
          ),
        ),
        child: Text(
          msg.text,
          style: const TextStyle(fontSize: 14.5, color: Colors.white, height: 1.3),
        ),
      ),
    );
  }

  Widget _buildTypingIndicator(Color aiBubbleColor) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        border: Border(top: BorderSide(color: textColor.withValues(alpha: 0.08))),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: "Ask a follow-up question...",
                hintStyle: TextStyle(color: textColor.withValues(alpha: 0.4), fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: textColor.withValues(alpha: 0.05),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                isDense: true,
              ),
              style: TextStyle(fontSize: 14, color: textColor),
              textInputAction: TextInputAction.send,
              onSubmitted: _isLoading ? null : (val) => _sendMessage(val),
            ),
          ),
          const SizedBox(width: 8),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _textController,
            builder: (context, value, child) {
              final canSend = value.text.trim().isNotEmpty && !_isLoading;
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: canSend ? () => _sendMessage(_textController.text) : null,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: canSend ? Colors.blueAccent : textColor.withValues(alpha: 0.05),
                    ),
                    child: Icon(
                      Icons.arrow_upward,
                      color: canSend ? Colors.white : textColor.withValues(alpha: 0.2),
                      size: 20,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
