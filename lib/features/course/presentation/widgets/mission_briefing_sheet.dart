import 'package:flutter/material.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/calligraphy_background.dart';
import 'package:hanzi_master/shared/widgets/pinyin_text.dart';

class MissionBriefingSheet extends StatelessWidget {
  final Flashcard targetCard;
  final List<Flashcard> warmupCards;
  final String radicalHanzi; 
  final VoidCallback onStart;
  final Function(Flashcard)? onComponentTap;

  const MissionBriefingSheet({
    super.key,
    required this.targetCard,
    required this.warmupCards,
    required this.radicalHanzi,
    required this.onStart,
    this.onComponentTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: Stack(
          children: [
            Positioned.fill(child: CalligraphyBackground(child: Container())),
            
            Column(
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40, height: 4,
                    decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(2)),
                  ),
                ),
                
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // 1. HEADER (Identity)
                        Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.indigo.withValues(alpha: 0.3), width: 1.5),
                            boxShadow: [
                              BoxShadow(color: Colors.indigo.withValues(alpha: 0.1), blurRadius: 20, spreadRadius: 5)
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                targetCard.hanzi,
                                style: TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.indigoAccent : Colors.indigo.shade900,
                                  height: 1.0,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                targetCard.pinyin,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.redAccent.shade200,
                                  fontStyle: FontStyle.italic
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                targetCard.definition.split(';').first.toUpperCase(),
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2.0, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 32),
                        
                        // 2. THE BLUEPRINT (Decomposition)
                        if (warmupCards.isNotEmpty) ...[
                          _buildSectionHeader(Icons.architecture, "THE BLUEPRINT"),
                          const SizedBox(height: 24),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 0; i < warmupCards.length; i++) ...[
                                  _ComponentBox(
                                    card: warmupCards[i], 
                                    isDark: isDark,
                                    isRadical: warmupCards[i].hanzi == radicalHanzi,
                                    onTap: () {
                                      if (onComponentTap != null) onComponentTap!(warmupCards[i]);
                                    },
                                  ),
                                  if (i < warmupCards.length - 1) 
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8),
                                      child: Icon(Icons.add, color: Colors.grey, size: 16),
                                    ),
                                ],
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Icon(Icons.arrow_forward, color: Colors.grey, size: 16),
                                ),
                                _ComponentBox(card: targetCard, isDark: isDark, isTarget: true),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Tap building blocks to explore their origin.",
                            style: TextStyle(fontSize: 14, color: isDark ? Colors.white54 : Colors.grey.shade600, fontStyle: FontStyle.italic),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                // 3. ACTION BUTTON
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: onStart,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 4,
                      ),
                      icon: const Icon(Icons.auto_awesome),
                      label: const Text("BEGIN JOURNEY", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
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

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.5)),
      ],
    );
  }
}

class _ComponentBox extends StatelessWidget {
  final Flashcard card;
  final bool isDark;
  final bool isTarget;
  final bool isRadical;
  final VoidCallback? onTap;

  const _ComponentBox({
    required this.card, 
    required this.isDark, 
    this.isTarget = false,
    this.isRadical = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isTarget 
        ? Colors.indigo 
        : (isRadical ? Colors.deepOrange : Colors.grey);
    
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60, height: 60,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isRadical ? Colors.deepOrange.withValues(alpha: 0.8) : color.withValues(alpha: 0.5), 
                width: isRadical ? 3 : 2,
              ),
              boxShadow: [
                if (isRadical) BoxShadow(color: Colors.deepOrange.withValues(alpha: 0.2), blurRadius: 10, spreadRadius: 1)
              ],
            ),
            child: Center(
              child: Text(
                card.hanzi,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color),
              ),
            ),
          ),
          const SizedBox(height: 6),
          PinyinText(
            text: card.pinyin.isEmpty ? "-" : card.pinyin,
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
          Text(
            card.definition.split(';').first.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}
