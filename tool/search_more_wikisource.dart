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
  final queries = [
    '拍案驚奇',
    '今古奇觀',
    '官場',
    '怪現狀',
    '說岳',
    '楊家將',
    '包公案',
    '施公案',
    '濟公',
    '孽海花',
    '浮生六記',
    '世說新語',
    '楚辭',
    '詩經',
    '六韜',
    '孫臏兵法',
    '吳子',
  ];

  for (final q in queries) {
    final titles = await searchWikisource(q);
    print('$q: ${titles.take(5).toList()}');
    sleep(const Duration(milliseconds: 100));
  }
}
