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
    final daysSinceEpoch = DateTime.now().difference(DateTime(2020)).inDays;
    final channelIds = _channels.keys.toList();
    final channelId = channelIds[daysSinceEpoch % channelIds.length];
    final channelTitle = _channels[channelId]!;

    final yt = YoutubeExplode();
    try {
      // getUploads fetches a batch of videos in one network request.
      final uploads = await yt.channels.getUploads(channelId).take(30).toList();
      
      if (uploads.isEmpty) throw Exception("No uploads found for channel.");
      
      // Cycle through the most recent 30 uploads so the video is always fresh
      // even if the channel hasn't uploaded recently.
      final videoIndex = (daysSinceEpoch ~/ channelIds.length) % uploads.length;
      final selectedVideo = uploads[videoIndex];
      
      return DailyMediaItem(
        title: selectedVideo.title,
        subtitle: channelTitle,
        url: selectedVideo.url,
        imageUrl: "https://img.youtube.com/vi/\${selectedVideo.id.value}/hqdefault.jpg",
        tag: "VIDEO OF THE DAY",
      );
    } catch (e) {
      // Fallback if API fails
      return DailyMediaItem(
        title: "李子柒 Liziqi: 大蒜的一生",
        subtitle: "The Life of Garlic - Traditional Chinese Life",
        url: "https://www.youtube.com/watch?v=gcShBujgsIQ",
        imageUrl: "https://img.youtube.com/vi/gcShBujgsIQ/hqdefault.jpg",
        tag: "2 MIN CULTURAL CONTEXT",
      );
    } finally {
      yt.close();
    }
  }

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
