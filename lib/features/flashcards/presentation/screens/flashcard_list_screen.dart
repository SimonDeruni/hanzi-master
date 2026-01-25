import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/stats_screen.dart';
import '../providers/flashcard_controller.dart';
import "settings_screen.dart";
import 'flashcard_form_screen.dart'; // Make sure this exists
import 'review_screen.dart';      // Make sure this exists
import '../widgets/streak_seal.dart';

// 1. CLASS PART 1: The Widget (Public Face)
class FlashcardListScreen extends ConsumerStatefulWidget {
  const FlashcardListScreen({super.key});

  @override
  ConsumerState<FlashcardListScreen> createState() => _FlashcardListScreenState();
}

// 2. CLASS PART 2: The State (Where the logic lives)
class _FlashcardListScreenState extends ConsumerState<FlashcardListScreen> {
  // Variable to store what the user types
  String _searchQuery = ""; 

  @override
  Widget build(BuildContext context) {
    // Watch the database for changes
    final asyncFlashcards = ref.watch(flashcardControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hanzi Master Library"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          // THE STREAK SEAL 🧧
          const Padding(
            padding: EdgeInsets.only(right: 8.0, top: 10, bottom: 10),
            child: StreakSeal(),
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            tooltip: "Stats",
            onPressed: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StatsScreen()),
              );
            },
          ),
          // SETTINGS BUTTON ⚙️
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      
      // THE BODY: Search Bar + List
      body: Column(
        children: [
          // A. THE SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Hanzi, Pinyin, or Meaning...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
              ),
              onChanged: (value) {
                // Update the state whenever you type
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // B. THE LIST (Filtered Grid)
          Expanded(
            child: asyncFlashcards.when(
              data: (flashcards) {
                // --- FILTER LOGIC ---
                final filteredCards = flashcards.where((card) {
                  final query = _searchQuery.toLowerCase();
                  return card.hanzi.contains(query) ||
                         card.pinyin.toLowerCase().contains(query) ||
                         card.definition.toLowerCase().contains(query);
                }).toList();
                // --------------------

                if (flashcards.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.library_books_outlined, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        const Text("Your library is empty"),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () => ref.read(flashcardControllerProvider.notifier).importHsk1(),
                          icon: const Icon(Icons.download),
                          label: const Text("Import HSK 1 (150 Words)"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (filteredCards.isEmpty) {
                  return const Center(child: Text("No cards found"));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: filteredCards.length,
                  itemBuilder: (context, index) {
                    final card = filteredCards[index];
                    final bool isMastered = card.isMastered;
                    
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewScreen(card: card),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Mastered Badge
                              Align(
                                alignment: Alignment.topRight,
                                child: Icon(
                                  isMastered ? Icons.verified : Icons.circle_outlined,
                                  size: 16,
                                  color: isMastered ? Colors.green : Colors.grey.shade300,
                                ),
                              ),
                              
                              // The Character
                              Text(
                                card.hanzi,
                                style: const TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              
                              // Pinyin
                              Text(
                                card.pinyin,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.indigo.shade700,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              
                              // Definition (Truncated)
                              const SizedBox(height: 4),
                              Text(
                                card.definition,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              
                              const Spacer(),
                              
                              // Edit Button
                              Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  icon: const Icon(Icons.edit, size: 18, color: Colors.grey),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FlashcardFormScreen(cardToEdit: card),
                                      ),
                                    );
                                  },
                                  constraints: const BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text("Error: $err")),
            ),
          ),
        ],
      ),

      // THE ADD BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FlashcardFormScreen()),
          );
        },
      ),
    );
  }
}