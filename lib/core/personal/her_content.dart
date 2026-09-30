import 'package:hanzi_master/core/personal/her_account.dart';
import 'package:hanzi_master/core/services/widget_service.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';

/// Everything the app shows to [HerAccount.email] and nobody else.
///
/// One file, four surfaces — the word of the day, the book in the reading room, the
/// shadowing sentences and the deck in the flashcards library — because they are one
/// person's content and splitting them across four features is how they drift apart.
///
/// Every string here is **content, not chrome**: not translated, shipped as written.
/// That is the same rule `birthday_playlist.dart` (the birthday tag),
/// `curated_shows.dart` (Chinese drama titles) and `video_category_queries.dart`
/// (discovery terms) follow, and it is why these are constants rather than ARB keys —
/// a machine-translated love letter is not the thing that was written.
///
/// Nothing here is fetched. `deckVocabulary`, `shadowingSentences` and
/// `shadowingDateSentences` are studied offline, and [wordOfTheDay] is hers every single
/// day rather than rotating through `wordOfTheDayVocabulary`, because the word she asked
/// for is a name, and a name does not change with the date.
abstract final class HerContent {
  // ---------------------------------------------------------------------------
  // 1. Word of the day — the home card, and the home-screen widget
  // ---------------------------------------------------------------------------

  /// 汉堡包 *is* "hanbaobao": the word she asked for is the Chinese for hamburger,
  /// which is where the nickname comes from. The definition leads with the nickname
  /// so the card reads as hers rather than as a menu item.
  static const WordOfTheDay wordOfTheDay = WordOfTheDay(
    hanzi: '汉堡包',
    pinyin: 'hàn bǎo bāo',
    definition: 'hanbaobao · hamburger',
    localizedDefinitions: {'french': 'hanbaobao · hamburger'},
  );

  /// The word for [date] for the account behind [email]: hers, or the ordinary
  /// rotation every other account gets from [wordOfTheDayFor].
  ///
  /// This exists so the card, the widget and anything added later resolve the word
  /// through one function — a second call site that forgot the account would show her
  /// the wrong word while the first one showed the right one.
  static WordOfTheDay wordOfTheDayForAccount({
    required String? email,
    required DateTime date,
  }) =>
      HerAccount.isHer(email) ? wordOfTheDay : wordOfTheDayFor(date);

  // ---------------------------------------------------------------------------
  // 2. The book in the reading room
  // ---------------------------------------------------------------------------

  /// The book's identifier. `^[a-z0-9_]+$` — `BookDownloadService` rejects anything
  /// else — and the chapter file's `bookId` fields have to match it exactly.
  static const String bookId = 'read_this';

  /// The title, exactly as asked for, including the space before the colon.
  static const String bookTitle = 'READ THIS :';

  /// Where the text of the book is kept: one bundled chapter file.
  ///
  /// It holds a letter in **plain English**, one sentence per line, in the `chinese`
  /// slot — the slot the reader prints as the text — with `pinyin` and `english` empty,
  /// because there is no pinyin for English and the letter is not a translation of
  /// anything. `docs/HER_CONTENT.md` has the details.
  static const String bookAsset = 'assets/data/her/read_this.json';

  /// The shelf entry for the book. `category` is deliberately not one of the reading
  /// room's filter pills: `READ THIS :` is not a genre, and inventing one would put a
  /// pill in every other account's reading room for a book they cannot open. It is
  /// listed under **All**, and prepended, so it is the first thing on the shelf.
  ///
  /// The author is the letter's signature, not the account's name.
  static const BookModel book = BookModel(
    id: bookId,
    title: bookTitle,
    titleEn: bookTitle,
    author: 'Simon',
    authorEn: 'Simon',
    category: 'For You',
    description: 'A letter for you.',
    descriptionEn: 'A letter for you.',
    dynastyOrEra: '',
    hskLevel: 1,
    totalChapters: 1,
    coverEmoji: '💌',
    tags: <String>['for you'],
  );

  /// Every account that can open [bookAsset] gets the book on the shelf; every other
  /// account's catalog comes back untouched.
  static List<BookModel> withBookFor({
    required String? email,
    required List<BookModel> catalog,
  }) {
    if (!HerAccount.isHer(email)) return catalog;
    if (catalog.any((BookModel book) => book.id == bookId)) return catalog;
    return <BookModel>[book, ...catalog];
  }

  // ---------------------------------------------------------------------------
  // 3. Shadowing — every sentence is a love sentence
  // ---------------------------------------------------------------------------

