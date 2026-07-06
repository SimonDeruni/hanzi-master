import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:hanzi_master/features/media/domain/models/daily_media_item.dart';

class DailyDiscoveryRepository {
  // A curated list of high-quality Chinese YouTube channels with their titles
  final Map<String, String> _channels = {
    'UC-O_hESCCmHj8qY6p-D-B6g': 'Mandarin Corner',
    'UCoC47do520osFaCG1YacMEA': '李子柒 Liziqi',
    'UCwYk4uL-I5dD9aY_L2E4Oyg': 'Grace Mandarin Chinese',
    'UC3y4-3hWqDXYk9h-T174gNA': 'ShuoshuoChinese',
    'UCPd3vXGz_6k2O-aN-TjA0jA': 'Peppa Pig Chinese',
  };

  Future<DailyMediaItem> getDailyVideo() async {
    final now = DateTime.now();
    final seed = "\${now.year}-\${now.month}-\${now.day}".hashCode;
    final random = Random(seed);
    
    final channelIds = _channels.keys.toList();
    final channelId = channelIds[random.nextInt(channelIds.length)];
    final channelTitle = _channels[channelId]!;

    final yt = YoutubeExplode();
    try {
      // getUploads fetches a batch of videos in one network request.
      final uploads = await yt.channels.getUploads(channelId).take(30).toList();
      
      if (uploads.isEmpty) throw Exception("No uploads found for channel.");
      
      final selectedVideo = uploads[random.nextInt(uploads.length)];
      
      return DailyMediaItem(
        title: selectedVideo.title,
        subtitle: channelTitle,
        url: selectedVideo.url,
        imageUrl: "https://img.youtube.com/vi/\${selectedVideo.id.value}/hqdefault.jpg",
        tag: "VIDEO OF THE DAY",
      );
    } catch (e) {
      // Fallback if API fails: cycle through a curated list
      return fallbackVideos[random.nextInt(fallbackVideos.length)];
    } finally {
      yt.close();
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
          
          // Try to extract thumbnail from media:thumbnail
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
      // Fallback
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
