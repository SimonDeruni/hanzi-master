import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/scenario.dart';
import '../providers/conversation_controller.dart';
import '../../../../core/models/pronunciation_grade.dart';
import '../../../chat/domain/entities/chat_message.dart';
import '../widgets/pronunciation_report_sheet.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/tappable_hanzi_text.dart';

class ConversationScreen extends ConsumerStatefulWidget {
  final ConversationScenario scenario;

  const ConversationScreen({super.key, required this.scenario});

  @override
  ConsumerState<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends ConsumerState<ConversationScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(conversationControllerProvider.notifier).startScenario(widget.scenario);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 200, // buffer for new message
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(conversationControllerProvider);
    final theme = Theme.of(context);

    ref.listen(conversationControllerProvider.select((state) => state.messages.length), (previous, next) {
      if (previous != null && next > previous) {
        Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
      }
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.scenario.title, style: const TextStyle(color: Colors.transparent)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: CalligraphyBackground(
        child: Stack(
          children: [
            // 1. Avatar Image at Top (Cover)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.45,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 1.0, end: 1.05),
                duration: const Duration(seconds: 10),
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: (widget.scenario.avatarAssetPath == 'none' || widget.scenario.avatarAssetPath.isEmpty)
                      ? Container(
                          color: theme.colorScheme.primary,
                          child: Center(
                            child: Text(
                              widget.scenario.personaName.isNotEmpty ? widget.scenario.personaName[0].toUpperCase() : '?',
                              style: const TextStyle(color: Colors.white, fontSize: 100, fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : Image.asset(
                          widget.scenario.avatarAssetPath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: theme.colorScheme.primary.withValues(alpha: 0.1),
                            child: Center(
                              child: Icon(Icons.person, size: 100, color: theme.colorScheme.primary),
                            ),
                          ),
                        ),
                  );
                },
              ),
            ),

            // Quests Overlay
            if (widget.scenario.quests.isNotEmpty)
              Positioned(
                top: 100,
                left: 16,
                right: 16,
                child: _QuestsOverlay(quests: widget.scenario.quests),
              ),

            // 2. Chat Area
            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                  boxShadow: [
                    BoxShadow(color: theme.colorScheme.onSurface.withValues(alpha: 0.1), blurRadius: 20, offset: const Offset(0, -5))
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          final message = state.messages[index];
                          return _buildMessage(message, theme);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            if (state.isProcessing)
              Center(
                child: CircularProgressIndicator(color: theme.colorScheme.primary),
              ),

            if (state.error != null)
              Positioned(
                bottom: 120,
                left: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: theme.colorScheme.error.withValues(alpha: 0.9),
                  child: Text(
                    state.error!,
                    style: TextStyle(color: theme.colorScheme.onError),
                  ),
                ),
              ),

            // 3. Input Area
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildInputArea(state, theme),
            ),
          ],
        ),
      ),
    );
  }

  final TextEditingController _textController = TextEditingController();

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
                    border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          style: theme.textTheme.bodyLarge,
                          maxLines: 4,
                          minLines: 1,
                          decoration: InputDecoration(
                            hintText: state.isRecording ? "Listening..." : "Type your message...",
                            hintStyle: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                          onSubmitted: (val) {
                            if (val.trim().isNotEmpty) {
                              FocusScope.of(context).unfocus();
                              // We need a sendMessage method in ConversationController
                              ref.read(conversationControllerProvider.notifier).sendMessage(val);
                              _textController.clear();
                            }
                          },
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
                      onTap: state.isProcessing ? null : () {
                        FocusScope.of(context).unfocus();
                        ref.read(conversationControllerProvider.notifier).sendMessage(_textController.text);
                        _textController.clear();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.primary,
                        ),
                        child: Icon(Icons.send_rounded, color: theme.colorScheme.onPrimary, size: 24),
                      ),
                    );
                  } else {
                    return Listener(
                      onPointerDown: (_) {
                        if (!state.isProcessing) ref.read(conversationControllerProvider.notifier).startRecording();
                      },
                      onPointerUp: (_) {
                        if (!state.isProcessing) ref.read(conversationControllerProvider.notifier).stopRecordingAndProcess();
                      },
                      onPointerCancel: (_) {
                        if (!state.isProcessing) ref.read(conversationControllerProvider.notifier).stopRecordingAndProcess();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: state.isRecording ? Colors.redAccent : theme.colorScheme.primary.withValues(alpha: 0.1),
                        ),
                        child: Icon(
                          state.isRecording ? Icons.mic : Icons.mic_none,
                          color: state.isRecording ? Colors.white : theme.colorScheme.primary,
                          size: 24,
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

  Widget _buildSimulatedWaveform(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        15,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: 4,
          height: 10 + (index % 4) * 5.0, // pseudo random height
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildMessage(GradedChatMessage message, ThemeData theme) {
    final isUser = message.role == ChatRole.user;

    return GestureDetector(
      onTap: () {
        if (isUser && message.grade != null) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => PronunciationReportSheet(grade: message.grade!),
          );
        }
      },
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
          decoration: BoxDecoration(
            color: isUser ? theme.colorScheme.primary.withValues(alpha: 0.1) : theme.cardTheme.color,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: Radius.circular(isUser ? 20 : 4),
              bottomRight: Radius.circular(isUser ? 4 : 20),
            ),
            border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
            boxShadow: [
              if (!isUser)
                 BoxShadow(color: theme.colorScheme.onSurface.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (message.grade != null && isUser) ...[
                // User Graded Message
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message.grade!.score.toString(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: message.grade!.score >= 80 ? Colors.green.shade600 : Colors.red.shade600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text('score', style: theme.textTheme.labelSmall),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: message.grade!.words.map((w) => _buildGradedWord(w, theme)).toList(),
                ),
              ] else ...[
                // AI Message with Pinyin
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.volume_up, color: theme.colorScheme.onSurface.withValues(alpha: 0.4), size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TappableMarkdownHanziText(
                            message.content,
                            style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          if (message.pinyin != null && message.pinyin!.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              message.pinyin!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                          if (message.english != null && message.english!.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              message.english!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                          if (message.suggestion != null) ...[
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.2)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.lightbulb_outline, size: 16, color: theme.colorScheme.primary),
                                      const SizedBox(width: 4),
                                      Text("Suggestion", style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  TappableHanziText(
                                    message.suggestion!['chinese'] ?? '',
                                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.primary),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    message.suggestion!['pinyin'] ?? '',
                                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    message.suggestion!['english'] ?? '',
                                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.8), fontStyle: FontStyle.italic),
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
      WordGradeLevel.wrong   => Colors.red.shade600,
    };
    final isClickable = word.gradeLevel != WordGradeLevel.correct && word.feedback.isNotEmpty;

    return GestureDetector(
      onTap: isClickable ? () => _showWordFeedbackDialog(word, color, theme) : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(word.pinyin, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(height: 2),
          Stack(
            alignment: Alignment.topRight,
            children: [
              Text(word.word, style: theme.textTheme.titleLarge?.copyWith(color: color, fontWeight: FontWeight.bold)),
              if (isClickable)
                Positioned(
                  top: 0, right: -2,
                  child: Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _showWordFeedbackDialog(SyllableGrade word, Color color, ThemeData theme) {
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
                width: 72, height: 72,
                decoration: BoxDecoration(color: color.withValues(alpha: 0.12), shape: BoxShape.circle),
                child: Center(child: Text(word.word, style: theme.textTheme.displaySmall?.copyWith(color: color, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(height: 8),
              Text(word.pinyin, style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
                child: Text(
                  word.gradeLevel == WordGradeLevel.partial ? l10n.pronunciationPartial : l10n.pronunciationWrong,
                  style: theme.textTheme.labelMedium?.copyWith(color: color, fontWeight: FontWeight.bold),
                ),
              ),
              if (word.expectedTone > 0) ...[
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _ToneChip(label: l10n.toneExpected, tone: word.expectedTone, color: Colors.green.shade600),
                    const SizedBox(width: 12),
                    _ToneChip(label: l10n.toneYouSaid, tone: word.actualTone, color: color),
                  ],
                ),
              ],
              const SizedBox(height: 16),
              Text(word.feedback, textAlign: TextAlign.center, style: theme.textTheme.bodyMedium?.copyWith(height: 1.5)),
              const SizedBox(height: 20),
              TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.gotIt)),
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
  const _ToneChip({required this.label, required this.tone, required this.color});

  static const _names = ['', '1st ˉ', '2nd ˊ', '3rd ˇ', '4th ˋ', 'neutral'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(label, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.5))),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(8)),
          child: Text(tone > 0 && tone < _names.length ? _names[tone] : '?', style: theme.textTheme.labelLarge?.copyWith(color: color, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

class _QuestsOverlay extends StatefulWidget {
  final List<String> quests;
  const _QuestsOverlay({required this.quests});

  @override
  State<_QuestsOverlay> createState() => _QuestsOverlayState();
}

class _QuestsOverlayState extends State<_QuestsOverlay> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.flag, color: Colors.amber, size: 20),
                const SizedBox(width: 8),
                const Text(
                  "ACTIVE QUESTS",
                  style: TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 1.2,
                  ),
                ),
                const Spacer(),
                Icon(
                  _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.white70,
                ),
              ],
            ),
            if (_expanded) ...[
              const SizedBox(height: 12),
              ...widget.quests.map((q) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6, right: 8),
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        q,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ]
          ],
        ),
      ),
    );
  }
}
