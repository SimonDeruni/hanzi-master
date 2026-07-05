// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hanzi_metadata_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hanziCharDefinitionsHash() =>
    r'9237fc63245217f06af1dafc2b323540926a9516';

/// Lightweight map from hanzi character → English definition.
/// Loaded from hanzi_metadata.json which covers all ~20k Chinese characters.
///
/// Copied from [hanziCharDefinitions].
@ProviderFor(hanziCharDefinitions)
final hanziCharDefinitionsProvider =
    FutureProvider<Map<String, String>>.internal(
  hanziCharDefinitions,
  name: r'hanziCharDefinitionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hanziCharDefinitionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef HanziCharDefinitionsRef = FutureProviderRef<Map<String, String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
