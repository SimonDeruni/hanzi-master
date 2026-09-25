import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/media/data/repositories/daily_discovery_repository.dart';

void main() {
  group('BBC article image upscaling', () {
    test('upgrades the 240px RSS thumbnail to a 1024px rendition', () {
      const lowRes =
          'https://ichef.bbci.co.uk/ace/ws/240/cpsprodpb/9972/live/29a84e10.jpg';

      final item = DailyDiscoveryRepository.debugBuildBbcArticle(
        title: '测试标题',
        link: 'https://www.bbc.com/zhongwen/articles/c6vgyzdjzl9ko/trad',
        imageUrl: lowRes,
      );

      expect(item.imageUrl,
          'https://ichef.bbci.co.uk/ace/ws/1024/cpsprodpb/9972/live/29a84e10.jpg');
      // The requested path must no longer advertise the 240px rendition.
      expect(item.imageUrl, isNot(contains('/ws/240/')));
    });

    test('handles legacy /news/ws/ image paths', () {
      final item = DailyDiscoveryRepository.debugBuildBbcArticle(
        title: 't',
        link: 'https://www.bbc.com/zhongwen/articles/abc/trad',
        imageUrl:
            'https://ichef.bbci.co.uk/news/ws/240/amz/worldservice/live.jpg',
      );

      expect(item.imageUrl, contains('/news/ws/1024/'));
    });

    test('leaves non-ichef URLs untouched', () {
      const external = 'https://example.com/image.jpg';

      final item = DailyDiscoveryRepository.debugBuildBbcArticle(
        title: 't',
        link: 'https://www.bbc.com/zhongwen/articles/abc/trad',
        imageUrl: external,
      );

      expect(item.imageUrl, external);
    });

    test('falls back to the BBC logo when no thumbnail is supplied', () {
      final item = DailyDiscoveryRepository.debugBuildBbcArticle(
        title: 't',
        link: 'https://www.bbc.com/zhongwen/articles/abc/trad',
        imageUrl: null,
      );

      expect(item.imageUrl, contains('bbc_news_logo.png'));
    });

    test('converts traditional links to simplified', () {
      final item = DailyDiscoveryRepository.debugBuildBbcArticle(
        title: 't',
        link: 'https://www.bbc.com/zhongwen/articles/abc/trad',
        imageUrl: null,
      );

      expect(item.url, contains('/simp'));
      expect(item.url, isNot(contains('/trad')));
      expect(item.tag, 'ARTICLE OF THE DAY');
    });
  });
}
