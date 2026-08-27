import 'dart:convert';
import 'dart:io';

Future<List<String>> searchWikisource(String query) async {
  final client = HttpClient();
  client.userAgent = 'HanziMasterApp/1.0 (educational research)';
  final uri = Uri.parse('https://zh.wikisource.org/w/api.php?action=query&list=search&srsearch=${Uri.encodeComponent(query)}&srlimit=10&format=json');
  try {
    final req = await client.getUrl(uri);
    final resp = await req.close();
    final body = await resp.transform(utf8.decoder).join();
    final json = jsonDecode(body) as Map<String, dynamic>;
    final search = (json['query']?['search'] as List<dynamic>?) ?? [];
    return search.map((e) => e['title'].toString()).toList();
  } catch (e) {
    return [];
  } finally {
    client.close();
  }
}

void main() async {
  print('=== Searching Wikisource Titles ===');

  final testBooks = [
    '聊斋志异',
    '古文观止',
    '战国策',
    '墨子',
    '管子',
    '商君书',
    '左传',
    '醒世恒言',
    '警世通言',
    '喻世明言',
    '初刻拍案惊奇',
    '二刻拍案惊奇',
    '隋唐演义',
    '说岳全传',
    '杨家将演义',
    '狄公案',
    '施公案',
    '济公全传',
    '白蛇传',
    '二十年目睹之怪现状',
    '官场现形记',
    '孽海花',
  ];

  for (final b in testBooks) {
    final titles = await searchWikisource(b);
    print('$b: ${titles.take(5).toList()}');
  }
}
