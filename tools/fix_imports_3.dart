import 'dart:io';

void main() {
  final dir = Directory('lib');
  final files = dir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));
  
  for (final file in files) {
    String content = file.readAsStringSync();
    if (content.contains('package:flutter_gen/gen_l10n/app_localizations.dart')) {
      content = content.replaceAll(
        'package:flutter_gen/gen_l10n/app_localizations.dart',
        'package:hanzi_master/l10n/app_localizations.dart'
      );
      file.writeAsStringSync(content);
      print('Fixed import in \${file.path}');
    }
  }
}
