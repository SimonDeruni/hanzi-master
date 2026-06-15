// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$courseControllerHash() => r'9923703a5f422062aaeff71ef8a18768d731bfba';

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

abstract class _$CourseController
    extends BuildlessAutoDisposeAsyncNotifier<List<CourseUnit>> {
  late final String deckId;

  FutureOr<List<CourseUnit>> build(
    String deckId,
  );
}

/// See also [CourseController].
@ProviderFor(CourseController)
const courseControllerProvider = CourseControllerFamily();

/// See also [CourseController].
class CourseControllerFamily extends Family<AsyncValue<List<CourseUnit>>> {
  /// See also [CourseController].
  const CourseControllerFamily();

  /// See also [CourseController].
  CourseControllerProvider call(
    String deckId,
  ) {
    return CourseControllerProvider(
      deckId,
    );
  }

  @override
  CourseControllerProvider getProviderOverride(
    covariant CourseControllerProvider provider,
  ) {
    return call(
      provider.deckId,
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
  String? get name => r'courseControllerProvider';
}

/// See also [CourseController].
class CourseControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    CourseController, List<CourseUnit>> {
  /// See also [CourseController].
  CourseControllerProvider(
    String deckId,
  ) : this._internal(
          () => CourseController()..deckId = deckId,
          from: courseControllerProvider,
          name: r'courseControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$courseControllerHash,
          dependencies: CourseControllerFamily._dependencies,
          allTransitiveDependencies:
              CourseControllerFamily._allTransitiveDependencies,
          deckId: deckId,
        );

  CourseControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.deckId,
  }) : super.internal();

  final String deckId;

  @override
  FutureOr<List<CourseUnit>> runNotifierBuild(
    covariant CourseController notifier,
  ) {
    return notifier.build(
      deckId,
    );
  }

  @override
  Override overrideWith(CourseController Function() create) {
    return ProviderOverride(
      origin: this,
      override: CourseControllerProvider._internal(
        () => create()..deckId = deckId,
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
  AutoDisposeAsyncNotifierProviderElement<CourseController, List<CourseUnit>>
      createElement() {
    return _CourseControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseControllerProvider && other.deckId == deckId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, deckId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CourseControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<CourseUnit>> {
  /// The parameter `deckId` of this provider.
  String get deckId;
}

class _CourseControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CourseController,
        List<CourseUnit>> with CourseControllerRef {
  _CourseControllerProviderElement(super.provider);

  @override
  String get deckId => (origin as CourseControllerProvider).deckId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
