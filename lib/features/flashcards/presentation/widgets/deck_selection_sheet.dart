import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';

class DeckSelectionSheet extends ConsumerWidget {
  final Flashcard card;
  final VoidCallback? onAdded;

  const DeckSelectionSheet({super.key, required this.card, this.onAdded});

  static Future<void> show(BuildContext context, {required Flashcard card, VoidCallback? onAdded}) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => DeckSelectionSheet(card: card, onAdded: onAdded),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDecks = ref.watch(deckControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Choose a Deck",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Where would you like to save this character?",
            style: TextStyle(fontSize: 16, color: Colors.grey),
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
                      title: Text(deck.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      onTap: () {
                        final newCard = Flashcard(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          hanzi: card.hanzi,
                          pinyin: card.pinyin,
                          definition: card.definition,
                          hskLevel: card.hskLevel,
                          strokePaths: const [],
                          modeStats: const {},
                          deckId: deck.id,
                        );
                        ref.read(flashcardControllerProvider.notifier).addFlashcard(newCard);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added to ${deck.name}!'),
                            backgroundColor: Colors.green,
                          ),
                        );
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
