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
  print('=== Testing Raw GitHub Endpoints for Full Chinese Texts ===');

  final testUrls = {
    'shijing': 'https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E8%AF%97%E7%BB%8F/shijing.json',
    'chuci': 'https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E6%A5%9A%E8%BE%9E/chuci.json',
    'guwenguanzhi': 'https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E5%8F%A4%E6%96%87%E8%A7%82%E6%AD%A2/guwenguanzhi.json',
    'lunyu': 'https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E8%AE%BA%E8%AF%AD/lunyu.json',
    'mengzi': 'https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E5%AD%9F%E5%AD%90/mengzi.json',
    'daodejing': 'https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E9%81%93%E5%BE%B7%E7%BB%8F/daodejing.json',
    'zhuangzi': 'https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E5%BA%84%E5%AD%90/zhuangzi.json',
  };

  for (final entry in testUrls.entries) {
    final res = await fetchUrl(entry.value);
    if (res != null) {
      print('✅ SUCCESS: ${entry.key} -> downloaded ${res.length} chars (~${res.length ~/ 1024} KB)');
    } else {
      print('❌ FAILED: ${entry.key}');
    }
  }
}
