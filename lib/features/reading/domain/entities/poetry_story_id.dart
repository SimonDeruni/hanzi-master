import 'dart:convert';

const chinesePoetryAsset = 'assets/data/famous_chinese_poetry.json';
const legacyTangPoetryAsset = 'assets/data/tang_poetry_en.json';

/// The poets' biographies (Chinese), with `origin`/`source` provenance per poet.
const poetBiosAsset = 'assets/data/poet_bios.json';

/// The English biographies. English is the app's base locale rather than one of
/// the 13 selectable content locales, so `loadLocalizedTitlesById` skips it.
const poetBiosEnAsset = 'assets/data/l10n/poet_bios_en.json';

/// The **collection** summaries (Chinese), keyed by the poet's Chinese name.
///
/// A different text from [poetBiosAsset]: the biography is the person, this is
/// the contents — what is gathered in the poet's poems and what a learner gets
/// from reading them together. Both are shown, in different places: the summary
/// describes the collection card and the book, the biography answers the author
/// card through `BundledAuthorBiographyService`.
const poetryCollectionsAsset = 'assets/data/poetry_collections.json';

/// The English collection summaries, for the same reason [poetBiosEnAsset] is
/// read separately.
const poetryCollectionsEnAsset =
    'assets/data/l10n/poetry_collections_en.json';

/// Book-id prefix for one poet's collection (`poetry_author_<digest>`).
const String poetryAuthorBookPrefix = 'poetry_author_';

/// A stable 8-hex digest of [value], shaped like the existing
/// `poetry_<dynasty>_<hex>` poem ids.
///
/// FNV-1a over the UTF-8 bytes. This is a **book-id ingredient**: it is written
/// into Hive reading progress and bookmarks, so it must never change for a
/// given author name — a different digest would orphan a reader's history.
/// A degenerate hash (all digits, no letter) is left-padded rather than
/// re-hashed, which keeps the function total and deterministic.
String poetryDigest(String value) {
  var hash = 0x811c9dc5;
  for (final byte in utf8.encode(value)) {
    hash ^= byte;
    hash = (hash * 0x01000193) & 0xFFFFFFFF;
  }
  return hash.toRadixString(16).padLeft(8, '0');
}

/// The book id for the collection of [author] (the **raw** Chinese name).
///
/// Keyed on the raw source name on purpose: display names are derived per
/// locale (`_translateAuthor` lowercases to pinyin), so keying on a displayed
/// name would split one poet into several books depending on the device locale.
String poetryAuthorBookId(String author) =>
    '$poetryAuthorBookPrefix${poetryDigest(author)}';

/// True for an author-collection book id (as opposed to a single poem's).
bool isPoetryAuthorBookId(String id) => id.startsWith(poetryAuthorBookPrefix);


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
