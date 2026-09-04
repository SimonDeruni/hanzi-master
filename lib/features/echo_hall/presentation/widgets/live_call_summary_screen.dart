import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import '../screens/live_call_screen.dart';
import '../../../chat/domain/entities/chat_message.dart';
import 'package:hanzi_master/core/models/pronunciation_grade.dart';
import 'package:hanzi_master/features/echo_hall/presentation/widgets/pronunciation_report_sheet.dart';
import 'tone_comparison_sheet.dart';

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
              // 1. Azure Acoustic Pronunciation Metrics Card
              _buildAcousticScoreBanner(context, theme),

              // 2. AI Pattern Analysis Card
              _buildVerdictCard(context, theme),

              const SizedBox(height: 32),

              Text(AppLocalizations.of(context)!.conversationReview,
                  style:
                      theme.textTheme.titleSmall?.copyWith(letterSpacing: 2)),
              const SizedBox(height: 16),

              // 2. Graded Transcript List
              ...transcript
                  .map((msg) => _buildSummaryBubble(context, msg, theme)),

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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(AppLocalizations.of(context)!.completeReview,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAcousticScoreBanner(BuildContext context, ThemeData theme) {
    int totalScore = 0;
    int totalAcc = 0;
    int totalFlu = 0;
    int count = 0;
    for (final msg in transcript) {
      if (msg.role == ChatRole.user &&
          msg.grade != null &&
          msg.grade!['score'] != null) {
        totalScore += (msg.grade!['score'] as num).toInt();
        totalAcc +=
            ((msg.grade!['accuracy'] ?? msg.grade!['score']) as num).toInt();
        totalFlu +=
            ((msg.grade!['fluency'] ?? msg.grade!['score']) as num).toInt();
        count++;
      }
    }

    if (count == 0) return const SizedBox.shrink();

    final avgScore = (totalScore / count).round();
    final avgAcc = (totalAcc / count).round();
    final avgFlu = (totalFlu / count).round();

    final isGood = avgScore >= 80;
    final isMedium = avgScore >= 65 && avgScore < 80;
    final accentColor = isGood
        ? const Color(0xFF10B981)
        : (isMedium ? const Color(0xFFF59E0B) : const Color(0xFFEF4444));

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accentColor.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.graphic_eq, color: accentColor, size: 20),
              const SizedBox(width: 8),
              Text(
                "AZURE PRONUNCIATION ASSESSMENT",
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: accentColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetricItem(
                  "Overall Score", "$avgScore%", accentColor, theme),
              _buildMetricItem("Tone Accuracy", "$avgAcc%",
                  theme.colorScheme.primary, theme),
              _buildMetricItem(
                  "Fluency", "$avgFlu%", const Color(0xFF3B82F6), theme),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(
      String label, String value, Color color, ThemeData theme) {
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildVerdictCard(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(24),
        border:
            Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
              color: theme.colorScheme.primary.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 10))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.psychology_outlined, color: theme.colorScheme.primary),
              const SizedBox(width: 12),
              Text(AppLocalizations.of(context)!.linguisticAnalysis,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          InteractiveMarkdownText(
              text: scholarVerdict, theme: theme, contextText: scholarVerdict),
        ],
      ),
    );
  }

  Widget _buildSummaryBubble(
      BuildContext context, LiveCallMessage msg, ThemeData theme) {
    final isUser = msg.role == ChatRole.user;
    final hasChinese = RegExp(r'[\u4e00-\u9fa5]').hasMatch(msg.text);
    final hasReviewableGrade = isUser &&
        hasChinese &&
        msg.grade != null &&
        (msg.grade!['words'] as List?)?.isNotEmpty == true;

    final bubble = Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUser
            ? theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                isUser ? "YOU" : "SCHOLAR",
                style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.4)),
              ),
              if (hasReviewableGrade) ...[
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
          if (hasReviewableGrade)
            _buildGradedRow(context, msg, msg.grade!['words'] ?? [], theme)
          else
            Text(msg.text,
                style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: !isUser ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );

    if (!hasReviewableGrade) return bubble;

    return GestureDetector(
      onTap: () => _showPronunciationReviewSheet(context, msg, theme),
      child: bubble,
    );
  }

  void _showPronunciationReviewSheet(
      BuildContext context, LiveCallMessage msg, ThemeData theme) {
    PronunciationGrade? parsedGrade;
    if (msg.grade != null) {
      try {
        parsedGrade = PronunciationGrade.fromJson(msg.grade!);
      } catch (e) {
        debugPrint("Error parsing grade: $e");
      }
    }

    final gradedMsg = GradedChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: msg.text,
      role: msg.role,
      timestamp: msg.timestamp,
      grade: parsedGrade,
      audioPath: msg.audioPath,
    );

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return PronunciationReportSheet(message: gradedMsg);
      },
    );
  }

  Widget _buildGradedRow(BuildContext context, LiveCallMessage msg,
      List<dynamic> words, ThemeData theme) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: words.map((w) {
        final bool correct = w['isCorrect'] ?? true;
        final bool partial = w['isPartial'] ?? false;
        final word = w['word'] ?? "";
        final pinyin = w['pinyin'] ?? "";
        final int expectedTone = w['expectedTone'] ?? 1;
        final int actualTone = w['actualTone'] ?? 1;
        final String feedback = w['feedback'] ?? "";

        final Color color = correct
            ? Colors.green.shade700
            : partial
                ? const Color(0xFFD97706)
                : Colors.red.shade700;

        return InkWell(
          onTap: () {
            ToneComparisonSheet.show(
              context,
              character: word,
              pinyin: pinyin,
              expectedTone: expectedTone,
              actualTone: actualTone,
              feedback: feedback,
            );
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Column(
              children: [
                Text(pinyin,
                    style: theme.textTheme.labelSmall?.copyWith(fontSize: 11)),
                Text(
                  word,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class InteractiveMarkdownText extends StatefulWidget {
  final String text;
  final ThemeData theme;
  final String contextText;

  const InteractiveMarkdownText({
    super.key,
    required this.text,
    required this.theme,
    required this.contextText,
  });

  @override
  State<InteractiveMarkdownText> createState() =>
      _InteractiveMarkdownTextState();
}

class _InteractiveMarkdownTextState extends State<InteractiveMarkdownText> {
  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void dispose() {
    for (final r in _recognizers) {
      r.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = widget.theme.textTheme.bodyLarge?.copyWith(height: 1.6);
    final spans = <TextSpan>[];

    // Pattern to match bold, italic, underline OR Chinese characters
    final pattern =
        RegExp(r'(\*\*(.+?)\*\*)|(\*(.+?)\*)|(__(.+?)__)|([\u4e00-\u9fff]+)');

    int lastEnd = 0;
    for (final match in pattern.allMatches(widget.text)) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: widget.text.substring(lastEnd, match.start)));
      }

      if (match.group(1) != null) {
        spans.add(TextSpan(
          text: match.group(2),
          style: baseStyle?.copyWith(fontWeight: FontWeight.bold),
        ));
      } else if (match.group(3) != null) {
        spans.add(TextSpan(
          text: match.group(4),
          style: baseStyle?.copyWith(fontStyle: FontStyle.italic),
        ));
      } else if (match.group(5) != null) {
        spans.add(TextSpan(
          text: match.group(6),
          style: baseStyle?.copyWith(decoration: TextDecoration.underline),
        ));
      } else if (match.group(7) != null) {
        final hanzi = match.group(7)!;
        Offset? anchorPosition;
        final recognizer = TapGestureRecognizer()
          ..onTapDown = (details) {
            anchorPosition = details.globalPosition;
          }
          ..onTap = () => showQuickLook(
                context,
                hanzi,
                contextText: widget.contextText,
                presentation: QuickLookPresentation.readingPopover,
                anchorPosition: anchorPosition,
              );
        _recognizers.add(recognizer);

        spans.add(TextSpan(
          text: hanzi,
          style: baseStyle?.copyWith(
            color: widget.theme.colorScheme.primary,
            decoration: TextDecoration.underline,
            decorationColor:
                widget.theme.colorScheme.primary.withValues(alpha: 0.5),
          ),
          recognizer: recognizer,
        ));
      }

      lastEnd = match.end;
    }

    if (lastEnd < widget.text.length) {
      spans.add(TextSpan(text: widget.text.substring(lastEnd)));
    }

    if (spans.isEmpty) {
      return Text(widget.text, style: baseStyle);
    }

    return RichText(
      text: TextSpan(style: baseStyle, children: spans),
    );
  }
}
