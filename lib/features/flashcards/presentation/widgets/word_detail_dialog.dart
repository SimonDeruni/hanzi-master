import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/drawing_canvas.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'dart:ui' as ui;
import 'ai_explainer_sheet.dart';
import 'package:hanzi_master/shared/widgets/global_blurred_bottom_sheet.dart';
import 'character_chat_sheet.dart';
import 'package:hanzi_master/core/services/character_lookup_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';

class WordDetailDialog extends ConsumerStatefulWidget {
  final AiWord word;
  final AiSentence sentence;

  const WordDetailDialog({super.key, required this.word, required this.sentence});

  static void show(BuildContext context, AiWord word, AiSentence sentence) {
    showDialog(
      context: context,
      builder: (context) => WordDetailDialog(word: word, sentence: sentence),
    );
  }

  @override
  ConsumerState<WordDetailDialog> createState() => _WordDetailDialogState();
}

class _WordDetailDialogState extends ConsumerState<WordDetailDialog> {
  final ValueNotifier<List<ui.Offset?>> _scratchpadNotifier = ValueNotifier([]);
  Flashcard? _flashcard;
  bool _isLoadingCard = true;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _loadFlashcard();
  }

  @override
  void dispose() {
    _scratchpadNotifier.dispose();
    super.dispose();
  }

  Future<void> _loadFlashcard() async {
    final char = widget.word.hanzi.characters.first;
    final repo = ref.read(globalDictionaryRepositoryProvider);
    final card = await repo.getExact(char);
    
    final flashcards = ref.read(flashcardControllerProvider).valueOrNull ?? [];
    final saved = flashcards.any((c) => c.hanzi == char);

    if (mounted) {
      setState(() {
        _flashcard = card;
        _isLoadingCard = false;
        _isSaved = saved;
      });
    }
  }

  void _addToDeck() async {
    if (_isSaved || _flashcard == null) return;

    final char = widget.word.hanzi.characters.first;
    
    // Show Deck Selector
    final navContext = Navigator.of(context).context;
    final isDark = Theme.of(navContext).brightness == Brightness.dark;
    
    // We get decks from deckControllerProvider, but it's not imported. We can import it.
    final decks = ref.read(deckControllerProvider).valueOrNull ?? [];
    
    final selectedDeckId = await showModalBottomSheet<String>(
      context: navContext,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Select Deck",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.layers),
              title: const Text("Default Deck"),
              onTap: () => Navigator.pop(ctx, 'default'),
            ),
            ...decks.map((deck) => ListTile(
              leading: const Icon(Icons.folder),
              title: Text(deck.name),
              onTap: () => Navigator.pop(ctx, deck.id),
            )),
          ],
        ),
      ),
    );

    if (selectedDeckId == null) return; // User cancelled

    // Inject contextual node data
    final cardWithContext = _flashcard!.copyWith(
      sourceSentence: widget.sentence.chinese,
      sourceContext: "Reading Room",
      deckId: selectedDeckId == 'default' ? '' : selectedDeckId,
    );
    
    await ref.read(flashcardControllerProvider.notifier).addFlashcard(cardWithContext);
    
    if (mounted) {
      setState(() => _isSaved = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Added $char to Review Queue")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
        child: SingleChildScrollView(
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
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.word.hanzi,
                            style: TextStyle(
                              fontFamily: 'NotoSerifSC',
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.word.pinyin,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w500,
                            ),
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
              const SizedBox(height: 16),
              
              // Unified Graph Node: Micro Calligraphy Canvas
              if (_isLoadingCard)
                const SizedBox(
                  height: 180,
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (_flashcard != null && _flashcard!.strokePaths.isNotEmpty)
                Center(
                  child: SizedBox(
                    height: 180,
                    width: 180,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: isDark ? Colors.white12 : Colors.black12, width: 1),
                        boxShadow: [
                          if (!isDark)
                            BoxShadow(color: Colors.black.withAlpha(12), blurRadius: 10, offset: const Offset(0, 4)),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: CalligraphyBackground(
                        child: DrawingCanvas(
                          strokePaths: _flashcard!.strokePaths,
                          medianPaths: _flashcard!.medianPaths,
                          showAnimation: false,
                          readOnly: false,
                          showControls: true,
                          showGrade: false,
                          showGuideLines: true,
                          isFlipped: _flashcard!.isFlipped,
                          userPointsNotifier: _scratchpadNotifier,
                        ),
                      ),
                    ),
                  ),
                ),
                
              const SizedBox(height: 24),
              Text(
                AppLocalizations.of(context)!.meaningInContext,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white54 : Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.word.meaning,
                style: TextStyle(
                  fontSize: 18,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              if (widget.word.hanzi.isNotEmpty)
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: widget.word.hanzi.characters.map((char) {
                    return ActionChip(
                      avatar: const Icon(Icons.explore, size: 16, color: Colors.indigo),
                      label: Text("Etymology: $char", style: const TextStyle(fontWeight: FontWeight.w600)),
                      backgroundColor: Colors.indigo.withValues(alpha: 0.1),
                      side: BorderSide.none,
                      onPressed: () async {
                        final navContext = Navigator.of(context).context;
                        Navigator.pop(context);
                        
                        // We use the character lookup service to get pinyin/definition for the chat sheet header.
                        final lookup = ref.read(characterLookupServiceProvider);
                        final info = await lookup.lookup(char);
                        
                        if (navContext.mounted) {
                          GlobalBlurredBottomSheet.show(
                            navContext,
                            child: CharacterChatSheet(
                              hanzi: char,
                              pinyin: info?.pinyin ?? "",
                              definition: info?.definition ?? "Component of ${widget.word.hanzi}",
                            ),
                          );
                        }
                      },
                    );
                  }).toList(),
                ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: BouncingButton(
                      onPressed: () {
                        final navContext = Navigator.of(context).context;
                        Navigator.pop(context);
                        AiExplainerSheet.show(navContext, widget.word, widget.sentence);
                      },
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.auto_awesome, size: 18),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                AppLocalizations.of(context)!.explainGrammar,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: BouncingButton(
                      onPressed: (_isSaved || _flashcard == null) ? null : _addToDeck,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isSaved ? Colors.green : Colors.blueAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                          disabledBackgroundColor: _isSaved ? Colors.green : Colors.grey.shade400,
                          disabledForegroundColor: Colors.white,
                        ),
                        onPressed: null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(_isSaved ? Icons.check_circle : Icons.add_box, size: 18),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                _isSaved ? "In Queue" : AppLocalizations.of(context)!.addToLibrary,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
