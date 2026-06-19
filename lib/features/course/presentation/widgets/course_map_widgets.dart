import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import '../screens/lesson_screen.dart';
import '../providers/lesson_controller.dart';
import '../../domain/entities/course_unit.dart';
import 'course_painters.dart';
import 'mission_briefing_sheet.dart';
import 'package:hanzi_master/features/onboarding/presentation/screens/tutorial_lesson_screen.dart';
import 'radical_detail_sheet.dart';

class UnitHeader extends StatelessWidget {
  final CourseUnit unit;
  const UnitHeader({super.key, required this.unit});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 60, bottom: 20),
      child: Column(
        children: [
          Text(
            unit.title.toUpperCase(),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              letterSpacing: 8,
              color: isDark ? Colors.white38 : const Color(0xFF5D4037).withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            unit.description,
            style: const TextStyle(fontSize: 10, color: Colors.grey, fontStyle: FontStyle.italic, letterSpacing: 1),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => UnitIntroSheet(unit: unit),
            ),
            icon: const Icon(Icons.menu_book, size: 16),
            label: Text(l10n?.unitIntro?.toUpperCase() ?? "UNIT INTRO", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.brown,
              side: const BorderSide(color: Colors.brown, width: 1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ],
      ),
    );
  }
}

class GalaxyRegion extends StatefulWidget {
  final CourseUnit unit;
  final List<CourseNode> cluster;
  final int unitIndex;
  final int clusterIndex;
  final bool isLastInUnit;
  final String labelSuffix;

  const GalaxyRegion({
    super.key,
    required this.unit,
    required this.cluster,
    required this.unitIndex,
    required this.clusterIndex,
    this.isLastInUnit = false,
    this.labelSuffix = "",
  });

  @override
  State<GalaxyRegion> createState() => _GalaxyRegionState();
}

class _GalaxyRegionState extends State<GalaxyRegion> {
  Map<String, Offset>? _cachedOffsets;
  double? _cachedWidth;

  Map<String, Offset> _getClusterOffsets(List<CourseNode> clusterNodes, double maxWidth) {
    if (_cachedOffsets != null && _cachedWidth == maxWidth) {
      return _cachedOffsets!;
    }

    if (clusterNodes.isEmpty) return {};
    final Map<String, Offset> offsets = {};
    final sunNode = clusterNodes.firstWhere((n) => n.parentUuid == null, orElse: () => clusterNodes.first);
    offsets[sunNode.uuid] = Offset.zero;
    final planets = clusterNodes.where((n) => n.uuid != sunNode.uuid).toList();
    final double maxAvailableRadius = (maxWidth / 2) - 45.0; 
    final double innerRadius = maxAvailableRadius * 0.55;
    final double outerRadius = maxAvailableRadius;
    final int innerCount = min(planets.length, 5);
    final random = Random(sunNode.uuid.hashCode);
    final double startAngle = random.nextDouble() * pi * 2;
    for (int i = 0; i < planets.length; i++) {
      double radius; double angle;
      if (i < innerCount) {
        radius = innerRadius; angle = startAngle + (i * (pi * 2 / innerCount));
      } else {
        radius = outerRadius;
        final int outerIndex = i - innerCount;
        final int outerTotal = planets.length - innerCount;
        angle = startAngle + (pi / innerCount) + (outerIndex * (pi * 2 / outerTotal));
      }
      double jitter = (random.nextDouble() - 0.5) * 15.0;
      if (radius + jitter > maxAvailableRadius) jitter = -5.0; 
      radius += jitter; angle += (random.nextDouble() - 0.5) * 0.2;
      offsets[planets[i].uuid] = Offset(radius * cos(angle), radius * sin(angle));
    }

    _cachedOffsets = offsets;
    _cachedWidth = maxWidth;
    return offsets;
  }

