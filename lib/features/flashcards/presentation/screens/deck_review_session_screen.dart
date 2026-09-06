import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/review_stats.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_session_summary.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/domain/logic/study_ahead_queue_builder.dart';
import 'package:hanzi_master/features/flashcards/domain/logic/study_queue_builder.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/review_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/session_summary_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/modes/reading_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/modes/recall_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/modes/listening_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/modes/speaking_mode.dart';

class DeckReviewSessionScreen extends ConsumerStatefulWidget {
  final String deckId;
  final StudyMode mode;
  final bool studyAhead;

  const DeckReviewSessionScreen({
    super.key,
    required this.deckId,
    required this.mode,
    this.studyAhead = false,
  });

  @override
  ConsumerState<DeckReviewSessionScreen> createState() =>
      _DeckReviewSessionScreenState();
}

class _DeckReviewSessionScreenState
    extends ConsumerState<DeckReviewSessionScreen> {
  List<Flashcard> _cardsToReview = [];
  int _currentIndex = 0;
  int _correctCount = 0;
  bool _isLoading = true;
  bool _isStarting = false;
  bool _isReviewRouteOpen = false;
  StudyQueue? _queue;
  String? _loadError;
  final Map<String, int> _retryCounts = {};
  final Map<int, int> _ratingCounts = {};
  DateTime? _startedAt;
  int _initialCardCount = 0;
  int _initialNewCount = 0;

  static const int _maxRetriesPerCard = 2;

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  Future<void> _loadCards() async {
    final cards = await ref
        .read(flashcardControllerProvider.notifier)
        .getCardsForDeck(widget.deckId);
    final deckResult =
        await ref.read(deckRepositoryProvider).getDeckById(widget.deckId);
    final deck = deckResult.fold((_) => null, (value) => value);

    if (!mounted) return;
    if (deck == null) {
      setState(() {
        _isLoading = false;
        _loadError = AppLocalizations.of(context)!.studySessionLoadFailed;
      });
      return;
    }

    final now = DateTime.now();
    late final StudyQueue queue;
    try {
      if (widget.studyAhead) {
        final aheadCards = StudyAheadQueueBuilder.build(
          cards: cards,
          mode: widget.mode,
          now: now,
          limit: deck.dailyReviewLimit,
        );
        queue = StudyQueue(
          cards: aheadCards,
          cardIdsToIntroduce: const {},
          newlyReservedCardIds: const {},
          reviewCardIdsToReserve: const {},
          dueCount: aheadCards.length,
          learningCount: 0,
          newCount: 0,
          emptyReason:
              aheadCards.isEmpty ? StudyQueueEmptyReason.noEligibleCards : null,
        );
      } else {
        final activity = await ref
            .read(studyActivityRepositoryProvider)
            .activityForDay(deckId: widget.deckId, cards: cards, now: now);
        queue = StudyQueueBuilder.build(
          cards: cards,
          mode: widget.mode,
          now: now,
          dailyNewLimit: deck.dailyNewCardsLimit,
          dailyReviewLimit: deck.dailyReviewLimit,
          introducedCardIds: activity.introducedCardIds,
          reviewedCardIds: activity.reviewedCardIds,
          modeIntroducedCardIds: activity.modeIntroductionKeys
              .where((key) => key.startsWith('${widget.mode.name}:'))
              .map((key) => key.substring(widget.mode.name.length + 1))
              .toSet(),
        );
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _loadError = AppLocalizations.of(context)!.studySessionLoadFailed;
      });
      return;
    }

    if (!mounted) return;
    setState(() {
      _queue = queue;
      _cardsToReview = List.of(queue.cards);
      _initialCardCount = queue.cards.length;
      _initialNewCount = queue.newCount;
      _isLoading = false;
      _loadError = null;
    });
  }

  Future<void> _startSession() async {
    if (_isStarting || _cardsToReview.isEmpty) return;
    setState(() => _isStarting = true);
    final now = DateTime.now();
    if (!widget.studyAhead) {
      final cards = await ref
          .read(flashcardControllerProvider.notifier)
          .getCardsForDeck(widget.deckId);
      final deckResult =
          await ref.read(deckRepositoryProvider).getDeckById(widget.deckId);
      final deck = deckResult.fold((_) => null, (value) => value);
      if (deck == null) {
        if (mounted) setState(() => _isStarting = false);
        return;
      }
      try {
        final reserved =
            await ref.read(studyActivityRepositoryProvider).reserveQueue(
                  deckId: widget.deckId,
                  cards: cards,
                  mode: widget.mode,
                  now: now,
                  dailyNewLimit: deck.dailyNewCardsLimit,
                  dailyReviewLimit: deck.dailyReviewLimit,
                );
        _queue = reserved;
        _cardsToReview = List.of(reserved.cards);
        _initialCardCount = reserved.cards.length;
        _initialNewCount = reserved.newCount;
      } catch (_) {
        if (mounted) {
          setState(() {
            _isStarting = false;
            _loadError = AppLocalizations.of(context)!.studySessionLoadFailed;
          });
        }
        return;
      }
    }
    if (_cardsToReview.isEmpty) {
      if (mounted) setState(() => _isStarting = false);
      return;
    }
    _startedAt = now;
    final controller = ref.read(flashcardControllerProvider.notifier);

    for (var index = 0; index < _cardsToReview.length; index++) {
      final card = _cardsToReview[index];
      if (!(_queue?.cardIdsToIntroduce.contains(card.id) ?? false)) continue;
      final stats = card.getStatsForMode(widget.mode).copyWith(
            introducedAt: now,
          );
      final updatedStats = Map<StudyMode, ReviewStats>.from(card.modeStats)
        ..[widget.mode] = stats;
      final updatedCard = card.copyWith(modeStats: updatedStats);
      await controller.updateFlashcard(updatedCard);
      _cardsToReview[index] = updatedCard;
    }

    if (!mounted) return;
    setState(() => _isStarting = false);
    _startNextReview();
  }

  Future<void> _startNextReview() async {
    if (_isReviewRouteOpen || !mounted) return;
    if (_currentIndex >= _cardsToReview.length) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SessionSummaryScreen(
              summary: StudySessionSummary(
                mode: widget.mode,
                startedAt: _startedAt ?? DateTime.now(),
                completedAt: DateTime.now(),
                uniqueCards: _initialCardCount,
                totalAttempts: _ratingCounts.values.fold(0, (a, b) => a + b),
                correctAttempts: _correctCount,
                newCards: _initialNewCount,
                reviewCards: _initialCardCount - _initialNewCount,
                retryAttempts: _retryCounts.values.fold(0, (a, b) => a + b),
                againCount: _ratingCounts[0] ?? 0,
                hardCount: _ratingCounts[2] ?? 0,
                goodCount: _ratingCounts[4] ?? 0,
                easyCount: _ratingCounts[5] ?? 0,
                needsPractice: _retryCounts.length,
                studyAhead: widget.studyAhead,
              ),
            ),
          ),
        );
      }
      return;
    }

    var card = _cardsToReview[_currentIndex];

    StudyMode actualMode = widget.mode;

    // Check for AI characters or compound words without stroke data in Calligraphy Mode
    if (widget.mode == StudyMode.calligraphy && card.strokePaths.isEmpty) {
      if (card.hanzi.length == 1) {
        setState(() => _isLoading = true);
        final updatedCard = await ref
            .read(flashcardControllerProvider.notifier)
            .loadStrokesFor(card);
        setState(() => _isLoading = false);

        if (!mounted) return;
        if (updatedCard != null) {
          card = updatedCard;
          _cardsToReview[_currentIndex] = card;
        }
      }

      if (card.strokePaths.isEmpty) {
        // Multi-character word or character without vector stroke data:
        // Gracefully fall back to Reading mode so the user can study this card!
        actualMode = StudyMode.reading;
      }
    }

    var dueCount = 0;
    var newCount = 0;
    var learningCount = 0;
    for (int i = _currentIndex; i < _cardsToReview.length; i++) {
      final stats = _cardsToReview[i].getStatsForMode(widget.mode);
      if (stats.isNew) {
        newCount++;
      } else if (stats.interval == 0 || stats.interval == 1) {
        learningCount++;
      } else {
        dueCount++;
      }
    }

    Widget screenToPush;

    switch (actualMode) {
      case StudyMode.calligraphy:
        screenToPush = ReviewScreen(
          card: card,
          reviewedCount: _currentIndex,
          dueCount: dueCount,
          newCount: newCount,
          learningCount: learningCount,
        );
        break;
      case StudyMode.reading:
        screenToPush = ReadingModeWidget(
          card: card,
          reviewedCount: _currentIndex,
          dueCount: dueCount,
          newCount: newCount,
          learningCount: learningCount,
        );
        break;
      case StudyMode.recall:
        screenToPush = RecallModeWidget(
          card: card,
          reviewedCount: _currentIndex,
          dueCount: dueCount,
          newCount: newCount,
          learningCount: learningCount,
        );
        break;
      case StudyMode.listening:
        screenToPush = ListeningModeWidget(
          card: card,
          reviewedCount: _currentIndex,
          dueCount: dueCount,
          newCount: newCount,
          learningCount: learningCount,
        );
        break;
      case StudyMode.speaking:
        screenToPush = SpeakingModeWidget(
          card: card,
          reviewedCount: _currentIndex,
          dueCount: dueCount,
          newCount: newCount,
          learningCount: learningCount,
        );
        break;
    }

    _isReviewRouteOpen = true;
    final grade = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (context) => screenToPush,
      ),
    );
    _isReviewRouteOpen = false;

    if (grade != null) {
      // 1. Process SM-2
      final updatedCard = card.processReview(grade, widget.mode);

      // 2. Save to database
      await ref
          .read(flashcardControllerProvider.notifier)
          .updateFlashcard(updatedCard);
      if (!widget.studyAhead &&
          card.getStatsForMode(widget.mode).interval > 1) {
        await ref.read(studyActivityRepositoryProvider).recordReview(
              deckId: widget.deckId,
              cardId: card.id,
              reviewedAt: DateTime.now(),
            );
      }

      // 3. Update stats
      if (grade >= 3) {
        _correctCount++;
      }
      _ratingCounts[grade] = (_ratingCounts[grade] ?? 0) + 1;

      // 4. Learning Phase: If interval is 0, they must see it again today.
      // Append it to the end of the session queue so they review it again before finishing.
      if (updatedCard.getStatsForMode(widget.mode).interval == 0) {
        final retryCount = _retryCounts[card.id] ?? 0;
        if (retryCount < _maxRetriesPerCard) {
          _retryCounts[card.id] = retryCount + 1;
          _cardsToReview.add(updatedCard);
        } else if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(AppLocalizations.of(context)!.retryLimitReached)),
          );
        }
      }

      _currentIndex++;
      _startNextReview();
    } else {
      // User aborted the session
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(localizations.studySession)),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _loadError != null
              ? _buildMessageState(
                  key: const Key('study_session_error'),
                  icon: Icons.error_outline,
                  title: localizations.studySessionLoadFailed,
                  body: _loadError!,
                  actionLabel: localizations.retry,
                  onAction: () {
                    setState(() => _isLoading = true);
                    _loadCards();
                  },
                )
              : _cardsToReview.isEmpty
                  ? _buildEmptyState(localizations)
                  : _buildPreview(localizations),
    );
  }

  Widget _buildPreview(AppLocalizations localizations) {
    final queue = _queue!;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Card(
          key: const Key('study_session_preview'),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.auto_stories, size: 56),
                const SizedBox(height: 16),
                Text(localizations.readyToStudy,
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(localizations.studyQueuePreviewDescription,
                    textAlign: TextAlign.center),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _queueCount('study_queue_review_count',
                        localizations.reviewed, queue.dueCount),
                    _queueCount('study_queue_learning_count',
                        localizations.learning, queue.learningCount),
                    _queueCount('study_queue_new_count', localizations.newLabel,
                        queue.newCount),
                  ],
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    key: const Key('study_session_start'),
                    onPressed: _isStarting ? null : _startSession,
                    icon: _isStarting
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.play_arrow),
                    label: Text(localizations.startSession),
                  ),
                ),
                TextButton(
                  key: const Key('study_session_cancel'),
                  onPressed: _isStarting ? null : () => Navigator.pop(context),
                  child: Text(localizations.notNow),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _queueCount(String keyName, String label, int value) {
    return Semantics(
      label: '$label: $value',
      child: Column(
        key: Key(keyName),
        children: [
          Text('$value', style: Theme.of(context).textTheme.headlineMedium),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations localizations) {
    final reason = _queue?.emptyReason;
    final (keyName, title, body) = switch (reason) {
      StudyQueueEmptyReason.deckEmpty => (
          'study_empty_deck',
          localizations.studyDeckEmpty,
          localizations.studyDeckEmptyDescription,
        ),
      StudyQueueEmptyReason.dailyLimitReached => (
          'study_empty_daily_limit',
          localizations.studyDailyLimitReached,
          localizations.studyDailyLimitReachedDescription,
        ),
      StudyQueueEmptyReason.caughtUp => (
          'study_empty_caught_up',
          localizations.allCardsCaughtUp,
          localizations.studyCaughtUpDescription,
        ),
      _ => (
          'study_empty_unavailable',
          localizations.noCardsAvailable,
          localizations.studyNoEligibleCardsDescription,
        ),
    };

    final canStudyAhead = !widget.studyAhead &&
        (reason == StudyQueueEmptyReason.dailyLimitReached ||
            reason == StudyQueueEmptyReason.caughtUp);

    return _buildMessageState(
      key: Key(keyName),
      icon: Icons.check_circle_outline,
      title: title,
      body: body,
      actionLabel:
          canStudyAhead ? localizations.studyAhead : localizations.back,
      onAction: canStudyAhead
          ? () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DeckReviewSessionScreen(
                    deckId: widget.deckId,
                    mode: widget.mode,
                    studyAhead: true,
                  ),
                ),
              );
            }
          : () => Navigator.pop(context),
      secondaryActionLabel: canStudyAhead ? localizations.back : null,
      onSecondaryAction: canStudyAhead ? () => Navigator.pop(context) : null,
    );
  }

  Widget _buildMessageState({
    required Key key,
    required IconData icon,
    required String title,
    required String body,
    required String actionLabel,
    required VoidCallback onAction,
    String? secondaryActionLabel,
    VoidCallback? onSecondaryAction,
  }) {
    return Center(
      child: Padding(
        key: key,
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64),
            const SizedBox(height: 16),
            Text(title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(body, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            if (secondaryActionLabel != null && onSecondaryAction != null) ...[
              FilledButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.fast_forward_rounded),
                label: Text(actionLabel),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: onSecondaryAction,
                child: Text(secondaryActionLabel),
              ),
            ] else ...[
              FilledButton(onPressed: onAction, child: Text(actionLabel)),
            ],
          ],
        ),
      ),
    );
  }
}
