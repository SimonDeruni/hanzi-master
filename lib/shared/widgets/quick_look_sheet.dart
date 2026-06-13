import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/utils/pinyin_utils.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/character_detail_provider.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/character_detail_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/flashcard_edit_dialog.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';

// ---------------------------------------------------------------------------
// Helpers — clean raw CC-CEDICT strings before display
// ---------------------------------------------------------------------------

/// Converts numeric pinyin to proper tone marks: da4 → dà, jiao1 → jiāo
String _cleanPinyin(String raw) => PinyinUtils.convertNumericToMarks(raw);

/// Strips CC-CEDICT embedded annotations like 大姐[da4 jie3] → 大姐
/// and trims the definition to the first 2 meaningful parts.
String _cleanDefinition(String raw) {
  // 1. Remove bracketed pinyin annotations: word[pin1 yin1]
  String s = raw.replaceAll(RegExp(r'\[[a-zA-Z0-9\s:]+\]'), '');
  // 2. Remove standalone numeric pinyin remnants
  s = s.replaceAll(RegExp(r'\b[a-zA-Z]+[1-5]\b'), '');
  // 3. Split on semicolons and take first 3 distinct parts
  final parts = s
      .split(';')
      .map((p) => p.trim())
      .where((p) => p.isNotEmpty && p.length > 1)
      .toList();
  if (parts.isEmpty) return s.trim();
  // Cap at 3 to avoid walls of text
  final shown = parts.take(3).join('; ');
  final remainder = parts.length > 3 ? '…' : '';
  return shown + remainder;
}

/// Shows a compact "Quick Look" bottom sheet for a single Chinese character.
void showQuickLook(BuildContext context, String hanzi) {
  if (hanzi.isEmpty) return;
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (ctx) => _QuickLookSheet(hanzi: hanzi),
  );
}

// ---------------------------------------------------------------------------
// Shell — handles loading / error / found states
// ---------------------------------------------------------------------------

class _QuickLookSheet extends ConsumerWidget {
  final String hanzi;
  const _QuickLookSheet({required this.hanzi});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final asyncCard = ref.watch(quickLookProvider(hanzi));
    final asyncCommon = ref.watch(commonWordsProvider(hanzi));
    final allCards = ref.watch(flashcardControllerProvider).value ?? [];
    final inDeck = allCards.any((c) => c.hanzi == hanzi);

