import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/deck_review_session_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/dictionary_quick_box.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/story_mode_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/study_mode_selection_sheet.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/deck_card_picker_screen.dart';

class DeckDetailScreen extends ConsumerWidget {
  final Deck deck;

  const DeckDetailScreen({super.key, required this.deck});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncFlashcards = ref.watch(flashcardControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
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
          
          // Calculate statistics
          final now = DateTime.now();
          final int dueToday = deckCards.where((c) => c.nextReviewDate.isBefore(now) || c.nextReviewDate.isAtSameMomentAs(now)).length;
          final int learning = deckCards.where((c) => c.streak < 2).length;
          final int mastered = deckCards.where((c) => c.streak >= 5).length;

          
          return CustomScrollView(
            slivers: [
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
              
              // Statistics Banner
              if (deckCards.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatBox(context, "Due Today", dueToday.toString(), Colors.orange),
                        _buildStatBox(context, "Learning", learning.toString(), Colors.blue),
                        _buildStatBox(context, "Mastered", mastered.toString(), Colors.green),
                      ],
                    ),
                  ),
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

              // Empty State
              if (deckCards.isEmpty)
                SliverFillRemaining(
                  child: Center(
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
                          "Tap the Magic Wand to generate cards!",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.purple.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                // Card List
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
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
                      childCount: deckCards.length,
                    ),
                  ),
                ),
                
              const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
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

  Widget _buildStatBox(BuildContext context, String label, String value, MaterialColor color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? color.shade900.withValues(alpha: 0.3) : color.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? color.shade700 : color.shade200),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? color.shade200 : color.shade700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
