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
  String get cardsRequireAttention => 'cards require attention.';

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
  String get startSession => 'START SESSION';

  @override
  String get sessionHistory => 'Session History';

  @override
  String get noSavedSessions => 'No saved sessions.';

  @override
  String get aiBreakdown => 'AI Breakdown';

  @override
  String get sessionDetails => 'Session Details';

  @override
  String get partner => 'Partner (中文)';

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
  String get hideStrokeGuideStreak => 'Hide stroke guide at streak: (streak)';

  @override
  String get inkPoints => '(points) Ink Points';

  @override
  String get speechRateMultiplier => '(rate)x';

  @override
  String get animationSpeedMultiplier => '(rate)x';

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
  String get followGuideStroke =>
      'Follow the blue guide to draw stroke (current) of (total)';

  @override
  String get skipCurrentStroke => 'Skip Current Stroke';

  @override
  String get submitDrawing => 'Submit Drawing';

  @override
  String get addedToDeck => 'Added (hanzi) to (deckName)';

  @override
  String get removedFromDeck => 'Removed (hanzi) from deck';

  @override
  String get skippedNoStrokeData =>
      'Skipped \"(hanzi)\" - No stroke data available for this AI character.';

  @override
  String get startingSession => 'Starting session...';

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
  String get storyTitleHsk => '(title) (HSK (level))';

  @override
  String get pleaseEnterTopic => 'Please enter a topic';

  @override
  String get createdDeckCards => 'Created (name) with (count) cards!';

  @override
  String get gradeResult => 'Grade: (grade)';

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
  String get addedCharToLibrary => 'Added (char) to Library';

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
  String get addedToLibrary => 'Added \'(hanzi)\' to your Library';

  @override
  String get generateNewStory => 'Generate New Story';

  @override
  String get failedToGenerateStory => 'Failed to generate story:\\n(error)';

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
  String get addTo => 'Add to';

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
      'If the AI detects a mismatch, it will ask \'Did you mean to say...?\'. You can tap the \'Yes, Re-Grade Me!\' button to instantly re-evaluate your original audio against your true intention without having to speak again.';

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
  String get library => 'æ–‡åŒ–ä¹¦æˆ¿ Library';

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
  String get score => 'Score:';

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
  String get whatIfAiMishears => 'What if the AI mishears what I meant to say?';

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
  String get you => 'You';

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
      'Your Echo Hall conversations are stored locally on your device so you can review them anytime. We do not use your personal conversations to train our AI models.';

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
  String get added_to_your_library => 'Added \'\' to your Library';

  @override
  String get advanced => 'Advanced';

  @override
  String get ai_stories => 'AI Stories';

  @override
  String get analysis_failed => 'Analysis Failed: (error)';

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
  String get chapters => 'Chapters)';

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
  String get error_creating_scenario => 'Error creating scenario: (error)';

  @override
  String get error_fetching_translation_for =>
      'Error fetching translation for : (error)';

  @override
  String get error_loading_chapters => 'Error loading chapters: (error)';

  @override
  String get error_loading_decks => 'Error loading decks';

  @override
  String get error_loading_microreads => 'Error loading micro-reads: (error)';

  @override
  String get error_loading_novels => 'Error loading novels: (error)';

  @override
  String get error_loading_poetry => 'Error loading poetry: (error)';

  @override
  String get etymology => 'Etymology: ';

  @override
  String get explanation => 'explanation';

  @override
  String get extracted_text_tap_to_lookup => 'Extracted Text (Tap to lookup)';

  @override
  String get extraction_failed => 'Extraction Failed: \\(error)';

  @override
  String get failed_to_download => 'Failed to download.';

  @override
  String get failed_to_generate_scenario =>
      'Failed to generate scenario: (error)';

  @override
  String get failed_to_generate_story => 'Failed to generate story:\\n(error)';

  @override
  String get failed_to_load_context => 'Failed to load context: (error)rr';

  @override
  String get feature_request => 'Feature Request';

  @override
  String get foundation => 'Foundation';

  @override
  String get how_is_my_pronunciation_scored =>
      'How is my pronunciation scored?';

  @override
  String get hsk => 'HSK ';

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
  String get no_results_found_for => 'No results found for \'\'';

  @override
  String get no_when_you_use_echo_hall =>
      'No. When you use Echo Hall, Scholar\'s Verdict, or Shadowing Studio, your audio is securely evaluated in real-time to generate a pronunciation score and then immediately discarded. We only store your numerical ratings to track your progress.';

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
  String get question => 'Question';

  @override
  String remove_from_this_deck(String hanzi) {
    return 'Remove $hanzi from this deck?';
  }

  @override
  String get revenuecat_error => 'RevenueCat Error: (error)';

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
  String get simplify_failed => 'Simplify Failed: (error)';

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
  String get translation_failed => 'Translation Failed: (error)';

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
  String get vocabularyBatch => 'Vocabulary Batch (index)';

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
  String get unnamedKey => '#(tag)';

  @override
  String get error => 'Error: (error)';

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
  String get failedToSaveExtractedWords =>
      'Failed to save extracted words: (error)';

  @override
  String get addToDeck => 'Add to Deck ((count))';

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
  String get cards => '(count) cards';

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
  String get bookmarkAdded => '已添加书签 · Bookmark added: 第(chapter)回';

  @override
  String get readingVocabulary => 'Reading & Vocabulary';

  @override
  String get vocabularyBatchUnitindex1 => 'Vocabulary Batch \$(unitIndex + 1)';

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
  String get ui__transcription => '\"\$_transcription\"';

  @override
  String get playPinyinwithtone => 'Play \$pinyinWithTone';

  @override
  String get errorE => 'Error: \$e';

  @override
  String get lookalikepinyin => '(\$(lookAlike.pinyin))';

  @override
  String get aiSmartContext1 => 'AI Smart Context';

  @override
  String get aiSmartContextError1 => 'AI Smart Context Error';

  @override
  String get errorErr => 'Error: \$err';

  @override
  String get downloadOfficialHskCollections1 =>
      'Download official HSK collections';

  @override
  String get unableToLoadThisSectionPleaseTryAga =>
      'Unable to load this section. Please try again.';

  @override
  String get searchRadicalsEgWater => 'Search radicals (e.g. Water, 氵)';

  @override
  String get ui__currentstrokeindex1totalstrokes =>
      '\$(_currentStrokeIndex + 1)/\$totalStrokes';

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
  String get accuracytostringasfixed1 => '\$(accuracy.toStringAsFixed(1))%';

  @override
  String get upcomingReviewsNext7Days => 'Upcoming Reviews (Next 7 Days)';

  @override
  String get explaining => 'Explaining:';

  @override
  String get entryhanziEntrypinyin => '\$(entry.hanzi) [\$(entry.pinyin)]';

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
  String get acc => '\$acc%';

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
  String get error_error => 'Error: \$_error';

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
  String get playbackratex => '\$(playbackRate)x';

  @override
  String get speedx => '\$(speed)x';

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
  String get addToDeck_selectedwordindiceslength =>
      'Add to Deck (\$(_selectedWordIndices.length))';

  @override
  String get scanner1 => 'Scanner';

  @override
  String get interpreter1 => 'Interpreter';

  @override
  String get entryvalueCards => '\$(entry.value) cards';

  @override
  String get score_score_questionslength =>
      'Score: \$_score / \$(_questions.length)';

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
  String get galaxyOf1 => 'GALAXY OF';

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
  String get divingInto1 => 'Diving into';

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
  String get inThisChapterOf => 'In this chapter of';

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
