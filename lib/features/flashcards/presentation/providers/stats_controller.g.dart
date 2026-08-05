// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userStatsHash() => r'90c10286f7f400249c46ca3dbd81fb0e201c4a12';

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

/// See also [userStats].
@ProviderFor(userStats)
const userStatsProvider = UserStatsFamily();

/// See also [userStats].
class UserStatsFamily extends Family<StatsState> {
  /// See also [userStats].
  const UserStatsFamily();

  /// See also [userStats].
  UserStatsProvider call({
    String? deckId,
  }) {
    return UserStatsProvider(
      deckId: deckId,
    );
  }

  @override
  UserStatsProvider getProviderOverride(
    covariant UserStatsProvider provider,
  ) {
    return call(
      deckId: provider.deckId,
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
  String? get name => r'userStatsProvider';
}

/// See also [userStats].
class UserStatsProvider extends AutoDisposeProvider<StatsState> {
  /// See also [userStats].
  UserStatsProvider({
    String? deckId,
  }) : this._internal(
          (ref) => userStats(
            ref as UserStatsRef,
            deckId: deckId,
          ),
          from: userStatsProvider,
          name: r'userStatsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userStatsHash,
          dependencies: UserStatsFamily._dependencies,
          allTransitiveDependencies: UserStatsFamily._allTransitiveDependencies,
          deckId: deckId,
        );

  UserStatsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.deckId,
  }) : super.internal();

  final String? deckId;

  @override
  Override overrideWith(
    StatsState Function(UserStatsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserStatsProvider._internal(
        (ref) => create(ref as UserStatsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        deckId: deckId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<StatsState> createElement() {
    return _UserStatsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserStatsProvider && other.deckId == deckId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, deckId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserStatsRef on AutoDisposeProviderRef<StatsState> {
  /// The parameter `deckId` of this provider.
  String? get deckId;
}

class _UserStatsProviderElement extends AutoDisposeProviderElement<StatsState>
    with UserStatsRef {
  _UserStatsProviderElement(super.provider);

  @override
  String? get deckId => (origin as UserStatsProvider).deckId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
