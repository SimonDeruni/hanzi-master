import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/stats_screen.dart';
import 'package:hanzi_master/features/course/domain/entities/course_unit.dart';
import 'package:hanzi_master/features/course/presentation/widgets/radical_detail_sheet.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/dictionary_provider.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/deck_detail_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/ai_deck_generator_sheet.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/settings_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/flashcard_form_screen.dart';
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
import 'package:hanzi_master/features/flashcards/presentation/widgets/dictionary_quick_box.dart';

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

    // Set the extracted text as the search query to show results in the dictionary
    setState(() {
      _searchQuery = extractedText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CalligraphyBackground(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
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
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: Text(
                  "Dictionary",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SearchBarDelegate(
                isDark: isDark,
                searchQuery: _searchQuery,
                onChanged: (value) => setState(() => _searchQuery = value),
                onMagicLens: _runMagicLens,
              ),
            ),
          ],
          body: _DictionarySearchTab(
            searchQuery: _searchQuery,
            onMagicLens: _runMagicLens,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'dictionary_add_fab',
        backgroundColor: Colors.purple,
        icon: const Icon(Icons.auto_awesome, color: Colors.white),
        label: const Text("Generate", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        onPressed: () => AiDeckGeneratorSheet.show(context),
      ),
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final bool isDark;
  final String searchQuery;
  final ValueChanged<String> onChanged;
  final VoidCallback onMagicLens;

  _SearchBarDelegate({
    required this.isDark,
    required this.searchQuery,
    required this.onChanged,
    required this.onMagicLens,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: (isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0)).withValues(alpha: 0.8),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: isDark ? Colors.white12 : Colors.black12, width: 1),
            ),
            child: TextField(
              style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 18),
              decoration: InputDecoration(
                hintText: "Search Pinyin, Hanzi, or English...",
                hintStyle: TextStyle(color: isDark ? Colors.white30 : Colors.black38),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.document_scanner, color: Colors.redAccent),
                  tooltip: "Magic Lens",
                  onPressed: onMagicLens,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 80.0;

  @override
  double get minExtent => 80.0;

  @override
  bool shouldRebuild(covariant _SearchBarDelegate oldDelegate) {
    return oldDelegate.isDark != isDark ||
           oldDelegate.searchQuery != searchQuery ||
           oldDelegate.onChanged != onChanged ||
           oldDelegate.onMagicLens != onMagicLens;
  }
}

class _DictionarySearchTab extends ConsumerWidget {
  final String searchQuery;
  final VoidCallback onMagicLens;
  
  const _DictionarySearchTab({
    required this.searchQuery,
    required this.onMagicLens,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncFlashcards = ref.watch(flashcardControllerProvider);
    final asyncDecks = ref.watch(deckControllerProvider);
    final masterResults = ref.watch(masterSearchProvider(searchQuery)).valueOrNull ?? [];

    return asyncFlashcards.when(
      data: (flashcards) {
        final libraryMap = { for (var card in flashcards) card.hanzi : card };
        
        // 1. Map master results, replacing with library versions if they exist to keep streak data
        final List<Flashcard> unifiedResults = masterResults.map((masterCard) {
          return libraryMap[masterCard.hanzi] ?? masterCard;
        }).toList();

        // 2. Find local-only cards that match the query but weren't in masterResults (e.g. custom user cards)
        final unifiedHanziSet = unifiedResults.map((c) => c.hanzi).toSet();
        final localOnlyMatches = flashcards.where((card) {
          if (unifiedHanziSet.contains(card.hanzi)) return false;
          final query = searchQuery.toLowerCase();
          return card.hanzi.contains(query) ||
                 card.pinyin.toLowerCase().contains(query) ||
                 card.definition.toLowerCase().contains(query);
        }).toList();

        unifiedResults.addAll(localOnlyMatches);

        if (searchQuery.isEmpty) {
          return asyncDecks.when(
            data: (decks) => _buildDecksGrid(context, decks, flashcards),
            loading: () => const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
            error: (e, s) => SliverFillRemaining(child: Center(child: Text("Error loading decks: $e"))),
          );
        }

        if (unifiedResults.isEmpty) {
          return Center(child: Text("No results found for '$searchQuery'", style: const TextStyle(color: Colors.grey)));
        }

        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final card = unifiedResults[index];
                    final isInLibrary = libraryMap.containsKey(card.hanzi);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: _DictionaryItem(card: card, isInLibrary: isInLibrary),
                    );
                  },
                  childCount: unifiedResults.length,
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text("Error: $err")),
    );
  }

  Widget _buildDecksGrid(BuildContext context, List<Deck> decks, List<Flashcard> allCards) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final deck = decks[index];
            final deckCardsCount = allCards.where((c) => c.deckId == deck.id || (deck.id == 'default' && c.deckId == null)).length;
            
            return InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeckDetailScreen(deck: deck)),
              ),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2A2A2B) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: (deck.id == 'default' ? Colors.indigo : Colors.orangeAccent).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        deck.id == 'default' ? Icons.library_books : Icons.folder,
                        color: deck.id == 'default' ? Colors.indigo : Colors.orangeAccent,
                        size: 28,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      deck.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "$deckCardsCount cards",
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.white54 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          childCount: decks.length,
        ),
      ),
    );
  }

  Widget _buildZenEmptyState(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    "字",
                    style: TextStyle(
                      fontSize: 180,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.indigo.withValues(alpha: 0.04),
                      height: 1,
                    ),
                  ),
                  Icon(Icons.menu_book_rounded, size: 48, color: isDark ? Colors.white24 : Colors.black26),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                "Your Library is waiting.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white54 : Colors.black54,
                ),
              ),
              const SizedBox(height: 40),
              
              // Functional Actions
              Row(
                children: [
                  Expanded(
                    child: _buildActionCard(
                      context,
                      icon: Icons.document_scanner,
                      title: "Scan Text",
                      subtitle: "Use camera",
                      color: Colors.redAccent,
                      onTap: onMagicLens,
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildActionCard(
                      context,
                      icon: Icons.add,
                      title: "Create Card",
                      subtitle: "Manual entry",
                      color: Colors.indigo,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FlashcardFormScreen()),
                      ),
                      isDark: isDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80), // Padding for the FAB
            ],
          ),
        ),
      ),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white54 : Colors.black54,
              ),
            ),
          ],
        ),
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
  final bool isInLibrary;
  const _DictionaryItem({required this.card, this.isInLibrary = false});

  @override
  Widget build(BuildContext context) {
    // If it's not in the library, it has no real mastery progress yet.
    final double masteryProgress = isInLibrary ? (card.streak / 5.0).clamp(0.0, 1.0) : 0.0;
    final bool isMastered = isInLibrary ? card.isMastered : false;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        DictionaryQuickBox.show(context, card: card, isInLibrary: isInLibrary);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.white.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDark ? Colors.white12 : Colors.black12, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left: Hanzi
            SizedBox(
              width: 80,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  card.hanzi,
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white.withValues(alpha: 0.9) : const Color(0xFF2C2C2C),
                    height: 1.1,
                  ),
                ),
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Middle: Pinyin & Definition
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PinyinText(
                    text: card.pinyin,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? Colors.indigo.shade200 : Colors.indigo.shade900.withValues(alpha: 0.8),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  CrossReferenceText(
                    card.definition,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white70 : Colors.black87,
                      fontStyle: FontStyle.italic,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            // Right: Mastery Seal
            if (isInLibrary) ...[
              const SizedBox(width: 12),
              MasterySeal(
                progress: masteryProgress,
                isMastered: isMastered,
                size: 36,
              ),
            ] else ...[
              // Placeholder for alignment if needed, or just blank
              const SizedBox(width: 48), 
            ],
          ],
        ),
      ),
    );
  }
}
