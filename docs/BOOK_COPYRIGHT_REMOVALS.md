# Book Copyright Removals — 2026-09-27

**31 books were removed from the Grand Library on 2026-09-27 because their bundled
files carry demonstrable copyright problems.** The library went from 86 titles to 55.

This document is the record of what was removed and why, and — just as importantly —
what was **not** removed and why. It is written to be handed to a lawyer.

> This is an engineering audit by someone who is not a lawyer. Nothing here is legal
> advice. The removals are based on evidence *inside the files themselves*, which is a
> deliberately conservative test: only what a file proves about itself.

## The rule that was applied

**Remove only what the file itself proves.** A book was removed only when its own text
showed one of the four conditions below. Books that merely *might* be problematic were
left in place and are listed in "Not removed" — hiding them would have been worse than
leaving them visible for a decision.

Mechanically this was done by `scratch/remove_copyrighted_books.py`, which is
re-runnable and prints a dry run by default.

---

## 1. `modern_cn` — modern Chinese works, still in copyright (7 books)

Not translations, so there is no public-domain original to fall back on. Under
著作权法 copyright runs for the author's life **+ 50 years**, counting from death.

| Book | Author | Died | In copyright until | Its own opening line |
|---|---|---|---|---|
| `border_town` | 沈从文 | 1988 | 2038 | 这官路将近湘西边境到了一个地方名为"茶峒"的小山城时… |
| `fortress_besieged` | 钱钟书 | 1998 | 2048 | 围城前言 / 重印前记 |
| `the_family_bajin` | 巴金 | 2005 | 2055 | 风刮得很紧，雪片像扯破了的棉絮一样在空中飞舞 |
| `spring_bajin` | 巴金 | 2005 | 2055 | 春1 "二小姐，我们太太请你去打牌" |
| `autumn_bajin` | 巴金 | 2005 | 2055 | 一个月以前省城附近有过几天混战。 |
| `love_fallen_city` | 张爱玲 | 1995 | 2045 | 胡琴咿咿哑哑拉着，在万盏灯的夜晚 |
| `golden_cangue` | 张爱玲 | 1995 | 2045 | 三十年前的上海，一个有月亮的晚上…… |

Each was confirmed by matching the file's text against the known work, not by trusting
the filename.

## 2. `pirated` — the file states where it came from (4 books)

| Book | Evidence in the file |
|---|---|
| `the_three_musketeers` | `声明：本书由零五电子书(txt.02405.com)网友分享，仅供预览，请在下载后的24小时内删除，版权归原作者和出版社所有` — a piracy site's own notice, naming itself and stating copyright belongs to the publisher |
| `the_great_gatsby` | `□ 版权所有——菲茨杰拉德` — a copyright notice, left in |
| `jane_eyre` | `一凡OCR` — the scan credit of whoever OCR'd the edition |
| `romance_sui_tang` | Project Gutenberg boilerplate for **a different, unrelated book** (*The Great K. & A. Robbery*, Paul Leicester Ford) plus Oscar Wilde. The content does not match the title at all |

Separately: the CHANGELOG records that **28 books previously "lost their watermarks"**.
Removing a copyright notice is a distinct problem from infringement itself — in the US
it is actionable independently under DMCA §1202, and comparable provisions exist
elsewhere. Any book that ever had a watermark stripped should be treated as
unverifiable rather than as fine because the notice is now gone.

## 3. `edition` — a named, in-copyright commercial translation (16 books)

A translation is a **new, separately-owned work**. The original's copyright status is
irrelevant to it: whoever translated it owns the translation for their own life + 50
years. These files carry the translator's or publisher's own front matter — a
**译本序 / 译序 / 译者前言 / 作品赏析 / 内容提要** — which proves they were copied from
a specific, recent, commercially published edition rather than an old one.

