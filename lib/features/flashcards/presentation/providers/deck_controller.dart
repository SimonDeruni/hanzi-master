import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/repositories/deck_repository.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';

final deckControllerProvider = StateNotifierProvider<DeckController, AsyncValue<List<Deck>>>((ref) {
  final repository = ref.watch(deckRepositoryProvider);
  return DeckController(repository, ref);
});

class DeckController extends StateNotifier<AsyncValue<List<Deck>>> {
  final DeckRepository _repository;
  final Ref _ref;

  DeckController(this._repository, this._ref) : super(const AsyncValue.loading()) {
    loadDecks();
  }

  Future<void> loadDecks() async {
    state = const AsyncValue.loading();
    final result = await _repository.getDecks();
    result.fold(
      (error) => state = AsyncValue.error(error, StackTrace.current),
      (decks) => state = AsyncValue.data(decks),
    );
  }

  Future<Deck?> createDeck(String name, {String description = ''}) async {
    final result = await _repository.createDeck(name, description: description);
    return result.fold(
      (error) {
        state = AsyncValue.error(error, StackTrace.current);
        return null;
      },
      (deck) {
        loadDecks(); // Reload to get updated list
        return deck;
      },
    );
  }

  Future<Deck?> updateDeck(Deck deck) async {
    final result = await _repository.updateDeck(deck);
    return result.fold(
      (error) {
        state = AsyncValue.error(error, StackTrace.current);
        return null;
      },
      (updatedDeck) {
        loadDecks();
        return updatedDeck;
      },
    );
  }

  Future<void> deleteDeck(String id) async {
    // 1. Delete associated flashcards first (cascading cleanup)
    try {
      final flashcardController = _ref.read(flashcardControllerProvider.notifier);
      final allCards = _ref.read(flashcardControllerProvider).valueOrNull ?? [];
      final deckCards = allCards.where((c) => c.deckId == id).toList();
      for (final card in deckCards) {
        await flashcardController.deleteFlashcard(card.id);
      }
    } catch (e) {
      debugPrint("Warning cascading flashcard deletion for deck $id: $e");
    }

    // 2. Delete the deck entry itself
    final result = await _repository.deleteDeck(id);
    result.fold(
      (error) => state = AsyncValue.error(error, StackTrace.current),
      (_) => loadDecks(),
    );
  }
}
