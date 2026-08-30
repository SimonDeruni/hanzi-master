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
