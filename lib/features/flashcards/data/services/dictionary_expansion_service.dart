import 'package:cloud_functions/cloud_functions.dart';
import 'package:hive/hive.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/dictionary_expansion.dart';

class DictionaryExpansionRequest {
  // Keep these aligned with functions/dictionary-expansion.js. Changing either
  // version intentionally invalidates the device cache.
  static const modelVersion = 'gemini-2.5-flash';
  static const promptVersion = 'dictionary-expansion-v1';

  final int wordId;
  final String languageCode;
  final String sourceDefinitionHash;

  const DictionaryExpansionRequest({
    required this.wordId,
    required this.languageCode,
    required this.sourceDefinitionHash,
  });

  String get cacheKey =>
      '$wordId:$languageCode:$sourceDefinitionHash:$modelVersion:$promptVersion';

  @override
  bool operator ==(Object other) =>
      other is DictionaryExpansionRequest && other.cacheKey == cacheKey;

  @override
  int get hashCode => cacheKey.hashCode;
}

class DictionaryExpansionService {
  static const _boxName = 'dictionary_expansions_v1';
  final FirebaseFunctions _functions;

  DictionaryExpansionService({FirebaseFunctions? functions})
      : _functions = functions ?? FirebaseFunctions.instance;

  /// Returns a valid device-cached expansion without contacting Firebase.
  Future<DictionaryExpansion?> getCachedExpansion(
    DictionaryExpansionRequest request,
  ) async {
    final box = await Hive.openBox<dynamic>(_boxName);
    final local = box.get(request.cacheKey);
    if (local is! Map) return null;

    try {
      final expansion =
          DictionaryExpansion.fromJson(Map<String, dynamic>.from(local));
      if (expansion.sourceDefinitionHash != request.sourceDefinitionHash ||
          expansion.languageCode != request.languageCode ||
          expansion.modelVersion != DictionaryExpansionRequest.modelVersion ||
          expansion.promptVersion != DictionaryExpansionRequest.promptVersion) {
        await box.delete(request.cacheKey);
        return null;
      }
      return expansion;
    } on FormatException {
      await box.delete(request.cacheKey);
      return null;
    }
  }

  Future<DictionaryExpansion> getExpansion(
    DictionaryExpansionRequest request,
  ) async {
    final cached = await getCachedExpansion(request);
    if (cached != null) return cached;

    final box = await Hive.openBox<dynamic>(_boxName);

    final result = await _functions
        .httpsCallable('getDictionaryExpansionV1')
        .call(<String, dynamic>{
      'wordId': request.wordId,
      'languageCode': request.languageCode,
      'sourceDefinitionHash': request.sourceDefinitionHash,
    });
    final payload = Map<String, dynamic>.from(result.data as Map);
    final expansion = DictionaryExpansion.fromJson(payload);
    if (expansion.sourceDefinitionHash != request.sourceDefinitionHash) {
      throw const FormatException('Stale dictionary expansion response');
    }
    await box.put(request.cacheKey, expansion.toJson());
    return expansion;
  }
}
