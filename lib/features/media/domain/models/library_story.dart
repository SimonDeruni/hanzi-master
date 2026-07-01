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
}
