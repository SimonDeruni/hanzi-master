import 'dart:io';
import 'dart:ui' as ui;
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
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:hanzi_master/core/services/audio_service.dart';
import 'package:hanzi_master/shared/widgets/breathing_widget.dart';
import 'package:hanzi_master/core/services/saved_scenarios_service.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:hanzi_master/core/widgets/translated_text.dart';

class ConversationScreen extends ConsumerStatefulWidget {
  final ConversationScenario scenario;

  const ConversationScreen({super.key, required this.scenario});

  @override
  ConsumerState<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends ConsumerState<ConversationScreen> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, bool> _translationVisibility = {};

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
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
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent +
            200, // buffer for new message
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Widget _buildBookmarkButton(ThemeData theme) {
    final savedScenarios = ref.watch(savedScenariosProvider);
    final isSaved = savedScenarios.any((s) => s.id == widget.scenario.id);

    return IconButton(
      icon: Icon(
        isSaved ? Icons.bookmark : Icons.bookmark_border,
        color: isSaved ? theme.colorScheme.primary : null,
      ),
      tooltip: isSaved
          ? AppLocalizations.of(context)!.removeFromSavedScenarios
          : AppLocalizations.of(context)!.saveThisScenario,
      onPressed: () {
        ref.read(savedScenariosProvider.notifier).toggle(widget.scenario);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isSaved
                ? AppLocalizations.of(context)!.scenarioRemoved
                : AppLocalizations.of(context)!.scenarioSavedFindInCustomTab),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
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

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CalligraphyBackground(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverAppBar(
                          expandedHeight: 220,
                          pinned: true,
                          backgroundColor: theme.colorScheme.surface,
                          surfaceTintColor: Colors.transparent,
                          iconTheme:
                              IconThemeData(color: theme.colorScheme.onSurface),
                          actions: [
                            _buildBookmarkButton(theme),
                          ],
                          flexibleSpace: FlexibleSpaceBar(
                            titlePadding: const EdgeInsets.symmetric(
                                horizontal: 56, vertical: 12),
                            title: Text(
                              widget.scenario.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: theme.colorScheme.onSurface,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            centerTitle: true,
                            background: _buildHeaderBackground(theme),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final message = state.messages[index];
                                return _buildMessage(message, theme);
                              },
                              childCount: state.messages.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Quests Overlay
                    if (widget.scenario.quests.isNotEmpty)
                      Positioned(
                        top: 240, // Below expanded app bar
                        right: 12,
                        child: _QuestsFloatingButton(
                            quests: widget.scenario.quests),
                      ),
                  ],
                ),
              ),
              // Input Area at the bottom
              _buildInputArea(state, theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderBackground(ThemeData theme) {
    if (widget.scenario.hasAvatar) {
      return SafeArea(
        bottom: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              widget.scenario.resolvedAvatarAssetPath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  _buildPlaceholderHeader(theme),
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
      );
    }
    return _buildPlaceholderHeader(theme);
  }

  Widget _buildPlaceholderHeader(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    final char = widget.scenario.personaName.isNotEmpty
        ? widget.scenario.personaName[0]
        : (widget.scenario.title.isNotEmpty ? widget.scenario.title[0] : '悟');
    return SafeArea(
      bottom: false,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark
                    ? [
                        theme.colorScheme.primary.withValues(alpha: 0.25),
                        const Color(0xFF1E1E24),
                        theme.colorScheme.surface,
                      ]
                    : [
                        theme.colorScheme.primary.withValues(alpha: 0.12),
                        const Color(0xFFF3EFE6),
                        theme.colorScheme.surface,
                      ],
              ),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: const SizedBox(),
            ),
          ),
          Positioned(
            top: 24,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark
                      ? const Color(0xFF2C2C34)
                      : const Color(0xFFFAF7F0),
                  border: Border.all(
                    color: const Color(0xFFD4AF37)
                        .withValues(alpha: isDark ? 0.7 : 0.8),
                    width: 2.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD4AF37).withValues(alpha: 0.25),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    char,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? const Color(0xFFFFD54F)
                          : const Color(0xFF8C6B1C),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
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
    return Container(
      color: theme.colorScheme.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.1)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: HanziTextField(
                          controller: _textController,
                          style: theme.textTheme.bodyLarge,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: state.isProcessing
                                ? AppLocalizations.of(context)!.thinking
                                : (state.isRecording
                                    ? AppLocalizations.of(context)!.listening
                                    : AppLocalizations.of(context)!
                                        .typeYourMessage),
                            hintStyle: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.4),
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                          onSubmitted: (_) => _handleSubmitted(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: _textController,
                builder: (context, value, child) {
                  final isTextMode = value.text.trim().isNotEmpty;

                  if (isTextMode) {
                    return GestureDetector(
                      onTap: state.isProcessing
                          ? null
                          : () {
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
                        ),
                        child: Icon(Icons.send_rounded,
                            color: theme.colorScheme.onPrimary, size: 24),
                      ),
                    );
                  } else {
                    return Listener(
                      onPointerDown: (_) {
                        if (!state.isProcessing) {
                          ref
                              .read(conversationControllerProvider.notifier)
                              .startRecording();
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
                                : theme.colorScheme.primary
                                    .withValues(alpha: 0.1),
                          ),
                          child: Icon(
                            state.isRecording ? Icons.mic : Icons.mic_none,
                            color: state.isRecording
                                ? Colors.white
                                : theme.colorScheme.primary,
                            size: 24,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreBadge(
      PronunciationGrade grade, ThemeData theme, bool isUser) {
    final scoreVal = grade.score;
    if (scoreVal == null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Grading...',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      );
    }
    // Compute effective score from dimensions when overall is 0
    final effectiveScore = scoreVal > 0
        ? scoreVal
        : ((grade.accuracy + grade.completeness + grade.fluency) / 3).round();

    final color =
        effectiveScore >= 80 ? Colors.green.shade600 : Colors.red.shade600;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          effectiveScore.toString(),
          style: theme.textTheme.titleMedium?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 4),
        Text(AppLocalizations.of(context)!.scoreText,
            style: theme.textTheme.labelSmall
                ?.copyWith(color: color.withValues(alpha: 0.7))),
        if (scoreVal == 0 && effectiveScore > 0) ...[
          const SizedBox(width: 4),
          Text(
            '(estimated)',
            style: theme.textTheme.labelSmall?.copyWith(
              fontStyle: FontStyle.italic,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMessage(GradedChatMessage message, ThemeData theme) {
    final isUser = message.role == ChatRole.user;
    final isExpanded = _translationVisibility[message.id] ?? false;

    return GestureDetector(
      onTap: () {
        if (isUser && message.grade != null) {
          showModalBottomSheet(
            context: context,
            useRootNavigator: true,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => PronunciationReportSheet(message: message),
          );
        }
      },
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
          decoration: BoxDecoration(
            color: isUser
                ? theme.colorScheme.primary.withValues(alpha: 0.1)
                : theme.cardTheme.color,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: Radius.circular(isUser ? 20 : 4),
              bottomRight: Radius.circular(isUser ? 4 : 20),
            ),
            border: Border.all(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
            boxShadow: [
              if (!isUser)
                BoxShadow(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4))
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
                      quickLookPresentation:
                          QuickLookPresentation.readingPopover,
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
                    quickLookPresentation: QuickLookPresentation.readingPopover,
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
                // AI Message with Pinyin
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.volume_up,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.4),
                          size: 20),
                      onPressed: () {
                        ref.read(audioServiceProvider).playSentence(
                            message.content,
                            voiceName: widget.scenario.voiceName);
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TappableMarkdownHanziText(
                            message.content,
                            quickLookPresentation:
                                QuickLookPresentation.readingPopover,
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          if (isExpanded) ...[
                            Builder(
                              builder: (context) {
                                final pinyin = (message.pinyin != null &&
                                        message.pinyin!.isNotEmpty)
                                    ? message.pinyin!
                                    : PinyinHelper.getPinyinE(message.content,
                                        separator: ' ',
                                        format: PinyinFormat.WITH_TONE_MARK);
                                if (pinyin.isEmpty) {
                                  return const SizedBox.shrink();
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    pinyin,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.6),
                                    ),
                                  ),
                                );
                              },
                            ),
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
                                          ? AppLocalizations.of(context)!
                                              .hideTranslation
                                          : AppLocalizations.of(context)!
                                              .translate,
                                      style:
                                          theme.textTheme.labelSmall?.copyWith(
                                        color: theme.colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          if (message.suggestion != null) ...[
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary
                                    .withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: theme.colorScheme.primary
                                        .withValues(alpha: 0.2)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.lightbulb_outline,
                                          size: 16,
                                          color: theme.colorScheme.primary),
                                      const SizedBox(width: 4),
                                      Text(
                                          AppLocalizations.of(context)!
                                              .suggestion,
                                          style: theme.textTheme.labelSmall
                                              ?.copyWith(
                                                  color:
                                                      theme.colorScheme.primary,
                                                  fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  TappableHanziText(
                                    message.suggestion!['chinese'] ?? '',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.primary),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    message.suggestion!['pinyin'] ?? '',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                        color: theme.colorScheme.onSurface
                                            .withValues(alpha: 0.6)),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    message.suggestion!['english'] ?? '',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                        color: theme.colorScheme.onSurface
                                            .withValues(alpha: 0.8),
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            ),
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
    return Column(
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
                    Text(
                      AppLocalizations.of(context)!.questsTitle,
                      style: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          letterSpacing: 1),
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
                            child: RegExp(r'[\u4e00-\u9fa5]').hasMatch(q)
                                ? TranslatedText(
                                    q,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        height: 1.3),
                                  )
                                : Text(
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
    );
  }
}
