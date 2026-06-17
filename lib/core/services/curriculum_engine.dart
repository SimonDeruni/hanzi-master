import 'dart:convert';
import 'package:flutter/services.dart';
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
  Map<String, dynamic> _hanziMeta = {};
  bool _isMetaLoaded = false;
  
  CurriculumEngineService(this._geminiService);

  Future<void> _ensureMetadataLoaded() async {
    if (_isMetaLoaded) return;
    try {
      final jsonString = await rootBundle.loadString('assets/data/hanzi_metadata.json');
      _hanziMeta = jsonDecode(jsonString);
      _isMetaLoaded = true;
    } catch (e) {
      // Fallback or ignore
    }
  }

  bool hasCachedCurriculum(String deckId) {
    final box = Hive.box<String>('curriculum_cache_box');
    return box.containsKey(deckId);
  }

  Future<void> generateAndCacheCurriculum(String deckId, List<Flashcard> allCards) async {
    await _ensureMetadataLoaded();
    // Filter cards for this deck
    final deckCards = allCards.where((c) => c.deckId == deckId).toList();
    if (deckCards.isEmpty) return;

    final box = Hive.box<String>('curriculum_cache_box');
    final generatedUnits = await _generatePathFromAI(deckId, deckCards);
    
    // Cache the result
    final jsonString = jsonEncode(generatedUnits.map((u) => u.toJson()).toList());
    await box.put(deckId, jsonString);
  }

  Future<List<CourseUnit>> getCurriculumForDeck(String deckId, List<Flashcard> allCards) async {
    await _ensureMetadataLoaded();
    final box = Hive.box<String>('curriculum_cache_box');
    final cachedJson = box.get(deckId);

    // Filter cards for this deck
    final deckCards = allCards.where((c) => c.deckId == deckId).toList();

    if (cachedJson != null) {
      try {
        final List<dynamic> decoded = jsonDecode(cachedJson);
        final cachedUnits = decoded.map((e) => CourseUnit.fromJson(e)).toList();
        
        // Validation: Ensure cache contains roughly the same cards
        int cachedNodeCount = 0;
        for (var unit in cachedUnits) {
          cachedNodeCount += unit.nodes.length;
        }
        
        if ((cachedNodeCount - deckCards.length).abs() <= 3) {
          return cachedUnits;
        }
      } catch (e) {
        // Cache corrupted
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
    if (deckId == 'default') {
       final localRepo = CourseRepositoryImpl();
       final res = await localRepo.getCourseStructure();
       return res.fold((l) => [], (r) => r);
    }

    // Pass 1: Global Syllabus Strategy
    // We send all Hanzi with their radical/component metadata for optimal clustering
    final wordData = cards.map((c) {
      final meta = _hanziMeta[c.hanzi] ?? {};
      return {
        'hanzi': c.hanzi,
        'pinyin': c.pinyin,
        'meaning': c.definition,
        'radical': meta['radical'] ?? '',
        'components': meta['decomposition'] ?? '',
        'hsk': c.hskLevel,
      };
    }).toList();

    final syllabusPrompt = '''
You are a Master Chinese Curriculum Architect. I have a deck of ${cards.length} Chinese words.
Your goal is to design a coherent learning path (Syllabus).

RULES:
1. Group words by SHARED RADICALS or COMPONENTS whenever possible (Pedagogical Clustering).
2. If no radical link exists, group by semantic theme (e.g., "Dining", "Emotions").
3. Each Unit should have 5-10 words.
4. For each Unit, identify ONE "Anchor Word" (the Sun node). This should be the simplest or most conceptually central word that others orbit.
5. Order the units so that simpler components are taught before complex characters that contain them (Prerequisite Mapping).

Return ONLY valid JSON with this exact structure:
{
  "units": [
    {
      "title": "Unit Title (e.g. The Flow of Water)",
      "description": "Brief pedagogical rationale",
      "anchorHanzi": "The main character",
      "orbitHanzi": ["other", "characters", "in", "this", "unit"]
    }
  ]
}

Words to Process:
${jsonEncode(wordData)}
''';

    try {
      final syllabusText = await _geminiService.makeOpenRouterCall(
         model: 'google/gemini-2.5-flash',
         messages: [{'role': 'user', 'content': syllabusPrompt}],
         jsonMode: true,
      );
      
      final cleanSyllabus = syllabusText.replaceAll(RegExp(r'^```json\n?'), '')
                                      .replaceAll(RegExp(r'^```\n?'), '')
                                      .replaceAll(RegExp(r'```$'), '');
                              
      final Map<String, dynamic> syllabus = jsonDecode(cleanSyllabus);
      final List<dynamic> jsonUnits = syllabus['units'] ?? [];
      
      final List<CourseUnit> finalUnits = [];
      
      for (var ju in jsonUnits) {
        final String anchorH = ju['anchorHanzi'] ?? '';
        final List<String> orbitH = List<String>.from(ju['orbitHanzi'] ?? []);
        final List<CourseNode> nodes = [];
        
        // 1. Process Anchor (Sun)
        final anchorCard = cards.firstWhere((c) => c.hanzi == anchorH, orElse: () => cards.first);
        nodes.add(CourseNode(uuid: anchorCard.id, hanzi: anchorCard.hanzi, parentUuid: null));
        
        // 2. Process Orbits
        for (var h in orbitH) {
          if (h == anchorH) continue;
          final match = cards.where((c) => c.hanzi == h);
          if (match.isNotEmpty) {
            final c = match.first;
            nodes.add(CourseNode(uuid: c.id, hanzi: c.hanzi, parentUuid: anchorCard.id));
          }
        }
        
        if (nodes.isNotEmpty) {
          finalUnits.add(CourseUnit(
            id: "ai_unit_${deckId}_${finalUnits.length}_${ju['title']}",
            title: ju['title'] ?? "Lesson",
            description: ju['description'] ?? "",
            nodes: nodes,
          ));
        }
      }
      
      return finalUnits;
    } catch (e) {
      // Fallback: Smart Chunking if AI fails
      final List<CourseUnit> fallbackUnits = [];
      cards.sort((a, b) => a.hskLevel.compareTo(b.hskLevel));
      
      for (int i = 0; i < cards.length; i += 8) {
        final chunk = cards.sublist(i, (i + 8 > cards.length) ? cards.length : i + 8);
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
        
        fallbackUnits.add(CourseUnit(
           id: "fallback_${deckId}_$i",
           title: "Vocabulary Batch ${i~/8 + 1}",
           description: "A balanced set of characters from your library.",
           nodes: nodes,
        ));
      }
      return fallbackUnits;
    }
  }
}
