import 'dart:io';
import 'package:http/http.dart' as http;

void main() async {
  const url = 'https://chinesereadingpractice.com/feed/';
  final response = await http.get(Uri.parse(url));
  File('scratch/feed2.xml').writeAsStringSync(response.body);
}
