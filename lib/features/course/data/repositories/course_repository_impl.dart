import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/course_unit.dart';
import '../../domain/repositories/course_repository.dart';

class CourseRepositoryImpl implements CourseRepository {
  // --- THE "SMART SPIRAL" CURRICULUM ---
  static const Map<String, String> _radicalToTheme = {
    // UNIT 1: THE ORIGIN (Basic Strokes & High Frequency)
    '一': 'Origin', '丨': 'Origin', '丿': 'Origin', '丶': 'Origin', 
    '乙': 'Origin', '亅': 'Origin', '二': 'Origin', '十': 'Origin',
    '八': 'Origin', '厶': 'Origin', '又': 'Origin', '匕': 'Origin',
    '口': 'Origin', // Very simple shape, high freq
    '人': 'Origin', // Very simple shape, high freq
    '亻': 'Origin', 

    // UNIT 2: THE ELEMENTS (Concrete Pictographs)
    '日': 'Elements', '月': 'Elements', 
    '水': 'Elements', '氵': 'Elements', '冫': 'Elements',
    '火': 'Elements', '灬': 'Elements', 
    '木': 'Elements', '禾': 'Elements', '竹': 'Elements', '艹': 'Elements',
    '土': 'Elements', '石': 'Elements', '山': 'Elements', 
    '雨': 'Elements', '风': 'Elements', 

    // UNIT 3: HUMANITY (Body, Family, Emotions)
    '女': 'Humanity', '子': 'Humanity', '父': 'Humanity', '儿': 'Humanity',
    '手': 'Humanity', '扌': 'Humanity', 
    '目': 'Humanity', '耳': 'Humanity', '舌': 'Humanity', '身': 'Humanity',
    '心': 'Humanity', '忄': 'Humanity',
    '尸': 'Humanity', '欠': 'Humanity', // Often body related actions

    // UNIT 4: THE VILLAGE (Structures, Agriculture, Tools)
    '宀': 'Village', '冖': 'Village', '广': 'Village', '厂': 'Village', 
    '门': 'Village', '户': 'Village',
    '田': 'Village', '力': 'Village', 
    '工': 'Village', '斤': 'Village', '刀': 'Village', '刂': 'Village', 
    '弓': 'Village', '矢': 'Village', '戈': 'Village',
    '囗': 'Village', // Enclosure

    // UNIT 5: THE JOURNEY (Movement, Speech, Eating)
    '辶': 'Journey', '走': 'Journey', '彳': 'Journey', '足': 'Journey',
    '讠': 'Journey', // Speech is an action/interaction
    '饣': 'Journey', // Eating is an activity
    '立': 'Journey', '止': 'Journey', 
    '攵': 'Journey', '攴': 'Journey', // Action suffix

    // UNIT 6: THE CITY (Complex Objects, Attributes, Society)
    '金': 'City', '钅': 'City', 
    '车': 'City', '舟': 'City',
    '衣': 'City', '衤': 'City', '巾': 'City', '糸': 'City', '纟': 'City',
    '贝': 'City', // Money
    '皿': 'City', // Dish/Vessel
    '大': 'City', '小': 'City', '高': 'City', '长': 'City', '白': 'City', // Attributes
    '文': 'City', // Culture
  };

  static const Map<String, String> _themeDescriptions = {
    'Origin': 'The simplest shapes. The beginning of all things.',
    'Elements': 'Sun, Moon, Water, and Fire. The natural world.',
    'Humanity': 'The body, the heart, and the family.',
    'Village': 'Fields, roofs, and tools. The foundations of society.',
    'Journey': 'Movement, speech, and sustenance.',
    'City': 'Commerce, clothing, and complex artifacts.',
  };

  @override
  Future<Either<String, List<CourseUnit>>> getCourseStructure() async {
    try {
      // 1. Load Data
      final hsk1String = await rootBundle.loadString('assets/data/hsk1.json');
      final hsk2String = await rootBundle.loadString('assets/data/hsk2_bundle.json');
      final metaString = await rootBundle.loadString('assets/data/hanzi_metadata.json');

      // 2. Compute Clusters (Mixing HSK1 and HSK2)
      final units = await compute(_processGalaxyData, {
        'hsk1': hsk1String,
        'hsk2': hsk2String,
        'meta': metaString,
        'radicalToTheme': _radicalToTheme,
        'themeDescriptions': _themeDescriptions,
      });

      return Right(units);

    } catch (e) {
      return Left("Failed to generate balanced galactic structure: $e");
    }
  }
}

// --- BACKGROUND ISOLATE LOGIC ---

