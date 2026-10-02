import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/scenario.dart';
import '../providers/conversation_controller.dart';
import 'package:hanzi_master/core/models/pronunciation_grade.dart';
import '../../../chat/domain/entities/chat_message.dart';
import '../widgets/pronunciation_report_sheet.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/tappable_hanzi_text.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/shared/widgets/breathing_widget.dart';
import 'package:hanzi_master/core/services/saved_scenarios_service.dart';
import 'package:hanzi_master/shared/widgets/ai_consent_sheet.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/widgets/zen_toast.dart';
import 'package:hanzi_master/shared/widgets/zen_overlay.dart';
import 'package:hanzi_master/core/layout/zen_layout.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import 'package:hanzi_master/shared/widgets/chat_motion.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';

class ConversationScreen extends ConsumerStatefulWidget {
  final ConversationScenario scenario;

  const ConversationScreen({super.key, required this.scenario});

  @override
  ConsumerState<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends ConsumerState<ConversationScreen> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, bool> _translationVisibility = {};

  /// Message ids that have already played their entrance. A `SliverList` recycles
  /// the elements it scrolls past, so without this a long transcript would replay
  /// every bubble's entrance on the way back up.
  final Set<String> _enteredMessages = <String>{};

  /// Drives the composer's armed state (border tint, send brush) without asking
  /// the provider on every keystroke.
  bool _hasText = false;

