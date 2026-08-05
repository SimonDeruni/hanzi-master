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
    // settings_screen.dart
    Rep('lib/features/flashcards/presentation/screens/settings_screen.dart',
        r'subtitle: "Hide stroke guide at streak: ${settings.guideDisappearanceStreak}"',
        r'subtitle: l10n?.hideStrokeGuideStreak(settings.guideDisappearanceStreak) ?? "Hide stroke guide at streak: ${settings.guideDisappearanceStreak}"',
        'hideStrokeGuideStreak', 'Hide stroke guide at streak: {streak}', {'streak': 'int'}),
    Rep('lib/features/flashcards/presentation/screens/settings_screen.dart',
        r'subtitle: "${settings.dailyGoal} Ink Points"',
        r'subtitle: l10n?.inkPoints(settings.dailyGoal) ?? "${settings.dailyGoal} Ink Points"',
        'inkPoints', '{points} Ink Points', {'points': 'int'}),
    Rep('lib/features/flashcards/presentation/screens/settings_screen.dart',
        r'subtitle: "${settings.speechRate.toStringAsFixed(1)}x"',
        r'subtitle: l10n?.speechRateMultiplier(settings.speechRate.toStringAsFixed(1)) ?? "${settings.speechRate.toStringAsFixed(1)}x"',
        'speechRateMultiplier', '{rate}x', {'rate': 'String'}),
    Rep('lib/features/flashcards/presentation/screens/settings_screen.dart',
        r'subtitle: "${settings.animationSpeed.toStringAsFixed(1)}x"',
        r'subtitle: l10n?.animationSpeedMultiplier(settings.animationSpeed.toStringAsFixed(1)) ?? "${settings.animationSpeed.toStringAsFixed(1)}x"',
        'animationSpeedMultiplier', '{rate}x', {'rate': 'String'}),
    Rep('lib/features/flashcards/presentation/screens/settings_screen.dart',
        r'_buildSectionHeader("Support & Feedback", theme)',
        r'_buildSectionHeader(l10n?.supportAndFeedback ?? "Support & Feedback", theme)',
        'supportAndFeedback', 'Support & Feedback'),
        
    // contact_screen.dart
    Rep('lib/features/settings/presentation/screens/contact_screen.dart',
        r"title: const Text('Contact Us')",
        r"title: Text(AppLocalizations.of(context)!.contactUs)",
        'contactUs', 'Contact Us'),
    Rep('lib/features/settings/presentation/screens/contact_screen.dart',
        r"title: const Text('Report a Bug')",
        r"title: Text(AppLocalizations.of(context)!.reportBug)",
        'reportBug', 'Report a Bug'),
    Rep('lib/features/settings/presentation/screens/contact_screen.dart',
        r"title: const Text('Suggest a Feature')",
        r"title: Text(AppLocalizations.of(context)!.suggestFeature)",
        'suggestFeature', 'Suggest a Feature'),
    Rep('lib/features/settings/presentation/screens/contact_screen.dart',
        r"title: const Text('General Feedback')",
        r"title: Text(AppLocalizations.of(context)!.generalFeedback)",
        'generalFeedback', 'General Feedback'),

    // review_screen.dart
    Rep('lib/features/flashcards/presentation/screens/review_screen.dart',
        r"const SnackBar(content: Text('Please draw something first'))",
        r"SnackBar(content: Text(AppLocalizations.of(context)!.pleaseDrawSomethingFirst))",
        'pleaseDrawSomethingFirst', 'Please draw something first'),
    Rep('lib/features/flashcards/presentation/screens/review_screen.dart',
        r"const Text('Draw this character:', style: TextStyle(fontSize: 16, color: Colors.white70, fontWeight: FontWeight.w500))",
        r"Text(AppLocalizations.of(context)!.drawThisCharacter, style: const TextStyle(fontSize: 16, color: Colors.white70, fontWeight: FontWeight.w500))",
        'drawThisCharacter', 'Draw this character:'),
    Rep('lib/features/flashcards/presentation/screens/review_screen.dart',
        r"Text('Follow the blue guide to draw stroke ${_currentStrokeIndex + 1} of $totalStrokes', style: const TextStyle(color: Colors.white, fontSize: 14))",
        r"Text(AppLocalizations.of(context)!.followGuideStroke(_currentStrokeIndex + 1, totalStrokes), style: const TextStyle(color: Colors.white, fontSize: 14))",
        'followGuideStroke', 'Follow the blue guide to draw stroke {current} of {total}', {'current': 'int', 'total': 'int'}),
    Rep('lib/features/flashcards/presentation/screens/review_screen.dart',
        r"label: const Text('Skip Current Stroke')",
        r"label: Text(AppLocalizations.of(context)!.skipCurrentStroke)",
        'skipCurrentStroke', 'Skip Current Stroke'),
    Rep('lib/features/flashcards/presentation/screens/review_screen.dart',
        r"label: const Text('Submit Drawing')",
        r"label: Text(AppLocalizations.of(context)!.submitDrawing)",
        'submitDrawing', 'Submit Drawing'),

    // deck_card_picker_screen.dart
    Rep('lib/features/flashcards/presentation/screens/deck_card_picker_screen.dart',
        r"content: Text('Added ${card.hanzi} to ${widget.deckName}')",
        r"content: Text(AppLocalizations.of(context)!.addedToDeck(card.hanzi, widget.deckName))",
        'addedToDeck', 'Added {hanzi} to {deckName}', {'hanzi': 'String', 'deckName': 'String'}),

    // deck_detail_screen.dart
    Rep('lib/features/flashcards/presentation/screens/deck_detail_screen.dart',
        r"content: Text('Removed ${card.hanzi} from deck')",
        r"content: Text(AppLocalizations.of(context)!.removedFromDeck(card.hanzi))",
        'removedFromDeck', 'Removed {hanzi} from deck', {'hanzi': 'String'}),

    // deck_review_session_screen.dart
    Rep('lib/features/flashcards/presentation/screens/deck_review_session_screen.dart',
        'content: Text(\'Skipped "\${card.hanzi}" - No stroke data available for this AI character.\')',
        'content: Text(AppLocalizations.of(context)!.skippedNoStrokeData(card.hanzi))',
        'skippedNoStrokeData', 'Skipped "{hanzi}" - No stroke data available for this AI character.', {'hanzi': 'String'}),
    Rep('lib/features/flashcards/presentation/screens/deck_review_session_screen.dart',
        r"const Text('Starting session...')",
        r"Text(AppLocalizations.of(context)!.startingSession)",
        'startingSession', 'Starting session...'),

    // dictionary_screen.dart
    Rep('lib/features/flashcards/presentation/screens/dictionary_screen.dart',
        r"Text('Radicals Index', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))",
        r"Text(AppLocalizations.of(context)!.radicalsIndex, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))",
        'radicalsIndex', 'Radicals Index'),
    Rep('lib/features/flashcards/presentation/screens/dictionary_screen.dart',
        r"Text('Master the building blocks of Hanzi', style: TextStyle(color: Colors.white70, fontSize: 13))",
        r"Text(AppLocalizations.of(context)!.masterBuildingBlocks, style: const TextStyle(color: Colors.white70, fontSize: 13))",
        'masterBuildingBlocks', 'Master the building blocks of Hanzi'),

    // stats_screen.dart
    Rep('lib/features/flashcards/presentation/screens/stats_screen.dart',
        r"title: const Text('Total Words')",
        r"title: Text(AppLocalizations.of(context)!.totalWords)",
        'totalWords', 'Total Words'),
    Rep('lib/features/flashcards/presentation/screens/stats_screen.dart',
        r"title: const Text('New Ink')",
        r"title: Text(AppLocalizations.of(context)!.newInk)",
        'newInk', 'New Ink'),
    Rep('lib/features/flashcards/presentation/screens/stats_screen.dart',
        r"title: const Text('Learning')",
        r"title: Text(AppLocalizations.of(context)!.learningStatus)",
        'learningStatus', 'Learning'),
    Rep('lib/features/flashcards/presentation/screens/stats_screen.dart',
        r"title: const Text('Mastered')",
        r"title: Text(AppLocalizations.of(context)!.masteredStatus)",
        'masteredStatus', 'Mastered'),
    Rep('lib/features/flashcards/presentation/screens/stats_screen.dart',
        r"title: const Text('Library Mastery')",
        r"title: Text(AppLocalizations.of(context)!.libraryMastery)",
        'libraryMastery', 'Library Mastery'),
    Rep('lib/features/flashcards/presentation/screens/stats_screen.dart',
        r"const Text('Accuracy by Mode', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))",
        r"Text(AppLocalizations.of(context)!.accuracyByMode, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))",
        'accuracyByMode', 'Accuracy by Mode'),
    Rep('lib/features/flashcards/presentation/screens/stats_screen.dart',
        r"const Text('Upcoming Reviews (Next 7 Days)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))",
        r"Text(AppLocalizations.of(context)!.upcomingReviews, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))",
        'upcomingReviews', 'Upcoming Reviews (Next 7 Days)'),
        
    // reading_room_screen.dart
    Rep('lib/features/reading/presentation/screens/reading_room_screen.dart',
        r"const Text('文化书房 (Cultural Reading Room)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))",
        r"Text(AppLocalizations.of(context)!.culturalReadingRoom, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))",
        'culturalReadingRoom', '文化书房 (Cultural Reading Room)'),

    // story_reader_screen.dart
    Rep('lib/features/reading/presentation/screens/story_reader_screen.dart',
        r"Text('${widget.blueprint.title} (HSK ${widget.hskLevel})', style: const TextStyle(fontFamily: 'NotoSerifSC'))",
        r"Text(AppLocalizations.of(context)!.storyTitleHsk(widget.blueprint.title, widget.hskLevel), style: const TextStyle(fontFamily: 'NotoSerifSC'))",
        'storyTitleHsk', '{title} (HSK {level})', {'title': 'String', 'level': 'int'}),

    // ai_deck_generator_sheet.dart
    Rep('lib/features/flashcards/presentation/widgets/ai_deck_generator_sheet.dart',
        r"const SnackBar(content: Text('Please enter a topic'))",
        r"SnackBar(content: Text(AppLocalizations.of(context)!.pleaseEnterTopic))",
        'pleaseEnterTopic', 'Please enter a topic'),
    Rep('lib/features/flashcards/presentation/widgets/ai_deck_generator_sheet.dart',
        r"SnackBar(content: Text('Created ${newDeck.name} with ${cards.length} cards!'))",
        r"SnackBar(content: Text(AppLocalizations.of(context)!.createdDeckCards(newDeck.name, cards.length)))",
        'createdDeckCards', 'Created {name} with {count} cards!', {'name': 'String', 'count': 'int'}),

    // drawing_canvas.dart
    Rep('lib/features/flashcards/presentation/widgets/drawing_canvas.dart',
        'Text(\'Grade: \${_gradingResult?.toStringAsFixed(2) ?? "N/A"}\'',
        'Text(AppLocalizations.of(context)!.gradeResult(_gradingResult?.toStringAsFixed(2) ?? "N/A")',
        'gradeResult', 'Grade: {grade}', {'grade': 'String'}),

    // live_call_summary_screen.dart
    Rep('lib/features/echo_hall/presentation/widgets/live_call_summary_screen.dart',
        'const Text("SCHOLAR\'S VERDICT")',
        'Text(AppLocalizations.of(context)!.scholarsVerdict)',
        'scholarsVerdict', "SCHOLAR'S VERDICT"),
    Rep('lib/features/echo_hall/presentation/widgets/live_call_summary_screen.dart',
        r'const Text("CONVERSATION REVIEW")',
        r'Text(AppLocalizations.of(context)!.conversationReview)',
        'conversationReview', "CONVERSATION REVIEW"),
    Rep('lib/features/echo_hall/presentation/widgets/live_call_summary_screen.dart',
        r"Text(AppLocalizations.of(context)!.completeReview, style: TextStyle(fontWeight: FontWeight.bold))",
        r"Text(AppLocalizations.of(context)!.completeReview, style: const TextStyle(fontWeight: FontWeight.bold))",
        'completeReview', 'Complete Review'),
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
        
        // Ensure AppLocalizations is imported
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
