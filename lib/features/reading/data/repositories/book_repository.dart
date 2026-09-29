import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/domain/entities/poetry_collection.dart';
import 'package:hanzi_master/features/reading/domain/entities/poetry_story_id.dart';
import 'package:hanzi_master/features/reading/domain/logic/reading_session.dart';
import 'package:hanzi_master/features/reading/data/services/book_download_service.dart';
import 'package:hanzi_master/features/reading/data/services/localized_title_loader.dart';

class BookRepository {
  static const String _progressBoxName = 'grand_library_progress_v1';
  static const String _bookCacheBoxName = 'grand_library_book_cache_v5';
  static const String _bookmarksBoxName = 'grand_library_bookmarks_v1';
  static const String _sessionBoxName = 'grand_library_session_v1';
  static const String _readingHistoryBoxName =
      'grand_library_reading_history_v1';

  List<BookModel> _cachedCatalog = [];
  List<Map<String, dynamic>> _poetryEntries = [];
  Map<String, Map<String, String>> _poetryTitlesById = {};

  /// One book per poet, so a short poem becomes a chapter rather than a whole
  /// book with a table of contents and a counter for four lines of verse.
  List<PoetryCollection> _poetryCollections = [];
  final BookDownloadService _downloadService;

  BookRepository({BookDownloadService? downloadService})
      : _downloadService = downloadService ?? BookDownloadService();

  Future<void> init() async {
    if (!Hive.isBoxOpen(_progressBoxName)) {
      await Hive.openBox<dynamic>(_progressBoxName);
    }
    if (!Hive.isBoxOpen(_bookmarksBoxName)) {
      await Hive.openBox<dynamic>(_bookmarksBoxName);
    }
    if (!Hive.isBoxOpen(_sessionBoxName)) {
      await Hive.openBox<dynamic>(_sessionBoxName);
    }
    if (!Hive.isBoxOpen(_readingHistoryBoxName)) {
      await Hive.openBox<dynamic>(_readingHistoryBoxName);
    }
    // Delete legacy cache boxes if still present
    for (final oldBox in [
      'grand_library_book_cache_v1',
      'grand_library_book_cache_v2',
      'grand_library_book_cache_v3',
      'grand_library_book_cache_v4',
      _bookCacheBoxName,
    ]) {
      try {
        if (await Hive.boxExists(oldBox)) {
          await Hive.deleteBoxFromDisk(oldBox);
        }
      } catch (_) {}
    }
    await _loadPoetryEntries();
    await _canonicalizeLegacyBookmarkBookIds();
    await _migratePoemRecordsToAuthorCollections();
    await loadCatalog();
  }

  Future<void> _loadPoetryEntries() async {
    try {
      final results = await Future.wait([
        rootBundle.loadString(chinesePoetryAsset),
        loadLocalizedTitlesById('poetry'),
      ]);
      final content = results[0] as String;
      _poetryTitlesById = results[1] as Map<String, Map<String, String>>;
      final entries = jsonDecode(content) as List<dynamic>;
      _poetryEntries = entries
          .map((entry) => Map<String, dynamic>.from(entry as Map))
          .toList();
      final bios = await _loadPoetBios();
      _poetryCollections = buildPoetryCollections(
        _poetryEntries,
        summaries: bios.$1,
        localizedSummaries: bios.$2,
      );
    } catch (_) {
      _poetryEntries = [];
      _poetryTitlesById = {};
      _poetryCollections = [];
    }
  }

