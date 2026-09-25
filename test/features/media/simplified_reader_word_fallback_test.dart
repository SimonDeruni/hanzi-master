import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guards the rendering contract of the simplified-article reader.
///
/// The reader composes the article's prose out of `sentence.words` (each word is
/// an inline `WidgetSpan` so the paragraph wraps like real prose while every word
/// stays tappable). A sentence that arrives without a word breakdown - a repaired
/// response, or one whose Chinese field was named differently - would therefore
/// render as a *blank paragraph*, which is how a "successful" simplification can
/// still look empty to the reader.
void main() {
  late String source;

  setUpAll(() {
    source = File(
      'lib/features/media/presentation/screens/simplified_article_reader_screen.dart',
    ).readAsStringSync();
  });

  test('a sentence without a word breakdown is still rendered', () {
    final start = source.indexOf('final spans = <InlineSpan>[');
    expect(start, isNot(-1), reason: 'The paragraph builder must build spans');

    expect(
      source.substring(start, start + 400),
      contains('if (sentence.words.isEmpty) TextSpan(text: sentence.chinese)'),
      reason: 'Guard the fallback: without it the paragraph is empty',
    );
  });
}
