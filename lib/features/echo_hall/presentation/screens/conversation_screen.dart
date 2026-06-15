import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/scenario.dart';
import '../providers/conversation_controller.dart';
import '../../../../core/models/pronunciation_grade.dart';
import '../../../chat/domain/entities/chat_message.dart';
import '../widgets/pronunciation_report_sheet.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';

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
                    child: Image.asset(
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

            // 3. Floating Mic Pill
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: _buildFloatingMicPill(state, theme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingMicPill(ConversationState state, ThemeData theme) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Cancel Button
          IconButton(
            icon: Icon(Icons.close, color: theme.colorScheme.onSurface.withValues(alpha: 0.4)),
            onPressed: () => Navigator.pop(context),
          ),
          
          // Center Mic / Waveform
          Expanded(
            child: GestureDetector(
              onLongPressStart: (_) {
                ref.read(conversationControllerProvider.notifier).startRecording();
              },
              onLongPressEnd: (_) {
                ref.read(conversationControllerProvider.notifier).stopRecordingAndProcess();
              },
              child: Container(
                color: Colors.transparent, // expanded touch area
                child: Center(
                  child: state.isRecording
                      ? _buildSimulatedWaveform(theme)
                      : Text(
                          "Hold to Talk",
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                ),
              ),
            ),
          ),
          
          // Send Button Placeholder
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.mic, color: theme.colorScheme.onPrimary, size: 20),
              onPressed: () {
                // Future feature: tap to toggle recording
              },
            ),
          ),
        ],
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
                      child: Text(
                        message.content,
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
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
    final color = word.isCorrect ? Colors.green.shade600 : Colors.red.shade600;
    return Column(
      children: [
        Text(
          word.pinyin,
          style: theme.textTheme.labelMedium,
        ),
        Text(
          word.word,
          style: theme.textTheme.titleLarge?.copyWith(color: color),
        ),
      ],
    );
  }
}
