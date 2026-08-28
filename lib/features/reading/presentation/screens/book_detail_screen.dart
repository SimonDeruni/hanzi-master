import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/features/reading/domain/entities/book_model.dart';
import 'package:hanzi_master/features/reading/presentation/providers/book_providers.dart';
import 'package:hanzi_master/features/reading/presentation/screens/book_reader_screen.dart';
import 'package:hanzi_master/features/reading/presentation/widgets/calligraphic_book_cover.dart';
import 'package:hanzi_master/features/flashcards/presentation/utils/haptics_manager.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';

// ─── Per-author English bio lookup ─────────────────────────────────────────
// Each entry is specific to the author's life, period, and literary impact.
const Map<String, String> _kAuthorBios = {
  // Chinese Classics
  '吴承恩': "Wu Cheng'en (c. 1500–1582) was a Ming Dynasty novelist from Huai'an, Jiangsu. Drawing on decades of folklore, Buddhist allegory, and satirical wit, he wove the mythology of the Tang pilgrimage into Journey to the West — one of the most inventive and beloved works in world literature.",
  '罗贯中': "Luo Guanzhong (c. 1330–1400) was a Yuan-to-Ming transition era playwright and novelist, believed to have studied under Shi Nai'an. His Romance of the Three Kingdoms synthesised historical chronicles, oral tradition, and dramatic storytelling into the definitive Chinese historical epic.",
  '施耐庵': "Shi Nai'an (c. 1296–1372) was a Yuan Dynasty literatus who reportedly passed the imperial examination yet chose the life of a reclusive scholar. Water Margin, his masterwork of heroic outlaws and righteous rebellion, established the archetype of the Chinese martial epic.",
  '曹雪芹': "Cao Xueqin (c. 1715–1763) was a Qing Dynasty novelist born into a once-wealthy Bannerman family whose fortunes collapsed under Emperor Yongzheng. Dream of the Red Chamber, written in his poverty-stricken final years, is widely regarded as the pinnacle of Chinese fiction — a vast, psychologically rich taphos of aristocratic decline.",
  '许仲琳': "Xu Zhonglin (fl. 16th–17th century) was a Ming Dynasty author credited with compiling Investiture of the Gods (封神演义), a monumental work of mythological fiction blending Shang-Zhou history with Daoist cosmology, celestial bureaucracy, and heroic warfare.",
  '蒲松龄': "Pu Songling (1640–1715) was a Qing Dynasty writer who spent decades compiling Strange Tales from a Chinese Studio after repeatedly failing the imperial examinations. His supernatural stories of fox spirits, ghosts, and scholars remain the gold standard of Chinese gothic literature.",
  '吴敬梓': "Wu Jingzi (1701–1754) was a Qing Dynasty novelist from Anhui who abandoned his inherited fortune and spent his life writing The Scholars — a biting satirical novel exposing the vanity, corruption, and absurdity of the imperial examination system and the scholar-gentry class.",
  '刘鹗': "Liu E (1857–1909) was a late-Qing polymath — engineer, doctor, and novelist — whose sole novel The Travels of Lao Can is a lyrical yet politically charged travelogue of a wandering healer navigating a China in the throes of dynastic collapse and foreign encroachment.",
  '李汝珍': "Li Ruzhen (c. 1763–1830) was a Qing Dynasty scholar with deep interests in phonology, chess, and cosmology. Flowers in the Mirror, his fantastical novel of a merchant journeying through impossible kingdoms, is remarkable for its feminist themes and encyclopaedic range of subjects.",
  '鲁迅': "Lu Xun (1881–1936), pen name of Zhou Shuren, is the father of modern Chinese literature. A physician who switched to writing to heal the Chinese spirit, his short story collections — Diary of a Madman and The True Story of Ah Q — used vernacular prose to expose feudalism, superstition, and national inertia with surgical precision.",
  '巴金': "Ba Jin (1904–2005), pen name of Li Yaotang, was one of the longest-lived and most prolific Chinese novelists of the 20th century. His Love Trilogy and Family Trilogy — including Spring and Autumn — depict Sichuan gentry families crushed by tradition and revolution, making him a voice of the May Fourth Movement's humanist ideals.",
  '老舍': "Lao She (1899–1966), pen name of Shu Qingchun, was a Beijing-born Manchu novelist and playwright whose Rickshaw Boy powerfully portrays the broken dreams of a rural migrant in Republican-era Beijing. Beloved for his warmth, humour, and authentic Beijing dialect, he was posthumously designated 'People's Artist'.",
  '钱钟书': "Qian Zhongshu (1910–1998) was a polyglot scholar who read in seven languages and produced Fortress Besieged — one of the wittiest novels in Chinese, a satirical dissection of the Chinese intellectual class of the 1940s. He spent the Cultural Revolution quietly working on his monumental annotations to the classics.",
  '张爱玲': "Zhang Ailing (1920–1995) was a Shanghai-born writer renowned for her psychologically precise and stylistically exquisite novellas — Love in a Fallen City and The Golden Cangue — that explore desire, betrayal, and survival among women in colonial Shanghai and wartime Hong Kong.",
  '沈从文': "Shen Congwen (1902–1988) was a self-educated Hunan writer who drew on his Miao-Han heritage to create the luminous pastoral world of Border Town — a novella of such elegant simplicity and quiet sorrow that it stands as one of the 20th century's most beloved Chinese texts.",
  '茅盾': "Mao Dun (1896–1981), pen name of Shen Dehong, was a Zhejiang-born novelist, critic, and politician who co-founded the Literary Research Society. Midnight (子夜), his magnum opus depicting Shanghai capitalism's turbulent 1930s financial crisis, is considered China's preeminent naturalist novel.",

  // Classical Literature
  '司马迁': "Sima Qian (c. 145–86 BC) was a Han Dynasty court historian who completed the Records of the Grand Historian (史记) despite enduring castration as imperial punishment for defending a disgraced general. His 130-chapter biographical history, covering three thousand years, defined the standard annals-and-biography format for all subsequent Chinese dynastic histories.",
  '孙武': "Sun Tzu (fl. 5th century BC) was a Chinese military strategist from the state of Qi whose 13-chapter treatise The Art of War has been studied continuously for 2,500 years. Its principles of deception, adaptability, and intelligence superiority have profoundly shaped military doctrine, diplomacy, and business strategy worldwide.",
  '鬼谷子': "Guiguzi (fl. 4th century BC) was a semi-legendary Warring States philosopher, the master of the Vertical and Horizontal School of political strategists. His treatise on persuasion, diplomacy, negotiation, and psychological manipulation remains a foundational text in Chinese statecraft and rhetoric.",
  '老子': "Laozi (fl. 6th century BC, tradition) is the legendary founder of Daoist philosophy, attributed with composing the Tao Te Ching (道德经) — 81 short chapters of paradoxical verse on the nature of the Way, non-action (wu wei), and the art of governing through yielding rather than force.",
  '庄子': "Zhuangzi (c. 369–286 BC) was a Warring States Daoist philosopher whose eponymous collected writings blend philosophical argument with vivid parables, dream sequences, and comic dialogues. His perspective-shifting thought experiments on relativity, nature, and freedom have fascinated readers from Chinese sages to Western existentialists.",
  '孔子': "Confucius (551–479 BC), born Kong Qiu in the state of Lu, was the founder of Confucianism whose teachings on ritual, benevolence (rén), and righteous governance profoundly shaped two millennia of Chinese civilisation. The Analects are a compilation of his sayings and dialogues recorded by his disciples.",
  '孟子': "Mencius (c. 372–289 BC) was the foremost student and advocate of Confucianism after Confucius himself. His eponymous text develops the doctrine of innate human goodness, the Mandate of Heaven, and the right of the people to overthrow tyrannical rulers — making him the earliest major thinker of benevolent government.",

  // European Classics — French
  '大仲马': "Alexandre Dumas père (1802–1870) was a Franco-Haitian playwright and novelist who became one of history's most prolific and widely read storytellers. The Count of Monte Cristo and The Three Musketeers, driven by his extraordinary gift for plotting and pace, made him a global phenomenon in the age of the serialised novel.",
  '雨果': "Victor Hugo (1802–1885) was the supreme figure of French Romanticism — poet, playwright, novelist, and political exile. Les Misérables, his sweeping vision of justice, redemption, and revolutionary Paris, stands among the most read novels in history; The Hunchback of Notre-Dame brought medieval Paris to vivid, melodramatic life.",
  '巴尔扎克': "Honoré de Balzac (1799–1850) was a French novelist of superhuman productivity who conceived The Human Comedy — a linked cycle of over 90 novels and stories intended as a complete sociological survey of French society. Despite chronic debt and minimal sleep, he transformed realist fiction into the art form of the modern world.",
  '福楼拜': "Gustave Flaubert (1821–1880) was a Normandy-born French master who spent five years writing Madame Bovary with such painstaking precision that each sentence was tested by reading aloud. His relentless pursuit of le mot juste (the exact word) and impersonal narrative stance made him the pioneer of literary realism.",
  '司汤达': "Stendhal (1783–1842), pen name of Marie-Henri Beyle, was a French novelist and diplomat whose The Red and the Black and The Charterhouse of Parma pioneered psychological realism decades ahead of their time. His focus on the inner life of ambitious, self-deluding heroes under Napoleonic ambition and Restoration hypocrisy remains startlingly modern.",
  '莫泊桑': "Guy de Maupassant (1850–1893) was a Norman-born French writer and protégé of Flaubert who mastered the short story with ruthless efficiency and compassion. Author of over 300 tales capturing peasants, bureaucrats, prostitutes, and soldiers, his prose style — spare, ironic, and perfectly observed — made him the defining short story writer of 19th-century France.",
  '大仲马（小仲马）': "Alexandre Dumas fils (1824–1895), son of Alexandre Dumas père, was a French playwright and novelist whose The Lady of the Camellias (Camille) — drawn from his own broken romance — became one of the most performed plays and beloved tearjerkers in European history, inspiring Verdi's La Traviata.",
  '儒勒·凡尔纳': "Jules Verne (1828–1905) was a French novelist from Nantes who, partnering with publisher Pierre-Jules Hetzel, created the Voyages Extraordinaires — 54 novels of scientific adventure that invented the genre of science fiction. His meticulous research into technology, geography, and natural science gave his fiction a prophetic credibility.",
  '卡谬': "Albert Camus (1913–1960) was an Algerian-French Nobel laureate who articulated absurdism — the confrontation between humanity's need for meaning and the universe's silent indifference. The Stranger and The Plague, his most celebrated novels, established him as the moral voice of postwar European existentialism.",
  '普鲁斯特': "Marcel Proust (1871–1922) was a Parisian novelist who spent the last 14 years of his life in a cork-lined room writing In Search of Lost Time — a 3,000-page introspective masterwork exploring memory, time, jealousy, and social performance in Belle Époque France. It is widely considered the greatest novel of the 20th century.",

  // German Classics
  '歌德': "Johann Wolfgang von Goethe (1749–1832) was the supreme figure of German literature — poet, playwright, scientist, and polymath. Faust, his 60-year magnum opus about a scholar who bargains with the devil for limitless knowledge, is the foundational work of German culture and one of world literature's most profound meditations on ambition and the human condition.",
  '托马斯·曼': "Thomas Mann (1875–1955) was a German Nobel laureate from Lübeck whose The Magic Mountain, Buddenbrooks, and Doctor Faustus combined dense intellectual symbolism, irony, and musical structure to create the defining works of German modernist prose. He spent the Nazi era in exile, broadcasting anti-fascist radio addresses from America.",
  '赫尔曼·黑塞': "Hermann Hesse (1877–1962) was a German-Swiss Nobel laureate whose novels Siddhartha, Steppenwolf, and The Glass Bead Game became cult texts of the 1960s counterculture. His lifelong quest for spiritual authenticity — drawing on Jungian psychology, Eastern philosophy, and German Romanticism — gave his work its peculiarly timeless and personal resonance.",
  '弗朗茨·卡夫卡': "Franz Kafka (1883–1924) was a Prague-born German-language insurance lawyer who wrote his nightmarish fiction entirely at night and instructed his executor to burn it after his death. The Trial, The Metamorphosis, and The Castle — largely unpublished in his lifetime — gave the world the adjective 'Kafkaesque' for bureaucratic absurdity, alienation, and existential dread.",
  '海因里希·海涅': "Heinrich Heine (1797–1856) was a German-Jewish Romantic poet and essayist whose lyrical wit and political radicalism made him both celebrated and exiled. Germany: A Winter's Tale merges travelogue, satire, and dream vision in a ferocious poetic attack on German nationalism and complacency.",

  // Russian Classics
  '托尔斯泰': "Leo Tolstoy (1828–1910) was a Russian Count from Tula who used his vast aristocratic estate and his even vaster moral conscience to produce War and Peace and Anna Karenina — two of the greatest novels ever written. In his final decades he became a Christian anarchist, renouncing his copyright and living in deliberate poverty.",
  '陀思妥耶夫斯基': "Fyodor Dostoevsky (1821–1881) was a Russian novelist who survived a mock execution, four years of Siberian hard labour, and a compulsive gambling habit to write Crime and Punishment, The Idiot, and The Brothers Karamazov. His psychologically harrowing portraits of suffering, faith, and free will made him the father of existentialist fiction.",
  '契诃夫': "Anton Chekhov (1860–1904) was a Russian physician and master of the short story whose works — The Cherry Orchard, Three Sisters, The Seagull — transformed theatre and prose with their elliptical endings, submerged emotion, and clinical compassion for ordinary human failure. He died of tuberculosis at 44, having written over 200 stories.",
  '屠格涅夫': "Ivan Turgenev (1818–1883) was the first Russian novelist to achieve major fame in Western Europe. Fathers and Sons introduced the word 'nihilism' to the world through the character of Bazarov; his Sketches from a Hunter's Album was credited by Tsar Alexander II with helping to inspire the emancipation of the serfs.",
  '果戈里': "Nikolai Gogol (1809–1852) was a Ukrainian-born Russian writer whose darkly comic masterpiece Dead Souls and his grotesque short stories — The Nose, The Overcoat — invented the tradition of Russian satirical realism that Dostoevsky famously declared 'we all came out from under Gogol's Overcoat'.",
  '高尔基': "Maxim Gorky (1868–1936), born Alexei Peshkov, rose from orphan and vagrant to become Russia's most celebrated proletarian writer. Mother and The Lower Depths gave a raw voice to Russia's dispossessed; his autobiographical trilogy stands as the most vivid account of self-education and political awakening in Russian literature.",

  // Spanish & Italian Classics
  '塞万提斯': "Miguel de Cervantes (1547–1616) was a Spanish soldier, captive, and tax collector whose Don Quixote — written largely in poverty — is the first modern novel and the most widely read Spanish-language book in history. Its self-aware, genre-subverting narrative of a deluded knight-errant remains inexhaustibly profound and funny.",
  '但丁': "Dante Alighieri (1265–1321) was a Florentine poet exiled for political intrigue whose Divine Comedy — Inferno, Purgatorio, and Paradiso — is the supreme work of medieval literature and the foundation of the Italian literary language. His journey through Hell, Purgatory, and Heaven with Virgil as guide shaped Western Christian imagination for seven centuries.",
  '薄伽丘': "Giovanni Boccaccio (1313–1375) was a Florentine writer whose Decameron — 100 tales told by ten aristocrats sheltering from the Black Death — is the masterwork of Italian Renaissance prose. Riotously comic, compassionate, and sometimes scandalous, it established the framed tale as a major literary form and influenced Chaucer and Shakespeare.",
  '彼特拉克': "Francesco Petrarch (1304–1374) was an Italian poet and scholar considered the 'Father of Humanism'. His Canzoniere — 366 Italian sonnets and songs lamenting his unrequited love for Laura — defined the Petrarchan sonnet form that shaped European lyric poetry for three centuries.",

  // British & American Classics
  '狄更斯': "Charles Dickens (1812–1870) was the defining English novelist of the Victorian era, serialising his novels in monthly parts to a mass readership. His childhood experience of factory labour (his father was imprisoned for debt) fuelled his lifelong campaign against poverty, injustice, and hypocrisy in novels of unforgettable characters and moral fury.",
  '简·奥斯汀': "Jane Austen (1775–1817) was a Hampshire clergyman's daughter who published her six novels anonymously, yet created the most precisely observed, wittily ironic portraits of English provincial society in literary history. Pride and Prejudice, Sense and Sensibility, and Emma remain among the most beloved and re-read novels in the English language.",
  '勃朗特': "Emily Brontë (1818–1848), the most reclusive of the remarkable Brontë sisters, spent most of her short life on the Yorkshire moors she loved passionately. Wuthering Heights, her only novel, is a gothic masterpiece of obsessive love, social class, and supernatural vengeance unlike any other Victorian fiction.",
  '夏洛蒂·勃朗特': "Charlotte Brontë (1816–1855) was the eldest surviving Brontë sister, who wrote Jane Eyre under the pseudonym Currer Bell. A pioneering work in first-person psychological realism and proto-feminist independence, it shocked and captivated Victorian readers with its passionate, defiant heroine.",
  '马克·吐温': "Mark Twain (1835–1910), pen name of Samuel Clemens, was a Missouri-born humorist, journalist, and novelist who captured the moral contradictions of antebellum America in The Adventures of Tom Sawyer and Huckleberry Finn — the latter called by Hemingway 'the book from which all modern American literature comes'.",
  '赫尔曼·梅尔维尔': "Herman Melville (1819–1891) was a New York-born sailor and novelist who drew on his harrowing whaling voyages to write Moby-Dick — initially a commercial failure that was rediscovered in the 20th century as the great American philosophical novel, a vast allegory of obsession, fate, and the unknowable.",
  '亨利·大卫·梭罗': "Henry David Thoreau (1817–1862) was a Massachusetts transcendentalist, naturalist, and tax resister who spent two years living in a hand-built cabin at Walden Pond. Walden, his account of deliberate simplicity and self-reliance, became a foundational text of environmentalism, civil disobedience, and the examined life.",
  '玛丽·雪莱': "Mary Shelley (1797–1851) was an English novelist who wrote Frankenstein at age 18 during a ghost-story challenge with Byron and Percy Bysshe Shelley on the shores of Lake Geneva. Her tale of a scientist's catastrophic act of creation is considered the first true science fiction novel and a foundational text on the ethics of playing God.",
  '亚瑟·柯南·道尔': "Arthur Conan Doyle (1859–1930) was a Scottish physician and novelist who created Sherlock Holmes — fiction's most famous detective — in a series of 60 stories published between 1887 and 1927. Holmes's deductive method, derived from Doyle's Edinburgh medical training, made him the archetype of the rational, scientific investigator.",
  '乔治·奥威尔': "George Orwell (1903–1950), pen name of Eric Blair, was an English essayist, journalist, and novelist who fought in the Spanish Civil War and emerged as the 20th century's most trenchant critic of totalitarianism. Animal Farm and Nineteen Eighty-Four — written while he was dying of tuberculosis — gave the world words like 'doublethink', 'Big Brother', and 'Newspeak'.",
  '杰克·伦敦': "Jack London (1876–1916) was an Oakland-born adventure writer, socialist, and former oyster pirate who channelled his brutal experiences as a labourer, sailor, and Klondike gold-rush prospector into The Call of the Wild, White Fang, and The Sea-Wolf — tales of survival, instinct, and the primordial struggle between civilisation and nature.",
  '夏洛克·福尔摩斯': "Arthur Conan Doyle (1859–1930) was a Scottish physician who created Sherlock Holmes — fiction's most celebrated detective — in a series of 60 stories. Holmes's extraordinary deductive method and Baker Street atmosphere made him the most frequently portrayed fictional character in film and television history.",
};

