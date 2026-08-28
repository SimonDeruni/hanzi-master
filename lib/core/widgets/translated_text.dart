import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/local_translation_service.dart';

class TranslatedText extends ConsumerStatefulWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool showOriginalOnLoading;
  final String? placeholder;

  const TranslatedText(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
    this.showOriginalOnLoading = false,
    this.placeholder,
  });

  @override
  ConsumerState<TranslatedText> createState() => _TranslatedTextState();
}

class _TranslatedTextState extends ConsumerState<TranslatedText> {
  String? _translatedText;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _translate();
  }

  @override
  void didUpdateWidget(TranslatedText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _translatedText = null;
      _isLoading = true;
      _translate();
    }
  }

  Future<void> _translate() async {
    if (widget.text.isEmpty) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }
    final translator = ref.read(localTranslationServiceProvider);
    final result = await translator.translate(widget.text);
    if (mounted) {
      setState(() {
        _translatedText = result;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading && _translatedText == null) {
      if (widget.showOriginalOnLoading) {
        return Text(
          widget.text,
          style: widget.style,
          maxLines: widget.maxLines,
          overflow: widget.overflow,
        );
      }
      return Text(
        widget.placeholder ?? '...',
        style: widget.style?.copyWith(
          color: widget.style?.color?.withValues(alpha: 0.45) ?? Colors.grey.withValues(alpha: 0.5),
        ),
        maxLines: widget.maxLines,
        overflow: widget.overflow,
      );
    }

    final displayText = _translatedText ?? (widget.showOriginalOnLoading ? widget.text : '');

    return Text(
      displayText,
      style: widget.style,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
    );
  }
}
