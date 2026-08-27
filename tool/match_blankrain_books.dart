import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  // Query tree from BlankRain/ebooks
  final client = HttpClient();
  client.userAgent = 'HanziMasterApp/1.0';
  final uri = Uri.parse('https://api.github.com/repos/BlankRain/ebooks/git/trees/master?recursive=1');
  final req = await client.getUrl(uri);
  final resp = await req.close();
  final body = await resp.transform(utf8.decoder).join();
  final json = jsonDecode(body) as Map<String, dynamic>;
  final tree = (json['tree'] as List<dynamic>?) ?? [];
  client.close();

  final catalogJson = File('assets/data/grand_library_catalog.json').readAsStringSync();
  final List<dynamic> catalog = jsonDecode(catalogJson);

  print('=== Matching Catalog Books against BlankRain/ebooks (${tree.length} items) ===\n');

  int matched = 0;
  for (final book in catalog) {
    var title = (book['title'] as String).replaceAll('精选', '').replaceAll('全集', '').trim();
    if (title.contains('·')) title = title.split('·').first;
    if (title.contains('（')) title = title.split('（').first;
    if (title.contains('(')) title = title.split('(').first;
    final id = book['id'] as String;

    final matching = tree.where((item) {
      final path = item['path'] as String;
      return path.contains(title) && path.endsWith('.txt');
    }).toList();

    if (matching.isNotEmpty) {
      print('✅ MATCH: $id ("$title") -> ${matching.first['path']}');
      matched++;
    }
  }

  print('\nTotal matched: $matched / ${catalog.length}');
}
