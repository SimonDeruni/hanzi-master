import 'package:fpdart/fpdart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/repositories/deck_repository.dart';
import 'package:hanzi_master/features/flashcards/data/models/deck_model.dart';

class DeckRepositoryImpl implements DeckRepository {
  final Box<DeckModel> _deckBox;
  final Uuid _uuid = const Uuid();

  Box<DeckModel> get _box =>
      _deckBox.isOpen ? _deckBox : Hive.box<DeckModel>('decks');

  DeckRepositoryImpl(this._deckBox);

  Future<void> _ensureDefaultDeck() async {
    if (!_box.containsKey('default')) {
      final defaultDeck = DeckModel(
        id: 'default',
        name: 'The Main Library',
        description: 'Your primary collection of characters.',
        createdAt: DateTime.now(),
      );
      await _box.put('default', defaultDeck);
    }
  }

  @override
  Future<Either<String, List<Deck>>> getDecks() async {
    try {
      await _ensureDefaultDeck();
      final decks = _box.values.map((model) => model.toDomain()).toList();
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
      if (id == 'default') await _ensureDefaultDeck();
      final model = _box.get(id);
      if (model != null) {
        return Right(model.toDomain());
      }
      return const Left('Deck not found');
    } catch (e) {
      return Left('Failed to load deck: $e');
    }
  }

  @override
  Future<Either<String, Deck>> createDeck(String name,
      {String description = ''}) async {
    try {
      final id = _uuid.v4();
      final deck = DeckModel(
        id: id,
        name: name,
        description: description,
        createdAt: DateTime.now(),
      );
      await _box.put(id, deck);
      return Right(deck.toDomain());
    } catch (e) {
      return Left('Failed to create deck: $e');
    }
  }

  @override
  Future<Either<String, Deck>> updateDeck(Deck deck) async {
    try {
      if (!_box.containsKey(deck.id)) {
        return const Left('Deck not found');
      }
      final model = DeckModel.fromDomain(deck);
      await _box.put(deck.id, model);
      return Right(deck);
    } catch (e) {
      return Left('Failed to update deck: $e');
    }
  }

  @override
  Future<Either<String, void>> deleteDeck(String id) async {
    try {
      if (id == 'default') {
        return const Left('Cannot delete the default deck');
      }
      await _box.delete(id);
      return const Right(null);
    } catch (e) {
      return Left('Failed to delete deck: $e');
    }
  }

  @override
  Future<Either<String, Deck>> ensureHSKDeckExists(int level) async {
    if (level < 1 || level > 6) {
      return Left('Invalid HSK level: $level');
    }
    final id = 'hsk$level';
    final existing = _box.get(id);
    if (existing != null) {
      return Right(existing.toDomain());
    }
    const names = [
      'HSK 1: Foundation',
      'HSK 2: Elementary',
      'HSK 3: Intermediate',
      'HSK 4: Upper Intermediate',
      'HSK 5: Advanced',
      'HSK 6: Mastery',
    ];
    const descs = [
      'The first 150 characters to start your journey.',
      'Build your vocabulary to 300 essential words.',
      'Master conversational fluency with 600 words.',
      'Read texts and converse fluently with 1200 words.',
      'Read newspapers and watch movies with 2500 words.',
      'Express yourself fully with 5000+ words.',
    ];
    final deck = DeckModel(
      id: id,
      name: names[level - 1],
      description: descs[level - 1],
      createdAt: DateTime.now(),
    );
    await _box.put(id, deck);
    return Right(deck.toDomain());
  }
}
