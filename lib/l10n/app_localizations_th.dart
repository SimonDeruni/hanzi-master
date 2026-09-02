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
  String get studySession => 'Study session';

  @override
  String get readyToStudy => 'Ready to study';

  @override
  String get studyQueuePreviewDescription =>
      'Your session is based on today\'s schedule and deck limits.';

  @override
  String get notNow => 'Not now';

  @override
  String get newLabel => 'ใหม่';

  @override
  String get studyDeckEmpty => 'This deck is empty';

  @override
  String get studyDeckEmptyDescription =>
      'Add cards before starting a study session.';

  @override
  String get studyDailyLimitReached => 'Today\'s limit is complete';

  @override
  String get studyDailyLimitReachedDescription =>
      'You\'ve used this deck\'s new-card or review allowance for today.';

  @override
  String get studyCaughtUpDescription =>
      'Nothing else is scheduled for today. Come back for the next review.';

  @override
  String get noCardsAvailable => 'No cards available';

  @override
  String get studyNoEligibleCardsDescription =>
      'No cards are eligible for this study mode right now.';

  @override
  String get studySessionLoadFailed =>
      'Unable to load this study session. Please try again.';

  @override
  String get retryLimitReached => 'This card will return in your next session.';

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
  String get aiDataPrivacyTitle => 'AI Data & Privacy';

  @override
  String get aiDataPrivacySettingsSubtitle =>
      'See what AI features send, why, and to whom';

  @override
  String get aiDataPrivacyOverviewTitle => 'When AI is used';

  @override
  String get aiDataPrivacyOverviewBody =>
      'SinoSpark uses cloud AI only when you choose a feature that needs it, such as AI chat, explanations, translation, image analysis, speech recognition, pronunciation grading, or cloud voices. AI output can be inaccurate, so review important results.';

  @override
  String get aiDataPrivacyProvidersTitle => 'AI service providers';

  @override
  String get aiDataPrivacyProvidersBody =>
      'Google Gemini processes generative text and image requests. OpenRouter routes some generative requests to Google Gemini or DeepSeek. Microsoft Azure AI Speech processes speech recognition, pronunciation assessment, and text sent for cloud voice synthesis.';

  @override
  String get aiDataPrivacySentTitle => 'Data that may be sent';

  @override
  String get aiDataPrivacySentBody =>
      'Depending on the feature, we send the text you enter or select, relevant conversation or lesson context, images you choose for AI analysis, voice recordings you submit, and technical request data such as IP address and device/network metadata. We do not intentionally include your name or email in AI prompts.';

  @override
  String get aiDataPrivacyControlsTitle => 'Your choices';

  @override
  String get aiDataPrivacyControlsBody =>
      'Do not use an AI feature if you do not want its input sent to the named provider. You can deny camera, photo, or microphone permission in device Settings. Choose the Local voice to keep text-to-speech on your device. Avoid submitting sensitive or confidential information.';

  @override
  String get aiDataPrivacyRetentionTitle => 'Storage and retention';

  @override
  String get aiDataPrivacyRetentionBody =>
      'SinoSpark does not intentionally store raw AI prompts, submitted images, or voice recordings on its own servers after processing. Generated results may be saved on your device or with your account when you choose to save them. Providers process data under their own terms and configured retention controls; see the full policy for details.';

  @override
  String get readFullPrivacyPolicy => 'Read Full Privacy Policy';

  @override
  String get linkOpenFailed => 'Could not open the link. Please try again.';

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
  String get askHowLongTheTripWillTake => 'ถามว่าการเดินทางใช้เวลานานเท่าใด';

  @override
  String get complainAboutTheTraffic => 'บ่นเรื่องการจราจรติดขัด';

  @override
  String get charon => 'Charon';

  @override
  String get thisClothingQualityIsEspeciallyGood =>
      'เสื้อผ้าชุดนี้คุณภาพดีเป็นพิเศษ ราคาเพียง 200 หยวนเท่านั้น';

  @override
  String get zhe4Jian4Yi1fuZhi4liang4Te4bie2Hao3 =>
      'Zhe4 jian4 yi1fu zhi4liang4 te4bie2 hao3, zhi3yao4 liang3 bai3 kuai4.';

  @override
  String get auntieChen => 'ป้าเฉิน (Auntie Chen)';

  @override
  String get askHowMuchTheSilkShirtCosts => 'ถามราคาเสื้อเชิ้ตผ้าไหม';

  @override
  String get sayItIsTooExpensive => 'บอกว่าราคาแพงเกินไป';

  @override
  String get bargainThePriceDownTo100Rmb => 'ต่อรองราคาลงเหลือ 100 หยวน';

  @override
  String get ni3Na3li3Bu4Shu1fuFa1shao1LeMa =>
      'Ni3 na3li3 bu4 shu1fu? Fa1shao1 le ma?';

  @override
  String get drZhang => 'หมอจาง (Dr. Zhang)';

  @override
  String get explainYouHaveHadAHeadacheForTwoDay =>
      'อธิบายว่าคุณมีอาการปวดศีรษะมาสองวันแล้ว';

  @override
  String get sayYouHaveASlightFever => 'บอกว่าคุณมีไข้ต่ำๆ';

  @override
  String get askIfYouNeedToTakeMedicine => 'ถามว่าจำเป็นต้องรับประทานยาหรือไม่';

  @override
  String get aoede => 'Aoede';

  @override
  String get heyLongTimeNoSeeHowHaveYouBeenLatel =>
      'ไง! ไม่ได้เจอกันนานเลย ช่วงนี้เป็นอย่างไรบ้าง?';

  @override
  String get ni3Hao3Hao3jiu3Bu4jian4Ni3Zui4jin4Z =>
      'Ni3 hao3! Hao3jiu3 bu4jian4, ni3 zui4jin4 zen3me yang4?';

  @override
  String get pleaseIntroduceYourselfWhyDoYouWant =>
      'กรุณาแนะนำตัวเอง เหตุใดคุณจึงอยากร่วมงานกับบริษัทของเรา?';

  @override
  String get qing3Xian1Zi4wo3Jie4shao4Yi1xia4Ni3 =>
      'Qing3 xian1 zi4wo3 jie4shao4 yi1xia4. Ni3 wei4shen2me xiang3 lai2 wo3men gong1si1 gong1zuo4?';

  @override
  String get managerLiu => 'ผู้จัดการหลิว (Manager Liu)';

  @override
  String get introduceYourProfessionalBackground =>
      'แนะนำประวัติการทำงานของคุณโดยสังเขป';

  @override
  String get explainWhyYouWantToWorkAtThisCompan =>
      'อธิบายเหตุผลที่คุณต้องการร่วมงานกับบริษัทนี้';

  @override
  String get askAPoliteQuestionAboutTheCompanyCu =>
      'ถามคำถามเกี่ยวกับวัฒนธรรมองค์กรอย่างสุภาพ';

  @override
  String get microphoneAccessIsRequiredPleaseEna =>
      'จำเป็นต้องได้รับสิทธิ์การเข้าถึงไมโครโฟน กรุณาเปิดใช้งานในการตั้งค่าอุปกรณ์ของคุณ';

  @override
  String get couldNotStartMicrophonePleaseCheckY =>
      'ไม่สามารถเปิดไมโครโฟนได้ กรุณาตรวจสอบการตั้งค่าเสียงแล้วลองใหม่อีกครั้ง';

  @override
  String get weDidntQuiteCatchThatPleaseHoldTheM =>
      'ระบบไม่ได้ยินเสียงของคุณอย่างชัดเจน กรุณากดปุ่มไมโครโฟนค้างไว้แล้วลองใหม่อีกครั้ง!';

  @override
  String get recordingWasTooShortHoldTheMicAndSp =>
      'เสียงที่บันทึกสั้นเกินไป กรุณากดปุ่มไมโครโฟนค้างไว้และพูดให้ชัดเจน';

  @override
  String get audioBufferWasEmptyPleaseCheckYourM =>
      'ไม่มีข้อมูลเสียงในบัฟเฟอร์ กรุณาตรวจสอบไมโครโฟนของคุณแล้วลองใหม่';

  @override
  String get audioFileIsSilentPleaseSpeakIntoThe =>
      'ไฟล์เสียงไม่มีเสียง กรุณาพูดใส่ไมโครโฟน';

  @override
  String get weCouldntUnderstandYourPronunciatio =>
      'ระบบไม่เข้าใจการออกเสียงของคุณ กรุณาพูดให้ชัดเจนแล้วลองอีกครั้ง';

  @override
  String get theServerIsTakingTooLongToRespondPl =>
      'เซิร์ฟเวอร์ใช้เวลาตอบสนองนานเกินไป กรุณาลองใหม่อีกครั้ง';

  @override
  String get noInternetConnectionPleaseCheckYour =>
      'ไม่มีการเชื่อมต่ออินเทอร์เน็ต กรุณาตรวจสอบเครือข่ายของคุณแล้วลองใหม่';

  @override
  String get audioProcessingFailedPleaseTryAgain =>
      'การประมวลผลเสียงล้มเหลว กรุณาลองใหม่อีกครั้ง';

  @override
  String get permission => 'สิทธิ์การเข้าถึง';

  @override
  String get couldNotProcessYourRecordingPleaseT =>
      'ไม่สามารถประมวลผลเสียงบันทึกของคุณได้ กรุณาลองใหม่อีกครั้ง';

  @override
  String get user => 'ผู้ใช้';

  @override
  String get scholar => 'บัณฑิต';

  @override
  String get ourAiTutorsAreCurrentlyOfflinePleas =>
      'ติวเตอร์ AI ออฟไลน์อยู่ในขณะนี้ กรุณาลองใหม่อีกครั้งในภายหลัง';

  @override
  String get hideTranslation => 'ซ่อนคำแปล';

  @override
  String get azureAssessment => 'การประเมินจาก Azure...';

  @override
  String get microphonePermissionRequired =>
      'จำเป็นต้องได้รับสิทธิ์การเข้าถึงไมโครโฟน';

  @override
  String get connectedSpeakNow => 'เชื่อมต่อแล้ว! พูดได้เลย';

  @override
  String get initializationErrorCheckPermissions =>
      'เกิดข้อผิดพลาดในการเริ่มต้น กรุณาตรวจสอบสิทธิ์การเข้าถึง';

  @override
  String get microphoneErrorTapToRetry =>
      'เกิดข้อผิดพลาดที่ไมโครโฟน แตะเพื่อลองใหม่';

  @override
  String get theTutorReturnedAnEmptyResponse => 'ติวเตอร์ไม่มีการตอบกลับ';

  @override
  String get connectionInterruptedPleaseSpeakAga =>
      'การเชื่อมต่อขัดข้อง กรุณาพูดใหม่อีกครั้ง';

  @override
  String get callPausedReviewingTones =>
      'พักสายชั่วคราว (กำลังตรวจสอบวรรณยุกต์)';

  @override
  String get pausedTakeABreak => 'หยุดชั่วคราว - พักสักครู่';

  @override
  String get goodStartPracticing => 'เริ่มต้นฝึกฝนได้ดี';

  @override
  String get studentCoach => 'STUDENT\' : \'COACH';

  @override
  String get keepYour1stToneHighAndSteadyOn =>
      'รักษาเสียงวรรณยุกต์ที่ 1 ให้สูงและคงที่บน';

  @override
  String get noScenariosFound => 'ไม่พบสถานการณ์';

  @override
  String get designYourOwnAiRoleplayExperience =>
      'ออกแบบประสบการณ์จำลองบทบาท AI ในแบบของคุณ';

  @override
  String get generateFromDeck => 'สร้างจากสำรับคำศัพท์';

  @override
  String get practiceFlashcardVocabularyInALiveD =>
      'ฝึกฝนคำศัพท์จากแฟลชการ์ดในบทสนทนาจริง';

  @override
  String get tapToRoleplay => 'แตะเพื่อจำลองบทบาท';

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
  String get dinnerWithDad => 'มื้อค่ำกับคุณพ่อ';

  @override
  String get orderingAtAChengduTeahouse => 'การสั่งชาที่โรงน้ำชาในเฉิงตู';

  @override
  String get buyingTeaAtTheMarket => 'การซื้อใบชาที่ตลาด';

  @override
  String get meetingAnOldClassmate => 'พบเพื่อนร่วมชั้นเก่า';

  @override
  String get readyToPractice => 'พร้อมฝึกฝนหรือยัง?';

  @override
  String get letsPracticeChinese => 'มาฝึกภาษาจีนกันเถอะ';

  @override
  String get areYouReady => 'คุณพร้อมหรือยัง?';

  @override
  String get discussWhatToHaveForDinner =>
      'พูดคุยว่าจะรับประทานอะไรเป็นมื้อค่ำ';

  @override
  String get suggestWatchingAMovieAfterwards =>
      'เสนอให้ไปดูภาพยนตร์ต่อหลังจากนั้น';

  @override
  String get askIfTheyWouldLikeTea => 'ถามว่าพวกเขาต้องการดื่มชาหรือไม่';

  @override
  String get helloVeryNiceToMeetYou => 'สวัสดี! ยินดีที่ได้รู้จักเป็นอย่างยิ่ง';

  @override
  String get deckPractice => 'ฝึกฝนจากสำรับ';

  @override
  String get practiceVocabularyWithAnAiPartner => 'ฝึกฝนคำศัพท์กับคู่สนทนา AI';

  @override
  String get designCustomAiRoleplayConversation =>
      'ออกแบบบทสนทนาและการจำลองบทบาท AI กำหนดเอง';

  @override
  String get random => 'สุ่ม';

  @override
  String get scenarioTopic => 'หัวข้อสถานการณ์';

  @override
  String get contextSettingOptional => 'บริบทและสถานที่ (ไม่บังคับ)';

  @override
  String get aiCharacterPersonaOptional => 'ตัวละคร / บุคลิก AI (ไม่บังคับ)';

  @override
  String get aQuietBambooCourtyardTeahouseInChen =>
      'โรงน้ำชาในสวนไผ่อันเงียบสงบที่เฉิงตู พร้อมเสียงดนตรีกู่เจิงอันไพเราะ';

  @override
  String get aBustlingSmokyNightMarketFilledWith =>
      'ตลาดกลางคืนที่คึกคักและอบอวลด้วยควัน หนาแน่นไปด้วยแผงขายของเสียบไม้ ซาลาเปานึ่ง และสตรีทฟู้ด';

  @override
  String get aLivelyHotpotRestaurantInChongqingW =>
      'ร้านหม้อไฟอันมีชีวิตชีวาในฉงชิ่ง พร้อมน้ำซุปสีแดงเดือดพล่านและกลิ่นพริกหอมกรุ่น';

  @override
  String get aBustlingTraditionalCantoneseTeahou =>
      'โรงน้ำชากวางตุ้งดั้งเดิมอันจอแจในกว่างโจว เต็มไปด้วยเข่งติ่มซำไม้ไผ่ควันกรุ่น';

  @override
  String get aChicMinimalistCafeInTheFrenchConce =>
      'คาเฟ่มินิมอลสุดเก๋ในเขตเฟรนช์คอนเซสชันในบ่ายวันอาทิตย์ที่ฝนพรำ';

  @override
  String get aWarmNorthernHomeKitchenDuringWinte =>
      'ครัวในบ้านแถบภาคเหนืออันอบอุ่นในฤดูหนาว มีแป้งบนโต๊ะและหม้อต้มเกี๊ยวควันฉุย';

  @override
  String get anOpenairNightStreetFoodAlleyWithSi =>
      'ตรอกสตรีทฟู้ดกลางแจ้งยามค่ำคืน มีเนื้อแกะเสียบไม้ย่างร้อนๆ มะเขือยาวเผา และเบียร์เย็นฉ่ำ';

  @override
  String get aSnowyStreetCornerOutsideTheLamaTem =>
      'หัวมุมถนนที่มีหิมะโปรยปรายนอกวัดลามะ พร้อมไม้เสียบถังหูลู่สีแดงสดแช่เย็น';

  @override
  String get craftBeerBreweryInQingdao => 'โรงเบียร์คราฟต์ในชิงเต่า';

  @override
  String get aLivelyCoastalTaproomWithWoodenBarr =>
      'แท็ปรูมริมชายฝั่งทะเลอันมีชีวิตชีวา ประดับด้วยถังไม้ ลมทะเลพัดผ่าน และเบียร์สดข้าวสาลี';

  @override
  String get sichuanCookingMasterclass => 'คลาสเรียนทำอาหารเสฉวนขั้นปรมาจารย์';

  @override
  String get aVibrantOpenKitchenWithWoksBlazingC =>
      'ครัวเปิดที่มีชีวิตชีวา กระทะลุกเป็นไฟ น้ำมันพริกเดือด และพริกไทยเสฉวนสดใหม่';

  @override
  String get highspeedRailSeatMixup => 'การสลับที่นั่งบนรถไฟความเร็วสูง';

  @override
  String get greatWallSunriseTrekInMutianyu =>
      'เดินชมพระอาทิตย์ขึ้นที่กำแพงเมืองจีนด่านมู่เถียนยวี่';

  @override
  String get theAncientStoneRampartsOfTheGreatWa =>
      'เชิงเทินหินโบราณของกำแพงเมืองจีนยามรุ่งอรุณ ล้อมรอบด้วยภูเขาสีเขียวเคล้าสายหมอก';

  @override
  String get bambooRaftDriftOnGuilinLiRiver =>
      'ล่องแพไม้ไผ่บนแม่น้ำหลี่ในกุ้ยหลิน';

  @override
  String get glidingAlongEmeraldKarstWatersBetwe =>
      'ล่องไปตามสายน้ำสีมรกตท่ามกลางยอดเขาหินปูนอันงดงามใกล้หยางซั่ว';

  @override
  String get silkRoadCamelTrekInDunhuang => 'ขี่อูฐบนเส้นทางสายไหมที่ตุนหวง';

  @override
  String get theRollingGoldenSandDunesOfMingshaM =>
      'เนินทรายสีทองอร่ามของภูเขาหมิงซาซาน ติดกับโอเอซิสสระน้ำจันทร์เสี้ยว';

  @override
  String get bookingACourtyardHomestayInDali =>
      'จองโฮมสเตย์เรือนโบราณในต้าหลี่';

  @override
  String get aSereneBaistyleBoutiqueCourtyardHot =>
      'โรงแรมบูทีคเรือนโบราณสไตล์ชนเผ่าไป๋อันเงียบสงบ มองเห็นทะเลสาบเอ๋อร์ไห่ในยูนนาน';

  @override
  String get potalaPalacePilgrimageInLhasa =>
      'การเดินทางแสวงบุญที่พระราชวังโปตาลาในลาซา';

  @override
  String get theMajesticSundrenchedStoneStepsOut =>
      'บันไดหินตระการตากลางแสงแดดนอกพระราชวังโปตาลา พร้อมวงล้ออธิษฐานที่หมุนวน';

  @override
  String get aSubzeroWonderlandOfIlluminatedCrys =>
      'แดนมหัศจรรย์ติดลบที่เต็มไปด้วยปราสาทน้ำแข็งคริสตัลประดับไฟและประติมากรรมหิมะสูงตระหง่าน';

  @override
  String get zhangjiajieAvatarMountainCableCar =>
      'กระเช้าลอยฟ้าเขาอวตารจางเจียเจี้ย';

  @override
  String get suspendedHighInAGlassCableCarSoarin =>
      'ลอยอยู่บนกระเช้าพื้นกระจกสูงเสียดฟ้า ทะยานผ่านยอดเสาหินทรายนับพันต้น';

  @override
  String get gobiDesertStargazingCampInGansu =>
      'แคมป์ดูดาวกลางทะเลทรายโกบีในกานซู่';

  @override
  String get aLuxuryYurtCampUnderACrystalclearMi =>
      'แคมป์กระโจมหรูหราใต้ท้องฟ้าทางช้างเผือกอันแจ่มชัดกลางทะเลทรายนอกเมืองเจียยวี่กวน';

  @override
  String get yangtzeRiverThreeGorgesCruise => 'ล่องเรือสำราญชมสามผาแม่น้ำแยงซี';

  @override
  String get onTheSunDeckOfARiverCruiseShipPassi =>
      'บนดาดฟ้าเรือสำราญ ล่องผ่านโตรกผาฉวีถังอันสูงชันและตระการตา';

  @override
  String get buyingAntiquesInBeijingPanjiayuan =>
      'เลือกซื้อของโบราณที่ตลาดพานเจียหยวนในปักกิ่ง';

  @override
  String get aHistoricPotteryKilnFilledWithDelic =>
      'เตาเผาเครื่องปั้นดินเผาโบราณ เต็มไปด้วยแจกันกระเบื้องเคลือบดิบอันประณีตและเคลือบสีน้ำเงินโคบอลต์';

  @override
  String get suzhouSilkEmbroideryStudio => 'สตูดิโองานปักผ้าไหมซูโจว';

  @override
  String get aPeacefulCanalsideGardenStudioInSuz =>
      'สตูดิโอในสวนริมคลองอันเงียบสงบในซูโจว มีเส้นไหมชั้นดีและสะดึงปักผ้าไม้';

  @override
  String get backstageAtATraditionalBeijingOpera =>
      'หลังเวทีโรงงิ้วปักกิ่งดั้งเดิม เต็มไปด้วยชุดแสดงสีสันสดใส กระจก และเครื่องประดับศีรษะ';

  @override
  String get traditionalChineseMedicineConsultat =>
      'การตรวจรักษากับแพทย์แผนจีนโบราณ';

  @override
  String get morningTaiChiInTempleOfHeavenPark =>
      'รำไทเก๊กยามเช้าที่สวนหอสวดมนต์เพื่อความอุดมสมบูรณ์ (เทียนถาน)';

  @override
  String get beneathAncientCypressTreesAtDawnWit =>
      'ใต้ต้นสนไซเปรสโบราณยามรุ่งอรุณ พร้อมเสียงนกในสวนและผู้สูงอายุที่ฝึกฝนท่วงท่าอย่างพร้อมเพรียง';

  @override
  String get rentingAHanfuForAPhotoShoot => 'เช่าชุดฮั่นฝูเพื่อถ่ายภาพ';

  @override
  String get aTraditionalCostumeBoutiqueNearTheW =>
      'ร้านชุดโบราณดั้งเดิมริมทะเลสาบซีหู เรียงรายไปด้วยชุดคลุมสมัยราชวงศ์ถังและซ่ง';

  @override
  String get guqinAncientZitherInstrumentWorksho =>
      'เวิร์กช็อปเครื่องดนตรีกู่ฉินโบราณ';

  @override
  String get aQuietPinewoodStudioInHangzhouFille =>
      'สตูดิโอไม้สนอันเงียบสงบในหางโจว อบอวลด้วยไม้เพาโลเนียเก่าแก่และเครื่องสายไหม';

  @override
  String get shaanxiShadowPuppetTheater => 'โรงละครหุ่นเงาหนังตะลุงส่านซี';

  @override
  String get behindAnIlluminatedWhiteSilkScreenW =>
      'หลังจอผ้าไหมสีขาวส่องสว่าง มีหุ่นเงาหนังโปร่งแสงอันประณีต';

  @override
  String get chineseCalligraphyWorkshop => 'เวิร์กช็อปการเขียนพู่กันจีน';

  @override
  String get aTranquilStudioScentedWithPineSootI =>
      'สตูดิโออันเงียบสงบอบอวลด้วยกลิ่นน้ำหมึกเขม่าสน ม้วนกระดาษฟาง และกลิ่นชาหอมละมุน';

  @override
  String get adoptingACatAtAnAnimalShelter =>
      'รับเลี้ยงแมวที่สถานสงเคราะห์สัตว์';

  @override
  String get aCozyPetRescueCenterInHangzhouWithE =>
      'ศูนย์ช่วยเหลือสัตว์เลี้ยงอันอบอุ่นในหางโจว มีลูกแมวขี้เล่นและน้ำชาสำหรับผู้มาเยือน';

  @override
  String get scriptMurderMysteryJubenshaGame =>
      'เกมไขคดีปริศนาฆาตกรรม (จวี้เปิ่นซา)';

  @override
  String get aThemedDetectiveLoungeInShanghaiWit =>
      'เลานจ์นักสืบตามธีมในเซี่ยงไฮ้ พร้อมผู้เล่นในชุดแต่งกายและแสงเทียนสลัว';

  @override
  String get vintageVinylRecordShopInShanghai =>
      'ร้านแผ่นเสียงไวนิลวินเทจในเซี่ยงไฮ้';

  @override
  String get aHiddenVinylStoreInAnOldLaneHousePa =>
      'ร้านแผ่นเสียงที่ซ่อนอยู่ในบ้านโบราณ เต็มไปด้วยเพลงแคนโตป็อปยุค 80 และแจ๊สคลาสสิก';

  @override
  String get ktvKaraokePartyWithFriends => 'ปาร์ตี้คาราโอเกะ KTV กับเพื่อนๆ';

  @override
  String get joiningACityBikeCyclingClub => 'เข้าร่วมชมรมปั่นจักรยานในเมือง';

  @override
  String get aGatheringOfCyclistsByTheRiverfront =>
      'การรวมตัวของนักปั่นริมฝั่งแม่น้ำ เพื่อเตรียมพร้อมสำหรับการปั่นยามค่ำคืนชมเส้นขอบฟ้าของเมือง';

  @override
  String get blindBoxToyTradingMeetup => 'งานมีทติ้งแลกเปลี่ยนของเล่นกล่องสุ่ม';

  @override
  String get aColorfulPopcultureToyStoreInChaoya =>
      'ร้านของเล่นป็อปคัลเจอร์สีสันสดใสในเฉาหยาง มีชั้นโชว์และกล่องสะสมที่ยังไม่เปิด';

  @override
  String get droneSkylineVideographyAtTheBund =>
      'ถ่ายวิดีโอเส้นขอบฟ้าด้วยโดรนที่หาดไว่ทาน';

  @override
  String get theBundPromenadeAtDuskOverlookingTh =>
      'ทางเดินเลียบหาดไว่ทานยามพลบค่ำ มองเห็นตึกระฟ้าประดับไฟแห่งอนาคตของผู่ตง';

  @override
  String get goldenRetrieverCafeInNanjing =>
      'คาเฟ่สุนัขโกลเด้นรีทรีฟเวอร์ในหนานจิง';

  @override
  String get aSunnyCheerfulPetCafeWithDozensOfFr =>
      'คาเฟ่สัตว์เลี้ยงแสนสดใส มีสุนัขขนนุ่มเป็นมิตรหลายสิบตัวคอยต้อนรับผู้มาเยือน';

  @override
  String get boulderingClimbingGymInChengdu => 'ยิมปีนหน้าผาจำลองในเฉิงตู';

  @override
  String get aModernIndoorClimbingGymWithVibrant =>
      'ยิมปีนผาในร่มที่ทันสมัย มีเส้นทางปีนป่ายสีสันสดใสและดนตรีเร้าใจ';

  @override
  String get aMassiveConventionHallFilledWithCol =>
      'ฮอลล์จัดแสดงงานขนาดใหญ่ เต็มไปด้วยบูธเกมสีสันสดใส โฟโต้บอร์ด และครีเอเตอร์ในชุดคอสเพลย์';

  @override
  String get askingForDirectionsInABeijingHutong => 'การถามทางในหูท่งปักกิ่ง';

  @override
  String get aMazeOfHistoricGreybrickAlleysWithB =>
      'เขาวงกตตรอกอิฐสีเทาโบราณ มีจักรยาน ลานบ้าน และต้นทับทิม';

  @override
  String get buyingFreshFruitAtAWetMarket => 'การซื้อผลไม้สดที่ตลาดสด';

  @override
  String get aLivelyMorningNeighborhoodMarketWit =>
      'ตลาดสดยามเช้าอันมีชีวิตชีวา มีลิ้นจี่ มะม่วง และแก้วมังกรสดวางเรียงรายเป็นกองโต';

  @override
  String get flowerMarketBouquetInKunming => 'จัดช่อดอกไม้ที่ตลาดดอกไม้คุนหมิง';

  @override
  String get theFamousDounanFlowerMarketSurround =>
      'ตลาดดอกไม้โต้วหนานอันเลื่องชื่อ ล้อมรอบด้วยดอกกุหลาบ ลิลลี่ และกิ่งยูคาลิปตัสนับพัน';

  @override
  String get tailorAlterationsInAnOldLaneHouse =>
      'แก้ทรงเสื้อผ้ากับช่างตัดเสื้อในบ้านโบราณ';

  @override
  String get aTraditionalTailorShopFilledWithSew =>
      'ร้านตัดเสื้อแบบดั้งเดิม เต็มไปด้วยจักรเย็บผ้า ผ้าพับต่างๆ และสายวัด';

  @override
  String get expressParcelLockerRetrieval => 'รับพัสดุด่วนที่ตู้ล็อกเกอร์';

  @override
  String get downstairsAtAResidentialApartmentGa =>
      'ชั้นล่างบริเวณประตูด้านหน้าอพาร์ตเมนต์ ติดกับระบบตู้ล็อกเกอร์อัจฉริยะ';

  @override
  String get bicycleFlatTireRepairAtCampusGate =>
      'ซ่อมยางรถจักรยานรั่วที่หน้าประตูมหาวิทยาลัย';

  @override
  String get aSmallOutdoorRoadsideToolkitStandUn =>
      'เพิงเครื่องมือซ่อมรถริมทางกลางแจ้งขนาดเล็กใต้ร่มเงาต้นไทรใบดก';

  @override
  String get techCompanyProductDemo => 'การสาธิตผลิตภัณฑ์ของบริษัทเทคโนโลยี';

  @override
  String get aFuturisticTechConferenceBoothInShe =>
      'บูธงานประชุมเทคโนโลยีแห่งอนาคตในเซินเจิ้น จัดแสดงฮาร์ดแวร์ AI ล้ำสมัย';

  @override
  String get ecommerceLivestreamStudio => 'สตูดิโอไลฟ์สดอีคอมเมิร์ซ';

  @override
  String get aHighenergyBroadcastStudioWithRingL =>
      'สตูดิโอถ่ายทอดสดพลังงานสูง พร้อมไฟวงแหวน ราวแขวนสินค้า และจอแสดงความคิดเห็นสด';

  @override
  String get yiwuInternationalTradeMarket => 'ตลาดการค้าระหว่างประเทศอี้อู';

  @override
  String get aVastMultistoryCommercialExhibition =>
      'ศูนย์แสดงสินค้าเชิงพาณิชย์หลายชั้นขนาดใหญ่ เต็มไปด้วยสินค้าขายส่งและงานฝีมือนับล้านรายการ';

  @override
  String get universityCampusExchangeProgram =>
      'โครงการแลกเปลี่ยนในมหาวิทยาลัย';

  @override
  String get aSunnyLawnOutsideTheUniversityLibra =>
      'สนามหญ้ากลางแดดนอกห้องสมุดมหาวิทยาลัย มีนักศึกษานั่งอ่านหนังสือและดื่มชานม';

  @override
  String get pleaseEnterAScenarioTopic => 'กรุณากรอกหัวข้อสถานการณ์';

  @override
  String get nameTitle => 'ชื่อ (หัวข้อเรื่อง)';

  @override
  String get aiCharacter => 'ตัวละคร AI';

  @override
  String get helloWelcomeHereWhatShallWeChatAbou =>
      'สวัสดี! ยินดีต้อนรับ วันนี้เราจะพูดคุยเรื่องอะไรกันดี?';

  @override
  String get greetYourConversationPartner => 'ทักทายคู่สนทนาของคุณ';

  @override
  String get askAQuestionInChinese => 'ถามคำถามเป็นภาษาจีน';

  @override
  String get pinyinWithToneMarks => 'พินอินพร้อมเครื่องหมายวรรณยุกต์';

  @override
  String get goal1InEnglish => 'เป้าหมายที่ 1 เป็นภาษาอังกฤษ';

  @override
  String get goal2InEnglish => 'เป้าหมายที่ 2 เป็นภาษาอังกฤษ';

  @override
  String get goal3InEnglish => 'เป้าหมายที่ 3 เป็นภาษาอังกฤษ';

  @override
  String get beginner => 'ระดับเริ่มต้น';

  @override
  String get hsk12 => 'HSK 1-2';

  @override
  String get hsk34 => 'HSK 3-4';

  @override
  String get hsk56 => 'HSK 5-6';

  @override
  String get master => 'ระดับปรมาจารย์';

  @override
  String get azurePronunciationAssessment => 'การประเมินการออกเสียงโดย AZURE';

  @override
  String get tapToReview => 'แตะเพื่อทบทวน';

  @override
  String get overallScore => 'คะแนนรวม';

  @override
  String get toneAccuracy => 'ความแม่นยำของวรรณยุกต์';

  @override
  String get fluency => 'ความคล่องแคล่ว';

  @override
  String get report => 'รายงานผล';

  @override
  String get goodPronunciationButCanBeBetter =>
      'ออกเสียงได้ดี แต่ยังพัฒนาให้ดีขึ้นได้อีก!';

  @override
  String get didYouMeanToSay => 'คุณตั้งใจจะพูดว่า... ใช่หรือไม่?';

  @override
  String get greatKeepTrying => 'Great!\' : \'Keep trying!';

  @override
  String get completeness => 'ความครบถ้วน';

  @override
  String get targetTone => 'วรรณยุกต์เป้าหมาย';

  @override
  String get k4toneComparisonTapToListen =>
      'เปรียบเทียบวรรณยุกต์ 4 เสียง (แตะเพื่อฟัง):';

  @override
  String get youSpokeMatch => 'สิ่งที่คุณพูด (ตรงกัน!)';

  @override
  String get youSpoke => 'สิ่งที่คุณพูด';

  @override
  String get yourPrimaryCollectionOfCharacters => 'ชุดสะสมตัวอักษรหลักของคุณ';

  @override
  String get deckNotFound => 'ไม่พบสำรับ';

  @override
  String get cannotDeleteTheDefaultDeck => 'ไม่สามารถลบสำรับเริ่มต้นได้';

  @override
  String get hsk4UpperIntermediate1 => 'HSK 4: ระดับกลางค่อนสูง';

  @override
  String get theFirst150CharactersToStartYourJou =>
      'ตัวอักษร 150 ตัวแรกเพื่อเริ่มต้นการเดินทางของคุณ';

  @override
  String get buildYourVocabularyTo300EssentialWo =>
      'สะสมคลังคำศัพท์ของคุณสู่ 300 คำสำคัญ';

  @override
  String get masterConversationalFluencyWith600W =>
      'เชี่ยวชาญการสนทนาอย่างคล่องแคล่วด้วย 600 คำ';

  @override
  String get readTextsAndConverseFluentlyWith120 =>
      'อ่านบทความและสนทนาอย่างคล่องแคล่วด้วย 1,200 คำ';

  @override
  String get readNewspapersAndWatchMoviesWith250 =>
      'อ่านหนังสือพิมพ์และชมภาพยนตร์ได้อย่างเข้าใจด้วย 2,500 คำ';

  @override
  String get databaseBoxNotOpen => 'กล่องฐานข้อมูลไม่ได้เปิดอยู่';

  @override
  String get hsk1DataFileIsEmpty => 'ไฟล์ข้อมูล HSK1 ว่างเปล่า';

  @override
  String get gold => 'ทองคำ';

  @override
  String get globalDictionaryNotInitialized =>
      'พจนานุกรมส่วนกลางยังไม่พร้อมใช้งาน';

  @override
  String get reading => 'การอ่าน';

  @override
  String get recall => 'การระลึกความจำ';

  @override
  String get speaking => 'การพูด';

  @override
  String get listening1 => 'การฟัง';

  @override
  String get practiceStrokeOrderWithVisualGuides =>
      'ฝึกเขียนลำดับขีดด้วยเส้นนำสายตา';

  @override
  String get seeTheCharacterRecallThePinyinAndMe =>
      'ดูตัวอักษร แล้วระลึกพินอินและความหมาย';

  @override
  String get seeTheMeaningDrawTheCharacterFromMe =>
      'ดูความหมาย แล้วเขียนตัวอักษรจากความจำ';

  @override
  String get readOutLoudToTestYourPronunciationT =>
      'อ่านออกเสียงเพื่อทดสอบวรรณยุกต์และการออกเสียงของคุณ';

  @override
  String get listenToTheAudioAndIdentifyTheChara =>
      'ฟังเสียงแล้วระบุตัวอักษรที่ถูกต้อง';

  @override
  String get contract => 'ข้อสัญญา';

  @override
  String get whoeverImplementsMeMustBeAbleToDoTh =>
      'ผู้ใดก็ตามที่ปรับใช้ฉัน จะต้องทำสิ่งเหล่านี้ได้';

  @override
  String get koreFenrirCharonAoedePuckOrLocal =>
      'Kore\', \'Fenrir\', \'Charon\', \'Aoede\', \'Puck\', หรือ \'local';

  @override
  String get manageDecks => 'จัดการสำรับคำศัพท์';

  @override
  String get weRanIntoTroubleLoadingTheLibraryPl =>
      'เกิดปัญหาในการโหลดคลังตำรา กรุณาลองใหม่อีกครั้ง';

  @override
  String get noCharactersInLexicon1 => 'ไม่มีตัวอักษรในคลังคำศัพท์';

  @override
  String get masterTheBuildingBlocks => 'ฝึกฝนชิ้นส่วนพื้นฐานให้เชี่ยวชาญ';

  @override
  String get other => 'อื่นๆ';

  @override
  String get required => 'จำเป็น';

  @override
  String get library1 => 'คลังตำรา';

  @override
  String get youAreAPremiumMember => 'คุณเป็นสมาชิกพรีเมียม';

  @override
  String get createAccountToSyncProgress => 'สร้างบัญชีเพื่อซิงค์ความคืบหน้า';

  @override
  String get signOut => 'ออกจากระบบ';

  @override
  String get account => 'บัญชีผู้ใช้';

  @override
  String get guestScholar => 'บัณฑิตรับเชิญ';

  @override
  String get localAccount => 'บัญชีในเครื่อง';

  @override
  String get unknownRadical => 'ไม่ทราบหมวดอักษร';

  @override
  String get followTheGuideStroke => 'ลากเส้นตามรอยนำ';

  @override
  String get strokeAnimationSpeed => 'ความเร็วแอนิเมชันลำดับขีด';

  @override
  String get notifications => 'การแจ้งเตือน';

  @override
  String get deutsch => 'ภาษาเยอรมัน';

  @override
  String get bahasaIndonesia => 'ภาษาอินโดนีเซีย';

  @override
  String get italiano => 'ภาษาอิตาลี';

  @override
  String get today1d2d3d4d5d6d =>
      'Today\', \'1d\', \'2d\', \'3d\', \'4d\', \'5d\', \'6d';

  @override
  String get targetDeck => 'สำรับเป้าหมาย';

  @override
  String get mixed => 'คละหมวดหมู่';

  @override
  String get topicForContext => 'หัวข้อ (สำหรับบริบท)';

  @override
  String get nounsOnly => 'คำนามเท่านั้น';

  @override
  String get verbsOnly => 'คำกริยาเท่านั้น';

  @override
  String get idiomsChengyu => 'สำนวนจีน (เฉิงอวี่)';

  @override
  String get fullSentences => 'ประโยคเต็ม';

  @override
  String get beginnerHsk12 => 'ระดับเริ่มต้น (HSK 1-2)';

  @override
  String get intermediateHsk34 => 'ระดับกลาง (HSK 3-4)';

  @override
  String get advancedHsk56 => 'ระดับสูง (HSK 5-6)';

  @override
  String get generatedByAi => 'สร้างโดย AI';

  @override
  String get canYouGiveMeTwoMoreExamplesUsingThi =>
      'ช่วยยกตัวอย่างเพิ่มเติมอีก 2 ประโยคที่ใช้คำนี้ได้ไหม?';

  @override
  String get whatAreSomeSimilarWordsAndHowDoThey =>
      'มีคำที่มีความหมายใกล้เคียงกันคำใดบ้าง และมีความแตกต่างกันอย่างไร?';

  @override
  String get isThisWordUsedInSpokenOrWrittenChin =>
      'คำนี้ใช้ในภาษาพูดหรือภาษาเขียนมากกว่ากัน?';

  @override
  String get areThereOtherWaysToTranslateThisWor =>
      'มีวิธีอื่นในการแปลคำนี้หรือไม่?';

  @override
  String get whatAreCommonWordsThatGoTogetherWit =>
      'คำศัพท์ที่พบบ่อยและมักใช้ร่วมกับคำนี้มีอะไรบ้าง?';

  @override
  String get whatAreCommonMistakesLearnersMakeWi =>
      'ข้อผิดพลาดที่ผู้เรียนมักทำเมื่อใช้คำนี้คืออะไร?';

  @override
  String get emptyResponse => 'ไม่มีการตอบกลับ';

  @override
  String get whatIsTheOracleBoneScriptOriginOfTh =>
      'ที่มาของตัวอักษรนี้ในอักษรกระดูกสัตว์โบราณคืออะไร?';

  @override
  String get howDidTheAncientFormOfThisCharacter =>
      'รูปแบบโบราณของตัวอักษรนี้มีวิวัฒนาการอย่างไรตามกาลเวลา?';

  @override
  String get giveMe3CommonWordsThatContainThisCh =>
      'ขอยกตัวอย่างคำศัพท์ที่พบบ่อย 3 คำที่มีตัวอักษรนี้ประกอบอยู่';

  @override
  String get whatOtherCharactersShareTheSameRadi =>
      'มีตัวอักษรอื่นใดอีกบ้างที่ใช้หมวดอักษรเดียวกัน?';

  @override
  String get isThereAChineseProverbOrSayingFeatu =>
      'มีสุภาษิตหรือคำพังเพยจีนที่มีตัวอักษรนี้ปรากฏอยู่หรือไม่?';

  @override
  String get explainTheStrokeOrderRulesForThisCh =>
      'ช่วยอธิบายกฎลำดับขีดของตัวอักษรนี้';

  @override
  String get giveMeOneCalligraphyTipForWritingTh =>
      'ขอเคล็ดลับการเขียนพู่กัน 1 ข้อเพื่อให้เขียนตัวอักษรนี้ได้อย่างสวยงาม';

  @override
  String get isThereAnythingTrickyAboutUsingThis =>
      'มีจุดที่ต้องระวังเป็นพิเศษในการใช้คำนี้ตามหลักไวยากรณ์หรือไม่?';

  @override
  String get whatWordsAreCommonlyConfusedWithThi =>
      'คำใดที่มักสับสนกับคำนี้บ่อยๆ และเพราะเหตุใด?';

  @override
  String get doesThisCharacterCarryCulturalSymbo =>
      'ตัวอักษรนี้มีความหมายเชิงสัญลักษณ์ทางวัฒนธรรมในจีนหรือไม่?';

  @override
  String get isThisCharacterCommonlySeenInChines =>
      'ตัวอักษรนี้พบเห็นได้บ่อยในภาพยนตร์ เพลง หรือตำราจีนหรือไม่?';

  @override
  String get whatDoesTheRadicalOfThisCharacterMe =>
      'หมวดอักษรของตัวอักษรนี้มีความหมายว่าอย่างไร?';

  @override
  String get breakDownEveryComponentAndItsMeanin =>
      'แยกส่วนประกอบทุกชิ้นพร้อมอธิบายความหมาย';

  @override
  String get giveMeATrickToRememberTheCorrectTon =>
      'ขอเทคนิคช่วยจำวรรณยุกต์ที่ถูกต้องของตัวอักษรนี้';

  @override
  String get areThereCommonHomophonesThatAreOfte =>
      'มีคำพ้องเสียงที่มักสับสนกับคำนี้บ่อยๆ หรือไม่?';

  @override
  String get quotaExceeded => 'เกินโควตาการใช้งาน';

  @override
  String get mustProvideEitherCardOrCards => 'ต้องระบุการ์ดใบเดียวหรือหลายใบ';

  @override
  String get deckSettings => 'การตั้งค่าสำรับ';

  @override
  String get saveSettings => 'บันทึกการตั้งค่า';

  @override
  String get sealRed => 'สีแดงชาดตราประทับ';

  @override
  String get sealScript => 'อักษรตราประทับ (จ้วนซู)';

  @override
  String get startYourStreak => 'เริ่มต้นความต่อเนื่องของคุณ';

  @override
  String get traditionalCharacter => 'อักษรจีนตัวเต็ม';

  @override
  String get inQueue => 'อยู่ในคิว';

  @override
  String get tapToListenAgain => 'แตะเพื่อฟังอีกครั้ง';

  @override
  String get contextClue => 'บริบทช่วยใบ้';

  @override
  String get microphonePermissionRequired1 =>
      'จำเป็นต้องได้รับสิทธิ์การเข้าถึงไมโครโฟน';

  @override
  String get recordingFailedNoFile => 'การบันทึกเสียงล้มเหลว (ไม่พบไฟล์)';

  @override
  String get holdToSpeakOptional => 'กดค้างเพื่อพูด (ไม่บังคับ)';

  @override
  String get microphonePermissionDeniedEnableItI =>
      'การอนุญาตใช้ไมโครโฟนถูกปฏิเสธ เปิดใช้งานในการตั้งค่าเพื่อใช้งาน Shadowing Studio';

  @override
  String get sessionSummary => 'สรุปผลเซสชัน';

  @override
  String get hereAreTheCharactersYouStruggledWit =>
      'นี่คือตัวอักษรที่คุณยังติดขัด:';

  @override
  String get applySessionGradesToSpacedRepetitio =>
      'นำคะแนนเซสชันไปใช้กับระบบทบทวนแบบเว้นระยะ (โหมดการพูด)';

  @override
  String get masterYourMandarinPronunciationnbyM =>
      'ฝึกฝนการออกเสียงภาษาจีนกลางให้เชี่ยวชาญ\nด้วยการเลียนแบบเสียงเจ้าของภาษา';

  @override
  String get aiIsGradingYourPronunciation =>
      'AI กำลังให้คะแนนการออกเสียงของคุณ...';

  @override
  String get holdMicToRecordReleaseToGrade =>
      'กดไมโครโฟนค้างไว้เพื่อบันทึก ปล่อยเพื่อดูคะแนน';

  @override
  String get tapAnySyllableToAuditionAll4Tones =>
      'แตะที่พยางค์ใดก็ได้เพื่อลองฟังวรรณยุกต์ทั้ง 4 เสียง:';

  @override
  String get freeFlowConversationalPractice => 'ฝึกสนทนาแบบอิสระลื่นไหล';

  @override
  String get failedToGeneratePhrasePleaseTryAgai =>
      'สร้างวลีไม่สำเร็จ กรุณาลองใหม่อีกครั้ง';

  @override
  String get recordingTooShortHoldTheMicButtonLo =>
      'เสียงบันทึกสั้นเกินไป กรุณากดปุ่มไมโครโฟนค้างไว้นานกว่านี้';

  @override
  String get recordingErrorPleaseTryAgain =>
      'เกิดข้อผิดพลาดในการบันทึกเสียง กรุณาลองใหม่อีกครั้ง';

  @override
  String get noRecordingCapturedPleaseTryAgain =>
      'ตรวจไม่พบเสียงบันทึก กรุณาลองใหม่อีกครั้ง';

  @override
  String get recordedAudioIsEmptyPleaseTryAgainA =>
      'ไฟล์เสียงที่บันทึกว่างเปล่า กรุณาลองใหม่อีกครั้งและพูดให้ชัดเจน';

  @override
  String get azureSpeechApiKeysAreMissing1 => 'ไม่พบคีย์ Azure Speech API';

  @override
  String get azureError401 => 'ข้อผิดพลาด Azure 401';

  @override
  String get azureAuthenticationFailedCheckYourS =>
      'การยืนยันตัวตน Azure ล้มเหลว ตรวจสอบคีย์ Speech API และ Region ในไฟล์ .env';

  @override
  String get azureError429 => 'ข้อผิดพลาด Azure 429';

  @override
  String get azureQuotaExceededTryAgainLater =>
      'เกินโควตา Azure แล้ว กรุณาลองใหม่อีกครั้งในภายหลัง';

  @override
  String get azureGradingTimedOutCheckYourIntern =>
      'การให้คะแนนจาก Azure หมดเวลา กรุณาตรวจสอบการเชื่อมต่ออินเทอร์เน็ต';

  @override
  String get recognitionFailedNull => 'การรู้จำเสียงล้มเหลว: null';

  @override
  String get couldNotHearYouClearlyPleaseTryAgai =>
      'ระบบไม่ได้ยินเสียงของคุณอย่างชัดเจน กรุณาลองใหม่อีกครั้ง';

  @override
  String get singlePhrasePractice => 'ฝึกฝนวลีเดี่ยว';

  @override
  String get failedToGeneratePhrase => 'สร้างวลีไม่สำเร็จ';

  @override
  String get omitted => 'ตกหล่น';

  @override
  String get partial => 'ออกเสียงบางส่วน';

  @override
  String get mispronounced => 'ออกเสียงผิด';

  @override
  String get startSession1 => 'เริ่มเซสชัน';

  @override
  String get chinese => 'ภาษาจีน';

  @override
  String get paused => 'หยุดชั่วคราว';

  @override
  String get translationFailed => 'การแปลล้มเหลว';

  @override
  String get engagingMacroeconomicAndBusinessBre =>
      'วิเคราะห์เศรษฐกิจมหภาคและธุรกิจอย่างน่าติดตาม ผ่านการเล่าเรื่องที่สนุกสนาน';

  @override
  String get exploresWorldEconomiesBankingHistor =>
      'สำรวจเศรษฐกิจโลก ประวัติศาสตร์การธนาคาร และพลวัตของอุตสาหกรรมระดับสากล';

  @override
  String get clearArticulateMandarinPerfectForIn =>
      'ภาษาจีนกลางที่ชัดถ้อยชัดคำ เหมาะอย่างยิ่งสำหรับผู้เรียนระดับกลางและระดับสูง';

  @override
  String get chefWang => 'เชฟหวัง (Chef Wang)';

  @override
  String get masterSichuanCulinaryTechniquesTaug =>
      'ฝึกฝนเทคนิคการทำอาหารเสฉวน ถ่ายทอดตรงโดยหัวหน้าเชฟมืออาชีพ';

  @override
  String get stepbystepAuthenticChineseRecipesWi =>
      'สูตรอาหารจีนแท้แบบทีละขั้นตอน พร้อมการควบคุมไฟในกระทะและทักษะการใช้มีด';

  @override
  String get conciseCulinaryVocabularyAndClearIn =>
      'คำศัพท์การทำอาหารที่กระชับและคำอธิบายที่ชัดเจนด้วยภาษาจีนกลางที่เป็นธรรมชาติ';

  @override
  String get cinematographyCuttingedgeCameraTech =>
      'ศาสตร์แห่งภาพยนตร์ เทคโนโลยีกล้องล้ำสมัย และการประเมินสื่อดิจิทัลเชิงลึก';

  @override
  String get highproductionDocumentaryStyleExplo =>
      'รูปแบบสารคดีโปรดักชันคุณภาพสูง สำรวจการสร้างสรรค์วิดีโอและนวัตกรรม AI';

  @override
  String get richTechnicalMandarinWithCrystalcle =>
      'ภาษาจีนกลางเชิงเทคนิคที่เข้มข้น ออกเสียงชัดเจน พร้อมคำบรรยายประกอบ';

  @override
  String get indepthInvestigativeJournalismAndCu =>
      'งานข่าวเชิงสืบสวนเชิงลึกและบทวิเคราะห์เหตุการณ์ปัจจุบัน';

  @override
  String get criticalPerspectivesOnSocialPhenome =>
      'มุมมองเชิงวิพากษ์ต่อปรากฏการณ์ทางสังคม ข่าวสารรอบโลก และประวัติศาสตร์';

  @override
  String get formalInvestigativeDiscourseIdealFo =>
      'ภาษาทางการเชิงสืบสวน เหมาะอย่างยิ่งสำหรับการฝึกฟังเพื่อความเข้าใจขั้นสูง';

  @override
  String get bitesizedAnimatedScienceDocumentari =>
      'สารคดีวิทยาศาสตร์แอนิเมชันขนาดสั้น ตอบคำถามน่ารู้ในชีวิตประจำวัน';

  @override
  String get exploresPhysicsBiologyAndEverydayCu =>
      'สำรวจฟิสิกส์ ชีววิทยา และเรื่องน่ารู้รอบตัวด้วยอินโฟกราฟิกที่เข้าใจง่าย';

  @override
  String get standardBeijingMandarinWithWellpace =>
      'ภาษาจีนกลางสำเนียงปักกิ่งมาตรฐาน จังหวะการบรรยายพอเหมาะพร้อมคำบรรยายชัดเจน';

  @override
  String get heartwarmingStreetFoodAdventuresAnd =>
      'การผจญภัยชิมสตรีทฟู้ดอันอบอุ่นหัวใจและบทสนทนาจริงใจทั่วประเทศจีน';

  @override
  String get exploresRegionalHumanStoriesFamilyT =>
      'สำรวจเรื่องราวชีวิตของผู้คนในท้องถิ่น ความผูกพันในครอบครัว และอาหารจานเด็ดประจำถิ่น';

  @override
  String get naturalConversationalMandarinWithDa =>
      'ภาษาจีนกลางสำหรับการสนทนาที่เป็นธรรมชาติ สอดแทรกคำสแลงประจำวันและอารมณ์อบอุ่น';

  @override
  String get humorousAndHonestConsumerElectronic =>
      'รีวิวอุปกรณ์อิเล็กทรอนิกส์สำหรับผู้ใช้อย่างตรงไปตรงมาและมีอารมณ์ขันจากประสบการณ์จริง';

  @override
  String get testingSmartphonesSmartHomeGadgetsA =>
      'ทดสอบสมาร์ตโฟน อุปกรณ์สมาร์ตโฮม และอุปกรณ์เทคโนโลยีไลฟ์สไตล์';

  @override
  String get relaxedHumorousConversationalDialog =>
      'บทสนทนาที่ผ่อนคลาย ขบขัน พร้อมคำสแลงและภาษาพูดสมัยใหม่';

  @override
  String get seanKitchen => 'Sean Kitchen';

  @override
  String get deliciousHomecookedChineseDishesAnd =>
      'อาหารจีนปรุงเองที่บ้านแสนอร่อยและการรังสรรค์ขนมสตรีทฟู้ดขึ้นมาใหม่';

  @override
  String get easytofollowKitchenTipsForCookingAu =>
      'เคล็ดลับในครัวที่ทำตามได้ง่ายเพื่อปรุงอาหารเอเชียรสชาติดั้งเดิม';

  @override
  String get warmInvitingCommentaryWithPractical =>
      'การบรรยายที่อบอุ่นเป็นกันเอง พร้อมคำศัพท์ในครัวที่นำไปใช้ได้จริง';

  @override
  String get chineseChannel => 'Chinese Channel';

  @override
  String get structuredChineseLanguageLessonsAnd =>
      'บทเรียนภาษาจีนที่มีโครงสร้างชัดเจนและบทเรียนสำรวจวัฒนธรรม';

  @override
  String get grammarPointsHskVocabularyBuildingA =>
      'ไวยากรณ์ การสะสมคำศัพท์ HSK และรูปแบบประโยคสนทนา';

  @override
  String get clearEducationalPacingTailoredSpeci =>
      'จังหวะการสอนที่ชัดเจน ออกแบบมาโดยเฉพาะสำหรับผู้เรียนภาษาจีน';

  @override
  String get oneInABillion => 'One in a Billion';

  @override
  String get intimatePortraitsAndStoriesOfUnique =>
      'ภาพสะท้อนและเรื่องราวเชิงลึกของบุคคลที่มีเอกลักษณ์ในสังคมจีนร่วมสมัย';

  @override
  String get exploresDiverseLifeChoicesYouthCult =>
      'สำรวจทางเลือกชีวิตที่หลากหลาย วัฒนธรรมคนรุ่นใหม่ และการเปลี่ยนแปลงทางสังคมยุคใหม่';

  @override
  String get deepNarrativeStorytellingWithRichVo =>
      'การเล่าเรื่องเชิงบรรยายที่ลึกซึ้ง พร้อมคำศัพท์ที่สละสลวยและเสียงสัมภาษณ์จริง';

  @override
  String get vickySoup => 'Vicky Soup';

  @override
  String get aestheticLifestyleVlogsFashionStyli =>
      'วล็อกไลฟ์สไตล์สุดเก๋ การแต่งกายแฟชั่น และกิจวัตรประจำวัน';

  @override
  String get travelDiariesAndCozyLifeMomentsDocu =>
      'บันทึกการเดินทางและช่วงเวลาชีวิตที่อบอุ่น ถ่ายทอดด้วยบรรยากาศภาพยนตร์';

  @override
  String get naturalCasualMandarinSpokenAtAComfo =>
      'ภาษาจีนกลางแบบสบายๆ เป็นธรรมชาติ พูดด้วยจังหวะที่ฟังง่ายและสื่ออารมณ์';

  @override
  String get tededMandarin => 'TED-Ed ภาษาจีนกลาง';

  @override
  String get highqualityAnimatedEducationalLesso =>
      'บทเรียนการศึกษาแอนิเมชันคุณภาพสูงเกี่ยวกับวิทยาศาสตร์ ปรัชญา และประวัติศาสตร์';

  @override
  String get thoughtprovokingRiddlesClassicLiter =>
      'ปริศนาชวนคิด วรรณกรรมคลาสสิก และความลึกลับทางจิตวิทยา';

  @override
  String get impeccableVoiceoverMandarinWithSync =>
      'เสียงพากย์ภาษาจีนกลางที่ไร้ที่ติ พร้อมคำบรรยายสองภาษาที่ซิงค์อย่างแม่นยำ';

  @override
  String get channel => 'ช่อง';

  @override
  String get curatedCulturalDocumentariesAndChin =>
      'สารคดีวัฒนธรรมคัดสรรและไฮไลต์วิถีชีวิตชาวจีน';

  @override
  String get exploringTraditionalArtsHeritageCra =>
      'สำรวจศิลปะดั้งเดิม งานฝีมือมรดกทางวัฒนธรรม และเทรนด์สมัยใหม่';

  @override
  String get highQualityAudioWithSynchronizedChi =>
      'เสียงคุณภาพสูงพร้อมคำบรรยายภาษาจีนที่ซิงค์ตรงกับเสียง';

  @override
  String get interestingStoriesAndCreativeVideoP =>
      'เรื่องราวที่น่าสนใจและโปรเจกต์วิดีโอสร้างสรรค์จากโลกอินเทอร์เน็ตของจีน';

  @override
  String get engagingInterviewsStorytellingAndVi =>
      'บทสัมภาษณ์ที่น่าติดตาม การเล่าเรื่อง และการสำรวจผ่านภาพ';

  @override
  String get greatListeningMaterialWithStandardP =>
      'สื่อการฝึกฟังชั้นยอดด้วยการออกเสียงตามมาตรฐาน';

  @override
  String get xVsY => 'X vs Y';

  @override
  String get untitled => 'ไม่มีชื่อเรื่อง';

  @override
  String get contemporaryStories => 'เรื่องราวร่วมสมัย';

  @override
  String get history => 'ประวัติศาสตร์';

  @override
  String get advancedReading => 'การอ่านระดับสูง';

  @override
  String get intermediateReading => 'การอ่านระดับกลาง';

  @override
  String get beginnerReading => 'การอ่านระดับต้น';

  @override
  String get mandarinBean => 'Mandarin Bean';

  @override
  String get unknown => 'ไม่ระบุ';

  @override
  String get localDb => 'ฐานข้อมูลในเครื่อง';

  @override
  String get emperorTaizong => 'จักรพรรดิถังไท่จง';

  @override
  String get emperorXuanzong => 'จักรพรรดิถังเสวียนจง';

  @override
  String get liBai => 'หลี่ไป๋ (Li Bai)';

  @override
  String get gradedReader => 'บทอ่านไล่ระดับความยาก';

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
  String get videoOfTheDay => 'วิดีโอประจำวัน';

  @override
  String get noValidVideoFound => 'ไม่พบวิดีโอที่ถูกต้อง';

  @override
  String get listeningPractice => 'การฝึกฟัง';

  @override
  String get socialSkills => 'ทักษะทางสังคม';

  @override
  String get culturalContext => 'บริบททางวัฒนธรรม';

  @override
  String get realLife => 'ชีวิตจริง';

  @override
  String get realWorld => 'โลกแห่งความเป็นจริง';

  @override
  String get articleOfTheDay => 'บทความประจำวัน';

  @override
  String get failedToLoadOrParseRssFeed =>
      'โหลดหรือแยกวิเคราะห์ฟีด RSS ไม่สำเร็จ';

  @override
  String get drama => 'ละคร / ซีรีส์';

  @override
  String get youkugetAppNow => 'YOUKU-รับแอปได้เลย';

  @override
  String get romanceTrailer => 'Romance\', \'Trailer';

  @override
  String get romance => 'โรแมนติก';

  @override
  String get action => 'แอ็กชัน';

  @override
  String get mystery => 'ลึกลับ / สืบสวน';

  @override
  String get historical => 'ย้อนยุค / ประวัติศาสตร์';

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
  String get youkuEnglishgetAppNow => 'YOUKU English-รับแอปได้เลย';

  @override
  String get theDouble => 'มรสุมชีวิต (The Double)';

  @override
  String get updatesByOshin => 'Updates By Oshin';

  @override
  String get backFromTheBrink => 'ล่าหัวใจมังกร (Back from the Brink)';

  @override
  String get fallingIntoYourSmile => 'รักยิ้มของเธอ (Falling Into Your Smile)';

  @override
  String get everyoneLovesMe => 'อย่ารักฉันเลย (Everyone Loves Me)';

  @override
  String get tillTheEndOfTheMoon => 'จันทราอัสดง (Till The End of The Moon)';

  @override
  String get theBestDayOfMyLife =>
      'วันที่ดีที่สุดในชีวิต (The Best Day of My Life)';

  @override
  String get gikkiChineseDrama => 'GIKKI ซีรีส์จีน';

  @override
  String get dashingYouth => 'ดรุณอันดามัน (Dashing Youth)';

  @override
  String get rebornChineseDramaEngSub => 'Reborn ซีรีส์จีน ซับอังกฤษ';

  @override
  String get ijenwaBenita => 'Ijenwa Benita';

  @override
  String get whenIFlyTowardsYou => 'เมื่อเธอเหินเวหา (When I Fly Towards You)';

  @override
  String get mztvExclusiveChineseDrama => 'MZTV ซีรีส์จีนสุดพิเศษ';

  @override
  String get theStarryLove => 'ดุจดวงดาวโอบล้อมใจ (The Starry Love)';

  @override
  String get comedy => 'ตลก / คอมเมดี้';

  @override
  String get backFromTheBrink1 => 'Back from the Brink\':';

  @override
  String get dashingYouth1 => 'Dashing Youth\':';

  @override
  String get beReborn => 'เกิดใหม่ (Be Reborn)';

  @override
  String get beautyStrategy => 'แผนลวงโฉมงาม (Beauty Strategy)';

  @override
  String get myDivineEmissary => 'ทูตสวรรค์ของฉัน (My Divine Emissary)';

  @override
  String get theHope => 'ความหวัง (The Hope)';

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
  String get membersPremiere => 'สิทธิพิเศษสำหรับสมาชิก';

  @override
  String get moonlight => 'แสงจันทร์ (Moonlight)';

  @override
  String get myJourneyToYou => 'เหนือเมฆาชะตาลิขิต (My Journey to You)';

  @override
  String get mysteriousLotusCasebook =>
      'หอดอกบัวลาย (Mysterious Lotus Casebook)';

  @override
  String get rebornChineseDramaEngSub1 => 'Reborn Chinese drama ENG SUB\': \'';

  @override
  String get reborn => 'เกิดใหม่ (Reborn)';

  @override
  String get theBestDayOfMyLife1 => 'The Best Day of My Life\': \'';

  @override
  String get theDouble1 => 'The Double\':';

  @override
  String get theLongBallad => 'สตรีหาญ ฉางเกอ (The Long Ballad)';

  @override
  String get theStarryLove1 => 'The Starry Love\':';

  @override
  String get theUntamed => 'ปรมาจารย์ลัทธิมาร (The Untamed)';

  @override
  String get tillTheEndOfTheMoon1 => 'Till The End of The Moon\':';

  @override
  String get whenIFlyTowardsYou1 => 'When I Fly Towards You\':';

  @override
  String get wordOfHonor => 'นักรบพเนจรสุดขอบฟ้า (Word of Honor)';

  @override
  String get blossom => 'เบ่งบาน (Blossom)';

  @override
  String get gemini => 'Gemini';

  @override
  String get generationToGeneration =>
      'จากรุ่นสู่รุ่น (Generation to Generation)';

  @override
  String get brocadeOdyssey => 'มหากาพย์ผ้าไหม (Brocade Odyssey)';

  @override
  String get circleOfLove => 'วงเวียนรัก (Circle of Love)';

  @override
  String get dawnIsBreaking => 'รุ่งอรุณแรก (Dawn is Breaking)';

  @override
  String get firstRomance => 'รักแรกพบ (First Romance)';

  @override
  String get loveInTheClouds => 'รักในม่านเมฆ (Love in The Clouds)';

  @override
  String get secondChanceRomance =>
      'โอกาสที่สองของความรัก (Second Chance Romance)';

  @override
  String get mrBad => 'ตัวร้ายที่รัก (Mr. BAD)';

  @override
  String get pursuitOfJade => 'ไขว่คว้าหยกงาม (Pursuit of Jade)';

  @override
  String get fatedHearts => 'ดวงใจพรหมลิขิต (Fated Hearts)';

  @override
  String get roadHome => 'ทางกลับบ้าน (Road Home)';

  @override
  String get myDearGuardian => 'ผู้พิทักษ์ที่รัก (My Dear Guardian)';

  @override
  String get brightEyesInTheDark =>
      'ดวงตาประกายในความมืด (Bright Eyes in the Dark)';

  @override
  String get theIngeniousOne => 'บัณฑิตหน้าใสหัวใจปราชญ์ (The Ingenious One)';

  @override
  String get herPhoenixMajesty => 'หงส์เคียงบัลลังก์ (Her Phoenix Majesty)';

  @override
  String get dreamsNeverEnd => 'ความฝันไม่สิ้นสุด (Dreams Never End)';

  @override
  String get theUltimateVowUnknownToYou =>
      'คำสาบานนิรันดร์ที่เธอไม่เคยรู้ (The Ultimate Vow, Unknown to You)';

  @override
  String get the300LoyalGhosts => '300 วิญญาณผู้ภักดี (The 300 Loyal Ghosts)';

  @override
  String get homelandGuardian => 'ผู้พิทักษ์แผ่นดินเกิด (Homeland Guardian)';

  @override
  String get loveIsAlwaysOnline => 'รักออนไลน์เสมอ (Love is Always Online)';

  @override
  String get thePrincessDecree => 'โองการองค์หญิง (The Princess Decree)';

  @override
  String get aVowInTheDark => 'คำสาบานในความมืด (A Vow in the Dark)';

  @override
  String get aGirlLikeMe => 'ข้าก็เป็นสตรีเช่นนี้ (A Girl Like Me)';

  @override
  String get iAmNobody => 'อัศวินพันธุ์แปลก (I Am Nobody)';

  @override
  String get myMamaGo => 'คุณแม่สู้ๆ (My Mama Go!)';

  @override
  String get myWesternRegionPrincess =>
      'องค์หญิงแดนประจิมของฉัน (My Western Region Princess)';

  @override
  String get aFlowerOnTheContinent =>
      'บุปผาแห่งผืนแผ่นดิน (A Flower On The Continent)';

  @override
  String get thePrincess => 'องค์หญิง (The Princess)';

  @override
  String get sweetLoveVersion => 'เวอร์ชันรักหวานฉ่ำ';

  @override
  String get hilariousFamily2 => 'ครอบครัวหรรษา 2 (Hilarious Family 2)';

  @override
  String get guYuanMountainHasASchool =>
      'สำนักศึกษาแห่งเขาเฉิน (Gu Yuan Mountain Has a School)';

  @override
  String get foreverYoung => 'เยาว์วัยนิรันดร์ (Forever Young)';

  @override
  String get theHiddenHeirYeChen =>
      'ทายาทที่ซ่อนอยู่ เย่เฉิน (The Hidden Heir Ye Chen)';

  @override
  String get extraordinary => 'เหนือธรรมดา (Extraordinary)';

  @override
  String get sideStoryOfFoxVolant =>
      'จิ้งจอกอหังการ (Side Story of Fox Volant)';

  @override
  String get loveOfTheDivineTree =>
      'รักแห่งพฤกษาเทวะ (Love of the Divine Tree)';

  @override
  String get rebirth => 'การเกิดใหม่ (Rebirth)';

  @override
  String get moonlitReunion => 'พบกันใต้แสงจันทร์ (Moonlit Reunion)';

  @override
  String get videoCountsCannotBeNegative => 'จำนวนวิดีโอต้องไม่เป็นค่าติดลบ';

  @override
  String get publicDomainClassic => 'วรรณกรรมคลาสสิกสาธารณสมบัติ';

  @override
  String get idioms => 'สำนวนจีน';

  @override
  String get news => 'ข่าวสาร';

  @override
  String get fairyTales => 'นิทานและเทพนิยาย';

  @override
  String get hereIsAFascinatingCulturalExplanati =>
      'นี่คือคำอธิบายทางวัฒนธรรมที่น่าสนใจ';

  @override
  String get videoFetchTimedOut => 'หมดเวลาการดึงข้อมูลวิดีโอ';

  @override
  String get aboutChannel => 'เกี่ยวกับช่อง';

  @override
  String get noVideosFound => 'ไม่พบวิดีโอ';

  @override
  String get failedToLoadVideos => 'โหลดวิดีโอไม่สำเร็จ';

  @override
  String get highqualityCuratedMandarinContentWi =>
      'เนื้อหาภาษาจีนกลางคุณภาพสูงที่คัดสรรมาเป็นอย่างดีพร้อมคำศัพท์ธรรมชาติ';

  @override
  String get authenticSpokenChineseAcrossRealwor =>
      'ภาษาจีนพูดแท้ๆ ในหัวข้อและบริบทโลกแห่งความจริง';

  @override
  String get engagingVideoMaterialWithInteractiv =>
      'สื่อวิดีโอที่น่าติดตามพร้อมคำบรรยายอินเทอร์แอ็กทีฟที่ซิงค์ตรงกัน';

  @override
  String get watchVideo => 'ชมวิดีโอ';

  @override
  String get culturalInsight => 'เกร็ดความรู้ทางวัฒนธรรม';

  @override
  String get aiIsAnalyzingCulturalContext =>
      'AI กำลังวิเคราะห์บริบททางวัฒนธรรม...';

  @override
  String get diveIntoFullContent => 'เจาะลึกเนื้อหาฉบับเต็ม';

  @override
  String get savedArticles => 'บทความที่บันทึกไว้';

  @override
  String get liveOverlay => 'โอเวอร์เลย์สด (LIVE OVERLAY)';

  @override
  String get webExplorer => 'ตัวสำรวจเว็บ (WEB EXPLORER)';

  @override
  String get browseAnyChineseWebsiteWithRealtime =>
      'ท่องเว็บไซต์ภาษาจีนด้วยพจนานุกรมแบบแตะทันใจ เสียงพินอิน และการแปลแบบเรียลไทม์';

  @override
  String get startExploring => 'เริ่มสำรวจ';

  @override
  String get chineseTvSeriesWithInteractiveSubti =>
      'ซีรีส์จีนพร้อมคำบรรยายแบบโต้ตอบ';

  @override
  String get failedToLoadContent => 'โหลดเนื้อหาไม่สำเร็จ';

  @override
  String get searchingYoutube => 'กำลังค้นหาบน YouTube...';

  @override
  String get noVideosFoundTryADifferentSearchTer =>
      'ไม่พบวิดีโอ ลองค้นหาด้วยคำอื่น';

  @override
  String get searching => 'กำลังค้นหา';

  @override
  String get noShowsFound => 'ไม่พบรายการ';

  @override
  String get bookmarked => 'คั่นหน้าแล้ว';

  @override
  String get trailer1 => 'ตัวอย่าง';

  @override
  String get highlight1 => 'ไฮไลต์';

  @override
  String get noCaptionsAvailable => 'ไม่มีคำบรรยาย';

  @override
  String get fetchingSubtitles => 'กำลังดึงคำบรรยาย...';

  @override
  String get generatingAiBriefing => 'กำลังสร้างบทสรุป AI...';

  @override
  String get noClosedCaptionsCcFoundForThisVideo =>
      'ไม่พบคำบรรยาย (CC) สำหรับวิดีโอนี้';

  @override
  String get videosWithHardcodedOrBurnedinSubtit =>
      'วิดีโอที่มีซับไตเติลฝังอยู่ในภาพจะไม่มีไฟล์ข้อความดิจิทัลบน YouTube';

  @override
  String get translatingSubtitles => 'กำลังแปลคำบรรยาย...';

  @override
  String get processingYourPronunciation => 'กำลังประมวลผลการออกเสียงของคุณ...';

  @override
  String get couldntIdentifyLine => 'ไม่สามารถระบุประโยคได้';

  @override
  String get listeningSpeakNow => 'กำลังฟัง... พูดได้เลย';

  @override
  String get thisVideoDoesNotHaveADigitalClosedC =>
      'วิดีโอนี้ไม่มีแทร็กคำบรรยายดิจิทัล (CC) บน YouTube';

  @override
  String get perfect1 => 'สมบูรณ์แบบ';

  @override
  String get thisVideoHasBeenRemovedOrIsNoLonger =>
      'วิดีโอนี้ถูกลบออกแล้วหรือไม่พร้อมใช้งานอีกต่อไป';

  @override
  String get thisVideoCannotBePlayedInTheAppYouC =>
      'วิดีโอนี้ไม่สามารถเล่นในแอปได้ คุณยังสามารถรับชมบน YouTube ได้';

  @override
  String get yourDeviceCannotPlayThisVideoPlease =>
      'อุปกรณ์ของคุณไม่สามารถเล่นวิดีโอนี้ได้ กรุณาลองวิดีโออื่น';

  @override
  String get invalidVideoReferencePleaseTryAgain =>
      'การอ้างอิงวิดีโอไม่ถูกต้อง กรุณาลองใหม่อีกครั้ง';

  @override
  String get unableToLoadThisVideoPleaseTryAnoth =>
      'ไม่สามารถโหลดวิดีโอนี้ได้ กรุณาลองอีกครั้งด้วยวิดีโออื่น';

  @override
  String get startReading => 'เริ่มอ่าน';

  @override
  String get analyzingCulturalContext => 'กำลังวิเคราะห์บริบททางวัฒนธรรม...';

  @override
  String get failedToLoadCulturalInsight => 'โหลดเกร็ดวัฒนธรรมไม่สำเร็จ';

  @override
  String get historicalContext => 'บริบททางประวัติศาสตร์';

  @override
  String get culturalSignificance => 'ความสำคัญทางวัฒนธรรม';

  @override
  String get authorBackground => 'ประวัติผู้ประพันธ์';

  @override
  String get k80CompleteClassicNovelsWorldEpics =>
      'นวนิยายคลาสสิกและมหากาพย์ระดับโลกฉบับสมบูรณ์กว่า 80 เรื่อง';

  @override
  String get storyOfTheDay => 'นิทานประจำวัน';

  @override
  String get tangDynasty => 'ราชวงศ์ถัง';

  @override
  String get poetryClassicalVerse => 'Poetry\', \'Classical\', \'Verse';

  @override
  String get allHsk => 'HSK ทั้งหมด';

  @override
  String get allStories => 'All Stories\' :';

  @override
  String get keyWords => 'คำสำคัญ';

  @override
  String get openOriginalWebsite => 'เปิดเว็บไซต์ต้นฉบับ';

  @override
  String get aiReadingTools => 'เครื่องมือช่วยอ่านด้วย AI';

  @override
  String get enhanceYourReadingWithAipoweredTool =>
      'ยกระดับการอ่านของคุณด้วยเครื่องมือที่ขับเคลื่อนด้วย AI';

  @override
  String get chooseTheTargetDifficultyForSimplif =>
      'เลือกระดับความยากเป้าหมายสำหรับการปรับให้อ่านง่าย';

  @override
  String get chooseDifficultyForSimplification =>
      'เลือกระดับความยากสำหรับการปรับให้อ่านง่าย';

  @override
  String get extractAllUnknownWordsToANewFlashca =>
      'สกัดคำศัพท์ที่ไม่คุ้นเคยทั้งหมดไปยังสำรับแฟลชการ์ดใหม่';

  @override
  String get length => 'ความยาว';

  @override
  String get m1554846a550010707 => 'M15.54 8.46a5 5 0 0 1 0 7.07';

  @override
  String get m1907493a101000101414 => 'M19.07 4.93a10 10 0 0 1 0 14.14';

  @override
  String get webExtraction => 'การสกัดข้อความจากเว็บ';

  @override
  String get aiTools => 'เครื่องมือ AI';

  @override
  String get stop => 'หยุด';

  @override
  String get keepPracticing1 => 'ฝึกฝนต่อไป';

  @override
  String get aiPrepRoom => 'ห้องเตรียมตัว AI';

  @override
  String get lessonSummary => 'สรุปบทเรียน';

  @override
  String get unlockSinosparkPremium => 'ปลดล็อก SinoSpark พรีเมียม';

  @override
  String get monthYear => 'Month\' : \'Year';

  @override
  String get enableNotifications => 'เปิดการแจ้งเตือน';

  @override
  String get notificationsConfigured => 'ตั้งค่าการแจ้งเตือนเรียบร้อยแล้ว';

  @override
  String get neverMissAStroke2 => 'อย่าพลาดแม้แต่เส้นเดียว';

  @override
  String get yourDailyDropAndStreakAlertsArePrim =>
      'การแจ้งเตือนบทเรียนประจำวันและความต่อเนื่องพร้อมแล้ว';

  @override
  String get stayConsistentWithDailyRitualDropsA =>
      'รักษาความต่อเนื่องด้วยบทเรียนประจำวันและการแจ้งเตือนช่วงทดลองใช้ที่ตรงเวลา';

  @override
  String get aNewWordAndStoryWaitingForYourDaily =>
      'คำศัพท์และนิทานใหม่พร้อมแล้วสำหรับกิจวัตรประจำวันของคุณ';

  @override
  String get gentlePromptsBeforeCharactersFadeFr =>
      'เตือนความจำอย่างนุ่มนวลก่อนที่ตัวอักษรจะเลือนหายไปจากความจำ';

  @override
  String get receiveAReminder2DaysBeforeYourFree =>
      'รับการแจ้งเตือน 2 วันก่อนที่ช่วงทดลองใช้ฟรีของคุณจะสิ้นสุดลง';

  @override
  String get yourPathTonchineseFluency =>
      'เส้นทางสู่ความคล่องแคล่ว\nในภาษาจีนของคุณ';

  @override
  String get answer3QuickQuestionsSoOurAiCanCraf =>
      'ตอบคำถามสั้นๆ 3 ข้อ เพื่อให้ AI ออกแบบ\nหลักสูตรที่เหมาะกับชีวิตของคุณ';

  @override
  String get whatIsYourLevelnwithChinese =>
      'ระดับภาษาจีนของคุณ\nอยู่ในระดับใด?';

  @override
  String get chooseThePathThatFitsYourDepth =>
      'เลือกเส้นทางที่เหมาะกับระดับความลึกซึ้งของคุณ';

  @override
  String get whatDrivesYourStudy => 'อะไรคือแรงผลักดันในการเรียนของคุณ?';

  @override
  String get purposeFuelsTheBrush => 'เป้าหมายคือพลังขับเคลื่อนพู่กัน';

  @override
  String get setYourDailyRitual => 'ตั้งเวลากิจวัตรประจำวันของคุณ';

  @override
  String get youCanAdjustYourRitualAnyTime =>
      'คุณสามารถปรับเปลี่ยนเวลากิจวัตรได้ตลอดเวลา';

  @override
  String get letsBegin => 'มาเริ่มกันเลย';

  @override
  String get brandNew => 'เริ่มต้นจากศูนย์';

  @override
  String get iveNeverStudiedChineseBefore => 'ฉันไม่เคยเรียนภาษาจีนมาก่อน';

  @override
  String get iKnowBasicCharactersAndPhrases =>
      'ฉันรู้ตัวอักษรและวลีพื้นฐานบ้าง';

  @override
  String get iCanHoldConversationsAndRead => 'ฉันสามารถสนทนาและอ่านได้';

  @override
  String get iWantToRefineAndPerfectMySkills =>
      'ฉันต้องการขัดเกลาและพัฒนาทักษะให้สมบูรณ์แบบ';

  @override
  String get confirmSelection => 'ยืนยันการเลือก';

  @override
  String get purposeFuelsTheBrushsMotion =>
      'เป้าหมายขับเคลื่อนทุกการตวัดพู่กัน';

  @override
  String get buildMyPath => 'สร้างเส้นทางของฉัน';

  @override
  String get hskCertification => 'การสอบวัดระดับ HSK';

  @override
  String get culturalAppreciation => 'ความซาบซึ้งในวัฒนธรรม';

  @override
  String get yourPlanIsReady => 'แผนการเรียนของคุณพร้อมแล้ว';

  @override
  String get craftingYourCurriculum => 'กำลังออกแบบหลักสูตรของคุณ';

  @override
  String get personalizedPathInitialized => 'เริ่มต้นเส้นทางเฉพาะบุคคลแล้ว';

  @override
  String get calibratingAiNeuralMasters => 'กำลังปรับเทียบระบบประสาท AI...';

  @override
  String get calibrationComplete => 'ปรับเทียบเสร็จสมบูรณ์';

  @override
  String get synthesizingModules => 'กำลังรวบรวมโมดูลบทเรียน...';

  @override
  String get oneAndWater => 'One\' และ \'Water';

  @override
  String get theHorizontalStroke => 'เส้นขวาง (เหิง)';

  @override
  String get theRadical => 'หมวดนำอักษร';

  @override
  String get water => 'น้ำ';

  @override
  String get river => 'แม่น้ำ';

  @override
  String get day5Reminder => 'การแจ้งเตือนวันที่ 5';

  @override
  String get wePromisedToAlertYou2DaysBeforeYour =>
      'เราสัญญาว่าจะแจ้งเตือนคุณ 2 วันก่อนช่วงทดลองใช้สิ้นสุด เพื่อให้คุณ';

  @override
  String get continueWithoutReminder => 'ดำเนินการต่อโดยไม่แจ้งเตือน';

  @override
  String get masterChineseWithnsinospark => 'เก่งภาษาจีนไปกับ\nSinoSpark';

  @override
  String get start7dayFreeTrial => 'เริ่มทดลองใช้ฟรี 7 วัน';

  @override
  String get precisionStrokes => 'ขีดเขียนแม่นยำ';

  @override
  String get aiPronunciation => 'การออกเสียงด้วย AI';

  @override
  String get today => 'วันนี้';

  @override
  String get fullAccess => 'เข้าถึงได้ทุกฟีเจอร์';

  @override
  String get day5 => 'วันที่ 5';

  @override
  String get reminder => 'แจ้งเตือน';

  @override
  String get day7 => 'วันที่ 7';

  @override
  String get trialBegins => 'เริ่มการทดลองใช้';

  @override
  String get revenuecatIsMissingACurrentOffering =>
      'RevenueCat ไม่มี Current Offering หรือ Packages กรุณากำหนดค่าในแดชบอร์ดของคุณ';

  @override
  String get cameraPermissionRequiredForLiveScan =>
      'จำเป็นต้องได้รับสิทธิ์การเข้าถึงกล้องสำหรับการสแกนสด';

  @override
  String get cameraAccessRequired => 'จำเป็นต้องเข้าถึงกล้อง';

  @override
  String get pleaseEnableCameraAccessInYourDevic =>
      'กรุณาเปิดใช้งานการเข้าถึงกล้องในการตั้งค่าอุปกรณ์เพื่อใช้งานฟีเจอร์นี้';

  @override
  String get alignChineseTextWithinFrame => 'จัดวางข้อความภาษาจีนให้อยู่ในกรอบ';

  @override
  String get inLibrary => 'อยู่ในคลังแล้ว';

  @override
  String get novice => 'ผู้เริ่มต้น';

  @override
  String get apprentice => 'ผู้ฝึกฝน';

  @override
  String get artisan => 'ช่างฝีมือ';

  @override
  String get grandmaster => 'ปรมาจารย์';

  @override
  String get poem => 'บทกวี';

  @override
  String get theNarrative => 'การเล่าเรื่อง';

  @override
  String get classicMasterpiece => 'ผลงานชิ้นเอกคลาสสิก';

  @override
  String get classicAuthor => 'ผู้ประพันธ์คลาสสิก';

  @override
  String get classical => 'คลาสสิกโบราณ';

  @override
  String get classicLiterature => 'Classic\', \'Literature';

  @override
  String inThisChapterOf(Object title) {
    return 'ในบทนี้ของ';
  }

  @override
  String get asTheNarrativeUnfoldsItIlluminatesT =>
      'เมื่อเรื่องราวดำเนินไป ยิ่งสะท้อนถึงภูมิปัญญาพื้นฐานของชีวิตและแรงบันดาลใจอันไม่รู้จบ';

  @override
  String get general => 'ทั่วไป';

  @override
  String get mythology => 'เทพปกรณัม';

  @override
  String get dailyLife => 'ชีวิตประจำวัน';

  @override
  String get tangPoetry => 'กวีนิพนธ์ราชวงศ์ถัง';

  @override
  String get classicalLiterature => 'วรรณกรรมคลาสสิก';

  @override
  String get justNow => 'เมื่อสักครู่';

  @override
  String get theTerracottaArmyOfQinShiHuang =>
      'กองทัพทหารดินเผาของจิ๋นซีฮ่องเต้';

  @override
  String get lifeInsideTheForbiddenCity => 'ชีวิตภายในพระราชวังต้องห้าม';

  @override
  String get buyingATicketAndTakingTheHighSpeedT =>
      'การซื้อตั๋วและโดยสารรถไฟความเร็วสูงในประเทศจีน';

  @override
  String get goingToTheHospitalForAColdAndSeeing =>
      'การไปโรงพยาบาลเพราะเป็นหวัดและพบแพทย์';

  @override
  String get goingToALocalRestaurantToOrderJiaoz =>
      'การไปร้านอาหารท้องถิ่นเพื่อสั่งเกี๊ยว (เจี่ยวจื่อ)';

  @override
  String get theTraditionalGongfuTeaCeremony => 'พิธีชงชากังฟูดั้งเดิม';

  @override
  String get theArtOfWritingChineseCharactersWit =>
      'ศิลปะการเขียนตัวอักษรจีนด้วยพู่กัน';

  @override
  String get theLifeAndConservationOfGiantPandas =>
      'ชีวิตและการอนุรักษ์แพนด้ายักษ์';

  @override
  String get storyNotFoundInDatabase => 'ไม่พบเรื่องราวในฐานข้อมูล';

  @override
  String get storyTextIsEmpty => 'ข้อความเนื้อเรื่องว่างเปล่า';

  @override
  String get myCustomStories => 'นิทานกำหนดเองของฉัน';

  @override
  String get userProvidedText => 'ข้อความที่ผู้ใช้ระบุ';

  @override
  String get local => 'ในเครื่อง';

  @override
  String get voiceEngineAllowance => 'ระบบเสียงและโควตาการใช้งาน';

  @override
  String get studioHdVsUnlimitedStandardVoice =>
      'Studio HD เทียบกับ เสียงมาตรฐานแบบไม่จำกัด';

  @override
  String get standardVoiceIs100UnlimitedFree =>
      'เสียงมาตรฐานใช้งานได้ฟรี 100% ไม่จำกัด';

  @override
  String get read => 'อ่าน';

  @override
  String get koreKoreFemaleWarm => 'Kore\', \'Kore\', \'หญิง, อบอุ่น';

  @override
  String get aoedeAoedeFemaleCheerful => 'Aoede\', \'Aoede\', \'หญิง, ร่าเริง';

  @override
  String get fenrirFenrirMaleUpbeat => 'Fenrir\', \'Fenrir\', \'ชาย, สดใส';

  @override
  String get charonCharonMaleNewsstyle =>
      'Charon\', \'Charon\', \'ชาย, สไตล์ผู้ประกาศข่าว';

  @override
  String get puckPuckMaleSporty => 'Puck\', \'Puck\', \'ชาย, กระฉับกระเฉง';

  @override
  String get localOndevice => 'Local\', \'On-device';

  @override
  String get localOndeviceTts => 'TTS ในอุปกรณ์ของเครื่อง';

  @override
  String get off => 'ปิด';

  @override
  String get endOfCurrentChapter => 'จบบทปัจจุบัน';

  @override
  String get standardVoice => 'เสียงมาตรฐาน';

  @override
  String get noNovelsFoundMatchingYourFilter =>
      'ไม่พบนวนิยายที่ตรงกับตัวกรองของคุณ';

  @override
  String get noMicroreadsFoundMatchingYourFilter =>
      'ไม่พบบทอ่านสั้นที่ตรงกับตัวกรองของคุณ';

  @override
  String get noPoemsFoundMatchingYourFilter =>
      'ไม่พบบทกวีที่ตรงกับตัวกรองของคุณ';

  @override
  String get audiobook => 'หนังสือเสียง';

  @override
  String get audio => 'เสียง';

  @override
  String get continueReading => 'อ่านต่อ';

  @override
  String get search96FullNovelsAuthorsEpics =>
      'ค้นหานวนิยายฉบับเต็ม 96 เรื่อง ผู้ประพันธ์ มหากาพย์...';

  @override
  String get searchClassicalPoemsAuthorsVerses =>
      'ค้นหาบทกวีคลาสสิก ผู้ประพันธ์ วรรคทอง...';

  @override
  String get allLevelsVal => 'ทุกระดับ';

  @override
  String get hsk1BeginnerVal => 'HSK 1 (ระดับต้น)';

  @override
  String get hsk2ElementaryVal => 'HSK 2 (ระดับประถม)';

  @override
  String get hsk3IntermediateVal => 'HSK 3 (ระดับกลาง)';

  @override
  String get hsk4UpperIntVal => 'HSK 4 (ระดับกลางค่อนสูง)';

  @override
  String get listenToAudiobook => 'ฟังหนังสือเสียง';

  @override
  String get synopsis => 'เรื่องย่อ';

  @override
  String get peoplesArtist => 'ศิลปินแห่งประชาชน\'.';

  @override
  String get kafkaesqueForBureaucraticAbsurdityA =>
      'Kafkaesque\' สำหรับความไร้สาระของระบบราชการ ความแปลกแยก และความสิ้นหวังในการมีอยู่';

  @override
  String get bigBrotherAndNewspeak => 'Big Brother\', และ \'Newspeak\'.';

  @override
  String get audiobookIncluded => 'รวมหนังสือเสียงแล้ว';

  @override
  String get readPoem => 'อ่านบทกวี';

  @override
  String get studioVoiceAllowance => 'โควตาเสียง Studio';

  @override
  String get weeklyHighdefinitionAiRecitation =>
      'การอ่านออกเสียงด้วย AI คุณภาพสูงระดับ HD ประจำสัปดาห์';

  @override
  String get resetsEveryMondayAt0000 => 'รีเซ็ตทุกวันจันทร์ เวลา 00:00 น.';

  @override
  String get whenYourWeekly4hourStudioAllowanceI =>
      'เมื่อใช้โควตาเสียง Studio ครบ 4 ชั่วโมงต่อสัปดาห์แล้ว แอปจะเปลี่ยนไปใช้เสียงในเครื่องโดยอัตโนมัติ เพื่อให้คุณฟังต่อได้ฟรีไม่จำกัดโดยไม่สะดุด';

  @override
  String get localDeviceVoice => 'Local device voice\' :';

  @override
  String get classicalVerse => 'กวีนิพนธ์คลาสสิก';

  @override
  String get ondeviceVoice4hWeeklyUsed =>
      'เสียงในเครื่อง (ใช้โควตา 4 ชม./สัปดาห์แล้ว)';

  @override
  String get generateACustomAiStoryBasedOnYourIn =>
      'สร้างนิทาน AI กำหนดเองตามความสนใจของคุณ';

  @override
  String get insteadOfAFixedHskLevelTheFlowState =>
      'แทนที่จะใช้ระดับ HSK คงที่ Flow State Engine จะวิเคราะห์คลังแฟลชการ์ดของคุณ\\n\\n';

  @override
  String get we => 'เรา';

  @override
  String get howCanWeHelpYou => 'เราสามารถช่วยเหลือคุณได้อย่างไร?';

  @override
  String get everythingYouNeedToKnowAboutHanziMa =>
      'ทุกสิ่งที่คุณจำเป็นต้องรู้เกี่ยวกับ Hanzi Master ฟีเจอร์ต่างๆ และความเป็นส่วนตัวของคุณ';

  @override
  String get whoAreTheVoicesSpeakingInTheApp =>
      'ใครคือเจ้าของเสียงที่พูดในแอป?';

  @override
  String get howDoesTheWebExplorerWork => 'ตัวสำรวจเว็บทำงานอย่างไร?';

  @override
  String get whatIsZenMode => 'โหมด Zen คืออะไร?';

  @override
  String get howDoesTheFlashcardSpacedrepetition =>
      'ระบบการทบทวนแบบเว้นระยะของแฟลชการ์ดทำงานอย่างไร?';

  @override
  String get traceComplete => 'ลากเส้นเสร็จสมบูรณ์!';

  @override
  String get traceCharacter => 'ลากเส้นตามตัวอักษร';

  @override
  String get analyzingWordRelationships => 'กำลังวิเคราะห์ความสัมพันธ์ของคำ...';

  @override
  String get identifyingUsageContexts => 'กำลังระบุบริบทการใช้งาน...';

  @override
  String get comparingFormalityLevels =>
      'กำลังเปรียบเทียบระดับความเป็นทางการ...';

  @override
  String get findingCommonCollocations => 'กำลังค้นหาคำที่มักใช้ร่วมกัน...';

  @override
  String get generatingComparison => 'กำลังสร้างการเปรียบเทียบ...';

  @override
  String get generationIsTakingLongerThanExpecte =>
      'การประมวลผลใช้เวลานานกว่าปกติ AI อาจกำลังทำงานหนัก';

  @override
  String get generationInterruptedShowingPartial =>
      'การประมวลผลถูกขัดจังหวะ กำลังแสดงผลลัพธ์บางส่วน';

  @override
  String get sorrySomethingWentWrong => 'ขออภัย เกิดข้อผิดพลาดบางอย่าง';

  @override
  String get usage => 'Usage:\', \'';

  @override
  String get alsoSeenIn => 'พบได้ใน';

  @override
  String get quickLook => 'ดูอย่างรวดเร็ว';

  @override
  String get notFound => 'ไม่พบข้อมูล';

  @override
  String get errorLoadingFromAi => 'เกิดข้อผิดพลาดในการโหลดข้อมูลจาก AI';

  @override
  String get analyzingImage => 'กำลังวิเคราะห์รูปภาพ...';

  @override
  String get extractingChineseText => 'กำลังสกัดข้อความภาษาจีน...';

  @override
  String get lookingUpVocabulary => 'กำลังค้นหาคำศัพท์...';

  @override
  String get dreamOfTheRedChamber => 'ความฝันในหอแดง';

  @override
  String get journeyToTheWest => 'ไซอิ๋ว';

  @override
  String get romanceOfTheThreeKingdoms => 'สามก๊ก';

  @override
  String get mingDynasty => 'ราชวงศ์หมิง';

  @override
  String get wuChengEn => 'อู๋เฉิงเอิน';

  @override
  String get hundredChapters => '100 บท';

  @override
  String get volume1 => 'เล่มที่ 1';

  @override
  String bookmarksCount(Object count) {
    return 'ที่คั่นหน้า ($count)';
  }

  @override
  String get noBookmarksYet =>
      'ยังไม่มีที่คั่นหน้า แตะไอคอนที่คั่นหน้าเพื่อบันทึกข้อความ';

  @override
  String get sinosparkIsNotResponding => 'SinoSpark ไม่ตอบสนอง';

  @override
  String get closeApp => 'ปิดแอป';

  @override
  String get wait => 'รอ';

  @override
  String studioHdAllowance(Object hours) {
    return 'Studio HD: $hours ชม.';
  }

  @override
  String bookPercentRead(Object percent) {
    return 'อ่านไปแล้ว $percent%';
  }

  @override
  String chAbbreviation(Object number) {
    return 'บทที่ $number';
  }

  @override
  String booksAndAudiobooks(Object count) {
    return 'หนังสือและหนังสือเสียง $count รายการ';
  }

  @override
  String sentenceXOfY(Object current, Object total) {
    return 'ประโยคที่ $current จาก $total';
  }

  @override
  String chapterXOfY(Object current, Object total) {
    return 'บทที่ $current จาก $total';
  }

  @override
  String get allLevels => 'ทุกระดับ';

  @override
  String get searchGradedMicroStories =>
      'ค้นหานิทานขนาดสั้นและนิทานอีสปตามระดับ...';

  @override
  String gradedStoriesAndMicroReads(Object count) {
    return 'นิทานตามระดับและบทอ่านสั้นรายวัน $count เรื่อง';
  }

  @override
  String get searchClassicalPoems => 'ค้นหาบทกวีคลาสสิก ผู้ประพันธ์ วรรคทอง...';

  @override
  String classicalPoemsAndVerse(Object count) {
    return 'บทกวีและกวีนิพนธ์คลาสสิก $count บท';
  }

  @override
  String get browseAnyChineseWebsite =>
      'ท่องเว็บไซต์ภาษาจีนด้วยพจนานุกรมแบบแตะทันใจ เสียงพินอิน และการแปลแบบเรียลไทม์';

  @override
  String get completed => 'เสร็จสมบูรณ์';

  @override
  String get aiIsReading => 'AI กำลังอ่าน...';

  @override
  String get bbcVerify => 'บีบีซี ตรวจสอบข้อเท็จจริง (BBC VERIFY)';

  @override
  String get hsk5AdvancedVal => 'HSK 5 (ระดับสูง)';

  @override
  String get hsk1Beginner => 'HSK 1 (ระดับต้น)';

  @override
  String get hsk4UpperInt => 'HSK 4 (ระดับกลางค่อนสูง)';

  @override
  String get extractAllUnknownWords =>
      'สกัดคำศัพท์ที่ไม่คุ้นเคยทั้งหมดไปยังสำรับแฟลชการ์ดใหม่';

  @override
  String get designCustomAiRoleplay =>
      'ออกแบบการสนทนาและการจำลองบทบาท AI กำหนดเอง';

  @override
  String get practiceFlashcardVocabulary =>
      'ฝึกฝนคำศัพท์จากแฟลชการ์ดในบทสนทนาจริง';

  @override
  String get surpriseMe => 'สุ่มให้ฉัน';

  @override
  String get rollCharacter => 'สุ่มตัวละคร';

  @override
  String get historicalCostume => 'ย้อนยุค / เครื่องแต่งกายโบราณ';

  @override
  String get modernYouth => 'ยุคใหม่และวัยรุ่น';

  @override
  String get fantasyMythology => 'แฟนตาซีและเทพนิยาย';

  @override
  String get familyDrama => 'ครอบครัวและดราม่า';

  @override
  String get fullVersion => 'ฉบับเต็ม';

  @override
  String episodesCount(Object count) {
    return '$count ตอน';
  }

  @override
  String episodeLabel(Object number) {
    return 'ตอนที่ $number';
  }

  @override
  String get translating => '[ กำลังแปล... ]';

  @override
  String get engSub => '[ซับอังกฤษ]';

  @override
  String get standardVocabulary => 'คำศัพท์มาตรฐาน';

  @override
  String get characters => 'ตัวอักษร';

  @override
  String get todayDashboard => 'Today';

  @override
  String get studyToday => 'Study today\'s cards';

  @override
  String get studyAhead => 'Study ahead';

  @override
  String get studyAheadDescription =>
      'Practice the nearest scheduled reviews without using today\'s quota. No new cards are introduced.';

  @override
  String get studyAheadComplete => 'Study-ahead practice complete';

  @override
  String get dueNow => 'Due now';

  @override
  String get scheduled => 'Scheduled';

  @override
  String get sevenDayForecast => '7-day review forecast';

  @override
  String get reviews => 'Reviews';

  @override
  String get newCardsLabel => 'New cards';

  @override
  String get attempts => 'Attempts';

  @override
  String get duration => 'Time';

  @override
  String get answerBreakdown => 'Answer breakdown';

  @override
  String get reviewCards => 'Review cards';

  @override
  String get retries => 'Retries';

  @override
  String get needsPractice => 'Needs practice';

  @override
  String get uniqueCardsStudied => 'Cards';

  @override
  String get dartConvert => 'dart:convert';

  @override
  String get env => '.env';

  @override
  String get dartUi => 'dart:ui';

  @override
  String get dartMath => 'dart:math';

  @override
  String get drawInTheOtherDirection => 'Draw in the other direction ➔';

  @override
  String get fastClean => 'Fast & Clean!';

  @override
  String get good2 => 'Good!';

  @override
  String get followTheFlow => 'Follow the flow.';

  @override
  String get masterful => 'Masterful!';

  @override
  String get missingTheHookEnd => 'Missing the hook/end.';

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
  String get ink => 'ink,';

  @override
  String get stroke => 'stroke,';

  @override
  String get breath => 'breath.';

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
  String get theExactSentenceProvided => 'the exact sentence provided';

  @override
  String get pinyinWithToneMarks2 => 'pinyin with tone marks';

  @override
  String get wXHuNH => 'Wǒ xǐhuān hē píngguǒzhī.';

  @override
  String get extractAllChineseCharactersFrom =>
      'Extract all Chinese characters from this image. Return ONLY the extracted text — no commentary, no formatting, no translations. Preserve line breaks. If there are no Chinese characters, return an empty string.';

  @override
  String get householdObject => 'household object';

  @override
  String get genericLabelFromTheList => 'generic label from the list';

  @override
  String get gNgS => 'gōng sī';

  @override
  String get measureWord => 'measure word';

  @override
  String get zenInk => 'Zen & Ink';

  @override
  String get cRITICALPutTheEnglishTranslation =>
      'CRITICAL: Put the English translation in the \"english\" JSON key!';

  @override
  String get definitionInEnglish => 'definition in English';

  @override
  String get simplifiedLine0 => 'simplified line 0';

  @override
  String get simplifiedLine1 => 'simplified line 1';

  @override
  String get iMPORTANTRULEDoNotAddress =>
      'IMPORTANT RULE: Do not address the user by any name. Never use placeholder names like \"John\". Speak directly to them without using a name.';

  @override
  String get rULESAnswerIn23 =>
      'RULES: Answer in 2–3 sentences max. Prefer bullet points for lists.';

  @override
  String get neverWriteIntroductionsSignOffs =>
      'Never write introductions, sign-offs, or filler phrases like \"Great question!\" or \"Certainly!\".';

  @override
  String get useBoldForChineseCharacters =>
      'Use **bold** for Chinese characters and key terms.';

  @override
  String get rULESAnswerIn232 => 'RULES: Answer in 2–3 sentences max.';

  @override
  String get accept => 'Accept';

  @override
  String get pronunciationAssessment => 'Pronunciation-Assessment';

  @override
  String get nBest => 'NBest';

  @override
  String get none => 'None';

  @override
  String get theCorrectedChineseText => 'the corrected Chinese text';

  @override
  String get thePinyinForTheCorrected => 'the pinyin for the corrected text';

  @override
  String get theEnglishMeaningOfThe =>
      'the english meaning of the corrected text';

  @override
  String get pNyNWithTone => 'pīnyīn with tone marks';

  @override
  String get englishTranslation2 => 'english translation';

  @override
  String get zhNggu => 'Zhōngguó';

  @override
  String get youAreAChineseClassical =>
      'You are a Chinese classical literature expert providing detailed accessible summaries of classical Chinese poetry.';

  @override
  String get youAreAChineseCulture =>
      'You are a Chinese culture and literature expert. Provide highly engaging, beautifully written cultural insights.';

  @override
  String get english2 => 'English:';

  @override
  String get remindersWhenYouHavenT =>
      'Reminders when you haven\'t used the app for a few days';

  @override
  String get itSBeenAFew =>
      'It\'s been a few days! Take 5 minutes to learn a new Hanzi today.';

  @override
  String get abbreviationFor => 'abbreviation for';

  @override
  String get cL => 'CL:';

  @override
  String get measureWord2 => 'Measure word:';

  @override
  String get lu => 'lu:';

  @override
  String get luE => 'lu:e';

  @override
  String get nu => 'nu:';

  @override
  String get nuE => 'nu:e';

  @override
  String get noUser => 'no-user';

  @override
  String get passwordRequired => 'password-required';

  @override
  String get unsupportedProvider => 'unsupported-provider';

  @override
  String get appleRevocationUnavailable => 'apple-revocation-unavailable';

  @override
  String get appleCredentialMissing => 'apple-credential-missing';

  @override
  String get authenticationDidNotReturnA =>
      'Authentication did not return a user.';

  @override
  String get viewSubscriptionPlans => 'View subscription plans';

  @override
  String get wrongPassword => 'wrong-password';

  @override
  String get invalidCredential => 'invalid-credential';

  @override
  String get networkRequestFailed => 'network-request-failed';

  @override
  String get requiresRecentLogin => 'requires-recent-login';

  @override
  String get userMismatch => 'user-mismatch';

  @override
  String get deleteAccountPassword => 'delete-account-password';

  @override
  String get deleteAccountError => 'delete-account-error';

  @override
  String get deleteAccountSubmit => 'delete-account-submit';

  @override
  String get theSimplestShapesTheBeginning =>
      'The simplest shapes. The beginning of all things.';

  @override
  String get sunMoonWaterAndFire =>
      'Sun, Moon, Water, and Fire. The natural world.';

  @override
  String get theBodyTheHeartAnd => 'The body, the heart, and the family.';

  @override
  String get fieldsRoofsAndToolsThe =>
      'Fields, roofs, and tools. The foundations of society.';

  @override
  String get movementSpeechAndSustenance => 'Movement, speech, and sustenance.';

  @override
  String get commerceClothingAndComplexArtifacts =>
      'Commerce, clothing, and complex artifacts.';

  @override
  String get fastTrackSimpleCharacterMastered =>
      '🚀 Fast Track! Simple character mastered.';

  @override
  String get excellentPrecisionGhostTraceSkipped =>
      '⚡ Excellent precision! Ghost trace skipped.';

  @override
  String get sample => 'Sample:';

  @override
  String get itsThat => 'Its/That';

  @override
  String get iMe => 'I/Me';

  @override
  String get stillTough => 'Still/Tough';

  @override
  String get partDecide => 'Part/Decide';

  @override
  String get selectTheCharacterFor => 'Select the character for:';

  @override
  String get selectThePinyinFor => 'Select the Pinyin for:';

  @override
  String get whereAreYouGoingThe =>
      'Where are you going? The airport? It is quite a trip!';

  @override
  String get youAreAuntieChenA =>
      'You are Auntie Chen, a shrewd market vendor selling silk and fabrics. Your ONLY role is a market vendor. Negotiate prices firmly but fairly in Mandarin. NEVER break character or introduce yourself as anything other than a vendor. Start with high prices and be willing to bargain down.';

  @override
  String get youAreDrZhangA =>
      'You are Dr. Zhang, a calm and professional doctor at a medical clinic. Your ONLY role is a doctor. Ask about health symptoms and provide medical advice in Mandarin. NEVER break character or introduce yourself as anything other than a doctor. Be reassuring but thorough.';

  @override
  String get whereDoYouFeelUncomfortable =>
      'Where do you feel uncomfortable? Do you have a fever?';

  @override
  String get youAreACloseFriend =>
      'You are a close friend catching up after a long time. Your ONLY role is a friend. Keep responses casual, warm, and short in Mandarin. NEVER break character or introduce yourself as anything other than a friend. Use informal speech patterns appropriate for close friends.';

  @override
  String get noNbest => 'no nbest';

  @override
  String get timedOut => 'timed out';

  @override
  String get grading => 'Grading...';

  @override
  String get label1st => '1st ˉ';

  @override
  String get label2nd => '2nd ˊ';

  @override
  String get label3rd => '3rd ˇ';

  @override
  String get label4th => '4th ˋ';

  @override
  String get speaking2 => 'Speaking...';

  @override
  String get sessionCompletedInYourNext =>
      'Session completed. In your next practice, speak complete sentences to receive detailed pronunciation and tone diagnostics.';

  @override
  String get craneSoaring => 'crane soaring';

  @override
  String get gentleStream => 'gentle stream';

  @override
  String get brushAndInk => 'brush and ink';

  @override
  String get myStudent => 'my student';

  @override
  String get honoredDisciple => 'honored disciple';

  @override
  String get notEnoughInformation => 'not enough information';

  @override
  String get asAnAi => 'as an ai';

  @override
  String get goodPracticeSessionContinueFocusing =>
      'Good practice session. Continue focusing on clear tone pitch contrasts and natural conversational pacing.';

  @override
  String get insideASleekFuxingBullet =>
      'Inside a sleek Fuxing bullet train traveling at 350 km/h from Beijing to Shanghai.';

  @override
  String get harbinIceSnowWorldWonder => 'Harbin Ice & Snow World Wonder';

  @override
  String get theFamousPanjiayuanWeekendFlea =>
      'The famous Panjiayuan weekend flea market crowded with calligraphy scrolls, jade, and vintage trinkets.';

  @override
  String get jingdezhenBlueWhitePorcelainStudio =>
      'Jingdezhen Blue & White Porcelain Studio';

  @override
  String get pekingOperaDressingRoomMakeup =>
      'Peking Opera Dressing Room & Makeup';

  @override
  String get aHistoricTongrentangApothecaryScented =>
      'A historic Tongrentang apothecary scented with ginseng, wolfberry, and hundreds of wooden herbal drawers.';

  @override
  String get aVibrantPrivateNeonLit =>
      'A vibrant private neon-lit karaoke room in Shenzhen with microphones, fruit platters, and screen controls.';

  @override
  String get animeCosplayExpoInGuangzhou => 'Anime & Cosplay Expo in Guangzhou';

  @override
  String get nHOHuNy =>
      'Nǐ hǎo! Huānyíng lái dào zhèlǐ, jīntiān wǒmen liáo xiē shénme ne?';

  @override
  String get surpriseMe2 => '🎲 Surprise Me';

  @override
  String get eGALivelyBanquet =>
      'e.g., A lively banquet celebrating in Shanghai...';

  @override
  String get rollCharacter2 => '🎲 Roll Character';

  @override
  String get eGACuriousCousin =>
      'e.g., A curious cousin asking about your career...';

  @override
  String get keepTrying => 'Keep trying!';

  @override
  String get pending => 'Pending...';

  @override
  String get expected => '🎯 Expected';

  @override
  String get hSK2Elementary => 'HSK 2: Elementary';

  @override
  String get hSK3Intermediate => 'HSK 3: Intermediate';

  @override
  String get hSK5Advanced => 'HSK 5: Advanced';

  @override
  String get expressYourselfFullyWith5000 =>
      'Express yourself fully with 5000+ words.';

  @override
  String get hanziWriter => 'hanzi-writer';

  @override
  String get hvg => 'hvg:';

  @override
  String get unlimited => 'Unlimited';

  @override
  String get dueToday => 'Due today';

  @override
  String get newAvailable => 'New available';

  @override
  String get deleteAccountTile => 'delete-account-tile';

  @override
  String get giveASingleShortPractical =>
      'Give a single, short, practical tip on how to improve the shape, position, or length of the poorly drawn strokes. Be direct and helpful, do not be overly poetic or metaphorical. Do not use markdown.';

  @override
  String get localOnDeviceTTS => 'Local — On-device TTS';

  @override
  String get espaOl => 'Español';

  @override
  String get franAis => 'Français';

  @override
  String get portuguS => 'Português';

  @override
  String get tiNgViT => 'Tiếng Việt';

  @override
  String get koreFemaleWarm => 'Kore — Female, warm';

  @override
  String get aoedeFemaleCheerful => 'Aoede — Female, cheerful';

  @override
  String get fenrirMaleUpbeat => 'Fenrir — Male, upbeat';

  @override
  String get charonMaleNewsStyle => 'Charon — Male, news-style';

  @override
  String get puckMaleSporty => 'Puck — Male, sporty';

  @override
  String get systemVoice => 'System voice';

  @override
  String get generateAdd => 'Generate & Add';

  @override
  String get moreExamples => '📝 More examples';

  @override
  String get usage2 => '❓ Usage';

  @override
  String get translation => '💬 Translation';

  @override
  String get collocations => '📚 Collocations';

  @override
  String get mistakes => '❌ Mistakes';

  @override
  String get decrease => 'Decrease';

  @override
  String get increase => 'Increase';

  @override
  String get label0MeansThisCardType => '0 means this card type is disabled.';

  @override
  String get tapTheValueToEnter => 'Tap the value to enter an exact limit.';

  @override
  String get exactDailyLimit => 'Exact daily limit';

  @override
  String get enter0ToDisable => 'Enter 0 to disable.';

  @override
  String get apply => 'Apply';

  @override
  String get selectDeck => 'Select Deck';

  @override
  String get azureSpeechKeysNotConfigured =>
      'Azure Speech keys not configured. Add AZURE_SPEECH_KEY and AZURE_SPEECH_REGION to .env';

  @override
  String get sTARTING => 'STARTING…';

  @override
  String get sTARTSESSION => 'START SESSION';

  @override
  String get translating2 => 'Translating...';

  @override
  String get chai => '柴知道Chai...';

  @override
  String get oneInABillion2 => '@One-In-a-Billion';

  @override
  String get businessEconomics => 'business & economics';

  @override
  String get hskPreparation => 'hsk preparation';

  @override
  String get liveInChina => 'live in china';

  @override
  String get comprehensiveExercise => 'comprehensive exercise';

  @override
  String get howToUse => 'how to use';

  @override
  String get usesOf => 'uses of';

  @override
  String get appearedFirstOnMandarinBean => 'appeared first on Mandarin Bean';

  @override
  String get news2 => 'news:';

  @override
  String get joke => 'joke:';

  @override
  String get jokes => 'jokes:';

  @override
  String get academicScience => 'academic / science';

  @override
  String get politicsCommunism => 'politics & communism';

  @override
  String get foodDining => 'Food & Dining';

  @override
  String get sciFi => 'sci-fi';

  @override
  String get scienceFictionTech => 'Science Fiction & Tech';

  @override
  String get travelPlaces => 'Travel & Places';

  @override
  String get mythologyFantasy => 'Mythology & Fantasy';

  @override
  String get cultureTraditions => 'Culture & Traditions';

  @override
  String get businessEconomy => 'Business & Economy';

  @override
  String get natureAnimals => 'Nature & Animals';

  @override
  String get articleImg => 'article img';

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
  String get xiXiPicturesOfficialChannel =>
      '西嘻影业官方频道 XiXi Pictures Official Channel';

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
  String get getTheWeTVAPP => '腾讯视频 - Get the WeTV APP';

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
  String get learnMandarinWithTaiwanPlus => 'Learn Mandarin with TaiwanPlus';

  @override
  String get everydayChinese => 'Everyday Chinese';

  @override
  String get uCCFdR7zZ5SUXuOrEdKw => 'UCC_fdR7zZ_5SU--xuOrEdKw';

  @override
  String get tingDailyLifeInChina => 'Ting-Daily life in China';

  @override
  String get tFTFOODTRAVEL => 'TFT - FOOD & TRAVEL';

  @override
  String get uCsHMiBJ9r87fRH7VAWZw => 'UCs_h_miBJ9r8-7fRH7VAWZw';

  @override
  String get liziqi3 => '李子柒 Liziqi: 大蒜的一生';

  @override
  String get label2MINCULTURALCONTEXT => '2 MIN CULTURAL CONTEXT';

  @override
  String get liziqi4 => '李子柒 Liziqi: 竹子家具';

  @override
  String get peppaPigChinese2 => 'Peppa Pig Chinese: 泥坑';

  @override
  String get noBBCLeadArticleIs =>
      'No BBC lead article is currently available.';

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
  String get thoseDays => '四喜 Those days';

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
  String get noFunnyNoMoney => '不好笑就露宿街头No Funny No Money';

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
  String get getTheWeTVAPP2 => '腾讯视频 - 动漫 - Get the WeTV APP';

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
      '《诡秘之主》Lord of Mysteries 乌贼配音vlog终版 腾讯视频 - 动漫';

  @override
  String get lordOfMysteries => '《诡秘之主》Lord of Mysteries 神秘学课堂第八期 腾讯视频 - 动漫';

  @override
  String get lordOfMysteries2 => '《诡秘之主》Lord of Mysteries 神秘学课堂第七期 腾讯视频 - 动漫';

  @override
  String get lordOfMysteries3 => '《诡秘之主》Lord of Mysteries 神秘学课堂第六期 腾讯视频 - 动漫';

  @override
  String get lordOfMysteries4 => '《诡秘之主》Lord of Mysteries 神秘学课堂第五期 腾讯视频 - 动漫';

  @override
  String get lordOfMysteries5 => '《诡秘之主》Lord of Mysteries 神秘学课堂第四期 腾讯视频 - 动漫';

  @override
  String get lordOfMysteries6 => '《诡秘之主》Lord of Mysteries 神秘学课堂第三期 腾讯视频 - 动漫';

  @override
  String get pakhctn6g6A => 'Pakhctn6g6A';

  @override
  String get lordOfMysteries7 => '《诡秘之主》Lord of Mysteries 神秘学课堂第二期 腾讯视频 - 动漫';

  @override
  String get lordOfMysteries8 => '《诡秘之主》Lord of Mysteries 神秘学课堂第一期 腾讯视频 - 动漫';

  @override
  String get g5fLWO98axs => 'G5fLWO98axs';

  @override
  String get gK0eOTF2s4c => 'GK0eOTF2s4c';

  @override
  String get oSTLordOfMysteries =>
      '【OST】《诡秘之主》Lord of Mysteries 终幕曲《勿忘我》 腾讯视频 - 动漫';

  @override
  String get membersPremiere2 => 'Members Premiere 会员抢先看';

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
  String get herBlaze => '她的盛焰 Her Blaze';

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
  String get aboutLove => '玫瑰丛生 About Love';

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
  String get tA => '《玫瑰丛生》全员陷入爱情迷雾，TA会如何破局？ ｜主演：王子文、刘宇宁';

  @override
  String get pLMX26aiIvX5rSLe74r7sARps4oOqaBWD =>
      'PLMX26aiIvX5rSLe74r7sA-Rps4oOqaBWD';

  @override
  String get generationToGeneration2 => '江湖夜雨十年灯 Generation to Generation';

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
  String get loveStoryInThe1970s => '纯真年代的爱情 Love Story in the 1970s';

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
  String get whyIsHeStillSingle => '他为什么依然单身 Why Is He Still Single';

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
  String get theGlamorousNight => '夜色正浓 The Glamorous Night';

  @override
  String get theGlamorousNightE03 =>
      '【夜色正浓 The Glamorous Night】E03 霸气出招！赵玫绝地反击（江疏影，佟大为）';

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
      '精彩片段04 : 离谱系统强行加戏！纸巾变卫生棉？这下尴尬大了！【突然的喜欢 My Page in the 90s】';

  @override
  String get label03MyPageInThe =>
      '精彩片段03 : 替闺蜜去相亲，结果相到了男主本尊？【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSXXMyPage =>
      'BTS｜「出戏 X 陈星旭 X 王玉雯」高总和欢儿的抽象究竟谁更甚一筹？【突然的喜欢 My Page in the 90s】';

  @override
  String get label02MyPageInThe =>
      '精彩片段 02：本想攻略男主，结果竟然认错人？【突然的喜欢 My Page in the 90s】';

  @override
  String get label01MyPageInThe =>
      '精彩片段01 : 离谱！突然就穿书了？这剧情我该怎么演?【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSMyPageInThe => 'BTS｜陈星旭王玉雯溜冰撞了个满怀【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSMyPageInThe2 => 'BTS｜陈星旭王玉雯甜蜜跨年【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSMyPageInThe3 => 'BTS｜陈星旭王玉雯七夕定格甜蜜瞬间【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSMyPageInThe4 => 'BTS｜陈星旭王玉雯欢乐游乐场【突然的喜欢 My Page in the 90s】';

  @override
  String get myPageInThe90s2 => '《突然的喜欢 My Page in the 90s》今日开播，陈星旭王玉雯玩转系统甜蜜热恋';

  @override
  String get myPageInThe90s3 =>
      '《突然的喜欢 My Page in the 90s》1月22日甜蜜开播，陈星旭王玉雯反套路恋爱';

  @override
  String get myPageInThe90s4 => '《突然的喜欢 My Page in the 90s》定档0122！陈星旭王玉雯跨时代热恋';

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
  String get theDreamMaker => '小城大事 The Dream Maker';

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
      '【轻年 Forever Young】E23 马丁回到胡同被兄弟硬控（霍建华, 田雨, 张雪迎, 乔振宇）';

  @override
  String get foreverYoungE25 =>
      '【轻年 Forever Young】E25 稳准狠！马丁教嫂子拿捏丈夫（霍建华, 田雨, 张雪迎, 乔振宇）';

  @override
  String get foreverYoungE24 =>
      '【轻年 Forever Young】E24 有情敌？马丁被毛头小子喊大叔（霍建华, 田雨, 张雪迎, 乔振宇）';

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
  String get iQIYIGetTheIQIYIAPP => 'iQIYI 悬疑社 - Get the iQIYI APP';

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
  String get getTheWeTVAPP3 => '腾讯视频 - 青春剧场 - Get the WeTV APP';

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
  String get theHiddenHeirYeChen2 => '进击的叶辰 The Hidden Heir Ye Chen';

  @override
  String get xtTr8ZBDpG => 'XtTr8ZBDp-g';

  @override
  String get dresmsNeverEnd => '去听旷野的风 Dresms Never End';

  @override
  String get mamaGo => '我的妈妈是校花 Mama Go!';

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
      '《纯真年代的爱情 Love Story in the 1970s》双线编年史短片温暖来袭~';

  @override
  String get loveStoryInThe1970s3 =>
      '《纯真年代的爱情 Love Story in the 1970s》双人短片正式发布~让我们用感官书写一封情书';

  @override
  String get bTSLoveStoryInThe =>
      'BTS｜全员杀青，期待下一次重逢【纯真年代的爱情 Love Story in the 1970s】';

  @override
  String get loveStoryInThe1970s4 =>
      '《纯真年代的爱情 Love Story in the 1970s》爱是藏在烟火里的诗～';

  @override
  String get sGX3zNIuzM => 'SGX-3zNIuzM';

  @override
  String get loveStoryInThe1970s5 =>
      '《纯真年代的爱情 Love Story in the 1970s》正式定档2月21日播出啦~';

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
  String get theTruth => '风过留痕 The Truth';

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
      'BTS｜「Out of Character Duo Interview 」出戏双彩—高总和欢儿的抽象究竟谁更甚一筹？ 《突然的喜欢 My Page in the 90s》 腾讯视频-青春剧场';

  @override
  String get rEk9xALNODE => 'REk9xALNODE';

  @override
  String get label04MyPageInThe2 =>
      '精彩片段04 离谱系统强行加戏！纸巾变卫生棉？这下尴尬大了！ 《突然的喜欢 My Page in the 90s》 腾讯视频-青春剧场';

  @override
  String get label03MyPageInThe2 =>
      '精彩片段03 替闺蜜去相亲，结果相到了男主本尊？ 《突然的喜欢 My Page in the 90s》 腾讯视频-青春剧场';

  @override
  String get xsb7BJppy0 => 'Xsb7B-Jppy0';

  @override
  String get label02MyPageInThe2 =>
      '精彩片段02 本想攻略男主，结果竟然认错人？ 《突然的喜欢 My Page in the 90s》 腾讯视频-青春剧场';

  @override
  String get label01MyPageInThe2 =>
      '精彩片段01 离谱！突然就穿书了？这剧情我该怎么演? 《突然的喜欢 My Page in the 90s》 腾讯视频-青春剧场';

  @override
  String get zSpXoH9ok => 'Z_SpXo-H9ok';

  @override
  String get myPageInThe90s5 => '《突然的喜欢 My Page in the 90s》BTS｜陈星旭王玉雯溜冰撞了个满';

  @override
  String get myPageInThe90s6 => '《突然的喜欢 My Page in the 90s》今日开播！陈星旭王玉雯玩转系统甜蜜热恋';

  @override
  String get bTSMyPageInThe5 => 'BTS｜陈星旭王玉雯搞怪互动暧昧超标【突然的喜欢 My Page in the 90s】';

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
  String get dearSecretary => '我亲爱的秘书 Dear Secretary';

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
  String get foreverYoung2 => '轻年 Forever Young';

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
  String get lightOfDawn => '人之初 Light of Dawn​';

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
  String get sniperButterfly => '狙击蝴蝶 Sniper Butterfly';

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
  String get sniperButterfly1204 => '《狙击蝴蝶 Sniper Butterfly》定档1204！ 为爱越界';

  @override
  String get sniperButterflyFullVersion1 =>
      '《狙击蝴蝶 Sniper Butterfly》Full Version 1-15｜主演：陈妍希，周柯宇 腾讯视频-青春剧场';

  @override
  String get sniperButterflyFullVersion16 =>
      '《狙击蝴蝶 Sniper Butterfly》Full Version 16-30｜主演：陈妍希，周柯宇 腾讯视频-青春剧场';

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
  String get allRise => '即刻上场 All Rise';

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
  String get loveIsAlwaysOnline2 => '对的时间对的人 Love is Always Online';

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
      '《他为什么依然单身 Why Is He Still Single》定档1116！霍建华朱珠熟龄男女的爱情童话有！';

  @override
  String get whyIsHeStillSingle3 =>
      '《他为什么依然单身 Why Is He Still Single》Full Version｜主演：霍建华，朱珠 腾讯视频-青春剧场';

  @override
  String get ijgFlHRPHw => 'Ijg-FlHRPHw';

  @override
  String get whyIsHeStillSingle4 =>
      '《他为什么依然单身 Why Is He Still Single》Full Version 1｜主演：霍建华，朱珠 腾讯视频-青春剧场';

  @override
  String get whyIsHeStillSingle5 =>
      '《他为什么依然单身 Why Is He Still Single》Full Version 2｜主演：霍建华，朱珠 腾讯视频-青春剧场';

  @override
  String get yVGKe9xonY => 'YV-GKe9xonY';

  @override
  String get qKftsk37mXo => 'QKftsk37mXo';

  @override
  String get ccxy931pac => 'ccxy9-31pac';

  @override
  String get uc5hawjBFU => 'Uc5hawj_bFU';

  @override
  String get fightForLove => '山河枕 Fight for Love';

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
  String get iMNobody => '我本无名  I\'m Nobody';

  @override
  String get persona => '重影 Persona';

  @override
  String get d5CPVc0EIY => 'D5CPVc0E-IY';

  @override
  String get pJsHXm9ZsC => 'pJsHXm9Zs-c';

  @override
  String get vYRvNE7Yk => '-VYRvNE-7Yk';

  @override
  String get lightBeyondTheReed => '余生有涯 Light Beyond the Reed';

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
  String get thePrisonerOfBeauty => '折腰精简版 The Prisoner of Beauty';

  @override
  String get wsGeYBRO => 'wsGeYB_-r_o';

  @override
  String get thePrisonerOfBeauty2 =>
      '《折腰精简版 The Prisoner of Beauty》小乔替姐嫁世仇，新婚头天就和夫君杠上了｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场';

  @override
  String get thePrisonerOfBeauty3 =>
      '《折腰精简版 The Prisoner of Beauty》小乔破刘琰炸渠阴谋，和魏劭从死磕变互相护着｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场';

  @override
  String get thePrisonerOfBeauty4 =>
      '《折腰精简版 The Prisoner of Beauty》小乔装病争主院，魏劭当众护妻拒纳妾｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场';

  @override
  String get thePrisonerOfBeauty5 =>
      '《折腰精简版 The Prisoner of Beauty》小乔破了木匣栽赃局，魏劭认她是自家女君了｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场';

  @override
  String get thePrisonerOfBeauty6 =>
      '《折腰精简版 The Prisoner of Beauty》小乔智破嫁祸局，魏劭认妻护妻婆媳掀桌｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场';

  @override
  String get thePrisonerOfBeauty7 =>
      '《折腰精简版 The Prisoner of Beauty》魏俨挑事传假信，小乔魏劭因玉坠闹信任危机｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场';

  @override
  String get thePrisonerOfBeauty8 =>
      '《折腰精简版 The Prisoner of Beauty》苏娥皇用熟麦坑小乔，魏劭护妻破案俩人更亲｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场';

  @override
  String get thePrisonerOfBeauty9 =>
      '《折腰精简版 The Prisoner of Beauty》小乔魏劭遇刺中毒，小乔智破阴谋救夫更亲｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场';

  @override
  String get rNYFWNcb8o => 'RNYFW-Ncb8o';

  @override
  String get thePrisonerOfBeauty10 =>
      '《折腰精简版 The Prisoner of Beauty》魏劭送战马后补发簪，护妻失踪急得抓耳挠腮｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场';

  @override
  String get thePrisonerOfBeauty11 =>
      '《折腰精简版 The Prisoner of Beauty》魏劭怕小乔跑了吃醋护妻，搬出又后悔想她｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场';

  @override
  String get thePrisonerOfBeauty12 =>
      '《折腰精简版 The Prisoner of Beauty》魏劭吃醋背小乔，解木匣疑云俩人更亲｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场';

  @override
  String get thePrisonerOfBeauty13 =>
      '《折腰精简版 The Prisoner of Beauty》乔慈探姐引魏劭吃醋，小乔俩口子掏心定终身｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场';

  @override
  String get thePrisonerOfBeauty14 =>
      '《折腰精简版 The Prisoner of Beauty》魏俨为小乔离乡，劭乔吵架后和好｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场';

  @override
  String get ry1BWClaV0 => 'ry1BWCla-V0';

  @override
  String get thePrisonerOfBeauty15 =>
      '《折腰精简版 The Prisoner of Beauty》新婚夜兵变姐妹反目，小乔智退敌魏劭认错｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场';

  @override
  String get o8nFcvzyvM => 'O8n-FcvzyvM';

  @override
  String get thePrisonerOfBeauty16 =>
      '《折腰精简版 The Prisoner of Beauty》魏劭陪小乔回康郡解心结，乔父认婿俩口子圆房｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场';

  @override
  String get krsrk6wSAy8 => 'Krsrk6wSAy8';

  @override
  String get thePrisonerOfBeauty17 =>
      '《折腰精简版 The Prisoner of Beauty》乔越叛变魏梁丧命，大乔被劫比彘拼命反杀｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场';

  @override
  String get v26fn6w270 => 'V-26fn6w270';

  @override
  String get thePrisonerOfBeauty18 =>
      '《折腰精简版 The Prisoner of Beauty》魏梁战死魏渠断臂，大乔坠楼刘琰覆灭｜主演：宋祖儿，刘宇宁 腾讯视频-青春剧场';

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
  String get pPT => '小组作业嫌我慢？霸总半夜爬窗送PPT，保安追着他跑 腾讯视频-青春剧场';

  @override
  String get zPBZ1KRQ3hY => 'ZPBZ1KRQ3hY';

  @override
  String get aThousandMilesToYour => '过遍千城才识君 A Thousand Miles to Your Heart';

  @override
  String get getTheWeTVAPP4 => '腾讯视频 - 古装剧场 - Get the WeTV APP';

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
  String get theInescapable => '锁簪 The Inescapable';

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
      '《江湖夜雨十年灯 Generation to Generation》定档2月22日！看江湖最强新生代慕慕昭昭一起闯江湖';

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
  String get the300LoyalGhosts2 => '大明暗影三百忠魂 The 300 Loyal Ghosts';

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
  String get danceOfThePhoenix => '且听凤鸣 Dance of The Phoenix';

  @override
  String get f0uIRYSOwo => 'F0uIRY_SOwo';

  @override
  String get extraordinary2 => '非凡 Extraordinary';

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
      '《御赐小仵作2 The Imperial Coroner S2》定档0115，楚瑜夫妇暖心回归！';

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
  String get theUltimateVowUnknownTo => '君不知 The Ultimate Vow, Unknown to You';

  @override
  String get duMRGzTeKs => 'DuM-rGzTeKs';

  @override
  String get pLs3DOuT3JlGTynSBKz3Z5DcDzwwmqSOf =>
      'PLs3DOuT3JlGTynSBKz3-z5DcDzwwmqSOf';

  @override
  String get theChangAnYouth => '长安少年行 The Chang\'An Youth';

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
  String get thePrincessDecree2 => '平凝有令 The Princess Decree';

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
  String get herPhoenixMajesty2 => '凤皇传 Her Phoenix Majesty';

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
      '【有花在洲 A Flower On The Continent】 小王爷当质子被花姑娘硬当公主，还挤一块住';

  @override
  String get aFlowerOnTheContinent4 =>
      '【有花在洲 A Flower On The Continent】 花姑娘女装露馅，小王爷舍命护她还反被诬陷';

  @override
  String get aFlowerOnTheContinent5 =>
      '【有花在洲 A Flower On The Continent】 花惜玉发现杀父仇人是宁玄洲的爹当场翻脸';

  @override
  String get aFlowerOnTheContinent6 =>
      '【有花在洲 A Flower On The Continent】 花惜玉穿嫁衣闯敌营，拼了命救宁玄洲差点没命';

  @override
  String get aFlowerOnTheContinent7 =>
      '【有花在洲 A Flower On The Continent】 两国签和约，宁玄洲撕诏书非要娶花惜玉';

  @override
  String get aFlowerOnTheContinent8 =>
      '【有花在洲 A Flower On The Continent】 花惜玉割腕放血制药，宁玄洲告发父皇杀了她爹';

  @override
  String get aFlowerOnTheContinent9 =>
      '【有花在洲 A Flower On The Continent】 花惜玉知道爹是宁玄洲爹杀的，在花海砍断定情树枝';

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
  String get hilariousFamily22 => '芬芳喜事 Hilarious Family 2';

  @override
  String get sliceOfLife => 'Slice of Life';

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
  String get legendOfTheFemaleGeneral => '锦月如歌 Legend of The Female General';

  @override
  String get highlightLegendOfTheFemale =>
      'Highlight高光合集 【锦月如歌 Legend of The Female General】';

  @override
  String get a40F2TEZrms => 'A40F2TEZrms';

  @override
  String get lYQ5iND4 => 'lYQ5iN-d-_4';

  @override
  String get bTSLegendOfTheFemale =>
      'BTS 周也的生日大放送 🎂！【锦月如歌 Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale2 =>
      'BTS 肖都督丞磊生日大放送 🎂！【锦月如歌 Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale3 =>
      'BTS 战场上帅气合体打斗，没人能拒绝飒感拉满的大魏双星【锦月如歌 Legend of The Female General】';

  @override
  String get bTS520LegendOfThe =>
      'BTS 喜肖晏开的520约会方案【锦月如歌 Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale4 =>
      'BTS 醉酒的周也可爱到犯规~舞剑反差萌拉满~一旁的丞磊嘴角笑意真藏不住一点！【锦月如歌 Legend of The Female General】';

  @override
  String get pLs3DOuT3JlGRucYIZLqmT7FO5IWDWrP =>
      'PLs3DOuT3JlGRuc_yIZLqmT7FO5IWD-WrP';

  @override
  String get thePrincessSGambit => '桃花映江山 The Princess\'s Gambit';

  @override
  String get highlightThePrincessSGambit =>
      'Highlight高光合集 【桃花映江山 The Princess\'s Gambit】';

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
      'Clip 一袭红衣染白雪！姜桃花为保护幼弟诀别故土远嫁祈国【桃花映江山 The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit2 =>
      'Clip 新婚日沈府妻妾集体作妖？桃花以退为进淡定接招【桃花映江山 The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit3 =>
      'Clip 桃花自缢装晕被拆穿，沈在野一针扎醒：演，接着演！【桃花映江山 The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit4 =>
      'Clip 沈相办案好狠的心！雷霆手段彻查恶钱案，贪官们瑟瑟发抖【桃花映江山 The Princess\'s Gambit】';

  @override
  String get eDrJjtCRF0 => 'eDr-jjtCRF0';

  @override
  String get clipThePrincessSGambit5 =>
      'Clip 面具刺客完美伪装难逃制裁，神探桃花：你的脚出卖了你！【桃花映江山 The Princess\'s Gambit】';

  @override
  String get clipPlayThePrincessS =>
      'Clip 发簪审讯play！沈在野执簪挑起桃花下巴冷声逼问【桃花映江山 The Princess\'s Gambit】';

  @override
  String get label58K8GxhXlQ => '58K8-gxhXlQ';

  @override
  String get clipThePrincessSGambit6 =>
      'Clip 初次相见就玩这么大！沈在野桃花身中合欢散四目相对【桃花映江山 The Princess\'s Gambit】';

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
      '【Limited FULL】云襄传 | The Ingenious One | iQIYI 👑Join the Membership and enjoy full episodes now!';

  @override
  String get iQIYIGetTheIQIYIAPP2 => 'iQIYI 爱奇艺 - Get the iQIYI APP';

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
      'iQIYI Philippines - Get the iQIYI APP';

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
      '【AI English Dub】Mr. BAD | Chen Zheyuan, Yue Shen | iQIYI Philippines';

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
      '🌸【奇幻仙侠】🎋Love of the Divine Tree 仙台有树 | Deng Wei × Xiang Hanzhi | FULL正片 | iQIYI 👑Join the Membership and enjoy full episodes now!';

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
      '【FULL】🕊️My Dear Guardian |  Johnny Huang, Li Qin | iQIYI Philippines';

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
      '🌸【治愈爱情】🎋The Best Thing 爱你 | Zhang Linghe × Xu Ruohan | FULL正片 | iQIYI 👑Join the Membership and enjoy full episodes now!';

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
      '📽️【EP01 2026】Rebirth Chinese Drama  ENGSUB | Li Yunrui / Huangyang Tiantian /Zhang Kangle ⛵😍 Historical Drama 2026 #冰湖重生';

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
      '【Full】Bright Eyes in the Dark | Johnny Huang, Zhang Jing Yi | iQIYI Philippines';

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
      '🎥✨【ENG SUB】Chinese Fantasy Movie | Fantasy、Adventure【 iQIYI MOVIE THEATER-Welcome to subscribe】';

  @override
  String get iQIYIMOVIETHEATERGetThe =>
      '爱奇艺大电影 iQIYI MOVIE THEATER - Get the iQIYI APP';

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
      '🎀【微短剧 Mini Drama】ENG SUB | Full Version Collection | Download WeTV / Tencent Video APP to Watch More';

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
      '【Full】Beauty of Resilience | Ju Jing Yi, Fiction | iQIYI Philippines';

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
      '🔥Hot Trending【子夜归 Moonlit Reunion】Full EPS | Human and Demon fall in love while solving mysteries | Xu Kai, Tian Xiwei | ENG SUB';

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
  String get fallInLove => 'fall in love';

  @override
  String get myGirl => 'my girl';

  @override
  String get firstRomance2 => 'first romance';

  @override
  String get fallFor => 'fall for';

  @override
  String get uCD83JhUFQXRDwC6S8caCQ => 'UCD_83Jh-UFQXRDwC6S8caCQ';

  @override
  String get uCFh5x5AZHQQ6FaGKnGQXDA => 'UCFh5x5AZHQQ6FaGKnG-QXDA';

  @override
  String get uCRABdhiBHX4BieJfPCd2pg => 'UCRABdhiBHX4Bie-jfPCd2pg';

  @override
  String get hiddenLove2 => 'Hidden Love';

  @override
  String get loveBetweenFairyAndDevil2 => 'Love Between Fairy and Devil';

  @override
  String get loveLikeTheGalaxy2 => 'Love Like The Galaxy';

  @override
  String get myJourneyToYou2 => 'My Journey to You';

  @override
  String get mysteriousLotusCasebook2 => 'Mysterious Lotus Casebook';

  @override
  String get reset => 'Reset';

  @override
  String get theLongBallad2 => 'The Long Ballad';

  @override
  String get theUntamed2 => 'The Untamed';

  @override
  String get wordOfHonor2 => 'Word of Honor';

  @override
  String get lightOfDawn2 => '人之初 Light of Dawn';

  @override
  String get hOMELANDGUARDIAN2 => '守诚者|HOMELAND GUARDIAN';

  @override
  String get searching2 => 'Searching...';

  @override
  String get verse => 'Verse';

  @override
  String get allStories2 => 'All Stories';

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
  String get char2 => '+ char +';

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
      'article, .article, .post, .content, main';

  @override
  String get ttsActiveWord => '.tts-active-word';

  @override
  String get ttsActiveWord2 => 'tts-active-word';

  @override
  String get upperIntermediate2 => 'Upper-Intermediate';

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
  String get processing => 'Processingâ€¦';

  @override
  String get keepItUp => '好！Keep it up';

  @override
  String get minutesDay => 'Minutes / Day';

  @override
  String get consistencyIsTheInkThat =>
      '\"Consistency is the ink that builds the character.\"';

  @override
  String get businessCareer => 'Business & Career';

  @override
  String get travelSurvival => 'Travel & Survival';

  @override
  String get label05MinDay => '05 Min / Day';

  @override
  String get label10MinDay => '10 Min / Day';

  @override
  String get label20MinDay => '20 Min / Day';

  @override
  String get label30MinDay => '30 Min / Day';

  @override
  String get dynamicDecksStrokeAnalysis => 'Dynamic Decks & Stroke Analysis';

  @override
  String get subscriptionsAreTemporarilyUnavailablePl =>
      'Subscriptions are temporarily unavailable. Please try again.';

  @override
  String get trialReminder => 'Trial Reminder';

  @override
  String get turnOnNotificationsIfYou =>
      'Turn on notifications if you would like a reminder before your eligible trial expires. Your App Store subscription settings remain the source of truth.';

  @override
  String get label2Months => '2 months';

  @override
  String get label3Months => '3 months';

  @override
  String get label6Months => '6 months';

  @override
  String get billingPeriod => 'billing period';

  @override
  String get chooseASubscription => 'Choose a subscription';

  @override
  String get startFreeTrial => 'Start free trial';

  @override
  String get smartNewsDict => 'Smart News & Dict';

  @override
  String get hSK16AIDecks => 'HSK 1-6 & AI Decks';

  @override
  String get continueWithTemporaryPremium => 'Continue with temporary Premium';

  @override
  String get testProductUnavailable => 'Test product unavailable';

  @override
  String get paymentIsChargedToYour =>
      'Payment is charged to your App Store account.';

  @override
  String get subscriptionsRenewAutomaticallyUnlessCan =>
      'Subscriptions renew automatically unless canceled';

  @override
  String get atLeast24HoursBefore =>
      'at least 24 hours before the end of the current period.';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get closePurchaseOffer => 'Close purchase offer';

  @override
  String get loading => 'Loading...';

  @override
  String get analyzingImage2 => 'Analyzing image…';

  @override
  String get extractingChineseText2 => 'Extracting Chinese text…';

  @override
  String get lookingUpVocabulary2 => 'Looking up vocabulary…';

  @override
  String get deselectAll => 'Deselect All';

  @override
  String get selectAll => 'Select All';

  @override
  String get worldChineseLiteraryMasterpiece =>
      'World & Chinese literary masterpiece.';

  @override
  String get classic => 'Classic';

  @override
  String get literature => 'Literature';

  @override
  String get theOriginAwakening => 'The Origin & Awakening';

  @override
  String get turbulentHorizonsTheJourney => 'Turbulent Horizons & The Journey';

  @override
  String get trialsTribulationsDevotion => 'Trials, Tribulations & Devotion';

  @override
  String get theClashOfWitsBravery => 'The Clash of Wits & Bravery';

  @override
  String get theGrandClimaxResolution => 'The Grand Climax & Resolution';

  @override
  String get everlastingLegacyEpilogue => 'Everlasting Legacy & Epilogue';

  @override
  String get acrossTheVastExpanseOf =>
      'Across the vast expanse of heaven and earth, characters pursue their destiny and convictions through profound trials.';

  @override
  String get everyDialogueAndEncounterWithin =>
      'Every dialogue and encounter within the tale carries the brilliance of the human spirit and the imprint of its era.';

  @override
  String get followingTheFlowOfProse =>
      'Following the flow of prose, readers traverse centuries of time to share in the triumphs and sorrows of legendary figures.';

  @override
  String get preQin => 'pre-qin';

  @override
  String get theGoddessNWaRepairing => 'The goddess Nüwa repairing the sky';

  @override
  String get artsTraditions => 'Arts & Traditions';

  @override
  String get femaleWarm => 'Female, warm';

  @override
  String get femaleCheerful => 'Female, cheerful';

  @override
  String get maleUpbeat => 'Male, upbeat';

  @override
  String get maleNewsStyle => 'Male, news-style';

  @override
  String get maleSporty => 'Male, sporty';

  @override
  String get onDevice => 'On-device';

  @override
  String get label15Minutes => '15 Minutes';

  @override
  String get label30Minutes => '30 Minutes';

  @override
  String get label45Minutes => '45 Minutes';

  @override
  String get selectChapter => 'Select Chapter';

  @override
  String get andContinuesToBeStudied =>
      'and continues to be studied and celebrated by readers across generations.';

  @override
  String get label1Poem => '1 Poem';

  @override
  String get label1Chapter => '1 Chapter';

  @override
  String get localDeviceVoice2 => 'Local device voice';

  @override
  String get weeklyAzureQuotaReachedSwitching =>
      'Weekly Azure quota reached — switching to local voice';

  @override
  String get sleepTimer2 => '定时关闭 · Sleep Timer';

  @override
  String get tableOfContents2 => '目录 · Table of Contents';

  @override
  String get hanziMaster10 => 'HanziMaster/1.0';

  @override
  String get spanishItalianRussianClassics =>
      'Spanish, Italian & Russian Classics';

  @override
  String get englishAmericanGlobalClassics =>
      'English, American & Global Classics';

  @override
  String get whileStrategicallyEmbeddingWordsYou =>
      'while strategically embedding words you are currently struggling with so you can learn them in context.';

  @override
  String get poetryPainting => 'poetry-painting';

  @override
  String get contactSinosparkCom => 'contact@sinospark.com';

  @override
  String get shadowingStudioIsADedicated =>
      'Shadowing Studio is a dedicated space to practice mimicking native speakers. You listen to a phrase, record yourself repeating it, and compare the waveforms and pronunciation scores to refine your accent.';

  @override
  String get theVoicesInAIStories =>
      'The voices in AI Stories and Echo Hall are powered by advanced Neural Text-to-Speech models. They are specifically tuned to provide authentic native Chinese accents, appropriate emotional inflection, and natural pacing.';

  @override
  String get theWebExplorerAllowsYou =>
      'The Web Explorer allows you to browse any Chinese website. When you encounter a difficult word, simply tap it to open the Quick Look card, which provides instant pinyin, translation, and HSK level.';

  @override
  String get zenModeStripsAwayDistracting =>
      'Zen Mode strips away distracting web elements, ads, and complex layouts from articles, presenting you with a clean, calligraphic reading environment focused purely on the text.';

  @override
  String get weUseAnIntelligentAlgorithm =>
      'We use an intelligent algorithm that predicts when you are about to forget a word. Words you struggle with will appear more frequently, while words you know well will be scheduled further into the future.';

  @override
  String get usage3 => 'Usage:';
}
