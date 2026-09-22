import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/core/providers/translation_language_provider.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';

// Provider to fetch common words for a specific character.
//
// Works for multi-character cards too: for 学习 it surfaces other words
// containing 学, which is what makes the section useful outside single
// characters. Ranking (HSK level first) happens in the repository.
final commonWordsProvider =
    FutureProvider.family<List<Flashcard>, String>((ref, character) async {
  if (character.trim().isEmpty) return [];

  final targetLanguage = ref.watch(translationLanguageProvider);
  final dictionaryRepo = ref.read(globalDictionaryRepositoryProvider);
  final result = await dictionaryRepo.getWordsContaining(character,
      limit: 12, targetLanguage: targetLanguage);

  return result.fold(
    (l) => [],
    (words) => words
        .where((word) => word.hanzi != character && word.hanzi.contains(character))
        .take(6)
        .toList(growable: false),
  );
});

// Provider to fetch Gemini context for a specific character
final characterContextProvider =
    FutureProvider.family<GeminiContext?, Flashcard>((ref, card) async {
  // Establish an explicit dependency so an open detail view refreshes its
  // localized AI content as soon as the app language changes.
  ref.watch(translationLanguageProvider);
  final geminiService = ref.watch(geminiServiceProvider);
  return await geminiService.generateContext(card.hanzi, card.hskLevel);
});

/// Fast single-character lookup for Quick Look sheets.
final quickLookProvider =
    FutureProvider.family<Flashcard?, String>((ref, hanzi) async {
  if (hanzi.trim().isEmpty) return null;

  // Watch local library so it updates automatically when added.
  final libraryCards = ref.watch(flashcardControllerProvider).valueOrNull ?? [];
  final targetLanguage = ref.watch(translationLanguageProvider);
  final isEnglishTarget = targetLanguage.toLowerCase() == 'english';

  Flashcard? localMatch;
  try {
    localMatch = libraryCards.firstWhere((c) => c.hanzi == hanzi);
    // For English users the saved card is always sufficient — skip the DB
    // round-trip. For every other language we must hit the dictionary to
    // obtain a correctly-localized definition; never short-circuit here
    // because the saved card may have a stale English definition even when
    // definitionLanguage/sourceDefinitionHash look complete.
    if (isEnglishTarget &&
        localMatch.dictionaryWordId != null &&
        localMatch.definitionLanguage != null &&
        localMatch.sourceDefinitionHash != null) {
      return localMatch;
    }
  } catch (_) {
    // Not found locally.
  }

  // Consult the global dictionary. For non-English users this is the primary
  // path: the repository returns the definition column for [targetLanguage]
  // and sets definitionLanguage accordingly. We always copy definition +
  // pinyin so TranslatedDefinition sees text that honestly matches the
  // reported definitionLanguage (previously only metadata was copied, causing
  // English text to be tagged as the target language and silently skipping
  // translation).
  final dictionaryRepo = ref.read(globalDictionaryRepositoryProvider);
  final dictionaryCard =
      await dictionaryRepo.getExact(hanzi, targetLanguage: targetLanguage);
  if (localMatch == null || dictionaryCard == null) {
    return dictionaryCard ?? localMatch;
  }

  return localMatch.copyWith(
    pinyin: dictionaryCard.pinyin,
    definition: dictionaryCard.definition,
    definitionLanguage: dictionaryCard.definitionLanguage,
    dictionaryWordId: dictionaryCard.dictionaryWordId,
    englishDefinition: dictionaryCard.englishDefinition,
    localizedDefinitionQuality: dictionaryCard.localizedDefinitionQuality,
    isExpansionEligible: dictionaryCard.isExpansionEligible,
    sourceDefinitionHash: dictionaryCard.sourceDefinitionHash,
  );
});

/// Resolves a specific search result in the active definition language.
/// Dictionary word IDs distinguish entries that share the same Hanzi.
final dictionaryWordProvider =
    FutureProvider.family<Flashcard?, int>((ref, wordId) async {
  final targetLanguage = ref.watch(translationLanguageProvider);
  final dictionaryRepo = ref.read(globalDictionaryRepositoryProvider);
  return dictionaryRepo.getByWordId(
    wordId,
    targetLanguage: targetLanguage,
  );
});
