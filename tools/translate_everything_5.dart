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
    Rep('lib/features/flashcards/presentation/widgets/deck_selection_sheet.dart',
        "Text('Added to \${deck.name}!')", "Text(AppLocalizations.of(context)!.addedToDeck(deck.name))", 
        'addedToDeck', 'Added to {deckName}!', {'deckName': 'String'}),
        
    Rep('lib/features/flashcards/presentation/widgets/dictionary_search_delegate.dart',
        "Text('Added \\'\$hanzi\\' to your Library')", "Text(AppLocalizations.of(context)!.addedToLibrary(hanzi))", 
        'addedToLibrary', "Added '{hanzi}' to your Library", {'hanzi': 'String'}),

    Rep('lib/features/premium/presentation/screens/reading_room_screen.dart',
        "Text('Generate New Story')", "Text(AppLocalizations.of(context)!.generateNewStory)", 'generateNewStory', 'Generate New Story'),

    Rep('lib/features/premium/presentation/screens/reading_room_screen.dart',
        "Text('Failed to generate story:\\n\$e')", "Text(AppLocalizations.of(context)!.failedToGenerateStory(e.toString()))", 'failedToGenerateStory', 'Failed to generate story:\\n{error}', {'error': 'String'}),

    Rep('lib/features/premium/presentation/screens/story_reader_screen.dart',
        "Text('Detail')", "Text(AppLocalizations.of(context)!.detail)", 'detail', 'Detail'),
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
