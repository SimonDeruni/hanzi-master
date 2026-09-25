import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/media/data/video_category_queries.dart';
import 'package:hanzi_master/features/media/data/youtube_repository.dart';
import 'package:hanzi_master/features/media/domain/models/youtube_video.dart';

void main() {
  group('video category queries', () {
    test('use fixed Mandarin discovery terms', () {
      expect(VideoCategoryQueries.lifestyle, '中国 日常生活 vlog 中文');
      expect(VideoCategoryQueries.food, contains('美食'));
      expect(VideoCategoryQueries.technology, contains('科技'));
    });

    test('no gaming/esports shelf is offered to the feed', () {
      // Its query returned nothing, so the Explore feed shipped a 250dp shelf
      // that only ever said "Aucune vidéo trouvée" — dead space that read as an
      // unfinished feature. Removed on 2026-09-23.
      final String queries = File(
        'lib/features/media/data/video_category_queries.dart',
      ).readAsStringSync();
      expect(queries, isNot(contains('static const gaming')));
      expect(queries, isNot(contains('游戏 实况')),
          reason: 'The esports discovery term itself is gone');

      final String feed = File(
        'lib/features/media/presentation/screens/media_search_screen.dart',
      ).readAsStringSync();
      expect(feed, isNot(contains('gamingAndEsports')));
      expect(feed, isNot(contains('VideoCategoryQueries.gaming')));
    });

    test('the feed drops shelves that load empty', () {
      final String feed = File(
        'lib/features/media/presentation/screens/media_search_screen.dart',
      ).readAsStringSync();

      expect(feed, contains('.where((entry) =>'),
          reason: 'Empty shelves must be filtered out, not rendered as '
              'placeholder space');
      expect(feed, contains('_CategoryLoadState.empty'),
          reason: 'The state machine still classifies an empty load');
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
