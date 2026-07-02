enum StorySourceType {
  rss, // Option A (Web browser with Zen Mode)
  json, // Option B (Raw text for Reader Screen)
}

class LibraryStory {
  final String title;
  final String? titleEn;
  final String sourceName; // e.g. "Mandarin Bean" or "Public Domain Classic"
  final String link; // URL to the story (either webpage URL or JSON/TXT URL)
  final String? imageUrl;
  final String summary;
  final String? summaryEn;
  final DateTime? pubDate;
  final String category; // e.g. "Idioms", "News", "Fairy Tales"
  final StorySourceType sourceType;
  final int hskLevel; // 0 for Native/Classic, 1-6 for HSK levels
  final List<String> keywords;

  const LibraryStory({
    required this.title,
    this.titleEn,
    required this.sourceName,
    required this.link,
    this.imageUrl,
    required this.summary,
    this.summaryEn,
    this.pubDate,
    required this.category,
    required this.sourceType,
    this.hskLevel = 0,
    this.keywords = const [],
  });

  LibraryStory copyWith({
    String? title,
    String? titleEn,
    String? sourceName,
    String? link,
    String? imageUrl,
    String? summary,
    String? summaryEn,
    DateTime? pubDate,
    String? category,
    StorySourceType? sourceType,
    int? hskLevel,
  }) {
    return LibraryStory(
      title: title ?? this.title,
      titleEn: titleEn ?? this.titleEn,
      sourceName: sourceName ?? this.sourceName,
      link: link ?? this.link,
      imageUrl: imageUrl ?? this.imageUrl,
      summary: summary ?? this.summary,
      summaryEn: summaryEn ?? this.summaryEn,
      pubDate: pubDate ?? this.pubDate,
      category: category ?? this.category,
      sourceType: sourceType ?? this.sourceType,
      hskLevel: hskLevel ?? this.hskLevel,
    );
  }
}
