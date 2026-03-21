import 'package:fpdart/fpdart.dart';
import '../entities/flashcard.dart';

// This is the "Contract". It doesn't know about Hive or Databases.
// It just says: "Whoever implements me MUST be able to do these things."
abstract class FlashcardRepository {
  Future<void> init();
  
  // Get all flashcards from storage
  Future<Either<String, List<Flashcard>>> getFlashcards();
  Future<Either<String, List<Flashcard>>> searchAll(String query);

  // Save a single flashcard (or update it)
  Future<Either<String, void>> saveFlashcard(Flashcard card);

    Future<Either<String, void>> deleteFlashcard(String id);
    Future<Either<String, void>> deleteFlashcardsByLevel(int level);
    Future<Either<String, void>> importHsk1();
    Future<Either<String, void>> importHsk2();
    
    // 🚀 PRE-WARMING
    Future<void> preloadDatabases();
  
    Future<Either<String, Flashcard>> fetchAndSaveStrokes(Flashcard card);
  
}