import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hanzi_master/core/layout/zen_layout.dart';
import 'package:hanzi_master/shared/widgets/quick_look_sheet.dart';

/// CJK Unified Ideographs: basic block + Ext-A + Compatibility Ideographs.
/// Covers the vast majority of characters used in modern Chinese.
final _cjkPattern = RegExp(
  r'[\u4e00-\u9fff' // CJK Unified Ideographs (basic — most common)
  r'\u3400-\u4dbf' // CJK Extension A
  r'\uf900-\ufaff' // CJK Compatibility Ideographs
  r'\u3005' // 々 (iteration mark)
  r']',
  unicode: true,
);

// ---------------------------------------------------------------------------
// StatefulWidget base — manages TapGestureRecognizer lifecycle correctly.
// Creating recognizers in a StatelessWidget causes gesture arena corruption
// because they are never disposed when the widget rebuilds.
// ---------------------------------------------------------------------------

abstract class _TappableBase extends StatefulWidget {
  final QuickLookPresentation quickLookPresentation;

  /// On a pointer device — an iPad with a trackpad or Magic Keyboard, or a mouse
  /// — hovering a character shows a non-modal **peek**: the same body the tap
  /// opens, without the sheet or its barrier (see [showQuickLookPeek]). Dense
  /// prose can pass `false` to keep tapping as the only way in.
  final bool hoverPeek;

  const _TappableBase({
    super.key,
    this.quickLookPresentation = QuickLookPresentation.bottomSheet,
    this.hoverPeek = true,
  });
}

abstract class _TappableBaseState<T extends _TappableBase> extends State<T> {
  final List<TapGestureRecognizer> _recognizers = [];
  String? _selectedCharKey;

  void _disposeRecognizers() {
    for (final r in _recognizers) {
      r.dispose();
    }
    _recognizers.clear();
  }

  TapGestureRecognizer _makeRecognizer(String char, String charKey) {
    Offset? anchorPosition;
    final r = TapGestureRecognizer()
      ..onTapDown = (details) {
        anchorPosition = details.globalPosition;
      }
      ..onTap = () async {
        setState(() {
          _selectedCharKey = charKey;
          _rebuildSpans();
        });
        await showQuickLook(
          context,
          char,
          presentation: widget.quickLookPresentation,
          anchorPosition: anchorPosition,
          onDismiss: () {
            if (mounted) {
              setState(() {
                if (_selectedCharKey == charKey) {
                  _selectedCharKey = null;
                  _rebuildSpans();
                }
              });
            }
          },
        );
        if (mounted) {
          setState(() {
            if (_selectedCharKey == charKey) {
              _selectedCharKey = null;
              _rebuildSpans();
            }
          });
        }
      };
    _recognizers.add(r);
    return r;
  }

  void _rebuildSpans();

  // -------------------------------------------------------------------------
  // Hover peek (pointer devices)
  // -------------------------------------------------------------------------

  final GlobalKey _hoverKey = GlobalKey();
  QuickLookPeekHandle? _peek;
  Timer? _peekIntent;
  Timer? _peekGrace;
  String? _peekedChar;

  /// The text this widget actually renders, used to map a hover position to a
  /// character. `null` disables the peek for a subclass whose rendered text
  /// differs from its source — the markdown bubble pre-processes its markers, so
  /// paragraph offsets would point at the wrong character.
  @protected
  String? get hoverSourceText => null;

  bool get _hoverPeekAvailable =>
      widget.hoverPeek &&
      hoverSourceText != null &&
      ZenWindow.of(context).isAtLeastMedium;

  void _dismissPeek() {
    _peek?.dismiss();
    _peek = null;
    _peekedChar = null;
  }

  void _cancelPeekTimers() {
    _peekIntent?.cancel();
    _peekGrace?.cancel();
    _peekIntent = null;
    _peekGrace = null;
  }

  void _onHoverPeek(PointerHoverEvent event) {
    if (!_hoverPeekAvailable) return;
    if (event.kind != PointerDeviceKind.mouse &&
        event.kind != PointerDeviceKind.stylus &&
        event.kind != PointerDeviceKind.invertedStylus &&
        event.kind != PointerDeviceKind.trackpad) {
      return;
    }
    final String text = hoverSourceText!;
    final RenderObject? render = _hoverKey.currentContext?.findRenderObject();
    if (render is! RenderParagraph) return;
    final TextPosition position =
        render.getPositionForOffset(render.globalToLocal(event.position));
    if (position.offset < 0 || position.offset >= text.length) return;
    final String char = text[position.offset];
    if (!_cjkPattern.hasMatch(char)) return;

    // Already showing this character: keep it, and cancel the pending leave.
    _peekGrace?.cancel();
    if (_peekedChar == char && _peek != null) return;

    // Hover *intent*: a pointer crossing the text must not flash a card per
    // character it passes over.
    _peekIntent?.cancel();
    _peekIntent = Timer(const Duration(milliseconds: 320), () {
      if (!mounted) return;
      _dismissPeek();
      _peek = showQuickLookPeek(context, char, anchorPosition: event.position);
      if (_peek != null) _peekedChar = char;
    });
  }

