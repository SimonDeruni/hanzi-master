import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/repositories/deck_repository.dart';
import 'package:hanzi_master/features/flashcards/data/models/deck_model.dart';

class DeckRepositoryImpl implements DeckRepository {
  final Box<DeckModel> _deckBox;
  final Uuid _uuid = const Uuid();

  DeckRepositoryImpl(this._deckBox) {
    _ensureDefaultDeck();
  }

  void _ensureDefaultDeck() {
    if (!_deckBox.containsKey('default')) {
      final defaultDeck = DeckModel(
        id: 'default',
        name: 'The Main Library',
        description: 'Your primary collection of characters.',
        createdAt: DateTime.now(),
      );
      _deckBox.put('default', defaultDeck);
    }
    
    // Seed HSK 1-3 Decks so the Bookshelf looks premium out of the box
    if (!_deckBox.containsKey('hsk1')) {
      _deckBox.put('hsk1', DeckModel(
        id: 'hsk1',
        name: 'HSK 1: Foundation',
        description: 'The first 150 characters to start your journey.',
        createdAt: DateTime.now().add(const Duration(seconds: 1)),
      ));
    }
    if (!_deckBox.containsKey('hsk2')) {
      _deckBox.put('hsk2', DeckModel(
        id: 'hsk2',
        name: 'HSK 2: Elementary',
        description: 'Build your vocabulary to 300 essential words.',
        createdAt: DateTime.now().add(const Duration(seconds: 2)),
      ));
    }
    if (!_deckBox.containsKey('hsk3')) {
      _deckBox.put('hsk3', DeckModel(
        id: 'hsk3',
        name: 'HSK 3: Intermediate',
        description: 'Master conversational fluency with 600 words.',
        createdAt: DateTime.now().add(const Duration(seconds: 3)),
      ));
    }
  }

  @override
  Future<Either<String, List<Deck>>> getDecks() async {
    try {
      final decks = _deckBox.values.map((model) => model.toDomain()).toList();
      // Sort so 'default' is always first, then by creation date
      decks.sort((a, b) {
        if (a.id == 'default') return -1;
        if (b.id == 'default') return 1;
        return a.createdAt.compareTo(b.createdAt);
      });
      return Right(decks);
    } catch (e) {
      return Left('Failed to load decks: $e');
    }
  }

  @override
  Future<Either<String, Deck>> getDeckById(String id) async {
    try {
      final model = _deckBox.get(id);
      if (model != null) {
        return Right(model.toDomain());
      }
      return Left('Deck not found');
    } catch (e) {
      return Left('Failed to load deck: $e');
    }
  }

  @override
  Future<Either<String, Deck>> createDeck(String name, {String description = ''}) async {
    try {
      final id = _uuid.v4();
      final deck = DeckModel(
        id: id,
        name: name,
        description: description,
        createdAt: DateTime.now(),
      );
      await _deckBox.put(id, deck);
      return Right(deck.toDomain());
    } catch (e) {
      return Left('Failed to create deck: $e');
    }
  }

  @override
  Future<Either<String, Deck>> updateDeck(Deck deck) async {
    try {
      if (!_deckBox.containsKey(deck.id)) {
        return Left('Deck not found');
      }
      final model = DeckModel.fromDomain(deck);
      await _deckBox.put(deck.id, model);
      return Right(deck);
    } catch (e) {
      return Left('Failed to update deck: $e');
    }
  }

  @override
  Future<Either<String, void>> deleteDeck(String id) async {
    try {
      if (id == 'default') {
        return Left('Cannot delete the default deck');
      }
      await _deckBox.delete(id);
      return const Right(null);
    } catch (e) {
      return Left('Failed to delete deck: $e');
    }
  }
}
