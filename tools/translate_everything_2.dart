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
    // Modes
    Rep('lib/features/flashcards/presentation/widgets/modes/listening_mode.dart',
        r"const Text('Listening Mode')", r"Text(AppLocalizations.of(context)!.listeningMode)", 'listeningMode', 'Listening Mode'),
    Rep('lib/features/flashcards/presentation/widgets/modes/reading_mode.dart',
        r"const Text('Reading Mode')", r"Text(AppLocalizations.of(context)!.readingMode)", 'readingMode', 'Reading Mode'),
    Rep('lib/features/flashcards/presentation/widgets/modes/recall_mode.dart',
        r"const Text('Recall Mode')", r"Text(AppLocalizations.of(context)!.recallMode)", 'recallMode', 'Recall Mode'),
    Rep('lib/features/flashcards/presentation/widgets/modes/speaking_mode.dart',
        r"const Text('Speaking Mode')", r"Text(AppLocalizations.of(context)!.speakingMode)", 'speakingMode', 'Speaking Mode'),
        
    // Character Details
    Rep('lib/features/flashcards/presentation/screens/character_detail_screen.dart',
        r"const Text('AI Memory Hook')", r"Text(AppLocalizations.of(context)!.aiMemoryHook)", 'aiMemoryHook', 'AI Memory Hook'),
    Rep('lib/features/flashcards/presentation/screens/character_detail_screen.dart',
        r"const Text('Example Sentences')", r"Text(AppLocalizations.of(context)!.exampleSentences)", 'exampleSentences', 'Example Sentences'),
    Rep('lib/features/flashcards/presentation/screens/character_detail_screen.dart',
        r"const Text('Ghost Characters')", r"Text(AppLocalizations.of(context)!.ghostCharacters)", 'ghostCharacters', 'Ghost Characters'),
    Rep('lib/features/flashcards/presentation/screens/character_detail_screen.dart',
        r"const Text('Common Words')", r"Text(AppLocalizations.of(context)!.commonWords)", 'commonWords', 'Common Words'),
    Rep('lib/features/flashcards/presentation/screens/character_detail_screen.dart',
        r"const Text('Personal Notes')", r"Text(AppLocalizations.of(context)!.personalNotes)", 'personalNotes', 'Personal Notes'),
    Rep('lib/features/flashcards/presentation/screens/character_detail_screen.dart',
        r"hintText: 'Add your own mnemonics or notes here...'", r"hintText: AppLocalizations.of(context)!.addPersonalNotes", 'addPersonalNotes', 'Add your own mnemonics or notes here...'),

    // Universal Scanner
    Rep('lib/features/premium/presentation/screens/universal_scanner_screen.dart',
        r"const Text('Take Photo')", r"Text(AppLocalizations.of(context)!.takePhoto)", 'takePhoto', 'Take Photo'),
    Rep('lib/features/premium/presentation/screens/universal_scanner_screen.dart',
        r"const Text('Gallery')", r"Text(AppLocalizations.of(context)!.gallery)", 'gallery', 'Gallery'),
    Rep('lib/features/premium/presentation/screens/universal_scanner_screen.dart',
        r"const Text('AR Lens')", r"Text(AppLocalizations.of(context)!.arLens)", 'arLens', 'AR Lens'),

    // Deck review
    Rep('lib/features/flashcards/presentation/screens/deck_review_session_screen.dart',
        r"content: Text('Added $char to Library')", r"content: Text(AppLocalizations.of(context)!.addedCharToLibrary(char))", 'addedCharToLibrary', 'Added {char} to Library', {'char': 'String'}),

    // Echo Hall Conversation
    Rep('lib/features/echo_hall/presentation/screens/conversation_screen.dart',
        r"Text('score', style: theme.textTheme.labelSmall)", r"Text(AppLocalizations.of(context)!.scoreText, style: theme.textTheme.labelSmall)", 'scoreText', 'score'),
    
    // UI misc
    Rep('lib/features/flashcards/presentation/screens/dictionary_screen.dart',
        r"hintText: 'Search character, pinyin, or meaning...'", r"hintText: AppLocalizations.of(context)!.searchDictionaryHint", 'searchDictionaryHint', 'Search character, pinyin, or meaning...'),
    Rep('lib/features/flashcards/presentation/screens/deck_detail_screen.dart',
        r"hintText: 'Search character, pinyin...'", r"hintText: AppLocalizations.of(context)!.searchDeckHint", 'searchDeckHint', 'Search character, pinyin...'),
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
