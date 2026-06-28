import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hanzi_master/features/media/domain/models/daily_media_item.dart';
import 'package:hanzi_master/features/media/data/repositories/daily_discovery_repository.dart';

part 'daily_discovery_provider.g.dart';

@riverpod
class DailyDiscovery extends _$DailyDiscovery {
  @override
  Future<List<DailyMediaItem>> build() async {
    final repo = DailyDiscoveryRepository();
    
    // Fetch both simultaneously
    final results = await Future.wait([
      repo.getDailyVideo(),
      repo.getDailyArticle(),
    ]);
    
    return results;
  }
}
