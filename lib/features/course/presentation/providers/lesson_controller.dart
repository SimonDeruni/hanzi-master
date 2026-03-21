import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';

part 'lesson_controller.g.dart';

enum LessonStepType {
  discovery,
  quizRecognition, // English -> Hanzi
  quizPinyin,      // Hanzi -> Pinyin
  guidedTrace,
  ghostTrace,
  anchors,
  activeRecall,
  context 
}

class LessonState {
  final int currentStepIndex;
  final List<LessonStepType> steps;
  final Map<LessonStepType, double> scores;
  final String? skipReason;
  final List<Flashcard> warmupCards;
  final int currentWarmupIndex;
  // Distractors for the current lesson (shared across quiz steps to ensure consistency if needed, 
  // though generating per step is also fine. We'll store a pool here).
  final List<Flashcard> distractors;

  LessonState({
    required this.currentStepIndex,
    required this.steps,
    required this.scores,
    this.skipReason,
    this.warmupCards = const [],
    this.currentWarmupIndex = 0,
    this.distractors = const [],
  });

  LessonState copyWith({
    int? currentStepIndex,
    List<LessonStepType>? steps,
    Map<LessonStepType, double>? scores,
    String? skipReason,
    List<Flashcard>? warmupCards,
    int? currentWarmupIndex,
    List<Flashcard>? distractors,
  }) {
    return LessonState(
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      steps: steps ?? this.steps,
      scores: scores ?? this.scores,
      skipReason: skipReason ?? this.skipReason,
      warmupCards: warmupCards ?? this.warmupCards,
      currentWarmupIndex: currentWarmupIndex ?? this.currentWarmupIndex,
      distractors: distractors ?? this.distractors,
    );
  }
  
  LessonStepType get currentStep => steps[currentStepIndex];
  bool get isLastStep => currentStepIndex == steps.length - 1;
  double get progress => (currentStepIndex + 1 + currentWarmupIndex) / (steps.length + warmupCards.length);
  bool get inWarmupPhase => currentWarmupIndex < warmupCards.length;
}

// Side-channel to pass warmup cards without changing the provider family signature
final activeWarmupCardsProvider = StateProvider<List<Flashcard>>((ref) => []);
// Side-channel for distractors (all available cards) to avoid fetching inside controller
final allCardsProvider = StateProvider<List<Flashcard>>((ref) => []);

@riverpod
class LessonController extends _$LessonController {
  late Flashcard _card;

  @override
  LessonState build(Flashcard card) {
    _card = card;
    
    // Grab warmups from the side-channel
    final warmups = ref.read(activeWarmupCardsProvider);
    final allCards = ref.read(allCardsProvider);
    
    // Generate distractors (3 random cards that are NOT the current card)
    final distractors = _generateDistractors(card, allCards);

    // Enhanced 4-Pillar Lesson Flow
    return LessonState(
      currentStepIndex: 0,
      steps: [
        LessonStepType.discovery,
        LessonStepType.quizRecognition, // "Which one is 'Water'?"
        LessonStepType.guidedTrace,     // Learn to write
        LessonStepType.quizPinyin,      // "What is the pinyin?" (Reinforcement)
        LessonStepType.ghostTrace,      // Practice writing
        LessonStepType.anchors,         // Master writing
        LessonStepType.activeRecall,    // Final Test
        LessonStepType.context,         // Fill-in-the-blank writing
      ],
      scores: {},
      warmupCards: warmups,
      distractors: distractors,
    );
  }

  List<Flashcard> _generateDistractors(Flashcard correct, List<Flashcard> pool) {
    if (pool.isEmpty) return [];
    final candidates = pool.where((c) => c.id != correct.id).toList();
    candidates.shuffle();
    return candidates.take(3).toList();
  }

  void advanceStep() {
    if (state.inWarmupPhase) {
      state = state.copyWith(currentWarmupIndex: state.currentWarmupIndex + 1);
    } else if (!state.isLastStep) {
      state = state.copyWith(currentStepIndex: state.currentStepIndex + 1);
    }
  }

  void recordScore(double score) {
    if (state.inWarmupPhase) {
      // Logic for recording SRS scores could go here
      return;
    }

    final step = state.currentStep;
    final newScores = Map<LessonStepType, double>.from(state.scores);
    newScores[step] = score;

    // Check for Fast Track opportunities during Guided Trace
    if (step == LessonStepType.guidedTrace) {
      _checkForFastTrack(score);
    }
    
    // We update scores but preserve any skipReason that might have been set by _checkForFastTrack
    state = state.copyWith(scores: newScores);
  }

  void _checkForFastTrack(double score) {
    final int strokeCount = _card.strokePaths.length;
    List<LessonStepType> newSteps = List.from(state.steps);
    String? reason;

    // Fast Track Logic
    // Simple (1-3 strokes): > 90% -> Skip Ghost & Anchors
    if (strokeCount <= 3 && score >= 90) {
      newSteps.remove(LessonStepType.ghostTrace);
      newSteps.remove(LessonStepType.anchors);
      reason = "🚀 Fast Track! Simple character mastered.";
    } 
    // Medium (4-7 strokes): > 95% -> Skip Ghost
    else if (strokeCount <= 7 && score >= 95) {
      newSteps.remove(LessonStepType.ghostTrace);
      reason = "⚡ Excellent precision! Ghost trace skipped.";
    }
    
    if (reason != null) {
      state = state.copyWith(steps: newSteps, skipReason: reason);
    }
  }
}
