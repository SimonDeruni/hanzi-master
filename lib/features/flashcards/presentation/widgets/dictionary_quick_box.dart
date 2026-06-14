import 'package:flutter/material.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';
import 'package:hanzi_master/shared/widgets/clickable_chinese_text.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/character_detail_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/review_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/mastery_seal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/deck_selection_sheet.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/study_mode.dart';

class DictionaryQuickBox extends ConsumerStatefulWidget {
  final Flashcard card;
  final bool isInLibrary;

  const DictionaryQuickBox({
    super.key,
    required this.card,
    required this.isInLibrary,
  });

  static Future<void> show(BuildContext context, {required Flashcard card, required bool isInLibrary}) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DictionaryQuickBox(card: card, isInLibrary: isInLibrary),
    );
  }

  @override
  ConsumerState<DictionaryQuickBox> createState() => _DictionaryQuickBoxState();
}

class _DictionaryQuickBoxState extends ConsumerState<DictionaryQuickBox> {
  late Flashcard _card;
  bool _isLoadingAi = false;

  @override
  void initState() {
    super.initState();
    _card = widget.card;
    if (_card.id.startsWith('dummy_')) {
      _fetchAiDefinition();
    }
  }

  Future<void> _fetchAiDefinition() async {
    setState(() => _isLoadingAi = true);
    try {
      final gemini = ref.read(geminiServiceProvider);
      final aiDef = await gemini.defineWord(_card.hanzi);
      if (mounted) {
        setState(() {
          _card = _card.copyWith(
            pinyin: aiDef['pinyin'] ?? '?',
            definition: aiDef['meaning'] ?? 'Not found',
          );
          _isLoadingAi = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _card = _card.copyWith(definition: 'Error loading from AI.');
          _isLoadingAi = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final double masteryProgress = widget.isInLibrary ? _card.masteryLevel(StudyMode.reading) : 0.0;
    
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: isDark ? Colors.white12 : Colors.black12, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header row with Seal
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.isInLibrary)
                    MasterySeal(progress: masteryProgress, isMastered: _card.isMastered(StudyMode.reading), size: 40)
                  else
                    const SizedBox(width: 40, height: 40), // Placeholder to balance
                    
                  IconButton(
                    icon: Icon(Icons.close, color: isDark ? Colors.white54 : Colors.black54),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              
              // Character
              Text(
                _card.hanzi,
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF2C2C2C),
                  height: 1.0,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Pinyin
              PinyinText(
                text: _card.pinyin,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.indigo.shade200 : Colors.indigo.shade900,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Definition
              if (_isLoadingAi)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Center(
                    child: SizedBox(
                      width: 24, height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                )
              else
                ClickableChineseText(
                  _card.definition,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? Colors.white70 : Colors.black87,
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              
              const SizedBox(height: 32),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context); // Close the quick box
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterDetailScreen(card: _card)));
                      },
                      icon: const Icon(Icons.explore),
                      label: const Text("Inspect"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: isDark ? Colors.white : Colors.black,
                        side: BorderSide(color: isDark ? Colors.white24 : Colors.black26),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                  if (widget.isInLibrary) ...[
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context); // Close the quick box
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewScreen(card: _card)));
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text("Practice"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ),
                  ] else ...[
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context); 
                          DeckSelectionSheet.show(context, card: _card);
                        },
                        icon: const Icon(Icons.add),
                        label: const Text("Add to Library"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal.shade700,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ),
                  ]
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