    return _SheetShell(
      isDark: isDark,
      child: asyncCard.when(
        loading: () => _LoadingBody(isDark: isDark),
        error: (_, __) => _NotFoundBody(hanzi: hanzi, isDark: isDark),
        data: (card) => card == null
            ? _NotFoundBody(hanzi: hanzi, isDark: isDark)
            : _FoundBody(
                card: card,
                isDark: isDark,
                inDeck: inDeck,
                asyncCommon: asyncCommon,
              ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared shell — rounded sheet with drag handle and gradient header zone
// ---------------------------------------------------------------------------

class _SheetShell extends StatelessWidget {
  final bool isDark;
  final Widget child;
  const _SheetShell({required this.isDark, required this.child});

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? const Color(0xFF1C1C1E) : const Color(0xFFFDFCF0);
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 32,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 6),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: isDark ? 0.4 : 0.28),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Loading state
// ---------------------------------------------------------------------------

class _LoadingBody extends StatelessWidget {
  final bool isDark;
  const _LoadingBody({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 56),
      child: Center(
        child: CircularProgressIndicator(color: Colors.indigo, strokeWidth: 2),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Not found state
// ---------------------------------------------------------------------------

class _NotFoundBody extends ConsumerStatefulWidget {
  final String hanzi;
  final bool isDark;
  const _NotFoundBody({required this.hanzi, required this.isDark});

  @override
  ConsumerState<_NotFoundBody> createState() => _NotFoundBodyState();
}

class _NotFoundBodyState extends ConsumerState<_NotFoundBody> {
  bool _isLoadingAi = true;
  String _pinyin = '';
  String _definition = '';

  @override
  void initState() {
    super.initState();
    _fetchAiDefinition();
  }

  Future<void> _fetchAiDefinition() async {
    try {
      final aiDef = await ref.read(geminiServiceProvider).defineWord(widget.hanzi);
      if (mounted) {
        setState(() {
          _pinyin = aiDef['pinyin'] ?? '?';
          _definition = aiDef['meaning'] ?? 'Not found';
          _isLoadingAi = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _definition = 'Error loading from AI.';
          _isLoadingAi = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = widget.isDark ? Colors.white : const Color(0xFF1A1A1B);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _CharacterHero(hanzi: widget.hanzi, isDark: widget.isDark, pinyin: _pinyin, hskLevel: 0, definition: _definition),
          const SizedBox(height: 16),
          if (_isLoadingAi)
            const SizedBox(
              width: 24, height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add_box),
                label: const Text("Review & Add to Library"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                onPressed: () {
                  FlashcardEditDialog.show(
                    context,
                    hanzi: widget.hanzi,
                    pinyin: _pinyin,
                    definition: _definition,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Main content when character is found
// ---------------------------------------------------------------------------

class _FoundBody extends ConsumerWidget {
  final Flashcard card;
  final bool isDark;
  final bool inDeck;
  final AsyncValue<List<Flashcard>> asyncCommon;

  const _FoundBody({
    required this.card,
    required this.isDark,
    required this.inDeck,
    required this.asyncCommon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textColor = isDark ? Colors.white : const Color(0xFF1A1A1B);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Character hero panel ─────────────────────────────────────
          _CharacterHero(
            hanzi: card.hanzi,
            isDark: isDark,
            pinyin: card.pinyin,
            hskLevel: card.hskLevel,
            definition: card.definition,
          ),

          // ── Compound words ───────────────────────────────────────────
          asyncCommon.maybeWhen(
            data: (words) {
              if (words.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Container(
                        width: 3,
                        height: 13,
                        decoration: BoxDecoration(
                          color: Colors.indigo.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 7),
                      Text(
                        'Also seen in',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.6,
                          color: textColor.withValues(alpha: 0.45),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: words.take(5).length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (ctx, i) {
                        final w = words.toList()[i];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            showQuickLook(context, w.hanzi);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.indigo
                                  .withValues(alpha: isDark ? 0.18 : 0.08),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.indigo
                                      .withValues(alpha: isDark ? 0.3 : 0.18)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  w.hanzi,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.w600,
                                    height: 1,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  _cleanPinyin(w.pinyin),
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    color:
                                        Colors.indigo.withValues(alpha: 0.65),
                                    height: 1,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
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
              // Add / In Deck button
              Expanded(
                child: _ActionButton(
                  label: inDeck ? 'In Deck ✓' : '+ Add to Deck',
                  isPrimary: false,
                  isDisabled: inDeck,
                  onTap: inDeck
                      ? null
                      : () async {
                          await ref
                              .read(flashcardControllerProvider.notifier)
                              .addFlashcard(card);
                          if (context.mounted) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${card.hanzi} added!'),
                                backgroundColor: Colors.indigo,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            );
                          }
                        },
                ),
              ),
              const SizedBox(width: 10),
              // Full card button
              Expanded(
                child: _ActionButton(
                  label: 'Open Card →',
                  isPrimary: true,
                  isDisabled: false,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CharacterDetailScreen(card: card)),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Character Hero — the gradient spotlight panel
// ---------------------------------------------------------------------------

class _CharacterHero extends StatelessWidget {
  final String hanzi;
  final String pinyin;
  final int hskLevel;
  final bool isDark;
  final String definition;

  const _CharacterHero({
    required this.hanzi,
    required this.pinyin,
    required this.hskLevel,
    required this.isDark,
    required this.definition,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  Colors.indigo.shade900.withValues(alpha: 0.6),
                  Colors.indigo.shade800.withValues(alpha: 0.2),
                ]
              : [
                  Colors.indigo.shade50,
                  Colors.indigo.shade100.withValues(alpha: 0.3),
                ],
        ),
        border: Border.all(
          color: Colors.indigo.withValues(alpha: isDark ? 0.3 : 0.15),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Faint Calligraphy Watermark on the far right
            Positioned(
              right: -30,
              top: -20,
              bottom: -20,
              child: Opacity(
                opacity: isDark ? 0.04 : 0.06,
                child: Center(
                  child: Text(
                    hanzi,
                    style: TextStyle(
                      fontSize: 140,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.indigo.shade900,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ),
            
            // Foreground Content
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Large character
                  Text(
                    hanzi,
                    style: TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.w100,
                      color: isDark ? Colors.white : Colors.indigo.shade800,
                      height: 1,
                      shadows: [
                        Shadow(
                          color: Colors.indigo.withValues(alpha: isDark ? 0.4 : 0.15),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 18),
                  
                  // Pinyin + Definition + Badges
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (pinyin.isNotEmpty)
                          Text(
                            _cleanPinyin(pinyin),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: isDark
                                  ? Colors.white70
                                  : Colors.indigo.shade700,
                              fontStyle: FontStyle.italic,
                              letterSpacing: 0.5,
                            ),
                          ),
                        const SizedBox(height: 6),
                        
                        // English definition integrated into the card
                        if (definition.isNotEmpty)
                          Text(
                            _cleanDefinition(definition),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.white.withValues(alpha: 0.75) : const Color(0xFF1A1A1B).withValues(alpha: 0.75),
                              height: 1.3,
                            ),
                          ),
                        const SizedBox(height: 10),
                        
                        Row(
                          children: [
                            if (hskLevel > 0)
                              _Badge(
                                label: 'HSK $hskLevel',
                                color: Colors.indigo,
                                isDark: isDark,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Small badge chip
// ---------------------------------------------------------------------------

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  final bool isDark;
  const _Badge({required this.label, required this.color, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.25 : 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: isDark ? 0.5 : 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: isDark ? Colors.white70 : color,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Action button — primary (indigo filled) or secondary (outlined)
// ---------------------------------------------------------------------------

class _ActionButton extends StatelessWidget {
  final String label;
  final bool isPrimary;
  final bool isDisabled;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.label,
    required this.isPrimary,
    required this.isDisabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = isDisabled ? Colors.grey : Colors.indigo;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isPrimary
              ? (isDisabled
                  ? Colors.grey.shade300
                  : Colors.indigo)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: isPrimary
              ? null
              : Border.all(
                  color: effectiveColor.withValues(alpha: 0.4),
                  width: 1.5,
                ),
          boxShadow: isPrimary && !isDisabled
              ? [
                  BoxShadow(
                    color: Colors.indigo.withValues(alpha: 0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isPrimary
                ? Colors.white
                : (isDisabled
                    ? Colors.grey
                    : Colors.indigo),
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
