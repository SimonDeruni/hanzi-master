// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$lessonControllerHash() => r'c15634e836d10b4aa8514eac474d3df8ab3f8b4e';

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

abstract class _$LessonController
    extends BuildlessAutoDisposeNotifier<LessonState> {
  late final Flashcard card;

  LessonState build(
    Flashcard card,
  );
}

/// See also [LessonController].
@ProviderFor(LessonController)
const lessonControllerProvider = LessonControllerFamily();

/// See also [LessonController].
class LessonControllerFamily extends Family<LessonState> {
  /// See also [LessonController].
  const LessonControllerFamily();

  /// See also [LessonController].
  LessonControllerProvider call(
    Flashcard card,
  ) {
    return LessonControllerProvider(
      card,
    );
  }

  @override
  LessonControllerProvider getProviderOverride(
    covariant LessonControllerProvider provider,
  ) {
    return call(
      provider.card,
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
  String? get name => r'lessonControllerProvider';
}

/// See also [LessonController].
class LessonControllerProvider
    extends AutoDisposeNotifierProviderImpl<LessonController, LessonState> {
  /// See also [LessonController].
  LessonControllerProvider(
    Flashcard card,
  ) : this._internal(
          () => LessonController()..card = card,
          from: lessonControllerProvider,
          name: r'lessonControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$lessonControllerHash,
          dependencies: LessonControllerFamily._dependencies,
          allTransitiveDependencies:
              LessonControllerFamily._allTransitiveDependencies,
          card: card,
        );

  LessonControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.card,
  }) : super.internal();

  final Flashcard card;

  @override
  LessonState runNotifierBuild(
    covariant LessonController notifier,
  ) {
    return notifier.build(
      card,
    );
  }

  @override
  Override overrideWith(LessonController Function() create) {
    return ProviderOverride(
      origin: this,
      override: LessonControllerProvider._internal(
        () => create()..card = card,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        card: card,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<LessonController, LessonState>
      createElement() {
    return _LessonControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LessonControllerProvider && other.card == card;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, card.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LessonControllerRef on AutoDisposeNotifierProviderRef<LessonState> {
  /// The parameter `card` of this provider.
  Flashcard get card;
}

class _LessonControllerProviderElement
    extends AutoDisposeNotifierProviderElement<LessonController, LessonState>
    with LessonControllerRef {
  _LessonControllerProviderElement(super.provider);

  @override
  Flashcard get card => (origin as LessonControllerProvider).card;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