  /// False once the reader has scrolled back up the transcript — the cue for the
  /// "New" pill that carries them back to the foot of the conversation.
  bool _isNearBottom = true;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_syncHasText);
    _scrollController.addListener(_syncScrollAffordance);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final consented = await AiConsentSheet.ensureConsent(context);
      if (!consented && mounted) {
        Navigator.of(context).pop();
        return;
      }
      ref
          .read(conversationControllerProvider.notifier)
          .startScenario(widget.scenario);
    });
  }

  @override
  void dispose() {
    // Delete any locally cached audio files from this session
    final state = ref.read(conversationControllerProvider);
    for (var message in state.messages) {
      if (message.audioPath != null) {
        try {
          final file = File(message.audioPath!);
          if (file.existsSync()) {
            file.deleteSync();
          }
        } catch (e) {
          debugPrint("Error deleting conversation recording on dispose: $e");
        }
      }
    }
    _textController.removeListener(_syncHasText);
    _scrollController.removeListener(_syncScrollAffordance);
    _scrollController.dispose();
    super.dispose();
  }

  /// Keeps `_hasText` in sync with the composer. Only rebuilds on the empty↔
  /// non-empty transition, not on every keystroke.
  void _syncHasText() {
    final bool hasText = _textController.text.trim().isNotEmpty;
    if (hasText != _hasText) setState(() => _hasText = hasText);
  }

  /// Tracks whether the foot of the transcript is on screen. Rebuilds only on the
  /// transition, so scrolling never rebuilds the transcript frame by frame.
  void _syncScrollAffordance() {
    if (!_scrollController.hasClients) return;
    final ScrollPosition position = _scrollController.position;
    final bool nearBottom = position.maxScrollExtent - position.pixels < 160;
    if (nearBottom != _isNearBottom) setState(() => _isNearBottom = nearBottom);
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent +
            200, // buffer for new message
        duration: ZenMotion.quick,
        curve: ZenMotion.enter,
      );
    }
  }

  Widget _buildBookmarkButton(ThemeData theme) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final savedScenarios = ref.watch(savedScenariosProvider);
    final isSaved = savedScenarios.any((s) => s.id == widget.scenario.id);

    return IconButton(
      icon: Icon(
        isSaved ? Icons.bookmark : Icons.bookmark_border,
        color: isSaved ? theme.colorScheme.primary : null,
      ),
      tooltip:
          isSaved ? l10n.removeFromSavedScenarios : l10n.saveScenario,
      onPressed: () {
        ref.read(savedScenariosProvider.notifier).toggle(widget.scenario);
        ZenToast.info(
            context,
            isSaved
                ? l10n.scenarioRemoved
                : l10n.scenarioSavedFindInCustomTab);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(conversationControllerProvider);
    final theme = Theme.of(context);

    ref.listen(
        conversationControllerProvider.select((state) => state.messages.length),
        (previous, next) {
      if (previous != null && next > previous) {
        Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
      }
    });

    // iPad (>=840dp, either orientation): the transcript keeps a column of its
    // own and the scenario's identity + objectives move to a desk beside it,
    // instead of floating a badge over the conversation. The gate is the window
    // class, never a raw width, so a Split View half keeps the phone layout.
    final bool wide = context.zenWindow.isExpanded;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CalligraphyBackground(
          child: wide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: _buildChatColumn(state, theme,
                          showQuestsButton: false, headerHeight: 180),
                    ),
                    _buildScenarioDesk(theme),
                  ],
                )
              : _buildChatColumn(state, theme,
                  showQuestsButton: true, headerHeight: 220),
        ),
      ),
    );
  }

  /// The transcript and the composer, in one column.
  ///
  /// Both arrangements share it, so the phone and the iPad cannot drift apart.
  /// The measure comes from this column's own constraints, never the window:
  /// 80% of the *window* on a 1366dp iPad was a 1093dp bubble, one sentence of
  /// Chinese per line.
  Widget _buildChatColumn(
    ConversationState state,
    ThemeData theme, {
    required bool showQuestsButton,
    required double headerHeight,
  }) {
    final List<String> quests =
        widget.scenario.localizedQuests(Localizations.localeOf(context));

    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              // Centre the transcript on a readable measure once the window is
              // wider than one.
              final double measure =
                  math.min(constraints.maxWidth, ZenContentWidth.reading);
              final double inset = _readingInset(constraints.maxWidth);
              final double bubbleMax = measure * 0.86;

              return Stack(
                children: [
                  CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverAppBar(
                        expandedHeight: headerHeight,
                        pinned: true,
                        backgroundColor: theme.colorScheme.surface,
                        surfaceTintColor: Colors.transparent,
                        iconTheme:
                            IconThemeData(color: theme.colorScheme.onSurface),
                        actions: [
                          _buildBookmarkButton(theme),
                        ],
                        flexibleSpace: FlexibleSpaceBar(
                          title: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                widget.scenario.title,
                                style: TextStyle(
                                  color: theme.colorScheme.onSurface,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              // The persona, not only the scenario: once the
                              // banner scrolls away the bar is all that is left,
                              // and "who am I talking to" is the question a
                              // roleplay transcript is about.
                              Text(
                                widget.scenario.localizedPersonaName(
                                    Localizations.localeOf(context)),
                                style: TextStyle(
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.6),
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          centerTitle: true,
                          background: _buildHeaderBackground(theme),
                        ),
                      ),
                      if (state.messages.isEmpty)
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: _buildOpeningState(state, theme),
                        )
                      else
                        SliverPadding(
                          padding: EdgeInsets.fromLTRB(inset, 24, inset, 20),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                if (index == state.messages.length) {
                                  return _buildTypingRow(theme);
                                }
                                return _buildMessage(
                                    state.messages[index], theme, bubbleMax);
                              },
                              childCount: state.messages.length +
                                  (state.isProcessing ? 1 : 0),
                            ),
                          ),
                        ),
                    ],
                  ),
                  // Phone: the objectives ride above the transcript. On iPad
                  // they live in the desk, so the badge is not built at all.
                  if (showQuestsButton && quests.isNotEmpty)
                    Positioned(
                      top: 240, // Below expanded app bar
                      right: 12,
                      child: _QuestsFloatingButton(quests: quests),
                    ),
                  // Scrolling back through a transcript strands you: this fades in
                  // over the composer and one tap returns you to the newest line.
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: AnimatedScale(
                      scale: _isNearBottom ? 0.85 : 1.0,
                      duration: ZenMotion.of(context, ZenMotion.swap),
                      curve: ZenMotion.arrival,
                      child: AnimatedOpacity(
                        opacity: _isNearBottom ? 0.0 : 1.0,
                        duration: ZenMotion.of(context, ZenMotion.swap),
                        child: IgnorePointer(
                          ignoring: _isNearBottom,
                          child: _buildJumpToLatest(theme),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        // Input Area at the bottom
        _buildInputArea(state, theme),
      ],
    );
  }

  /// The opening beat: the scenario is being set up, so the transcript is empty.
  /// A bare list read as "something broke"; this says what is happening.
  Widget _buildOpeningState(ConversationState state, ThemeData theme) {
    final String persona =
        widget.scenario.localizedPersonaName(Localizations.localeOf(context));
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ZenFadeIn(
              child: ZenLoader(
                label: AppLocalizations.of(context)!.thinking,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            ZenFadeIn(
              child: Text(
                state.error ?? persona,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// The iPad desk beside the transcript: who you are talking to, what you are
  /// meant to achieve, and the scenario's own words — the three things a badge
  /// floating over a phone transcript cannot hold.
  Widget _buildScenarioDesk(ThemeData theme) {
    final Locale locale = Localizations.localeOf(context);
    final List<String> quests = widget.scenario.localizedQuests(locale);
    final String persona = widget.scenario.localizedPersonaName(locale);

    // The desk steps with the window class instead of sitting at one width: a
    // 13" iPad can afford a wider brief. (A Split View half never reaches this
    // branch at all.)
    final double deskWidth =
        zenValue(context, compact: 320, expanded: 340, large: 380);

    return Container(
      width: deskWidth,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          left: BorderSide(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.08)),
        ),
        // A soft edge, so the desk reads as a docked pane rather than a second
        // page butted against the transcript.
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
                alpha: theme.brightness == Brightness.dark ? 0.30 : 0.05),
            blurRadius: 18,
            offset: const Offset(-6, 0),
          ),
        ],
      ),
      child: SafeArea(
        left: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
          children: [
            ZenFadeIn(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPersonaChip(theme, size: 96),
                  const SizedBox(height: 14),
                  Text(
                    persona,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.scenario.title,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color:
                          theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (widget.scenario.description.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text(
                widget.scenario.description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.75),
                  height: 1.4,
                ),
              ),
            ],
            if (quests.isNotEmpty) ...[
              const SizedBox(height: 28),
              _buildObjectivesCard(quests, theme),
            ],
          ],
        ),
      ),
    );
  }

  /// The persona's face: the scenario's avatar when it has one, its monogram
  /// otherwise — the same contract the launcher and the call screen use, so "no
  /// portrait" is a finished state rather than a gap.
  Widget _buildPersonaChip(ThemeData theme, {double size = 28}) {
    final String persona =
        widget.scenario.localizedPersonaName(Localizations.localeOf(context));
    final String monogram = persona.isNotEmpty
        ? persona[0].toUpperCase()
        : (widget.scenario.title.isNotEmpty
            ? widget.scenario.title[0].toUpperCase()
            : '悟');
    final Widget fallback = Center(
      child: Text(
        monogram,
        style: TextStyle(
          fontSize: size * 0.42,
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
    );

    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.primary.withValues(alpha: 0.12),
      ),
      child: widget.scenario.hasAvatar
          ? Image.asset(
              widget.scenario.avatarAssetPath,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => fallback,
            )
          : fallback,
    );
  }

  /// "The persona is writing" — the same ink dots the Bureau du savant shows, so
  /// a slow reply reads as activity rather than a frozen transcript.
  Widget _buildTypingRow(ThemeData theme) {
    return ChatMessageEntrance(
      key: const ValueKey<String>('persona-typing'),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPersonaChip(theme),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: theme.cardTheme.color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(4),
                ),
                border: Border.all(
                    color:
                        theme.colorScheme.onSurface.withValues(alpha: 0.1)),
              ),
              child: ChatTypingDots(color: theme.colorScheme.primary),
            ),
          ],
        ),
      ),
    );
  }

  /// The scenario's objectives as a titled card. The iPad desk uses it directly;
  /// on a phone the same list lives behind the floating badge, which cannot
  /// afford a title, a border and a bullet per line.
  Widget _buildObjectivesCard(List<String> quests, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: theme.colorScheme.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.flag, size: 16, color: theme.colorScheme.primary),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                AppLocalizations.of(context)!.objectivesTitle,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ]),
          const SizedBox(height: 10),
          ...quests.map((String quest) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6, right: 8),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.6),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        quest,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color:
                              theme.colorScheme.onSurface.withValues(alpha: 0.8),
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  /// Replays one reply in the scenario's voice. It sits in the message's action
  /// row rather than floating at the bubble's leading edge, so the leading space
  /// belongs to the persona's face.
  Widget _buildSpeakButton(GradedChatMessage message, ThemeData theme) {
    return Semantics(
      button: true,
      label: AppLocalizations.of(context)!.listen,
      child: BouncingButton(
        onPressed: () => ref.read(audioServiceProvider).playSentence(
              message.content,
              voiceName: widget.scenario.voiceName,
            ),
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.06),
          ),
          child: Icon(
            Icons.volume_up,
            size: 16,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }

  /// The reply the persona is nudging you towards.
  ///
  /// The Chinese line is a *tappable* chip rather than a quotation: the Bureau du
  /// savant's follow-up chips work the same way, and a learner who is stuck wants
  /// one tap — not a transcription exercise on a phone keyboard.
  Widget _buildSuggestionCard(GradedChatMessage message, ThemeData theme) {
    final Map<String, dynamic> suggestion = message.suggestion!;
    final String chinese = (suggestion['chinese'] ?? '').toString();
    final String pinyin = (suggestion['pinyin'] ?? '').toString();
    final String english = (suggestion['english'] ?? '').toString();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border:
            Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.lightbulb_outline,
                size: 16, color: theme.colorScheme.primary),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                AppLocalizations.of(context)!.suggestion,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ]),
          if (chinese.isNotEmpty) ...[
            const SizedBox(height: 8),
            // One beat behind the bubble, exactly like the Bureau's follow-ups.
            ChatMessageEntrance(
              delay: ZenMotion.beat,
              child: _buildSuggestionChip(chinese, theme),
            ),
          ],
          if (pinyin.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              pinyin,
              style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
            ),
          ],
          if (english.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              english,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(String chinese, ThemeData theme) {
    final bool busy = ref.read(conversationControllerProvider).isProcessing;
    // Plain text, not TappableHanziText: the chip's one job is to send, and a
    // per-character recogniser inside it would swallow the tap.
    return Semantics(
      button: true,
      label: chinese,
      child: BouncingButton(
        onPressed: busy ? null : () => _sendSuggestion(chinese),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
                color: theme.colorScheme.primary.withValues(alpha: 0.35)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  chinese,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_upward_rounded,
                  size: 15, color: theme.colorScheme.primary),
            ],
          ),
        ),
      ),
    );
  }

  /// Sends a suggestion as the learner's own turn. The composer is deliberately
  /// left alone, so half-typed text survives the shortcut.
  void _sendSuggestion(String chinese) {
    if (chinese.trim().isEmpty) return;
    HapticsManager.medium();
    FocusScope.of(context).unfocus();
    ref.read(conversationControllerProvider.notifier).sendMessage(chinese);
  }

  /// The "New" pill: one tap back to the foot of the transcript. It shares the
  /// quest badge's rise, so chrome never snaps into place.
  Widget _buildJumpToLatest(ThemeData theme) {
    return Semantics(
      button: true,
      label: AppLocalizations.of(context)!.newLabel,
      child: BouncingButton(
        onPressed: () {
          HapticsManager.light();
          _scrollToBottom();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.35),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_downward_rounded,
                  size: 16, color: theme.colorScheme.onPrimary),
              const SizedBox(width: 6),
              Text(
                AppLocalizations.of(context)!.newLabel,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderBackground(ThemeData theme) {
    if (widget.scenario.hasAvatar) {
      // On a phone this box *is* the bar. On an iPad it centres the banner on the
      // transcript's reading measure, so a full-bleed 1000dp wash stops sitting
      // above bubbles that only occupy 680 of it.
      return Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: ZenContentWidth.reading),
          child: SafeArea(
        bottom: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              widget.scenario.avatarAssetPath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                child: Center(
                  child: Icon(Icons.person,
                      size: 100, color: theme.colorScheme.primary),
                ),
              ),
            ),
            // Gradient scrim so the title text is perfectly readable
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 100,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      theme.colorScheme.surface,
                      theme.colorScheme.surface.withValues(alpha: 0.7),
                      theme.colorScheme.surface.withValues(alpha: 0.0),
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

    // Refined Monogram
    final personaName =
        widget.scenario.localizedPersonaName(Localizations.localeOf(context));
    final char = personaName.isNotEmpty ? personaName[0].toUpperCase() : '?';
    return SafeArea(
      bottom: false,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary.withValues(alpha: 0.1),
              theme.colorScheme.surface,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.secondary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: Center(
              child: Text(
                char,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  final TextEditingController _textController = TextEditingController();

  void _handleSubmitted() {
    final val = _textController.text;
    if (val.trim().isNotEmpty) {
      FocusScope.of(context).unfocus();
      ref.read(conversationControllerProvider.notifier).sendMessage(val);
      _textController.clear();
    }
  }

  Widget _buildInputArea(ConversationState state, ThemeData theme) {
    final bool isDark = theme.brightness == Brightness.dark;
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // The composer keeps the transcript's measure. An input row spanning a
        // 1000dp iPad column reads as a stretched phone field; on a phone this is
        // the same 16dp gutter the transcript uses.
        final double gutter = math.max(16, _readingInset(constraints.maxWidth));
        return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.06)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(gutter, 10, gutter, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                // The composer arms itself: the border warms to the accent as
                // soon as there is something to send.
                child: AnimatedContainer(
                  duration: ZenMotion.of(context, ZenMotion.swap),
                  curve: ZenMotion.natural,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.06)
                        : theme.cardTheme.color,
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(
                      color: theme.colorScheme.primary
                          .withValues(alpha: _hasText ? 0.45 : 0.12),
                      width: 1.2,
                    ),
                  ),
                  child: HanziTextField(
                    controller: _textController,
                    style: theme.textTheme.bodyLarge,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: state.isProcessing
                          ? l10n.thinking
                          : (state.isRecording
                              ? l10n.listening
                              : l10n.typeYourMessage),
                      hintStyle: theme.textTheme.bodyMedium?.copyWith(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.4),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 13),
                    ),
                    onSubmitted: (_) => _handleSubmitted(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // One control, two modes: the recorder, or the send brush. They
              // cross-fade rather than swapping between frames, and the brush
              // only arms when there is something to send.
              AnimatedSwitcher(
                duration: ZenMotion.of(context, ZenMotion.swap),
                switchInCurve: ZenMotion.arrival,
                switchOutCurve: ZenMotion.natural,
                transitionBuilder: (Widget child, Animation<double> animation) =>
                    FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(scale: animation, child: child),
                ),
                child: _hasText
                    ? _buildSendButton(state, theme)
                    : _buildMicButton(state, theme),
              ),
            ],
          ),
        ),
      ),
    );
      },
    );
  }

  Widget _buildSendButton(ConversationState state, ThemeData theme) {
    return BouncingButton(
      key: const ValueKey<String>('send'),
      onPressed: state.isProcessing
          ? null
          : () {
              HapticsManager.medium();
              FocusScope.of(context).unfocus();
              ref
                  .read(conversationControllerProvider.notifier)
                  .sendMessage(_textController.text);
              _textController.clear();
            },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: theme.colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withValues(alpha: 0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(Icons.arrow_upward,
            color: theme.colorScheme.onPrimary, size: 24),
      ),
    );
  }

  /// Hold to talk. Kept as a [Listener] rather than a button because recording
  /// starts on touch-down and is graded on lift.
  Widget _buildMicButton(ConversationState state, ThemeData theme) {
    return Listener(
      key: const ValueKey<String>('mic'),
      onPointerDown: (_) {
        if (!state.isProcessing) {
          ref.read(conversationControllerProvider.notifier).startRecording();
        }
      },
      onPointerUp: (_) {
        if (!state.isProcessing) {
          ref
              .read(conversationControllerProvider.notifier)
              .stopRecordingAndProcess();
        }
      },
      onPointerCancel: (_) {
        if (!state.isProcessing) {
          ref
              .read(conversationControllerProvider.notifier)
              .stopRecordingAndProcess();
        }
      },
      child: BreathingWidget(
        isBreathing: state.isRecording,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: state.isRecording
                ? Colors.redAccent
                : theme.colorScheme.primary.withValues(alpha: 0.1),
          ),
          child: Icon(
            state.isRecording ? Icons.mic : Icons.mic_none,
            color:
                state.isRecording ? Colors.white : theme.colorScheme.primary,
            size: 24,
          ),
        ),
      ),
    );
  }

  /// The paper a reply sits on — warm ivory in light mode, a lifted charcoal in
  /// dark. Not the raw card colour: a hair of separation from
  /// `CalligraphyBackground` is what keeps a transcript readable over an ink
  /// wash, and it is the surface the Bureau du savant uses.
  /// The horizontal inset that centres content on a readable measure.
  ///
  /// 16dp on a phone (where the window is already narrower than the measure, so
  /// this *is* the gutter), growing with the window — the one number that keeps a
  /// transcript and its composer on the same 680dp column on an iPad.
  double _readingInset(double width) {
    final double measure = math.min(width, ZenContentWidth.reading);
    return math.max(16, (width - measure) / 2);
  }

  Color _bubblePaper(ThemeData theme) => theme.brightness == Brightness.dark
      ? const Color(0xFF252525)
      : const Color(0xFFFFF8EE);

  /// The pronunciation score as a chip rather than a bare number: the old row
  /// read "87 score (estimated)", which is three unlabelled fragments in a 12px
  /// line. A pill says the same thing in one glance and colour-codes it.
  Widget _buildScoreBadge(
      PronunciationGrade grade, ThemeData theme, bool isUser) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final int? scoreVal = grade.score;
    final bool isGrading = scoreVal == null;
    // Compute the effective score from the dimensions when the overall is 0.
    final int effectiveScore = isGrading
        ? 0
        : (scoreVal > 0
            ? scoreVal
            : ((grade.accuracy + grade.completeness + grade.fluency) / 3)
                .round());
    final bool isEstimated = !isGrading && scoreVal == 0 && effectiveScore > 0;
    final Color color = isGrading
        ? theme.colorScheme.onSurface.withValues(alpha: 0.45)
        : (effectiveScore >= 80 ? Colors.green.shade600 : Colors.red.shade600);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.30)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isGrading ? Icons.hourglass_top_rounded : Icons.graphic_eq_rounded,
            size: 13,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            isGrading ? l10n.grading : '$effectiveScore',
            style: theme.textTheme.labelMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (!isGrading) ...[
            const SizedBox(width: 4),
            Text(
              l10n.scoreText,
              style: theme.textTheme.labelSmall
                  ?.copyWith(color: color.withValues(alpha: 0.75)),
            ),
          ],
          if (isEstimated) ...[
            const SizedBox(width: 4),
            Icon(Icons.auto_awesome, size: 11, color: color.withValues(alpha: 0.6)),
          ],
        ],
      ),
    );
  }

  Widget _buildMessage(
      GradedChatMessage message, ThemeData theme, double maxBubbleWidth) {
    final isUser = message.role == ChatRole.user;
    final isExpanded = _translationVisibility[message.id] ?? false;

    // One entrance per message, keyed by its id. The memo stops a recycled
    // element replaying the rise when the reader scrolls back up a transcript.
    return ChatMessageEntrance(
      key: ValueKey<String>('msg-${message.id}'),
      animate: !_enteredMessages.contains(message.id),
      onEntered: () => _enteredMessages.add(message.id),
      child: GestureDetector(
      onTap: () {
        if (isUser && message.grade != null) {
          zenSheet(
            context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => PronunciationReportSheet(message: message),
          );
        }
      },
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(bottom: 18),
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          constraints: BoxConstraints(maxWidth: maxBubbleWidth),
          decoration: BoxDecoration(
            // The Bureau du savant's paper, so the app's two AI conversations
            // read as one product: warm ivory under the other side's reply, a
            // tint of the accent under yours.
            color: isUser
                ? theme.colorScheme.primary.withValues(alpha: 0.12)
                : _bubblePaper(theme),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(22),
              topRight: const Radius.circular(22),
              bottomLeft: Radius.circular(isUser ? 22 : 6),
              bottomRight: Radius.circular(isUser ? 6 : 22),
            ),
            border: Border.all(
              color: isUser
                  ? theme.colorScheme.primary.withValues(alpha: 0.22)
                  : theme.colorScheme.onSurface.withValues(alpha: 0.07),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                    alpha: theme.brightness == Brightness.dark ? 0.25 : 0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isUser) ...[
                if (message.grade != null) ...[
                  _buildScoreBadge(message.grade!, theme, isUser),
                  // User's spoken text
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: TappableMarkdownHanziText(
                      message.content,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: message.grade!.words
                        .map((w) => _buildGradedWord(w, theme))
                        .toList(),
                  ),
                ] else ...[
                  TappableMarkdownHanziText(
                    message.content,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
                if (message.english != null && message.english!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    message.english!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ] else ...[
                // AI reply: the persona's face leads, so the transcript has an
                // identity instead of an anonymous wall of text, and every action
                // on the message sits in one row at its foot.
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPersonaChip(theme),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TappableMarkdownHanziText(
                            message.content,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          if (isExpanded) ...[
                            if (message.pinyin != null &&
                                message.pinyin!.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Text(
                                message.pinyin!,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                            if (message.english != null &&
                                message.english!.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Text(
                                message.english!,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.8),
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ],
                          if (message.role == ChatRole.scholar) ...[
                            const SizedBox(height: 8),
                            // One action row for everything you can do with a
                            // reply: reveal the translation, or hear it again.
                            Row(children: [
                              InkWell(
                                onTap: () {
                                  // Lazy-load translation if not yet cached
                                  if (message.english == null ||
                                      message.english!.isEmpty) {
                                    ref
                                        .read(conversationControllerProvider
                                            .notifier)
                                        .translateMessage(message.id);
                                  }
                                  setState(() {
                                    _translationVisibility[message.id] =
                                        !isExpanded;
                                  });
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        isExpanded
                                            ? Icons.visibility_off_outlined
                                            : Icons.translate_rounded,
                                        size: 14,
                                        color: theme.colorScheme.primary,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        isExpanded
                                            ? (AppLocalizations.of(context)
                                                    ?.hideTranslation ??
                                                'Hide Translation')
                                            : (AppLocalizations.of(context)
                                                    ?.translation ??
                                                'Translate'),
                                        style: theme.textTheme.labelSmall
                                            ?.copyWith(
                                          color: theme.colorScheme.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              _buildSpeakButton(message, theme),
                            ]),
                          ],
                          if (message.suggestion != null) ...[
                            const SizedBox(height: 12),
                            _buildSuggestionCard(message, theme),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
      ),
    );
  }

  Widget _buildGradedWord(SyllableGrade word, ThemeData theme) {
    final color = switch (word.gradeLevel) {
      WordGradeLevel.correct => Colors.green.shade600,
      WordGradeLevel.partial => const Color(0xFFF59E0B),
      WordGradeLevel.wrong => Colors.red.shade600,
    };
    final isClickable =
        word.gradeLevel != WordGradeLevel.correct && word.feedback.isNotEmpty;

    return GestureDetector(
      onTap: isClickable
          ? () => _showWordFeedbackDialog(word, color, theme)
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(word.pinyin,
              style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(height: 2),
          Stack(
            alignment: Alignment.topRight,
            children: [
              Text(word.word,
                  style: theme.textTheme.titleLarge
                      ?.copyWith(color: color, fontWeight: FontWeight.bold)),
              if (isClickable)
                Positioned(
                  top: 0,
                  right: -2,
                  child: Container(
                      width: 6,
                      height: 6,
                      decoration:
                          BoxDecoration(color: color, shape: BoxShape.circle)),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _showWordFeedbackDialog(
      SyllableGrade word, Color color, ThemeData theme) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
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
                    color: color.withValues(alpha: 0.12),
                    shape: BoxShape.circle),
                child: Center(
                    child: Text(word.word,
                        style: theme.textTheme.displaySmall?.copyWith(
                            color: color, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(height: 8),
              Text(word.pinyin,
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
                  word.gradeLevel == WordGradeLevel.partial
                      ? l10n.pronunciationPartial
                      : l10n.pronunciationWrong,
                  style: theme.textTheme.labelMedium
                      ?.copyWith(color: color, fontWeight: FontWeight.bold),
                ),
              ),
              if (word.expectedTone > 0) ...[
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _ToneChip(
                        label: l10n.toneExpected,
                        tone: word.expectedTone,
                        color: Colors.green.shade600),
                    const SizedBox(width: 12),
                    _ToneChip(
                        label: l10n.toneYouSaid,
                        tone: word.actualTone,
                        color: color),
                  ],
                ),
              ],
              const SizedBox(height: 16),
              Text(word.feedback,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(height: 1.5)),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () => Navigator.pop(ctx), child: Text(l10n.gotIt)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToneChip extends StatelessWidget {
  final String label;
  final int tone;
  final Color color;
  const _ToneChip(
      {required this.label, required this.tone, required this.color});

  static const _names = ['', '1st ˉ', '2nd ˊ', '3rd ˇ', '4th ˋ', 'neutral'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
          child: Text(tone > 0 && tone < _names.length ? _names[tone] : '?',
              style: theme.textTheme.labelLarge
                  ?.copyWith(color: color, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

class _QuestsFloatingButton extends StatefulWidget {
  final List<String> quests;
  const _QuestsFloatingButton({required this.quests});

  @override
  State<_QuestsFloatingButton> createState() => _QuestsFloatingButtonState();
}

class _QuestsFloatingButtonState extends State<_QuestsFloatingButton> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    // Grows open instead of appearing: a badge that pops over a still transcript
    // reads as a glitch.
    return AnimatedSize(
      duration: ZenMotion.of(context, ZenMotion.swap),
      curve: ZenMotion.arrival,
      alignment: Alignment.topRight,
      child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_expanded)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            constraints: const BoxConstraints(maxWidth: 220),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber.withValues(alpha: 0.4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(Icons.flag, color: Colors.amber, size: 16),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        AppLocalizations.of(context)!.questsTitle,
                        style: const TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            letterSpacing: 1),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...widget.quests.map((q) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Icon(Icons.circle,
                                size: 5, color: Colors.white70),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              q,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  height: 1.3),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.7),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.amber.withValues(alpha: 0.5)),
            ),
            child: Icon(
              _expanded ? Icons.close : Icons.flag_outlined,
              color: Colors.amber,
              size: 20,
            ),
          ),
        ),
      ],
      ),
    );
  }
}
