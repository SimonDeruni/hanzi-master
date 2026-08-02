import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/models/pronunciation_grade.dart';
import '../../../../core/services/audio_service.dart';
import '../../../../core/services/gemini_service.dart';
import '../../../chat/domain/entities/chat_message.dart';
import '../providers/conversation_controller.dart';

class PronunciationReportSheet extends ConsumerStatefulWidget {
  final GradedChatMessage message;

  const PronunciationReportSheet({super.key, required this.message});

  @override
  ConsumerState<PronunciationReportSheet> createState() => _PronunciationReportSheetState();
}

class _PronunciationReportSheetState extends ConsumerState<PronunciationReportSheet> {
  Map<String, String>? _intendedMeaning;
  bool _isLoadingIntention = true;
  bool _isRegrading = false;

  @override
  void initState() {
    super.initState();
    if (widget.message.audioPath != null) {
      _fetchIntention();
    } else {
      _isLoadingIntention = false;
    }
  }

  Future<void> _fetchIntention() async {
    final chatHistory = ref.read(conversationControllerProvider.notifier).getChatHistory(widget.message.id);
    final gemini = ref.read(geminiServiceProvider);
    
    final result = await gemini.guessIntendedMeaning(chatHistory, widget.message.content);
    if (mounted) {
      setState(() {
        _intendedMeaning = result;
        _isLoadingIntention = false;
      });
    }
  }

  void _handleRegrade() async {
    if (_intendedMeaning == null) return;
    setState(() => _isRegrading = true);
    
    await ref.read(conversationControllerProvider.notifier).regradeMessage(
      widget.message.id,
      _intendedMeaning!['intendedHanzi'] ?? "",
      _intendedMeaning!['intendedPinyin'] ?? "",
    );
    
    if (mounted) {
      Navigator.pop(context); 
    }
  }

  @override
  Widget build(BuildContext context) {
    final grade = widget.message.grade;
    if (grade == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surfaceColor = theme.colorScheme.surface;
    final onSurface = theme.colorScheme.onSurface;
    final subtitleColor = onSurface.withValues(alpha: 0.6);

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Report',
                style: theme.textTheme.titleLarge?.copyWith(color: onSurface),
              ),
              IconButton(
                icon: Icon(Icons.close, color: subtitleColor),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Character Breakdown
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: isDark ? 0.3 : 0.5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.dividerColor),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: grade.words.map((w) => _buildCharacterColumn(w, theme)).toList(),
                ),
                const Divider(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    final sentence = grade.words.map((w) => w.word).join('');
                    ref.read(audioServiceProvider).playSentence(sentence);
                  },
                  icon: const Icon(Icons.volume_up, size: 20),
                  label: const Text('Play Reference Pronunciation', style: TextStyle(fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade50,
                    foregroundColor: Colors.orange.shade800,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.orange.shade200),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // AI Intention
          if (widget.message.audioPath != null)
            _buildAiIntentionBox(theme),

          const SizedBox(height: 16),
          
          // Good tag
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    Text(
                      grade.score?.toString() ?? 'N/A',
                      style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_upward, size: 12, color: Colors.orange),
                    const SizedBox(width: 8),
                    Text(
                      grade.score != null ? (grade.score! >= 80 ? 'Great!' : 'Keep trying!') : 'Pending...',
                      style: TextStyle(fontWeight: FontWeight.bold, color: onSurface),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Metrics
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetricDial('Accuracy', grade.accuracy, Colors.orange, theme),
              _buildMetricDial('Completeness', grade.completeness, Colors.green, theme),
              _buildMetricDial('Fluency', grade.fluency, Colors.orange, theme),
            ],
          ),
          const SizedBox(height: 24),

          // Detailed Feedback
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? Colors.yellow.shade50.withValues(alpha: 0.15) : Colors.yellow.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.yellow.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.auto_awesome, size: 16, color: Colors.orange),
                    SizedBox(width: 8),
                    Text(
                      'Good pronunciation, but can be better!',
                      style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(color: Colors.orange, height: 24),
                Text(
                  grade.overallFeedback,
                  style: TextStyle(color: Colors.orange.shade900, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAiIntentionBox(ThemeData theme) {
    if (_isLoadingIntention) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    if (_intendedMeaning == null || _intendedMeaning!['intendedHanzi'] == widget.message.content) {
      return const SizedBox.shrink();
    }

    final onSurface = theme.colorScheme.onSurface;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.blue.shade50.withValues(alpha: 0.15) : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.psychology, size: 18, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                'Did you mean to say...?',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _intendedMeaning!['intendedHanzi'] ?? "",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: onSurface),
          ),
          Text(
            _intendedMeaning!['intendedPinyin'] ?? "",
            style: TextStyle(fontSize: 14, color: onSurface.withValues(alpha: 0.6)),
          ),
          const SizedBox(height: 4),
          Text(
            _intendedMeaning!['englishTranslation'] ?? "",
            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: onSurface.withValues(alpha: 0.6)),
          ),
          const SizedBox(height: 12),
          if (_isRegrading)
            const Center(child: CircularProgressIndicator())
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _intendedMeaning = null;
                    });
                  },
                  child: const Text('No'),
                ),
                ElevatedButton(
                  onPressed: _handleRegrade,
                  child: const Text('Yes, Re-Grade Me!'),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildCharacterColumn(SyllableGrade word, ThemeData theme) {
    final color = word.isCorrect
        ? Colors.green
        : word.isPartial
            ? Colors.orange
            : Colors.red;
    final onSurface = theme.colorScheme.onSurface;

    return Column(
      children: [
        // Pinyin
        Text(
          word.pinyin,
          style: TextStyle(fontSize: 14, color: onSurface.withValues(alpha: 0.6)),
        ),
        const SizedBox(height: 2),
        // Hanzi
        Text(
          word.word,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: onSurface),
        ),
        const SizedBox(height: 2),
        // English meaning
        if (word.english != null && word.english!.isNotEmpty)
          Text(
            word.english!,
            style: TextStyle(fontSize: 10, color: onSurface.withValues(alpha: 0.5), fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        // Score / icon
        Text(
          word.wordScore > 0 ? word.wordScore.toString() : (word.isCorrect ? '\u2713' : word.isPartial ? '~' : '\u2717'),
          style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildMetricDial(String label, int value, Color color, ThemeData theme) {
    final onSurface = theme.colorScheme.onSurface;
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: value / 100,
                color: color,
                backgroundColor: color.withValues(alpha: 0.1),
                strokeWidth: 4,
              ),
            ),
            Text(
              value.toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: onSurface),
        ),
      ],
    );
  }
}