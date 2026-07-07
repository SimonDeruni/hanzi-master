import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:hanzi_master/features/media/domain/models/daily_media_item.dart';

class DailyDiscoveryRepository {
  static const int _channelsToFetch = 5;
  static const int _maxVideosPerChannel = 3;

  static const Map<String, String> _channelPool = {
    'UCoC47do520osFaCG1YacMEA': '李子柒 Liziqi',
    'UC4R1p5m2sLhD5IysM9F5vzg': '美食作家王刚',
    'UCQ_RJN2yW42jqXIGK2VKIPw': '小高姐的魔法料理',
    'UCJA2N5BTeiEepZxQZJ6KLYw': '日食记',
    'UC5HcJx5GvGmQH7hMB6yJv4g': '绵羊料理',
    'UCfXmR5lU1Rz7GEdwFv4Yj3g': '影视飓风',
    'UCt5Oy7RQlS1FK2a0a1f7Ywg': '毕导',
    'UCj7wKsP6Y_G2F0U3h0V6mBg': '小Lin说',
    'UCB1AtKqZqVb1oZwVZsQmzYg': '老师好我叫何同学',
    'UCnS9mPbLZOuGjSoV90S8PVA': '你好竹子',
    'UC1SnPt6sSHbaqCztp8f3MpQ': '小鹿Lawrence',
    'UCt4t3iY8hL5sF5pV6qW2xRg': '手工耿',
    'UCp8q9rL2jG5hV7xW3mR5bNQ': '星球研究所',
    'UCvZ9W7u3T6a5YJS0VT-28oA': '滇西小哥',
    'UCjqGZKJ5gY5X7hq8m9L2eZQ': '厨师长农国栋',
    'UCp5Q1s2m8GmG3t5Qc4vL2iA': '大象放映室',
    'UCm7yM8rL5jG5pV6qW3xR2bQ': '戴建业',
  };

  Future<({DailyMediaItem item, String videoId})> getDailyVideo({
    required List<String> shownVideoIds,
  }) async {
    final now = DateTime.now();
    final seed = '${now.year}-${now.month}-${now.day}'.hashCode;
    final random = Random(seed);

    final channelEntries = _channelPool.entries.toList();
    final selected = [...channelEntries]..shuffle(random);
    final batch = selected.take(_channelsToFetch);

    final feeds = await Future.wait(
      batch.map((entry) => _fetchChannelVideos(entry.key, entry.value)),
    );

    final candidates = <_VideoCandidate>[];
    for (final feed in feeds) {
      candidates.addAll(feed);
    }
    candidates.shuffle(random);

    final unseen = candidates.where((c) => !shownVideoIds.contains(c.videoId)).toList();
    final pool = unseen.isNotEmpty ? unseen : candidates;

    for (final candidate in pool) {
      final thumbUri = Uri.parse('https://img.youtube.com/vi/${candidate.videoId}/hqdefault.jpg');
      try {
        final head = await http.head(thumbUri).timeout(const Duration(seconds: 3));
        if (head.statusCode == 200) {
          return (
            item: DailyMediaItem(
              title: candidate.title,
              subtitle: candidate.channelName,
              url: 'https://www.youtube.com/watch?v=${candidate.videoId}',
              imageUrl: thumbUri.toString(),
              tag: 'VIDEO OF THE DAY',
            ),
            videoId: candidate.videoId,
          );
        }
      } catch (_) {
        continue;
      }
    }

    throw Exception('No valid video found.');
  }

  Future<List<_VideoCandidate>> _fetchChannelVideos(String channelId, String channelName) async {
    try {
      final response = await http
          .get(Uri.parse('https://www.youtube.com/feeds/videos.xml?channel_id=$channelId'))
          .timeout(const Duration(seconds: 6));
      if (response.statusCode != 200) return [];

      final doc = XmlDocument.parse(response.body);
      final entries = doc.findAllElements('entry').take(_maxVideosPerChannel);
      return entries.map((e) {
        final videoId = e.findElements('yt:videoId').first.innerText;
        final title = e.findElements('title').first.innerText;
        return _VideoCandidate(videoId: videoId, title: title, channelName: channelName);
      }).toList();
    } catch (_) {
      return [];
    }
  }

