import 'dart:convert';
import 'dart:io';

Future<List<String>> searchWikisource(String query) async {
  final client = HttpClient();
  client.userAgent = 'HanziMasterApp/1.0 (educational research)';
  final uri = Uri.parse('https://zh.wikisource.org/w/api.php?action=opensearch&search=${Uri.encodeComponent(query)}&limit=10&format=json');
  try {
    final req = await client.getUrl(uri);
    final resp = await req.close();
    final body = await resp.transform(utf8.decoder).join();
    final json = jsonDecode(body) as List<dynamic>;
    if (json.length > 1) {
      return (json[1] as List<dynamic>).map((e) => e.toString()).toList();
    }
    return [];
  } catch (e) {
    return [];
  } finally {
    client.close();
  }
}

void main() async {
  print('=== OpenSearch on Chinese Wikisource ===');

  final testBooks = [
    '聊齋志異',
    '古文觀止',
    '戰國策',
    '墨子',
    '管子',
    '商君書',
    '左傳',
    '醒世恆言',
    '警世通言',
    '喻世明言',
    '初刻拍案驚奇',
    '二刻拍案驚奇',
    '隋唐演義',
    '說岳全傳',
    '楊家將演義',
    '狄公案',
    '施公案',
    '濟公全傳',
    '二十年目睹之怪現狀',
    '官場現形記',
    '孽海花',
  ];

  for (final b in testBooks) {
    final titles = await searchWikisource(b);
    print('$b: ${titles.take(5).toList()}');
    sleep(const Duration(milliseconds: 100));
  }
}
