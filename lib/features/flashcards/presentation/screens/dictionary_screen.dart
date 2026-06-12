import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/stats_screen.dart';
import 'package:hanzi_master/features/course/domain/entities/course_unit.dart';
import 'package:hanzi_master/features/course/presentation/widgets/radical_detail_sheet.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/settings_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/flashcard_form_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/review_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/character_detail_screen.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/streak_seal.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/mastery_seal.dart';
import 'package:hanzi_master/features/premium/presentation/screens/paywall_sheet.dart';
import 'package:hanzi_master/features/premium/presentation/screens/ocr_scanner_screen.dart';
import 'package:hanzi_master/core/services/ocr_service.dart';
import 'package:hanzi_master/core/providers/premium_controller.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/cross_reference_text.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/dictionary_provider.dart';

class DictionaryScreen extends ConsumerStatefulWidget {
  const DictionaryScreen({super.key});

  @override
  ConsumerState<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends ConsumerState<DictionaryScreen> {
  String _searchQuery = "";

  Future<void> _runMagicLens() async {
    final isPremium = ref.read(premiumControllerProvider).valueOrNull ?? false;
    if (!isPremium) {
      PaywallSheet.show(context);
      return;
    }

    final bool? fromCamera = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[900] : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Magic Lens", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.indigo),
              title: const Text("Take Photo"),
              onTap: () => Navigator.pop(context, true),
            ),
            ListTile(
              leading: const Icon(Icons.image, color: Colors.indigo),
              title: const Text("Choose from Gallery"),
              onTap: () => Navigator.pop(context, false),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );

    if (!mounted) return;

    if (fromCamera == null) return; // User canceled

    final ocrService = OcrService();
    // Show a loading indicator while the camera/ML Kit works
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Scanning image..."), duration: Duration(seconds: 1)),
      );
    }

    final extractedText = await ocrService.scanImage(fromCamera: fromCamera);
    
    if (!mounted) return;

    if (extractedText == null || extractedText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No Chinese characters recognized.")),
      );
      return;
    }

    final allCards = ref.read(flashcardControllerProvider).valueOrNull ?? [];
    List<Flashcard> matchedCards = [];
    bool reachedLimit = false;
    
    // Find all unique matching cards (Limit to top 10 for Magic Lens)
    for (int i = 0; i < extractedText.length; i++) {
      final char = extractedText[i];
      final match = allCards.firstWhere(
        (c) => c.hanzi == char, 
        orElse: () => Flashcard(id: 'dummy', hanzi: '', pinyin: '', definition: '', hskLevel: 0, strokePaths: const [], nextReviewDate: DateTime.now(), interval: 0, easeFactor: 0, streak: 0),
      );
      if (match.hanzi.isNotEmpty && !matchedCards.any((c) => c.hanzi == match.hanzi)) {
        matchedCards.add(match);
        if (matchedCards.length >= 10) {
          reachedLimit = true;
          break; // Stop after 10 matches to keep the UI clean
        }
      }
    }

    if (!mounted) return;

    if (matchedCards.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Characters recognized, but none are in your HSK library.")),
      );
      return;
    }

    if (matchedCards.length == 1) {
      // Just one match, go straight to it
      if (mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterDetailScreen(card: matchedCards.first)));
      }
    } else {
      // Multiple matches, let the user choose
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[900] : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Multiple Characters Found", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("Which one do you want to inspect?", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: matchedCards.length,
                  itemBuilder: (context, index) {
                    final card = matchedCards[index];
                    return ListTile(
                      leading: Text(card.hanzi, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo)),
                      title: PinyinText(text: card.pinyin, style: const TextStyle(fontSize: 16)),
                      subtitle: Text(card.definition, maxLines: 1, overflow: TextOverflow.ellipsis),
                      onTap: () {
                        Navigator.pop(context); // Close the sheet
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterDetailScreen(card: card)));
                      },
                    );
                  },
                ),
              ),
              if (reachedLimit)
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline, size: 16, color: Colors.grey),
                      SizedBox(width: 8),
                      Text("Showing top 10. Use 'Snapshot' for full pages.", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: CalligraphyBackground(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                title: const Text(
                  "Scholar's Library",
                  style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                foregroundColor: isDark ? Colors.white70 : Colors.black87,
                actions: [
                  Consumer(
                    builder: (context, ref, child) {
                      final isPremium = ref.watch(premiumControllerProvider).valueOrNull ?? false;
                      
                      return Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.camera_alt),
                            onPressed: () {
                              if (isPremium) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const OcrScannerScreen()));
                              } else {
                                PaywallSheet.show(context);
                              }
                            },
                          ),
                          if (isPremium)
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.workspace_premium, color: Colors.amber),
                            )
                          else
                            IconButton(
                              icon: const Icon(Icons.workspace_premium_outlined, color: Colors.indigo),
                              onPressed: () => PaywallSheet.show(context),
                            ),
                        ],
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0, top: 10, bottom: 10),
                    child: StreakSeal(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.bar_chart),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StatsScreen())),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen())),
                  ),
                ],
                bottom: const TabBar(
                  indicatorColor: Colors.indigo,
                  labelColor: Colors.indigo,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: "CHARACTERS"),
                    Tab(text: "RADICALS"),
                  ],
                ),
              ),
            ],
            body: Column(
              children: [
                // B. MINIMALIST SEARCH BAR
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: TextField(
                    style: TextStyle(color: isDark ? Colors.white : Colors.black),
                    decoration: InputDecoration(
                      hintText: "Search Library...",
                      hintStyle: TextStyle(color: isDark ? Colors.white30 : Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.indigo),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.document_scanner, color: Colors.indigo),
                        tooltip: "Magic Lens (Scan a character)",
                        onPressed: _runMagicLens,
                      ),
                      filled: true,
                      fillColor: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white.withValues(alpha: 0.7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                    onChanged: (value) => setState(() => _searchQuery = value),
                  ),
                ),

                // C. TABS CONTENT
                Expanded(
                  child: TabBarView(
                    children: [
                      _CharacterLibraryTab(searchQuery: _searchQuery),
                      _RadicalLibraryTab(searchQuery: _searchQuery),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'dictionary_add_fab',
          mini: true,
          backgroundColor: Colors.indigo,
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FlashcardFormScreen()),
          ),
        ),
      ),
    );
  }
}

