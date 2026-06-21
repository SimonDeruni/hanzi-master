import 'dart:io';

void main() {
  final dir = Directory('lib');
  final files = dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));
  
  final regexes = [
    RegExp(r"Text\(\s*'((?:\\'|[^'])+)'"),
    RegExp(r'Text\(\s*"((?:\\"|[^"])+)"'),
    RegExp(r"(?:title|subtitle|label|hintText|tooltip|content):\s*'((?:\\'|[^'])+)'"),
    RegExp(r'(?:title|subtitle|label|hintText|tooltip|content):\s*"((?:\\"|[^"])+)"'),
  ];
  
  for (final file in files) {
    final lines = file.readAsLinesSync();
    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      if (line.contains('AppLocalizations')) continue;
      if (line.contains('RegExp')) continue; // Skip regexes
      if (line.contains('Exception(') || line.contains('Error(') || line.contains('throw ')) continue; // Skip errors
      
      for (final regex in regexes) {
        final matches = regex.allMatches(line);
        for (final match in matches) {
          final str = match.group(1)!;
          // Skip single character, pure numbers, or empty strings
          if (str.length <= 1) continue;
          if (double.tryParse(str) != null) continue;
          // Skip if it looks like a route or icon path
          if (str.startsWith('/')) continue;
          if (str.startsWith('assets/')) continue;
          
          print('\${file.path}:\${i+1}: $str');
        }
      }
    }
  }
}