  /// The poet biographies: the Chinese originals plus every translation, so a
  /// collection can be described in the reader's own language.
  ///
  /// Each file is optional — a missing catalogue must not cost the poems — so
  /// every part is guarded and the collection simply falls back to the poem
  /// titles it always used.
  Future<(Map<String, String>, Map<String, Map<String, String>>)>
      _loadPoetBios() async {
    final summaries = <String, String>{};
    final localized = <String, Map<String, String>>{};
    try {
      final raw =
          jsonDecode(await rootBundle.loadString(poetBiosAsset)) as Map<String, dynamic>;
      for (final entry in raw.entries) {
        final value = entry.value;
        final text = value is Map
            ? (value['summary'] ?? '').toString()
            : value.toString();
        if (text.trim().isNotEmpty) summaries[entry.key] = text.trim();
      }
    } catch (_) {}
    try {
      final byLocale = await loadLocalizedTitlesById('poet_bios');
      for (final entry in byLocale.entries) {
        localized[entry.key] = <String, String>{
          ...?localized[entry.key],
          ...entry.value,
        };
      }
    } catch (_) {}
    try {
      final english =
          jsonDecode(await rootBundle.loadString(poetBiosEnAsset)) as Map<String, dynamic>;
      for (final entry in english.entries) {
        final text = entry.value.toString().trim();
        if (text.isNotEmpty) {
          localized.putIfAbsent(entry.key, () => <String, String>{})['en'] = text;
        }
      }
    } catch (_) {}
    return (summaries, localized);
  }

  PoetryCollection? _collectionById(String bookId) {
    for (final collection in _poetryCollections) {
      if (collection.id == bookId) return collection;
    }
    return null;
  }

  /// The per-poet collections: one book per poet, so a short poem is a chapter
  /// rather than a whole book. Populated by [init]; a caller reading this before
  /// init sees an empty list, so providers await `init()` first.
  List<PoetryCollection> get poetryCollections =>
      List<PoetryCollection>.unmodifiable(_poetryCollections);

  /// The id a record about [bookId] belongs under.
  ///
  /// Two renames have happened: a legacy title-as-id (`tang_poetry_静夜思`) became
  /// the poem's canonical id, and a poem became a chapter of the poet's
  /// collection. Resolving both here keeps every caller agreeing - what
  /// [saveBookmark] writes is what [getBookmarks] looks up, what the bookmarks
  /// shelf groups by, and what [migratePoemRecordsToAuthorCollections] would have
  /// rewritten anyway. Without the collection step a bookmark saved in this
  /// session stayed on the bare poem id and only joined the poet's shelf after
  /// the next launch.
  String _canonicalBookId(String bookId) {
    final poemId = canonicalPoetryId(_poetryEntries, bookId) ?? bookId;
    if (_poetryCollections.isEmpty) return poemId;
    return collectionForPoem(_poetryCollections, poemId)?.id ?? poemId;
  }

  /// Renames legacy poetry ids (`tang_poetry_静夜思` → `poetry_tang_<hex>`)
  /// before the collection migration runs, so a bookmark written against a
  /// title-as-id still lands on the author book that owns the poem.
  Future<void> _canonicalizeLegacyBookmarkBookIds() async {
    if (!Hive.isBoxOpen(_bookmarksBoxName) || _poetryEntries.isEmpty) return;
    final box = Hive.box<dynamic>(_bookmarksBoxName);
    for (final key in box.keys.toList()) {
      final value = box.get(key);
      if (value is! Map) continue;
      try {
        final bookmark = Map<String, dynamic>.from(value);
        final oldId = bookmark['bookId']?.toString() ?? '';
        final canonicalId = _canonicalBookId(oldId);
        if (oldId != canonicalId) {
          bookmark['bookId'] = canonicalId;
          await box.put(key, bookmark);
        }
      } catch (_) {}
    }
  }

