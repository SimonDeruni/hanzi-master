import 'dart:convert';
import 'dart:io';

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
    return null;
  } finally {
    client.close();
  }
}

Future<List<String>> fetchSubpages(String prefix) async {
  final client = HttpClient();
  client.userAgent = 'HanziMasterApp/1.0 (educational research)';
  final uri = Uri.parse('https://zh.wikisource.org/w/api.php?action=query&list=allpages&apprefix=${Uri.encodeComponent(prefix)}&aplimit=50&format=json');
  try {
    final req = await client.getUrl(uri);
    final resp = await req.close();
    final body = await resp.transform(utf8.decoder).join();
    final json = jsonDecode(body) as Map<String, dynamic>;
    final pages = (json['query']?['allpages'] as List<dynamic>?) ?? [];
    return pages.map((e) => e['title'].toString()).toList();
  } catch (e) {
    return [];
  } finally {
    client.close();
  }
}

void main() async {
  print('=== Testing Chinese Wikisource Subpages & Full Text ===');

  final testBooks = [
    '封神演義',
    '儒林外史',
    '東周列國志',
    '老殘遊記',
    '鏡花緣',
    '隋唐演義',
    '聊齋志異',
    '醒世恆言',
    '警世通言',
    '喻世明言',
    '初刻拍案驚奇',
    '二刻拍案驚奇',
    '古文觀止',
    '戰國策',
    '墨子',
    '管子',
    '商君書',
    '左傳',
  ];

  for (final b in testBooks) {
    final subpages = await fetchSubpages('$b/');
    print('Book "$b" -> found ${subpages.length} subpages: ${subpages.take(3).toList()}');
    if (subpages.isNotEmpty) {
      final sample = await fetchWikisourcePage(subpages.first);
      if (sample != null) {
        print('   -> Sample length: ${sample.length} characters\n');
      }
    }
  }
}
