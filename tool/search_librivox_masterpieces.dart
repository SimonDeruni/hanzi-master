import 'dart:convert';
import 'dart:io';

void main() async {
  print('Searching LibriVox for specific Chinese masterpieces...');
  final client = HttpClient();

  final queries = ['Journey to the West', 'Sunzi', 'Art of War', 'Laozi', 'Confucius', 'Analects', 'Three Kingdoms', 'Dream of the Red Chamber', 'Lu Xun', 'Ah Q', 'Water Margin', 'Tang Poetry'];

  for (final q in queries) {
    try {
      final uri = Uri.parse('https://librivox.org/api/feed/audiobooks/?title=^${Uri.encodeComponent(q)}&format=json&extended=1');
      final req = await client.getUrl(uri);
      req.headers.set('User-Agent', 'Mozilla/5.0');
      final res = await req.close();
      final body = await res.transform(utf8.decoder).join();
      final data = jsonDecode(body);
      final List<dynamic> books = data['books'] ?? [];
      print('Query "$q": found ${books.length} records');
      for (final b in books) {
        print('  -> Title: ${b['title']} | Language: ${b['language']} | URL: ${b['url_librivox']} | Audio Zip: ${b['url_zip_file']}');
      }
    } catch (e) {
      print('Error on "$q": $e');
    }
  }

  // Also search Archive.org directly with metadata
  print('\nSearching Internet Archive directly for Chinese spoken audiobooks...');
  try {
    final uri = Uri.parse('https://archive.org/advancedsearch.php?q=mediatype:(audio)+AND+(subject:(Chinese+audiobook)+OR+subject:(评书)+OR+title:(西游记)+OR+title:(三国演义)+OR+title:(道德经))&fl[]=identifier,title,creator,year&rows=25&output=json');
    final req = await client.getUrl(uri);
    req.headers.set('User-Agent', 'Mozilla/5.0');
    final res = await req.close();
    final body = await res.transform(utf8.decoder).join();
    final data = jsonDecode(body);
    final List<dynamic> docs = data['response']?['docs'] ?? [];
    print('Found ${docs.length} audio items on Archive.org:');
    for (final d in docs) {
      print('  -> [Archive.org] ${d['identifier']} : ${d['title']} (${d['creator']})');
    }
  } catch (e) {
    print('Error on Archive.org search: $e');
  }
}
