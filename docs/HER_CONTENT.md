# One Account's Content — `hanbaobao@love.com`

Everything the app shows to a single account, and nobody else. Four surfaces, one gate,
one content file.

| Surface | Where it appears | What it shows | Content lives in |
|---|---|---|---|
| Word of the day | Home card + the iOS home-screen widget | 汉堡包 `hàn bǎo bāo` — "hanbaobao · hamburger", **every** day, not a rotation | `lib/core/personal/her_content.dart` → `wordOfTheDay` |
| `READ THIS :` | Reading room → **All** (prepended, so it is first) | her letter, in English, readable with no download | `assets/data/her/read_this.json` (text) · `her_content.dart` → `book` (shelf entry) |
| Shadowing | Echo Hall → Shadowing studio | only love sentences, addressed to her — from a local bank, not from the model — plus one mode that is hers alone | `her_content.dart` → `shadowingSentences` · `shadowingDateSentences` |
| Love deck | Flashcards → deck library, and the paths list | one deck, `Love`, with six cards | `her_content.dart` → `deckVocabulary` |

## The gate

`lib/core/personal/her_account.dart` owns the comparison (`HerAccount.isHer(email)`), and
every surface asks *it*. `BirthdayPlaylist.isFor` and `BirthdayPlaylist.recipientEmail`
delegate to it too, so the birthday shelf and the rest of her content cannot disagree
about who she is. Lookalike addresses (`hanbaobao@love.com.evil.example`), other domains,
padded or differently-cased spellings are all handled in that one place, and anything that
is not her account gets the ordinary app: the rotation word, the untouched catalogue, the
ordinary deck library.

## The book — a letter in English

`assets/data/her/read_this.json` holds **the letter, in English, exactly as it was
written**: one sentence per line, in the `chinese` slot — the slot the reader prints as
the text — with `pinyin` and `english` empty, because there is no pinyin for English and
the letter is not a translation of anything. It is the same chapter shape as
`assets/data/books/*.json`, validated by `BookDownloadService`:

```json
[{ "id": "read_this_001", "bookId": "read_this", "chapterIndex": 1,
   "title": "一 · 写给你的信", "titleEn": "Dear BaoBao",
   "sentences": [{ "chinese": "Dear BaoBao,", "pinyin": "", "english": "" }] }]
```

`bookId` must stay `read_this` (it is matched against `HerContent.bookId`), the file is
listed in `pubspec.yaml` under `assets/data/her/`, and `BookDownloadService.bundledBooks`
is what makes it readable offline instead of "not downloaded". To add a chapter, append
another object with `chapterIndex: 2` and bump `totalChapters` in `her_content.dart`.
The shelf entry's `author` is the letter's signature (`Simon`), not the account's name.

**Why the text is in the `chinese` slot.** The reader prints that slot as the sentence —
large, always visible — while the meaning line beneath it is behind the translation toggle
*and* is produced by `TranslatedText`, which machine-translates the sentence into the
app's language. Put the letter in `english` instead and her French app would show blank
lines, or the letter through a translator.

**What a line with no Hanzi does** (`sentenceHasHanzi`,
`lib/features/reading/domain/logic/sentence_script.dart`): it is printed as it is — no
ruby pinyin (the tokenizer pairs *characters* with syllables from a Mandarin dictionary,
which over English leaves one stray syllable above one letter), no meaning line (a
translation of the words already on screen), and no audio (the voices are Mandarin, so
there is nothing for them to read). Both the reader and the audiobook player ask that one
rule, and `test/features/reading/sentence_script_test.dart` pins it.

## The practice mode that is only hers — "Notre histoire"

The studio offers four practice modes to everybody. For her the row has five, and the
first one is hers: `ShadowingMode.ourDates`, carrying
`HerContent.shadowingDateSentences` — the three days, as three sentences, plus the three
words.

| Chinese | his line |
|---|---|
| 我爱你。 | I love you. |
| 我们相遇的那一天是二零二五年十月十六日。 | The day we met is 16 October 2025. |
| 我们发出第一条消息的那一天是二零二五年十月十八日。 | The day we sent the first message is 18 October 2025. |
| 我们在海德堡见面的那一天是二零二六年七月十四日。 | The day we met in Heidelberg is 14.07.26. |

- **The dates are Chinese numerals, not digits.** The studio draws one syllable above each
  *character*; `2025` would pair the ruby with the wrong ones. Written on a card, this is
  also how a date looks in Chinese.
- **Which bank answers a mode is `HerContent.shadowingBankFor`'s decision**, not the
  screen's: free flow, thematic and deck get the love sentences, `ourDates` gets the
  dates, and `customWord` / `customSentence` still go to Gemini — those are her words and
  she asked for them to be translated. The mode arrives as its `toString()`, and
  `test/features/live_translate/shadowing_studio_practice_mode_test.dart` holds a table of
  every mode: a `ShadowingMode` added later without a decision **fails** there instead of
  quietly practising her dates.
- **The chip is hers alone** — built only when `HerAccount.isHer` — and three widget tests
  pump the real screen to say so: hers (it opens, and shows the three dates), another
  account (absent), signed out (absent).
- **The mode's name, its card and its three dates are content**, not chrome:
  `shadowingDateModeLabel` (`'Notre histoire'`), `shadowingDateModeDescription` and
  `shadowingDateLabels`. They live in `her_content.dart` rather than in the fourteen
  `app_*.arb` files, because no other account can open the mode — and her app is the
  French one, so they are written in French. Renaming the mode is renaming one string.
- **Changing a date means two edits** — the sentence (Chinese + pinyin + his English) and
  the label on the card. `her_content_test` compares the two, so a date changed in one
  place and not the other fails the suite rather than showing her two different days.

## Notes for the next change

- **Content, not chrome.** None of these strings are translated; they ship as written,
  like the birthday tag, the drama titles and the discovery queries.
- **The letter is quoted, not edited.** It is his text: `didnt`, `hahhaha`, the curly
  apostrophes and the three flattened line breaks are all part of it, and
  `her_content_test` compares the book against the letter line for line. Change the book
  only when he writes something new — never to tidy it up, and never by adding a Chinese
  or pinyin line beside it.
- **Offline.** Nothing in this bundle is fetched: the sentences, the cards and the book
  are in the binary.
- The deck is seeded on first open of the deck library (`FlashcardController.ensureLoveDeck`),
  idempotently — a card is only written when its id is missing, so review progress is never
  reset by re-opening the library.
- `test/core/personal/her_content_test.dart` pins the content, the gate, the seeding (real
  Hive) and the four surfaces. Its widget tests fake the repositories on purpose: a real
  Hive write started inside a widget test's fake clock never completes and **hangs** the
  test instead of failing it.
