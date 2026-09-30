import 'package:flutter/material.dart';
import 'package:hanzi_master/core/widgets/translated_text.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/domain/logic/sentence_script.dart';

/// The line under a sentence: what it means, in the reader's own language.
///
/// For a Chinese sentence this is [BookSentence.chinese] *translated*, with the
/// chapter's own [BookSentence.english] riding along as `englishFallback` — which
/// `TranslatedText` prints verbatim when English **is** the target and shows while a
/// translation is in flight.
///
/// For a sentence with no Hanzi in it ([sentenceHasHanzi]) there is nothing to translate:
/// that sentence *is* the text, and the reader is already showing it. A meaning line
/// under it would be a translation of the words on screen — which for the one account's
/// private book, an English letter, meant a French reader being shown the letter through
/// a translator instead of as written. Nothing is rendered at all.
///
/// The book reader and the audiobook player both go through this widget, so the two
/// cannot disagree about what a sentence means.
class SentenceMeaningLine extends StatelessWidget {
  const SentenceMeaningLine({
    super.key,
    required this.sentence,
    this.style,
  });

  final BookSentence sentence;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    if (!sentenceHasHanzi(sentence.chinese)) return const SizedBox.shrink();
    return TranslatedText(
      sentence.chinese,
      englishFallback: sentence.english.isEmpty ? null : sentence.english,
      style: style,
    );
  }
}
