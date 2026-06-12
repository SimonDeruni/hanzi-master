import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';

/// CJK Unified Ideographs: basic block + Ext-A + Compatibility Ideographs.
/// Covers the vast majority of characters used in modern Chinese.
final _cjkPattern = RegExp(
  r'[\u4e00-\u9fff'    // CJK Unified Ideographs (basic — most common)
  r'\u3400-\u4dbf'    // CJK Extension A
  r'\uf900-\ufaff'    // CJK Compatibility Ideographs
  r'\u3005'           // 々 (iteration mark)
  r']',
  unicode: true,
);

// ---------------------------------------------------------------------------
// StatefulWidget base — manages TapGestureRecognizer lifecycle correctly.
// Creating recognizers in a StatelessWidget causes gesture arena corruption
// because they are never disposed when the widget rebuilds.
// ---------------------------------------------------------------------------

abstract class _TappableBase extends StatefulWidget {
  const _TappableBase({super.key});
}

abstract class _TappableBaseState<T extends _TappableBase> extends State<T> {
  final List<TapGestureRecognizer> _recognizers = [];

  void _disposeRecognizers() {
    for (final r in _recognizers) {
      r.dispose();
    }
    _recognizers.clear();
  }

  TapGestureRecognizer _makeRecognizer(String char) {
    final r = TapGestureRecognizer()
      ..onTap = () => showQuickLook(context, char);
    _recognizers.add(r);
    return r;
  }

  @override
  void dispose() {
    _disposeRecognizers();
    super.dispose();
  }
}

// ---------------------------------------------------------------------------
// TappableHanziText — drop-in for plain Text widgets.
// ---------------------------------------------------------------------------

class TappableHanziText extends _TappableBase {
  final String text;
  final TextStyle? style;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const TappableHanziText(
    this.text, {
    super.key,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  @override
  State<TappableHanziText> createState() => _TappableHanziTextState();
}

class _TappableHanziTextState extends _TappableBaseState<TappableHanziText> {
  List<InlineSpan>? _spans;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _rebuildSpans();
  }

  @override
  void didUpdateWidget(TappableHanziText old) {
    super.didUpdateWidget(old);
    if (old.text != widget.text || old.style != widget.style) {
      _rebuildSpans();
    }
  }

  void _rebuildSpans() {
    _disposeRecognizers();
    final resolved = DefaultTextStyle.of(context).style.merge(widget.style);
    _spans = _buildSpans(resolved);
  }

  List<InlineSpan> _buildSpans(TextStyle resolved) {
    final spans = <InlineSpan>[];
    int cursor = 0;
    for (final match in _cjkPattern.allMatches(widget.text)) {
      if (match.start > cursor) {
        spans.add(TextSpan(
          text: widget.text.substring(cursor, match.start),
          style: resolved,
        ));
      }
      final char = match.group(0)!;
      spans.add(TextSpan(
        text: char,
        style: resolved.copyWith(
          decoration: TextDecoration.underline,
          decorationColor: Colors.indigo.withValues(alpha: 0.35),
          decorationStyle: TextDecorationStyle.dotted,
        ),
        recognizer: _makeRecognizer(char),
      ));
      cursor = match.end;
    }
    if (cursor < widget.text.length) {
      spans.add(TextSpan(text: widget.text.substring(cursor), style: resolved));
    }
    return spans.isEmpty
        ? [TextSpan(text: widget.text, style: resolved)]
        : spans;
  }

  @override
  Widget build(BuildContext context) {
    final spans = _spans ?? [];
    return RichText(
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      overflow: widget.overflow ?? TextOverflow.clip,
      text: TextSpan(children: spans),
    );
  }
}

// ---------------------------------------------------------------------------
// TappableMarkdownHanziText — parses **bold**, *italic*, `code` AND makes
// every CJK character tappable. Used in AI chat bubbles.
// ---------------------------------------------------------------------------

class TappableMarkdownHanziText extends _TappableBase {
  final String text;
  final TextStyle? style;
  final TextAlign textAlign;

