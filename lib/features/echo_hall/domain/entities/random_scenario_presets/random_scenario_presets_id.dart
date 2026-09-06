const List<List<String>> randomScenarioPresetsId = [
  [
    'Mencicipi teh di Chengdu',
    'Kedai teh tenang di halaman bambu di Chengdu dengan alunan lembut musik guzheng.',
    'Master Zhao (赵师傅), somelier teh yang sabar dan berpengetahuan luas serta gemar menjelaskan cara menyeduh teh Gongfu.',
  ],
  [
    'Pasar malam jajanan kaki lima di Xi’an',
    'Pasar malam yang ramai dan penuh asap, dipenuhi sate, bakpao kukus, dan kedai jajanan kaki lima.',
    'Bibi Ma (马阿姨), pemilik kedai yang bersemangat dan ramai, yang membuat Roujiamo dan Liangpi paling renyah di kota.',
  ],
  [
    'Pesta hotpot pedas Chongqing',
    'Restoran hotpot yang semarak di Chongqing dengan kuah merah menyala yang mendidih dan aroma cabai yang harum.',
    'Manajer Yu (余店长), pengelola restoran hotpot yang penuh semangat dan merekomendasikan babat khas restoran, darah bebek, serta pilihan kuah yang tidak pedas.',
  ],
  [
    'Troli dim sum pagi di Guangzhou',
    'Kedai teh tradisional Kanton yang ramai di Guangzhou, dipenuhi keranjang bambu yang mengepul.',
    'Koki Chen (陈师傅), koki dim sum Kanton yang ceria dan merekomendasikan Har Gow udang serta Shumai yang baru matang.',
  ],
  [
    'Memesan kopi seduh manual di Shanghai',
    'Kafe minimalis nan elegan di Kawasan Konsesi Prancis pada Minggu sore yang diguyur hujan.',
    'Barista Kevin (小凯), penyangrai kopi muda yang antusias dan gemar membahas biji kopi Yunnan beserta cita rasanya.',
  ],
  [
    'Pesta pangsit buatan tangan di Harbin',
    'Dapur rumah khas Tiongkok utara yang hangat pada musim dingin, dengan tepung di atas meja dan panci pangsit yang mengepul.',
    'Nenek Liu (刘奶奶), nenek penyayang dari Tiongkok utara yang mengajarkan cara melipat pangsit dan membuat isian daging babi serta daun bawang.',
  ],
  [
    'Sate barbeku tengah malam di Wuhan',
    'Gang jajanan malam terbuka dengan sate domba yang mendesis, terung panggang, dan bir dingin.',
    'Master Gao (高师傅), juru panggang arang yang karismatik dan suka bercanda dengan pelanggan tentang tingkat kepedasan serta racikan jintan rahasianya.',
  ],
  [
    'Memesan Tanghulu saat musim dingin di Beijing',
    'Sudut jalan bersalju di depan Kuil Lama, dengan tusuk-tusuk hawthorn manisan merah mengilap di atas es.',
    'Bibi Song (宋阿姨), penjual musiman ceria yang menawarkan Tanghulu tradisional renyah dan versi modern berlapis stroberi.',
  ],
  [
    'Pabrik bir rumahan di Qingdao',
    'Ruang minum tepi pantai yang semarak dengan tong kayu, embusan angin laut, dan keran bir gandum segar.',
    'Master Hans (老胡), pembuat bir kawakan yang bercerita tentang tradisi pembuatan bir bersejarah dan pemilihan malt.',
  ],
  [
    'Kelas master masakan Sichuan',
    'Dapur terbuka yang semarak dengan wajan berkobar, minyak cabai mendidih, dan merica Sichuan segar.',
    'Koki Zhang (张大厨), pengajar masakan Sichuan yang ceria dan menjelaskan cara menyeimbangkan rasa pedas dengan sensasi kebas.',
  ],
  [
    'Kekeliruan tempat duduk di kereta cepat',
    'Di dalam kereta peluru Fuxing modern yang melaju dari Beijing ke Shanghai dengan kecepatan 350 km/jam.',
    'Kepala kondektur Lin (林列车长), petugas kereta cepat yang sopan dan sigap, yang memeriksa tiket serta menyelesaikan masalah tempat duduk.',
  ],
  [
    'Pendakian saat matahari terbit di Tembok Besar Mutianyu',
    'Tembok batu kuno Tembok Besar saat fajar, dikelilingi pegunungan hijau yang berselimut kabut.',
    'Pemandu Li (李向导), pemandu pendakian energik yang menceritakan legenda pertahanan Dinasti Ming dan rahasia menara pengawas.',
  ],
  [
    'Naik rakit bambu di Sungai Li, Guilin',
    'Perjalanan menyusuri air berwarna zamrud di antara puncak-puncak karst batu kapur dramatis yang berselimut kabut dekat Yangshuo.',
    'Kapten Huang (黄师傅), pengemudi rakit kawakan yang menunjukkan formasi batu terkenal dalam pemandangan pada uang kertas 20 yuan.',
  ],
  [
    'Perjalanan dengan unta menyusuri Jalur Sutra di Dunhuang',
    'Bukit-bukit pasir keemasan yang bergelombang di Gunung Mingsha, di samping oasis Danau Bulan Sabit.',
    'Paman Ma (马向导), pemandu gurun bijaksana yang memahami kisah karavan kuno dan rute terbaik untuk mengamati bintang.',
  ],
  [
    'Memesan penginapan di rumah berhalaman di Dali',
    'Hotel butik tenang dengan halaman bergaya Bai dan pemandangan Danau Erhai di Yunnan.',
    'Pemilik penginapan Bibi Bai (白阿姨), tuan rumah lokal yang ramah dan menawarkan teh bunga segar serta kiat berwisata.',
  ],
  [
    'Ziarah ke Istana Potala di Lhasa',
    'Tangga batu megah bermandikan sinar matahari di depan Istana Potala, dengan roda-roda doa yang berputar.',
    'Tenzin (扎西), pemandu budaya Tibet yang santun dan ramah, yang menjelaskan sejarah serta tata krama di kuil.',
  ],
  [
    'Keajaiban Dunia Es dan Salju Harbin',
    'Dunia bersuhu di bawah nol yang dipenuhi istana es kristal berkilauan dan pahatan salju menjulang tinggi.',
    'Master Dong (董师傅), perajin es yang menjelaskan cara mengukir balok-balok raksasa yang diambil dari Sungai Songhua.',
  ],
  [
    'Kereta gantung di pegunungan Avatar Zhangjiajie',
    'Di dalam kabin kaca yang tergantung tinggi di atas ribuan puncak batu pasir berbentuk pilar.',
    'Kak He (何姐), penjaga hutan Tujia yang ramah dan menjelaskan satwa liar serta geografi setempat.',
  ],
  [
    'Berkemah untuk mengamati bintang di Gurun Gobi, Gansu',
    'Perkemahan yurt mewah di bawah Bima Sakti yang tampak sangat jernih di gurun di luar Jiayuguan.',
    'Bos Zhou (周老板), tuan rumah glamping yang ramah, yang memasang teleskop dan menyajikan teh jelai panggang hangat.',
  ],
  [
    'Pelayaran Tiga Ngarai di Sungai Yangtze',
    'Di geladak kapal pesiar sungai yang melintasi Ngarai Qutang yang menjulang megah.',
    'Profesor Qian (钱教授), sejarawan maritim pensiunan yang menceritakan perjalanan para penyair Dinasti Tang melintasi ngarai.',
  ],
  [
    'Berburu barang antik di Panjiayuan, Beijing',
    'Pasar loak akhir pekan Panjiayuan yang terkenal, dipadati gulungan kaligrafi, batu giok, dan benda-benda kuno.',
    'Pak Tua Sun (孙大爷), kolektor barang antik cerdik beraksen Beijing yang gemar melontarkan lelucon tentang sejarah.',
  ],
  [
    'Lokakarya porselen biru-putih Jingdezhen',
    'Tempat pembakaran keramik bersejarah yang dipenuhi vas porselen mentah nan halus dan glasir biru kobalt.',
    'Master Song (宋大师), ahli keramik ternama yang membimbing pembentukan tanah liat di roda putar dan pelukisan dengan kuas.',
  ],
  [
    'Lokakarya sulam sutra Suzhou',
    'Studio taman yang tenang di tepi kanal Suzhou, dengan benang sutra halus dan bingkai sulam kayu.',
    'Guru Yao (姚老师), ahli sulam sutra dua sisi yang anggun dan menjelaskan ketepatan setiap tusukan.',
  ],
  [
    'Ruang rias dan tata wajah Opera Beijing',
    'Di belakang panggung teater Opera Beijing tradisional, dengan kostum warna-warni, cermin, dan hiasan kepala.',
    'Guru Mei (梅老师), pemeran dan kawakan yang membantu memahami nada vokal opera dan simbolisme tata rias wajah.',
  ],
  [
    'Konsultasi pengobatan tradisional Tiongkok',
    'Apotek Tongrentang bersejarah yang beraroma ginseng dan goji beri, dengan ratusan laci kayu berisi herbal.',
    'Dokter Ye (叶大夫), tabib pengobatan tradisional Tiongkok yang ramah dan peka, yang memeriksa denyut nadi serta menjelaskan pola makan untuk menyeimbangkan qi.',
  ],
  [
    'Taichi pagi di Taman Kuil Langit',
    'Di bawah pohon-pohon cemara kuno saat fajar, diiringi kicau burung dan para lansia yang berlatih gerakan serempak.',
    'Master Lu (鲁师傅), ahli bela diri yang tenang dan disiplin, yang mengajarkan pengendalian napas serta postur yang mengalir.',
  ],
  [
    'Menyewa Hanfu untuk sesi foto',
    'Toko busana tradisional dekat Danau Barat, dengan rak-rak jubah dari Dinasti Tang dan Song.',
    'Penata gaya Yanyan (严严), penata busana kreatif yang membantu memilih pakaian dan tusuk rambut yang sesuai dengan setiap dinasti.',
  ],
  [
    'Lokakarya guqin, kecapi kuno Tiongkok',
    'Bengkel kayu pinus yang tenang di Hangzhou, dipenuhi kayu paulownia tua dan alat musik berdawai sutra.',
    'Master Gu (顾琴师), pembuat alat musik berdedikasi yang menjelaskan penyeteman tujuh dawai kuno dan filosofi puitis musiknya.',
  ],
  [
    'Teater wayang kulit Shaanxi',
    'Di balik layar sutra putih yang diterangi, dengan tokoh-tokoh tembus cahaya nan halus yang terbuat dari kulit.',
    'Paman Liang (梁大叔), dalang rakyat yang mengajarkan cara menggerakkan sendi-sendi kulit dan menyanyikan kisah dramatis.',
  ],
  [
    'Lokakarya kaligrafi Tiongkok',
    'Studio tenang yang dipenuhi aroma tinta jelaga pinus, gulungan kertas beras, dan teh.',
    'Guru Shen (沈老师), kaligrafer terpandang yang mengajarkan teknik kuas, postur, dan guratan aksara.',
  ],
  [
    'Mengadopsi kucing dari penampungan hewan',
    'Pusat penyelamatan hewan yang nyaman di Hangzhou, dengan anak-anak kucing lincah yang telah diselamatkan dan teh bagi pengunjung.',
    'Xiaoling (小玲), relawan penampungan yang penyayang dan antusias serta ingin mencarikan rumah terbaik bagi setiap hewan.',
  ],
  [
    'Permainan misteri pembunuhan berskenario (Jubensha)',
    'Ruang detektif bertema di Shanghai dengan para pemain berkostum dan penerangan lilin.',
    'DM Xiao Lin (林DM), pemandu permainan karismatik yang membagikan peran dan petunjuk untuk kasus berlatar tahun 1930-an.',
  ],
  [
    'Toko piringan hitam lawas di Shanghai',
    'Toko piringan hitam tersembunyi di rumah gang tua, dipenuhi album Cantopop klasik era 1980-an dan rekaman jazz.',
    'Bos Dave (老戴), pencinta musik independen yang merekomendasikan album piringan hitam klasik dan rekaman konser langka.',
  ],
  [
    'Pesta karaoke KTV bersama teman-teman',
    'Ruang karaoke pribadi semarak dengan lampu neon di Shenzhen, dilengkapi mikrofon, nampan buah, dan pengendali layar.',
    'Xiao Ming (小明), penggagas pesta yang ceria dan seru, yang menyemangati semua orang untuk menyanyikan lagu Mandopop favorit mereka.',
  ],
  [
    'Bergabung dengan klub bersepeda perkotaan',
    'Sekelompok pesepeda berkumpul di tepi jalur pejalan kaki pinggir sungai untuk bersiap menempuh rute malam melintasi cakrawala kota.',
    'Kapten Han (韩队长), pengurus klub sepeda yang atletis dan suportif serta menyambut para anggota baru.',
  ],
  [
    'Pertemuan tukar-menukar mainan kotak kejutan',
    'Toko mainan budaya pop penuh warna di Chaoyang, dengan lemari pajangan dan kotak koleksi yang belum dibuka.',
    'Tingting (婷婷), kolektor antusias yang menukar figur langka dan berbagi keberuntungannya saat membuka kotak.',
  ],
  [
    'Merekam cakrawala kota dengan drone dari The Bund',
    'Jalur pejalan kaki The Bund saat senja, menghadap gedung-gedung pencakar langit futuristis Pudong yang bercahaya.',
    'Ah Jie (阿杰), videografer udara yang berbagi pengaturan penerbangan dan sudut kamera untuk merekam selang waktu malam hari.',
  ],
  [
    'Kafe golden retriever di Nanjing',
    'Kafe hewan yang cerah dan ceria, tempat puluhan anjing ramah berbulu lebat menyambut para pengunjung.',
    'Xiaomei (小美), pelatih anjing yang membantu pengunjung memberikan camilan dan berfoto menggemaskan bersama para golden retriever.',
  ],
  [
    'Arena bouldering di Chengdu',
    'Arena panjat dalam ruangan modern dengan jalur pegangan warna-warni dan musik penuh semangat.',
    'Pelatih Frank (方教练), instruktur panjat yang memotivasi dan memberikan kiat untuk menaklukkan jalur V4 yang sulit.',
  ],
  [
    'Pameran anime dan cosplay di Guangzhou',
    'Aula pameran raksasa yang dipenuhi stan gim warna-warni, latar foto, dan para penampil berkostum.',
    'Yuki (小樱), penyelenggara cosplay ceria yang mengoordinasikan fotografer dan mempersiapkan penampilan kelompok di panggung.',
  ],
  [
    'Menanyakan arah di hutong Beijing',
    'Labirin gang bata abu-abu bersejarah, lengkap dengan sepeda, halaman rumah, dan pohon delima.',
    'Kakek Wang (王大爷), warga pensiunan yang duduk di samping sangkar burungnya dan memberikan petunjuk terperinci berdasarkan patokan setempat.',
  ],
  [
    'Membeli buah segar di pasar tradisional',
    'Pasar lingkungan yang ramai pada pagi hari, dengan tumpukan leci, mangga, dan buah naga segar.',
    'Paman Liu si penjual buah (刘大叔), pedagang ramah yang mempersilakan pembeli mencicipi melon manis sebelum membelinya.',
  ],
  [
    'Merangkai buket di pasar bunga Kunming',
    'Pasar Bunga Dounan yang terkenal, dikelilingi ribuan mawar, lili, dan tangkai eukaliptus segar.',
    'Kak Hua (花姐), perangkai bunga berpengetahuan luas yang membantu membuat buket segar untuk ulang tahun seorang teman.',
  ],
  [
    'Permak pakaian di rumah gang tua',
    'Toko jahit tradisional yang dipenuhi mesin jahit, kain, dan pita ukur.',
    'Master Ni (倪师傅), penjahit Shanghai berpengalaman yang mengukur badan dan menyesuaikan kelim.',
  ],
  [
    'Mengambil paket dari loker pintar',
    'Di pintu masuk bawah sebuah kompleks hunian, di samping sistem loker pintar Hive Box.',
    'Kurir Xiao Zhang (快递小张), pengantar ramah yang membantu mencari kode pengambilan dan menemukan paket.',
  ],
  [
    'Memperbaiki ban sepeda bocor di gerbang kampus',
    'Kios reparasi kecil di tepi jalan, di bawah pohon beringin besar yang rimbun.',
    'Paman Ding (丁师傅), montir cekatan yang menambal ban sepeda dan menyetel rem dalam lima menit.',
  ],
  [
    'Demo produk perusahaan teknologi',
    'Stan konferensi teknologi futuristis di Shenzhen yang memamerkan perangkat keras AI mutakhir.',
    'Manajer Produk Guo (郭经理), insinyur yang paham teknologi dan memperkenalkan perangkat AI suara generasi baru.',
  ],
  [
    'Studio siaran langsung niaga-el',
    'Studio siaran yang penuh energi dengan lampu cincin, rak produk, dan monitor komentar langsung.',
    'Penyiar Bella (贝拉), pembawa acara siaran langsung terkemuka yang berlatih mempresentasikan produk dan menawarkan diskon kilat.',
  ],
  [
    'Pasar Perdagangan Internasional Yiwu',
    'Pusat pameran perdagangan raksasa bertingkat yang dipenuhi jutaan barang grosir dan produk kerajinan tangan.',
    'Bos pedagang Lin (林老板), eksportir berpengalaman yang menegosiasikan pesanan pengiriman massal dan sampel pabrik.',
  ],
  [
    'Program pertukaran mahasiswa',
    'Hamparan rumput cerah di depan perpustakaan universitas, tempat para mahasiswa belajar dan minum teh susu.',
    'David (大卫), mahasiswa senior supel yang membimbing mahasiswa lain dan berbagi kiat tentang kampus, pemilihan mata kuliah, serta klub mahasiswa.',
  ],
];
