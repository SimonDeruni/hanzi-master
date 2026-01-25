import 'package:hanzi_master/core/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/flashcard.dart';
import '../../domain/logic/srs_logic.dart'; // Don't forget to import this!

// This connects the generator part
part 'flashcard_controller.g.dart';

@riverpod
class FlashcardController extends _$FlashcardController {
  
  // 1. INITIALIZE: When the app starts, what happens?
  @override
  Future<List<Flashcard>> build() async {
    // We ask the repository for the cards
    return _loadFlashcards();
  }

  // Helper function to load cards
  Future<List<Flashcard>> _loadFlashcards() async {
    final repository = ref.read(flashcardRepositoryProvider);
    final result = await repository.getFlashcards();
    
    // If success, return the cards. If error, return empty list (for now).
    return result.fold(
      (error) => [], 
      (cards) => cards,
    );
  }

  // 2. ADD: How do we add a new card?
  Future<void> addFlashcard(Flashcard card) async {
    final repository = ref.read(flashcardRepositoryProvider);
    await repository.saveFlashcard(card);
    
    // Refresh the list so the UI updates automatically
    ref.invalidateSelf(); 
  }

  // 3. DELETE: How do we remove a card?
  // 1. DELETE ONE CARD 🗑️
  Future<void> deleteFlashcard(String id) async {
    final repository = ref.read(flashcardRepositoryProvider);
    await repository.deleteFlashcard(id);
    ref.invalidateSelf(); // Refresh the list immediately
  }

  // 2. DELETE EVERYTHING (The Nuclear Option) ☢️
  // 2. DELETE EVERYTHING (The Nuclear Option) ☢️
  Future<void> resetAllData() async {
    final repository = ref.read(flashcardRepositoryProvider);
    final result = await repository.getFlashcards();
    
    // We must "unfold" the result to get the actual list inside
    await result.fold(
      (failure) {
        // If there was an error reading database, do nothing
        return; 
      },
      (allCards) async {
        // If successful, we get 'allCards' (the List)
        for (var card in allCards) {
          await repository.deleteFlashcard(card.id);
        }
      },
    );
    
    ref.invalidateSelf(); // List becomes empty
  }
  Future<void> reviewFlashcard(Flashcard card, int rating) async {
    // 1. Ask the Logic to calculate the new stats
    final updatedCard = SrsLogic.reviewCard(card, rating);
    
    // 2. Save the updated card to the database
    final repository = ref.read(flashcardRepositoryProvider);
    await repository.saveFlashcard(updatedCard);
    
    // 3. Refresh the list
    ref.invalidateSelf();
  }
  // 5. RESET: Wipe everything clean
  Future<void> resetDatabase() async {
    final repository = ref.read(flashcardRepositoryProvider);
    
    // We cheat a bit here: we get all cards, then delete them one by one.
    // (In a real app, you might just clear the box, but this is safer for now)
    final result = await repository.getFlashcards();
    
    result.fold(
      (error) => null, // Do nothing if error
      (cards) async {
        for (var card in cards) {
          await repository.deleteFlashcard(card.id);
        }
      },
    );
    
    ref.invalidateSelf(); // Refresh the UI to show empty state
  }
  // 6. EDIT: Update text without resetting study stats
  Future<void> editFlashcard(Flashcard originalCard, String hanzi, String pinyin, String definition) async {
    final updatedCard = Flashcard(
      id: originalCard.id, // KEEP the old ID
      hanzi: hanzi,
      pinyin: pinyin,
      definition: definition,
      hskLevel: originalCard.hskLevel,
      strokePaths: originalCard.strokePaths,
      
      // KEEP all the old study stats
      nextReviewDate: originalCard.nextReviewDate,
      interval: originalCard.interval,
      easeFactor: originalCard.easeFactor,
      streak: originalCard.streak,
    );

    final repository = ref.read(flashcardRepositoryProvider);
    await repository.saveFlashcard(updatedCard);
    
    // Refresh the UI
    ref.invalidateSelf();
  }
  // 7. IMPORT HSK 1: Load the foundation 🇨🇳
  Future<void> importHsk1() async {
    // 1. Show loading state immediately
    state = const AsyncValue.loading();

    // 2. Call the repository
    final repository = ref.read(flashcardRepositoryProvider);
    final result = await repository.importHsk1();

    // 3. Handle the result
    result.fold(
      (failure) {
        // If it failed, show the error
        state = AsyncValue.error(failure, StackTrace.current);
      },
      (_) {
        // If successful, refresh the list so the new cards appear!
        ref.invalidateSelf();
      },
    );
  }
  // 🖌️ LOAD STROKES (Lazy Loading)
  // 🖌️ UPDATED: Returns the new card so the UI can update!
  Future<Flashcard?> loadStrokesFor(Flashcard card) async {
    // 1. If we already have strokes, just return the card as is.
    if (card.strokePaths.isNotEmpty) return card;

    final repository = ref.read(flashcardRepositoryProvider);
    final result = await repository.fetchAndSaveStrokes(card);

    return result.fold(
      (error) {
        return null;
      },
      (updatedCard) {
        // 2. Refresh the list (for other screens)
        ref.invalidateSelf();
        // 3. Return the new card (for the current screen)
        return updatedCard;
      },
    );
  }

  // UPDATE: Save a modified card (used for performance tracking)
  Future<void> updateFlashcard(Flashcard card) async {
    final repository = ref.read(flashcardRepositoryProvider);
    await repository.saveFlashcard(card);
    ref.invalidateSelf();
  }
}
// ... inside flashcard_controller.dart ...

// Make sure this is OUTSIDE the FlashcardController class
final dueFlashcardsProvider = Provider<List<Flashcard>>((ref) {
  final allCards = ref.watch(flashcardControllerProvider).value ?? [];
  final now = DateTime.now();
  
  // Return only cards where the date is in the past (or today)
  return allCards.where((card) => card.nextReviewDate.isBefore(now)).toList();
});