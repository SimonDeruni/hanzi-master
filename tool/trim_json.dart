import 'dart:convert';
import 'dart:io';

void trimJsonFile(String path, int count) {
  final file = File(path);
  if (!file.existsSync()) {
    print('File not found: $path');
    return;
  }
  
  final rawData = file.readAsStringSync();
  final data = jsonDecode(rawData);
  
  if (data is List) {
    if (data.length <= count) {
      print('$path is already <= $count. (Length: ${data.length})');
      return;
    }
    final trimmedList = data.sublist(0, count);
    
    // Write back pretty printed
    final encoder = JsonEncoder.withIndent('  ');
    file.writeAsStringSync(encoder.convert(trimmedList));
    print('Trimmed $path to $count entries.');
  } else {
    print('$path is not a JSON List.');
  }
}

void main() {
  trimJsonFile('assets/data/1000_stories.json', 150);
  trimJsonFile('assets/data/tang_poetry.json', 150);
}
