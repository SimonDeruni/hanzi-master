const List<List<String>> randomScenarioPresetsIt = [
  [
    'Degustazione di tè a Chengdu',
    'Una tranquilla casa da tè con un cortile di bambù a Chengdu, accompagnata da una dolce melodia di guzheng.',
    'Maestro Zhao (赵师傅), un paziente ed esperto sommelier del tè che ama spiegare la preparazione del tè Gongfu.',
  ],
  [
    'Mercato notturno dello street food a Xi’an',
    'Un vivace mercato notturno avvolto dal fumo, pieno di spiedini, panini al vapore e bancarelle di street food.',
    'Zia Ma (马阿姨), un’energica e chiassosa venditrice che prepara i Roujiamo e i Liangpi più croccanti della città.',
  ],
  [
    'Banchetto di hotpot piccante di Chongqing',
    'Un animato ristorante di hotpot a Chongqing, con brodo rosso scarlatto in ebollizione e un fragrante aroma di peperoncino.',
    'Direttrice Yu (余店长), un’energica responsabile di un ristorante di hotpot che consiglia la trippa della casa, il sangue d’anatra e le varianti di brodo non piccante.',
  ],
  [
    'Carrello mattutino di dim sum a Guangzhou',
    'Una vivace casa da tè tradizionale cantonese a Guangzhou, piena di cestelli di bambù fumanti.',
    'Chef Chen (陈师傅), un allegro cuoco cantonese specializzato in dim sum che consiglia Har Gow ai gamberi appena fatti e Shumai.',
  ],
  [
    'Ordinare un caffè preparato a mano a Shanghai',
    'Un elegante caffè minimalista nella Concessione francese durante un piovoso pomeriggio domenicale.',
    'Barista Kevin (小凯), un giovane torrefattore appassionato che ama parlare dei chicchi di caffè dello Yunnan e delle loro note aromatiche.',
  ],
  [
    'Banchetto di ravioli fatti a mano a Harbin',
    'Un’accogliente cucina domestica della Cina settentrionale in inverno, con farina sul tavolo e pentole di ravioli fumanti.',
    'Nonna Liu (刘奶奶), un’affettuosa nonna del Nord che insegna a pieghettare i ravioli e a preparare il ripieno di maiale e cipollotto.',
  ],
  [
    'Spiedini alla griglia di mezzanotte a Wuhan',
    'Un vicolo all’aperto dedicato al cibo notturno, con spiedini d’agnello sfrigolanti, melanzane arrostite e birra fresca.',
    'Maestro Gao (高师傅), un carismatico grigliatore che scherza con i clienti sul grado di piccantezza e sulle sue marinature segrete al cumino.',
  ],
  [
    'Ordinare Tanghulu nella Pechino invernale',
    'Un angolo di strada innevato davanti al Tempio dei Lama, con lucenti spiedini rossi di biancospino candito sul ghiaccio.',
    'Zia Song (宋阿姨), un’allegra venditrice stagionale che offre croccanti Tanghulu tradizionali e una moderna variante glassata alla fragola.',
  ],
  [
    'Birrificio artigianale a Qingdao',
    'Un’animata birreria sulla costa, con botti di legno, brezza marina e spine di birra di frumento appena prodotta.',
    'Maestro Hans (老胡), un esperto mastro birraio che racconta storie sulle antiche tradizioni brassicole e sulla selezione del malto.',
  ],
  [
    'Masterclass di cucina del Sichuan',
    'Una vivace cucina a vista con wok fiammeggianti, olio al peperoncino che sobbolle e grani freschi di pepe del Sichuan.',
    'Chef Zhang (张大厨), un allegro insegnante di cucina del Sichuan che spiega come equilibrare piccantezza ed effetto anestetizzante.',
  ],
  [
    'Confusione con i posti sul treno ad alta velocità',
    'A bordo di un moderno treno ad alta velocità Fuxing che viaggia da Pechino a Shanghai a 350 km/h.',
    'Capotreno Lin (林列车长), un cortese e disponibile responsabile del treno ad alta velocità che controlla i biglietti e risolve i problemi con i posti.',
  ],
  [
    'Escursione all’alba sulla Grande Muraglia a Mutianyu',
    'Le antiche mura di pietra della Grande Muraglia all’alba, circondate da verdi montagne avvolte nella nebbia.',
    'Guida Li (李向导), un’energica guida escursionistica che racconta le leggende sulle difese della dinastia Ming e i segreti delle torri di guardia.',
  ],
  [
    'Discesa del fiume Li su una zattera di bambù a Guilin',
    'Un viaggio su acque color smeraldo tra spettacolari picchi carsici calcarei avvolti dalla nebbia nei pressi di Yangshuo.',
    'Capitano Huang (黄师傅), un esperto barcaiolo che indica le celebri formazioni rocciose raffigurate sulla banconota da 20 yuan.',
  ],
  [
    'Escursione in cammello sulla Via della Seta a Dunhuang',
    'Le ondulate dune dorate del monte Mingsha, accanto all’oasi del lago della Mezzaluna.',
    'Zio Ma (马向导), una saggia guida del deserto che conosce antichi racconti sulle carovane e itinerari per osservare le stelle.',
  ],
  [
    'Prenotare un alloggio in una casa con cortile a Dali',
    'Un tranquillo boutique hotel con cortile in stile bai e vista sul lago Erhai, nello Yunnan.',
    'Locandiera zia Bai (白阿姨), un’ospitale padrona di casa del luogo che offre tisane ai fiori freschi e consigli turistici.',
  ],
  [
    'Pellegrinaggio al palazzo del Potala a Lhasa',
    'Le maestose scalinate di pietra illuminate dal sole davanti al palazzo del Potala, con ruote di preghiera che girano.',
    'Tenzin (扎西), una rispettosa e cordiale guida culturale tibetana che spiega la storia e le regole di comportamento nel tempio.',
  ],
  [
    'Meraviglie del Mondo di ghiaccio e neve di Harbin',
    'Un mondo sottozero di scintillanti palazzi di ghiaccio cristallino e imponenti sculture di neve.',
    'Maestro Dong (董师傅), un artigiano del ghiaccio che spiega come vengono scolpiti gli enormi blocchi estratti dal fiume Songhua.',
  ],
  [
    'Funivia sulle montagne di Avatar a Zhangjiajie',
    'In una cabina di vetro sospesa molto in alto sopra migliaia di picchi d’arenaria a forma di pilastro.',
    'Responsabile He (何姐), una gentile guardaparco tujia che illustra la fauna e la geografia locali.',
  ],
  [
    'Campeggio per osservare le stelle nel deserto del Gobi, nel Gansu',
    'Un lussuoso accampamento di yurte sotto una Via Lattea nitidissima, nel deserto alle porte di Jiayuguan.',
    'Titolare Zhou (周老板), un cordiale gestore di glamping che prepara i telescopi e serve tè caldo d’orzo tostato.',
  ],
  [
    'Crociera nelle Tre Gole del fiume Yangtze',
    'Sul ponte di una nave da crociera fluviale che attraversa l’imponente gola di Qutang.',
    'Professor Qian (钱教授), uno storico della navigazione in pensione che racconta i viaggi dei poeti della dinastia Tang attraverso le gole.',
  ],
  [
    'Caccia alle antichità a Panjiayuan, Pechino',
    'Il famoso mercato delle pulci del fine settimana di Panjiayuan, affollato di rotoli calligrafici, giada e oggetti antichi.',
    'Signor Sun (孙大爷), un perspicace collezionista di antichità dall’accento pechinese che ama scherzare sulla storia.',
  ],
  [
    'Laboratorio di porcellana bianca e blu a Jingdezhen',
    'Un’antica fornace di ceramica piena di delicati vasi di porcellana non cotti e smalti blu cobalto.',
    'Maestro Song (宋大师), un rinomato ceramista che guida nella modellazione dell’argilla al tornio e nella pittura a pennello.',
  ],
  [
    'Laboratorio di ricamo su seta a Suzhou',
    'Un tranquillo laboratorio con giardino accanto a un canale di Suzhou, con sottili fili di seta e telai di legno.',
    'Insegnante Yao (姚老师), un’elegante maestra del ricamo su seta a doppia faccia che spiega la precisione dei punti.',
  ],
  [
    'Trucco e camerino dell’Opera di Pechino',
    'Dietro le quinte di un teatro tradizionale dell’Opera di Pechino, con costumi variopinti, specchi e copricapi.',
    'Insegnante Mei (梅老师), una veterana interprete di ruoli dan che aiuta a comprendere il tono vocale dell’opera e il simbolismo del trucco facciale.',
  ],
  [
    'Consulto di medicina tradizionale cinese',
    'Una storica farmacia Tongrentang profumata di ginseng e bacche di goji, con centinaia di cassetti di legno per le erbe.',
    'Dottor Ye (叶大夫), un gentile e perspicace medico di medicina tradizionale cinese che misura il polso e spiega una dieta equilibrata per il qi.',
  ],
  [
    'Tai chi mattutino nel parco del Tempio del Cielo',
    'Sotto antichi cipressi all’alba, tra il canto degli uccelli e anziani che eseguono movimenti sincronizzati.',
    'Maestro Lu (鲁师傅), un sereno e disciplinato artista marziale che insegna a controllare la respirazione e a mantenere una postura fluida.',
  ],
  [
    'Noleggiare un Hanfu per un servizio fotografico',
    'Un negozio di abiti tradizionali vicino al Lago dell’Ovest, con appendiabiti colmi di vesti delle dinastie Tang e Song.',
    'Stilista Yanyan (严严), una creativa stilista di moda che aiuta a scegliere gli abiti e le forcine adatti a ciascuna dinastia.',
  ],
  [
    'Laboratorio di guqin, l’antica cetra cinese',
    'Un tranquillo laboratorio in legno di pino a Hangzhou, pieno di paulonia stagionata e strumenti con corde di seta.',
    'Maestro Gu (顾琴师), un liutaio appassionato che spiega l’antica accordatura a sette corde e la filosofia poetica della musica.',
  ],
  [
    'Teatro delle ombre dello Shaanxi',
    'Dietro uno schermo illuminato di seta bianca, con delicate figure traslucide di cuoio.',
    'Zio Liang (梁大叔), un burattinaio popolare che insegna a muovere le articolazioni di cuoio e a cantare racconti drammatici.',
  ],
  [
    'Laboratorio di calligrafia cinese',
    'Uno studio sereno pervaso dal profumo dell’inchiostro di nerofumo di pino, dei rotoli di carta di riso e del tè.',
    'Maestro Shen (沈老师), un rispettato calligrafo che insegna la tecnica del pennello, la postura e i tratti dei caratteri.',
  ],
  [
    'Adottare un gatto in un rifugio per animali',
    'Un accogliente centro di soccorso per animali a Hangzhou, con vivaci gattini salvati e tè per i visitatori.',
    'Xiaoling (小玲), un’affettuosa ed entusiasta volontaria del rifugio che desidera trovare la casa migliore per ogni animale.',
  ],
  [
    'Partita a un giallo con copione (Jubensha)',
    'Un salone a tema investigativo a Shanghai, con partecipanti in costume e illuminazione a lume di candela.',
    'DM Xiao Lin (林DM), un carismatico game master che assegna i ruoli e fornisce indizi per un caso ambientato negli anni Trenta.',
  ],
  [
    'Negozio di vecchi dischi in vinile a Shanghai',
    'Un negozio di vinili nascosto in una vecchia casa di vicolo, pieno di classici cantopop degli anni Ottanta e dischi jazz.',
    'Titolare Dave (老戴), un appassionato di musica indipendente che consiglia classici album in vinile e rare registrazioni di concerti.',
  ],
  [
    'Serata karaoke KTV con gli amici',
    'Una vivace sala karaoke privata illuminata al neon a Shenzhen, con microfoni, vassoi di frutta e comandi su schermo.',
    'Xiao Ming (小明), un allegro e divertente organizzatore di feste che incoraggia tutti a cantare i propri brani mandopop preferiti.',
  ],
  [
    'Entrare in un club di ciclismo urbano',
    'Un gruppo di ciclisti si ritrova vicino alla passeggiata sul fiume per preparare un giro notturno attraverso lo skyline cittadino.',
    'Capitano Han (韩队长), un atletico e incoraggiante organizzatore del club ciclistico che accoglie i nuovi membri.',
  ],
  [
    'Incontro per scambiarsi giocattoli in scatole a sorpresa',
    'Un colorato negozio di giocattoli della cultura pop a Chaoyang, con vetrine e scatole da collezione ancora sigillate.',
    'Tingting (婷婷), un’entusiasta collezionista che scambia statuette rare e racconta la propria fortuna nell’aprire le scatole.',
  ],
  [
    'Riprendere con un drone lo skyline dal Bund',
    'La passeggiata del Bund al crepuscolo, di fronte ai futuristici grattacieli illuminati di Pudong.',
    'Ah Jie (阿杰), un videomaker aereo che condivide impostazioni di volo e angolazioni della telecamera per riprese notturne in time-lapse.',
  ],
  [
    'Caffè dei golden retriever a Nanchino',
    'Un luminoso e allegro caffè con animali, dove decine di cani amichevoli e soffici accolgono i visitatori.',
    'Xiaomei (小美), un’addestratrice cinofila che aiuta i visitatori a dare bocconcini ai cani e a scattare adorabili foto con i golden retriever.',
  ],
  [
    'Palestra di bouldering a Chengdu',
    'Una moderna palestra di arrampicata al coperto con percorsi dalle prese colorate e musica energica.',
    'Allenatore Frank (方教练), un motivante istruttore di arrampicata che dà consigli per superare un difficile percorso V4.',
  ],
  [
    'Fiera di anime e cosplay a Guangzhou',
    'Un enorme padiglione fieristico pieno di colorati stand di videogiochi, fondali fotografici e artisti in costume.',
    'Yuki (小樱), un’allegra organizzatrice di cosplay che coordina i fotografi e prepara esibizioni di gruppo sul palco.',
  ],
  [
    'Chiedere indicazioni in un hutong di Pechino',
    'Un labirinto di storici vicoli in mattoni grigi, con biciclette, cortili e alberi di melograno.',
    'Nonno Wang (王大爷), un residente in pensione seduto accanto alla sua gabbia per uccelli che fornisce indicazioni dettagliate usando punti di riferimento locali.',
  ],
  [
    'Comprare frutta fresca in un mercato alimentare',
    'Un vivace mercato di quartiere al mattino, con pile di litchi, manghi e frutti del drago freschi.',
    'Venditore zio Liu (刘大叔), un gentile fruttivendolo che fa assaggiare i meloni dolci prima dell’acquisto.',
  ],
  [
    'Comporre un bouquet al mercato dei fiori di Kunming',
    'Il famoso mercato dei fiori di Dounan, circondato da migliaia di rose, gigli e steli freschi di eucalipto.',
    'Sorella Hua (花姐), un’esperta fioraia che aiuta a comporre un bouquet fresco per il compleanno di un amico.',
  ],
  [
    'Modifiche sartoriali in una vecchia casa di vicolo',
    'Una sartoria tradizionale piena di macchine da cucire, tessuti e metri a nastro.',
    'Maestro Ni (倪师傅), un esperto sarto di Shanghai che prende le misure e sistema gli orli.',
  ],
  [
    'Ritirare un pacco da un armadietto intelligente',
    'All’ingresso di un edificio residenziale, accanto a un sistema di armadietti intelligenti Hive Box.',
    'Corriere Xiao Zhang (快递小张), un gentile fattorino che aiuta a verificare i codici di ritiro e a trovare i pacchi.',
  ],
  [
    'Riparare una gomma forata della bicicletta all’ingresso del campus',
    'Una piccola postazione di riparazione all’aperto sul ciglio della strada, sotto un rigoglioso baniano.',
    'Zio Ding (丁师傅), un meccanico veloce che ripara le forature e regola i freni delle biciclette in cinque minuti.',
  ],
  [
    'Dimostrazione di prodotto di un’azienda tecnologica',
    'Uno stand futuristico a una conferenza tecnologica di Shenzhen che presenta hardware di IA all’avanguardia.',
    'Product manager Guo (郭经理), un ingegnere esperto di tecnologia che presenta dispositivi di IA vocale di nuova generazione.',
  ],
  [
    'Studio di live streaming per l’e-commerce',
    'Un dinamico studio di trasmissione con ring light, espositori di prodotti e monitor per i commenti in diretta.',
    'Streamer Bella (贝拉), una celebre conduttrice di live streaming che prova presentazioni di prodotti e sconti lampo.',
  ],
  [
    'Mercato del commercio internazionale di Yiwu',
    'Un enorme centro espositivo commerciale su più piani, pieno di milioni di articoli all’ingrosso e prodotti artigianali.',
    'Commerciante Lin (林老板), un esperto esportatore che negozia ordini di spedizioni all’ingrosso e campioni di fabbrica.',
  ],
  [
    'Programma di scambio universitario',
    'Un prato soleggiato davanti alla biblioteca universitaria, con studenti che studiano e bevono tè al latte.',
    'David (大卫), un estroverso studente dell’ultimo anno che fa da mentore e condivide consigli sul campus, sull’iscrizione ai corsi e sulle attività dei club.',
  ],
];
