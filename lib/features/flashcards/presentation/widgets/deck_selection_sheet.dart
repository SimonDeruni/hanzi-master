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
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: decks.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return ListTile(
                        leading: const Icon(Icons.add_circle_outline, color: Colors.green),
                        title: const Text("Create New Deck", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
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
                      );
                    }
                    
                    final deck = decks[index - 1];
                    return ListTile(
                      leading: Icon(deck.id == 'default' ? Icons.library_books : Icons.book, color: Colors.indigo),
                      title: Text(deck.localizedName(context), style: const TextStyle(fontWeight: FontWeight.bold)),
                      onTap: () {
                        _addCardsToDeck(context, ref, deck.id, deck.localizedName(context));
                      },
                    );
                  },
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
