import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/deck.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'ai_explainer_sheet.dart';

class WordDetailDialog extends ConsumerWidget {
  final AiWord word;
  final AiSentence sentence;

  const WordDetailDialog({super.key, required this.word, required this.sentence});

  static void show(BuildContext context, AiWord word, AiSentence sentence) {
    showDialog(
      context: context,
      builder: (context) => WordDetailDialog(word: word, sentence: sentence),
    );
  }

  void _addToDeck(BuildContext context, WidgetRef ref) async {
    final char = word.hanzi.characters.first;
    final repo = ref.read(globalDictionaryRepositoryProvider);
    final flashcards = ref.read(flashcardControllerProvider).valueOrNull ?? [];
    
    if (flashcards.any((c) => c.hanzi == char)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Already in your Library!")),
      );
      return;
    }

    Flashcard? card = await repo.getExact(char);
    if (card != null) {
      await ref.read(flashcardControllerProvider.notifier).addFlashcard(card);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Added $char to Library")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: isDark ? Colors.white12 : Colors.black12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        word.hanzi,
                        style: TextStyle(
                          fontFamily: 'NotoSerifSC',
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      Text(
                        word.pinyin,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              "Meaning in Context",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white54 : Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              word.meaning,
              style: TextStyle(
                fontSize: 18,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: BouncingButton(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.auto_awesome),
                      label: const FittedBox(fit: BoxFit.scaleDown, child: Text("Explain Grammar")),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        AiExplainerSheet.show(context, word, sentence);
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: BouncingButton(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add_box),
                      label: const FittedBox(fit: BoxFit.scaleDown, child: Text("Add to Library")),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      onPressed: () => _addToDeck(context, ref),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
