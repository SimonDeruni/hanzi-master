import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final client = HttpClient();
  client.userAgent = 'HanziMasterApp/1.0';
  final uri = Uri.parse('https://api.github.com/repos/BlankRain/ebooks/git/trees/master?recursive=1');
  final req = await client.getUrl(uri);
  final resp = await req.close();
  final body = await resp.transform(utf8.decoder).join();
  final json = jsonDecode(body) as Map<String, dynamic>;
  final tree = (json['tree'] as List<dynamic>?) ?? [];
  client.close();

  final keywords = [
    '莎士比亚', '茨威格', '契诃夫', '复活', '格列佛', '野性', '维特', '卡夫卡',
    '彷徨', '野草', '巴金', '茅盾', '曹禺', '爱伦·坡', '王尔德', '霍夫曼',
    '安徒生', '格林', '伊索', '包法利', '忏悔录', '赫尔曼', '托马斯', '莫里哀'
  ];

  print('=== Searching BlankRain/ebooks for Keywords ===');
  for (final kw in keywords) {
    final matches = tree.where((item) => (item['path'] as String).contains(kw)).map((e) => e['path'] as String).toList();
    print('$kw: ${matches.take(5).toList()}');
  }
}
