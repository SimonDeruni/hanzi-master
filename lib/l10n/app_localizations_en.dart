// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

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
  String get isThereAChineseIdiomFeaturingThisCharacter =>
      'Is there a Chinese idiom (成语) featuring this character?';

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
  String get deleteAccount => 'Delete Account';

  @override
  String get deleteAccountSubtitle => 'Permanently delete your account';

  @override
  String get deleteAccountTitle => 'Permanently delete your account?';

  @override
  String get accountDataDeletedTitle => 'Account data will be deleted';

  @override
  String get accountDataDeletedBody =>
      'Your sign-in account and account information held by SinoSpark will be permanently deleted. This cannot be undone.';

  @override
  String get localDataKeptTitle => 'Data on this device will remain';

  @override
  String get localDataKeptBody =>
      'Study progress, downloaded content, and preferences stored only on this device will not be removed.';

  @override
  String get subscriptionNotCanceledTitle => 'Subscriptions are not canceled';

  @override
  String get subscriptionNotCanceledBody =>
      'Deleting your account does not cancel an App Store subscription. It may continue to renew until you cancel it with Apple.';

  @override
  String get manageSubscription => 'Manage App Store Subscription';

  @override
  String get subscriptionManagementFailed =>
      'Could not open Apple subscription management. Open Settings, tap your name, then tap Subscriptions.';

  @override
  String get confirmPassword => 'Current password';

  @override
  String get confirmPasswordToDelete =>
      'Enter your password to confirm your identity.';

  @override
  String get deleteAccountPermanently => 'Delete Account Permanently';

  @override
  String get deleteAccountFinalTitle => 'Final confirmation';

  @override
  String get deleteAccountFinalWarning =>
      'This permanently deletes your account and cannot be undone. Data stored only on this device will remain. Continue?';

  @override
  String get deletingAccount => 'Deleting account...';

  @override
  String get accountPasswordRequired =>
      'Enter your current password to continue.';

  @override
  String get accountPasswordIncorrect =>
      'The password is incorrect. Please try again.';

  @override
  String get accountReauthenticationCanceled =>
      'Identity confirmation was canceled. Your account was not deleted.';

  @override
  String get accountReauthenticationFailed =>
      'We could not confirm your identity. Please try again and complete the sign-in prompt.';

  @override
  String get accountAlreadySignedOut =>
      'You are already signed out. No signed-in account was deleted.';

  @override
  String get accountProviderUnsupported =>
      'This sign-in method cannot be verified in the app. Contact support for help deleting the account.';

  @override
  String get appleDeletionRequiresAppleDevice =>
      'For security, an account linked to Apple must be deleted on an Apple device.';

  @override
  String get accountDeletionNetworkError =>
      'Check your internet connection and try deleting the account again.';

  @override
  String get accountDeletionFailed =>
      'The account could not be deleted. Your account remains active. Please try again.';

  @override
  String get accountDeletedSuccessfully =>
      'Your account was permanently deleted.';

  @override
  String get globalMastery => 'GLOBAL MASTERY';

  @override
  String get masteredCards => 'Mastered';

  @override
  String get hsk1Candidate => 'HSK 1 Candidate';

  @override
  String get hsk2Candidate => 'HSK 2 Candidate';

  @override
  String get hsk3Candidate => 'HSK 3 Candidate';

  @override
  String get hsk4Candidate => 'HSK 4 Candidate';

  @override
  String get hsk5Candidate => 'HSK 5 Candidate';

  @override
  String get hsk6Candidate => 'HSK 6 Candidate';

  @override
  String get hsk6Master => 'HSK 6 Master';

  @override
  String get currentRank => 'CURRENT RANK';

  @override
  String get next => 'Next';

  @override
  String get searchHanziOrPinyin => 'Search Hanzi or Pinyin...';

  @override
  String get dailyReview => 'Daily Review';

  @override
  String get upcomingForecast => 'Upcoming Forecast';

  @override
  String get laterToday => 'Later Today';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get next7Days => 'Next 7 Days';

  @override
  String get theScholarWay => 'The Scholar\'s Way';

  @override
  String get beginJourney => 'Begin Journey';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get darkModeDesc => 'Easy on the eyes';

  @override
  String get voiceSpeed => 'Voice Speed';

  @override
  String get artAndIntellect => 'ART & INTELLECT';

  @override
  String get theDigitalScholar => 'The Digital Scholar';

  @override
  String get refineBrushVoice =>
      'Refine your brush and voice with advanced AI.';

  @override
  String get liveVoiceCall => 'Live Voice Call';

  @override
  String get immersiveRoleplay => 'Immersive roleplay with AI avatars';

  @override
  String get readingRoom => 'Reading Room';

  @override
  String get shadowingStudio => 'Shadowing Studio';

  @override
  String get errorPrefix => 'Error: ';

  @override
  String get initializingLibrary => 'Initializing Library...';

  @override
  String get unlockCharactersToQuiz =>
      'Unlock at least 4 characters to start a quiz!';

  @override
  String get practiceQuiz => 'PRACTICE QUIZ';

  @override
  String get curriculumPaths => 'CURRICULUM PATHS';

  @override
  String get noDecksFound => 'No decks found. Add some to your library!';

  @override
  String get addCardsFirst => 'Add some cards to this deck first!';

  @override
  String get aiDraftingPath => 'The AI Scholar is drafting your path...';

  @override
  String get pathReady => 'Your path is ready!';

  @override
  String get errorGeneratingPath => 'Error generating path';

  @override
  String get brushingCurriculum => 'Brushing Curriculum...';

  @override
  String get warmUp => 'WARM UP';

  @override
  String get lessonComplete => 'Lesson Complete! +10 Ink Points';

  @override
  String get step1Origin => 'STEP 1: THE ORIGIN';

  @override
  String get traceRadical => 'Trace the Radical';

  @override
  String get step2Forge => 'STEP 2: THE FORGE';

  @override
  String get chooseEssence => 'Choose the Essence';

  @override
  String get wrongEssence => 'Wrong essence! Try again.';

  @override
  String get step3Hunt => 'STEP 3: THE HUNT';

  @override
  String get findCharacters => 'Find characters';

  @override
  String get notThatOne => 'Not that one! Look closer.';

  @override
  String get successfullyInstalled => 'Successfully installed';

  @override
  String get failedToDownload => 'Failed to download module.';

  @override
  String get rescindTitle => 'Rescind?';

  @override
  String get removeCharactersWarning =>
      'This will remove these characters from your library and reset your mastery progress.';

  @override
  String get cancel => 'Cancel';

  @override
  String get uninstall => 'Uninstall';

  @override
  String get removedLibrary => 'Removed Library.';

  @override
  String get tomeLibrary => 'Tome Library';

  @override
  String get libraryError => 'Library Error';

  @override
  String get installTome => 'INSTALL TOME';

  @override
  String get unitIntro => 'UNIT INTRO';

  @override
  String get constellationCluster => 'Constellation Cluster';

  @override
  String get ok => 'OK';

  @override
  String get divingInto => 'Diving into...';

  @override
  String get keyRadicals => 'KEY RADICALS';

  @override
  String get noRadicalData => 'No radical data available.';

  @override
  String get discovery => 'DISCOVERY';

  @override
  String get startLearning => 'START LEARNING';

  @override
  String get selectPersona => 'Select Persona';

  @override
  String get customPersona => 'Custom Persona';

  @override
  String get geminiLiveCall => 'GEMINI LIVE CALL';

  @override
  String get returnToMenu => 'Return to menu';

  @override
  String get strokeAnalysis => 'Stroke Analysis';

  @override
  String get excellentWork => 'Excellent work!';

  @override
  String get keepPracticing => 'Keep practicing!';

  @override
  String get drawingSubmitted => 'Drawing Submitted';

  @override
  String get customPersonaHint => 'Define a custom persona...';

  @override
  String get stepOneOrigin => 'STEP 1: THE ORIGIN';

  @override
  String get stepTwoForge => 'STEP 2: THE FORGE';

  @override
  String get toForge => 'To forge';

  @override
  String get whatEssenceDoesNeed => 'what essence does';

  @override
  String get need => 'need';

  @override
  String get forged => 'FORGED';

  @override
  String get stepThreeHunt => 'STEP 3: THE HUNT';

  @override
  String get findCharactersWith => 'Find characters with';

  @override
  String get uninstallButton => 'UNINSTALL';

  @override
  String get gradedAiStories => 'Graded Ai Stories';

  @override
  String get calligraphy => 'Calligraphy';

  @override
  String get theScrollOfOrigin => 'The Scroll Of Origin';

  @override
  String get galaxyOf => 'Galaxy Of';

  @override
  String get constellationDescription => 'Constellation Description';

  @override
  String get noRadicalDataAvailable => 'No Radical Data Available';

  @override
  String get learningPreferences => 'Learning Preferences';

  @override
  String get hardMode => 'Hard Mode';

  @override
  String get hardModeDesc => 'Hard Mode Desc';

  @override
  String get adaptiveGuidance => 'Adaptive Guidance';

  @override
  String get dailyGoal => 'Daily Goal';

  @override
  String get audioAndHaptics => 'Audio And Haptics';

  @override
  String get autoPlayAudio => 'Auto Play Audio';

  @override
  String get autoPlayDesc => 'Auto Play Desc';

  @override
  String get haptics => 'Haptics';

  @override
  String get displayAndContent => 'Display And Content';

  @override
  String get useEnglishDefinitions => 'Use English definitions';

  @override
  String get useEnglishDefinitionsDesc =>
      'English definitions are generally more accurate and detailed';

  @override
  String get animationSpeed => 'Animation Speed';

  @override
  String get manageTomes => 'Manage Tomes';

  @override
  String get manageTomesDesc => 'Manage Tomes Desc';

  @override
  String get dangerZone => 'Danger Zone';

  @override
  String get resetAllData => 'Reset All Data';

  @override
  String get resetDataDesc => 'Reset Data Desc';

  @override
  String get areYouSure => 'Are You Sure';

  @override
  String get cannotBeUndone => 'Cannot Be Undone';

  @override
  String get deleteEverything => 'Delete Everything';

  @override
  String get appLanguage => 'App Language';

  @override
  String get howDidYouDo => 'How did you do?';

  @override
  String get missedItEntirely => 'Missed it entirely';

  @override
  String get gotItButStruggled => 'Got it, but struggled';

  @override
  String get gotItClearly => 'Got it clearly';

  @override
  String get perfectAndImmediate => 'Perfect & immediate';

  @override
  String get again => 'Again';

  @override
  String get hard => 'Hard';

  @override
  String get good => 'Good';

  @override
  String get easy => 'Easy';

  @override
  String get tapToReveal => 'Tap to Reveal';

  @override
  String get howWellDidYouRemember => 'How well did you remember?';

  @override
  String get completelyForgot => 'Completely forgot';

  @override
  String get gotItWithDifficulty => 'Got it with difficulty';

  @override
  String get recalledCorrectly => 'Recalled correctly';

  @override
  String get perfectRecall => 'Perfect recall';

  @override
  String get practiceWriting => 'Practice Writing';

  @override
  String get hideScratchpad => 'Hide Scratchpad';

  @override
  String get whatCharacterMeans => 'What character means:';

  @override
  String get tapCardToReveal => 'Tap card to Reveal';

  @override
  String get ratePronunciationConfidence =>
      'Rate your pronunciation confidence';

  @override
  String get botchedIt => 'Botched it';

  @override
  String get struggledWithTones => 'Struggled with tones';

  @override
  String get acceptable => 'Acceptable';

  @override
  String get perfectlyNatural => 'Perfectly natural';

  @override
  String get sessionComplete => 'Session Complete!';

  @override
  String get accuracy => 'Accuracy';

  @override
  String get reviewed => 'Reviewed';

  @override
  String get correct => 'Correct';

  @override
  String get backToLibrary => 'Back to Library';

  @override
  String get revealAnswer => 'Reveal Answer';

  @override
  String get aiHubTitle => 'AI Hub';

  @override
  String get textChat => 'Text Chat';

  @override
  String get scholarlyPersonas => 'Scholarly Personas';

  @override
  String get shadowing => 'Shadowing';

  @override
  String get liveTranslation => 'Live Translation';

  @override
  String get scholarsLibrary => 'The Scholar\'s Library';

  @override
  String get generate => 'Generate';

  @override
  String get searchPinyinHanziEnglish => 'Search Pinyin, Hanzi, or English...';

  @override
  String get liveTranslate => 'Live Translate';

  @override
  String get travelInterpreter => 'Travel Interpreter';

  @override
  String get realTimeSplitScreen =>
      'Real-time split-screen conversation with a native speaker. Breaks down language barriers instantly.';

  @override
  String get whisperEarpiece => 'Whisper Earpiece';

  @override
  String get listenToChineseAudio =>
      'Listen to Chinese audio and get real-time English subtitles directly on your screen.';

  @override
  String get dashboardTitle => 'Dashboard';

  @override
  String get yourMindIsClear => 'Your mind is clear.';

  @override
  String get noReviewsDueToday => 'No reviews due today.';

  @override
  String get done => 'Done';

  @override
  String get hskLevel1 => 'HSK Level 1';

  @override
  String get hskLevel2 => 'HSK Level 2';

  @override
  String get hskLevel3 => 'HSK Level 3';

  @override
  String get hskLevel4 => 'HSK Level 4';

  @override
  String get hskLevel5 => 'HSK Level 5';

  @override
  String get hskLevel6 => 'HSK Level 6';

  @override
  String get generalVocabulary => 'General Vocabulary';

  @override
  String cardsRequireAttention(Object count) {
    return 'cards require attention.';
  }

  @override
  String get begin => 'Begin';

  @override
  String get poweredByAi =>
      'Powered by advanced AI. Seamless real-time translation for any scenario.';

  @override
  String get downloadingModel => 'Downloading model...';

  @override
  String get soon => 'SOON';

  @override
  String get installed => 'INSTALLED';

  @override
  String get premium => 'PREMIUM';

  @override
  String get coreModule => 'CORE MODULE';

  @override
  String get step6Context => 'STEP 6: CONTEXT';

  @override
  String get tapBuildingBlocksTo =>
      'Tap building blocks to explore their origin.';

  @override
  String get initiateRadicalSequence => 'INITIATE RADICAL SEQUENCE';

  @override
  String get holdToTalk => 'Hold to Talk';

  @override
  String get customScenario => 'Custom Scenario';

  @override
  String get voiceCall => 'Voice Call';

  @override
  String get pronunciation => 'Pronunciation';

  @override
  String get selectAScenarioTo =>
      'Select a scenario to practice your spoken Mandarin. The Scholar will grade your tones and clarity.';

  @override
  String get create => 'Create';

  @override
  String get createYourScenario => 'Create Your Scenario';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get scholarsVerdict => 'SCHOLAR\'S VERDICT';

  @override
  String get completeReview => 'Complete Review';

  @override
  String get conversationReview => 'CONVERSATION REVIEW';

  @override
  String get linguisticAnalysis => 'Linguistic Analysis';

  @override
  String get examplesInHsk1 => 'EXAMPLES IN HSK 1';

  @override
  String get characterReference => 'Character Reference';

  @override
  String get askTutor => 'Ask Tutor';

  @override
  String get addToStudyDeck => 'Add to Study Deck';

  @override
  String get startPractice => 'START PRACTICE';

  @override
  String get noOtherHsk1 => 'No other HSK 1 characters use this radical.';

  @override
  String get couldNotLoadAi =>
      'Could not load AI context. (Rate limit or network error)\\nTap the refresh button below to try again later.';

  @override
  String get noAvailableCardsFound => 'No available cards found.';

  @override
  String get addCards => 'Add Cards';

  @override
  String get removeCard => 'Remove Card';

  @override
  String get remove => 'Remove';

  @override
  String get review => 'Review';

  @override
  String get story => 'Story';

  @override
  String get thisDeckIsEmpty => 'This deck is empty.';

  @override
  String get tapTheAddCards => 'Tap the Add Cards button!';

  @override
  String get noCardsFound => 'No cards found.';

  @override
  String get addCardsToSee => 'Add cards to see statistics.';

  @override
  String get aiGenerated => 'AI Generated';

  @override
  String get allCardsCaughtUp => 'All cards caught up! Great job.';

  @override
  String get latestDiscoveries => 'Latest Discoveries';

  @override
  String get noCharactersInLexicon => 'No characters in lexicon yet.';

  @override
  String get yourBookshelf => 'Your Bookshelf';

  @override
  String get text_1782026184579 => '字';

  @override
  String get searchYourDictionary => 'Search your dictionary...';

  @override
  String get saveCard => 'Save Card';

  @override
  String get noCharactersFound => 'No characters found.';

  @override
  String get radicalsIndex => 'Radicals Index';

  @override
  String get masteringRadicalsIsThe =>
      'Mastering radicals is the key to unlocking thousands of Hanzi. Select a radical to see all characters that use it.';

  @override
  String get noRadicalsFound => 'No radicals found.';

  @override
  String get yourDrawing => 'Your Drawing';

  @override
  String get reference => 'Reference';

  @override
  String get rateYourRecall => 'Rate your recall';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get reportBugsOrRequest => 'Report bugs or request features';

  @override
  String get allDataHasBeen => 'All data has been wiped.';

  @override
  String get hanziMasterV100 => 'SinoSpark v1.0.0';

  @override
  String get myProgress => 'My Progress';

  @override
  String get overview => 'Overview';

  @override
  String get aiStory => 'AI Story';

  @override
  String get usingYourDecksVocabulary => 'Using your deck\'s vocabulary';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get translate => 'Translate';

  @override
  String get pinyin => 'Pinyin';

  @override
  String get fullTranslation => 'Full Translation';

  @override
  String get geminiFlashIsStructuring => 'Crafting your custom story...';

  @override
  String get aiDeckGenerator => 'AI Deck Generator';

  @override
  String get whatDoYouWant => 'What do you want to learn?';

  @override
  String get targetDifficulty => 'Target Difficulty';

  @override
  String get focusArea => 'Focus Area';

  @override
  String get specificContextOrTone => 'Specific Context or Tone (Optional)';

  @override
  String get numberOfCards => 'Number of Cards';

  @override
  String get generateDeck => 'Generate Deck';

  @override
  String get aiGrammarExplanation => 'AI Grammar Explanation';

  @override
  String get scholarsDesk => 'Scholar\'s Desk';

  @override
  String get chooseADeck => 'Choose a Deck';

  @override
  String get whereWouldYouLike =>
      'Where would you like to save this character?';

  @override
  String get addToDefaultStudy => 'Add to Default Study Deck';

  @override
  String get ifOffItsOnly =>
      'If off, it\'s only saved to the global Dictionary';

  @override
  String get saveToLibrary => 'Save to Library';

  @override
  String get pleaseEnterValidChinese => 'Please enter valid Chinese characters';

  @override
  String get reviewAiCard => 'Review AI Card';

  @override
  String get pleaseDoublecheckTheAis =>
      'Please double-check the AI\'s output below. Feel free to tweak the pinyin or definition before saving it to your permanent library.';

  @override
  String get alreadyInYourLibrary => 'Already in your Library!';

  @override
  String get meaningInContext => 'Meaning in Context';

  @override
  String get explainGrammar => 'Explain Grammar';

  @override
  String get addToLibrary => 'Add to Library';

  @override
  String get masterYourMandarinPronunciation =>
      'Master your Mandarin pronunciation by mimicking native speech in real-time.';

  @override
  String get startSession => 'Start session';

  @override
  String get sessionHistory => 'Session History';

  @override
  String get noSavedSessions => 'No saved sessions.';

  @override
  String get aiBreakdown => 'AI Breakdown';

  @override
  String get sessionDetails => 'Session Details';

  @override
  String partner(Object lang) {
    return 'Partner (中文)';
  }

  @override
  String get youEnglish => 'You (English)';

  @override
  String get noTranscriptToSave => 'No transcript to save!';

  @override
  String get sessionSaved => 'Session saved!';

  @override
  String get realtimeBidirectionalTranslationSpeak =>
      'Real-time bidirectional translation. Speak English or Mandarin, and it will instantly translate for you and your partner.';

  @override
  String get text_1782026184665 => '录音中';

  @override
  String get recording => 'Recording';

  @override
  String get yourSilentCompanionListen =>
      'Your silent companion. Listen to Mandarin, and hear the English translation instantly.';

  @override
  String get startListening => 'START LISTENING';

  @override
  String get skip => 'Skip';

  @override
  String get independentStars => 'INDEPENDENT STARS';

  @override
  String get notEveryCharacterHas =>
      'Not every character has a parent Radical. Some are unique pictographs or stand alone.';

  @override
  String get onTheMapWe =>
      'On the map, we group these independent characters into CONSTELLATIONS (✨).';

  @override
  String get iUnderstand => 'I UNDERSTAND';

  @override
  String get whatAreRadicals => 'WHAT ARE RADICALS?';

  @override
  String get hanziAreBuiltFrom =>
      'Hanzi are built from building blocks called RADICALS.\\n\\nThey give the character its core meaning or theme.';

  @override
  String get continueText => 'CONTINUE';

  @override
  String get hanziAreNotJust =>
      'Hanzi are not just letters. They are pictures frozen in time.\\n\\nTo master them, you must learn to trace their flow.';

  @override
  String get iAmReady => 'I AM READY';

  @override
  String get youAreAScholar => 'YOU ARE A SCHOLAR';

  @override
  String get theGalaxyMapAwaitsnmaster =>
      'The Galaxy Map awaits.\\nMaster the Suns (Radicals) to unlock the Planets (Characters).';

  @override
  String get enterTheScroll => 'ENTER THE SCROLL';

  @override
  String get openingTheOriginScroll => 'Opening the Origin Scroll...';

  @override
  String get text_1782026184670 => '+';

  @override
  String get theScholarsEdition => 'The Scholar\'s Edition';

  @override
  String get weArePreparingThe =>
      'We are preparing the Scholar\'s Edition for launch.';

  @override
  String get devBypassUnlockNow => 'DEV BYPASS: UNLOCK NOW';

  @override
  String get restorePurchases => 'Restore Purchases';

  @override
  String get welcomeScholarTheScroll =>
      'Welcome, Scholar. The scroll is fully open to you.';

  @override
  String get purchasesRestoredSuccessfully =>
      'Purchases restored successfully.';

  @override
  String get noPreviousPurchasesFound =>
      'No previous purchases found on this account.';

  @override
  String get unlockTheFullPotential =>
      'Unlock the full potential of your journey. One time purchase, yours forever.';

  @override
  String get universalScanner => 'Universal Scanner';

  @override
  String get noChineseCharactersFound =>
      'No Chinese characters found in the image.';

  @override
  String get addedNewCharactersTo => 'Added new characters to your library!';

  @override
  String get extractingTextAndObjects => 'Extracting text and objects...';

  @override
  String get scanATextbookSign =>
      'Scan a textbook, sign, or object to extract Chinese characters.';

  @override
  String get extractedText => 'Extracted Text';

  @override
  String get useText => 'Use Text';

  @override
  String get noMatchingDictionaryEntries =>
      'No matching dictionary entries found.';

  @override
  String get quizComplete => 'Quiz Complete!';

  @override
  String get returnToCourse => 'Return to Course';

  @override
  String get notEnoughCardsFor =>
      'Not enough cards for a quiz! Need at least 4.';

  @override
  String get creatorMode => 'Creator Mode';

  @override
  String get noStoriesFoundMatching => 'No stories found matching your search.';

  @override
  String get discard => 'Discard';

  @override
  String get save => 'Save';

  @override
  String get generatingStoryViaDeepseek => 'Generating story via DeepSeek...';

  @override
  String get storySavedToLibrary => 'Story saved to Library!';

  @override
  String get storyNotFound => 'Story not found.';

  @override
  String get targetHskLevel => 'Target HSK Level';

  @override
  String get wedLoveToHear => 'We\'d love to hear from you!';

  @override
  String get whetherYouveFoundA =>
      'Whether you\'ve found a bug, have a feature request, or just want to say hi, your feedback helps us improve SinoSpark.';

  @override
  String get pointYourCameraAt => 'Point your camera at objects';

  @override
  String get reviewAddToLibrary => 'Review & Add to Library';

  @override
  String hideStrokeGuideStreak(Object streak) {
    return 'Hide stroke guide at streak: $streak';
  }

  @override
  String inkPoints(Object points) {
    return '$points Ink Points';
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
  String get supportAndFeedback => 'Support & Feedback';

  @override
  String get reportBug => 'Report a Bug';

  @override
  String get suggestFeature => 'Suggest a Feature';

  @override
  String get generalFeedback => 'General Feedback';

  @override
  String get pleaseDrawSomethingFirst => 'Please draw something first';

  @override
  String get drawThisCharacter => 'Draw this character:';

  @override
  String followGuideStroke(Object current, Object total) {
    return 'Follow the blue guide to draw stroke $current of $total';
  }

  @override
  String get skipCurrentStroke => 'Skip Current Stroke';

  @override
  String get submitDrawing => 'Submit Drawing';

  @override
  String addedToDeck(Object deckName, Object hanzi) {
    return 'Added $hanzi to $deckName';
  }

  @override
  String removedFromDeck(Object hanzi) {
    return 'Removed $hanzi from deck';
  }

  @override
  String skippedNoStrokeData(Object hanzi) {
    return 'Skipped \"$hanzi\" - No stroke data available for this AI character.';
  }

  @override
  String get startingSession => 'Starting session...';

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
  String get newLabel => 'New';

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
  String get masterBuildingBlocks => 'Master the building blocks of Hanzi';

  @override
  String get totalWords => 'Total Words';

  @override
  String get newInk => 'New Ink';

  @override
  String get learningStatus => 'Learning';

  @override
  String get masteredStatus => 'Mastered';

  @override
  String get libraryMastery => 'Library Mastery';

  @override
  String get accuracyByMode => 'Accuracy by Mode';

  @override
  String get upcomingReviews => 'Upcoming Reviews (Next 7 Days)';

  @override
  String get culturalReadingRoom => '文化书房 (Cultural Reading Room)';

  @override
  String storyTitleHsk(Object level, Object title) {
    return '$title (HSK $level)';
  }

  @override
  String get pleaseEnterTopic => 'Please enter a topic';

  @override
  String createdDeckCards(Object count, Object name) {
    return 'Created $name with $count cards!';
  }

  @override
  String gradeResult(Object grade) {
    return 'Grade: $grade';
  }

  @override
  String get listeningMode => 'Listening Mode';

  @override
  String get readingMode => 'Reading Mode';

  @override
  String get recallMode => 'Recall Mode';

  @override
  String get speakingMode => 'Speaking Mode';

  @override
  String get aiMemoryHook => 'AI Memory Hook';

  @override
  String get exampleSentences => 'Example Sentences';

  @override
  String get ghostCharacters => 'Ghost Characters';

  @override
  String get commonWords => 'Common Words';

  @override
  String get personalNotes => 'Personal Notes';

  @override
  String get addPersonalNotes => 'Add your own mnemonics or notes here...';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get gallery => 'Gallery';

  @override
  String get arLens => 'AR Lens';

  @override
  String addedCharToLibrary(Object char) {
    return 'Added $char to Library';
  }

  @override
  String get scoreText => 'score';

  @override
  String get searchDictionaryHint => 'Search character, pinyin, or meaning...';

  @override
  String get searchDeckHint => 'Search character, pinyin...';

  @override
  String get localRestaurant => 'Local Restaurant';

  @override
  String get taxiToAirport => 'Taxi to Airport';

  @override
  String get silkMarketHaggling => 'Silk Market Haggling';

  @override
  String get medicalClinic => 'Medical Clinic';

  @override
  String get meetingAFriend => 'Meeting a Friend';

  @override
  String get jobInterview => 'Job Interview';

  @override
  String get searchRadicalsHint => 'Search radicals (e.g. Water, 氵)';

  @override
  String get definition => 'Definition';

  @override
  String get undo => 'UNDO';

  @override
  String get hanziMaster => 'SinoSpark';

  @override
  String get unlockForever => 'Unlock Forever - .99';

  @override
  String get clear => 'Clear';

  @override
  String get clearChat => 'Clear chat';

  @override
  String get typeMessage => 'Type your message...';

  @override
  String addedToLibrary(Object hanzi) {
    return 'Added \'$hanzi\' to your Library';
  }

  @override
  String get generateNewStory => 'Generate New Story';

  @override
  String failedToGenerateStory(Object error) {
    return 'Failed to generate story:\\n$error';
  }

  @override
  String get detail => 'Detail';

  @override
  String get scanText => 'Scan Text';

  @override
  String get createMagic => 'Create Magic';

  @override
  String get learning => 'Learning';

  @override
  String get upcomingReviews7Days => 'Upcoming Reviews (Next 7 Days)';

  @override
  String get askFollowUpQuestion => 'Ask a follow-up question...';

  @override
  String get pasteScanToSimplify => 'Paste or scan Chinese text to simplify';

  @override
  String get searchStoriesHint =>
      'Search stories by title or tags (e.g. mythology, travel)';

  @override
  String get importAll => 'Import All';

  @override
  String get ascendAll => 'Ascend All';

  @override
  String get startAscension => 'Start Ascension';

  @override
  String get scenarioLocalRestaurant => 'Local Restaurant';

  @override
  String get scenarioLocalRestaurantDesc =>
      'Practice ordering dishes and asking for recommendations.';

  @override
  String get scenarioTaxiAirport => 'Taxi to Airport';

  @override
  String get scenarioTaxiAirportDesc =>
      'Tell the driver your destination and discuss the traffic.';

  @override
  String get scenarioSilkMarket => 'Silk Market Haggling';

  @override
  String get scenarioSilkMarketDesc =>
      'Try to get a better price for a souvenir.';

  @override
  String get scenarioMedicalClinic => 'Medical Clinic';

  @override
  String get scenarioMedicalClinicDesc =>
      'Explain your symptoms to a traditional doctor.';

  @override
  String get scenarioMeetingFriend => 'Meeting a Friend';

  @override
  String get scenarioMeetingFriendDesc =>
      'Introduce yourself and make small talk.';

  @override
  String get scenarioJobInterview => 'Job Interview';

  @override
  String get scenarioJobInterviewDesc =>
      'Apply for a role at a tech company in Shanghai.';

  @override
  String get createCustomScenario => 'Create Custom Scenario';

  @override
  String get customScenarioTitleHint => 'Title (e.g. Wedding Reception)';

  @override
  String get customScenarioDescHint => 'Description (Context)';

  @override
  String get customScenarioPersonaHint =>
      'AI Persona (e.g. A curious coworker)';

  @override
  String get customScenarioDifficulty => 'Difficulty';

  @override
  String get createAction => 'Create';

  @override
  String get cancelAction => 'Cancel';

  @override
  String get mythsAndLegends => 'Myths & Legends';

  @override
  String get historyAndCulture => 'History & Culture';

  @override
  String get idiomsTitle => 'Idioms (成语)';

  @override
  String get theMonkeyKing => 'The Monkey King';

  @override
  String get theMonkeyKingDesc => 'Sun Wukong (Journey to the West)';

  @override
  String get huaMulan => 'Hua Mulan';

  @override
  String get huaMulanDesc => 'Hua Mulan joining the army instead of her father';

  @override
  String get confuciusTitle => 'Confucius';

  @override
  String get confuciusDesc => 'The life and teachings of Confucius';

  @override
  String get theGreatWall => 'The Great Wall';

  @override
  String get theGreatWallDesc => 'Building the Great Wall of China';

  @override
  String get generateTopic => 'Generate Topic';

  @override
  String get simplifyText => 'Simplify Text';

  @override
  String get topicHint => 'Topic (e.g. Aliens in Beijing)';

  @override
  String get tagsHint => 'Tags (comma separated, optional)';

  @override
  String get speakWithMasterLin => 'Speak with Master Lin';

  @override
  String get masterLinGreeting =>
      'Greetings, student. The ink is ready. What character or phrase shall we examine today?';

  @override
  String get typeYourMessage => 'Type your message...';

  @override
  String get theMainLibrary => 'The Main Library';

  @override
  String get hsk1Foundation => 'HSK 1: Foundation';

  @override
  String get hsk2Elementary => 'HSK 2 (Elementary)';

  @override
  String get hsk3Intermediate => 'HSK 3 (Intermediate)';

  @override
  String get inDeckCheck => 'In Deck ✓';

  @override
  String get addToDeckPlus => '+ Add to Deck';

  @override
  String get openCardArrow => 'Open Card →';

  @override
  String get pronunciationPartial => 'Tone Imprecise';

  @override
  String get pronunciationWrong => 'Incorrect';

  @override
  String get toneExpected => 'Expected';

  @override
  String get toneYouSaid => 'You Said';

  @override
  String get gotIt => 'Got it!';

  @override
  String foundNCharacters(int count) {
    return '$count Characters Found';
  }

  @override
  String get lookingUpCharacters => 'Looking up characters…';

  @override
  String get practiceAll => 'Practice All';

  @override
  String get arLensObjects => 'Objects';

  @override
  String get arLensText => 'Text';

  @override
  String get arLensDetectedText => 'Detected Text';

  @override
  String get duration12Min => '1-2 min';

  @override
  String get aClassicTangDynastyPoem => 'A classic Tang Dynasty poem';

  @override
  String get aClassicTangDynastyPoemBy => 'A classic Tang Dynasty poem by';

  @override
  String get aStructuralComponent => 'A structural component.';

  @override
  String get addSelectedToDeck => 'Add Selected to Deck';

  @override
  String addTo(Object target) {
    return 'Add to $target';
  }

  @override
  String addedHanziToYourLibrary(String hanzi) {
    return 'Added \'$hanzi\' to your Library';
  }

  @override
  String get adjustFontSize => 'Adjust Font Size';

  @override
  String get againGoodEasyHard => '⬅️ Again    ➡️ Good    ⬆️ Easy    ⬇️ Hard';

  @override
  String get aiAnalysisFailed => 'AI Analysis Failed';

  @override
  String get aiIsThinking => 'AI is thinking...';

  @override
  String get aiSceneAnalysisFailed => 'AI Scene Analysis Failed';

  @override
  String get allLabel => 'All';

  @override
  String get allPinyin => 'All Pinyin';

  @override
  String get alreadyHaveAccountSignIn => 'Already have an account? Sign in';

  @override
  String get analysisFailed => 'Analysis Failed:';

  @override
  String get analyzingClassicalCharacters =>
      'Analyzing classical characters...';

  @override
  String get anatomy => 'Anatomy';

  @override
  String get ancientPhilosophy => 'Ancient Philosophy';

  @override
  String get warringStates => 'Warring States';

  @override
  String get hanFeiLegalism =>
      'Han Fei (c. 280–233 BCE) was a prince of the state of Han and the foremost thinker of Chinese Legalism. Drawing together the ideas of law, administrative technique, and authority, his writings in the Han Feizi profoundly influenced the political philosophy and institutions of imperial China.';

  @override
  String get articleSavedToMediaHub => 'Article saved to Media Hub!';

  @override
  String get askAFollowUp => 'Ask a follow-up...';

  @override
  String get audioPrivacyAndHowThingsWork =>
      'Audio, privacy, and how things work';

  @override
  String get audiobookPlayer => 'Audiobook Player';

  @override
  String get audiobookVoice => 'Audiobook Voice';

  @override
  String get auntieMaTown =>
      'Auntie Ma (马阿姨), an energetic and loud stall owner who makes the crispiest Roujiamo and Liangpi in town.';

  @override
  String get back => 'Back';

  @override
  String get baristaKevinNotes =>
      'Barista Kevin (小凯), a passionate young coffee roaster who loves discussing Yunnan coffee beans and flavor notes.';

  @override
  String get bbc => 'BBC 中文网';

  @override
  String get beginYourJourney => 'Begin Your Journey';

  @override
  String get bestValue => 'Best Value';

  @override
  String get bookLinkCopiedToClipboard => 'Book link copied to clipboard!';

  @override
  String get bookmarkChapter => 'Bookmark Chapter';

  @override
  String get bookmarks => 'Bookmarks';

  @override
  String get books => 'Books';

  @override
  String get briefing => 'Briefing';

  @override
  String get bugReport => 'Bug Report';

  @override
  String get caoXueqinDecline =>
      'Cao Xueqin (c. 1715–1763) was a Qing Dynasty novelist born into a once-wealthy Bannerman family whose fortunes collapsed under Emperor Yongzheng. Dream of the Red Chamber, written in his poverty-stricken final years, is widely regarded as the pinnacle of Chinese fiction — a vast, psychologically rich taphos of aristocratic decline.';

  @override
  String get cardsTitle => 'CARDS';

  @override
  String get cc => 'CC';

  @override
  String get characterOrWord => 'Character / Word';

  @override
  String get chatMore => 'Chat more';

  @override
  String get chefChenShumai =>
      'Chef Chen (陈师傅), a cheerful Cantonese dim sum chef recommending fresh Har Gow shrimp dumplings and Shumai.';

  @override
  String get chineseEpics => 'Chinese Epics';

  @override
  String get chinesePoetry => 'Chinese Poetry';

  @override
  String get chng => 'chéng';

  @override
  String get chongqingSpicyHotpotFeast => 'Chongqing Spicy Hotpot Feast';

  @override
  String get chooseAudiobookVoice => 'Choose Audiobook Voice';

  @override
  String get chooseVoice => 'Choose Voice';

  @override
  String get compare => 'Compare';

  @override
  String get compare4Tones => 'Compare 4 Tones';

  @override
  String get configuration => 'Configuration';

  @override
  String get contemporary => 'Contemporary';

  @override
  String get context => 'Context';

  @override
  String get couldNotLoadLibrary => 'Couldn\'t load the library';

  @override
  String get couldNotLoadVocabulary => 'Could not load vocabulary.';

  @override
  String get couldNotOpenEmailApp => 'Could not open email app.';

  @override
  String get createAccount => 'Create Account';

  @override
  String get createNewDeck => 'Create New Deck';

  @override
  String get createScenario => 'Create Scenario';

  @override
  String get createStory => 'Create Story';

  @override
  String get customLabel => 'Custom';

  @override
  String get customWord => 'Custom Word';

  @override
  String get days => 'days';

  @override
  String get deck => 'Deck';

  @override
  String get deckName => 'Deck Name';

  @override
  String get deckStory => 'Deck Story';

  @override
  String get deepAnalysis => 'Deep Analysis';

  @override
  String get defaultDeck => 'Default Deck';

  @override
  String get deleteLabel => 'Delete';

  @override
  String get deleteScenario => 'Delete Scenario';

  @override
  String get deletesAllProgressPermanently =>
      'Deletes all progress permanently';

  @override
  String get developerBackdoorUnlocked => 'Developer Backdoor Unlocked!';

  @override
  String get doesNotExistInChinese => 'Does not exist in Chinese';

  @override
  String get dontHaveAccountSignUp => 'Don\'t have an account? Sign up';

  @override
  String get draftingStoryOutline => 'Drafting story outline...';

  @override
  String get dynamicFlowState => 'Dynamic Flow State';

  @override
  String get dynamicFlowStateParenthetical => 'Dynamic (Flow State)';

  @override
  String get editCard => 'Edit Card';

  @override
  String get egAnimeVocab => 'E.g. Anime Vocab';

  @override
  String get egFormalBusinessLanguageSlangForTexting =>
      'e.g., Formal business language, slang for texting...';

  @override
  String get egOrderingAtARestaurantBusinessVocab =>
      'e.g., Ordering at a restaurant, Business vocab...';

  @override
  String get egWeddingReceptionTechInterview =>
      'e.g., Wedding Reception, Tech Interview...';

  @override
  String get emailLabel => 'Email';

  @override
  String get english => 'English';

  @override
  String get englishAndWorld => 'English & World';

  @override
  String get episodes => 'episodes';

  @override
  String get erase => 'Erase';

  @override
  String get eraseDeckQuestion => 'Erase Deck?';

  @override
  String errorFetchingTranslationForLabelE(String label, String e) {
    return 'Error fetching translation for $label: $e';
  }

  @override
  String errorLoadingMicroreadsE(String e) {
    return 'Error loading micro-reads: $e';
  }

  @override
  String errorLoadingNovelsE(String e) {
    return 'Error loading novels: $e';
  }

  @override
  String errorLoadingPoetryE(String e) {
    return 'Error loading poetry: $e';
  }

  @override
  String get exitFocus => 'Exit Focus';

  @override
  String get explore => 'Explore';

  @override
  String get exportToThisDeck => 'Export to this deck';

  @override
  String get extractAndSimplify => 'Extract & Simplify';

  @override
  String get failedToCreateDeck => 'Failed to create deck';

  @override
  String get failedToLoadDailyContent => 'Failed to load daily content';

  @override
  String get failedToLoadEpisodes => 'Failed to load episodes';

  @override
  String get failedToLoadShows => 'Failed to load shows';

  @override
  String get finalizingDetails => 'Finalizing details...';

  @override
  String get finalizingStoryDetails => 'Finalizing story details...';

  @override
  String get firebaseAuthConsole =>
      'Firebase Auth not enabled. Please enable the required Sign-In method in your Firebase Console.';

  @override
  String get flashcardDeckTitle => 'FLASHCARD DECK';

  @override
  String get focus => 'Focus';

  @override
  String get foodAndCooking => 'Food & Cooking';

  @override
  String get forward => 'Forward';

  @override
  String get freeFlow => 'Free Flow';

  @override
  String get frenchClassics => 'French Classics';

  @override
  String get full => 'Full';

  @override
  String get gamingAndEsports => 'Gaming & Esports';

  @override
  String get germanClassics => 'German Classics';

  @override
  String get ghostPinyin => 'Ghost Pinyin';

  @override
  String get goodAttempt => 'Good attempt';

  @override
  String get gotItSimple => 'Got it';

  @override
  String get grammar => 'Grammar';

  @override
  String get grandmaLiuFilling =>
      'Grandma Liu (刘奶奶), a doting northern grandmother who teaches you how to pinch dumpling pleats and make pork-scallion filling.';

  @override
  String get great => 'Great!';

  @override
  String get handmadeDumplingFeastInHarbin =>
      'Handmade Dumpling Feast in Harbin';

  @override
  String get hanziCharacter => 'Hanzi (Character)';

  @override
  String get hapticFeedback => 'Haptic Feedback';

  @override
  String get helpAndSupport => 'Help & Support';

  @override
  String get hidden => 'Hidden';

  @override
  String get hideEnglishTranslations => 'Hide English Translations';

  @override
  String get hidePinyin => 'Hide Pinyin';

  @override
  String get highlight => 'HIGHLIGHT';

  @override
  String get howWouldYouLikeToStudy => 'How would you like to study?';

  @override
  String get hsk1 => 'HSK 1';

  @override
  String get hsk4UpperIntermediate => 'HSK 4: Upper Int.';

  @override
  String get hsk5Advanced => 'HSK 5 (Advanced)';

  @override
  String get hsk6Mastery => 'HSK 6: Mastery';

  @override
  String get hskCollections => 'HSK Collections';

  @override
  String hskLevel(String level) {
    return 'HSK $level';
  }

  @override
  String get hskSimplifySubtitles => 'HSK Simplify Subtitles';

  @override
  String get hskVocabularyCollections => 'HSK vocabulary collections';

  @override
  String get i => 'I\\';

  @override
  String get ifTheAgain =>
      'If the transcript does not match what you said, select the phrase you intended and tap \'Yes, Re-Grade Me!\' to evaluate the original recording again without speaking a second time.';

  @override
  String get install => 'Install';

  @override
  String get just => 'Just \\\$';

  @override
  String get keyword => 'keyword';

  @override
  String get knowledgeBase => 'Knowledge Base';

  @override
  String get liRuzhenSubjects =>
      'Li Ruzhen (c. 1763–1830) was a Qing Dynasty scholar with deep interests in phonology, chess, and cosmology. Flowers in the Mirror, his fantastical novel of a merchant journeying through impossible kingdoms, is remarkable for its feminist themes and encyclopaedic range of subjects.';

  @override
  String get libraryLabel => 'Library';

  @override
  String get lifestyleAndVlog => 'Lifestyle & Vlog';

  @override
  String get listenInAudiobookMode => 'Listen in Audiobook Mode';

  @override
  String get listenToThisWord => 'Listen to this word';

  @override
  String get listening => 'Listening...';

  @override
  String get liuEEncroachment =>
      'Liu E (1857–1909) was a late-Qing polymath — engineer, doctor, and novelist — whose sole novel The Travels of Lao Can is a lyrical yet politically charged travelogue of a wandering healer navigating a China in the throes of dynastic collapse and foreign encroachment.';

  @override
  String get loadingTranslations => 'Loading translations...';

  @override
  String get luXunVernacular =>
      'Lu Xun (1881–1936), pen name of Zhou Shuren, is the father of modern Chinese literature. A physician who switched to writing to heal the Chinese spirit, his short story collections — Diary of a Madman and The True Story of Ah Q — used vernacular';

  @override
  String get luoGuanzhongEpic =>
      'Luo Guanzhong (c. 1330–1400) was a Yuan-to-Ming transition era playwright and novelist, believed to have studied under Shi Nai\'an. His Romance of the Three Kingdoms synthesised historical chronicles, oral tradition, and dramatic storytelling into the definitive Chinese historical epic.';

  @override
  String get makeACustomCollection => 'Make a custom collection';

  @override
  String get manageDailyDropsAndReviewReminders =>
      'Manage Daily Drops and Review Reminders';

  @override
  String get managerYuOptions =>
      'Manager Yu (余店长), a fiery hotpot restaurant manager who recommends signature tripe, duck blood, and mild broth options.';

  @override
  String get masterGaoRubs =>
      'Master Gao (高师傅), a charismatic charcoal BBQ master bantering with customers about spice levels and secret cumin rubs.';

  @override
  String get masterThisToUnlockItsGalaxy => 'Master this to unlock its galaxy.';

  @override
  String get masterZhaoBrewing =>
      'Master Zhao (赵师傅), a patient and knowledgeable tea sommelier who loves explaining Gongfu tea brewing.';

  @override
  String get mastery => 'Mastery';

  @override
  String get maybeLater => 'Maybe Later';

  @override
  String get memes => 'Memes';

  @override
  String get midnightBbqSkewersInWuhan => 'Midnight BBQ Skewers in Wuhan';

  @override
  String get mo => '/mo';

  @override
  String get modernChinese => 'Modern Chinese';

  @override
  String get monthly => 'Monthly';

  @override
  String get morningDimSumCartInGuangzhou =>
      'Morning Dim Sum Cart in Guangzhou';

  @override
  String get nameLabel => 'Name';

  @override
  String get native => 'Native';

  @override
  String get newCard => 'New Card';

  @override
  String get newDeck => 'New Deck';

  @override
  String get newDeckName => 'New Deck Name';

  @override
  String get noActiveSubscriptionFound => 'No active subscription found.';

  @override
  String get noEpisodesFound => 'No episodes found';

  @override
  String get noKeyWordsFoundForThisStory =>
      'No key words found for this story.';

  @override
  String get noLabel => 'No';

  @override
  String get noNewWordsFound => 'No new words found!';

  @override
  String get noPinyin => 'No Pinyin';

  @override
  String get noPremiumPackagesAvailable =>
      'No premium packages available at the moment.';

  @override
  String noResultsFoundForSearchquery(String searchQuery) {
    return 'No results found for \'$searchQuery\'';
  }

  @override
  String get noSavedArticlesYet => 'No saved articles yet.';

  @override
  String get noShowsAvailable => 'No shows available';

  @override
  String get noStoriesFound => 'No stories found.';

  @override
  String get noWordsSelected => 'No words selected';

  @override
  String get notes => 'Notes';

  @override
  String get notoserifsc => 'NotoSerifSC';

  @override
  String get objectivesTitle => 'OBJECTIVES';

  @override
  String get openInYoutube => 'Open in YouTube';

  @override
  String get orderingHanddripCoffeeInShanghai =>
      'Ordering Hand-Drip Coffee in Shanghai';

  @override
  String get orderingSugarcoatedHawsInWinterBeijing =>
      'Ordering Sugar-Coated Haws in Winter Beijing';

  @override
  String partnerLang(String lang) {
    return 'Partner ($lang)';
  }

  @override
  String get partnerListening => 'Partner listening...';

  @override
  String get partnerSpeaking => 'Partner speaking…';

  @override
  String get passwordLabel => 'Password';

  @override
  String get pause => 'Pause';

  @override
  String get perfect => 'Perfect!';

  @override
  String get personalizedPathBasedOnDeck =>
      'A personalized path based on your deck.';

  @override
  String get play => 'Play';

  @override
  String get pleaseEnterMessageBeforeSending =>
      'Please enter a message before sending.';

  @override
  String get practiceInRoleplay => 'Practice in Roleplay';

  @override
  String get practiceModes => 'Practice Modes';

  @override
  String get practicePronouncingWithAiGrading =>
      'Practice pronouncing this word with AI grading';

  @override
  String get preparingReadingInterface => 'Preparing reading interface...';

  @override
  String get privacy => 'Privacy';

  @override
  String get privacyAndAudio => 'Privacy & Audio';

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
      'Pu Songling (1640–1715) was a Qing Dynasty writer who spent decades compiling Strange Tales from a Chinese Studio after repeatedly failing the imperial examinations. His supernatural stories of fox spirits, ghosts, and scholars remain the gold standard of Chinese gothic literature.';

  @override
  String get qaFaq => 'Q&A / FAQ';

  @override
  String get questsTitle => 'QUESTS';

  @override
  String get quickBookmarks => 'Quick Bookmarks';

  @override
  String get radical => 'Radical';

  @override
  String get ready => 'Ready';

  @override
  String get readyToInterpret => 'Ready to interpret';

  @override
  String get readyToStart => 'Ready to start.';

  @override
  String get recentBookmarks => 'Recent Bookmarks';

  @override
  String get refiningGrammar => 'Refining grammar...';

  @override
  String get refresh => 'Refresh';

  @override
  String get removeFromSaved => 'Remove from Saved';

  @override
  String get removeFromSavedScenarios => 'Remove from saved scenarios';

  @override
  String get removed => 'Removed';

  @override
  String get requestPermissions => 'Request Permissions';

  @override
  String get rescind => 'Rescind';

  @override
  String get restore => 'Restore';

  @override
  String get results => 'Results';

  @override
  String get resume => 'Resume';

  @override
  String get retry => 'Retry';

  @override
  String get revenuecatError => 'RevenueCat Error:';

  @override
  String revenuecatErrorE(String e) {
    return 'RevenueCat Error: $e';
  }

  @override
  String get reviewExtractedDeck => 'Review Extracted Deck';

  @override
  String get reviewIn => 'Review in';

  @override
  String get reviewingYourTones => 'Reviewing your tones...';

  @override
  String get saveAll => 'Save All';

  @override
  String get saveScenario => 'Save Scenario';

  @override
  String get saveThisScenario => 'Save this scenario';

  @override
  String get saved => 'Saved';

  @override
  String get scanAnother => 'Scan Another';

  @override
  String get scenarioRemoved => 'Scenario removed';

  @override
  String get scenarioSavedFindInCustomTab =>
      'Scenario saved! Find it in the Custom tab.';

  @override
  String score(Object score, Object total) {
    return 'Score:';
  }

  @override
  String get searchByPinyinOrMeaning => 'Search by pinyin or meaning...';

  @override
  String get searchByTitleOrTag => 'Search by title or tag...';

  @override
  String get searchDictionaryOrTypeCustom => 'Search dictionary or type custom';

  @override
  String get searchHint => 'Search...';

  @override
  String get searchOrEnterUrl => 'Search or enter URL';

  @override
  String get searchScenariosHint => 'Search scenarios...';

  @override
  String get searchStoriesIdiomsNews => 'Search stories, idioms, news...';

  @override
  String get searchTopicsEgCookingHistory =>
      'Search topics (e.g., Cooking, History)';

  @override
  String get seeAll => 'See all';

  @override
  String get selectADeck => 'Select a Deck';

  @override
  String get selectPracticeMode => 'Select Practice Mode';

  @override
  String get selectingHskVocabulary => 'Selecting HSK vocabulary...';

  @override
  String get send => 'Send';

  @override
  String get sendMessage => 'Send Message';

  @override
  String get serif => 'Serif';

  @override
  String get shadow => 'Shadow';

  @override
  String get shiNaianEpic =>
      'Shi Nai\'an (c. 1296–1372) was a Yuan Dynasty literatus who reportedly passed the imperial examination yet chose the life of a reclusive scholar. Water Margin, his masterwork of heroic outlaws and righteous rebellion, established the archetype of the Chinese martial epic.';

  @override
  String get showEnglish => 'Show English';

  @override
  String get showEnglishTranslations => 'Show English Translations';

  @override
  String get showHanzi => 'Show Hanzi';

  @override
  String get showPinyin => 'Show Pinyin';

  @override
  String get showTranslation => 'Show Translation';

  @override
  String get shows => 'Shows';

  @override
  String get signIn => 'Sign In';

  @override
  String get simplifiedArticle => 'Simplified Article';

  @override
  String get simplifyingSubtitles => 'Simplifying subtitles...';

  @override
  String get sincereHonest => 'sincere; honest';

  @override
  String get sleepTimer => 'Sleep Timer';

  @override
  String get smartDeck => 'Smart Deck';

  @override
  String get spanishAndWorld => 'Spanish & World';

  @override
  String get speaker => 'Speaker';

  @override
  String get spotifyStylePlayer => 'Spotify-style Player';

  @override
  String get storyBookmarkedInLibrary => 'Story bookmarked in Library!';

  @override
  String get streetFoodNightMarketInXian =>
      'Street Food Night Market in Xi\'an';

  @override
  String get strokes => 'Strokes';

  @override
  String get studyCharacter => 'Study Character';

  @override
  String get subtitleOpacity => 'Subtitle Opacity';

  @override
  String get suggestion => 'Suggestion';

  @override
  String get summary => 'Summary';

  @override
  String get supernaturalAndFolklore => 'Supernatural & Folklore';

  @override
  String get swipeToGrade => 'Swipe to Grade:';

  @override
  String get tableOfContents => 'Table of Contents';

  @override
  String get tapToRetry => 'Tap to Retry';

  @override
  String get teaTastingInChengdu => 'Tea Tasting in Chengdu';

  @override
  String get techAndGadgets => 'Tech & Gadgets';

  @override
  String get terms => 'Terms';

  @override
  String get theGalaxyCharacters =>
      'The Galaxy Map awaits.\nMaster the Suns (Radicals) to unlock the Planets (Characters).';

  @override
  String get theme => 'Theme';

  @override
  String get thinking => 'Thinking...';

  @override
  String get thisArticleCharacters =>
      'This article contains Traditional Chinese characters.';

  @override
  String get todaysWord => 'TODAY\'S WORD';

  @override
  String get togglePinyin => 'Toggle Pinyin';

  @override
  String get toggleTranslation => 'Toggle Translation';

  @override
  String get toneDoesNotExistInMandarin =>
      'This tone does not exist in standard Mandarin.';

  @override
  String get toneGraph => 'Tone Graph';

  @override
  String get traceLabel => 'Trace';

  @override
  String get trailer => 'TRAILER';

  @override
  String get translatingAndAddingPinyin => 'Translating and adding Pinyin...';

  @override
  String get translatingText => 'Translating text...';

  @override
  String get turnOn => 'Turn On';

  @override
  String get typeHanziPinyinOrEnglish => 'Type Hanzi, Pinyin, or English...';

  @override
  String get unknown2 => '游戏 实况 王者荣耀 原神';

  @override
  String get unknown3 => '中国 美食 菜谱';

  @override
  String get unknown4 => '中国 科技 测评';

  @override
  String get unrollingTheScroll => 'Unrolling the scroll...';

  @override
  String get upperIntermediate => 'Upper Int.';

  @override
  String get vibrationsForInteractions => 'Vibrations for interactions';

  @override
  String get video => 'Video';

  @override
  String get viewAnswer => 'View Answer';

  @override
  String get viewAsList => 'View as List';

  @override
  String get viewBookmarks => 'View Bookmarks';

  @override
  String get viewMyDrawing => 'View My Drawing';

  @override
  String get vlog => '中国 日常 vlog';

  @override
  String get voice => 'Voice:';

  @override
  String get web => 'Web';

  @override
  String get wedLoveToHearFromYou => 'We\'d love to\nhear from you.';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get whatDoesThisMean => 'What does this mean?';

  @override
  String get whatHappensToMyChatHistory => 'What happens to my chat history?';

  @override
  String get whatIfAiMishears =>
      'What can I do if the AI misinterprets what I said?';

  @override
  String get whichCharacterIs => 'Which character is:';

  @override
  String get wikipedia => 'Wikipedia';

  @override
  String get wordsSavedAndSrsScheduled => 'Words saved and SRS scheduled!';

  @override
  String get writeYourMessageHere => 'Write your message here...';

  @override
  String get wuChengenLiterature =>
      'Wu Cheng\'en (c. 1500–1582) was a Ming Dynasty novelist from Huai\'an, Jiangsu. Drawing on decades of folklore, Buddhist allegory, and satirical wit, he wove the mythology of the Tang pilgrimage into Journey to the West — one of the most inventive and beloved works in world literature.';

  @override
  String get wuJingziClass =>
      'Wu Jingzi (1701–1754) was a Qing Dynasty novelist from Anhui who abandoned his inherited fortune and spent his life writing The Scholars — a biting satirical novel exposing the vanity, corruption, and absurdity of the imperial examination system and the scholar-gentry class.';

  @override
  String get xuZhonglinWarfare =>
      'Xu Zhonglin (fl. 16th–17th century) was a Ming Dynasty author credited with compiling Investiture of the Gods (封神演义), a monumental work of mythological fiction blending Shang-Zhou history with Daoist cosmology, celestial bureaucracy, and heroic warfare.';

  @override
  String get yearly => 'Yearly';

  @override
  String get yesReGradeMe => 'Yes, Re-Grade Me!';

  @override
  String you(Object lang) {
    return 'You';
  }

  @override
  String get youAreSpeaking => 'You are speaking';

  @override
  String get youLabel => 'You';

  @override
  String youLang(String lang) {
    return 'You ($lang)';
  }

  @override
  String get youMustAccount =>
      'You must accept the Terms of Service and Privacy Policy to create an account.';

  @override
  String get yourEchoModels =>
      'Your saved Roleplay conversation history stays locally on your device so you can review it later. We do not use your personal conversations to train our AI models.';

  @override
  String get zhOnly => 'ZH Only';

  @override
  String get hsk_1300_cards => '1300 cards';

  @override
  String get hsk_154_cards => '154 cards';

  @override
  String get hsk_162_cards => '162 cards';

  @override
  String get hsk_2500_cards => '2500 cards';

  @override
  String get hsk_299_cards => '299 cards';

  @override
  String get hsk_602_cards => '602 cards';

  @override
  String get added_to_review_queue => 'Added  to Review Queue';

  @override
  String added_cards_to(int cardCount, String deckName) {
    return 'Added $cardCount cards to \"$deckName\".';
  }

  @override
  String added_to_your_library(Object hanzi) {
    return 'Added \'\' to your Library';
  }

  @override
  String get advanced => 'Advanced';

  @override
  String get ai_stories => 'AI Stories';

  @override
  String analysis_failed(Object error) {
    return 'Analysis Failed: $error';
  }

  @override
  String get analyzing_pronunciation_with_gemini_ai =>
      'Analyzing pronunciation with Gemini AI...';

  @override
  String get analyzing_your_pronunciation => 'Analyzing your pronunciation...';

  @override
  String are_you_sure_you_want_to(String deckName) {
    return 'Are you sure you want to permanently erase \"$deckName\"? This action cannot be undone and will delete all cards inside it.';
  }

  @override
  String ask_about(String hanzi) {
    return 'Ask about $hanzi...';
  }

  @override
  String get audio_haptics => 'Audio & Haptics';

  @override
  String get audio_could_not_start_check_your =>
      'Audio could not start. Check your connection and device voice settings.';

  @override
  String get calligraphy_trace => 'Calligraphy Trace';

  @override
  String chapters(Object count) {
    return 'Chapters)';
  }

  @override
  String get char => 'char';

  @override
  String get chinese_character => 'CHINESE CHARACTER';

  @override
  String get contact_us_and_report_issues => 'Contact us and report issues';

  @override
  String created_smart_deck_with_words(String deckName, int wordCount) {
    return 'Created smart deck: \"$deckName\" with $wordCount words!';
  }

  @override
  String get custom_ai_generated_story => 'Custom AI generated story.';

  @override
  String get display_content => 'Display & Content';

  @override
  String get do_you_keep_or_store_my =>
      'Do you keep or store my voice recordings?';

  @override
  String get elementary => 'Elementary';

  @override
  String error_creating_scenario(Object error) {
    return 'Error creating scenario: $error';
  }

  @override
  String error_fetching_translation_for(Object error) {
    return 'Error fetching translation for : $error';
  }

  @override
  String error_loading_chapters(Object error) {
    return 'Error loading chapters: $error';
  }

  @override
  String get error_loading_decks => 'Error loading decks';

  @override
  String error_loading_microreads(Object error) {
    return 'Error loading micro-reads: $error';
  }

  @override
  String error_loading_novels(Object error) {
    return 'Error loading novels: $error';
  }

  @override
  String error_loading_poetry(Object error) {
    return 'Error loading poetry: $error';
  }

  @override
  String get etymology => 'Etymology: ';

  @override
  String get explanation => 'explanation';

  @override
  String get extracted_text_tap_to_lookup => 'Extracted Text (Tap to lookup)';

  @override
  String extraction_failed(Object error) {
    return 'Extraction Failed: \\$error';
  }

  @override
  String get failed_to_download => 'Failed to download.';

  @override
  String failed_to_generate_scenario(Object error) {
    return 'Failed to generate scenario: $error';
  }

  @override
  String failed_to_generate_story(Object error) {
    return 'Failed to generate story:\\n$error';
  }

  @override
  String failed_to_load_context(Object error) {
    return 'Failed to load context: ${error}rr';
  }

  @override
  String get feature_request => 'Feature Request';

  @override
  String get foundation => 'Foundation';

  @override
  String get how_is_my_pronunciation_scored =>
      'How is my pronunciation scored?';

  @override
  String hsk(Object level) {
    return 'HSK ';
  }

  @override
  String hsk_vocabulary(int hskLevel) {
    return 'HSK $hskLevel vocabulary';
  }

  @override
  String get hsk_level => 'HSK LEVEL';

  @override
  String get intermediate => 'Intermediate';

  @override
  String get learning_stats => 'Learning Stats';

  @override
  String get mandarin => 'Mandarin';

  @override
  String get meaning => 'meaning';

  @override
  String get no_decks_found => 'No decks found.';

  @override
  String no_results_found_for(Object searchQuery) {
    return 'No results found for \'\'';
  }

  @override
  String get no_when_you_use_echo_hall =>
      'Recordings submitted for pronunciation assessment are processed securely and are not kept by SinoSpark after processing is complete. Roleplay history you choose to save may remain on your device and can be deleted in the app.';

  @override
  String get notification_settings => 'Notification Settings';

  @override
  String get open_settings => 'Open Settings';

  @override
  String get phoneme => 'phoneme';

  @override
  String get play_reference_pronunciation => 'Play Reference Pronunciation';

  @override
  String get please_select_a_deck_to_add =>
      'Please select a deck to add cards to.';

  @override
  String get point_at_chinese_text_to_translate =>
      'Point at Chinese text to translate';

  @override
  String get practice_writing_the_strokes_by_hand =>
      'Practice writing the strokes by hand';

  @override
  String get preferences_audio_and_display => 'Preferences, Audio, and Display';

  @override
  String get preparing_your_scholars_verdict =>
      'Preparing your Scholar\'s Verdict...';

  @override
  String get previous => 'Previous';

  @override
  String question(Object current, Object total) {
    return 'Question';
  }

  @override
  String remove_from_this_deck(String hanzi) {
    return 'Remove $hanzi from this deck?';
  }

  @override
  String revenuecat_error(Object error) {
    return 'RevenueCat Error: $error';
  }

  @override
  String get review_tomorrow => 'Review Tomorrow';

  @override
  String get roleplay => 'Roleplay';

  @override
  String saving_words_to(int wordCount, String deckName) {
    return 'Saving $wordCount words to $deckName...';
  }

  @override
  String get search_radicals_eg_water => 'Search radicals (e.g. Water, 氵)';

  @override
  String get select_target_hsk_level => 'Select Target HSK Level';

  @override
  String get sentence => 'Sentence';

  @override
  String get shadowing_studio_is_a_dedicated_space =>
      'Shadowing Studio is a dedicated space to practice mimicking native';

  @override
  String simplify_failed(Object error) {
    return 'Simplify Failed: $error';
  }

  @override
  String get sinospark_premium => 'SinoSpark Premium';

  @override
  String get speaking_pronunciation => 'Speaking & Pronunciation';

  @override
  String get statistics => 'Statistics';

  @override
  String get table_of_contents => 'Table of Contents · 目录 (';

  @override
  String get the_ai_evaluates_your_speech_across =>
      'The AI evaluates your speech across three dimensions:\n• Accuracy: Did you articulate the correct syllables?\n• Completeness: Did you skip or miss any words?\n• Fluency: Did you pause naturally and use the correct tones?\nIt compares your audio against native models to generate a score out of 100.';

  @override
  String get this_cannot_be_undone => 'This cannot be undone.';

  @override
  String get title => 'title';

  @override
  String get to_be_reviewed => 'To Be Reviewed';

  @override
  String get traditional => 'Traditional';

  @override
  String translation_failed(Object error) {
    return 'Translation Failed: $error';
  }

  @override
  String get type_in => 'Type in ...';

  @override
  String get type_your_message_in => 'Type your message in ...';

  @override
  String get unable_to_open_this_video_please =>
      'Unable to open this video. Please try again later.';

  @override
  String get view_your_learning_history_and_streaks =>
      'View your learning history and streaks';

  @override
  String get what_is_shadowing_studio => 'What is Shadowing Studio?';

  @override
  String get words => 'words';

  @override
  String your_path_for_is_ready(String deckName) {
    return 'Your path for \'$deckName\' is ready!';
  }

  @override
  String get you_said => '🗣️ You Said';

  @override
  String vocabularyBatch(Object index) {
    return 'Vocabulary Batch (index)';
  }

  @override
  String get yourDailyDropIsHere => 'Your Daily Drop is here! ✨';

  @override
  String get timeToReview => 'Time to Review! 📚';

  @override
  String get neverMissAStroke => 'Never miss a stroke! 🖌️';

  @override
  String get yourTrialEndsTomorrow => 'Your trial ends tomorrow! ⏳';

  @override
  String get officialStandardVocabularyTiers =>
      'Official standard vocabulary tiers';

  @override
  String get failedToLoadCollections => 'Failed to load collections.';

  @override
  String unnamedKey(Object tag) {
    return '#(tag)';
  }

  @override
  String error(Object error) {
    return 'Error: $error';
  }

  @override
  String get aiSmartContext => 'AI Smart Context';

  @override
  String get aiSmartContextError => 'AI Smart Context Error';

  @override
  String get downloadOfficialHskCollections =>
      'Download official HSK collections';

  @override
  String get unableToLoadThisSection =>
      'Unable to load this section. Please try again.';

  @override
  String get translationLanguage => 'Translation Language';

  @override
  String get dailyDrops => 'Daily Drops';

  @override
  String get wordOfTheDayNews => 'Word of the Day & news';

  @override
  String get reviewReminders => 'Review Reminders';

  @override
  String get flashcardsDueForReview => 'Flashcards due for review';

  @override
  String get dailyNewCards => 'Daily New Cards';

  @override
  String get dailyReviewLimit => 'Daily Review Limit';

  @override
  String get practiceMode => 'Practice Mode';

  @override
  String get liziqi => '李子柒 Liziqi: 绢花';

  @override
  String get theLifeOfGarlicTraditional =>
      'The Life of Garlic - Traditional Chinese Life';

  @override
  String get graceMandarin50Phrases => 'Grace Mandarin: 50 Phrases';

  @override
  String get essentialChinesePhrasesForBeginners =>
      'Essential Chinese Phrases for Beginners';

  @override
  String get makingBambooFurniture => 'Making Bamboo Furniture';

  @override
  String get peppaPigChinese => 'Peppa Pig Chinese: 躲猫猫';

  @override
  String get muddyPuddlesBeginnerFriendly =>
      'Muddy Puddles - Beginner Friendly';

  @override
  String get mandarinCorner300Verbs => 'Mandarin Corner: 300 Verbs';

  @override
  String get mostCommonChineseVerbs => 'Most Common Chinese Verbs';

  @override
  String get graceMandarinOrderFood => 'Grace Mandarin: Order Food';

  @override
  String get howToOrderFoodIn => 'How to order food in a Chinese restaurant';

  @override
  String get silkFlowersTraditionalCraft => 'Silk Flowers - Traditional Craft';

  @override
  String get mandarinCorner => 'Mandarin Corner: 学中文 看病';

  @override
  String get goingToTheDoctorReal =>
      'Going to the Doctor - Real Life Conversation';

  @override
  String get hideAndSeekBeginnerFriendly => 'Hide and Seek - Beginner Friendly';

  @override
  String get linGdp6 => '小Lin说: 为什么GDP增长6%';

  @override
  String get why6GdpGrowthEasy => 'Why 6% GDP Growth - Easy Chinese Economics';

  @override
  String get bbcWorldNews => 'BBC 中文 (World News)';

  @override
  String get currentEventsInSimplifiedChinese =>
      'Current Events in Simplified Chinese';

  @override
  String get baidu => 'Baidu';

  @override
  String get youtubeDesk => 'YOUTUBE DESK';

  @override
  String get interactiveTranscriptsShadowing =>
      'Interactive transcripts & shadowing';

  @override
  String get showsDramas => 'SHOWS & DRAMAS';

  @override
  String get extractToDeck => 'Extract to Deck';

  @override
  String get autoSimplify => 'Auto-Simplify';

  @override
  String get rewriteThisArticleToMatch =>
      'Rewrite this article to match your HSK level';

  @override
  String failedToSaveExtractedWords(Object error) {
    return 'Failed to save extracted words: $error';
  }

  @override
  String addToDeck(Object count) {
    return 'Add to Deck $count';
  }

  @override
  String get dailyDiscoveryDrop => 'Daily Discovery Drop';

  @override
  String get smartSpacedRepetition => 'Smart Spaced Repetition';

  @override
  String get trialProtectionAlert => 'Trial Protection Alert';

  @override
  String get masteryLevel => 'Mastery Level';

  @override
  String get targetObjective => 'Target Objective';

  @override
  String get dailyPractice => 'Daily Practice';

  @override
  String get aiSpacedRepetition => 'AI Spaced Repetition';

  @override
  String get iVeGrantedAccess => 'I\'ve granted access';

  @override
  String get scanner => 'Scanner';

  @override
  String get interpreter => 'Interpreter';

  @override
  String cards(Object count) {
    return '$count cards';
  }

  @override
  String get nWaMendsTheHeavens => 'Nüwa Mends the Heavens';

  @override
  String get terracottaArmy => 'Terracotta Army';

  @override
  String get forbiddenCity => 'Forbidden City';

  @override
  String get aBlessingInDisguise => 'A Blessing in Disguise';

  @override
  String get drawingASnake => 'Drawing a Snake';

  @override
  String get takingTheBulletTrain => 'Taking the Bullet Train';

  @override
  String get visitingTheDoctor => 'Visiting the Doctor';

  @override
  String get orderingDumplings => 'Ordering Dumplings';

  @override
  String get theTeaCeremony => 'The Tea Ceremony';

  @override
  String get chineseCalligraphy => 'Chinese Calligraphy';

  @override
  String get theGiantPanda => 'The Giant Panda';

  @override
  String get simplifiedText => 'Simplified Text';

  @override
  String get novels96 => 'Novels (96)';

  @override
  String get microReads => 'Micro-Reads';

  @override
  String get poetry => 'Poetry';

  @override
  String get bookmarkRemoved => '书签已移除 · Bookmark removed';

  @override
  String bookmarkAdded(Object chapter) {
    return '已添加书签 · Bookmark added: 第(chapter)回';
  }

  @override
  String get readingVocabulary => 'Reading & Vocabulary';

  @override
  String vocabularyBatchUnitindex1(Object index) {
    return 'Vocabulary Batch \$(unitIndex + 1)';
  }

  @override
  String get yourDailyDropIsHere1 => 'Your Daily Drop is here! ✨';

  @override
  String get timeToReview1 => 'Time to Review! 📚';

  @override
  String get neverMissAStroke1 => 'Never miss a stroke! 🖌️';

  @override
  String get yourTrialEndsTomorrow1 => 'Your trial ends tomorrow! ⏳';

  @override
  String get hskCollections1 => 'HSK Collections';

  @override
  String get officialStandardVocabularyTiers1 =>
      'Official standard vocabulary tiers';

  @override
  String get failedToLoadCollections1 => 'Failed to load collections.';

  @override
  String ui__transcription(Object transcription) {
    return '\"\$_transcription\"';
  }

  @override
  String playPinyinwithtone(Object pinyinWithTone) {
    return 'Play \$pinyinWithTone';
  }

  @override
  String errorE(Object e) {
    return 'Error: \$e';
  }

  @override
  String lookalikepinyin(Object pinyin) {
    return '(\$(lookAlike.pinyin))';
  }

  @override
  String get aiSmartContext1 => 'AI Smart Context';

  @override
  String get aiSmartContextError1 => 'AI Smart Context Error';

  @override
  String errorErr(Object err, Object error) {
    return 'Error: \$err';
  }

  @override
  String get downloadOfficialHskCollections1 =>
      'Download official HSK collections';

  @override
  String get unableToLoadThisSectionPleaseTryAga =>
      'Unable to load this section. Please try again.';

  @override
  String get searchRadicalsEgWater => 'Search radicals (e.g. Water, 氵)';

  @override
  String ui__currentstrokeindex1totalstrokes(Object current, Object total) {
    return '\$(_currentStrokeIndex + 1)/\$totalStrokes';
  }

  @override
  String get translationLanguage1 => 'Translation Language';

  @override
  String get appLanguage1 => 'App Language';

  @override
  String get dailyDrops1 => 'Daily Drops';

  @override
  String get wordOfTheDayNews1 => 'Word of the Day & news';

  @override
  String get reviewReminders1 => 'Review Reminders';

  @override
  String get flashcardsDueForReview1 => 'Flashcards due for review';

  @override
  String get accuracyByMode1 => 'Accuracy by Mode';

  @override
  String accuracytostringasfixed1(Object accuracy) {
    return '\$(accuracy.toStringAsFixed(1))%';
  }

  @override
  String get upcomingReviewsNext7Days => 'Upcoming Reviews (Next 7 Days)';

  @override
  String get explaining => 'Explaining:';

  @override
  String entryhanziEntrypinyin(Object hanzi, Object pinyin) {
    return '\$(entry.hanzi) [\$(entry.pinyin)]';
  }

  @override
  String get dailyNewCards1 => 'Daily New Cards';

  @override
  String get dailyReviewLimit1 => 'Daily Review Limit';

  @override
  String get listeningMode1 => 'Listening Mode';

  @override
  String get readingMode1 => 'Reading Mode';

  @override
  String get recallMode1 => 'Recall Mode';

  @override
  String get speakingMode1 => 'Speaking Mode';

  @override
  String get practiceMode1 => 'Practice Mode';

  @override
  String acc(Object acc) {
    return '\$acc%';
  }

  @override
  String get partner1 => 'Partner';

  @override
  String get partnerSpeaking1 => 'Partner speaking…';

  @override
  String get theLifeOfGarlicTraditionalChineseLi =>
      'The Life of Garlic - Traditional Chinese Life';

  @override
  String get graceMandarin50Phrases1 => 'Grace Mandarin: 50 Phrases';

  @override
  String get essentialChinesePhrasesForBeginners1 =>
      'Essential Chinese Phrases for Beginners';

  @override
  String get makingBambooFurniture1 => 'Making Bamboo Furniture';

  @override
  String get muddyPuddlesBeginnerFriendly1 =>
      'Muddy Puddles - Beginner Friendly';

  @override
  String get mandarinCorner300Verbs1 => 'Mandarin Corner: 300 Verbs';

  @override
  String get mostCommonChineseVerbs1 => 'Most Common Chinese Verbs';

  @override
  String get graceMandarinOrderFood1 => 'Grace Mandarin: Order Food';

  @override
  String get howToOrderFoodInAChineseRestaurant =>
      'How to order food in a Chinese restaurant';

  @override
  String get silkFlowersTraditionalCraft1 => 'Silk Flowers - Traditional Craft';

  @override
  String get goingToTheDoctorRealLifeConversatio =>
      'Going to the Doctor - Real Life Conversation';

  @override
  String get hideAndSeekBeginnerFriendly1 =>
      'Hide and Seek - Beginner Friendly';

  @override
  String get lingdp6 => '小Lin说: 为什么GDP增长6%';

  @override
  String get why6GdpGrowthEasyChineseEconomics =>
      'Why 6% GDP Growth - Easy Chinese Economics';

  @override
  String get currentEventsInSimplifiedChinese1 =>
      'Current Events in Simplified Chinese';

  @override
  String get baidu1 => 'Baidu';

  @override
  String get youtubeDesk1 => 'YOUTUBE DESK';

  @override
  String get interactiveTranscriptsShadowing1 =>
      'Interactive transcripts & shadowing';

  @override
  String get showsDramas1 => 'SHOWS & DRAMAS';

  @override
  String error_error(Object error) {
    return 'Error: \$_error';
  }

  @override
  String get extractToDeck1 => 'Extract to Deck';

  @override
  String get autosimplify => 'Auto-Simplify';

  @override
  String get rewriteThisArticleToMatchYourHskLev =>
      'Rewrite this article to match your HSK level';

  @override
  String get addToDeck1 => 'Add to Deck';

  @override
  String playbackratex(Object playbackRate) {
    return '\$(playbackRate)x';
  }

  @override
  String speedx(Object speed) {
    return '\$(speed)x';
  }

  @override
  String get dailyDiscoveryDrop1 => 'Daily Discovery Drop';

  @override
  String get smartSpacedRepetition1 => 'Smart Spaced Repetition';

  @override
  String get trialProtectionAlert1 => 'Trial Protection Alert';

  @override
  String get masteryLevel1 => 'Mastery Level';

  @override
  String get targetObjective1 => 'Target Objective';

  @override
  String get dailyPractice1 => 'Daily Practice';

  @override
  String get aiSpacedRepetition1 => 'AI Spaced Repetition';

  @override
  String get iveGrantedAccess => 'I\'ve granted access';

  @override
  String addToDeck_selectedwordindiceslength(Object count) {
    return 'Add to Deck (\$(_selectedWordIndices.length))';
  }

  @override
  String get scanner1 => 'Scanner';

  @override
  String get interpreter1 => 'Interpreter';

  @override
  String entryvalueCards(Object count) {
    return '\$(entry.value) cards';
  }

  @override
  String score_score_questionslength(Object score, Object total) {
    return 'Score: \$_score / \$(_questions.length)';
  }

  @override
  String get theMonkeyKing1 => 'The Monkey King';

  @override
  String get huaMulan1 => 'Hua Mulan';

  @override
  String get nwaMendsTheHeavens => 'Nüwa Mends the Heavens';

  @override
  String get confucius => 'Confucius';

  @override
  String get theGreatWall1 => 'The Great Wall';

  @override
  String get terracottaArmy1 => 'Terracotta Army';

  @override
  String get forbiddenCity1 => 'Forbidden City';

  @override
  String get aBlessingInDisguise1 => 'A Blessing in Disguise';

  @override
  String get drawingASnake1 => 'Drawing a Snake';

  @override
  String get takingTheBulletTrain1 => 'Taking the Bullet Train';

  @override
  String get visitingTheDoctor1 => 'Visiting the Doctor';

  @override
  String get orderingDumplings1 => 'Ordering Dumplings';

  @override
  String get theTeaCeremony1 => 'The Tea Ceremony';

  @override
  String get chineseCalligraphy1 => 'Chinese Calligraphy';

  @override
  String get theGiantPanda1 => 'The Giant Panda';

  @override
  String get simplifiedText1 => 'Simplified Text';

  @override
  String get novels961 => 'Novels (96)';

  @override
  String get microreads => 'Micro-Reads';

  @override
  String get poetry1 => 'Poetry';

  @override
  String get readingVocabulary1 => 'Reading & Vocabulary';

  @override
  String get defaultfirebaseoptionsHaveNotBeenCo =>
      'DefaultFirebaseOptions have not been configured for linux -';

  @override
  String get defaultfirebaseoptionsAreNotSupport =>
      'DefaultFirebaseOptions are not supported for this platform.';

  @override
  String get hanziMaster1 => 'Hanzi Master';

  @override
  String get strokesCannotBeEmpty => 'Strokes cannot be empty.';

  @override
  String get wrongStartPoint => 'Wrong start point.';

  @override
  String get rightShapeButWrongPlace => 'Right shape, but wrong place!';

  @override
  String get goodFollowTheFlow => 'Good!\') : \'Follow the flow.';

  @override
  String get aBitShaky => 'A bit shaky!';

  @override
  String get aBitHesitant => 'A bit hesitant...';

  @override
  String get shapeIsOff => 'Shape is off.';

  @override
  String get arabic => 'Arabic';

  @override
  String get german => 'German';

  @override
  String get spanish => 'Spanish';

  @override
  String get french => 'French';

  @override
  String get hindi => 'Hindi';

  @override
  String get indonesian => 'Indonesian';

  @override
  String get italian => 'Italian';

  @override
  String get japanese => 'Japanese';

  @override
  String get korean => 'Korean';

  @override
  String get portuguese => 'Portuguese';

  @override
  String get russian => 'Russian';

  @override
  String get vietnamese => 'Vietnamese';

  @override
  String get microphonePermissionDenied => 'Microphone permission denied';

  @override
  String get offset => 'Offset';

  @override
  String get audioserviceHasBeenDisposed => 'AudioService has been disposed';

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
  String get anchorWord => 'Anchor Word';

  @override
  String get creativeThematicTitle => 'Creative Thematic Title';

  @override
  String get briefPedagogicalOrSemanticRationale =>
      'Brief pedagogical or semantic rationale';

  @override
  String get theSingleMostCentralCharacterFromTh =>
      'The single most central character from the list';

  @override
  String get aBalancedSetOfCharactersFromYourLib =>
      'A balanced set of characters from your library.';

  @override
  String get yourNaturalConversationalReplyInChi =>
      'Your natural conversational reply in Chinese characters.';

  @override
  String get theEnglishTranslationOfYourReply =>
      'The English translation of your reply.';

  @override
  String get thePinyinWithToneMarksForYourReply =>
      'The Pinyin with tone marks for your reply.';

  @override
  String get aSuggestedResponseTheUserCouldSayBa =>
      'A suggested response the user could say back to you.';

  @override
  String get pinyinForTheSuggestion => 'Pinyin for the suggestion.';

  @override
  String get englishTranslationForTheSuggestion =>
      'English translation for the suggestion.';

  @override
  String get scholarsCritique => 'Scholar\'s Critique';

  @override
  String get theEchoHallRemainsSilentTryYourBrea =>
      'The Echo Hall remains silent. Try your breath again.';

  @override
  String get xtitleHanziMaster => 'X-Title\': \'Hanzi Master';

  @override
  String get noneYet => 'None yet.';

  @override
  String get exactSentence => 'Exact Sentence:';

  @override
  String get englishTranslation => 'English translation';

  @override
  String get previouslyGeneratedPhrases => 'Previously generated phrases';

  @override
  String get iLikeDrinkingAppleJuice => 'I like drinking apple juice.';

  @override
  String get theEnglishMeaningHere => 'The English meaning here...';

  @override
  String get failedToFetchDefinition => 'Failed to fetch definition.';

  @override
  String get failedToLoadExplanation => 'Failed to load explanation.';

  @override
  String get failedToLoadComparison => 'Failed to load comparison.';

  @override
  String get emptyResponseFromOpenrouter => 'Empty response from OpenRouter';

  @override
  String get emptyResponseFromVisionModel => 'Empty response from Vision model';

  @override
  String get standard => 'Standard';

  @override
  String get theFullSentenceInChinese => 'The full sentence in Chinese...';

  @override
  String get theWordOrCharacterInChinese => 'The word or character in Chinese';

  @override
  String get thePinyinForThisSpecificWord =>
      'The pinyin for this specific word';

  @override
  String get emptyResponseFromDeepseekApi => 'Empty response from DeepSeek API';

  @override
  String get criticalPutTheEnglishTranslationInT =>
      'CRITICAL: Put the English translation in the';

  @override
  String get englishTranslationOfTheEntireSenten =>
      'English translation of the entire sentence';

  @override
  String get hanziWord => 'Hanzi word';

  @override
  String get theFullSimplifiedSentenceInChinese =>
      'The full simplified sentence in Chinese...';

  @override
  String get lyingFlatACulturalMovement => 'Lying flat: A cultural movement...';

  @override
  String get theUserYouAreSpeakingToIsNamed =>
      'The user you are speaking to is named';

  @override
  String get importantRuleDoNotAddressTheUserByA =>
      'IMPORTANT RULE: Do not address the user by any name. Never use placeholder names like';

  @override
  String get youAreAConciseChineseCalligraphyAnd =>
      'You are a concise Chinese Calligraphy and Etymology tutor inside a mobile flashcard app.';

  @override
  String get theStudentIsStudyingTheCharacter =>
      'The student is studying the character';

  @override
  String get neverWriteIntroductionsSignoffsOrFi =>
      'Never write introductions, sign-offs, or filler phrases like';

  @override
  String get beDirectAndInformative => 'Be direct and informative.';

  @override
  String get criticalRuleYouMustRespondEntirelyI =>
      'CRITICAL RULE: You must respond ENTIRELY in the language corresponding to ISO 639-1 code';

  @override
  String get youAreAConciseChineseGrammarTutorIn =>
      'You are a concise Chinese Grammar tutor inside a mobile app.';

  @override
  String get theStudentIsConfusedAboutTheWord =>
      'The student is confused about the word';

  @override
  String get neverWriteIntroductionsSignoffsOrFi1 =>
      'Never write introductions, sign-offs, or filler phrases.';

  @override
  String get azureSpeechApiKeysAreMissing =>
      'Azure Speech API keys are missing.';

  @override
  String get success => 'Success';

  @override
  String get granularity => 'Granularity';

  @override
  String get phoneme1 => 'Phoneme';

  @override
  String get dimension => 'Dimension';

  @override
  String get comprehensive => 'Comprehensive';

  @override
  String get weCouldntHearYouClearlyPleaseTryAga =>
      'We couldn\'t hear you clearly. Please try again.';

  @override
  String get noNbestResultFound => 'No NBest result found.';

  @override
  String get words1 => 'Words';

  @override
  String get word => 'Word';

  @override
  String get phonemes => 'Phonemes';

  @override
  String get syllables => 'Syllables';

  @override
  String get syllable => 'Syllable';

  @override
  String get omission => 'Omission';

  @override
  String get insertion => 'Insertion';

  @override
  String get youMissedThisWord => 'You missed this word.';

  @override
  String get extraWordAddedHere => 'Extra word added here.';

  @override
  String get mispronunciation => 'Mispronunciation';

  @override
  String get pronunciationWasInaccurate => 'Pronunciation was inaccurate.';

  @override
  String get goodEffortKeepPracticing => 'Good effort! Keep practicing.';

  @override
  String get perfectPronunciationSoundsLikeANati =>
      'Perfect pronunciation! Sounds like a native speaker.';

  @override
  String get greatJobAFewMinorToneInaccuracies =>
      'Great job! A few minor tone inaccuracies.';

  @override
  String get notBadButYourTonesNeedSomeWork =>
      'Not bad, but your tones need some work.';

  @override
  String get keepPracticingListenToTheNativeAudi =>
      'Keep practicing! Listen to the native audio and try again.';

  @override
  String get lexical => 'Lexical';

  @override
  String get chineseHanziHere => 'Chinese Hanzi here';

  @override
  String get aShortSummaryInEnglish => 'A short summary in English';

  @override
  String get noCoherentChineseTextFoundInTheScan =>
      'No coherent Chinese text found in the scan.';

  @override
  String get theFullEnglishTranslationOfTheScann =>
      'The full English translation of the scanned text... OR \'No coherent Chinese text found.\'';

  @override
  String get aShort24WordTitleForThisScanEgResta =>
      'A short 2-4 word title for this scan (e.g. \'Restaurant Menu\', \'Street Sign\')';

  @override
  String get china => 'China';

  @override
  String get noTranslationAvailable => 'No translation available.';

  @override
  String get scanResults => 'Scan Results';

  @override
  String get whenWasItWrittenAndWhatWasHappening =>
      'When was it written and what was happening in China at the time?';

  @override
  String get whyIsThisPieceFamousWhatPhilosophic =>
      'Why is this piece famous? What philosophical or cultural themes does it explore?';

  @override
  String get aBriefBioOfTheAuthor => 'A brief bio of the author.';

  @override
  String get informationUnavailable => 'Information unavailable.';

  @override
  String get noSummaryAvailable => 'No summary available.';

  @override
  String get hanziAiPro => 'Hanzi AI Pro';

  @override
  String get trialNormalIntro => 'TRIAL\', \'NORMAL\', \'INTRO';

  @override
  String get dailyDrop => 'Daily Drop';

  @override
  String get dailyNotificationsForWordOfTheDayAn =>
      'Daily notifications for Word of the Day and news';

  @override
  String get aNewWordAndStoryOfTheDayAreWaitingF =>
      'A new Word and Story of the Day are waiting for you!';

  @override
  String get spacedRepetition => 'Spaced Repetition';

  @override
  String get remindersForFlashcardsDueForReview =>
      'Reminders for flashcards due for review';

  @override
  String get engagementReminders => 'Engagement Reminders';

  @override
  String get trialReminders => 'Trial Reminders';

  @override
  String get notificationsForYourTrialStatus =>
      'Notifications for your trial status';

  @override
  String get comeReviewYourHanziAndTryALiveCallB =>
      'Come review your Hanzi and try a Live Call before your free access ends!';

  @override
  String get scholarsEye => 'Scholar\'s Eye';

  @override
  String get clMeasureWord => 'CL:\', \'Measure word:';

  @override
  String get surnameShi => 'Surname Shi';

  @override
  String get chineseFamilyNameShi => 'Chinese family name (Shi)';

  @override
  String get neutralToneLight => 'Neutral Tone (Light)';

  @override
  String get keepYourPitchHighAndSteadyLikeSingi =>
      'Keep your pitch high and steady like singing a note.';

  @override
  String get startInTheMiddleAndSlideYourPitchUp =>
      'Start in the middle and slide your pitch upward like asking \'What?\'';

  @override
  String get dipYourVoiceDownLowThenRiseGentlyBa =>
      'Dip your voice down low, then rise gently back up.';

  @override
  String get dropYourPitchSharplyAndDecisivelyLi =>
      'Drop your pitch sharply and decisively like a firm \'No!\'';

  @override
  String get pronounceSoftlyBrieflyAndWithoutEmp =>
      'Pronounce softly, briefly, and without emphasis.';

  @override
  String get spotOnPitchWasHighFlatAndSteady =>
      'Spot on! Pitch was high, flat, and steady.';

  @override
  String get spotOnUpwardPitchRiseWasClear =>
      'Spot on! Upward pitch rise was clear.';

  @override
  String get spotOnLowDippingCurveWasAccurate =>
      'Spot on! Low dipping curve was accurate.';

  @override
  String get spotOnSharpFallingDropWasDecisive =>
      'Spot on! Sharp falling drop was decisive.';

  @override
  String get spotOnToneWasPronouncedAccurately =>
      'Spot on! Tone was pronounced accurately.';

  @override
  String get iAgreeToTheTermsOfServiceAndPrivacy =>
      'I agree to the Terms of Service and Privacy Policy.';

  @override
  String get sendMeOccasionalUpdatesTipsAndOffer =>
      'Send me occasional updates, tips, and offers.';

  @override
  String get signInToSyncYourProgress => 'Sign in to sync your progress.';

  @override
  String get createAnAccountToSaveYourStats =>
      'Create an account to save your stats.';

  @override
  String get smartSpiral => 'SMART SPIRAL';

  @override
  String get origin => 'Origin';

  @override
  String get elements => 'Elements';

  @override
  String get humanity => 'Humanity';

  @override
  String get village => 'Village';

  @override
  String get journey => 'Journey';

  @override
  String get city => 'City';

  @override
  String get originTheSimplestShapesTheBeginning =>
      'Origin\': \'The simplest shapes. The beginning of all things.';

  @override
  String get elementsSunMoonWaterAndFireTheNatur =>
      'Elements\': \'Sun, Moon, Water, and Fire. The natural world.';

  @override
  String get humanityTheBodyTheHeartAndTheFamily =>
      'Humanity\': \'The body, the heart, and the family.';

  @override
  String get villageFieldsRoofsAndToolsTheFounda =>
      'Village\': \'Fields, roofs, and tools. The foundations of society.';

  @override
  String get journeyMovementSpeechAndSustenance =>
      'Journey\': \'Movement, speech, and sustenance.';

  @override
  String get cityCommerceClothingAndComplexArtif =>
      'City\': \'Commerce, clothing, and complex artifacts.';

  @override
  String get equilibriumAlgorithm => 'Equilibrium Algorithm';

  @override
  String get misc => 'Misc';

  @override
  String get cityOrOriginAs => 'City\' or \'Origin\' as';

  @override
  String get miscToOrigin => 'Misc\' to \'Origin';

  @override
  String get constellation => 'Constellation';

  @override
  String get whichOneIsWater => 'Which one is \'Water\'?';

  @override
  String get whatIsThePinyin => 'What is the pinyin?';

  @override
  String get nature => 'Nature';

  @override
  String get whatEssenceDoes => 'What essence does';

  @override
  String get allTiers => 'All Tiers';

  @override
  String get active => 'Active';

  @override
  String get theScrollOfOrigin1 => 'THE SCROLL OF ORIGIN';

  @override
  String galaxyOf1(Object name) {
    return 'GALAXY OF';
  }

  @override
  String get also => 'Also';

  @override
  String get work => 'Work';

  @override
  String get cloud => 'Cloud';

  @override
  String get youArchaic => 'You (archaic)';

  @override
  String get suddenly => 'Suddenly';

  @override
  String get owner => 'Owner';

  @override
  String get door => 'Door';

  @override
  String get occupy => 'Occupy';

  @override
  String get nail => 'Nail';

  @override
  String get and => 'And';

  @override
  String get buddhistNun => 'Buddhist Nun';

  @override
  String get anxious => 'Anxious';

  @override
  String get sprout => 'Sprout';

  @override
  String get exchange => 'Exchange';

  @override
  String get sheep => 'Sheep';

  @override
  String get strange => 'Strange';

  @override
  String get opposite => 'Opposite';

  @override
  String get shorttailedBird => 'Short-tailed bird';

  @override
  String get shoot => 'Shoot';

  @override
  String get small => 'Small';

  @override
  String get gather => 'Gather';

  @override
  String get order => 'Order';

  @override
  String get flat => 'Flat';

  @override
  String get thePersonWho => 'The person who...';

  @override
  String get nobleman => 'Nobleman';

  @override
  String get cause => 'Cause';

  @override
  String get pig => 'Pig';

  @override
  String get bright => 'Bright';

  @override
  String get slowly => 'Slowly';

  @override
  String get give => 'Give';

  @override
  String get arrow => 'Arrow';

  @override
  String get dry => 'Dry';

  @override
  String get obstacle => 'Obstacle';

  @override
  String get beg => 'Beg';

  @override
  String get window => 'Window';

  @override
  String get fear => 'Fear';

  @override
  String get drum => 'Drum';

  @override
  String get why => 'Why';

  @override
  String get talent => 'Talent';

  @override
  String get follow => 'Follow';

  @override
  String get desert => 'Desert';

  @override
  String get component => 'Component';

  @override
  String divingInto1(Object topic) {
    return 'Diving into';
  }

  @override
  String get unitIntro1 => 'Unit Intro';

  @override
  String get theBlueprint => 'THE BLUEPRINT';

  @override
  String get theOrigin => 'THE ORIGIN';

  @override
  String get theGalaxy => 'THE GALAXY';

  @override
  String get theScholarListens => 'The Scholar listens...';

  @override
  String get consultingTheScrolls => 'Consulting the scrolls...';

  @override
  String get traceWithTheGuide => 'Trace with the Guide';

  @override
  String get traceTheGhost => 'Trace the Ghost';

  @override
  String get connectTheDots => 'Connect the Dots';

  @override
  String get drawFromMemory => 'Draw from Memory';

  @override
  String get assistant => 'Assistant';

  @override
  String get puck => 'Puck';

  @override
  String get helloWelcomeWhatWouldYouLikeToOrder =>
      'Hello! Welcome. What would you like to order?';

  @override
  String get ni3Hao3Huan1ying2Guang1lin2Qing3wen =>
      'Ni3 hao3! Huan1ying2 guang1lin2. Qing3wen4 ni3 yao4 dian3 shen2me?';

  @override
  String get waiterLi => 'Waiter Li';

  @override
  String get askForTheMenu => 'Ask for the menu';

  @override
  String get orderOneDishAndOneDrink => 'Order one dish and one drink';

  @override
  String get askForTheBill => 'Ask for the bill';

  @override
  String get fenrir => 'Fenrir';

  @override
  String get ni3Qu4Na3rAJi1chang3MaTing3Yuan3De =>
      'Ni3 qu4 na3r a? Ji1chang3 ma? Ting3 yuan3 de!';

  @override
  String get driverWang => 'Driver Wang';

  @override
  String get tellTheDriverYouAreGoingToTheAirpor =>
      'Tell the driver you are going to the airport';

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
  String get requiredLabel => 'Required';

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
      'Master your Mandarin pronunciation\nby mimicking native speech.';

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
  String get yourPathTonchineseFluency => 'Your Path to\nChinese Fluency';

  @override
  String get answer3QuickQuestionsSoOurAiCanCraf =>
      'Answer 3 quick questions so our AI can craft\na curriculum that fits your life.';

  @override
  String get whatIsYourLevelnwithChinese => 'What is your level\nwith Chinese?';

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
      'AI Stories and Roleplay use synthetic voices generated by advanced text-to-speech models, tuned for clear, natural Chinese pronunciation. A local device voice may also be available in some features.';

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

  @override
  String get tutorialOneExplanation =>
      'This is ONE (Yī). Always draw from Left to Right.';

  @override
  String get tutorialWaterExplanation =>
      'This is the full character WATER (Shuǐ). When used as a left-side component, it shapeshifts into \'氵\' (Three Drops)!';

  @override
  String get tutorialRadicalsExplanation =>
      'Hanzi are built from building blocks called RADICALS. They give the character its core meaning or theme.';

  @override
  String get tutorialLettersExplanation =>
      'Hanzi are not just letters. They are pictures frozen in time. To master them, you must learn to trace their flow.';

  @override
  String get tutorialGalaxyExplanation =>
      'The Galaxy Map awaits. Master the Suns (Radicals) to unlock the Planets (Characters).';

  @override
  String get onboardingDailyLifeTravel => 'Daily Life & Travel';

  @override
  String get onboardingPhilosophyIdioms => 'Philosophy & Idioms';

  @override
  String get onboardingBusinessCareerMulti => 'Business &\nCareer';

  @override
  String get onboardingTravelSurvivalMulti => 'Travel &\nSurvival';

  @override
  String get onboardingHskCertificationMulti => 'HSK\nCertification';

  @override
  String get onboardingCulturalAppreciationMulti => 'Cultural\nAppreciation';

  @override
  String get practiceReminders => 'Practice reminders';

  @override
  String get oneOptionalDailyReminderTo =>
      'One optional daily reminder to practice Chinese';

  @override
  String get aFewMinutesOfChinese => 'A few minutes of Chinese? 🌱';

  @override
  String get keepYourProgressMovingWith =>
      'Keep your progress moving with a short practice session.';

  @override
  String get xuX => 'xué xí';

  @override
  String get toStudyToLearn => 'to study · to learn';

  @override
  String get pNgYou => 'péng you';

  @override
  String get fXiN => 'fā xiàn';

  @override
  String get toDiscover => 'to discover';

  @override
  String get jiNCh => 'jiān chí';

  @override
  String get toPersist => 'to persist';

  @override
  String get yNgQ => 'yǒng qì';

  @override
  String get zhHu => 'zhì huì';

  @override
  String get chNgZhNg => 'chéng zhǎng';

  @override
  String get toGrow => 'to grow';

  @override
  String get pNgJNg => 'píng jìng';

  @override
  String get calmPeaceful => 'calm · peaceful';

  @override
  String get xWNg => 'xī wàng';

  @override
  String get lJi => 'lǐ jiě';

  @override
  String get toUnderstand => 'to understand';

  @override
  String get xGuN => 'xí guàn';

  @override
  String get wNNuN => 'wēn nuǎn';

  @override
  String get warmthWarm => 'warmth · warm';

  @override
  String get zhuNZh => 'zhuān zhù';

  @override
  String get toFocus => 'to focus';

  @override
  String get definitionExpansionButton => 'definition-expansion-button';

  @override
  String get wenigerAnzeigen => 'Weniger anzeigen';

  @override
  String get mostrarMenos => 'Mostrar menos';

  @override
  String get afficherMoins => 'Afficher moins';

  @override
  String get mostraMeno => 'Mostra meno';

  @override
  String get showFewer => 'Show fewer';

  @override
  String get masterLin => 'Master Lin';

  @override
  String get xiaoMei => 'Xiao Mei';

  @override
  String get thePoet => 'The Poet';

  @override
  String get aQiang => 'A-Qiang';

  @override
  String get vivian => 'Vivian';

  @override
  String get formalWise => 'Formal & wise';

  @override
  String get casualFriendly => 'Casual & friendly';

  @override
  String get poeticAncient => 'Poetic & ancient';

  @override
  String get slangInternet => 'Slang & internet';

  @override
  String get trendyModern => 'Trendy & modern';

  @override
  String get designYourOwn => 'Design your own';

  @override
  String get theBambooSwaysAndThe =>
      'The bamboo sways, and the scholar awaits your words like morning rain...';

  @override
  String get yourCustomPersonaIsActive =>
      'Your custom persona is active. Type to start the conversation.';

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
      'Stale dictionary expansion response';

  @override
  String get dictionaryExpansionWasEmpty => 'Dictionary expansion was empty';

  @override
  String get explicationDTaillEDisponible => 'Explication détaillée disponible';

  @override
  String get ausfHrlicheErklRungVerf => 'Ausführliche Erklärung verfügbar';

  @override
  String get explicaciNDetalladaDisponible =>
      'Explicación detallada disponible';

  @override
  String get spiegazioneDettagliataDisponibile =>
      'Spiegazione dettagliata disponibile';

  @override
  String get explicaODetalhadaDisponVel => 'Explicação detalhada disponível';

  @override
  String get detailedExplanationAvailable => 'Detailed explanation available';

  @override
  String get oneOptionalDailyPracticeReminder =>
      'One optional daily practice reminder';

  @override
  String get chooseOneOptionalDailyPractice =>
      'Choose one optional daily practice reminder.';

  @override
  String get practiceReminder => 'Practice reminder';

  @override
  String get oneGentleReminderADay =>
      'One gentle reminder a day, only if you need it';

  @override
  String get finishingPracticeSilencesTodayS =>
      'Finishing practice silences today’s reminder. Review and';

  @override
  String get reEngagementAlertsAreCombined =>
      're-engagement alerts are combined so they never stack.';

  @override
  String get processing2 => 'Processing…';

  @override
  String get wDKIChu => 'wǒ dǎ kāi chuāng hu';

  @override
  String get listen => 'Listen';

  @override
  String get notice => 'Notice';

  @override
  String get fourTones => 'Four tones';

  @override
  String get write => 'Write';

  @override
  String get recap => 'Recap';

  @override
  String get playbackDidNotStart => 'Playback did not start';

  @override
  String get audioIsUnavailableYouCan =>
      'Audio is unavailable. You can still read and continue.';

  @override
  String get microphoneAccessWasNotGranted =>
      'Microphone access was not granted. You can use the quiet option below.';

  @override
  String get recordingIsUnavailableRightNow =>
      'Recording is unavailable right now.';

  @override
  String get listeningToYourTones => 'Listening to your tones…';

  @override
  String get noRecording => 'No recording';

  @override
  String get weCouldNotScoreThat =>
      'We could not score that recording, so here is a sample tone comparison.';

  @override
  String get listenForTheLowDipping =>
      'Listen for the low, dipping third tone.';

  @override
  String get firstHearATinyMoment =>
      'First, hear a tiny moment in Mandarin. No memorizing yet.';

  @override
  String get loadingAudio => 'Loading audio…';

  @override
  String get listenToThePassage => 'Listen to the passage';

  @override
  String get continueAction => 'Continue';

  @override
  String get noticeHowMeaningSoundAnd =>
      'Notice how meaning, sound, and characters travel together.';

  @override
  String get shadowOneSentence => 'Shadow one sentence';

  @override
  String get listenOnceThenHoldThe =>
      'Listen once, then hold the microphone and say the sentence.';

  @override
  String get hearItAgain => 'Hear it again';

  @override
  String get stopAndCheckMyTones => 'Stop and check my tones';

  @override
  String get useMicrophone => 'Use microphone';

  @override
  String get iCanTSpeakRight => 'I can\'t speak right now';

  @override
  String get tapACharacterToCompare =>
      'Tap a character to compare the tone you said with the target, then hear tones 1–4.';

  @override
  String get tryHandwriting => 'Try handwriting';

  @override
  String get seeWhatYouLearned => 'See what you learned';

  @override
  String get inAFewMinutesYou =>
      'In a few minutes, you used the same loop that powers your lessons.';

  @override
  String get listenedToChineseInContext => 'Listened to Chinese in context';

  @override
  String get shadowedASentence => 'Shadowed a sentence';

  @override
  String get comparedMandarinTones => 'Compared Mandarin tones';

  @override
  String get practicedARealCharacter => 'Practiced a real character';

  @override
  String get qNgchNXiOy =>
      'Qīngchén, xiǎoyǔ tíng le. Wǒ dǎkāi chuānghu, tīngjiàn niǎor zài shù shàng chànggē. Xīn de yì tiān kāishǐ le.';

  @override
  String get atDawnTheLightRain =>
      'At dawn, the light rain stopped. I opened the window and heard birds singing in the trees. A new day began.';

  @override
  String get learnThroughRealVideos => 'Learn through real videos';

  @override
  String get followInteractiveSubtitlesLookUp =>
      'Follow interactive subtitles, look up words instantly, and turn every video into a lesson.';

  @override
  String get videoLearningScreenshot => 'Video learning screenshot';

  @override
  String get turnAnyBookIntoA => 'Turn any book into a lesson & audiobook';

  @override
  String get readNaturallyWithPronunciationDefinition =>
      'Read naturally with pronunciation, definitions, and translation available whenever you need them.';

  @override
  String get bookReaderScreenshot => 'Book reader screenshot';

  @override
  String get speakWithTheRightRhythm => 'Speak freely with AI & live tones';

  @override
  String get shadowNativeAudioAndVisualize =>
      'Shadow native audio and visualize all four tones as your pronunciation improves.';

  @override
  String get shadowingAndTonesScreenshot => 'Shadowing and tones screenshot';

  @override
  String get understandEveryCharacter => 'Understand every character';

  @override
  String get exploreMeaningPronunciationComponentsStr =>
      'Explore meaning, pronunciation, components, stroke order, and useful vocabulary in one place.';

  @override
  String get characterDictionaryScreenshot => 'Character dictionary screenshot';

  @override
  String get learnChineseWithoutLimits => 'Learn Chinese without limits';

  @override
  String get watchReadSpeakAndUnderstand =>
      'Watch, read, speak, and understand Chinese with one complete learning companion.';

  @override
  String get seeWhatPremiumUnlocks => 'See what Premium unlocks';

  @override
  String get scrollToExploreTheComplete =>
      'Scroll to explore the complete learning experience';

  @override
  String get cOMINGSOON => 'COMING SOON';

  @override
  String get guidedHandwritingPractice => 'Guided handwriting practice';

  @override
  String get scannerAndLiveTranslation => 'Scanner and live translation';

  @override
  String get hSK16AndAI => 'HSK 1–6 and AI decks';

  @override
  String get smartSpacedRepetition2 => 'Smart spaced repetition';

  @override
  String get progressAndStreakTracking => 'Progress and streak tracking';

  @override
  String get learningToolsInOnePlace => 'Learning tools in one place';

  @override
  String get everythingIncluded => 'Everything included';

  @override
  String get paymentIsChargedToYour2 =>
      'Payment is charged to your App Store account. Subscriptions renew automatically unless canceled at least 24 hours before the end of the current period.';

  @override
  String get yourFirstWeekOfTracked => 'Your first week of tracked practice';

  @override
  String get sameNumberOfCardsAs => 'Same number of cards as last week';

  @override
  String cardsComparedWithLastWeek(String change) {
    return '$change cards vs last week';
  }

  @override
  String get todaySPractice => 'Today’s practice';

  @override
  String get goalCompleteAnythingMoreIs =>
      'Goal complete — anything more is a bonus.';

  @override
  String get aSmallAchievableTargetNo =>
      'A small, achievable target. No penalty for a rest day.';

  @override
  String get thisWeek => 'This week';

  @override
  String get minutes => 'Minutes';

  @override
  String get activeDays => 'Active days';

  @override
  String dayStreakCount(int count) {
    return '$count-day streak';
  }

  @override
  String get masterChineseOneStrokeAt => 'Master Chinese, one stroke at a time';

  @override
  String get dictionaryExpansionButton => 'dictionary-expansion-button';

  @override
  String get kIErweiterterWRterbucheintrag =>
      'KI-erweiterter Wörterbucheintrag';

  @override
  String get detalleAmpliadoPorIA => 'Detalle ampliado por IA';

  @override
  String get dTailEnrichiParL => 'Détail enrichi par l’IA';

  @override
  String get aI => 'AI द्वारा विस्तृत शब्दकोश विवरण';

  @override
  String get detailKamusYangDiperluasAI => 'Detail kamus yang diperluas AI';

  @override
  String get dettaglioDelDizionarioAmpliatoDall =>
      'Dettaglio del dizionario ampliato dall’IA';

  @override
  String get aI2 => 'AIによる辞書の補足';

  @override
  String get aI3 => 'AI로 확장된 사전 설명';

  @override
  String get detalheDeDicionRioExpandido =>
      'Detalhe de dicionário expandido por IA';

  @override
  String get aI4 => 'รายละเอียดพจนานุกรมที่ขยายโดย AI';

  @override
  String get chiTiTTI => 'Chi tiết từ điển được AI mở rộng';

  @override
  String get aI5 => 'AI 扩展词典释义';

  @override
  String get aIExpandedDictionaryDetail => 'AI-expanded dictionary detail';

  @override
  String get cetteEntrEEstBr =>
      'Cette entrée est brève. Une explication détaillée est disponible.';

  @override
  String get dieserEintragIstKurzEine =>
      'Dieser Eintrag ist kurz. Eine ausführliche Erklärung ist verfügbar.';

  @override
  String get estaEntradaEsBreveHay =>
      'Esta entrada es breve. Hay una explicación detallada disponible.';

  @override
  String get questaVoceBreveDisponibileUna =>
      'Questa voce è breve. È disponibile una spiegazione dettagliata.';

  @override
  String get estaEntradaBreveEstDispon =>
      'Esta entrada é breve. Está disponível uma explicação detalhada.';

  @override
  String get thisDictionaryEntryIsBrief =>
      'This dictionary entry is brief. A detailed explanation is available.';

  @override
  String get dVelopperEnFranAis => 'Développer en français';

  @override
  String get aufDeutschErweitern => 'Auf Deutsch erweitern';

  @override
  String get ampliarEnEspaOl => 'Ampliar en español';

  @override
  String get approfondisciInItaliano => 'Approfondisci in italiano';

  @override
  String get expandirEmPortuguS => 'Expandir em português';

  @override
  String get expandDefinition => 'Expand definition';

  @override
  String get impossibleDeChargerLExplication =>
      'Impossible de charger l’explication.';

  @override
  String get dieErklRungKonnteNicht =>
      'Die Erklärung konnte nicht geladen werden.';

  @override
  String get noSePudoCargarLa => 'No se pudo cargar la explicación.';

  @override
  String get impossibileCaricareLaSpiegazione =>
      'Impossibile caricare la spiegazione.';

  @override
  String get nOFoiPossVel => 'Não foi possível carregar a explicação.';

  @override
  String get unableToLoadTheExplanation => 'Unable to load the explanation.';

  @override
  String get failedToGenerateStoryN => 'Failed to generate story:\\n\$e';

  @override
  String get thematic => 'Thematic';

  @override
  String get deckFlashcards => 'Deck (Flashcards)';

  @override
  String get searchLibraryOrTypeCustom => 'Search library or type custom';

  @override
  String get hSKLevel => 'HSK \$level';

  @override
  String get analysisFailedE => 'Analysis failed: \$e';

  @override
  String get extractionFailedE => 'Extraction failed: \$e';

  @override
  String get simplifyFailedE => 'Simplify failed: \$e';

  @override
  String get translationFailedE => 'Translation failed: \$e';

  @override
  String get failedToSaveExtractedWords2 =>
      'Failed to save extracted words: \$error';

  @override
  String youActualTargetExpected(String actual, String expected) {
    return 'You: $actual  ·  Target: $expected';
  }

  @override
  String get improveTheLocalVoice => 'Improve the local voice';

  @override
  String get higherQualityOfflineMandarin => 'Higher-quality offline Mandarin';

  @override
  String get removeDownload => 'Remove download?';

  @override
  String get removeDownload2 => 'Remove Download';

  @override
  String get tag => '#\$tag';

  @override
  String get voiceFemaleWarm => 'Female, warm';

  @override
  String get voiceFemaleCheerful => 'Female, cheerful';

  @override
  String get voiceMaleUpbeat => 'Male, upbeat';

  @override
  String get voiceMaleNewsStyle => 'Male, news-style';

  @override
  String get voiceMaleSporty => 'Male, sporty';

  @override
  String get voiceOnDeviceTts => 'On-device TTS';

  @override
  String get voiceSystemVoice => 'System voice';

  @override
  String get applySessionGradesToSpacedRepetition =>
      'Apply session grades to Spaced Repetition (Speaking Mode)';

  @override
  String get unableToLoadThisSectionPleaseTryAgain =>
      'Unable to load this section. Please try again.';

  @override
  String get removeDownloadQuestion => 'Remove download?';

  @override
  String get removeDownloadContent =>
      'Are you sure you want to remove the downloaded content for this book?';

  @override
  String get removeDownloadAction => 'Remove Download';

  @override
  String get removeDownloadButton => 'Remove Download';

  @override
  String cardsCount(num count) {
    return '$count Cards';
  }

  @override
  String get aiSummary => 'AI Summary';

  @override
  String get readability => 'Readability';

  @override
  String get translateAction => 'Translate';

  @override
  String get checkingDownload => 'Checking download';

  @override
  String downloadingBook(int percent) {
    return 'Downloading $percent%';
  }

  @override
  String get retryDownload => 'Retry download';

  @override
  String get downloadBook => 'Download book';

  @override
  String continueChapter(int chapter) {
    return 'Continue chapter $chapter';
  }

  @override
  String get downloadBookError =>
      'Could not download this book. Check your connection and try again.';

  @override
  String downloadBookOffline(int count) {
    return 'Download the book to read its $count chapters offline.';
  }

  @override
  String poemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count poems',
      one: '1 poem',
    );
    return '$_temp0';
  }

  @override
  String get americanLiterature => 'American Literature';

  @override
  String get ancientChina => 'Ancient China';

  @override
  String get britishLiterature => 'British Literature';

  @override
  String get frenchLiterature => 'French Literature';

  @override
  String get germanLiterature => 'German Literature';

  @override
  String get italianLiterature => 'Italian Literature';

  @override
  String get jinDynasty => 'Jin Dynasty';

  @override
  String get preQinEra => 'Pre-Qin';

  @override
  String get qingDynasty => 'Qing Dynasty';

  @override
  String get republicOfChinaEra => 'Republic of China';

  @override
  String get russianLiterature => 'Russian Literature';

  @override
  String get spanishLiterature => 'Spanish Literature';

  @override
  String get springAndAutumn => 'Spring and Autumn period';

  @override
  String get westernHan => 'Western Han';

  @override
  String get roleplayCreatorContextPlaceholder =>
      'e.g., A lively banquet celebrating in Shanghai...';

  @override
  String get roleplayCreatorPersonaPlaceholder =>
      'e.g., A curious cousin asking about your career...';

  @override
  String get beginFirstLesson => 'Begin First Lesson';

  @override
  String onboardingLessonProgress(Object current, Object total) {
    return 'YOUR FIRST LESSON  •  $current OF $total';
  }

  @override
  String get onboardingListenInstruction =>
      'First, hear one of the best-known lines in Chinese literature. No memorizing yet.';

  @override
  String get onboardingFromGrandLibrary => 'From the Grand Library';

  @override
  String get onboardingArtOfWarTitleAuthor => 'The Art of War · Sun Tzu';

  @override
  String get onboardingArtOfWarChapter => '谋攻篇 · Chapter 3';

  @override
  String get onboardingClassicLineLabel => 'A CLASSIC LINE';

  @override
  String get onboardingArtOfWarTranslation =>
      '“Know the enemy and know yourself, and you need not fear the result of a hundred battles.”';

  @override
  String get onboardingNoticeMeaning => 'Know the enemy and know yourself,';

  @override
  String get onboardingShadowMeaning =>
      'You will not be imperiled in a hundred battles.';

  @override
  String get onboardingPracticeThisLabel => 'YOU’LL PRACTICE THIS';

  @override
  String get onboardingFromArtOfWarLabel => 'FROM THE ART OF WAR';

  @override
  String get onboardingYourPronunciationLabel => 'YOUR PRONUNCIATION';

  @override
  String get onboardingTapACharacter => 'Tap a character';

  @override
  String onboardingWordAndPinyin(String word, String pinyin) {
    return '$word · $pinyin';
  }

  @override
  String get onboardingToneMatched => 'Matched';

  @override
  String get onboardingCompareTones => 'Compare tones';

  @override
  String get onboardingToneOneHigh => 'tone 1 · high';

  @override
  String get onboardingToneTwoRising => 'tone 2 · rising';

  @override
  String get onboardingToneThreeDipping => 'tone 3 · dipping';

  @override
  String get onboardingToneFourFalling => 'tone 4 · falling';

  @override
  String get onboardingToneNotDetected => 'not detected';

  @override
  String get onboardingFeedbackGreatThirdTone => 'Great dipping third tone.';

  @override
  String get onboardingFeedbackFourthToneFall =>
      'Let the fourth tone fall firmly and quickly.';

  @override
  String get onboardingFeedbackClearFourthTone => 'Clear falling fourth tone.';

  @override
  String get onboardingFeedbackStrongFourthTone =>
      'Strong falling fourth tone.';

  @override
  String onboardingTraceInstruction(
      String character, String pinyin, String meaning) {
    return 'Trace $character ($pinyin, “$meaning”). Follow the faint stroke guide.';
  }

  @override
  String billingDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: 'day',
    );
    return '$_temp0';
  }

  @override
  String billingWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count weeks',
      one: 'week',
    );
    return '$_temp0';
  }

  @override
  String billingMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count months',
      one: 'month',
    );
    return '$_temp0';
  }

  @override
  String billingYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count years',
      one: 'year',
    );
    return '$_temp0';
  }

  @override
  String startPeriodFreeTrial(String period) {
    return 'Start $period free trial';
  }

  @override
  String subscribeForPricePeriod(String price, String period) {
    return 'Subscribe for $price / $period';
  }

  @override
  String eligibleTrialRenewalNotice(String price, String period) {
    return 'Your selected StoreKit product includes an eligible free trial. After the trial, it renews for $price per $period unless canceled.';
  }

  @override
  String pricePerPeriod(String price, String period) {
    return '$price / $period';
  }

  @override
  String get learn => 'Learn';

  @override
  String get booksAndStudioQualityAudiobooks =>
      'Books and studio-quality audiobooks';

  @override
  String get aiConversationsAndLiveToneFeedback =>
      'AI conversations and live tone feedback';

  @override
  String get interactiveVideoAndWebImmersion =>
      'Interactive video and web immersion';

  @override
  String get characterInsightsAndHandwritingPractice =>
      'Character insights and handwriting practice';

  @override
  String get hskDecksAndSmartSpacedRepetition =>
      'HSK decks and smart spaced repetition';

  @override
  String get termsOfUseEula => 'Terms of Use (EULA)';

  @override
  String get masterEveryStroke => 'Master every stroke';

  @override
  String get exploreTheChineseWeb => 'Explore the Chinese web';

  @override
  String get tone1Description =>
      'Keep your pitch high and steady like singing a note.';

  @override
  String get tone2Description =>
      'Start in the middle and slide your pitch upward like asking \'What?\'';

  @override
  String get tone3Description =>
      'Dip your voice down low, then rise gently back up.';

  @override
  String get tone4Description =>
      'Drop your pitch sharply and decisively like a firm \'No!\'';

  @override
  String get toneNeutralDescription =>
      'Pronounce softly, briefly, and without emphasis.';

  @override
  String get toneDiagMatch1 => 'Spot on! Pitch was high, flat, and steady.';

  @override
  String get toneDiagMatch2 => 'Spot on! Upward pitch rise was clear.';

  @override
  String get toneDiagMatch3 => 'Spot on! Low dipping curve was accurate.';

  @override
  String get toneDiagMatch4 => 'Spot on! Sharp falling drop was decisive.';

  @override
  String get toneDiagMatchDefault => 'Spot on! Tone was pronounced accurately.';

  @override
  String get toneDiag1vs2 =>
      'You rose your pitch (2nd tone /). Keep your voice flat and high across the whole syllable (1st tone ˉ).';

  @override
  String get toneDiag1vs3 =>
      'You dipped your voice (3rd tone ˇ). Keep your pitch steady and high without dipping (1st tone ˉ).';

  @override
  String get toneDiag1vs4 =>
      'You dropped your pitch (4th tone \\). Sustain a high, level pitch like singing a note (1st tone ˉ).';

  @override
  String get toneDiag2vs1 =>
      'You stayed flat (1st tone ˉ). Slide your pitch upward like asking \'What?\' (2nd tone /).';

  @override
  String get toneDiag2vs3 =>
      'You dipped too deep (3rd tone ˇ). Start mid-level and rise smoothly without bottoming out (2nd tone /).';

  @override
  String get toneDiag2vs4 =>
      'You dropped your pitch (4th tone \\). Rise upward like asking a question (2nd tone /).';

  @override
  String get toneDiag3vs1 =>
      'You stayed high and flat (1st tone ˉ). Let your pitch drop low into your chest register before rising (3rd tone ˇ).';

  @override
  String get toneDiag3vs2 =>
      'You rose immediately (2nd tone /). Make sure to dip down low first before rising back up (3rd tone ˇ).';

  @override
  String get toneDiag3vs4 =>
      'You dropped sharply without rising (4th tone \\). Allow your pitch to bounce gently back up at the end (3rd tone ˇ).';

  @override
  String get toneDiag4vs1 =>
      'You stayed flat (1st tone ˉ). Drop your pitch sharply and decisively like a firm \'No!\' (4th tone \\).';

  @override
  String get toneDiag4vs2 =>
      'You rose your pitch (2nd tone /). Start high and snap sharply downward (4th tone \\).';

  @override
  String get toneDiag4vs3 =>
      'You dipped and rose (3rd tone ˇ). Drop straight down without rising back up (4th tone \\).';

  @override
  String get toneDiagListenDiff =>
      'Listen to the 4 tones below to hear the difference.';

  @override
  String get liveCallSpeaking => 'Speaking...';

  @override
  String get toneAccurate => 'Tone Accurate';

  @override
  String get toneNeedsWork => 'Tone Needs Work';

  @override
  String get liveCallSessionCompletedFallback =>
      'Session completed. In your next practice, speak complete sentences to receive detailed pronunciation and tone diagnostics.';

  @override
  String liveCallGoodStartPracticingWord(String word) {
    return 'Good start practicing \'$word\'. In your next session, try stringing full sentences together to practice tone transitions and natural flow.';
  }

  @override
  String get liveCallSolidEffortFallback =>
      'Solid conversational effort. Focus on keeping 1st tones high and steady (55) and 4th tones sharp and decisive (51) to enhance native clarity.';

  @override
  String get liveCallGoodPracticeFallback =>
      'Good practice session. Continue focusing on clear tone pitch contrasts and natural conversational pacing.';
}
