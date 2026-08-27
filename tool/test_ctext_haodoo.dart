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
  print('=== Testing CText & Haodoo Endpoints ===');

  // Test CText API
  // Sunzi Art of War: https://ctext.org/art-of-war/zh
  final ctextSunzi = await fetchUrl('https://ctext.org/art-of-war/zh');
  if (ctextSunzi != null) {
    print('✅ CText Sunzi connected: ${ctextSunzi.length} bytes');
  } else {
    print('❌ CText Sunzi failed');
  }

  // Test Haodoo direct text
  final haodooMystery = await fetchUrl('http://www.haodoo.net/?M=hd&P=mystery');
  if (haodooMystery != null) {
    print('✅ Haodoo Mystery connected: ${haodooMystery.length} bytes');
  }
}
