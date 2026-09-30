import 'book_model.dart';
import 'poetry_story_id.dart';

/// Author name used when a poem carries none, so no poem is ever dropped.
const String poetryUnknownAuthor = '佚名';

/// One poet's book: a collection of their poems, where each poem is a chapter.
///
/// A single Chinese poem averages ~85 characters, so one poem per book dropped
/// the reader into full book chrome — table of contents, chapter counter,
/// progress — for four lines of verse. Grouping by author gives the reader the
/// shape it was built for, and the per-poem localized titles already shipped in
/// `assets/data/l10n/poetry_<locale>.json` become the chapter titles, so the
/// 13-locale translation work is reused rather than duplicated.
class PoetryCollection {
  /// Book id: `poetry_author_<digest of [author]>`.
  final String id;

  /// The **raw** Chinese author name: the grouping key, and the only stable
  /// identity for the poet (display names are derived per locale).
  final String author;

  /// Dynasty as recorded on the poems (`Tang`, `Song`, …).
  final String dynasty;

  /// Median of the poems' positive HSK levels — the level needed for the
  /// *typical* poem here, rather than the easiest or the hardest one.
  final int hskLevel;

  /// The poems, in curated order. Poem 1 is chapter 1.
  final List<Map<String, dynamic>> poems;

  /// The poet's biography in Simplified Chinese ('' when none was sourced).
  final String summary;

  /// The biography per locale, keyed like the content catalogues (`fr`, `ja`…),
  /// including `en` because English is the app's base locale rather than one of
  /// the 13 selectable content locales.
  final Map<String, String> localizedSummaries;

  const PoetryCollection({
    required this.id,
    required this.author,
    required this.dynasty,
    required this.hskLevel,
    required this.poems,
    this.summary = '',
    this.localizedSummaries = const {},
  });

  /// The biography in [localeCode]. Falls back to the Chinese original, so a
  /// missing translation shows the poet's real history rather than nothing.
  String localizedSummary(String localeCode) {
    if (summary.isEmpty) return '';
    final normalized = localeCode.replaceAll('-', '_').toLowerCase();
    final language = normalized.split('_').first;
    if (language == 'zh') return summary;
    return localizedSummaries[normalized] ??
        localizedSummaries[language] ??
        summary;
  }

  /// The English biography, for `BookModel.descriptionEn`.
  String get summaryEn => localizedSummaries['en'] ?? summary;

  int get poemCount => poems.length;

  List<String> get poemIds =>
      poems.map((poem) => poetryEntryId(poem)).toList(growable: false);

  /// 1-based chapter number of [poemId], or null when this collection does not
  /// hold it. Migrating a bookmark that still points at a bare poem needs this.
  int? chapterIndexOf(String poemId) {
    final int index = poemIds.indexOf(poemId);
    return index == -1 ? null : index + 1;
  }
}

/// Groups per-poem entries into one collection per author.
///
/// Collections are ordered by size (biggest first), ties broken by the order the
/// author first appears in [entries], so the catalog opens on the substantial
/// books. Poems keep their curated order inside a collection, which keeps the
/// best-known poem as chapter 1.
List<PoetryCollection> buildPoetryCollections(
  List<Map<String, dynamic>> entries, {
  Map<String, String> summaries = const <String, String>{},
  Map<String, Map<String, String>> localizedSummaries =
      const <String, Map<String, String>>{},
}) {
  final grouped = <String, List<Map<String, dynamic>>>{};
  final firstSeen = <String, int>{};

  for (var index = 0; index < entries.length; index++) {
    final entry = entries[index];
    final raw = (entry['sourceName'] ?? '').toString().trim();
    final author = raw.isEmpty ? poetryUnknownAuthor : raw;
    firstSeen.putIfAbsent(author, () => index);
    grouped.putIfAbsent(author, () => <Map<String, dynamic>>[]).add(entry);
  }

  final collections = grouped.entries
      .map((group) => PoetryCollection(
            id: poetryAuthorBookId(group.key),
            author: group.key,
            dynasty: _dynastyOf(group.value),
            hskLevel: _medianHskLevel(group.value),
            poems: group.value,
            summary: summaries[group.key] ?? '',
            localizedSummaries:
                localizedSummaries[group.key] ?? const <String, String>{},
          ))
      .toList();

  collections.sort((a, b) {
    final bySize = b.poemCount.compareTo(a.poemCount);
    if (bySize != 0) return bySize;
    return firstSeen[a.author]!.compareTo(firstSeen[b.author]!);
  });
  return collections;
}

