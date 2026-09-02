// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

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
  String get deleteAccount => 'حذف الحساب';

  @override
  String get deleteAccountSubtitle => 'حذف حسابك نهائيًا';

  @override
  String get deleteAccountTitle => 'هل تريد حذف حسابك نهائيًا؟';

  @override
  String get accountDataDeletedTitle => 'سيتم حذف بيانات الحساب';

  @override
  String get accountDataDeletedBody =>
      'سيتم حذف حساب تسجيل الدخول ومعلومات الحساب التي تحتفظ بها SinoSpark نهائيًا. لا يمكن التراجع عن ذلك.';

  @override
  String get localDataKeptTitle => 'ستبقى البيانات الموجودة على هذا الجهاز';

  @override
  String get localDataKeptBody =>
      'لن تتم إزالة تقدم الدراسة والمحتوى المحمّل والتفضيلات المخزنة على هذا الجهاز فقط.';

  @override
  String get subscriptionNotCanceledTitle => 'لن يتم إلغاء الاشتراكات';

  @override
  String get subscriptionNotCanceledBody =>
      'حذف حسابك لا يلغي اشتراك App Store، وقد يستمر في التجدد حتى تلغيه لدى Apple.';

  @override
  String get manageSubscription => 'إدارة اشتراك App Store';

  @override
  String get subscriptionManagementFailed =>
      'تعذر فتح إدارة اشتراكات Apple. افتح الإعدادات، واضغط على اسمك، ثم الاشتراكات.';

  @override
  String get confirmPassword => 'كلمة المرور الحالية';

  @override
  String get confirmPasswordToDelete => 'أدخل كلمة المرور لتأكيد هويتك.';

  @override
  String get deleteAccountPermanently => 'حذف الحساب نهائيًا';

  @override
  String get deleteAccountFinalTitle => 'التأكيد النهائي';

  @override
  String get deleteAccountFinalWarning =>
      'سيؤدي هذا إلى حذف حسابك نهائيًا ولا يمكن التراجع عنه. ستبقى البيانات المخزنة على هذا الجهاز فقط. هل تريد المتابعة؟';

  @override
  String get deletingAccount => 'جارٍ حذف الحساب...';

  @override
  String get accountPasswordRequired => 'أدخل كلمة المرور الحالية للمتابعة.';

  @override
  String get accountPasswordIncorrect =>
      'كلمة المرور غير صحيحة. حاول مرة أخرى.';

  @override
  String get accountReauthenticationCanceled =>
      'تم إلغاء تأكيد الهوية. لم يتم حذف حسابك.';

  @override
  String get accountReauthenticationFailed =>
      'تعذر تأكيد هويتك. حاول مرة أخرى وأكمل مطالبة تسجيل الدخول.';

  @override
  String get accountAlreadySignedOut =>
      'لقد سجلت الخروج بالفعل. لم يتم حذف أي حساب.';

  @override
  String get accountProviderUnsupported =>
      'لا يمكن التحقق من طريقة تسجيل الدخول هذه داخل التطبيق. اتصل بالدعم للمساعدة.';

  @override
  String get appleDeletionRequiresAppleDevice =>
      'لأسباب أمنية، يجب حذف الحساب المرتبط بـ Apple على جهاز Apple.';

  @override
  String get accountDeletionNetworkError =>
      'تحقق من اتصال الإنترنت وحاول حذف الحساب مرة أخرى.';

  @override
  String get accountDeletionFailed =>
      'تعذر حذف الحساب. لا يزال حسابك نشطًا. حاول مرة أخرى.';

  @override
  String get accountDeletedSuccessfully => 'تم حذف حسابك نهائيًا.';

  @override
  String get globalMastery => 'الإتقان الشامل';

  @override
  String get masteredCards => 'مُتقَن';

  @override
  String get hsk1Candidate => 'مرشح HSK 1';

  @override
  String get hsk2Candidate => 'مرشح HSK 2';

  @override
  String get hsk3Candidate => 'مرشح HSK 3';

  @override
  String get hsk4Candidate => 'مرشح HSK 4';

  @override
  String get hsk5Candidate => 'مرشح HSK 5';

  @override
  String get hsk6Candidate => 'مرشح HSK 6';

  @override
  String get hsk6Master => 'خبير HSK 6';

  @override
  String get currentRank => 'الرتبة الحالية';

  @override
  String get next => 'التالي';

  @override
  String get searchHanziOrPinyin => 'ابحث عن هانزي أو بينيين...';

  @override
  String get dailyReview => 'المراجعة اليومية';

  @override
  String get upcomingForecast => 'التوقعات القادمة';

  @override
  String get laterToday => 'لاحقاً اليوم';

  @override
  String get tomorrow => 'غداً';

  @override
  String get next7Days => 'الأيام السبعة القادمة';

  @override
  String get theScholarWay => 'طريق العالِم';

  @override
  String get beginJourney => 'ابدأ الرحلة';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get darkModeDesc => 'مريح للعين';

  @override
  String get voiceSpeed => 'سرعة الصوت';

  @override
  String get artAndIntellect => 'الفن والفكر';

  @override
  String get theDigitalScholar => 'العالِم الرقمي';

  @override
  String get refineBrushVoice =>
      'حسّن مهارات الفرشاة والصوت مع الذكاء الاصطناعي.';

  @override
  String get liveVoiceCall => 'مكالمة صوتية مباشرة';

  @override
  String get immersiveRoleplay => 'لعب أدوار غامر مع الذكاء الاصطناعي';

  @override
  String get readingRoom => 'غرفة القراءة';

  @override
  String get shadowingStudio => 'استوديو المحاكاة الصوتية (Shadowing)';

  @override
  String get errorPrefix => 'خطأ: ';

  @override
  String get initializingLibrary => 'جارٍ التهيئة...';

  @override
  String get unlockCharactersToQuiz => 'افتح 4 رموز للاختبار!';

  @override
  String get practiceQuiz => 'اختبار';

  @override
  String get curriculumPaths => 'مسارات المناهج';

  @override
  String get noDecksFound => 'لا توجد مجموعات.';

  @override
  String get addCardsFirst => 'أضف بطاقات أولاً!';

  @override
  String get aiDraftingPath => 'الذكاء الاصطناعي يجهز مسارك...';

  @override
  String get pathReady => 'مسارك جاهز!';

  @override
  String get errorGeneratingPath => 'خطأ في إنشاء المسار';

  @override
  String get brushingCurriculum => 'إنشاء المسار...';

  @override
  String get warmUp => 'إحماء';

  @override
  String get lessonComplete => 'اكتمل الدرس! +10 نقاط حبر';

  @override
  String get step1Origin => 'الخطوة 1: الأصل';

  @override
  String get traceRadical => 'تتبع الجذر';

  @override
  String get step2Forge => 'الخطوة 2: الصياغة';

  @override
  String get chooseEssence => 'اختر الجوهر';

  @override
  String get wrongEssence => 'خطأ! حاول مرة أخرى.';

  @override
  String get step3Hunt => 'الخطوة 3: البحث';

  @override
  String get findCharacters => 'ابحث عن الرموز';

  @override
  String get notThatOne => 'ليس هذا!';

  @override
  String get successfullyInstalled => 'تم التثبيت:';

  @override
  String get failedToDownload => 'فشل التنزيل.';

  @override
  String get rescindTitle => 'إلغاء؟';

  @override
  String get removeCharactersWarning => 'سيؤدي هذا إلى إزالة هذه الرموز.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get uninstall => 'إلغاء التثبيت';

  @override
  String get removedLibrary => 'تمت الإزالة:';

  @override
  String get tomeLibrary => 'مكتبة المجلدات';

  @override
  String get libraryError => 'خطأ في المكتبة';

  @override
  String get installTome => 'تثبيت';

  @override
  String get unitIntro => 'مقدمة الوحدة';

  @override
  String get constellationCluster => 'عنقود الكوكبات';

  @override
  String get ok => 'حسناً';

  @override
  String get divingInto => 'الانتقال إلى...';

  @override
  String get keyRadicals => 'الجذور الرئيسية';

  @override
  String get noRadicalData => 'لا توجد بيانات.';

  @override
  String get discovery => 'اكتشاف';

  @override
  String get startLearning => 'ابدأ التعلم';

  @override
  String get selectPersona => 'اختر الشخصية';

  @override
  String get customPersona => 'شخصية مخصصة';

  @override
  String get geminiLiveCall => 'مكالمة مباشرة';

  @override
  String get returnToMenu => 'عودة إلى القائمة';

  @override
  String get strokeAnalysis => 'تحليل ترتيب الخطوط';

  @override
  String get excellentWork => 'عمل ممتاز!';

  @override
  String get keepPracticing => 'واصل التدريب!';

  @override
  String get drawingSubmitted => 'تم إرسال الرسم';

  @override
  String get customPersonaHint => 'حدد شخصية مخصصة...';

  @override
  String get stepOneOrigin => 'الخطوة 1: الأصل';

  @override
  String get stepTwoForge => 'الخطوة 2: الصياغة';

  @override
  String get toForge => 'للصياغة';

  @override
  String get whatEssenceDoesNeed => 'ما هو الجوهر الذي';

  @override
  String get need => 'يحتاجه';

  @override
  String get forged => 'تمت الصياغة';

  @override
  String get stepThreeHunt => 'الخطوة 3: البحث';

  @override
  String get findCharactersWith => 'ابحث عن الرموز التي تحتوي على';

  @override
  String get uninstallButton => 'إلغاء التثبيت';

  @override
  String get gradedAiStories => 'قصص متدرجة بالذكاء الاصطناعي';

  @override
  String get calligraphy => 'فن الخط';

  @override
  String get theScrollOfOrigin => 'لفافة الأصل';

  @override
  String get galaxyOf => 'مجرة';

  @override
  String get constellationDescription => 'وصف الكوكبة';

  @override
  String get noRadicalDataAvailable => 'لا تتوفر بيانات عن الجذر';

  @override
  String get learningPreferences => 'تفضيلات التعلم';

  @override
  String get hardMode => 'الوضع الصعب';

  @override
  String get hardModeDesc => 'وصف الوضع الصعب';

  @override
  String get adaptiveGuidance => 'التوجيه التكيفي';

  @override
  String get dailyGoal => 'الهدف اليومي';

  @override
  String get audioAndHaptics => 'الصوت والاستجابة اللمسية';

  @override
  String get autoPlayAudio => 'تشغيل الصوت تلقائيًا';

  @override
  String get autoPlayDesc => 'تشغيل النطق تلقائيًا عند عرض البطاقة';

  @override
  String get haptics => 'الاستجابة اللمسية';

  @override
  String get displayAndContent => 'العرض والمحتوى';

  @override
  String get useEnglishDefinitions => 'استخدام التعريفات الإنجليزية';

  @override
  String get useEnglishDefinitionsDesc =>
      'التعريفات الإنجليزية أكثر دقة وتفصيلاً بشكل عام';

  @override
  String get animationSpeed => 'سرعة الحركة';

  @override
  String get manageTomes => 'إدارة المجلدات';

  @override
  String get manageTomesDesc => 'عرض وإدارة المجلدات المثبتة';

  @override
  String get dangerZone => 'منطقة الخطر';

  @override
  String get resetAllData => 'إعادة تعيين جميع البيانات';

  @override
  String get resetDataDesc =>
      'سيؤدي هذا إلى حذف جميع بيانات التقدم والإحصائيات والإعدادات بشكل دائم. لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get areYouSure => 'هل أنت متأكد؟';

  @override
  String get cannotBeUndone => 'لا يمكن التراجع عن هذا الإجراء';

  @override
  String get deleteEverything => 'حذف كل شيء';

  @override
  String get appLanguage => 'لغة التطبيق';

  @override
  String get howDidYouDo => 'كيف كان أداؤك؟';

  @override
  String get missedItEntirely => 'أخطأت كليًا';

  @override
  String get gotItButStruggled => 'تذكرت بصعوبة';

  @override
  String get gotItClearly => 'تذكرت بوضوح';

  @override
  String get perfectAndImmediate => 'مثالي وفوري';

  @override
  String get again => 'مرة أخرى';

  @override
  String get hard => 'صعب';

  @override
  String get good => 'جيد';

  @override
  String get easy => 'سهل';

  @override
  String get tapToReveal => 'انقر للكشف';

  @override
  String get howWellDidYouRemember => 'ما مدى تذكرك؟';

  @override
  String get completelyForgot => 'نسيت تمامًا';

  @override
  String get gotItWithDifficulty => 'تذكرت بصعوبة';

  @override
  String get recalledCorrectly => 'تذكرت بشكل صحيح';

  @override
  String get perfectRecall => 'تذكر مثالي';

  @override
  String get practiceWriting => 'تدرب على الكتابة';

  @override
  String get hideScratchpad => 'إخفاء لوح الرسم';

  @override
  String get whatCharacterMeans => 'معنى هذا الرمز:';

  @override
  String get tapCardToReveal => 'انقر على البطاقة للكشف';

  @override
  String get ratePronunciationConfidence => 'قيّم ثقتك في النطق';

  @override
  String get botchedIt => 'أخطأت تمامًا';

  @override
  String get struggledWithTones => 'واجهت صعوبة في النغمات';

  @override
  String get acceptable => 'مقبول';

  @override
  String get perfectlyNatural => 'طبيعي تمامًا';

  @override
  String get sessionComplete => 'اكتملت الجلسة!';

  @override
  String get accuracy => 'الدقة';

  @override
  String get reviewed => 'تمت المراجعة';

  @override
  String get correct => 'صحيح';

  @override
  String get backToLibrary => 'العودة إلى المكتبة';

  @override
  String get revealAnswer => 'كشف الإجابة';

  @override
  String get aiHubTitle => 'مركز الذكاء الاصطناعي';

  @override
  String get textChat => 'محادثة نصية';

  @override
  String get scholarlyPersonas => 'شخصيات علمية';

  @override
  String get shadowing => 'المحاكاة الصوتية (Shadowing)';

  @override
  String get liveTranslation => 'ترجمة فورية';

  @override
  String get scholarsLibrary => 'مكتبة العالِم';

  @override
  String get generate => 'توليد';

  @override
  String get searchPinyinHanziEnglish =>
      'ابحث عن البينيين أو الهانزي أو المعنى...';

  @override
  String get liveTranslate => 'ترجمة مباشرة';

  @override
  String get travelInterpreter => 'مترجم السفر';

  @override
  String get realTimeSplitScreen =>
      'محادثة بشاشة مقسمة في الوقت الفعلي مع متحدث أصلي لتجاوز حواجز اللغة فورًا.';

  @override
  String get whisperEarpiece => 'سماعة الترجمة الفورية';

  @override
  String get listenToChineseAudio =>
      'استمع إلى الصوت الصيني واحصل على ترجمة فورية باللغة العربية مباشرة على شاشتك.';

  @override
  String get dashboardTitle => 'لوحة التحكم';

  @override
  String get yourMindIsClear => 'ذهنك صافٍ.';

  @override
  String get noReviewsDueToday => 'لا توجد مراجعات مستحقة اليوم.';

  @override
  String get done => 'تم';

  @override
  String get hskLevel1 => 'مستوى HSK 1';

  @override
  String get hskLevel2 => 'مستوى HSK 2';

  @override
  String get hskLevel3 => 'مستوى HSK 3';

  @override
  String get hskLevel4 => 'مستوى HSK 4';

  @override
  String get hskLevel5 => 'مستوى HSK 5';

  @override
  String get hskLevel6 => 'مستوى HSK 6';

  @override
  String get generalVocabulary => 'مفردات عامة';

  @override
  String cardsRequireAttention(Object count) {
    return '$count بطاقات تتطلب المراجعة.';
  }

  @override
  String get begin => 'ابدأ';

  @override
  String get poweredByAi =>
      'مدعوم بالذكاء الاصطناعي المتقدم لترجمة فورية وسلسة في جميع المواقف.';

  @override
  String get downloadingModel => 'جارٍ تنزيل النموذج...';

  @override
  String get soon => 'قريباً';

  @override
  String get installed => 'مثبّت';

  @override
  String get premium => 'مميز';

  @override
  String get coreModule => 'الوحدة الأساسية';

  @override
  String get step6Context => 'الخطوة 6: السياق';

  @override
  String get tapBuildingBlocksTo => 'انقر على اللبنات الأساسية لاستكشاف أصلها.';

  @override
  String get initiateRadicalSequence => 'بدء تسلسل الجذور';

  @override
  String get holdToTalk => 'اضغط مع الاستمرار للتحدث';

  @override
  String get customScenario => 'سيناريو مخصص';

  @override
  String get voiceCall => 'مكالمة صوتية';

  @override
  String get pronunciation => 'النطق';

  @override
  String get selectAScenarioTo =>
      'اختر سيناريو لممارسة الماندارين المنطوقة. سيقوم العالِم بتقييم نبرات صوتك ووضوحها.';

  @override
  String get create => 'إنشاء';

  @override
  String get createYourScenario => 'أنشئ سيناريو خاصًا بك';

  @override
  String get difficulty => 'الصعوبة';

  @override
  String get scholarsVerdict => 'تقييم العالِم';

  @override
  String get completeReview => 'مراجعة كاملة';

  @override
  String get conversationReview => 'مراجعة المحادثة';

  @override
  String get linguisticAnalysis => 'التحليل اللغوي';

  @override
  String get examplesInHsk1 => 'أمثلة في HSK 1';

  @override
  String get characterReference => 'مرجع الرمز';

  @override
  String get askTutor => 'اسأل المعلم';

  @override
  String get addToStudyDeck => 'أضف إلى مجموعة الدراسة';

  @override
  String get startPractice => 'ابدأ التدريب';

  @override
  String get noOtherHsk1 => 'لا توجد رموز أخرى في HSK 1 تستخدم هذا الجذر.';

  @override
  String get couldNotLoadAi =>
      'تعذر تحميل سياق الذكاء الاصطناعي. (حد الطلبات أو خطأ في الشبكة)\nانقر على زر التحديث أدناه للمحاولة مرة أخرى لاحقًا.';

  @override
  String get noAvailableCardsFound => 'لم يتم العثور على بطاقات متاحة.';

  @override
  String get addCards => 'إضافة بطاقات';

  @override
  String get removeCard => 'إزالة البطاقة';

  @override
  String get remove => 'إزالة';

  @override
  String get review => 'مراجعة';

  @override
  String get story => 'قصة';

  @override
  String get thisDeckIsEmpty => 'هذه المجموعة فارغة.';

  @override
  String get tapTheAddCards => 'انقر على زر إضافة بطاقات!';

  @override
  String get noCardsFound => 'لم يتم العثور على بطاقات.';

  @override
  String get addCardsToSee => 'أضف بطاقات لرؤية الإحصائيات.';

  @override
  String get aiGenerated => 'تم إنشاؤه بواسطة الذكاء الاصطناعي';

  @override
  String get allCardsCaughtUp => 'تمت مراجعة جميع البطاقات! عمل رائع.';

  @override
  String get latestDiscoveries => 'أحدث الاكتشافات';

  @override
  String get noCharactersInLexicon => 'لا توجد رموز في المعجم حتى الآن.';

  @override
  String get yourBookshelf => 'رف كتبك';

  @override
  String get text_1782026184579 => '字';

  @override
  String get searchYourDictionary => 'ابحث في قاموسك...';

  @override
  String get saveCard => 'حفظ البطاقة';

  @override
  String get noCharactersFound => 'لم يتم العثور على رموز.';

  @override
  String get radicalsIndex => 'فهرس الجذور';

  @override
  String get masteringRadicalsIsThe =>
      'إتقان الجذور هو المفتاح لفهم آلاف رموز الهانزي. حدد جذرًا لعرض جميع الرموز المرتبطة به.';

  @override
  String get noRadicalsFound => 'لم يتم العثور على جذور.';

  @override
  String get yourDrawing => 'رسمك';

  @override
  String get reference => 'المرجع';

  @override
  String get rateYourRecall => 'قيّم مدى تذكرك';

  @override
  String get contactUs => 'اتصل بنا';

  @override
  String get reportBugsOrRequest => 'الإبلاغ عن الأخطاء أو اقتراح ميزات';

  @override
  String get allDataHasBeen => 'تم مسح جميع البيانات.';

  @override
  String get hanziMasterV100 => 'SinoSpark v1.0.0';

  @override
  String get myProgress => 'تقدمي';

  @override
  String get overview => 'نظرة عامة';

  @override
  String get aiStory => 'قصة بالذكاء الاصطناعي';

  @override
  String get usingYourDecksVocabulary => 'باستخدام مفردات مجموعتك';

  @override
  String get tryAgain => 'حاول مرة أخرى';

  @override
  String get translate => 'ترجمة';

  @override
  String get pinyin => 'بينيين';

  @override
  String get fullTranslation => 'ترجمة كاملة';

  @override
  String get geminiFlashIsStructuring => 'يقوم Gemini Flash بصياغة قصتك...';

  @override
  String get aiDeckGenerator => 'منشئ المجموعات بالذكاء الاصطناعي';

  @override
  String get whatDoYouWant => 'ماذا تريد أن تتعلم؟';

  @override
  String get targetDifficulty => 'الصعوبة المستهدفة';

  @override
  String get focusArea => 'مجال التركيز';

  @override
  String get specificContextOrTone => 'سياق أو نبرة محددة (اختياري)';

  @override
  String get numberOfCards => 'عدد البطاقات';

  @override
  String get generateDeck => 'إنشاء مجموعة';

  @override
  String get aiGrammarExplanation => 'شرح القواعد بالذكاء الاصطناعي';

  @override
  String get scholarsDesk => 'مكتب العالِم';

  @override
  String get chooseADeck => 'اختر مجموعة';

  @override
  String get whereWouldYouLike => 'أين تود حفظ هذا الرمز؟';

  @override
  String get addToDefaultStudy => 'أضف إلى مجموعة الدراسة الافتراضية';

  @override
  String get ifOffItsOnly => 'إذا تم تعطيله، فسيتم حفظه في القاموس العام فقط';

  @override
  String get saveToLibrary => 'حفظ في المكتبة';

  @override
  String get pleaseEnterValidChinese => 'يرجى إدخال رموز صينية صحيحة';

  @override
  String get reviewAiCard => 'مراجعة بطاقة الذكاء الاصطناعي';

  @override
  String get pleaseDoublecheckTheAis =>
      'يرجى مراجعة نتيجة الذكاء الاصطناعي أدناه. يمكنك تعديل البينيين أو التعريف قبل الحفظ في مكتبتك الدائمة.';

  @override
  String get alreadyInYourLibrary => 'موجود بالفعل في مكتبتك!';

  @override
  String get meaningInContext => 'المعنى في السياق';

  @override
  String get explainGrammar => 'شرح القواعد';

  @override
  String get addToLibrary => 'أضف إلى المكتبة';

  @override
  String get masterYourMandarinPronunciation =>
      'أتقن نطقك للماندارين من خلال محاكاة المتحدثين الأصليين في الوقت الفعلي.';

  @override
  String get startSession => 'بدء الجلسة';

  @override
  String get sessionHistory => 'سجل الجلسات';

  @override
  String get noSavedSessions => 'لا توجد جلسات محفوظة.';

  @override
  String get aiBreakdown => 'تحليل الذكاء الاصطناعي';

  @override
  String get sessionDetails => 'تفاصيل الجلسة';

  @override
  String partner(Object lang) {
    return 'الشريك ($lang)';
  }

  @override
  String get youEnglish => 'أنت (العربية)';

  @override
  String get noTranscriptToSave => 'لا يوجد نص لحفظه!';

  @override
  String get sessionSaved => 'تم حفظ الجلسة!';

  @override
  String get realtimeBidirectionalTranslationSpeak =>
      'ترجمة ثنائية الاتجاه في الوقت الفعلي. تحدث بالعربية أو الماندارين، وسيترجم فورًا لك ولشريكك.';

  @override
  String get text_1782026184665 => 'تسجيل';

  @override
  String get recording => 'تسجيل';

  @override
  String get yourSilentCompanionListen =>
      'رفيقك الصامت. استمع إلى الماندارين، واحصل على الترجمة العربية على الفور.';

  @override
  String get startListening => 'بدء الاستماع';

  @override
  String get skip => 'تخطي';

  @override
  String get independentStars => 'نجوم مستقلة';

  @override
  String get notEveryCharacterHas =>
      'لا يحتوي كل رمز على جذر أصلي. بعضها رموز بصرية فريدة أو قائمة بذاتها.';

  @override
  String get onTheMapWe =>
      'على الخريطة، نجمع هذه الرموز المستقلة في كوكبات (✨).';

  @override
  String get iUnderstand => 'أفهم ذلك';

  @override
  String get whatAreRadicals => 'ما هي الجذور؟';

  @override
  String get hanziAreBuiltFrom =>
      'تتكون رموز الهانزي من لبنات بناء تسمى الجذور.\n\nتمنح الرمز معناه أو موضوعه الأساسي.';

  @override
  String get continueText => 'متابعة';

  @override
  String get hanziAreNotJust =>
      'رموز الهانزي ليست مجرد حروف، بل هي صور مخلدة عبر الزمن.\n\nلإتقانها، يجب أن تتعلم مسار رسمها وتدفقها.';

  @override
  String get iAmReady => 'أنا مستعد';

  @override
  String get youAreAScholar => 'أنت عالِم';

  @override
  String get theGalaxyMapAwaitsnmaster =>
      'خريطة المجرة في انتظارك.\nأتقن الشموس (الجذور) لفتح الكواكب (الرموز).';

  @override
  String get enterTheScroll => 'ادخل إلى اللفافة';

  @override
  String get openingTheOriginScroll => 'جارٍ فتح لفافة الأصل...';

  @override
  String get text_1782026184670 => '+';

  @override
  String get theScholarsEdition => 'نسخة العالِم';

  @override
  String get weArePreparingThe => 'نحن نجهز نسخة العالِم للإطلاق.';

  @override
  String get devBypassUnlockNow => 'تجاوز المطور: فتح الآن';

  @override
  String get restorePurchases => 'استعادة المشتريات';

  @override
  String get welcomeScholarTheScroll =>
      'مرحبًا أيها العالِم، اللفافة مفتوحة لك بالكامل.';

  @override
  String get purchasesRestoredSuccessfully => 'تمت استعادة المشتريات بنجاح.';

  @override
  String get noPreviousPurchasesFound =>
      'لم يتم العثور على مشتريات سابقة لهذا الحساب.';

  @override
  String get unlockTheFullPotential =>
      'أطلق العنان للإمكانات الكاملة لرحلتك. شراء لمرة واحدة وامتلاك دائم.';

  @override
  String get universalScanner => 'الماسح الشامل';

  @override
  String get noChineseCharactersFound =>
      'لم يتم العثور على رموز صينية في الصورة.';

  @override
  String get addedNewCharactersTo => 'تمت إضافة رموز جديدة إلى مكتبتك!';

  @override
  String get extractingTextAndObjects => 'جارٍ استخراج النصوص والكائنات...';

  @override
  String get scanATextbookSign =>
      'امسح كتابًا دراسيًا أو لافتة أو كائنًا لاستخراج الرموز الصينية.';

  @override
  String get extractedText => 'النص المستخرج';

  @override
  String get useText => 'استخدام النص';

  @override
  String get noMatchingDictionaryEntries =>
      'لم يتم العثور على إدخالات مطابقة في القاموس.';

  @override
  String get quizComplete => 'اكتمل الاختبار!';

  @override
  String get returnToCourse => 'العودة إلى المسار';

  @override
  String get notEnoughCardsFor =>
      'لا توجد بطاقات كافية للاختبار! يلزم توفر 4 بطاقات على الأقل.';

  @override
  String get creatorMode => 'وضع المنشئ';

  @override
  String get noStoriesFoundMatching => 'لم يتم العثور على قصص مطابقة لبحثك.';

  @override
  String get discard => 'تجاهل';

  @override
  String get save => 'حفظ';

  @override
  String get generatingStoryViaDeepseek => 'جارٍ إنشاء القصة عبر DeepSeek...';

  @override
  String get storySavedToLibrary => 'تم حفظ القصة في المكتبة!';

  @override
  String get storyNotFound => 'لم يتم العثور على القصة.';

  @override
  String get targetHskLevel => 'مستوى HSK المستهدف';

  @override
  String get wedLoveToHear => 'يسعدنا سماع رأيك!';

  @override
  String get whetherYouveFoundA =>
      'سواء وجدت خطأً، أو كان لديك اقتراح لميزة، أو أردت فقط إلقاء التحية، فإن ملاحظاتك تساعدنا على تحسين SinoSpark.';

  @override
  String get pointYourCameraAt => 'وجّه الكاميرا نحو الكائنات';

  @override
  String get reviewAddToLibrary => 'مراجعة وإضافة إلى المكتبة';

  @override
  String hideStrokeGuideStreak(Object streak) {
    return 'إخفاء دليل مسار الخطوط عند السلسلة: $streak';
  }

  @override
  String inkPoints(Object points) {
    return 'نقاط الحبر: $points';
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
  String get supportAndFeedback => 'الدعم والملاحظات';

  @override
  String get reportBug => 'الإبلاغ عن خطأ';

  @override
  String get suggestFeature => 'اقتراح ميزة';

  @override
  String get generalFeedback => 'ملاحظات عامة';

  @override
  String get pleaseDrawSomethingFirst => 'يرجى رسم شيء أولاً';

  @override
  String get drawThisCharacter => 'ارسم هذا الرمز:';

  @override
  String followGuideStroke(Object current, Object total) {
    return 'اتبع الدليل الأزرق لرسم الخط $current من $total';
  }

  @override
  String get skipCurrentStroke => 'تخطي الخط الحالي';

  @override
  String get submitDrawing => 'تأكيد الرسم';

  @override
  String addedToDeck(Object deckName, Object hanzi) {
    return 'تمت إضافة $hanzi إلى $deckName';
  }

  @override
  String removedFromDeck(Object hanzi) {
    return 'تمت إزالة $hanzi من المجموعة';
  }

  @override
  String skippedNoStrokeData(Object hanzi) {
    return 'تم تخطي \"$hanzi\" - لا تتوفر بيانات مسار الخطوط لهذا الرمز.';
  }

  @override
  String get startingSession => 'بدء الجلسة...';

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
  String get newLabel => 'جديد';

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
  String get masterBuildingBlocks => 'إتقان لبنات بناء الهانزي';

  @override
  String get totalWords => 'إجمالي الكلمات';

  @override
  String get newInk => 'حبر جديد';

  @override
  String get learningStatus => 'قيد التعلم';

  @override
  String get masteredStatus => 'مُتقَن';

  @override
  String get libraryMastery => 'إتقان المكتبة';

  @override
  String get accuracyByMode => 'الدقة حسب الوضع';

  @override
  String get upcomingReviews => 'المراجعات القادمة (خلال 7 أيام)';

  @override
  String get culturalReadingRoom => 'غرفة المطالعة الثقافية (文化书房)';

  @override
  String storyTitleHsk(Object level, Object title) {
    return '$title (مستوى HSK $level)';
  }

  @override
  String get pleaseEnterTopic => 'يرجى إدخال موضوع';

  @override
  String createdDeckCards(Object count, Object name) {
    return 'تم إنشاء $name بـ $count بطاقات!';
  }

  @override
  String gradeResult(Object grade) {
    return 'الدرجة: $grade';
  }

  @override
  String get listeningMode => 'وضع الاستماع';

  @override
  String get readingMode => 'وضع القراءة';

  @override
  String get recallMode => 'وضع الاستدعاء الذهني';

  @override
  String get speakingMode => 'وضع التحدث';

  @override
  String get aiMemoryHook => 'الرابط الذهني بالذكاء الاصطناعي';

  @override
  String get exampleSentences => 'جمل توضيحية';

  @override
  String get ghostCharacters => 'الرموز الإرشادية (الشبحية)';

  @override
  String get commonWords => 'الكلمات الشائعة';

  @override
  String get personalNotes => 'ملاحظات شخصية';

  @override
  String get addPersonalNotes => 'أضف روابطك الذهنية أو ملاحظاتك هنا...';

  @override
  String get takePhoto => 'التقاط صورة';

  @override
  String get gallery => 'المعرض';

  @override
  String get arLens => 'عدسة الواقع المعزز (AR)';

  @override
  String addedCharToLibrary(Object char) {
    return 'تمت إضافة $char إلى المكتبة';
  }

  @override
  String get scoreText => 'النقاط';

  @override
  String get searchDictionaryHint => 'ابحث عن الرمز أو البينيين أو المعنى...';

  @override
  String get searchDeckHint => 'ابحث عن الرمز أو البينيين...';

  @override
  String get localRestaurant => 'مطعم محلي';

  @override
  String get taxiToAirport => 'تاكسي إلى المطار';

  @override
  String get silkMarketHaggling => 'المساومة في سوق الحرير';

  @override
  String get medicalClinic => 'عيادة طبية';

  @override
  String get meetingAFriend => 'لقاء صديق';

  @override
  String get jobInterview => 'مقابلة عمل';

  @override
  String get searchRadicalsHint => 'ابحث عن الجذور (مثل الماء، 氵)';

  @override
  String get definition => 'التعريف';

  @override
  String get undo => 'تراجع';

  @override
  String get hanziMaster => 'هانزي ماستر';

  @override
  String get unlockForever => 'فتح دائم - \$9.99';

  @override
  String get clear => 'مسح';

  @override
  String get clearChat => 'مسح المحادثة';

  @override
  String get typeMessage => 'اكتب رسالتك...';

  @override
  String addedToLibrary(Object hanzi) {
    return 'تمت إضافة \'$hanzi\' إلى مكتبتك';
  }

  @override
  String get generateNewStory => 'توليد قصة جديدة';

  @override
  String failedToGenerateStory(Object error) {
    return 'فشل إنشاء القصة:\n$error';
  }

  @override
  String get detail => 'التفاصيل';

  @override
  String get scanText => 'مسح ضوئي للنص';

  @override
  String get createMagic => 'ابتكار سحر';

  @override
  String get learning => 'قيد التعلم';

  @override
  String get upcomingReviews7Days => 'المراجعات القادمة (خلال 7 أيام)';

  @override
  String get askFollowUpQuestion => 'اطرح سؤالاً إضافياً...';

  @override
  String get pasteScanToSimplify => 'الصق النص الصيني أو امسحه ضوئيًا لتبسيطه';

  @override
  String get searchStoriesHint =>
      'ابحث في القصص حسب العنوان أو الوسوم (مثل: الأساطير، السفر)';

  @override
  String get importAll => 'استيراد الكل';

  @override
  String get ascendAll => 'ترقية الكل';

  @override
  String get startAscension => 'بدء الارتقاء';

  @override
  String get scenarioLocalRestaurant => 'مطعم محلي';

  @override
  String get scenarioLocalRestaurantDesc =>
      'تدرب على طلب الأطباق وطلب التوصيات.';

  @override
  String get scenarioTaxiAirport => 'تاكسي إلى المطار';

  @override
  String get scenarioTaxiAirportDesc => 'أخبر السائق وجهتك وناقش حركة المرور.';

  @override
  String get scenarioSilkMarket => 'المساومة في سوق الحرير';

  @override
  String get scenarioSilkMarketDesc => 'حاول الحصول على سعر أفضل لتذكار.';

  @override
  String get scenarioMedicalClinic => 'عيادة طبية';

  @override
  String get scenarioMedicalClinicDesc =>
      'اشرح الأعراض التي تعاني منها لطبيب تقليدي.';

  @override
  String get scenarioMeetingFriend => 'لقاء صديق';

  @override
  String get scenarioMeetingFriendDesc => 'قدم نفسك وتحدث في مواضيع عامة.';

  @override
  String get scenarioJobInterview => 'مقابلة عمل';

  @override
  String get scenarioJobInterviewDesc => 'تقدم لوظيفة في شركة تقنية في شنغهاي.';

  @override
  String get createCustomScenario => 'إنشاء سيناريو مخصص';

  @override
  String get customScenarioTitleHint => 'العنوان (مثال: حفل زفاف)';

  @override
  String get customScenarioDescHint => 'الوصف (السياق)';

  @override
  String get customScenarioPersonaHint =>
      'شخصية الذكاء الاصطناعي (مثال: زميل عمل فضولي)';

  @override
  String get customScenarioDifficulty => 'الصعوبة';

  @override
  String get createAction => 'إنشاء';

  @override
  String get cancelAction => 'إلغاء';

  @override
  String get mythsAndLegends => 'الأساطير والحكايات';

  @override
  String get historyAndCulture => 'التاريخ والثقافة';

  @override
  String get idiomsTitle => 'تعبيرات اصطلاحية (成语)';

  @override
  String get theMonkeyKing => 'ملك القردة';

  @override
  String get theMonkeyKingDesc => 'سون ووكونغ (رحلة إلى الغرب)';

  @override
  String get huaMulan => 'هوا مولان';

  @override
  String get huaMulanDesc => 'انضمام هوا مولان للجيش بدلاً من والدها';

  @override
  String get confuciusTitle => 'كونفوشيوس';

  @override
  String get confuciusDesc => 'حياة وتعاليم كونفوشيوس';

  @override
  String get theGreatWall => 'سور الصين العظيم';

  @override
  String get theGreatWallDesc => 'بناء سور الصين العظيم';

  @override
  String get generateTopic => 'إنشاء موضوع';

  @override
  String get simplifyText => 'تبسيط النص';

  @override
  String get topicHint => 'الموضوع (مثال: كائنات فضائية في بكين)';

  @override
  String get tagsHint => 'الوسوم (مفصولة بفواصل، اختياري)';

  @override
  String get speakWithMasterLin => 'تحدث مع المعلم لين';

  @override
  String get masterLinGreeting =>
      'تحياتي، أيها المتعلّم. الحبر جاهز. أي رمز أو عبارة سنتناولها اليوم؟';

  @override
  String get typeYourMessage => 'اكتب رسالتك...';

  @override
  String get theMainLibrary => 'المكتبة الرئيسية';

  @override
  String get hsk1Foundation => 'HSK 1: الأساسيات';

  @override
  String get hsk2Elementary => 'HSK 2: ابتدائي';

  @override
  String get hsk3Intermediate => 'HSK 3: متوسط';

  @override
  String get inDeckCheck => 'موجود في المجموعة ✓';

  @override
  String get addToDeckPlus => '+ إضافة للمجموعة';

  @override
  String get openCardArrow => 'فتح البطاقة →';

  @override
  String get pronunciationPartial => 'النغمة غير دقيقة';

  @override
  String get pronunciationWrong => 'غير صحيح';

  @override
  String get toneExpected => 'المتوقع';

  @override
  String get toneYouSaid => 'ما نطقته';

  @override
  String get gotIt => 'فهمت!';

  @override
  String foundNCharacters(int count) {
    return 'تم العثور على $count رموز';
  }

  @override
  String get lookingUpCharacters => 'جارٍ البحث عن الرموز…';

  @override
  String get practiceAll => 'التدرب على الكل';

  @override
  String get arLensObjects => 'الكائنات';

  @override
  String get arLensText => 'نص';

  @override
  String get arLensDetectedText => 'النص المكتشف';

  @override
  String get duration12Min => '١-٢ دقيقة';

  @override
  String get aClassicTangDynastyPoem => 'قصيدة كلاسيكية من عهد تانغ';

  @override
  String get aClassicTangDynastyPoemBy => 'قصيدة كلاسيكية من عهد تانغ بقلم';

  @override
  String get aStructuralComponent => 'عنصر تركيبي.';

  @override
  String get addSelectedToDeck => 'إضافة المحدد إلى المجموعة';

  @override
  String addTo(Object target) {
    return 'أضف إلى ';
  }

  @override
  String addedHanziToYourLibrary(String hanzi) {
    return 'تمت إضافة \'$hanzi\' إلى مكتبتك';
  }

  @override
  String get adjustFontSize => 'ضبط حجم الخط';

  @override
  String get againGoodEasyHard => '⬅️ مرة أخرى    ➡️ جيد    ⬆️ سهل    ⬇️ صعب';

  @override
  String get aiAnalysisFailed => 'فشل تحليل الذكاء الاصطناعي';

  @override
  String get aiIsThinking => 'جارٍ تفكير الذكاء الاصطناعي...';

  @override
  String get aiSceneAnalysisFailed => 'فشل تحليل المشهد بالذكاء الاصطناعي';

  @override
  String get allLabel => 'الكل';

  @override
  String get allPinyin => 'جميع نغمات البينيين';

  @override
  String get alreadyHaveAccountSignIn => 'لديك حساب بالفعل؟ تسجيل الدخول';

  @override
  String get analysisFailed => 'فشل التحليل:';

  @override
  String get analyzingClassicalCharacters => 'جارٍ تحليل الرموز الكلاسيكية...';

  @override
  String get anatomy => 'التشريح';

  @override
  String get ancientPhilosophy => 'الفلسفة القديمة';

  @override
  String get articleSavedToMediaHub => 'تم حفظ المقال في مكتبة الوسائط!';

  @override
  String get askAFollowUp => 'اطرح سؤالاً إضافياً...';

  @override
  String get audioPrivacyAndHowThingsWork => 'الصوت والخصوصية وآلية العمل';

  @override
  String get audiobookPlayer => 'مشغل الكتاب الصوتي';

  @override
  String get audiobookVoice => 'صوت الكتاب الصوتي';

  @override
  String get auntieMaTown =>
      'العمة ما (马阿姨)، صاحبة كشك مفعمة بالحيوية تصنع أشهى روجيامو وليانغبي في المدينة.';

  @override
  String get back => 'رجوع';

  @override
  String get baristaKevinNotes =>
      'الباريستا كيفن (小凯)، محمّص قهوة شاب شغوف يحب الحديث عن حبوب بن يوننان وإيحاءاتها.';

  @override
  String get bbc => 'بي بي سي الصينية';

  @override
  String get beginYourJourney => 'ابدأ رحلتك';

  @override
  String get bestValue => 'أفضل قيمة';

  @override
  String get bookLinkCopiedToClipboard => 'تم نسخ رابط الكتاب إلى الحافظة!';

  @override
  String get bookmarkChapter => 'وضع إشارة مرجعية للفصل';

  @override
  String get bookmarks => 'الإشارات المرجعية';

  @override
  String get books => 'الكتب';

  @override
  String get briefing => 'الإحاطة';

  @override
  String get bugReport => 'الإبلاغ عن خطأ';

  @override
  String get caoXueqinDecline =>
      'كان تساو شيويهتشين (حوالي 1715–1763) روائياً من عهد تشينغ وُلد في عائلة بانرمان الثرية التي انهارت ثروتها في عهد الإمبراطور يونغ تشنغ. تُعتبر رواية حلم الغرفة الحمراء، التي كُتبت في سنواته الأخيرة التي عاشها في فقر، ذروة الأدب الصيني — لوحة شاسعة وغنية نفسياً تصف انحدار الطبقة الأرستقراطية.';

  @override
  String get cardsTitle => 'البطاقات';

  @override
  String get cc => 'الترجمة التوضيحية (CC)';

  @override
  String get characterOrWord => 'رمز / كلمة';

  @override
  String get chatMore => 'متابعة المحادثة';

  @override
  String get chefChenShumai =>
      'الشيف تشن (陈师傅)، طاهي ديم سام كانتوني مرح يوصي بزلابية هار غاو الطازجة والشوماي.';

  @override
  String get chineseEpics => 'الملاحم الصينية';

  @override
  String get chinesePoetry => 'الشعر الصيني';

  @override
  String get chng => 'chéng';

  @override
  String get chongqingSpicyHotpotFeast =>
      'وليمة الهوت بوت الحارة في تشونغتشينغ';

  @override
  String get chooseAudiobookVoice => 'اختر صوت الكتاب الصوتي';

  @override
  String get chooseVoice => 'اختر صوتاً';

  @override
  String get compare => 'مقارنة';

  @override
  String get compare4Tones => 'مقارنة النغمات الأربع';

  @override
  String get configuration => 'التهيئة';

  @override
  String get contemporary => 'معاصر';

  @override
  String get context => 'السياق';

  @override
  String get couldNotLoadLibrary => 'تعذر تحميل المكتبة';

  @override
  String get couldNotLoadVocabulary => 'تعذر تحميل المفردات.';

  @override
  String get couldNotOpenEmailApp => 'تعذر فتح تطبيق البريد الإلكتروني.';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get createNewDeck => 'إنشاء مجموعة جديدة';

  @override
  String get createScenario => 'إنشاء سيناريو';

  @override
  String get createStory => 'إنشاء قصة';

  @override
  String get customLabel => 'مخصص';

  @override
  String get customWord => 'كلمة مخصصة';

  @override
  String get days => 'أيام';

  @override
  String get deck => 'مجموعة';

  @override
  String get deckName => 'اسم المجموعة';

  @override
  String get deckStory => 'قصة المجموعة';

  @override
  String get deepAnalysis => 'تحليل عميق';

  @override
  String get defaultDeck => 'المجموعة الافتراضية';

  @override
  String get deleteLabel => 'حذف';

  @override
  String get deleteScenario => 'حذف السيناريو';

  @override
  String get deletesAllProgressPermanently => 'يحذف كل التقدم بشكل دائم';

  @override
  String get developerBackdoorUnlocked => 'تم فتح الباب الخلفي للمطور!';

  @override
  String get doesNotExistInChinese => 'غير موجود في اللغة الصينية';

  @override
  String get dontHaveAccountSignUp => 'ليس لديك حساب؟ إنشاء حساب';

  @override
  String get draftingStoryOutline => 'جارٍ صياغة مخطط القصة...';

  @override
  String get dynamicFlowState => 'حالة التدفق الديناميكي';

  @override
  String get dynamicFlowStateParenthetical => 'ديناميكي (حالة التدفق)';

  @override
  String get editCard => 'تعديل البطاقة';

  @override
  String get egAnimeVocab => 'مثال: مفردات الأنمي';

  @override
  String get egFormalBusinessLanguageSlangForTexting =>
      'مثال: لغة الأعمال الرسمية، العامية للتراسل...';

  @override
  String get egOrderingAtARestaurantBusinessVocab =>
      'مثال: الطلب في مطعم، مفردات الأعمال...';

  @override
  String get egWeddingReceptionTechInterview =>
      'مثال: حفل زفاف، مقابلة تقنية...';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get english => 'الإنجليزية';

  @override
  String get englishAndWorld => 'الإنجليزية والعالم';

  @override
  String get episodes => 'حلقات';

  @override
  String get erase => 'مسح';

  @override
  String get eraseDeckQuestion => 'مسح المجموعة؟';

  @override
  String errorFetchingTranslationForLabelE(String label, String e) {
    return 'خطأ في جلب الترجمة لـ $label: $e';
  }

  @override
  String errorLoadingMicroreadsE(String e) {
    return 'خطأ في تحميل القراءات القصيرة: $e';
  }

  @override
  String errorLoadingNovelsE(String e) {
    return 'خطأ في تحميل الروايات: $e';
  }

  @override
  String errorLoadingPoetryE(String e) {
    return 'خطأ في تحميل الشعر: $e';
  }

  @override
  String get exitFocus => 'الخروج من وضع التركيز';

  @override
  String get explore => 'استكشف';

  @override
  String get exportToThisDeck => 'تصدير إلى هذه المجموعة';

  @override
  String get extractAndSimplify => 'استخراج وتبسيط';

  @override
  String get failedToCreateDeck => 'فشل إنشاء المجموعة';

  @override
  String get failedToLoadDailyContent => 'فشل تحميل المحتوى اليومي';

  @override
  String get failedToLoadEpisodes => 'فشل تحميل الحلقات';

  @override
  String get failedToLoadShows => 'فشل تحميل البرامج';

  @override
  String get finalizingDetails => 'جارٍ إنهاء التفاصيل...';

  @override
  String get finalizingStoryDetails => 'جارٍ إنهاء تفاصيل القصة...';

  @override
  String get firebaseAuthConsole =>
      'مصادقة Firebase غير مفعلة. يرجى تفعيل طريقة تسجيل الدخول المطلوبة في وحدة تحكم Firebase.';

  @override
  String get flashcardDeckTitle => 'مجموعة البطاقات التعليمية';

  @override
  String get focus => 'تركيز';

  @override
  String get foodAndCooking => 'الطعام والطبخ';

  @override
  String get forward => 'تقديم سريع';

  @override
  String get freeFlow => 'تدفق حر';

  @override
  String get frenchClassics => 'الكلاسيكيات الفرنسية';

  @override
  String get full => 'كامل';

  @override
  String get gamingAndEsports => 'الألعاب والرياضات الإلكترونية';

  @override
  String get germanClassics => 'الكلاسيكيات الألمانية';

  @override
  String get ghostPinyin => 'بينيين إرشادي (باهت)';

  @override
  String get goodAttempt => 'محاولة جيدة';

  @override
  String get gotItSimple => 'فهمت';

  @override
  String get grammar => 'القواعد';

  @override
  String get grandmaLiuFilling =>
      'الجدة ليو (刘奶奶)، جدة شمالية حنونة تعلمك كيفية طي عجينة الزلابية وصنع حشوة لحم الخنزير والبصل الأخضر.';

  @override
  String get great => 'ممتاز!';

  @override
  String get handmadeDumplingFeastInHarbin =>
      'وليمة الزلابية اليدوية في هاربين';

  @override
  String get hanziCharacter => 'هانزي (رمز)';

  @override
  String get hapticFeedback => 'الاستجابة اللمسية';

  @override
  String get helpAndSupport => 'المساعدة والدعم';

  @override
  String get hidden => 'مخفي';

  @override
  String get hideEnglishTranslations => 'إخفاء الترجمة';

  @override
  String get hidePinyin => 'إخفاء البينيين';

  @override
  String get highlight => 'تمييز';

  @override
  String get howWouldYouLikeToStudy => 'كيف تفضل الدراسة؟';

  @override
  String get hsk1 => 'HSK 1';

  @override
  String get hsk4UpperIntermediate => 'HSK 4: متوسط متقدم';

  @override
  String get hsk5Advanced => 'HSK 5: متقدم';

  @override
  String get hsk6Mastery => 'HSK 6: إتقان';

  @override
  String get hskCollections => 'مجموعات HSK';

  @override
  String hskLevel(String level) {
    return 'HSK $level';
  }

  @override
  String get hskSimplifySubtitles => 'تبسيط الترجمة حسب HSK';

  @override
  String get hskVocabularyCollections => 'مجموعات مفردات HSK';

  @override
  String get i => 'أنا';

  @override
  String get ifTheAgain =>
      'إذا اكتشف الذكاء الاصطناعي عدم تطابق، فسيسأل \'هل قصدت أن تقول...؟\'. يمكنك النقر على زر \'نعم، أعد تقييمي!\' لإعادة تقييم صوتك الأصلي فوراً مقابل نيتك الحقيقية دون الحاجة للتحدث مرة أخرى.';

  @override
  String get install => 'تثبيت';

  @override
  String get just => 'فقط \$';

  @override
  String get keyword => 'كلمة مفتاحية';

  @override
  String get knowledgeBase => 'قاعدة المعرفة';

  @override
  String get liRuzhenSubjects =>
      'لي روجن (حوالي 1763–1830) كان عالماً من عهد تشينغ مهتماً بعلم الأصوات والشطرنج وعلم الكون. روايته أزهار في المرآة، وهي رواية خيالية عن تاجر يرتحل عبر ممالك مستحيلة، تتميز بموضوعاتها النسوية ونطاقها الموسوعي.';

  @override
  String get library => 'مكتبة وِنْهوا شُوفَانغ';

  @override
  String get lifestyleAndVlog => 'نمط الحياة والفلوغ';

  @override
  String get listenInAudiobookMode => 'الاستماع في وضع الكتاب الصوتي';

  @override
  String get listenToThisWord => 'استمع إلى هذه الكلمة';

  @override
  String get listening => 'جارٍ الاستماع...';

  @override
  String get liuEEncroachment =>
      'ليو إي (1857–1909) كان موسوعياً في أواخر عهد تشينغ — مهندساً وطبيباً وروائياً — روايته الوحيدة رحلات لاو تسان هي رحلة غنائية لكنها مشحونة سياسياً لمعالج متجول يجتاز الصين في خضم الانهيار الأسري والتعدي الأجنبي.';

  @override
  String get loadingTranslations => 'جارٍ تحميل الترجمات...';

  @override
  String get luXunVernacular =>
      'لو شون (1881–1936)، الاسم المستعار لتشو شو رن، هو أبو الأدب الصيني الحديث. طبيب تحول إلى الكتابة لعلاج الروح الصينية، مجموعاته القصصية — يوميات مجنون والقصة الحقيقية لأه كيو — استخدمت اللغة العامية لنقد المجتمع التقليدي.';

  @override
  String get luoGuanzhongEpic =>
      'لو قوانتشونغ (حوالي 1330–1400) كان كاتباً مسرحياً وروائياً في فترة الانتقال من يوان إلى مينغ، يُعتقد أنه درس تحت إشراف شي نايآن. روايته رومانسية الممالك الثلاث دمجت السجلات التاريخية والتقليد الشفهي والسرد الدرامي في الملحمة التاريخية الصينية النهائية.';

  @override
  String get makeACustomCollection => 'إنشاء مجموعة مخصصة';

  @override
  String get manageDailyDropsAndReviewReminders =>
      'إدارة الإضافات اليومية وتذكيرات المراجعة';

  @override
  String get managerYuOptions =>
      'المدير يو (余店长)، مدير مطعم هوت بوت مفعم بالحماس يوصي بالكرشة المميزة، ودم البط، وخيارات المرق غير الحار.';

  @override
  String get masterGaoRubs =>
      'المعلم قاو (高师傅)، طاهٍ كاريزمي للشواء على الفحم يمازج الزبائن حول مستويات التوابل وخلطات الكمون السرية.';

  @override
  String get masterThisToUnlockItsGalaxy => 'أتقن هذا لفتح مجرته.';

  @override
  String get masterZhaoBrewing =>
      'المعلم تشاو (赵师傅)، خبير شاي صبور ومتمكن يحب شرح إعداد شاي الغونغفو.';

  @override
  String get mastery => 'إتقان';

  @override
  String get maybeLater => 'ربما لاحقاً';

  @override
  String get memes => 'الميمات';

  @override
  String get midnightBbqSkewersInWuhan =>
      'أسياخ الشواء في منتصف الليل في ووهان';

  @override
  String get mo => '/شهر';

  @override
  String get modernChinese => 'الصينية الحديثة';

  @override
  String get monthly => 'شهري';

  @override
  String get morningDimSumCartInGuangzhou =>
      'عربة الديم سام الصباحية في غوانغتشو';

  @override
  String get nameLabel => 'الاسم';

  @override
  String get native => 'أصلي';

  @override
  String get newCard => 'بطاقة جديدة';

  @override
  String get newDeck => 'مجموعة جديدة';

  @override
  String get newDeckName => 'اسم المجموعة الجديدة';

  @override
  String get noActiveSubscriptionFound => 'لم يتم العثور على اشتراك نشط.';

  @override
  String get noEpisodesFound => 'لم يتم العثور على حلقات';

  @override
  String get noKeyWordsFoundForThisStory =>
      'لم يتم العثور على كلمات مفتاحية لهذه القصة.';

  @override
  String get noLabel => 'لا';

  @override
  String get noNewWordsFound => 'لم يتم العثور على كلمات جديدة!';

  @override
  String get noPinyin => 'بدون بينيين';

  @override
  String get noPremiumPackagesAvailable => 'لا توجد باقات مميزة متاحة حالياً.';

  @override
  String noResultsFoundForSearchquery(String searchQuery) {
    return 'لا توجد نتائج لـ \'$searchQuery\'';
  }

  @override
  String get noSavedArticlesYet => 'لا توجد مقالات محفوظة بعد.';

  @override
  String get noShowsAvailable => 'لا توجد برامج متاحة';

  @override
  String get noStoriesFound => 'لم يتم العثور على قصص.';

  @override
  String get noWordsSelected => 'لم يتم تحديد كلمات';

  @override
  String get notes => 'ملاحظات';

  @override
  String get notoserifsc => 'NotoSerifSC';

  @override
  String get objectivesTitle => 'الأهداف';

  @override
  String get openInYoutube => 'فتح في يوتيوب';

  @override
  String get orderingHanddripCoffeeInShanghai =>
      'طلب القهوة المقطرة يدوياً في شنغهاي';

  @override
  String get orderingSugarcoatedHawsInWinterBeijing =>
      'طلب أسياخ التانغهولو (حلوى الزعرور) في بكين شتاءً';

  @override
  String partnerLang(String lang) {
    return 'الشريك ($lang)';
  }

  @override
  String get partnerListening => 'الشريك يستمع...';

  @override
  String get partnerSpeaking => 'الشريك يتحدث...';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get pause => 'إيقاف مؤقت';

  @override
  String get perfect => 'ممتاز!';

  @override
  String get personalizedPathBasedOnDeck => 'مسار مخصص يعتمد على مجموعتك.';

  @override
  String play(Object pinyin) {
    return 'استماع (بينيين)';
  }

  @override
  String get pleaseEnterMessageBeforeSending => 'يرجى إدخال رسالة قبل الإرسال.';

  @override
  String get practiceInRoleplay => 'التدرب في لعب الأدوار';

  @override
  String get practiceModes => 'أنماط التدريب';

  @override
  String get practicePronouncingWithAiGrading =>
      'تدرب على نطق هذه الكلمة مع تقييم الذكاء الاصطناعي';

  @override
  String get preparingReadingInterface => 'جارٍ تحضير واجهة القراءة...';

  @override
  String get privacy => 'الخصوصية';

  @override
  String get privacyAndAudio => 'الخصوصية والصوت';

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
      'بو سونغلينغ (1640–1715) كان كاتباً من عهد تشينغ أمضى عقوداً في جمع حكايات غريبة من استوديو الأديب بعد أن فشل مراراً في امتحانات الخدمة الإمبراطورية. قصصه الخارقة عن أرواح الثعالب والأشباح والأدباء لا تزال المعيار الذهبي للأدب الصيني الكلاسيكي الغرائبي.';

  @override
  String get qaFaq => 'الأسئلة الشائعة';

  @override
  String get questsTitle => 'المهام';

  @override
  String get quickBookmarks => 'إشارات مرجعية سريعة';

  @override
  String get radical => 'الجذر';

  @override
  String get ready => 'جاهز';

  @override
  String get readyToInterpret => 'جاهز للترجمة الفورية';

  @override
  String get readyToStart => 'جاهز للبدء.';

  @override
  String get recentBookmarks => 'الإشارات المرجعية الحديثة';

  @override
  String get refiningGrammar => 'جارٍ تحسين القواعد...';

  @override
  String get refresh => 'تحديث';

  @override
  String get removeFromSaved => 'إزالة من المحفوظات';

  @override
  String get removeFromSavedScenarios => 'إزالة من السيناريوهات المحفوظة';

  @override
  String get removed => 'تمت الإزالة';

  @override
  String get requestPermissions => 'طلب الأذونات';

  @override
  String get rescind => 'إلغاء';

  @override
  String get restore => 'استعادة';

  @override
  String get results => 'النتائج';

  @override
  String get resume => 'استئناف';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get revenuecatError => 'خطأ RevenueCat:';

  @override
  String revenuecatErrorE(String e) {
    return 'خطأ RevenueCat: $e';
  }

  @override
  String get reviewExtractedDeck => 'مراجعة المجموعة المستخرجة';

  @override
  String get reviewIn => 'مراجعة في';

  @override
  String get reviewingYourTones => 'جارٍ مراجعة نغماتك...';

  @override
  String get saveAll => 'حفظ الكل';

  @override
  String get saveScenario => 'حفظ السيناريو';

  @override
  String get saveThisScenario => 'حفظ هذا السيناريو';

  @override
  String get saved => 'تم الحفظ';

  @override
  String get scanAnother => 'مسح ضوئي آخر';

  @override
  String get scenarioRemoved => 'تمت إزالة السيناريو';

  @override
  String get scenarioSavedFindInCustomTab =>
      'تم حفظ السيناريو! تجده في علامة التبويب المخصصة.';

  @override
  String score(Object score, Object total) {
    return 'النتيجة: $score / $total';
  }

  @override
  String get searchByPinyinOrMeaning => 'ابحث بالبينيين أو المعنى...';

  @override
  String get searchByTitleOrTag => 'ابحث بالعنوان أو الوسم...';

  @override
  String get searchDictionaryOrTypeCustom =>
      'ابحث في القاموس أو اكتب كلمة مخصصة';

  @override
  String get searchHint => 'بحث...';

  @override
  String get searchOrEnterUrl => 'ابحث أو أدخل رابطاً';

  @override
  String get searchScenariosHint => 'ابحث عن سيناريوهات...';

  @override
  String get searchStoriesIdiomsNews => 'ابحث عن قصص وتعابير وأخبار...';

  @override
  String get searchTopicsEgCookingHistory =>
      'ابحث عن مواضيع (مثل: الطبخ، التاريخ)';

  @override
  String get seeAll => 'عرض الكل';

  @override
  String get selectADeck => 'اختر مجموعة';

  @override
  String get selectPracticeMode => 'اختر نمط التدريب';

  @override
  String get selectingHskVocabulary => 'جارٍ اختيار مفردات HSK...';

  @override
  String get send => 'إرسال';

  @override
  String get sendMessage => 'إرسال رسالة';

  @override
  String get serif => 'خط مذيل (Serif)';

  @override
  String get shadow => 'المحاكاة الصوتية (Shadowing)';

  @override
  String get shiNaianEpic =>
      'شي نايآن (حوالي 1296–1372) كان أديباً من عهد يوان قيل إنه اجتاز الامتحان الإمبراطوري لكنه اختار حياة العزلة العلمية. روايته حافة الماء، عن الأبطال الخارجين عن القانون والثورة الصالحة، أسست النموذج الأصلي للملحمة القتالية الصينية.';

  @override
  String get showEnglish => 'إظهار الإنجليزية';

  @override
  String get showEnglishTranslations => 'إظهار الترجمات الإنجليزية';

  @override
  String get showHanzi => 'إظهار الهانزي';

  @override
  String get showPinyin => 'إظهار البينيين';

  @override
  String get showTranslation => 'إظهار الترجمة';

  @override
  String get shows => 'البرامج';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get simplifiedArticle => 'مقال مبسط';

  @override
  String get simplifyingSubtitles => 'جارٍ تبسيط الترجمة...';

  @override
  String get sincereHonest => 'صادق؛ أمين';

  @override
  String get sleepTimer => 'مؤقت النوم';

  @override
  String get smartDeck => 'مجموعة ذكية';

  @override
  String get spanishAndWorld => 'الإسبانية والعالم';

  @override
  String get speaker => 'المتحدث';

  @override
  String get spotifyStylePlayer => 'مشغل على غرار سبوتيفاي';

  @override
  String get storyBookmarkedInLibrary =>
      'تمت إضافة القصة إلى الإشارات المرجعية في المكتبة!';

  @override
  String get streetFoodNightMarketInXian => 'سوق طعام الشارع الليلي في شيآن';

  @override
  String get strokes => 'الخطوط';

  @override
  String get studyCharacter => 'دراسة الرمز';

  @override
  String get subtitleOpacity => 'شفافية الترجمة';

  @override
  String get suggestion => 'اقتراح';

  @override
  String get summary => 'ملخص';

  @override
  String get supernaturalAndFolklore => 'ما وراء الطبيعة والفولكلور';

  @override
  String get swipeToGrade => 'اسحب للتقييم:';

  @override
  String get tableOfContents => 'جدول المحتويات';

  @override
  String get tapToRetry => 'اضغط لإعادة المحاولة';

  @override
  String get teaTastingInChengdu => 'تذوق الشاي في تشنغدو';

  @override
  String get techAndGadgets => 'التقنية والأجهزة';

  @override
  String get terms => 'الشروط';

  @override
  String get theGalaxyCharacters =>
      'خريطة المجرة في انتظارك.\nأتقن الشموس (الجذور) لفتح الكواكب (الرموز).';

  @override
  String get theme => 'المظهر';

  @override
  String get thinking => 'جارٍ التفكير...';

  @override
  String get thisArticleCharacters =>
      'يحتوي هذا المقال على رموز صينية تقليدية.';

  @override
  String get todaysWord => 'كلمة اليوم';

  @override
  String get togglePinyin => 'تبديل البينيين';

  @override
  String get toggleTranslation => 'تبديل الترجمة';

  @override
  String get toneDoesNotExistInMandarin =>
      'هذه النغمة غير موجودة في لغة الماندرين القياسية.';

  @override
  String get toneGraph => 'مخطط النغمات';

  @override
  String get traceLabel => 'تتبع';

  @override
  String get trailer => 'المقطع الترويجي';

  @override
  String get translatingAndAddingPinyin => 'جارٍ الترجمة وإضافة البينيين...';

  @override
  String get translatingText => 'جارٍ ترجمة النص...';

  @override
  String get turnOn => 'تشغيل';

  @override
  String get typeHanziPinyinOrEnglish => 'اكتب هانزي أو بينيين أو ترجمة...';

  @override
  String get unknown2 => '游戏 实况 王者荣耀 原神';

  @override
  String get unknown3 => '中国 美食 菜谱';

  @override
  String get unknown4 => '中国 科技 测评';

  @override
  String get unrollingTheScroll => 'جارٍ فتح اللفافة...';

  @override
  String get upperIntermediate => 'متوسط متقدم';

  @override
  String get vibrationsForInteractions => 'الاهتزاز عند التفاعل';

  @override
  String get video => 'فيديو';

  @override
  String get viewAnswer => 'عرض الإجابة';

  @override
  String get viewAsList => 'عرض كقائمة';

  @override
  String get viewBookmarks => 'عرض الإشارات المرجعية';

  @override
  String get viewMyDrawing => 'عرض رسمي';

  @override
  String get vlog => '中国 日常 vlog';

  @override
  String get voice => 'الصوت:';

  @override
  String get web => 'الويب';

  @override
  String get wedLoveToHearFromYou => 'يسعدنا\nسماع رأيك.';

  @override
  String get welcomeBack => 'مرحباً بعودتك';

  @override
  String get whatDoesThisMean => 'ماذا يعني هذا؟';

  @override
  String get whatHappensToMyChatHistory => 'ماذا يحدث لسجل الدردشة الخاص بي؟';

  @override
  String get whatIfAiMishears =>
      'ماذا لو أخطأ الذكاء الاصطناعي في فهم ما قصدت قوله؟';

  @override
  String get whichCharacterIs => 'أي رمز هو:';

  @override
  String get wikipedia => 'ويكيبيديا';

  @override
  String get wordsSavedAndSrsScheduled =>
      'تم حفظ الكلمات وجدولة المراجعة التكرارية!';

  @override
  String get writeYourMessageHere => 'اكتب رسالتك هنا...';

  @override
  String get wuChengenLiterature =>
      'وو تشنغإن (حوالي 1500–1582) كان روائياً من عهد مينغ من هوايان، جيانغسو. بالاعتماد على عقود من الفولكلور والرمزية البوذية والفطنة الساخرة، نسج أسطورة حج تانغ في رحلة إلى الغرب — واحدة من أكثر الأعمال إبداعاً ومحبة في الأدب العالمي.';

  @override
  String get wuJingziClass =>
      'وو جينغتسي (1701–1754) كان روائياً من عهد تشينغ من آنهوي تخلى عن ثروته الموروثة وأمضى حياته في كتابة العلماء — رواية ساخرة لاذعة تكشف الغرور والفساد وعبثية نظام الامتحانات الإمبراطورية وطبقة النبلاء العلماء.';

  @override
  String get xuZhonglinWarfare =>
      'شو تشونغلين (ازدهر في القرنين 16-17) كان مؤلفاً من عهد مينغ يُنسب إليه جمع تنصيب الآلهة (封神演义)، وهو عمل ضخم من الخيال الأسطوري يمزج بين تاريخ شانغ-تشو وعلم الكون الطاوي والبيروقراطية السماوية والحروب البطولية.';

  @override
  String get yearly => 'سنوي';

  @override
  String get yesReGradeMe => 'نعم، أعد تقييمي!';

  @override
  String you(Object lang) {
    return 'أنت ($lang)';
  }

  @override
  String get youAreSpeaking => 'أنت تتحدث';

  @override
  String get youLabel => 'أنت';

  @override
  String youLang(String lang) {
    return 'أنت ($lang)';
  }

  @override
  String get youMustAccount =>
      'يجب عليك قبول شروط الخدمة وسياسة الخصوصية لإنشاء حساب.';

  @override
  String get yourEchoModels =>
      'محادثات قاعة الصدى الخاصة بك تُخزَّن محلياً على جهازك لتتمكن من مراجعتها في أي وقت. نحن لا نستخدم محادثاتك الشخصية لتدريب نماذج الذكاء الاصطناعي الخاصة بنا.';

  @override
  String get zhOnly => 'الصينية فقط';

  @override
  String get hsk_1300_cards => '1300 بطاقة';

  @override
  String get hsk_154_cards => '154 بطاقة';

  @override
  String get hsk_162_cards => '162 بطاقة';

  @override
  String get hsk_2500_cards => '2500 بطاقة';

  @override
  String get hsk_299_cards => '299 بطاقة';

  @override
  String get hsk_602_cards => '602 بطاقة';

  @override
  String get added_to_review_queue => 'تمت الإضافة إلى قائمة المراجعة';

  @override
  String added_cards_to(int cardCount, String deckName) {
    return 'تمت إضافة $cardCount بطاقات إلى «$deckName».';
  }

  @override
  String added_to_your_library(Object hanzi) {
    return 'تمت إضافة \'$hanzi\' إلى مكتبتك';
  }

  @override
  String get advanced => 'متقدم';

  @override
  String get ai_stories => 'قصص بالذكاء الاصطناعي';

  @override
  String analysis_failed(Object error) {
    return 'فشل التحليل: $error';
  }

  @override
  String get analyzing_pronunciation_with_gemini_ai =>
      'جارٍ تحليل النطق باستخدام ذكاء Gemini الاصطناعي...';

  @override
  String get analyzing_your_pronunciation => 'جارٍ تحليل نطقك...';

  @override
  String are_you_sure_you_want_to(String deckName) {
    return 'هل أنت متأكد من رغبتك في حذف «$deckName» نهائيًا؟ لا يمكن التراجع عن هذا الإجراء وسيتم حذف جميع البطاقات بداخلها.';
  }

  @override
  String ask_about(String hanzi) {
    return 'اسأل عن $hanzi...';
  }

  @override
  String get audio_haptics => 'الصوت والاستجابة اللمسية';

  @override
  String get audio_could_not_start_check_your =>
      'تعذر تشغيل الصوت. تحقق من اتصالك وإعدادات الصوت في جهازك.';

  @override
  String get calligraphy_trace => 'تتبع مسار الخط';

  @override
  String chapters(Object count) {
    return '$count فصول';
  }

  @override
  String get char => 'رمز';

  @override
  String get chinese_character => 'رمز صيني';

  @override
  String get contact_us_and_report_issues => 'اتصل بنا وأبلغ عن المشكلات';

  @override
  String created_smart_deck_with_words(String deckName, int wordCount) {
    return 'تم إنشاء مجموعة ذكية: «$deckName» تحتوي على $wordCount كلمة!';
  }

  @override
  String get custom_ai_generated_story =>
      'قصة مخصصة تم إنشاؤها بواسطة الذكاء الاصطناعي.';

  @override
  String get display_content => 'العرض والمحتوى';

  @override
  String get do_you_keep_or_store_my =>
      'هل تحتفظون بتسجيلاتي الصوتية أو تخزنونها؟';

  @override
  String get elementary => 'ابتدائي';

  @override
  String error_creating_scenario(Object error) {
    return 'خطأ في إنشاء السيناريو: $error';
  }

  @override
  String error_fetching_translation_for(Object error) {
    return 'خطأ في جلب الترجمة: $error';
  }

  @override
  String error_loading_chapters(Object error) {
    return 'خطأ في تحميل الفصول: $error';
  }

  @override
  String get error_loading_decks => 'خطأ في تحميل المجموعات';

  @override
  String error_loading_microreads(Object error) {
    return 'خطأ في تحميل القراءات القصيرة: $error';
  }

  @override
  String error_loading_novels(Object error) {
    return 'خطأ في تحميل الروايات: $error';
  }

  @override
  String error_loading_poetry(Object error) {
    return 'خطأ في تحميل الشعر: $error';
  }

  @override
  String get etymology => 'أصل الرمز (Etymology): ';

  @override
  String get explanation => 'الشرح';

  @override
  String get extracted_text_tap_to_lookup => 'النص المستخرج (انقر للبحث)';

  @override
  String extraction_failed(Object error) {
    return 'فشل الاستخراج: $error';
  }

  @override
  String get failed_to_download => 'فشل التنزيل.';

  @override
  String failed_to_generate_scenario(Object error) {
    return 'فشل إنشاء السيناريو: $error';
  }

  @override
  String failed_to_generate_story(Object error) {
    return 'فشل إنشاء القصة:\n$error';
  }

  @override
  String failed_to_load_context(Object error) {
    return 'فشل تحميل السياق: $error';
  }

  @override
  String get feature_request => 'طلب ميزة';

  @override
  String get foundation => 'الأساسيات';

  @override
  String get how_is_my_pronunciation_scored => 'كيف يتم تقييم نطقي؟';

  @override
  String hsk(Object level) {
    return 'HSK $level';
  }

  @override
  String hsk_vocabulary(int hskLevel) {
    return 'مفردات HSK $hskLevel';
  }

  @override
  String get hsk_level => 'مستوى HSK';

  @override
  String get intermediate => 'متوسط';

  @override
  String get learning_stats => 'إحصائيات التعلم';

  @override
  String get mandarin => 'الماندارين';

  @override
  String get meaning => 'المعنى';

  @override
  String get no_decks_found => 'لم يتم العثور على مجموعات.';

  @override
  String no_results_found_for(Object searchQuery) {
    return 'لم يتم العثور على نتائج لـ \'$searchQuery\'';
  }

  @override
  String get no_when_you_use_echo_hall =>
      'لا. عندما تستخدم قاعة الصدى، أو تقييم العالِم، أو استوديو المحاكاة الصوتية (Shadowing)، يتم تقييم تسجيلك الصوتي بشكل آمن في الوقت الفعلي لتحديد درجة النطق ثم حذفه فورًا. نحن نحتفظ فقط بالدرجات الرقمية لتتبع تقدمك.';

  @override
  String get notification_settings => 'إعدادات الإشعارات';

  @override
  String get open_settings => 'فتح الإعدادات';

  @override
  String get phoneme => 'صوت لغوي (فونيم)';

  @override
  String get play_reference_pronunciation => 'تشغيل النطق المرجعي';

  @override
  String get please_select_a_deck_to_add =>
      'يرجى اختيار مجموعة لإضافة البطاقات إليها.';

  @override
  String get point_at_chinese_text_to_translate =>
      'وجّه الكاميرا نحو النص الصيني لترجمته';

  @override
  String get practice_writing_the_strokes_by_hand =>
      'تدرب على كتابة الخطوط يدويًا';

  @override
  String get preferences_audio_and_display => 'التفضيلات، الصوت، والعرض';

  @override
  String get preparing_your_scholars_verdict => 'جارٍ تحضير تقييم العالِم...';

  @override
  String get previous => 'السابق';

  @override
  String question(Object current, Object total) {
    return 'سؤال $current/$total';
  }

  @override
  String remove_from_this_deck(String hanzi) {
    return 'إزالة $hanzi من هذه المجموعة؟';
  }

  @override
  String revenuecat_error(Object error) {
    return 'خطأ RevenueCat: $error';
  }

  @override
  String get review_tomorrow => 'مراجعة غدًا';

  @override
  String get roleplay => 'لعب الأدوار';

  @override
  String saving_words_to(int wordCount, String deckName) {
    return 'جارٍ حفظ $wordCount كلمة في $deckName...';
  }

  @override
  String get search_radicals_eg_water => 'ابحث عن الجذور (مثل: الماء، 氵)';

  @override
  String get select_target_hsk_level => 'اختر مستوى HSK المستهدف';

  @override
  String get sentence => 'جملة';

  @override
  String get shadowing_studio_is_a_dedicated_space =>
      'استوديو المحاكاة الصوتية (Shadowing) هو مساحة مخصصة للتدرب على محاكاة المتحدثين الأصليين في الوقت الفعلي.';

  @override
  String simplify_failed(Object error) {
    return 'فشل التبسيط: $error';
  }

  @override
  String get sinospark_premium => 'SinoSpark المميز';

  @override
  String get speaking_pronunciation => 'التحدث والنطق';

  @override
  String get statistics => 'الإحصائيات';

  @override
  String get table_of_contents => 'جدول المحتويات · 目录';

  @override
  String get the_ai_evaluates_your_speech_across =>
      'يقيم الذكاء الاصطناعي نطقك عبر ثلاثة أبعاد:\n• الدقة: هل نطقت المقاطع الصوتية الصحيحة؟\n• الاكتمال: هل تخطيت أو نسيت أي كلمات؟\n• الطلاقة: هل توقفت بشكل طبيعي واستخدمت النغمات الصحيحة؟\nيقوم بمقارنة تسجيلك مع نماذج المتحدثين الأصليين لإعطاء درجة من 100.';

  @override
  String get this_cannot_be_undone => 'لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get title => 'العنوان';

  @override
  String get to_be_reviewed => 'مستحقة للمراجعة';

  @override
  String get traditional => 'تقليدي';

  @override
  String translation_failed(Object error) {
    return 'فشلت الترجمة: $error';
  }

  @override
  String get type_in => 'اكتب...';

  @override
  String get type_your_message_in => 'اكتب رسالتك بـ...';

  @override
  String get unable_to_open_this_video_please =>
      'تعذر فتح هذا الفيديو. يرجى المحاولة مرة أخرى لاحقًا.';

  @override
  String get view_your_learning_history_and_streaks =>
      'عرض سجل التعلم وسلسلة إنجازاتك';

  @override
  String get what_is_shadowing_studio =>
      'ما هو استوديو المحاكاة الصوتية (Shadowing)؟';

  @override
  String get words => 'كلمات';

  @override
  String your_path_for_is_ready(String deckName) {
    return 'مسارك لـ «$deckName» جاهز!';
  }

  @override
  String get you_said => '🗣️ ما نطقته';

  @override
  String vocabularyBatch(Object index) {
    return 'دفعة المفردات $index';
  }

  @override
  String get yourDailyDropIsHere => 'جرعتك اليومية هنا! ✨';

  @override
  String get timeToReview => 'حان وقت المراجعة! 📚';

  @override
  String get neverMissAStroke => 'لا تفوت أي خط! 🖌️';

  @override
  String get yourTrialEndsTomorrow => 'تنتهي فترتك التجريبية غدًا! ⏳';

  @override
  String get officialStandardVocabularyTiers =>
      'مستويات المفردات القياسية الرسمية';

  @override
  String get failedToLoadCollections => 'فشل تحميل المجموعات.';

  @override
  String unnamedKey(Object tag) {
    return '#$tag';
  }

  @override
  String error(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get aiSmartContext => 'السياق الذكي بالذكاء الاصطناعي';

  @override
  String get aiSmartContextError => 'خطأ في السياق الذكي بالذكاء الاصطناعي';

  @override
  String get downloadOfficialHskCollections => 'تنزيل مجموعات HSK الرسمية';

  @override
  String get unableToLoadThisSection =>
      'تعذر تحميل هذا القسم. يرجى المحاولة مرة أخرى.';

  @override
  String get translationLanguage => 'لغة الترجمة';

  @override
  String get dailyDrops => 'الجرعات اليومية';

  @override
  String get wordOfTheDayNews => 'كلمة اليوم والأخبار';

  @override
  String get reviewReminders => 'تذكيرات المراجعة';

  @override
  String get flashcardsDueForReview => 'البطاقات المستحقة للمراجعة';

  @override
  String get dailyNewCards => 'بطاقات جديدة يومية';

  @override
  String get dailyReviewLimit => 'حد المراجعة اليومي';

  @override
  String get practiceMode => 'وضع التدريب';

  @override
  String get liziqi => 'لي زي تشي (Liziqi): زهور الحرير';

  @override
  String get theLifeOfGarlicTraditional =>
      'حياة الثوم - الحياة الصينية التقليدية';

  @override
  String get graceMandarin50Phrases => 'غريس ماندراين: 50 عبارة';

  @override
  String get essentialChinesePhrasesForBeginners =>
      'عبارات صينية أساسية للمبتدئين';

  @override
  String get makingBambooFurniture => 'صناعة أثاث الخيزران';

  @override
  String get peppaPigChinese => 'بيبا بيغ بالصينية: الغميضة';

  @override
  String get muddyPuddlesBeginnerFriendly => 'برك موحلة - مناسب للمبتدئين';

  @override
  String get mandarinCorner300Verbs => 'ماندارين كورنر: 300 فعل';

  @override
  String get mostCommonChineseVerbs => 'الأفعال الصينية الأكثر شيوعًا';

  @override
  String get graceMandarinOrderFood => 'غريس ماندراين: طلب الطعام';

  @override
  String get howToOrderFoodIn => 'كيف تطلب الطعام في مطعم صيني';

  @override
  String get silkFlowersTraditionalCraft => 'زهور الحرير - حرفة تقليدية';

  @override
  String get mandarinCorner => 'ماندارين كورنر: تعلم الصينية - زيارة الطبيب';

  @override
  String get goingToTheDoctorReal => 'الذهاب إلى الطبيب - محادثة واقعية';

  @override
  String get hideAndSeekBeginnerFriendly => 'الغميضة - مناسب للمبتدئين';

  @override
  String get linGdp6 => 'شياو لين يقول: لماذا نمو الناتج المحلي الإجمالي 6%';

  @override
  String get why6GdpGrowthEasy =>
      'لماذا نمو الناتج المحلي الإجمالي 6% - اقتصاد صيني مبسط';

  @override
  String get bbcWorldNews => 'بي بي سي الصينية (أخبار العالم)';

  @override
  String get currentEventsInSimplifiedChinese => 'أحداث جارية بالصينية المبسطة';

  @override
  String get baidu => 'بايدو';

  @override
  String get youtubeDesk => 'ركن يوتيوب';

  @override
  String get interactiveTranscriptsShadowing => 'نصوص تفاعلية ومحاكاة صوتية';

  @override
  String get showsDramas => 'برامج ومسلسلات درامية';

  @override
  String get extractToDeck => 'استخراج إلى مجموعة';

  @override
  String get autoSimplify => 'تبسيط تلقائي';

  @override
  String get rewriteThisArticleToMatch =>
      'أعد كتابة هذا المقال ليتناسب مع مستوى HSK الخاص بك';

  @override
  String failedToSaveExtractedWords(Object error) {
    return 'فشل حفظ الكلمات المستخرجة: $error';
  }

  @override
  String addToDeck(Object count) {
    return 'أضف إلى المجموعة ($count)';
  }

  @override
  String get dailyDiscoveryDrop => 'جرعة الاكتشاف اليومية';

  @override
  String get smartSpacedRepetition => 'التكرار المتباعد الذكي';

  @override
  String get trialProtectionAlert => 'تنبيه حماية الفترة التجريبية';

  @override
  String get masteryLevel => 'مستوى الإتقان';

  @override
  String get targetObjective => 'الهدف المنشود';

  @override
  String get dailyPractice => 'التدريب اليومي';

  @override
  String get aiSpacedRepetition => 'التكرار المتباعد بالذكاء الاصطناعي';

  @override
  String get iVeGrantedAccess => 'لقد منحت الإذن';

  @override
  String get scanner => 'ماسح ضوئي';

  @override
  String get interpreter => 'مترجم فوري';

  @override
  String cards(Object count) {
    return '$count بطاقات';
  }

  @override
  String get nWaMendsTheHeavens => 'نويوا تصلح السماء';

  @override
  String get terracottaArmy => 'جيش الطين (التيراكوتا)';

  @override
  String get forbiddenCity => 'المدينة المحرمة';

  @override
  String get aBlessingInDisguise => 'رب ضارة نافعة';

  @override
  String get drawingASnake => 'رسم أقدام للأفعى (تكلّف لا داعي له)';

  @override
  String get takingTheBulletTrain => 'ركوب القطار السريع';

  @override
  String get visitingTheDoctor => 'زيارة الطبيب';

  @override
  String get orderingDumplings => 'طلب الزلابية';

  @override
  String get theTeaCeremony => 'مراسم الشاي';

  @override
  String get chineseCalligraphy => 'فن الخط الصيني';

  @override
  String get theGiantPanda => 'الباندا العملاقة';

  @override
  String get simplifiedText => 'نص مبسط';

  @override
  String get novels96 => 'روايات (96)';

  @override
  String get microReads => 'قراءات قصيرة';

  @override
  String get poetry => 'شعر';

  @override
  String get bookmarkRemoved => '书签已移除 · تمت إزالة الإشارة المرجعية';

  @override
  String bookmarkAdded(Object chapter) {
    return '已添加书签 · تمت إضافة إشارة مرجعية: الفصل $chapter';
  }

  @override
  String get readingVocabulary => 'القراءة والمفردات';

  @override
  String vocabularyBatchUnitindex1(Object index) {
    return 'دفعة المفردات $index';
  }

  @override
  String get yourDailyDropIsHere1 => 'جرعتك اليومية هنا! ✨';

  @override
  String get timeToReview1 => 'حان وقت المراجعة! 📚';

  @override
  String get neverMissAStroke1 => 'لا تفوت أي خط! 🖌️';

  @override
  String get yourTrialEndsTomorrow1 => 'تنتهي فترتك التجريبية غدًا! ⏳';

  @override
  String get hskCollections1 => 'مجموعات HSK';

  @override
  String get officialStandardVocabularyTiers1 =>
      'مستويات المفردات القياسية الرسمية';

  @override
  String get failedToLoadCollections1 => 'فشل تحميل المجموعات.';

  @override
  String ui__transcription(Object transcription) {
    return '\"$transcription\"';
  }

  @override
  String playPinyinwithtone(Object pinyinWithTone) {
    return 'استماع إلى $pinyinWithTone';
  }

  @override
  String errorE(Object e) {
    return 'خطأ: $e';
  }

  @override
  String lookalikepinyin(Object pinyin) {
    return '($pinyin)';
  }

  @override
  String get aiSmartContext1 => 'السياق الذكي بالذكاء الاصطناعي';

  @override
  String get aiSmartContextError1 => 'خطأ في السياق الذكي بالذكاء الاصطناعي';

  @override
  String errorErr(Object err, Object error) {
    return 'خطأ: $err';
  }

  @override
  String get downloadOfficialHskCollections1 => 'تنزيل مجموعات HSK الرسمية';

  @override
  String get unableToLoadThisSectionPleaseTryAga =>
      'تعذر تحميل هذا القسم. يرجى المحاولة مرة أخرى.';

  @override
  String get searchRadicalsEgWater => 'ابحث عن الجذور (مثل: الماء، 氵)';

  @override
  String ui__currentstrokeindex1totalstrokes(Object current, Object total) {
    return '$current/$total';
  }

  @override
  String get translationLanguage1 => 'لغة الترجمة';

  @override
  String get appLanguage1 => 'لغة التطبيق';

  @override
  String get dailyDrops1 => 'الجرعات اليومية';

  @override
  String get wordOfTheDayNews1 => 'كلمة اليوم والأخبار';

  @override
  String get reviewReminders1 => 'تذكيرات المراجعة';

  @override
  String get flashcardsDueForReview1 => 'بطاقات مستحقة للمراجعة';

  @override
  String get accuracyByMode1 => 'الدقة حسب الوضع';

  @override
  String accuracytostringasfixed1(Object accuracy) {
    return '$accuracy%';
  }

  @override
  String get upcomingReviewsNext7Days => 'المراجعات القادمة (خلال 7 أيام)';

  @override
  String get explaining => 'الشرح:';

  @override
  String entryhanziEntrypinyin(Object hanzi, Object pinyin) {
    return '$hanzi [$pinyin]';
  }

  @override
  String get dailyNewCards1 => 'بطاقات جديدة يومية';

  @override
  String get dailyReviewLimit1 => 'حد المراجعة اليومي';

  @override
  String get listeningMode1 => 'وضع الاستماع';

  @override
  String get readingMode1 => 'وضع القراءة';

  @override
  String get recallMode1 => 'وضع الاستدعاء الذهني';

  @override
  String get speakingMode1 => 'وضع التحدث';

  @override
  String get practiceMode1 => 'وضع التدريب';

  @override
  String acc(Object acc) {
    return '$acc%';
  }

  @override
  String get partner1 => 'الشريك';

  @override
  String get partnerSpeaking1 => 'الشريك يتحدث…';

  @override
  String get theLifeOfGarlicTraditionalChineseLi =>
      'حياة الثوم - الحياة الصينية التقليدية';

  @override
  String get graceMandarin50Phrases1 => 'غريس ماندراين: 50 عبارة';

  @override
  String get essentialChinesePhrasesForBeginners1 =>
      'عبارات صينية أساسية للمبتدئين';

  @override
  String get makingBambooFurniture1 => 'صناعة أثاث الخيزران';

  @override
  String get muddyPuddlesBeginnerFriendly1 => 'برك موحلة - مناسب للمبتدئين';

  @override
  String get mandarinCorner300Verbs1 => 'ماندارين كورنر: 300 فعل';

  @override
  String get mostCommonChineseVerbs1 => 'الأفعال الصينية الأكثر شيوعًا';

  @override
  String get graceMandarinOrderFood1 => 'غريس ماندراين: طلب الطعام';

  @override
  String get howToOrderFoodInAChineseRestaurant =>
      'كيفية طلب الطعام في مطعم صيني';

  @override
  String get silkFlowersTraditionalCraft1 => 'زهور الحرير - حرفة تقليدية';

  @override
  String get goingToTheDoctorRealLifeConversatio =>
      'الذهاب إلى الطبيب - محادثة واقعية';

  @override
  String get hideAndSeekBeginnerFriendly1 => 'الغميضة - مناسب للمبتدئين';

  @override
  String get lingdp6 => 'شياو لين يقول: لماذا نمو الناتج المحلي الإجمالي 6%';

  @override
  String get why6GdpGrowthEasyChineseEconomics =>
      'لماذا نمو الناتج المحلي الإجمالي 6% - اقتصاد صيني مبسط';

  @override
  String get currentEventsInSimplifiedChinese1 =>
      'الأحداث الجارية بالصينية المبسطة';

  @override
  String get baidu1 => 'بايدو';

  @override
  String get youtubeDesk1 => 'ركن يوتيوب';

  @override
  String get interactiveTranscriptsShadowing1 => 'نصوص تفاعلية ومحاكاة صوتية';

  @override
  String get showsDramas1 => 'برامج ومسلسلات درامية';

  @override
  String error_error(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get extractToDeck1 => 'استخراج إلى مجموعة';

  @override
  String get autosimplify => 'تبسيط تلقائي';

  @override
  String get rewriteThisArticleToMatchYourHskLev =>
      'أعد كتابة هذا المقال ليتناسب مع مستوى HSK الخاص بك';

  @override
  String get addToDeck1 => 'إضافة إلى المجموعة';

  @override
  String playbackratex(Object playbackRate) {
    return '${playbackRate}x';
  }

  @override
  String speedx(Object speed) {
    return '${speed}x';
  }

  @override
  String get dailyDiscoveryDrop1 => 'جرعة الاكتشاف اليومية';

  @override
  String get smartSpacedRepetition1 => 'التكرار المتباعد الذكي';

  @override
  String get trialProtectionAlert1 => 'تنبيه حماية الفترة التجريبية';

  @override
  String get masteryLevel1 => 'مستوى الإتقان';

  @override
  String get targetObjective1 => 'الهدف المنشود';

  @override
  String get dailyPractice1 => 'التدريب اليومي';

  @override
  String get aiSpacedRepetition1 => 'التكرار المتباعد بالذكاء الاصطناعي';

  @override
  String get iveGrantedAccess => 'لقد منحت الإذن';

  @override
  String addToDeck_selectedwordindiceslength(Object count) {
    return 'إضافة إلى المجموعة ($count)';
  }

  @override
  String get scanner1 => 'ماسح ضوئي';

  @override
  String get interpreter1 => 'مترجم فوري';

  @override
  String entryvalueCards(Object count) {
    return '$count بطاقات';
  }

  @override
  String score_score_questionslength(Object score, Object total) {
    return 'النتيجة: $score / $total';
  }

  @override
  String get theMonkeyKing1 => 'ملك القردة';

  @override
  String get huaMulan1 => 'هوا مولان';

  @override
  String get nwaMendsTheHeavens => 'نويوا تصلح السماء';

  @override
  String get confucius => 'كونفوشيوس';

  @override
  String get theGreatWall1 => 'سور الصين العظيم';

  @override
  String get terracottaArmy1 => 'جيش الطين (التيراكوتا)';

  @override
  String get forbiddenCity1 => 'المدينة المحرمة';

  @override
  String get aBlessingInDisguise1 => 'رب ضارة نافعة';

  @override
  String get drawingASnake1 => 'رسم أقدام للأفعى';

  @override
  String get takingTheBulletTrain1 => 'ركوب القطار السريع';

  @override
  String get visitingTheDoctor1 => 'زيارة الطبيب';

  @override
  String get orderingDumplings1 => 'طلب الزلابية';

  @override
  String get theTeaCeremony1 => 'مراسم الشاي';

  @override
  String get chineseCalligraphy1 => 'فن الخط الصيني';

  @override
  String get theGiantPanda1 => 'الباندا العملاقة';

  @override
  String get simplifiedText1 => 'نص مبسط';

  @override
  String get novels961 => 'روايات (96)';

  @override
  String get microreads => 'قراءات قصيرة';

  @override
  String get poetry1 => 'شعر';

  @override
  String get readingVocabulary1 => 'القراءة والمفردات';

  @override
  String get defaultfirebaseoptionsHaveNotBeenCo =>
      'لم يتم تكوين DefaultFirebaseOptions لنظام Linux.';

  @override
  String get defaultfirebaseoptionsAreNotSupport =>
      'DefaultFirebaseOptions غير مدعومة على هذه المنصة.';

  @override
  String get hanziMaster1 => 'هانزي ماستر';

  @override
  String get strokesCannotBeEmpty => 'لا يمكن أن تكون خطوط الحرف فارغة.';

  @override
  String get wrongStartPoint => 'نقطة بداية غير صحيحة.';

  @override
  String get rightShapeButWrongPlace => 'الشكل صحيح، لكن الموضع غير صحيح!';

  @override
  String get goodFollowTheFlow => 'جيد! اتبع مسار الخطوط.';

  @override
  String get aBitShaky => 'مهتز قليلاً!';

  @override
  String get aBitHesitant => 'متردد قليلاً...';

  @override
  String get shapeIsOff => 'الشكل غير دقيق.';

  @override
  String get arabic => 'العربية';

  @override
  String get german => 'الألمانية';

  @override
  String get spanish => 'الإسبانية';

  @override
  String get french => 'الفرنسية';

  @override
  String get hindi => 'الهندية';

  @override
  String get indonesian => 'الإندونيسية';

  @override
  String get italian => 'الإيطالية';

  @override
  String get japanese => 'اليابانية';

  @override
  String get korean => 'الكورية';

  @override
  String get portuguese => 'البرتغالية';

  @override
  String get russian => 'الروسية';

  @override
  String get vietnamese => 'الفيتنامية';

  @override
  String get microphonePermissionDenied => 'تم رفض إذن الميكروفون';

  @override
  String get offset => 'إزاحة';

  @override
  String get audioserviceHasBeenDisposed => 'تم إيقاف خدمة الصوت AudioService';

  @override
  String get fenrirZhcnyunxineural => 'فنرير (zh-CN-YunxiNeural)';

  @override
  String get charonZhcnyunyangneural => 'شارون (zh-CN-YunyangNeural)';

  @override
  String get koreZhcnxiaoxiaoneural => 'كوري (zh-CN-XiaoxiaoNeural)';

  @override
  String get aoedeZhcnxiaoyineural => 'أويدي (zh-CN-XiaoyiNeural)';

  @override
  String get puckZhcnyunjianneural => 'باك (zh-CN-YunjianNeural)';

  @override
  String get kore => 'كوري (أنثوي، دافئ)';

  @override
  String get xmicrosoftoutputformatAudio24khz48k =>
      'audio-24khz-48kbitrate-mono-mp3';

  @override
  String get useragentHanzimasterapp => 'HanziMasterApp';

  @override
  String get anchorWord => 'كلمة مرجعية';

  @override
  String get creativeThematicTitle => 'عنوان موضوعي إبداعي';

  @override
  String get briefPedagogicalOrSemanticRationale => 'مبرر تعليمي أو دلالي موجز';

  @override
  String get theSingleMostCentralCharacterFromTh =>
      'الرمز الأكثر أهمية في القائمة';

  @override
  String get aBalancedSetOfCharactersFromYourLib =>
      'مجموعة متوازنة من الرموز من مكتبتك.';

  @override
  String get yourNaturalConversationalReplyInChi =>
      'ردك الطبيعي في المحادثة بالرموز الصينية.';

  @override
  String get theEnglishTranslationOfYourReply => 'الترجمة العربية لردك.';

  @override
  String get thePinyinWithToneMarksForYourReply =>
      'البينيين مع علامات النغمات لردك.';

  @override
  String get aSuggestedResponseTheUserCouldSayBa =>
      'رد مقترح يمكن للمستخدم أن يقوله.';

  @override
  String get pinyinForTheSuggestion => 'البينيين للرد المقترح.';

  @override
  String get englishTranslationForTheSuggestion =>
      'الترجمة العربية للرد المقترح.';

  @override
  String get scholarsCritique => 'تقييم العالِم';

  @override
  String get theEchoHallRemainsSilentTryYourBrea =>
      'قاعة الصدى لا تزال صامتة. خذ نفسًا وحاول مجددًا.';

  @override
  String get xtitleHanziMaster => 'Hanzi Master';

  @override
  String get noneYet => 'لا يوجد حتى الآن.';

  @override
  String get exactSentence => 'الجملة تمامًا:';

  @override
  String get englishTranslation => 'الترجمة';

  @override
  String get previouslyGeneratedPhrases => 'العبارات المنشأة مسبقًا';

  @override
  String get iLikeDrinkingAppleJuice => 'أحب شرب عصير التفاح.';

  @override
  String get theEnglishMeaningHere => 'المعنى هنا...';

  @override
  String get failedToFetchDefinition => 'فشل جلب التعريف.';

  @override
  String get failedToLoadExplanation => 'فشل تحميل الشرح.';

  @override
  String get failedToLoadComparison => 'فشل تحميل المقارنة.';

  @override
  String get emptyResponseFromOpenrouter => 'استجابة فارغة من OpenRouter';

  @override
  String get emptyResponseFromVisionModel =>
      'استجابة فارغة من نموذج الرؤية (Vision)';

  @override
  String get standard => 'قياسي';

  @override
  String get theFullSentenceInChinese => 'الجملة الكاملة بالصينية...';

  @override
  String get theWordOrCharacterInChinese => 'الكلمة أو الرمز بالصينية';

  @override
  String get thePinyinForThisSpecificWord => 'البينيين لهذه الكلمة المحددة';

  @override
  String get emptyResponseFromDeepseekApi => 'استجابة فارغة من واجهة DeepSeek';

  @override
  String get criticalPutTheEnglishTranslationInT =>
      'هام: ضع الترجمة العربية في';

  @override
  String get englishTranslationOfTheEntireSenten =>
      'الترجمة العربية للجملة كاملة';

  @override
  String get hanziWord => 'رمز/كلمة هانزي';

  @override
  String get theFullSimplifiedSentenceInChinese =>
      'الجملة المبسطة الكاملة بالصينية...';

  @override
  String get lyingFlatACulturalMovement =>
      'الاستلقاء المسطح (Tang Ping): حركة ثقافية...';

  @override
  String get theUserYouAreSpeakingToIsNamed => 'المستخدم الذي تتحدث إليه اسمه';

  @override
  String get importantRuleDoNotAddressTheUserByA =>
      'قاعدة مهمة: لا تخاطب المستخدم بأي اسم. لا تستخدم أبدًا أسماء بديلة مثل';

  @override
  String get youAreAConciseChineseCalligraphyAnd =>
      'أنت معلم موجز للخط الصيني وأصول الرموز في تطبيق بطاقات تعليمية.';

  @override
  String get theStudentIsStudyingTheCharacter => 'المتعلم يدرس الرمز';

  @override
  String get neverWriteIntroductionsSignoffsOrFi =>
      'لا تكتب أبدًا مقدمات أو خاتمات أو عبارات حشو مثل';

  @override
  String get beDirectAndInformative => 'كن مباشرًا وغنيًا بالمعلومات.';

  @override
  String get criticalRuleYouMustRespondEntirelyI =>
      'قاعدة حاسمة: يجب أن تجيب بالكامل باللغة المطابقة لرمز ISO 639-1';

  @override
  String get youAreAConciseChineseGrammarTutorIn =>
      'أنت معلم موجز لقواعد اللغة الصينية داخل تطبيق هاتف.';

  @override
  String get theStudentIsConfusedAboutTheWord =>
      'المتعلم لديه التباس بشأن الكلمة';

  @override
  String get neverWriteIntroductionsSignoffsOrFi1 =>
      'لا تكتب أبدًا مقدمات أو خاتمات أو عبارات حشو.';

  @override
  String get azureSpeechApiKeysAreMissing =>
      'مفاتيح واجهة Azure Speech مفقودة.';

  @override
  String get success => 'تم بنجاح';

  @override
  String get granularity => 'مستوى التفصيل';

  @override
  String get phoneme1 => 'صوت لغوي (فونيم)';

  @override
  String get dimension => 'بُعد';

  @override
  String get comprehensive => 'شامل';

  @override
  String get weCouldntHearYouClearlyPleaseTryAga =>
      'لم نتمكن من سماعك بوضوح. يرجى المحاولة مرة أخرى.';

  @override
  String get noNbestResultFound => 'لم يتم العثور على نتائج NBest.';

  @override
  String get words1 => 'كلمات';

  @override
  String get word => 'كلمة';

  @override
  String get phonemes => 'أصوات لغوية';

  @override
  String get syllables => 'مقاطع صوتية';

  @override
  String get syllable => 'مقطع صوتي';

  @override
  String get omission => 'حذف';

  @override
  String get insertion => 'إضافة';

  @override
  String get youMissedThisWord => 'لقد فاتتك هذه الكلمة.';

  @override
  String get extraWordAddedHere => 'تمت إضافة كلمة زائدة هنا.';

  @override
  String get mispronunciation => 'نطق غير صحيح';

  @override
  String get pronunciationWasInaccurate => 'كان النطق غير دقيق.';

  @override
  String get goodEffortKeepPracticing => 'محاولة جيدة! واصل التدريب.';

  @override
  String get perfectPronunciationSoundsLikeANati =>
      'نطق مثالي! يبدو كنطق متحدث أصلي.';

  @override
  String get greatJobAFewMinorToneInaccuracies =>
      'عمل رائع! توجد بعض الأخطاء البسيطة في النغمات.';

  @override
  String get notBadButYourTonesNeedSomeWork =>
      'ليس سيئًا، لكن نغماتك تحتاج إلى بعض التدريب.';

  @override
  String get keepPracticingListenToTheNativeAudi =>
      'واصل التدريب! استمع إلى التسجيل الأصلي وحاول مجددًا.';

  @override
  String get lexical => 'معجمي';

  @override
  String get chineseHanziHere => 'رمز هانزي الصيني هنا';

  @override
  String get aShortSummaryInEnglish => 'ملخص موجز بالعربية';

  @override
  String get noCoherentChineseTextFoundInTheScan =>
      'لم يتم العثور على نص صيني واضح في المسح الضوئي.';

  @override
  String get theFullEnglishTranslationOfTheScann =>
      'الترجمة العربية الكاملة للنص الممسوح ضوئيًا... أو \'لم يتم العثور على نص صيني واضح.\'';

  @override
  String get aShort24WordTitleForThisScanEgResta =>
      'عنوان قصير من 2-4 كلمات لهذا المسح (مثل: \'قائمة مطعم\'، \'لافتة شارع\')';

  @override
  String get china => 'الصين';

  @override
  String get noTranslationAvailable => 'لا تتوفر ترجمة.';

  @override
  String get scanResults => 'نتائج المسح الضوئي';

  @override
  String get whenWasItWrittenAndWhatWasHappening =>
      'متى كُتب وماذا كان يحدث في الصين في ذلك الوقت؟';

  @override
  String get whyIsThisPieceFamousWhatPhilosophic =>
      'لماذا هذا العمل مشهور؟ وما هي الموضوعات الفلسفية أو الثقافية التي يتناولها؟';

  @override
  String get aBriefBioOfTheAuthor => 'نبذة موجزة عن المؤلف.';

  @override
  String get informationUnavailable => 'المعلومات غير متوفرة.';

  @override
  String get noSummaryAvailable => 'لا يتوفر ملخص.';

  @override
  String get hanziAiPro => 'SinoSpark AI Pro';

  @override
  String get trialNormalIntro => 'تجريبي، عادي، مقدمة';

  @override
  String get dailyDrop => 'الجرعة اليومية';

  @override
  String get dailyNotificationsForWordOfTheDayAn =>
      'إشعارات يومية لكلمة اليوم والأخبار';

  @override
  String get aNewWordAndStoryOfTheDayAreWaitingF =>
      'كلمة وقصة جديدة لليوم في انتظارك!';

  @override
  String get spacedRepetition => 'التكرار المتباعد';

  @override
  String get remindersForFlashcardsDueForReview =>
      'تنبيهات للبطاقات المستحقة للمراجعة';

  @override
  String get engagementReminders => 'تذكيرات التفاعل';

  @override
  String get trialReminders => 'تنبيهات الفترة التجريبية';

  @override
  String get notificationsForYourTrialStatus =>
      'إشعارات حول حالة فترتك التجريبية';

  @override
  String get comeReviewYourHanziAndTryALiveCallB =>
      'راجع رموز الهانزي وجرّب مكالمة مباشرة قبل انتهاء فترتك التجريبية المجانية!';

  @override
  String get scholarsEye => 'عين العالِم';

  @override
  String get clMeasureWord => 'كلمة كمية / مصنف (CL):';

  @override
  String get surnameShi => 'اسم العائلة شي';

  @override
  String get chineseFamilyNameShi => 'اسم العائلة الصيني (شي)';

  @override
  String get neutralToneLight => 'نغمة محايدة (خفيفة)';

  @override
  String get keepYourPitchHighAndSteadyLikeSingi =>
      'حافظ على طبقة صوتك عالية وثابتة كما لو كنت تغني نغمة موسيقية.';

  @override
  String get startInTheMiddleAndSlideYourPitchUp =>
      'ابدأ من طبقة متوسطة وارفع صوتك للأعلى كما لو كنت تسأل باستهجان \'ماذا؟\'';

  @override
  String get dipYourVoiceDownLowThenRiseGentlyBa =>
      'اخفض صوتك إلى طبقة منخفضة ثم ارفعه بلطف مجددًا.';

  @override
  String get dropYourPitchSharplyAndDecisivelyLi =>
      'اخفض طبقة صوتك بحدة وحسم كأنك تقول \'لا!\' بحزم.';

  @override
  String get pronounceSoftlyBrieflyAndWithoutEmp =>
      'انطق بخفة وإيجاز ودون تشديد.';

  @override
  String get spotOnPitchWasHighFlatAndSteady =>
      'ممتاز! كانت النغمة عالية ومستقرة وثابتة.';

  @override
  String get spotOnUpwardPitchRiseWasClear => 'ممتاز! كان تصاعد النغمة واضحًا.';

  @override
  String get spotOnLowDippingCurveWasAccurate =>
      'ممتاز! كان انخفاض النغمة وصعودها دقيقًا.';

  @override
  String get spotOnSharpFallingDropWasDecisive =>
      'ممتاز! كان هبوط النغمة حاسمًا ودقيقًا.';

  @override
  String get spotOnToneWasPronouncedAccurately => 'ممتاز! تم نطق النغمة بدقة.';

  @override
  String get iAgreeToTheTermsOfServiceAndPrivacy =>
      'أوافق على شروط الخدمة وسياسة الخصوصية.';

  @override
  String get sendMeOccasionalUpdatesTipsAndOffer =>
      'أرسل لي تحديثات ونصائح وعروضًا من حين لآخر.';

  @override
  String get signInToSyncYourProgress => 'سجّل الدخول لمزامنة تقدمك.';

  @override
  String get createAnAccountToSaveYourStats => 'أنشئ حسابًا لحفظ إحصائياتك.';

  @override
  String get smartSpiral => 'المسار الحلزوني الذكي';

  @override
  String get origin => 'الأصل';

  @override
  String get elements => 'العناصر';

  @override
  String get humanity => 'الإنسان والمجتمع';

  @override
  String get village => 'القرية';

  @override
  String get journey => 'الرحلة';

  @override
  String get city => 'المدينة';

  @override
  String get originTheSimplestShapesTheBeginning =>
      'أبسط الأشكال. بداية كل شيء.';

  @override
  String get elementsSunMoonWaterAndFireTheNatur =>
      'الشمس، القمر، الماء، والنار. العالم الطبيعي.';

  @override
  String get humanityTheBodyTheHeartAndTheFamily => 'الجسد، القلب، والعائلة.';

  @override
  String get villageFieldsRoofsAndToolsTheFounda =>
      'الحقول، الأسقف، والأدوات. أسس المجتمع.';

  @override
  String get journeyMovementSpeechAndSustenance => 'الحركة، الكلام، والمعيشة.';

  @override
  String get cityCommerceClothingAndComplexArtif =>
      'التجارة، الملابس، والتحف المعقدة.';

  @override
  String get equilibriumAlgorithm => 'خوارزمية التوازن';

  @override
  String get misc => 'متفرقات';

  @override
  String get cityOrOriginAs => '«المدينة» أو «الأصل» كـ';

  @override
  String get miscToOrigin => '«متفرقات» إلى «الأصل»';

  @override
  String get constellation => 'كوكبة';

  @override
  String get whichOneIsWater => 'أيٌّ منها يمثل «الماء»؟';

  @override
  String get whatIsThePinyin => 'ما هو البينيين؟';

  @override
  String get nature => 'الطبيعة';

  @override
  String get whatEssenceDoes => 'ما هو جوهر';

  @override
  String get allTiers => 'جميع المستويات';

  @override
  String get active => 'نشط';

  @override
  String get theScrollOfOrigin1 => 'لفافة الأصل';

  @override
  String galaxyOf1(Object name) {
    return 'مجرة $name';
  }

  @override
  String get also => 'أيضًا';

  @override
  String get work => 'عمل';

  @override
  String get cloud => 'سحابة';

  @override
  String get youArchaic => 'أنت (بصيغة كلاسيكية)';

  @override
  String get suddenly => 'فجأة';

  @override
  String get owner => 'مالك';

  @override
  String get door => 'باب';

  @override
  String get occupy => 'يشغل';

  @override
  String get nail => 'مسمار';

  @override
  String get and => 'و';

  @override
  String get buddhistNun => 'راهبة بوذية';

  @override
  String get anxious => 'قلق';

  @override
  String get sprout => 'برعم';

  @override
  String get exchange => 'تبادل';

  @override
  String get sheep => 'خروف';

  @override
  String get strange => 'غريب';

  @override
  String get opposite => 'عكس';

  @override
  String get shorttailedBird => 'طائر قصير الذيل';

  @override
  String get shoot => 'برعم / نبتة';

  @override
  String get small => 'صغير';

  @override
  String get gather => 'يجمع';

  @override
  String get order => 'ترتيب';

  @override
  String get flat => 'مسطح';

  @override
  String get thePersonWho => 'الشخص الذي...';

  @override
  String get nobleman => 'نبيل';

  @override
  String get cause => 'سبب';

  @override
  String get pig => 'خنزير';

  @override
  String get bright => 'مشرق';

  @override
  String get slowly => 'ببطء';

  @override
  String get give => 'يعطي';

  @override
  String get arrow => 'سهم';

  @override
  String get dry => 'جاف';

  @override
  String get obstacle => 'عقبة';

  @override
  String get beg => 'يتوسل';

  @override
  String get window => 'نافذة';

  @override
  String get fear => 'خوف';

  @override
  String get drum => 'طبل';

  @override
  String get why => 'لماذا';

  @override
  String get talent => 'موهبة';

  @override
  String get follow => 'يتبع';

  @override
  String get desert => 'صحراء';

  @override
  String get component => 'عنصر تركيبي';

  @override
  String divingInto1(Object topic) {
    return 'الانتقال إلى $topic';
  }

  @override
  String get unitIntro1 => 'مقدمة الوحدة';

  @override
  String get theBlueprint => 'المخطط الأساسي';

  @override
  String get theOrigin => 'الأصل';

  @override
  String get theGalaxy => 'المجرة';

  @override
  String get theScholarListens => 'العالِم يستمع...';

  @override
  String get consultingTheScrolls => 'مراجعة اللفافات القديمة...';

  @override
  String get traceWithTheGuide => 'تتبع مع الدليل';

  @override
  String get traceTheGhost => 'تتبع الخط الإرشادي';

  @override
  String get connectTheDots => 'صل النقاط';

  @override
  String get drawFromMemory => 'ارسم من الذاكرة';

  @override
  String get assistant => 'المساعد';

  @override
  String get puck => 'باك (رياضي)';

  @override
  String get helloWelcomeWhatWouldYouLikeToOrder =>
      'مرحباً! أهلاً وسهلاً. ماذا تود أن تطلب؟';

  @override
  String get ni3Hao3Huan1ying2Guang1lin2Qing3wen =>
      'Nǐ hǎo! Huānyíng guānglín. Qǐngwèn nǐ yào diǎn shénme?';

  @override
  String get waiterLi => 'النادل لي';

  @override
  String get askForTheMenu => 'اطلب قائمة الطعام';

  @override
  String get orderOneDishAndOneDrink => 'اطلب طبقاً واحداً ومشروباً واحداً';

  @override
  String get askForTheBill => 'اطلب الحساب';

  @override
  String get fenrir => 'فنرير (حيوي)';

  @override
  String get ni3Qu4Na3rAJi1chang3MaTing3Yuan3De =>
      'Nǐ qù nǎr a? Jīchǎng ma? Tǐng yuǎn de!';

  @override
  String get driverWang => 'السائق وانغ';

  @override
  String get tellTheDriverYouAreGoingToTheAirpor =>
      'أخبر السائق أنك متوجه إلى المطار';

  @override
  String get askHowLongTheTripWillTake => 'اسأل عن مدة الرحلة';

  @override
  String get complainAboutTheTraffic => 'تذمّر من الازدحام المروري';

  @override
  String get charon => 'شارون (إخباري)';

  @override
  String get thisClothingQualityIsEspeciallyGood =>
      'جودة هذه الملابس ممتازة حقًا، بـ 200 كواي فقط.';

  @override
  String get zhe4Jian4Yi1fuZhi4liang4Te4bie2Hao3 =>
      'Zhè jiàn yīfu zhìliàng tèbié hǎo, zhǐyào liǎng bǎi kuài.';

  @override
  String get auntieChen => 'العمة تشن';

  @override
  String get askHowMuchTheSilkShirtCosts => 'اسأل عن سعر القميص الحريري';

  @override
  String get sayItIsTooExpensive => 'قل إنه باهظ الثمن جداً';

  @override
  String get bargainThePriceDownTo100Rmb => 'ساوم على تخفيض السعر إلى 100 يوان';

  @override
  String get ni3Na3li3Bu4Shu1fuFa1shao1LeMa =>
      'Nǐ nǎlǐ bù shūfu? Fāshāo le ma?';

  @override
  String get drZhang => 'الدكتور تشانغ';

  @override
  String get explainYouHaveHadAHeadacheForTwoDay =>
      'اشرح أنك تعاني من صداع منذ يومين';

  @override
  String get sayYouHaveASlightFever => 'قل إن لديك حمى خفيفة';

  @override
  String get askIfYouNeedToTakeMedicine =>
      'اسأل عما إذا كنت بحاجة لتناول الدواء';

  @override
  String get aoede => 'أويدي (أنثوي، مبهج)';

  @override
  String get heyLongTimeNoSeeHowHaveYouBeenLatel =>
      'مرحباً! لم نرك منذ زمن، كيف حالك مؤخراً؟';

  @override
  String get ni3Hao3Hao3jiu3Bu4jian4Ni3Zui4jin4Z =>
      'Nǐ hǎo! Hǎojiǔ bùjiàn, nǐ zuìjìn zěnmeyàng?';

  @override
  String get pleaseIntroduceYourselfWhyDoYouWant =>
      'الرجاء تقديم نفسك. لماذا ترغب في العمل بشركتنا؟';

  @override
  String get qing3Xian1Zi4wo3Jie4shao4Yi1xia4Ni3 =>
      'Qǐng xiān zìwǒ jièshào yíxià. Nǐ wèishénme xiǎng lái wǒmen gōngsī gōngzuò?';

  @override
  String get managerLiu => 'المدير ليو';

  @override
  String get introduceYourProfessionalBackground =>
      'قدم خلفيتك المهنية باختصار';

  @override
  String get explainWhyYouWantToWorkAtThisCompan =>
      'اشرح لماذا ترغب في العمل بهذه الشركة';

  @override
  String get askAPoliteQuestionAboutTheCompanyCu =>
      'اطرح سؤالاً مهذباً عن ثقافة الشركة';

  @override
  String get microphoneAccessIsRequiredPleaseEna =>
      'مطلوب الإذن بالوصول إلى الميكروفون. يرجى تمكينه من إعدادات جهازك.';

  @override
  String get couldNotStartMicrophonePleaseCheckY =>
      'تعذر تشغيل الميكروفون. يرجى التحقق من إعدادات الصوت والمحاولة مرة أخرى.';

  @override
  String get weDidntQuiteCatchThatPleaseHoldTheM =>
      'لم نتمكن من سماع ذلك بوضوح. يرجى الضغط مطولاً على الميكروفون والمحاولة مجددًا!';

  @override
  String get recordingWasTooShortHoldTheMicAndSp =>
      'كان التسجيل قصيرًا جدًا. اضغط مع الاستمرار على الميكروفون وتحدث بوضوح.';

  @override
  String get audioBufferWasEmptyPleaseCheckYourM =>
      'مخزن الصوت المؤقت فارغ. يرجى التحقق من الميكروفون والمحاولة مرة أخرى.';

  @override
  String get audioFileIsSilentPleaseSpeakIntoThe =>
      'الملف الصوتي صامت. يرجى التحدث في الميكروفون.';

  @override
  String get weCouldntUnderstandYourPronunciatio =>
      'لم نتمكن من التعرف على نطقك. يرجى التحدث بوضوح والمحاولة مرة أخرى.';

  @override
  String get theServerIsTakingTooLongToRespondPl =>
      'استغرق الخادم وقتًا طويلاً للاستجابة. يرجى المحاولة مرة أخرى.';

  @override
  String get noInternetConnectionPleaseCheckYour =>
      'لا يوجد اتصال بالإنترنت. يرجى التحقق من الشبكة والمحاولة مرة أخرى.';

  @override
  String get audioProcessingFailedPleaseTryAgain =>
      'فشلت معالجة الصوت. يرجى المحاولة مرة أخرى.';

  @override
  String get permission => 'إذن';

  @override
  String get couldNotProcessYourRecordingPleaseT =>
      'تعذر معالجة تسجيلك. يرجى المحاولة مرة أخرى.';

  @override
  String get user => 'المستخدم';

  @override
  String get scholar => 'العالِم';

  @override
  String get ourAiTutorsAreCurrentlyOfflinePleas =>
      'معلمو الذكاء الاصطناعي غير متصلين حالياً، يرجى المحاولة لاحقاً.';

  @override
  String get hideTranslation => 'إخفاء الترجمة';

  @override
  String get azureAssessment => 'جارٍ تقييم Azure...';

  @override
  String get microphonePermissionRequired => 'إذن الميكروفون مطلوب';

  @override
  String get connectedSpeakNow => 'تم الاتصال! تحدث الآن.';

  @override
  String get initializationErrorCheckPermissions =>
      'خطأ في التهيئة. يرجى التحقق من الأذونات.';

  @override
  String get microphoneErrorTapToRetry =>
      'خطأ في الميكروفون. انقر لإعادة المحاولة.';

  @override
  String get theTutorReturnedAnEmptyResponse => 'أرجع المعلم استجابة فارغة.';

  @override
  String get connectionInterruptedPleaseSpeakAga =>
      'انقطع الاتصال. يرجى التحدث مجددًا.';

  @override
  String get callPausedReviewingTones =>
      'المكالمة متوقفة مؤقتًا (مراجعة النغمات)';

  @override
  String get pausedTakeABreak => 'متوقف مؤقتًا - خذ استراحة';

  @override
  String get goodStartPracticing => 'بداية جيدة للتدريب';

  @override
  String get studentCoach => 'طالب / مدرب';

  @override
  String get keepYour1stToneHighAndSteadyOn =>
      'حافظ على نبرتك الأولى عالية وثابتة عند';

  @override
  String get noScenariosFound => 'لم يتم العثور على سيناريوهات.';

  @override
  String get designYourOwnAiRoleplayExperience =>
      'صمم تجربة لعب الأدوار الخاصة بك بالذكاء الاصطناعي';

  @override
  String get generateFromDeck => 'إنشاء من المجموعة';

  @override
  String get practiceFlashcardVocabularyInALiveD =>
      'تدرب على مفردات البطاقات التعليمية في محادثة مباشرة';

  @override
  String get tapToRoleplay => 'انقر لبدء لعب الأدوار';

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
  String get dinnerWithDad => 'عشاء مع أبي';

  @override
  String get orderingAtAChengduTeahouse => 'الطلب في دار شاي بتشنغدو';

  @override
  String get buyingTeaAtTheMarket => 'شراء الشاي من السوق';

  @override
  String get meetingAnOldClassmate => 'لقاء زميل دراسة قديم';

  @override
  String get readyToPractice => 'هل أنت مستعد للتدريب؟';

  @override
  String get letsPracticeChinese => 'دعنا نتدرب على اللغة الصينية';

  @override
  String get areYouReady => 'هل أنت مستعد؟';

  @override
  String get discussWhatToHaveForDinner => 'مناقشة ما ستتناولانه على العشاء';

  @override
  String get suggestWatchingAMovieAfterwards => 'اقتراح مشاهدة فيلم بعد ذلك';

  @override
  String get askIfTheyWouldLikeTea =>
      'السؤال عما إذا كانوا يرغبون في تناول الشاي';

  @override
  String get helloVeryNiceToMeetYou => 'مرحباً! سررت جداً بلقائك.';

  @override
  String get deckPractice => 'تدريب المجموعة';

  @override
  String get practiceVocabularyWithAnAiPartner =>
      'تدرب على المفردات مع شريك ذكاء اصطناعي.';

  @override
  String get designCustomAiRoleplayConversation =>
      'صمم محادثة مخصصة ولعب أدوار بالذكاء الاصطناعي';

  @override
  String get random => 'عشوائي';

  @override
  String get scenarioTopic => 'موضوع السيناريو';

  @override
  String get contextSettingOptional => 'السياق والمكان (اختياري)';

  @override
  String get aiCharacterPersonaOptional => 'شخصية الذكاء الاصطناعي (اختياري)';

  @override
  String get aQuietBambooCourtyardTeahouseInChen =>
      'دار شاي هادئة بفناء من الخيزران في تشنغدو مع أنغام آلة الغوتشنغ الهادئة.';

  @override
  String get aBustlingSmokyNightMarketFilledWith =>
      'سوق ليلي صاخب يملؤه الدخان مع أسياخ الشواء، والخبز المطهو على البخار، وأكشاك طعام الشارع.';

  @override
  String get aLivelyHotpotRestaurantInChongqingW =>
      'مطعم هوت بوت حيوي في تشونغتشينغ مع مرق قرمزي يغلي ونكهة فلفل حار فواحة.';

  @override
  String get aBustlingTraditionalCantoneseTeahou =>
      'دار شاي كانتونية تقليدية صاخبة في غوانغتشو مليئة بسلال الخيزران البخارية.';

  @override
  String get aChicMinimalistCafeInTheFrenchConce =>
      'مقهى أنيق وبسيط في منطقة الامتياز الفرنسي في فترة ما بعد ظهر يوم أحد ممطر.';

  @override
  String get aWarmNorthernHomeKitchenDuringWinte =>
      'مطبخ منزلي دافئ في شمال الصين خلال الشتاء مع طحين على الطاولة وقدور زلابية يتصاعد منها البخار.';

  @override
  String get anOpenairNightStreetFoodAlleyWithSi =>
      'زقاق مفتوح لأطعمة الشارع ليلاً مع أسياخ لحم ضأن مشوية، وباذنجان محمص، ومشروبات باردة.';

  @override
  String get aSnowyStreetCornerOutsideTheLamaTem =>
      'زاوية شارع مغطاة بالثلوج أمام معبد لاما مع أسياخ التانغهولو (حلوى الزعرور) الحمراء اللامعة على الجليد.';

  @override
  String get craftBeerBreweryInQingdao => 'مصنع مشروبات حرفية في تشينغداو';

  @override
  String get aLivelyCoastalTaproomWithWoodenBarr =>
      'حانة ساحلية حيوية ببراميل خشبية، ونسيم البحر، وصنابير مشروبات القمح الطازجة.';

  @override
  String get sichuanCookingMasterclass => 'دورة متقدمة في فنون طهي سيتشوان';

  @override
  String get aVibrantOpenKitchenWithWoksBlazingC =>
      'مطبخ مفتوح نابض بالحياة مع مقالي الووك المشتعلة، وزيت الفلفل الحار الفوار، وحبات فلفل سيتشوان الطازجة.';

  @override
  String get highspeedRailSeatMixup => 'التباس في مقاعد القطار فائق السرعة';

  @override
  String get greatWallSunriseTrekInMutianyu =>
      'رحلة شروق الشمس على سور الصين العظيم في موتيانيو';

  @override
  String get theAncientStoneRampartsOfTheGreatWa =>
      'الأسوار الحجرية القديمة لسور الصين العظيم عند الفجر، محاطة بجبال خضراء ضبابية.';

  @override
  String get bambooRaftDriftOnGuilinLiRiver =>
      'جولة بطوافة الخيزران على نهر لي في غويلين';

  @override
  String get glidingAlongEmeraldKarstWatersBetwe =>
      'الإبحار على طول مياه الكارست الزمردية بين قمم الحجر الجيري الضبابية بالقرب من يانغشوو.';

  @override
  String get silkRoadCamelTrekInDunhuang =>
      'رحلة على ظهور الجمال على طريق الحرير في دونهوانغ';

  @override
  String get theRollingGoldenSandDunesOfMingshaM =>
      'الكثبان الرملية الذهبية لجبل مينغشا بجوار واحة بحيرة الهلال.';

  @override
  String get bookingACourtyardHomestayInDali =>
      'حجز إقامة في نُزُل تقليدي بفناء في دالي';

  @override
  String get aSereneBaistyleBoutiqueCourtyardHot =>
      'فندق بوتيكي هادئ على طراز قومية باي مع فناء يطل على بحيرة إرهاي في يونان.';

  @override
  String get potalaPalacePilgrimageInLhasa => 'زيارة قصر بوتالا في لاسا';

  @override
  String get theMajesticSundrenchedStoneStepsOut =>
      'الدرجات الحجرية المهيبة المغمورة بأشعة الشمس أمام قصر بوتالا مع عجلات الصلاة الدوارة.';

  @override
  String get aSubzeroWonderlandOfIlluminatedCrys =>
      'أرض عجائب جليدية تحت الصفر تضم قصورًا بلورية مضاءة ومنحوتات ثلجية شاهقة.';

  @override
  String get zhangjiajieAvatarMountainCableCar =>
      'تلفريك جبل أفاتار في تشانغجياجيه';

  @override
  String get suspendedHighInAGlassCableCarSoarin =>
      'معلق عاليًا في مقصورة تلفريك زجاجية تحلق فوق آلاف الأعمدة الرملية الشاهقة.';

  @override
  String get gobiDesertStargazingCampInGansu =>
      'مخيم لرصد النجوم في صحراء غوبي في قانسو';

  @override
  String get aLuxuryYurtCampUnderACrystalclearMi =>
      'مخيم خيام يورت فاخر تحت سماء درب التبانة الصافية في الصحراء بالقرب من جيايوجوان.';

  @override
  String get yangtzeRiverThreeGorgesCruise =>
      'رحلة بحرية عبر الخوانق الثلاثة لنهر اليانغتسي';

  @override
  String get onTheSunDeckOfARiverCruiseShipPassi =>
      'على السطح الشمسي لسفينة سياحية نهرية تعبر مضيق تشوتانغ المهيب والخلاب.';

  @override
  String get buyingAntiquesInBeijingPanjiayuan =>
      'شراء التحف في سوق بانجيايوان ببكين';

  @override
  String get aHistoricPotteryKilnFilledWithDelic =>
      'فرن فخار تاريخي مليء بمزهريات الخزف الدقيقة غير المحروقة وطلاء الكوبالت الأزرق.';

  @override
  String get suzhouSilkEmbroideryStudio => 'استوديو تطريز الحرير في سوتشو';

  @override
  String get aPeacefulCanalsideGardenStudioInSuz =>
      'استوديو حديقة هادئ على ضفة القناة في سوتشو بخيوط حريرية رفيعة وإطارات تطريز خشبية.';

  @override
  String get backstageAtATraditionalBeijingOpera =>
      'خلف كواليس مسرح أوبرا بكين التقليدية مع أزياء ملونة ومرايا وأغطية رأس متقنة.';

  @override
  String get traditionalChineseMedicineConsultat =>
      'استشارة في الطب الصيني التقليدي';

  @override
  String get morningTaiChiInTempleOfHeavenPark =>
      'ممارسة التاي تشي صباحًا في حديقة معبد السماء';

  @override
  String get beneathAncientCypressTreesAtDawnWit =>
      'تحت أشجار السرو العتيقة عند الفجر مع أصوات الطيور وكبار السن يمارسون حركات متزامنة.';

  @override
  String get rentingAHanfuForAPhotoShoot => 'استئجار زي هانفو لجلسة تصوير';

  @override
  String get aTraditionalCostumeBoutiqueNearTheW =>
      'متجر أزياء تقليدية بالقرب من البحيرة الغربية مع صفوف من أثواب أسرتي تانغ وسونغ.';

  @override
  String get guqinAncientZitherInstrumentWorksho =>
      'ورشة آلة الغوتشين (القيثارة الصينية القديمة)';

  @override
  String get aQuietPinewoodStudioInHangzhouFille =>
      'استوديو هادئ من خشب الصنوبر في هانغتشو مليء بآلات من خشب البولونيا المعتق وأوتار الحرير.';

  @override
  String get shaanxiShadowPuppetTheater => 'مسرح خيال الظل في شنشي';

  @override
  String get behindAnIlluminatedWhiteSilkScreenW =>
      'خلف شاشة حريرية بيضاء مضاءة مع دمى جلدية رقيقة لخيالات الظل.';

  @override
  String get chineseCalligraphyWorkshop => 'ورشة فن الخط الصيني';

  @override
  String get aTranquilStudioScentedWithPineSootI =>
      'استوديو هادئ تفوح منه رائحة حبر سخام الصنوبر ولفائف ورق الأرز وعبير الشاي.';

  @override
  String get adoptingACatAtAnAnimalShelter => 'تبني قطة من ملجأ للحيوانات';

  @override
  String get aCozyPetRescueCenterInHangzhouWithE =>
      'مركز دافئ لإنقاذ الحيوانات الأليفة في هانغتشو مع قطط نشيطة وشاي للزوار.';

  @override
  String get scriptMurderMysteryJubenshaGame =>
      'لعبة حل ألغاز الجرائم النصية (جوبينشا / Jubensha)';

  @override
  String get aThemedDetectiveLoungeInShanghaiWit =>
      'صالة تحريات ذات طابع خاص في شنغهاي مع لاعبين بأزياء تنكرية وأضواء الشموع.';

  @override
  String get vintageVinylRecordShopInShanghai =>
      'متجر أسطوانات فينيل كلاسيكية في شنغهاي';

  @override
  String get aHiddenVinylStoreInAnOldLaneHousePa =>
      'متجر أسطوانات مخفي في منزل أزقة قديم (Shikumen) مليء بأسطوانات الكانتوبوب والجاز من الثمانينيات.';

  @override
  String get ktvKaraokePartyWithFriends => 'حفلة كاريوكي KTV مع الأصدقاء';

  @override
  String get joiningACityBikeCyclingClub =>
      'الانضمام إلى نادٍ لركوب الدراجات في المدينة';

  @override
  String get aGatheringOfCyclistsByTheRiverfront =>
      'تجمع لراكبي الدراجات على ضفة النهر للاستعداد لجولة ليلية حول أفق المدينة.';

  @override
  String get blindBoxToyTradingMeetup =>
      'لقاء لتبادل دمى الصناديق الغامضة (Blind Box)';

  @override
  String get aColorfulPopcultureToyStoreInChaoya =>
      'متجر ألعاب ثقافة البوب الملون في تشاويانغ مع أرفف عرض وصناديق مقتنيات جديدة.';

  @override
  String get droneSkylineVideographyAtTheBund =>
      'تصوير أفق المدينة بالطائرة المسيرة (الدرون) في منطقة البوند';

  @override
  String get theBundPromenadeAtDuskOverlookingTh =>
      'ممشى البوند عند الغسق المطل على ناطحات السحاب المستقبلية المضاءة في بودونغ.';

  @override
  String get goldenRetrieverCafeInNanjing => 'مقهى غولدن ريتريفر في نانجينغ';

  @override
  String get aSunnyCheerfulPetCafeWithDozensOfFr =>
      'مقهى حيوانات أليفة مشمس ومبهج مع عشرات الكلاب الودودة تستقبل الزوار.';

  @override
  String get boulderingClimbingGymInChengdu =>
      'صالة تسلق الجدران (بولدرينغ) في تشنغدو';

  @override
  String get aModernIndoorClimbingGymWithVibrant =>
      'صالة تسلق داخلية حديثة مع مسارات ملونة وموسيقى حيوية.';

  @override
  String get aMassiveConventionHallFilledWithCol =>
      'قاعة مؤتمرات ضخمة مليئة بأجنحة ألعاب ملونة، وخلفيات للتصوير، وصناع محتوى بأزياء كوزبلاي.';

  @override
  String get askingForDirectionsInABeijingHutong =>
      'السؤال عن الاتجاهات في أحد أزقة الهوتونغ ببكين';

  @override
  String get aMazeOfHistoricGreybrickAlleysWithB =>
      'متاهة من الأزقة التاريخية المبنية بالطوب الرمادي مع دراجات، وأفنية تقليدية، وأشجار رمان.';

  @override
  String get buyingFreshFruitAtAWetMarket => 'شراء فواكه طازجة من السوق الشعبي';

  @override
  String get aLivelyMorningNeighborhoodMarketWit =>
      'سوق حي صباحي نابض بالحياة يضم أكوامًا من الليتشي والمانجو وفاكهة التنين الطازجة.';

  @override
  String get flowerMarketBouquetInKunming => 'باقة من سوق الزهور في كونمينغ';

  @override
  String get theFamousDounanFlowerMarketSurround =>
      'سوق دونان للزهور الشهير المحاط بآلاف الورود الطازجة والزنابق وأغصان الكافور.';

  @override
  String get tailorAlterationsInAnOldLaneHouse =>
      'تعديل الملابس عند خياط في منزل أزقة قديم';

  @override
  String get aTraditionalTailorShopFilledWithSew =>
      'محل خياطة تقليدي مليء بآلات الخياطة والأقمشة وأشرطة القياس.';

  @override
  String get expressParcelLockerRetrieval => 'استلام طرد من الخزائن الذكية';

  @override
  String get downstairsAtAResidentialApartmentGa =>
      'عند مدخل مبنى سكني بجوار نظام خزائن Hive الذكية.';

  @override
  String get bicycleFlatTireRepairAtCampusGate =>
      'إصلاح إطار دراجة مثقوب عند بوابة الحرم الجامعي';

  @override
  String get aSmallOutdoorRoadsideToolkitStandUn =>
      'كشك أدوات صغير على جانب الطريق في الهواء الطلق تحت شجرة بانيان مورقة.';

  @override
  String get techCompanyProductDemo => 'عرض توضيحي لمنتج شركة تقنية';

  @override
  String get aFuturisticTechConferenceBoothInShe =>
      'جناح مؤتمر تقني مستقبلي في شنتشن يعرض أحدث أجهزة الذكاء الاصطناعي.';

  @override
  String get ecommerceLivestreamStudio =>
      'استوديو بث مباشر للتجارة الإلكترونية';

  @override
  String get aHighenergyBroadcastStudioWithRingL =>
      'استوديو بث مفعم بالطاقة مع أضواء حلقية، وأرفف لعرض المنتجات، وشاشات للتعليقات المباشرة.';

  @override
  String get yiwuInternationalTradeMarket => 'سوق ييوو للتجارة الدولية';

  @override
  String get aVastMultistoryCommercialExhibition =>
      'مركز معارض تجاري ضخم متعدد الطوابق يضم ملايين المنتجات بالجملة والأعمال الحرفية.';

  @override
  String get universityCampusExchangeProgram =>
      'برنامج تبادل طلابي في الحرم الجامعي';

  @override
  String get aSunnyLawnOutsideTheUniversityLibra =>
      'حديقة مشمسة خارج مكتبة الجامعة مع طلاب يدرسون ويشربون شاي الحليب.';

  @override
  String get pleaseEnterAScenarioTopic => 'يرجى إدخال موضوع السيناريو.';

  @override
  String get nameTitle => 'الاسم (العنوان)';

  @override
  String get aiCharacter => 'شخصية الذكاء الاصطناعي';

  @override
  String get helloWelcomeHereWhatShallWeChatAbou =>
      'مرحبًا! أهلاً بك، عمَّ سنتحدث اليوم؟';

  @override
  String get greetYourConversationPartner => 'رحّب بشريك المحادثة';

  @override
  String get askAQuestionInChinese => 'اطرح سؤالاً باللغة الصينية';

  @override
  String get pinyinWithToneMarks => 'بينيين مع علامات النغمات';

  @override
  String get goal1InEnglish => 'الهدف 1 بالعربية';

  @override
  String get goal2InEnglish => 'الهدف 2 بالعربية';

  @override
  String get goal3InEnglish => 'الهدف 3 بالعربية';

  @override
  String get beginner => 'مبتدئ';

  @override
  String get hsk12 => 'HSK 1-2';

  @override
  String get hsk34 => 'HSK 3-4';

  @override
  String get hsk56 => 'HSK 5-6';

  @override
  String get master => 'متقن';

  @override
  String get azurePronunciationAssessment => 'تقييم النطق من Azure';

  @override
  String get tapToReview => 'انقر للمراجعة';

  @override
  String get overallScore => 'الدرجة الإجمالية';

  @override
  String get toneAccuracy => 'دقة النغمات';

  @override
  String get fluency => 'الطلاقة';

  @override
  String get report => 'تقرير';

  @override
  String get goodPronunciationButCanBeBetter => 'نطق جيد، ولكن يمكن تحسينه!';

  @override
  String get didYouMeanToSay => 'هل كنت تقصد أن تقول...؟';

  @override
  String get greatKeepTrying => 'رائع! واصل المحاولة!';

  @override
  String get completeness => 'الاكتمال';

  @override
  String get targetTone => 'النغمة المستهدفة';

  @override
  String get k4toneComparisonTapToListen =>
      'مقارنة النغمات الأربع (انقر للاستماع):';

  @override
  String get youSpokeMatch => 'ما نطقته (مطابق!)';

  @override
  String get youSpoke => 'ما نطقته';

  @override
  String get yourPrimaryCollectionOfCharacters => 'مجموعتك الأساسية من الرموز.';

  @override
  String get deckNotFound => 'المجموعة غير موجودة';

  @override
  String get cannotDeleteTheDefaultDeck => 'لا يمكن حذف المجموعة الافتراضية';

  @override
  String get hsk4UpperIntermediate1 => 'HSK 4: متوسط متقدم';

  @override
  String get theFirst150CharactersToStartYourJou => 'أول 150 رمزًا لبدء رحلتك.';

  @override
  String get buildYourVocabularyTo300EssentialWo =>
      'ابنِ مفرداتك لتصل إلى 300 كلمة أساسية.';

  @override
  String get masterConversationalFluencyWith600W =>
      'أتقن الطلاقة في المحادثة بـ 600 كلمة.';

  @override
  String get readTextsAndConverseFluentlyWith120 =>
      'اقرأ النصوص وتحدث بطلاقة بـ 1200 كلمة.';

  @override
  String get readNewspapersAndWatchMoviesWith250 =>
      'اقرأ الصحف وشاهد الأفلام بـ 2500 كلمة.';

  @override
  String get databaseBoxNotOpen => 'قاعدة البيانات غير مفتوحة';

  @override
  String get hsk1DataFileIsEmpty => 'ملف بيانات HSK 1 فارغ';

  @override
  String get gold => 'ذهب';

  @override
  String get globalDictionaryNotInitialized => 'القاموس العام غير مهيأ';

  @override
  String get reading => 'القراءة';

  @override
  String get recall => 'الاستدعاء الذهني';

  @override
  String get speaking => 'التحدث';

  @override
  String get listening1 => 'الاستماع';

  @override
  String get practiceStrokeOrderWithVisualGuides =>
      'تدرب على ترتيب الخطوط مع أدلة بصرية.';

  @override
  String get seeTheCharacterRecallThePinyinAndMe =>
      'شاهد الرمز، واسترجع البينيين والمعنى.';

  @override
  String get seeTheMeaningDrawTheCharacterFromMe =>
      'شاهد المعنى، وارسم الرمز من الذاكرة.';

  @override
  String get readOutLoudToTestYourPronunciationT =>
      'اقرأ بصوت عالٍ لاختبار نغمات نطقك.';

  @override
  String get listenToTheAudioAndIdentifyTheChara =>
      'استمع إلى الصوت وتعرف على الرمز.';

  @override
  String get contract => 'عقد';

  @override
  String get whoeverImplementsMeMustBeAbleToDoTh =>
      'يجب على من يطبق هذه الواجهة أن يكون قادرًا على تنفيذ هذه المهام.';

  @override
  String get koreFenrirCharonAoedePuckOrLocal =>
      'كوري، فنرير، شارون، أويدي، باك، أو محلي';

  @override
  String get manageDecks => 'إدارة المجموعات';

  @override
  String get weRanIntoTroubleLoadingTheLibraryPl =>
      'واجهنا مشكلة في تحميل المكتبة. يرجى المحاولة مرة أخرى.';

  @override
  String get noCharactersInLexicon1 => 'لا توجد رموز في المعجم';

  @override
  String get masterTheBuildingBlocks => 'أتقن اللبنات الأساسية';

  @override
  String get other => 'أخرى';

  @override
  String get required => 'مطلوب';

  @override
  String get library1 => 'المكتبة';

  @override
  String get youAreAPremiumMember => 'أنت عضو في SinoSpark Premium';

  @override
  String get createAccountToSyncProgress => 'إنشاء حساب لمزامنة التقدم';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get account => 'الحساب';

  @override
  String get guestScholar => 'عالِم ضيف';

  @override
  String get localAccount => 'حساب محلي';

  @override
  String get unknownRadical => 'جذر غير معروف';

  @override
  String get followTheGuideStroke => 'اتبع الخط الإرشادي';

  @override
  String get strokeAnimationSpeed => 'سرعة حركة رسم الخطوط';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get deutsch => 'الألمانية';

  @override
  String get bahasaIndonesia => 'الإندونيسية';

  @override
  String get italiano => 'الإيطالية';

  @override
  String get today1d2d3d4d5d6d =>
      'اليوم، يوم واحد، يومان، 3 أيام، 4 أيام، 5 أيام، 6 أيام';

  @override
  String get targetDeck => 'المجموعة المستهدفة';

  @override
  String get mixed => 'مختلط';

  @override
  String get topicForContext => 'الموضوع (للسياق)';

  @override
  String get nounsOnly => 'أسماء فقط';

  @override
  String get verbsOnly => 'أفعال فقط';

  @override
  String get idiomsChengyu => 'تعبيرات اصطلاحية (تشنغيو)';

  @override
  String get fullSentences => 'جمل كاملة';

  @override
  String get beginnerHsk12 => 'مبتدئ (HSK 1-2)';

  @override
  String get intermediateHsk34 => 'متوسط (HSK 3-4)';

  @override
  String get advancedHsk56 => 'متقدم (HSK 5-6)';

  @override
  String get generatedByAi => 'تم إنشاؤه بواسطة الذكاء الاصطناعي';

  @override
  String get canYouGiveMeTwoMoreExamplesUsingThi =>
      'هل يمكنك إعطائي مثالين إضافيين باستخدام هذه الكلمة؟';

  @override
  String get whatAreSomeSimilarWordsAndHowDoThey =>
      'ما هي بعض الكلمات المشابهة وما الفرق بينها؟';

  @override
  String get isThisWordUsedInSpokenOrWrittenChin =>
      'هل تُستخدم هذه الكلمة في الصينية المنطوقة أم المكتوبة أكثر؟';

  @override
  String get areThereOtherWaysToTranslateThisWor =>
      'هل هناك طرق أخرى لترجمة هذه الكلمة؟';

  @override
  String get whatAreCommonWordsThatGoTogetherWit =>
      'ما هي الكلمات الشائعة التي تقترن بهذه الكلمة؟';

  @override
  String get whatAreCommonMistakesLearnersMakeWi =>
      'ما هي الأخطاء الشائعة التي يرتكبها المتعلمون مع هذه الكلمة؟';

  @override
  String get emptyResponse => 'استجابة فارغة';

  @override
  String get whatIsTheOracleBoneScriptOriginOfTh =>
      'ما هو أصل هذا الرمز في نقوش عظام العرافة (أوراكل)؟';

  @override
  String get howDidTheAncientFormOfThisCharacter =>
      'كيف تطور الشكل القديم لهذا الرمز عبر التاريخ؟';

  @override
  String get giveMe3CommonWordsThatContainThisCh =>
      'أعطني 3 كلمات شائعة تحتوي على هذا الرمز.';

  @override
  String get whatOtherCharactersShareTheSameRadi =>
      'ما هي الرموز الأخرى التي تشترك في نفس الجذر؟';

  @override
  String get isThereAChineseProverbOrSayingFeatu =>
      'هل هناك مثل صيني أو حكمة تتضمن هذا الرمز؟';

  @override
  String get explainTheStrokeOrderRulesForThisCh =>
      'اشرح قواعد ترتيب خطوط هذا الرمز.';

  @override
  String get giveMeOneCalligraphyTipForWritingTh =>
      'أعطني نصيحة واحدة في فن الخط لكتابة هذا الرمز بجمالية.';

  @override
  String get isThereAnythingTrickyAboutUsingThis =>
      'هل هناك أي خصوصية نحوية معقدة في استخدام هذا الرمز؟';

  @override
  String get whatWordsAreCommonlyConfusedWithThi =>
      'ما هي الكلمات التي غالبًا ما يُخلط بينها وبين هذه الكلمة ولماذا؟';

  @override
  String get doesThisCharacterCarryCulturalSymbo =>
      'هل يحمل هذا الرمز دلالة رمزية أو ثقافية في الصين؟';

  @override
  String get isThisCharacterCommonlySeenInChines =>
      'هل يظهر هذا الرمز بشكل شائع في الأفلام أو الأغاني أو النصوص الصينية؟';

  @override
  String get whatDoesTheRadicalOfThisCharacterMe => 'ماذا يعني جذر هذا الرمز؟';

  @override
  String get breakDownEveryComponentAndItsMeanin =>
      'فكك كل مكون ومعناه بالتفصيل.';

  @override
  String get giveMeATrickToRememberTheCorrectTon =>
      'أعطني وسيلة لتذكر النغمة الصحيحة لهذا الرمز.';

  @override
  String get areThereCommonHomophonesThatAreOfte =>
      'هل هناك كلمات متجانسة صوتيًا يُخلط بينها وبين هذا الرمز؟';

  @override
  String get quotaExceeded => 'تم تجاوز الحد المسموح';

  @override
  String get mustProvideEitherCardOrCards => 'يجب توفير بطاقة أو بطاقات';

  @override
  String get deckSettings => 'إعدادات المجموعة';

  @override
  String get saveSettings => 'حفظ الإعدادات';

  @override
  String get sealRed => 'ختم أحمر';

  @override
  String get sealScript => 'خط الختم الصيني (Seal Script)';

  @override
  String get startYourStreak => 'ابدأ سلسلتك';

  @override
  String get traditionalCharacter => 'رمز تقليدي';

  @override
  String get inQueue => 'في قائمة الانتظار';

  @override
  String get tapToListenAgain => 'انقر للاستماع مجددًا';

  @override
  String get contextClue => 'دليل سياقي';

  @override
  String get microphonePermissionRequired1 => 'إذن الميكروفون مطلوب.';

  @override
  String get recordingFailedNoFile => 'فشل التسجيل (لم يتم إنشاء ملف).';

  @override
  String get holdToSpeakOptional => 'اضغط للتحدث (اختياري)';

  @override
  String get microphonePermissionDeniedEnableItI =>
      'تم رفض إذن الميكروفون. يرجى تفعيله من الإعدادات لاستخدام استوديو المحاكاة الصوتية (Shadowing).';

  @override
  String get sessionSummary => 'ملخص الجلسة';

  @override
  String get hereAreTheCharactersYouStruggledWit =>
      'إليك الرموز التي واجهت صعوبة فيها:';

  @override
  String get applySessionGradesToSpacedRepetitio =>
      'تطبيق تقييمات الجلسة على التكرار المتباعد (وضع التحدث)';

  @override
  String get masterYourMandarinPronunciationnbyM =>
      'أتقن نطقك للغة الماندرين\nمن خلال محاكاة النطق الأصلي.';

  @override
  String get aiIsGradingYourPronunciation => 'الذكاء الاصطناعي يقيم نطقك...';

  @override
  String get holdMicToRecordReleaseToGrade =>
      'اضغط مطولاً على الميكروفون للتسجيل، ثم اتركه للتقييم.';

  @override
  String get tapAnySyllableToAuditionAll4Tones =>
      'انقر على أي مقطع صوتي للاستماع إلى النغمات الأربع:';

  @override
  String get freeFlowConversationalPractice => 'تدريب محادثة حرة.';

  @override
  String get failedToGeneratePhrasePleaseTryAgai =>
      'فشل إنشاء العبارة. يرجى المحاولة مرة أخرى.';

  @override
  String get recordingTooShortHoldTheMicButtonLo =>
      'التسجيل قصير جدًا. اضغط على زر الميكروفون لفترة أطول.';

  @override
  String get recordingErrorPleaseTryAgain =>
      'خطأ في التسجيل. يرجى المحاولة مرة أخرى.';

  @override
  String get noRecordingCapturedPleaseTryAgain =>
      'لم يتم التقاط أي تسجيل. يرجى المحاولة مرة أخرى.';

  @override
  String get recordedAudioIsEmptyPleaseTryAgainA =>
      'التسجيل الصوتي فارغ. يرجى المحاولة مرة أخرى والتحدث بوضوح.';

  @override
  String get azureSpeechApiKeysAreMissing1 => 'مفاتيح Azure Speech API مفقودة';

  @override
  String get azureError401 => 'خطأ Azure 401';

  @override
  String get azureAuthenticationFailedCheckYourS =>
      'فشلت مصادقة Azure. تحقق من مفتاح Speech API والمنطقة في .env';

  @override
  String get azureError429 => 'خطأ Azure 429';

  @override
  String get azureQuotaExceededTryAgainLater =>
      'تم تجاوز حصة Azure. يرجى المحاولة لاحقًا.';

  @override
  String get azureGradingTimedOutCheckYourIntern =>
      'انتهت مهلة تقييم Azure. تحقق من اتصالك بالإنترنت.';

  @override
  String get recognitionFailedNull => 'فشل التعرف: قيمة فارغة';

  @override
  String get couldNotHearYouClearlyPleaseTryAgai =>
      'لم نتمكن من سماعك بوضوح. يرجى المحاولة مرة أخرى.';

  @override
  String get singlePhrasePractice => 'تدريب على عبارة واحدة';

  @override
  String get failedToGeneratePhrase => 'فشل إنشاء العبارة';

  @override
  String get omitted => 'محذوف';

  @override
  String get partial => 'جزئي';

  @override
  String get mispronounced => 'نطق غير دقيق';

  @override
  String get startSession1 => 'بدء الجلسة';

  @override
  String get chinese => 'الصينية';

  @override
  String get paused => 'متوقف مؤقتًا';

  @override
  String get translationFailed => 'فشلت الترجمة';

  @override
  String get engagingMacroeconomicAndBusinessBre =>
      'تحليلات اقتصادية كلية وتجارية شيقة تُقدم بأسلوب سردي ممتع.';

  @override
  String get exploresWorldEconomiesBankingHistor =>
      'استكشاف اقتصادات العالم وتاريخ البنوك وديناميكيات الصناعة العالمية.';

  @override
  String get clearArticulateMandarinPerfectForIn =>
      'لغة ماندرين واضحة ومتقنة، مثالية للمتعلمين في المستويين المتوسط والمتقدم.';

  @override
  String get chefWang => 'الشيف وانغ';

  @override
  String get masterSichuanCulinaryTechniquesTaug =>
      'أتقن فنون طهي سيتشوان مباشرة من رئيس طهاة محترف.';

  @override
  String get stepbystepAuthenticChineseRecipesWi =>
      'وصفات صينية أصيلة خطوة بخطوة مع إتقان استخدام مقلاة الووك والسكين.';

  @override
  String get conciseCulinaryVocabularyAndClearIn =>
      'مفردات طهي موجزة وتعليمات واضحة بلغة ماندرين طبيعية.';

  @override
  String get cinematographyCuttingedgeCameraTech =>
      'تصوير سينمائي، وتقنيات كاميرا متطورة، ومراجعات متعمقة للإعلام الرقمي.';

  @override
  String get highproductionDocumentaryStyleExplo =>
      'أسلوب وثائقي عالي الإنتاج يستكشف صناعة الفيديو وابتكارات الذكاء الاصطناعي.';

  @override
  String get richTechnicalMandarinWithCrystalcle =>
      'لغة ماندرين تقنية غنية بنطق واضح وترجمات مرئية.';

  @override
  String get indepthInvestigativeJournalismAndCu =>
      'صحافة استقصائية متعمقة وتحليلات للشؤون الجارية.';

  @override
  String get criticalPerspectivesOnSocialPhenome =>
      'رؤى نقدية حول الظواهر الاجتماعية والأخبار العالمية والتاريخ.';

  @override
  String get formalInvestigativeDiscourseIdealFo =>
      'خطاب استقصائي رسمي مثالي لتطوير مهارة الاستماع المتقدم.';

  @override
  String get bitesizedAnimatedScienceDocumentari =>
      'أفلام وثائقية علمية متحركة وموجزة تجيب عن تساؤلات الحياة اليومية.';

  @override
  String get exploresPhysicsBiologyAndEverydayCu =>
      'استكشاف الفيزياء والأحياء والفضول اليومي برسوم بيانية ممتعة.';

  @override
  String get standardBeijingMandarinWithWellpace =>
      'لغة ماندرين قياسية بلهجة بكين مع سرد منتظم وترجمات واضحة.';

  @override
  String get heartwarmingStreetFoodAdventuresAnd =>
      'مغامرات طعام الشارع الممتعة ومحادثات أصيلة من مختلف أنحاء الصين.';

  @override
  String get exploresRegionalHumanStoriesFamilyT =>
      'استكشاف القصص الإنسانية المحلية، والتقاليد العائلية، والأكلات الإقليمية.';

  @override
  String get naturalConversationalMandarinWithDa =>
      'لغة ماندرين حوارية طبيعية مع تعبيرات دارجة ودفء إنساني.';

  @override
  String get humorousAndHonestConsumerElectronic =>
      'مراجعات فكاهية وصادقة للإلكترونيات الاستهلاكية من واقع التجربة الفعلية.';

  @override
  String get testingSmartphonesSmartHomeGadgetsA =>
      'اختبار الهواتف الذكية وأجهزة المنزل الذكي وأحدث التقنيات اليومية.';

  @override
  String get relaxedHumorousConversationalDialog =>
      'حوارات عفوية وممتعة مليئة بالعبارات الشائعة الحديثة.';

  @override
  String get seanKitchen => 'مطبخ شون';

  @override
  String get deliciousHomecookedChineseDishesAnd =>
      'أطباق صينية منزلية شهية وإعادة إعداد أشهر وجبات الشارع.';

  @override
  String get easytofollowKitchenTipsForCookingAu =>
      'نصائح مطبخ سهلة التطبيق لطهي أطباق آسيوية أصيلة ومريحة.';

  @override
  String get warmInvitingCommentaryWithPractical =>
      'تعليق دافئ وممتع مع مفردات مطبخ عملية.';

  @override
  String get chineseChannel => 'القناة الصينية';

  @override
  String get structuredChineseLanguageLessonsAnd =>
      'دروس لغة صينية منظمة وبرامج لاكتشاف الثقافة.';

  @override
  String get grammarPointsHskVocabularyBuildingA =>
      'قواعد لغوية، وبناء مفردات HSK، وتراكيب للمحادثة.';

  @override
  String get clearEducationalPacingTailoredSpeci =>
      'وتيرة تعليمية واضحة ومصممة خصيصًا لمتعلمي اللغة الصينية.';

  @override
  String get oneInABillion => 'واحد من مليار';

  @override
  String get intimatePortraitsAndStoriesOfUnique =>
      'قصص ملهمة ولمحات شخصية لأفراد مميزين في الصين المعاصرة.';

  @override
  String get exploresDiverseLifeChoicesYouthCult =>
      'استكشاف اختيارات الحياة المتنوعة، وثقافة الشباب، والتحولات الاجتماعية الحديثة.';

  @override
  String get deepNarrativeStorytellingWithRichVo =>
      'سرد قصصي عميق بمفردات غنية وأصوات أصيلة.';

  @override
  String get vickySoup => 'فيكي سوب';

  @override
  String get aestheticLifestyleVlogsFashionStyli =>
      'يوميات أسلوب حياة أنيق، وتنسيق أزياء، وروتين يومي.';

  @override
  String get travelDiariesAndCozyLifeMomentsDocu =>
      'يوميات سفر ولحظات دافئة موثقة بأسلوب سينمائي.';

  @override
  String get naturalCasualMandarinSpokenAtAComfo =>
      'لغة ماندرين عفوية وطبيعية منطوقة بوتيرة مريحة ومعبرة.';

  @override
  String get tededMandarin => 'تيد-إد بالماندارين';

  @override
  String get highqualityAnimatedEducationalLesso =>
      'دروس تعليمية متحركة عالية الجودة في العلوم والفلسفة والتاريخ.';

  @override
  String get thoughtprovokingRiddlesClassicLiter =>
      'ألغاز محفزة للتفكير، وأدب كلاسيكي، وأسرار علم النفس.';

  @override
  String get impeccableVoiceoverMandarinWithSync =>
      'أداء صوتي متقن بالماندارين مع ترجمة ثنائية اللغة متزامنة.';

  @override
  String get channel => 'قناة';

  @override
  String get curatedCulturalDocumentariesAndChin =>
      'أفلام وثائقية ثقافية مختارة وأبرز معالم نمط الحياة الصيني.';

  @override
  String get exploringTraditionalArtsHeritageCra =>
      'استكشاف الفنون التقليدية، والحرف التراثية، والاتجاهات الحديثة.';

  @override
  String get highQualityAudioWithSynchronizedChi =>
      'صوت عالي الجودة مع نصوص صينية متزامنة.';

  @override
  String get interestingStoriesAndCreativeVideoP =>
      'قصص شيقة ومشاريع فيديو إبداعية من الويب الصيني.';

  @override
  String get engagingInterviewsStorytellingAndVi =>
      'مقابلات جذابة وسرد قصصي واستكشافات بصرية.';

  @override
  String get greatListeningMaterialWithStandardP =>
      'محتوى استماع ممتاز بنطق قياسي.';

  @override
  String get xVsY => 'X مقابل Y';

  @override
  String get untitled => 'بدون عنوان';

  @override
  String get contemporaryStories => 'قصص معاصرة';

  @override
  String get history => 'تاريخ';

  @override
  String get advancedReading => 'قراءة متقدمة';

  @override
  String get intermediateReading => 'قراءة متوسطة';

  @override
  String get beginnerReading => 'قراءة للمبتدئين';

  @override
  String get mandarinBean => 'ماندارين بين';

  @override
  String get unknown => 'غير معروف';

  @override
  String get localDb => 'قاعدة بيانات محلية';

  @override
  String get emperorTaizong => 'الإمبراطور تايزونغ';

  @override
  String get emperorXuanzong => 'الإمبراطور شوانزونغ';

  @override
  String get liBai => 'لي باي';

  @override
  String get gradedReader => 'قارئ متدرج';

  @override
  String get ucj10r97lkwgdtqbt6xzv8gLearnMandari =>
      'تعلم الماندارين مع TaiwanPlus';

  @override
  String get ucsxriuqkzzmaqklq0n9xfvwEverydayChi => 'الصينية في الحياة اليومية';

  @override
  String get graceMandarinChinese => 'غريس ماندرين الصينية';

  @override
  String get ucolbhvvl5dcjlmzeqbuu1vwTingdailyLi =>
      'تينغ - الحياة اليومية في الصين';

  @override
  String get xinxin => 'شينشين';

  @override
  String get sweetFamilyDailyLife => 'يوميات عائلية دافئة';

  @override
  String get chinsunDailyLife => 'يوميات تشين-سن';

  @override
  String get tasteChina => 'تذوق الصين';

  @override
  String get dawenFoodQuest => 'مغامرات داوين في عالم الطعام';

  @override
  String get chinaTravelWithCangbao => 'السياحة في الصين مع تسانغباو';

  @override
  String get alinFoodWalk => 'جولة ألين لتذوق أطعمة الشارع';

  @override
  String get videoOfTheDay => 'فيديو اليوم';

  @override
  String get noValidVideoFound => 'لم يتم العثور على فيديو صالح.';

  @override
  String get listeningPractice => 'تدريب الاستماع';

  @override
  String get socialSkills => 'المهارات الاجتماعية';

  @override
  String get culturalContext => 'السياق الثقافي';

  @override
  String get realLife => 'الحياة الواقعية';

  @override
  String get realWorld => 'العالم الواقعي';

  @override
  String get articleOfTheDay => 'مقال اليوم';

  @override
  String get failedToLoadOrParseRssFeed => 'فشل تحميل موجز RSS أو تحليله.';

  @override
  String get drama => 'دراما';

  @override
  String get youkugetAppNow => 'YOUKU - حمل التطبيق الآن';

  @override
  String get romanceTrailer => 'رومانسي / إعلان تشويقي';

  @override
  String get romance => 'رومانسي';

  @override
  String get action => 'حركة (أكشن)';

  @override
  String get mystery => 'غموض';

  @override
  String get historical => 'تاريخي';

  @override
  String get historicalAction => 'تاريخي / حركة';

  @override
  String get historicalRomance => 'تاريخي / رومانسي';

  @override
  String get anYouth => 'شباب';

  @override
  String get historicalSliceOfLife => 'تاريخي / شريحة من الحياة';

  @override
  String get historicalHighlight => 'تاريخي / لقطات مميزة';

  @override
  String get youkuEnglishgetAppNow => 'YOUKU English - حمل التطبيق الآن';

  @override
  String get theDouble => 'المزدوج';

  @override
  String get updatesByOshin => 'تحديثات بواسطة أوشين';

  @override
  String get backFromTheBrink => 'العودة من حافة الهاوية';

  @override
  String get fallingIntoYourSmile => 'الوقوع في سحر ابتسامتك';

  @override
  String get everyoneLovesMe => 'الجميع يحبني';

  @override
  String get tillTheEndOfTheMoon => 'حتى نهاية القمر';

  @override
  String get theBestDayOfMyLife => 'أفضل يوم في حياتي';

  @override
  String get gikkiChineseDrama => 'دراما صينية GIKKI';

  @override
  String get dashingYouth => 'الشباب المتألق';

  @override
  String get rebornChineseDramaEngSub => 'دراما صينية ولادة جديدة (مترجمة)';

  @override
  String get ijenwaBenita => 'إيجينوا بينيتا';

  @override
  String get whenIFlyTowardsYou => 'عندما أحلق نحوك';

  @override
  String get mztvExclusiveChineseDrama => 'دراما صينية حصرية من MZTV';

  @override
  String get theStarryLove => 'الحب المرصع بالنجوم';

  @override
  String get comedy => 'كوميديا';

  @override
  String get backFromTheBrink1 => 'العودة من حافة الهاوية';

  @override
  String get dashingYouth1 => 'الشباب المتألق';

  @override
  String get beReborn => 'ولادة جديدة';

  @override
  String get beautyStrategy => 'استراتيجية الجمال';

  @override
  String get myDivineEmissary => 'مبعوثي الإلهي';

  @override
  String get theHope => 'الأمل';

  @override
  String get ep16In => 'الحلقة 16';

  @override
  String get everyoneLovesMe1 => 'الجميع يحبني';

  @override
  String get fallingIntoYourSmile1 => 'الوقوع في سحر ابتسامتك';

  @override
  String get hiddenLove => 'حب خفي';

  @override
  String get loveBetweenFairyAndDevil => 'الحب بين الجنية والشيطان';

  @override
  String get loveLikeTheGalaxy => 'حب كالمجرة';

  @override
  String get membersPremiere => 'عرض أول للأعضاء';

  @override
  String get moonlight => 'ضوء القمر';

  @override
  String get myJourneyToYou => 'رحلتي إليك';

  @override
  String get mysteriousLotusCasebook => 'سجلات اللوتس الغامضة';

  @override
  String get rebornChineseDramaEngSub1 => 'دراما صينية ولادة جديدة (مترجمة)';

  @override
  String get reborn => 'ولادة جديدة';

  @override
  String get theBestDayOfMyLife1 => 'أفضل يوم في حياتي';

  @override
  String get theDouble1 => 'المزدوج';

  @override
  String get theLongBallad => 'القصيدة الطويلة';

  @override
  String get theStarryLove1 => 'الحب المرصع بالنجوم';

  @override
  String get theUntamed => 'الجامح (The Untamed)';

  @override
  String get tillTheEndOfTheMoon1 => 'حتى نهاية القمر';

  @override
  String get whenIFlyTowardsYou1 => 'عندما أحلق نحوك';

  @override
  String get wordOfHonor => 'كلمة شرف';

  @override
  String get blossom => 'إزهار';

  @override
  String get gemini => 'Gemini';

  @override
  String get generationToGeneration => 'جيل بعد جيل';

  @override
  String get brocadeOdyssey => 'ملحمة الديباج';

  @override
  String get circleOfLove => 'دائرة الحب';

  @override
  String get dawnIsBreaking => 'بزوغ الفجر';

  @override
  String get firstRomance => 'الرومانسية الأولى';

  @override
  String get loveInTheClouds => 'حب بين الغيوم';

  @override
  String get secondChanceRomance => 'فرصة ثانية للحب';

  @override
  String get mrBad => 'السيد الشرير (Mr. Bad)';

  @override
  String get pursuitOfJade => 'السعي وراء اليشم';

  @override
  String get fatedHearts => 'قلوب جمعها القدر';

  @override
  String get roadHome => 'طريق العودة للديار';

  @override
  String get myDearGuardian => 'حارسي العزيز';

  @override
  String get brightEyesInTheDark => 'عيون متقدة في الظلام';

  @override
  String get theIngeniousOne => 'الداهية';

  @override
  String get herPhoenixMajesty => 'جلالة العنقاء';

  @override
  String get dreamsNeverEnd => 'الأحلام لا تنتهي';

  @override
  String get theUltimateVowUnknownToYou => 'العهد الأسمى المجهول لك';

  @override
  String get the300LoyalGhosts => 'الأرواح الـ 300 المخلصة';

  @override
  String get homelandGuardian => 'حارس الوطن';

  @override
  String get loveIsAlwaysOnline => 'الحب متصل دائمًا';

  @override
  String get thePrincessDecree => 'مرسوم الأميرة';

  @override
  String get aVowInTheDark => 'عهد في الظلام';

  @override
  String get aGirlLikeMe => 'فتاة مثلي';

  @override
  String get iAmNobody => 'أنا لست نكرة';

  @override
  String get myMamaGo => 'انطلقي يا أمي!';

  @override
  String get myWesternRegionPrincess => 'أميرة المناطق الغربية';

  @override
  String get aFlowerOnTheContinent => 'زهرة في القارة';

  @override
  String get thePrincess => 'الأميرة';

  @override
  String get sweetLoveVersion => 'نسخة الحب الحلو';

  @override
  String get hilariousFamily2 => 'عائلة مرحة 2';

  @override
  String get guYuanMountainHasASchool => 'مدرسة جبل غو يوان';

  @override
  String get foreverYoung => 'شباب دائم';

  @override
  String get theHiddenHeirYeChen => 'الوريث الخفي يي تشن';

  @override
  String get extraordinary => 'استثنائي';

  @override
  String get sideStoryOfFoxVolant => 'قصة جانبية للثعلب الطائر';

  @override
  String get loveOfTheDivineTree => 'حب الشجرة المقدسة';

  @override
  String get rebirth => 'ولادة جديدة';

  @override
  String get moonlitReunion => 'لقاء تحت ضوء القمر';

  @override
  String get videoCountsCannotBeNegative =>
      'لا يمكن أن يكون عدد مقاطع الفيديو سالبًا.';

  @override
  String get publicDomainClassic => 'عمل كلاسيكي من الملكية العامة';

  @override
  String get idioms => 'تعبيرات اصطلاحية';

  @override
  String get news => 'أخبار';

  @override
  String get fairyTales => 'قصص خيالية';

  @override
  String get hereIsAFascinatingCulturalExplanati => 'إليك شرح ثقافي شيق';

  @override
  String get videoFetchTimedOut => 'انتهت مهلة جلب الفيديو';

  @override
  String get aboutChannel => 'عن القناة';

  @override
  String get noVideosFound => 'لم يتم العثور على مقاطع فيديو';

  @override
  String get failedToLoadVideos => 'فشل تحميل مقاطع الفيديو';

  @override
  String get highqualityCuratedMandarinContentWi =>
      'محتوى لغة صينية (ماندارين) منتقى وعالي الجودة بمفردات طبيعية.';

  @override
  String get authenticSpokenChineseAcrossRealwor =>
      'لغة صينية منطوقة أصيلة تغطي مواضيع ووقائع من الحياة الحقيقية.';

  @override
  String get engagingVideoMaterialWithInteractiv =>
      'مقاطع فيديو تعليمية جذابة مع نصوص متزامنة وتفاعلية.';

  @override
  String get watchVideo => 'مشاهدة الفيديو';

  @override
  String get culturalInsight => 'إضاءة ثقافية';

  @override
  String get aiIsAnalyzingCulturalContext =>
      'الذكاء الاصطناعي يحلل السياق الثقافي...';

  @override
  String get diveIntoFullContent => 'استكشف المحتوى بالكامل';

  @override
  String get savedArticles => 'المقالات المحفوظة';

  @override
  String get liveOverlay => 'شاشة العرض المباشر';

  @override
  String get webExplorer => 'مستكشف الويب';

  @override
  String get browseAnyChineseWebsiteWithRealtime =>
      'تصفح أي موقع صيني مع قاموس فوري باللمس، وشروحات البينيين، والترجمة المباشرة.';

  @override
  String get startExploring => 'ابدأ الاستكشاف';

  @override
  String get chineseTvSeriesWithInteractiveSubti =>
      'مسلسلات تلفزيونية صينية مع ترجمة تفاعلية';

  @override
  String get failedToLoadContent => 'فشل تحميل المحتوى';

  @override
  String get searchingYoutube => 'جارٍ البحث في YouTube...';

  @override
  String get noVideosFoundTryADifferentSearchTer =>
      'لم يتم العثور على مقاطع فيديو. جرب عبارة بحث أخرى.';

  @override
  String get searching => 'جارٍ البحث';

  @override
  String get noShowsFound => 'لم يتم العثور على عروض';

  @override
  String get bookmarked => 'مضاف للمفضلة';

  @override
  String get trailer1 => 'إعلان تشويقي';

  @override
  String get highlight1 => 'لقطة مميزة';

  @override
  String get noCaptionsAvailable => 'لا توجد ترجمة متاحة';

  @override
  String get fetchingSubtitles => 'جارٍ جلب الترجمة...';

  @override
  String get generatingAiBriefing => 'جارٍ إنشاء ملخص بالذكاء الاصطناعي...';

  @override
  String get noClosedCaptionsCcFoundForThisVideo =>
      'لم يتم العثور على ترجمة نصية رقمية (CC) لهذا الفيديو.';

  @override
  String get videosWithHardcodedOrBurnedinSubtit =>
      'مقاطع الفيديو ذات الترجمات المدمجة مسبقًا في الصورة لا تحتوي على مسار نصي على YouTube.';

  @override
  String get translatingSubtitles => 'جارٍ ترجمة النصوص...';

  @override
  String get processingYourPronunciation => 'جارٍ معالجة نطقك...';

  @override
  String get couldntIdentifyLine => 'تعذر التعرف على السطر.';

  @override
  String get listeningSpeakNow => 'جارٍ الاستماع... تحدث الآن.';

  @override
  String get thisVideoDoesNotHaveADigitalClosedC =>
      'لا يحتوي هذا الفيديو على ترجمة نصية رقمية (CC) على YouTube.';

  @override
  String get perfect1 => 'مثالي';

  @override
  String get thisVideoHasBeenRemovedOrIsNoLonger =>
      'تمت إزالة هذا الفيديو أو لم يعد متوفرًا.';

  @override
  String get thisVideoCannotBePlayedInTheAppYouC =>
      'لا يمكن تشغيل هذا الفيديو داخل التطبيق. يمكنك مشاهدته مباشرة على YouTube.';

  @override
  String get yourDeviceCannotPlayThisVideoPlease =>
      'تعذر تشغيل هذا الفيديو على جهازك. يرجى تجربة فيديو آخر.';

  @override
  String get invalidVideoReferencePleaseTryAgain =>
      'رابط الفيديو غير صالح. يرجى المحاولة مرة أخرى.';

  @override
  String get unableToLoadThisVideoPleaseTryAnoth =>
      'تعذر تحميل هذا الفيديو. يرجى تجربة فيديو آخر.';

  @override
  String get startReading => 'ابدأ القراءة';

  @override
  String get analyzingCulturalContext => 'جارٍ تحليل السياق الثقافي...';

  @override
  String get failedToLoadCulturalInsight => 'فشل تحميل الإضاءة الثقافية.';

  @override
  String get historicalContext => 'السياق التاريخي';

  @override
  String get culturalSignificance => 'الأهمية الثقافية';

  @override
  String get authorBackground => 'نبذة عن المؤلف';

  @override
  String get k80CompleteClassicNovelsWorldEpics =>
      'أكثر من 80 رواية وملحمة كلاسيكية عالمية كاملة';

  @override
  String get storyOfTheDay => 'قصة اليوم';

  @override
  String get tangDynasty => 'أسرة تانغ';

  @override
  String get poetryClassicalVerse => 'شعر كلاسيكي ونثر';

  @override
  String get allHsk => 'جميع مستويات HSK';

  @override
  String get allStories => 'جميع القصص';

  @override
  String get keyWords => 'الكلمات المفتاحية';

  @override
  String get openOriginalWebsite => 'فتح الموقع الأصلي';

  @override
  String get aiReadingTools => 'أدوات القراءة بالذكاء الاصطناعي';

  @override
  String get enhanceYourReadingWithAipoweredTool =>
      'عزز تجربة قراءتك بأدوات مدعومة بالذكاء الاصطناعي';

  @override
  String get chooseTheTargetDifficultyForSimplif =>
      'اختر مستوى الصعوبة المستهدف للتبسيط';

  @override
  String get chooseDifficultyForSimplification => 'اختر مستوى الصعوبة للتبسيط';

  @override
  String get extractAllUnknownWordsToANewFlashca =>
      'استخراج جميع الكلمات غير المعروفة إلى مجموعة بطاقات جديدة';

  @override
  String get length => 'المدة';

  @override
  String get m1554846a550010707 => 'M15.54 8.46a5 5 0 0 1 0 7.07';

  @override
  String get m1907493a101000101414 => 'M19.07 4.93a10 10 0 0 1 0 14.14';

  @override
  String get webExtraction => 'استخراج الويب';

  @override
  String get aiTools => 'أدوات الذكاء الاصطناعي';

  @override
  String get stop => 'إيقاف';

  @override
  String get keepPracticing1 => 'واصل التدريب';

  @override
  String get aiPrepRoom => 'غرفة التحضير بالذكاء الاصطناعي';

  @override
  String get lessonSummary => 'ملخص الدرس';

  @override
  String get unlockSinosparkPremium => 'الترقية إلى SinoSpark Premium';

  @override
  String get monthYear => 'شهر / سنة';

  @override
  String get enableNotifications => 'تفعيل الإشعارات';

  @override
  String get notificationsConfigured => 'تم ضبط الإشعارات';

  @override
  String get neverMissAStroke2 => 'لا تفوت أي خطوة في التعلم';

  @override
  String get yourDailyDropAndStreakAlertsArePrim =>
      'تنبيهات جرعتك اليومية وسلسلة إنجازك جاهزة.';

  @override
  String get stayConsistentWithDailyRitualDropsA =>
      'حافظ على استمرارية التعلم مع الجرعات اليومية وتنبيهات الفترة التجريبية.';

  @override
  String get aNewWordAndStoryWaitingForYourDaily =>
      'كلمة وقصة جديدة بانتظارك في روتينك اليومي.';

  @override
  String get gentlePromptsBeforeCharactersFadeFr =>
      'تنبيهات لطيفة قبل أن تتلاشى الرموز من ذاكرتك.';

  @override
  String get receiveAReminder2DaysBeforeYourFree =>
      'احصل على تذكير قبل يومين من انتهاء فترتك التجريبية المجانية.';

  @override
  String get yourPathTonchineseFluency => 'طريقك نحو\nإتقان اللغة الصينية';

  @override
  String get answer3QuickQuestionsSoOurAiCanCraf =>
      'أجب عن 3 أسئلة سريعة ليصمم ذكاؤنا الاصطناعي\nمنهجًا مخصصًا لأسلوب حياتك.';

  @override
  String get whatIsYourLevelnwithChinese => 'ما هو مستواك\nفي اللغة الصينية؟';

  @override
  String get chooseThePathThatFitsYourDepth =>
      'اختر المسار الذي يناسب مستواك الحالي.';

  @override
  String get whatDrivesYourStudy => 'ما هو دافعك للتعلم؟';

  @override
  String get purposeFuelsTheBrush => 'الغاية توجه ريشة الخط';

  @override
  String get setYourDailyRitual => 'حدد روتينك اليومي.';

  @override
  String get youCanAdjustYourRitualAnyTime =>
      'يمكنك تعديل روتينك اليومي في أي وقت.';

  @override
  String get letsBegin => 'لنبدأ';

  @override
  String get brandNew => 'مبتدئ تمامًا';

  @override
  String get iveNeverStudiedChineseBefore => 'لم أدرس اللغة الصينية من قبل.';

  @override
  String get iKnowBasicCharactersAndPhrases =>
      'أعرف الرموز والعبارات الأساسية.';

  @override
  String get iCanHoldConversationsAndRead =>
      'يمكنني إجراء محادثات وقراءة نصوص بسيطة.';

  @override
  String get iWantToRefineAndPerfectMySkills =>
      'أرغب في صقل مهاراتي والوصول إلى الإتقان.';

  @override
  String get confirmSelection => 'تأكيد الاختيار';

  @override
  String get purposeFuelsTheBrushsMotion => 'الغاية تمنح ريشة الخط حركتها.';

  @override
  String get buildMyPath => 'صمم مساري';

  @override
  String get hskCertification => 'شهادة اختبار HSK';

  @override
  String get culturalAppreciation => 'التعرف على الثقافة الصينية';

  @override
  String get yourPlanIsReady => 'خطتك التعليمية جاهزة';

  @override
  String get craftingYourCurriculum => 'جارٍ إعداد خطتك التعليمية...';

  @override
  String get personalizedPathInitialized => 'تم إعداد المسار المخصص';

  @override
  String get calibratingAiNeuralMasters =>
      'جارٍ ضبط نماذج المعلمين بالذكاء الاصطناعي...';

  @override
  String get calibrationComplete => 'اكتمل الضبط';

  @override
  String get synthesizingModules => 'جارٍ تجميع الوحدات التعليمية...';

  @override
  String get oneAndWater => '«واحد» و«ماء»';

  @override
  String get theHorizontalStroke => 'الخط الأفقي (Héng)';

  @override
  String get theRadical => 'الجذر (Radical)';

  @override
  String get water => 'ماء';

  @override
  String get river => 'نهر';

  @override
  String get day5Reminder => 'تذكير اليوم الخامس';

  @override
  String get wePromisedToAlertYou2DaysBeforeYour =>
      'لقد وعدنا بتنبيهك قبل يومين من انتهاء فترتك التجريبية لتتمكن من اتخاذ قرارك براحة.';

  @override
  String get continueWithoutReminder => 'المتابعة بدون تذكير';

  @override
  String get masterChineseWithnsinospark => 'أتقن الصينية مع\nSinoSpark';

  @override
  String get start7dayFreeTrial => 'ابدأ تجربة مجانية لمدة 7 أيام';

  @override
  String get precisionStrokes => 'دقة في رسم الخطوط';

  @override
  String get aiPronunciation => 'نطق مدعوم بالذكاء الاصطناعي';

  @override
  String get today => 'اليوم';

  @override
  String get fullAccess => 'وصول كامل';

  @override
  String get day5 => 'اليوم 5';

  @override
  String get reminder => 'تذكير';

  @override
  String get day7 => 'اليوم 7';

  @override
  String get trialBegins => 'بدء الفترة التجريبية';

  @override
  String get revenuecatIsMissingACurrentOffering =>
      'لا تتوفر باقات اشتراك حالية في RevenueCat. يرجى تهيئة لوحة التحكم.';

  @override
  String get cameraPermissionRequiredForLiveScan =>
      'إذن الكاميرا مطلوب للمسح الضوئي المباشر.';

  @override
  String get cameraAccessRequired => 'مطلوب الإذن باستخدام الكاميرا';

  @override
  String get pleaseEnableCameraAccessInYourDevic =>
      'يرجى تمكين إذن الكاميرا من إعدادات جهازك لاستخدام هذه الميزة.';

  @override
  String get alignChineseTextWithinFrame =>
      'قم بمحاذاة النص الصيني داخل الإطار';

  @override
  String get inLibrary => 'في المكتبة';

  @override
  String get novice => 'مبتدئ';

  @override
  String get apprentice => 'متدرب';

  @override
  String get artisan => 'حرفي';

  @override
  String get grandmaster => 'أستاذ خبير';

  @override
  String get poem => 'قصيدة';

  @override
  String get theNarrative => 'السرد';

  @override
  String get classicMasterpiece => 'شاهقة كلاسيكية';

  @override
  String get classicAuthor => 'مؤلف كلاسيكي';

  @override
  String get classical => 'كلاسيكي';

  @override
  String get classicLiterature => 'أدب كلاسيكي';

  @override
  String inThisChapterOf(Object title) {
    return 'في هذا الفصل من $title';
  }

  @override
  String get asTheNarrativeUnfoldsItIlluminatesT =>
      'مع تتابع أحداث القصة، تتجلى حكمة الحياة وتلهم القارئ.';

  @override
  String get general => 'عام';

  @override
  String get mythology => 'أساطير';

  @override
  String get dailyLife => 'الحياة اليومية';

  @override
  String get tangPoetry => 'شعر أسرة تانغ';

  @override
  String get classicalLiterature => 'الأدب الكلاسيكي';

  @override
  String get justNow => 'الآن';

  @override
  String get theTerracottaArmyOfQinShiHuang =>
      'جيش الطين للإمبراطور تشين شي هوانغ';

  @override
  String get lifeInsideTheForbiddenCity => 'الحياة داخل المدينة المحرمة';

  @override
  String get buyingATicketAndTakingTheHighSpeedT =>
      'شراء تذكرة وركوب القطار فائق السرعة في الصين';

  @override
  String get goingToTheHospitalForAColdAndSeeing =>
      'الذهاب إلى المستشفى بسبب نزلة برد وزيارة الطبيب';

  @override
  String get goingToALocalRestaurantToOrderJiaoz =>
      'الذهاب إلى مطعم محلي لطلب زلابية الجياوزي';

  @override
  String get theTraditionalGongfuTeaCeremony => 'مراسم شاي الغونغفو التقليدي';

  @override
  String get theArtOfWritingChineseCharactersWit =>
      'فن كتابة الرموز الصينية بالفرشاة';

  @override
  String get theLifeAndConservationOfGiantPandas =>
      'حياة الباندا العملاقة وحمايتها من الانقراض';

  @override
  String get storyNotFoundInDatabase => 'القصة غير موجودة في قاعدة البيانات';

  @override
  String get storyTextIsEmpty => 'نص القصة فارغ';

  @override
  String get myCustomStories => 'قصصي المخصصة';

  @override
  String get userProvidedText => 'نص مخصص من المستخدم';

  @override
  String get local => 'محلي';

  @override
  String get voiceEngineAllowance => 'رصيد محرك الصوت';

  @override
  String get studioHdVsUnlimitedStandardVoice =>
      'أصوات Studio HD الفائقة مقابل الصوت القياسي غير المحدود';

  @override
  String get standardVoiceIs100UnlimitedFree =>
      'الصوت القياسي مجاني وغير محدود بنسبة 100%';

  @override
  String get read => 'قراءة';

  @override
  String get koreKoreFemaleWarm => 'كوري (أنثوي، دافئ)';

  @override
  String get aoedeAoedeFemaleCheerful => 'أويدي (أنثوي، مبهج)';

  @override
  String get fenrirFenrirMaleUpbeat => 'فنرير (ذكوري، حيوي)';

  @override
  String get charonCharonMaleNewsstyle => 'شارون (ذكوري، أسلوب إخباري)';

  @override
  String get puckPuckMaleSporty => 'باك (ذكوري، رياضي)';

  @override
  String get localOndevice => 'صوت مدمج بالجهاز';

  @override
  String get localOndeviceTts => 'تحويل النص إلى كلام مدمج بالجهاز';

  @override
  String get off => 'إيقاف';

  @override
  String get endOfCurrentChapter => 'نهاية الفصل الحالي';

  @override
  String get standardVoice => 'صوت قياسي';

  @override
  String get noNovelsFoundMatchingYourFilter =>
      'لم يتم العثور على روايات تطابق خيارات التصفية.';

  @override
  String get noMicroreadsFoundMatchingYourFilter =>
      'لم يتم العثور على قراءات قصيرة تطابق خيارات التصفية.';

  @override
  String get noPoemsFoundMatchingYourFilter =>
      'لم يتم العثور على قصائد تطابق خيارات التصفية.';

  @override
  String get audiobook => 'كتاب صوتي';

  @override
  String get audio => 'صوت';

  @override
  String get continueReading => 'متابعة القراءة';

  @override
  String get search96FullNovelsAuthorsEpics =>
      'ابحث في 96 رواية كاملة، ومؤلفين، وملاحم...';

  @override
  String get searchClassicalPoemsAuthorsVerses =>
      'ابحث في القصائد الكلاسيكية، والشعراء، والأبيات...';

  @override
  String get allLevelsVal => 'جميع المستويات';

  @override
  String get hsk1BeginnerVal => 'HSK 1 (مبتدئ)';

  @override
  String get hsk2ElementaryVal => 'HSK 2 (ابتدائي)';

  @override
  String get hsk3IntermediateVal => 'HSK 3 (متوسط)';

  @override
  String get hsk4UpperIntVal => 'HSK 4 (متوسط متقدم)';

  @override
  String get listenToAudiobook => 'استمع إلى الكتاب الصوتي';

  @override
  String get synopsis => 'ملخص العمل';

  @override
  String get peoplesArtist => 'فنان الشعب';

  @override
  String get kafkaesqueForBureaucraticAbsurdityA =>
      '«كافكاوي» للإشارة إلى العبثية البيروقراطية والاغتراب والقلق الوجودي.';

  @override
  String get bigBrotherAndNewspeak => '«الأخ الأكبر» و«لغة النيوسبيك».';

  @override
  String get audiobookIncluded => 'يتضمن كتابًا صوتيًا';

  @override
  String get readPoem => 'قراءة القصيدة';

  @override
  String get studioVoiceAllowance => 'رصيد أصوات الاستوديو (Studio)';

  @override
  String get weeklyHighdefinitionAiRecitation =>
      'تلاوة أسبوعية عالية الدقة بالذكاء الاصطناعي';

  @override
  String get resetsEveryMondayAt0000 => 'يتجدد كل يوم اثنين الساعة 00:00';

  @override
  String get whenYourWeekly4hourStudioAllowanceI =>
      'عند استهلاك رصيدك الأسبوعي البالغ 4 ساعات لأصوات الاستوديو، ينتقل التطبيق تلقائيًا إلى الصوت المدمج بالجهاز للاستماع مجانًا وبلا حدود دون انقطاع.';

  @override
  String get localDeviceVoice => 'صوت الجهاز المدمج';

  @override
  String get classicalVerse => 'شعر كلاسيكي';

  @override
  String get ondeviceVoice4hWeeklyUsed =>
      'صوت الجهاز (تم استخدام رصيد 4 ساعات الأسبوعي)';

  @override
  String get generateACustomAiStoryBasedOnYourIn =>
      'إنشاء قصة مخصصة بالذكاء الاصطناعي بناءً على اهتماماتك';

  @override
  String get insteadOfAFixedHskLevelTheFlowState =>
      'بدلاً من التقيد بمستوى HSK ثابت، يحلل محرك التدفق (Flow State) مكتبة بطاقاتك التعليمية.';

  @override
  String get we => 'نحن';

  @override
  String get howCanWeHelpYou => 'كيف يمكننا مساعدتك؟';

  @override
  String get everythingYouNeedToKnowAboutHanziMa =>
      'كل ما تحتاج لمعرفته حول SinoSpark، وميزاته، وخصوصيتك.';

  @override
  String get whoAreTheVoicesSpeakingInTheApp =>
      'من هم أصحاب الأصوات في التطبيق؟';

  @override
  String get howDoesTheWebExplorerWork => 'كيف يعمل مستكشف الويب؟';

  @override
  String get whatIsZenMode => 'ما هو وضع الهدوء (Zen Mode)؟';

  @override
  String get howDoesTheFlashcardSpacedrepetition =>
      'كيف يعمل نظام التكرار المتباعد للبطاقات التعليمية؟';

  @override
  String get traceComplete => 'اكتمل التتبع!';

  @override
  String get traceCharacter => 'تتبع رسم الرمز';

  @override
  String get analyzingWordRelationships => 'جارٍ تحليل العلاقات بين الكلمات...';

  @override
  String get identifyingUsageContexts => 'جارٍ تحديد سياقات الاستخدام...';

  @override
  String get comparingFormalityLevels => 'جارٍ مقارنة مستويات الرسمية...';

  @override
  String get findingCommonCollocations =>
      'جارٍ البحث عن المتلازمات اللفظية الشائعة...';

  @override
  String get generatingComparison => 'جارٍ إنشاء المقارنة...';

  @override
  String get generationIsTakingLongerThanExpecte =>
      'يستغرق الإنشاء وقتًا أطول من المتوقع نتيجة الضغط على خوادم الذكاء الاصطناعي.';

  @override
  String get generationInterruptedShowingPartial =>
      'تمت مقاطعة الإنشاء. يتم عرض نتيجة جزئية.';

  @override
  String get sorrySomethingWentWrong => 'عذرًا، حدث خطأ غير متوقع.';

  @override
  String get usage => 'الاستخدام:';

  @override
  String get alsoSeenIn => 'يظهر أيضًا في';

  @override
  String get quickLook => 'نظرة سريعة';

  @override
  String get notFound => 'غير موجود';

  @override
  String get errorLoadingFromAi => 'خطأ في التحميل من الذكاء الاصطناعي.';

  @override
  String get analyzingImage => 'جارٍ تحليل الصورة...';

  @override
  String get extractingChineseText => 'جارٍ استخراج النص الصيني...';

  @override
  String get lookingUpVocabulary => 'جارٍ البحث عن المفردات...';

  @override
  String get dreamOfTheRedChamber => 'حلم الغرفة الحمراء';

  @override
  String get journeyToTheWest => 'رحلة إلى الغرب';

  @override
  String get romanceOfTheThreeKingdoms => 'رومانسية الممالك الثلاث';

  @override
  String get mingDynasty => 'أسرة مينغ';

  @override
  String get wuChengEn => 'وو تشنغ إن';

  @override
  String get hundredChapters => '100 فصل';

  @override
  String get volume1 => 'المجلد 1';

  @override
  String bookmarksCount(Object count) {
    return 'العلامات المرجعية ($count)';
  }

  @override
  String get noBookmarksYet =>
      'لا توجد علامات مرجعية حتى الآن. انقر على أيقونة الإشارة المرجعية لحفظ نص.';

  @override
  String get sinosparkIsNotResponding => 'SinoSpark لا يستجيب';

  @override
  String get closeApp => 'إغلاق التطبيق';

  @override
  String get wait => 'انتظار';

  @override
  String studioHdAllowance(Object hours) {
    return 'رصيد Studio HD: $hours ساعة';
  }

  @override
  String bookPercentRead(Object percent) {
    return 'تمت قراءة $percent%';
  }

  @override
  String chAbbreviation(Object number) {
    return 'فصل $number';
  }

  @override
  String booksAndAudiobooks(Object count) {
    return '$count كتب وكتب صوتية';
  }

  @override
  String sentenceXOfY(Object current, Object total) {
    return 'جملة $current من $total';
  }

  @override
  String chapterXOfY(Object current, Object total) {
    return 'فصل $current من $total';
  }

  @override
  String get allLevels => 'جميع المستويات';

  @override
  String get searchGradedMicroStories => 'ابحث في القصص المتدرجة والحكايات...';

  @override
  String gradedStoriesAndMicroReads(Object count) {
    return '$count قصة متدرجة وقراءات يومية';
  }

  @override
  String get searchClassicalPoems =>
      'ابحث في القصائد الكلاسيكية، والشعراء، والأبيات...';

  @override
  String classicalPoemsAndVerse(Object count) {
    return '$count قصيدة كلاسيكية وأبيات شعرية';
  }

  @override
  String get browseAnyChineseWebsite =>
      'تصفح أي موقع صيني مع قاموس فوري باللمس، وتدوين البينيين، وترجمة فورية.';

  @override
  String get completed => 'مكتمل';

  @override
  String get aiIsReading => 'الذكاء الاصطناعي يقرأ...';

  @override
  String get bbcVerify => 'BBC Verify';

  @override
  String get hsk5AdvancedVal => 'HSK 5 (متقدم)';

  @override
  String get hsk1Beginner => 'HSK 1 (مبتدئ)';

  @override
  String get hsk4UpperInt => 'HSK 4 (متوسط متقدم)';

  @override
  String get extractAllUnknownWords =>
      'استخراج جميع الكلمات غير المعروفة إلى مجموعة بطاقات جديدة';

  @override
  String get designCustomAiRoleplay =>
      'تصميم تجربة محادثة ولعب أدوار مخصصة بالذكاء الاصطناعي';

  @override
  String get practiceFlashcardVocabulary =>
      'تدريب على مفردات البطاقات في محادثة مباشرة';

  @override
  String get surpriseMe => 'اختر لي عشوائيًا';

  @override
  String get rollCharacter => 'توليد شخصية';

  @override
  String get historicalCostume => 'تاريخي / أزياء تنكرية';

  @override
  String get modernYouth => 'عصري وشبابي';

  @override
  String get fantasyMythology => 'خيالي وأسطوري';

  @override
  String get familyDrama => 'دراما عائلية';

  @override
  String get fullVersion => 'النسخة الكاملة';

  @override
  String episodesCount(Object count) {
    return '$count حلقات';
  }

  @override
  String episodeLabel(Object number) {
    return 'حلقة $number';
  }

  @override
  String get translating => '[ جارٍ الترجمة... ]';

  @override
  String get engSub => '[ترجمة عربية]';

  @override
  String get standardVocabulary => 'المفردات القياسية';

  @override
  String get characters => 'رموزًا';

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
