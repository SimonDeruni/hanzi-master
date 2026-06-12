import 'package:fpdart/fpdart.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';

abstract class DeckRepository {
  /// Get all decks
  Future<Either<String, List<Deck>>> getDecks();
  
  /// Get a specific deck by ID
  Future<Either<String, Deck>> getDeckById(String id);
  
  /// Create a new deck
  Future<Either<String, Deck>> createDeck(String name, {String description = ''});
  
  /// Update an existing deck
  Future<Either<String, Deck>> updateDeck(Deck deck);
  
  /// Delete a deck
  Future<Either<String, void>> deleteDeck(String id);
}
