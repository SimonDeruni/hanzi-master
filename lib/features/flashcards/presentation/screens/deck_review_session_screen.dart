import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/review_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/session_summary_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/modes/reading_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/modes/recall_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/modes/listening_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/modes/speaking_mode.dart';
import 'package:hanzi_master/core/services/analytics_service.dart';

class DeckReviewSessionScreen extends ConsumerStatefulWidget {
  final String deckId;
  final StudyMode mode;

  const DeckReviewSessionScreen({
    super.key,
    required this.deckId,
    required this.mode,
  });

  @override
  ConsumerState<DeckReviewSessionScreen> createState() => _DeckReviewSessionScreenState();
}

class _DeckReviewSessionScreenState extends ConsumerState<DeckReviewSessionScreen> {
  List<Flashcard> _cardsToReview = [];
  int _currentIndex = 0;
  int _correctCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadCards() async {
    final result = await ref.read(flashcardControllerProvider.notifier).getCardsForDeck(widget.deckId);
    
    if (mounted) {
      // Filter due cards and new cards
      final dueCards = result.where((c) => !c.isNew(widget.mode) && c.isDue(widget.mode)).toList();
      final newCards = result.where((c) => c.isNew(widget.mode)).toList();
      
      _cardsToReview = [...dueCards, ...newCards];
      
      setState(() {
        _isLoading = false;
      });

      if (_cardsToReview.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _startNextReview();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("All cards caught up! Great job.")),
        );
        Navigator.pop(context);
      }
    }
  }

  Future<void> _startNextReview() async {
    if (_currentIndex >= _cardsToReview.length) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SessionSummaryScreen(
              totalReviewed: _cardsToReview.length,
              correctCount: _correctCount,
            ),
          ),
        );
      }
      return;
    }

    var card = _cardsToReview[_currentIndex];
    
    // Check for AI characters without stroke data in Calligraphy Mode
    if (widget.mode == StudyMode.calligraphy && card.strokePaths.isEmpty) {
      setState(() => _isLoading = true);
      final updatedCard = await ref.read(flashcardControllerProvider.notifier).loadStrokesFor(card);
      setState(() => _isLoading = false);
      
      if (!mounted) return;
      if (updatedCard != null) {
        card = updatedCard;
        _cardsToReview[_currentIndex] = card;
      }
      
      if (card.strokePaths.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Skipped "${card.hanzi}" - No stroke data available for this AI character.'),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
        
        // Remove from this session's review queue
        setState(() {
          _cardsToReview.removeAt(_currentIndex);
        });
        
        // Start next review immediately without incrementing index
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _startNextReview();
        });
        return;
      }
    }
    
    // We push the selected Mode UI. Currently we only have Calligraphy wired up fully.
    // For other modes, we fallback to Calligraphy or show a placeholder.
    int dueCount = 0;
    int newCount = 0;
    int learningCount = 0;
    
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
    
    StudyMode actualMode = widget.mode;
    
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

    final grade = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (context) => screenToPush,
      ),
    );

    if (grade != null) {
      // 1. Process SM-2
      final updatedCard = card.processReview(grade, widget.mode);
      
      // 2. Save to database
      await ref.read(flashcardControllerProvider.notifier).updateFlashcard(updatedCard);
      
      // 3. Update stats
      if (grade >= 3) {
        _correctCount++;
      }

      // 4. Learning Phase: If interval is 0, they must see it again today.
      // Append it to the end of the session queue so they review it again before finishing.
      if (updatedCard.getStatsForMode(widget.mode).interval == 0) {
        _cardsToReview.add(updatedCard);
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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: _isLoading 
            ? const CircularProgressIndicator()
            : const Text('Starting session...'),
      ),
    );
  }
}
