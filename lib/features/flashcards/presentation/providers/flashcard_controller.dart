import 'package:hanzi_master/core/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/logic/srs_logic.dart';

part 'flashcard_controller.g.dart';

@riverpod
class FlashcardController extends _$FlashcardController {
  @override
  Future<List<Flashcard>> build() async {
    return _loadFlashcards();
  }

  /// One-time initialization logic (Auto-import HSK1)
  Future<void> init() async {
    final cards = await _loadFlashcards();
    if (cards.isEmpty) {
      await importHsk1();
    }
  }

  Future<List<Flashcard>> _loadFlashcards() async {
    final repository = ref.read(flashcardRepositoryProvider);
    final result = await repository.getFlashcards();
    return result.fold((error) => [], (cards) => cards);
  }

  Future<void> addFlashcard(Flashcard card) async {
    final repository = ref.read(flashcardRepositoryProvider);
    await repository.saveFlashcard(card);
    ref.invalidateSelf(); 
  }

  Future<void> deleteFlashcard(String id) async {
    final repository = ref.read(flashcardRepositoryProvider);
    await repository.deleteFlashcard(id);
    ref.invalidateSelf();
  }

  Future<void> resetAllData() async {
    final repository = ref.read(flashcardRepositoryProvider);
    final result = await repository.getFlashcards();
    await result.fold(
      (failure) => null,
      (allCards) async {
        for (var card in allCards) {
          await repository.deleteFlashcard(card.id);
        }
      },
    );
    ref.invalidateSelf();
  }

  Future<void> reviewFlashcard(Flashcard card, int rating) async {
    final updatedCard = SrsLogic.reviewCard(card, rating);
    final repository = ref.read(flashcardRepositoryProvider);
    await repository.saveFlashcard(updatedCard);
    ref.invalidateSelf();
  }

  Future<void> editFlashcard(Flashcard originalCard, String hanzi, String pinyin, String definition) async {
    final updatedCard = originalCard.copyWith(
      hanzi: hanzi,
      pinyin: pinyin,
      definition: definition,
    );
    final repository = ref.read(flashcardRepositoryProvider);
    await repository.saveFlashcard(updatedCard);
    ref.invalidateSelf();
  }

  Future<void> importHsk1() async {
    state = const AsyncValue.loading();
    final repository = ref.read(flashcardRepositoryProvider);
    final result = await repository.importHsk1();
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => ref.invalidateSelf(),
    );
  }

  Future<void> importLevel(int level) async {
    state = const AsyncValue.loading();
    final repository = ref.read(flashcardRepositoryProvider);
    final result = await repository.importLevel(level);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => ref.invalidateSelf(),
    );
  }

  Future<void> uninstallLevel(int level) async {
    state = const AsyncValue.loading();
    final repository = ref.read(flashcardRepositoryProvider);
    final result = await repository.deleteFlashcardsByLevel(level);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => ref.invalidateSelf(),
    );
  }

  Future<Flashcard?> loadStrokesFor(Flashcard card) async {
    if (card.strokePaths.isNotEmpty) return card;
    final repository = ref.read(flashcardRepositoryProvider);
    final result = await repository.fetchAndSaveStrokes(card);
    return result.fold(
      (error) => null,
      (updatedCard) {
        // Manually update the card in the list to avoid full reload
        final currentList = state.valueOrNull ?? [];
        if (currentList.isNotEmpty) {
          final newList = currentList.map((c) => c.id == updatedCard.id ? updatedCard : c).toList();
          state = AsyncValue.data(newList);
        } else {
          // If list was empty (unlikely if we clicked a card), fallback to reload
          ref.invalidateSelf();
        }
        return updatedCard;
      },
    );
  }

  Future<void> updateFlashcard(Flashcard card) async {
    final repository = ref.read(flashcardRepositoryProvider);
    await repository.saveFlashcard(card);
    ref.invalidateSelf();
  }

  Future<void> clearAllStrokes() async {
    final repository = ref.read(flashcardRepositoryProvider);
    final result = await repository.getFlashcards();
    
    await result.fold(
      (failure) => null,
      (cards) async {
        for (final card in cards) {
          final updatedCard = card.copyWith(strokePaths: [], medianPaths: []);
          await repository.saveFlashcard(updatedCard);
        }
      },
    );
    
    ref.invalidateSelf();
  }
}

final dueFlashcardsProvider = Provider<List<Flashcard>>((ref) {
  final allCards = ref.watch(flashcardControllerProvider).value ?? [];
  final now = DateTime.now();
  return allCards.where((card) => card.nextReviewDate.isBefore(now)).toList();
});