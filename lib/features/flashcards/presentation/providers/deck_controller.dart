import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/repositories/deck_repository.dart';

final deckControllerProvider = StateNotifierProvider<DeckController, AsyncValue<List<Deck>>>((ref) {
  final repository = ref.watch(deckRepositoryProvider);
  return DeckController(repository);
});

class DeckController extends StateNotifier<AsyncValue<List<Deck>>> {
  final DeckRepository _repository;

  DeckController(this._repository) : super(const AsyncValue.loading()) {
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

  Future<void> deleteDeck(String id) async {
    final result = await _repository.deleteDeck(id);
    result.fold(
      (error) => state = AsyncValue.error(error, StackTrace.current),
      (_) => loadDecks(),
    );
  }
}