List<CourseUnit> _processGalaxyData(Map<String, dynamic> params) {

  final hsk1Data = json.decode(params['hsk1']) as List<dynamic>;
  final hsk2Bundle = json.decode(params['hsk2']) as Map<String, dynamic>;
  final hsk2Data = hsk2Bundle['vocabulary'] as List<dynamic>;
  
  final metaData = json.decode(params['meta']) as Map<String, dynamic>;
  final radicalToTheme = params['radicalToTheme'] as Map<String, String>;
  final themeDescriptions = params['themeDescriptions'] as Map<String, String>;

  final List<dynamic> combinedData = [
    ...hsk1Data,
    ...hsk2Data.asMap().entries.map((e) {
      final item = e.value as Map<String, dynamic>;
      // Ensure HSK 2 items have deterministic UUIDs for clustering consistency
      return {
        ...item,
        'uuid': item['uuid'] ?? 'hsk2_${(e.key + 1).toString().padLeft(3, '0')}',
      };
    }),
  ];

  // 2. Group by Radical first
  final Map<String, List<Map<String, dynamic>>> radicalGroups = {};
  final Map<String, List<Map<String, dynamic>>> miscRadicals = {};

  for (final item in combinedData) {
    final Map<String, dynamic> charData = item as Map<String, dynamic>;
    final String hanzi = charData['hanzi'];
    final String firstChar = hanzi.isNotEmpty ? hanzi[0] : '';
    
    String radical = '?';
    if (firstChar.isNotEmpty && metaData.containsKey(firstChar)) {
      radical = metaData[firstChar]['radical'];
    }
    
    // Check if this radical belongs to a known theme
    if (radicalToTheme.containsKey(radical)) {
       radicalGroups.putIfAbsent(radical, () => []).add(charData);
    } else {
       miscRadicals.putIfAbsent(radical, () => []).add(charData);
    }
  }



  // 3. Process Themes with "Equilibrium Algorithm"
  final List<CourseUnit> units = [];
  
  // STRICT ORDERING - REMOVED 'Misc'
  final List<String> orderedThemes = [
    'Origin', 
    'Elements', 
    'Humanity', 
    'Village', 
    'Journey', 
    'City', 
  ];

  for (final themeName in orderedThemes) {
      final String desc = themeDescriptions[themeName] ?? '';

      // Collect radicals for this theme
      final Map<String, List<Map<String, dynamic>>> themeRadicals = {};
      
      // Explicit mapping first
      radicalGroups.forEach((radical, chars) {
        final String theme = radicalToTheme[radical] ?? 'Misc';
        if (theme == themeName) themeRadicals[radical] = chars;
      });
      
      // If we are in the LAST unit (City), dump any remaining 'Misc' radicals here?
      // Or distribute them? Let's just dump unmapped stuff into 'City' or 'Origin' as "Constellations".
      // Better: Map 'Misc' to 'Origin' by default in the loop above?
      // Let's iterate miscRadicals and assign them to themes based on heuristic or just dump to Origin.
      // Current plan: Use 'Origin' as the catch-all for unmapped basics.
      
      if (themeName == 'Origin') {
         themeRadicals.addAll(miscRadicals);
      }

      if (themeRadicals.isEmpty) continue;

      final List<CourseNode> allUnitNodes = [];
      
      // INJECT TUTORIAL NODE (Only for Origin unit)
      if (themeName == 'Origin') {
        allUnitNodes.add(const CourseNode(
          uuid: 'tutorial_intro',
          hanzi: '📖', 
          parentUuid: null,
        ));
      }

      int clusterCounter = 0;
      List<Map<String, dynamic>> themeConstellationPool = []; // Orphans for THIS theme

      final sortedRadicals = themeRadicals.keys.toList()
        ..sort((a, b) => themeRadicals[b]!.length.compareTo(themeRadicals[a]!.length));

      for (final radical in sortedRadicals) {
          final chars = themeRadicals[radical]!;

          // If really big, split it
          if (chars.length > 7) {
              for (var i = 0; i < chars.length; i += 7) {
                  final chunk = chars.sublist(i, min(i + 7, chars.length));
                  allUnitNodes.addAll(_generateClusterNodes(radical, chunk, clusterCounter++));
              }
          } 
          // If tiny, add to Constellation
          else if (chars.length < 3) {
              themeConstellationPool.addAll(chars);
          } 
          // Normal size
          else {
              allUnitNodes.addAll(_generateClusterNodes(radical, chars, clusterCounter++));
          }
      }

      // Create "Constellation" for orphans
      if (themeConstellationPool.isNotEmpty) {
          // Break into chunks of 6 to avoid massive constellations
           for (var i = 0; i < themeConstellationPool.length; i += 6) {
              final chunk = themeConstellationPool.sublist(i, min(i + 6, themeConstellationPool.length));
              allUnitNodes.addAll(_generateClusterNodes('✨', chunk, clusterCounter++, isMerged: true));
           }
      }

      units.add(CourseUnit(
          id: 'unit_${themeName.toLowerCase()}',
          title: themeName,
          description: desc,
          nodes: allUnitNodes,
      ));
  }

  return units;
}

List<CourseNode> _generateClusterNodes(String radical, List<Map<String, dynamic>> chars, int clusterIndex, {bool isMerged = false}) {
  final List<CourseNode> nodes = [];
  final exactMatch = chars.where((c) => c['hanzi'] == radical);
  
  String sunUuid;
  String sunHanzi;

  if (exactMatch.isNotEmpty) {
    final sunChar = exactMatch.first;
    sunUuid = sunChar['uuid'];
    sunHanzi = sunChar['hanzi'];
    nodes.add(CourseNode(uuid: sunUuid, hanzi: sunHanzi, parentUuid: null));
  } else {
    sunUuid = 'radical_ghost_${radical}_$clusterIndex';
    sunHanzi = radical;
    nodes.add(CourseNode(uuid: sunUuid, hanzi: sunHanzi, parentUuid: null));
  }

  for (final char in chars) {
    if (char['uuid'] == sunUuid) continue;
    nodes.add(CourseNode(uuid: char['uuid'], hanzi: char['hanzi'], parentUuid: sunUuid));
  }

  return nodes;
}
