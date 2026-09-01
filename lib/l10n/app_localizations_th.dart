// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get originStoryChip => '📜 ที่มาของตัวอักษร';

  @override
  String get ancientFormChip => '🏺 รูปแบบโบราณ';

  @override
  String get threeMoreWordsChip => '📖 เพิ่มอีก 3 คำ';

  @override
  String get wordFamilyChip => '🔗 ตระกูลคำศัพท์';

  @override
  String get idiomChip => '🀄 สำนวนจีน';

  @override
  String get proverbChip => '💬 สุภาษิต';

  @override
  String get strokeOrderChip => '✏️ ลำดับขีด';

  @override
  String get calligraphyTipChip => '🎨 เคล็ดลับการเขียนพู่กัน';

  @override
  String get grammarNoteChip => '📝 ไวยากรณ์น่ารู้';

  @override
  String get similarWordsChip => '🔄 คำที่มีความหมายใกล้เคียง';

  @override
  String get culturalNoteChip => '🏮 เกร็ดวัฒนธรรม';

  @override
  String get inMediaChip => '🀄 ในสื่อและบริบทจริง';

  @override
  String get radicalMeaningChip => '🧩 ความหมายหมวดอักษร';

  @override
  String get componentBreakdownChip => '🔍 แยกส่วนประกอบอักษร';

  @override
  String get toneTipChip => '🎵 เทคนิคจำวรรณยุกต์';

  @override
  String get homophonesChip => '👯 คำพ้องเสียง';

  @override
  String askMeAnythingAbout(String hanzi) {
    return 'ถามอะไรก็ได้เกี่ยวกับ $hanzi...';
  }

  @override
  String aiTutorError(String error) {
    return 'เกิดข้อผิดพลาดจากติวเตอร์ AI: $error';
  }

  @override
  String get aiTutorRateLimit =>
      'ขณะนี้ติวเตอร์ AI กำลังให้บริการจำนวนมาก กรุณารอสักครู่แล้วลองใหม่อีกครั้ง';

  @override
  String get deleteAccount => 'ลบบัญชีผู้ใช้';

  @override
  String get deleteAccountSubtitle => 'ลบบัญชีของคุณอย่างถาวร';

  @override
  String get deleteAccountTitle => 'ต้องการลบบัญชีของคุณอย่างถาวรหรือไม่?';

  @override
  String get accountDataDeletedTitle => 'ข้อมูลบัญชีจะถูกลบ';

  @override
  String get accountDataDeletedBody =>
      'บัญชีที่เข้าสู่ระบบและข้อมูลบัญชีของคุณที่บันทึกไว้ใน SinoSpark จะถูกลบอย่างถาวร การดำเนินการนี้ไม่สามารถยกเลิกได้';

  @override
  String get localDataKeptTitle => 'ข้อมูลในอุปกรณ์นี้จะยังคงอยู่';

  @override
  String get localDataKeptBody =>
      'ความคืบหน้าในการเรียน เนื้อหาที่ดาวน์โหลด และการตั้งค่าที่บันทึกไว้เฉพาะในอุปกรณ์นี้จะไม่ถูกลบออก';

  @override
  String get subscriptionNotCanceledTitle => 'การสมัครสมาชิกจะไม่ถูกยกเลิก';

  @override
  String get subscriptionNotCanceledBody =>
      'การลบบัญชีไม่ได้เป็นการยกเลิกการสมัครสมาชิกบน App Store การต่ออายุอาจดำเนินต่อไปจนกว่าคุณจะยกเลิกกับทาง Apple';

  @override
  String get manageSubscription => 'จัดการการสมัครสมาชิก App Store';

  @override
  String get subscriptionManagementFailed =>
      'ไม่สามารถเปิดหน้าจัดการการสมัครสมาชิกของ Apple ได้ กรุณาไปที่ \'การตั้งค่า\' > แตะที่ชื่อของคุณ > แตะ \'การสมัครสมาชิก\'';

  @override
  String get confirmPassword => 'รหัสผ่านปัจจุบัน';

  @override
  String get confirmPasswordToDelete => 'ป้อนรหัสผ่านเพื่อยืนยันตัวตนของคุณ';

  @override
  String get deleteAccountPermanently => 'ลบบัญชีถาวร';

  @override
  String get deleteAccountFinalTitle => 'ยืนยันขั้นตอนสุดท้าย';

  @override
  String get deleteAccountFinalWarning =>
      'การดำเนินการนี้จะลบบัญชีของคุณอย่างถาวรและไม่สามารถเรียกคืนได้ ข้อมูลที่เก็บไว้ในอุปกรณ์นี้เท่านั้นที่จะยังคงอยู่ ต้องการดำเนินการต่อหรือไม่?';

  @override
  String get deletingAccount => 'กำลังลบบัญชี...';

  @override
  String get accountPasswordRequired =>
      'กรุณากรอกรหัสผ่านปัจจุบันเพื่อดำเนินการต่อ';

  @override
  String get accountPasswordIncorrect =>
      'รหัสผ่านไม่ถูกต้อง กรุณาลองใหม่อีกครั้ง';

  @override
  String get accountReauthenticationCanceled =>
      'การยืนยันตัวตนถูกยกเลิก บัญชีของคุณยังไม่ถูกลบ';

  @override
  String get accountReauthenticationFailed =>
      'ไม่สามารถยืนยันตัวตนของคุณได้ กรุณาลองใหม่อีกครั้งและเข้าสู่ระบบตามขั้นตอน';

  @override
  String get accountAlreadySignedOut =>
      'คุณออกจากระบบแล้ว ไม่มีบัญชีที่เข้าสู่ระบบถูกลบ';

  @override
  String get accountProviderUnsupported =>
      'ไม่สามารถยืนยันวิธีการเข้าสู่ระบบนี้ภายในแอปได้ กรุณาติดต่อฝ่ายสนับสนุนเพื่อขอลบบัญชี';

  @override
  String get appleDeletionRequiresAppleDevice =>
      'เพื่อความปลอดภัย บัญชีที่เชื่อมโยงกับ Apple จะต้องดำเนินการลบบนอุปกรณ์ Apple';

  @override
  String get accountDeletionNetworkError =>
      'กรุณาตรวจสอบการเชื่อมต่ออินเทอร์เน็ตและลองลบบัญชีอีกครั้ง';

  @override
  String get accountDeletionFailed =>
      'ไม่สามารถลบบัญชีได้ บัญชีของคุณยังคงใช้งานได้ตามปกติ กรุณาลองใหม่อีกครั้ง';

  @override
  String get accountDeletedSuccessfully =>
      'ลบบัญชีของคุณอย่างถาวรเรียบร้อยแล้ว';

  @override
  String get globalMastery => 'ความเชี่ยวชาญโดยรวม';

  @override
  String get masteredCards => 'เชี่ยวชาญแล้ว';

  @override
  String get hsk1Candidate => 'ผู้เตรียมสอบ HSK 1';

  @override
  String get hsk2Candidate => 'ผู้เตรียมสอบ HSK 2';

  @override
  String get hsk3Candidate => 'ผู้เตรียมสอบ HSK 3';

  @override
  String get hsk4Candidate => 'ผู้เตรียมสอบ HSK 4';

  @override
  String get hsk5Candidate => 'ผู้เตรียมสอบ HSK 5';

  @override
  String get hsk6Candidate => 'ผู้เตรียมสอบ HSK 6';

  @override
  String get hsk6Master => 'ผู้เชี่ยวชาญระดับ HSK 6';

  @override
  String get currentRank => 'อันดับปัจจุบัน';

  @override
  String get next => 'ถัดไป';

  @override
  String get searchHanziOrPinyin => 'ค้นหาตัวอักษรจีนหรือพินอิน...';

  @override
  String get dailyReview => 'ทบทวนประจำวัน';

  @override
  String get upcomingForecast => 'กำหนดการทบทวน';

  @override
  String get laterToday => 'วันนี้ในภายหลัง';

  @override
  String get tomorrow => 'พรุ่งนี้';

  @override
  String get next7Days => '7 วันข้างหน้า';

  @override
  String get theScholarWay => 'วิถีแห่งบัณฑิต';

  @override
  String get beginJourney => 'เริ่มต้นการเดินทาง';

  @override
  String get settingsTitle => 'การตั้งค่า';

  @override
  String get darkMode => 'โหมดมืด';

  @override
  String get darkModeDesc => 'สบายตา';

  @override
  String get voiceSpeed => 'ความเร็วเสียง';

  @override
  String get artAndIntellect => 'ศิลปะและปัญญา';

  @override
  String get theDigitalScholar => 'บัณฑิตดิจิทัล';

  @override
  String get refineBrushVoice => 'ฝึกฝนการเขียนและสำเนียงด้วย AI ขั้นสูง';

  @override
  String get liveVoiceCall => 'สนทนาเสียงสด';

  @override
  String get immersiveRoleplay => 'จำลองบทบาทสมจริงกับอวาตาร์ AI';

  @override
  String get readingRoom => 'ห้องอ่านหนังสือ';

  @override
  String get shadowingStudio => 'สตูดิโอฝึกพูดตาม (Shadowing)';

  @override
  String get errorPrefix => 'ข้อผิดพลาด: ';

  @override
  String get initializingLibrary => 'กำลังเตรียมคลังความรู้...';

  @override
  String get unlockCharactersToQuiz =>
      'ปลดล็อกตัวอักษรอย่างน้อย 4 ตัวเพื่อเริ่มทำแบบทดสอบ!';

  @override
  String get practiceQuiz => 'แบบทดสอบฝึกฝน';

  @override
  String get curriculumPaths => 'เส้นทางการเรียนรู้';

  @override
  String get noDecksFound => 'ไม่พบสำรับคำศัพท์ เพิ่มสำรับลงในคลังของคุณเลย!';

  @override
  String get addCardsFirst => 'เพิ่มการ์ดลงในสำรับนี้ก่อน!';

  @override
  String get aiDraftingPath => 'บัณฑิต AI กำลังออกแบบเส้นทางการเรียนให้คุณ...';

  @override
  String get pathReady => 'เส้นทางการเรียนของคุณพร้อมแล้ว!';

  @override
  String get errorGeneratingPath => 'เกิดข้อผิดพลาดในการสร้างเส้นทาง';

  @override
  String get brushingCurriculum => 'กำลังจัดเตรียมหลักสูตร...';

  @override
  String get warmUp => 'อบอุ่นร่างกาย';

  @override
  String get lessonComplete => 'จบบทเรียนแล้ว! +10 แต้มน้ำหมึก';

  @override
  String get step1Origin => 'ขั้นตอนที่ 1: ต้นกำเนิด';

  @override
  String get traceRadical => 'ลากเส้นตามหมวดอักษร';

  @override
  String get step2Forge => 'ขั้นตอนที่ 2: หลอมรวม';

  @override
  String get chooseEssence => 'เลือกหัวใจสำคัญ';

  @override
  String get wrongEssence => 'ไม่ใช่หัวใจสำคัญที่ถูกต้อง! ลองใหม่อีกครั้ง';

  @override
  String get step3Hunt => 'ขั้นตอนที่ 3: ค้นหา';

  @override
  String get findCharacters => 'ค้นหาตัวอักษร';

  @override
  String get notThatOne => 'ยังไม่ใช่ตัวนี้! ลองดูให้ละเอียดอีกที';

  @override
  String get successfullyInstalled => 'ติดตั้งสำเร็จแล้ว';

  @override
  String get failedToDownload => 'ดาวน์โหลดโมดูลไม่สำเร็จ';

  @override
  String get rescindTitle => 'ต้องการยกเลิกหรือไม่?';

  @override
  String get removeCharactersWarning =>
      'การดำเนินการนี้จะลบตัวอักษรเหล่านี้ออกจากคลังและรีเซ็ตความคืบหน้าความเชี่ยวชาญของคุณ';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get uninstall => 'ถอนการติดตั้ง';

  @override
  String get removedLibrary => 'ลบออกจากคลังแล้ว';

  @override
  String get tomeLibrary => 'คลังตำรา';

  @override
  String get libraryError => 'ข้อผิดพลาดของคลังตำรา';

  @override
  String get installTome => 'ติดตั้งตำรา';

  @override
  String get unitIntro => 'บทนำประจำหน่วย';

  @override
  String get constellationCluster => 'กลุ่มดาวอักษร';

  @override
  String get ok => 'ตกลง';

  @override
  String get divingInto => 'กำลังเข้าสู่...';

  @override
  String get keyRadicals => 'หมวดอักษรสำคัญ';

  @override
  String get noRadicalData => 'ไม่มีข้อมูลหมวดอักษร';

  @override
  String get discovery => 'ค้นพบ';

  @override
  String get startLearning => 'เริ่มเรียนรู้';

  @override
  String get selectPersona => 'เลือกตัวละคร AI';

  @override
  String get customPersona => 'ตัวละครกำหนดเอง';

  @override
  String get geminiLiveCall => 'สนทนาสดกับ GEMINI';

  @override
  String get returnToMenu => 'กลับสู่เมนู';

  @override
  String get strokeAnalysis => 'วิเคราะห์ลำดับขีด';

  @override
  String get excellentWork => 'ยอดเยี่ยมมาก!';

  @override
  String get keepPracticing => 'ฝึกฝนต่อไป!';

  @override
  String get drawingSubmitted => 'ส่งผลงานเขียนแล้ว';

  @override
  String get customPersonaHint =>
      'บุคลิกตัวละคร AI (เช่น เพื่อนร่วมงานช่างสงสัย)';

  @override
  String get stepOneOrigin => 'ขั้นตอนที่ 1: ต้นกำเนิด';

  @override
  String get stepTwoForge => 'ขั้นตอนที่ 2: หลอมรวม';

  @override
  String get toForge => 'ในการหลอมรวม';

  @override
  String get whatEssenceDoesNeed => 'ต้องการหัวใจสำคัญใดสำหรับ';

  @override
  String get need => 'ต้องการ';

  @override
  String get forged => 'หลอมรวมสำเร็จ';

  @override
  String get stepThreeHunt => 'ขั้นตอนที่ 3: ค้นหา';

  @override
  String get findCharactersWith => 'ค้นหาตัวอักษรที่มี';

  @override
  String get uninstallButton => 'ถอนการติดตั้ง';

  @override
  String get gradedAiStories => 'นิทาน AI ตามระดับความยาก';

  @override
  String get calligraphy => 'การเขียนพู่กันจีน';

  @override
  String get theScrollOfOrigin => 'ม้วนคัมภีร์ต้นกำเนิด';

  @override
  String get galaxyOf => 'กาแล็กซีแห่ง';

  @override
  String get constellationDescription => 'คำอธิบายกลุ่มดาว';

  @override
  String get noRadicalDataAvailable => 'ไม่มีข้อมูลหมวดอักษร';

  @override
  String get learningPreferences => 'การตั้งค่าการเรียนรู้';

  @override
  String get hardMode => 'โหมดท้าทาย';

  @override
  String get hardModeDesc => 'เพิ่มความท้าทายในการทดสอบโดยลดคำใบ้';

  @override
  String get adaptiveGuidance => 'คำแนะนำแบบปรับตามผู้เรียน';

  @override
  String get dailyGoal => 'เป้าหมายรายวัน';

  @override
  String get audioAndHaptics => 'เสียงและการสั่น';

  @override
  String get autoPlayAudio => 'เล่นเสียงอัตโนมัติ';

  @override
  String get autoPlayDesc => 'เล่นเสียงการออกเสียงโดยอัตโนมัติเมื่อเปิดการ์ด';

  @override
  String get haptics => 'การสั่นตอบสนอง';

  @override
  String get displayAndContent => 'การแสดงผลและเนื้อหา';

  @override
  String get useEnglishDefinitions => 'ใช้คำแปลภาษาอังกฤษ';

  @override
  String get useEnglishDefinitionsDesc =>
      'คำแปลภาษาอังกฤษมักจะละเอียดและครอบคลุมมากกว่า';

  @override
  String get animationSpeed => 'ความเร็วแอนิเมชัน';

  @override
  String get manageTomes => 'จัดการตำรา';

  @override
  String get manageTomesDesc => 'ดาวน์โหลด ลบ หรืออัปเดตโมดูลบทเรียนของคุณ';

  @override
  String get dangerZone => 'พื้นที่อันตราย';

  @override
  String get resetAllData => 'รีเซ็ตข้อมูลทั้งหมด';

  @override
  String get resetDataDesc => 'ล้างความคืบหน้าและการตั้งค่าทั้งหมดบนอุปกรณ์นี้';

  @override
  String get areYouSure => 'คุณแน่ใจหรือไม่';

  @override
  String get cannotBeUndone => 'ไม่สามารถเรียกคืนข้อมูลได้';

  @override
  String get deleteEverything => 'ลบข้อมูลทั้งหมด';

  @override
  String get appLanguage => 'ภาษาของแอป';

  @override
  String get howDidYouDo => 'ทำได้ดีแค่ไหน?';

  @override
  String get missedItEntirely => 'จำไม่ได้เลย';

  @override
  String get gotItButStruggled => 'จำได้แต่นึกนาน';

  @override
  String get gotItClearly => 'จำได้แม่นยำ';

  @override
  String get perfectAndImmediate => 'จำได้ทันทีและสมบูรณ์แบบ';

  @override
  String get again => 'เริ่มใหม่';

  @override
  String get hard => 'ยาก';

  @override
  String get good => 'ดี';

  @override
  String get easy => 'ง่าย';

  @override
  String get tapToReveal => 'แตะเพื่อดูเฉลย';

  @override
  String get howWellDidYouRemember => 'คุณจำได้ดีเพียงใด?';

  @override
  String get completelyForgot => 'ลืมสนิท';

  @override
  String get gotItWithDifficulty => 'นึกออกอย่างยากลำบาก';

  @override
  String get recalledCorrectly => 'นึกออกถูกต้อง';

  @override
  String get perfectRecall => 'จำได้แม่นยำไร้ที่ติ';

  @override
  String get practiceWriting => 'ฝึกเขียนอักษร';

  @override
  String get hideScratchpad => 'ซ่อนกระดานทดเขียน';

  @override
  String get whatCharacterMeans => 'ความหมายของตัวอักษรนี้:';

  @override
  String get tapCardToReveal => 'แตะการ์ดเพื่อดูเฉลย';

  @override
  String get ratePronunciationConfidence =>
      'ประเมินความมั่นใจในการออกเสียงของคุณ';

  @override
  String get botchedIt => 'ออกเสียงผิด';

  @override
  String get struggledWithTones => 'ติดขัดเรื่องวรรณยุกต์';

  @override
  String get acceptable => 'พอใช้ได้';

  @override
  String get perfectlyNatural => 'เป็นธรรมชาติสมบูรณ์แบบ';

  @override
  String get sessionComplete => 'เสร็จสิ้นการฝึกฝน!';

  @override
  String get accuracy => 'ความแม่นยำ';

  @override
  String get reviewed => 'ทบทวนแล้ว';

  @override
  String get correct => 'ถูกต้อง';

  @override
  String get backToLibrary => 'กลับสู่คลัง';

  @override
  String get revealAnswer => 'เฉลยคำตอบ';

  @override
  String get aiHubTitle => 'ศูนย์รวม AI';

  @override
  String get textChat => 'แชทข้อความ';

  @override
  String get scholarlyPersonas => 'ตัวละครบัณฑิต';

  @override
  String get shadowing => 'ฝึกพูดตาม (Shadowing)';

  @override
  String get liveTranslation => 'แปลสด';

  @override
  String get scholarsLibrary => 'คลังตำราบัณฑิต';

  @override
  String get generate => 'สร้าง';

  @override
  String get searchPinyinHanziEnglish =>
      'ค้นหาพินอิน ตัวอักษรจีน หรือภาษาอังกฤษ...';

  @override
  String get liveTranslate => 'แปลภาษาแบบสด';

  @override
  String get travelInterpreter => 'ล่ามพกพาสำหรับท่องเที่ยว';

  @override
  String get realTimeSplitScreen =>
      'สนทนาแบบแบ่งหน้าจอเรียลไทม์กับเจ้าของภาษา ทลายกำแพงภาษาได้ทันที';

  @override
  String get whisperEarpiece => 'หูฟังกระซิบคำแปล';

  @override
  String get listenToChineseAudio =>
      'ฟังเสียงภาษาจีนและรับคำบรรยายภาษาอังกฤษแบบเรียลไทม์บนหน้าจอของคุณ';

  @override
  String get dashboardTitle => 'แดชบอร์ด';

  @override
  String get yourMindIsClear => 'จิตใจของคุณปลอดโปร่ง';

  @override
  String get noReviewsDueToday => 'ไม่มีรายการทบทวนที่ต้องทำในวันนี้';

  @override
  String get done => 'เสร็จสิ้น';

  @override
  String get hskLevel1 => 'HSK ระดับ 1';

  @override
  String get hskLevel2 => 'HSK ระดับ 2';

  @override
  String get hskLevel3 => 'HSK ระดับ 3';

  @override
  String get hskLevel4 => 'HSK ระดับ 4';

  @override
  String get hskLevel5 => 'HSK ระดับ 5';

  @override
  String get hskLevel6 => 'HSK ระดับ 6';

  @override
  String get generalVocabulary => 'คำศัพท์ทั่วไป';

  @override
  String cardsRequireAttention(Object count) {
    return 'การ์ดที่ต้องทบทวนเป็นพิเศษ';
  }

  @override
  String get begin => 'เริ่มต้น';

  @override
  String get poweredByAi =>
      'ขับเคลื่อนด้วย AI ขั้นสูง แปลภาษาเรียลไทม์ได้อย่างลื่นไหลสำหรับทุกสถานการณ์';

  @override
  String get downloadingModel => 'กำลังดาวน์โหลดโมเดล...';

  @override
  String get soon => 'เร็วๆ นี้';

  @override
  String get installed => 'ติดตั้งแล้ว';

  @override
  String get premium => 'พรีเมียม';

  @override
  String get coreModule => 'โมดูลหลัก';

  @override
  String get step6Context => 'ขั้นตอนที่ 6: บริบทการใช้งาน';

  @override
  String get tapBuildingBlocksTo => 'แตะชิ้นส่วนประกอบเพื่อสำรวจที่มา';

  @override
  String get initiateRadicalSequence => 'เริ่มลำดับหมวดอักษร';

  @override
  String get holdToTalk => 'กดค้างเพื่อพูด';

  @override
  String get customScenario => 'สถานการณ์กำหนดเอง';

  @override
  String get voiceCall => 'โทรด้วยเสียง';

  @override
  String get pronunciation => 'การออกเสียง';

  @override
  String get selectAScenarioTo =>
      'เลือกสถานการณ์เพื่อฝึกพูดภาษาจีนกลาง บัณฑิต AI จะประเมินวรรณยุกต์และความชัดเจนของคุณ';

  @override
  String get create => 'สร้าง';

  @override
  String get createYourScenario => 'สร้างสถานการณ์ของคุณ';

  @override
  String get difficulty => 'ระดับความยาก';

  @override
  String get scholarsVerdict => 'คำตัดสินของบัณฑิต';

  @override
  String get completeReview => 'ทบทวนให้เสร็จสมบูรณ์';

  @override
  String get conversationReview => 'ทบทวนบทสนทนา';

  @override
  String get linguisticAnalysis => 'การวิเคราะห์ทางภาษาศาสตร์';

  @override
  String get examplesInHsk1 => 'ตัวอย่างใน HSK 1';

  @override
  String get characterReference => 'ข้อมูลอ้างอิงตัวอักษร';

  @override
  String get askTutor => 'ถามติวเตอร์';

  @override
  String get addToStudyDeck => 'เพิ่มลงในสำรับการเรียน';

  @override
  String get startPractice => 'เริ่มฝึกฝน';

  @override
  String get noOtherHsk1 => 'ไม่มีตัวอักษร HSK 1 อื่นที่ใช้หมวดอักษรนี้';

  @override
  String get couldNotLoadAi =>
      'ไม่สามารถโหลดบริบท AI ได้ (เกินขีดจำกัดการใช้งานหรือเกิดข้อผิดพลาดของเครือข่าย)\nแตะปุ่มรีเฟรชด้านล่างเพื่อลองใหม่ภายหลัง';

  @override
  String get noAvailableCardsFound => 'ไม่พบการ์ดที่พร้อมใช้งาน';

  @override
  String get addCards => 'เพิ่มการ์ด';

  @override
  String get removeCard => 'ลบการ์ด';

  @override
  String get remove => 'ลบออก';

  @override
  String get review => 'ทบทวน';

  @override
  String get story => 'เรื่องราว';

  @override
  String get thisDeckIsEmpty => 'สำรับนี้ว่างเปล่า';

  @override
  String get tapTheAddCards => 'แตะปุ่มเพิ่มการ์ด!';

  @override
  String get noCardsFound => 'ไม่พบการ์ด';

  @override
  String get addCardsToSee => 'เพิ่มการ์ดเพื่อดูสถิติ';

  @override
  String get aiGenerated => 'สร้างโดย AI';

  @override
  String get allCardsCaughtUp => 'ทบทวนการ์ดครบหมดแล้ว! เยี่ยมมาก';

  @override
  String get latestDiscoveries => 'การค้นพบล่าสุด';

  @override
  String get noCharactersInLexicon => 'ยังไม่มีตัวอักษรในคลังคำศัพท์';

  @override
  String get yourBookshelf => 'ชั้นหนังสือของคุณ';

  @override
  String get text_1782026184579 => '字';

  @override
  String get searchYourDictionary => 'ค้นหาในพจนานุกรมของคุณ...';

  @override
  String get saveCard => 'บันทึกการ์ด';

  @override
  String get noCharactersFound => 'ไม่พบตัวอักษร';

  @override
  String get radicalsIndex => 'ดัชนีหมวดอักษร';

  @override
  String get masteringRadicalsIsThe =>
      'การเชี่ยวชาญหมวดอักษรเป็นกุญแจสำคัญในการปลดล็อกตัวอักษรจีนนับพันตัว เลือกหมวดอักษรเพื่อดูตัวอักษรทั้งหมดที่ใช้หมวดนี้';

  @override
  String get noRadicalsFound => 'ไม่พบหมวดอักษร';

  @override
  String get yourDrawing => 'ภาพวาดของคุณ';

  @override
  String get reference => 'ข้อมูลอ้างอิง';

  @override
  String get rateYourRecall => 'ประเมินความจำของคุณ';

  @override
  String get contactUs => 'ติดต่อเรา';

  @override
  String get reportBugsOrRequest => 'รายงานข้อผิดพลาดหรือแนะนำฟีเจอร์';

  @override
  String get allDataHasBeen => 'ข้อมูลทั้งหมดถูกล้างเรียบร้อยแล้ว';

  @override
  String get hanziMasterV100 => 'SinoSpark v1.0.0';

  @override
  String get myProgress => 'ความคืบหน้าของฉัน';

  @override
  String get overview => 'ภาพรวม';

  @override
  String get aiStory => 'นิทาน AI';

  @override
  String get usingYourDecksVocabulary => 'ใช้คำศัพท์จากสำรับของคุณ';

  @override
  String get tryAgain => 'ลองใหม่อีกครั้ง';

  @override
  String get translate => 'แปล';

  @override
  String get pinyin => 'พินอิน';

  @override
  String get fullTranslation => 'คำแปลฉบับเต็ม';

  @override
  String get geminiFlashIsStructuring => 'กำลังรังสรรค์นิทานสำหรับคุณ...';

  @override
  String get aiDeckGenerator => 'เครื่องมือสร้างสำรับด้วย AI';

  @override
  String get whatDoYouWant => 'คุณต้องการเรียนรู้อะไร?';

  @override
  String get targetDifficulty => 'ระดับความยากเป้าหมาย';

  @override
  String get focusArea => 'หัวข้อที่ต้องการเน้น';

  @override
  String get specificContextOrTone => 'บริบทเฉพาะหรือน้ำเสียง (ไม่บังคับ)';

  @override
  String get numberOfCards => 'จำนวนการ์ด';

  @override
  String get generateDeck => 'สร้างสำรับ';

  @override
  String get aiGrammarExplanation => 'คำอธิบายไวยากรณ์ด้วย AI';

  @override
  String get scholarsDesk => 'โต๊ะบัณฑิต';

  @override
  String get chooseADeck => 'เลือกสำรับ';

  @override
  String get whereWouldYouLike => 'คุณต้องการบันทึกตัวอักษรนี้ไว้ที่ไหน?';

  @override
  String get addToDefaultStudy => 'เพิ่มลงในสำรับการเรียนหลัก';

  @override
  String get ifOffItsOnly => 'หากปิดไว้ จะบันทึกลงในพจนานุกรมรวมเท่านั้น';

  @override
  String get saveToLibrary => 'บันทึกลงคลัง';

  @override
  String get pleaseEnterValidChinese => 'กรุณากรอกตัวอักษรจีนที่ถูกต้อง';

  @override
  String get reviewAiCard => 'ตรวจสอบการ์ด AI';

  @override
  String get pleaseDoublecheckTheAis =>
      'โปรดตรวจสอบข้อมูลที่ AI สร้างขึ้นด้านล่าง คุณสามารถปรับแต่งพินอินหรือคำแปลได้ก่อนบันทึกลงในคลังถาวรของคุณ';

  @override
  String get alreadyInYourLibrary => 'มีอยู่ในคลังของคุณแล้ว!';

  @override
  String get meaningInContext => 'ความหมายตามบริบท';

  @override
  String get explainGrammar => 'อธิบายไวยากรณ์';

  @override
  String get addToLibrary => 'เพิ่มลงในคลัง';

  @override
  String get masterYourMandarinPronunciation =>
      'ฝึกฝนการออกเสียงภาษาจีนกลางให้เชี่ยวชาญด้วยการเลียนแบบเสียงเจ้าของภาษาแบบเรียลไทม์';

  @override
  String get startSession => 'เริ่มเซสชัน';

  @override
  String get sessionHistory => 'ประวัติเซสชัน';

  @override
  String get noSavedSessions => 'ไม่มีเซสชันที่บันทึกไว้';

  @override
  String get aiBreakdown => 'การวิเคราะห์โดย AI';

  @override
  String get sessionDetails => 'รายละเอียดเซสชัน';

  @override
  String partner(Object lang) {
    return 'คู่สนทนา (中文)';
  }

  @override
  String get youEnglish => 'คุณ (English)';

  @override
  String get noTranscriptToSave => 'ไม่มีบทสนทนาที่จะบันทึก!';

  @override
  String get sessionSaved => 'บันทึกเซสชันเรียบร้อยแล้ว!';

  @override
  String get realtimeBidirectionalTranslationSpeak =>
      'การแปลสองทางแบบเรียลไทม์ พูดภาษาอังกฤษหรือภาษาจีนกลาง แล้วระบบจะแปลให้คุณและคู่สนทนาทันที';

  @override
  String get text_1782026184665 => '录音中';

  @override
  String get recording => 'กำลังบันทึกเสียง';

  @override
  String get yourSilentCompanionListen =>
      'ผู้ช่วยแปลภาษาข้างกายคุณ ฟังภาษาจีนกลางและรับฟังคำแปลภาษาอังกฤษได้ทันที';

  @override
  String get startListening => 'เริ่มฟัง';

  @override
  String get skip => 'ข้าม';

  @override
  String get independentStars => 'ดวงดาวอิสระ';

  @override
  String get notEveryCharacterHas =>
      'ไม่ใช่ทุกตัวอักษรที่จะมีหมวดอักษรหลัก บางตัวเป็นอักษรภาพที่มีเอกลักษณ์เฉพาะตัวหรือยืนเดี่ยวได้';

  @override
  String get onTheMapWe =>
      'บนแผนที่ เราจัดกลุ่มตัวอักษรอิสระเหล่านี้เป็น กลุ่มดาว (✨)';

  @override
  String get iUnderstand => 'ฉันเข้าใจแล้ว';

  @override
  String get whatAreRadicals => 'หมวดอักษรจีน (Radicals) คืออะไร?';

  @override
  String get hanziAreBuiltFrom =>
      'ตัวอักษรจีนประกอบขึ้นจากชิ้นส่วนพื้นฐานที่เรียกว่า หมวดนำอักษร (Radicals)\n\nชิ้นส่วนเหล่านี้จะกำหนดความหมายหลักหรือหมวดหมู่ของตัวอักษร';

  @override
  String get continueText => 'ดำเนินการต่อ';

  @override
  String get hanziAreNotJust =>
      'อักษรจีนไม่ได้เป็นเพียงแค่ตัวหนังสือ แต่คือภาพวาดที่หยุดเวลาไว้\n\nหากต้องการเชี่ยวชาญ คุณต้องเรียนรู้ที่จะลากเส้นตามลำดับที่ถูกต้อง';

  @override
  String get iAmReady => 'ฉันพร้อมแล้ว';

  @override
  String get youAreAScholar => 'คุณคือนักปราชญ์';

  @override
  String get theGalaxyMapAwaitsnmaster =>
      'แผนที่กาแล็กซีกำลังรอคุณอยู่\nฝึกฝนดวงอาทิตย์ (หมวดอักษร) ให้เชี่ยวชาญเพื่อปลดล็อกดวงดาว (ตัวอักษร)';

  @override
  String get enterTheScroll => 'เข้าสู่ม้วนคัมภีร์';

  @override
  String get openingTheOriginScroll => 'กำลังเปิดม้วนคัมภีร์ต้นกำเนิด...';

  @override
  String get text_1782026184670 => '+';

  @override
  String get theScholarsEdition => 'ฉบับบัณฑิต (The Scholar\'s Edition)';

  @override
  String get weArePreparingThe =>
      'เรากำลังเตรียมเปิดตัว The Scholar\'s Edition เร็วๆ นี้';

  @override
  String get devBypassUnlockNow => 'โหมดนักพัฒนา: ปลดล็อกทันที';

  @override
  String get restorePurchases => 'กู้คืนรายการสั่งซื้อ';

  @override
  String get welcomeScholarTheScroll =>
      'ยินดีต้อนรับท่านบัณฑิต ม้วนคัมภีร์เปิดกว้างสำหรับคุณแล้ว';

  @override
  String get purchasesRestoredSuccessfully => 'กู้คืนรายการสั่งซื้อสำเร็จแล้ว';

  @override
  String get noPreviousPurchasesFound =>
      'ไม่พบประวัติการสั่งซื้อสำหรับบัญชีนี้';

  @override
  String get unlockTheFullPotential =>
      'ปลดล็อกศักยภาพเต็มรูปแบบของการเดินทาง จ่ายครั้งเดียว เป็นเจ้าของตลอดชีพ';

  @override
  String get universalScanner => 'สแกนเนอร์อเนกประสงค์';

  @override
  String get noChineseCharactersFound => 'ไม่พบตัวอักษรจีนในรูปภาพ';

  @override
  String get addedNewCharactersTo => 'เพิ่มตัวอักษรใหม่ลงในคลังของคุณแล้ว!';

  @override
  String get extractingTextAndObjects => 'กำลังแยกข้อความและวัตถุ...';

  @override
  String get scanATextbookSign =>
      'สแกนหนังสือเรียน ป้าย หรือวัตถุ เพื่อสกัดตัวอักษรจีน';

  @override
  String get extractedText => 'ข้อความที่สกัดได้';

  @override
  String get useText => 'ใช้ข้อความนี้';

  @override
  String get noMatchingDictionaryEntries => 'ไม่พบคำศัพท์ที่ตรงกันในพจนานุกรม';

  @override
  String get quizComplete => 'ทำแบบทดสอบเสร็จสมบูรณ์!';

  @override
  String get returnToCourse => 'กลับสู่คอร์สเรียน';

  @override
  String get notEnoughCardsFor =>
      'การ์ดไม่เพียงพอสำหรับทำแบบทดสอบ! ต้องมีอย่างน้อย 4 ใบ';

  @override
  String get creatorMode => 'โหมดผู้สร้าง';

  @override
  String get noStoriesFoundMatching => 'ไม่พบนิทานที่ตรงกับการค้นหาของคุณ';

  @override
  String get discard => 'ละทิ้ง';

  @override
  String get save => 'บันทึก';

  @override
  String get generatingStoryViaDeepseek => 'กำลังสร้างนิทานผ่าน DeepSeek...';

  @override
  String get storySavedToLibrary => 'บันทึกนิทานลงในคลังแล้ว!';

  @override
  String get storyNotFound => 'ไม่พบนิทาน';

  @override
  String get targetHskLevel => 'ระดับ HSK เป้าหมาย';

  @override
  String get wedLoveToHear => 'เราอยากฟังความคิดเห็นจากคุณ!';

  @override
  String get whetherYouveFoundA =>
      'ไม่ว่าคุณจะพบข้อผิดพลาด มีข้อเสนอแนะเกี่ยวกับฟีเจอร์ หรือเพียงแค่อยากทักทาย ทุกความคิดเห็นช่วยให้เราพัฒนา SinoSpark ให้ดียิ่งขึ้น';

  @override
  String get pointYourCameraAt => 'ชี้กล้องของคุณไปที่วัตถุ';

  @override
  String get reviewAddToLibrary => 'ตรวจสอบและเพิ่มลงในคลัง';

  @override
  String hideStrokeGuideStreak(Object streak) {
    return 'ซ่อนเส้นนำลำดับขีดเมื่อฝึกต่อเนื่อง: (streak)';
  }

  @override
  String inkPoints(Object points) {
    return '(points) แต้มน้ำหมึก';
  }

  @override
  String speechRateMultiplier(Object rate) {
    return '(rate)x';
  }

  @override
  String animationSpeedMultiplier(Object rate) {
    return '(rate)x';
  }

  @override
  String get supportAndFeedback => 'การสนับสนุนและข้อเสนอแนะ';

  @override
  String get reportBug => 'รายงานข้อผิดพลาด';

  @override
  String get suggestFeature => 'แนะนำฟีเจอร์';

  @override
  String get generalFeedback => 'ข้อเสนอแนะทั่วไป';

  @override
  String get pleaseDrawSomethingFirst => 'กรุณาวาดลงบนหน้าจอก่อน';

  @override
  String get drawThisCharacter => 'เขียนตัวอักษรนี้:';

  @override
  String followGuideStroke(Object current, Object total) {
    return 'ลากเส้นตามเส้นสีน้ำเงินเพื่อเขียนขีดที่ (current) จากทั้งหมด (total)';
  }

  @override
  String get skipCurrentStroke => 'ข้ามเส้นขีดนี้';

  @override
  String get submitDrawing => 'ส่งผลงานเขียน';

  @override
  String addedToDeck(Object deckName, Object hanzi) {
    return 'เพิ่ม (hanzi) ลงใน (deckName) แล้ว';
  }

  @override
  String removedFromDeck(Object hanzi) {
    return 'ลบ (hanzi) ออกจากสำรับแล้ว';
  }

  @override
  String skippedNoStrokeData(Object hanzi) {
    return 'ข้าม \"(hanzi)\" - ไม่มีข้อมูลลำดับขีดสำหรับตัวอักษร AI นี้';
  }

  @override
  String get startingSession => 'กำลังเริ่มเซสชัน...';

  @override
  String get masterBuildingBlocks =>
      'ฝึกฝนชิ้นส่วนพื้นฐานของอักษรจีนให้เชี่ยวชาญ';

  @override
  String get totalWords => 'คำศัพท์ทั้งหมด';

  @override
  String get newInk => 'หมึกใหม่';

  @override
  String get learningStatus => 'กำลังเรียนรู้';

  @override
  String get masteredStatus => 'เชี่ยวชาญแล้ว';

  @override
  String get libraryMastery => 'ความเชี่ยวชาญในคลัง';

  @override
  String get accuracyByMode => 'ความแม่นยำตามโหมด';

  @override
  String get upcomingReviews => 'การทบทวนที่กำลังจะมาถึง (7 วันข้างหน้า)';

  @override
  String get culturalReadingRoom => '文化书房 (ห้องอ่านหนังสือวัฒนธรรม)';

  @override
  String storyTitleHsk(Object level, Object title) {
    return '(title) (HSK (level))';
  }

  @override
  String get pleaseEnterTopic => 'กรุณาระบุหัวข้อ';

  @override
  String createdDeckCards(Object count, Object name) {
    return 'สร้าง (name) พร้อมการ์ด (count) ใบเรียบร้อยแล้ว!';
  }

  @override
  String gradeResult(Object grade) {
    return 'ผลการประเมิน: (grade)';
  }

  @override
  String get listeningMode => 'โหมดการฟัง';

  @override
  String get readingMode => 'โหมดการอ่าน';

  @override
  String get recallMode => 'โหมดระลึกความจำ';

  @override
  String get speakingMode => 'โหมดการพูด';

  @override
  String get aiMemoryHook => 'เทคนิคช่วยจำด้วย AI';

  @override
  String get exampleSentences => 'ประโยคตัวอย่าง';

  @override
  String get ghostCharacters => 'ตัวอักษรเงา';

  @override
  String get commonWords => 'คำศัพท์ที่พบบ่อย';

  @override
  String get personalNotes => 'บันทึกส่วนตัว';

  @override
  String get addPersonalNotes =>
      'เพิ่มเทคนิคช่วยจำหรือบันทึกของคุณเองที่นี่...';

  @override
  String get takePhoto => 'ถ่ายภาพ';

  @override
  String get gallery => 'คลังภาพ';

  @override
  String get arLens => 'เลนส์ AR';

  @override
  String addedCharToLibrary(Object char) {
    return 'เพิ่ม (char) ลงในคลังแล้ว';
  }

  @override
  String get scoreText => 'คะแนน';

  @override
  String get searchDictionaryHint => 'ค้นหาตัวอักษร พินอิน หรือความหมาย...';

  @override
  String get searchDeckHint => 'ค้นหาตัวอักษร พินอิน...';

  @override
  String get localRestaurant => 'ร้านอาหารท้องถิ่น';

  @override
  String get taxiToAirport => 'นั่งแท็กซี่ไปสนามบิน';

  @override
  String get silkMarketHaggling => 'ต่อรองราคาที่ตลาดผ้าไหม';

  @override
  String get medicalClinic => 'คลินิกรักษาโรค';

  @override
  String get meetingAFriend => 'พบปะเพื่อนฝูง';

  @override
  String get jobInterview => 'การสัมภาษณ์งาน';

  @override
  String get searchRadicalsHint => 'ค้นหาหมวดอักษร (เช่น น้ำ, 氵)';

  @override
  String get definition => 'คำจำกัดความ';

  @override
  String get undo => 'เลิกทำ';

  @override
  String get hanziMaster => 'SinoSpark';

  @override
  String get unlockForever => 'ปลดล็อกตลอดชีพ - .99';

  @override
  String get clear => 'ล้างข้อมูล';

  @override
  String get clearChat => 'ล้างแชท';

  @override
  String get typeMessage => 'พิมพ์ข้อความของคุณ...';

  @override
  String addedToLibrary(Object hanzi) {
    return 'เพิ่ม \'(hanzi)\' ลงในคลังของคุณแล้ว';
  }

  @override
  String get generateNewStory => 'สร้างนิทานใหม่';

  @override
  String failedToGenerateStory(Object error) {
    return 'สร้างนิทานไม่สำเร็จ:\n(error)';
  }

  @override
  String get detail => 'รายละเอียด';

  @override
  String get scanText => 'สแกนข้อความ';

  @override
  String get createMagic => 'สร้างสรรค์เวทมนตร์';

  @override
  String get learning => 'กำลังเรียนรู้';

  @override
  String get upcomingReviews7Days => 'การทบทวนที่กำลังจะมาถึง (7 วันข้างหน้า)';

  @override
  String get askFollowUpQuestion => 'ถามคำถามเพิ่มเติม...';

  @override
  String get pasteScanToSimplify =>
      'วางหรือสแกนข้อความภาษาจีนเพื่อปรับให้อ่านง่ายขึ้น';

  @override
  String get searchStoriesHint =>
      'ค้นหานิทานตามชื่อหรือแท็ก (เช่น เทพนิยาย, การท่องเที่ยว)';

  @override
  String get importAll => 'นำเข้าทั้งหมด';

  @override
  String get ascendAll => 'เลื่อนระดับทั้งหมด';

  @override
  String get startAscension => 'เริ่มการเลื่อนระดับ';

  @override
  String get scenarioLocalRestaurant => 'ร้านอาหารท้องถิ่น';

  @override
  String get scenarioLocalRestaurantDesc => 'ฝึกสั่งอาหารและขอคำแนะนำเมนูเด็ด';

  @override
  String get scenarioTaxiAirport => 'นั่งแท็กซี่ไปสนามบิน';

  @override
  String get scenarioTaxiAirportDesc =>
      'บอกจุดหมายปลายทางแก่คนขับและสนทนาเรื่องการจราจร';

  @override
  String get scenarioSilkMarket => 'ต่อรองราคาที่ตลาดผ้าไหม';

  @override
  String get scenarioSilkMarketDesc =>
      'ลองต่อรองราคาเพื่อให้ได้ของที่ระลึกในราคาที่คุ้มค่า';

  @override
  String get scenarioMedicalClinic => 'คลินิกรักษาโรค';

  @override
  String get scenarioMedicalClinicDesc =>
      'อธิบายอาการป่วยของคุณให้แพทย์แผนจีนฟัง';

  @override
  String get scenarioMeetingFriend => 'พบปะเพื่อนฝูง';

  @override
  String get scenarioMeetingFriendDesc =>
      'แนะนำตัวและพูดคุยเรื่องทั่วไปอย่างเป็นกันเอง';

  @override
  String get scenarioJobInterview => 'การสัมภาษณ์งาน';

  @override
  String get scenarioJobInterviewDesc =>
      'สมัครงานในตำแหน่งงานที่บริษัทเทคโนโลยีในเซี่ยงไฮ้';

  @override
  String get createCustomScenario => 'สร้างสถานการณ์กำหนดเอง';

  @override
  String get customScenarioTitleHint => 'ชื่อเรื่อง (เช่น งานเลี้ยงแต่งงาน)';

  @override
  String get customScenarioDescHint => 'คำอธิบาย (บริบท)';

  @override
  String get customScenarioPersonaHint =>
      'AI Persona (e.g. A curious coworker)';

  @override
  String get customScenarioDifficulty => 'ระดับความยาก';

  @override
  String get createAction => 'สร้าง';

  @override
  String get cancelAction => 'ยกเลิก';

  @override
  String get mythsAndLegends => 'ตำนานและปกรณัม';

  @override
  String get historyAndCulture => 'ประวัติศาสตร์และวัฒนธรรม';

  @override
  String get idiomsTitle => 'สำนวนจีน (成语)';

  @override
  String get theMonkeyKing => 'ไซอิ๋ว (ซุนหงอคง)';

  @override
  String get theMonkeyKingDesc => 'ซุนหงอคง (การเดินทางสู่ไซอิ๋ว)';

  @override
  String get huaMulan => 'ฮวา มู่หลาน';

  @override
  String get huaMulanDesc => 'ฮวา มู่หลาน เข้าร่วมกองทัพแทนบิดา';

  @override
  String get confuciusTitle => 'ขงจื๊อ';

  @override
  String get confuciusDesc => 'ชีวประวัติและคำสอนของขงจื๊อ';

  @override
  String get theGreatWall => 'กำแพงเมืองจีน';

  @override
  String get theGreatWallDesc => 'การสร้างกำแพงเมืองจีน';

  @override
  String get generateTopic => 'สร้างหัวข้อ';

  @override
  String get simplifyText => 'ปรับข้อความให้อ่านง่าย';

  @override
  String get topicHint => 'หัวข้อ (เช่น เอเลี่ยนเยือนปักกิ่ง)';

  @override
  String get tagsHint => 'แท็ก (คั่นด้วยจุลภาค, ไม่บังคับ)';

  @override
  String get speakWithMasterLin => 'สนทนากับอาจารย์หลิน';

  @override
  String get masterLinGreeting =>
      'สวัสดี ศิษย์รัก น้ำหมึกพร้อมแล้ว วันนี้เราจะศึกษาตัวอักษรหรือวลีใดกันดี?';

  @override
  String get typeYourMessage => 'พิมพ์ข้อความของคุณ...';

  @override
  String get theMainLibrary => 'คลังตำราหลัก';

  @override
  String get hsk1Foundation => 'HSK 1: พื้นฐาน';

  @override
  String get hsk2Elementary => 'HSK 2 (ระดับต้น)';

  @override
  String get hsk3Intermediate => 'HSK 3 (ระดับกลาง)';

  @override
  String get inDeckCheck => 'อยู่ในสำรับแล้ว ✓';

  @override
  String get addToDeckPlus => '+ เพิ่มลงสำรับ';

  @override
  String get openCardArrow => 'เปิดการ์ด →';

  @override
  String get pronunciationPartial => 'วรรณยุกต์ยังไม่แม่นยำ';

  @override
  String get pronunciationWrong => 'ไม่ถูกต้อง';

  @override
  String get toneExpected => 'เสียงที่ถูกต้อง';

  @override
  String get toneYouSaid => 'เสียงที่คุณพูด';

  @override
  String get gotIt => 'เข้าใจแล้ว!';

  @override
  String foundNCharacters(int count) {
    return 'พบ $count ตัวอักษร';
  }

  @override
  String get lookingUpCharacters => 'กำลังค้นหาตัวอักษร…';

  @override
  String get practiceAll => 'ฝึกฝนทั้งหมด';

  @override
  String get arLensObjects => 'วัตถุ';

  @override
  String get arLensText => 'ข้อความ';

  @override
  String get arLensDetectedText => 'ข้อความที่ตรวจพบ';

  @override
  String get duration12Min => '1-2 นาที';

  @override
  String get aClassicTangDynastyPoem => 'บทกวีคลาสสิกสมัยราชวงศ์ถัง';

  @override
  String get aClassicTangDynastyPoemBy => 'บทกวีคลาสสิกสมัยราชวงศ์ถังโดย';

  @override
  String get aStructuralComponent => 'ชิ้นส่วนโครงสร้างอักษร';

  @override
  String get addSelectedToDeck => 'เพิ่มรายการที่เลือกลงสำรับ';

  @override
  String addTo(Object target) {
    return 'เพิ่มลงใน';
  }

  @override
  String addedHanziToYourLibrary(String hanzi) {
    return 'เพิ่ม \'$hanzi\' ลงในคลังของคุณแล้ว';
  }

  @override
  String get adjustFontSize => 'ปรับขนาดตัวอักษร';

  @override
  String get againGoodEasyHard => '⬅️ เริ่มใหม่    ➡️ ดี    ⬆️ ง่าย    ⬇️ ยาก';

  @override
  String get aiAnalysisFailed => 'การวิเคราะห์ด้วย AI ล้มเหลว';

  @override
  String get aiIsThinking => 'AI กำลังคิด...';

  @override
  String get aiSceneAnalysisFailed => 'การวิเคราะห์ฉากด้วย AI ล้มเหลว';

  @override
  String get allLabel => 'ทั้งหมด';

  @override
  String get allPinyin => 'พินอินทั้งหมด';

  @override
  String get alreadyHaveAccountSignIn => 'มีบัญชีอยู่แล้วใช่ไหม? เข้าสู่ระบบ';

  @override
  String get analysisFailed => 'การวิเคราะห์ล้มเหลว:';

  @override
  String get analyzingClassicalCharacters => 'กำลังวิเคราะห์อักษรจีนโบราณ...';

  @override
  String get anatomy => 'โครงสร้างอักษร';

  @override
  String get ancientPhilosophy => 'ปรัชญาโบราณ';

  @override
  String get articleSavedToMediaHub => 'บันทึกบทความลงใน Media Hub แล้ว!';

  @override
  String get askAFollowUp => 'ถามคำถามเพิ่มเติม...';

  @override
  String get audioPrivacyAndHowThingsWork =>
      'ระบบเสียง ความเป็นส่วนตัว และหลักการทำงาน';

  @override
  String get audiobookPlayer => 'เครื่องเล่นหนังสือเสียง';

  @override
  String get audiobookVoice => 'เสียงผู้บรรยายหนังสือเสียง';

  @override
  String get auntieMaTown =>
      'ป้าหม่า (马阿姨) เจ้าของแผงขายอาหารผู้กระฉับกระเฉงและเสียงดัง ผู้ทำโร่วเจียหมัวและเหลียงผีที่กรอบอร่อยที่สุดในเมือง';

  @override
  String get back => 'ย้อนกลับ';

  @override
  String get baristaKevinNotes =>
      'บาริสต้าเควิน (小凯) นักคั่วกาแฟหนุ่มไฟแรงผู้หลงใหลการพูดคุยเรื่องเมล็ดกาแฟยูนนานและกลิ่นรสสัมผัส';

  @override
  String get bbc => 'BBC 中文网';

  @override
  String get beginYourJourney => 'เริ่มต้นการเดินทางของคุณ';

  @override
  String get bestValue => 'คุ้มค่าที่สุด';

  @override
  String get bookLinkCopiedToClipboard =>
      'คัดลอกลิงก์หนังสือไปยังคลิปบอร์ดแล้ว!';

  @override
  String get bookmarkChapter => 'คั่นหน้าบทนี้';

  @override
  String get bookmarks => 'ที่คั่นหน้า';

  @override
  String get books => 'หนังสือ';

  @override
  String get briefing => 'ข้อมูลสรุป';

  @override
  String get bugReport => 'รายงานข้อผิดพลาด';

  @override
  String get caoXueqinDecline =>
      'เฉา เสวี่ยฉิน (ประมาณ ค.ศ. 1715–1763) นักประพันธ์ในสมัยราชวงศ์ชิง เกิดในตระกูลขุนนางแปดกองธงที่เคยรุ่งเรืองก่อนจะตกต่ำลงในรัชสมัยจักรพรรดิยงเจิ้ง \'ความฝันในหอแดง\' ซึ่งเขียนขึ้นในช่วงบั้นปลายชีวิตที่ยากจนข้นแค้น ได้รับการยกย่องอย่างกว้างขวางว่าเป็นจุดสูงสุดของวรรณกรรมจีน — ภาพสะท้อนอันกว้างใหญ่และลึกซึ้งทางจิตวิทยาของความเสื่อมถอยในตระกูลขุนนาง';

  @override
  String get cardsTitle => 'การ์ดคำศัพท์';

  @override
  String get cc => 'คำบรรยาย (CC)';

  @override
  String get characterOrWord => 'ตัวอักษร / คำศัพท์';

  @override
  String get chatMore => 'สนทนาเพิ่มเติม';

  @override
  String get chefChenShumai =>
      'เชฟเฉิน (陈师傅) พ่อครัวติ่มซำกวางตุ้งอารมณ์ดี ผู้แนะนำฮะเก๋ากุ้งสดและขนมจีบเลิศรส';

  @override
  String get chineseEpics => 'มหากาพย์วรรณกรรมจีน';

  @override
  String get chinesePoetry => 'กวีนิพนธ์จีน';

  @override
  String get chng => 'chéng';

  @override
  String get chongqingSpicyHotpotFeast => 'มหกรรมหม้อไฟเผ็ดร้อนฉงชิ่ง';

  @override
  String get chooseAudiobookVoice => 'เลือกเสียงหนังสือเสียง';

  @override
  String get chooseVoice => 'เลือกเสียง';

  @override
  String get compare => 'เปรียบเทียบ';

  @override
  String get compare4Tones => 'เปรียบเทียบวรรณยุกต์ 4 เสียง';

  @override
  String get configuration => 'การกำหนดค่า';

  @override
  String get contemporary => 'ร่วมสมัย';

  @override
  String get context => 'บริบท';

  @override
  String get couldNotLoadLibrary => 'ไม่สามารถโหลดคลังได้';

  @override
  String get couldNotLoadVocabulary => 'ไม่สามารถโหลดคำศัพท์ได้';

  @override
  String get couldNotOpenEmailApp => 'ไม่สามารถเปิดแอปอีเมลได้';

  @override
  String get createAccount => 'สร้างบัญชี';

  @override
  String get createNewDeck => 'สร้างสำรับใหม่';

  @override
  String get createScenario => 'สร้างสถานการณ์';

  @override
  String get createStory => 'สร้างเรื่องราว';

  @override
  String get customLabel => 'กำหนดเอง';

  @override
  String get customWord => 'คำศัพท์กำหนดเอง';

  @override
  String get days => 'วัน';

  @override
  String get deck => 'สำรับ';

  @override
  String get deckName => 'ชื่อสำรับ';

  @override
  String get deckStory => 'เรื่องราวประจำสำรับ';

  @override
  String get deepAnalysis => 'การวิเคราะห์เชิงลึก';

  @override
  String get defaultDeck => 'สำรับเริ่มต้น';

  @override
  String get deleteLabel => 'ลบ';

  @override
  String get deleteScenario => 'ลบสถานการณ์';

  @override
  String get deletesAllProgressPermanently => 'ลบความคืบหน้าทั้งหมดอย่างถาวร';

  @override
  String get developerBackdoorUnlocked => 'ปลดล็อกโหมดนักพัฒนาแล้ว!';

  @override
  String get doesNotExistInChinese => 'ไม่มีในภาษาจีน';

  @override
  String get dontHaveAccountSignUp => 'ยังไม่มีบัญชีใช่ไหม? ลงทะเบียน';

  @override
  String get draftingStoryOutline => 'กำลังร่างโครงเรื่อง...';

  @override
  String get dynamicFlowState => 'สภาวะลื่นไหลแบบไดนามิก';

  @override
  String get dynamicFlowStateParenthetical => 'ไดนามิก (สภาวะลื่นไหล)';

  @override
  String get editCard => 'แก้ไขการ์ด';

  @override
  String get egAnimeVocab => 'เช่น คำศัพท์อนิเมะ';

  @override
  String get egFormalBusinessLanguageSlangForTexting =>
      'เช่น ภาษาธุรกิจทางการ, คำสแลงสำหรับแชท...';

  @override
  String get egOrderingAtARestaurantBusinessVocab =>
      'เช่น การสั่งอาหารในร้าน, คำศัพท์ธุรกิจ...';

  @override
  String get egWeddingReceptionTechInterview =>
      'เช่น งานเลี้ยงแต่งงาน, การสัมภาษณ์งานสายไอที...';

  @override
  String get emailLabel => 'อีเมล';

  @override
  String get english => 'ภาษาอังกฤษ';

  @override
  String get englishAndWorld => 'ภาษาอังกฤษและระดับสากล';

  @override
  String get episodes => 'ตอน';

  @override
  String get erase => 'ล้างข้อมูล';

  @override
  String get eraseDeckQuestion => 'ต้องการล้างสำรับนี้หรือไม่?';

  @override
  String errorFetchingTranslationForLabelE(String label, String e) {
    return 'เกิดข้อผิดพลาดในการดึงคำแปลสำหรับ $label: $e';
  }

  @override
  String errorLoadingMicroreadsE(String e) {
    return 'เกิดข้อผิดพลาดในการโหลดบทอ่านสั้น: $e';
  }

  @override
  String errorLoadingNovelsE(String e) {
    return 'เกิดข้อผิดพลาดในการโหลดนวนิยาย: $e';
  }

  @override
  String errorLoadingPoetryE(String e) {
    return 'เกิดข้อผิดพลาดในการโหลดบทกวี: $e';
  }

  @override
  String get exitFocus => 'ออกจากโหมดโฟกัส';

  @override
  String get explore => 'สำรวจ';

  @override
  String get exportToThisDeck => 'ส่งออกไปยังสำรับนี้';

  @override
  String get extractAndSimplify => 'สกัดและปรับให้อ่านง่าย';

  @override
  String get failedToCreateDeck => 'สร้างสำรับไม่สำเร็จ';

  @override
  String get failedToLoadDailyContent => 'โหลดเนื้อหาประจำวันไม่สำเร็จ';

  @override
  String get failedToLoadEpisodes => 'โหลดรายการตอนไม่สำเร็จ';

  @override
  String get failedToLoadShows => 'โหลดรายการไม่สำเร็จ';

  @override
  String get finalizingDetails => 'กำลังสรุปรายละเอียด...';

  @override
  String get finalizingStoryDetails => 'กำลังสรุปรายละเอียดเรื่องราว...';

  @override
  String get firebaseAuthConsole =>
      'ยังไม่ได้เปิดใช้งาน Firebase Auth กรุณาเปิดใช้งานวิธีการเข้าสู่ระบบที่ต้องการใน Firebase Console';

  @override
  String get flashcardDeckTitle => 'สำรับแฟลชการ์ด';

  @override
  String get focus => 'โฟกัส';

  @override
  String get foodAndCooking => 'อาหารและการทำอาหาร';

  @override
  String get forward => 'ไปข้างหน้า';

  @override
  String get freeFlow => 'การไหลลื่นอิสระ';

  @override
  String get frenchClassics => 'วรรณกรรมคลาสสิกฝรั่งเศส';

  @override
  String get full => 'เต็มรูปแบบ';

  @override
  String get gamingAndEsports => 'เกมและอีสปอร์ต';

  @override
  String get germanClassics => 'วรรณกรรมคลาสสิกเยอรมัน';

  @override
  String get ghostPinyin => 'พินอินแบบจาง';

  @override
  String get goodAttempt => 'ทำได้ดีมาก';

  @override
  String get gotItSimple => 'เข้าใจแล้ว';

  @override
  String get grammar => 'ไวยากรณ์';

  @override
  String get grandmaLiuFilling =>
      'คุณย่าหลิว (刘奶奶) คุณย่าชาวเหนือผู้ใจดีที่จะสอนคุณจับจีบเกี๊ยวและทำไส้หมูสับต้นหอม';

  @override
  String get great => 'ยอดเยี่ยม!';

  @override
  String get handmadeDumplingFeastInHarbin => 'มหกรรมเกี๊ยวทำมือในฮาร์บิน';

  @override
  String get hanziCharacter => 'อักษรจีน (ฮั่นจื้อ)';

  @override
  String get hapticFeedback => 'การสั่นตอบสนอง';

  @override
  String get helpAndSupport => 'ช่วยเหลือและสนับสนุน';

  @override
  String get hidden => 'ซ่อนอยู่';

  @override
  String get hideEnglishTranslations => 'ซ่อนคำแปลภาษาอังกฤษ';

  @override
  String get hidePinyin => 'ซ่อนพินอิน';

  @override
  String get highlight => 'ไฮไลต์';

  @override
  String get howWouldYouLikeToStudy => 'คุณต้องการเรียนรู้รูปแบบใด?';

  @override
  String get hsk1 => 'HSK 1';

  @override
  String get hsk4UpperIntermediate => 'HSK 4: ระดับกลางค่อนสูง';

  @override
  String get hsk5Advanced => 'HSK 5 (ระดับสูง)';

  @override
  String get hsk6Mastery => 'HSK 6: ระดับเชี่ยวชาญ';

  @override
  String get hskCollections => 'คลังคำศัพท์ HSK';

  @override
  String hskLevel(String level) {
    return 'HSK ระดับ $level';
  }

  @override
  String get hskSimplifySubtitles => 'ปรับคำบรรยายให้เข้าใจง่ายตาม HSK';

  @override
  String get hskVocabularyCollections => 'ชุดรวมคำศัพท์ HSK';

  @override
  String get i => 'ฉัน';

  @override
  String get ifTheAgain =>
      'หาก AI ตรวจพบเสียงที่ไม่ตรงกัน ระบบจะถามว่า \'คุณตั้งใจจะพูดว่า... ใช่หรือไม่?\' คุณสามารถแตะปุ่ม \'ใช่ ให้คะแนนฉันใหม่!\' เพื่อประเมินเสียงบันทึกเดิมของคุณใหม่ได้ทันทีโดยไม่ต้องพูดซ้ำ';

  @override
  String get install => 'ติดตั้ง';

  @override
  String get just => 'เพียง \$';

  @override
  String get keyword => 'คำสำคัญ';

  @override
  String get knowledgeBase => 'ฐานความรู้';

  @override
  String get liRuzhenSubjects =>
      'หลี่ หรูเจิน (ประมาณ ค.ศ. 1763–1830) บัณฑิตสมัยราชวงศ์ชิงที่มีความสนใจลึกซึ้งด้านสัทศาสตร์ หมากรุก และจักรวาลวิทยา \'กระจกบุปผา\' (จิ้งฮวาหยวน) นวนิยายแฟนตาซีเกี่ยวกับการเดินทางของพ่อค้าผ่านดินแดนมหัศจรรย์ โดดเด่นด้วยแนวคิดสตรีนิยมและความรู้ที่ครอบคลุมหลากหลายสาขาวิชา';

  @override
  String get library => 'คลังตำรา 文化书房';

  @override
  String get lifestyleAndVlog => 'ไลฟ์สไตล์และวล็อก';

  @override
  String get listenInAudiobookMode => 'ฟังในโหมดหนังสือเสียง';

  @override
  String get listenToThisWord => 'ฟังเสียงคำนี้';

  @override
  String get listening => 'กำลังฟัง...';

  @override
  String get liuEEncroachment =>
      'หลิว เอ้อ (1857–1909) ปราชญ์ผู้เชี่ยวชาญหลายสาขาในปลายราชวงศ์ชิง ทั้งวิศวกร แพทย์ และนักประพันธ์ นวนิยายเรื่องเดียวของเขา \'การเดินทางของเหล่าชาน\' เป็นบันทึกการเดินทางที่ไพเราะแต่แฝงการเมืองของหมอพเนจรผู้นำทางในจีนยุคที่ราชวงศ์กำลังล่มสลายและการรุกรานจากต่างชาติ';

  @override
  String get loadingTranslations => 'กำลังโหลดคำแปล...';

  @override
  String get luXunVernacular =>
      'หลู่ ซวิ่น (1881–1936) นามปากกาของโจว ซู่เหริน คือบิดาแห่งวรรณกรรมจีนสมัยใหม่ แพทย์ผู้ผันตัวมาเป็นนักเขียนเพื่อเยียวยาจิตวิญญาณของชาวจีน รวมเรื่องสั้นของเขาอย่าง \'บันทึกคนบ้า\' และ \'ประวัติจริงของอาคิว\' ได้ริเริ่มการใช้ภาษาพูดในงานประพันธ์';

  @override
  String get luoGuanzhongEpic =>
      'หลัว กวั้นจง (ประมาณ ค.ศ. 1330–1400) นักเขียนบทละครและนักประพันธ์ยุคเปลี่ยนผ่านหยวน-หมิง เชื่อกันว่าเป็นศิษย์ของซือ ไน่อัน ผลงาน \'สามก๊ก\' ของเขาได้สังเคราะห์พงศาวดารประวัติศาสตร์ มุขปาฐะ และการเล่าเรื่องเชิงละครเข้าด้วยกันจนกลายเป็นมหากาพย์ประวัติศาสตร์จีนอันทรงคุณค่า';

  @override
  String get makeACustomCollection => 'สร้างคอลเลกชันกำหนดเอง';

  @override
  String get manageDailyDropsAndReviewReminders =>
      'จัดการเนื้อหารายวันและการแจ้งเตือนทบทวน';

  @override
  String get managerYuOptions =>
      'ผู้จัดการอวี๋ (余店长) ผู้จัดการร้านหม้อไฟสุดกระตือรือร้น ผู้แนะนำผ้าขี้ริ้วสูตรเด็ด เลือดเป็ด และน้ำซุปรสกลมกล่อม';

  @override
  String get masterGaoRubs =>
      'อาจารย์เกา (高师傅) ผู้เชี่ยวชาญการปิ้งย่างเตาถ่านเปี่ยมเสน่ห์ ผู้ชอบพูดคุยกับลูกค้าเรื่องระดับความเผ็ดและผงหมักยี่หร่าสูตรลับ';

  @override
  String get masterThisToUnlockItsGalaxy =>
      'ฝึกฝนสิ่งนี้ให้เชี่ยวชาญเพื่อปลดล็อกกาแล็กซี';

  @override
  String get masterZhaoBrewing =>
      'อาจารย์จ้าว (赵师傅) ผู้เชี่ยวชาญด้านชาผู้ใจเย็นและรอบรู้ ผู้หลงใหลการอธิบายศาสตร์การชงชาแบบกังฟู';

  @override
  String get mastery => 'ความเชี่ยวชาญ';

  @override
  String get maybeLater => 'ไว้วันหลัง';

  @override
  String get memes => 'มีม';

  @override
  String get midnightBbqSkewersInWuhan => 'บาร์บีคิวเสียบไม้ยามดึกที่อู่ฮั่น';

  @override
  String get mo => '/เดือน';

  @override
  String get modernChinese => 'ภาษาจีนสมัยใหม่';

  @override
  String get monthly => 'รายเดือน';

  @override
  String get morningDimSumCartInGuangzhou => 'รถเข็นติ่มซำยามเช้าที่กว่างโจว';

  @override
  String get nameLabel => 'ชื่อ';

  @override
  String get native => 'เจ้าของภาษา';

  @override
  String get newCard => 'การ์ดใหม่';

  @override
  String get newDeck => 'สำรับใหม่';

  @override
  String get newDeckName => 'ชื่อสำรับใหม่';

  @override
  String get noActiveSubscriptionFound => 'ไม่พบการสมัครสมาชิกที่ใช้งานอยู่';

  @override
  String get noEpisodesFound => 'ไม่พบรายการตอน';

  @override
  String get noKeyWordsFoundForThisStory => 'ไม่พบคำสำคัญสำหรับเรื่องนี้';

  @override
  String get noLabel => 'ไม่ใช่';

  @override
  String get noNewWordsFound => 'ไม่พบคำศัพท์ใหม่!';

  @override
  String get noPinyin => 'ไม่มีพินอิน';

  @override
  String get noPremiumPackagesAvailable =>
      'ขณะนี้ยังไม่มีแพ็กเกจพรีเมียมที่พร้อมใช้งาน';

  @override
  String noResultsFoundForSearchquery(String searchQuery) {
    return 'ไม่พบผลลัพธ์สำหรับ \'$searchQuery\'';
  }

  @override
  String get noSavedArticlesYet => 'ยังไม่มีบทความที่บันทึกไว้';

  @override
  String get noShowsAvailable => 'ไม่มีรายการที่พร้อมใช้งาน';

  @override
  String get noStoriesFound => 'ไม่พบนิทาน';

  @override
  String get noWordsSelected => 'ไม่ได้เลือกคำศัพท์';

  @override
  String get notes => 'บันทึก';

  @override
  String get notoserifsc => 'NotoSerifSC';

  @override
  String get objectivesTitle => 'วัตถุประสงค์';

  @override
  String get openInYoutube => 'เปิดใน YouTube';

  @override
  String get orderingHanddripCoffeeInShanghai =>
      'การสั่งกาแฟดริปมือที่เซี่ยงไฮ้';

  @override
  String get orderingSugarcoatedHawsInWinterBeijing =>
      'การซื้อถังหูลู่ในฤดูหนาวที่ปักกิ่ง';

  @override
  String partnerLang(String lang) {
    return 'คู่สนทนา ($lang)';
  }

  @override
  String get partnerListening => 'คู่สนทนากำลังฟัง...';

  @override
  String get partnerSpeaking => 'คู่สนทนากำลังพูด…';

  @override
  String get passwordLabel => 'รหัสผ่าน';

  @override
  String get pause => 'พักชั่วคราว';

  @override
  String get perfect => 'สมบูรณ์แบบ!';

  @override
  String get personalizedPathBasedOnDeck =>
      'เส้นทางการเรียนรู้เฉพาะบุคคลตามสำรับของคุณ';

  @override
  String play(Object pinyin) {
    return 'เล่น';
  }

  @override
  String get pleaseEnterMessageBeforeSending => 'กรุณากรอกข้อความก่อนส่ง';

  @override
  String get practiceInRoleplay => 'ฝึกฝนผ่านการจำลองบทบาท';

  @override
  String get practiceModes => 'โหมดการฝึกฝน';

  @override
  String get practicePronouncingWithAiGrading =>
      'ฝึกออกเสียงคำนี้พร้อมการให้คะแนนโดย AI';

  @override
  String get preparingReadingInterface => 'กำลังเตรียมหน้าจอสำหรับการอ่าน...';

  @override
  String get privacy => 'ความเป็นส่วนตัว';

  @override
  String get privacyAndAudio => 'ความเป็นส่วนตัวและระบบเสียง';

  @override
  String get puSonglingLiterature =>
      'ผู ซงหลิง (1640–1715) นักเขียนสมัยราชวงศ์ชิงที่ใช้เวลาหลายทศวรรษในการรวบรวม \'เหลียวไจจื้ออี้\' (เรื่องเล่าพิสดารจากห้องหนังสือ) หลังสอบขุนนางไม่ผ่านซ้ำแล้วซ้ำเล่า เรื่องราวเหนือธรรมชาติเกี่ยวกับปีศาจจิ้งจอก ผี และบัณฑิต ยังคงเป็นมาตรฐานสูงสุดของวรรณกรรมโกธิกแบบจีน';

  @override
  String get qaFaq => 'ถาม-ตอบ / คำถามที่พบบ่อย';

  @override
  String get questsTitle => 'ภารกิจ';

  @override
  String get quickBookmarks => 'ที่คั่นหน้าด่วน';

  @override
  String get radical => 'หมวดนำอักษร';

  @override
  String get ready => 'พร้อม';

  @override
  String get readyToInterpret => 'พร้อมสำหรับการแปลภาษา';

  @override
  String get readyToStart => 'พร้อมเริ่มต้น';

  @override
  String get recentBookmarks => 'ที่คั่นหน้าล่าสุด';

  @override
  String get refiningGrammar => 'กำลังปรับปรุงไวยากรณ์...';

  @override
  String get refresh => 'รีเฟรช';

  @override
  String get removeFromSaved => 'ลบออกจากรายการที่บันทึก';

  @override
  String get removeFromSavedScenarios => 'ลบออกจากสถานการณ์ที่บันทึกไว้';

  @override
  String get removed => 'ลบออกแล้ว';

  @override
  String get requestPermissions => 'ขอสิทธิ์การเข้าถึง';

  @override
  String get rescind => 'ยกเลิก';

  @override
  String get restore => 'กู้คืน';

  @override
  String get results => 'ผลลัพธ์';

  @override
  String get resume => 'เล่นต่อ';

  @override
  String get retry => 'ลองใหม่';

  @override
  String get revenuecatError => 'ข้อผิดพลาดจาก RevenueCat:';

  @override
  String revenuecatErrorE(String e) {
    return 'ข้อผิดพลาดจาก RevenueCat: $e';
  }

  @override
  String get reviewExtractedDeck => 'ตรวจสอบสำรับที่สกัดได้';

  @override
  String get reviewIn => 'ทบทวนใน';

  @override
  String get reviewingYourTones => 'กำลังตรวจสอบวรรณยุกต์ของคุณ...';

  @override
  String get saveAll => 'บันทึกทั้งหมด';

  @override
  String get saveScenario => 'บันทึกสถานการณ์';

  @override
  String get saveThisScenario => 'บันทึกสถานการณ์นี้';

  @override
  String get saved => 'บันทึกแล้ว';

  @override
  String get scanAnother => 'สแกนอีกครั้ง';

  @override
  String get scenarioRemoved => 'ลบสถานการณ์แล้ว';

  @override
  String get scenarioSavedFindInCustomTab =>
      'บันทึกสถานการณ์แล้ว! ดูได้ในแท็บ \'กำหนดเอง\'';

  @override
  String score(Object score, Object total) {
    return 'คะแนน:';
  }

  @override
  String get searchByPinyinOrMeaning => 'ค้นหาตามพินอินหรือความหมาย...';

  @override
  String get searchByTitleOrTag => 'ค้นหาตามชื่อเรื่องหรือแท็ก...';

  @override
  String get searchDictionaryOrTypeCustom =>
      'ค้นหาในพจนานุกรมหรือพิมพ์คำศัพท์เอง';

  @override
  String get searchHint => 'ค้นหา...';

  @override
  String get searchOrEnterUrl => 'ค้นหาหรือป้อน URL';

  @override
  String get searchScenariosHint => 'ค้นหาสถานการณ์...';

  @override
  String get searchStoriesIdiomsNews => 'ค้นหานิทาน สำนวน ข่าว...';

  @override
  String get searchTopicsEgCookingHistory =>
      'ค้นหาหัวข้อ (เช่น การทำอาหาร, ประวัติศาสตร์)';

  @override
  String get seeAll => 'ดูทั้งหมด';

  @override
  String get selectADeck => 'เลือกสำรับ';

  @override
  String get selectPracticeMode => 'เลือกโหมดการฝึกฝน';

  @override
  String get selectingHskVocabulary => 'กำลังเลือกคำศัพท์ HSK...';

  @override
  String get send => 'ส่ง';

  @override
  String get sendMessage => 'ส่งข้อความ';

  @override
  String get serif => 'เซอริฟ (Serif)';

  @override
  String get shadow => 'ฝึกพูดตาม (Shadowing)';

  @override
  String get shiNaianEpic =>
      'ซือ ไน่อัน (ประมาณ ค.ศ. 1296–1372) ปราชญ์สมัยราชวงศ์หยวนที่สอบผ่านเป็นจอหงวนแต่เลือกใช้ชีวิตบัณฑิตสันโดษ \'ซ้องกั๋ง\' (108 ผู้กล้าแห่งเขาเหลียงซาน) ผลงานชิ้นเอกเกี่ยวกับวีรบุรุษนอกกฎหมายและการลุกฮืออย่างชอบธรรม ได้สร้างบรรทัดฐานของมหากาพย์กำลังภายในของจีน';

  @override
  String get showEnglish => 'แสดงภาษาอังกฤษ';

  @override
  String get showEnglishTranslations => 'แสดงคำแปลภาษาอังกฤษ';

  @override
  String get showHanzi => 'แสดงอักษรจีน (ฮั่นจื้อ)';

  @override
  String get showPinyin => 'แสดงพินอิน';

  @override
  String get showTranslation => 'แสดงคำแปล';

  @override
  String get shows => 'รายการ';

  @override
  String get signIn => 'เข้าสู่ระบบ';

  @override
  String get simplifiedArticle => 'บทความแบบอ่านง่าย';

  @override
  String get simplifyingSubtitles => 'กำลังปรับคำบรรยายให้อ่านง่ายขึ้น...';

  @override
  String get sincereHonest => 'จริงใจ; ซื่อสัตย์';

  @override
  String get sleepTimer => 'ตัวตั้งเวลาปิด';

  @override
  String get smartDeck => 'สำรับอัจฉริยะ';

  @override
  String get spanishAndWorld => 'ภาษาสเปนและระดับสากล';

  @override
  String get speaker => 'ลำโพง';

  @override
  String get spotifyStylePlayer => 'เครื่องเล่นสไตล์ Spotify';

  @override
  String get storyBookmarkedInLibrary => 'คั่นหน้านิทานในคลังแล้ว!';

  @override
  String get streetFoodNightMarketInXian => 'ตลาดกลางคืนสตรีทฟู้ดในซีอาน';

  @override
  String get strokes => 'ลำดับขีด';

  @override
  String get studyCharacter => 'ศึกษาตัวอักษร';

  @override
  String get subtitleOpacity => 'ความโปร่งใสของคำบรรยาย';

  @override
  String get suggestion => 'ข้อเสนอแนะ';

  @override
  String get summary => 'สรุป';

  @override
  String get supernaturalAndFolklore => 'เรื่องเหนือธรรมชาติและคติชนวิทยา';

  @override
  String get swipeToGrade => 'ปัดเพื่อประเมินคะแนน:';

  @override
  String get tableOfContents => 'สารบัญ';

  @override
  String get tapToRetry => 'แตะเพื่อลองใหม่';

  @override
  String get teaTastingInChengdu => 'การชิมชาที่เฉิงตู';

  @override
  String get techAndGadgets => 'เทคโนโลยีและแกดเจ็ต';

  @override
  String get terms => 'ข้อกำหนด';

  @override
  String get theGalaxyCharacters =>
      'แผนที่กาแล็กซีกำลังรอคุณอยู่\nฝึกฝนดวงอาทิตย์ (หมวดอักษร) ให้เชี่ยวชาญเพื่อปลดล็อกดวงดาว (ตัวอักษร)';

  @override
  String get theme => 'ธีม';

  @override
  String get thinking => 'กำลังคิด...';

  @override
  String get thisArticleCharacters => 'บทความนี้มีตัวอักษรจีนตัวเต็ม';

  @override
  String get todaysWord => 'คำศัพท์ประจำวัน';

  @override
  String get togglePinyin => 'เปิด/ปิด พินอิน';

  @override
  String get toggleTranslation => 'เปิด/ปิด คำแปล';

  @override
  String get toneDoesNotExistInMandarin =>
      'วรรณยุกต์นี้ไม่มีในภาษาจีนกลางมาตรฐาน';

  @override
  String get toneGraph => 'กราฟวรรณยุกต์';

  @override
  String get traceLabel => 'ลากเส้นตาม';

  @override
  String get trailer => 'ตัวอย่าง';

  @override
  String get translatingAndAddingPinyin => 'กำลังแปลและเพิ่มพินอิน...';

  @override
  String get translatingText => 'กำลังแปลข้อความ...';

  @override
  String get turnOn => 'เปิดใช้งาน';

  @override
  String get typeHanziPinyinOrEnglish =>
      'พิมพ์ตัวอักษรจีน พินอิน หรือภาษาอังกฤษ...';

  @override
  String get unknown2 => '游戏 实况 王者荣耀 原神';

  @override
  String get unknown3 => '中国 美食 菜谱';

  @override
  String get unknown4 => '中国 科技 测评';

  @override
  String get unrollingTheScroll => 'กำลังคลี่ม้วนคัมภีร์...';

  @override
  String get upperIntermediate => 'ระดับกลางค่อนสูง';

  @override
  String get vibrationsForInteractions => 'การสั่นสำหรับการตอบสนอง';

  @override
  String get video => 'วิดีโอ';

  @override
  String get viewAnswer => 'ดูคำตอบ';

  @override
  String get viewAsList => 'ดูเป็นรายการ';

  @override
  String get viewBookmarks => 'ดูที่คั่นหน้า';

  @override
  String get viewMyDrawing => 'ดูภาพวาดของฉัน';

  @override
  String get vlog => '中国 日常 vlog';

  @override
  String get voice => 'เสียง:';

  @override
  String get web => 'เว็บ';

  @override
  String get wedLoveToHearFromYou => 'เรายินดีรับฟัง\nความคิดเห็นของคุณ';

  @override
  String get welcomeBack => 'ยินดีต้อนรับกลับ';

  @override
  String get whatDoesThisMean => 'สิ่งนี้หมายความว่าอย่างไร?';

  @override
  String get whatHappensToMyChatHistory =>
      'จะเกิดอะไรขึ้นกับประวัติการแชทของฉัน?';

  @override
  String get whatIfAiMishears =>
      'จะเกิดอะไรขึ้นหาก AI ได้ยินคำที่ฉันต้องการจะพูดผิดไป?';

  @override
  String get whichCharacterIs => 'ตัวอักษรใดคือ:';

  @override
  String get wikipedia => 'วิกิพีเดีย';

  @override
  String get wordsSavedAndSrsScheduled =>
      'บันทึกคำศัพท์และจัดตารางทบทวน SRS เรียบร้อยแล้ว!';

  @override
  String get writeYourMessageHere => 'เขียนข้อความของคุณที่นี่...';

  @override
  String get wuChengenLiterature =>
      'อู๋ เฉิงเอิน (ประมาณ ค.ศ. 1500–1582) นักประพันธ์สมัยราชวงศ์หมิงจากหวยอัน เจียงซู ด้วยการรวบรวมนิทานพื้นบ้าน บุคลาธิษฐานทางพุทธศาสนา และการเสียดสีอันแยบคาย เขาได้ถักทอตำนานการจาริกแสวงบุญในสมัยถังจนกลายเป็น \'ไซอิ๋ว\' — หนึ่งในผลงานที่สร้างสรรค์และเป็นที่รักมากที่สุดในวรรณกรรมโลก';

  @override
  String get wuJingziClass =>
      'อู๋ จิ้งจื่อ (1701–1754) นักประพันธ์สมัยราชวงศ์ชิงจากอันฮุย ผู้สละมรดกตกทอดและอุทิศชีวิตให้กับการเขียน \'หรูหลินไว่สื่อ\' (ประวัติไม่เป็นทางการของเหล่าปราชญ์) — นวนิยายเสียดสีอันเผ็ดร้อนที่เปิดโปงความหลงตัวเอง การทุจริต และความไร้สาระของระบบการสอบจอหงวนและชนชั้นปัญญาชน';

  @override
  String get xuZhonglinWarfare =>
      'สวี่ จ้งหลิน (ช่วงศตวรรษที่ 16–17) ผู้ประพันธ์สมัยราชวงศ์หมิงผู้ได้รับการยกย่องในการรวบรวม \'ห้องสิน\' (封神演义) วรรณกรรมเทพนิยายชิ้นเอกที่ผสมผสานประวัติศาสตร์ยุคซาง-โจวเข้ากับจักรวาลวิทยาของเต๋า ระบบสวรรค์ และสงครามอันยิ่งใหญ่';

  @override
  String get yearly => 'รายปี';

  @override
  String get yesReGradeMe => 'ใช่ ให้คะแนนฉันใหม่!';

  @override
  String you(Object lang) {
    return 'คุณ';
  }

  @override
  String get youAreSpeaking => 'คุณกำลังพูด';

  @override
  String get youLabel => 'คุณ';

  @override
  String youLang(String lang) {
    return 'คุณ ($lang)';
  }

  @override
  String get youMustAccount =>
      'คุณต้องยอมรับข้อกำหนดการให้บริการและนโยบายความเป็นส่วนตัวเพื่อสร้างบัญชี';

  @override
  String get yourEchoModels =>
      'บทสนทนาใน Echo Hall ของคุณจะถูกเก็บไว้ในอุปกรณ์ของคุณ เพื่อให้คุณสามารถทบทวนได้ตลอดเวลา เราจะไม่นำบทสนทนาส่วนตัวของคุณไปใช้ในการฝึกฝนโมเดล AI ของเรา';

  @override
  String get zhOnly => 'ภาษาจีนเท่านั้น';

  @override
  String get hsk_1300_cards => '1,300 ใบ';

  @override
  String get hsk_154_cards => '154 ใบ';

  @override
  String get hsk_162_cards => '162 ใบ';

  @override
  String get hsk_2500_cards => '2,500 ใบ';

  @override
  String get hsk_299_cards => '299 ใบ';

  @override
  String get hsk_602_cards => '602 ใบ';

  @override
  String get added_to_review_queue => 'เพิ่มลงในคิวการทบทวนแล้ว';

  @override
  String added_cards_to(int cardCount, String deckName) {
    return 'เพิ่มการ์ด $cardCount ใบลงใน \"$deckName\" แล้ว';
  }

  @override
  String added_to_your_library(Object hanzi) {
    return 'เพิ่มลงในคลังของคุณแล้ว';
  }

  @override
  String get advanced => 'ระดับสูง';

  @override
  String get ai_stories => 'นิทาน AI';

  @override
  String analysis_failed(Object error) {
    return 'การวิเคราะห์ล้มเหลว: (error)';
  }

  @override
  String get analyzing_pronunciation_with_gemini_ai =>
      'กำลังวิเคราะห์การออกเสียงด้วย Gemini AI...';

  @override
  String get analyzing_your_pronunciation =>
      'กำลังวิเคราะห์การออกเสียงของคุณ...';

  @override
  String are_you_sure_you_want_to(String deckName) {
    return 'คุณแน่ใจหรือไม่ว่าต้องการล้าง \"$deckName\" อย่างถาวร? การดำเนินการนี้ไม่สามารถย้อนกลับได้และจะลบการ์ดทั้งหมดที่อยู่ภายใน';
  }

  @override
  String ask_about(String hanzi) {
    return 'ถามเกี่ยวกับ $hanzi...';
  }

  @override
  String get audio_haptics => 'ระบบเสียงและการสั่น';

  @override
  String get audio_could_not_start_check_your =>
      'ไม่สามารถเริ่มเล่นเสียงได้ กรุณาตรวจสอบการเชื่อมต่อและการตั้งค่าเสียงของอุปกรณ์';

  @override
  String get calligraphy_trace => 'ลากเส้นตามรอยพู่กัน';

  @override
  String chapters(Object count) {
    return 'บท)';
  }

  @override
  String get char => 'ตัวอักษร';

  @override
  String get chinese_character => 'ตัวอักษรจีน';

  @override
  String get contact_us_and_report_issues => 'ติดต่อเราและรายงานปัญหา';

  @override
  String created_smart_deck_with_words(String deckName, int wordCount) {
    return 'สร้างสำรับอัจฉริยะ: \"$deckName\" พร้อม $wordCount คำเรียบร้อยแล้ว!';
  }

  @override
  String get custom_ai_generated_story => 'นิทานกำหนดเองที่สร้างโดย AI';

  @override
  String get display_content => 'การแสดงผลและเนื้อหา';

  @override
  String get do_you_keep_or_store_my =>
      'คุณเก็บหรือบันทึกเสียงของฉันไว้หรือไม่?';

  @override
  String get elementary => 'ระดับต้น';

  @override
  String error_creating_scenario(Object error) {
    return 'เกิดข้อผิดพลาดในการสร้างสถานการณ์: (error)';
  }

  @override
  String error_fetching_translation_for(Object error) {
    return 'เกิดข้อผิดพลาดในการดึงคำแปลสำหรับ : (error)';
  }

  @override
  String error_loading_chapters(Object error) {
    return 'เกิดข้อผิดพลาดในการโหลดบทเรียน: (error)';
  }

  @override
  String get error_loading_decks => 'เกิดข้อผิดพลาดในการโหลดสำรับ';

  @override
  String error_loading_microreads(Object error) {
    return 'เกิดข้อผิดพลาดในการโหลดบทอ่านสั้น: (error)';
  }

  @override
  String error_loading_novels(Object error) {
    return 'เกิดข้อผิดพลาดในการโหลดนวนิยาย: (error)';
  }

  @override
  String error_loading_poetry(Object error) {
    return 'เกิดข้อผิดพลาดในการโหลดบทกวี: (error)';
  }

  @override
  String get etymology => 'นิรุกติศาสตร์ (ที่มาของคำ): ';

  @override
  String get explanation => 'คำอธิบาย';

  @override
  String get extracted_text_tap_to_lookup =>
      'ข้อความที่สกัดได้ (แตะเพื่อค้นหา)';

  @override
  String extraction_failed(Object error) {
    return 'การสกัดข้อความล้มเหลว: (error)';
  }

  @override
  String get failed_to_download => 'ดาวน์โหลดไม่สำเร็จ';

  @override
  String failed_to_generate_scenario(Object error) {
    return 'เกิดข้อผิดพลาดในการสร้างสถานการณ์: (error)';
  }

  @override
  String failed_to_generate_story(Object error) {
    return 'สร้างนิทานไม่สำเร็จ:\n(error)';
  }

  @override
  String failed_to_load_context(Object error) {
    return 'โหลดบริบทไม่สำเร็จ: (error)rr';
  }

  @override
  String get feature_request => 'แนะนำฟีเจอร์';

  @override
  String get foundation => 'พื้นฐาน';

  @override
  String get how_is_my_pronunciation_scored =>
      'การออกเสียงของฉันได้รับการประเมินคะแนนอย่างไร?';

  @override
  String hsk(Object level) {
    return 'HSK ';
  }

  @override
  String hsk_vocabulary(int hskLevel) {
    return 'คำศัพท์ HSK $hskLevel';
  }

  @override
  String get hsk_level => 'ระดับ HSK';

  @override
  String get intermediate => 'ระดับกลาง';

  @override
  String get learning_stats => 'สถิติการเรียนรู้';

  @override
  String get mandarin => 'ภาษาจีนกลาง';

  @override
  String get meaning => 'ความหมาย';

  @override
  String get no_decks_found => 'ไม่พบสำรับคำศัพท์';

  @override
  String no_results_found_for(Object searchQuery) {
    return 'ไม่พบผลลัพธ์สำหรับ \'\'';
  }

  @override
  String get no_when_you_use_echo_hall =>
      'ไม่ เมื่อคุณใช้งาน Echo Hall, Scholar\'s Verdict หรือ Shadowing Studio ไฟล์เสียงของคุณจะได้รับการประเมินแบบเรียลไทม์อย่างปลอดภัยเพื่อสร้างคะแนนการออกเสียง และจะถูกลบทิ้งทันทีหลังจากนั้น เราจะจัดเก็บเฉพาะคะแนนตัวเลขเพื่อติดตามความคืบหน้าของคุณเท่านั้น';

  @override
  String get notification_settings => 'การตั้งค่าการแจ้งเตือน';

  @override
  String get open_settings => 'เปิดการตั้งค่า';

  @override
  String get phoneme => 'หน่วยเสียง';

  @override
  String get play_reference_pronunciation => 'เล่นเสียงออกเสียงต้นแบบ';

  @override
  String get please_select_a_deck_to_add =>
      'กรุณาเลือกสำรับที่ต้องการเพิ่มการ์ด';

  @override
  String get point_at_chinese_text_to_translate =>
      'ชี้กล้องไปที่ข้อความภาษาจีนเพื่อแปล';

  @override
  String get practice_writing_the_strokes_by_hand => 'ฝึกเขียนลำดับขีดด้วยมือ';

  @override
  String get preferences_audio_and_display =>
      'การตั้งค่า ระบบเสียง และการแสดงผล';

  @override
  String get preparing_your_scholars_verdict =>
      'กำลังเตรียมคำตัดสินของบัณฑิต...';

  @override
  String get previous => 'ก่อนหน้า';

  @override
  String question(Object current, Object total) {
    return 'คำถาม';
  }

  @override
  String remove_from_this_deck(String hanzi) {
    return 'ลบ $hanzi ออกจากสำรับนี้หรือไม่?';
  }

  @override
  String revenuecat_error(Object error) {
    return 'ข้อผิดพลาดจาก RevenueCat: (error)';
  }

  @override
  String get review_tomorrow => 'ทบทวนพรุ่งนี้';

  @override
  String get roleplay => 'จำลองบทบาท';

  @override
  String saving_words_to(int wordCount, String deckName) {
    return 'กำลังบันทึก $wordCount คำลงใน $deckName...';
  }

  @override
  String get search_radicals_eg_water => 'ค้นหาหมวดอักษร (เช่น น้ำ, 氵)';

  @override
  String get select_target_hsk_level => 'เลือกระดับ HSK เป้าหมาย';

  @override
  String get sentence => 'ประโยค';

  @override
  String get shadowing_studio_is_a_dedicated_space =>
      'Shadowing Studio คือพื้นที่สำหรับการฝึกออกเสียงตามเจ้าของภาษาโดยเฉพาะ';

  @override
  String simplify_failed(Object error) {
    return 'การปรับให้อ่านง่ายล้มเหลว: (error)';
  }

  @override
  String get sinospark_premium => 'SinoSpark พรีเมียม';

  @override
  String get speaking_pronunciation => 'การพูดและการออกเสียง';

  @override
  String get statistics => 'สถิติ';

  @override
  String get table_of_contents => 'สารบัญ · 目录 (';

  @override
  String get the_ai_evaluates_your_speech_across =>
      'AI จะประเมินการพูดของคุณใน 3 มิติ:\n• ความแม่นยำ: คุณออกเสียงพยางค์ถูกต้องหรือไม่?\n• ความครบถ้วน: คุณข้ามหรือตกหล่นคำใดไปหรือไม่?\n• ความคล่องแคล่ว: คุณเว้นวรรคอย่างเป็นธรรมชาติและใช้วรรณยุกต์ถูกต้องหรือไม่?\nระบบจะเปรียบเทียบเสียงของคุณกับโมเดลเจ้าของภาษาเพื่อสร้างคะแนนเต็ม 100';

  @override
  String get this_cannot_be_undone => 'การดำเนินการนี้ไม่สามารถยกเลิกได้';

  @override
  String get title => 'ชื่อเรื่อง';

  @override
  String get to_be_reviewed => 'รอการทบทวน';

  @override
  String get traditional => 'ตัวเต็ม';

  @override
  String translation_failed(Object error) {
    return 'การแปลล้มเหลว: (error)';
  }

  @override
  String get type_in => 'พิมพ์ใน...';

  @override
  String get type_your_message_in => 'พิมพ์ข้อความของคุณใน...';

  @override
  String get unable_to_open_this_video_please =>
      'ไม่สามารถเปิดวิดีโอนี้ได้ กรุณาลองใหม่อีกครั้งในภายหลัง';

  @override
  String get view_your_learning_history_and_streaks =>
      'ดูประวัติการเรียนรู้และความต่อเนื่องของคุณ';

  @override
  String get what_is_shadowing_studio => 'Shadowing Studio คืออะไร?';

  @override
  String get words => 'คำ';

  @override
  String your_path_for_is_ready(String deckName) {
    return 'เส้นทางการเรียนรู้สำหรับ \'$deckName\' พร้อมแล้ว!';
  }

  @override
  String get you_said => '🗣️ คุณพูดว่า';

  @override
  String vocabularyBatch(Object index) {
    return 'ชุดคำศัพท์ (index)';
  }

  @override
  String get yourDailyDropIsHere => 'บทเรียนรายวันของคุณมาแล้ว! ✨';

  @override
  String get timeToReview => 'ได้เวลาทบทวนแล้ว! 📚';

  @override
  String get neverMissAStroke => 'อย่าพลาดแม้แต่เส้นเดียว! 🖌️';

  @override
  String get yourTrialEndsTomorrow =>
      'ช่วงทดลองใช้ของคุณจะสิ้นสุดในวันพรุ่งนี้! ⏳';

  @override
  String get officialStandardVocabularyTiers =>
      'ระดับคำศัพท์มาตรฐานอย่างเป็นทางการ';

  @override
  String get failedToLoadCollections => 'โหลดคอลเลกชันไม่สำเร็จ';

  @override
  String unnamedKey(Object tag) {
    return '#(tag)';
  }

  @override
  String error(Object error) {
    return 'ข้อผิดพลาด: (error)';
  }

  @override
  String get aiSmartContext => 'บริบทอัจฉริยะด้วย AI';

  @override
  String get aiSmartContextError => 'ข้อผิดพลาดของบริบทอัจฉริยะ AI';

  @override
  String get downloadOfficialHskCollections => 'ดาวน์โหลดชุดคำศัพท์ HSK ทางการ';

  @override
  String get unableToLoadThisSection =>
      'ไม่สามารถโหลดส่วนนี้ได้ กรุณาลองใหม่อีกครั้ง';

  @override
  String get translationLanguage => 'ภาษาสำหรับแปล';

  @override
  String get dailyDrops => 'บทเรียนรายวัน';

  @override
  String get wordOfTheDayNews => 'คำศัพท์ประจำวันและข่าวสาร';

  @override
  String get reviewReminders => 'การแจ้งเตือนทบทวน';

  @override
  String get flashcardsDueForReview => 'แฟลชการ์ดที่ถึงกำหนดทบทวน';

  @override
  String get dailyNewCards => 'การ์ดใหม่รายวัน';

  @override
  String get dailyReviewLimit => 'จำกัดการทบทวนรายวัน';

  @override
  String get practiceMode => 'โหมดการฝึกฝน';

  @override
  String get liziqi => '李子柒 Liziqi: ดอกไม้ผ้าไหม (绢花)';

  @override
  String get theLifeOfGarlicTraditional =>
      'ชีวิตของกระเทียม - วิถีชีวิตจีนดั้งเดิม';

  @override
  String get graceMandarin50Phrases => 'Grace Mandarin: 50 วลีสำคัญ';

  @override
  String get essentialChinesePhrasesForBeginners =>
      'วลีภาษาจีนที่จำเป็นสำหรับผู้เริ่มต้น';

  @override
  String get makingBambooFurniture => 'การทำเฟอร์นิเจอร์ไม้ไผ่';

  @override
  String get peppaPigChinese => 'Peppa Pig ภาษาจีน: ซ่อนหา (躲猫猫)';

  @override
  String get muddyPuddlesBeginnerFriendly =>
      'แอ่งโคลน - เหมาะสำหรับผู้เริ่มต้น';

  @override
  String get mandarinCorner300Verbs => 'Mandarin Corner: 300 คำกริยา';

  @override
  String get mostCommonChineseVerbs => 'คำกริยาภาษาจีนที่ใช้บ่อยที่สุด';

  @override
  String get graceMandarinOrderFood => 'Grace Mandarin: การสั่งอาหาร';

  @override
  String get howToOrderFoodIn => 'วิธีสั่งอาหารในร้านอาหารจีน';

  @override
  String get silkFlowersTraditionalCraft => 'ดอกไม้ผ้าไหม - หัตถศิลป์ดั้งเดิม';

  @override
  String get mandarinCorner => 'Mandarin Corner: เรียนภาษาจีน - พบแพทย์ (看病)';

  @override
  String get goingToTheDoctorReal => 'การไปพบแพทย์ - บทสนทนาในชีวิตจริง';

  @override
  String get hideAndSeekBeginnerFriendly =>
      'เล่นซ่อนหา - เหมาะสำหรับผู้เริ่มต้น';

  @override
  String get linGdp6 => '小Lin说: ทำไม GDP ถึงโต 6%';

  @override
  String get why6GdpGrowthEasy =>
      'ทำไม GDP ถึงโต 6% - เศรษฐศาสตร์จีนแบบเข้าใจง่าย';

  @override
  String get bbcWorldNews => 'BBC 中文 (ข่าวรอบโลก)';

  @override
  String get currentEventsInSimplifiedChinese =>
      'เหตุการณ์ปัจจุบันเป็นภาษาจีนตัวย่อ';

  @override
  String get baidu => 'Baidu';

  @override
  String get youtubeDesk => 'โต๊ะเรียนรู้ YOUTUBE';

  @override
  String get interactiveTranscriptsShadowing =>
      'สคริปต์แบบโต้ตอบและการฝึกพูดตาม';

  @override
  String get showsDramas => 'รายการและซีรีส์';

  @override
  String get extractToDeck => 'สกัดลงสำรับ';

  @override
  String get autoSimplify => 'ปรับให้อ่านง่ายอัตโนมัติ';

  @override
  String get rewriteThisArticleToMatch =>
      'เขียนบทความนี้ใหม่ให้ตรงกับระดับ HSK ของคุณ';

  @override
  String failedToSaveExtractedWords(Object error) {
    return 'บันทึกคำที่สกัดได้ไม่สำเร็จ: (error)';
  }

  @override
  String addToDeck(Object count) {
    return 'เพิ่มลงสำรับ ((count))';
  }

  @override
  String get dailyDiscoveryDrop => 'บทเรียนค้นพบประจำวัน';

  @override
  String get smartSpacedRepetition => 'การทบทวนแบบเว้นระยะอัจฉริยะ (SRS)';

  @override
  String get trialProtectionAlert => 'การแจ้งเตือนสิทธิ์ทดลองใช้';

  @override
  String get masteryLevel => 'ระดับความเชี่ยวชาญ';

  @override
  String get targetObjective => 'เป้าหมายที่ตั้งไว้';

  @override
  String get dailyPractice => 'การฝึกฝนประจำวัน';

  @override
  String get aiSpacedRepetition => 'การทบทวนแบบเว้นระยะด้วย AI';

  @override
  String get iVeGrantedAccess => 'ฉันอนุญาตการเข้าถึงแล้ว';

  @override
  String get scanner => 'สแกนเนอร์';

  @override
  String get interpreter => 'ล่ามแปลภาษา';

  @override
  String cards(Object count) {
    return '(count) ใบ';
  }

  @override
  String get nWaMendsTheHeavens => 'เจ้าแม่หนี่วาซ่อมฟ้า';

  @override
  String get terracottaArmy => 'กองทัพทหารดินเผา';

  @override
  String get forbiddenCity => 'พระราชวังต้องห้าม';

  @override
  String get aBlessingInDisguise => 'เรื่องร้ายกลายเป็นดี (塞翁失马)';

  @override
  String get drawingASnake => 'วาดงูเติมขา (画蛇添足)';

  @override
  String get takingTheBulletTrain => 'การโดยสารรถไฟความเร็วสูง';

  @override
  String get visitingTheDoctor => 'การไปพบแพทย์';

  @override
  String get orderingDumplings => 'การสั่งเกี๊ยว';

  @override
  String get theTeaCeremony => 'พิธีชงชา';

  @override
  String get chineseCalligraphy => 'การเขียนพู่กันจีน';

  @override
  String get theGiantPanda => 'แพนด้ายักษ์';

  @override
  String get simplifiedText => 'ข้อความแบบอ่านง่าย';

  @override
  String get novels96 => 'นวนิยาย (96)';

  @override
  String get microReads => 'บทอ่านสั้น';

  @override
  String get poetry => 'บทกวี';

  @override
  String get bookmarkRemoved => 'ลบที่คั่นหน้าแล้ว · 书签已移除';

  @override
  String bookmarkAdded(Object chapter) {
    return 'เพิ่มที่คั่นหน้าแล้ว · 已添加书签: บทที่ (chapter)';
  }

  @override
  String get readingVocabulary => 'การอ่านและคำศัพท์';

  @override
  String vocabularyBatchUnitindex1(Object index) {
    return 'ชุดคำศัพท์ \$(unitIndex + 1)';
  }

  @override
  String get yourDailyDropIsHere1 => 'บทเรียนรายวันของคุณมาแล้ว! ✨';

  @override
  String get timeToReview1 => 'ได้เวลาทบทวนแล้ว! 📚';

  @override
  String get neverMissAStroke1 => 'อย่าพลาดแม้แต่เส้นเดียว! 🖌️';

  @override
  String get yourTrialEndsTomorrow1 =>
      'ช่วงทดลองใช้ของคุณจะสิ้นสุดในวันพรุ่งนี้! ⏳';

  @override
  String get hskCollections1 => 'คลังคำศัพท์ HSK';

  @override
  String get officialStandardVocabularyTiers1 =>
      'ระดับคำศัพท์มาตรฐานอย่างเป็นทางการ';

  @override
  String get failedToLoadCollections1 => 'โหลดคอลเลกชันไม่สำเร็จ';

  @override
  String ui__transcription(Object transcription) {
    return '\"\$_transcription\"';
  }

  @override
  String playPinyinwithtone(Object pinyinWithTone) {
    return 'เล่นเสียง \$pinyinWithTone';
  }

  @override
  String errorE(Object e) {
    return 'ข้อผิดพลาด: \$e';
  }

  @override
  String lookalikepinyin(Object pinyin) {
    return '(\$(lookAlike.pinyin))';
  }

  @override
  String get aiSmartContext1 => 'บริบทอัจฉริยะด้วย AI';

  @override
  String get aiSmartContextError1 => 'ข้อผิดพลาดของบริบทอัจฉริยะ AI';

  @override
  String errorErr(Object err, Object error) {
    return 'ข้อผิดพลาด: \$err';
  }

  @override
  String get downloadOfficialHskCollections1 =>
      'ดาวน์โหลดชุดคำศัพท์ HSK ทางการ';

  @override
  String get unableToLoadThisSectionPleaseTryAga =>
      'ไม่สามารถโหลดส่วนนี้ได้ กรุณาลองใหม่อีกครั้ง';

  @override
  String get searchRadicalsEgWater => 'ค้นหาหมวดอักษร (เช่น น้ำ, 氵)';

  @override
  String ui__currentstrokeindex1totalstrokes(Object current, Object total) {
    return '\$(_currentStrokeIndex + 1)/\$totalStrokes';
  }

  @override
  String get translationLanguage1 => 'ภาษาสำหรับแปล';

  @override
  String get appLanguage1 => 'ภาษาของแอป';

  @override
  String get dailyDrops1 => 'บทเรียนรายวัน';

  @override
  String get wordOfTheDayNews1 => 'คำศัพท์ประจำวันและข่าวสาร';

  @override
  String get reviewReminders1 => 'การแจ้งเตือนทบทวน';

  @override
  String get flashcardsDueForReview1 => 'แฟลชการ์ดที่ถึงกำหนดทบทวน';

  @override
  String get accuracyByMode1 => 'ความแม่นยำตามโหมด';

  @override
  String accuracytostringasfixed1(Object accuracy) {
    return '\$(accuracy.toStringAsFixed(1))%';
  }

  @override
  String get upcomingReviewsNext7Days =>
      'การทบทวนที่กำลังจะมาถึง (7 วันข้างหน้า)';

  @override
  String get explaining => 'กำลังอธิบาย:';

  @override
  String entryhanziEntrypinyin(Object hanzi, Object pinyin) {
    return '\$(entry.hanzi) [\$(entry.pinyin)]';
  }

  @override
  String get dailyNewCards1 => 'การ์ดใหม่รายวัน';

  @override
  String get dailyReviewLimit1 => 'จำกัดการทบทวนรายวัน';

  @override
  String get listeningMode1 => 'โหมดการฟัง';

  @override
  String get readingMode1 => 'โหมดการอ่าน';

  @override
  String get recallMode1 => 'โหมดระลึกความจำ';

  @override
  String get speakingMode1 => 'โหมดการพูด';

  @override
  String get practiceMode1 => 'โหมดการฝึกฝน';

  @override
  String acc(Object acc) {
    return '\$acc%';
  }

  @override
  String get partner1 => 'คู่สนทนา';

  @override
  String get partnerSpeaking1 => 'คู่สนทนากำลังพูด…';

  @override
  String get theLifeOfGarlicTraditionalChineseLi =>
      'ชีวิตของกระเทียม - วิถีชีวิตจีนดั้งเดิม';

  @override
  String get graceMandarin50Phrases1 => 'Grace Mandarin: 50 วลีสำคัญ';

  @override
  String get essentialChinesePhrasesForBeginners1 =>
      'วลีภาษาจีนที่จำเป็นสำหรับผู้เริ่มต้น';

  @override
  String get makingBambooFurniture1 => 'การทำเฟอร์นิเจอร์ไม้ไผ่';

  @override
  String get muddyPuddlesBeginnerFriendly1 =>
      'แอ่งโคลน - เหมาะสำหรับผู้เริ่มต้น';

  @override
  String get mandarinCorner300Verbs1 => 'Mandarin Corner: 300 คำกริยา';

  @override
  String get mostCommonChineseVerbs1 => 'คำกริยาภาษาจีนที่ใช้บ่อยที่สุด';

  @override
  String get graceMandarinOrderFood1 => 'Grace Mandarin: การสั่งอาหาร';

  @override
  String get howToOrderFoodInAChineseRestaurant =>
      'วิธีสั่งอาหารในร้านอาหารจีน';

  @override
  String get silkFlowersTraditionalCraft1 => 'ดอกไม้ผ้าไหม - หัตถศิลป์ดั้งเดิม';

  @override
  String get goingToTheDoctorRealLifeConversatio =>
      'การไปพบแพทย์ - บทสนทนาในชีวิตจริง';

  @override
  String get hideAndSeekBeginnerFriendly1 =>
      'เล่นซ่อนหา - เหมาะสำหรับผู้เริ่มต้น';

  @override
  String get lingdp6 => '小Lin说: ทำไม GDP ถึงโต 6%';

  @override
  String get why6GdpGrowthEasyChineseEconomics =>
      'ทำไม GDP ถึงโต 6% - เศรษฐศาสตร์จีนแบบเข้าใจง่าย';

  @override
  String get currentEventsInSimplifiedChinese1 =>
      'เหตุการณ์ปัจจุบันเป็นภาษาจีนตัวย่อ';

  @override
  String get baidu1 => 'Baidu';

  @override
  String get youtubeDesk1 => 'โต๊ะเรียนรู้ YOUTUBE';

  @override
  String get interactiveTranscriptsShadowing1 =>
      'สคริปต์แบบโต้ตอบและการฝึกพูดตาม';

  @override
  String get showsDramas1 => 'รายการและซีรีส์';

  @override
  String error_error(Object error) {
    return 'ข้อผิดพลาด: \$_error';
  }

  @override
  String get extractToDeck1 => 'สกัดลงสำรับ';

  @override
  String get autosimplify => 'ปรับให้อ่านง่ายอัตโนมัติ';

  @override
  String get rewriteThisArticleToMatchYourHskLev =>
      'เขียนบทความนี้ใหม่ให้ตรงกับระดับ HSK ของคุณ';

  @override
  String get addToDeck1 => 'เพิ่มลงสำรับ';

  @override
  String playbackratex(Object playbackRate) {
    return '\$(playbackRate)x';
  }

  @override
  String speedx(Object speed) {
    return '\$(speed)x';
  }

  @override
  String get dailyDiscoveryDrop1 => 'บทเรียนค้นพบประจำวัน';

  @override
  String get smartSpacedRepetition1 => 'การทบทวนแบบเว้นระยะอัจฉริยะ (SRS)';

  @override
  String get trialProtectionAlert1 => 'การแจ้งเตือนสิทธิ์ทดลองใช้';

  @override
  String get masteryLevel1 => 'ระดับความเชี่ยวชาญ';

  @override
  String get targetObjective1 => 'เป้าหมายที่ตั้งไว้';

  @override
  String get dailyPractice1 => 'การฝึกฝนประจำวัน';

  @override
  String get aiSpacedRepetition1 => 'การทบทวนแบบเว้นระยะด้วย AI';

  @override
  String get iveGrantedAccess => 'ฉันอนุญาตการเข้าถึงแล้ว';

  @override
  String addToDeck_selectedwordindiceslength(Object count) {
    return 'เพิ่มลงสำรับ (\$(_selectedWordIndices.length))';
  }

  @override
  String get scanner1 => 'สแกนเนอร์';

  @override
  String get interpreter1 => 'ล่ามแปลภาษา';

  @override
  String entryvalueCards(Object count) {
    return '\$(entry.value) ใบ';
  }

  @override
  String score_score_questionslength(Object score, Object total) {
    return 'คะแนน: \$_score / \$(_questions.length)';
  }

  @override
  String get theMonkeyKing1 => 'ไซอิ๋ว (ซุนหงอคง)';

  @override
  String get huaMulan1 => 'ฮวา มู่หลาน';

  @override
  String get nwaMendsTheHeavens => 'เจ้าแม่หนี่วาซ่อมฟ้า';

  @override
  String get confucius => 'ขงจื๊อ';

  @override
  String get theGreatWall1 => 'กำแพงเมืองจีน';

  @override
  String get terracottaArmy1 => 'กองทัพทหารดินเผา';

  @override
  String get forbiddenCity1 => 'พระราชวังต้องห้าม';

  @override
  String get aBlessingInDisguise1 => 'เรื่องร้ายกลายเป็นดี (塞翁失马)';

  @override
  String get drawingASnake1 => 'วาดงูเติมขา (画蛇添足)';

  @override
  String get takingTheBulletTrain1 => 'การโดยสารรถไฟความเร็วสูง';

  @override
  String get visitingTheDoctor1 => 'การไปพบแพทย์';

  @override
  String get orderingDumplings1 => 'การสั่งเกี๊ยว';

  @override
  String get theTeaCeremony1 => 'พิธีชงชา';

  @override
  String get chineseCalligraphy1 => 'การเขียนพู่กันจีน';

  @override
  String get theGiantPanda1 => 'แพนด้ายักษ์';

  @override
  String get simplifiedText1 => 'ข้อความแบบอ่านง่าย';

  @override
  String get novels961 => 'นวนิยาย (96)';

  @override
  String get microreads => 'บทอ่านสั้น';

  @override
  String get poetry1 => 'บทกวี';

  @override
  String get readingVocabulary1 => 'การอ่านและคำศัพท์';

  @override
  String get defaultfirebaseoptionsHaveNotBeenCo =>
      'DefaultFirebaseOptions ยังไม่ได้กำหนดค่าสำหรับ Linux -';

  @override
  String get defaultfirebaseoptionsAreNotSupport =>
      'แพลตฟอร์มนี้ไม่รองรับ DefaultFirebaseOptions';

  @override
  String get hanziMaster1 => 'Hanzi Master';

  @override
  String get strokesCannotBeEmpty => 'เส้นลำดับขีดต้องไม่ว่างเปล่า';

  @override
  String get wrongStartPoint => 'จุดเริ่มต้นไม่ถูกต้อง';

  @override
  String get rightShapeButWrongPlace => 'รูปร่างถูกต้อง แต่ผิดตำแหน่ง!';

  @override
  String get goodFollowTheFlow => 'ดีมาก!\') : \'ลากตามแนวเส้น.';

  @override
  String get aBitShaky => 'มือสั่นไปนิดนึง!';

  @override
  String get aBitHesitant => 'ดูล้าช้าหรือลังเลไปนิด...';

  @override
  String get shapeIsOff => 'รูปทรงคลาดเคลื่อน';

  @override
  String get arabic => 'ภาษาอาหรับ';

  @override
  String get german => 'ภาษาเยอรมัน';

  @override
  String get spanish => 'ภาษาสเปน';

  @override
  String get french => 'ภาษาฝรั่งเศส';

  @override
  String get hindi => 'ภาษาฮินดี';

  @override
  String get indonesian => 'ภาษาอินโดนีเซีย';

  @override
  String get italian => 'ภาษาอิตาลี';

  @override
  String get japanese => 'ภาษาญี่ปุ่น';

  @override
  String get korean => 'ภาษาเกาหลี';

  @override
  String get portuguese => 'ภาษาโปรตุเกส';

  @override
  String get russian => 'ภาษารัสเซีย';

  @override
  String get vietnamese => 'ภาษาเวียดนาม';

  @override
  String get microphonePermissionDenied => 'การอนุญาตใช้ไมโครโฟนถูกปฏิเสธ';

  @override
  String get offset => 'ออฟเซ็ต';

  @override
  String get audioserviceHasBeenDisposed => 'AudioService ถูกปิดการทำงานแล้ว';

  @override
  String get fenrirZhcnyunxineural => 'Fenrir\': \'zh-CN-YunxiNeural';

  @override
  String get charonZhcnyunyangneural => 'Charon\': \'zh-CN-YunyangNeural';

  @override
  String get koreZhcnxiaoxiaoneural => 'Kore\': \'zh-CN-XiaoxiaoNeural';

  @override
  String get aoedeZhcnxiaoyineural => 'Aoede\': \'zh-CN-XiaoyiNeural';

  @override
  String get puckZhcnyunjianneural => 'Puck\': \'zh-CN-YunjianNeural';

  @override
  String get kore => 'Kore';

  @override
  String get xmicrosoftoutputformatAudio24khz48k =>
      'X-Microsoft-OutputFormat\': \'audio-24khz-48kbitrate-mono-mp3';

  @override
  String get useragentHanzimasterapp => 'User-Agent\': \'HanziMasterApp';

  @override
  String get anchorWord => 'คำหลัก (Anchor Word)';

  @override
  String get creativeThematicTitle => 'ชื่อธีมเชิงสร้างสรรค์';

  @override
  String get briefPedagogicalOrSemanticRationale =>
      'เหตุผลเชิงการสอนหรือความหมายสั้นๆ';

  @override
  String get theSingleMostCentralCharacterFromTh =>
      'ตัวอักษรที่เป็นศูนย์กลางสำคัญที่สุดจากรายการ';

  @override
  String get aBalancedSetOfCharactersFromYourLib =>
      'ชุดตัวอักษรที่สมดุลจากคลังของคุณ';

  @override
  String get yourNaturalConversationalReplyInChi =>
      'คำตอบรับการสนทนาที่เป็นธรรมชาติของคุณเป็นอักษรจีน';

  @override
  String get theEnglishTranslationOfYourReply =>
      'คำแปลภาษาอังกฤษของคำตอบของคุณ';

  @override
  String get thePinyinWithToneMarksForYourReply =>
      'พินอินพร้อมเครื่องหมายวรรณยุกต์สำหรับคำตอบของคุณ';

  @override
  String get aSuggestedResponseTheUserCouldSayBa =>
      'ข้อเสนอแนะคำตอบที่ผู้ใช้สามารถพูดตอบกลับได้';

  @override
  String get pinyinForTheSuggestion => 'พินอินสำหรับข้อเสนอแนะ';

  @override
  String get englishTranslationForTheSuggestion =>
      'คำแปลภาษาอังกฤษสำหรับข้อเสนอแนะ';

  @override
  String get scholarsCritique => 'คำวิจารณ์ของบัณฑิต';

  @override
  String get theEchoHallRemainsSilentTryYourBrea =>
      'ห้องสะท้อนเสียงยังคงเงียบงัน ลองเปล่งเสียงอีกครั้ง';

  @override
  String get xtitleHanziMaster => 'X-Title\': \'Hanzi Master';

  @override
  String get noneYet => 'ยังไม่มี';

  @override
  String get exactSentence => 'ประโยคที่แน่นอน:';

  @override
  String get englishTranslation => 'คำแปลภาษาอังกฤษ';

  @override
  String get previouslyGeneratedPhrases => 'วลีที่สร้างขึ้นก่อนหน้า';

  @override
  String get iLikeDrinkingAppleJuice => 'ฉันชอบดื่มน้ำแอปเปิ้ล';

  @override
  String get theEnglishMeaningHere => 'ความหมายภาษาอังกฤษตรงนี้...';

  @override
  String get failedToFetchDefinition => 'ดึงข้อมูลคำจำกัดความไม่สำเร็จ';

  @override
  String get failedToLoadExplanation => 'โหลดคำอธิบายไม่สำเร็จ';

  @override
  String get failedToLoadComparison => 'โหลดการเปรียบเทียบไม่สำเร็จ';

  @override
  String get emptyResponseFromOpenrouter => 'ไม่มีการตอบกลับจาก OpenRouter';

  @override
  String get emptyResponseFromVisionModel => 'ไม่มีการตอบกลับจากโมเดล Vision';

  @override
  String get standard => 'มาตรฐาน';

  @override
  String get theFullSentenceInChinese => 'ประโยคเต็มเป็นภาษาจีน...';

  @override
  String get theWordOrCharacterInChinese => 'คำศัพท์หรือตัวอักษรเป็นภาษาจีน';

  @override
  String get thePinyinForThisSpecificWord => 'พินอินสำหรับคำนี้โดยเฉพาะ';

  @override
  String get emptyResponseFromDeepseekApi => 'ไม่มีการตอบกลับจาก DeepSeek API';

  @override
  String get criticalPutTheEnglishTranslationInT =>
      'สำคัญมาก: ใส่คำแปลภาษาอังกฤษใน';

  @override
  String get englishTranslationOfTheEntireSenten =>
      'คำแปลภาษาอังกฤษของทั้งประโยค';

  @override
  String get hanziWord => 'คำศัพท์อักษรจีน';

  @override
  String get theFullSimplifiedSentenceInChinese => 'ประโยคเต็มภาษาจีนตัวย่อ...';

  @override
  String get lyingFlatACulturalMovement =>
      'นอนราบ (ถังผิง): กระแสวัฒนธรรมร่วมสมัย...';

  @override
  String get theUserYouAreSpeakingToIsNamed =>
      'ผู้ใช้ที่คุณกำลังสนทนาด้วยมีชื่อว่า';

  @override
  String get importantRuleDoNotAddressTheUserByA =>
      'กฎสำคัญ: ห้ามเรียกผู้ใช้ด้วยชื่อใดๆ ทั้งสิ้น อย่าใช้ชื่อชั่วคราวเช่น';

  @override
  String get youAreAConciseChineseCalligraphyAnd =>
      'คุณคือติวเตอร์สอนการเขียนพู่กันและนิรุกติศาสตร์ภาษาจีนที่กระชับ ตรงประเด็น ในแอปแฟลชการ์ดบนมือถือ';

  @override
  String get theStudentIsStudyingTheCharacter => 'ผู้เรียนกำลังศึกษาตัวอักษร';

  @override
  String get neverWriteIntroductionsSignoffsOrFi =>
      'ห้ามเขียนคำเกริ่นนำ คำลงท้าย หรือคำพูดฟุ่มเฟือยเช่น';

  @override
  String get beDirectAndInformative =>
      'ให้ตอบอย่างตรงไปตรงมาและให้ข้อมูลครบถ้วน';

  @override
  String get criticalRuleYouMustRespondEntirelyI =>
      'กฎสำคัญยิ่ง: คุณต้องตอบเป็นภาษาที่ตรงกับรหัส ISO 639-1 เท่านั้น';

  @override
  String get youAreAConciseChineseGrammarTutorIn =>
      'คุณคือติวเตอร์สอนไวยากรณ์ภาษาจีนที่กระชับ ตรงประเด็น ในแอปมือถือ';

  @override
  String get theStudentIsConfusedAboutTheWord =>
      'ผู้เรียนเกิดความสับสนเกี่ยวกับคำว่า';

  @override
  String get neverWriteIntroductionsSignoffsOrFi1 =>
      'ห้ามเขียนคำเกริ่นนำ คำลงท้าย หรือคำพูดฟุ่มเฟือย';

  @override
  String get azureSpeechApiKeysAreMissing => 'ไม่พบคีย์ Azure Speech API';

  @override
  String get success => 'สำเร็จ';

  @override
  String get granularity => 'ระดับความละเอียด';

  @override
  String get phoneme1 => 'หน่วยเสียง';

  @override
  String get dimension => 'มิติ';

  @override
  String get comprehensive => 'ครอบคลุม';

  @override
  String get weCouldntHearYouClearlyPleaseTryAga =>
      'ระบบไม่ได้ยินเสียงของคุณอย่างชัดเจน กรุณาลองใหม่อีกครั้ง';

  @override
  String get noNbestResultFound => 'ไม่พบผลลัพธ์ NBest';

  @override
  String get words1 => 'คำศัพท์';

  @override
  String get word => 'คำ';

  @override
  String get phonemes => 'หน่วยเสียง';

  @override
  String get syllables => 'พยางค์';

  @override
  String get syllable => 'พยางค์';

  @override
  String get omission => 'การตกหล่น';

  @override
  String get insertion => 'การเพิ่มคำเกิน';

  @override
  String get youMissedThisWord => 'คุณตกหล่นคำนี้ไป';

  @override
  String get extraWordAddedHere => 'มีคำเกินเพิ่มเข้ามาตรงนี้';

  @override
  String get mispronunciation => 'การออกเสียงผิด';

  @override
  String get pronunciationWasInaccurate => 'การออกเสียงยังไม่ถูกต้องแม่นยำ';

  @override
  String get goodEffortKeepPracticing => 'พยายามได้ดี! ฝึกฝนต่อไป';

  @override
  String get perfectPronunciationSoundsLikeANati =>
      'การออกเสียงสมบูรณ์แบบ! เหมือนเจ้าของภาษาเลย';

  @override
  String get greatJobAFewMinorToneInaccuracies =>
      'ยอดเยี่ยมมาก! มีเสียงวรรณยุกต์คลาดเคลื่อนเล็กน้อย';

  @override
  String get notBadButYourTonesNeedSomeWork =>
      'ไม่เลวเลย แต่วรรณยุกต์ยังต้องปรับอีกนิด';

  @override
  String get keepPracticingListenToTheNativeAudi =>
      'ฝึกฝนต่อไป! ฟังเสียงเจ้าของภาษาแล้วลองใหม่อีกครั้ง';

  @override
  String get lexical => 'ด้านคำศัพท์';

  @override
  String get chineseHanziHere => 'อักษรจีนตรงนี้';

  @override
  String get aShortSummaryInEnglish => 'บทสรุปสั้นๆ เป็นภาษาอังกฤษ';

  @override
  String get noCoherentChineseTextFoundInTheScan =>
      'ไม่พบข้อความภาษาจีนที่อ่านได้ใจความในการสแกน';

  @override
  String get theFullEnglishTranslationOfTheScann =>
      'คำแปลภาษาอังกฤษฉบับเต็มของข้อความที่สแกน... หรือ \'ไม่พบข้อความภาษาจีนที่อ่านได้ใจความ\'';

  @override
  String get aShort24WordTitleForThisScanEgResta =>
      'ชื่อสั้นๆ 2-4 คำสำหรับการสแกนนี้ (เช่น \'เมนูร้านอาหาร\', \'ป้ายบอกทาง\')';

  @override
  String get china => 'ประเทศจีน';

  @override
  String get noTranslationAvailable => 'ไม่มีคำแปล';

  @override
  String get scanResults => 'ผลการสแกน';

  @override
  String get whenWasItWrittenAndWhatWasHappening =>
      'ผลงานนี้เขียนขึ้นเมื่อใด และเกิดเหตุการณ์ใดขึ้นในประเทศจีนในขณะนั้น?';

  @override
  String get whyIsThisPieceFamousWhatPhilosophic =>
      'เหตุใดผลงานนี้จึงมีชื่อเสียง? สำรวจประเด็นทางปรัชญาหรือวัฒนธรรมใดบ้าง?';

  @override
  String get aBriefBioOfTheAuthor => 'ประวัติโดยย่อของผู้ประพันธ์';

  @override
  String get informationUnavailable => 'ไม่มีข้อมูล';

  @override
  String get noSummaryAvailable => 'ไม่มีบทสรุป';

  @override
  String get hanziAiPro => 'Hanzi AI Pro';

  @override
  String get trialNormalIntro => 'TRIAL\', \'NORMAL\', \'INTRO';

  @override
  String get dailyDrop => 'บทเรียนรายวัน';

  @override
  String get dailyNotificationsForWordOfTheDayAn =>
      'การแจ้งเตือนรายวันสำหรับคำศัพท์ประจำวันและข่าวสาร';

  @override
  String get aNewWordAndStoryOfTheDayAreWaitingF =>
      'คำศัพท์และนิทานประจำวันใหม่กำลังรอคุณอยู่!';

  @override
  String get spacedRepetition => 'การทบทวนแบบเว้นระยะ (Spaced Repetition)';

  @override
  String get remindersForFlashcardsDueForReview =>
      'การแจ้งเตือนแฟลชการ์ดที่ถึงกำหนดทบทวน';

  @override
  String get engagementReminders => 'การแจ้งเตือนการมีส่วนร่วม';

  @override
  String get trialReminders => 'การแจ้งเตือนช่วงทดลองใช้';

  @override
  String get notificationsForYourTrialStatus =>
      'การแจ้งเตือนสถานะการทดลองใช้งานของคุณ';

  @override
  String get comeReviewYourHanziAndTryALiveCallB =>
      'กลับมาทบทวนอักษรจีนและลองใช้ Live Call ก่อนที่สิทธิ์ทดลองใช้ฟรีของคุณจะหมดลง!';

  @override
  String get scholarsEye => 'ดวงตาบัณฑิต (Scholar\'s Eye)';

  @override
  String get clMeasureWord => 'CL:\', \'คำลักษณนาม:';

  @override
  String get surnameShi => 'แซ่สือ (Shi)';

  @override
  String get chineseFamilyNameShi => 'นามสกุลจีน (สือ / Shi)';

  @override
  String get neutralToneLight => 'เสียงเบา (เสียงกลาง)';

  @override
  String get keepYourPitchHighAndSteadyLikeSingi =>
      'รักษาโทนเสียงให้สูงและคงที่ คล้ายการร้องตัวโน้ต';

  @override
  String get startInTheMiddleAndSlideYourPitchUp =>
      'เริ่มจากเสียงระดับกลางแล้วลากเสียงขึ้น คล้ายตอนถามว่า \'อะไรนะ?\'';

  @override
  String get dipYourVoiceDownLowThenRiseGentlyBa =>
      'กดเสียงลงต่ำ แล้วค่อยๆ ลากเสียงกลับขึ้นมาอย่างนุ่มนวล';

  @override
  String get dropYourPitchSharplyAndDecisivelyLi =>
      'ทอดเสียงลงอย่างหนักแน่นและเด็ดขาด คล้ายคำว่า \'ไม่!\'';

  @override
  String get pronounceSoftlyBrieflyAndWithoutEmp =>
      'ออกเสียงเบาๆ สั้นๆ โดยไม่ต้องเน้นเสียง';

  @override
  String get spotOnPitchWasHighFlatAndSteady =>
      'ถูกต้องแม่นยำ! ระดับเสียงสูง ราบเรียบ และคงที่';

  @override
  String get spotOnUpwardPitchRiseWasClear =>
      'ถูกต้องแม่นยำ! การลากเสียงขึ้นทำได้อย่างชัดเจน';

  @override
  String get spotOnLowDippingCurveWasAccurate =>
      'ถูกต้องแม่นยำ! เส้นเสียงกดต่ำแล้วขึ้นมีความถูกต้อง';

  @override
  String get spotOnSharpFallingDropWasDecisive =>
      'ถูกต้องแม่นยำ! เสียงตกลงอย่างเด็ดขาดและหนักแน่น';

  @override
  String get spotOnToneWasPronouncedAccurately =>
      'ถูกต้องแม่นยำ! ออกเสียงวรรณยุกต์ได้อย่างถูกต้อง';

  @override
  String get iAgreeToTheTermsOfServiceAndPrivacy =>
      'ฉันยอมรับข้อกำหนดการให้บริการและนโยบายความเป็นส่วนตัว';

  @override
  String get sendMeOccasionalUpdatesTipsAndOffer =>
      'ส่งข่าวสารอัปเดต เคล็ดลับ และข้อเสนอพิเศษเป็นครั้งคราว';

  @override
  String get signInToSyncYourProgress =>
      'เข้าสู่ระบบเพื่อซิงค์ความคืบหน้าของคุณ';

  @override
  String get createAnAccountToSaveYourStats =>
      'สร้างบัญชีเพื่อบันทึกสถิติของคุณ';

  @override
  String get smartSpiral => 'เกลียวการเรียนรู้อัจฉริยะ (SMART SPIRAL)';

  @override
  String get origin => 'ต้นกำเนิด';

  @override
  String get elements => 'ธาตุธรรมชาติ';

  @override
  String get humanity => 'มนุษยชาติ';

  @override
  String get village => 'หมู่บ้าน';

  @override
  String get journey => 'การเดินทาง';

  @override
  String get city => 'เมือง';

  @override
  String get originTheSimplestShapesTheBeginning =>
      'Origin\': \'รูปทรงที่เรียบง่ายที่สุด จุดเริ่มต้นของสรรพสิ่ง';

  @override
  String get elementsSunMoonWaterAndFireTheNatur =>
      'Elements\': \'ดวงอาทิตย์ ดวงจันทร์ น้ำ และไฟ โลกแห่งธรรมชาติ';

  @override
  String get humanityTheBodyTheHeartAndTheFamily =>
      'Humanity\': \'ร่างกาย จิตใจ และครอบครัว';

  @override
  String get villageFieldsRoofsAndToolsTheFounda =>
      'Village\': \'ทุ่งนา หลังคา และเครื่องมือ รากฐานแห่งสังคม';

  @override
  String get journeyMovementSpeechAndSustenance =>
      'Journey\': \'การเคลื่อนไหว คำพูด และการดำรงชีพ';

  @override
  String get cityCommerceClothingAndComplexArtif =>
      'City\': \'การค้า เครื่องนุ่งห่ม และสิ่งประดิษฐ์อันประณีต';

  @override
  String get equilibriumAlgorithm => 'อัลกอริทึมสมดุล (Equilibrium Algorithm)';

  @override
  String get misc => 'อื่นๆ';

  @override
  String get cityOrOriginAs => 'City\' หรือ \'Origin\' เป็น';

  @override
  String get miscToOrigin => 'Misc\' เป็น \'Origin';

  @override
  String get constellation => 'กลุ่มดาว';

  @override
  String get whichOneIsWater => 'ตัวอักษรใดคือ \'น้ำ\'?';

  @override
  String get whatIsThePinyin => 'พินอินคืออะไร?';

  @override
  String get nature => 'ธรรมชาติ';

  @override
  String get whatEssenceDoes => 'หัวใจสำคัญใดที่';

  @override
  String get allTiers => 'ทุกระดับ';

  @override
  String get active => 'ใช้งานอยู่';

  @override
  String get theScrollOfOrigin1 => 'ม้วนคัมภีร์ต้นกำเนิด';

  @override
  String galaxyOf1(Object name) {
    return 'กาแล็กซีแห่ง';
  }

  @override
  String get also => 'ด้วย / เช่นกัน';

  @override
  String get work => 'ทำงาน';

  @override
  String get cloud => 'เมฆ';

  @override
  String get youArchaic => 'ท่าน / เจ้า (ภาษาโบราณ)';

  @override
  String get suddenly => 'ทันใดนั้น';

  @override
  String get owner => 'เจ้าของ';

  @override
  String get door => 'ประตู';

  @override
  String get occupy => 'ครอบครอง';

  @override
  String get nail => 'ตะปู';

  @override
  String get and => 'และ';

  @override
  String get buddhistNun => 'แม่ชี';

  @override
  String get anxious => 'กังวล';

  @override
  String get sprout => 'หน่ออ่อน / ยอดอ่อน';

  @override
  String get exchange => 'แลกเปลี่ยน';

  @override
  String get sheep => 'แกะ';

  @override
  String get strange => 'แปลกประหลาด';

  @override
  String get opposite => 'ตรงกันข้าม';

  @override
  String get shorttailedBird => 'นกหางสั้น';

  @override
  String get shoot => 'ยิง';

  @override
  String get small => 'เล็ก';

  @override
  String get gather => 'รวบรวม';

  @override
  String get order => 'สั่ง / ลำดับ';

  @override
  String get flat => 'แบน / ราบ';

  @override
  String get thePersonWho => 'ผู้ที่...';

  @override
  String get nobleman => 'ขุนนาง / ชนชั้นสูง';

  @override
  String get cause => 'สาเหตุ';

  @override
  String get pig => 'หมู';

  @override
  String get bright => 'สว่างไสว';

  @override
  String get slowly => 'อย่างช้าๆ';

  @override
  String get give => 'ให้';

  @override
  String get arrow => 'ลูกศร / ลูกธนู';

  @override
  String get dry => 'แห้ง';

  @override
  String get obstacle => 'อุปสรรค';

  @override
  String get beg => 'ขอร้อง / ขอทาน';

  @override
  String get window => 'หน้าต่าง';

  @override
  String get fear => 'ความกลัว';

  @override
  String get drum => 'กลอง';

  @override
  String get why => 'ทำไม';

  @override
  String get talent => 'พรสวรรค์ / ความสามารถ';

  @override
  String get follow => 'ติดตาม / ตาม';

  @override
  String get desert => 'ทะเลทราย';

  @override
  String get component => 'ส่วนประกอบ';

  @override
  String divingInto1(Object topic) {
    return 'กำลังเข้าสู่';
  }

  @override
  String get unitIntro1 => 'บทนำประจำหน่วย';

  @override
  String get theBlueprint => 'พิมพ์เขียว';

  @override
  String get theOrigin => 'ต้นกำเนิด';

  @override
  String get theGalaxy => 'กาแล็กซี';

  @override
  String get theScholarListens => 'บัณฑิตกำลังตั้งใจฟัง...';

  @override
  String get consultingTheScrolls => 'กำลังค้นหาในม้วนคัมภีร์...';

  @override
  String get traceWithTheGuide => 'ลากเส้นตามเส้นนำทาง';

  @override
  String get traceTheGhost => 'ลากเส้นตามรอยจาง';

  @override
  String get connectTheDots => 'ลากเส้นเชื่อมจุด';

  @override
  String get drawFromMemory => 'เขียนจากความจำ';

  @override
  String get assistant => 'ผู้ช่วย';

  @override
  String get puck => 'Puck';

  @override
  String get helloWelcomeWhatWouldYouLikeToOrder =>
      'สวัสดีครับ/ค่ะ! ยินดีต้อนรับ รับอะไรดีครับ/ค่ะ?';

  @override
  String get ni3Hao3Huan1ying2Guang1lin2Qing3wen =>
      'Ni3 hao3! Huan1ying2 guang1lin2. Qing3wen4 ni3 yao4 dian3 shen2me?';

  @override
  String get waiterLi => 'บริกรหลี่ (Waiter Li)';

  @override
  String get askForTheMenu => 'ขอดูเมนูอาหาร';

  @override
  String get orderOneDishAndOneDrink => 'สั่งอาหาร 1 จานและเครื่องดื่ม 1 แก้ว';

  @override
  String get askForTheBill => 'เช็คบิล / ขอใบเสร็จ';

  @override
  String get fenrir => 'Fenrir';

  @override
  String get ni3Qu4Na3rAJi1chang3MaTing3Yuan3De =>
      'Ni3 qu4 na3r a? Ji1chang3 ma? Ting3 yuan3 de!';

  @override
  String get driverWang => 'คนขับหวัง (Driver Wang)';

  @override
  String get tellTheDriverYouAreGoingToTheAirpor =>
      'บอกคนขับว่าคุณกำลังจะไปสนามบิน';

  @override
  String get askHowLongTheTripWillTake => 'Ask how long the trip will take';

  @override
  String get complainAboutTheTraffic => 'Complain about the traffic';

  @override
  String get charon => 'Charon';

  @override
  String get thisClothingQualityIsEspeciallyGood =>
      'This clothing quality is especially good, only 200 kuai.';

  @override
  String get zhe4Jian4Yi1fuZhi4liang4Te4bie2Hao3 =>
      'Zhe4 jian4 yi1fu zhi4liang4 te4bie2 hao3, zhi3yao4 liang3 bai3 kuai4.';

  @override
  String get auntieChen => 'Auntie Chen';

  @override
  String get askHowMuchTheSilkShirtCosts => 'Ask how much the silk shirt costs';

  @override
  String get sayItIsTooExpensive => 'Say it is too expensive';

  @override
  String get bargainThePriceDownTo100Rmb => 'Bargain the price down to 100 RMB';

  @override
  String get ni3Na3li3Bu4Shu1fuFa1shao1LeMa =>
      'Ni3 na3li3 bu4 shu1fu? Fa1shao1 le ma?';

  @override
  String get drZhang => 'Dr. Zhang';

  @override
  String get explainYouHaveHadAHeadacheForTwoDay =>
      'Explain you have had a headache for two days';

  @override
  String get sayYouHaveASlightFever => 'Say you have a slight fever';

  @override
  String get askIfYouNeedToTakeMedicine => 'Ask if you need to take medicine';

  @override
  String get aoede => 'Aoede';

  @override
  String get heyLongTimeNoSeeHowHaveYouBeenLatel =>
      'Hey! Long time no see, how have you been lately?';

  @override
  String get ni3Hao3Hao3jiu3Bu4jian4Ni3Zui4jin4Z =>
      'Ni3 hao3! Hao3jiu3 bu4jian4, ni3 zui4jin4 zen3me yang4?';

  @override
  String get pleaseIntroduceYourselfWhyDoYouWant =>
      'Please introduce yourself. Why do you want to work at our company?';

  @override
  String get qing3Xian1Zi4wo3Jie4shao4Yi1xia4Ni3 =>
      'Qing3 xian1 zi4wo3 jie4shao4 yi1xia4. Ni3 wei4shen2me xiang3 lai2 wo3men gong1si1 gong1zuo4?';

  @override
  String get managerLiu => 'Manager Liu';

  @override
  String get introduceYourProfessionalBackground =>
      'Introduce your professional background briefly';

  @override
  String get explainWhyYouWantToWorkAtThisCompan =>
      'Explain why you want to work at this company';

  @override
  String get askAPoliteQuestionAboutTheCompanyCu =>
      'Ask a polite question about the company culture';

  @override
  String get microphoneAccessIsRequiredPleaseEna =>
      'Microphone access is required. Please enable it in your device Settings.';

  @override
  String get couldNotStartMicrophonePleaseCheckY =>
      'Could not start microphone. Please check your audio settings and try again.';

  @override
  String get weDidntQuiteCatchThatPleaseHoldTheM =>
      'We didn\'t quite catch that. Please hold the mic and try again!';

  @override
  String get recordingWasTooShortHoldTheMicAndSp =>
      'Recording was too short. Hold the mic and speak clearly.';

  @override
  String get audioBufferWasEmptyPleaseCheckYourM =>
      'Audio buffer was empty. Please check your microphone and try again.';

  @override
  String get audioFileIsSilentPleaseSpeakIntoThe =>
      'Audio file is silent. Please speak into the microphone.';

  @override
  String get weCouldntUnderstandYourPronunciatio =>
      'We couldn\'t understand your pronunciation. Please speak clearly and try again.';

  @override
  String get theServerIsTakingTooLongToRespondPl =>
      'The server is taking too long to respond. Please try again.';

  @override
  String get noInternetConnectionPleaseCheckYour =>
      'No internet connection. Please check your network and try again.';

  @override
  String get audioProcessingFailedPleaseTryAgain =>
      'Audio processing failed. Please try again.';

  @override
  String get permission => 'Permission';

  @override
  String get couldNotProcessYourRecordingPleaseT =>
      'Could not process your recording. Please try again.';

  @override
  String get user => 'User';

  @override
  String get scholar => 'Scholar';

  @override
  String get ourAiTutorsAreCurrentlyOfflinePleas =>
      'Our AI tutors are currently offline, please try again later.';

  @override
  String get hideTranslation => 'Hide Translation';

  @override
  String get azureAssessment => 'Azure Assessment...';

  @override
  String get microphonePermissionRequired => 'Microphone permission required';

  @override
  String get connectedSpeakNow => 'Connected! Speak now.';

  @override
  String get initializationErrorCheckPermissions =>
      'Initialization error. Check permissions.';

  @override
  String get microphoneErrorTapToRetry => 'Microphone error. Tap to retry.';

  @override
  String get theTutorReturnedAnEmptyResponse =>
      'The tutor returned an empty response';

  @override
  String get connectionInterruptedPleaseSpeakAga =>
      'Connection interrupted. Please speak again.';

  @override
  String get callPausedReviewingTones => 'Call Paused (Reviewing Tones)';

  @override
  String get pausedTakeABreak => 'Paused - Take a break';

  @override
  String get goodStartPracticing => 'Good start practicing';

  @override
  String get studentCoach => 'STUDENT\' : \'COACH';

  @override
  String get keepYour1stToneHighAndSteadyOn =>
      'Keep your 1st tone high and steady on';

  @override
  String get noScenariosFound => 'No scenarios found.';

  @override
  String get designYourOwnAiRoleplayExperience =>
      'Design your own AI roleplay experience';

  @override
  String get generateFromDeck => 'Generate from Deck';

  @override
  String get practiceFlashcardVocabularyInALiveD =>
      'Practice flashcard vocabulary in a live dialogue';

  @override
  String get tapToRoleplay => 'Tap to roleplay';

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
  String get dinnerWithDad => 'Dinner with Dad';

  @override
  String get orderingAtAChengduTeahouse => 'Ordering at a Chengdu Teahouse';

  @override
  String get buyingTeaAtTheMarket => 'Buying Tea at the Market';

  @override
  String get meetingAnOldClassmate => 'Meeting an Old Classmate';

  @override
  String get readyToPractice => 'Ready to practice?';

  @override
  String get letsPracticeChinese => 'Let\'s practice Chinese';

  @override
  String get areYouReady => 'Are you ready?';

  @override
  String get discussWhatToHaveForDinner => 'Discuss what to have for dinner';

  @override
  String get suggestWatchingAMovieAfterwards =>
      'Suggest watching a movie afterwards';

  @override
  String get askIfTheyWouldLikeTea => 'Ask if they would like tea';

  @override
  String get helloVeryNiceToMeetYou => 'Hello! Very nice to meet you.';

  @override
  String get deckPractice => 'Deck Practice';

  @override
  String get practiceVocabularyWithAnAiPartner =>
      'Practice vocabulary with an AI partner.';

  @override
  String get designCustomAiRoleplayConversation =>
      'Design custom AI roleplay & conversation';

  @override
  String get random => 'Random';

  @override
  String get scenarioTopic => 'Scenario Topic';

  @override
  String get contextSettingOptional => 'Context & Setting (Optional)';

  @override
  String get aiCharacterPersonaOptional => 'AI Character / Persona (Optional)';

  @override
  String get aQuietBambooCourtyardTeahouseInChen =>
      'A quiet bamboo courtyard teahouse in Chengdu with gentle guzheng music playing.';

  @override
  String get aBustlingSmokyNightMarketFilledWith =>
      'A bustling, smoky night market filled with skewers, steamed buns, and street food stalls.';

  @override
  String get aLivelyHotpotRestaurantInChongqingW =>
      'A lively hotpot restaurant in Chongqing with boiling crimson broth and fragrant chili aroma.';

  @override
  String get aBustlingTraditionalCantoneseTeahou =>
      'A bustling traditional Cantonese teahouse in Guangzhou filled with steaming bamboo baskets.';

  @override
  String get aChicMinimalistCafeInTheFrenchConce =>
      'A chic minimalist cafe in the French Concession during a rainy Sunday afternoon.';

  @override
  String get aWarmNorthernHomeKitchenDuringWinte =>
      'A warm northern home kitchen during winter with flour on the table and steaming dumpling pots.';

  @override
  String get anOpenairNightStreetFoodAlleyWithSi =>
      'An open-air night street food alley with sizzling lamb skewers, roasted eggplant, and cold beer.';

  @override
  String get aSnowyStreetCornerOutsideTheLamaTem =>
      'A snowy street corner outside the Lama Temple with glowing red candied hawthorn skewers on ice.';

  @override
  String get craftBeerBreweryInQingdao => 'Craft Beer Brewery in Qingdao';

  @override
  String get aLivelyCoastalTaproomWithWoodenBarr =>
      'A lively coastal taproom with wooden barrels, ocean breeze, and fresh wheat beer taps.';

  @override
  String get sichuanCookingMasterclass => 'Sichuan Cooking Masterclass';

  @override
  String get aVibrantOpenKitchenWithWoksBlazingC =>
      'A vibrant open kitchen with woks blazing, chili oil simmering, and fresh peppercorns.';

  @override
  String get highspeedRailSeatMixup => 'High-Speed Rail Seat Mix-Up';

  @override
  String get greatWallSunriseTrekInMutianyu =>
      'Great Wall Sunrise Trek in Mutianyu';

  @override
  String get theAncientStoneRampartsOfTheGreatWa =>
      'The ancient stone ramparts of the Great Wall at dawn, surrounded by misty green mountains.';

  @override
  String get bambooRaftDriftOnGuilinLiRiver =>
      'Bamboo Raft Drift on Guilin Li River';

  @override
  String get glidingAlongEmeraldKarstWatersBetwe =>
      'Gliding along emerald karst waters between dramatic misty limestone peaks near Yangshuo.';

  @override
  String get silkRoadCamelTrekInDunhuang => 'Silk Road Camel Trek in Dunhuang';

  @override
  String get theRollingGoldenSandDunesOfMingshaM =>
      'The rolling golden sand dunes of Mingsha Mountain next to the Crescent Lake oasis.';

  @override
  String get bookingACourtyardHomestayInDali =>
      'Booking a Courtyard Homestay in Dali';

  @override
  String get aSereneBaistyleBoutiqueCourtyardHot =>
      'A serene Bai-style boutique courtyard hotel overlooking Erhai Lake in Yunnan.';

  @override
  String get potalaPalacePilgrimageInLhasa =>
      'Potala Palace Pilgrimage in Lhasa';

  @override
  String get theMajesticSundrenchedStoneStepsOut =>
      'The majestic sun-drenched stone steps outside the Potala Palace with spinning prayer wheels.';

  @override
  String get aSubzeroWonderlandOfIlluminatedCrys =>
      'A sub-zero wonderland of illuminated crystal ice palaces and towering snow sculptures.';

  @override
  String get zhangjiajieAvatarMountainCableCar =>
      'Zhangjiajie Avatar Mountain Cable Car';

  @override
  String get suspendedHighInAGlassCableCarSoarin =>
      'Suspended high in a glass cable car soaring above thousands of sandstone pillar peaks.';

  @override
  String get gobiDesertStargazingCampInGansu =>
      'Gobi Desert Stargazing Camp in Gansu';

  @override
  String get aLuxuryYurtCampUnderACrystalclearMi =>
      'A luxury yurt camp under a crystal-clear Milky Way sky in the desert outside Jiayuguan.';

  @override
  String get yangtzeRiverThreeGorgesCruise =>
      'Yangtze River Three Gorges Cruise';

  @override
  String get onTheSunDeckOfARiverCruiseShipPassi =>
      'On the sun deck of a river cruise ship passing through the dramatic towering Qutang Gorge.';

  @override
  String get buyingAntiquesInBeijingPanjiayuan =>
      'Buying Antiques in Beijing Panjiayuan';

  @override
  String get aHistoricPotteryKilnFilledWithDelic =>
      'A historic pottery kiln filled with delicate unfired porcelain vases and cobalt blue glazes.';

  @override
  String get suzhouSilkEmbroideryStudio => 'Suzhou Silk Embroidery Studio';

  @override
  String get aPeacefulCanalsideGardenStudioInSuz =>
      'A peaceful canal-side garden studio in Suzhou with fine silk threads and wooden embroidery frames.';

  @override
  String get backstageAtATraditionalBeijingOpera =>
      'Backstage at a traditional Beijing opera theater with colorful costumes, mirrors, and headpieces.';

  @override
  String get traditionalChineseMedicineConsultat =>
      'Traditional Chinese Medicine Consultation';

  @override
  String get morningTaiChiInTempleOfHeavenPark =>
      'Morning Tai Chi in Temple of Heaven Park';

  @override
  String get beneathAncientCypressTreesAtDawnWit =>
      'Beneath ancient cypress trees at dawn with park birds and seniors practicing synchronized movements.';

  @override
  String get rentingAHanfuForAPhotoShoot => 'Renting a Hanfu for a Photo Shoot';

  @override
  String get aTraditionalCostumeBoutiqueNearTheW =>
      'A traditional costume boutique near the West Lake with racks of Tang and Song dynasty robes.';

  @override
  String get guqinAncientZitherInstrumentWorksho =>
      'Guqin Ancient Zither Instrument Workshop';

  @override
  String get aQuietPinewoodStudioInHangzhouFille =>
      'A quiet pine-wood studio in Hangzhou filled with aged paulownia wood and silk-string instruments.';

  @override
  String get shaanxiShadowPuppetTheater => 'Shaanxi Shadow Puppet Theater';

  @override
  String get behindAnIlluminatedWhiteSilkScreenW =>
      'Behind an illuminated white silk screen with delicate translucent leather shadow figures.';

  @override
  String get chineseCalligraphyWorkshop => 'Chinese Calligraphy Workshop';

  @override
  String get aTranquilStudioScentedWithPineSootI =>
      'A tranquil studio scented with pine soot ink, rice paper scrolls, and soft tea aromas.';

  @override
  String get adoptingACatAtAnAnimalShelter =>
      'Adopting a Cat at an Animal Shelter';

  @override
  String get aCozyPetRescueCenterInHangzhouWithE =>
      'A cozy pet rescue center in Hangzhou with energetic rescue kittens and tea for visitors.';

  @override
  String get scriptMurderMysteryJubenshaGame =>
      'Script Murder Mystery (Jubensha) Game';

  @override
  String get aThemedDetectiveLoungeInShanghaiWit =>
      'A themed detective lounge in Shanghai with costumed players and candlelight.';

  @override
  String get vintageVinylRecordShopInShanghai =>
      'Vintage Vinyl Record Shop in Shanghai';

  @override
  String get aHiddenVinylStoreInAnOldLaneHousePa =>
      'A hidden vinyl store in an old lane house packed with classic 80s Cantopop and jazz records.';

  @override
  String get ktvKaraokePartyWithFriends => 'KTV Karaoke Party with Friends';

  @override
  String get joiningACityBikeCyclingClub => 'Joining a City Bike Cycling Club';

  @override
  String get aGatheringOfCyclistsByTheRiverfront =>
      'A gathering of cyclists by the riverfront preparing for an evening ride around the city skyline.';

  @override
  String get blindBoxToyTradingMeetup => 'Blind Box Toy Trading Meetup';

  @override
  String get aColorfulPopcultureToyStoreInChaoya =>
      'A colorful pop-culture toy store in Chaoyang with display shelves and unopened collectible boxes.';

  @override
  String get droneSkylineVideographyAtTheBund =>
      'Drone Skyline Videography at the Bund';

  @override
  String get theBundPromenadeAtDuskOverlookingTh =>
      'The Bund promenade at dusk overlooking the futuristic illuminated skyscrapers of Pudong.';

  @override
  String get goldenRetrieverCafeInNanjing => 'Golden Retriever Cafe in Nanjing';

  @override
  String get aSunnyCheerfulPetCafeWithDozensOfFr =>
      'A sunny, cheerful pet cafe with dozens of friendly, fluffy dogs greeting visitors.';

  @override
  String get boulderingClimbingGymInChengdu =>
      'Bouldering Climbing Gym in Chengdu';

  @override
  String get aModernIndoorClimbingGymWithVibrant =>
      'A modern indoor climbing gym with vibrant colored hold routes and energetic music.';

  @override
  String get aMassiveConventionHallFilledWithCol =>
      'A massive convention hall filled with colorful game booths, photo walls, and costumed creators.';

  @override
  String get askingForDirectionsInABeijingHutong =>
      'Asking for Directions in a Beijing Hutong';

  @override
  String get aMazeOfHistoricGreybrickAlleysWithB =>
      'A maze of historic grey-brick alleys with bicycles, courtyards, and pomegranate trees.';

  @override
  String get buyingFreshFruitAtAWetMarket =>
      'Buying Fresh Fruit at a Wet Market';

  @override
  String get aLivelyMorningNeighborhoodMarketWit =>
      'A lively morning neighborhood market with mounds of fresh lychees, mangoes, and dragonfruit.';

  @override
  String get flowerMarketBouquetInKunming => 'Flower Market Bouquet in Kunming';

  @override
  String get theFamousDounanFlowerMarketSurround =>
      'The famous Dounan Flower Market surrounded by thousands of fresh roses, lilies, and eucalyptus stems.';

  @override
  String get tailorAlterationsInAnOldLaneHouse =>
      'Tailor Alterations in an Old Lane House';

  @override
  String get aTraditionalTailorShopFilledWithSew =>
      'A traditional tailor shop filled with sewing machines, fabrics, and measuring tapes.';

  @override
  String get expressParcelLockerRetrieval => 'Express Parcel Locker Retrieval';

  @override
  String get downstairsAtAResidentialApartmentGa =>
      'Downstairs at a residential apartment gate next to a smart Hive box locker system.';

  @override
  String get bicycleFlatTireRepairAtCampusGate =>
      'Bicycle Flat Tire Repair at Campus Gate';

  @override
  String get aSmallOutdoorRoadsideToolkitStandUn =>
      'A small outdoor roadside toolkit stand under a large leafy banyan tree.';

  @override
  String get techCompanyProductDemo => 'Tech Company Product Demo';

  @override
  String get aFuturisticTechConferenceBoothInShe =>
      'A futuristic tech conference booth in Shenzhen showcasing cutting-edge AI hardware.';

  @override
  String get ecommerceLivestreamStudio => 'E-commerce Live-Stream Studio';

  @override
  String get aHighenergyBroadcastStudioWithRingL =>
      'A high-energy broadcast studio with ring lights, product display racks, and live comment monitors.';

  @override
  String get yiwuInternationalTradeMarket => 'Yiwu International Trade Market';

  @override
  String get aVastMultistoryCommercialExhibition =>
      'A vast multi-story commercial exhibition mall filled with millions of wholesale goods and crafts.';

  @override
  String get universityCampusExchangeProgram =>
      'University Campus Exchange Program';

  @override
  String get aSunnyLawnOutsideTheUniversityLibra =>
      'A sunny lawn outside the university library with students studying and drinking milk tea.';

  @override
  String get pleaseEnterAScenarioTopic => 'Please enter a scenario topic.';

  @override
  String get nameTitle => 'Name (Title)';

  @override
  String get aiCharacter => 'AI Character';

  @override
  String get helloWelcomeHereWhatShallWeChatAbou =>
      'Hello! Welcome here, what shall we chat about today?';

  @override
  String get greetYourConversationPartner => 'Greet your conversation partner';

  @override
  String get askAQuestionInChinese => 'Ask a question in Chinese';

  @override
  String get pinyinWithToneMarks => 'Pinyin with tone marks';

  @override
  String get goal1InEnglish => 'Goal 1 in English';

  @override
  String get goal2InEnglish => 'Goal 2 in English';

  @override
  String get goal3InEnglish => 'Goal 3 in English';

  @override
  String get beginner => 'Beginner';

  @override
  String get hsk12 => 'HSK 1-2';

  @override
  String get hsk34 => 'HSK 3-4';

  @override
  String get hsk56 => 'HSK 5-6';

  @override
  String get master => 'Master';

  @override
  String get azurePronunciationAssessment => 'AZURE PRONUNCIATION ASSESSMENT';

  @override
  String get tapToReview => 'Tap to review';

  @override
  String get overallScore => 'Overall Score';

  @override
  String get toneAccuracy => 'Tone Accuracy';

  @override
  String get fluency => 'Fluency';

  @override
  String get report => 'Report';

  @override
  String get goodPronunciationButCanBeBetter =>
      'Good pronunciation, but can be better!';

  @override
  String get didYouMeanToSay => 'Did you mean to say...?';

  @override
  String get greatKeepTrying => 'Great!\' : \'Keep trying!';

  @override
  String get completeness => 'Completeness';

  @override
  String get targetTone => 'Target Tone';

  @override
  String get k4toneComparisonTapToListen =>
      '4-Tone Comparison (Tap to Listen):';

  @override
  String get youSpokeMatch => 'You Spoke (Match!)';

  @override
  String get youSpoke => 'You Spoke';

  @override
  String get yourPrimaryCollectionOfCharacters =>
      'Your primary collection of characters.';

  @override
  String get deckNotFound => 'Deck not found';

  @override
  String get cannotDeleteTheDefaultDeck => 'Cannot delete the default deck';

  @override
  String get hsk4UpperIntermediate1 => 'HSK 4: Upper Intermediate';

  @override
  String get theFirst150CharactersToStartYourJou =>
      'The first 150 characters to start your journey.';

  @override
  String get buildYourVocabularyTo300EssentialWo =>
      'Build your vocabulary to 300 essential words.';

  @override
  String get masterConversationalFluencyWith600W =>
      'Master conversational fluency with 600 words.';

  @override
  String get readTextsAndConverseFluentlyWith120 =>
      'Read texts and converse fluently with 1200 words.';

  @override
  String get readNewspapersAndWatchMoviesWith250 =>
      'Read newspapers and watch movies with 2500 words.';

  @override
  String get databaseBoxNotOpen => 'Database box not open';

  @override
  String get hsk1DataFileIsEmpty => 'HSK1 data file is empty';

  @override
  String get gold => 'Gold';

  @override
  String get globalDictionaryNotInitialized =>
      'Global Dictionary not initialized';

  @override
  String get reading => 'Reading';

  @override
  String get recall => 'Recall';

  @override
  String get speaking => 'Speaking';

  @override
  String get listening1 => 'Listening';

  @override
  String get practiceStrokeOrderWithVisualGuides =>
      'Practice stroke order with visual guides.';

  @override
  String get seeTheCharacterRecallThePinyinAndMe =>
      'See the character, recall the Pinyin and Meaning.';

  @override
  String get seeTheMeaningDrawTheCharacterFromMe =>
      'See the meaning, draw the character from memory.';

  @override
  String get readOutLoudToTestYourPronunciationT =>
      'Read out loud to test your pronunciation tones.';

  @override
  String get listenToTheAudioAndIdentifyTheChara =>
      'Listen to the audio and identify the character.';

  @override
  String get contract => 'Contract';

  @override
  String get whoeverImplementsMeMustBeAbleToDoTh =>
      'Whoever implements me MUST be able to do these things.';

  @override
  String get koreFenrirCharonAoedePuckOrLocal =>
      'Kore\', \'Fenrir\', \'Charon\', \'Aoede\', \'Puck\', or \'local';

  @override
  String get manageDecks => 'Manage Decks';

  @override
  String get weRanIntoTroubleLoadingTheLibraryPl =>
      'We ran into trouble loading the library. Please try again.';

  @override
  String get noCharactersInLexicon1 => 'No characters in lexicon';

  @override
  String get masterTheBuildingBlocks => 'Master the building blocks';

  @override
  String get other => 'Other';

  @override
  String get required => 'Required';

  @override
  String get library1 => 'Library';

  @override
  String get youAreAPremiumMember => 'You are a Premium member';

  @override
  String get createAccountToSyncProgress => 'Create Account to Sync Progress';

  @override
  String get signOut => 'Sign Out';

  @override
  String get account => 'Account';

  @override
  String get guestScholar => 'Guest Scholar';

  @override
  String get localAccount => 'Local Account';

  @override
  String get unknownRadical => 'Unknown Radical';

  @override
  String get followTheGuideStroke => 'Follow the guide stroke';

  @override
  String get strokeAnimationSpeed => 'Stroke Animation Speed';

  @override
  String get notifications => 'Notifications';

  @override
  String get deutsch => 'Deutsch';

  @override
  String get bahasaIndonesia => 'Bahasa Indonesia';

  @override
  String get italiano => 'Italiano';

  @override
  String get today1d2d3d4d5d6d =>
      'Today\', \'1d\', \'2d\', \'3d\', \'4d\', \'5d\', \'6d';

  @override
  String get targetDeck => 'Target Deck';

  @override
  String get mixed => 'Mixed';

  @override
  String get topicForContext => 'Topic (for context)';

  @override
  String get nounsOnly => 'Nouns only';

  @override
  String get verbsOnly => 'Verbs only';

  @override
  String get idiomsChengyu => 'Idioms (Chengyu)';

  @override
  String get fullSentences => 'Full Sentences';

  @override
  String get beginnerHsk12 => 'Beginner (HSK 1-2)';

  @override
  String get intermediateHsk34 => 'Intermediate (HSK 3-4)';

  @override
  String get advancedHsk56 => 'Advanced (HSK 5-6)';

  @override
  String get generatedByAi => 'Generated by AI';

  @override
  String get canYouGiveMeTwoMoreExamplesUsingThi =>
      'Can you give me two more examples using this word?';

  @override
  String get whatAreSomeSimilarWordsAndHowDoThey =>
      'What are some similar words and how do they differ?';

  @override
  String get isThisWordUsedInSpokenOrWrittenChin =>
      'Is this word used in spoken or written Chinese more?';

  @override
  String get areThereOtherWaysToTranslateThisWor =>
      'Are there other ways to translate this word?';

  @override
  String get whatAreCommonWordsThatGoTogetherWit =>
      'What are common words that go together with this word?';

  @override
  String get whatAreCommonMistakesLearnersMakeWi =>
      'What are common mistakes learners make with this word?';

  @override
  String get emptyResponse => 'Empty response';

  @override
  String get whatIsTheOracleBoneScriptOriginOfTh =>
      'What is the oracle bone script origin of this character?';

  @override
  String get howDidTheAncientFormOfThisCharacter =>
      'How did the ancient form of this character evolve over time?';

  @override
  String get giveMe3CommonWordsThatContainThisCh =>
      'Give me 3 common words that contain this character.';

  @override
  String get whatOtherCharactersShareTheSameRadi =>
      'What other characters share the same radical?';

  @override
  String get isThereAChineseProverbOrSayingFeatu =>
      'Is there a Chinese proverb or saying featuring this character?';

  @override
  String get explainTheStrokeOrderRulesForThisCh =>
      'Explain the stroke order rules for this character.';

  @override
  String get giveMeOneCalligraphyTipForWritingTh =>
      'Give me one calligraphy tip for writing this character beautifully.';

  @override
  String get isThereAnythingTrickyAboutUsingThis =>
      'Is there anything tricky about using this grammatically?';

  @override
  String get whatWordsAreCommonlyConfusedWithThi =>
      'What words are commonly confused with this one and why?';

  @override
  String get doesThisCharacterCarryCulturalSymbo =>
      'Does this character carry cultural symbolism in China?';

  @override
  String get isThisCharacterCommonlySeenInChines =>
      'Is this character commonly seen in Chinese movies, songs, or texts?';

  @override
  String get whatDoesTheRadicalOfThisCharacterMe =>
      'What does the radical of this character mean?';

  @override
  String get breakDownEveryComponentAndItsMeanin =>
      'Break down every component and its meaning.';

  @override
  String get giveMeATrickToRememberTheCorrectTon =>
      'Give me a trick to remember the correct tone for this character.';

  @override
  String get areThereCommonHomophonesThatAreOfte =>
      'Are there common homophones that are often confused with this?';

  @override
  String get quotaExceeded => 'Quota exceeded';

  @override
  String get mustProvideEitherCardOrCards =>
      'Must provide either card or cards';

  @override
  String get deckSettings => 'Deck Settings';

  @override
  String get saveSettings => 'Save Settings';

  @override
  String get sealRed => 'Seal Red';

  @override
  String get sealScript => 'Seal Script';

  @override
  String get startYourStreak => 'START YOUR STREAK';

  @override
  String get traditionalCharacter => 'Traditional Character';

  @override
  String get inQueue => 'In Queue';

  @override
  String get tapToListenAgain => 'Tap to listen again';

  @override
  String get contextClue => 'Context Clue';

  @override
  String get microphonePermissionRequired1 => 'Microphone permission required.';

  @override
  String get recordingFailedNoFile => 'Recording failed (no file).';

  @override
  String get holdToSpeakOptional => 'Hold to speak (Optional)';

  @override
  String get microphonePermissionDeniedEnableItI =>
      'Microphone permission denied. Enable it in Settings to use Shadowing Studio.';

  @override
  String get sessionSummary => 'Session Summary';

  @override
  String get hereAreTheCharactersYouStruggledWit =>
      'Here are the characters you struggled with:';

  @override
  String get applySessionGradesToSpacedRepetitio =>
      'Apply session grades to Spaced Repetition (Speaking Mode)';

  @override
  String get masterYourMandarinPronunciationnbyM =>
      'Master your Mandarin pronunciation\\nby mimicking native speech.';

  @override
  String get aiIsGradingYourPronunciation =>
      'AI is grading your pronunciation...';

  @override
  String get holdMicToRecordReleaseToGrade =>
      'Hold mic to record. Release to grade.';

  @override
  String get tapAnySyllableToAuditionAll4Tones =>
      'Tap any syllable to audition all 4 tones:';

  @override
  String get freeFlowConversationalPractice =>
      'Free flow conversational practice.';

  @override
  String get failedToGeneratePhrasePleaseTryAgai =>
      'Failed to generate phrase. Please try again.';

  @override
  String get recordingTooShortHoldTheMicButtonLo =>
      'Recording too short. Hold the mic button longer.';

  @override
  String get recordingErrorPleaseTryAgain =>
      'Recording error. Please try again.';

  @override
  String get noRecordingCapturedPleaseTryAgain =>
      'No recording captured. Please try again.';

  @override
  String get recordedAudioIsEmptyPleaseTryAgainA =>
      'Recorded audio is empty. Please try again and speak clearly.';

  @override
  String get azureSpeechApiKeysAreMissing1 =>
      'Azure Speech API keys are missing';

  @override
  String get azureError401 => 'Azure Error 401';

  @override
  String get azureAuthenticationFailedCheckYourS =>
      'Azure authentication failed. Check your Speech API key and region in .env';

  @override
  String get azureError429 => 'Azure Error 429';

  @override
  String get azureQuotaExceededTryAgainLater =>
      'Azure quota exceeded. Try again later.';

  @override
  String get azureGradingTimedOutCheckYourIntern =>
      'Azure grading timed out. Check your internet connection.';

  @override
  String get recognitionFailedNull => 'Recognition failed: null';

  @override
  String get couldNotHearYouClearlyPleaseTryAgai =>
      'Could not hear you clearly. Please try again.';

  @override
  String get singlePhrasePractice => 'Single Phrase Practice';

  @override
  String get failedToGeneratePhrase => 'Failed to generate phrase';

  @override
  String get omitted => 'Omitted';

  @override
  String get partial => 'Partial';

  @override
  String get mispronounced => 'Mispronounced';

  @override
  String get startSession1 => 'Start Session';

  @override
  String get chinese => 'Chinese';

  @override
  String get paused => 'Paused';

  @override
  String get translationFailed => 'Translation failed';

  @override
  String get engagingMacroeconomicAndBusinessBre =>
      'Engaging macroeconomic and business breakdowns explained through lively storytelling.';

  @override
  String get exploresWorldEconomiesBankingHistor =>
      'Explores world economies, banking histories, and global industry dynamics.';

  @override
  String get clearArticulateMandarinPerfectForIn =>
      'Clear, articulate Mandarin perfect for intermediate and advanced learners.';

  @override
  String get chefWang => 'Chef Wang';

  @override
  String get masterSichuanCulinaryTechniquesTaug =>
      'Master Sichuan culinary techniques taught directly by a professional head chef.';

  @override
  String get stepbystepAuthenticChineseRecipesWi =>
      'Step-by-step authentic Chinese recipes with wok control and knife work.';

  @override
  String get conciseCulinaryVocabularyAndClearIn =>
      'Concise culinary vocabulary and clear instruction in natural Mandarin.';

  @override
  String get cinematographyCuttingedgeCameraTech =>
      'Cinematography, cutting-edge camera tech, and deep digital media evaluations.';

  @override
  String get highproductionDocumentaryStyleExplo =>
      'High-production documentary style exploring video creation and AI innovations.';

  @override
  String get richTechnicalMandarinWithCrystalcle =>
      'Rich technical Mandarin with crystal-clear pronunciation and visual captions.';

  @override
  String get indepthInvestigativeJournalismAndCu =>
      'In-depth investigative journalism and current affairs commentary.';

  @override
  String get criticalPerspectivesOnSocialPhenome =>
      'Critical perspectives on social phenomena, world news, and history.';

  @override
  String get formalInvestigativeDiscourseIdealFo =>
      'Formal investigative discourse ideal for advanced listening comprehension.';

  @override
  String get bitesizedAnimatedScienceDocumentari =>
      'Bite-sized animated science documentaries answering everyday questions.';

  @override
  String get exploresPhysicsBiologyAndEverydayCu =>
      'Explores physics, biology, and everyday curiosities with fun infographics.';

  @override
  String get standardBeijingMandarinWithWellpace =>
      'Standard Beijing Mandarin with well-paced narration and clear subtitles.';

  @override
  String get heartwarmingStreetFoodAdventuresAnd =>
      'Heartwarming street food adventures and genuine conversations across China.';

  @override
  String get exploresRegionalHumanStoriesFamilyT =>
      'Explores regional human stories, family traditions, and local delicacies.';

  @override
  String get naturalConversationalMandarinWithDa =>
      'Natural conversational Mandarin with daily slang and emotional warmth.';

  @override
  String get humorousAndHonestConsumerElectronic =>
      'Humorous and honest consumer electronics reviews from real-life experience.';

  @override
  String get testingSmartphonesSmartHomeGadgetsA =>
      'Testing smartphones, smart home gadgets, and tech lifestyle gear.';

  @override
  String get relaxedHumorousConversationalDialog =>
      'Relaxed, humorous conversational dialogue with modern colloquialisms.';

  @override
  String get seanKitchen => 'Sean Kitchen';

  @override
  String get deliciousHomecookedChineseDishesAnd =>
      'Delicious home-cooked Chinese dishes and street snack recreation.';

  @override
  String get easytofollowKitchenTipsForCookingAu =>
      'Easy-to-follow kitchen tips for cooking authentic Asian comfort food.';

  @override
  String get warmInvitingCommentaryWithPractical =>
      'Warm, inviting commentary with practical kitchen vocabulary.';

  @override
  String get chineseChannel => 'Chinese Channel';

  @override
  String get structuredChineseLanguageLessonsAnd =>
      'Structured Chinese language lessons and cultural discovery tutorials.';

  @override
  String get grammarPointsHskVocabularyBuildingA =>
      'Grammar points, HSK vocabulary building, and conversational patterns.';

  @override
  String get clearEducationalPacingTailoredSpeci =>
      'Clear educational pacing tailored specifically for Chinese learners.';

  @override
  String get oneInABillion => 'One in a Billion';

  @override
  String get intimatePortraitsAndStoriesOfUnique =>
      'Intimate portraits and stories of unique individuals in contemporary China.';

  @override
  String get exploresDiverseLifeChoicesYouthCult =>
      'Explores diverse life choices, youth culture, and modern social shifts.';

  @override
  String get deepNarrativeStorytellingWithRichVo =>
      'Deep narrative storytelling with rich vocabulary and authentic voices.';

  @override
  String get vickySoup => 'Vicky Soup';

  @override
  String get aestheticLifestyleVlogsFashionStyli =>
      'Aesthetic lifestyle vlogs, fashion styling, and daily routines.';

  @override
  String get travelDiariesAndCozyLifeMomentsDocu =>
      'Travel diaries and cozy life moments documented with cinematic warmth.';

  @override
  String get naturalCasualMandarinSpokenAtAComfo =>
      'Natural casual Mandarin spoken at a comfortable, expressive pace.';

  @override
  String get tededMandarin => 'TED-Ed Mandarin';

  @override
  String get highqualityAnimatedEducationalLesso =>
      'High-quality animated educational lessons on science, philosophy, and history.';

  @override
  String get thoughtprovokingRiddlesClassicLiter =>
      'Thought-provoking riddles, classic literature, and psychology mysteries.';

  @override
  String get impeccableVoiceoverMandarinWithSync =>
      'Impeccable voice-over Mandarin with synchronized bilingual subtitles.';

  @override
  String get channel => 'Channel';

  @override
  String get curatedCulturalDocumentariesAndChin =>
      'Curated cultural documentaries and Chinese lifestyle highlights.';

  @override
  String get exploringTraditionalArtsHeritageCra =>
      'Exploring traditional arts, heritage craftsmanship, and modern trends.';

  @override
  String get highQualityAudioWithSynchronizedChi =>
      'High quality audio with synchronized Chinese closed captions.';

  @override
  String get interestingStoriesAndCreativeVideoP =>
      'Interesting stories and creative video projects across the Chinese web.';

  @override
  String get engagingInterviewsStorytellingAndVi =>
      'Engaging interviews, storytelling, and visual explorations.';

  @override
  String get greatListeningMaterialWithStandardP =>
      'Great listening material with standard pronunciation.';

  @override
  String get xVsY => 'X vs Y';

  @override
  String get untitled => 'Untitled';

  @override
  String get contemporaryStories => 'Contemporary Stories';

  @override
  String get history => 'History';

  @override
  String get advancedReading => 'Advanced Reading';

  @override
  String get intermediateReading => 'Intermediate Reading';

  @override
  String get beginnerReading => 'Beginner Reading';

  @override
  String get mandarinBean => 'Mandarin Bean';

  @override
  String get unknown => 'Unknown';

  @override
  String get localDb => 'Local DB';

  @override
  String get emperorTaizong => 'Emperor Taizong';

  @override
  String get emperorXuanzong => 'Emperor Xuanzong';

  @override
  String get liBai => 'Li Bai';

  @override
  String get gradedReader => 'Graded Reader';

  @override
  String get ucj10r97lkwgdtqbt6xzv8gLearnMandari =>
      'UCJ10R97LkwGdTqBT6xz-v8g\': \'Learn Mandarin with TaiwanPlus';

  @override
  String get ucsxriuqkzzmaqklq0n9xfvwEverydayChi =>
      'UCSXriUqkzZmAQklQ0N9XFVw\': \'Everyday Chinese';

  @override
  String get graceMandarinChinese => 'Grace Mandarin Chinese';

  @override
  String get ucolbhvvl5dcjlmzeqbuu1vwTingdailyLi =>
      'UCOLBhVvL5dcJLMZeQBUu1Vw\': \'Ting-Daily life in China';

  @override
  String get xinxin => 'Xinxin';

  @override
  String get sweetFamilyDailyLife => 'Sweet Family Daily Life';

  @override
  String get chinsunDailyLife => 'Chin-Sun Daily Life';

  @override
  String get tasteChina => 'Taste China';

  @override
  String get dawenFoodQuest => 'DaWen Food Quest';

  @override
  String get chinaTravelWithCangbao => 'China Travel with Cangbao';

  @override
  String get alinFoodWalk => 'Alin Food Walk';

  @override
  String get videoOfTheDay => 'VIDEO OF THE DAY';

  @override
  String get noValidVideoFound => 'No valid video found.';

  @override
  String get listeningPractice => 'LISTENING PRACTICE';

  @override
  String get socialSkills => 'SOCIAL SKILLS';

  @override
  String get culturalContext => 'CULTURAL CONTEXT';

  @override
  String get realLife => 'REAL LIFE';

  @override
  String get realWorld => 'REAL WORLD';

  @override
  String get articleOfTheDay => 'ARTICLE OF THE DAY';

  @override
  String get failedToLoadOrParseRssFeed => 'Failed to load or parse RSS feed.';

  @override
  String get drama => 'Drama';

  @override
  String get youkugetAppNow => 'YOUKU-Get APP now';

  @override
  String get romanceTrailer => 'Romance\', \'Trailer';

  @override
  String get romance => 'Romance';

  @override
  String get action => 'Action';

  @override
  String get mystery => 'Mystery';

  @override
  String get historical => 'Historical';

  @override
  String get historicalAction => 'Historical\', \'Action';

  @override
  String get historicalRomance => 'Historical\', \'Romance';

  @override
  String get anYouth => 'An Youth';

  @override
  String get historicalSliceOfLife => 'Historical\', \'Slice of Life';

  @override
  String get historicalHighlight => 'Historical\', \'Highlight';

  @override
  String get youkuEnglishgetAppNow => 'YOUKU English-Get APP now';

  @override
  String get theDouble => 'The Double';

  @override
  String get updatesByOshin => 'Updates By Oshin';

  @override
  String get backFromTheBrink => 'Back from the Brink';

  @override
  String get fallingIntoYourSmile => 'Falling Into Your Smile';

  @override
  String get everyoneLovesMe => 'Everyone Loves Me';

  @override
  String get tillTheEndOfTheMoon => 'Till The End of The Moon';

  @override
  String get theBestDayOfMyLife => 'The Best Day of My Life';

  @override
  String get gikkiChineseDrama => 'GIKKI Chinese Drama';

  @override
  String get dashingYouth => 'Dashing Youth';

  @override
  String get rebornChineseDramaEngSub => 'Reborn Chinese drama ENG SUB';

  @override
  String get ijenwaBenita => 'Ijenwa Benita';

  @override
  String get whenIFlyTowardsYou => 'When I Fly Towards You';

  @override
  String get mztvExclusiveChineseDrama => 'MZTV Exclusive Chinese Drama';

  @override
  String get theStarryLove => 'The Starry Love';

  @override
  String get comedy => 'Comedy';

  @override
  String get backFromTheBrink1 => 'Back from the Brink\':';

  @override
  String get dashingYouth1 => 'Dashing Youth\':';

  @override
  String get beReborn => 'Be Reborn';

  @override
  String get beautyStrategy => 'Beauty Strategy';

  @override
  String get myDivineEmissary => 'My Divine Emissary';

  @override
  String get theHope => 'The Hope';

  @override
  String get ep16In => 'EP16\': \'In';

  @override
  String get everyoneLovesMe1 => 'Everyone Loves Me\': \'';

  @override
  String get fallingIntoYourSmile1 => 'Falling Into Your Smile\':';

  @override
  String get hiddenLove => 'Hidden Love\':';

  @override
  String get loveBetweenFairyAndDevil => 'Love Between Fairy and Devil\':';

  @override
  String get loveLikeTheGalaxy => 'Love Like The Galaxy\':';

  @override
  String get membersPremiere => 'Members Premiere';

  @override
  String get moonlight => 'Moonlight';

  @override
  String get myJourneyToYou => 'My Journey to You\':';

  @override
  String get mysteriousLotusCasebook => 'Mysterious Lotus Casebook\':';

  @override
  String get rebornChineseDramaEngSub1 => 'Reborn Chinese drama ENG SUB\': \'';

  @override
  String get reborn => 'Reborn';

  @override
  String get theBestDayOfMyLife1 => 'The Best Day of My Life\': \'';

  @override
  String get theDouble1 => 'The Double\':';

  @override
  String get theLongBallad => 'The Long Ballad\':';

  @override
  String get theStarryLove1 => 'The Starry Love\':';

  @override
  String get theUntamed => 'The Untamed\':';

  @override
  String get tillTheEndOfTheMoon1 => 'Till The End of The Moon\':';

  @override
  String get whenIFlyTowardsYou1 => 'When I Fly Towards You\':';

  @override
  String get wordOfHonor => 'Word of Honor\':';

  @override
  String get blossom => 'Blossom';

  @override
  String get gemini => 'Gemini';

  @override
  String get generationToGeneration => 'Generation to Generation';

  @override
  String get brocadeOdyssey => 'Brocade Odyssey';

  @override
  String get circleOfLove => 'Circle of Love';

  @override
  String get dawnIsBreaking => 'Dawn is Breaking';

  @override
  String get firstRomance => 'First Romance';

  @override
  String get loveInTheClouds => 'Love in The Clouds';

  @override
  String get secondChanceRomance => 'Second Chance Romance';

  @override
  String get mrBad => 'Mr. BAD';

  @override
  String get pursuitOfJade => 'Pursuit of Jade';

  @override
  String get fatedHearts => 'Fated Hearts';

  @override
  String get roadHome => 'Road Home';

  @override
  String get myDearGuardian => 'My Dear Guardian';

  @override
  String get brightEyesInTheDark => 'Bright Eyes in the Dark';

  @override
  String get theIngeniousOne => 'The Ingenious One';

  @override
  String get herPhoenixMajesty => 'Her Phoenix Majesty';

  @override
  String get dreamsNeverEnd => 'Dreams Never End';

  @override
  String get theUltimateVowUnknownToYou => 'The Ultimate Vow, Unknown to You';

  @override
  String get the300LoyalGhosts => 'The 300 Loyal Ghosts';

  @override
  String get homelandGuardian => 'Homeland Guardian';

  @override
  String get loveIsAlwaysOnline => 'Love is Always Online';

  @override
  String get thePrincessDecree => 'The Princess Decree';

  @override
  String get aVowInTheDark => 'A Vow in the Dark';

  @override
  String get aGirlLikeMe => 'A Girl Like Me';

  @override
  String get iAmNobody => 'I Am Nobody';

  @override
  String get myMamaGo => 'My Mama Go!';

  @override
  String get myWesternRegionPrincess => 'My Western Region Princess';

  @override
  String get aFlowerOnTheContinent => 'A Flower On The Continent';

  @override
  String get thePrincess => 'The Princess';

  @override
  String get sweetLoveVersion => 'Sweet Love Version';

  @override
  String get hilariousFamily2 => 'Hilarious Family 2';

  @override
  String get guYuanMountainHasASchool => 'Gu Yuan Mountain Has a School';

  @override
  String get foreverYoung => 'Forever Young';

  @override
  String get theHiddenHeirYeChen => 'The Hidden Heir Ye Chen';

  @override
  String get extraordinary => 'Extraordinary';

  @override
  String get sideStoryOfFoxVolant => 'Side Story of Fox Volant';

  @override
  String get loveOfTheDivineTree => 'Love of the Divine Tree';

  @override
  String get rebirth => 'Rebirth';

  @override
  String get moonlitReunion => 'Moonlit Reunion';

  @override
  String get videoCountsCannotBeNegative => 'Video counts cannot be negative.';

  @override
  String get publicDomainClassic => 'Public Domain Classic';

  @override
  String get idioms => 'Idioms';

  @override
  String get news => 'News';

  @override
  String get fairyTales => 'Fairy Tales';

  @override
  String get hereIsAFascinatingCulturalExplanati =>
      'Here is a fascinating cultural explanation';

  @override
  String get videoFetchTimedOut => 'Video fetch timed out';

  @override
  String get aboutChannel => 'ABOUT CHANNEL';

  @override
  String get noVideosFound => 'No videos found';

  @override
  String get failedToLoadVideos => 'Failed to load videos';

  @override
  String get highqualityCuratedMandarinContentWi =>
      'High-quality curated Mandarin content with natural vocabulary.';

  @override
  String get authenticSpokenChineseAcrossRealwor =>
      'Authentic spoken Chinese across real-world themes and topics.';

  @override
  String get engagingVideoMaterialWithInteractiv =>
      'Engaging video material with interactive synchronized subtitles.';

  @override
  String get watchVideo => 'Watch Video';

  @override
  String get culturalInsight => 'Cultural Insight';

  @override
  String get aiIsAnalyzingCulturalContext =>
      'AI is analyzing cultural context...';

  @override
  String get diveIntoFullContent => 'Dive into Full Content';

  @override
  String get savedArticles => 'Saved Articles';

  @override
  String get liveOverlay => 'LIVE OVERLAY';

  @override
  String get webExplorer => 'WEB EXPLORER';

  @override
  String get browseAnyChineseWebsiteWithRealtime =>
      'Browse any Chinese website with real-time tap dictionary, pinyin annotations & instant translations.';

  @override
  String get startExploring => 'START EXPLORING';

  @override
  String get chineseTvSeriesWithInteractiveSubti =>
      'Chinese TV series with interactive subtitles';

  @override
  String get failedToLoadContent => 'Failed to load content';

  @override
  String get searchingYoutube => 'Searching YouTube...';

  @override
  String get noVideosFoundTryADifferentSearchTer =>
      'No videos found. Try a different search term.';

  @override
  String get searching => 'Searching';

  @override
  String get noShowsFound => 'No shows found';

  @override
  String get bookmarked => 'Bookmarked';

  @override
  String get trailer1 => 'Trailer';

  @override
  String get highlight1 => 'Highlight';

  @override
  String get noCaptionsAvailable => 'No Captions Available';

  @override
  String get fetchingSubtitles => 'Fetching subtitles...';

  @override
  String get generatingAiBriefing => 'Generating AI briefing...';

  @override
  String get noClosedCaptionsCcFoundForThisVideo =>
      'No Closed Captions (CC) found for this video.';

  @override
  String get videosWithHardcodedOrBurnedinSubtit =>
      'Videos with hardcoded or burned-in subtitles do not have digital text tracks available on YouTube.';

  @override
  String get translatingSubtitles => 'Translating subtitles...';

  @override
  String get processingYourPronunciation => 'Processing your pronunciation...';

  @override
  String get couldntIdentifyLine => 'Couldn\'t identify line.';

  @override
  String get listeningSpeakNow => 'Listening... speak now.';

  @override
  String get thisVideoDoesNotHaveADigitalClosedC =>
      'This video does not have a digital Closed Captions (CC) track on YouTube.';

  @override
  String get perfect1 => 'Perfect';

  @override
  String get thisVideoHasBeenRemovedOrIsNoLonger =>
      'This video has been removed or is no longer available.';

  @override
  String get thisVideoCannotBePlayedInTheAppYouC =>
      'This video cannot be played in the app. You can still watch it on YouTube.';

  @override
  String get yourDeviceCannotPlayThisVideoPlease =>
      'Your device cannot play this video. Please try a different one.';

  @override
  String get invalidVideoReferencePleaseTryAgain =>
      'Invalid video reference. Please try again.';

  @override
  String get unableToLoadThisVideoPleaseTryAnoth =>
      'Unable to load this video. Please try another one.';

  @override
  String get startReading => 'Start Reading';

  @override
  String get analyzingCulturalContext => 'Analyzing cultural context...';

  @override
  String get failedToLoadCulturalInsight => 'Failed to load cultural insight.';

  @override
  String get historicalContext => 'Historical Context';

  @override
  String get culturalSignificance => 'Cultural Significance';

  @override
  String get authorBackground => 'Author Background';

  @override
  String get k80CompleteClassicNovelsWorldEpics =>
      '80+ Complete classic novels & world epics';

  @override
  String get storyOfTheDay => 'STORY OF THE DAY';

  @override
  String get tangDynasty => 'Tang Dynasty';

  @override
  String get poetryClassicalVerse => 'Poetry\', \'Classical\', \'Verse';

  @override
  String get allHsk => 'All HSK';

  @override
  String get allStories => 'All Stories\' :';

  @override
  String get keyWords => 'Key Words';

  @override
  String get openOriginalWebsite => 'Open Original Website';

  @override
  String get aiReadingTools => 'AI Reading Tools';

  @override
  String get enhanceYourReadingWithAipoweredTool =>
      'Enhance your reading with AI-powered tools';

  @override
  String get chooseTheTargetDifficultyForSimplif =>
      'Choose the target difficulty for simplification';

  @override
  String get chooseDifficultyForSimplification =>
      'Choose difficulty for simplification';

  @override
  String get extractAllUnknownWordsToANewFlashca =>
      'Extract all unknown words to a new flashcard deck';

  @override
  String get length => 'Length';

  @override
  String get m1554846a550010707 => 'M15.54 8.46a5 5 0 0 1 0 7.07';

  @override
  String get m1907493a101000101414 => 'M19.07 4.93a10 10 0 0 1 0 14.14';

  @override
  String get webExtraction => 'Web Extraction';

  @override
  String get aiTools => 'AI Tools';

  @override
  String get stop => 'Stop';

  @override
  String get keepPracticing1 => 'Keep practicing';

  @override
  String get aiPrepRoom => 'AI Prep Room';

  @override
  String get lessonSummary => 'LESSON SUMMARY';

  @override
  String get unlockSinosparkPremium => 'Unlock SinoSpark Premium';

  @override
  String get monthYear => 'Month\' : \'Year';

  @override
  String get enableNotifications => 'Enable Notifications';

  @override
  String get notificationsConfigured => 'Notifications Configured';

  @override
  String get neverMissAStroke2 => 'Never Miss a Stroke';

  @override
  String get yourDailyDropAndStreakAlertsArePrim =>
      'Your daily drop and streak alerts are primed.';

  @override
  String get stayConsistentWithDailyRitualDropsA =>
      'Stay consistent with daily ritual drops and timely trial reminders.';

  @override
  String get aNewWordAndStoryWaitingForYourDaily =>
      'A new Word and Story waiting for your daily ritual.';

  @override
  String get gentlePromptsBeforeCharactersFadeFr =>
      'Gentle prompts before characters fade from your memory.';

  @override
  String get receiveAReminder2DaysBeforeYourFree =>
      'Receive a reminder 2 days before your free trial ends.';

  @override
  String get yourPathTonchineseFluency => 'Your Path to\\nChinese Fluency';

  @override
  String get answer3QuickQuestionsSoOurAiCanCraf =>
      'Answer 3 quick questions so our AI can craft\\na curriculum that fits your life.';

  @override
  String get whatIsYourLevelnwithChinese =>
      'What is your level\\nwith Chinese?';

  @override
  String get chooseThePathThatFitsYourDepth =>
      'Choose the path that fits your depth.';

  @override
  String get whatDrivesYourStudy => 'What drives your study?';

  @override
  String get purposeFuelsTheBrush => 'Purpose fuels the brush';

  @override
  String get setYourDailyRitual => 'Set your daily ritual.';

  @override
  String get youCanAdjustYourRitualAnyTime =>
      'You can adjust your ritual any time.';

  @override
  String get letsBegin => 'Let\'s Begin';

  @override
  String get brandNew => 'Brand New';

  @override
  String get iveNeverStudiedChineseBefore =>
      'I\'ve never studied Chinese before.';

  @override
  String get iKnowBasicCharactersAndPhrases =>
      'I know basic characters and phrases.';

  @override
  String get iCanHoldConversationsAndRead =>
      'I can hold conversations and read.';

  @override
  String get iWantToRefineAndPerfectMySkills =>
      'I want to refine and perfect my skills.';

  @override
  String get confirmSelection => 'Confirm Selection';

  @override
  String get purposeFuelsTheBrushsMotion =>
      'Purpose fuels the brush\'s motion.';

  @override
  String get buildMyPath => 'Build My Path';

  @override
  String get hskCertification => 'HSK Certification';

  @override
  String get culturalAppreciation => 'Cultural Appreciation';

  @override
  String get yourPlanIsReady => 'Your Plan is Ready';

  @override
  String get craftingYourCurriculum => 'Crafting Your Curriculum';

  @override
  String get personalizedPathInitialized => 'PERSONALIZED PATH INITIALIZED';

  @override
  String get calibratingAiNeuralMasters => 'CALIBRATING AI NEURAL MASTERS...';

  @override
  String get calibrationComplete => 'Calibration Complete';

  @override
  String get synthesizingModules => 'Synthesizing Modules...';

  @override
  String get oneAndWater => 'One\' and \'Water';

  @override
  String get theHorizontalStroke => 'THE HORIZONTAL STROKE';

  @override
  String get theRadical => 'THE RADICAL';

  @override
  String get water => 'Water';

  @override
  String get river => 'River';

  @override
  String get day5Reminder => 'Day 5 Reminder';

  @override
  String get wePromisedToAlertYou2DaysBeforeYour =>
      'We promised to alert you 2 days before your trial ends so you';

  @override
  String get continueWithoutReminder => 'Continue without reminder';

  @override
  String get masterChineseWithnsinospark => 'Master Chinese with\\nSinoSpark';

  @override
  String get start7dayFreeTrial => 'Start 7-Day Free Trial';

  @override
  String get precisionStrokes => 'Precision Strokes';

  @override
  String get aiPronunciation => 'AI Pronunciation';

  @override
  String get today => 'Today';

  @override
  String get fullAccess => 'Full Access';

  @override
  String get day5 => 'Day 5';

  @override
  String get reminder => 'Reminder';

  @override
  String get day7 => 'Day 7';

  @override
  String get trialBegins => 'Trial Begins';

  @override
  String get revenuecatIsMissingACurrentOffering =>
      'RevenueCat is missing a Current Offering or Packages. Please configure your Dashboard.';

  @override
  String get cameraPermissionRequiredForLiveScan =>
      'Camera permission required for live scanning.';

  @override
  String get cameraAccessRequired => 'Camera Access Required';

  @override
  String get pleaseEnableCameraAccessInYourDevic =>
      'Please enable camera access in your device settings to use this feature.';

  @override
  String get alignChineseTextWithinFrame => 'Align Chinese text within frame';

  @override
  String get inLibrary => 'In Library';

  @override
  String get novice => 'Novice';

  @override
  String get apprentice => 'Apprentice';

  @override
  String get artisan => 'Artisan';

  @override
  String get grandmaster => 'Grandmaster';

  @override
  String get poem => 'Poem';

  @override
  String get theNarrative => 'The Narrative';

  @override
  String get classicMasterpiece => 'Classic Masterpiece';

  @override
  String get classicAuthor => 'Classic Author';

  @override
  String get classical => 'Classical';

  @override
  String get classicLiterature => 'Classic\', \'Literature';

  @override
  String inThisChapterOf(Object title) {
    return 'In this chapter of';
  }

  @override
  String get asTheNarrativeUnfoldsItIlluminatesT =>
      'As the narrative unfolds, it illuminates the fundamental wisdom of life and lasting inspiration.';

  @override
  String get general => 'General';

  @override
  String get mythology => 'Mythology';

  @override
  String get dailyLife => 'Daily Life';

  @override
  String get tangPoetry => 'Tang Poetry';

  @override
  String get classicalLiterature => 'Classical Literature';

  @override
  String get justNow => 'Just now';

  @override
  String get theTerracottaArmyOfQinShiHuang =>
      'The Terracotta Army of Qin Shi Huang';

  @override
  String get lifeInsideTheForbiddenCity => 'Life inside the Forbidden City';

  @override
  String get buyingATicketAndTakingTheHighSpeedT =>
      'Buying a ticket and taking the high speed train in China';

  @override
  String get goingToTheHospitalForAColdAndSeeing =>
      'Going to the hospital for a cold and seeing a doctor';

  @override
  String get goingToALocalRestaurantToOrderJiaoz =>
      'Going to a local restaurant to order Jiaozi (dumplings)';

  @override
  String get theTraditionalGongfuTeaCeremony =>
      'The traditional Gongfu tea ceremony';

  @override
  String get theArtOfWritingChineseCharactersWit =>
      'The art of writing Chinese characters with a brush';

  @override
  String get theLifeAndConservationOfGiantPandas =>
      'The life and conservation of Giant Pandas';

  @override
  String get storyNotFoundInDatabase => 'Story not found in database';

  @override
  String get storyTextIsEmpty => 'Story text is empty';

  @override
  String get myCustomStories => 'My Custom Stories';

  @override
  String get userProvidedText => 'User provided text';

  @override
  String get local => 'Local';

  @override
  String get voiceEngineAllowance => 'Voice Engine & Allowance';

  @override
  String get studioHdVsUnlimitedStandardVoice =>
      'Studio HD vs. Unlimited Standard Voice';

  @override
  String get standardVoiceIs100UnlimitedFree =>
      'Standard Voice is 100% Unlimited & Free';

  @override
  String get read => 'Read';

  @override
  String get koreKoreFemaleWarm => 'Kore\', \'Kore\', \'Female, warm';

  @override
  String get aoedeAoedeFemaleCheerful =>
      'Aoede\', \'Aoede\', \'Female, cheerful';

  @override
  String get fenrirFenrirMaleUpbeat => 'Fenrir\', \'Fenrir\', \'Male, upbeat';

  @override
  String get charonCharonMaleNewsstyle =>
      'Charon\', \'Charon\', \'Male, news-style';

  @override
  String get puckPuckMaleSporty => 'Puck\', \'Puck\', \'Male, sporty';

  @override
  String get localOndevice => 'Local\', \'On-device';

  @override
  String get localOndeviceTts => 'Local on-device TTS';

  @override
  String get off => 'Off';

  @override
  String get endOfCurrentChapter => 'End of Current Chapter';

  @override
  String get standardVoice => 'Standard Voice';

  @override
  String get noNovelsFoundMatchingYourFilter =>
      'No novels found matching your filter.';

  @override
  String get noMicroreadsFoundMatchingYourFilter =>
      'No micro-reads found matching your filter.';

  @override
  String get noPoemsFoundMatchingYourFilter =>
      'No poems found matching your filter.';

  @override
  String get audiobook => 'Audiobook';

  @override
  String get audio => 'Audio';

  @override
  String get continueReading => 'Continue Reading';

  @override
  String get search96FullNovelsAuthorsEpics =>
      'Search 96 full novels, authors, epics...';

  @override
  String get searchClassicalPoemsAuthorsVerses =>
      'Search classical poems, authors, verses...';

  @override
  String get allLevelsVal => 'All Levels';

  @override
  String get hsk1BeginnerVal => 'HSK 1 (Beginner)';

  @override
  String get hsk2ElementaryVal => 'HSK 2 (Elementary)';

  @override
  String get hsk3IntermediateVal => 'HSK 3 (Intermediate)';

  @override
  String get hsk4UpperIntVal => 'HSK 4 (Upper Int)';

  @override
  String get listenToAudiobook => 'Listen to Audiobook';

  @override
  String get synopsis => 'Synopsis';

  @override
  String get peoplesArtist => 'People\'s Artist\'.';

  @override
  String get kafkaesqueForBureaucraticAbsurdityA =>
      'Kafkaesque\' for bureaucratic absurdity, alienation, and existential dread.';

  @override
  String get bigBrotherAndNewspeak => 'Big Brother\', and \'Newspeak\'.';

  @override
  String get audiobookIncluded => 'Audiobook Included';

  @override
  String get readPoem => 'Read Poem';

  @override
  String get studioVoiceAllowance => 'Studio Voice Allowance';

  @override
  String get weeklyHighdefinitionAiRecitation =>
      'Weekly High-Definition AI Recitation';

  @override
  String get resetsEveryMondayAt0000 => 'Resets every Monday at 00:00';

  @override
  String get whenYourWeekly4hourStudioAllowanceI =>
      'When your weekly 4-hour Studio allowance is used, the app automatically switches to On-Device Voice for unlimited, free listening without interruption.';

  @override
  String get localDeviceVoice => 'Local device voice\' :';

  @override
  String get classicalVerse => 'Classical Verse';

  @override
  String get ondeviceVoice4hWeeklyUsed => 'On-Device Voice (4h weekly used)';

  @override
  String get generateACustomAiStoryBasedOnYourIn =>
      'Generate a custom AI story based on your interests';

  @override
  String get insteadOfAFixedHskLevelTheFlowState =>
      'Instead of a fixed HSK level, the Flow State Engine analyzes your Flashcard Library.\\n\\n';

  @override
  String get we => 'We';

  @override
  String get howCanWeHelpYou => 'How can we help you?';

  @override
  String get everythingYouNeedToKnowAboutHanziMa =>
      'Everything you need to know about Hanzi Master, its features, and your privacy.';

  @override
  String get whoAreTheVoicesSpeakingInTheApp =>
      'Who are the voices speaking in the app?';

  @override
  String get howDoesTheWebExplorerWork => 'How does the Web Explorer work?';

  @override
  String get whatIsZenMode => 'What is Zen Mode?';

  @override
  String get howDoesTheFlashcardSpacedrepetition =>
      'How does the Flashcard spaced-repetition work?';

  @override
  String get traceComplete => 'Trace Complete!';

  @override
  String get traceCharacter => 'Trace Character';

  @override
  String get analyzingWordRelationships => 'Analyzing word relationships...';

  @override
  String get identifyingUsageContexts => 'Identifying usage contexts...';

  @override
  String get comparingFormalityLevels => 'Comparing formality levels...';

  @override
  String get findingCommonCollocations => 'Finding common collocations...';

  @override
  String get generatingComparison => 'Generating comparison...';

  @override
  String get generationIsTakingLongerThanExpecte =>
      'Generation is taking longer than expected. The AI may be overloaded.';

  @override
  String get generationInterruptedShowingPartial =>
      'Generation interrupted. Showing partial result.';

  @override
  String get sorrySomethingWentWrong => 'Sorry, something went wrong.';

  @override
  String get usage => 'Usage:\', \'';

  @override
  String get alsoSeenIn => 'Also seen in';

  @override
  String get quickLook => 'Quick Look';

  @override
  String get notFound => 'Not found';

  @override
  String get errorLoadingFromAi => 'Error loading from AI.';

  @override
  String get newLabel => 'New';

  @override
  String get analyzingImage => 'Analyzing image...';

  @override
  String get extractingChineseText => 'Extracting Chinese text...';

  @override
  String get lookingUpVocabulary => 'Looking up vocabulary...';

  @override
  String get dreamOfTheRedChamber => 'Dream of the Red Chamber';

  @override
  String get journeyToTheWest => 'Journey to the West';

  @override
  String get romanceOfTheThreeKingdoms => 'Romance of the Three Kingdoms';

  @override
  String get mingDynasty => 'Ming Dynasty';

  @override
  String get wuChengEn => 'Wu Cheng\'en';

  @override
  String get hundredChapters => '100 Chapters';

  @override
  String get volume1 => 'Volume 1';

  @override
  String bookmarksCount(Object count) {
    return 'Bookmarks ($count)';
  }

  @override
  String get noBookmarksYet =>
      'No bookmarks yet. Tap the bookmark icon to save a passage.';

  @override
  String get sinosparkIsNotResponding => 'SinoSpark isn\'t responding';

  @override
  String get closeApp => 'Close app';

  @override
  String get wait => 'Wait';

  @override
  String studioHdAllowance(Object hours) {
    return 'Studio HD: ${hours}h';
  }

  @override
  String bookPercentRead(Object percent) {
    return 'Book $percent%';
  }

  @override
  String chAbbreviation(Object number) {
    return 'Ch. $number';
  }

  @override
  String booksAndAudiobooks(Object count) {
    return '$count Books & Audiobooks';
  }

  @override
  String sentenceXOfY(Object current, Object total) {
    return 'Sentence $current of $total';
  }

  @override
  String chapterXOfY(Object current, Object total) {
    return 'Chapter $current of $total';
  }

  @override
  String get allLevels => 'All Levels';

  @override
  String get searchGradedMicroStories =>
      'Search graded micro-stories & fables...';

  @override
  String gradedStoriesAndMicroReads(Object count) {
    return '$count Graded Stories & Daily Micro-Reads';
  }

  @override
  String get searchClassicalPoems =>
      'Search classical poems, authors, verses...';

  @override
  String classicalPoemsAndVerse(Object count) {
    return '$count Classical Poems & Verse';
  }

  @override
  String get browseAnyChineseWebsite =>
      'Browse any Chinese website with real-time tap dictionary, pinyin annotations & instant translations.';

  @override
  String get completed => 'COMPLETED';

  @override
  String get aiIsReading => 'AI is reading...';

  @override
  String get bbcVerify => 'BBC VERIFY';

  @override
  String get hsk5AdvancedVal => 'HSK 5 (Advanced)';

  @override
  String get hsk1Beginner => 'HSK 1 (Beginner)';

  @override
  String get hsk4UpperInt => 'HSK 4 (Upper Int)';

  @override
  String get extractAllUnknownWords =>
      'Extract all unknown words to a new flashcard deck';

  @override
  String get designCustomAiRoleplay =>
      'Design custom AI roleplay & conversation';

  @override
  String get practiceFlashcardVocabulary =>
      'Practice flashcard vocabulary in a live dialogue';

  @override
  String get surpriseMe => 'Surprise Me';

  @override
  String get rollCharacter => 'Roll Character';

  @override
  String get historicalCostume => 'Historical / Costume';

  @override
  String get modernYouth => 'Modern & Youth';

  @override
  String get fantasyMythology => 'Fantasy & Mythology';

  @override
  String get familyDrama => 'Family & Drama';

  @override
  String get fullVersion => 'Full Version';

  @override
  String episodesCount(Object count) {
    return '$count episodes';
  }

  @override
  String episodeLabel(Object number) {
    return 'EP$number';
  }

  @override
  String get translating => '[ Translating... ]';

  @override
  String get engSub => '[ENG SUB]';

  @override
  String get standardVocabulary => 'Standard Vocabulary';

  @override
  String get characters => 'characters';
}
