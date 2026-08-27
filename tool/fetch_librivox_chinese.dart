import 'dart:convert';
import 'dart:io';

void main() async {
  print('Querying LibriVox API for Chinese projects...');
  final client = HttpClient();

  try {
    final uri = Uri.parse('https://librivox.org/api/feed/audiobooks/?format=json&extended=1&language=Chinese');
    final req = await client.getUrl(uri);
    req.headers.set('User-Agent', 'Mozilla/5.0');
    final res = await req.close();
    final body = await res.transform(utf8.decoder).join();
    final data = jsonDecode(body);
    final List<dynamic> books = data['books'] ?? [];
    print('Total LibriVox Chinese Audiobooks found: ${books.length}');
    for (final b in books) {
      print('- ID: ${b['id']} | Title: ${b['title']} | URL: ${b['url_librivox']} | RSS: ${b['url_rss']}');
    }
  } catch (e) {
    print('Error querying LibriVox API: $e');
  }

  print('\nQuerying Archive.org for Chinese LibriVox recordings...');
  try {
    final uri = Uri.parse('https://archive.org/advancedsearch.php?q=collection:(librivoxaudio)+AND+language:(Chinese)&fl[]=identifier,title,creator,year&rows=50&output=json');
    final req = await client.getUrl(uri);
    req.headers.set('User-Agent', 'Mozilla/5.0');
    final res = await req.close();
    final body = await res.transform(utf8.decoder).join();
    final data = jsonDecode(body);
    final List<dynamic> docs = data['response']?['docs'] ?? [];
    print('Total Archive.org LibriVox Chinese items: ${docs.length}');
    for (final d in docs) {
      print('- Identifier: ${d['identifier']} | Title: ${d['title']} | Creator: ${d['creator']}');
    }
  } catch (e) {
    print('Error querying Archive.org: $e');
  }
}
