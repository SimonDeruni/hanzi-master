import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/scenario.dart';
import '../providers/conversation_controller.dart';
import '../../../../core/models/pronunciation_grade.dart';
import '../../../chat/domain/entities/chat_message.dart';
import '../widgets/pronunciation_report_sheet.dart';

class ConversationScreen extends ConsumerStatefulWidget {
  final ConversationScenario scenario;

  const ConversationScreen({super.key, required this.scenario});

  @override
  ConsumerState<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends ConsumerState<ConversationScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(conversationControllerProvider.notifier).startScenario(widget.scenario);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(conversationControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6), // Match image 2 background roughly
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.scenario.title, style: const TextStyle(color: Colors.transparent)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
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
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        return _buildMessage(message);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          if (state.isProcessing)
            const Center(
              child: CircularProgressIndicator(),
            ),

          if (state.error != null)
            Positioned(
              bottom: 120,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.red.withValues(alpha: 0.9),
                child: Text(
                  state.error!,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),

          // 3. Floating Mic Pill
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: _buildFloatingMicPill(state),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingMicPill(ConversationState state) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
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
            icon: const Icon(Icons.close, color: Colors.grey),
            onPressed: () {},
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
                      ? _buildSimulatedWaveform()
                      : const Text(
                          "Hold to Talk",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ),
            ),
          ),
          
          // Send Button
          Container(
            margin: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white, size: 20),
              onPressed: () {
                // Future feature: text input
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimulatedWaveform() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        15,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: 4,
          height: 10 + (index % 4) * 5.0, // pseudo random height
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildMessage(GradedChatMessage message) {
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
            color: isUser ? Colors.deepPurple.withValues(alpha: 0.1) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: isUser ? null : Border.all(color: Colors.grey.shade200),
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
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: message.grade!.score >= 80 ? Colors.green : Colors.red,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text('score', style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: message.grade!.words.map((w) => _buildGradedWord(w)).toList(),
                ),
              ] else ...[
                // AI Message with Pinyin
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.volume_up, color: Colors.grey, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        message.content,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

  Widget _buildGradedWord(SyllableGrade word) {
    final color = word.isCorrect ? Colors.green : Colors.red;
    return Column(
      children: [
        Text(
          word.pinyin,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(
          word.word,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
