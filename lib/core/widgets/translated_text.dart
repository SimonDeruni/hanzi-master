import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/local_translation_service.dart';

class TranslatedText extends ConsumerStatefulWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;

  const TranslatedText(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.overflow,
  });

  @override
  ConsumerState<TranslatedText> createState() => _TranslatedTextState();
}

class _TranslatedTextState extends ConsumerState<TranslatedText> {
  String? _translatedText;

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
      _translate();
    }
  }

  Future<void> _translate() async {
    if (widget.text.isEmpty) return;
    final translator = ref.read(localTranslationServiceProvider);
    final result = await translator.translate(widget.text);
    if (mounted) {
      setState(() {
        _translatedText = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show original text if translation hasn't loaded yet
    final displayText = _translatedText ?? widget.text;

    return Text(
      displayText,
      style: widget.style,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
    );
  }
}
