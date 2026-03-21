import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/quiz/presentation/screens/quiz_screen.dart';
import '../providers/course_controller.dart';
import '../../domain/entities/course_unit.dart';
import '../../../progression/presentation/widgets/ink_stone_widget.dart';
import '../widgets/course_map_widgets.dart';
import '../widgets/course_painters.dart';

class CourseScreen extends ConsumerWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUnits = ref.watch(courseControllerProvider);
    final isLibraryLoading = ref.watch(flashcardControllerProvider.select((s) => s.isLoading));

    return Scaffold(
      appBar: AppBar(
        title: const Text("THE LIVING SCROLL", 
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 6, fontSize: 10, color: Colors.brown)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 1. GLOBAL BACKGROUND
          Positioned.fill(
            child: RepaintBoundary(
              child: CustomPaint(
                painter: AncientAtlasPainter(
                  index: 0, 
                  isDark: Theme.of(context).brightness == Brightness.dark,
                  themeName: 'Nature', 
                ),
              ),
            ),
          ),

          // 2. SCROLLABLE CONTENT
          SafeArea(
            bottom: false,
            child: asyncUnits.when(
              data: (units) {
                final List<dynamic> viewItems = [];
                viewItems.add(const SizedBox(height: 120)); 
                viewItems.add(const InkStoneWidget());
                viewItems.add(const SizedBox(height: 40));

                for (int i = 0; i < units.length; i++) {
                  final unit = units[i];
                  viewItems.add(UnitHeader(unit: unit));

                  final clusters = _identifyClusters(unit.nodes);
                  final Map<String, int> radicalCounts = {};

                  for (int j = 0; j < clusters.length; j++) {
                    final cluster = clusters[j];
                    final sunNode = cluster.firstWhere((n) => n.parentUuid == null, orElse: () => cluster.first);
                    final String radical = sunNode.hanzi;
                    
                    final int count = (radicalCounts[radical] ?? 0) + 1;
                    radicalCounts[radical] = count;
                    
                    String suffix = "";
                    if (count > 1) {
                      suffix = " ${_toRoman(count)}";
                    }

                    viewItems.add(_GalaxyClusterItem(
                      unit: unit,
                      cluster: cluster,
                      unitIndex: i,
                      clusterIndex: j,
                      isLastInUnit: j == clusters.length - 1,
                      labelSuffix: suffix,
                    ));
                  }
                  viewItems.add(const SizedBox(height: 100));
                }

                viewItems.add(const SizedBox(height: 200));

                return CustomScrollView(
                  cacheExtent: 500,
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = viewItems[index];
                          if (item is Widget) return item;
                          if (item is _GalaxyClusterItem) {
                            return GalaxyRegion(
                              unit: item.unit,
                              cluster: item.cluster,
                              unitIndex: item.unitIndex,
                              clusterIndex: item.clusterIndex,
                              isLastInUnit: item.isLastInUnit,
                              labelSuffix: item.labelSuffix,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                        childCount: viewItems.length,
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator(color: Colors.brown)),
              error: (err, stack) => Center(child: Text("Error: $err", style: const TextStyle(color: Colors.red))),
            ),
          ),

          // 3. OVERLAY LOADING
          if (isLibraryLoading)
            Positioned.fill(
              child: AbsorbPointer(
                child: Container(
                  color: Colors.black54,
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(color: Colors.white),
                        SizedBox(height: 16),
                        Text("Initializing Library...", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'course_quiz_fab',
        onPressed: () {
          final cards = ref.read(flashcardControllerProvider).value ?? [];
          if (cards.length < 4) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Unlock at least 4 characters to start a quiz!")));
            return;
          }
          Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen(availableCards: cards)));
        },
        label: const Text("PRACTICE QUIZ"),
        icon: const Icon(Icons.quiz),
        backgroundColor: Colors.indigo,
      ),
    );
  }

  List<List<CourseNode>> _identifyClusters(List<CourseNode> nodes) {
    final Map<String, List<CourseNode>> clusters = {};
    final suns = nodes.where((n) => n.parentUuid == null).toList();
    for (var sun in suns) {
      clusters[sun.uuid] = [sun];
      clusters[sun.uuid]!.addAll(nodes.where((n) => n.parentUuid == sun.uuid));
    }
    return clusters.values.toList();
  }

  String _toRoman(int num) {
    if (num == 1) return "I";
    if (num == 2) return "II";
    if (num == 3) return "III";
    if (num == 4) return "IV";
    if (num == 5) return "V";
    return "$num";
  }
}

class _GalaxyClusterItem {
  final CourseUnit unit;
  final List<CourseNode> cluster;
  final int unitIndex;
  final int clusterIndex;
  final bool isLastInUnit;
  final String labelSuffix;

  _GalaxyClusterItem({
    required this.unit,
    required this.cluster,
    required this.unitIndex,
    required this.clusterIndex,
    required this.isLastInUnit,
    this.labelSuffix = "",
  });
}