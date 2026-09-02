// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get originStoryChip => '📜 Origin story';

  @override
  String get ancientFormChip => '🏺 Ancient form';

  @override
  String get threeMoreWordsChip => '📖 3 more words';

  @override
  String get wordFamilyChip => '🔗 Word family';

  @override
  String get idiomChip => '🀄 Idiom';

  @override
  String get proverbChip => '💬 Proverb';

  @override
  String get strokeOrderChip => '✏️ Stroke order';

  @override
  String get calligraphyTipChip => '🎨 Calligraphy tip';

  @override
  String get grammarNoteChip => '📝 Grammar note';

  @override
  String get similarWordsChip => '🔄 Similar words';

  @override
  String get culturalNoteChip => '🏮 Cultural note';

  @override
  String get inMediaChip => '🀄 In media';

  @override
  String get radicalMeaningChip => '🧩 Radical meaning';

  @override
  String get componentBreakdownChip => '🔍 Component breakdown';

  @override
  String get toneTipChip => '🎵 Tone tip';

  @override
  String get homophonesChip => '👯 Homophones';

  @override
  String askMeAnythingAbout(String hanzi) {
    return 'Ask me anything about $hanzi...';
  }

  @override
  String aiTutorError(String error) {
    return 'AI tutor error: $error';
  }

  @override
  String get aiTutorRateLimit =>
      'The AI tutor is busy right now. Please wait a moment and try again.';

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
  String get studySession => 'Study session';

  @override
  String get readyToStudy => 'Ready to study';

  @override
  String get studyQueuePreviewDescription =>
      'Your session is based on today\'s schedule and deck limits.';

  @override
  String get notNow => 'Not now';

  @override
  String get newLabel => 'नया';

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
      'यदि AI को कोई असंगति मिलती है, तो वह पूछेगा \'क्या आपका मतलब था...?\'. आप दोबारा बोले बिना अपने मूल ऑडियो का पुनः मूल्यांकन कराने के लिए \'हाँ, मुझे फिर से रेट करें!\' पर टैप कर सकते हैं।';

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
  String get library => 'सांस्कृतिक पुस्तकालय (文化书房)';

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
  String get notoserifsc => 'NotoSerifSC';

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
  String play(Object pinyin) {
    return 'चलाएं ($pinyin)';
  }

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
  String get vlog => '中国 日常 vlog';

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
  String get whatIfAiMishears => 'यदि AI मेरी बात गलत सुन ले तो क्या होगा?';

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
      'आपकी Echo Hall बातचीत आपके डिवाइस पर स्थानीय रूप से संग्रहीत की जाती है ताकि आप कभी भी उनकी समीक्षा कर सकें। हम अपने AI मॉडल को प्रशिक्षित करने के लिए आपकी व्यक्तिगत बातचीत का उपयोग नहीं करते हैं।';

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
      'नहीं। जब आप Echo Hall, Scholar\'s Verdict, या Shadowing Studio का उपयोग करते हैं, तो उच्चारण स्कोर उत्पन्न करने के लिए आपके ऑडियो का वास्तविक समय में सुरक्षित मूल्यांकन किया जाता है और उसके तुरंत बाद उसे हटा दिया जाता है। हम आपकी प्रगति को ट्रैक करने के लिए केवल संख्यात्मक रेटिंग संग्रहीत करते हैं।';

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
  String get bookmarkRemoved => '书签已移除 · बुकमार्क हटाया गया';

  @override
  String bookmarkAdded(Object chapter) {
    return '已添加书签 · बुकमार्क जोड़ा गया: अध्याय $chapter';
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
  String get required => 'आवश्यक';

  @override
  String get library1 => 'पुस्तकालय';

  @override
  String get youAreAPremiumMember => 'आप एक प्रीमियम सदस्य हैं';

  @override
  String get createAccountToSyncProgress =>
      'प्रगति सिंक करने के लिए खाता बनाएं';

  @override
  String get signOut => 'साइन आउट करें';

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
  String get mandarinBean => 'Mandarin Bean';

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
  String get theDouble => 'The Double';

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
  String get gemini => 'Gemini';

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
  String get liveOverlay => 'लाइव ओवरले';

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
}
