import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hanzi_master/features/media/domain/models/daily_media_item.dart';
import 'package:hanzi_master/features/media/data/repositories/daily_discovery_repository.dart';

part 'daily_discovery_provider.g.dart';

@riverpod
class DailyDiscovery extends _$DailyDiscovery {
  @override
  Future<List<DailyMediaItem>> build() async {
    final repo = DailyDiscoveryRepository();
    
    // Fetch both simultaneously with a 5-second timeout to prevent hanging
    final results = await Future.wait([
      repo.getDailyVideo().timeout(
        const Duration(seconds: 8),
        onTimeout: () => DailyMediaItem(
          title: "李子柒 Liziqi: 大蒜的一生",
          subtitle: "The Life of Garlic - Traditional Chinese Life",
          url: "https://www.youtube.com/watch?v=1d_K6O9cQ8s",
          imageUrl: "https://img.youtube.com/vi/1d_K6O9cQ8s/hqdefault.jpg",
          tag: "2 MIN CULTURAL CONTEXT",
        ),
      ),
      repo.getDailyArticle().timeout(
        const Duration(seconds: 5),
        onTimeout: () => DailyMediaItem(
          title: "BBC 中文网",
          subtitle: "Current Events in Simplified Chinese",
          url: "https://www.bbc.com/zhongwen/simp",
          imageUrl: "https://www.bbc.co.uk/news/special/2015/newsspec_10857/bbc_news_logo.png",
          tag: "2 MIN CULTURAL CONTEXT",
        ),
      ),
    ]);
    
    return results;
  }
}
