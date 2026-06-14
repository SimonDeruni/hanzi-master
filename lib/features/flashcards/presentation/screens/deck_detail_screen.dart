import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/deck_review_session_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/dictionary_quick_box.dart';
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

class DeckDetailScreen extends ConsumerWidget {
  final Deck deck;

  const DeckDetailScreen({super.key, required this.deck});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncFlashcards = ref.watch(flashcardControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
        floatingActionButton: deck.id != 'default' ? FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DeckCardPickerScreen(deckId: deck.id, deckName: deck.name),
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
            final deckCards = allCards.where((c) => c.deckId == deck.id || (deck.id == 'default' && c.deckId.isEmpty)).toList().reversed.toList();
            
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  // Hero Header
                  SliverAppBar(
                    expandedHeight: 200.0,
                    floating: false,
                    pinned: true,
                    backgroundColor: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(
                        deck.name,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          const CalligraphyBackground(child: SizedBox.expand()),
                          Container(
                            color: (isDark ? Colors.black : Colors.white).withValues(alpha: 0.6),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  "${deckCards.length} Cards",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: isDark ? Colors.white70 : Colors.black54,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      if (deck.id != 'default')
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                          onPressed: () {
                            // Delete deck
                          },
                        ),
                    ],
                  ),
                  
                  // Action Row
                  if (deckCards.isNotEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () {
                                  StudyModeSelectionSheet.show(
                                    context,
                                    onModeSelected: (mode) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DeckReviewSessionScreen(
                                            deckId: deck.id,
                                            mode: mode,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.play_arrow_rounded, size: 28),
                                    SizedBox(width: 8),
                                    Text(
                                      "Start Review",
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: OutlinedButton(
                                onPressed: () {
                                  if (deckCards.isEmpty) return;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StoryModeScreen(deck: deck, cards: deckCards),
                                    ),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: isDark ? Colors.purple[300] : Colors.purple[700],
                                  side: BorderSide(color: isDark ? Colors.purple[300]! : Colors.purple[700]!, width: 2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.menu_book, size: 24),
                                    SizedBox(width: 8),
                                    Text(
                                      "Read Story (AI)",
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ],
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
                  deckCards.isEmpty 
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
                    : ListView.builder(
                        padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 80),
                        itemCount: deckCards.length,
                        itemBuilder: (context, index) {
                          final card = deckCards[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: deck.id == 'default' ? _buildCardContent(context, card, isDark) : Dismissible(
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
      onTap: () => DictionaryQuickBox.show(context, card: card, isInLibrary: true),
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.pinyin,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? Colors.white70 : Colors.black54,
                      letterSpacing: 1.2,
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
