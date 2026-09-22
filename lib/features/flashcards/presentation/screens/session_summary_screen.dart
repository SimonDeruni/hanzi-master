import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/analytics_service.dart';
import 'package:hanzi_master/core/services/app_rating_service.dart';
import 'package:hanzi_master/core/services/notification_service.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_session_summary.dart';
import 'package:hanzi_master/features/progression/data/study_progress_service.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/core/services/zen_sound_service.dart';

class SessionSummaryScreen extends ConsumerStatefulWidget {
  const SessionSummaryScreen({super.key, required this.summary});

  final StudySessionSummary summary;

  @override
  ConsumerState<SessionSummaryScreen> createState() =>
      _SessionSummaryScreenState();
}

class _SessionSummaryScreenState extends ConsumerState<SessionSummaryScreen> {
  StudySessionSummary get summary => widget.summary;

  @override
  void initState() {
    super.initState();
    ZenSoundService.instance.playBellChime();
    Future<void>(() async {
      try {
        final wasAdded = await ref
            .read(studyProgressServiceProvider)
            .recordCompletedSession(summary);
        if (!wasAdded) return;
        ref.invalidate(studyProgressProvider);
        await ref.read(notificationServiceProvider).recordPracticeCompleted();
      } catch (error) {
        debugPrint('Could not update completed-session habits: $error');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final accuracy = (summary.accuracy * 100).round();
    final minutes = summary.duration.inMinutes;
    final seconds = summary.duration.inSeconds.remainder(60);

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          children: [
            Icon(accuracy >= 80 ? Icons.emoji_events : Icons.insights,
                size: 72, color: accuracy >= 80 ? Colors.amber : Colors.indigo),
            const SizedBox(height: 8),
            Text(l10n.sessionComplete,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            if (summary.studyAhead)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(l10n.studyAheadComplete,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: theme.colorScheme.primary)),
              ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  Text('$accuracy%',
                      style: theme.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: accuracy >= 80 ? Colors.green : Colors.orange,
                      )),
                  Text(l10n.accuracy),
                  const SizedBox(height: 20),
                  Row(children: [
                    _Metric(l10n.uniqueCardsStudied, '${summary.uniqueCards}'),
                    _Metric(l10n.attempts, '${summary.totalAttempts}'),
                    _Metric(l10n.duration,
                        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}'),
                  ]),
                ]),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.answerBreakdown,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    _RatingBar(l10n.again, summary.againCount, Colors.red),
                    _RatingBar(l10n.hard, summary.hardCount, Colors.orange),
                    _RatingBar(l10n.good, summary.goodCount, Colors.green),
                    _RatingBar(l10n.easy, summary.easyCount, Colors.blue),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(children: [
                  _Metric(l10n.newCardsLabel, '${summary.newCards}'),
                  _Metric(l10n.reviewCards, '${summary.reviewCards}'),
                  _Metric(l10n.retries, '${summary.retryAttempts}'),
                  _Metric(l10n.needsPractice, '${summary.needsPractice}'),
                ]),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                final ratingService = ref.read(appRatingServiceProvider);
                final analytics = ref.read(analyticsServiceProvider);
                Navigator.of(context).popUntil((route) => route.isFirst);
                Future<void>.delayed(const Duration(milliseconds: 500),
                    () async {
                  final result =
                      await ratingService.registerCompletedSession(summary);
                  if (result == RatingPromptResult.requested) {
                    await analytics
                        .logEvent('app_rating_requested', parameters: {
                      'trigger': 'study_session_complete',
                      'cards': summary.uniqueCards,
                      'accuracy_percent': (summary.accuracy * 100).round(),
                    });
                  }
                });
              },
              icon: const Icon(Icons.home_outlined),
              label: Text(l10n.backToLibrary),
            ),
          ],
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric(this.label, this.value);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Column(children: [
          Text(value,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 3),
          Text(label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall),
        ]),
      );
}

class _RatingBar extends StatelessWidget {
  const _RatingBar(this.label, this.count, this.color);
  final String label;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        // A Table lets the localized label column grow with the language while
        // the bar absorbs the remaining width - no fixed pixel widths, so the
        // labels can never overflow in German, Russian, Vietnamese, etc.
        child: Table(
          columnWidths: const {
            0: IntrinsicColumnWidth(), // label sizes itself to the translation
            1: FlexColumnWidth(), // bar takes whatever space is left
            2: IntrinsicColumnWidth(), // count sizes itself
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  // Two lines are allowed before truncating, never overflow.
                  child: Text(
                    label,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: LinearProgressIndicator(
                    value: count == 0 ? 0 : (count / 10).clamp(0, 1),
                    color: color,
                    backgroundColor: color.withValues(alpha: .12),
                    borderRadius: BorderRadius.circular(8),
                    minHeight: 8,
                  ),
                ),
                Text('$count', textAlign: TextAlign.end),
              ],
            ),
          ],
        ),
      );
}
