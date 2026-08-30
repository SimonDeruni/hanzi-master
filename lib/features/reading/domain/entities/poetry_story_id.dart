const chinesePoetryAsset = 'assets/data/famous_chinese_poetry.json';
const legacyTangPoetryAsset = 'assets/data/tang_poetry_en.json';

String poetryCoverAssetPath(String poetryId) =>
    'assets/images/poetry/$poetryId.jpg';

String bookCoverAssetPath(String bookId, {required bool isPoetry}) {
  if (isPoetry) return poetryCoverAssetPath(bookId);
  if (bookId == 'black_cat_poe') {
    return 'assets/images/books/the_black_cat.jpg';
  }
  return 'assets/images/books/$bookId.jpg';
}

bool isPoetryStoryId(String id) =>
    id.startsWith('poetry_') || id.startsWith('tang_poetry_');

String poetryEntryId(Map<String, dynamic> entry) =>
    (entry['link'] ?? entry['id'] ?? 'poetry_${entry['title']}').toString();

bool poetryEntryMatchesId(Map<String, dynamic> entry, String id) {
  if (poetryEntryId(entry) == id) return true;
  final legacyLinks = entry['legacyLinks'];
  if (legacyLinks is List &&
      legacyLinks.map((value) => value.toString()).contains(id)) {
    return true;
  }
  return entry['legacyLink']?.toString() == id;
}

String? canonicalPoetryId(
  Iterable<Map<String, dynamic>> entries,
  String id,
) {
  for (final entry in entries) {
    if (poetryEntryMatchesId(entry, id)) return poetryEntryId(entry);
  }
  return null;
}

bool isPoetryCategory(String category) =>
    category == 'Chinese Poetry' ||
    category == 'Tang Poetry' ||
    category == 'Classical Literature';

String poetryDynastyLabel(String id, {String fallback = ''}) {
  const labels = {
    'pre-qin': '先秦',
    'five_dynasties': '五代',
    'tang': '唐',
    'song': '宋',
    'yuan': '元',
    'han': '汉',
    'qing': '清',
  };
  for (final entry in labels.entries) {
    if (id.startsWith('poetry_${entry.key}_')) return entry.value;
  }
  if (id.startsWith('tang_poetry_')) return labels['tang']!;
  return fallback;
}