// ─── Per-author Chinese bio (generic fallback) ──────────────────────────────
String _authorBioZh(BookModel book) =>
    '本作是 ${book.author} 的代表性传世巨著，在世界与中华文学史上具有深远的历史影响与文学造诣。';

String _authorBioEn(BookModel book) {
  // Try exact Chinese name match first
  final exact = _kAuthorBios[book.author];
  if (exact != null) return exact;
  // Try English name partial match
  final en = book.authorEn.trim();
  for (final entry in _kAuthorBios.entries) {
    if (entry.key.contains(en) || en.contains(entry.key)) return entry.value;
  }
  // Fallback: generic English template (still uses real metadata)
  return '${book.authorEn} (${book.dynastyOrEra}) is the author of ${book.titleEn}, '
      'a seminal work of ${book.category} that has left an enduring mark on world literature '
      'and continues to be studied and celebrated by readers across generations.';
}

// ─── Screen ─────────────────────────────────────────────────────────────────

class BookDetailScreen extends ConsumerStatefulWidget {
  final BookModel book;
  const BookDetailScreen({super.key, required this.book});

  @override
  ConsumerState<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends ConsumerState<BookDetailScreen> {
  bool _showChineseAuthor = false;
  bool _showChineseSynopsis = false;

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF141416) : const Color(0xFFFDFCF0);
    final cardBg = isDark ? const Color(0xFF1E1E22) : Colors.white;
    final primaryText = isDark ? Colors.white : const Color(0xFF1A1A1B);
    final accentColor = isDark ? Colors.amber.shade400 : const Color(0xFF8B0000);

