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
  print('=== Testing chinese-poetry & Ancient Philosophy Endpoints ===');

  // Let's test several endpoints from chinese-poetry and open ancient repos
  final testUrls = {
    'caigentan': 'https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E8%94%AC%E6%A0%B9%E8%B0%AD/caigentan.json',
    'youmengying': 'https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E5%B9%BD%E6%A2%A6%E5%BD%B1/youmengying.json',
    'sanzijing': 'https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E8%92%99%E5%AD%A6/sanzijing.json',
    'baijiaxing': 'https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E8%92%99%E5%AD%A6/baijiaxing.json',
    'qianziwen': 'https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E8%92%99%E5%AD%A6/qianziwen.json',
    'dizigui': 'https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E8%92%99%E5%AD%A6/dizigui.json',
    'zhuzijiaxun': 'https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E8%92%99%E5%AD%A6/zhuzijiaxun.json',
  };

  for (final entry in testUrls.entries) {
    final res = await fetchUrl(entry.value);
    if (res != null) {
      print('✅ SUCCESS: ${entry.key} -> ${res.length} bytes');
    } else {
      print('❌ FAILED: ${entry.key}');
    }
  }
}