  Color _getThemeColor(String radical) {
    if (radical == '📖') return Colors.amber;
    switch (radical) {
      case '水': case '氵': case '冫': return Colors.cyan;
      case '日': return Colors.orange;
      case '月': return Colors.indigoAccent;
      case '木': case '禾': case '艹': return Colors.lightGreen;
      case '火': case '灬': return Colors.deepOrange;
      case '土': case '石': case '山': return Colors.brown;
      case '雨': return Colors.blueGrey;
      case '人': case '亻': return Colors.amber;
      case '女': return Colors.pinkAccent;
      case '子': return Colors.teal;
      case '口': return Colors.lime;
      case '心': case '忄': return Colors.redAccent;
      case '手': case '扌': return Colors.lightBlue;
      case '目': return Colors.purpleAccent;
      case '宀': return Colors.deepPurple;
      case '门': return Colors.blueGrey;
      case '车': return Colors.red;
      case '工': return Colors.grey;
      case '钅': return Colors.amberAccent; 
      case '田': return Colors.green;
      case '衣': case '衤': return Colors.purple;
      case '辶': case '走': return Colors.orangeAccent;
      case '讠': return Colors.indigo;
      case '力': return Colors.deepOrangeAccent;
      default: return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    const double height = 450.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double midX = constraints.maxWidth / 2;
        final offsets = _getClusterOffsets(widget.cluster, constraints.maxWidth);
        
        final sunNode = widget.cluster.firstWhere((n) => n.parentUuid == null);
        final themeColor = _getThemeColor(sunNode.hanzi);
        
        final String labelText = sunNode.uuid == 'tutorial_intro' 
            ? (l10n?.theScrollOfOrigin ?? "THE SCROLL OF ORIGIN") 
            : "${l10n?.galaxyOf ?? "GALAXY OF"} ${sunNode.hanzi}${widget.labelSuffix}";

        return SizedBox(
          width: double.infinity,
          height: height,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: RepaintBoundary(
                  child: CustomPaint(
                    painter: _AtmospherePainter(color: themeColor, isDark: isDark),
                  ),
                ),
              ),

              Positioned.fill(
                child: RepaintBoundary(
                  child: CustomPaint(
                    painter: GalaxyPainter(
                      offsets: offsets.values.toList(),
                      isDark: isDark,
                      isFirst: widget.unitIndex == 0 && widget.clusterIndex == 0,
                    ),
                  ),
                ),
              ),

              if (!widget.isLastInUnit)
                Positioned(
                  top: 265, 
                  left: midX,
                  height: height, 
                  child: RepaintBoundary(
                    child: CustomPaint(painter: _InterSystemPathPainter(isDark: isDark)),
                  ),
                ),

              Positioned(
                top: 80,
                left: 0, right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.black.withValues(alpha: 0.7) : Colors.white.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: themeColor.withValues(alpha: 0.3), width: 1.0),
                    ),
                    child: Text(
                      labelText,
                      style: TextStyle(
                        fontSize: 14, 
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.5,
                        color: themeColor, 
                      ),
                    ),
                  ),
                ),
              ),

              ...widget.cluster.asMap().entries.map((entry) {
                final nodeIndex = entry.key;
                final node = entry.value;
                final offset = offsets[node.uuid]!;
                final bool isSun = node.parentUuid == null;

                return Positioned(
                  left: midX + offset.dx - (isSun ? 42.5 : 32.5),
                  top: 265 + offset.dy - (isSun ? 42.5 : 32.5),
                  child: MapNode(
                    node: node,
                    isSun: isSun,
                    index: nodeIndex,
                    radicalHanzi: sunNode.hanzi,
                    cluster: widget.cluster,
                  ),
                );
              }),
            ],
          ),
        );
      }
    );
  }
}