  /// Re-points records written when one poem was one book at the author book
  /// that now owns that poem, keeping the verse the reader was actually on.
  ///
  /// A poem's own chapterIndex (always 1) becomes its position inside the
  /// collection, and its percentage is recomputed against the collection —
  /// otherwise having finished one poem would claim the whole poet as read.
  Future<void> _migratePoemRecordsToAuthorCollections() async {
    if (_poetryCollections.isEmpty) return;

    if (Hive.isBoxOpen(_progressBoxName)) {
      final box = Hive.box<dynamic>(_progressBoxName);
      // Re-keying can collide: two poems by one poet used to be two books and
      // are now two chapters of one, so the most recent record wins.
      final merged = <String, Map<String, dynamic>>{};
      final staleKeys = <dynamic>[];
      for (final key in box.keys.toList()) {
        final value = box.get(key);
        if (value is! Map) continue;
        final migrated = _migrateRecordToCollection(
          Map<String, dynamic>.from(value),
        );
        if (migrated == null) continue;
        staleKeys.add(key);
        final bookId = migrated['bookId'] as String;
        final existing = merged[bookId];
        final newer = existing == null ||
            (migrated['updatedAt']?.toString() ?? '')
                    .compareTo(existing['updatedAt']?.toString() ?? '') >
                0;
        if (newer) merged[bookId] = migrated;
      }
      for (final key in staleKeys) {
        await box.delete(key);
      }
      for (final entry in merged.entries) {
        await box.put(entry.key, entry.value);
      }
    }

    // Bookmarks are keyed by their own id, so a rewrite cannot collide.
    if (Hive.isBoxOpen(_bookmarksBoxName)) {
      final box = Hive.box<dynamic>(_bookmarksBoxName);
      for (final key in box.keys.toList()) {
        final value = box.get(key);
        if (value is! Map) continue;
        final migrated = _migrateRecordToCollection(
          Map<String, dynamic>.from(value),
        );
        if (migrated != null) await box.put(key, migrated);
      }
    }

    // The resume card points at one book too.
    if (Hive.isBoxOpen(_sessionBoxName)) {
      final box = Hive.box<dynamic>(_sessionBoxName);
      final value = box.get('last_session');
      if (value is Map) {
        final migrated = _migrateRecordToCollection(
          Map<String, dynamic>.from(value),
        );
        if (migrated != null) await box.put('last_session', migrated);
      }
    }
  }

  /// Rewrites [record] when its `bookId` is a bare poem, or returns null when
  /// the record is already correct (an author book, or a non-poetry book).
  Map<String, dynamic>? _migrateRecordToCollection(
    Map<String, dynamic> record,
  ) {
    final oldId = record['bookId']?.toString() ?? '';
    if (oldId.isEmpty || isPoetryAuthorBookId(oldId)) return null;
    final collection = collectionForPoem(_poetryCollections, oldId);
    if (collection == null) return null;

    final chapterIndex = collection.chapterIndexOf(oldId) ?? 1;
    final migrated = Map<String, dynamic>.from(record)
      ..['bookId'] = collection.id
      ..['chapterIndex'] = chapterIndex;
    // Progress is a share of the *book*, and the book is now the collection.
    // Only progress records carry the field.
    if (record.containsKey('percentage')) {
      migrated['percentage'] = collection.poemCount == 0
          ? 0.0
          : (chapterIndex - 1) / collection.poemCount;
    }
    return migrated;
  }

  Future<List<BookModel>> loadCatalog() async {
    try {
      final results = await Future.wait([
        rootBundle.loadString('assets/data/grand_library_catalog.json'),
        loadLocalizedTitlesById('book_titles'),
      ]);
      final jsonString = results[0] as String;
      final localizedTitlesById =
          results[1] as Map<String, Map<String, String>>;
      final List<dynamic> list = jsonDecode(jsonString);
      _cachedCatalog = list.map((entry) {
        final json = Map<String, dynamic>.from(entry as Map);
        final embedded = localizedStringsFromJson(json['localizedTitles']);
        json['localizedTitles'] = {
          ...?localizedTitlesById[json['id']?.toString()],
          ...embedded,
        };
        return BookModel.fromJson(json);
      }).toList();
    } catch (e) {
      _cachedCatalog = [];
    }
    return _cachedCatalog;
  }

  Future<List<BookChapter>> getBookChapters(String bookId) async {
    // An author collection: one chapter per poem, in curated order. These
    // chapter numbers are exactly what `PoetryCollection.chapterIndexOf`
    // reports, which is what the reader and the migration both rely on.
    if (isPoetryAuthorBookId(bookId)) {
      await _ensurePoetryLoaded();
      final collection = _collectionById(bookId);
      if (collection == null) {
        throw StateError('Poetry collection was not found.');
      }
      return [
        for (var index = 0; index < collection.poems.length; index++)
          _chapterFromPoem(
            collection.poems[index],
            bookId: collection.id,
            chapterIndex: index + 1,
          ),
      ];
    }

    // A bare poem is still readable on its own — a legacy link, or a bookmark
    // written before collections — presented as a single-chapter book.
    if (isPoetryStoryId(bookId)) {
      await _ensurePoetryLoaded();
      for (final entry in _poetryEntries) {
        if (!poetryEntryMatchesId(entry, bookId)) continue;
        return [_chapterFromPoem(entry, bookId: bookId, chapterIndex: 1)];
      }
      throw StateError('Poetry entry was not found.');
    }

    return _downloadService.load(bookId);
  }

