import 'dart:io';
import 'dart:convert';

void main() {
  final dir = Directory('lib');
  final files = dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));
  
  final arbFile = File('lib/l10n/app_en.arb');
  final arbData = jsonDecode(arbFile.readAsStringSync()) as Map<String, dynamic>;
  bool arbUpdated = false;

  final textRegex = RegExp(r'(?<!const\s)Text\(\s*"([^"]+)"\s*(?:,|\))');
  final constTextRegex = RegExp(r'const\s+Text\(\s*"([^"]+)"\s*(?:,|\))');

  String generateKey(String text) {
    var key = text.replaceAll(RegExp(r'[^a-zA-Z0-9 ]'), '').trim();
    if (key.isEmpty) return 'text_${DateTime.now().millisecondsSinceEpoch}';
    
    List<String> words = key.split(RegExp(r'\s+'));
    if (words.length > 4) words = words.sublist(0, 4);
    
    String finalKey = words[0].toLowerCase();
    for (int i = 1; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        finalKey += words[i].substring(0, 1).toUpperCase() + words[i].substring(1).toLowerCase();
      }
    }
    return finalKey;
  }

  for (final file in files) {
    String content = file.readAsStringSync();
    bool fileUpdated = false;
    bool needsImport = false;

    // Process const Text("...")
    content = content.replaceAllMapped(constTextRegex, (match) {
      final text = match.group(1)!;
      if (text.contains(r'$') || text.isEmpty) return match.group(0)!; // Skip interpolated or empty
      
      final key = generateKey(text);
      if (!arbData.containsKey(key)) {
        arbData[key] = text;
        arbUpdated = true;
      }
      
      fileUpdated = true;
      needsImport = true;
      final original = match.group(0)!;
      return original.replaceFirst('const Text(', 'Text(').replaceFirst('"$text"', 'AppLocalizations.of(context)!.$key');
    });

    // Process Text("...")
    content = content.replaceAllMapped(textRegex, (match) {
      final text = match.group(1)!;
      if (text.contains(r'$') || text.isEmpty) return match.group(0)!; // Skip interpolated or empty
      
      final key = generateKey(text);
      if (!arbData.containsKey(key)) {
        arbData[key] = text;
        arbUpdated = true;
      }
      
      fileUpdated = true;
      needsImport = true;
      final original = match.group(0)!;
      return original.replaceFirst('"$text"', 'AppLocalizations.of(context)!.$key');
    });

    if (fileUpdated) {
      if (needsImport && !content.contains('app_localizations.dart')) {
        // add import at top
        content = "import 'package:flutter_gen/gen_l10n/app_localizations.dart';\n" + content;
      }
      file.writeAsStringSync(content);
      print('Updated ${file.path}');
    }
  }

  if (arbUpdated) {
    arbFile.writeAsStringSync(JsonEncoder.withIndent('  ').convert(arbData));
    print('Updated app_en.arb with new keys');
  } else {
    print('No new keys found.');
  }
}
