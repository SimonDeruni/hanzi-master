import 'dart:io';

void main() {
  final dir = Directory('lib');
  final files = dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));
  
  final regexes = [
    RegExp(r'const\s+(SnackBar\s*\(\s*content:\s*Text\s*\(\s*AppLocalizations)'),
    RegExp(r'const\s+(Center\s*\(\s*child:\s*Text\s*\(\s*AppLocalizations)'),
    RegExp(r'const\s+(Text\s*\(\s*AppLocalizations)'),
    RegExp(r'const\s+(FittedBox\s*\(\s*fit:\s*BoxFit\.scaleDown,\s*child:\s*Text\s*\(\s*AppLocalizations)'),
  ];
  
  for (final file in files) {
    String content = file.readAsStringSync();
    bool modified = false;
    
    // First, simple replacements for exact matches
    for (final regex in regexes) {
      if (regex.hasMatch(content)) {
        content = content.replaceAllMapped(regex, (match) => match.group(1)!);
        modified = true;
      }
    }

    // Also look for `const\s*\n\s*SnackBar` and similar patterns
    final multilineRegexes = [
      RegExp(r'const\s*\n\s*(SnackBar\s*\(\s*content:\s*Text\s*\(\s*AppLocalizations)'),
      RegExp(r'const\s*\n\s*(Center\s*\(\s*child:\s*Text\s*\(\s*AppLocalizations)'),
      RegExp(r'const\s*\n\s*(Text\s*\(\s*AppLocalizations)'),
      RegExp(r'const\s*\n\s*(FittedBox\s*\(\s*fit:\s*BoxFit\.scaleDown,\s*child:\s*Text\s*\(\s*AppLocalizations)'),
    ];
    
    for (final regex in multilineRegexes) {
      if (regex.hasMatch(content)) {
        content = content.replaceAllMapped(regex, (match) => match.group(1)!);
        modified = true;
      }
    }
    
    if (modified) {
      file.writeAsStringSync(content);
      print('Fixed const in \${file.path}');
    }
  }
}
