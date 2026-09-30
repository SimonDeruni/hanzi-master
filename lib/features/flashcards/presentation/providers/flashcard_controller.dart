import 'package:flutter/foundation.dart';
import 'package:hanzi_master/core/personal/her_content.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hanzi_master/features/course/data/thematic_decks_data.dart';
import 'package:hanzi_master/features/flashcards/data/models/flashcard_model.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';

part 'flashcard_controller.g.dart';

@riverpod
class FlashcardController extends _$FlashcardController {
  @override
  Future<List<Flashcard>> build() async {
    return _loadFlashcards();
  }

  Future<List<Flashcard>> getCardsForDeck(String deckId) async {
    final allCards = state.valueOrNull ?? await _loadFlashcards();
    return allCards
        .where((c) =>
            c.deckId == deckId || (deckId == 'default' && c.deckId.isEmpty))
        .toList();
  }

  /// One-time initialization logic
  Future<void> init() async {
    // No longer auto-importing HSK 1. Decks must be downloaded manually.
    await _loadFlashcards();
  }

  Future<List<Flashcard>> _loadFlashcards() async {
    final repository = ref.read(flashcardRepositoryProvider);
    final result = await repository.getFlashcards();
    return result.fold((error) => [], (cards) {
      final validCards = <Flashcard>[];
      final badCards = <Flashcard>[];

      final cjkRegex = RegExp(r'[\u4e00-\u9fff\u3400-\u4dbf]');
      for (final c in cards) {
        if (c.hanzi.trim().isEmpty || !cjkRegex.hasMatch(c.hanzi)) {
          badCards.add(c);
        } else {
          validCards.add(c);
        }
      }

      // Asynchronously clean up bad cards (like the stray '?')
      for (final bad in badCards) {
        repository.deleteFlashcard(bad.id);
      }

      return validCards;
    });
  }

