import 'dart:io';
import 'dart:convert';

void main() {
  final dirLib = Directory('lib');
  final dartFiles = dirLib.listSync(recursive: true).where((f) => f.path.endsWith('.dart'));

  final RegExp exp = RegExp(r'l10n\??\.([a-zA-Z0-9_]+)');
  final Set<String> foundKeys = {};

  for (var file in dartFiles) {
    if (file is File) {
      final content = file.readAsStringSync();
      final matches = exp.allMatches(content);
      for (var m in matches) {
        foundKeys.add(m.group(1)!);
      }
    }
  }

  // Common things that might not be actual keys
  foundKeys.remove('localeName');
  foundKeys.remove('toString');
  foundKeys.remove('of');

  final dirArb = Directory('lib/l10n');
  final arbFiles = dirArb.listSync().where((f) => f.path.endsWith('.arb'));

  for (var file in arbFiles) {
    if (file is File) {
      final content = file.readAsStringSync();
      final Map<String, dynamic> data = json.decode(content);
      
      bool changed = false;
      for (var k in foundKeys) {
        if (!data.containsKey(k) && !k.startsWith('_')) {
          // Just use the key name as a fallback to make it compile!
          // We split camelCase for readability if possible
          final fallback = k.replaceAllMapped(RegExp(r'[A-Z]'), (m) => ' ${m.group(0)}').trim();
          data[k] = fallback[0].toUpperCase() + fallback.substring(1);
          changed = true;
        }
      }
      
      if (changed) {
        file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(data));
      }
    }
  }
  
  print('Injected missing keys: ${foundKeys.length}');
}
