import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final client = HttpClient();
  client.userAgent = 'HanziMasterApp/1.0';
  final uri = Uri.parse('https://api.github.com/repos/xp44mm/hanchuancaolu/git/trees/master?recursive=1');
  try {
    final req = await client.getUrl(uri);
    final resp = await req.close();
    final body = await resp.transform(utf8.decoder).join();
    final json = jsonDecode(body) as Map<String, dynamic>;
    final tree = (json['tree'] as List<dynamic>?) ?? [];

    final Set<String> topDirs = {};
    for (final item in tree) {
      final path = item['path'] as String;
      final parts = path.split('/');
      if (parts.length > 1) {
        topDirs.add(parts[0]);
      }
    }

    print('Top directories in xp44mm/hanchuancaolu: ${topDirs.length}');
    for (final d in topDirs) {
      print('  - $d');
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    client.close();
  }
}
