// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cultural_context_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$culturalContextHash() => r'cd3ab11dc923c05a676ab6a3f146dcdd0de76a66';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$CulturalContext extends BuildlessAsyncNotifier<String> {
  late final String mediaTitle;

  FutureOr<String> build(
    String mediaTitle,
  );
}

/// See also [CulturalContext].
@ProviderFor(CulturalContext)
const culturalContextProvider = CulturalContextFamily();

/// See also [CulturalContext].
class CulturalContextFamily extends Family<AsyncValue<String>> {
  /// See also [CulturalContext].
  const CulturalContextFamily();

  /// See also [CulturalContext].
  CulturalContextProvider call(
    String mediaTitle,
  ) {
    return CulturalContextProvider(
      mediaTitle,
    );
  }

  @override
  CulturalContextProvider getProviderOverride(
    covariant CulturalContextProvider provider,
  ) {
    return call(
      provider.mediaTitle,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'culturalContextProvider';
}

/// See also [CulturalContext].
class CulturalContextProvider
    extends AsyncNotifierProviderImpl<CulturalContext, String> {
  /// See also [CulturalContext].
  CulturalContextProvider(
    String mediaTitle,
  ) : this._internal(
          () => CulturalContext()..mediaTitle = mediaTitle,
          from: culturalContextProvider,
          name: r'culturalContextProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$culturalContextHash,
          dependencies: CulturalContextFamily._dependencies,
          allTransitiveDependencies:
              CulturalContextFamily._allTransitiveDependencies,
          mediaTitle: mediaTitle,
        );

  CulturalContextProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mediaTitle,
  }) : super.internal();

  final String mediaTitle;

  @override
  FutureOr<String> runNotifierBuild(
    covariant CulturalContext notifier,
  ) {
    return notifier.build(
      mediaTitle,
    );
  }

  @override
  Override overrideWith(CulturalContext Function() create) {
    return ProviderOverride(
      origin: this,
      override: CulturalContextProvider._internal(
        () => create()..mediaTitle = mediaTitle,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        mediaTitle: mediaTitle,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<CulturalContext, String> createElement() {
    return _CulturalContextProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CulturalContextProvider && other.mediaTitle == mediaTitle;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mediaTitle.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CulturalContextRef on AsyncNotifierProviderRef<String> {
  /// The parameter `mediaTitle` of this provider.
  String get mediaTitle;
}

class _CulturalContextProviderElement
    extends AsyncNotifierProviderElement<CulturalContext, String>
    with CulturalContextRef {
  _CulturalContextProviderElement(super.provider);

  @override
  String get mediaTitle => (origin as CulturalContextProvider).mediaTitle;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
