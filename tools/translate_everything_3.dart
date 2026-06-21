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
    // Character Detail Screen
    Rep('lib/features/flashcards/presentation/screens/character_detail_screen.dart',
        'title: "AI Memory Hook"', 'title: AppLocalizations.of(context)!.aiMemoryHook', 'aiMemoryHook', 'AI Memory Hook'),
    Rep('lib/features/flashcards/presentation/screens/character_detail_screen.dart',
        'title: "Example Sentences"', 'title: AppLocalizations.of(context)!.exampleSentences', 'exampleSentences', 'Example Sentences'),
    Rep('lib/features/flashcards/presentation/screens/character_detail_screen.dart',
        'title: "Ghost Characters"', 'title: AppLocalizations.of(context)!.ghostCharacters', 'ghostCharacters', 'Ghost Characters'),
    Rep('lib/features/flashcards/presentation/screens/character_detail_screen.dart',
        'title: "Common Words"', 'title: AppLocalizations.of(context)!.commonWords', 'commonWords', 'Common Words'),
    Rep('lib/features/flashcards/presentation/screens/character_detail_screen.dart',
        'title: "Personal Notes"', 'title: AppLocalizations.of(context)!.personalNotes', 'personalNotes', 'Personal Notes'),

    // Echo Hall Scenarios
    Rep('lib/features/echo_hall/presentation/screens/conversation_screen.dart',
        r"'score'", r"AppLocalizations.of(context)!.scoreText", 'scoreText', 'score'),

    Rep('lib/features/echo_hall/data/default_scenarios.dart',
        "'Local Restaurant'", "AppLocalizations.of(context)!.localRestaurant", 'localRestaurant', 'Local Restaurant'),
    Rep('lib/features/echo_hall/data/default_scenarios.dart',
        "'Taxi to Airport'", "AppLocalizations.of(context)!.taxiToAirport", 'taxiToAirport', 'Taxi to Airport'),
    Rep('lib/features/echo_hall/data/default_scenarios.dart',
        "'Silk Market Haggling'", "AppLocalizations.of(context)!.silkMarketHaggling", 'silkMarketHaggling', 'Silk Market Haggling'),
    Rep('lib/features/echo_hall/data/default_scenarios.dart',
        "'Medical Clinic'", "AppLocalizations.of(context)!.medicalClinic", 'medicalClinic', 'Medical Clinic'),
    Rep('lib/features/echo_hall/data/default_scenarios.dart',
        "'Meeting a Friend'", "AppLocalizations.of(context)!.meetingAFriend", 'meetingAFriend', 'Meeting a Friend'),
    Rep('lib/features/echo_hall/data/default_scenarios.dart',
        "'Job Interview'", "AppLocalizations.of(context)!.jobInterview", 'jobInterview', 'Job Interview'),
        
    // Miscellaneous
    Rep('lib/features/premium/presentation/screens/universal_scanner_screen.dart',
        'label: "Take Photo"', 'label: AppLocalizations.of(context)!.takePhoto', 'takePhoto', 'Take Photo'),
    Rep('lib/features/premium/presentation/screens/universal_scanner_screen.dart',
        'label: "Gallery"', 'label: AppLocalizations.of(context)!.gallery', 'gallery', 'Gallery'),
    Rep('lib/features/premium/presentation/screens/universal_scanner_screen.dart',
        'label: "AR Lens"', 'label: AppLocalizations.of(context)!.arLens', 'arLens', 'AR Lens'),

    Rep('lib/features/echo_hall/presentation/widgets/live_call_summary_screen.dart',
        'const Text("CONVERSATION REVIEW")', 'Text(AppLocalizations.of(context)!.conversationReview)', 'conversationReview', 'CONVERSATION REVIEW'),
    Rep('lib/features/echo_hall/presentation/widgets/live_call_summary_screen.dart',
        'const Text("Linguistic Analysis")', 'Text(AppLocalizations.of(context)!.linguisticAnalysis)', 'linguisticAnalysis', 'Linguistic Analysis'),
    
    // Dictionary
    Rep('lib/features/flashcards/presentation/screens/dictionary_screen.dart',
        r"'Search radicals (e.g. Water, 氵)'", r"AppLocalizations.of(context)!.searchRadicalsHint", 'searchRadicalsHint', 'Search radicals (e.g. Water, 氵)'),
    Rep('lib/features/flashcards/presentation/screens/dictionary_screen.dart',
        r"const Text('Definition')", r"Text(AppLocalizations.of(context)!.definition)", 'definition', 'Definition'),

    // Deck review
    Rep('lib/features/flashcards/presentation/screens/deck_review_session_screen.dart',
        r"const Text('UNDO')", r"Text(AppLocalizations.of(context)!.undo)", 'undo', 'UNDO'),

    // More
    Rep('lib/features/flashcards/presentation/screens/main_navigation_screen.dart',
        r"const Text('Hanzi Master')", r"Text(AppLocalizations.of(context)!.hanziMaster)", 'hanziMaster', 'Hanzi Master'),

    Rep('lib/features/premium/presentation/screens/premium_paywall_screen.dart',
        r"'Unlock Forever - \$9.99'", r"AppLocalizations.of(context)!.unlockForever", 'unlockForever', 'Unlock Forever - \$9.99'),
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
