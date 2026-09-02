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
  String get deleteAccount => 'Удалить аккаунт';

  @override
  String get deleteAccountSubtitle => 'Безвозвратное удаление вашего аккаунта';

  @override
  String get deleteAccountTitle => 'Удалить аккаунт навсегда?';

  @override
  String get accountDataDeletedTitle => 'Данные аккаунта будут удалены';

  @override
  String get accountDataDeletedBody =>
      'Ваш аккаунт и вся связанная с ним информация в SinoSpark будут удалены безвозвратно. Это действие нельзя отменить.';

  @override
  String get localDataKeptTitle => 'Данные на этом устройстве сохранятся';

  @override
  String get localDataKeptBody =>
      'Прогресс обучения, загруженные материалы и настройки, сохраненные локально на этом устройстве, удалены не будут.';

  @override
  String get subscriptionNotCanceledTitle =>
      'Подписки не отменяются автоматически';

  @override
  String get subscriptionNotCanceledBody =>
      'Удаление аккаунта не отменяет действующую подписку в App Store. Списания могут продолжаться, пока вы не отмените ее в настройках Apple.';

  @override
  String get manageSubscription => 'Управление подпиской в App Store';

  @override
  String get subscriptionManagementFailed =>
      'Не удалось открыть управление подписками Apple. Перейдите в «Настройки» > [ваше имя] > «Подписки».';

  @override
  String get confirmPassword => 'Текущий пароль';

  @override
  String get confirmPasswordToDelete =>
      'Введите пароль для подтверждения личности.';

  @override
  String get deleteAccountPermanently => 'Удалить аккаунт навсегда';

  @override
  String get deleteAccountFinalTitle => 'Подтверждение удаления';

  @override
  String get deleteAccountFinalWarning =>
      'Это действие навсегда удалит ваш аккаунт. Восстановить его будет невозможно. Данные, сохраненные только на этом устройстве, останутся. Продолжить?';

  @override
  String get deletingAccount => 'Удаление аккаунта...';

  @override
  String get accountPasswordRequired =>
      'Введите текущий пароль, чтобы продолжить.';

  @override
  String get accountPasswordIncorrect => 'Неверный пароль. Попробуйте еще раз.';

  @override
  String get accountReauthenticationCanceled =>
      'Подтверждение личности отменено. Аккаунт не был удален.';

  @override
  String get accountReauthenticationFailed =>
      'Не удалось подтвердить личность. Повторите попытку и выполните вход.';

  @override
  String get accountAlreadySignedOut =>
      'Вы уже вышли из системы. Аккаунт не был удален.';

  @override
  String get accountProviderUnsupported =>
      'Этот способ входа не поддерживается для автоматического удаления в приложении. Обратитесь в службу поддержки.';

  @override
  String get appleDeletionRequiresAppleDevice =>
      'В целях безопасности удаление аккаунта с привязкой к Apple должно выполняться с устройства Apple.';

  @override
  String get accountDeletionNetworkError =>
      'Проверьте подключение к интернету и повторите попытку удаления.';

  @override
  String get accountDeletionFailed =>
      'Не удалось удалить аккаунт. Он остается активным. Попробуйте снова.';

  @override
  String get accountDeletedSuccessfully =>
      'Ваш аккаунт был успешно и безвозвратно удален.';

  @override
  String get globalMastery => 'ОБЩИЙ УРОВЕНЬ';

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
  String get searchHanziOrPinyin => 'Поиск по иероглифам или пиньиню...';

  @override
  String get dailyReview => 'Ежедневный повтор';

  @override
  String get upcomingForecast => 'График повторений';

  @override
  String get laterToday => 'Позже сегодня';

  @override
  String get tomorrow => 'Завтра';

  @override
  String get next7Days => 'Ближайшие 7 дней';

  @override
  String get theScholarWay => 'Путь Ученого';

  @override
  String get beginJourney => 'Начать обучение';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get darkMode => 'Темная тема';

  @override
  String get darkModeDesc => 'Комфортно для глаз';

  @override
  String get voiceSpeed => 'Скорость озвучки';

  @override
  String get artAndIntellect => 'ИСКУССТВО И ИНТЕЛЛЕКТ';

  @override
  String get theDigitalScholar => 'Цифровой Ученый';

  @override
  String get refineBrushVoice =>
      'Оттачивайте каллиграфию и произношение с помощью ИИ.';

  @override
  String get liveVoiceCall => 'Голосовой звонок в реальном времени';

  @override
  String get immersiveRoleplay => 'Интерактивная ролевая игра с ИИ';

  @override
  String get readingRoom => 'Читальный зал';

  @override
  String get shadowingStudio => 'Студия теневого повторения (Shadowing)';

  @override
  String get errorPrefix => 'Ошибка: ';

  @override
  String get initializingLibrary => 'Инициализация библиотеки...';

  @override
  String get unlockCharactersToQuiz =>
      'Откройте 4 иероглифа, чтобы начать викторину!';

  @override
  String get practiceQuiz => 'ВИКТОРИНА';

  @override
  String get curriculumPaths => 'УЧЕБНЫЕ ПУТИ';

  @override
  String get noDecksFound => 'Колоды не найдены. Создайте новую!';

  @override
  String get addCardsFirst => 'Сначала добавьте карточки!';

  @override
  String get aiDraftingPath => 'ИИ составляет персональный маршрут...';

  @override
  String get pathReady => 'Учебный путь готов!';

  @override
  String get errorGeneratingPath => 'Ошибка создания пути';

  @override
  String get brushingCurriculum => 'Формирование учебного плана...';

  @override
  String get warmUp => 'РАЗМИНКА';

  @override
  String get lessonComplete => 'Урок пройден! +10 очков туши';

  @override
  String get step1Origin => 'ШАГ 1: ИСТОКИ';

  @override
  String get traceRadical => 'Напишите радикал (ключ)';

  @override
  String get step2Forge => 'ШАГ 2: КУЗНИЦА';

  @override
  String get chooseEssence => 'Выберите ключевой элемент';

  @override
  String get wrongEssence => 'Неверно! Попробуйте еще раз.';

  @override
  String get step3Hunt => 'ШАГ 3: ПОИСК';

  @override
  String get findCharacters => 'Найдите иероглифы';

  @override
  String get notThatOne => 'Не этот!';

  @override
  String get successfullyInstalled => 'Успешно установлено:';

  @override
  String get failedToDownload => 'Не удалось загрузить.';

  @override
  String get rescindTitle => 'Отменить действие?';

  @override
  String get removeCharactersWarning => 'Выбранные иероглифы будут удалены.';

  @override
  String get cancel => 'Отмена';

  @override
  String get uninstall => 'Удалить';

  @override
  String get removedLibrary => 'Удалено из библиотеки:';

  @override
  String get tomeLibrary => 'Библиотека фолиантов';

  @override
  String get libraryError => 'Ошибка библиотеки';

  @override
  String get installTome => 'УСТАНОВИТЬ';

  @override
  String get unitIntro => 'ВВЕДЕНИЕ В РАЗДЕЛ';

  @override
  String get constellationCluster => 'Скопление созвездий';

  @override
  String get ok => 'ОК';

  @override
  String get divingInto => 'Погружаемся в тему...';

  @override
  String get keyRadicals => 'КЛЮЧЕВЫЕ РАДИКАЛЫ';

  @override
  String get noRadicalData => 'Данные отсутствуют.';

  @override
  String get discovery => 'ОТКРЫТИЕ';

  @override
  String get startLearning => 'НАЧАТЬ';

  @override
  String get selectPersona => 'Выбор собеседника';

  @override
  String get customPersona => 'Свой персонаж';

  @override
  String get geminiLiveCall => 'ЖИВОЙ ЗВОНОК';

  @override
  String get returnToMenu => 'Вернуться в меню';

  @override
  String get strokeAnalysis => 'Анализ порядка черт';

  @override
  String get excellentWork => 'Отличная работа!';

  @override
  String get keepPracticing => 'Продолжайте практиковаться!';

  @override
  String get drawingSubmitted => 'Иероглиф отправлен';

  @override
  String get customPersonaHint => 'Задайте характер персонажа...';

  @override
  String get stepOneOrigin => 'ШАГ 1: ИСТОКИ';

  @override
  String get stepTwoForge => 'ШАГ 2: КУЗНИЦА';

  @override
  String get toForge => 'Чтобы создать иероглиф';

  @override
  String get whatEssenceDoesNeed => 'какой элемент требуется';

  @override
  String get need => 'нужен';

  @override
  String get forged => 'СОЗДАНО';

  @override
  String get stepThreeHunt => 'ШАГ 3: ПОИСК';

  @override
  String get findCharactersWith => 'Найдите иероглифы с элементом';

  @override
  String get uninstallButton => 'УДАЛИТЬ';

  @override
  String get gradedAiStories => 'Адаптированные истории от ИИ';

  @override
  String get calligraphy => 'Каллиграфия';

  @override
  String get theScrollOfOrigin => 'Свиток Происхождения';

  @override
  String get galaxyOf => 'Галактика';

  @override
  String get constellationDescription => 'Описание созвездия';

  @override
  String get noRadicalDataAvailable => 'Информация о радикалах отсутствует';

  @override
  String get learningPreferences => 'Настройки обучения';

  @override
  String get hardMode => 'Сложный режим';

  @override
  String get hardModeDesc =>
      'Требует точного написания без вспомогательных контуров.';

  @override
  String get adaptiveGuidance => 'Адаптивные подсказки';

  @override
  String get dailyGoal => 'Ежедневная цель';

  @override
  String get audioAndHaptics => 'Звук и тактильный отклик';

  @override
  String get autoPlayAudio => 'Автовоспроизведение аудио';

  @override
  String get autoPlayDesc =>
      'Автоматически воспроизводить произношение при показе карточки.';

  @override
  String get haptics => 'Тактильный отклик (вибрация)';

  @override
  String get displayAndContent => 'Отображение и контент';

  @override
  String get useEnglishDefinitions => 'Использовать английские определения';

  @override
  String get useEnglishDefinitionsDesc =>
      'Определения на английском языке часто содержат более подробные смысловые нюансы';

  @override
  String get animationSpeed => 'Скорость анимации';

  @override
  String get manageTomes => 'Управление томами';

  @override
  String get manageTomesDesc =>
      'Управляйте установленными учебными материалами.';

  @override
  String get dangerZone => 'Опасная зона';

  @override
  String get resetAllData => 'Сбросить все данные';

  @override
  String get resetDataDesc =>
      'Это действие навсегда сотрет весь ваш прогресс, статистику и персональные настройки. Отменить его невозможно.';

  @override
  String get areYouSure => 'Вы уверены?';

  @override
  String get cannotBeUndone => 'Действие необратимо';

  @override
  String get deleteEverything => 'Удалить все данные';

  @override
  String get appLanguage => 'Язык приложения';

  @override
  String get howDidYouDo => 'Как ваши успехи?';

  @override
  String get missedItEntirely => 'Совсем не вспомнил';

  @override
  String get gotItButStruggled => 'Вспомнил с трудом';

  @override
  String get gotItClearly => 'Вспомнил уверенно';

  @override
  String get perfectAndImmediate => 'Идеально и мгновенно';

  @override
  String get again => 'Заново';

  @override
  String get hard => 'Трудно';

  @override
  String get good => 'Хорошо';

  @override
  String get easy => 'Легко';

  @override
  String get tapToReveal => 'Нажмите, чтобы увидеть ответ';

  @override
  String get howWellDidYouRemember => 'Насколько хорошо вы запомнили?';

  @override
  String get completelyForgot => 'Полностью забыл';

  @override
  String get gotItWithDifficulty => 'Вспомнил с трудом';

  @override
  String get recalledCorrectly => 'Вспомнил правильно';

  @override
  String get perfectRecall => 'Идеально запомнил';

  @override
  String get practiceWriting => 'Практика письма';

  @override
  String get hideScratchpad => 'Скрыть область для письма';

  @override
  String get whatCharacterMeans => 'Значение иероглифа:';

  @override
  String get tapCardToReveal => 'Нажмите на карточку, чтобы перевернуть';

  @override
  String get ratePronunciationConfidence =>
      'Оцените уверенность в произношении';

  @override
  String get botchedIt => 'Очень неточно';

  @override
  String get struggledWithTones => 'Трудности с тонами';

  @override
  String get acceptable => 'Приемлемо';

  @override
  String get perfectlyNatural => 'Абсолютно естественно';

  @override
  String get sessionComplete => 'Сессия завершена!';

  @override
  String get accuracy => 'Точность';

  @override
  String get reviewed => 'Повторено';

  @override
  String get correct => 'Верно';

  @override
  String get backToLibrary => 'Вернуться в библиотеку';

  @override
  String get revealAnswer => 'Показать ответ';

  @override
  String get aiHubTitle => 'ИИ-Хаб';

  @override
  String get textChat => 'Текстовый чат';

  @override
  String get scholarlyPersonas => 'Персонажи-Ученые';

  @override
  String get shadowing => 'Метод теневого повторения (Shadowing)';

  @override
  String get liveTranslation => 'Синхронный перевод';

  @override
  String get scholarsLibrary => 'Библиотека Ученого';

  @override
  String get generate => 'Создать';

  @override
  String get searchPinyinHanziEnglish =>
      'Поиск по пиньиню, иероглифам или переводу...';

  @override
  String get liveTranslate => 'Синхронный перевод';

  @override
  String get travelInterpreter => 'Переводчик для путешествий';

  @override
  String get realTimeSplitScreen =>
      'Диалог с носителем языка на разделенном экране в реальном времени. Мгновенно преодолевайте языковые барьеры.';

  @override
  String get whisperEarpiece => 'Синхронные субтитры';

  @override
  String get listenToChineseAudio =>
      'Слушайте китайскую речь и читайте перевод в реальном времени прямо на экране.';

  @override
  String get dashboardTitle => 'Главная панель';

  @override
  String get yourMindIsClear => 'На сегодня все задачи выполнены!';

  @override
  String get noReviewsDueToday => 'На сегодня повторений нет.';

  @override
  String get done => 'Готово';

  @override
  String get hskLevel1 => 'Уровень HSK 1';

  @override
  String get hskLevel2 => 'Уровень HSK 2';

  @override
  String get hskLevel3 => 'Уровень HSK 3';

  @override
  String get hskLevel4 => 'Уровень HSK 4';

  @override
  String get hskLevel5 => 'Уровень HSK 5';

  @override
  String get hskLevel6 => 'Уровень HSK 6';

  @override
  String get generalVocabulary => 'Общая лексика';

  @override
  String cardsRequireAttention(Object count) {
    return 'Карточек для повторения: $count.';
  }

  @override
  String get begin => 'Начать';

  @override
  String get poweredByAi =>
      'На базе передового ИИ. Безупречный перевод в реальном времени для любых ситуаций.';

  @override
  String get downloadingModel => 'Загрузка модели ИИ...';

  @override
  String get soon => 'СКОРО';

  @override
  String get installed => 'УСТАНОВЛЕНО';

  @override
  String get premium => 'ПРЕМИУМ';

  @override
  String get coreModule => 'ОСНОВНОЙ МОДУЛЬ';

  @override
  String get step6Context => 'ШАГ 6: КОНТЕКСТ И ПРИМЕРЫ';

  @override
  String get tapBuildingBlocksTo =>
      'Нажимайте на составные части, чтобы исследовать происхождение иероглифа.';

  @override
  String get initiateRadicalSequence => 'ЗАПУСТИТЬ ИЗУЧЕНИЕ РАДИКАЛОВ';

  @override
  String get holdToTalk => 'Удерживайте, чтобы говорить';

  @override
  String get customScenario => 'Свой сценарий';

  @override
  String get voiceCall => 'Голосовой звонок';

  @override
  String get pronunciation => 'Произношение';

  @override
  String get selectAScenarioTo =>
      'Выберите сценарий для тренировки разговорной речи. ИИ-Ученый оценит точность тонов и разборчивость речи.';

  @override
  String get create => 'Создать';

  @override
  String get createYourScenario => 'Создайте свой сценарий';

  @override
  String get difficulty => 'Сложность';

  @override
  String get scholarsVerdict => 'ВЕРДИКТ УЧЕНОГО';

  @override
  String get completeReview => 'Завершить разбор';

  @override
  String get conversationReview => 'РАЗБОР ДИАЛОГА';

  @override
  String get linguisticAnalysis => 'Лингвистический анализ';

  @override
  String get examplesInHsk1 => 'ПРИМЕРЫ В HSK 1';

  @override
  String get characterReference => 'Справочник иероглифов';

  @override
  String get askTutor => 'Спросить тьютора';

  @override
  String get addToStudyDeck => 'Добавить в учебную колоду';

  @override
  String get startPractice => 'НАЧАТЬ ПРАКТИКУ';

  @override
  String get noOtherHsk1 =>
      'В HSK 1 больше нет других иероглифов с этим радикалом.';

  @override
  String get couldNotLoadAi =>
      'Не удалось загрузить ИИ-контекст (превышен лимит запросов или ошибка сети).\nНажмите кнопку обновления ниже, чтобы повторить попытку.';

  @override
  String get noAvailableCardsFound => 'Доступных карточек не найдено.';

  @override
  String get addCards => 'Добавить карточки';

  @override
  String get removeCard => 'Удалить карточку';

  @override
  String get remove => 'Удалить';

  @override
  String get review => 'Повторить';

  @override
  String get story => 'История';

  @override
  String get thisDeckIsEmpty => 'Эта колода пуста.';

  @override
  String get tapTheAddCards => 'Нажмите кнопку «Добавить карточки»!';

  @override
  String get noCardsFound => 'Карточки не найдены.';

  @override
  String get addCardsToSee => 'Добавьте карточки, чтобы увидеть статистику.';

  @override
  String get aiGenerated => 'Создано ИИ';

  @override
  String get allCardsCaughtUp => 'Все карточки повторены! Отличный результат.';

  @override
  String get latestDiscoveries => 'Недавние открытия';

  @override
  String get noCharactersInLexicon =>
      'В словаре пока нет сохраненных иероглифов.';

  @override
  String get yourBookshelf => 'Ваша книжная полка';

  @override
  String get text_1782026184579 => 'Иероглиф';

  @override
  String get searchYourDictionary => 'Поиск в личном словаре...';

  @override
  String get saveCard => 'Сохранить карточку';

  @override
  String get noCharactersFound => 'Иероглифы не найдены.';

  @override
  String get radicalsIndex => 'Алфавитный указатель ключей (радикалов)';

  @override
  String get masteringRadicalsIsThe =>
      'Освоение радикалов — ключ к пониманию тысяч китайских иероглифов. Выберите радикал, чтобы увидеть все связанные с ним знаки.';

  @override
  String get noRadicalsFound => 'Радикалы не найдены.';

  @override
  String get yourDrawing => 'Ваш рисунок';

  @override
  String get reference => 'Эталонное написание';

  @override
  String get rateYourRecall => 'Оцените прочность запоминания';

  @override
  String get contactUs => 'Связаться с нами';

  @override
  String get reportBugsOrRequest => 'Сообщить об ошибке или предложить идею';

  @override
  String get allDataHasBeen => 'Все данные были успешно удалены.';

  @override
  String get hanziMasterV100 => 'SinoSpark v1.0.0';

  @override
  String get myProgress => 'Мой прогресс';

  @override
  String get overview => 'Обзор';

  @override
  String get aiStory => 'История от ИИ';

  @override
  String get usingYourDecksVocabulary =>
      'Используется словарный запас вашей колоды';

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
      'Gemini Flash создает сюжет истории...';

  @override
  String get aiDeckGenerator => 'Генератор колод на базе ИИ';

  @override
  String get whatDoYouWant => 'Что вы хотите изучить?';

  @override
  String get targetDifficulty => 'Целевой уровень сложности';

  @override
  String get focusArea => 'Фокус обучения';

  @override
  String get specificContextOrTone =>
      'Контекст или стиль общения (необязательно)';

  @override
  String get numberOfCards => 'Количество карточек';

  @override
  String get generateDeck => 'Сгенерировать колоду';

  @override
  String get aiGrammarExplanation => 'Грамматический разбор от ИИ';

  @override
  String get scholarsDesk => 'Письменный стол Ученого';

  @override
  String get chooseADeck => 'Выберите колоду';

  @override
  String get whereWouldYouLike => 'Куда вы хотите сохранить этот иероглиф?';

  @override
  String get addToDefaultStudy => 'Добавить в основную учебную колоду';

  @override
  String get ifOffItsOnly =>
      'Если выключено, сохранится только в общий словарь';

  @override
  String get saveToLibrary => 'Сохранить в библиотеку';

  @override
  String get pleaseEnterValidChinese =>
      'Пожалуйста, введите корректные китайские иероглифы';

  @override
  String get reviewAiCard => 'Просмотр карточки ИИ';

  @override
  String get pleaseDoublecheckTheAis =>
      'Проверьте сгенерированный ИИ текст. Вы можете отредактировать пиньинь и значение перед сохранением в библиотеку.';

  @override
  String get alreadyInYourLibrary => 'Уже есть в вашей библиотеке!';

  @override
  String get meaningInContext => 'Значение в контексте';

  @override
  String get explainGrammar => 'Объяснить грамматику';

  @override
  String get addToLibrary => 'Добавить в библиотеку';

  @override
  String get masterYourMandarinPronunciation =>
      'Освойте произношение китайского языка, повторяя за носителями в реальном времени.';

  @override
  String get startSession => 'НАЧАТЬ СЕССИЮ';

  @override
  String get sessionHistory => 'История сессий';

  @override
  String get noSavedSessions => 'Нет сохраненных сессий.';

  @override
  String get aiBreakdown => 'Подробный разбор ИИ';

  @override
  String get sessionDetails => 'Детали сессии';

  @override
  String partner(Object lang) {
    return 'Собеседник ($lang)';
  }

  @override
  String get youEnglish => 'Вы (Русский)';

  @override
  String get noTranscriptToSave => 'Нет диалога для сохранения!';

  @override
  String get sessionSaved => 'Сессия сохранена!';

  @override
  String get realtimeBidirectionalTranslationSpeak =>
      'Двусторонний перевод в реальном времени. Говорите по-русски или по-китайски — приложение мгновенно переведет речь для вас и вашего собеседника.';

  @override
  String get text_1782026184665 => 'Идет запись';

  @override
  String get recording => 'Идет запись';

  @override
  String get yourSilentCompanionListen =>
      'Ваш надежный помощник. Слушайте китайскую речь и мгновенно получайте перевод на русский язык.';

  @override
  String get startListening => 'НАЧАТЬ ПРОСЛУШИВАНИЕ';

  @override
  String get skip => 'Пропустить';

  @override
  String get independentStars => 'НЕЗАВИСИМЫЕ ЗВЕЗДЫ';

  @override
  String get notEveryCharacterHas =>
      'Не каждый иероглиф происходит от составного радикала. Некоторые из них являются уникальными одиночными пиктограммами.';

  @override
  String get onTheMapWe =>
      'На карте мы объединили такие самостоятельные знаки в СОЗВЕЗДИЯ (✨).';

  @override
  String get iUnderstand => 'ПОНЯТНО';

  @override
  String get whatAreRadicals => 'ЧТО ТАКОЕ РАДИКАЛЫ (КЛЮЧИ)?';

  @override
  String get hanziAreBuiltFrom =>
      'Иероглифы (Ханьцзы) строятся из базовых элементов — РАДИКАЛОВ (ключей).\n\nОни определяют коренной смысл и тематику знака.';

  @override
  String get continueText => 'ПРОДОЛЖИТЬ';

  @override
  String get hanziAreNotJust =>
      'Ханьцзы — это не просто буквы. Это картины, запечатленные во времени.\n\nЧтобы овладеть ими, нужно прочувствовать логику их начертания.';

  @override
  String get iAmReady => 'Я ГОТОВ';

  @override
  String get youAreAScholar => 'ВЫ — УЧЕНЫЙ';

  @override
  String get theGalaxyMapAwaitsnmaster =>
      'Карта Галактики ждет вас.\nОсваивайте Солнца (радикалы), чтобы открывать Планеты (иероглифы).';

  @override
  String get enterTheScroll => 'РАЗВЕРНУТЬ СВИТОК';

  @override
  String get openingTheOriginScroll => 'Разворачиваем Свиток Истоков...';

  @override
  String get text_1782026184670 => '+';

  @override
  String get theScholarsEdition => 'Издание Ученого';

  @override
  String get weArePreparingThe => 'Мы готовим к выпуску Издание Ученого.';

  @override
  String get devBypassUnlockNow => 'DEV-ДОСТУП: РАЗБЛОКИРОВАТЬ СЕЙЧАС';

  @override
  String get restorePurchases => 'Восстановить покупки';

  @override
  String get welcomeScholarTheScroll =>
      'Приветствуем вас, Ученый. Свиток полностью открыт перед вами.';

  @override
  String get purchasesRestoredSuccessfully => 'Покупки успешно восстановлены.';

  @override
  String get noPreviousPurchasesFound =>
      'Для этого аккаунта не найдено предыдущих покупок.';

  @override
  String get unlockTheFullPotential =>
      'Раскройте весь потенциал обучения. Единоразовая покупка — навсегда с вами.';

  @override
  String get universalScanner => 'Универсальный сканер';

  @override
  String get noChineseCharactersFound =>
      'На изображении не обнаружено китайских иероглифов.';

  @override
  String get addedNewCharactersTo =>
      'Новые иероглифы добавлены в вашу библиотеку!';

  @override
  String get extractingTextAndObjects => 'Распознавание текста и объектов...';

  @override
  String get scanATextbookSign =>
      'Сканируйте страницы учебников, вывески и предметы, чтобы извлечь иероглифы.';

  @override
  String get extractedText => 'Распознанный текст';

  @override
  String get useText => 'Использовать этот текст';

  @override
  String get noMatchingDictionaryEntries => 'Совпадений в словаре не найдено.';

  @override
  String get quizComplete => 'Викторина пройдена!';

  @override
  String get returnToCourse => 'Вернуться к курсу';

  @override
  String get notEnoughCardsFor =>
      'Недостаточно карточек для викторины (требуется минимум 4).';

  @override
  String get creatorMode => 'Режим автора';

  @override
  String get noStoriesFoundMatching => 'По вашему запросу историй не найдено.';

  @override
  String get discard => 'Сбросить';

  @override
  String get save => 'Сохранить';

  @override
  String get generatingStoryViaDeepseek =>
      'ИИ генерирует историю через DeepSeek...';

  @override
  String get storySavedToLibrary => 'История сохранена в библиотеку!';

  @override
  String get storyNotFound => 'История не найдена.';

  @override
  String get targetHskLevel => 'Целевой уровень HSK';

  @override
  String get wedLoveToHear => 'Будем рады вашим отзывам!';

  @override
  String get whetherYouveFoundA =>
      'Если вы нашли баг, хотите предложить новую функцию или просто поделиться впечатлениями — ваш отзыв помогает развивать SinoSpark.';

  @override
  String get pointYourCameraAt => 'Наведите камеру на объект';

  @override
  String get reviewAddToLibrary => 'Проверить и добавить в библиотеку';

  @override
  String hideStrokeGuideStreak(Object streak) {
    return 'Скрывать подсказки начертания при серии верных ответов: $streak';
  }

  @override
  String inkPoints(Object points) {
    return '$points очков туши';
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
  String get supportAndFeedback => 'Поддержка и обратная связь';

  @override
  String get reportBug => 'Сообщить об ошибке';

  @override
  String get suggestFeature => 'Предложить функцию';

  @override
  String get generalFeedback => 'Общий отзыв';

  @override
  String get pleaseDrawSomethingFirst =>
      'Пожалуйста, сначала напишите иероглиф';

  @override
  String get drawThisCharacter => 'Напишите этот иероглиф:';

  @override
  String followGuideStroke(Object current, Object total) {
    return 'Следуйте синей линии, чтобы провести черту $current из $total';
  }

  @override
  String get skipCurrentStroke => 'Пропустить текущую черту';

  @override
  String get submitDrawing => 'Отправить на проверку';

  @override
  String addedToDeck(Object deckName, Object hanzi) {
    return 'Иероглиф «$hanzi» добавлен в колоду «$deckName»';
  }

  @override
  String removedFromDeck(Object hanzi) {
    return 'Иероглиф «$hanzi» удален из колоды';
  }

  @override
  String skippedNoStrokeData(Object hanzi) {
    return 'Пропущено «$hanzi» — для данного знака нет данных о порядке черт.';
  }

  @override
  String get startingSession => 'Запуск учебной сессии...';

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
  String get newLabel => 'Новинка';

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
  String get masterBuildingBlocks => 'Освойте базовые элементы иероглифов';

  @override
  String get totalWords => 'Всего слов';

  @override
  String get newInk => 'Получено туши';

  @override
  String get learningStatus => 'В процессе';

  @override
  String get masteredStatus => 'Освоено';

  @override
  String get libraryMastery => 'Процент освоения библиотеки';

  @override
  String get accuracyByMode => 'Точность по режимам';

  @override
  String get upcomingReviews => 'Предстоящие повторения (ближайшие 7 дней)';

  @override
  String get culturalReadingRoom => 'Культурный читальный зал (文化书房)';

  @override
  String storyTitleHsk(Object level, Object title) {
    return '$title (HSK $level)';
  }

  @override
  String get pleaseEnterTopic => 'Пожалуйста, укажите тему';

  @override
  String createdDeckCards(Object count, Object name) {
    return 'Создана колода «$name» ($count карточек)!';
  }

  @override
  String gradeResult(Object grade) {
    return 'Оценка: $grade';
  }

  @override
  String get listeningMode => 'Режим аудирования';

  @override
  String get readingMode => 'Режим чтения';

  @override
  String get recallMode => 'Режим воспроизведения';

  @override
  String get speakingMode => 'Режим говорения';

  @override
  String get aiMemoryHook => 'ИИ-ассоциация для запоминания';

  @override
  String get exampleSentences => 'Примеры предложений';

  @override
  String get ghostCharacters => 'Контурные подсказки (водяные знаки)';

  @override
  String get commonWords => 'Часто встречающиеся слова';

  @override
  String get personalNotes => 'Личные заметки';

  @override
  String get addPersonalNotes =>
      'Добавьте свои ассоциации или комментарии здесь...';

  @override
  String get takePhoto => 'Сделать фото';

  @override
  String get gallery => 'Выбрать из галереи';

  @override
  String get arLens => 'AR-сканер';

  @override
  String addedCharToLibrary(Object char) {
    return 'Символ «$char» добавлен в библиотеку';
  }

  @override
  String get scoreText => 'Баллы';

  @override
  String get searchDictionaryHint =>
      'Поиск по иероглифу, пиньиню или значению...';

  @override
  String get searchDeckHint => 'Поиск по колоде (иероглифы, пиньинь)...';

  @override
  String get localRestaurant => 'Местный ресторан';

  @override
  String get taxiToAirport => 'Такси в аэропорт';

  @override
  String get silkMarketHaggling => 'Торг на Шелковом рынке';

  @override
  String get medicalClinic => 'Поликлиника / Прием у врача';

  @override
  String get meetingAFriend => 'Встреча со старым другом';

  @override
  String get jobInterview => 'Собеседование при приеме на работу';

  @override
  String get searchRadicalsHint => 'Поиск ключей (напр.: 水, 氵)';

  @override
  String get definition => 'Определение и толкование';

  @override
  String get undo => 'ОТМЕНИТЬ';

  @override
  String get hanziMaster => 'SinoSpark';

  @override
  String get unlockForever => 'Бессрочный доступ — \$9.99';

  @override
  String get clear => 'Очистить';

  @override
  String get clearChat => 'Очистить историю чата';

  @override
  String get typeMessage => 'Введите сообщение...';

  @override
  String addedToLibrary(Object hanzi) {
    return '«$hanzi» добавлено в библиотеку';
  }

  @override
  String get generateNewStory => 'Сгенерировать новую историю';

  @override
  String failedToGenerateStory(Object error) {
    return 'Не удалось сгенерировать историю:\n$error';
  }

  @override
  String get detail => 'Подробнее';

  @override
  String get scanText => 'Сканировать текст';

  @override
  String get createMagic => 'Создать с помощью ИИ';

  @override
  String get learning => 'Изучается';

  @override
  String get upcomingReviews7Days =>
      'Предстоящие повторения (следующие 7 дней)';

  @override
  String get askFollowUpQuestion => 'Задать уточняющий вопрос...';

  @override
  String get pasteScanToSimplify =>
      'Вставьте или отсканируйте китайский текст для адаптации';

  @override
  String get searchStoriesHint =>
      'Поиск историй по названию или тегам (напр.: мифология, путешествия)';

  @override
  String get importAll => 'Импортировать все';

  @override
  String get ascendAll => 'Повысить уровень всего';

  @override
  String get startAscension => 'Начать восхождение мастерства';

  @override
  String get scenarioLocalRestaurant => 'Аутентичный ресторан';

  @override
  String get scenarioLocalRestaurantDesc =>
      'Потренируйтесь делать заказ и спрашивать рекомендации официанта.';

  @override
  String get scenarioTaxiAirport => 'Поездка в аэропорт на такси';

  @override
  String get scenarioTaxiAirportDesc =>
      'Назовите водителю пункт назначения и поддержите беседу о ситуации на дорогах.';

  @override
  String get scenarioSilkMarket => 'Торг на Шелковом рынке';

  @override
  String get scenarioSilkMarketDesc =>
      'Договоритесь о более выгодной цене на сувениры.';

  @override
  String get scenarioMedicalClinic => 'Визит к врачу';

  @override
  String get scenarioMedicalClinicDesc =>
      'Опишите свои симптомы доктору традиционной китайской медицины.';

  @override
  String get scenarioMeetingFriend => 'Встреча с другом';

  @override
  String get scenarioMeetingFriendDesc =>
      'Поприветствуйте старого знакомого и расскажите о новостях из жизни.';

  @override
  String get scenarioJobInterview => 'Собеседование на работу';

  @override
  String get scenarioJobInterviewDesc =>
      'Пройдите интервью на должность в IT-компании в Шанхае.';

  @override
  String get createCustomScenario => 'Создать свой сценарий';

  @override
  String get customScenarioTitleHint => 'Название (напр.: Свадебный банкет)';

  @override
  String get customScenarioDescHint => 'Описание и контекст ситуации';

  @override
  String get customScenarioPersonaHint => 'Роль ИИ (напр.: Любопытный коллега)';

  @override
  String get customScenarioDifficulty => 'Уровень сложности';

  @override
  String get createAction => 'Создать';

  @override
  String get cancelAction => 'Отмена';

  @override
  String get mythsAndLegends => 'Мифы и легенды';

  @override
  String get historyAndCulture => 'История и культура';

  @override
  String get idiomsTitle => 'Идиомы и чэнъюи (成语)';

  @override
  String get theMonkeyKing => 'Царь Обезьян';

  @override
  String get theMonkeyKingDesc => 'Сунь Укун (Путешествие на Запад)';

  @override
  String get huaMulan => 'Хуа Мулань';

  @override
  String get huaMulanDesc =>
      'История Мулань, отправившейся на войну вместо отца';

  @override
  String get confuciusTitle => 'Конфуций';

  @override
  String get confuciusDesc => 'Жизнь и мудрые наставления Конфуция';

  @override
  String get theGreatWall => 'Великая стена';

  @override
  String get theGreatWallDesc =>
      'Строительство и тайны Великой Китайской стены';

  @override
  String get generateTopic => 'Сгенерировать тему';

  @override
  String get simplifyText => 'Упростить текст (адаптация)';

  @override
  String get topicHint => 'Тема (напр.: Пришельцы в Пекине)';

  @override
  String get tagsHint => 'Теги (через запятую, необязательно)';

  @override
  String get speakWithMasterLin => 'Беседа с Мастером Линем';

  @override
  String get masterLinGreeting =>
      'Приветствую тебя, ученик. Тушь готова. Какой иероглиф или оборот мы разберем сегодня?';

  @override
  String get typeYourMessage => 'Напишите сообщение...';

  @override
  String get theMainLibrary => 'Основная библиотека';

  @override
  String get hsk1Foundation => 'HSK 1: Базовый уровень';

  @override
  String get hsk2Elementary => 'HSK 2: Начальный уровень';

  @override
  String get hsk3Intermediate => 'HSK 3: Средний уровень';

  @override
  String get inDeckCheck => 'В колоде ✓';

  @override
  String get addToDeckPlus => '+ В колоду';

  @override
  String get openCardArrow => 'Открыть карточку →';

  @override
  String get pronunciationPartial => 'Неточный тон';

  @override
  String get pronunciationWrong => 'Неверно';

  @override
  String get toneExpected => 'Ожидаемый тон';

  @override
  String get toneYouSaid => 'Ваш тон';

  @override
  String get gotIt => 'Понятно!';

  @override
  String foundNCharacters(int count) {
    return 'Найдено иероглифов: $count';
  }

  @override
  String get lookingUpCharacters => 'Поиск иероглифов…';

  @override
  String get practiceAll => 'Практиковать все';

  @override
  String get arLensObjects => 'Объекты';

  @override
  String get arLensText => 'Текст';

  @override
  String get arLensDetectedText => 'Распознанный текст';

  @override
  String get duration12Min => '1–2 мин';

  @override
  String get aClassicTangDynastyPoem =>
      'Классическое стихотворение династии Тан';

  @override
  String get aClassicTangDynastyPoemBy =>
      'Классическое танское стихотворение автора';

  @override
  String get aStructuralComponent =>
      'Структурный компонент (элемент иероглифа).';

  @override
  String get addSelectedToDeck => 'Добавить выбранное в колоду';

  @override
  String addTo(Object target) {
    return 'Добавить в ';
  }

  @override
  String addedHanziToYourLibrary(String hanzi) {
    return 'Иероглиф «$hanzi» добавлен в вашу библиотеку';
  }

  @override
  String get adjustFontSize => 'Настроить размер шрифта';

  @override
  String get againGoodEasyHard =>
      '⬅️ Снова    ➡️ Хорошо    ⬆️ Легко    ⬇️ Сложно';

  @override
  String get aiAnalysisFailed => 'Ошибка ИИ-анализа';

  @override
  String get aiIsThinking => 'ИИ думает...';

  @override
  String get aiSceneAnalysisFailed => 'Ошибка ИИ-анализа сцены';

  @override
  String get allLabel => 'Все';

  @override
  String get allPinyin => 'Все слоги пиньиня';

  @override
  String get alreadyHaveAccountSignIn => 'Уже есть аккаунт? Войти';

  @override
  String get analysisFailed => 'Ошибка анализа: ';

  @override
  String get analyzingClassicalCharacters =>
      'Анализ классических иероглифов...';

  @override
  String get anatomy => 'Анатомия иероглифа';

  @override
  String get ancientPhilosophy => 'Древняя философия';

  @override
  String get articleSavedToMediaHub => 'Статья сохранена в Медиа-хабе!';

  @override
  String get askAFollowUp => 'Задать уточняющий вопрос...';

  @override
  String get audioPrivacyAndHowThingsWork =>
      'Аудио, конфиденциальность и принципы работы';

  @override
  String get audiobookPlayer => 'Плеер аудиокниг';

  @override
  String get audiobookVoice => 'Голос аудиокниги';

  @override
  String get auntieMaTown =>
      'Тетушка Ма (马阿姨): бойкая хозяйка уличного ларька, которая готовит самые хрустящие жоуцзямо и лянпи в городе.';

  @override
  String get back => 'Назад';

  @override
  String get baristaKevinNotes =>
      'Бариста Кевин (小凯): увлеченный молодой обжарщик, готовый бесконечно рассказывать о кофейных зернах из Юньнани и их вкусовых нотах.';

  @override
  String get bbc => 'BBC 中文 (Новости на китайском)';

  @override
  String get beginYourJourney => 'Начать свой путь';

  @override
  String get bestValue => 'Хит / Самый выгодный';

  @override
  String get bookLinkCopiedToClipboard =>
      'Ссылка на книгу скопирована в буфер обмена!';

  @override
  String get bookmarkChapter => 'Добавить главу в закладки';

  @override
  String get bookmarks => 'Закладки';

  @override
  String get books => 'Книги';

  @override
  String get briefing => 'Краткая сводка';

  @override
  String get bugReport => 'Сообщить об ошибке';

  @override
  String get caoXueqinDecline =>
      'Цао Сюэцинь (ок. 1715–1763) — цинский писатель из знатного знаменного рода, разорившегося при императоре Юнчжэне. Его роман «Сон в красном тереме», созданный в нищете на склоне лет, признан вершиной классической китайской прозы — грандиозной психологической эпопеей об упадке аристократии.';

  @override
  String get cardsTitle => 'КАРТОЧКИ';

  @override
  String get cc => 'Субтитры (CC)';

  @override
  String get characterOrWord => 'Иероглиф / Слово';

  @override
  String get chatMore => 'Продолжить общение';

  @override
  String get chefChenShumai =>
      'Шеф Чэнь (陈师傅): жизнерадостный кантонский мастер димсамов, рекомендующий свежайшие паровые пельмени хагау и сиомай.';

  @override
  String get chineseEpics => 'Китайский эпос';

  @override
  String get chinesePoetry => 'Китайская поэзия';

  @override
  String get chng => 'chéng';

  @override
  String get chongqingSpicyHotpotFeast =>
      'Пряное застолье с сычуаньским хого в Чунцине';

  @override
  String get chooseAudiobookVoice => 'Выбрать голос аудиокниги';

  @override
  String get chooseVoice => 'Выбрать голос';

  @override
  String get compare => 'Сравнить';

  @override
  String get compare4Tones => 'Сравнение 4 тонов';

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
  String get customWord => 'Свое слово';

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
  String get defaultDeck => 'Основная колода';

  @override
  String get deleteLabel => 'Удалить';

  @override
  String get deleteScenario => 'Удалить сценарий';

  @override
  String get deletesAllProgressPermanently =>
      'Безвозвратно удаляет весь прогресс обучения';

  @override
  String get developerBackdoorUnlocked => 'Меню разработчика разблокировано!';

  @override
  String get doesNotExistInChinese => 'В китайском языке нет такого аналога';

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
  String get egAnimeVocab => 'Напр.: лексика из аниме';

  @override
  String get egFormalBusinessLanguageSlangForTexting =>
      'Напр.: деловой китайский, сленг из соцсетей...';

  @override
  String get egOrderingAtARestaurantBusinessVocab =>
      'Напр.: заказ в ресторане, бизнес-лексика...';

  @override
  String get egWeddingReceptionTechInterview =>
      'Напр.: свадебный тост, техническое собеседование...';

  @override
  String get emailLabel => 'Эл. почта';

  @override
  String get english => 'Английский';

  @override
  String get englishAndWorld => 'Английский и мировая литература';

  @override
  String get episodes => 'эпизоды';

  @override
  String get erase => 'Очистить';

  @override
  String get eraseDeckQuestion => 'Очистить колоду?';

  @override
  String errorFetchingTranslationForLabelE(String label, String e) {
    return 'Ошибка получения перевода для $label: $e';
  }

  @override
  String errorLoadingMicroreadsE(String e) {
    return 'Ошибка загрузки микрочтений: $e';
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
  String get exitFocus => 'Выйти из режима фокуса';

  @override
  String get explore => 'Исследовать';

  @override
  String get exportToThisDeck => 'Экспортировать в эту колоду';

  @override
  String get extractAndSimplify => 'Извлечь и адаптировать';

  @override
  String get failedToCreateDeck => 'Не удалось создать колоду';

  @override
  String get failedToLoadDailyContent =>
      'Не удалось загрузить ежедневный материал';

  @override
  String get failedToLoadEpisodes => 'Не удалось загрузить эпизоды';

  @override
  String get failedToLoadShows => 'Не удалось загрузить видео';

  @override
  String get finalizingDetails => 'Уточнение деталей...';

  @override
  String get finalizingStoryDetails => 'Доработка деталей истории...';

  @override
  String get firebaseAuthConsole =>
      'Аутентификация Firebase отключена. Включите нужный метод входа в консоли Firebase.';

  @override
  String get flashcardDeckTitle => 'КОЛОДА КАРТОЧЕК';

  @override
  String get focus => 'Фокус';

  @override
  String get foodAndCooking => 'Еда и кулинария';

  @override
  String get forward => 'Вперед';

  @override
  String get freeFlow => 'Свободная беседа';

  @override
  String get frenchClassics => 'Французская классика';

  @override
  String get full => 'Полный';

  @override
  String get gamingAndEsports => 'Игры и киберспорт';

  @override
  String get germanClassics => 'Немецкая классика';

  @override
  String get ghostPinyin => 'Фоновый пиньинь';

  @override
  String get goodAttempt => 'Хорошая попытка!';

  @override
  String get gotItSimple => 'Понятно';

  @override
  String get grammar => 'Грамматика';

  @override
  String get grandmaLiuFilling =>
      'Бабушка Лю (刘奶奶): заботливая бабушка из северного Китая, которая учит защипывать края цзяоцзы и готовить сочную начинку из свинины и зеленого лука.';

  @override
  String get great => 'Отлично!';

  @override
  String get handmadeDumplingFeastInHarbin =>
      'Праздник домашних пельменей цзяоцзы в Харбине';

  @override
  String get hanziCharacter => 'Ханьцзы (иероглиф)';

  @override
  String get hapticFeedback => 'Тактильный отклик';

  @override
  String get helpAndSupport => 'Помощь и поддержка';

  @override
  String get hidden => 'Скрыто';

  @override
  String get hideEnglishTranslations => 'Скрыть английский перевод';

  @override
  String get hidePinyin => 'Скрыть пиньинь';

  @override
  String get highlight => 'ВЫДЕЛИТЬ';

  @override
  String get howWouldYouLikeToStudy => 'Как вы хотите заниматься?';

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
  String get hskSimplifySubtitles => 'Адаптация субтитров под HSK';

  @override
  String get hskVocabularyCollections => 'Коллекции лексики HSK';

  @override
  String get i => 'Я';

  @override
  String get ifTheAgain =>
      'Если ИИ заметит неточность в распознавании, он спросит: «Вы имели в виду...?». Нажмите «Да, переоценить!», чтобы моментально перепроверить исходную запись с учетом вашего намерения без необходимости говорить снова.';

  @override
  String get install => 'Установить';

  @override
  String get just => 'Всего \$';

  @override
  String get keyword => 'ключевое слово';

  @override
  String get knowledgeBase => 'База знаний';

  @override
  String get liRuzhenSubjects =>
      'Ли Жучжэнь (ок. 1763–1830) — цинский эрудит, знаток фонологии, вэйци и космологии. Его фантастический роман «Цветы в зеркале» о путешествиях купца по причудливым заморским царствам примечателен ранними феминистскими идеями и энциклопедической широтой знаний.';

  @override
  String get library => 'Библиотека 文化书房';

  @override
  String get lifestyleAndVlog => 'Стиль жизни и влоги';

  @override
  String get listenInAudiobookMode => 'Слушать в режиме аудиокниги';

  @override
  String get listenToThisWord => 'Прослушать это слово';

  @override
  String get listening => 'Слушаю...';

  @override
  String get liuEEncroachment =>
      'Лю Э (1857–1909) — разносторонний позднецинский мыслитель (инженер, врач и писатель), чей роман «Путешествие Лао Цаня» представляет собой пронзительный и полный социальных наблюдений дневник странствующего врача во времена заката империи и иностранной экспансии.';

  @override
  String get loadingTranslations => 'Загрузка переводов...';

  @override
  String get luXunVernacular =>
      'Лу Синь (1881–1936, псевдоним Чжоу Шужэня) — основоположник современной китайской литературы. Врач, обратившийся к литературе ради духовного пробуждения нации, автор сборников «Записки сумасшедшего» и «Подлинная история А-кью», написанных на живом разговорном байхуа.';

  @override
  String get luoGuanzhongEpic =>
      'Ло Гуаньчжун (ок. 1330–1400) — драматург и писатель эпохи Юань-Мин, ученик Ши Найаня. Его монументальное «Троецарствие» объединило исторические хроники, устный фольклор и сценическое искусство в главный исторический эпос Китая.';

  @override
  String get makeACustomCollection => 'Создать свою подборку';

  @override
  String get manageDailyDropsAndReviewReminders =>
      'Управление ежедневными порциями и напоминаниями';

  @override
  String get managerYuOptions =>
      'Управляющая Юй (余店长): энергичная хозяйка ресторана хого, которая посоветует фирменный рубец, утиную кровь и варианты нежного неострого бульона.';

  @override
  String get masterGaoRubs =>
      'Мастер Гао (高师傅): харизматичный мастер гриля на углях, с юмором подбирающий уровень остроты и секретную приправу с кумином.';

  @override
  String get masterThisToUnlockItsGalaxy =>
      'Освойте этот элемент, чтобы открыть его галактику.';

  @override
  String get masterZhaoBrewing =>
      'Мастер Чжао (赵师傅): терпеливый чайный мастер, с упоением раскрывающий тонкости заваривания чая по методу Гунфу-ча.';

  @override
  String get mastery => 'Уровень освоения';

  @override
  String get maybeLater => 'Позже';

  @override
  String get memes => 'Мемы и тренды';

  @override
  String get midnightBbqSkewersInWuhan => 'Ночные шашлычки на углях в Ухане';

  @override
  String get mo => '/мес.';

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
  String get native => 'Носитель языка';

  @override
  String get newCard => 'Новая карточка';

  @override
  String get newDeck => 'Новая колода';

  @override
  String get newDeckName => 'Название новой колоды';

  @override
  String get noActiveSubscriptionFound => 'Активная подписка не найдена.';

  @override
  String get noEpisodesFound => 'Эпизоды не найдены';

  @override
  String get noKeyWordsFoundForThisStory =>
      'Ключевые слова для этой истории не найдены.';

  @override
  String get noLabel => 'Нет';

  @override
  String get noNewWordsFound => 'Новых слов не найдено!';

  @override
  String get noPinyin => 'Без пиньиня';

  @override
  String get noPremiumPackagesAvailable =>
      'Премиум-пакеты в данный момент недоступны.';

  @override
  String noResultsFoundForSearchquery(String searchQuery) {
    return 'По запросу «$searchQuery» ничего не найдено';
  }

  @override
  String get noSavedArticlesYet => 'Сохраненных статей пока нет.';

  @override
  String get noShowsAvailable => 'Нет доступных видеоматериалов';

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
  String get openInYoutube => 'Открыть на YouTube';

  @override
  String get orderingHanddripCoffeeInShanghai =>
      'Заказ фильтр-кофе пуровер в Шанхае';

  @override
  String get orderingSugarcoatedHawsInWinterBeijing =>
      'Покупка карамельных ягод танхулу в зимнем Пекине';

  @override
  String partnerLang(String lang) {
    return 'Собеседник ($lang)';
  }

  @override
  String get partnerListening => 'Собеседник слушает...';

  @override
  String get partnerSpeaking => 'Собеседник говорит...';

  @override
  String get passwordLabel => 'Пароль';

  @override
  String get pause => 'Пауза';

  @override
  String get perfect => 'Идеально!';

  @override
  String get personalizedPathBasedOnDeck =>
      'Персональный учебный план на основе вашей колоды.';

  @override
  String play(Object pinyin) {
    return 'Воспроизвести ($pinyin)';
  }

  @override
  String get pleaseEnterMessageBeforeSending =>
      'Пожалуйста, введите сообщение перед отправкой.';

  @override
  String get practiceInRoleplay => 'Практика в ролевой игре';

  @override
  String get practiceModes => 'Режимы практики';

  @override
  String get practicePronouncingWithAiGrading =>
      'Тренируйте произношение с оценкой от ИИ';

  @override
  String get preparingReadingInterface => 'Подготовка читального зала...';

  @override
  String get privacy => 'Конфиденциальность';

  @override
  String get privacyAndAudio => 'Конфиденциальность и аудио';

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
      'Пу Сунлин (1640–1715) — цинский новеллист, посвятивший десятилетия сбору «Описания чудес из кабинета Ляо» после неудач на государственных экзаменах. Его мистические новеллы о духах-лисицах, привидениях и ученых остаются золотым эталоном китайской фантастической прозы.';

  @override
  String get qaFaq => 'Вопросы и ответы (FAQ)';

  @override
  String get questsTitle => 'ЗАДАНИЯ';

  @override
  String get quickBookmarks => 'Быстрые закладки';

  @override
  String get radical => 'Радикал (ключ)';

  @override
  String get ready => 'Готово';

  @override
  String get readyToInterpret => 'Готов к переводу';

  @override
  String get readyToStart => 'Готов начать.';

  @override
  String get recentBookmarks => 'Недавние закладки';

  @override
  String get refiningGrammar => 'Уточнение грамматики...';

  @override
  String get refresh => 'Обновить';

  @override
  String get removeFromSaved => 'Удалить из сохраненного';

  @override
  String get removeFromSavedScenarios => 'Удалить из сохраненных сценариев';

  @override
  String get removed => 'Удалено';

  @override
  String get requestPermissions => 'Запросить разрешения';

  @override
  String get rescind => 'Отменить';

  @override
  String get restore => 'Восстановить';

  @override
  String get results => 'Результаты';

  @override
  String get resume => 'Возобновить';

  @override
  String get retry => 'Повторить попытку';

  @override
  String get revenuecatError => 'Ошибка RevenueCat: ';

  @override
  String revenuecatErrorE(String e) {
    return 'Ошибка RevenueCat: $e';
  }

  @override
  String get reviewExtractedDeck => 'Повторить извлеченную колоду';

  @override
  String get reviewIn => 'Повторить через';

  @override
  String get reviewingYourTones => 'Анализ тонов...';

  @override
  String get saveAll => 'Сохранить все';

  @override
  String get saveScenario => 'Сохранить сценарий';

  @override
  String get saveThisScenario => 'Сохранить этот сценарий';

  @override
  String get saved => 'Сохранено';

  @override
  String get scanAnother => 'Сканировать другой объект';

  @override
  String get scenarioRemoved => 'Сценарий удален';

  @override
  String get scenarioSavedFindInCustomTab =>
      'Сценарий сохранен! Вы найдете его во вкладке «Свои».';

  @override
  String score(Object score, Object total) {
    return 'Баллы: $score / $total';
  }

  @override
  String get searchByPinyinOrMeaning => 'Поиск по пиньиню или значению...';

  @override
  String get searchByTitleOrTag => 'Поиск по названию или тегу...';

  @override
  String get searchDictionaryOrTypeCustom =>
      'Искать в словаре или ввести вручную';

  @override
  String get searchHint => 'Поиск...';

  @override
  String get searchOrEnterUrl => 'Поиск или ввод URL-адреса';

  @override
  String get searchScenariosHint => 'Поиск сценариев...';

  @override
  String get searchStoriesIdiomsNews => 'Поиск историй, чэнъюев, новостей...';

  @override
  String get searchTopicsEgCookingHistory =>
      'Поиск тем (напр.: Кулинария, История)';

  @override
  String get seeAll => 'Смотреть все';

  @override
  String get selectADeck => 'Выберите колоду';

  @override
  String get selectPracticeMode => 'Выберите режим практики';

  @override
  String get selectingHskVocabulary => 'Подбор лексики HSK...';

  @override
  String get send => 'Отправить';

  @override
  String get sendMessage => 'Отправить сообщение';

  @override
  String get serif => 'С засечками (Serif)';

  @override
  String get shadow => 'Shadowing';

  @override
  String get shiNaianEpic =>
      'Ши Найань (ок. 1296–1372) — литератор эпохи Юань, сдавший государственные экзамены, но выбравший жизнь ученого-отшельника. Его бессмертный шедевр «Речные заводи» заложил канон китайского героического эпоса о благородных бунтарях.';

  @override
  String get showEnglish => 'Показать английский';

  @override
  String get showEnglishTranslations => 'Показать перевод на английский';

  @override
  String get showHanzi => 'Показать иероглифы';

  @override
  String get showPinyin => 'Показать пиньинь';

  @override
  String get showTranslation => 'Показать перевод';

  @override
  String get shows => 'Видеопрограммы';

  @override
  String get signIn => 'Войти';

  @override
  String get simplifiedArticle => 'Адаптированная статья';

  @override
  String get simplifyingSubtitles => 'Упрощение субтитров...';

  @override
  String get sincereHonest => 'искренний и честный';

  @override
  String get sleepTimer => 'Таймер сна';

  @override
  String get smartDeck => 'Умная колода';

  @override
  String get spanishAndWorld => 'Испанский и мировая литература';

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
  String get suggestion => 'Предложенный ответ';

  @override
  String get summary => 'Краткое содержание';

  @override
  String get supernaturalAndFolklore => 'Мистика и фольклор';

  @override
  String get swipeToGrade => 'Смахните для оценки:';

  @override
  String get tableOfContents => 'Оглавление';

  @override
  String get tapToRetry => 'Нажмите для повтора';

  @override
  String get teaTastingInChengdu => 'Чайная дегустация в Чэнду';

  @override
  String get techAndGadgets => 'Технологии и гаджеты';

  @override
  String get terms => 'Условия обслуживания';

  @override
  String get theGalaxyCharacters =>
      'Карта Галактики ждет вас.\nОсвойте Солнца (радикалы), чтобы разблокировать Планеты (иероглифы).';

  @override
  String get theme => 'Тема';

  @override
  String get thinking => 'ИИ думает...';

  @override
  String get thisArticleCharacters =>
      'Этот текст содержит традиционные иероглифы.';

  @override
  String get todaysWord => 'СЛОВО ДНЯ';

  @override
  String get togglePinyin => 'Переключить пиньинь';

  @override
  String get toggleTranslation => 'Переключить перевод';

  @override
  String get toneDoesNotExistInMandarin =>
      'Этот тон отсутствует в стандартном путунхуа.';

  @override
  String get toneGraph => 'График высоты тона';

  @override
  String get traceLabel => 'Написание по контуру';

  @override
  String get trailer => 'ТРЕЙЛЕР';

  @override
  String get translatingAndAddingPinyin => 'Перевод и добавление пиньиня...';

  @override
  String get translatingText => 'Перевод текста...';

  @override
  String get turnOn => 'Включить';

  @override
  String get typeHanziPinyinOrEnglish =>
      'Введите иероглифы, пиньинь или перевод...';

  @override
  String get unknown2 => 'Игровые стримы, Honor of Kings, Genshin Impact';

  @override
  String get unknown3 => 'Китайская кухня, рецепты';

  @override
  String get unknown4 => 'Китайские технологии, обзоры';

  @override
  String get unrollingTheScroll => 'Разворачиваем свиток...';

  @override
  String get upperIntermediate => 'Средне-продвинутый';

  @override
  String get vibrationsForInteractions => 'Виброотклик при нажатии';

  @override
  String get video => 'Видео';

  @override
  String get viewAnswer => 'Показать ответ';

  @override
  String get viewAsList => 'Показать списком';

  @override
  String get viewBookmarks => 'Просмотр закладок';

  @override
  String get viewMyDrawing => 'Посмотреть мой рисунок';

  @override
  String get vlog => 'Китай: влоги о повседневной жизни';

  @override
  String get voice => 'Голос:';

  @override
  String get web => 'Веб';

  @override
  String get wedLoveToHearFromYou => 'Мы будем рады\nуслышать ваш отзыв.';

  @override
  String get welcomeBack => 'С возвращением';

  @override
  String get whatDoesThisMean => 'Что это значит?';

  @override
  String get whatHappensToMyChatHistory => 'Что происходит с историей чата?';

  @override
  String get whatIfAiMishears =>
      'Что делать, если ИИ неправильно распознал мою речь?';

  @override
  String get whichCharacterIs => 'Какой иероглиф означает:';

  @override
  String get wikipedia => 'Википедия';

  @override
  String get wordsSavedAndSrsScheduled =>
      'Слова сохранены и добавлены в график интервальных повторений!';

  @override
  String get writeYourMessageHere => 'Напишите сообщение...';

  @override
  String get wuChengenLiterature =>
      'У Чэнъэнь (ок. 1500–1582) — минский писатель из Хуайаня, Цзянсу. Объединив фольклор, буддийские аллегории и тонкую сатиру, он превратил предание о паломничестве танского монаха в «Путешествие на Запад» — одно из самых любимых и изобретательных произведений мировой литературы.';

  @override
  String get wuJingziClass =>
      'У Цзинцзы (1701–1754) — цинский писатель из Аньхоя, отказавшийся от наследства ради создания «Неофициальной истории конфуцианцев» — блестящего сатирического романа, высмеивающего тщеславие, коррупцию и абсурдность экзаменационной системы сословия ученых-чиновников.';

  @override
  String get xuZhonglinWarfare =>
      'Сюй Чжунлинь (XVI–XVII вв.) — минский литератор, которому приписывают создание эпического романа «Возведение в ранг духов» (封神演义), где эпоха Шан-Чжоу переплетается с даосской мифологией, небесной иерархией и грандиозными сражениями бессмертных.';

  @override
  String get yearly => 'Годовая подписка';

  @override
  String get yesReGradeMe => 'Да, переоценить!';

  @override
  String you(Object lang) {
    return 'Вы ($lang)';
  }

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
      'Для создания аккаунта необходимо принять Условия обслуживания и Политику конфиденциальности.';

  @override
  String get yourEchoModels =>
      'Ваши диалоги в Echo Hall хранятся локально на вашем устройстве, и вы можете прослушать их в любое время. Ваши личные аудиозаписи не используются для обучения моделей ИИ.';

  @override
  String get zhOnly => 'Только китайский (ZH)';

  @override
  String get hsk_1300_cards => '1300 карточек';

  @override
  String get hsk_154_cards => '154 карточки';

  @override
  String get hsk_162_cards => '162 карточки';

  @override
  String get hsk_2500_cards => '2500 карточек';

  @override
  String get hsk_299_cards => '299 карточек';

  @override
  String get hsk_602_cards => '602 карточки';

  @override
  String get added_to_review_queue => 'Добавлено в очередь повторения';

  @override
  String added_cards_to(int cardCount, String deckName) {
    return 'В колоду «$deckName» добавлено карточек: $cardCount.';
  }

  @override
  String added_to_your_library(Object hanzi) {
    return '«$hanzi» добавлено в вашу библиотеку';
  }

  @override
  String get advanced => 'Продвинутый уровень';

  @override
  String get ai_stories => 'Истории от ИИ';

  @override
  String analysis_failed(Object error) {
    return 'Ошибка анализа: $error';
  }

  @override
  String get analyzing_pronunciation_with_gemini_ai =>
      'ИИ Gemini анализирует произношение...';

  @override
  String get analyzing_your_pronunciation => 'Идет анализ произношения...';

  @override
  String are_you_sure_you_want_to(String deckName) {
    return 'Вы уверены, что хотите навсегда удалить колоду «$deckName»? Это действие нельзя отменить, все карточки внутри будут удалены.';
  }

  @override
  String ask_about(String hanzi) {
    return 'Спросить об иероглифе «$hanzi»...';
  }

  @override
  String get audio_haptics => 'Звук и тактильный отклик';

  @override
  String get audio_could_not_start_check_your =>
      'Не удалось запустить аудио. Проверьте интернет-соединение и настройки озвучки на устройстве.';

  @override
  String get calligraphy_trace => 'Каллиграфическая обводка';

  @override
  String chapters(Object count) {
    return '$count глав';
  }

  @override
  String get char => 'Иероглиф';

  @override
  String get chinese_character => 'КИТАЙСКИЙ ИЕРОГЛИФ';

  @override
  String get contact_us_and_report_issues =>
      'Связаться с нами и сообщить о проблеме';

  @override
  String created_smart_deck_with_words(String deckName, int wordCount) {
    return 'Создана умная колода «$deckName» ($wordCount слов)!';
  }

  @override
  String get custom_ai_generated_story =>
      'Персональная история, сгенерированная ИИ.';

  @override
  String get display_content => 'Отображение и контент';

  @override
  String get do_you_keep_or_store_my => 'Сохраняются ли мои голосовые записи?';

  @override
  String get elementary => 'Начальный уровень';

  @override
  String error_creating_scenario(Object error) {
    return 'Ошибка при создании сценария: $error';
  }

  @override
  String error_fetching_translation_for(Object error) {
    return 'Ошибка получения перевода: $error';
  }

  @override
  String error_loading_chapters(Object error) {
    return 'Ошибка загрузки глав: $error';
  }

  @override
  String get error_loading_decks => 'Ошибка загрузки колод';

  @override
  String error_loading_microreads(Object error) {
    return 'Ошибка загрузки микрочтений: $error';
  }

  @override
  String error_loading_novels(Object error) {
    return 'Ошибка загрузки романов: $error';
  }

  @override
  String error_loading_poetry(Object error) {
    return 'Ошибка загрузки поэзии: $error';
  }

  @override
  String get etymology => 'Этимология и происхождение: ';

  @override
  String get explanation => 'Пояснение';

  @override
  String get extracted_text_tap_to_lookup =>
      'Извлеченный текст (нажмите для поиска)';

  @override
  String extraction_failed(Object error) {
    return 'Ошибка извлечения: $error';
  }

  @override
  String get failed_to_download => 'Не удалось загрузить.';

  @override
  String failed_to_generate_scenario(Object error) {
    return 'Не удалось создать сценарий: $error';
  }

  @override
  String failed_to_generate_story(Object error) {
    return 'Не удалось сгенерировать историю:\n$error';
  }

  @override
  String failed_to_load_context(Object error) {
    return 'Не удалось загрузить контекст: $error';
  }

  @override
  String get feature_request => 'Предложение функции';

  @override
  String get foundation => 'Базовый уровень';

  @override
  String get how_is_my_pronunciation_scored => 'Как оценивается произношение?';

  @override
  String hsk(Object level) {
    return 'HSK $level';
  }

  @override
  String hsk_vocabulary(int hskLevel) {
    return 'Лексика HSK $hskLevel';
  }

  @override
  String get hsk_level => 'УРОВЕНЬ HSK';

  @override
  String get intermediate => 'Средний уровень';

  @override
  String get learning_stats => 'Статистика обучения';

  @override
  String get mandarin => 'Китайский (путунхуа)';

  @override
  String get meaning => 'Значение';

  @override
  String get no_decks_found => 'Колоды не найдены.';

  @override
  String no_results_found_for(Object searchQuery) {
    return 'По запросу «$searchQuery» ничего не найдено';
  }

  @override
  String get no_when_you_use_echo_hall =>
      'Нет. При использовании Echo Hall, Вердикта Ученого или Студии Shadowing аудиозаписи безопасно оцениваются в реальном времени для расчета баллов произношения и сразу же удаляются. Мы сохраняем только числовые показатели для отслеживания вашего прогресса.';

  @override
  String get notification_settings => 'Настройки уведомлений';

  @override
  String get open_settings => 'Открыть Настройки';

  @override
  String get phoneme => 'Фонема';

  @override
  String get play_reference_pronunciation =>
      'Прослушать эталонное произношение';

  @override
  String get please_select_a_deck_to_add =>
      'Пожалуйста, выберите колоду для добавления карточек.';

  @override
  String get point_at_chinese_text_to_translate =>
      'Наведите камеру на китайский текст для перевода';

  @override
  String get practice_writing_the_strokes_by_hand =>
      'Тренируйте написание черт от руки';

  @override
  String get preferences_audio_and_display => 'Настройки, звук и отображение';

  @override
  String get preparing_your_scholars_verdict =>
      'Подготовка вердикта Ученого...';

  @override
  String get previous => 'Назад';

  @override
  String question(Object current, Object total) {
    return 'Вопрос $current из $total';
  }

  @override
  String remove_from_this_deck(String hanzi) {
    return 'Удалить «$hanzi» из этой колоды?';
  }

  @override
  String revenuecat_error(Object error) {
    return 'Ошибка RevenueCat: $error';
  }

  @override
  String get review_tomorrow => 'Повторить завтра';

  @override
  String get roleplay => 'Ролевая игра';

  @override
  String saving_words_to(int wordCount, String deckName) {
    return 'Сохранение $wordCount слов в «$deckName»...';
  }

  @override
  String get search_radicals_eg_water => 'Поиск ключей (напр.: Вода, 氵)';

  @override
  String get select_target_hsk_level => 'Выберите целевой уровень HSK';

  @override
  String get sentence => 'Предложение';

  @override
  String get shadowing_studio_is_a_dedicated_space =>
      'Студия Shadowing — это специализированное пространство для отработки произношения путем синхронного повторения за носителями языка в реальном времени.';

  @override
  String simplify_failed(Object error) {
    return 'Ошибка адаптации: $error';
  }

  @override
  String get sinospark_premium => 'SinoSpark Премиум';

  @override
  String get speaking_pronunciation => 'Устная речь и произношение';

  @override
  String get statistics => 'Статистика';

  @override
  String get table_of_contents => 'Оглавление · 目录';

  @override
  String get the_ai_evaluates_your_speech_across =>
      'ИИ оценивает вашу речь по трем критериям:\n• Точность: правильно ли артикулированы слоги?\n• Полнота: не пропущены ли слова?\n• Беглость: выдержаны ли естественные паузы и правильные тона?\nЗапись сопоставляется с моделями носителей языка, формируя оценку по 100-балльной шкале.';

  @override
  String get this_cannot_be_undone => 'Это действие нельзя отменить.';

  @override
  String get title => 'Заголовок';

  @override
  String get to_be_reviewed => 'К повторению';

  @override
  String get traditional => 'Традиционный';

  @override
  String translation_failed(Object error) {
    return 'Ошибка перевода: $error';
  }

  @override
  String get type_in => 'Введите...';

  @override
  String get type_your_message_in => 'Введите сообщение...';

  @override
  String get unable_to_open_this_video_please =>
      'Не удалось открыть это видео. Пожалуйста, повторите попытку позже.';

  @override
  String get view_your_learning_history_and_streaks =>
      'Просмотр истории обучения и серий занятий';

  @override
  String get what_is_shadowing_studio => 'Что такое Студия Shadowing?';

  @override
  String get words => 'Слова';

  @override
  String your_path_for_is_ready(String deckName) {
    return 'Ваш учебный путь для «$deckName» готов!';
  }

  @override
  String get you_said => '🗣️ Вы сказали';

  @override
  String vocabularyBatch(Object index) {
    return 'Набор слов $index';
  }

  @override
  String get yourDailyDropIsHere => 'Ваша Ежедневная порция готова! ✨';

  @override
  String get timeToReview => 'Время для повторения! 📚';

  @override
  String get neverMissAStroke => 'Ни одной черты мимо! 🖌️';

  @override
  String get yourTrialEndsTomorrow => 'Пробный период заканчивается завтра! ⏳';

  @override
  String get officialStandardVocabularyTiers =>
      'Официальные стандартные уровни лексики HSK';

  @override
  String get failedToLoadCollections => 'Не удалось загрузить коллекции.';

  @override
  String unnamedKey(Object tag) {
    return '#$tag';
  }

  @override
  String error(Object error) {
    return 'Ошибка: $error';
  }

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
  String get dailyDrops => 'Ежедневные порции';

  @override
  String get wordOfTheDayNews => 'Слово дня и новости';

  @override
  String get reviewReminders => 'Напоминания о повторении';

  @override
  String get flashcardsDueForReview => 'Карточки, готовые к повторению';

  @override
  String get dailyNewCards => 'Новые карточки в день';

  @override
  String get dailyReviewLimit => 'Лимит повторений в день';

  @override
  String get practiceMode => 'Режим практики';

  @override
  String get liziqi => 'Ли Цзыци (李子柒): Шелковые цветы';

  @override
  String get theLifeOfGarlicTraditional =>
      'Жизнь чеснока: традиционный деревенский уклад Китая';

  @override
  String get graceMandarin50Phrases => 'Grace Mandarin: 50 ключевых фраз';

  @override
  String get essentialChinesePhrasesForBeginners =>
      'Базовые фразы на китайском для начинающих';

  @override
  String get makingBambooFurniture => 'Традиционная мебель из бамбука';

  @override
  String get peppaPigChinese => 'Свинка Пеппа на китайском: Прятки (躲猫猫)';

  @override
  String get muddyPuddlesBeginnerFriendly =>
      'Грязные лужи (для начального уровня)';

  @override
  String get mandarinCorner300Verbs => 'Mandarin Corner: 300 базовых глаголов';

  @override
  String get mostCommonChineseVerbs =>
      'Самые распространенные глаголы китайского языка';

  @override
  String get graceMandarinOrderFood => 'Grace Mandarin: Как заказывать еду';

  @override
  String get howToOrderFoodIn => 'Как сделать заказ в китайском ресторане';

  @override
  String get silkFlowersTraditionalCraft => 'Шелковые цветы: старинное ремесло';

  @override
  String get mandarinCorner => 'Mandarin Corner: Китайский для визита к врачу';

  @override
  String get goingToTheDoctorReal => 'У врача: живой разговорный диалог';

  @override
  String get hideAndSeekBeginnerFriendly => 'Прятки (для начального уровня)';

  @override
  String get linGdp6 => 'Сяо Линь объясняет: почему целевой рост ВВП — 6%';

  @override
  String get why6GdpGrowthEasy =>
      'Рост ВВП на 6%: основы китайской экономики простыми словами';

  @override
  String get bbcWorldNews => 'BBC 中文 (Мировые новости)';

  @override
  String get currentEventsInSimplifiedChinese =>
      'Новости на упрощенном китайском языке';

  @override
  String get baidu => 'Baidu (Байду)';

  @override
  String get youtubeDesk => 'РАБОЧИЙ СТОЛ YOUTUBE';

  @override
  String get interactiveTranscriptsShadowing =>
      'Интерактивная транскрипция и метод Shadowing';

  @override
  String get showsDramas => 'ПЕРЕДАЧИ И СЕРИАЛЫ';

  @override
  String get extractToDeck => 'Извлечь слова в колоду';

  @override
  String get autoSimplify => 'Автоматическая адаптация';

  @override
  String get rewriteThisArticleToMatch =>
      'Адаптировать текст под ваш уровень HSK';

  @override
  String failedToSaveExtractedWords(Object error) {
    return 'Не удалось сохранить извлеченные слова: $error';
  }

  @override
  String addToDeck(Object count) {
    return 'Добавить в колоду ($count)';
  }

  @override
  String get dailyDiscoveryDrop => 'Ежедневное открытие';

  @override
  String get smartSpacedRepetition => 'Интервальное повторение (SRS)';

  @override
  String get trialProtectionAlert => 'Уведомление о пробном периоде';

  @override
  String get masteryLevel => 'Уровень освоения';

  @override
  String get targetObjective => 'Цель обучения';

  @override
  String get dailyPractice => 'Ежедневная практика';

  @override
  String get aiSpacedRepetition => 'Интервальные повторения с ИИ';

  @override
  String get iVeGrantedAccess => 'Доступ предоставлен';

  @override
  String get scanner => 'Сканер';

  @override
  String get interpreter => 'Переводчик';

  @override
  String cards(Object count) {
    return 'Карточек: $count';
  }

  @override
  String get nWaMendsTheHeavens => 'Нюйва латает небосвод (女娲补天)';

  @override
  String get terracottaArmy => 'Терракотовая армия';

  @override
  String get forbiddenCity => 'Запретный город (Гугун)';

  @override
  String get aBlessingInDisguise => 'Нет худа без добра (塞翁失马)';

  @override
  String get drawingASnake => 'Пририсовать змее ноги (画蛇添足)';

  @override
  String get takingTheBulletTrain =>
      'Поездка на высокоскоростном поезде (гаоте)';

  @override
  String get visitingTheDoctor => 'Визит к врачу';

  @override
  String get orderingDumplings => 'Заказ пельменей цзяоцзы';

  @override
  String get theTeaCeremony => 'Китайская чайная церемония (Гунфу-ча)';

  @override
  String get chineseCalligraphy => 'Китайская каллиграфия';

  @override
  String get theGiantPanda => 'Большая панда';

  @override
  String get simplifiedText => 'Адаптированный текст';

  @override
  String get novels96 => 'Романы (96 произведений)';

  @override
  String get microReads => 'Микрочтения';

  @override
  String get poetry => 'Классическая поэзия';

  @override
  String get bookmarkRemoved => '书签已移除 · Закладка удалена';

  @override
  String bookmarkAdded(Object chapter) {
    return '已添加书签 · Закладка добавлена: Глава $chapter';
  }

  @override
  String get readingVocabulary => 'Чтение и лексика';

  @override
  String vocabularyBatchUnitindex1(Object index) {
    return 'Набор слов $index';
  }

  @override
  String get yourDailyDropIsHere1 => 'Ваша ежедневная порция готова! ✨';

  @override
  String get timeToReview1 => 'Время повторить пройденное! 📚';

  @override
  String get neverMissAStroke1 => 'Ни одной черты мимо! 🖌️';

  @override
  String get yourTrialEndsTomorrow1 => 'Пробный период заканчивается завтра! ⏳';

  @override
  String get hskCollections1 => 'Коллекции HSK';

  @override
  String get officialStandardVocabularyTiers1 =>
      'Официальные стандартные уровни лексики HSK';

  @override
  String get failedToLoadCollections1 => 'Не удалось загрузить коллекции.';

  @override
  String ui__transcription(Object transcription) {
    return '«$transcription»';
  }

  @override
  String playPinyinwithtone(Object pinyinWithTone) {
    return 'Воспроизвести $pinyinWithTone';
  }

  @override
  String errorE(Object e) {
    return 'Ошибка: $e';
  }

  @override
  String lookalikepinyin(Object pinyin) {
    return '($pinyin)';
  }

  @override
  String get aiSmartContext1 => 'Умный контекст ИИ';

  @override
  String get aiSmartContextError1 => 'Ошибка умного контекста ИИ';

  @override
  String errorErr(Object err, Object error) {
    return 'Ошибка: $error';
  }

  @override
  String get downloadOfficialHskCollections1 =>
      'Загрузить официальные коллекции HSK';

  @override
  String get unableToLoadThisSectionPleaseTryAga =>
      'Не удалось загрузить этот раздел. Пожалуйста, попробуйте снова.';

  @override
  String get searchRadicalsEgWater => 'Поиск ключей (напр.: Вода, 氵)';

  @override
  String ui__currentstrokeindex1totalstrokes(Object current, Object total) {
    return '$current/$total';
  }

  @override
  String get translationLanguage1 => 'Язык перевода';

  @override
  String get appLanguage1 => 'Язык приложения';

  @override
  String get dailyDrops1 => 'Ежедневные порции';

  @override
  String get wordOfTheDayNews1 => 'Слово дня и новости';

  @override
  String get reviewReminders1 => 'Напоминания о повторении';

  @override
  String get flashcardsDueForReview1 => 'Карточки для повторения';

  @override
  String get accuracyByMode1 => 'Точность по режимам';

  @override
  String accuracytostringasfixed1(Object accuracy) {
    return '$accuracy%';
  }

  @override
  String get upcomingReviewsNext7Days =>
      'Предстоящие повторения (следующие 7 дней)';

  @override
  String get explaining => 'Пояснение:';

  @override
  String entryhanziEntrypinyin(Object hanzi, Object pinyin) {
    return '$hanzi [$pinyin]';
  }

  @override
  String get dailyNewCards1 => 'Новые карточки в день';

  @override
  String get dailyReviewLimit1 => 'Дневной лимит повторений';

  @override
  String get listeningMode1 => 'Режим аудирования';

  @override
  String get readingMode1 => 'Режим чтения';

  @override
  String get recallMode1 => 'Режим воспроизведения';

  @override
  String get speakingMode1 => 'Режим говорения';

  @override
  String get practiceMode1 => 'Режим практики';

  @override
  String acc(Object acc) {
    return '$acc%';
  }

  @override
  String get partner1 => 'Собеседник';

  @override
  String get partnerSpeaking1 => 'Собеседник говорит…';

  @override
  String get theLifeOfGarlicTraditionalChineseLi =>
      'Жизнь чеснока: традиционный деревенский уклад Китая';

  @override
  String get graceMandarin50Phrases1 => 'Grace Mandarin: 50 ключевых фраз';

  @override
  String get essentialChinesePhrasesForBeginners1 =>
      'Базовые фразы на китайском для начинающих';

  @override
  String get makingBambooFurniture1 => 'Традиционная мебель из бамбука';

  @override
  String get muddyPuddlesBeginnerFriendly1 =>
      'Грязные лужи (для начального уровня)';

  @override
  String get mandarinCorner300Verbs1 => 'Mandarin Corner: 300 базовых глаголов';

  @override
  String get mostCommonChineseVerbs1 =>
      'Самые распространенные глаголы китайского языка';

  @override
  String get graceMandarinOrderFood1 => 'Grace Mandarin: Как заказывать еду';

  @override
  String get howToOrderFoodInAChineseRestaurant =>
      'Как сделать заказ в китайском ресторане';

  @override
  String get silkFlowersTraditionalCraft1 =>
      'Шелковые цветы: старинное ремесло';

  @override
  String get goingToTheDoctorRealLifeConversatio =>
      'У врача: живой разговорный диалог';

  @override
  String get hideAndSeekBeginnerFriendly1 => 'Прятки (для начального уровня)';

  @override
  String get lingdp6 => 'Сяо Линь объясняет: почему целевой рост ВВП — 6%';

  @override
  String get why6GdpGrowthEasyChineseEconomics =>
      'Рост ВВП на 6%: основы китайской экономики простыми словами';

  @override
  String get currentEventsInSimplifiedChinese1 =>
      'Новости на упрощенном китайском языке';

  @override
  String get baidu1 => 'Baidu (Байду)';

  @override
  String get youtubeDesk1 => 'РАБОЧИЙ СТОЛ YOUTUBE';

  @override
  String get interactiveTranscriptsShadowing1 =>
      'Интерактивная транскрипция и метод Shadowing';

  @override
  String get showsDramas1 => 'ПЕРЕДАЧИ И СЕРИАЛЫ';

  @override
  String error_error(Object error) {
    return 'Ошибка: $error';
  }

  @override
  String get extractToDeck1 => 'Извлечь слова в колоду';

  @override
  String get autosimplify => 'Автоматическая адаптация';

  @override
  String get rewriteThisArticleToMatchYourHskLev =>
      'Адаптировать текст под ваш уровень HSK';

  @override
  String get addToDeck1 => 'Добавить в колоду';

  @override
  String playbackratex(Object playbackRate) {
    return '${playbackRate}x';
  }

  @override
  String speedx(Object speed) {
    return '${speed}x';
  }

  @override
  String get dailyDiscoveryDrop1 => 'Ежедневное открытие';

  @override
  String get smartSpacedRepetition1 => 'Интервальное повторение (SRS)';

  @override
  String get trialProtectionAlert1 => 'Уведомление о пробном периоде';

  @override
  String get masteryLevel1 => 'Уровень освоения';

  @override
  String get targetObjective1 => 'Цель обучения';

  @override
  String get dailyPractice1 => 'Ежедневная практика';

  @override
  String get aiSpacedRepetition1 => 'Интервальные повторения с ИИ';

  @override
  String get iveGrantedAccess => 'Доступ предоставлен';

  @override
  String addToDeck_selectedwordindiceslength(Object count) {
    return 'Добавить в колоду ($count)';
  }

  @override
  String get scanner1 => 'Сканер';

  @override
  String get interpreter1 => 'Переводчик';

  @override
  String entryvalueCards(Object count) {
    return 'Карточек: $count';
  }

  @override
  String score_score_questionslength(Object score, Object total) {
    return 'Счет: $score / $total';
  }

  @override
  String get theMonkeyKing1 => 'Царь Обезьян';

  @override
  String get huaMulan1 => 'Хуа Мулань';

  @override
  String get nwaMendsTheHeavens => 'Нюйва латает небосвод';

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
  String get drawingASnake1 => 'Пририсовать змее ноги';

  @override
  String get takingTheBulletTrain1 => 'Поездка на скоростном поезде';

  @override
  String get visitingTheDoctor1 => 'Визит к врачу';

  @override
  String get orderingDumplings1 => 'Заказ пельменей цзяоцзы';

  @override
  String get theTeaCeremony1 => 'Китайская чайная церемония';

  @override
  String get chineseCalligraphy1 => 'Китайская каллиграфия';

  @override
  String get theGiantPanda1 => 'Большая панда';

  @override
  String get simplifiedText1 => 'Адаптированный текст';

  @override
  String get novels961 => 'Романы (96 произведений)';

  @override
  String get microreads => 'Микрочтения';

  @override
  String get poetry1 => 'Классическая поэзия';

  @override
  String get readingVocabulary1 => 'Чтение и лексика';

  @override
  String get defaultfirebaseoptionsHaveNotBeenCo =>
      'Параметры DefaultFirebaseOptions не настроены для Linux.';

  @override
  String get defaultfirebaseoptionsAreNotSupport =>
      'Параметры DefaultFirebaseOptions не поддерживаются на этой платформе.';

  @override
  String get hanziMaster1 => 'SinoSpark';

  @override
  String get strokesCannotBeEmpty => 'Список черт не может быть пустым.';

  @override
  String get wrongStartPoint => 'Неверная начальная точка черты.';

  @override
  String get rightShapeButWrongPlace => 'Форма верная, но положение смещено!';

  @override
  String get goodFollowTheFlow =>
      'Отлично! Следуйте естественному движению кисти.';

  @override
  String get aBitShaky => 'Линия получилась немного неровной!';

  @override
  String get aBitHesitant => 'Чувствуется легкая неуверенность в движении...';

  @override
  String get shapeIsOff => 'Форма черты искажена.';

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
  String get microphonePermissionDenied => 'Доступ к микрофону отклонен';

  @override
  String get offset => 'Смещение';

  @override
  String get audioserviceHasBeenDisposed =>
      'Сервис AudioService был остановлен';

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
  String get kore => 'Kore (женский, мягкий тон)';

  @override
  String get xmicrosoftoutputformatAudio24khz48k =>
      'audio-24khz-48kbitrate-mono-mp3';

  @override
  String get useragentHanzimasterapp => 'HanziMasterApp';

  @override
  String get anchorWord => 'Опорное слово';

  @override
  String get creativeThematicTitle => 'Креативное название темы';

  @override
  String get briefPedagogicalOrSemanticRationale =>
      'Краткое педагогическое или семантическое обоснование';

  @override
  String get theSingleMostCentralCharacterFromTh =>
      'Главный ключевой иероглиф из списка';

  @override
  String get aBalancedSetOfCharactersFromYourLib =>
      'Сбалансированная подборка иероглифов из вашей библиотеки';

  @override
  String get yourNaturalConversationalReplyInChi =>
      'Ваш естественный разговорный ответ китайскими иероглифами';

  @override
  String get theEnglishTranslationOfYourReply =>
      'Русский перевод вашего ответа';

  @override
  String get thePinyinWithToneMarksForYourReply =>
      'Пиньинь с обозначением тонов для вашего ответа';

  @override
  String get aSuggestedResponseTheUserCouldSayBa =>
      'Вариант фразы, которую пользователь может сказать в ответ';

  @override
  String get pinyinForTheSuggestion => 'Пиньинь для подсказанной фразы';

  @override
  String get englishTranslationForTheSuggestion =>
      'Русский перевод для подсказанной фразы';

  @override
  String get scholarsCritique => 'Вердикт и разбор Ученого';

  @override
  String get theEchoHallRemainsSilentTryYourBrea =>
      'В Зале Эха царит тишина. Переведите дух и попробуйте снова.';

  @override
  String get xtitleHanziMaster => 'SinoSpark';

  @override
  String get noneYet => 'Пока пусто.';

  @override
  String get exactSentence => 'Изучаемое предложение:';

  @override
  String get englishTranslation => 'Русский перевод';

  @override
  String get previouslyGeneratedPhrases => 'Ранее созданные фразы';

  @override
  String get iLikeDrinkingAppleJuice => 'Я люблю пить яблочный сок.';

  @override
  String get theEnglishMeaningHere => 'Значение на русском языке...';

  @override
  String get failedToFetchDefinition => 'Не удалось загрузить определение.';

  @override
  String get failedToLoadExplanation => 'Не удалось загрузить пояснение.';

  @override
  String get failedToLoadComparison =>
      'Не удалось загрузить сравнительный анализ.';

  @override
  String get emptyResponseFromOpenrouter =>
      'Получен пустой ответ от OpenRouter';

  @override
  String get emptyResponseFromVisionModel =>
      'Получен пустой ответ от модели распознавания (Vision)';

  @override
  String get standard => 'Стандартный';

  @override
  String get theFullSentenceInChinese => 'Полное предложение на китайском...';

  @override
  String get theWordOrCharacterInChinese => 'Слово или иероглиф на китайском';

  @override
  String get thePinyinForThisSpecificWord => 'Пиньинь для данного слова';

  @override
  String get emptyResponseFromDeepseekApi =>
      'Получен пустой ответ от DeepSeek API';

  @override
  String get criticalPutTheEnglishTranslationInT =>
      'ВАЖНО: Укажите русский перевод в поле';

  @override
  String get englishTranslationOfTheEntireSenten =>
      'Русский перевод всего предложения';

  @override
  String get hanziWord => 'Иероглиф / Слово';

  @override
  String get theFullSimplifiedSentenceInChinese =>
      'Полное предложение на упрощенном китайском...';

  @override
  String get lyingFlatACulturalMovement =>
      'Танпин (лежание плашмя): социокультурный феномен...';

  @override
  String get theUserYouAreSpeakingToIsNamed => 'Имя собеседника:';

  @override
  String get importantRuleDoNotAddressTheUserByA =>
      'ВАЖНОЕ ПРАВИЛО: Не обращайтесь к пользователю по вымышленным именам и не используйте шаблонные плейсхолдеры вроде';

  @override
  String get youAreAConciseChineseCalligraphyAnd =>
      'Вы — лаконичный и опытный репетитор по китайской каллиграфии и этимологии в мобильном приложении.';

  @override
  String get theStudentIsStudyingTheCharacter => 'Ученик изучает иероглиф';

  @override
  String get neverWriteIntroductionsSignoffsOrFi =>
      'Никогда не используйте вводные приветствия, прощания или лишние пустые фразы вроде';

  @override
  String get beDirectAndInformative => 'Отвечайте четко, емко и по существу.';

  @override
  String get criticalRuleYouMustRespondEntirelyI =>
      'СТРОГОЕ ПРАВИЛО: Вы должны отвечать ИСКЛЮЧИТЕЛЬНО на языке, соответствующем коду ISO 639-1';

  @override
  String get youAreAConciseChineseGrammarTutorIn =>
      'Вы — лаконичный репетитор по китайской грамматике в мобильном приложении.';

  @override
  String get theStudentIsConfusedAboutTheWord =>
      'Ученик сомневается в употреблении слова';

  @override
  String get neverWriteIntroductionsSignoffsOrFi1 =>
      'Никогда не пишите шаблонные вступления, прощания или фразы-заполнители.';

  @override
  String get azureSpeechApiKeysAreMissing =>
      'Отсутствуют ключи Azure Speech API.';

  @override
  String get success => 'Успешно';

  @override
  String get granularity => 'Детализация';

  @override
  String get phoneme1 => 'Фонема';

  @override
  String get dimension => 'Критерий оценки';

  @override
  String get comprehensive => 'Комплексная оценка';

  @override
  String get weCouldntHearYouClearlyPleaseTryAga =>
      'Не удалось четко распознать голос. Пожалуйста, повторите попытку.';

  @override
  String get noNbestResultFound =>
      'Оптимальный результат распознавания не найден.';

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
  String get omission => 'Пропуск слова';

  @override
  String get insertion => 'Лишний звук (вставка)';

  @override
  String get youMissedThisWord => 'Вы пропустили это слово.';

  @override
  String get extraWordAddedHere => 'Здесь было произнесено лишнее слово.';

  @override
  String get mispronunciation => 'Неверное произношение';

  @override
  String get pronunciationWasInaccurate =>
      'Произношение было недостаточно точным.';

  @override
  String get goodEffortKeepPracticing =>
      'Хорошая попытка! Продолжайте тренироваться.';

  @override
  String get perfectPronunciationSoundsLikeANati =>
      'Безупречное произношение! Звучит как у носителя языка.';

  @override
  String get greatJobAFewMinorToneInaccuracies =>
      'Отличная работа! Есть лишь пара едва заметных неточностей в тонах.';

  @override
  String get notBadButYourTonesNeedSomeWork =>
      'Неплохо, но тонам стоит уделить еще немного внимания.';

  @override
  String get keepPracticingListenToTheNativeAudi =>
      'Слушайте эталонное аудио носителя и пробуйте снова!';

  @override
  String get lexical => 'Лексический';

  @override
  String get chineseHanziHere => 'Китайские иероглифы здесь';

  @override
  String get aShortSummaryInEnglish => 'Краткое содержание на русском';

  @override
  String get noCoherentChineseTextFoundInTheScan =>
      'На отсканированном изображении не найдено распознаваемого китайского текста.';

  @override
  String get theFullEnglishTranslationOfTheScann =>
      'Полный русский перевод распознанного текста... ИЛИ «Разборчивый китайский текст не обнаружен».';

  @override
  String get aShort24WordTitleForThisScanEgResta =>
      'Краткий заголовок из 2–4 слов для этого скана (напр.: «Меню ресторана», «Дорожный указатель»)';

  @override
  String get china => 'Китай';

  @override
  String get noTranslationAvailable => 'Перевод недоступен.';

  @override
  String get scanResults => 'Результаты сканирования';

  @override
  String get whenWasItWrittenAndWhatWasHappening =>
      'Когда это было создано и какой исторический контекст окружал автора в Китае?';

  @override
  String get whyIsThisPieceFamousWhatPhilosophic =>
      'Чем знаменито это произведение и какие философские или культурные темы в нем заложены?';

  @override
  String get aBriefBioOfTheAuthor => 'Краткая биография автора';

  @override
  String get informationUnavailable => 'Информация недоступна.';

  @override
  String get noSummaryAvailable => 'Краткое описание отсутствует.';

  @override
  String get hanziAiPro => 'SinoSpark AI Pro';

  @override
  String get trialNormalIntro => 'Пробный, Обычный, Введение';

  @override
  String get dailyDrop => 'Ежедневная порция';

  @override
  String get dailyNotificationsForWordOfTheDayAn =>
      'Уведомления о Слове дня и новостях';

  @override
  String get aNewWordAndStoryOfTheDayAreWaitingF =>
      'Вас ждут новое Слово и История дня!';

  @override
  String get spacedRepetition => 'Интервальное повторение (SRS)';

  @override
  String get remindersForFlashcardsDueForReview =>
      'Напоминания о карточках, требующих повторения';

  @override
  String get engagementReminders => 'Напоминания о регулярных занятиях';

  @override
  String get trialReminders => 'Напоминания о пробном периоде';

  @override
  String get notificationsForYourTrialStatus =>
      'Уведомления о статусе вашего пробного периода';

  @override
  String get comeReviewYourHanziAndTryALiveCallB =>
      'Повторите иероглифы и опробуйте Голосовой звонок до окончания бесплатного доступа!';

  @override
  String get scholarsEye => 'Взгляд Ученого (экспертный разбор)';

  @override
  String get clMeasureWord => 'Счетное слово (CL):';

  @override
  String get surnameShi => 'Фамилия Ши';

  @override
  String get chineseFamilyNameShi => 'Китайская фамилия (Ши)';

  @override
  String get neutralToneLight => 'Нейтральный тон (легкий)';

  @override
  String get keepYourPitchHighAndSteadyLikeSingi =>
      'Держите тон ровным и высоким, как будто тянете ноту.';

  @override
  String get startInTheMiddleAndSlideYourPitchUp =>
      'Начните со среднего регистра и ведите тон вверх, словно переспрашивая: «Что?»';

  @override
  String get dipYourVoiceDownLowThenRiseGentlyBa =>
      'Опустите голос в нижний регистр, а затем плавно выведите его наверх.';

  @override
  String get dropYourPitchSharplyAndDecisivelyLi =>
      'Резко и твердо бросьте тон вниз, как при категоричном: «Нет!»';

  @override
  String get pronounceSoftlyBrieflyAndWithoutEmp =>
      'Произносите мягко, коротко и без акцента.';

  @override
  String get spotOnPitchWasHighFlatAndSteady =>
      'В точку! Высокий тон выдержан ровно и стабильно.';

  @override
  String get spotOnUpwardPitchRiseWasClear =>
      'В точку! Восходящее движение тона прозвучало четко.';

  @override
  String get spotOnLowDippingCurveWasAccurate =>
      'В точку! Понижение и подъем тона выполнены предельно точно.';

  @override
  String get spotOnSharpFallingDropWasDecisive =>
      'В точку! Резкое нисходящее движение тона прозвучало уверенно.';

  @override
  String get spotOnToneWasPronouncedAccurately =>
      'В точку! Тон произнесен абсолютно точно.';

  @override
  String get iAgreeToTheTermsOfServiceAndPrivacy =>
      'Я принимаю Условия использования и Политику конфиденциальности.';

  @override
  String get sendMeOccasionalUpdatesTipsAndOffer =>
      'Получать полезные советы по учебе и спецпредложения.';

  @override
  String get signInToSyncYourProgress =>
      'Войдите, чтобы синхронизировать прогресс в облаке.';

  @override
  String get createAnAccountToSaveYourStats =>
      'Создайте аккаунт для надежного сохранения статистики.';

  @override
  String get smartSpiral => 'УМНАЯ СПИРАЛЬ';

  @override
  String get origin => 'Истоки';

  @override
  String get elements => 'Природные стихии';

  @override
  String get humanity => 'Человек и тело';

  @override
  String get village => 'Быт и поселения';

  @override
  String get journey => 'Путь и движение';

  @override
  String get city => 'Город и общество';

  @override
  String get originTheSimplestShapesTheBeginning =>
      'Базовые формы. Начало начал всех иероглифов.';

  @override
  String get elementsSunMoonWaterAndFireTheNatur =>
      'Солнце, Луна, Вода и Огонь. Мир живой природы.';

  @override
  String get humanityTheBodyTheHeartAndTheFamily =>
      'Тело, сердце, родственные узы и человек.';

  @override
  String get villageFieldsRoofsAndToolsTheFounda =>
      'Поля, жилища и орудия труда. Основа социума.';

  @override
  String get journeyMovementSpeechAndSustenance =>
      'Движение, живая речь и пропитание.';

  @override
  String get cityCommerceClothingAndComplexArtif =>
      'Торговля, одежда и шедевры цивилизации.';

  @override
  String get equilibriumAlgorithm => 'Алгоритм балансировки';

  @override
  String get misc => 'Разное';

  @override
  String get cityOrOriginAs => '«Город» или «Истоки» как';

  @override
  String get miscToOrigin => 'Из «Разного» в «Истоки»';

  @override
  String get constellation => 'Созвездие';

  @override
  String get whichOneIsWater => 'Какой из иероглифов означает «Вода»?';

  @override
  String get whatIsThePinyin => 'Какой пиньинь верный?';

  @override
  String get nature => 'Природа';

  @override
  String get whatEssenceDoes => 'Какой радикал (ключ) входит в состав';

  @override
  String get allTiers => 'Все уровни';

  @override
  String get active => 'Активно';

  @override
  String get theScrollOfOrigin1 => 'СВИТОК ИСТОКОВ';

  @override
  String galaxyOf1(Object name) {
    return 'ГАЛАКТИКА $name';
  }

  @override
  String get also => 'Также';

  @override
  String get work => 'Труд / Работа';

  @override
  String get cloud => 'Облако';

  @override
  String get youArchaic => 'Ты (архаичн.)';

  @override
  String get suddenly => 'Внезапно';

  @override
  String get owner => 'Хозяин';

  @override
  String get door => 'Дверь / Врата';

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
  String get shorttailedBird => 'Короткохвостая птица (隹)';

  @override
  String get shoot => 'Стрелять / Побег бамбука';

  @override
  String get small => 'Маленький';

  @override
  String get gather => 'Собирать';

  @override
  String get order => 'Порядок';

  @override
  String get flat => 'Плоский';

  @override
  String get thePersonWho => 'Тот, кто... (者)';

  @override
  String get nobleman => 'Благородный муж';

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
  String get beg => 'Просить / Молить';

  @override
  String get window => 'Окно';

  @override
  String get fear => 'Страх';

  @override
  String get drum => 'Барабан';

  @override
  String get why => 'Почему / Зачем';

  @override
  String get talent => 'Талант';

  @override
  String get follow => 'Следовать';

  @override
  String get desert => 'Пустыня';

  @override
  String get component => 'Компонент (радикал)';

  @override
  String divingInto1(Object topic) {
    return 'Погружение в тему: $topic';
  }

  @override
  String get unitIntro1 => 'Введение в раздел';

  @override
  String get theBlueprint => 'ЧЕРТЕЖ';

  @override
  String get theOrigin => 'ИСТОКИ';

  @override
  String get theGalaxy => 'ГАЛАКТИКА';

  @override
  String get theScholarListens => 'Ученый слушает...';

  @override
  String get consultingTheScrolls => 'Изучение древних свитков...';

  @override
  String get traceWithTheGuide => 'Пишите по подсказке';

  @override
  String get traceTheGhost => 'Пишите по контуру';

  @override
  String get connectTheDots => 'Соедините опорные точки';

  @override
  String get drawFromMemory => 'Напишите по памяти';

  @override
  String get assistant => 'Ассистент';

  @override
  String get puck => 'Puck (мужской, спортивный)';

  @override
  String get helloWelcomeWhatWouldYouLikeToOrder =>
      'Здравствуйте! Добро пожаловать. Что желаете заказать?';

  @override
  String get ni3Hao3Huan1ying2Guang1lin2Qing3wen =>
      'Nǐ hǎo! Huānyíng guānglín. Qǐngwèn nǐ yào diǎn shénme?';

  @override
  String get waiterLi => 'Официант Ли';

  @override
  String get askForTheMenu => 'Попросить меню';

  @override
  String get orderOneDishAndOneDrink => 'Заказать одно блюдо и один напиток';

  @override
  String get askForTheBill => 'Попросить счет';

  @override
  String get fenrir => 'Fenrir (мужской, энергичный)';

  @override
  String get ni3Qu4Na3rAJi1chang3MaTing3Yuan3De =>
      'Nǐ qù nǎr a? Jīchǎng ma? Tǐng yuǎn de!';

  @override
  String get driverWang => 'Водитель Ван';

  @override
  String get tellTheDriverYouAreGoingToTheAirpor =>
      'Сказать водителю, что вам нужно в аэропорт';

  @override
  String get askHowLongTheTripWillTake => 'Уточнить время в пути';

  @override
  String get complainAboutTheTraffic => 'Обсудить плотное движение на дорогах';

  @override
  String get charon => 'Charon (мужской, дикторский стиль)';

  @override
  String get thisClothingQualityIsEspeciallyGood =>
      'Качество этой вещи отличное, и стоит всего 200 юаней.';

  @override
  String get zhe4Jian4Yi1fuZhi4liang4Te4bie2Hao3 =>
      'Zhè jiàn yīfu zhìliàng tèbié hǎo, zhǐyào liǎng bǎi kuài.';

  @override
  String get auntieChen => 'Тетушка Чэнь';

  @override
  String get askHowMuchTheSilkShirtCosts => 'Спросить цену шелковой рубашки';

  @override
  String get sayItIsTooExpensive => 'Сказать, что это слишком дорого';

  @override
  String get bargainThePriceDownTo100Rmb => 'Сторговаться до 100 юаней';

  @override
  String get ni3Na3li3Bu4Shu1fuFa1shao1LeMa =>
      'Nǐ nǎlǐ bù shūfu? Fāshāo le ma?';

  @override
  String get drZhang => 'Доктор Чжан';

  @override
  String get explainYouHaveHadAHeadacheForTwoDay =>
      'Объяснить, что голова болит уже два дня';

  @override
  String get sayYouHaveASlightFever =>
      'Сказать, что поднялась небольшая температура';

  @override
  String get askIfYouNeedToTakeMedicine =>
      'Спросить, нужно ли принимать лекарства';

  @override
  String get aoede => 'Aoede (женский, звонкий)';

  @override
  String get heyLongTimeNoSeeHowHaveYouBeenLatel =>
      'Привет! Сколько лет, сколько зим! Как твои дела?';

  @override
  String get ni3Hao3Hao3jiu3Bu4jian4Ni3Zui4jin4Z =>
      'Nǐ hǎo! Hǎojiǔ bùjiàn, nǐ zuìjìn zěnmeyàng?';

  @override
  String get pleaseIntroduceYourselfWhyDoYouWant =>
      'Пожалуйста, расскажите о себе. Почему вы хотите работать именно в нашей компании?';

  @override
  String get qing3Xian1Zi4wo3Jie4shao4Yi1xia4Ni3 =>
      'Qǐng xiān zìwǒ jièshào yíxià. Nǐ wèishénme xiǎng lái wǒmen gōngsī gōngzuò?';

  @override
  String get managerLiu => 'Менеджер Лю (HR)';

  @override
  String get introduceYourProfessionalBackground =>
      'Кратко описать свой профессиональный опыт';

  @override
  String get explainWhyYouWantToWorkAtThisCompan =>
      'Объяснить свою мотивацию и интерес к компании';

  @override
  String get askAPoliteQuestionAboutTheCompanyCu =>
      'Задать вежливый вопрос о корпоративной культуре';

  @override
  String get microphoneAccessIsRequiredPleaseEna =>
      'Требуется доступ к микрофону. Пожалуйста, включите его в настройках устройства.';

  @override
  String get couldNotStartMicrophonePleaseCheckY =>
      'Не удалось включить микрофон. Проверьте настройки звука и повторите попытку.';

  @override
  String get weDidntQuiteCatchThatPleaseHoldTheM =>
      'Не удалось четко расслышать. Удерживайте кнопку микрофона и попробуйте снова!';

  @override
  String get recordingWasTooShortHoldTheMicAndSp =>
      'Запись получилась слишком короткой. Удерживайте кнопку и говорите разборчиво.';

  @override
  String get audioBufferWasEmptyPleaseCheckYourM =>
      'Аудиобуфер пуст. Проверьте микрофон и попробуйте снова.';

  @override
  String get audioFileIsSilentPleaseSpeakIntoThe =>
      'В аудиофайле нет звука. Говорите прямо в микрофон.';

  @override
  String get weCouldntUnderstandYourPronunciatio =>
      'Не удалось распознать произношение. Пожалуйста, говорите четче и повторите запись.';

  @override
  String get theServerIsTakingTooLongToRespondPl =>
      'Сервер отвечает дольше обычного. Пожалуйста, попробуйте еще раз.';

  @override
  String get noInternetConnectionPleaseCheckYour =>
      'Отсутствует подключение к интернету. Проверьте сеть и повторите попытку.';

  @override
  String get audioProcessingFailedPleaseTryAgain =>
      'Ошибка при обработке аудио. Пожалуйста, попробуйте снова.';

  @override
  String get permission => 'Разрешение';

  @override
  String get couldNotProcessYourRecordingPleaseT =>
      'Не удалось обработать запись. Пожалуйста, попробуйте еще раз.';

  @override
  String get user => 'Пользователь';

  @override
  String get scholar => 'Ученый';

  @override
  String get ourAiTutorsAreCurrentlyOfflinePleas =>
      'Наши ИИ-тьюторы сейчас оффлайн. Пожалуйста, попробуйте позже.';

  @override
  String get hideTranslation => 'Скрыть перевод';

  @override
  String get azureAssessment => 'Оценка Azure в процессе...';

  @override
  String get microphonePermissionRequired => 'Необходим доступ к микрофону';

  @override
  String get connectedSpeakNow => 'Связь установлена! Можно говорить.';

  @override
  String get initializationErrorCheckPermissions =>
      'Ошибка инициализации. Проверьте выданные разрешения.';

  @override
  String get microphoneErrorTapToRetry =>
      'Ошибка микрофона. Нажмите, чтобы повторить попытку.';

  @override
  String get theTutorReturnedAnEmptyResponse => 'Тьютор вернул пустой ответ.';

  @override
  String get connectionInterruptedPleaseSpeakAga =>
      'Соединение прервано. Пожалуйста, повторите фразу.';

  @override
  String get callPausedReviewingTones => 'Звонок на паузе (разбор тонов)';

  @override
  String get pausedTakeABreak => 'Пауза — сделайте небольшой перерыв';

  @override
  String get goodStartPracticing => 'Отличное начало практики!';

  @override
  String get studentCoach => 'Ученик / Наставник';

  @override
  String get keepYour1stToneHighAndSteadyOn =>
      'Держите 1-й тон высоким и ровным на слоге';

  @override
  String get noScenariosFound => 'Сценарии не найдены.';

  @override
  String get designYourOwnAiRoleplayExperience =>
      'Создайте свой персональный ИИ-диалог';

  @override
  String get generateFromDeck => 'Сгенерировать из колоды';

  @override
  String get practiceFlashcardVocabularyInALiveD =>
      'Отрабатывайте слова из карточек в живом диалоге';

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
  String get orderingAtAChengduTeahouse => 'Заказ чая в чайной в Чэнду';

  @override
  String get buyingTeaAtTheMarket => 'Покупка чая на традиционном рынке';

  @override
  String get meetingAnOldClassmate => 'Встреча со старым одноклассником';

  @override
  String get readyToPractice => 'Готовы к тренировке?';

  @override
  String get letsPracticeChinese => 'Попрактикуем китайский язык';

  @override
  String get areYouReady => 'Вы готовы?';

  @override
  String get discussWhatToHaveForDinner => 'Обсудить выбор блюд на ужин';

  @override
  String get suggestWatchingAMovieAfterwards =>
      'Предложить посмотреть фильм после ужина';

  @override
  String get askIfTheyWouldLikeTea => 'Предложить выпить чаю';

  @override
  String get helloVeryNiceToMeetYou =>
      'Здравствуйте! Очень приятно познакомиться.';

  @override
  String get deckPractice => 'Практика по колоде';

  @override
  String get practiceVocabularyWithAnAiPartner =>
      'Тренируйте словарный запас с ИИ-партнером.';

  @override
  String get designCustomAiRoleplayConversation =>
      'Создавайте собственные сценарии и ролевые диалоги с ИИ';

  @override
  String get random => 'Случайный выбор';

  @override
  String get scenarioTopic => 'Тема сценария';

  @override
  String get contextSettingOptional => 'Контекст и обстановка (необязательно)';

  @override
  String get aiCharacterPersonaOptional => 'Роль / Персонаж ИИ (необязательно)';

  @override
  String get aQuietBambooCourtyardTeahouseInChen =>
      'Уединенная чайная с бамбуковым двориком в Чэнду под нежные звуки гучжэна.';

  @override
  String get aBustlingSmokyNightMarketFilledWith =>
      'Шумный ночной рынок с ароматами шашлычков на углях, паровых булочек баоцзы и уличной еды.';

  @override
  String get aLivelyHotpotRestaurantInChongqingW =>
      'Колоритный ресторан сычуаньского хого в Чунцине с кипящим огненным бульоном и пряным ароматом чили.';

  @override
  String get aBustlingTraditionalCantoneseTeahou =>
      'Традиционная кантонская чайная в Гуанчжоу, наполненная паром от бамбуковых лукошек с димсамами.';

  @override
  String get aChicMinimalistCafeInTheFrenchConce =>
      'Элегантное минималистичное кафе во Французской концессии дождливым воскресным днем.';

  @override
  String get aWarmNorthernHomeKitchenDuringWinte =>
      'Уютная домашняя кухня северного Китая зимой: мука на столе и исходящие паром кастрюли с цзяоцзы.';

  @override
  String get anOpenairNightStreetFoodAlleyWithSi =>
      'Оживленный ночной переулок уличной еды со шкворчащими шашлычками из баранины, печеными баклажанами и холодным пивом.';

  @override
  String get aSnowyStreetCornerOutsideTheLamaTem =>
      'Заснеженный перекресток у храма Юнхэгун с ярко-красными блестящими шпажками танхулу на льду.';

  @override
  String get craftBeerBreweryInQingdao => 'Крафтовая пивоварня в Циндао';

  @override
  String get aLivelyCoastalTaproomWithWoodenBarr =>
      'Оживленный прибрежный паб с деревянными бочками, морским бризом и кранами со свежим пшеничным пивом.';

  @override
  String get sichuanCookingMasterclass => 'Мастер-класс по сычуаньской кухне';

  @override
  String get aVibrantOpenKitchenWithWoksBlazingC =>
      'Колоритная открытая кухня с пылающими воками, кипящим маслом с чили и свежим сычуаньским перцем.';

  @override
  String get highspeedRailSeatMixup => 'Путаница с местами в скоростном поезде';

  @override
  String get greatWallSunriseTrekInMutianyu =>
      'Встреча рассвета на Великой китайской стене на участке Мутяньюй';

  @override
  String get theAncientStoneRampartsOfTheGreatWa =>
      'Древние каменные зубцы Великой стены на рассвете в окружении окутанных туманом зеленых гор.';

  @override
  String get bambooRaftDriftOnGuilinLiRiver =>
      'Сплав на бамбуковом плоту по реке Лицзян в Гуйлине';

  @override
  String get glidingAlongEmeraldKarstWatersBetwe =>
      'Скольжение по изумрудным карстовым водам среди туманных известняковых пиков близ Яншо.';

  @override
  String get silkRoadCamelTrekInDunhuang =>
      'Караванная прогулка на верблюдах по Шелковому пути в Дуньхуане';

  @override
  String get theRollingGoldenSandDunesOfMingshaM =>
      'Волнистые золотые песчаные дюны горы Миншашань рядом с оазисом озера Полумесяца (Юэяцюань).';

  @override
  String get bookingACourtyardHomestayInDali =>
      'Бронирование традиционного отеля с внутренним двором в Дали';

  @override
  String get aSereneBaistyleBoutiqueCourtyardHot =>
      'Уютный бутик-отель с двориком в стиле народа бай с видом на озеро Эрхай в Юньнани.';

  @override
  String get potalaPalacePilgrimageInLhasa =>
      'Паломничество во дворец Потала в Лхасе';

  @override
  String get theMajesticSundrenchedStoneStepsOut =>
      'Величественные залитые солнцем каменные ступени дворца Потала и вращающиеся молитвенные барабаны.';

  @override
  String get aSubzeroWonderlandOfIlluminatedCrys =>
      'Зимняя сказка из сверкающих подсвеченных ледяных дворцов и гигантских снежных скульптур.';

  @override
  String get zhangjiajieAvatarMountainCableCar =>
      'Канатная дорога к парящим горам Аватара в Чжанцзяцзе';

  @override
  String get suspendedHighInAGlassCableCarSoarin =>
      'Полет высоко в стеклянной кабине канатной дороги над тысячами песчаниковых столбов-пиков.';

  @override
  String get gobiDesertStargazingCampInGansu =>
      'Лагерь для наблюдения за звездами в пустыне Гоби (Ганьсу)';

  @override
  String get aLuxuryYurtCampUnderACrystalclearMi =>
      'Роскошный глэмпинг в юртах под хрустально-чистым небом Млечного Пути в пустыне близ Цзяюйгуаня.';

  @override
  String get yangtzeRiverThreeGorgesCruise =>
      'Круиз по реке Янцзы через район Трех ущелий (Санься)';

  @override
  String get onTheSunDeckOfARiverCruiseShipPassi =>
      'На открытой палубе речного лайнера, проходящего через грандиозное ущелье Цюйтанся.';

  @override
  String get buyingAntiquesInBeijingPanjiayuan =>
      'Покупка антиквариата на рынке Паньцзяюань в Пекине';

  @override
  String get aHistoricPotteryKilnFilledWithDelic =>
      'Старинная гончарная печь, наполненная изящными фарфоровыми вазами-сырцами и кобальтовой глазурью.';

  @override
  String get suzhouSilkEmbroideryStudio =>
      'Мастерская традиционной шелковой вышивки в Сучжоу';

  @override
  String get aPeacefulCanalsideGardenStudioInSuz =>
      'Тихая мастерская в саду у каналов Сучжоу с тончайшими шелковыми нитями и деревянными пяльцами.';

  @override
  String get backstageAtATraditionalBeijingOpera =>
      'За кулисами традиционной Пекинской оперы среди ярких сценических костюмов, зеркал и массивных головных уборов.';

  @override
  String get traditionalChineseMedicineConsultat =>
      'Консультация врача традиционной китайской медицины (ТКМ)';

  @override
  String get morningTaiChiInTempleOfHeavenPark =>
      'Утренняя практика тайцзи в парке Храма Неба';

  @override
  String get beneathAncientCypressTreesAtDawnWit =>
      'Под кронами вековых кипарисов на рассвете под пение птиц, пока пожилые мастера синхронно выполняют формы тайцзи.';

  @override
  String get rentingAHanfuForAPhotoShoot =>
      'Аренда традиционного костюма ханьфу для фотосессии';

  @override
  String get aTraditionalCostumeBoutiqueNearTheW =>
      'Бутик традиционных нарядов у озера Сиху со стойками шелковых одеяний эпох Тан и Сун.';

  @override
  String get guqinAncientZitherInstrumentWorksho =>
      'Мастерская древней семиструнной цитры гуцинь';

  @override
  String get aQuietPinewoodStudioInHangzhouFille =>
      'Уютная мастерская из массива сосны в Ханчжоу с инструментами из выдержанной павловнии и шелковыми струнами.';

  @override
  String get shaanxiShadowPuppetTheater =>
      'Театр теневых кукол провинции Шэньси';

  @override
  String get behindAnIlluminatedWhiteSilkScreenW =>
      'За подсвеченным белым шелковым экраном, где оживают тонкие силуэты фигурок из полупрозрачной кожи.';

  @override
  String get chineseCalligraphyWorkshop =>
      'Мастер-класс по китайской каллиграфии';

  @override
  String get aTranquilStudioScentedWithPineSootI =>
      'Безмятежная студия с ароматом туши из сосновой сажи, свитками рисовой бумаги и тонким запахом чая.';

  @override
  String get adoptingACatAtAnAnimalShelter =>
      'Взять кошку из приюта для животных';

  @override
  String get aCozyPetRescueCenterInHangzhouWithE =>
      'Уютный приют для животных в Ханчжоу с игривыми спасенными котятами и чаем для гостей.';

  @override
  String get scriptMurderMysteryJubenshaGame =>
      'Детективная ролевая игра по сценарию (Цзюйбэньша / 剧本杀)';

  @override
  String get aThemedDetectiveLoungeInShanghaiWit =>
      'Тематический детективный клуб в Шанхае с игроками в костюмах при мерцании свечей.';

  @override
  String get vintageVinylRecordShopInShanghai =>
      'Магазин винтажного винила в Шанхае';

  @override
  String get aHiddenVinylStoreInAnOldLaneHousePa =>
      'Уютная виниловая лавка в старом переулке шикумэнь, полная пластинок с кантопопом 80-х и джазом.';

  @override
  String get ktvKaraokePartyWithFriends => 'Караоке-вечеринка в KTV с друзьями';

  @override
  String get joiningACityBikeCyclingClub =>
      'Вступление в клуб городского велоспорта';

  @override
  String get aGatheringOfCyclistsByTheRiverfront =>
      'Сбор велосипедистов на набережной перед вечерним заездом с видом на огни ночного города.';

  @override
  String get blindBoxToyTradingMeetup =>
      'Встреча коллекционеров для обмена фигурками из блайнд-боксов';

  @override
  String get aColorfulPopcultureToyStoreInChaoya =>
      'Яркий магазин дизайнерских игрушек в районе Чаоян с витринами и запечатанными коллекционными коробками.';

  @override
  String get droneSkylineVideographyAtTheBund =>
      'Аэросъемка панорамы набережной Вайтань с дрона';

  @override
  String get theBundPromenadeAtDuskOverlookingTh =>
      'Прогулка по набережной Вайтань в сумерках с видом на футуристические сияющие небоскребы Пудуна.';

  @override
  String get goldenRetrieverCafeInNanjing =>
      'Кафе с золотистыми ретриверами в Нанкине';

  @override
  String get aSunnyCheerfulPetCafeWithDozensOfFr =>
      'Солнечное дружелюбное дог-кафе, где гостей встречают десятки пушистых ласковых собак.';

  @override
  String get boulderingClimbingGymInChengdu =>
      'Скалодром для боулдеринга в Чэнду';

  @override
  String get aModernIndoorClimbingGymWithVibrant =>
      'Современный крытый скалодром с яркими трассами и динамичной музыкой.';

  @override
  String get aMassiveConventionHallFilledWithCol =>
      'Огромный выставочный комплекс с красочными игровыми стендами, фотозонами и косплеерами.';

  @override
  String get askingForDirectionsInABeijingHutong =>
      'Как спросить дорогу в пекинских хутунах';

  @override
  String get aMazeOfHistoricGreybrickAlleysWithB =>
      'Лабиринт старинных переулков из серого кирпича с велосипедами, внутренними двориками и гранатовыми деревьями.';

  @override
  String get buyingFreshFruitAtAWetMarket =>
      'Покупка свежих фруктов на традиционном рынке';

  @override
  String get aLivelyMorningNeighborhoodMarketWit =>
      'Оживленный утренний базар с прилавками, усыпанными свежими личи, манго и питахайей.';

  @override
  String get flowerMarketBouquetInKunming =>
      'Букет с цветочного рынка в Куньмине';

  @override
  String get theFamousDounanFlowerMarketSurround =>
      'Знаменитый цветочный рынок Доунань среди миллионов свежих роз, лилий и веток эвкалипта.';

  @override
  String get tailorAlterationsInAnOldLaneHouse =>
      'Подгонка одежды в мастерской старого переулка';

  @override
  String get aTraditionalTailorShopFilledWithSew =>
      'Традиционная швейная мастерская со швейными машинками, рулонами тканей и сантиметровыми лентами.';

  @override
  String get expressParcelLockerRetrieval =>
      'Получение посылки в постамате (Hive Box)';

  @override
  String get downstairsAtAResidentialApartmentGa =>
      'У входа в жилой комплекс, прямо у постамата Hive Box.';

  @override
  String get bicycleFlatTireRepairAtCampusGate =>
      'Ремонт проколотого колеса велосипеда у ворот кампуса';

  @override
  String get aSmallOutdoorRoadsideToolkitStandUn =>
      'Небольшой придорожный столик мастера по ремонту в тени раскидистого баньяна.';

  @override
  String get techCompanyProductDemo => 'Презентация продукта в IT-компании';

  @override
  String get aFuturisticTechConferenceBoothInShe =>
      'Футуристический выставочный стенд на технологической конференции в Шэньчжэне с демонстрацией ИИ-устройств.';

  @override
  String get ecommerceLivestreamStudio =>
      'Студия стриминга для онлайн-продаж (Live Commerce)';

  @override
  String get aHighenergyBroadcastStudioWithRingL =>
      'Динамичная студия прямых эфиров с кольцевым светом, витринами товаров и мониторами комментариев.';

  @override
  String get yiwuInternationalTradeMarket =>
      'Международный оптовый рынок в Иу (Yiwu)';

  @override
  String get aVastMultistoryCommercialExhibition =>
      'Колоссальный многоэтажный оптовый торговый комплекс с миллионами товаров и ремесленных изделий.';

  @override
  String get universityCampusExchangeProgram =>
      'Программа студенческого обмена в университетском кампусе';

  @override
  String get aSunnyLawnOutsideTheUniversityLibra =>
      'Солнечная лужайка перед университетской библиотекой со студентами с молочным чаем в руках.';

  @override
  String get pleaseEnterAScenarioTopic => 'Пожалуйста, введите тему сценария.';

  @override
  String get nameTitle => 'Имя (обращение)';

  @override
  String get aiCharacter => 'ИИ-персонаж';

  @override
  String get helloWelcomeHereWhatShallWeChatAbou =>
      'Здравствуйте! Добро пожаловать. О чем поговорим сегодня?';

  @override
  String get greetYourConversationPartner => 'Поприветствуйте собеседника';

  @override
  String get askAQuestionInChinese => 'Задайте вопрос на китайском языке';

  @override
  String get pinyinWithToneMarks => 'Пиньинь со знаками тонов';

  @override
  String get goal1InEnglish => 'Цель 1 (на русском)';

  @override
  String get goal2InEnglish => 'Цель 2 (на русском)';

  @override
  String get goal3InEnglish => 'Цель 3 (на русском)';

  @override
  String get beginner => 'Начальный';

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
  String get tapToReview => 'Нажмите для разбора';

  @override
  String get overallScore => 'Общий балл';

  @override
  String get toneAccuracy => 'Точность тонов';

  @override
  String get fluency => 'Беглость речи';

  @override
  String get report => 'Отчет';

  @override
  String get goodPronunciationButCanBeBetter =>
      'Хорошее произношение, но можно сделать еще лучше!';

  @override
  String get didYouMeanToSay => 'Вы имели в виду...?';

  @override
  String get greatKeepTrying => 'Отлично! Продолжайте тренироваться!';

  @override
  String get completeness => 'Полнота';

  @override
  String get targetTone => 'Ожидаемый тон';

  @override
  String get k4toneComparisonTapToListen =>
      'Сравнение 4 тонов (нажмите, чтобы прослушать):';

  @override
  String get youSpokeMatch => 'Вы сказали (Верно!)';

  @override
  String get youSpoke => 'Вы сказали';

  @override
  String get yourPrimaryCollectionOfCharacters =>
      'Ваша основная коллекция иероглифов.';

  @override
  String get deckNotFound => 'Колода не найдена';

  @override
  String get cannotDeleteTheDefaultDeck => 'Нельзя удалить основную колоду';

  @override
  String get hsk4UpperIntermediate1 => 'HSK 4: Средне-продвинутый';

  @override
  String get theFirst150CharactersToStartYourJou =>
      'Первые 150 базовых иероглифов для старта обучения.';

  @override
  String get buildYourVocabularyTo300EssentialWo =>
      'Расширьте словарный запас до 300 ключевых слов.';

  @override
  String get masterConversationalFluencyWith600W =>
      'Освойте разговорную речь с запасом в 600 слов.';

  @override
  String get readTextsAndConverseFluentlyWith120 =>
      'Читайте тексты и свободно общайтесь, зная 1200 слов.';

  @override
  String get readNewspapersAndWatchMoviesWith250 =>
      'Читайте статьи и смотрите фильмы с запасом в 2500 слов.';

  @override
  String get databaseBoxNotOpen => 'База данных не открыта';

  @override
  String get hsk1DataFileIsEmpty => 'Файл данных HSK 1 пуст';

  @override
  String get gold => 'Золото';

  @override
  String get globalDictionaryNotInitialized =>
      'Глобальный словарь не инициализирован';

  @override
  String get reading => 'Чтение';

  @override
  String get recall => 'Воспроизведение';

  @override
  String get speaking => 'Говорение';

  @override
  String get listening1 => 'Аудирование';

  @override
  String get practiceStrokeOrderWithVisualGuides =>
      'Тренируйте порядок черт с помощью наглядных подсказок.';

  @override
  String get seeTheCharacterRecallThePinyinAndMe =>
      'Посмотрите на иероглиф, вспомните пиньинь и значение.';

  @override
  String get seeTheMeaningDrawTheCharacterFromMe =>
      'Посмотрите на перевод, напишите иероглиф по памяти.';

  @override
  String get readOutLoudToTestYourPronunciationT =>
      'Прочитайте вслух, чтобы проверить тона и произношение.';

  @override
  String get listenToTheAudioAndIdentifyTheChara =>
      'Прослушайте аудио и выберите правильный иероглиф.';

  @override
  String get contract => 'Контракт интерфейса';

  @override
  String get whoeverImplementsMeMustBeAbleToDoTh =>
      'Любой класс, реализующий этот интерфейс, ДОЛЖЕН поддерживать данные методы.';

  @override
  String get koreFenrirCharonAoedePuckOrLocal =>
      'Kore, Fenrir, Charon, Aoede, Puck или локальный голос';

  @override
  String get manageDecks => 'Управление колодами';

  @override
  String get weRanIntoTroubleLoadingTheLibraryPl =>
      'Не удалось загрузить библиотеку. Пожалуйста, попробуйте снова.';

  @override
  String get noCharactersInLexicon1 => 'В словаре нет иероглифов';

  @override
  String get masterTheBuildingBlocks => 'Освойте базовые элементы';

  @override
  String get other => 'Другое';

  @override
  String get required => 'Обязательно';

  @override
  String get library1 => 'Библиотека';

  @override
  String get youAreAPremiumMember => 'У вас статус Premium';

  @override
  String get createAccountToSyncProgress =>
      'Создайте аккаунт для синхронизации прогресса';

  @override
  String get signOut => 'Выйти';

  @override
  String get account => 'Аккаунт';

  @override
  String get guestScholar => 'Гость-исследователь';

  @override
  String get localAccount => 'Локальный аккаунт';

  @override
  String get unknownRadical => 'Неизвестный радикал';

  @override
  String get followTheGuideStroke => 'Ведите по направляющей черте';

  @override
  String get strokeAnimationSpeed => 'Скорость анимации написания';

  @override
  String get notifications => 'Уведомления';

  @override
  String get deutsch => 'Немецкий';

  @override
  String get bahasaIndonesia => 'Индонезийский';

  @override
  String get italiano => 'Итальянский';

  @override
  String get today1d2d3d4d5d6d => 'Сегодня, 1д, 2д, 3д, 4д, 5д, 6д';

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
  String get idiomsChengyu => 'Идиомы (чэнъюи)';

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
      'Приведите еще два примера использования этого слова?';

  @override
  String get whatAreSomeSimilarWordsAndHowDoThey =>
      'Какие есть синонимы и в чем разница между ними?';

  @override
  String get isThisWordUsedInSpokenOrWrittenChin =>
      'Это слово чаще используется в разговорной или письменной речи?';

  @override
  String get areThereOtherWaysToTranslateThisWor =>
      'Есть ли другие варианты перевода этого слова?';

  @override
  String get whatAreCommonWordsThatGoTogetherWit =>
      'С какими словами чаще всего сочетается это слово?';

  @override
  String get whatAreCommonMistakesLearnersMakeWi =>
      'Какие типичные ошибки студенты допускают в этом слове?';

  @override
  String get emptyResponse => 'Пустой ответ';

  @override
  String get whatIsTheOracleBoneScriptOriginOfTh =>
      'Каково происхождение этого иероглифа в надписях на гадательных костях цзягувэнь?';

  @override
  String get howDidTheAncientFormOfThisCharacter =>
      'Как древняя форма этого иероглифа эволюционировала со временем?';

  @override
  String get giveMe3CommonWordsThatContainThisCh =>
      'Назовите 3 распространенных слова, содержащих этот иероглиф.';

  @override
  String get whatOtherCharactersShareTheSameRadi =>
      'В каких еще иероглифах используется этот же радикал?';

  @override
  String get isThereAChineseProverbOrSayingFeatu =>
      'Есть ли китайская пословица или чэнъюй с этим иероглифом?';

  @override
  String get explainTheStrokeOrderRulesForThisCh =>
      'Объясните правила порядка черт для этого иероглифа.';

  @override
  String get giveMeOneCalligraphyTipForWritingTh =>
      'Дайте совет по красивому каллиграфическому написанию этого иероглифа.';

  @override
  String get isThereAnythingTrickyAboutUsingThis =>
      'Есть ли какие-то грамматические тонкости или подводные камни?';

  @override
  String get whatWordsAreCommonlyConfusedWithThi =>
      'С какими словами чаще всего путают это слово и почему?';

  @override
  String get doesThisCharacterCarryCulturalSymbo =>
      'Имеет ли этот иероглиф особый культурный символизм в Китае?';

  @override
  String get isThisCharacterCommonlySeenInChines =>
      'Часто ли этот иероглиф встречается в фильмах, песнях или современных текстах?';

  @override
  String get whatDoesTheRadicalOfThisCharacterMe =>
      'Какое смысловое значение несет радикал этого иероглифа?';

  @override
  String get breakDownEveryComponentAndItsMeanin =>
      'Разберите иероглиф по составным частям и объясните значение каждой.';

  @override
  String get giveMeATrickToRememberTheCorrectTon =>
      'Подскажите мнемонический прием, чтобы легко запомнить правильный тон этого иероглифа.';

  @override
  String get areThereCommonHomophonesThatAreOfte =>
      'Есть ли распространенные омофоны, с которыми его часто путают?';

  @override
  String get quotaExceeded => 'Лимит запросов исчерпан';

  @override
  String get mustProvideEitherCardOrCards =>
      'Необходимо указать одну или несколько карточек';

  @override
  String get deckSettings => 'Настройки колоды';

  @override
  String get saveSettings => 'Сохранить настройки';

  @override
  String get sealRed => 'Красная печать';

  @override
  String get sealScript => 'Стиль печатей (чжуаньшу)';

  @override
  String get startYourStreak => 'НАЧАТЬ СЕРИЮ ЗАНЯТИЙ';

  @override
  String get traditionalCharacter => 'Традиционный иероглиф';

  @override
  String get inQueue => 'В очереди';

  @override
  String get tapToListenAgain => 'Нажмите, чтобы прослушать снова';

  @override
  String get contextClue => 'Подсказка из контекста';

  @override
  String get microphonePermissionRequired1 =>
      'Требуется разрешение на использование микрофона.';

  @override
  String get recordingFailedNoFile => 'Ошибка записи (аудиофайл не создан).';

  @override
  String get holdToSpeakOptional => 'Удерживайте для записи (необязательно)';

  @override
  String get microphonePermissionDeniedEnableItI =>
      'Доступ к микрофону отклонен. Включите его в Настройках для работы со Студией Shadowing.';

  @override
  String get sessionSummary => 'Итоги сессии';

  @override
  String get hereAreTheCharactersYouStruggledWit =>
      'Иероглифы, вызвавшие наибольшие затруднения:';

  @override
  String get applySessionGradesToSpacedRepetitio =>
      'Применить результаты сессии к интервальным повторениям (режим говорения)';

  @override
  String get masterYourMandarinPronunciationnbyM =>
      'Отточите произношение в китайском,\nповторяя за носителями в реальном времени.';

  @override
  String get aiIsGradingYourPronunciation =>
      'ИИ анализирует ваше произношение...';

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
      'Ошибка записи. Пожалуйста, повторите попытку.';

  @override
  String get noRecordingCapturedPleaseTryAgain =>
      'Голос не записан. Пожалуйста, попробуйте снова.';

  @override
  String get recordedAudioIsEmptyPleaseTryAgainA =>
      'Записанный аудиофайл пуст. Попробуйте снова и говорите четче.';

  @override
  String get azureSpeechApiKeysAreMissing1 =>
      'Отсутствуют ключи Azure Speech API';

  @override
  String get azureError401 => 'Ошибка Azure 401';

  @override
  String get azureAuthenticationFailedCheckYourS =>
      'Ошибка аутентификации Azure. Проверьте ключ Speech API и регион в файле .env';

  @override
  String get azureError429 => 'Ошибка Azure 429';

  @override
  String get azureQuotaExceededTryAgainLater =>
      'Квота Azure исчерпана. Повторите попытку позже.';

  @override
  String get azureGradingTimedOutCheckYourIntern =>
      'Время оценки Azure истекло. Проверьте интернет-соединение.';

  @override
  String get recognitionFailedNull => 'Ошибка распознавания: null';

  @override
  String get couldNotHearYouClearlyPleaseTryAgai =>
      'Не удалось четко расслышать. Пожалуйста, повторите попытку.';

  @override
  String get singlePhrasePractice => 'Отработка одной фразы';

  @override
  String get failedToGeneratePhrase => 'Не удалось сгенерировать фразу';

  @override
  String get omitted => 'Пропущено';

  @override
  String get partial => 'Частично';

  @override
  String get mispronounced => 'Неверно произнесено';

  @override
  String get startSession1 => 'Начать сессию';

  @override
  String get chinese => 'Китайский';

  @override
  String get paused => 'Пауза';

  @override
  String get translationFailed => 'Ошибка перевода';

  @override
  String get engagingMacroeconomicAndBusinessBre =>
      'Увлекательный макроэкономический и бизнес-анализ в формате живого сторителлинга.';

  @override
  String get exploresWorldEconomiesBankingHistor =>
      'Исследует мировую экономику, историю банковского дела и динамику глобальных рынков.';

  @override
  String get clearArticulateMandarinPerfectForIn =>
      'Четкий и образцовый китайский язык, идеальный для среднего и продвинутого уровней.';

  @override
  String get chefWang => 'Шеф-повар Ван Ган';

  @override
  String get masterSichuanCulinaryTechniquesTaug =>
      'Освойте кулинарные техники Сычуани под руководством профессионального шеф-повара.';

  @override
  String get stepbystepAuthenticChineseRecipesWi =>
      'Пошаговые аутентичные китайские рецепты: от владения воком до тонкостей нарезки.';

  @override
  String get conciseCulinaryVocabularyAndClearIn =>
      'Точная кулинарная лексика и понятные инструкции на естественном китайском языке.';

  @override
  String get cinematographyCuttingedgeCameraTech =>
      'Кинематография, передовые технологии камер и глубокий разбор цифровых медиа.';

  @override
  String get highproductionDocumentaryStyleExplo =>
      'Высокобюджетный документальный стиль, исследующий видеопроизводство и инновации ИИ.';

  @override
  String get richTechnicalMandarinWithCrystalcle =>
      'Богатый технический китайский язык с кристально чистой дикцией и титрами.';

  @override
  String get indepthInvestigativeJournalismAndCu =>
      'Глубокая расследовательская журналистика и аналитика актуальных событий.';

  @override
  String get criticalPerspectivesOnSocialPhenome =>
      'Критический взгляд на социальные явления, мировые новости и историю.';

  @override
  String get formalInvestigativeDiscourseIdealFo =>
      'Формальный аналитический стиль речи, идеальный для продвинутой практики аудирования.';

  @override
  String get bitesizedAnimatedScienceDocumentari =>
      'Короткие анимационные научно-популярные ролики, отвечающие на повседневные вопросы.';

  @override
  String get exploresPhysicsBiologyAndEverydayCu =>
      'Наглядное объяснение физики, биологии и любопытных явлений через инфографику.';

  @override
  String get standardBeijingMandarinWithWellpace =>
      'Стандартный путунхуа с размеренным темпом речи и четкими субтитрами.';

  @override
  String get heartwarmingStreetFoodAdventuresAnd =>
      'Душевные путешествия по стритфуд-культуре и искренние разговоры с жителями Китая.';

  @override
  String get exploresRegionalHumanStoriesFamilyT =>
      'Исследует судьбы людей в регионах, семейные традиции и местные гастрономические шедевры.';

  @override
  String get naturalConversationalMandarinWithDa =>
      'Живой разговорный китайский с современной разговорной лексикой и душевной интонацией.';

  @override
  String get humorousAndHonestConsumerElectronic =>
      'Остроумные и честные обзоры потребительской электроники на основе реального опыта.';

  @override
  String get testingSmartphonesSmartHomeGadgetsA =>
      'Тестирование смартфонов, умного дома и гаджетов для комфортной жизни.';

  @override
  String get relaxedHumorousConversationalDialog =>
      'Непринужденный и остроумный разговорный диалог с современным сленгом.';

  @override
  String get seanKitchen => 'Кухня Шона';

  @override
  String get deliciousHomecookedChineseDishesAnd =>
      'Вкусные домашние блюда китайской кухни и воссоздание популярных уличных закусок.';

  @override
  String get easytofollowKitchenTipsForCookingAu =>
      'Простые кулинарные секреты для приготовления аутентичной азиатской еды дома.';

  @override
  String get warmInvitingCommentaryWithPractical =>
      'Теплые и понятные комментарии с полезной кулинарной лексикой.';

  @override
  String get chineseChannel => 'Канал о китайском языке';

  @override
  String get structuredChineseLanguageLessonsAnd =>
      'Структурированные уроки китайского языка и культурные гиды.';

  @override
  String get grammarPointsHskVocabularyBuildingA =>
      'Грамматические разборы, набор лексики HSK и типовые разговорные модели.';

  @override
  String get clearEducationalPacingTailoredSpeci =>
      'Четкий темп подачи материала, адаптированный специально для изучающих китайский.';

  @override
  String get oneInABillion => 'Один на миллиард';

  @override
  String get intimatePortraitsAndStoriesOfUnique =>
      'Глубокие портреты и истории уникальных людей современного Китая.';

  @override
  String get exploresDiverseLifeChoicesYouthCult =>
      'Исследует жизненные пути, молодежную культуру и перемены в обществе.';

  @override
  String get deepNarrativeStorytellingWithRichVo =>
      'Вдумчивое повествование с богатым словарным запасом и подлинными голосами героев.';

  @override
  String get vickySoup => 'Влоги Вики (Vicky Soup)';

  @override
  String get aestheticLifestyleVlogsFashionStyli =>
      'Эстетичные лайфстайл-влоги, стильные образы и повседневная рутина.';

  @override
  String get travelDiariesAndCozyLifeMomentsDocu =>
      'Путевые заметки и уютные моменты жизни, запечатленные с кинематографичной теплотой.';

  @override
  String get naturalCasualMandarinSpokenAtAComfo =>
      'Естественный разговорный китайский в комфортном и выразительном темпе.';

  @override
  String get tededMandarin => 'TED-Ed на китайском';

  @override
  String get highqualityAnimatedEducationalLesso =>
      'Высококачественные анимационные уроки по науке, философии и истории.';

  @override
  String get thoughtprovokingRiddlesClassicLiter =>
      'Увлекательные загадки, классическая литература и тайны психологии.';

  @override
  String get impeccableVoiceoverMandarinWithSync =>
      'Безупречная дикторская озвучка на путунхуа с синхронными двуязычными субтитрами.';

  @override
  String get channel => 'Канал';

  @override
  String get curatedCulturalDocumentariesAndChin =>
      'Отобранные культурные документальные фильмы и обзоры стиля жизни в Китае.';

  @override
  String get exploringTraditionalArtsHeritageCra =>
      'Знакомство с традиционными искусствами, старинными ремеслами и современными трендами.';

  @override
  String get highQualityAudioWithSynchronizedChi =>
      'Качественное аудио с синхронизированными субтитрами на китайском языке.';

  @override
  String get interestingStoriesAndCreativeVideoP =>
      'Увлекательные истории и креативные видеопроекты из китайского интернета.';

  @override
  String get engagingInterviewsStorytellingAndVi =>
      'Захватывающие интервью, истории из жизни и эффектный видеоряд.';

  @override
  String get greatListeningMaterialWithStandardP =>
      'Отличный материал для аудирования с эталонным нормативным произношением.';

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
  String get intermediateReading => 'Средний уровень чтения';

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
  String get gradedReader => 'Адаптированные книги';

  @override
  String get ucj10r97lkwgdtqbt6xzv8gLearnMandari =>
      'Учите китайский с TaiwanPlus';

  @override
  String get ucsxriuqkzzmaqklq0n9xfvwEverydayChi => 'Китайский на каждый день';

  @override
  String get graceMandarinChinese => 'Grace Mandarin Chinese';

  @override
  String get ucolbhvvl5dcjlmzeqbuu1vwTingdailyLi => 'Ting: жизнь в Китае';

  @override
  String get xinxin => 'Синьсинь';

  @override
  String get sweetFamilyDailyLife => 'Уютные семейные будни';

  @override
  String get chinsunDailyLife => 'Будни Чин-Сун';

  @override
  String get tasteChina => 'Вкус Китая';

  @override
  String get dawenFoodQuest => 'Гастрономический квест Давэня';

  @override
  String get chinaTravelWithCangbao => 'Путешествия по Китаю с Цанбао';

  @override
  String get alinFoodWalk => 'Гастро-прогулка с Алин';

  @override
  String get videoOfTheDay => 'ВИДЕО ДНЯ';

  @override
  String get noValidVideoFound => 'Подходящее видео не найдено.';

  @override
  String get listeningPractice => 'ПРАКТИКА АУДИРОВАНИЯ';

  @override
  String get socialSkills => 'НАВЫКИ ОБЩЕНИЯ';

  @override
  String get culturalContext => 'КУЛЬТУРНЫЙ КОНТЕКСТ';

  @override
  String get realLife => 'ЖИВАЯ РЕЧЬ';

  @override
  String get realWorld => 'РЕАЛЬНЫЙ МИР';

  @override
  String get articleOfTheDay => 'СТАТЬЯ ДНЯ';

  @override
  String get failedToLoadOrParseRssFeed =>
      'Не удалось загрузить или обработать RSS-ленту.';

  @override
  String get drama => 'Дорама / Сериал';

  @override
  String get youkugetAppNow => 'YOUKU: Скачайте приложение';

  @override
  String get romanceTrailer => 'Романтика / Трейлер';

  @override
  String get romance => 'Мелодрама / Романтика';

  @override
  String get action => 'Боевик / Экшен';

  @override
  String get mystery => 'Детектив / Тайна';

  @override
  String get historical => 'Исторический / Костюмированный';

  @override
  String get historicalAction => 'Исторический / Боевик';

  @override
  String get historicalRomance => 'Исторический / Романтика';

  @override
  String get anYouth => 'Молодость';

  @override
  String get historicalSliceOfLife => 'Исторический / Повседневность';

  @override
  String get historicalHighlight => 'Исторический / Лучшие моменты';

  @override
  String get youkuEnglishgetAppNow => 'YOUKU English: Скачайте приложение';

  @override
  String get theDouble => 'Двойник (The Double)';

  @override
  String get updatesByOshin => 'Обновления от Oshin';

  @override
  String get backFromTheBrink => 'Защити сердце (Back From the Brink)';

  @override
  String get fallingIntoYourSmile =>
      'Влюбиться в твою улыбку (Falling Into Your Smile)';

  @override
  String get everyoneLovesMe => 'Все меня любят (Everyone Loves Me)';

  @override
  String get tillTheEndOfTheMoon =>
      'Светлый пепел луны (Till The End Of The Moon)';

  @override
  String get theBestDayOfMyLife =>
      'Лучший день в моей жизни (The Best Day of My Life)';

  @override
  String get gikkiChineseDrama => 'Китайские дорамы GIKKI';

  @override
  String get dashingYouth => 'Юноша на белом коне (Dashing Youth)';

  @override
  String get rebornChineseDramaEngSub => 'Дорама «Перерождение» с субтитрами';

  @override
  String get ijenwaBenita => 'Ijenwa Benita';

  @override
  String get whenIFlyTowardsYou =>
      'Когда я лечу к тебе (When I Fly Towards You)';

  @override
  String get mztvExclusiveChineseDrama => 'Эксклюзивная китайская дорама MZTV';

  @override
  String get theStarryLove => 'Любовь во время звездопада (The Starry Love)';

  @override
  String get comedy => 'Комедия';

  @override
  String get backFromTheBrink1 => 'Защити сердце';

  @override
  String get dashingYouth1 => 'Юноша на белом коне';

  @override
  String get beReborn => 'Перерождение';

  @override
  String get beautyStrategy => 'Стратегия красоты';

  @override
  String get myDivineEmissary => 'Мой небесный посланник';

  @override
  String get theHope => 'Юность и надежда (The Hope)';

  @override
  String get ep16In => 'Серия 16';

  @override
  String get everyoneLovesMe1 => 'Все меня любят';

  @override
  String get fallingIntoYourSmile1 => 'Влюбиться в твою улыбку';

  @override
  String get hiddenLove => 'Скрытая любовь (Hidden Love)';

  @override
  String get loveBetweenFairyAndDevil => 'Разлука Орхидеи и Повелителя демонов';

  @override
  String get loveLikeTheGalaxy =>
      'Любовь подобна звездам (Love Like the Galaxy)';

  @override
  String get membersPremiere => 'Премьера для подписчиков';

  @override
  String get moonlight => 'Лунный свет (Moonlight)';

  @override
  String get myJourneyToYou => 'Мой путь к тебе (My Journey to You)';

  @override
  String get mysteriousLotusCasebook =>
      'Лотосовый терем (Mysterious Lotus Casebook)';

  @override
  String get rebornChineseDramaEngSub1 => 'Дорама «Перерождение»';

  @override
  String get reborn => 'Перерождение';

  @override
  String get theBestDayOfMyLife1 => 'Лучший день в моей жизни';

  @override
  String get theDouble1 => 'Двойник';

  @override
  String get theLongBallad => 'Баллада о Чанъань (The Long Ballad)';

  @override
  String get theStarryLove1 => 'Любовь во время звездопада';

  @override
  String get theUntamed => 'Неукротимый: Повелитель Чэньцин (The Untamed)';

  @override
  String get tillTheEndOfTheMoon1 => 'Светлый пепел луны';

  @override
  String get whenIFlyTowardsYou1 => 'Когда я лечу к тебе';

  @override
  String get wordOfHonor => 'Далекие странники (Word of Honor)';

  @override
  String get blossom => 'Цветение (Blossoms Shanghai)';

  @override
  String get gemini => 'Gemini';

  @override
  String get generationToGeneration => 'Из поколения в поколение';

  @override
  String get brocadeOdyssey => 'Одиссея парчи (Brocade Odyssey)';

  @override
  String get circleOfLove => 'Круговорот любви';

  @override
  String get dawnIsBreaking => 'Перед рассветом';

  @override
  String get firstRomance => 'Первая любовь';

  @override
  String get loveInTheClouds => 'Любовь в облаках';

  @override
  String get secondChanceRomance => 'Второй шанс на любовь';

  @override
  String get mrBad => 'Мой злодей (Mr. Bad)';

  @override
  String get pursuitOfJade => 'В погоне за нефритом';

  @override
  String get fatedHearts => 'Судьбоносные сердца';

  @override
  String get roadHome => 'Дорога домой (Road Home)';

  @override
  String get myDearGuardian => 'Мой дорогой защитник (My Dear Guardian)';

  @override
  String get brightEyesInTheDark =>
      'Яркие глаза во тьме (Bright Eyes in the Dark)';

  @override
  String get theIngeniousOne => 'Гений (The Ingenious One)';

  @override
  String get herPhoenixMajesty => 'Ее Величество Феникс';

  @override
  String get dreamsNeverEnd => 'Мечты не угасают';

  @override
  String get theUltimateVowUnknownToYou => 'Тайная клятва';

  @override
  String get the300LoyalGhosts => '300 верных духов';

  @override
  String get homelandGuardian => 'Хранитель родины';

  @override
  String get loveIsAlwaysOnline => 'Любовь всегда в сети';

  @override
  String get thePrincessDecree => 'Указ принцессы';

  @override
  String get aVowInTheDark => 'Клятва во тьме';

  @override
  String get aGirlLikeMe => 'Такая девушка, как я';

  @override
  String get iAmNobody => 'Я никто (I Am Nobody)';

  @override
  String get myMamaGo => 'Мама, вперед!';

  @override
  String get myWesternRegionPrincess => 'Моя принцесса Западных земель';

  @override
  String get aFlowerOnTheContinent => 'Цветок континента';

  @override
  String get thePrincess => 'Принцесса';

  @override
  String get sweetLoveVersion => 'Версия: Нежная любовь';

  @override
  String get hilariousFamily2 => 'Веселая семейка 2';

  @override
  String get guYuanMountainHasASchool => 'Школа на горе Гуюань';

  @override
  String get foreverYoung => 'Вечно молодые';

  @override
  String get theHiddenHeirYeChen => 'Тайный наследник Е Чэнь';

  @override
  String get extraordinary => 'Необыкновенный путь';

  @override
  String get sideStoryOfFoxVolant => 'Хроники Летящего Лиса (Fox Volant)';

  @override
  String get loveOfTheDivineTree => 'Любовь священного древа';

  @override
  String get rebirth => 'Возрождение';

  @override
  String get moonlitReunion => 'Воссоединение при луне';

  @override
  String get videoCountsCannotBeNegative =>
      'Количество видео не может быть отрицательным.';

  @override
  String get publicDomainClassic => 'Классика в общественном достоянии';

  @override
  String get idioms => 'Чэнъюи и идиомы';

  @override
  String get news => 'Новости';

  @override
  String get fairyTales => 'Сказки и притчи';

  @override
  String get hereIsAFascinatingCulturalExplanati =>
      'Увлекательное культурно-историческое пояснение:';

  @override
  String get videoFetchTimedOut => 'Время ожидания загрузки видео истекло';

  @override
  String get aboutChannel => 'О КАНАЛЕ';

  @override
  String get noVideosFound => 'Видео не найдены';

  @override
  String get failedToLoadVideos => 'Не удалось загрузить видео';

  @override
  String get highqualityCuratedMandarinContentWi =>
      'Качественный китайский контент с живой лексикой.';

  @override
  String get authenticSpokenChineseAcrossRealwor =>
      'Аутентичная разговорная речь на самые разные актуальные темы.';

  @override
  String get engagingVideoMaterialWithInteractiv =>
      'Интерактивные видеоматериалы с синхронизированными субтитрами.';

  @override
  String get watchVideo => 'Смотреть видео';

  @override
  String get culturalInsight => 'Культурный инсайт';

  @override
  String get aiIsAnalyzingCulturalContext =>
      'ИИ анализирует культурный контекст...';

  @override
  String get diveIntoFullContent => 'Смотреть материал полностью';

  @override
  String get savedArticles => 'Сохраненные статьи';

  @override
  String get liveOverlay => 'ЖИВОЙ ОВЕРЛЕЙ';

  @override
  String get webExplorer => 'ВЕБ-БРАУЗЕР';

  @override
  String get browseAnyChineseWebsiteWithRealtime =>
      'Читайте любые китайские сайты с мгновенным словарем по нажатию, пиньинем и переводом.';

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
      'Видео не найдены. Попробуйте изменить поисковый запрос.';

  @override
  String get searching => 'Поиск...';

  @override
  String get noShowsFound => 'Передачи не найдены';

  @override
  String get bookmarked => 'В закладках';

  @override
  String get trailer1 => 'Трейлер';

  @override
  String get highlight1 => 'Фрагмент';

  @override
  String get noCaptionsAvailable => 'Субтитры недоступны';

  @override
  String get fetchingSubtitles => 'Загрузка субтитров...';

  @override
  String get generatingAiBriefing => 'Генерация ИИ-конспекта...';

  @override
  String get noClosedCaptionsCcFoundForThisVideo =>
      'Для этого видео не найдены цифровые субтитры (CC).';

  @override
  String get videosWithHardcodedOrBurnedinSubtit =>
      'Видео с вшитыми в картинку субтитрами не содержат текстовых дорожек на YouTube.';

  @override
  String get translatingSubtitles => 'Перевод субтитров...';

  @override
  String get processingYourPronunciation => 'Обработка вашего произношения...';

  @override
  String get couldntIdentifyLine => 'Не удалось распознать реплику.';

  @override
  String get listeningSpeakNow => 'Слушаю... говорите.';

  @override
  String get thisVideoDoesNotHaveADigitalClosedC =>
      'У этого видео нет цифровой дорожки субтитров (CC) на YouTube.';

  @override
  String get perfect1 => 'Идеально';

  @override
  String get thisVideoHasBeenRemovedOrIsNoLonger =>
      'Это видео было удалено или больше недоступно.';

  @override
  String get thisVideoCannotBePlayedInTheAppYouC =>
      'Это видео нельзя воспроизвести в приложении. Вы можете открыть его на YouTube.';

  @override
  String get yourDeviceCannotPlayThisVideoPlease =>
      'Ваше устройство не поддерживает воспроизведение этого видео. Попробуйте другое.';

  @override
  String get invalidVideoReferencePleaseTryAgain =>
      'Некорректная ссылка на видео. Попробуйте еще раз.';

  @override
  String get unableToLoadThisVideoPleaseTryAnoth =>
      'Не удалось загрузить видео. Попробуйте другое.';

  @override
  String get startReading => 'Начать чтение';

  @override
  String get analyzingCulturalContext => 'Анализ культурного контекста...';

  @override
  String get failedToLoadCulturalInsight =>
      'Не удалось загрузить культурную справку.';

  @override
  String get historicalContext => 'Исторический контекст';

  @override
  String get culturalSignificance => 'Культурное значение';

  @override
  String get authorBackground => 'Биография автора';

  @override
  String get k80CompleteClassicNovelsWorldEpics =>
      'Более 80 полных классических романов и мировых эпосов';

  @override
  String get storyOfTheDay => 'ИСТОРИЯ ДНЯ';

  @override
  String get tangDynasty => 'Династия Тан';

  @override
  String get poetryClassicalVerse => 'Классическая поэзия и стихи';

  @override
  String get allHsk => 'Все уровни HSK';

  @override
  String get allStories => 'Все истории';

  @override
  String get keyWords => 'Ключевые слова';

  @override
  String get openOriginalWebsite => 'Открыть первоисточник';

  @override
  String get aiReadingTools => 'Инструменты для чтения с ИИ';

  @override
  String get enhanceYourReadingWithAipoweredTool =>
      'Улучшайте навыки чтения с помощью умных инструментов ИИ';

  @override
  String get chooseTheTargetDifficultyForSimplif =>
      'Выберите целевой уровень сложности для адаптации текста';

  @override
  String get chooseDifficultyForSimplification =>
      'Выберите сложность адаптации';

  @override
  String get extractAllUnknownWordsToANewFlashca =>
      'Извлечь все незнакомые слова в новую колоду карточек';

  @override
  String get length => 'Объем';

  @override
  String get m1554846a550010707 => 'M15.54 8.46a5 5 0 0 1 0 7.07';

  @override
  String get m1907493a101000101414 => 'M19.07 4.93a10 10 0 0 1 0 14.14';

  @override
  String get webExtraction => 'Извлечение текста с веб-страницы';

  @override
  String get aiTools => 'Инструменты ИИ';

  @override
  String get stop => 'Остановить';

  @override
  String get keepPracticing1 => 'Продолжайте тренироваться';

  @override
  String get aiPrepRoom => 'Подготовительная комната ИИ';

  @override
  String get lessonSummary => 'ИТОГИ УРОКА';

  @override
  String get unlockSinosparkPremium => 'Разблокировать SinoSpark Premium';

  @override
  String get monthYear => 'Месяц / Год';

  @override
  String get enableNotifications => 'Включить уведомления';

  @override
  String get notificationsConfigured => 'Уведомления настроены';

  @override
  String get neverMissAStroke2 => 'Ни одной черты мимо';

  @override
  String get yourDailyDropAndStreakAlertsArePrim =>
      'Ваши ежедневные порции и напоминания о серии занятий настроены.';

  @override
  String get stayConsistentWithDailyRitualDropsA =>
      'Сохраняйте регулярность благодаря ежедневным порциям и своевременным напоминаниям.';

  @override
  String get aNewWordAndStoryWaitingForYourDaily =>
      'Новое слово и история уже ждут вас в ежедневном уроке.';

  @override
  String get gentlePromptsBeforeCharactersFadeFr =>
      'Бережные напоминания как раз перед тем, как иероглиф сотрется из памяти.';

  @override
  String get receiveAReminder2DaysBeforeYourFree =>
      'Получите уведомление за 2 дня до окончания бесплатного пробного периода.';

  @override
  String get yourPathTonchineseFluency => 'Ваш путь к\nсвободному китайскому';

  @override
  String get answer3QuickQuestionsSoOurAiCanCraf =>
      'Ответьте на 3 быстрых вопроса, чтобы наш ИИ составил\nучебный план под ваш ритм жизни.';

  @override
  String get whatIsYourLevelnwithChinese =>
      'Какой у вас уровень\nкитайского языка?';

  @override
  String get chooseThePathThatFitsYourDepth =>
      'Выберите программу, соответствующую вашей подготовке.';

  @override
  String get whatDrivesYourStudy => 'Что вдохновляет вас изучать китайский?';

  @override
  String get purposeFuelsTheBrush => 'Цель придает уверенность кисти';

  @override
  String get setYourDailyRitual => 'Настройте ваш ежедневный ритуал занятий.';

  @override
  String get youCanAdjustYourRitualAnyTime =>
      'Вы сможете изменить график занятий в любое время.';

  @override
  String get letsBegin => 'Начать';

  @override
  String get brandNew => 'Полный новичок';

  @override
  String get iveNeverStudiedChineseBefore =>
      'Я никогда раньше не изучал китайский язык.';

  @override
  String get iKnowBasicCharactersAndPhrases =>
      'Я знаю базовые иероглифы и простые приветствия.';

  @override
  String get iCanHoldConversationsAndRead =>
      'Могу поддержать простой разговор и читать несложные тексты.';

  @override
  String get iWantToRefineAndPerfectMySkills =>
      'Хочу отточить знания и довести язык до совершенства.';

  @override
  String get confirmSelection => 'Подтвердить выбор';

  @override
  String get purposeFuelsTheBrushsMotion =>
      'Четкая цель направляет каждое движение кисти.';

  @override
  String get buildMyPath => 'Составить мой путь';

  @override
  String get hskCertification => 'Сдача экзаменов и сертификат HSK';

  @override
  String get culturalAppreciation => 'Интерес к культуре, истории и искусству';

  @override
  String get yourPlanIsReady => 'Ваш план обучения готов';

  @override
  String get craftingYourCurriculum =>
      'Составляем персональный учебный план...';

  @override
  String get personalizedPathInitialized => 'ПЕРСОНАЛЬНЫЙ ПЛАН ИНИЦИАЛИЗИРОВАН';

  @override
  String get calibratingAiNeuralMasters => 'НАСТРОЙКА НЕЙРОННЫХ ИИ-ТЬЮТОРОВ...';

  @override
  String get calibrationComplete => 'Настройка завершена';

  @override
  String get synthesizingModules => 'Сборка учебных модулей...';

  @override
  String get oneAndWater => '«Один» и «Вода»';

  @override
  String get theHorizontalStroke => 'ГОРИЗОНТАЛЬНАЯ ЧЕРТА (ХЭН)';

  @override
  String get theRadical => 'РАДИКАЛ (КЛЮЧ)';

  @override
  String get water => 'Вода';

  @override
  String get river => 'Река';

  @override
  String get day5Reminder => 'Напоминание на 5-й день';

  @override
  String get wePromisedToAlertYou2DaysBeforeYour =>
      'Как и обещали, мы напоминаем за 2 дня до окончания пробного периода, чтобы вы могли спокойно принять решение.';

  @override
  String get continueWithoutReminder => 'Продолжить без напоминания';

  @override
  String get masterChineseWithnsinospark =>
      'Освойте китайский язык с\nSinoSpark';

  @override
  String get start7dayFreeTrial => 'Начать 7-дневный бесплатный пробный период';

  @override
  String get precisionStrokes => 'Точная каллиграфия';

  @override
  String get aiPronunciation => 'Постановка произношения с ИИ';

  @override
  String get today => 'Сегодня';

  @override
  String get fullAccess => 'Полный доступ ко всем функциям';

  @override
  String get day5 => 'День 5';

  @override
  String get reminder => 'Напоминание';

  @override
  String get day7 => 'День 7';

  @override
  String get trialBegins => 'Начало пробного периода';

  @override
  String get revenuecatIsMissingACurrentOffering =>
      'В RevenueCat нет активных пакетов. Настройте панель управления.';

  @override
  String get cameraPermissionRequiredForLiveScan =>
      'Для сканирования в реальном времени требуется доступ к камере.';

  @override
  String get cameraAccessRequired => 'Требуется доступ к камере';

  @override
  String get pleaseEnableCameraAccessInYourDevic =>
      'Пожалуйста, включите доступ к камере в настройках устройства, чтобы использовать эту функцию.';

  @override
  String get alignChineseTextWithinFrame =>
      'Поместите китайский текст внутрь рамки';

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
  String get poem => 'Стихотворение';

  @override
  String get theNarrative => 'Повествование';

  @override
  String get classicMasterpiece => 'Классический шедевр';

  @override
  String get classicAuthor => 'Классический автор';

  @override
  String get classical => 'Классика';

  @override
  String get classicLiterature => 'Классическая литература';

  @override
  String inThisChapterOf(Object title) {
    return 'В этой главе «$title»';
  }

  @override
  String get asTheNarrativeUnfoldsItIlluminatesT =>
      'С развитием сюжета раскрывается непреходящая жизненная мудрость и источник вдохновения.';

  @override
  String get general => 'Общее';

  @override
  String get mythology => 'Мифология';

  @override
  String get dailyLife => 'Повседневная жизнь';

  @override
  String get tangPoetry => 'Поэзия эпохи Тан';

  @override
  String get classicalLiterature => 'Классическая литература';

  @override
  String get justNow => 'Только что';

  @override
  String get theTerracottaArmyOfQinShiHuang =>
      'Терракотовая армия императора Цинь Шихуанди';

  @override
  String get lifeInsideTheForbiddenCity => 'Жизнь внутри Запретного города';

  @override
  String get buyingATicketAndTakingTheHighSpeedT =>
      'Покупка билета и поездка на скоростном поезде в Китае';

  @override
  String get goingToTheHospitalForAColdAndSeeing =>
      'Визит к врачу в больницу при простуде';

  @override
  String get goingToALocalRestaurantToOrderJiaoz =>
      'Поход в аутентичный ресторан и заказ пельменей цзяоцзы';

  @override
  String get theTraditionalGongfuTeaCeremony =>
      'Традиционная чайная церемония Гунфу-ча';

  @override
  String get theArtOfWritingChineseCharactersWit =>
      'Искусство написания иероглифов кистью';

  @override
  String get theLifeAndConservationOfGiantPandas =>
      'Жизнь и сохранение популяции больших панд';

  @override
  String get storyNotFoundInDatabase => 'История не найдена в базе данных';

  @override
  String get storyTextIsEmpty => 'Текст истории пуст';

  @override
  String get myCustomStories => 'Мои истории';

  @override
  String get userProvidedText => 'Текст пользователя';

  @override
  String get local => 'Локальный';

  @override
  String get voiceEngineAllowance => 'Голосовой движок и лимит использования';

  @override
  String get studioHdVsUnlimitedStandardVoice =>
      'Голоса Studio HD vs. Безлимитный стандартный голос';

  @override
  String get standardVoiceIs100UnlimitedFree =>
      'Стандартный голос на 100% бесплатен и не имеет ограничений';

  @override
  String get read => 'Читать';

  @override
  String get koreKoreFemaleWarm => 'Kore (женский, теплый)';

  @override
  String get aoedeAoedeFemaleCheerful => 'Aoede (женский, жизнерадостный)';

  @override
  String get fenrirFenrirMaleUpbeat => 'Fenrir (мужской, энергичный)';

  @override
  String get charonCharonMaleNewsstyle => 'Charon (мужской, дикторский)';

  @override
  String get puckPuckMaleSporty => 'Puck (мужской, спортивный)';

  @override
  String get localOndevice => 'Голос устройства';

  @override
  String get localOndeviceTts => 'Локальный системный TTS';

  @override
  String get off => 'Выкл.';

  @override
  String get endOfCurrentChapter => 'Конец текущей главы';

  @override
  String get standardVoice => 'Стандартный голос';

  @override
  String get noNovelsFoundMatchingYourFilter =>
      'Романов по выбранным фильтрам не найдено.';

  @override
  String get noMicroreadsFoundMatchingYourFilter =>
      'Микрочтений по выбранным фильтрам не найдено.';

  @override
  String get noPoemsFoundMatchingYourFilter =>
      'Стихотворений по выбранным фильтрам не найдено.';

  @override
  String get audiobook => 'Аудиокнига';

  @override
  String get audio => 'Аудио';

  @override
  String get continueReading => 'Продолжить чтение';

  @override
  String get search96FullNovelsAuthorsEpics =>
      'Поиск по 96 полным романам, авторам и эпосам...';

  @override
  String get searchClassicalPoemsAuthorsVerses =>
      'Поиск по классическим стихам, авторам и строфам...';

  @override
  String get allLevelsVal => 'Все уровни';

  @override
  String get hsk1BeginnerVal => 'HSK 1 (Начальный)';

  @override
  String get hsk2ElementaryVal => 'HSK 2 (Базовый)';

  @override
  String get hsk3IntermediateVal => 'HSK 3 (Средний)';

  @override
  String get hsk4UpperIntVal => 'HSK 4 (Средне-продвинутый)';

  @override
  String get listenToAudiobook => 'Слушать аудиокнигу';

  @override
  String get synopsis => 'Аннотация';

  @override
  String get peoplesArtist => 'Народный артист';

  @override
  String get kafkaesqueForBureaucraticAbsurdityA =>
      '«Кафкианский» — для выражения бюрократического абсурда, отчуждения и экзистенциальной тревоги.';

  @override
  String get bigBrotherAndNewspeak => '«Большой Брат» и «Новояз».';

  @override
  String get audiobookIncluded => 'Аудиокнига включена';

  @override
  String get readPoem => 'Читать стих';

  @override
  String get studioVoiceAllowance => 'Лимит озвучки Studio HD';

  @override
  String get weeklyHighdefinitionAiRecitation =>
      'Еженедельная декламация ИИ высокой четкости';

  @override
  String get resetsEveryMondayAt0000 =>
      'Сбрасывается каждый понедельник в 00:00';

  @override
  String get whenYourWeekly4hourStudioAllowanceI =>
      'После расхода 4 часов Studio в неделю приложение автоматически переключится на встроенный голос устройства для безлимитного бесплатного прослушивания.';

  @override
  String get localDeviceVoice => 'Голос устройства';

  @override
  String get classicalVerse => 'Классические строки';

  @override
  String get ondeviceVoice4hWeeklyUsed =>
      'Голос устройства (4 ч в неделю израсходовано)';

  @override
  String get generateACustomAiStoryBasedOnYourIn =>
      'Создайте свою ИИ-историю на основе ваших интересов';

  @override
  String get insteadOfAFixedHskLevelTheFlowState =>
      'Вместо жесткого уровня HSK движок Flow State подстраивается под лексику из ваших личных карточек.\n\n';

  @override
  String get we => 'Мы';

  @override
  String get howCanWeHelpYou => 'Чем мы можем вам помочь?';

  @override
  String get everythingYouNeedToKnowAboutHanziMa =>
      'Все, что нужно знать о SinoSpark, его возможностях и конфиденциальности.';

  @override
  String get whoAreTheVoicesSpeakingInTheApp =>
      'Кто озвучивает диалоги в приложении?';

  @override
  String get howDoesTheWebExplorerWork => 'Как работает веб-браузер?';

  @override
  String get whatIsZenMode => 'Что такое Дзен-режим?';

  @override
  String get howDoesTheFlashcardSpacedrepetition =>
      'Как работает интервальное повторение карточек?';

  @override
  String get traceComplete => 'Написание завершено!';

  @override
  String get traceCharacter => 'Обвести иероглиф';

  @override
  String get analyzingWordRelationships => 'Анализ смысловых связей слов...';

  @override
  String get identifyingUsageContexts =>
      'Определение контекста употребления...';

  @override
  String get comparingFormalityLevels => 'Сравнение уровней формальности...';

  @override
  String get findingCommonCollocations => 'Поиск устойчивых словосочетаний...';

  @override
  String get generatingComparison => 'Формирование сравнительного анализа...';

  @override
  String get generationIsTakingLongerThanExpecte =>
      'Генерация занимает больше времени, чем обычно. Сервер ИИ может быть временно перегружен.';

  @override
  String get generationInterruptedShowingPartial =>
      'Генерация прервана. Отображаются частичные результаты.';

  @override
  String get sorrySomethingWentWrong => 'Извините, произошла ошибка.';

  @override
  String get usage => 'Употребление:';

  @override
  String get alsoSeenIn => 'Также встречается в';

  @override
  String get quickLook => 'Быстрый просмотр';

  @override
  String get notFound => 'Не найдено';

  @override
  String get errorLoadingFromAi => 'Ошибка при получении данных от ИИ.';

  @override
  String get analyzingImage => 'Анализ изображения...';

  @override
  String get extractingChineseText => 'Распознавание китайского текста...';

  @override
  String get lookingUpVocabulary => 'Поиск слов в словаре...';

  @override
  String get dreamOfTheRedChamber => 'Сон в красном тереме (Хунлоумэн)';

  @override
  String get journeyToTheWest => 'Путешествие на Запад (Сиюцзи)';

  @override
  String get romanceOfTheThreeKingdoms => 'Троецарствие (Саньго яньи)';

  @override
  String get mingDynasty => 'Династия Мин';

  @override
  String get wuChengEn => 'У Чэнъэнь';

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
      'Закладок пока нет. Нажмите на значок закладки, чтобы сохранить понравившийся фрагмент.';

  @override
  String get sinosparkIsNotResponding => 'SinoSpark не отвечает';

  @override
  String get closeApp => 'Закрыть приложение';

  @override
  String get wait => 'Подождать';

  @override
  String studioHdAllowance(Object hours) {
    return 'Studio HD: $hours ч';
  }

  @override
  String bookPercentRead(Object percent) {
    return 'Прочитано $percent%';
  }

  @override
  String chAbbreviation(Object number) {
    return 'Гл. $number';
  }

  @override
  String booksAndAudiobooks(Object count) {
    return 'Книг и аудиокниг: $count';
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
      'Поиск адаптированных микроисторий и притч...';

  @override
  String gradedStoriesAndMicroReads(Object count) {
    return 'Адаптированных историй и ежедневных чтений: $count';
  }

  @override
  String get searchClassicalPoems =>
      'Поиск классических стихов, поэтов, строк...';

  @override
  String classicalPoemsAndVerse(Object count) {
    return 'Классических стихов и поэм: $count';
  }

  @override
  String get browseAnyChineseWebsite =>
      'Читайте любые китайские сайты со встроенным словарем в реальном времени, пиньинем и мгновенным переводом.';

  @override
  String get completed => 'ЗАВЕРШЕНО';

  @override
  String get aiIsReading => 'ИИ читает текст...';

  @override
  String get bbcVerify => 'BBC Verify';

  @override
  String get hsk5AdvancedVal => 'HSK 5 (Продвинутый)';

  @override
  String get hsk1Beginner => 'HSK 1 (Начальный)';

  @override
  String get hsk4UpperInt => 'HSK 4 (Средне-продвинутый)';

  @override
  String get extractAllUnknownWords =>
      'Извлечь все незнакомые слова в новую колоду карточек';

  @override
  String get designCustomAiRoleplay =>
      'Создать свою ролевую игру и диалог с ИИ';

  @override
  String get practiceFlashcardVocabulary =>
      'Отрабатывать слова из карточек в живом диалоге';

  @override
  String get surpriseMe => 'Случайный выбор';

  @override
  String get rollCharacter => 'Случайный персонаж';

  @override
  String get historicalCostume => 'Исторический / Костюмированный';

  @override
  String get modernYouth => 'Современность и молодежь';

  @override
  String get fantasyMythology => 'Фэнтези и мифология';

  @override
  String get familyDrama => 'Семья и драма';

  @override
  String get fullVersion => 'Полная версия';

  @override
  String episodesCount(Object count) {
    return 'Серий: $count';
  }

  @override
  String episodeLabel(Object number) {
    return 'Серия $number';
  }

  @override
  String get translating => '[ Перевод... ]';

  @override
  String get engSub => '[Русские субтитры]';

  @override
  String get standardVocabulary => 'Стандартная лексика';

  @override
  String get characters => 'Иероглифы';

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
