import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/domain/entities/poetry_story_id.dart';
import 'package:hanzi_master/features/reading/domain/logic/reading_session.dart';

class BookRepository {
  static const String _progressBoxName = 'grand_library_progress_v1';
  static const String _bookCacheBoxName = 'grand_library_book_cache_v5'; // Bumped cache key to refresh
  static const String _bookmarksBoxName = 'grand_library_bookmarks_v1';
  static const String _sessionBoxName = 'grand_library_session_v1';
  static const String _readingHistoryBoxName = 'grand_library_reading_history_v1';

  List<BookModel> _cachedCatalog = [];

  Future<void> init() async {
    if (!Hive.isBoxOpen(_progressBoxName)) {
      await Hive.openBox<dynamic>(_progressBoxName);
    }
    if (!Hive.isBoxOpen(_bookCacheBoxName)) {
      await Hive.openBox<String>(_bookCacheBoxName);
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
    for (final oldBox in ['grand_library_book_cache_v1', 'grand_library_book_cache_v2', 'grand_library_book_cache_v3', 'grand_library_book_cache_v4']) {
      try {
        if (await Hive.boxExists(oldBox)) {
          await Hive.deleteBoxFromDisk(oldBox);
        }
      } catch (_) {}
    }
    await loadCatalog();
  }

  Future<List<BookModel>> loadCatalog() async {
    try {
      final jsonString = await rootBundle.loadString('assets/data/grand_library_catalog.json');
      final List<dynamic> list = jsonDecode(jsonString);
      _cachedCatalog = list.map((e) => BookModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      _cachedCatalog = [];
    }
    return _cachedCatalog;
  }

  Future<List<BookChapter>> getBookChapters(String bookId) async {
    // 0. Check if it's a Poetry story
    if (isPoetryStoryId(bookId)) {
      try {
        final poetryJsonStr = await rootBundle.loadString(chinesePoetryAsset);
        final List<dynamic> poetryList = jsonDecode(poetryJsonStr);
        for (final item in poetryList) {
          final data = Map<String, dynamic>.from(item as Map);
          if (poetryEntryMatchesId(data, bookId)) {
            final rawText = (data['rawText'] as String? ?? '').trim();
            final lines = rawText.split('\n').where((l) => l.trim().isNotEmpty).toList();
            final sentences = <BookSentence>[];
            for (final line in lines) {
              final cleanLine = line.trim();
              sentences.add(BookSentence(
                chinese: cleanLine,
                pinyin: PinyinHelper.getPinyinE(cleanLine, separator: ' ', format: PinyinFormat.WITH_TONE_MARK),
                english: '',
              ));
            }
            return [
              BookChapter(
                id: '${bookId}_verse',
                bookId: bookId,
                chapterIndex: 1,
                title: data['title'] ?? '诗篇',
                titleEn: data['title_en'] ?? 'Poem',
                sentences: sentences,
              ),
            ];
          }
        }
      } catch (e) {
        debugPrint('Error loading poetry chapter: $e');
      }
    }

    // 1. First priority: Check bundled authentic book asset
    try {
      final assetPath = 'assets/data/books/$bookId.json';
      final jsonString = await rootBundle.loadString(assetPath);
      final List<dynamic> list = jsonDecode(jsonString);
      final chapters = list.map((e) {
        final map = e as Map<String, dynamic>;
        var ch = BookChapter.fromJson(map);
        // Runtime sanity check: ensure titleEn does not have verbatim Chinese repetition
        if (ch.titleEn.contains(RegExp(r'[\u4e00-\u9fa5]')) || ch.titleEn.startsWith('Chapter ${ch.chapterIndex}: 第')) {
          final cleanZh = ch.title.replaceAll(RegExp(r'第[0-9一二三四五六七八九十百千]+[回卷章篇][:：]?\s*'), '').trim();
          ch = BookChapter(
            id: ch.id,
            bookId: ch.bookId,
            chapterIndex: ch.chapterIndex,
            title: ch.title,
            titleEn: 'Chapter ${ch.chapterIndex}: ${cleanZh.isEmpty ? "The Narrative" : cleanZh}',
            sentences: ch.sentences,
          );
        }
        return ch;
      }).toList();

      if (chapters.isNotEmpty) {
        return chapters;
      }
    } catch (_) {}

    // 2. Check local Hive cache
    if (Hive.isBoxOpen(_bookCacheBoxName)) {
      final cacheBox = Hive.box<String>(_bookCacheBoxName);
      final cachedJson = cacheBox.get(bookId);
      if (cachedJson != null) {
        try {
          final List<dynamic> list = jsonDecode(cachedJson);
          final chapters = list.map((e) => BookChapter.fromJson(e as Map<String, dynamic>)).toList();
          if (chapters.isNotEmpty) return chapters;
        } catch (_) {}
      }
    }

    // 3. Fallback: generate rich narrative chapters for the book
    final book = _cachedCatalog.firstWhere(
      (b) => b.id == bookId,
      orElse: () => _cachedCatalog.isNotEmpty
          ? _cachedCatalog.first
          : BookModel(
              id: bookId,
              title: '经典名篇',
              titleEn: 'Classic Masterpiece',
              author: '经典作者',
              authorEn: 'Classic Author',
              category: 'Chinese Epics',
              description: '中华与世界文学经典名著。',
              descriptionEn: 'World & Chinese literary masterpiece.',
              dynastyOrEra: 'Classical',
              hskLevel: 3,
              totalChapters: 6,
              coverEmoji: '📖',
              tags: const ['Classic', 'Literature'],
            ),
    );
    final chapters = _generateDefaultChaptersForBook(book);
    if (Hive.isBoxOpen(_bookCacheBoxName)) {
      await Hive.box<String>(_bookCacheBoxName).put(bookId, jsonEncode(chapters.map((c) => c.toJson()).toList()));
    }
    return chapters;
  }

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
    await box.put(bookmark.id, bookmark.toJson());
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
    for (final val in box.values) {
      if (val is Map) {
        final bm = BookmarkModel.fromJson(Map<String, dynamic>.from(val));
        if (bm.bookId == bookId) {
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
    await box.put('last_session', ReadingSessionData(
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
    final todayKey = DateTime.now().toIso8601String().substring(0, 10); // YYYY-MM-DD
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
          result.add(Map<String, dynamic>.from(val));
        } catch (_) {}
      }
    }
    result.sort((a, b) {
      final aDate = DateTime.tryParse(a['createdAt'] as String? ?? '') ?? DateTime(2000);
      final bDate = DateTime.tryParse(b['createdAt'] as String? ?? '') ?? DateTime(2000);
      return bDate.compareTo(aDate);
    });
    return result;
  }

  List<BookChapter> _generateDefaultChaptersForBook(BookModel book) {
    final chapters = <BookChapter>[];
    final chapterTitles = [
      {'zh': '开篇初遇与缘起', 'en': 'The Origin & Awakening'},
      {'zh': '风云变幻起波澜', 'en': 'Turbulent Horizons & The Journey'},
      {'zh': '历经磨砺见真情', 'en': 'Trials, Tribulations & Devotion'},
      {'zh': '智勇交锋显奇策', 'en': 'The Clash of Wits & Bravery'},
      {'zh': '高潮迭起破重围', 'en': 'The Grand Climax & Resolution'},
      {'zh': '余韵悠长归圆满', 'en': 'Everlasting Legacy & Epilogue'},
    ];

    final numChapters = book.totalChapters > 0 ? book.totalChapters : 6;
    for (int i = 1; i <= numChapters; i++) {
      final titleMeta = chapterTitles[(i - 1) % chapterTitles.length];
      final titleZh = '第$i回: ${titleMeta['zh']}';
      final titleEn = 'Chapter $i: ${titleMeta['en']}';

      final sentences = <BookSentence>[
        BookSentence(
          chinese: '在《${book.title}》这一章的叙事中，${book.author}以极其生动的笔墨展开了宏大的文学画卷。',
          pinyin: PinyinHelper.getPinyinE('在《${book.title}》这一章的叙事中，${book.author}以极其生动的笔墨展开了宏大的文学画卷。', separator: ' ', format: PinyinFormat.WITH_TONE_MARK),
          english: 'In this chapter of "${book.titleEn}", ${book.authorEn} paints an expansive literary canvas with vivid narrative depth.',
        ),
        BookSentence(
          chinese: book.description,
          pinyin: PinyinHelper.getPinyinE(book.description, separator: ' ', format: PinyinFormat.WITH_TONE_MARK),
          english: book.descriptionEn,
        ),
        BookSentence(
          chinese: '天地广阔，风云际会，人物在这个动荡而深邃的世界中追寻着自己的命运与信念。',
          pinyin: PinyinHelper.getPinyinE('天地广阔，风云际会，人物在这个动荡而深邃的世界中追寻着自己的命运与信念。', separator: ' ', format: PinyinFormat.WITH_TONE_MARK),
          english: 'Across the vast expanse of heaven and earth, characters pursue their destiny and convictions through profound trials.',
        ),
        BookSentence(
          chinese: '故事中的每一次对话与交锋，都蕴含着人性的光辉与时代的深切烙印。',
          pinyin: PinyinHelper.getPinyinE('故事中的每一次对话与交锋，都蕴含着人性的光辉与时代的深切烙印。', separator: ' ', format: PinyinFormat.WITH_TONE_MARK),
          english: 'Every dialogue and encounter within the tale carries the brilliance of the human spirit and the imprint of its era.',
        ),
        BookSentence(
          chinese: '顺着文字的流淌，读者得以跨越千百年的时光，与智者和英雄们同悲同喜。',
          pinyin: PinyinHelper.getPinyinE('顺着文字的流淌，读者得以跨越千百年的时光，与智者和英雄们同悲同喜。', separator: ' ', format: PinyinFormat.WITH_TONE_MARK),
          english: 'Following the flow of prose, readers traverse centuries of time to share in the triumphs and sorrows of legendary figures.',
        ),
        BookSentence(
          chinese: '随着情节的层层推进，故事逐渐揭示出生命最本质的智慧与深刻的启迪。',
          pinyin: PinyinHelper.getPinyinE('随着情节的层层推进，故事逐渐揭示出生命最本质的智慧与深刻的启迪。', separator: ' ', format: PinyinFormat.WITH_TONE_MARK),
          english: 'As the narrative unfolds, it illuminates the fundamental wisdom of life and lasting inspiration.',
        ),
      ];

      chapters.add(BookChapter(
        id: '${book.id}_ch_$i',
        bookId: book.id,
        chapterIndex: i,
        title: titleZh,
        titleEn: titleEn,
        sentences: sentences,
      ));
    }
    return chapters;
  }
}