class _InterSystemPathPainter extends CustomPainter {
  final bool isDark;
  _InterSystemPathPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = (isDark ? Colors.white : Colors.brown).withValues(alpha: 0.3)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    _drawDashedPath(canvas, Path()..moveTo(0, 50)..lineTo(0, size.height - 50), paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    const double dashWidth = 6.0;
    const double dashSpace = 6.0;
    for (ui.PathMetric metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + dashWidth), paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MapNode extends ConsumerWidget {
  final CourseNode node;
  final bool isSun;
  final int index; 
  final String radicalHanzi; 
  final List<CourseNode>? cluster;

  const MapNode({
    super.key, 
    required this.node, 
    this.isSun = false, 
    this.index = 0,
    required this.radicalHanzi,
    this.cluster,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final cardAsync = ref.watch(flashcardControllerProvider.select(
      (value) => value.whenData((cards) => cards.firstWhere(
        (c) => c.id == node.uuid,
        orElse: () => _createPlaceholder(node),
      ))
    ));
    
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Flashcard card = cardAsync.value ?? _createPlaceholder(node);

    final settings = ref.watch(settingsProvider);
    final bool isTutorial = node.uuid == 'tutorial_intro';
    
    // SHARED MASTERY LOGIC FOR SUNS
    bool isMastered = false;
    if (isTutorial) {
      isMastered = settings.isTutorialCompleted;
    } else if (isSun) {
      final allCards = ref.watch(flashcardControllerProvider).value ?? [];
      isMastered = allCards.any((c) => c.hanzi == node.hanzi && c.isMastered(StudyMode.reading));
    } else {
      isMastered = card.isMastered(StudyMode.reading);
    }

    // GALAXY COMPLETION LOGIC
    final allCards = ref.watch(flashcardControllerProvider).value ?? [];
    final bool isGalaxyCompleted = isSun && cluster != null && cluster!.isNotEmpty && cluster!.every((nodeInCluster) {
      final c = allCards.firstWhere((c) => c.id == nodeInCluster.uuid, orElse: () => _createPlaceholder(nodeInCluster));
      if (nodeInCluster.parentUuid == null) {
        return allCards.any((ac) => ac.hanzi == nodeInCluster.hanzi && ac.isMastered(StudyMode.reading));
      }
      return c.isMastered(StudyMode.reading);
    });
        
    final bool isDue = !isTutorial && !card.isNew(StudyMode.reading) && card.isDue(StudyMode.reading);
    final bool isNew = !isTutorial && card.isNew(StudyMode.reading);

    // Define onTap callback
    void onNodeTap() async {
      if (isTutorial) {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TutorialLessonScreen()),
        );
        ref.invalidate(settingsProvider);
        return;
      }

      // SPECIAL: CONSTELLATION NODE (Not a real radical)
      if (node.hanzi == '✨') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            icon: const Icon(Icons.auto_awesome, size: 48, color: Colors.amber),
            title: Text(l10n?.constellationCluster ?? "Constellation Cluster"),
            content: Text(
              l10n?.constellationDescription ?? "These characters are Independent Stars.\nThey do not belong to a specific Radical family.",
              textAlign: TextAlign.center,
            ),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n?.ok ?? "OK"))],
          ),
        );
        return;
      }

      if (isSun) {
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => RadicalDetailSheet(
            sunNode: node,
            clusterNodes: cluster ?? [],
          ),
        );
        ref.invalidate(flashcardControllerProvider);
        return;
      }

      final updatedCard = await ref.read(flashcardControllerProvider.notifier).loadStrokesFor(card);
      final allCards = ref.read(flashcardControllerProvider).value ?? [];
      
      final metaString = await rootBundle.loadString('assets/data/hanzi_metadata.json');
      final Map<String, dynamic> metaData = json.decode(metaString);
      
      final radString = await rootBundle.loadString('assets/data/radicals.json');
      final Map<String, dynamic> radData = json.decode(radString)['radicals'];
      
      // Common non-radical building blocks in HSK 1
      const Map<String, Map<String, String>> essentialComponents = {
        '也': {'pinyin': 'yě', 'meaning': 'Also'},
        '工': {'pinyin': 'gōng', 'meaning': 'Work'},
        '云': {'pinyin': 'yún', 'meaning': 'Cloud'},
        '尔': {'pinyin': 'ěr', 'meaning': 'You (archaic)'},
        '乍': {'pinyin': 'zhà', 'meaning': 'Suddenly'},
        '主': {'pinyin': 'zhǔ', 'meaning': 'Owner'},
        '门': {'pinyin': 'mén', 'meaning': 'Door'},
        '占': {'pinyin': 'zhàn', 'meaning': 'Occupy'},
        '其': {'pinyin': 'qí', 'meaning': 'Its/That'},
        '丁': {'pinyin': 'dīng', 'meaning': 'Nail'},
        '不': {'pinyin': 'bù', 'meaning': 'No'},
        '且': {'pinyin': 'qiě', 'meaning': 'And'},
        '尼': {'pinyin': 'ní', 'meaning': 'Buddhist Nun'},
        '巴': {'pinyin': 'ba', 'meaning': 'Anxious'},
        '句': {'pinyin': 'jù', 'meaning': 'Sentence'},
        '苗': {'pinyin': 'miáo', 'meaning': 'Sprout'},
        '交': {'pinyin': 'jiāo', 'meaning': 'Exchange'},
        '羊': {'pinyin': 'yáng', 'meaning': 'Sheep'},
        '奇': {'pinyin': 'qí', 'meaning': 'Strange'},
        '反': {'pinyin': 'fǎn', 'meaning': 'Opposite'},
        '兑': {'pinyin': 'duì', 'meaning': 'Exchange'},
        '隹': {'pinyin': 'zhuī', 'meaning': 'Short-tailed bird'},
        '射': {'pinyin': 'shè', 'meaning': 'Shoot'},
        '戋': {'pinyin': 'jiān', 'meaning': 'Small'},
        '采': {'pinyin': 'cǎi', 'meaning': 'Gather'},
        '吾': {'pinyin': 'wú', 'meaning': 'I/Me'},
        '令': {'pinyin': 'lìng', 'meaning': 'Order'},
        '平': {'pinyin': 'píng', 'meaning': 'Flat'},
        '者': {'pinyin': 'zhě', 'meaning': 'The person who...'},
        '矦': {'pinyin': 'hóu', 'meaning': 'Nobleman'},
        '故': {'pinyin': 'gù', 'meaning': 'Cause'},
        '豕': {'pinyin': 'shǐ', 'meaning': 'Pig'},
        '艮': {'pinyin': 'gèn', 'meaning': 'Still/Tough'},
        '景': {'pinyin': 'jǐng', 'meaning': 'Bright'},
        '冉': {'pinyin': 'rǎn', 'meaning': 'Slowly'},
        '与': {'pinyin': 'yǔ', 'meaning': 'Give'},
        '屮': {'pinyin': 'chè', 'meaning': 'Sprout'},
        '矢': {'pinyin': 'shǐ', 'meaning': 'Arrow'},
        '干': {'pinyin': 'gān', 'meaning': 'Dry'},
        '丂': {'pinyin': 'kǎo', 'meaning': 'Obstacle'},
        '乞': {'pinyin': 'qǐ', 'meaning': 'Beg'},
        '冏': {'pinyin': 'jiǒng', 'meaning': 'Window'},
        '畏': {'pinyin': 'wèi', 'meaning': 'Fear'},
        '壴': {'pinyin': 'zhù', 'meaning': 'Drum'},
        '曷': {'pinyin': 'hé', 'meaning': 'Why'},
        '才': {'pinyin': 'cái', 'meaning': 'Talent'},
        '从': {'pinyin': 'cóng', 'meaning': 'Follow'},
        '夬': {'pinyin': 'guài', 'meaning': 'Part/Decide'},
        '冋': {'pinyin': 'jiōng', 'meaning': 'Desert'},
      };

      final List<Flashcard> blueprintComponents = [];
      final String radicalHanziForHighlight = metaData[card.hanzi]?['radical'] ?? "";
      
      if (metaData.containsKey(card.hanzi)) {
        String decomposition = metaData[card.hanzi]['decomposition'] ?? "";
        final String radical = metaData[card.hanzi]['radical'] ?? "";
        
        void addComponent(String char) {
          final existing = allCards.firstWhere((c) => c.hanzi == char, orElse: () {
            final info = radData[char];
            final essential = essentialComponents[char];
            return Flashcard(
              id: 'temp_$char',
              hanzi: char,
              pinyin: info?['pinyin'] ?? essential?['pinyin'] ?? "",
              definition: info?['meaning'] ?? essential?['meaning'] ?? "Component",
              hskLevel: 1, strokePaths: const [], modeStats: const {}
            );
          });
          blueprintComponents.add(existing);
        }

        if (decomposition == "？" || decomposition.isEmpty) {
          if (radical.isNotEmpty && radical != card.hanzi) {
            addComponent(radical);
            final String remainder = card.hanzi.replaceAll(radical, '');
            if (remainder.isNotEmpty) addComponent(remainder);
          }
        } else {
          final String cleanDecomp = decomposition.replaceAll(RegExp(r'[⿰⿱⿲⿳⿴⿵⿶⿷⿸⿹⿺⿻？]'), '');
          for (var i = 0; i < cleanDecomp.length; i++) {
            addComponent(cleanDecomp[i]);
          }
        }
      }
      
      if (blueprintComponents.isEmpty) blueprintComponents.add(card);
      
      for (var i = 0; i < blueprintComponents.length; i++) {
         if (!blueprintComponents[i].id.startsWith('temp_')) {
           final hydrated = await ref.read(flashcardControllerProvider.notifier).loadStrokesFor(blueprintComponents[i]);
           if (hydrated != null) blueprintComponents[i] = hydrated;
         }
      }
      
      ref.read(activeWarmupCardsProvider.notifier).state = blueprintComponents.where((c) => !c.id.startsWith('temp_')).toList();
      ref.read(allCardsProvider.notifier).state = allCards;
      
      // Navigation Handler for components
      Future<void> handleComponentTap(Flashcard comp) async {
        // 1. Is it a Radical?
        final bool isRad = radData.containsKey(comp.hanzi);
        if (isRad) {
          // Find or create a CourseNode for this radical to satisfy the sheet
          final radNode = CourseNode(uuid: 'temp_${comp.hanzi}', hanzi: comp.hanzi);
          Navigator.pop(context); // Close current sheet
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
                      builder: (context) => RadicalDetailSheet(
                        sunNode: radNode,
                        clusterNodes: const [], // We'll let the sheet handle empty cluster gracefully
                      ),          );
          return;
        }

        // 2. Is it a Character? (Refresh the briefing with this character)
        Navigator.pop(context); // Close current
        // Re-trigger the tap logic for this new character
        // We'll call onNodeTap but specifically for this card
        // For simplicity in this scope, we show a preview
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${l10n?.divingInto ?? "Diving into"} ${comp.hanzi}..."), duration: const Duration(milliseconds: 500))
        );
      }

      if (context.mounted) {
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => MissionBriefingSheet(
            targetCard: updatedCard ?? card,
            warmupCards: blueprintComponents,
            radicalHanzi: radicalHanziForHighlight,
            onComponentTap: handleComponentTap, // PASS THE HANDLER
            onStart: () async {
              Navigator.pop(context);
              await Navigator.push(context, MaterialPageRoute(builder: (context) => LessonScreen(card: updatedCard ?? card)));
            },
          ),
        );
        ref.invalidate(flashcardControllerProvider);
      }
    }

    return _IconNode(
      node: node,
      radicalHanzi: radicalHanzi,
      isSun: isSun,
      index: index,
      isMastered: isMastered,
      isGalaxyCompleted: isGalaxyCompleted,
      isDue: isDue,
      isNew: isNew,
      isDark: isDark,
      onTap: onNodeTap,
    );
  }

  Flashcard _createPlaceholder(CourseNode node) => Flashcard(id: node.uuid, hanzi: node.hanzi, pinyin: "", definition: "", hskLevel: 1, strokePaths: const [], modeStats: const {});
}

