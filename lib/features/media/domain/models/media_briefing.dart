class MediaBriefing {
  final String summary;
  final List<String> hardWords;
  final String? localizedTitle;

  MediaBriefing({
    required this.summary,
    required this.hardWords,
    this.localizedTitle,
  });

  String displayTitle(String fallbackTitle) {
    final title = localizedTitle?.trim();
    return title == null || title.isEmpty ? fallbackTitle : title;
  }

  factory MediaBriefing.fromJson(Map<String, dynamic> json) {
    return MediaBriefing(
      summary: json['summary']?.toString() ?? '',
      hardWords: List<String>.from(json['hardWords'] ?? []),
      localizedTitle: json['localizedTitle']?.toString(),
    );
  }
}
