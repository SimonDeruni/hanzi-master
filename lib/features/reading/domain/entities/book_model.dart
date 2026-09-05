import 'package:equatable/equatable.dart';

class BookSentence extends Equatable {
  final String chinese;
  final String pinyin;
  final String english;

  const BookSentence({
    required this.chinese,
    required this.pinyin,
    required this.english,
  });

  factory BookSentence.fromJson(Map<String, dynamic> json) {
    return BookSentence(
      chinese: json['chinese'] as String? ?? '',
      pinyin: json['pinyin'] as String? ?? '',
      english: json['english'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'chinese': chinese,
        'pinyin': pinyin,
        'english': english,
      };

  @override
  List<Object?> get props => [chinese, pinyin, english];
}

class BookChapter extends Equatable {
  final String id;
  final String bookId;
  final int chapterIndex;
  final String title;
  final String titleEn;
  final Map<String, String> localizedTitles;
  final List<BookSentence> sentences;
  final String? audioStreamUrl;

  const BookChapter({
    required this.id,
    required this.bookId,
    required this.chapterIndex,
    required this.title,
    required this.titleEn,
    this.localizedTitles = const {},
    required this.sentences,
    this.audioStreamUrl,
  });

  factory BookChapter.fromJson(Map<String, dynamic> json) {
    return BookChapter(
      id: json['id'] as String? ?? '',
      bookId: json['bookId'] as String? ?? '',
      chapterIndex: json['chapterIndex'] as int? ?? 1,
      title: json['title'] as String? ?? '',
      titleEn: json['titleEn'] as String? ?? '',
      localizedTitles: _localizedStringsFromJson(json['localizedTitles']),
      sentences: (json['sentences'] as List<dynamic>?)
              ?.map((e) => BookSentence.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      audioStreamUrl: json['audioStreamUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'bookId': bookId,
        'chapterIndex': chapterIndex,
        'title': title,
        'titleEn': titleEn,
        if (localizedTitles.isNotEmpty) 'localizedTitles': localizedTitles,
        'sentences': sentences.map((s) => s.toJson()).toList(),
        if (audioStreamUrl != null) 'audioStreamUrl': audioStreamUrl,
      };

  @override
  List<Object?> get props => [
        id,
        bookId,
        chapterIndex,
        title,
        titleEn,
        localizedTitles,
        sentences,
        audioStreamUrl,
      ];

  String localizedTitle(String localeCode) =>
      localizedValue(localizedTitles, localeCode, titleEn,
          chineseFallback: title);
}

class BookModel extends Equatable {
  final String id;
  final String title;
  final String titleEn;
  final Map<String, String> localizedTitles;
  final String author;
  final String authorEn;
  final Map<String, String> localizedAuthors;
  final String category;
  final String description;
  final String descriptionEn;
  final String dynastyOrEra;
  final int hskLevel;
  final int totalChapters;
  final String coverEmoji;
  final List<String> tags;
  final String? audioStreamUrl;

  const BookModel({
    required this.id,
    required this.title,
    required this.titleEn,
    this.localizedTitles = const {},
    required this.author,
    required this.authorEn,
    this.localizedAuthors = const {},
    required this.category,
    required this.description,
    required this.descriptionEn,
    required this.dynastyOrEra,
    required this.hskLevel,
    required this.totalChapters,
    required this.coverEmoji,
    required this.tags,
    this.audioStreamUrl,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      titleEn: json['titleEn'] as String? ?? '',
      localizedTitles: _localizedStringsFromJson(json['localizedTitles']),
      author: json['author'] as String? ?? '',
      authorEn: json['authorEn'] as String? ?? '',
      localizedAuthors: _localizedStringsFromJson(json['localizedAuthors']),
      category: json['category'] as String? ?? 'General',
      description: json['description'] as String? ?? '',
      descriptionEn: json['descriptionEn'] as String? ?? '',
      dynastyOrEra: json['dynastyOrEra'] as String? ?? '',
      hskLevel: json['hskLevel'] as int? ?? 1,
      totalChapters: json['totalChapters'] as int? ?? 1,
      coverEmoji: json['coverEmoji'] as String? ?? '📖',
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ??
              [],
      audioStreamUrl: json['audioStreamUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'titleEn': titleEn,
        if (localizedTitles.isNotEmpty) 'localizedTitles': localizedTitles,
        'author': author,
        'authorEn': authorEn,
        if (localizedAuthors.isNotEmpty) 'localizedAuthors': localizedAuthors,
        'category': category,
        'description': description,
        'descriptionEn': descriptionEn,
        'dynastyOrEra': dynastyOrEra,
        'hskLevel': hskLevel,
        'totalChapters': totalChapters,
        'coverEmoji': coverEmoji,
        'tags': tags,
        if (audioStreamUrl != null) 'audioStreamUrl': audioStreamUrl,
      };

  @override
  List<Object?> get props => [
        id,
        title,
        titleEn,
        localizedTitles,
        author,
        authorEn,
        localizedAuthors,
        category,
        description,
        descriptionEn,
        dynastyOrEra,
        hskLevel,
        totalChapters,
        coverEmoji,
        tags,
      ];

  String localizedTitle(String localeCode) =>
      localizedValue(localizedTitles, localeCode, titleEn,
          chineseFallback: title);

  String localizedAuthor(String localeCode) =>
      localizedValue(localizedAuthors, localeCode, authorEn,
          chineseFallback: author);

  static Map<String, String> _localizedStringsFromJson(Object? value) {
    return localizedStringsFromJson(value);
  }
}

Map<String, String> _localizedStringsFromJson(Object? value) =>
    localizedStringsFromJson(value);

Map<String, String> localizedStringsFromJson(Object? value) {
  if (value is! Map) return const {};
  return Map.unmodifiable(
    value.map(
      (key, value) => MapEntry(key.toString(), value.toString()),
    )..removeWhere((key, value) => value.trim().isEmpty),
  );
}

String localizedValue(
  Map<String, String> values,
  String localeCode,
  String fallback, {
  String? chineseFallback,
}) {
  final normalizedLocale = localeCode.replaceAll('-', '_').toLowerCase();
  final languageCode = normalizedLocale.split('_').first;
  if (languageCode == 'zh' && chineseFallback != null) {
    return chineseFallback;
  }
  return values[normalizedLocale] ?? values[languageCode] ?? fallback;
}

class BookmarkModel extends Equatable {
  final String id;
  final String bookId;
  final int chapterIndex;
  final int sentenceIndex;
  final String snippetChinese;
  final String snippetEnglish;
  final DateTime createdAt;

  const BookmarkModel({
    required this.id,
    required this.bookId,
    required this.chapterIndex,
    required this.sentenceIndex,
    required this.snippetChinese,
    required this.snippetEnglish,
    required this.createdAt,
  });

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      id: json['id'] as String? ?? '',
      bookId: json['bookId'] as String? ?? '',
      chapterIndex: json['chapterIndex'] as int? ?? 1,
      sentenceIndex: json['sentenceIndex'] as int? ?? 0,
      snippetChinese: json['snippetChinese'] as String? ?? '',
      snippetEnglish: json['snippetEnglish'] as String? ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'bookId': bookId,
        'chapterIndex': chapterIndex,
        'sentenceIndex': sentenceIndex,
        'snippetChinese': snippetChinese,
        'snippetEnglish': snippetEnglish,
        'createdAt': createdAt.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        bookId,
        chapterIndex,
        sentenceIndex,
        snippetChinese,
        snippetEnglish,
        createdAt
      ];
}

class BookReadingProgress extends Equatable {
  final String bookId;
  final int chapterIndex;
  final int sentenceIndex;
  final double percentage;
  final DateTime updatedAt;

  const BookReadingProgress({
    required this.bookId,
    required this.chapterIndex,
    this.sentenceIndex = 0,
    this.percentage = 0.0,
    required this.updatedAt,
  });

  factory BookReadingProgress.fromJson(Map<String, dynamic> json) {
    return BookReadingProgress(
      bookId: json['bookId'] as String? ?? '',
      chapterIndex: json['chapterIndex'] as int? ?? 1,
      sentenceIndex: json['sentenceIndex'] as int? ?? 0,
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'bookId': bookId,
        'chapterIndex': chapterIndex,
        'sentenceIndex': sentenceIndex,
        'percentage': percentage,
        'updatedAt': updatedAt.toIso8601String(),
      };

  @override
  List<Object?> get props =>
      [bookId, chapterIndex, sentenceIndex, percentage, updatedAt];
}
