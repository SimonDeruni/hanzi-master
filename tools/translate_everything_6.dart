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
    Rep('lib/features/reading/presentation/widgets/custom_story_creator_sheet.dart',
        "tooltip: 'Scan Text',", "tooltip: AppLocalizations.of(context)!.scanText,", 'scanText', 'Scan Text'),
    Rep('lib/features/reading/presentation/widgets/custom_story_creator_sheet.dart',
        "const Text('Create Magic',", "Text(AppLocalizations.of(context)!.createMagic,", 'createMagic', 'Create Magic'),

    Rep('lib/features/flashcards/presentation/screens/deck_detail_screen.dart',
        "\"Learning\"", "AppLocalizations.of(context)!.learning", 'learning', 'Learning'),
    Rep('lib/features/flashcards/presentation/screens/deck_detail_screen.dart',
        "\"Mastered\"", "AppLocalizations.of(context)!.masteredStatus", 'masteredStatus', 'Mastered'),

    Rep('lib/features/flashcards/presentation/screens/stats_screen.dart',
        "title: \"Total Words\"", "title: AppLocalizations.of(context)!.totalWords", 'totalWords', 'Total Words'),
    Rep('lib/features/flashcards/presentation/screens/stats_screen.dart',
        "title: \"New Ink\"", "title: AppLocalizations.of(context)!.newInk", 'newInk', 'New Ink'),
    Rep('lib/features/flashcards/presentation/screens/stats_screen.dart',
        "title: \"Learning\"", "title: AppLocalizations.of(context)!.learning", 'learning', 'Learning'),
    Rep('lib/features/flashcards/presentation/screens/stats_screen.dart',
        "title: \"Mastered\"", "title: AppLocalizations.of(context)!.masteredStatus", 'masteredStatus', 'Mastered'),
    Rep('lib/features/flashcards/presentation/screens/stats_screen.dart',
        "const Text(\"Library Mastery\",", "Text(AppLocalizations.of(context)!.libraryMastery,", 'libraryMastery', 'Library Mastery'),
    Rep('lib/features/flashcards/presentation/screens/stats_screen.dart',
        "const Text(\"Accuracy by Mode\",", "Text(AppLocalizations.of(context)!.accuracyByMode,", 'accuracyByMode', 'Accuracy by Mode'),
    Rep('lib/features/flashcards/presentation/screens/stats_screen.dart',
        "const Text(\"Upcoming Reviews (Next 7 Days)\",", "Text(AppLocalizations.of(context)!.upcomingReviews7Days,", 'upcomingReviews7Days', 'Upcoming Reviews (Next 7 Days)'),

    Rep('lib/features/flashcards/presentation/widgets/learning_stats_card.dart',
        "\"Listening Mode\"", "AppLocalizations.of(context)!.listeningMode", 'listeningMode', 'Listening Mode'),
    Rep('lib/features/flashcards/presentation/widgets/learning_stats_card.dart',
        "\"Reading Mode\"", "AppLocalizations.of(context)!.readingMode", 'readingMode', 'Reading Mode'),
    Rep('lib/features/flashcards/presentation/widgets/learning_stats_card.dart',
        "\"Recall Mode\"", "AppLocalizations.of(context)!.recallMode", 'recallMode', 'Recall Mode'),
    Rep('lib/features/flashcards/presentation/widgets/learning_stats_card.dart',
        "\"Speaking Mode\"", "AppLocalizations.of(context)!.speakingMode", 'speakingMode', 'Speaking Mode'),
        
    // Fix error in Premium reading room
    Rep('lib/features/premium/presentation/screens/reading_room_screen.dart',
        "Text(AppLocalizations.of(context)!.failedToGenerateStory(e.toString()))", "Text(AppLocalizations.of(context)!.failedToGenerateStory(e.toString()))", 'failedToGenerateStory', 'Failed to generate story:\\n{error}', {'error': 'String'}),
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
