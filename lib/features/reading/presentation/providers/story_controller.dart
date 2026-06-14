import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
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
  final List<StoryBlueprint> blueprints;

  const StoryState({
    this.isLoading = false,
    this.error,
    this.currentStory,
    this.blueprints = const [],
  });

  StoryState copyWith({
    bool? isLoading,
    String? error,
    GradedStory? currentStory,
    List<StoryBlueprint>? blueprints,
  }) {
    return StoryState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      currentStory: currentStory ?? this.currentStory,
      blueprints: blueprints ?? this.blueprints,
    );
  }
}

class StoryBlueprint {
  final String id;
  final String title;
  final String topic;
  final String category;
  final String imageUrl;
  final List<String> tags;

  const StoryBlueprint({
    required this.id,
    required this.title,
    required this.topic,
    required this.category,
    required this.imageUrl,
    required this.tags,
  });

  factory StoryBlueprint.fromJson(Map<String, dynamic> json) {
    return StoryBlueprint(
      id: json['id'] as String,
      title: json['title'] as String,
      topic: json['topic'] as String,
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String? ?? '',
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'topic': topic,
      'category': category,
      'imageUrl': imageUrl,
      'tags': tags,
    };
  }
}

class StoryController extends StateNotifier<StoryState> {
  final GeminiService geminiService;
  final StoryRepository repository;

  StoryController({
    required this.geminiService,
    required this.repository,
  }) : super(const StoryState()) {
    _init();
  }

  Future<void> _init() async {
    final customBlueprints = await repository.getCustomBlueprints();
    state = state.copyWith(blueprints: [...defaultBlueprints, ...customBlueprints]);
  }

  static const List<StoryBlueprint> defaultBlueprints = [
    // Myths & Legends
    StoryBlueprint(
      id: 'myth_monkey', 
      title: 'The Monkey King', 
      topic: 'Sun Wukong (Journey to the West)', 
      category: 'Myths & Legends',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Sun_Wukong_and_Jade_Emperor.jpg/800px-Sun_Wukong_and_Jade_Emperor.jpg',
      tags: ['mythology', 'adventure', 'magic', 'animals'],
    ),
    StoryBlueprint(
      id: 'myth_mulan', 
      title: 'Hua Mulan', 
      topic: 'Hua Mulan joining the army instead of her father', 
      category: 'Myths & Legends',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Hua_Mulan.jpg/800px-Hua_Mulan.jpg',
      tags: ['history', 'war', 'family', 'hero'],
    ),
    StoryBlueprint(
      id: 'myth_nuwa', 
      title: 'Nüwa Mends the Heavens', 
      topic: 'The goddess Nüwa repairing the sky', 
      category: 'Myths & Legends',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/63/N%C3%BCwa_and_Fuxi.jpg/800px-N%C3%BCwa_and_Fuxi.jpg',
      tags: ['mythology', 'creation', 'gods'],
    ),

    // History & Culture
    StoryBlueprint(
      id: 'hist_confucius', 
      title: 'Confucius', 
      topic: 'The life and teachings of Confucius', 
      category: 'History & Culture',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/Confucius_Tang_Dynasty.jpg/800px-Confucius_Tang_Dynasty.jpg',
      tags: ['history', 'philosophy', 'education'],
    ),
    StoryBlueprint(
      id: 'hist_wall', 
      title: 'The Great Wall', 
      topic: 'Building the Great Wall of China', 
      category: 'History & Culture',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/The_Great_Wall_of_China_at_Jinshanling-edit.jpg/800px-The_Great_Wall_of_China_at_Jinshanling-edit.jpg',
      tags: ['history', 'architecture', 'travel', 'war'],
    ),
    StoryBlueprint(
      id: 'hist_terracotta', 
      title: 'Terracotta Army', 
      topic: 'The Terracotta Army of Qin Shi Huang', 
      category: 'History & Culture',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Terracotta_Army_view_of_pit_1.jpg/800px-Terracotta_Army_view_of_pit_1.jpg',
      tags: ['history', 'emperors', 'art', 'travel'],
    ),
    StoryBlueprint(
      id: 'hist_forbidden', 
      title: 'Forbidden City', 
      topic: 'Life inside the Forbidden City', 
      category: 'History & Culture',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Forbidden_City_Beijing_Shenwumen_Gate.JPG/800px-Forbidden_City_Beijing_Shenwumen_Gate.JPG',
      tags: ['history', 'architecture', 'emperors', 'travel'],
    ),

    // Idioms (成语)
    StoryBlueprint(
      id: 'idiom_saiweng', 
      title: 'A Blessing in Disguise', 
      topic: 'The idiom Sai Weng Shi Ma (塞翁失马)', 
      category: 'Idioms (成语)',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f6/A_Tartar_Horseman_-_Zhao_Mengfu.jpg/800px-A_Tartar_Horseman_-_Zhao_Mengfu.jpg',
      tags: ['idiom', 'philosophy', 'animals', 'life'],
    ),
    StoryBlueprint(
      id: 'idiom_snake', 
      title: 'Drawing a Snake', 
      topic: 'Drawing a snake and adding legs (画蛇添足)', 
      category: 'Idioms (成语)',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/Snake_in_the_grass.jpg/800px-Snake_in_the_grass.jpg',
      tags: ['idiom', 'animals', 'mistakes', 'funny'],
    ),

    // Daily Life
    StoryBlueprint(
      id: 'life_train', 
      title: 'Taking the Bullet Train', 
      topic: 'Buying a ticket and taking the high speed train in China', 
      category: 'Daily Life',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/CR400AF-A-2042_%40_Wuhan_%2820190516140645%29.jpg/800px-CR400AF-A-2042_%40_Wuhan_%2820190516140645%29.jpg',
      tags: ['travel', 'modern', 'transportation', 'practical'],
    ),
    StoryBlueprint(
      id: 'life_doctor', 
      title: 'Visiting the Doctor', 
      topic: 'Going to the hospital for a cold and seeing a doctor', 
      category: 'Daily Life',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b3/Peking_Union_Medical_College_Hospital_-_East_Gate_%2820200827170138%29.jpg/800px-Peking_Union_Medical_College_Hospital_-_East_Gate_%2820200827170138%29.jpg',
      tags: ['health', 'practical', 'modern', 'hospital'],
    ),
    StoryBlueprint(
      id: 'life_food', 
      title: 'Ordering Dumplings', 
      topic: 'Going to a local restaurant to order Jiaozi (dumplings)', 
      category: 'Daily Life',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/80/Jiaozi_at_a_restaurant_in_Beijing.jpg/800px-Jiaozi_at_a_restaurant_in_Beijing.jpg',
      tags: ['food', 'restaurant', 'practical', 'culture'],
    ),

    // Arts & Traditions
    StoryBlueprint(
      id: 'art_tea', 
      title: 'The Tea Ceremony', 
      topic: 'The traditional Gongfu tea ceremony', 
      category: 'Arts & Traditions',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Gongfu_tea_ceremony.jpg/800px-Gongfu_tea_ceremony.jpg',
      tags: ['culture', 'tea', 'tradition', 'relax'],
    ),
    StoryBlueprint(
      id: 'art_calligraphy', 
      title: 'Chinese Calligraphy', 
      topic: 'The art of writing Chinese characters with a brush', 
      category: 'Arts & Traditions',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Chinese_calligraphy_at_the_British_Museum.jpg/800px-Chinese_calligraphy_at_the_British_Museum.jpg',
      tags: ['culture', 'art', 'writing', 'tradition'],
    ),
    StoryBlueprint(
      id: 'art_panda', 
      title: 'The Giant Panda', 
      topic: 'The life and conservation of Giant Pandas', 
      category: 'Arts & Traditions',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Grosser_Panda.JPG/800px-Grosser_Panda.JPG',
      tags: ['animals', 'nature', 'culture', 'cute'],
    ),
  ];

