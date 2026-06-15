import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/course/domain/entities/course_unit.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/course/data/repositories/course_repository_impl.dart';

final curriculumEngineProvider = Provider<CurriculumEngineService>((ref) {
  final geminiService = ref.watch(geminiServiceProvider);
  return CurriculumEngineService(geminiService);
});

class CurriculumEngineService {
  final GeminiService _geminiService;
  
  CurriculumEngineService(this._geminiService);

  bool hasCachedCurriculum(String deckId) {
    final box = Hive.box<String>('curriculum_cache_box');
    return box.containsKey(deckId);
  }

  Future<void> generateAndCacheCurriculum(String deckId, List<Flashcard> allCards) async {
    // Filter cards for this deck
    final deckCards = allCards.where((c) => c.deckId == deckId || (deckId == 'default' && c.deckId == null)).toList();
    if (deckCards.isEmpty) return;

    final box = Hive.box<String>('curriculum_cache_box');
    final generatedUnits = await _generatePathFromAI(deckId, deckCards);
    
    // Cache the result
    final jsonString = jsonEncode(generatedUnits.map((u) => u.toJson()).toList());
    await box.put(deckId, jsonString);
  }

  Future<List<CourseUnit>> getCurriculumForDeck(String deckId, List<Flashcard> allCards) async {
    final box = Hive.box<String>('curriculum_cache_box');
    final cachedJson = box.get(deckId);

    // Filter cards for this deck
    final deckCards = allCards.where((c) => c.deckId == deckId || (deckId == 'default' && c.deckId == null)).toList();

    if (cachedJson != null) {
      try {
        final List<dynamic> decoded = jsonDecode(cachedJson);
        final cachedUnits = decoded.map((e) => CourseUnit.fromJson(e)).toList();
        
        // Validation: Ensure cache contains roughly the same cards, otherwise regenerate
        int cachedNodeCount = 0;
        for (var unit in cachedUnits) {
          cachedNodeCount += unit.nodes.length;
        }
        
        // If the number of cards changed significantly (e.g. added more than 3 cards), regenerate.
        if ((cachedNodeCount - deckCards.length).abs() <= 3) {
          return cachedUnits;
        }
      } catch (e) {
        // Cache corrupted, regenerate
      }
    }

    if (deckCards.isEmpty) {
      return [];
    }

    // Generate new curriculum
    final generatedUnits = await _generatePathFromAI(deckId, deckCards);
    
    // Cache the result
    final jsonString = jsonEncode(generatedUnits.map((u) => u.toJson()).toList());
    await box.put(deckId, jsonString);
    
    return generatedUnits;
  }

  Future<List<CourseUnit>> _generatePathFromAI(String deckId, List<Flashcard> cards) async {
    // If it's the default deck or a massive deck, we can fallback to the local engine 
    // to avoid massive API costs and wait times, but the user explicitly requested AI generation.
    // So we chunk it.
    
    const int chunkSize = 30;
    final List<CourseUnit> allUnits = [];
    
    // Fallback: if it's the 'default' main deck, we just use the local Smart Spiral
    // so we don't break the original app experience.
    if (deckId == 'default') {
       final localRepo = CourseRepositoryImpl();
       final res = await localRepo.getCourseStructure();
       return res.fold((l) => [], (r) => r);
    }

    // Sort by HSK level or character simplicity (id length is a poor proxy, but we just want deterministic batches)
    cards.sort((a, b) => a.hskLevel.compareTo(b.hskLevel));

    for (int i = 0; i < cards.length; i += chunkSize) {
      final chunk = cards.sublist(i, (i + chunkSize > cards.length) ? cards.length : i + chunkSize);
      final wordListStr = chunk.map((c) => "${c.hanzi} (${c.pinyin}): ${c.definition}").join(", ");

      final prompt = '''
You are a master Chinese language curriculum designer.
I have a list of Chinese vocabulary words. I need you to cluster them into 2-3 thematic "Lessons".
Return ONLY valid JSON with this exact structure, nothing else:

{
  "units": [
    {
      "id": "unique_unit_id",
      "title": "Creative Thematic Title",
      "description": "Short description of the theme",
      "hanziList": ["汉", "字"] // The exact Chinese characters from my list that belong in this lesson
    }
  ]
}

Here are the words:
$wordListStr

Group them logically. EVERY character from the list MUST be placed into exactly one unit's hanziList. Do not omit any.
''';

      try {
        final text = await _geminiService.makeOpenRouterCall(
           model: 'google/gemini-2.5-flash',
           messages: [{'role': 'user', 'content': prompt}],
           jsonMode: true,
        );
        
        final cleanText = text.replaceAll(RegExp(r'^```json\n?'), '')
                              .replaceAll(RegExp(r'^```\n?'), '')
                              .replaceAll(RegExp(r'```$'), '');
                              
        final Map<String, dynamic> data = jsonDecode(cleanText);
        final List<dynamic> jsonUnits = data['units'] ?? [];
        
        for (var ju in jsonUnits) {
          final List<String> hList = List<String>.from(ju['hanziList'] ?? []);
          final List<CourseNode> nodes = [];
          
          String? parentUuid;
          for (int j = 0; j < hList.length; j++) {
            final String h = hList[j];
            // Find corresponding card
            final match = chunk.where((c) => c.hanzi == h);
            if (match.isNotEmpty) {
              final c = match.first;
              // Make the first item the "Sun" (parentUuid = null)
              if (nodes.isEmpty) {
                 parentUuid = c.id;
                 nodes.add(CourseNode(uuid: c.id, hanzi: c.hanzi, parentUuid: null));
              } else {
                 nodes.add(CourseNode(uuid: c.id, hanzi: c.hanzi, parentUuid: parentUuid));
              }
            }
          }
          
          if (nodes.isNotEmpty) {
            allUnits.add(CourseUnit(
              id: "unit_${deckId}_${i}_${ju['title']}",
              title: ju['title'] ?? "Lesson",
              description: ju['description'] ?? "",
              nodes: nodes,
            ));
          }
        }
      } catch (e) {
        // Fallback if AI fails for this chunk
        final List<CourseNode> nodes = [];
        String? parentUuid;
        for (var c in chunk) {
            if (nodes.isEmpty) {
                 parentUuid = c.id;
                 nodes.add(CourseNode(uuid: c.id, hanzi: c.hanzi, parentUuid: null));
            } else {
                 nodes.add(CourseNode(uuid: c.id, hanzi: c.hanzi, parentUuid: parentUuid));
            }
        }
        allUnits.add(CourseUnit(
           id: "fallback_unit_${i}",
           title: "Mixed Vocabulary ${i~/chunkSize + 1}",
           description: "Assorted characters from your deck.",
           nodes: nodes,
        ));
      }
    }
    
    return allUnits;
  }
}
