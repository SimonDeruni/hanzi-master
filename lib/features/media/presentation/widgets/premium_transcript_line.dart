import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';
import '../../domain/models/video_transcript.dart';

class PremiumTranscriptLine extends StatefulWidget {
  final TranscriptLine line;
  final bool isCurrent;
  final int highlightedCount;
  final VoidCallback onReplay;
  final VoidCallback? onLineTapped;
  final Function(String) onWordTapped;
  final bool showPinyin;
  final bool showEnglish;
  final String? simplifiedText;
  final bool isShadowingMode;
  final bool isRecordingThisLine;
  final VoidCallback? onShadowTapped;

  const PremiumTranscriptLine({
    super.key,
    required this.line,
    required this.isCurrent,
    required this.highlightedCount,
    required this.onReplay,
    this.onLineTapped,
    required this.onWordTapped,
    this.showPinyin = true,
    this.showEnglish = true,
    this.simplifiedText,
    this.isShadowingMode = false,
    this.isRecordingThisLine = false,
    this.onShadowTapped,
  });

  @override
  State<PremiumTranscriptLine> createState() => _PremiumTranscriptLineState();
}

class _PremiumTranscriptLineState extends State<PremiumTranscriptLine> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    if (widget.isRecordingThisLine) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(PremiumTranscriptLine oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRecordingThisLine != oldWidget.isRecordingThisLine) {
      if (widget.isRecordingThisLine) {
        _pulseController.repeat(reverse: true);
      } else {
        _pulseController.stop();
        _pulseController.value = 0.0;
      }
    }
  }

  final List<TapGestureRecognizer> _recognizers = [];
  int? _selectedCharIndex;

  @override
  void dispose() {
    for (final r in _recognizers) {
      r.dispose();
    }
    _recognizers.clear();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    for (final r in _recognizers) {
      r.dispose();
    }
    _recognizers.clear();

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline indicator & play button column
          SizedBox(
            width: 40,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // Vertical Timeline Line
                Container(
                  width: 2,
                  color: const Color(0xFFE0E0E0),
                  margin: const EdgeInsets.only(top: 24, bottom: 0),
                ),
                // Play Icon (Active) or Bullet (Inactive)
                Positioned(
                  top: 12,
                  child: widget.isCurrent
                      ? GestureDetector(
                          onTap: widget.onReplay,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.play_circle_outline,
                              color: Colors.blueAccent,
                              size: 28,
                            ),
                          ),
                        )
                      : Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(top: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xFFE0E0E0),
                            shape: BoxShape.circle,
                          ),
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          
          // Subtitle Content Block
          Expanded(
            child: GestureDetector(
              onTap: widget.onLineTapped,
              behavior: HitTestBehavior.opaque,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.isCurrent ? const Color(0xFFE8F0FE) : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: widget.isCurrent 
                      ? Border.all(color: Colors.blueAccent.withValues(alpha: 0.3))
                      : Border.all(color: Colors.transparent),
                  boxShadow: widget.isCurrent 
                      ? [
                          BoxShadow(
                            color: Colors.blueAccent.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 0),
                          )
                        ]
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Hanzi Line
                    RichText(
                      text: TextSpan(
                        children: widget.line.text.split('').asMap().entries.map((entry) {
                          final charIndex = entry.key;
                          final char = entry.value;
                          final isHighlighted = widget.isCurrent && charIndex <= widget.highlightedCount;
                          final isChinese = RegExp(r'[\u4e00-\u9fff]').hasMatch(char);
                          final isSelected = _selectedCharIndex == charIndex;

                          TapGestureRecognizer? recognizer;
                          if (isChinese) {
                            Offset? anchorPosition;
                            recognizer = TapGestureRecognizer()
                              ..onTapDown = (details) {
                                anchorPosition = details.globalPosition;
                              }
                              ..onTap = () async {
                                widget.onWordTapped(char);
                                setState(() {
                                  _selectedCharIndex = charIndex;
                                });
                                await showQuickLook(
                                  context,
                                  char,
                                  contextText: widget.line.text,
                                  presentation: QuickLookPresentation.readingPopover,
                                  anchorPosition: anchorPosition,
                                  onDismiss: () {
                                    if (mounted) {
                                      setState(() {
                                        if (_selectedCharIndex == charIndex) {
                                          _selectedCharIndex = null;
                                        }
                                      });
                                    }
                                  },
                                );
                                if (mounted) {
                                  setState(() {
                                    if (_selectedCharIndex == charIndex) {
                                      _selectedCharIndex = null;
                                    }
                                  });
                                }
                              };
                            _recognizers.add(recognizer);
                          }

                          return TextSpan(
                            text: char,
                            style: TextStyle(
                              fontSize: 22,
                              backgroundColor: isSelected
                                  ? const Color(0xFF4F46E5).withValues(alpha: 0.22)
                                  : null,
                              color: isSelected
                                  ? const Color(0xFF4F46E5)
                                  : isHighlighted
                                      ? const Color(0xFF1976D2)
                                      : const Color(0xFF2C2C2C),
                              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w500,
                              height: 1.5,
                              fontFamily: 'NotoSerifSC', // fallback if needed
                            ),
                            recognizer: recognizer,
                          );
                        }).toList(),
                      ),
                    ),
                    
                    // 2. Pinyin Line
                    if (widget.showPinyin) ...[
                      () {
                        final raw = widget.line.pinyin?.trim();
                        final translation = widget.line.translation?.trim().toLowerCase();
                        String? effectivePinyin;
                        if (raw != null && raw.isNotEmpty && (translation == null || raw.toLowerCase() != translation)) {
                          effectivePinyin = raw;
                        } else if (RegExp(r'[\u4e00-\u9fff]').hasMatch(widget.line.text)) {
                          effectivePinyin = PinyinHelper.getPinyinE(widget.line.text,
                              separator: ' ', format: PinyinFormat.WITH_TONE_MARK);
                        }

                        if (effectivePinyin != null && effectivePinyin.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              effectivePinyin,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF757575),
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      }(),
                    ],
                      
                    // 3. English/Local Translation Line + Shadowing Button
                    if (widget.showEnglish || widget.isShadowingMode)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.showEnglish)
                              Expanded(
                                child: Text(
                                  widget.line.translation ??
                                      AppLocalizations.of(context)?.translating ??
                                      "[ Translating... ]",
                                  style: const TextStyle(
                                    fontSize: 14, 
                                    fontStyle: FontStyle.italic,
                                    color: Color(0xFF9E9E9E),
                                  ),
                                ),
                              )
                            else
                              const Spacer(),
                            const SizedBox(width: 8),
                            
                            // Shadowing / Mic Button
                            GestureDetector(
                              onTap: widget.onShadowTapped,
                              child: AnimatedBuilder(
                                animation: _pulseAnimation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: widget.isRecordingThisLine ? _pulseAnimation.value : 1.0,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: widget.isRecordingThisLine 
                                            ? Colors.red.withValues(alpha: 0.2) 
                                            : Colors.indigo.withValues(alpha: 0.1),
                                        boxShadow: widget.isRecordingThisLine ? [
                                          BoxShadow(color: Colors.red.withValues(alpha: 0.4), blurRadius: 8, spreadRadius: 2)
                                        ] : null,
                                      ),
                                      child: Icon(
                                        widget.isRecordingThisLine ? Icons.stop : Icons.mic,
                                        color: widget.isRecordingThisLine ? Colors.red : Colors.indigo,
                                        size: 20,
                                      ),
                                    ),
                                  );
                                }
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
