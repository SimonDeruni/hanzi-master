import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

void main() async {
  final url = 'https://mandarinbean.com/feed/?paged=1';
  final response = await http.get(Uri.parse(url));
  final document = XmlDocument.parse(response.body);
  final items = document.findAllElements('item').take(1);
  for (var item in items) {
    final description = item.findElements('content:encoded').first.innerText;
    var matches = RegExp(r'<p(>|\s[^>]*>)(.*?)</p>', dotAll: true).allMatches(description);
    for(var m in matches) {
      String clean = m.group(2)!.replaceAll(RegExp(r'<[^>]*>'), '').trim();
      if(clean.isNotEmpty) print('P: ' + clean);
    }
  }
}
