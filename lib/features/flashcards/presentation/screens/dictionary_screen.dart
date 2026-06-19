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
import 'package:hanzi_master/core/utils/pinyin_utils.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/streak_seal.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/mastery_seal.dart';
import 'package:hanzi_master/features/premium/presentation/screens/paywall_sheet.dart';
import 'package:hanzi_master/features/premium/presentation/screens/universal_scanner_screen.dart';
import 'package:hanzi_master/core/providers/premium_controller.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/shared/widgets/clickable_chinese_text.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/dictionary_quick_box.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/radical_library_screen.dart';
import 'package:hanzi_master/shared/widgets/global_sliver_app_bar.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';

class DictionaryScreen extends ConsumerStatefulWidget {
  const DictionaryScreen({super.key});

  @override
  ConsumerState<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends ConsumerState<DictionaryScreen> {
  String _searchQuery = "";
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(searchFocusRequestProvider, (previous, next) {
      if (next == true) {
        Future.delayed(const Duration(milliseconds: 50), () {
          if (mounted) {
            _searchFocusNode.requestFocus();
            ref.read(searchFocusRequestProvider.notifier).state = false;
          }
        });
      }
    });

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: CalligraphyBackground(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            GlobalSliverAppBar(title: l10n?.scholarsLibrary ?? "The Scholar's Library"),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SearchBarDelegate(
                isDark: isDark,
                searchQuery: _searchQuery,
                focusNode: _searchFocusNode,
                onChanged: (value) => setState(() => _searchQuery = value),
              ),
            ),
          ],
          body: _DictionarySearchTab(
            searchQuery: _searchQuery,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'dictionary_add_fab',
        backgroundColor: Colors.purple,
        icon: const Icon(Icons.auto_awesome, color: Colors.white),
        label: Text(l10n?.generate ?? "Generate", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        onPressed: () => AiDeckGeneratorSheet.show(context),
      ),
    );
  }
}

class _LexiconMiniCard extends StatelessWidget {
  final Flashcard card;

  const _LexiconMiniCard({required this.card});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        DictionaryQuickBox.show(context, card: card, isInLibrary: true);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                card.hanzi,
                style: theme.textTheme.displaySmall?.copyWith(height: 1.1),
              ),
            ),
            const SizedBox(height: 8),
            PinyinText(
              text: card.pinyin,
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              card.definition,
              style: theme.textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _BookshelfVerticalCard extends StatelessWidget {
  final Deck deck;
  final int cardCount;

  const _BookshelfVerticalCard({
    required this.deck,
    required this.cardCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDefault = deck.id == 'default';
    final Color deckColor = isDefault ? theme.colorScheme.primary : theme.colorScheme.secondary;
    
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DeckDetailScreen(deck: deck)),
      ),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.colorScheme.onSurface.withValues(alpha: 0.1)),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: deckColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isDefault ? Icons.library_books : Icons.folder,
                color: deckColor,
                size: 28,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deck.name,
                    style: theme.textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$cardCount cards",
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 16, color: theme.colorScheme.onSurface.withValues(alpha: 0.4)),
          ],
        ),
      ),
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final bool isDark;
  final String searchQuery;
  final ValueChanged<String> onChanged;
  final FocusNode focusNode;

  _SearchBarDelegate({
    required this.isDark,
    required this.searchQuery,
    required this.onChanged,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                focusNode: focusNode,
                style: theme.textTheme.bodyLarge,
                decoration: InputDecoration(
                  hintText: l10n?.searchPinyinHanziEnglish ?? "Search Pinyin, Hanzi, or English...",
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.4)),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onChanged: onChanged,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.camera_alt),
              color: theme.colorScheme.onPrimary,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const UniversalScannerScreen()));
              },
            ),
          ),
        ],
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
           oldDelegate.onChanged != onChanged;
  }
}

class _DictionarySearchTab extends ConsumerWidget {
  final String searchQuery;
  
  const _DictionarySearchTab({
    required this.searchQuery,
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
          final cleanPinyin = PinyinUtils.removeToneMarks(card.pinyin).toLowerCase();
          return card.hanzi.contains(query) ||
                 cleanPinyin.contains(query) ||
                 card.pinyin.toLowerCase().contains(query) ||
                 card.definition.toLowerCase().contains(query);
        }).toList();

        unifiedResults.addAll(localOnlyMatches);

        if (searchQuery.isEmpty) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          "Latest Discoveries",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 140,
                        child: flashcards.isEmpty 
                          ? const Center(child: Text("No characters in lexicon yet."))
                          : ListView.separated(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              scrollDirection: Axis.horizontal,
                              itemCount: flashcards.length > 10 ? 10 : flashcards.length,
                              separatorBuilder: (context, index) => const SizedBox(width: 16),
                              itemBuilder: (context, index) {
                                // latest first -> flashcards are usually appended, so reversed
                                final card = flashcards[flashcards.length - 1 - index];
                                return _LexiconMiniCard(card: card);
                              },
                            ),
                      ),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const RadicalLibraryScreen()));
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF1A1A1B), Color(0xFF3A3A3C)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF1A1A1B).withValues(alpha: 0.2),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text('氵', style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(width: 16),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Radicals Index', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                      SizedBox(height: 4),
                                      Text('Master the building blocks of Hanzi', style: TextStyle(color: Colors.white70, fontSize: 13)),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          "Your Bookshelf",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              asyncDecks.when(
                data: (decks) => SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final deck = decks[index];
                        final deckCardsCount = flashcards.where((c) => c.deckId == deck.id).length;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _BookshelfVerticalCard(deck: deck, cardCount: deckCardsCount),
                        );
                      },
                      childCount: decks.length,
                    ),
                  ),
                ),
                loading: () => const SliverFillRemaining(child: Center(child: CircularProgressIndicator())),
                error: (e, s) => SliverFillRemaining(child: Center(child: Text("Error: $e"))),
              ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
            ],
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
            final deckCardsCount = allCards.where((c) => c.deckId == deck.id).length;
            
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Center(
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
                Icon(Icons.search_rounded, size: 48, color: isDark ? Colors.white24 : Colors.black26),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              "Search your dictionary...",
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: 80), // Padding for the FABs
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
    final double masteryProgress = isInLibrary ? (card.getStatsForMode(StudyMode.reading).streak / 5.0).clamp(0.0, 1.0) : 0.0;
    final bool isMastered = isInLibrary ? card.isMastered(StudyMode.reading) : false;
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
                      color: isDark ? Colors.indigo.shade300 : Colors.indigo.shade700,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (card.hskLevel == 0)
                    Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.purple.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.purple.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.auto_awesome, size: 10, color: Colors.purple.shade400),
                          const SizedBox(width: 4),
                          Text(
                            "AI Generated",
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ClickableChineseText(
                    card.definition,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white : Colors.black,
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