  /// The shadowing studio's phrase bank for her, in the exact shape
  /// `GeminiService.generateShadowingPhrase` returns (`hanzi` / `pinyin` /
  /// `english`), so it can stand in for the model without the studio knowing.
  ///
  /// It stands in for a reason: the studio asks Gemini for a phrase in a *theme*, and
  /// a theme is a hint, not a guarantee. "Only sentences related to love" is a
  /// guarantee, so the sentences are written down here instead — which also means they
  /// arrive instantly and work with no key and no connection.
  static const List<Map<String, String>> shadowingSentences =
      <Map<String, String>>[
    <String, String>{
      'hanzi': '我爱你，汉堡包。',
      'pinyin': 'wǒ ài nǐ, hàn bǎo bāo.',
      'english': 'I love you, hanbaobao.',
    },
    <String, String>{
      'hanzi': '你是我最爱的人。',
      'pinyin': 'nǐ shì wǒ zuì ài de rén.',
      'english': 'You are the person I love most.',
    },
    <String, String>{
      'hanzi': '我想和你在一起。',
      'pinyin': 'wǒ xiǎng hé nǐ zài yì qǐ.',
      'english': 'I want to be with you.',
    },
    <String, String>{
      'hanzi': '你的笑容让我心跳。',
      'pinyin': 'nǐ de xiào róng ràng wǒ xīn tiào.',
      'english': 'Your smile makes my heart beat.',
    },
    <String, String>{
      'hanzi': '蓝色柠檬水甜甜的，像你一样。',
      'pinyin': 'lán sè níng méng shuǐ tián tián de, xiàng nǐ yí yàng.',
      'english': 'Blue lemonade is sweet, just like you.',
    },
    <String, String>{
      'hanzi': '我每天都在想你。',
      'pinyin': 'wǒ měi tiān dōu zài xiǎng nǐ.',
      'english': 'I think about you every day.',
    },
    <String, String>{
      'hanzi': '谢谢你走进我的生活。',
      'pinyin': 'xiè xie nǐ zǒu jìn wǒ de shēng huó.',
      'english': 'Thank you for walking into my life.',
    },
    <String, String>{
      'hanzi': '你让我的世界变得温暖。',
      'pinyin': 'nǐ ràng wǒ de shì jiè biàn de wēn nuǎn.',
      'english': 'You make my world warm.',
    },
    <String, String>{
      'hanzi': '宝宝，你是我的宝贝。',
      'pinyin': 'bǎo bao, nǐ shì wǒ de bǎo bèi.',
      'english': 'Baobao, you are my treasure.',
    },
    <String, String>{
      'hanzi': '我会一直爱你。',
      'pinyin': 'wǒ huì yì zhí ài nǐ.',
      'english': 'I will always love you.',
    },
  ];

  // ---------------------------------------------------------------------------
  // 3b. Shadowing — the mode that is only hers: the three days that are theirs
  // ---------------------------------------------------------------------------

  /// The practice mode that carries [shadowingDateSentences].
  ///
  /// The studio carries its mode around as `toString()` — `_fetchNextPhrase` already
  /// does, and `GeminiService.generateShadowingPhrase` takes the same form — so a mode
  /// maps to a bank by string. The pairing is pinned by
  /// `test/features/live_translate/shadowing_studio_practice_mode_test.dart`, which
  /// switches over `ShadowingMode`: a mode added later without a decision fails there
  /// instead of quietly practising her sentences.
  static const String shadowingDateMode = 'ShadowingMode.ourDates';

  /// What the mode is called where she chooses it.
  ///
  /// **Content, not chrome**, like everything else in this file: it is hers, it is only
  /// ever shown to her, and her app is the French one — so it is written here rather
  /// than in the fourteen `app_*.arb` files, where a mode no other account can open
  /// would be a string no other account should translate. Renaming the mode is renaming
  /// this one string.
  static const String shadowingDateModeLabel = 'Notre histoire';

  /// What the mode is for, on the card under the mode row.
  static const String shadowingDateModeDescription =
      'Les trois jours qui sont à nous, en trois phrases — et les dates qu’elles gardent.';

  /// The three days, as three sentences.
  ///
  /// The same shape as [shadowingSentences] (`hanzi` / `pinyin` / `english`), and for
  /// the same reason the bank exists at all: a date is a fact, not a theme, and no
  /// prompt can promise that 16 October 2025 comes back out of a model unaltered. The
  /// dates are written in Chinese numerals (二零二五年十月十六日) rather than in digits,
  /// so that every character is a Hanzi: the studio draws one syllable above each
  /// *character*, and digits would pair the ruby with the wrong ones.
  ///
  /// The English line is his, down to the `14.07.26`.
  static const List<Map<String, String>> shadowingDateSentences =
      <Map<String, String>>[
    <String, String>{
      'hanzi': '我爱你。',
      'pinyin': 'wǒ ài nǐ.',
      'english': 'I love you.',
    },
    <String, String>{
      'hanzi': '我们相遇的那一天是二零二五年十月十六日。',
      'pinyin':
          'wǒ men xiāng yù de nà yì tiān shì èr líng èr wǔ nián shí yuè shí liù rì.',
      'english': 'The day we met is 16 October 2025.',
    },
    <String, String>{
      'hanzi': '我们发出第一条消息的那一天是二零二五年十月十八日。',
      'pinyin':
          'wǒ men fā chū dì yī tiáo xiāo xi de nà yì tiān shì èr líng èr wǔ nián shí yuè shí bā rì.',
      'english': 'The day we sent the first message is 18 October 2025.',
    },
    <String, String>{
      'hanzi': '我们在海德堡见面的那一天是二零二六年七月十四日。',
      'pinyin':
          'wǒ men zài hǎi dé bǎo jiàn miàn de nà yì tiān shì èr líng èr liù nián qī yuè shí sì rì.',
      'english': 'The day we met in Heidelberg is 14.07.26.',
    },
  ];

