import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hanzi_master/features/reading/domain/entities/graded_story.dart';
import 'package:hanzi_master/features/reading/presentation/providers/story_controller.dart';
final storyRepositoryProvider = Provider<StoryRepository>((ref) {
  return StoryRepository();
});

class StoryRepository {
  static const String boxName = 'graded_stories';
  static const String customBlueprintsBoxName = 'custom_blueprints';

  Future<void> init() async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<String>(boxName);
    }
    if (!Hive.isBoxOpen(customBlueprintsBoxName)) {
      await Hive.openBox<String>(customBlueprintsBoxName);
    }
  }

  Future<void> saveStory(GradedStory story) async {
    final box = Hive.box<String>(boxName);
    await box.put(story.id, jsonEncode(story.toJson()));
  }

  Future<void> saveCustomBlueprint(StoryBlueprint blueprint) async {
    final box = Hive.box<String>(customBlueprintsBoxName);
    await box.put(blueprint.id, jsonEncode(blueprint.toJson()));
  }

  Future<List<StoryBlueprint>> getCustomBlueprints() async {
    final box = Hive.box<String>(customBlueprintsBoxName);
    final list = <StoryBlueprint>[];
    for (final key in box.keys) {
      final jsonStr = box.get(key);
      if (jsonStr != null) {
        try {
          final json = jsonDecode(jsonStr);
          list.add(StoryBlueprint.fromJson(json));
        } catch (e) {
          // Ignore parse errors
        }
      }
    }
    return list;
  }

  Future<GradedStory?> getStory(String id) async {
    final box = Hive.box<String>(boxName);
    final jsonStr = box.get(id);
    if (jsonStr != null) {
      try {
        final json = jsonDecode(jsonStr);
        return GradedStory.fromJson(json);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  Future<List<GradedStory>> getAllStories() async {
    final box = Hive.box<String>(boxName);
    final stories = <GradedStory>[];
    for (final key in box.keys) {
      final jsonStr = box.get(key);
      if (jsonStr != null) {
        try {
          final json = jsonDecode(jsonStr);
          stories.add(GradedStory.fromJson(json));
        } catch (e) {
          // ignore invalid
        }
      }
    }
    return stories;
  }
}
