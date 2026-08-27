import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final client = HttpClient();
  final req = await client.getUrl(Uri.parse('http://www.haodoo.net/?M=hd&P=wisdom'));
  final resp = await req.close();
  final bytes = await resp.fold<List<int>>([], (p, e) => p..addAll(e));
  // Haodoo uses Big5 or UTF8
  String text;
  try {
    text = utf8.decode(bytes);
  } catch (_) {
    text = latin1.decode(bytes);
  }
  final lines = text.split('\n');
  print('Total lines: ${lines.length}');
  for (int i = 0; i < lines.length && i < 150; i++) {
    if (lines[i].contains('Book') || lines[i].contains('href') || lines[i].contains('P=')) {
      print('Line $i: ${lines[i].trim()}');
    }
  }
}
