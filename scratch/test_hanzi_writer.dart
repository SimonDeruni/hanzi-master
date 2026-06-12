import 'package:http/http.dart' as http;

void main() async {
  String char = '尔';
  final url = Uri.parse('https://cdn.jsdelivr.net/npm/hanzi-writer-data@2.0.1/$char.json');
  final response = await http.get(url);
  print(response.statusCode);
  if (response.statusCode == 200) {
    print("Success: ${response.body.substring(0, 100)}");
  } else {
    print("Failed to fetch.");
  }
}
