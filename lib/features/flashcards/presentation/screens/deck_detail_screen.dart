import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/deck_review_session_screen.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/dictionary_quick_box.dart';
import 'package:hanzi_master/core/services/analytics_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/story_mode_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/study_mode_selection_sheet.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/deck_card_picker_screen.dart';

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final Color backgroundColor;

  _SliverTabBarDelegate(this.tabBar, this.backgroundColor);

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}

class DeckDetailScreen extends ConsumerStatefulWidget {
  final Deck deck;

  const DeckDetailScreen({super.key, required this.deck});

  @override
  ConsumerState<DeckDetailScreen> createState() => _DeckDetailScreenState();
}

class _DeckDetailScreenState extends ConsumerState<DeckDetailScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncFlashcards = ref.watch(flashcardControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
        floatingActionButton: widget.deck.id != 'default' ? FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DeckCardPickerScreen(deckId: widget.deck.id, deckName: widget.deck.name),
              ),
            );
          },
          icon: const Icon(Icons.add),
          label: const Text("Add Cards"),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ) : null,
        body: asyncFlashcards.when(
          data: (allCards) {
            final deckCards = allCards.where((c) => c.deckId == widget.deck.id || (widget.deck.id == 'default' && c.deckId.isEmpty)).toList().reversed.toList();
            
            final filteredCards = deckCards.where((c) {
              if (_searchQuery.isEmpty) return true;
              return c.hanzi.contains(_searchQuery) || 
                     c.pinyin.toLowerCase().contains(_searchQuery) || 
                     c.definition.toLowerCase().contains(_searchQuery);
            }).toList();

            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  // Premium Header
                  SliverAppBar(
                    expandedHeight: 120.0,
                    floating: false,
                    pinned: true,
                    backgroundColor: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      titlePadding: const EdgeInsets.only(bottom: 12),
                      title: Text(
                        widget.deck.name,
                        style: TextStyle(
                          color: isDark ? Colors.white : const Color(0xFF2C2C2C),
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                          letterSpacing: 0.5,
                        ),
                      ),
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Opacity(
                            opacity: isDark ? 0.3 : 0.1,
                            child: const CalligraphyBackground(child: SizedBox.expand()),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 56.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  "${deckCards.length} Cards",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark ? Colors.white70 : Colors.black54,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      if (widget.deck.id != 'default')
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                          onPressed: () {
                            // Delete deck
                          },
                        ),
                    ],
                  ),
                  
                  // Action Row (Compact & Premium)
                  if (deckCards.isNotEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 56,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF4A00E0).withValues(alpha: 0.3),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                      StudyModeSelectionSheet.show(
                                        context,
                                        onModeSelected: (mode) {
                                          ref.read(analyticsServiceProvider).logStudySession(
                                            action: 'started',
                                            mode: mode.name,
                                            deckId: widget.deck.id,
                                            cardCount: deckCards.length,
                                          );
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => DeckReviewSessionScreen(deckId: widget.deck.id, mode: mode),
                                          ));
                                        },
                                      );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.play_arrow_rounded, size: 24, color: Colors.white),
                                      SizedBox(width: 8),
                                      Text("Review", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: 56,
                                child: OutlinedButton(
                                  onPressed: () {
                                    if (deckCards.isEmpty) return;
                                    ref.read(analyticsServiceProvider).logStoryAction(
                                      action: 'started',
                                      storyId: 'custom_deck_story',
                                      storyLevel: widget.deck.id,
                                    );
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => StoryModeScreen(deck: widget.deck, cards: deckCards),
                                    ));
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: isDark ? Colors.purple[300] : Colors.purple[700],
                                    backgroundColor: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.purple.withValues(alpha: 0.05),
                                    side: BorderSide(color: isDark ? Colors.purple[300]!.withValues(alpha: 0.5) : Colors.purple[200]!, width: 1.5),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.auto_awesome, size: 18),
                                      SizedBox(width: 6),
                                      Text("Story", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                  // Tab Bar
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverTabBarDelegate(
                      TabBar(
                        labelColor: isDark ? Colors.purple[300] : Colors.purple[700],
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: isDark ? Colors.purple[300] : Colors.purple[700],
                        indicatorWeight: 3,
                        tabs: const [
                          Tab(text: "Cards"),
                          Tab(text: "Statistics"),
                        ],
                      ),
                      isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  // Tab 1: Cards
                  Column(
                    children: [
                      if (deckCards.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: "Search character, pinyin...",
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: _searchQuery.isNotEmpty 
                                  ? IconButton(
                                      icon: const Icon(Icons.clear), 
                                      onPressed: () {
                                        _searchController.clear();
                                        setState(() => _searchQuery = '');
                                      }
                                    ) 
                                  : null,
                              filled: true,
                              fillColor: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                            onChanged: (val) => setState(() => _searchQuery = val.toLowerCase()),
                          ),
                        ),
                      Expanded(
                        child: deckCards.isEmpty 
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.inbox_outlined, size: 80, color: Colors.grey.withValues(alpha: 0.3)),
                                  const SizedBox(height: 16),
                                  Text(
                                    "This deck is empty.",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: isDark ? Colors.white54 : Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Tap the Add Cards button!",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.purple.withValues(alpha: 0.8),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : filteredCards.isEmpty
                            ? Center(
                                child: Text(
                                  "No cards found.",
                                  style: TextStyle(color: isDark ? Colors.white54 : Colors.black54),
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 80),
                                itemCount: filteredCards.length,
                                itemBuilder: (context, index) {
                                  final card = filteredCards[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12.0),
                                    child: widget.deck.id == 'default' ? _buildCardContent(context, card, isDark) : Dismissible(
                                      key: Key('dismiss_${card.id}'),
                                      direction: DismissDirection.endToStart,
                                      background: Container(
                                        alignment: Alignment.centerRight,
                                        padding: const EdgeInsets.symmetric(horizontal: 24),
                                        decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: const Icon(Icons.delete_sweep, color: Colors.white, size: 32),
                                      ),
                                      confirmDismiss: (direction) async {
                                        return await showDialog<bool>(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text("Remove Card"),
                                            content: Text("Remove ${card.hanzi} from this deck?"),
                                            actions: [
                                              TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
                                              TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Remove")),
                                            ],
                                          ),
                                        );
                                      },
                                      onDismissed: (direction) {
                                        final updatedCard = card.copyWith(deckId: 'default');
                                        ref.read(flashcardControllerProvider.notifier).updateFlashcard(updatedCard);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Removed ${card.hanzi} from deck'),
                                            backgroundColor: Colors.redAccent,
                                            duration: const Duration(seconds: 2),
                                            action: SnackBarAction(
                                              label: 'UNDO',
                                              textColor: Colors.white,
                                              onPressed: () {
                                                ref.read(flashcardControllerProvider.notifier).updateFlashcard(card);
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      child: _buildCardContent(context, card, isDark),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                  
                  // Tab 2: Statistics
                  _buildStatisticsTab(context, deckCards),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }

  Widget _buildStatisticsTab(BuildContext context, List<Flashcard> cards) {
    if (cards.isEmpty) {
      return Center(
        child: Text(
          "Add cards to see statistics.",
          style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white54 : Colors.black54),
        ),
      );
    }
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final modes = StudyMode.values;

    return ListView.builder(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 80),
      itemCount: modes.length,
      itemBuilder: (context, index) {
        final mode = modes[index];
        final due = cards.where((c) => c.isDue(mode)).length;
        final newCount = cards.where((c) => c.isNew(mode)).length;
        final learning = cards.where((c) {
            final s = c.getStatsForMode(mode);
            return !s.isNew && s.interval < 2;
        }).length;
        final mastered = cards.where((c) => c.isMastered(mode)).length;

        // Friendly name mapping
        String modeName = mode.name;
        modeName = modeName[0].toUpperCase() + modeName.substring(1);

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
          elevation: isDark ? 0 : 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: isDark ? Colors.white12 : Colors.black12, width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _getModeIcon(mode), 
                      color: isDark ? Colors.purple[300] : Colors.purple[700],
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      modeName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.purple[300] : Colors.purple[700],
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(context, "New", newCount.toString(), Colors.blue),
                    _buildStatItem(context, "Due", due.toString(), Colors.orange),
                    _buildStatItem(context, "Learning", learning.toString(), Colors.indigo),
                    _buildStatItem(context, "Mastered", mastered.toString(), Colors.green),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _getModeIcon(StudyMode mode) {
    switch (mode) {
      case StudyMode.reading: return Icons.visibility;
      case StudyMode.calligraphy: return Icons.brush;
      case StudyMode.recall: return Icons.memory;
      case StudyMode.listening: return Icons.headset;
      case StudyMode.speaking: return Icons.mic;
    }
  }

  Widget _buildStatItem(BuildContext context, String label, String value, MaterialColor color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isDark ? color.shade300 : color.shade700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white54 : Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildCardContent(BuildContext context, dynamic card, bool isDark) {
    return InkWell(
      onTap: () => showQuickLook(context, card.hanzi),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2C) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isDark ? [] : [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: isDark ? Colors.white12 : Colors.transparent, width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  card.hanzi,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    color: isDark ? Colors.white.withValues(alpha: 0.9) : const Color(0xFF2C2C2C),
                    height: 1.1,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.pinyin,
                    style: TextStyle(
                      fontSize: 15,
                      color: isDark ? Colors.white60 : Colors.black54,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (card.hskLevel == 0 && widget.deck.id == 'default')
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.purple.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.purple.withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.auto_awesome, size: 10, color: Colors.purple.shade400),
                          const SizedBox(width: 4),
                          Text(
                            "AI Generated",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Text(
                    card.definition,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
