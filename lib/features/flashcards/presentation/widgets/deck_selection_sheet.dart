import 'package:flutter/material.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/shared/widgets/global_blurred_bottom_sheet.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:uuid/uuid.dart';

class DeckSelectionSheet extends ConsumerWidget {
  final Flashcard? card;
  final List<Flashcard>? cards;
  final VoidCallback? onAdded;

  const DeckSelectionSheet({super.key, this.card, this.cards, this.onAdded})
      : assert(
            card != null || cards != null, 'Must provide either card or cards');

  static Future<void> show(BuildContext context,
      {Flashcard? card, List<Flashcard>? cards, VoidCallback? onAdded}) {
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
            isBatch
                ? "Where would you like to save these ${cards!.length} words?"
                : "Where would you like to save this character?",
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          asyncDecks.when(
            data: (decks) {
              final allCards =
                  ref.watch(flashcardControllerProvider).value ?? [];
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Create New Deck Action Card
                      BouncingButton(
                        onPressed: () async {
                          final newDeckName =
                              await _showCreateDeckDialog(context);
                          if (newDeckName != null &&
                              newDeckName.trim().isNotEmpty) {
                            final deckCtrl =
                                ref.read(deckControllerProvider.notifier);
                            final newDeck =
                                await deckCtrl.createDeck(newDeckName.trim());
                            if (newDeck != null && context.mounted) {
                              _addCardsToDeck(context, ref, newDeck.id,
                                  newDeck.localizedName(context));
                            }
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withValues(alpha: 0.2)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.add_circle,
                                  color: Theme.of(context).colorScheme.primary),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  "Create New Deck",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.04)
                              : Colors.black.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.1)
                                  : Colors.black.withValues(alpha: 0.1)),
                        ),
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: decks.length,
                          separatorBuilder: (context, index) => Divider(
                              height: 1,
                              indent: 56,
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.1)
                                  : Colors.black.withValues(alpha: 0.1)),
                          itemBuilder: (context, index) {
                            final deck = decks[index];
                            final deckCardCount = allCards
                                .where((c) => c.deckId == deck.id)
                                .length;

                            return BouncingButton(
                              onPressed: () {
                                _addCardsToDeck(context, ref, deck.id,
                                    deck.localizedName(context));
                              },
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                leading: Icon(
                                    deck.id == 'default'
                                        ? Icons.library_books
                                        : Icons.book,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                title: Text(deck.localizedName(context),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600)),
                                subtitle: Text(
                                  "$deckCardCount items",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black54,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color:
                                      isDark ? Colors.white38 : Colors.black38,
                                  size: 20,
                                ),
                              ),
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
            error: (err, stack) => Text("Error: $err"),
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
        title: Text(AppLocalizations.of(context)!.newDeck),
        content: HanziTextField(
          controller: controller,
          decoration:
              InputDecoration(hintText: AppLocalizations.of(context)!.deckName),
          autofocus: true,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(AppLocalizations.of(context)!.cancelAction)),
          ElevatedButton(
              onPressed: () => Navigator.pop(ctx, controller.text),
              child: Text(AppLocalizations.of(context)!.createAction)),
        ],
      ),
    ).whenComplete(() => controller.dispose());
  }

  void _addCardsToDeck(BuildContext context, WidgetRef ref, String deckId,
      String deckName) async {
    final controller = ref.read(flashcardControllerProvider.notifier);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    if (cards != null && cards!.isNotEmpty) {
      // Get existing cards to detect duplicates (for accurate count)
      final existingCards = ref.read(flashcardControllerProvider).value ?? [];
      final existingHanzi = existingCards.map((c) => c.hanzi).toSet();

      int addedCount = 0;
      int skippedCount = 0;
      for (final c in cards!) {
        final newCard = Flashcard(
          id: const Uuid().v4(),
          hanzi: c.hanzi,
          pinyin: c.pinyin,
          definition: c.definition,
          hskLevel: c.hskLevel,
          strokePaths: const [],
          modeStats: const {},
          deckId: deckId,
        );
        if (existingHanzi.contains(c.hanzi)) {
          // Already exists — update its definition/pinyin but keep the existing card
          skippedCount++;
          await controller
              .addFlashcard(newCard); // This will update the existing one
        } else {
          await controller.addFlashcard(newCard);
          addedCount++;
          existingHanzi
              .add(c.hanzi); // Track for subsequent duplicates in same batch
        }
      }

      String message;
      if (skippedCount > 0) {
        message =
            'Added $addedCount new words, updated $skippedCount existing words to $deckName';
      } else {
        message = 'Added $addedCount words to $deckName';
      }
      messenger.showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
        ),
      );
    } else if (card != null) {
      final newCard = Flashcard(
        id: const Uuid().v4(),
        hanzi: card!.hanzi,
        pinyin: card!.pinyin,
        definition: card!.definition,
        hskLevel: card!.hskLevel,
        strokePaths: const [],
        modeStats: const {},
        deckId: deckId,
      );
      await controller.addFlashcard(newCard);
      messenger.showSnackBar(
        SnackBar(
          content: Text("Added ${card!.hanzi} to $deckName"),
          backgroundColor: Colors.green,
        ),
      );
    }

    navigator.pop();
    if (onAdded != null) onAdded!();
  }
}
