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
        const Duration(seconds: 5),
        onTimeout: () => DailyMediaItem(
          title: "CCTV-4 Live News",
          subtitle: "Chinese National Television",
          url: "https://www.youtube.com/watch?v=kYc5F3D172M",
          imageUrl: "https://img.youtube.com/vi/kYc5F3D172M/maxresdefault.jpg",
          tag: "VIDEO OF THE DAY",
        ),
      ),
      repo.getDailyArticle().timeout(
        const Duration(seconds: 5),
        onTimeout: () => DailyMediaItem(
          title: "BBC 中文网",
          subtitle: "Current Events in Simplified Chinese",
          url: "https://www.bbc.com/zhongwen/simp",
          imageUrl: "https://www.bbc.co.uk/news/special/2015/newsspec_10857/bbc_news_logo.png",
          tag: "ARTICLE OF THE DAY",
        ),
      ),
    ]);
    
    return results;
  }
}
