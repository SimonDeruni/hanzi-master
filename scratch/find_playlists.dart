import 'package:http/http.dart' as http;

void main() async {
  final c = http.Client();
  const videoId = 'dQw4w9WgXcQ'; // Rick Roll — always has captions
  final uri = Uri.parse('https://www.youtube.com/watch?v=$videoId');
  final r = await c.get(uri, headers: {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
    'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8',
  });
  print('Status: ${r.statusCode}');
  print('Body length: ${r.body.length}');

  // Test the regex
  final regex = RegExp(r'ytInitialPlayerResponse\s*=\s*(\{.+?\});', dotAll: true);
  final match = regex.firstMatch(r.body);
  print('Regex match: ${match != null}');
  if (match != null) {
    print('Matched length: ${match.group(1)!.length}');
  } else {
    // Try alternative — YouTube may have changed the variable name
    final containsYt = r.body.contains('ytInitialPlayerResponse');
    final containsYtData = r.body.contains('ytInitialData');
    print('Contains ytInitialPlayerResponse: $containsYt');
    print('Contains ytInitialData: $containsYtData');

    // Try finding captions in raw body
    final hasCaptions = r.body.contains('captionTracks');
    print('Contains captionTracks: $hasCaptions');

    // Try with wider regex
    final regex2 = RegExp(r'var\s+ytInitialPlayerResponse\s*=\s*(\{.*?\});', dotAll: true);
    final match2 = regex2.firstMatch(r.body);
    print('"var ytInitial..." match: ${match2 != null}');
  }
  c.close();
}