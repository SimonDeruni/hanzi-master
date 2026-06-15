import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:uuid/uuid.dart';

class FlashcardEditDialog extends ConsumerStatefulWidget {
  final String initialHanzi;
  final String initialPinyin;
  final String initialDefinition;

  const FlashcardEditDialog({
    super.key,
    required this.initialHanzi,
    required this.initialPinyin,
    required this.initialDefinition,
  });

  static Future<void> show(BuildContext context, {
    required String hanzi,
    required String pinyin,
    required String definition,
  }) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: FlashcardEditDialog(
          initialHanzi: hanzi,
          initialPinyin: pinyin,
          initialDefinition: definition,
        ),
      ),
    );
  }

  @override
  ConsumerState<FlashcardEditDialog> createState() => _FlashcardEditDialogState();
}

class _FlashcardEditDialogState extends ConsumerState<FlashcardEditDialog> {
  late final TextEditingController _hanziController;
  late final TextEditingController _pinyinController;
  late final TextEditingController _definitionController;
  bool _addToDeck = true;

  @override
  void initState() {
    super.initState();
    _hanziController = TextEditingController(text: widget.initialHanzi);
    _pinyinController = TextEditingController(text: widget.initialPinyin);
    _definitionController = TextEditingController(text: widget.initialDefinition);
  }

  @override
  void dispose() {
    _hanziController.dispose();
    _pinyinController.dispose();
    _definitionController.dispose();
    super.dispose();
  }

  void _save() async {
    final hanzi = _hanziController.text.trim();
    final pinyin = _pinyinController.text.trim();
    final def = _definitionController.text.trim();

    if (hanzi.isEmpty || def.isEmpty) return;

    // Must contain at least one valid Chinese character
    final hasChinese = RegExp(r'[\u4e00-\u9fff\u3400-\u4dbf]').hasMatch(hanzi);
    if (!hasChinese) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter valid Chinese characters")),
        );
      }
      return;
    }

    final newCard = Flashcard(
      id: const Uuid().v4(),
      hanzi: hanzi,
      pinyin: pinyin,
      definition: def,
      hskLevel: 0, // AI generated or custom cards have level 0 by default
      strokePaths: const [], // Stroke data won't exist for these custom cards
      modeStats: const {},
      deckId: _addToDeck ? 'default' : 'none',
    );

    await ref.read(flashcardControllerProvider.notifier).addFlashcard(newCard);

    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Added '$hanzi' to your Library")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0);
    final textColor = isDark ? Colors.white : const Color(0xFF1A1A1B);

    return Dialog(
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.edit_note, color: Colors.indigo),
                const SizedBox(width: 8),
                Text(
                  "Review AI Card",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "Please double-check the AI's output below. Feel free to tweak the pinyin or definition before saving it to your permanent library.",
              style: TextStyle(fontSize: 13, color: textColor.withValues(alpha: 0.6)),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _hanziController,
              decoration: const InputDecoration(
                labelText: "Character / Word",
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: textColor, fontFamily: 'NotoSerifSC', fontSize: 24),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pinyinController,
              decoration: const InputDecoration(
                labelText: "Pinyin",
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: textColor),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _definitionController,
              decoration: const InputDecoration(
                labelText: "Definition",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              style: TextStyle(color: textColor),
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text("Add to Default Study Deck"),
              subtitle: const Text("If off, it's only saved to the global Dictionary", style: TextStyle(fontSize: 12)),
              value: _addToDeck,
              activeTrackColor: Colors.indigo.withValues(alpha: 0.5),
              activeThumbColor: Colors.indigo,
              onChanged: (val) {
                setState(() {
                  _addToDeck = val;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Save to Library", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
