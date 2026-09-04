import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/data/services/dictionary_expansion_service.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/dictionary_expansion.dart';

final dictionaryExpansionServiceProvider =
    Provider<DictionaryExpansionService>((ref) => DictionaryExpansionService());

final dictionaryExpansionProvider = FutureProvider.autoDispose
    .family<DictionaryExpansion, DictionaryExpansionRequest>((ref, request) {
  return ref.read(dictionaryExpansionServiceProvider).getExpansion(request);
});
