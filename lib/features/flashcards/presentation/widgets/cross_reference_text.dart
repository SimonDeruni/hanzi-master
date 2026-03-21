import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/dictionary_provider.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/character_detail_screen.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';

class CrossReferenceText extends ConsumerStatefulWidget {
  final String text;
  final TextStyle? style;
  final TextStyle? linkStyle;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const CrossReferenceText(
    this.text, {
    super.key,
    this.style,
    this.linkStyle,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  @override
  ConsumerState<CrossReferenceText> createState() => _CrossReferenceTextState();
}

class _CrossReferenceTextState extends ConsumerState<CrossReferenceText> {
  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void dispose() {
    for (var recognizer in _recognizers) {
      recognizer.dispose();
    }
    super.dispose();
  }

  void _onEntryTapped(String hanzi, DictionaryEntry entry) {
    if (entry.inLibrary) {
      // Navigate to detail screen using a temporary card if necessary,
      // but ideally we find the real card from the controller.
      // For now, constructing a minimal card that the detail screen can use.
      final card = Flashcard(
        id: hanzi, // Simplified ID for lookup
        hanzi: entry.hanzi,
        pinyin: entry.pinyin,
        definition: entry.definition,
        hskLevel: entry.hskLevel,
        strokePaths: const [],
        nextReviewDate: DateTime.now(),
        interval: 0,
        easeFactor: 0,
        streak: 0,
      );
      
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CharacterDetailScreen(card: card)),
      );
    } else {
      // Show "Pre-import" detail view or a snackbar with basic info
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${entry.hanzi} [${entry.pinyin}]: ${entry.definition}"),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: "Detail",
            onPressed: () {
              final card = Flashcard(
                id: hanzi,
                hanzi: entry.hanzi,
                pinyin: entry.pinyin,
                definition: entry.definition,
                hskLevel: entry.hskLevel,
                strokePaths: const [],
                nextReviewDate: DateTime.now(),
                interval: 0,
                easeFactor: 0,
                streak: 0,
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CharacterDetailScreen(card: card)),
              );
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    for (var recognizer in _recognizers) {
      recognizer.dispose();
    }
    _recognizers.clear();

    final dictionaryAsync = ref.watch(masterDictionaryProvider);
    final dictionary = ref.read(masterDictionaryProvider.notifier);
    
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    final TextStyle baseStyle = widget.style ?? defaultTextStyle.style;
    
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final TextStyle libraryLinkStyle = widget.linkStyle ?? baseStyle.copyWith(
      color: isDark ? Colors.amber.shade300 : Colors.orange.shade800,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
    );
    final TextStyle dictionaryLinkStyle = widget.linkStyle ?? baseStyle.copyWith(
      color: isDark ? Colors.indigo.shade300 : Colors.indigo.shade700,
      fontWeight: FontWeight.bold,
    );

    // If dictionary isn't ready yet, just show plain text
    if (dictionaryAsync is AsyncLoading || dictionaryAsync is AsyncError) {
      return Text(widget.text, style: baseStyle, textAlign: widget.textAlign);
    }

    // Segment the text using MFM
    final segments = dictionary.segment(widget.text);
    final List<TextSpan> spans = [];

    for (final segment in segments) {
      final entry = dictionary.lookup(segment);
      
      if (entry != null) {
        final TapGestureRecognizer recognizer = TapGestureRecognizer()
          ..onTap = () => _onEntryTapped(segment, entry);
        _recognizers.add(recognizer);

        spans.add(TextSpan(
          text: segment,
          style: entry.inLibrary ? libraryLinkStyle : dictionaryLinkStyle,
          recognizer: recognizer,
        ));
      } else {
        spans.add(TextSpan(
          text: segment,
          style: baseStyle,
        ));
      }
    }

    return RichText(
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      overflow: widget.overflow ?? (widget.maxLines != null ? TextOverflow.ellipsis : TextOverflow.clip),
      text: TextSpan(children: spans),
    );
  }
}
