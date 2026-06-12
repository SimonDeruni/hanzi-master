import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';

// Provider to fetch common words for a specific character
final commonWordsProvider = FutureProvider.family<List<Flashcard>, String>((ref, character) async {
  if (character.isEmpty) return [];
  
  final dictionaryRepo = ref.read(globalDictionaryRepositoryProvider);
  final result = await dictionaryRepo.getWordsContaining(character, limit: 6);
  
  return result.fold(
    (l) => [],
    (r) => r,
  );
});

// Provider to fetch Gemini context for a specific character
final characterContextProvider = FutureProvider.family<GeminiContext?, Flashcard>((ref, card) async {
  final geminiService = ref.read(geminiServiceProvider);
  return await geminiService.generateContext(card.hanzi, card.hskLevel);
});
