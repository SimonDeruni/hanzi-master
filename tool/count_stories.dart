import 'dart:convert';
import 'dart:io';

void main() {
  int countStories(String path) {
    try {
      final file = File(path);
      if (!file.existsSync()) return 0;
      final data = jsonDecode(file.readAsStringSync());
      if (data is List) return data.length;
      if (data is Map) {
        if (data.containsKey('stories') && data['stories'] is List) {
          return (data['stories'] as List).length;
        }
        return data.keys.length; // e.g. default_stories might be a map of keys to stories
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  final idioms = countStories('assets/data/1000_stories.json');
  final poetry = countStories('assets/data/tang_poetry.json');
  final defaultStories = countStories('assets/default_stories.json');
  
  print('Idiom Stories: $idioms');
  print('Tang Poetry: $poetry');
  print('Default Graded Stories: $defaultStories');
  print('Total Static Stories: ${idioms + poetry + defaultStories}');
}
