class MediaBriefing {
  final String summary;
  final List<String> hardWords;

  MediaBriefing({
    required this.summary,
    required this.hardWords,
  });

  factory MediaBriefing.fromJson(Map<String, dynamic> json) {
    return MediaBriefing(
      summary: json['summary'] ?? '',
      hardWords: List<String>.from(json['hardWords'] ?? []),
    );
  }
}
