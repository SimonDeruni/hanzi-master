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

/// Book ids whose bundled cover is a **Project Gutenberg geometric placeholder**
/// rather than a real jacket.
///
/// The Gutenberg imports (`docs/BOOK_SOURCES.md`) arrived with the cover image PG
/// auto-generates when a book has no jacket: a flat colour field with a few right
/// angles, a triangle or a circle, then a "Project Gutenberg" stamp. On the shelf
/// those tiles read as random colour blocks — `BoxFit.cover` in the grid crops the
/// Chinese title off the top and the stamp off the bottom, leaving only the shapes
/// — and they fight the hand-picked jackets and the CC0 museum plates every other
/// book wears.
///
/// For these ids [CalligraphicBookCover] draws its own calligraphic plate instead
/// of the raw photo, so the shelf keeps the "Zen & Ink" look. The file is still
/// bundled (the cover-manifest test requires one per book) and is shown again the
/// moment a book is given real art and drops out of this set.
///
/// This list is **derived, not hand-guessed**: it is exactly the `gutenberg.org`
/// sources in `docs/BOOK_SOURCES.md`, and `scratch/_cover_placeholder_probe.py`
/// prints it and cross-checks it against the bundled files. No Gutenberg-sourced
/// cover is real art, and the only sub-20 KB covers outside Gutenberg are four
/// hand-picked jackets (`dao_de_jing`, `journey_to_the_west`,
/// `records_grand_historian`, `the_art_of_war`), which are deliberately absent.
const Set<String> gutenbergPlaceholderCoverIds = {
  'a_fool_s_dream_talk',
  'a_play_within_a_play',
  'anecdotes_from_court_and_country',
  'casual_expressions_of_idle_feeling',
  'deng_xizi',
  'discourses_of_the_states',
  'dream_pool_essays',
  'extended_reflections',
  'flowers_in_the_mirror',
  'further_records_of_searching_for_spirits',
  'garden_of_stories',
  'generals_of_the_yang_family',
  'gongsun_longzi',
  'guanzi',
  'idle_talk_under_the_bean_arbor',
  'lord_liang_s_nine_remonstrances',
  'love_in_the_mountains_and_waters',
  'miscellaneous_records_of_duyang',
  'miscellanies_of_the_western_capital',
  'new_prefaces',
  'notes_from_the_thatched_hut',
  'officialdom_unmasked',
  'outer_traditions_of_the_han_school_of_so',
  'reflections_on_things_at_hand',
  'romance_of_the_sui_and_tang',
  'romance_of_the_western_chamber',
  'six_secret_teachings',
  'spring_in_the_jade_tower',
  'stories_to_enlighten_the_world',
  'study_of_human_abilities',
  'tales_of_the_tang',
  'the_book_of_lord_shang',
  'the_cases_of_judge_dee',
  'the_cases_of_judge_hai',
  'the_cases_of_judge_shi',
  'the_classic_of_go',
  'the_classic_of_tea',
  'the_complete_tale_of_feituo',
  'the_drunken_awakening_stone',
  'the_family_instructions_of_master_yan',
  'the_flounder',
  'the_green_peony',
  'the_heavenly_leopard',
  'the_investiture_of_the_gods',
  'the_literary_mind_and_the_carving_of_dra',
  'the_lone_swan',
  'the_new_book_of_jia_yi',
  'the_peony_pavilion',
  'the_phoenix_flute',
  'the_platform_sutra_of_the_sixth_patriarc',
  'the_poets_grading',
  'the_scholars',
  'the_slaying_of_the_ghosts',
  'the_strange_tale_of_the_woman_mulan',
  'the_tale_of_li_wa',
  'the_travels_of_lao_can',
  'the_travels_of_xu_xiake',
  'the_unicorn_child',
  'three_strategies',
  'waiting_for_the_dawn',
  'water_margin',
  'wei_liaozi',
  'yan_danzi',
  'yin_wenzi',
  'yu_jiao_li',
  'yuli_zi',
};

/// True when [bookId]'s bundled cover is a Project Gutenberg geometric placeholder,
/// i.e. one the shelf is better off drawing than photographing.
bool bookCoverIsPlaceholder(String bookId) =>
    gutenbergPlaceholderCoverIds.contains(bookId);

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
