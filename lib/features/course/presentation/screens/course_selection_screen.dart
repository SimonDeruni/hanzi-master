import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/course/presentation/screens/course_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/deck_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';

class CourseSelectionScreen extends ConsumerWidget {
  const CourseSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDecks = ref.watch(deckControllerProvider);
    final allCards = ref.watch(flashcardControllerProvider).valueOrNull ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("CURRICULUM PATHS", 
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 4, fontSize: 12, color: Colors.brown)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: CalligraphyBackground(
        child: asyncDecks.when(
          data: (decks) {
            if (decks.isEmpty) {
              return const Center(child: Text("No decks found. Add some to your library!"));
            }
            
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(24, 120, 24, 40),
              itemCount: decks.length,
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final deck = decks[index];
                final cardCount = allCards.where((c) => c.deckId == deck.id || (deck.id == 'default' && c.deckId == null)).length;
                
                final isDark = Theme.of(context).brightness == Brightness.dark;
                
                return _CourseCard(
                  title: deck.name,
                  subtitle: deck.description.isNotEmpty ? deck.description : "A personalized path based on your deck.",
                  level: "$cardCount CARDS",
                  color: deck.id == 'default' ? Colors.indigo : Colors.teal,
                  isLocked: false,
                  onTap: () {
                    if (cardCount == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Add some cards to this deck first!")));
                      return;
                    }
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => CourseScreen(deckId: deck.id, deckName: deck.name)),
                    );
                  },
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text("Error loading decks: $err")),
        ),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String level;
  final Color color;
  final bool isLocked;
  final VoidCallback onTap;

  const _CourseCard({
    required this.title,
    required this.subtitle,
    required this.level,
    required this.color,
    required this.isLocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLocked ? null : onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 160,
          decoration: BoxDecoration(
            color: isLocked 
                ? Colors.grey.withValues(alpha: 0.1) 
                : (isDark ? const Color(0xFF2A2A2B) : Colors.white.withValues(alpha: 0.8)),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isLocked ? Colors.grey.withValues(alpha: 0.3) : color.withValues(alpha: 0.3),
              width: 1.5,
            ),
            boxShadow: [
              if (!isLocked)
                BoxShadow(
                  color: color.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                )
            ],
          ),
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isLocked ? Colors.grey : color,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        level.toUpperCase(),
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isLocked ? Colors.grey : (isDark ? Colors.white : Colors.black87),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: isLocked ? Colors.grey : (isDark ? Colors.white70 : Colors.grey.shade700),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (isLocked)
                const Icon(Icons.lock, color: Colors.grey, size: 32)
              else
                Icon(Icons.arrow_forward_ios, color: color.withValues(alpha: 0.5), size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
