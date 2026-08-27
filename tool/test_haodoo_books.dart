import 'dart:convert';
import 'dart:io';

Future<String?> fetchUrl(String url) async {
  final client = HttpClient();
  client.userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)';
  try {
    final req = await client.getUrl(Uri.parse(url));
    final resp = await req.close();
    if (resp.statusCode == 200) {
      final bytes = await resp.fold<List<int>>([], (prev, elem) => prev..addAll(elem));
      try {
        return utf8.decode(bytes);
      } catch (_) {
        return latin1.decode(bytes);
      }
    }
    return null;
  } catch (e) {
    return null;
  } finally {
    client.close();
  }
}

void main() async {
  print('=== Testing Haodoo Book Search & Pages ===');

  // Let's test fetching a page from Haodoo
  // Example: http://www.haodoo.net/?M=hd&P=wisdom (随身智囊 / 世界名著)
  // Example: http://www.haodoo.net/?M=hd&P=mystery (侦探小说 - Sherlock Holmes)

  final urls = [
    'http://www.haodoo.net/?M=hd&P=wisdom',
    'http://www.haodoo.net/?M=hd&P=mystery',
    'http://www.haodoo.net/?M=hd&P=scifi',
    'http://www.haodoo.net/?M=hd&P=history',
  ];

  for (final u in urls) {
    final html = await fetchUrl(u);
    if (html != null) {
      print('✅ Fetched $u: ${html.length} bytes');
      // Look for book titles like 基督山, 福尔摩斯, 傲慢与偏见, 简爱, 悲惨世界
      final matches = RegExp(r'SetTitle\("([^"]+)"\)').allMatches(html);
      final titles = matches.map((m) => m.group(1)).toList();
      print('   Found books: ${titles.take(6).toList()}...\n');
    }
  }
}
