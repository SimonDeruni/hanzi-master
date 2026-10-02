import 'package:flutter/material.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/core/utils/network_failure.dart';
import 'package:hanzi_master/core/utils/pinyin_utils.dart';
import 'package:hanzi_master/shared/widgets/network_notice.dart';
import 'package:hanzi_master/shared/widgets/tappable_hanzi_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:hanzi_master/core/widgets/translated_definition.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/ai_consent_sheet.dart';
import 'package:hanzi_master/shared/widgets/chat_motion.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/scholar_stroke_lesson.dart';

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

/// A structured artefact the Scholar can attach to a reply instead of prose —
/// a real widget built from the app's own data (the stroke skeletons on the
/// card), so "explain the stroke order" answers by *showing* it.
enum ScholarArtefact { strokeOrder }

class ChatMessage {
  /// Stable identity, so a bubble animates in exactly once as it is appended.
  final int id;
  final String text;
  final bool isUser;
  // ignore: library_private_types_in_public_api
  final List<CharacterChatPrompt> chips;

  /// Optional mini-lesson rendered under the bubble.
  final ScholarArtefact? artefact;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isUser,
    this.chips = const [],
    this.artefact,
  });
}

// ---------------------------------------------------------------------------
// Markdown → TextSpan renderer now handled by TappableMarkdownHanziText.
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// The bubble entrance and the typing dots now live in
// `shared/widgets/chat_motion.dart`, so the Bureau du savant and the Echo Hall
// roleplay transcripts animate identically.
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// Main Drawer Widget
// ---------------------------------------------------------------------------

class CharacterChatSheet extends ConsumerStatefulWidget {
  final String hanzi;
  final String pinyin;
  final String definition;
  final String? definitionLanguage;
  final Future<String> Function(String message)? messageSender;

  /// Stroke skeletons, so a stroke-order answer can *show* the animation rather
  /// than only describe it. Empty when the caller has no hydrated card.
  final List<String> strokePaths;
  final List<List<Offset>> medianPaths;
  final bool isFlipped;

  /// True when the sheet is hosted inside a side pane instead of a modal sheet —
  /// the iPad "Scholar's Desk on the side" (row 23 of `IPAD_ADAPTIVE_PLAN.md`).
  /// An embedded panel fills its pane rather than taking 85% of the window, sizes
  /// its bubbles to the pane instead of the screen, and closes through [onClose]
  /// instead of popping a route.
  final bool embedded;

  /// Invoked by the header's close button when [embedded] is true. The modal form
  /// ignores it and pops its own route.
  final VoidCallback? onClose;

  const CharacterChatSheet({
    super.key,
    required this.hanzi,
    required this.pinyin,
    required this.definition,
    this.definitionLanguage,
    this.messageSender,
    this.strokePaths = const <String>[],
    this.medianPaths = const <List<Offset>>[],
    this.isFlipped = false,
    this.embedded = false,
    this.onClose,
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

  /// Monotonic id for each bubble, used as its entrance-animation key.
  int _nextMessageId = 0;

  /// Whether the composer holds text, so the send button can react to it.
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onComposerChanged);
  }

