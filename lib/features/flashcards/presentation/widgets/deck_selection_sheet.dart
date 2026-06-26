import 'package:flutter/material.dart';
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
                  itemCount: decks.length,
                  itemBuilder: (context, index) {
                    final deck = decks[index];
                    return ListTile(
                      leading: Icon(deck.id == 'default' ? Icons.library_books : Icons.book, color: Colors.indigo),
                      title: Text(deck.localizedName(context), style: const TextStyle(fontWeight: FontWeight.bold)),
                      onTap: () {
                        final controller = ref.read(flashcardControllerProvider.notifier);
                        final l10n = AppLocalizations.of(context)!;
                        
                        if (isBatch) {
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
                               deckId: deck.id,
                             );
                             controller.addFlashcard(newCard);
                             addedCount++;
                           }
                           ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                               content: Text('Added $addedCount words to ${deck.localizedName(context)}'),
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
                             deckId: deck.id,
                           );
                           controller.addFlashcard(newCard);
                           ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                               content: Text(l10n.addedToDeck(card!.hanzi, deck.localizedName(context))),
                               backgroundColor: Colors.green,
                             ),
                           );
                        }
                        
                        Navigator.pop(context);
                        if (onAdded != null) onAdded!();
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
}