| Book | Front matter proving the edition |
|---|---|
| `madame_bovary` | `译本序　施康强` — a named modern translator, who in the same preface cites 李健吾's translation (d. 1982, also in copyright) |
| `the_magic_mountain` | `译者前言` |
| `steppenwolf_hesse` | `译本序` |
| `don_quixote` | `译本序言` |
| `eugenie_grandet` | `译序` |
| `anna_karenina` | `前言` — a critical/biographical preface (and the title reads 卡列尼娜 while the body reads 卡列宁娜: two editions mixed) |
| `boule_de_suif` | `莫泊桑中短篇小说选前言` |
| `crime_and_punishment` | `作品赏析` — a critical essay |
| `the_old_man_and_sea` | opens with a critical essay, `《老人与海》：海明威无意识欲望的表征` |
| `ninety_three_hugo` | `《九三年》序` |
| `hunchback_notre_dame` | `前言` (editorial) beside Hugo's own `作者原序` |
| `les_miserables` | `悲惨世界序` |
| `fathers_and_sons` | a biographical/critical introduction |
| `black_cat_poe` | a critical introduction quoting Shaw |
| `wuthering_heights` | `内容提要` — the publisher's blurb |
| `teahouse_laoshe` | `老舍文集（第十一卷）` — a specific published collection |

`teahouse_laoshe` is a special case worth noting: 老舍 died 1966, so the underlying
Work is **public domain in China since 2017**. It was removed because the file is copied
from a named published collection, whose editorial apparatus is separately protected —
not because of Lao She.

## 4. `broken` — the content is not the book it claims to be (1 book)

| Book | Problem |
|---|---|
| `macbeth_shakespeare` | A file named Macbeth containing **Titus Andronicus**. Neither `麦克白` nor `麦克佩斯` appears anywhere in it |

## Also removed, as a consequence

- **Covers** for every removed book (`assets/images/books/<id>.jpg`), plus one orphan,
  `the_black_cat.jpg`, which was the cover of `black_cat_poe` under a different name.
- **Catalog entries** — `grand_library_catalog.json`, 86 → 58.
- **Chapter titles** — 1,904 ids per locale across `chapter_titles_by_id_*.json` ×14.
- **Localised titles and synopses** — `book_titles_*.json` and `books_*.json` ×13.
- **15 orphaned author biographies** per locale, because
  `bundled_book_detail_localization_test.dart` requires the biography key set to match
  the catalog's authors **exactly**, not merely to contain them. 62 authors → 44.

---

## 5. Found by the second pass — auditing every book individually

Sections 1–4 came from reading the first line of every file. A per-book pass
(`scratch/audit_book_provenance.py`, which reports front matter, translator and
publisher names, piracy and OCR markers, and untranslated source text) found **three
more** — and, just as usefully, **cleared four that a keyword scan had wrongly
flagged**.

| Book | Verdict | Evidence |
|---|---|---|
| `walden_thoreau` | **removed** | opens `译本序 - 1` … `译本序 - 5`, and the preface names its own edition: `由译文出版社出第二版的` (Shanghai, 1982, second edition) and `译文出版社在第二版的编审过程中，对译文进行了一次全面的校订工作` |
| `the_decameron` | **removed** | carries a `译后记`, and states `每篇故事的头花，采自俄译本《十日谈》(国家文学艺术出版社，1955)` — the illustrations came from a named 1955 Soviet edition |
| `picture_dorian_gray` | **removed** | 1,097 of its 1,906 `chinese` sentences are **English**. It is an English edition of the novel, not a Chinese text |

**Cleared — keywords that looked damning and were not:**

