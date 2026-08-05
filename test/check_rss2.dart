import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

void main() async {
  const url = 'https://mandarinbean.com/feed/?paged=1';
  final response = await http.get(Uri.parse(url));
  final document = XmlDocument.parse(response.body);
  final items = document.findAllElements('item').take(1);
  for (var item in items) {
    final description = item.findElements('description').first.innerText;
    print('RAW DESC: $description');
    final pMatch = RegExp(r'<p>(.*?)</p>').firstMatch(description);
    String summary = '';
    if (pMatch != null) {
      summary = pMatch.group(1)!.replaceAll(RegExp(r'<[^>]*>'), '');
    } else {
      summary = description.replaceAll(RegExp(r'<[^>]*>'), '');
    }
    print('SUMMARY: $summary');
  }
}
