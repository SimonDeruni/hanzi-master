import 'dart:convert';
import 'dart:io';

Future<List<String>> searchWikisource(String query) async {
  final client = HttpClient();
  client.userAgent = 'HanziMasterApp/1.0 (educational research)';
  final uri = Uri.parse('https://zh.wikisource.org/w/api.php?action=query&list=search&srsearch=${Uri.encodeComponent(query)}&format=json');
  try {
    final req = await client.getUrl(uri);
    final resp = await req.close();
    final body = await resp.transform(utf8.decoder).join();
    final json = jsonDecode(body) as Map<String, dynamic>;
    final search = (json['query']?['search'] as List<dynamic>?) ?? [];
    return search.map((e) => e['title'].toString()).toList();
  } catch (e) {
    print('Error searching $query: $e');
    return [];
  } finally {
    client.close();
  }
}

Future<String?> fetchWikisourcePage(String title) async {
  final client = HttpClient();
  client.userAgent = 'HanziMasterApp/1.0 (educational research)';
  final uri = Uri.parse('https://zh.wikisource.org/w/api.php?action=parse&page=${Uri.encodeComponent(title)}&format=json&prop=wikitext');
  try {
    final req = await client.getUrl(uri);
    final resp = await req.close();
    final body = await resp.transform(utf8.decoder).join();
    final json = jsonDecode(body) as Map<String, dynamic>;
    return json['parse']?['wikitext']?['*'] as String?;
  } catch (e) {
    print('Error fetching $title: $e');
    return null;
  } finally {
    client.close();
  }
}

void main() async {
  print('=== Testing Chinese Wikisource (zh.wikisource.org) API ===');
  final testQueries = [
    '三十六计',
    '封神演义',
    '聊斋志异',
    '儒林外史',
    '东周列国志',
    '老残游记',
    '小王子',
    '变形记',
    '老人与海',
    '安徒生童话',
    '格林童话'
  ];

  for (final q in testQueries) {
    final res = await searchWikisource(q);
    print('Search "$q" -> found ${res.length} titles: ${res.take(4).toList()}');
    if (res.isNotEmpty) {
      final sample = await fetchWikisourcePage(res.first);
      if (sample != null) {
        final preview = sample.replaceAll(RegExp(r'\[\[|\]\]|\{\{|\}\}'), '').trim();
        print('  Sample text (${preview.length} chars): ${preview.substring(0, preview.length > 80 ? 80 : preview.length).replaceAll('\n', ' ')}...\n');
      }
    }
  }
}
