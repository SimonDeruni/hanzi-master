import 'dart:io';

void main() {
  final l10nDir = Directory('lib/l10n');
  final arbFiles = l10nDir.listSync().whereType<File>().where((f) => f.path.endsWith('.arb'));
  
  for (final file in arbFiles) {
    String content = file.readAsStringSync();
    if (content.contains('"continue":')) {
      content = content.replaceAll('"continue":', '"continueText":');
      file.writeAsStringSync(content);
      print('Updated \${file.path}');
    }
  }

  final dartDir = Directory('lib');
  final dartFiles = dartDir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));
  
  for (final file in dartFiles) {
    String content = file.readAsStringSync();
    if (content.contains('.continue')) {
      // Be careful, only replace if it's l10n.continue or similar AppLocalizations
      content = content.replaceAll('AppLocalizations.of(context)!.continue', 'AppLocalizations.of(context)!.continueText');
      content = content.replaceAll('l10n.continue', 'l10n.continueText');
      file.writeAsStringSync(content);
      print('Updated \${file.path}');
    }
  }
}
