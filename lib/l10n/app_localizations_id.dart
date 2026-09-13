// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get originStoryChip => '📜 Asal-usul';

  @override
  String get ancientFormChip => '🏺 Bentuk kuno';

  @override
  String get threeMoreWordsChip => '📖 3 kata lagi';

  @override
  String get wordFamilyChip => '🔗 Rumpun kata';

  @override
  String get idiomChip => '🀄 Idiom';

  @override
  String get proverbChip => '💬 Peribahasa';

  @override
  String get isThereAChineseIdiomFeaturingThisCharacter =>
      'Apakah ada idiom Tionghoa (成语) yang mengandung karakter ini?';

  @override
  String get strokeOrderChip => '✏️ Urutan goresan';

  @override
  String get calligraphyTipChip => '🎨 Tips kaligrafi';

  @override
  String get grammarNoteChip => '📝 Catatan tata bahasa';

  @override
  String get similarWordsChip => '🔄 Kata serupa';

  @override
  String get culturalNoteChip => '🏮 Catatan budaya';

  @override
  String get inMediaChip => '🀄 Dalam media';

  @override
  String get radicalMeaningChip => '🧩 Arti radikal';

  @override
  String get componentBreakdownChip => '🔍 Rincian komponen';

  @override
  String get toneTipChip => '🎵 Tips nada';

  @override
  String get homophonesChip => '👯 Homofon';

  @override
  String askMeAnythingAbout(String hanzi) {
    return 'Tanyakan apa saja tentang $hanzi...';
  }

  @override
  String aiTutorError(String error) {
    return 'Kesalahan tutor AI: $error';
  }

  @override
  String get aiTutorRateLimit =>
      'Tutor AI sedang sibuk saat ini. Harap tunggu sebentar dan coba lagi.';

  @override
  String get deleteAccount => 'Hapus Akun';

  @override
  String get deleteAccountSubtitle => 'Hapus akun Anda secara permanen';

  @override
  String get deleteAccountTitle => 'Hapus akun Anda secara permanen?';

  @override
  String get accountDataDeletedTitle => 'Data akun akan dihapus';

  @override
  String get accountDataDeletedBody =>
      'Akun masuk dan informasi akun Anda yang disimpan oleh SinoSpark akan dihapus secara permanen. Tindakan ini tidak dapat dibatalkan.';

  @override
  String get localDataKeptTitle => 'Data di perangkat ini akan tetap ada';

  @override
  String get localDataKeptBody =>
      'Progres belajar, konten yang diunduh, dan preferensi yang hanya disimpan di perangkat ini tidak akan dihapus.';

  @override
  String get subscriptionNotCanceledTitle => 'Langganan tidak dibatalkan';

  @override
  String get subscriptionNotCanceledBody =>
      'Menghapus akun Anda tidak membatalkan langganan App Store. Langganan dapat terus diperpanjang hingga Anda membatalkannya melalui Apple.';

  @override
  String get manageSubscription => 'Kelola Langganan App Store';

  @override
  String get subscriptionManagementFailed =>
      'Tidak dapat membuka manajemen langganan Apple. Buka Pengaturan, ketuk nama Anda, lalu ketuk Langganan.';

  @override
  String get confirmPassword => 'Kata sandi saat ini';

  @override
  String get confirmPasswordToDelete =>
      'Masukkan kata sandi Anda untuk mengonfirmasi identitas Anda.';

  @override
  String get deleteAccountPermanently => 'Hapus Akun Secara Permanen';

  @override
  String get deleteAccountFinalTitle => 'Konfirmasi akhir';

  @override
  String get deleteAccountFinalWarning =>
      'Ini akan menghapus akun Anda secara permanen dan tidak dapat dibatalkan. Data yang hanya disimpan di perangkat ini akan tetap ada. Lanjutkan?';

  @override
  String get deletingAccount => 'Menghapus akun...';

  @override
  String get accountPasswordRequired =>
      'Masukkan kata sandi Anda saat ini untuk melanjutkan.';

  @override
  String get accountPasswordIncorrect => 'Kata sandi salah. Silakan coba lagi.';

  @override
  String get accountReauthenticationCanceled =>
      'Konfirmasi identitas dibatalkan. Akun Anda tidak dihapus.';

  @override
  String get accountReauthenticationFailed =>
      'Kami tidak dapat mengonfirmasi identitas Anda. Silakan coba lagi dan selesaikan petunjuk masuk.';

  @override
  String get accountAlreadySignedOut =>
      'Anda sudah keluar. Tidak ada akun masuk yang dihapus.';

  @override
  String get accountProviderUnsupported =>
      'Metode masuk ini tidak dapat diverifikasi di aplikasi. Hubungi dukungan untuk bantuan menghapus akun.';

  @override
  String get appleDeletionRequiresAppleDevice =>
      'Demi keamanan, akun yang ditautkan ke Apple harus dihapus di perangkat Apple.';

  @override
  String get accountDeletionNetworkError =>
      'Periksa koneksi internet Anda dan coba hapus akun lagi.';

  @override
  String get accountDeletionFailed =>
      'Akun tidak dapat dihapus. Akun Anda tetap aktif. Silakan coba lagi.';

  @override
  String get accountDeletedSuccessfully =>
      'Akun Anda telah berhasil dihapus secara permanen.';

  @override
  String get globalMastery => 'PENGUASAAN GLOBAL';

  @override
  String get masteredCards => 'Dikuasai';

  @override
  String get hsk1Candidate => 'Kandidat HSK 1';

  @override
  String get hsk2Candidate => 'Kandidat HSK 2';

  @override
  String get hsk3Candidate => 'Kandidat HSK 3';

  @override
  String get hsk4Candidate => 'Kandidat HSK 4';

  @override
  String get hsk5Candidate => 'Kandidat HSK 5';

  @override
  String get hsk6Candidate => 'Kandidat HSK 6';

  @override
  String get hsk6Master => 'Master HSK 6';

  @override
  String get currentRank => 'PERINGKAT SAAT INI';

  @override
  String get next => 'Berikutnya';

  @override
  String get searchHanziOrPinyin => 'Cari Hanzi atau Pinyin...';

  @override
  String get dailyReview => 'Ulasan Harian';

  @override
  String get upcomingForecast => 'Prakiraan Mendatang';

  @override
  String get laterToday => 'Nanti Hari Ini';

  @override
  String get tomorrow => 'Besok';

  @override
  String get next7Days => '7 Hari Ke Depan';

  @override
  String get theScholarWay => 'Jalan Cendekiawan';

  @override
  String get beginJourney => 'Mulai Perjalanan';

  @override
  String get settingsTitle => 'Pengaturan';

  @override
  String get darkMode => 'Mode Gelap';

  @override
  String get darkModeDesc => 'Nyaman di mata';

  @override
  String get voiceSpeed => 'Kecepatan Suara';

  @override
  String get artAndIntellect => 'SENI & INTELEK';

  @override
  String get theDigitalScholar => 'Cendekiawan Digital';

  @override
  String get refineBrushVoice =>
      'Sempurnakan kuas dan pengucapan Anda dengan AI.';

  @override
  String get liveVoiceCall => 'Panggilan Suara Langsung';

  @override
  String get immersiveRoleplay => 'Roleplay Imersif dengan Avatar AI';

  @override
  String get readingRoom => 'Ruang Baca';

  @override
  String get shadowingStudio => 'Studio Shadowing';

  @override
  String get errorPrefix => 'Kesalahan: ';

  @override
  String get initializingLibrary => 'Memulai perpustakaan...';

  @override
  String get unlockCharactersToQuiz => 'Buka 4 karakter untuk kuis!';

  @override
  String get practiceQuiz => 'KUIS';

  @override
  String get curriculumPaths => 'JALUR PEMBELAJARAN';

  @override
  String get noDecksFound => 'Tidak ada dek. Tambahkan beberapa!';

  @override
  String get addCardsFirst => 'Tambahkan kartu terlebih dahulu!';

  @override
  String get aiDraftingPath => 'AI sedang menyiapkan jalur Anda...';

  @override
  String get pathReady => 'Jalur siap!';

  @override
  String get errorGeneratingPath => 'Gagal membuat jalur';

  @override
  String get brushingCurriculum => 'Membuat kurikulum...';

  @override
  String get warmUp => 'PEMANASAN';

  @override
  String get lessonComplete => 'Pelajaran Selesai! +10 Poin Tinta';

  @override
  String get step1Origin => 'LANGKAH 1: ASAL USUL';

  @override
  String get traceRadical => 'Tebalkan Radikal';

  @override
  String get step2Forge => 'LANGKAH 2: PENEMPAAN';

  @override
  String get chooseEssence => 'Pilih Intisari';

  @override
  String get wrongEssence => 'Salah! Coba lagi.';

  @override
  String get step3Hunt => 'LANGKAH 3: PERBURUAN';

  @override
  String get findCharacters => 'Temukan karakter';

  @override
  String get notThatOne => 'Bukan yang itu!';

  @override
  String get successfullyInstalled => 'Berhasil diinstal:';

  @override
  String get failedToDownload => 'Gagal mengunduh.';

  @override
  String get rescindTitle => 'Batalkan?';

  @override
  String get removeCharactersWarning =>
      'Ini akan menghapus karakter-karakter ini.';

  @override
  String get cancel => 'Batal';

  @override
  String get uninstall => 'Copot pemasangan';

  @override
  String get removedLibrary => 'Dihapus:';

  @override
  String get tomeLibrary => 'Perpustakaan Buku';

  @override
  String get libraryError => 'Kesalahan Perpustakaan';

  @override
  String get installTome => 'INSTAL';

  @override
  String get unitIntro => 'INTRO UNIT';

  @override
  String get constellationCluster => 'Gugus Konstelasi';

  @override
  String get ok => 'OKE';

  @override
  String get divingInto => 'Menyelami...';

  @override
  String get keyRadicals => 'RADIKAL UTAMA';

  @override
  String get noRadicalData => 'Tidak ada data.';

  @override
  String get discovery => 'PENEMUAN';

  @override
  String get startLearning => 'MULAI BELAJAR';

  @override
  String get selectPersona => 'Pilih Persona';

  @override
  String get customPersona => 'Persona Kustom';

  @override
  String get geminiLiveCall => 'PANGGILAN LANGSUNG';

  @override
  String get returnToMenu => 'Kembali ke Menu';

  @override
  String get strokeAnalysis => 'Analisis Urutan Goresan';

  @override
  String get excellentWork => 'Kerja luar biasa!';

  @override
  String get keepPracticing => 'Teruslah berlatih!';

  @override
  String get drawingSubmitted => 'Gambar Dikirim';

  @override
  String get customPersonaHint => 'Tentukan persona kustom...';

  @override
  String get stepOneOrigin => 'LANGKAH 1: ASAL USUL';

  @override
  String get stepTwoForge => 'LANGKAH 2: PENEMPAAN';

  @override
  String get toForge => 'Untuk menempa';

  @override
  String get whatEssenceDoesNeed => 'intisari apa yang dibutuhkan';

  @override
  String get need => 'dibutuhkan';

  @override
  String get forged => 'DITEMPA';

  @override
  String get stepThreeHunt => 'LANGKAH 3: PERBURUAN';

  @override
  String get findCharactersWith => 'Temukan karakter dengan';

  @override
  String get uninstallButton => 'COPOT PEMASANGAN';

  @override
  String get gradedAiStories => 'Cerita AI Berjenjang';

  @override
  String get calligraphy => 'Kaligrafi';

  @override
  String get theScrollOfOrigin => 'Gulungan Asal Usul';

  @override
  String get galaxyOf => 'Galaksi';

  @override
  String get constellationDescription => 'Deskripsi Konstelasi';

  @override
  String get noRadicalDataAvailable => 'Tidak Ada Data Radikal yang Tersedia';

  @override
  String get learningPreferences => 'Preferensi Belajar';

  @override
  String get hardMode => 'Mode Sulit';

  @override
  String get hardModeDesc =>
      'Memerlukan input presisi tanpa bantuan panduan visual.';

  @override
  String get adaptiveGuidance => 'Panduan Adaptif';

  @override
  String get dailyGoal => 'Target Harian';

  @override
  String get audioAndHaptics => 'Audio dan Haptik';

  @override
  String get autoPlayAudio => 'Putar Audio Otomatis';

  @override
  String get autoPlayDesc =>
      'Putar pengucapan secara otomatis saat kartu dibuka.';

  @override
  String get haptics => 'Umpan Balik Haptik';

  @override
  String get displayAndContent => 'Tampilan dan Konten';

  @override
  String get useEnglishDefinitions => 'Gunakan definisi bahasa Inggris';

  @override
  String get useEnglishDefinitionsDesc =>
      'Definisi bahasa Inggris umumnya lebih akurat dan terperinci';

  @override
  String get animationSpeed => 'Kecepatan Animasi';

  @override
  String get manageTomes => 'Kelola Buku';

  @override
  String get manageTomesDesc =>
      'Kelola materi dan buku pembelajaran yang terinstal.';

  @override
  String get dangerZone => 'Zona Berbahaya';

  @override
  String get resetAllData => 'Setel Ulang Semua Data';

  @override
  String get resetDataDesc =>
      'Ini akan menghapus semua data progres, statistik, dan pengaturan Anda secara permanen. Tindakan ini tidak dapat dibatalkan.';

  @override
  String get areYouSure => 'Apakah Anda yakin?';

  @override
  String get cannotBeUndone => 'Tidak dapat dibatalkan';

  @override
  String get deleteEverything => 'Hapus Semuanya';

  @override
  String get appLanguage => 'Bahasa Aplikasi';

  @override
  String get howDidYouDo => 'Bagaimana hasil belajarmu?';

  @override
  String get missedItEntirely => 'Lupa sama sekali';

  @override
  String get gotItButStruggled => 'Ingat, tapi kesulitan';

  @override
  String get gotItClearly => 'Ingat dengan jelas';

  @override
  String get perfectAndImmediate => 'Sempurna dan langsung ingat';

  @override
  String get again => 'Ulangi';

  @override
  String get hard => 'Sulit';

  @override
  String get good => 'Bagus';

  @override
  String get easy => 'Mudah';

  @override
  String get tapToReveal => 'Ketuk untuk membuka';

  @override
  String get howWellDidYouRemember => 'Seberapa baik Anda mengingatnya?';

  @override
  String get completelyForgot => 'Lupa total';

  @override
  String get gotItWithDifficulty => 'Mengingat dengan susah payah';

  @override
  String get recalledCorrectly => 'Teringat dengan benar';

  @override
  String get perfectRecall => 'Ingatan sempurna';

  @override
  String get practiceWriting => 'Latihan Menulis';

  @override
  String get hideScratchpad => 'Sembunyikan papan coretan';

  @override
  String get whatCharacterMeans => 'Arti karakter:';

  @override
  String get tapCardToReveal => 'Ketuk kartu untuk melihat';

  @override
  String get ratePronunciationConfidence =>
      'Nilai tingkat percaya diri pengucapan Anda';

  @override
  String get botchedIt => 'Sangat tidak tepat';

  @override
  String get struggledWithTones => 'Kesulitan dengan nada';

  @override
  String get acceptable => 'Cukup baik';

  @override
  String get perfectlyNatural => 'Sangat alami';

  @override
  String get sessionComplete => 'Sesi Selesai!';

  @override
  String get accuracy => 'Akurasi';

  @override
  String get reviewed => 'Ditinjau';

  @override
  String get correct => 'Benar';

  @override
  String get backToLibrary => 'Kembali ke Perpustakaan';

  @override
  String get revealAnswer => 'Tampilkan Jawaban';

  @override
  String get aiHubTitle => 'Pusat AI';

  @override
  String get textChat => 'Obrolan Teks';

  @override
  String get scholarlyPersonas => 'Persona Cendekiawan';

  @override
  String get shadowing => 'Shadowing';

  @override
  String get liveTranslation => 'Terjemahan Langsung';

  @override
  String get scholarsLibrary => 'Perpustakaan Cendekiawan';

  @override
  String get generate => 'Buat';

  @override
  String get searchPinyinHanziEnglish => 'Cari Pinyin, Hanzi, atau arti...';

  @override
  String get liveTranslate => 'Terjemahkan Langsung';

  @override
  String get travelInterpreter => 'Penerjemah Perjalanan';

  @override
  String get realTimeSplitScreen =>
      'Percakapan layar terpisah real-time dengan penutur asli. Menghilangkan hambatan bahasa secara instan.';

  @override
  String get whisperEarpiece => 'Earpiece Terjemahan Instan';

  @override
  String get listenToChineseAudio =>
      'Dengarkan audio Mandarin dan dapatkan subtitle bahasa Indonesia secara real-time langsung di layar Anda.';

  @override
  String get dashboardTitle => 'Dasbor';

  @override
  String get yourMindIsClear => 'Pikiran Anda jernih dan siap belajar.';

  @override
  String get noReviewsDueToday => 'Tidak ada ulasan yang jatuh tempo hari ini.';

  @override
  String get done => 'Selesai';

  @override
  String get hskLevel1 => 'Tingkat HSK 1';

  @override
  String get hskLevel2 => 'Tingkat HSK 2';

  @override
  String get hskLevel3 => 'Tingkat HSK 3';

  @override
  String get hskLevel4 => 'Tingkat HSK 4';

  @override
  String get hskLevel5 => 'Tingkat HSK 5';

  @override
  String get hskLevel6 => 'Tingkat HSK 6';

  @override
  String get generalVocabulary => 'Kosakata Umum';

  @override
  String cardsRequireAttention(Object count) {
    return '$count kartu memerlukan perhatian.';
  }

  @override
  String get begin => 'Mulai';

  @override
  String get poweredByAi =>
      'Didukung oleh AI canggih. Terjemahan real-time lancar untuk situasi apa pun.';

  @override
  String get downloadingModel => 'Mengunduh model...';

  @override
  String get soon => 'SEGERA';

  @override
  String get installed => 'TERINSTAL';

  @override
  String get premium => 'PREMIUM';

  @override
  String get coreModule => 'MODUL UTAMA';

  @override
  String get step6Context => 'LANGKAH 6: KONTEKS';

  @override
  String get tapBuildingBlocksTo =>
      'Ketuk blok pembangun untuk menjelajahi asal-usulnya.';

  @override
  String get initiateRadicalSequence => 'MULAI URUTAN RADIKAL';

  @override
  String get holdToTalk => 'Tahan untuk Bicara';

  @override
  String get customScenario => 'Skenario Kustom';

  @override
  String get voiceCall => 'Panggilan Suara';

  @override
  String get pronunciation => 'Pengucapan';

  @override
  String get selectAScenarioTo =>
      'Pilih skenario untuk melatih percakapan Mandarin Anda. Sang Cendekia akan menilai nada dan kejelasan Anda.';

  @override
  String get create => 'Buat';

  @override
  String get createYourScenario => 'Buat Skenario Anda';

  @override
  String get difficulty => 'Tingkat Kesulitan';

  @override
  String get scholarsVerdict => 'PENILAIAN CENDEKIAWAN';

  @override
  String get completeReview => 'Selesaikan Ulasan';

  @override
  String get conversationReview => 'ULASAN PERCAKAPAN';

  @override
  String get linguisticAnalysis => 'Analisis Linguistik';

  @override
  String get examplesInHsk1 => 'CONTOH DI HSK 1';

  @override
  String get characterReference => 'Referensi Karakter';

  @override
  String get askTutor => 'Tanya Tutor';

  @override
  String get addToStudyDeck => 'Tambahkan ke Dek Belajar';

  @override
  String get startPractice => 'MULAI LATIHAN';

  @override
  String get noOtherHsk1 =>
      'Tidak ada karakter HSK 1 lain yang menggunakan radikal ini.';

  @override
  String get couldNotLoadAi =>
      'Tidak dapat memuat konteks AI. (Batas kuota atau kesalahan jaringan)\nKetuk tombol segarkan di bawah untuk mencoba lagi nanti.';

  @override
  String get noAvailableCardsFound => 'Tidak ada kartu yang tersedia.';

  @override
  String get addCards => 'Tambah Kartu';

  @override
  String get removeCard => 'Hapus Kartu';

  @override
  String get remove => 'Hapus';

  @override
  String get review => 'Ulas';

  @override
  String get story => 'Cerita';

  @override
  String get thisDeckIsEmpty => 'Dek ini kosong.';

  @override
  String get tapTheAddCards => 'Ketuk tombol Tambah Kartu!';

  @override
  String get noCardsFound => 'Tidak ada kartu yang ditemukan.';

  @override
  String get addCardsToSee => 'Tambahkan kartu untuk melihat statistik.';

  @override
  String get aiGenerated => 'Dibuat oleh AI';

  @override
  String get allCardsCaughtUp => 'Semua kartu sudah ditinjau! Kerja bagus.';

  @override
  String get latestDiscoveries => 'Penemuan Terbaru';

  @override
  String get noCharactersInLexicon => 'Belum ada karakter dalam leksikon.';

  @override
  String get yourBookshelf => 'Rak Buku Anda';

  @override
  String get text_1782026184579 => '字';

  @override
  String get searchYourDictionary => 'Cari di kamus Anda...';

  @override
  String get saveCard => 'Simpan Kartu';

  @override
  String get noCharactersFound => 'Tidak ada karakter yang ditemukan.';

  @override
  String get radicalsIndex => 'Indeks Radikal';

  @override
  String get masteringRadicalsIsThe =>
      'Menguasai radikal adalah kunci untuk memahami ribuan Hanzi. Pilih sebuah radikal untuk melihat semua karakter yang menggunakannya.';

  @override
  String get noRadicalsFound => 'Tidak ada radikal yang ditemukan.';

  @override
  String get yourDrawing => 'Gambar Anda';

  @override
  String get reference => 'Referensi';

  @override
  String get rateYourRecall => 'Nilai daya ingat Anda';

  @override
  String get contactUs => 'Hubungi Kami';

  @override
  String get reportBugsOrRequest => 'Laporkan bug atau minta fitur';

  @override
  String get allDataHasBeen => 'Semua data telah dihapus.';

  @override
  String get hanziMasterV100 => 'SinoSpark v1.0.0';

  @override
  String get myProgress => 'Kemajuan Saya';

  @override
  String get overview => 'Ringkasan';

  @override
  String get aiStory => 'Cerita AI';

  @override
  String get usingYourDecksVocabulary => 'Menggunakan kosakata dari dek Anda';

  @override
  String get tryAgain => 'Coba Lagi';

  @override
  String get translate => 'Terjemahkan';

  @override
  String get pinyin => 'Pinyin';

  @override
  String get fullTranslation => 'Terjemahan Lengkap';

  @override
  String get geminiFlashIsStructuring =>
      'Gemini Flash sedang menyusun cerita Anda...';

  @override
  String get aiDeckGenerator => 'Pembuat Dek AI';

  @override
  String get whatDoYouWant => 'Apa yang ingin Anda pelajari?';

  @override
  String get targetDifficulty => 'Tingkat Kesulitan Target';

  @override
  String get focusArea => 'Area Fokus';

  @override
  String get specificContextOrTone => 'Konteks atau Nada Khusus (Opsional)';

  @override
  String get numberOfCards => 'Jumlah Kartu';

  @override
  String get generateDeck => 'Buat Dek';

  @override
  String get aiGrammarExplanation => 'Penjelasan Tata Bahasa AI';

  @override
  String get scholarsDesk => 'Meja Cendekiawan';

  @override
  String get chooseADeck => 'Pilih Dek';

  @override
  String get whereWouldYouLike => 'Di mana Anda ingin menyimpan karakter ini?';

  @override
  String get addToDefaultStudy => 'Tambahkan ke Dek Belajar Default';

  @override
  String get ifOffItsOnly =>
      'Jika dinonaktifkan, hanya akan disimpan ke kamus global';

  @override
  String get saveToLibrary => 'Simpan ke Perpustakaan';

  @override
  String get pleaseEnterValidChinese =>
      'Harap masukkan karakter Mandarin yang valid';

  @override
  String get reviewAiCard => 'Tinjau Kartu AI';

  @override
  String get pleaseDoublecheckTheAis =>
      'Mohon periksa ulang hasil AI di bawah ini. Anda dapat menyesuaikan pinyin atau definisi sebelum menyimpannya ke perpustakaan permanen Anda.';

  @override
  String get alreadyInYourLibrary => 'Sudah ada di perpustakaan Anda!';

  @override
  String get meaningInContext => 'Makna dalam Konteks';

  @override
  String get explainGrammar => 'Jelaskan Tata Bahasa';

  @override
  String get addToLibrary => 'Tambahkan ke Perpustakaan';

  @override
  String get masterYourMandarinPronunciation =>
      'Kuasai pengucapan Mandarin Anda dengan meniru penutur asli secara real-time.';

  @override
  String get startSession => 'MULAI SESI';

  @override
  String get sessionHistory => 'Riwayat Sesi';

  @override
  String get noSavedSessions => 'Tidak ada sesi yang tersimpan.';

  @override
  String get aiBreakdown => 'Analisis AI';

  @override
  String get sessionDetails => 'Detail Sesi';

  @override
  String partner(Object lang) {
    return 'Mitra ($lang)';
  }

  @override
  String get youEnglish => 'Anda (Bahasa Indonesia)';

  @override
  String get noTranscriptToSave => 'Tidak ada transkrip untuk disimpan!';

  @override
  String get sessionSaved => 'Sesi berhasil disimpan!';

  @override
  String get realtimeBidirectionalTranslationSpeak =>
      'Terjemahan dua arah real-time. Bicaralah dalam bahasa Indonesia atau Mandarin, dan percakapan akan diterjemahkan secara instan untuk Anda dan rekan bicara Anda.';

  @override
  String get text_1782026184665 => 'Merekam';

  @override
  String get recording => 'Merekam';

  @override
  String get yourSilentCompanionListen =>
      'Pendamping setia Anda. Dengarkan bahasa Mandarin dan dapatkan terjemahan bahasa Indonesia secara instan.';

  @override
  String get startListening => 'MULAI MENDENGARKAN';

  @override
  String get skip => 'Lewati';

  @override
  String get independentStars => 'BINTANG INDEPENDEN';

  @override
  String get notEveryCharacterHas =>
      'Tidak setiap karakter memiliki radikal induk. Beberapa merupakan piktogram unik atau berdiri sendiri.';

  @override
  String get onTheMapWe =>
      'Di peta, kami mengelompokkan karakter independen ini ke dalam KONSTELASI (✨).';

  @override
  String get iUnderstand => 'SAYA PAHAM';

  @override
  String get whatAreRadicals => 'APA ITU RADIKAL?';

  @override
  String get hanziAreBuiltFrom =>
      'Hanzi tersusun dari blok-blok pembangun yang disebut RADIKAL.\n\nRadikal memberikan makna inti atau tema dasar pada karakter.';

  @override
  String get continueText => 'LANJUTKAN';

  @override
  String get hanziAreNotJust =>
      'Hanzi bukan sekadar huruf, melainkan gambar yang membeku dalam waktu.\n\nUntuk menguasainya, Anda perlu belajar mengikuti alur goresannya.';

  @override
  String get iAmReady => 'SAYA SIAP';

  @override
  String get youAreAScholar => 'ANDA ADALAH SEORANG CENDEKIAWAN';

  @override
  String get theGalaxyMapAwaitsnmaster =>
      'Peta Galaksi menanti Anda.\nKuasai Matahari (Radikal) untuk membuka Planet (Karakter).';

  @override
  String get enterTheScroll => 'BUKA GULUNGAN';

  @override
  String get openingTheOriginScroll => 'Membuka Gulungan Asal Usul...';

  @override
  String get text_1782026184670 => '+';

  @override
  String get theScholarsEdition => 'Edisi Cendekiawan';

  @override
  String get weArePreparingThe =>
      'Kami sedang mempersiapkan peluncuran Edisi Cendekiawan.';

  @override
  String get devBypassUnlockNow => 'DEV BYPASS: BUKA SEKARANG';

  @override
  String get restorePurchases => 'Pulihkan Pembelian';

  @override
  String get welcomeScholarTheScroll =>
      'Selamat datang, Cendekiawan. Gulungan ini terbuka sepenuhnya untuk Anda.';

  @override
  String get purchasesRestoredSuccessfully => 'Pembelian berhasil dipulihkan.';

  @override
  String get noPreviousPurchasesFound =>
      'Tidak ditemukan riwayat pembelian sebelumnya di akun ini.';

  @override
  String get unlockTheFullPotential =>
      'Buka potensi penuh pembelajaran Anda. Pembelian sekali, milik Anda selamanya.';

  @override
  String get universalScanner => 'Pemindai Universal';

  @override
  String get noChineseCharactersFound =>
      'Tidak ada karakter Mandarin yang ditemukan pada gambar.';

  @override
  String get addedNewCharactersTo =>
      'Karakter baru telah ditambahkan ke perpustakaan Anda!';

  @override
  String get extractingTextAndObjects => 'Mengekstrak teks dan objek...';

  @override
  String get scanATextbookSign =>
      'Pindai buku teks, papan tanda, atau objek untuk mengekstrak karakter Mandarin.';

  @override
  String get extractedText => 'Teks yang Diekstrak';

  @override
  String get useText => 'Gunakan Teks';

  @override
  String get noMatchingDictionaryEntries =>
      'Tidak ditemukan entri kamus yang cocok.';

  @override
  String get quizComplete => 'Kuis Selesai!';

  @override
  String get returnToCourse => 'Kembali ke Kursus';

  @override
  String get notEnoughCardsFor =>
      'Kartu tidak cukup untuk kuis! Diperlukan setidaknya 4 kartu.';

  @override
  String get creatorMode => 'Mode Pembuat';

  @override
  String get noStoriesFoundMatching =>
      'Tidak ada cerita yang cocok dengan pencarian Anda.';

  @override
  String get discard => 'Buang';

  @override
  String get save => 'Simpan';

  @override
  String get generatingStoryViaDeepseek =>
      'Menghasilkan cerita melalui DeepSeek...';

  @override
  String get storySavedToLibrary => 'Cerita berhasil disimpan ke Perpustakaan!';

  @override
  String get storyNotFound => 'Cerita tidak ditemukan.';

  @override
  String get targetHskLevel => 'Target Level HSK';

  @override
  String get wedLoveToHear => 'Kami ingin mendengar tanggapan Anda!';

  @override
  String get whetherYouveFoundA =>
      'Baik Anda menemukan bug, memiliki saran fitur, atau sekadar ingin menyapa, masukan Anda sangat membantu meningkatkan SinoSpark.';

  @override
  String get pointYourCameraAt => 'Arahkan kamera Anda ke objek';

  @override
  String get reviewAddToLibrary => 'Tinjau & Tambahkan ke Perpustakaan';

  @override
  String hideStrokeGuideStreak(Object streak) {
    return 'Sembunyikan panduan goresan saat streak: $streak';
  }

  @override
  String inkPoints(Object points) {
    return '$points Poin Tinta';
  }

  @override
  String speechRateMultiplier(Object rate) {
    return '${rate}x';
  }

  @override
  String animationSpeedMultiplier(Object rate) {
    return '${rate}x';
  }

  @override
  String get supportAndFeedback => 'Dukungan & Umpan Balik';

  @override
  String get reportBug => 'Laporkan Bug';

  @override
  String get suggestFeature => 'Sarankan Fitur';

  @override
  String get generalFeedback => 'Umpan Balik Umum';

  @override
  String get pleaseDrawSomethingFirst =>
      'Silakan gambar sesuatu terlebih dahulu';

  @override
  String get drawThisCharacter => 'Gambar karakter ini:';

  @override
  String followGuideStroke(Object current, Object total) {
    return 'Ikuti panduan biru untuk menggambar goresan $current dari $total';
  }

  @override
  String get skipCurrentStroke => 'Lewati Goresan Saat Ini';

  @override
  String get submitDrawing => 'Kirim Gambar';

  @override
  String addedToDeck(Object deckName, Object hanzi) {
    return 'Menambahkan «$hanzi» ke «$deckName»';
  }

  @override
  String removedFromDeck(Object hanzi) {
    return 'Menghapus «$hanzi» dari dek';
  }

  @override
  String skippedNoStrokeData(Object hanzi) {
    return 'Melewati «$hanzi» - Tidak ada data goresan yang tersedia untuk karakter AI ini.';
  }

  @override
  String get startingSession => 'Memulai sesi...';

  @override
  String get studySession => 'Sesi belajar';

  @override
  String get readyToStudy => 'Siap belajar';

  @override
  String get studyQueuePreviewDescription =>
      'Sesi Anda didasarkan pada jadwal hari ini dan batas dek.';

  @override
  String get notNow => 'Nanti saja';

  @override
  String get newLabel => 'Baru';

  @override
  String get studyDeckEmpty => 'Dek ini kosong';

  @override
  String get studyDeckEmptyDescription =>
      'Tambahkan kartu sebelum memulai sesi belajar.';

  @override
  String get studyDailyLimitReached => 'Batas harian telah tercapai';

  @override
  String get studyDailyLimitReachedDescription =>
      'Anda telah menggunakan kuota kartu baru atau ulasan dek ini untuk hari ini.';

  @override
  String get studyCaughtUpDescription =>
      'Tidak ada jadwal lain untuk hari ini. Kembali lagi untuk ulasan berikutnya.';

  @override
  String get noCardsAvailable => 'Tidak ada kartu yang tersedia';

  @override
  String get studyNoEligibleCardsDescription =>
      'Tidak ada kartu yang memenuhi syarat untuk mode belajar ini saat ini.';

  @override
  String get studySessionLoadFailed =>
      'Gagal memuat sesi belajar ini. Silakan coba lagi.';

  @override
  String get retryLimitReached =>
      'Kartu ini akan muncul kembali di sesi Anda berikutnya.';

  @override
  String get masterBuildingBlocks => 'Kuasai blok pembangun Hanzi';

  @override
  String get totalWords => 'Total Kata';

  @override
  String get newInk => 'Tinta Baru';

  @override
  String get learningStatus => 'Sedang Dipelajari';

  @override
  String get masteredStatus => 'Dikuasai';

  @override
  String get libraryMastery => 'Penguasaan Perpustakaan';

  @override
  String get accuracyByMode => 'Akurasi Berdasarkan Mode';

  @override
  String get upcomingReviews => 'Ulasan Mendatang (7 Hari ke Depan)';

  @override
  String get culturalReadingRoom => 'Ruang Baca Budaya (文化书房)';

  @override
  String storyTitleHsk(Object level, Object title) {
    return '$title (HSK $level)';
  }

  @override
  String get pleaseEnterTopic => 'Silakan masukkan topik';

  @override
  String createdDeckCards(Object count, Object name) {
    return 'Membuat «$name» dengan $count kartu!';
  }

  @override
  String gradeResult(Object grade) {
    return 'Nilai: $grade';
  }

  @override
  String get listeningMode => 'Mode Mendengar';

  @override
  String get readingMode => 'Mode Membaca';

  @override
  String get recallMode => 'Mode Mengingat';

  @override
  String get speakingMode => 'Mode Berbicara';

  @override
  String get aiMemoryHook => 'Jembatan Keledai AI (Memory Hook)';

  @override
  String get exampleSentences => 'Contoh Kalimat';

  @override
  String get ghostCharacters => 'Karakter Panduan (Watermark)';

  @override
  String get commonWords => 'Kata-kata Umum';

  @override
  String get personalNotes => 'Catatan Pribadi';

  @override
  String get addPersonalNotes =>
      'Tambahkan catatan atau jembatan keledai Anda di sini...';

  @override
  String get takePhoto => 'Ambil Foto';

  @override
  String get gallery => 'Galeri';

  @override
  String get arLens => 'Lensa AR';

  @override
  String addedCharToLibrary(Object char) {
    return '«$char» ditambahkan ke perpustakaan';
  }

  @override
  String get scoreText => 'Skor';

  @override
  String get searchDictionaryHint => 'Cari karakter, pinyin, atau arti...';

  @override
  String get searchDeckHint => 'Cari karakter, pinyin...';

  @override
  String get localRestaurant => 'Restoran Lokal';

  @override
  String get taxiToAirport => 'Taksi ke Bandara';

  @override
  String get silkMarketHaggling => 'Tawar-menawar di Pasar Sutra';

  @override
  String get medicalClinic => 'Klinik Medis';

  @override
  String get meetingAFriend => 'Bertemu Teman';

  @override
  String get jobInterview => 'Wawancara Kerja';

  @override
  String get searchRadicalsHint => 'Cari radikal (mis. Air, 氵)';

  @override
  String get definition => 'Definisi';

  @override
  String get undo => 'Urungkan';

  @override
  String get hanziMaster => 'SinoSpark';

  @override
  String get unlockForever => 'Buka Selamanya - \$9.99';

  @override
  String get clear => 'Hapus';

  @override
  String get clearChat => 'Hapus obrolan';

  @override
  String get typeMessage => 'Ketik pesan Anda...';

  @override
  String addedToLibrary(Object hanzi) {
    return 'Menambahkan «$hanzi» ke perpustakaan Anda';
  }

  @override
  String get generateNewStory => 'Buat Cerita Baru';

  @override
  String failedToGenerateStory(Object error) {
    return 'Gagal membuat cerita:\n$error';
  }

  @override
  String get detail => 'Detail';

  @override
  String get scanText => 'Pindai Teks';

  @override
  String get createMagic => 'Ciptakan Keajaiban';

  @override
  String get learning => 'Sedang Dipelajari';

  @override
  String get upcomingReviews7Days => 'Ulasan Mendatang (7 Hari ke Depan)';

  @override
  String get askFollowUpQuestion => 'Ajukan pertanyaan lanjutan...';

  @override
  String get pasteScanToSimplify =>
      'Tempel atau pindai teks Mandarin untuk disederhanakan';

  @override
  String get searchStoriesHint =>
      'Cari cerita berdasarkan judul atau tag (mis. mitologi, perjalanan)';

  @override
  String get importAll => 'Impor semua';

  @override
  String get ascendAll => 'Tingkatkan Semua';

  @override
  String get startAscension => 'Mulai peningkatan';

  @override
  String get scenarioLocalRestaurant => 'Restoran Lokal';

  @override
  String get scenarioLocalRestaurantDesc =>
      'Berlatih memesan makanan dan meminta rekomendasi menu.';

  @override
  String get scenarioTaxiAirport => 'Taksi ke Bandara';

  @override
  String get scenarioTaxiAirportDesc =>
      'Beri tahu pengemudi tujuan Anda dan bicarakan kondisi lalu lintas.';

  @override
  String get scenarioSilkMarket => 'Tawar-menawar di Pasar Sutra';

  @override
  String get scenarioSilkMarketDesc =>
      'Cobalah menawar harga terbaik untuk sebuah suvenir.';

  @override
  String get scenarioMedicalClinic => 'Klinik Medis';

  @override
  String get scenarioMedicalClinicDesc =>
      'Jelaskan gejala yang Anda rasakan kepada dokter tradisional.';

  @override
  String get scenarioMeetingFriend => 'Bertemu Teman';

  @override
  String get scenarioMeetingFriendDesc =>
      'Perkenalkan diri dan lakukan percakapan santai.';

  @override
  String get scenarioJobInterview => 'Wawancara Kerja';

  @override
  String get scenarioJobInterviewDesc =>
      'Melamar pekerjaan di sebuah perusahaan teknologi di Shanghai.';

  @override
  String get createCustomScenario => 'Buat Skenario Kustom';

  @override
  String get customScenarioTitleHint => 'Judul (mis. Resepsi Pernikahan)';

  @override
  String get customScenarioDescHint => 'Deskripsi (Konteks)';

  @override
  String get customScenarioPersonaHint =>
      'Persona AI (mis. Rekan kerja yang ingin tahu)';

  @override
  String get customScenarioDifficulty => 'Tingkat Kesulitan';

  @override
  String get createAction => 'Buat';

  @override
  String get cancelAction => 'Batal';

  @override
  String get mythsAndLegends => 'Mitos & Legenda';

  @override
  String get historyAndCulture => 'Sejarah & Budaya';

  @override
  String get idiomsTitle => 'Idiom (成语)';

  @override
  String get theMonkeyKing => 'Raja Kera';

  @override
  String get theMonkeyKingDesc => 'Sun Wukong (Perjalanan ke Barat)';

  @override
  String get huaMulan => 'Hua Mulan';

  @override
  String get huaMulanDesc =>
      'Hua Mulan bergabung dengan militer menggantikan ayahnya';

  @override
  String get confuciusTitle => 'Konfusius';

  @override
  String get confuciusDesc => 'Kehidupan dan ajaran Konfusius';

  @override
  String get theGreatWall => 'Tembok Besar';

  @override
  String get theGreatWallDesc => 'Pembangunan Tembok Besar Tiongkok';

  @override
  String get generateTopic => 'Hasilkan Topik';

  @override
  String get simplifyText => 'Sederhanakan Teks';

  @override
  String get topicHint => 'Topik (mis. Alien di Beijing)';

  @override
  String get tagsHint => 'Tag (dipisahkan koma, opsional)';

  @override
  String get speakWithMasterLin => 'Bicara dengan Master Lin';

  @override
  String get masterLinGreeting =>
      'Salam, muridku. Tinta telah siap. Karakter atau kalimat apa yang ingin kita pelajari hari ini?';

  @override
  String get typeYourMessage => 'Ketik pesan Anda...';

  @override
  String get theMainLibrary => 'Perpustakaan Utama';

  @override
  String get hsk1Foundation => 'HSK 1: Tingkat Dasar';

  @override
  String get hsk2Elementary => 'HSK 2: Tingkat Pemula';

  @override
  String get hsk3Intermediate => 'HSK 3: Tingkat Menengah';

  @override
  String get inDeckCheck => 'Sudah di Dek ✓';

  @override
  String get addToDeckPlus => '+ Tambah ke Dek';

  @override
  String get openCardArrow => 'Buka Kartu →';

  @override
  String get pronunciationPartial => 'Nada kurang tepat';

  @override
  String get pronunciationWrong => 'Salah';

  @override
  String get toneExpected => 'Nada yang diharapkan';

  @override
  String get toneYouSaid => 'Nada yang diucapkan';

  @override
  String get gotIt => 'Paham!';

  @override
  String foundNCharacters(int count) {
    return '$count karakter ditemukan';
  }

  @override
  String get lookingUpCharacters => 'Mencari karakter…';

  @override
  String get practiceAll => 'Latih semua';

  @override
  String get arLensObjects => 'Objek';

  @override
  String get arLensText => 'Teks';

  @override
  String get arLensDetectedText => 'Teks terdeteksi';

  @override
  String get duration12Min => '1-2 mnt';

  @override
  String get aClassicTangDynastyPoem => 'Puisi klasik Dinasti Tang';

  @override
  String get aClassicTangDynastyPoemBy => 'Puisi klasik Dinasti Tang oleh';

  @override
  String get aStructuralComponent => 'Komponen struktural.';

  @override
  String get addSelectedToDeck => 'Tambahkan yang Dipilih ke Dek';

  @override
  String addTo(Object target) {
    return 'Tambahkan ke $target';
  }

  @override
  String addedHanziToYourLibrary(String hanzi) {
    return '«$hanzi» telah ditambahkan ke perpustakaan Anda';
  }

  @override
  String get adjustFontSize => 'Sesuaikan Ukuran Huruf';

  @override
  String get againGoodEasyHard => '⬅️ Lagi    ➡️ Baik    ⬆️ Mudah    ⬇️ Sulit';

  @override
  String get aiAnalysisFailed => 'Analisis AI Gagal';

  @override
  String get aiIsThinking => 'AI sedang berpikir...';

  @override
  String get aiSceneAnalysisFailed => 'Analisis Adegan AI Gagal';

  @override
  String get allLabel => 'Semua';

  @override
  String get allPinyin => 'Semua Pinyin';

  @override
  String get alreadyHaveAccountSignIn => 'Sudah punya akun? Masuk';

  @override
  String get analysisFailed => 'Analisis Gagal:';

  @override
  String get analyzingClassicalCharacters => 'Menganalisis karakter klasik...';

  @override
  String get anatomy => 'Anatomi';

  @override
  String get ancientPhilosophy => 'Filsafat Kuno';

  @override
  String get warringStates => 'Negara-Negara Berperang';

  @override
  String get hanFeiLegalism =>
      'Han Fei (sekitar 280–233 SM) adalah seorang pangeran dari negara Han dan pemikir terkemuka Legalisme Tiongkok. Menggabungkan gagasan tentang hukum, teknik administrasi, dan otoritas, tulisan-tulisannya dalam Han Feizi sangat memengaruhi filsafat politik dan institusi kekaisaran Tiongkok.';

  @override
  String get articleSavedToMediaHub =>
      'Artikel berhasil disimpan ke Media Hub!';

  @override
  String get askAFollowUp => 'Ajukan pertanyaan lanjutan...';

  @override
  String get audioPrivacyAndHowThingsWork => 'Audio, privasi, dan cara kerja';

  @override
  String get audiobookPlayer => 'Pemutar Buku Audio';

  @override
  String get audiobookVoice => 'Suara Buku Audio';

  @override
  String get auntieMaTown =>
      'Bibi Ma (马阿姨), pemilik kios yang energik dan bersuara lantang yang membuat Roujiamo dan Liangpi paling renyah di kota.';

  @override
  String get back => 'Kembali';

  @override
  String get baristaKevinNotes =>
      'Barista Kevin (小凯), seorang pemanggang kopi muda bersemangat yang senang mendiskusikan biji kopi Yunnan dan profil rasa.';

  @override
  String get bbc => 'BBC Bahasa Mandarin';

  @override
  String get beginYourJourney => 'Mulai Perjalanan Anda';

  @override
  String get bestValue => 'Paling Hemat';

  @override
  String get bookLinkCopiedToClipboard =>
      'Tautan buku berhasil disalin ke papan klip!';

  @override
  String get bookmarkChapter => 'Tandai Bab Ini';

  @override
  String get bookmarks => 'Markah Buku';

  @override
  String get books => 'Buku';

  @override
  String get briefing => 'Pengarahan Singkat';

  @override
  String get bugReport => 'Laporan Bug';

  @override
  String get caoXueqinDecline =>
      'Cao Xueqin (sekitar 1715–1763) adalah novelis Dinasti Qing yang lahir dari keluarga bangsawan terpandang yang kemudian jatuh miskin di era Kaisar Yongzheng. Impian di Paviliun Merah (Dream of the Red Chamber), yang ditulis pada tahun-tahun terakhir kehidupannya yang serba kekurangan, diakui luas sebagai mahakarya fiksi klasik Tiongkok yang melukiskan keruntuhan kaum aristokrat secara mendalam.';

  @override
  String get cardsTitle => 'KARTU';

  @override
  String get cc => 'Subtitel (CC)';

  @override
  String get characterOrWord => 'Karakter / Kata';

  @override
  String get chatMore => 'Ngobrol lagi';

  @override
  String get chefChenShumai =>
      'Koki Chen (陈师傅), seorang koki dim sum Kanton yang ceria, merekomendasikan pangsit udang Har Gow segar dan Shumai.';

  @override
  String get chineseEpics => 'Epos Tiongkok';

  @override
  String get chinesePoetry => 'Puisi Tiongkok';

  @override
  String get chng => 'chéng';

  @override
  String get chongqingSpicyHotpotFeast => 'Pesta Hotpot Pedas Chongqing';

  @override
  String get chooseAudiobookVoice => 'Pilih Suara Buku Audio';

  @override
  String get chooseVoice => 'Pilih Suara';

  @override
  String get compare => 'Bandingkan';

  @override
  String get compare4Tones => 'Bandingkan 4 Nada';

  @override
  String get configuration => 'Konfigurasi';

  @override
  String get contemporary => 'Kontemporer';

  @override
  String get context => 'Konteks';

  @override
  String get couldNotLoadLibrary => 'Tidak dapat memuat perpustakaan';

  @override
  String get couldNotLoadVocabulary => 'Tidak dapat memuat kosakata.';

  @override
  String get couldNotOpenEmailApp => 'Tidak dapat membuka aplikasi email.';

  @override
  String get createAccount => 'Buat Akun';

  @override
  String get createNewDeck => 'Buat Dek Baru';

  @override
  String get createScenario => 'Buat Skenario';

  @override
  String get createStory => 'Buat Cerita';

  @override
  String get customLabel => 'Kustom';

  @override
  String get customWord => 'Kata Kustom';

  @override
  String get days => 'hari';

  @override
  String get deck => 'Dek';

  @override
  String get deckName => 'Nama Dek';

  @override
  String get deckStory => 'Cerita Dek';

  @override
  String get deepAnalysis => 'Analisis Mendalam';

  @override
  String get defaultDeck => 'Dek Default';

  @override
  String get deleteLabel => 'Hapus';

  @override
  String get deleteScenario => 'Hapus Skenario';

  @override
  String get deletesAllProgressPermanently =>
      'Menghapus semua kemajuan belajar secara permanen';

  @override
  String get developerBackdoorUnlocked => 'Akses Pengembang Terbuka!';

  @override
  String get doesNotExistInChinese => 'Tidak ada dalam bahasa Mandarin';

  @override
  String get dontHaveAccountSignUp => 'Belum punya akun? Daftar';

  @override
  String get draftingStoryOutline => 'Menyusun kerangka cerita...';

  @override
  String get dynamicFlowState => 'Status Alur Dinamis';

  @override
  String get dynamicFlowStateParenthetical => 'Dinamis (Alur Pembelajaran)';

  @override
  String get editCard => 'Edit Kartu';

  @override
  String get egAnimeVocab => 'Mis. Kosakata Anime';

  @override
  String get egFormalBusinessLanguageSlangForTexting =>
      'Mis. bahasa bisnis formal, bahasa gaul percakapan...';

  @override
  String get egOrderingAtARestaurantBusinessVocab =>
      'Mis. memesan di restoran, kosakata bisnis...';

  @override
  String get egWeddingReceptionTechInterview =>
      'Mis. resepsi pernikahan, wawancara teknis...';

  @override
  String get emailLabel => 'Email';

  @override
  String get english => 'Bahasa Inggris';

  @override
  String get englishAndWorld => 'Bahasa Inggris & Dunia';

  @override
  String get episodes => 'episode';

  @override
  String get erase => 'Hapus';

  @override
  String get eraseDeckQuestion => 'Hapus Dek?';

  @override
  String errorFetchingTranslationForLabelE(String label, String e) {
    return 'Kesalahan saat mengambil terjemahan untuk $label: $e';
  }

  @override
  String errorLoadingMicroreadsE(String e) {
    return 'Kesalahan saat memuat bacaan mikro: $e';
  }

  @override
  String errorLoadingNovelsE(String e) {
    return 'Kesalahan saat memuat novel: $e';
  }

  @override
  String errorLoadingPoetryE(String e) {
    return 'Kesalahan saat memuat puisi: $e';
  }

  @override
  String get exitFocus => 'Keluar dari Mode Fokus';

  @override
  String get explore => 'Jelajahi';

  @override
  String get exportToThisDeck => 'Ekspor ke dek ini';

  @override
  String get extractAndSimplify => 'Ekstrak & Sederhanakan';

  @override
  String get failedToCreateDeck => 'Gagal membuat dek';

  @override
  String get failedToLoadDailyContent => 'Gagal memuat konten harian';

  @override
  String get failedToLoadEpisodes => 'Gagal memuat episode';

  @override
  String get failedToLoadShows => 'Gagal memuat acara';

  @override
  String get finalizingDetails => 'Menyelesaikan detail...';

  @override
  String get finalizingStoryDetails => 'Menyelesaikan detail cerita...';

  @override
  String get firebaseAuthConsole =>
      'Firebase Auth tidak aktif. Harap aktifkan metode masuk yang diperlukan di Konsol Firebase Anda.';

  @override
  String get flashcardDeckTitle => 'DEK FLASHCARD';

  @override
  String get focus => 'Fokus';

  @override
  String get foodAndCooking => 'Makanan & Kuliner';

  @override
  String get forward => 'Maju';

  @override
  String get freeFlow => 'Alur Bebas';

  @override
  String get frenchClassics => 'Karya Klasik Prancis';

  @override
  String get full => 'Penuh';

  @override
  String get gamingAndEsports => 'Game & Esports';

  @override
  String get germanClassics => 'Karya Klasik Jerman';

  @override
  String get ghostPinyin => 'Pinyin Panduan';

  @override
  String get goodAttempt => 'Percobaan yang bagus';

  @override
  String get gotItSimple => 'Paham';

  @override
  String get grammar => 'Tata Bahasa';

  @override
  String get grandmaLiuFilling =>
      'Nenek Liu (刘奶奶), seorang nenek yang ramah dari utara yang mengajari Anda cara melipat kulit jiaozi dan membuat isian daging babi serta daun bawang.';

  @override
  String get great => 'Hebat!';

  @override
  String get handmadeDumplingFeastInHarbin =>
      'Pesta Jiaozi Buatan Tangan di Harbin';

  @override
  String get hanziCharacter => 'Hanzi (Karakter)';

  @override
  String get hapticFeedback => 'Umpan Balik Haptik';

  @override
  String get helpAndSupport => 'Bantuan & Dukungan';

  @override
  String get hidden => 'Tersembunyi';

  @override
  String get hideEnglishTranslations => 'Sembunyikan Terjemahan Bahasa Inggris';

  @override
  String get hidePinyin => 'Sembunyikan Pinyin';

  @override
  String get highlight => 'SOROTAN';

  @override
  String get howWouldYouLikeToStudy => 'Bagaimana Anda ingin belajar?';

  @override
  String get hsk1 => 'HSK 1';

  @override
  String get hsk4UpperIntermediate => 'HSK 4: Menengah Atas';

  @override
  String get hsk5Advanced => 'HSK 5: Mahir';

  @override
  String get hsk6Mastery => 'HSK 6: Penguasaan';

  @override
  String get hskCollections => 'Koleksi HSK';

  @override
  String hskLevel(String level) {
    return 'HSK $level';
  }

  @override
  String get hskSimplifySubtitles => 'Sederhanakan Subtitel HSK';

  @override
  String get hskVocabularyCollections => 'Koleksi Kosakata HSK';

  @override
  String get i => 'Saya';

  @override
  String get ifTheAgain =>
      'Jika transkripsi tidak sesuai dengan ucapan Anda, pilih frasa yang dimaksud lalu ketuk “Ya, Nilai Ulang!” untuk menilai kembali rekaman asli tanpa perlu berbicara lagi.';

  @override
  String get install => 'Instal';

  @override
  String get just => 'Hanya \$';

  @override
  String get keyword => 'Kata Kunci';

  @override
  String get knowledgeBase => 'Basis Pengetahuan';

  @override
  String get liRuzhenSubjects =>
      'Li Ruzhen (sekitar 1763–1830) adalah cendekiawan Dinasti Qing yang memiliki minat mendalam pada fonologi, catur, dan kosmologi. Bunga di Dalam Cermin (Flowers in the Mirror), novel fantasinya tentang perjalanan seorang pedagang melintasi negeri-negeri ajaib, terkenal karena tema feminis dan cakupan ilmunya yang ensiklopedis.';

  @override
  String get libraryLabel => 'Perpustakaan';

  @override
  String get lifestyleAndVlog => 'Gaya Hidup & Vlog';

  @override
  String get listenInAudiobookMode => 'Dengarkan dalam Mode Buku Audio';

  @override
  String get listenToThisWord => 'Dengarkan kata ini';

  @override
  String get listening => 'Mendengarkan...';

  @override
  String get liuEEncroachment =>
      'Liu E (1857–1909) adalah seorang polimatik akhir Dinasti Qing — insinyur, dokter, dan novelis — yang novel tunggalnya Perjalanan Lao Can (The Travels of Lao Can) merupakan catatan perjalanan liris bermuatan politik tentang tabib kelana yang menjelajahi Tiongkok di tengah keruntuhan dinasti dan tekanan asing.';

  @override
  String get loadingTranslations => 'Memuat terjemahan...';

  @override
  String get luXunVernacular =>
      'Lu Xun (1881–1936), nama pena Zhou Shuren, adalah bapak sastra Tiongkok modern. Seorang dokter yang beralih ke dunia penulisan untuk memulihkan jiwa bangsanya, kumpulan cerita pendeknya — Catatan Harian Orang Gila dan Kisah Nyata Ah Q — mempelopori penggunaan bahasa rakyat (Baihua) dalam mengkritisi tatanan sosial lama.';

  @override
  String get luoGuanzhongEpic =>
      'Luo Guanzhong (sekitar 1330–1400) adalah dramawan dan novelis era transisi Yuan ke Ming, yang diyakini pernah belajar di bawah bimbingan Shi Nai\'an. Karyanya Kisah Tiga Negara (Romance of the Three Kingdoms) memadukan kronik sejarah, tradisi lisan, dan drama panggung menjadi epos sejarah Tiongkok yang legendaris.';

  @override
  String get makeACustomCollection => 'Buat koleksi kustom';

  @override
  String get manageDailyDropsAndReviewReminders =>
      'Kelola Sajian Harian dan Pengingat Ulasan';

  @override
  String get managerYuOptions =>
      'Manajer Yu (余店长), seorang manajer restoran hotpot yang bersemangat, merekomendasikan babat khas, darah bebek, dan pilihan kuah gurih.';

  @override
  String get masterGaoRubs =>
      'Master Gao (高师傅), ahli BBQ arang karismatik yang suka bercanda dengan pelanggan tentang tingkat kepedasan dan bumbu jintan rahasia.';

  @override
  String get masterThisToUnlockItsGalaxy =>
      'Kuasai ini untuk membuka galaksinya.';

  @override
  String get masterZhaoBrewing =>
      'Master Zhao (赵师傅), seorang sommelier teh yang sabar dan berpengetahuan luas yang senang menjelaskan seni penyeduhan teh Gongfu.';

  @override
  String get mastery => 'Penguasaan';

  @override
  String get maybeLater => 'Mungkin Nanti';

  @override
  String get memes => 'Meme';

  @override
  String get midnightBbqSkewersInWuhan => 'Sate BBQ Tengah Malam di Wuhan';

  @override
  String get mo => '/bln';

  @override
  String get modernChinese => 'Mandarin Modern';

  @override
  String get monthly => 'Bulanan';

  @override
  String get morningDimSumCartInGuangzhou => 'Kereta Dim Sum Pagi di Guangzhou';

  @override
  String get nameLabel => 'Nama';

  @override
  String get native => 'Penutur Asli';

  @override
  String get newCard => 'Kartu Baru';

  @override
  String get newDeck => 'Dek Baru';

  @override
  String get newDeckName => 'Nama Dek Baru';

  @override
  String get noActiveSubscriptionFound => 'Tidak ditemukan langganan aktif.';

  @override
  String get noEpisodesFound => 'Tidak ada episode yang ditemukan';

  @override
  String get noKeyWordsFoundForThisStory =>
      'Tidak ada kata kunci yang ditemukan untuk cerita ini.';

  @override
  String get noLabel => 'Tidak';

  @override
  String get noNewWordsFound => 'Tidak ada kata baru yang ditemukan!';

  @override
  String get noPinyin => 'Tanpa Pinyin';

  @override
  String get noPremiumPackagesAvailable =>
      'Saat ini tidak ada paket premium yang tersedia.';

  @override
  String noResultsFoundForSearchquery(String searchQuery) {
    return 'Tidak ada hasil untuk \'$searchQuery\'';
  }

  @override
  String get noSavedArticlesYet => 'Belum ada artikel yang disimpan.';

  @override
  String get noShowsAvailable => 'Tidak ada acara yang tersedia';

  @override
  String get noStoriesFound => 'Tidak ada cerita yang ditemukan.';

  @override
  String get noWordsSelected => 'Tidak ada kata yang dipilih';

  @override
  String get notes => 'Catatan';

  @override
  String get notoserifsc => 'NotoSerifSC';

  @override
  String get objectivesTitle => 'TUJUAN';

  @override
  String get openInYoutube => 'Buka di YouTube';

  @override
  String get orderingHanddripCoffeeInShanghai =>
      'Memesan Kopi Manual Brew di Shanghai';

  @override
  String get orderingSugarcoatedHawsInWinterBeijing =>
      'Memesan Tanghulu (Manisan Hawthorn) di Musim Dingin Beijing';

  @override
  String partnerLang(String lang) {
    return 'Mitra ($lang)';
  }

  @override
  String get partnerListening => 'Mitra sedang mendengarkan...';

  @override
  String get partnerSpeaking => 'Mitra sedang berbicara...';

  @override
  String get passwordLabel => 'Kata Sandi';

  @override
  String get pause => 'Jeda';

  @override
  String get perfect => 'Sempurna!';

  @override
  String get personalizedPathBasedOnDeck =>
      'Jalur belajar yang dipersonalisasi berdasarkan dek Anda.';

  @override
  String get play => 'Putar )';

  @override
  String get pleaseEnterMessageBeforeSending =>
      'Harap masukkan pesan sebelum mengirim.';

  @override
  String get practiceInRoleplay => 'Berlatih dalam Roleplay';

  @override
  String get practiceModes => 'Mode Latihan';

  @override
  String get practicePronouncingWithAiGrading =>
      'Latih pengucapan kata ini dengan penilaian AI';

  @override
  String get preparingReadingInterface => 'Menyiapkan antarmuka membaca...';

  @override
  String get privacy => 'Privasi';

  @override
  String get privacyAndAudio => 'Privasi & Audio';

  @override
  String get aiDataPrivacyTitle => 'Data & Privasi AI';

  @override
  String get aiDataPrivacySettingsSubtitle =>
      'Lihat apa yang dikirim fitur AI, alasannya, dan kepada siapa';

  @override
  String get aiDataPrivacyOverviewTitle => 'Kapan AI digunakan';

  @override
  String get aiDataPrivacyOverviewBody =>
      'SinoSpark menggunakan AI cloud hanya saat Anda memilih fitur yang membutuhkannya, seperti obrolan AI, penjelasan, terjemahan, analisis gambar, pengenalan suara, penilaian pengucapan, atau suara cloud. Hasil AI mungkin tidak akurat, jadi periksa kembali hasil yang penting.';

  @override
  String get aiDataPrivacyProvidersTitle => 'Penyedia layanan AI';

  @override
  String get aiDataPrivacyProvidersBody =>
      'Google Gemini memproses permintaan teks dan gambar generatif. OpenRouter meneruskan beberapa permintaan generatif ke Google Gemini atau DeepSeek. Microsoft Azure AI Speech memproses pengenalan suara, penilaian pengucapan, dan teks yang dikirim untuk sintesis suara cloud.';

  @override
  String get aiDataPrivacySentTitle => 'Data yang mungkin dikirim';

  @override
  String get aiDataPrivacySentBody =>
      'Tergantung fiturnya, kami mengirimkan teks yang Anda masukkan atau pilih, konteks percakapan atau pelajaran yang relevan, gambar yang Anda pilih untuk analisis AI, rekaman suara yang Anda kirimkan, serta data permintaan teknis seperti alamat IP dan metadata perangkat/jaringan. Kami tidak dengan sengaja menyertakan nama atau email Anda dalam prompt AI.';

  @override
  String get aiDataPrivacyControlsTitle => 'Pilihan Anda';

  @override
  String get aiDataPrivacyControlsBody =>
      'Jangan gunakan fitur AI jika Anda tidak ingin masukannya dikirim ke penyedia yang disebutkan. Anda dapat menolak izin kamera, foto, atau mikrofon di Pengaturan perangkat. Pilih suara Lokal agar teks-ke-suara tetap berada di perangkat Anda. Hindari mengirimkan informasi sensitif atau rahasia.';

  @override
  String get aiDataPrivacyRetentionTitle => 'Penyimpanan dan retensi';

  @override
  String get aiDataPrivacyRetentionBody =>
      'SinoSpark tidak dengan sengaja menyimpan prompt AI mentah, gambar yang dikirimkan, atau rekaman suara di servernya sendiri setelah diproses. Hasil yang dibuat dapat disimpan di perangkat atau akun Anda jika Anda memilih untuk menyimpannya. Penyedia memproses data berdasarkan ketentuan dan kontrol retensi mereka sendiri; lihat kebijakan lengkap untuk detailnya.';

  @override
  String get readFullPrivacyPolicy => 'Baca Kebijakan Privasi Lengkap';

  @override
  String get linkOpenFailed => 'Gagal membuka tautan. Silakan coba lagi.';

  @override
  String get puSonglingLiterature =>
      'Pu Songling (1640–1715) adalah penulis Dinasti Qing yang mendedikasikan puluhan tahun mengumpulkan Kisah Aneh dari Studio Liaozhai (Strange Tales from a Chinese Studio) setelah berulang kali gagal dalam ujian kekaisaran. Kisah supernatural tentang siluman rubah, hantu, dan kaum terpelajar ini tetap menjadi mahakarya sastra klasik Tiongkok.';

  @override
  String get qaFaq => 'Tanya Jawab / FAQ';

  @override
  String get questsTitle => 'MISI';

  @override
  String get quickBookmarks => 'Markah Buku Cepat';

  @override
  String get radical => 'Radikal';

  @override
  String get ready => 'Siap';

  @override
  String get readyToInterpret => 'Siap menerjemahkan';

  @override
  String get readyToStart => 'Siap untuk memulai.';

  @override
  String get recentBookmarks => 'Markah Buku Terbaru';

  @override
  String get refiningGrammar => 'Menyempurnakan tata bahasa...';

  @override
  String get refresh => 'Segarkan';

  @override
  String get removeFromSaved => 'Hapus dari Tersimpan';

  @override
  String get removeFromSavedScenarios => 'Hapus dari skenario tersimpan';

  @override
  String get removed => 'Dihapus';

  @override
  String get requestPermissions => 'Minta Izin';

  @override
  String get rescind => 'Batalkan';

  @override
  String get restore => 'Pulihkan';

  @override
  String get results => 'Hasil';

  @override
  String get resume => 'Lanjutkan';

  @override
  String get retry => 'Coba Lagi';

  @override
  String get revenuecatError => 'Kesalahan RevenueCat:';

  @override
  String revenuecatErrorE(String e) {
    return 'Kesalahan RevenueCat: $e';
  }

  @override
  String get reviewExtractedDeck => 'Tinjau Dek yang Diekstrak';

  @override
  String get reviewIn => 'Tinjau dalam';

  @override
  String get reviewingYourTones => 'Meninjau nada Anda...';

  @override
  String get saveAll => 'Simpan Semua';

  @override
  String get saveScenario => 'Simpan Skenario';

  @override
  String get saveThisScenario => 'Simpan skenario ini';

  @override
  String get saved => 'Tersimpan';

  @override
  String get scanAnother => 'Pindai Lainnya';

  @override
  String get scenarioRemoved => 'Skenario dihapus';

  @override
  String get scenarioSavedFindInCustomTab =>
      'Skenario tersimpan! Temukan di tab Kustom.';

  @override
  String score(Object score, Object total) {
    return 'Skor: $score / $total';
  }

  @override
  String get searchByPinyinOrMeaning => 'Cari berdasarkan pinyin atau arti...';

  @override
  String get searchByTitleOrTag => 'Cari berdasarkan judul atau tag...';

  @override
  String get searchDictionaryOrTypeCustom => 'Cari di kamus atau ketik kustom';

  @override
  String get searchHint => 'Cari...';

  @override
  String get searchOrEnterUrl => 'Cari atau masukkan URL';

  @override
  String get searchScenariosHint => 'Cari skenario...';

  @override
  String get searchStoriesIdiomsNews => 'Cari cerita, idiom, berita...';

  @override
  String get searchTopicsEgCookingHistory =>
      'Cari topik (mis. Memasak, Sejarah)';

  @override
  String get seeAll => 'Lihat semua';

  @override
  String get selectADeck => 'Pilih Dek';

  @override
  String get selectPracticeMode => 'Pilih Mode Latihan';

  @override
  String get selectingHskVocabulary => 'Memilih kosakata HSK...';

  @override
  String get send => 'Kirim';

  @override
  String get sendMessage => 'Kirim Pesan';

  @override
  String get serif => 'Serif';

  @override
  String get shadow => 'Shadowing';

  @override
  String get shiNaianEpic =>
      'Shi Nai\'an (sekitar 1296–1372) adalah sastrawan Dinasti Yuan yang tercatat lulus ujian kekaisaran namun memilih hidup menyendiri sebagai cendekiawan. Batas Air (Water Margin), mahakaryanya tentang para pendekar pemberontak dan perjuangan keadilan, meletakkan dasar bagi epos persilatan Tiongkok.';

  @override
  String get showEnglish => 'Tampilkan Bahasa Inggris';

  @override
  String get showEnglishTranslations => 'Tampilkan Terjemahan Bahasa Inggris';

  @override
  String get showHanzi => 'Tampilkan Hanzi';

  @override
  String get showPinyin => 'Tampilkan Pinyin';

  @override
  String get showTranslation => 'Tampilkan Terjemahan';

  @override
  String get shows => 'Acara';

  @override
  String get signIn => 'Masuk';

  @override
  String get simplifiedArticle => 'Artikel yang Disederhanakan';

  @override
  String get simplifyingSubtitles => 'Menyederhanakan subtitel...';

  @override
  String get sincereHonest => 'tulus; jujur';

  @override
  String get sleepTimer => 'Pengatur Waktu Tidur';

  @override
  String get smartDeck => 'Dek Pintar';

  @override
  String get spanishAndWorld => 'Bahasa Spanyol & Dunia';

  @override
  String get speaker => 'Pengeras Suara';

  @override
  String get spotifyStylePlayer => 'Pemutar Bergaya Spotify';

  @override
  String get storyBookmarkedInLibrary =>
      'Cerita berhasil ditandai di Perpustakaan!';

  @override
  String get streetFoodNightMarketInXian => 'Pasar Malam Street Food di Xi\'an';

  @override
  String get strokes => 'Goresan';

  @override
  String get studyCharacter => 'Pelajari Karakter';

  @override
  String get subtitleOpacity => 'Transparansi Subtitel';

  @override
  String get suggestion => 'Saran';

  @override
  String get summary => 'Ringkasan';

  @override
  String get supernaturalAndFolklore => 'Kisah Gaib & Cerita Rakyat';

  @override
  String get swipeToGrade => 'Geser untuk Menilai:';

  @override
  String get tableOfContents => 'Daftar Isi';

  @override
  String get tapToRetry => 'Ketuk untuk Coba Lagi';

  @override
  String get teaTastingInChengdu => 'Mencicipi Teh di Chengdu';

  @override
  String get techAndGadgets => 'Teknologi & Gadget';

  @override
  String get terms => 'Ketentuan Layanan';

  @override
  String get theGalaxyCharacters =>
      'Peta Galaksi menanti Anda.\nKuasai Matahari (Radikal) untuk membuka Planet (Karakter).';

  @override
  String get theme => 'Tema';

  @override
  String get thinking => 'Sedang berpikir...';

  @override
  String get thisArticleCharacters =>
      'Artikel ini memuat karakter Mandarin Tradisional.';

  @override
  String get todaysWord => 'KATA HARI INI';

  @override
  String get togglePinyin => 'Alihkan Pinyin';

  @override
  String get toggleTranslation => 'Alihkan Terjemahan';

  @override
  String get toneDoesNotExistInMandarin =>
      'Nada ini tidak ada dalam bahasa Mandarin standar.';

  @override
  String get toneGraph => 'Grafik Nada';

  @override
  String get traceLabel => 'Tebalkan';

  @override
  String get trailer => 'TRAILER';

  @override
  String get translatingAndAddingPinyin =>
      'Menerjemahkan dan menambahkan Pinyin...';

  @override
  String get translatingText => 'Menerjemahkan teks...';

  @override
  String get turnOn => 'Aktifkan';

  @override
  String get typeHanziPinyinOrEnglish =>
      'Ketik Hanzi, Pinyin, atau bahasa Indonesia...';

  @override
  String get unknown2 => '游戏 实况 王者荣耀 原神';

  @override
  String get unknown3 => '中国 美食 菜谱';

  @override
  String get unknown4 => '中国 科技 测评';

  @override
  String get unrollingTheScroll => 'Membuka gulungan...';

  @override
  String get upperIntermediate => 'Menengah Atas';

  @override
  String get vibrationsForInteractions => 'Getaran untuk interaksi';

  @override
  String get video => 'Video';

  @override
  String get viewAnswer => 'Lihat Jawaban';

  @override
  String get viewAsList => 'Lihat sebagai Daftar';

  @override
  String get viewBookmarks => 'Lihat Markah Buku';

  @override
  String get viewMyDrawing => 'Lihat Gambar Saya';

  @override
  String get vlog => 'Vlog harian Tiongkok';

  @override
  String get voice => 'Suara:';

  @override
  String get web => 'Web';

  @override
  String get wedLoveToHearFromYou => 'Kami senang\nmendengar dari Anda.';

  @override
  String get welcomeBack => 'Selamat Datang Kembali';

  @override
  String get whatDoesThisMean => 'Apa artinya ini?';

  @override
  String get whatHappensToMyChatHistory =>
      'Apa yang terjadi dengan riwayat obrolan saya?';

  @override
  String get whatIfAiMishears =>
      'Apa yang dapat saya lakukan jika AI salah memahami ucapan saya?';

  @override
  String get whichCharacterIs => 'Karakter manakah yang:';

  @override
  String get wikipedia => 'Wikipedia';

  @override
  String get wordsSavedAndSrsScheduled =>
      'Kata berhasil disimpan dan jadwal SRS telah dibuat!';

  @override
  String get writeYourMessageHere => 'Tulis pesan Anda di sini...';

  @override
  String get wuChengenLiterature =>
      'Wu Cheng\'en (sekitar 1500–1582) adalah novelis Dinasti Ming asal Huai\'an, Jiangsu. Memadukan cerita rakyat, alegori Buddhis, dan satire jenaka, ia menyusun kisah mitologi ziarah Tang menjadi Perjalanan ke Barat (Journey to the West) — salah satu mahakarya paling imajinatif dalam sejarah sastra dunia.';

  @override
  String get wuJingziClass =>
      'Wu Jingzi (1701–1754) adalah novelis Dinasti Qing asal Anhui yang menolak harta warisan dan mendedikasikan hidupnya untuk menulis Kisah Para Cendekiawan (The Scholars - Rulin Waishi) — novel satir tajam yang membongkar kepalsuan, korupsi, dan kepongahan sistem ujian kekaisaran serta kaum birokrat terpelajar.';

  @override
  String get xuZhonglinWarfare =>
      'Xu Zhonglin (abad ke-16–17) adalah penulis Dinasti Ming yang dipercaya menyusun Penganugerahan Para Dewa (Investiture of the Gods - Fengshen Yanyi), sebuah epos mitologi monumental yang memadukan sejarah Shang-Zhou dengan kosmologi Taoisme, tatanan dewata langit, dan kisah peperangan heroik.';

  @override
  String get yearly => 'Tahunan';

  @override
  String get yesReGradeMe => 'Ya, Nilai Ulang Saya!';

  @override
  String you(Object lang) {
    return 'Anda ($lang)';
  }

  @override
  String get youAreSpeaking => 'Anda sedang berbicara';

  @override
  String get youLabel => 'Anda';

  @override
  String youLang(String lang) {
    return 'Anda ($lang)';
  }

  @override
  String get youMustAccount =>
      'Anda harus menyetujui Ketentuan Layanan dan Kebijakan Privasi untuk membuat akun.';

  @override
  String get yourEchoModels =>
      'Riwayat percakapan Bermain Peran yang Anda simpan tetap tersimpan secara lokal di perangkat agar dapat ditinjau kembali. Kami tidak menggunakan percakapan pribadi Anda untuk melatih model AI kami.';

  @override
  String get zhOnly => 'Hanya Mandarin (ZH)';

  @override
  String get hsk_1300_cards => '1300 kartu';

  @override
  String get hsk_154_cards => '154 kartu';

  @override
  String get hsk_162_cards => '162 kartu';

  @override
  String get hsk_2500_cards => '2500 kartu';

  @override
  String get hsk_299_cards => '299 kartu';

  @override
  String get hsk_602_cards => '602 kartu';

  @override
  String get added_to_review_queue => 'Ditambahkan ke antrean ulasan';

  @override
  String added_cards_to(int cardCount, String deckName) {
    return 'Menambahkan $cardCount kartu ke «$deckName».';
  }

  @override
  String added_to_your_library(Object hanzi) {
    return '«$hanzi» ditambahkan ke Perpustakaan Anda';
  }

  @override
  String get advanced => 'Tingkat Mahir';

  @override
  String get ai_stories => 'Cerita AI';

  @override
  String analysis_failed(Object error) {
    return 'Analisis Gagal: $error';
  }

  @override
  String get analyzing_pronunciation_with_gemini_ai =>
      'Menganalisis pengucapan dengan Gemini AI...';

  @override
  String get analyzing_your_pronunciation => 'Menganalisis pengucapan Anda...';

  @override
  String are_you_sure_you_want_to(String deckName) {
    return 'Apakah Anda yakin ingin menghapus «$deckName» secara permanen? Tindakan ini tidak dapat dibatalkan dan akan menghapus semua kartu di dalamnya.';
  }

  @override
  String ask_about(String hanzi) {
    return 'Tanyakan tentang $hanzi...';
  }

  @override
  String get audio_haptics => 'Audio & Haptik';

  @override
  String get audio_could_not_start_check_your =>
      'Audio tidak dapat dimulai. Periksa koneksi dan pengaturan audio perangkat Anda.';

  @override
  String get calligraphy_trace => 'Tebalkan Kaligrafi';

  @override
  String chapters(Object count) {
    return '$count Bab';
  }

  @override
  String get char => 'Karakter';

  @override
  String get chinese_character => 'KARAKTER MANDARIN';

  @override
  String get contact_us_and_report_issues =>
      'Hubungi kami dan laporkan masalah';

  @override
  String created_smart_deck_with_words(String deckName, int wordCount) {
    return 'Dek pintar berhasil dibuat: «$deckName» dengan $wordCount kata!';
  }

  @override
  String get custom_ai_generated_story => 'Cerita kustom buatan AI.';

  @override
  String get display_content => 'Tampilan & Konten';

  @override
  String get do_you_keep_or_store_my =>
      'Apakah Anda menyimpan rekaman suara saya?';

  @override
  String get elementary => 'Tingkat Pemula';

  @override
  String error_creating_scenario(Object error) {
    return 'Kesalahan saat membuat skenario: $error';
  }

  @override
  String error_fetching_translation_for(Object error) {
    return 'Kesalahan saat mengambil terjemahan: $error';
  }

  @override
  String error_loading_chapters(Object error) {
    return 'Kesalahan saat memuat bab: $error';
  }

  @override
  String get error_loading_decks => 'Kesalahan saat memuat dek';

  @override
  String error_loading_microreads(Object error) {
    return 'Kesalahan saat memuat bacaan mikro: $error';
  }

  @override
  String error_loading_novels(Object error) {
    return 'Kesalahan saat memuat novel: $error';
  }

  @override
  String error_loading_poetry(Object error) {
    return 'Kesalahan saat memuat puisi: $error';
  }

  @override
  String get etymology => 'Etimologi: ';

  @override
  String get explanation => 'Penjelasan';

  @override
  String get extracted_text_tap_to_lookup =>
      'Teks yang Diekstrak (Ketuk untuk mencari)';

  @override
  String extraction_failed(Object error) {
    return 'Ekstraksi Gagal: $error';
  }

  @override
  String get failed_to_download => 'Gagal mengunduh.';

  @override
  String failed_to_generate_scenario(Object error) {
    return 'Gagal membuat skenario: $error';
  }

  @override
  String failed_to_generate_story(Object error) {
    return 'Gagal membuat cerita:\n$error';
  }

  @override
  String failed_to_load_context(Object error) {
    return 'Gagal memuat konteks: $error';
  }

  @override
  String get feature_request => 'Saran Fitur';

  @override
  String get foundation => 'Tingkat Dasar';

  @override
  String get how_is_my_pronunciation_scored =>
      'Bagaimana pengucapan saya dinilai?';

  @override
  String hsk(Object level) {
    return 'HSK $level';
  }

  @override
  String hsk_vocabulary(int hskLevel) {
    return 'Kosakata HSK $hskLevel';
  }

  @override
  String get hsk_level => 'TINGKAT HSK';

  @override
  String get intermediate => 'Tingkat Menengah';

  @override
  String get learning_stats => 'Statistik Belajar';

  @override
  String get mandarin => 'Mandarin';

  @override
  String get meaning => 'Arti';

  @override
  String get no_decks_found => 'Tidak ada dek yang ditemukan.';

  @override
  String no_results_found_for(Object searchQuery) {
    return 'Tidak ada hasil untuk «$searchQuery»';
  }

  @override
  String get no_when_you_use_echo_hall =>
      'Rekaman yang dikirim untuk penilaian pelafalan diproses dengan aman dan tidak disimpan oleh SinoSpark setelah pemrosesan selesai. Riwayat Bermain Peran yang Anda pilih untuk disimpan dapat tetap berada di perangkat dan dapat dihapus di aplikasi.';

  @override
  String get notification_settings => 'Pengaturan Notifikasi';

  @override
  String get open_settings => 'Buka Pengaturan';

  @override
  String get phoneme => 'Fonem';

  @override
  String get play_reference_pronunciation => 'Putar Pengucapan Referensi';

  @override
  String get please_select_a_deck_to_add =>
      'Silakan pilih dek untuk menambahkan kartu.';

  @override
  String get point_at_chinese_text_to_translate =>
      'Arahkan ke teks Mandarin untuk menerjemahkan';

  @override
  String get practice_writing_the_strokes_by_hand =>
      'Latih menulis goresan dengan tangan';

  @override
  String get preferences_audio_and_display => 'Preferensi, Audio, dan Tampilan';

  @override
  String get preparing_your_scholars_verdict =>
      'Menyiapkan Penilaian Cendekiawan...';

  @override
  String get previous => 'Sebelumnya';

  @override
  String question(Object current, Object total) {
    return 'Pertanyaan $current/$total';
  }

  @override
  String remove_from_this_deck(String hanzi) {
    return 'Hapus «$hanzi» dari dek ini?';
  }

  @override
  String revenuecat_error(Object error) {
    return 'Kesalahan RevenueCat: $error';
  }

  @override
  String get review_tomorrow => 'Tinjau Besok';

  @override
  String get roleplay => 'Bermain Peran';

  @override
  String saving_words_to(int wordCount, String deckName) {
    return 'Menyimpan $wordCount kata ke «$deckName»...';
  }

  @override
  String get search_radicals_eg_water => 'Cari radikal (mis. Air, 氵)';

  @override
  String get select_target_hsk_level => 'Pilih Target Tingkat HSK';

  @override
  String get sentence => 'Kalimat';

  @override
  String get shadowing_studio_is_a_dedicated_space =>
      'Studio Shadowing adalah ruang khusus untuk melatih pengucapan dengan menirukan penutur asli secara real-time.';

  @override
  String simplify_failed(Object error) {
    return 'Penyederhanaan Gagal: $error';
  }

  @override
  String get sinospark_premium => 'SinoSpark Premium';

  @override
  String get speaking_pronunciation => 'Berbicara & Pengucapan';

  @override
  String get statistics => 'Statistik';

  @override
  String get table_of_contents => 'Daftar Isi · 目录';

  @override
  String get the_ai_evaluates_your_speech_across =>
      'AI mengevaluasi ucapan Anda berdasarkan tiga aspek:\n• Akurasi: Apakah Anda melafalkan suku kata dengan benar?\n• Kelengkapan: Apakah ada kata yang terlewatkan?\n• Kelancaran: Apakah Anda berhenti sejenak secara alami dan menerapkan nada dengan tepat?\nAI membandingkan rekaman Anda dengan standar penutur asli untuk memberikan skor dari 100.';

  @override
  String get this_cannot_be_undone => 'Tindakan ini tidak dapat dibatalkan.';

  @override
  String get title => 'Judul';

  @override
  String get to_be_reviewed => 'Perlu Ditinjau';

  @override
  String get traditional => 'Tradisional';

  @override
  String translation_failed(Object error) {
    return 'Terjemahan Gagal: $error';
  }

  @override
  String get type_in => 'Ketik...';

  @override
  String get type_your_message_in => 'Ketik pesan Anda dalam...';

  @override
  String get unable_to_open_this_video_please =>
      'Tidak dapat membuka video ini. Silakan coba lagi nanti.';

  @override
  String get view_your_learning_history_and_streaks =>
      'Lihat riwayat belajar dan streak Anda';

  @override
  String get what_is_shadowing_studio => 'Apa itu Studio Shadowing?';

  @override
  String get words => 'kata';

  @override
  String your_path_for_is_ready(String deckName) {
    return 'Jalur belajar Anda untuk «$deckName» sudah siap!';
  }

  @override
  String get you_said => '🗣️ Anda Mengucapkan';

  @override
  String vocabularyBatch(Object index) {
    return 'Batch Kosakata $index';
  }

  @override
  String get yourDailyDropIsHere => 'Sajian Harian Anda telah tiba! ✨';

  @override
  String get timeToReview => 'Waktunya Mengulas! 📚';

  @override
  String get neverMissAStroke => 'Jangan lewatkan satu goresan pun! 🖌️';

  @override
  String get yourTrialEndsTomorrow => 'Masa uji coba Anda berakhir besok! ⏳';

  @override
  String get officialStandardVocabularyTiers =>
      'Tingkatan kosakata standar resmi';

  @override
  String get failedToLoadCollections => 'Gagal memuat koleksi.';

  @override
  String unnamedKey(Object tag) {
    return '#$tag';
  }

  @override
  String error(Object error) {
    return 'Kesalahan: $error';
  }

  @override
  String get aiSmartContext => 'Konteks Pintar AI';

  @override
  String get aiSmartContextError => 'Kesalahan Konteks Pintar AI';

  @override
  String get downloadOfficialHskCollections => 'Unduh koleksi resmi HSK';

  @override
  String get unableToLoadThisSection =>
      'Tidak dapat memuat bagian ini. Silakan coba lagi.';

  @override
  String get translationLanguage => 'Bahasa Terjemahan';

  @override
  String get dailyDrops => 'Sajian Harian';

  @override
  String get wordOfTheDayNews => 'Kata Hari Ini & Berita';

  @override
  String get reviewReminders => 'Pengingat Ulasan';

  @override
  String get flashcardsDueForReview =>
      'Flashcard yang jatuh tempo untuk ditinjau';

  @override
  String get dailyNewCards => 'Kartu Baru Harian';

  @override
  String get dailyReviewLimit => 'Batas Ulasan Harian';

  @override
  String get practiceMode => 'Mode Latihan';

  @override
  String get liziqi => 'Li Ziqi (李子柒): Bunga Sutra';

  @override
  String get theLifeOfGarlicTraditional =>
      'Kehidupan Bawang Putih: Tradisi Hidup Pedesaan Tiongkok';

  @override
  String get graceMandarin50Phrases => 'Grace Mandarin: 50 Frasa';

  @override
  String get essentialChinesePhrasesForBeginners =>
      'Frasa Mandarin Esensial untuk Pemula';

  @override
  String get makingBambooFurniture => 'Membuat Furnitur Bambu';

  @override
  String get peppaPigChinese => 'Peppa Pig Mandarin: Petak Umpet (躲猫猫)';

  @override
  String get muddyPuddlesBeginnerFriendly => 'Kubangan Lumpur (Tingkat Pemula)';

  @override
  String get mandarinCorner300Verbs => 'Mandarin Corner: 300 Kata Kerja';

  @override
  String get mostCommonChineseVerbs =>
      'Kata Kerja Mandarin yang Paling Sering Digunakan';

  @override
  String get graceMandarinOrderFood => 'Grace Mandarin: Memesan Makanan';

  @override
  String get howToOrderFoodIn => 'Cara Memesan Makanan di Restoran Tiongkok';

  @override
  String get silkFlowersTraditionalCraft =>
      'Bunga Sutra: Kerajinan Tangan Tradisional';

  @override
  String get mandarinCorner =>
      'Mandarin Corner: Belajar Mandarin - Pergi ke Dokter';

  @override
  String get goingToTheDoctorReal => 'Pergi ke Dokter: Percakapan Nyata';

  @override
  String get hideAndSeekBeginnerFriendly => 'Petak Umpet (Tingkat Pemula)';

  @override
  String get linGdp6 => 'Xiao Lin Menjelaskan: Mengapa Pertumbuhan PDB 6%?';

  @override
  String get why6GdpGrowthEasy =>
      'Mengapa Pertumbuhan PDB 6%? - Ekonomi Tiongkok yang Mudah Dipahami';

  @override
  String get bbcWorldNews => 'BBC 中文 (Berita Dunia)';

  @override
  String get currentEventsInSimplifiedChinese =>
      'Berita Terkini dalam Aksara Hanzi Sederhana';

  @override
  String get baidu => 'Baidu';

  @override
  String get youtubeDesk => 'MEJA YOUTUBE';

  @override
  String get interactiveTranscriptsShadowing =>
      'Transkrip interaktif & shadowing';

  @override
  String get showsDramas => 'SERIAL & DRAMA';

  @override
  String get extractToDeck => 'Ekstrak ke Dek';

  @override
  String get autoSimplify => 'Sederhanakan Otomatis';

  @override
  String get rewriteThisArticleToMatch =>
      'Tulis ulang artikel ini agar sesuai dengan tingkat HSK Anda';

  @override
  String failedToSaveExtractedWords(Object error) {
    return 'Gagal menyimpan kata-kata yang diekstrak: $error';
  }

  @override
  String addToDeck(Object count) {
    return 'Tambahkan ke Dek ($count)';
  }

  @override
  String get dailyDiscoveryDrop => 'Sajian Penemuan Harian';

  @override
  String get smartSpacedRepetition =>
      'Pengulangan Berjarak Cerdas (Spaced Repetition)';

  @override
  String get trialProtectionAlert => 'Peringatan Perlindungan Uji Coba';

  @override
  String get masteryLevel => 'Tingkat Penguasaan';

  @override
  String get targetObjective => 'Target Pembelajaran';

  @override
  String get dailyPractice => 'Latihan Harian';

  @override
  String get aiSpacedRepetition => 'Pengulangan Berjarak AI';

  @override
  String get iVeGrantedAccess => 'Saya telah memberikan akses';

  @override
  String get scanner => 'Pemindai';

  @override
  String get interpreter => 'Penerjemah';

  @override
  String cards(Object count) {
    return '$count kartu';
  }

  @override
  String get nWaMendsTheHeavens => 'Nüwa Menambal Langit';

  @override
  String get terracottaArmy => 'Prajurit Terakota';

  @override
  String get forbiddenCity => 'Kota Terlarang';

  @override
  String get aBlessingInDisguise => 'Hikmah di Balik Musibah (塞翁失马)';

  @override
  String get drawingASnake => 'Menggambar Kaki pada Ular (画蛇添足)';

  @override
  String get takingTheBulletTrain => 'Naik Kereta Cepat';

  @override
  String get visitingTheDoctor => 'Pergi ke Dokter';

  @override
  String get orderingDumplings => 'Memesan Jiaozi (Pangsit)';

  @override
  String get theTeaCeremony => 'Upacara Minum Teh Tradisional';

  @override
  String get chineseCalligraphy => 'Kaligrafi Mandarin';

  @override
  String get theGiantPanda => 'Panda Raksasa';

  @override
  String get simplifiedText => 'Teks Sederhana';

  @override
  String get novels96 => 'Novel (96)';

  @override
  String get microReads => 'Bacaan Mikro';

  @override
  String get poetry => 'Puisi';

  @override
  String get bookmarkRemoved => '书签已移除 · Markah buku dihapus';

  @override
  String bookmarkAdded(Object chapter) {
    return '已添加书签 · Markah buku ditambahkan: Bab $chapter';
  }

  @override
  String get readingVocabulary => 'Membaca & Kosakata';

  @override
  String vocabularyBatchUnitindex1(Object index) {
    return 'Batch Kosakata $index';
  }

  @override
  String get yourDailyDropIsHere1 => 'Sajian Harian Anda telah tiba! ✨';

  @override
  String get timeToReview1 => 'Waktunya Mengulas! 📚';

  @override
  String get neverMissAStroke1 => 'Jangan lewatkan satu goresan pun! 🖌️';

  @override
  String get yourTrialEndsTomorrow1 => 'Masa uji coba Anda berakhir besok! ⏳';

  @override
  String get hskCollections1 => 'Koleksi HSK';

  @override
  String get officialStandardVocabularyTiers1 =>
      'Tingkatan kosakata standar resmi';

  @override
  String get failedToLoadCollections1 => 'Gagal memuat koleksi.';

  @override
  String ui__transcription(Object transcription) {
    return '\"$transcription\"';
  }

  @override
  String playPinyinwithtone(Object pinyinWithTone) {
    return 'Putar $pinyinWithTone';
  }

  @override
  String errorE(Object e) {
    return 'Kesalahan: $e';
  }

  @override
  String lookalikepinyin(Object pinyin) {
    return '($pinyin)';
  }

  @override
  String get aiSmartContext1 => 'Konteks Pintar AI';

  @override
  String get aiSmartContextError1 => 'Kesalahan Konteks Pintar AI';

  @override
  String errorErr(Object err, Object error) {
    return 'Kesalahan: $error';
  }

  @override
  String get downloadOfficialHskCollections1 => 'Unduh koleksi resmi HSK';

  @override
  String get unableToLoadThisSectionPleaseTryAga =>
      'Tidak dapat memuat bagian ini. Silakan coba lagi.';

  @override
  String get searchRadicalsEgWater => 'Cari radikal (mis. Air, 氵)';

  @override
  String ui__currentstrokeindex1totalstrokes(Object current, Object total) {
    return '$current/$total';
  }

  @override
  String get translationLanguage1 => 'Bahasa Terjemahan';

  @override
  String get appLanguage1 => 'Bahasa Aplikasi';

  @override
  String get dailyDrops1 => 'Sajian Harian';

  @override
  String get wordOfTheDayNews1 => 'Kata Hari Ini & Berita';

  @override
  String get reviewReminders1 => 'Pengingat Ulasan';

  @override
  String get flashcardsDueForReview1 => 'Flashcard yang siap diulang';

  @override
  String get accuracyByMode1 => 'Akurasi Berdasarkan Mode';

  @override
  String accuracytostringasfixed1(Object accuracy) {
    return '$accuracy%';
  }

  @override
  String get upcomingReviewsNext7Days => 'Ulasan Mendatang (7 Hari ke Depan)';

  @override
  String get explaining => 'Penjelasan:';

  @override
  String entryhanziEntrypinyin(Object hanzi, Object pinyin) {
    return '$hanzi [$pinyin]';
  }

  @override
  String get dailyNewCards1 => 'Kartu Baru Harian';

  @override
  String get dailyReviewLimit1 => 'Batas Ulasan Harian';

  @override
  String get listeningMode1 => 'Mode Mendengar';

  @override
  String get readingMode1 => 'Mode Membaca';

  @override
  String get recallMode1 => 'Mode Mengingat';

  @override
  String get speakingMode1 => 'Mode Berbicara';

  @override
  String get practiceMode1 => 'Mode Latihan';

  @override
  String acc(Object acc) {
    return '$acc%';
  }

  @override
  String get partner1 => 'Mitra';

  @override
  String get partnerSpeaking1 => 'Mitra sedang berbicara…';

  @override
  String get theLifeOfGarlicTraditionalChineseLi =>
      'Kehidupan Bawang Putih: Tradisi Hidup Pedesaan Tiongkok';

  @override
  String get graceMandarin50Phrases1 => 'Grace Mandarin: 50 Frasa';

  @override
  String get essentialChinesePhrasesForBeginners1 =>
      'Frasa Mandarin Penting untuk Pemula';

  @override
  String get makingBambooFurniture1 => 'Membuat Furnitur Bambu';

  @override
  String get muddyPuddlesBeginnerFriendly1 =>
      'Kubangan Lumpur (Tingkat Pemula)';

  @override
  String get mandarinCorner300Verbs1 => 'Mandarin Corner: 300 Kata Kerja';

  @override
  String get mostCommonChineseVerbs1 =>
      'Kata Kerja Mandarin yang Paling Sering Digunakan';

  @override
  String get graceMandarinOrderFood1 => 'Grace Mandarin: Memesan Makanan';

  @override
  String get howToOrderFoodInAChineseRestaurant =>
      'Cara memesan makanan di restoran Tiongkok';

  @override
  String get silkFlowersTraditionalCraft1 =>
      'Bunga Sutra: Kerajinan Tangan Tradisional';

  @override
  String get goingToTheDoctorRealLifeConversatio =>
      'Pergi ke Dokter: Percakapan Nyata';

  @override
  String get hideAndSeekBeginnerFriendly1 => 'Petak Umpet (Tingkat Pemula)';

  @override
  String get lingdp6 => 'Xiao Lin Menjelaskan: Mengapa Pertumbuhan PDB 6%?';

  @override
  String get why6GdpGrowthEasyChineseEconomics =>
      'Mengapa Pertumbuhan PDB 6%? - Ekonomi Tiongkok yang Mudah Dipahami';

  @override
  String get currentEventsInSimplifiedChinese1 =>
      'Peristiwa Terkini dalam Aksara Hanzi Sederhana';

  @override
  String get baidu1 => 'Baidu';

  @override
  String get youtubeDesk1 => 'MEJA YOUTUBE';

  @override
  String get interactiveTranscriptsShadowing1 =>
      'Transkrip interaktif & shadowing';

  @override
  String get showsDramas1 => 'SERIAL & DRAMA';

  @override
  String error_error(Object error) {
    return 'Kesalahan: $error';
  }

  @override
  String get extractToDeck1 => 'Ekstrak ke Dek';

  @override
  String get autosimplify => 'Sederhanakan Otomatis';

  @override
  String get rewriteThisArticleToMatchYourHskLev =>
      'Tulis ulang artikel ini agar sesuai dengan tingkat HSK Anda';

  @override
  String get addToDeck1 => 'Tambahkan ke Dek';

  @override
  String playbackratex(Object playbackRate) {
    return '${playbackRate}x';
  }

  @override
  String speedx(Object speed) {
    return '${speed}x';
  }

  @override
  String get dailyDiscoveryDrop1 => 'Sajian Penemuan Harian';

  @override
  String get smartSpacedRepetition1 => 'Pengulangan Berjarak Cerdas';

  @override
  String get trialProtectionAlert1 => 'Peringatan Perlindungan Uji Coba';

  @override
  String get masteryLevel1 => 'Tingkat Penguasaan';

  @override
  String get targetObjective1 => 'Target Sasaran';

  @override
  String get dailyPractice1 => 'Latihan Harian';

  @override
  String get aiSpacedRepetition1 => 'Pengulangan Berjarak AI';

  @override
  String get iveGrantedAccess => 'Saya telah memberikan akses';

  @override
  String addToDeck_selectedwordindiceslength(Object count) {
    return 'Tambahkan ke Dek ($count)';
  }

  @override
  String get scanner1 => 'Pemindai';

  @override
  String get interpreter1 => 'Penerjemah';

  @override
  String entryvalueCards(Object count) {
    return '$count kartu';
  }

  @override
  String score_score_questionslength(Object score, Object total) {
    return 'Skor: $score / $total';
  }

  @override
  String get theMonkeyKing1 => 'Raja Kera';

  @override
  String get huaMulan1 => 'Hua Mulan';

  @override
  String get nwaMendsTheHeavens => 'Nüwa Menambal Langit';

  @override
  String get confucius => 'Konfusius';

  @override
  String get theGreatWall1 => 'Tembok Besar';

  @override
  String get terracottaArmy1 => 'Prajurit Terakota';

  @override
  String get forbiddenCity1 => 'Kota Terlarang';

  @override
  String get aBlessingInDisguise1 => 'Hikmah di Balik Musibah';

  @override
  String get drawingASnake1 => 'Menggambar Kaki pada Ular';

  @override
  String get takingTheBulletTrain1 => 'Naik Kereta Cepat';

  @override
  String get visitingTheDoctor1 => 'Pergi ke Dokter';

  @override
  String get orderingDumplings1 => 'Memesan Jiaozi (Pangsit)';

  @override
  String get theTeaCeremony1 => 'Upacara Minum Teh';

  @override
  String get chineseCalligraphy1 => 'Kaligrafi Mandarin';

  @override
  String get theGiantPanda1 => 'Panda Raksasa';

  @override
  String get simplifiedText1 => 'Teks Sederhana';

  @override
  String get novels961 => 'Novel (96)';

  @override
  String get microreads => 'Bacaan Mikro';

  @override
  String get poetry1 => 'Puisi';

  @override
  String get readingVocabulary1 => 'Membaca & Kosakata';

  @override
  String get defaultfirebaseoptionsHaveNotBeenCo =>
      'DefaultFirebaseOptions belum dikonfigurasi untuk Linux.';

  @override
  String get defaultfirebaseoptionsAreNotSupport =>
      'DefaultFirebaseOptions tidak didukung untuk platform ini.';

  @override
  String get hanziMaster1 => 'SinoSpark';

  @override
  String get strokesCannotBeEmpty => 'Goresan tidak boleh kosong.';

  @override
  String get wrongStartPoint => 'Titik awal salah.';

  @override
  String get rightShapeButWrongPlace =>
      'Bentuk sudah benar, tetapi posisinya salah!';

  @override
  String get goodFollowTheFlow => 'Bagus! Ikuti alur goresannya.';

  @override
  String get aBitShaky => 'Goresan sedikit goyah!';

  @override
  String get aBitHesitant => 'Sedikit ragu-ragu...';

  @override
  String get shapeIsOff => 'Bentuk goresan kurang tepat.';

  @override
  String get arabic => 'Arab';

  @override
  String get german => 'Jerman';

  @override
  String get spanish => 'Spanyol';

  @override
  String get french => 'Prancis';

  @override
  String get hindi => 'Hindi';

  @override
  String get indonesian => 'Bahasa Indonesia';

  @override
  String get italian => 'Italia';

  @override
  String get japanese => 'Jepang';

  @override
  String get korean => 'Korea';

  @override
  String get portuguese => 'Portugis';

  @override
  String get russian => 'Rusia';

  @override
  String get vietnamese => 'Vietnam';

  @override
  String get microphonePermissionDenied => 'Izin mikrofon ditolak';

  @override
  String get offset => 'Imbuhan';

  @override
  String get audioserviceHasBeenDisposed => 'AudioService telah ditutup';

  @override
  String get fenrirZhcnyunxineural => 'Fenrir (zh-CN-YunxiNeural)';

  @override
  String get charonZhcnyunyangneural => 'Charon (zh-CN-YunyangNeural)';

  @override
  String get koreZhcnxiaoxiaoneural => 'Kore (zh-CN-XiaoxiaoNeural)';

  @override
  String get aoedeZhcnxiaoyineural => 'Aoede (zh-CN-XiaoyiNeural)';

  @override
  String get puckZhcnyunjianneural => 'Puck (zh-CN-YunjianNeural)';

  @override
  String get kore => 'Kore (perempuan, ramah)';

  @override
  String get xmicrosoftoutputformatAudio24khz48k =>
      'audio-24khz-48kbitrate-mono-mp3';

  @override
  String get useragentHanzimasterapp => 'HanziMasterApp';

  @override
  String get anchorWord => 'Kata Jangkar';

  @override
  String get creativeThematicTitle => 'Judul Tematik Kreatif';

  @override
  String get briefPedagogicalOrSemanticRationale =>
      'Alasan pedagogis atau semantik ringkas';

  @override
  String get theSingleMostCentralCharacterFromTh =>
      'Karakter paling utama dari daftar';

  @override
  String get aBalancedSetOfCharactersFromYourLib =>
      'Kumpulan karakter yang seimbang dari perpustakaan Anda.';

  @override
  String get yourNaturalConversationalReplyInChi =>
      'Balasan percakapan alami Anda dalam karakter Mandarin.';

  @override
  String get theEnglishTranslationOfYourReply =>
      'Terjemahan bahasa Indonesia dari balasan Anda.';

  @override
  String get thePinyinWithToneMarksForYourReply =>
      'Pinyin dengan tanda nada untuk balasan Anda.';

  @override
  String get aSuggestedResponseTheUserCouldSayBa =>
      'Saran balasan yang dapat diucapkan pengguna kepada Anda.';

  @override
  String get pinyinForTheSuggestion => 'Pinyin untuk saran balasan.';

  @override
  String get englishTranslationForTheSuggestion =>
      'Terjemahan bahasa Indonesia untuk saran balasan.';

  @override
  String get scholarsCritique => 'Evaluasi Kritis Cendekiawan';

  @override
  String get theEchoHallRemainsSilentTryYourBrea =>
      'Aula Gema tetap hening. Tarik napas dan coba lagi.';

  @override
  String get xtitleHanziMaster => 'SinoSpark';

  @override
  String get noneYet => 'Belum ada.';

  @override
  String get exactSentence => 'Kalimat Tepat:';

  @override
  String get englishTranslation => 'Terjemahan Bahasa Indonesia';

  @override
  String get previouslyGeneratedPhrases => 'Frasa yang dibuat sebelumnya';

  @override
  String get iLikeDrinkingAppleJuice => 'Saya suka minum jus apel.';

  @override
  String get theEnglishMeaningHere => 'Arti dalam bahasa Indonesia di sini...';

  @override
  String get failedToFetchDefinition => 'Gagal mengambil definisi.';

  @override
  String get failedToLoadExplanation => 'Gagal memuat penjelasan.';

  @override
  String get failedToLoadComparison => 'Gagal memuat perbandingan.';

  @override
  String get emptyResponseFromOpenrouter => 'Respons kosong dari OpenRouter';

  @override
  String get emptyResponseFromVisionModel => 'Respons kosong dari model Vision';

  @override
  String get standard => 'Standar';

  @override
  String get theFullSentenceInChinese =>
      'Kalimat lengkap dalam bahasa Mandarin...';

  @override
  String get theWordOrCharacterInChinese =>
      'Kata atau karakter dalam bahasa Mandarin';

  @override
  String get thePinyinForThisSpecificWord => 'Pinyin untuk kata khusus ini';

  @override
  String get emptyResponseFromDeepseekApi => 'Respons kosong dari DeepSeek API';

  @override
  String get criticalPutTheEnglishTranslationInT =>
      'PENTING: Letakkan terjemahan bahasa Indonesia di';

  @override
  String get englishTranslationOfTheEntireSenten =>
      'Terjemahan bahasa Indonesia dari seluruh kalimat';

  @override
  String get hanziWord => 'Kata Hanzi';

  @override
  String get theFullSimplifiedSentenceInChinese =>
      'Kalimat lengkap dalam Hanzi sederhana...';

  @override
  String get lyingFlatACulturalMovement =>
      'Tang Ping (Lying Flat): Sebuah gerakan budaya...';

  @override
  String get theUserYouAreSpeakingToIsNamed =>
      'Pengguna yang sedang Anda ajak bicara bernama';

  @override
  String get importantRuleDoNotAddressTheUserByA =>
      'ATURAN PENTING: Jangan memanggil pengguna dengan nama apa pun. Jangan pernah menggunakan nama placeholder seperti';

  @override
  String get youAreAConciseChineseCalligraphyAnd =>
      'Anda adalah tutor Kaligrafi dan Etimologi Mandarin yang ringkas di aplikasi flashcard seluler.';

  @override
  String get theStudentIsStudyingTheCharacter =>
      'Siswa sedang mempelajari karakter';

  @override
  String get neverWriteIntroductionsSignoffsOrFi =>
      'Jangan pernah menulis kata pengantar, salam penutup, atau frasa basa-basi seperti';

  @override
  String get beDirectAndInformative => 'Bersikaplah lugas dan informatif.';

  @override
  String get criticalRuleYouMustRespondEntirelyI =>
      'ATURAN KRITIS: Anda harus merespons SEPENUHNYA dalam bahasa yang sesuai dengan kode ISO 639-1';

  @override
  String get youAreAConciseChineseGrammarTutorIn =>
      'Anda adalah tutor Tata Bahasa Mandarin yang ringkas di aplikasi seluler.';

  @override
  String get theStudentIsConfusedAboutTheWord => 'Siswa bingung mengenai kata';

  @override
  String get neverWriteIntroductionsSignoffsOrFi1 =>
      'Jangan pernah menulis kata pengantar, salam penutup, atau frasa basa-basi.';

  @override
  String get azureSpeechApiKeysAreMissing =>
      'Kunci Azure Speech API tidak ditemukan.';

  @override
  String get success => 'Berhasil';

  @override
  String get granularity => 'Tingkat Rincian (Granularitas)';

  @override
  String get phoneme1 => 'Fonem';

  @override
  String get dimension => 'Dimensi';

  @override
  String get comprehensive => 'Komprehensif';

  @override
  String get weCouldntHearYouClearlyPleaseTryAga =>
      'Kami tidak dapat mendengar Anda dengan jelas. Silakan coba lagi.';

  @override
  String get noNbestResultFound =>
      'Tidak ditemukan hasil pengenalan terbaik (NBest).';

  @override
  String get words1 => 'Kata-kata';

  @override
  String get word => 'Kata';

  @override
  String get phonemes => 'Fonem';

  @override
  String get syllables => 'Suku Kata';

  @override
  String get syllable => 'Suku Kata';

  @override
  String get omission => 'Penghilangan';

  @override
  String get insertion => 'Penyisipan';

  @override
  String get youMissedThisWord => 'Anda melewatkan kata ini.';

  @override
  String get extraWordAddedHere => 'Kata tambahan terselip di sini.';

  @override
  String get mispronunciation => 'Pengucapan keliru';

  @override
  String get pronunciationWasInaccurate => 'Pengucapan kurang akurat.';

  @override
  String get goodEffortKeepPracticing => 'Usaha yang bagus! Teruslah berlatih.';

  @override
  String get perfectPronunciationSoundsLikeANati =>
      'Pengucapan sempurna! Terdengar persis seperti penutur asli.';

  @override
  String get greatJobAFewMinorToneInaccuracies =>
      'Kerja bagus! Hanya ada sedikit ketidaktepatan nada.';

  @override
  String get notBadButYourTonesNeedSomeWork =>
      'Cukup baik, tetapi nada bicara Anda masih perlu dilatih.';

  @override
  String get keepPracticingListenToTheNativeAudi =>
      'Teruslah berlatih! Dengarkan audio penutur asli dan coba lagi.';

  @override
  String get lexical => 'Leksikal';

  @override
  String get chineseHanziHere => 'Hanzi Mandarin di sini';

  @override
  String get aShortSummaryInEnglish =>
      'Ringkasan singkat dalam bahasa Indonesia';

  @override
  String get noCoherentChineseTextFoundInTheScan =>
      'Tidak ada teks Mandarin yang jelas ditemukan dalam pemindaian.';

  @override
  String get theFullEnglishTranslationOfTheScann =>
      'Terjemahan lengkap bahasa Indonesia dari teks yang dipindai... ATAU \'Tidak ada teks Mandarin yang jelas ditemukan.\'';

  @override
  String get aShort24WordTitleForThisScanEgResta =>
      'Judul singkat 2-4 kata untuk pemindaian ini (mis. \'Menu Restoran\', \'Papan Nama Jalan\')';

  @override
  String get china => 'Tiongkok';

  @override
  String get noTranslationAvailable => 'Tidak ada terjemahan yang tersedia.';

  @override
  String get scanResults => 'Hasil Pemindaian';

  @override
  String get whenWasItWrittenAndWhatWasHappening =>
      'Kapan karya ini ditulis dan peristiwa apa yang terjadi di Tiongkok saat itu?';

  @override
  String get whyIsThisPieceFamousWhatPhilosophic =>
      'Mengapa karya ini terkenal? Tema filosofis atau budaya apa yang diulas di dalamnya?';

  @override
  String get aBriefBioOfTheAuthor => 'Biografi singkat tentang penulis.';

  @override
  String get informationUnavailable => 'Informasi tidak tersedia.';

  @override
  String get noSummaryAvailable => 'Tidak ada ringkasan yang tersedia.';

  @override
  String get hanziAiPro => 'SinoSpark AI Pro';

  @override
  String get trialNormalIntro => 'Uji Coba, Normal, Pengantar';

  @override
  String get dailyDrop => 'Sajian Harian';

  @override
  String get dailyNotificationsForWordOfTheDayAn =>
      'Notifikasi harian untuk Kata Hari Ini dan berita';

  @override
  String get aNewWordAndStoryOfTheDayAreWaitingF =>
      'Kata dan Kisah Hari Ini yang baru sudah menanti Anda!';

  @override
  String get spacedRepetition => 'Pengulangan Berjarak (Spaced Repetition)';

  @override
  String get remindersForFlashcardsDueForReview =>
      'Pengingat untuk flashcard yang siap diulang';

  @override
  String get engagementReminders => 'Pengingat Keaktifan Belajar';

  @override
  String get trialReminders => 'Pengingat Masa Uji Coba';

  @override
  String get notificationsForYourTrialStatus =>
      'Notifikasi mengenai status masa uji coba Anda';

  @override
  String get comeReviewYourHanziAndTryALiveCallB =>
      'Ayo tinjau Hanzi Anda dan coba Panggilan Langsung sebelum akses gratis berakhir!';

  @override
  String get scholarsEye => 'Mata Cendekiawan';

  @override
  String get clMeasureWord => 'Kata Penggolong (Classifier / CL):';

  @override
  String get surnameShi => 'Marga Shi';

  @override
  String get chineseFamilyNameShi => 'Nama keluarga Tiongkok (Shi)';

  @override
  String get neutralToneLight => 'Nada Netral (Ringan)';

  @override
  String get keepYourPitchHighAndSteadyLikeSingi =>
      'Pertahankan nada tetap tinggi dan stabil seperti menahan satu nada lagu.';

  @override
  String get startInTheMiddleAndSlideYourPitchUp =>
      'Mulai dari nada sedang lalu naikkan nada ke atas seperti bertanya \'Apa?\'';

  @override
  String get dipYourVoiceDownLowThenRiseGentlyBa =>
      'Turunkan nada suara Anda ke bawah, lalu naikkan kembali secara perlahan.';

  @override
  String get dropYourPitchSharplyAndDecisivelyLi =>
      'Turunkan nada suara Anda dengan tajam dan tegas seperti mengatakan \'Tidak!\' dengan mantap.';

  @override
  String get pronounceSoftlyBrieflyAndWithoutEmp =>
      'Lafalkan dengan lembut, singkat, dan tanpa penekanan.';

  @override
  String get spotOnPitchWasHighFlatAndSteady =>
      'Sempurna! Nada terdengar tinggi, datar, dan stabil.';

  @override
  String get spotOnUpwardPitchRiseWasClear =>
      'Sempurna! Kenaikan nada ke atas terdengar sangat jelas.';

  @override
  String get spotOnLowDippingCurveWasAccurate =>
      'Sempurna! Lengkungan nada turun-naik terdengar sangat akurat.';

  @override
  String get spotOnSharpFallingDropWasDecisive =>
      'Sempurna! Penurunan nada yang tajam dan tegas terdengar tepat.';

  @override
  String get spotOnToneWasPronouncedAccurately =>
      'Sempurna! Nada dilafalkan dengan sangat akurat.';

  @override
  String get iAgreeToTheTermsOfServiceAndPrivacy =>
      'Saya menyetujui Ketentuan Layanan dan Kebijakan Privasi.';

  @override
  String get sendMeOccasionalUpdatesTipsAndOffer =>
      'Kirimi saya pembaruan berkala, tips, dan penawaran khusus.';

  @override
  String get signInToSyncYourProgress =>
      'Masuk untuk menyinkronkan progres belajar Anda.';

  @override
  String get createAnAccountToSaveYourStats =>
      'Buat akun untuk menyimpan statistik belajar Anda.';

  @override
  String get smartSpiral => 'SPIRAL PINTAR';

  @override
  String get origin => 'Asal Usul';

  @override
  String get elements => 'Elemen Alami';

  @override
  String get humanity => 'Kemanusiaan & Sosial';

  @override
  String get village => 'Kehidupan Desa';

  @override
  String get journey => 'Perjalanan';

  @override
  String get city => 'Kota & Niaga';

  @override
  String get originTheSimplestShapesTheBeginning =>
      'Bentuk paling sederhana. Awal mula segala sesuatu.';

  @override
  String get elementsSunMoonWaterAndFireTheNatur =>
      'Matahari, Bulan, Air, dan Api. Dunia alami.';

  @override
  String get humanityTheBodyTheHeartAndTheFamily =>
      'Tubuh, hati nurani, dan keluarga.';

  @override
  String get villageFieldsRoofsAndToolsTheFounda =>
      'Ladang, atap rumah, dan perkakas. Fondasi masyarakat.';

  @override
  String get journeyMovementSpeechAndSustenance =>
      'Pergerakan, tutur kata, dan rezeki.';

  @override
  String get cityCommerceClothingAndComplexArtif =>
      'Perniagaan, busana, dan peradaban maju.';

  @override
  String get equilibriumAlgorithm => 'Algoritma Keseimbangan';

  @override
  String get misc => 'Lain-lain';

  @override
  String get cityOrOriginAs => '«Kota» atau «Asal Usul» sebagai';

  @override
  String get miscToOrigin => '«Lain-lain» ke «Asal Usul»';

  @override
  String get constellation => 'Konstelasi';

  @override
  String get whichOneIsWater => 'Manakah yang berarti \'Air\'?';

  @override
  String get whatIsThePinyin => 'Apa pinyin untuk karakter ini?';

  @override
  String get nature => 'Alam';

  @override
  String get whatEssenceDoes => 'Intisari apa yang dimiliki';

  @override
  String get allTiers => 'Semua Tingkatan';

  @override
  String get active => 'Aktif';

  @override
  String get theScrollOfOrigin1 => 'GULUNGAN ASAL USUL';

  @override
  String galaxyOf1(Object name) {
    return 'GALAKSI $name';
  }

  @override
  String get also => 'Juga';

  @override
  String get work => 'Kerja';

  @override
  String get cloud => 'Awan';

  @override
  String get youArchaic => 'Engkau (kuno)';

  @override
  String get suddenly => 'Tiba-tiba';

  @override
  String get owner => 'Pemilik';

  @override
  String get door => 'Pintu';

  @override
  String get occupy => 'Menduduki';

  @override
  String get nail => 'Paku';

  @override
  String get and => 'Dan';

  @override
  String get buddhistNun => 'Biksuni';

  @override
  String get anxious => 'Gelisah';

  @override
  String get sprout => 'Tunas';

  @override
  String get exchange => 'Bertukar';

  @override
  String get sheep => 'Domba';

  @override
  String get strange => 'Aneh';

  @override
  String get opposite => 'Berlawanan';

  @override
  String get shorttailedBird => 'Burung berekor pendek';

  @override
  String get shoot => 'Tunas / Rebung';

  @override
  String get small => 'Kecil';

  @override
  String get gather => 'Terkumpul';

  @override
  String get order => 'Urutan';

  @override
  String get flat => 'Datar';

  @override
  String get thePersonWho => 'Orang yang...';

  @override
  String get nobleman => 'Bangsawan / Orang Berbudi';

  @override
  String get cause => 'Penyebab';

  @override
  String get pig => 'Babi';

  @override
  String get bright => 'Terang';

  @override
  String get slowly => 'Perlahan';

  @override
  String get give => 'Memberi';

  @override
  String get arrow => 'Anak Panah';

  @override
  String get dry => 'Kering';

  @override
  String get obstacle => 'Rintangan';

  @override
  String get beg => 'Memohon';

  @override
  String get window => 'Jendela';

  @override
  String get fear => 'Takut';

  @override
  String get drum => 'Gendang';

  @override
  String get why => 'Mengapa';

  @override
  String get talent => 'Bakat';

  @override
  String get follow => 'Mengikuti';

  @override
  String get desert => 'Gurun';

  @override
  String get component => 'Komponen';

  @override
  String divingInto1(Object topic) {
    return 'Menyelami $topic';
  }

  @override
  String get unitIntro1 => 'Pengantar Unit';

  @override
  String get theBlueprint => 'CETAK BIRU';

  @override
  String get theOrigin => 'ASAL USUL';

  @override
  String get theGalaxy => 'GALAKSI';

  @override
  String get theScholarListens => 'Sang Cendekia mendengarkan...';

  @override
  String get consultingTheScrolls => 'Mengkaji naskah gulungan...';

  @override
  String get traceWithTheGuide => 'Tebalkan Sesuai Panduan';

  @override
  String get traceTheGhost => 'Tebalkan Bayangan Garis';

  @override
  String get connectTheDots => 'Hubungkan Titik-titik';

  @override
  String get drawFromMemory => 'Gambar dari Ingatan';

  @override
  String get assistant => 'Asisten';

  @override
  String get puck => 'Puck (laki-laki, sporty)';

  @override
  String get helloWelcomeWhatWouldYouLikeToOrder =>
      'Halo! Selamat datang. Apa yang ingin Anda pesan hari ini?';

  @override
  String get ni3Hao3Huan1ying2Guang1lin2Qing3wen =>
      'Nǐ hǎo! Huānyíng guānglín. Qǐngwèn nǐ yào diǎn shénme?';

  @override
  String get waiterLi => 'Pelayan Li';

  @override
  String get askForTheMenu => 'Minta buku menu';

  @override
  String get orderOneDishAndOneDrink => 'Pesan satu makanan dan satu minuman';

  @override
  String get askForTheBill => 'Minta tagihan pembayaran';

  @override
  String get fenrir => 'Fenrir (laki-laki, penuh semangat)';

  @override
  String get ni3Qu4Na3rAJi1chang3MaTing3Yuan3De =>
      'Nǐ qù nǎr a? Jīchǎng ma? Tǐng yuǎn de!';

  @override
  String get driverWang => 'Sopir Wang';

  @override
  String get tellTheDriverYouAreGoingToTheAirpor =>
      'Beri tahu sopir bahwa Anda hendak pergi ke bandara';

  @override
  String get askHowLongTheTripWillTake =>
      'Tanyakan berapa lama durasi perjalanannya';

  @override
  String get complainAboutTheTraffic =>
      'Bicarakan soal kondisi lalu lintas yang padat';

  @override
  String get charon => 'Charon (laki-laki, gaya pembaca berita)';

  @override
  String get thisClothingQualityIsEspeciallyGood =>
      'Kualitas pakaian ini sangat bagus, harganya hanya 200 kuai.';

  @override
  String get zhe4Jian4Yi1fuZhi4liang4Te4bie2Hao3 =>
      'Zhè jiàn yīfu zhìliàng tèbié hǎo, zhǐyào liǎng bǎi kuài.';

  @override
  String get auntieChen => 'Bibi Chen';

  @override
  String get askHowMuchTheSilkShirtCosts =>
      'Tanyakan berapa harga kemeja sutra tersebut';

  @override
  String get sayItIsTooExpensive => 'Katakan bahwa harganya terlalu mahal';

  @override
  String get bargainThePriceDownTo100Rmb => 'Tawar harganya hingga 100 RMB';

  @override
  String get ni3Na3li3Bu4Shu1fuFa1shao1LeMa =>
      'Nǐ nǎlǐ bù shūfu? Fāshāo le ma?';

  @override
  String get drZhang => 'Dr. Zhang';

  @override
  String get explainYouHaveHadAHeadacheForTwoDay =>
      'Jelaskan bahwa Anda sudah sakit kepala selama dua hari berturut-turut';

  @override
  String get sayYouHaveASlightFever => 'Katakan bahwa Anda merasa agak demam';

  @override
  String get askIfYouNeedToTakeMedicine =>
      'Tanyakan apakah Anda perlu minum obat tertentu';

  @override
  String get aoede => 'Aoede (perempuan, ceria)';

  @override
  String get heyLongTimeNoSeeHowHaveYouBeenLatel =>
      'Hai! Sudah lama tidak bertemu, bagaimana kabarmu belakangan ini?';

  @override
  String get ni3Hao3Hao3jiu3Bu4jian4Ni3Zui4jin4Z =>
      'Nǐ hǎo! Hǎojiǔ bùjiàn, nǐ zuìjìn zěnmeyàng?';

  @override
  String get pleaseIntroduceYourselfWhyDoYouWant =>
      'Silakan perkenalkan diri Anda. Mengapa Anda tertarik bekerja di perusahaan kami?';

  @override
  String get qing3Xian1Zi4wo3Jie4shao4Yi1xia4Ni3 =>
      'Qǐng xiān zìwǒ jièshào yíxià. Nǐ wèishénme xiǎng lái wǒmen gōngsī gōngzuò?';

  @override
  String get managerLiu => 'Manajer Liu';

  @override
  String get introduceYourProfessionalBackground =>
      'Jelaskan latar belakang profesional Anda secara singkat';

  @override
  String get explainWhyYouWantToWorkAtThisCompan =>
      'Jelaskan alasan kuat Anda ingin bergabung dengan perusahaan ini';

  @override
  String get askAPoliteQuestionAboutTheCompanyCu =>
      'Ajukan pertanyaan yang sopan mengenai budaya kerja perusahaan';

  @override
  String get microphoneAccessIsRequiredPleaseEna =>
      'Akses mikrofon diperlukan. Harap aktifkan di Pengaturan perangkat Anda.';

  @override
  String get couldNotStartMicrophonePleaseCheckY =>
      'Mikrofon tidak dapat dimulai. Periksa pengaturan audio Anda dan coba lagi.';

  @override
  String get weDidntQuiteCatchThatPleaseHoldTheM =>
      'Suara kurang terdengar jelas. Tahan tombol mikrofon dan coba lagi!';

  @override
  String get recordingWasTooShortHoldTheMicAndSp =>
      'Rekaman terlalu singkat. Tahan tombol mikrofon lebih lama dan bicaralah dengan jelas.';

  @override
  String get audioBufferWasEmptyPleaseCheckYourM =>
      'Buffer audio kosong. Periksa mikrofon Anda dan coba lagi.';

  @override
  String get audioFileIsSilentPleaseSpeakIntoThe =>
      'File audio tidak bersuara. Silakan bicara langsung ke mikrofon.';

  @override
  String get weCouldntUnderstandYourPronunciatio =>
      'Kami tidak dapat mengenali pengucapan Anda. Silakan berbicara dengan jelas dan coba lagi.';

  @override
  String get theServerIsTakingTooLongToRespondPl =>
      'Server membutuhkan waktu terlalu lama untuk merespons. Silakan coba lagi.';

  @override
  String get noInternetConnectionPleaseCheckYour =>
      'Tidak ada koneksi internet. Periksa jaringan Anda dan coba lagi.';

  @override
  String get audioProcessingFailedPleaseTryAgain =>
      'Pemrosesan audio gagal. Silakan coba lagi.';

  @override
  String get permission => 'Izin';

  @override
  String get couldNotProcessYourRecordingPleaseT =>
      'Tidak dapat memproses rekaman Anda. Silakan coba lagi.';

  @override
  String get user => 'Pengguna';

  @override
  String get scholar => 'Cendekiawan';

  @override
  String get ourAiTutorsAreCurrentlyOfflinePleas =>
      'Tutor AI kami sedang offline saat ini. Silakan coba lagi nanti.';

  @override
  String get hideTranslation => 'Sembunyikan Terjemahan';

  @override
  String get azureAssessment => 'Penilaian Azure sedang berlangsung...';

  @override
  String get microphonePermissionRequired => 'Izin mikrofon diperlukan';

  @override
  String get connectedSpeakNow => 'Terhubung! Anda dapat berbicara sekarang.';

  @override
  String get initializationErrorCheckPermissions =>
      'Terjadi kesalahan inisialisasi. Periksa izin perangkat Anda.';

  @override
  String get microphoneErrorTapToRetry =>
      'Terjadi masalah pada mikrofon. Ketuk untuk mencoba lagi.';

  @override
  String get theTutorReturnedAnEmptyResponse =>
      'Tutor memberikan respons kosong.';

  @override
  String get connectionInterruptedPleaseSpeakAga =>
      'Koneksi terputus. Silakan bicara kembali.';

  @override
  String get callPausedReviewingTones => 'Panggilan Dijeda (Meninjau Nada)';

  @override
  String get pausedTakeABreak => 'Dijeda - Istirahat sejenak';

  @override
  String get goodStartPracticing => 'Awal yang sangat baik untuk latihan';

  @override
  String get studentCoach => 'Murid / Pelatih';

  @override
  String get keepYour1stToneHighAndSteadyOn =>
      'Pertahankan nada pertama tetap tinggi dan stabil pada';

  @override
  String get noScenariosFound => 'Tidak ada skenario yang ditemukan.';

  @override
  String get designYourOwnAiRoleplayExperience =>
      'Rancang pengalaman roleplay AI Anda sendiri';

  @override
  String get generateFromDeck => 'Buat dari Dek';

  @override
  String get practiceFlashcardVocabularyInALiveD =>
      'Latih kosakata flashcard dalam dialog interaktif langsung';

  @override
  String get tapToRoleplay => 'Ketuk untuk memulai roleplay';

  @override
  String get hsk2 => 'HSK 2';

  @override
  String get hsk3 => 'HSK 3';

  @override
  String get hsk4 => 'HSK 4';

  @override
  String get hsk5 => 'HSK 5';

  @override
  String get hsk6 => 'HSK 6';

  @override
  String get dinnerWithDad => 'Makan Malam Bersama Ayah';

  @override
  String get orderingAtAChengduTeahouse => 'Memesan di Kedai Teh Chengdu';

  @override
  String get buyingTeaAtTheMarket => 'Membeli Teh di Pasar Tradisional';

  @override
  String get meetingAnOldClassmate => 'Bertemu Teman Sekelas Lama';

  @override
  String get readyToPractice => 'Siap untuk berlatih?';

  @override
  String get letsPracticeChinese => 'Mari berlatih bahasa Mandarin';

  @override
  String get areYouReady => 'Apakah Anda sudah siap?';

  @override
  String get discussWhatToHaveForDinner =>
      'Diskusikan menu pilihan untuk makan malam';

  @override
  String get suggestWatchingAMovieAfterwards =>
      'Sarankan menonton film setelah makan';

  @override
  String get askIfTheyWouldLikeTea =>
      'Tanyakan apakah mereka ingin menikmati teh';

  @override
  String get helloVeryNiceToMeetYou =>
      'Halo! Senang sekali bisa berkenalan dengan Anda.';

  @override
  String get deckPractice => 'Latihan dengan Dek';

  @override
  String get practiceVocabularyWithAnAiPartner =>
      'Latih kosakata bersama mitra AI.';

  @override
  String get designCustomAiRoleplayConversation =>
      'Rancang percakapan & roleplay kustom dengan AI';

  @override
  String get random => 'Acak';

  @override
  String get scenarioTopic => 'Topik Skenario';

  @override
  String get contextSettingOptional => 'Konteks & Latar (Opsional)';

  @override
  String get aiCharacterPersonaOptional => 'Karakter / Persona AI (Opsional)';

  @override
  String get aQuietBambooCourtyardTeahouseInChen =>
      'Sebuah kedai teh berhalaman bambu yang tenang di Chengdu dengan iringan musik guzheng yang syahdu.';

  @override
  String get aBustlingSmokyNightMarketFilledWith =>
      'Pasar malam yang ramai dan penuh aroma bakaran, dipenuhi sate, baozi kukus, dan jajanan jalanan.';

  @override
  String get aLivelyHotpotRestaurantInChongqingW =>
      'Restoran hotpot yang semarak di Chongqing dengan kuah merah membara dan aroma cabai yang menggugah selera.';

  @override
  String get aBustlingTraditionalCantoneseTeahou =>
      'Kedai teh Kanton tradisional yang ramai di Guangzhou, dipenuhi keranjang bambu dim sum yang mengepul.';

  @override
  String get aChicMinimalistCafeInTheFrenchConce =>
      'Kafe minimalis yang apik di French Concession pada sore hari Minggu yang rintik.';

  @override
  String get aWarmNorthernHomeKitchenDuringWinte =>
      'Dapur rumah yang hangat di utara saat musim dingin, lengkap dengan tepung di atas meja dan panci jiaozi yang mengepul.';

  @override
  String get anOpenairNightStreetFoodAlleyWithSi =>
      'Gang jajanan malam terbuka dengan sate domba mendesis, terong panggang, dan bir dingin.';

  @override
  String get aSnowyStreetCornerOutsideTheLamaTem =>
      'Sudut jalan bersalju di luar Kuil Lama dengan jajanan tanghulu merah mengilap di atas balok es.';

  @override
  String get craftBeerBreweryInQingdao => 'Pabrik Bir Kriya di Qingdao';

  @override
  String get aLivelyCoastalTaproomWithWoodenBarr =>
      'Taproom pesisir yang hidup dengan tong kayu, semilir angin laut, dan bir gandum segar dari keran.';

  @override
  String get sichuanCookingMasterclass => 'Kelas Memasak Kuliner Sichuan';

  @override
  String get aVibrantOpenKitchenWithWoksBlazingC =>
      'Dapur terbuka yang semarak dengan api wajan membara, minyak cabai mendidih, dan lada Sichuan segar.';

  @override
  String get highspeedRailSeatMixup => 'Kekeliruan Kursi di Kereta Cepat';

  @override
  String get greatWallSunriseTrekInMutianyu =>
      'Pendakian Menyambut Matahari Terbit di Tembok Besar Mutianyu';

  @override
  String get theAncientStoneRampartsOfTheGreatWa =>
      'Dinding benteng batu kuno Tembok Besar saat fajar menyingsing, dikelilingi perbukitan hijau berkabut.';

  @override
  String get bambooRaftDriftOnGuilinLiRiver =>
      'Menyusuri Sungai Li Guilin dengan Rakit Bambu';

  @override
  String get glidingAlongEmeraldKarstWatersBetwe =>
      'Meluncur di atas perairan zamrud di antara puncak tebing karst berkabut yang megah di dekat Yangshuo.';

  @override
  String get silkRoadCamelTrekInDunhuang =>
      'Trekking Unta di Jalur Sutra Dunhuang';

  @override
  String get theRollingGoldenSandDunesOfMingshaM =>
      'Hamparan bukit pasir keemasan di Gunung Mingsha berdampingan dengan oasis Danau Bulan Sabit.';

  @override
  String get bookingACourtyardHomestayInDali =>
      'Memesan Homestay Berhalaman Tradisional di Dali';

  @override
  String get aSereneBaistyleBoutiqueCourtyardHot =>
      'Hotel butik berhalaman gaya etnis Bai yang tenang dengan pemandangan Danau Erhai di Yunnan.';

  @override
  String get potalaPalacePilgrimageInLhasa =>
      'Ziarah ke Istana Potala di Lhasa';

  @override
  String get theMajesticSundrenchedStoneStepsOut =>
      'Undakan tangga batu megah bermandikan cahaya mentari di luar Istana Potala dengan roda doa yang berputar.';

  @override
  String get aSubzeroWonderlandOfIlluminatedCrys =>
      'Negeri dongeng musim dingin dengan istana kristal es berpendar lampu dan pahatan salju raksasa.';

  @override
  String get zhangjiajieAvatarMountainCableCar =>
      'Kereta Gantung Gunung Avatar di Zhangjiajie';

  @override
  String get suspendedHighInAGlassCableCarSoarin =>
      'Menggantung tinggi di dalam kereta gantung kaca, melayang di atas ribuan pilar batu pasir yang menjulang.';

  @override
  String get gobiDesertStargazingCampInGansu =>
      'Kemah Pengamatan Bintang di Gurun Gobi Gansu';

  @override
  String get aLuxuryYurtCampUnderACrystalclearMi =>
      'Kemah tenda yurt mewah di bawah bentangan Bima Sakti yang jernih di gurun luar Jiayuguan.';

  @override
  String get yangtzeRiverThreeGorgesCruise =>
      'Pelayaran Tiga Ngarai Sungai Yangtze';

  @override
  String get onTheSunDeckOfARiverCruiseShipPassi =>
      'Di dek berjemur kapal pesiar sungai yang melewati Ngarai Qutang yang megah dan dramatis.';

  @override
  String get buyingAntiquesInBeijingPanjiayuan =>
      'Membeli Barang Antik di Panjiayuan Beijing';

  @override
  String get aHistoricPotteryKilnFilledWithDelic =>
      'Tungku tembikar bersejarah yang dipenuhi vas porselen mentah yang halus dan glasir biru kobalt.';

  @override
  String get suzhouSilkEmbroideryStudio => 'Studio Bordir Sutra Suzhou';

  @override
  String get aPeacefulCanalsideGardenStudioInSuz =>
      'Studio taman tepi kanal yang damai di Suzhou dengan benang sutra halus dan bingkai bordir kayu.';

  @override
  String get backstageAtATraditionalBeijingOpera =>
      'Di balik panggung teater opera Beijing tradisional dengan kostum warna-warni, cermin, dan hiasan kepala.';

  @override
  String get traditionalChineseMedicineConsultat =>
      'Konsultasi Pengobatan Tradisional Tiongkok (TCM)';

  @override
  String get morningTaiChiInTempleOfHeavenPark =>
      'Tai Chi Pagi di Taman Kuil Surga (Temple of Heaven)';

  @override
  String get beneathAncientCypressTreesAtDawnWit =>
      'Di bawah pohon cemara kuno saat fajar bersama kicauan burung dan warga lansia yang berlatih gerakan selaras.';

  @override
  String get rentingAHanfuForAPhotoShoot => 'Menyewa Hanfu untuk Sesi Foto';

  @override
  String get aTraditionalCostumeBoutiqueNearTheW =>
      'Butik busana tradisional dekat Danau Barat dengan deretan jubah dinasti Tang dan Song.';

  @override
  String get guqinAncientZitherInstrumentWorksho =>
      'Lokakarya Alat Musik Guqin (Zither Tradisional Tiongkok)';

  @override
  String get aQuietPinewoodStudioInHangzhouFille =>
      'Studio kayu pinus yang tenang di Hangzhou, dipenuhi alat musik kayu paulownia tua berdawai sutra.';

  @override
  String get shaanxiShadowPuppetTheater =>
      'Teater Wayang Kulit Bayangan Shaanxi';

  @override
  String get behindAnIlluminatedWhiteSilkScreenW =>
      'Di balik layar sutra putih yang berpendar dengan wayang kulit berukir halus.';

  @override
  String get chineseCalligraphyWorkshop => 'Lokakarya Kaligrafi Mandarin';

  @override
  String get aTranquilStudioScentedWithPineSootI =>
      'Studio tenang beraroma tinta jelaga pinus, gulungan kertas beras, dan keharuman teh lembut.';

  @override
  String get adoptingACatAtAnAnimalShelter =>
      'Mengadopsi Kucing di Penampungan Hewan';

  @override
  String get aCozyPetRescueCenterInHangzhouWithE =>
      'Pusat penyelamatan hewan yang nyaman di Hangzhou dengan anak kucing lincah dan sajian teh untuk pengunjung.';

  @override
  String get scriptMurderMysteryJubenshaGame =>
      'Permainan Roleplay Misteri Pembunuhan (Jubensha)';

  @override
  String get aThemedDetectiveLoungeInShanghaiWit =>
      'Lounge detektif bertema di Shanghai dengan pemain berkostum dalam temaram cahaya lilin.';

  @override
  String get vintageVinylRecordShopInShanghai =>
      'Toko Piringan Hitam Vintage di Shanghai';

  @override
  String get aHiddenVinylStoreInAnOldLaneHousePa =>
      'Toko piringan hitam tersembunyi di bangunan gang tua, penuh dengan piringan hitam Cantopop dan jazz klasik 80-an.';

  @override
  String get ktvKaraokePartyWithFriends => 'Pesta Karaoke KTV Bersama Teman';

  @override
  String get joiningACityBikeCyclingClub => 'Bergabung dengan Klub Sepeda Kota';

  @override
  String get aGatheringOfCyclistsByTheRiverfront =>
      'Kumpulan pesepeda di tepi sungai bersiap untuk gowes malam mengelilingi panorama kota.';

  @override
  String get blindBoxToyTradingMeetup => 'Pertemuan Tukar Mainan Blind Box';

  @override
  String get aColorfulPopcultureToyStoreInChaoya =>
      'Toko mainan kultur pop penuh warna di Chaoyang dengan rak pajangan dan kotak koleksi yang belum dibuka.';

  @override
  String get droneSkylineVideographyAtTheBund =>
      'Videografi Udara Lanskap Kota dengan Drone di The Bund';

  @override
  String get theBundPromenadeAtDuskOverlookingTh =>
      'Promenade The Bund saat senja dengan panorama gedung pencakar langit Pudong yang futuristik.';

  @override
  String get goldenRetrieverCafeInNanjing => 'Kafe Golden Retriever di Nanjing';

  @override
  String get aSunnyCheerfulPetCafeWithDozensOfFr =>
      'Kafe hewan peliharaan yang cerah dan ceria dengan puluhan anjing ramah yang menyambut pengunjung.';

  @override
  String get boulderingClimbingGymInChengdu =>
      'Gym Panjat Tebing Bouldering di Chengdu';

  @override
  String get aModernIndoorClimbingGymWithVibrant =>
      'Gym panjat tebing dalam ruangan modern dengan rute pegangan berwarna cerah dan musik berenergi.';

  @override
  String get aMassiveConventionHallFilledWithCol =>
      'Gedung konvensi megah penuh stan permainan warna-warni, latar foto, dan kreator berkostum.';

  @override
  String get askingForDirectionsInABeijingHutong =>
      'Bertanya Arah Jalan di Hutong Beijing';

  @override
  String get aMazeOfHistoricGreybrickAlleysWithB =>
      'Labirin gang bata abu-abu bersejarah dengan sepeda, halaman rumah, dan pohon delima.';

  @override
  String get buyingFreshFruitAtAWetMarket =>
      'Membeli Buah Segar di Pasar Tradisional';

  @override
  String get aLivelyMorningNeighborhoodMarketWit =>
      'Pasar pagi lingkungan yang ramai dengan tumpukan buah leci, mangga, dan buah naga segar.';

  @override
  String get flowerMarketBouquetInKunming =>
      'Buket Bunga dari Pasar Bunga Kunming';

  @override
  String get theFamousDounanFlowerMarketSurround =>
      'Pasar Bunga Dounan yang tersohor, dikelilingi ribuan mawar, lili, dan tangkai eukaliptus segar.';

  @override
  String get tailorAlterationsInAnOldLaneHouse =>
      'Vermak Jahit di Rumah Gang Tradisional';

  @override
  String get aTraditionalTailorShopFilledWithSew =>
      'Toko penjahit tradisional yang dipenuhi mesin jahit, kain, dan meteran pita.';

  @override
  String get expressParcelLockerRetrieval => 'Mengambil Paket di Loker Pintar';

  @override
  String get downstairsAtAResidentialApartmentGa =>
      'Di lantai bawah gerbang apartemen di samping sistem loker pintar Hive box.';

  @override
  String get bicycleFlatTireRepairAtCampusGate =>
      'Tambal Ban Sepeda di Gerbang Kampus';

  @override
  String get aSmallOutdoorRoadsideToolkitStandUn =>
      'Kios perkakas pinggir jalan di bawah naungan pohon beringin rimbun.';

  @override
  String get techCompanyProductDemo => 'Demo Produk Perusahaan Teknologi';

  @override
  String get aFuturisticTechConferenceBoothInShe =>
      'Stan konferensi teknologi futuristik di Shenzhen yang memamerkan perangkat keras AI mutakhir.';

  @override
  String get ecommerceLivestreamStudio => 'Studio Live Streaming E-Commerce';

  @override
  String get aHighenergyBroadcastStudioWithRingL =>
      'Studio siaran penuh energi dengan ring light, rak pajangan produk, dan monitor komentar langsung.';

  @override
  String get yiwuInternationalTradeMarket =>
      'Pasar Perdagangan Internasional Yiwu';

  @override
  String get aVastMultistoryCommercialExhibition =>
      'Pusat pameran komersial bertingkat luas yang dipadati jutaan barang grosir dan kerajinan tangan.';

  @override
  String get universityCampusExchangeProgram =>
      'Program Pertukaran Pelajar Kampus Universitas';

  @override
  String get aSunnyLawnOutsideTheUniversityLibra =>
      'Halaman rumput bermandikan mentari di luar perpustakaan kampus dengan mahasiswa yang belajar sambil minum boba.';

  @override
  String get pleaseEnterAScenarioTopic => 'Silakan masukkan topik skenario.';

  @override
  String get nameTitle => 'Nama (Judul)';

  @override
  String get aiCharacter => 'Karakter AI';

  @override
  String get helloWelcomeHereWhatShallWeChatAbou =>
      'Halo! Selamat datang, topik apa yang ingin kita perbincangkan hari ini?';

  @override
  String get greetYourConversationPartner => 'Sapa rekan bicara Anda';

  @override
  String get askAQuestionInChinese => 'Ajukan pertanyaan dalam bahasa Mandarin';

  @override
  String get pinyinWithToneMarks => 'Pinyin dengan tanda nada';

  @override
  String get goal1InEnglish => 'Tujuan 1 (Bahasa Indonesia)';

  @override
  String get goal2InEnglish => 'Tujuan 2 (Bahasa Indonesia)';

  @override
  String get goal3InEnglish => 'Tujuan 3 (Bahasa Indonesia)';

  @override
  String get beginner => 'Pemula';

  @override
  String get hsk12 => 'HSK 1-2';

  @override
  String get hsk34 => 'HSK 3-4';

  @override
  String get hsk56 => 'HSK 5-6';

  @override
  String get master => 'Mahir';

  @override
  String get azurePronunciationAssessment => 'PENILAIAN PENGUCAPAN AZURE';

  @override
  String get tapToReview => 'Ketuk untuk meninjau';

  @override
  String get overallScore => 'Skor Keseluruhan';

  @override
  String get toneAccuracy => 'Akurasi Nada';

  @override
  String get fluency => 'Kelancaran';

  @override
  String get report => 'Laporan';

  @override
  String get goodPronunciationButCanBeBetter =>
      'Pengucapan bagus, tetapi masih bisa ditingkatkan!';

  @override
  String get didYouMeanToSay => 'Apakah maksud Anda...?';

  @override
  String get greatKeepTrying => 'Hebat! Teruslah berlatih!';

  @override
  String get completeness => 'Kelengkapan';

  @override
  String get targetTone => 'Nada Target';

  @override
  String get k4toneComparisonTapToListen =>
      'Perbandingan 4 Nada (Ketuk untuk Mendengarkan):';

  @override
  String get youSpokeMatch => 'Anda Mengucapkan (Cocok!)';

  @override
  String get youSpoke => 'Anda Mengucapkan';

  @override
  String get yourPrimaryCollectionOfCharacters =>
      'Koleksi karakter utama Anda.';

  @override
  String get deckNotFound => 'Dek tidak ditemukan';

  @override
  String get cannotDeleteTheDefaultDeck => 'Tidak dapat menghapus dek bawaan';

  @override
  String get hsk4UpperIntermediate1 => 'HSK 4: Menengah Atas';

  @override
  String get theFirst150CharactersToStartYourJou =>
      '150 karakter pertama untuk memulai perjalanan belajar Anda.';

  @override
  String get buildYourVocabularyTo300EssentialWo =>
      'Perkaya kosakata Anda hingga 300 kata esensial.';

  @override
  String get masterConversationalFluencyWith600W =>
      'Kuasai kelancaran percakapan dengan 600 kata.';

  @override
  String get readTextsAndConverseFluentlyWith120 =>
      'Membaca teks dan bercakap-cakap dengan lancar menggunakan 1200 kata.';

  @override
  String get readNewspapersAndWatchMoviesWith250 =>
      'Membaca surat kabar dan menonton film dengan 2500 kata.';

  @override
  String get databaseBoxNotOpen => 'Basis data tidak terbuka';

  @override
  String get hsk1DataFileIsEmpty => 'Berkas data HSK 1 kosong';

  @override
  String get gold => 'Emas';

  @override
  String get globalDictionaryNotInitialized =>
      'Kamus Global belum diinisialisasi';

  @override
  String get reading => 'Membaca';

  @override
  String get recall => 'Mengingat';

  @override
  String get speaking => 'Berbicara';

  @override
  String get listening1 => 'Mendengarkan';

  @override
  String get practiceStrokeOrderWithVisualGuides =>
      'Latih urutan goresan dengan panduan visual.';

  @override
  String get seeTheCharacterRecallThePinyinAndMe =>
      'Lihat karakter, lalu ingat Pinyin dan maknanya.';

  @override
  String get seeTheMeaningDrawTheCharacterFromMe =>
      'Lihat arti, lalu tulis karakter dari ingatan.';

  @override
  String get readOutLoudToTestYourPronunciationT =>
      'Baca dengan lantang untuk menguji ketepatan nada pengucapan Anda.';

  @override
  String get listenToTheAudioAndIdentifyTheChara =>
      'Dengarkan audio dan tentukan karakter yang tepat.';

  @override
  String get contract => 'Kontrak';

  @override
  String get whoeverImplementsMeMustBeAbleToDoTh =>
      'Siapa pun yang mengimplementasikan antarmuka ini HARUS dapat melakukan hal-hal berikut.';

  @override
  String get koreFenrirCharonAoedePuckOrLocal =>
      'Kore, Fenrir, Charon, Aoede, Puck, atau lokal';

  @override
  String get manageDecks => 'Kelola Dek';

  @override
  String get weRanIntoTroubleLoadingTheLibraryPl =>
      'Terjadi kendala saat memuat perpustakaan. Silakan coba lagi.';

  @override
  String get noCharactersInLexicon1 => 'Tidak ada karakter dalam leksikon';

  @override
  String get masterTheBuildingBlocks => 'Kuasai blok pembangun dasar';

  @override
  String get other => 'Lainnya';

  @override
  String get requiredLabel => 'Wajib';

  @override
  String get library1 => 'Perpustakaan';

  @override
  String get youAreAPremiumMember => 'Anda adalah anggota Premium';

  @override
  String get createAccountToSyncProgress =>
      'Buat Akun untuk Menyinkronkan Progres';

  @override
  String get signOut => 'Keluar';

  @override
  String get account => 'Akun';

  @override
  String get guestScholar => 'Cendekiawan Tamu';

  @override
  String get localAccount => 'Akun Lokal';

  @override
  String get unknownRadical => 'Radikal Tidak Dikenal';

  @override
  String get followTheGuideStroke => 'Ikuti goresan panduan';

  @override
  String get strokeAnimationSpeed => 'Kecepatan Animasi Goresan';

  @override
  String get notifications => 'Notifikasi';

  @override
  String get deutsch => 'Jerman';

  @override
  String get bahasaIndonesia => 'Bahasa Indonesia';

  @override
  String get italiano => 'Italia';

  @override
  String get today1d2d3d4d5d6d =>
      'Hari Ini, 1 hari, 2 hari, 3 hari, 4 hari, 5 hari, 6 hari';

  @override
  String get targetDeck => 'Dek Sasaran';

  @override
  String get mixed => 'Campuran';

  @override
  String get topicForContext => 'Topik (sebagai konteks)';

  @override
  String get nounsOnly => 'Hanya kata benda';

  @override
  String get verbsOnly => 'Hanya kata kerja';

  @override
  String get idiomsChengyu => 'Idiom (Chengyu)';

  @override
  String get fullSentences => 'Kalimat Lengkap';

  @override
  String get beginnerHsk12 => 'Pemula (HSK 1-2)';

  @override
  String get intermediateHsk34 => 'Menengah (HSK 3-4)';

  @override
  String get advancedHsk56 => 'Mahir (HSK 5-6)';

  @override
  String get generatedByAi => 'Dibuat oleh AI';

  @override
  String get canYouGiveMeTwoMoreExamplesUsingThi =>
      'Bisakah Anda memberikan dua contoh lagi yang menggunakan kata ini?';

  @override
  String get whatAreSomeSimilarWordsAndHowDoThey =>
      'Apa saja kata yang serupa dan bagaimana perbedaannya?';

  @override
  String get isThisWordUsedInSpokenOrWrittenChin =>
      'Apakah kata ini lebih sering digunakan dalam bahasa Mandarin lisan atau tulisan?';

  @override
  String get areThereOtherWaysToTranslateThisWor =>
      'Apakah ada padanan kata lain untuk menerjemahkan kata ini?';

  @override
  String get whatAreCommonWordsThatGoTogetherWit =>
      'Kata-kata umum apa yang sering dipadukan dengan kata ini?';

  @override
  String get whatAreCommonMistakesLearnersMakeWi =>
      'Kesalahan umum apa yang sering dilakukan pembelajar saat menggunakan kata ini?';

  @override
  String get emptyResponse => 'Respons kosong';

  @override
  String get whatIsTheOracleBoneScriptOriginOfTh =>
      'Bagaimana asal-usul karakter ini dalam naskah aksara tulang orakel?';

  @override
  String get howDidTheAncientFormOfThisCharacter =>
      'Bagaimana bentuk kuno karakter ini berevolusi dari masa ke masa?';

  @override
  String get giveMe3CommonWordsThatContainThisCh =>
      'Berikan 3 kata umum yang mengandung karakter ini.';

  @override
  String get whatOtherCharactersShareTheSameRadi =>
      'Karakter apa lagi yang menggunakan radikal yang sama?';

  @override
  String get isThereAChineseProverbOrSayingFeatu =>
      'Apakah ada peribahasa atau pepatah Tiongkok yang memuat karakter ini?';

  @override
  String get explainTheStrokeOrderRulesForThisCh =>
      'Jelaskan aturan urutan goresan untuk karakter ini.';

  @override
  String get giveMeOneCalligraphyTipForWritingTh =>
      'Berikan satu kiat kaligrafi agar dapat menuliskan karakter ini dengan indah.';

  @override
  String get isThereAnythingTrickyAboutUsingThis =>
      'Apakah ada keunikan atau kerumitan tata bahasa dalam penggunaan karakter ini?';

  @override
  String get whatWordsAreCommonlyConfusedWithThi =>
      'Kata apa saja yang sering tertukar dengan kata ini dan mengapa?';

  @override
  String get doesThisCharacterCarryCulturalSymbo =>
      'Apakah karakter ini memiliki simbolisme budaya tertentu di Tiongkok?';

  @override
  String get isThisCharacterCommonlySeenInChines =>
      'Apakah karakter ini sering dijumpai dalam film, lagu, atau teks Mandarin kontemporer?';

  @override
  String get whatDoesTheRadicalOfThisCharacterMe =>
      'Apa makna yang dikandung oleh radikal karakter ini?';

  @override
  String get breakDownEveryComponentAndItsMeanin =>
      'Uraikan setiap komponen beserta artinya.';

  @override
  String get giveMeATrickToRememberTheCorrectTon =>
      'Berikan jembatan keledai untuk mengingat nada yang tepat bagi karakter ini.';

  @override
  String get areThereCommonHomophonesThatAreOfte =>
      'Apakah ada kata homofon yang kerap membingungkan?';

  @override
  String get quotaExceeded => 'Batas kuota terlampaui';

  @override
  String get mustProvideEitherCardOrCards =>
      'Harus menyertakan parameter kartu tunggal atau daftar kartu';

  @override
  String get deckSettings => 'Pengaturan Dek';

  @override
  String get saveSettings => 'Simpan Pengaturan';

  @override
  String get sealRed => 'Cap Merah';

  @override
  String get sealScript => 'Aksara Segel (Zhuan)';

  @override
  String get startYourStreak => 'MULAI RENTETAN BELAJAR ANDA';

  @override
  String get traditionalCharacter => 'Karakter Tradisional';

  @override
  String get inQueue => 'Dalam Antrean';

  @override
  String get tapToListenAgain => 'Ketuk untuk mendengarkan kembali';

  @override
  String get contextClue => 'Petunjuk Konteks';

  @override
  String get microphonePermissionRequired1 => 'Izin mikrofon diperlukan.';

  @override
  String get recordingFailedNoFile =>
      'Perekaman gagal (berkas tidak terbentuk).';

  @override
  String get holdToSpeakOptional => 'Tahan untuk berbicara (Opsional)';

  @override
  String get microphonePermissionDeniedEnableItI =>
      'Izin mikrofon ditolak. Aktifkan di Pengaturan untuk menggunakan Studio Shadowing.';

  @override
  String get sessionSummary => 'Ringkasan Sesi';

  @override
  String get hereAreTheCharactersYouStruggledWit =>
      'Berikut adalah karakter yang dirasa sulit selama sesi ini:';

  @override
  String get applySessionGradesToSpacedRepetitio =>
      'Terapkan nilai sesi ke Pengulangan Berjarak (Mode Berbicara)';

  @override
  String get masterYourMandarinPronunciationnbyM =>
      'Kuasai pengucapan Mandarin Anda\ndengan meniru penutur asli.';

  @override
  String get aiIsGradingYourPronunciation =>
      'AI sedang mengevaluasi pengucapan Anda...';

  @override
  String get holdMicToRecordReleaseToGrade =>
      'Tahan mikrofon untuk merekam. Lepas untuk menilai.';

  @override
  String get tapAnySyllableToAuditionAll4Tones =>
      'Ketuk suku kata mana pun untuk mendengarkan keempat nada:';

  @override
  String get freeFlowConversationalPractice => 'Latihan percakapan alur bebas.';

  @override
  String get failedToGeneratePhrasePleaseTryAgai =>
      'Gagal membuat frasa. Silakan coba lagi.';

  @override
  String get recordingTooShortHoldTheMicButtonLo =>
      'Durasi rekaman terlalu singkat. Tahan tombol mikrofon lebih lama.';

  @override
  String get recordingErrorPleaseTryAgain =>
      'Terjadi kesalahan perekaman. Silakan coba lagi.';

  @override
  String get noRecordingCapturedPleaseTryAgain =>
      'Tidak ada rekaman yang tertangkap. Silakan coba lagi.';

  @override
  String get recordedAudioIsEmptyPleaseTryAgainA =>
      'Audio yang direkam kosong. Silakan coba lagi dan bicaralah dengan jelas.';

  @override
  String get azureSpeechApiKeysAreMissing1 =>
      'Kunci Azure Speech API tidak ditemukan';

  @override
  String get azureError401 => 'Kesalahan Azure 401';

  @override
  String get azureAuthenticationFailedCheckYourS =>
      'Autentikasi Azure gagal. Periksa kunci Speech API dan wilayah di berkas .env Anda.';

  @override
  String get azureError429 => 'Kesalahan Azure 429';

  @override
  String get azureQuotaExceededTryAgainLater =>
      'Kuota Azure terlampaui. Silakan coba lagi nanti.';

  @override
  String get azureGradingTimedOutCheckYourIntern =>
      'Waktu penilaian Azure habis. Periksa koneksi internet Anda.';

  @override
  String get recognitionFailedNull => 'Pengenalan gagal: nilai kosong';

  @override
  String get couldNotHearYouClearlyPleaseTryAgai =>
      'Suara Anda tidak terdengar jelas. Silakan coba lagi.';

  @override
  String get singlePhrasePractice => 'Latihan Frasa Tunggal';

  @override
  String get failedToGeneratePhrase => 'Gagal membuat frasa';

  @override
  String get omitted => 'Dilewati';

  @override
  String get partial => 'Sebagian';

  @override
  String get mispronounced => 'Kurang tepat';

  @override
  String get startSession1 => 'Mulai Sesi';

  @override
  String get chinese => 'Mandarin';

  @override
  String get paused => 'Dijeda';

  @override
  String get translationFailed => 'Terjemahan gagal';

  @override
  String get engagingMacroeconomicAndBusinessBre =>
      'Analisis makroekonomi dan bisnis menarik yang disampaikan lewat penceritaan memikat.';

  @override
  String get exploresWorldEconomiesBankingHistor =>
      'Menjelajahi ekonomi dunia, sejarah perbankan, dan dinamika industri global.';

  @override
  String get clearArticulateMandarinPerfectForIn =>
      'Bahasa Mandarin yang jelas dan lugas, sangat ideal bagi pembelajar tingkat menengah dan mahir.';

  @override
  String get chefWang => 'Chef Wang';

  @override
  String get masterSichuanCulinaryTechniquesTaug =>
      'Kuasai teknik kuliner otentik Sichuan yang diajarkan langsung oleh kepala koki profesional.';

  @override
  String get stepbystepAuthenticChineseRecipesWi =>
      'Resep masakan Tiongkok otentik langkah demi langkah dengan penguasaan wajan dan teknik pisau.';

  @override
  String get conciseCulinaryVocabularyAndClearIn =>
      'Kosakata kuliner ringkas dengan instruksi yang jelas dalam bahasa Mandarin alami.';

  @override
  String get cinematographyCuttingedgeCameraTech =>
      'Sinematografi, teknologi kamera mutakhir, dan ulasan media digital yang mendalam.';

  @override
  String get highproductionDocumentaryStyleExplo =>
      'Gaya dokumenter berkelas tinggi yang mengeksplorasi kreasi video dan inovasi AI.';

  @override
  String get richTechnicalMandarinWithCrystalcle =>
      'Kosakata teknis Mandarin yang kaya dengan pelafalan jernih dan takarir visual.';

  @override
  String get indepthInvestigativeJournalismAndCu =>
      'Jurnalisme investigasi mendalam dan ulasan isu terkini.';

  @override
  String get criticalPerspectivesOnSocialPhenome =>
      'Perspektif kritis atas fenomena sosial, kabar dunia, dan sejarah.';

  @override
  String get formalInvestigativeDiscourseIdealFo =>
      'Wacana investigatif formal, sangat cocok untuk mengasah pemahaman menyimak tingkat lanjut.';

  @override
  String get bitesizedAnimatedScienceDocumentari =>
      'Dokumenter sains animasi ringkas yang menjawab rasa ingin tahu sehari-hari.';

  @override
  String get exploresPhysicsBiologyAndEverydayCu =>
      'Mengeksplorasi fisika, biologi, dan fenomena harian lewat infografis interaktif.';

  @override
  String get standardBeijingMandarinWithWellpace =>
      'Bahasa Mandarin Beijing standar dengan ritme narasi pas dan takarir yang jelas.';

  @override
  String get heartwarmingStreetFoodAdventuresAnd =>
      'Petualangan kuliner kaki lima yang hangat dan perbincangan tulus di seantero Tiongkok.';

  @override
  String get exploresRegionalHumanStoriesFamilyT =>
      'Mengeksplorasi kisah humanis daerah, tradisi keluarga, dan kekayaan kuliner lokal.';

  @override
  String get naturalConversationalMandarinWithDa =>
      'Percakapan Mandarin alami dengan ungkapan sehari-hari dan kehangatan emosional.';

  @override
  String get humorousAndHonestConsumerElectronic =>
      'Ulasan barang elektronik konsumen yang kocak dan jujur berdasarkan pengalaman nyata.';

  @override
  String get testingSmartphonesSmartHomeGadgetsA =>
      'Menguji ponsel pintar, perangkat rumah pintar, dan pernak-pernik teknologi gaya hidup.';

  @override
  String get relaxedHumorousConversationalDialog =>
      'Dialog percakapan santai dan menghibur dengan bahasa gaul modern.';

  @override
  String get seanKitchen => 'Dapur Sean';

  @override
  String get deliciousHomecookedChineseDishesAnd =>
      'Hidangan rumahan Tiongkok yang lezat dan kreasi ulang jajanan kaki lima.';

  @override
  String get easytofollowKitchenTipsForCookingAu =>
      'Tips dapur praktis untuk memasak hidangan khas Asia yang menggugah selera.';

  @override
  String get warmInvitingCommentaryWithPractical =>
      'Ulasan hangat dan bersahabat dengan kosakata dapur praktis.';

  @override
  String get chineseChannel => 'Saluran Mandarin';

  @override
  String get structuredChineseLanguageLessonsAnd =>
      'Pelajaran bahasa Mandarin terstruktur dan panduan eksplorasi budaya.';

  @override
  String get grammarPointsHskVocabularyBuildingA =>
      'Poin tata bahasa, pembentukan kosakata HSK, dan pola percakapan.';

  @override
  String get clearEducationalPacingTailoredSpeci =>
      'Laju pembelajaran teratur yang dirancang khusus bagi pembelajar bahasa Mandarin.';

  @override
  String get oneInABillion => 'Satu dari Semiliar';

  @override
  String get intimatePortraitsAndStoriesOfUnique =>
      'Potret dekat dan kisah hidup sosok-sosok istimewa di Tiongkok kontemporer.';

  @override
  String get exploresDiverseLifeChoicesYouthCult =>
      'Mengeksplorasi pilihan hidup yang beragam, kultur anak muda, dan pergeseran sosial modern.';

  @override
  String get deepNarrativeStorytellingWithRichVo =>
      'Penceritaan narasi mendalam dengan kekayaan kosakata dan penuturan yang otentik.';

  @override
  String get vickySoup => 'Sup Vicky';

  @override
  String get aestheticLifestyleVlogsFashionStyli =>
      'Vlog gaya hidup estetis, penataan busana, dan rutinitas harian.';

  @override
  String get travelDiariesAndCozyLifeMomentsDocu =>
      'Catatan perjalanan dan momen kehangatan hidup yang dikemas secara sinematik.';

  @override
  String get naturalCasualMandarinSpokenAtAComfo =>
      'Percakapan Mandarin kasual yang diucapkan dengan tempo nyaman dan ekspresif.';

  @override
  String get tededMandarin => 'TED-Ed Mandarin';

  @override
  String get highqualityAnimatedEducationalLesso =>
      'Pelajaran edukasi animasi berkualitas tinggi seputar sains, filsafat, dan sejarah.';

  @override
  String get thoughtprovokingRiddlesClassicLiter =>
      'Teka-teki yang menggugah pikiran, sastra klasik, dan misteri psikologi.';

  @override
  String get impeccableVoiceoverMandarinWithSync =>
      'Sulih suara Mandarin sempurna dengan takarir dwibahasa yang tersinkronisasi rapi.';

  @override
  String get channel => 'Saluran';

  @override
  String get curatedCulturalDocumentariesAndChin =>
      'Dokumenter budaya pilihan dan sorotan gaya hidup Tiongkok.';

  @override
  String get exploringTraditionalArtsHeritageCra =>
      'Menjelajahi seni tradisional, kriya warisan leluhur, dan tren modern.';

  @override
  String get highQualityAudioWithSynchronizedChi =>
      'Audio berkualitas jernih dengan takarir Mandarin yang tersinkronisasi rapi.';

  @override
  String get interestingStoriesAndCreativeVideoP =>
      'Kisah memikat dan karya video kreatif dari jagat maya Tiongkok.';

  @override
  String get engagingInterviewsStorytellingAndVi =>
      'Wawancara memikat, penceritaan kisah, dan eksplorasi visual.';

  @override
  String get greatListeningMaterialWithStandardP =>
      'Materi menyimak bermutu tinggi dengan pengucapan baku.';

  @override
  String get xVsY => 'X vs Y';

  @override
  String get untitled => 'Tanpa Judul';

  @override
  String get contemporaryStories => 'Kisah Kontemporer';

  @override
  String get history => 'Sejarah';

  @override
  String get advancedReading => 'Bacaan Tingkat Mahir';

  @override
  String get intermediateReading => 'Bacaan Tingkat Menengah';

  @override
  String get beginnerReading => 'Bacaan Tingkat Pemula';

  @override
  String get mandarinBean => 'Mandarin Bean';

  @override
  String get unknown => 'Tidak Diketahui';

  @override
  String get localDb => 'Basis Data Lokal';

  @override
  String get emperorTaizong => 'Kaisar Taizong';

  @override
  String get emperorXuanzong => 'Kaisar Xuanzong';

  @override
  String get liBai => 'Li Bai';

  @override
  String get gradedReader => 'Bacaan Berjenjang';

  @override
  String get ucj10r97lkwgdtqbt6xzv8gLearnMandari =>
      'Belajar Mandarin bersama TaiwanPlus';

  @override
  String get ucsxriuqkzzmaqklq0n9xfvwEverydayChi => 'Mandarin Sehari-hari';

  @override
  String get graceMandarinChinese => 'Grace Mandarin Chinese';

  @override
  String get ucolbhvvl5dcjlmzeqbuu1vwTingdailyLi =>
      'Ting: Kehidupan Sehari-hari di Tiongkok';

  @override
  String get xinxin => 'Xinxin';

  @override
  String get sweetFamilyDailyLife => 'Kehidupan Keluarga yang Manis';

  @override
  String get chinsunDailyLife => 'Keseharian Chin-Sun';

  @override
  String get tasteChina => 'Cita Rasa Tiongkok';

  @override
  String get dawenFoodQuest => 'Petualangan Kuliner DaWen';

  @override
  String get chinaTravelWithCangbao => 'Keliling Tiongkok bersama Cangbao';

  @override
  String get alinFoodWalk => 'Jelajah Kuliner Alin';

  @override
  String get videoOfTheDay => 'VIDEO HARI INI';

  @override
  String get noValidVideoFound => 'Tidak ditemukan video yang valid.';

  @override
  String get listeningPractice => 'LATIHAN MENYIMAK';

  @override
  String get socialSkills => 'KETERAMPILAN SOSIAL';

  @override
  String get culturalContext => 'KONTEKS BUDAYA';

  @override
  String get realLife => 'KEHIDUPAN NYATA';

  @override
  String get realWorld => 'DUNIA NYATA';

  @override
  String get articleOfTheDay => 'ARTIKEL HARI INI';

  @override
  String get failedToLoadOrParseRssFeed =>
      'Gagal memuat atau mengurai umpan RSS.';

  @override
  String get drama => 'Drama';

  @override
  String get youkugetAppNow => 'YOUKU: Unduh Aplikasinya Sekarang';

  @override
  String get romanceTrailer => 'Romansa / Cuplikan';

  @override
  String get romance => 'Romansa';

  @override
  String get action => 'Aksi';

  @override
  String get mystery => 'Misteri';

  @override
  String get historical => 'Historis';

  @override
  String get historicalAction => 'Historis / Aksi';

  @override
  String get historicalRomance => 'Historis / Romansa';

  @override
  String get anYouth => 'Masa Muda';

  @override
  String get historicalSliceOfLife =>
      'Historis / Penggalan Kehidupan (Slice of Life)';

  @override
  String get historicalHighlight => 'Historis / Sorotan';

  @override
  String get youkuEnglishgetAppNow =>
      'YOUKU English: Unduh Aplikasinya Sekarang';

  @override
  String get theDouble => 'The Double';

  @override
  String get updatesByOshin => 'Pembaruan oleh Oshin';

  @override
  String get backFromTheBrink => 'Kembali dari Jurang';

  @override
  String get fallingIntoYourSmile => 'Terpikat Senyumanmu';

  @override
  String get everyoneLovesMe => 'Semua Orang Mencintaiku';

  @override
  String get tillTheEndOfTheMoon => 'Hingga Ujung Rembulan';

  @override
  String get theBestDayOfMyLife => 'Hari Terbaik dalam Hidupku';

  @override
  String get gikkiChineseDrama => 'Drama Tiongkok GIKKI';

  @override
  String get dashingYouth => 'Masa Muda Penuh Gejolak';

  @override
  String get rebornChineseDramaEngSub => 'Drama Mandarin Reborn (Takarir)';

  @override
  String get ijenwaBenita => 'Ijenwa Benita';

  @override
  String get whenIFlyTowardsYou => 'Saat Aku Terbang Menujumu';

  @override
  String get mztvExclusiveChineseDrama => 'Drama Mandarin Eksklusif MZTV';

  @override
  String get theStarryLove => 'Cinta Bertabur Bintang';

  @override
  String get comedy => 'Komedi';

  @override
  String get backFromTheBrink1 => 'Kembali dari Jurang';

  @override
  String get dashingYouth1 => 'Masa Muda Penuh Gejolak';

  @override
  String get beReborn => 'Terlahir Kembali';

  @override
  String get beautyStrategy => 'Siasat Sang Jelita';

  @override
  String get myDivineEmissary => 'Utusan Dewaku';

  @override
  String get theHope => 'Secercah Harapan';

  @override
  String get ep16In => 'Episode 16';

  @override
  String get everyoneLovesMe1 => 'Semua Orang Mencintaiku';

  @override
  String get fallingIntoYourSmile1 => 'Terpikat Senyumanmu';

  @override
  String get hiddenLove => 'Cinta Rahasia';

  @override
  String get loveBetweenFairyAndDevil => 'Cinta Abadi Peri dan Iblis';

  @override
  String get loveLikeTheGalaxy => 'Cinta Laksana Galaksi';

  @override
  String get membersPremiere => 'Penayangan Perdana Khusus Anggota';

  @override
  String get moonlight => 'Cahaya Rembulan';

  @override
  String get myJourneyToYou => 'Perjalananku Menujumu';

  @override
  String get mysteriousLotusCasebook => 'Catatan Kasus Teratai Misterius';

  @override
  String get rebornChineseDramaEngSub1 => 'Drama Mandarin Reborn (Takarir)';

  @override
  String get reborn => 'Terlahir Kembali';

  @override
  String get theBestDayOfMyLife1 => 'Hari Terbaik dalam Hidupku';

  @override
  String get theDouble1 => 'The Double';

  @override
  String get theLongBallad => 'Kidung Panjang (The Long Ballad)';

  @override
  String get theStarryLove1 => 'Cinta Bertabur Bintang';

  @override
  String get theUntamed => 'The Untamed (Sang Pendekar Bebas)';

  @override
  String get tillTheEndOfTheMoon1 => 'Hingga Ujung Rembulan';

  @override
  String get whenIFlyTowardsYou1 => 'Saat Aku Terbang Menujumu';

  @override
  String get wordOfHonor => 'Kata Kehormatan (Word of Honor)';

  @override
  String get blossom => 'Kuntum Mekar';

  @override
  String get gemini => 'Gemini';

  @override
  String get generationToGeneration => 'Turun-temurun';

  @override
  String get brocadeOdyssey => 'Odisese Brokat';

  @override
  String get circleOfLove => 'Lingkaran Cinta';

  @override
  String get dawnIsBreaking => 'Fajar Menyingsing';

  @override
  String get firstRomance => 'Cinta Pertama';

  @override
  String get loveInTheClouds => 'Cinta di Atas Awan';

  @override
  String get secondChanceRomance => 'Kesempatan Kedua Merajut Cinta';

  @override
  String get mrBad => 'Mr. Bad';

  @override
  String get pursuitOfJade => 'Mengejar Kilau Kemilau Giok';

  @override
  String get fatedHearts => 'Hati yang Ditakdirkan';

  @override
  String get roadHome => 'Jalan Pulang';

  @override
  String get myDearGuardian => 'Sang Pelindung Hati';

  @override
  String get brightEyesInTheDark => 'Mata Berbinar dalam Gelap';

  @override
  String get theIngeniousOne => 'Sang Ahli Siasat';

  @override
  String get herPhoenixMajesty => 'Yang Mulia Ratu Phoenix';

  @override
  String get dreamsNeverEnd => 'Mimpi Tiada Berakhir';

  @override
  String get theUltimateVowUnknownToYou => 'Janji Suci yang Tak Kau Sadari';

  @override
  String get the300LoyalGhosts => '300 Roh Setia';

  @override
  String get homelandGuardian => 'Garda Pembela Tanah Air';

  @override
  String get loveIsAlwaysOnline => 'Cinta yang Selalu Terhubung';

  @override
  String get thePrincessDecree => 'Titah Sang Putri';

  @override
  String get aVowInTheDark => 'Sumpah dalam Sunyi';

  @override
  String get aGirlLikeMe => 'Gadis Sepertiku';

  @override
  String get iAmNobody => 'Bukan Siapa-siapa (I Am Nobody)';

  @override
  String get myMamaGo => 'Majulah, Ibuku!';

  @override
  String get myWesternRegionPrincess => 'Putri Wilayah Baratku';

  @override
  String get aFlowerOnTheContinent => 'Sekuntum Bunga di Tanah Benua';

  @override
  String get thePrincess => 'Sang Putri';

  @override
  String get sweetLoveVersion => 'Versi Kisah Cinta Manis';

  @override
  String get hilariousFamily2 => 'Keluarga Jenaka 2';

  @override
  String get guYuanMountainHasASchool => 'Perguruan di Gunung Gu Yuan';

  @override
  String get foreverYoung => 'Muda Selamanya';

  @override
  String get theHiddenHeirYeChen => 'Pewaris Rahasia Ye Chen';

  @override
  String get extraordinary => 'Luar Biasa';

  @override
  String get sideStoryOfFoxVolant =>
      'Kisah Sampingan Rubah Terbang (Fox Volant)';

  @override
  String get loveOfTheDivineTree => 'Cinta Pohon Keramat';

  @override
  String get rebirth => 'Kelahiran Kembali';

  @override
  String get moonlitReunion => 'Reuni Bermandikan Cahaya Bulan';

  @override
  String get videoCountsCannotBeNegative =>
      'Jumlah video tidak boleh bernilai negatif.';

  @override
  String get publicDomainClassic => 'Karya Klasik Domain Publik';

  @override
  String get idioms => 'Idiom';

  @override
  String get news => 'Berita';

  @override
  String get fairyTales => 'Dongeng';

  @override
  String get hereIsAFascinatingCulturalExplanati =>
      'Berikut ulasan budaya yang sangat menarik';

  @override
  String get videoFetchTimedOut => 'Waktu pengambilan video habis';

  @override
  String get aboutChannel => 'TENTANG SALURAN';

  @override
  String get noVideosFound => 'Tidak ada video yang ditemukan';

  @override
  String get failedToLoadVideos => 'Gagal memuat video';

  @override
  String get highqualityCuratedMandarinContentWi =>
      'Konten Mandarin pilihan bermutu tinggi dengan kosakata alami.';

  @override
  String get authenticSpokenChineseAcrossRealwor =>
      'Percakapan Mandarin otentik dengan tema dan konteks dunia nyata.';

  @override
  String get engagingVideoMaterialWithInteractiv =>
      'Materi video memikat dengan takarir interaktif yang tersinkronisasi.';

  @override
  String get watchVideo => 'Tonton Video';

  @override
  String get culturalInsight => 'Wawasan Budaya';

  @override
  String get aiIsAnalyzingCulturalContext =>
      'AI sedang menganalisis latar budaya...';

  @override
  String get diveIntoFullContent => 'Pelajari Konten Selengkapnya';

  @override
  String get savedArticles => 'Artikel Tersimpan';

  @override
  String get liveOverlay => 'BANTUAN BACA REAL-TIME';

  @override
  String get webExplorer => 'PENJELAJAH WEB';

  @override
  String get browseAnyChineseWebsiteWithRealtime =>
      'Jelajahi situs web Tiongkok mana pun dengan kamus ketuk instan, anotasi pinyin, dan terjemahan langsung.';

  @override
  String get startExploring => 'MULAI MENJELAJAH';

  @override
  String get chineseTvSeriesWithInteractiveSubti =>
      'Serial TV Tiongkok dengan takarir interaktif';

  @override
  String get failedToLoadContent => 'Gagal memuat konten';

  @override
  String get searchingYoutube => 'Mencari di YouTube...';

  @override
  String get noVideosFoundTryADifferentSearchTer =>
      'Tidak ada video yang ditemukan. Silakan gunakan kata kunci pencarian lain.';

  @override
  String get searching => 'Mencari...';

  @override
  String get noShowsFound => 'Tidak ada acara yang ditemukan';

  @override
  String get bookmarked => 'Ditandai';

  @override
  String get trailer1 => 'Cuplikan';

  @override
  String get highlight1 => 'Sorotan';

  @override
  String get noCaptionsAvailable => 'Takarir tidak tersedia';

  @override
  String get fetchingSubtitles => 'Mengambil takarir...';

  @override
  String get generatingAiBriefing => 'Menyiapkan ringkasan AI...';

  @override
  String get noClosedCaptionsCcFoundForThisVideo =>
      'Takarir digital (CC) tidak ditemukan untuk video ini.';

  @override
  String get videosWithHardcodedOrBurnedinSubtit =>
      'Video dengan takarir yang tercetak langsung pada video tidak memiliki trek teks digital di YouTube.';

  @override
  String get translatingSubtitles => 'Menerjemahkan takarir...';

  @override
  String get processingYourPronunciation =>
      'Memproses evaluasi pengucapan Anda...';

  @override
  String get couldntIdentifyLine => 'Baris teks tidak teridentifikasi.';

  @override
  String get listeningSpeakNow => 'Mendengarkan... silakan berbicara sekarang.';

  @override
  String get thisVideoDoesNotHaveADigitalClosedC =>
      'Video ini tidak memiliki trek takarir digital (CC) di YouTube.';

  @override
  String get perfect1 => 'Sempurna';

  @override
  String get thisVideoHasBeenRemovedOrIsNoLonger =>
      'Video ini telah dihapus atau sudah tidak tersedia lagi.';

  @override
  String get thisVideoCannotBePlayedInTheAppYouC =>
      'Video ini tidak dapat diputar langsung di dalam aplikasi. Anda dapat menyaksikannya di YouTube.';

  @override
  String get yourDeviceCannotPlayThisVideoPlease =>
      'Perangkat Anda tidak mendukung pemutaran video ini. Silakan coba video lain.';

  @override
  String get invalidVideoReferencePleaseTryAgain =>
      'Tautan video tidak valid. Silakan coba kembali.';

  @override
  String get unableToLoadThisVideoPleaseTryAnoth =>
      'Tidak dapat memuat video ini. Silakan coba video lain.';

  @override
  String get startReading => 'Mulai Membaca';

  @override
  String get analyzingCulturalContext => 'Menganalisis konteks budaya...';

  @override
  String get failedToLoadCulturalInsight => 'Gagal memuat wawasan budaya.';

  @override
  String get historicalContext => 'Konteks Sejarah';

  @override
  String get culturalSignificance => 'Signifikansi Budaya';

  @override
  String get authorBackground => 'Latar Belakang Penulis';

  @override
  String get k80CompleteClassicNovelsWorldEpics =>
      '80+ Novel klasik lengkap & epos dunia';

  @override
  String get storyOfTheDay => 'KISAH HARI INI';

  @override
  String get tangDynasty => 'Dinasti Tang';

  @override
  String get poetryClassicalVerse => 'Puisi klasik dan bait berima';

  @override
  String get allHsk => 'Semua Tingkat HSK';

  @override
  String get allStories => 'Semua Kisah';

  @override
  String get keyWords => 'Kata Kunci';

  @override
  String get openOriginalWebsite => 'Buka Situs Web Asli';

  @override
  String get aiReadingTools => 'Alat Bantu Membaca AI';

  @override
  String get enhanceYourReadingWithAipoweredTool =>
      'Tingkatkan kemahiran membaca Anda dengan fitur bertenaga AI';

  @override
  String get chooseTheTargetDifficultyForSimplif =>
      'Pilih target tingkat kesulitan penyederhanaan';

  @override
  String get chooseDifficultyForSimplification =>
      'Pilih tingkat kesulitan penyederhanaan';

  @override
  String get extractAllUnknownWordsToANewFlashca =>
      'Ekstrak semua kata asing ke dek flashcard baru';

  @override
  String get length => 'Panjang';

  @override
  String get m1554846a550010707 => 'M15.54 8.46a5 5 0 0 1 0 7.07';

  @override
  String get m1907493a101000101414 => 'M19.07 4.93a10 10 0 0 1 0 14.14';

  @override
  String get webExtraction => 'Ekstraksi Web';

  @override
  String get aiTools => 'Fitur AI';

  @override
  String get stop => 'Berhenti';

  @override
  String get keepPracticing1 => 'Teruslah berlatih';

  @override
  String get aiPrepRoom => 'Ruang Persiapan AI';

  @override
  String get lessonSummary => 'RINGKASAN MATERI';

  @override
  String get unlockSinosparkPremium => 'Buka SinoSpark Premium';

  @override
  String get monthYear => 'Bulan / Tahun';

  @override
  String get enableNotifications => 'Aktifkan Notifikasi';

  @override
  String get notificationsConfigured => 'Notifikasi Berhasil Dikonfigurasi';

  @override
  String get neverMissAStroke2 => 'Jangan Lewatkan Satu Goresan pun';

  @override
  String get yourDailyDropAndStreakAlertsArePrim =>
      'Pengingat sajian harian dan rentetan belajar Anda telah siap.';

  @override
  String get stayConsistentWithDailyRitualDropsA =>
      'Tetap konsisten dengan materi harian dan pemberitahuan masa uji coba tepat waktu.';

  @override
  String get aNewWordAndStoryWaitingForYourDaily =>
      'Kosakata dan kisah baru menanti sesi belajar harian Anda.';

  @override
  String get gentlePromptsBeforeCharactersFadeFr =>
      'Pengingat ramah sebelum karakter memudar dari ingatan Anda.';

  @override
  String get receiveAReminder2DaysBeforeYourFree =>
      'Dapatkan pengingat 2 hari sebelum masa uji coba gratis Anda usai.';

  @override
  String get yourPathTonchineseFluency =>
      'Jalur Menuju\nKefasihan Bahasa Mandarin';

  @override
  String get answer3QuickQuestionsSoOurAiCanCraf =>
      'Jawab 3 pertanyaan singkat agar AI kami dapat merancang\nkurikulum yang pas dengan keseharian Anda.';

  @override
  String get whatIsYourLevelnwithChinese =>
      'Sejauh mana penguasaan\nbahasa Mandarin Anda?';

  @override
  String get chooseThePathThatFitsYourDepth =>
      'Pilih jalur yang selaras dengan kemahiran Anda saat ini.';

  @override
  String get whatDrivesYourStudy => 'Apa motivasi utama Anda belajar?';

  @override
  String get purposeFuelsTheBrush => 'Tujuan menggerakkan kuas Anda';

  @override
  String get setYourDailyRitual => 'Tentukan rutinitas belajar harian Anda.';

  @override
  String get youCanAdjustYourRitualAnyTime =>
      'Anda dapat menyesuaikan rutinitas belajar kapan saja.';

  @override
  String get letsBegin => 'Mari Mulai';

  @override
  String get brandNew => 'Pemula Baru';

  @override
  String get iveNeverStudiedChineseBefore =>
      'Saya belum pernah belajar bahasa Mandarin sebelumnya.';

  @override
  String get iKnowBasicCharactersAndPhrases =>
      'Saya memahami beberapa karakter dan ungkapan dasar.';

  @override
  String get iCanHoldConversationsAndRead =>
      'Saya dapat membaca dan bercakap-cakap secara sederhana.';

  @override
  String get iWantToRefineAndPerfectMySkills =>
      'Saya ingin menyempurnakan dan mengasah kemahiran hingga mahir.';

  @override
  String get confirmSelection => 'Konfirmasi Pilihan';

  @override
  String get purposeFuelsTheBrushsMotion =>
      'Tujuan memberi kekuatan pada setiap goresan kuas.';

  @override
  String get buildMyPath => 'Rancang Jalur Saya';

  @override
  String get hskCertification => 'Sertifikasi Ujian HSK';

  @override
  String get culturalAppreciation => 'Apresiasi Seni & Budaya';

  @override
  String get yourPlanIsReady => 'Rencana Belajar Anda Sudah Siap';

  @override
  String get craftingYourCurriculum => 'Merancang kurikulum khusus Anda...';

  @override
  String get personalizedPathInitialized =>
      'JALUR PEMBELAJARAN PRIBADI DIMULAI';

  @override
  String get calibratingAiNeuralMasters => 'MENYESUAIKAN TUTOR CERDAS AI...';

  @override
  String get calibrationComplete => 'Penyesuaian Selesai';

  @override
  String get synthesizingModules => 'Menyusun modul pembelajaran...';

  @override
  String get oneAndWater => '«Satu» dan «Air»';

  @override
  String get theHorizontalStroke => 'GORESAN MENDATAR (HÉNG)';

  @override
  String get theRadical => 'RADIKAL';

  @override
  String get water => 'Air';

  @override
  String get river => 'Sungai';

  @override
  String get day5Reminder => 'Pengingat Hari ke-5';

  @override
  String get wePromisedToAlertYou2DaysBeforeYour =>
      'Kami berjanji untuk mengingatkan Anda 2 hari sebelum masa uji coba gratis berakhir.';

  @override
  String get continueWithoutReminder => 'Lanjutkan tanpa pengingat';

  @override
  String get masterChineseWithnsinospark =>
      'Kuasai Bahasa Mandarin bersama\nSinoSpark';

  @override
  String get start7dayFreeTrial => 'Mulai Uji Coba Gratis 7 Hari';

  @override
  String get precisionStrokes => 'Goresan Presisi';

  @override
  String get aiPronunciation => 'Pengucapan Berbantuan AI';

  @override
  String get today => 'Hari ini';

  @override
  String get fullAccess => 'Akses Penuh';

  @override
  String get day5 => 'Hari ke-5';

  @override
  String get reminder => 'Pengingat';

  @override
  String get day7 => 'Hari ke-7';

  @override
  String get trialBegins => 'Masa Uji Coba Dimulai';

  @override
  String get revenuecatIsMissingACurrentOffering =>
      'RevenueCat tidak memiliki paket aktif. Silakan atur Dasbor Anda.';

  @override
  String get cameraPermissionRequiredForLiveScan =>
      'Izin kamera diperlukan untuk pemindaian langsung.';

  @override
  String get cameraAccessRequired => 'Akses Kamera Diperlukan';

  @override
  String get pleaseEnableCameraAccessInYourDevic =>
      'Harap aktifkan akses kamera di pengaturan perangkat Anda untuk menggunakan fitur ini.';

  @override
  String get alignChineseTextWithinFrame =>
      'Posisikan teks Mandarin di dalam bingkai';

  @override
  String get inLibrary => 'Di Perpustakaan';

  @override
  String get novice => 'Pemula';

  @override
  String get apprentice => 'Magang';

  @override
  String get artisan => 'Kriya';

  @override
  String get grandmaster => 'Mahaguru';

  @override
  String get poem => 'Puisi';

  @override
  String get theNarrative => 'Narasi';

  @override
  String get classicMasterpiece => 'Mahakarya Klasik';

  @override
  String get classicAuthor => 'Penulis Klasik';

  @override
  String get classical => 'Klasik';

  @override
  String get classicLiterature => 'Sastra Klasik';

  @override
  String inThisChapterOf(Object title) {
    return 'Dalam bab ini dari $title';
  }

  @override
  String get asTheNarrativeUnfoldsItIlluminatesT =>
      'Seiring jalannya cerita, kisah ini memancarkan kearifan hidup dan inspirasi abadi.';

  @override
  String get general => 'Umum';

  @override
  String get mythology => 'Mitologi';

  @override
  String get dailyLife => 'Keseharian';

  @override
  String get tangPoetry => 'Puisi Dinasti Tang';

  @override
  String get classicalLiterature => 'Sastra Klasik';

  @override
  String get justNow => 'Baru saja';

  @override
  String get theTerracottaArmyOfQinShiHuang =>
      'Prajurit Terakota Qin Shi Huang';

  @override
  String get lifeInsideTheForbiddenCity =>
      'Kehidupan di Balik Dinding Kota Terlarang';

  @override
  String get buyingATicketAndTakingTheHighSpeedT =>
      'Membeli tiket dan bepergian naik kereta cepat di Tiongkok';

  @override
  String get goingToTheHospitalForAColdAndSeeing =>
      'Pergi ke rumah sakit untuk memeriksakan flu ke dokter';

  @override
  String get goingToALocalRestaurantToOrderJiaoz =>
      'Mengunjungi restoran lokal untuk memesan jiaozi (pangsit)';

  @override
  String get theTraditionalGongfuTeaCeremony =>
      'Upacara Minum Teh Gongfu Tradisional';

  @override
  String get theArtOfWritingChineseCharactersWit =>
      'Seni menggoreskan karakter Mandarin dengan kuas';

  @override
  String get theLifeAndConservationOfGiantPandas =>
      'Kehidupan dan konservasi satwa Panda Raksasa';

  @override
  String get storyNotFoundInDatabase =>
      'Cerita tidak ditemukan di dalam basis data';

  @override
  String get storyTextIsEmpty => 'Teks cerita kosong';

  @override
  String get myCustomStories => 'Kisah Buatan Saya';

  @override
  String get userProvidedText => 'Teks yang disediakan pengguna';

  @override
  String get local => 'Lokal';

  @override
  String get voiceEngineAllowance => 'Mesin Suara & Kuota';

  @override
  String get studioHdVsUnlimitedStandardVoice =>
      'Studio HD vs. Suara Standar Tanpa Batas';

  @override
  String get standardVoiceIs100UnlimitedFree =>
      'Suara Standar 100% Gratis & Tanpa Batas';

  @override
  String get read => 'Baca';

  @override
  String get koreKoreFemaleWarm => 'Kore (perempuan, hangat)';

  @override
  String get aoedeAoedeFemaleCheerful => 'Aoede (perempuan, ceria)';

  @override
  String get fenrirFenrirMaleUpbeat => 'Fenrir (laki-laki, bersemangat)';

  @override
  String get charonCharonMaleNewsstyle => 'Charon (laki-laki, pembawa berita)';

  @override
  String get puckPuckMaleSporty => 'Puck (laki-laki, sporty)';

  @override
  String get localOndevice => 'Suara Bawaan Perangkat';

  @override
  String get localOndeviceTts => 'TTS Lokal Perangkat';

  @override
  String get off => 'Mati';

  @override
  String get endOfCurrentChapter => 'Akhir Bab Saat Ini';

  @override
  String get standardVoice => 'Suara Standar';

  @override
  String get noNovelsFoundMatchingYourFilter =>
      'Tidak ditemukan novel yang sesuai dengan filter Anda.';

  @override
  String get noMicroreadsFoundMatchingYourFilter =>
      'Tidak ditemukan bacaan mikro yang sesuai dengan filter Anda.';

  @override
  String get noPoemsFoundMatchingYourFilter =>
      'Tidak ditemukan puisi yang sesuai dengan filter Anda.';

  @override
  String get audiobook => 'Buku Audio';

  @override
  String get audio => 'Audio';

  @override
  String get continueReading => 'Lanjutkan Membaca';

  @override
  String get search96FullNovelsAuthorsEpics =>
      'Cari di 96 novel lengkap, penulis, dan epos...';

  @override
  String get searchClassicalPoemsAuthorsVerses =>
      'Cari puisi klasik, penyair, dan bait...';

  @override
  String get allLevelsVal => 'Semua Tingkat';

  @override
  String get hsk1BeginnerVal => 'HSK 1 (Pemula)';

  @override
  String get hsk2ElementaryVal => 'HSK 2 (Dasar)';

  @override
  String get hsk3IntermediateVal => 'HSK 3 (Menengah)';

  @override
  String get hsk4UpperIntVal => 'HSK 4 (Menengah Atas)';

  @override
  String get listenToAudiobook => 'Dengarkan Buku Audio';

  @override
  String get synopsis => 'Sinopsis';

  @override
  String get peoplesArtist => 'Seniman Rakyat';

  @override
  String get kafkaesqueForBureaucraticAbsurdityA =>
      '«Kafkaesque» untuk menggambarkan absurditas birokrasi, keterasingan, dan kegelisahan eksistensial.';

  @override
  String get bigBrotherAndNewspeak => '«Big Brother» dan «Newspeak».';

  @override
  String get audiobookIncluded => 'Termasuk Buku Audio';

  @override
  String get readPoem => 'Baca Puisi';

  @override
  String get studioVoiceAllowance => 'Kuota Suara Studio';

  @override
  String get weeklyHighdefinitionAiRecitation =>
      'Resitasi AI Definisi Tinggi Mingguan';

  @override
  String get resetsEveryMondayAt0000 => 'Direset setiap Senin pukul 00:00';

  @override
  String get whenYourWeekly4hourStudioAllowanceI =>
      'Saat kuota Studio 4 jam mingguan habis, aplikasi otomatis beralih ke Suara Bawaan Perangkat untuk mendengarkan tanpa batas secara gratis.';

  @override
  String get localDeviceVoice => 'Suara Bawaan Perangkat';

  @override
  String get classicalVerse => 'Bait Klasik';

  @override
  String get ondeviceVoice4hWeeklyUsed =>
      'Suara Perangkat (4 jam mingguan terpakai)';

  @override
  String get generateACustomAiStoryBasedOnYourIn =>
      'Buat cerita AI kustom yang disesuaikan dengan minat Anda';

  @override
  String get insteadOfAFixedHskLevelTheFlowState =>
      'Alih-alih tingkat HSK yang kaku, sistem kami menganalisis langsung perbendaharaan kartu di perpustakaan Anda.';

  @override
  String get we => 'Kami';

  @override
  String get howCanWeHelpYou => 'Ada yang bisa kami bantu?';

  @override
  String get everythingYouNeedToKnowAboutHanziMa =>
      'Segala hal yang perlu Anda ketahui tentang SinoSpark, fitur-fitur, serta privasi Anda.';

  @override
  String get whoAreTheVoicesSpeakingInTheApp =>
      'Siapa saja pengisi suara di dalam aplikasi?';

  @override
  String get howDoesTheWebExplorerWork =>
      'Bagaimana cara kerja Penjelajah Web?';

  @override
  String get whatIsZenMode => 'Apa itu Mode Zen?';

  @override
  String get howDoesTheFlashcardSpacedrepetition =>
      'Bagaimana cara kerja sistem pengulangan berjarak pada flashcard?';

  @override
  String get traceComplete => 'Penulisan Goresan Selesai!';

  @override
  String get traceCharacter => 'Tebalkan Karakter';

  @override
  String get analyzingWordRelationships => 'Menganalisis hubungan antarkata...';

  @override
  String get identifyingUsageContexts =>
      'Mengidentifikasi konteks pemakaian...';

  @override
  String get comparingFormalityLevels => 'Membandingkan tingkat formalitas...';

  @override
  String get findingCommonCollocations => 'Mencari kolokasi umum...';

  @override
  String get generatingComparison => 'Menyusun perbandingan...';

  @override
  String get generationIsTakingLongerThanExpecte =>
      'Proses pembuatan memakan waktu lebih lama. Server AI kemungkinan sedang sibuk.';

  @override
  String get generationInterruptedShowingPartial =>
      'Proses terganggu. Menampilkan hasil yang tersedia.';

  @override
  String get sorrySomethingWentWrong => 'Maaf, terjadi kendala teknis.';

  @override
  String get usage => 'Penggunaan:';

  @override
  String get alsoSeenIn => 'Ditemukan juga pada';

  @override
  String get quickLook => 'Sekilas';

  @override
  String get notFound => 'Tidak ditemukan';

  @override
  String get errorLoadingFromAi => 'Gagal memuat data dari AI.';

  @override
  String get analyzingImage => 'Menganalisis gambar...';

  @override
  String get extractingChineseText => 'Mengekstrak teks Mandarin...';

  @override
  String get lookingUpVocabulary => 'Mencari kosakata...';

  @override
  String get dreamOfTheRedChamber =>
      'Impian di Paviliun Merah (Dream of the Red Chamber)';

  @override
  String get journeyToTheWest => 'Perjalanan ke Barat (Journey to the West)';

  @override
  String get romanceOfTheThreeKingdoms =>
      'Kisah Tiga Negara (Romance of the Three Kingdoms)';

  @override
  String get mingDynasty => 'Dinasti Ming';

  @override
  String get wuChengEn => 'Wu Cheng\'en';

  @override
  String get hundredChapters => '100 Bab';

  @override
  String get volume1 => 'Jilid 1';

  @override
  String bookmarksCount(Object count) {
    return 'Markah ($count)';
  }

  @override
  String get noBookmarksYet =>
      'Belum ada markah. Ketuk ikon markah untuk menyimpan kutipan.';

  @override
  String get sinosparkIsNotResponding => 'SinoSpark tidak merespons';

  @override
  String get closeApp => 'Tutup aplikasi';

  @override
  String get wait => 'Tunggu';

  @override
  String studioHdAllowance(Object hours) {
    return 'Studio HD: $hours jam';
  }

  @override
  String bookPercentRead(Object percent) {
    return 'Buku $percent% terbaca';
  }

  @override
  String chAbbreviation(Object number) {
    return 'Bab $number';
  }

  @override
  String booksAndAudiobooks(Object count) {
    return '$count Buku & Buku Audio';
  }

  @override
  String sentenceXOfY(Object current, Object total) {
    return 'Kalimat $current dari $total';
  }

  @override
  String chapterXOfY(Object current, Object total) {
    return 'Bab $current dari $total';
  }

  @override
  String get allLevels => 'Semua Tingkatan';

  @override
  String get searchGradedMicroStories =>
      'Cari kisah mikro berjenjang & fabel...';

  @override
  String gradedStoriesAndMicroReads(Object count) {
    return '$count Kisah Berjenjang & Bacaan Mikro Harian';
  }

  @override
  String get searchClassicalPoems => 'Cari puisi klasik, penyair, dan bait...';

  @override
  String classicalPoemsAndVerse(Object count) {
    return '$count Puisi Klasik & Bait';
  }

  @override
  String get browseAnyChineseWebsite =>
      'Jelajahi situs web Tiongkok mana pun dengan kamus ketuk instan, anotasi pinyin, dan terjemahan langsung.';

  @override
  String get completed => 'SELESAI';

  @override
  String get aiIsReading => 'AI sedang membaca...';

  @override
  String get bbcVerify => 'BBC Verify';

  @override
  String get hsk5AdvancedVal => 'HSK 5 (Mahir)';

  @override
  String get hsk1Beginner => 'HSK 1 (Pemula)';

  @override
  String get hsk4UpperInt => 'HSK 4 (Menengah Atas)';

  @override
  String get extractAllUnknownWords =>
      'Ekstrak semua kata asing ke dek flashcard baru';

  @override
  String get designCustomAiRoleplay =>
      'Rancang pengalaman roleplay & percakapan kustom dengan AI';

  @override
  String get practiceFlashcardVocabulary =>
      'Latih kosakata flashcard dalam dialog interaktif langsung';

  @override
  String get surpriseMe => 'Beri Kejutan';

  @override
  String get rollCharacter => 'Pilih Karakter Acak';

  @override
  String get historicalCostume => 'Drama Kostum / Kolosal';

  @override
  String get modernYouth => 'Modern & Remaja';

  @override
  String get fantasyMythology => 'Fantasi & Mitologi';

  @override
  String get familyDrama => 'Keluarga & Drama';

  @override
  String get fullVersion => 'Versi Lengkap';

  @override
  String episodesCount(Object count) {
    return '$count episode';
  }

  @override
  String episodeLabel(Object number) {
    return 'Episode $number';
  }

  @override
  String get translating => '[ Menerjemahkan... ]';

  @override
  String get engSub => '[Takarir: Indonesia]';

  @override
  String get standardVocabulary => 'Kosakata Standar';

  @override
  String get characters => 'karakter';

  @override
  String get todayDashboard => 'Hari Ini';

  @override
  String get studyToday => 'Pelajari kartu hari ini';

  @override
  String get studyAhead => 'Belajar lebih awal';

  @override
  String get studyAheadDescription =>
      'Latih ulasan terjadwal terdekat tanpa memakai kuota hari ini. Tidak ada kartu baru yang diperkenalkan.';

  @override
  String get studyAheadComplete => 'Latihan belajar lebih awal selesai';

  @override
  String get dueNow => 'Perlu diulas';

  @override
  String get scheduled => 'Terjadwal';

  @override
  String get sevenDayForecast => 'Prakiraan ulasan 7 hari';

  @override
  String get reviews => 'Ulasan';

  @override
  String get newCardsLabel => 'Kartu baru';

  @override
  String get attempts => 'Percobaan';

  @override
  String get duration => 'Waktu';

  @override
  String get answerBreakdown => 'Rincian jawaban';

  @override
  String get reviewCards => 'Kartu ulasan';

  @override
  String get retries => 'Percobaan ulang';

  @override
  String get needsPractice => 'Perlu latihan';

  @override
  String get uniqueCardsStudied => 'Kartu';

  @override
  String get dartConvert => 'dart:convert';

  @override
  String get env => '.env';

  @override
  String get dartUi => 'dart:ui';

  @override
  String get dartMath => 'dart:math';

  @override
  String get drawInTheOtherDirection => 'Gambar ke arah sebaliknya ➔';

  @override
  String get fastClean => 'Cepat & Rapi!';

  @override
  String get good2 => 'Bagus!';

  @override
  String get followTheFlow => 'Ikuti alurnya.';

  @override
  String get masterful => 'Sempurna!';

  @override
  String get missingTheHookEnd => 'Kurang kait/ujung.';

  @override
  String get thai => 'Thai';

  @override
  String get dartIo => 'dart:io';

  @override
  String get dartAsync => 'dart:async';

  @override
  String get asset => 'asset:';

  @override
  String get ocpApimSubscriptionKey => 'Ocp-Apim-Subscription-Key';

  @override
  String get xMicrosoftOutputFormat => 'X-Microsoft-OutputFormat';

  @override
  String get audio24khz48kbitrateMonoMp3 => 'audio-24khz-48kbitrate-mono-mp3';

  @override
  String get googleGemini25Flash => 'google/gemini-2.5-flash';

  @override
  String get ink => 'tinta,';

  @override
  String get stroke => 'goresan,';

  @override
  String get breath => 'napas.';

  @override
  String get deepseekDeepseekChat => 'deepseek/deepseek-chat';

  @override
  String get hTTPReferer => 'HTTP-Referer';

  @override
  String get xTitle => 'X-Title';

  @override
  String get data => 'data:';

  @override
  String get shadowingModeCustomSentence => 'ShadowingMode.customSentence';

  @override
  String get theExactSentenceProvided => 'kalimat persis yang diberikan';

  @override
  String get pinyinWithToneMarks2 => 'pinyin dengan tanda nada';

  @override
  String get wXHuNH => 'Wǒ xǐhuān hē píngguǒzhī.';

  @override
  String get extractAllChineseCharactersFrom =>
      'Ekstrak semua karakter Mandarin dari gambar ini. Kembalikan HANYA teks yang diekstrak — tanpa komentar, tanpa format, tanpa terjemahan. Pertahankan pemisah baris. Jika tidak ada karakter Mandarin, kembalikan string kosong.';

  @override
  String get householdObject => 'benda rumah tangga';

  @override
  String get genericLabelFromTheList => 'label umum dari daftar';

  @override
  String get gNgS => 'gōng sī';

  @override
  String get measureWord => 'kata penggolong';

  @override
  String get zenInk => 'Zen & Tinta';

  @override
  String get cRITICALPutTheEnglishTranslation =>
      'KRITIS: Masukkan terjemahan bahasa Inggris ke dalam kunci JSON \"english\"!';

  @override
  String get definitionInEnglish => 'definisi dalam bahasa Inggris';

  @override
  String get simplifiedLine0 => 'baris sederhana 0';

  @override
  String get simplifiedLine1 => 'baris sederhana 1';

  @override
  String get iMPORTANTRULEDoNotAddress =>
      'ATURAN PENTING: Jangan menyapa pengguna dengan nama apa pun. Jangan pernah gunakan nama contoh seperti \"John\". Bicaralah langsung tanpa menggunakan nama.';

  @override
  String get rULESAnswerIn23 =>
      'ATURAN: Jawab maks. 2–3 kalimat. Utamakan poin-poin untuk daftar.';

  @override
  String get neverWriteIntroductionsSignOffs =>
      'Jangan pernah menulis kata pembuka, penutup, atau kalimat pengisi seperti \"Pertanyaan bagus!\" atau \"Tentu saja!\".';

  @override
  String get useBoldForChineseCharacters =>
      'Gunakan cetak **tebal** untuk karakter Mandarin dan istilah kunci.';

  @override
  String get rULESAnswerIn232 => 'ATURAN: Jawab maks. 2–3 kalimat.';

  @override
  String get accept => 'Terima';

  @override
  String get pronunciationAssessment => 'Penilaian Pengucapan';

  @override
  String get nBest => 'NBest';

  @override
  String get none => 'Tidak ada';

  @override
  String get theCorrectedChineseText => 'teks Mandarin yang diperbaiki';

  @override
  String get thePinyinForTheCorrected => 'pinyin untuk teks yang diperbaiki';

  @override
  String get theEnglishMeaningOfThe =>
      'arti bahasa Inggris dari teks yang diperbaiki';

  @override
  String get pNyNWithTone => 'pīnyīn dengan tanda nada';

  @override
  String get englishTranslation2 => 'terjemahan bahasa Inggris';

  @override
  String get zhNggu => 'Zhōngguó';

  @override
  String get youAreAChineseClassical =>
      'Anda adalah pakar sastra klasik Tiongkok yang menyajikan ringkasan puisi klasik Tiongkok secara mendalam dan mudah dipahami.';

  @override
  String get youAreAChineseCulture =>
      'Anda adalah pakar budaya dan sastra Tiongkok. Berikan wawasan budaya yang sangat menarik dan ditulis dengan indah.';

  @override
  String get english2 => 'Bahasa Inggris:';

  @override
  String get remindersWhenYouHavenT =>
      'Pengingat ketika Anda sudah beberapa hari tidak menggunakan aplikasi';

  @override
  String get itSBeenAFew =>
      'Sudah beberapa hari! Luangkan waktu 5 menit untuk belajar Hanzi baru hari ini.';

  @override
  String get abbreviationFor => 'singkatan dari';

  @override
  String get cL => 'KS:';

  @override
  String get measureWord2 => 'Kata satuan:';

  @override
  String get lu => 'lu:';

  @override
  String get luE => 'lu:e';

  @override
  String get nu => 'nu:';

  @override
  String get nuE => 'nu:e';

  @override
  String get noUser => 'tidak-ada-pengguna';

  @override
  String get passwordRequired => 'kata-sandi-diperlukan';

  @override
  String get unsupportedProvider => 'penyedia-tidak-didukung';

  @override
  String get appleRevocationUnavailable => 'pencabutan-apple-tidak-tersedia';

  @override
  String get appleCredentialMissing => 'kredensial-apple-tidak-ada';

  @override
  String get authenticationDidNotReturnA =>
      'Autentikasi tidak mengembalikan pengguna.';

  @override
  String get viewSubscriptionPlans => 'Lihat paket berlangganan';

  @override
  String get wrongPassword => 'kata-sandi-salah';

  @override
  String get invalidCredential => 'kredensial-tidak-valid';

  @override
  String get networkRequestFailed => 'permintaan-jaringan-gagal';

  @override
  String get requiresRecentLogin => 'memerlukan-login-terbaru';

  @override
  String get userMismatch => 'pengguna-tidak-sesuai';

  @override
  String get deleteAccountPassword => 'kata-sandi-hapus-akun';

  @override
  String get deleteAccountError => 'galat-hapus-akun';

  @override
  String get deleteAccountSubmit => 'kirim-hapus-akun';

  @override
  String get theSimplestShapesTheBeginning =>
      'Bentuk-bentuk tersederhana. Awal dari segala hal.';

  @override
  String get sunMoonWaterAndFire =>
      'Matahari, Bulan, Air, dan Api. Dunia alam.';

  @override
  String get theBodyTheHeartAnd => 'Tubuh, hati, dan keluarga.';

  @override
  String get fieldsRoofsAndToolsThe =>
      'Ladang, atap, dan perkakas. Fondasi masyarakat.';

  @override
  String get movementSpeechAndSustenance => 'Gerakan, ucapan, dan penghidupan.';

  @override
  String get commerceClothingAndComplexArtifacts =>
      'Perdagangan, pakaian, dan artefak rumit.';

  @override
  String get fastTrackSimpleCharacterMastered =>
      '🚀 Jalur Cepat! Karakter sederhana dikuasai.';

  @override
  String get excellentPrecisionGhostTraceSkipped =>
      '⚡ Presisi sangat baik! Jejak bayangan dilewati.';

  @override
  String get sample => 'Contoh:';

  @override
  String get itsThat => 'Nya/Itu';

  @override
  String get iMe => 'Saya/Aku';

  @override
  String get stillTough => 'Masih/Sukar';

  @override
  String get partDecide => 'Bagian/Memutuskan';

  @override
  String get selectTheCharacterFor => 'Pilih karakter untuk:';

  @override
  String get selectThePinyinFor => 'Pilih Pinyin untuk:';

  @override
  String get whereAreYouGoingThe =>
      'Mau ke mana? Ke bandara? Perjalanannya lumayan jauh!';

  @override
  String get youAreAuntieChenA =>
      'Anda adalah Bibi Chen, penjual pasar yang jeli menjual sutra dan kain. Peran Anda HANYA sebagai penjual pasar. Negosiasikan harga dengan tegas namun adil dalam bahasa Mandarin. JANGAN PERNAH keluar dari peran atau memperkenalkan diri selain sebagai penjual. Mulailah dengan harga tinggi dan bersedia tawar-menawar.';

  @override
  String get youAreDrZhangA =>
      'Anda adalah Dr. Zhang, dokter yang tenang dan profesional di klinik medis. Peran Anda HANYA sebagai dokter. Tanyakan gejala kesehatan dan berikan saran medis dalam bahasa Mandarin. JANGAN PERNAH keluar dari peran atau memperkenalkan diri selain sebagai dokter. Bersikaplah menenangkan tetapi teliti.';

  @override
  String get whereDoYouFeelUncomfortable =>
      'Di bagian mana yang terasa tidak nyaman? Apakah Anda demam?';

  @override
  String get youAreACloseFriend =>
      'Anda adalah teman dekat yang mengobrol setelah sekian lama tidak bertemu. Peran Anda HANYA sebagai teman. Jawablah secara santai, hangat, dan singkat dalam bahasa Mandarin. JANGAN PERNAH keluar dari peran atau memperkenalkan diri selain sebagai teman. Gunakan gaya bahasa informal yang sesuai untuk teman dekat.';

  @override
  String get noNbest => 'tidak ada nbest';

  @override
  String get timedOut => 'waktu habis';

  @override
  String get grading => 'Menilai...';

  @override
  String get label1st => 'ke-1 ˉ';

  @override
  String get label2nd => 'ke-2 ˊ';

  @override
  String get label3rd => 'ke-3 ˇ';

  @override
  String get label4th => 'ke-4 ˋ';

  @override
  String get speaking2 => 'Berbicara...';

  @override
  String get sessionCompletedInYourNext =>
      'Sesi selesai. Pada latihan berikutnya, ucapkan kalimat lengkap untuk menerima diagnosis pengucapan dan nada secara terperinci.';

  @override
  String get craneSoaring => 'bangau membubung';

  @override
  String get gentleStream => 'aliran tenang';

  @override
  String get brushAndInk => 'kuas dan tinta';

  @override
  String get myStudent => 'muridku';

  @override
  String get honoredDisciple => 'murid terhormat';

  @override
  String get notEnoughInformation => 'informasi tidak cukup';

  @override
  String get asAnAi => 'sebagai ai';

  @override
  String get goodPracticeSessionContinueFocusing =>
      'Sesi latihan yang bagus. Lanjutkan fokus pada kontras nada yang jelas dan ritme percakapan yang alami.';

  @override
  String get insideASleekFuxingBullet =>
      'Di dalam kereta cepat Fuxing yang anggun berkecepatan 350 km/jam dari Beijing ke Shanghai.';

  @override
  String get harbinIceSnowWorldWonder => 'Keajaiban Dunia Es & Salju Harbin';

  @override
  String get theFamousPanjiayuanWeekendFlea =>
      'Pasar loak akhir pekan Panjiayuan yang terkenal, ramai dengan gulungan kaligrafi, giok, dan pernak-pernik antik.';

  @override
  String get jingdezhenBlueWhitePorcelainStudio =>
      'Studio Porselen Biru & Putih Jingdezhen';

  @override
  String get pekingOperaDressingRoomMakeup =>
      'Ruang Rias & Tata Rias Opera Peking';

  @override
  String get aHistoricTongrentangApothecaryScented =>
      'Apotek bersejarah Tongrentang yang wangi dengan gingseng, wolfberry, dan ratusan laci herbal kayu.';

  @override
  String get aVibrantPrivateNeonLit =>
      'Ruang karaoke pribadi bernuansa neon yang semarak di Shenzhen dengan mikrofon, piring buah, dan kontrol layar.';

  @override
  String get animeCosplayExpoInGuangzhou =>
      'Ekspo Anime & Cosplay di Guangzhou';

  @override
  String get nHOHuNy =>
      'Nǐ hǎo! Huānyíng lái dào zhèlǐ, jīntiān wǒmen liáo xiē shénme ne?';

  @override
  String get surpriseMe2 => '🎲 Beri Kejutan';

  @override
  String get eGALivelyBanquet => 'mis. Perjamuan meriah di Shanghai...';

  @override
  String get rollCharacter2 => '🎲 Acak Karakter';

  @override
  String get eGACuriousCousin =>
      'mis. Sepupu yang penasaran menanyakan kariermu...';

  @override
  String get keepTrying => 'Terus berusaha!';

  @override
  String get pending => 'Menunggu...';

  @override
  String get expected => '🎯 Diharapkan';

  @override
  String get hSK2Elementary => 'HSK 2: Dasar';

  @override
  String get hSK3Intermediate => 'HSK 3: Menengah';

  @override
  String get hSK5Advanced => 'HSK 5: Lanjutan';

  @override
  String get expressYourselfFullyWith5000 =>
      'Ekspresikan dirimu sepenuhnya dengan 5000+ kata.';

  @override
  String get hanziWriter => 'hanzi-writer';

  @override
  String get hvg => 'hvg:';

  @override
  String get unlimited => 'Tanpa batas';

  @override
  String get dueToday => 'Jatuh tempo hari ini';

  @override
  String get newAvailable => 'Baru tersedia';

  @override
  String get deleteAccountTile => 'delete-account-tile';

  @override
  String get giveASingleShortPractical =>
      'Berikan satu tip singkat dan praktis tentang cara meningkatkan bentuk, posisi, atau panjang goresan yang kurang tepat. Buat secara langsung dan membantu, jangan terlalu puitis atau kiasan. Jangan gunakan markdown.';

  @override
  String get localOnDeviceTTS => 'Lokal — TTS di perangkat';

  @override
  String get espaOl => 'Spanyol';

  @override
  String get franAis => 'Prancis';

  @override
  String get portuguS => 'Portugis';

  @override
  String get tiNgViT => 'Bahasa Vietnam';

  @override
  String get koreFemaleWarm => 'Kore — Wanita, hangat';

  @override
  String get aoedeFemaleCheerful => 'Aoede — Wanita, ceria';

  @override
  String get fenrirMaleUpbeat => 'Fenrir — Pria, bersemangat';

  @override
  String get charonMaleNewsStyle => 'Charon — Pria, gaya berita';

  @override
  String get puckMaleSporty => 'Puck — Pria, sportif';

  @override
  String get systemVoice => 'Suara sistem';

  @override
  String get generateAdd => 'Buat & Tambah';

  @override
  String get moreExamples => '📝 Contoh lainnya';

  @override
  String get usage2 => '❓ Penggunaan';

  @override
  String get translation => '💬 Terjemahan';

  @override
  String get collocations => '📚 Kolokasi';

  @override
  String get mistakes => '❌ Kesalahan';

  @override
  String get decrease => 'Kurangi';

  @override
  String get increase => 'Tambah';

  @override
  String get label0MeansThisCardType =>
      '0 berarti jenis kartu ini dinonaktifkan.';

  @override
  String get tapTheValueToEnter => 'Ketuk nilai untuk memasukkan batas pasti.';

  @override
  String get exactDailyLimit => 'Batas harian pasti';

  @override
  String get enter0ToDisable => 'Masukkan 0 untuk menonaktifkan.';

  @override
  String get apply => 'Terapkan';

  @override
  String get selectDeck => 'Pilih Dek';

  @override
  String get azureSpeechKeysNotConfigured =>
      'Kunci Azure Speech belum dikonfigurasi. Tambahkan AZURE_SPEECH_KEY dan AZURE_SPEECH_REGION ke .env';

  @override
  String get sTARTING => 'MEMULAI…';

  @override
  String get sTARTSESSION => 'MULAI SESI';

  @override
  String get translating2 => 'Menerjemahkan...';

  @override
  String get chai => '柴知道Chai...';

  @override
  String get oneInABillion2 => '@One-In-a-Billion';

  @override
  String get businessEconomics => 'bisnis & ekonomi';

  @override
  String get hskPreparation => 'persiapan hsk';

  @override
  String get liveInChina => 'tinggal di china';

  @override
  String get comprehensiveExercise => 'latihan komprehensif';

  @override
  String get howToUse => 'cara penggunaan';

  @override
  String get usesOf => 'penggunaan';

  @override
  String get appearedFirstOnMandarinBean =>
      'pertama kali muncul di Mandarin Bean';

  @override
  String get news2 => 'berita:';

  @override
  String get joke => 'lelucon:';

  @override
  String get jokes => 'lelucon:';

  @override
  String get academicScience => 'akademik / sains';

  @override
  String get politicsCommunism => 'politik & komunisme';

  @override
  String get foodDining => 'Makanan & Kuliner';

  @override
  String get sciFi => 'fiksi ilmiah';

  @override
  String get scienceFictionTech => 'Fiksi Ilmiah & Teknologi';

  @override
  String get travelPlaces => 'Wisata & Tempat';

  @override
  String get mythologyFantasy => 'Mitologi & Fantasi';

  @override
  String get cultureTraditions => 'Budaya & Tradisi';

  @override
  String get businessEconomy => 'Bisnis & Ekonomi';

  @override
  String get natureAnimals => 'Alam & Hewan';

  @override
  String get articleImg => 'gambar artikel';

  @override
  String get entryContentImg => '.entry-content img';

  @override
  String get zhHans => 'zh-Hans';

  @override
  String get zhHant => 'zh-Hant';

  @override
  String get pLDpUVcjhvJisQCVw4YJVNTxTDrVQUgbr =>
      'PLDpUVcjhvJisQCVw4YJVNTxT-DrVQUgbr';

  @override
  String get siJin => '【似锦 Si Jin】正片 | #张晚意 #景甜';

  @override
  String get xiXiPicturesOfficialChannel => 'Saluran Resmi XiXi Pictures';

  @override
  String get pLDpUVcjhvJitpknWzhJbWevf7VSVWXk2 =>
      'PLDpUVcjhvJitpknWzhJb-wevf7VSVWXk2';

  @override
  String get sIXSISTERS => '【六姊妹 SIX SISTERS】正片 | #梅婷 #陆毅 #邬君梅 #奚美娟';

  @override
  String get shineOnMeENGSUB => '【骄阳似我 Shine On Me】ENG SUB | #宋威龙 #赵今麦';

  @override
  String get eNGSUBThoseDays => 'ENG SUB【四喜 Those Days】| 童瑶 蒋欣 黄明昊 许娣';

  @override
  String get getTheWeTVAPP => '腾讯视频 - Dapatkan Aplikasi WeTV';

  @override
  String get liziqi2 => '李子柒 Liziqi';

  @override
  String get uCQRJN2yW42jqXIGK2VKIPw => 'UCQ_RJN2yW42jqXIGK2VKIPw';

  @override
  String get uCt4t3iY8hL5sF5pV6qW2xRg => 'UCt4t3iY8hL5sF5pV6qW2xRg';

  @override
  String get uCp8q9rL2jG5hV7xW3mR5bNQ => 'UCp8q9rL2jG5hV7xW3mR5bNQ';

  @override
  String get uCvZ9W7u3T6a5YJS0VT28oA => 'UCvZ9W7u3T6a5YJS0VT-28oA';

  @override
  String get uCm7yM8rL5jG5pV6qW3xR2bQ => 'UCm7yM8rL5jG5pV6qW3xR2bQ';

  @override
  String get uCJ10R97LkwGdTqBT6xzV8g => 'UCJ10R97LkwGdTqBT6xz-v8g';

  @override
  String get learnMandarinWithTaiwanPlus =>
      'Belajar Mandarin dengan TaiwanPlus';

  @override
  String get everydayChinese => 'Bahasa Mandarin Sehari-hari';

  @override
  String get uCCFdR7zZ5SUXuOrEdKw => 'UCC_fdR7zZ_5SU--xuOrEdKw';

  @override
  String get tingDailyLifeInChina => 'Ting - Kehidupan Sehari-hari di Tiongkok';

  @override
  String get tFTFOODTRAVEL => 'TFT - KULINER & WISATA';

  @override
  String get uCsHMiBJ9r87fRH7VAWZw => 'UCs_h_miBJ9r8-7fRH7VAWZw';

  @override
  String get liziqi3 => '李子柒 Liziqi: Kehidupan Bawang Putih';

  @override
  String get label2MINCULTURALCONTEXT => 'KONTEKS BUDAYA 2 MENIT';

  @override
  String get liziqi4 => '李子柒 Liziqi: Perabot Bambu';

  @override
  String get peppaPigChinese2 => 'Peppa Pig Mandarin: Genangan Lumpur';

  @override
  String get noBBCLeadArticleIs =>
      'Saat ini tidak ada artikel utama BBC yang tersedia.';

  @override
  String get mediaThumbnail => 'media:thumbnail';

  @override
  String get bBC => 'BBC 中文';

  @override
  String get siJin2 => '似锦 Si Jin';

  @override
  String get n9Yh6jSqjg => 'n9Yh-6jSqjg';

  @override
  String get eV4j0RDXDVU => 'EV4j0RDXDVU';

  @override
  String get eY3hnHAmSg => 'e-Y3hnHAmSg';

  @override
  String get cD0Q81FnaY => 'CD0Q81-fnaY';

  @override
  String get label0UEwtWyW5s => '0UEwtWy-W5s';

  @override
  String get label8PNkm5Mxxk => '8PNkm5-Mxxk';

  @override
  String get iWNYkjEle8 => 'IWNYkj-ele8';

  @override
  String get rGrzq5WtBE => 'r-grzq5WtBE';

  @override
  String get tBo7q3wafw => 't-bo7q3wafw';

  @override
  String get iJkbO5H6E => 'I_jkbO5-h6E';

  @override
  String get oMM5UD0T2w => 'OMM5_UD0T2w';

  @override
  String get sIXSISTERS2 => '六姊妹 SIX SISTERS';

  @override
  String get cNylns5HiA => 'c-nylns5HiA';

  @override
  String get mEUH5U8EZa4 => 'MEUH5U8EZa4';

  @override
  String get label3Wx8JnjWZc => '3Wx8JnjW-Zc';

  @override
  String get qj17RJVE5B0 => 'Qj17RJVE5B0';

  @override
  String get vO4nggZ6Grs => 'VO4nggZ6Grs';

  @override
  String get zNR4WLEcJ4 => 'Z-NR4WLEcJ4';

  @override
  String get mA08u68O7Q => 'MA08u68O7_Q';

  @override
  String get ig8tnI0c9xM => 'Ig8tnI0c9xM';

  @override
  String get gIBYzq4lFtw => 'GIBYzq4lFtw';

  @override
  String get qDOf4OCZgd0 => 'QDOf4OCZgd0';

  @override
  String get shineOnMe => '骄阳似我 Shine on Me';

  @override
  String get zx7pUK2J1Uc => 'Zx7pUK2J1Uc';

  @override
  String get zdgymrBo9Y => 'zdgymr-bo9Y';

  @override
  String get label7yMAZEUBs => '7yMAZ_e-uBs';

  @override
  String get l9AqUHU14 => '_l9AqU-hU14';

  @override
  String get label1elnMxr0A0 => '1elnMxr0-A0';

  @override
  String get ozsUxgd7sk => 'OzsUxgd-7sk';

  @override
  String get label4czDUfmwv8 => '4cz-dUfmwv8';

  @override
  String get iuiTM37MII => 'iuiTM37M-II';

  @override
  String get xgXf9j96yM => 'XgXf-9j96yM';

  @override
  String get thoseDays => '四喜 Hari-hari Itu';

  @override
  String get a5nhDbkkCU => 'a5nhDbkkC-U';

  @override
  String get jb8unABN00 => '-jb8unABN00';

  @override
  String get label78OX9HXqKA => '78OX-9HXqKA';

  @override
  String get oDw77ocPGXg => 'ODw77ocPGXg';

  @override
  String get tt28uayZ7U => '-tt28uayZ7U';

  @override
  String get sOl3U7rPEPc => 'SOl3U7rPEPc';

  @override
  String get sffGZZpJ48 => 'sffGZZp-j48';

  @override
  String get v2UNvBajdY => 'v2UNv-BajdY';

  @override
  String get noFunnyNoMoney => 'Tidak Lucu Tidur di Jalan - No Funny No Money';

  @override
  String get dob3yGGLHIg => 'Dob3yGGLHIg';

  @override
  String get q5vqCQ6P9Pk => 'Q5vqCQ6P9Pk';

  @override
  String get label9Nc40rZ3b8 => '-9Nc40rZ3b8';

  @override
  String get d3zEt3pV8 => '_D3z-Et3pV8';

  @override
  String get label5S3yHQ10 => '5_S3yHQ--10';

  @override
  String get jQbyRRCa5U => 'JQbyR-rCa5U';

  @override
  String get x5WFTXq2FW0 => 'X5WFTXq2FW0';

  @override
  String get getTheWeTVAPP2 => 'Tencent Video - Anime - Dapatkan Aplikasi WeTV';

  @override
  String get y4TWL0m2i4c => 'Y4TWL0m2i4c';

  @override
  String get uVZdKZcAXU => 'UV-ZdKZcAXU';

  @override
  String get mR8VUhHc => '-__MR8VUhHc';

  @override
  String get jrTInzf1Kc => 'Jr_tInzf1Kc';

  @override
  String get xfjz857p3w => 'Xfjz_857p3w';

  @override
  String get mI1Wl3V5WBE => 'MI1Wl3V5WBE';

  @override
  String get lordOfMysteriesVlog =>
      '《诡秘之主》Lord of Mysteries Vlog Sulih Suara Cuttlefish Versi Final Tencent Video - Anime';

  @override
  String get lordOfMysteries =>
      '《诡秘之主》Lord of Mysteries Kelas Okultisme Episode 8 Tencent Video - Anime';

  @override
  String get lordOfMysteries2 =>
      '《诡秘之主》Lord of Mysteries Kelas Okultisme Episode 7 Tencent Video - Anime';

  @override
  String get lordOfMysteries3 =>
      '《诡秘之主》Lord of Mysteries Kelas Okultisme Episode 6 Tencent Video - Anime';

  @override
  String get lordOfMysteries4 =>
      '《诡秘之主》Lord of Mysteries Kelas Okultisme Episode 5 Tencent Video - Anime';

  @override
  String get lordOfMysteries5 =>
      '《诡秘之主》Lord of Mysteries Kelas Okultisme Episode 4 Tencent Video - Anime';

  @override
  String get lordOfMysteries6 =>
      '《诡秘之主》Lord of Mysteries Kelas Okultisme Episode 3 Tencent Video - Anime';

  @override
  String get pakhctn6g6A => 'Pakhctn6g6A';

  @override
  String get lordOfMysteries7 =>
      '《诡秘之主》Lord of Mysteries Kelas Okultisme Episode 2 Tencent Video - Anime';

  @override
  String get lordOfMysteries8 =>
      '《诡秘之主》Lord of Mysteries Kelas Okultisme Episode 1 Tencent Video - Anime';

  @override
  String get g5fLWO98axs => 'G5fLWO98axs';

  @override
  String get gK0eOTF2s4c => 'GK0eOTF2s4c';

  @override
  String get oSTLordOfMysteries =>
      '【OST】《诡秘之主》Lord of Mysteries Lagu Penutup \'Forget Me Not\' Tencent Video - Anime';

  @override
  String get membersPremiere2 => 'Premiere Anggota';

  @override
  String get dOtFXu1Vw => '_dOt-fXu1Vw';

  @override
  String get eA13aHY8jw => 'EA13aH_Y8jw';

  @override
  String get jVfwogmt8JM => 'JVfwogmt8JM';

  @override
  String get sfj9727Xu4 => 'Sfj9727-Xu4';

  @override
  String get tnv6Me0FI4s => 'Tnv6Me0FI4s';

  @override
  String get wEY80ZpZ8 => 'wEY80-_ZpZ8';

  @override
  String get pNRv9ncKDq4 => 'PNRv9ncKDq4';

  @override
  String get yZI6rr4wR1I => 'YZI6rr4wR1I';

  @override
  String get bDzKpcxWto => 'B-DzKpcxWto';

  @override
  String get dy9QDPpZBk => 'dy9QDPpZ-bk';

  @override
  String get tZ53akmpvyc => 'TZ53akmpvyc';

  @override
  String get label4Ip1rJO4gE => '4-Ip1rJO4gE';

  @override
  String get label5VKww8pjFA => '5-vKww8pjFA';

  @override
  String get label60SpwYfgUU => '60Spw-yfgUU';

  @override
  String get v8AG9HnmFA => 'V8AG9_hnmFA';

  @override
  String get vY6ao4ktdo => '-vY6ao4ktdo';

  @override
  String get htxVeakvE => '-htx-veakvE';

  @override
  String get fO7muIAr9dA => 'FO7muIAr9dA';

  @override
  String get s4O9Nk3Q4 => 'S4_O9Nk-3Q4';

  @override
  String get lMDHc55prI => 'LM_dHc55prI';

  @override
  String get lGpl7G7850 => '-LGpl7G7850';

  @override
  String get xJ2dwZ2xCw0 => 'XJ2dwZ2xCw0';

  @override
  String get qo47iejJOQ => 'Qo_47iejJOQ';

  @override
  String get gbnoj9WUP5Y => 'Gbnoj9WUP5Y';

  @override
  String get qCHKUuwF0 => 'QCHKUuw_f_0';

  @override
  String get qyh4kU263OA => 'Qyh4kU263OA';

  @override
  String get vnTQZY6QM => 'Vn-TQZ_Y6QM';

  @override
  String get vwk9yx7WL0c => 'Vwk9yx7WL0c';

  @override
  String get uLa6Qw2aL0 => 'u-La6Qw2aL0';

  @override
  String get kQJ5gjZwU0 => 'k-QJ5gjZwU0';

  @override
  String get mQH5jhyqPHc => 'MQH5jhyqPHc';

  @override
  String get h6rjzyquxA => 'h6rjzyqux-A';

  @override
  String get pLMX26aiIvX5phl8n87NqTbaeXK2HHm =>
      'PLMX26aiIvX5phl8n8-7-nqTbaeXK2HHm-';

  @override
  String get eightHundred => '方圆八百米 Eight Hundred';

  @override
  String get l1Xmsbo6RE => 'L1Xmsbo6_rE';

  @override
  String get dq1IgosbLQ => 'Dq1Igosb_lQ';

  @override
  String get i8e9E1bZR7I => 'I8e9E1bZR7I';

  @override
  String get iqRK2KUN0I => 'IqRK2KUN-0I';

  @override
  String get c3wWSQPFc0 => 'C3w-WSQPFc0';

  @override
  String get loveBeyondTheGrave => '白日提灯 Love Beyond the Grave';

  @override
  String get rPWA2OHxlaw => 'RPWA2OHxlaw';

  @override
  String get label8NShMGCGZk => '8NShMG-cGZk';

  @override
  String get q2TPc3EOYl4 => 'Q2TPc3EOYl4';

  @override
  String get pmPPM7YT5M => 'PmPP-M7YT5M';

  @override
  String get azFL5ujNQ0 => '-AzFL5ujNQ0';

  @override
  String get kpD2a0Z9yE => 'kpD-2a0Z9yE';

  @override
  String get dMAm1i8Ylb8 => 'DMAm1i8Ylb8';

  @override
  String get ppk0MGKF8Y => 'Ppk_0MGKF8Y';

  @override
  String get label1ZEKWcipU => '1_zEK-WcipU';

  @override
  String get dcOLJI4L5A => 'dcO-LJI4L5A';

  @override
  String get loveBeyondTheGrave2 =>
      '片场彩蛋：贺思慕段胥本名难觅花名纷至【白日提灯 Love Beyond the Grave】';

  @override
  String get label5MVET41ATY => '5MVET41A-tY';

  @override
  String get bTSLoveBeyondTheGrave =>
      'BTS｜【鹅剧派对】迪丽热巴陈飞宇携众主创默契五感五连拍！【白日提灯 Love Beyond the Grave】';

  @override
  String get bTSLoveBeyondTheGrave2 =>
      'BTS｜【鹅剧派对】迪丽热巴陈飞宇亮相，眼神杀直接封神！【白日提灯 Love Beyond the Grave】';

  @override
  String get herBlaze => 'Her Blaze';

  @override
  String get opOIDzw8Vo => 'Op_OIDzw8Vo';

  @override
  String get rv9nnIn4wxQ => 'Rv9nnIn4wxQ';

  @override
  String get c5e9V1GRnn8 => 'C5e9V1GRnn8';

  @override
  String get xAjvi1fmrrQ => 'XAjvi1fmrrQ';

  @override
  String get yIkxweh5A0 => 'yIkxweh5-A0';

  @override
  String get label9CM48di86g => '9-CM48di86g';

  @override
  String get dAwbSEDikg => 'D-AwbSEDikg';

  @override
  String get ecXCXc5EUg => 'Ec_xCXc5EUg';

  @override
  String get lKBf8Y0Qfqg => 'LKBf8Y0Qfqg';

  @override
  String get qnc5caQJITA => 'Qnc5caQJITA';

  @override
  String get xmLEreDeoU => 'xmLEreDeo-U';

  @override
  String get aboutLove => '玫瑰丛生 Tentang Cinta';

  @override
  String get i4cZFlj8Fw => 'I4cZ-Flj8Fw';

  @override
  String get v8m00Hcam0 => 'V8m0-0Hcam0';

  @override
  String get aVPsfT4c4 => 'a-_vPsfT4c4';

  @override
  String get cJ9KNnY2cc => 'CJ9K-NnY2cc';

  @override
  String get j078HAJbI => 'J-078H-aJbI';

  @override
  String get byLJulMrNs => 'by-lJulMrNs';

  @override
  String get hj663skfypU => 'Hj663skfypU';

  @override
  String get lVOj0dkxDQ => 'LVOj0dkx-DQ';

  @override
  String get hKCVYT0J0 => 'hK-CVYT0J_0';

  @override
  String get v9czXRh5oUc => 'V9czXRh5oUc';

  @override
  String get af4fVhhPVg => 'af4fVhhP-Vg';

  @override
  String get tA =>
      'Semua pemeran \"About Love\" terjebak dalam kabut cinta, bagaimana mereka memecahkan kebuntuan? | Dibintangi: Wang Ziwen, Liu Yuning';

  @override
  String get pLMX26aiIvX5rSLe74r7sARps4oOqaBWD =>
      'PLMX26aiIvX5rSLe74r7sA-Rps4oOqaBWD';

  @override
  String get generationToGeneration2 => '江湖夜雨十年灯 Dari Generasi ke Generasi';

  @override
  String get wCfp3YN9mPs => 'WCfp3YN9mPs';

  @override
  String get label0Sus6s0HWM => '0Sus6s0-hWM';

  @override
  String get zjcGjE54zU => 'Zjc-GjE54zU';

  @override
  String get g1q8I4lZ5mU => 'G1q8I4lZ5mU';

  @override
  String get y2IWPq6jFCE => 'Y2IWPq6jFCE';

  @override
  String get wz9oy74X8 => 'Wz9oy_74_x8';

  @override
  String get ztz3CXfrQE => '-ztz3CXfrQE';

  @override
  String get loveStoryInThe1970s => 'Kisah Cinta di Tahun 1970-an';

  @override
  String get eGYAJh8Z8Pc => 'EGYAJh8Z8Pc';

  @override
  String get aBXZma9Mqc => 'A-bXZma9Mqc';

  @override
  String get wSHZC7Yb5s => 'WSHZC_7Yb5s';

  @override
  String get aK8Fl3m9W7I => 'AK8Fl3m9W7I';

  @override
  String get label0jw5TGzM0s => '0jw5T-gzM0s';

  @override
  String get xIbV4LmjNk => 'XIbV4-lmjNk';

  @override
  String get hkpSEzLKLg => 'HkpSEzLK-Lg';

  @override
  String get pLMX26aiIvX5q5kRTszb0kZqKc2TJWnf =>
      'PLMX26aiIvX5q5kR_Tszb0kZqKc2T-JWnf';

  @override
  String get whyIsHeStillSingle => 'Mengapa Dia Masih Lajang';

  @override
  String get okB86OjCI => 'okB_86OjC-I';

  @override
  String get m8eZwl6rA4 => 'm8eZwl6rA-4';

  @override
  String get label3ub1XXXYI => '3ub-1-xXXYI';

  @override
  String get label4dW228WSVk => '4dW228-wSVk';

  @override
  String get wCAK3UFi5M => 'WCAK3_uFi5M';

  @override
  String get eZzak3C73nI => 'EZzak3C73nI';

  @override
  String get theGlamorousNight => 'Malam yang Gemerlap';

  @override
  String get theGlamorousNightE03 =>
      '【Malam yang Gemerlap】E03 Langkah Hebat! Serangan Balik Zhao Mei (Jiang Shuying, Tong Dawei)';

  @override
  String get zaalDLrc => '--Zaal-DLrc';

  @override
  String get label26Lkp84WD0 => '2-6Lkp84WD0';

  @override
  String get jD9iPkDDqC => 'jD9iPkDDq-c';

  @override
  String get jIyk18uXB7Q => 'JIyk18uXB7Q';

  @override
  String get h3XEsv0mgA => 'h3-xEsv0mgA';

  @override
  String get vClRnlEUTQ => 'VClRnlEUT-Q';

  @override
  String get myPageInThe90s => '突然的喜欢 My Page in the 90s';

  @override
  String get m7XBiuw1TU => 'm7XBiuw1-tU';

  @override
  String get a25pD4FCQio => 'A25pD4FCQio';

  @override
  String get muCj0GdNdw => 'muCj-0GdNdw';

  @override
  String get aQ4hlmkOv3A => 'AQ4hlmkOv3A';

  @override
  String get nEiRnIHDg => 'NEiRn_IH-Dg';

  @override
  String get label04MyPageInThe =>
      'Klip 04: Sistem konyol paksakan drama! Tisu jadi pembalut? Jadi canggung banget! 【突然的喜欢 My Page in the 90s】';

  @override
  String get label03MyPageInThe =>
      'Klip 03: Gantikan sahabat kencan buta, malah ketemu pemeran utama pria asli? 【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSXXMyPage =>
      'BTS | 「Di Luar Peran X Chen Xingxu X Wang Yuwen」 Siapa yang lebih kocak antara Pak Gao dan Huan\'er? 【突然的喜欢 My Page in the 90s】';

  @override
  String get label02MyPageInThe =>
      'Klip 02: Niat mendekati pemeran utama pria, malah salah orang? 【突然的喜欢 My Page in the 90s】';

  @override
  String get label01MyPageInThe =>
      'Klip 01: Konyol! Tiba-tiba masuk ke dalam novel? Gimana cara merankan cerita ini? 【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSMyPageInThe =>
      'BTS | Chen Xingxu dan Wang Yuwen saling tabrak mesra saat bermain sepatu roda 【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSMyPageInThe2 =>
      'BTS | Chen Xingxu dan Wang Yuwen rayakan tahun baru dengan manis 【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSMyPageInThe3 =>
      'BTS | Chen Xingxu dan Wang Yuwen abadikan momen manis Festival Qixi 【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSMyPageInThe4 =>
      'BTS | Keseruan Chen Xingxu dan Wang Yuwen di taman bermain 【突然的喜欢 My Page in the 90s】';

  @override
  String get myPageInThe90s2 =>
      '《突然的喜欢 My Page in the 90s》 Tayang hari ini, Chen Xingxu dan Wang Yuwen nikmati kisah cinta manis lewat sistem';

  @override
  String get myPageInThe90s3 =>
      '《突然的喜欢 My Page in the 90s》 Tayang manis 22 Januari, asmara unik Chen Xingxu dan Wang Yuwen';

  @override
  String get myPageInThe90s4 =>
      '《突然的喜欢 My Page in the 90s》 Dikonfirmasi tayang 22 Januari! Cinta lintas era Chen Xingxu dan Wang Yuwen';

  @override
  String get pLMX26aiIvX5qxr2ZxGgBQKRNVGydd =>
      'PLMX26aiIvX5qxr2ZxGgBQKR-n-V_Gydd-';

  @override
  String get uDFuWJvE1M => 'uDFuWJv-e1M';

  @override
  String get bNKH0V8G => 'bN-kH-0V8-g';

  @override
  String get l4tkACioRc => 'L4tkACio-Rc';

  @override
  String get label2TheImperialCoronerS2 => '御赐小仵作2 The Imperial Coroner S2';

  @override
  String get hNa1FW55Q5s => 'HNa1FW55Q5s';

  @override
  String get yyn06Ql7ADg => 'Yyn06Ql7ADg';

  @override
  String get h0LBmMzQBc => 'h0LBmMz-qBc';

  @override
  String get label25FI49I6Sk => '25FI49I6-Sk';

  @override
  String get aAY7eaH3jw => 'aAY7ea-H3jw';

  @override
  String get ukcZXSZhOc => 'UkcZX-SZhOc';

  @override
  String get pLMX26aiIvX5o7sdz290MeDHgSqCHsIS =>
      'PLMX26aiIvX5o7sdz290MeD-HgSqCHsI_s';

  @override
  String get theDreamMaker => 'Pembuat Mimpi The Dream Maker';

  @override
  String get fLcyGh4lXM => 'FLcy_gh4lXM';

  @override
  String get zvaRoKDtG0 => 'ZvaRoKDtG-0';

  @override
  String get x1CkUlPzUc => 'x1CkUl-pzUc';

  @override
  String get axn5uV9sXSw => 'Axn5uV9sXSw';

  @override
  String get hj11XBTF4hQ => 'Hj11XBTF4hQ';

  @override
  String get kzB7eE7CFc => 'Kz_B7eE7CFc';

  @override
  String get m5bbHdJrE => '-m5bb_HdJrE';

  @override
  String get vl9SPb3Hs => 'Vl9_s-Pb3Hs';

  @override
  String get y1y6xz0xM2I => 'Y1y6xz0xM2I';

  @override
  String get label8HxijD19OI => '8HxijD19O-I';

  @override
  String get nj33Wy40VXU => 'Nj33Wy40VXU';

  @override
  String get eDGFBue80s => 'EDGF_Bue80s';

  @override
  String get label19zBynsjTk => '19z-BynsjTk';

  @override
  String get oJmIfnNd8s => 'oJmIfnNd-8s';

  @override
  String get yVp1Ms3ZE8 => 'YVp1_Ms3ZE8';

  @override
  String get foreverYoungE23 =>
      '【轻年 Forever Young】E23 Martin kembali ke hutong dan dikendalikan oleh saudara-saudaranya (Wallace Huo, Tian Yu, Zhang Xueying, Qiao Zhenyu)';

  @override
  String get foreverYoungE25 =>
      '【轻年 Forever Young】E25 Tepat, mantap, dan tegas! Martin mengajari ipar perempuan cara mengendalikan suaminya (Wallace Huo, Tian Yu, Zhang Xueying, Qiao Zhenyu)';

  @override
  String get foreverYoungE24 =>
      '【轻年 Forever Young】E24 Ada saingan cinta? Martin dipanggil paman oleh anak muda (Wallace Huo, Tian Yu, Zhang Xueying, Qiao Zhenyu)';

  @override
  String get fEYoHxyxzQ => 'FEYo_hxyxzQ';

  @override
  String get zF8OR9onddY => 'ZF8OR9onddY';

  @override
  String get b1FJGDAKV8 => 'B1FJ-GDAKV8';

  @override
  String get pLL3q9saUp1GZjNkX3Zxfr4y8rZhaZ0jV =>
      'PLL3q9saUp1GZj-nkX3Zxfr4y8rZhaZ0jV';

  @override
  String get hOMELANDGUARDIAN => '守诚者|HOMELAND GUARDIAN🚔';

  @override
  String get iQIYIGetTheIQIYIAPP => 'iQIYI 悬疑社 - Dapatkan Aplikasi iQIYI';

  @override
  String get label8QBlaWEtbw => '8Q-blaWEtbw';

  @override
  String get label0XrMBoHTsY => '0XrMBoH-TsY';

  @override
  String get zBzbg0Nu84 => 'zBzbg0-Nu84';

  @override
  String get label7ItX7Vt8Qc => '7ItX7Vt8-qc';

  @override
  String get zx5XvNKhXo => 'zx5Xv-NKhXo';

  @override
  String get nigVK5Ing => '-Nig_vK5Ing';

  @override
  String get loveHasFireworks => '爱情有烟火 Love Has Fireworks';

  @override
  String get getTheWeTVAPP3 => '腾讯视频 - 青春剧场 - Dapatkan Aplikasi WeTV';

  @override
  String get oMOcpoXhYw => 'OMOcpoXh-yw';

  @override
  String get xwTcCP8TsU => 'XwTc-CP8TsU';

  @override
  String get t4dBHQH9F0I => 'T4dBHQH9F0I';

  @override
  String get jZP3R3khZMk => 'JZP3R3khZMk';

  @override
  String get cLBYyAU0AU => '-CLBYyAU0AU';

  @override
  String get x1F7qp1cZo => 'X-1F7qp1cZo';

  @override
  String get jJ5X6yEpiI => 'J-j5X6yEpiI';

  @override
  String get label8JmxrnwT0 => '8-jmxrnwT-0';

  @override
  String get gWvOJODRXU => 'gWvOJO-dRXU';

  @override
  String get t1VyWJTB2A => 't1VyWJT-b2A';

  @override
  String get e00xfXWql4Q => 'E00xfXWql4Q';

  @override
  String get theHiddenHeirYeChen2 => 'Ye Chen: Sang Pewaris Tersembunyi';

  @override
  String get xtTr8ZBDpG => 'XtTr8ZBDp-g';

  @override
  String get dresmsNeverEnd =>
      'Dengarkan Angin Padang Luas - Mimpi Tak Pernah Usai';

  @override
  String get mamaGo => 'Ibuku Bunga Sekolah - Mama Go!';

  @override
  String get o4rwrV9yv0 => 'O4rwr_v9yv0';

  @override
  String get x5Cm37j3g0 => 'X5Cm37j_3g0';

  @override
  String get jTqQ3t6gg => '_jTqQ3t-6gg';

  @override
  String get cNIRYF7Ig4 => 'cNIR-yF7Ig4';

  @override
  String get hr2GfDJNGg => 'Hr2GfD-JNGg';

  @override
  String get yXXjFZcZw => 'Y-X-xjFZcZw';

  @override
  String get xrBNQazEsk => 'xrBN-qazEsk';

  @override
  String get fJDN8r3rcRw => 'FJDN8r3rcRw';

  @override
  String get jEXB1NMkHs => 'JEXB1N-MkHs';

  @override
  String get d3dl69d81pQ => 'D3dl69d81pQ';

  @override
  String get xGZPKLBH8Q => 'XGZPK-LBH8Q';

  @override
  String get x59A8sSoGs => 'x59A8s-SoGs';

  @override
  String get lo6iApMzI => '_lo6iAp-mzI';

  @override
  String get d4a9aQ7h18 => 'D4a9aQ7h1_8';

  @override
  String get zCt0on2nA9s => 'ZCt0on2nA9s';

  @override
  String get b6BykN3fT4 => 'b6BykN3f-t4';

  @override
  String get eMZrxHTajM => 'EM-zrxHTajM';

  @override
  String get t1RJnvl2RA => 'T1RJnvl2R_A';

  @override
  String get hOE347NBAc => 'hOE-347NBAc';

  @override
  String get loveStoryInThe1970s2 =>
      'Film pendek kronik ganda 《Love Story in the 1970s》 telah hadir dengan hangat~';

  @override
  String get loveStoryInThe1970s3 =>
      'Film pendek duet 《Love Story in the 1970s》 resmi dirilis~ Mari tulis surat cinta dengan indra kita';

  @override
  String get bTSLoveStoryInThe =>
      'BTS | Syuting rampung, menantikan pertemuan berikutnya 【Love Story in the 1970s】';

  @override
  String get loveStoryInThe1970s4 =>
      '《Love Story in the 1970s》Cinta adalah puisi yang tersembunyi dalam kehangatan hidup~';

  @override
  String get sGX3zNIuzM => 'SGX-3zNIuzM';

  @override
  String get loveStoryInThe1970s5 =>
      '《Love Story in the 1970s》Resmi dijadwalkan tayang 21 Februari~';

  @override
  String get dEZKlJqTo => 'DE_ZKl_jqTo';

  @override
  String get sc8aQLBntwk => 'Sc8aQLBntwk';

  @override
  String get aDa3c9hGZA => 'ADa_3c9hGZA';

  @override
  String get yj9xkfkxmpQ => 'Yj9xkfkxmpQ';

  @override
  String get idjCqdRyYG => 'idjCqdRyY-g';

  @override
  String get sqwEl8o75U => 'Sqw-El8o75U';

  @override
  String get wbF6Wgzai4 => 'WbF-6Wgzai4';

  @override
  String get pLyX50Z72L2xpkH5SEO0XjQxJPO1sC =>
      'PLyX_50Z72L2xpk_h5SEO0Xj_qx-jPO1sC';

  @override
  String get theTruth => 'Jejak Angin: The Truth';

  @override
  String get q4im6PPfcw => 'Q4im6P_Pfcw';

  @override
  String get tsyfcT6RG8 => 'Tsyfc-t6RG8';

  @override
  String get pHOAi3EJ6Cg => 'PHOAi3EJ6Cg';

  @override
  String get l2EHE50Bhlw => 'L2EHE50Bhlw';

  @override
  String get pVgnsUnNXw => 'PVgnsUnN-Xw';

  @override
  String get pLyX50Z72L2wsEVLZsclrIke3z7FY8n =>
      'PLyX_50Z72L2wsEVL-zsclrIke3z7F-Y8n';

  @override
  String get ugNrNd0OM8 => 'Ug_nrNd0OM8';

  @override
  String get b4hADbXtGo => 'b4hADb-xtGo';

  @override
  String get rQXFQTj6XY => 'RQ_XFQTj6XY';

  @override
  String get a6TSVxp9x0 => 'A6TS_Vxp9x0';

  @override
  String get gwt9Y2ESIOA => 'Gwt9Y2ESIOA';

  @override
  String get c2tVD8rhVMM => 'C2tVD8rhVMM';

  @override
  String get pLyX50Z72L2wshCDZ4cWBwWHjigU7av =>
      'PLyX_50Z72L2wshCDZ4cW-BwWHjigU7av-';

  @override
  String get tW5f69bxL0 => 'TW_5f69bxL0';

  @override
  String get l8T7Lz5VN44 => 'L8T7Lz5VN44';

  @override
  String get cVLZ3AmkTE => '-cVLZ3AmkTE';

  @override
  String get t4E2lf096yM => 'T4E2lf096yM';

  @override
  String get wHENTJCl9M => 'WHENTJCl9-M';

  @override
  String get bTSOutOfCharacterDuo =>
      'BTS｜\"Wawancara Duo Luar Karakter\" Ekstra—Siapa yang Lebih Nyeleneh Antara Pak Gao dan Huan\'er? 《My Page in the 90s》 Tencent Video - Teater Pemuda';

  @override
  String get rEk9xALNODE => 'REk9xALNODE';

  @override
  String get label04MyPageInThe2 =>
      'Klip Menarik 04 Sistem konyol paksakan adegan! Tisu jadi pembalut? Malu banget! 《My Page in the 90s》 Tencent Video - Teater Pemuda';

  @override
  String get label03MyPageInThe2 =>
      'Klip Menarik 03 Gantikan sahabat kencan buta, malah ketemu pemeran utama pria? 《My Page in the 90s》 Tencent Video - Teater Pemuda';

  @override
  String get xsb7BJppy0 => 'Xsb7B-Jppy0';

  @override
  String get label02MyPageInThe2 =>
      'Klip Menarik 02 Maksud hati mendekati pemeran utama pria, tapi malah salah orang? 《My Page in the 90s》 Tencent Video - Teater Pemuda';

  @override
  String get label01MyPageInThe2 =>
      'Klip Menarik 01 Konyol! Tiba-tiba masuk ke dalam buku? Bagaimana cara meragakan alur cerita ini? 《My Page in the 90s》 Tencent Video - Teater Pemuda';

  @override
  String get zSpXoH9ok => 'Z_SpXo-H9ok';

  @override
  String get myPageInThe90s5 =>
      '《My Page in the 90s》BTS｜Chen Xingxu dan Wang Yuwen Tabrakan Saat Main Sepatu Roda';

  @override
  String get myPageInThe90s6 =>
      '《My Page in the 90s》Tayang Hari Ini! Chen Xingxu & Wang Yuwen Nikmati Cinta Manis Lewat Sistem';

  @override
  String get bTSMyPageInThe5 =>
      'BTS｜Interaksi Konyol Chen Xingxu dan Wang Yuwen, Keintiman Melampaui Batas 【My Page in the 90s】';

  @override
  String get aYyrt0eGYw => 'AYyrt0e-gYw';

  @override
  String get qM5S5tiCI0 => 'QM_5S5tiCI0';

  @override
  String get w1mYTU1AGkg => 'W1mYTU1AGkg';

  @override
  String get pLyX50Z72L2zuddUfGdIXCxO1jAzTlPd =>
      'PLyX_50Z72L2zudd-ufGdIXCxO1jAzTlPd';

  @override
  String get jWEK0M59Ysk => 'JWEK0M59Ysk';

  @override
  String get p6l7C0ovRFM => 'P6l7C0ovRFM';

  @override
  String get vRYp5JmLwc => '-vRYp5JmLwc';

  @override
  String get dearSecretary => 'Sekretarisku Sayang Dear Secretary';

  @override
  String get pAoESWUjrI => 'PAoES-wUjrI';

  @override
  String get pLyX50Z72L2yOG39wBXIFJlA2GtbWheA =>
      'PLyX_50Z72L2yOG39wBXIFJlA-2GtbWheA';

  @override
  String get label0JQ43Tt8D4 => '0J-q43Tt8D4';

  @override
  String get lIJJXYywPM => 'LIJ-jXYywPM';

  @override
  String get xLc3qBC5k => 'XLc3qB_c-5k';

  @override
  String get mKLZpubV04 => 'MKL_zpubV04';

  @override
  String get wXevXICxAQ => 'wXevXICx-AQ';

  @override
  String get xRRUT4fbgQ => 'xRR-uT4fbgQ';

  @override
  String get q5WMmVzsGQ => 'q5-wMmVzsGQ';

  @override
  String get dOFDys0lAJ0 => 'DOFDys0lAJ0';

  @override
  String get wadaICY1qo => 'WadaIC-Y1qo';

  @override
  String get label44PA4p4dXY => '44P-a4p4dXY';

  @override
  String get pLyX50Z72L2xbAikt1CHmEyvZrQv1XJu =>
      'PLyX_50Z72L2xbAikt1CHmEyvZrQv1X-ju';

  @override
  String get foreverYoung2 => '轻年 Muda Selamanya';

  @override
  String get omVSnG9O8g => 'omVSn-G9O8g';

  @override
  String get label2qKWcz2zU0 => '2qKWcz2z-u0';

  @override
  String get label1WMYcdS8oE => '1WMYcdS8o-E';

  @override
  String get u0fCO4W9LHg => 'U0fCO4W9LHg';

  @override
  String get m9xLRZlwO => 'M9xL-rZlw-o';

  @override
  String get vo5jCUWPNAo => 'Vo5jCUWPNAo';

  @override
  String get vb1N5r3zZFo => 'Vb1N5r3zZFo';

  @override
  String get lightOfDawn => '人之初 Cahaya Fajar';

  @override
  String get teDx70IJcw => 'Te_dx70IJcw';

  @override
  String get mF2299T610 => 'mF2299T-610';

  @override
  String get yLNGIsWlU => 'YL_-NGIsWlU';

  @override
  String get mUZMDrFnNw => 'MUZMDrFn-Nw';

  @override
  String get pi2b8VYkM8 => 'Pi2b8VYk-m8';

  @override
  String get pLyX50Z72L2xDQ9d02geVDYSbkol6u9Z =>
      'PLyX_50Z72L2xDQ9d02geVDYSbkol-6u9Z';

  @override
  String get wWy3IO1E9cw => 'WWy3IO1E9cw';

  @override
  String get wW9DI00Rx3w => 'WW9DI00Rx3w';

  @override
  String get a6Y3wzD0I => 'A_6Y3wzD-0I';

  @override
  String get wXEkwsviSA => '-WXEkwsviSA';

  @override
  String get uq15J34lYB0 => 'Uq15J34lYB0';

  @override
  String get sc7Fg23kmUM => 'Sc7Fg23kmUM';

  @override
  String get kaJ2rw9Aqk => 'ka-j2rw9Aqk';

  @override
  String get uLnBQ3TFuc => 'ULnBQ3-TFuc';

  @override
  String get t2Iwb6RA1A => 'T2Iwb6-RA1A';

  @override
  String get mug6zYTLTlc => 'Mug6zYTLTlc';

  @override
  String get n2FDS8D8uu4 => 'N2FDS8D8uu4';

  @override
  String get s8lCa09LCr8 => 'S8lCa09LCr8';

  @override
  String get cU6u6WUM => 'C-u6u_6-WUM';

  @override
  String get oNNJqZYydM => 'ONN-JqZYydM';

  @override
  String get sniperButterfly => 'Kupu-Kupu Penembak Jitu Sniper Butterfly';

  @override
  String get zExesh1IRe4 => 'ZExesh1IRe4';

  @override
  String get ygyiJvBu0 => 'ygyi-JvBu-0';

  @override
  String get label8lAlJTtlQw => '8lAlJ-ttlQw';

  @override
  String get oi4cSib0SMU => 'Oi4cSib0SMU';

  @override
  String get gBZIZ1syhRw => 'GBZIZ1syhRw';

  @override
  String get yOIsab02PVs => 'YOIsab02PVs';

  @override
  String get y3OhRM7dJg => 'Y3Oh_RM7dJg';

  @override
  String get bqvORbC4cY => 'BqvORbC4c-Y';

  @override
  String get iE8MjgoaPY => 'IE8Mjgoa-pY';

  @override
  String get sniperButterfly1204 =>
      '《狙击蝴蝶 Sniper Butterfly》 Tayang 04/12! Demi Cinta Melintasi Batas';

  @override
  String get sniperButterflyFullVersion1 =>
      '《狙击蝴蝶 Sniper Butterfly》 Versi Penuh 1-15｜Pemeran Utama: Chen Yanxi, Zhou Keyu Tencent Video-Youth Theater';

  @override
  String get sniperButterflyFullVersion16 =>
      '《狙击蝴蝶 Sniper Butterfly》 Versi Penuh 16-30｜Pemeran Utama: Chen Yanxi, Zhou Keyu Tencent Video-Youth Theater';

  @override
  String get imr0DFA4mNA => 'Imr0DFA4mNA';

  @override
  String get iVGn2RlvnG => 'IVGn2Rlvn_g';

  @override
  String get dIhValICo => 'dIh-Val_ICo';

  @override
  String get u3CEzhnlaM => 'U3C-EzhnlaM';

  @override
  String get bJ3HUIXyu04 => 'BJ3HUIXyu04';

  @override
  String get g9lIyw6LKr8 => 'G9lIyw6LKr8';

  @override
  String get xQhtl58Mg0 => 'x-qhtl58Mg0';

  @override
  String get emRj53N7q0 => 'emRj53N7q-0';

  @override
  String get g4LSe3sjJ1I => 'G4LSe3sjJ1I';

  @override
  String get label7PpYIVmyaU => '7PpYI-vmyaU';

  @override
  String get allRise => 'Segera Tampil All Rise';

  @override
  String get label9AaKDIWNK8 => '-9AaKDIWNK8';

  @override
  String get cIY8AALMGA => 'cIY8AAL-MGA';

  @override
  String get mwHNJlgj0M => '-MwHNJlgj0M';

  @override
  String get lM6Siyziyfg => 'LM6Siyziyfg';

  @override
  String get yUgNvqLkHo => 'Y-ugNvqLkHo';

  @override
  String get loveIsAlwaysOnline2 =>
      'Orang yang Tepat di Waktu yang Tepat Love is Always Online';

  @override
  String get bbu8Ct33WGY => 'Bbu8Ct33WGY';

  @override
  String get iW8gQdPQE => 'iW-8g-qdPQE';

  @override
  String get zKjqrbqqc74 => 'ZKjqrbqqc74';

  @override
  String get label1UbEkGEXNs => '1UbEkGE-xNs';

  @override
  String get w8eDA1UJ5OY => 'W8eDA1UJ5OY';

  @override
  String get hydT2kHzno => '-hydT2kHzno';

  @override
  String get fONOKBq7bLo => 'FONOKBq7bLo';

  @override
  String get s4zCx2IlFE => 's4zCx2Il-fE';

  @override
  String get bA13fouCls => 'BA_13fouCls';

  @override
  String get pLyX50Z72L2xw1E6HhmF968YkX7BlZ9 =>
      'PLyX_50Z72L2xw1-e6HhmF968YkX7Bl_Z9';

  @override
  String get loveOnTheTurquoiseLand => '枭起青壤 Love on the Turquoise Land';

  @override
  String get we5ry5kxdHE => 'We5ry5kxdHE';

  @override
  String get emIUEma8Hg => 'EmIUEma-8Hg';

  @override
  String get wu6k5Xa3MM => 'Wu-6k5Xa3MM';

  @override
  String get label80SA571cW0 => '80-SA571cW0';

  @override
  String get label4PdR5JPhcY => '4Pd-R5JPhcY';

  @override
  String get fyB12Rr0V8 => 'fyB12-Rr0V8';

  @override
  String get ldKl7dOoRs => 'ld-Kl7dOoRs';

  @override
  String get label3xjBMrz6iC => '3xjBMrz6i-c';

  @override
  String get vt0403FhEU => 'Vt0403Fh-eU';

  @override
  String get eCcqo2QsOI => 'ECcqo2Qs-OI';

  @override
  String get syI7F7W2c8 => 'Sy-i7F7W2c8';

  @override
  String get vxTWyvL1Ms => 'VxTWyvL-1Ms';

  @override
  String get yw8QK3SuW => 'yw8QK-3Su-w';

  @override
  String get o16uHD0kTS => 'O16uHD0kT-s';

  @override
  String get nHx9DZl4Q => 'nHx9-D-Zl4Q';

  @override
  String get wMJrWKUN7w => '-WMJrWKUN7w';

  @override
  String get s9JU0L2RS4o => 'S9JU0L2RS4o';

  @override
  String get uJC6xna2PBM => 'UJC6xna2PBM';

  @override
  String get rbvdnADd18 => 'Rbvdn-ADd18';

  @override
  String get iHHlxN0Swo => 'i-HHlxN0Swo';

  @override
  String get zd8EBbfqs => 'Zd8_-EBbfqs';

  @override
  String get xUG53k1B4 => 'XUG_53k1-b4';

  @override
  String get whyIsHeStillSingle2 =>
      '《Why Is He Still Single》 Tayang 16/11! Dongeng cinta dewasa Wallace Huo & Zhu Zhu!';

  @override
  String get whyIsHeStillSingle3 =>
      '《Why Is He Still Single》 Versi Penuh｜Pemeran Utama: Wallace Huo, Zhu Zhu Tencent Video-Youth Theatre';

  @override
  String get ijgFlHRPHw => 'Ijg-FlHRPHw';

  @override
  String get whyIsHeStillSingle4 =>
      '《Why Is He Still Single》 Versi Penuh 1｜Pemeran Utama: Wallace Huo, Zhu Zhu Tencent Video-Youth Theatre';

  @override
  String get whyIsHeStillSingle5 =>
      '《Why Is He Still Single》 Versi Penuh 2｜Pemeran Utama: Wallace Huo, Zhu Zhu Tencent Video-Youth Theatre';

  @override
  String get yVGKe9xonY => 'YV-GKe9xonY';

  @override
  String get qKftsk37mXo => 'QKftsk37mXo';

  @override
  String get ccxy931pac => 'ccxy9-31pac';

  @override
  String get uc5hawjBFU => 'Uc5hawj_bFU';

  @override
  String get fightForLove => 'Shanhe Zhen Fight for Love';

  @override
  String get lGP6TCHM => 'l_g-p6TC_hM';

  @override
  String get wXKMI7kmY3Y => 'WXKMI7kmY3Y';

  @override
  String get v0wqy1HUJJE => 'V0wqy1HUJJE';

  @override
  String get j24dJWDtyps => 'J24dJWDtyps';

  @override
  String get v937gFLg7QU => 'V937gFLg7QU';

  @override
  String get x4R4W9wwzY => 'x4R-4W9wwzY';

  @override
  String get jV9KYnyvsg => 'jV9-kYnyvsg';

  @override
  String get hQPFMP7zQO0 => 'HQPFMP7zQO0';

  @override
  String get pLyX50Z72L2wHtPGkazV4LCGl20kRY4 =>
      'PLyX_50Z72L2w_HtPGkazV4-lCGl20kRY4';

  @override
  String get iMNobody => '我本无名 I\'m Nobody';

  @override
  String get persona => 'Persona (重影)';

  @override
  String get d5CPVc0EIY => 'D5CPVc0E-IY';

  @override
  String get pJsHXm9ZsC => 'pJsHXm9Zs-c';

  @override
  String get vYRvNE7Yk => '-VYRvNE-7Yk';

  @override
  String get lightBeyondTheReed => 'Light Beyond the Reed (余生有涯)';

  @override
  String get kqfhRrmmG => 'Kqfh_Rrmm_g';

  @override
  String get iKEYUsv14 => 'I-kE-YUsv14';

  @override
  String get hOC9mu9HVs => 'HOC9mu_9HVs';

  @override
  String get x8jqt87WIuo => 'X8jqt87WIuo';

  @override
  String get gb0Bk564EQ => 'gb0Bk564-EQ';

  @override
  String get thePrisonerOfBeauty => 'The Prisoner of Beauty (Versi Ringkas)';

  @override
  String get wsGeYBRO => 'wsGeYB_-r_o';

  @override
  String get thePrisonerOfBeauty2 =>
      '《The Prisoner of Beauty (Versi Ringkas)》Xiao Qiao menggantikan kakaknya menikah dengan musuh bebuyutan, berselisih dengan suami di hari pertama pernikahan | Dibintangi: Song Zuer, Liu Yuning | Tencent Video-Youth Theatre';

  @override
  String get thePrisonerOfBeauty3 =>
      '《The Prisoner of Beauty (Versi Ringkas)》Xiao Qiao menggagalkan konspirasi Liu Yan mengebom kanal, hubungan dengan Wei Shao berubah dari musuh jadi saling melindungi | Dibintangi: Song Zuer, Liu Yuning | Tencent Video-Youth Theatre';

  @override
  String get thePrisonerOfBeauty4 =>
      '《The Prisoner of Beauty (Versi Ringkas)》Xiao Qiao berpura-pura sakit demi merebut kediaman utama, Wei Shao membela istrinya di depan umum dan menolak selir | Dibintangi: Song Zuer, Liu Yuning | Tencent Video-Youth Theatre';

  @override
  String get thePrisonerOfBeauty5 =>
      '《The Prisoner of Beauty (Versi Ringkas)》Xiao Qiao membongkar jebakan kotak kayu, Wei Shao mengakuinya sebagai nyonya rumah | Dibintangi: Song Zuer, Liu Yuning | Tencent Video-Youth Theatre';

  @override
  String get thePrisonerOfBeauty6 =>
      '《The Prisoner of Beauty (Versi Ringkas)》Xiao Qiao dengan cerdik mematahkan jebakan fitnah, Wei Shao mengakui dan melindungi istrinya saat perselisihan keluarga | Dibintangi: Song Zuer, Liu Yuning | Tencent Video-Youth Theatre';

  @override
  String get thePrisonerOfBeauty7 =>
      '《The Prisoner of Beauty (Versi Ringkas)》Wei Yan memicu masalah dengan surat palsu, Xiao Qiao dan Wei Shao mengalami krisis kepercayaan karena liontin giok | Dibintangi: Song Zuer, Liu Yuning | Tencent Video-Youth Theatre';

  @override
  String get thePrisonerOfBeauty8 =>
      '《The Prisoner of Beauty (Versi Ringkas)》Su Ehuang menjebak Xiao Qiao dengan gandum matang, Wei Shao melindungi istrinya dan memecahkan kasus sehingga hubungan makin dekat | Dibintangi: Song Zuer, Liu Yuning | Tencent Video-Youth Theatre';

  @override
  String get thePrisonerOfBeauty9 =>
      '《The Prisoner of Beauty (Versi Ringkas)》Xiao Qiao dan Wei Shao diserang dan diracuni, Xiao Qiao dengan cerdik menggagalkan konspirasi demi menyelamatkan suaminya | Dibintangi: Song Zuer, Liu Yuning | Tencent Video-Youth Theatre';

  @override
  String get rNYFWNcb8o => 'RNYFW-Ncb8o';

  @override
  String get thePrisonerOfBeauty10 =>
      '《The Prisoner of Beauty (Versi Ringkas)》Wei Shao memberi kuda perang lalu menyusul dengan tusuk konde, panik cemas saat istrinya menghilang | Dibintangi: Song Zuer, Liu Yuning | Tencent Video-Youth Theatre';

  @override
  String get thePrisonerOfBeauty11 =>
      '《The Prisoner of Beauty (Versi Ringkas)》Wei Shao cemburu dan takut Xiao Qiao kabur, menyesal dan merindukannya setelah pindah keluar | Dibintangi: Song Zuer, Liu Yuning | Tencent Video-Youth Theatre';

  @override
  String get thePrisonerOfBeauty12 =>
      '《The Prisoner of Beauty (Versi Ringkas)》Wei Shao yang cemburu menggendong Xiao Qiao, misteri kotak kayu terungkap dan membuat mereka makin dekat | Dibintangi: Song Zuer, Liu Yuning | Tencent Video-Youth Theatre';

  @override
  String get thePrisonerOfBeauty13 =>
      '《The Prisoner of Beauty (Versi Ringkas)》Kunjungan Qiao Ci membuat Wei Shao cemburu, Xiao Qiao dan suaminya saling membuka hati dan mengikat janji seumur hidup | Dibintangi: Song Zuer, Liu Yuning | Tencent Video-Youth Theatre';

  @override
  String get thePrisonerOfBeauty14 =>
      '《The Prisoner of Beauty Ringkasan》Wei Yan pergi demi Xiao Qiao, Shao dan Qiao berbaikan setelah bertengkar | Pemeran: Song Zuer, Liu Yuning Tencent Video-Teater Remaja';

  @override
  String get ry1BWClaV0 => 'ry1BWCla-V0';

  @override
  String get thePrisonerOfBeauty15 =>
      '《The Prisoner of Beauty Ringkasan》Pemberontakan malam pernikahan membuat saudari bermusuhan, Xiao Qiao mengusir musuh dengan cerdik dan Wei Shao mengaku salah | Pemeran: Song Zuer, Liu Yuning Tencent Video-Teater Remaja';

  @override
  String get o8nFcvzyvM => 'O8n-FcvzyvM';

  @override
  String get thePrisonerOfBeauty16 =>
      '《The Prisoner of Beauty Ringkasan》Wei Shao menemani Xiao Qiao ke Kangjun untuk menyelesaikan konflik, Ayah Qiao mengakui menantunya dan mereka bersatu | Pemeran: Song Zuer, Liu Yuning Tencent Video-Teater Remaja';

  @override
  String get krsrk6wSAy8 => 'Krsrk6wSAy8';

  @override
  String get thePrisonerOfBeauty17 =>
      '《The Prisoner of Beauty Ringkasan》Qiao Yue berkhianat dan Wei Liang tewas, Da Qiao diculik dan Bi Zhi melawan sekuat tenaga | Pemeran: Song Zuer, Liu Yuning Tencent Video-Teater Remaja';

  @override
  String get v26fn6w270 => 'V-26fn6w270';

  @override
  String get thePrisonerOfBeauty18 =>
      '《The Prisoner of Beauty Ringkasan》Wei Liang tewas bertempur dan lengan Wei Qu terputus, Da Qiao jatuh dari gedung dan Liu Yan hancur | Pemeran: Song Zuer, Liu Yuning Tencent Video-Teater Remaja';

  @override
  String get pLyX50Z72L2zD8aIumtBOoc0OWrwUUSe =>
      'PLyX_50Z72L2zD-8aIumtBOoc0OWrwUUSe';

  @override
  String get ahjr3KPEXv4 => 'Ahjr3KPEXv4';

  @override
  String get igijfp2Q8BY => 'Igijfp2Q8BY';

  @override
  String get kIy3O9LyJQ => 'kIy3-o9LyJQ';

  @override
  String get g40pz8IOI => 'G-40pz8I_oI';

  @override
  String get label4LTdKzOI54 => '4LTdKzO-I54';

  @override
  String get pPT =>
      'Tugas kelompok menganggapku lambat? CEO dominan memanjat jendela tengah malam mengantar PPT, satpam mengejarnya Tencent Video-Teater Remaja';

  @override
  String get zPBZ1KRQ3hY => 'ZPBZ1KRQ3hY';

  @override
  String get aThousandMilesToYour =>
      'Menjelajahi Ribuan Kota demi Mengenalmu - A Thousand Miles to Your Heart';

  @override
  String get getTheWeTVAPP4 =>
      'Tencent Video - Teater Drama Kolosal - Dapatkan Aplikasi WeTV';

  @override
  String get jnz1S8Qb5xE => 'Jnz1S8Qb5xE';

  @override
  String get nf5tvYU1W5A => 'Nf5tvYU1W5A';

  @override
  String get jRzsIK84C0 => 'jRzsIK84C-0';

  @override
  String get label9TcXQyaUAC => '9TcXQyaUA-c';

  @override
  String get mG6d7wN6fg => 'M-g6d7wN6fg';

  @override
  String get theInescapable => 'Suozan - The Inescapable';

  @override
  String get label2TF7nb09WM => '2TF7nb09W-M';

  @override
  String get xG7qBdDRn0 => '-XG7qBdDRn0';

  @override
  String get zeFO2XDbA4 => 'zeFO2XDb-A4';

  @override
  String get pLs3DOuT3JlGR2nMcuGW2139rVVeHcWIs =>
      'PLs3DOuT3JlGR2nMcuGW2139rV-veHcWIs';

  @override
  String get pursuitOfJade2 => '逐玉 Pursuit of Jade';

  @override
  String get tBj7OHjb2tI => 'TBj7OHjb2tI';

  @override
  String get vWOECNVUlQ => 'VWOE-cNVUlQ';

  @override
  String get label5NKgOE5DPQ => '5NKgOE5D-pQ';

  @override
  String get ipim7l2LZg => 'ipim7l2L-Zg';

  @override
  String get vmuf05J8Vc => '-Vmuf05J8Vc';

  @override
  String get label2M3Ls74gZY => '2M3Ls74gZ-Y';

  @override
  String get p8DW4Gef70o => 'P8DW4Gef70o';

  @override
  String get d4duxTP0FDE => 'D4duxTP0FDE';

  @override
  String get b1T03rs9WGI => 'B1T03rs9WGI';

  @override
  String get ruBRX68XPg => 'Ru-BRX68XPg';

  @override
  String get aX5eShfmFk => 'AX5eShfm_fk';

  @override
  String get fCsjHXbBlE => 'f-CsjHXbBlE';

  @override
  String get m9xKlm95oc => 'M9xKlm-95oc';

  @override
  String get xh0z4YV9v2s => 'Xh0z4YV9v2s';

  @override
  String get iufzj2MLPs => 'iufzj2M-LPs';

  @override
  String get x6uXEQgWuM => '-X6uXEQgWuM';

  @override
  String get wlz3IhZptM => 'Wlz3Ih-ZptM';

  @override
  String get p10GCq30oNI => 'P10GCq30oNI';

  @override
  String get b65UYuRtpE => 'B65-uYuRtpE';

  @override
  String get generationToGeneration222 =>
      '《江湖夜雨十年灯 Generation to Generation》tayang 22 Februari! Saksikan generasi muda terkuat Jianghu, Mu Mu dan Zhao Zhao, berpetualang bersama di dunia persilatan.';

  @override
  String get label6yOPycBAyU => '6y-oPycBAyU';

  @override
  String get lIAUBGNQM => 'LI-AUBGN-QM';

  @override
  String get sU12uaTtBg => 'SU-12uaTtBg';

  @override
  String get label05nLbIKPkQ => '05nLb-iKPkQ';

  @override
  String get rKGFPIzgpO => 'rKGFPIzgp-o';

  @override
  String get shO2wXA6U => 'Sh-o2w-xA6U';

  @override
  String get dNsDNXcJgM => 'd-nsDNXcJgM';

  @override
  String get w0NMLE9Hw => 'W_0N-mLE9Hw';

  @override
  String get lTtwLNkDHY => 'LTtwLNkD-HY';

  @override
  String get the300LoyalGhosts2 => '大明暗影三百忠魂 300 Jiwa Setia';

  @override
  String get zj1Mh0bRE => 'zj1Mh_0b-rE';

  @override
  String get kj6122rOzW => 'kj6122rOz-w';

  @override
  String get ftgF1Hu9Ko => 'Ftg-f1Hu9Ko';

  @override
  String get cnFIQ9QT4M => '-CnFIQ9QT4M';

  @override
  String get ajdFKQ4uq8 => 'AjdF-kQ4uq8';

  @override
  String get danceOfThePhoenix => '且听凤鸣 Tarian Phoenix';

  @override
  String get f0uIRYSOwo => 'F0uIRY_SOwo';

  @override
  String get extraordinary2 => '非凡 Luar Biasa';

  @override
  String get mIOS6JeeMU => 'mIOS6Jee-mU';

  @override
  String get d8CsUqEy4 => 'd8CsUq-ey_4';

  @override
  String get oZpINX3A => '-o_zpI-NX3A';

  @override
  String get hyKy6aEDmo => 'HyKy6aE-Dmo';

  @override
  String get nkAYc4ZSW8 => 'NkAYc4Z-sW8';

  @override
  String get ovTXZjh2M => 'ov-T_XZjh2M';

  @override
  String get label2TheImperialCoronerS22 =>
      '《御赐小仵作2 The Imperial Coroner S2》 dijadwalkan 15/01, pasangan Chu Yu kembali menghangatkan hati!';

  @override
  String get kvFDYYmg => 'KvF__d-YYmg';

  @override
  String get llaTO7muek => 'llaT-O7muek';

  @override
  String get label3r4Qw60AhM => '3r4Qw60Ah-M';

  @override
  String get nwb6rTXjAs => 'Nwb6rTXj-As';

  @override
  String get label87A7F8yq94 => '87A7F-8yq94';

  @override
  String get yJPJ6RWgyg => 'yJP-j6RWgyg';

  @override
  String get rebirthForYou => '嘉南传 Rebirth For You';

  @override
  String get f9eLAZQDUds => 'F9eLAZQDUds';

  @override
  String get aVowInTheDark2 => '恋恋风陵渡 A Vow in the Dark';

  @override
  String get theUltimateVowUnknownTo => 'The Ultimate Vow, Unknown to You';

  @override
  String get duMRGzTeKs => 'DuM-rGzTeKs';

  @override
  String get pLs3DOuT3JlGTynSBKz3Z5DcDzwwmqSOf =>
      'PLs3DOuT3JlGTynSBKz3-z5DcDzwwmqSOf';

  @override
  String get theChangAnYouth => 'Masa Muda Chang\'An The Chang\'An Youth';

  @override
  String get jg0aX6eEK4 => 'Jg0aX6e_EK4';

  @override
  String get adbjo5emA => 'Adbjo5em__A';

  @override
  String get label2QO1c7aWBE => '2QO1c7aW-bE';

  @override
  String get x75eul0gjYM => 'X75eul0gjYM';

  @override
  String get dN6c2uB2cF4 => 'DN6c2uB2cF4';

  @override
  String get label1xqkI5jRsc => '1xqkI5j-rsc';

  @override
  String get jRRXVJblrk => 'JRR-XVJblrk';

  @override
  String get thePrincessDecree2 => 'The Princess Decree';

  @override
  String get ppiNYsUwOA => 'PpiNYs-uwOA';

  @override
  String get label83tIjIiqM => '-_83tIjIiqM';

  @override
  String get p4cKjzSHFw => 'P4cKjz-sHFw';

  @override
  String get babysitter => '我在冷宫做月嫂 Babysitter';

  @override
  String get label0MjfIXHKOM => '0MjfIXHKO-M';

  @override
  String get zEOhv9GVlao => 'ZEOhv9GVlao';

  @override
  String get pLs3DOuT3JlGRa8QmAVS9qfbbZS7afa0x =>
      'PLs3DOuT3JlGRa8Qm-AVS9qfbbZS7afa0x';

  @override
  String get xUjdpB74DU => 'XUjdp_B74DU';

  @override
  String get ddcGbI27AE => 'DdcGbI-27AE';

  @override
  String get herPhoenixMajesty2 => 'Her Phoenix Majesty 2';

  @override
  String get pzXvIZTfw => 'Pz_xvIZ-Tfw';

  @override
  String get lXojyPTBzS => 'lXojyPTBz-s';

  @override
  String get pLs3DOuT3JlGQtL9S4u2QaRJty8BDrUk6 =>
      'PLs3DOuT3JlGQtL9S4u2QaRJty8BDrUk6-';

  @override
  String get ntuwtDMChw => 'ntuwtD-MChw';

  @override
  String get bGXUzqodupo => 'BGXUzqodupo';

  @override
  String get plePvm344k => 'plePvm-344k';

  @override
  String get f0OIk6BUbo => 'F0OIk6-BUbo';

  @override
  String get kZZnmxJGHw => 'KZZnmx_jGHw';

  @override
  String get eIuk7EPq2hg => 'EIuk7EPq2hg';

  @override
  String get label2H0pqyiPdk => '2H0pqyi-Pdk';

  @override
  String get j6Xs9w4Elw => 'J6_Xs9w4Elw';

  @override
  String get xMtNosSw0 => 'X_-mtNosSw0';

  @override
  String get bienjpo0UFM => 'Bienjpo0UFM';

  @override
  String get oJOso5tVBek => 'OJOso5tVBek';

  @override
  String get eRxWzG9p7U => 'eRxWzG9p7-U';

  @override
  String get iusgk4UlU => 'iusgk-4Ul-U';

  @override
  String get pUV3TRgebig => 'PUV3TRgebig';

  @override
  String get lr4EpeONCw => 'Lr4Epe-oNCw';

  @override
  String get o3jzt2IlGU => 'o3jzt2IlG-U';

  @override
  String get kKJPm6qb54A => 'KKJPm6qb54A';

  @override
  String get qlWNAIqlvw => 'Ql_WNAIqlvw';

  @override
  String get label0miWUBl3ZA => '0miWUBl3-zA';

  @override
  String get jQMZbtl7b2w => 'JQMZbtl7b2w';

  @override
  String get qAw54adzTQ => 'QAw5_4adzTQ';

  @override
  String get eSL64O0EfI => 'eSL-64O0EfI';

  @override
  String get eYC4j7ky8pg => 'EYC4j7ky8pg';

  @override
  String get hGDl1nDeqE => 'h-gDl1nDeqE';

  @override
  String get oAHE5vyYQg => '-oAHE5vyYQg';

  @override
  String get gbFQy8CqEo => 'GbFQy8Cq-Eo';

  @override
  String get izi1KFUxPk => 'Izi1KFUx-Pk';

  @override
  String get i3qxA2cr8kA => 'I3qxA2cr8kA';

  @override
  String get oFI5pek3lvY => 'OFI5pek3lvY';

  @override
  String get obuu6ZaIA8 => 'obuu6ZaIA-8';

  @override
  String get xIf4aL45npQ => 'XIf4aL45npQ';

  @override
  String get aGirlLikeMe2 => '我就是这般女子 A Girl Like Me';

  @override
  String get p4YsJ5WtBw => 'p4YsJ5Wt-bw';

  @override
  String get pIg2oXFWS8 => 'pIg2oXFWS-8';

  @override
  String get hrJz2C0Fxs => 'hrJz-2C0Fxs';

  @override
  String get mL0phSCWJY => 'mL0phSC-wJY';

  @override
  String get sideStoryOfFoxVolant2 => '飞狐外传 Side Story of Fox Volant';

  @override
  String get pLs3DOuT3JlGQCkd77fhalA8WxMD3OT4Q =>
      'PLs3DOuT3JlGQCkd77fhalA8Wx-mD3OT4Q';

  @override
  String get aFlowerOnTheContinent2 => '有花在洲 A Flower On The Continent';

  @override
  String get aFlowerOnTheContinent3 =>
      '【有花在洲 A Flower On The Continent】 Pangeran muda menjadi sandera, diperlakukan sebagai putri oleh Nona Hua, dan bahkan tinggal bersama';

  @override
  String get aFlowerOnTheContinent4 =>
      '【有花在洲 A Flower On The Continent】 Penyamaran Nona Hua terbongkar, pangeran muda mempertaruhkan nyawa melindunginya tapi malah difitnah';

  @override
  String get aFlowerOnTheContinent5 =>
      '【A Flower On The Continent】 Hua Xiyu mendapati pembunuh ayahnya adalah ayah Ning Xuanzhou dan mendadak murka';

  @override
  String get aFlowerOnTheContinent6 =>
      '【A Flower On The Continent】 Hua Xiyu bergaun pengantin menerobos kamp musuh, mempertaruhkan nyawa demi menyelamatkan Ning Xuanzhou';

  @override
  String get aFlowerOnTheContinent7 =>
      '【A Flower On The Continent】 Dua negara menandatangani perjanjian damai, Ning Xuanzhou merobek titah demi menikahi Hua Xiyu';

  @override
  String get aFlowerOnTheContinent8 =>
      '【A Flower On The Continent】 Hua Xiyu melukai pergelangan tangan demi obat, Ning Xuanzhou melaporkan ayahnya yang membunuh ayah Hua Xiyu';

  @override
  String get aFlowerOnTheContinent9 =>
      '【A Flower On The Continent】 Hua Xiyu tahu ayahnya dibunuh ayah Ning Xuanzhou, lalu memotong dahan kenangan di lautan bunga';

  @override
  String get pLs3DOuT3JlGS2bplCB41Z0150Kb9oQdn =>
      'PLs3DOuT3JlGS2bplCB41Z0150-Kb9oQdn';

  @override
  String get t1D3w33qTG8 => 'T1D3w33qTG8';

  @override
  String get fLoEBicAD0 => 'fLoEBicA-D0';

  @override
  String get pLs3DOuT3JlGTeaxmA97G31cUKERfzNgN =>
      'PLs3DOuT3JlGTeaxmA97G31cUK-eRfzNgN';

  @override
  String get d3UOh8aqKE => 'D3UOh_8aqKE';

  @override
  String get hcEA13KgnE => 'hcEA13Kgn-E';

  @override
  String get pbC7hP30zU => 'PbC7h-P30zU';

  @override
  String get hilariousFamily22 => 'Hilarious Family 2';

  @override
  String get sliceOfLife => 'Kisah Kehidupan';

  @override
  String get p6Og4b7SEiw => 'P6Og4b7SEiw';

  @override
  String get label6TOkoVJcus => '6-tOkoVJcus';

  @override
  String get xKUz23x2pOo => 'XKUz23x2pOo';

  @override
  String get fTuSIxeFUY => 'FTuSIxe-fUY';

  @override
  String get kdow9dKN0 => '_Kdow9dKN-0';

  @override
  String get y4eB2fuCNs => 'Y4e_b2fuCNs';

  @override
  String get sVClNTSRcQ => 'SV-clNTSRcQ';

  @override
  String get xQtiANGe8 => 'x-qtiA-NGe8';

  @override
  String get obESRYh3NU => 'obESRYh3-NU';

  @override
  String get pLs3DOuT3JlGShdDzo52tfDOSU1UkUcHX =>
      'PLs3DOuT3JlGShdDzo52tfDOSU1UkUc-hX';

  @override
  String get legendOfTheFemaleGeneral => 'Legend of The Female General';

  @override
  String get highlightLegendOfTheFemale =>
      'Kompilasi Sorotan 【Legend of The Female General】';

  @override
  String get a40F2TEZrms => 'A40F2TEZrms';

  @override
  String get lYQ5iND4 => 'lYQ5iN-d-_4';

  @override
  String get bTSLegendOfTheFemale =>
      'BTS Spesial Ulang Tahun Zhou Ye 🎂! 【Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale2 =>
      'BTS Spesial Ulang Tahun Komandan Xiao Cheng Lei 🎂! 【Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale3 =>
      'BTS Aksi Pertarungan Keren Berdua di Medan Perang, Bintang Kembar Great Wei 【Legend of The Female General】';

  @override
  String get bTS520LegendOfThe =>
      'BTS Rencanakan Kencan 520 Xi Xiao Yan Kai 【Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale4 =>
      'BTS Zhou Ye Saat Mabuk Sangat Imut~ Tarian Pedang Penuh Pesona~ Senyum Cheng Lei di Samping Tidak Bisa Disembunyikan! 【Legend of The Female General】';

  @override
  String get pLs3DOuT3JlGRucYIZLqmT7FO5IWDWrP =>
      'PLs3DOuT3JlGRuc_yIZLqmT7FO5IWD-WrP';

  @override
  String get thePrincessSGambit => 'The Princess\'s Gambit';

  @override
  String get highlightThePrincessSGambit =>
      'Kompilasi Sorotan 【The Princess\'s Gambit】';

  @override
  String get qJRbuw2hJ3s => 'QJRbuw2hJ3s';

  @override
  String get cGtKgr7X4o => 'cGt-Kgr7X4o';

  @override
  String get iZe4HBUZQ => 'IZe4_HBU_ZQ';

  @override
  String get zGgyp0sbyDM => 'ZGgyp0sbyDM';

  @override
  String get label2BI4oU8Rwo => '2BI4o-u8Rwo';

  @override
  String get zNZAQZZQ => '-ZN-zAQZZ-Q';

  @override
  String get uma3ppi4wiM => 'Uma3ppi4wiM';

  @override
  String get clipThePrincessSGambit =>
      'Klip: Gaun Merah Menodai Salju! Jiang Taohua Berpisah dengan Tanah Air demi Menikah ke Negara Qi Demi Adik Kecilnya 【The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit2 =>
      'Klip: Para Istri Kediaman Shen Bikin Ulah di Hari Pernikahan? Taohua Menghadapinya dengan Tenang 【The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit3 =>
      'Klip: Pura-Pura Pingsan Taohua Terbongkar, Shen Zaiye Membangunkannya dengan Jarum: Teruskan Aktingmu! 【The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit4 =>
      'Klip: Perdana Menteri Shen Tegas Menangani Kasus! Tindakan Tegas Usut Kasus Uang Palsu, Pejabat Korup Gemetar 【The Princess\'s Gambit】';

  @override
  String get eDrJjtCRF0 => 'eDr-jjtCRF0';

  @override
  String get clipThePrincessSGambit5 =>
      'Klip: Pembunuh Bertopeng Tak Lolos dari Hukuman, Detektif Taohua: Kakimu Membocorkannya! 【The Princess\'s Gambit】';

  @override
  String get clipPlayThePrincessS =>
      'Klip: Interogasi Tusuk Konde! Shen Zaiye Mengangkat Dagu Taohua dan Menginterogasinya dengan Dingin 【The Princess\'s Gambit】';

  @override
  String get label58K8GxhXlQ => '58K8-gxhXlQ';

  @override
  String get clipThePrincessSGambit6 =>
      'Klip 初次相见就玩这么大！沈在野桃花身中合欢散四目相对【桃花映江山 The Princess\'s Gambit】';

  @override
  String get pLIPiKkSFpK8B6r2izKyYYiYdbkYSBbd =>
      'PLIPiKkS-FpK8B6r2izKyY-yiYdbkYSBbd';

  @override
  String get reqdatIdS => 'Reqdat_id-s';

  @override
  String get label72zyHSuRDM => '72zyHSuR-dM';

  @override
  String get zQDc6PfC0 => 'z-q_Dc6PfC0';

  @override
  String get hfcLvnUQqA => '-hfcLvnUQqA';

  @override
  String get y5CHMfB8dw => 'Y5C-HMfB8dw';

  @override
  String get p28HP1H4Vc => 'P28HP_1H4Vc';

  @override
  String get yBclY6CaTw => 'yBclY6-caTw';

  @override
  String get bGIAtDEdlk => 'B-gIAtDEdlk';

  @override
  String get mWKB6zDZwc => 'mWKB6zD-zwc';

  @override
  String get q8N3LJ0A9Bk => 'Q8N3LJ0A9Bk';

  @override
  String get yR6T2qwwRJ0 => 'YR6T2qwwRJ0';

  @override
  String get oOgqhGuLE => '-o_ogqhGuLE';

  @override
  String get sk2MR0LGf0E => 'Sk2MR0LGf0E';

  @override
  String get rodBx023QQ => 'rodBx023-qQ';

  @override
  String get zPVcOAzByY => 'z-pVcOAzByY';

  @override
  String get nWM1Ceq5oyE => 'NWM1Ceq5oyE';

  @override
  String get pLIPiKkSFpKIRCE5jKV6WuMHd3ba79JP =>
      'PLIPiKkS-FpK_IRCE5jKV6WuMHd3ba79JP';

  @override
  String get label7yLGOh2ABg => '7y-lGOh2ABg';

  @override
  String get yr5pUONS3c => '-Yr5pUONS3c';

  @override
  String get svE0DPJGYA => 'SvE0DPJ-gYA';

  @override
  String get i709WD0cVs => 'I_709WD0cVs';

  @override
  String get mgWNgw9MQ => 'MgWNgw_9-MQ';

  @override
  String get xs2k2nlJYYc => 'Xs2k2nlJYYc';

  @override
  String get fdXXdYB6Vo => 'FdXXd-YB6Vo';

  @override
  String get pKG6QKF6Og => 'p-KG6QKF6Og';

  @override
  String get limitedFULLTheIngeniousOne =>
      '【Limited FULL】云襄传 | The Ingenious One | iQIYI 👑Bergabunglah menjadi Anggota dan nikmati episode lengkap sekarang!';

  @override
  String get iQIYIGetTheIQIYIAPP2 => 'iQIYI 爱奇艺 - Dapatkan Aplikasi iQIYI';

  @override
  String get aky3021PW => '_Aky3021P-w';

  @override
  String get hMaBvO3nkM => 'hMaBv-O3nkM';

  @override
  String get r2YEAXZFxp4 => 'R2YEAXZFxp4';

  @override
  String get iTLYG63GDc => 'ITLYG-63GDc';

  @override
  String get label1TyTz8z1vK => '1TyTz8z1v-k';

  @override
  String get jIq5a7yEd8c => 'JIq5a7yEd8c';

  @override
  String get tDMpSBCf5k => 'tDMp-sBCf5k';

  @override
  String get iPWSYbG6s4 => 'IPW-sYbG6s4';

  @override
  String get label6GjFP04aw => '6Gj-FP-04aw';

  @override
  String get pL6xVgUZ4UP2Ps7N0b2CUMkQ49aAX3xlw =>
      'PL6xVgUZ4UP2Ps7N0b2-cUMkQ49aAX3xlw';

  @override
  String get f8ilmFb30 => 'f8ilm_Fb-30';

  @override
  String get dQt4Zorb4gE => 'DQt4Zorb4gE';

  @override
  String get t9XDOuWLc => 't9XD-OuW-Lc';

  @override
  String get vcEgRd08 => '-vc_egRd_08';

  @override
  String get b0b1dFL9Nc => 'B0b1dF-l9Nc';

  @override
  String get pLIPiKkSFpK8VhfSNo7Vsx4lCMTKbcOm =>
      'PLIPiKkS-FpK8_VhfSNo7Vsx4lCMTKbcOm';

  @override
  String get aMeUFNq1m8 => 'AMe-uFNq1m8';

  @override
  String get dJUpKoPRtg => 'DJ-UpKoPRtg';

  @override
  String get oQMLDVlb7g => 'OQML_DVlb7g';

  @override
  String get aUeypfRL24 => 'aUeypfRL-24';

  @override
  String get uB9ycPhk1mg => 'UB9ycPhk1mg';

  @override
  String get pLIPiKkSFpK8Pesmyu9gzK2jXpplqUn9d =>
      'PLIPiKkS-FpK8Pesmyu9gzK2jXpplqUn9d';

  @override
  String get i5TQ4zJDUs => 'I5TQ4z_jDUs';

  @override
  String get goft2N911yE => 'Goft2N911yE';

  @override
  String get sraEP5hG98 => 'sraEP5hG-98';

  @override
  String get axhDRyKII => '_AxhDRy-kII';

  @override
  String get j1z4azTG40 => 'J-1z4azTG40';

  @override
  String get m87V7kOvg => '-m_87V7kOvg';

  @override
  String get g2ASv4fOuc => 'G2-aSv4fOuc';

  @override
  String get tONKwUFYQ => '-TONKwU_FYQ';

  @override
  String get mw7OlvkWDg => '-Mw7OlvkWDg';

  @override
  String get pLIPiKkSFpK8KCCeSQTpodI0VqMejybr9 =>
      'PLIPiKkS-FpK8KCCeSQTpodI0VqMejybr9';

  @override
  String get label4GJqLnsV6c => '4G-jqLnsV6c';

  @override
  String get b36gveSPqI => 'B36gveS-pqI';

  @override
  String get da6GLS11sDg => 'Da6GLS11sDg';

  @override
  String get r7Jzgv6XuM => '-r7Jzgv6XuM';

  @override
  String get fULLROADHOMEBoranJingSeven =>
      '【FULL】👮ROAD HOME💕 | BoranJing, Seven Tan | iQIYI Philippines';

  @override
  String get iQIYIPhilippinesGetTheIQIYI =>
      'iQIYI Philippines - Dapatkan Aplikasi iQIYI';

  @override
  String get lKuff6Nfwp8 => 'LKuff6Nfwp8';

  @override
  String get n3oPG8EusI => 'N3oPG8Eus-I';

  @override
  String get jEq6lPG1rus => 'JEq6lPG1rus';

  @override
  String get uwhhmc98HX8 => 'Uwhhmc98HX8';

  @override
  String get k3KVVNRjgw => 'K3KVV-NRjgw';

  @override
  String get aIEnglishDubMrBAD =>
      '【Sulih Suara AI Bahasa Inggris】Mr. BAD | Chen Zheyuan, Yue Shen | iQIYI Philippines';

  @override
  String get h7d38oiW4 => '-h7d38oi_w4';

  @override
  String get tIjEEDlLPY => '-TIjEEDlLPY';

  @override
  String get label6P746xQE1E => '6P746xQE1-E';

  @override
  String get wJo20fh1ovU => 'WJo20fh1ovU';

  @override
  String get aUci4B6qoIY => 'AUci4B6qoIY';

  @override
  String get loveOfTheDivineTree2 =>
      '🌸【奇幻仙侠】🎋Love of the Divine Tree 仙台有树 | Deng Wei × Xiang Hanzhi | FULL Episode | iQIYI 👑Bergabunglah dengan Keanggotaan dan nikmati episode lengkapnya sekarang!';

  @override
  String get uFSyFzIASM => 'UFSyFzIA-sM';

  @override
  String get c8THRSSU6M => 'c8-tHRSSU6M';

  @override
  String get cxx0rl8JJnc => 'Cxx0rl8JJnc';

  @override
  String get o5Mn9URF3uE => 'O5Mn9URF3uE';

  @override
  String get eE1jl4dzrg8 => 'EE1jl4dzrg8';

  @override
  String get label6GeLMiukHC => '6GeLMiukH-c';

  @override
  String get eAhVaQ2RA => 'e_ahVaQ2-rA';

  @override
  String get h9VQfSPUzs => 'H9VQfS-pUzs';

  @override
  String get pLIPiKkSFpKUBrffjChZ310g2OtsQfLf =>
      'PLIPiKkS-FpK-uBrffjChZ310g2OtsQfLf';

  @override
  String get k8DtfAAU4U => 'K8-DtfAAU4U';

  @override
  String get pLIPiKkSFpK9TcBapXhwwF9nCt2DZu9k =>
      'PLIPiKkS-FpK9-TcBapXhwwF9nCt2DZu9k';

  @override
  String get vP12XNOv5eM => 'VP12XNOv5eM';

  @override
  String get yTp22S1oA5Q => 'YTp22S1oA5Q';

  @override
  String get rxgy49XHTbs => 'Rxgy49XHTbs';

  @override
  String get hHw9RaWByc => 'hHw9-RaWByc';

  @override
  String get wwoz6JPu2Yg => 'Wwoz6JPu2Yg';

  @override
  String get lW32xQCoqs => 'LW32x_QCoqs';

  @override
  String get gb414C2O3w => 'Gb414C2_O3w';

  @override
  String get k7iTvKzZyQ => 'K7iTv-KzZyQ';

  @override
  String get npbhgWJePE => 'npbhgWJe-PE';

  @override
  String get knWpROE9xU => 'kn-WpROE9xU';

  @override
  String get eT8okyktVok => 'ET8okyktVok';

  @override
  String get pLIPiKkSFpK8Q5DyWQXPpAdGsyH8BPUYA =>
      'PLIPiKkS-FpK8Q5DyWQXPpAdGsyH8BPUYA';

  @override
  String get rD40VQSYnjo => 'RD40VQSYnjo';

  @override
  String get bmdZBo8HoE => 'BmdZ-Bo8HoE';

  @override
  String get pLIPiKkSFpK9MiE3quPZjNnu7RgviYDy =>
      'PLIPiKkS-FpK9MiE3quPZjNnu7-RgviYDy';

  @override
  String get fYFcg3qNJE => 'fYFcg3qN-jE';

  @override
  String get uWRVG89Kn8M => 'UWRVG89Kn8M';

  @override
  String get iBUh0B2XAMQ => 'IBUh0B2XAMQ';

  @override
  String get wQlTnSp5s => 'W-ql-tnSp5s';

  @override
  String get edAqyr6ieU => '-EdAqyr6ieU';

  @override
  String get pLIPiKkSFpK8wb8Yzzh4eptkOEn2LPtDf =>
      'PLIPiKkS-FpK8wb8Yzzh4eptkOEn2LPtDf';

  @override
  String get label93ckJe0R6c => '-93ckJe0R6c';

  @override
  String get vzb1BHRshM => 'Vzb1B-hRshM';

  @override
  String get yC69yjVyOo => 'y-C69yjVyOo';

  @override
  String get pLIPiKkSFpK8MdPQg72ceDNUGjf0mhENz =>
      'PLIPiKkS-FpK8MdPQg72ceDNUGjf0mhENz';

  @override
  String get iEC4DBbzBI => 'iEC4DBbzB-I';

  @override
  String get yf7VWSAbOU => 'yf7VW-sAbOU';

  @override
  String get sF0QfbuHtQ => 'S-F0QfbuHtQ';

  @override
  String get yPcsflr52s => 'yPcsflr-52s';

  @override
  String get md04meyJlA => 'md0-4meyJlA';

  @override
  String get iof4jeN6LG4 => 'Iof4jeN6LG4';

  @override
  String get label8FjmZttLM => '-8_fjmZttLM';

  @override
  String get cCnli0HQ3IE => 'CCnli0HQ3IE';

  @override
  String get label8EXPB74Dyc => '8-EXPB74Dyc';

  @override
  String get fULLMyDearGuardianJohnny =>
      '【FULL】🕊️My Dear Guardian | Johnny Huang, Li Qin | iQIYI Filipina';

  @override
  String get fN0lxPL4Qa0 => 'FN0lxPL4Qa0';

  @override
  String get bjlqxe76Cc => 'bjlqxe76-cc';

  @override
  String get pLIPiKkSFpKHKjDQgjOj98MaZq0gm =>
      'PLIPiKkS-FpK-_h-KjD_qgjOj98MaZq0gm';

  @override
  String get tcWqflGCUY => 'TcWqflG-CUY';

  @override
  String get rZfxh4rSg => '--rZfxh4rSg';

  @override
  String get label1ORyfeHBGG => '1ORyfeHBG-g';

  @override
  String get pLIPiKkSFpK9cwfQqamjvymbElQlrV6do =>
      'PLIPiKkS-FpK9cwfQqamjvymbElQlrV6do';

  @override
  String get vKvu1urDSps => 'VKvu1urDSps';

  @override
  String get dB2fAHAIw30 => 'DB2fAHAIw30';

  @override
  String get pLlCrV9TCfzMYJebfwvzDDQzDFbY9XqvE =>
      'PLlCrV9TCfzMYJebfwvzDDQzDFbY-9XqvE';

  @override
  String get theBestThingZhangLinghe =>
      '🌸【治愈爱情】🎋The Best Thing 爱你 | Zhang Linghe × Xu Ruohan | FULL正片 | iQIYI 👑Bergabunglah menjadi Anggota dan nikmati episode lengkapnya sekarang!';

  @override
  String get h22R4lYT0QQ => 'H22R4lYT0QQ';

  @override
  String get a4CMqC9Hg => 'A-4C-mqC9Hg';

  @override
  String get jJvSIEUsWY => 'jJvSI-EUsWY';

  @override
  String get label94M1y8ivG => '94M1y8iv--g';

  @override
  String get k50lO8uGHM => 'K_50lO8uGHM';

  @override
  String get eP012026RebirthChineseDrama =>
      '📽️【EP01 2026】Drama China Rebirth ENGSUB | Li Yunrui / Huangyang Tiantian /Zhang Kangle ⛵😍 Drama Sejarah 2026 #冰湖重生';

  @override
  String get soRNQqVHiE => 'SoRN-qqVHiE';

  @override
  String get label0WKj11GO1k => '0WKj11G-O1k';

  @override
  String get mckn8scIT9M => 'Mckn8scIT9M';

  @override
  String get label3ouJb1XcvO => '3ouJb1Xcv-o';

  @override
  String get oGOi5zR5GE => 'OGOi5z-R5GE';

  @override
  String get oSCmrPPTm8 => 'oSCmrPPTm-8';

  @override
  String get fSBy5hig8pk => 'FSBy5hig8pk';

  @override
  String get sC1tGve5Nr0 => 'SC1tGve5Nr0';

  @override
  String get lYWUkqJk2E => 'LYW-ukqJk2E';

  @override
  String get iXwhs66r7C => 'IXwhs66r7_c';

  @override
  String get hJ1qGBGVF14 => 'HJ1qGBGVF14';

  @override
  String get xz1ZaLRTo => 'xz1-Za_LRTo';

  @override
  String get pL6xVgUZ4UP2OaE8yjLqTIxq2XKePI7m7 =>
      'PL6xVgUZ4UP2OaE8yjLqTIxq2XKe-PI7m7';

  @override
  String get xi7IXdkzYg => 'Xi7IXdkz-yg';

  @override
  String get xMUzyFFGBS => 'xMUzyFFGB-s';

  @override
  String get cAPUf0NVjfg => 'CAPUf0NVjfg';

  @override
  String get jObgd77gRVI => 'JObgd77gRVI';

  @override
  String get zAh5l4TSL44 => 'ZAh5l4TSL44';

  @override
  String get iH5Dhymb50 => 'IH-5Dhymb50';

  @override
  String get pLIPiKkSFpKBxGpxeLaoE3RK1B27J2K =>
      'PLIPiKkS-FpK-BxGpxeLaoE3RK1-B27J2K';

  @override
  String get label5iTVfTFX1c => '5i-tVfTFX1c';

  @override
  String get label2jKJSKqQlI => '2jKJSKq-qlI';

  @override
  String get xTqeH63puw => 'xTqe-h63puw';

  @override
  String get oazvgr9cyow => 'Oazvgr9cyow';

  @override
  String get fULLFatedHeartsLiQin =>
      '【FULL】🏹Fated Hearts | Li Qin, Chen Zheyuan | iQIYI Philippines';

  @override
  String get kCYYUs6wGOY => 'KCYYUs6wGOY';

  @override
  String get tm2SyrqoQg => 'tm2-SyrqoQg';

  @override
  String get qZ5uUGk9gmg => 'QZ5uUGk9gmg';

  @override
  String get xETV6qEPY => 'XETV6qE-P_Y';

  @override
  String get label8rWW83nQVE => '-8rWW83nQVE';

  @override
  String get zd4MuxKNDE => 'zd-4MuxKNDE';

  @override
  String get s2pk7pn3go4 => 'S2pk7pn3go4';

  @override
  String get hQvrj4X9Frg => 'HQvrj4X9Frg';

  @override
  String get fc8AWtgpGY => 'fc-8AWtgpGY';

  @override
  String get zPgeg1zFU1s => 'ZPgeg1zFU1s';

  @override
  String get iYjOKBPzxE => 'iYjOK-bPzxE';

  @override
  String get label6DmBfkWs4I => '-6DmBfkWs4I';

  @override
  String get label3JUCW6WIY => '-3JUC-w6WIY';

  @override
  String get sJ22yMn4qfY => 'SJ22yMn4qfY';

  @override
  String get ono7fMWcfcg => 'Ono7fMWcfcg';

  @override
  String get txW0Ss7D50 => 'txW-0Ss7D50';

  @override
  String get pLIPiKkSFpK9dJRiyjRahGpG8woGS9Sl2 =>
      'PLIPiKkS-FpK9dJRiyjRahGpG8woGS9Sl2';

  @override
  String get mVab12IKYMA => 'MVab12IKYMA';

  @override
  String get zLABLPu8ik => 'Z-lABLPu8ik';

  @override
  String get hCoJMcrjQ => 'hCoJ_-McrjQ';

  @override
  String get eRyFDWPR4 => 'e_ry-fDWPR4';

  @override
  String get mAvoRUd3wU => 'MAvoRUd-3wU';

  @override
  String get dWExvMyVU => 'dW-ExvMyV-U';

  @override
  String get bPKuepfUA => '-bPKuepf_UA';

  @override
  String get fBj8DL4EF0 => 'fBj8D-L4EF0';

  @override
  String get pLIPiKkSFpK87slgXbMjH686D5Y9P0EuG =>
      'PLIPiKkS-FpK87slgXbMjH686D5Y9P0EuG';

  @override
  String get k0Gl3FEW4s => 'K0Gl-3FEW4s';

  @override
  String get shHZmbjrqI => '-shHZmbjrqI';

  @override
  String get label7X5IzmrLCw => '7-X5IzmrLCw';

  @override
  String get nI1kp3v97O => 'nI1kp3v97-o';

  @override
  String get ea8enhWKTo0 => 'Ea8enhWKTo0';

  @override
  String get yL0RBWIo2iw => 'YL0RBWIo2iw';

  @override
  String get hX1u0R19FY => 'H_x1u0R19FY';

  @override
  String get cEGtoc5chDc => 'CEGtoc5chDc';

  @override
  String get qXKk36teGLc => 'QXKk36teGLc';

  @override
  String get pLIPiKkSFpKZTWsxZO5xUAlAsUEFOl3K =>
      'PLIPiKkS-FpK-zTWsxZO5xUAlAsUEFOl3K';

  @override
  String get mtO6K9Y59Q => 'Mt_o6K9Y59Q';

  @override
  String get kVop5QZCM => 'kVop_5QZ-cM';

  @override
  String get lX8cA1yLAg => 'l-X8cA1yLAg';

  @override
  String get v7m8WNX1gxE => 'V7m8WNX1gxE';

  @override
  String get bGf1clBUq0 => 'BGf1clB_uq0';

  @override
  String get lPA6cWd9vqA => 'LPA6cWd9vqA';

  @override
  String get pfckLVY64 => '-Pfck_LVY64';

  @override
  String get pLIPiKkSFpKN3T51FbkSIbF5IQ0RxhVm =>
      'PLIPiKkS-FpK_n3T51FbkSIbF5IQ0RxhVm';

  @override
  String get aH80GizsvY => 'AH8-0GizsvY';

  @override
  String get jI2ISWehQ => 'jI2IS-Weh_Q';

  @override
  String get label7rwGdyAl0g => '7rw-gdyAl0g';

  @override
  String get kF4rfnm9qdo => 'KF4rfnm9qdo';

  @override
  String get v1ae2rgrl70 => 'V1ae2rgrl70';

  @override
  String get c9D8kCt3k => 'C9D8k_-Ct3k';

  @override
  String get zY4ALWb5lw => 'ZY4AL-wb5lw';

  @override
  String get qUvwUdI73Y => 'q-UvwUdI73Y';

  @override
  String get iT670fTpFQ => 'iT-670fTpFQ';

  @override
  String get b6t7LGBPK => 'b6t_7LGBP-k';

  @override
  String get w9QYDN3nxTc => 'W9QYDN3nxTc';

  @override
  String get w9NPQe4Z5kE => 'W9NPQe4Z5kE';

  @override
  String get tQSHAlsaxqw => 'TQSHAlsaxqw';

  @override
  String get tN0ATkrc2zw => 'TN0ATkrc2zw';

  @override
  String get label7tsZeZfLtI => '7tsZeZfLt-I';

  @override
  String get w59SaAa6Ck => 'W59Sa_Aa6Ck';

  @override
  String get lSBiko45p8U => 'LSBiko45p8U';

  @override
  String get t2PwfV1JIE => 'T2PwfV1J-iE';

  @override
  String get bz75CXZ3c => 'Bz75CX-z_3c';

  @override
  String get nEEt9D9uR4g => 'NEEt9D9uR4g';

  @override
  String get dFv86C0wEg8 => 'DFv86C0wEg8';

  @override
  String get nWijSsYBUI => 'nWijSsYBU-I';

  @override
  String get ui2O9fffvWM => 'Ui2O9fffvWM';

  @override
  String get kMK9ZIL5vIE => 'KMK9ZIL5vIE';

  @override
  String get pZxPXGSNk => 'pZx_pXG-sNk';

  @override
  String get lGe1BEo7wL8 => 'LGe1BEo7wL8';

  @override
  String get wtVVEt4NxI => 'WtVVEt4Nx-I';

  @override
  String get ggXL7dEPA => 'Gg-xL7d-ePA';

  @override
  String get mPO0drxj4XI => 'MPO0drxj4XI';

  @override
  String get qYkUzAJo => '--q_ykUzAJo';

  @override
  String get mU4PJGdOxg => 'mU4PJGd-oxg';

  @override
  String get hOWSRDXSjb4 => 'HOWSRDXSjb4';

  @override
  String get nttqxJL3ES => 'nttqxJL3E-s';

  @override
  String get tJCmewUT4O => 'tJCmewUT4-o';

  @override
  String get sp7QFdPm3o => 'Sp7Q-FdPm3o';

  @override
  String get qI7c50Jcxbk => 'QI7c50Jcxbk';

  @override
  String get tM0RxsWCms => 'tM0Rxs-wCms';

  @override
  String get pLIPiKkSFpK6Iyv3Gsa1hZqwSLQ4z34u =>
      'PLIPiKkS-FpK_6Iyv3Gsa1hZqwSLQ4z34u';

  @override
  String get p1c9AW9VNY => 'p1c9-aW9VNY';

  @override
  String get eTwGAe5RiM => 'e-TwGAe5RiM';

  @override
  String get vSDFc4ivKU => 'VSD-Fc4ivKU';

  @override
  String get label2UNAa30mF0 => '2U-nAa30mF0';

  @override
  String get iLP6X3nSYE => 'I-LP6X3nSYE';

  @override
  String get mo4kd8rg3yU => 'Mo4kd8rg3yU';

  @override
  String get xt8m39rI9o => 'Xt8m_39rI9o';

  @override
  String get oFLWTHOJJo => 'OFLWTHO-jJo';

  @override
  String get pLlRMBKO6RkY69nj6AJ051lj7vSGrkNxZ =>
      'PLlRMBK-O6RkY69nj6AJ051lj7vSGrkNxZ';

  @override
  String get label3gTpyQenT0 => '3gTpy-qenT0';

  @override
  String get nM3BDMI4YS => 'nM3BDMI4Y-s';

  @override
  String get hudgy0oFTz4 => 'Hudgy0oFTz4';

  @override
  String get lVc0U1sJIBU => 'LVc0U1sJIBU';

  @override
  String get gBTqOwTPTU => 'G-BTqOwTPTU';

  @override
  String get tN0iGRSk => '_T-N-0iGRSk';

  @override
  String get gkEBMyB9TM => 'gkEBMy-B9TM';

  @override
  String get bw3XWYzoI => '-bw3XWYzo-I';

  @override
  String get fullBrightEyesInThe =>
      '【Full】Bright Eyes in the Dark | Johnny Huang, Zhang Jing Yi | iQIYI Filipina';

  @override
  String get jalmOqeImY => 'JalmOqeIm-Y';

  @override
  String get vUuzPUBkas => 'V-UuzPUBkas';

  @override
  String get ni1jN2ECMY => 'Ni1j-N2ECMY';

  @override
  String get v5qeq2caORg => 'V5qeq2caORg';

  @override
  String get cB64rYJ2tX4 => 'CB64rYJ2tX4';

  @override
  String get qwyz2k6oymc => 'Qwyz2k6oymc';

  @override
  String get gQYaqUf4 => 'GQ_-_YaqUf4';

  @override
  String get tqHC6KtyoI => 'tqHC6-ktyoI';

  @override
  String get hvsJOV10Q => 'hvsJOV-_10Q';

  @override
  String get label9LFPEXffyQ => '-9LFPEXffyQ';

  @override
  String get bMbhR77eps => 'b-MbhR77eps';

  @override
  String get olkxX4m0m4 => 'OlkxX-4m0m4';

  @override
  String get vE8nY1UC2zo => 'VE8nY1UC2zo';

  @override
  String get pLIPiKkSFpKZjc5dsVYfFD44oWYA1YZ =>
      'PLIPiKkS-FpK-Zjc5dsVYfFD44oWYA-1YZ';

  @override
  String get gZDlH6PN3M => 'gZDlH6P-n3M';

  @override
  String get iw4jJBB5z7A => 'Iw4jJBB5z7A';

  @override
  String get hOTu6yklewA => 'HOTu6yklewA';

  @override
  String get vJqSl1U6CE => '-VJqSl1U6CE';

  @override
  String get yF3ZBEnNaA => 'YF-3ZBEnNaA';

  @override
  String get at8v7Xp7XX4 => 'At8v7Xp7XX4';

  @override
  String get ctXWz6p3RI => '-CtXWz6p3RI';

  @override
  String get gsuEr3Rwo => 'GsuEr3--Rwo';

  @override
  String get cvkAplxMt0 => '-CvkAplxMt0';

  @override
  String get ssQiWv0MEA => 'SsQiWv0M-eA';

  @override
  String get aaDlYQswEc => 'aaDl-YQswEc';

  @override
  String get oaDLF7MQF0 => 'Oa_DLF7MQF0';

  @override
  String get pLIPiKkSFpK9jSaLiXXKZUvwfh7ROuLy =>
      'PLIPiKkS-FpK9jSaLiXX_KZUvwfh7ROuLy';

  @override
  String get g0nqbugnDI => 'G_0nqbugnDI';

  @override
  String get tnHgUzjPNQ => 'TnHgUzj-pNQ';

  @override
  String get nM7ZeWM1g => 'n-m7ZeW-m1g';

  @override
  String get sUqbEIap2M => '-sUqbEIap2M';

  @override
  String get x0qW6MwABw => 'X0qW6Mw-ABw';

  @override
  String get lANXfM0Hmc => 'L-aNXfM0Hmc';

  @override
  String get y84UUFKMZf4 => 'Y84UUFKMZf4';

  @override
  String get mGPFI2bfKPE => 'MGPFI2bfKPE';

  @override
  String get f3wSwhf0z8 => 'F3w_swhf0z8';

  @override
  String get qFITVBXVj2g => 'QFITVBXVj2g';

  @override
  String get pLyT8L9yeLXCR7t2xuK0L7L4qIRBTnA2n =>
      'PLyT8L9yeLXCR7t2xuK0-L7L4qIRBTnA2n';

  @override
  String get aY1Wv805lUw => 'AY1Wv805lUw';

  @override
  String get w44Q3K2QJY => 'W44-q3K2QJY';

  @override
  String get kJn1gifAmok => 'KJn1gifAmok';

  @override
  String get xwEsWU6WI => 'xwEs-WU6_wI';

  @override
  String get gt93TaUaco => 'gt9-3TaUaco';

  @override
  String get label0C62qBO6o => '0_c62q-bO6o';

  @override
  String get label7DqIz7YqcA => '7Dq-iz7YqcA';

  @override
  String get xh5K9iCMoo => 'xh5K9iC-Moo';

  @override
  String get aKGp1lOCRTI => 'AKGp1lOCRTI';

  @override
  String get jWYI2dtDE0 => 'JWY_i2dtDE0';

  @override
  String get yWHZCsskuvo => 'YWHZCsskuvo';

  @override
  String get label76Z43cwXKQ => '76Z43cw-xKQ';

  @override
  String get cINtsiKIx4 => 'CINtsi-kIx4';

  @override
  String get eNGSUBChineseFantasyMovie =>
      '🎥✨【SUB ENG】Film Fantasi Tiongkok | Fantasi, Petualangan【 iQIYI MOVIE THEATER-Selamat berlangganan】';

  @override
  String get iQIYIMOVIETHEATERGetThe =>
      '爱奇艺大电影 iQIYI MOVIE THEATER - Dapatkan Aplikasi iQIYI';

  @override
  String get oNi1Mh97lYo => 'ONi1Mh97lYo';

  @override
  String get sF74vcQwZE => 'sF74vc-qwZE';

  @override
  String get qBQ1xvkvQHw => 'QBQ1xvkvQHw';

  @override
  String get s2HdHtZAU => 'S2HdHtZ_A-U';

  @override
  String get pyt8OISpH0 => 'Pyt8O-ISpH0';

  @override
  String get x5oUtpXWQ => 'X5oUtp_X_wQ';

  @override
  String get miniDramaENGSUBFull =>
      '🎀【Drama Mini】SUB ENG | Koleksi Versi Lengkap | Unduh Aplikasi WeTV / Tencent Video untuk Menonton Lebih Banyak';

  @override
  String get vZysxG7Jdg => 'V-zysxG7Jdg';

  @override
  String get aLCm1V4uj8 => 'aL-Cm1V4uj8';

  @override
  String get xk8guI5XC7I => 'Xk8guI5XC7I';

  @override
  String get woIZMiblY => 'Wo--IZMiblY';

  @override
  String get e0Z1n9lVyg => 'E0Z1n-9lVyg';

  @override
  String get rakZAuY6Xc => 'RakZ-auY6Xc';

  @override
  String get rW5f3p84 => 'RW_5f-_3p84';

  @override
  String get wMtyXWrQRY => 'wMtyXWrQ-rY';

  @override
  String get bQj9Q1GRnrk => 'BQj9Q1GRnrk';

  @override
  String get ezD9rGwMk => '-EzD9r_GwMk';

  @override
  String get pLIPiKkSFpK8hfRCOdc3tpxnj6JmGAZoc =>
      'PLIPiKkS-FpK8hfRCOdc3tpxnj6JmGAZoc';

  @override
  String get bSt0NgJemE => '-bSt0NgJemE';

  @override
  String get zwSSFibKM => 'zwSSFib-_kM';

  @override
  String get rFPkjQgdwQ => 'rFPkjQgdw-Q';

  @override
  String get label0BgIjnISU => '0BgIjnIS-_U';

  @override
  String get o1mRObiOog => 'O-1mRObiOog';

  @override
  String get yHkKXeRbbk => 'YHk-KXeRbbk';

  @override
  String get label0E4CVmwEv0 => '0E4-CVmwEv0';

  @override
  String get n220nwxfsgY => 'N220nwxfsgY';

  @override
  String get rZQc0wk8Y4c => 'RZQc0wk8Y4c';

  @override
  String get uIV6jneTw => 'U_i-v6jneTw';

  @override
  String get fullBeautyOfResilienceJu =>
      '【Lengkap】Beauty of Resilience | Ju Jing Yi, Fiction | iQIYI Filipina';

  @override
  String get tT8V4eOewkc => 'TT8V4eOewkc';

  @override
  String get a6D40BKYc9Y => 'A6D40BKYc9Y';

  @override
  String get gd5lvL1Y3UI => 'Gd5lvL1Y3UI';

  @override
  String get bhrmf6kUnc => 'Bhrmf6k_Unc';

  @override
  String get zajsQ18HyM => 'Zajs-Q18HyM';

  @override
  String get za9iO7xrdhU => 'Za9iO7xrdhU';

  @override
  String get cCi69c44BTY => 'CCi69c44BTY';

  @override
  String get c5Lnqm4FI5s => 'C5Lnqm4FI5s';

  @override
  String get bXr6Zu7EH3g => 'BXr6Zu7EH3g';

  @override
  String get pLIPiKkSFpK85Ldm2HSl0Xwj2hN7T59g =>
      'PLIPiKkS-FpK85Ldm2HSl-0Xwj2hN7T59g';

  @override
  String get pLWIh6wofY4 => 'PLWIh6wofY4';

  @override
  String get label3YVDQD5Onc => '3-yVDQD5Onc';

  @override
  String get iPxGP1UGnM => 'IPx-GP1UGnM';

  @override
  String get hotTrendingMoonlitReunionFull =>
      '🔥Sedang Tren【子夜归 Moonlit Reunion】Episode Lengkap | Manusia dan Siluman jatuh cinta sambil memecahkan misteri | Xu Kai, Tian Xiwei | SUB INDO';

  @override
  String get v7niIXnWWM => 'v7ni-iXnWWM';

  @override
  String get vQ5PKKJSVHc => 'VQ5PKKJSVHc';

  @override
  String get hWuKG1vJe0 => 'hWu-kG1vJe0';

  @override
  String get ydHHEma2Q => '-ydHH-ema2Q';

  @override
  String get w6SB0R7W1U => 'W6-SB0R7W1U';

  @override
  String get kwjhz1XOLhs => 'Kwjhz1XOLhs';

  @override
  String get cmyjS5zTQ => '-cmyjS-5zTQ';

  @override
  String get label8DzphxFJPI => '8-DzphxFJPI';

  @override
  String get gzjc1eGV22g => 'Gzjc1eGV22g';

  @override
  String get y9ZHRA9lxcg => 'Y9ZHRA9lxcg';

  @override
  String get mnfa5S7KO8 => 'Mnfa5_S7KO8';

  @override
  String get gNiRWpeMws => 'gNiRWpe-mws';

  @override
  String get cVO0hA3P8O => 'CVO0hA3P8-o';

  @override
  String get label9afZnkZaPs => '9afZnk-zaPs';

  @override
  String get pLIPiKkSFpK9cUoS9l5spDGFvN2Crmdn =>
      'PLIPiKkS-FpK9cUoS9l_5spDGFvN2Crmdn';

  @override
  String get nLMKI6PT3o => 'NL_MKI6PT3o';

  @override
  String get zR7i5LASYI => 'ZR7i5_lASYI';

  @override
  String get keKMrR1Yss => 'KeK-mrR1Yss';

  @override
  String get juRTPVpVXA => 'juRTPVp-VXA';

  @override
  String get yzSy3klEQU => 'yzSy3kl-eQU';

  @override
  String get label8A7WTDaaGs => '8A7W-tDaaGs';

  @override
  String get pLIPiKkSFpK8hIu32ZhKKsO2wlADWaCBU =>
      'PLIPiKkS-FpK8hIu32ZhKKsO2wlADWaCBU';

  @override
  String get oVN1y6LPWD4 => 'OVN1y6LPWD4';

  @override
  String get qU7t6C4Gc => 'qU7t6-c4_gc';

  @override
  String get fk9JXDCOG4 => 'Fk9_JXDCOG4';

  @override
  String get uC7Mnd3qJc => 'UC7Mnd3q_Jc';

  @override
  String get glHm8Zs8Ac => 'glHm8Zs8-Ac';

  @override
  String get l2w4TUDxmsg => 'L2w4TUDxmsg';

  @override
  String get cPLU864rP14 => 'CPLU864rP14';

  @override
  String get a4mUs48UAU => 'a4mUs4-8UAU';

  @override
  String get bVmda5m2mN4 => 'BVmda5m2mN4';

  @override
  String get mZUf8J2gZA4 => 'MZUf8J2gZA4';

  @override
  String get tQiZtftwY => 'TQi--ZtftwY';

  @override
  String get bR38d9KJoos => 'BR38d9KJoos';

  @override
  String get pLIPiKkSFpKOHffjOp4RqWHtE2OYq =>
      'PLIPiKkS-FpK-oHffjOp4-rq__WHtE2OYq';

  @override
  String get fyuHVqsXMI => 'fyuHVqs-XMI';

  @override
  String get yJB0nFJNw0 => 'YJB0nFJNw_0';

  @override
  String get label21RxwDPr8k => '21Rxw-DPr8k';

  @override
  String get zZTZ149pQ => 'ZZ-_tZ149pQ';

  @override
  String get o5qvwYEyQ0 => 'o5qvwY-EyQ0';

  @override
  String get bGGDIBw4TIw => 'BGGDIBw4TIw';

  @override
  String get gU0lbFUBwg8 => 'GU0lbFUBwg8';

  @override
  String get yTfshUkXmG => 'yTfshUkXm-g';

  @override
  String get yOUTUBEAPIKEY => 'YOUTUBE_API_KEY=';

  @override
  String get partContentDetails => '?part=contentDetails';

  @override
  String get fallInLove => 'jatuh cinta';

  @override
  String get myGirl => 'gadisku';

  @override
  String get firstRomance2 => 'cinta pertama';

  @override
  String get fallFor => 'jatuh hati';

  @override
  String get uCD83JhUFQXRDwC6S8caCQ => 'UCD_83Jh-UFQXRDwC6S8caCQ';

  @override
  String get uCFh5x5AZHQQ6FaGKnGQXDA => 'UCFh5x5AZHQQ6FaGKnG-QXDA';

  @override
  String get uCRABdhiBHX4BieJfPCd2pg => 'UCRABdhiBHX4Bie-jfPCd2pg';

  @override
  String get hiddenLove2 => 'Cinta Tersembunyi';

  @override
  String get loveBetweenFairyAndDevil2 => 'Love Between Fairy and Devil';

  @override
  String get loveLikeTheGalaxy2 => 'Love Like The Galaxy';

  @override
  String get myJourneyToYou2 => 'My Journey to You';

  @override
  String get mysteriousLotusCasebook2 => 'Mysterious Lotus Casebook';

  @override
  String get reset => 'Atur ulang';

  @override
  String get theLongBallad2 => 'The Long Ballad';

  @override
  String get theUntamed2 => 'The Untamed';

  @override
  String get wordOfHonor2 => 'Word of Honor';

  @override
  String get lightOfDawn2 => '人之初 Cahaya Fajar';

  @override
  String get hOMELANDGUARDIAN2 => '守诚者|PENJAGA TANAH AIR';

  @override
  String get searching2 => 'Mencari...';

  @override
  String get verse => 'Bait';

  @override
  String get allStories2 => 'Semua Cerita';

  @override
  String get bbcComZhongwenTrad => 'bbc.com/zhongwen/trad';

  @override
  String get hanziClickable => '.hanzi-clickable';

  @override
  String get sentenceText => 'sentence-text';

  @override
  String get sentenceWrapper => 'sentence-wrapper';

  @override
  String get hanziClickable2 => 'hanzi-clickable';

  @override
  String get char2 => '+ karakter +';

  @override
  String get sentenceText2 => '.sentence-text';

  @override
  String get ttsBtn => 'tts-btn';

  @override
  String get hanziTranslateBtn => 'hanzi-translate-btn';

  @override
  String get label10px16px => '10px 16px';

  @override
  String get articleArticlePostContentMain =>
      'artikel, .artikel, .posting, .konten, utama';

  @override
  String get ttsActiveWord => '.tts-active-word';

  @override
  String get ttsActiveWord2 => 'tts-active-word';

  @override
  String get upperIntermediate2 => 'Menengah Atas';

  @override
  String get hanziDarkModeStyle => 'hanzi-dark-mode-style';

  @override
  String get sharedaddyJpPostFlairEntry =>
      '.sharedaddy, #jp-post-flair, .entry-meta, .wpcnt, .author-info, #comments, .comments, .post-footer, footer, .related-posts, .share-buttons';

  @override
  String get aiInsightBanner => 'ai-insight-banner';

  @override
  String get summaryToggleBtn => 'summary-toggle-btn';

  @override
  String get toggleChevron => 'toggle-chevron';

  @override
  String get summaryText => 'summary-text';

  @override
  String get documentBodyInnerText => 'document.body.innerText';

  @override
  String get documentTitle => 'document.title';

  @override
  String get processing => 'Memproses…';

  @override
  String get keepItUp => '好！Pertahankan';

  @override
  String get minutesDay => 'Menit / Hari';

  @override
  String get consistencyIsTheInkThat =>
      '\"Konsistensi adalah tinta yang membentuk karakter.\"';

  @override
  String get businessCareer => 'Bisnis & Karier';

  @override
  String get travelSurvival => 'Perjalanan & Survival';

  @override
  String get label05MinDay => '05 Mnt / Hari';

  @override
  String get label10MinDay => '10 Mnt / Hari';

  @override
  String get label20MinDay => '20 Mnt / Hari';

  @override
  String get label30MinDay => '30 Mnt / Hari';

  @override
  String get dynamicDecksStrokeAnalysis => 'Dek Dinamis & Analisis Goresan';

  @override
  String get subscriptionsAreTemporarilyUnavailablePl =>
      'Langganan tidak tersedia untuk sementara. Silakan coba lagi.';

  @override
  String get trialReminder => 'Pengingat Uji Coba';

  @override
  String get turnOnNotificationsIfYou =>
      'Aktifkan notifikasi jika Anda ingin pengingat sebelum masa uji coba berakhir. Pengaturan langganan App Store Anda tetap menjadi acuan utama.';

  @override
  String get label2Months => '2 bulan';

  @override
  String get label3Months => '3 bulan';

  @override
  String get label6Months => '6 bulan';

  @override
  String get billingPeriod => 'periode penagihan';

  @override
  String get chooseASubscription => 'Pilih langganan';

  @override
  String get startFreeTrial => 'Mulai uji coba gratis';

  @override
  String get smartNewsDict => 'Berita & Kamus Pintar';

  @override
  String get hSK16AIDecks => 'Dek HSK 1-6 & AI';

  @override
  String get continueWithTemporaryPremium =>
      'Lanjutkan dengan Premium sementara';

  @override
  String get testProductUnavailable => 'Produk uji coba tidak tersedia';

  @override
  String get paymentIsChargedToYour =>
      'Pembayaran ditagihkan ke akun App Store Anda.';

  @override
  String get subscriptionsRenewAutomaticallyUnlessCan =>
      'Langganan diperbarui secara otomatis kecuali dibatalkan';

  @override
  String get atLeast24HoursBefore =>
      'setidaknya 24 jam sebelum akhir periode saat ini.';

  @override
  String get privacyPolicy => 'Kebijakan Privasi';

  @override
  String get closePurchaseOffer => 'Tutup penawaran pembelian';

  @override
  String get loading => 'Memuat...';

  @override
  String get analyzingImage2 => 'Menganalisis gambar…';

  @override
  String get extractingChineseText2 => 'Mengekstrak teks Mandarin…';

  @override
  String get lookingUpVocabulary2 => 'Mencari kosakata…';

  @override
  String get deselectAll => 'Batal Pilih Semua';

  @override
  String get selectAll => 'Pilih Semua';

  @override
  String get worldChineseLiteraryMasterpiece =>
      'Mahakarya sastra dunia & Tionghoa.';

  @override
  String get classic => 'Klasik';

  @override
  String get literature => 'Sastra';

  @override
  String get theOriginAwakening => 'Asal-Usul & Kebangkitan';

  @override
  String get turbulentHorizonsTheJourney => 'Cakrawala Bergolak & Perjalanan';

  @override
  String get trialsTribulationsDevotion => 'Ujian, Kesengsaraan & Pengabdian';

  @override
  String get theClashOfWitsBravery => 'Adu Kecerdasan & Keberanian';

  @override
  String get theGrandClimaxResolution => 'Klimaks Agung & Resolusi';

  @override
  String get everlastingLegacyEpilogue => 'Warisan Abadi & Epilog';

  @override
  String get acrossTheVastExpanseOf =>
      'Di seluruh hamparan langit dan bumi yang luas, para tokoh mengejar takdir dan keyakinan mereka melalui ujian yang mendalam.';

  @override
  String get everyDialogueAndEncounterWithin =>
      'Setiap dialog dan pertemuan dalam kisah ini memancarkan keagungan jiwa manusia dan jejak zamannya.';

  @override
  String get followingTheFlowOfProse =>
      'Mengikuti alur prosa, pembaca melintasi berabad-abad waktu untuk merasakan kejayaan dan kesedihan para tokoh legenda.';

  @override
  String get preQin => 'pra-Qin';

  @override
  String get theGoddessNWaRepairing => 'Dewi Nüwa menambal langit';

  @override
  String get artsTraditions => 'Seni & Tradisi';

  @override
  String get femaleWarm => 'Wanita, hangat';

  @override
  String get femaleCheerful => 'Wanita, ceria';

  @override
  String get maleUpbeat => 'Pria, bersemangat';

  @override
  String get maleNewsStyle => 'Pria, gaya berita';

  @override
  String get maleSporty => 'Pria, sporty';

  @override
  String get onDevice => 'Di perangkat';

  @override
  String get label15Minutes => '15 Menit';

  @override
  String get label30Minutes => '30 Menit';

  @override
  String get label45Minutes => '45 Menit';

  @override
  String get selectChapter => 'Pilih Bab';

  @override
  String get andContinuesToBeStudied =>
      'dan terus dipelajari serta diapresiasi oleh pembaca lintas generasi.';

  @override
  String get label1Poem => '1 Puisi';

  @override
  String get label1Chapter => '1 Bab';

  @override
  String get localDeviceVoice2 => 'Suara perangkat lokal';

  @override
  String get weeklyAzureQuotaReachedSwitching =>
      'Kuota mingguan Azure tercapai — beralih ke suara lokal';

  @override
  String get sleepTimer2 => '定时关闭 · Pengatur Waktu Tidur';

  @override
  String get tableOfContents2 => '目录 · Daftar Isi';

  @override
  String get hanziMaster10 => 'HanziMaster/1.0';

  @override
  String get spanishItalianRussianClassics =>
      'Karya Klasik Spanyol, Italia & Rusia';

  @override
  String get englishAmericanGlobalClassics =>
      'Karya Klasik Inggris, Amerika & Global';

  @override
  String get whileStrategicallyEmbeddingWordsYou =>
      'sambil menyelipkan kata-kata yang sulit Anda kuasai secara strategis agar dapat dipelajari dalam konteks.';

  @override
  String get poetryPainting => 'puisi-lukisan';

  @override
  String get contactSinosparkCom => 'contact@sinospark.com';

  @override
  String get shadowingStudioIsADedicated =>
      'Shadowing Studio adalah ruang khusus untuk berlatih menirukan penutur asli. Anda dapat mendengarkan frasa, merekam diri saat mengulangnya, serta membandingkan bentuk gelombang dan skor pengucapan untuk menyempurnakan aksen Anda.';

  @override
  String get theVoicesInAIStories =>
      'Cerita AI dan Bermain Peran menggunakan suara sintetis dari model teks-ke-ucapan canggih yang disetel untuk pelafalan bahasa Mandarin yang jelas dan alami. Suara lokal perangkat juga mungkin tersedia pada fitur tertentu.';

  @override
  String get theWebExplorerAllowsYou =>
      'Web Explorer memungkinkan Anda menjelajahi situs web berbahasa Mandarin apa pun. Saat menemukan kata yang sulit, cukup ketuk untuk membuka kartu Intip Cepat yang menyediakan Pinyin, terjemahan, dan tingkat HSK secara instan.';

  @override
  String get zenModeStripsAwayDistracting =>
      'Mode Zen menghilangkan elemen web yang mengganggu, iklan, dan tata letak artikel yang rumit, menyajikan lingkungan membaca kaligrafi yang bersih dan berfokus sepenuhnya pada teks.';

  @override
  String get weUseAnIntelligentAlgorithm =>
      'Kami menggunakan algoritma cerdas yang memprediksi kapan Anda hampir melupakan suatu kata. Kata-kata yang sulit bagi Anda akan muncul lebih sering, sementara kata-kata yang sudah dikuasai akan dijadwalkan lebih jauh di masa mendatang.';

  @override
  String get usage3 => 'Penggunaan:';

  @override
  String get tutorialOneExplanation =>
      'Ini adalah SATU (Yī). Selalu tulis dari Kiri ke Kanan.';

  @override
  String get tutorialWaterExplanation =>
      'Ini adalah karakter utuh AIR (Shuǐ). Saat digunakan sebagai komponen di sisi kiri, bentuknya berubah menjadi \'氵\' (Tiga Tetes)!';

  @override
  String get tutorialRadicalsExplanation =>
      'Hanzi dibentuk dari blok penyusun yang disebut RADIKAL. Radikal memberikan makna inti atau tema pada karakter tersebut.';

  @override
  String get tutorialLettersExplanation =>
      'Hanzi bukan sekadar huruf. Hanzi adalah lukisan yang terbekukan oleh waktu. Untuk menguasainya, Anda harus belajar mengikuti alur goresannya.';

  @override
  String get tutorialGalaxyExplanation =>
      'Peta Galaksi menanti. Kuasai Matahari (Radikal) untuk membuka Kunci Planet (Karakter).';

  @override
  String get onboardingDailyLifeTravel => 'Kehidupan Sehari-hari & Wisata';

  @override
  String get onboardingPhilosophyIdioms => 'Filsafat & Idiom';

  @override
  String get onboardingBusinessCareerMulti => 'Bisnis &\nKarier';

  @override
  String get onboardingTravelSurvivalMulti => 'Wisata &\nBertahan Hidup';

  @override
  String get onboardingHskCertificationMulti => 'Sertifikasi\nHSK';

  @override
  String get onboardingCulturalAppreciationMulti => 'Apresiasi\nBudaya';

  @override
  String get practiceReminders => 'Pengingat latihan';

  @override
  String get oneOptionalDailyReminderTo =>
      'Satu pengingat harian opsional untuk berlatih bahasa Mandarin';

  @override
  String get aFewMinutesOfChinese => 'Beberapa menit berlatih Mandarin? 🌱';

  @override
  String get keepYourProgressMovingWith =>
      'Pertahankan kemajuan Anda dengan sesi latihan singkat.';

  @override
  String get xuX => 'xué xí';

  @override
  String get toStudyToLearn => 'belajar · mempelajari';

  @override
  String get pNgYou => 'péng you';

  @override
  String get fXiN => 'fā xiàn';

  @override
  String get toDiscover => 'menemukan';

  @override
  String get jiNCh => 'jiān chí';

  @override
  String get toPersist => 'bertahan';

  @override
  String get yNgQ => 'yǒng qì';

  @override
  String get zhHu => 'zhì huì';

  @override
  String get chNgZhNg => 'chéng zhǎng';

  @override
  String get toGrow => 'tumbuh';

  @override
  String get pNgJNg => 'píng jìng';

  @override
  String get calmPeaceful => 'tenang · damai';

  @override
  String get xWNg => 'xī wàng';

  @override
  String get lJi => 'lǐ jiě';

  @override
  String get toUnderstand => 'memahami';

  @override
  String get xGuN => 'xí guàn';

  @override
  String get wNNuN => 'wēn nuǎn';

  @override
  String get warmthWarm => 'kehangatan · hangat';

  @override
  String get zhuNZh => 'zhuān zhù';

  @override
  String get toFocus => 'fokus';

  @override
  String get definitionExpansionButton => 'tombol-perluasan-definisi';

  @override
  String get wenigerAnzeigen => 'Tampilkan lebih sedikit';

  @override
  String get mostrarMenos => 'Tampilkan lebih sedikit';

  @override
  String get afficherMoins => 'Tampilkan lebih sedikit';

  @override
  String get mostraMeno => 'Tampilkan lebih sedikit';

  @override
  String get showFewer => 'Tampilkan lebih sedikit';

  @override
  String get masterLin => 'Master Lin';

  @override
  String get xiaoMei => 'Xiao Mei';

  @override
  String get thePoet => 'Sang Penyair';

  @override
  String get aQiang => 'A-Qiang';

  @override
  String get vivian => 'Vivian';

  @override
  String get formalWise => 'Formal & bijak';

  @override
  String get casualFriendly => 'Santai & ramah';

  @override
  String get poeticAncient => 'Puitis & kuno';

  @override
  String get slangInternet => 'Gaul & internet';

  @override
  String get trendyModern => 'Kekinian & modern';

  @override
  String get designYourOwn => 'Buat sendiri';

  @override
  String get theBambooSwaysAndThe =>
      'Bambu bergoyang, dan sang cendekiawan menanti katamu bak hujan pagi...';

  @override
  String get yourCustomPersonaIsActive =>
      'Persona kustom Anda aktif. Ketik untuk memulai percakapan.';

  @override
  String get hHMm => 'HH:mm';

  @override
  String get fROMLocalizedDefinitionQualityWHERE =>
      'FROM localized_definition_quality WHERE language_code = ?';

  @override
  String get gemini25Flash => 'gemini-2.5-flash';

  @override
  String get dictionaryExpansionV1 => 'dictionary-expansion-v1';

  @override
  String get staleDictionaryExpansionResponse => 'Respons ekspansi kamus usang';

  @override
  String get dictionaryExpansionWasEmpty => 'Ekspansi kamus kosong';

  @override
  String get explicationDTaillEDisponible => 'Penjelasan terperinci tersedia';

  @override
  String get ausfHrlicheErklRungVerf => 'Penjelasan terperinci tersedia';

  @override
  String get explicaciNDetalladaDisponible => 'Penjelasan terperinci tersedia';

  @override
  String get spiegazioneDettagliataDisponibile =>
      'Penjelasan terperinci tersedia';

  @override
  String get explicaODetalhadaDisponVel => 'Penjelasan terperinci tersedia';

  @override
  String get detailedExplanationAvailable => 'Penjelasan terperinci tersedia';

  @override
  String get oneOptionalDailyPracticeReminder =>
      'Satu pengingat latihan harian opsional';

  @override
  String get chooseOneOptionalDailyPractice =>
      'Pilih satu pengingat latihan harian opsional.';

  @override
  String get practiceReminder => 'Pengingat latihan';

  @override
  String get oneGentleReminderADay =>
      'Satu pengingat lembut sehari, hanya jika Anda membutuhkannya';

  @override
  String get finishingPracticeSilencesTodayS =>
      'Menyelesaikan latihan akan mematikan pengingat hari ini. Pengulangan dan';

  @override
  String get reEngagementAlertsAreCombined =>
      'peringatan keterlibatan kembali digabung agar tidak bertumpuk.';

  @override
  String get processing2 => 'Memproses…';

  @override
  String get wDKIChu => 'wǒ dǎ kāi chuāng hu';

  @override
  String get listen => 'Dengarkan';

  @override
  String get notice => 'Perhatikan';

  @override
  String get fourTones => 'Empat nada';

  @override
  String get write => 'Tulis';

  @override
  String get recap => 'Rangkuman';

  @override
  String get playbackDidNotStart => 'Pemutaran tidak dimulai';

  @override
  String get audioIsUnavailableYouCan =>
      'Audio tidak tersedia. Anda tetap dapat membaca dan melanjutkan.';

  @override
  String get microphoneAccessWasNotGranted =>
      'Akses mikrofon tidak diberikan. Anda dapat menggunakan opsi hening di bawah.';

  @override
  String get recordingIsUnavailableRightNow =>
      'Perekaman tidak tersedia saat ini.';

  @override
  String get listeningToYourTones => 'Mendengarkan nada Anda…';

  @override
  String get noRecording => 'Tidak ada rekaman';

  @override
  String get weCouldNotScoreThat =>
      'Kami tidak dapat menilai rekaman tersebut, jadi inilah contoh perbandingan nada.';

  @override
  String get listenForTheLowDipping =>
      'Dengarkan nada ketiga yang rendah dan meliuk.';

  @override
  String get firstHearATinyMoment =>
      'Pertama, dengarkan momen singkat dalam bahasa Mandarin. Belum perlu menghafal.';

  @override
  String get loadingAudio => 'Memuat audio…';

  @override
  String get listenToThePassage => 'Dengarkan bacaan';

  @override
  String get continueAction => 'Lanjutkan';

  @override
  String get noticeHowMeaningSoundAnd =>
      'Perhatikan bagaimana makna, bunyi, dan karakter berjalan bersama.';

  @override
  String get shadowOneSentence => 'Tiru satu kalimat';

  @override
  String get listenOnceThenHoldThe =>
      'Dengarkan sekali, lalu tahan mikrofon dan ucapkan kalimatnya.';

  @override
  String get hearItAgain => 'Dengarkan lagi';

  @override
  String get stopAndCheckMyTones => 'Berhenti dan periksa nada saya';

  @override
  String get useMicrophone => 'Gunakan mikrofon';

  @override
  String get iCanTSpeakRight => 'Saya tidak bisa bicara sekarang';

  @override
  String get tapACharacterToCompare =>
      'Ketuk karakter untuk membandingkan nada Anda dengan target, lalu dengarkan nada 1–4.';

  @override
  String get tryHandwriting => 'Coba tulisan tangan';

  @override
  String get seeWhatYouLearned => 'Lihat yang telah Anda pelajari';

  @override
  String get inAFewMinutesYou =>
      'Dalam beberapa menit, Anda telah menggunakan alur yang sama dengan pelajaran Anda.';

  @override
  String get listenedToChineseInContext =>
      'Mendengarkan bahasa Mandarin dalam konteks';

  @override
  String get shadowedASentence => 'Menirukan satu kalimat';

  @override
  String get comparedMandarinTones => 'Membandingkan nada bahasa Mandarin';

  @override
  String get practicedARealCharacter => 'Melatih karakter asli';

  @override
  String get qNgchNXiOy =>
      'Qīngchén, xiǎoyǔ tíng le. Wǒ dǎkāi chuānghu, tīngjiàn niǎor zài shù shàng chànggē. Xīn de yì tiān kāishǐ le.';

  @override
  String get atDawnTheLightRain =>
      'Saat fajar, hujan gerimis reda. Saya membuka jendela dan mendengar burung bernyanyi di pohon. Hari yang baru dimulai.';

  @override
  String get learnThroughRealVideos => 'Belajar melalui video nyata';

  @override
  String get followInteractiveSubtitlesLookUp =>
      'Ikuti subtitle interaktif, cari arti kata seketika, dan ubah setiap video menjadi pelajaran.';

  @override
  String get videoLearningScreenshot => 'Tangkapan layar pembelajaran video';

  @override
  String get turnAnyBookIntoA =>
      'Ubah buku apa pun menjadi pelajaran & buku audio';

  @override
  String get readNaturallyWithPronunciationDefinition =>
      'Baca secara alami dengan pelafalan, definisi, dan terjemahan yang tersedia kapan saja.';

  @override
  String get bookReaderScreenshot => 'Tangkapan layar pembaca buku';

  @override
  String get speakWithTheRightRhythm =>
      'Bicara bebas dengan AI & nada langsung';

  @override
  String get shadowNativeAudioAndVisualize =>
      'Tiru audio penutur asli dan visualisasikan keempat nada seiring meningkatnya pelafalan Anda.';

  @override
  String get shadowingAndTonesScreenshot =>
      'Tangkapan layar shadowing dan nada';

  @override
  String get understandEveryCharacter => 'Pahami setiap karakter';

  @override
  String get exploreMeaningPronunciationComponentsStr =>
      'Jelajahi arti, pelafalan, komponen, urutan goresan, dan kosakata bermanfaat di satu tempat.';

  @override
  String get characterDictionaryScreenshot => 'Tangkapan layar kamus karakter';

  @override
  String get learnChineseWithoutLimits => 'Belajar bahasa Mandarin tanpa batas';

  @override
  String get watchReadSpeakAndUnderstand =>
      'Tonton, baca, bicara, dan pahami bahasa Mandarin dengan satu pendamping belajar lengkap.';

  @override
  String get seeWhatPremiumUnlocks => 'Lihat apa yang dibuka oleh Premium';

  @override
  String get scrollToExploreTheComplete =>
      'Gulir untuk menjelajahi pengalaman belajar yang lengkap';

  @override
  String get cOMINGSOON => 'SEGERA HADIR';

  @override
  String get guidedHandwritingPractice => 'Latihan menulis tangan terpandu';

  @override
  String get scannerAndLiveTranslation => 'Pemindai dan terjemahan langsung';

  @override
  String get hSK16AndAI => 'Dek HSK 1–6 dan AI';

  @override
  String get smartSpacedRepetition2 => 'Pengulangan berjarak pintar';

  @override
  String get progressAndStreakTracking => 'Pelacakan kemajuan dan rentetan';

  @override
  String get learningToolsInOnePlace => 'Alat belajar di satu tempat';

  @override
  String get everythingIncluded => 'Semua sudah termasuk';

  @override
  String get paymentIsChargedToYour2 =>
      'Pembayaran ditagihkan ke akun App Store Anda. Langganan diperbarui secara otomatis kecuali dibatalkan setidaknya 24 jam sebelum akhir periode saat ini.';

  @override
  String get yourFirstWeekOfTracked => 'Minggu pertama latihan terlacak Anda';

  @override
  String get sameNumberOfCardsAs => 'Jumlah kartu yang sama dengan minggu lalu';

  @override
  String cardsComparedWithLastWeek(String change) {
    return '$change kartu dibandingkan minggu lalu';
  }

  @override
  String get todaySPractice => 'Latihan hari ini';

  @override
  String get goalCompleteAnythingMoreIs =>
      'Target tercapai — sisanya adalah bonus.';

  @override
  String get aSmallAchievableTargetNo =>
      'Target kecil yang dapat dicapai. Tanpa penalti untuk hari istirahat.';

  @override
  String get thisWeek => 'Minggu ini';

  @override
  String get minutes => 'Menit';

  @override
  String get activeDays => 'Hari aktif';

  @override
  String dayStreakCount(int count) {
    return 'Rangkaian $count hari';
  }

  @override
  String get masterChineseOneStrokeAt =>
      'Kuasai bahasa Mandarin, goresan demi goresan';

  @override
  String get dictionaryExpansionButton => 'tombol perluasan kamus';

  @override
  String get kIErweiterterWRterbucheintrag => 'Detail kamus diperluas AI';

  @override
  String get detalleAmpliadoPorIA => 'Detail diperluas AI';

  @override
  String get dTailEnrichiParL => 'Detail diperkaya AI';

  @override
  String get aI => 'Detail kamus diperluas AI';

  @override
  String get detailKamusYangDiperluasAI => 'Detail kamus yang diperluas AI';

  @override
  String get dettaglioDelDizionarioAmpliatoDall => 'Detail kamus diperluas AI';

  @override
  String get aI2 => 'Detail kamus diperluas AI';

  @override
  String get aI3 => 'Detail kamus diperluas AI';

  @override
  String get detalheDeDicionRioExpandido => 'Detail kamus diperluas AI';

  @override
  String get aI4 => 'Detail kamus diperluas AI';

  @override
  String get chiTiTTI => 'Detail kamus diperluas AI';

  @override
  String get aI5 => 'Detail kamus diperluas AI';

  @override
  String get aIExpandedDictionaryDetail => 'Detail kamus diperluas AI';

  @override
  String get cetteEntrEEstBr =>
      'Entri ini singkat. Penjelasan terperinci tersedia.';

  @override
  String get dieserEintragIstKurzEine =>
      'Entri ini singkat. Penjelasan terperinci tersedia.';

  @override
  String get estaEntradaEsBreveHay =>
      'Entri ini singkat. Penjelasan terperinci tersedia.';

  @override
  String get questaVoceBreveDisponibileUna =>
      'Entri ini singkat. Penjelasan terperinci tersedia.';

  @override
  String get estaEntradaBreveEstDispon =>
      'Entri ini singkat. Penjelasan terperinci tersedia.';

  @override
  String get thisDictionaryEntryIsBrief =>
      'Entri kamus ini singkat. Penjelasan terperinci tersedia.';

  @override
  String get dVelopperEnFranAis => 'Perluas dalam bahasa Prancis';

  @override
  String get aufDeutschErweitern => 'Perluas dalam bahasa Jerman';

  @override
  String get ampliarEnEspaOl => 'Perluas dalam bahasa Spanyol';

  @override
  String get approfondisciInItaliano => 'Perluas dalam bahasa Italia';

  @override
  String get expandirEmPortuguS => 'Perluas dalam bahasa Portugis';

  @override
  String get expandDefinition => 'Perluas definisi';

  @override
  String get impossibleDeChargerLExplication => 'Gagal memuat penjelasan.';

  @override
  String get dieErklRungKonnteNicht => 'Gagal memuat penjelasan.';

  @override
  String get noSePudoCargarLa => 'Gagal memuat penjelasan.';

  @override
  String get impossibileCaricareLaSpiegazione => 'Gagal memuat penjelasan.';

  @override
  String get nOFoiPossVel => 'Gagal memuat penjelasan.';

  @override
  String get unableToLoadTheExplanation => 'Gagal memuat penjelasan.';

  @override
  String get failedToGenerateStoryN => 'Gagal membuat cerita:\\n\$e';

  @override
  String get thematic => 'Tematik';

  @override
  String get deckFlashcards => 'Dek (Kartu Kilat)';

  @override
  String get searchLibraryOrTypeCustom => 'Cari pustaka atau ketik kustom';

  @override
  String get hSKLevel => 'HSK \$level';

  @override
  String get analysisFailedE => 'Analisis gagal: \$e';

  @override
  String get extractionFailedE => 'Ekstraksi gagal: \$e';

  @override
  String get simplifyFailedE => 'Gagal menyederhanakan: \$e';

  @override
  String get translationFailedE => 'Terjemahan gagal: \$e';

  @override
  String get failedToSaveExtractedWords2 =>
      'Gagal menyimpan kata yang diekstrak: \$error';

  @override
  String youActualTargetExpected(String actual, String expected) {
    return 'Anda: $actual  ·  Target: $expected';
  }

  @override
  String get improveTheLocalVoice => 'Tingkatkan suara lokal';

  @override
  String get higherQualityOfflineMandarin =>
      'Mandarin offline berkualitas tinggi';

  @override
  String get removeDownload => 'Hapus unduhan?';

  @override
  String get removeDownload2 => 'Hapus Unduhan';

  @override
  String get tag => '#\$tag';

  @override
  String get voiceFemaleWarm => 'Wanita, hangat';

  @override
  String get voiceFemaleCheerful => 'Wanita, ceria';

  @override
  String get voiceMaleUpbeat => 'Pria, bersemangat';

  @override
  String get voiceMaleNewsStyle => 'Pria, gaya berita';

  @override
  String get voiceMaleSporty => 'Pria, sporty';

  @override
  String get voiceOnDeviceTts => 'TTS di perangkat';

  @override
  String get voiceSystemVoice => 'Suara sistem';

  @override
  String get applySessionGradesToSpacedRepetition =>
      'Terapkan nilai sesi ke Pengulangan Berjarak (Mode Berbicara)';

  @override
  String get unableToLoadThisSectionPleaseTryAgain =>
      'Tidak dapat memuat bagian ini. Silakan coba lagi.';

  @override
  String get removeDownloadQuestion => 'Hapus unduhan?';

  @override
  String get removeDownloadContent => 'Remove downloaded content?';

  @override
  String get removeDownloadAction => 'Hapus Unduhan';

  @override
  String get removeDownloadButton => 'Hapus Unduhan';

  @override
  String cardsCount(num count) {
    return '$count Cards';
  }

  @override
  String get aiSummary => 'Ringkasan AI';

  @override
  String get readability => 'Keterbacaan';

  @override
  String get translateAction => 'Terjemahkan';

  @override
  String get checkingDownload => 'Memeriksa unduhan';

  @override
  String downloadingBook(int percent) {
    return 'Mengunduh: $percent%';
  }

  @override
  String get retryDownload => 'Coba unduh lagi';

  @override
  String get downloadBook => 'Unduh buku';

  @override
  String continueChapter(int chapter) {
    return 'Lanjutkan bab $chapter';
  }

  @override
  String get downloadBookError =>
      'Buku ini tidak dapat diunduh. Periksa koneksi Anda lalu coba lagi.';

  @override
  String downloadBookOffline(int count) {
    return 'Unduh buku untuk membaca $count babnya secara offline.';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count puisi',
      one: '1 puisi',
    );
    return '$_temp0';
  }

  @override
  String get americanLiterature => 'Sastra Amerika';

  @override
  String get ancientChina => 'Tiongkok Kuno';

  @override
  String get britishLiterature => 'Sastra Britania';

  @override
  String get frenchLiterature => 'Sastra Prancis';

  @override
  String get germanLiterature => 'Sastra Jerman';

  @override
  String get italianLiterature => 'Sastra Italia';

  @override
  String get jinDynasty => 'Dinasti Jin';

  @override
  String get preQinEra => 'Masa Pra-Qin';

  @override
  String get qingDynasty => 'Dinasti Qing';

  @override
  String get republicOfChinaEra => 'Republik Tiongkok';

  @override
  String get russianLiterature => 'Sastra Rusia';

  @override
  String get spanishLiterature => 'Sastra Spanyol';

  @override
  String get springAndAutumn => 'Periode Musim Semi dan Gugur';

  @override
  String get westernHan => 'Han Barat';

  @override
  String get roleplayCreatorContextPlaceholder =>
      'mis., Jamuan meriah untuk merayakan sesuatu di Shanghai...';

  @override
  String get roleplayCreatorPersonaPlaceholder =>
      'mis., Sepupu yang penasaran dan bertanya tentang karier Anda...';

  @override
  String get beginFirstLesson => 'Mulai Pelajaran Pertama';

  @override
  String onboardingLessonProgress(Object current, Object total) {
    return 'PELAJARAN PERTAMA ANDA  •  $current DARI $total';
  }

  @override
  String get onboardingListenInstruction =>
      'Pertama, dengarkan salah satu bait paling terkenal dalam sastra Tionghoa. Belum perlu menghafal.';

  @override
  String get onboardingFromGrandLibrary => 'Dari Perpustakaan Agung';

  @override
  String get onboardingArtOfWarTitleAuthor => 'Seni Perang · Sun Tzu';

  @override
  String get onboardingArtOfWarChapter => '谋攻篇 · Bab 3';

  @override
  String get onboardingClassicLineLabel => 'BAIT KLASIK';

  @override
  String get onboardingArtOfWarTranslation =>
      '“Kenali musuhmu dan kenali dirimu sendiri, maka engkau tidak perlu takut dalam seratus pertempuran.”';

  @override
  String get onboardingNoticeMeaning =>
      'Kenali musuhmu dan kenali dirimu sendiri,';

  @override
  String get onboardingShadowMeaning =>
      'Engkau tidak akan terancam bahaya dalam seratus pertempuran.';

  @override
  String get onboardingPracticeThisLabel => 'ANDA AKAN MELATIH INI';

  @override
  String get onboardingFromArtOfWarLabel => 'DARI SENI PERANG';

  @override
  String get onboardingYourPronunciationLabel => 'PELAFALAN ANDA';

  @override
  String get onboardingTapACharacter => 'Ketuk aksara';

  @override
  String onboardingWordAndPinyin(String word, String pinyin) {
    return '$word · $pinyin';
  }

  @override
  String get onboardingToneMatched => 'Sesuai';

  @override
  String get onboardingCompareTones => 'Bandingkan nada';

  @override
  String get onboardingToneOneHigh => 'nada 1 · tinggi';

  @override
  String get onboardingToneTwoRising => 'nada 2 · naik';

  @override
  String get onboardingToneThreeDipping => 'nada 3 · meliuk';

  @override
  String get onboardingToneFourFalling => 'nada 4 · turun';

  @override
  String get onboardingToneNotDetected => 'tidak terdeteksi';

  @override
  String get onboardingFeedbackGreatThirdTone =>
      'Nada ketiga meliuk yang sangat baik.';

  @override
  String get onboardingFeedbackFourthToneFall =>
      'Biarkan nada keempat turun dengan tegas dan cepat.';

  @override
  String get onboardingFeedbackClearFourthTone =>
      'Nada keempat turun yang jelas.';

  @override
  String get onboardingFeedbackStrongFourthTone =>
      'Nada keempat turun yang kuat.';

  @override
  String onboardingTraceInstruction(
      String character, String pinyin, String meaning) {
    return 'Telusuri $character ($pinyin, “$meaning”). Ikuti panduan goresan samar.';
  }

  @override
  String billingDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hari',
    );
    return '$_temp0';
  }

  @override
  String billingWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minggu',
    );
    return '$_temp0';
  }

  @override
  String billingMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count bulan',
    );
    return '$_temp0';
  }

  @override
  String billingYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tahun',
    );
    return '$_temp0';
  }

  @override
  String startPeriodFreeTrial(String period) {
    return 'Mulai uji coba gratis $period';
  }

  @override
  String subscribeForPricePeriod(String price, String period) {
    return 'Berlangganan seharga $price / $period';
  }

  @override
  String eligibleTrialRenewalNotice(String price, String period) {
    return 'Produk StoreKit yang Anda pilih mencakup uji coba gratis yang memenuhi syarat. Setelah masa uji coba, langganan diperbarui seharga $price per $period kecuali dibatalkan.';
  }

  @override
  String pricePerPeriod(String price, String period) {
    return '$price / $period';
  }

  @override
  String get learn => 'Belajar';

  @override
  String get booksAndStudioQualityAudiobooks =>
      'Buku dan buku audio berkualitas studio';

  @override
  String get aiConversationsAndLiveToneFeedback =>
      'Percakapan AI dan umpan balik nada langsung';

  @override
  String get interactiveVideoAndWebImmersion =>
      'Video interaktif dan imersi web';

  @override
  String get characterInsightsAndHandwritingPractice =>
      'Wawasan karakter dan latihan menulis tangan';

  @override
  String get hskDecksAndSmartSpacedRepetition =>
      'Dek HSK dan pengulangan berjarak pintar';

  @override
  String get termsOfUseEula => 'Syarat Penggunaan (EULA)';

  @override
  String get masterEveryStroke => 'Kuasai setiap goresan';

  @override
  String get exploreTheChineseWeb => 'Jelajahi web Tiongkok';

  @override
  String get tone1Description =>
      'Pertahankan nada Anda tinggi dan stabil seperti menyanyikan sebuah not.';

  @override
  String get tone2Description =>
      'Mulai dari tengah dan geser nada Anda ke atas seperti bertanya \'Apa?\'';

  @override
  String get tone3Description =>
      'Turunkan suara Anda rendah, lalu naikkan kembali perlahan.';

  @override
  String get tone4Description =>
      'Jatuhkan nada Anda dengan tajam dan tegas seperti \'Tidak!\' yang mantap.';

  @override
  String get toneNeutralDescription =>
      'Ucapkan dengan lembut, singkat, dan tanpa penekanan.';

  @override
  String get toneDiagMatch1 => 'Tepat sekali! Nada tinggi, datar, dan stabil.';

  @override
  String get toneDiagMatch2 => 'Tepat sekali! Kenaikan nada jelas.';

  @override
  String get toneDiagMatch3 => 'Tepat sekali! Kurva menurun rendah akurat.';

  @override
  String get toneDiagMatch4 =>
      'Tepat sekali! Penurunan tajam sangat menentukan.';

  @override
  String get toneDiagMatchDefault =>
      'Tepat sekali! Nada diucapkan dengan akurat.';

  @override
  String get toneDiag1vs2 =>
      'Anda menaikkan nada (nada ke-2 /). Pertahankan suara Anda datar dan tinggi di seluruh suku kata (nada ke-1 ˉ).';

  @override
  String get toneDiag1vs3 =>
      'Anda menurunkan suara Anda (nada ke-3 ˇ). Pertahankan nada Anda stabil dan tinggi tanpa menurun (nada ke-1 ˉ).';

  @override
  String get toneDiag1vs4 =>
      'Anda menurunkan nada Anda (nada ke-4 \\). Pertahankan nada tinggi dan rata seperti menyanyikan sebuah not (nada ke-1 ˉ).';

  @override
  String get toneDiag2vs1 =>
      'Anda tetap datar (nada ke-1 ˉ). Geser nada Anda ke atas seperti bertanya \'Apa?\' (nada ke-2 /).';

  @override
  String get toneDiag2vs3 =>
      'Anda terlalu dalam menurun (nada ke-3 ˇ). Mulai dari tingkat menengah dan naik dengan mulus tanpa menyentuh dasar (nada ke-2 /).';

  @override
  String get toneDiag2vs4 =>
      'Anda menurunkan nada Anda (nada ke-4 \\). Naik ke atas seperti mengajukan pertanyaan (nada ke-2 /).';

  @override
  String get toneDiag3vs1 =>
      'Anda tetap tinggi dan datar (nada ke-1 ˉ). Biarkan nada Anda turun rendah ke register dada Anda sebelum naik (nada ke-3 ˇ).';

  @override
  String get toneDiag3vs2 =>
      'Anda langsung naik (nada ke-2 /). Pastikan untuk turun rendah terlebih dahulu sebelum naik kembali (nada ke-3 ˇ).';

  @override
  String get toneDiag3vs4 =>
      'Anda turun tajam tanpa naik (nada ke-4 \\). Biarkan nada Anda memantul lembut kembali di akhir (nada ke-3 ˇ).';

  @override
  String get toneDiag4vs1 =>
      'Anda tetap datar (nada ke-1 ˉ). Turunkan nada Anda dengan tajam dan tegas seperti \'Tidak!\' yang tegas (nada ke-4 \\).';

  @override
  String get toneDiag4vs2 =>
      'Anda menaikkan nada Anda (nada ke-2 /). Mulai tinggi dan turun tajam ke bawah (nada ke-4 \\).';

  @override
  String get toneDiag4vs3 =>
      'Anda menurun dan naik (nada ke-3 ˇ). Turun lurus ke bawah tanpa naik kembali (nada ke-4 \\).';

  @override
  String get toneDiagListenDiff =>
      'Dengarkan 4 nada di bawah untuk mendengar perbedaannya.';

  @override
  String get liveCallSpeaking => 'Sedang berbicara...';

  @override
  String get toneAccurate => 'Nada Tepat';

  @override
  String get toneNeedsWork => 'Nada Perlu Latihan';

  @override
  String get liveCallSessionCompletedFallback =>
      'Sesi selesai. Pada latihan berikutnya, ucapkan kalimat lengkap untuk menerima diagnostik pengucapan dan nada yang mendalam.';

  @override
  String liveCallGoodStartPracticingWord(String word) {
    return 'Awal yang baik berlatih \'$word\'. Pada sesi berikutnya, cobalah merangkai kalimat lengkap untuk melatih transisi nada dan kelancaran alami.';
  }

  @override
  String get liveCallSolidEffortFallback =>
      'Upaya percakapan yang solid. Fokuslah menjaga nada ke-1 tetap tinggi dan rata (55) serta nada ke-4 tajam dan tegas (51) untuk meningkatkan kejelasan alami.';

  @override
  String get liveCallGoodPracticeFallback =>
      'Sesi latihan yang bagus. Lanjutkan fokus pada kontras tinggi nada yang jelas dan tempo percakapan yang alami.';
}