  /// [init] loads the poetry store, but a screen can reach the reader first on
  /// a cold path, so load on demand rather than serving nothing.
  Future<void> _ensurePoetryLoaded() async {
    if (_poetryEntries.isEmpty) await _loadPoetryEntries();
  }

  /// Builds one chapter from one poem. The chapter id **is** the poem id, which
  /// is what lets a migrated bookmark be traced back to the verse it marks.
  BookChapter _chapterFromPoem(
    Map<String, dynamic> poem, {
    required String bookId,
    required int chapterIndex,
  }) {
    final rawText = (poem['rawText'] as String? ?? '').trim();
    final sentences = rawText
        .split('\n')
        .where((line) => line.trim().isNotEmpty)
        .map((line) {
      final cleanLine = line.trim();
      return BookSentence(
        chinese: cleanLine,
        pinyin: PinyinHelper.getPinyinE(
          cleanLine,
          separator: ' ',
          format: PinyinFormat.WITH_TONE_MARK,
        ),
        english: '',
      );
    }).toList();
    final poemId = poetryEntryId(poem);
    return BookChapter(
      id: poemId,
      bookId: bookId,
      chapterIndex: chapterIndex,
      title: poem['title'] as String? ?? '诗篇',
      titleEn: poem['title_en'] as String? ?? 'Poem',
      localizedTitles: _poetryTitlesById[poemId] ?? const {},
      sentences: sentences,
    );
  }

  Future<bool> isBookDownloaded(String bookId) {
    if (isPoetryStoryId(bookId)) return Future.value(true);
    return _downloadService.isDownloaded(bookId);
  }

  Future<void> downloadBook(
    String bookId, {
    void Function(double progress)? onProgress,
  }) =>
      _downloadService.download(bookId, onProgress: onProgress);

  Future<void> removeDownloadedBook(String bookId) =>
      _downloadService.remove(bookId);

  int getReadingProgress(String bookId) {
    if (!Hive.isBoxOpen(_progressBoxName)) return 1;
    final box = Hive.box<dynamic>(_progressBoxName);
    final data = box.get(bookId);
    if (data is Map) {
      return (data['chapterIndex'] as int?) ?? 1;
    }
    return 1;
  }

  BookReadingProgress? getDetailedReadingProgress(String bookId) {
    if (!Hive.isBoxOpen(_progressBoxName)) return null;
    final box = Hive.box<dynamic>(_progressBoxName);
    final data = box.get(bookId);
    if (data is Map) {
      return BookReadingProgress.fromJson(Map<String, dynamic>.from(data));
    }
    return null;
  }

  List<Map<String, dynamic>> getAllInProgressBooksData() {
    if (!Hive.isBoxOpen(_progressBoxName)) return [];
    final box = Hive.box<dynamic>(_progressBoxName);
    final results = <Map<String, dynamic>>[];
    for (final key in box.keys) {
      final val = box.get(key);
      if (val is Map) {
        final map = Map<String, dynamic>.from(val);
        map['bookId'] = key.toString();
        results.add(map);
      }
    }
    // Sort by most recently updated
    results.sort((a, b) {
      final aDate = a['updatedAt']?.toString() ?? '';
      final bDate = b['updatedAt']?.toString() ?? '';
      return bDate.compareTo(aDate);
    });
    return results;
  }

