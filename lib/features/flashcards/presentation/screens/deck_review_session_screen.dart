import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/review_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/session_summary_screen.dart';

class DeckReviewSessionScreen extends StatefulWidget {
  final List<Flashcard> cardsToReview;

  const DeckReviewSessionScreen({super.key, required this.cardsToReview});

  @override
  State<DeckReviewSessionScreen> createState() => _DeckReviewSessionScreenState();
}

class _DeckReviewSessionScreenState extends State<DeckReviewSessionScreen> {
  int currentIndex = 0;
  int correctCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startNextReview();
    });
  }

  Future<void> _startNextReview() async {
    if (currentIndex >= widget.cardsToReview.length) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SessionSummaryScreen(
              totalReviewed: widget.cardsToReview.length,
              correctCount: correctCount,
            ),
          ),
        );
      }
      return;
    }

    final card = widget.cardsToReview[currentIndex];
    
    // We push ReviewScreen
    final score = await Navigator.push<double>(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewScreen(
          card: card,
          reviewedCount: currentIndex,
        ),
      ),
    );

    // After review pops, it returns the score (or null if user pressed back button)
    if (score != null) {
      if (score >= 80) {
        correctCount++;
      }
      currentIndex++;
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
    // Blank screen while pushing
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