class _IconNode extends StatelessWidget {
  final CourseNode node;
  final String radicalHanzi;
  final bool isSun;
  final int index;
  final bool isMastered;
  final bool isGalaxyCompleted; // NEW
  final bool isDue;
  final bool isNew;
  final bool isDark;
  final VoidCallback onTap;

  const _IconNode({
    required this.node,
    required this.radicalHanzi,
    required this.isSun,
    required this.index,
    required this.isMastered,
    this.isGalaxyCompleted = false, // Default to false
    required this.isDue,
    required this.isNew,
    required this.isDark,
    required this.onTap,
  });

  // ELEMENTAL COLOR MAPPING
  Color _getThemeColor() {
    if (isGalaxyCompleted && isSun) return Colors.teal; // JADE FOR GALAXY COMPLETION
    if (radicalHanzi == '📖') return Colors.amber;
    if (radicalHanzi == '✨') return Colors.deepPurpleAccent; // CONSTELLATION
    switch (radicalHanzi) {
      case '水': case '氵': case '冫': return Colors.cyan;
      case '日': return Colors.orange;
      case '月': return Colors.indigoAccent;
      case '木': case '禾': case '艹': return Colors.green;
      case '火': case '灬': return Colors.red;
      case '土': case '石': case '山': return Colors.brown;
      case '雨': return Colors.cyan;
      case '风': return Colors.lightBlue;
      case '人': case '亻': return Colors.orange;
      case '女': return Colors.pinkAccent;
      case '子': return Colors.teal;
      case '口': return Colors.lime;
      case '心': case '忄': return Colors.redAccent;
      case '手': case '扌': return Colors.lightBlue;
      case '目': return Colors.purpleAccent;
      case '宀': return Colors.deepPurple;
      case '门': return Colors.blueGrey;
      case '车': return Colors.red;
      case '工': return Colors.grey;
      case '钅': return Colors.amberAccent; 
      case '田': return Colors.green;
      case '衣': case '衤': return Colors.purple;
      case '辶': case '走': return Colors.orangeAccent;
      case '讠': return Colors.indigo;
      case '力': return Colors.deepOrangeAccent;
      default: return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double size = isSun ? 80 : 64;
    final Color themeColor = _getThemeColor();
    
    Color colorA, colorB;
    Color textColor;
    Color borderColor;
    List<BoxShadow> shadows;

    if (isDark) {
      // NIGHT MODE (Glowing Jewels)
      // Hierarchy: Completed Galaxy (Jade) > Mastered Sun (Gold) > Theme Color
      Color effectiveColor = themeColor;
      if (isGalaxyCompleted && isSun) {
        effectiveColor = Colors.greenAccent;
      } else if (isMastered && isSun) {
        effectiveColor = Colors.amber;
      }
      
      colorA = isNew ? Colors.white10 : effectiveColor;
      colorB = isNew ? Colors.white10 : effectiveColor.withValues(alpha: 0.7);
      textColor = isNew ? Colors.white38 : Colors.white;
      borderColor = isMastered ? Colors.white.withValues(alpha: 0.8) : Colors.white.withValues(alpha: 0.1);
      shadows = [
        BoxShadow(color: (isMastered && isSun ? Colors.amber : Colors.black).withValues(alpha: isMastered && isSun ? 0.4 : 0.3), blurRadius: isMastered && isSun ? 15 : 5, offset: const Offset(0, 4)),
        BoxShadow(color: Colors.white.withValues(alpha: 0.2), blurRadius: 5, offset: const Offset(0, -2), spreadRadius: -2, blurStyle: BlurStyle.inner),
      ];
    } else {
      if (isGalaxyCompleted && isSun) {
        // JADE SUN (Completed Galaxy)
        colorA = const Color(0xFF4DB6AC); // Teal Light
        colorB = const Color(0xFF00695C); // Teal Deep
        textColor = Colors.white;
        borderColor = Colors.white.withValues(alpha: 0.8);
      } else if (isMastered) {
        // GOLDEN SUNS vs CINNABAR PLANETS
        colorA = isSun ? const Color(0xFFFFD54F) : const Color(0xFFE53935); // Gold vs Red
        colorB = isSun ? const Color(0xFFFF6F00) : const Color(0xFFB71C1C);
        textColor = isSun ? const Color(0xFF3E2723) : Colors.white;
        borderColor = Colors.white.withValues(alpha: 0.5);
      } else if (isNew) {
        colorA = const Color(0xFFF5F5F5); 
        colorB = const Color(0xFFE0E0E0); 
        textColor = const Color(0xFF2C2C2C).withValues(alpha: 0.5); 
        borderColor = Colors.grey.shade300;
      } else {
        colorA = const Color(0xFFA1887F);
        colorB = const Color(0xFF5D4037);
        textColor = Colors.white;
        borderColor = const Color(0xFFD7CCC8);
      }
      
      shadows = [
        BoxShadow(color: Colors.brown.withValues(alpha: 0.2), blurRadius: 6, offset: const Offset(0, 4)), 
        BoxShadow(color: Colors.white.withValues(alpha: 0.8), blurRadius: 4, offset: const Offset(0, -2), spreadRadius: -1, blurStyle: BlurStyle.inner),
      ];
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            if (isMastered || isDue)
              Container(
                width: size + 15, height: size + 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: (isDue ? Colors.redAccent : themeColor).withValues(alpha: isDark ? 0.4 : 0.2),
                      blurRadius: 20,
                      spreadRadius: 2,
                    )
                  ],
                ),
              ),

            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(size / 2),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: size, height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [colorA, colorB],
                      stops: const [0.2, 1.0],
                      center: const Alignment(-0.3, -0.3),
                    ),
                    boxShadow: shadows,
                    border: Border.all(
                      color: borderColor,
                      width: isSun ? 3 : 1.5,
                    )
                  ),
                  child: Center(
                    child: isSun
                      ? Text(
                          node.hanzi,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: textColor,
                            height: 1.0,
                            shadows: isDark 
                                ? [Shadow(color: Colors.black.withValues(alpha: 0.3), offset: const Offset(1, 1), blurRadius: 2)]
                                : [Shadow(color: Colors.black.withValues(alpha: 0.1), offset: const Offset(1, 1), blurRadius: 1)],
                          ),
                        )
                      : Text(
                          node.hanzi,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: textColor,
                            fontFamily: 'NotoSerifSC',
                          ),
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AtmospherePainter extends CustomPainter {
  final Color color;
  final bool isDark;
  _AtmospherePainter({required this.color, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 1.2; 

    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withValues(alpha: isDark ? 0.3 : 0.25), 
          color.withValues(alpha: 0.0)
        ],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class UnitIntroSheet extends StatefulWidget {
  final CourseUnit unit;
  const UnitIntroSheet({super.key, required this.unit});

  @override
  State<UnitIntroSheet> createState() => _UnitIntroSheetState();
}

class _UnitIntroSheetState extends State<UnitIntroSheet> {
  final List<Map<String, dynamic>> _radicals = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final metaString = await rootBundle.loadString('assets/data/hanzi_metadata.json');
      final hanziMeta = json.decode(metaString);
      final radicalString = await rootBundle.loadString('assets/data/radicals.json');
      final radicalDb = json.decode(radicalString)['radicals'];

      final Set<String> unitChars = widget.unit.nodes.map((n) => n.hanzi).toSet();
      final Set<String> seenRadicals = {};
      final List<Map<String, dynamic>> radicals = [];

      for (var char in unitChars) {
        for (var subChar in char.split('')) {
          final meta = hanziMeta[subChar];
          if (meta != null) {
            final radical = meta['radical'];
            if (!seenRadicals.contains(radical) && radicalDb.containsKey(radical)) {
              seenRadicals.add(radical);
              radicals.add({
                'char': radical,
                'info': radicalDb[radical],
              });
            }
          }
        }
      }
      
      if (mounted) {
        setState(() {
          _radicals.addAll(radicals);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: SizedBox(width: 40, height: 4, child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(2))))),
          const SizedBox(height: 24),
          Text("${l10n?.unitIntro ?? "Unit Intro"}: ${widget.unit.title}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo)),
          const SizedBox(height: 8),
          Text(widget.unit.description, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 24),
          Text(l10n?.keyRadicals ?? "KEY RADICALS", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: Colors.brown)),
          const SizedBox(height: 16),
          Expanded(
            child: _isLoading 
              ? const Center(child: CircularProgressIndicator()) 
              : (_radicals.isEmpty 
                  ? Center(child: Text(l10n?.noRadicalDataAvailable ?? "No radical data available.")) 
                  : ListView.separated(
                      itemCount: _radicals.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = _radicals[index];
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.brown.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Text(item['char'], style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.red)),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item['info']['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    Text(item['info']['meaning'], style: const TextStyle(fontSize: 14, color: Colors.black87)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                ),
          ),
        ],
      ),
    );
  }
}
