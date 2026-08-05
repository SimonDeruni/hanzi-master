import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  final key = dotenv.env['YOUTUBE_API_KEY'];
  print('Key starting with: ${key?.substring(0, 5)}');

  final uri = Uri.parse('https://www.googleapis.com/youtube/v3/search?part=snippet&q=Chinese&type=video&maxResults=2&key=$key');
  final response = await http.get(uri);
  print('Status: ${response.statusCode}');
  print('Body: ${response.body}');
}
