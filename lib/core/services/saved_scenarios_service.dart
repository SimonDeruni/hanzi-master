import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/echo_hall/domain/entities/scenario.dart';

final savedScenariosProvider = StateNotifierProvider<SavedScenariosNotifier, List<ConversationScenario>>((ref) {
  return SavedScenariosNotifier();
});

class SavedScenariosNotifier extends StateNotifier<List<ConversationScenario>> {
  SavedScenariosNotifier() : super([]) {
    _load();
  }

  static const _storageKey = 'saved_custom_scenarios';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_storageKey);
    if (stored != null) {
      try {
        final list = (jsonDecode(stored) as List<dynamic>)
            .map((e) => ConversationScenario.fromJson(e as Map<String, dynamic>))
            .toList();
        state = list;
      } catch (e) {
        debugPrint('SavedScenarios: load error $e');
        state = [];
      }
    }
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(state.map((s) => s.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }

  bool isSaved(String id) => state.any((s) => s.id == id);

  Future<void> toggle(ConversationScenario scenario) async {
    final existingIndex = state.indexWhere((s) => s.id == scenario.id);
    if (existingIndex >= 0) {
      // Remove
      state = [...state]..removeAt(existingIndex);
    } else {
      // Save as custom
      final saved = ConversationScenario(
        id: scenario.id,
        title: scenario.title,
        description: scenario.description,
        initialAiMessage: scenario.initialAiMessage,
        systemPrompt: scenario.systemPrompt,
        targetHskLevel: scenario.targetHskLevel,
        avatarAssetPath: scenario.avatarAssetPath,
        backgroundAudioPath: scenario.backgroundAudioPath,
        backgroundAssetPath: scenario.backgroundAssetPath,
        quests: List<String>.from(scenario.quests),
        personaName: scenario.personaName,
        isCustom: true,
        voiceName: scenario.voiceName,
        deckId: scenario.deckId,
      );
      state = [...state, saved];
    }
    await _persist();
  }

  Future<void> remove(String id) async {
    state = state.where((s) => s.id != id).toList();
    await _persist();
  }
}