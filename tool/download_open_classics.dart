import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() async {
  print('=== Downloading Authentic Open-Source Ancient Chinese Texts ===');

  final ancientDir = Directory('assets/data/ancient');
  if (!ancientDir.existsSync()) {
    ancientDir.createSync(recursive: true);
  }

  final files = [
    '三十六计.json',
    '孙子兵法.json',
    '老子.json',
    '论语.json',
    '庄子.json',
    '孟子.json',
    '荀子.json',
    '韩非子.json',
    '菜根谭.json',
    '山海经.json',
    '淮南子.json',
    '搜神记.json',
    '列子.json',
    '史记.json',
    '世说新语.json',
  ];

  for (final filename in files) {
    final url = Uri.parse('https://raw.githubusercontent.com/hanzhaodeng/chinese-ancient-text/master/${Uri.encodeComponent(filename)}');
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final dest = File('assets/data/ancient/$filename');
        dest.writeAsBytesSync(res.bodyBytes);
        print('  ✓ Downloaded $filename (${res.bodyBytes.length} bytes)');
      } else {
        print('  ✗ Failed $filename: HTTP ${res.statusCode}');
      }
    } catch (e) {
      print('  ✗ Error downloading $filename: $e');
    }
  }

  print('=== All Ancient Texts Downloaded! ===');
}
