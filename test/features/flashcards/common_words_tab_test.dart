import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The character-detail "Words" tab used to be useless:
///
/// 1. `_buildCommonWordsSection` bailed out entirely for multi-character cards.
/// 2. The section rendered `SizedBox.shrink()` when empty, but its `GlobalKey`
///    stayed mounted — so the pill scrolled to a zero-height placeholder and
///    appeared to do nothing.
/// 3. Results were ordered `LENGTH(simplified) ASC`, which surfaced obscure
///    words (中中, 中亚, 侃学) instead of genuinely common ones.
void main() {
  late String screen;
  late String provider;
  late String repository;

  setUpAll(() {
    screen = File(
      'lib/features/flashcards/presentation/screens/character_detail_screen.dart',
    ).readAsStringSync();
    provider = File(
      'lib/features/flashcards/presentation/providers/character_detail_provider.dart',
    ).readAsStringSync();
    repository = File(
      'lib/features/flashcards/data/repositories/global_dictionary_repository.dart',
    ).readAsStringSync();
  });

  group('the Words tab reaches a section that actually exists', () {
    test('the single-character-only guard is gone', () {
      expect(
        screen,
        isNot(contains('if (widget.card.hanzi.length > 1)')),
        reason: 'Multi-character cards must be able to show related words',
      );
    });

    test('the pill is conditional on the section having content', () {
      expect(screen, contains('bool get _hasCommonWords'),
          reason: 'The pill must know whether its section will render');
      expect(screen, contains('if (_hasCommonWords) l10n.words'),
          reason: 'The Words pill must be omitted when there is no content');
    });

    test('the section is only mounted when it has content', () {
      // The guard moved from a spread-if in `_buildDetailSections` into
      // `_detailSectionWidgets` — the single list both arrangements are built
      // from. The pill list has an `if (_hasCommonWords)` of its own, so anchor
      // on the guard that actually wraps the Words section.
      final RegExp guard = RegExp(
          r'if \(_hasCommonWords\)[\s\S]{0,240}?_buildCommonWordsSection\(');
      expect(guard.hasMatch(screen), isTrue,
          reason: 'An empty section would leave a dead scroll target');
      expect(guard.firstMatch(screen)!.group(0), contains('_wordsKey'));
    });

    test('pills and sections share one ordered key list', () {
      expect(screen, contains('List<GlobalKey> get _visibleSectionKeys'),
          reason: 'A single source of truth prevents pill/section drift');
      // Both navigation paths must use the visible keys, not a fixed list.
      expect(screen, contains('final keys = _visibleSectionKeys;'));
      expect(screen, isNot(contains('_sectionKeys[index]')),
          reason:
              'Indexing a fixed key list desynchronises after hiding a pill');
    });
  });

  group('related words are ranked by usefulness, not string length', () {
    test('SQL no longer orders by length', () {
      expect(repository, isNot(contains('ORDER BY LENGTH(simplified) ASC')),
          reason: 'Length ordering surfaced obscure words');
    });

    test('ranking prefers HSK levels via the popularity table', () {
      expect(repository, contains('int _compareWordRows('));
      final comparator = repository.substring(
        repository.indexOf('int _compareWordRows('),
        repository.indexOf('/// Drops duplicate'),
      );
      expect(comparator, contains('_popularityRank(leftHanzi)'),
          reason: 'HSK rank must be the primary sort key');
      expect(comparator, contains('lengthComparison'),
          reason: 'Length is a sensible secondary key');
    });

    test('a wider candidate pool is fetched before ranking', () {
      expect(repository, contains('_wordCandidatePool'),
          reason: 'Ranking in Dart needs more candidates than we return');
      final pool = RegExp(r'_wordCandidatePool = (\d+)').firstMatch(repository);
      expect(pool, isNotNull);
      expect(int.parse(pool!.group(1)!), greaterThanOrEqualTo(200));
    });

    test('duplicate simplified rows are collapsed', () {
      expect(repository, contains('_dedupeBySimplified('),
          reason: 'Simp/trad rows can duplicate a word (e.g. 好吃 twice)');
      expect(repository, contains('_dedupeBySimplified(results)'),
          reason: 'Dedupe must run after sorting so the best row survives');
    });
  });

  group('the provider supports multi-character lookup', () {
    test('blank input is rejected but multi-character input is allowed', () {
      expect(provider, contains("if (character.trim().isEmpty) return [];"),
          reason: 'Guard should be on emptiness, not length');
    });

    test('results still exclude the card itself', () {
      expect(provider, contains('word.hanzi != character'));
      expect(provider, contains('word.hanzi.contains(character)'));
    });
  });
}
