import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/reading/domain/entities/poetry_story_id.dart';

void main() {
  final entries = [
    <String, dynamic>{
      'id': 'poetry_tang_fef789b0',
      'link': 'poetry_tang_fef789b0',
      'legacyLinks': ['tang_poetry_静夜思'],
    },
  ];

  test('canonical poetry and legacy IDs resolve to the canonical ID', () {
    expect(canonicalPoetryId(entries, 'poetry_tang_fef789b0'),
        'poetry_tang_fef789b0');
    expect(
        canonicalPoetryId(entries, 'tang_poetry_静夜思'), 'poetry_tang_fef789b0');
    expect(canonicalPoetryId(entries, 'unknown'), isNull);
  });

  test('cover resolver handles poetry and the Black Cat catalog alias', () {
    // `black_cat_poe` was removed from the catalog on 2026-09-27 as part of the
    // copyright removals (docs/BOOK_COPYRIGHT_REMOVALS.md), and its cover
    // `the_black_cat.jpg` along with it. This alias is kept because the resolver is a
    // pure path function and the id may still exist in a reader's saved bookmarks -
    // but it no longer maps to a shipped asset, so nothing should reintroduce it.
    expect(
      bookCoverAssetPath('poetry_tang_fef789b0', isPoetry: true),
      'assets/images/poetry/poetry_tang_fef789b0.jpg',
    );
    expect(
      bookCoverAssetPath('black_cat_poe', isPoetry: false),
      'assets/images/books/the_black_cat.jpg',
    );
  });
}
