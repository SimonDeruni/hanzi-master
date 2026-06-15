import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/core/services/curriculum_engine.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import '../../domain/entities/course_unit.dart';

part 'course_controller.g.dart';

@riverpod
class CourseController extends _$CourseController {
  @override
  Future<List<CourseUnit>> build(String deckId) async {
    final engine = ref.read(curriculumEngineProvider);
    final allCards = ref.watch(flashcardControllerProvider).valueOrNull ?? [];
    
    // We only use the engine if we have cards loaded.
    if (allCards.isEmpty) return [];
    
    return await engine.getCurriculumForDeck(deckId, allCards);
  }
}

