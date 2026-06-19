import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import '../providers/lesson_controller.dart';
import '../../../progression/providers/progression_service.dart';
import '../widgets/lesson_steps/discovery_step.dart';
import '../widgets/lesson_steps/quiz_step.dart';
import '../widgets/lesson_steps/drawing_step.dart';
import '../widgets/lesson_steps/context_step.dart';

import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/core/services/audio_service.dart';

class LessonScreen extends ConsumerWidget {
  final Flashcard card;

  const LessonScreen({super.key, required this.card});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    // The warmups are now handled internally by the controller reading the side-channel provider
    final lessonState = ref.watch(lessonControllerProvider(card));
    final controller = ref.read(lessonControllerProvider(card).notifier);

    // Listen for Fast Track events
    ref.listen(lessonControllerProvider(card), (previous, next) {
      if (next.skipReason != null && next.skipReason != previous?.skipReason) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.speed, color: Colors.white),
                const SizedBox(width: 12),
                Text(next.skipReason!),
              ],
            ),
            backgroundColor: Colors.indigoAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
        title: lessonState.inWarmupPhase 
          ? Text(l10n?.warmUp ?? "WARM UP", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.indigo))
          : null,
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: CalligraphyBackground(
        child: Column(
          children: [
            _buildProgressBar(context, lessonState.progress),
            Expanded(
              child: lessonState.inWarmupPhase
                  ? _buildWarmupStep(lessonState.warmupCards[lessonState.currentWarmupIndex], controller)
                  : _buildStepContent(lessonState.currentStep, lessonState, controller, context, ref),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarmupStep(Flashcard card, LessonController controller) {
    return DrawingStep(
      key: ValueKey("warmup_${card.id}"),
      card: card,
      mode: DrawingStepMode.recall, // Warmups are always Active Recall
      onComplete: (score) {
        controller.advanceStep();
      },
    );
  }

  Widget _buildProgressBar(BuildContext context, double progress) {
    final topPadding = MediaQuery.of(context).padding.top + 40;
    return Padding(
      padding: EdgeInsets.fromLTRB(24, topPadding, 24, 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: LinearProgressIndicator(
          value: progress,
          minHeight: 8,
          backgroundColor: Colors.grey.withValues(alpha: 0.2),
          valueColor: const AlwaysStoppedAnimation(Colors.indigo),
        ),
      ),
    );
  }

  Widget _buildStepContent(LessonStepType step, LessonState state, LessonController controller, BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    switch (step) {
      case LessonStepType.discovery:
        return DiscoveryStep(card: card, onComplete: controller.advanceStep);
      case LessonStepType.quizRecognition:
        return QuizStep(
          key: const ValueKey("quiz_rec"),
          targetCard: card,
          distractors: state.distractors,
          mode: QuizMode.recognition,
          onComplete: controller.advanceStep,
        );
      case LessonStepType.quizPinyin:
        return QuizStep(
          key: const ValueKey("quiz_pin"),
          targetCard: card,
          distractors: state.distractors,
          mode: QuizMode.pinyin,
          onComplete: controller.advanceStep,
        );
      case LessonStepType.guidedTrace:
        return DrawingStep(
          key: const ValueKey("guided"),
          card: card,
          mode: DrawingStepMode.guided,
          onComplete: (score) {
            controller.recordScore(score);
            controller.advanceStep();
          },
        );
      case LessonStepType.ghostTrace:
        return DrawingStep(
          key: const ValueKey("ghost"),
          card: card,
          mode: DrawingStepMode.ghost,
          onComplete: (score) {
            controller.recordScore(score);
            controller.advanceStep();
          },
        );
      case LessonStepType.anchors:
        return DrawingStep(
          key: const ValueKey("anchors"),
          card: card,
          mode: DrawingStepMode.anchors,
          onComplete: (score) {
            controller.recordScore(score);
            controller.advanceStep();
          },
        );
      case LessonStepType.activeRecall:
        return DrawingStep(
          key: const ValueKey("recall"),
          card: card,
          mode: DrawingStepMode.recall,
          onComplete: (score) {
            controller.recordScore(score);
            controller.advanceStep();
          },
        );
      case LessonStepType.context:
        return ContextStep(
          key: const ValueKey("context"),
          card: card,
          onComplete: () {
            ref.read(audioServiceProvider).playCompleteSfx();
            ref.read(progressionProvider.notifier).addInkPoints(10);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n?.lessonComplete ?? "Lesson Complete! +10 Ink Points")),
            );
          },
        );
    }
  }
}
