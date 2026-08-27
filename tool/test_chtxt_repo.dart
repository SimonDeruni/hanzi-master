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
  print('=== Testing JasonWade001/chtxt Repository ===');

  // Let's test several raw URLs from JasonWade001/chtxt
  final testUrls = [
    'https://raw.githubusercontent.com/JasonWade001/chtxt/master/%E4%B8%9C%E5%91%A8%E5%88%97%E5%9B%BD%E5%BF%97.txt',
    'https://raw.githubusercontent.com/JasonWade001/chtxt/master/%E5%8F%A4%E6%96%87%E8%A7%82%E6%AD%A2.txt',
    'https://raw.githubusercontent.com/JasonWade001/chtxt/master/%E6%B5%AE%E7%94%9F%E5%85%AD%E8%AE%B0.txt',
    'https://raw.githubusercontent.com/JasonWade001/chtxt/master/%E8%AF%B4%E5%B2%B3%E5%85%A8%E4%BC%A0.txt',
    'https://raw.githubusercontent.com/JasonWade001/chtxt/master/%E9%9A%8B%E5%94%90%E6%BC%94%E4%B9%89.txt',
    'https://raw.githubusercontent.com/JasonWade001/chtxt/master/%E6%9D%A8%E5%AE%B6%E5%B0%86%E6%BC%94%E4%B9%89.txt',
    'https://raw.githubusercontent.com/JasonWade001/chtxt/master/%E5%8C%85%E5%85%AC%E6%A1%88.txt',
    'https://raw.githubusercontent.com/JasonWade001/chtxt/master/%E6%96%BD%E5%85%AC%E6%A1%88.txt',
    'https://raw.githubusercontent.com/JasonWade001/chtxt/master/%E6%B5%8E%E5%85%AC%E5%85%A8%E4%BC%A0.txt',
    'https://raw.githubusercontent.com/JasonWade001/chtxt/master/%E9%86%92%E4%B8%96%E6%81%92%E8%A8%80.txt',
    'https://raw.githubusercontent.com/JasonWade001/chtxt/master/%E8%AD%A6%E4%B8%96%E9%80%9A%E8%A8%80.txt',
    'https://raw.githubusercontent.com/JasonWade001/chtxt/master/%E5%96%BB%E4%B8%96%E6%98%8E%E8%A8%80.txt',
    'https://raw.githubusercontent.com/JasonWade001/chtxt/master/%E5%88%9D%E5%88%BB%E6%8B%8D%E6%A1%88%E6%83%8A%E5%A5%87.txt',
    'https://raw.githubusercontent.com/JasonWade001/chtxt/master/%E4%BA%8C%E5%88%BB%E6%8B%8D%E6%A1%88%E6%83%8A%E5%A5%87.txt',
    'https://raw.githubusercontent.com/JasonWade001/chtxt/master/%E6%88%98%E5%9B%BD%E7%AD%96.txt',
    'https://raw.githubusercontent.com/JasonWade001/chtxt/master/%E5%B7%A6%E4%BC%A0.txt',
    'https://raw.githubusercontent.com/JasonWade001/chtxt/master/%E5%95%86%E5%90%9B%E4%B9%A6.txt',
    'https://raw.githubusercontent.com/JasonWade001/chtxt/master/%E7%AE%A1%E5%AD%90.txt',
    'https://raw.githubusercontent.com/JasonWade001/chtxt/master/%E5%85%AD%E9%9F%AC.txt',
    'https://raw.githubusercontent.com/JasonWade001/chtxt/master/%E5%AD%99%E8%85%95%E5%85%B5%E6%B3%95.txt',
  ];

  for (final u in testUrls) {
    final text = await fetchUrl(u);
    final name = Uri.decodeComponent(u.split('/').last);
    if (text != null && text.length > 500) {
      print('✅ SUCCESS: $name -> ${text.length} chars (~${text.length ~/ 1024} KB)');
    } else {
      print('❌ FAILED: $name');
    }
  }
}
