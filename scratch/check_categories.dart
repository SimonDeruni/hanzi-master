import 'dart:io';
import 'package:xml/xml.dart';

void main() {
  final file = File('scratch/feed2.xml');
  final document = XmlDocument.parse(file.readAsStringSync());
  final items = document.findAllElements('item');
  for (final item in items) {
    final title = item.findElements('title').firstOrNull?.innerText;
    final categories = item.findElements('category').map((e) => e.innerText).toList();
    print('Title: $title\nCategories: $categories\n');
  }
}
