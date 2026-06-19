import 'dart:convert';
import 'dart:io';

void main() {
  // 1. Process app_en.arb
  final enFile = File('lib/l10n/app_en.arb');
  final enContent = enFile.readAsStringSync();
  final Map<String, dynamic> enData = jsonDecode(enContent);

  if (enData.containsKey('poweredByGemini')) {
    enData.remove('poweredByGemini');
  }
  enData['poweredByAi'] = "Powered by advanced AI. Seamless real-time translation for any scenario.";

  enFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(enData));

  // 2. Process other arb files
  final dir = Directory('lib/l10n');
  final arbFiles = dir.listSync().whereType<File>().where((f) => f.path.endsWith('.arb'));

  for (final file in arbFiles) {
    final fileName = file.path.split(Platform.pathSeparator).last;
    if (fileName == 'app_en.arb') continue;

    final content = file.readAsStringSync();
    final Map<String, dynamic> data = jsonDecode(content);

    bool changed = false;
    if (data.containsKey('poweredByGemini')) {
      data.remove('poweredByGemini');
      changed = true;
    }
    
    // Also remove poweredByAi if it exists so it gets re-translated
    if (data.containsKey('poweredByAi')) {
      data.remove('poweredByAi');
      changed = true;
    }

    if (changed) {
      file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(data));
    }
  }

  print("Arb files updated for poweredByAi!");
}
