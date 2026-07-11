import 'package:hanzi_master/l10n/app_localizations.dart';
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
  final _countController = TextEditingController(text: '10');
  int _mode = 0; // 0 = new deck, 1 = add to deck
  String? _selectedDeckId;
  String? _selectedDeckName;
  @override
  void initState() {
    super.initState();
    _countController.addListener(_onCountChanged);
  }
  void _onCountChanged() {
    final parsed = int.tryParse(_countController.text);
    if (parsed != null && parsed != _cardCount.round()) {
      final clamped = parsed.clamp(5, 200);
      setState(() => _cardCount = clamped.toDouble());
    }
  }
  @override
  void dispose() {
    _countController.removeListener(_onCountChanged);
    _topicController.dispose();
    _contextController.dispose();
    _countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(
        top: 24,
        bottom: bottomPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
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
                  child: Icon(Icons.auto_awesome, color: Colors.purple),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.aiDeckGenerator,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          _buildTab(0, "New Deck"),
                          SizedBox(width: 8),
                          _buildTab(1, "Add to Deck"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),

            if (_mode == 1)
              // Deck picker for add mode
              _buildDeckPicker(isDark),

            // Topic Field
            Text(
              _mode == 0
                ? AppLocalizations.of(context)!.whatDoYouWant
                : "Topic (for context)",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
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
                prefixIcon: Icon(Icons.lightbulb_outline),
              ),
            ),
            
            SizedBox(height: 32),
            
            if (_mode == 0) ...[
              // Difficulty
              Text(
                AppLocalizations.of(context)!.targetDifficulty,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  _buildDifficultySegment(0, "Beginner", "HSK 1-2"),
                  SizedBox(width: 8),
                  _buildDifficultySegment(1, "Intermediate", "HSK 3-4"),
                  SizedBox(width: 8),
                  _buildDifficultySegment(2, "Advanced", "HSK 5-6"),
                ],
              ),
              
              SizedBox(height: 32),
              
              // Focus Area
              Text(
                AppLocalizations.of(context)!.focusArea,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  'Mixed', 'Nouns only', 'Verbs only', 'Idioms (Chengyu)', 'Full Sentences'
                ].map((focus) => _buildFocusChip(focus, isDark)).toList(),
              ),
            ],

            SizedBox(height: 32),

            // Context / Tone
            Text(
              AppLocalizations.of(context)!.specificContextOrTone,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
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
                prefixIcon: Icon(Icons.psychology_alt),
              ),
            ),

            SizedBox(height: 32),
            
            // Card Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.numberOfCards,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 70,
                  height: 36,
                  child: TextField(
                    controller: _countController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
            Slider(
              value: _cardCount,
              min: 5,
              max: 200,
              activeColor: Colors.purple,
              onChanged: (val) {
                setState(() {
                  _cardCount = val;
                  _countController.text = val.toInt().toString();
                });
              },
            ),
            
            SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SafeArea(
            bottom: true,
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: SizedBox(
                width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isGenerating ? null : () async {
                  final topic = _topicController.text.trim();
                  if (topic.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.pleaseEnterTopic)));
                    return;
                  }

                  if (_mode == 1 && _selectedDeckId == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a deck to add cards to.')));
                    return;
                  }

                  setState(() => _isGenerating = true);
                  try {
                    final geminiService = ref.read(geminiServiceProvider);
                    final flashcardController = ref.read(flashcardControllerProvider.notifier);

                    if (_mode == 0) {
                      // === NEW DECK MODE ===
                      final difficultyLevel = _difficultyIndex == 0 ? "Beginner (HSK 1-2)" : _difficultyIndex == 1 ? "Intermediate (HSK 3-4)" : "Advanced (HSK 5-6)";
                      
                      final cards = await geminiService.generateDeckCards(
                        topic: topic,
                        difficulty: difficultyLevel,
                        contextTone: _contextController.text.trim(),
                        count: _cardCount.toInt(),
                      );
                      
                      if (cards.isNotEmpty) {
                        final deckController = ref.read(deckControllerProvider.notifier);
                        final newDeck = await deckController.createDeck(topic, description: "Generated by AI");
                        
                        if (newDeck != null) {
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
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.createdDeckCards(newDeck.name, cards.length))));
                          }
                        }
                      }
                    } else {
                      // === ADD TO DECK MODE ===
                      final allCards = ref.read(flashcardControllerProvider).value ?? [];
                      final deckCards = allCards.where((c) => c.deckId == _selectedDeckId).toList();
                      final existingHanzi = deckCards.map((c) => c.hanzi).toList();
                      final existingPinyin = deckCards.map((c) => c.pinyin).toList();

                      final cards = await geminiService.generateContextualCards(
                        deckTopic: topic,
                        contextTone: _contextController.text.trim(),
                        count: _cardCount.toInt(),
                        existingHanzi: existingHanzi,
                        existingPinyin: existingPinyin,
                      );
                      
                      if (cards.isNotEmpty) {
                        for (final cardMap in cards) {
                          final newCard = Flashcard(
                            id: const Uuid().v4(),
                            deckId: _selectedDeckId!,
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
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added ${cards.length} cards to "$_selectedDeckName".')));
                        }
                      }
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
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
                  ? SizedBox(
                      width: 24, height: 24,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.auto_awesome),
                        SizedBox(width: 8),
                        Text(
                          _mode == 0 ? "Generate Deck" : "Generate & Add",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
              ),
            ),
            ),
          ),
        ],
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
              SizedBox(height: 4),
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

  Widget _buildTab(int tabIndex, String label) {
    final isSelected = _mode == tabIndex;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        setState(() {
          _mode = tabIndex;
          if (tabIndex == 1 && _selectedDeckId == null) {
            final decks = ref.read(deckControllerProvider).value ?? [];
            if (decks.isNotEmpty) {
              _selectedDeckId = decks.first.id;
              _selectedDeckName = decks.first.localizedName(context);
              _topicController.text = _selectedDeckName!;
            }
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.grey.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : (isDark ? Colors.white70 : Colors.black54),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildDeckPicker(bool isDark) {
    final decks = ref.watch(deckControllerProvider).value ?? [];
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Target Deck",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _selectedDeckId,
            decoration: InputDecoration(
              filled: true,
              fillColor: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(Icons.folder_open),
            ),
            items: decks.map((d) {
              return DropdownMenuItem(
                value: d.id,
                child: Text(d.localizedName(context)),
              );
            }).toList(),
            onChanged: (val) {
              setState(() {
                _selectedDeckId = val;
                final deck = decks.firstWhere((d) => d.id == val);
                _selectedDeckName = deck.localizedName(context);
                _topicController.text = _selectedDeckName!;
              });
            },
          ),
        ],
      ),
    );
  }
}