/// The collection holding [poemId], or null when no author holds that poem.
///
/// A legacy bookmark or progress record still carries a bare poem id; this is
/// how it is resolved to the author book that now owns it.
PoetryCollection? collectionForPoem(
  List<PoetryCollection> collections,
  String poemId,
) {
  for (final collection in collections) {
    if (collection.chapterIndexOf(poemId) != null) return collection;
  }
  return null;
}

/// The book the shelf and the reader use for [collection].
///
/// The title is the poet's **name**, not a translated phrase: a proper noun
/// reads the same in all 14 locales, so a collection needs no new ARB key and no
/// 13-file translation sweep for its title. The poem count rides on
/// `totalChapters`, which the catalog card renders through the existing
/// `chapters(n)` string.
BookModel poetryCollectionToBook(
  PoetryCollection collection, {
  String localeCode = 'en',
}) {
  final firstPoem = collection.poems.first;
  final authorEn = (firstPoem['author_en'] ?? '').toString().trim();
  final summary = collection.localizedSummary(localeCode);
  return BookModel(
    id: collection.id,
    title: collection.author,
    titleEn: authorEn.isNotEmpty ? authorEn : collection.author,
    author: collection.author,
    authorEn: authorEn.isNotEmpty ? authorEn : collection.author,
    category: 'Chinese Poetry',
    // What is *in* the collection — its own summary, translated. The poet's
    // biography is a separate text (the person, not the contents) and reaches the
    // author card through `BundledAuthorBiographyService`; the poem titles are
    // the last resort for a collection we could not describe at all.
    description: summary.isNotEmpty
        ? summary
        : _joinTitles(collection, 'title'),
    descriptionEn: collection.summaryEn.isNotEmpty
        ? collection.summaryEn
        : _joinTitles(collection, 'title_en'),
    dynastyOrEra: collection.dynasty,
    hskLevel: collection.hskLevel,
    totalChapters: collection.poemCount,
    coverEmoji: '📜',
    tags: const ['Poetry', 'Classical', 'Verse'],
  );
}

/// Up to six poem titles joined for the synopsis, so a fifty-poem collection
/// does not produce a screen-long description.
String _joinTitles(PoetryCollection collection, String key) {
  final titles = collection.poems
      .map((poem) => (poem[key] ?? '').toString().trim())
      .where((title) => title.isNotEmpty)
      .toList();
  const limit = 6;
  if (titles.length <= limit) return titles.join(' · ');
  return '${titles.take(limit).join(' · ')} …';
}

/// The dynasty of the first poem that records one.
String _dynastyOf(List<Map<String, dynamic>> poems) {
  for (final poem in poems) {
    final dynasty = (poem['dynasty'] ?? '').toString().trim();
    if (dynasty.isNotEmpty) return dynasty;
  }
  return '';
}

/// Median of the poems' positive HSK levels, or 0 when none is graded.
int _medianHskLevel(List<Map<String, dynamic>> poems) {
  final levels = <int>[];
  for (final poem in poems) {
    final level = poem['hskLevel'];
    if (level is int && level > 0) levels.add(level);
  }
  if (levels.isEmpty) return 0;
  levels.sort();
  return levels[levels.length ~/ 2];
}
