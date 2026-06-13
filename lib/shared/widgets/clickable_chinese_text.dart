import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/dictionary_quick_box.dart';

class ClickableChineseText extends ConsumerStatefulWidget {
  final String text;
  final TextStyle? style;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const ClickableChineseText(
    this.text, {
    super.key,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  @override
  ConsumerState<ClickableChineseText> createState() => _ClickableChineseTextState();
}

class _ClickableChineseTextState extends ConsumerState<ClickableChineseText> {
  List<InlineSpan> _spans = [];
  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void initState() {
    super.initState();
    _buildSpans();
  }

  @override
  void didUpdateWidget(ClickableChineseText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text || oldWidget.style != widget.style) {
      _buildSpans();
    }
  }

  Future<void> _handleWordTap(BuildContext context, WidgetRef ref, String char) async {
    final repo = ref.read(globalDictionaryRepositoryProvider);
    final flashcards = ref.read(flashcardControllerProvider).valueOrNull ?? [];
    final isInLibrary = flashcards.any((c) => c.hanzi == char);
    
    Flashcard? card = await repo.getExact(char);
    if (card == null) {
      card = Flashcard(
        id: 'dummy_$char',
        hanzi: char,
        pinyin: '?',
        definition: 'Not found in offline dictionary.',
        hskLevel: 0,
        strokePaths: const [],
        nextReviewDate: DateTime.now(),
        interval: 0,
        easeFactor: 2.5,
        streak: 0,
      );
    }
    
    if (context.mounted) {
      DictionaryQuickBox.show(context, card: card, isInLibrary: isInLibrary);
    }
  }

  void _disposeRecognizers() {
    for (var r in _recognizers) {
      r.dispose();
    }
    _recognizers.clear();
  }

  void _buildSpans() {
    _disposeRecognizers();
    _spans = [];

    final RegExp chineseRegex = RegExp(r'[\u4e00-\u9fa5]');
    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < widget.text.length; i++) {
      final char = widget.text[i];
      if (chineseRegex.hasMatch(char)) {
        if (buffer.isNotEmpty) {
          _spans.add(TextSpan(text: buffer.toString(), style: widget.style));
          buffer.clear();
        }
        
        final recognizer = TapGestureRecognizer()
          ..onTap = () {
            _handleWordTap(context, ref, char);
          };
        _recognizers.add(recognizer);

        _spans.add(
          TextSpan(
            text: char,
            style: (widget.style ?? const TextStyle()).copyWith(
              color: Colors.blueAccent, // Highlight clickable Chinese chars
              fontWeight: FontWeight.w500,
            ),
            recognizer: recognizer,
          ),
        );
      } else {
        buffer.write(char);
      }
    }

    if (buffer.isNotEmpty) {
      _spans.add(TextSpan(text: buffer.toString(), style: widget.style));
    }
  }

  @override
  void dispose() {
    _disposeRecognizers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      overflow: widget.overflow ?? (widget.maxLines != null ? TextOverflow.ellipsis : TextOverflow.clip),
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: _spans,
      ),
    );
  }
}
