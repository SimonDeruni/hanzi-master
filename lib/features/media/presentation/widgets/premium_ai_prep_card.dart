import 'package:flutter/material.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import '../../domain/models/media_briefing.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';

class PremiumAiPrepCard extends StatefulWidget {
  final MediaBriefing briefing;
  final Function(String) onWordTapped;

  const PremiumAiPrepCard({
    super.key,
    required this.briefing,
    required this.onWordTapped,
  });

  @override
  State<PremiumAiPrepCard> createState() => _PremiumAiPrepCardState();
}

class _PremiumAiPrepCardState extends State<PremiumAiPrepCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header row — always visible ────────────────────────────
            GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBF3F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      size: 16,
                      color: Color(0xFF1C2541),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    AppLocalizations.of(context)!.aiPrepRoom,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1C2541),
                    ),
                  ),
                  const Spacer(),
                  // Expand/collapse chevron
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: ZenMotion.of(context, ZenMotion.swap),
                    curve: ZenMotion.natural,
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.grey[500],
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),

            // ── Key vocab chips — always visible ──────────────────────
            if (widget.briefing.hardWords.isNotEmpty) ...[
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: widget.briefing.hardWords.take(6).map((w) {
                  Offset? tapPosition;
                  return GestureDetector(
                    onTapDown: (details) => tapPosition = details.globalPosition,
                    onTap: () {
                      widget.onWordTapped(w);
                      if (tapPosition != null) {
                        showQuickLook(
                          context,
                          w,
                          presentation: QuickLookPresentation.readingPopover,
                          anchorPosition: tapPosition,
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBF3F9),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        w,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1C2541),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],

            // ── Expandable summary body ────────────────────────────────
            AnimatedCrossFade(
              firstChild: const SizedBox(width: double.infinity, height: 0),
              secondChild: Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(height: 1, color: Color(0xFFE8E8E8)),
                    const SizedBox(height: 12),
                    Text(
                      AppLocalizations.of(context)!.lessonSummary,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9E9E9E),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.briefing.summary,
                      style: const TextStyle(
                        fontSize: 13.5,
                        height: 1.5,
                        color: Color(0xFF2C2C2C),
                      ),
                    ),
                  ],
                ),
              ),
              crossFadeState: _expanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: ZenMotion.of(context, ZenMotion.swap),
              sizeCurve: ZenMotion.natural,
            ),
          ],
        ),
      ),
    );
  }
}
