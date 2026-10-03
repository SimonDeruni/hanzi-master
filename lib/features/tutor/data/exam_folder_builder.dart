/// Executes a `make` proposal — the one place the tutor changes the app.
///
/// It is deliberately narrow, and every restriction comes from
/// `docs/AI_TUTOR_CONCEPT.md` §11.3:
///
///  * **Only a deck the learner already has.** The proposal names a deck id; the
///    cards are copied from that deck's own cards, so nothing can be invented.
///  * **Nothing is written until the learner commits** — the UI renders a confirm
///    card and calls this only on tap.
///  * **A refusal is a result, not an exception.** A deck with three cards cannot
///    make a ten-item exam, and saying so is the correct behaviour.
library;

import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/repositories/flashcard_repository.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_make_result.dart';
import 'package:hanzi_master/features/tutor/domain/entities/tutor_reply.dart';
import 'package:uuid/uuid.dart';

abstract final class ExamFolderBuilder {
  /// Four is the smallest set a multiple-choice paper can be built from without
  /// repeating a word in the options.
  static const int minimumCards = 4;

  /// Creates the folder. [sourceCards] must be every flashcard the app has; the
  /// pool is then filtered to the deck the proposal named.
  static Future<TutorMakeResult> create({
    required TutorMake make,
    required List<Flashcard> sourceCards,
    required DeckController deckController,
    required FlashcardRepository flashcardRepository,
    required String name,
    required String description,
  }) async {
    final String? deckId = make.deckId;
    if (deckId == null) return const TutorMakeResult.failed();
    final List<Flashcard> pool =
        sourceCards.where((Flashcard card) => card.deckId == deckId).toList();
    if (pool.length < minimumCards) {
      return TutorMakeResult.notEnoughCards(pool.length);
    }

    return createFromCards(
      cards: _sample(pool, make.items),
      name: name,
      description: description,
      deckController: deckController,
      flashcardRepository: flashcardRepository,
    );
  }

  /// Creates a folder holding exactly [cards] — the shared half of every folder a
  /// `make` can produce, whether the cards were sampled from one deck or gathered
  /// because they are due today.
  static Future<TutorMakeResult> createFromCards({
    required List<Flashcard> cards,
    required String name,
    required String description,
    required DeckController deckController,
    required FlashcardRepository flashcardRepository,
  }) async {
    if (cards.isEmpty) return const TutorMakeResult.failed();

    final Deck? deck =
        await deckController.createDeck(name, description: description);
    if (deck == null) return const TutorMakeResult.failed();

    const Uuid uuid = Uuid();
    for (final Flashcard card in cards) {
      // A copy, not a move: the source deck the learner studies is untouched, and
      // every field that makes the card work offline travels with it.
      await flashcardRepository.saveFlashcard(
        Flashcard(
          id: uuid.v4(),
          deckId: deck.id,
          hanzi: card.hanzi,
          pinyin: card.pinyin,
          definition: card.definition,
          definitionLanguage: card.definitionLanguage,
          dictionaryWordId: card.dictionaryWordId,
          englishDefinition: card.englishDefinition,
          localizedDefinitionQuality: card.localizedDefinitionQuality,
          hskLevel: card.hskLevel,
          strokePaths: card.strokePaths,
          medianPaths: card.medianPaths,
          isFlipped: card.isFlipped,
          modeStats: const {},
          sourceSentence: card.sourceSentence,
          sourceContext: card.sourceContext,
        ),
      );
    }

    await deckController.loadDecks();
    return TutorMakeResult.created(deck, cards.length);
  }

  /// A deterministic spread through the deck rather than the first N, so the exam
  /// does not silently become "the beginning of the deck" every time.
  static List<Flashcard> _sample(List<Flashcard> pool, int items) {
    final int count = items.clamp(1, pool.length);
    if (count == pool.length) return List<Flashcard>.from(pool);

    final List<Flashcard> selected = <Flashcard>[];
    final double step = pool.length / count;
    for (int i = 0; i < count; i++) {
      selected.add(pool[(i * step).floor().clamp(0, pool.length - 1)]);
    }
    return selected;
  }
}
