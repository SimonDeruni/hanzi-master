// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

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
  String get globalMastery => 'ОБЩЕЕ МАСТЕРСТВО';

  @override
  String get masteredCards => 'Освоено';

  @override
  String get hsk1Candidate => 'Кандидат HSK 1';

  @override
  String get hsk2Candidate => 'Кандидат HSK 2';

  @override
  String get hsk3Candidate => 'Кандидат HSK 3';

  @override
  String get hsk4Candidate => 'Кандидат HSK 4';

  @override
  String get hsk5Candidate => 'Кандидат HSK 5';

  @override
  String get hsk6Candidate => 'Кандидат HSK 6';

  @override
  String get hsk6Master => 'Мастер HSK 6';

  @override
  String get currentRank => 'ТЕКУЩИЙ РАНГ';

  @override
  String get next => 'Далее';

  @override
  String get searchHanziOrPinyin => 'Поиск...';

  @override
  String get dailyReview => 'Ежедневный повтор';

  @override
  String get upcomingForecast => 'Прогноз';

  @override
  String get laterToday => 'Позже сегодня';

  @override
  String get tomorrow => 'Завтра';

  @override
  String get next7Days => 'Следующие 7 дней';

  @override
  String get theScholarWay => 'Путь Ученого';

  @override
  String get beginJourney => 'Начать';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get darkMode => 'Темный режим';

  @override
  String get darkModeDesc => 'Приятно для глаз';

  @override
  String get voiceSpeed => 'Скорость голоса';

  @override
  String get artAndIntellect => 'ИСКУССТВО И ИНТЕЛЛЕКТ';

  @override
  String get theDigitalScholar => 'Цифровой Ученый';

  @override
  String get refineBrushVoice => 'Совершенствуйте кисть и голос с ИИ.';

  @override
  String get liveVoiceCall => 'Голосовой вызов';

  @override
  String get immersiveRoleplay => 'Ролевая игра с ИИ';

  @override
  String get readingRoom => 'Читальный зал';

  @override
  String get shadowingStudio => 'Студия повторения';

  @override
  String get errorPrefix => 'Ошибка: ';

  @override
  String get initializingLibrary => 'Инициализация...';

  @override
  String get unlockCharactersToQuiz =>
      'Разблокируйте 4 иероглифа для викторины!';

  @override
  String get practiceQuiz => 'ВИКТОРИНА';

  @override
  String get curriculumPaths => 'ПУТИ';

  @override
  String get noDecksFound => 'Нет колод. Добавьте их!';

  @override
  String get addCardsFirst => 'Сначала добавьте карточки!';

  @override
  String get aiDraftingPath => 'ИИ готовит ваш путь...';

  @override
  String get pathReady => 'Путь готов!';

  @override
  String get errorGeneratingPath => 'Ошибка';

  @override
  String get brushingCurriculum => 'Создание пути...';

  @override
  String get warmUp => 'РАЗМИНКА';

  @override
  String get lessonComplete => 'Урок завершен! +10 Очков';

  @override
  String get step1Origin => 'ШАГ 1: ИСТОК';

  @override
  String get traceRadical => 'Обведите радикал';

  @override
  String get step2Forge => 'ШАГ 2: КУЗНИЦА';

  @override
  String get chooseEssence => 'Выберите суть';

  @override
  String get wrongEssence => 'Неверно! Попробуйте снова.';

  @override
  String get step3Hunt => 'ШАГ 3: ОХОТА';

  @override
  String get findCharacters => 'Найдите иероглифы';

  @override
  String get notThatOne => 'Не этот!';

  @override
  String get successfullyInstalled => 'Установлено:';

  @override
  String get failedToDownload => 'Ошибка загрузки.';

  @override
  String get rescindTitle => 'Отменить?';

  @override
  String get removeCharactersWarning => 'Это удалит эти иероглифы.';

  @override
  String get cancel => '取消';

  @override
  String get uninstall => 'Удалить';

  @override
  String get removedLibrary => 'Удалено:';

  @override
  String get tomeLibrary => 'Библиотека';

  @override
  String get libraryError => 'Ошибка библиотеки';

  @override
  String get installTome => 'УСТАНОВИТЬ';

  @override
  String get unitIntro => 'ВВЕДЕНИЕ';

  @override
  String get constellationCluster => 'Звездное скопление';

  @override
  String get ok => 'ОК';

  @override
  String get divingInto => 'Погружение...';

  @override
  String get keyRadicals => 'КЛЮЧЕВЫЕ РАДИКАЛЫ';

  @override
  String get noRadicalData => 'Нет данных.';

  @override
  String get discovery => 'ОТКРЫТИЕ';

  @override
  String get startLearning => 'НАЧАТЬ';

  @override
  String get selectPersona => 'Выбрать Персонажа';

  @override
  String get customPersona => 'Пользовательский Персонаж';

  @override
  String get geminiLiveCall => 'ЖИВОЙ ВЫЗОВ';

  @override
  String get returnToMenu => 'Назад';

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
  String get gradedAiStories => 'Истории ИИ';

  @override
  String get calligraphy => 'Каллиграфия';

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
  String get audioAndHaptics => 'Аудио и тактильные ощущения';

  @override
  String get autoPlayAudio => 'Auto Play Audio';

  @override
  String get autoPlayDesc => 'Auto Play Desc';

  @override
  String get haptics => 'Haptics';

  @override
  String get displayAndContent => 'Экран и содержимое';

  @override
  String get useEnglishDefinitions => 'Использовать определения на английском';

  @override
  String get useEnglishDefinitionsDesc =>
      'Определения на английском обычно точнее и подробнее';

  @override
  String get animationSpeed => 'Скорость анимации';

  @override
  String get manageTomes => 'Manage Tomes';

  @override
  String get manageTomesDesc => 'Manage Tomes Desc';

  @override
  String get dangerZone => 'Опасная зона';

  @override
  String get resetAllData => 'Сбросить все данные';

  @override
  String get resetDataDesc =>
      'Это навсегда удалит все ваши данные прогресса, статистику и настройки. Это действие нельзя отменить.';

  @override
  String get areYouSure => 'Are You Sure';

  @override
  String get cannotBeUndone => 'Cannot Be Undone';

  @override
  String get deleteEverything => 'Delete Everything';

  @override
  String get appLanguage => 'Язык приложения';

  @override
  String get howDidYouDo => 'Как у вас получилось?';

  @override
  String get missedItEntirely => 'Совершенно не понял';

  @override
  String get gotItButStruggled => 'Понял, но с трудом';

  @override
  String get gotItClearly => 'Понял четко';

  @override
  String get perfectAndImmediate => 'Идеально и сразу';

  @override
  String get again => 'Снова';

  @override
  String get hard => 'Сложно';

  @override
  String get good => 'Хорошо';

  @override
  String get easy => 'Легко';

  @override
  String get tapToReveal => 'Нажмите, чтобы открыть';

  @override
  String get howWellDidYouRemember => 'Насколько хорошо вы запомнили?';

  @override
  String get completelyForgot => 'Совершенно забыл';

  @override
  String get gotItWithDifficulty => 'Вспомнил с трудом';

  @override
  String get recalledCorrectly => 'Вспомнил правильно';

  @override
  String get perfectRecall => 'Вспомнил идеально';

  @override
  String get practiceWriting => 'Практика письма';

  @override
  String get hideScratchpad => 'Скрыть черновик';

  @override
  String get whatCharacterMeans => 'Что означает иероглиф:';

  @override
  String get tapCardToReveal => 'Нажмите на карточку, чтобы открыть';

  @override
  String get ratePronunciationConfidence =>
      'Оцените свою уверенность в произношении';

  @override
  String get botchedIt => 'Совсем не получилось';

  @override
  String get struggledWithTones => 'Были проблемы с тонами';

  @override
  String get acceptable => 'Приемлемо';

  @override
  String get perfectlyNatural => 'Идеально естественно';

  @override
  String get sessionComplete => 'Сессия завершена!';

  @override
  String get accuracy => 'Точность';

  @override
  String get reviewed => 'Повторено';

  @override
  String get correct => 'Правильно';

  @override
  String get backToLibrary => 'Вернуться в библиотеку';

  @override
  String get revealAnswer => 'Показать ответ';

  @override
  String get aiHubTitle => 'ИИ-Хаб';

  @override
  String get textChat => 'Текстовый чат';

  @override
  String get scholarlyPersonas => 'Учёные собеседники';

  @override
  String get shadowing => 'Метод повторения';

  @override
  String get liveTranslation => 'Перевод в реальном времени';

  @override
  String get scholarsLibrary => 'Библиотека учёного';

  @override
  String get generate => 'Сгенерировать';

  @override
  String get searchPinyinHanziEnglish =>
      'Поиск по пиньиню, иероглифам или английскому...';

  @override
  String get liveTranslate => 'Перевести в реальном времени';

  @override
  String get travelInterpreter => 'Переводчик для путешествий';

  @override
  String get realTimeSplitScreen =>
      'Разговор с носителем языка на разделенном экране в реальном времени. Мгновенно устраняет языковые барьеры.';

  @override
  String get whisperEarpiece => 'Наушник-переводчик';

  @override
  String get listenToChineseAudio =>
      'Слушайте китайский аудиоматериал и получайте английские субтитры в реальном времени прямо на экране.';

  @override
  String get dashboardTitle => 'Панель управления';

  @override
  String get yourMindIsClear => 'Ваш разум чист.';

  @override
  String get noReviewsDueToday => 'На сегодня нет повторений.';

  @override
  String get done => 'Готово';

  @override
  String get hskLevel1 => 'HSK Уровень 1';

  @override
  String get hskLevel2 => 'HSK Уровень 2';

  @override
  String get hskLevel3 => 'HSK Уровень 3';

  @override
  String get hskLevel4 => 'HSK Уровень 4';

  @override
  String get hskLevel5 => 'HSK Уровень 5';

  @override
  String get hskLevel6 => 'HSK Уровень 6';

  @override
  String get generalVocabulary => 'Общая лексика';

  @override
  String get cardsRequireAttention => 'карточек требуют внимания.';

  @override
  String get begin => 'Начать';

  @override
  String get poweredByAi =>
      'На основе передового ИИ. Бесшовный перевод в реальном времени для любого сценария.';

  @override
  String get downloadingModel => 'Загрузка модели...';

  @override
  String get soon => 'СКОРО';

  @override
  String get installed => 'УСТАНОВЛЕНО';

  @override
  String get premium => 'ПРЕМИУМ';

  @override
  String get coreModule => 'ОСНОВНОЙ МОДУЛЬ';

  @override
  String get step6Context => 'ШАГ 6: КОНТЕКСТ';

  @override
  String get tapBuildingBlocksTo =>
      'Нажмите на строительные блоки, чтобы узнать их происхождение.';

  @override
  String get initiateRadicalSequence => 'НАЧАТЬ РАДИКАЛЬНУЮ ПОСЛЕДОВАТЕЛЬНОСТЬ';

  @override
  String get holdToTalk => 'Удерживайте, чтобы говорить';

  @override
  String get customScenario => 'Пользовательский сценарий';

  @override
  String get voiceCall => 'Голосовой вызов';

  @override
  String get pronunciation => '发音';

  @override
  String get selectAScenarioTo =>
      'Выберите сценарий для практики разговорного мандаринского наречия. Ученый оценит ваши тона и ясность речи.';

  @override
  String get create => 'Создать';

  @override
  String get createYourScenario => 'Создайте свой сценарий';

  @override
  String get difficulty => 'Сложность';

  @override
  String get scholarsVerdict => 'ВЕРДИКТ УЧЕНОГО';

  @override
  String get completeReview => 'Завершить обзор';

  @override
  String get conversationReview => 'ОБЗОР РАЗГОВОРА';

  @override
  String get linguisticAnalysis => 'Лингвистический анализ';

  @override
  String get examplesInHsk1 => 'ПРИМЕРЫ В HSK 1';

  @override
  String get characterReference => 'Ссылки на символы';

  @override
  String get askTutor => 'Спросить репетитора';

  @override
  String get addToStudyDeck => 'Добавить в учебную колоду';

  @override
  String get startPractice => 'НАЧАТЬ ПРАКТИКУ';

  @override
  String get noOtherHsk1 =>
      'Никакие другие символы HSK 1 не используют этот радикал.';

  @override
  String get couldNotLoadAi =>
      'Не удалось загрузить контекст ИИ. (Превышен лимит запросов или ошибка сети)\nНажмите кнопку обновления ниже, чтобы повторить попытку позже.';

  @override
  String get noAvailableCardsFound => 'Карточек не найдено.';

  @override
  String get addCards => 'Добавить карточки';

  @override
  String get removeCard => 'Удалить карточку';

  @override
  String get remove => 'Удалить';

  @override
  String get review => '复习';

  @override
  String get story => 'История';

  @override
  String get thisDeckIsEmpty => 'Эта колода пуста.';

  @override
  String get tapTheAddCards => 'Нажмите кнопку «Добавить карточки»!';

  @override
  String get noCardsFound => 'Карточек не найдено.';

  @override
  String get addCardsToSee => 'Добавьте карточки, чтобы увидеть статистику.';

  @override
  String get aiGenerated => 'Сгенерировано ИИ';

  @override
  String get allCardsCaughtUp => 'Все карточки проработаны! Отличная работа.';

  @override
  String get latestDiscoveries => 'Последние открытия';

  @override
  String get noCharactersInLexicon => 'Пока нет символов в лексиконе.';

  @override
  String get yourBookshelf => 'Ваша книжная полка';

  @override
  String get text_1782026184579 => '字';

  @override
  String get searchYourDictionary => 'Искать в словаре...';

  @override
  String get saveCard => 'Сохранить карточку';

  @override
  String get noCharactersFound => 'Символов не найдено.';

  @override
  String get radicalsIndex => 'Индекс радикалов';

  @override
  String get masteringRadicalsIsThe =>
      'Освоение радикалов является ключом к разблокировке тысяч ханьцзы. Выберите радикал, чтобы увидеть все символы, которые его используют.';

  @override
  String get noRadicalsFound => 'Радикалов не найдено.';

  @override
  String get yourDrawing => 'Ваш рисунок';

  @override
  String get reference => 'Справка';

  @override
  String get rateYourRecall => 'Оцените свое запоминание';

  @override
  String get contactUs => 'Свяжитесь с нами';

  @override
  String get reportBugsOrRequest => 'Сообщить об ошибках или запросить функции';

  @override
  String get allDataHasBeen => 'Все данные были удалены.';

  @override
  String get hanziMasterV100 => 'SinoSpark v1.0.0';

  @override
  String get myProgress => 'Мой прогресс';

  @override
  String get overview => 'Обзор';

  @override
  String get aiStory => 'История ИИ';

  @override
  String get usingYourDecksVocabulary =>
      'Используя словарный запас вашей колоды';

  @override
  String get tryAgain => 'Попробовать снова';

  @override
  String get translate => 'Перевести';

  @override
  String get pinyin => 'Пиньинь';

  @override
  String get fullTranslation => 'Полный перевод';

  @override
  String get geminiFlashIsStructuring =>
      'Gemini Flash структурирует вашу историю...';

  @override
  String get aiDeckGenerator => 'Генератор колод ИИ';

  @override
  String get whatDoYouWant => 'Что вы хотите изучить?';

  @override
  String get targetDifficulty => 'Целевая сложность';

  @override
  String get focusArea => 'Область внимания';

  @override
  String get specificContextOrTone => 'Особый контекст или тон (необязательно)';

  @override
  String get numberOfCards => 'Количество карточек';

  @override
  String get generateDeck => 'Сгенерировать колоду';

  @override
  String get aiGrammarExplanation => 'Объяснение грамматики ИИ';

  @override
  String get scholarsDesk => 'Стол ученого';

  @override
  String get chooseADeck => 'Выберите колоду';

  @override
  String get whereWouldYouLike => 'Куда вы хотите сохранить этот символ?';

  @override
  String get addToDefaultStudy => 'Добавить в колоду изучения по умолчанию';

  @override
  String get ifOffItsOnly =>
      'Если выключено, сохраняется только в глобальный словарь';

  @override
  String get saveToLibrary => 'Сохранить в библиотеку';

  @override
  String get pleaseEnterValidChinese =>
      'Пожалуйста, введите действительные китайские иероглифы';

  @override
  String get reviewAiCard => 'Просмотреть карточку ИИ';

  @override
  String get pleaseDoublecheckTheAis =>
      'Пожалуйста, перепроверьте вывод ИИ ниже. Вы можете изменить пиньинь или определение, прежде чем сохранить его в свою постоянную библиотеку.';

  @override
  String get alreadyInYourLibrary => 'Уже в вашей библиотеке!';

  @override
  String get meaningInContext => 'Значение в контексте';

  @override
  String get explainGrammar => 'Объяснить грамматику';

  @override
  String get addToLibrary => 'Добавить в библиотеку';

  @override
  String get masterYourMandarinPronunciation =>
      'Освойте произношение мандаринского наречия, имитируя речь носителей в реальном времени.';

  @override
  String get startSession => 'НАЧАТЬ СЕССИЮ';

  @override
  String get sessionHistory => 'История сессий';

  @override
  String get noSavedSessions => 'Нет сохраненных сессий.';

  @override
  String get aiBreakdown => 'Разбор ИИ';

  @override
  String get sessionDetails => 'Детали сессии';

  @override
  String get partner => 'Партнер ((lang))';

  @override
  String get youEnglish => 'Вы (английский)';

  @override
  String get noTranscriptToSave => 'Нет стенограммы для сохранения!';

  @override
  String get sessionSaved => 'Сессия сохранена!';

  @override
  String get realtimeBidirectionalTranslationSpeak =>
      'Двунаправленный перевод в реальном времени. Говорите по-английски или на мандаринском, и он мгновенно переведет для вас и вашего партнера.';

  @override
  String get text_1782026184665 => '录音中';

  @override
  String get recording => 'Запись';

  @override
  String get yourSilentCompanionListen =>
      'Ваш безмолвный спутник. Слушайте мандаринский, и мгновенно услышите английский перевод.';

  @override
  String get startListening => 'НАЧАТЬ ПРОСЛУШИВАНИЕ';

  @override
  String get skip => 'Пропустить';

  @override
  String get independentStars => 'НЕЗАВИСИМЫЕ ЗВЁЗДЫ';

  @override
  String get notEveryCharacterHas =>
      'Не каждый символ имеет родительский радикал. Некоторые являются уникальными пиктограммами или стоят отдельно.';

  @override
  String get onTheMapWe =>
      'На карте мы группируем эти независимые символы в СОЗВЕЗДИЯ (✨).';

  @override
  String get iUnderstand => 'Я ПОНИМАЮ';

  @override
  String get whatAreRadicals => 'ЧТО ТАКОЕ РАДИКАЛЫ?';

  @override
  String get hanziAreBuiltFrom =>
      'Ханьцзы строятся из строительных блоков, называемых РАДИКАЛАМИ.\\n\\nОни дают символу его основное значение или тему.';

  @override
  String get continueText => 'ПРОДОЛЖИТЬ';

  @override
  String get hanziAreNotJust =>
      'Ханьцзы — это не просто буквы. Это картины, застывшие во времени.\\n\\nЧтобы освоить их, вы должны научиться отслеживать их поток.';

  @override
  String get iAmReady => 'Я ГОТОВ';

  @override
  String get youAreAScholar => 'ВЫ – УЧЕНЫЙ';

  @override
  String get theGalaxyMapAwaitsnmaster =>
      'Карта Галактики ждет.\\nПокорите Солнца (Радикалы), чтобы разблокировать Планеты (Символы).';

  @override
  String get enterTheScroll => 'ВОЙТИ В СВИТОК';

  @override
  String get openingTheOriginScroll => 'Открытие Свитка Происхождения...';

  @override
  String get text_1782026184670 => '+';

  @override
  String get theScholarsEdition => 'Издание Ученого';

  @override
  String get weArePreparingThe => 'Мы готовим издание Ученого к запуску.';

  @override
  String get devBypassUnlockNow => 'DEV ОБХОД: РАЗБЛОКИРОВАТЬ СЕЙЧАС';

  @override
  String get restorePurchases => 'Восстановить покупки';

  @override
  String get welcomeScholarTheScroll =>
      'Добро пожаловать, Ученый. Свиток полностью открыт для вас.';

  @override
  String get purchasesRestoredSuccessfully => 'Покупки успешно восстановлены.';

  @override
  String get noPreviousPurchasesFound =>
      'На этом аккаунте не найдено предыдущих покупок.';

  @override
  String get unlockTheFullPotential =>
      'Раскройте весь потенциал своего путешествия. Единовременная покупка, ваша навсегда.';

  @override
  String get universalScanner => 'Универсальный сканер';

  @override
  String get noChineseCharactersFound =>
      'На изображении не найдено китайских иероглифов.';

  @override
  String get addedNewCharactersTo =>
      'Добавлены новые символы в вашу библиотеку!';

  @override
  String get extractingTextAndObjects => 'Извлечение текста и объектов...';

  @override
  String get scanATextbookSign =>
      'Сканируйте учебник, вывеску или объект, чтобы извлечь китайские иероглифы.';

  @override
  String get extractedText => 'Извлеченный текст';

  @override
  String get useText => 'Использовать текст';

  @override
  String get noMatchingDictionaryEntries =>
      'Соответствующих словарных записей не найдено.';

  @override
  String get quizComplete => 'Викторина завершена!';

  @override
  String get returnToCourse => 'Вернуться к курсу';

  @override
  String get notEnoughCardsFor =>
      'Недостаточно карточек для викторины! Нужно как минимум 4.';

  @override
  String get creatorMode => 'Режим создателя';

  @override
  String get noStoriesFoundMatching =>
      'Историй, соответствующих вашему поиску, не найдено.';

  @override
  String get discard => 'Отменить';

  @override
  String get save => '保存';

  @override
  String get generatingStoryViaDeepseek =>
      'Генерация истории через DeepSeek...';

  @override
  String get storySavedToLibrary => 'История сохранена в библиотеку!';

  @override
  String get storyNotFound => 'История не найдена.';

  @override
  String get targetHskLevel => 'Целевой уровень HSK';

  @override
  String get wedLoveToHear => 'Мы будем рады услышать вас!';

  @override
  String get whetherYouveFoundA =>
      'Нашли ли вы ошибку, есть ли у вас запрос на функцию или просто хотите поздороваться – ваш отзыв помогает нам улучшать SinoSpark.';

  @override
  String get pointYourCameraAt => 'Наведите камеру на объекты';

  @override
  String get reviewAddToLibrary => 'Просмотреть и добавить в библиотеку';

  @override
  String get hideStrokeGuideStreak =>
      'Скрыть направляющую штрихов при серии из (streak)';

  @override
  String get inkPoints => '(points) Чернильных Очков';

  @override
  String get speechRateMultiplier => '(rate)x';

  @override
  String get animationSpeedMultiplier => '(rate)x';

  @override
  String get supportAndFeedback => 'Поддержка и Обратная связь';

  @override
  String get reportBug => 'Сообщить об ошибке';

  @override
  String get suggestFeature => 'Предложить функцию';

  @override
  String get generalFeedback => 'Общая обратная связь';

  @override
  String get pleaseDrawSomethingFirst =>
      'Пожалуйста, сначала что-нибудь нарисуйте';

  @override
  String get drawThisCharacter => 'Нарисуйте этот символ:';

  @override
  String get followGuideStroke =>
      'Следуйте синей линии, чтобы нарисовать штрих (current) из (total)';

  @override
  String get skipCurrentStroke => 'Пропустить текущий штрих';

  @override
  String get submitDrawing => 'Отправить рисунок';

  @override
  String get addedToDeck => 'Добавлено (hanzi) в колоду (deckName)';

  @override
  String get removedFromDeck => 'Удалено (hanzi) из колоды';

  @override
  String get skippedNoStrokeData =>
      'Пропущено \"(hanzi)\" – Нет данных о штрихах для этого ИИ-символа.';

  @override
  String get startingSession => 'Начало сессии...';

  @override
  String get masterBuildingBlocks => 'Освойте строительные блоки иероглифов';

  @override
  String get totalWords => 'Всего слов';

  @override
  String get newInk => 'Новые чернила';

  @override
  String get learningStatus => 'Изучается';

  @override
  String get masteredStatus => 'Освоено';

  @override
  String get libraryMastery => 'Количество освоенных в библиотеке';

  @override
  String get accuracyByMode => 'Точность по режиму';

  @override
  String get upcomingReviews => 'Предстоящие Просмотры (Следующие 7 Дней)';

  @override
  String get culturalReadingRoom => '文化书房 (Культурный Читальный Зал)';

  @override
  String get storyTitleHsk => '(title) (HSK (level))';

  @override
  String get pleaseEnterTopic => 'Пожалуйста, введите тему';

  @override
  String get createdDeckCards => 'Создана колода (name) с (count) карточками!';

  @override
  String get gradeResult => 'Оценка: (grade)';

  @override
  String get listeningMode => 'Режим аудирования';

  @override
  String get readingMode => 'Режим чтения';

  @override
  String get recallMode => 'Режим повторения';

  @override
  String get speakingMode => 'Режим говорения';

  @override
  String get aiMemoryHook => 'Крючок памяти ИИ';

  @override
  String get exampleSentences => 'Примеры предложений';

  @override
  String get ghostCharacters => 'Призрачные символы';

  @override
  String get commonWords => 'Общие слова';

  @override
  String get personalNotes => 'Личные заметки';

  @override
  String get addPersonalNotes =>
      'Добавьте свои мнемонические правила или заметки здесь...';

  @override
  String get takePhoto => 'Сделать фото';

  @override
  String get gallery => 'Галерея';

  @override
  String get arLens => 'AR-линза';

  @override
  String get addedCharToLibrary => '(char) добавлен в библиотеку';

  @override
  String get scoreText => 'баллы';

  @override
  String get searchDictionaryHint =>
      'Поиск по иероглифу, пиньинь или значению...';

  @override
  String get searchDeckHint => 'Поиск по иероглифу, пиньинь...';

  @override
  String get localRestaurant => 'Местный ресторан';

  @override
  String get taxiToAirport => 'Такси в аэропорт';

  @override
  String get silkMarketHaggling => 'Торг на Шелковом рынке';

  @override
  String get medicalClinic => 'Медицинская клиника';

  @override
  String get meetingAFriend => 'Встреча с другом';

  @override
  String get jobInterview => 'Собеседование';

  @override
  String get searchRadicalsHint => 'Поиск радикалов (напр. Вода, 氵)';

  @override
  String get definition => 'Определение';

  @override
  String get undo => 'ОТМЕНИТЬ';

  @override
  String get hanziMaster => 'SinoSpark';

  @override
  String get unlockForever => 'Разблокировать навсегда — .99';

  @override
  String get clear => 'Очистить';

  @override
  String get clearChat => 'Очистить чат';

  @override
  String get typeMessage => 'Введите сообщение...';

  @override
  String get addedToLibrary => 'Добавлено «(hanzi)» в вашу библиотеку';

  @override
  String get generateNewStory => 'Создать новую историю';

  @override
  String get failedToGenerateStory =>
      'Не удалось сгенерировать историю:\\n(error)';

  @override
  String get detail => 'Деталь';

  @override
  String get scanText => 'Сканировать текст';

  @override
  String get createMagic => 'Создать магию';

  @override
  String get learning => 'Обучение';

  @override
  String get upcomingReviews7Days =>
      'Предстоящие повторения (следующие 7 дней)';

  @override
  String get askFollowUpQuestion => 'Задайте дополнительный вопрос...';

  @override
  String get pasteScanToSimplify =>
      'Вставьте или отсканируйте китайский текст для упрощения';

  @override
  String get searchStoriesHint =>
      'Поиск историй по названию или тегам (например, мифология, путешествия)';

  @override
  String get importAll => 'Импортировать всё';

  @override
  String get ascendAll => 'Возвысить все';

  @override
  String get startAscension => 'Начать восхождение';

  @override
  String get scenarioLocalRestaurant => 'Местный ресторан';

  @override
  String get scenarioLocalRestaurantDesc =>
      'Попрактикуйтесь в заказе блюд и запросе рекомендаций.';

  @override
  String get scenarioTaxiAirport => 'Такси в аэропорт';

  @override
  String get scenarioTaxiAirportDesc =>
      'Сообщите водителю пункт назначения и обсудите дорожное движение.';

  @override
  String get scenarioSilkMarket => 'Торг на Шелковом рынке';

  @override
  String get scenarioSilkMarketDesc =>
      'Попытайтесь получить лучшую цену на сувенир.';

  @override
  String get scenarioMedicalClinic => 'Медицинская клиника';

  @override
  String get scenarioMedicalClinicDesc =>
      'Объясните свои симптомы традиционному доктору.';

  @override
  String get scenarioMeetingFriend => 'Встреча с другом';

  @override
  String get scenarioMeetingFriendDesc =>
      'Представьтесь и поговорите о пустяках.';

  @override
  String get scenarioJobInterview => 'Собеседование';

  @override
  String get scenarioJobInterviewDesc =>
      'Подайте заявку на должность в технологической компании в Шанхае.';

  @override
  String get createCustomScenario => 'Создать пользовательский сценарий';

  @override
  String get customScenarioTitleHint => 'Название (например, Свадебный прием)';

  @override
  String get customScenarioDescHint => 'Описание (Контекст)';

  @override
  String get customScenarioPersonaHint =>
      'Личность ИИ (например, Любопытный коллега)';

  @override
  String get customScenarioDifficulty => 'Сложность';

  @override
  String get createAction => 'Создать';

  @override
  String get cancelAction => 'Отмена';

  @override
  String get mythsAndLegends => 'Мифы и легенды';

  @override
  String get historyAndCulture => 'История и культура';

  @override
  String get idiomsTitle => 'Идиомы (成语)';

  @override
  String get theMonkeyKing => 'Король обезьян';

  @override
  String get theMonkeyKingDesc => 'Сунь Укун (Путешествие на Запад)';

  @override
  String get huaMulan => 'Хуа Мулань';

  @override
  String get huaMulanDesc => 'Хуа Мулань идет в армию вместо отца';

  @override
  String get confuciusTitle => 'Конфуций';

  @override
  String get confuciusDesc => 'Жизнь и учения Конфуция';

  @override
  String get theGreatWall => 'Великая стена';

  @override
  String get theGreatWallDesc => 'Строительство Великой Китайской стены';

  @override
  String get generateTopic => 'Сгенерировать тему';

  @override
  String get simplifyText => 'Упростить текст';

  @override
  String get topicHint => 'Тема (например, Инопланетяне в Пекине)';

  @override
  String get tagsHint => 'Теги (через запятую, необязательно)';

  @override
  String get speakWithMasterLin => 'Поговорите с Мастером Лином';

  @override
  String get masterLinGreeting =>
      'Приветствую, студент. Чернила готовы. Какой иероглиф или фразу мы сегодня рассмотрим?';

  @override
  String get typeYourMessage => 'Напишите свое сообщение...';

  @override
  String get theMainLibrary => 'Главная библиотека';

  @override
  String get hsk1Foundation => 'HSK 1: Основы';

  @override
  String get hsk2Elementary => 'HSK 2: Начальный';

  @override
  String get hsk3Intermediate => 'HSK 3: Средний';

  @override
  String get inDeckCheck => 'В колоде ✓';

  @override
  String get addToDeckPlus => '+ В колоду';

  @override
  String get openCardArrow => 'Открыть карточку →';

  @override
  String get pronunciationPartial => 'Неточное произношение';

  @override
  String get pronunciationWrong => 'Неправильно';

  @override
  String get toneExpected => 'Ожидалось';

  @override
  String get toneYouSaid => 'Вы сказали';

  @override
  String get gotIt => 'Понятно!';

  @override
  String foundNCharacters(int count) {
    return 'Найдено (count) иероглифов';
  }

  @override
  String get lookingUpCharacters => 'Поиск иероглифов…';

  @override
  String get practiceAll => 'Практиковать всё';

  @override
  String get arLensObjects => 'Объекты';

  @override
  String get arLensText => 'Текст';

  @override
  String get arLensDetectedText => 'Обнаруженный текст';

  @override
  String get duration12Min => '1-2 мин';

  @override
  String get aClassicTangDynastyPoem =>
      'Классическое стихотворение династии Тан';

  @override
  String get aClassicTangDynastyPoemBy =>
      'Классическое стихотворение династии Тан, автор';

  @override
  String get aStructuralComponent => 'Структурный компонент.';

  @override
  String get addSelectedToDeck => 'Добавить выбранное в колоду';

  @override
  String get addTo => 'Добавить в ';

  @override
  String addedHanziToYourLibrary(String hanzi) {
    return 'Добавлено \'$hanzi\' в вашу библиотеку';
  }

  @override
  String get adjustFontSize => 'Настроить размер шрифта';

  @override
  String get againGoodEasyHard =>
      '⬅️ Снова    ➡️ Хорошо    ⬆️ Легко    ⬇️ Сложно';

  @override
  String get aiAnalysisFailed => 'Ошибка AI-анализа';

  @override
  String get aiIsThinking => 'AI думает...';

  @override
  String get aiSceneAnalysisFailed => 'Ошибка анализа сцены AI';

  @override
  String get allLabel => 'Все';

  @override
  String get allPinyin => 'Все Pinyin';

  @override
  String get alreadyHaveAccountSignIn => 'Уже есть аккаунт? Войти';

  @override
  String get analysisFailed => 'Ошибка анализа:';

  @override
  String get analyzingClassicalCharacters =>
      'Анализ классических иероглифов...';

  @override
  String get anatomy => 'Анатомия';

  @override
  String get ancientPhilosophy => 'Древняя философия';

  @override
  String get articleSavedToMediaHub => 'Статья сохранена в Media Hub!';

  @override
  String get askAFollowUp => 'Задать уточняющий вопрос...';

  @override
  String get audioPrivacyAndHowThingsWork =>
      'Аудио, конфиденциальность и как это работает';

  @override
  String get audiobookPlayer => 'Аудиоплеер';

  @override
  String get audiobookVoice => 'Голос аудиокниги';

  @override
  String get auntieMaTown =>
      'Тётушка Ма (马阿姨), энергичная и громкая владелица ларька, которая готовит самые хрустящие жоуцзямо и лянпи в городе.';

  @override
  String get back => 'Назад';

  @override
  String get baristaKevinNotes =>
      'Бариста Кевин (小凯), страстный молодой обжарщик кофе, который любит обсуждать кофейные зёрна Юньнани и вкусовые ноты.';

  @override
  String get bbc => 'BBC 中文网';

  @override
  String get beginYourJourney => 'Начни свой путь';

  @override
  String get bestValue => 'Лучшее соотношение цены и качества';

  @override
  String get bookLinkCopiedToClipboard =>
      'Ссылка на книгу скопирована в буфер обмена!';

  @override
  String get bookmarkChapter => 'Добавить закладку главы';

  @override
  String get bookmarks => 'Закладки';

  @override
  String get books => 'Книги';

  @override
  String get briefing => 'Брифинг';

  @override
  String get bugReport => 'Сообщить об ошибке';

  @override
  String get caoXueqinDecline =>
      'Цао Сюэцинь (ок. 1715–1763) — писатель эпохи Цин, родившийся в когда-то богатой семье знамённых, чьё состояние рухнуло при императоре Юнчжэне. «Сон в красном тереме», написанный в его нищие последние годы, считается вершиной китайской прозы — обширный, психологически богатый эпос об упадке аристократии.';

  @override
  String get cardsTitle => 'КАРТОЧКИ';

  @override
  String get cc => 'Субтитры';

  @override
  String get characterOrWord => 'Иероглиф / Слово';

  @override
  String get chatMore => 'Продолжить чат';

  @override
  String get chefChenShumai =>
      'Шеф-повар Чэнь (陈师傅), весёлый кантонский мастер димсамов, рекомендует свежие креветочные пельмени харгау и шумай.';

  @override
  String get chineseEpics => 'Китайский эпос';

  @override
  String get chinesePoetry => 'Китайская поэзия';

  @override
  String get chng => 'chéng';

  @override
  String get chongqingSpicyHotpotFeast => 'Пикантный пир хого в Чунцине';

  @override
  String get chooseAudiobookVoice => 'Выберите голос аудиокниги';

  @override
  String get chooseVoice => 'Выберите голос';

  @override
  String get compare => 'Сравнить';

  @override
  String get compare4Tones => 'Сравнить 4 тона';

  @override
  String get configuration => 'Конфигурация';

  @override
  String get contemporary => 'Современное';

  @override
  String get context => 'Контекст';

  @override
  String get couldNotLoadLibrary => 'Не удалось загрузить библиотеку';

  @override
  String get couldNotLoadVocabulary => 'Не удалось загрузить словарь.';

  @override
  String get couldNotOpenEmailApp => 'Не удалось открыть почтовое приложение.';

  @override
  String get createAccount => 'Создать аккаунт';

  @override
  String get createNewDeck => 'Создать новую колоду';

  @override
  String get createScenario => 'Создать сценарий';

  @override
  String get createStory => 'Создать историю';

  @override
  String get customLabel => 'Пользовательское';

  @override
  String get customWord => 'Пользовательское слово';

  @override
  String get days => 'дн.';

  @override
  String get deck => 'Колода';

  @override
  String get deckName => 'Название колоды';

  @override
  String get deckStory => 'История колоды';

  @override
  String get deepAnalysis => 'Глубокий анализ';

  @override
  String get defaultDeck => 'Колода по умолчанию';

  @override
  String get deleteLabel => 'Удалить';

  @override
  String get deleteScenario => 'Удалить сценарий';

  @override
  String get deletesAllProgressPermanently => 'Навсегда удаляет весь прогресс';

  @override
  String get developerBackdoorUnlocked => 'Чёрный ход разработчика открыт!';

  @override
  String get doesNotExistInChinese => 'Не существует в китайском языке';

  @override
  String get dontHaveAccountSignUp => 'Нет аккаунта? Зарегистрироваться';

  @override
  String get draftingStoryOutline => 'Составление плана истории...';

  @override
  String get dynamicFlowState => 'Динамическое состояние потока';

  @override
  String get dynamicFlowStateParenthetical => 'Динамический (состояние потока)';

  @override
  String get editCard => 'Редактировать карточку';

  @override
  String get egAnimeVocab => 'Напр., лексика аниме';

  @override
  String get egFormalBusinessLanguageSlangForTexting =>
      'напр., официальный деловой язык, сленг для переписки...';

  @override
  String get egOrderingAtARestaurantBusinessVocab =>
      'напр., заказ в ресторане, деловая лексика...';

  @override
  String get egWeddingReceptionTechInterview =>
      'напр., свадебный приём, техническое собеседование...';

  @override
  String get emailLabel => 'Эл. почта';

  @override
  String get english => 'Английский';

  @override
  String get englishAndWorld => 'Английский и мир';

  @override
  String get episodes => 'эпизоды';

  @override
  String get erase => 'Стереть';

  @override
  String get eraseDeckQuestion => 'Стереть колоду?';

  @override
  String errorFetchingTranslationForLabelE(String label, String e) {
    return 'Ошибка получения перевода для $label: $e';
  }

  @override
  String errorLoadingMicroreadsE(String e) {
    return 'Ошибка загрузки микро-чтений: $e';
  }

  @override
  String errorLoadingNovelsE(String e) {
    return 'Ошибка загрузки романов: $e';
  }

  @override
  String errorLoadingPoetryE(String e) {
    return 'Ошибка загрузки поэзии: $e';
  }

  @override
  String get exitFocus => 'Выйти из фокуса';

  @override
  String get explore => 'Исследовать';

  @override
  String get exportToThisDeck => 'Экспортировать в эту колоду';

  @override
  String get extractAndSimplify => 'Извлечь и упростить';

  @override
  String get failedToCreateDeck => 'Не удалось создать колоду';

  @override
  String get failedToLoadDailyContent =>
      'Не удалось загрузить ежедневный контент';

  @override
  String get failedToLoadEpisodes => 'Не удалось загрузить эпизоды';

  @override
  String get failedToLoadShows => 'Не удалось загрузить шоу';

  @override
  String get finalizingDetails => 'Завершение деталей...';

  @override
  String get finalizingStoryDetails => 'Завершение деталей истории...';

  @override
  String get firebaseAuthConsole =>
      'Firebase Auth не включён. Пожалуйста, включите необходимый метод входа в консоли Firebase.';

  @override
  String get flashcardDeckTitle => 'КОЛОДА КАРТОЧЕК';

  @override
  String get focus => 'Фокус';

  @override
  String get foodAndCooking => 'Еда и кулинария';

  @override
  String get forward => 'Вперёд';

  @override
  String get freeFlow => 'Свободный поток';

  @override
  String get frenchClassics => 'Французская классика';

  @override
  String get full => 'Полный';

  @override
  String get gamingAndEsports => 'Игры и киберспорт';

  @override
  String get germanClassics => 'Немецкая классика';

  @override
  String get ghostPinyin => 'Призрачный Pinyin';

  @override
  String get goodAttempt => 'Хорошая попытка';

  @override
  String get gotItSimple => 'Понял(а)';

  @override
  String get grammar => 'Грамматика';

  @override
  String get grandmaLiuFilling =>
      'Бабушка Лю (刘奶奶), любящая северная бабушка, которая учит лепить пельмени и делать свино-луковую начинку.';

  @override
  String get great => 'Отлично!';

  @override
  String get handmadeDumplingFeastInHarbin =>
      'Пир домашних пельменей в Харбине';

  @override
  String get hanziCharacter => 'Hanzi (иероглиф)';

  @override
  String get hapticFeedback => 'Тактильная обратная связь';

  @override
  String get helpAndSupport => 'Помощь и поддержка';

  @override
  String get hidden => 'Скрытое';

  @override
  String get hideEnglishTranslations => 'Скрыть английские переводы';

  @override
  String get hidePinyin => 'Скрыть Pinyin';

  @override
  String get highlight => 'ВЫДЕЛИТЬ';

  @override
  String get howWouldYouLikeToStudy => 'Как бы вы хотели учиться?';

  @override
  String get hsk1 => 'HSK 1';

  @override
  String get hsk4UpperIntermediate => 'HSK 4: Средне-продвинутый';

  @override
  String get hsk5Advanced => 'HSK 5: Продвинутый';

  @override
  String get hsk6Mastery => 'HSK 6: Свободное владение';

  @override
  String get hskCollections => 'Коллекции HSK';

  @override
  String hskLevel(String level) {
    return 'HSK $level';
  }

  @override
  String get hskSimplifySubtitles => 'HSK упрощение субтитров';

  @override
  String get hskVocabularyCollections => 'Коллекции лексики HSK';

  @override
  String get i => 'Я';

  @override
  String get ifTheAgain =>
      'Если AI обнаружит несоответствие, он спросит: «Вы имели в виду...?» Вы можете нажать кнопку «Да, переоценить!», чтобы мгновенно переоценить вашу оригинальную аудиозапись в соответствии с вашим истинным намерением, не говоря снова.';

  @override
  String get install => 'Установить';

  @override
  String get just => 'Всего';

  @override
  String get keyword => 'ключевое слово';

  @override
  String get knowledgeBase => 'База знаний';

  @override
  String get liRuzhenSubjects =>
      'Ли Жучжэнь (ок. 1763–1830) — учёный эпохи Цин с глубокими познаниями в фонологии, шахматах и космологии. «Цветы в зеркале», его фантастический роман о путешествии купца по невозможным королевствам, примечателен феминистскими темами и энциклопедическим охватом предметов.';

  @override
  String get library => 'æ–‡åŒ–ä¹¦æˆ¿ Библиотека';

  @override
  String get lifestyleAndVlog => 'Образ жизни и влог';

  @override
  String get listenInAudiobookMode => 'Слушать в режиме аудиокниги';

  @override
  String get listenToThisWord => 'Прослушать это слово';

  @override
  String get listening => 'Слушаю...';

  @override
  String get liuEEncroachment =>
      'Лю Э (1857–1909) — позднецинский эрудит — инженер, врач и писатель, чей единственный роман «Путешествие Лао Цаня» представляет собой лиричный, но политически заряженный путевой дневник странствующего целителя, путешествующего по Китаю в разгар династического упадка и иностранного вторжения.';

  @override
  String get loadingTranslations => 'Загрузка переводов...';

  @override
  String get luXunVernacular =>
      'Лу Синь (1881–1936), псевдоним Чжоу Шужэня, — отец современной китайской литературы. Врач, переключившийся на писательство, чтобы исцелить китайский дух, его сборники рассказов — «Записки сумасшедшего» и «Подлинная история А Q» — использовали разговорный язык';

  @override
  String get luoGuanzhongEpic =>
      'Ло Гуаньчжун (ок. 1330–1400) — драматург и писатель переходного периода от Юань к Мин, предположительно учившийся у Ши Найаня. Его «Троецарствие» синтезировало исторические хроники, устную традицию и драматическое повествование в определяющий китайский исторический эпос.';

  @override
  String get makeACustomCollection => 'Создать свою коллекцию';

  @override
  String get manageDailyDropsAndReviewReminders =>
      'Управление ежедневными порциями и напоминаниями о повторении';

  @override
  String get managerYuOptions =>
      'Менеджер Юй (余店长), энергичный менеджер ресторана хого, рекомендует фирменные требуху, утиную кровь и варианты нежного бульона.';

  @override
  String get masterGaoRubs =>
      'Мастер Гао (高师傅), харизматичный мастер гриля на углях, шутит с клиентами об уровне остроты и секретных приправах с тмином.';

  @override
  String get masterThisToUnlockItsGalaxy =>
      'Освойте это, чтобы разблокировать его галактику.';

  @override
  String get masterZhaoBrewing =>
      'Мастер Чжао (赵师傅), терпеливый и знающий чайный сомелье, который любит объяснять искусство заваривания чая Гунфу.';

  @override
  String get mastery => 'Мастерство';

  @override
  String get maybeLater => 'Может, позже';

  @override
  String get memes => 'Мемы';

  @override
  String get midnightBbqSkewersInWuhan => 'Полуночные шашлычки в Ухане';

  @override
  String get mo => '/мес';

  @override
  String get modernChinese => 'Современный китайский';

  @override
  String get monthly => 'Ежемесячно';

  @override
  String get morningDimSumCartInGuangzhou =>
      'Утренняя тележка с димсамами в Гуанчжоу';

  @override
  String get nameLabel => 'Имя';

  @override
  String get native => 'Родной';

  @override
  String get newCard => 'Новая карточка';

  @override
  String get newDeck => 'Новая колода';

  @override
  String get newDeckName => 'Новое название колоды';

  @override
  String get noActiveSubscriptionFound => 'Активная подписка не найдена.';

  @override
  String get noEpisodesFound => 'Эпизоды не найдены';

  @override
  String get noKeyWordsFoundForThisStory =>
      'Для этой истории ключевые слова не найдены.';

  @override
  String get noLabel => 'Нет';

  @override
  String get noNewWordsFound => 'Новых слов не найдено!';

  @override
  String get noPinyin => 'Без Pinyin';

  @override
  String get noPremiumPackagesAvailable =>
      'На данный момент премиум-пакеты недоступны.';

  @override
  String noResultsFoundForSearchquery(String searchQuery) {
    return 'Результатов для \'$searchQuery\' не найдено';
  }

  @override
  String get noSavedArticlesYet => 'Сохранённых статей пока нет.';

  @override
  String get noShowsAvailable => 'Нет доступных шоу';

  @override
  String get noStoriesFound => 'Истории не найдены.';

  @override
  String get noWordsSelected => 'Слова не выбраны';

  @override
  String get notes => 'Заметки';

  @override
  String get notoserifsc => 'NotoSerifSC';

  @override
  String get objectivesTitle => 'ЦЕЛИ';

  @override
  String get openInYoutube => 'Открыть в YouTube';

  @override
  String get orderingHanddripCoffeeInShanghai => 'Заказ фильтр-кофе в Шанхае';

  @override
  String get orderingSugarcoatedHawsInWinterBeijing =>
      'Заказ сахарных ягод в зимнем Пекине';

  @override
  String partnerLang(String lang) {
    return 'Партнёр ($lang)';
  }

  @override
  String get partnerListening => 'Партнёр слушает...';

  @override
  String get partnerSpeaking => 'Партнёр говорит...';

  @override
  String get passwordLabel => 'Пароль';

  @override
  String get pause => 'Пауза';

  @override
  String get perfect => 'Идеально!';

  @override
  String get personalizedPathBasedOnDeck =>
      'Персонализированный путь на основе вашей колоды.';

  @override
  String get play => 'Воспроизвести (pinyin)';

  @override
  String get pleaseEnterMessageBeforeSending =>
      'Пожалуйста, введите сообщение перед отправкой.';

  @override
  String get practiceInRoleplay => 'Практиковаться в ролевой игре';

  @override
  String get practiceModes => 'Режимы практики';

  @override
  String get practicePronouncingWithAiGrading =>
      'Потренироваться в произношении этого слова с оценкой AI';

  @override
  String get preparingReadingInterface => 'Подготовка интерфейса чтения...';

  @override
  String get privacy => 'Конфиденциальность';

  @override
  String get privacyAndAudio => 'Конфиденциальность и аудио';

  @override
  String get puSonglingLiterature =>
      'Пу Сунлин (1640–1715) — писатель эпохи Цин, потративший десятилетия на составление «Странных историй из кабинета Ляо» после неоднократных провалов на императорских экзаменах. Его сверхъестественные истории о лисах-оборотнях, призраках и учёных остаются золотым стандартом китайской готической литературы.';

  @override
  String get qaFaq => 'Вопросы и ответы / FAQ';

  @override
  String get questsTitle => 'КВЕСТЫ';

  @override
  String get quickBookmarks => 'Быстрые закладки';

  @override
  String get radical => 'Ключ';

  @override
  String get ready => 'Готово';

  @override
  String get readyToInterpret => 'Готов к интерпретации';

  @override
  String get readyToStart => 'Готов начать.';

  @override
  String get recentBookmarks => 'Недавние закладки';

  @override
  String get refiningGrammar => 'Уточнение грамматики...';

  @override
  String get refresh => 'Обновить';

  @override
  String get removeFromSaved => 'Удалить из сохранённого';

  @override
  String get removeFromSavedScenarios => 'Удалить из сохранённых сценариев';

  @override
  String get removed => 'Удалено';

  @override
  String get requestPermissions => 'Запросить разрешения';

  @override
  String get rescind => 'Отозвать';

  @override
  String get restore => 'Восстановить';

  @override
  String get results => 'Результаты';

  @override
  String get resume => 'Продолжить';

  @override
  String get retry => 'Повторить';

  @override
  String get revenuecatError => 'Ошибка RevenueCat:';

  @override
  String revenuecatErrorE(String e) {
    return 'Ошибка RevenueCat: $e';
  }

  @override
  String get reviewExtractedDeck => 'Просмотреть извлечённую колоду';

  @override
  String get reviewIn => 'Повторить через';

  @override
  String get reviewingYourTones => 'Проверка ваших тонов...';

  @override
  String get saveAll => 'Сохранить всё';

  @override
  String get saveScenario => 'Сохранить сценарий';

  @override
  String get saveThisScenario => 'Сохранить этот сценарий';

  @override
  String get saved => 'Сохранено';

  @override
  String get scanAnother => 'Сканировать ещё';

  @override
  String get scenarioRemoved => 'Сценарий удалён';

  @override
  String get scenarioSavedFindInCustomTab =>
      'Сценарий сохранён! Найдите его на вкладке «Пользовательское».';

  @override
  String get score => 'Счет: (score) / (total)';

  @override
  String get searchByPinyinOrMeaning => 'Поиск по pinyin или значению...';

  @override
  String get searchByTitleOrTag => 'Поиск по названию или тегу...';

  @override
  String get searchDictionaryOrTypeCustom =>
      'Поиск в словаре или ввод пользовательского';

  @override
  String get searchHint => 'Поиск...';

  @override
  String get searchOrEnterUrl => 'Поиск или ввод URL';

  @override
  String get searchScenariosHint => 'Поиск сценариев...';

  @override
  String get searchStoriesIdiomsNews => 'Поиск историй, идиом, новостей...';

  @override
  String get searchTopicsEgCookingHistory =>
      'Поиск тем (напр., Кулинария, История)';

  @override
  String get seeAll => 'Смотреть всё';

  @override
  String get selectADeck => 'Выберите колоду';

  @override
  String get selectPracticeMode => 'Выберите режим практики';

  @override
  String get selectingHskVocabulary => 'Выбор лексики HSK...';

  @override
  String get send => 'Отправить';

  @override
  String get sendMessage => 'Отправить сообщение';

  @override
  String get serif => 'С засечками';

  @override
  String get shadow => 'Тень';

  @override
  String get shiNaianEpic =>
      'Ши Найань (ок. 1296–1372) — литератор эпохи Юань, который, как сообщается, сдал императорский экзамен, но выбрал жизнь учёного-отшельника. «Речные заводи», его шедевр о героических разбойниках и праведном восстании, установил архетип китайского военного эпоса.';

  @override
  String get showEnglish => 'Показать английский';

  @override
  String get showEnglishTranslations => 'Показать английские переводы';

  @override
  String get showHanzi => 'Показать Hanzi';

  @override
  String get showPinyin => 'Показать Pinyin';

  @override
  String get showTranslation => 'Показать перевод';

  @override
  String get shows => 'Шоу';

  @override
  String get signIn => 'Войти';

  @override
  String get simplifiedArticle => 'Упрощённая статья';

  @override
  String get simplifyingSubtitles => 'Упрощение субтитров...';

  @override
  String get sincereHonest => 'искренний; честный';

  @override
  String get sleepTimer => 'Таймер сна';

  @override
  String get smartDeck => 'Умная колода';

  @override
  String get spanishAndWorld => 'Испанский и мир';

  @override
  String get speaker => 'Динамик';

  @override
  String get spotifyStylePlayer => 'Плеер в стиле Spotify';

  @override
  String get storyBookmarkedInLibrary =>
      'История добавлена в закладки библиотеки!';

  @override
  String get streetFoodNightMarketInXian => 'Ночной рынок уличной еды в Сиане';

  @override
  String get strokes => 'Черты';

  @override
  String get studyCharacter => 'Изучать иероглиф';

  @override
  String get subtitleOpacity => 'Прозрачность субтитров';

  @override
  String get suggestion => 'Предложение';

  @override
  String get summary => 'Краткое содержание';

  @override
  String get supernaturalAndFolklore => 'Сверхъестественное и фольклор';

  @override
  String get swipeToGrade => 'Проведите для оценки:';

  @override
  String get tableOfContents => 'Содержание';

  @override
  String get tapToRetry => 'Нажмите, чтобы повторить';

  @override
  String get teaTastingInChengdu => 'Чайная дегустация в Чэнду';

  @override
  String get techAndGadgets => 'Технологии и гаджеты';

  @override
  String get terms => 'Условия';

  @override
  String get theGalaxyCharacters =>
      'Карта галактики ждёт.\nОсвойте Солнца (Ключи), чтобы разблокировать Планеты (Иероглифы).';

  @override
  String get theme => 'Тема';

  @override
  String get thinking => 'Думаю...';

  @override
  String get thisArticleCharacters =>
      'Эта статья содержит иероглифы традиционного китайского.';

  @override
  String get todaysWord => 'СЛОВО ДНЯ';

  @override
  String get togglePinyin => 'Переключить Pinyin';

  @override
  String get toggleTranslation => 'Переключить перевод';

  @override
  String get toneDoesNotExistInMandarin =>
      'Этот тон не существует в стандартном путунхуа.';

  @override
  String get toneGraph => 'График тона';

  @override
  String get traceLabel => 'Обводка';

  @override
  String get trailer => 'ТРЕЙЛЕР';

  @override
  String get translatingAndAddingPinyin => 'Перевод и добавление Pinyin...';

  @override
  String get translatingText => 'Перевод текста...';

  @override
  String get turnOn => 'Включить';

  @override
  String get typeHanziPinyinOrEnglish =>
      'Введите Hanzi, Pinyin или английский...';

  @override
  String get unknown2 => '游戏 实况 王者荣耀 原神';

  @override
  String get unknown3 => '中国 美食 菜谱';

  @override
  String get unknown4 => '中国 科技 测评';

  @override
  String get unrollingTheScroll => 'Разворачивание свитка...';

  @override
  String get upperIntermediate => 'Средне-продвинутый';

  @override
  String get vibrationsForInteractions => 'Вибрация для взаимодействий';

  @override
  String get video => 'Видео';

  @override
  String get viewAnswer => 'Показать ответ';

  @override
  String get viewAsList => 'Показать списком';

  @override
  String get viewBookmarks => 'Просмотр закладок';

  @override
  String get viewMyDrawing => 'Просмотреть мой рисунок';

  @override
  String get vlog => '中国 日常 vlog';

  @override
  String get voice => 'Голос:';

  @override
  String get web => 'Веб';

  @override
  String get wedLoveToHearFromYou => 'Мы будем рады\nуслышать вас.';

  @override
  String get welcomeBack => 'С возвращением';

  @override
  String get whatDoesThisMean => 'Что это значит?';

  @override
  String get whatHappensToMyChatHistory =>
      'Что происходит с моей историей чата?';

  @override
  String get whatIfAiMishears =>
      'Что если AI неправильно расслышал то, что я хотел сказать?';

  @override
  String get whichCharacterIs => 'Какой иероглиф:';

  @override
  String get wikipedia => 'Wikipedia';

  @override
  String get wordsSavedAndSrsScheduled =>
      'Слова сохранены и SRS запланированы!';

  @override
  String get writeYourMessageHere => 'Напишите ваше сообщение здесь...';

  @override
  String get wuChengenLiterature =>
      'У Чэнъэнь (ок. 1500–1582) — писатель эпохи Мин из Хуайаня, Цзянсу. Опираясь на десятилетия фольклора, буддийские аллегории и сатирическое остроумие, он сплёл мифологию паломничества эпохи Тан в «Путешествие на Запад» — одно из самых изобретательных и любимых произведений мировой литературы.';

  @override
  String get wuJingziClass =>
      'У Цзинцзы (1701–1754) — писатель эпохи Цин из Аньхоя, который отказался от унаследованного состояния и посвятил свою жизнь написанию «Неофициальной истории конфуцианцев» — едкого сатирического романа, обнажающего тщеславие, коррупцию и абсурд императорской экзаменационной системы и сословия учёных-чиновников.';

  @override
  String get xuZhonglinWarfare =>
      'Сюй Чжунлинь (расцвет — XVI–XVII вв.) — писатель эпохи Мин, которому приписывают составление «Возведения в ранг духов» (封神演义), монументального произведения мифологической фантастики, смешивающего историю Шан-Чжоу с даосской космологией, небесной бюрократией и героическими войнами.';

  @override
  String get yearly => 'Ежегодно';

  @override
  String get yesReGradeMe => 'Да, переоценить меня!';

  @override
  String get you => 'Вы ((lang))';

  @override
  String get youAreSpeaking => 'Вы говорите';

  @override
  String get youLabel => 'Вы';

  @override
  String youLang(String lang) {
    return 'Вы ($lang)';
  }

  @override
  String get youMustAccount =>
      'Вы должны принять Условия обслуживания и Политику конфиденциальности, чтобы создать аккаунт.';

  @override
  String get yourEchoModels =>
      'Ваши беседы Echo Hall хранятся локально на вашем устройстве, чтобы вы могли просматривать их в любое время. Мы не используем ваши личные разговоры для обучения наших моделей AI.';

  @override
  String get zhOnly => 'Только ZH';

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
    return 'Added (cardCount) cards to \"(deckName)\".';
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
    return 'Are you sure you want to permanently erase \"(deckName)\"? This action cannot be undone and will delete all cards inside it.';
  }

  @override
  String ask_about(String hanzi) {
    return 'Ask about (hanzi)...';
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
    return 'Created smart deck: \"(deckName)\" with (wordCount) words!';
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
  String get hsk => 'HSK (level)';

  @override
  String hsk_vocabulary(int hskLevel) {
    return 'HSK (hskLevel) vocabulary';
  }

  @override
  String get hsk_level => 'HSK LEVEL';

  @override
  String get intermediate => 'Intermediate';

  @override
  String get learning_stats => 'Статистика обучения';

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
  String get notification_settings => 'Настройки уведомлений';

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
  String get previous => 'Назад';

  @override
  String get question => 'Вопрос (current)/(total)';

  @override
  String remove_from_this_deck(String hanzi) {
    return 'Remove (hanzi) from this deck?';
  }

  @override
  String get revenuecat_error => 'RevenueCat Error: (error)';

  @override
  String get review_tomorrow => 'Review Tomorrow';

  @override
  String get roleplay => 'Roleplay';

  @override
  String saving_words_to(int wordCount, String deckName) {
    return 'Saving (wordCount) words to (deckName)...';
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
      'Просмотрите свою историю обучения и серии';

  @override
  String get what_is_shadowing_studio => 'What is Shadowing Studio?';

  @override
  String get words => '生词';

  @override
  String your_path_for_is_ready(String deckName) {
    return 'Your path for \'(deckName)\' is ready!';
  }

  @override
  String get you_said => '🗣️ You Said';

  @override
  String get vocabularyBatch => 'Пакет лексики (index)';

  @override
  String get yourDailyDropIsHere => 'Ваша Ежедневная Капля здесь! ✨';

  @override
  String get timeToReview => 'Время для повторения! 📚';

  @override
  String get neverMissAStroke => 'Никогда не пропускайте черту! 🖌️';

  @override
  String get yourTrialEndsTomorrow =>
      'Ваша пробная версия заканчивается завтра! ⏳';

  @override
  String get officialStandardVocabularyTiers =>
      'Официальные стандартные уровни лексики';

  @override
  String get failedToLoadCollections => 'Не удалось загрузить коллекции.';

  @override
  String get unnamedKey => '#(tag)';

  @override
  String get error => 'Ошибка: (error)';

  @override
  String get aiSmartContext => 'Умный контекст ИИ';

  @override
  String get aiSmartContextError => 'Ошибка умного контекста ИИ';

  @override
  String get downloadOfficialHskCollections =>
      'Загрузить официальные коллекции HSK';

  @override
  String get unableToLoadThisSection =>
      'Не удалось загрузить этот раздел. Пожалуйста, попробуйте снова.';

  @override
  String get translationLanguage => 'Язык перевода';

  @override
  String get dailyDrops => 'Ежедневные Капли';

  @override
  String get wordOfTheDayNews => 'Слово дня и новости';

  @override
  String get reviewReminders => 'Напоминания о повторении';

  @override
  String get flashcardsDueForReview => 'Флэш-карты, подлежащие повторению';

  @override
  String get dailyNewCards => 'Ежедневные новые карточки';

  @override
  String get dailyReviewLimit => 'Лимит ежедневных повторений';

  @override
  String get practiceMode => 'Режим тренировки';

  @override
  String get liziqi => 'Ли Цзыци: Шелковые цветы';

  @override
  String get theLifeOfGarlicTraditional =>
      'Жизнь чеснока - Традиционная китайская жизнь';

  @override
  String get graceMandarin50Phrases => 'Grace Mandarin: 50 фраз';

  @override
  String get essentialChinesePhrasesForBeginners =>
      'Основные китайские фразы для начинающих';

  @override
  String get makingBambooFurniture => 'Изготовление бамбуковой мебели';

  @override
  String get peppaPigChinese => 'Свинка Пеппа на китайском: Прятки';

  @override
  String get muddyPuddlesBeginnerFriendly => 'Грязные лужи - Для начинающих';

  @override
  String get mandarinCorner300Verbs => 'Mandarin Corner: 300 глаголов';

  @override
  String get mostCommonChineseVerbs =>
      'Самые распространенные китайские глаголы';

  @override
  String get graceMandarinOrderFood => 'Grace Mandarin: Заказ еды';

  @override
  String get howToOrderFoodIn => 'Как заказать еду в китайском ресторане';

  @override
  String get silkFlowersTraditionalCraft =>
      'Шелковые цветы - Традиционное ремесло';

  @override
  String get mandarinCorner =>
      'Mandarin Corner: Учим китайский - Посещение врача';

  @override
  String get goingToTheDoctorReal =>
      'Поход к врачу - Разговор из реальной жизни';

  @override
  String get hideAndSeekBeginnerFriendly => 'Прятки - Для начинающих';

  @override
  String get linGdp6 => 'Сяо Линь говорит: Почему рост ВВП составляет 6%';

  @override
  String get why6GdpGrowthEasy =>
      'Почему рост ВВП на 6% - Простая китайская экономика';

  @override
  String get bbcWorldNews => 'BBC 中文 (Мировые новости)';

  @override
  String get currentEventsInSimplifiedChinese =>
      'Текущие события на упрощенном китайском';

  @override
  String get baidu => 'Baidu';

  @override
  String get youtubeDesk => 'YOUTUBE DESK';

  @override
  String get interactiveTranscriptsShadowing =>
      'Интерактивные транскрипции и теневое повторение';

  @override
  String get showsDramas => 'ШОУ И ДРАМЫ';

  @override
  String get extractToDeck => 'Извлечь в колоду';

  @override
  String get autoSimplify => 'Автоматическое упрощение';

  @override
  String get rewriteThisArticleToMatch =>
      'Переписать эту статью в соответствии с вашим уровнем HSK';

  @override
  String get failedToSaveExtractedWords =>
      'Не удалось сохранить извлеченные слова: (error)';

  @override
  String get addToDeck => 'Добавить в колоду ((count))';

  @override
  String get dailyDiscoveryDrop => 'Ежедневный Сброс Открытий';

  @override
  String get smartSpacedRepetition => 'Умное интервальное повторение';

  @override
  String get trialProtectionAlert => 'Предупреждение о защите пробной версии';

  @override
  String get masteryLevel => 'Уровень мастерства';

  @override
  String get targetObjective => 'Цель';

  @override
  String get dailyPractice => 'Ежедневная практика';

  @override
  String get aiSpacedRepetition => 'Интервальное повторение с ИИ';

  @override
  String get iVeGrantedAccess => 'Я предоставил доступ';

  @override
  String get scanner => 'Сканер';

  @override
  String get interpreter => 'Интерпретатор';

  @override
  String get cards => '(count) карточек';

  @override
  String get nWaMendsTheHeavens => 'Нюйва чинит небеса';

  @override
  String get terracottaArmy => 'Терракотовая армия';

  @override
  String get forbiddenCity => 'Запретный город';

  @override
  String get aBlessingInDisguise => 'Нет худа без добра';

  @override
  String get drawingASnake => 'Рисование змеи';

  @override
  String get takingTheBulletTrain => 'Поездка на скоростном поезде';

  @override
  String get visitingTheDoctor => 'Посещение врача';

  @override
  String get orderingDumplings => 'Заказ пельменей';

  @override
  String get theTeaCeremony => 'Чайная церемония';

  @override
  String get chineseCalligraphy => 'Китайская каллиграфия';

  @override
  String get theGiantPanda => 'Большая панда';

  @override
  String get simplifiedText => 'Упрощенный текст';

  @override
  String get novels96 => 'Романы (96)';

  @override
  String get microReads => 'Микро-чтения';

  @override
  String get poetry => 'Поэзия';

  @override
  String get bookmarkRemoved => '书签已移除 · Закладка удалена';

  @override
  String get bookmarkAdded => '已添加书签 · Закладка добавлена: Глава (chapter)';

  @override
  String get readingVocabulary => 'Чтение и словарный запас';

  @override
  String get vocabularyBatchUnitindex1 => 'Набор слов \$(unitIndex + 1)';

  @override
  String get yourDailyDropIsHere1 => 'Ваша ежедневная подборка здесь! ✨';

  @override
  String get timeToReview1 => 'Пора повторять! 📚';

  @override
  String get neverMissAStroke1 => 'Не пропустите ни одного штриха! 🖌️';

  @override
  String get yourTrialEndsTomorrow1 =>
      'Ваша пробная версия заканчивается завтра! ⏳';

  @override
  String get hskCollections1 => 'Коллекции HSK';

  @override
  String get officialStandardVocabularyTiers1 =>
      'Официальные стандартные уровни словарного запаса';

  @override
  String get failedToLoadCollections1 => 'Не удалось загрузить коллекции.';

  @override
  String get ui__transcription => '\"\$_transcription\"';

  @override
  String get playPinyinwithtone => 'Воспроизвести \$pinyinWithTone';

  @override
  String get errorE => 'Ошибка: \$e';

  @override
  String get lookalikepinyin => '(\$(lookAlike.pinyin))';

  @override
  String get aiSmartContext1 => 'Умный контекст ИИ';

  @override
  String get aiSmartContextError1 => 'Ошибка умного контекста ИИ';

  @override
  String get errorErr => 'Ошибка: \$err';

  @override
  String get downloadOfficialHskCollections1 =>
      'Скачать официальные коллекции HSK';

  @override
  String get unableToLoadThisSectionPleaseTryAga =>
      'Не удалось загрузить этот раздел. Пожалуйста, попробуйте снова.';

  @override
  String get searchRadicalsEgWater => 'Поиск радикалов (напр. Вода, 氵)';

  @override
  String get ui__currentstrokeindex1totalstrokes =>
      '\$(_currentStrokeIndex + 1)/\$totalStrokes';

  @override
  String get translationLanguage1 => 'Язык перевода';

  @override
  String get appLanguage1 => 'Язык приложения';

  @override
  String get dailyDrops1 => 'Ежедневные подборки';

  @override
  String get wordOfTheDayNews1 => 'Слово дня и новости';

  @override
  String get reviewReminders1 => 'Напоминания о повторении';

  @override
  String get flashcardsDueForReview1 => 'Карточки для повторения';

  @override
  String get accuracyByMode1 => 'Точность по режиму';

  @override
  String get accuracytostringasfixed1 => '\$(accuracy.toStringAsFixed(1))%';

  @override
  String get upcomingReviewsNext7Days =>
      'Предстоящие повторения (следующие 7 дней)';

  @override
  String get explaining => 'Объяснение:';

  @override
  String get entryhanziEntrypinyin => '\$(entry.hanzi) [\$(entry.pinyin)]';

  @override
  String get dailyNewCards1 => 'Ежедневные новые карточки';

  @override
  String get dailyReviewLimit1 => 'Ежедневный лимит повторений';

  @override
  String get listeningMode1 => 'Режим аудирования';

  @override
  String get readingMode1 => 'Режим чтения';

  @override
  String get recallMode1 => 'Режим вспоминания';

  @override
  String get speakingMode1 => 'Режим говорения';

  @override
  String get practiceMode1 => 'Режим практики';

  @override
  String get acc => '\$acc%';

  @override
  String get partner1 => 'Партнер';

  @override
  String get partnerSpeaking1 => 'Партнер говорит…';

  @override
  String get theLifeOfGarlicTraditionalChineseLi =>
      'Жизнь чеснока - Традиционная китайская жизнь';

  @override
  String get graceMandarin50Phrases1 => 'Grace Mandarin: 50 фраз';

  @override
  String get essentialChinesePhrasesForBeginners1 =>
      'Основные китайские фразы для начинающих';

  @override
  String get makingBambooFurniture1 => 'Изготовление бамбуковой мебели';

  @override
  String get muddyPuddlesBeginnerFriendly1 => 'Грязевые лужи - Для начинающих';

  @override
  String get mandarinCorner300Verbs1 => 'Mandarin Corner: 300 глаголов';

  @override
  String get mostCommonChineseVerbs1 =>
      'Самые распространенные китайские глаголы';

  @override
  String get graceMandarinOrderFood1 => 'Grace Mandarin: Заказ еды';

  @override
  String get howToOrderFoodInAChineseRestaurant =>
      'Как заказать еду в китайском ресторане';

  @override
  String get silkFlowersTraditionalCraft1 =>
      'Шелковые цветы - Традиционное ремесло';

  @override
  String get goingToTheDoctorRealLifeConversatio =>
      'Посещение врача - Разговор из реальной жизни';

  @override
  String get hideAndSeekBeginnerFriendly1 => 'Прятки - Для начинающих';

  @override
  String get lingdp6 => 'Сяо Линь говорит: Почему ВВП вырос на 6%';

  @override
  String get why6GdpGrowthEasyChineseEconomics =>
      'Почему рост ВВП на 6% - Простая китайская экономика';

  @override
  String get currentEventsInSimplifiedChinese1 =>
      'Текущие события на упрощенном китайском';

  @override
  String get baidu1 => 'Baidu';

  @override
  String get youtubeDesk1 => 'YOUTUBE DESK';

  @override
  String get interactiveTranscriptsShadowing1 =>
      'Интерактивные транскрипции и теневое повторение';

  @override
  String get showsDramas1 => 'ШОУ И ДРАМЫ';

  @override
  String get error_error => 'Ошибка: \$_error';

  @override
  String get extractToDeck1 => 'Извлечь в колоду';

  @override
  String get autosimplify => 'Автоматическое упрощение';

  @override
  String get rewriteThisArticleToMatchYourHskLev =>
      'Перепишите эту статью в соответствии с вашим уровнем HSK';

  @override
  String get addToDeck1 => 'Добавить в колоду';

  @override
  String get playbackratex => '\$(playbackRate)x';

  @override
  String get speedx => '\$(speed)x';

  @override
  String get dailyDiscoveryDrop1 => 'Ежедневная подборка открытий';

  @override
  String get smartSpacedRepetition1 => 'Умное интервальное повторение';

  @override
  String get trialProtectionAlert1 => 'Предупреждение о защите пробной версии';

  @override
  String get masteryLevel1 => 'Уровень владения';

  @override
  String get targetObjective1 => 'Цель';

  @override
  String get dailyPractice1 => 'Ежедневная практика';

  @override
  String get aiSpacedRepetition1 => 'ИИ интервальное повторение';

  @override
  String get iveGrantedAccess => 'Я предоставил доступ';

  @override
  String get addToDeck_selectedwordindiceslength =>
      'Добавить в колоду (\$(_selectedWordIndices.length))';

  @override
  String get scanner1 => 'Сканер';

  @override
  String get interpreter1 => 'Переводчик';

  @override
  String get entryvalueCards => '\$(entry.value) карточек';

  @override
  String get score_score_questionslength =>
      'Счет: \$_score / \$(_questions.length)';

  @override
  String get theMonkeyKing1 => 'Царь обезьян';

  @override
  String get huaMulan1 => 'Хуа Мулань';

  @override
  String get nwaMendsTheHeavens => 'Нюйва чинит небо';

  @override
  String get confucius => 'Конфуций';

  @override
  String get theGreatWall1 => 'Великая стена';

  @override
  String get terracottaArmy1 => 'Терракотовая армия';

  @override
  String get forbiddenCity1 => 'Запретный город';

  @override
  String get aBlessingInDisguise1 => 'Нет худа без добра';

  @override
  String get drawingASnake1 => 'Рисование змеи';

  @override
  String get takingTheBulletTrain1 => 'Поездка на скоростном поезде';

  @override
  String get visitingTheDoctor1 => 'Посещение врача';

  @override
  String get orderingDumplings1 => 'Заказ пельменей';

  @override
  String get theTeaCeremony1 => 'Чайная церемония';

  @override
  String get chineseCalligraphy1 => 'Китайская каллиграфия';

  @override
  String get theGiantPanda1 => 'Большая панда';

  @override
  String get simplifiedText1 => 'Упрощенный текст';

  @override
  String get novels961 => 'Романы (96)';

  @override
  String get microreads => 'Микро-чтения';

  @override
  String get poetry1 => 'Поэзия';

  @override
  String get readingVocabulary1 => 'Чтение и словарный запас';

  @override
  String get defaultfirebaseoptionsHaveNotBeenCo =>
      'DefaultFirebaseOptions не были настроены для Linux -';

  @override
  String get defaultfirebaseoptionsAreNotSupport =>
      'DefaultFirebaseOptions не поддерживаются на этой платформе.';

  @override
  String get hanziMaster1 => 'Hanzi Master';

  @override
  String get strokesCannotBeEmpty => 'Черты не могут быть пустыми.';

  @override
  String get wrongStartPoint => 'Неверная начальная точка.';

  @override
  String get rightShapeButWrongPlace => 'Правильная форма, но неверное место!';

  @override
  String get goodFollowTheFlow => 'Хорошо!\') : \'Следуйте потоку.';

  @override
  String get aBitShaky => 'Немного дрожит!';

  @override
  String get aBitHesitant => 'Немного нерешительно...';

  @override
  String get shapeIsOff => 'Форма неверна.';

  @override
  String get arabic => 'Арабский';

  @override
  String get german => 'Немецкий';

  @override
  String get spanish => 'Испанский';

  @override
  String get french => 'Французский';

  @override
  String get hindi => 'Хинди';

  @override
  String get indonesian => 'Индонезийский';

  @override
  String get italian => 'Итальянский';

  @override
  String get japanese => 'Японский';

  @override
  String get korean => 'Корейский';

  @override
  String get portuguese => 'Португальский';

  @override
  String get russian => 'Русский';

  @override
  String get vietnamese => 'Вьетнамский';

  @override
  String get microphonePermissionDenied =>
      'Разрешение на использование микрофона отклонено';

  @override
  String get offset => 'Смещение';

  @override
  String get audioserviceHasBeenDisposed => 'AudioService был освобожден';

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
  String get kore => 'Коре';

  @override
  String get xmicrosoftoutputformatAudio24khz48k =>
      'X-Microsoft-OutputFormat\': \'audio-24khz-48kbitrate-mono-mp3';

  @override
  String get useragentHanzimasterapp => 'User-Agent\': \'HanziMasterApp';

  @override
  String get anchorWord => 'Якорное слово';

  @override
  String get creativeThematicTitle => 'Креативное тематическое название';

  @override
  String get briefPedagogicalOrSemanticRationale =>
      'Краткое педагогическое или семантическое обоснование';

  @override
  String get theSingleMostCentralCharacterFromTh =>
      'Самый центральный иероглиф из списка';

  @override
  String get aBalancedSetOfCharactersFromYourLib =>
      'Сбалансированный набор иероглифов из вашей библиотеки.';

  @override
  String get yourNaturalConversationalReplyInChi =>
      'Ваш естественный разговорный ответ китайскими иероглифами.';

  @override
  String get theEnglishTranslationOfYourReply =>
      'Английский перевод вашего ответа.';

  @override
  String get thePinyinWithToneMarksForYourReply =>
      'Пиньинь с тоновыми знаками для вашего ответа.';

  @override
  String get aSuggestedResponseTheUserCouldSayBa =>
      'Предлагаемый ответ, который пользователь мог бы сказать вам в ответ.';

  @override
  String get pinyinForTheSuggestion => 'Пиньинь для предложения.';

  @override
  String get englishTranslationForTheSuggestion =>
      'Английский перевод для предложения.';

  @override
  String get scholarsCritique => 'Критика учёного';

  @override
  String get theEchoHallRemainsSilentTryYourBrea =>
      'Эхо-зал молчит. Попробуйте снова.';

  @override
  String get xtitleHanziMaster => 'X-Title\': \'Hanzi Master';

  @override
  String get noneYet => 'Пока нет.';

  @override
  String get exactSentence => 'Точное предложение:';

  @override
  String get englishTranslation => 'Английский перевод';

  @override
  String get previouslyGeneratedPhrases => 'Ранее сгенерированные фразы';

  @override
  String get iLikeDrinkingAppleJuice => 'Я люблю пить яблочный сок.';

  @override
  String get theEnglishMeaningHere => 'Английское значение здесь...';

  @override
  String get failedToFetchDefinition => 'Не удалось получить определение.';

  @override
  String get failedToLoadExplanation => 'Не удалось загрузить объяснение.';

  @override
  String get failedToLoadComparison => 'Не удалось загрузить сравнение.';

  @override
  String get emptyResponseFromOpenrouter => 'Пустой ответ от OpenRouter';

  @override
  String get emptyResponseFromVisionModel => 'Пустой ответ от модели Vision';

  @override
  String get standard => 'Стандартный';

  @override
  String get theFullSentenceInChinese => 'Полное предложение на китайском...';

  @override
  String get theWordOrCharacterInChinese => 'Слово или иероглиф на китайском';

  @override
  String get thePinyinForThisSpecificWord =>
      'Пиньинь для этого конкретного слова';

  @override
  String get emptyResponseFromDeepseekApi => 'Пустой ответ от DeepSeek API';

  @override
  String get criticalPutTheEnglishTranslationInT =>
      'ВАЖНО: Поместите английский перевод в';

  @override
  String get englishTranslationOfTheEntireSenten =>
      'Английский перевод всего предложения';

  @override
  String get hanziWord => 'Слово ханьцзы';

  @override
  String get theFullSimplifiedSentenceInChinese =>
      'Полное упрощенное предложение на китайском...';

  @override
  String get lyingFlatACulturalMovement =>
      'Лежать плашмя: Культурное движение...';

  @override
  String get theUserYouAreSpeakingToIsNamed =>
      'Пользователя, с которым вы говорите, зовут';

  @override
  String get importantRuleDoNotAddressTheUserByA =>
      'ВАЖНОЕ ПРАВИЛО: Не обращайтесь к пользователю по имени. Никогда не используйте имена-заполнители, такие как';

  @override
  String get youAreAConciseChineseCalligraphyAnd =>
      'Вы — лаконичный репетитор по китайской каллиграфии и этимологии в мобильном приложении с карточками.';

  @override
  String get theStudentIsStudyingTheCharacter => 'Ученик изучает иероглиф';

  @override
  String get neverWriteIntroductionsSignoffsOrFi =>
      'Никогда не пишите вступления, прощания или фразы-заполнители, такие как';

  @override
  String get beDirectAndInformative => 'Будьте прямы и информативны.';

  @override
  String get criticalRuleYouMustRespondEntirelyI =>
      'КРИТИЧЕСКОЕ ПРАВИЛО: Вы должны отвечать ПОЛНОСТЬЮ на языке, соответствующем коду ISO 639-1';

  @override
  String get youAreAConciseChineseGrammarTutorIn =>
      'Вы — лаконичный репетитор по китайской грамматике в мобильном приложении.';

  @override
  String get theStudentIsConfusedAboutTheWord => 'Ученик запутался в слове';

  @override
  String get neverWriteIntroductionsSignoffsOrFi1 =>
      'Никогда не пишите вступления, прощания или фразы-заполнители.';

  @override
  String get azureSpeechApiKeysAreMissing =>
      'Ключи Azure Speech API отсутствуют.';

  @override
  String get success => 'Успех';

  @override
  String get granularity => 'Детализация';

  @override
  String get phoneme1 => 'Фонема';

  @override
  String get dimension => 'Измерение';

  @override
  String get comprehensive => 'Комплексный';

  @override
  String get weCouldntHearYouClearlyPleaseTryAga =>
      'Мы не смогли вас четко расслышать. Пожалуйста, попробуйте еще раз.';

  @override
  String get noNbestResultFound => 'Результат NBest не найден.';

  @override
  String get words1 => 'Слова';

  @override
  String get word => 'Слово';

  @override
  String get phonemes => 'Фонемы';

  @override
  String get syllables => 'Слоги';

  @override
  String get syllable => 'Слог';

  @override
  String get omission => 'Пропуск';

  @override
  String get insertion => 'Вставка';

  @override
  String get youMissedThisWord => 'Вы пропустили это слово.';

  @override
  String get extraWordAddedHere => 'Здесь добавлено лишнее слово.';

  @override
  String get mispronunciation => 'Неправильное произношение';

  @override
  String get pronunciationWasInaccurate => 'Произношение было неточным.';

  @override
  String get goodEffortKeepPracticing =>
      'Хорошая попытка! Продолжайте практиковаться.';

  @override
  String get perfectPronunciationSoundsLikeANati =>
      'Идеальное произношение! Звучит как носитель языка.';

  @override
  String get greatJobAFewMinorToneInaccuracies =>
      'Отличная работа! Несколько незначительных неточностей в тоне.';

  @override
  String get notBadButYourTonesNeedSomeWork =>
      'Неплохо, но над вашими тонами нужно поработать.';

  @override
  String get keepPracticingListenToTheNativeAudi =>
      'Продолжайте практиковаться! Послушайте аудио носителя языка и попробуйте еще раз.';

  @override
  String get lexical => 'Лексический';

  @override
  String get chineseHanziHere => 'Китайские иероглифы здесь';

  @override
  String get aShortSummaryInEnglish => 'Краткое содержание на английском';

  @override
  String get noCoherentChineseTextFoundInTheScan =>
      'В сканировании не найдено связного китайского текста.';

  @override
  String get theFullEnglishTranslationOfTheScann =>
      'Полный английский перевод отсканированного текста... ИЛИ \'Связный китайский текст не найден.\'';

  @override
  String get aShort24WordTitleForThisScanEgResta =>
      'Короткое название из 2-4 слов для этого сканирования (например, \'Меню ресторана\', \'Уличный знак\')';

  @override
  String get china => 'Китай';

  @override
  String get noTranslationAvailable => 'Перевод недоступен.';

  @override
  String get scanResults => 'Результаты сканирования';

  @override
  String get whenWasItWrittenAndWhatWasHappening =>
      'Когда это было написано и что происходило в Китае в то время?';

  @override
  String get whyIsThisPieceFamousWhatPhilosophic =>
      'Почему это произведение знаменито? Какие философские или культурные темы оно исследует?';

  @override
  String get aBriefBioOfTheAuthor => 'Краткая биография автора.';

  @override
  String get informationUnavailable => 'Информация недоступна.';

  @override
  String get noSummaryAvailable => 'Краткое содержание недоступно.';

  @override
  String get hanziAiPro => 'Hanzi AI Pro';

  @override
  String get trialNormalIntro => 'ПРОБНЫЙ\', \'ОБЫЧНЫЙ\', \'ВСТУПЛЕНИЕ';

  @override
  String get dailyDrop => 'Ежедневная подборка';

  @override
  String get dailyNotificationsForWordOfTheDayAn =>
      'Ежедневные уведомления о Слове дня и новостях';

  @override
  String get aNewWordAndStoryOfTheDayAreWaitingF =>
      'Новое Слово и История дня ждут вас!';

  @override
  String get spacedRepetition => 'Интервальное повторение';

  @override
  String get remindersForFlashcardsDueForReview =>
      'Напоминания о карточках, требующих повторения';

  @override
  String get engagementReminders => 'Напоминания о вовлеченности';

  @override
  String get trialReminders => 'Напоминания о пробной версии';

  @override
  String get notificationsForYourTrialStatus =>
      'Уведомления о статусе вашей пробной версии';

  @override
  String get comeReviewYourHanziAndTryALiveCallB =>
      'Повторите свои иероглифы и попробуйте Live Call до окончания бесплатного доступа!';

  @override
  String get scholarsEye => 'Взгляд ученого';

  @override
  String get clMeasureWord => 'CL:\', \'Счетное слово:';

  @override
  String get surnameShi => 'Фамилия Ши';

  @override
  String get chineseFamilyNameShi => 'Китайская фамилия (Ши)';

  @override
  String get neutralToneLight => 'Нейтральный тон (легкий)';

  @override
  String get keepYourPitchHighAndSteadyLikeSingi =>
      'Держите высоту голоса высокой и ровной, как при пении ноты.';

  @override
  String get startInTheMiddleAndSlideYourPitchUp =>
      'Начните со средней высоты и плавно повышайте тон, как при вопросе \'Что?\'';

  @override
  String get dipYourVoiceDownLowThenRiseGentlyBa =>
      'Опустите голос низко, затем плавно поднимите его обратно.';

  @override
  String get dropYourPitchSharplyAndDecisivelyLi =>
      'Резко и решительно понизьте тон, как при твердом \'Нет!\'';

  @override
  String get pronounceSoftlyBrieflyAndWithoutEmp =>
      'Произносите мягко, кратко и без акцента.';

  @override
  String get spotOnPitchWasHighFlatAndSteady =>
      'В точку! Высота была высокой, ровной и устойчивой.';

  @override
  String get spotOnUpwardPitchRiseWasClear =>
      'В точку! Повышение тона было четким.';

  @override
  String get spotOnLowDippingCurveWasAccurate =>
      'В точку! Низкая нисходящая кривая была точной.';

  @override
  String get spotOnSharpFallingDropWasDecisive =>
      'В точку! Резкий падающий штрих был решающим.';

  @override
  String get spotOnToneWasPronouncedAccurately =>
      'В точку! Тон произнесен верно.';

  @override
  String get iAgreeToTheTermsOfServiceAndPrivacy =>
      'Я согласен с Условиями использования и Политикой конфиденциальности.';

  @override
  String get sendMeOccasionalUpdatesTipsAndOffer =>
      'Присылайте мне периодические обновления, советы и предложения.';

  @override
  String get signInToSyncYourProgress =>
      'Войдите, чтобы синхронизировать свой прогресс.';

  @override
  String get createAnAccountToSaveYourStats =>
      'Создайте аккаунт, чтобы сохранить свою статистику.';

  @override
  String get smartSpiral => 'УМНАЯ СПИРАЛЬ';

  @override
  String get origin => 'Исток';

  @override
  String get elements => 'Элементы';

  @override
  String get humanity => 'Человечество';

  @override
  String get village => 'Деревня';

  @override
  String get journey => 'Путешествие';

  @override
  String get city => 'Город';

  @override
  String get originTheSimplestShapesTheBeginning =>
      'Простейшие формы. Начало всего сущего.';

  @override
  String get elementsSunMoonWaterAndFireTheNatur =>
      'Солнце, Луна, Вода и Огонь. Мир природы.';

  @override
  String get humanityTheBodyTheHeartAndTheFamily => 'Тело, сердце и семья.';

  @override
  String get villageFieldsRoofsAndToolsTheFounda =>
      'Поля, крыши и инструменты. Основы общества.';

  @override
  String get journeyMovementSpeechAndSustenance =>
      'Движение, речь и пропитание.';

  @override
  String get cityCommerceClothingAndComplexArtif =>
      'Торговля, одежда и сложные артефакты.';

  @override
  String get equilibriumAlgorithm => 'Алгоритм равновесия';

  @override
  String get misc => 'Разное';

  @override
  String get cityOrOriginAs => '\'Город\' или \'Исток\' как';

  @override
  String get miscToOrigin => '\'Разное\' к \'Истоку\'';

  @override
  String get constellation => 'Созвездие';

  @override
  String get whichOneIsWater => 'Какой из них \'Вода\'?';

  @override
  String get whatIsThePinyin => 'Что такое пиньинь?';

  @override
  String get nature => 'Природа';

  @override
  String get whatEssenceDoes => 'Какую сущность имеет';

  @override
  String get allTiers => 'Все уровни';

  @override
  String get active => 'Активно';

  @override
  String get theScrollOfOrigin1 => 'СВИТОК ИСТОКА';

  @override
  String get galaxyOf1 => 'ГАЛАКТИКА';

  @override
  String get also => 'Также';

  @override
  String get work => 'Работа';

  @override
  String get cloud => 'Облако';

  @override
  String get youArchaic => 'Ты (архаичн.)';

  @override
  String get suddenly => 'Внезапно';

  @override
  String get owner => 'Владелец';

  @override
  String get door => 'Дверь';

  @override
  String get occupy => 'Занимать';

  @override
  String get nail => 'Гвоздь';

  @override
  String get and => 'И';

  @override
  String get buddhistNun => 'Буддийская монахиня';

  @override
  String get anxious => 'Тревожный';

  @override
  String get sprout => 'Росток';

  @override
  String get exchange => 'Обмен';

  @override
  String get sheep => 'Овца';

  @override
  String get strange => 'Странный';

  @override
  String get opposite => 'Противоположный';

  @override
  String get shorttailedBird => 'Короткохвостая птица';

  @override
  String get shoot => 'Побег';

  @override
  String get small => 'Маленький';

  @override
  String get gather => 'Собирать';

  @override
  String get order => 'Порядок';

  @override
  String get flat => 'Плоский';

  @override
  String get thePersonWho => 'Человек, который...';

  @override
  String get nobleman => 'Дворянин';

  @override
  String get cause => 'Причина';

  @override
  String get pig => 'Свинья';

  @override
  String get bright => 'Яркий';

  @override
  String get slowly => 'Медленно';

  @override
  String get give => 'Давать';

  @override
  String get arrow => 'Стрела';

  @override
  String get dry => 'Сухой';

  @override
  String get obstacle => 'Препятствие';

  @override
  String get beg => 'Просить';

  @override
  String get window => 'Окно';

  @override
  String get fear => 'Страх';

  @override
  String get drum => 'Барабан';

  @override
  String get why => 'Почему';

  @override
  String get talent => 'Талант';

  @override
  String get follow => 'Подписаться';

  @override
  String get desert => 'Пустыня';

  @override
  String get component => 'Компонент';

  @override
  String get divingInto1 => 'Погружение в';

  @override
  String get unitIntro1 => 'Введение в раздел';

  @override
  String get theBlueprint => 'ЧЕРТЕЖ';

  @override
  String get theOrigin => 'ПРОИСХОЖДЕНИЕ';

  @override
  String get theGalaxy => 'ГАЛАКТИКА';

  @override
  String get theScholarListens => 'Учёный слушает...';

  @override
  String get consultingTheScrolls => 'Изучение свитков...';

  @override
  String get traceWithTheGuide => 'Обвести по образцу';

  @override
  String get traceTheGhost => 'Обвести по контуру';

  @override
  String get connectTheDots => 'Соединить точки';

  @override
  String get drawFromMemory => 'Нарисовать по памяти';

  @override
  String get assistant => 'Ассистент';

  @override
  String get puck => 'Пак';

  @override
  String get helloWelcomeWhatWouldYouLikeToOrder =>
      'Здравствуйте! Добро пожаловать. Что бы вы хотели заказать?';

  @override
  String get ni3Hao3Huan1ying2Guang1lin2Qing3wen =>
      'Ni3 hao3! Huan1ying2 guang1lin2. Qing3wen4 ni3 yao4 dian3 shen2me?';

  @override
  String get waiterLi => 'Официант Ли';

  @override
  String get askForTheMenu => 'Попросить меню';

  @override
  String get orderOneDishAndOneDrink => 'Заказать одно блюдо и один напиток';

  @override
  String get askForTheBill => 'Попросить счёт';

  @override
  String get fenrir => 'Фенрир';

  @override
  String get ni3Qu4Na3rAJi1chang3MaTing3Yuan3De =>
      'Ni3 qu4 na3r a? Ji1chang3 ma? Ting3 yuan3 de!';

  @override
  String get driverWang => 'Водитель Ван';

  @override
  String get tellTheDriverYouAreGoingToTheAirpor =>
      'Сказать водителю, что едете в аэропорт';

  @override
  String get askHowLongTheTripWillTake => 'Спросить, сколько займёт поездка';

  @override
  String get complainAboutTheTraffic => 'Пожаловаться на пробки';

  @override
  String get charon => 'Харон';

  @override
  String get thisClothingQualityIsEspeciallyGood =>
      'Качество этой одежды особенно хорошее, всего 200 юаней.';

  @override
  String get zhe4Jian4Yi1fuZhi4liang4Te4bie2Hao3 =>
      'Zhe4 jian4 yi1fu zhi4liang4 te4bie2 hao3, zhi3yao4 liang3 bai3 kuai4.';

  @override
  String get auntieChen => 'Тётушка Чэнь';

  @override
  String get askHowMuchTheSilkShirtCosts =>
      'Спросить, сколько стоит шёлковая рубашка';

  @override
  String get sayItIsTooExpensive => 'Сказать, что это слишком дорого';

  @override
  String get bargainThePriceDownTo100Rmb => 'Сторговаться до 100 юаней';

  @override
  String get ni3Na3li3Bu4Shu1fuFa1shao1LeMa =>
      'Ni3 na3li3 bu4 shu1fu? Fa1shao1 le ma?';

  @override
  String get drZhang => 'Доктор Чжан';

  @override
  String get explainYouHaveHadAHeadacheForTwoDay =>
      'Объяснить, что болит голова уже два дня';

  @override
  String get sayYouHaveASlightFever => 'Сказать, что у вас небольшой жар';

  @override
  String get askIfYouNeedToTakeMedicine =>
      'Спросить, нужно ли принимать лекарство';

  @override
  String get aoede => 'Эоэда';

  @override
  String get heyLongTimeNoSeeHowHaveYouBeenLatel =>
      'Привет! Давно не виделись, как дела в последнее время?';

  @override
  String get ni3Hao3Hao3jiu3Bu4jian4Ni3Zui4jin4Z =>
      'Ni3 hao3! Hao3jiu3 bu4jian4, ni3 zui4jin4 zen3me yang4?';

  @override
  String get pleaseIntroduceYourselfWhyDoYouWant =>
      'Пожалуйста, представьтесь. Почему вы хотите работать в нашей компании?';

  @override
  String get qing3Xian1Zi4wo3Jie4shao4Yi1xia4Ni3 =>
      'Qing3 xian1 zi4wo3 jie4shao4 yi1xia4. Ni3 wei4shen2me xiang3 lai2 wo3men gong1si1 gong1zuo4?';

  @override
  String get managerLiu => 'Менеджер Лю';

  @override
  String get introduceYourProfessionalBackground =>
      'Кратко представьте свой профессиональный опыт';

  @override
  String get explainWhyYouWantToWorkAtThisCompan =>
      'Объяснить, почему вы хотите работать в этой компании';

  @override
  String get askAPoliteQuestionAboutTheCompanyCu =>
      'Задать вежливый вопрос о корпоративной культуре';

  @override
  String get microphoneAccessIsRequiredPleaseEna =>
      'Требуется доступ к микрофону. Пожалуйста, включите его в настройках вашего устройства.';

  @override
  String get couldNotStartMicrophonePleaseCheckY =>
      'Не удалось запустить микрофон. Пожалуйста, проверьте настройки звука и попробуйте снова.';

  @override
  String get weDidntQuiteCatchThatPleaseHoldTheM =>
      'Мы не совсем поняли. Пожалуйста, держите микрофон ближе и попробуйте снова!';

  @override
  String get recordingWasTooShortHoldTheMicAndSp =>
      'Запись была слишком короткой. Держите микрофон ближе и говорите чётко.';

  @override
  String get audioBufferWasEmptyPleaseCheckYourM =>
      'Аудиобуфер пуст. Пожалуйста, проверьте микрофон и попробуйте снова.';

  @override
  String get audioFileIsSilentPleaseSpeakIntoThe =>
      'Аудиофайл без звука. Пожалуйста, говорите в микрофон.';

  @override
  String get weCouldntUnderstandYourPronunciatio =>
      'Мы не смогли понять ваше произношение. Пожалуйста, говорите чётко и попробуйте снова.';

  @override
  String get theServerIsTakingTooLongToRespondPl =>
      'Сервер слишком долго не отвечает. Пожалуйста, попробуйте снова.';

  @override
  String get noInternetConnectionPleaseCheckYour =>
      'Нет подключения к интернету. Пожалуйста, проверьте сеть и попробуйте снова.';

  @override
  String get audioProcessingFailedPleaseTryAgain =>
      'Ошибка обработки аудио. Пожалуйста, попробуйте снова.';

  @override
  String get permission => 'Разрешение';

  @override
  String get couldNotProcessYourRecordingPleaseT =>
      'Не удалось обработать вашу запись. Пожалуйста, попробуйте снова.';

  @override
  String get user => 'Пользователь';

  @override
  String get scholar => 'Учёный';

  @override
  String get ourAiTutorsAreCurrentlyOfflinePleas =>
      'Наши ИИ-репетиторы сейчас недоступны, пожалуйста, попробуйте позже.';

  @override
  String get hideTranslation => 'Скрыть перевод';

  @override
  String get azureAssessment => 'Оценка Azure...';

  @override
  String get microphonePermissionRequired =>
      'Требуется разрешение на использование микрофона';

  @override
  String get connectedSpeakNow => 'Подключено! Говорите.';

  @override
  String get initializationErrorCheckPermissions =>
      'Ошибка инициализации. Проверьте разрешения.';

  @override
  String get microphoneErrorTapToRetry =>
      'Ошибка микрофона. Нажмите, чтобы повторить.';

  @override
  String get theTutorReturnedAnEmptyResponse => 'Репетитор вернул пустой ответ';

  @override
  String get connectionInterruptedPleaseSpeakAga =>
      'Соединение прервано. Пожалуйста, повторите.';

  @override
  String get callPausedReviewingTones => 'Звонок на паузе (проверка тонов)';

  @override
  String get pausedTakeABreak => 'Пауза – Сделайте перерыв';

  @override
  String get goodStartPracticing => 'Хорошее начало тренировки';

  @override
  String get studentCoach => 'УЧЕНИК\' : \'ТРЕНЕР';

  @override
  String get keepYour1stToneHighAndSteadyOn =>
      'Держите ваш 1-й тон высоким и ровным на';

  @override
  String get noScenariosFound => 'Сценарии не найдены.';

  @override
  String get designYourOwnAiRoleplayExperience =>
      'Создайте свой собственный опыт ролевой игры с ИИ';

  @override
  String get generateFromDeck => 'Сгенерировать из колоды';

  @override
  String get practiceFlashcardVocabularyInALiveD =>
      'Практикуйте словарный запас из карточек в живом диалоге';

  @override
  String get tapToRoleplay => 'Нажмите, чтобы начать ролевую игру';

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
  String get dinnerWithDad => 'Ужин с папой';

  @override
  String get orderingAtAChengduTeahouse => 'Заказ в чайной Чэнду';

  @override
  String get buyingTeaAtTheMarket => 'Покупка чая на рынке';

  @override
  String get meetingAnOldClassmate => 'Встреча со старым одноклассником';

  @override
  String get readyToPractice => 'Готовы практиковаться?';

  @override
  String get letsPracticeChinese => 'Давайте практиковать китайский';

  @override
  String get areYouReady => 'Вы готовы?';

  @override
  String get discussWhatToHaveForDinner => 'Обсудить, что приготовить на ужин';

  @override
  String get suggestWatchingAMovieAfterwards =>
      'Предложить посмотреть фильм после';

  @override
  String get askIfTheyWouldLikeTea => 'Спросить, хотят ли они чаю';

  @override
  String get helloVeryNiceToMeetYou =>
      'Здравствуйте! Очень приятно познакомиться.';

  @override
  String get deckPractice => 'Практика с колодой';

  @override
  String get practiceVocabularyWithAnAiPartner =>
      'Практикуйте словарный запас с ИИ-партнером.';

  @override
  String get designCustomAiRoleplayConversation =>
      'Создайте собственную ролевую игру и диалог с ИИ';

  @override
  String get random => 'Случайный';

  @override
  String get scenarioTopic => 'Тема сценария';

  @override
  String get contextSettingOptional => 'Контекст и обстановка (необязательно)';

  @override
  String get aiCharacterPersonaOptional =>
      'Персонаж / Личность ИИ (необязательно)';

  @override
  String get aQuietBambooCourtyardTeahouseInChen =>
      'Тихая чайная в бамбуковом дворике Чэнду с нежной музыкой гучжэна.';

  @override
  String get aBustlingSmokyNightMarketFilledWith =>
      'Шумный, дымный ночной рынок, полный шашлыков, паровых булочек и уличных закусочных.';

  @override
  String get aLivelyHotpotRestaurantInChongqingW =>
      'Оживленный ресторан хого в Чунцине с кипящим багровым бульоном и ароматным запахом чили.';

  @override
  String get aBustlingTraditionalCantoneseTeahou =>
      'Шумная традиционная кантонская чайная в Гуанчжоу, полная дымящихся бамбуковых корзин.';

  @override
  String get aChicMinimalistCafeInTheFrenchConce =>
      'Шикарное минималистичное кафе во Французской концессии дождливым воскресным днем.';

  @override
  String get aWarmNorthernHomeKitchenDuringWinte =>
      'Теплая северная домашняя кухня зимой с мукой на столе и дымящимися горшками с пельменями.';

  @override
  String get anOpenairNightStreetFoodAlleyWithSi =>
      'Уличная ночная аллея с едой под открытым небом, с шипящими шашлыками из баранины, жареными баклажанами и холодным пивом.';

  @override
  String get aSnowyStreetCornerOutsideTheLamaTem =>
      'Заснеженный уличный уголок у храма Ламы с ярко-красными засахаренными шашлыками из боярышника на льду.';

  @override
  String get craftBeerBreweryInQingdao => 'Пивоварня крафтового пива в Циндао';

  @override
  String get aLivelyCoastalTaproomWithWoodenBarr =>
      'Оживленный прибрежный паб с деревянными бочками, морским бризом и кранами свежего пшеничного пива.';

  @override
  String get sichuanCookingMasterclass => 'Мастер-класс по сычуаньской кухне';

  @override
  String get aVibrantOpenKitchenWithWoksBlazingC =>
      'Яркая открытая кухня с пылающими воками, кипящим чили-маслом и свежим сычуаньским перцем.';

  @override
  String get highspeedRailSeatMixup => 'Путаница с местами в скоростном поезде';

  @override
  String get greatWallSunriseTrekInMutianyu =>
      'Восход солнца на Великой стене в Мутяньюй';

  @override
  String get theAncientStoneRampartsOfTheGreatWa =>
      'Древние каменные валы Великой стены на рассвете, окруженные туманными зелеными горами.';

  @override
  String get bambooRaftDriftOnGuilinLiRiver =>
      'Сплав на бамбуковом плоту по реке Ли в Гуйлине';

  @override
  String get glidingAlongEmeraldKarstWatersBetwe =>
      'Скольжение по изумрудным карстовым водам между величественными туманными известняковыми пиками близ Яншо.';

  @override
  String get silkRoadCamelTrekInDunhuang =>
      'Верблюжий поход по Шелковому пути в Дуньхуане';

  @override
  String get theRollingGoldenSandDunesOfMingshaM =>
      'Катящиеся золотые песчаные дюны горы Минша рядом с оазисом озера Полумесяца.';

  @override
  String get bookingACourtyardHomestayInDali =>
      'Бронирование гостевого дома во дворе в Дали';

  @override
  String get aSereneBaistyleBoutiqueCourtyardHot =>
      'Безмятежный бутик-отель в стиле Бай с внутренним двором, откуда открывается вид на озеро Эрхай в Юньнани.';

  @override
  String get potalaPalacePilgrimageInLhasa =>
      'Паломничество во дворец Потала в Лхасе';

  @override
  String get theMajesticSundrenchedStoneStepsOut =>
      'Величественные залитые солнцем каменные ступени у дворца Потала с вращающимися молитвенными барабанами.';

  @override
  String get aSubzeroWonderlandOfIlluminatedCrys =>
      'Морозная страна чудес из освещенных хрустальных ледяных дворцов и высоких снежных скульптур.';

  @override
  String get zhangjiajieAvatarMountainCableCar =>
      'Канатная дорога к горам Аватар в Чжанцзяцзе';

  @override
  String get suspendedHighInAGlassCableCarSoarin =>
      'Парящий высоко в стеклянной кабине канатной дороги над тысячами песчаниковых пиков-столбов.';

  @override
  String get gobiDesertStargazingCampInGansu =>
      'Лагерь для наблюдения за звездами в пустыне Гоби, Ганьсу';

  @override
  String get aLuxuryYurtCampUnderACrystalclearMi =>
      'Роскошный юртовый лагерь под кристально чистым небом Млечного Пути в пустыне за Цзяюйгуанем.';

  @override
  String get yangtzeRiverThreeGorgesCruise =>
      'Круиз по реке Янцзы через Три ущелья';

  @override
  String get onTheSunDeckOfARiverCruiseShipPassi =>
      'На солнечной палубе круизного лайнера, проходящего через величественное ущелье Цюйтан.';

  @override
  String get buyingAntiquesInBeijingPanjiayuan =>
      'Покупка антиквариата на рынке Паньцзяюань в Пекине';

  @override
  String get aHistoricPotteryKilnFilledWithDelic =>
      'Историческая гончарная печь, наполненная изящными необожженными фарфоровыми вазами и кобальтово-синей глазурью.';

  @override
  String get suzhouSilkEmbroideryStudio => 'Студия шелковой вышивки в Сучжоу';

  @override
  String get aPeacefulCanalsideGardenStudioInSuz =>
      'Спокойная садовая студия у канала в Сучжоу с тонкими шелковыми нитями и деревянными вышивальными рамами.';

  @override
  String get backstageAtATraditionalBeijingOpera =>
      'За кулисами традиционного театра Пекинской оперы с яркими костюмами, зеркалами и головными уборами.';

  @override
  String get traditionalChineseMedicineConsultat =>
      'Консультация по традиционной китайской медицине';

  @override
  String get morningTaiChiInTempleOfHeavenPark =>
      'Утреннее тайцзи в Парке Храма Неба';

  @override
  String get beneathAncientCypressTreesAtDawnWit =>
      'Под древними кипарисами на рассвете, с парковыми птицами и пожилыми людьми, практикующими синхронные движения.';

  @override
  String get rentingAHanfuForAPhotoShoot => 'Аренда ханьфу для фотосессии';

  @override
  String get aTraditionalCostumeBoutiqueNearTheW =>
      'Бутик традиционных костюмов у Западного озера со стойками, полными халатов династий Тан и Сун.';

  @override
  String get guqinAncientZitherInstrumentWorksho =>
      'Мастер-класс по игре на гуцине (древней цитре)';

  @override
  String get aQuietPinewoodStudioInHangzhouFille =>
      'Тихая студия из сосны в Ханчжоу, наполненная инструментами из выдержанного дерева павловнии и шелковыми струнами.';

  @override
  String get shaanxiShadowPuppetTheater => 'Театр теневых кукол Шэньси';

  @override
  String get behindAnIlluminatedWhiteSilkScreenW =>
      'За освещенным белым шелковым экраном с изящными полупрозрачными кожаными теневыми фигурами.';

  @override
  String get chineseCalligraphyWorkshop =>
      'Мастер-класс по китайской каллиграфии';

  @override
  String get aTranquilStudioScentedWithPineSootI =>
      'Спокойная студия, благоухающая чернилами из сосновой сажи, свитками из рисовой бумаги и нежными чайными ароматами.';

  @override
  String get adoptingACatAtAnAnimalShelter =>
      'Усыновление кошки в приюте для животных';

  @override
  String get aCozyPetRescueCenterInHangzhouWithE =>
      'Уютный центр спасения животных в Ханчжоу с энергичными спасенными котятами и чаем для посетителей.';

  @override
  String get scriptMurderMysteryJubenshaGame =>
      'Сюжетная детективная игра (Дзюбэнша)';

  @override
  String get aThemedDetectiveLoungeInShanghaiWit =>
      'Тематический детективный лаундж в Шанхае с игроками в костюмах и при свечах.';

  @override
  String get vintageVinylRecordShopInShanghai =>
      'Магазин винтажных виниловых пластинок в Шанхае';

  @override
  String get aHiddenVinylStoreInAnOldLaneHousePa =>
      'Скрытый магазин винила в старом переулке, заполненный классическими записями кантопопа 80-х и джаза.';

  @override
  String get ktvKaraokePartyWithFriends => 'KTV Караоке-вечеринка с друзьями';

  @override
  String get joiningACityBikeCyclingClub => 'Вступление в городской вело-клуб';

  @override
  String get aGatheringOfCyclistsByTheRiverfront =>
      'Сбор велосипедистов на набережной, готовящихся к вечерней поездке по городскому пейзажу.';

  @override
  String get blindBoxToyTradingMeetup =>
      'Встреча по обмену игрушками вслепую (Blind Box)';

  @override
  String get aColorfulPopcultureToyStoreInChaoya =>
      'Красочный магазин игрушек поп-культуры в Чаояне с витринами и нераспечатанными коллекционными коробками.';

  @override
  String get droneSkylineVideographyAtTheBund =>
      'Аэросъемка городского пейзажа дроном на набережной Вайтань';

  @override
  String get theBundPromenadeAtDuskOverlookingTh =>
      'Набережная Вайтань на закате с видом на футуристические освещенные небоскребы Пудуна.';

  @override
  String get goldenRetrieverCafeInNanjing =>
      'Кафе с золотистыми ретриверами в Нанкине';

  @override
  String get aSunnyCheerfulPetCafeWithDozensOfFr =>
      'Солнечное, веселое кафе для животных с десятками дружелюбных, пушистых собак, встречающих посетителей.';

  @override
  String get boulderingClimbingGymInChengdu =>
      'Боулдеринговый скалодром в Чэнду';

  @override
  String get aModernIndoorClimbingGymWithVibrant =>
      'Современный крытый скалодром с яркими маршрутами и энергичной музыкой.';

  @override
  String get aMassiveConventionHallFilledWithCol =>
      'Огромный выставочный зал, заполненный красочными игровыми стендами, фотозонами и создателями в костюмах.';

  @override
  String get askingForDirectionsInABeijingHutong =>
      'Спрашивать дорогу в пекинском хутуне';

  @override
  String get aMazeOfHistoricGreybrickAlleysWithB =>
      'Лабиринт исторических переулков из серого кирпича с велосипедами, внутренними двориками и гранатовыми деревьями.';

  @override
  String get buyingFreshFruitAtAWetMarket => 'Покупка свежих фруктов на рынке';

  @override
  String get aLivelyMorningNeighborhoodMarketWit =>
      'Оживленный утренний районный рынок с горами свежих личи, манго и питайи.';

  @override
  String get flowerMarketBouquetInKunming =>
      'Букет с цветочного рынка в Куньмине';

  @override
  String get theFamousDounanFlowerMarketSurround =>
      'Знаменитый цветочный рынок Доунань, окруженный тысячами свежих роз, лилий и стеблей эвкалипта.';

  @override
  String get tailorAlterationsInAnOldLaneHouse =>
      'Пошив и ремонт одежды в старом переулке';

  @override
  String get aTraditionalTailorShopFilledWithSew =>
      'Традиционная швейная мастерская, наполненная швейными машинами, тканями и измерительными лентами.';

  @override
  String get expressParcelLockerRetrieval => 'Получение посылки из постамата';

  @override
  String get downstairsAtAResidentialApartmentGa =>
      'Внизу у ворот жилого дома, рядом с умной системой постаматов Hive box.';

  @override
  String get bicycleFlatTireRepairAtCampusGate =>
      'Ремонт проколотой шины велосипеда у ворот кампуса';

  @override
  String get aSmallOutdoorRoadsideToolkitStandUn =>
      'Небольшой уличный придорожный стенд с инструментами под большим раскидистым баньяном.';

  @override
  String get techCompanyProductDemo =>
      'Демонстрация продукта технологической компании';

  @override
  String get aFuturisticTechConferenceBoothInShe =>
      'Футуристический стенд на технологической конференции в Шэньчжэне, демонстрирующий передовое аппаратное обеспечение ИИ.';

  @override
  String get ecommerceLivestreamStudio =>
      'Студия для прямых трансляций электронной коммерции';

  @override
  String get aHighenergyBroadcastStudioWithRingL =>
      'Высокоэнергетическая студия вещания с кольцевыми лампами, стеллажами для демонстрации продуктов и мониторами для комментариев в прямом эфире.';

  @override
  String get yiwuInternationalTradeMarket => 'Международный торговый рынок Иу';

  @override
  String get aVastMultistoryCommercialExhibition =>
      'Огромный многоэтажный торгово-выставочный центр, заполненный миллионами оптовых товаров и ремесел.';

  @override
  String get universityCampusExchangeProgram =>
      'Программа обмена в университетском кампусе';

  @override
  String get aSunnyLawnOutsideTheUniversityLibra =>
      'Солнечная лужайка у университетской библиотеки со студентами, занимающимися и пьющими молочный чай.';

  @override
  String get pleaseEnterAScenarioTopic => 'Пожалуйста, введите тему сценария.';

  @override
  String get nameTitle => 'Имя (Название)';

  @override
  String get aiCharacter => 'ИИ-персонаж';

  @override
  String get helloWelcomeHereWhatShallWeChatAbou =>
      'Привет! Добро пожаловать, о чем мы сегодня поговорим?';

  @override
  String get greetYourConversationPartner => 'Поприветствуйте собеседника';

  @override
  String get askAQuestionInChinese => 'Задайте вопрос на китайском';

  @override
  String get pinyinWithToneMarks => 'Пиньинь с тоновыми знаками';

  @override
  String get goal1InEnglish => 'Цель 1 на английском';

  @override
  String get goal2InEnglish => 'Цель 2 на английском';

  @override
  String get goal3InEnglish => 'Цель 3 на английском';

  @override
  String get beginner => 'Новичок';

  @override
  String get hsk12 => 'HSK 1-2';

  @override
  String get hsk34 => 'HSK 3-4';

  @override
  String get hsk56 => 'HSK 5-6';

  @override
  String get master => 'Мастер';

  @override
  String get azurePronunciationAssessment => 'ОЦЕНКА ПРОИЗНОШЕНИЯ AZURE';

  @override
  String get tapToReview => 'Нажмите для просмотра';

  @override
  String get overallScore => 'Общий балл';

  @override
  String get toneAccuracy => 'Точность тонов';

  @override
  String get fluency => 'Беглость';

  @override
  String get report => 'Сообщить';

  @override
  String get goodPronunciationButCanBeBetter =>
      'Хорошее произношение, но может быть лучше!';

  @override
  String get didYouMeanToSay => 'Вы имели в виду...?';

  @override
  String get greatKeepTrying => 'Отлично!\' : \'Продолжайте попытки!';

  @override
  String get completeness => 'Полнота';

  @override
  String get targetTone => 'Целевой тон';

  @override
  String get k4toneComparisonTapToListen =>
      'Сравнение 4 тонов (нажмите, чтобы прослушать):';

  @override
  String get youSpokeMatch => 'Вы произнесли (Совпадение!)';

  @override
  String get youSpoke => 'Вы произнесли';

  @override
  String get yourPrimaryCollectionOfCharacters =>
      'Ваша основная коллекция иероглифов.';

  @override
  String get deckNotFound => 'Колода не найдена';

  @override
  String get cannotDeleteTheDefaultDeck =>
      'Невозможно удалить колоду по умолчанию';

  @override
  String get hsk4UpperIntermediate1 => 'HSK 4: Выше среднего';

  @override
  String get theFirst150CharactersToStartYourJou =>
      'Первые 150 иероглифов для начала вашего пути.';

  @override
  String get buildYourVocabularyTo300EssentialWo =>
      'Расширьте свой словарный запас до 300 основных слов.';

  @override
  String get masterConversationalFluencyWith600W =>
      'Овладейте разговорной беглостью с 600 словами.';

  @override
  String get readTextsAndConverseFluentlyWith120 =>
      'Читайте тексты и свободно общайтесь, зная 1200 слов.';

  @override
  String get readNewspapersAndWatchMoviesWith250 =>
      'Читайте газеты и смотрите фильмы, зная 2500 слов.';

  @override
  String get databaseBoxNotOpen => 'База данных не открыта';

  @override
  String get hsk1DataFileIsEmpty => 'Файл данных HSK1 пуст';

  @override
  String get gold => 'Золото';

  @override
  String get globalDictionaryNotInitialized =>
      'Глобальный словарь не инициализирован';

  @override
  String get reading => 'Чтение';

  @override
  String get recall => 'Вспоминание';

  @override
  String get speaking => 'Говорение';

  @override
  String get listening1 => 'Аудирование';

  @override
  String get practiceStrokeOrderWithVisualGuides =>
      'Практикуйте порядок черт с визуальными подсказками.';

  @override
  String get seeTheCharacterRecallThePinyinAndMe =>
      'Увидьте иероглиф, вспомните пиньинь и значение.';

  @override
  String get seeTheMeaningDrawTheCharacterFromMe =>
      'Увидьте значение, нарисуйте иероглиф по памяти.';

  @override
  String get readOutLoudToTestYourPronunciationT =>
      'Читайте вслух, чтобы проверить произношение тонов.';

  @override
  String get listenToTheAudioAndIdentifyTheChara =>
      'Прослушайте аудио и определите иероглиф.';

  @override
  String get contract => 'Контракт';

  @override
  String get whoeverImplementsMeMustBeAbleToDoTh =>
      'Тот, кто меня реализует, ДОЛЖЕН уметь делать эти вещи.';

  @override
  String get koreFenrirCharonAoedePuckOrLocal =>
      'Коре\', \'Фенрир\', \'Харон\', \'Аоэда\', \'Пак\' или \'локальный\'';

  @override
  String get manageDecks => 'Управление колодами';

  @override
  String get weRanIntoTroubleLoadingTheLibraryPl =>
      'Возникли проблемы при загрузке библиотеки. Пожалуйста, попробуйте снова.';

  @override
  String get noCharactersInLexicon1 => 'В лексиконе нет иероглифов';

  @override
  String get masterTheBuildingBlocks => 'Освойте основы';

  @override
  String get other => 'Другое';

  @override
  String get required => 'Обязательно';

  @override
  String get library1 => 'Библиотека';

  @override
  String get youAreAPremiumMember => 'Вы являетесь Premium-пользователем';

  @override
  String get createAccountToSyncProgress =>
      'Создайте аккаунт для синхронизации прогресса';

  @override
  String get signOut => 'Выйти';

  @override
  String get account => 'Аккаунт';

  @override
  String get guestScholar => 'Гостевой ученый';

  @override
  String get localAccount => 'Локальный аккаунт';

  @override
  String get unknownRadical => 'Неизвестный радикал';

  @override
  String get followTheGuideStroke => 'Следуйте направляющей черте';

  @override
  String get strokeAnimationSpeed => 'Скорость анимации черт';

  @override
  String get notifications => 'Уведомления';

  @override
  String get deutsch => 'Немецкий';

  @override
  String get bahasaIndonesia => 'Индонезийский';

  @override
  String get italiano => 'Итальянский';

  @override
  String get today1d2d3d4d5d6d =>
      'Сегодня\', \'1д\', \'2д\', \'3д\', \'4д\', \'5д\', \'6д';

  @override
  String get targetDeck => 'Целевая колода';

  @override
  String get mixed => 'Смешанный';

  @override
  String get topicForContext => 'Тема (для контекста)';

  @override
  String get nounsOnly => 'Только существительные';

  @override
  String get verbsOnly => 'Только глаголы';

  @override
  String get idiomsChengyu => 'Идиомы (Чэнъюй)';

  @override
  String get fullSentences => 'Полные предложения';

  @override
  String get beginnerHsk12 => 'Начальный (HSK 1-2)';

  @override
  String get intermediateHsk34 => 'Средний (HSK 3-4)';

  @override
  String get advancedHsk56 => 'Продвинутый (HSK 5-6)';

  @override
  String get generatedByAi => 'Сгенерировано ИИ';

  @override
  String get canYouGiveMeTwoMoreExamplesUsingThi =>
      'Можете ли вы привести еще два примера использования этого слова?';

  @override
  String get whatAreSomeSimilarWordsAndHowDoThey =>
      'Какие есть похожие слова и чем они отличаются?';

  @override
  String get isThisWordUsedInSpokenOrWrittenChin =>
      'Это слово чаще используется в разговорном или письменном китайском?';

  @override
  String get areThereOtherWaysToTranslateThisWor =>
      'Есть ли другие способы перевести это слово?';

  @override
  String get whatAreCommonWordsThatGoTogetherWit =>
      'Какие слова часто употребляются вместе с этим словом?';

  @override
  String get whatAreCommonMistakesLearnersMakeWi =>
      'Какие распространённые ошибки допускают учащиеся с этим словом?';

  @override
  String get emptyResponse => 'Пустой ответ';

  @override
  String get whatIsTheOracleBoneScriptOriginOfTh =>
      'Каково происхождение этого иероглифа в надписях на гадательных костях?';

  @override
  String get howDidTheAncientFormOfThisCharacter =>
      'Как древняя форма этого иероглифа развивалась со временем?';

  @override
  String get giveMe3CommonWordsThatContainThisCh =>
      'Назовите 3 распространённых слова, содержащих этот иероглиф.';

  @override
  String get whatOtherCharactersShareTheSameRadi =>
      'Какие ещё иероглифы имеют тот же ключ?';

  @override
  String get isThereAChineseProverbOrSayingFeatu =>
      'Есть ли китайская пословица или поговорка с этим иероглифом?';

  @override
  String get explainTheStrokeOrderRulesForThisCh =>
      'Объясните правила порядка черт для этого иероглифа.';

  @override
  String get giveMeOneCalligraphyTipForWritingTh =>
      'Дайте один каллиграфический совет для красивого написания этого иероглифа.';

  @override
  String get isThereAnythingTrickyAboutUsingThis =>
      'Есть ли какие-либо сложности в его грамматическом использовании?';

  @override
  String get whatWordsAreCommonlyConfusedWithThi =>
      'Какие слова часто путают с этим и почему?';

  @override
  String get doesThisCharacterCarryCulturalSymbo =>
      'Несёт ли этот иероглиф культурный символизм в Китае?';

  @override
  String get isThisCharacterCommonlySeenInChines =>
      'Часто ли этот иероглиф встречается в китайских фильмах, песнях или текстах?';

  @override
  String get whatDoesTheRadicalOfThisCharacterMe =>
      'Что означает ключ этого иероглифа?';

  @override
  String get breakDownEveryComponentAndItsMeanin =>
      'Разберите каждый компонент и его значение.';

  @override
  String get giveMeATrickToRememberTheCorrectTon =>
      'Дайте мне приём для запоминания правильного тона этого иероглифа.';

  @override
  String get areThereCommonHomophonesThatAreOfte =>
      'Есть ли распространённые омофоны, которые часто путают с этим?';

  @override
  String get quotaExceeded => 'Квота превышена';

  @override
  String get mustProvideEitherCardOrCards =>
      'Необходимо предоставить либо карточку, либо карточки';

  @override
  String get deckSettings => 'Настройки колоды';

  @override
  String get saveSettings => 'Сохранить настройки';

  @override
  String get sealRed => 'Красная печать';

  @override
  String get sealScript => 'Стиль печати';

  @override
  String get startYourStreak => 'НАЧНИТЕ СЕРИЮ';

  @override
  String get traditionalCharacter => 'Традиционный иероглиф';

  @override
  String get inQueue => 'В очереди';

  @override
  String get tapToListenAgain => 'Нажмите, чтобы прослушать снова';

  @override
  String get contextClue => 'Подсказка контекста';

  @override
  String get microphonePermissionRequired1 =>
      'Требуется разрешение на использование микрофона.';

  @override
  String get recordingFailedNoFile => 'Запись не удалась (нет файла).';

  @override
  String get holdToSpeakOptional => 'Удерживайте для разговора (Необязательно)';

  @override
  String get microphonePermissionDeniedEnableItI =>
      'Доступ к микрофону запрещён. Включите его в Настройках, чтобы использовать Shadowing Studio.';

  @override
  String get sessionSummary => 'Сводка сессии';

  @override
  String get hereAreTheCharactersYouStruggledWit =>
      'Вот иероглифы, с которыми у вас были трудности:';

  @override
  String get applySessionGradesToSpacedRepetitio =>
      'Применить оценки сессии к интервальному повторению (режим говорения)';

  @override
  String get masterYourMandarinPronunciationnbyM =>
      'Отточите своё произношение мандарина\\n, имитируя речь носителей языка.';

  @override
  String get aiIsGradingYourPronunciation =>
      'ИИ оценивает ваше произношение...';

  @override
  String get holdMicToRecordReleaseToGrade =>
      'Удерживайте микрофон для записи. Отпустите для оценки.';

  @override
  String get tapAnySyllableToAuditionAll4Tones =>
      'Нажмите на любой слог, чтобы прослушать все 4 тона:';

  @override
  String get freeFlowConversationalPractice =>
      'Свободная разговорная практика.';

  @override
  String get failedToGeneratePhrasePleaseTryAgai =>
      'Не удалось сгенерировать фразу. Пожалуйста, попробуйте снова.';

  @override
  String get recordingTooShortHoldTheMicButtonLo =>
      'Запись слишком короткая. Удерживайте кнопку микрофона дольше.';

  @override
  String get recordingErrorPleaseTryAgain =>
      'Ошибка записи. Пожалуйста, попробуйте снова.';

  @override
  String get noRecordingCapturedPleaseTryAgain =>
      'Запись не была сделана. Пожалуйста, попробуйте снова.';

  @override
  String get recordedAudioIsEmptyPleaseTryAgainA =>
      'Записанный звук пуст. Пожалуйста, попробуйте снова и говорите чётко.';

  @override
  String get azureSpeechApiKeysAreMissing1 =>
      'Отсутствуют ключи Azure Speech API';

  @override
  String get azureError401 => 'Ошибка Azure 401';

  @override
  String get azureAuthenticationFailedCheckYourS =>
      'Аутентификация Azure не удалась. Проверьте ваш ключ Speech API и регион в .env';

  @override
  String get azureError429 => 'Ошибка Azure 429';

  @override
  String get azureQuotaExceededTryAgainLater =>
      'Квота Azure превышена. Попробуйте снова позже.';

  @override
  String get azureGradingTimedOutCheckYourIntern =>
      'Время оценки Azure истекло. Проверьте ваше интернет-соединение.';

  @override
  String get recognitionFailedNull => 'Распознавание не удалось: null';

  @override
  String get couldNotHearYouClearlyPleaseTryAgai =>
      'Не удалось чётко вас расслышать. Пожалуйста, попробуйте снова.';

  @override
  String get singlePhrasePractice => 'Практика одной фразы';

  @override
  String get failedToGeneratePhrase => 'Не удалось сгенерировать фразу';

  @override
  String get omitted => 'Пропущено';

  @override
  String get partial => 'Частично';

  @override
  String get mispronounced => 'Неправильно произнесено';

  @override
  String get startSession1 => 'Начать сессию';

  @override
  String get chinese => 'Китайский';

  @override
  String get paused => 'Пауза';

  @override
  String get translationFailed => 'Перевод не удался';

  @override
  String get engagingMacroeconomicAndBusinessBre =>
      'Увлекательные макроэкономические и бизнес-анализы, объяснённые через живое повествование.';

  @override
  String get exploresWorldEconomiesBankingHistor =>
      'Исследует мировые экономики, историю банковского дела и динамику мировой промышленности.';

  @override
  String get clearArticulateMandarinPerfectForIn =>
      'Чёткий, выразительный мандарин, идеальный для учащихся среднего и продвинутого уровней.';

  @override
  String get chefWang => 'Шеф-повар Ван';

  @override
  String get masterSichuanCulinaryTechniquesTaug =>
      'Освойте сычуаньские кулинарные техники, преподаваемые непосредственно профессиональным шеф-поваром.';

  @override
  String get stepbystepAuthenticChineseRecipesWi =>
      'Пошаговые аутентичные китайские рецепты с контролем вока и работой ножом.';

  @override
  String get conciseCulinaryVocabularyAndClearIn =>
      'Лаконичный кулинарный словарь и чёткие инструкции на естественном мандарине.';

  @override
  String get cinematographyCuttingedgeCameraTech =>
      'Кинематография, передовые технологии камер и глубокий анализ цифровых медиа.';

  @override
  String get highproductionDocumentaryStyleExplo =>
      'Высококачественные документальные фильмы, исследующие создание видео и инновации ИИ.';

  @override
  String get richTechnicalMandarinWithCrystalcle =>
      'Богатый технический мандарин с кристально чистым произношением и визуальными субтитрами.';

  @override
  String get indepthInvestigativeJournalismAndCu =>
      'Глубокая расследовательская журналистика и комментарии по текущим событиям.';

  @override
  String get criticalPerspectivesOnSocialPhenome =>
      'Критический взгляд на социальные явления, мировые новости и историю.';

  @override
  String get formalInvestigativeDiscourseIdealFo =>
      'Формальный исследовательский дискурс, идеальный для продвинутого понимания на слух.';

  @override
  String get bitesizedAnimatedScienceDocumentari =>
      'Короткие анимированные научные документальные фильмы, отвечающие на повседневные вопросы.';

  @override
  String get exploresPhysicsBiologyAndEverydayCu =>
      'Исследует физику, биологию и повседневные любопытства с помощью забавной инфографики.';

  @override
  String get standardBeijingMandarinWithWellpace =>
      'Стандартный пекинский мандарин с размеренным повествованием и четкими субтитрами.';

  @override
  String get heartwarmingStreetFoodAdventuresAnd =>
      'Трогательные приключения с уличной едой и искренние беседы по всему Китаю.';

  @override
  String get exploresRegionalHumanStoriesFamilyT =>
      'Исследует региональные человеческие истории, семейные традиции и местные деликатесы.';

  @override
  String get naturalConversationalMandarinWithDa =>
      'Естественный разговорный мандарин с повседневным сленгом и эмоциональной теплотой.';

  @override
  String get humorousAndHonestConsumerElectronic =>
      'Юмористические и честные обзоры потребительской электроники из реального опыта.';

  @override
  String get testingSmartphonesSmartHomeGadgetsA =>
      'Тестирование смартфонов, гаджетов для умного дома и устройств для технологичного образа жизни.';

  @override
  String get relaxedHumorousConversationalDialog =>
      'Расслабленный, юмористический разговорный диалог с современными разговорными выражениями.';

  @override
  String get seanKitchen => 'Кухня Шона';

  @override
  String get deliciousHomecookedChineseDishesAnd =>
      'Вкусные домашние китайские блюда и воссоздание уличных закусок.';

  @override
  String get easytofollowKitchenTipsForCookingAu =>
      'Простые кулинарные советы по приготовлению аутентичной азиатской домашней еды.';

  @override
  String get warmInvitingCommentaryWithPractical =>
      'Теплые, располагающие комментарии с практической кухонной лексикой.';

  @override
  String get chineseChannel => 'Китайский канал';

  @override
  String get structuredChineseLanguageLessonsAnd =>
      'Структурированные уроки китайского языка и обучающие материалы по культурным открытиям.';

  @override
  String get grammarPointsHskVocabularyBuildingA =>
      'Грамматические правила, пополнение словарного запаса HSK и разговорные модели.';

  @override
  String get clearEducationalPacingTailoredSpeci =>
      'Четкий образовательный темп, специально разработанный для изучающих китайский язык.';

  @override
  String get oneInABillion => 'Один на миллиард';

  @override
  String get intimatePortraitsAndStoriesOfUnique =>
      'Интимные портреты и истории уникальных личностей в современном Китае.';

  @override
  String get exploresDiverseLifeChoicesYouthCult =>
      'Исследует разнообразный выбор жизненного пути, молодежную культуру и современные социальные изменения.';

  @override
  String get deepNarrativeStorytellingWithRichVo =>
      'Глубокое повествование с богатым словарным запасом и аутентичными голосами.';

  @override
  String get vickySoup => 'Суп Вики';

  @override
  String get aestheticLifestyleVlogsFashionStyli =>
      'Эстетические лайфстайл-влоги, модный стайлинг и повседневные рутины.';

  @override
  String get travelDiariesAndCozyLifeMomentsDocu =>
      'Путевые дневники и уютные моменты жизни, задокументированные с кинематографической теплотой.';

  @override
  String get naturalCasualMandarinSpokenAtAComfo =>
      'Естественный повседневный мандарин, произносимый в комфортном, выразительном темпе.';

  @override
  String get tededMandarin => 'TED-Ed Мандарин';

  @override
  String get highqualityAnimatedEducationalLesso =>
      'Высококачественные анимированные образовательные уроки по науке, философии и истории.';

  @override
  String get thoughtprovokingRiddlesClassicLiter =>
      'Загадки, заставляющие задуматься, классическая литература и тайны психологии.';

  @override
  String get impeccableVoiceoverMandarinWithSync =>
      'Безупречный закадровый мандарин с синхронизированными двуязычными субтитрами.';

  @override
  String get channel => 'Канал';

  @override
  String get curatedCulturalDocumentariesAndChin =>
      'Культурные документальные фильмы и яркие моменты китайского образа жизни.';

  @override
  String get exploringTraditionalArtsHeritageCra =>
      'Исследование традиционных искусств, ремесленного наследия и современных тенденций.';

  @override
  String get highQualityAudioWithSynchronizedChi =>
      'Высококачественный звук с синхронизированными китайскими субтитрами.';

  @override
  String get interestingStoriesAndCreativeVideoP =>
      'Интересные истории и креативные видеопроекты в китайском интернете.';

  @override
  String get engagingInterviewsStorytellingAndVi =>
      'Увлекательные интервью, повествования и визуальные исследования.';

  @override
  String get greatListeningMaterialWithStandardP =>
      'Отличный материал для аудирования со стандартным произношением.';

  @override
  String get xVsY => 'X против Y';

  @override
  String get untitled => 'Без названия';

  @override
  String get contemporaryStories => 'Современные истории';

  @override
  String get history => 'История';

  @override
  String get advancedReading => 'Продвинутое чтение';

  @override
  String get intermediateReading => 'Чтение для среднего уровня';

  @override
  String get beginnerReading => 'Чтение для начинающих';

  @override
  String get mandarinBean => 'Mandarin Bean';

  @override
  String get unknown => 'Неизвестно';

  @override
  String get localDb => 'Локальная БД';

  @override
  String get emperorTaizong => 'Император Тай-цзун';

  @override
  String get emperorXuanzong => 'Император Сюань-цзун';

  @override
  String get liBai => 'Ли Бо';

  @override
  String get gradedReader => 'Адаптированное чтение';

  @override
  String get ucj10r97lkwgdtqbt6xzv8gLearnMandari =>
      'UCJ10R97LkwGdTqBT6xz-v8g\': \'Изучайте мандарин с TaiwanPlus';

  @override
  String get ucsxriuqkzzmaqklq0n9xfvwEverydayChi =>
      'UCSXriUqkzZmAQklQ0N9XFVw\': \'Повседневный китайский';

  @override
  String get graceMandarinChinese => 'Grace Mandarin Chinese';

  @override
  String get ucolbhvvl5dcjlmzeqbuu1vwTingdailyLi =>
      'UCOLBhVvL5dcJLMZeQBUu1Vw\': \'Тин — Повседневная жизнь в Китае';

  @override
  String get xinxin => 'Синьсинь';

  @override
  String get sweetFamilyDailyLife => 'Сладкая семейная повседневная жизнь';

  @override
  String get chinsunDailyLife => 'Повседневная жизнь Чин-Сун';

  @override
  String get tasteChina => 'Вкус Китая';

  @override
  String get dawenFoodQuest => 'Кулинарный квест ДаВэня';

  @override
  String get chinaTravelWithCangbao => 'Путешествие по Китаю с Цанбао';

  @override
  String get alinFoodWalk => 'Кулинарная прогулка Алин';

  @override
  String get videoOfTheDay => 'ВИДЕО ДНЯ';

  @override
  String get noValidVideoFound => 'Действительное видео не найдено.';

  @override
  String get listeningPractice => 'ПРАКТИКА АУДИРОВАНИЯ';

  @override
  String get socialSkills => 'СОЦИАЛЬНЫЕ НАВЫКИ';

  @override
  String get culturalContext => 'КУЛЬТУРНЫЙ КОНТЕКСТ';

  @override
  String get realLife => 'РЕАЛЬНАЯ ЖИЗНЬ';

  @override
  String get realWorld => 'РЕАЛЬНЫЙ МИР';

  @override
  String get articleOfTheDay => 'СТАТЬЯ ДНЯ';

  @override
  String get failedToLoadOrParseRssFeed =>
      'Не удалось загрузить или разобрать RSS-ленту.';

  @override
  String get drama => 'Драма';

  @override
  String get youkugetAppNow => 'YOUKU – Скачать приложение сейчас';

  @override
  String get romanceTrailer => 'Романтика\', \'Трейлер';

  @override
  String get romance => 'Романтика';

  @override
  String get action => 'Боевик';

  @override
  String get mystery => 'Детектив';

  @override
  String get historical => 'Исторический';

  @override
  String get historicalAction => 'Исторический\', \'Боевик';

  @override
  String get historicalRomance => 'Исторический\', \'Романтика';

  @override
  String get anYouth => 'Молодежный';

  @override
  String get historicalSliceOfLife => 'Исторический\', \'Повседневность';

  @override
  String get historicalHighlight => 'Исторический\', \'Избранное';

  @override
  String get youkuEnglishgetAppNow =>
      'YOUKU English – Скачать приложение сейчас';

  @override
  String get theDouble => 'Двойник';

  @override
  String get updatesByOshin => 'Обновления от Ошин';

  @override
  String get backFromTheBrink => 'Возвращение с края';

  @override
  String get fallingIntoYourSmile => 'Влюбиться в твою улыбку';

  @override
  String get everyoneLovesMe => 'Все меня любят';

  @override
  String get tillTheEndOfTheMoon => 'До конца луны';

  @override
  String get theBestDayOfMyLife => 'Лучший день моей жизни';

  @override
  String get gikkiChineseDrama => 'Китайская драма GIKKI';

  @override
  String get dashingYouth => 'Отважная молодость';

  @override
  String get rebornChineseDramaEngSub =>
      'Китайская драма «Перерождение» с англ. субтитрами';

  @override
  String get ijenwaBenita => 'Идженва Бенита';

  @override
  String get whenIFlyTowardsYou => 'Когда я лечу к тебе';

  @override
  String get mztvExclusiveChineseDrama => 'Эксклюзивная китайская драма MZTV';

  @override
  String get theStarryLove => 'Звездная любовь';

  @override
  String get comedy => 'Комедия';

  @override
  String get backFromTheBrink1 => 'Возвращение с края\':';

  @override
  String get dashingYouth1 => 'Отважная молодость\':';

  @override
  String get beReborn => 'Переродиться';

  @override
  String get beautyStrategy => 'Стратегия красоты';

  @override
  String get myDivineEmissary => 'Мой божественный посланник';

  @override
  String get theHope => 'Надежда';

  @override
  String get ep16In => 'ЭП16\': \'В';

  @override
  String get everyoneLovesMe1 => 'Все меня любят\': \'';

  @override
  String get fallingIntoYourSmile1 => 'Влюбиться в твою улыбку\':';

  @override
  String get hiddenLove => 'Скрытая любовь\':';

  @override
  String get loveBetweenFairyAndDevil => 'Любовь между феей и дьяволом\':';

  @override
  String get loveLikeTheGalaxy => 'Любовь, как галактика\':';

  @override
  String get membersPremiere => 'Премьера для подписчиков';

  @override
  String get moonlight => 'Лунный свет';

  @override
  String get myJourneyToYou => 'Мой путь к тебе\':';

  @override
  String get mysteriousLotusCasebook => 'Загадочный лотосовый дневник\':';

  @override
  String get rebornChineseDramaEngSub1 =>
      'Китайская драма «Перерождение» с англ. субтитрами\': \'';

  @override
  String get reborn => 'Перерождение';

  @override
  String get theBestDayOfMyLife1 => 'Лучший день моей жизни\': \'';

  @override
  String get theDouble1 => 'Двойник\':';

  @override
  String get theLongBallad => 'Длинная баллада\':';

  @override
  String get theStarryLove1 => 'Звездная любовь\':';

  @override
  String get theUntamed => 'Неукротимый\':';

  @override
  String get tillTheEndOfTheMoon1 => 'До конца луны\':';

  @override
  String get whenIFlyTowardsYou1 => 'Когда я лечу к тебе\':';

  @override
  String get wordOfHonor => 'Слово чести\':';

  @override
  String get blossom => 'Цветение';

  @override
  String get gemini => 'Близнецы';

  @override
  String get generationToGeneration => 'Из поколения в поколение';

  @override
  String get brocadeOdyssey => 'Парчовая одиссея';

  @override
  String get circleOfLove => 'Круг любви';

  @override
  String get dawnIsBreaking => 'Рассвет наступает';

  @override
  String get firstRomance => 'Первая романтика';

  @override
  String get loveInTheClouds => 'Любовь в облаках';

  @override
  String get secondChanceRomance => 'Романтика второго шанса';

  @override
  String get mrBad => 'Мистер Плохиш';

  @override
  String get pursuitOfJade => 'В погоне за нефритом';

  @override
  String get fatedHearts => 'Судьбоносные сердца';

  @override
  String get roadHome => 'Дорога домой';

  @override
  String get myDearGuardian => 'Мой дорогой хранитель';

  @override
  String get brightEyesInTheDark => 'Яркие глаза во тьме';

  @override
  String get theIngeniousOne => 'Гениальный';

  @override
  String get herPhoenixMajesty => 'Её Величество Феникс';

  @override
  String get dreamsNeverEnd => 'Мечты не умирают';

  @override
  String get theUltimateVowUnknownToYou => 'Высшая клятва, тебе неведомая';

  @override
  String get the300LoyalGhosts => '300 верных призраков';

  @override
  String get homelandGuardian => 'Хранитель родины';

  @override
  String get loveIsAlwaysOnline => 'Любовь всегда онлайн';

  @override
  String get thePrincessDecree => 'Указ принцессы';

  @override
  String get aVowInTheDark => 'Клятва во тьме';

  @override
  String get aGirlLikeMe => 'Девушка, как я';

  @override
  String get iAmNobody => 'Я никто';

  @override
  String get myMamaGo => 'Моя мама, вперёд!';

  @override
  String get myWesternRegionPrincess => 'Моя принцесса Западного края';

  @override
  String get aFlowerOnTheContinent => 'Цветок на континенте';

  @override
  String get thePrincess => 'Принцесса';

  @override
  String get sweetLoveVersion => 'Версия «Сладкая любовь»';

  @override
  String get hilariousFamily2 => 'Весёлая семейка 2';

  @override
  String get guYuanMountainHasASchool => 'На горе Гу Юань есть школа';

  @override
  String get foreverYoung => 'Вечно молодой';

  @override
  String get theHiddenHeirYeChen => 'Скрытый наследник Е Чэнь';

  @override
  String get extraordinary => 'Необыкновенный';

  @override
  String get sideStoryOfFoxVolant => 'Побочная история Летающей Лисы';

  @override
  String get loveOfTheDivineTree => 'Любовь Божественного Древа';

  @override
  String get rebirth => 'Перерождение';

  @override
  String get moonlitReunion => 'Лунное воссоединение';

  @override
  String get videoCountsCannotBeNegative =>
      'Количество видео не может быть отрицательным.';

  @override
  String get publicDomainClassic => 'Классика общественного достояния';

  @override
  String get idioms => 'Идиомы';

  @override
  String get news => 'Новости';

  @override
  String get fairyTales => 'Сказки';

  @override
  String get hereIsAFascinatingCulturalExplanati =>
      'Вот увлекательное культурное объяснение';

  @override
  String get videoFetchTimedOut => 'Время загрузки видео истекло';

  @override
  String get aboutChannel => 'О КАНАЛЕ';

  @override
  String get noVideosFound => 'Видео не найдены';

  @override
  String get failedToLoadVideos => 'Не удалось загрузить видео';

  @override
  String get highqualityCuratedMandarinContentWi =>
      'Высококачественный мандаринский контент с естественной лексикой.';

  @override
  String get authenticSpokenChineseAcrossRealwor =>
      'Аутентичная разговорная китайская речь на реальные темы.';

  @override
  String get engagingVideoMaterialWithInteractiv =>
      'Увлекательные видеоматериалы с интерактивными синхронизированными субтитрами.';

  @override
  String get watchVideo => 'Смотреть видео';

  @override
  String get culturalInsight => 'Культурный обзор';

  @override
  String get aiIsAnalyzingCulturalContext =>
      'ИИ анализирует культурный контекст...';

  @override
  String get diveIntoFullContent => 'Погрузитесь в полный контент';

  @override
  String get savedArticles => 'Сохранённые статьи';

  @override
  String get liveOverlay => 'ЖИВОЙ ОВЕРЛЕЙ';

  @override
  String get webExplorer => 'ВЕБ-ПРОВОДНИК';

  @override
  String get browseAnyChineseWebsiteWithRealtime =>
      'Просматривайте любые китайские веб-сайты с мгновенным словарём по касанию, аннотациями пиньинь и моментальным переводом.';

  @override
  String get startExploring => 'НАЧАТЬ ИССЛЕДОВАНИЕ';

  @override
  String get chineseTvSeriesWithInteractiveSubti =>
      'Китайские сериалы с интерактивными субтитрами';

  @override
  String get failedToLoadContent => 'Не удалось загрузить контент';

  @override
  String get searchingYoutube => 'Поиск на YouTube...';

  @override
  String get noVideosFoundTryADifferentSearchTer =>
      'Видео не найдены. Попробуйте другой поисковый запрос.';

  @override
  String get searching => 'Поиск';

  @override
  String get noShowsFound => 'Передачи не найдены';

  @override
  String get bookmarked => 'В закладках';

  @override
  String get trailer1 => 'Трейлер';

  @override
  String get highlight1 => 'Основное';

  @override
  String get noCaptionsAvailable => 'Субтитры недоступны';

  @override
  String get fetchingSubtitles => 'Загрузка субтитров...';

  @override
  String get generatingAiBriefing => 'Генерация сводки ИИ...';

  @override
  String get noClosedCaptionsCcFoundForThisVideo =>
      'Для этого видео не найдены скрытые субтитры (CC).';

  @override
  String get videosWithHardcodedOrBurnedinSubtit =>
      'Видео с вшитыми или встроенными субтитрами не имеют цифровых текстовых дорожек на YouTube.';

  @override
  String get translatingSubtitles => 'Перевод субтитров...';

  @override
  String get processingYourPronunciation => 'Обработка вашего произношения...';

  @override
  String get couldntIdentifyLine => 'Не удалось распознать строку.';

  @override
  String get listeningSpeakNow => 'Слушаю... говорите сейчас.';

  @override
  String get thisVideoDoesNotHaveADigitalClosedC =>
      'Это видео не имеет цифровых субтитров (CC) на YouTube.';

  @override
  String get perfect1 => 'Идеально';

  @override
  String get thisVideoHasBeenRemovedOrIsNoLonger =>
      'Это видео было удалено или больше недоступно.';

  @override
  String get thisVideoCannotBePlayedInTheAppYouC =>
      'Это видео нельзя воспроизвести в приложении. Вы можете посмотреть его на YouTube.';

  @override
  String get yourDeviceCannotPlayThisVideoPlease =>
      'Ваше устройство не может воспроизвести это видео. Пожалуйста, попробуйте другое.';

  @override
  String get invalidVideoReferencePleaseTryAgain =>
      'Неверная ссылка на видео. Пожалуйста, попробуйте снова.';

  @override
  String get unableToLoadThisVideoPleaseTryAnoth =>
      'Не удалось загрузить это видео. Пожалуйста, попробуйте другое.';

  @override
  String get startReading => 'Начать чтение';

  @override
  String get analyzingCulturalContext => 'Анализ культурного контекста...';

  @override
  String get failedToLoadCulturalInsight =>
      'Не удалось загрузить культурную информацию.';

  @override
  String get historicalContext => 'Исторический контекст';

  @override
  String get culturalSignificance => 'Культурное значение';

  @override
  String get authorBackground => 'Об авторе';

  @override
  String get k80CompleteClassicNovelsWorldEpics =>
      '80+ полных классических романов и мировых эпосов';

  @override
  String get storyOfTheDay => 'ИСТОРИЯ ДНЯ';

  @override
  String get tangDynasty => 'Династия Тан';

  @override
  String get poetryClassicalVerse => 'Поэзия\', \'Классика\', \'Стих';

  @override
  String get allHsk => 'Все HSK';

  @override
  String get allStories => 'Все истории\':';

  @override
  String get keyWords => 'Ключевые слова';

  @override
  String get openOriginalWebsite => 'Открыть оригинальный сайт';

  @override
  String get aiReadingTools => 'Инструменты для чтения с ИИ';

  @override
  String get enhanceYourReadingWithAipoweredTool =>
      'Улучшите свое чтение с помощью инструментов на базе ИИ';

  @override
  String get chooseTheTargetDifficultyForSimplif =>
      'Выберите целевой уровень сложности для упрощения';

  @override
  String get chooseDifficultyForSimplification =>
      'Выберите сложность для упрощения';

  @override
  String get extractAllUnknownWordsToANewFlashca =>
      'Извлечь все незнакомые слова в новую колоду карточек';

  @override
  String get length => 'Длина';

  @override
  String get m1554846a550010707 => 'M15.54 8.46a5 5 0 0 1 0 7.07';

  @override
  String get m1907493a101000101414 => 'M19.07 4.93a10 10 0 0 1 0 14.14';

  @override
  String get webExtraction => 'Веб-извлечение';

  @override
  String get aiTools => 'Инструменты ИИ';

  @override
  String get stop => 'Стоп';

  @override
  String get keepPracticing1 => 'Продолжайте практиковаться';

  @override
  String get aiPrepRoom => 'Комната подготовки ИИ';

  @override
  String get lessonSummary => 'ИТОГИ УРОКА';

  @override
  String get unlockSinosparkPremium => 'Разблокировать SinoSpark Premium';

  @override
  String get monthYear => 'Месяц\' : \'Год';

  @override
  String get enableNotifications => 'Включить уведомления';

  @override
  String get notificationsConfigured => 'Уведомления настроены';

  @override
  String get neverMissAStroke2 => 'Не пропустите ни одной черты';

  @override
  String get yourDailyDropAndStreakAlertsArePrim =>
      'Ваши ежедневные уведомления о новых словах и сериях готовы.';

  @override
  String get stayConsistentWithDailyRitualDropsA =>
      'Будьте последовательны с ежедневными ритуальными уроками и своевременными напоминаниями о пробной версии.';

  @override
  String get aNewWordAndStoryWaitingForYourDaily =>
      'Новое слово и история ждут вашего ежедневного ритуала.';

  @override
  String get gentlePromptsBeforeCharactersFadeFr =>
      'Мягкие напоминания, прежде чем иероглифы исчезнут из вашей памяти.';

  @override
  String get receiveAReminder2DaysBeforeYourFree =>
      'Получите напоминание за 2 дня до окончания вашей бесплатной пробной версии.';

  @override
  String get yourPathTonchineseFluency =>
      'Ваш путь к\\nсвободному владению китайским';

  @override
  String get answer3QuickQuestionsSoOurAiCanCraf =>
      'Ответьте на 3 коротких вопроса, чтобы наш ИИ мог создать\\nучебный план, который подходит именно вам.';

  @override
  String get whatIsYourLevelnwithChinese =>
      'Какой у вас уровень\\nкитайского языка?';

  @override
  String get chooseThePathThatFitsYourDepth =>
      'Выберите путь, соответствующий вашему уровню.';

  @override
  String get whatDrivesYourStudy => 'Что мотивирует ваше обучение?';

  @override
  String get purposeFuelsTheBrush => 'Цель питает кисть';

  @override
  String get setYourDailyRitual => 'Установите свой ежедневный ритуал.';

  @override
  String get youCanAdjustYourRitualAnyTime =>
      'Вы можете изменить свой ритуал в любое время.';

  @override
  String get letsBegin => 'Начнем';

  @override
  String get brandNew => 'Новичок';

  @override
  String get iveNeverStudiedChineseBefore =>
      'Я никогда раньше не изучал китайский.';

  @override
  String get iKnowBasicCharactersAndPhrases =>
      'Я знаю базовые иероглифы и фразы.';

  @override
  String get iCanHoldConversationsAndRead =>
      'Я могу поддерживать разговор и читать.';

  @override
  String get iWantToRefineAndPerfectMySkills =>
      'Я хочу отточить и усовершенствовать свои навыки.';

  @override
  String get confirmSelection => 'Подтвердить выбор';

  @override
  String get purposeFuelsTheBrushsMotion => 'Цель питает движение кисти.';

  @override
  String get buildMyPath => 'Построить мой путь';

  @override
  String get hskCertification => 'Сертификация HSK';

  @override
  String get culturalAppreciation => 'Культурное обогащение';

  @override
  String get yourPlanIsReady => 'Ваш план готов';

  @override
  String get craftingYourCurriculum => 'Составление вашего учебного плана';

  @override
  String get personalizedPathInitialized =>
      'ПЕРСОНАЛИЗИРОВАННЫЙ ПУТЬ ИНИЦИАЛИЗИРОВАН';

  @override
  String get calibratingAiNeuralMasters =>
      'КАЛИБРОВКА НЕЙРОННЫХ МАСТЕРОВ ИИ...';

  @override
  String get calibrationComplete => 'Калибровка завершена';

  @override
  String get synthesizingModules => 'Синтез модулей...';

  @override
  String get oneAndWater => '\'Один\' и \'Вода\'';

  @override
  String get theHorizontalStroke => 'ГОРИЗОНТАЛЬНАЯ ЧЕРТА';

  @override
  String get theRadical => 'КЛЮЧ';

  @override
  String get water => 'Вода';

  @override
  String get river => 'Река';

  @override
  String get day5Reminder => 'Напоминание: День 5';

  @override
  String get wePromisedToAlertYou2DaysBeforeYour =>
      'Мы обещали уведомить вас за 2 дня до окончания пробного периода, чтобы вы';

  @override
  String get continueWithoutReminder => 'Продолжить без напоминания';

  @override
  String get masterChineseWithnsinospark => 'Освойте китайский с\\nSinoSpark';

  @override
  String get start7dayFreeTrial => 'Начать 7-дневную бесплатную пробную версию';

  @override
  String get precisionStrokes => 'Точные штрихи';

  @override
  String get aiPronunciation => 'Произношение ИИ';

  @override
  String get today => 'Сегодня';

  @override
  String get fullAccess => 'Полный доступ';

  @override
  String get day5 => 'День 5';

  @override
  String get reminder => 'Напоминание';

  @override
  String get day7 => 'День 7';

  @override
  String get trialBegins => 'Пробный период начинается';

  @override
  String get revenuecatIsMissingACurrentOffering =>
      'В RevenueCat отсутствует текущее предложение или пакеты. Пожалуйста, настройте свою панель управления.';

  @override
  String get cameraPermissionRequiredForLiveScan =>
      'Для живого сканирования требуется разрешение камеры.';

  @override
  String get cameraAccessRequired => 'Требуется доступ к камере';

  @override
  String get pleaseEnableCameraAccessInYourDevic =>
      'Пожалуйста, включите доступ к камере в настройках вашего устройства, чтобы использовать эту функцию.';

  @override
  String get alignChineseTextWithinFrame =>
      'Выровняйте китайский текст в рамке';

  @override
  String get inLibrary => 'В библиотеке';

  @override
  String get novice => 'Новичок';

  @override
  String get apprentice => 'Ученик';

  @override
  String get artisan => 'Мастер';

  @override
  String get grandmaster => 'Грандмастер';

  @override
  String get poem => 'Поэма';

  @override
  String get theNarrative => 'Повествование';

  @override
  String get classicMasterpiece => 'Классический шедевр';

  @override
  String get classicAuthor => 'Классический автор';

  @override
  String get classical => 'Классический';

  @override
  String get classicLiterature => 'Классика\', \'Литература';

  @override
  String get inThisChapterOf => 'В этой главе';

  @override
  String get asTheNarrativeUnfoldsItIlluminatesT =>
      'По мере развития повествования оно раскрывает фундаментальную мудрость жизни и вечное вдохновение.';

  @override
  String get general => 'Общее';

  @override
  String get mythology => 'Мифология';

  @override
  String get dailyLife => 'Повседневная жизнь';

  @override
  String get tangPoetry => 'Поэзия Тан';

  @override
  String get classicalLiterature => 'Классическая литература';

  @override
  String get justNow => 'Только что';

  @override
  String get theTerracottaArmyOfQinShiHuang =>
      'Терракотовая армия Цинь Шихуанди';

  @override
  String get lifeInsideTheForbiddenCity => 'Жизнь в Запретном городе';

  @override
  String get buyingATicketAndTakingTheHighSpeedT =>
      'Покупка билета и поездка на скоростном поезде в Китае';

  @override
  String get goingToTheHospitalForAColdAndSeeing =>
      'Поход в больницу с простудой и визит к врачу';

  @override
  String get goingToALocalRestaurantToOrderJiaoz =>
      'Поход в местный ресторан, чтобы заказать цзяоцзы (пельмени)';

  @override
  String get theTraditionalGongfuTeaCeremony =>
      'Традиционная чайная церемония Гунфу';

  @override
  String get theArtOfWritingChineseCharactersWit =>
      'Искусство написания китайских иероглифов кистью';

  @override
  String get theLifeAndConservationOfGiantPandas =>
      'Жизнь и сохранение больших панд';

  @override
  String get storyNotFoundInDatabase => 'История не найдена в базе данных';

  @override
  String get storyTextIsEmpty => 'Текст истории пуст';

  @override
  String get myCustomStories => 'Мои пользовательские истории';

  @override
  String get userProvidedText => 'Текст, предоставленный пользователем';

  @override
  String get local => 'Локальный';

  @override
  String get voiceEngineAllowance => 'Голосовой движок и лимит';

  @override
  String get studioHdVsUnlimitedStandardVoice =>
      'Studio HD против безлимитного стандартного голоса';

  @override
  String get standardVoiceIs100UnlimitedFree =>
      'Стандартный голос на 100% безлимитен и бесплатен';

  @override
  String get read => 'Читать';

  @override
  String get koreKoreFemaleWarm => 'Коре\', \'Коре\', \'Женский, теплый';

  @override
  String get aoedeAoedeFemaleCheerful =>
      'Эоэда\', \'Эоэда\', \'Женский, жизнерадостный';

  @override
  String get fenrirFenrirMaleUpbeat =>
      'Фенрир\', \'Фенрир\', \'Мужской, энергичный';

  @override
  String get charonCharonMaleNewsstyle =>
      'Харон\', \'Харон\', \'Мужской, новостной стиль';

  @override
  String get puckPuckMaleSporty => 'Пак\', \'Пак\', \'Мужской, спортивный';

  @override
  String get localOndevice => 'Локальный\', \'На устройстве';

  @override
  String get localOndeviceTts => 'Локальный TTS на устройстве';

  @override
  String get off => 'Выкл.';

  @override
  String get endOfCurrentChapter => 'Конец текущей главы';

  @override
  String get standardVoice => 'Стандартный голос';

  @override
  String get noNovelsFoundMatchingYourFilter =>
      'Романы по вашему фильтру не найдены.';

  @override
  String get noMicroreadsFoundMatchingYourFilter =>
      'Микрочтения по вашему фильтру не найдены.';

  @override
  String get noPoemsFoundMatchingYourFilter =>
      'Стихи по вашему фильтру не найдены.';

  @override
  String get audiobook => 'Аудиокнига';

  @override
  String get audio => 'Аудио';

  @override
  String get continueReading => 'Продолжить чтение';

  @override
  String get search96FullNovelsAuthorsEpics =>
      'Поиск 96 полных романов, авторов, эпосов...';

  @override
  String get searchClassicalPoemsAuthorsVerses =>
      'Поиск классических стихов, авторов, строф...';

  @override
  String get allLevelsVal => 'Все уровни\', \'val';

  @override
  String get hsk1BeginnerVal => 'HSK 1 (Начальный)\', \'val';

  @override
  String get hsk2ElementaryVal => 'HSK 2 (Элементарный)\', \'val';

  @override
  String get hsk3IntermediateVal => 'HSK 3 (Средний)\', \'val';

  @override
  String get hsk4UpperIntVal => 'HSK 4 (Выше среднего)\', \'val';

  @override
  String get listenToAudiobook => 'Слушать аудиокнигу';

  @override
  String get synopsis => 'Синопсис';

  @override
  String get peoplesArtist => 'Народный артист\'.';

  @override
  String get kafkaesqueForBureaucraticAbsurdityA =>
      'Кафкианский\' для обозначения бюрократического абсурда, отчуждения и экзистенциального ужаса.';

  @override
  String get bigBrotherAndNewspeak => 'Большой Брат\' и \'Новояз\'.';

  @override
  String get audiobookIncluded => 'Аудиокнига включена';

  @override
  String get readPoem => 'Читать стихотворение';

  @override
  String get studioVoiceAllowance => 'Лимит студийного голоса';

  @override
  String get weeklyHighdefinitionAiRecitation =>
      'Еженедельное высококачественное AI-озвучивание';

  @override
  String get resetsEveryMondayAt0000 =>
      'Обновляется каждый понедельник в 00:00';

  @override
  String get whenYourWeekly4hourStudioAllowanceI =>
      'Когда ваш еженедельный 4-часовой лимит студийного голоса исчерпан, приложение автоматически переключается на голос устройства для неограниченного, бесплатного прослушивания без перерывов.';

  @override
  String get localDeviceVoice => 'Голос устройства\' :';

  @override
  String get classicalVerse => 'Классический стих';

  @override
  String get ondeviceVoice4hWeeklyUsed =>
      'Голос устройства (4 ч. в неделю использовано)';

  @override
  String get generateACustomAiStoryBasedOnYourIn =>
      'Сгенерировать индивидуальную AI-историю по вашим интересам';

  @override
  String get insteadOfAFixedHskLevelTheFlowState =>
      'Вместо фиксированного уровня HSK, движок Flow State анализирует вашу библиотеку карточек.\\n\\n';

  @override
  String get we => 'Мы';

  @override
  String get howCanWeHelpYou => 'Чем мы можем вам помочь?';

  @override
  String get everythingYouNeedToKnowAboutHanziMa =>
      'Все, что вам нужно знать о Hanzi Master, его функциях и вашей конфиденциальности.';

  @override
  String get whoAreTheVoicesSpeakingInTheApp => 'Кто озвучивает приложение?';

  @override
  String get howDoesTheWebExplorerWork => 'Как работает Веб-проводник?';

  @override
  String get whatIsZenMode => 'Что такое Дзен-режим?';

  @override
  String get howDoesTheFlashcardSpacedrepetition =>
      'Как работает интервальное повторение карточек?';

  @override
  String get traceComplete => 'Обводка завершена!';

  @override
  String get traceCharacter => 'Обвести иероглиф';

  @override
  String get analyzingWordRelationships => 'Анализ связей между словами...';

  @override
  String get identifyingUsageContexts =>
      'Определение контекстов использования...';

  @override
  String get comparingFormalityLevels => 'Сравнение уровней формальности...';

  @override
  String get findingCommonCollocations => 'Поиск общих словосочетаний...';

  @override
  String get generatingComparison => 'Генерация сравнения...';

  @override
  String get generationIsTakingLongerThanExpecte =>
      'Генерация занимает больше времени, чем ожидалось. Возможно, AI перегружен.';

  @override
  String get generationInterruptedShowingPartial =>
      'Генерация прервана. Показан частичный результат.';

  @override
  String get sorrySomethingWentWrong => 'Извините, что-то пошло не так.';

  @override
  String get usage => 'Использование:\', \'';

  @override
  String get alsoSeenIn => 'Также встречается в';

  @override
  String get quickLook => 'Быстрый просмотр';

  @override
  String get notFound => 'Не найдено';

  @override
  String get errorLoadingFromAi => 'Ошибка загрузки от AI.';

  @override
  String get newLabel => 'Новое';

  @override
  String get analyzingImage => 'Анализ изображения...';

  @override
  String get extractingChineseText => 'Извлечение китайского текста...';

  @override
  String get lookingUpVocabulary => 'Поиск словарных слов...';

  @override
  String get dreamOfTheRedChamber => 'Сон в красном тереме';

  @override
  String get journeyToTheWest => 'Путешествие на Запад';

  @override
  String get romanceOfTheThreeKingdoms => 'Троецарствие';

  @override
  String get mingDynasty => 'Династия Мин';

  @override
  String get wuChengEn => 'У Чэньэнь';

  @override
  String get hundredChapters => '100 глав';

  @override
  String get volume1 => 'Том 1';

  @override
  String bookmarksCount(Object count) {
    return 'Закладки ($count)';
  }

  @override
  String get noBookmarksYet =>
      'Пока нет закладок. Нажмите значок закладки, чтобы сохранить отрывок.';

  @override
  String get sinosparkIsNotResponding => 'SinoSpark не отвечает';

  @override
  String get closeApp => 'Закрыть приложение';

  @override
  String get wait => 'Подождите';

  @override
  String studioHdAllowance(Object hours) {
    return 'Studio HD: $hoursч';
  }

  @override
  String bookPercentRead(Object percent) {
    return 'Книга $percent%';
  }

  @override
  String chAbbreviation(Object number) {
    return 'Гл. $number';
  }

  @override
  String booksAndAudiobooks(Object count) {
    return '$count книг и аудиокниг';
  }

  @override
  String sentenceXOfY(Object current, Object total) {
    return 'Предложение $current из $total';
  }

  @override
  String chapterXOfY(Object current, Object total) {
    return 'Глава $current из $total';
  }

  @override
  String get allLevels => 'Все уровни';

  @override
  String get searchGradedMicroStories =>
      'Поиск адаптированных микроисторий и басен...';

  @override
  String gradedStoriesAndMicroReads(Object count) {
    return '$count адаптированных историй и ежедневных микрочтений';
  }

  @override
  String get searchClassicalPoems =>
      'Поиск классических стихов, авторов, строф...';

  @override
  String classicalPoemsAndVerse(Object count) {
    return '$count классических стихов и поэм';
  }

  @override
  String get browseAnyChineseWebsite =>
      'Просматривайте любой китайский веб-сайт с косновенным словарем в реальном времени, аннотациями пиньинь и мгновенными переводами.';

  @override
  String get completed => 'ЗАВЕРШЕНО';

  @override
  String get aiIsReading => 'ИИ читает...';

  @override
  String get bbcVerify => 'BBC VERIFY';

  @override
  String get hsk5AdvancedVal => 'HSK 5 (Продвинутый)';

  @override
  String get hsk1Beginner => 'HSK 1 (Начинающий)';

  @override
  String get hsk4UpperInt => 'HSK 4 (Выше среднего)';

  @override
  String get extractAllUnknownWords =>
      'Извлечь все неизвестные слова в новую колоду карточек';

  @override
  String get designCustomAiRoleplay =>
      'Создать свою ролевую игру и беседу с ИИ';

  @override
  String get practiceFlashcardVocabulary =>
      'Практиковать лексику карточек в живом диалоге';

  @override
  String get surpriseMe => 'Удиви меня';

  @override
  String get rollCharacter => 'Выбрать персонажа';

  @override
  String get historicalCostume => 'Исторический / Костюмированный';

  @override
  String get modernYouth => 'Современное & Молодежное';

  @override
  String get fantasyMythology => 'Фэнтези & Мифология';

  @override
  String get familyDrama => 'Семейное & Драма';

  @override
  String get fullVersion => 'Полная версия';

  @override
  String episodesCount(Object count) {
    return '$count эпизодов';
  }

  @override
  String episodeLabel(Object number) {
    return 'ЭП$number';
  }

  @override
  String get translating => '[ Перевод... ]';

  @override
  String get engSub => '[СУБ РУС]';

  @override
  String get standardVocabulary => 'Стандартный словарь';

  @override
  String get characters => '汉字';
}
