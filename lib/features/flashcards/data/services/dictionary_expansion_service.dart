import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/dictionary_expansion.dart';

class DictionaryExpansionRequest {
  // Keep these aligned with functions/dictionary-expansion.js. Changing either
  // version intentionally invalidates the device cache.
  static const modelVersion = 'gemini-2.5-flash';
  static const promptVersion = 'dictionary-expansion-v2-concise';

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
  final FirebaseFunctions? _customFunctions;
  final FirebaseAuth? _customAuth;

  DictionaryExpansionService({
    FirebaseFunctions? functions,
    FirebaseAuth? auth,
  })  : _customFunctions = functions,
        _customAuth = auth;

  FirebaseFunctions? get _functions {
    if (_customFunctions != null) return _customFunctions;
    try {
      return FirebaseFunctions.instance;
    } catch (_) {
      return null;
    }
  }

  FirebaseAuth? get _auth {
    if (_customAuth != null) return _customAuth;
    try {
      return FirebaseAuth.instance;
    } catch (_) {
      return null;
    }
  }

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

    try {
      final auth = _auth;
      final functions = _functions;
      if (auth == null || functions == null) {
        throw const DictionaryExpansionException(
          DictionaryExpansionFailure.unavailable,
        );
      }
      if (auth.currentUser == null) {
        await auth.signInAnonymously();
      }

      final result = await functions
          .httpsCallable('getDictionaryExpansionV1')
          .call(<String, dynamic>{
        'wordId': request.wordId,
        'languageCode': request.languageCode,
        'sourceDefinitionHash': request.sourceDefinitionHash,
      });
      final payload = Map<String, dynamic>.from(result.data as Map);
      final expansion = DictionaryExpansion.fromJson(payload);
      if (expansion.sourceDefinitionHash != request.sourceDefinitionHash ||
          expansion.languageCode != request.languageCode ||
          expansion.modelVersion != DictionaryExpansionRequest.modelVersion ||
          expansion.promptVersion != DictionaryExpansionRequest.promptVersion) {
        throw const FormatException('Stale dictionary expansion response');
      }
      await box.put(request.cacheKey, expansion.toJson());
      return expansion;
    } on DictionaryExpansionException {
      rethrow;
    } on FirebaseFunctionsException catch (error) {
      throw DictionaryExpansionException.fromFirebaseCode(error.code);
    } on FirebaseAuthException catch (error) {
      throw DictionaryExpansionException.fromFirebaseCode(error.code);
    } on FirebaseException catch (_) {
      throw const DictionaryExpansionException(
        DictionaryExpansionFailure.appVerification,
      );
    }
  }
}

enum DictionaryExpansionFailure {
  signIn,
  appVerification,
  unavailable,
  quota,
  staleSource,
  notEligible,
  unknown,
}

class DictionaryExpansionException implements Exception {
  final DictionaryExpansionFailure failure;

  const DictionaryExpansionException(this.failure);

  factory DictionaryExpansionException.fromFirebaseCode(String code) {
    switch (code) {
      case 'unauthenticated':
      case 'operation-not-allowed':
        return const DictionaryExpansionException(
          DictionaryExpansionFailure.signIn,
        );
      case 'unauthorized':
      case 'failed-precondition':
        return const DictionaryExpansionException(
          DictionaryExpansionFailure.notEligible,
        );
      case 'resource-exhausted':
        return const DictionaryExpansionException(
          DictionaryExpansionFailure.quota,
        );
      case 'not-found':
        return const DictionaryExpansionException(
          DictionaryExpansionFailure.staleSource,
        );
      case 'unavailable':
      case 'deadline-exceeded':
      case 'internal':
        return const DictionaryExpansionException(
          DictionaryExpansionFailure.unavailable,
        );
      default:
        return const DictionaryExpansionException(
          DictionaryExpansionFailure.unknown,
        );
    }
  }

  @override
  String toString() => 'Dictionary expansion failed: ${failure.name}';
}
