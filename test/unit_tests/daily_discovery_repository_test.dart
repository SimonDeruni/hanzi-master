import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/media/data/repositories/daily_discovery_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  test('uses the first BBC RSS article instead of the channel homepage',
      () async {
    final client = MockClient((request) async {
      expect(request.url.toString(),
          'https://feeds.bbci.co.uk/zhongwen/simp/rss.xml');
      return http.Response.bytes(utf8.encode('''
        <rss xmlns:media="http://search.yahoo.com/mrss/">
          <channel>
            <item>
              <title>今日头条</title>
              <link>https://www.bbc.com/zhongwen/articles/example/trad?source=rss</link>
              <media:thumbnail url="https://example.com/lead.jpg" />
            </item>
          </channel>
        </rss>
      '''), 200, headers: const {
        'content-type': 'application/rss+xml; charset=utf-8',
      });
    });

    final item =
        await DailyDiscoveryRepository(client: client).getDailyArticle();

    expect(item.title, '今日头条');
    expect(item.subtitle, 'BBC 中文');
    expect(item.url,
        'https://www.bbc.com/zhongwen/articles/example/simp?source=rss');
    expect(item.imageUrl, 'https://example.com/lead.jpg');
    expect(item.url, isNot('https://www.bbc.com/zhongwen/simp'));
  });

  test('falls back to the BBC homepage lead article when RSS fails', () async {
    final client = MockClient((request) async {
      if (request.url.host == 'feeds.bbci.co.uk') {
        return http.Response('unavailable', 503);
      }
      return http.Response.bytes(utf8.encode('''
        <html><body><main>
          <section>
            <img src="https://example.com/home-lead.jpg">
            <div><h3><a href="/zhongwen/articles/lead-story/simp">
              屏幕上的主要新闻
            </a></h3></div>
          </section>
        </main></body></html>
      '''), 200, headers: const {
        'content-type': 'text/html; charset=utf-8',
      });
    });

    final item =
        await DailyDiscoveryRepository(client: client).getDailyArticle();

    expect(item.title, '屏幕上的主要新闻');
    expect(item.url, 'https://www.bbc.com/zhongwen/articles/lead-story/simp');
    expect(item.imageUrl, 'https://example.com/home-lead.jpg');
  });
}
