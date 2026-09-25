import 'dart:async';

import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
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
import 'package:hanzi_master/shared/utils/motion_preferences.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';

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

  /// True from the moment the queue is reserved until the summary is shown.
  ///
  /// While a session runs, the screen behind the card must not be the "Ready to
  /// study" preview: each card is a route of its own, so the preview used to be
  /// revealed between every single card — the whole page faded out to a Start
  /// button and faded back in, once per word.
  bool _sessionStarted = false;

  /// Hive writes for finished cards, awaited before the session leaves.
  ///
  /// Persisting used to sit *between* the pop of the finished card and the push
  /// of the next one, which is dead time the user spent staring at the revealed
  /// base route. Writes are chained rather than fired in parallel so two cards
  /// can never interleave an update to the controller's state.
  Future<void> _writeChain = Future<void>.value();

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
    setState(() {
      _isStarting = false;
      _sessionStarted = true;
    });
    _startNextReview();
  }

  Future<void> _startNextReview() async {
    if (_isReviewRouteOpen || !mounted) return;
    if (_currentIndex >= _cardsToReview.length) {
      // Flush the last cards' writes before leaving the session, so the summary
      // and the statistics behind it are never shown a review short.
      await _drainPendingWrites();
      if (!mounted) return;
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
      // A card, not a screen: the finished card leaves in `swap` and the next
      // sheet settles in over `quick`, both from the shared motion vocabulary.
      // `MaterialPageRoute` here meant a full page transition per card — the
      // page faded out to the preview and back in, once per word.
      _CardRoute<int>(
        reduceMotion: context.reduceMotion,
        child: screenToPush,
      ),
    );
    _isReviewRouteOpen = false;

    if (grade != null) {
      _applyGrade(card, grade);
      _currentIndex++;
      // Deliberately not awaited: the next card must arrive immediately, and
      // the write is drained before the session shows its summary.
      _startNextReview();
    } else {
      // User aborted the session
      await _drainPendingWrites();
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  /// Books a finished card: SM-2 result, session tallies, the learning-phase
  /// re-queue, and the persistence that runs alongside the next card.
  void _applyGrade(Flashcard card, int grade) {
    final Flashcard updatedCard = card.processReview(grade, widget.mode);

    // Chained so the previous card's write finishes first; the learner keeps
    // swiping at their own pace while these drain in the background.
    _writeChain = _writeChain
        .then((_) => _persistReview(card, updatedCard))
        .catchError((Object error, StackTrace stackTrace) {
      // A failed write must not stall the queue: the SRS state on the card is
      // untouched by it, so the word simply returns on its next due date.
      debugPrint('Study session: could not persist ${card.id} — $error');
    });

    if (grade >= 3) {
      _correctCount++;
    }
    _ratingCounts[grade] = (_ratingCounts[grade] ?? 0) + 1;

    // Learning Phase: If interval is 0, they must see it again today. Append it
    // to the end of the session queue so they review it again before finishing.
    if (updatedCard.getStatsForMode(widget.mode).interval == 0) {
      final retryCount = _retryCounts[card.id] ?? 0;
      if (retryCount < _maxRetriesPerCard) {
        _retryCounts[card.id] = retryCount + 1;
        _cardsToReview.add(updatedCard);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.retryLimitReached),
          ),
        );
      }
    }
  }

  Future<void> _persistReview(Flashcard card, Flashcard updatedCard) async {
    await ref
        .read(flashcardControllerProvider.notifier)
        .updateFlashcard(updatedCard);
    if (!widget.studyAhead && card.getStatsForMode(widget.mode).interval > 1) {
      await ref.read(studyActivityRepositoryProvider).recordReview(
            deckId: widget.deckId,
            cardId: card.id,
            reviewedAt: DateTime.now(),
          );
    }
  }

  Future<void> _drainPendingWrites() async {
    await _writeChain;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(localizations.studySession)),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _isLoading
          ? const Center(child: ZenLoader())
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
                  : _sessionStarted
                      ? _buildSessionSurface()
                      : _buildPreview(localizations),
    );
  }

  /// What sits behind an open card: the session's paper, and nothing else.
  ///
  /// Each card is a route, so this surface *is* the "between cards" state. It
  /// is deliberately empty — the finished card leaves and the next settles in
  /// over it, which is what makes the swap read as one motion instead of a page
  /// change. It must never be the preview: a Start button appearing between two
  /// words is exactly the glitch this replaces.
  Widget _buildSessionSurface() {
    return const SizedBox.expand();
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

/// The transition for one card of a session.
///
/// Not a page: the finished card is already off-screen from the user's own
/// swipe, so the only motion worth showing is the next sheet settling into
/// place. The outgoing leg therefore runs on [ZenMotion.swap] (180ms) while the
/// incoming one gets [ZenMotion.quick] (300ms) — both tokens from the shared
/// motion vocabulary, and both skipped under reduced motion, where the next card
/// is simply presented.
class _CardRoute<T> extends PageRouteBuilder<T> {
  _CardRoute({required Widget child, required bool reduceMotion})
      : super(
          opaque: true,
          transitionDuration: reduceMotion ? Duration.zero : ZenMotion.quick,
          reverseTransitionDuration:
              reduceMotion ? Duration.zero : ZenMotion.swap,
          pageBuilder: (_, __, ___) => child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            if (reduceMotion) return child;

            final Animation<double> curved = CurvedAnimation(
              parent: animation,
              curve: ZenMotion.enter,
              reverseCurve: ZenMotion.natural,
            );
            return FadeTransition(
              opacity: curved,
              child: SlideTransition(
                // 6% rise: the new sheet arrives from just below the old one,
                // far enough to read as a card and short enough to stay calm.
                position: Tween<Offset>(
                  begin: const Offset(0, 0.06),
                  end: Offset.zero,
                ).animate(curved),
                child: child,
              ),
            );
          },
        );
}
