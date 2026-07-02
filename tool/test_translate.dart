import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final url = 'https://translate.googleapis.com/translate_a/single?client=dict-chrome-ex&sl=en&tl=es&dt=t&q=hello&q=world';
  final response = await http.get(Uri.parse(url));
  print(response.body);
}
