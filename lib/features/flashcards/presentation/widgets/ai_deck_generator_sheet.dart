import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:uuid/uuid.dart';
import 'package:hanzi_master/shared/widgets/global_blurred_bottom_sheet.dart';

class AiDeckGeneratorSheet extends ConsumerStatefulWidget {
  const AiDeckGeneratorSheet({super.key});

  static void show(BuildContext context) {
    GlobalBlurredBottomSheet.show(
      context,
      child: const AiDeckGeneratorSheet(),
    );
  }

  @override
  ConsumerState<AiDeckGeneratorSheet> createState() => _AiDeckGeneratorSheetState();
}

class _AiDeckGeneratorSheetState extends ConsumerState<AiDeckGeneratorSheet> {
  final _topicController = TextEditingController();
  final _contextController = TextEditingController();
  int _difficultyIndex = 0; // 0 = Beginner, 1 = Intermediate, 2 = Advanced
  String _focusArea = 'Mixed';
  double _cardCount = 10;
  bool _isGenerating = false;
  @override
  void dispose() {
    _topicController.dispose();
    _contextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.purple.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.auto_awesome, color: Colors.purple),
                ),
                const SizedBox(width: 16),
                const Text(
                  "AI Deck Generator",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Topic Field
            const Text(
              "What do you want to learn?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _topicController,
              decoration: InputDecoration(
                hintText: "e.g., Ordering at a restaurant, Business vocab...",
                filled: true,
                fillColor: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.lightbulb_outline),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Difficulty
            const Text(
              "Target Difficulty",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildDifficultySegment(0, "Beginner", "HSK 1-2"),
                const SizedBox(width: 8),
                _buildDifficultySegment(1, "Intermediate", "HSK 3-4"),
                const SizedBox(width: 8),
                _buildDifficultySegment(2, "Advanced", "HSK 5-6"),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Focus Area
            const Text(
              "Focus Area",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                'Mixed', 'Nouns only', 'Verbs only', 'Idioms (Chengyu)', 'Full Sentences'
              ].map((focus) => _buildFocusChip(focus, isDark)).toList(),
            ),

            const SizedBox(height: 32),

            // Context / Tone
            const Text(
              "Specific Context or Tone (Optional)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _contextController,
              decoration: InputDecoration(
                hintText: "e.g., Formal business language, slang for texting...",
                filled: true,
                fillColor: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.psychology_alt),
              ),
            ),

            const SizedBox(height: 32),
            
            // Card Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Number of Cards",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${_cardCount.toInt()} cards",
                  style: const TextStyle(
                    fontSize: 16, 
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
            Slider(
              value: _cardCount,
              min: 5,
              max: 50,
              divisions: 9,
              activeColor: Colors.purple,
              onChanged: (val) {
                setState(() => _cardCount = val);
              },
            ),
            
            const SizedBox(height: 40),
            
            // Generate Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isGenerating ? null : () async {
                  final topic = _topicController.text.trim();
                  if (topic.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a topic')));
                    return;
                  }

                  setState(() => _isGenerating = true);
                  try {
                    final geminiService = ref.read(geminiServiceProvider);
                    final difficultyLevel = _difficultyIndex == 0 ? "Beginner (HSK 1-2)" : _difficultyIndex == 1 ? "Intermediate (HSK 3-4)" : "Advanced (HSK 5-6)";
                    
                    final cards = await geminiService.generateDeckCards(
                      topic: topic,
                      difficulty: difficultyLevel,
                      contextTone: _contextController.text.trim(),
                      count: _cardCount.toInt(),
                    );
                    
                    if (cards.isNotEmpty) {
                      // 1. Create Deck
                      final deckController = ref.read(deckControllerProvider.notifier);
                      final newDeck = await deckController.createDeck(topic, description: "Generated by AI");
                      
                      if (newDeck != null) {
                        // 2. Add Cards
                        final flashcardController = ref.read(flashcardControllerProvider.notifier);
                        for (final cardMap in cards) {
                          final newCard = Flashcard(
                            id: const Uuid().v4(),
                            deckId: newDeck.id,
                            hanzi: cardMap['hanzi'] ?? '',
                            pinyin: cardMap['pinyin'] ?? '',
                            definition: cardMap['english'] ?? '',
                            hskLevel: 0,
                            strokePaths: const [],
                            modeStats: const {},
                          );
                          await flashcardController.addFlashcard(newCard);
                        }
                        
                        if (mounted) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Created ${newDeck.name} with ${cards.length} cards!')));
                        }
                      }
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error generating deck: $e')));
                    }
                  } finally {
                    if (mounted) {
                      setState(() => _isGenerating = false);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: _isGenerating
                  ? const SizedBox(
                      width: 24, height: 24,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.auto_awesome),
                        SizedBox(width: 8),
                        Text(
                          "Generate Deck",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDifficultySegment(int index, String title, String subtitle) {
    final isSelected = _difficultyIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _difficultyIndex = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected 
              ? Colors.purple.withValues(alpha: 0.1) 
              : (isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05)),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? Colors.purple : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.purple : (isDark ? Colors.white70 : Colors.black87),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.purple.withValues(alpha: 0.8) : (isDark ? Colors.white54 : Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFocusChip(String label, bool isDark) {
    final isSelected = _focusArea == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) setState(() => _focusArea = label);
      },
      selectedColor: Colors.purple.withValues(alpha: 0.2),
      backgroundColor: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05),
      labelStyle: TextStyle(
        color: isSelected ? Colors.purple : (isDark ? Colors.white : Colors.black),
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      side: BorderSide(
        color: isSelected ? Colors.purple : Colors.transparent,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