| Book | Why it looked bad | Why it is fine |
|---|---|---|
| `faust_goethe` | matched `下载` ("download") | the line is `我卸下载我的云辇` — 卸下 + 载, "unloaded and carried". Not a download |
| `letter_unknown_woman` | matched `印刷` (printing) | ordinary prose: `报纸和几份印刷品` |
| `nineteen_eighty_four` | matched `印刷` | `印刷车间`, `印刷术的发明` — the plot, not a colophon |
| `sherlock_holmes` | matched `印刷` and `校对` | `印刷人是谁？`, `校对完` — printing is a plot point in a detective story |
| `war_and_peace` | 36 Latin-heavy sentences | 1% of the file, and they are Tolstoy's own **French** dialogue, normal in a translation. Contrast `picture_dorian_gray` at 58% |
| `sense_and_sensibility`, `call_to_arms_luxun`, `dawn_blossoms_luxun`, `old_tales_retold` | scraping artefacts (`&nbsp;`, literal ` ``` `) | the works are public domain; the artefacts are a quality problem, not a rights one |

**Flagged, not removed — the base text is free but the file shows a modern editor's hand:**

- **`in_search_of_sacred`** carries `编者按：原缺` and `编者按：中平当为中元` with `□□□□□`
  lacuna marks. Those are a *modern editor's* textual notes, so a specific scholarly
  edition is being shipped. The underlying 《搜神记》 is Eastern Jin and free, so the
  exposure is the annotation rather than the text. The filename is also simply wrong.
- **`animal_farm`** opens `《》目录` — an empty title marker where a series or site name
  was stripped. That is one of the "28 books that lost their watermarks", so its
  provenance is **unverifiable rather than clean**.
- **`rickshaw_boy`** contains 老舍's own note
  `此书原由文化生活出版社印行，今改由晨光出版公司出版`, which places it in a specific
  published edition. 老舍 (d. 1966) is public domain in China since 2017, so the *work*
  is free — the *edition* is the open question.

## NOT removed — and why this matters more than the list above

**33 of the 55 remaining books are Chinese translations of foreign classics.** They
carry the *same legal exposure* as the 17 removed in §3 and §5 — a translation is a
separate copyright owned by its translator — but they contain **no front matter proving
which edition they are**. They were left in place because removing them is a product
decision (replace vs delete) and because this script's rule is to act only on proof.

Treat these 33 as **unverified, not as cleared**:

```
animal_farm              brothers_karamazov       call_of_the_wild
count_of_monte_cristo    dead_souls_gogol         death_in_venice
faust_goethe             frankenstein_shelley     hamlet_shakespeare
huckleberry_finn         intrigue_and_love        lady_of_camellias
letter_unknown_woman     merchant_of_venice       moby_dick_melville
nineteen_eighty_four     pere_goriot              pride_and_prejudice
robinson_crusoe          romeo_and_juliet         sense_and_sensibility
sherlock_holmes          siddhartha_hesse         the_captains_daughter
the_castle_kafka         the_little_prince        the_metamorphosis
the_mysterious_island    the_red_and_the_black    the_trial_kafka
twenty_thousand_leagues  war_and_peace            white_nights_dostoevsky
```

Three of those are worth a decision because the answer is knowable:

- **Shakespeare** — `hamlet_shakespeare`, `merchant_of_venice`, `romeo_and_juliet`.
  The standard Chinese Shakespeare is **朱生豪's (d. 1944)**, which is **public domain
  in China since 1995**. If these use it they are clean. That is checkable.
- **Orwell** — `animal_farm`, `nineteen_eighty_four`. Orwell died 1950, so both are
  public domain in China and the EU — but **still in copyright in the US until 2040 and
  2041**. Where you ship decides which applies to you.
- **`picture_dorian_gray`** contains **untranslated English**, and
  **`in_search_of_sacred` is misnamed** — its content is 《搜神记》, an Eastern Jin text,
  with nothing to do with a search for the sacred. Neither is a legal problem; both are
  content-quality problems worth fixing anyway.

## Safe or near-safe (22 books)

**Ancient Chinese texts — the original is unambiguously public domain (17).**
Caveat: the *text* is free, but a modern punctuated or annotated edition can carry
editorial copyright, and any English or other-language **translation** of them is a
new work.

```
classic_mountains_seas     dao_de_jing         dream_of_red_chamber    guiguzi
han_feizi                  huainanzi           in_search_of_sacred     journey_to_the_west
liezi                      mencius             mozi                    records_grand_historian
romance_of_three_kingdoms  the_analects        the_art_of_war          thirty_six_stratagems
zhuangzi
```

**Twentieth-century Chinese authors old enough to be free (6).**

```
call_to_arms_luxun   dawn_blossoms_luxun   old_tales_retold   wandering_luxun
```

Lu Xun died 1936, so these have been public domain in China since 1986. They carry
scraped-website artefacts (literal ``` fences) worth cleaning.

```
rickshaw_boy
```

老舍 died 1966, so this is public domain in China since 2017 — but note its sibling
`teahouse_laoshe` was removed, and this file may come from the same published collection.

## Recommended next steps

1. **Decide on the 36 translations.** Either identify each translator and keep the ones
   whose translator died 50+ years ago, or replace them with original-language
   public-domain texts translated with AI, or remove them.
2. **Check the three Shakespeare titles against 朱生豪** — likely a free win.
3. **Check against US rules** if you distribute there: 95 years from publication applies
   regardless of the author's death date.
4. **Apply the same removals where the books are actually served from.** They are bundled
   *and* mirrored at `hanzi-master-books.web.app`; a removed book may still be
   downloadable from there.
5. **Get a lawyer** on the translation question. It is settled law — 翻译作品 is
   explicitly protected under 著作权法 — and it is the one answer here that is expensive
   to get wrong.
