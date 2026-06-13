import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/graded_story.dart';
import '../../../../core/services/gemini_service.dart';
import '../../data/repositories/story_repository.dart';

final storyControllerProvider = StateNotifierProvider<StoryController, StoryState>((ref) {
  return StoryController(
    geminiService: ref.watch(geminiServiceProvider),
    repository: ref.watch(storyRepositoryProvider),
  );
});

class StoryState {
  final bool isLoading;
  final String? error;
  final GradedStory? currentStory;

  const StoryState({
    this.isLoading = false,
    this.error,
    this.currentStory,
  });

  StoryState copyWith({
    bool? isLoading,
    String? error,
    GradedStory? currentStory,
  }) {
    return StoryState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      currentStory: currentStory ?? this.currentStory,
    );
  }
}

class StoryBlueprint {
  final String id;
  final String title;
  final String topic;
  final String category;

  const StoryBlueprint({
    required this.id,
    required this.title,
    required this.topic,
    required this.category,
  });
}

class StoryController extends StateNotifier<StoryState> {
  final GeminiService geminiService;
  final StoryRepository repository;

  StoryController({
    required this.geminiService,
    required this.repository,
  }) : super(const StoryState());

  static const List<StoryBlueprint> blueprints = [
    StoryBlueprint(id: 'myth_1', title: 'The Legend of the White Snake', topic: 'The Legend of the White Snake (白蛇传)', category: 'Myths & Legends'),
    StoryBlueprint(id: 'myth_2', title: 'Mulan', topic: 'Hua Mulan joining the army instead of her father', category: 'Myths & Legends'),
    StoryBlueprint(id: 'idiom_1', title: 'A Blessing in Disguise', topic: 'The idiom Sai Weng Shi Ma (塞翁失马)', category: 'Idioms'),
    StoryBlueprint(id: 'life_1', title: 'Taking the High-Speed Train', topic: 'Buying a ticket and taking the high speed train in China', category: 'Daily Life'),
    StoryBlueprint(id: 'life_2', title: 'Visiting the Doctor', topic: 'Going to the hospital for a cold', category: 'Daily Life'),
  ];

  Future<void> loadOrGenerateStory(StoryBlueprint blueprint, int hskLevel) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final storyId = '${blueprint.id}_hsk$hskLevel';
      
      // 1. Check Cache
      final cachedStory = await repository.getStory(storyId);
      if (cachedStory != null) {
        state = state.copyWith(isLoading: false, currentStory: cachedStory);
        return;
      }

      // 2. Generate if not cached
      final result = await geminiService.generateGradedStory(blueprint.topic, blueprint.category, hskLevel);
      
      final newStory = GradedStory(
        id: storyId,
        title: blueprint.title,
        category: blueprint.category,
        hskLevel: hskLevel,
        content: result['content'] ?? '',
        englishTranslation: result['englishTranslation'] ?? '',
        generatedAt: DateTime.now(),
      );

      // 3. Save to cache
      await repository.saveStory(newStory);

      // 4. Update state
      state = state.copyWith(isLoading: false, currentStory: newStory);

    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void clearCurrentStory() {
    state = state.copyWith(currentStory: null);
  }
}
