import 'dart:io';

void main() {
  final content = File(r'C:\Users\simon\.gemini\antigravity\brain\e9e0dddf-13d1-440b-aba6-a6c104a305f7\.system_generated\steps\6888\content.md').readAsStringSync();
  final re = RegExp(r'"download_url":"([^"]+)"');
  final matches = re.allMatches(content).take(3);
  for (final m in matches) {
    print(m.group(1));
  }
}