  Future<void> saveReadingProgress({
    required String bookId,
    required int chapterIndex,
    int sentenceIndex = 0,
    double percentage = 0.0,
  }) async {
    if (!Hive.isBoxOpen(_progressBoxName)) return;
    final box = Hive.box<dynamic>(_progressBoxName);
    await box.put(bookId, {
      'bookId': bookId,
      'chapterIndex': chapterIndex,
      'sentenceIndex': sentenceIndex,
      'percentage': percentage,
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }

  // --- Bookmarks ---
  Future<void> saveBookmark(BookmarkModel bookmark) async {
    if (!Hive.isBoxOpen(_bookmarksBoxName)) return;
    final box = Hive.box<dynamic>(_bookmarksBoxName);
    final json = bookmark.toJson();
    json['bookId'] = _canonicalBookId(bookmark.bookId);
    await box.put(bookmark.id, json);
  }

  Future<void> removeBookmark(String bookmarkId) async {
    if (!Hive.isBoxOpen(_bookmarksBoxName)) return;
    final box = Hive.box<dynamic>(_bookmarksBoxName);
    await box.delete(bookmarkId);
  }

  List<BookmarkModel> getBookmarks(String bookId) {
    if (!Hive.isBoxOpen(_bookmarksBoxName)) return [];
    final box = Hive.box<dynamic>(_bookmarksBoxName);
    final bookmarks = <BookmarkModel>[];
    final canonicalBookId = _canonicalBookId(bookId);
    for (final val in box.values) {
      if (val is Map) {
        final bm = BookmarkModel.fromJson(Map<String, dynamic>.from(val));
        if (_canonicalBookId(bm.bookId) == canonicalBookId) {
          bookmarks.add(bm);
        }
      }
    }
    bookmarks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return bookmarks;
  }

  // --- Reading Sessions ---

  Future<void> saveReadingSession({
    required String bookId,
    required int chapterIndex,
    required int sentenceIndex,
    bool wasAudiobook = false,
  }) async {
    if (!Hive.isBoxOpen(_sessionBoxName)) return;
    final box = Hive.box<dynamic>(_sessionBoxName);
    await box.put(
        'last_session',
        ReadingSessionData(
          bookId: bookId,
          chapterIndex: chapterIndex,
          sentenceIndex: sentenceIndex,
          wasAudiobook: wasAudiobook,
          lastActiveTimestamp: DateTime.now(),
        ).toJson());
  }

  ReadingSessionData? getLastReadingSession() {
    if (!Hive.isBoxOpen(_sessionBoxName)) return null;
    final box = Hive.box<dynamic>(_sessionBoxName);
    final data = box.get('last_session');
    if (data == null) return null;
    return ReadingSessionData.fromJson(Map<String, dynamic>.from(data));
  }

  // --- Reading History (for streak calculation) ---

  Future<void> recordReadingEvent() async {
    if (!Hive.isBoxOpen(_readingHistoryBoxName)) return;
    final box = Hive.box<dynamic>(_readingHistoryBoxName);
    final todayKey =
        DateTime.now().toIso8601String().substring(0, 10); // YYYY-MM-DD
    await box.put(todayKey, DateTime.now().toIso8601String());
  }

  int getReadingStreak() {
    if (!Hive.isBoxOpen(_readingHistoryBoxName)) return 0;
    final box = Hive.box<dynamic>(_readingHistoryBoxName);
    int streak = 0;
    var checkDate = DateTime.now();
    while (true) {
      final key = checkDate.toIso8601String().substring(0, 10);
      if (box.containsKey(key)) {
        streak++;
        checkDate = checkDate.subtract(const Duration(days: 1));
      } else {
        // Allow yesterday to be missing only if we haven't read today yet
        if (streak == 0 && checkDate.day == DateTime.now().day) {
          checkDate = checkDate.subtract(const Duration(days: 1));
          continue;
        }
        break;
      }
    }
    return streak;
  }

  // --- All Bookmarks across all books ---

  List<Map<String, dynamic>> getAllBookmarksAcrossBooks() {
    final result = <Map<String, dynamic>>[];
    if (!Hive.isBoxOpen(_bookmarksBoxName)) return result;
    final box = Hive.box<dynamic>(_bookmarksBoxName);
    for (final val in box.values) {
      if (val is Map) {
        try {
          final bookmark = Map<String, dynamic>.from(val);
          final bookId = bookmark['bookId']?.toString() ?? '';
          bookmark['bookId'] = _canonicalBookId(bookId);
          result.add(bookmark);
        } catch (_) {}
      }
    }
    result.sort((a, b) {
      final aDate =
          DateTime.tryParse(a['createdAt'] as String? ?? '') ?? DateTime(2000);
      final bDate =
          DateTime.tryParse(b['createdAt'] as String? ?? '') ?? DateTime(2000);
      return bDate.compareTo(aDate);
    });
    return result;
  }
}
