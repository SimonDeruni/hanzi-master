import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/media/data/video_category_queries.dart';
import 'package:hanzi_master/features/media/data/youtube_repository.dart';
import 'package:hanzi_master/features/media/domain/models/youtube_video.dart';

void main() {
  group('video category queries', () {
    test('use fixed Mandarin discovery terms', () {
      expect(VideoCategoryQueries.lifestyle, '中国 日常生活 vlog 中文');
      expect(VideoCategoryQueries.gaming, contains('游戏'));
      expect(VideoCategoryQueries.food, contains('美食'));
      expect(VideoCategoryQueries.technology, contains('科技'));
    });
  });

  group('Chinese video discovery', () {
    test('prefers Chinese captions and excludes unrelated French videos',
        () async {
      final repository = _FakeYoutubeRepository(
        chineseCaptionIds: {'mandarin'},
        captionedIds: {'mandarin', 'french', 'chinese-metadata'},
      );
      final candidates = [
        _video('french', 'Ils travaillent 24/24', "L'Effet Papillon"),
        _video('chinese-metadata', '中国生活记录', 'Daily life'),
        _video('mandarin', 'A day in Shanghai', 'Mandarin Vlogs'),
      ];

      final results =
          await repository.filterForChineseDiscovery(candidates, max: 15);

      expect(results.map((video) => video.id), [
        'mandarin',
        'chinese-metadata',
      ]);
    });

    test('keeps captioned Chinese-metadata videos as a flexible fallback',
        () async {
      final repository = _FakeYoutubeRepository(
        chineseCaptionIds: const {},
        captionedIds: {'fallback'},
      );

      final results = await repository.filterForChineseDiscovery([
        _video('fallback', '科技产品评测', 'Tech Reviews'),
      ]);

      expect(results.single.id, 'fallback');
    });
  });
}

YoutubeVideo _video(String id, String title, String channelTitle) {
  return YoutubeVideo(
    id: id,
    title: title,
    url: 'https://www.youtube.com/watch?v=$id',
    mediumThumbnailUrl: '',
    highThumbnailUrl: '',
    channelTitle: channelTitle,
  );
}

class _FakeYoutubeRepository extends YoutubeRepository {
  _FakeYoutubeRepository({
    required this.chineseCaptionIds,
    required this.captionedIds,
  });

  final Set<String> chineseCaptionIds;
  final Set<String> captionedIds;

  @override
  Future<bool> hasChineseCaptions(String videoId) async =>
      chineseCaptionIds.contains(videoId);

  @override
  Future<bool> hasCaptions(String videoId) async =>
      captionedIds.contains(videoId);
}
