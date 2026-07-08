import 'package:flutter/material.dart';
import 'package:hanzi_master/core/services/amap_service.dart';

typedef OnLocationTap = void Function(PlaceMatch match);

class LocationAwareText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextStyle? locationStyle;
  final TextAlign? textAlign;
  final OnLocationTap? onLocationTap;

  const LocationAwareText(
    this.text, {
    super.key,
    this.style,
    this.locationStyle,
    this.textAlign,
    this.onLocationTap,
  });

  @override
  Widget build(BuildContext context) {
    final db = AmapService();
    if (!db.isLoaded || text.isEmpty) {
      return Text(text, style: style, textAlign: textAlign);
    }

    final matches = db.scan(text);
    if (matches.isEmpty) {
      return Text(text, style: style, textAlign: textAlign);
    }

    final baseStyle = style ?? DefaultTextStyle.of(context).style;
    final locStyle = baseStyle.merge(locationStyle);

    final spans = <InlineSpan>[];
    int cursor = 0;

    for (final match in matches) {
      // Text before this match
      if (match.startIndex > cursor) {
        spans.add(TextSpan(
          text: text.substring(cursor, match.startIndex),
          style: baseStyle,
        ));
      }

      // Tappable location span
      spans.add(WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: GestureDetector(
          onTap: () {
            if (onLocationTap != null) {
              onLocationTap!(match);
            }
          },
          child: Text(
            match.matchedText,
            style: locStyle,
          ),
        ),
      ));

      cursor = match.endIndex;
    }

    // Remaining text after last match
    if (cursor < text.length) {
      spans.add(TextSpan(
        text: text.substring(cursor),
        style: baseStyle,
      ));
    }

    return Text.rich(
      TextSpan(children: spans),
      textAlign: textAlign,
    );
  }
}