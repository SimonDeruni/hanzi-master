import 'dart:io';
import 'dart:convert';

void main() {
  final dir = Directory('lib/l10n');
  final files = dir.listSync().whereType<File>().where((f) => f.path.endsWith('.arb'));
  
  for (final file in files) {
    final content = file.readAsStringSync();
    final data = jsonDecode(content) as Map<String, dynamic>;
    
    if (!data.containsKey('appLanguage')) {
      data['appLanguage'] = 'App Language';
      if (file.path.endsWith('app_en.arb')) {
        data['@appLanguage'] = {'description': 'Label for the app language setting'};
      }
      file.writeAsStringSync(JsonEncoder.withIndent('  ').convert(data));
      print('Updated ${file.path}');
    }
  }
}
