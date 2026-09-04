import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/core/providers/translation_language_provider.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';

// Provider to fetch common words for a specific character
final commonWordsProvider =
    FutureProvider.family<List<Flashcard>, String>((ref, character) async {
  if (character.isEmpty) return [];

  final targetLanguage = ref.watch(translationLanguageProvider);
  final dictionaryRepo = ref.read(globalDictionaryRepositoryProvider);
  final result = await dictionaryRepo.getWordsContaining(character,
      limit: 6, targetLanguage: targetLanguage);

  return result.fold(
    (l) => [],
    (r) => r,
  );
});

// Provider to fetch Gemini context for a specific character
final characterContextProvider =
    FutureProvider.family<GeminiContext?, Flashcard>((ref, card) async {
  final geminiService = ref.read(geminiServiceProvider);
  return await geminiService.generateContext(card.hanzi, card.hskLevel);
});

/// Fast single-character lookup for Quick Look sheets.
final quickLookProvider =
    FutureProvider.family<Flashcard?, String>((ref, hanzi) async {
  if (hanzi.trim().isEmpty) return null;

  // Watch local library so it updates automatically when added
  final libraryCards = ref.watch(flashcardControllerProvider).valueOrNull ?? [];
  Flashcard? localMatch;
  try {
    localMatch = libraryCards.firstWhere((c) => c.hanzi == hanzi);
    if (localMatch.dictionaryWordId != null &&
        localMatch.definitionLanguage != null &&
        localMatch.sourceDefinitionHash != null) {
      return localMatch;
    }
  } catch (_) {
    // Not found locally
  }

  // Fall back to the global dictionary. Legacy saved cards did not persist
  // dictionary provenance, so enrich them without replacing study progress or
  // the user's saved definition.
  final targetLanguage = ref.watch(translationLanguageProvider);
  final dictionaryRepo = ref.read(globalDictionaryRepositoryProvider);
  final dictionaryCard =
      await dictionaryRepo.getExact(hanzi, targetLanguage: targetLanguage);
  if (localMatch == null || dictionaryCard == null) {
    return dictionaryCard ?? localMatch;
  }

  return localMatch.copyWith(
    definitionLanguage: dictionaryCard.definitionLanguage,
    dictionaryWordId: dictionaryCard.dictionaryWordId,
    englishDefinition: dictionaryCard.englishDefinition,
    localizedDefinitionQuality: dictionaryCard.localizedDefinitionQuality,
    isExpansionEligible: dictionaryCard.isExpansionEligible,
    sourceDefinitionHash: dictionaryCard.sourceDefinitionHash,
  );
});