  Future<void> loadOrGenerateStory(StoryBlueprint blueprint, int hskLevel) async {
    state = state.copyWith(isLoading: true, error: null, currentStory: null);
    
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
        sentences: result.sentences,
        generatedAt: DateTime.now(),
      );

      // 3. Save to cache
      await repository.saveStory(newStory);

      state = state.copyWith(isLoading: false, currentStory: newStory);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString(), currentStory: null);
    }
  }

  Future<StoryBlueprint> generateCustomStoryByTopic(String topic, List<String> tags, int hskLevel) async {
    final id = 'custom_${DateTime.now().millisecondsSinceEpoch}';
    final blueprint = StoryBlueprint(
      id: id,
      title: topic,
      topic: topic,
      category: 'My Custom Stories',
      imageUrl: '', // Blank implies placeholder in UI
      tags: tags,
    );

    // Save blueprint
    await repository.saveCustomBlueprint(blueprint);
    state = state.copyWith(blueprints: [...state.blueprints, blueprint]);

    // Now generate and load (fire and forget)
    loadOrGenerateStory(blueprint, hskLevel);
    
    return blueprint;
  }

  Future<StoryBlueprint> generateSimplifiedStory(String sourceText, int hskLevel) async {
    final id = 'custom_${DateTime.now().millisecondsSinceEpoch}';
    final blueprint = StoryBlueprint(
      id: id,
      title: 'Simplified Text',
      topic: 'User provided text',
      category: 'My Custom Stories',
      imageUrl: '',
      tags: ['simplified', 'custom'],
    );

    // Save blueprint
    await repository.saveCustomBlueprint(blueprint);
    state = state.copyWith(
      blueprints: [...state.blueprints, blueprint],
      isLoading: true,
      error: null,
      currentStory: null,
    );

    // Fire and forget the generation
    _performSimplification(blueprint, sourceText, hskLevel);
    
    return blueprint;
  }

  Future<void> deleteCustomStory(StoryBlueprint blueprint) async {
    // 1. Remove from local state
    final updatedBlueprints = state.blueprints.where((b) => b.id != blueprint.id).toList();
    
    // If current story is the deleted one, clear it
    final isCurrent = state.currentStory?.id.startsWith(blueprint.id) ?? false;
    
    state = state.copyWith(
      blueprints: updatedBlueprints,
      currentStory: isCurrent ? null : state.currentStory,
    );

    // 2. Remove from repository
    // We only remove the blueprint, since the actual story may or may not be generated.
    // If you wanted to be thorough, you'd delete the story from the box as well.
    final box = Hive.box<String>(StoryRepository.customBlueprintsBoxName);
    await box.delete(blueprint.id);
  }

  Future<void> _performSimplification(StoryBlueprint blueprint, String sourceText, int hskLevel) async {
    try {
      final result = await geminiService.simplifyTextToHsk(sourceText, hskLevel);
      
      final newStory = GradedStory(
        id: '${blueprint.id}_hsk$hskLevel',
        title: blueprint.title,
        category: blueprint.category,
        hskLevel: hskLevel,
        sentences: result.sentences,
        generatedAt: DateTime.now(),
      );

      await repository.saveStory(newStory);

      state = state.copyWith(isLoading: false, currentStory: newStory);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString(), currentStory: null);
    }
  }

  void clearCurrentStory() {
    state = const StoryState(isLoading: false, error: null, currentStory: null);
  }
}
