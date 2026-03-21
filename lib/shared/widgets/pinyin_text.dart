import 'package:flutter/material.dart';
import '../../core/utils/pinyin_utils.dart';

class PinyinText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int? maxLines;

  const PinyinText({
    super.key,
    required this.text,
    this.style,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.clip,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) return const SizedBox.shrink();

    final tokens = PinyinUtils.tokenize(text);
    final baseStyle = style ?? DefaultTextStyle.of(context).style;

    return RichText(
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      text: TextSpan(
        children: tokens.map((token) {
          final int tone = token['tone'];
          final String content = token['text'];
          
          return TextSpan(
            text: content,
            style: baseStyle.copyWith(
              color: PinyinUtils.toneColors[tone],
              fontWeight: tone != 5 ? FontWeight.bold : baseStyle.fontWeight,
            ),
          );
        }).toList(),
      ),
    );
  }
}
