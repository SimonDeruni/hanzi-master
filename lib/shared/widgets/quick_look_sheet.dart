import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/character_detail_provider.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/character_detail_screen.dart';

/// Shows a compact "Quick Look" bottom sheet for a single Chinese character.
void showQuickLook(BuildContext context, String hanzi) {
  // Only trigger for a single CJK character
  if (hanzi.isEmpty) return;
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (ctx) => _QuickLookSheet(hanzi: hanzi),
  );
}

class _QuickLookSheet extends ConsumerWidget {
  final String hanzi;
  const _QuickLookSheet({required this.hanzi});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1E1E1F) : const Color(0xFFFDFCF0);
    final textColor = isDark ? Colors.white : const Color(0xFF1A1A1B);

    final asyncCard = ref.watch(quickLookProvider(hanzi));
    final asyncCommon = ref.watch(commonWordsProvider(hanzi));
    final allCards = ref.watch(flashcardControllerProvider).value ?? [];
    final inDeck = allCards.any((c) => c.hanzi == hanzi);

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.55,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Drag handle ──────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 4),
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          Flexible(
            child: asyncCard.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(48),
                child: Center(child: CircularProgressIndicator(color: Colors.indigo)),
              ),
              error: (e, _) => Padding(
                padding: const EdgeInsets.all(32),
                child: Text('Not found in dictionary', style: TextStyle(color: textColor.withValues(alpha: 0.5))),
              ),
              data: (card) {
                if (card == null) {
                  return Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(hanzi, style: const TextStyle(fontSize: 56, fontWeight: FontWeight.w200, color: Colors.indigo)),
                        const SizedBox(height: 12),
                        Text('Not found in dictionary', style: TextStyle(color: textColor.withValues(alpha: 0.5), fontSize: 14)),
                      ],
                    ),
                  );
                }
                return _QuickLookContent(
                  card: card,
                  isDark: isDark,
                  bgColor: bgColor,
                  textColor: textColor,
                  inDeck: inDeck,
                  asyncCommon: asyncCommon,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickLookContent extends ConsumerWidget {
  final Flashcard card;
  final bool isDark;
  final Color bgColor;
  final Color textColor;
  final bool inDeck;
  final AsyncValue<List<Flashcard>> asyncCommon;

  const _QuickLookContent({
    required this.card,
    required this.isDark,
    required this.bgColor,
    required this.textColor,
    required this.inDeck,
    required this.asyncCommon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Character + pinyin + definition ──────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Big character
              Text(
                card.hanzi,
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w200,
                  color: Colors.indigo,
                  height: 1,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Pinyin
                    Text(
                      card.pinyin,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.indigo.withValues(alpha: 0.8),
                        fontStyle: FontStyle.italic,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // HSK badge
                    if (card.hskLevel > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.indigo.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'HSK ${card.hskLevel}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.indigo,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          // ── Definition ────────────────────────────────────────────────
          Text(
            card.definition,
            style: TextStyle(
              fontSize: 15,
              color: textColor.withValues(alpha: 0.85),
              height: 1.5,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),

          // ── Common compound words ─────────────────────────────────────
          asyncCommon.maybeWhen(
            data: (words) {
              if (words.isEmpty) return const SizedBox.shrink();
              final shown = words.take(3).toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 14),
                  Divider(color: Colors.indigo.withValues(alpha: 0.1), height: 1),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: shown.map((w) => GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        showQuickLook(context, w.hanzi);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.indigo.withValues(alpha: isDark ? 0.15 : 0.07),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.indigo.withValues(alpha: 0.18)),
                        ),
                        child: Text(
                          '${w.hanzi}  ${w.pinyin}',
                          style: const TextStyle(fontSize: 13, color: Colors.indigo, fontWeight: FontWeight.w500),
                        ),
                      ),
                    )).toList(),
                  ),
                ],
              );
            },
            orElse: () => const SizedBox.shrink(),
          ),

          const SizedBox(height: 20),
          // ── Action buttons ────────────────────────────────────────────
          Row(
            children: [
              // Add to deck
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: inDeck ? null : () async {
                    await ref.read(flashcardControllerProvider.notifier).addFlashcard(card);
                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${card.hanzi} added to your deck!'),
                          backgroundColor: Colors.indigo,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      );
                    }
                  },
                  icon: Icon(inDeck ? Icons.check : Icons.bookmark_add_outlined, size: 18),
                  label: Text(inDeck ? 'In Deck' : 'Add to Deck'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: inDeck ? Colors.grey : Colors.indigo,
                    side: BorderSide(color: inDeck ? Colors.grey.withValues(alpha: 0.3) : Colors.indigo.withValues(alpha: 0.4)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Full card
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CharacterDetailScreen(card: card)),
                    );
                  },
                  icon: const Icon(Icons.open_in_new, size: 18),
                  label: const Text('Full Card'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
