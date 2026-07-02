import 'dart:io';
import 'package:xml/xml.dart';

void main() async {
  final client = HttpClient();
  final request = await client.getUrl(Uri.parse('https://mandarinbean.com/feed/'));
  request.headers.set('User-Agent', 'Mozilla/5.0');
  final response = await request.close();
  final body = await response.transform(SystemEncoding().decoder).join();
  
  final doc = XmlDocument.parse(body);
  final items = doc.findAllElements('item');
  
  for (final item in items) {
    final title = item.findElements('title').firstOrNull?.innerText ?? 'no title';
    final cats = item.findElements('category').map((e) => e.innerText).toList();
    print('TITLE: $title');
    print('CATS: $cats');
    print('---');
  }
  client.close();
}
