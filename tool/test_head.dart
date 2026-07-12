import 'package:http/http.dart' as http;

void main() async {
  final thumbUri = Uri.parse('https://img.youtube.com/vi/gcShBujgsIQ/hqdefault.jpg');
  final thumbUri0 = Uri.parse('https://img.youtube.com/vi/gcShBujgsIQ/0.jpg');
  
  try {
    final head = await http.head(thumbUri);
    print("HEAD hqdefault.jpg: ${head.statusCode}");
  } catch (e) {
    print("HEAD hqdefault.jpg Error: $e");
  }

  try {
    final head0 = await http.head(thumbUri0);
    print("HEAD 0.jpg: ${head0.statusCode}");
  } catch (e) {
    print("HEAD 0.jpg Error: $e");
  }

  try {
    final get = await http.get(thumbUri);
    print("GET hqdefault.jpg: ${get.statusCode}");
  } catch (e) {
    print("GET hqdefault.jpg Error: $e");
  }
}
