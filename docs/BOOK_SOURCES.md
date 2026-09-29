# Book Sources — where the added books came from

Every book added to the Grand Library after 2026-09-27 is listed here with the
URL it was fetched from and the licence it was under. The first 86 books had no
such record, which is how 31 of them turned out to be unshippable — see
`BOOK_COPYRIGHT_REMOVALS.md`.

Fetched 2026-09-27. Regenerate with `python scratch/import_pd_books.py --phase data`.

## Sources

* **[chinese-poetry/chinese-poetry](https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master)** — MIT (chinese-poetry); underlying text public domain.
  Licence text bundled at `third_party/chinese-poetry-LICENSE`.
* **[Project Gutenberg](https://www.gutenberg.org/browse/languages/zh)** — Project Gutenberg License (public-domain text). Header and footer boilerplate is stripped at import; the works
  themselves are public domain.

## Why these are safe to ship

1. **The underlying works are public domain.** Every text was written before 1900
   and its author died centuries ago. **None is a modern translation**, which was
   the single largest problem in the original library.
2. **Each source carries an explicit licence** (MIT, or the Project Gutenberg
   License), and both are recorded here rather than assumed.

Text is converted traditional → simplified at import time (`opencc`) and pinyin is
generated locally (`pypinyin`); neither step creates a new copyright.

**78 book(s) recorded.**

| id | 中文名 | English | Author | Source | Licence |
|---|---|---|---|---|---|
| `a_fool_s_dream_talk` |  | A Fool's Dream Talk | Anonymous | [link](https://www.gutenberg.org/ebooks/24154) | Project Gutenberg License (public-domain text) |
| `a_play_within_a_play` |  | A Play Within a Play | Anonymous | [link](https://www.gutenberg.org/ebooks/24225) | Project Gutenberg License (public-domain text) |
| `anecdotes_from_court_and_country` |  | Anecdotes from Court and Country | Zhang Zhuo | [link](https://www.gutenberg.org/ebooks/26997) | Project Gutenberg License (public-domain text) |
| `baijiaxing` | 百家姓 | Hundred Family Surnames | 佚名 | [link](https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E8%92%99%E5%AD%A6/baijiaxing.json) | MIT (chinese-poetry) |
| `casual_expressions_of_idle_feeling` |  | Casual Expressions of Idle Feeling | Li Yu | [link](https://www.gutenberg.org/ebooks/25471) | Project Gutenberg License (public-domain text) |
| `daxue` | 大学 | The Great Learning | 曾子 | [link](https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E5%9B%9B%E4%B9%A6%E4%BA%94%E7%BB%8F/daxue.json) | MIT (chinese-poetry) |
| `deng_xizi` |  | Deng Xizi | Deng Xi | [link](https://www.gutenberg.org/ebooks/7215) | Project Gutenberg License (public-domain text) |
| `discourses_of_the_states` |  | Discourses of the States | Anonymous | [link](https://www.gutenberg.org/ebooks/23911) | Project Gutenberg License (public-domain text) |
| `dizigui` | 弟子规 | Standards for Students | 李毓秀 | [link](https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E8%92%99%E5%AD%A6/dizigui.json) | MIT (chinese-poetry) |
| `dream_pool_essays` |  | Dream Pool Essays | Shen Kuo | [link](https://www.gutenberg.org/ebooks/7317) | Project Gutenberg License (public-domain text) |
| `flowers_in_the_mirror` |  | Flowers in the Mirror | Li Ruzhen | [link](https://www.gutenberg.org/ebooks/23818) | Project Gutenberg License (public-domain text) |
| `further_records_of_searching_for_spirits` |  | Further Records of Searching for Spirits | Tao Yuanming | [link](https://www.gutenberg.org/ebooks/7266) | Project Gutenberg License (public-domain text) |
| `garden_of_stories` |  | Garden of Stories | Liu Xiang | [link](https://www.gutenberg.org/ebooks/7332) | Project Gutenberg License (public-domain text) |
| `generals_of_the_yang_family` |  | Generals of the Yang Family | Anonymous | [link](https://www.gutenberg.org/ebooks/23838) | Project Gutenberg License (public-domain text) |
| `gongsun_longzi` |  | Gongsun Longzi | Gongsun Long | [link](https://www.gutenberg.org/ebooks/7216) | Project Gutenberg License (public-domain text) |
| `guanzi` |  | Guanzi | Guan Zhong et al. | [link](https://www.gutenberg.org/ebooks/7367) | Project Gutenberg License (public-domain text) |
| `guwenguanzhi` | 古文观止 | Guwen Guanzhi: The Finest Classical Prose | 吴楚材、吴调侯 | [link](https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E8%92%99%E5%AD%A6/guwenguanzhi.json) | MIT (chinese-poetry) |
| `idle_talk_under_the_bean_arbor` |  | Idle Talk Under the Bean Arbor | Aina Jushi | [link](https://www.gutenberg.org/ebooks/25328) | Project Gutenberg License (public-domain text) |
| `lord_liang_s_nine_remonstrances` |  | Lord Liang's Nine Remonstrances | Anonymous | [link](https://www.gutenberg.org/ebooks/26886) | Project Gutenberg License (public-domain text) |
| `love_in_the_mountains_and_waters` |  | Love in the Mountains and Waters | Anonymous | [link](https://www.gutenberg.org/ebooks/25146) | Project Gutenberg License (public-domain text) |
| `miscellaneous_records_of_duyang` |  | Miscellaneous Records of Duyang | Su E | [link](https://www.gutenberg.org/ebooks/25253) | Project Gutenberg License (public-domain text) |
| `miscellanies_of_the_western_capital` |  | Miscellanies of the Western Capital | Anonymous | [link](https://www.gutenberg.org/ebooks/23951) | Project Gutenberg License (public-domain text) |
| `new_prefaces` |  | New Prefaces | Liu Xiang | [link](https://www.gutenberg.org/ebooks/23945) | Project Gutenberg License (public-domain text) |
| `notes_from_the_thatched_hut` |  | Notes from the Thatched Hut | Ji Yun | [link](https://www.gutenberg.org/ebooks/23817) | Project Gutenberg License (public-domain text) |
| `officialdom_unmasked` |  | Officialdom Unmasked | Li Baojia | [link](https://www.gutenberg.org/ebooks/24138) | Project Gutenberg License (public-domain text) |
| `outer_traditions_of_the_han_school_of_so` |  | Outer Traditions of the Han School of Songs | Han Ying | [link](https://www.gutenberg.org/ebooks/7290) | Project Gutenberg License (public-domain text) |
| `qianziwen` | 千字文 | Thousand Character Classic | 周兴嗣 | [link](https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E8%92%99%E5%AD%A6/qianziwen.json) | MIT (chinese-poetry) |
| `reflections_on_things_at_hand` |  | Reflections on Things at Hand | Zhu Xi & Lu Zuqian | [link](https://www.gutenberg.org/ebooks/23840) | Project Gutenberg License (public-domain text) |
| `romance_of_the_sui_and_tang` |  | Romance of the Sui and Tang | Chu Renhuo | [link](https://www.gutenberg.org/ebooks/23835) | Project Gutenberg License (public-domain text) |
| `romance_of_the_western_chamber` |  | Romance of the Western Chamber | Wang Shifu | [link](https://www.gutenberg.org/ebooks/23906) | Project Gutenberg License (public-domain text) |
| `sanzijing` | 三字经 | Three Character Classic | 王应麟 | [link](https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E8%92%99%E5%AD%A6/sanzijing-new.json) | MIT (chinese-poetry) |
| `shenglvqimeng` | 声律启蒙 | Rhyme Enlightenment | 车万育 | [link](https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E8%92%99%E5%AD%A6/shenglvqimeng.json) | MIT (chinese-poetry) |
| `six_secret_teachings` |  | Six Secret Teachings | Jiang Ziya | [link](https://www.gutenberg.org/ebooks/7340) | Project Gutenberg License (public-domain text) |
| `spring_in_the_jade_tower` |  | Spring in the Jade Tower | Anonymous | [link](https://www.gutenberg.org/ebooks/25422) | Project Gutenberg License (public-domain text) |
| `stories_to_enlighten_the_world` |  | Stories to Enlighten the World | Feng Menglong | [link](https://www.gutenberg.org/ebooks/27582) | Project Gutenberg License (public-domain text) |
| `study_of_human_abilities` |  | Study of Human Abilities | Liu Shao | [link](https://www.gutenberg.org/ebooks/7217) | Project Gutenberg License (public-domain text) |
| `tales_of_the_tang` |  | Tales of the Tang | Anonymous | [link](https://www.gutenberg.org/ebooks/23824) | Project Gutenberg License (public-domain text) |
| `the_book_of_lord_shang` |  | The Book of Lord Shang | Shang Yang | [link](https://www.gutenberg.org/ebooks/7383) | Project Gutenberg License (public-domain text) |
| `the_cases_of_judge_dee` |  | The Cases of Judge Dee | Anonymous | [link](https://www.gutenberg.org/ebooks/27686) | Project Gutenberg License (public-domain text) |
| `the_cases_of_judge_hai` |  | The Cases of Judge Hai | Anonymous | [link](https://www.gutenberg.org/ebooks/54494) | Project Gutenberg License (public-domain text) |
| `the_cases_of_judge_shi` |  | The Cases of Judge Shi | Anonymous | [link](https://www.gutenberg.org/ebooks/25393) | Project Gutenberg License (public-domain text) |
| `the_classic_of_go` |  | The Classic of Go | Various | [link](https://www.gutenberg.org/ebooks/7407) | Project Gutenberg License (public-domain text) |
| `the_classic_of_tea` |  | The Classic of Tea | Lu Yu | [link](https://www.gutenberg.org/ebooks/7406) | Project Gutenberg License (public-domain text) |
| `the_complete_tale_of_feituo` |  | The Complete Tale of Feituo | Anonymous | [link](https://www.gutenberg.org/ebooks/27331) | Project Gutenberg License (public-domain text) |
| `the_drunken_awakening_stone` |  | The Drunken Awakening Stone | Anonymous | [link](https://www.gutenberg.org/ebooks/24027) | Project Gutenberg License (public-domain text) |
| `the_family_instructions_of_master_yan` |  | The Family Instructions of Master Yan | Yan Zhitui | [link](https://www.gutenberg.org/ebooks/7454) | Project Gutenberg License (public-domain text) |
| `the_flounder` |  | The Flounder | Li Yu | [link](https://www.gutenberg.org/ebooks/24185) | Project Gutenberg License (public-domain text) |
| `the_green_peony` |  | The Green Peony | Anonymous | [link](https://www.gutenberg.org/ebooks/27330) | Project Gutenberg License (public-domain text) |
| `the_heavenly_leopard` |  | The Heavenly Leopard | Anonymous | [link](https://www.gutenberg.org/ebooks/26904) | Project Gutenberg License (public-domain text) |
| `the_investiture_of_the_gods` |  | The Investiture of the Gods | Xu Zhonglin | [link](https://www.gutenberg.org/ebooks/23910) | Project Gutenberg License (public-domain text) |
| `the_literary_mind_and_the_carving_of_dra` |  | The Literary Mind and the Carving of Dragons | Liu Xie | [link](https://www.gutenberg.org/ebooks/23822) | Project Gutenberg License (public-domain text) |
| `the_lone_swan` |  | The Lone Swan | Su Manshu | [link](https://www.gutenberg.org/ebooks/23983) | Project Gutenberg License (public-domain text) |
| `the_new_book_of_jia_yi` |  | The New Book of Jia Yi | Jia Yi | [link](https://www.gutenberg.org/ebooks/23814) | Project Gutenberg License (public-domain text) |
| `the_peony_pavilion` |  | The Peony Pavilion | Tang Xianzu | [link](https://www.gutenberg.org/ebooks/23849) | Project Gutenberg License (public-domain text) |
| `the_phoenix_flute` |  | The Phoenix Flute | Anonymous | [link](https://www.gutenberg.org/ebooks/26921) | Project Gutenberg License (public-domain text) |
| `the_platform_sutra_of_the_sixth_patriarc` |  | The Platform Sutra of the Sixth Patriarch | Huineng | [link](https://www.gutenberg.org/ebooks/23844) | Project Gutenberg License (public-domain text) |
| `the_poets_grading` |  | The Poets' Grading | Zhong Rong | [link](https://www.gutenberg.org/ebooks/7342) | Project Gutenberg License (public-domain text) |
| `the_scholars` |  | The Scholars | Wu Jingzi | [link](https://www.gutenberg.org/ebooks/24032) | Project Gutenberg License (public-domain text) |
| `the_slaying_of_the_ghosts` |  | The Slaying of the Ghosts | Anonymous | [link](https://www.gutenberg.org/ebooks/23867) | Project Gutenberg License (public-domain text) |
| `the_strange_tale_of_the_woman_mulan` |  | The Strange Tale of the Woman Mulan | Anonymous | [link](https://www.gutenberg.org/ebooks/23938) | Project Gutenberg License (public-domain text) |
| `the_tale_of_li_wa` |  | The Tale of Li Wa | Bai Xingjian | [link](https://www.gutenberg.org/ebooks/24051) | Project Gutenberg License (public-domain text) |
| `the_travels_of_lao_can` |  | The Travels of Lao Can | Liu E | [link](https://www.gutenberg.org/ebooks/23850) | Project Gutenberg License (public-domain text) |
| `the_travels_of_xu_xiake` |  | The Travels of Xu Xiake | Xu Xiake | [link](https://www.gutenberg.org/ebooks/23876) | Project Gutenberg License (public-domain text) |
| `the_unicorn_child` |  | The Unicorn Child | Anonymous | [link](https://www.gutenberg.org/ebooks/27399) | Project Gutenberg License (public-domain text) |
| `three_strategies` |  | Three Strategies | Huang Shigong | [link](https://www.gutenberg.org/ebooks/7218) | Project Gutenberg License (public-domain text) |
| `waiting_for_the_dawn` |  | Waiting for the Dawn | Huang Zongxi | [link](https://www.gutenberg.org/ebooks/23855) | Project Gutenberg License (public-domain text) |
| `water_margin` |  | Water Margin | Shi Nai'an | [link](https://www.gutenberg.org/ebooks/23863) | Project Gutenberg License (public-domain text) |
| `wei_liaozi` |  | Wei Liaozi | Wei Liao | [link](https://www.gutenberg.org/ebooks/7219) | Project Gutenberg License (public-domain text) |
| `wenzimengqiu` | 文字蒙求 | Learning Characters | 王筠 | [link](https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E8%92%99%E5%AD%A6/wenzimengqiu.json) | MIT (chinese-poetry) |
| `yan_danzi` |  | Yan Danzi | Anonymous | [link](https://www.gutenberg.org/ebooks/24068) | Project Gutenberg License (public-domain text) |
| `yin_wenzi` |  | Yin Wenzi | Yin Wen | [link](https://www.gutenberg.org/ebooks/27017) | Project Gutenberg License (public-domain text) |
| `youmengying` | 幽梦影 | Quiet Dream Shadows | 张潮 | [link](https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E5%B9%BD%E6%A2%A6%E5%BD%B1/youmengying.json) | MIT (chinese-poetry) |
| `youxueqionglin` | 幼学琼林 | Children's Knowledge Treasury | 程允升 | [link](https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E8%92%99%E5%AD%A6/youxueqionglin.json) | MIT (chinese-poetry) |
| `yu_jiao_li` |  | Yu Jiao Li | Anonymous | [link](https://www.gutenberg.org/ebooks/23877) | Project Gutenberg License (public-domain text) |
| `yuli_zi` |  | Yuli Zi | Liu Ji | [link](https://www.gutenberg.org/ebooks/25298) | Project Gutenberg License (public-domain text) |
| `zengguangxianwen` | 增广贤文 | Enlarged Collection of Maxims | 佚名 | [link](https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E8%92%99%E5%AD%A6/zengguangxianwen.json) | MIT (chinese-poetry) |
| `zhongyong` | 中庸 | The Doctrine of the Mean | 子思 | [link](https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E5%9B%9B%E4%B9%A6%E4%BA%94%E7%BB%8F/zhongyong.json) | MIT (chinese-poetry) |
| `zhuzijiaxun` | 朱子家训 | Zhu Family Maxims | 朱柏庐 | [link](https://raw.githubusercontent.com/chinese-poetry/chinese-poetry/master/%E8%92%99%E5%AD%A6/zhuzijiaxun.json) | MIT (chinese-poetry) |