  /// The three days as the mode's own card lists them: the same three facts as
  /// [shadowingDateSentences], in the short numeric form he writes dates in (the
  /// letter's `14.07.26`), so the card and the sentences cannot disagree about a date.
  static const List<String> shadowingDateLabels =
      <String>['16.10.25', '18.10.25', '14.07.26'];

  /// The bank [mode] practises, or `null` when the phrase is the model's to write.
  ///
  /// Every mode except the two where **she** brings the words: a free-flow line or a
  /// themed one is chosen from [shadowingSentences], her three days come from
  /// [shadowingDateSentences], and `customWord` / `customSentence` are her own input and
  /// get their pinyin and translation from the model exactly as they always did. The
  /// mode arrives as its `toString()` — the same form the studio already hands to
  /// `GeminiService.generateShadowingPhrase`.
  static List<Map<String, String>>? shadowingBankFor(String mode) {
    if (mode == 'ShadowingMode.customWord' ||
        mode == 'ShadowingMode.customSentence') {
      return null;
    }
    if (mode == shadowingDateMode) return shadowingDateSentences;
    return shadowingSentences;
  }

  /// True when a mode should practise a bank from this file rather than ask the model.
  static bool shadowingBankAppliesTo(String mode) =>
      shadowingBankFor(mode) != null;

  /// The sentence after [history]: the first one she has not heard yet, and the first
  /// again once the whole bank has been round — so the practice never runs out and
  /// never repeats the line that is already on screen. [history] is what the studio
  /// already keeps (and passes to the model as `previousPhrases`).
  ///
  /// [bank] is what [shadowingBankFor] resolved, and defaults to [shadowingSentences].
  static Map<String, String> shadowingSentenceAfter(
    List<String> history, {
    List<Map<String, String>>? bank,
  }) {
    final List<Map<String, String>> sentences = bank ?? shadowingSentences;
    final Set<String> heard = history.toSet();
    for (final Map<String, String> sentence in sentences) {
      if (!heard.contains(sentence['hanzi'])) return sentence;
    }
    return sentences.first;
  }

  // ---------------------------------------------------------------------------
  // 4. The deck in the flashcards library
  // ---------------------------------------------------------------------------

  static const String deckId = 'love';
  static const String deckName = 'Love';
  static const String deckDescription = 'The words that are yours.';

  /// The six cards, in the order they were asked for. `hanzi`, `pinyin` and
  /// `definition` are the keys `ThematicDecksData` uses, so the installer that seeds
  /// this deck is the installer that seeds the curated ones.
  ///
  /// 汉堡包 is "hanbaobao" the same way it is the word of the day — the nickname is the
  /// hamburger — and 汉 is the *Han* it starts with. 蓝色柠檬水 ("blue lemonade") is a
  /// literal translation of a name rather than a fixed phrase, which is why the card
  /// says what it is rather than pretending to be an idiom.
  static const List<Map<String, String>> deckVocabulary = <Map<String, String>>[
    <String, String>{
      'hanzi': '汉堡包',
      'pinyin': 'hàn bǎo bāo',
      'definition': 'hanbaobao · hamburger',
    },
    <String, String>{
      'hanzi': '蓝色柠檬水',
      'pinyin': 'lán sè níng méng shuǐ',
      'definition': 'blue lemonade',
    },
    <String, String>{
      'hanzi': '爱',
      'pinyin': 'ài',
      'definition': 'love',
    },
    <String, String>{
      'hanzi': '汉',
      'pinyin': 'hàn',
      'definition': 'Han · Chinese',
    },
    <String, String>{
      'hanzi': '宝宝',
      'pinyin': 'bǎo bao',
      'definition': 'baobao · baby, darling',
    },
    <String, String>{
      'hanzi': '我爱你',
      'pinyin': 'wǒ ài nǐ',
      'definition': 'wo ai ni · I love you',
    },
  ];
}
