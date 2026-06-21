import 'dart:io';

void main() {
  final filesToImport = [
    'lib/core/presentation/widgets/handwriting_canvas.dart',
    'lib/features/echo_hall/presentation/widgets/live_call_summary_screen.dart',
    'lib/features/flashcards/presentation/widgets/drawing_canvas.dart',
  ];

  for (final path in filesToImport) {
    final file = File(path);
    if (file.existsSync()) {
      var content = file.readAsStringSync();
      if (!content.contains('app_localizations.dart')) {
        content = "import 'package:flutter_gen/gen_l10n/app_localizations.dart';\n" + content;
        file.writeAsStringSync(content);
        print('Added import to $path');
      }
    }
  }
}
