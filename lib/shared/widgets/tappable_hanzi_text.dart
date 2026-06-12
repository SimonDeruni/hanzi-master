import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';

/// Regex matching a single CJK Unified Ideograph (basic + Extension A/B blocks).
final _cjkPattern = RegExp(r'[\u4e00-\u9fff\u3400-\u4dbf\u{20000}-\u{2a6df}]', unicode: true);

/// A text widget that makes every CJK character individually tappable.
/// Tap any Chinese character to open the Quick Look sheet.
///
/// Drop-in replacement for [Text] / [RichText].
class TappableHanziText extends StatelessWidget {
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

  List<InlineSpan> _buildSpans(BuildContext context, TextStyle resolved) {
    final spans = <InlineSpan>[];
    int cursor = 0;

    for (final match in _cjkPattern.allMatches(text)) {
      // Plain text before this CJK character
      if (match.start > cursor) {
        spans.add(TextSpan(
          text: text.substring(cursor, match.start),
          style: resolved,
        ));
      }

      final char = match.group(0)!;

      // Tappable CJK character
      spans.add(TextSpan(
        text: char,
        style: resolved.copyWith(
          decoration: TextDecoration.underline,
          decorationColor: Colors.indigo.withValues(alpha: 0.4),
          decorationStyle: TextDecorationStyle.dotted,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () => showQuickLook(context, char),
      ));

      cursor = match.end;
    }

    // Remaining plain text
    if (cursor < text.length) {
      spans.add(TextSpan(text: text.substring(cursor), style: resolved));
    }

    return spans.isEmpty ? [TextSpan(text: text, style: resolved)] : spans;
  }

  @override
  Widget build(BuildContext context) {
    final resolved = DefaultTextStyle.of(context).style.merge(style);
    return RichText(
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
      text: TextSpan(children: _buildSpans(context, resolved)),
    );
  }
}

/// A variant that also parses **bold**, *italic* and `code` markdown,
/// AND makes CJK characters tappable. Used in AI chat bubbles.
class TappableMarkdownHanziText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign textAlign;

  const TappableMarkdownHanziText(
    this.text, {
    super.key,
    this.style,
    this.textAlign = TextAlign.start,
  });

  static final _mdPattern = RegExp(r'\*\*(.+?)\*\*|\*(.+?)\*|`(.+?)`');

  List<InlineSpan> _buildSpans(BuildContext context, TextStyle base) {
    final all = <InlineSpan>[];

    // First split on markdown tokens, then sub-split each segment on CJK
    int last = 0;
    void addCjkSpans(String segment, TextStyle segStyle) {
      int c = 0;
      for (final m in _cjkPattern.allMatches(segment)) {
        if (m.start > c) {
          all.add(TextSpan(text: segment.substring(c, m.start), style: segStyle));
        }
        final char = m.group(0)!;
        all.add(TextSpan(
          text: char,
          style: segStyle.copyWith(
            decoration: TextDecoration.underline,
            decorationColor: Colors.indigo.withValues(alpha: 0.4),
            decorationStyle: TextDecorationStyle.dotted,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () => showQuickLook(context, char),
        ));
        c = m.end;
      }
      if (c < segment.length) {
        all.add(TextSpan(text: segment.substring(c), style: segStyle));
      }
    }

    for (final match in _mdPattern.allMatches(text)) {
      if (match.start > last) {
        addCjkSpans(text.substring(last, match.start), base);
      }
      if (match.group(1) != null) {
        addCjkSpans(match.group(1)!, base.copyWith(fontWeight: FontWeight.bold));
      } else if (match.group(2) != null) {
        addCjkSpans(match.group(2)!, base.copyWith(fontStyle: FontStyle.italic));
      } else if (match.group(3) != null) {
        all.add(TextSpan(
          text: match.group(3),
          style: base.copyWith(
            color: Colors.indigo,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
          ),
        ));
      }
      last = match.end;
    }
    if (last < text.length) {
      addCjkSpans(text.substring(last), base);
    }

    return all.isEmpty ? [TextSpan(text: text, style: base)] : all;
  }

  @override
  Widget build(BuildContext context) {
    final resolved = DefaultTextStyle.of(context).style.merge(style);
    return RichText(
      textAlign: textAlign,
      text: TextSpan(children: _buildSpans(context, resolved)),
    );
  }
}
