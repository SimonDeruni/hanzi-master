import 'dart:io';
import 'dart:convert';

void main() {
  final keys = {
    "strokeAnalysis": "Stroke Analysis",
    "excellentWork": "Excellent work!",
    "keepPracticing": "Keep practicing!",
    "drawingSubmitted": "Drawing Submitted",
    "customPersonaHint": "Define a custom persona...",
    "stepOneOrigin": "STEP 1: THE ORIGIN",
    "stepTwoForge": "STEP 2: THE FORGE",
    "toForge": "To forge",
    "whatEssenceDoesNeed": "what essence does",
    "need": "need",
    "forged": "FORGED",
    "stepThreeHunt": "STEP 3: THE HUNT",
    "findCharactersWith": "Find characters with",
    "uninstallButton": "UNINSTALL"
  };

  final dir = Directory('lib/l10n');
  final files = dir.listSync().where((f) => f.path.endsWith('.arb'));

  for (var file in files) {
    if (file is File) {
      final content = file.readAsStringSync();
      final Map<String, dynamic> data = json.decode(content);
      
      bool changed = false;
      keys.forEach((k, v) {
        if (!data.containsKey(k)) {
          data[k] = v;
          changed = true;
        }
      });
      
      if (changed) {
        file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(data));
      }
    }
  }
}
