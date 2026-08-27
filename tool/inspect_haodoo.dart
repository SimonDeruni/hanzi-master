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
  final html = await fetchUrl('http://www.haodoo.net/?M=hd&P=wisdom');
  if (html == null) return;

  // Search for book definitions
  // Format typically: Pcode('B1001') or CreateBook(...) or title="...", onclick="SetBook('...')"
  final matches = RegExp(r'CC\([^\)]+\)').allMatches(html);
  for (final m in matches.take(15)) {
    print('Match: ${m.group(0)}');
  }

  final bookMatches = RegExp(r"SetBookTitle\('([^']+)'\)").allMatches(html);
  print('\nSetBookTitle matches: ${bookMatches.length}');
  for (final m in bookMatches.take(10)) {
    print('  - ${m.group(1)}');
  }

  final generalMatches = RegExp(r"onclick=([^>]+)").allMatches(html);
  print('\nOnclick matches: ${generalMatches.length}');
  for (final m in generalMatches.take(10)) {
    print('  - ${m.group(1)}');
  }
}
