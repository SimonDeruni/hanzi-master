import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final client = HttpClient();
  client.userAgent = 'HanziMasterApp/1.0';
  final uri = Uri.parse('https://api.github.com/repos/JasonWade001/chtxt/git/trees/main?recursive=1');
  try {
    final req = await client.getUrl(uri);
    final resp = await req.close();
    final body = await resp.transform(utf8.decoder).join();
    final json = jsonDecode(body) as Map<String, dynamic>;
    final tree = (json['tree'] as List<dynamic>?) ?? [];
    print('Total tree items: ${tree.length}');
    for (final item in tree) {
      final path = item['path'] as String;
      if (path.endsWith('.txt')) {
        print('  File: $path');
      }
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    client.close();
  }
}