  Future<void> addFlashcard(Flashcard card) async {
    final currentCards = state.valueOrNull ?? [];
    final existingIndex = currentCards.indexWhere((c) => c.hanzi == card.hanzi);

    final repository = ref.read(flashcardRepositoryProvider);
    if (existingIndex != -1) {
      final existing = currentCards[existingIndex];
      // It exists. Update it with new fields but keep its ID and progress.
      final updated = existing.copyWith(
        pinyin: card.pinyin,
        definition: card.definition,
        deckId: card.deckId, // keep track of the new deck assignment
      );
      await repository.saveFlashcard(updated);
    } else {
      await repository.saveFlashcard(card);
    }
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

  Future<void> reviewFlashcard(Flashcard card, int rating,
      [StudyMode mode = StudyMode.reading]) async {
    final updatedCard = card.processReview(rating, mode);
    final repository = ref.read(flashcardRepositoryProvider);
    await repository.saveFlashcard(updatedCard);
    ref.invalidateSelf();
  }

  Future<void> editFlashcard(Flashcard originalCard, String hanzi,
      String pinyin, String definition) async {
    final updatedCard = originalCard.copyWith(
      hanzi: hanzi,
      pinyin: pinyin,
      definition: definition,
    );
    final repository = ref.read(flashcardRepositoryProvider);
    await repository.saveFlashcard(updatedCard);
    ref.invalidateSelf();
  }

  Future<Either<String, void>> importHsk1() async {
    state = const AsyncValue.loading();
    final repository = ref.read(flashcardRepositoryProvider);
    final result = await repository.importHsk1();
    return result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        return Left(failure);
      },
      (_) {
        ref.invalidateSelf();
        return const Right(null);
      },
    );
  }

  Future<Either<String, void>> importLevel(int level) async {
    state = const AsyncValue.loading();
    final repository = ref.read(flashcardRepositoryProvider);
    final result = await repository.importLevel(level);
    return result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        return Left(failure);
      },
      (_) {
        ref.invalidateSelf();
        return const Right(null);
      },
    );
  }

  Future<Either<String, void>> uninstallLevel(int level) async {
    state = const AsyncValue.loading();
    final repository = ref.read(flashcardRepositoryProvider);
    final result = await repository.deleteFlashcardsByLevel(level);
    return result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        return Left(failure);
      },
      (_) {
        ref.invalidateSelf();
        return const Right(null);
      },
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
          final newList = currentList
              .map((c) => c.id == updatedCard.id ? updatedCard : c)
              .toList();
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

  /// Import a curated thematic collection (Travel, Business, Culture, Studies).
  Future<Either<String, void>> importThematicDeck(String thematicId) async {
    try {
      final definition = ThematicDecksData.collections.firstWhere(
        (d) => d.id == thematicId,
        orElse: () => throw ArgumentError('Unknown thematic deck: $thematicId'),
      );

      final box = ref.read(hiveBoxProvider);
      final entries = <String, FlashcardModel>{};
      for (int i = 0; i < definition.vocabulary.length; i++) {
        final item = definition.vocabulary[i];
        final id = '${thematicId}_${(i + 1).toString().padLeft(3, '0')}';
        entries[id] = FlashcardModel(
          id: id,
          hanzi: item['hanzi']!,
          pinyin: item['pinyin']!,
          definition: item['definition']!,
          hskLevel: 0,
          nextReviewDate: DateTime.now(),
          interval: 0,
          easeFactor: 2.5,
          streak: 0,
          strokePaths: [],
          deckId: thematicId,
          definitionLanguage: 'English',
        );
      }
      await box.putAll(entries);
      await ref.read(deckRepositoryProvider).ensureThematicDeckExists(
            thematicId,
            name: definition.title,
            description: definition.description,
          );
      ref.invalidateSelf();
      return const Right(null);
    } catch (e) {
      return Left('Failed to import thematic deck: $e');
    }
  }

  /// Her deck: the "Love" deck and its six cards, seeded the first time her library
  /// opens and left alone after that.
  ///
  /// Idempotent on purpose, because it runs on every open: `ensureThematicDeckExists`
  /// keeps a deck that is already there, and a card is only written when its id is
  /// missing — so opening the library again can never duplicate a card, and can never
  /// reset the review progress she has already earned on one.
  Future<void> ensureLoveDeck() async {
    try {
      final box = ref.read(hiveBoxProvider);
      final entries = <String, FlashcardModel>{};
      for (int i = 0; i < HerContent.deckVocabulary.length; i++) {
        final item = HerContent.deckVocabulary[i];
        final id =
            '${HerContent.deckId}_${(i + 1).toString().padLeft(3, '0')}';
        if (box.containsKey(id)) continue;
        entries[id] = FlashcardModel(
          id: id,
          hanzi: item['hanzi']!,
          pinyin: item['pinyin']!,
          definition: item['definition']!,
          hskLevel: 0,
          nextReviewDate: DateTime.now(),
          interval: 0,
          easeFactor: 2.5,
          streak: 0,
          strokePaths: [],
          deckId: HerContent.deckId,
          definitionLanguage: 'English',
        );
      }
      if (entries.isNotEmpty) await box.putAll(entries);
      await ref.read(deckRepositoryProvider).ensureThematicDeckExists(
            HerContent.deckId,
            name: HerContent.deckName,
            description: HerContent.deckDescription,
          );
      if (entries.isNotEmpty) ref.invalidateSelf();
    } catch (e) {
      // A deck that failed to seed must not take the library down with it: the shelf
      // below still renders, and the next open tries again.
      debugPrint('Warning: the Love deck could not be seeded: $e');
    }
  }

  /// Uninstall a thematic collection and remove its cards.
  Future<Either<String, void>> uninstallThematicDeck(String thematicId) async {
    try {
      final box = ref.read(hiveBoxProvider);
      final keysToDelete = <dynamic>[];
      for (final card in box.values) {
        if (card.deckId == thematicId) {
          keysToDelete.add(card.id);
        }
      }
      await box.deleteAll(keysToDelete);
      await ref.read(deckRepositoryProvider).deleteDeck(thematicId);
      ref.invalidateSelf();
      return const Right(null);
    } catch (e) {
      return Left('Failed to uninstall thematic deck: $e');
    }
  }

  /// Pre-seeds relevant decks based on the learner's onboarding survey choices.
  Future<void> preseedOnboardingDecks({
    required int masteryLevel,
    required int drive,
  }) async {
    try {
      // 1. Install corresponding HSK tier
      final hskTier = masteryLevel == 0 ? 1 : (masteryLevel == 1 ? 2 : (masteryLevel == 2 ? 3 : 5));
      await importLevel(hskTier);
      await ref.read(deckRepositoryProvider).ensureHSKDeckExists(hskTier);

      // 2. Install goal/drive thematic deck
      String? thematicId;
      if (drive == 0) thematicId = 'thematic_business';
      if (drive == 1) thematicId = 'thematic_travel';
      if (drive == 3) thematicId = 'thematic_culture';

      if (thematicId != null) {
        await importThematicDeck(thematicId);
      }
    } catch (e) {
      debugPrint('Warning: Deck pre-seeding failed: $e');
    }
  }
}

final dueFlashcardsProvider = Provider<List<Flashcard>>((ref) {
  final allCards = ref.watch(flashcardControllerProvider).value ?? [];
  return allCards.where((card) => card.isDue(StudyMode.reading)).toList();
});

final dueFlashcardsCountProvider = Provider<int>((ref) {
  return ref.watch(dueFlashcardsProvider).length;
});
