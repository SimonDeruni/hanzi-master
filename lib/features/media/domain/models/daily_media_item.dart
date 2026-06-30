class DailyMediaItem {
  final String title;
  final String subtitle;
  final String url;
  final String imageUrl;
  final String tag;

  DailyMediaItem({
    required this.title,
    required this.subtitle,
    required this.url,
    required this.imageUrl,
    required this.tag,
  });

  factory DailyMediaItem.fromJson(Map<String, dynamic> json) {
    return DailyMediaItem(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      url: json['url'] as String,
      imageUrl: json['imageUrl'] as String,
      tag: json['tag'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'url': url,
      'imageUrl': imageUrl,
      'tag': tag,
    };
  }
}
