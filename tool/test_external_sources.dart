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
  print('=== Testing External Repositories for World Classics in Chinese ===');

  // Let's test several public raw GitHub mirrors and archives
  final testUrls = {
    'haodoo_index': 'http://www.haodoo.net/',
  };

  for (final entry in testUrls.entries) {
    final res = await fetchUrl(entry.value);
    if (res != null) {
      print('✅ SUCCESS: ${entry.key} connected (${res.length} bytes)');
    } else {
      print('❌ FAILED: ${entry.key}');
    }
  }
}
