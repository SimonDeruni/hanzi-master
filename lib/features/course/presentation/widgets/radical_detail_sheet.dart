import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/course/domain/entities/course_unit.dart';
import '../screens/radical_lesson_screen.dart';

class RadicalDetailSheet extends ConsumerStatefulWidget {
  final CourseNode sunNode;
  final List<CourseNode> clusterNodes;

  const RadicalDetailSheet({
    super.key,
    required this.sunNode,
    required this.clusterNodes,
  });

  @override
  ConsumerState<RadicalDetailSheet> createState() => _RadicalDetailSheetState();
}

class _RadicalDetailSheetState extends ConsumerState<RadicalDetailSheet> {
  Map<String, dynamic>? _radicalInfo;
  String? _radicalPinyin;

  @override
  void initState() {
    super.initState();
    _loadRadicalData();
  }

  Future<void> _loadRadicalData() async {
    try {
      final radString = await rootBundle.loadString('assets/data/radicals.json');
      final hskString = await rootBundle.loadString('assets/data/hsk1.json');
      
      final radicalsDb = json.decode(radString)['radicals'] as Map<String, dynamic>;
      final hskList = json.decode(hskString) as List<dynamic>;

      // 1. Info from Radicals DB
      if (radicalsDb.containsKey(widget.sunNode.hanzi)) {
        _radicalInfo = radicalsDb[widget.sunNode.hanzi];
      }
      
      // 2. Pinyin from HSK1 DB
      final hskEntry = hskList.firstWhere(
        (e) => e['hanzi'] == widget.sunNode.hanzi, 
        orElse: () => null
      );
      
      if (hskEntry != null) {
        _radicalPinyin = hskEntry['pinyin'];
      }

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    final info = _radicalInfo ?? {
      "name": "Radical",
      "meaning": "A structural component.",
      "mnemonic": "Master this to unlock its galaxy."
    };

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: Stack(
          children: [
            Positioned.fill(child: CalligraphyBackground(child: Container())),
            
            Column(
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40, height: 4,
                    decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(2)),
                  ),
                ),
                
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // 1. HEADER
                        Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.amber.withValues(alpha: 0.3), width: 1.5),
                            boxShadow: [
                              BoxShadow(color: Colors.amber.withValues(alpha: 0.1), blurRadius: 20, spreadRadius: 5)
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                widget.sunNode.hanzi,
                                style: TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.amberAccent : Colors.brown.shade800,
                                  height: 1.0,
                                ),
                              ),
                              const SizedBox(height: 8),
                              if (_radicalPinyin != null)
                                PinyinText(
                                  text: _radicalPinyin!,
                                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                                ),
                              const SizedBox(height: 16),
                              Text(
                                info['name'].toString().toUpperCase(),
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2.0, color: Colors.grey),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                info['meaning'],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16, color: isDark ? Colors.white70 : Colors.black87),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 32),
                        _buildSectionHeader(Icons.lightbulb_outline, "THE ORIGIN"),
                        const SizedBox(height: 12),
                        Text(
                          info['mnemonic'],
                          style: TextStyle(fontSize: 16, height: 1.5, color: isDark ? Colors.white60 : Colors.black54, fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                        
                        const SizedBox(height: 32),
                        _buildSectionHeader(Icons.hub, "THE GALAXY"),
                        const SizedBox(height: 16),
                        
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: widget.clusterNodes.where((n) => n.uuid != widget.sunNode.uuid).length,
                          itemBuilder: (context, index) {
                            final node = widget.clusterNodes.where((n) => n.uuid != widget.sunNode.uuid).toList()[index];
                            return _GalaxyPreviewChip(node: node, isDark: isDark); 
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context); 
                        if (context.mounted) {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => RadicalLessonScreen(
                                sunNode: widget.sunNode,
                                clusterNodes: widget.clusterNodes,
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber.shade800,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                      ),
                      icon: const Icon(Icons.auto_awesome),
                      label: const Text("INITIATE RADICAL SEQUENCE", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.5)),
      ],
    );
  }
}

class _GalaxyPreviewChip extends ConsumerWidget {
  final CourseNode node;
  final bool isDark;
  const _GalaxyPreviewChip({required this.node, required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCards = ref.watch(flashcardControllerProvider);
    final card = asyncCards.value?.firstWhere((c) => c.id == node.uuid, orElse: () => Flashcard(id: '', hanzi: node.hanzi, pinyin: '', definition: '', hskLevel: 1, strokePaths: const [], modeStats: const {}));

    if (card == null) return const SizedBox();

    return Container(
      width: 100, 
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.brown.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.white24 : Colors.brown.withValues(alpha: 0.2)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            node.hanzi,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.brown.shade800),
          ),
          const SizedBox(height: 4),
          if (card.pinyin.isNotEmpty)
              PinyinText(
                text: card.pinyin,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
              ),
          if (card.definition.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(
              card.definition.split(';').first,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 10, color: isDark ? Colors.white54 : Colors.brown.shade400, fontStyle: FontStyle.italic),
            ),
          ]
        ],
      ),
    );
  }
}