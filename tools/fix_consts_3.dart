import 'dart:io';

void main() {
  final files = [
    'lib/features/course/presentation/screens/course_screen.dart',
    'lib/features/course/presentation/screens/course_selection_screen.dart',
    'lib/features/flashcards/presentation/screens/character_detail_screen.dart',
    'lib/features/flashcards/presentation/screens/deck_detail_screen.dart',
    'lib/features/flashcards/presentation/screens/dictionary_screen.dart',
    'lib/features/flashcards/presentation/widgets/ai_deck_generator_sheet.dart',
    'lib/features/flashcards/presentation/widgets/drawing_canvas.dart',
    'lib/features/flashcards/presentation/widgets/modes/listening_mode.dart',
    'lib/features/flashcards/presentation/widgets/modes/reading_mode.dart',
    'lib/features/flashcards/presentation/widgets/modes/speaking_mode.dart',
    'lib/features/live_translate/presentation/screens/shadowing_studio_screen.dart',
    'lib/features/live_translate/presentation/screens/travel_interpreter_screen.dart',
    'lib/features/live_translate/presentation/screens/whisper_earpiece_screen.dart',
    'lib/features/onboarding/presentation/screens/tutorial_lesson_screen.dart',
    'lib/features/premium/presentation/screens/paywall_sheet.dart',
    'lib/features/reading/presentation/screens/reading_room_screen.dart',
    'lib/features/reading/presentation/widgets/custom_story_creator_sheet.dart',
  ];

  for (final path in files) {
    final file = File(path);
    if (!file.existsSync()) continue;
    
    String content = file.readAsStringSync();
    
    // We'll replace `const Something(..., AppLocalizations)`
    // Actually, the simplest brute force for these exact files is to just replace 'const ' with '' if it's right before something that spans to AppLocalizations.
    // Let's just remove ALL `const ` from the file! Wait, removing ALL const could degrade performance but it will definitely fix the error.
    // Better: let's replace things like:
    content = content.replaceAll('const Center(', 'Center(');
    content = content.replaceAll('const Padding(', 'Padding(');
    content = content.replaceAll('const Column(', 'Column(');
    content = content.replaceAll('const Row(', 'Row(');
    content = content.replaceAll('const SizedBox(', 'SizedBox(');
    content = content.replaceAll('const Icon(', 'Icon(');
    content = content.replaceAll('const Text(', 'Text(');
    content = content.replaceAll('const SnackBar(', 'SnackBar(');
    content = content.replaceAll('const FittedBox(', 'FittedBox(');
    content = content.replaceAll('const Tooltip(', 'Tooltip(');
    content = content.replaceAll('const ActionChip(', 'ActionChip(');
    content = content.replaceAll('const ActionButton(', 'ActionButton(');
    content = content.replaceAll('const StatCard(', 'StatCard(');
    
    file.writeAsStringSync(content);
    print('Fixed consts in $path');
  }
}