  void _onHoverPeekExit(PointerEvent event) {
    _peekIntent?.cancel();
    if (_peek == null) return;
    // Grace period, so crossing a character boundary or the padding between two
    // lines does not dismiss and re-show the card.
    _peekGrace?.cancel();
    _peekGrace = Timer(const Duration(milliseconds: 520), () {
      if (mounted) _dismissPeek();
    });
  }

  /// Wraps a rendered paragraph so it can be peeked. The key is what makes the
  /// hit-test exact: the paragraph itself maps the pointer to a text offset.
  @protected
  Widget withHoverPeek(Widget child) => MouseRegion(
        onHover: _onHoverPeek,
        onExit: _onHoverPeekExit,
        child: KeyedSubtree(key: _hoverKey, child: child),
      );

  @override
  void dispose() {
    _cancelPeekTimers();
    _dismissPeek();
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
    super.quickLookPresentation,
    super.hoverPeek,
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

  @override
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
      final charKey = '${match.start}_$char';
      final isSelected = _selectedCharKey == charKey;
      spans.add(TextSpan(
        text: char,
        style: resolved.copyWith(
          backgroundColor: isSelected
              ? const Color(0xFF4F46E5).withValues(alpha: 0.22)
              : null,
          color: isSelected ? const Color(0xFF4F46E5) : null,
          decoration: TextDecoration.underline,
          decorationColor: isSelected
              ? const Color(0xFF4F46E5)
              : Colors.indigo.withValues(alpha: 0.35),
          decorationStyle: TextDecorationStyle.dotted,
        ),
        recognizer: _makeRecognizer(char, charKey),
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

  /// The rendered text *is* the source text here, so paragraph offsets map 1:1
  /// onto characters and the hover peek can hit-test exactly.
  @override
  String? get hoverSourceText => widget.text;

  @override
  Widget build(BuildContext context) {
    final spans = _spans ?? [];
    return withHoverPeek(
      RichText(
        textAlign: widget.textAlign,
        maxLines: widget.maxLines,
        overflow: widget.overflow ?? TextOverflow.clip,
        text: TextSpan(children: spans),
      ),
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
  final int? maxLines;
  final TextOverflow? overflow;

  const TappableMarkdownHanziText(
    this.text, {
    super.key,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    super.quickLookPresentation,
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
    r'\*\*(.+?)\*\*' // **bold**
    r'|(?<!\*)\*(?!\*)(.+?)(?<!\*)\*(?!\*)' // *italic* (not **)
    r'|`(.+?)`', // `code`
    dotAll: false,
  );

  /// Pre-processes raw AI text before markdown parsing:
  /// - Converts line-start `* ` or `- ` bullets to `• `
  /// - Strips orphan single asterisks left at end of words (e.g. 我们*)
  static String _preprocessText(String text) {
    // Strip leading markdown headers (#, ##, ###) so they never render as literal hashes.
    final noHeaders =
        text.replaceAll(RegExp(r'^[ \t]*#{1,6}\s*', multiLine: true), '');
    // Convert line-start bullet markers to Unicode bullet.
    // Matches ^ (start of line) optionally followed by spaces, then * or -, then a space.
    return noHeaders.replaceAllMapped(
      RegExp(r'^[ \t]*[\*\-]( |$)', multiLine: true),
      (m) => '• ',
    );
  }

  List<InlineSpan>? _spans;
  int _charSeq = 0;

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

  @override
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
      final charKey = '${_charSeq++}_$char';
      final isSelected = _selectedCharKey == charKey;
      target.add(TextSpan(
        text: char,
        style: segStyle.copyWith(
          backgroundColor: isSelected
              ? const Color(0xFF4F46E5).withValues(alpha: 0.22)
              : null,
          color: isSelected ? const Color(0xFF4F46E5) : null,
          decoration: TextDecoration.underline,
          decorationColor: isSelected
              ? const Color(0xFF4F46E5)
              : Colors.indigo.withValues(alpha: 0.35),
          decorationStyle: TextDecorationStyle.dotted,
        ),
        recognizer: _makeRecognizer(char, charKey),
      ));
      c = m.end;
    }
    if (c < segment.length) {
      target.add(TextSpan(text: segment.substring(c), style: segStyle));
    }
  }

  List<InlineSpan> _buildSpans(TextStyle base) {
    _charSeq = 0;
    final all = <InlineSpan>[];
    final processedText = _preprocessText(widget.text);
    int last = 0;

    for (final match in _mdPattern.allMatches(processedText)) {
      if (match.start > last) {
        _addCjkSpans(all, processedText.substring(last, match.start), base);
      }
      if (match.group(1) != null) {
        _addCjkSpans(all, match.group(1)!,
            base.copyWith(fontWeight: FontWeight.bold, color: Colors.indigo));
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
      maxLines: widget.maxLines,
      overflow: widget.overflow ?? TextOverflow.clip,
      text: TextSpan(children: spans),
    );
  }
}
