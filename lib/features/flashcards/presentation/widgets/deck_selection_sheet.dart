import 'package:flutter/material.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/shared/widgets/global_blurred_bottom_sheet.dart';

class DeckSelectionSheet extends ConsumerWidget {
  final Flashcard? card;
  final List<Flashcard>? cards;
  final VoidCallback? onAdded;

  const DeckSelectionSheet({super.key, this.card, this.cards, this.onAdded})
      : assert(card != null || cards != null, 'Must provide either card or cards');

  static Future<void> show(BuildContext context, {Flashcard? card, List<Flashcard>? cards, VoidCallback? onAdded}) {
    return GlobalBlurredBottomSheet.show(
      context,
      child: DeckSelectionSheet(card: card, cards: cards, onAdded: onAdded),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDecks = ref.watch(deckControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isBatch = cards != null && cards!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Choose a Deck",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            isBatch ? "Where would you like to save these ${cards!.length} words?" : "Where would you like to save this character?",
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          asyncDecks.when(
            data: (decks) {
              final allCards = ref.watch(flashcardControllerProvider).value ?? [];
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Create New Deck Action Card
                      InkWell(
                        onTap: () async {
                          final newDeckName = await _showCreateDeckDialog(context);
                          if (newDeckName != null && newDeckName.trim().isNotEmpty) {
                            final deckCtrl = ref.read(deckControllerProvider.notifier);
                            final newDeck = await deckCtrl.createDeck(newDeckName.trim());
                            if (newDeck != null) {
                              _addCardsToDeck(context, ref, newDeck.id, newDeck.localizedName(context));
                            }
                          }
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.add_circle, color: Theme.of(context).colorScheme.primary),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  "Create New Deck",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Grouped Deck List
                      Container(
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white.withValues(alpha: 0.04) : Colors.black.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.1)),
                        ),
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: decks.length,
                          separatorBuilder: (context, index) => Divider(
                            height: 1, 
                            indent: 56, 
                            color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.1)
                          ),
                          itemBuilder: (context, index) {
                            final deck = decks[index];
                            final deckCardCount = allCards.where((c) => c.deckId == deck.id).length;
                            
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              leading: Icon(
                                deck.id == 'default' ? Icons.library_books : Icons.book, 
                                color: Theme.of(context).colorScheme.primary
                              ),
                              title: Text(
                                deck.localizedName(context), 
                                style: const TextStyle(fontWeight: FontWeight.w600)
                              ),
                              subtitle: Text(
                                "$deckCardCount items",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isDark ? Colors.white70 : Colors.black54,
                                ),
                              ),
                              trailing: Icon(
                                Icons.chevron_right, 
                                color: isDark ? Colors.white38 : Colors.black38,
                                size: 20,
                              ),
                              onTap: () {
                                _addCardsToDeck(context, ref, deck.id, deck.localizedName(context));
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Text('Error: $err'),
          ),
        ],
      ),
    );
  }

  Future<String?> _showCreateDeckDialog(BuildContext context) {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("New Deck"),
        content: HanziTextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Deck Name"),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Cancel")),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, controller.text), child: const Text("Create")),
        ],
      ),
    );
  }

  void _addCardsToDeck(BuildContext context, WidgetRef ref, String deckId, String deckName) {
    final controller = ref.read(flashcardControllerProvider.notifier);
    final l10n = AppLocalizations.of(context)!;
    
    if (cards != null && cards!.isNotEmpty) {
       int addedCount = 0;
       for (final c in cards!) {
         final newCard = Flashcard(
           id: DateTime.now().millisecondsSinceEpoch.toString() + addedCount.toString(),
           hanzi: c.hanzi,
           pinyin: c.pinyin,
           definition: c.definition,
           hskLevel: c.hskLevel,
           strokePaths: const [],
           modeStats: const {},
           deckId: deckId,
         );
         controller.addFlashcard(newCard);
         addedCount++;
       }
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content: Text('Added $addedCount words to $deckName'),
           backgroundColor: Colors.green,
         ),
       );
    } else if (card != null) {
       final newCard = Flashcard(
         id: DateTime.now().millisecondsSinceEpoch.toString(),
         hanzi: card!.hanzi,
         pinyin: card!.pinyin,
         definition: card!.definition,
         hskLevel: card!.hskLevel,
         strokePaths: const [],
         modeStats: const {},
         deckId: deckId,
       );
       controller.addFlashcard(newCard);
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content: Text(l10n.addedToDeck(card!.hanzi, deckName)),
           backgroundColor: Colors.green,
         ),
       );
    }
    
    Navigator.pop(context);
    if (onAdded != null) onAdded!();
  }
}
