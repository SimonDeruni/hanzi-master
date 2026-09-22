import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/daily_deck_activity.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/domain/logic/daily_study_metrics.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/deck_review_session_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/study_mode_selection_sheet.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';

class DailyStudyDashboardScreen extends ConsumerWidget {
  const DailyStudyDashboardScreen({super.key, required this.deck});
  final Deck deck;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardsAsync = ref.watch(flashcardControllerProvider);
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.todayDashboard)),
      body: cardsAsync.when(
        loading: () => const Center(child: ZenLoader()),
        error: (_, __) => Center(
            child: Text(AppLocalizations.of(context)!.studySessionLoadFailed)),
        data: (allCards) {
          final cards = allCards.where((c) => c.deckId == deck.id).toList();
          return FutureBuilder<DailyDeckActivity>(
            future: ref.read(studyActivityRepositoryProvider).activityForDay(
                  deckId: deck.id,
                  cards: cards,
                  now: DateTime.now(),
                ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: ZenLoader());
              }
              final metrics = DailyStudyMetrics.calculate(
                cards: cards,
                activity: snapshot.data!,
                mode: StudyMode.reading,
                now: DateTime.now(),
              );
              return _DashboardBody(deck: deck, cards: cards, metrics: metrics);
            },
          );
        },
      ),
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody(
      {required this.deck, required this.cards, required this.metrics});
  final Deck deck;
  final List<Flashcard> cards;
  final DailyStudyMetrics metrics;

  void _launch(BuildContext context, {required bool studyAhead}) {
    StudyModeSelectionSheet.show(context, onModeSelected: (mode) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DeckReviewSessionScreen(
            deckId: deck.id,
            mode: mode,
            studyAhead: studyAhead,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final newProgress = deck.dailyNewCardsLimit <= 0
        ? 0.0
        : (metrics.introducedToday / deck.dailyNewCardsLimit)
            .clamp(0, 1)
            .toDouble();
    final reviewProgress = deck.dailyReviewLimit <= 0
        ? 0.0
        : (metrics.reviewedToday / deck.dailyReviewLimit)
            .clamp(0, 1)
            .toDouble();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(deck.localizedName(context), style: theme.textTheme.headlineSmall),
        const SizedBox(height: 4),
        Text(DateFormat.yMMMMEEEEd().format(DateTime.now()),
            style: theme.textTheme.bodyMedium),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              _GoalRow(l10n.newCardsLabel, metrics.introducedToday,
                  deck.dailyNewCardsLimit, newProgress, Colors.green),
              const SizedBox(height: 18),
              _GoalRow(l10n.reviews, metrics.reviewedToday,
                  deck.dailyReviewLimit, reviewProgress, Colors.indigo),
            ]),
          ),
        ),
        const SizedBox(height: 12),
        Row(children: [
          _CountCard(l10n.dueNow, metrics.dueNow, Icons.notifications_active,
              Colors.orange),
          const SizedBox(width: 10),
          _CountCard(
              l10n.learning, metrics.learningNow, Icons.school, Colors.green),
          const SizedBox(width: 10),
          _CountCard(
              l10n.scheduled, metrics.futureReviews, Icons.event, Colors.blue),
        ]),
        const SizedBox(height: 20),
        Text(l10n.sevenDayForecast,
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        SizedBox(
          height: 130,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(metrics.forecast.length, (index) {
              final max =
                  metrics.forecast.fold<int>(1, (a, b) => b > a ? b : a);
              final count = metrics.forecast[index];
              final date = DateTime.now().add(Duration(days: index));
              return Expanded(
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text('$count', style: theme.textTheme.bodySmall),
                  const SizedBox(height: 4),
                  Container(
                    width: 18,
                    height: 12 + 70 * count / max,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(DateFormat.E().format(date).substring(0, 1)),
                ]),
              );
            }),
          ),
        ),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed:
              cards.isEmpty ? null : () => _launch(context, studyAhead: false),
          icon: const Icon(Icons.play_arrow),
          label: Text(l10n.studyToday),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: metrics.futureReviews == 0
              ? null
              : () => _launch(context, studyAhead: true),
          icon: const Icon(Icons.fast_forward),
          label: Text(l10n.studyAhead),
        ),
        const SizedBox(height: 6),
        Text(l10n.studyAheadDescription,
            textAlign: TextAlign.center, style: theme.textTheme.bodySmall),
      ],
    );
  }
}

class _GoalRow extends StatelessWidget {
  const _GoalRow(this.label, this.value, this.limit, this.progress, this.color);
  final String label;
  final int value;
  final int limit;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) => Column(children: [
        Row(children: [
          Text(label),
          const Spacer(),
          Text('$value / $limit',
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ]),
        const SizedBox(height: 8),
        LinearProgressIndicator(
            value: progress,
            color: color,
            minHeight: 9,
            borderRadius: BorderRadius.circular(8)),
      ]);
}

class _CountCard extends StatelessWidget {
  const _CountCard(this.label, this.value, this.icon, this.color);
  final String label;
  final int value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Column(children: [
              Icon(icon, color: color),
              const SizedBox(height: 5),
              Text('$value', style: Theme.of(context).textTheme.titleLarge),
              Text(label,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall),
            ]),
          ),
        ),
      );
}