  static final List<DailyMediaItem> fallbackVideos = [
    DailyMediaItem(
      title: "李子柒 Liziqi: 大蒜的一生",
      subtitle: "The Life of Garlic - Traditional Chinese Life",
      url: "https://www.youtube.com/watch?v=gcShBujgsIQ",
      imageUrl: "https://img.youtube.com/vi/gcShBujgsIQ/0.jpg",
      tag: "2 MIN CULTURAL CONTEXT",
    ),
    DailyMediaItem(
      title: "Mandarin Corner: Supermarket",
      subtitle: "Learn Chinese in the Supermarket",
      url: "https://www.youtube.com/watch?v=rY0_A32XnSg",
      imageUrl: "https://img.youtube.com/vi/rY0_A32XnSg/0.jpg",
      tag: "VOCABULARY",
    ),
    DailyMediaItem(
      title: "Grace Mandarin: 50 Phrases",
      subtitle: "Essential Chinese Phrases for Beginners",
      url: "https://www.youtube.com/watch?v=vV0222xP9uM",
      imageUrl: "https://img.youtube.com/vi/vV0222xP9uM/hqdefault.jpg",
      tag: "ESSENTIALS",
    ),
    DailyMediaItem(
      title: "李子柒 Liziqi: 竹子家具",
      subtitle: "Making Bamboo Furniture",
      url: "https://www.youtube.com/watch?v=Yf0vP1tN8-w",
      imageUrl: "https://img.youtube.com/vi/Yf0vP1tN8-w/hqdefault.jpg",
      tag: "2 MIN CULTURAL CONTEXT",
    ),
    DailyMediaItem(
      title: "Peppa Pig Chinese: 泥坑",
      subtitle: "Muddy Puddles - Beginner Friendly",
      url: "https://www.youtube.com/watch?v=LqAObK1tE9w",
      imageUrl: "https://img.youtube.com/vi/LqAObK1tE9w/hqdefault.jpg",
      tag: "LISTENING PRACTICE",
    ),
    DailyMediaItem(
      title: "ShuoshuoChinese: Real Chinese Speaking",
      subtitle: "Street Interviews in China",
      url: "https://www.youtube.com/watch?v=mF_u4s98vT8",
      imageUrl: "https://img.youtube.com/vi/mF_u4s98vT8/hqdefault.jpg",
      tag: "REAL LIFE",
    ),
    DailyMediaItem(
      title: "Mandarin Corner: 300 Verbs",
      subtitle: "Most Common Chinese Verbs",
      url: "https://www.youtube.com/watch?v=_p-h-VdM-s0",
      imageUrl: "https://img.youtube.com/vi/_p-h-VdM-s0/hqdefault.jpg",
      tag: "VOCABULARY",
    ),
    DailyMediaItem(
      title: "Grace Mandarin: Order Food",
      subtitle: "How to order food in a Chinese restaurant",
      url: "https://www.youtube.com/watch?v=b4O0Z4qD-x8",
      imageUrl: "https://img.youtube.com/vi/b4O0Z4qD-x8/hqdefault.jpg",
      tag: "SOCIAL SKILLS",
    ),
    DailyMediaItem(
      title: "李子柒 Liziqi: 绢花",
      subtitle: "Silk Flowers - Traditional Craft",
      url: "https://www.youtube.com/watch?v=pY-5X9Z5O3E",
      imageUrl: "https://img.youtube.com/vi/pY-5X9Z5O3E/0.jpg",
      tag: "CULTURAL CONTEXT",
    ),
    DailyMediaItem(
      title: "Peppa Pig Chinese: 躲猫猫",
      subtitle: "Hide and Seek - Beginner Friendly",
      url: "https://www.youtube.com/watch?v=hB9K3G0mR3g",
      imageUrl: "https://img.youtube.com/vi/hB9K3G0mR3g/hqdefault.jpg",
      tag: "LISTENING PRACTICE",
    ),
  ];

  Future<DailyMediaItem> getDailyArticle() async {
    try {
      final response = await http.get(Uri.parse('https://feeds.bbci.co.uk/zhongwen/simp/rss.xml'))
          .timeout(const Duration(seconds: 4));
      if (response.statusCode == 200) {
        final document = XmlDocument.parse(response.body);
        final items = document.findAllElements('item');
        if (items.isNotEmpty) {
          final firstItem = items.first;
          final title = firstItem.findElements('title').first.innerText;
          final link = firstItem.findElements('link').first.innerText;

          String imageUrl = "https://www.bbc.co.uk/news/special/2015/newsspec_10857/bbc_news_logo.png";
          final mediaThumbnails = firstItem.findElements('media:thumbnail');
          if (mediaThumbnails.isNotEmpty) {
            imageUrl = mediaThumbnails.first.getAttribute('url') ?? imageUrl;
          }

          return DailyMediaItem(
            title: title,
            subtitle: "BBC 中文 (World News)",
            url: link,
            imageUrl: imageUrl,
            tag: "ARTICLE OF THE DAY",
          );
        }
      }
      throw Exception("Failed to load or parse RSS feed.");
    } catch (e) {
      return DailyMediaItem(
        title: "BBC 中文网",
        subtitle: "Current Events in Simplified Chinese",
        url: "https://www.bbc.com/zhongwen/simp",
        imageUrl: "https://ichef.bbci.co.uk/news/1024/branded_zhongwen/154F3/production/_115651738_1.jpg",
        tag: "2 MIN CULTURAL CONTEXT",
      );
    }
  }
}

class _VideoCandidate {
  final String videoId;
  final String title;
  final String channelName;
  _VideoCandidate({required this.videoId, required this.title, required this.channelName});
}
