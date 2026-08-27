import 'dart:convert';
import 'dart:io';

void main() async {
  print('=== Fetching Archive.org Direct Audio MP3 Streams ===');
  final client = HttpClient();

  // Test identifiers from previous search
  final identifiers = [
    'tangpoems4_1207_librivox',
    'analects_confucius_1303_librivox',
    'art_of_war_librivox',
    'w73c9plhpwnxbrnuiirr35904vgtrtcmiyvvlfst', // 三国演义
    'a7zerwneey84c2wgt9cbbwig5nb5rxshbznp48ys', // 西游记
  ];

  for (final id in identifiers) {
    try {
      final uri = Uri.parse('https://archive.org/metadata/$id/files');
      final req = await client.getUrl(uri);
      req.headers.set('User-Agent', 'Mozilla/5.0');
      final res = await req.close();
      final body = await res.transform(utf8.decoder).join();
      final data = jsonDecode(body);
      final List<dynamic> files = data['result'] ?? [];
      final mp3s = files.where((f) => (f['name'] as String).endsWith('.mp3')).toList();
      print('\nIdentifier: $id (found ${mp3s.length} MP3 files)');
      for (final f in mp3s.take(5)) {
        final name = f['name'];
        final directUrl = 'https://archive.org/download/$id/$name';
        print('  -> File: $name | URL: $directUrl | Title: ${f['title'] ?? ''}');
      }
    } catch (e) {
      print('Error on $id: $e');
    }
  }
}