  void _onComposerChanged() {
    final bool hasText = _textController.text.trim().isNotEmpty;
    if (hasText != _hasText) setState(() => _hasText = hasText);
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
        id: _nextMessageId++,
        text: l10n.askMeAnythingAbout(widget.hanzi),
        isUser: false,
        chips: _chipsForIndex(0, l10n),
      ));
    }
  }

  @override
  void dispose() {
    _textController.removeListener(_onComposerChanged);
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    final consent = await AiConsentSheet.ensureConsent(context);
    if (!consent || !mounted) return;
    final l10n = AppLocalizations.of(context)!;
    HapticsManager.light();
    setState(() {
      _messages.add(ChatMessage(id: _nextMessageId++, text: text, isUser: true));
      _isLoading = true;
    });
    _textController.clear();
    _scrollToBottom();

    // A chip tap and a typed question both reach here as text, so stroke-order
    // intent is matched from the wording — but the lesson only attaches when the
    // card actually carries the skeletons it needs.
    final ScholarArtefact? reply = _attachArtefact(_detectArtefact(text, l10n));

    try {
      if (widget.messageSender != null) {
        final rawText = await widget.messageSender!(text);
        if (rawText.isEmpty) throw Exception('Empty response');
        _addAiReply(rawText, l10n, artefact: reply);
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

      _addAiReply(rawText, l10n, artefact: reply);
    } catch (e) {
      final errorStr = e.toString();

      // Order matters: a lost connection is the one failure the learner can
      // actually fix, so it must not be buried under the generic
      // "AI tutor error: <raw exception>" line that used to be shown for it.
      final String userMessage;
      if (NetworkFailure.isOffline(e)) {
        userMessage = NetworkNotice.messageOf(l10n);
      } else if (errorStr.contains('Quota exceeded') ||
          errorStr.contains('429')) {
        userMessage = l10n.aiTutorRateLimit;
      } else {
        userMessage = l10n.aiTutorError(errorStr);
      }

      setState(() {
        _messages.add(
            ChatMessage(id: _nextMessageId++, text: userMessage, isUser: false));
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  void _addAiReply(String text, AppLocalizations l10n,
      {ScholarArtefact? artefact}) {
    _aiReplyCount++;
    setState(() {
      _messages.add(ChatMessage(
        id: _nextMessageId++,
        text: text,
        isUser: false,
        chips: _chipsForIndex(_aiReplyCount, l10n),
        artefact: artefact,
      ));
      _isLoading = false;
    });
    _scrollToBottom();
  }

  /// Matches a question to a mini-lesson. Deliberately small and multilingual:
  /// there is no NLU here, and the only artefact today is the stroke lesson.
  ScholarArtefact? _detectArtefact(String text, AppLocalizations l10n) {
    if (text == l10n.explainTheStrokeOrderRulesForThisCh) {
      return ScholarArtefact.strokeOrder;
    }
    final String q = text.toLowerCase();
    const List<String> needles = <String>[
      'stroke order',
      'stroke-order',
      'ordre des traits',
      '笔顺',
      '筆順',
      '書き順',
      'ordine dei tratti',
      'orden de los trazos',
      'ordem dos traços',
      'urutan guratan',
      'thứ tự nét',
    ];
    for (final String needle in needles) {
      if (q.contains(needle)) return ScholarArtefact.strokeOrder;
    }
    return null;
  }

  /// The stroke lesson needs real skeletons; without them the reply stays prose
  /// rather than showing an empty grid.
  ScholarArtefact? _attachArtefact(ScholarArtefact? artefact) =>
      artefact == ScholarArtefact.strokeOrder && widget.strokePaths.isNotEmpty
          ? artefact
          : null;

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

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // In a side pane the bubbles size to the *pane*, not the window - 88% of
        // an iPad is wider than the pane the chat actually lives in.
        final double drawerWidth = widget.embedded
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width * 0.88;

        final Widget column = Column(
          children: [
            // Only the modal form needs the grab-handle strip; embedded, the
            // pane's own header takes that role and the strip is dead air.
            if (!widget.embedded) const SizedBox(height: 8),

            _buildHeader(isDark, textColor),

            ChatMessageEntrance(
              delay: ZenMotion.beat,
              child: _buildCharacterBox(isDark, aiBubbleColor, textColor),
            ),

            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                itemCount: _messages.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _messages.length) {
                    return ChatMessageEntrance(
                      key: const ValueKey<String>('scholar-typing'),
                      child: _buildTypingIndicator(aiBubbleColor),
                    );
                  }
                  final msg = _messages[index];
                  // Each bubble rises in once, keyed by its id so scrolling
                  // back and forth does not replay the entrance.
                  return ChatMessageEntrance(
                    key: ValueKey<int>(msg.id),
                    child: msg.isUser
                        ? _buildUserBubble(msg, drawerWidth, textColor)
                        : _buildAiBubble(
                            msg, aiBubbleColor, drawerWidth, textColor, isDark),
                  );
                },
              ),
            ),

            _buildInputBar(isDark, textColor),
          ],
        );

        // Embedded: fill the pane the parent hands us. The parent owns the
        // height, the border and the safe area, so no modal chrome is added.
        if (widget.embedded) return column;

        return SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.85,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: column,
            ),
          ),
        );
      },
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
            onPressed: widget.embedded
                ? (widget.onClose ?? () {})
                : () => Navigator.pop(context),
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
        // A mini-lesson built from the app's own data, when words alone are not
        // enough ("explain the stroke order" → the animated canvas).
        if (msg.artefact == ScholarArtefact.strokeOrder)
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: drawerWidth * 0.82),
            child: ScholarStrokeLesson(
              hanzi: widget.hanzi,
              strokePaths: widget.strokePaths,
              medianPaths: widget.medianPaths,
              isFlipped: widget.isFlipped,
              isDark: isDark,
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
                  .asMap()
                  .entries
                  .map((entry) => ChatMessageEntrance(
                        // The chips follow the bubble in one beat apart, rather
                        // than all landing at once with it — the same rise-and-fade
                        // the bubble uses, honouring Reduce Motion.
                        delay: ZenMotion.beat * (entry.key + 1),
                        child: GestureDetector(
                          onTap: () {
                            HapticsManager.light();
                            _sendMessage(entry.value.prompt);
                          },
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
                              entry.value.label,
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: Colors.indigo,
                                fontWeight: FontWeight.w500,
                              ),
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
        child: const ChatTypingDots(),
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
                      onTap: _hasText
                          ? () => _sendMessage(_textController.text)
                          : null,
                      // The brush "presses" only when there is something to
                      // send, so an empty composer no longer reads as armed.
                      child: AnimatedScale(
                        scale: _hasText ? 1.0 : 0.82,
                        duration: ZenMotion.of(context, ZenMotion.swap),
                        curve: ZenMotion.natural,
                        child: AnimatedOpacity(
                          opacity: _hasText ? 1.0 : 0.55,
                          duration: ZenMotion.of(context, ZenMotion.swap),
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
