import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/domain/entities/poetry_story_id.dart';
import 'package:hanzi_master/features/reading/domain/logic/reading_session.dart';
import 'package:hanzi_master/features/reading/data/services/book_download_service.dart';

class BookRepository {
  static const String _progressBoxName = 'grand_library_progress_v1';
  static const String _bookCacheBoxName = 'grand_library_book_cache_v5';
  static const String _bookmarksBoxName = 'grand_library_bookmarks_v1';
  static const String _sessionBoxName = 'grand_library_session_v1';
  static const String _readingHistoryBoxName =
      'grand_library_reading_history_v1';

  List<BookModel> _cachedCatalog = [];
  List<Map<String, dynamic>> _poetryEntries = [];
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
    await loadCatalog();
  }

  Future<void> _loadPoetryEntries() async {
    try {
      final content = await rootBundle.loadString(chinesePoetryAsset);
      final entries = jsonDecode(content) as List<dynamic>;
      _poetryEntries = entries
          .map((entry) => Map<String, dynamic>.from(entry as Map))
          .toList();
    } catch (_) {
      _poetryEntries = [];
    }
  }

  String _canonicalBookId(String bookId) =>
      canonicalPoetryId(_poetryEntries, bookId) ?? bookId;

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

  Future<List<BookModel>> loadCatalog() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/grand_library_catalog.json');
      final List<dynamic> list = jsonDecode(jsonString);
      _cachedCatalog = list
          .map((e) => BookModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _cachedCatalog = [];
    }
    return _cachedCatalog;
  }

  Future<List<BookChapter>> getBookChapters(String bookId) async {
    if (isPoetryStoryId(bookId)) {
      final poetryJsonStr = await rootBundle.loadString(chinesePoetryAsset);
      final List<dynamic> poetryList = jsonDecode(poetryJsonStr);
      for (final item in poetryList) {
        final data = Map<String, dynamic>.from(item as Map);
        if (!poetryEntryMatchesId(data, bookId)) continue;
        final rawText = (data['rawText'] as String? ?? '').trim();
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
        return [
          BookChapter(
            id: '${bookId}_verse',
            bookId: bookId,
            chapterIndex: 1,
            title: data['title'] as String? ?? '诗篇',
            titleEn: data['title_en'] as String? ?? 'Poem',
            sentences: sentences,
          ),
        ];
      }
      throw StateError('Poetry entry was not found.');
    }

    return _downloadService.load(bookId);
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