class _CharacterLibraryTab extends ConsumerWidget {
  final String searchQuery;
  const _CharacterLibraryTab({required this.searchQuery});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncFlashcards = ref.watch(flashcardControllerProvider);
    final masterResults = ref.watch(masterSearchProvider(searchQuery)).valueOrNull ?? [];

    return asyncFlashcards.when(
      data: (flashcards) {
        final filteredCards = flashcards.where((card) {
          final query = searchQuery.toLowerCase();
          return card.hanzi.contains(query) ||
                 card.pinyin.toLowerCase().contains(query) ||
                 card.definition.toLowerCase().contains(query);
        }).toList();

        final libraryHanzi = filteredCards.map((c) => c.hanzi).toSet();
        final extraResults = masterResults.where((c) => !libraryHanzi.contains(c.hanzi)).toList();

        if (flashcards.isEmpty && extraResults.isEmpty) {
          if (searchQuery.isNotEmpty) {
            return Center(child: Text("No results found for '$searchQuery'", style: const TextStyle(color: Colors.grey)));
          }
          return _buildEmptyState(ref);
        }

        return CustomScrollView(
          slivers: [
            if (filteredCards.isNotEmpty) ...[
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(24, 20, 24, 8),
                sliver: SliverToBoxAdapter(
                  child: Text("IN YOUR LIBRARY", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: Colors.indigo)),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, 
                    childAspectRatio: 0.9, 
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _DictionaryItem(card: filteredCards[index]),
                    childCount: filteredCards.length,
                  ),
                ),
              ),
            ],
            if (extraResults.isNotEmpty) ...[
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(24, 32, 24, 8),
                sliver: SliverToBoxAdapter(
                  child: Text("MASTER DICTIONARY", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: Colors.teal)),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, 
                    childAspectRatio: 0.9, 
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _DictionaryItem(card: extraResults[index]),
                    childCount: extraResults.length,
                  ),
                ),
              ),
            ],
            const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text("Error: $err")),
    );
  }

  Widget _buildEmptyState(WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_stories, size: 80, color: Colors.indigo.withValues(alpha: 0.3)),
          const SizedBox(height: 16),
          const Text("Your library is empty", style: TextStyle(fontSize: 18, color: Colors.grey)),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => ref.read(flashcardControllerProvider.notifier).importHsk1(),
            icon: const Icon(Icons.download),
            label: const Text("Import HSK 1"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () => ref.read(flashcardControllerProvider.notifier).importLevel(2),
            icon: const Icon(Icons.download_for_offline),
            label: const Text("Import HSK 2"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal.shade700,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}

class _RadicalLibraryTab extends ConsumerStatefulWidget {
  final String searchQuery;
  const _RadicalLibraryTab({required this.searchQuery});

  @override
  ConsumerState<_RadicalLibraryTab> createState() => _RadicalLibraryTabState();
}

class _RadicalLibraryTabState extends ConsumerState<_RadicalLibraryTab> {
  Map<String, dynamic> _radicals = {};
  Map<String, dynamic> _hanziMeta = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final radString = await rootBundle.loadString('assets/data/radicals.json');
      final metaString = await rootBundle.loadString('assets/data/hanzi_metadata.json');
      
      if (mounted) {
        setState(() {
          _radicals = json.decode(radString)['radicals'];
          _hanziMeta = json.decode(metaString);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());

    final filteredRadicals = _radicals.entries.where((entry) {
      final query = widget.searchQuery.toLowerCase();
      final key = entry.key;
      final name = (entry.value['name'] as String).toLowerCase();
      final meaning = (entry.value['meaning'] as String).toLowerCase();
      
      return key.contains(query) || name.contains(query) || meaning.contains(query);
    }).toList();

    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: filteredRadicals.length,
      itemBuilder: (context, index) {
        final entry = filteredRadicals[index];
        return _RadicalCard(
          radical: entry.key,
          info: entry.value,
          metaData: _hanziMeta,
        );
      },
    );
  }
}

class _RadicalCard extends ConsumerWidget {
  final String radical;
  final Map<String, dynamic> info;
  final Map<String, dynamic> metaData;

  const _RadicalCard({required this.radical, required this.info, required this.metaData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        // 1. Create Sun Node
        final sunNode = CourseNode(uuid: 'rad_$radical', hanzi: radical);
        
        // 2. Find Children (Characters in library that use this radical)
        final allCards = ref.read(flashcardControllerProvider).value ?? [];
        final List<CourseNode> clusterNodes = [];
        
        // Add Sun first
        clusterNodes.add(sunNode);
        
        for (var card in allCards) {
          final meta = metaData[card.hanzi];
          if (meta != null && meta['radical'] == radical && card.hanzi != radical) {
            clusterNodes.add(CourseNode(uuid: card.id, hanzi: card.hanzi, parentUuid: sunNode.uuid));
          }
        }

        // 3. Open Detail Sheet
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => RadicalDetailSheet(
            sunNode: sunNode,
            clusterNodes: clusterNodes,
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.brown.withValues(alpha: 0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(radical, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.redAccent)),
            const SizedBox(height: 8),
            Text(
              info['name'],
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isDark ? Colors.white70 : Colors.black87),
            ),
            Text(
              info['meaning'],
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 10, color: isDark ? Colors.white30 : Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class _DictionaryItem extends StatelessWidget {
  final dynamic card;
  const _DictionaryItem({required this.card});

  @override
  Widget build(BuildContext context) {
    final double masteryProgress = (card.streak / 5.0).clamp(0.0, 1.0);
    final bool isMastered = card.isMastered;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CharacterDetailScreen(card: card)),
      ),
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    (isDark ? Colors.indigo.shade900 : Colors.white).withValues(alpha: isMastered ? 0.4 : 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      card.hanzi,
                      style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white.withValues(alpha: 0.9) : const Color(0xFF2C2C2C), 
                        height: 1.1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: PinyinText(
                      text: card.pinyin,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.indigo.shade200 : Colors.indigo.shade900.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                CrossReferenceText(
                  card.definition,
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? Colors.white54 : Colors.grey.shade700,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // QUICK PRACTICE BUTTON (Hidden for global cards)
                if (!card.id.startsWith('global_'))
                  SizedBox(
                    height: 24,
                    child: TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReviewScreen(card: card)),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        backgroundColor: Colors.indigo.withValues(alpha: 0.1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        "PRACTICE", 
                        style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5)
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Positioned(
            top: 0,
            right: 0,
            child: MasterySeal(
              progress: masteryProgress,
              isMastered: isMastered,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
