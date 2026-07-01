enum StorySourceType {
  rss, // Option A (Web browser with Zen Mode)
  json, // Option B (Raw text for Reader Screen)
}

class LibraryStory {
  final String title;
  final String sourceName; // e.g. "Mandarin Bean" or "Public Domain Classic"
  final String link; // URL to the story (either webpage URL or JSON/TXT URL)
  final String? imageUrl;
  final String summary;
  final DateTime? pubDate;
  final StorySourceType sourceType;

  LibraryStory({
    required this.title,
    required this.sourceName,
    required this.link,
    this.imageUrl,
    required this.summary,
    this.pubDate,
    required this.sourceType,
  });

  LibraryStory copyWith({
    String? title,
    String? sourceName,
    String? link,
    String? imageUrl,
    String? summary,
    DateTime? pubDate,
    StorySourceType? sourceType,
  }) {
    return LibraryStory(
      title: title ?? this.title,
      sourceName: sourceName ?? this.sourceName,
      link: link ?? this.link,
      imageUrl: imageUrl ?? this.imageUrl,
      summary: summary ?? this.summary,
      pubDate: pubDate ?? this.pubDate,
      sourceType: sourceType ?? this.sourceType,
    );
  }
}
