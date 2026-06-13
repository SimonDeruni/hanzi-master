import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hanzi_master/features/reading/domain/entities/graded_story.dart';

final storyRepositoryProvider = Provider<StoryRepository>((ref) {
  return StoryRepository();
});

class StoryRepository {
  static const String boxName = 'graded_stories';

  Future<void> init() async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<String>(boxName);
    }
  }

  Future<void> saveStory(GradedStory story) async {
    final box = Hive.box<String>(boxName);
    await box.put(story.id, jsonEncode(story.toJson()));
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