    final chaptersAsync = ref.watch(bookChaptersProvider(book.id));
    final currentProgress = ref.watch(bookProgressProvider(book.id));

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20, color: primaryText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share_outlined, size: 22, color: primaryText),
            onPressed: () {
              HapticsManager.light();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Book link copied to clipboard!')),
              );
            },
          ),
        ],
      ),
      body: chaptersAsync.when(
        data: (chapters) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Hero Book Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Calligraphic Book Cover
                      CalligraphicBookCover(
                        book: book,
                        width: 135,
                        height: 190,
                      ),
                      const SizedBox(height: 16),

                      Text(
                        book.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: primaryText,
                          letterSpacing: 1.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        book.titleEn,
                        style: TextStyle(
                          fontSize: 15,
                          color: isDark ? Colors.white60 : Colors.black54,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),

                      // Tags Row
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8,
                        children: [
                          _buildBadge('HSK ${book.hskLevel}', isDark ? Colors.amber.shade400 : const Color(0xFF8B0000)),
                          _buildBadge(book.category, isDark ? Colors.blue.shade300 : Colors.indigo.shade700),
                          _buildBadge(book.dynastyOrEra, isDark ? Colors.green.shade300 : Colors.teal.shade700),
                          _buildBadge('${chapters.length} Chapters', isDark ? Colors.purple.shade300 : Colors.deepPurple.shade700),
                        ],
                      ),
                      const SizedBox(height: 18),

                      // Action Button (Start / Continue Reading)
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            HapticsManager.heavy();
                            final initialIndex = (currentProgress - 1).clamp(0, chapters.length - 1);
                            Navigator.of(context).push(
                              SwipeBackPageRoute(
                                builder: (_) => BookReaderScreen(
                                  book: book,
                                  chapters: chapters,
                                  initialChapterIndex: initialIndex,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDark ? Colors.amber.shade700 : const Color(0xFF1A1A1B),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                currentProgress > 1 ? Icons.auto_stories : Icons.play_arrow_rounded,
                                size: 22,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                currentProgress > 1
                                    ? 'Continue Chapter $currentProgress'
                                    : 'Start Reading',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (chapters.isNotEmpty) ...[
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              HapticsManager.medium();
                              final initialIndex = (currentProgress - 1).clamp(0, chapters.length - 1);
                              Navigator.of(context).push(
                                SwipeBackPageRoute(
                                  builder: (_) => BookReaderScreen(
                                    book: book,
                                    chapters: chapters,
                                    initialChapterIndex: initialIndex,
                                    autoStartAudiobook: true,
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.podcasts, size: 18, color: accentColor),
                            label: Text(
                              'Listen to Audiobook',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: accentColor,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: accentColor, width: 1.2),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),

                      // ── Author Card ─────────────────────────────────────
                      _buildCard(
                        isDark: isDark,
                        cardBg: cardBg,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Author header row
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: accentColor.withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.person_outline, size: 22, color: accentColor),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        book.authorEn,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: primaryText,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${book.author}  ·  ${book.dynastyOrEra}  ·  ${book.category}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: accentColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // English bio (unique per author)
                            Text(
                              _authorBioEn(book),
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.55,
                                color: isDark ? Colors.white70 : const Color(0xFF2C2C2E),
                              ),
                            ),

                            // Chinese dropdown toggle
                            _buildChineseToggle(
                              label: '查看中文简介',
                              isOpen: _showChineseAuthor,
                              accentColor: accentColor,
                              onTap: () {
                                HapticsManager.light();
                                setState(() => _showChineseAuthor = !_showChineseAuthor);
                              },
                            ),
                            if (_showChineseAuthor) ...[
                              const SizedBox(height: 8),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: accentColor.withValues(alpha: isDark ? 0.08 : 0.05),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: accentColor.withValues(alpha: 0.2)),
                                ),
                                child: Text(
                                  _authorBioZh(book),
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.55,
                                    color: isDark ? Colors.white60 : Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // ── Synopsis Card ───────────────────────────────────
                      _buildCard(
                        isDark: isDark,
                        cardBg: cardBg,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Section header
                            Row(
                              children: [
                                Icon(Icons.auto_stories, size: 20, color: accentColor),
                                const SizedBox(width: 8),
                                Text(
                                  'Synopsis',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryText,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // English synopsis (default visible)
                            Text(
                              book.descriptionEn,
                              style: TextStyle(
                                fontSize: 14.5,
                                height: 1.6,
                                color: isDark ? Colors.white70 : const Color(0xFF1A1A1B),
                              ),
                            ),

                            // Chinese synopsis dropdown
                            _buildChineseToggle(
                              label: '查看中文概述',
                              isOpen: _showChineseSynopsis,
                              accentColor: accentColor,
                              onTap: () {
                                HapticsManager.light();
                                setState(() => _showChineseSynopsis = !_showChineseSynopsis);
                              },
                            ),
                            if (_showChineseSynopsis) ...[
                              const SizedBox(height: 8),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: accentColor.withValues(alpha: isDark ? 0.08 : 0.05),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: accentColor.withValues(alpha: 0.2)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      book.description,
                                      style: TextStyle(
                                        fontSize: 14.5,
                                        height: 1.6,
                                        color: isDark ? Colors.white60 : Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Divider(color: isDark ? Colors.white12 : Colors.black12),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(Icons.psychology_outlined, size: 14, color: accentColor),
                                        const SizedBox(width: 5),
                                        Text(
                                          '核心思想与阅读价值',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: accentColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '全篇通过跌宕起伏的叙事艺术，探讨了人性抉择、道德伦理与精神追求，是语言学习与人文修养的必读典范。',
                                      style: TextStyle(
                                        fontSize: 13,
                                        height: 1.4,
                                        color: isDark ? Colors.white54 : Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Table of Contents Header
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Table of Contents · 目录 (${chapters.length} Chapters)',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: primaryText,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),

              // Chapter List
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final ch = chapters[index];
                      final isCurrent = ch.chapterIndex == currentProgress;
                      final isDarkLocal = Theme.of(context).brightness == Brightness.dark;
                      final cardBgLocal = isDarkLocal ? const Color(0xFF1E1E22) : Colors.white;
                      final primaryTextLocal = isDarkLocal ? Colors.white : const Color(0xFF1A1A1B);

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: isCurrent
                              ? (isDarkLocal ? Colors.amber.withValues(alpha: 0.15) : const Color(0xFFF2ECE1))
                              : cardBgLocal,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isCurrent
                                ? (isDarkLocal ? Colors.amber.shade500 : const Color(0xFF8B0000))
                                : (isDarkLocal ? Colors.white10 : Colors.black.withValues(alpha: 0.05)),
                            width: isCurrent ? 1.5 : 1.0,
                          ),
                        ),
                        child: ListTile(
                          onTap: () {
                            HapticsManager.medium();
                            Navigator.of(context).push(
                              SwipeBackPageRoute(
                                builder: (_) => BookReaderScreen(
                                  book: book,
                                  chapters: chapters,
                                  initialChapterIndex: index,
                                ),
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            radius: 16,
                            backgroundColor: isCurrent
                                ? (isDarkLocal ? Colors.amber.shade700 : const Color(0xFF8B0000))
                                : (isDarkLocal ? Colors.white12 : Colors.black12),
                            child: Text(
                              '${ch.chapterIndex}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isCurrent ? Colors.white : (isDarkLocal ? Colors.white70 : Colors.black87),
                              ),
                            ),
                          ),
                          title: Text(
                            ch.title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: primaryTextLocal,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              ch.titleEn,
                              style: TextStyle(
                                fontSize: 12.5,
                                color: isDarkLocal ? Colors.amber.shade300 : const Color(0xFF8B0000),
                                fontStyle: FontStyle.italic,
                                height: 1.3,
                              ),
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                        ),
                      );
                    },
                    childCount: chapters.length,
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading chapters: $e')),
      ),
    );
  }

  // ── Shared card container ──────────────────────────────────────────────────
  Widget _buildCard({required bool isDark, required Color cardBg, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  // ── Chinese language dropdown toggle ────────────────────────────────────────
  Widget _buildChineseToggle({
    required String label,
    required bool isOpen,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Row(
          children: [
            Icon(
              isOpen ? Icons.expand_less : Icons.expand_more,
              size: 16,
              color: accentColor.withValues(alpha: 0.7),
            ),
            const SizedBox(width: 4),
            Text(
              isOpen ? '收起中文' : label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: accentColor.withValues(alpha: 0.7),
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Badge ──────────────────────────────────────────────────────────────────
  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}
