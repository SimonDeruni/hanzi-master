// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get originStoryChip => '📜 उत्पत्ति की कहानी';

  @override
  String get ancientFormChip => '🏺 प्राचीन रूप';

  @override
  String get threeMoreWordsChip => '📖 3 और शब्द';

  @override
  String get wordFamilyChip => '🔗 शब्द परिवार';

  @override
  String get idiomChip => '🀄 मुहावरा';

  @override
  String get proverbChip => '💬 कहावत';

  @override
  String get isThereAChineseIdiomFeaturingThisCharacter =>
      'क्या कोई चीनी मुहावरा (成语) है जिसमें यह अक्षर आता हो?';

  @override
  String get strokeOrderChip => '✏️ स्ट्रोक क्रम';

  @override
  String get calligraphyTipChip => '🎨 सुलेख सुझाव';

  @override
  String get grammarNoteChip => '📝 व्याकरण नोट';

  @override
  String get similarWordsChip => '🔄 समान शब्द';

  @override
  String get culturalNoteChip => '🏮 सांस्कृतिक नोट';

  @override
  String get inMediaChip => '🀄 मीडिया में';

  @override
  String get radicalMeaningChip => '🧩 रेडिकल का अर्थ';

  @override
  String get componentBreakdownChip => '🔍 घटकों का विवरण';

  @override
  String get toneTipChip => '🎵 टोन सुझाव';

  @override
  String get homophonesChip => '👯 समोच्चारित शब्द';

  @override
  String askMeAnythingAbout(String hanzi) {
    return '$hanzi के बारे में मुझसे कुछ भी पूछें...';
  }

  @override
  String aiTutorError(String error) {
    return 'AI ट्यूटर त्रुटि: $error';
  }

  @override
  String get aiTutorRateLimit =>
      'AI ट्यूटर अभी व्यस्त है। कृपया कुछ देर प्रतीक्षा करें और फिर से प्रयास करें।';

  @override
  String get deleteAccount => 'खाता हटाएं';

  @override
  String get deleteAccountSubtitle => 'अपना खाता स्थायी रूप से हटाएं';

  @override
  String get deleteAccountTitle =>
      'क्या आप अपना खाता स्थायी रूप से हटाना चाहते हैं?';

  @override
  String get accountDataDeletedTitle => 'खाते का डेटा हटा दिया जाएगा';

  @override
  String get accountDataDeletedBody =>
      'SinoSpark द्वारा रखा गया आपका साइन-इन खाता और खाता विवरण स्थायी रूप से हटा दिया जाएगा। इसे पूर्ववत नहीं किया जा सकता।';

  @override
  String get localDataKeptTitle => 'इस डिवाइस का डेटा सुरक्षित रहेगा';

  @override
  String get localDataKeptBody =>
      'केवल इस डिवाइस पर संग्रहीत अध्ययन प्रगति, डाउनलोड की गई सामग्री और प्राथमिकताएं नहीं हटाई जाएंगी।';

  @override
  String get subscriptionNotCanceledTitle => 'सदस्यता रद्द नहीं होगी';

  @override
  String get subscriptionNotCanceledBody =>
      'अपना खाता हटाने से App Store की सदस्यता रद्द नहीं होती है। जब तक आप इसे Apple के माध्यम से रद्द नहीं करते, इसका नवीनीकरण जारी रह सकता है।';

  @override
  String get manageSubscription => 'App Store सदस्यता प्रबंधित करें';

  @override
  String get subscriptionManagementFailed =>
      'Apple सदस्यता प्रबंधन खोला नहीं जा सका। सेटिंग्स खोलें, अपने नाम पर टैप करें, फिर \'सदस्यताएं\' चुनें।';

  @override
  String get confirmPassword => 'वर्तमान पासवर्ड';

  @override
  String get confirmPasswordToDelete =>
      'अपनी पहचान की पुष्टि करने के लिए पासवर्ड दर्ज करें।';

  @override
  String get deleteAccountPermanently => 'खाता स्थायी रूप से हटाएं';

  @override
  String get deleteAccountFinalTitle => 'अंतिम पुष्टि';

  @override
  String get deleteAccountFinalWarning =>
      'यह आपके खाते को स्थायी रूप से हटा देगा और इसे पूर्ववत नहीं किया जा सकता। केवल इस डिवाइस पर संग्रहीत डेटा सुरक्षित रहेगा। क्या आप जारी रखना चाहते हैं?';

  @override
  String get deletingAccount => 'खाता हटाया जा रहा है...';

  @override
  String get accountPasswordRequired =>
      'जारी रखने के लिए अपना वर्तमान पासवर्ड दर्ज करें।';

  @override
  String get accountPasswordIncorrect =>
      'पासवर्ड गलत है। कृपया पुनः प्रयास करें।';

  @override
  String get accountReauthenticationCanceled =>
      'पहचान की पुष्टि रद्द कर दी गई। आपका खाता नहीं हटाया गया।';

  @override
  String get accountReauthenticationFailed =>
      'हम आपकी पहचान की पुष्टि नहीं कर सके। कृपया पुनः प्रयास करें और साइन-इन पूरा करें।';

  @override
  String get accountAlreadySignedOut =>
      'आप पहले ही साइन आउट कर चुके हैं। कोई खाता नहीं हटाया गया।';

  @override
  String get accountProviderUnsupported =>
      'ऐप में इस साइन-इन विधि को सत्यापित नहीं किया जा सकता। खाता हटाने में सहायता के लिए सहायता केंद्र से संपर्क करें।';

  @override
  String get appleDeletionRequiresAppleDevice =>
      'सुरक्षा कारणों से, Apple से जुड़ा खाता Apple डिवाइस पर ही हटाया जाना चाहिए।';

  @override
  String get accountDeletionNetworkError =>
      'अपना इंटरनेट कनेक्शन जांचें और खाता दोबारा हटाने का प्रयास करें।';

  @override
  String get accountDeletionFailed =>
      'खाता हटाया नहीं जा सका। आपका खाता अभी भी सक्रिय है। कृपया पुनः प्रयास करें।';

  @override
  String get accountDeletedSuccessfully =>
      'आपका खाता स्थायी रूप से हटा दिया गया है।';

  @override
  String get globalMastery => 'संपूर्ण महारत';

  @override
  String get masteredCards => 'महारत हासिल';

  @override
  String get hsk1Candidate => 'HSK 1 उम्मीदवार';

  @override
  String get hsk2Candidate => 'HSK 2 उम्मीदवार';

  @override
  String get hsk3Candidate => 'HSK 3 उम्मीदवार';

  @override
  String get hsk4Candidate => 'HSK 4 उम्मीदवार';

  @override
  String get hsk5Candidate => 'HSK 5 उम्मीदवार';

  @override
  String get hsk6Candidate => 'HSK 6 उम्मीदवार';

  @override
  String get hsk6Master => 'HSK 6 मास्टर';

  @override
  String get currentRank => 'वर्तमान रैंक';

  @override
  String get next => 'आगे';

  @override
  String get searchHanziOrPinyin => 'हान्ज़ी या पिनयिन खोजें...';

  @override
  String get dailyReview => 'दैनिक समीक्षा';

  @override
  String get upcomingForecast => 'आगामी पूर्वानुमान';

  @override
  String get laterToday => 'आज बाद में';

  @override
  String get tomorrow => 'कल';

  @override
  String get next7Days => 'अगले 7 दिन';

  @override
  String get theScholarWay => 'विद्वान का मार्ग';

  @override
  String get beginJourney => 'शुरू करें';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get darkMode => 'डार्क मोड';

  @override
  String get darkModeDesc => 'आंखों के लिए आरामदायक';

  @override
  String get voiceSpeed => 'आवाज़ की गति';

  @override
  String get artAndIntellect => 'कला और बुद्धि';

  @override
  String get theDigitalScholar => 'डिजिटल विद्वान';

  @override
  String get refineBrushVoice => 'AI के साथ ब्रश और उच्चारण को निखारें।';

  @override
  String get liveVoiceCall => 'लाइव वॉयस कॉल';

  @override
  String get immersiveRoleplay => 'इमर्सिव रोलप्ले';

  @override
  String get readingRoom => 'रीडिंग रूम';

  @override
  String get shadowingStudio => 'शैडोइंग स्टूडियो';

  @override
  String get errorPrefix => 'त्रुटि: ';

  @override
  String get initializingLibrary => 'शुरू हो रहा है...';

  @override
  String get unlockCharactersToQuiz => 'क्विज़ के लिए 4 वर्ण अनलॉक करें!';

  @override
  String get practiceQuiz => 'क्विज़';

  @override
  String get curriculumPaths => 'पाठ्यक्रम';

  @override
  String get noDecksFound => 'कोई डेक नहीं मिला।';

  @override
  String get addCardsFirst => 'पहले कार्ड जोड़ें!';

  @override
  String get aiDraftingPath => 'AI आपका मार्ग तैयार कर रहा है...';

  @override
  String get pathReady => 'मार्ग तैयार है!';

  @override
  String get errorGeneratingPath => 'मार्ग बनाने में त्रुटि';

  @override
  String get brushingCurriculum => 'मार्ग बनाया जा रहा है...';

  @override
  String get warmUp => 'वार्म अप';

  @override
  String get lessonComplete => 'पाठ पूरा हुआ! +10 अंक';

  @override
  String get step1Origin => 'चरण 1: उत्पत्ति';

  @override
  String get traceRadical => 'रेडिकल को ट्रेस करें';

  @override
  String get step2Forge => 'चरण 2: निर्माण';

  @override
  String get chooseEssence => 'सार चुनें';

  @override
  String get wrongEssence => 'गलत! पुनः प्रयास करें।';

  @override
  String get step3Hunt => 'चरण 3: खोज';

  @override
  String get findCharacters => 'वर्ण खोजें';

  @override
  String get notThatOne => 'यह नहीं!';

  @override
  String get successfullyInstalled => 'सफलतापूर्वक स्थापित:';

  @override
  String get failedToDownload => 'डाउनलोड विफल।';

  @override
  String get rescindTitle => 'रद्द करें?';

  @override
  String get removeCharactersWarning => 'यह इन वर्णों को हटा देगा।';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get uninstall => 'अनइंस्टॉल करें';

  @override
  String get removedLibrary => 'हटा दिया गया:';

  @override
  String get tomeLibrary => 'पुस्तकालय';

  @override
  String get libraryError => 'पुस्तकालय त्रुटि';

  @override
  String get installTome => 'इंस्टॉल करें';

  @override
  String get unitIntro => 'यूनिट परिचय';

  @override
  String get constellationCluster => 'नक्षत्र समूह';

  @override
  String get ok => 'ठीक है';

  @override
  String get divingInto => 'शुरू कर रहे हैं...';

  @override
  String get keyRadicals => 'मुख्य रेडिकल्स';

  @override
  String get noRadicalData => 'कोई डेटा नहीं।';

  @override
  String get discovery => 'खोज';

  @override
  String get startLearning => 'सीखना शुरू करें';

  @override
  String get selectPersona => 'व्यक्तित्व चुनें';

  @override
  String get customPersona => 'कस्टम व्यक्तित्व';

  @override
  String get geminiLiveCall => 'लाइव कॉल';

  @override
  String get returnToMenu => 'वापस जाएँ';

  @override
  String get strokeAnalysis => 'स्ट्रोक क्रम विश्लेषण';

  @override
  String get excellentWork => 'उत्कृष्ट कार्य!';

  @override
  String get keepPracticing => 'अभ्यास जारी रखें!';

  @override
  String get drawingSubmitted => 'ड्राइंग जमा की गई';

  @override
  String get customPersonaHint => 'एक कस्टम व्यक्तित्व परिभाषित करें...';

  @override
  String get stepOneOrigin => 'चरण 1: उत्पत्ति';

  @override
  String get stepTwoForge => 'चरण 2: निर्माण';

  @override
  String get toForge => 'निर्माण के लिए';

  @override
  String get whatEssenceDoesNeed => 'किस सार की आवश्यकता है';

  @override
  String get need => 'आवश्यकता';

  @override
  String get forged => 'निर्मित';

  @override
  String get stepThreeHunt => 'चरण 3: खोज';

  @override
  String get findCharactersWith => 'इसके साथ वर्ण खोजें';

  @override
  String get uninstallButton => 'अनइंस्टॉल करें';

  @override
  String get gradedAiStories => 'स्तरानुसार AI कहानियाँ';

  @override
  String get calligraphy => 'सुलेख';

  @override
  String get theScrollOfOrigin => 'उत्पत्ति का स्क्रॉल';

  @override
  String get galaxyOf => 'की आकाशगंगा';

  @override
  String get constellationDescription => 'नक्षत्र विवरण';

  @override
  String get noRadicalDataAvailable => 'कोई रेडिकल डेटा उपलब्ध नहीं है';

  @override
  String get learningPreferences => 'सीखने की प्राथमिकताएं';

  @override
  String get hardMode => 'कठिन मोड';

  @override
  String get hardModeDesc =>
      'बिना किसी दृश्य सहायता के सटीक इनपुट की आवश्यकता होती है।';

  @override
  String get adaptiveGuidance => 'अनुकूली मार्गदर्शन';

  @override
  String get dailyGoal => 'दैनिक लक्ष्य';

  @override
  String get audioAndHaptics => 'ऑडियो और हैप्टिक्स';

  @override
  String get autoPlayAudio => 'ऑडियो स्वतः चलाएं';

  @override
  String get autoPlayDesc => 'कार्ड प्रकट होने पर उच्चारण अपने आप चलाएं।';

  @override
  String get haptics => 'हैप्टिक फीडबैक';

  @override
  String get displayAndContent => 'प्रदर्शन और सामग्री';

  @override
  String get useEnglishDefinitions => 'अंग्रेज़ी परिभाषाएँ उपयोग करें';

  @override
  String get useEnglishDefinitionsDesc =>
      'अंग्रेज़ी परिभाषाएँ आम तौर पर अधिक सटीक और विस्तृत होती हैं';

  @override
  String get animationSpeed => 'एनिमेशन गति';

  @override
  String get manageTomes => 'ग्रंथ प्रबंधित करें';

  @override
  String get manageTomesDesc => 'स्थापित अध्ययन सामग्री प्रबंधित करें।';

  @override
  String get dangerZone => 'खतरे का क्षेत्र';

  @override
  String get resetAllData => 'सभी डेटा रीसेट करें';

  @override
  String get resetDataDesc =>
      'यह आपके सभी प्रगति डेटा, आँकड़े और सेटिंग्स को स्थायी रूप से हटा देगा। यह क्रिया पूर्ववत नहीं की जा सकती।';

  @override
  String get areYouSure => 'क्या आप सुनिश्चित हैं?';

  @override
  String get cannotBeUndone => 'इसे पूर्ववत नहीं किया जा सकता';

  @override
  String get deleteEverything => 'सब कुछ हटाएं';

  @override
  String get appLanguage => 'ऐप भाषा';

  @override
  String get howDidYouDo => 'आपने कैसा प्रदर्शन किया?';

  @override
  String get missedItEntirely => 'पूरी तरह से भूल गए';

  @override
  String get gotItButStruggled => 'याद आ गया, पर संघर्ष हुआ';

  @override
  String get gotItClearly => 'स्पष्ट रूप से याद आ गया';

  @override
  String get perfectAndImmediate => 'उत्तम और तुरंत';

  @override
  String get again => 'फिर से';

  @override
  String get hard => 'कठिन';

  @override
  String get good => 'अच्छा';

  @override
  String get easy => 'आसान';

  @override
  String get tapToReveal => 'दिखाने के लिए टैप करें';

  @override
  String get howWellDidYouRemember => 'आपको कितना याद रहा?';

  @override
  String get completelyForgot => 'पूरी तरह से भूल गए';

  @override
  String get gotItWithDifficulty => 'कठिनाई से याद आया';

  @override
  String get recalledCorrectly => 'सही ढंग से याद किया';

  @override
  String get perfectRecall => 'पूरी तरह याद';

  @override
  String get practiceWriting => 'लिखने का अभ्यास करें';

  @override
  String get hideScratchpad => 'स्क्रैचपैड छुपाएँ';

  @override
  String get whatCharacterMeans => 'इस वर्ण का अर्थ है:';

  @override
  String get tapCardToReveal => 'दिखाने के लिए कार्ड पर टैप करें';

  @override
  String get ratePronunciationConfidence =>
      'अपने उच्चारण आत्मविश्वास को रेट करें';

  @override
  String get botchedIt => 'पूरी तरह से गलत';

  @override
  String get struggledWithTones => 'टोन में कठिनाई हुई';

  @override
  String get acceptable => 'स्वीकार्य';

  @override
  String get perfectlyNatural => 'पूरी तरह से स्वाभाविक';

  @override
  String get sessionComplete => 'सत्र पूरा हुआ!';

  @override
  String get accuracy => 'सटीकता';

  @override
  String get reviewed => 'समीक्षित';

  @override
  String get correct => 'सही!';

  @override
  String get backToLibrary => 'लाइब्रेरी पर वापस जाएं';

  @override
  String get revealAnswer => 'उत्तर दिखाएँ';

  @override
  String get aiHubTitle => 'AI हब';

  @override
  String get textChat => 'टेक्स्ट चैट';

  @override
  String get scholarlyPersonas => 'विद्वत्तापूर्ण व्यक्तित्व';

  @override
  String get shadowing => 'शैडोइंग';

  @override
  String get liveTranslation => 'लाइव अनुवाद';

  @override
  String get scholarsLibrary => 'विद्वान की लाइब्रेरी';

  @override
  String get generate => 'जनरेट करें';

  @override
  String get searchPinyinHanziEnglish => 'पिनयिन, हान्ज़ी या अर्थ खोजें...';

  @override
  String get liveTranslate => 'लाइव अनुवाद करें';

  @override
  String get travelInterpreter => 'यात्रा दुभाषिया';

  @override
  String get realTimeSplitScreen =>
      'मूल वक्ता के साथ वास्तविक समय में स्प्लिट-स्क्रीन बातचीत। भाषा की बाधाओं को तुरंत दूर करें।';

  @override
  String get whisperEarpiece => 'फुसफुसाहट इयरपीस';

  @override
  String get listenToChineseAudio =>
      'चीनी ऑडियो सुनें और अपनी स्क्रीन पर सीधे वास्तविक समय में हिंदी अनुवाद प्राप्त करें।';

  @override
  String get dashboardTitle => 'डैशबोर्ड';

  @override
  String get yourMindIsClear => 'आपका मन शांत और स्पष्ट है।';

  @override
  String get noReviewsDueToday => 'आज कोई समीक्षा बाकी नहीं है।';

  @override
  String get done => 'हो गया';

  @override
  String get hskLevel1 => 'HSK स्तर 1';

  @override
  String get hskLevel2 => 'HSK स्तर 2';

  @override
  String get hskLevel3 => 'HSK स्तर 3';

  @override
  String get hskLevel4 => 'HSK स्तर 4';

  @override
  String get hskLevel5 => 'HSK स्तर 5';

  @override
  String get hskLevel6 => 'HSK स्तर 6';

  @override
  String get generalVocabulary => 'सामान्य शब्दावली';

  @override
  String cardsRequireAttention(Object count) {
    return '$count कार्ड्स पर ध्यान देने की आवश्यकता है।';
  }

  @override
  String get begin => 'शुरू करें';

  @override
  String get poweredByAi =>
      'उन्नत AI द्वारा संचालित। किसी भी स्थिति के लिए सहज वास्तविक समय अनुवाद।';

  @override
  String get downloadingModel => 'मॉडल डाउनलोड हो रहा है...';

  @override
  String get soon => 'जल्द ही';

  @override
  String get installed => 'स्थापित';

  @override
  String get premium => 'प्रीमियम';

  @override
  String get coreModule => 'मुख्य मॉड्यूल';

  @override
  String get step6Context => 'चरण 6: संदर्भ';

  @override
  String get tapBuildingBlocksTo =>
      'उनके मूल को जानने के लिए बिल्डिंग ब्लॉक्स पर टैप करें।';

  @override
  String get initiateRadicalSequence => 'रेडिकल अनुक्रम प्रारंभ करें';

  @override
  String get holdToTalk => 'बात करने के लिए दबाकर रखें';

  @override
  String get customScenario => 'कस्टम परिदृश्य';

  @override
  String get voiceCall => 'वॉयस कॉल';

  @override
  String get pronunciation => 'उच्चारण';

  @override
  String get selectAScenarioTo =>
      'अपनी बोली जाने वाली मंदारिन का अभ्यास करने के लिए एक परिदृश्य चुनें। विद्वान आपके स्वर और स्पष्टता का मूल्यांकन करेंगे।';

  @override
  String get create => 'बनाएँ';

  @override
  String get createYourScenario => 'अपना परिदृश्य बनाएँ';

  @override
  String get difficulty => 'कठिनाई';

  @override
  String get scholarsVerdict => 'विद्वान का निर्णय';

  @override
  String get completeReview => 'समीक्षा पूर्ण करें';

  @override
  String get conversationReview => 'बातचीत की समीक्षा';

  @override
  String get linguisticAnalysis => 'भाषाई विश्लेषण';

  @override
  String get examplesInHsk1 => 'HSK 1 में उदाहरण';

  @override
  String get characterReference => 'वर्ण संदर्भ';

  @override
  String get askTutor => 'शिक्षक से पूछें';

  @override
  String get addToStudyDeck => 'अध्ययन डेक में जोड़ें';

  @override
  String get startPractice => 'अभ्यास शुरू करें';

  @override
  String get noOtherHsk1 =>
      'कोई अन्य HSK 1 वर्ण इस रेडिकल का उपयोग नहीं करता है।';

  @override
  String get couldNotLoadAi =>
      'AI संदर्भ लोड नहीं हो सका। (दर सीमा या नेटवर्क त्रुटि)\nबाद में पुनः प्रयास करने के लिए नीचे दिए गए रिफ्रेश बटन पर टैप करें।';

  @override
  String get noAvailableCardsFound => 'कोई उपलब्ध कार्ड नहीं मिला।';

  @override
  String get addCards => 'कार्ड जोड़ें';

  @override
  String get removeCard => 'कार्ड हटाएं';

  @override
  String get remove => 'हटाएं';

  @override
  String get review => 'समीक्षा';

  @override
  String get story => 'कहानी';

  @override
  String get thisDeckIsEmpty => 'यह डेक खाली है।';

  @override
  String get tapTheAddCards => 'कार्ड जोड़ें बटन पर टैप करें!';

  @override
  String get noCardsFound => 'कोई कार्ड नहीं मिला।';

  @override
  String get addCardsToSee => 'आँकड़े देखने के लिए कार्ड जोड़ें।';

  @override
  String get aiGenerated => 'AI द्वारा जनरेट किया गया';

  @override
  String get allCardsCaughtUp => 'सभी कार्ड कवर किए गए! बहुत बढ़िया काम।';

  @override
  String get latestDiscoveries => 'नवीनतम खोजें';

  @override
  String get noCharactersInLexicon => 'अभी तक शब्दकोश में कोई वर्ण नहीं हैं।';

  @override
  String get yourBookshelf => 'आपकी किताबों की अलमारी';

  @override
  String get text_1782026184579 => '字';

  @override
  String get searchYourDictionary => 'अपने शब्दकोश में खोजें...';

  @override
  String get saveCard => 'कार्ड सहेजें';

  @override
  String get noCharactersFound => 'कोई वर्ण नहीं मिला।';

  @override
  String get radicalsIndex => 'रेडिकल्स इंडेक्स';

  @override
  String get masteringRadicalsIsThe =>
      'रेडिकल में महारत हासिल करना हजारों हान्ज़ी को समझने की कुंजी है। इसका उपयोग करने वाले सभी वर्णों को देखने के लिए एक रेडिकल चुनें।';

  @override
  String get noRadicalsFound => 'कोई रेडिकल नहीं मिला।';

  @override
  String get yourDrawing => 'आपकी ड्राइंग';

  @override
  String get reference => 'संदर्भ';

  @override
  String get rateYourRecall => 'अपनी याददाश्त को रेट करें';

  @override
  String get contactUs => 'हमसे संपर्क करें';

  @override
  String get reportBugsOrRequest =>
      'बग की रिपोर्ट करें या सुविधाओं का अनुरोध करें';

  @override
  String get allDataHasBeen => 'सभी डेटा मिटा दिया गया है।';

  @override
  String get hanziMasterV100 => 'SinoSpark v1.0.0';

  @override
  String get myProgress => 'मेरी प्रगति';

  @override
  String get overview => 'अवलोकन';

  @override
  String get aiStory => 'AI कहानी';

  @override
  String get usingYourDecksVocabulary =>
      'आपके डेक की शब्दावली का उपयोग करते हुए';

  @override
  String get tryAgain => 'पुनः प्रयास करें';

  @override
  String get translate => 'अनुवाद करें';

  @override
  String get pinyin => 'पिनयिन';

  @override
  String get fullTranslation => 'पूर्ण अनुवाद';

  @override
  String get geminiFlashIsStructuring =>
      'Gemini Flash आपकी कहानी तैयार कर रहा है...';

  @override
  String get aiDeckGenerator => 'AI डेक जनरेटर';

  @override
  String get whatDoYouWant => 'आप क्या सीखना चाहते हैं?';

  @override
  String get targetDifficulty => 'लक्ष्य कठिनाई';

  @override
  String get focusArea => 'फोकस क्षेत्र';

  @override
  String get specificContextOrTone => 'विशिष्ट संदर्भ या शैली (वैकल्पिक)';

  @override
  String get numberOfCards => 'कार्डों की संख्या';

  @override
  String get generateDeck => 'डेक बनाएं';

  @override
  String get aiGrammarExplanation => 'AI व्याकरण स्पष्टीकरण';

  @override
  String get scholarsDesk => 'विद्वान की मेज';

  @override
  String get chooseADeck => 'एक डेक चुनें';

  @override
  String get whereWouldYouLike => 'आप इस वर्ण को कहाँ सहेजना चाहेंगे?';

  @override
  String whereWouldYouLikeWords(int count) {
    return 'आप इन $count शब्दों को कहाँ सहेजना चाहेंगे?';
  }

  @override
  String deckItemsCount(int count) {
    return '$count आइटम';
  }

  @override
  String get addToDefaultStudy => 'डिफ़ॉल्ट अध्ययन डेक में जोड़ें';

  @override
  String get ifOffItsOnly =>
      'यदि बंद किया गया है, तो यह केवल सामान्य शब्दकोश में सहेजा जाएगा';

  @override
  String get saveToLibrary => 'पुस्तकालय में सहेजें';

  @override
  String get pleaseEnterValidChinese => 'कृपया मान्य चीनी वर्ण दर्ज करें';

  @override
  String get reviewAiCard => 'AI कार्ड की समीक्षा करें';

  @override
  String get pleaseDoublecheckTheAis =>
      'कृपया नीचे AI के आउटपुट की दोबारा जाँच करें। इसे अपनी स्थायी लाइब्रेरी में सहेजने से पहले पिनयिन या परिभाषा को बदलने के लिए स्वतंत्र महसूस करें।';

  @override
  String get alreadyInYourLibrary => 'पहले से ही आपकी लाइब्रेरी में है!';

  @override
  String get meaningInContext => 'संदर्भ में अर्थ';

  @override
  String get explainGrammar => 'व्याकरण समझाएं';

  @override
  String get addToLibrary => 'पुस्तकालय में जोड़ें';

  @override
  String get masterYourMandarinPronunciation =>
      'वास्तविक समय में मूल उच्चारण का अनुकरण करके अपने मंदारिन उच्चारण में महारत हासिल करें।';

  @override
  String get startSession => 'सत्र शुरू करें';

  @override
  String get sessionHistory => 'सत्र इतिहास';

  @override
  String get noSavedSessions => 'कोई सहेजा गया सत्र नहीं है।';

  @override
  String get aiBreakdown => 'AI विश्लेषण';

  @override
  String get sessionDetails => 'सत्र विवरण';

  @override
  String partner(Object lang) {
    return 'साझेदार ($lang)';
  }

  @override
  String get youEnglish => 'आप (हिंदी)';

  @override
  String get noTranscriptToSave => 'सहेजने के लिए कोई ट्रांसक्रिप्ट नहीं है!';

  @override
  String get sessionSaved => 'सत्र सहेजा गया!';

  @override
  String get realtimeBidirectionalTranslationSpeak =>
      'वास्तविक समय में द्वि-दिशात्मक अनुवाद। हिंदी या मंदारिन बोलें, और यह आपके और आपके साथी के लिए तुरंत अनुवाद करेगा।';

  @override
  String get text_1782026184665 => 'रिकॉर्डिंग';

  @override
  String get recording => 'रिकॉर्डिंग';

  @override
  String get yourSilentCompanionListen =>
      'आपका शांत साथी। मंदारिन सुनें और तुरंत हिंदी अनुवाद प्राप्त करें।';

  @override
  String get startListening => 'सुनना शुरू करें';

  @override
  String get skip => 'छोड़ें';

  @override
  String get independentStars => 'स्वतंत्र सितारे';

  @override
  String get notEveryCharacterHas =>
      'हर वर्ण का एक मूल रेडिकल नहीं होता है। कुछ अद्वितीय पिक्टोग्राफ होते हैं या अपने आप में पूर्ण होते हैं।';

  @override
  String get onTheMapWe =>
      'मानचित्र पर, हम इन स्वतंत्र वर्णों को नक्षत्रों (✨) में समूहित करते हैं।';

  @override
  String get iUnderstand => 'समझ गया';

  @override
  String get whatAreRadicals => 'रेडिकल क्या हैं?';

  @override
  String get hanziAreBuiltFrom =>
      'हान्ज़ी बिल्डिंग ब्लॉक्स से बने होते हैं जिन्हें रेडिकल कहा जाता है।\n\nवे वर्ण को उसका मुख्य अर्थ या विषय देते हैं।';

  @override
  String get continueText => 'जारी रखें';

  @override
  String get hanziAreNotJust =>
      'हान्ज़ी केवल अक्षर नहीं हैं। वे समय में जमे हुए चित्र हैं।\n\nउनमें महारत हासिल करने के लिए, आपको उनके प्रवाह को समझना सीखना होगा।';

  @override
  String get iAmReady => 'मैं तैयार हूँ';

  @override
  String get youAreAScholar => 'आप एक विद्वान हैं';

  @override
  String get theGalaxyMapAwaitsnmaster =>
      'आकाशगंगा का नक्शा आपका इंतजार कर रहा है।\nग्रहों (वर्णों) को अनलॉक करने के लिए सूर्यों (रेडिकल्स) में महारत हासिल करें।';

  @override
  String get enterTheScroll => 'स्क्रॉल में प्रवेश करें';

  @override
  String get openingTheOriginScroll => 'उत्पत्ति स्क्रॉल खोला जा रहा है...';

  @override
  String get text_1782026184670 => '+';

  @override
  String get theScholarsEdition => 'विद्वान संस्करण';

  @override
  String get weArePreparingThe =>
      'हम विद्वान संस्करण को लॉन्च करने की तैयारी कर रहे हैं।';

  @override
  String get devBypassUnlockNow => 'डेवलपर बायपास: अभी अनलॉक करें';

  @override
  String get restorePurchases => 'खरीदारी बहाल करें';

  @override
  String get welcomeScholarTheScroll =>
      'स्वागत है, विद्वान। स्क्रॉल आपके लिए पूरी तरह खुला है।';

  @override
  String get purchasesRestoredSuccessfully => 'खरीदारी सफलतापूर्वक बहाल की गई।';

  @override
  String get noPreviousPurchasesFound =>
      'इस खाते पर कोई पिछली खरीदारी नहीं मिली।';

  @override
  String get unlockTheFullPotential =>
      'अपनी यात्रा की पूरी क्षमता को अनलॉक करें। एक बार की खरीदारी, हमेशा के लिए आपकी।';

  @override
  String get universalScanner => 'यूनिवर्सल स्कैनर';

  @override
  String get noChineseCharactersFound => 'छवि में कोई चीनी वर्ण नहीं मिला।';

  @override
  String get addedNewCharactersTo => 'आपकी लाइब्रेरी में नए वर्ण जोड़े गए!';

  @override
  String get extractingTextAndObjects =>
      'टेक्स्ट और वस्तुओं को निकाला जा रहा है...';

  @override
  String get scanATextbookSign =>
      'चीनी वर्णों को निकालने के लिए एक पाठ्यपुस्तक, साइनबोर्ड या वस्तु को स्कैन करें।';

  @override
  String get extractedText => 'निकाला गया टेक्स्ट';

  @override
  String get useText => 'टेक्स्ट का उपयोग करें';

  @override
  String get noMatchingDictionaryEntries =>
      'कोई मिलान वाली शब्दकोश प्रविष्टियां नहीं मिलीं।';

  @override
  String get quizComplete => 'क्विज़ पूर्ण!';

  @override
  String get returnToCourse => 'पाठ्यक्रम पर लौटें';

  @override
  String get notEnoughCardsFor =>
      'क्विज़ के लिए पर्याप्त कार्ड नहीं हैं! कम से कम 4 की आवश्यकता है।';

  @override
  String get creatorMode => 'क्रिएटर मोड';

  @override
  String get noStoriesFoundMatching =>
      'आपकी खोज से मेल खाने वाली कोई कहानी नहीं मिली।';

  @override
  String get discard => 'खारिज करें';

  @override
  String get save => 'सहेजें';

  @override
  String get generatingStoryViaDeepseek =>
      'DeepSeek के माध्यम से कहानी जनरेट हो रही है...';

  @override
  String get storySavedToLibrary => 'कहानी लाइब्रेरी में सहेजी गई!';

  @override
  String get storyNotFound => 'कहानी नहीं मिली।';

  @override
  String get targetHskLevel => 'लक्ष्य HSK स्तर';

  @override
  String get wedLoveToHear => 'हमें आपसे प्रतिक्रिया पाकर खुशी होगी!';

  @override
  String get whetherYouveFoundA =>
      'चाहे आपको कोई बग मिला हो, कोई सुविधा अनुरोध हो, या सिर्फ नमस्ते कहना चाहते हों, आपकी प्रतिक्रिया हमें SinoSpark को बेहतर बनाने में मदद करती है।';

  @override
  String get pointYourCameraAt => 'अपने कैमरे को वस्तुओं की ओर करें';

  @override
  String get reviewAddToLibrary => 'समीक्षा करें और लाइब्रेरी में जोड़ें';

  @override
  String hideStrokeGuideStreak(Object streak) {
    return 'स्ट्रोक गाइड छिपाएँ (स्ट्रीक: $streak)';
  }

  @override
  String inkPoints(Object points) {
    return '$points इंक पॉइंट्स';
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
  String get supportAndFeedback => 'सहायता और प्रतिक्रिया';

  @override
  String get reportBug => 'बग की रिपोर्ट करें';

  @override
  String get suggestFeature => 'सुविधा का सुझाव दें';

  @override
  String get generalFeedback => 'सामान्य प्रतिक्रिया';

  @override
  String get pleaseDrawSomethingFirst => 'कृपया पहले कुछ बनाएं';

  @override
  String get drawThisCharacter => 'यह वर्ण बनाएं:';

  @override
  String followGuideStroke(Object current, Object total) {
    return 'स्ट्रोक $current से $total बनाने के लिए नीले गाइड का पालन करें';
  }

  @override
  String get skipCurrentStroke => 'वर्तमान स्ट्रोक छोड़ें';

  @override
  String get submitDrawing => 'ड्राइंग सबमिट करें';

  @override
  String addedToDeck(Object deckName, Object hanzi) {
    return '$hanzi को $deckName में जोड़ा गया';
  }

  @override
  String removedFromDeck(Object hanzi) {
    return '$hanzi को डेक से हटाया गया';
  }

  @override
  String skippedNoStrokeData(Object hanzi) {
    return 'छोड़ा गया \"$hanzi\" - इस AI वर्ण के लिए स्ट्रोक डेटा उपलब्ध नहीं है।';
  }

  @override
  String get startingSession => 'सत्र शुरू हो रहा है...';

  @override
  String get studySession => 'अध्ययन सत्र';

  @override
  String get readyToStudy => 'अध्ययन के लिए तैयार';

  @override
  String get studyQueuePreviewDescription =>
      'आपका सत्र आज के शेड्यूल और डेक सीमाओं पर आधारित है।';

  @override
  String get notNow => 'अभी नहीं';

  @override
  String get newLabel => 'नया';

  @override
  String get studyDeckEmpty => 'यह डेक खाली है';

  @override
  String get studyDeckEmptyDescription =>
      'अध्ययन सत्र शुरू करने से पहले कार्ड जोड़ें।';

  @override
  String get studyDailyLimitReached => 'आज की सीमा पूरी हुई';

  @override
  String get studyDailyLimitReachedDescription =>
      'आपने आज के लिए इस डेक के नए कार्ड या समीक्षा की सीमा पूरी कर ली है।';

  @override
  String get studyCaughtUpDescription =>
      'आज के लिए और कुछ निर्धारित नहीं है। अगली समीक्षा के लिए वापस आएं।';

  @override
  String get noCardsAvailable => 'कोई कार्ड उपलब्ध नहीं हैं';

  @override
  String get studyNoEligibleCardsDescription =>
      'अभी इस अध्ययन मोड के लिए कोई कार्ड योग्य नहीं हैं।';

  @override
  String get studySessionLoadFailed =>
      'यह अध्ययन सत्र लोड करने में असमर्थ। कृपया पुनः प्रयास करें।';

  @override
  String get retryLimitReached => 'यह कार्ड आपके अगले सत्र में फिर से आएगा।';

  @override
  String get masterBuildingBlocks =>
      'हान्ज़ी के मूल तत्वों में महारत हासिल करें';

  @override
  String get totalWords => 'कुल शब्द';

  @override
  String get newInk => 'नई इंक';

  @override
  String get learningStatus => 'सीख रहे हैं';

  @override
  String get masteredStatus => 'महारत हासिल';

  @override
  String get libraryMastery => 'पुस्तकालय महारत';

  @override
  String get accuracyByMode => 'मोड के अनुसार सटीकता';

  @override
  String get upcomingReviews => 'आगामी समीक्षाएं (अगले 7 दिन)';

  @override
  String get culturalReadingRoom => 'सांस्कृतिक पठन कक्ष (文化书房)';

  @override
  String storyTitleHsk(Object level, Object title) {
    return '$title (HSK $level)';
  }

  @override
  String get pleaseEnterTopic => 'कृपया कोई विषय दर्ज करें';

  @override
  String createdDeckCards(Object count, Object name) {
    return '$name को $count कार्डों के साथ बनाया गया!';
  }

  @override
  String gradeResult(Object grade) {
    return 'ग्रेड: $grade';
  }

  @override
  String get listeningMode => 'सुनने का मोड';

  @override
  String get readingMode => 'पढ़ने का मोड';

  @override
  String get recallMode => 'स्मरण मोड';

  @override
  String get speakingMode => 'बोलने का मोड';

  @override
  String get aiMemoryHook => 'AI मेमोरी हुक (याद रखने की ट्रिक)';

  @override
  String get exampleSentences => 'उदाहरण वाक्य';

  @override
  String get ghostCharacters => 'गाइड वर्ण (घोस्ट कैरेक्टर)';

  @override
  String get commonWords => 'सामान्य शब्द';

  @override
  String get personalNotes => 'व्यक्तिगत नोट्स';

  @override
  String get addPersonalNotes => 'अपने स्मरणीय सूत्र या नोट्स यहाँ जोड़ें...';

  @override
  String get takePhoto => 'फोटो लें';

  @override
  String get gallery => 'गैलरी';

  @override
  String get arLens => 'AR लेंस';

  @override
  String addedCharToLibrary(Object char) {
    return '$char लाइब्रेरी में जोड़ा गया';
  }

  @override
  String get scoreText => 'स्कोर';

  @override
  String get searchDictionaryHint => 'वर्ण, पिनयिन या अर्थ खोजें...';

  @override
  String get searchDeckHint => 'वर्ण, पिनयिन खोजें...';

  @override
  String get localRestaurant => 'स्थानीय रेस्तरां';

  @override
  String get taxiToAirport => 'हवाई अड्डे के लिए टैक्सी';

  @override
  String get silkMarketHaggling => 'सिल्क मार्केट में मोलभाव';

  @override
  String get medicalClinic => 'चिकित्सा क्लिनिक';

  @override
  String get meetingAFriend => 'एक मित्र से मिलना';

  @override
  String get jobInterview => 'नौकरी का साक्षात्कार';

  @override
  String get searchRadicalsHint => 'रेडिकल खोजें (जैसे पानी, 氵)';

  @override
  String get definition => 'परिभाषा';

  @override
  String get undo => 'पूर्ववत करें';

  @override
  String get hanziMaster => 'SinoSpark';

  @override
  String get unlockForever => 'हमेशा के लिए अनलॉक करें - \$9.99';

  @override
  String get clear => 'साफ़ करें';

  @override
  String get clearChat => 'चैट साफ़ करें';

  @override
  String get typeMessage => 'अपना संदेश लिखें...';

  @override
  String addedToLibrary(Object hanzi) {
    return '$hanzi आपकी लाइब्रेरी में जोड़ा गया';
  }

  @override
  String get generateNewStory => 'नई कहानी जनरेट करें';

  @override
  String failedToGenerateStory(Object error) {
    return 'कहानी जनरेट करने में विफल रहे:\n$error';
  }

  @override
  String get detail => 'विवरण';

  @override
  String get scanText => 'टेक्स्ट स्कैन करें';

  @override
  String get createMagic => 'जादू बनाएं';

  @override
  String get learning => 'सीख रहे हैं';

  @override
  String get upcomingReviews7Days => 'आगामी समीक्षाएं (अगले 7 दिन)';

  @override
  String get askFollowUpQuestion => 'अनुवर्ती प्रश्न पूछें...';

  @override
  String get pasteScanToSimplify =>
      'सरल बनाने के लिए चीनी पाठ पेस्ट या स्कैन करें';

  @override
  String get searchStoriesHint =>
      'शीर्षक या टैग द्वारा कहानियाँ खोजें (जैसे पौराणिक कथा, यात्रा)';

  @override
  String get importAll => 'सभी आयात करें';

  @override
  String get ascendAll => 'सभी अपग्रेड करें';

  @override
  String get startAscension => 'सीखना शुरू करें';

  @override
  String get scenarioLocalRestaurant => 'स्थानीय रेस्तरां';

  @override
  String get scenarioLocalRestaurantDesc =>
      'व्यंजन ऑर्डर करने और सुझाव मांगने का अभ्यास करें।';

  @override
  String get scenarioTaxiAirport => 'हवाई अड्डा टैक्सी';

  @override
  String get scenarioTaxiAirportDesc =>
      'ड्राइवर को अपनी मंजिल बताएं और ट्रैफिक पर चर्चा करें।';

  @override
  String get scenarioSilkMarket => 'सिल्क मार्केट में मोलभाव';

  @override
  String get scenarioSilkMarketDesc =>
      'एक स्मारिका के लिए बेहतर कीमत पाने का प्रयास करें।';

  @override
  String get scenarioMedicalClinic => 'मेडिकल क्लिनिक';

  @override
  String get scenarioMedicalClinicDesc =>
      'एक पारंपरिक डॉक्टर को अपने लक्षण बताएं।';

  @override
  String get scenarioMeetingFriend => 'दोस्त से मिलना';

  @override
  String get scenarioMeetingFriendDesc =>
      'अपना परिचय दें और थोड़ी बहुत बात करें।';

  @override
  String get scenarioJobInterview => 'नौकरी का इंटरव्यू';

  @override
  String get scenarioJobInterviewDesc =>
      'शंघाई में एक टेक कंपनी में एक पद के लिए आवेदन करें।';

  @override
  String get createCustomScenario => 'कस्टम परिदृश्य बनाएं';

  @override
  String get customScenarioTitleHint => 'शीर्षक (उदा. शादी का रिसेप्शन)';

  @override
  String get customScenarioDescHint => 'विवरण (संदर्भ)';

  @override
  String get customScenarioPersonaHint =>
      'AI व्यक्तित्व (उदा. एक जिज्ञासु सहकर्मी)';

  @override
  String get customScenarioDifficulty => 'कठिनाई';

  @override
  String get createAction => 'बनाएं';

  @override
  String get cancelAction => 'रद्द करें';

  @override
  String get mythsAndLegends => 'मिथक और किंवदंतियाँ';

  @override
  String get historyAndCulture => 'इतिहास और संस्कृति';

  @override
  String get idiomsTitle => 'मुहावरे (成语)';

  @override
  String get theMonkeyKing => 'बंदर राजा (मंकी किंग)';

  @override
  String get theMonkeyKingDesc => 'सन वुकोंग (पश्चिम की यात्रा)';

  @override
  String get huaMulan => 'हुआ मुलान';

  @override
  String get huaMulanDesc =>
      'हुआ मुलान अपने पिता के स्थान पर सेना में शामिल हुईं';

  @override
  String get confuciusTitle => 'कन्फ्यूशियस';

  @override
  String get confuciusDesc => 'कन्फ्यूशियस का जीवन और शिक्षाएं';

  @override
  String get theGreatWall => 'चीन की महान दीवार';

  @override
  String get theGreatWallDesc => 'चीन की महान दीवार का निर्माण';

  @override
  String get generateTopic => 'विषय उत्पन्न करें';

  @override
  String get simplifyText => 'पाठ को सरल बनाएं';

  @override
  String get topicHint => 'विषय (उदा. बीजिंग में एलियंस)';

  @override
  String get tagsHint => 'टैग (कॉमा से अलग, वैकल्पिक)';

  @override
  String get speakWithMasterLin => 'मास्टर लिन से बात करें';

  @override
  String get masterLinGreeting =>
      'नमस्ते, छात्र। स्याही तैयार है। आज हम किस वर्ण या वाक्यांश का अध्ययन करेंगे?';

  @override
  String get typeYourMessage => 'अपना संदेश लिखें...';

  @override
  String get theMainLibrary => 'मुख्य पुस्तकालय';

  @override
  String get hsk1Foundation => 'HSK 1: बुनियादी';

  @override
  String get hsk2Elementary => 'HSK 2: प्रारंभिक';

  @override
  String get hsk3Intermediate => 'HSK 3: मध्यवर्ती';

  @override
  String get inDeckCheck => 'डेक में ✓';

  @override
  String get addToDeckPlus => '+ डेक में जोड़ें';

  @override
  String get openCardArrow => 'कार्ड खोलें →';

  @override
  String get pronunciationPartial => 'स्वर अस्पष्ट';

  @override
  String get pronunciationWrong => 'अशुद्ध';

  @override
  String get toneExpected => 'अपेक्षित';

  @override
  String get toneYouSaid => 'आपने कहा';

  @override
  String get gotIt => 'समझ गया!';

  @override
  String foundNCharacters(int count) {
    return '$count वर्ण मिले';
  }

  @override
  String get lookingUpCharacters => 'वर्ण खोजे जा रहे हैं…';

  @override
  String get practiceAll => 'सभी का अभ्यास करें';

  @override
  String get arLensObjects => 'वस्तुएं';

  @override
  String get arLensText => 'पाठ';

  @override
  String get arLensDetectedText => 'पहचाना गया पाठ';

  @override
  String get duration12Min => '1-2 मिनट';

  @override
  String get aClassicTangDynastyPoem => 'तांग राजवंश की एक शास्त्रीय कविता';

  @override
  String get aClassicTangDynastyPoemBy =>
      'तांग राजवंश की एक शास्त्रीय कविता, रचयिता:';

  @override
  String get aStructuralComponent => 'एक संरचनात्मक घटक।';

  @override
  String get addSelectedToDeck => 'चयनित को डेक में जोड़ें';

  @override
  String addTo(Object target) {
    return '$target में जोड़ें';
  }

  @override
  String addedHanziToYourLibrary(String hanzi) {
    return '«$hanzi» आपकी लाइब्रेरी में जोड़ा गया';
  }

  @override
  String get adjustFontSize => 'फ़ॉन्ट का आकार समायोजित करें';

  @override
  String get againGoodEasyHard => '⬅️ फिर से    ➡️ अच्छा    ⬆️ आसान    ⬇️ कठिन';

  @override
  String get aiAnalysisFailed => 'AI विश्लेषण विफल';

  @override
  String get aiIsThinking => 'AI सोच रहा है...';

  @override
  String get aiSceneAnalysisFailed => 'AI दृश्य विश्लेषण विफल';

  @override
  String get allLabel => 'सभी';

  @override
  String get allPinyin => 'सभी पिनयिन';

  @override
  String get alreadyHaveAccountSignIn => 'पहले से खाता है? साइन इन करें';

  @override
  String get analysisFailed => 'विश्लेषण विफल:';

  @override
  String get analyzingClassicalCharacters =>
      'शास्त्रीय वर्णों का विश्लेषण किया जा रहा है...';

  @override
  String get anatomy => 'शरीर रचना';

  @override
  String get ancientPhilosophy => 'प्राचीन दर्शन';

  @override
  String get warringStates => 'झगड़ते राज्य';

  @override
  String get hanFeiLegalism =>
      'हान फेई (लगभग 280-233 ईसा पूर्व) हान राज्य के एक राजकुमार थे और चीनी लीगलिज़्म (कानूनवाद) के प्रमुख विचारक थे। कानून, प्रशासनिक तकनीक और सत्ता के विचारों को एक साथ लाते हुए, \'हान फेइज़ी\' में उनके लेखन ने साम्राज्यवादी चीन के राजनीतिक दर्शन और संस्थानों को गहराई से प्रभावित किया।';

  @override
  String get articleSavedToMediaHub => 'लेख मीडिया हब में सहेजा गया!';

  @override
  String get askAFollowUp => 'एक अनुवर्ती प्रश्न पूछें...';

  @override
  String get audioPrivacyAndHowThingsWork => 'ऑडियो, गोपनीयता और कार्यप्रणाली';

  @override
  String get audiobookPlayer => 'ऑडियोबुक प्लेयर';

  @override
  String get audiobookVoice => 'ऑडियोबुक आवाज़';

  @override
  String get auntieMaTown =>
      'आंटी मा (马阿姨), एक ऊर्जावान स्टॉल मालिक जो शहर में सबसे कुरकुरी रौजियामो और लियांगपी बनाती हैं।';

  @override
  String get back => 'वापस';

  @override
  String get baristaKevinNotes =>
      'बरिस्ता केविन (小凯), एक उत्साही युवा कॉफ़ी रोस्टर जिन्हें युन्नान कॉफ़ी बीन्स और स्वाद के नोट्स पर चर्चा करना पसंद है।';

  @override
  String get bbc => 'बीबीसी चीनी';

  @override
  String get beginYourJourney => 'अपनी यात्रा शुरू करें';

  @override
  String get bestValue => 'सर्वोत्तम मूल्य';

  @override
  String get bookLinkCopiedToClipboard =>
      'पुस्तक का लिंक क्लिपबोर्ड पर कॉपी हो गया!';

  @override
  String get bookmarkChapter => 'अध्याय बुकमार्क करें';

  @override
  String get bookmarks => 'बुकमार्क';

  @override
  String get books => 'पुस्तकें';

  @override
  String get briefing => 'ब्रीफ़िंग';

  @override
  String get bugReport => 'बग रिपोर्ट';

  @override
  String get caoXueqinDecline =>
      'काओ ज़्यूचिन (लगभग 1715–1763) किंग राजवंश के उपन्यासकार थे। उनका जन्म एक समृद्ध परिवार में हुआ था जिसका भाग्य सम्राट योंगझेंग के समय ढह गया। \'लाल कक्ष का सपना\' (Dream of the Red Chamber), उनके अंतिम गरीबी के वर्षों में लिखा गया, चीनी गल्प साहित्य का शिखर माना जाता है।';

  @override
  String get cardsTitle => 'कार्ड';

  @override
  String get cc => 'उपशीर्षक (CC)';

  @override
  String get characterOrWord => 'वर्ण / शब्द';

  @override
  String get chatMore => 'और बातचीत करें';

  @override
  String get chefChenShumai =>
      'शेफ़ चेन (陈师傅), एक प्रसन्नचित्त कैंटोनीज़ डिम सम शेफ़ जो ताज़े हार गौ झींगा डंपलिंग और शुमाई की सिफारिश करते हैं।';

  @override
  String get chineseEpics => 'चीनी महाकाव्य';

  @override
  String get chinesePoetry => 'चीनी कविता';

  @override
  String get chng => 'chéng';

  @override
  String get chongqingSpicyHotpotFeast => 'चोंगकिंग मसालेदार हॉटपॉट दावत';

  @override
  String get chooseAudiobookVoice => 'ऑडियोबुक की आवाज़ चुनें';

  @override
  String get chooseVoice => 'आवाज़ चुनें';

  @override
  String get compare => 'तुलना करें';

  @override
  String get compare4Tones => '4 स्वरों की तुलना करें';

  @override
  String get configuration => 'कॉन्फ़िगरेशन';

  @override
  String get contemporary => 'समकालीन';

  @override
  String get context => 'संदर्भ';

  @override
  String get couldNotLoadLibrary => 'लाइब्रेरी लोड नहीं हो सकी';

  @override
  String get couldNotLoadVocabulary => 'शब्दावली लोड नहीं हो सकी।';

  @override
  String get couldNotOpenEmailApp => 'ईमेल ऐप नहीं खोला जा सका।';

  @override
  String get createAccount => 'खाता बनाएं';

  @override
  String get createNewDeck => 'नया डेक बनाएं';

  @override
  String get createScenario => 'परिदृश्य बनाएं';

  @override
  String get createStory => 'कहानी बनाएं';

  @override
  String get customLabel => 'कस्टम';

  @override
  String get customWord => 'कस्टम शब्द';

  @override
  String get days => 'दिन';

  @override
  String get deck => 'डेक';

  @override
  String get deckName => 'डेक का नाम';

  @override
  String get renameDeck => 'डेक का नाम बदलें';

  @override
  String get deckRenamed => 'डेक का नाम सफलतापूर्वक बदला गया';

  @override
  String get deckNameCannotBeEmpty => 'डेक का नाम खाली नहीं हो सकता';

  @override
  String get deckStory => 'डेक की कहानी';

  @override
  String get deepAnalysis => 'गहन विश्लेषण';

  @override
  String get defaultDeck => 'डिफ़ॉल्ट डेक';

  @override
  String get deleteLabel => 'हटाएं';

  @override
  String get deleteScenario => 'परिदृश्य हटाएं';

  @override
  String get deletesAllProgressPermanently =>
      'सभी प्रगति को स्थायी रूप से हटा देता है';

  @override
  String get developerBackdoorUnlocked => 'डेवलपर बैकडोर अनलॉक हो गया!';

  @override
  String get doesNotExistInChinese => 'चीनी भाषा में मौजूद नहीं है';

  @override
  String get dontHaveAccountSignUp => 'खाता नहीं है? साइन अप करें';

  @override
  String get draftingStoryOutline => 'कहानी की रूपरेखा तैयार की जा रही है...';

  @override
  String get dynamicFlowState => 'डायनामिक फ़्लो स्टेट';

  @override
  String get dynamicFlowStateParenthetical => 'डायनामिक (फ़्लो स्टेट)';

  @override
  String get editCard => 'कार्ड संपादित करें';

  @override
  String get egAnimeVocab => 'उदा. एनीमे शब्दावली';

  @override
  String get egFormalBusinessLanguageSlangForTexting =>
      'उदा. औपचारिक व्यावसायिक भाषा, चैटिंग स्लैंग...';

  @override
  String get egOrderingAtARestaurantBusinessVocab =>
      'उदा. रेस्तरां में ऑर्डर करना, व्यावसायिक शब्दावली...';

  @override
  String get egWeddingReceptionTechInterview =>
      'उदा. शादी का रिसेप्शन, तकनीकी साक्षात्कार...';

  @override
  String get emailLabel => 'ईमेल';

  @override
  String get english => 'अंग्रेज़ी';

  @override
  String get englishAndWorld => 'अंग्रेज़ी और विश्व';

  @override
  String get episodes => 'एपिसोड';

  @override
  String get erase => 'मिटाएं';

  @override
  String get eraseDeckQuestion => 'डेक मिटाएं?';

  @override
  String errorFetchingTranslationForLabelE(String label, String e) {
    return '$label के लिए अनुवाद लाने में त्रुटि: $e';
  }

  @override
  String errorLoadingMicroreadsE(String e) {
    return 'माइक्रो-रीड लोड करने में त्रुटि: $e';
  }

  @override
  String errorLoadingNovelsE(String e) {
    return 'उपन्यास लोड करने में त्रुटि: $e';
  }

  @override
  String errorLoadingPoetryE(String e) {
    return 'कविता लोड करने में त्रुटि: $e';
  }

  @override
  String get exitFocus => 'फ़ोकस मोड से बाहर निकलें';

  @override
  String get explore => 'खोजें';

  @override
  String get exportToThisDeck => 'इस डेक में निर्यात करें';

  @override
  String get extractAndSimplify => 'निकालें और सरल करें';

  @override
  String get failedToCreateDeck => 'डेक बनाने में विफल';

  @override
  String get failedToLoadDailyContent => 'दैनिक सामग्री लोड करने में विफल';

  @override
  String get failedToLoadEpisodes => 'एपिसोड लोड करने में विफल';

  @override
  String get failedToLoadShows => 'शो लोड करने में विफल';

  @override
  String get finalizingDetails => 'विवरण अंतिम रूप दिए जा रहे हैं...';

  @override
  String get finalizingStoryDetails =>
      'कहानी का विवरण अंतिम रूप दिया जा रहा है...';

  @override
  String get firebaseAuthConsole =>
      'Firebase Auth सक्षम नहीं है। कृपया अपने Firebase कंसोल में आवश्यक साइन-इन विधि सक्षम करें।';

  @override
  String get flashcardDeckTitle => 'फ़्लैशकार्ड डेक';

  @override
  String get focus => 'फ़ोकस';

  @override
  String get foodAndCooking => 'भोजन और पाक कला';

  @override
  String get forward => 'आगे';

  @override
  String get freeFlow => 'मुक्त प्रवाह';

  @override
  String get frenchClassics => 'फ़्रेंच क्लासिक्स';

  @override
  String get full => 'पूर्ण';

  @override
  String get gamingAndEsports => 'गेमिंग और ई-स्पोर्ट्स';

  @override
  String get germanClassics => 'जर्मन क्लासिक्स';

  @override
  String get ghostPinyin => 'गाइड पिनयिन';

  @override
  String get goodAttempt => 'अच्छा प्रयास';

  @override
  String get gotItSimple => 'समझ गया';

  @override
  String get grammar => 'व्याकरण';

  @override
  String get grandmaLiuFilling =>
      'दादी लियू (刘奶奶), उत्तरी चीन की एक स्नेही दादी जो आपको डंपलिंग की सिलवटें बनाना और पोर्क-हरी प्याज़ का भरावन तैयार करना सिखाती हैं।';

  @override
  String get great => 'बहुत बढ़िया!';

  @override
  String get handmadeDumplingFeastInHarbin =>
      'हार्बिन में हाथ से बनी डंपलिंग दावत';

  @override
  String get hanziCharacter => 'हान्ज़ी (वर्ण)';

  @override
  String get hapticFeedback => 'हैप्टिक फ़ीडबैक';

  @override
  String get helpAndSupport => 'सहायता और समर्थन';

  @override
  String get hidden => 'छिपा हुआ';

  @override
  String get hideEnglishTranslations => 'अंग्रेज़ी अनुवाद छिपाएं';

  @override
  String get hidePinyin => 'पिनयिन छिपाएं';

  @override
  String get highlight => 'हाइलाइट';

  @override
  String get howWouldYouLikeToStudy => 'आप कैसे अध्ययन करना चाहेंगे?';

  @override
  String get hsk1 => 'HSK 1';

  @override
  String get hsk4UpperIntermediate => 'HSK 4: उच्च-मध्यवर्ती';

  @override
  String get hsk5Advanced => 'HSK 5: उन्नत';

  @override
  String get hsk6Mastery => 'HSK 6: महारत';

  @override
  String get hskCollections => 'HSK संग्रह';

  @override
  String hskLevel(String level) {
    return 'HSK $level';
  }

  @override
  String get hskSimplifySubtitles => 'HSK उपशीर्षक सरलीकरण';

  @override
  String get hskVocabularyCollections => 'HSK शब्दावली संग्रह';

  @override
  String get i => 'मैं';

  @override
  String get ifTheAgain =>
      'अगर ट्रांसक्रिप्ट आपकी कही बात से मेल नहीं खाता, तो अपनी इच्छित पंक्ति चुनें और मूल रिकॉर्डिंग को दोबारा बोले बिना फिर से जाँचने के लिए “हाँ, फिर से अंक दें!” पर टैप करें।';

  @override
  String get install => 'इंस्टॉल करें';

  @override
  String get just => 'केवल \$';

  @override
  String get keyword => 'कीवर्ड';

  @override
  String get knowledgeBase => 'ज्ञानकोष';

  @override
  String get liRuzhenSubjects =>
      'ली रुझेन (लगभग 1763–1830) किंग राजवंश के एक विद्वान थे जिनकी ध्वनिविज्ञान, शतरंज और ब्रह्मांड विज्ञान में गहरी रुचि थी। उनका काल्पनिक उपन्यास \'आईने में फूल\' (Flowers in the Mirror) अपने नारीवादी विषयों और विश्वकोशीय दायरे के लिए प्रसिद्ध है।';

  @override
  String get libraryLabel => 'पुस्तकालय';

  @override
  String get lifestyleAndVlog => 'लाइफ़स्टाइल और व्लॉग';

  @override
  String get listenInAudiobookMode => 'ऑडियोबुक मोड में सुनें';

  @override
  String get listenToThisWord => 'यह शब्द सुनें';

  @override
  String get listening => 'सुन रहा है...';

  @override
  String get liuEEncroachment =>
      'लियू ए (1857–1909) उत्तर-किंग काल के बहुमुखी प्रतिभा के धनी विद्वान (इंजीनियर, डॉक्टर और उपन्यासकार) थे। उनका उपन्यास \'लाओ चान की यात्राएं\' (The Travels of Lao Can) राजवंशीय पतन के दौर में एक भटकते हुए चिकित्सक की यात्रा का सजीव चित्रण करता है।';

  @override
  String get loadingTranslations => 'अनुवाद लोड हो रहे हैं...';

  @override
  String get luXunVernacular =>
      'लू शुन (1881–1936), झोउ शुरेन का उपनाम, आधुनिक चीनी साहित्य के जनक हैं। समाज की कुरीतियों को उजागर करने के लिए उन्होंने अपनी कालजयी रचनाओं (\'एक पागल की डायरी\' और \'आह क्यू की सच्ची कहानी\') में बोलचाल की भाषा (बाईहुआ) का उपयोग किया।';

  @override
  String get luoGuanzhongEpic =>
      'लुओ गुआनझोंग (लगभग 1330–1400) युआन-मिंग संक्रमण काल के नाटककार और उपन्यासकार थे। उनका महाकाव्य \'तीन साम्राज्यों का रोमांस\' (Romance of the Three Kingdoms) ऐतिहासिक वृत्तांतों और लोक कथाओं का अनुपम संगम है।';

  @override
  String get makeACustomCollection => 'एक कस्टम संग्रह बनाएं';

  @override
  String get manageDailyDropsAndReviewReminders =>
      'दैनिक ड्रॉप्स और समीक्षा अनुस्मारक प्रबंधित करें';

  @override
  String get managerYuOptions =>
      'मैनेजर यू (余店长), एक ऊर्जावान हॉटपॉट रेस्तरां प्रबंधक जो ट्राइप, डक ब्लड और हल्के शोरबे के विकल्पों का सुझाव देती हैं।';

  @override
  String get masterGaoRubs =>
      'मास्टर गाओ (高师傅), एक करिश्माई चारकोल बारबेक्यू मास्टर जो ग्राहकों के साथ तीखेपन के स्तर और गुप्त जीरा मसालों के बारे में बातचीत करते हैं।';

  @override
  String get masterThisToUnlockItsGalaxy =>
      'इसकी आकाशगंगा को अनलॉक करने के लिए इसमें महारत हासिल करें।';

  @override
  String get masterZhaoBrewing =>
      'मास्टर झाओ (赵师傅), एक धैर्यवान और जानकार चाय विशेषज्ञ जिन्हें गोंगफू चाय बनाने की विधि समझाना पसंद है।';

  @override
  String get mastery => 'महारत';

  @override
  String get maybeLater => 'शायद बाद में';

  @override
  String get memes => 'मीम्स';

  @override
  String get midnightBbqSkewersInWuhan => 'वुहान में देर रात बारबेक्यू सीख';

  @override
  String get mo => '/माह';

  @override
  String get modernChinese => 'आधुनिक चीनी';

  @override
  String get monthly => 'मासिक';

  @override
  String get morningDimSumCartInGuangzhou =>
      'गुआंगज़ौ में सुबह की डिम सम गाड़ी';

  @override
  String get nameLabel => 'नाम';

  @override
  String get native => 'मूल वक्ता';

  @override
  String get newCard => 'नया कार्ड';

  @override
  String get newDeck => 'नया डेक';

  @override
  String get newDeckName => 'नए डेक का नाम';

  @override
  String get noActiveSubscriptionFound => 'कोई सक्रिय सदस्यता नहीं मिली।';

  @override
  String get noEpisodesFound => 'कोई एपिसोड नहीं मिला';

  @override
  String get noKeyWordsFoundForThisStory =>
      'इस कहानी के लिए कोई कीवर्ड नहीं मिला।';

  @override
  String get noLabel => 'नहीं';

  @override
  String get noNewWordsFound => 'कोई नया शब्द नहीं मिला!';

  @override
  String get noPinyin => 'पिनयिन नहीं';

  @override
  String get noPremiumPackagesAvailable =>
      'फ़िलहाल कोई प्रीमियम पैकेज उपलब्ध नहीं है।';

  @override
  String noResultsFoundForSearchquery(String searchQuery) {
    return '\'$searchQuery\' के लिए कोई परिणाम नहीं मिला';
  }

  @override
  String get noSavedArticlesYet => 'अभी तक कोई सहेजा गया लेख नहीं है।';

  @override
  String get noShowsAvailable => 'कोई शो उपलब्ध नहीं है';

  @override
  String get noStoriesFound => 'कोई कहानी नहीं मिली।';

  @override
  String get noWordsSelected => 'कोई शब्द नहीं चुना गया';

  @override
  String get notes => 'नोट्स';

  @override
  String get objectivesTitle => 'उद्देश्य';

  @override
  String get openInYoutube => 'YouTube में खोलें';

  @override
  String get orderingHanddripCoffeeInShanghai =>
      'शंघाई में फ़िल्टर कॉफ़ी ऑर्डर करना';

  @override
  String get orderingSugarcoatedHawsInWinterBeijing =>
      'सर्दियों के बीजिंग में तांगहुलु (कैंडीड हॉथॉर्न) ऑर्डर करना';

  @override
  String partnerLang(String lang) {
    return 'साथी ($lang)';
  }

  @override
  String get partnerListening => 'साथी सुन रहा है...';

  @override
  String get partnerSpeaking => 'साथी बोल रहा है...';

  @override
  String get passwordLabel => 'पासवर्ड';

  @override
  String get pause => 'रोकें';

  @override
  String get perfect => 'बिल्कुल सही!';

  @override
  String get personalizedPathBasedOnDeck =>
      'आपके डेक पर आधारित एक व्यक्तिगत शिक्षण पथ।';

  @override
  String get play => 'चलाएं';

  @override
  String get pleaseEnterMessageBeforeSending =>
      'कृपया भेजने से पहले एक संदेश लिखें।';

  @override
  String get practiceInRoleplay => 'रोलप्ले में अभ्यास करें';

  @override
  String get practiceModes => 'अभ्यास मोड';

  @override
  String get practicePronouncingWithAiGrading =>
      'AI मूल्यांकन के साथ इस शब्द के उच्चारण का अभ्यास करें';

  @override
  String get preparingReadingInterface =>
      'पठन इंटरफ़ेस तैयार किया जा रहा है...';

  @override
  String get privacy => 'गोपनीयता';

  @override
  String get privacyAndAudio => 'गोपनीयता और ऑडियो';

  @override
  String get aiDataPrivacyTitle => 'AI डेटा और गोपनीयता';

  @override
  String get aiDataPrivacySettingsSubtitle =>
      'देखें कि AI फ़ीचर क्या, क्यों और किसे भेजते हैं';

  @override
  String get aiDataPrivacyOverviewTitle => 'AI का उपयोग कब किया जाता है';

  @override
  String get aiDataPrivacyOverviewBody =>
      'SinoSpark क्लाउड AI का उपयोग केवल तब करता है जब आप कोई ऐसा फ़ीचर चुनते हैं जिसे इसकी आवश्यकता होती है, जैसे AI चैट, व्याख्याएं, अनुवाद, छवि विश्लेषण, वाक् पहचान, उच्चारण ग्रेडिंग, या क्लाउड आवाज़ें। AI परिणाम अशुद्ध हो सकते हैं, इसलिए महत्वपूर्ण परिणामों की समीक्षा करें।';

  @override
  String get aiDataPrivacyProvidersTitle => 'AI सेवा प्रदाता';

  @override
  String get aiDataPrivacyProvidersBody =>
      'Google Gemini जेनेरेटिव टेक्स्ट और इमेज अनुरोधों को प्रोसेस करता है। OpenRouter कुछ जेनेरेटिव अनुरोधों को Google Gemini या DeepSeek पर भेजता है। Microsoft Azure AI Speech वाक् पहचान, उच्चारण मूल्यांकन और क्लाउड वॉयस सिंथेसिस के लिए भेजे गए टेक्स्ट को प्रोसेस करता है।';

  @override
  String get aiDataPrivacySentTitle => 'डेटा जो भेजा जा सकता है';

  @override
  String get aiDataPrivacySentBody =>
      'फ़ीचर के आधार पर, हम आपके द्वारा दर्ज या चुने गए टेक्स्ट, प्रासंगिक बातचीत या पाठ संदर्भ, AI विश्लेषण के लिए चुनी गई छवियां, जमा की गई वॉयस रिकॉर्डिंग, और तकनीकी डेटा जैसे IP एड्रेस और डिवाइस/नेटवर्क मेटाडेटा भेजते हैं। हम जानबूझकर AI प्रॉम्प्ट में आपका नाम या ईमेल शामिल नहीं करते हैं।';

  @override
  String get aiDataPrivacyControlsTitle => 'आपके विकल्प';

  @override
  String get aiDataPrivacyControlsBody =>
      'यदि आप नहीं चाहते कि किसी AI फ़ीचर का इनपुट नामित प्रदाता को भेजा जाए, तो उसका उपयोग न करें। आप डिवाइस सेटिंग्स में कैमरा, फोटो या माइक की अनुमति अस्वीकार कर सकते हैं। अपने डिवाइस पर टेक्स्ट-टू-स्पीच रखने के लिए \'लोकल वॉयस\' चुनें। संवेदनशील या गोपनीय जानकारी सबमिट करने से बचें।';

  @override
  String get aiDataPrivacyRetentionTitle => 'संग्रहण और प्रतिधारण';

  @override
  String get aiDataPrivacyRetentionBody =>
      'SinoSpark प्रोसेसिंग के बाद अपने सर्वर पर मूल AI प्रॉम्प्ट, सबमिट की गई छवियों या वॉयस रिकॉर्डिंग को जानबूझकर स्टोर नहीं करता है। जनरेट किए गए परिणाम आपके डिवाइस या आपके खाते में सहेजे जा सकते हैं यदि आप उन्हें सहेजना चुनते हैं। प्रदाता अपनी शर्तों के तहत डेटा प्रोसेस करते हैं; विवरण के लिए पूर्ण नीति देखें।';

  @override
  String get readFullPrivacyPolicy => 'पूरी गोपनीयता नीति पढ़ें';

  @override
  String get linkOpenFailed => 'लिंक नहीं खोला जा सका। कृपया पुनः प्रयास करें।';

  @override
  String get puSonglingLiterature =>
      'पु सोंगलिंग (1640–1715) किंग राजवंश के लेखक थे जिन्होंने \'एक चीनी अध्ययन कक्ष की अजीबोगरीब कहानियां\' (Strange Tales from a Chinese Studio) का संकलन किया। उनकी आत्माओं और अलौकिक पात्रों की कहानियां चीनी गॉथिक साहित्य का मानक मानी जाती हैं।';

  @override
  String get qaFaq => 'प्रश्नोत्तर / FAQ';

  @override
  String get questsTitle => 'मिशन';

  @override
  String get quickBookmarks => 'त्वरित बुकमार्क';

  @override
  String get radical => 'रेडिकल';

  @override
  String get ready => 'तैयार';

  @override
  String get readyToInterpret => 'अनुवाद के लिए तैयार';

  @override
  String get readyToStart => 'शुरू करने के लिए तैयार।';

  @override
  String get recentBookmarks => 'हाल के बुकमार्क';

  @override
  String get refiningGrammar => 'व्याकरण को परिष्कृत किया जा रहा है...';

  @override
  String get refresh => 'रिफ़्रेश करें';

  @override
  String get removeFromSaved => 'सहेजे गए से हटाएं';

  @override
  String get removeFromSavedScenarios => 'सहेजे गए परिदृश्यों से हटाएं';

  @override
  String get removed => 'हटा दिया गया';

  @override
  String get requestPermissions => 'अनुमतियों का अनुरोध करें';

  @override
  String get rescind => 'रद्द करें';

  @override
  String get restore => 'पुनर्स्थापित करें';

  @override
  String get results => 'परिणाम';

  @override
  String get resume => 'जारी रखें';

  @override
  String get retry => 'पुनः प्रयास करें';

  @override
  String get revenuecatError => 'RevenueCat त्रुटि:';

  @override
  String revenuecatErrorE(String e) {
    return 'RevenueCat त्रुटि: $e';
  }

  @override
  String get reviewExtractedDeck => 'निकाले गए डेक की समीक्षा करें';

  @override
  String get reviewIn => 'में समीक्षा करें';

  @override
  String get reviewingYourTones => 'आपके स्वरों का मूल्यांकन किया जा रहा है...';

  @override
  String get saveAll => 'सभी सहेजें';

  @override
  String get saveScenario => 'परिदृश्य सहेजें';

  @override
  String get saveThisScenario => 'इस परिदृश्य को सहेजें';

  @override
  String get saved => 'सहेजा गया';

  @override
  String get scanAnother => 'एक और स्कैन करें';

  @override
  String get scenarioRemoved => 'परिदृश्य हटा दिया गया';

  @override
  String get scenarioSavedFindInCustomTab =>
      'परिदृश्य सहेजा गया! इसे कस्टम टैब में देखें।';

  @override
  String score(Object score, Object total) {
    return 'स्कोर: $score / $total';
  }

  @override
  String scoreValue(Object value) {
    return 'स्कोर: $value';
  }

  @override
  String get searchByPinyinOrMeaning => 'पिनयिन या अर्थ द्वारा खोजें...';

  @override
  String get searchByTitleOrTag => 'शीर्षक या टैग द्वारा खोजें...';

  @override
  String get searchDictionaryOrTypeCustom => 'शब्दकोश में खोजें या कस्टम लिखें';

  @override
  String get searchHint => 'खोजें...';

  @override
  String get searchOrEnterUrl => 'URL खोजें या दर्ज करें';

  @override
  String get searchScenariosHint => 'परिदृश्य खोजें...';

  @override
  String get searchStoriesIdiomsNews => 'कहानियां, मुहावरे, समाचार खोजें...';

  @override
  String get searchTopicsEgCookingHistory => 'विषय खोजें (उदा. भोजन, इतिहास)';

  @override
  String get seeAll => 'सभी देखें';

  @override
  String get selectADeck => 'एक डेक चुनें';

  @override
  String get selectPracticeMode => 'अभ्यास मोड चुनें';

  @override
  String get selectingHskVocabulary => 'HSK शब्दावली चुनी जा रही है...';

  @override
  String get send => 'भेजें';

  @override
  String get sendMessage => 'संदेश भेजें';

  @override
  String get serif => 'सेरिफ़';

  @override
  String get shadow => 'शैडोइंग';

  @override
  String get shiNaianEpic =>
      'शी नाइआन (लगभग 1296–1372) युआन राजवंश के लेखक थे। उनकी उत्कृष्ट कृति \'जल सीमांत\' (Water Margin) ने चीनी वीरगाथा परंपरा को स्थापित किया।';

  @override
  String get showEnglish => 'अंग्रेज़ी दिखाएं';

  @override
  String get showEnglishTranslations => 'अंग्रेज़ी अनुवाद दिखाएं';

  @override
  String get showHanzi => 'हान्ज़ी दिखाएं';

  @override
  String get showPinyin => 'पिनयिन दिखाएं';

  @override
  String get showTranslation => 'अनुवाद दिखाएं';

  @override
  String get shows => 'शो';

  @override
  String get signIn => 'साइन इन करें';

  @override
  String get simplifiedArticle => 'सरलीकृत लेख';

  @override
  String get simplifyingSubtitles => 'उपशीर्षक सरल किए जा रहे हैं...';

  @override
  String get sincereHonest => 'सच्चा और ईमानदार';

  @override
  String get sleepTimer => 'स्लीप टाइमर';

  @override
  String get smartDeck => 'स्मार्ट डेक';

  @override
  String get spanishAndWorld => 'स्पैनिश और विश्व';

  @override
  String get speaker => 'स्पीकर';

  @override
  String get spotifyStylePlayer => 'Spotify-शैली प्लेयर';

  @override
  String get storyBookmarkedInLibrary => 'कहानी लाइब्रेरी में बुकमार्क हो गई!';

  @override
  String get streetFoodNightMarketInXian =>
      'शी\'आन में स्ट्रीट फ़ूड नाइट मार्केट';

  @override
  String get strokes => 'स्ट्रोक';

  @override
  String get studyCharacter => 'वर्ण का अध्ययन करें';

  @override
  String get subtitleOpacity => 'उपशीर्षक अपारदर्शिता';

  @override
  String get suggestion => 'सुझाव';

  @override
  String get summary => 'सारांश';

  @override
  String get supernaturalAndFolklore => 'अलौकिक और लोककथाएं';

  @override
  String get swipeToGrade => 'रेट करने के लिए स्वाइप करें:';

  @override
  String get tableOfContents => 'विषय सूची';

  @override
  String get tapToRetry => 'पुनः प्रयास करने के लिए टैप करें';

  @override
  String get teaTastingInChengdu => 'चेंगदू में चाय चखना';

  @override
  String get techAndGadgets => 'तकनीक और गैजेट्स';

  @override
  String get terms => 'सेवा की शर्तें';

  @override
  String get theGalaxyCharacters =>
      'आकाशगंगा का नक्शा आपका इंतजार कर रहा है।\nग्रहों (वर्णों) को अनलॉक करने के लिए सूर्यों (रेडिकल्स) में महारत हासिल करें।';

  @override
  String get theme => 'थीम';

  @override
  String get thinking => 'सोच रहा है...';

  @override
  String get thisArticleCharacters =>
      'इस लेख में पारंपरिक चीनी वर्ण शामिल हैं।';

  @override
  String get todaysWord => 'आज का शब्द';

  @override
  String get togglePinyin => 'पिनयिन टॉगल करें';

  @override
  String get toggleTranslation => 'अनुवाद टॉगल करें';

  @override
  String get toneDoesNotExistInMandarin =>
      'यह स्वर मानक मंदारिन में मौजूद नहीं है।';

  @override
  String get toneGraph => 'स्वर ग्राफ़';

  @override
  String get toneGraphYourVoice => 'आपकी आवाज़';

  @override
  String get toneGraphTarget => 'लक्ष्य';

  @override
  String get toneGraphNoPitchMeasured =>
      'इस टेक में कोई पिच नहीं मापी गई, इसलिए आपकी आवाज़ के लिए खींचने को कुछ नहीं है। डैश वाला स्ट्रोक अभी भी वह आकार है जिसका आपने लक्ष्य रखा था।';

  @override
  String get toneGraphHowToReadPhraseNote =>
      'यहाँ डैश वाली रेखा वाक्यांश के स्वरों का आकार है, समान दूरी पर।\nहमें पता नहीं कि आपकी रिकॉर्डिंग में हर शब्दांश कहाँ से शुरू होता है, इसलिए आकार की तुलना करें, स्थिति की नहीं।';

  @override
  String get toneGraphHowToReadTitle => 'इस ग्राफ़ को कैसे पढ़ें';

  @override
  String get toneGraphHowToReadTooltip => 'इस ग्राफ़ को कैसे पढ़ें';

  @override
  String get toneGraphHowToReadBody =>
      'बाएँ से दाएँ समय है। ऊपर-नीचे आवाज़ की ऊँचाई है: आपकी आवाज़ कितनी ऊँची है, कितनी तेज़ नहीं।\nरेखा की दिशा पढ़ें, उसकी ऊँचाई नहीं: 1 ऊँचा और स्थिर · 2 चढ़ता हुआ · 3 नीचे झुकता हुआ · 4 ऊँचे से गिरता हुआ।\nपहली रेखा वह स्वर है जिसका आपने लक्ष्य रखा था; दूसरी रेखा तभी बनती है जब कोई भिन्न स्वर सुनाई दे।\nएक ही रेखा का अर्थ है कि आप लक्ष्य तक पहुँचे या स्वर मापा नहीं गया — कभी नहीं कि आप ग़लत थे।';

  @override
  String get traceLabel => 'ट्रेस करें';

  @override
  String get trailer => 'ट्रेलर';

  @override
  String get translatingAndAddingPinyin =>
      'अनुवाद और पिनयिन जोड़ा जा रहा है...';

  @override
  String get translatingText => 'पाठ का अनुवाद किया जा रहा है...';

  @override
  String get turnOn => 'चालू करें';

  @override
  String get typeHanziPinyinOrEnglish =>
      'हान्ज़ी, पिनयिन या अंग्रेज़ी लिखें...';

  @override
  String get unknown2 => '游戏 实况 王者荣耀 原神';

  @override
  String get unknown3 => '中国 美食 菜谱';

  @override
  String get unknown4 => '中国 科技 测评';

  @override
  String get unrollingTheScroll => 'स्क्रॉल खोला जा रहा है...';

  @override
  String get upperIntermediate => 'उच्च-मध्यवर्ती';

  @override
  String get vibrationsForInteractions => 'इंटरैक्शन के लिए कंपन';

  @override
  String get video => 'वीडियो';

  @override
  String get viewAnswer => 'उत्तर देखें';

  @override
  String get viewAsList => 'सूची के रूप में देखें';

  @override
  String get viewBookmarks => 'बुकमार्क देखें';

  @override
  String get viewMyDrawing => 'मेरी ड्राइंग देखें';

  @override
  String get vlog => 'चीनी दैनिक व्लॉग';

  @override
  String get voice => 'आवाज़:';

  @override
  String get web => 'वेब';

  @override
  String get wedLoveToHearFromYou => 'हमें आपसे\nसुनकर खुशी होगी।';

  @override
  String get welcomeBack => 'वापसी पर स्वागत है';

  @override
  String get whatDoesThisMean => 'इसका क्या अर्थ है?';

  @override
  String get whatHappensToMyChatHistory => 'मेरे चैट इतिहास का क्या होता है?';

  @override
  String get whatIfAiMishears =>
      'अगर AI मेरी बात का गलत अर्थ निकाले तो मैं क्या करूँ?';

  @override
  String get whichCharacterIs => 'यह कौन सा वर्ण है:';

  @override
  String get wikipedia => 'विकिपीडिया';

  @override
  String get wordsSavedAndSrsScheduled =>
      'शब्द सहेजे गए और SRS निर्धारित किया गया!';

  @override
  String get writeYourMessageHere => 'अपना संदेश यहाँ लिखें...';

  @override
  String get wuChengenLiterature =>
      'वू चेंग\'एन (लगभग 1500–1582) मिंग राजवंश के उपन्यासकार थे। उन्होंने तांग तीर्थयात्रा की पौराणिक कथाओं को \'पश्चिम की यात्रा\' (Journey to the West) में पिरोया, जो विश्व साहित्य की सबसे लोकप्रिय कृतियों में से एक है।';

  @override
  String get wuJingziClass =>
      'वू जिंगज़ी (1701–1754) किंग राजवंश के उपन्यासकार थे जिन्होंने \'द स्कॉलर्स\' (The Scholars - Rulin Waishi) लिखा। यह एक तीखा व्यंग्यात्मक उपन्यास है जो शाही परीक्षा प्रणाली और कुलीन वर्ग के आडंबर को उजागर करता है।';

  @override
  String get xuZhonglinWarfare =>
      'शू झोंगलिन (16वीं–17वीं शताब्दी) मिंग राजवंश के लेखक थे जिन्हें \'देवताओं का अलंकरण\' (Investiture of the Gods - Fengshen Yanyi) के संकलन का श्रेय दिया जाता है।';

  @override
  String get yearly => 'वार्षिक';

  @override
  String get yesReGradeMe => 'हाँ, मुझे फिर से रेट करें!';

  @override
  String you(Object lang) {
    return 'आप ($lang)';
  }

  @override
  String get youAreSpeaking => 'आप बोल रहे हैं';

  @override
  String get youLabel => 'आप';

  @override
  String youLang(String lang) {
    return 'आप ($lang)';
  }

  @override
  String get youMustAccount =>
      'खाता बनाने के लिए आपको सेवा की शर्तें और गोपनीयता नीति स्वीकार करनी होगी।';

  @override
  String get yourEchoModels =>
      'आपके द्वारा सेव किया गया रोलप्ले वार्तालाप इतिहास बाद में देखने के लिए आपके डिवाइस पर ही रहता है। हम आपकी निजी बातचीत का उपयोग अपने AI मॉडल को प्रशिक्षित करने के लिए नहीं करते।';

  @override
  String get zhOnly => 'केवल चीनी (ZH)';

  @override
  String get hsk_1300_cards => '1300 कार्ड';

  @override
  String get hsk_154_cards => '154 कार्ड';

  @override
  String get hsk_162_cards => '162 कार्ड';

  @override
  String get hsk_2500_cards => '2500 कार्ड';

  @override
  String get hsk_299_cards => '299 कार्ड';

  @override
  String get hsk_602_cards => '602 कार्ड';

  @override
  String get added_to_review_queue => 'समीक्षा कतार में जोड़ा गया';

  @override
  String added_cards_to(int cardCount, String deckName) {
    return '«$deckName» में $cardCount कार्ड जोड़े गए।';
  }

  @override
  String added_to_your_library(Object hanzi) {
    return '«$hanzi» आपकी लाइब्रेरी में जोड़ा गया';
  }

  @override
  String get advanced => 'उन्नत';

  @override
  String get ai_stories => 'AI कहानियाँ';

  @override
  String analysis_failed(Object error) {
    return 'विश्लेषण विफल: $error';
  }

  @override
  String get analyzing_pronunciation_with_gemini_ai =>
      'Gemini AI के साथ उच्चारण का विश्लेषण किया जा रहा है...';

  @override
  String get analyzing_your_pronunciation =>
      'आपके उच्चारण का विश्लेषण किया जा रहा है...';

  @override
  String are_you_sure_you_want_to(String deckName) {
    return 'क्या आप वाकई «$deckName» को स्थायी रूप से हटाना चाहते हैं? यह क्रिया पूर्ववत नहीं की जा सकती और इसके अंदर के सभी कार्ड हटा दिए जाएंगे।';
  }

  @override
  String ask_about(String hanzi) {
    return '$hanzi के बारे में पूछें...';
  }

  @override
  String get audio_haptics => 'ऑडियो और हैप्टिक्स';

  @override
  String get audio_could_not_start_check_your =>
      'ऑडियो शुरू नहीं हो सका। अपना कनेक्शन और डिवाइस की ऑडियो सेटिंग्स जांचें।';

  @override
  String get calligraphy_trace => 'सुलेख अनुरेखण';

  @override
  String chapters(Object count) {
    return '$count अध्याय';
  }

  @override
  String get char => 'वर्ण';

  @override
  String get chinese_character => 'चीनी वर्ण';

  @override
  String get contact_us_and_report_issues =>
      'हमसे संपर्क करें और समस्याओं की रिपोर्ट करें';

  @override
  String created_smart_deck_with_words(String deckName, int wordCount) {
    return 'स्मार्ट डेक बनाया गया: «$deckName» ($wordCount शब्दों के साथ)!';
  }

  @override
  String get custom_ai_generated_story => 'कस्टम AI जनरेट की गई कहानी।';

  @override
  String get display_content => 'प्रदर्शन और सामग्री';

  @override
  String get do_you_keep_or_store_my =>
      'क्या आप मेरी आवाज़ की रिकॉर्डिंग संग्रहीत करते हैं?';

  @override
  String get elementary => 'प्रारंभिक';

  @override
  String error_creating_scenario(Object error) {
    return 'परिदृश्य बनाने में त्रुटि: $error';
  }

  @override
  String error_fetching_translation_for(Object error) {
    return 'अनुवाद प्राप्त करने में त्रुटि: $error';
  }

  @override
  String error_loading_chapters(Object error) {
    return 'अध्याय लोड करने में त्रुटि: $error';
  }

  @override
  String get error_loading_decks => 'डेक लोड करने में त्रुटि';

  @override
  String error_loading_microreads(Object error) {
    return 'माइक्रो-रीड लोड करने में त्रुटि: $error';
  }

  @override
  String error_loading_novels(Object error) {
    return 'उपन्यास लोड करने में त्रुटि: $error';
  }

  @override
  String error_loading_poetry(Object error) {
    return 'कविता लोड करने में त्रुटि: $error';
  }

  @override
  String get etymology => 'व्युत्पत्ति (Etymology): ';

  @override
  String get explanation => 'स्पष्टीकरण';

  @override
  String get extracted_text_tap_to_lookup =>
      'निकाला गया पाठ (खोजने के लिए टैप करें)';

  @override
  String extraction_failed(Object error) {
    return 'निष्कर्षण विफल: $error';
  }

  @override
  String get failed_to_download => 'डाउनलोड विफल रहा।';

  @override
  String failed_to_generate_scenario(Object error) {
    return 'परिदृश्य जनरेट करने में विफल: $error';
  }

  @override
  String failed_to_generate_story(Object error) {
    return 'कहानी जनरेट करने में विफल:\n$error';
  }

  @override
  String failed_to_load_context(Object error) {
    return 'संदर्भ लोड करने में विफल: $error';
  }

  @override
  String get feature_request => 'सुविधा का अनुरोध';

  @override
  String get foundation => 'बुनियादी';

  @override
  String get how_is_my_pronunciation_scored =>
      'मेरे उच्चारण का मूल्यांकन कैसे किया जाता है?';

  @override
  String hsk(Object level) {
    return 'HSK $level';
  }

  @override
  String hsk_vocabulary(int hskLevel) {
    return 'HSK $hskLevel शब्दावली';
  }

  @override
  String get hsk_level => 'HSK स्तर';

  @override
  String get intermediate => 'मध्यवर्ती';

  @override
  String get learning_stats => 'अध्ययन आँकड़े';

  @override
  String get mandarin => 'मंदारिन';

  @override
  String get meaning => 'अर्थ';

  @override
  String get no_decks_found => 'कोई डेक नहीं मिला।';

  @override
  String no_results_found_for(Object searchQuery) {
    return '«$searchQuery» के लिए कोई परिणाम नहीं मिला';
  }

  @override
  String get no_when_you_use_echo_hall =>
      'उच्चारण आकलन के लिए भेजी गई रिकॉर्डिंग सुरक्षित रूप से प्रोसेस की जाती हैं और प्रोसेसिंग पूरी होने के बाद SinoSpark उन्हें नहीं रखता। आपके द्वारा सेव किया गया रोलप्ले इतिहास आपके डिवाइस पर रह सकता है और ऐप में हटाया जा सकता है।';

  @override
  String get notification_settings => 'सूचना सेटिंग्स';

  @override
  String get open_settings => 'सेटिंग्स खोलें';

  @override
  String get phoneme => 'स्वनिम (Phoneme)';

  @override
  String get play_reference_pronunciation => 'संदर्भ उच्चारण चलाएं';

  @override
  String get please_select_a_deck_to_add =>
      'कृपया कार्ड जोड़ने के लिए एक डेक चुनें।';

  @override
  String get point_at_chinese_text_to_translate =>
      'अनुवाद के लिए चीनी पाठ की ओर कैमरा करें';

  @override
  String get practice_writing_the_strokes_by_hand =>
      'हाथ से स्ट्रोक लिखने का अभ्यास करें';

  @override
  String get preferences_audio_and_display => 'प्राथमिकताएं, ऑडियो और प्रदर्शन';

  @override
  String get preparing_your_scholars_verdict =>
      'विद्वान का निर्णय तैयार किया जा रहा है...';

  @override
  String get previous => 'पिछला';

  @override
  String question(Object current, Object total) {
    return 'प्रश्न $current/$total';
  }

  @override
  String remove_from_this_deck(String hanzi) {
    return 'इस डेक से «$hanzi» को हटाएं?';
  }

  @override
  String revenuecat_error(Object error) {
    return 'RevenueCat त्रुटि: $error';
  }

  @override
  String get review_tomorrow => 'कल समीक्षा करें';

  @override
  String get roleplay => 'रोलप्ले';

  @override
  String saving_words_to(int wordCount, String deckName) {
    return '«$deckName» में $wordCount शब्द सहेजे जा रहे हैं...';
  }

  @override
  String get search_radicals_eg_water => 'रेडिकल खोजें (उदा. जल, 氵)';

  @override
  String get select_target_hsk_level => 'लक्ष्य HSK स्तर चुनें';

  @override
  String get sentence => 'वाक्य';

  @override
  String get shadowing_studio_is_a_dedicated_space =>
      'शैडोइंग स्टूडियो वास्तविक समय में मूल वक्ताओं के बोलने का अनुकरण करने का अभ्यास करने के लिए एक समर्पित सुविधा है।';

  @override
  String simplify_failed(Object error) {
    return 'सरलीकरण विफल: $error';
  }

  @override
  String get sinospark_premium => 'SinoSpark Premium';

  @override
  String get speaking_pronunciation => 'मौखिक अभिव्यक्ति और उच्चारण';

  @override
  String get statistics => 'आँकड़े';

  @override
  String get table_of_contents => 'विषय सूची · 目录';

  @override
  String get the_ai_evaluates_your_speech_across =>
      'AI तीन पैमानों पर आपके बोलने का मूल्यांकन करता है:\n• सटीकता: क्या आपने सही शब्दांश बोले?\n• पूर्णता: क्या आपसे कोई शब्द छूटा?\n• प्रवाह: क्या आपने स्वाभाविक विराम और सही स्वरों का उपयोग किया?\nयह 100 में से स्कोर देने के लिए आपके ऑडियो की तुलना मूल वक्ताओं से करता है।';

  @override
  String get this_cannot_be_undone => 'इसे पूर्ववत नहीं किया जा सकता।';

  @override
  String get title => 'शीर्षक';

  @override
  String get to_be_reviewed => 'समीक्षा हेतु बाकी';

  @override
  String get traditional => 'पारंपरिक';

  @override
  String translation_failed(Object error) {
    return 'अनुवाद विफल: $error';
  }

  @override
  String get type_in => 'टाइप करें...';

  @override
  String get type_your_message_in => 'अपना संदेश लिखें...';

  @override
  String get unable_to_open_this_video_please =>
      'यह वीडियो खोलने में असमर्थ। कृपया बाद में पुनः प्रयास करें।';

  @override
  String get view_your_learning_history_and_streaks =>
      'अपना अध्ययन इतिहास और स्ट्रीक्स देखें';

  @override
  String get what_is_shadowing_studio =>
      'शैडोइंग स्टूडियो (Shadowing Studio) क्या है?';

  @override
  String get words => 'शब्द';

  @override
  String your_path_for_is_ready(String deckName) {
    return '«$deckName» के लिए आपका मार्ग तैयार है!';
  }

  @override
  String get you_said => '🗣️ आपने कहा';

  @override
  String vocabularyBatch(Object index) {
    return 'शब्दावली बैच $index';
  }

  @override
  String get yourDailyDropIsHere => 'आपकी दैनिक खुराक यहाँ है! ✨';

  @override
  String get timeToReview => 'समीक्षा का समय! 📚';

  @override
  String get neverMissAStroke => 'कोई भी स्ट्रोक न चूकें! 🖌️';

  @override
  String get yourTrialEndsTomorrow => 'आपका ट्रायल कल समाप्त हो रहा है! ⏳';

  @override
  String get officialStandardVocabularyTiers => 'आधिकारिक मानक शब्दावली स्तर';

  @override
  String get failedToLoadCollections => 'संग्रह लोड करने में विफल।';

  @override
  String unnamedKey(Object tag) {
    return '#$tag';
  }

  @override
  String error(Object error) {
    return 'त्रुटि: $error';
  }

  @override
  String get aiSmartContext => 'AI स्मार्ट संदर्भ';

  @override
  String get aiSmartContextError => 'AI स्मार्ट संदर्भ त्रुटि';

  @override
  String get downloadOfficialHskCollections =>
      'आधिकारिक HSK संग्रह डाउनलोड करें';

  @override
  String get unableToLoadThisSection =>
      'इस अनुभाग को लोड करने में असमर्थ। कृपया पुनः प्रयास करें।';

  @override
  String get translationLanguage => 'अनुवाद भाषा';

  @override
  String get dailyDrops => 'दैनिक ड्रॉप्स';

  @override
  String get wordOfTheDayNews => 'आज का शब्द और समाचार';

  @override
  String get reviewReminders => 'समीक्षा अनुस्मारक';

  @override
  String get flashcardsDueForReview => 'समीक्षा के लिए बाकी फ्लैशकार्ड';

  @override
  String get dailyNewCards => 'दैनिक नए कार्ड';

  @override
  String get dailyReviewLimit => 'दैनिक समीक्षा सीमा';

  @override
  String get practiceMode => 'अभ्यास मोड';

  @override
  String get liziqi => 'ली ज़िछी (李子柒): रेशमी फूल';

  @override
  String get theLifeOfGarlicTraditional => 'लहसुन का जीवन: पारंपरिक चीनी जीवन';

  @override
  String get graceMandarin50Phrases => 'Grace Mandarin: 50 वाक्यांश';

  @override
  String get essentialChinesePhrasesForBeginners =>
      'शुरुआती लोगों के लिए आवश्यक चीनी वाक्यांश';

  @override
  String get makingBambooFurniture => 'बांस का फ़र्नीचर बनाना';

  @override
  String get peppaPigChinese => 'Peppa Pig चीनी: लुका-छिपी';

  @override
  String get muddyPuddlesBeginnerFriendly => 'कीचड़ भरे गड्ढे (शुरुआती स्तर)';

  @override
  String get mandarinCorner300Verbs => 'Mandarin Corner: 300 क्रियाएं';

  @override
  String get mostCommonChineseVerbs => 'सबसे आम चीनी क्रियाएं';

  @override
  String get graceMandarinOrderFood => 'Grace Mandarin: खाना ऑर्डर करें';

  @override
  String get howToOrderFoodIn => 'चीनी रेस्तरां में खाना कैसे ऑर्डर करें';

  @override
  String get silkFlowersTraditionalCraft => 'रेशमी फूल: पारंपरिक शिल्प';

  @override
  String get mandarinCorner =>
      'Mandarin Corner: चीनी सीखें - डॉक्टर के पास जाना';

  @override
  String get goingToTheDoctorReal =>
      'डॉक्टर के पास जाना: वास्तविक जीवन की बातचीत';

  @override
  String get hideAndSeekBeginnerFriendly => 'लुका-छिपी (शुरुआती स्तर)';

  @override
  String get linGdp6 => 'श्याओ लिन बताते हैं: GDP वृद्धि 6% क्यों?';

  @override
  String get why6GdpGrowthEasy => '6% GDP वृद्धि क्यों: सरल चीनी अर्थशास्त्र';

  @override
  String get bbcWorldNews => 'BBC 中文 (विश्व समाचार)';

  @override
  String get currentEventsInSimplifiedChinese =>
      'सरलीकृत चीनी में समसामयिक घटनाएं';

  @override
  String get baidu => 'Baidu';

  @override
  String get youtubeDesk => 'YOUTUBE डेस्क';

  @override
  String get interactiveTranscriptsShadowing =>
      'इंटरैक्टिव ट्रांसक्रिप्ट और शैडोइंग';

  @override
  String get showsDramas => 'शो और ड्रामा';

  @override
  String get extractToDeck => 'डेक में निकालें';

  @override
  String get autoSimplify => 'स्वतः सरल करें';

  @override
  String get rewriteThisArticleToMatch =>
      'इस लेख को अपने HSK स्तर के अनुसार फिर से लिखें';

  @override
  String failedToSaveExtractedWords(Object error) {
    return 'निकाले गए शब्दों को सहेजने में विफल: $error';
  }

  @override
  String addToDeck(Object count) {
    return 'डेक में जोड़ें ($count)';
  }

  @override
  String get dailyDiscoveryDrop => 'दैनिक खोज ड्रॉप';

  @override
  String get smartSpacedRepetition =>
      'स्मार्ट अंतराल पुनरावृत्ति (Spaced Repetition)';

  @override
  String get trialProtectionAlert => 'ट्रायल सुरक्षा अलर्ट';

  @override
  String get masteryLevel => 'महारत का स्तर';

  @override
  String get targetObjective => 'लक्ष्य';

  @override
  String get dailyPractice => 'दैनिक अभ्यास';

  @override
  String get aiSpacedRepetition => 'AI अंतराल पुनरावृत्ति';

  @override
  String get iVeGrantedAccess => 'मैंने अनुमति दे दी है';

  @override
  String get scanner => 'स्कैनर';

  @override
  String get interpreter => 'दुभाषिया';

  @override
  String cards(Object count) {
    return '$count कार्ड';
  }

  @override
  String get nWaMendsTheHeavens => 'नूवा आकाश की मरम्मत करती हैं';

  @override
  String get terracottaArmy => 'टेराकोटा सेना';

  @override
  String get forbiddenCity => 'फॉरबिडन सिटी (निषिद्ध शहर)';

  @override
  String get aBlessingInDisguise => 'आपदा में अवसर (छिपा हुआ वरदान)';

  @override
  String get drawingASnake => 'सांप के पैर बनाना (अनावश्यक कार्य करना)';

  @override
  String get takingTheBulletTrain => 'हाई-स्पीड बुलेट ट्रेन लेना';

  @override
  String get visitingTheDoctor => 'डॉक्टर के पास जाना';

  @override
  String get orderingDumplings => 'जियाओज़ी (डंपलिंग) ऑर्डर करना';

  @override
  String get theTeaCeremony => 'पारंपरिक चाय समारोह';

  @override
  String get chineseCalligraphy => 'चीनी सुलेख (कैलीग्राफी)';

  @override
  String get theGiantPanda => 'विशाल पांडा';

  @override
  String get simplifiedText => 'सरलीकृत पाठ';

  @override
  String get novels96 => 'उपन्यास (96)';

  @override
  String get microReads => 'माइक्रो-रीडिंग';

  @override
  String get poetry => 'कविता';

  @override
  String get bookmarkRemoved => 'बुकमार्क हटाया गया';

  @override
  String bookmarkAdded(Object chapter) {
    return 'बुकमार्क जोड़ा गया: अध्याय $chapter';
  }

  @override
  String get readingVocabulary => 'पठन और शब्दावली';

  @override
  String vocabularyBatchUnitindex1(Object index) {
    return 'शब्दावली बैच $index';
  }

  @override
  String get yourDailyDropIsHere1 => 'आपकी दैनिक ड्रॉप यहाँ है! ✨';

  @override
  String get timeToReview1 => 'समीक्षा का समय! 📚';

  @override
  String get neverMissAStroke1 => 'कोई भी स्ट्रोक न चूकें! 🖌️';

  @override
  String get yourTrialEndsTomorrow1 => 'आपका ट्रायल कल समाप्त हो रहा है! ⏳';

  @override
  String get hskCollections1 => 'HSK संग्रह';

  @override
  String get officialStandardVocabularyTiers1 => 'आधिकारिक मानक शब्दावली स्तर';

  @override
  String get failedToLoadCollections1 => 'संग्रह लोड करने में विफल।';

  @override
  String ui__transcription(Object transcription) {
    return '\"$transcription\"';
  }

  @override
  String playPinyinwithtone(Object pinyinWithTone) {
    return '$pinyinWithTone चलाएं';
  }

  @override
  String errorE(Object e) {
    return 'त्रुटि: $e';
  }

  @override
  String lookalikepinyin(Object pinyin) {
    return '($pinyin)';
  }

  @override
  String get aiSmartContext1 => 'AI स्मार्ट संदर्भ';

  @override
  String get aiSmartContextError1 => 'AI स्मार्ट संदर्भ त्रुटि';

  @override
  String errorErr(Object err, Object error) {
    return 'त्रुटि: $error';
  }

  @override
  String get downloadOfficialHskCollections1 =>
      'आधिकारिक HSK संग्रह डाउनलोड करें';

  @override
  String get unableToLoadThisSectionPleaseTryAga =>
      'इस अनुभाग को लोड करने में असमर्थ। कृपया पुनः प्रयास करें।';

  @override
  String get searchRadicalsEgWater => 'रेडिकल खोजें (उदा. जल, 氵)';

  @override
  String ui__currentstrokeindex1totalstrokes(Object current, Object total) {
    return '$current/$total';
  }

  @override
  String get translationLanguage1 => 'अनुवाद भाषा';

  @override
  String get appLanguage1 => 'ऐप भाषा';

  @override
  String get dailyDrops1 => 'दैनिक ड्रॉप्स';

  @override
  String get wordOfTheDayNews1 => 'आज का शब्द और समाचार';

  @override
  String get reviewReminders1 => 'समीक्षा अनुस्मारक';

  @override
  String get flashcardsDueForReview1 => 'समीक्षा के लिए बाकी फ्लैशकार्ड';

  @override
  String get accuracyByMode1 => 'मोड के अनुसार सटीकता';

  @override
  String accuracytostringasfixed1(Object accuracy) {
    return '$accuracy%';
  }

  @override
  String get upcomingReviewsNext7Days => 'आगामी समीक्षाएं (अगले 7 दिन)';

  @override
  String get explaining => 'व्याख्या:';

  @override
  String entryhanziEntrypinyin(Object hanzi, Object pinyin) {
    return '$hanzi [$pinyin]';
  }

  @override
  String get dailyNewCards1 => 'दैनिक नए कार्ड';

  @override
  String get dailyReviewLimit1 => 'दैनिक समीक्षा सीमा';

  @override
  String get listeningMode1 => 'सुनने का मोड';

  @override
  String get readingMode1 => 'पढ़ने का मोड';

  @override
  String get recallMode1 => 'स्मरण मोड';

  @override
  String get speakingMode1 => 'बोलने का मोड';

  @override
  String get practiceMode1 => 'अभ्यास मोड';

  @override
  String acc(Object acc) {
    return '$acc%';
  }

  @override
  String get partner1 => 'साझेदार';

  @override
  String get partnerSpeaking1 => 'साझेदार बोल रहा है…';

  @override
  String get theLifeOfGarlicTraditionalChineseLi =>
      'लहसुन का जीवन: पारंपरिक चीनी जीवन';

  @override
  String get graceMandarin50Phrases1 => 'Grace Mandarin: 50 वाक्यांश';

  @override
  String get essentialChinesePhrasesForBeginners1 =>
      'शुरुआती लोगों के लिए आवश्यक चीनी वाक्यांश';

  @override
  String get makingBambooFurniture1 => 'बांस का फ़र्नीचर बनाना';

  @override
  String get muddyPuddlesBeginnerFriendly1 => 'कीचड़ भरे गड्ढे (शुरुआती स्तर)';

  @override
  String get mandarinCorner300Verbs1 => 'Mandarin Corner: 300 क्रियाएं';

  @override
  String get mostCommonChineseVerbs1 => 'सबसे आम चीनी क्रियाएं';

  @override
  String get graceMandarinOrderFood1 => 'Grace Mandarin: खाना ऑर्डर करें';

  @override
  String get howToOrderFoodInAChineseRestaurant =>
      'चीनी रेस्तरां में खाना कैसे ऑर्डर करें';

  @override
  String get silkFlowersTraditionalCraft1 => 'रेशमी फूल: पारंपरिक शिल्प';

  @override
  String get goingToTheDoctorRealLifeConversatio =>
      'डॉक्टर के पास जाना: वास्तविक जीवन की बातचीत';

  @override
  String get hideAndSeekBeginnerFriendly1 => 'लुका-छिपी (शुरुआती स्तर)';

  @override
  String get lingdp6 => 'श्याओ लिन बताते हैं: GDP वृद्धि 6% क्यों?';

  @override
  String get why6GdpGrowthEasyChineseEconomics =>
      '6% GDP वृद्धि क्यों: सरल चीनी अर्थशास्त्र';

  @override
  String get currentEventsInSimplifiedChinese1 =>
      'सरलीकृत चीनी में समसामयिक घटनाएं';

  @override
  String get baidu1 => 'Baidu';

  @override
  String get youtubeDesk1 => 'YOUTUBE डेस्क';

  @override
  String get interactiveTranscriptsShadowing1 =>
      'इंटरैक्टिव ट्रांसक्रिप्ट और शैडोइंग';

  @override
  String get showsDramas1 => 'शो और ड्रामा';

  @override
  String error_error(Object error) {
    return 'त्रुटि: $error';
  }

  @override
  String get extractToDeck1 => 'डेक में निकालें';

  @override
  String get autosimplify => 'स्वतः सरल करें';

  @override
  String get rewriteThisArticleToMatchYourHskLev =>
      'इस लेख को अपने HSK स्तर के अनुसार फिर से लिखें';

  @override
  String get addToDeck1 => 'डेक में जोड़ें';

  @override
  String playbackratex(Object playbackRate) {
    return '${playbackRate}x';
  }

  @override
  String speedx(Object speed) {
    return '${speed}x';
  }

  @override
  String get dailyDiscoveryDrop1 => 'दैनिक खोज ड्रॉप';

  @override
  String get smartSpacedRepetition1 => 'स्मार्ट अंतराल पुनरावृत्ति';

  @override
  String get trialProtectionAlert1 => 'ट्रायल सुरक्षा अलर्ट';

  @override
  String get masteryLevel1 => 'महारत का स्तर';

  @override
  String get targetObjective1 => 'लक्ष्य';

  @override
  String get dailyPractice1 => 'दैनिक अभ्यास';

  @override
  String get aiSpacedRepetition1 => 'AI अंतराल पुनरावृत्ति';

  @override
  String get iveGrantedAccess => 'मैंने अनुमति दे दी है';

  @override
  String addToDeck_selectedwordindiceslength(Object count) {
    return 'डेक में जोड़ें ($count)';
  }

  @override
  String get scanner1 => 'स्कैनर';

  @override
  String get interpreter1 => 'दुभाषिया';

  @override
  String entryvalueCards(Object count) {
    return '$count कार्ड';
  }

  @override
  String score_score_questionslength(Object score, Object total) {
    return 'स्कोर: $score / $total';
  }

  @override
  String get theMonkeyKing1 => 'मंकी किंग (बंदर राजा)';

  @override
  String get huaMulan1 => 'हुआ मुलान';

  @override
  String get nwaMendsTheHeavens => 'नूवा आकाश की मरम्मत करती हैं';

  @override
  String get confucius => 'कन्फ्यूशियस';

  @override
  String get theGreatWall1 => 'चीन की महान दीवार';

  @override
  String get terracottaArmy1 => 'टेराकोटा सेना';

  @override
  String get forbiddenCity1 => 'फॉरबिडन सिटी (निषिद्ध शहर)';

  @override
  String get aBlessingInDisguise1 => 'आपदा में अवसर';

  @override
  String get drawingASnake1 => 'सांप के पैर बनाना';

  @override
  String get takingTheBulletTrain1 => 'हाई-स्पीड ट्रेन लेना';

  @override
  String get visitingTheDoctor1 => 'डॉक्टर के पास जाना';

  @override
  String get orderingDumplings1 => 'डंपलिंग ऑर्डर करना';

  @override
  String get theTeaCeremony1 => 'पारंपरिक चाय समारोह';

  @override
  String get chineseCalligraphy1 => 'चीनी सुलेख';

  @override
  String get theGiantPanda1 => 'विशाल पांडा';

  @override
  String get simplifiedText1 => 'सरलीकृत पाठ';

  @override
  String get novels961 => 'उपन्यास (96)';

  @override
  String get microreads => 'माइक्रो-रीडिंग';

  @override
  String get poetry1 => 'कविता';

  @override
  String get readingVocabulary1 => 'पठन और शब्दावली';

  @override
  String get defaultfirebaseoptionsHaveNotBeenCo =>
      'Linux के लिए DefaultFirebaseOptions कॉन्फ़िगर नहीं किए गए हैं।';

  @override
  String get defaultfirebaseoptionsAreNotSupport =>
      'इस प्लेटफ़ॉर्म के लिए DefaultFirebaseOptions समर्थित नहीं हैं।';

  @override
  String get hanziMaster1 => 'SinoSpark';

  @override
  String get strokesCannotBeEmpty => 'स्ट्रोक खाली नहीं हो सकते।';

  @override
  String get wrongStartPoint => 'गलत प्रारंभिक बिंदु।';

  @override
  String get rightShapeButWrongPlace => 'सही आकार, लेकिन गलत जगह!';

  @override
  String get goodFollowTheFlow => 'बहुत अच्छा! स्ट्रोक के प्रवाह का पालन करें।';

  @override
  String get aBitShaky => 'थोड़ा अस्थिर!';

  @override
  String get aBitHesitant => 'थोड़ा झिझक भरा...';

  @override
  String get shapeIsOff => 'आकार सही नहीं है।';

  @override
  String get arabic => 'अरबी';

  @override
  String get german => 'जर्मन';

  @override
  String get spanish => 'स्पैनिश';

  @override
  String get french => 'फ़्रेंच';

  @override
  String get hindi => 'हिंदी';

  @override
  String get indonesian => 'इंडोनेशियाई';

  @override
  String get italian => 'इतालवी';

  @override
  String get japanese => 'जापानी';

  @override
  String get korean => 'कोरियाई';

  @override
  String get portuguese => 'पुर्तगाली';

  @override
  String get russian => 'रूसी';

  @override
  String get vietnamese => 'वियतनामी';

  @override
  String get microphonePermissionDenied => 'माइक्रोफ़ोन अनुमति अस्वीकृत';

  @override
  String get offset => 'ऑफ़सेट';

  @override
  String get audioserviceHasBeenDisposed => 'AudioService बंद कर दी गई है';

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
  String get kore => 'Kore (स्त्रीलिंग, सौम्य)';

  @override
  String get xmicrosoftoutputformatAudio24khz48k =>
      'audio-24khz-48kbitrate-mono-mp3';

  @override
  String get useragentHanzimasterapp => 'HanziMasterApp';

  @override
  String get anchorWord => 'एंकर शब्द';

  @override
  String get creativeThematicTitle => 'रचनात्मक विषयगत शीर्षक';

  @override
  String get briefPedagogicalOrSemanticRationale =>
      'संक्षिप्त शैक्षणिक या अर्थ संबंधी तर्क';

  @override
  String get theSingleMostCentralCharacterFromTh => 'सूची का सबसे मुख्य वर्ण';

  @override
  String get aBalancedSetOfCharactersFromYourLib =>
      'आपकी लाइब्रेरी से वर्णों का एक संतुलित समूह।';

  @override
  String get yourNaturalConversationalReplyInChi =>
      'चीनी वर्णों में आपका स्वाभाविक संवादात्मक उत्तर।';

  @override
  String get theEnglishTranslationOfYourReply => 'आपके उत्तर का हिंदी अनुवाद।';

  @override
  String get thePinyinWithToneMarksForYourReply =>
      'आपके उत्तर के लिए टोन चिह्नों के साथ पिनयिन।';

  @override
  String get aSuggestedResponseTheUserCouldSayBa =>
      'एक सुझाया गया उत्तर जो उपयोगकर्ता कह सकता है।';

  @override
  String get pinyinForTheSuggestion => 'सुझाव के लिए पिनयिन।';

  @override
  String get englishTranslationForTheSuggestion => 'सुझाव के लिए हिंदी अनुवाद।';

  @override
  String get scholarsCritique => 'विद्वान की समीक्षा';

  @override
  String get theEchoHallRemainsSilentTryYourBrea =>
      'इको हॉल शांत है। एक गहरी सांस लें और पुनः प्रयास करें।';

  @override
  String get xtitleHanziMaster => 'SinoSpark';

  @override
  String get noneYet => 'अभी तक कोई नहीं।';

  @override
  String get exactSentence => 'सटीक वाक्य:';

  @override
  String get englishTranslation => 'हिंदी अनुवाद';

  @override
  String get previouslyGeneratedPhrases => 'पहले जनरेट किए गए वाक्यांश';

  @override
  String get iLikeDrinkingAppleJuice => 'मुझे सेब का जूस पीना पसंद है।';

  @override
  String get theEnglishMeaningHere => 'यहाँ अर्थ...';

  @override
  String get failedToFetchDefinition => 'परिभाषा प्राप्त करने में विफल।';

  @override
  String get failedToLoadExplanation => 'स्पष्टीकरण लोड करने में विफल।';

  @override
  String get failedToLoadComparison => 'तुलना लोड करने में विफल।';

  @override
  String get emptyResponseFromOpenrouter =>
      'OpenRouter से खाली प्रतिक्रिया प्राप्त हुई';

  @override
  String get emptyResponseFromVisionModel =>
      'विज़न मॉडल से खाली प्रतिक्रिया प्राप्त हुई';

  @override
  String get standard => 'मानक';

  @override
  String get theFullSentenceInChinese => 'चीनी में पूरा वाक्य...';

  @override
  String get theWordOrCharacterInChinese => 'चीनी में शब्द या वर्ण';

  @override
  String get thePinyinForThisSpecificWord => 'इस विशिष्ट शब्द के लिए पिनयिन';

  @override
  String get emptyResponseFromDeepseekApi =>
      'DeepSeek API से खाली प्रतिक्रिया प्राप्त हुई';

  @override
  String get criticalPutTheEnglishTranslationInT =>
      'महत्वपूर्ण: अनुवाद को इसमें रखें';

  @override
  String get englishTranslationOfTheEntireSenten =>
      'पूरे वाक्य का हिंदी अनुवाद';

  @override
  String get hanziWord => 'हान्ज़ी शब्द';

  @override
  String get theFullSimplifiedSentenceInChinese =>
      'चीनी में पूरा सरलीकृत वाक्य...';

  @override
  String get lyingFlatACulturalMovement =>
      'तांग पिंग (Tang Ping): एक सांस्कृतिक आंदोलन...';

  @override
  String get theUserYouAreSpeakingToIsNamed =>
      'जिस उपयोगकर्ता से आप बात कर रहे हैं उसका नाम है';

  @override
  String get importantRuleDoNotAddressTheUserByA =>
      'महत्वपूर्ण नियम: उपयोगकर्ता को किसी नाम से संबोधित न करें। कभी भी प्लेसहोल्डर नामों का उपयोग न करें जैसे';

  @override
  String get youAreAConciseChineseCalligraphyAnd =>
      'आप एक मोबाइल फ्लैशकार्ड ऐप में चीनी सुलेख और व्युत्पत्ति के सटीक ट्यूटर हैं।';

  @override
  String get theStudentIsStudyingTheCharacter =>
      'शिक्षार्थी इस वर्ण का अध्ययन कर रहा है';

  @override
  String get neverWriteIntroductionsSignoffsOrFi =>
      'कभी भी औपचारिक परिचय, समापन या अनावश्यक वाक्यांश न लिखें जैसे';

  @override
  String get beDirectAndInformative => 'सटीक और ज्ञानवर्धक रहें।';

  @override
  String get criticalRuleYouMustRespondEntirelyI =>
      'महत्वपूर्ण नियम: आपको ISO 639-1 कोड के अनुरूप भाषा में ही पूरा उत्तर देना होगा';

  @override
  String get youAreAConciseChineseGrammarTutorIn =>
      'आप एक मोबाइल ऐप में चीनी व्याकरण के सटीक ट्यूटर हैं।';

  @override
  String get theStudentIsConfusedAboutTheWord =>
      'शिक्षार्थी इस शब्द को लेकर भ्रमित है';

  @override
  String get neverWriteIntroductionsSignoffsOrFi1 =>
      'कभी भी परिचय, समापन या अनावश्यक वाक्यांश न लिखें।';

  @override
  String get azureSpeechApiKeysAreMissing =>
      'Azure Speech API कुंजियाँ मौजूद नहीं हैं।';

  @override
  String get success => 'सफलता';

  @override
  String get granularity => 'सूक्ष्मता (Granularity)';

  @override
  String get phoneme1 => 'स्वनिम (Phoneme)';

  @override
  String get dimension => 'आयाम';

  @override
  String get comprehensive => 'व्यापक';

  @override
  String get weCouldntHearYouClearlyPleaseTryAga =>
      'हम आपको स्पष्ट रूप से सुन नहीं पाए। कृपया पुनः प्रयास करें।';

  @override
  String get noNbestResultFound => 'कोई उपयुक्त पहचान परिणाम नहीं मिला।';

  @override
  String get words1 => 'शब्द';

  @override
  String get word => 'शब्द';

  @override
  String get phonemes => 'स्वनिम';

  @override
  String get syllables => 'शब्दांश';

  @override
  String get syllable => 'शब्दांश';

  @override
  String get omission => 'छूटा हुआ';

  @override
  String get insertion => 'अतिरिक्त जुड़ा हुआ';

  @override
  String get youMissedThisWord => 'आपने यह शब्द छोड़ दिया।';

  @override
  String get extraWordAddedHere => 'यहाँ अतिरिक्त शब्द जुड़ गया।';

  @override
  String get mispronunciation => 'अशुद्ध उच्चारण';

  @override
  String get pronunciationWasInaccurate => 'उच्चारण सटीक नहीं था।';

  @override
  String get goodEffortKeepPracticing => 'अच्छा प्रयास! अभ्यास जारी रखें।';

  @override
  String get perfectPronunciationSoundsLikeANati =>
      'शानदार उच्चारण! बिल्कुल मूल वक्ता जैसा।';

  @override
  String get greatJobAFewMinorToneInaccuracies =>
      'बहुत बढ़िया! कुछ मामूली टोन अशुद्धियां।';

  @override
  String get notBadButYourTonesNeedSomeWork =>
      'अच्छा प्रयास, लेकिन टोन पर थोड़ा और ध्यान देने की आवश्यकता है।';

  @override
  String get keepPracticingListenToTheNativeAudi =>
      'अभ्यास जारी रखें! मूल ऑडियो सुनें और दोबारा प्रयास करें।';

  @override
  String get lexical => 'शाब्दिक';

  @override
  String get chineseHanziHere => 'चीनी हान्ज़ी यहाँ';

  @override
  String get aShortSummaryInEnglish => 'एक संक्षिप्त सारांश';

  @override
  String get noCoherentChineseTextFoundInTheScan =>
      'स्कैन में कोई सुसंगत चीनी पाठ नहीं मिला।';

  @override
  String get theFullEnglishTranslationOfTheScann =>
      'स्कैन किए गए पाठ का पूरा अनुवाद... या \'कोई सुसंगत चीनी पाठ नहीं मिला।\'';

  @override
  String get aShort24WordTitleForThisScanEgResta =>
      'इस स्कैन के लिए 2-4 शब्दों का एक संक्षिप्त शीर्षक (उदा. \'रेस्तरां मेनू\', \'सड़क का बोर्ड\')';

  @override
  String get china => 'चीन';

  @override
  String get noTranslationAvailable => 'कोई अनुवाद उपलब्ध नहीं है।';

  @override
  String get scanResults => 'स्कैन परिणाम';

  @override
  String get whenWasItWrittenAndWhatWasHappening =>
      'यह कब लिखा गया था और उस समय चीन में क्या ऐतिहासिक पृष्ठभूमि थी?';

  @override
  String get whyIsThisPieceFamousWhatPhilosophic =>
      'यह रचना क्यों प्रसिद्ध है? यह किन दार्शनिक या सांस्कृतिक विषयों को छूती है?';

  @override
  String get aBriefBioOfTheAuthor => 'लेखक का संक्षिप्त परिचय।';

  @override
  String get informationUnavailable => 'जानकारी उपलब्ध नहीं है।';

  @override
  String get noSummaryAvailable => 'कोई सारांश उपलब्ध नहीं है।';

  @override
  String get hanziAiPro => 'SinoSpark AI Pro';

  @override
  String get trialNormalIntro => 'ट्रायल, सामान्य, परिचय';

  @override
  String get dailyDrop => 'दैनिक ड्रॉप';

  @override
  String get dailyNotificationsForWordOfTheDayAn =>
      'आज का शब्द और समाचार के लिए दैनिक सूचनाएं';

  @override
  String get aNewWordAndStoryOfTheDayAreWaitingF =>
      'आज का एक नया शब्द और कहानी आपका इंतजार कर रहे हैं!';

  @override
  String get spacedRepetition => 'अंतराल पुनरावृत्ति (Spaced Repetition)';

  @override
  String get remindersForFlashcardsDueForReview =>
      'समीक्षा के लिए बाकी फ्लैशकार्ड के अनुस्मारक';

  @override
  String get engagementReminders => 'सक्रियता अनुस्मारक';

  @override
  String get trialReminders => 'ट्रायल अनुस्मारक';

  @override
  String get notificationsForYourTrialStatus =>
      'आपके ट्रायल की स्थिति के लिए सूचनाएं';

  @override
  String get comeReviewYourHanziAndTryALiveCallB =>
      'अपने हान्ज़ी का अभ्यास करें और मुफ़्त एक्सेस समाप्त होने से पहले लाइव कॉल आज़माएं!';

  @override
  String get scholarsEye => 'विद्वान की दृष्टि';

  @override
  String get clMeasureWord => 'मापक शब्द (Classifier / CL):';

  @override
  String get surnameShi => 'उपनाम शि';

  @override
  String get chineseFamilyNameShi => 'चीनी पारिवारिक नाम (शि)';

  @override
  String get neutralToneLight => 'तटस्थ टोन (हल्का)';

  @override
  String get keepYourPitchHighAndSteadyLikeSingi =>
      'अपनी पिच को ऊंचा और स्थिर रखें जैसे कोई सुर साध रहे हों।';

  @override
  String get startInTheMiddleAndSlideYourPitchUp =>
      'मध्यम पिच से शुरू करें और सवाल पूछते हुए ऊपर ले जाएं, जैसे \'क्या?\'';

  @override
  String get dipYourVoiceDownLowThenRiseGentlyBa =>
      'अपनी आवाज़ को पहले नीचे ले जाएं, फिर धीरे से वापस ऊपर उठाएं।';

  @override
  String get dropYourPitchSharplyAndDecisivelyLi =>
      'अपनी पिच को तेजी से और दृढ़ता से नीचे गिराएं, जैसे \'नहीं!\' कहना हो।';

  @override
  String get pronounceSoftlyBrieflyAndWithoutEmp =>
      'हल्के, संक्षिप्त और बिना किसी जोर के उच्चारण करें।';

  @override
  String get spotOnPitchWasHighFlatAndSteady =>
      'बिल्कुल सही! पिच ऊंची, सपाट और स्थिर थी।';

  @override
  String get spotOnUpwardPitchRiseWasClear =>
      'बिल्कुल सही! ऊपर की ओर टोन का चढ़ाव स्पष्ट था।';

  @override
  String get spotOnLowDippingCurveWasAccurate =>
      'बिल्कुल सही! नीचे झुककर ऊपर उठने वाला वक्र सटीक था।';

  @override
  String get spotOnSharpFallingDropWasDecisive =>
      'बिल्कुल सही! तीखा और गिरता हुआ टोन सटीक था।';

  @override
  String get spotOnToneWasPronouncedAccurately =>
      'बिल्कुल सही! टोन का उच्चारण सटीक था।';

  @override
  String get iAgreeToTheTermsOfServiceAndPrivacy =>
      'मैं सेवा की शर्तों और गोपनीयता नीति से सहमत हूँ।';

  @override
  String get sendMeOccasionalUpdatesTipsAndOffer =>
      'मुझे सामयिक अपडेट, सुझाव और ऑफ़र भेजें।';

  @override
  String get signInToSyncYourProgress =>
      'अपनी सीखने की प्रगति सिंक करने के लिए साइन इन करें।';

  @override
  String get createAnAccountToSaveYourStats =>
      'अपने आंकड़े सहेजने के लिए एक खाता बनाएं।';

  @override
  String get smartSpiral => 'स्मार्ट स्पाइरल';

  @override
  String get origin => 'मूल';

  @override
  String get elements => 'प्राकृतिक तत्व';

  @override
  String get humanity => 'मानव और समाज';

  @override
  String get village => 'ग्राम्य जीवन';

  @override
  String get journey => 'यात्रा';

  @override
  String get city => 'नगर और वाणिज्य';

  @override
  String get originTheSimplestShapesTheBeginning =>
      'सबसे सरल आकृतियां। सभी चीजों की शुरुआत।';

  @override
  String get elementsSunMoonWaterAndFireTheNatur =>
      'सूर्य, चंद्रमा, जल और अग्नि। प्राकृतिक संसार।';

  @override
  String get humanityTheBodyTheHeartAndTheFamily => 'शरीर, हृदय और परिवार।';

  @override
  String get villageFieldsRoofsAndToolsTheFounda =>
      'खेत, छतें और औजार। समाज की नींव।';

  @override
  String get journeyMovementSpeechAndSustenance => 'गति, वाणी और पोषण।';

  @override
  String get cityCommerceClothingAndComplexArtif =>
      'व्यापार, वस्त्र और जटिल कलाकृतियां।';

  @override
  String get equilibriumAlgorithm => 'संतुलन एल्गोरिदम';

  @override
  String get misc => 'विविध';

  @override
  String get cityOrOriginAs => '«शहर» या «मूल» के रूप में';

  @override
  String get miscToOrigin => '«विविध» से «मूल» तक';

  @override
  String get constellation => 'नक्षत्र समूह';

  @override
  String get whichOneIsWater => 'इनमें से \'जल\' कौन सा है?';

  @override
  String get whatIsThePinyin => 'इसका पिनयिन क्या है?';

  @override
  String get nature => 'प्रकृति';

  @override
  String get whatEssenceDoes => 'क्या सार रखता है';

  @override
  String get allTiers => 'सभी स्तर';

  @override
  String get active => 'सक्रिय';

  @override
  String get theScrollOfOrigin1 => 'उत्पत्ति का स्क्रॉल';

  @override
  String galaxyOf1(Object name) {
    return '$name की आकाशगंगा';
  }

  @override
  String get also => 'भी';

  @override
  String get work => 'कार्य';

  @override
  String get cloud => 'बादल';

  @override
  String get youArchaic => 'तुम (पुरातन)';

  @override
  String get suddenly => 'अचानक';

  @override
  String get owner => 'स्वामी';

  @override
  String get door => 'दरवाज़ा';

  @override
  String get occupy => 'अधिकार करना';

  @override
  String get nail => 'कील';

  @override
  String get and => 'और';

  @override
  String get buddhistNun => 'बौद्ध भिक्षुणी';

  @override
  String get anxious => 'चिंतित';

  @override
  String get sprout => 'अंकुर';

  @override
  String get exchange => 'आदान-प्रदान';

  @override
  String get sheep => 'भेड़';

  @override
  String get strange => 'विचित्र';

  @override
  String get opposite => 'विपरीत';

  @override
  String get shorttailedBird => 'छोटी पूंछ वाला पक्षी';

  @override
  String get shoot => 'अंकुर / प्ररोह';

  @override
  String get small => 'छोटा';

  @override
  String get gather => 'एकत्र करना';

  @override
  String get order => 'क्रम';

  @override
  String get flat => 'सपाट';

  @override
  String get thePersonWho => 'वह व्यक्ति जो...';

  @override
  String get nobleman => 'सज्जन / कुलीन';

  @override
  String get cause => 'कारण';

  @override
  String get pig => 'सूअर';

  @override
  String get bright => 'उज्ज्वल';

  @override
  String get slowly => 'धीरे-धीरे';

  @override
  String get give => 'देना';

  @override
  String get arrow => 'तीर';

  @override
  String get dry => 'सूखा';

  @override
  String get obstacle => 'बाधा';

  @override
  String get beg => 'याचना करना';

  @override
  String get window => 'खिड़की';

  @override
  String get fear => 'भय';

  @override
  String get drum => 'ढोल';

  @override
  String get why => 'क्यों';

  @override
  String get talent => 'प्रतिभा';

  @override
  String get follow => 'अनुसरण करना';

  @override
  String get desert => 'रेगिस्तान';

  @override
  String get component => 'घटक';

  @override
  String divingInto1(Object topic) {
    return '$topic में प्रवेश';
  }

  @override
  String get unitIntro1 => 'यूनिट परिचय';

  @override
  String get theBlueprint => 'ब्लूप्रिंट (खाका)';

  @override
  String get theOrigin => 'उत्पत्ति';

  @override
  String get theGalaxy => 'आकाशगंगा';

  @override
  String get theScholarListens => 'विद्वान सुन रहे हैं...';

  @override
  String get consultingTheScrolls => 'प्राचीन ग्रंथों का अवलोकन...';

  @override
  String get traceWithTheGuide => 'मार्गदर्शन रेखा के साथ ट्रेस करें';

  @override
  String get traceTheGhost => 'हल्की रेखा के ऊपर ट्रेस करें';

  @override
  String get connectTheDots => 'बिंदुओं को जोड़ें';

  @override
  String get drawFromMemory => 'याददाश्त से बनाएं';

  @override
  String get assistant => 'सहायक';

  @override
  String get puck => 'Puck (पुल्लिंग, स्पोर्टी)';

  @override
  String get helloWelcomeWhatWouldYouLikeToOrder =>
      'नमस्ते! स्वागत है। आप क्या ऑर्डर करना चाहेंगे?';

  @override
  String get ni3Hao3Huan1ying2Guang1lin2Qing3wen =>
      'Nǐ hǎo! Huānyíng guānglín. Qǐngwèn nǐ yào diǎn shénme?';

  @override
  String get waiterLi => 'वेटर ली';

  @override
  String get askForTheMenu => 'मेनू मांगें';

  @override
  String get orderOneDishAndOneDrink => 'एक व्यंजन और एक पेय ऑर्डर करें';

  @override
  String get askForTheBill => 'बिल मांगें';

  @override
  String get fenrir => 'Fenrir (पुल्लिंग, ऊर्जावान)';

  @override
  String get ni3Qu4Na3rAJi1chang3MaTing3Yuan3De =>
      'Nǐ qù nǎr a? Jīchǎng ma? Tǐng yuǎn de!';

  @override
  String get driverWang => 'ड्राइवर वांग';

  @override
  String get tellTheDriverYouAreGoingToTheAirpor =>
      'ड्राइवर को बताएं कि आपको हवाई अड्डे जाना है';

  @override
  String get askHowLongTheTripWillTake => 'पूछें कि रास्ते में कितना समय लगेगा';

  @override
  String get complainAboutTheTraffic => 'ट्रैफ़िक की स्थिति पर बात करें';

  @override
  String get charon => 'Charon (पुल्लिंग, समाचार शैली)';

  @override
  String get thisClothingQualityIsEspeciallyGood =>
      'इस पोशाक की गुणवत्ता बहुत अच्छी है, केवल 200 कुआई।';

  @override
  String get zhe4Jian4Yi1fuZhi4liang4Te4bie2Hao3 =>
      'Zhè jiàn yīfu zhìliàng tèbié hǎo, zhǐyào liǎng bǎi kuài.';

  @override
  String get auntieChen => 'आंटी चेन';

  @override
  String get askHowMuchTheSilkShirtCosts =>
      'पूछें कि रेशमी कमीज़ की कीमत कितनी है';

  @override
  String get sayItIsTooExpensive => 'कहें कि यह बहुत महंगा है';

  @override
  String get bargainThePriceDownTo100Rmb =>
      'कीमत 100 RMB तक घटाने के लिए मोलभाव करें';

  @override
  String get ni3Na3li3Bu4Shu1fuFa1shao1LeMa =>
      'Nǐ nǎlǐ bù shūfu? Fāshāo le ma?';

  @override
  String get drZhang => 'डॉ. झांग';

  @override
  String get explainYouHaveHadAHeadacheForTwoDay =>
      'बताएं कि आपको दो दिन से सिरदर्द हो रहा है';

  @override
  String get sayYouHaveASlightFever => 'बताएं कि आपको हल्का बुखार है';

  @override
  String get askIfYouNeedToTakeMedicine => 'पूछें कि क्या दवा लेने की जरूरत है';

  @override
  String get aoede => 'Aoede (स्त्रीलिंग, प्रफुल्लित)';

  @override
  String get heyLongTimeNoSeeHowHaveYouBeenLatel =>
      'अरे! बहुत दिनों बाद मिले, आजकल आपका क्या हाल-चाल है?';

  @override
  String get ni3Hao3Hao3jiu3Bu4jian4Ni3Zui4jin4Z =>
      'Nǐ hǎo! Hǎojiǔ bùjiàn, nǐ zuìjìn zěnmeyàng?';

  @override
  String get pleaseIntroduceYourselfWhyDoYouWant =>
      'कृपया अपना परिचय दें। आप हमारी कंपनी में क्यों काम करना चाहते हैं?';

  @override
  String get qing3Xian1Zi4wo3Jie4shao4Yi1xia4Ni3 =>
      'Qǐng xiān zìwǒ jièshào yíxià. Nǐ wèishénme xiǎng lái wǒmen gōngsī gōngzuò?';

  @override
  String get managerLiu => 'मैनेजर लियू';

  @override
  String get introduceYourProfessionalBackground =>
      'संक्षेप में अपनी पेशेवर पृष्ठभूमि बताएं';

  @override
  String get explainWhyYouWantToWorkAtThisCompan =>
      'बताएं कि आप इस कंपनी में क्यों काम करना चाहते हैं';

  @override
  String get askAPoliteQuestionAboutTheCompanyCu =>
      'कंपनी की संस्कृति के बारे में एक विनम्र प्रश्न पूछें';

  @override
  String get microphoneAccessIsRequiredPleaseEna =>
      'माइक्रोफ़ोन एक्सेस आवश्यक है। कृपया इसे अपने डिवाइस की सेटिंग्स में सक्षम करें।';

  @override
  String get couldNotStartMicrophonePleaseCheckY =>
      'माइक्रोफ़ोन शुरू नहीं हो सका। कृपया अपनी ऑडियो सेटिंग्स जांचें और पुनः प्रयास करें।';

  @override
  String get weDidntQuiteCatchThatPleaseHoldTheM =>
      'हम ठीक से सुन नहीं पाए। कृपया माइक बटन दबाकर रखें और पुनः प्रयास करें!';

  @override
  String get recordingWasTooShortHoldTheMicAndSp =>
      'रिकॉर्डिंग बहुत छोटी थी। माइक बटन दबाकर रखें और स्पष्ट बोलें।';

  @override
  String get audioBufferWasEmptyPleaseCheckYourM =>
      'ऑडियो बफ़र खाली था। कृपया अपना माइक्रोफ़ोन जांचें और पुनः प्रयास करें।';

  @override
  String get audioFileIsSilentPleaseSpeakIntoThe =>
      'ऑडियो फ़ाइल मूक है। कृपया सीधे माइक्रोफ़ोन में बोलें।';

  @override
  String get weCouldntUnderstandYourPronunciatio =>
      'हम आपका उच्चारण समझ नहीं सके। कृपया स्पष्ट बोलें और पुनः प्रयास करें।';

  @override
  String get theServerIsTakingTooLongToRespondPl =>
      'सर्वर जवाब देने में बहुत अधिक समय ले रहा है। कृपया पुनः प्रयास करें।';

  @override
  String get noInternetConnectionPleaseCheckYour =>
      'कोई इंटरनेट कनेक्शन नहीं है। कृपया अपना नेटवर्क जांचें और पुनः प्रयास करें।';

  @override
  String get audioProcessingFailedPleaseTryAgain =>
      'ऑडियो प्रोसेसिंग विफल रही। कृपया पुनः प्रयास करें।';

  @override
  String get permission => 'अनुमति';

  @override
  String get couldNotProcessYourRecordingPleaseT =>
      'आपकी रिकॉर्डिंग को प्रोसेस नहीं किया जा सका। कृपया पुनः प्रयास करें।';

  @override
  String get user => 'उपयोगकर्ता';

  @override
  String get scholar => 'विद्वान';

  @override
  String get ourAiTutorsAreCurrentlyOfflinePleas =>
      'हमारे AI ट्यूटर इस समय ऑफ़लाइन हैं, कृपया बाद में पुनः प्रयास करें।';

  @override
  String get hideTranslation => 'अनुवाद छिपाएं';

  @override
  String get azureAssessment => 'Azure मूल्यांकन जारी है...';

  @override
  String get microphonePermissionRequired => 'माइक्रोफ़ोन अनुमति आवश्यक है';

  @override
  String get connectedSpeakNow => 'कनेक्ट हो गया! अब आप बोल सकते हैं।';

  @override
  String get initializationErrorCheckPermissions =>
      'आरंभीकरण त्रुटि। कृपया अनुमतियां जांचें।';

  @override
  String get microphoneErrorTapToRetry =>
      'माइक्रोफ़ोन त्रुटि। पुनः प्रयास करने के लिए टैप करें।';

  @override
  String get theTutorReturnedAnEmptyResponse =>
      'ट्यूटर की ओर से कोई उत्तर नहीं मिला।';

  @override
  String get connectionInterruptedPleaseSpeakAga =>
      'कनेक्शन टूट गया। कृपया दोबारा बोलें।';

  @override
  String get callPausedReviewingTones => 'कॉल रोकी गई (टोन का पुनरीक्षण)';

  @override
  String get pausedTakeABreak => 'विराम: थोड़ा ब्रेक लें';

  @override
  String get goodStartPracticing => 'अभ्यास की अच्छी शुरुआत';

  @override
  String get studentCoach => 'विद्यार्थी / कोच';

  @override
  String get keepYour1stToneHighAndSteadyOn =>
      'अपनी पहली टोन को इस पर ऊंचा और स्थिर रखें:';

  @override
  String get noScenariosFound => 'कोई परिदृश्य नहीं मिला।';

  @override
  String get designYourOwnAiRoleplayExperience =>
      'अपना स्वयं का AI रोलप्ले अनुभव डिज़ाइन करें';

  @override
  String get generateFromDeck => 'डेक से बनाएं';

  @override
  String get practiceFlashcardVocabularyInALiveD =>
      'लाइव संवाद में फ्लैशकार्ड शब्दावली का अभ्यास करें';

  @override
  String get tapToRoleplay => 'रोलप्ले शुरू करने के लिए टैप करें';

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
  String get dinnerWithDad => 'पिताजी के साथ डिनर';

  @override
  String get orderingAtAChengduTeahouse => 'चेंगदू के टीहाउस में ऑर्डर करना';

  @override
  String get buyingTeaAtTheMarket => 'बाज़ार में चाय खरीदना';

  @override
  String get meetingAnOldClassmate => 'पुराने सहपाठी से मिलना';

  @override
  String get readyToPractice => 'क्या आप अभ्यास के लिए तैयार हैं?';

  @override
  String get letsPracticeChinese => 'आइए चीनी का अभ्यास करें';

  @override
  String get areYouReady => 'क्या आप तैयार हैं?';

  @override
  String get discussWhatToHaveForDinner => 'रात के खाने के बारे में चर्चा करें';

  @override
  String get suggestWatchingAMovieAfterwards =>
      'बाद में मूवी देखने का सुझाव दें';

  @override
  String get askIfTheyWouldLikeTea => 'पूछें कि क्या वे चाय लेना पसंद करेंगे';

  @override
  String get helloVeryNiceToMeetYou => 'नमस्ते! आपसे मिलकर बहुत खुशी हुई।';

  @override
  String get deckPractice => 'डेक अभ्यास';

  @override
  String get practiceVocabularyWithAnAiPartner =>
      'AI पार्टनर के साथ शब्दावली का अभ्यास करें।';

  @override
  String get designCustomAiRoleplayConversation =>
      'कस्टम AI रोलप्ले और बातचीत डिज़ाइन करें';

  @override
  String get random => 'यादृच्छिक';

  @override
  String get scenarioTopic => 'परिदृश्य का विषय';

  @override
  String get contextSettingOptional => 'संदर्भ और परिवेश (वैकल्पिक)';

  @override
  String get aiCharacterPersonaOptional => 'AI चरित्र / व्यक्तित्व (वैकल्पिक)';

  @override
  String get aQuietBambooCourtyardTeahouseInChen =>
      'चेंगदू में एक शांत बांस के आंगन वाला टीहाउस, जहाँ पृष्ठभूमि में मधुर गुझेंग संगीत बज रहा है।';

  @override
  String get aBustlingSmokyNightMarketFilledWith =>
      'एक हलचल भरा, धुआंधार रात्रि बाज़ार, जो सीख कबाब, बाओज़ी और स्ट्रीट फ़ूड स्टालों से भरा है।';

  @override
  String get aLivelyHotpotRestaurantInChongqingW =>
      'चोंगकिंग का एक जीवंत हॉटपॉट रेस्तरां, जिसमें उबलता हुआ गहरा लाल शोरबा और सुगंधित मिर्च का तीखापन है।';

  @override
  String get aBustlingTraditionalCantoneseTeahou =>
      'गुआंगज़ौ में एक पारंपरिक कैंटोनीज़ टीहाउस, जहाँ बांस की टोकरियों से गर्म भाप उठ रही है।';

  @override
  String get aChicMinimalistCafeInTheFrenchConce =>
      'फ़्रेंच कंसेशन में बारिश की रविवार दोपहर में एक सुरुचिपूर्ण और शांत कैफ़े।';

  @override
  String get aWarmNorthernHomeKitchenDuringWinte =>
      'सर्दियों में उत्तरी चीन की एक आरामदायक घरेलू रसोई, जहाँ मेज़ पर आटा और उबलते जियाओज़ी के बर्तन हैं।';

  @override
  String get anOpenairNightStreetFoodAlleyWithSi =>
      'स्ट्रीट फ़ूड की एक खुली रात्रि गली, जहाँ सिज़लिंग मटन कबाब, भुने हुए बैंगन और ठंडी बीयर का आनंद है।';

  @override
  String get aSnowyStreetCornerOutsideTheLamaTem =>
      'लामा मंदिर के बाहर बर्फ से ढका सड़क का कोना, जहाँ चमकते हुए लाल तांगहुलु (कैंडीड हॉथॉर्न) सजे हैं।';

  @override
  String get craftBeerBreweryInQingdao => 'क़िंगदाओ में क्राफ्ट बीयर ब्रूअरी';

  @override
  String get aLivelyCoastalTaproomWithWoodenBarr =>
      'लकड़ी के बैरल, समुद्री हवा और ताज़ा व्हीट बीयर के साथ एक जीवंत तटीय टैपरूम।';

  @override
  String get sichuanCookingMasterclass => 'सिचुआन कुकिंग मास्टरक्लास';

  @override
  String get aVibrantOpenKitchenWithWoksBlazingC =>
      'लपटों से घिरे वोक, खौलते मिर्च के तेल और ताज़ी सिचुआन मिर्च के साथ एक खुली जीवंत रसोई।';

  @override
  String get highspeedRailSeatMixup => 'हाई-स्पीड रेल में सीट को लेकर भ्रम';

  @override
  String get greatWallSunriseTrekInMutianyu =>
      'मुतियान्यु में चीन की महान दीवार पर सूर्योदय ट्रेक';

  @override
  String get theAncientStoneRampartsOfTheGreatWa =>
      'भोर की धुंधली हरी पहाड़ियों से घिरी महान दीवार की प्राचीन पत्थर की प्राचीर।';

  @override
  String get bambooRaftDriftOnGuilinLiRiver =>
      'गुइलिन की ली नदी पर बांस के बेड़े की सैर';

  @override
  String get glidingAlongEmeraldKarstWatersBetwe =>
      'यांगशुओ की चूना पत्थर की चोटियों के बीच पन्ना जैसे हरे पानी पर तैरती नाव।';

  @override
  String get silkRoadCamelTrekInDunhuang =>
      'दुन्हुआंग में सिल्क रोड पर ऊंट की सवारी';

  @override
  String get theRollingGoldenSandDunesOfMingshaM =>
      'क्रिसेंट लेक नखलिस्तान के समीप मिंग्शा पर्वत के सुनहरे रेत के टीले।';

  @override
  String get bookingACourtyardHomestayInDali =>
      'डाली में एक पारंपरिक आंगन वाला होमस्टे बुक करना';

  @override
  String get aSereneBaistyleBoutiqueCourtyardHot =>
      'युन्नान में एरहाई झील के सुरम्य नज़ारे वाला पारंपरिक बाई-शैली का बुटीक होटल।';

  @override
  String get potalaPalacePilgrimageInLhasa =>
      'ल्हासा में पोटाला पैलेस की तीर्थयात्रा';

  @override
  String get theMajesticSundrenchedStoneStepsOut =>
      'घूमते हुए प्रार्थना चक्रों के बीच पोटाला पैलेस की धूप से नहाई भव्य पत्थर की सीढ़ियाँ।';

  @override
  String get aSubzeroWonderlandOfIlluminatedCrys =>
      'जगमगाते बर्फ के महलों और विशालकाय हिम मूर्तियों का एक शीतकालीन वंडरलैंड।';

  @override
  String get zhangjiajieAvatarMountainCableCar =>
      'झांगजियाजी अवतार माउंटेन केबल कार';

  @override
  String get suspendedHighInAGlassCableCarSoarin =>
      'बलुआ पत्थर के हज़ारों ऊँचे खंभों के ऊपर से गुजरती कांच की केबल कार।';

  @override
  String get gobiDesertStargazingCampInGansu =>
      'गांसु के गोबी रेगिस्तान में तारों को निहारने का कैंप';

  @override
  String get aLuxuryYurtCampUnderACrystalclearMi =>
      'जियायुगुआन के पास रेगिस्तान में आकाशगंगा के साफ़ तारों तले बना एक लक्ज़री यर्ट कैंप।';

  @override
  String get yangtzeRiverThreeGorgesCruise =>
      'यांग्त्ज़ी नदी की तीन घाटियों (थ्री गॉर्जेस) का क्रूज़';

  @override
  String get onTheSunDeckOfARiverCruiseShipPassi =>
      'रिवर क्रूज़ के सन डेक पर खड़े होकर भव्य कुटांग घाटी से गुज़रने का अनुभव।';

  @override
  String get buyingAntiquesInBeijingPanjiayuan =>
      'बीजिंग के पानजियायुआन बाज़ार में प्राचीन वस्तुएं खरीदना';

  @override
  String get aHistoricPotteryKilnFilledWithDelic =>
      'नाजुक चीनी मिट्टी के बर्तनों और कोबाल्ट नीले ग्लेज़ से भरी एक ऐतिहासिक भट्टी।';

  @override
  String get suzhouSilkEmbroideryStudio => 'सूझोऊ सिल्क कढ़ाई स्टूडियो';

  @override
  String get aPeacefulCanalsideGardenStudioInSuz =>
      'नहर के किनारे बना एक शांत गार्डन स्टूडियो, जहाँ रेशम के बारीक धागे और लकड़ी के फ्रेम सजे हैं।';

  @override
  String get backstageAtATraditionalBeijingOpera =>
      'पारंपरिक बीजिंग ओपेरा थिएटर के मंच के पीछे सजे रंग-बिरंगे परिधान, दर्पण और मुकुट।';

  @override
  String get traditionalChineseMedicineConsultat =>
      'पारंपरिक चीनी चिकित्सा (TCM) परामर्श';

  @override
  String get morningTaiChiInTempleOfHeavenPark =>
      'टेंपल ऑफ़ हेवन पार्क में सुबह का ताई ची';

  @override
  String get beneathAncientCypressTreesAtDawnWit =>
      'सुबह के समय प्राचीन सरू के पेड़ों के नीचे पक्षियों के चहकने और बुजुर्गों के ताई ची का दृश्य।';

  @override
  String get rentingAHanfuForAPhotoShoot =>
      'फ़ोटोशूट के लिए पारंपरिक हानफू पोशाक किराए पर लेना';

  @override
  String get aTraditionalCostumeBoutiqueNearTheW =>
      'वेस्ट लेक के पास एक बुटीक, जहाँ तांग और सोंग राजवंश के परिधानों की कतारें लगी हैं।';

  @override
  String get guqinAncientZitherInstrumentWorksho =>
      'गुकिन (प्राचीन चीनी ज़ीथर) वाद्य यंत्र कार्यशाला';

  @override
  String get aQuietPinewoodStudioInHangzhouFille =>
      'हांग्जो में देवदार की लकड़ी से बना एक शांत स्टूडियो, जहाँ रेशम के तारों वाले वाद्य यंत्र रखे हैं।';

  @override
  String get shaanxiShadowPuppetTheater => 'शानक्सी छाया कठपुतली थियेटर';

  @override
  String get behindAnIlluminatedWhiteSilkScreenW =>
      'रोशन सफेद रेशमी पर्दे के पीछे से पारदर्शी चमड़े की कठपुतलियों का प्रदर्शन।';

  @override
  String get chineseCalligraphyWorkshop => 'चीनी सुलेख कार्यशाला';

  @override
  String get aTranquilStudioScentedWithPineSootI =>
      'एक शांत कला स्टूडियो, जो पाइन की स्याही, राइस पेपर और ताज़ा चाय की खुशबू से महक रहा है।';

  @override
  String get adoptingACatAtAnAnimalShelter => 'पशु आश्रय से बिल्ली को गोद लेना';

  @override
  String get aCozyPetRescueCenterInHangzhouWithE =>
      'हांग्जो में एक आरामदायक रेस्क्यू सेंटर, जहाँ नटखट बिल्लियाँ और आगंतुकों के लिए चाय उपलब्ध है।';

  @override
  String get scriptMurderMysteryJubenshaGame =>
      'स्क्रिप्ट मर्डर मिस्ट्री (जुबेंशा) खेल';

  @override
  String get aThemedDetectiveLoungeInShanghaiWit =>
      'शंघाई में मोमबत्ती की रोशनी और रहस्यमयी वेशभूषा वाला एक डिटेक्टिव लाउंज।';

  @override
  String get vintageVinylRecordShopInShanghai =>
      'शंघाई में विंटेज विनाइल रिकॉर्ड की दुकान';

  @override
  String get aHiddenVinylStoreInAnOldLaneHousePa =>
      'एक पारंपरिक गली के घर में छिपी रिकॉर्ड शॉप, जहाँ 80 के दशक के कैंटोपॉप और जैज़ रिकॉर्ड्स हैं।';

  @override
  String get ktvKaraokePartyWithFriends => 'दोस्तों के साथ KTV कराओके पार्टी';

  @override
  String get joiningACityBikeCyclingClub =>
      'शहरी साइकिलिंग क्लब में शामिल होना';

  @override
  String get aGatheringOfCyclistsByTheRiverfront =>
      'नदी किनारे इकट्ठा हुए साइकिल चालक, जो शहर की नाइट राइड के लिए तैयार हैं।';

  @override
  String get blindBoxToyTradingMeetup =>
      'ब्लाइंड बॉक्स संग्रहणीय खिलौनों का आदान-प्रदान';

  @override
  String get aColorfulPopcultureToyStoreInChaoya =>
      'चाओयांग की एक रंग-बिरंगी टॉय शॉप, जहाँ नए डिज़ाइनर खिलौनों के बॉक्स सजे हैं।';

  @override
  String get droneSkylineVideographyAtTheBund =>
      'द बंड पर ड्रोन से स्काईलाइन वीडियोग्राफी';

  @override
  String get theBundPromenadeAtDuskOverlookingTh =>
      'शाम के समय द बंड की सैरगाह, जहाँ से पुडोंग के जगमगाते गगनचुंबी टॉवर दिखाई देते हैं।';

  @override
  String get goldenRetrieverCafeInNanjing =>
      'नानजिंग में गोल्डन रिट्रीवर कैफ़े';

  @override
  String get aSunnyCheerfulPetCafeWithDozensOfFr =>
      'एक धूप से खिला हुआ कैफ़े, जहाँ दर्जनों दोस्ताना और प्यारे कुत्ते आगंतुकों का स्वागत करते हैं।';

  @override
  String get boulderingClimbingGymInChengdu =>
      'चेंगदू में बोल्डरिंग क्लाइंबिंग जिम';

  @override
  String get aModernIndoorClimbingGymWithVibrant =>
      'एक आधुनिक इंडोर क्लाइंबिंग जिम, जिसमें रंग-बिरंगे रूट्स और जोशीला संगीत है।';

  @override
  String get aMassiveConventionHallFilledWithCol =>
      'गेमिंग बूथों, फ़ोटो ज़ोन और कॉस्ट्यूम कलाकारों से भरा एक विशाल कन्वेंशन हॉल।';

  @override
  String get askingForDirectionsInABeijingHutong =>
      'बीजिंग के हुतोंग में रास्ता पूछना';

  @override
  String get aMazeOfHistoricGreybrickAlleysWithB =>
      'ग्रे ईंटों की ऐतिहासिक गलियों की भूलभुलैया, जहाँ साइकिलें, आंगन और अनार के पेड़ हैं।';

  @override
  String get buyingFreshFruitAtAWetMarket =>
      'पारंपरिक ताज़ा फल बाज़ार में खरीदारी';

  @override
  String get aLivelyMorningNeighborhoodMarketWit =>
      'सुबह का एक चहल-पहल भरा स्थानीय बाज़ार, जहाँ लीची, आम और ड्रैगनफ्रूट के ढेर लगे हैं।';

  @override
  String get flowerMarketBouquetInKunming =>
      'कुनमिंग के फूल बाज़ार से गुलदस्ता';

  @override
  String get theFamousDounanFlowerMarketSurround =>
      'प्रसिद्ध डौनान फूल बाज़ार, जो हज़ारों ताज़ा गुलाबों, लिली और यूकेलिप्टस से महक रहा है।';

  @override
  String get tailorAlterationsInAnOldLaneHouse =>
      'पारंपरिक गली के मकान में टेलर से कपड़ों की फिटिंग';

  @override
  String get aTraditionalTailorShopFilledWithSew =>
      'सिलाई मशीनों, कपड़ों के थानों और इंची टेपों से भरी एक पारंपरिक दर्जी की दुकान।';

  @override
  String get expressParcelLockerRetrieval =>
      'स्मार्ट पार्सल लॉकर से पैकेज प्राप्त करना';

  @override
  String get downstairsAtAResidentialApartmentGa =>
      'अपार्टमेंट के मुख्य द्वार पर स्थित स्मार्ट हाइव पार्सल लॉकर सिस्टम।';

  @override
  String get bicycleFlatTireRepairAtCampusGate =>
      'कैंपस गेट पर साइकिल का पंचर बनवाना';

  @override
  String get aSmallOutdoorRoadsideToolkitStandUn =>
      'घने बरगद के पेड़ की छांव में सड़क किनारे लगा एक छोटा साइकिल मरम्मत स्टॉल।';

  @override
  String get techCompanyProductDemo => 'टेक कंपनी का उत्पाद डेमो';

  @override
  String get aFuturisticTechConferenceBoothInShe =>
      'शेन्ज़ेन में अत्याधुनिक AI हार्डवेयर प्रदर्शित करता हुआ एक भविष्यवादी टेक बूथ।';

  @override
  String get ecommerceLivestreamStudio => 'ई-कॉमर्स लाइव-स्ट्रीम स्टूडियो';

  @override
  String get aHighenergyBroadcastStudioWithRingL =>
      'रिंग लाइट्स, डिस्प्ले रैक और लाइव कमेंट्री स्क्रीन से सुसज्जित एक हाई-एनर्जी ब्रॉडकास्ट स्टूडियो।';

  @override
  String get yiwuInternationalTradeMarket =>
      'यीवू अंतर्राष्ट्रीय व्यापार बाज़ार';

  @override
  String get aVastMultistoryCommercialExhibition =>
      'लाखों थोक उत्पादों और शिल्पों से भरा एक विशाल बहुमंजिला व्यापारिक केंद्र।';

  @override
  String get universityCampusExchangeProgram =>
      'विश्वविद्यालय कैंपस विनिमय कार्यक्रम';

  @override
  String get aSunnyLawnOutsideTheUniversityLibra =>
      'यूनिवर्सिटी लाइब्रेरी के बाहर धूप खिली घास, जहाँ छात्र पढ़ाई करते हुए मिल्क टी पी रहे हैं।';

  @override
  String get pleaseEnterAScenarioTopic => 'कृपया परिदृश्य का विषय दर्ज करें।';

  @override
  String get nameTitle => 'नाम (शीर्षक)';

  @override
  String get aiCharacter => 'AI पात्र';

  @override
  String get helloWelcomeHereWhatShallWeChatAbou =>
      'नमस्ते! आपका स्वागत है, आज हम किस विषय पर बात करें?';

  @override
  String get greetYourConversationPartner =>
      'अपने वार्तालाप साथी का अभिवादन करें';

  @override
  String get askAQuestionInChinese => 'चीनी भाषा में एक प्रश्न पूछें';

  @override
  String get pinyinWithToneMarks => 'टोन चिह्नों के साथ पिनयिन';

  @override
  String get goal1InEnglish => 'लक्ष्य 1 (हिंदी में)';

  @override
  String get goal2InEnglish => 'लक्ष्य 2 (हिंदी में)';

  @override
  String get goal3InEnglish => 'लक्ष्य 3 (हिंदी में)';

  @override
  String get beginner => 'शुरुआती';

  @override
  String get hsk12 => 'HSK 1-2';

  @override
  String get hsk34 => 'HSK 3-4';

  @override
  String get hsk56 => 'HSK 5-6';

  @override
  String get master => 'मास्टर';

  @override
  String get azurePronunciationAssessment => 'AZURE उच्चारण मूल्यांकन';

  @override
  String get tapToReview => 'समीक्षा के लिए टैप करें';

  @override
  String get overallScore => 'कुल स्कोर';

  @override
  String get toneAccuracy => 'टोन सटीकता';

  @override
  String get fluency => 'प्रवाह';

  @override
  String get report => 'रिपोर्ट';

  @override
  String get goodPronunciationButCanBeBetter =>
      'उच्चारण अच्छा है, लेकिन और बेहतर हो सकता है!';

  @override
  String get didYouMeanToSay => 'क्या आपका मतलब यह था...?';

  @override
  String get greatKeepTrying => 'बहुत बढ़िया! अभ्यास जारी रखें!';

  @override
  String get completeness => 'पूर्णता';

  @override
  String get targetTone => 'लक्षित टोन';

  @override
  String get k4toneComparisonTapToListen =>
      '4-टोन तुलना (सुनने के लिए टैप करें):';

  @override
  String get youSpokeMatch => 'आपने कहा (सटीक मेल!)';

  @override
  String get youSpoke => 'आपने कहा';

  @override
  String get yourPrimaryCollectionOfCharacters =>
      'आपके वर्णों का मुख्य संग्रह।';

  @override
  String get deckNotFound => 'डेक नहीं मिला';

  @override
  String get cannotDeleteTheDefaultDeck => 'डिफ़ॉल्ट डेक को हटाया नहीं जा सकता';

  @override
  String get hsk4UpperIntermediate1 => 'HSK 4: उच्च-मध्यवर्ती';

  @override
  String get theFirst150CharactersToStartYourJou =>
      'आपकी अध्ययन यात्रा शुरू करने के लिए पहले 150 वर्ण।';

  @override
  String get buildYourVocabularyTo300EssentialWo =>
      'अपनी शब्दावली को 300 आवश्यक शब्दों तक बढ़ाएं।';

  @override
  String get masterConversationalFluencyWith600W =>
      '600 शब्दों के साथ बातचीत के प्रवाह में महारत हासिल करें।';

  @override
  String get readTextsAndConverseFluentlyWith120 =>
      '1200 शब्दों के साथ धाराप्रवाह पाठ पढ़ें और संवाद करें।';

  @override
  String get readNewspapersAndWatchMoviesWith250 =>
      '2500 शब्दों के साथ समाचार पत्र पढ़ें और फ़िल्में देखें।';

  @override
  String get databaseBoxNotOpen => 'डेटाबेस बॉक्स खुला नहीं है';

  @override
  String get hsk1DataFileIsEmpty => 'HSK 1 डेटा फ़ाइल रिक्त है';

  @override
  String get gold => 'स्वर्ण';

  @override
  String get globalDictionaryNotInitialized =>
      'वैश्विक शब्दकोश प्रारंभ नहीं हुआ';

  @override
  String get reading => 'पढ़ना';

  @override
  String get recall => 'स्मरण';

  @override
  String get speaking => 'बोलना';

  @override
  String get listening1 => 'सुनना';

  @override
  String get practiceStrokeOrderWithVisualGuides =>
      'विज़ुअल गाइड की मदद से स्ट्रोक क्रम का अभ्यास करें।';

  @override
  String get seeTheCharacterRecallThePinyinAndMe =>
      'वर्ण देखकर उसका पिनयिन और अर्थ याद करें।';

  @override
  String get seeTheMeaningDrawTheCharacterFromMe =>
      'अर्थ देखकर याददाश्त से वर्ण बनाएं।';

  @override
  String get readOutLoudToTestYourPronunciationT =>
      'उच्चारण और टोन का परीक्षण करने के लिए ज़ोर से पढ़ें।';

  @override
  String get listenToTheAudioAndIdentifyTheChara =>
      'ऑडियो सुनकर सही वर्ण की पहचान करें।';

  @override
  String get contract => 'अनुबंध';

  @override
  String get whoeverImplementsMeMustBeAbleToDoTh =>
      'इस इंटरफ़ेस को लागू करने वाले को ये सभी कार्य करने में सक्षम होना चाहिए।';

  @override
  String get koreFenrirCharonAoedePuckOrLocal =>
      'Kore, Fenrir, Charon, Aoede, Puck या स्थानीय';

  @override
  String get manageDecks => 'डेक प्रबंधित करें';

  @override
  String get weRanIntoTroubleLoadingTheLibraryPl =>
      'लाइब्रेरी लोड करने में समस्या हुई। कृपया पुनः प्रयास करें।';

  @override
  String get noCharactersInLexicon1 => 'शब्दकोश में कोई वर्ण नहीं है';

  @override
  String get masterTheBuildingBlocks => 'मूलभूत तत्वों में महारत हासिल करें';

  @override
  String get other => 'अन्य';

  @override
  String get requiredLabel => 'अनिवार्य';

  @override
  String get library1 => 'पुस्तकालय';

  @override
  String get youAreAPremiumMember => 'आप एक प्रीमियम सदस्य हैं';

  @override
  String get createAccountToSyncProgress =>
      'प्रगति सिंक करने के लिए खाता बनाएं';

  @override
  String get signOut => 'साइन आउट';

  @override
  String get account => 'खाता';

  @override
  String get guestScholar => 'अतिथि विद्वान';

  @override
  String get localAccount => 'स्थानीय खाता';

  @override
  String get unknownRadical => 'अज्ञात रेडिकल';

  @override
  String get followTheGuideStroke => 'मार्गदर्शक स्ट्रोक का पालन करें';

  @override
  String get strokeAnimationSpeed => 'स्ट्रोक एनिमेशन गति';

  @override
  String get notifications => 'सूचनाएं';

  @override
  String get deutsch => 'जर्मन';

  @override
  String get bahasaIndonesia => 'इंडोनेशियाई';

  @override
  String get italiano => 'इतालवी';

  @override
  String get today1d2d3d4d5d6d =>
      'आज, 1 दिन, 2 दिन, 3 दिन, 4 दिन, 5 दिन, 6 दिन';

  @override
  String get targetDeck => 'लक्ष्य डेक';

  @override
  String get mixed => 'मिश्रित';

  @override
  String get topicForContext => 'विषय (संदर्भ के लिए)';

  @override
  String get nounsOnly => 'केवल संज्ञाएं';

  @override
  String get verbsOnly => 'केवल क्रियाएं';

  @override
  String get idiomsChengyu => 'मुहावरे (चेंग्यू)';

  @override
  String get fullSentences => 'पूर्ण वाक्य';

  @override
  String get beginnerHsk12 => 'शुरुआती (HSK 1-2)';

  @override
  String get intermediateHsk34 => 'मध्यवर्ती (HSK 3-4)';

  @override
  String get advancedHsk56 => 'उन्नत (HSK 5-6)';

  @override
  String get generatedByAi => 'AI द्वारा निर्मित';

  @override
  String get canYouGiveMeTwoMoreExamplesUsingThi =>
      'क्या आप इस शब्द का उपयोग करके दो और उदाहरण दे सकते हैं?';

  @override
  String get whatAreSomeSimilarWordsAndHowDoThey =>
      'इसके समान शब्द कौन से हैं और वे कैसे भिन्न हैं?';

  @override
  String get isThisWordUsedInSpokenOrWrittenChin =>
      'क्या यह शब्द बोलचाल में अधिक प्रयुक्त होता है या लिखित चीनी में?';

  @override
  String get areThereOtherWaysToTranslateThisWor =>
      'क्या इस शब्द का अनुवाद करने के अन्य विकल्प हैं?';

  @override
  String get whatAreCommonWordsThatGoTogetherWit =>
      'इस शब्द के साथ सामान्यतः कौन से शब्द जोड़े जाते हैं?';

  @override
  String get whatAreCommonMistakesLearnersMakeWi =>
      'इस शब्द के उपयोग में शिक्षार्थी प्रायः क्या गलतियाँ करते हैं?';

  @override
  String get emptyResponse => 'खाली उत्तर';

  @override
  String get whatIsTheOracleBoneScriptOriginOfTh =>
      'ओरेकल बोन लिपि (Oracle Bone Script) में इस वर्ण की उत्पत्ति क्या है?';

  @override
  String get howDidTheAncientFormOfThisCharacter =>
      'समय के साथ इस वर्ण का प्राचीन रूप कैसे विकसित हुआ?';

  @override
  String get giveMe3CommonWordsThatContainThisCh =>
      'मुझे 3 सामान्य शब्द बताएं जिनमें यह वर्ण आता हो।';

  @override
  String get whatOtherCharactersShareTheSameRadi =>
      'कौन से अन्य वर्ण इसी रेडिकल से बने हैं?';

  @override
  String get isThereAChineseProverbOrSayingFeatu =>
      'क्या कोई चीनी कहावत या लोकोक्ति है जिसमें यह वर्ण आता है?';

  @override
  String get explainTheStrokeOrderRulesForThisCh =>
      'इस वर्ण के स्ट्रोक क्रम के नियमों को स्पष्ट करें।';

  @override
  String get giveMeOneCalligraphyTipForWritingTh =>
      'इस वर्ण को सुंदरता से लिखने के लिए एक सुलेख सुझाव दें।';

  @override
  String get isThereAnythingTrickyAboutUsingThis =>
      'क्या इसके व्याकरणिक प्रयोग में कोई विशेष सावधानी रखनी होती है?';

  @override
  String get whatWordsAreCommonlyConfusedWithThi =>
      'किन शब्दों को लेकर इसके साथ अक्सर भ्रम होता है और क्यों?';

  @override
  String get doesThisCharacterCarryCulturalSymbo =>
      'क्या इस वर्ण का चीनी संस्कृति में कोई विशेष प्रतीकात्मक अर्थ है?';

  @override
  String get isThisCharacterCommonlySeenInChines =>
      'क्या यह वर्ण चीनी गीतों, फ़िल्मों या समकालीन पाठों में अक्सर दिखाई देता है?';

  @override
  String get whatDoesTheRadicalOfThisCharacterMe =>
      'इस वर्ण के रेडिकल का क्या अर्थ है?';

  @override
  String get breakDownEveryComponentAndItsMeanin =>
      'इसके प्रत्येक घटक और उसके अर्थ का विश्लेषण करें।';

  @override
  String get giveMeATrickToRememberTheCorrectTon =>
      'इस वर्ण के सही टोन को याद रखने की कोई युक्ति बताएं।';

  @override
  String get areThereCommonHomophonesThatAreOfte =>
      'क्या इसके कोई सामान्य समध्वनिक (Homophones) शब्द हैं जो भ्रम पैदा करते हैं?';

  @override
  String get quotaExceeded => 'कोटा सीमा समाप्त हो गई है';

  @override
  String get mustProvideEitherCardOrCards =>
      'एक कार्ड या कार्डों की सूची प्रदान करना आवश्यक है';

  @override
  String get deckSettings => 'डेक सेटिंग्स';

  @override
  String get saveSettings => 'सेटिंग्स सहेजें';

  @override
  String get sealRed => 'सील लाल';

  @override
  String get sealScript => 'सील लिपि (Seal Script)';

  @override
  String get startYourStreak => 'अपनी स्ट्रीक शुरू करें';

  @override
  String get traditionalCharacter => 'पारंपरिक वर्ण';

  @override
  String get inQueue => 'कतार में';

  @override
  String get tapToListenAgain => 'दोबारा सुनने के लिए टैप करें';

  @override
  String get contextClue => 'संदर्भ संकेत';

  @override
  String get microphonePermissionRequired1 =>
      'माइक्रोफ़ोन की अनुमति आवश्यक है।';

  @override
  String get recordingFailedNoFile => 'रिकॉर्डिंग विफल रही (फ़ाइल नहीं बनी)।';

  @override
  String get holdToSpeakOptional => 'बोलने के लिए दबाकर रखें (वैकल्पिक)';

  @override
  String get microphonePermissionDeniedEnableItI =>
      'माइक्रोफ़ोन अनुमति अस्वीकृत। शैडोइंग स्टूडियो का उपयोग करने के लिए इसे सेटिंग्स में सक्षम करें।';

  @override
  String get sessionSummary => 'सत्र सारांश';

  @override
  String get hereAreTheCharactersYouStruggledWit =>
      'ये वे वर्ण हैं जिनमें आपको कठिनाई हुई:';

  @override
  String get applySessionGradesToSpacedRepetitio =>
      'सत्र के अंकों को अंतराल पुनरावृत्ति (बोलने का मोड) पर लागू करें';

  @override
  String get masterYourMandarinPronunciationnbyM =>
      'मूल वक्ताओं का अनुकरण करके अपने मंदारिन उच्चारण\nमें महारत हासिल करें।';

  @override
  String get aiIsGradingYourPronunciation =>
      'AI आपके उच्चारण का मूल्यांकन कर रहा है...';

  @override
  String get holdMicToRecordReleaseToGrade =>
      'रिकॉर्ड करने के लिए माइक दबाकर रखें। मूल्यांकन के लिए छोड़ें।';

  @override
  String get tapAnySyllableToAuditionAll4Tones =>
      'सभी 4 टोन सुनने के लिए किसी भी शब्दांश पर टैप करें:';

  @override
  String get freeFlowConversationalPractice =>
      'मुक्त प्रवाह संवादात्मक अभ्यास।';

  @override
  String get failedToGeneratePhrasePleaseTryAgai =>
      'वाक्यांश बनाने में विफल। कृपया पुनः प्रयास करें।';

  @override
  String get recordingTooShortHoldTheMicButtonLo =>
      'रिकॉर्डिंग बहुत छोटी थी। माइक बटन को अधिक समय तक दबाकर रखें।';

  @override
  String get recordingErrorPleaseTryAgain =>
      'रिकॉर्डिंग में त्रुटि हुई। कृपया पुनः प्रयास करें।';

  @override
  String get noRecordingCapturedPleaseTryAgain =>
      'कोई रिकॉर्डिंग दर्ज नहीं हुई। कृपया पुनः प्रयास करें।';

  @override
  String get recordedAudioIsEmptyPleaseTryAgainA =>
      'रिकॉर्ड किया गया ऑडियो मूक है। कृपया स्पष्ट आवाज़ में पुनः प्रयास करें।';

  @override
  String get azureSpeechApiKeysAreMissing1 =>
      'Azure Speech API कुंजियाँ उपलब्ध नहीं हैं';

  @override
  String get azureError401 => 'Azure त्रुटि 401';

  @override
  String get azureAuthenticationFailedCheckYourS =>
      'Azure प्रमाणीकरण विफल। .env फ़ाइल में अपनी Speech API कुंजी और क्षेत्र की जाँच करें।';

  @override
  String get azureError429 => 'Azure त्रुटि 429';

  @override
  String get azureQuotaExceededTryAgainLater =>
      'Azure कोटा समाप्त हो गया है। कृपया बाद में पुनः प्रयास करें।';

  @override
  String get azureGradingTimedOutCheckYourIntern =>
      'Azure मूल्यांकन का समय समाप्त हो गया। अपना इंटरनेट कनेक्शन जांचें।';

  @override
  String get recognitionFailedNull => 'पहचान विफल: परिणाम शून्य';

  @override
  String get couldNotHearYouClearlyPleaseTryAgai =>
      'हम आपकी आवाज़ स्पष्ट रूप से नहीं सुन सके। कृपया पुनः प्रयास करें।';

  @override
  String get singlePhrasePractice => 'एकल वाक्यांश अभ्यास';

  @override
  String get failedToGeneratePhrase => 'वाक्यांश जनरेट करने में विफल';

  @override
  String get omitted => 'छूटा हुआ';

  @override
  String get partial => 'आंशिक';

  @override
  String get mispronounced => 'अशुद्ध उच्चारण';

  @override
  String get startSession1 => 'सत्र शुरू करें';

  @override
  String get chinese => 'चीनी';

  @override
  String get paused => 'विराम दिया गया';

  @override
  String get translationFailed => 'अनुवाद विफल';

  @override
  String get engagingMacroeconomicAndBusinessBre =>
      'सजीव कहानियों के माध्यम से प्रस्तुत रोचक वृहद-आर्थिक और व्यावसायिक विश्लेषण।';

  @override
  String get exploresWorldEconomiesBankingHistor =>
      'वैश्विक अर्थव्यवस्थाओं, बैंकिंग इतिहास और उद्योग की गतिशीलता की खोज।';

  @override
  String get clearArticulateMandarinPerfectForIn =>
      'स्पष्ट और धाराप्रवाह मंदारिन, जो मध्यम और उच्च स्तर के शिक्षार्थियों के लिए आदर्श है।';

  @override
  String get chefWang => 'शेफ वांग';

  @override
  String get masterSichuanCulinaryTechniquesTaug =>
      'एक पेशेवर हेड शेफ से सीखें सिचुआन की प्रामाणिक पाक कला।';

  @override
  String get stepbystepAuthenticChineseRecipesWi =>
      'वोक नियंत्रण और कटिंग कौशल के साथ प्रामाणिक चीनी व्यंजनों की चरण-दर-चरण विधि।';

  @override
  String get conciseCulinaryVocabularyAndClearIn =>
      'सहज मंदारिन में संक्षिप्त रसोई शब्दावली और स्पष्ट निर्देश।';

  @override
  String get cinematographyCuttingedgeCameraTech =>
      'सिनेमैटोग्राफी, अत्याधुनिक कैमरा तकनीक और डिजिटल मीडिया का गहन विश्लेषण।';

  @override
  String get highproductionDocumentaryStyleExplo =>
      'उच्च-स्तरीय डॉक्यूमेंट्री शैली, जो वीडियो निर्माण और AI नवाचारों की पड़ताल करती है।';

  @override
  String get richTechnicalMandarinWithCrystalcle =>
      'स्पष्ट उच्चारण और विज़ुअल कैप्शन के साथ समृद्ध तकनीकी मंदारिन।';

  @override
  String get indepthInvestigativeJournalismAndCu =>
      'गहन खोजी पत्रकारिता और समसामयिक विषयों पर गंभीर टिप्पणी।';

  @override
  String get criticalPerspectivesOnSocialPhenome =>
      'सामाजिक घटनाओं, वैश्विक समाचार और इतिहास पर विश्लेषणात्मक दृष्टिकोण।';

  @override
  String get formalInvestigativeDiscourseIdealFo =>
      'औपचारिक खोजी शैली, जो उन्नत श्रवण कौशल विकसित करने के लिए उत्तम है।';

  @override
  String get bitesizedAnimatedScienceDocumentari =>
      'दैनिक जीवन के सवालों के उत्तर देने वाली संक्षिप्त एनिमेटेड विज्ञान डॉक्यूमेंट्री।';

  @override
  String get exploresPhysicsBiologyAndEverydayCu =>
      'रोचक इन्फोग्राफिक्स के साथ भौतिकी, जीव विज्ञान और रोज़मर्रा की जिज्ञासाओं की पड़ताल।';

  @override
  String get standardBeijingMandarinWithWellpace =>
      'उचित गति और स्पष्ट उपशीर्षकों के साथ मानक बीजिंग मंदारिन।';

  @override
  String get heartwarmingStreetFoodAdventuresAnd =>
      'चीन भर में स्ट्रीट फ़ूड के दिलकश अनुभव और स्थानीय लोगों से सच्ची बातचीत।';

  @override
  String get exploresRegionalHumanStoriesFamilyT =>
      'क्षेत्रीय लोककथाओं, पारिवारिक परंपराओं और स्थानीय स्वादों की खोज।';

  @override
  String get naturalConversationalMandarinWithDa =>
      'दैनिक बोलचाल और आत्मीयता से युक्त सहज संवादी मंदारिन।';

  @override
  String get humorousAndHonestConsumerElectronic =>
      'वास्तविक अनुभवों पर आधारित उपभोक्ता इलेक्ट्रॉनिक्स की निष्पक्ष और हास्यपूर्ण समीक्षाएं।';

  @override
  String get testingSmartphonesSmartHomeGadgetsA =>
      'स्मार्टफोन, स्मार्ट होम गैजेट्स और लाइफस्टाइल टेक गियर का परीक्षण।';

  @override
  String get relaxedHumorousConversationalDialog =>
      'आधुनिक बोलचाल की भाषा के साथ सहज और हास्यपूर्ण संवाद।';

  @override
  String get seanKitchen => 'शॉन किचन';

  @override
  String get deliciousHomecookedChineseDishesAnd =>
      'स्वादिष्ट घरेलू चीनी व्यंजन और प्रसिद्ध स्ट्रीट स्नैक्स।';

  @override
  String get easytofollowKitchenTipsForCookingAu =>
      'प्रामाणिक एशियाई व्यंजन पकाने के लिए सरल और उपयोगी किचन टिप्स।';

  @override
  String get warmInvitingCommentaryWithPractical =>
      'व्यावहारिक रसोई शब्दावली के साथ आत्मीय और आकर्षक प्रस्तुति।';

  @override
  String get chineseChannel => 'चीनी चैनल';

  @override
  String get structuredChineseLanguageLessonsAnd =>
      'संरचित चीनी भाषा पाठ और सांस्कृतिक खोज ट्यूटोरियल।';

  @override
  String get grammarPointsHskVocabularyBuildingA =>
      'व्याकरण बिंदु, HSK शब्दावली निर्माण और बातचीत के पैटर्न।';

  @override
  String get clearEducationalPacingTailoredSpeci =>
      'चीनी शिक्षार्थियों के लिए विशेष रूप से तैयार की गई स्पष्ट शिक्षण गति।';

  @override
  String get oneInABillion => 'एक अरब में एक';

  @override
  String get intimatePortraitsAndStoriesOfUnique =>
      'समकालीन चीन के अद्वितीय व्यक्तित्वों की जीवन गाथाएं।';

  @override
  String get exploresDiverseLifeChoicesYouthCult =>
      'विविध जीवन विकल्पों, युवा संस्कृति और आधुनिक सामाजिक परिवर्तनों की खोज।';

  @override
  String get deepNarrativeStorytellingWithRichVo =>
      'समृद्ध शब्दावली और प्रामाणिक आवाज़ों के साथ गहन कथात्मक प्रस्तुति।';

  @override
  String get vickySoup => 'विक्की सूप';

  @override
  String get aestheticLifestyleVlogsFashionStyli =>
      'सौंदर्यपूर्ण लाइफस्टाइल व्लॉग, फैशन स्टाइलिंग और दैनिक दिनचर्या।';

  @override
  String get travelDiariesAndCozyLifeMomentsDocu =>
      'सिनेमाई खूबसूरती के साथ प्रस्तुत यात्रा डायरी और जीवन के सुखद पल।';

  @override
  String get naturalCasualMandarinSpokenAtAComfo =>
      'सहज गति में बोली जाने वाली स्वाभाविक और अनौपचारिक मंदारिन।';

  @override
  String get tededMandarin => 'TED-Ed मंदारिन';

  @override
  String get highqualityAnimatedEducationalLesso =>
      'विज्ञान, दर्शन और इतिहास पर उच्च गुणवत्ता वाले एनिमेटेड शैक्षणिक पाठ।';

  @override
  String get thoughtprovokingRiddlesClassicLiter =>
      'विचारोत्तेजक पहेलियाँ, शास्त्रीय साहित्य और मनोवैज्ञानिक रहस्य।';

  @override
  String get impeccableVoiceoverMandarinWithSync =>
      'सटीक द्विभाषी उपशीर्षकों के साथ त्रुटिहीन वॉयस-ओवर मंदारिन।';

  @override
  String get channel => 'चैनल';

  @override
  String get curatedCulturalDocumentariesAndChin =>
      'चयनित सांस्कृतिक डॉक्यूमेंट्री और चीनी जीवनशैली की झलकियां।';

  @override
  String get exploringTraditionalArtsHeritageCra =>
      'पारंपरिक कलाओं, सांस्कृतिक शिल्प और आधुनिक रुझानों की खोज।';

  @override
  String get highQualityAudioWithSynchronizedChi =>
      'सिंक्रोनाइज़्ड चीनी उपशीर्षकों के साथ उच्च गुणवत्ता वाला ऑडियो।';

  @override
  String get interestingStoriesAndCreativeVideoP =>
      'चीनी वेब की दिलचस्प कहानियाँ और रचनात्मक वीडियो प्रोजेक्ट।';

  @override
  String get engagingInterviewsStorytellingAndVi =>
      'आकर्षक साक्षात्कार, कहानी और विज़ुअल प्रस्तुति।';

  @override
  String get greatListeningMaterialWithStandardP =>
      'मानक उच्चारण के साथ बेहतरीन श्रवण सामग्री।';

  @override
  String get xVsY => 'X बनाम Y';

  @override
  String get untitled => 'शीर्षकहीन';

  @override
  String get contemporaryStories => 'समकालीन कहानियाँ';

  @override
  String get history => 'इतिहास';

  @override
  String get advancedReading => 'उन्नत पठन';

  @override
  String get intermediateReading => 'मध्यवर्ती पठन';

  @override
  String get beginnerReading => 'प्रारंभिक पठन';

  @override
  String get mandarinBean => 'मंदारिन बीन';

  @override
  String get unknown => 'अज्ञात';

  @override
  String get localDb => 'स्थानीय डेटाबेस';

  @override
  String get emperorTaizong => 'सम्राट ताइज़ोंग';

  @override
  String get emperorXuanzong => 'सम्राट ज़ुआनज़ोंग';

  @override
  String get liBai => 'ली बाई';

  @override
  String get gradedReader => 'श्रेणीबद्ध पाठक (Graded Reader)';

  @override
  String get ucj10r97lkwgdtqbt6xzv8gLearnMandari =>
      'TaiwanPlus के साथ मंदारिन सीखें';

  @override
  String get ucsxriuqkzzmaqklq0n9xfvwEverydayChi => 'रोजमर्रा की चीनी भाषा';

  @override
  String get graceMandarinChinese => 'Grace Mandarin Chinese';

  @override
  String get ucolbhvvl5dcjlmzeqbuu1vwTingdailyLi => 'Ting: चीन में दैनिक जीवन';

  @override
  String get xinxin => 'शिनशिन';

  @override
  String get sweetFamilyDailyLife => 'सुखद पारिवारिक जीवन';

  @override
  String get chinsunDailyLife => 'चिन-सन दैनिक जीवन';

  @override
  String get tasteChina => 'चीन का स्वाद';

  @override
  String get dawenFoodQuest => 'दावेन फूड क्वेस्ट';

  @override
  String get chinaTravelWithCangbao => 'कांगबाओ के साथ चीन यात्रा';

  @override
  String get alinFoodWalk => 'एलिन फूड वॉक';

  @override
  String get videoOfTheDay => 'आज का वीडियो';

  @override
  String get noValidVideoFound => 'कोई मान्य वीडियो नहीं मिला।';

  @override
  String get listeningPractice => 'श्रवण अभ्यास';

  @override
  String get socialSkills => 'सामाजिक कौशल';

  @override
  String get culturalContext => 'सांस्कृतिक संदर्भ';

  @override
  String get realLife => 'वास्तविक जीवन';

  @override
  String get realWorld => 'वास्तविक दुनिया';

  @override
  String get articleOfTheDay => 'आज का लेख';

  @override
  String get failedToLoadOrParseRssFeed =>
      'RSS फ़ीड लोड या पार्स करने में विफल।';

  @override
  String get drama => 'ड्रामा';

  @override
  String get youkugetAppNow => 'YOUKU: अभी ऐप डाउनलोड करें';

  @override
  String get romanceTrailer => 'रोमांस / ट्रेलर';

  @override
  String get romance => 'रोमांस';

  @override
  String get action => 'एक्शन';

  @override
  String get mystery => 'रहस्य';

  @override
  String get historical => 'ऐतिहासिक';

  @override
  String get historicalAction => 'ऐतिहासिक / एक्शन';

  @override
  String get historicalRomance => 'ऐतिहासिक / रोमांस';

  @override
  String get anYouth => 'युवा';

  @override
  String get historicalSliceOfLife => 'ऐतिहासिक / जीवन की झलक (Slice of Life)';

  @override
  String get historicalHighlight => 'ऐतिहासिक / मुख्य अंश';

  @override
  String get youkuEnglishgetAppNow => 'YOUKU English: अभी ऐप डाउनलोड करें';

  @override
  String get theDouble => 'द डबल';

  @override
  String get updatesByOshin => 'ओशिन द्वारा अपडेट';

  @override
  String get backFromTheBrink => 'कगार से वापसी';

  @override
  String get fallingIntoYourSmile => 'आपकी मुस्कान में खो जाना';

  @override
  String get everyoneLovesMe => 'हर कोई मुझे प्यार करता है';

  @override
  String get tillTheEndOfTheMoon => 'चाँद के अंत तक';

  @override
  String get theBestDayOfMyLife => 'मेरे जीवन का सबसे अच्छा दिन';

  @override
  String get gikkiChineseDrama => 'GIKKI चीनी ड्रामा';

  @override
  String get dashingYouth => 'उत्साही युवा';

  @override
  String get rebornChineseDramaEngSub => 'Reborn चीनी ड्रामा (उपशीर्षक सहित)';

  @override
  String get ijenwaBenita => 'इजेनवा बेनिटा';

  @override
  String get whenIFlyTowardsYou => 'जब मैं तुम्हारी ओर उड़ूं';

  @override
  String get mztvExclusiveChineseDrama => 'MZTV एक्सक्लूसिव चीनी ड्रामा';

  @override
  String get theStarryLove => 'तारों भरा प्यार';

  @override
  String get comedy => 'कॉमेडी';

  @override
  String get backFromTheBrink1 => 'कगार से वापसी';

  @override
  String get dashingYouth1 => 'उत्साही युवा';

  @override
  String get beReborn => 'पुनर्जन्म';

  @override
  String get beautyStrategy => 'सौंदर्य रणनीति';

  @override
  String get myDivineEmissary => 'मेरा दिव्य दूत';

  @override
  String get theHope => 'आशा';

  @override
  String get ep16In => 'एपिसोड 16';

  @override
  String get everyoneLovesMe1 => 'हर कोई मुझे प्यार करता है';

  @override
  String get fallingIntoYourSmile1 => 'आपकी मुस्कान में खो जाना';

  @override
  String get hiddenLove => 'गुप्त प्रेम';

  @override
  String get loveBetweenFairyAndDevil => 'परी और राक्षस का प्रेम';

  @override
  String get loveLikeTheGalaxy => 'आकाशगंगा जैसा प्रेम';

  @override
  String get membersPremiere => 'सदस्य प्रीमियर';

  @override
  String get moonlight => 'चाँदनी';

  @override
  String get myJourneyToYou => 'आपकी ओर मेरी यात्रा';

  @override
  String get mysteriousLotusCasebook => 'रहस्यमय कमल केसबुक';

  @override
  String get rebornChineseDramaEngSub1 => 'Reborn चीनी ड्रामा (उपशीर्षक सहित)';

  @override
  String get reborn => 'पुनर्जन्म';

  @override
  String get theBestDayOfMyLife1 => 'मेरे जीवन का सबसे अच्छा दिन';

  @override
  String get theDouble1 => 'The Double';

  @override
  String get theLongBallad => 'द लॉन्ग बैलाड';

  @override
  String get theStarryLove1 => 'तारों भरा प्यार';

  @override
  String get theUntamed => 'द अनटेम्ड';

  @override
  String get tillTheEndOfTheMoon1 => 'चाँद के अंत तक';

  @override
  String get whenIFlyTowardsYou1 => 'जब मैं तुम्हारी ओर उड़ूं';

  @override
  String get wordOfHonor => 'सम्मान का वचन';

  @override
  String get blossom => 'खिलना';

  @override
  String get gemini => 'जेमिनी';

  @override
  String get generationToGeneration => 'पीढ़ी दर पीढ़ी';

  @override
  String get brocadeOdyssey => 'ब्रोकेड ओडिसी';

  @override
  String get circleOfLove => 'प्यार का घेरा';

  @override
  String get dawnIsBreaking => 'भोर हो रही है';

  @override
  String get firstRomance => 'पहला रोमांस';

  @override
  String get loveInTheClouds => 'बादलों में प्यार';

  @override
  String get secondChanceRomance => 'दूसरा मौका रोमांस';

  @override
  String get mrBad => 'मिस्टर बैड';

  @override
  String get pursuitOfJade => 'जेड की तलाश';

  @override
  String get fatedHearts => 'भाग्य से जुड़े दिल';

  @override
  String get roadHome => 'घर का रास्ता';

  @override
  String get myDearGuardian => 'मेरे प्रिय संरक्षक';

  @override
  String get brightEyesInTheDark => 'अंधेरे में चमकती आँखें';

  @override
  String get theIngeniousOne => 'द इंजीनियस वन';

  @override
  String get herPhoenixMajesty => 'हर फीनिक्स मैजेस्टी';

  @override
  String get dreamsNeverEnd => 'सपने कभी समाप्त नहीं होते';

  @override
  String get theUltimateVowUnknownToYou => 'अंतिम प्रतिज्ञा';

  @override
  String get the300LoyalGhosts => '300 वफादार आत्माएं';

  @override
  String get homelandGuardian => 'मातृभूमि का संरक्षक';

  @override
  String get loveIsAlwaysOnline => 'प्यार हमेशा ऑनलाइन है';

  @override
  String get thePrincessDecree => 'राजकुमारी का फरमान';

  @override
  String get aVowInTheDark => 'अंधेरे में एक प्रतिज्ञा';

  @override
  String get aGirlLikeMe => 'मुझ जैसी लड़की';

  @override
  String get iAmNobody => 'आई एम नोबडी';

  @override
  String get myMamaGo => 'माई मामा गो!';

  @override
  String get myWesternRegionPrincess => 'पश्चिमी क्षेत्र की राजकुमारी';

  @override
  String get aFlowerOnTheContinent => 'महाद्वीप का एक फूल';

  @override
  String get thePrincess => 'राजकुमारी';

  @override
  String get sweetLoveVersion => 'स्वीट लव संस्करण';

  @override
  String get hilariousFamily2 => 'प्रफुल्लित परिवार 2';

  @override
  String get guYuanMountainHasASchool => 'गु युआन पर्वत पर एक विद्यालय है';

  @override
  String get foreverYoung => 'सदाबहार युवा';

  @override
  String get theHiddenHeirYeChen => 'गुप्त उत्तराधिकारी ये चेन';

  @override
  String get extraordinary => 'असाधारण';

  @override
  String get sideStoryOfFoxVolant => 'फॉक्स वोलेंट की उपकथा';

  @override
  String get loveOfTheDivineTree => 'दिव्य वृक्ष का प्रेम';

  @override
  String get rebirth => 'पुनर्जन्म';

  @override
  String get moonlitReunion => 'चाँदनी रात का पुनर्मिलन';

  @override
  String get videoCountsCannotBeNegative =>
      'वीडियो की संख्या ऋणात्मक नहीं हो सकती।';

  @override
  String get publicDomainClassic => 'सार्वजनिक डोमेन क्लासिक';

  @override
  String get idioms => 'मुहावरे';

  @override
  String get news => 'समाचार';

  @override
  String get fairyTales => 'परियों की कहानियाँ';

  @override
  String get hereIsAFascinatingCulturalExplanati =>
      'यहाँ एक रोचक सांस्कृतिक व्याख्या है';

  @override
  String get videoFetchTimedOut => 'वीडियो लाने का समय समाप्त हो गया';

  @override
  String get aboutChannel => 'चैनल के बारे में';

  @override
  String get noVideosFound => 'कोई वीडियो नहीं मिला';

  @override
  String get failedToLoadVideos => 'वीडियो लोड करने में विफल';

  @override
  String get highqualityCuratedMandarinContentWi =>
      'सहज शब्दावली के साथ उच्च गुणवत्ता वाली चयनित मंदारिन सामग्री।';

  @override
  String get authenticSpokenChineseAcrossRealwor =>
      'वास्तविक दुनिया के विषयों पर प्रामाणिक बोलचाल की चीनी।';

  @override
  String get engagingVideoMaterialWithInteractiv =>
      'इंटरैक्टिव समकालिक उपशीर्षकों के साथ रोचक वीडियो सामग्री।';

  @override
  String get watchVideo => 'वीडियो देखें';

  @override
  String get culturalInsight => 'सांस्कृतिक दृष्टिकोण';

  @override
  String get aiIsAnalyzingCulturalContext =>
      'AI सांस्कृतिक संदर्भ का विश्लेषण कर रहा है...';

  @override
  String get diveIntoFullContent => 'पूरी सामग्री देखें';

  @override
  String get savedArticles => 'सहेजे गए लेख';

  @override
  String get liveOverlay => 'रीयल-टाइम रीडिंग असिस्टेंट';

  @override
  String get webExplorer => 'वेब एक्सप्लोरर';

  @override
  String get browseAnyChineseWebsiteWithRealtime =>
      'रीयल-टाइम टैप शब्दकोश, पिनयिन एनोटेशन और तुरंत अनुवाद के साथ किसी भी चीनी वेबसाइट को ब्राउज़ करें।';

  @override
  String get startExploring => 'अन्वेषण शुरू करें';

  @override
  String get chineseTvSeriesWithInteractiveSubti =>
      'इंटरैक्टिव उपशीर्षकों के साथ चीनी टीवी धारावाहिक';

  @override
  String get failedToLoadContent => 'सामग्री लोड करने में विफल';

  @override
  String get searchingYoutube => 'YouTube पर खोजा जा रहा है...';

  @override
  String get noVideosFoundTryADifferentSearchTer =>
      'कोई वीडियो नहीं मिला। कृपया अन्य खोज शब्द का प्रयास करें।';

  @override
  String get searching => 'खोजा जा रहा है';

  @override
  String get noShowsFound => 'कोई शो नहीं मिला';

  @override
  String get bookmarked => 'बुकमार्क किया गया';

  @override
  String get trailer1 => 'ट्रेलर';

  @override
  String get highlight1 => 'मुख्य अंश';

  @override
  String get noCaptionsAvailable => 'कोई उपशीर्षक उपलब्ध नहीं है';

  @override
  String get fetchingSubtitles => 'उपशीर्षक प्राप्त किए जा रहे हैं...';

  @override
  String get generatingAiBriefing => 'AI ब्रीफिंग तैयार की जा रही है...';

  @override
  String get noClosedCaptionsCcFoundForThisVideo =>
      'इस वीडियो के लिए कोई डिजिटल उपशीर्षक (CC) नहीं मिला।';

  @override
  String get videosWithHardcodedOrBurnedinSubtit =>
      'वीडियो में पहले से छपे हुए उपशीर्षकों के लिए YouTube पर डिजिटल टेक्स्ट ट्रैक उपलब्ध नहीं होते हैं।';

  @override
  String get translatingSubtitles => 'उपशीर्षकों का अनुवाद किया जा रहा है...';

  @override
  String get processingYourPronunciation =>
      'आपके उच्चारण का विश्लेषण किया जा रहा है...';

  @override
  String get couldntIdentifyLine => 'पंक्ति की पहचान नहीं हो सकी।';

  @override
  String get listeningSpeakNow => 'सुन रहे हैं... अब बोलें।';

  @override
  String get thisVideoDoesNotHaveADigitalClosedC =>
      'इस वीडियो में YouTube पर डिजिटल उपशीर्षक (CC) ट्रैक उपलब्ध नहीं है।';

  @override
  String get perfect1 => 'उत्तम';

  @override
  String get thisVideoHasBeenRemovedOrIsNoLonger =>
      'यह वीडियो हटा दिया गया है या अब उपलब्ध नहीं है।';

  @override
  String get thisVideoCannotBePlayedInTheAppYouC =>
      'यह वीडियो ऐप में नहीं चलाया जा सकता। आप इसे YouTube पर देख सकते हैं।';

  @override
  String get yourDeviceCannotPlayThisVideoPlease =>
      'आपका डिवाइस यह वीडियो नहीं चला सकता। कृपया कोई अन्य वीडियो आज़माएं।';

  @override
  String get invalidVideoReferencePleaseTryAgain =>
      'अमान्य वीडियो संदर्भ। कृपया पुनः प्रयास करें।';

  @override
  String get unableToLoadThisVideoPleaseTryAnoth =>
      'यह वीडियो लोड नहीं हो सका। कृपया कोई अन्य वीडियो आज़माएं।';

  @override
  String get startReading => 'पढ़ना शुरू करें';

  @override
  String get analyzingCulturalContext =>
      'सांस्कृतिक संदर्भ का विश्लेषण किया जा रहा है...';

  @override
  String get failedToLoadCulturalInsight =>
      'सांस्कृतिक जानकारी लोड करने में विफल।';

  @override
  String get historicalContext => 'ऐतिहासिक संदर्भ';

  @override
  String get culturalSignificance => 'सांस्कृतिक महत्व';

  @override
  String get authorBackground => 'लेखक की पृष्ठभूमि';

  @override
  String get k80CompleteClassicNovelsWorldEpics =>
      '80+ संपूर्ण शास्त्रीय उपन्यास और विश्व महाकाव्य';

  @override
  String get storyOfTheDay => 'आज की कहानी';

  @override
  String get tangDynasty => 'तांग राजवंश';

  @override
  String get poetryClassicalVerse => 'शास्त्रीय कविता और छंद';

  @override
  String get allHsk => 'सभी HSK स्तर';

  @override
  String get allStories => 'सभी कहानियाँ';

  @override
  String get keyWords => 'मुख्य शब्द';

  @override
  String get openOriginalWebsite => 'मूल वेबसाइट खोलें';

  @override
  String get aiReadingTools => 'AI पठन उपकरण';

  @override
  String get enhanceYourReadingWithAipoweredTool =>
      'AI-संचालित उपकरणों के साथ अपने पठन कौशल को बेहतर बनाएं';

  @override
  String get chooseTheTargetDifficultyForSimplif =>
      'सरलीकरण के लिए लक्षित कठिनाई स्तर चुनें';

  @override
  String get chooseDifficultyForSimplification =>
      'सरलीकरण के लिए कठिनाई स्तर चुनें';

  @override
  String get extractAllUnknownWordsToANewFlashca =>
      'सभी अज्ञात शब्दों को एक नए फ्लैशकार्ड डेक में निकालें';

  @override
  String get length => 'लंबाई';

  @override
  String get m1554846a550010707 => 'M15.54 8.46a5 5 0 0 1 0 7.07';

  @override
  String get m1907493a101000101414 => 'M19.07 4.93a10 10 0 0 1 0 14.14';

  @override
  String get webExtraction => 'वेब निष्कर्षण';

  @override
  String get aiTools => 'AI उपकरण';

  @override
  String get stop => 'रोकें';

  @override
  String get keepPracticing1 => 'अभ्यास जारी रखें';

  @override
  String get aiPrepRoom => 'AI तैयारी कक्ष';

  @override
  String get lessonSummary => 'पाठ सारांश';

  @override
  String get unlockSinosparkPremium => 'SinoSpark Premium अनलॉक करें';

  @override
  String get monthYear => 'माह / वर्ष';

  @override
  String get enableNotifications => 'सूचनाएं सक्षम करें';

  @override
  String get notificationsConfigured => 'सूचनाएं कॉन्फ़िगर की गईं';

  @override
  String get neverMissAStroke2 => 'कोई भी स्ट्रोक न चूकें';

  @override
  String get yourDailyDropAndStreakAlertsArePrim =>
      'आपकी दैनिक ड्रॉप और स्ट्रीक अलर्ट तैयार हैं।';

  @override
  String get stayConsistentWithDailyRitualDropsA =>
      'दैनिक अध्ययन और समय पर ट्रायल अलर्ट के साथ निरंतरता बनाए रखें।';

  @override
  String get aNewWordAndStoryWaitingForYourDaily =>
      'आपकी दैनिक अध्ययन दिनचर्या के लिए एक नया शब्द और कहानी तैयार है।';

  @override
  String get gentlePromptsBeforeCharactersFadeFr =>
      'वर्णों को भूलने से पहले सहायक अनुस्मारक।';

  @override
  String get receiveAReminder2DaysBeforeYourFree =>
      'निःशुल्क ट्रायल समाप्त होने से 2 दिन पहले अनुस्मारक प्राप्त करें।';

  @override
  String get yourPathTonchineseFluency => 'चीनी भाषा में प्रवाह की\nआपकी राह';

  @override
  String get answer3QuickQuestionsSoOurAiCanCraf =>
      '3 त्वरित प्रश्नों के उत्तर दें ताकि हमारा AI\nआपकी दिनचर्या के अनुकूल पाठ्यक्रम तैयार कर सके।';

  @override
  String get whatIsYourLevelnwithChinese => 'चीनी भाषा में आपका स्तर\nक्या है?';

  @override
  String get chooseThePathThatFitsYourDepth =>
      'वह विकल्प चुनें जो आपके वर्तमान ज्ञान के अनुकूल हो।';

  @override
  String get whatDrivesYourStudy => 'आप चीनी क्यों सीखना चाहते हैं?';

  @override
  String get purposeFuelsTheBrush => 'लक्ष्य से ही कला निखरती है';

  @override
  String get setYourDailyRitual => 'अपना दैनिक अध्ययन नियम निर्धारित करें।';

  @override
  String get youCanAdjustYourRitualAnyTime =>
      'आप अपनी दिनचर्या को कभी भी बदल सकते हैं।';

  @override
  String get letsBegin => 'आइए शुरू करें';

  @override
  String get brandNew => 'बिल्कुल नए शिक्षार्थी';

  @override
  String get iveNeverStudiedChineseBefore =>
      'मैंने पहले कभी चीनी भाषा नहीं सीखी है।';

  @override
  String get iKnowBasicCharactersAndPhrases =>
      'मुझे बुनियादी वर्ण और वाक्यांश आते हैं।';

  @override
  String get iCanHoldConversationsAndRead =>
      'मैं सामान्य बातचीत कर सकता/सकती हूँ और पढ़ सकता/सकती हूँ।';

  @override
  String get iWantToRefineAndPerfectMySkills =>
      'मैं अपने भाषा कौशल को और निखारना चाहता/चाहती हूँ।';

  @override
  String get confirmSelection => 'चयन की पुष्टि करें';

  @override
  String get purposeFuelsTheBrushsMotion =>
      'उद्देश्य ही स्ट्रोक को गति देता है।';

  @override
  String get buildMyPath => 'मेरा मार्ग तैयार करें';

  @override
  String get hskCertification => 'HSK प्रमाणन';

  @override
  String get culturalAppreciation => 'सांस्कृतिक रुचि';

  @override
  String get yourPlanIsReady => 'आपकी योजना तैयार है';

  @override
  String get craftingYourCurriculum => 'आपका पाठ्यक्रम तैयार किया जा रहा है...';

  @override
  String get personalizedPathInitialized => 'व्यक्तिगत शिक्षण पथ प्रारंभ';

  @override
  String get calibratingAiNeuralMasters =>
      'AI न्यूरल मास्टर्स कैलिब्रेट किए जा रहे हैं...';

  @override
  String get calibrationComplete => 'कैलिब्रेशन पूर्ण';

  @override
  String get synthesizingModules => 'मॉड्यूल तैयार किए जा रहे हैं...';

  @override
  String get oneAndWater => '«एक» और «जल»';

  @override
  String get theHorizontalStroke => 'क्षैतिज स्ट्रोक (HÉNG)';

  @override
  String get theRadical => 'रेडिकल';

  @override
  String get water => 'जल';

  @override
  String get river => 'नदी';

  @override
  String get day5Reminder => 'दिन 5 अनुस्मारक';

  @override
  String get wePromisedToAlertYou2DaysBeforeYour =>
      'हमने आपसे वादा किया था कि ट्रायल समाप्त होने से 2 दिन पहले हम आपको सूचित करेंगे।';

  @override
  String get continueWithoutReminder => 'बिना अनुस्मारक के जारी रखें';

  @override
  String get masterChineseWithnsinospark =>
      'SinoSpark के साथ चीनी में\nमहारत हासिल करें';

  @override
  String get start7dayFreeTrial => '7-दिवसीय निःशुल्क ट्रायल शुरू करें';

  @override
  String get precisionStrokes => 'सटीक स्ट्रोक';

  @override
  String get aiPronunciation => 'AI उच्चारण';

  @override
  String get today => 'आज';

  @override
  String get fullAccess => 'पूर्ण एक्सेस';

  @override
  String get day5 => 'दिन 5';

  @override
  String get reminder => 'अनुस्मारक';

  @override
  String get day7 => 'दिन 7';

  @override
  String get trialBegins => 'ट्रायल प्रारंभ';

  @override
  String get revenuecatIsMissingACurrentOffering =>
      'RevenueCat में कोई सक्रिय पैकेज उपलब्ध नहीं है। कृपया अपना डैशबोर्ड कॉन्फ़िगर करें।';

  @override
  String get cameraPermissionRequiredForLiveScan =>
      'लाइव स्कैन के लिए कैमरा अनुमति आवश्यक है।';

  @override
  String get cameraAccessRequired => 'कैमरा एक्सेस आवश्यक है';

  @override
  String get pleaseEnableCameraAccessInYourDevic =>
      'इस सुविधा का उपयोग करने के लिए कृपया अपनी डिवाइस सेटिंग्स में कैमरा एक्सेस सक्षम करें।';

  @override
  String get alignChineseTextWithinFrame =>
      'फ़्रेम के भीतर चीनी पाठ को संरेखित करें';

  @override
  String get inLibrary => 'लाइब्रेरी में';

  @override
  String get novice => 'शुरुआती';

  @override
  String get apprentice => 'शिक्षार्थी';

  @override
  String get artisan => 'शिल्पकार';

  @override
  String get grandmaster => 'महागुरु';

  @override
  String get poem => 'कविता';

  @override
  String get theNarrative => 'कथा';

  @override
  String get classicMasterpiece => 'शास्त्रीय उत्कृष्ट कृति';

  @override
  String get classicAuthor => 'शास्त्रीय लेखक';

  @override
  String get classical => 'शास्त्रीय';

  @override
  String get classicLiterature => 'शास्त्रीय साहित्य';

  @override
  String inThisChapterOf(Object title) {
    return '$title के इस अध्याय में';
  }

  @override
  String get asTheNarrativeUnfoldsItIlluminatesT =>
      'जैसे-जैसे कहानी आगे बढ़ती है, यह जीवन के मूलभूत ज्ञान और प्रेरणा को उजागर करती है।';

  @override
  String get general => 'सामान्य';

  @override
  String get mythology => 'पौराणिक कथाएँ';

  @override
  String get dailyLife => 'दैनिक जीवन';

  @override
  String get tangPoetry => 'तांग कविता';

  @override
  String get classicalLiterature => 'शास्त्रीय साहित्य';

  @override
  String get justNow => 'अभी-अभी';

  @override
  String get theTerracottaArmyOfQinShiHuang => 'किन शी हुआंग की टेराकोटा सेना';

  @override
  String get lifeInsideTheForbiddenCity => 'फॉरबिडन सिटी के भीतर का जीवन';

  @override
  String get buyingATicketAndTakingTheHighSpeedT =>
      'टिकट खरीदना और हाई-स्पीड ट्रेन से यात्रा करना';

  @override
  String get goingToTheHospitalForAColdAndSeeing =>
      'सर्दी-जुकाम के लिए डॉक्टर के पास जाना';

  @override
  String get goingToALocalRestaurantToOrderJiaoz =>
      'स्थानीय रेस्तरां में जियाओज़ी (डंपलिंग) ऑर्डर करना';

  @override
  String get theTraditionalGongfuTeaCeremony => 'पारंपरिक गोंगफू चाय समारोह';

  @override
  String get theArtOfWritingChineseCharactersWit =>
      'ब्रश से चीनी वर्ण लिखने की कला';

  @override
  String get theLifeAndConservationOfGiantPandas =>
      'विशाल पांडा का जीवन और संरक्षण';

  @override
  String get storyNotFoundInDatabase => 'कहानी डेटाबेस में नहीं मिली';

  @override
  String get storyTextIsEmpty => 'कहानी का पाठ रिक्त है';

  @override
  String get myCustomStories => 'मेरी कस्टम कहानियाँ';

  @override
  String get userProvidedText => 'उपयोगकर्ता द्वारा प्रदान किया गया पाठ';

  @override
  String get local => 'स्थानीय';

  @override
  String get voiceEngineAllowance => 'वॉयस इंजन और कोटा';

  @override
  String get studioHdVsUnlimitedStandardVoice =>
      'Studio HD बनाम असीमित मानक आवाज़';

  @override
  String get standardVoiceIs100UnlimitedFree =>
      'मानक आवाज़ 100% असीमित और निःशुल्क है';

  @override
  String get read => 'पढ़ें';

  @override
  String get koreKoreFemaleWarm => 'Kore (स्त्रीलिंग, सौम्य)';

  @override
  String get aoedeAoedeFemaleCheerful => 'Aoede (स्त्रीलिंग, प्रफुल्लित)';

  @override
  String get fenrirFenrirMaleUpbeat => 'Fenrir (पुल्लिंग, उत्साही)';

  @override
  String get charonCharonMaleNewsstyle => 'Charon (पुल्लिंग, समाचार शैली)';

  @override
  String get puckPuckMaleSporty => 'Puck (पुल्लिंग, स्पोर्टी)';

  @override
  String get localOndevice => 'स्थानीय (डिवाइस आवाज़)';

  @override
  String get localOndeviceTts => 'स्थानीय ऑन-डिवाइस TTS';

  @override
  String get off => 'बंद';

  @override
  String get endOfCurrentChapter => 'वर्तमान अध्याय समाप्त';

  @override
  String get standardVoice => 'मानक आवाज़';

  @override
  String get noNovelsFoundMatchingYourFilter =>
      'आपके फ़िल्टर से मेल खाता कोई उपन्यास नहीं मिला।';

  @override
  String get noMicroreadsFoundMatchingYourFilter =>
      'आपके फ़िल्टर से मेल खाती कोई माइक्रो-रीडिंग नहीं मिली।';

  @override
  String get noPoemsFoundMatchingYourFilter =>
      'आपके फ़िल्टर से मेल खाती कोई कविता नहीं मिली।';

  @override
  String get audiobook => 'ऑडियोबुक';

  @override
  String get audio => 'ऑडियो';

  @override
  String get continueReading => 'पढ़ना जारी रखें';

  @override
  String get search96FullNovelsAuthorsEpics =>
      '96 संपूर्ण उपन्यास, लेखक और महाकाव्य खोजें...';

  @override
  String get searchClassicalPoemsAuthorsVerses =>
      'शास्त्रीय कविताएं, लेखक और छंद खोजें...';

  @override
  String get allLevelsVal => 'सभी स्तर';

  @override
  String get hsk1BeginnerVal => 'HSK 1 (शुरुआती)';

  @override
  String get hsk2ElementaryVal => 'HSK 2 (प्रारंभिक)';

  @override
  String get hsk3IntermediateVal => 'HSK 3 (मध्यवर्ती)';

  @override
  String get hsk4UpperIntVal => 'HSK 4 (उच्च-मध्यवर्ती)';

  @override
  String get listenToAudiobook => 'ऑडियोबुक सुनें';

  @override
  String get synopsis => 'सारांश';

  @override
  String get peoplesArtist => 'जन कलाकार';

  @override
  String get kafkaesqueForBureaucraticAbsurdityA =>
      '«काफ्काएस्क» नौकरशाही की विसंगतियों और अस्तित्वगत संकट के लिए।';

  @override
  String get bigBrotherAndNewspeak => '«बिग ब्रदर» और «न्यूस्पीक»।';

  @override
  String get audiobookIncluded => 'ऑडियोबुक शामिल है';

  @override
  String get readPoem => 'कविता पढ़ें';

  @override
  String get studioVoiceAllowance => 'Studio आवाज़ कोटा';

  @override
  String get weeklyHighdefinitionAiRecitation =>
      'साप्ताहिक हाई-डेफिनिशन AI पाठ';

  @override
  String get resetsEveryMondayAt0000 =>
      'प्रत्येक सोमवार 00:00 बजे रीसेट होता है';

  @override
  String get whenYourWeekly4hourStudioAllowanceI =>
      'जब आपका साप्ताहिक 4 घंटे का Studio कोटा समाप्त हो जाता है, तो ऐप बिना किसी रुकावट के असीमित सुनने के लिए ऑन-डिवाइस आवाज़ पर स्विच हो जाता है।';

  @override
  String get localDeviceVoice => 'स्थानीय डिवाइस आवाज़';

  @override
  String get classicalVerse => 'शास्त्रीय छंद';

  @override
  String get ondeviceVoice4hWeeklyUsed =>
      'डिवाइस आवाज़ (साप्ताहिक 4 घंटे प्रयुक्त)';

  @override
  String get generateACustomAiStoryBasedOnYourIn =>
      'अपनी रुचियों के आधार पर एक कस्टम AI कहानी बनाएं';

  @override
  String get insteadOfAFixedHskLevelTheFlowState =>
      'किसी निश्चित स्तर तक सीमित रहने के बजाय, डायनामिक इंजन आपके व्यक्तिगत कार्ड संग्रह का मूल्यांकन करता है।';

  @override
  String get we => 'हम';

  @override
  String get howCanWeHelpYou => 'हम आपकी क्या सहायता कर सकते हैं?';

  @override
  String get everythingYouNeedToKnowAboutHanziMa =>
      'SinoSpark, इसकी विशेषताओं और आपकी गोपनीयता के बारे में सभी आवश्यक जानकारी।';

  @override
  String get whoAreTheVoicesSpeakingInTheApp =>
      'ऐप में बोलने वाले वक्ता कौन हैं?';

  @override
  String get howDoesTheWebExplorerWork => 'वेब एक्सप्लोरर कैसे काम करता है?';

  @override
  String get whatIsZenMode => 'ज़ेन मोड क्या है?';

  @override
  String get howDoesTheFlashcardSpacedrepetition =>
      'फ़्लैशकार्ड अंतराल पुनरावृत्ति प्रणाली कैसे काम करती है?';

  @override
  String get traceComplete => 'ट्रेसिंग पूर्ण!';

  @override
  String get traceCharacter => 'वर्ण ट्रेस करें';

  @override
  String get analyzingWordRelationships =>
      'शब्द संबंधों का विश्लेषण किया जा रहा है...';

  @override
  String get identifyingUsageContexts =>
      'उपयोग संदर्भों की पहचान की जा रही है...';

  @override
  String get comparingFormalityLevels =>
      'औपचारिकता के स्तरों की तुलना की जा रही है...';

  @override
  String get findingCommonCollocations =>
      'सामान्य सह-प्रयोगों की खोज की जा रही है...';

  @override
  String get generatingComparison =>
      'तुलनात्मक विश्लेषण तैयार किया जा रहा है...';

  @override
  String get generationIsTakingLongerThanExpecte =>
      'प्रक्रिया में अधिक समय लग रहा है। AI सर्वर पर अत्यधिक लोड हो सकता है।';

  @override
  String get generationInterruptedShowingPartial =>
      'प्रक्रिया बाधित हुई। आंशिक परिणाम दिखाया जा रहा है।';

  @override
  String get sorrySomethingWentWrong =>
      'क्षमा करें, कोई तकनीकी समस्या उत्पन्न हुई।';

  @override
  String get usage => 'प्रयोग:';

  @override
  String get alsoSeenIn => 'यहाँ भी प्रयुक्त';

  @override
  String get quickLook => 'त्वरित अवलोकन';

  @override
  String get notFound => 'नहीं मिला';

  @override
  String get errorLoadingFromAi => 'AI से डेटा लोड करने में त्रुटि।';

  @override
  String get analyzingImage => 'छवि का विश्लेषण किया जा रहा है...';

  @override
  String get extractingChineseText => 'चीनी पाठ निकाला जा रहा है...';

  @override
  String get lookingUpVocabulary => 'शब्दावली खोजी जा रही है...';

  @override
  String get dreamOfTheRedChamber =>
      'लाल कक्ष का सपना (Dream of the Red Chamber)';

  @override
  String get journeyToTheWest => 'पश्चिम की यात्रा (Journey to the West)';

  @override
  String get romanceOfTheThreeKingdoms =>
      'तीन साम्राज्यों का रोमांस (Romance of the Three Kingdoms)';

  @override
  String get mingDynasty => 'मिंग राजवंश';

  @override
  String get wuChengEn => 'वू चेंग\'एन';

  @override
  String get hundredChapters => '100 अध्याय';

  @override
  String get volume1 => 'खंड 1';

  @override
  String bookmarksCount(Object count) {
    return 'बुकमार्क ($count)';
  }

  @override
  String get noBookmarksYet =>
      'अभी तक कोई बुकमार्क नहीं है। किसी अंश को सहेजने के लिए बुकमार्क आइकन पर टैप करें।';

  @override
  String get sinosparkIsNotResponding => 'SinoSpark जवाब नहीं दे रहा है';

  @override
  String get closeApp => 'ऐप बंद करें';

  @override
  String get wait => 'प्रतीक्षा करें';

  @override
  String studioHdAllowance(Object hours) {
    return 'Studio HD: $hours घंटे';
  }

  @override
  String bookPercentRead(Object percent) {
    return '$percent% पढ़ा गया';
  }

  @override
  String chAbbreviation(Object number) {
    return 'अध्याय $number';
  }

  @override
  String booksAndAudiobooks(Object count) {
    return '$count पुस्तकें और ऑडियोबुक';
  }

  @override
  String sentenceXOfY(Object current, Object total) {
    return 'वाक्य $current/$total';
  }

  @override
  String chapterXOfY(Object current, Object total) {
    return 'अध्याय $current/$total';
  }

  @override
  String get allLevels => 'सभी स्तर';

  @override
  String get searchGradedMicroStories =>
      'श्रेणीबद्ध लघु कहानियों और नीति-कथाओं में खोजें...';

  @override
  String gradedStoriesAndMicroReads(Object count) {
    return '$count श्रेणीबद्ध कहानियाँ और दैनिक पठन';
  }

  @override
  String get searchClassicalPoems =>
      'शास्त्रीय कविताओं, रचयिताओं और छंदों में खोजें...';

  @override
  String classicalPoemsAndVerse(Object count) {
    return '$count शास्त्रीय कविताएँ और छंद';
  }

  @override
  String get browseAnyChineseWebsite =>
      'रीयल-टाइम टैप शब्दकोश, पिनयिन एनोटेशन और तुरंत अनुवाद के साथ किसी भी चीनी वेबसाइट को ब्राउज़ करें।';

  @override
  String get completed => 'पूर्ण';

  @override
  String get aiIsReading => 'AI पढ़ रहा है...';

  @override
  String get bbcVerify => 'BBC Verify';

  @override
  String get hsk5AdvancedVal => 'HSK 5 (उन्नत)';

  @override
  String get hsk1Beginner => 'HSK 1 (शुरुआती)';

  @override
  String get hsk4UpperInt => 'HSK 4 (उच्च-मध्यवर्ती)';

  @override
  String get extractAllUnknownWords =>
      'सभी अज्ञात शब्दों को एक नए फ्लैशकार्ड डेक में निकालें';

  @override
  String get designCustomAiRoleplay =>
      'कस्टम AI रोलप्ले और बातचीत डिज़ाइन करें';

  @override
  String get practiceFlashcardVocabulary =>
      'लाइव संवाद में फ्लैशकार्ड शब्दावली का अभ्यास करें';

  @override
  String get surpriseMe => 'मुझे आश्चर्यचकित करें';

  @override
  String get rollCharacter => 'यादृच्छिक पात्र चुनें';

  @override
  String get historicalCostume => 'ऐतिहासिक / पोशाक ड्रामा';

  @override
  String get modernYouth => 'आधुनिक और युवा';

  @override
  String get fantasyMythology => 'फैंटेसी और पौराणिक कथाएँ';

  @override
  String get familyDrama => 'पारिवारिक ड्रामा';

  @override
  String get fullVersion => 'पूर्ण संस्करण';

  @override
  String episodesCount(Object count) {
    return '$count एपिसोड';
  }

  @override
  String episodeLabel(Object number) {
    return 'एपिसोड $number';
  }

  @override
  String get translating => '[ अनुवाद जारी है... ]';

  @override
  String get engSub => '[उपशीर्षक: हिंदी]';

  @override
  String get standardVocabulary => 'मानक शब्दावली';

  @override
  String get characters => 'वर्ण';

  @override
  String get todayDashboard => 'आज';

  @override
  String get studyToday => 'आज के कार्ड का अध्ययन करें';

  @override
  String get studyAhead => 'समय से पहले पढ़ें';

  @override
  String get studyAheadDescription =>
      'आज के कोटे का उपयोग किए बिना आगामी समीक्षाओं का अभ्यास करें। कोई नए कार्ड शामिल नहीं किए जाएंगे।';

  @override
  String get studyAheadComplete => 'समय से पहले अभ्यास पूरा हुआ';

  @override
  String get dueNow => 'अभी बकाया';

  @override
  String get scheduled => 'निर्धारित';

  @override
  String get sevenDayForecast => '7-दिवसीय समीक्षा अनुमान';

  @override
  String get reviews => 'समीक्षाएँ';

  @override
  String get newCardsLabel => 'नए कार्ड';

  @override
  String get attempts => 'प्रयास';

  @override
  String get duration => 'समय';

  @override
  String get answerBreakdown => 'उत्तर विवरण';

  @override
  String get reviewCards => 'समीक्षा कार्ड';

  @override
  String get retries => 'पुनः प्रयास';

  @override
  String get needsPractice => 'अभ्यास की आवश्यकता';

  @override
  String get uniqueCardsStudied => 'कार्ड';

  @override
  String get dartConvert => 'dart:convert';

  @override
  String get env => '.env';

  @override
  String get dartUi => 'dart:ui';

  @override
  String get dartMath => 'dart:math';

  @override
  String get drawInTheOtherDirection => 'दूसरी दिशा में बनाएं ➔';

  @override
  String get fastClean => 'तेज़ और साफ़!';

  @override
  String get good2 => 'अच्छा!';

  @override
  String get followTheFlow => 'प्रवाह का पालन करें।';

  @override
  String get masterful => 'उत्कृष्ट!';

  @override
  String get missingTheHookEnd => 'हुक/अंत गायब है।';

  @override
  String get thai => 'थाई';

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
  String get ink => 'स्याही,';

  @override
  String get stroke => 'स्ट्रोक,';

  @override
  String get breath => 'सांस।';

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
  String get theExactSentenceProvided => 'प्रदान किया गया सटीक वाक्य';

  @override
  String get pinyinWithToneMarks2 => 'स्वर चिह्नों के साथ पिनयिन';

  @override
  String get wXHuNH => 'Wǒ xǐhuān hē píngguǒzhī.';

  @override
  String get extractAllChineseCharactersFrom =>
      'इस छवि से सभी चीनी वर्ण निकालें। केवल निकाला गया पाठ ही लौटाएं — कोई टिप्पणी नहीं, कोई प्रारूपण नहीं, कोई अनुवाद नहीं। पंक्ति विच्छेद बनाए रखें। यदि कोई चीनी वर्ण नहीं हैं, तो एक खाली स्ट्रिंग लौटाएं।';

  @override
  String get householdObject => 'घरेलू वस्तु';

  @override
  String get genericLabelFromTheList => 'सूची से सामान्य लेबल';

  @override
  String get gNgS => 'gōng sī';

  @override
  String get measureWord => 'मापक शब्द';

  @override
  String get zenInk => 'ज़ेन और स्याही';

  @override
  String get cRITICALPutTheEnglishTranslation =>
      'महत्वपूर्ण: \"english\" JSON कुंजी में अंग्रेजी अनुवाद डालें!';

  @override
  String get definitionInEnglish => 'अंग्रेजी में परिभाषा';

  @override
  String get simplifiedLine0 => 'सरलीकृत पंक्ति 0';

  @override
  String get simplifiedLine1 => 'सरलीकृत पंक्ति 1';

  @override
  String get iMPORTANTRULEDoNotAddress =>
      'महत्वपूर्ण नियम: उपयोगकर्ता को किसी भी नाम से संबोधित न करें। \"John\" जैसे प्लेसहोल्डर नामों का उपयोग कभी न करें। बिना नाम के सीधे उनसे बात करें।';

  @override
  String get rULESAnswerIn23 =>
      'नियम: अधिकतम 2-3 वाक्यों में उत्तर दें। सूचियों के लिए बुलेट पॉइंट्स को प्राथमिकता दें।';

  @override
  String get neverWriteIntroductionsSignOffs =>
      'कभी भी परिचय, समापन या \"शानदार प्रश्न!\" या \"निश्चित रूप से!\" जैसे निरर्थक वाक्यांश न लिखें।';

  @override
  String get useBoldForChineseCharacters =>
      'चीनी अक्षरों और प्रमुख शब्दों के लिए **बोल्ड** का प्रयोग करें।';

  @override
  String get rULESAnswerIn232 => 'नियम: अधिकतम 2-3 वाक्यों में उत्तर दें।';

  @override
  String get accept => 'स्वीकार करें';

  @override
  String get pronunciationAssessment => 'उच्चारण-मूल्यांकन';

  @override
  String get nBest => 'NBest';

  @override
  String get none => 'कोई नहीं';

  @override
  String get theCorrectedChineseText => 'संशोधित चीनी पाठ';

  @override
  String get thePinyinForTheCorrected => 'संशोधित पाठ का पिनयिन';

  @override
  String get theEnglishMeaningOfThe => 'संशोधित पाठ का अंग्रेजी अर्थ';

  @override
  String get pNyNWithTone => 'स्वर चिह्नों के साथ पिनयिन';

  @override
  String get englishTranslation2 => 'अंग्रेजी अनुवाद';

  @override
  String get zhNggu => 'Zhōngguó';

  @override
  String get youAreAChineseClassical =>
      'आप एक चीनी शास्त्रीय साहित्य विशेषज्ञ हैं जो चीनी शास्त्रीय कविता के विस्तृत और सुलभ सारांश प्रदान करते हैं।';

  @override
  String get youAreAChineseCulture =>
      'आप एक चीनी संस्कृति और साहित्य विशेषज्ञ हैं। अत्यधिक आकर्षक और सुंदर ढंग से लिखी गई सांस्कृतिक अंतर्दृष्टि प्रदान करें।';

  @override
  String get english2 => 'अंग्रेजी:';

  @override
  String get remindersWhenYouHavenT =>
      'जब आपने कुछ दिनों से ऐप का उपयोग न किया हो तब रिमाइंडर';

  @override
  String get itSBeenAFew =>
      'कुछ दिन हो गए हैं! आज एक नया हांज़ी सीखने के लिए 5 मिनट निकालें।';

  @override
  String get abbreviationFor => 'का संक्षिप्त रूप';

  @override
  String get cL => 'CL:';

  @override
  String get measureWord2 => 'मापक शब्द:';

  @override
  String get lu => 'lu:';

  @override
  String get luE => 'lu:e';

  @override
  String get nu => 'nu:';

  @override
  String get nuE => 'nu:e';

  @override
  String get noUser => 'उपयोगकर्ता-नहीं';

  @override
  String get passwordRequired => 'पासवर्ड-आवश्यक';

  @override
  String get unsupportedProvider => 'असमर्थित-प्रदाता';

  @override
  String get appleRevocationUnavailable => 'ऐप्पल-रद्दीकरण-अनुपलब्ध';

  @override
  String get appleCredentialMissing => 'ऐप्पल-प्रमाण-गायब';

  @override
  String get authenticationDidNotReturnA =>
      'प्रमाणीकरण से कोई उपयोगकर्ता नहीं मिला।';

  @override
  String get viewSubscriptionPlans => 'सदस्यता योजनाएं देखें';

  @override
  String get wrongPassword => 'गलत-पासवर्ड';

  @override
  String get invalidCredential => 'अमान्य-प्रमाण-पत्र';

  @override
  String get networkRequestFailed => 'नेटवर्क-अनुरोध-विफल';

  @override
  String get requiresRecentLogin => 'हालिया-लॉगिन-आवश्यक';

  @override
  String get userMismatch => 'उपयोगकर्ता-बेमेल';

  @override
  String get deleteAccountPassword => 'खाता-हटाने-का-पासवर्ड';

  @override
  String get deleteAccountError => 'खाता-हटाने-में-त्रुटि';

  @override
  String get deleteAccountSubmit => 'खाता-हटाना-सबमिट';

  @override
  String get theSimplestShapesTheBeginning =>
      'सबसे सरल आकृतियां। सभी चीजों की शुरुआत।';

  @override
  String get sunMoonWaterAndFire =>
      'सूर्य, चंद्रमा, जल और अग्नि। प्राकृतिक दुनिया।';

  @override
  String get theBodyTheHeartAnd => 'शरीर, हृदय और परिवार।';

  @override
  String get fieldsRoofsAndToolsThe => 'खेत, छतें और औजार। समाज की नींव।';

  @override
  String get movementSpeechAndSustenance => 'गति, वाणी और जीविका।';

  @override
  String get commerceClothingAndComplexArtifacts =>
      'व्यापार, वस्त्र और जटिल वस्तुएँ।';

  @override
  String get fastTrackSimpleCharacterMastered =>
      '🚀 फ़ास्ट ट्रैक! सरल अक्षर सीख लिया।';

  @override
  String get excellentPrecisionGhostTraceSkipped =>
      '⚡ बेहतरीन सटीकता! घोस्ट ट्रेस छोड़ा गया।';

  @override
  String get sample => 'नमूना:';

  @override
  String get itsThat => 'इसका/वह';

  @override
  String get iMe => 'मैं/मुझे';

  @override
  String get stillTough => 'अभी भी/कठिन';

  @override
  String get partDecide => 'भाग/तय करना';

  @override
  String get selectTheCharacterFor => 'इसके लिए अक्षर चुनें:';

  @override
  String get selectThePinyinFor => 'इसके लिए पिनयिन चुनें:';

  @override
  String get whereAreYouGoingThe =>
      'आप कहाँ जा रहे हैं? हवाई अड्डा? यह तो काफी लंबी यात्रा है!';

  @override
  String get youAreAuntieChenA =>
      'आप आंटी चेन हैं, जो रेशम और कपड़े बेचने वाली एक चतुर बाज़ार विक्रेता हैं। आपकी एकमात्र भूमिका एक बाज़ार विक्रेता की है। मंदारिन में मजबूती से लेकिन निष्पक्ष रूप से कीमतों पर मोल-भाव करें। कभी भी चरित्र से बाहर न आएं या खुद का परिचय विक्रेता के अलावा किसी अन्य रूप में न दें। ऊंची कीमतों से शुरुआत करें और मोल-भाव करने के लिए तैयार रहें।';

  @override
  String get youAreDrZhangA =>
      'आप डॉ. झांग हैं, जो एक मेडिकल क्लिनिक में शांत और पेशेवर डॉक्टर हैं। आपकी एकमात्र भूमिका एक डॉक्टर की है। मंदारिन में स्वास्थ्य संबंधी लक्षणों के बारे में पूछें और चिकित्सीय सलाह दें। कभी भी चरित्र से बाहर न आएं या खुद का परिचय डॉक्टर के अलावा किसी अन्य रूप में न दें। आश्वस्त करने वाले लेकिन पूरी तरह से गहन रहें।';

  @override
  String get whereDoYouFeelUncomfortable =>
      'आपको कहाँ असहज महसूस हो रहा है? क्या आपको बुखार है?';

  @override
  String get youAreACloseFriend =>
      'आप एक घनिष्ठ मित्र हैं जो लंबे समय बाद हाल-चाल ले रहे हैं। आपकी एकमात्र भूमिका एक मित्र की है। मंदारिन में उत्तर अनौपचारिक, गर्मजोशी से भरे और छोटे रखें। कभी भी चरित्र से बाहर न आएं या खुद का परिचय मित्र के अलावा किसी अन्य रूप में न दें। घनिष्ठ मित्रों के लिए उपयुक्त अनौपचारिक भाषा शैली का उपयोग करें।';

  @override
  String get noNbest => 'कोई nbest नहीं';

  @override
  String get timedOut => 'समय समाप्त';

  @override
  String get grading => 'मूल्यांकन हो रहा है...';

  @override
  String get label1st => 'पहला ˉ';

  @override
  String get label2nd => 'दूसरा ˊ';

  @override
  String get label3rd => 'तीसरा ˇ';

  @override
  String get label4th => 'चौथा ˋ';

  @override
  String get speaking2 => 'बोल रहे हैं...';

  @override
  String get sessionCompletedInYourNext =>
      'सत्र पूरा हुआ। अपने अगले अभ्यास में, विस्तृत उच्चारण और स्वर विश्लेषण प्राप्त करने के लिए पूरे वाक्य बोलें।';

  @override
  String get craneSoaring => 'उड़ता सारस';

  @override
  String get gentleStream => 'शांत धारा';

  @override
  String get brushAndInk => 'ब्रश और स्याही';

  @override
  String get myStudent => 'मेरा छात्र';

  @override
  String get honoredDisciple => 'आदरणीय शिष्य';

  @override
  String get notEnoughInformation => 'पर्याप्त जानकारी नहीं';

  @override
  String get asAnAi => 'एक AI के रूप में';

  @override
  String get goodPracticeSessionContinueFocusing =>
      'अच्छा अभ्यास सत्र। स्पष्ट स्वर उतार-चढ़ाव और स्वाभाविक बातचीत की गति पर ध्यान केंद्रित करना जारी रखें।';

  @override
  String get insideASleekFuxingBullet =>
      'बीजिंग से शंघाई तक 350 किमी/घंटा की गति से चल रही एक आधुनिक फ़ूशिंग बुलेट ट्रेन के भीतर।';

  @override
  String get harbinIceSnowWorldWonder => 'हार्बिन आइस एंड स्नो वर्ल्ड वंडर';

  @override
  String get theFamousPanjiayuanWeekendFlea =>
      'प्रसिद्ध पंजियायुआन वीकेंड फ़्ली मार्केट, जो सुलेख स्क्रॉल, नीलम और विंटेज आभूषणों से भरा है।';

  @override
  String get jingdezhenBlueWhitePorcelainStudio =>
      'जिंगदेझेन ब्लू एंड व्हाइट पोर्सलेन स्टूडियो';

  @override
  String get pekingOperaDressingRoomMakeup =>
      'पेकिंग ओपेरा ड्रेसिंग रूम और मेकअप';

  @override
  String get aHistoricTongrentangApothecaryScented =>
      'जिंसेंग, वॉल्फ़बेरी और सैकड़ों लकड़ी की जड़ी-बूटियों की दराज़ों की खुशबू वाला एक ऐतिहासिक टोंगरेनटैंग दवाखाना।';

  @override
  String get aVibrantPrivateNeonLit =>
      'शेन्ज़ेन में माइक्रोफ़ोन, फल की प्लेटों और स्क्रीन नियंत्रणों के साथ एक जीवंत निजी नियॉन-रोशनी वाला कराओके कमरा।';

  @override
  String get animeCosplayExpoInGuangzhou =>
      'ग्वांगझू में एनीमे और कॉसप्ले एक्सपो';

  @override
  String get nHOHuNy =>
      'Nǐ hǎo! Huānyíng lái dào zhèlǐ, jīntiān wǒmen liáo xiē shénme ne?';

  @override
  String get surpriseMe2 => '🎲 मुझे सरप्राइज करें';

  @override
  String get eGALivelyBanquet => 'उदा. शंघाई में जश्न मनाती एक जीवंत दावत...';

  @override
  String get rollCharacter2 => '🎲 पात्र चुनें';

  @override
  String get eGACuriousCousin =>
      'उदा. आपके करियर के बारे में पूछता एक उत्सुक चचेरा भाई...';

  @override
  String get keepTrying => 'कोशिश करते रहें!';

  @override
  String get pending => 'लंबित...';

  @override
  String get expected => '🎯 अपेक्षित';

  @override
  String get hSK2Elementary => 'HSK 2: प्रारंभिक';

  @override
  String get hSK3Intermediate => 'HSK 3: मध्यम';

  @override
  String get hSK5Advanced => 'HSK 5: उन्नत';

  @override
  String get expressYourselfFullyWith5000 =>
      '5000+ शब्दों के साथ खुद को पूरी तरह से व्यक्त करें।';

  @override
  String get hanziWriter => 'hanzi-writer';

  @override
  String get hvg => 'hvg:';

  @override
  String get unlimited => 'असीमित';

  @override
  String get dueToday => 'आज देय';

  @override
  String get newAvailable => 'नए उपलब्ध';

  @override
  String get deleteAccountTile => 'delete-account-tile';

  @override
  String get giveASingleShortPractical =>
      'गलत तरीके से खींचे गए स्ट्रोक के आकार, स्थिति या लंबाई को सुधारने के लिए एक छोटा, व्यावहारिक सुझाव दें। स्पष्ट और मददगार रहें, काव्यात्मक न बनें। मार्कडाउन का उपयोग न करें।';

  @override
  String get localOnDeviceTTS => 'लोकल — ऑन-डिवाइस TTS';

  @override
  String get espaOl => 'स्पेनिश';

  @override
  String get franAis => 'फ्रेंच';

  @override
  String get portuguS => 'पुर्तगाली';

  @override
  String get tiNgViT => 'वियतनामी';

  @override
  String get koreFemaleWarm => 'कोर — महिला, गर्मजोश';

  @override
  String get aoedeFemaleCheerful => 'अओएड — महिला, हंसमुख';

  @override
  String get fenrirMaleUpbeat => 'फेनरिर — पुरुष, उत्साही';

  @override
  String get charonMaleNewsStyle => 'कैरोन — पुरुष, समाचार-शैली';

  @override
  String get puckMaleSporty => 'पक — पुरुष, स्पोर्टी';

  @override
  String get systemVoice => 'सिस्टम आवाज़';

  @override
  String get generateAdd => 'बनाएं और जोड़ें';

  @override
  String get moreExamples => '📝 और उदाहरण';

  @override
  String get usage2 => '❓ उपयोग';

  @override
  String get translation => '💬 अनुवाद';

  @override
  String get collocations => '📚 शब्द-संयोजन';

  @override
  String get mistakes => '❌ गलतियाँ';

  @override
  String get decrease => 'घटाएं';

  @override
  String get increase => 'बढ़ाएं';

  @override
  String get label0MeansThisCardType =>
      '0 का मतलब है कि यह कार्ड प्रकार निष्क्रिय है।';

  @override
  String get tapTheValueToEnter =>
      'सटीक सीमा दर्ज करने के लिए मान पर टैप करें।';

  @override
  String get exactDailyLimit => 'सटीक दैनिक सीमा';

  @override
  String get enter0ToDisable => 'निष्क्रिय करने के लिए 0 दर्ज करें।';

  @override
  String get apply => 'लागू करें';

  @override
  String get selectDeck => 'डेक चुनें';

  @override
  String get azureSpeechKeysNotConfigured =>
      'Azure Speech कुंजियाँ कॉन्फ़िगर नहीं की गई हैं। .env में AZURE_SPEECH_KEY और AZURE_SPEECH_REGION जोड़ें';

  @override
  String get sTARTING => 'शुरू हो रहा है…';

  @override
  String get sTARTSESSION => 'सत्र शुरू करें';

  @override
  String get translating2 => 'अनुवाद हो रहा है...';

  @override
  String get chai => '柴知道Chai...';

  @override
  String get oneInABillion2 => '@One-In-a-Billion';

  @override
  String get businessEconomics => 'व्यापार और अर्थशास्त्र';

  @override
  String get hskPreparation => 'HSK तैयारी';

  @override
  String get liveInChina => 'चीन में रहना';

  @override
  String get comprehensiveExercise => 'व्यापक अभ्यास';

  @override
  String get howToUse => 'उपयोग कैसे करें';

  @override
  String get usesOf => 'के उपयोग';

  @override
  String get appearedFirstOnMandarinBean =>
      'सबसे पहले Mandarin Bean पर दिखाई दिया';

  @override
  String get news2 => 'समाचार:';

  @override
  String get joke => 'चुटकुला:';

  @override
  String get jokes => 'चुटकुले:';

  @override
  String get academicScience => 'अकादमिक / विज्ञान';

  @override
  String get politicsCommunism => 'राजनीति और साम्यवाद';

  @override
  String get foodDining => 'खान-पान और भोजन';

  @override
  String get sciFi => 'विज्ञान कथा';

  @override
  String get scienceFictionTech => 'विज्ञान कथा और तकनीक';

  @override
  String get travelPlaces => 'यात्रा और स्थान';

  @override
  String get mythologyFantasy => 'पौराणिक कथाएं और फैंटेसी';

  @override
  String get cultureTraditions => 'संस्कृति और परंपराएं';

  @override
  String get businessEconomy => 'व्यापार और अर्थव्यवस्था';

  @override
  String get natureAnimals => 'प्रकृति और जानवर';

  @override
  String get articleImg => 'लेख img';

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
  String get xiXiPicturesOfficialChannel => 'XiXi पिक्चर्स ऑफिशियल चैनल';

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
  String get getTheWeTVAPP => '腾讯视频 - WeTV ऐप प्राप्त करें';

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
  String get learnMandarinWithTaiwanPlus => 'TaiwanPlus के साथ मंदारिन सीखें';

  @override
  String get everydayChinese => 'रोज़मर्रा की चीनी';

  @override
  String get uCCFdR7zZ5SUXuOrEdKw => 'UCC_fdR7zZ_5SU--xuOrEdKw';

  @override
  String get tingDailyLifeInChina => 'टिंग - चीन में दैनिक जीवन';

  @override
  String get tFTFOODTRAVEL => 'TFT - भोजन और यात्रा';

  @override
  String get uCsHMiBJ9r87fRH7VAWZw => 'UCs_h_miBJ9r8-7fRH7VAWZw';

  @override
  String get liziqi3 => '李子柒 Liziqi: लहसुन का जीवन';

  @override
  String get label2MINCULTURALCONTEXT => '2 मिनट का सांस्कृतिक संदर्भ';

  @override
  String get liziqi4 => '李子柒 Liziqi: बांस का फर्नीचर';

  @override
  String get peppaPigChinese2 => 'Peppa Pig चीनी: 泥坑';

  @override
  String get noBBCLeadArticleIs =>
      'वर्तमान में कोई बीबीसी मुख्य लेख उपलब्ध नहीं है।';

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
  String get thoseDays => 'चार खुशियाँ - वे दिन';

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
  String get noFunnyNoMoney => 'हँसी नहीं तो सड़कों पर सोना - नो फनी नो मनी';

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
  String get getTheWeTVAPP2 => 'टैनसेंट वीडियो - एनीमे - WeTV ऐप प्राप्त करें';

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
      '\"लॉर्ड ऑफ मिस्ट्रीज\" कटलफिश डबिंग व्लॉग अंतिम संस्करण टेनसेंट वीडियो - एनिमे';

  @override
  String get lordOfMysteries =>
      '\"लॉर्ड ऑफ मिस्ट्रीज\" गूढ़विद्या कक्षा एपिसोड 8 टेनसेंट वीडियो - एनिमे';

  @override
  String get lordOfMysteries2 =>
      '\"लॉर्ड ऑफ मिस्ट्रीज\" गूढ़विद्या कक्षा एपिसोड 7 टेनसेंट वीडियो - एनिमे';

  @override
  String get lordOfMysteries3 =>
      '\"लॉर्ड ऑफ मिस्ट्रीज\" गूढ़विद्या कक्षा एपिसोड 6 टेनसेंट वीडियो - एनिमे';

  @override
  String get lordOfMysteries4 =>
      '\"लॉर्ड ऑफ मिस्ट्रीज\" गूढ़विद्या कक्षा एपिसोड 5 टेनसेंट वीडियो - एनिमे';

  @override
  String get lordOfMysteries5 =>
      '\"लॉर्ड ऑफ मिस्ट्रीज\" गूढ़विद्या कक्षा एपिसोड 4 टेनसेंट वीडियो - एनिमे';

  @override
  String get lordOfMysteries6 =>
      '\"लॉर्ड ऑफ मिस्ट्रीज\" गूढ़विद्या कक्षा एपिसोड 3 टेनसेंट वीडियो - एनिमे';

  @override
  String get pakhctn6g6A => 'Pakhctn6g6A';

  @override
  String get lordOfMysteries7 =>
      '\"लॉर्ड ऑफ मिस्ट्रीज\" गूढ़विद्या कक्षा एपिसोड 2 टेनसेंट वीडियो - एनिमे';

  @override
  String get lordOfMysteries8 =>
      '\"लॉर्ड ऑफ मिस्ट्रीज\" गूढ़विद्या कक्षा एपिसोड 1 टेनसेंट वीडियो - एनिमे';

  @override
  String get g5fLWO98axs => 'G5fLWO98axs';

  @override
  String get gK0eOTF2s4c => 'GK0eOTF2s4c';

  @override
  String get oSTLordOfMysteries =>
      '【OST】\"लॉर्ड ऑफ मिस्ट्रीज\" समापन गीत \"फॉरगेट-मी-नॉट\" टेनसेंट वीडियो - एनिमे';

  @override
  String get membersPremiere2 => 'सदस्य प्रीमियर';

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
  String get eightHundred => '方圆八百米 आठ सौ';

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
  String get loveBeyondTheGrave => 'लव बियॉन्ड द ग्रेव (Love Beyond the Grave)';

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
      'सेट ईस्टर एग: हे सिमु और दुआन शू के असली नाम मिलना मुश्किल 【लव बियॉन्ड द ग्रेव】';

  @override
  String get label5MVET41ATY => '5MVET41A-tY';

  @override
  String get bTSLoveBeyondTheGrave =>
      'BTS｜【गूज़ ड्रामा पार्टी】दिलीराबा और चेन फेईयु ने स्टार कास्ट के साथ किए 5-सेंस पोज़! 【लव बियॉन्ड द ग्रेव】';

  @override
  String get bTSLoveBeyondTheGrave2 =>
      'BTS｜【गूज़ ड्रामा पार्टी】दिलीराबा और चेन फेईयु की शानदार एंट्री, कातिलाना लुक! 【लव बियॉन्ड द ग्रेव】';

  @override
  String get herBlaze => 'हर ब्लेज़ (Her Blaze)';

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
  String get aboutLove => 'प्यार के बारे में (About Love)';

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
      '《अबाउट लव》 में सभी प्यार की उलझन में फंसे हैं, वे इस स्थिति से कैसे निकलेंगे? | मुख्य कलाकार: वांग ज़ीवेन, लियू युनिंग';

  @override
  String get pLMX26aiIvX5rSLe74r7sARps4oOqaBWD =>
      'PLMX26aiIvX5rSLe74r7sA-Rps4oOqaBWD';

  @override
  String get generationToGeneration2 =>
      'पीढ़ी दर पीढ़ी (Generation to Generation)';

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
  String get loveStoryInThe1970s => '纯真年代的爱情 1970 के दशक की प्रेम कहानी';

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
  String get whyIsHeStillSingle => '他为什么依然单身 वह अब भी सिंगल क्यों है';

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
  String get theGlamorousNight => '夜色正浓 द ग्लैमरस नाइट';

  @override
  String get theGlamorousNightE03 =>
      '【夜色正浓 द ग्लैमरस नाइट】E03 दमदार चाल! झाओ मेई का ज़बरदस्त पलटवार (जियांग शुयिंग, टोंग दावेई)';

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
  String get myPageInThe90s => 'माय पेज इन द 90s (突然的喜欢)';

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
      'खास पल 04: अजीब सिस्टम ने ड्रामा बढ़ाया! टिश्यू बन गया सेनेटरी पैड? अब तो बेहद शर्मिंदगी हुई! [माय पेज इन द 90s]';

  @override
  String get label03MyPageInThe =>
      'खास पल 03: सहेली की जगह ब्लाइंड डेट पर गई, और खुद मेल लीड से मुलाकात हो गई? [माय पेज इन द 90s]';

  @override
  String get bTSXXMyPage =>
      'बिहाइंड द सीन्स | \'बीटीएस X चेन शिंगशू X वांग युवेन\' मिस्टर गाओ और हुआन-एर में से कौन ज़्यादा अनोखा है? [माय पेज इन द 90s]';

  @override
  String get label02MyPageInThe =>
      'खास पल 02: मेल लीड को इम्प्रेस करना चाहती थी, लेकिन गलत इंसान को पहचान बैठी? [माय पेज इन द 90s]';

  @override
  String get label01MyPageInThe =>
      'खास पल 01: हास्यास्पद! अचानक किताब की दुनिया में पहुंच गई? अब इस कहानी में कैसे एक्टिंग करूं? [माय पेज इन द 90s]';

  @override
  String get bTSMyPageInThe =>
      'बिहाइंड द सीन्स | आइस स्केटिंग के दौरान टकराए चेन शिंगशू और वांग युवेन [माय पेज इन द 90s]';

  @override
  String get bTSMyPageInThe2 =>
      'बिहाइंड द सीन्स | चेन शिंगशू और वांग युवेन का मीठा न्यू ईयर सेलिब्रेशन [माय पेज इन द 90s]';

  @override
  String get bTSMyPageInThe3 =>
      'बिहाइंड द सीन्स | चीशी त्यौहार पर चेन शिंगशू और वांग युवेन का रोमांटिक पल [माय पेज इन द 90s]';

  @override
  String get bTSMyPageInThe4 =>
      'बिहाइंड द सीन्स | एम्यूजमेंट पार्क में चेन शिंगशू और वांग युवेन की मस्ती [माय पेज इन द 90s]';

  @override
  String get myPageInThe90s2 =>
      '\'माय पेज इन द 90s\' आज से शुरू, चेन शिंगशू और वांग युवेन का सिस्टम के साथ मीठा रोमांस';

  @override
  String get myPageInThe90s3 =>
      '\'माय पेज इन द 90s\' 22 जनवरी से शुरू, चेन शिंगशू और वांग युवेन का अनूठा प्यार';

  @override
  String get myPageInThe90s4 =>
      '\'माय पेज इन द 90s\' 22 जनवरी को रिलीज़! चेन शिंगशू और वांग युवेन का समय पार प्यार';

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
  String get label2TheImperialCoronerS2 =>
      'द इम्पीरियल कोरोनर सीज़न 2 (御赐小仵作2)';

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
  String get theDreamMaker => 'द ड्रीम मेकर The Dream Maker';

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
      '【轻年 Forever Young】E23 मार्टिन हुटोंग लौटा और भाइयों द्वारा नियंत्रित किया गया (वॉल्स हू, तian यू, झांग श्युयिंग, किआओ झेन्यू)';

  @override
  String get foreverYoungE25 =>
      '【轻年 Forever Young】E25 सटीक, स्थिर और क्रूर! मार्टिन ने भाभी को सिखाया पति को कैसे काबू करें (वॉल्स हू, तian यू, झांग श्युयिंग, किआओ झेन्यू)';

  @override
  String get foreverYoungE24 =>
      '【轻年 Forever Young】E24 प्यार में प्रतिद्वंद्वी? मार्टिन को एक छोटे लड़के ने अंकल कहा (वॉल्स हू, तian यू, झांग श्युयिंग, किआओ झेन्यू)';

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
  String get hOMELANDGUARDIAN => '守诚者|होमलैंड गार्जियन🚔';

  @override
  String get iQIYIGetTheIQIYIAPP => 'iQIYI सस्पेंस क्लब - iQIYI ऐप पाएं';

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
  String get loveHasFireworks => 'लव हैज़ फ़ायरवर्क्स';

  @override
  String get getTheWeTVAPP3 => 'टेंसेंट वीडियो - यूथ थिएटर - WeTV ऐप पाएं';

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
  String get theHiddenHeirYeChen2 => 'छिपे हुए वारिस ये चेन 2';

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
      '《纯真年代的爱情 Love Story in the 1970s》 दोहरी समयरेखा वाली लघु फ़िल्म रिलीज़ हो चुकी है~';

  @override
  String get loveStoryInThe1970s3 =>
      '《纯真年代的爱情 Love Story in the 1970s》 युगल लघु फ़िल्म आधिकारिक तौर पर जारी~ आइए अपनी भावनाओं से एक प्रेम पत्र लिखें';

  @override
  String get bTSLoveStoryInThe =>
      'BTS｜शूटिंग पूरी हुई, अगली मुलाकात का इंतज़ार 【1970 के दशक की प्रेम कहानी Love Story in the 1970s】';

  @override
  String get loveStoryInThe1970s4 =>
      '《1970 के दशक की प्रेम कहानी Love Story in the 1970s》 प्यार सादगी भरे जीवन में छिपी एक कविता है～';

  @override
  String get sGX3zNIuzM => 'SGX-3zNIuzM';

  @override
  String get loveStoryInThe1970s5 =>
      '《1970 के दशक की प्रेम कहानी Love Story in the 1970s》 21 फ़रवरी को प्रसारित होने के लिए तैयार~';

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
  String get theTruth => 'हवा छोड़ जाए निशान The Truth';

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
      'BTS | \'आउट ऑफ कैरेक्टर\' इंटरव्यू - मिस्टर गाओ या हुआन\'एर, कौन ज्यादा अनोखा है? 《अचानक पसंद आना My Page in the 90s》 टेनसेंट वीडियो';

  @override
  String get rEk9xALNODE => 'REk9xALNODE';

  @override
  String get label04MyPageInThe2 =>
      'खास पल 04: अजीब सिस्टम का नया ड्रामा! टिश्यू बन गया सेनेटरी पैड? बेहद शर्मिंदगी! 《अचानक पसंद आना My Page in the 90s》 टेनसेंट वीडियो';

  @override
  String get label03MyPageInThe2 =>
      'खास पल 03: बेस्ट फ्रेंड के बदले ब्लाइंड डेट पर गई, और खुद हीरो से ही मिल बैठी? 《अचानक पसंद आना My Page in the 90s》 टेनसेंट वीडियो';

  @override
  String get xsb7BJppy0 => 'Xsb7B-Jppy0';

  @override
  String get label02MyPageInThe2 =>
      'खास पल 02: हीरो को इंप्रेस करना चाहती थी, लेकिन गलत इंसान को समझ बैठी? 《अचानक पसंद आना My Page in the 90s》 टेनसेंट वीडियो';

  @override
  String get label01MyPageInThe2 =>
      'खास पल 01: गजब! अचानक किताब के अंदर पहुंच गई? अब इस कहानी में कैसे एक्टिंग करूं? 《अचानक पसंद आना My Page in the 90s》 टेनसेंट वीडियो';

  @override
  String get zSpXoH9ok => 'Z_SpXo-H9ok';

  @override
  String get myPageInThe90s5 =>
      '《अचानक पसंद आना My Page in the 90s》BTS | चेन शिंगशू और वांग युवेन स्केटिंग करते हुए आपस में टकरा गए';

  @override
  String get myPageInThe90s6 =>
      '《अचानक पसंद आना My Page in the 90s》आज से शुरू! चेन शिंगशू और वांग युवेन की सिस्टम के साथ मीठी प्रेम कहानी';

  @override
  String get bTSMyPageInThe5 =>
      'BTS | चेन शिंगशू और वांग युवेन की मस्तीभरी और रोमांटिक केमिस्ट्री 【अचानक पसंद आना My Page in the 90s】';

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
  String get dearSecretary => 'मेरी प्यारी सेक्रेटरी (Dear Secretary)';

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
  String get foreverYoung2 => '轻年 सदा युवा';

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
  String get lightOfDawn => '人之初 भोर की रोशनी';

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
  String get sniperButterfly => '狙击蝴蝶 स्नाइपर बटरफ्लाई';

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
      '《狙击蝴蝶 Sniper Butterfly》1204 के लिए तय! प्यार के लिए सीमाएं लांघी';

  @override
  String get sniperButterflyFullVersion1 =>
      '《狙击蝴蝶 Sniper Butterfly》पूरा एपिसोड 1-15｜मुख्य कलाकार: चेन यानक्सी, झोउ केयू टेनसेंट वीडियो-यूथ थिएटर';

  @override
  String get sniperButterflyFullVersion16 =>
      '《狙击蝴蝶 Sniper Butterfly》पूरा एपिसोड 16-30｜मुख्य कलाकार: चेन यानक्सी, झोउ केयू टेनसेंट वीडियो-यूथ थिएटर';

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
  String get allRise => 'तुरंत मैदान में All Rise';

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
  String get loveIsAlwaysOnline2 => 'सही समय, सही इंसान Love is Always Online';

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
  String get loveOnTheTurquoiseLand => '枭起青壤 फ़िरोज़ी भूमि पर प्रेम';

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
      '《वह अभी भी सिंगल क्यों है Why Is He Still Single》 11/16 को रिलीज़! वॉलेस हुओ और झू झू के परिपक्व प्रेम की कहानी!';

  @override
  String get whyIsHeStillSingle3 =>
      '《वह अभी भी सिंगल क्यों है Why Is He Still Single》पूरा एपिसोड｜मुख्य कलाकार: वॉलेस हुओ, झू झू - टेनसेंट वीडियो-यूथ थिएटर';

  @override
  String get ijgFlHRPHw => 'Ijg-FlHRPHw';

  @override
  String get whyIsHeStillSingle4 =>
      '《वह अभी भी सिंगल क्यों है Why Is He Still Single》पूरा एपिसोड 1｜मुख्य कलाकार: वॉलेस हुओ, झू झू - टेनसेंट वीडियो-यूथ थिएटर';

  @override
  String get whyIsHeStillSingle5 =>
      '《वह अभी भी सिंगल क्यों है Why Is He Still Single》पूरा एपिसोड 2｜मुख्य कलाकार: वॉलेस हुओ, झू झू - टेनसेंट वीडियो-यूथ थिएटर';

  @override
  String get yVGKe9xonY => 'YV-GKe9xonY';

  @override
  String get qKftsk37mXo => 'QKftsk37mXo';

  @override
  String get ccxy931pac => 'ccxy9-31pac';

  @override
  String get uc5hawjBFU => 'Uc5hawj_bFU';

  @override
  String get fightForLove => '山河枕 - फ़ाइट फॉर लव';

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
  String get iMNobody => '我本无名 - I\'m Nobody';

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
  String get thePrisonerOfBeauty =>
      'The Prisoner of Beauty (संक्षिप्त संस्करण)';

  @override
  String get wsGeYBRO => 'wsGeYB_-r_o';

  @override
  String get thePrisonerOfBeauty2 =>
      '«The Prisoner of Beauty»: शियाओ किआओ अपनी बहन के बदले अपने कट्टर दुश्मन से शादी करती है, और शादी के पहले ही दिन पति से भिड़ जाती है | मुख्य कलाकार: सॉन्ग ज़ूएर, लियू युनिंग';

  @override
  String get thePrisonerOfBeauty3 =>
      '《The Prisoner of Beauty (संक्षिप्त संस्करण)》: शियाओ किआओ ने लيو यान की साजिश को नाकाम किया, वेई शाओ के साथ उनकी दुश्मनी आपसी सुरक्षा में बदली | मुख्य कलाकार: सॉन्ग ज़ूएर, लियू युनिंग - Tencent Video';

  @override
  String get thePrisonerOfBeauty4 =>
      '《The Prisoner of Beauty (संक्षिप्त संस्करण)》: शियाओ किआओ बीमारी का नाटक करती है, वेई शाओ सार्वजनिक रूप से अपनी पत्नी की रक्षा करते हैं और रखेलों को ठुकराते हैं | मुख्य कलाकार: सॉन्ग ज़ूएर, लियू युनिंग - Tencent Video';

  @override
  String get thePrisonerOfBeauty5 =>
      '《The Prisoner of Beauty (संक्षिप्त संस्करण)》: शियाओ किआओ लकड़ी के बक्से की साजिश को तोड़ती है, वेई शाओ उसे अपनी मालकिन स्वीकार करता है | मुख्य कलाकार: सॉन्ग ज़ूएर, लियू युनिंग - Tencent Video';

  @override
  String get thePrisonerOfBeauty6 =>
      '《The Prisoner of Beauty (संक्षिप्त संस्करण)》: शियाओ किआओ चालाकी से साजिश को मात देती है, वेई शाओ पत्नी को पहचानकर रक्षा करता है | मुख्य कलाकार: सॉन्ग ज़ूएर, लियू युनिंग - Tencent Video';

  @override
  String get thePrisonerOfBeauty7 =>
      '《The Prisoner of Beauty (संक्षिप्त संस्करण)》: वेई यान झूठा पत्र भेजकर मुसीबत खड़ी करता है, जेड पेंडेंट के कारण शियाओ किआओ और वेई शाओ के बीच विश्वास का संकट पैदा होता है | मुख्य कलाकार: सॉन्ग ज़ूएर, लियू युनिंग - Tencent Video';

  @override
  String get thePrisonerOfBeauty8 =>
      '《The Prisoner of Beauty (संक्षिप्त संस्करण)》: सु एहुआंग पके गेहूं का उपयोग करके शियाओ किआओ को फंसाती है, वेई शाओ पत्नी की रक्षा कर मामला सुलझाता है और दोनों करीब आते हैं | मुख्य कलाकार: सॉन्ग ज़ूएर, लियू युनिंग - Tencent Video';

  @override
  String get thePrisonerOfBeauty9 =>
      '《The Prisoner of Beauty (संक्षिप्त संस्करण)》: शियाओ किआओ और वेई शाओ पर जानलेवा हमला होता है और जहर दिया जाता है, शियाओ किआओ साजिश को मात देकर पति की जान बचाती है और उनके रिश्ते गहरे होते हैं | मुख्य कलाकार: सॉन्ग ज़ूएर, लियू युनिंग - Tencent Video';

  @override
  String get rNYFWNcb8o => 'RNYFW-Ncb8o';

  @override
  String get thePrisonerOfBeauty10 =>
      '«The Prisoner of Beauty»: वेई शाओ युद्ध के घोड़े देने के बाद हेयरبिन भेजता है, पत्नी की रक्षा में बेचैन | मुख्य कलाकार: सॉन्ग ज़ूएर, लियू युनिंग';

  @override
  String get thePrisonerOfBeauty11 =>
      '«The Prisoner of Beauty»: वेई शाओ को डर है कि शियाओ किआओ भाग जाएगी, ईर्ष्या करता है और याद करता है | मुख्य कलाकार: सॉन्ग ज़ूएर, लियू युनिंग';

  @override
  String get thePrisonerOfBeauty12 =>
      '«The Prisoner of Beauty»: ईर्ष्या के कारण वेई शाओ शियाओ किआओ को अपनी पीठ पर उठाता है, लकड़ी के बक्से का रहस्य सुलझता है और वे करीब आते हैं | मुख्य कलाकार: सॉन्ग ज़ूएर, लियू युनिंग';

  @override
  String get thePrisonerOfBeauty13 =>
      '«The Prisoner of Beauty»: कियाओ ची अपनी बहन से मिलने आता है जिससे वेई शाओ को ईर्ष्या होती है, दोनों अपने दिल की बात कहते हैं | मुख्य कलाकार: सॉन्ग ज़ूएर, लियू युनिंग';

  @override
  String get thePrisonerOfBeauty14 =>
      '《द प्रिज़नर ऑफ़ ब्यूटी (मिनी)》वेई यान ने शियाओ क़ियाओ के लिए घर छोड़ा, शाओ-क़ियाओ के झगड़े के बाद सुलह हुई | कलाकार: सोंग ज़ुएर, लियू युनिंग - टेंसेंट वीडियो यूथ थिएटर';

  @override
  String get ry1BWClaV0 => 'ry1BWCla-V0';

  @override
  String get thePrisonerOfBeauty15 =>
      '《द प्रिज़नर ऑफ़ ब्यूटी (मिनी)》शादी की रात सैन्य विद्रोह, शियाओ क़ियाओ ने दुश्मन को भगाया | कलाकार: सोंग ज़ुएर, लियू युनिंग - टेंसेंट वीडियो यूथ थिएटर';

  @override
  String get o8nFcvzyvM => 'O8n-FcvzyvM';

  @override
  String get thePrisonerOfBeauty16 =>
      '《द प्रिज़नर ऑफ़ ब्यूटी (मिनी)》वेई शाओ शियाओ क़ियाओ के साथ कांग काउंटी गया, दूरियाँ हुईं कम | कलाकार: सोंग ज़ुएर, लियू युनिंग - टेंसेंट वीडियो यूथ थिएटर';

  @override
  String get krsrk6wSAy8 => 'Krsrk6wSAy8';

  @override
  String get thePrisonerOfBeauty17 =>
      '《द प्रिज़नर ऑफ़ ब्यूटी (मिनी)》क़ियाओ युए का विश्वासघात, वेई लियांग की मौत, दा क़ियाओ का अपहरण | कलाकार: सोंग ज़ुएर, लियू युनिंग - टेंसेंट वीडियो यूथ थिएटर';

  @override
  String get v26fn6w270 => 'V-26fn6w270';

  @override
  String get thePrisonerOfBeauty18 =>
      '《द प्रिज़नर ऑफ़ ब्यूटी (मिनी)》युद्ध में वेई लियांग की मौत, दा क़ियाओ गिरी, लियू यान का पतन | कलाकार: सोंग ज़ुएर, लियू युनिंग - टेंसेंट वीडियो यूथ थिएटर';

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
      'ग्रुप प्रोजेक्ट में मेरी गति धीमी? बॉस रात में खिड़की से PPT देने आया, गार्ड्स पीछे भागे | टेंसेंट वीडियो - यूथ थिएटर';

  @override
  String get zPBZ1KRQ3hY => 'ZPBZ1KRQ3hY';

  @override
  String get aThousandMilesToYour =>
      'हजारों शहर पार कर तुमसे मिला A Thousand Miles to Your Heart';

  @override
  String get getTheWeTVAPP4 =>
      'टेंसेंट वीडियो - कॉस्ट्यूम ड्रामा थिएटर - WeTV ऐप प्राप्त करें';

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
  String get theInescapable => 'द इनएस्केपेबल The Inescapable';

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
      '《江湖夜雨十年灯 Generation to Generation》22 फ़रवरी को आ रहा है! देखिए जिआंगहू की सबसे मज़बूत नई पीढ़ी मुमु और झाओझाओ को एक साथ इस दुनिया में उतरते हुए।';

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
  String get the300LoyalGhosts2 => 'द 300 लॉयल घोस्ट्स';

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
  String get danceOfThePhoenix => 'डांस ऑफ द फीनिक्स';

  @override
  String get f0uIRYSOwo => 'F0uIRY_SOwo';

  @override
  String get extraordinary2 => 'असाधारण';

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
      '《द इम्पीरियल कोरोनर S2》 15 जनवरी को आ रहा है, चू-यू जोड़ी की दिल छू लेने वाली वापसी!';

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
  String get rebirthForYou => '嘉南传 - आपके लिए पुनर्जन्म';

  @override
  String get f9eLAZQDUds => 'F9eLAZQDUds';

  @override
  String get aVowInTheDark2 => '恋恋风陵渡 - अंधेरे में एक मन्नत';

  @override
  String get theUltimateVowUnknownTo => '君不知 - परम प्रतिज्ञा, आपसे अनजान';

  @override
  String get duMRGzTeKs => 'DuM-rGzTeKs';

  @override
  String get pLs3DOuT3JlGTynSBKz3Z5DcDzwwmqSOf =>
      'PLs3DOuT3JlGTynSBKz3-z5DcDzwwmqSOf';

  @override
  String get theChangAnYouth => '长安少年行 - चांगआन के युवा';

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
  String get thePrincessDecree2 => '平凝有令 - राजकुमारी का आदेश';

  @override
  String get ppiNYsUwOA => 'PpiNYs-uwOA';

  @override
  String get label83tIjIiqM => '-_83tIjIiqM';

  @override
  String get p4cKjzSHFw => 'P4cKjz-sHFw';

  @override
  String get babysitter => '我在冷宫做月嫂 - बेबीसिटर';

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
  String get aGirlLikeMe2 => '我就是这般女子 (A Girl Like Me)';

  @override
  String get p4YsJ5WtBw => 'p4YsJ5Wt-bw';

  @override
  String get pIg2oXFWS8 => 'pIg2oXFWS-8';

  @override
  String get hrJz2C0Fxs => 'hrJz-2C0Fxs';

  @override
  String get mL0phSCWJY => 'mL0phSC-wJY';

  @override
  String get sideStoryOfFoxVolant2 => '飞狐外传 (Side Story of Fox Volant)';

  @override
  String get pLs3DOuT3JlGQCkd77fhalA8WxMD3OT4Q =>
      'PLs3DOuT3JlGQCkd77fhalA8Wx-mD3OT4Q';

  @override
  String get aFlowerOnTheContinent2 => '有花在洲 (A Flower On The Continent)';

  @override
  String get aFlowerOnTheContinent3 =>
      '【有花在洲 A Flower On The Continent】 युवा राजकुमार को बंधक बनाकर राजकुमारी की तरह रहने पर मजबूर किया गया और दोनों को साथ रहना पड़ा';

  @override
  String get aFlowerOnTheContinent4 =>
      '【有花在洲 A Flower On The Continent】 लड़की का भेद खुला, राजकुमार ने जान पर खेलकर उसे बचाया पर खुद ही झूठा आरोपी बन गया';

  @override
  String get aFlowerOnTheContinent5 =>
      '【ए फ्लावर ऑन द कॉन्टिनेंट】 हुआ शियू को पता चलता है कि उसके पिता का हत्यारा निंग शुआनझोउ का पिता है और वह तुरंत भड़क जाती है';

  @override
  String get aFlowerOnTheContinent6 =>
      '【ए फ्लावर ऑन द कॉन्टिनेंट】 हुआ शियू दुल्हन के कपड़ों में दुश्मन के शिविर में घुसती है और निंग शुआनझोउ को बचाने में लगभग अपनी जान गंवा देती है';

  @override
  String get aFlowerOnTheContinent7 =>
      '【ए फ्लावर ऑन द कॉन्टिनेंट】 दोनों देशों के बीच संधि होती है, निंग शुआनझोउ शाही फरमान फाड़कर हुआ शियू से शादी करने पर अड़ जाता है';

  @override
  String get aFlowerOnTheContinent8 =>
      '【ए फ्लावर ऑन द कॉन्टिनेंट】 दवा बनाने के लिए हुआ शियू अपनी कलाई काटती है, निंग शुआनझोउ अपने पिता का पर्दाफाश करता है कि उसने उसके पिता को मारा';

  @override
  String get aFlowerOnTheContinent9 =>
      '【ए फ्लावर ऑन द कॉन्टिनेंट】 हुआ शियू को पता चलता है कि उसके पिता की हत्या निंग शुआनझोउ के पिता ने की थी, वह फूलों के बीच अपनी सगाई का प्रतीक टहनी काट देती है';

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
  String get hilariousFamily22 => 'हिलैरियस फैमिली 2';

  @override
  String get sliceOfLife => 'जीवन की झलक';

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
  String get legendOfTheFemaleGeneral => 'लीजेंड ऑफ द फीमेल जनरल';

  @override
  String get highlightLegendOfTheFemale =>
      'हाईलाइट संग्रह 【Legend of The Female General】';

  @override
  String get a40F2TEZrms => 'A40F2TEZrms';

  @override
  String get lYQ5iND4 => 'lYQ5iN-d-_4';

  @override
  String get bTSLegendOfTheFemale =>
      'बिहाइंड द सीन्स: झोउ ये का जन्मदिन स्पेशल 🎂! 【Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale2 =>
      'बिहाइंड द सीन्स: चेंग लेई का जन्मदिन स्पेशल 🎂! 【Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale3 =>
      'बिहाइंड द सीन्स: युद्ध के मैदान में शानदार लड़ाई 【Legend of The Female General】';

  @override
  String get bTS520LegendOfThe =>
      'बिहाइंड द सीन्स: 520 डेट प्लान 【Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale4 =>
      'बिहाइंड द सीन्स: झोउ ये का क्यूट स्वॉर्ड डांस 【Legend of The Female General】';

  @override
  String get pLs3DOuT3JlGRucYIZLqmT7FO5IWDWrP =>
      'PLs3DOuT3JlGRuc_yIZLqmT7FO5IWD-WrP';

  @override
  String get thePrincessSGambit => 'The Princess\'s Gambit';

  @override
  String get highlightThePrincessSGambit =>
      'हाईलाइट संग्रह 【The Princess\'s Gambit】';

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
      'क्लिप: सफेद बर्फ में लाल पोशाक! छोटे भाई की रक्षा के लिए विदाई 【The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit2 =>
      'क्लिप: शादी के दिन नया हंगामा? ताओहुआ ने शांति से संभाला 【The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit3 =>
      'क्लिप: ताओहुआ की फर्जी बेहोशी का खुलासा 【The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit4 =>
      'क्लिप: प्रधानमंत्री शेन की सख्त कार्रवाई, भ्रष्ट अधिकारी डरे 【The Princess\'s Gambit】';

  @override
  String get eDrJjtCRF0 => 'eDr-jjtCRF0';

  @override
  String get clipThePrincessSGambit5 =>
      'क्लिप: नकाबपोश हत्यारा पकड़ा गया: तुम्हारे पैरों ने राज खोल दिया! 【The Princess\'s Gambit】';

  @override
  String get clipPlayThePrincessS =>
      'क्लिप: हेयरपिन से पूछताछ! शेन जईये ने ताओहुआ से सवाल किए 【The Princess\'s Gambit】';

  @override
  String get label58K8GxhXlQ => '58K8-gxhXlQ';

  @override
  String get clipThePrincessSGambit6 =>
      'क्लिप: पहली ही मुलाकात में इतना बड़ा खेल! शेन ज़ैये और ताओहुआ की नज़रें मिलीं 【द प्रिंसेस गैंबिट】';

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
      '【सीमित पूर्ण】云襄传 | द इनजीनियस वन | iQIYI 👑अभी सदस्यता लें और पूरे एपिसोड देखें!';

  @override
  String get iQIYIGetTheIQIYIAPP2 => 'iQIYI 爱奇艺 - iQIYI ऐप प्राप्त करें';

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
      '【पूरा】👮रोड होम💕 | बोरान जिंग, सेवेन टैन | iQIYI फ़िलीपींस';

  @override
  String get iQIYIPhilippinesGetTheIQIYI =>
      'iQIYI फ़िलीपींस - iQIYI ऐप डाउनलोड करें';

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
      '【AI अंग्रेज़ी डब】मिस्टर बैड | चेन झेयुआन, शेन युए | iQIYI फ़िलीपींस';

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
      '🌸【奇幻仙侠】🎋Love of the Divine Tree 仙台有树 | Deng Wei × Xiang Hanzhi | पूरा एपिसोड | iQIYI 👑सदस्यता लें और अभी पूरे एपिसोड का आनंद लें!';

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
      '【पूरा】🕊️माय डियर गार्जियन | जॉनी हुआंग, ली क़िन | iQIYI फ़िलीपींस';

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
      '🌸【सुखद प्रेम】🎋द बेस्ट थिंग 爱你 | झांग लिंगहे × शू रुओहान | पूरा एपिसोड | iQIYI 👑सदस्यता लें और अब पूरे एपिसोड देखें!';

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
      '📽️【EP01 2026】रीबर्थ चाइनीज ड्रामा ENGSUB | ली युनरूई / हुआंगयांग तियानतियान / झांग कांगले ⛵😍 ऐतिहासिक ड्रामा 2026 #冰湖重生';

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
      '【पूरा】🏹फेटेड हार्ट्स | ली चिन, चेन झेयुआन | iQIYI फ़िलीपींस';

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
      '【पूरा】 ब्राइट आइज़ इन द डार्क | जॉनी हुआंग, झांग जिंग यी | iQIYI फ़िलीपींस';

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
      '🎥✨【अंग्रेज़ी उपशीर्षक】चीनी फैंटेसी फ़िल्म | फैंटेसी, एडवेंचर【 iQIYI मूवी थिएटर-सब्सक्राइब करने के लिए स्वागत है】';

  @override
  String get iQIYIMOVIETHEATERGetThe =>
      '爱奇艺大电影 iQIYI मूवी थिएटर - iQIYI ऐप डाउनलोड करें';

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
      '🎀【मिनी ड्रामा】अंग्रेज़ी सबटाइटल्स | पूर्ण संग्रह | अधिक देखने के लिए WeTV / Tencent Video ऐप डाउनलोड करें';

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
      '【पूरा】ब्यूटी ऑफ़ रेजिलियंस | जू जिंगई, फ़िक्शन | iQIYI फिलीपींस';

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
      '🔥हॉट ट्रेंडिंग【子夜归 Moonlit Reunion】पूरे एपिसोड | रहस्य सुलझाते हुए इंसान और दानव में प्यार | शू काई, त्यान शीवेई | अंग्रेजी सबटाइटल्स';

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
  String get fallInLove => 'प्यार में पड़ना';

  @override
  String get myGirl => 'माई गर्ल';

  @override
  String get firstRomance2 => 'पहला रोमांस';

  @override
  String get fallFor => 'आकर्षित होना';

  @override
  String get uCD83JhUFQXRDwC6S8caCQ => 'UCD_83Jh-UFQXRDwC6S8caCQ';

  @override
  String get uCFh5x5AZHQQ6FaGKnGQXDA => 'UCFh5x5AZHQQ6FaGKnG-QXDA';

  @override
  String get uCRABdhiBHX4BieJfPCd2pg => 'UCRABdhiBHX4Bie-jfPCd2pg';

  @override
  String get hiddenLove2 => 'हिडन लव';

  @override
  String get loveBetweenFairyAndDevil2 => 'लव बिटवीन फेयरी एंड डेविल';

  @override
  String get loveLikeTheGalaxy2 => 'लव लाइक द गैलेक्सी';

  @override
  String get myJourneyToYou2 => 'माई जर्नी टू यू';

  @override
  String get mysteriousLotusCasebook2 => 'मिस्टीरियस लोटस केसबुक';

  @override
  String get reset => 'रीसेट';

  @override
  String get theLongBallad2 => 'द लॉन्ग बैलाड';

  @override
  String get theUntamed2 => 'द अनटेम्ड';

  @override
  String get wordOfHonor2 => 'वर्ड ऑफ ऑनर';

  @override
  String get lightOfDawn2 => '人之初 भोर की किरण';

  @override
  String get hOMELANDGUARDIAN2 => '守诚者|मातृभूमि रक्षक';

  @override
  String get searching2 => 'खोज रहे हैं...';

  @override
  String get verse => 'छंद';

  @override
  String get allStories2 => 'सभी कहानियाँ';

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
  String get char2 => '+ वर्ण +';

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
      'लेख, .लेख, .पोस्ट, .सामग्री, मुख्य';

  @override
  String get ttsActiveWord => '.tts-active-word';

  @override
  String get ttsActiveWord2 => 'tts-active-word';

  @override
  String get upperIntermediate2 => 'उच्च-मध्यम';

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
  String get processing => 'प्रक्रिया जारी है…';

  @override
  String get keepItUp => '好！ऐसे ही जारी रखें';

  @override
  String get minutesDay => 'मिनट / दिन';

  @override
  String get consistencyIsTheInkThat =>
      '\"निरंतरता ही वह स्याही है जो अक्षर गढ़ती है।\"';

  @override
  String get businessCareer => 'व्यापार और करियर';

  @override
  String get travelSurvival => 'यात्रा और सर्वाइवल';

  @override
  String get label05MinDay => '05 मिनट / दिन';

  @override
  String get label10MinDay => '10 मिनट / दिन';

  @override
  String get label20MinDay => '20 मिनट / दिन';

  @override
  String get label30MinDay => '30 मिनट / दिन';

  @override
  String get dynamicDecksStrokeAnalysis => 'डायनामिक डेक और स्ट्रोक विश्लेषण';

  @override
  String get subscriptionsAreTemporarilyUnavailablePl =>
      'सदस्यताएँ अस्थायी रूप से उपलब्ध नहीं हैं। कृपया पुनः प्रयास करें।';

  @override
  String get trialReminder => 'ट्रायल रिमाइंडर';

  @override
  String get turnOnNotificationsIfYou =>
      'यदि आप अपने पात्र ट्रायल के समाप्त होने से पहले रिमाइंडर पाना चाहते हैं तो नोटिफिकेशन चालू करें। आपकी App Store सदस्यता सेटिंग्स ही मुख्य स्रोत रहेंगी।';

  @override
  String get label2Months => '2 महीने';

  @override
  String get label3Months => '3 महीने';

  @override
  String get label6Months => '6 महीने';

  @override
  String get billingPeriod => 'बिलिंग अवधि';

  @override
  String get chooseASubscription => 'एक सदस्यता चुनें';

  @override
  String get startFreeTrial => 'मुफ़्त ट्रायल शुरू करें';

  @override
  String get smartNewsDict => 'स्मार्ट समाचार और शब्दकोश';

  @override
  String get hSK16AIDecks => 'HSK 1-6 और AI डेक';

  @override
  String get continueWithTemporaryPremium =>
      'अस्थायी प्रीमियम के साथ जारी रखें';

  @override
  String get testProductUnavailable => 'परीक्षण उत्पाद उपलब्ध नहीं है';

  @override
  String get paymentIsChargedToYour =>
      'भुगतान आपके ऐप स्टोर खाते से लिया जाता है।';

  @override
  String get subscriptionsRenewAutomaticallyUnlessCan =>
      'सदस्यता स्वचालित रूप से नवीनीकृत होती है, जब तक रद्द न की जाए';

  @override
  String get atLeast24HoursBefore =>
      'वर्तमान अवधि समाप्त होने से कम से कम 24 घंटे पहले।';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

  @override
  String get closePurchaseOffer => 'खरीद ऑफ़र बंद करें';

  @override
  String get loading => 'लोड हो रहा है...';

  @override
  String get analyzingImage2 => 'छवि का विश्लेषण किया जा रहा है…';

  @override
  String get extractingChineseText2 => 'चीनी पाठ निकाला जा रहा है…';

  @override
  String get lookingUpVocabulary2 => 'शब्दावली खोजी जा रही है…';

  @override
  String get deselectAll => 'सभी का चयन रद्द करें';

  @override
  String get selectAll => 'सभी को चुनें';

  @override
  String get worldChineseLiteraryMasterpiece =>
      'विश्व और चीनी साहित्यिक उत्कृष्ट कृति।';

  @override
  String get classic => 'शास्त्रीय';

  @override
  String get literature => 'साहित्य';

  @override
  String get theOriginAwakening => 'उत्पत्ति और जागरण';

  @override
  String get turbulentHorizonsTheJourney => 'अशांत क्षितिज और यात्रा';

  @override
  String get trialsTribulationsDevotion => 'कठिनाइयां, संकट और भक्ति';

  @override
  String get theClashOfWitsBravery => 'बुद्धिमत्ता और वीरता का टकराव';

  @override
  String get theGrandClimaxResolution => 'महा-चरमोत्कर्ष और समाधान';

  @override
  String get everlastingLegacyEpilogue => 'शाश्वत विरासत और उपसंहार';

  @override
  String get acrossTheVastExpanseOf =>
      'आकाश और पृथ्वी के विशाल विस्तार में, पात्र कठिन परीक्षाओं के माध्यम से अपने भाग्य और विश्वास की खोज करते हैं।';

  @override
  String get everyDialogueAndEncounterWithin =>
      'इस कहानी का प्रत्येक संवाद और मुलाकात मानवीय भावना की चमक और अपने युग की छाप समेटे हुए है।';

  @override
  String get followingTheFlowOfProse =>
      'गद्य के प्रवाह का अनुसरण करते हुए, पाठक महान हस्तियों के सुख और दुख में शामिल होने के लिए सदियों की यात्रा करते हैं।';

  @override
  String get preQin => 'पूर्व-किन';

  @override
  String get theGoddessNWaRepairing => 'देवी नुआ द्वारा आकाश की मरम्मत';

  @override
  String get artsTraditions => 'कला और परंपराएँ';

  @override
  String get femaleWarm => 'महिला, मधुर';

  @override
  String get femaleCheerful => 'महिला, हंसमुख';

  @override
  String get maleUpbeat => 'पुरुष, उत्साहित';

  @override
  String get maleNewsStyle => 'पुरुष, समाचार शैली';

  @override
  String get maleSporty => 'पुरुष, जोशीला';

  @override
  String get onDevice => 'डिवाइस पर';

  @override
  String get label15Minutes => '15 मिनट';

  @override
  String get label30Minutes => '30 मिनट';

  @override
  String get label45Minutes => '45 मिनट';

  @override
  String get selectChapter => 'अध्याय चुनें';

  @override
  String get andContinuesToBeStudied =>
      'और पीढ़ियों से पाठकों द्वारा पढ़ा व सराहा जा रहा है।';

  @override
  String get label1Poem => '1 कविता';

  @override
  String get label1Chapter => '1 अध्याय';

  @override
  String get localDeviceVoice2 => 'लोकल डिवाइस वॉयस';

  @override
  String get weeklyAzureQuotaReachedSwitching =>
      'साप्ताहिक Azure कोटा समाप्त — लोकल वॉयस पर स्विच किया जा रहा है';

  @override
  String get sleepTimer2 => 'स्लीप टाइमर';

  @override
  String get tableOfContents2 => 'विषय-सूची';

  @override
  String get hanziMaster10 => 'HanziMaster/1.0';

  @override
  String get spanishItalianRussianClassics =>
      'स्पैनिश, इतालवी और रूसी क्लासिक्स';

  @override
  String get englishAmericanGlobalClassics =>
      'अंग्रेज़ी, अमेरिकी और वैश्विक क्लासिक्स';

  @override
  String get whileStrategicallyEmbeddingWordsYou =>
      'और उन कठिन शब्दों को रणनीतिक रूप से शामिल करता है, ताकि आप उन्हें संदर्भ में सीख सकें।';

  @override
  String get poetryPainting => 'कविता-चित्रकला';

  @override
  String get contactSinosparkCom => 'contact@sinospark.com';

  @override
  String get shadowingStudioIsADedicated =>
      'शैडोइंग स्टूडियो मूल भाषियों का अनुकरण करने का एक विशेष स्थान है। आप एक वाक्यांश सुनते हैं, उसे दोहराते हुए खुद को रिकॉर्ड करते हैं, और अपने उच्चारण को सुधारने के लिए वेवफॉर्म और उच्चारण स्कोर की तुलना करते हैं।';

  @override
  String get theVoicesInAIStories =>
      'AI कहानियाँ और रोलप्ले उन्नत टेक्स्ट-टू-स्पीच मॉडल से बनी कृत्रिम आवाज़ों का उपयोग करते हैं, जिन्हें स्पष्ट और स्वाभाविक चीनी उच्चारण के लिए तैयार किया गया है। कुछ सुविधाओं में डिवाइस की स्थानीय आवाज़ भी उपलब्ध हो सकती है।';

  @override
  String get theWebExplorerAllowsYou =>
      'वेब एक्सप्लोरर आपको किसी भी चीनी वेबसाइट को ब्राउज़ करने की सुविधा देता है। जब आपको कोई कठिन शब्द मिले, तो त्वरित झलक कार्ड खोलने के लिए बस उस पर टैप करें, जो तुरंत पिनयिन, अनुवाद और HSK स्तर प्रदान करता है।';

  @override
  String get zenModeStripsAwayDistracting =>
      'ज़ेन मोड लेखों से ध्यान भटकाने वाले तत्वों, विज्ञापनों और जटिल लेआउट को हटा देता है, जिससे आपको केवल पाठ पर केंद्रित एक साफ़, सुलेखन पठन वातावरण मिलता है।';

  @override
  String get weUseAnIntelligentAlgorithm =>
      'हम एक बुद्धिमान एल्गोरिदम का उपयोग करते हैं जो अनुमान लगाता है कि आप कब कोई शब्द भूलने वाले हैं। जिन शब्दों में आपको कठिनाई होती है वे अधिक बार दिखाई देंगे, जबकि जिन्हें आप अच्छी तरह जानते हैं उन्हें भविष्य में बाद के लिए निर्धारित किया जाएगा।';

  @override
  String get usage3 => 'उपयोग:';

  @override
  String get tutorialOneExplanation =>
      'यह \'एक\' (Yī) है। इसे हमेशा बाएं से दाएं खींचें।';

  @override
  String get tutorialWaterExplanation =>
      'यह पूर्ण अक्षर \'जल\' (Shuǐ) है। जब इसे बाएं-तरफ के घटक के रूप में उपयोग किया जाता है, तो यह \'氵\' (तीन बूंदें) में बदल जाता है!';

  @override
  String get tutorialRadicalsExplanation =>
      'हांज़ी मूल घटकों से बने होते हैं जिन्हें रेडिकल्स कहा जाता है। वे अक्षर को उसका मुख्य अर्थ या विषय प्रदान करते हैं।';

  @override
  String get tutorialLettersExplanation =>
      'हांज़ी केवल अक्षर नहीं हैं। वे समय में जमी हुई तस्वीरें हैं। उन पर महारत हासिल करने के लिए, आपको उनके प्रवाह को सीखना होगा।';

  @override
  String get tutorialGalaxyExplanation =>
      'गैलेक्सी मैप आपका इंतज़ार कर रहा है। ग्रहों (अक्षरों) को अनलॉक करने के लिए सूर्य (रेडिकल्स) पर महारत हासिल करें।';

  @override
  String get onboardingDailyLifeTravel => 'दैनिक जीवन और यात्रा';

  @override
  String get onboardingPhilosophyIdioms => 'दर्शन और मुहावरे';

  @override
  String get onboardingBusinessCareerMulti => 'व्यापार और\nकरियर';

  @override
  String get onboardingTravelSurvivalMulti => 'यात्रा और\nउत्तरजीविता';

  @override
  String get onboardingHskCertificationMulti => 'HSK\nप्रमाणन';

  @override
  String get onboardingCulturalAppreciationMulti => 'सांस्कृतिक\nसमझ';

  @override
  String get practiceReminders => 'अभ्यास रिमाइंडर';

  @override
  String get oneOptionalDailyReminderTo =>
      'चीनी भाषा का अभ्यास करने के लिए एक वैकल्पिक दैनिक रिमाइंडर';

  @override
  String get aFewMinutesOfChinese => 'चीनी भाषा के लिए कुछ मिनट? 🌱';

  @override
  String get keepYourProgressMovingWith =>
      'एक छोटे अभ्यास सत्र के साथ अपनी प्रगति जारी रखें।';

  @override
  String get xuX => 'xué xí';

  @override
  String get toStudyToLearn => 'अध्ययन करना · सीखना';

  @override
  String get pNgYou => 'péng you';

  @override
  String get fXiN => 'fā xiàn';

  @override
  String get toDiscover => 'खोजना';

  @override
  String get jiNCh => 'jiān chí';

  @override
  String get toPersist => 'दृढ़ रहना';

  @override
  String get yNgQ => 'yǒng qì';

  @override
  String get zhHu => 'zhì huì';

  @override
  String get chNgZhNg => 'chéng zhǎng';

  @override
  String get toGrow => 'बढ़ना';

  @override
  String get pNgJNg => 'píng jìng';

  @override
  String get calmPeaceful => 'शांत · शांतिपूर्ण';

  @override
  String get xWNg => 'xī wàng';

  @override
  String get lJi => 'lǐ jiě';

  @override
  String get toUnderstand => 'समझना';

  @override
  String get xGuN => 'xí guàn';

  @override
  String get wNNuN => 'wēn nuǎn';

  @override
  String get warmthWarm => 'गर्माहट · गर्म';

  @override
  String get zhuNZh => 'zhuān zhù';

  @override
  String get toFocus => 'ध्यान केंद्रित करना';

  @override
  String get definitionExpansionButton => 'परिभाषा विस्तार बटन';

  @override
  String get wenigerAnzeigen => 'कम दिखाएं';

  @override
  String get mostrarMenos => 'कम दिखाएं';

  @override
  String get afficherMoins => 'कम दिखाएं';

  @override
  String get mostraMeno => 'कम दिखाएं';

  @override
  String get showFewer => 'कम दिखाएं';

  @override
  String get masterLin => 'मास्टर लिन';

  @override
  String get xiaoMei => 'शाओ मेई';

  @override
  String get thePoet => 'कवि';

  @override
  String get aQiang => 'अ-च्यांग';

  @override
  String get vivian => 'विवियन';

  @override
  String get formalWise => 'औपचारिक और ज्ञानी';

  @override
  String get casualFriendly => 'अनौपचारिक और दोस्ताना';

  @override
  String get poeticAncient => 'काव्यात्मक और प्राचीन';

  @override
  String get slangInternet => 'स्लैंग और इंटरनेट';

  @override
  String get trendyModern => 'ट्रेंडी और आधुनिक';

  @override
  String get designYourOwn => 'अपना खुद का डिज़ाइन करें';

  @override
  String get theBambooSwaysAndThe =>
      'बांस झूम रहा है, और विद्वान सुबह की बारिश की तरह आपके शब्दों की प्रतीक्षा कर रहा है...';

  @override
  String get yourCustomPersonaIsActive =>
      'आपका कस्टम व्यक्तित्व सक्रिय है। बातचीत शुरू करने के लिए टाइप करें।';

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
  String get staleDictionaryExpansionResponse =>
      'पुरानी शब्दकोश विस्तार प्रतिक्रिया';

  @override
  String get dictionaryExpansionWasEmpty => 'शब्दकोश विस्तार खाली था';

  @override
  String get explicationDTaillEDisponible => 'विस्तृत व्याख्या उपलब्ध';

  @override
  String get ausfHrlicheErklRungVerf => 'विस्तृत व्याख्या उपलब्ध';

  @override
  String get explicaciNDetalladaDisponible => 'विस्तृत व्याख्या उपलब्ध';

  @override
  String get spiegazioneDettagliataDisponibile => 'विस्तृत व्याख्या उपलब्ध';

  @override
  String get explicaODetalhadaDisponVel => 'विस्तृत व्याख्या उपलब्ध';

  @override
  String get detailedExplanationAvailable => 'विस्तृत व्याख्या उपलब्ध';

  @override
  String get oneOptionalDailyPracticeReminder =>
      'एक वैकल्पिक दैनिक अभ्यास रिमाइंडर';

  @override
  String get chooseOneOptionalDailyPractice =>
      'एक वैकल्पिक दैनिक अभ्यास रिमाइंडर चुनें।';

  @override
  String get practiceReminder => 'अभ्यास रिमाइंडर';

  @override
  String get oneGentleReminderADay =>
      'दिन में एक सौम्य रिमाइंडर, केवल आवश्यकता होने पर';

  @override
  String get finishingPracticeSilencesTodayS =>
      'अभ्यास पूरा करने से आज का रिमाइंडर बंद हो जाता है। समीक्षा और';

  @override
  String get reEngagementAlertsAreCombined =>
      'पुनः जुड़ने वाले अलर्ट संयुक्त हैं ताकि वे इकट्ठा न हों।';

  @override
  String get processing2 => 'प्रक्रिया जारी है…';

  @override
  String get wDKIChu => 'wǒ dǎ kāi chuāng hu';

  @override
  String get listen => 'सुनें';

  @override
  String get notice => 'ध्यान दें';

  @override
  String get fourTones => 'चार टोन';

  @override
  String get write => 'लिखें';

  @override
  String get recap => 'पुनरावलोकन';

  @override
  String get playbackDidNotStart => 'प्लेबैक शुरू नहीं हुआ';

  @override
  String get audioIsUnavailableYouCan =>
      'ऑडियो उपलब्ध नहीं है। आप पढ़ना जारी रख सकते हैं।';

  @override
  String get microphoneAccessWasNotGranted =>
      'माइक्रोफ़ोन की अनुमति नहीं मिली। आप इसे सेटिंग्स में सक्षम कर सकते हैं।';

  @override
  String get recordingIsUnavailableRightNow => 'रिकॉर्डिंग अभी उपलब्ध नहीं है।';

  @override
  String get listeningToYourTones => 'आपके टोन सुने जा रहे हैं…';

  @override
  String get noRecording => 'कोई रिकॉर्डिंग नहीं';

  @override
  String get weCouldNotScoreThat =>
      'हम उस रिकॉर्डिंग का मूल्यांकन नहीं कर सके, इसलिए यहाँ टोन तुलना का एक उदाहरण है।';

  @override
  String get listenForTheLowDipping =>
      'निचली, झुकती हुई तीसरी टोन को ध्यान से सुनें।';

  @override
  String get firstHearATinyMoment =>
      'पहले, मंदारिन का एक छोटा सा अंश सुनें। अभी याद करने की ज़रूरत नहीं है।';

  @override
  String get loadingAudio => 'ऑडियो लोड हो रहा है…';

  @override
  String get listenToThePassage => 'गद्यांश सुनें';

  @override
  String get continueAction => 'जारी रखें';

  @override
  String get noticeHowMeaningSoundAnd =>
      'ध्यान दें कि अर्थ, ध्वनि और अक्षर कैसे एक साथ चलते हैं।';

  @override
  String get shadowOneSentence => 'एक वाक्य साथ में दोहराएं';

  @override
  String get listenOnceThenHoldThe =>
      'एक बार सुनें, फिर माइक दबाकर रखें और वाक्य बोलें।';

  @override
  String get hearItAgain => 'फिर से सुनें';

  @override
  String get stopAndCheckMyTones => 'रुकें और मेरी टोन जांचें';

  @override
  String get useMicrophone => 'माइक्रोफ़ोन का उपयोग करें';

  @override
  String get iCanTSpeakRight => 'मैं अभी बोल नहीं सकता';

  @override
  String get tapACharacterToCompare =>
      'अपनी बोली गई टोन की तुलना करने के लिए किसी अक्षर पर टैप करें, फिर टोन 1–4 सुनें।';

  @override
  String get tryHandwriting => 'हाथ से लिखना आज़माएं';

  @override
  String get seeWhatYouLearned => 'देखें आपने क्या सीखा';

  @override
  String get inAFewMinutesYou =>
      'कुछ ही मिनटों में, आपने उसी चक्र का उपयोग किया जो आपके पाठों को संचालित करता है।';

  @override
  String get listenedToChineseInContext => 'संदर्भ में चीनी भाषा सुनी';

  @override
  String get shadowedASentence => 'वाक्य को दोहराया';

  @override
  String get comparedMandarinTones => 'मंदारिन टोन की तुलना की';

  @override
  String get practicedARealCharacter => 'एक वास्तविक अक्षर का अभ्यास किया';

  @override
  String get qNgchNXiOy =>
      'Qīngchén, xiǎoyǔ tíng le. Wǒ dǎkāi chuānghu, tīngjiàn niǎor zài shù shàng chànggē. Xīn de yì tiān kāishǐ le.';

  @override
  String get atDawnTheLightRain =>
      'भोर में, हल्की बारिश रुक गई। मैंने खिड़की खोली और पेड़ों पर पक्षियों का गाना सुना। एक नया दिन शुरू हुआ।';

  @override
  String get learnThroughRealVideos => 'वास्तविक वीडियो के माध्यम से सीखें';

  @override
  String get followInteractiveSubtitlesLookUp =>
      'इंटरैक्टिव उपशीर्षक देखें, तुरंत शब्द खोजें, और हर वीडियो को एक पाठ में बदलें।';

  @override
  String get videoLearningScreenshot => 'वीडियो लर्निंग स्क्रीनशॉट';

  @override
  String get turnAnyBookIntoA => 'किसी भी किताब को पाठ और ऑडियोबुक में बदलें';

  @override
  String get readNaturallyWithPronunciationDefinition =>
      'आवश्यकता पड़ने पर उच्चारण, परिभाषाओं और अनुवाद के साथ स्वाभाविक रूप से पढ़ें।';

  @override
  String get bookReaderScreenshot => 'बुक रीडर स्क्रीनशॉट';

  @override
  String get speakWithTheRightRhythm => 'एआई और लाइव टोन के साथ खुलकर बोलें';

  @override
  String get shadowNativeAudioAndVisualize =>
      'मूल ऑडियो को दोहराएं और अपने उच्चारण में सुधार के साथ सभी चार टोन को विज़ुअलाइज़ करें।';

  @override
  String get shadowingAndTonesScreenshot => 'शैडोइंग और टोन स्क्रीनशॉट';

  @override
  String get understandEveryCharacter => 'हर अक्षर को समझें';

  @override
  String get exploreMeaningPronunciationComponentsStr =>
      'एक ही स्थान पर अर्थ, उच्चारण, घटक, स्ट्रोक क्रम और उपयोगी शब्दावली खोजें।';

  @override
  String get characterDictionaryScreenshot => 'अक्षर शब्दकोश का स्क्रीनशॉट';

  @override
  String get learnChineseWithoutLimits => 'बिना किसी सीमा के चीनी सीखें';

  @override
  String get watchReadSpeakAndUnderstand =>
      'एक संपूर्ण शिक्षण साथी के साथ चीनी देखें, पढ़ें, बोलें और समझें।';

  @override
  String get seeWhatPremiumUnlocks => 'देखें कि प्रीमियम क्या अनलॉक करता है';

  @override
  String get scrollToExploreTheComplete =>
      'पूरा सीखने का अनुभव देखने के लिए स्क्रॉल करें';

  @override
  String get cOMINGSOON => 'जल्द आ रहा है';

  @override
  String get guidedHandwritingPractice => 'निर्देशित हस्तलेखन अभ्यास';

  @override
  String get scannerAndLiveTranslation => 'स्कैनर और लाइव अनुवाद';

  @override
  String get hSK16AndAI => 'HSK 1–6 और AI डेक';

  @override
  String get smartSpacedRepetition2 => 'स्मार्ट स्पेस्ड रिपीटीशन';

  @override
  String get progressAndStreakTracking => 'प्रगति और स्ट्रिक ट्रैकिंग';

  @override
  String get learningToolsInOnePlace => 'सीखने के उपकरण एक ही स्थान पर';

  @override
  String get everythingIncluded => 'सब कुछ शामिल है';

  @override
  String get paymentIsChargedToYour2 =>
      'भुगतान आपके App Store खाते से लिया जाता है। सदस्यता स्वचालित रूप से नवीनीकृत हो जाती है जब तक कि वर्तमान अवधि समाप्त होने से कम से कम 24 घंटे पहले रद्द न की जाए।';

  @override
  String get yourFirstWeekOfTracked =>
      'ट्रैक किए गए अभ्यास का आपका पहला सप्ताह';

  @override
  String get sameNumberOfCardsAs => 'पिछले सप्ताह जितने ही कार्ड';

  @override
  String cardsComparedWithLastWeek(String change) {
    return 'पिछले सप्ताह की तुलना में $change कार्ड';
  }

  @override
  String get todaySPractice => 'आज का अभ्यास';

  @override
  String get goalCompleteAnythingMoreIs =>
      'लक्ष्य पूरा हुआ — इसके अलावा सब कुछ एक बोनस है।';

  @override
  String get aSmallAchievableTargetNo =>
      'एक छोटा, प्राप्त करने योग्य लक्ष्य। आराम के दिन के लिए कोई पेनल्टी नहीं।';

  @override
  String get thisWeek => 'इस सप्ताह';

  @override
  String get minutes => 'मिनट';

  @override
  String get activeDays => 'सक्रिय दिन';

  @override
  String dayStreakCount(int count) {
    return '$count दिन की स्ट्रीक';
  }

  @override
  String get masterChineseOneStrokeAt =>
      'एक बार में एक स्ट्रोक के साथ चीनी भाषा में महारत हासिल करें';

  @override
  String get dictionaryExpansionButton => 'शब्दकोश विस्तार बटन';

  @override
  String get kIErweiterterWRterbucheintrag => 'AI-विस्तृत शब्दकोश प्रविष्टि';

  @override
  String get detalleAmpliadoPorIA => 'AI द्वारा विस्तृत विवरण';

  @override
  String get dTailEnrichiParL => 'AI द्वारा संवर्धित विवरण';

  @override
  String get aI => 'AI द्वारा विस्तृत शब्दकोश विवरण';

  @override
  String get detailKamusYangDiperluasAI => 'AI द्वारा विस्तृत शब्दकोश विवरण';

  @override
  String get dettaglioDelDizionarioAmpliatoDall =>
      'AI द्वारा विस्तृत शब्दकोश विवरण';

  @override
  String get aI2 => 'AI द्वारा शब्दकोश पूरक';

  @override
  String get aI3 => 'AI द्वारा विस्तृत शब्दकोश व्याख्या';

  @override
  String get detalheDeDicionRioExpandido => 'AI द्वारा विस्तृत शब्दकोश विवरण';

  @override
  String get aI4 => 'AI द्वारा विस्तृत शब्दकोश विवरण';

  @override
  String get chiTiTTI => 'AI द्वारा विस्तृत शब्दकोश विवरण';

  @override
  String get aI5 => 'AI द्वारा विस्तृत शब्दकोश अर्थ';

  @override
  String get aIExpandedDictionaryDetail => 'AI द्वारा विस्तृत शब्दकोश विवरण';

  @override
  String get cetteEntrEEstBr =>
      'यह प्रविष्टि संक्षिप्त है। विस्तृत व्याख्या उपलब्ध है।';

  @override
  String get dieserEintragIstKurzEine =>
      'यह प्रविष्टि संक्षिप्त है। विस्तृत व्याख्या उपलब्ध है।';

  @override
  String get estaEntradaEsBreveHay =>
      'यह प्रविष्टि संक्षिप्त है। विस्तृत व्याख्या उपलब्ध है।';

  @override
  String get questaVoceBreveDisponibileUna =>
      'यह प्रविष्टि संक्षिप्त है। विस्तृत व्याख्या उपलब्ध है।';

  @override
  String get estaEntradaBreveEstDispon =>
      'यह प्रविष्टि संक्षिप्त है। विस्तृत व्याख्या उपलब्ध है।';

  @override
  String get thisDictionaryEntryIsBrief =>
      'यह शब्दकोश प्रविष्टि संक्षिप्त है। विस्तृत व्याख्या उपलब्ध है।';

  @override
  String get dVelopperEnFranAis => 'फ़्रेंच में विस्तार करें';

  @override
  String get aufDeutschErweitern => 'जर्मन में विस्तार करें';

  @override
  String get ampliarEnEspaOl => 'स्पैनिश में विस्तार करें';

  @override
  String get approfondisciInItaliano => 'इतालवी में विस्तार करें';

  @override
  String get expandirEmPortuguS => 'पुर्तगाली में विस्तार करें';

  @override
  String get expandDefinition => 'परिभाषा का विस्तार करें';

  @override
  String get impossibleDeChargerLExplication => 'व्याख्या लोड नहीं की जा सकी।';

  @override
  String get dieErklRungKonnteNicht => 'व्याख्या लोड नहीं की जा सकी।';

  @override
  String get noSePudoCargarLa => 'व्याख्या लोड नहीं की जा सकी।';

  @override
  String get impossibileCaricareLaSpiegazione => 'व्याख्या लोड नहीं की जा सकी।';

  @override
  String get nOFoiPossVel => 'व्याख्या लोड नहीं की जा सकी।';

  @override
  String get unableToLoadTheExplanation => 'व्याख्या लोड नहीं की जा सकी।';

  @override
  String get failedToGenerateStoryN => 'कहानी जनरेट करने में विफल:\\n\$e';

  @override
  String get thematic => 'विषयगत';

  @override
  String get deckFlashcards => 'डेक (फ्लैशकार्ड)';

  @override
  String get searchLibraryOrTypeCustom => 'लाइब्रेरी खोजें या कस्टम टाइप करें';

  @override
  String get hSKLevel => 'HSK \$level';

  @override
  String get analysisFailedE => 'विश्लेषण विफल: \$e';

  @override
  String get extractionFailedE => 'निष्कर्षण विफल: \$e';

  @override
  String get simplifyFailedE => 'सरलीकरण विफल: \$e';

  @override
  String get translationFailedE => 'अनुवाद विफल: \$e';

  @override
  String get failedToSaveExtractedWords2 =>
      'निकाल गए शब्दों को सहेजने में विफल: \$error';

  @override
  String youActualTargetExpected(String actual, String expected) {
    return 'आप: $actual  ·  लक्ष्य: $expected';
  }

  @override
  String get improveTheLocalVoice => 'स्थानीय आवाज़ में सुधार करें';

  @override
  String get higherQualityOfflineMandarin =>
      'उच्च गुणवत्ता वाली ऑफ़लाइन मंदारिन';

  @override
  String get removeDownload => 'डाउनलोड हटाएं?';

  @override
  String get removeDownload2 => 'डाउनलोड हटाएं';

  @override
  String get tag => '#\$tag';

  @override
  String get voiceFemaleWarm => 'महिला, गर्म';

  @override
  String get voiceFemaleCheerful => 'महिला, हंसमुख';

  @override
  String get voiceMaleUpbeat => 'पुरुष, उत्साही';

  @override
  String get voiceMaleNewsStyle => 'पुरुष, समाचार-शैली';

  @override
  String get voiceMaleSporty => 'पुरुष, स्पोर्टी';

  @override
  String get voiceOnDeviceTts => 'डिवाइस पर टीटीएस';

  @override
  String get voiceSystemVoice => 'सिस्टम आवाज';

  @override
  String get applySessionGradesToSpacedRepetition =>
      'सत्र के अंकों को अंतराल पुनरावृत्ति (बोलने का मोड) पर लागू करें';

  @override
  String get unableToLoadThisSectionPleaseTryAgain =>
      'इस अनुभाग को लोड करने में असमर्थ। कृपया पुनः प्रयास करें।';

  @override
  String get removeDownloadQuestion => 'डाउनलोड हटाएं?';

  @override
  String get removeDownloadContent => 'Remove downloaded content?';

  @override
  String get removeDownloadAction => 'डाउनलोड हटाएं';

  @override
  String get removeDownloadButton => 'डाउनलोड हटाएं';

  @override
  String cardsCount(num count) {
    return '$count Cards';
  }

  @override
  String get aiSummary => 'AI सारांश';

  @override
  String get readability => 'पठनीयता';

  @override
  String get translateAction => 'अनुवाद करें';

  @override
  String get checkingDownload => '??????? ????? ?? ??? ??';

  @override
  String downloadingBook(int percent) {
    return '??????? ?? ??? ??: $percent%';
  }

  @override
  String get retryDownload => '??????? ??? ?? ????';

  @override
  String get downloadBook => '?????? ??????? ????';

  @override
  String continueChapter(int chapter) {
    return '?????? $chapter ?? ???? ????';
  }

  @override
  String get downloadBookError =>
      '?? ?????? ??????? ???? ?? ???? ???? ??????? ?????? ?? ??? ????? ?????';

  @override
  String downloadBookOffline(int count) {
    return '???? $count ?????? ??????? ????? ?? ??? ?????? ??????? ?????';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ???????',
      one: '1 ?????',
    );
    return '$_temp0';
  }

  @override
  String get americanLiterature => '??????? ???????';

  @override
  String get ancientChina => '??????? ???';

  @override
  String get britishLiterature => '??????? ???????';

  @override
  String get frenchLiterature => '?????????? ???????';

  @override
  String get germanLiterature => '????? ???????';

  @override
  String get italianLiterature => '?????? ???????';

  @override
  String get jinDynasty => '??? ??????';

  @override
  String get preQinEra => '???-????? ???';

  @override
  String get qingDynasty => '???? ??????';

  @override
  String get republicOfChinaEra => '??? ???????';

  @override
  String get russianLiterature => '???? ???????';

  @override
  String get spanishLiterature => '?????? ???????';

  @override
  String get springAndAutumn => '???? ?? ??? ???';

  @override
  String get westernHan => '??????? ???';

  @override
  String get roleplayCreatorContextPlaceholder =>
      'उदा., शंघाई में जश्न मनाता एक जीवंत भोज...';

  @override
  String get roleplayCreatorPersonaPlaceholder =>
      'उदा., आपके करियर के बारे में पूछता एक जिज्ञासु चचेरा भाई...';

  @override
  String get beginFirstLesson => 'पहला पाठ आरंभ करें';

  @override
  String get exploreLibraryDirectly => 'सीधे लाइब्रेरी देखें';

  @override
  String onboardingLessonProgress(Object current, Object total) {
    return 'आपका पहला पाठ  •  $total में से $current';
  }

  @override
  String get onboardingListenInstruction =>
      'सबसे पहले, चीनी साहित्य की प्रसिद्ध पंक्तियों में से एक सुनें। अभी याद करने की आवश्यकता नहीं है।';

  @override
  String get onboardingFromGrandLibrary => 'महान पुस्तकालय से';

  @override
  String get onboardingArtOfWarTitleAuthor => 'युद्ध कला · सन त्ज़ू';

  @override
  String get onboardingArtOfWarChapter => '谋攻篇 · अध्याय 3';

  @override
  String get onboardingClassicLineLabel => 'एक कालजयी पंक्ति';

  @override
  String get onboardingArtOfWarTranslation =>
      '“शत्रु को जानें और स्वयं को जानें, तो आपको सौ युद्धों के परिणाम का भय नहीं होगा।”';

  @override
  String get onboardingNoticeMeaning => 'शत्रु को जानें और स्वयं को जानें,';

  @override
  String get onboardingShadowMeaning =>
      'आप सौ युद्धों में भी कभी संकट में नहीं पड़ेंगे।';

  @override
  String get onboardingPracticeThisLabel => 'आप इसका अभ्यास करेंगे';

  @override
  String get onboardingFromArtOfWarLabel => '‘युद्ध कला’ से';

  @override
  String get onboardingYourPronunciationLabel => 'आपका उच्चारण';

  @override
  String get onboardingTapACharacter => 'किसी अक्षर पर टैप करें';

  @override
  String onboardingWordAndPinyin(String word, String pinyin) {
    return '$word · $pinyin';
  }

  @override
  String get onboardingToneMatched => 'मिलान हुआ';

  @override
  String get onboardingCompareTones => 'स्वरों की तुलना करें';

  @override
  String get onboardingToneOneHigh => 'स्वर 1 · उच्च';

  @override
  String get onboardingToneTwoRising => 'स्वर 2 · आरोही';

  @override
  String get onboardingToneThreeDipping => 'स्वर 3 · उतरता-चढ़ता';

  @override
  String get onboardingToneFourFalling => 'स्वर 4 · अवरोही';

  @override
  String get onboardingToneNotDetected => 'पहचाना नहीं गया';

  @override
  String get onboardingFeedbackGreatThirdTone =>
      'तीसरा उतरता-चढ़ता स्वर उत्कृष्ट है।';

  @override
  String get onboardingFeedbackFourthToneFall =>
      'चौथे स्वर को दृढ़ता और शीघ्रता से नीचे जाने दें।';

  @override
  String get onboardingFeedbackClearFourthTone => 'स्पष्ट अवरोही चौथा स्वर।';

  @override
  String get onboardingFeedbackStrongFourthTone => 'सशक्त अवरोही चौथा स्वर।';

  @override
  String onboardingTraceInstruction(
      String character, String pinyin, String meaning) {
    return '$character ($pinyin, “$meaning”) का आलेखन करें। धुंधले रेखा-मार्गदर्शक का अनुसरण करें।';
  }

  @override
  String billingDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count दिन',
      one: '1 दिन',
    );
    return '$_temp0';
  }

  @override
  String billingWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count सप्ताह',
      one: '1 सप्ताह',
    );
    return '$_temp0';
  }

  @override
  String billingMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count महीने',
      one: '1 महीना',
    );
    return '$_temp0';
  }

  @override
  String billingYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count वर्ष',
      one: '1 वर्ष',
    );
    return '$_temp0';
  }

  @override
  String startPeriodFreeTrial(String period) {
    return '$period का नि:शुल्क परीक्षण शुरू करें';
  }

  @override
  String subscribeForPricePeriod(String price, String period) {
    return '$price / $period में सदस्यता लें';
  }

  @override
  String eligibleTrialRenewalNotice(String price, String period) {
    return 'आपके चुने गए स्टोरकिट उत्पाद में एक योग्य नि:शुल्क परीक्षण शामिल है। परीक्षण के बाद, जब तक रद्द न किया जाए, यह $price प्रति $period की दर से नवीनीकृत हो जाता है।';
  }

  @override
  String pricePerPeriod(String price, String period) {
    return '$price / $period';
  }

  @override
  String get learn => 'सीखें';

  @override
  String get booksAndStudioQualityAudiobooks =>
      '86 क्लासिक किताबें और स्टूडियो-गुणवत्ता वाली ऑडियोबुक्स';

  @override
  String get aiConversationsAndLiveToneFeedback =>
      'एआई बातचीत और लाइव टोन फ़ीडबैक';

  @override
  String get interactiveVideoAndWebImmersion =>
      'इंटरएक्टिव वीडियो और वेब इमर्शन';

  @override
  String get characterInsightsAndHandwritingPractice =>
      'अक्षर अंतर्दृष्टि और हस्तलेखन अभ्यास';

  @override
  String get hskDecksAndSmartSpacedRepetition =>
      'HSK डेक और स्मार्ट स्पेस्ड रिपीटीशन';

  @override
  String get termsOfUseEula => 'उपयोग की शर्तें (EULA)';

  @override
  String get masterEveryStroke => 'हर स्ट्रोक में महारत हासिल करें';

  @override
  String get exploreTheChineseWeb => 'चीनी वेब का अन्वेषण करें';

  @override
  String get tone1Description =>
      'अपनी पिच को ऊँचा और स्थिर रखें जैसे कोई धुन गाते समय।';

  @override
  String get tone2Description =>
      'बीच से शुरू करें और अपनी पिच को ऊपर की ओर खिसकाएँ जैसे \'क्या?\' पूछते समय।';

  @override
  String get tone3Description =>
      'अपनी आवाज़ को नीचे ले जाएँ, फिर धीरे से वापस ऊपर उठाएँ।';

  @override
  String get tone4Description =>
      'अपनी पिच को तेज़ी से और निर्णायक रूप से गिराएँ जैसे एक दृढ़ \'नहीं!\'।';

  @override
  String get toneNeutralDescription =>
      'धीरे, संक्षेप में और बिना ज़ोर दिए उच्चारण करें।';

  @override
  String get toneDiagMatch1 => 'बिल्कुल सही! पिच ऊंची, सपाट और स्थिर थी।';

  @override
  String get toneDiagMatch2 => 'बिल्कुल सही! ऊपर की ओर पिच का उठना स्पष्ट था।';

  @override
  String get toneDiagMatch3 => 'बिल्कुल सही! निचला झुकाव वाला वक्र सटीक था।';

  @override
  String get toneDiagMatch4 => 'बिल्कुल सही! तेज गिरावट निर्णायक थी।';

  @override
  String get toneDiagMatchDefault => 'बिल्कुल सही! टोन का उच्चारण सटीक था।';

  @override
  String get toneDiag1vs2 =>
      'आपने अपनी पिच बढ़ाई (दूसरा टोन /)। अपनी आवाज को पूरे शब्दांश में सपाट और ऊंचा रखें (पहला टोन ˉ)।';

  @override
  String get toneDiag1vs3 =>
      'आपने अपनी आवाज नीचे की (तीसरा टोन ˇ)। अपनी पिच को बिना नीचे किए स्थिर और ऊंचा रखें (पहला टोन ˉ)।';

  @override
  String get toneDiag1vs4 =>
      'आपने अपनी पिच गिराई (चौथा टोन \\)। एक नोट गाने की तरह एक उच्च, समतल पिच बनाए रखें (पहला टोन ˉ)।';

  @override
  String get toneDiag2vs1 =>
      'आप सपाट रहे (पहला टोन ˉ)। अपनी पिच को ऊपर की ओर खिसकाएं जैसे \'क्या?\' पूछ रहे हों (दूसरा टोन /)।';

  @override
  String get toneDiag2vs3 =>
      'आप बहुत गहरे नीचे गए (तीसरा टोन ˇ)। मध्य-स्तर से शुरू करें और बिना नीचे तक जाए सुचारू रूप से ऊपर उठें (दूसरा टोन /)।';

  @override
  String get toneDiag2vs4 =>
      'आपने अपनी पिच गिराई (चौथा टोन \\)। एक प्रश्न पूछने की तरह ऊपर की ओर उठें (दूसरा टोन /)।';

  @override
  String get toneDiag3vs1 =>
      'आप ऊंचे और सपाट रहे (पहला टोन ˉ)। ऊपर उठने से पहले अपनी पिच को अपनी छाती के रजिस्टर में नीचे गिरने दें (तीसरा टोन ˇ)।';

  @override
  String get toneDiag3vs2 =>
      'आप तुरंत ऊपर उठे (दूसरा टोन /)। ऊपर उठने से पहले पहले नीचे तक झुकना सुनिश्चित करें (तीसरा टोन ˇ)।';

  @override
  String get toneDiag3vs4 =>
      'आप बिना उठे तेजी से गिरे (चौथा टोन \\)। अंत में अपनी पिच को धीरे से ऊपर उछलने दें (तीसरा टोन ˇ)।';

  @override
  String get toneDiag4vs1 =>
      'आप सपाट रहे (पहला टोन ˉ)। अपनी पिच को तेजी से और निर्णायक रूप से गिराएं जैसे एक दृढ़ \'नहीं!\' (चौथा टोन \\)।';

  @override
  String get toneDiag4vs2 =>
      'आपने अपनी पिच बढ़ाई (दूसरा टोन /)। ऊंचा शुरू करें और तेजी से नीचे गिरें (चौथा टोन \\)।';

  @override
  String get toneDiag4vs3 =>
      'आप नीचे झुके और ऊपर उठे (तीसरा टोन ˇ)। बिना ऊपर उठे सीधे नीचे गिरें (चौथा टोन \\)।';

  @override
  String get toneDiagListenDiff => 'अंतर सुनने के लिए नीचे दिए गए 4 टोन सुनें।';

  @override
  String get liveCallSpeaking => 'बोल रहा है...';

  @override
  String get toneAccurate => 'सटीक टोन';

  @override
  String get toneNeedsWork => 'टोन पर अभ्यास चाहिए';

  @override
  String get liveCallSessionCompletedFallback =>
      'सत्र पूरा हुआ। अपने अगले अभ्यास में, विस्तृत उच्चारण और टोन विश्लेषण प्राप्त करने के लिए पूरे वाक्य बोलें।';

  @override
  String liveCallGoodStartPracticingWord(String word) {
    return '\'$word\' के साथ अभ्यास की अच्छी शुरुआत। अपने अगले सत्र में, टोन के बदलाव और स्वाभाविक प्रवाह का अभ्यास करने के लिए पूरे वाक्य बोलने का प्रयास करें।';
  }

  @override
  String get liveCallSolidEffortFallback =>
      'शानदार बातचीत का प्रयास। स्वाभाविक स्पष्टता बढ़ाने के लिए पहली टोन को ऊंचा और स्थिर (55) तथा चौथी टोन को तेज व निर्णायक (51) रखने पर ध्यान दें।';

  @override
  String get liveCallGoodPracticeFallback =>
      'अच्छा अभ्यास सत्र। टोन के स्पष्ट उतार-चढ़ाव और स्वाभाविक संवादात्मक गति पर ध्यान केंद्रित करना जारी रखें।';

  @override
  String sentenceNumber(Object number) {
    return 'वाक्य $number';
  }

  @override
  String endlessAiStreamSentence(Object count) {
    return 'अंतहीन एआई स्ट्रीम • वाक्य $count';
  }

  @override
  String get aiConsentTitle => 'एआई अभ्यास और गोपनीयता';

  @override
  String get aiConsentSubtitle =>
      'SinoSpark आवाज उच्चारण मूल्यांकन, संवाद रोलप्ले और अध्ययन उपकरणों के लिए सुरक्षित तृतीय-पक्ष एआई सेवाओं का उपयोग करता है।';

  @override
  String get aiConsentDataSentTitle => 'प्रेषित डेटा';

  @override
  String get aiConsentDataSentBody =>
      'वॉयस ऑडियो रिकॉर्डिंग, बोले गए भाषण के प्रतिलेख और अध्ययन संकेत।';

  @override
  String get aiConsentProvidersTitle => 'तृतीय-पक्ष एआई सेवाएं';

  @override
  String get aiConsentProvidersBody =>
      '• Microsoft Azure AI Speech (उच्चारण मूल्यांकन और आवाज संश्लेषण)\n• Google Gemini & DeepSeek (बातचीत संवाद और डेक निर्माण)';

  @override
  String get aiConsentGuaranteesTitle => 'गोपनीयता की गारंटी';

  @override
  String get aiConsentGuaranteesBody =>
      'आपका डेटा ट्रांसिट में एन्क्रिप्टेड है, अल्पकालिक रूप से संसाधित होता है, कभी बेचा नहीं जाता है, और कभी भी सार्वजनिक एआई मॉडल को प्रशिक्षित करने के लिए उपयोग नहीं किया जाता है।';

  @override
  String get aiConsentAgree => 'सहमत हों और AI का उपयोग करें';

  @override
  String get aiConsentLearnMore => 'और जानें';

  @override
  String get viewPlans => 'योजनाएं देखें';

  @override
  String get authInvalidCredentials =>
      'गलत ईमेल या पासवर्ड। यदि आपका कोई खाता नहीं है, तो कृपया साइन अप करें।';

  @override
  String get authInvalidEmail => 'कृपया एक मान्य ईमेल पता दर्ज करें।';

  @override
  String get authEmailAlreadyInUse =>
      'इस ईमेल पते से पहले से ही एक खाता मौजूद है।';

  @override
  String get authWeakPassword => 'पासवर्ड कम से कम 6 अक्षरों का होना चाहिए।';

  @override
  String get authTooManyRequests =>
      'बहुत अधिक विफल प्रयास। कृपया बाद में पुन: प्रयास करें।';

  @override
  String get authNetworkError => 'नेटवर्क त्रुटि। कृपया अपना कनेक्शन जांचें।';

  @override
  String get subscriptionRequired => 'सदस्यता आवश्यक है';

  @override
  String get subscriptionRequiredDesc =>
      'सभी पाठों, पुस्तकों और AI ध्वनि उपकरणों तक पहुंचने के लिए एक सक्रिय SinoSpark सदस्यता आवश्यक है।';

  @override
  String signedInAs(String email) {
    return '$email के रूप में साइन इन हैं';
  }

  @override
  String get battle => 'युद्ध';

  @override
  String addedWordsAndUpdatedWords(
      int addedCount, int updatedCount, String deckName) {
    return '$addedCount नए शब्द जोड़े गए, «$deckName» में $updatedCount मौजूदा शब्द अपडेट किए गए';
  }

  @override
  String addedWordsToDeck(int count, String deckName) {
    return '«$deckName» में $count शब्द जोड़े गए';
  }

  @override
  String updatedWordsInDeck(int count, String deckName) {
    return '«$deckName» में $count मौजूदा शब्द अपडेट किए गए';
  }

  @override
  String addedCardToDeck(String hanzi, String deckName) {
    return '$hanzi को $deckName में जोड़ा गया';
  }

  @override
  String get callCategory => 'लाइव कॉल';

  @override
  String get aiCallFluencyTitle => 'प्रवाह सुधारने के लिए एआई कॉल';

  @override
  String get aiCallFluencyDesc =>
      'एआई ट्यूटर के साथ वास्तविक आवाज में बातचीत करें, तुरंत टोन ग्रेडिंग प्राप्त करें और बोलने का प्रवाह बनाएं।';

  @override
  String get decksCategory => 'डेक';

  @override
  String get decksSpacedRepetitionTitle => 'स्पैस्ड रिपीटिशन वाले डेक';

  @override
  String get decksSpacedRepetitionDesc =>
      'वैज्ञानिक रूप से सिद्ध स्पैस्ड रिपीटिशन एल्गोरिदम के साथ HSK 1-6 और कस्टम डेक में महारत हासिल करें।';

  @override
  String get booksCategory => 'किताबें';

  @override
  String get classicalBooksPoemsTitle => '86 क्लासिक किताबें और 100 कविताएं';

  @override
  String get classicalBooksPoemsDesc =>
      'सिंक्रनाइज़ किए गए ऑडियो और द्विभाषी व्याख्याओं के साथ कालजयी साहित्य और कविता में खो जाएं।';

  @override
  String get scanCategory => 'स्कैनर';

  @override
  String get scannerScanCardsTitle =>
      'चित्र स्कैन करें और डेक में कार्ड जोड़ें';

  @override
  String get scannerScanCardsDesc =>
      'शब्दों को तुरंत निकालने और अपने डेक में सहेजने के लिए अपने कैमरे को किसी भी चीनी टेक्स्ट, मेनू या साइन पर ले जाएं।';

  @override
  String get smartDictionaryStrokeOrderTitle =>
      'स्ट्रोक ऑर्डर के साथ स्मार्ट डिक्शनरी';

  @override
  String get liveAiVoiceCallsAndToneGrading =>
      'लाइव एआई वॉयस कॉल और तुरंत टोन ग्रेडिंग';

  @override
  String get shadowingStudioAndToneAnalysis =>
      'शैडोइंग स्टूडियो और विज़ुअल टोन पिच विश्लेषण';

  @override
  String get startMy7DaysFreeTrial =>
      'मेरे 7 दिन का निःशुल्क परीक्षण शुरू करें';

  @override
  String trialSubtextUnderCta(String price, String period) {
    return 'फिर $price / $period। सेटिंग्स में कभी भी रद्द करें।';
  }

  @override
  String get deckLibraryTitle => 'डेक लाइब्रेरी';

  @override
  String get deckLibrarySubtitle => 'HSK, संस्कृति, खेल और अकादमिक संग्रह';

  @override
  String get downloadOfficialDecks =>
      'आधिकारिक HSK और थीम वाले डेक डाउनलोड करें';

  @override
  String wordsSelectedCount(int selected, int total) {
    return '$total में से $selected शब्द चुने गए';
  }

  @override
  String get comparisonLabel => 'तुलना';

  @override
  String get ambientSoundscape => 'शांत पृष्ठभूमि संगीत';

  @override
  String get ambientSoundscapeDesc => 'पढ़ने और सुनने के लिए सुखदायक माहौल';

  @override
  String get ambientSoundscapeOff => 'बंद (शांत)';

  @override
  String get soundscapeCourtyardRain => 'आंगन की बारिश';

  @override
  String get soundscapeGuqinWind => 'गुकिन और बांस की हवा';

  @override
  String get soundscapeMidnightZen => 'मध्यरात्रि ध्यान';

  @override
  String get ambientVolume => 'पृष्ठभूमि की आवाज़';

  @override
  String get rateSinoSpark => 'SinoSpark को रेट करें';

  @override
  String get rateSinoSparkDesc => 'ऐप स्टोर पर अपनी राय साझा करें';

  @override
  String get sendFeedback => 'प्रतिक्रिया भेजें';

  @override
  String get sendFeedbackDesc => 'सुधार में मदद करें या समस्या की रिपोर्ट करें';

  @override
  String get enjoyingAppTitle => 'क्या आपको SinoSpark पसंद आ रहा है?';

  @override
  String get enjoyingAppSubtitle =>
      'अब तक आपकी चीनी सीखने की यात्रा कैसी रही है?';

  @override
  String get ratingLovingIt => 'हाँ, बहुत पसंद आ रहा है!';

  @override
  String get ratingCouldBeBetter => 'और बेहतर हो सकता है';

  @override
  String get dictionarySearchFailed =>
      'शब्दकोश खोज विफल रही। कृपया पुनः प्रयास करें।';

  @override
  String get tapToHearVoiceSample => 'नमूना सुनने के लिए ▶ दबाएँ';

  @override
  String get soundEffects => 'ध्वनि प्रभाव';

  @override
  String get soundEffectsDesc =>
      'कोमल कागज़, लकड़ी की मुहर और सुलेख की ध्वनियाँ';

  @override
  String get generatingYourScenario => 'आपका परिदृश्य बनाया जा रहा है…';

  @override
  String get failedToGenerateScenario =>
      'यह परिदृश्य बनाना संभव नहीं हुआ। कृपया फिर कोशिश करें।';

  @override
  String get trickyCharacters => 'कठिन अक्षर';

  @override
  String get strongestCharacters => 'सबसे मज़बूत अक्षर';

  @override
  String get newThisWeek => 'पिछले 7 दिनों में नए';

  @override
  String get averageAttemptsPerWord => 'प्रति शब्द औसत प्रयास';

  @override
  String get noCardsYet => 'इस डेक में अभी कोई कार्ड नहीं है';

  @override
  String get libraryFilterOfficialHsk => 'आधिकारिक HSK';

  @override
  String get libraryFilterCulture => 'संस्कृति';

  @override
  String get libraryFilterSports => 'खेल';

  @override
  String get libraryFilterEducation => 'शिक्षा';

  @override
  String get libraryFilterTravel => 'यात्रा';

  @override
  String get libraryFilterBusiness => 'व्यवसाय';

  @override
  String get librarySearchHint => 'डेक, विषय या हानज़ी शब्द खोजें...';

  @override
  String libraryNoMatch(String query) {
    return '“$query” से मेल खाता कोई डेक नहीं मिला';
  }

  @override
  String get libraryResetFilters => 'फ़िल्टर रीसेट करें';

  @override
  String get shelfHskTitle => 'आधिकारिक HSK पाठ्यक्रम';

  @override
  String get shelfHskSubtitle => 'आधिकारिक चीनी दक्षता मानक (HSK 1 - 6)';

  @override
  String get shelfCultureTitle => 'संस्कृति और विरासत';

  @override
  String get shelfCultureSubtitle =>
      'पारंपरिक कलाएँ, टीसीएम स्वास्थ्य, चाय और त्योहार';

  @override
  String get shelfSportsTitle => 'खेल और मार्शल आर्ट';

  @override
  String get shelfSportsSubtitle => 'वुशू कुंग फू, बॉल गेम, जिम और एथलेटिक्स';

  @override
  String get shelfEducationTitle => 'शिक्षा और अकादमिक';

  @override
  String get shelfEducationSubtitle =>
      'विश्वविद्यालय अनुसंधान, विज्ञान, तकनीक और भाषाविज्ञान';

  @override
  String get shelfTravelTitle => 'यात्रा और शहरी जीवन';

  @override
  String get shelfTravelSubtitle => 'उत्तरजीविता चीनी, भोजन, खरीदारी और मेट्रो';

  @override
  String get shelfBusinessTitle => 'व्यवसाय और पेशेवर';

  @override
  String get shelfBusinessSubtitle =>
      'अनुबंध, बातचीत, कार्यस्थल और वैश्विक वित्त';

  @override
  String get shelfInstalled => 'लाइब्रेरी में इंस्टॉल';

  @override
  String get shelfAvailable => 'डाउनलोड के लिए उपलब्ध';

  @override
  String shelfSampleVocabulary(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'नमूना शब्दावली ($countString शब्द)';
  }

  @override
  String get shelfRemoveFromBookshelf => 'लाइब्रेरी से हटाएँ';

  @override
  String get shelfDownloadInstall => 'डेक डाउनलोड और इंस्टॉल करें';

  @override
  String get shelfGetButton => 'प्राप्त करें';

  @override
  String shelfDeckCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return '$countString डेक';
  }

  @override
  String shelfAddedThematic(String title) {
    return '“$title” आपकी लाइब्रेरी में जोड़ा गया।';
  }

  @override
  String shelfRemovedThematic(String title) {
    return '“$title” हटा दिया गया।';
  }

  @override
  String get hskDescription1 =>
      '154 बुनियादी हानज़ी, दैनिक अभिवादन, संख्याएँ और सरल वाक्य-संरचनाएँ सीखें।';

  @override
  String get hskDescription2 => 'दैनिक संवाद के लिए 162 प्रारंभिक शब्द सीखें।';

  @override
  String get hskDescription3 =>
      'अकादमिक, सामाजिक और यात्रा में सहज बातचीत के लिए 299 मध्यम स्तर के शब्द सीखें।';

  @override
  String get hskDescription4 =>
      'देशी वक्ताओं से विविध विषयों पर धाराप्रवाह बातचीत के लिए 602 शब्द सीखें।';

  @override
  String get hskDescription5 =>
      'समाचार पत्र, पत्रिकाएँ और फ़िल्मों के लिए 1,300 उन्नत शब्द सीखें।';

  @override
  String get hskDescription6 =>
      'किसी भी बोली या लिखित चीनी को सहज समझने और भाव व्यक्त करने के लिए 2,500 शब्द सीखें।';

  @override
  String get storyCategoryIdiomStories => 'मुहावरों की कहानियाँ';

  @override
  String get storyCategoryContemporaryStories => 'समकालीन कहानियाँ';

  @override
  String get storyCategoryClassicalLiterature => 'शास्त्रीय साहित्य';

  @override
  String get storyCategoryEnglishWorld => 'अंग्रेज़ी और विश्व';

  @override
  String get storyCategoryFrenchClassics => 'फ़्रांसीसी क्लासिक्स';

  @override
  String get storyCategoryAncientPhilosophy => 'प्राचीन दर्शन';

  @override
  String get storyCategoryModernChinese => 'आधुनिक चीनी';

  @override
  String get storyCategoryGermanClassics => 'जर्मन क्लासिक्स';

  @override
  String get storyCategorySpanishWorld => 'स्पेनिश और विश्व';

  @override
  String get storyCategoryChineseEpics => 'चीनी महाकाव्य';

  @override
  String get storyCategorySupernaturalFolklore => 'अलौकिक और लोककथा';

  @override
  String get storyCategoryChinesePoetry => 'चीनी कविता';

  @override
  String get storyCategoryTangPoetry => 'तांग कविता';
}
