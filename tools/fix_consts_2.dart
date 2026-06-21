import 'dart:io';

void main() {
  final dir = Directory('lib');
  final files = dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));
  
  for (final file in files) {
    List<String> lines = file.readAsLinesSync();
    bool modified = false;
    
    for (int i = 0; i < lines.length; i++) {
      if (lines[i].contains('const ') && lines[i].contains('AppLocalizations.of')) {
        // remove all "const " on this line if it has AppLocalizations
        lines[i] = lines[i].replaceAll('const ', '');
        modified = true;
      }
    }
    
    if (modified) {
      file.writeAsStringSync(lines.join('\n') + '\n');
      print('Fixed \${file.path}');
    }
  }
}
