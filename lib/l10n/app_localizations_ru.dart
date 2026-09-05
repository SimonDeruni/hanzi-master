// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get originStoryChip => '📜 Происхождение';

  @override
  String get ancientFormChip => '🏺 Древняя форма';

  @override
  String get threeMoreWordsChip => '📖 Ещё 3 слова';

  @override
  String get wordFamilyChip => '🔗 Однокоренные слова';

  @override
  String get idiomChip => '🀄 Идиома';

  @override
  String get proverbChip => '💬 Пословица';

  @override
  String get strokeOrderChip => '✏️ Порядок черт';

  @override
  String get calligraphyTipChip => '🎨 Совет по каллиграфии';

  @override
  String get grammarNoteChip => '📝 Грамматическая заметка';

  @override
  String get similarWordsChip => '🔄 Похожие слова';

  @override
  String get culturalNoteChip => '🏮 Культурная заметка';

  @override
  String get inMediaChip => '🀄 В медиа';

  @override
  String get radicalMeaningChip => '🧩 Значение ключа';

  @override
  String get componentBreakdownChip => '🔍 Разбор компонентов';

  @override
  String get toneTipChip => '🎵 Совет по тонам';

  @override
  String get homophonesChip => '👯 Омофоны';

  @override
  String askMeAnythingAbout(String hanzi) {
    return 'Задайте любой вопрос о $hanzi...';
  }

  @override
  String aiTutorError(String error) {
    return 'Ошибка ИИ-репетитора: $error';
  }

  @override
  String get aiTutorRateLimit =>
      'ИИ-репетитор сейчас занят. Пожалуйста, подождите немного и попробуйте снова.';

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
  String get studySession => 'Учебная сессия';

  @override
  String get readyToStudy => 'Готовы учиться';

  @override
  String get studyQueuePreviewDescription =>
      'Занятие сформировано на основе расписания на сегодня и лимитов колоды.';

  @override
  String get notNow => 'Не сейчас';

  @override
  String get newLabel => 'Новинка';

  @override
  String get studyDeckEmpty => 'Эта колода пуста';

  @override
  String get studyDeckEmptyDescription =>
      'Добавьте карточки перед началом занятия.';

  @override
  String get studyDailyLimitReached => 'Дневной лимит достигнут';

  @override
  String get studyDailyLimitReachedDescription =>
      'Вы исчерпали дневную норму новых карточек или повторений для этой колоды.';

  @override
  String get studyCaughtUpDescription =>
      'На сегодня больше ничего не запланировано. Возвращайтесь к следующему повторению.';

  @override
  String get noCardsAvailable => 'Нет доступных карточек';

  @override
  String get studyNoEligibleCardsDescription =>
      'В данный момент нет карточек, подходящих для этого режима.';

  @override
  String get studySessionLoadFailed =>
      'Не удалось загрузить занятие. Попробуйте снова.';

  @override
  String get retryLimitReached => 'Эта карточка появится в следующей сессии.';

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
  String get libraryLabel => '文化书房 Библиотека';

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
  String get play => 'Воспроизвести )';

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
  String get aiDataPrivacyTitle => 'ИИ и конфиденциальность';

  @override
  String get aiDataPrivacySettingsSubtitle =>
      'Узнайте, какие данные отправляют функции ИИ, зачем и кому';

  @override
  String get aiDataPrivacyOverviewTitle => 'Когда используется ИИ';

  @override
  String get aiDataPrivacyOverviewBody =>
      'SinoSpark использует облачный ИИ только тогда, когда вы выбираете соответствующую функцию: чат ИИ, объяснения, перевод, анализ изображений, распознавание речи, оценка произношения или облачная озвучка. Ответы ИИ могут быть неточными, проверяйте важную информацию.';

  @override
  String get aiDataPrivacyProvidersTitle => 'Провайдеры ИИ';

  @override
  String get aiDataPrivacyProvidersBody =>
      'Google Gemini обрабатывает запросы с генерацией текста и изображений. OpenRouter направляет часть генеративных запросов в Google Gemini или DeepSeek. Microsoft Azure AI Speech отвечает за распознавание речи, оценку произношения и синтез речи в облаке.';

  @override
  String get aiDataPrivacySentTitle => 'Отправляемые данные';

  @override
  String get aiDataPrivacySentBody =>
      'В зависимости от функции могут отправляться: введённый или выбранный текст, контекст диалога или урока, изображения для анализа, голосовые записи и технические данные (IP-адрес, метаданные устройства и сети). Мы намеренно не включаем ваше имя или email в запросы к ИИ.';

  @override
  String get aiDataPrivacyControlsTitle => 'Ваш выбор';

  @override
  String get aiDataPrivacyControlsBody =>
      'Не используйте функции ИИ, если не хотите передавать данные провайдерам. Вы можете запретить доступ к камере, фото или микрофону в настройках устройства. Выберите локальный голос, чтобы озвучка выполнялась на устройстве. Не передавайте конфиденциальную информацию.';

  @override
  String get aiDataPrivacyRetentionTitle => 'Хранение данных';

  @override
  String get aiDataPrivacyRetentionBody =>
      'SinoSpark не хранит исходные запросы ИИ, изображения или аудиозаписи на своих серверах после обработки. Сгенерированные результаты могут сохраняться на устройстве или в аккаунте по вашему выбору. Провайдеры обрабатывают данные согласно своим правилам; подробнее см. в полной политике.';

  @override
  String get readFullPrivacyPolicy => 'Читать политику конфиденциальности';

  @override
  String get linkOpenFailed => 'Не удалось открыть ссылку. Попробуйте снова.';

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
  String get requiredLabel => 'Обязательно';

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
  String get ijenwaBenita => 'Идженва Бенита';

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
  String get liveOverlay => 'УМНЫЙ ОВЕРЛЕЙ';

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
  String get todayDashboard => 'Сегодня';

  @override
  String get studyToday => 'Учить карточки на сегодня';

  @override
  String get studyAhead => 'Учить заранее';

  @override
  String get studyAheadDescription =>
      'Повторяйте ближайшие запланированные карточки без расхода дневного лимита. Новые карточки не добавляются.';

  @override
  String get studyAheadComplete => 'Досрочное повторение завершено';

  @override
  String get dueNow => 'К повторению';

  @override
  String get scheduled => 'Запланировано';

  @override
  String get sevenDayForecast => 'Прогноз повторений на 7 дней';

  @override
  String get reviews => 'Повторения';

  @override
  String get newCardsLabel => 'Новые карточки';

  @override
  String get attempts => 'Попытки';

  @override
  String get duration => 'Время';

  @override
  String get answerBreakdown => 'Разбор ответов';

  @override
  String get reviewCards => 'Карточки для повторения';

  @override
  String get retries => 'Повторные попытки';

  @override
  String get needsPractice => 'Нужно повторить';

  @override
  String get uniqueCardsStudied => 'Карточки';

  @override
  String get dartConvert => 'dart:convert';

  @override
  String get env => '.env';

  @override
  String get dartUi => 'dart:ui';

  @override
  String get dartMath => 'dart:math';

  @override
  String get drawInTheOtherDirection => 'Ведите в другом направлении ➔';

  @override
  String get fastClean => 'Быстро и аккуратно!';

  @override
  String get good2 => 'Хорошо!';

  @override
  String get followTheFlow => 'Следуйте движению.';

  @override
  String get masterful => 'Мастерски!';

  @override
  String get missingTheHookEnd => 'Не хватает крючка/конца.';

  @override
  String get thai => 'Тайский';

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
  String get ink => 'тушь,';

  @override
  String get stroke => 'черта,';

  @override
  String get breath => 'дыхание.';

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
  String get theExactSentenceProvided => 'точное предоставленное предложение';

  @override
  String get pinyinWithToneMarks2 => 'пиньинь со значками тонов';

  @override
  String get wXHuNH => 'Wǒ xǐhuān hē píngguǒzhī.';

  @override
  String get extractAllChineseCharactersFrom =>
      'Извлеките все китайские иероглифы из этого изображения. Верните ТОЛЬКО извлеченный текст — без комментариев, форматирования и переводов. Сохраняйте переносы строк. Если китайских иероглифов нет, верните пустую строку.';

  @override
  String get householdObject => 'бытовой предмет';

  @override
  String get genericLabelFromTheList => 'общая метка из списка';

  @override
  String get gNgS => 'gōng sī';

  @override
  String get measureWord => 'счётное слово';

  @override
  String get zenInk => 'Дзен и тушь';

  @override
  String get cRITICALPutTheEnglishTranslation =>
      'ВАЖНО: Поместите английский перевод в ключ JSON «english»!';

  @override
  String get definitionInEnglish => 'определение на английском';

  @override
  String get simplifiedLine0 => 'упрощенная строка 0';

  @override
  String get simplifiedLine1 => 'упрощенная строка 1';

  @override
  String get iMPORTANTRULEDoNotAddress =>
      'ВАЖНОЕ ПРАВИЛО: Не обращайтесь к пользователю по имени. Никогда не используйте имена-заглушки вроде «Джон». Обращайтесь напрямую без использования имени.';

  @override
  String get rULESAnswerIn23 =>
      'ПРАВИЛА: Отвечайте максимум в 2–3 предложениях. Для списков используйте маркированные пункты.';

  @override
  String get neverWriteIntroductionsSignOffs =>
      'Никогда не пишите вступлений, прощаний или вводных фраз вроде «Отличный вопрос!» или «Конечно!».';

  @override
  String get useBoldForChineseCharacters =>
      'Используйте **полужирный шрифт** для китайских иероглифов и ключевых терминов.';

  @override
  String get rULESAnswerIn232 =>
      'ПРАВИЛА: Отвечайте максимум в 2–3 предложениях.';

  @override
  String get accept => 'Принять';

  @override
  String get pronunciationAssessment => 'Оценка произношения';

  @override
  String get nBest => 'NBest';

  @override
  String get none => 'Нет';

  @override
  String get theCorrectedChineseText => 'исправленный китайский текст';

  @override
  String get thePinyinForTheCorrected => 'пиньинь для исправленного текста';

  @override
  String get theEnglishMeaningOfThe =>
      'значение исправленного текста на английском';

  @override
  String get pNyNWithTone => 'пиньинь с обозначением тонов';

  @override
  String get englishTranslation2 => 'английский перевод';

  @override
  String get zhNggu => 'Zhōngguó';

  @override
  String get youAreAChineseClassical =>
      'Вы — эксперт по классической китайской литературе, предоставляющий подробные и доступные разборы классической китайской поэзии.';

  @override
  String get youAreAChineseCulture =>
      'Вы — эксперт по китайской культуре и литературе. Делитесь увлекательными и красиво написанными заметками о культуре.';

  @override
  String get english2 => 'Английский:';

  @override
  String get remindersWhenYouHavenT =>
      'Напоминания, если вы не заходили в приложение несколько дней';

  @override
  String get itSBeenAFew =>
      'Прошло несколько дней! Уделите сегодня 5 минут изучению нового иероглифа.';

  @override
  String get abbreviationFor => 'сокращение от';

  @override
  String get cL => 'Сч. слово:';

  @override
  String get measureWord2 => 'Счетное слово:';

  @override
  String get lu => 'lu:';

  @override
  String get luE => 'lu:e';

  @override
  String get nu => 'nu:';

  @override
  String get nuE => 'nu:e';

  @override
  String get noUser => 'Пользователь не найден';

  @override
  String get passwordRequired => 'Требуется пароль';

  @override
  String get unsupportedProvider => 'Провайдер не поддерживается';

  @override
  String get appleRevocationUnavailable => 'Отзыв Apple недоступен';

  @override
  String get appleCredentialMissing => 'Отсутствуют учетные данные Apple';

  @override
  String get authenticationDidNotReturnA =>
      'Аутентификация не вернула пользователя.';

  @override
  String get viewSubscriptionPlans => 'Посмотреть тарифные планы';

  @override
  String get wrongPassword => 'Неверный пароль';

  @override
  String get invalidCredential => 'Недействительные учетные данные';

  @override
  String get networkRequestFailed => 'Ошибка сетевого запроса';

  @override
  String get requiresRecentLogin => 'Требуется повторный вход';

  @override
  String get userMismatch => 'Несоответствие пользователей';

  @override
  String get deleteAccountPassword => 'Пароль для удаления аккаунта';

  @override
  String get deleteAccountError => 'Ошибка при удалении аккаунта';

  @override
  String get deleteAccountSubmit => 'Удалить аккаунт';

  @override
  String get theSimplestShapesTheBeginning =>
      'Самые простые формы. Начало всего.';

  @override
  String get sunMoonWaterAndFire => 'Солнце, Луна, Вода и Огонь. Мир природы.';

  @override
  String get theBodyTheHeartAnd => 'Тело, сердце и семья.';

  @override
  String get fieldsRoofsAndToolsThe =>
      'Поля, крыши и инструменты. Основы общества.';

  @override
  String get movementSpeechAndSustenance => 'Движение, речь и пропитание.';

  @override
  String get commerceClothingAndComplexArtifacts =>
      'Торговля, одежда и сложные предметы.';

  @override
  String get fastTrackSimpleCharacterMastered =>
      '🚀 Ускоренный курс! Простой иероглиф освоен.';

  @override
  String get excellentPrecisionGhostTraceSkipped =>
      '⚡ Отличная точность! Фантомный контур пропущен.';

  @override
  String get sample => 'Образец:';

  @override
  String get itsThat => 'Его / Тот';

  @override
  String get iMe => 'Я / Меня';

  @override
  String get stillTough => 'Всё ещё / Трудный';

  @override
  String get partDecide => 'Часть / Решать';

  @override
  String get selectTheCharacterFor => 'Выберите иероглиф для:';

  @override
  String get selectThePinyinFor => 'Выберите пиньинь для:';

  @override
  String get whereAreYouGoingThe =>
      'Куда вы направляетесь? В аэропорт? Это довольно долгий путь!';

  @override
  String get youAreAuntieChenA =>
      'Вы — тетушка Чэнь, проницательный торговец шелком и тканями на рынке. Ваша ЕДИНСТВЕННАЯ роль — продавец. Твердо, но честно ведите торговлю на путунхуа. НИКОГДА не выходите из образа и не представляйтесь кем-либо еще. Начинайте с высоких цен и будьте готовы торговаться.';

  @override
  String get youAreDrZhangA =>
      'Вы — доктор Чжан, спокойный и профессиональный врач в клинике. Ваша ЕДИНСТВЕННАЯ роль — врач. Спрашивайте о симптомах и давайте медицинские советы на путунхуа. НИКОГДА не выходите из образа и не представляйтесь кем-либо еще. Будьте доброжелательны и внимательны.';

  @override
  String get whereDoYouFeelUncomfortable =>
      'Где вы чувствуете недомогание? У вас есть температура?';

  @override
  String get youAreACloseFriend =>
      'Ты — близкий друг, встречающий товарища после долгой разлуки. Твоя ЕДИНСТВЕННАЯ роль — друг. Отвечай непринужденно, тепло и коротко на путунхуа. НИКОГДА не выходи из образа и не представляйся кем-то еще. Используй неформальный стиль общения, подходящий для близких друзей.';

  @override
  String get noNbest => 'нет nbest';

  @override
  String get timedOut => 'время истекло';

  @override
  String get grading => 'Оценивание...';

  @override
  String get label1st => '1-й ˉ';

  @override
  String get label2nd => '2-й ˊ';

  @override
  String get label3rd => '3-й ˇ';

  @override
  String get label4th => '4-й ˋ';

  @override
  String get speaking2 => 'Говорение...';

  @override
  String get sessionCompletedInYourNext =>
      'Занятие завершено. На следующей практике произносите полные предложения, чтобы получить подробную диагностику произношения и тонов.';

  @override
  String get craneSoaring => 'парящий журавль';

  @override
  String get gentleStream => 'тихий ручей';

  @override
  String get brushAndInk => 'кисть и тушь';

  @override
  String get myStudent => 'мой ученик';

  @override
  String get honoredDisciple => 'почтенный ученик';

  @override
  String get notEnoughInformation => 'недостаточно информации';

  @override
  String get asAnAi => 'как ИИ';

  @override
  String get goodPracticeSessionContinueFocusing =>
      'Хорошая тренировка. Продолжайте уделять внимание четкости тонов и естественному темпу речи.';

  @override
  String get insideASleekFuxingBullet =>
      'Внутри скоростного поезда «Фусин», летящего со скоростью 350 км/ч из Пекина в Шанхай.';

  @override
  String get harbinIceSnowWorldWonder => 'Харбинский мир льда и снега';

  @override
  String get theFamousPanjiayuanWeekendFlea =>
      'Знаменитый выходной блошиный рынок Паньцзяюань со свитками каллиграфии, нефритом и винтажными безделушками.';

  @override
  String get jingdezhenBlueWhitePorcelainStudio =>
      'Студия бело-голубого фарфора в Цзиндэчжэне';

  @override
  String get pekingOperaDressingRoomMakeup => 'Гримерка Пекинской оперы';

  @override
  String get aHistoricTongrentangApothecaryScented =>
      'Историческая аптека «Тунжэньтан» с ароматом женьшеня, ягод годжи и сотнями деревянных ящиков с травами.';

  @override
  String get aVibrantPrivateNeonLit =>
      'Яркая неоновая караоке-комната в Шэньчжэне с микрофонами, фруктовыми нарезками и пультом управления.';

  @override
  String get animeCosplayExpoInGuangzhou =>
      'Выставка аниме и косплея в Гуанчжоу';

  @override
  String get nHOHuNy =>
      'Nǐ hǎo! Huānyíng lái dào zhèlǐ, jīntiān wǒmen liáo xiē shénme ne?';

  @override
  String get surpriseMe2 => '🎲 Удиви меня';

  @override
  String get eGALivelyBanquet => 'напр., оживленный банкет в Шанхае...';

  @override
  String get rollCharacter2 => '🎲 Случайный персонаж';

  @override
  String get eGACuriousCousin =>
      'напр., любопытный кузен, расспрашивающий о вашей карьере...';

  @override
  String get keepTrying => 'Попробуйте еще!';

  @override
  String get pending => 'В ожидании...';

  @override
  String get expected => '🎯 Ожидается';

  @override
  String get hSK2Elementary => 'HSK 2: Элементарный';

  @override
  String get hSK3Intermediate => 'HSK 3: Средний';

  @override
  String get hSK5Advanced => 'HSK 5: Продвинутый';

  @override
  String get expressYourselfFullyWith5000 =>
      'Свободно выражайте мысли с 5000+ слов.';

  @override
  String get hanziWriter => 'hanzi-writer';

  @override
  String get hvg => 'hvg:';

  @override
  String get unlimited => 'Безлимитно';

  @override
  String get dueToday => 'На сегодня';

  @override
  String get newAvailable => 'Доступны новые';

  @override
  String get deleteAccountTile => 'delete-account-tile';

  @override
  String get giveASingleShortPractical =>
      'Дайте один короткий практичный совет, как улучшить форму, положение или длину неверно нарисованных черт. Пишите прямо и по делу, без поэтичности и метафор. Не используйте markdown.';

  @override
  String get localOnDeviceTTS => 'Локально — TTS на устройстве';

  @override
  String get espaOl => 'Испанский';

  @override
  String get franAis => 'Французский';

  @override
  String get portuguS => 'Португальский';

  @override
  String get tiNgViT => 'Вьетнамский';

  @override
  String get koreFemaleWarm => 'Kore — женский, тёплый';

  @override
  String get aoedeFemaleCheerful => 'Aoede — женский, жизнерадостный';

  @override
  String get fenrirMaleUpbeat => 'Fenrir — мужской, бодрый';

  @override
  String get charonMaleNewsStyle => 'Charon — мужской, новостной стиль';

  @override
  String get puckMaleSporty => 'Puck — мужской, спортивный';

  @override
  String get systemVoice => 'Системный голос';

  @override
  String get generateAdd => 'Сгенерировать и добавить';

  @override
  String get moreExamples => '📝 Ещё примеры';

  @override
  String get usage2 => '❓ Использование';

  @override
  String get translation => '💬 Перевод';

  @override
  String get collocations => '📚 Словосочетания';

  @override
  String get mistakes => '❌ Ошибки';

  @override
  String get decrease => 'Уменьшить';

  @override
  String get increase => 'Увеличить';

  @override
  String get label0MeansThisCardType =>
      '0 означает, что этот тип карточек отключен.';

  @override
  String get tapTheValueToEnter =>
      'Нажмите на значение, чтобы ввести точный лимит.';

  @override
  String get exactDailyLimit => 'Точный дневной лимит';

  @override
  String get enter0ToDisable => 'Введите 0 для отключения.';

  @override
  String get apply => 'Применить';

  @override
  String get selectDeck => 'Выберите колоду';

  @override
  String get azureSpeechKeysNotConfigured =>
      'Ключи Azure Speech не настроены. Добавьте AZURE_SPEECH_KEY и AZURE_SPEECH_REGION в .env';

  @override
  String get sTARTING => 'ЗАПУСК…';

  @override
  String get sTARTSESSION => 'НАЧАТЬ СЕССИЮ';

  @override
  String get translating2 => 'Перевод...';

  @override
  String get chai => '柴知道Chai...';

  @override
  String get oneInABillion2 => '@One-In-a-Billion';

  @override
  String get businessEconomics => 'бизнес и экономика';

  @override
  String get hskPreparation => 'подготовка к HSK';

  @override
  String get liveInChina => 'жизнь в китае';

  @override
  String get comprehensiveExercise => 'комплексное упражнение';

  @override
  String get howToUse => 'как использовать';

  @override
  String get usesOf => 'варианты использования';

  @override
  String get appearedFirstOnMandarinBean =>
      'впервые появилось на Mandarin Bean';

  @override
  String get news2 => 'новости:';

  @override
  String get joke => 'анекдот:';

  @override
  String get jokes => 'шутки:';

  @override
  String get academicScience => 'академия / наука';

  @override
  String get politicsCommunism => 'политика и коммунизм';

  @override
  String get foodDining => 'Еда и рестораны';

  @override
  String get sciFi => 'научная фантастика';

  @override
  String get scienceFictionTech => 'Научная фантастика и технологии';

  @override
  String get travelPlaces => 'Путешествия и места';

  @override
  String get mythologyFantasy => 'Мифология и фэнтези';

  @override
  String get cultureTraditions => 'Культура и традиции';

  @override
  String get businessEconomy => 'Бизнес и экономика';

  @override
  String get natureAnimals => 'Природа и животные';

  @override
  String get articleImg => 'изображение статьи';

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
  String get xiXiPicturesOfficialChannel => 'Официальный канал XiXi Pictures';

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
  String get getTheWeTVAPP => '腾讯视频 — Скачать приложение WeTV';

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
  String get learnMandarinWithTaiwanPlus => 'Учите китайский с TaiwanPlus';

  @override
  String get everydayChinese => 'Повседневный китайский';

  @override
  String get uCCFdR7zZ5SUXuOrEdKw => 'UCC_fdR7zZ_5SU--xuOrEdKw';

  @override
  String get tingDailyLifeInChina => 'Тин — повседневная жизнь в Китае';

  @override
  String get tFTFOODTRAVEL => 'TFT — ЕДА И ПУТЕШЕСТВИЯ';

  @override
  String get uCsHMiBJ9r87fRH7VAWZw => 'UCs_h_miBJ9r8-7fRH7VAWZw';

  @override
  String get liziqi3 => '李子柒 Liziqi: Жизнь чеснока';

  @override
  String get label2MINCULTURALCONTEXT => '2 МИН КУЛЬТУРНОГО КОНТЕКСТА';

  @override
  String get liziqi4 => '李子柒 Liziqi: Бамбуковая мебель';

  @override
  String get peppaPigChinese2 => 'Свинка Пеппа на китайском: Грязная лужа';

  @override
  String get noBBCLeadArticleIs =>
      'Главная статья BBC в настоящее время недоступна.';

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
  String get sIXSISTERS2 => '六姊妹 Шесть сестёр';

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
  String get shineOnMe => '骄阳似我 Сияй для меня';

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
  String get thoseDays => '四喜 Те дни';

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
  String get noFunnyNoMoney => 'Не смешно — ночуй на улице (No Funny No Money)';

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
  String get getTheWeTVAPP2 =>
      'Tencent Video — Аниме — Скачайте приложение WeTV';

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
      '«Повелитель тайн» (Lord of Mysteries) — Влог озвучки от Cuttlefish (финал) | Tencent Video — Аниме';

  @override
  String get lordOfMysteries =>
      '«Повелитель тайн» (Lord of Mysteries) — Урок оккультизма №8 | Tencent Video — Аниме';

  @override
  String get lordOfMysteries2 =>
      '«Повелитель тайн» (Lord of Mysteries) — Урок оккультизма №7 | Tencent Video — Аниме';

  @override
  String get lordOfMysteries3 =>
      '«Повелитель тайн» (Lord of Mysteries) — Урок оккультизма №6 | Tencent Video — Аниме';

  @override
  String get lordOfMysteries4 =>
      '«Повелитель тайн» (Lord of Mysteries) — Урок оккультизма №5 | Tencent Video — Аниме';

  @override
  String get lordOfMysteries5 =>
      '«Повелитель тайн» (Lord of Mysteries) — Урок оккультизма №4 | Tencent Video — Аниме';

  @override
  String get lordOfMysteries6 =>
      '«Повелитель тайн» (Lord of Mysteries) — Урок оккультизма №3 | Tencent Video — Аниме';

  @override
  String get pakhctn6g6A => 'Pakhctn6g6A';

  @override
  String get lordOfMysteries7 =>
      '«Повелитель тайн» (Lord of Mysteries) — Урок оккультизма №2 | Tencent Video — Аниме';

  @override
  String get lordOfMysteries8 =>
      '«Повелитель тайн» (Lord of Mysteries) — Урок оккультизма №1 | Tencent Video — Аниме';

  @override
  String get g5fLWO98axs => 'G5fLWO98axs';

  @override
  String get gK0eOTF2s4c => 'GK0eOTF2s4c';

  @override
  String get oSTLordOfMysteries =>
      '[OST] «Повелитель тайн» (Lord of Mysteries) — Финальная тема «Незабудка» | Tencent Video — Аниме';

  @override
  String get membersPremiere2 => 'Премьера для участников';

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
  String get eightHundred => '方圆八百米 Восемьсот';

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
  String get loveBeyondTheGrave => '白日提灯 Любовь за гранью смерти';

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
      'Бонус со съемок: настоящих имен Хэ Сыму и Дуань Сюя не найти, зато прозвищ пруд пруди 【白日提灯 Любовь за гранью смерти】';

  @override
  String get label5MVET41ATY => '5MVET41A-tY';

  @override
  String get bTSLoveBeyondTheGrave =>
      'BTS｜【Tencent Drama Party】 Дильраба и Чэнь Фэйюй вместе с командой демонстрируют сыгранность в фотосессии «Пять чувств»! 【白日提灯 Любовь за гранью смерти】';

  @override
  String get bTSLoveBeyondTheGrave2 =>
      'BTS｜【Tencent Drama Party】 Появление Дильрабы и Чэнь Фэйюя: убийственный взгляд — это просто шедевр! 【白日提灯 Любовь за гранью смерти】';

  @override
  String get herBlaze => '她的盛焰 Её пламя';

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
  String get aboutLove => '玫瑰丛生 О любви';

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
      'Все герои «Розы в зарослях» запутались в любовном тумане. Как они найдут выход? | В главных ролях: Ван Цзывэнь, Лю Юйнин';

  @override
  String get pLMX26aiIvX5rSLe74r7sARps4oOqaBWD =>
      'PLMX26aiIvX5rSLe74r7sA-Rps4oOqaBWD';

  @override
  String get generationToGeneration2 => '江湖夜雨十年灯 Из поколения в поколение';

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
  String get loveStoryInThe1970s => 'Любовь в 1970-х';

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
  String get whyIsHeStillSingle => 'Почему он всё ещё один';

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
  String get theGlamorousNight => 'Роскошная ночь';

  @override
  String get theGlamorousNightE03 =>
      '【Роскошная ночь】Эп. 03: Решительный ход! Контратака Чжао Мэй (Цзян Шуин, Тун Давэй)';

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
  String get myPageInThe90s => 'Внезапная любовь — My Page in the 90s';

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
      'Отрывок 04: Нелепая система драматизирует! Салфетка стала прокладкой? Вот это конфуз! 【My Page in the 90s】';

  @override
  String get label03MyPageInThe =>
      'Отрывок 03: Пошла на свидание вслепую вместо подруги и встретила главного героя? 【My Page in the 90s】';

  @override
  String get bTSXXMyPage =>
      'За кадром | Чэнь Синсюй и Ван Юйвэнь: кто из них смешнее? 【My Page in the 90s】';

  @override
  String get label02MyPageInThe =>
      'Отрывок 02: Хотела завоевать главного героя, но перепутала людей? 【My Page in the 90s】';

  @override
  String get label01MyPageInThe =>
      'Отрывок 01: Невероятно! Внезапно попала в книгу? Как мне это играть? 【My Page in the 90s】';

  @override
  String get bTSMyPageInThe =>
      'За кадром | Чэнь Синсюй и Ван Юйвэнь случайно врезались друг в друга на катке 【My Page in the 90s】';

  @override
  String get bTSMyPageInThe2 =>
      'За кадром | Чэнь Синсюй и Ван Юйвэнь вместе встречают Новый год 【My Page in the 90s】';

  @override
  String get bTSMyPageInThe3 =>
      'За кадром | Чэнь Синсюй и Ван Юйвэнь: романтический момент на Циси 【My Page in the 90s】';

  @override
  String get bTSMyPageInThe4 =>
      'За кадром | Чэнь Синсюй и Ван Юйвэнь веселятся в парке развлечений 【My Page in the 90s】';

  @override
  String get myPageInThe90s2 =>
      'Премьера «My Page in the 90s» сегодня! Чэнь Синсюй и Ван Юйвэнь в романтической истории';

  @override
  String get myPageInThe90s3 =>
      'Премьера «My Page in the 90s» 22 января: нетипичная романтика Чэнь Синсюя и Ван Юйвэнь';

  @override
  String get myPageInThe90s4 =>
      '«My Page in the 90s» выходит 22 января! Романтическая история Чэнь Синсюя и Ван Юйвэнь';

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
      'Императорский коронер 2 (The Imperial Coroner S2)';

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
  String get theDreamMaker => '小城大事 (The Dream Maker)';

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
      '【Forever Young】 Эп. 23 | Мартин возвращается в хутун и оказывается во власти друзей (Хо Цзяньхуа, Тянь Юй, Чжан Сюэин, Цяо Чжэньюй)';

  @override
  String get foreverYoungE25 =>
      '【Forever Young】 Эп. 25 | Уверенно и точно! Мартин учит невестку держать мужа в руках (Хо Цзяньхуа, Тянь Юй, Чжан Сюэин, Цяо Чжэньюй)';

  @override
  String get foreverYoungE24 =>
      '【Forever Young】 Эп. 24 | Соперник? Юнец называет Мартина «дядей» (Хо Цзяньхуа, Тянь Юй, Чжан Сюэин, Цяо Чжэньюй)';

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
  String get hOMELANDGUARDIAN => 'Защитник Родины🚔';

  @override
  String get iQIYIGetTheIQIYIAPP =>
      'iQIYI Детективы — Скачайте приложение iQIYI';

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
  String get loveHasFireworks => 'Любовь с фейерверками';

  @override
  String get getTheWeTVAPP3 =>
      'Tencent Video — Молодежный театр — Скачайте приложение WeTV';

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
  String get theHiddenHeirYeChen2 => 'Скрытый наследник Е Чэнь';

  @override
  String get xtTr8ZBDpG => 'XtTr8ZBDp-g';

  @override
  String get dresmsNeverEnd => 'Слушай ветер в поле: Мечты не кончаются';

  @override
  String get mamaGo => 'Моя мама — красавица школы: Вперёд, мама!';

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
      '«Любовь в 1970-х годах»: трогательная короткометражная хроника уже здесь~';

  @override
  String get loveStoryInThe1970s3 =>
      'Официальный релиз короткометражки «Любовь в 1970-х годах»~ Напишем любовное письмо чувствами';

  @override
  String get bTSLoveStoryInThe =>
      'За кадром | Съёмки завершены, ждём новой встречи! [Любовь в 1970-х]';

  @override
  String get loveStoryInThe1970s4 =>
      '«Любовь в 1970-х»: Любовь — это поэзия повседневности~';

  @override
  String get sGX3zNIuzM => 'SGX-3zNIuzM';

  @override
  String get loveStoryInThe1970s5 =>
      '«Любовь в 1970-х»: Официальная премьера 21 февраля~';

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
  String get theTruth => 'Следы на ветру | Истина';

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
      'За кадром | Интервью актеров: кто абсурднее — директор Гао или Хуаньэр? «Моя страница в 90-х» Tencent Video — Молодёжный театр';

  @override
  String get rEk9xALNODE => 'REk9xALNODE';

  @override
  String get label04MyPageInThe2 =>
      'Лучший момент 04: Абсурдная система драматизирует! Салфетка стала прокладкой? Вот это конфуз! «Моя страница в 90-х» Tencent Video';

  @override
  String get label03MyPageInThe2 =>
      'Лучший момент 03: Пошла на свидание вслепую вместо подруги и встретила самого главного героя? «Моя страница в 90-х» Tencent Video';

  @override
  String get xsb7BJppy0 => 'Xsb7B-Jppy0';

  @override
  String get label02MyPageInThe2 =>
      'Лучший момент 02: Хотела завоевать главного героя, но перепутала людей? «Моя страница в 90-х» Tencent Video';

  @override
  String get label01MyPageInThe2 =>
      'Лучший момент 01: Невероятно! Внезапно попала в книгу? Как играть эту роль? «Моя страница в 90-х» Tencent Video';

  @override
  String get zSpXoH9ok => 'Z_SpXo-H9ok';

  @override
  String get myPageInThe90s5 =>
      '«Моя страница в 90-х» За кадром | Чэнь Синсюй и Ван Юйвэнь столкнулись на катке';

  @override
  String get myPageInThe90s6 =>
      '«Моя страница в 90-х» Сегодня премьера! Сладкий роман Чэнь Синсюя и Ван Юйвэнь в виртуальной системе';

  @override
  String get bTSMyPageInThe5 =>
      'За кадром | Веселая химия и флирт Чэнь Синсюя и Ван Юйвэнь 【Моя страница в 90-х】';

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
  String get dearSecretary => 'Мой дорогой секретарь (Dear Secretary)';

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
  String get foreverYoung2 => '轻年 Вечно молодой';

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
  String get lightOfDawn => '人之初 Свет зари';

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
  String get sniperButterfly => '狙击蝴蝶 Снайперская бабочка';

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
      '«Снайпер и бабочка» — премьера 04.12! Переступить черту ради любви';

  @override
  String get sniperButterflyFullVersion1 =>
      '«Снайпер и бабочка» Полная версия 1-15 | В главных ролях: Чэнь Яньси, Чжоу Кэюй | Tencent Video — Молодежный театр';

  @override
  String get sniperButterflyFullVersion16 =>
      '«Снайпер и бабочка» Полная версия 16-30 | В главных ролях: Чэнь Яньси, Чжоу Кэюй | Tencent Video — Молодежный театр';

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
  String get allRise => '«Выйти на поле» All Rise';

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
      '«Тот самый человек в то самое время» Love is Always Online';

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
  String get loveOnTheTurquoiseLand => '枭起青壤 Любовь на бирюзовой земле';

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
      '«Почему он всё ещё одинок» — премьера 16.11! Романтическая сказка для взрослых с Уоллесом Хо и Чжу Чжу!';

  @override
  String get whyIsHeStillSingle3 =>
      '«Почему он всё ещё одинок» — Полная версия | В главных ролях: Уоллес Хо, Чжу Чжу | Tencent Video — Молодежный театр';

  @override
  String get ijgFlHRPHw => 'Ijg-FlHRPHw';

  @override
  String get whyIsHeStillSingle4 =>
      '«Почему он всё ещё одинок» — Полная версия 1 | В главных ролях: Уоллес Хо, Чжу Чжу | Tencent Video — Молодежный театр';

  @override
  String get whyIsHeStillSingle5 =>
      '«Почему он всё ещё одинок» — Полная версия 2 | В главных ролях: Уоллес Хо, Чжу Чжу | Tencent Video — Молодежный театр';

  @override
  String get yVGKe9xonY => 'YV-GKe9xonY';

  @override
  String get qKftsk37mXo => 'QKftsk37mXo';

  @override
  String get ccxy931pac => 'ccxy9-31pac';

  @override
  String get uc5hawjBFU => 'Uc5hawj_bFU';

  @override
  String get fightForLove => '«Сражение за любовь» (Fight for Love)';

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
  String get iMNobody => '«Я никто» (I\'m Nobody)';

  @override
  String get persona => 'Персона (重影)';

  @override
  String get d5CPVc0EIY => 'D5CPVc0E-IY';

  @override
  String get pJsHXm9ZsC => 'pJsHXm9Zs-c';

  @override
  String get vYRvNE7Yk => '-VYRvNE-7Yk';

  @override
  String get lightBeyondTheReed => 'Свет за тростником (余生有涯)';

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
  String get thePrisonerOfBeauty => 'Узница красоты (краткая версия)';

  @override
  String get wsGeYBRO => 'wsGeYB_-r_o';

  @override
  String get thePrisonerOfBeauty2 =>
      '«Узница красоты (короткая версия)»: Сяо Цяо выходит замуж за врага вместо сестры и спорит с мужем с первого дня | В главных ролях: Сун Цзуэр, Лю Юйнин | Tencent Video';

  @override
  String get thePrisonerOfBeauty3 =>
      '«Узница красоты (короткая версия)»: Сяо Цяо раскрывает заговор, и они с Вэй Шао начинают защищать друг друга | В главных ролях: Сун Цзуэр, Лю Юйнин | Tencent Video';

  @override
  String get thePrisonerOfBeauty4 =>
      '«Узница красоты (короткая версия)»: Сяо Цяо притворяется больной, а Вэй Шао защищает её и отказывается от наложниц | В главных ролях: Сун Цзуэр, Лю Юйнин | Tencent Video';

  @override
  String get thePrisonerOfBeauty5 =>
      '«Узница красоты (короткая версия)»: Сяо Цяо раскрывает обман со шкатулкой, и Вэй Шао признает её госпожой | В главных ролях: Сун Цзуэр, Лю Юйнин | Tencent Video';

  @override
  String get thePrisonerOfBeauty6 =>
      '«Узница красоты (короткая версия)»: Сяо Цяо умного раскрывает подставу, а Вэй Шао встает на защиту жены | В главных ролях: Сун Цзуэр, Лю Юйнин | Tencent Video';

  @override
  String get thePrisonerOfBeauty7 =>
      '«Узница красоты (короткая версия)»: Вэй Янь сеет рознь поддельным письмом, вызывая кризис доверия супругов | В главных ролях: Сун Цзуэр, Лю Юйнин | Tencent Video';

  @override
  String get thePrisonerOfBeauty8 =>
      '«Узница красоты (короткая версия)»: Су Эхуан пытается подставить Сяо Цяо, но Вэй Шао спасает жену и они сближаются | В главных ролях: Сун Цзуэр, Лю Юйнин | Tencent Video';

  @override
  String get thePrisonerOfBeauty9 =>
      '«Узница красоты (короткая версия)»: Сяо Цяо и Вэй Шао отравлены при покушении, но Сяо Цяо спасает мужа | В главных ролях: Сун Цзуэр, Лю Юйнин | Tencent Video';

  @override
  String get rNYFWNcb8o => 'RNYFW-Ncb8o';

  @override
  String get thePrisonerOfBeauty10 =>
      '«Узница красоты (короткая версия)»: Вэй Шао дарит шпильку и очень волнуется, когда жена пропадает | В главных ролях: Сун Цзуэр, Лю Юйнин | Tencent Video';

  @override
  String get thePrisonerOfBeauty11 =>
      '«Узница красоты (короткая версия)»: Вэй Шао ревнует Сяо Цяо, переезжает, но сразу начинает скучать по ней | В главных ролях: Сун Цзуэр, Лю Юйнин | Tencent Video';

  @override
  String get thePrisonerOfBeauty12 =>
      '«Узница красоты (короткая версия)»: Вэй Шао ревнует и несет Сяо Цяо на спине; тайны раскрыты, и они сближаются | В главных ролях: Сун Цзуэр, Лю Юйнин | Tencent Video';

  @override
  String get thePrisonerOfBeauty13 =>
      '«Узница красоты (короткая версия)»: Визит Цяо Цы вызывает ревность, но супруги откровенно признаются в любви | В главных ролях: Сун Цзуэр, Лю Юйнин | Tencent Video';

  @override
  String get thePrisonerOfBeauty14 =>
      '《Узник красоты (краткая версия)》 Вэй Янь покидает родину ради Сяо Цяо, Вэй Шао и Цяо мирятся после ссоры | В главных ролях: Сун Цзуэр, Лю Юйнин — Tencent Video';

  @override
  String get ry1BWClaV0 => 'ry1BWCla-V0';

  @override
  String get thePrisonerOfBeauty15 =>
      '《Узник красоты (краткая версия)》 Мятеж в свадебную ночь, сестры враждуют, Сяо Цяо хитростью отбивает врагов, Вэй Шао признает ошибку | В главных ролях: Сун Цзуэр, Лю Юйнин — Tencent Video';

  @override
  String get o8nFcvzyvM => 'O8n-FcvzyvM';

  @override
  String get thePrisonerOfBeauty16 =>
      '《Узник красоты (краткая версия)》 Вэй Шао сопровождает Сяо Цяо в Канцзюнь, отец Цяо признает зятя | В главных ролях: Сун Цзуэр, Лю Юйнин — Tencent Video';

  @override
  String get krsrk6wSAy8 => 'Krsrk6wSAy8';

  @override
  String get thePrisonerOfBeauty17 =>
      '《Узник красоты (краткая версия)》 Предательство Цяо Юэ, смерть Вэй Ляна, похищение Да Цяо | В главных ролях: Сун Цзуэр, Лю Юйнин — Tencent Video';

  @override
  String get v26fn6w270 => 'V-26fn6w270';

  @override
  String get thePrisonerOfBeauty18 =>
      '《Узник красоты (краткая версия)》 Вэй Лян погиб в бою, Да Цяо падает с башни, Лю Янь разгромлен | В главных ролях: Сун Цзуэр, Лю Юйнин — Tencent Video';

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
      'Слишком медленно делаю командный проект? Президент ночью лезет в окно с презентацией, а охранник гонится за ним — Tencent Video';

  @override
  String get zPBZ1KRQ3hY => 'ZPBZ1KRQ3hY';

  @override
  String get aThousandMilesToYour => 'Тысяча миль к твоему сердцу';

  @override
  String get getTheWeTVAPP4 =>
      'Tencent Video — Исторические дорамы — Скачать приложение WeTV';

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
  String get theInescapable => 'Запертая шпилька (The Inescapable)';

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
  String get pursuitOfJade2 => '逐玉 В погоне за нефритом';

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
      '«江湖夜雨十年灯 Из поколения в поколение» выйдет 22 февраля! Смотрите, как сильнейшее новое поколение Цзянху — Муму и Чжаочжао — вместе покоряет мир!';

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
  String get the300LoyalGhosts2 => '大明暗影三百忠魂 300 верных душ';

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
  String get danceOfThePhoenix => '且听凤鸣 Танец феникса';

  @override
  String get f0uIRYSOwo => 'F0uIRY_SOwo';

  @override
  String get extraordinary2 => '非凡 Необычайный';

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
      '《御赐小仵作2 Императорский коронер 2》 премьера 15 января, пара Чу Юй с теплом возвращается!';

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
  String get rebirthForYou => '嘉南传 Возрождение для тебя';

  @override
  String get f9eLAZQDUds => 'F9eLAZQDUds';

  @override
  String get aVowInTheDark2 => '恋恋风陵渡 Клятва во тьме';

  @override
  String get theUltimateVowUnknownTo => '君不知 Неизвестная вам клятва';

  @override
  String get duMRGzTeKs => 'DuM-rGzTeKs';

  @override
  String get pLs3DOuT3JlGTynSBKz3Z5DcDzwwmqSOf =>
      'PLs3DOuT3JlGTynSBKz3-z5DcDzwwmqSOf';

  @override
  String get theChangAnYouth => '长安少年行 Юность Чананя';

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
  String get thePrincessDecree2 => '平凝有令 Указ принцессы';

  @override
  String get ppiNYsUwOA => 'PpiNYs-uwOA';

  @override
  String get label83tIjIiqM => '-_83tIjIiqM';

  @override
  String get p4cKjzSHFw => 'P4cKjz-sHFw';

  @override
  String get babysitter => '我在冷宫做月嫂 Няня';

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
  String get herPhoenixMajesty2 => '凤皇传 Её Величество Феникс';

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
  String get aGirlLikeMe2 => '我就是这般女子 (Такая девушка, как я)';

  @override
  String get p4YsJ5WtBw => 'p4YsJ5Wt-bw';

  @override
  String get pIg2oXFWS8 => 'pIg2oXFWS-8';

  @override
  String get hrJz2C0Fxs => 'hrJz-2C0Fxs';

  @override
  String get mL0phSCWJY => 'mL0phSC-wJY';

  @override
  String get sideStoryOfFoxVolant2 => '飞狐外传 (Легенда о летящем лисе)';

  @override
  String get pLs3DOuT3JlGQCkd77fhalA8WxMD3OT4Q =>
      'PLs3DOuT3JlGQCkd77fhalA8Wx-mD3OT4Q';

  @override
  String get aFlowerOnTheContinent2 => '有花在洲 (Цветок на континенте)';

  @override
  String get aFlowerOnTheContinent3 =>
      '【有花在洲 A Flower On The Continent】 Молодой князь-заложник ошибочно принят девушкой Хуа за принцессу, и они вынуждены жить вместе';

  @override
  String get aFlowerOnTheContinent4 =>
      '【有花在洲 A Flower On The Continent】 Обман девушки Хуа раскрыт: молодой князь рискует жизнью, чтобы защитить её, но сам оказывается обвинён';

  @override
  String get aFlowerOnTheContinent5 =>
      '【A Flower On The Continent】 Хуа Сиюй узнаёт, что отец Нин Сюаньчжоу — убийца её отца, и мгновенно отрекается от него';

  @override
  String get aFlowerOnTheContinent6 =>
      '【A Flower On The Continent】 Хуа Сиюй в свадебном наряде врывается в лагерь врага и едва не погибает, спасая Нин Сюаньчжоу';

  @override
  String get aFlowerOnTheContinent7 =>
      '【A Flower On The Continent】 Страны подписывают мирный договор, а Нин Сюаньчжоу рвёт указ, желая жениться на Хуа Сиюй';

  @override
  String get aFlowerOnTheContinent8 =>
      '【A Flower On The Continent】 Хуа Сиюй пускает кровь ради лекарства, а Нин Сюаньчжоу обвиняет отца-императора в убийстве её отца';

  @override
  String get aFlowerOnTheContinent9 =>
      '【A Flower On The Continent】 Узнав, что отец Нин Сюаньчжоу убил её отца, Хуа Сиюй срубает символическую ветвь любви среди моря цветов';

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
  String get hilariousFamily22 => 'Весёлая семейка 2 (Hilarious Family 2)';

  @override
  String get sliceOfLife => 'Повседневность';

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
  String get legendOfTheFemaleGeneral =>
      'Легенда о девушке-генерале (Legend of The Female General)';

  @override
  String get highlightLegendOfTheFemale =>
      'Лучшие моменты: Легенда о женщине-генерале';

  @override
  String get a40F2TEZrms => 'A40F2TEZrms';

  @override
  String get lYQ5iND4 => 'lYQ5iN-d-_4';

  @override
  String get bTSLegendOfTheFemale =>
      'За кулисами: Спецвыпуск ко дню рождения Чжоу Е 🎂! [Легенда о женщине-генерале]';

  @override
  String get bTSLegendOfTheFemale2 =>
      'За кулисами: Спецвыпуск ко дню рождения Чэн Лэя 🎂! [Легенда о женщине-генерале]';

  @override
  String get bTSLegendOfTheFemale3 =>
      'За кулисами: Эффектный совместный бой звезд Великой Вэй [Легенда о женщине-генерале]';

  @override
  String get bTS520LegendOfThe =>
      'За кулисами: Идеи для романтического свидания [Легенда о женщине-генерале]';

  @override
  String get bTSLegendOfTheFemale4 =>
      'За кулисами: Милый танец с мечом пьяной Чжоу Е и улыбка Чэн Лэя [Легенда о женщине-генерале]';

  @override
  String get pLs3DOuT3JlGRucYIZLqmT7FO5IWDWrP =>
      'PLs3DOuT3JlGRuc_yIZLqmT7FO5IWD-WrP';

  @override
  String get thePrincessSGambit => 'Гамбит принцессы (The Princess\'s Gambit)';

  @override
  String get highlightThePrincessSGambit => 'Лучшие моменты: Гамбит принцессы';

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
      'Отрывок: Красное на белом снегу! Прощание Таохуа с родиной ради брата [Гамбит принцессы]';

  @override
  String get clipThePrincessSGambit2 =>
      'Отрывок: Интриги наложниц в день свадьбы и спокойный ответ Таохуа [Гамбит принцессы]';

  @override
  String get clipThePrincessSGambit3 =>
      'Отрывок: Притворство Таохуа разоблачено — Шэнь Цзайе приводит её в чувство [Гамбит принцессы]';

  @override
  String get clipThePrincessSGambit4 =>
      'Отрывок: Жёсткое расследование министра Шэня пугает коррупционеров [Гамбит принцессы]';

  @override
  String get eDrJjtCRF0 => 'eDr-jjtCRF0';

  @override
  String get clipThePrincessSGambit5 =>
      'Отрывок: Убийца в маске разоблачён: «Тебя выдали ноги!» [Гамбит принцессы]';

  @override
  String get clipPlayThePrincessS =>
      'Отрывок: Допрос со шпилькой — Шэнь Цзайе допрашивает Таохуа [Гамбит принцессы]';

  @override
  String get label58K8GxhXlQ => '58K8-gxhXlQ';

  @override
  String get clipThePrincessSGambit6 =>
      'Отрывок: 初次相见就玩这么大！沈在野桃花身中合欢散四目相对【桃花映江山 The Princess\'s Gambit】';

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
      '【Ограничено: ПОЛНАЯ версия】云襄传 | The Ingenious One | iQIYI 👑 Оформите подписку и наслаждайтесь всеми сериями прямо сейчас!';

  @override
  String get iQIYIGetTheIQIYIAPP2 => 'iQIYI 愛奇藝 - Скачайте приложение iQIYI';

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
      'iQIYI Филиппины - Скачайте приложение iQIYI';

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
      '【Английский дубляж с ИИ】Мистер Злодей | Чэнь Чжэюань, Юэ Шэнь | iQIYI Филиппины';

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
      '【FULL】🕊️My Dear Guardian | Johnny Huang, Li Qin | iQIYI Philippines';

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
      '🌸【Исцеляющий роман】🎋The Best Thing Я люблю тебя | Zhang Linghe × Xu Ruohan | ПОЛНАЯ версия | iQIYI 👑Оформите подписку и наслаждайтесь всеми сериями прямо сейчас!';

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
      '【Полный】Bright Eyes in the Dark | Джонни Хуан, Чжан Цзин И | iQIYI Филиппины';

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
      'iQIYI MOVIE THEATER - Скачайте приложение iQIYI';

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
      '🎀【Мини-драма】Английские субтитры | Полная коллекция версий | Скачайте приложение WeTV / Tencent Video, чтобы смотреть больше';

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
      '【Полный】Beauty of Resilience | Цзю Цзин И, Фантастика | iQIYI Филиппины';

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
      '🔥В тренде【子夜归 Moonlit Reunion】Все серии | Человек и демон влюбляются, разгадывая тайны | Сюй Кай, Тянь Сивэй | АНГЛ. СУБТИТРЫ';

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
  String get fallInLove => 'влюбиться';

  @override
  String get myGirl => 'My Girl';

  @override
  String get firstRomance2 => 'первый роман';

  @override
  String get fallFor => 'запасть на';

  @override
  String get uCD83JhUFQXRDwC6S8caCQ => 'UCD_83Jh-UFQXRDwC6S8caCQ';

  @override
  String get uCFh5x5AZHQQ6FaGKnGQXDA => 'UCFh5x5AZHQQ6FaGKnG-QXDA';

  @override
  String get uCRABdhiBHX4BieJfPCd2pg => 'UCRABdhiBHX4Bie-jfPCd2pg';

  @override
  String get hiddenLove2 => 'Скрытая любовь';

  @override
  String get loveBetweenFairyAndDevil2 => 'Love Between Fairy and Devil';

  @override
  String get loveLikeTheGalaxy2 => 'Love Like The Galaxy';

  @override
  String get myJourneyToYou2 => 'My Journey to You';

  @override
  String get mysteriousLotusCasebook2 => 'Mysterious Lotus Casebook';

  @override
  String get reset => 'Сбросить';

  @override
  String get theLongBallad2 => 'Длинная баллада';

  @override
  String get theUntamed2 => 'Неукротимый: Повелитель Чэньцин (The Untamed)';

  @override
  String get wordOfHonor2 => 'Длекео';

  @override
  String get lightOfDawn2 => '人之初 Light of Dawn';

  @override
  String get hOMELANDGUARDIAN2 => '守诚者 | HOMELAND GUARDIAN';

  @override
  String get searching2 => 'Searching...';

  @override
  String get verse => 'Verse';

  @override
  String get allStories2 => 'Все истории';

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
  String get char2 => '+ симв +';

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
      'статья, .article, .post, .content, главная';

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
  String get minutesDay => 'Минут / День';

  @override
  String get consistencyIsTheInkThat =>
      '«Постоянство — это чернила, создающие характер».';

  @override
  String get businessCareer => 'Бизнес и карьера';

  @override
  String get travelSurvival => 'Путешествия и выживание';

  @override
  String get label05MinDay => '05 Min / Day';

  @override
  String get label10MinDay => '10 Min / Day';

  @override
  String get label20MinDay => '20 Min / Day';

  @override
  String get label30MinDay => '30 Min / Day';

  @override
  String get dynamicDecksStrokeAnalysis => 'Динамические колоды и анализ черт';

  @override
  String get subscriptionsAreTemporarilyUnavailablePl =>
      'Подписки временно недоступны. Пожалуйста, попробуйте снова.';

  @override
  String get trialReminder => 'Напоминание о пробном периоде';

  @override
  String get turnOnNotificationsIfYou =>
      'Включите уведомления, если вы хотите получить напоминание до истечения срока действия соответствующей пробной версии. Настройки вашей подписки в App Store остаются источником истины.';

  @override
  String get label2Months => '2 месяца';

  @override
  String get label3Months => '3 месяца';

  @override
  String get label6Months => '6 месяцев';

  @override
  String get billingPeriod => 'расчетный период';

  @override
  String get chooseASubscription => 'Выберите подписку';

  @override
  String get startFreeTrial => 'Начать бесплатный пробный период';

  @override
  String get smartNewsDict => 'Умные новости и словарь';

  @override
  String get hSK16AIDecks => 'HSK 1-6 и колоды с ИИ';

  @override
  String get continueWithTemporaryPremium => 'Продолжить с временным Премиумом';

  @override
  String get testProductUnavailable => 'Тестовый продукт недоступен';

  @override
  String get paymentIsChargedToYour =>
      'Платеж будет списан с вашей учетной записи App Store.';

  @override
  String get subscriptionsRenewAutomaticallyUnlessCan =>
      'Подписки продлеваются автоматически, если их не отменить';

  @override
  String get atLeast24HoursBefore =>
      'по крайней мере за 24 часа до окончания текущего периода.';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get closePurchaseOffer => 'Закрыть предложение о покупке';

  @override
  String get loading => 'Loading...';

  @override
  String get analyzingImage2 => 'Анализ изображения…';

  @override
  String get extractingChineseText2 => 'Извлечение китайского текста...';

  @override
  String get lookingUpVocabulary2 => 'Поиск словаря...';

  @override
  String get deselectAll => 'Снять выделение со всего';

  @override
  String get selectAll => 'Выбрать все';

  @override
  String get worldChineseLiteraryMasterpiece =>
      'Мировой и китайский литературный шедевр.';

  @override
  String get classic => 'Классический';

  @override
  String get literature => 'Литература';

  @override
  String get theOriginAwakening => 'Истоки и пробуждение';

  @override
  String get turbulentHorizonsTheJourney =>
      'Турбулентные горизонты и путешествие';

  @override
  String get trialsTribulationsDevotion => 'Испытания, невзгоды и преданность';

  @override
  String get theClashOfWitsBravery => 'Столкновение ума и отваги';

  @override
  String get theGrandClimaxResolution => 'Великая кульминация и развязка';

  @override
  String get everlastingLegacyEpilogue => 'Вечное наследие и эпилог';

  @override
  String get acrossTheVastExpanseOf =>
      'На просторах неба и земли персонажи идут к своей судьбе и убеждениям через глубокие испытания.';

  @override
  String get everyDialogueAndEncounterWithin =>
      'Каждый диалог и встреча в этой истории несут в себе блеск человеческого духа и печать своей эпохи.';

  @override
  String get followingTheFlowOfProse =>
      'Следуя за течением прозы, читатели преодолевают века, чтобы разделить триумфы и печали легендарных фигур.';

  @override
  String get preQin => 'pre-qin';

  @override
  String get theGoddessNWaRepairing => 'Богиня Нюйва латает небо';

  @override
  String get artsTraditions => 'Искусство и традиции';

  @override
  String get femaleWarm => 'Женский, мягкий';

  @override
  String get femaleCheerful => 'Женский, жизнерадостный';

  @override
  String get maleUpbeat => 'Мужской, бодрый';

  @override
  String get maleNewsStyle => 'Male, news-style';

  @override
  String get maleSporty => 'Мужской, спортивный';

  @override
  String get onDevice => 'On-device';

  @override
  String get label15Minutes => '15 минут';

  @override
  String get label30Minutes => '30 минут';

  @override
  String get label45Minutes => '45 минут';

  @override
  String get selectChapter => 'Выберите главу';

  @override
  String get andContinuesToBeStudied =>
      'и продолжает изучаться и отмечаться читателями из поколения в поколение.';

  @override
  String get label1Poem => '1 стихотворение';

  @override
  String get label1Chapter => '1 глава';

  @override
  String get localDeviceVoice2 => 'Голос локального устройства';

  @override
  String get weeklyAzureQuotaReachedSwitching =>
      'Достигнута недельная квота Azure — переключение на локальный голос';

  @override
  String get sleepTimer2 => 'Таймер сна · Sleep Timer';

  @override
  String get tableOfContents2 => 'Оглавление · Table of Contents';

  @override
  String get hanziMaster10 => 'HanziMaster/1.0';

  @override
  String get spanishItalianRussianClassics =>
      'Испанская, итальянская и русская классика';

  @override
  String get englishAmericanGlobalClassics =>
      'Английские, американские и мировые классические произведения';

  @override
  String get whileStrategicallyEmbeddingWordsYou =>
      'при этом стратегически внедряя слова, с которыми у вас возникают трудности, чтобы вы могли изучать их в контексте.';

  @override
  String get poetryPainting => 'poetry-painting';

  @override
  String get contactSinosparkCom => 'contact@sinospark.com';

  @override
  String get shadowingStudioIsADedicated =>
      'Студия теневого повтора — это место для практики имитации речи носителей языка. Слушайте фразу, записывайте своё повторение и сравнивайте звуковые волны и оценки произношения, чтобы улучшить акцент.';

  @override
  String get theVoicesInAIStories =>
      'Озвучка в «ИИ-историях» и «Эхо-зале» работает на основе нейросетевых моделей синтеза речи. Они настроены для передачи аутентичного китайского произношения, правильных эмоций и естественного темпа.';

  @override
  String get theWebExplorerAllowsYou =>
      'Веб-браузер позволяет просматривать любые китайские сайты. Нажмите на незнакомое слово, чтобы открыть карточку быстрого просмотра с пиньинем, переводом и уровнем HSK.';

  @override
  String get zenModeStripsAwayDistracting =>
      'Режим «Дзен» убирает лишние элементы сайтов, рекламу и сложную верстку, создавая чистое каллиграфическое пространство, сосредоточенное только на тексте.';

  @override
  String get weUseAnIntelligentAlgorithm =>
      'Интеллектуальный алгоритм предсказывает, когда вы можете забыть слово. Сложные слова будут появляться чаще, а хорошо знакомые — откладываться на более долгий срок.';

  @override
  String get usage3 => 'Использование:';

  @override
  String get tutorialOneExplanation =>
      'Это «ОДИН» (Yī). Всегда пишите слева направо.';

  @override
  String get tutorialWaterExplanation =>
      'Это полный иероглиф «ВОДА» (Shuǐ). В качестве левого ключа он превращается в «氵» (Три капли)!';

  @override
  String get tutorialRadicalsExplanation =>
      'Иероглифы состоят из базовых элементов — КЛЮЧЕЙ. Они передают основной смысл или тему знака.';

  @override
  String get tutorialLettersExplanation =>
      'Иероглифы — это не просто буквы. Это застывшие во времени картины. Чтобы освоить их, нужно почувствовать порядок черт.';

  @override
  String get tutorialGalaxyExplanation =>
      'Карта Галактики ждёт. Осваивайте Солнца (Ключи), чтобы открыть Планеты (Иероглифы).';

  @override
  String get onboardingDailyLifeTravel => 'Повседневная жизнь и путешествия';

  @override
  String get onboardingPhilosophyIdioms => 'Философия и идиомы';

  @override
  String get onboardingBusinessCareerMulti => 'Бизнес и\nкарьера';

  @override
  String get onboardingTravelSurvivalMulti => 'Путешествия и\nвыживание';

  @override
  String get onboardingHskCertificationMulti => 'Сертификация\nHSK';

  @override
  String get onboardingCulturalAppreciationMulti => 'Понимание\nкультуры';

  @override
  String get practiceReminders => 'Напоминания о практике';

  @override
  String get oneOptionalDailyReminderTo =>
      'Одно необязательное напоминание в день о практике китайского';

  @override
  String get aFewMinutesOfChinese => 'Несколько минут китайского? 🌱';

  @override
  String get keepYourProgressMovingWith =>
      'Продолжайте прогрессировать с помощью короткой тренировки.';

  @override
  String get xuX => 'xué xí';

  @override
  String get toStudyToLearn => 'учиться · изучать';

  @override
  String get pNgYou => 'péng you';

  @override
  String get fXiN => 'fā xiàn';

  @override
  String get toDiscover => 'открывать';

  @override
  String get jiNCh => 'jiān chí';

  @override
  String get toPersist => 'проявлять упорство';

  @override
  String get yNgQ => 'yǒng qì';

  @override
  String get zhHu => 'zhì huì';

  @override
  String get chNgZhNg => 'chéng zhǎng';

  @override
  String get toGrow => 'расти';

  @override
  String get pNgJNg => 'píng jìng';

  @override
  String get calmPeaceful => 'спокойный · умиротворённый';

  @override
  String get xWNg => 'xī wàng';

  @override
  String get lJi => 'lǐ jiě';

  @override
  String get toUnderstand => 'понимать';

  @override
  String get xGuN => 'xí guàn';

  @override
  String get wNNuN => 'wēn nuǎn';

  @override
  String get warmthWarm => 'тепло · тёплый';

  @override
  String get zhuNZh => 'zhuān zhù';

  @override
  String get toFocus => 'сосредотачиваться';

  @override
  String get definitionExpansionButton => 'кнопка раскрытия определения';

  @override
  String get wenigerAnzeigen => 'Показать меньше';

  @override
  String get mostrarMenos => 'Показать меньше';

  @override
  String get afficherMoins => 'Показать меньше';

  @override
  String get mostraMeno => 'Показать меньше';

  @override
  String get showFewer => 'Показать меньше';

  @override
  String get masterLin => 'Мастер Лин';

  @override
  String get xiaoMei => 'Сяо Мэй';

  @override
  String get thePoet => 'Поэт';

  @override
  String get aQiang => 'А-Цян';

  @override
  String get vivian => 'Вивьен';

  @override
  String get formalWise => 'Официальный и мудрый';

  @override
  String get casualFriendly => 'Неформальный и дружелюбный';

  @override
  String get poeticAncient => 'Поэтичный и старинный';

  @override
  String get slangInternet => 'Сленг и интернет';

  @override
  String get trendyModern => 'Современный и трендовый';

  @override
  String get designYourOwn => 'Создать свой';

  @override
  String get theBambooSwaysAndThe =>
      'Бамбук колышется, и ученый ждет ваших слов, как утреннего дождя...';

  @override
  String get yourCustomPersonaIsActive =>
      'Ваш персонаж активен. Напишите что-нибудь, чтобы начать общение.';

  @override
  String get hHMm => 'ЧЧ:мм';

  @override
  String get fROMLocalizedDefinitionQualityWHERE =>
      'FROM localized_definition_quality WHERE language_code = ?';

  @override
  String get gemini25Flash => 'gemini-2.5-flash';

  @override
  String get dictionaryExpansionV1 => 'dictionary-expansion-v1';

  @override
  String get staleDictionaryExpansionResponse =>
      'Устаревший ответ расширения словаря';

  @override
  String get dictionaryExpansionWasEmpty => 'Пустой ответ расширения словаря';

  @override
  String get explicationDTaillEDisponible => 'Доступно подробное объяснение';

  @override
  String get ausfHrlicheErklRungVerf => 'Доступно подробное объяснение';

  @override
  String get explicaciNDetalladaDisponible => 'Доступно подробное объяснение';

  @override
  String get spiegazioneDettagliataDisponibile =>
      'Доступно подробное объяснение';

  @override
  String get explicaODetalhadaDisponVel => 'Доступно подробное объяснение';

  @override
  String get detailedExplanationAvailable => 'Доступно подробное объяснение';

  @override
  String get oneOptionalDailyPracticeReminder =>
      'Одно необязательное ежедневное напоминание';

  @override
  String get chooseOneOptionalDailyPractice =>
      'Выберите одно необязательное ежедневное напоминание.';

  @override
  String get practiceReminder => 'Напоминание об уроках';

  @override
  String get oneGentleReminderADay =>
      'Одно ненавязчивое напоминание в день — только если нужно';

  @override
  String get finishingPracticeSilencesTodayS =>
      'Выполнение урока отключает сегодняшнее напоминание. Повторения и';

  @override
  String get reEngagementAlertsAreCombined =>
      'напоминания объединены, чтобы не накапливаться.';

  @override
  String get processing2 => 'Обработка…';

  @override
  String get wDKIChu => 'wǒ dǎ kāi chuāng hu';

  @override
  String get listen => 'Слушать';

  @override
  String get notice => 'Обратите внимание';

  @override
  String get fourTones => 'Четыре тона';

  @override
  String get write => 'Написать';

  @override
  String get recap => 'Итоги';

  @override
  String get playbackDidNotStart => 'Воспроизведение не началось';

  @override
  String get audioIsUnavailableYouCan =>
      'Аудио недоступно. Вы можете читать текст и продолжать.';

  @override
  String get microphoneAccessWasNotGranted =>
      'Нет доступа к микрофону. Вы можете использовать тихий режим ниже.';

  @override
  String get recordingIsUnavailableRightNow => 'Запись сейчас недоступна.';

  @override
  String get listeningToYourTones => 'Слушаем ваши тоны…';

  @override
  String get noRecording => 'Запись отсутствует';

  @override
  String get weCouldNotScoreThat =>
      'Не удалось оценить запись, поэтому вот пример сравнения тонов.';

  @override
  String get listenForTheLowDipping =>
      'Обратите внимание на низкий, нисходяще-восходящий третий тон.';

  @override
  String get firstHearATinyMoment =>
      'Сначала просто послушайте короткий фрагмент. Запоминать пока не нужно.';

  @override
  String get loadingAudio => 'Загрузка аудио…';

  @override
  String get listenToThePassage => 'Прослушайте отрывок';

  @override
  String get continueAction => 'Продолжить';

  @override
  String get noticeHowMeaningSoundAnd =>
      'Обратите внимание, как объединяются значение, звучание и иероглифы.';

  @override
  String get shadowOneSentence => 'Повторите одно предложение за диктором';

  @override
  String get listenOnceThenHoldThe =>
      'Послушайте один раз, затем зажмите микрофон и произнесите предложение.';

  @override
  String get hearItAgain => 'Прослушать снова';

  @override
  String get stopAndCheckMyTones => 'Остановить и проверить тоны';

  @override
  String get useMicrophone => 'Использовать микрофон';

  @override
  String get iCanTSpeakRight => 'Не могу говорить сейчас';

  @override
  String get tapACharacterToCompare =>
      'Нажмите на иероглиф, чтобы сравнить произнесенный тон с эталоном и прослушать тоны 1–4.';

  @override
  String get tryHandwriting => 'Попробовать письмо';

  @override
  String get seeWhatYouLearned => 'Посмотреть, что вы изучили';

  @override
  String get inAFewMinutesYou =>
      'За несколько минут вы прошли тот же цикл, на котором строятся ваши уроки.';

  @override
  String get listenedToChineseInContext =>
      'Послушали китайскую речь в контексте';

  @override
  String get shadowedASentence => 'Повторили предложение за диктором';

  @override
  String get comparedMandarinTones => 'Сравнили тоны в китайском';

  @override
  String get practicedARealCharacter => 'Потренировали написание иероглифа';

  @override
  String get qNgchNXiOy =>
      'Qīngchén, xiǎoyǔ tíng le. Wǒ dǎkāi chuānghu, tīngjiàn niǎor zài shù shàng chànggē. Xīn de yì tiān kāishǐ le.';

  @override
  String get atDawnTheLightRain =>
      'Ранним утром мелкий дождь утих. Я открыл окно и услышал пение птиц на деревьях. Начался новый день.';

  @override
  String get learnThroughRealVideos => 'Учитесь по настоящим видео';

  @override
  String get followInteractiveSubtitlesLookUp =>
      'Следите за интерактивными субтитрами, мгновенно ищите слова и превращайте любое видео в урок.';

  @override
  String get videoLearningScreenshot => 'Скриншот: видеообучение';

  @override
  String get turnAnyBookIntoA => 'Превратите любую книгу в урок';

  @override
  String get readNaturallyWithPronunciationDefinition =>
      'Читайте с легкостью: произношение, определения и перевод всегда под рукой.';

  @override
  String get bookReaderScreenshot => 'Скриншот: чтение книг';

  @override
  String get speakWithTheRightRhythm => 'Говорите с правильным ритмом';

  @override
  String get shadowNativeAudioAndVisualize =>
      'Повторяйте за носителем языка и наглядно отслеживайте все четыре тона.';

  @override
  String get shadowingAndTonesScreenshot => 'Скриншот: повторение и тоны';

  @override
  String get understandEveryCharacter => 'Понимайте каждый иероглиф';

  @override
  String get exploreMeaningPronunciationComponentsStr =>
      'Значение, произношение, элементы, порядок черт и полезная лексика — всё в одном месте.';

  @override
  String get characterDictionaryScreenshot => 'Скриншот словаря иероглифов';

  @override
  String get learnChineseWithoutLimits => 'Изучайте китайский без ограничений';

  @override
  String get watchReadSpeakAndUnderstand =>
      'Смотрите, читайте, говорите и понимайте по-китайски с универсальным помощником.';

  @override
  String get seeWhatPremiumUnlocks => 'Узнайте, что открывает Premium';

  @override
  String get scrollToExploreTheComplete =>
      'Прокрутите, чтобы ознакомиться со всеми возможностями';

  @override
  String get cOMINGSOON => 'СКОРО';

  @override
  String get guidedHandwritingPractice => 'Практика письма с подсказками';

  @override
  String get scannerAndLiveTranslation => 'Сканер и мгновенный перевод';

  @override
  String get hSK16AndAI => 'HSK 1–6 и ИИ-колоды';

  @override
  String get smartSpacedRepetition2 => 'Умное интервальное повторение';

  @override
  String get progressAndStreakTracking => 'Отслеживание прогресса и серий';

  @override
  String get learningToolsInOnePlace => 'Инструменты обучения в одном месте';

  @override
  String get everythingIncluded => 'Всё включено';

  @override
  String get paymentIsChargedToYour2 =>
      'Оплата списывается с вашего аккаунта App Store. Подписка продлевается автоматически, если она не была отменена хотя бы за 24 часа до окончания текущего периода.';

  @override
  String get yourFirstWeekOfTracked =>
      'Ваша первая неделя занятий со статистикой';

  @override
  String get sameNumberOfCardsAs =>
      'Столько же карточек, сколько на прошлой неделе';

  @override
  String cardsComparedWithLastWeek(String change) {
    return '$change карточек по сравнению с прошлой неделей';
  }

  @override
  String get todaySPractice => 'Практика на сегодня';

  @override
  String get goalCompleteAnythingMoreIs =>
      'Цель достигнута — остальное уже бонус.';

  @override
  String get aSmallAchievableTargetNo =>
      'Небольшая, достижимая цель. Без штрафов за день отдыха.';

  @override
  String get thisWeek => 'На этой неделе';

  @override
  String get minutes => 'Минуты';

  @override
  String get activeDays => 'Дни активности';

  @override
  String dayStreakCount(int count) {
    return 'Серия: $count дней';
  }

  @override
  String get masterChineseOneStrokeAt => 'Осваивайте китайский черта за чертой';

  @override
  String get dictionaryExpansionButton => 'dictionary-expansion-button';

  @override
  String get kIErweiterterWRterbucheintrag => 'Расширенная словарная статья ИИ';

  @override
  String get detalleAmpliadoPorIA => 'Расширенная словарная статья ИИ';

  @override
  String get dTailEnrichiParL => 'Расширенная словарная статья ИИ';

  @override
  String get aI => 'Расширенная словарная статья ИИ';

  @override
  String get detailKamusYangDiperluasAI => 'Расширенная словарная статья ИИ';

  @override
  String get dettaglioDelDizionarioAmpliatoDall =>
      'Расширенная словарная статья ИИ';

  @override
  String get aI2 => 'Расширенная словарная статья ИИ';

  @override
  String get aI3 => 'Расширенная словарная статья ИИ';

  @override
  String get detalheDeDicionRioExpandido => 'Расширенная словарная статья ИИ';

  @override
  String get aI4 => 'Расширенная словарная статья ИИ';

  @override
  String get chiTiTTI => 'Расширенная словарная статья ИИ';

  @override
  String get aI5 => 'Расширенная словарная статья ИИ';

  @override
  String get aIExpandedDictionaryDetail => 'Расширенная словарная статья ИИ';

  @override
  String get cetteEntrEEstBr =>
      'Эта словарная статья краткая. Доступно подробное объяснение.';

  @override
  String get dieserEintragIstKurzEine =>
      'Эта словарная статья краткая. Доступно подробное объяснение.';

  @override
  String get estaEntradaEsBreveHay =>
      'Эта словарная статья краткая. Доступно подробное объяснение.';

  @override
  String get questaVoceBreveDisponibileUna =>
      'Эта словарная статья краткая. Доступно подробное объяснение.';

  @override
  String get estaEntradaBreveEstDispon =>
      'Эта словарная статья краткая. Доступно подробное объяснение.';

  @override
  String get thisDictionaryEntryIsBrief =>
      'Эта словарная статья краткая. Доступно подробное объяснение.';

  @override
  String get dVelopperEnFranAis => 'Раскрыть на французском';

  @override
  String get aufDeutschErweitern => 'Раскрыть на немецком';

  @override
  String get ampliarEnEspaOl => 'Раскрыть на испанском';

  @override
  String get approfondisciInItaliano => 'Раскрыть на итальянском';

  @override
  String get expandirEmPortuguS => 'Раскрыть на португальском';

  @override
  String get expandDefinition => 'Расширить определение';

  @override
  String get impossibleDeChargerLExplication =>
      'Не удалось загрузить объяснение.';

  @override
  String get dieErklRungKonnteNicht => 'Не удалось загрузить объяснение.';

  @override
  String get noSePudoCargarLa => 'Не удалось загрузить объяснение.';

  @override
  String get impossibileCaricareLaSpiegazione =>
      'Не удалось загрузить объяснение.';

  @override
  String get nOFoiPossVel => 'Не удалось загрузить объяснение.';

  @override
  String get unableToLoadTheExplanation => 'Не удалось загрузить объяснение.';

  @override
  String get failedToGenerateStoryN => 'Не удалось создать историю:\\n\$e';

  @override
  String get thematic => 'Тематический';

  @override
  String get deckFlashcards => 'Колода (Карточки)';

  @override
  String get searchLibraryOrTypeCustom => 'Искать в библиотеке или ввести свое';

  @override
  String get hSKLevel => 'HSK \$level';

  @override
  String get analysisFailedE => 'Ошибка анализа: \$e';

  @override
  String get extractionFailedE => 'Ошибка извлечения: \$e';

  @override
  String get simplifyFailedE => 'Не удалось упростить: \$e';

  @override
  String get translationFailedE => 'Ошибка перевода: \$e';

  @override
  String get failedToSaveExtractedWords2 =>
      'Не удалось сохранить извлеченные слова: \$error';

  @override
  String get youActualTargetExpected => 'Вы: \$actual  ·  Цель: \$expected';

  @override
  String get improveTheLocalVoice => 'Улучшить локальный голос';

  @override
  String get higherQualityOfflineMandarin =>
      'Высококачественный китайский оффлайн';

  @override
  String get removeDownload => 'Удалить загрузку?';

  @override
  String get removeDownload2 => 'Удалить загрузку';

  @override
  String get tag => '#\$tag';

  @override
  String get voiceFemaleWarm => 'Женский, тёплый';

  @override
  String get voiceFemaleCheerful => 'Женский, бодрый';

  @override
  String get voiceMaleUpbeat => 'Мужской, энергичный';

  @override
  String get voiceMaleNewsStyle => 'Мужской, дикторский';

  @override
  String get voiceMaleSporty => 'Мужской, спортивный';

  @override
  String get voiceOnDeviceTts => 'Синтез речи на устройстве';

  @override
  String get voiceSystemVoice => 'Системный голос';

  @override
  String get applySessionGradesToSpacedRepetition =>
      'Применить результаты сессии к интервальным повторениям (режим говорения)';

  @override
  String get unableToLoadThisSectionPleaseTryAgain =>
      'Не удалось загрузить этот раздел. Пожалуйста, попробуйте снова.';

  @override
  String get removeDownloadQuestion => 'Удалить загрузку?';

  @override
  String get removeDownloadContent => 'Remove downloaded content?';

  @override
  String get removeDownloadAction => 'Удалить загрузку';

  @override
  String get removeDownloadButton => 'Удалить загрузку';

  @override
  String cardsCount(num count) {
    return '$count Cards';
  }

  @override
  String get aiSummary => 'Сводка ИИ';

  @override
  String get readability => 'Читаемость';
}
