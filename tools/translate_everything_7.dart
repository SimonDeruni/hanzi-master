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
    // Live translate / translation detail
    Rep('lib/features/live_translate/presentation/screens/translation_session_detail_screen.dart',
        "const Text('Session Details',", "Text(AppLocalizations.of(context)!.sessionDetails,", 'sessionDetails', 'Session Details'),
    Rep('lib/features/live_translate/presentation/screens/translation_session_detail_screen.dart',
        "const Text('AI Breakdown',", "Text(AppLocalizations.of(context)!.aiBreakdown,", 'aiBreakdown', 'AI Breakdown'),
    Rep('lib/features/live_translate/presentation/screens/translation_session_detail_screen.dart',
        "hintText: 'Ask a follow-up question...',", "hintText: AppLocalizations.of(context)!.askFollowUpQuestion,", 'askFollowUpQuestion', 'Ask a follow-up question...'),

    // Library and reading
    Rep('lib/features/reading/presentation/widgets/custom_story_creator_sheet.dart',
        "labelText: 'Paste or scan Chinese text to simplify',", "labelText: AppLocalizations.of(context)!.pasteScanToSimplify,", 'pasteScanToSimplify', 'Paste or scan Chinese text to simplify'),
    Rep('lib/features/reading/presentation/screens/reading_room_screen.dart',
        "hintText: 'Search stories by title or tags (e.g. mythology, travel)',", "hintText: AppLocalizations.of(context)!.searchStoriesHint,", 'searchStoriesHint', 'Search stories by title or tags (e.g. mythology, travel)'),

    // Settings
    Rep('lib/features/settings/presentation/screens/settings_screen.dart',
        "title: \"Import All\",", "title: AppLocalizations.of(context)!.importAll,", 'importAll', 'Import All'),
    Rep('lib/features/settings/presentation/screens/settings_screen.dart',
        "title: \"Ascend All\",", "title: AppLocalizations.of(context)!.ascendAll,", 'ascendAll', 'Ascend All'),
    Rep('lib/features/settings/presentation/screens/settings_screen.dart',
        "const Text('Start Ascension'),", "Text(AppLocalizations.of(context)!.startAscension),", 'startAscension', 'Start Ascension'),

    // Dictionary / Anatomy
    Rep('lib/features/flashcards/presentation/widgets/character_anatomy_widget.dart',
        "Text('Trace the Radical: \${widget.sunNode.hanzi}')", "Text(AppLocalizations.of(context)!.traceRadical(widget.sunNode.hanzi))", 'traceRadical', 'Trace the Radical: {hanzi}', {'hanzi': 'String'}),
    Rep('lib/features/flashcards/presentation/widgets/character_anatomy_widget.dart',
        "Text('Find characters with \${widget.sunNode.hanzi}')", "Text(AppLocalizations.of(context)!.findCharactersWith(widget.sunNode.hanzi))", 'findCharactersWith', 'Find characters with {hanzi}', {'hanzi': 'String'}),
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
          content = "import 'package:flutter_gen/gen_l10n/app_localizations.dart';\n$content";
        }
        
        file.writeAsStringSync(content);
        print('Updated \${rep.path}');
      }
    }
  }

  if (arbUpdated) {
    l10nFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(l10nData));
    print('Updated app_en.arb');
  }
}
