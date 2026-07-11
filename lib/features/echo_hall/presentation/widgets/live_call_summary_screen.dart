import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import '../screens/live_call_screen.dart';
import '../../../chat/domain/entities/chat_message.dart';

class LiveCallSummaryScreen extends StatelessWidget {
  final List<LiveCallMessage> transcript;
  final String scholarVerdict;

  const LiveCallSummaryScreen({
    super.key,
    required this.transcript,
    required this.scholarVerdict,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.scholarsVerdict),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: CalligraphyBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. AI Pattern Analysis Card
              _buildVerdictCard(context, theme),
              
              const SizedBox(height: 32),
              
              Text("CONVERSATION REVIEW", style: theme.textTheme.titleSmall?.copyWith(letterSpacing: 2)),
              const SizedBox(height: 16),
              
              // 2. Graded Transcript List
              ...transcript.map((msg) => _buildSummaryBubble(context, msg, theme)),
              
              const SizedBox(height: 40),
              
              // 3. Action Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text("Complete Review", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerdictCard(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(color: theme.colorScheme.primary.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, 10))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.psychology_outlined, color: theme.colorScheme.primary),
              const SizedBox(width: 12),
              Text("Linguistic Analysis", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          _buildMarkdownText(scholarVerdict, theme),
        ],
      ),
    );
  }

  Widget _buildMarkdownText(String text, ThemeData theme) {
    final baseStyle = theme.textTheme.bodyLarge?.copyWith(height: 1.6);
    final spans = <TextSpan>[];
    final pattern = RegExp(r'(\*\*(.+?)\*\*)|(\*(.+?)\*)|(__(.+?)__)');

    int lastEnd = 0;
    for (final match in pattern.allMatches(text)) {
      // Text before this match
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: text.substring(lastEnd, match.start)));
      }

      if (match.group(1) != null) {
        // **bold**
        spans.add(TextSpan(
          text: match.group(2),
          style: baseStyle?.copyWith(fontWeight: FontWeight.bold),
        ));
      } else if (match.group(3) != null) {
        // *italic*
        spans.add(TextSpan(
          text: match.group(4),
          style: baseStyle?.copyWith(fontStyle: FontStyle.italic),
        ));
      } else if (match.group(5) != null) {
        // __underline__
        spans.add(TextSpan(
          text: match.group(6),
          style: baseStyle?.copyWith(decoration: TextDecoration.underline),
        ));
      }

      lastEnd = match.end;
    }

    // Remaining text after last match
    if (lastEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastEnd)));
    }

    // Fallback: plain text if no matches
    if (spans.isEmpty) {
      return Text(text, style: baseStyle);
    }

    return RichText(
      text: TextSpan(style: baseStyle, children: spans),
    );
  }

  Widget _buildSummaryBubble(BuildContext context, LiveCallMessage msg, ThemeData theme) {
    final isUser = msg.role == ChatRole.user;
    final bubble = Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUser ? theme.colorScheme.primary.withValues(alpha: 0.05) : theme.colorScheme.onSurface.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                isUser ? "YOU" : "SCHOLAR",
                style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.4)),
              ),
              if (isUser) ...[
                const Spacer(),
                Icon(
                  Icons.touch_app_outlined,
                  size: 14,
                  color: theme.colorScheme.primary.withValues(alpha: 0.5),
                ),
                const SizedBox(width: 4),
                Text(
                  "Tap to review",
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.primary.withValues(alpha: 0.5),
                    fontSize: 10,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          if (isUser && msg.grade != null)
            _buildGradedRow(context, msg, msg.grade!['words'] ?? [], theme)
          else
            Text(msg.text, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: !isUser ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );

    if (!isUser) return bubble;

    return GestureDetector(
      onTap: () => showQuickLook(context, msg.text),
      child: bubble,
    );
  }

  Widget _buildGradedRow(BuildContext context, LiveCallMessage msg, List<dynamic> words, ThemeData theme) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: words.map((w) {
        final bool correct = w['isCorrect'] ?? true;
        final word = w['word'] ?? "";
        return GestureDetector(
          onTap: () => showQuickLook(context, word, contextText: msg.text),
          child: Column(
            children: [
              Text(w['pinyin'] ?? "", style: theme.textTheme.labelSmall?.copyWith(fontSize: 10)),
              Text(
                word,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: correct ? Colors.green.shade700 : Colors.red.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
