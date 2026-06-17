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

    final List<CourseUnit> finalUnits = [];
    
    // --- STEP 1: Map (Local Clustering) ---
    // Group all cards by their primary radical to guarantee no card is omitted.
    final Map<String, List<Flashcard>> radicalClusters = {};
    final List<Flashcard> unmatchedCards = [];

    for (var card in cards) {
      final meta = _hanziMeta[card.hanzi];
      if (meta != null && meta['radical'] != null && meta['radical'].toString().isNotEmpty) {
        final radical = meta['radical'].toString();
        radicalClusters.putIfAbsent(radical, () => []).add(card);
      } else {
        unmatchedCards.add(card);
      }
    }

    // Combine tiny clusters (e.g. radicals with only 1-2 words) into a 'mixed' pool to avoid sending 100 API calls
    final List<List<Flashcard>> batches = [];
    List<Flashcard> currentMixedBatch = [...unmatchedCards];

    radicalClusters.forEach((radical, clusterCards) {
      if (clusterCards.length >= 4) {
        // Good sized cluster, keep it intact
        batches.add(clusterCards);
      } else {
        currentMixedBatch.addAll(clusterCards);
      }
    });

    // Chunk the mixed batch into groups of ~8-10
    for (int i = 0; i < currentMixedBatch.length; i += 10) {
      batches.add(currentMixedBatch.sublist(i, (i + 10 > currentMixedBatch.length) ? currentMixedBatch.length : i + 10));
    }

    // --- STEP 2: Reduce (AI Titling) ---
    // We process the batches. To save API time, we could process them in parallel, 
    // but for stability we'll process sequentially or in small parallel chunks.
    
    int unitIndex = 0;
    for (var batch in batches) {
      final wordData = batch.map((c) => "${c.hanzi} (${c.pinyin}): ${c.definition}").toList();
      
      final prompt = '''
You are a Master Chinese Curriculum Architect.
I have grouped a small batch of related Chinese vocabulary words.
Your task is to give this specific lesson a poetic, thematic title and a brief 1-sentence description.
Also, pick the simplest or most central character from the list to be the "Anchor Word".

WORDS:
${jsonEncode(wordData)}

Return ONLY valid JSON:
{
  "title": "Creative Thematic Title",
  "description": "Brief pedagogical or semantic rationale",
  "anchorHanzi": "The single most central character from the list"
}
''';

      try {
        final text = await _geminiService.makeOpenRouterCall(
           model: 'google/gemini-2.5-flash',
           messages: [{'role': 'user', 'content': prompt}],
           jsonMode: true,
        );
        
        final cleanJson = text.replaceAll(RegExp(r'^```json\n?'), '')
                              .replaceAll(RegExp(r'^```\n?'), '')
                              .replaceAll(RegExp(r'```$'), '');
                              
        final Map<String, dynamic> aiResponse = jsonDecode(cleanJson);
        
        final String anchorH = aiResponse['anchorHanzi'] ?? batch.first.hanzi;
        
        final List<CourseNode> nodes = [];
        // Ensure anchor card exists in batch
        final anchorCard = batch.firstWhere((c) => c.hanzi == anchorH, orElse: () => batch.first);
        nodes.add(CourseNode(uuid: anchorCard.id, hanzi: anchorCard.hanzi, parentUuid: null));
        
        for (var c in batch) {
          if (c.hanzi == anchorCard.hanzi) continue;
          nodes.add(CourseNode(uuid: c.id, hanzi: c.hanzi, parentUuid: anchorCard.id));
        }

        finalUnits.add(CourseUnit(
          id: "ai_unit_${deckId}_${unitIndex}",
          title: aiResponse['title'] ?? "Lesson ${unitIndex + 1}",
          description: aiResponse['description'] ?? "",
          nodes: nodes,
        ));
      } catch (e) {
        // Fallback for this specific chunk
        final List<CourseNode> nodes = [];
        final anchorCard = batch.first;
        nodes.add(CourseNode(uuid: anchorCard.id, hanzi: anchorCard.hanzi, parentUuid: null));
        for (var c in batch) {
          if (c.id == anchorCard.id) continue;
          nodes.add(CourseNode(uuid: c.id, hanzi: c.hanzi, parentUuid: anchorCard.id));
        }
        
        finalUnits.add(CourseUnit(
           id: "fallback_${deckId}_$unitIndex",
           title: "Vocabulary Batch ${unitIndex + 1}",
           description: "A balanced set of characters from your library.",
           nodes: nodes,
        ));
      }
      unitIndex++;
    }
    
    return finalUnits;
  }
}