  const TappableMarkdownHanziText(
    this.text, {
    super.key,
    this.style,
    this.textAlign = TextAlign.start,
  });

  @override
  State<TappableMarkdownHanziText> createState() =>
      _TappableMarkdownHanziTextState();
}

class _TappableMarkdownHanziTextState
    extends _TappableBaseState<TappableMarkdownHanziText> {
  // Italic: single * NOT preceded or followed by another * (so **bold** is not confused)
  // Bullet lines: handled in _preprocessText before regex runs
  static final _mdPattern = RegExp(
    r'\*\*(.+?)\*\*'             // **bold**
    r'|(?<!\*)\*(?!\*)(.+?)(?<!\*)\*(?!\*)' // *italic* (not **)
    r'|`(.+?)`',                  // `code`
    dotAll: false,
  );

  /// Pre-processes raw AI text before markdown parsing:
  /// - Converts line-start `* ` or `- ` bullets to `• `
  /// - Strips orphan single asterisks left at end of words (e.g. 我们*)
  static String _preprocessText(String text) {
    // Convert line-start bullet markers to Unicode bullet.
    // Matches ^ (start of line) optionally followed by spaces, then * or -, then a space.
    return text.replaceAllMapped(
      RegExp(r'^[ \t]*[\*\-]( |$)', multiLine: true),
      (m) => '• ',
    );
  }

  List<InlineSpan>? _spans;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _rebuildSpans();
  }

  @override
  void didUpdateWidget(TappableMarkdownHanziText old) {
    super.didUpdateWidget(old);
    if (old.text != widget.text || old.style != widget.style) {
      _rebuildSpans();
    }
  }

  void _rebuildSpans() {
    _disposeRecognizers();
    final resolved = DefaultTextStyle.of(context).style.merge(widget.style);
    _spans = _buildSpans(resolved);
  }

  void _addCjkSpans(
    List<InlineSpan> target,
    String segment,
    TextStyle segStyle,
  ) {
    int c = 0;
    for (final m in _cjkPattern.allMatches(segment)) {
      if (m.start > c) {
        target.add(TextSpan(
          text: segment.substring(c, m.start),
          style: segStyle,
        ));
      }
      final char = m.group(0)!;
      target.add(TextSpan(
        text: char,
        style: segStyle.copyWith(
          decoration: TextDecoration.underline,
          decorationColor: Colors.indigo.withValues(alpha: 0.35),
          decorationStyle: TextDecorationStyle.dotted,
        ),
        recognizer: _makeRecognizer(char),
      ));
      c = m.end;
    }
    if (c < segment.length) {
      target.add(TextSpan(text: segment.substring(c), style: segStyle));
    }
  }

  List<InlineSpan> _buildSpans(TextStyle base) {
    final all = <InlineSpan>[];
    final processedText = _preprocessText(widget.text);
    int last = 0;

    for (final match in _mdPattern.allMatches(processedText)) {
      if (match.start > last) {
        _addCjkSpans(all, processedText.substring(last, match.start), base);
      }
      if (match.group(1) != null) {
        _addCjkSpans(
            all, match.group(1)!, base.copyWith(fontWeight: FontWeight.bold));
      } else if (match.group(2) != null) {
        _addCjkSpans(
            all, match.group(2)!, base.copyWith(fontStyle: FontStyle.italic));
      } else if (match.group(3) != null) {
        all.add(TextSpan(
          text: match.group(3),
          style: base.copyWith(
            color: Colors.indigo,
            fontWeight: FontWeight.w600,
          ),
        ));
      }
      last = match.end;
    }
    if (last < processedText.length) {
      _addCjkSpans(all, processedText.substring(last), base);
    }
    return all.isEmpty ? [TextSpan(text: processedText, style: base)] : all;
  }

  @override
  Widget build(BuildContext context) {
    final spans = _spans ?? [];
    return RichText(
      textAlign: widget.textAlign,
      text: TextSpan(children: spans),
    );
  }
}
