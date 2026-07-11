import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final c = http.Client();
  const key = 'AIzaSyCvmm4uljoCyIFkBIoBybiishaWyyu2ROU';

  // Quick API check
  final r = await c.get(Uri.parse('https://www.googleapis.com/youtube/v3/channels?part=snippet&id=UCUhpu5MJQ_bjPkXO00jyxsw&key=$key'));
  print('API status: ${r.statusCode}');
  if (r.statusCode == 200) {
    final d = jsonDecode(r.body);
    print('OK: ${(d['items'] as List)[0]['snippet']['title']}');
  } else {
    print(r.body.substring(0, 300));
  }

  // Playlist check
  final r2 = await c.get(Uri.parse('https://www.googleapis.com/youtube/v3/playlists?part=snippet&channelId=UCUhpu5MJQ_bjPkXO00jyxsw&maxResults=3&key=$key'));
  print('Playlists: ${r2.statusCode}');
  if (r2.statusCode == 200) {
    final d = jsonDecode(r2.body);
    print('Count: ${(d['items'] as List).length}');
  }

  c.close();
}