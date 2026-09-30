/// Whether [text] contains anything to read *as Chinese*.
///
/// The reader turns a sentence into **ruby**: it asks a Mandarin dictionary for one
/// syllable per character and draws each syllable above the character it belongs to.
/// Run over a sentence with no Hanzi in it, that is nonsense — the dictionary has fewer
/// syllables than the sentence has characters, so one Latin letter ends up carrying a
/// stray syllable and the rest carry nothing.
///
/// A line with no Hanzi is therefore printed **as it is**: no ruby, no pinyin row, and
/// nothing to translate either (a translation of it would be a translation of the text
/// the reader is already reading — see `SentenceMeaningLine`).
///
/// This is how the one account's private book ships: an English letter, one sentence per
/// line, inside a reader built for Chinese.
bool sentenceHasHanzi(String text) =>
    RegExp(r'[\u3400-\u4dbf\u4e00-\u9fff]').hasMatch(text);
