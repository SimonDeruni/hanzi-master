import 'dart:io';
import 'dart:convert';

class Rep {
  final String path;
  final String original;
  final String replacement;
  final String key;
  final String enValue;
  final Map<String, String>? placeholders;

  Rep(this.path, this.original, this.replacement, this.key, this.enValue, [this.placeholders]);
}

void main() {
  final l10nFile = File('lib/l10n/app_en.arb');
  final l10nData = jsonDecode(l10nFile.readAsStringSync()) as Map<String, dynamic>;
  bool arbUpdated = false;

  final reps = [
    Rep('lib/features/settings/presentation/screens/contact_screen.dart',
        'title: "Report a Bug",', 'title: AppLocalizations.of(context)!.reportBug,', 'reportBug', 'Report a Bug'),
    Rep('lib/features/settings/presentation/screens/contact_screen.dart',
        'title: "Suggest a Feature",', 'title: AppLocalizations.of(context)!.suggestFeature,', 'suggestFeature', 'Suggest a Feature'),
    Rep('lib/features/settings/presentation/screens/contact_screen.dart',
        'title: "General Feedback",', 'title: AppLocalizations.of(context)!.generalFeedback,', 'generalFeedback', 'General Feedback'),
    Rep('lib/features/echo_hall/presentation/screens/live_call_screen.dart',
        'tooltip: "Undo",', 'tooltip: AppLocalizations.of(context)!.undo,', 'undo', 'Undo'),
    Rep('lib/features/echo_hall/presentation/screens/live_call_screen.dart',
        'tooltip: "Clear",', 'tooltip: AppLocalizations.of(context)!.clear,', 'clear', 'Clear'),
    Rep('lib/features/echo_hall/presentation/screens/conversation_screen.dart',
        'tooltip: "Clear chat",', 'tooltip: AppLocalizations.of(context)!.clearChat,', 'clearChat', 'Clear chat'),
    Rep('lib/features/echo_hall/presentation/screens/conversation_screen.dart',
        "hintText: 'Type your message...'", "hintText: AppLocalizations.of(context)!.typeMessage,", 'typeMessage', 'Type your message...'),
  ];

  for (final rep in reps) {
    if (!l10nData.containsKey(rep.key)) {
      l10nData[rep.key] = rep.enValue;
      if (rep.placeholders != null) {
        l10nData['@\${rep.key}'] = {
          'placeholders': rep.placeholders!.map((k, v) => MapEntry(k, {'type': v}))
        };
      }
      arbUpdated = true;
    }

    final file = File(rep.path);
    if (file.existsSync()) {
      var content = file.readAsStringSync();
      if (content.contains(rep.original)) {
        content = content.replaceAll(rep.original, rep.replacement);
        
        if (!content.contains('app_localizations.dart')) {
          content = "import 'package:flutter_gen/gen_l10n/app_localizations.dart';\n" + content;
        }
        
        file.writeAsStringSync(content);
        print('Updated \${rep.path}');
      }
    }
  }

  if (arbUpdated) {
    l10nFile.writeAsStringSync(JsonEncoder.withIndent('  ').convert(l10nData));
    print('Updated app_en.arb');
  }
}
