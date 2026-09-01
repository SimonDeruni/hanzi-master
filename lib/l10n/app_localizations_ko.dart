// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

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
  String get aiTutorRateLimit => 'The AI tutor is busy right now. Please wait a moment and try again.';

  @override
  String get deleteAccount => '계정 삭제';

  @override
  String get deleteAccountSubtitle => '계정을 영구적으로 삭제합니다';

  @override
  String get deleteAccountTitle => '계정을 완전히 삭제하시겠습니까?';

  @override
  String get accountDataDeletedTitle => '계정 데이터가 삭제됩니다';

  @override
  String get accountDataDeletedBody => 'SinoSpark에 저장된 회원님의 로그인 계정 및 모든 계정 정보가 영구적으로 삭제됩니다. 이 작업은 실행 취소할 수 없습니다.';

  @override
  String get localDataKeptTitle => '이 기기의 데이터는 유지됩니다';

  @override
  String get localDataKeptBody => '이 기기에만 로컬 저장된 학습 진행도, 다운로드한 콘텐츠 및 환경설정은 삭제되지 않습니다.';

  @override
  String get subscriptionNotCanceledTitle => '구독은 자동으로 취소되지 않습니다';

  @override
  String get subscriptionNotCanceledBody => '계정을 삭제해도 App Store 구독은 자동으로 취소되지 않습니다. Apple 설정에서 직접 구독을 취소하지 않으면 정기 결제가 계속될 수 있습니다.';

  @override
  String get manageSubscription => 'App Store 구독 관리';

  @override
  String get subscriptionManagementFailed => 'Apple 구독 관리 화면을 열 수 없습니다. \'설정\' > \'사용자 이름\' > \'구독\'에서 직접 관리해 주세요.';

  @override
  String get confirmPassword => '현재 비밀번호';

  @override
  String get confirmPasswordToDelete => '본인 확인을 위해 비밀번호를 입력해 주세요.';

  @override
  String get deleteAccountPermanently => '계정 영구 삭제';

  @override
  String get deleteAccountFinalTitle => '최종 확인';

  @override
  String get deleteAccountFinalWarning => '계정이 영구적으로 삭제되며 되돌릴 수 없습니다. 이 기기에만 저장된 데이터는 유지됩니다. 계속하시겠습니까?';

  @override
  String get deletingAccount => '계정 삭제 중...';

  @override
  String get accountPasswordRequired => '계속하려면 현재 비밀번호를 입력해 주세요.';

  @override
  String get accountPasswordIncorrect => '비밀번호가 올바르지 않습니다. 다시 시도해 주세요.';

  @override
  String get accountReauthenticationCanceled => '본인 확인이 취소되었습니다. 계정이 삭제되지 않았습니다.';

  @override
  String get accountReauthenticationFailed => '본인 확인에 실패했습니다. 다시 시도하여 로그인 절차를 완료해 주세요.';

  @override
  String get accountAlreadySignedOut => '이미 로그아웃되었습니다. 삭제된 로그인 계정이 없습니다.';

  @override
  String get accountProviderUnsupported => '해당 로그인 방식은 앱 내에서 확인할 수 없습니다. 계정 삭제 지원을 위해 고객센터에 문의해 주세요.';

  @override
  String get appleDeletionRequiresAppleDevice => '보안을 위해 Apple 연동 계정은 Apple 기기에서 삭제해야 합니다.';

  @override
  String get accountDeletionNetworkError => '인터넷 연결을 확인한 후 계정 삭제를 다시 시도해 주세요.';

  @override
  String get accountDeletionFailed => '계정을 삭제하지 못했습니다. 계정은 활성 상태로 유지됩니다. 다시 시도해 주세요.';

  @override
  String get accountDeletedSuccessfully => '계정이 완전히 삭제되었습니다.';

  @override
  String get globalMastery => '종합 숙련도';

  @override
  String get masteredCards => '완전 습득';

  @override
  String get hsk1Candidate => 'HSK 1급 도전자';

  @override
  String get hsk2Candidate => 'HSK 2급 도전자';

  @override
  String get hsk3Candidate => 'HSK 3급 도전자';

  @override
  String get hsk4Candidate => 'HSK 4급 도전자';

  @override
  String get hsk5Candidate => 'HSK 5급 도전자';

  @override
  String get hsk6Candidate => 'HSK 6급 도전자';

  @override
  String get hsk6Master => 'HSK 6급 마스터';

  @override
  String get currentRank => '현재 랭크';

  @override
  String get next => '다음';

  @override
  String get searchHanziOrPinyin => '한자 또는 병음 검색...';

  @override
  String get dailyReview => '오늘의 복습';

  @override
  String get upcomingForecast => '복습 예정';

  @override
  String get laterToday => '오늘 늦게';

  @override
  String get tomorrow => '내일';

  @override
  String get next7Days => '향후 7일';

  @override
  String get theScholarWay => '학자의 길';

  @override
  String get beginJourney => '학습 시작하기';

  @override
  String get settingsTitle => '설정';

  @override
  String get darkMode => '다크 모드';

  @override
  String get darkModeDesc => '눈이 편안한 화면';

  @override
  String get voiceSpeed => '음성 속도';

  @override
  String get artAndIntellect => '예술과 지성';

  @override
  String get theDigitalScholar => '디지털 학자';

  @override
  String get refineBrushVoice => 'AI와 함께 필순과 발음을 연마하세요.';

  @override
  String get liveVoiceCall => '실시간 음성 통화';

  @override
  String get immersiveRoleplay => '몰입형 AI 롤플레잉';

  @override
  String get readingRoom => '문화 서재 (독서실)';

  @override
  String get shadowingStudio => '섀도잉 스튜디오';

  @override
  String get errorPrefix => '오류: ';

  @override
  String get initializingLibrary => '라이브러리 초기화 중...';

  @override
  String get unlockCharactersToQuiz => '퀴즈를 시작하려면 한자 4개를 잠금 해제하세요!';

  @override
  String get practiceQuiz => '퀴즈';

  @override
  String get curriculumPaths => '학습 커리큘럼';

  @override
  String get noDecksFound => '생성된 덱이 없습니다. 새 덱을 추가해 보세요!';

  @override
  String get addCardsFirst => '먼저 카드를 추가해 주세요!';

  @override
  String get aiDraftingPath => 'AI가 맞춤 경로를 구성하는 중...';

  @override
  String get pathReady => '학습 경로 준비 완료!';

  @override
  String get errorGeneratingPath => '경로 생성 오류';

  @override
  String get brushingCurriculum => '커리큘럼을 생성하는 중...';

  @override
  String get warmUp => '워밍업';

  @override
  String get lessonComplete => '레슨 완료! +10 잉크 포인트';

  @override
  String get step1Origin => '1단계: 기원';

  @override
  String get traceRadical => '부수 따라 쓰기';

  @override
  String get step2Forge => '2단계: 조합과 단련';

  @override
  String get chooseEssence => '핵심 요소 선택';

  @override
  String get wrongEssence => '틀렸습니다! 다시 시도해 보세요.';

  @override
  String get step3Hunt => '3단계: 한자 찾기';

  @override
  String get findCharacters => '한자 찾기';

  @override
  String get notThatOne => '이 글자가 아닙니다!';

  @override
  String get successfullyInstalled => '설치 완료:';

  @override
  String get failedToDownload => '다운로드에 실패했습니다.';

  @override
  String get rescindTitle => '취소하시겠습니까?';

  @override
  String get removeCharactersWarning => '선택한 한자들이 삭제됩니다.';

  @override
  String get cancel => '취소';

  @override
  String get uninstall => '설치 제거';

  @override
  String get removedLibrary => '삭제 완료:';

  @override
  String get tomeLibrary => '서책 라이브러리';

  @override
  String get libraryError => '라이브러리 오류';

  @override
  String get installTome => '설치';

  @override
  String get unitIntro => '단원 소개';

  @override
  String get constellationCluster => '별자리 클러스터';

  @override
  String get ok => '확인';

  @override
  String get divingInto => '학습 시작 중...';

  @override
  String get keyRadicals => '핵심 부수';

  @override
  String get noRadicalData => '부수 데이터가 없습니다.';

  @override
  String get discovery => '새로운 발견';

  @override
  String get startLearning => '학습 시작';

  @override
  String get selectPersona => '페르소나 선택';

  @override
  String get customPersona => '맞춤 페르소나';

  @override
  String get geminiLiveCall => '라이브 통화';

  @override
  String get returnToMenu => '메뉴로 돌아가기';

  @override
  String get strokeAnalysis => '필순 및 획 분석';

  @override
  String get excellentWork => '정말 훌륭합니다!';

  @override
  String get keepPracticing => '계속 연습해 보세요!';

  @override
  String get drawingSubmitted => '손글씨 제출 완료';

  @override
  String get customPersonaHint => '맞춤 페르소나 설정...';

  @override
  String get stepOneOrigin => '1단계: 기원';

  @override
  String get stepTwoForge => '2단계: 조합과 단련';

  @override
  String get toForge => '조합할 한자';

  @override
  String get whatEssenceDoesNeed => '어떤 요소가 필요한가요?';

  @override
  String get need => '필요';

  @override
  String get forged => '조합 완료';

  @override
  String get stepThreeHunt => '3단계: 한자 찾기';

  @override
  String get findCharactersWith => '다음 요소를 포함하는 한자 찾기:';

  @override
  String get uninstallButton => '제거';

  @override
  String get gradedAiStories => '수준별 AI 스토리';

  @override
  String get calligraphy => '서예 및 필순';

  @override
  String get theScrollOfOrigin => '기원의 두루마리';

  @override
  String get galaxyOf => '~의 은하';

  @override
  String get constellationDescription => '별자리 설명';

  @override
  String get noRadicalDataAvailable => '사용 가능한 부수 데이터가 없습니다';

  @override
  String get learningPreferences => '학습 환경설정';

  @override
  String get hardMode => '하드 모드';

  @override
  String get hardModeDesc => '가이드라인 없이 정확한 필순과 획으로 작성해야 합니다.';

  @override
  String get adaptiveGuidance => '맞춤형 가이드';

  @override
  String get dailyGoal => '일일 목표';

  @override
  String get audioAndHaptics => '오디오 및 햅틱 피드백';

  @override
  String get autoPlayAudio => '오디오 자동 재생';

  @override
  String get autoPlayDesc => '카드가 열릴 때 발음을 자동으로 재생합니다.';

  @override
  String get haptics => '햅틱 피드백';

  @override
  String get displayAndContent => '디스플레이 및 콘텐츠';

  @override
  String get useEnglishDefinitions => '영어 정의 표시';

  @override
  String get useEnglishDefinitionsDesc => '영어 정의에는 단어의 뉘앙스가 더욱 상세히 설명되어 있습니다';

  @override
  String get animationSpeed => '애니메이션 속도';

  @override
  String get manageTomes => '서책 관리';

  @override
  String get manageTomesDesc => '설치된 학습 서책을 관리합니다.';

  @override
  String get dangerZone => '위험 구역';

  @override
  String get resetAllData => '모든 데이터 초기화';

  @override
  String get resetDataDesc => '학습 진행 상황, 통계 및 설정이 완전히 삭제됩니다. 이 작업은 되돌릴 수 없습니다.';

  @override
  String get areYouSure => '정말 진행하시겠습니까?';

  @override
  String get cannotBeUndone => '되돌릴 수 없습니다';

  @override
  String get deleteEverything => '모든 항목 삭제';

  @override
  String get appLanguage => '앱 언어';

  @override
  String get howDidYouDo => '결과는 어떠셨나요?';

  @override
  String get missedItEntirely => '전혀 기억나지 않음';

  @override
  String get gotItButStruggled => '어렵게 맞춤';

  @override
  String get gotItClearly => '명확히 기억함';

  @override
  String get perfectAndImmediate => '완벽하고 즉각적임';

  @override
  String get again => '다시';

  @override
  String get hard => '어려움';

  @override
  String get good => '알맞음';

  @override
  String get easy => '쉬움';

  @override
  String get tapToReveal => '탭하여 정답 확인';

  @override
  String get howWellDidYouRemember => '얼마나 잘 기억하셨나요?';

  @override
  String get completelyForgot => '완전히 잊어버림';

  @override
  String get gotItWithDifficulty => '간신히 기억해 냄';

  @override
  String get recalledCorrectly => '정확하게 기억함';

  @override
  String get perfectRecall => '완벽하게 기억함';

  @override
  String get practiceWriting => '손글씨 쓰기 연습';

  @override
  String get hideScratchpad => '연습장 숨기기';

  @override
  String get whatCharacterMeans => '한자의 뜻:';

  @override
  String get tapCardToReveal => '카드를 탭하여 뒷면 확인';

  @override
  String get ratePronunciationConfidence => '발음 자신감 평가';

  @override
  String get botchedIt => '많이 부족함';

  @override
  String get struggledWithTones => '성조가 어려움';

  @override
  String get acceptable => '무난함';

  @override
  String get perfectlyNatural => '완벽하고 자연스러움';

  @override
  String get sessionComplete => '학습 세션 완료!';

  @override
  String get accuracy => '정확도';

  @override
  String get reviewed => '복습 완료';

  @override
  String get correct => '정답';

  @override
  String get backToLibrary => '라이브러리로 돌아가기';

  @override
  String get revealAnswer => '정답 보기';

  @override
  String get aiHubTitle => 'AI 허브';

  @override
  String get textChat => '텍스트 채팅';

  @override
  String get scholarlyPersonas => '학자 페르소나';

  @override
  String get shadowing => '섀도잉';

  @override
  String get liveTranslation => '실시간 통역';

  @override
  String get scholarsLibrary => '학자의 서재';

  @override
  String get generate => '생성';

  @override
  String get searchPinyinHanziEnglish => '병음, 한자 또는 한국어로 검색...';

  @override
  String get liveTranslate => '실시간 번역';

  @override
  String get travelInterpreter => '여행 통역기';

  @override
  String get realTimeSplitScreen => '원어민과의 실시간 화면 분할 대화로 언어의 장벽을 즉시 허물어 보세요.';

  @override
  String get whisperEarpiece => '실시간 음성 자막';

  @override
  String get listenToChineseAudio => '중국어 음성을 들으며 화면에서 실시간 자막을 바로 확인하세요.';

  @override
  String get dashboardTitle => '대시보드';

  @override
  String get yourMindIsClear => '오늘의 학습을 모두 마쳤습니다!';

  @override
  String get noReviewsDueToday => '오늘 예정된 복습이 없습니다.';

  @override
  String get done => '완료';

  @override
  String get hskLevel1 => 'HSK 1급';

  @override
  String get hskLevel2 => 'HSK 2급';

  @override
  String get hskLevel3 => 'HSK 3급';

  @override
  String get hskLevel4 => 'HSK 4급';

  @override
  String get hskLevel5 => 'HSK 5급';

  @override
  String get hskLevel6 => 'HSK 6급';

  @override
  String get generalVocabulary => '일반 어휘';

  @override
  String cardsRequireAttention(Object count) {
    return '$count장의 카드가 복습을 기다리고 있습니다.';
  }

  @override
  String get begin => '시작하기';

  @override
  String get poweredByAi => '최첨단 AI 탑재. 어떤 상황에서도 매끄러운 실시간 통번역.';

  @override
  String get downloadingModel => 'AI 모델 다운로드 중...';

  @override
  String get soon => '출시 예정';

  @override
  String get installed => '설치됨';

  @override
  String get premium => '프리미엄';

  @override
  String get coreModule => '코어 모듈';

  @override
  String get step6Context => '6단계: 문맥과 예문';

  @override
  String get tapBuildingBlocksTo => '구성 요소를 탭하여 한자의 유래를 탐구해 보세요.';

  @override
  String get initiateRadicalSequence => '부수 시퀀스 시작';

  @override
  String get holdToTalk => '길게 눌러서 말하기';

  @override
  String get customScenario => '맞춤 시나리오';

  @override
  String get voiceCall => '음성 통화';

  @override
  String get pronunciation => '발음';

  @override
  String get selectAScenarioTo => '시나리오를 선택하여 중국어 회화를 연습하세요. AI 학자가 성조와 명확도를 평가합니다.';

  @override
  String get create => '생성';

  @override
  String get createYourScenario => '시나리오 만들기';

  @override
  String get difficulty => '난이도';

  @override
  String get scholarsVerdict => '학자의 판정';

  @override
  String get completeReview => '복습 완료';

  @override
  String get conversationReview => '대화 검토';

  @override
  String get linguisticAnalysis => '언어학적 분석';

  @override
  String get examplesInHsk1 => 'HSK 1급 예시';

  @override
  String get characterReference => '한자 레퍼런스';

  @override
  String get askTutor => '튜터에게 질문하기';

  @override
  String get addToStudyDeck => '학습 덱에 추가';

  @override
  String get startPractice => '연습 시작';

  @override
  String get noOtherHsk1 => '이 부수를 사용하는 다른 HSK 1급 한자가 없습니다.';

  @override
  String get couldNotLoadAi => 'AI 콘텐츠를 불러오지 못했습니다 (요청 한도 초과 또는 네트워크 오류).\n아래 새로고침 버튼을 탭하여 다시 시도해 주세요.';

  @override
  String get noAvailableCardsFound => '사용 가능한 카드가 없습니다.';

  @override
  String get addCards => '카드 추가';

  @override
  String get removeCard => '카드 제거';

  @override
  String get remove => '제거';

  @override
  String get review => '복습';

  @override
  String get story => '스토리';

  @override
  String get thisDeckIsEmpty => '이 덱은 비어 있습니다.';

  @override
  String get tapTheAddCards => '\'카드 추가\' 버튼을 탭해 보세요!';

  @override
  String get noCardsFound => '카드를 찾을 수 없습니다.';

  @override
  String get addCardsToSee => '카드를 추가하면 학습 통계가 표시됩니다.';

  @override
  String get aiGenerated => 'AI 생성';

  @override
  String get allCardsCaughtUp => '모든 카드의 복습을 완료했습니다! 대단해요.';

  @override
  String get latestDiscoveries => '최근 발견한 한자';

  @override
  String get noCharactersInLexicon => '아직 사전에 등록된 한자가 없습니다.';

  @override
  String get yourBookshelf => '내 서가';

  @override
  String get text_1782026184579 => '글자';

  @override
  String get searchYourDictionary => '내 사전 검색...';

  @override
  String get saveCard => '카드 저장';

  @override
  String get noCharactersFound => '한자를 찾을 수 없습니다.';

  @override
  String get radicalsIndex => '부수 색인';

  @override
  String get masteringRadicalsIsThe => '부수를 마스터하는 것은 수천 개의 한자를 익히는 열쇠입니다. 부수를 선택하여 해당 부수가 쓰인 모든 한자를 확인하세요.';

  @override
  String get noRadicalsFound => '부수를 찾을 수 없습니다.';

  @override
  String get yourDrawing => '내가 쓴 글씨';

  @override
  String get reference => '모범 필순';

  @override
  String get rateYourRecall => '기억 회상도 평가';

  @override
  String get contactUs => '문의하기';

  @override
  String get reportBugsOrRequest => '버그 제보 및 기능 제안';

  @override
  String get allDataHasBeen => '모든 데이터가 초기화되었습니다.';

  @override
  String get hanziMasterV100 => 'SinoSpark v1.0.0';

  @override
  String get myProgress => '내 학습 진도';

  @override
  String get overview => '개요';

  @override
  String get aiStory => 'AI 스토리';

  @override
  String get usingYourDecksVocabulary => '내 덱의 어휘 활용 중';

  @override
  String get tryAgain => '다시 시도';

  @override
  String get translate => '번역';

  @override
  String get pinyin => '병음';

  @override
  String get fullTranslation => '전체 번역';

  @override
  String get geminiFlashIsStructuring => 'Gemini Flash가 스토리를 구성하는 중입니다...';

  @override
  String get aiDeckGenerator => 'AI 덱 생성기';

  @override
  String get whatDoYouWant => '무엇을 배우고 싶으신가요?';

  @override
  String get targetDifficulty => '목표 난이도';

  @override
  String get focusArea => '집중 학습 영역';

  @override
  String get specificContextOrTone => '특정 문맥 또는 어조 (선택 사항)';

  @override
  String get numberOfCards => '카드 장수';

  @override
  String get generateDeck => '덱 생성하기';

  @override
  String get aiGrammarExplanation => 'AI 문법 해설';

  @override
  String get scholarsDesk => '학자의 책상';

  @override
  String get chooseADeck => '덱 선택';

  @override
  String get whereWouldYouLike => '이 한자를 어디에 저장하시겠습니까?';

  @override
  String get addToDefaultStudy => '기본 학습 덱에 추가';

  @override
  String get ifOffItsOnly => '비활성화 시 글로벌 사전에만 저장됩니다';

  @override
  String get saveToLibrary => '라이브러리에 저장';

  @override
  String get pleaseEnterValidChinese => '올바른 중국어 한자를 입력해 주세요.';

  @override
  String get reviewAiCard => 'AI 카드 검토';

  @override
  String get pleaseDoublecheckTheAis => '생성된 AI 내용을 확인하세요. 영구 서재에 저장하기 전에 병음이나 뜻을 자유롭게 수정할 수 있습니다.';

  @override
  String get alreadyInYourLibrary => '이미 라이브러리에 있습니다!';

  @override
  String get meaningInContext => '문맥 속 의미';

  @override
  String get explainGrammar => '문법 설명';

  @override
  String get addToLibrary => '라이브러리에 추가';

  @override
  String get masterYourMandarinPronunciation => '원어민의 억양과 발음을 실시간으로 따라 하며 중국어 발음을 완벽하게 마스터하세요.';

  @override
  String get startSession => '세션 시작';

  @override
  String get sessionHistory => '세션 기록';

  @override
  String get noSavedSessions => '저장된 세션이 없습니다.';

  @override
  String get aiBreakdown => 'AI 상세 분석';

  @override
  String get sessionDetails => '세션 상세 정보';

  @override
  String partner(Object lang) {
    return '대화 상대 ($lang)';
  }

  @override
  String get youEnglish => '나 (한국어)';

  @override
  String get noTranscriptToSave => '저장할 대화 기록이 없습니다!';

  @override
  String get sessionSaved => '세션이 저장되었습니다!';

  @override
  String get realtimeBidirectionalTranslationSpeak => '실시간 양방향 번역. 한국어 또는 중국어로 말하면 대화 상대에게 즉시 번역됩니다.';

  @override
  String get text_1782026184665 => '녹음 중';

  @override
  String get recording => '녹음 중';

  @override
  String get yourSilentCompanionListen => '든든한 언어 파트너. 중국어 음성을 들으면 한국어 번역이 화면에 실시간으로 표시됩니다.';

  @override
  String get startListening => '듣기 시작';

  @override
  String get skip => '건너뛰기';

  @override
  String get independentStars => '독체자 (독립 한자)';

  @override
  String get notEveryCharacterHas => '모든 한자가 특정 부수에서 파생된 것은 아닙니다. 일부는 독립적인 상형 문자이거나 단독으로 구성됩니다.';

  @override
  String get onTheMapWe => '지도에서 이러한 독립 한자들을 \'별자리(✨)\'로 분류해 두었습니다.';

  @override
  String get iUnderstand => '이해했습니다';

  @override
  String get whatAreRadicals => '부수란 무엇인가요?';

  @override
  String get hanziAreBuiltFrom => '한자는 \'부수\'라고 불리는 기본 구성 요소로 이루어져 있습니다.\n\n부수는 한자의 핵심 의미나 주제를 결정합니다.';

  @override
  String get continueText => '계속하기';

  @override
  String get hanziAreNotJust => '한자는 단순한 글자가 아니라, 시간이 빚어낸 그림입니다.\n\n한자를 마스터하려면 붓의 흐름과 획을 익혀야 합니다.';

  @override
  String get iAmReady => '준비 완료';

  @override
  String get youAreAScholar => '당신은 탐구하는 학자입니다';

  @override
  String get theGalaxyMapAwaitsnmaster => '은하 지도가 기다리고 있습니다.\n태양(부수)을 마스터하여 행성(한자)을 해제하세요.';

  @override
  String get enterTheScroll => '두루마리 펼치기';

  @override
  String get openingTheOriginScroll => '기원의 두루마리를 펼치는 중...';

  @override
  String get text_1782026184670 => '+';

  @override
  String get theScholarsEdition => '학자 에디션';

  @override
  String get weArePreparingThe => '학자 에디션 출시를 준비 중입니다.';

  @override
  String get devBypassUnlockNow => '개발자 우회: 지금 잠금 해제';

  @override
  String get restorePurchases => '구매 내역 복원';

  @override
  String get welcomeScholarTheScroll => '환영합니다, 학자님. 두루마리가 활짝 열렸습니다.';

  @override
  String get purchasesRestoredSuccessfully => '구매 내역이 성공적으로 복원되었습니다.';

  @override
  String get noPreviousPurchasesFound => '이 계정에서 이전 구매 내역을 찾을 수 없습니다.';

  @override
  String get unlockTheFullPotential => '학습의 잠재력을 무한히 펼쳐보세요. 한 번의 구매로 평생 소장할 수 있습니다.';

  @override
  String get universalScanner => '유니버설 스캐너';

  @override
  String get noChineseCharactersFound => '이미지에서 중국어 한자를 찾을 수 없습니다.';

  @override
  String get addedNewCharactersTo => '새로운 한자가 라이브러리에 추가되었습니다!';

  @override
  String get extractingTextAndObjects => '텍스트 및 사물 추출 중...';

  @override
  String get scanATextbookSign => '교재, 간판, 사물 등을 스캔하여 중국어 한자를 추출하세요.';

  @override
  String get extractedText => '추출된 텍스트';

  @override
  String get useText => '이 텍스트 사용';

  @override
  String get noMatchingDictionaryEntries => '일치하는 사전 항목을 찾을 수 없습니다.';

  @override
  String get quizComplete => '퀴즈 완료!';

  @override
  String get returnToCourse => '코스로 돌아가기';

  @override
  String get notEnoughCardsFor => '퀴즈를 진행하기 위한 카드가 부족합니다 (최소 4장 필요).';

  @override
  String get creatorMode => '크리에이터 모드';

  @override
  String get noStoriesFoundMatching => '검색 조건과 일치하는 스토리가 없습니다.';

  @override
  String get discard => '삭제';

  @override
  String get save => '저장';

  @override
  String get generatingStoryViaDeepseek => 'DeepSeek를 통해 스토리를 생성하는 중...';

  @override
  String get storySavedToLibrary => '스토리가 라이브러리에 저장되었습니다!';

  @override
  String get storyNotFound => '스토리를 찾을 수 없습니다.';

  @override
  String get targetHskLevel => '목표 HSK 급수';

  @override
  String get wedLoveToHear => '소중한 의견을 들려주세요!';

  @override
  String get whetherYouveFoundA => '버그 제보, 기능 요청, 간단한 인사 등 여러분의 피드백은 SinoSpark 발전에 큰 힘이 됩니다.';

  @override
  String get pointYourCameraAt => '카메라를 사물에 비춰보세요';

  @override
  String get reviewAddToLibrary => '확인 후 라이브러리에 추가';

  @override
  String hideStrokeGuideStreak(Object streak) {
    return '$streak회 연속 정답 시 획 가이드 숨기기';
  }

  @override
  String inkPoints(Object points) {
    return '$points 잉크 포인트';
  }

  @override
  String speechRateMultiplier(Object rate) {
    return '$rate배속';
  }

  @override
  String animationSpeedMultiplier(Object rate) {
    return '$rate배속';
  }

  @override
  String get supportAndFeedback => '지원 및 피드백';

  @override
  String get reportBug => '버그 신고';

  @override
  String get suggestFeature => '기능 제안';

  @override
  String get generalFeedback => '일반 피드백';

  @override
  String get pleaseDrawSomethingFirst => '먼저 글씨를 써주세요';

  @override
  String get drawThisCharacter => '이 한자를 써보세요:';

  @override
  String followGuideStroke(Object current, Object total) {
    return '파란색 가이드에 따라 총 $total획 중 $current번째 획을 쓰세요';
  }

  @override
  String get skipCurrentStroke => '현재 획 건너뛰기';

  @override
  String get submitDrawing => '작성 완료';

  @override
  String addedToDeck(Object deckName, Object hanzi) {
    return '「$hanzi」을(를) 「$deckName」에 추가했습니다';
  }

  @override
  String removedFromDeck(Object hanzi) {
    return '덱에서 「$hanzi」을(를) 삭제했습니다';
  }

  @override
  String skippedNoStrokeData(Object hanzi) {
    return '「$hanzi」 건너뜀 - 해당 글자의 필순 데이터가 없습니다.';
  }

  @override
  String get startingSession => '학습 세션을 시작하는 중...';

  @override
  String get masterBuildingBlocks => '한자의 기초 구성 요소를 마스터하세요';

  @override
  String get totalWords => '총 단어 수';

  @override
  String get newInk => '획득한 잉크';

  @override
  String get learningStatus => '학습 중';

  @override
  String get masteredStatus => '완전 습득';

  @override
  String get libraryMastery => '라이브러리 숙련도';

  @override
  String get accuracyByMode => '모드별 정확도';

  @override
  String get upcomingReviews => '예정된 복습 (향후 7일)';

  @override
  String get culturalReadingRoom => '문화 서재 (文化书房)';

  @override
  String storyTitleHsk(Object level, Object title) {
    return '$title (HSK $level급)';
  }

  @override
  String get pleaseEnterTopic => '주제를 입력해 주세요';

  @override
  String createdDeckCards(Object count, Object name) {
    return '「$name」 덱($count장)이 생성되었습니다!';
  }

  @override
  String gradeResult(Object grade) {
    return '평가 결과: $grade';
  }

  @override
  String get listeningMode => '듣기 모드';

  @override
  String get readingMode => '읽기 모드';

  @override
  String get recallMode => '회상 모드';

  @override
  String get speakingMode => '말하기 모드';

  @override
  String get aiMemoryHook => 'AI 기억 연상 고리';

  @override
  String get exampleSentences => '예문';

  @override
  String get ghostCharacters => '가이드 글자 (투명도)';

  @override
  String get commonWords => '자주 쓰이는 단어';

  @override
  String get personalNotes => '개인 메모';

  @override
  String get addPersonalNotes => '자신만의 암기법이나 노트를 추가하세요...';

  @override
  String get takePhoto => '사진 촬영';

  @override
  String get gallery => '갤러리에서 선택';

  @override
  String get arLens => 'AR 렌즈';

  @override
  String addedCharToLibrary(Object char) {
    return '「$char」을(를) 라이브러리에 추가했습니다';
  }

  @override
  String get scoreText => '점수';

  @override
  String get searchDictionaryHint => '한자, 병음, 의미로 검색...';

  @override
  String get searchDeckHint => '덱 내 한자, 병음 검색...';

  @override
  String get localRestaurant => '로컬 식당';

  @override
  String get taxiToAirport => '공항 택시 탑승';

  @override
  String get silkMarketHaggling => '슈슈이제(실크마켓) 가격 흥정';

  @override
  String get medicalClinic => '중의원 / 병원 진료';

  @override
  String get meetingAFriend => '친구와의 만남';

  @override
  String get jobInterview => '입사 면접';

  @override
  String get searchRadicalsHint => '부수 검색 (예: 水, 氵)';

  @override
  String get definition => '정의 및 해설';

  @override
  String get undo => '실행 취소';

  @override
  String get hanziMaster => 'SinoSpark';

  @override
  String get unlockForever => '평생 이용권 구매 - \$9.99';

  @override
  String get clear => '지우기';

  @override
  String get clearChat => '대화 내용 지우기';

  @override
  String get typeMessage => '메시지를 입력하세요...';

  @override
  String addedToLibrary(Object hanzi) {
    return '「$hanzi」을(를) 서재에 추가했습니다';
  }

  @override
  String get generateNewStory => '새로운 스토리 생성';

  @override
  String failedToGenerateStory(Object error) {
    return '스토리 생성 실패:\n$error';
  }

  @override
  String get detail => '상세 정보';

  @override
  String get scanText => '텍스트 스캔';

  @override
  String get createMagic => 'AI 생성';

  @override
  String get learning => '학습 중';

  @override
  String get upcomingReviews7Days => '예정된 복습 (향후 7일)';

  @override
  String get askFollowUpQuestion => '추가 질문하기...';

  @override
  String get pasteScanToSimplify => '중국어 텍스트를 붙여넣거나 스캔하여 쉬운 글로 변환';

  @override
  String get searchStoriesHint => '제목이나 태그로 스토리 검색 (예: 신화, 여행)';

  @override
  String get importAll => '모두 가져오기';

  @override
  String get ascendAll => '전체 승격';

  @override
  String get startAscension => '숙련 단계 시작';

  @override
  String get scenarioLocalRestaurant => '로컬 식당';

  @override
  String get scenarioLocalRestaurantDesc => '음식을 주문하고 추천 메뉴를 물어보는 연습을 해보세요.';

  @override
  String get scenarioTaxiAirport => '공항 택시 탑승';

  @override
  String get scenarioTaxiAirportDesc => '기사님께 목적지를 전달하고 교통 상황에 대해 이야기해 보세요.';

  @override
  String get scenarioSilkMarket => '슈슈이제(실크마켓) 가격 흥정';

  @override
  String get scenarioSilkMarketDesc => '기념품을 더 좋은 가격으로 구매하기 위해 흥정해 보세요.';

  @override
  String get scenarioMedicalClinic => '중의원 / 병원 진료';

  @override
  String get scenarioMedicalClinicDesc => '의사에게 자신의 증상을 구체적으로 설명해 보세요.';

  @override
  String get scenarioMeetingFriend => '친구와의 만남';

  @override
  String get scenarioMeetingFriendDesc => '오랜만에 만난 친구와 안부를 나누고 근황을 이야기해 보세요.';

  @override
  String get scenarioJobInterview => '입사 면접';

  @override
  String get scenarioJobInterviewDesc => '상하이의 IT 테크 기업 채용 면접에 임해 보세요.';

  @override
  String get createCustomScenario => '맞춤 시나리오 만들기';

  @override
  String get customScenarioTitleHint => '제목 (예: 결혼 피로연)';

  @override
  String get customScenarioDescHint => '상황 및 배경 설명';

  @override
  String get customScenarioPersonaHint => 'AI 역할 (예: 호기심 많은 직장 동료)';

  @override
  String get customScenarioDifficulty => '난이도';

  @override
  String get createAction => '만들기';

  @override
  String get cancelAction => '취소';

  @override
  String get mythsAndLegends => '신화와 전설';

  @override
  String get historyAndCulture => '역사와 문화';

  @override
  String get idiomsTitle => '고사성어 (成语)';

  @override
  String get theMonkeyKing => '손오공';

  @override
  String get theMonkeyKingDesc => '손오공 (서유기)';

  @override
  String get huaMulan => '화목란 (뮬란)';

  @override
  String get huaMulanDesc => '병든 아버지를 대신해 군대에 입대한 목란의 이야기';

  @override
  String get confuciusTitle => '공자';

  @override
  String get confuciusDesc => '공자의 삶과 지혜로운 가르침';

  @override
  String get theGreatWall => '만리장성';

  @override
  String get theGreatWallDesc => '만리장성의 축조 역사와 비화';

  @override
  String get generateTopic => '주제 생성';

  @override
  String get simplifyText => '텍스트 쉬운 글로 변환';

  @override
  String get topicHint => '주제 (예: 베이징의 외계인)';

  @override
  String get tagsHint => '태그 (쉼표로 구분, 선택 사항)';

  @override
  String get speakWithMasterLin => '린(林) 사부와 대화하기';

  @override
  String get masterLinGreeting => '어서 오너라. 묵향이 준비되었으니, 오늘은 어떤 글자나 표현을 함께 탐구해 볼까?';

  @override
  String get typeYourMessage => '메시지를 입력하세요...';

  @override
  String get theMainLibrary => '메인 라이브러리';

  @override
  String get hsk1Foundation => 'HSK 1급: 기초';

  @override
  String get hsk2Elementary => 'HSK 2급: 초급';

  @override
  String get hsk3Intermediate => 'HSK 3급: 중급';

  @override
  String get inDeckCheck => '덱에 포함됨 ✓';

  @override
  String get addToDeckPlus => '+ 덱에 추가';

  @override
  String get openCardArrow => '카드 열기 →';

  @override
  String get pronunciationPartial => '성조 부정확';

  @override
  String get pronunciationWrong => '발음 틀림';

  @override
  String get toneExpected => '목표 성조';

  @override
  String get toneYouSaid => '발음한 성조';

  @override
  String get gotIt => '확인 완료!';

  @override
  String foundNCharacters(int count) {
    return '$count개의 한자를 찾았습니다';
  }

  @override
  String get lookingUpCharacters => '한자 검색 중…';

  @override
  String get practiceAll => '전체 연습하기';

  @override
  String get arLensObjects => '사물 인식';

  @override
  String get arLensText => '텍스트 인식';

  @override
  String get arLensDetectedText => '감지된 텍스트';

  @override
  String get duration12Min => '1~2분 소요';

  @override
  String get aClassicTangDynastyPoem => '당나라 고전 명시';

  @override
  String get aClassicTangDynastyPoemBy => '~의 당나라 고전 명시';

  @override
  String get aStructuralComponent => '한자의 구조적 구성 요소입니다.';

  @override
  String get addSelectedToDeck => '선택 항목을 덱에 추가';

  @override
  String addTo(Object target) {
    return ' 에 추가';
  }

  @override
  String addedHanziToYourLibrary(String hanzi) {
    return '「$hanzi」을(를) 라이브러리에 추가했습니다';
  }

  @override
  String get adjustFontSize => '글자 크기 조정';

  @override
  String get againGoodEasyHard => '⬅️ 다시    ➡️ 보통    ⬆️ 쉬움    ⬇️ 어려움';

  @override
  String get aiAnalysisFailed => 'AI 분석 실패';

  @override
  String get aiIsThinking => 'AI가 생각하는 중입니다...';

  @override
  String get aiSceneAnalysisFailed => 'AI 장면 분석 실패';

  @override
  String get allLabel => '전체';

  @override
  String get allPinyin => '모든 병음';

  @override
  String get alreadyHaveAccountSignIn => '이미 계정이 있으신가요? 로그인';

  @override
  String get analysisFailed => '분석 실패: ';

  @override
  String get analyzingClassicalCharacters => '고전 한자 분석 중...';

  @override
  String get anatomy => '구조 분석';

  @override
  String get ancientPhilosophy => '고대 철학';

  @override
  String get articleSavedToMediaHub => '기사가 미디어 허브에 저장되었습니다!';

  @override
  String get askAFollowUp => '추가 질문하기...';

  @override
  String get audioPrivacyAndHowThingsWork => '오디오, 개인정보 보호 및 작동 방식';

  @override
  String get audiobookPlayer => '오디오북 플레이어';

  @override
  String get audiobookVoice => '오디오북 음성';

  @override
  String get auntieMaTown => '마 이모(马阿姨): 활기찬 성격의 노점상 주인. 마을에서 가장 바삭한 로우자모(肉夹馍)와 량피(凉皮)의 달인.';

  @override
  String get back => '뒤로';

  @override
  String get baristaKevinNotes => '바리스타 샤오카이(小凯): 윈난산 스페셜티 원두의 풍미와 아로마에 열정적인 청년 로스터.';

  @override
  String get bbc => 'BBC 중국어 뉴스';

  @override
  String get beginYourJourney => '학습 여정 시작하기';

  @override
  String get bestValue => '최고 인기 / 추천';

  @override
  String get bookLinkCopiedToClipboard => '도서 링크가 클립보드에 복사되었습니다!';

  @override
  String get bookmarkChapter => '이 장 북마크';

  @override
  String get bookmarks => '북마크';

  @override
  String get books => '도서';

  @override
  String get briefing => '요약 브리핑';

  @override
  String get bugReport => '버그 신고';

  @override
  String get caoXueqinDecline => '조설근(曹雪芹, 약 1715~1763)은 청나라의 소설가입니다. 한때 명문 귀족이었으나 옹정제 시기 몰락한 가문 출신으로, 가난한 말년에 집필한 《홍루몽》은 귀족 사회의 쇠락을 치밀한 심리 묘사로 그려낸 중국 고전문학의 독보적 금자탑입니다.';

  @override
  String get cardsTitle => '카드';

  @override
  String get cc => '자막 (CC)';

  @override
  String get characterOrWord => '한자 / 단어';

  @override
  String get chatMore => '대화 계속하기';

  @override
  String get chefChenShumai => '천 셰프(陈师傅): 신선한 하가우(새우 딤섬)와 샤오마이를 추천하는 유쾌한 광둥 딤섬 장인.';

  @override
  String get chineseEpics => '중국 고전 서사시';

  @override
  String get chinesePoetry => '중국 한시 / 시가';

  @override
  String get chng => 'chéng';

  @override
  String get chongqingSpicyHotpotFeast => '충칭 마라 훠궈 만찬';

  @override
  String get chooseAudiobookVoice => '오디오북 음성 선택';

  @override
  String get chooseVoice => '음성 선택';

  @override
  String get compare => '비교하기';

  @override
  String get compare4Tones => '성조(4성) 비교';

  @override
  String get configuration => '구성 설정';

  @override
  String get contemporary => '현대 / 컨템포러리';

  @override
  String get context => '문맥';

  @override
  String get couldNotLoadLibrary => '라이브러리를 불러올 수 없습니다';

  @override
  String get couldNotLoadVocabulary => '어휘 데이터를 불러오지 못했습니다.';

  @override
  String get couldNotOpenEmailApp => '이메일 앱을 열 수 없습니다.';

  @override
  String get createAccount => '계정 만들기';

  @override
  String get createNewDeck => '새 덱 만들기';

  @override
  String get createScenario => '시나리오 만들기';

  @override
  String get createStory => '스토리 생성';

  @override
  String get customLabel => '맞춤 설정';

  @override
  String get customWord => '사용자 지정 단어';

  @override
  String get days => '일';

  @override
  String get deck => '덱';

  @override
  String get deckName => '덱 이름';

  @override
  String get deckStory => '덱 스토리';

  @override
  String get deepAnalysis => '심층 분석';

  @override
  String get defaultDeck => '기본 덱';

  @override
  String get deleteLabel => '삭제';

  @override
  String get deleteScenario => '시나리오 삭제';

  @override
  String get deletesAllProgressPermanently => '모든 학습 진행도를 영구적으로 삭제합니다';

  @override
  String get developerBackdoorUnlocked => '개발자 메뉴가 활성화되었습니다!';

  @override
  String get doesNotExistInChinese => '중국어에 해당 표현이 없습니다';

  @override
  String get dontHaveAccountSignUp => '계정이 없으신가요? 회원가입';

  @override
  String get draftingStoryOutline => '스토리 개요를 작성하는 중...';

  @override
  String get dynamicFlowState => '동적 플로우 상태';

  @override
  String get dynamicFlowStateParenthetical => '동적 (플로우 상태)';

  @override
  String get editCard => '카드 수정';

  @override
  String get egAnimeVocab => '예: 애니메이션 어휘';

  @override
  String get egFormalBusinessLanguageSlangForTexting => '예: 격식 있는 비즈니스 표현, 메신저 신조어...';

  @override
  String get egOrderingAtARestaurantBusinessVocab => '예: 식당에서 주문하기, 비즈니스 실무 어휘...';

  @override
  String get egWeddingReceptionTechInterview => '예: 결혼 피로연 축사, IT 기술 면접...';

  @override
  String get emailLabel => '이메일';

  @override
  String get english => '영어';

  @override
  String get englishAndWorld => '영어 및 세계 문학';

  @override
  String get episodes => '에피소드';

  @override
  String get erase => '초기화';

  @override
  String get eraseDeckQuestion => '덱을 초기화하시겠습니까?';

  @override
  String errorFetchingTranslationForLabelE(String label, String e) {
    return '$label 번역 가져오기 실패: $e';
  }

  @override
  String errorLoadingMicroreadsE(String e) {
    return '마이크로 리딩 불러오기 오류: $e';
  }

  @override
  String errorLoadingNovelsE(String e) {
    return '소설 불러오기 오류: $e';
  }

  @override
  String errorLoadingPoetryE(String e) {
    return '시가 불러오기 오류: $e';
  }

  @override
  String get exitFocus => '집중 모드 종료';

  @override
  String get explore => '탐색';

  @override
  String get exportToThisDeck => '이 덱으로 내보내기';

  @override
  String get extractAndSimplify => '추출 및 쉬운 글로 변환';

  @override
  String get failedToCreateDeck => '덱 생성에 실패했습니다';

  @override
  String get failedToLoadDailyContent => '일일 학습 콘텐츠를 불러오지 못했습니다';

  @override
  String get failedToLoadEpisodes => '에피소드를 불러오지 못했습니다';

  @override
  String get failedToLoadShows => '프로그램 목록을 불러오지 못했습니다';

  @override
  String get finalizingDetails => '세부 사항을 정리하는 중...';

  @override
  String get finalizingStoryDetails => '스토리 세부 사항을 다듬는 중...';

  @override
  String get firebaseAuthConsole => 'Firebase 인증이 활성화되지 않았습니다. Firebase 콘솔에서 로그인 방식을 활성화해 주세요.';

  @override
  String get flashcardDeckTitle => '플래시카드 덱';

  @override
  String get focus => '집중';

  @override
  String get foodAndCooking => '요리 및 미식';

  @override
  String get forward => '앞으로';

  @override
  String get freeFlow => '자유 대화';

  @override
  String get frenchClassics => '프랑스 고전';

  @override
  String get full => '전체';

  @override
  String get gamingAndEsports => '게임 및 e스포츠';

  @override
  String get germanClassics => '독일 고전';

  @override
  String get ghostPinyin => '가이드 병음';

  @override
  String get goodAttempt => '좋은 시도예요!';

  @override
  String get gotItSimple => '확인 완료';

  @override
  String get grammar => '문법';

  @override
  String get grandmaLiuFilling => '류 할머니(刘奶奶): 물만두 예쁘게 빚는 법과 돼지고기 파 속 만드는 비법을 알려주는 정 많은 북방 할머니.';

  @override
  String get great => '훌륭해요!';

  @override
  String get handmadeDumplingFeastInHarbin => '하얼빈 수제 만두 만찬';

  @override
  String get hanziCharacter => '한자 (Hanzi)';

  @override
  String get hapticFeedback => '햅틱 피드백';

  @override
  String get helpAndSupport => '도움말 및 고객지원';

  @override
  String get hidden => '숨김';

  @override
  String get hideEnglishTranslations => '영어 번역 숨기기';

  @override
  String get hidePinyin => '병음 숨기기';

  @override
  String get highlight => '하이라이트';

  @override
  String get howWouldYouLikeToStudy => '어떤 방식으로 학습하시겠습니까?';

  @override
  String get hsk1 => 'HSK 1급';

  @override
  String get hsk4UpperIntermediate => 'HSK 4급: 중상급';

  @override
  String get hsk5Advanced => 'HSK 5급: 고급';

  @override
  String get hsk6Mastery => 'HSK 6급: 마스터';

  @override
  String get hskCollections => 'HSK 단어 컬렉션';

  @override
  String hskLevel(String level) {
    return 'HSK $level급';
  }

  @override
  String get hskSimplifySubtitles => 'HSK 맞춤 자막 평이화';

  @override
  String get hskVocabularyCollections => 'HSK 어휘 컬렉션';

  @override
  String get i => '나';

  @override
  String get ifTheAgain => 'AI가 의도와의 차이를 감지하면 \'혹시 ...을(를) 말씀하시려 했나요?\'라고 묻습니다. 이때 \'예, 다시 평가해 주세요!\'를 누르면 다시 말할 필요 없이 기존 녹음으로 즉시 재채점을 받을 수 있습니다.';

  @override
  String get install => '설치';

  @override
  String get just => '단 \$';

  @override
  String get keyword => '키워드';

  @override
  String get knowledgeBase => '지식 베이스';

  @override
  String get liRuzhenSubjects => '이여진(李汝珍, 약 1763~1830)은 음운학, 바둑, 천문학에 조예가 깊었던 청나라 학자입니다. 기상천외한 나라들을 여행하는 상인의 이야기를 담은 환상 소설 《경화연(鏡花緣)》은 시대를 앞선 페미니즘적 문제의식과 백과사전적 박학다식함으로 높은 평가를 받습니다.';

  @override
  String get library => '문화 서재 (文化书房)';

  @override
  String get lifestyleAndVlog => '라이프스타일 및 브이로그';

  @override
  String get listenInAudiobookMode => '오디오북 모드로 듣기';

  @override
  String get listenToThisWord => '이 단어 발음 듣기';

  @override
  String get listening => '듣는 중...';

  @override
  String get liuEEncroachment => '유악(劉鶚, 1857~1909)은 엔지니어, 의사, 소설가로 활약한 청말의 박식가입니다. 유일한 소설 《노잔유기(老殘遊記)》는 왕조의 몰락과 외세의 침탈 속에서 고통받는 중국을 순회하는 방랑 의사의 여정을 서정적이면서도 날카로운 비판 의식으로 담아낸 명작입니다.';

  @override
  String get loadingTranslations => '번역을 불러오는 중...';

  @override
  String get luXunVernacular => '루쉰(魯迅, 1881~1936, 본명 저우수런)은 중국 현대 문학의 아버지입니다. 국민의 정신을 일깨우기 위해 의학을 버리고 문필가가 되었으며, 《광인일기》와 《아Q정전》 등의 소설을 통해 백화문 문학 혁명을 이끌었습니다.';

  @override
  String get luoGuanzhongEpic => '나관중(羅貫中, 약 1330~1400)은 원말명초의 극작가이자 소설가로, 시내암에게 수학한 것으로 전해집니다. 정사와 민간 설화, 극적 서사를 집대성한 그의 대작 《삼국지연의(三國志演義)》는 중국 역사 서사 문학의 최고봉으로 꼽힙니다.';

  @override
  String get makeACustomCollection => '나만의 맞춤 단어장 만들기';

  @override
  String get manageDailyDropsAndReviewReminders => '일일 학습 및 복습 알림 관리';

  @override
  String get managerYuOptions => '위 매니저(余店长): 천엽, 오리 선지, 담백한 백탕 육수 등 인기 메뉴를 센스 있게 추천하는 열정적인 훠궈 전문점 지배인.';

  @override
  String get masterGaoRubs => '가오 사부(高师傅): 숯불 꼬치구이의 달인. 손님들과 맵기 조절과 비법 쯔란 가루에 대해 유쾌하게 이야기를 나눕니다.';

  @override
  String get masterThisToUnlockItsGalaxy => '이 요소를 마스터하여 은하 맵을 잠금 해제하세요.';

  @override
  String get masterZhaoBrewing => '자오 사부(赵师傅): 다도에 조예가 깊은 차(茶) 전문가. 전통 궁푸차(工夫茶) 우려내는 법을 친절하게 전수합니다.';

  @override
  String get mastery => '숙련도';

  @override
  String get maybeLater => '나중에 하기';

  @override
  String get memes => '밈 & 트렌드';

  @override
  String get midnightBbqSkewersInWuhan => '우한의 심야 숯불 꼬치구이';

  @override
  String get mo => '/월';

  @override
  String get modernChinese => '현대 중국어';

  @override
  String get monthly => '월간 플랜';

  @override
  String get morningDimSumCartInGuangzhou => '광저우 아침 딤섬 카트';

  @override
  String get nameLabel => '이름';

  @override
  String get native => '원어민';

  @override
  String get newCard => '새 카드';

  @override
  String get newDeck => '새 덱';

  @override
  String get newDeckName => '새 덱 이름';

  @override
  String get noActiveSubscriptionFound => '활성화된 구독이 없습니다.';

  @override
  String get noEpisodesFound => '에피소드를 찾을 수 없습니다';

  @override
  String get noKeyWordsFoundForThisStory => '이 스토리에 등록된 키워드가 없습니다.';

  @override
  String get noLabel => '아니요';

  @override
  String get noNewWordsFound => '새로운 단어가 없습니다!';

  @override
  String get noPinyin => '병음 없음';

  @override
  String get noPremiumPackagesAvailable => '현재 이용 가능한 프리미엄 플랜이 없습니다.';

  @override
  String noResultsFoundForSearchquery(String searchQuery) {
    return '「$searchQuery」에 대한 검색 결과가 없습니다';
  }

  @override
  String get noSavedArticlesYet => '아직 저장된 기사가 없습니다.';

  @override
  String get noShowsAvailable => '시청 가능한 프로그램이 없습니다';

  @override
  String get noStoriesFound => '스토리를 찾을 수 없습니다.';

  @override
  String get noWordsSelected => '선택된 단어가 없습니다';

  @override
  String get notes => '메모';

  @override
  String get notoserifsc => 'NotoSerifSC';

  @override
  String get objectivesTitle => '학습 목표';

  @override
  String get openInYoutube => 'YouTube에서 열기';

  @override
  String get orderingHanddripCoffeeInShanghai => '상하이 카페에서 핸드드립 커피 주문하기';

  @override
  String get orderingSugarcoatedHawsInWinterBeijing => '겨울철 베이징에서 탕후루(산사나무 열매 사탕) 사 먹기';

  @override
  String partnerLang(String lang) {
    return '대화 상대 ($lang)';
  }

  @override
  String get partnerListening => '대화 상대가 듣고 있습니다...';

  @override
  String get partnerSpeaking => '대화 상대가 말하고 있습니다...';

  @override
  String get passwordLabel => '비밀번호';

  @override
  String get pause => '일시 정지';

  @override
  String get perfect => '완벽해요!';

  @override
  String get personalizedPathBasedOnDeck => '내 덱을 기반으로 한 맞춤형 학습 경로입니다.';

  @override
  String play(Object pinyin) {
    return '발음 재생 ($pinyin)';
  }

  @override
  String get pleaseEnterMessageBeforeSending => '전송할 메시지를 입력해 주세요.';

  @override
  String get practiceInRoleplay => '롤플레잉으로 실전 연습';

  @override
  String get practiceModes => '연습 모드';

  @override
  String get practicePronouncingWithAiGrading => 'AI 발음 채점으로 이 단어 연습하기';

  @override
  String get preparingReadingInterface => '읽기 화면을 준비하는 중...';

  @override
  String get privacy => '개인정보 보호';

  @override
  String get privacyAndAudio => '개인정보 및 오디오';

  @override
  String get puSonglingLiterature => '포송령(蒲松齡, 1640~1715)은 과거 시험에 거듭 낙방한 후 평생에 걸쳐 민간 설화를 수집해 《요재지이(聊齋志異)》를 완성한 청나라의 문인입니다. 여우 요괴, 귀신, 선비가 등장하는 그의 기이한 이야기들은 동양 기이 문학의 최고 걸작으로 손꼽힙니다.';

  @override
  String get qaFaq => '자주 묻는 질문 (FAQ)';

  @override
  String get questsTitle => '퀘스트';

  @override
  String get quickBookmarks => '빠른 북마크';

  @override
  String get radical => '부수';

  @override
  String get ready => '준비 완료';

  @override
  String get readyToInterpret => '통역 준비 완료';

  @override
  String get readyToStart => '시작할 준비가 되었습니다.';

  @override
  String get recentBookmarks => '최근 북마크';

  @override
  String get refiningGrammar => '문법을 다듬는 중...';

  @override
  String get refresh => '새로고침';

  @override
  String get removeFromSaved => '저장 목록에서 삭제';

  @override
  String get removeFromSavedScenarios => '저장된 시나리오에서 삭제';

  @override
  String get removed => '삭제됨';

  @override
  String get requestPermissions => '권한 요청';

  @override
  String get rescind => '취소';

  @override
  String get restore => '복원하기';

  @override
  String get results => '결과';

  @override
  String get resume => '이어하기';

  @override
  String get retry => '다시 시도';

  @override
  String get revenuecatError => 'RevenueCat 오류: ';

  @override
  String revenuecatErrorE(String e) {
    return 'RevenueCat 오류: $e';
  }

  @override
  String get reviewExtractedDeck => '추출된 덱 복습하기';

  @override
  String get reviewIn => '복습 주기';

  @override
  String get reviewingYourTones => '성조 평가 중...';

  @override
  String get saveAll => '모두 저장';

  @override
  String get saveScenario => '시나리오 저장';

  @override
  String get saveThisScenario => '이 시나리오 저장';

  @override
  String get saved => '저장됨';

  @override
  String get scanAnother => '다른 항목 스캔';

  @override
  String get scenarioRemoved => '시나리오가 삭제되었습니다';

  @override
  String get scenarioSavedFindInCustomTab => '시나리오가 저장되었습니다! \'맞춤\' 탭에서 확인하세요.';

  @override
  String score(Object score, Object total) {
    return '점수: $score / $total';
  }

  @override
  String get searchByPinyinOrMeaning => '병음 또는 뜻으로 검색...';

  @override
  String get searchByTitleOrTag => '제목 또는 태그로 검색...';

  @override
  String get searchDictionaryOrTypeCustom => '사전 검색 또는 직접 입력';

  @override
  String get searchHint => '검색...';

  @override
  String get searchOrEnterUrl => '검색어 또는 URL 입력';

  @override
  String get searchScenariosHint => '시나리오 검색...';

  @override
  String get searchStoriesIdiomsNews => '스토리, 성어, 뉴스 검색...';

  @override
  String get searchTopicsEgCookingHistory => '주제 검색 (예: 요리, 역사)';

  @override
  String get seeAll => '전체 보기';

  @override
  String get selectADeck => '덱 선택';

  @override
  String get selectPracticeMode => '연습 모드 선택';

  @override
  String get selectingHskVocabulary => 'HSK 어휘 선별 중...';

  @override
  String get send => '전송';

  @override
  String get sendMessage => '메시지 보내기';

  @override
  String get serif => '명조체 (Serif)';

  @override
  String get shadow => '섀도잉';

  @override
  String get shiNaianEpic => '시내암(施耐庵, 약 1296~1372)은 과거에 급제했으나 관직을 버리고 은둔의 길을 택한 원말명초의 문인입니다. 의로운 호걸들의 반란과 활약을 그린 그의 걸작 《수호전(水滸傳)》은 중국 무협 군상극의 효시가 되었습니다.';

  @override
  String get showEnglish => '영어 표시';

  @override
  String get showEnglishTranslations => '영어 번역 표시';

  @override
  String get showHanzi => '한자 표시';

  @override
  String get showPinyin => '병음 표시';

  @override
  String get showTranslation => '번역 표시';

  @override
  String get shows => '영상 콘텐츠';

  @override
  String get signIn => '로그인';

  @override
  String get simplifiedArticle => '쉬운 글로 변환된 기사';

  @override
  String get simplifyingSubtitles => '자막을 쉽게 변환하는 중...';

  @override
  String get sincereHonest => '진솔하고 성실함';

  @override
  String get sleepTimer => '수면 타이머';

  @override
  String get smartDeck => '스마트 덱';

  @override
  String get spanishAndWorld => '스페인어 및 세계 문학';

  @override
  String get speaker => '스피커';

  @override
  String get spotifyStylePlayer => 'Spotify 스타일 플레이어';

  @override
  String get storyBookmarkedInLibrary => '스토리가 서재에 북마크되었습니다!';

  @override
  String get streetFoodNightMarketInXian => '시안 야시장 길거리 음식 탐방';

  @override
  String get strokes => '획수';

  @override
  String get studyCharacter => '한자 학습';

  @override
  String get subtitleOpacity => '자막 불투명도';

  @override
  String get suggestion => '추천 표현';

  @override
  String get summary => '요약';

  @override
  String get supernaturalAndFolklore => '기이담 및 민속';

  @override
  String get swipeToGrade => '스와이프하여 채점:';

  @override
  String get tableOfContents => '목차';

  @override
  String get tapToRetry => '탭하여 다시 시도';

  @override
  String get teaTastingInChengdu => '청두 전통 찻집 시음 체험';

  @override
  String get techAndGadgets => '테크 및 디지털';

  @override
  String get terms => '이용약관';

  @override
  String get theGalaxyCharacters => '은하 지도가 기다리고 있습니다.\n태양(부수)을 마스터하여 행성(한자)을 해제하세요.';

  @override
  String get theme => '테마';

  @override
  String get thinking => '생각하는 중...';

  @override
  String get thisArticleCharacters => '이 글에는 번체자가 포함되어 있습니다.';

  @override
  String get todaysWord => '오늘의 단어';

  @override
  String get togglePinyin => '병음 표시 전환';

  @override
  String get toggleTranslation => '번역 표시 전환';

  @override
  String get toneDoesNotExistInMandarin => '해당 성조는 표준 중국어(보통화)에 존재하지 않습니다.';

  @override
  String get toneGraph => '성조 피치 그래프';

  @override
  String get traceLabel => '따라 쓰기';

  @override
  String get trailer => '예고편';

  @override
  String get translatingAndAddingPinyin => '번역 및 병음 표기 생성 중...';

  @override
  String get translatingText => '텍스트 번역 중...';

  @override
  String get turnOn => '켜기';

  @override
  String get typeHanziPinyinOrEnglish => '한자, 병음 또는 한국어 입력...';

  @override
  String get unknown2 => '게임 실황 왕자영요 원신';

  @override
  String get unknown3 => '중국 요리 레시피';

  @override
  String get unknown4 => '중국 IT 테크 리뷰';

  @override
  String get unrollingTheScroll => '두루마리를 펼치는 중...';

  @override
  String get upperIntermediate => '중상급';

  @override
  String get vibrationsForInteractions => '상호작용 진동 피드백';

  @override
  String get video => '동영상';

  @override
  String get viewAnswer => '정답 보기';

  @override
  String get viewAsList => '목록으로 보기';

  @override
  String get viewBookmarks => '북마크 목록 보기';

  @override
  String get viewMyDrawing => '내가 쓴 글씨 확인';

  @override
  String get vlog => '중국 일상 브이로그';

  @override
  String get voice => '음성:';

  @override
  String get web => '웹';

  @override
  String get wedLoveToHearFromYou => '여러분의 소중한 의견을\n들려주세요.';

  @override
  String get welcomeBack => '다시 오신 것을 환영합니다';

  @override
  String get whatDoesThisMean => '무슨 뜻인가요?';

  @override
  String get whatHappensToMyChatHistory => '채팅 대화 기록은 어떻게 관리되나요?';

  @override
  String get whatIfAiMishears => 'AI가 제 발음을 잘못 인식하면 어떻게 되나요?';

  @override
  String get whichCharacterIs => '다음 설명에 해당하는 글자는 무엇인가요:';

  @override
  String get wikipedia => '위키백과';

  @override
  String get wordsSavedAndSrsScheduled => '단어가 저장되고 SRS 복습 주기가 등록되었습니다!';

  @override
  String get writeYourMessageHere => '여기에 메시지를 작성하세요...';

  @override
  String get wuChengenLiterature => '오승은(吳承恩, 약 1500~1582)은 장쑤성 화이안 출신의 명나라 소설가입니다. 오랜 세월 전해 내려온 민간 설화, 불교적 우화, 번뜩이는 풍자 정신을 결합하여 현장 법사의 인도 순례 설화를 대작 《서유기(西遊記)》로 승화시켰습니다.';

  @override
  String get wuJingziClass => '오경재(吳敬梓, 1701~1754)는 안후이성 출신의 청나라 소설가입니다. 물려받은 가산을 털어 평생을 《유림외사(儒林外史)》 집필에 바쳤으며, 과거 시험의 폐해와 사대부 계층의 위선과 부패를 신랄하게 풍자했습니다.';

  @override
  String get xuZhonglinWarfare => '허중림(許仲琳, 16~17세기 활동)은 명나라의 문인으로, 대작 신마 소설 《봉신연의(封神演義)》의 편찬자로 널리 알려져 있습니다. 은주 교체기의 역사에 도교의 신선 사상과 천상계의 전투를 화려하게 엮어낸 고전입니다.';

  @override
  String get yearly => '연간 플랜';

  @override
  String get yesReGradeMe => '예, 다시 평가해 주세요!';

  @override
  String you(Object lang) {
    return '나 ($lang)';
  }

  @override
  String get youAreSpeaking => '말하는 중';

  @override
  String get youLabel => '나';

  @override
  String youLang(String lang) {
    return '나 ($lang)';
  }

  @override
  String get youMustAccount => '계정을 생성하려면 이용약관 및 개인정보 처리방침에 동의해야 합니다.';

  @override
  String get yourEchoModels => 'Echo Hall의 대화 내용은 기기 로컬에만 안전하게 저장되어 언제든 다시 들을 수 있습니다. 사용자의 개인 음성 대화는 AI 모델 학습에 사용되지 않습니다.';

  @override
  String get zhOnly => '중국어 전용';

  @override
  String get hsk_1300_cards => '1300장의 카드';

  @override
  String get hsk_154_cards => '154장의 카드';

  @override
  String get hsk_162_cards => '162장의 카드';

  @override
  String get hsk_2500_cards => '2500장의 카드';

  @override
  String get hsk_299_cards => '299장의 카드';

  @override
  String get hsk_602_cards => '602장의 카드';

  @override
  String get added_to_review_queue => '복습 큐에 추가됨';

  @override
  String added_cards_to(int cardCount, String deckName) {
    return '「$deckName」에 $cardCount장의 카드가 추가되었습니다.';
  }

  @override
  String added_to_your_library(Object hanzi) {
    return '「$hanzi」을(를) 라이브러리에 추가했습니다';
  }

  @override
  String get advanced => '고급';

  @override
  String get ai_stories => 'AI 스토리';

  @override
  String analysis_failed(Object error) {
    return '분석 실패: $error';
  }

  @override
  String get analyzing_pronunciation_with_gemini_ai => 'Gemini AI로 발음을 분석하는 중...';

  @override
  String get analyzing_your_pronunciation => '발음을 분석하는 중...';

  @override
  String are_you_sure_you_want_to(String deckName) {
    return '정말로 「$deckName」 덱을 완전히 삭제하시겠습니까? 이 작업은 취소할 수 없으며 덱 안의 모든 카드가 삭제됩니다.';
  }

  @override
  String ask_about(String hanzi) {
    return '「$hanzi」에 대해 질문하기...';
  }

  @override
  String get audio_haptics => '오디오 및 햅틱';

  @override
  String get audio_could_not_start_check_your => '오디오를 시작할 수 없습니다. 인터넷 연결과 기기의 오디오 설정을 확인하세요.';

  @override
  String get calligraphy_trace => '서예 필순 따라 쓰기';

  @override
  String chapters(Object count) {
    return '$count장';
  }

  @override
  String get char => '한자';

  @override
  String get chinese_character => '중국어 한자';

  @override
  String get contact_us_and_report_issues => '문의하기 및 문제 신고';

  @override
  String created_smart_deck_with_words(String deckName, int wordCount) {
    return '스마트 덱 생성 완료: 「$deckName」 ($wordCount개 단어)';
  }

  @override
  String get custom_ai_generated_story => 'AI가 생성한 맞춤형 스토리입니다.';

  @override
  String get display_content => '디스플레이 및 콘텐츠';

  @override
  String get do_you_keep_or_store_my => '내 음성 녹음 데이터가 서버에 저장되나요?';

  @override
  String get elementary => '초급';

  @override
  String error_creating_scenario(Object error) {
    return '시나리오 생성 오류: $error';
  }

  @override
  String error_fetching_translation_for(Object error) {
    return '번역 불러오기 오류: $error';
  }

  @override
  String error_loading_chapters(Object error) {
    return '챕터 불러오기 오류: $error';
  }

  @override
  String get error_loading_decks => '덱 불러오기 오류';

  @override
  String error_loading_microreads(Object error) {
    return '마이크로 리딩 불러오기 오류: $error';
  }

  @override
  String error_loading_novels(Object error) {
    return '소설 불러오기 오류: $error';
  }

  @override
  String error_loading_poetry(Object error) {
    return '시가 불러오기 오류: $error';
  }

  @override
  String get etymology => '어원 및 자원(字源): ';

  @override
  String get explanation => '해설';

  @override
  String get extracted_text_tap_to_lookup => '추출된 텍스트 (탭하여 단어 검색)';

  @override
  String extraction_failed(Object error) {
    return '추출 실패: $error';
  }

  @override
  String get failed_to_download => '다운로드에 실패했습니다.';

  @override
  String failed_to_generate_scenario(Object error) {
    return '시나리오 생성 실패: $error';
  }

  @override
  String failed_to_generate_story(Object error) {
    return '스토리 생성 실패:\n$error';
  }

  @override
  String failed_to_load_context(Object error) {
    return '문맥 로드 실패: $error';
  }

  @override
  String get feature_request => '기능 제안';

  @override
  String get foundation => '기초 / 입문';

  @override
  String get how_is_my_pronunciation_scored => '발음 점수는 어떻게 채점되나요?';

  @override
  String hsk(Object level) {
    return 'HSK $level급';
  }

  @override
  String hsk_vocabulary(int hskLevel) {
    return 'HSK $hskLevel급 필수 어휘';
  }

  @override
  String get hsk_level => 'HSK 급수';

  @override
  String get intermediate => '중급';

  @override
  String get learning_stats => '학습 통계';

  @override
  String get mandarin => '중국어 (보통화)';

  @override
  String get meaning => '의미 / 뜻';

  @override
  String get no_decks_found => '생성된 덱이 없습니다.';

  @override
  String no_results_found_for(Object searchQuery) {
    return '「$searchQuery」에 대한 검색 결과가 없습니다';
  }

  @override
  String get no_when_you_use_echo_hall => '아니요. Echo Hall, 학자의 판정, 섀도잉 스튜디오를 사용할 때 음성은 발음 평가를 위해 실시간으로 안전하게 처리된 직후 즉시 파기됩니다. 오직 학습 진도 관리를 위한 점수 수치만 저장됩니다.';

  @override
  String get notification_settings => '알림 설정';

  @override
  String get open_settings => '설정 열기';

  @override
  String get phoneme => '음소';

  @override
  String get play_reference_pronunciation => '모범 발음 재생';

  @override
  String get please_select_a_deck_to_add => '카드를 추가할 덱을 선택해 주세요.';

  @override
  String get point_at_chinese_text_to_translate => '카메라를 중국어 텍스트에 비추어 번역하세요';

  @override
  String get practice_writing_the_strokes_by_hand => '직접 손으로 쓰며 획순과 필순을 연습하세요';

  @override
  String get preferences_audio_and_display => '환경설정, 오디오 및 화면';

  @override
  String get preparing_your_scholars_verdict => '학자의 판정 결과를 준비하는 중...';

  @override
  String get previous => '이전';

  @override
  String question(Object current, Object total) {
    return '문제 $current / $total';
  }

  @override
  String remove_from_this_deck(String hanzi) {
    return '이 덱에서 「$hanzi」을(를) 삭제하시겠습니까?';
  }

  @override
  String revenuecat_error(Object error) {
    return 'RevenueCat 오류: $error';
  }

  @override
  String get review_tomorrow => '내일 복습';

  @override
  String get roleplay => '롤플레잉';

  @override
  String saving_words_to(int wordCount, String deckName) {
    return '$wordCount개의 단어를 「$deckName」에 저장하는 중...';
  }

  @override
  String get search_radicals_eg_water => '부수 검색 (예: 水, 氵)';

  @override
  String get select_target_hsk_level => '목표 HSK 급수 선택';

  @override
  String get sentence => '문장';

  @override
  String get shadowing_studio_is_a_dedicated_space => '섀도잉 스튜디오는 원어민의 음성을 실시간으로 따라 하며 자연스러운 억양과 발음을 익히는 전용 훈련 공간입니다.';

  @override
  String simplify_failed(Object error) {
    return '평이화 실패: $error';
  }

  @override
  String get sinospark_premium => 'SinoSpark 프리미엄';

  @override
  String get speaking_pronunciation => '스피킹 및 발음';

  @override
  String get statistics => '학습 통계';

  @override
  String get table_of_contents => '목차 · 目录';

  @override
  String get the_ai_evaluates_your_speech_across => 'AI가 다음 3가지 요소를 종합 평가합니다:\n• 정확도: 각 음절을 올바르게 발음했는가\n• 완성도: 누락되거나 건너뛴 단어가 없는가\n• 유창성: 자연스러운 호흡과 올바른 성조로 발화했는가\n원어민 발음 모델과 비교하여 100점 만점으로 점수를 환산합니다.';

  @override
  String get this_cannot_be_undone => '이 작업은 되돌릴 수 없습니다.';

  @override
  String get title => '제목';

  @override
  String get to_be_reviewed => '복습 대기';

  @override
  String get traditional => '번체자';

  @override
  String translation_failed(Object error) {
    return '번역 실패: $error';
  }

  @override
  String get type_in => '입력...';

  @override
  String get type_your_message_in => '메시지를 입력하세요...';

  @override
  String get unable_to_open_this_video_please => '이 동영상을 열 수 없습니다. 잠시 후 다시 시도해 주세요.';

  @override
  String get view_your_learning_history_and_streaks => '학습 기록 및 연속 학습 일수 보기';

  @override
  String get what_is_shadowing_studio => '섀도잉 스튜디오란 무엇인가요?';

  @override
  String get words => '단어';

  @override
  String your_path_for_is_ready(String deckName) {
    return '「$deckName」을(를) 위한 맞춤 학습 경로가 준비되었습니다!';
  }

  @override
  String get you_said => '🗣️ 내 발음';

  @override
  String vocabularyBatch(Object index) {
    return '어휘 묶음 $index';
  }

  @override
  String get yourDailyDropIsHere => '오늘의 데일리 드롭이 도착했습니다! ✨';

  @override
  String get timeToReview => '복습할 시간입니다! 📚';

  @override
  String get neverMissAStroke => '한 획도 놓치지 마세요! 🖌️';

  @override
  String get yourTrialEndsTomorrow => '무료 체험이 내일 종료됩니다! ⏳';

  @override
  String get officialStandardVocabularyTiers => '공식 표준 어휘 등급';

  @override
  String get failedToLoadCollections => '컬렉션을 불러오지 못했습니다.';

  @override
  String unnamedKey(Object tag) {
    return '#$tag';
  }

  @override
  String error(Object error) {
    return '오류: $error';
  }

  @override
  String get aiSmartContext => 'AI 스마트 컨텍스트';

  @override
  String get aiSmartContextError => 'AI 스마트 컨텍스트 오류';

  @override
  String get downloadOfficialHskCollections => '공식 HSK 컬렉션 다운로드';

  @override
  String get unableToLoadThisSection => '이 섹션을 불러올 수 없습니다. 다시 시도해 주세요.';

  @override
  String get translationLanguage => '번역 언어';

  @override
  String get dailyDrops => '데일리 드롭';

  @override
  String get wordOfTheDayNews => '오늘의 단어 및 뉴스';

  @override
  String get reviewReminders => '복습 알림';

  @override
  String get flashcardsDueForReview => '복습할 플래시카드';

  @override
  String get dailyNewCards => '일일 새 카드';

  @override
  String get dailyReviewLimit => '일일 복습 제한';

  @override
  String get practiceMode => '연습 모드';

  @override
  String get liziqi => '리즈치(李子柒): 융화(비단꽃 공예)';

  @override
  String get theLifeOfGarlicTraditional => '마늘의 일생: 중국 전통 전원생활';

  @override
  String get graceMandarin50Phrases => 'Grace Mandarin: 필수 50개 문장';

  @override
  String get essentialChinesePhrasesForBeginners => '초보자를 위한 필수 중국어 회화';

  @override
  String get makingBambooFurniture => '전통 대나무 가구 제작';

  @override
  String get peppaPigChinese => '페파피그 중국어: 숨바꼭질 (躲猫猫)';

  @override
  String get muddyPuddlesBeginnerFriendly => '진흙 웅덩이 (초급 맞춤)';

  @override
  String get mandarinCorner300Verbs => 'Mandarin Corner: 필수 동사 300선';

  @override
  String get mostCommonChineseVerbs => '가장 자주 쓰이는 중국어 기본 동사';

  @override
  String get graceMandarinOrderFood => 'Grace Mandarin: 식당에서 음식 주문하기';

  @override
  String get howToOrderFoodIn => '중국 식당에서 음식 주문하는 법';

  @override
  String get silkFlowersTraditionalCraft => '비단꽃: 중국 전통 공예';

  @override
  String get mandarinCorner => 'Mandarin Corner: 중국어로 병원 진료받기';

  @override
  String get goingToTheDoctorReal => '병원 진료: 실제 상황 대화';

  @override
  String get hideAndSeekBeginnerFriendly => '숨바꼭질 (초급 맞춤)';

  @override
  String get linGdp6 => '샤오린 설명: 왜 GDP 성장률 목표가 6%일까?';

  @override
  String get why6GdpGrowthEasy => 'GDP 6% 성장의 이유: 알기 쉬운 중국 경제';

  @override
  String get bbcWorldNews => 'BBC 中文 (세계 뉴스)';

  @override
  String get currentEventsInSimplifiedChinese => '간체자로 읽는 최신 시사 뉴스';

  @override
  String get baidu => '바이두(Baidu)';

  @override
  String get youtubeDesk => 'YouTube 데스크';

  @override
  String get interactiveTranscriptsShadowing => '인터랙티브 스크립트 및 섀도잉';

  @override
  String get showsDramas => '드라마 및 방송';

  @override
  String get extractToDeck => '덱으로 단어 추출';

  @override
  String get autoSimplify => '자동 평이화';

  @override
  String get rewriteThisArticleToMatch => '내 HSK 급수에 맞춰 기사를 쉽게 변환';

  @override
  String failedToSaveExtractedWords(Object error) {
    return '추출된 단어를 저장하지 못했습니다: $error';
  }

  @override
  String addToDeck(Object count) {
    return '덱에 추가 ($count)';
  }

  @override
  String get dailyDiscoveryDrop => '데일리 탐구 드롭';

  @override
  String get smartSpacedRepetition => '스마트 간격 반복 (SRS)';

  @override
  String get trialProtectionAlert => '무료 체험 보호 알림';

  @override
  String get masteryLevel => '숙련도 레벨';

  @override
  String get targetObjective => '학습 목표';

  @override
  String get dailyPractice => '일일 연습';

  @override
  String get aiSpacedRepetition => 'AI 간격 반복 학습';

  @override
  String get iVeGrantedAccess => '접근 권한을 허용했습니다';

  @override
  String get scanner => '스캐너';

  @override
  String get interpreter => '통역기';

  @override
  String cards(Object count) {
    return '$count장의 카드';
  }

  @override
  String get nWaMendsTheHeavens => '여와보천 (여와가 하늘을 깁다)';

  @override
  String get terracottaArmy => '병마용';

  @override
  String get forbiddenCity => '자금성 (고궁)';

  @override
  String get aBlessingInDisguise => '새옹지마 (塞翁失馬)';

  @override
  String get drawingASnake => '화사첨족 (뱀에 발 그리기)';

  @override
  String get takingTheBulletTrain => '고속열차(까오티에) 탑승하기';

  @override
  String get visitingTheDoctor => '병원 진료받기';

  @override
  String get orderingDumplings => '물만두(교자) 주문하기';

  @override
  String get theTeaCeremony => '중국 전통 다도·궁푸차';

  @override
  String get chineseCalligraphy => '중국 서예';

  @override
  String get theGiantPanda => '자이언트 판다';

  @override
  String get simplifiedText => '쉬운 텍스트 (평이화)';

  @override
  String get novels96 => '소설 (96편)';

  @override
  String get microReads => '마이크로 리딩';

  @override
  String get poetry => '고전 시가';

  @override
  String get bookmarkRemoved => '书签已移除 · 북마크가 삭제되었습니다';

  @override
  String bookmarkAdded(Object chapter) {
    return '已添加书签 · 북마크 추가됨: 제$chapter장';
  }

  @override
  String get readingVocabulary => '독해 및 어휘';

  @override
  String vocabularyBatchUnitindex1(Object index) {
    return '어휘 묶음 $index';
  }

  @override
  String get yourDailyDropIsHere1 => '오늘의 데일리 드롭이 도착했습니다! ✨';

  @override
  String get timeToReview1 => '복습할 시간입니다! 📚';

  @override
  String get neverMissAStroke1 => '한 획도 놓치지 마세요! 🖌️';

  @override
  String get yourTrialEndsTomorrow1 => '무료 체험이 내일 종료됩니다! ⏳';

  @override
  String get hskCollections1 => 'HSK 컬렉션';

  @override
  String get officialStandardVocabularyTiers1 => '공식 표준 어휘 등급';

  @override
  String get failedToLoadCollections1 => '컬렉션을 불러오지 못했습니다.';

  @override
  String ui__transcription(Object transcription) {
    return '\"$transcription\"';
  }

  @override
  String playPinyinwithtone(Object pinyinWithTone) {
    return '$pinyinWithTone 재생';
  }

  @override
  String errorE(Object e) {
    return '오류: $e';
  }

  @override
  String lookalikepinyin(Object pinyin) {
    return '($pinyin)';
  }

  @override
  String get aiSmartContext1 => 'AI 스마트 컨텍스트';

  @override
  String get aiSmartContextError1 => 'AI 스마트 컨텍스트 오류';

  @override
  String errorErr(Object err, Object error) {
    return '오류: $error';
  }

  @override
  String get downloadOfficialHskCollections1 => '공식 HSK 컬렉션 다운로드';

  @override
  String get unableToLoadThisSectionPleaseTryAga => '이 섹션을 불러올 수 없습니다. 다시 시도해 주세요.';

  @override
  String get searchRadicalsEgWater => '부수 검색 (예: 水, 氵)';

  @override
  String ui__currentstrokeindex1totalstrokes(Object current, Object total) {
    return '$current/$total';
  }

  @override
  String get translationLanguage1 => '번역 언어';

  @override
  String get appLanguage1 => '앱 언어';

  @override
  String get dailyDrops1 => '데일리 드롭';

  @override
  String get wordOfTheDayNews1 => '오늘의 단어 및 뉴스';

  @override
  String get reviewReminders1 => '복습 알림';

  @override
  String get flashcardsDueForReview1 => '복습할 플래시카드';

  @override
  String get accuracyByMode1 => '모드별 정확도';

  @override
  String accuracytostringasfixed1(Object accuracy) {
    return '$accuracy%';
  }

  @override
  String get upcomingReviewsNext7Days => '예정된 복습 (향후 7일)';

  @override
  String get explaining => '해설:';

  @override
  String entryhanziEntrypinyin(Object hanzi, Object pinyin) {
    return '$hanzi [$pinyin]';
  }

  @override
  String get dailyNewCards1 => '일일 새 카드';

  @override
  String get dailyReviewLimit1 => '일일 복습 제한';

  @override
  String get listeningMode1 => '듣기 모드';

  @override
  String get readingMode1 => '읽기 모드';

  @override
  String get recallMode1 => '회상 모드';

  @override
  String get speakingMode1 => '말하기 모드';

  @override
  String get practiceMode1 => '연습 모드';

  @override
  String acc(Object acc) {
    return '$acc%';
  }

  @override
  String get partner1 => '대화 상대';

  @override
  String get partnerSpeaking1 => '상대방이 말하는 중…';

  @override
  String get theLifeOfGarlicTraditionalChineseLi => '마늘의 일생: 중국 전통 전원생활';

  @override
  String get graceMandarin50Phrases1 => 'Grace Mandarin: 필수 50개 문장';

  @override
  String get essentialChinesePhrasesForBeginners1 => '초보자를 위한 필수 중국어 문구';

  @override
  String get makingBambooFurniture1 => '전통 대나무 가구 제작';

  @override
  String get muddyPuddlesBeginnerFriendly1 => '진흙 웅덩이 (초급 맞춤)';

  @override
  String get mandarinCorner300Verbs1 => 'Mandarin Corner: 필수 동사 300선';

  @override
  String get mostCommonChineseVerbs1 => '가장 흔히 쓰이는 중국어 기본 동사';

  @override
  String get graceMandarinOrderFood1 => 'Grace Mandarin: 음식 주문하기';

  @override
  String get howToOrderFoodInAChineseRestaurant => '중국 식당에서 음식 주문하는 방법';

  @override
  String get silkFlowersTraditionalCraft1 => '비단꽃: 중국 전통 공예';

  @override
  String get goingToTheDoctorRealLifeConversatio => '병원 진료: 실제 상황 대화';

  @override
  String get hideAndSeekBeginnerFriendly1 => '숨바꼭질 (초급 맞춤)';

  @override
  String get lingdp6 => '샤오린 설명: 왜 GDP 성장률 목표가 6%일까?';

  @override
  String get why6GdpGrowthEasyChineseEconomics => '왜 GDP 6% 성장인가: 알기 쉬운 중국 경제';

  @override
  String get currentEventsInSimplifiedChinese1 => '간체자로 읽는 최신 시사 뉴스';

  @override
  String get baidu1 => '바이두(Baidu)';

  @override
  String get youtubeDesk1 => 'YOUTUBE DESK';

  @override
  String get interactiveTranscriptsShadowing1 => '인터랙티브 스크립트 및 섀도잉';

  @override
  String get showsDramas1 => '드라마 및 방송';

  @override
  String error_error(Object error) {
    return '오류: $error';
  }

  @override
  String get extractToDeck1 => '덱으로 단어 추출';

  @override
  String get autosimplify => '자동 평이화';

  @override
  String get rewriteThisArticleToMatchYourHskLev => '내 HSK 급수에 맞춰 기사를 쉽게 변환';

  @override
  String get addToDeck1 => '덱에 추가';

  @override
  String playbackratex(Object playbackRate) {
    return '$playbackRate배속';
  }

  @override
  String speedx(Object speed) {
    return '$speed배속';
  }

  @override
  String get dailyDiscoveryDrop1 => '데일리 탐구 드롭';

  @override
  String get smartSpacedRepetition1 => '스마트 간격 반복 (SRS)';

  @override
  String get trialProtectionAlert1 => '무료 체험 보호 알림';

  @override
  String get masteryLevel1 => '숙련도 레벨';

  @override
  String get targetObjective1 => '학습 목표';

  @override
  String get dailyPractice1 => '일일 연습';

  @override
  String get aiSpacedRepetition1 => 'AI 간격 반복 학습';

  @override
  String get iveGrantedAccess => '접근 권한을 허용했습니다';

  @override
  String addToDeck_selectedwordindiceslength(Object count) {
    return '덱에 추가 ($count)';
  }

  @override
  String get scanner1 => '스캐너';

  @override
  String get interpreter1 => '통역기';

  @override
  String entryvalueCards(Object count) {
    return '$count장의 카드';
  }

  @override
  String score_score_questionslength(Object score, Object total) {
    return '점수: $score / $total';
  }

  @override
  String get theMonkeyKing1 => '손오공';

  @override
  String get huaMulan1 => '화목란 (뮬란)';

  @override
  String get nwaMendsTheHeavens => '여와보천';

  @override
  String get confucius => '공자';

  @override
  String get theGreatWall1 => '만리장성';

  @override
  String get terracottaArmy1 => '병마용';

  @override
  String get forbiddenCity1 => '자금성';

  @override
  String get aBlessingInDisguise1 => '새옹지마';

  @override
  String get drawingASnake1 => '화사첨족 (뱀에 발 그리기)';

  @override
  String get takingTheBulletTrain1 => '고속열차 타기';

  @override
  String get visitingTheDoctor1 => '병원 진료받기';

  @override
  String get orderingDumplings1 => '물만두 주문하기';

  @override
  String get theTeaCeremony1 => '중국 전통 다도';

  @override
  String get chineseCalligraphy1 => '중국 서예';

  @override
  String get theGiantPanda1 => '자이언트 판다';

  @override
  String get simplifiedText1 => '쉬운 텍스트';

  @override
  String get novels961 => '소설 (96편)';

  @override
  String get microreads => '마이크로 리딩';

  @override
  String get poetry1 => '고전 시가';

  @override
  String get readingVocabulary1 => '독해 및 어휘';

  @override
  String get defaultfirebaseoptionsHaveNotBeenCo => 'DefaultFirebaseOptions가 Linux용으로 구성되지 않았습니다.';

  @override
  String get defaultfirebaseoptionsAreNotSupport => '이 플랫폼에서는 DefaultFirebaseOptions가 지원되지 않습니다.';

  @override
  String get hanziMaster1 => 'SinoSpark';

  @override
  String get strokesCannotBeEmpty => '획수가 비어 있을 수 없습니다.';

  @override
  String get wrongStartPoint => '시작 지점이 잘못되었습니다.';

  @override
  String get rightShapeButWrongPlace => '모양은 맞지만 위치가 잘못되었습니다!';

  @override
  String get goodFollowTheFlow => '잘하셨어요! 붓의 흐름을 따라 써보세요.';

  @override
  String get aBitShaky => '선이 조금 흔들렸어요!';

  @override
  String get aBitHesitant => '약간 망설임이 느껴집니다...';

  @override
  String get shapeIsOff => '획의 형태가 어긋났습니다.';

  @override
  String get arabic => '아랍어';

  @override
  String get german => '독일어';

  @override
  String get spanish => '스페인어';

  @override
  String get french => '프랑스어';

  @override
  String get hindi => '힌디어';

  @override
  String get indonesian => '인도네시아어';

  @override
  String get italian => '이탈리아어';

  @override
  String get japanese => '일본어';

  @override
  String get korean => '한국어';

  @override
  String get portuguese => '포르투갈어';

  @override
  String get russian => '러시아어';

  @override
  String get vietnamese => '베트남어';

  @override
  String get microphonePermissionDenied => '마이크 권한이 거부되었습니다';

  @override
  String get offset => '오프셋';

  @override
  String get audioserviceHasBeenDisposed => 'AudioService가 해제되었습니다';

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
  String get kore => 'Kore (여성, 따뜻한 목소리)';

  @override
  String get xmicrosoftoutputformatAudio24khz48k => 'audio-24khz-48kbitrate-mono-mp3';

  @override
  String get useragentHanzimasterapp => 'HanziMasterApp';

  @override
  String get anchorWord => '기준 단어';

  @override
  String get creativeThematicTitle => '창의적 테마 제목';

  @override
  String get briefPedagogicalOrSemanticRationale => '간략한 교육적/의미론적 근거';

  @override
  String get theSingleMostCentralCharacterFromTh => '목록에서 가장 핵심적인 대표 한자';

  @override
  String get aBalancedSetOfCharactersFromYourLib => '라이브러리에서 균형 있게 선별된 한자 세트';

  @override
  String get yourNaturalConversationalReplyInChi => '중국어(간체)로 된 자연스러운 대화 답변';

  @override
  String get theEnglishTranslationOfYourReply => '답변의 한국어 번역';

  @override
  String get thePinyinWithToneMarksForYourReply => '답변의 성조 표기 병음';

  @override
  String get aSuggestedResponseTheUserCouldSayBa => '사용자가 대답할 수 있는 추천 표현';

  @override
  String get pinyinForTheSuggestion => '추천 표현의 병음';

  @override
  String get englishTranslationForTheSuggestion => '추천 표현의 한국어 번역';

  @override
  String get scholarsCritique => '학자의 평가 및 피드백';

  @override
  String get theEchoHallRemainsSilentTryYourBrea => '에코 홀이 고요합니다. 숨을 가다듬고 다시 시도해 보세요.';

  @override
  String get xtitleHanziMaster => 'SinoSpark';

  @override
  String get noneYet => '아직 없습니다.';

  @override
  String get exactSentence => '해당 문장:';

  @override
  String get englishTranslation => '한국어 번역';

  @override
  String get previouslyGeneratedPhrases => '이전에 생성된 문장';

  @override
  String get iLikeDrinkingAppleJuice => '저는 사과 주스를 마시는 것을 좋아합니다.';

  @override
  String get theEnglishMeaningHere => '여기에 한국어 뜻 입력...';

  @override
  String get failedToFetchDefinition => '단어 뜻을 가져오지 못했습니다.';

  @override
  String get failedToLoadExplanation => '해설을 불러오지 못했습니다.';

  @override
  String get failedToLoadComparison => '비교 데이터를 불러오지 못했습니다.';

  @override
  String get emptyResponseFromOpenrouter => 'OpenRouter로부터 빈 응답이 반환되었습니다';

  @override
  String get emptyResponseFromVisionModel => 'Vision 모델로부터 빈 응답이 반환되었습니다';

  @override
  String get standard => '표준';

  @override
  String get theFullSentenceInChinese => '중국어 전체 문장...';

  @override
  String get theWordOrCharacterInChinese => '중국어 단어 또는 한자';

  @override
  String get thePinyinForThisSpecificWord => '해당 단어의 병음';

  @override
  String get emptyResponseFromDeepseekApi => 'DeepSeek API로부터 빈 응답이 반환되었습니다';

  @override
  String get criticalPutTheEnglishTranslationInT => '중요: 한국어 번역을 다음 항목에 입력하세요';

  @override
  String get englishTranslationOfTheEntireSenten => '전체 문장의 한국어 번역';

  @override
  String get hanziWord => '한자 단어';

  @override
  String get theFullSimplifiedSentenceInChinese => '중국어 간체자 전체 문장...';

  @override
  String get lyingFlatACulturalMovement => '탕핑(躺平): 사회 문화적 현상...';

  @override
  String get theUserYouAreSpeakingToIsNamed => '대화 중인 사용자의 이름:';

  @override
  String get importantRuleDoNotAddressTheUserByA => '중요 규칙: 사용자를 임의의 이름으로 부르지 마세요. 다음과 같은 플레이스홀더 이름은 절대 사용 금지입니다:';

  @override
  String get youAreAConciseChineseCalligraphyAnd => '당신은 플래시카드 앱 내에서 중국어 서예와 자원(字源)을 명쾌하게 가르쳐 주는 튜터입니다.';

  @override
  String get theStudentIsStudyingTheCharacter => '학생이 학습 중인 한자:';

  @override
  String get neverWriteIntroductionsSignoffsOrFi => '서론, 맺음말 또는 불필요한 군더더기 표현을 절대 작성하지 마세요.';

  @override
  String get beDirectAndInformative => '간결하고 유익하게 설명하세요.';

  @override
  String get criticalRuleYouMustRespondEntirelyI => '중요 규칙: 지정된 ISO 639-1 언어 코드로만 답변해야 합니다.';

  @override
  String get youAreAConciseChineseGrammarTutorIn => '당신은 모바일 앱 내에서 중국어 문법을 핵심만 명쾌하게 가르쳐 주는 튜터입니다.';

  @override
  String get theStudentIsConfusedAboutTheWord => '학생이 헷갈려하는 단어:';

  @override
  String get neverWriteIntroductionsSignoffsOrFi1 => '서론, 맺음말 또는 불필요한 미사여구를 절대 작성하지 마세요.';

  @override
  String get azureSpeechApiKeysAreMissing => 'Azure Speech API 키가 누락되었습니다.';

  @override
  String get success => '성공';

  @override
  String get granularity => '상세도 (세분성)';

  @override
  String get phoneme1 => '음소';

  @override
  String get dimension => '평가 영역';

  @override
  String get comprehensive => '종합 평가';

  @override
  String get weCouldntHearYouClearlyPleaseTryAga => '음성이 선명하게 들리지 않았습니다. 다시 말씀해 주세요.';

  @override
  String get noNbestResultFound => '인식 결과를 찾을 수 없습니다.';

  @override
  String get words1 => '단어';

  @override
  String get word => '단어';

  @override
  String get phonemes => '음소';

  @override
  String get syllables => '음절';

  @override
  String get syllable => '음절';

  @override
  String get omission => '누락 (생략)';

  @override
  String get insertion => '불필요한 발음 (삽입)';

  @override
  String get youMissedThisWord => '이 단어를 건너뛰었습니다.';

  @override
  String get extraWordAddedHere => '여기에 불필요한 단어가 추가되었습니다.';

  @override
  String get mispronunciation => '발음 오류';

  @override
  String get pronunciationWasInaccurate => '발음이 정확하지 않았습니다.';

  @override
  String get goodEffortKeepPracticing => '좋은 시도예요! 계속 연습해 보세요.';

  @override
  String get perfectPronunciationSoundsLikeANati => '완벽한 발음입니다! 원어민 같아요.';

  @override
  String get greatJobAFewMinorToneInaccuracies => '아주 잘하셨어요! 성조에 아주 미세한 오차가 있을 뿐입니다.';

  @override
  String get notBadButYourTonesNeedSomeWork => '나쁘지 않지만, 성조를 조금 더 다듬어 보세요.';

  @override
  String get keepPracticingListenToTheNativeAudi => '원어민 음성을 듣고 반복해서 연습해 보세요!';

  @override
  String get lexical => '어휘';

  @override
  String get chineseHanziHere => '중국어 한자 입력';

  @override
  String get aShortSummaryInEnglish => '한국어 요약';

  @override
  String get noCoherentChineseTextFoundInTheScan => '스캔 이미지에서 유효한 중국어 텍스트를 찾을 수 없습니다.';

  @override
  String get theFullEnglishTranslationOfTheScann => '스캔된 텍스트의 전체 한국어 번역... 또는 \'유효한 중국어 텍스트를 찾을 수 없습니다.\'';

  @override
  String get aShort24WordTitleForThisScanEgResta => '이 스캔에 대한 2~4단어의 짧은 제목 (예: \'식당 메뉴판\', \'도로 표지판\')';

  @override
  String get china => '중국';

  @override
  String get noTranslationAvailable => '번역을 사용할 수 없습니다.';

  @override
  String get scanResults => '스캔 결과';

  @override
  String get whenWasItWrittenAndWhatWasHappening => '언제 쓰였으며, 당시 중국에서는 어떤 역사적 사건이 있었나요?';

  @override
  String get whyIsThisPieceFamousWhatPhilosophic => '이 작품이 유명한 이유는 무엇이며, 어떤 철학적·문화적 주제를 다루나요?';

  @override
  String get aBriefBioOfTheAuthor => '작가 약력';

  @override
  String get informationUnavailable => '정보를 확인할 수 없습니다.';

  @override
  String get noSummaryAvailable => '요약 정보가 없습니다.';

  @override
  String get hanziAiPro => 'SinoSpark AI Pro';

  @override
  String get trialNormalIntro => '체험, 일반, 안내';

  @override
  String get dailyDrop => '데일리 드롭';

  @override
  String get dailyNotificationsForWordOfTheDayAn => '오늘의 단어 및 뉴스 알림';

  @override
  String get aNewWordAndStoryOfTheDayAreWaitingF => '오늘의 새로운 단어와 스토리가 준비되었습니다!';

  @override
  String get spacedRepetition => '간격 반복 학습 (SRS)';

  @override
  String get remindersForFlashcardsDueForReview => '복습할 플래시카드 알림';

  @override
  String get engagementReminders => '학습 참여 알림';

  @override
  String get trialReminders => '체험 기간 알림';

  @override
  String get notificationsForYourTrialStatus => '체험 상태 관련 알림';

  @override
  String get comeReviewYourHanziAndTryALiveCallB => '무료 이용 기간이 끝나기 전에 한자를 복습하고 라이브 통화를 체험해 보세요!';

  @override
  String get scholarsEye => '학자의 안목 (상세 분석)';

  @override
  String get clMeasureWord => '양사 (CL):';

  @override
  String get surnameShi => '성씨 사(史)';

  @override
  String get chineseFamilyNameShi => '중국 성씨 (Shi)';

  @override
  String get neutralToneLight => '경성 (가볍고 짧게)';

  @override
  String get keepYourPitchHighAndSteadyLikeSingi => '노래하듯 높은 음을 평평하고 일정하게 유지하세요.';

  @override
  String get startInTheMiddleAndSlideYourPitchUp => '중간 음높이에서 시작해 \'뭐?\'라고 되묻듯 위로 올리세요.';

  @override
  String get dipYourVoiceDownLowThenRiseGentlyBa => '목소리를 낮게 내렸다가 부드럽게 끌어올리세요.';

  @override
  String get dropYourPitchSharplyAndDecisivelyLi => '단호하게 \'안 돼!\'라고 외치듯 높음에서 아래로 날카롭게 내리꽂으세요.';

  @override
  String get pronounceSoftlyBrieflyAndWithoutEmp => '힘을 빼고 짧고 가볍게 얹듯이 발음하세요.';

  @override
  String get spotOnPitchWasHighFlatAndSteady => '완벽합니다! 음높이가 높고 평평하게 잘 유지되었습니다.';

  @override
  String get spotOnUpwardPitchRiseWasClear => '완벽합니다! 아래에서 위로 치고 올라가는 소리가 명확했습니다.';

  @override
  String get spotOnLowDippingCurveWasAccurate => '완벽합니다! 저음으로 꺾였다가 올라가는 굴곡이 정확했습니다.';

  @override
  String get spotOnSharpFallingDropWasDecisive => '완벽합니다! 단호하게 떨어지는 하강음이 명확했습니다.';

  @override
  String get spotOnToneWasPronouncedAccurately => '완벽합니다! 성조가 정확하게 발음되었습니다.';

  @override
  String get iAgreeToTheTermsOfServiceAndPrivacy => '이용약관 및 개인정보 처리방침에 동의합니다.';

  @override
  String get sendMeOccasionalUpdatesTipsAndOffer => '유용한 학습 팁과 프로모션 혜택을 받아봅니다.';

  @override
  String get signInToSyncYourProgress => '학습 진도를 동기화하려면 로그인하세요.';

  @override
  String get createAnAccountToSaveYourStats => '학습 통계를 안전하게 저장하려면 계정을 만드세요.';

  @override
  String get smartSpiral => '스마트 스파이럴';

  @override
  String get origin => '기원';

  @override
  String get elements => '자연 원소';

  @override
  String get humanity => '인간과 신체';

  @override
  String get village => '생활과 부락';

  @override
  String get journey => '여정과 이동';

  @override
  String get city => '도시와 문명';

  @override
  String get originTheSimplestShapesTheBeginning => '가장 단순한 형태. 모든 글자의 시작.';

  @override
  String get elementsSunMoonWaterAndFireTheNatur => '해, 달, 물, 불. 대자연의 세계.';

  @override
  String get humanityTheBodyTheHeartAndTheFamily => '신체, 마음, 그리고 가족.';

  @override
  String get villageFieldsRoofsAndToolsTheFounda => '논밭, 지붕, 그리고 도구. 사회의 토대.';

  @override
  String get journeyMovementSpeechAndSustenance => '움직임, 언어, 그리고 식생활.';

  @override
  String get cityCommerceClothingAndComplexArtif => '상업, 의복, 정교한 문명의 산물.';

  @override
  String get equilibriumAlgorithm => '균형 학습 알고리즘';

  @override
  String get misc => '기타';

  @override
  String get cityOrOriginAs => '\'도시\' 또는 \'기원\'으로';

  @override
  String get miscToOrigin => '\'기타\'에서 \'기원\'으로';

  @override
  String get constellation => '별자리';

  @override
  String get whichOneIsWater => '\'물\'을 뜻하는 글자는 어느 것인가요?';

  @override
  String get whatIsThePinyin => '올바른 병음은 무엇인가요?';

  @override
  String get nature => '자연';

  @override
  String get whatEssenceDoes => '어떤 부수(본질)가 필요한가요:';

  @override
  String get allTiers => '전체 등급';

  @override
  String get active => '활성';

  @override
  String get theScrollOfOrigin1 => '기원의 두루마리';

  @override
  String galaxyOf1(Object name) {
    return '~의 은하: $name';
  }

  @override
  String get also => '또한';

  @override
  String get work => '일·노동';

  @override
  String get cloud => '구름';

  @override
  String get youArchaic => '그대 (고어)';

  @override
  String get suddenly => '갑자기';

  @override
  String get owner => '주인';

  @override
  String get door => '문·출입문';

  @override
  String get occupy => '차지하다';

  @override
  String get nail => '못';

  @override
  String get and => '그리고';

  @override
  String get buddhistNun => '비구니';

  @override
  String get anxious => '초조한';

  @override
  String get sprout => '새싹';

  @override
  String get exchange => '교환';

  @override
  String get sheep => '양';

  @override
  String get strange => '기이한';

  @override
  String get opposite => '반대';

  @override
  String get shorttailedBird => '짧은 꼬리 새 (隹)';

  @override
  String get shoot => '쏘다·발사';

  @override
  String get small => '작은';

  @override
  String get gather => '모으다';

  @override
  String get order => '순서';

  @override
  String get flat => '평평한';

  @override
  String get thePersonWho => '~하는 사람 (者)';

  @override
  String get nobleman => '귀인·군자';

  @override
  String get cause => '원인';

  @override
  String get pig => '돼지';

  @override
  String get bright => '밝은';

  @override
  String get slowly => '천천히';

  @override
  String get give => '주다·수여';

  @override
  String get arrow => '화살';

  @override
  String get dry => '마른·건조';

  @override
  String get obstacle => '장애물';

  @override
  String get beg => '청하다·간청';

  @override
  String get window => '창문';

  @override
  String get fear => '두려움';

  @override
  String get drum => '북';

  @override
  String get why => '어찌·이유';

  @override
  String get talent => '재능';

  @override
  String get follow => '따르다';

  @override
  String get desert => '사막';

  @override
  String get component => '구성 요소 (부수)';

  @override
  String divingInto1(Object topic) {
    return '깊이 알아보기: $topic';
  }

  @override
  String get unitIntro1 => '단원 소개';

  @override
  String get theBlueprint => '설계도 (청사진)';

  @override
  String get theOrigin => '기원';

  @override
  String get theGalaxy => '은하';

  @override
  String get theScholarListens => '학자가 귀를 기울입니다...';

  @override
  String get consultingTheScrolls => '고문헌을 살펴보는 중...';

  @override
  String get traceWithTheGuide => '가이드에 따라 쓰기';

  @override
  String get traceTheGhost => '흐릿한 가이드선 따라 쓰기';

  @override
  String get connectTheDots => '점 잇기';

  @override
  String get drawFromMemory => '기억해서 쓰기';

  @override
  String get assistant => '어시스턴트';

  @override
  String get puck => 'Puck (남성, 스포티한 목소리)';

  @override
  String get helloWelcomeWhatWouldYouLikeToOrder => '어서 오세요! 무엇을 주문하시겠어요?';

  @override
  String get ni3Hao3Huan1ying2Guang1lin2Qing3wen => 'Nǐ hǎo! Huānyíng guānglín. Qǐngwèn nǐ yào diǎn shénme?';

  @override
  String get waiterLi => '종업원 리(李)';

  @override
  String get askForTheMenu => '메뉴판 요청하기';

  @override
  String get orderOneDishAndOneDrink => '요리 1개와 음료 1개 주문하기';

  @override
  String get askForTheBill => '계산서 요청하기';

  @override
  String get fenrir => 'Fenrir (남성, 활기찬 목소리)';

  @override
  String get ni3Qu4Na3rAJi1chang3MaTing3Yuan3De => 'Nǐ qù nǎr a? Jīchǎng ma? Tǐng yuǎn de!';

  @override
  String get driverWang => '기사 왕(王) 씨';

  @override
  String get tellTheDriverYouAreGoingToTheAirpor => '기사님께 공항으로 간다고 말하기';

  @override
  String get askHowLongTheTripWillTake => '도착까지 시간이 얼마나 걸리는지 묻기';

  @override
  String get complainAboutTheTraffic => '교통 체증에 대해 이야기하기';

  @override
  String get charon => 'Charon (남성, 뉴스 앵커 스타일)';

  @override
  String get thisClothingQualityIsEspeciallyGood => '이 옷은 원단이 아주 좋은데, 200위안밖에 안 해요.';

  @override
  String get zhe4Jian4Yi1fuZhi4liang4Te4bie2Hao3 => 'Zhè jiàn yīfu zhìliàng tèbié hǎo, zhǐyào liǎng bǎi kuài.';

  @override
  String get auntieChen => '첸(陳) 이모';

  @override
  String get askHowMuchTheSilkShirtCosts => '실크 셔츠 가격 묻기';

  @override
  String get sayItIsTooExpensive => '너무 비싸다고 말하기';

  @override
  String get bargainThePriceDownTo100Rmb => '100위안으로 가격 흥정하기';

  @override
  String get ni3Na3li3Bu4Shu1fuFa1shao1LeMa => 'Nǐ nǎlǐ bù shūfu? Fāshāo le ma?';

  @override
  String get drZhang => '장(張) 의사';

  @override
  String get explainYouHaveHadAHeadacheForTwoDay => '이틀 전부터 두통이 있다고 설명하기';

  @override
  String get sayYouHaveASlightFever => '미열이 있다고 말하기';

  @override
  String get askIfYouNeedToTakeMedicine => '약을 복용해야 하는지 묻기';

  @override
  String get aoede => 'Aoede (여성, 밝은 목소리)';

  @override
  String get heyLongTimeNoSeeHowHaveYouBeenLatel => '오랜만이야! 그동안 어떻게 지냈어?';

  @override
  String get ni3Hao3Hao3jiu3Bu4jian4Ni3Zui4jin4Z => 'Nǐ hǎo! Hǎojiǔ bùjiàn, nǐ zuìjìn zěnmeyàng?';

  @override
  String get pleaseIntroduceYourselfWhyDoYouWant => '간단한 자기소개와 함께 저희 회사에 지원한 동기를 말씀해 주세요.';

  @override
  String get qing3Xian1Zi4wo3Jie4shao4Yi1xia4Ni3 => 'Qǐng xiān zìwǒ jièshào yíxià. Nǐ wèishénme xiǎng lái wǒmen gōngsī gōngzuò?';

  @override
  String get managerLiu => '류(劉) 인사담당자';

  @override
  String get introduceYourProfessionalBackground => '자신의 전문 경력을 간략히 소개하기';

  @override
  String get explainWhyYouWantToWorkAtThisCompan => '지원 동기를 설명하기';

  @override
  String get askAPoliteQuestionAboutTheCompanyCu => '기업 문화에 대해 정중히 질문하기';

  @override
  String get microphoneAccessIsRequiredPleaseEna => '마이크 접근 권한이 필요합니다. 기기 설정에서 활성화해 주세요.';

  @override
  String get couldNotStartMicrophonePleaseCheckY => '마이크를 시작할 수 없습니다. 오디오 설정을 확인하고 다시 시도해 주세요.';

  @override
  String get weDidntQuiteCatchThatPleaseHoldTheM => '음성을 잘 알아듣지 못했습니다. 마이크를 누른 상태에서 다시 말씀해 주세요!';

  @override
  String get recordingWasTooShortHoldTheMicAndSp => '녹음 시간이 너무 짧습니다. 마이크를 길게 누르고 또렷하게 말씀해 주세요.';

  @override
  String get audioBufferWasEmptyPleaseCheckYourM => '음성 버퍼가 비어 있습니다. 마이크 상태를 확인하고 다시 시도해 주세요.';

  @override
  String get audioFileIsSilentPleaseSpeakIntoThe => '녹음된 음성이 없습니다. 마이크에 대고 말씀해 주세요.';

  @override
  String get weCouldntUnderstandYourPronunciatio => '발음을 인식하지 못했습니다. 더 또렷하게 발음하고 다시 시도해 주세요.';

  @override
  String get theServerIsTakingTooLongToRespondPl => '서버 응답이 지연되고 있습니다. 잠시 후 다시 시도해 주세요.';

  @override
  String get noInternetConnectionPleaseCheckYour => '인터넷 연결이 끊겼습니다. 네트워크 환경을 확인하고 다시 시도해 주세요.';

  @override
  String get audioProcessingFailedPleaseTryAgain => '오디오 처리에 실패했습니다. 다시 시도해 주세요.';

  @override
  String get permission => '권한';

  @override
  String get couldNotProcessYourRecordingPleaseT => '녹음을 처리하지 못했습니다. 다시 시도해 주세요.';

  @override
  String get user => '사용자';

  @override
  String get scholar => '학자';

  @override
  String get ourAiTutorsAreCurrentlyOfflinePleas => 'AI 튜터가 현재 오프라인 상태입니다. 잠시 후 다시 시도해 주세요.';

  @override
  String get hideTranslation => '번역 숨기기';

  @override
  String get azureAssessment => 'Azure 발음 평가 중...';

  @override
  String get microphonePermissionRequired => '마이크 권한 필요';

  @override
  String get connectedSpeakNow => '연결되었습니다! 지금 말씀하세요.';

  @override
  String get initializationErrorCheckPermissions => '초기화 오류. 권한을 확인하세요.';

  @override
  String get microphoneErrorTapToRetry => '마이크 오류. 탭하여 다시 시도하세요.';

  @override
  String get theTutorReturnedAnEmptyResponse => '튜터로부터 응답이 없습니다.';

  @override
  String get connectionInterruptedPleaseSpeakAga => '연결이 끊어졌습니다. 다시 말씀해 주세요.';

  @override
  String get callPausedReviewingTones => '통화 일시 중지 (성조 확인 중)';

  @override
  String get pausedTakeABreak => '일시 중지됨 - 잠시 휴식을 취하세요';

  @override
  String get goodStartPracticing => '좋은 출발이에요!';

  @override
  String get studentCoach => '학생 / 코치';

  @override
  String get keepYour1stToneHighAndSteadyOn => '1성은 높고 평평하게 유지하세요:';

  @override
  String get noScenariosFound => '시나리오를 찾을 수 없습니다.';

  @override
  String get designYourOwnAiRoleplayExperience => '나만의 맞춤형 AI 롤플레잉 만들기';

  @override
  String get generateFromDeck => '덱에서 생성';

  @override
  String get practiceFlashcardVocabularyInALiveD => '실전 대화로 플래시카드 단어 연습';

  @override
  String get tapToRoleplay => '탭하여 롤플레잉 시작';

  @override
  String get hsk2 => 'HSK 2급';

  @override
  String get hsk3 => 'HSK 3급';

  @override
  String get hsk4 => 'HSK 4급';

  @override
  String get hsk5 => 'HSK 5급';

  @override
  String get hsk6 => 'HSK 6급';

  @override
  String get dinnerWithDad => '아버지와의 저녁 식사';

  @override
  String get orderingAtAChengduTeahouse => '청두 전통 찻집에서 차 주문하기';

  @override
  String get buyingTeaAtTheMarket => '시장에서 찻잎 구매하기';

  @override
  String get meetingAnOldClassmate => '동창과의 반가운 재회';

  @override
  String get readyToPractice => '연습할 준비가 되셨나요?';

  @override
  String get letsPracticeChinese => '중국어를 연습해 볼까요?';

  @override
  String get areYouReady => '준비되셨나요?';

  @override
  String get discussWhatToHaveForDinner => '저녁 메뉴 정하기';

  @override
  String get suggestWatchingAMovieAfterwards => '식사 후 영화 관람 제안하기';

  @override
  String get askIfTheyWouldLikeTea => '차를 마실지 물어보기';

  @override
  String get helloVeryNiceToMeetYou => '안녕하세요! 만나서 반갑습니다.';

  @override
  String get deckPractice => '덱 실전 연습';

  @override
  String get practiceVocabularyWithAnAiPartner => 'AI 파트너와 함께 어휘를 연습하세요.';

  @override
  String get designCustomAiRoleplayConversation => '맞춤형 AI 롤플레잉 및 대화 설계';

  @override
  String get random => '랜덤';

  @override
  String get scenarioTopic => '시나리오 주제';

  @override
  String get contextSettingOptional => '상황 및 배경 설정 (선택 사항)';

  @override
  String get aiCharacterPersonaOptional => 'AI 캐릭터 페르소나 (선택 사항)';

  @override
  String get aQuietBambooCourtyardTeahouseInChen => '은은한 고쟁 선율이 흐르는 청두의 고즈넉한 대나무 찻집.';

  @override
  String get aBustlingSmokyNightMarketFilledWith => '양꼬치와 만두, 길거리 음식 노점으로 활기와 연기가 가득한 야시장.';

  @override
  String get aLivelyHotpotRestaurantInChongqingW => '새빨간 육수가 끓어오르고 알싸한 고추 향이 진동하는 충칭의 활기찬 훠궈 전문점.';

  @override
  String get aBustlingTraditionalCantoneseTeahou => '대나무 찜통에서 김이 피어오르는 광저우의 활기찬 전통 딤섬 찻집.';

  @override
  String get aChicMinimalistCafeInTheFrenchConce => '비 내리는 일요일 오후, 프랑스 조계지의 세련되고 미니멀한 카페.';

  @override
  String get aWarmNorthernHomeKitchenDuringWinte => '겨울철 밀가루 가루 날리는 식탁과 김 나는 만둣국이 있는 따뜻한 북방 가정집 주방.';

  @override
  String get anOpenairNightStreetFoodAlleyWithSi => '지글거리는 양꼬치와 구운 가지, 시원한 맥주가 있는 야외 야시장 골목.';

  @override
  String get aSnowyStreetCornerOutsideTheLamaTem => '눈 덮인 라마사(옹화궁) 문 앞, 얼음 위에 놓인 윤기 나는 빨간 탕후루 꼬치.';

  @override
  String get craftBeerBreweryInQingdao => '칭다오 수제 맥주 브루어리';

  @override
  String get aLivelyCoastalTaproomWithWoodenBarr => '오크통과 시원한 바닷바람, 신선한 밀맥주가 있는 해변가 펍.';

  @override
  String get sichuanCookingMasterclass => '정통 사천요리 마스터클래스';

  @override
  String get aVibrantOpenKitchenWithWoksBlazingC => '웍에서 불길이 솟구치고 고추기름이 끓어오르며 신선한 화자오 향이 가득한 활기찬 오픈 키친.';

  @override
  String get highspeedRailSeatMixup => '고속열차 좌석 혼동';

  @override
  String get greatWallSunriseTrekInMutianyu => '무톈위 만리장성 일출 트레킹';

  @override
  String get theAncientStoneRampartsOfTheGreatWa => '안개 낀 푸른 산세에 둘러싸여 새벽빛을 머금은 만리장성의 고대 석조 성벽.';

  @override
  String get bambooRaftDriftOnGuilinLiRiver => '구이린 리강 대나무 뗏목 유람';

  @override
  String get glidingAlongEmeraldKarstWatersBetwe => '양숴 인근, 물안개 자욱한 석회암 기암괴석 사이로 에메랄드빛 카르스트 수면을 미끄러지듯 나아가며.';

  @override
  String get silkRoadCamelTrekInDunhuang => '둔황 실크로드 낙타 트레킹';

  @override
  String get theRollingGoldenSandDunesOfMingshaM => '월아천 오아시스 곁에 끝없이 펼쳐진 명사산의 굽이치는 황금빛 사구.';

  @override
  String get bookingACourtyardHomestayInDali => '다리 전통 안뜰 사합원 숙소 예약하기';

  @override
  String get aSereneBaistyleBoutiqueCourtyardHot => '윈난성 얼하이호를 내려다보는 고즈넉한 바이족 양식의 부티크 안뜰 호텔.';

  @override
  String get potalaPalacePilgrimageInLhasa => '라싸 포탈라궁 순례';

  @override
  String get theMajesticSundrenchedStoneStepsOut => '따스한 햇살이 내리쬐는 포탈라궁 앞 웅장한 돌계단과 돌아가는 마니차.';

  @override
  String get aSubzeroWonderlandOfIlluminatedCrys => '화려한 조명으로 수놓인 얼음 궁전과 웅장한 눈 조각이 가득한 영하의 환상적인 얼음 왕국.';

  @override
  String get zhangjiajieAvatarMountainCableCar => '장자제 아바타 산 케이블카';

  @override
  String get suspendedHighInAGlassCableCarSoarin => '수천 개의 웅장한 사암 석주 봉우리 위를 가로지르는 통유리 케이블카에 높이 올라.';

  @override
  String get gobiDesertStargazingCampInGansu => '간쑤성 고비 사막 은하수 별 관측 캠핑';

  @override
  String get aLuxuryYurtCampUnderACrystalclearMi => '자위관 인근 사막, 맑고 청명한 밤하늘의 은하수 아래 펼쳐진 럭셔리 게르 캠프.';

  @override
  String get yangtzeRiverThreeGorgesCruise => '양쯔강 삼협(싼샤) 유람선 크루즈';

  @override
  String get onTheSunDeckOfARiverCruiseShipPassi => '우뚝 솟은 웅장한 구당협(취탕샤)을 가로지르는 리버 크루즈선의 선데크에서.';

  @override
  String get buyingAntiquesInBeijingPanjiayuan => '베이징 판자위안 골동품 시장 탐방';

  @override
  String get aHistoricPotteryKilnFilledWithDelic => '섬세한 미완성 백자 화병과 코발트블루 청화 유약이 가득한 유서 깊은 도자기 가마.';

  @override
  String get suzhouSilkEmbroideryStudio => '쑤저우 전통 비단 자수 공방';

  @override
  String get aPeacefulCanalsideGardenStudioInSuz => '고운 비단실과 원목 자수 수틀이 놓인 쑤저우 수로 옆 한적한 정원 공방.';

  @override
  String get backstageAtATraditionalBeijingOpera => '화려한 무대 의상, 화장대 거울, 정교한 머리 장식으로 가득한 전통 경극 분장실.';

  @override
  String get traditionalChineseMedicineConsultat => '중의학(한의학) 진료 상담';

  @override
  String get morningTaiChiInTempleOfHeavenPark => '천단공원에서의 아침 태극권 수련';

  @override
  String get beneathAncientCypressTreesAtDawnWit => '새벽녘 울창한 측백나무 아래, 새들의 지저귐 속에 어르신들이 호흡을 맞춰 태극권을 수련하는 풍경.';

  @override
  String get rentingAHanfuForAPhotoShoot => '스냅 사진 촬영을 위한 한푸(전통 의상) 대여';

  @override
  String get aTraditionalCostumeBoutiqueNearTheW => '서호 근처 당나라와 송나라 양식의 우아한 예복이 가득한 전통 의상점.';

  @override
  String get guqinAncientZitherInstrumentWorksho => '고금(구친, 전통 7현금) 공방 체험';

  @override
  String get aQuietPinewoodStudioInHangzhouFille => '오래된 오동나무와 명주실 현악기로 가득 찬 항저우의 고즈넉한 소나무 공방.';

  @override
  String get shaanxiShadowPuppetTheater => '산시성 전통 그림자 인형극(피영희)';

  @override
  String get behindAnIlluminatedWhiteSilkScreenW => '조명을 밝힌 하얀 비단 스크린 뒤편에서 섬세하게 조각된 반투명 소가죽 인형들이 춤추는 무대.';

  @override
  String get chineseCalligraphyWorkshop => '중국 전통 서예 워크숍';

  @override
  String get aTranquilStudioScentedWithPineSootI => '송연묵의 그윽한 묵향, 선지 두루마리, 은은한 차 향기가 맴도는 고요한 서실.';

  @override
  String get adoptingACatAtAnAnimalShelter => '동물 보호소에서 고양이 입양하기';

  @override
  String get aCozyPetRescueCenterInHangzhouWithE => '활발한 구조 아기 고양이들과 방문객을 위한 따뜻한 차가 준비된 항저우의 아늑한 동물 구조 센터.';

  @override
  String get scriptMurderMysteryJubenshaGame => '추리 롤플레잉 게임 (쥐번샤 / 剧本杀)';

  @override
  String get aThemedDetectiveLoungeInShanghaiWit => '코스튬을 입은 플레이어들과 촛불이 은은하게 켜진 상하이의 테마 추리 라운지.';

  @override
  String get vintageVinylRecordShopInShanghai => '상하이 빈티지 바이닐 레코드 샵';

  @override
  String get aHiddenVinylStoreInAnOldLaneHousePa => '80년대 클래식 홍콩 팝과 재즈 음반으로 가득한 오래된 스쿠먼 골목 안 숨은 LP 샵.';

  @override
  String get ktvKaraokePartyWithFriends => '친구들과 즐기는 KTV 노래방 파티';

  @override
  String get joiningACityBikeCyclingClub => '도심 자전거 라이딩 클럽 참가';

  @override
  String get aGatheringOfCyclistsByTheRiverfront => '도심 스카이라인을 배경으로 야간 라이딩을 준비하는 강변의 라이더 모임.';

  @override
  String get blindBoxToyTradingMeetup => '블라인드 박스 아트토이 교환 모임';

  @override
  String get aColorfulPopcultureToyStoreInChaoya => '전시 진열장과 미개봉 한정판 컬렉션이 가득한 차오양구의 다채로운 팝 컬처 토이 샵.';

  @override
  String get droneSkylineVideographyAtTheBund => '와이탄 도심 스카이라인 드론 항공 촬영';

  @override
  String get theBundPromenadeAtDuskOverlookingTh => '푸둥의 미래지향적인 마천루 야경이 한눈에 내려다보이는 해 질 녘 와이탄 산책로.';

  @override
  String get goldenRetrieverCafeInNanjing => '난징 골든 리트리버 카페';

  @override
  String get aSunnyCheerfulPetCafeWithDozensOfFr => '수십 마리의 순하고 사랑스러운 대형견들이 반갑게 맞아주는 햇살 가득한 애견 카페.';

  @override
  String get boulderingClimbingGymInChengdu => '청두 실내 볼더링 클라이밍 짐';

  @override
  String get aModernIndoorClimbingGymWithVibrant => '알록달록한 홀드 루트와 신나는 음악이 흐르는 트렌디한 최신 실내 클라이밍 센터.';

  @override
  String get aMassiveConventionHallFilledWithCol => '다채로운 게임 부스, 포토존, 코스프레 크리에이터들로 가득 찬 초대형 컨벤션 홀.';

  @override
  String get askingForDirectionsInABeijingHutong => '베이징 후퉁 골목에서 길 묻기';

  @override
  String get aMazeOfHistoricGreybrickAlleysWithB => '자전거와 안뜰, 석류나무가 어우러진 역사적인 회색 벽돌 후퉁 골목의 미로.';

  @override
  String get buyingFreshFruitAtAWetMarket => '전통 재래시장에서 신선한 과일 사기';

  @override
  String get aLivelyMorningNeighborhoodMarketWit => '싱싱한 리치, 망고, 용과가 수북이 쌓여 있는 활기 넘치는 아침 동네 청과 시장.';

  @override
  String get flowerMarketBouquetInKunming => '쿤밍 꽃 시장 꽃다발 고르기';

  @override
  String get theFamousDounanFlowerMarketSurround => '수만 송이의 싱싱한 장미, 백합, 유칼립투스 향기로 가득 찬 아시아 최대의 더우난 꽃 시장.';

  @override
  String get tailorAlterationsInAnOldLaneHouse => '골목길 옛 가옥의 전통 수선집';

  @override
  String get aTraditionalTailorShopFilledWithSew => '재봉틀, 원단 두루마리, 줄자가 가득한 정겨운 전통 양복 수선점.';

  @override
  String get expressParcelLockerRetrieval => '스마트 무인 택배함에서 택배 찾기';

  @override
  String get downstairsAtAResidentialApartmentGa => '아파트 정문 1층, 하이브 박스(Hive Box) 스마트 무인 택배함 앞.';

  @override
  String get bicycleFlatTireRepairAtCampusGate => '대학교 정문 앞 자전거 펑크 수리';

  @override
  String get aSmallOutdoorRoadsideToolkitStandUn => '우거진 벵골보리수 나무 그늘 아래 자리 잡은 소박한 길거리 수리 노점.';

  @override
  String get techCompanyProductDemo => 'IT 테크 기업 신제품 데모 시연';

  @override
  String get aFuturisticTechConferenceBoothInShe => '최첨단 AI 하드웨어를 선보이는 선전의 미래지향적인 테크 컨퍼런스 부스.';

  @override
  String get ecommerceLivestreamStudio => '라이브 커머스(생방송 판매) 스튜디오';

  @override
  String get aHighenergyBroadcastStudioWithRingL => '링 라이트 조명, 제품 진열대, 실시간 반응 모니터가 갖춰진 열기 넘치는 방송 스튜디오.';

  @override
  String get yiwuInternationalTradeMarket => '이우(Yiwu) 국제 상무성';

  @override
  String get aVastMultistoryCommercialExhibition => '수백만 종의 도매 공산품과 공예품이 끝없이 늘어선 거대한 다층 무역 전시관.';

  @override
  String get universityCampusExchangeProgram => '대학교 캠퍼스 교환학생 프로그램';

  @override
  String get aSunnyLawnOutsideTheUniversityLibra => '학생들이 삼삼오오 모여 공부하고 밀크티를 마시는 대학 도서관 앞 잔디밭.';

  @override
  String get pleaseEnterAScenarioTopic => '시나리오 주제를 입력해 주세요.';

  @override
  String get nameTitle => '이름 (호칭)';

  @override
  String get aiCharacter => 'AI 캐릭터';

  @override
  String get helloWelcomeHereWhatShallWeChatAbou => '안녕하세요! 환영합니다. 오늘 어떤 주제로 대화를 나눠볼까요?';

  @override
  String get greetYourConversationPartner => '대화 상대에게 인사하기';

  @override
  String get askAQuestionInChinese => '중국어로 질문하기';

  @override
  String get pinyinWithToneMarks => '성조 표기 병음';

  @override
  String get goal1InEnglish => '학습 목표 1 (한국어)';

  @override
  String get goal2InEnglish => '학습 목표 2 (한국어)';

  @override
  String get goal3InEnglish => '학습 목표 3 (한국어)';

  @override
  String get beginner => '초급';

  @override
  String get hsk12 => 'HSK 1-2급';

  @override
  String get hsk34 => 'HSK 3-4급';

  @override
  String get hsk56 => 'HSK 5-6급';

  @override
  String get master => '마스터 (고급)';

  @override
  String get azurePronunciationAssessment => 'AZURE 발음 평가 시스템';

  @override
  String get tapToReview => '탭하여 복습하기';

  @override
  String get overallScore => '종합 점수';

  @override
  String get toneAccuracy => '성조 정확도';

  @override
  String get fluency => '유창성';

  @override
  String get report => '리포트 보기';

  @override
  String get goodPronunciationButCanBeBetter => '좋은 발음이에요! 조금만 더 다듬어 볼까요?';

  @override
  String get didYouMeanToSay => '혹시 이렇게 말하려고 하셨나요?';

  @override
  String get greatKeepTrying => '훌륭해요! 계속 연습해 보세요!';

  @override
  String get completeness => '완성도';

  @override
  String get targetTone => '목표 성조';

  @override
  String get k4toneComparisonTapToListen => '4가지 성조 비교 (탭하여 듣기):';

  @override
  String get youSpokeMatch => '내 발음 (일치!)';

  @override
  String get youSpoke => '내 발음';

  @override
  String get yourPrimaryCollectionOfCharacters => '기본 한자 단어장입니다.';

  @override
  String get deckNotFound => '덱을 찾을 수 없습니다';

  @override
  String get cannotDeleteTheDefaultDeck => '기본 덱은 삭제할 수 없습니다';

  @override
  String get hsk4UpperIntermediate1 => 'HSK 4급: 중상급';

  @override
  String get theFirst150CharactersToStartYourJou => '학습 여정을 시작하는 필수 150자.';

  @override
  String get buildYourVocabularyTo300EssentialWo => '300개의 핵심 단어로 어휘력을 확장하세요.';

  @override
  String get masterConversationalFluencyWith600W => '600개 단어로 일상 회화를 유창하게 구사하세요.';

  @override
  String get readTextsAndConverseFluentlyWith120 => '1,200개 단어로 글을 읽고 유창하게 소통하세요.';

  @override
  String get readNewspapersAndWatchMoviesWith250 => '2,500개 단어로 신문을 읽고 영화를 감상하세요.';

  @override
  String get databaseBoxNotOpen => '데이터베이스가 열려 있지 않습니다';

  @override
  String get hsk1DataFileIsEmpty => 'HSK 1급 데이터 파일이 비어 있습니다';

  @override
  String get gold => '골드';

  @override
  String get globalDictionaryNotInitialized => '글로벌 사전이 초기화되지 않았습니다';

  @override
  String get reading => '독해';

  @override
  String get recall => '회상';

  @override
  String get speaking => '스피킹';

  @override
  String get listening1 => '듣기';

  @override
  String get practiceStrokeOrderWithVisualGuides => '시각 가이드에 따라 올바른 필순을 연습하세요.';

  @override
  String get seeTheCharacterRecallThePinyinAndMe => '한자를 보고 병음과 뜻을 떠올려 보세요.';

  @override
  String get seeTheMeaningDrawTheCharacterFromMe => '뜻을 보고 기억을 더듬어 직접 한자를 써보세요.';

  @override
  String get readOutLoudToTestYourPronunciationT => '소리 내어 읽으며 발음과 성조를 테스트하세요.';

  @override
  String get listenToTheAudioAndIdentifyTheChara => '음성을 듣고 알맞은 한자를 찾아보세요.';

  @override
  String get contract => '인터페이스 명세';

  @override
  String get whoeverImplementsMeMustBeAbleToDoTh => '이 인터페이스를 구현하는 모든 클래스는 다음 기능을 제공해야 합니다.';

  @override
  String get koreFenrirCharonAoedePuckOrLocal => 'Kore, Fenrir, Charon, Aoede, Puck 또는 기기 로컬 음성';

  @override
  String get manageDecks => '덱 관리';

  @override
  String get weRanIntoTroubleLoadingTheLibraryPl => '라이브러리를 불러오는 중 문제가 발생했습니다. 다시 시도해 주세요.';

  @override
  String get noCharactersInLexicon1 => '어휘장에 등록된 한자가 없습니다';

  @override
  String get masterTheBuildingBlocks => '한자의 기본 부수를 마스터하세요';

  @override
  String get other => '기타';

  @override
  String get required => '필수';

  @override
  String get library1 => '라이브러리';

  @override
  String get youAreAPremiumMember => '프리미엄 회원입니다';

  @override
  String get createAccountToSyncProgress => '학습 진도를 동기화하려면 계정을 생성하세요';

  @override
  String get signOut => '로그아웃';

  @override
  String get account => '계정';

  @override
  String get guestScholar => '게스트 탐구자';

  @override
  String get localAccount => '로컬 계정';

  @override
  String get unknownRadical => '미분류 부수';

  @override
  String get followTheGuideStroke => '가이드 획을 따라 바르게 쓰세요';

  @override
  String get strokeAnimationSpeed => '필순 애니메이션 속도';

  @override
  String get notifications => '알림';

  @override
  String get deutsch => '독일어';

  @override
  String get bahasaIndonesia => '인도네시아어';

  @override
  String get italiano => '이탈리아어';

  @override
  String get today1d2d3d4d5d6d => '오늘, 1일 후, 2일 후, 3일 후, 4일 후, 5일 후, 6일 후';

  @override
  String get targetDeck => '저장 대상 덱';

  @override
  String get mixed => '혼합형';

  @override
  String get topicForContext => '학습 주제 (문맥 설정)';

  @override
  String get nounsOnly => '명사만';

  @override
  String get verbsOnly => '동사만';

  @override
  String get idiomsChengyu => '고사성어 (成语)';

  @override
  String get fullSentences => '전체 문장';

  @override
  String get beginnerHsk12 => '초급 (HSK 1-2급)';

  @override
  String get intermediateHsk34 => '중급 (HSK 3-4급)';

  @override
  String get advancedHsk56 => '고급 (HSK 5-6급)';

  @override
  String get generatedByAi => 'AI 생성';

  @override
  String get canYouGiveMeTwoMoreExamplesUsingThi => '이 단어를 사용한 예문을 2개 더 알려주실 수 있나요?';

  @override
  String get whatAreSomeSimilarWordsAndHowDoThey => '유사한 단어에는 무엇이 있으며, 뉘앙스는 어떻게 다른가요?';

  @override
  String get isThisWordUsedInSpokenOrWrittenChin => '이 단어는 구어체와 문어체 중 어디에 더 자주 쓰이나요?';

  @override
  String get areThereOtherWaysToTranslateThisWor => '이 단어를 번역할 수 있는 다른 표현이 있나요?';

  @override
  String get whatAreCommonWordsThatGoTogetherWit => '이 단어와 함께 자주 결합하는 연어(콜로케이션)는 무엇인가요?';

  @override
  String get whatAreCommonMistakesLearnersMakeWi => '학습자들이 이 단어를 쓸 때 가장 자주 범하는 실수는 무엇인가요?';

  @override
  String get emptyResponse => '응답이 없습니다';

  @override
  String get whatIsTheOracleBoneScriptOriginOfTh => '이 한자의 갑골문 기원과 자원(字源)은 무엇인가요?';

  @override
  String get howDidTheAncientFormOfThisCharacter => '이 한자의 고대 자형은 세월에 따라 어떻게 변천되었나요?';

  @override
  String get giveMe3CommonWordsThatContainThisCh => '이 한자가 포함된 대표적인 단어 3개를 알려주세요.';

  @override
  String get whatOtherCharactersShareTheSameRadi => '이 한자와 같은 부수를 사용하는 다른 한자에는 무엇이 있나요?';

  @override
  String get isThereAChineseProverbOrSayingFeatu => '이 한자가 들어간 중국 속담이나 사자성어가 있나요?';

  @override
  String get explainTheStrokeOrderRulesForThisCh => '이 한자의 필순(획순) 규칙을 설명해 주세요.';

  @override
  String get giveMeOneCalligraphyTipForWritingTh => '이 한자를 균형감 있게 잘 쓰기 위한 서예 팁을 알려주세요.';

  @override
  String get isThereAnythingTrickyAboutUsingThis => '이 단어를 문법적으로 활용할 때 유의할 점이 있나요?';

  @override
  String get whatWordsAreCommonlyConfusedWithThi => '이 단어와 헷갈리기 쉬운 단어는 무엇이며, 이유는 무엇인가요?';

  @override
  String get doesThisCharacterCarryCulturalSymbo => '이 한자는 중국 문화에서 특별한 상징적 의미가 있나요?';

  @override
  String get isThisCharacterCommonlySeenInChines => '이 한자는 현대 중국의 영화, 노래, 문학에서 자주 쓰이나요?';

  @override
  String get whatDoesTheRadicalOfThisCharacterMe => '이 한자의 부수는 어떤 고유한 의미를 나타내나요?';

  @override
  String get breakDownEveryComponentAndItsMeanin => '글자의 각 구성 요소를 분해하여 그 뜻을 설명해 주세요.';

  @override
  String get giveMeATrickToRememberTheCorrectTon => '이 한자의 성조를 쉽게 외울 수 있는 암기 팁을 알려주세요.';

  @override
  String get areThereCommonHomophonesThatAreOfte => '발음이 같아 혼동하기 쉬운 동음이의어가 있나요?';

  @override
  String get quotaExceeded => '이용 한도 초과';

  @override
  String get mustProvideEitherCardOrCards => '단일 카드 또는 카드 목록을 전달해야 합니다';

  @override
  String get deckSettings => '덱 설정';

  @override
  String get saveSettings => '설정 저장';

  @override
  String get sealRed => '인주색 (인장 붉은색)';

  @override
  String get sealScript => '전서체 (篆書體)';

  @override
  String get startYourStreak => '연속 학습 시작하기';

  @override
  String get traditionalCharacter => '번체자';

  @override
  String get inQueue => '복습 대기 중';

  @override
  String get tapToListenAgain => '탭하여 다시 듣기';

  @override
  String get contextClue => '문맥 단서';

  @override
  String get microphonePermissionRequired1 => '마이크 접근 권한이 필요합니다.';

  @override
  String get recordingFailedNoFile => '녹음에 실패했습니다 (생성된 음성 파일 없음).';

  @override
  String get holdToSpeakOptional => '길게 눌러 말하기 (선택 사항)';

  @override
  String get microphonePermissionDeniedEnableItI => '마이크 권한이 거부되었습니다. 섀도잉 스튜디오를 사용하려면 기기 설정에서 활성화해 주세요.';

  @override
  String get sessionSummary => '세션 학습 요약';

  @override
  String get hereAreTheCharactersYouStruggledWit => '이번 세션에서 어려워했던 한자 목록입니다:';

  @override
  String get applySessionGradesToSpacedRepetitio => '세션 채점 결과를 간격 반복 시스템(말하기 모드)에 반영';

  @override
  String get masterYourMandarinPronunciationnbyM => '원어민 발음을 그림자처럼 따라 하며\n자연스러운 중국어 성조를 완성하세요.';

  @override
  String get aiIsGradingYourPronunciation => 'AI가 발음을 정밀 분석 중입니다...';

  @override
  String get holdMicToRecordReleaseToGrade => '마이크를 길게 누르고 말하세요. 손을 떼면 채점됩니다.';

  @override
  String get tapAnySyllableToAuditionAll4Tones => '음절을 탭하여 4가지 성조를 모두 들어보세요:';

  @override
  String get freeFlowConversationalPractice => '자유 대화형 실전 회화 연습';

  @override
  String get failedToGeneratePhrasePleaseTryAgai => '문장 생성에 실패했습니다. 다시 시도해 주세요.';

  @override
  String get recordingTooShortHoldTheMicButtonLo => '녹음이 너무 짧습니다. 마이크 버튼을 길게 누르고 말씀해 주세요.';

  @override
  String get recordingErrorPleaseTryAgain => '녹음 중 오류가 발생했습니다. 다시 시도해 주세요.';

  @override
  String get noRecordingCapturedPleaseTryAgain => '녹음된 음성이 없습니다. 다시 시도해 주세요.';

  @override
  String get recordedAudioIsEmptyPleaseTryAgainA => '녹음 파일에 음성이 감지되지 않았습니다. 또렷하게 말씀해 주세요.';

  @override
  String get azureSpeechApiKeysAreMissing1 => 'Azure Speech API 키가 설정되지 않았습니다';

  @override
  String get azureError401 => 'Azure 인증 오류 401';

  @override
  String get azureAuthenticationFailedCheckYourS => 'Azure 인증에 실패했습니다. .env 파일의 Speech API 키와 리전을 확인하세요.';

  @override
  String get azureError429 => 'Azure 요청 한도 초과 오류 429';

  @override
  String get azureQuotaExceededTryAgainLater => 'Azure API 호출 할당량이 초과되었습니다. 잠시 후 다시 시도해 주세요.';

  @override
  String get azureGradingTimedOutCheckYourIntern => 'Azure 발음 채점 시간이 초과되었습니다. 인터넷 연결을 확인하세요.';

  @override
  String get recognitionFailedNull => '음성 인식 실패: null';

  @override
  String get couldNotHearYouClearlyPleaseTryAgai => '음성을 명확하게 인식하지 못했습니다. 다시 말씀해 주세요.';

  @override
  String get singlePhrasePractice => '단일 문장 집중 연습';

  @override
  String get failedToGeneratePhrase => '문장 생성 실패';

  @override
  String get omitted => '누락';

  @override
  String get partial => '부분 일치';

  @override
  String get mispronounced => '발음 오류';

  @override
  String get startSession1 => '세션 시작하기';

  @override
  String get chinese => '중국어';

  @override
  String get paused => '일시 정지됨';

  @override
  String get translationFailed => '번역에 실패했습니다';

  @override
  String get engagingMacroeconomicAndBusinessBre => '생생한 스토리텔링으로 쉽게 풀어내는 거시 경제 및 비즈니스 트렌드 분석.';

  @override
  String get exploresWorldEconomiesBankingHistor => '세계 경제, 금융의 역사, 글로벌 산업 생태계를 심층 탐구합니다.';

  @override
  String get clearArticulateMandarinPerfectForIn => '중·고급 학습자의 듣기 실력 향상에 최적화된 명확하고 수려한 표준 보통화.';

  @override
  String get chefWang => '왕강(王剛) 셰프';

  @override
  String get masterSichuanCulinaryTechniquesTaug => '전문 헤드 셰프가 직접 전수하는 정통 사천요리 조리 기술.';

  @override
  String get stepbystepAuthenticChineseRecipesWi => '강한 불맛의 웍 조절과 정교한 칼질을 배울 수 있는 단계별 정통 중식 레시피.';

  @override
  String get conciseCulinaryVocabularyAndClearIn => '간결한 조리 용어와 군더더기 없이 명쾌한 보통화 설명.';

  @override
  String get cinematographyCuttingedgeCameraTech => '시네마틱 영상미, 첨단 카메라 장비 및 디지털 미디어 심층 리뷰.';

  @override
  String get highproductionDocumentaryStyleExplo => '영상 제작 기법과 최신 AI 혁신 기술을 다루는 고품격 다큐멘터리.';

  @override
  String get richTechnicalMandarinWithCrystalcle => '정확한 딕션과 시각 자막으로 배우는 풍부한 IT 전문 중국어.';

  @override
  String get indepthInvestigativeJournalismAndCu => '심도 있는 탐사 보도와 날카로운 시사 이슈 해설.';

  @override
  String get criticalPerspectivesOnSocialPhenome => '사회 현상, 국제 뉴스, 역사적 사건을 조명하는 비판적 통찰.';

  @override
  String get formalInvestigativeDiscourseIdealFo => '고급 시사 듣기 학습에 이상적인 격식 있는 시사 담화.';

  @override
  String get bitesizedAnimatedScienceDocumentari => '일상 속 호기심을 명쾌하게 풀어주는 숏폼 애니메이션 과학 다큐.';

  @override
  String get exploresPhysicsBiologyAndEverydayCu => '물리학, 생물학, 일상 속 미스터리를 흥미진진한 인포그래픽으로 탐구.';

  @override
  String get standardBeijingMandarinWithWellpace => '듣기 편안한 속도의 내레이션과 명확한 자막이 돋보이는 표준 베이징 보통화.';

  @override
  String get heartwarmingStreetFoodAdventuresAnd => '중국 전역의 정겨운 길거리 음식과 현지인들의 따스한 삶의 이야기.';

  @override
  String get exploresRegionalHumanStoriesFamilyT => '각 지역의 사람 냄새 나는 이야기, 가족의 전통, 향토 미식을 조명.';

  @override
  String get naturalConversationalMandarinWithDa => '일상 유행어와 사람 냄새가 묻어나는 자연스러운 생활 중국어 회화.';

  @override
  String get humorousAndHonestConsumerElectronic => '실제 사용기를 바탕으로 한 솔직하고 유쾌한 전자기기 테크 리뷰.';

  @override
  String get testingSmartphonesSmartHomeGadgetsA => '스마트폰, 스마트홈 기기, 라이프스타일 테크 장비 실전 테스트.';

  @override
  String get relaxedHumorousConversationalDialog => '최신 신조어가 녹아든 편안하고 위트 넘치는 일상 대화.';

  @override
  String get seanKitchen => '션의 주방 (Sean\'s Kitchen)';

  @override
  String get deliciousHomecookedChineseDishesAnd => '맛있는 중국 가정식 요리와 인기 길거리 간식 홈메이드 레시피.';

  @override
  String get easytofollowKitchenTipsForCookingAu => '정통 아시아 요리를 집에서 손쉽게 완성하는 실용적인 요리 꿀팁.';

  @override
  String get warmInvitingCommentaryWithPractical => '실용적인 주방 어휘와 함께하는 다정하고 친근한 설명.';

  @override
  String get chineseChannel => '차이나 채널';

  @override
  String get structuredChineseLanguageLessonsAnd => '체계적인 단계별 중국어 강의와 문화 탐색 튜토리얼.';

  @override
  String get grammarPointsHskVocabularyBuildingA => '핵심 문법 포인트, HSK 필수 단어 완성, 실전 대화 패턴 훈련.';

  @override
  String get clearEducationalPacingTailoredSpeci => '외국인 학습자의 눈높이에 맞춘 명확하고 체계적인 수업 진도.';

  @override
  String get oneInABillion => '14억 분의 1의 이야기 (One in a Billion)';

  @override
  String get intimatePortraitsAndStoriesOfUnique => '현대 중국을 살아가는 특별한 인물들의 진솔한 삶과 자화상.';

  @override
  String get exploresDiverseLifeChoicesYouthCult => '다양한 삶의 방식, 청년 서브컬처, 현대 사회의 가치관 변화를 조명.';

  @override
  String get deepNarrativeStorytellingWithRichVo => '풍부한 어휘와 진정성 있는 목소리로 전하는 깊이 있는 스토리텔링.';

  @override
  String get vickySoup => '비키의 일상 (Vicky Soup)';

  @override
  String get aestheticLifestyleVlogsFashionStyli => '감각적인 라이프스타일 브이로그, 패션 스타일링, 일상 루틴.';

  @override
  String get travelDiariesAndCozyLifeMomentsDocu => '영화 같은 따스한 영상미로 담아낸 감성 여행과 아늑한 일상의 순간들.';

  @override
  String get naturalCasualMandarinSpokenAtAComfo => '듣기 편안하고 감정 표현이 풍부한 자연스러운 캐주얼 보통화.';

  @override
  String get tededMandarin => 'TED-Ed 중국어';

  @override
  String get highqualityAnimatedEducationalLesso => '과학, 철학, 역사를 아우르는 고품격 애니메이션 교양 수업.';

  @override
  String get thoughtprovokingRiddlesClassicLiter => '생각을 깨우는 수수께끼, 고전 문학의 정수, 심리학의 미스터리.';

  @override
  String get impeccableVoiceoverMandarinWithSync => '동기화된 2개 국어 자막과 완벽한 딕션의 표준 보통화 내레이션.';

  @override
  String get channel => '채널';

  @override
  String get curatedCulturalDocumentariesAndChin => '엄선된 문화 다큐멘터리와 현대 중국의 라이프스타일 하이라이트.';

  @override
  String get exploringTraditionalArtsHeritageCra => '전통 예술, 무형 문화유산, 현대적 트렌드의 조화를 탐색.';

  @override
  String get highQualityAudioWithSynchronizedChi => '실시간 동기화 중국어 자막이 제공되는 고음질 오디오 트랙.';

  @override
  String get interestingStoriesAndCreativeVideoP => '중국 인터넷에서 화제가 된 흥미진진한 이야기와 창의적인 영상 프로젝트.';

  @override
  String get engagingInterviewsStorytellingAndVi => '몰입도 높은 인터뷰, 감동적인 스토리텔링, 아름다운 영상미.';

  @override
  String get greatListeningMaterialWithStandardP => '정확한 표준 발음으로 학습하는 최고의 듣기 훈련 자료.';

  @override
  String get xVsY => 'X 대 Y';

  @override
  String get untitled => '제목 없음';

  @override
  String get contemporaryStories => '현대 단편 스토리';

  @override
  String get history => '역사';

  @override
  String get advancedReading => '고급 독해';

  @override
  String get intermediateReading => '중급 독해';

  @override
  String get beginnerReading => '초급 독해';

  @override
  String get mandarinBean => 'Mandarin Bean';

  @override
  String get unknown => '알 수 없음';

  @override
  String get localDb => '로컬 DB';

  @override
  String get emperorTaizong => '당 태종(이세민)';

  @override
  String get emperorXuanzong => '당 현종(이융기)';

  @override
  String get liBai => '이백(이태백)';

  @override
  String get gradedReader => '단계별 다독 교재';

  @override
  String get ucj10r97lkwgdtqbt6xzv8gLearnMandari => 'TaiwanPlus로 배우는 중국어';

  @override
  String get ucsxriuqkzzmaqklq0n9xfvwEverydayChi => '일상 중국어 회화';

  @override
  String get graceMandarinChinese => 'Grace Mandarin Chinese';

  @override
  String get ucolbhvvl5dcjlmzeqbuu1vwTingdailyLi => 'Ting: 중국 일상 브이로그';

  @override
  String get xinxin => '신신(欣欣)';

  @override
  String get sweetFamilyDailyLife => '달콤한 우리 가족의 일상';

  @override
  String get chinsunDailyLife => '친선의 하루';

  @override
  String get tasteChina => '미식 중국 기행';

  @override
  String get dawenFoodQuest => '다원의 맛집 원정대';

  @override
  String get chinaTravelWithCangbao => '창바오와 함께 떠나는 중국 여행';

  @override
  String get alinFoodWalk => '아린의 길거리 먹방 투어';

  @override
  String get videoOfTheDay => '오늘의 추천 영상';

  @override
  String get noValidVideoFound => '재생 가능한 영상을 찾을 수 없습니다.';

  @override
  String get listeningPractice => '리스닝 집중 훈련';

  @override
  String get socialSkills => '소통과 회화 스킬';

  @override
  String get culturalContext => '문화적 배경 이해';

  @override
  String get realLife => '생생한 일상 중국어';

  @override
  String get realWorld => '실전 현지 표현';

  @override
  String get articleOfTheDay => '오늘의 아티클';

  @override
  String get failedToLoadOrParseRssFeed => 'RSS 피드를 불러오거나 구문 분석하는 데 실패했습니다.';

  @override
  String get drama => '드라마';

  @override
  String get youkugetAppNow => 'YOUKU: 지금 앱 다운로드하기';

  @override
  String get romanceTrailer => '로맨스 / 예고편';

  @override
  String get romance => '로맨스';

  @override
  String get action => '액션';

  @override
  String get mystery => '미스터리 / 수사';

  @override
  String get historical => '사극 / 고장극';

  @override
  String get historicalAction => '사극 / 액션';

  @override
  String get historicalRomance => '사극 / 로맨스';

  @override
  String get anYouth => '청춘물';

  @override
  String get historicalSliceOfLife => '사극 / 일상 힐링';

  @override
  String get historicalHighlight => '사극 / 명장면 하이라이트';

  @override
  String get youkuEnglishgetAppNow => 'YOUKU English: 지금 앱 다운로드하기';

  @override
  String get theDouble => '묵우운간 (The Double)';

  @override
  String get updatesByOshin => 'Oshin의 최신 소식';

  @override
  String get backFromTheBrink => '호심 (Back From the Brink)';

  @override
  String get fallingIntoYourSmile => '니소시흔미 (Falling Into Your Smile)';

  @override
  String get everyoneLovesMe => '별대아동심 (Everyone Loves Me)';

  @override
  String get tillTheEndOfTheMoon => '장월신명 (Till The End Of The Moon)';

  @override
  String get theBestDayOfMyLife => '최호적일천 (The Best Day of My Life)';

  @override
  String get gikkiChineseDrama => 'GIKKI 중국 드라마';

  @override
  String get dashingYouth => '소년백마취춘풍 (Dashing Youth)';

  @override
  String get rebornChineseDramaEngSub => '중생 (Reborn) 중국 드라마';

  @override
  String get ijenwaBenita => 'Ijenwa Benita';

  @override
  String get whenIFlyTowardsYou => '당아비분향니 (When I Fly Towards You)';

  @override
  String get mztvExclusiveChineseDrama => 'MZTV 독점 중국 드라마';

  @override
  String get theStarryLove => '성락응성당 (The Starry Love)';

  @override
  String get comedy => '코미디';

  @override
  String get backFromTheBrink1 => '호심 (Back From the Brink)';

  @override
  String get dashingYouth1 => '소년백마취춘풍';

  @override
  String get beReborn => '다시 태어나다 (중생)';

  @override
  String get beautyStrategy => '미인계략';

  @override
  String get myDivineEmissary => '천강신사 (My Divine Emissary)';

  @override
  String get theHope => '명룡소년 (The Hope)';

  @override
  String get ep16In => '제16화';

  @override
  String get everyoneLovesMe1 => '별대아동심';

  @override
  String get fallingIntoYourSmile1 => '니소시흔미';

  @override
  String get hiddenLove => '투투장부주 (Hidden Love)';

  @override
  String get loveBetweenFairyAndDevil => '창란결 (Love Between Fairy and Devil)';

  @override
  String get loveLikeTheGalaxy => '성한찬란 (Love Like the Galaxy)';

  @override
  String get membersPremiere => 'VIP 회원 선공개';

  @override
  String get moonlight => '월광변주곡 (Moonlight)';

  @override
  String get myJourneyToYou => '운지우 (My Journey to You)';

  @override
  String get mysteriousLotusCasebook => '연화루 (Mysterious Lotus Casebook)';

  @override
  String get rebornChineseDramaEngSub1 => '중생 (Reborn)';

  @override
  String get reborn => '중생';

  @override
  String get theBestDayOfMyLife1 => '최호적일천';

  @override
  String get theDouble1 => '묵우운간';

  @override
  String get theLongBallad => '장가행 (The Long Ballad)';

  @override
  String get theStarryLove1 => '성락응성당';

  @override
  String get theUntamed => '진정령 (The Untamed)';

  @override
  String get tillTheEndOfTheMoon1 => '장월신명';

  @override
  String get whenIFlyTowardsYou1 => '당아비분향니';

  @override
  String get wordOfHonor => '산하령 (Word of Honor)';

  @override
  String get blossom => '번화 (Blossoms Shanghai)';

  @override
  String get gemini => 'Gemini';

  @override
  String get generationToGeneration => '대대손손 이어지는 이야기';

  @override
  String get brocadeOdyssey => '촉금인가 (Brocade Odyssey)';

  @override
  String get circleOfLove => '쇄애삼생 (Circle of Love)';

  @override
  String get dawnIsBreaking => '동틀 녘의 빛';

  @override
  String get firstRomance => '첫사랑 로맨스';

  @override
  String get loveInTheClouds => '구름 위의 사랑';

  @override
  String get secondChanceRomance => '다시 찾아온 두 번째 사랑';

  @override
  String get mrBad => '나의 반파남우 (Mr. Bad)';

  @override
  String get pursuitOfJade => '옥을 쫓는 자';

  @override
  String get fatedHearts => '운명으로 맺어진 인연';

  @override
  String get roadHome => '귀로 (Road Home)';

  @override
  String get myDearGuardian => '애상특종병 (My Dear Guardian)';

  @override
  String get brightEyesInTheDark => '타종화광중주래 (Bright Eyes in the Dark)';

  @override
  String get theIngeniousOne => '운양전 (The Ingenious One)';

  @override
  String get herPhoenixMajesty => '봉황의 옥좌';

  @override
  String get dreamsNeverEnd => '끝나지 않는 꿈';

  @override
  String get theUltimateVowUnknownToYou => '너는 모르는 마지막 맹세';

  @override
  String get the300LoyalGhosts => '충성스러운 삼백의 영혼';

  @override
  String get homelandGuardian => '조국의 수호자';

  @override
  String get loveIsAlwaysOnline => '언제나 접속 중인 사랑';

  @override
  String get thePrincessDecree => '공주의 칙령';

  @override
  String get aVowInTheDark => '어둠 속의 맹세';

  @override
  String get aGirlLikeMe => '아취시저반여자 (A Girl Like Me)';

  @override
  String get iAmNobody => '이인지하 (I Am Nobody)';

  @override
  String get myMamaGo => '엄마, 힘내!';

  @override
  String get myWesternRegionPrincess => '나의 서역 공주님';

  @override
  String get aFlowerOnTheContinent => '대륙에 핀 꽃';

  @override
  String get thePrincess => '공주';

  @override
  String get sweetLoveVersion => '달콤 로맨스 버전';

  @override
  String get hilariousFamily2 => '우당탕탕 우리 가족 2';

  @override
  String get guYuanMountainHasASchool => '고원산의 서당';

  @override
  String get foreverYoung => '영원한 청춘';

  @override
  String get theHiddenHeirYeChen => '숨겨진 후계자 엽진';

  @override
  String get extraordinary => '비범한 자의 길';

  @override
  String get sideStoryOfFoxVolant => '비호외전 (Side Story of Fox Volant)';

  @override
  String get loveOfTheDivineTree => '신목의 연정';

  @override
  String get rebirth => '환생과 부활';

  @override
  String get moonlitReunion => '달빛 아래의 재회';

  @override
  String get videoCountsCannotBeNegative => '동영상 수는 0 이상이어야 합니다.';

  @override
  String get publicDomainClassic => '퍼블릭 도메인 고전 명작';

  @override
  String get idioms => '고사성어';

  @override
  String get news => '뉴스';

  @override
  String get fairyTales => '전래동화 및 우화';

  @override
  String get hereIsAFascinatingCulturalExplanati => '흥미로운 문화적 배경 해설입니다:';

  @override
  String get videoFetchTimedOut => '동영상 불러오기 시간이 초과되었습니다';

  @override
  String get aboutChannel => '채널 소개';

  @override
  String get noVideosFound => '동영상을 찾을 수 없습니다';

  @override
  String get failedToLoadVideos => '동영상을 불러오지 못했습니다';

  @override
  String get highqualityCuratedMandarinContentWi => '생생한 어휘로 엄선된 고품격 중국어 학습 콘텐츠.';

  @override
  String get authenticSpokenChineseAcrossRealwor => '실제 일상과 다양한 주제를 아우르는 진짜 중국어 회화.';

  @override
  String get engagingVideoMaterialWithInteractiv => '실시간 동기화 자막이 지원되는 몰입도 높은 영상 학습 자료.';

  @override
  String get watchVideo => '영상 시청하기';

  @override
  String get culturalInsight => '문화적 인사이트';

  @override
  String get aiIsAnalyzingCulturalContext => 'AI가 문화적 배경을 분석하는 중입니다...';

  @override
  String get diveIntoFullContent => '콘텐츠 전문 확인하기';

  @override
  String get savedArticles => '저장된 아티클';

  @override
  String get liveOverlay => '라이브 오버레이';

  @override
  String get webExplorer => '웹 탐색기';

  @override
  String get browseAnyChineseWebsiteWithRealtime => '단어 탭 사전, 병음 주석, 실시간 번역으로 중국어 웹사이트를 자유롭게 서핑하세요.';

  @override
  String get startExploring => '탐색 시작하기';

  @override
  String get chineseTvSeriesWithInteractiveSubti => '인터랙티브 자막과 함께 보는 중국 드라마';

  @override
  String get failedToLoadContent => '콘텐츠를 불러오지 못했습니다';

  @override
  String get searchingYoutube => 'YouTube 검색 중...';

  @override
  String get noVideosFoundTryADifferentSearchTer => '검색된 동영상이 없습니다. 다른 검색어로 시도해 보세요.';

  @override
  String get searching => '검색 중...';

  @override
  String get noShowsFound => '프로그램을 찾을 수 없습니다';

  @override
  String get bookmarked => '북마크 완료';

  @override
  String get trailer1 => '예고편';

  @override
  String get highlight1 => '하이라이트';

  @override
  String get noCaptionsAvailable => '사용 가능한 자막이 없습니다';

  @override
  String get fetchingSubtitles => '자막을 가져오는 중...';

  @override
  String get generatingAiBriefing => 'AI 요약 브리핑 생성 중...';

  @override
  String get noClosedCaptionsCcFoundForThisVideo => '이 동영상에는 디지털 자막(CC)이 없습니다.';

  @override
  String get videosWithHardcodedOrBurnedinSubtit => '영상 화면에 자체 인쇄된 자막은 디지털 텍스트로 추출할 수 없습니다.';

  @override
  String get translatingSubtitles => '자막을 번역하는 중...';

  @override
  String get processingYourPronunciation => '발음 데이터를 분석하는 중...';

  @override
  String get couldntIdentifyLine => '해당 문장을 인식하지 못했습니다.';

  @override
  String get listeningSpeakNow => '듣고 있습니다... 지금 말씀하세요.';

  @override
  String get thisVideoDoesNotHaveADigitalClosedC => '이 동영상은 디지털 자막(CC)을 지원하지 않습니다.';

  @override
  String get perfect1 => '완벽해요';

  @override
  String get thisVideoHasBeenRemovedOrIsNoLonger => '이 동영상은 삭제되었거나 더 이상 재생할 수 없습니다.';

  @override
  String get thisVideoCannotBePlayedInTheAppYouC => '이 동영상은 앱 내 재생을 지원하지 않습니다. YouTube에서 시청해 주세요.';

  @override
  String get yourDeviceCannotPlayThisVideoPlease => '현재 기기에서 지원하지 않는 동영상 형식입니다. 다른 영상을 선택해 주세요.';

  @override
  String get invalidVideoReferencePleaseTryAgain => '올바르지 않은 동영상 링크입니다. 다시 시도해 주세요.';

  @override
  String get unableToLoadThisVideoPleaseTryAnoth => '동영상을 불러올 수 없습니다. 다른 영상을 시도해 주세요.';

  @override
  String get startReading => '읽기 시작하기';

  @override
  String get analyzingCulturalContext => '문화적 배경 분석 중...';

  @override
  String get failedToLoadCulturalInsight => '문화 해설을 불러오지 못했습니다.';

  @override
  String get historicalContext => '역사적 배경';

  @override
  String get culturalSignificance => '문화적 의의';

  @override
  String get authorBackground => '작가의 생애와 배경';

  @override
  String get k80CompleteClassicNovelsWorldEpics => '80편 이상의 완역 고전 소설 및 세계 서사시 수록';

  @override
  String get storyOfTheDay => '오늘의 스토리';

  @override
  String get tangDynasty => '당나라';

  @override
  String get poetryClassicalVerse => '한시·고전 시가·운문';

  @override
  String get allHsk => '전체 HSK 급수';

  @override
  String get allStories => '전체 스토리';

  @override
  String get keyWords => '핵심 단어';

  @override
  String get openOriginalWebsite => '원본 웹사이트 열기';

  @override
  String get aiReadingTools => 'AI 독서 도구';

  @override
  String get enhanceYourReadingWithAipoweredTool => 'AI 기반 도구로 독해력을 극대화하세요';

  @override
  String get chooseTheTargetDifficultyForSimplif => '쉬운 글 변환 목표 난이도를 선택하세요';

  @override
  String get chooseDifficultyForSimplification => '난이도 선택';

  @override
  String get extractAllUnknownWordsToANewFlashca => '모르는 단어를 새 플래시카드 덱으로 모두 추출';

  @override
  String get length => '분량';

  @override
  String get m1554846a550010707 => 'M15.54 8.46a5 5 0 0 1 0 7.07';

  @override
  String get m1907493a101000101414 => 'M19.07 4.93a10 10 0 0 1 0 14.14';

  @override
  String get webExtraction => '웹 텍스트 추출';

  @override
  String get aiTools => 'AI 학습 도구';

  @override
  String get stop => '정지';

  @override
  String get keepPracticing1 => '계속 연습하기';

  @override
  String get aiPrepRoom => 'AI 학습 준비실';

  @override
  String get lessonSummary => '레슨 요약';

  @override
  String get unlockSinosparkPremium => 'SinoSpark 프리미엄 잠금 해제';

  @override
  String get monthYear => '월 / 년';

  @override
  String get enableNotifications => '알림 켜기';

  @override
  String get notificationsConfigured => '알림 설정이 완료되었습니다';

  @override
  String get neverMissAStroke2 => '한 획도 놓치지 마세요';

  @override
  String get yourDailyDropAndStreakAlertsArePrim => '일일 데일리 드롭과 연속 학습 알림이 준비되었습니다.';

  @override
  String get stayConsistentWithDailyRitualDropsA => '매일 주어지는 학습 루틴과 알림을 통해 학습 습관을 꾸준히 유지하세요.';

  @override
  String get aNewWordAndStoryWaitingForYourDaily => '매일의 학습 루틴을 위한 새로운 단어와 스토리가 준비되어 있습니다.';

  @override
  String get gentlePromptsBeforeCharactersFadeFr => '기억에서 잊히기 전에 최적의 타이밍에 복습 알림을 드립니다.';

  @override
  String get receiveAReminder2DaysBeforeYourFree => '무료 체험 종료 2일 전에 사전 알림을 받아보세요.';

  @override
  String get yourPathTonchineseFluency => '중국어 마스터를 향한 맞춤 길';

  @override
  String get answer3QuickQuestionsSoOurAiCanCraf => '간단한 3가지 질문에 답하시면,\nAI가 회원님의 라이프스타일에 맞춘 최적의 커리큘럼을 설계합니다.';

  @override
  String get whatIsYourLevelnwithChinese => '현재 중국어 실력은\n어느 정도인가요?';

  @override
  String get chooseThePathThatFitsYourDepth => '현재 수준에 가장 적합한 학습 경로를 선택하세요.';

  @override
  String get whatDrivesYourStudy => '중국어를 배우는 주된 목표는 무엇인가요?';

  @override
  String get purposeFuelsTheBrush => '확고한 목표가 배움의 붓을 움직입니다';

  @override
  String get setYourDailyRitual => '매일의 학습 목표 시간을 설정하세요.';

  @override
  String get youCanAdjustYourRitualAnyTime => '학습 루틴은 언제든지 변경할 수 있습니다.';

  @override
  String get letsBegin => '지금 시작하기';

  @override
  String get brandNew => '입문 (처음 시작)';

  @override
  String get iveNeverStudiedChineseBefore => '중국어를 전혀 배운 적이 없습니다.';

  @override
  String get iKnowBasicCharactersAndPhrases => '기초적인 한자와 간단한 인사말 정도는 알고 있습니다.';

  @override
  String get iCanHoldConversationsAndRead => '간단한 일상 대화가 가능하며 짧은 문장을 읽을 수 있습니다.';

  @override
  String get iWantToRefineAndPerfectMySkills => '원어민 수준으로 실력을 다듬고 완성하고 싶습니다.';

  @override
  String get confirmSelection => '선택 완료';

  @override
  String get purposeFuelsTheBrushsMotion => '뚜렷한 목적이 한 획 한 획에 힘을 실어줍니다.';

  @override
  String get buildMyPath => '맞춤 커리큘럼 생성';

  @override
  String get hskCertification => 'HSK 시험 합격 및 자격 취득';

  @override
  String get culturalAppreciation => '중국 문화·역사·예술 이해';

  @override
  String get yourPlanIsReady => '맞춤 학습 플랜이 준비되었습니다';

  @override
  String get craftingYourCurriculum => '맞춤 커리큘럼을 생성하는 중...';

  @override
  String get personalizedPathInitialized => '맞춤형 학습 경로가 시작되었습니다';

  @override
  String get calibratingAiNeuralMasters => 'AI 뉴럴 튜터를 조정하는 중...';

  @override
  String get calibrationComplete => '튜터 세팅 완료';

  @override
  String get synthesizingModules => '학습 모듈을 구성하는 중...';

  @override
  String get oneAndWater => '「一 (하나 일)」과 「水 (물 수)」';

  @override
  String get theHorizontalStroke => '기본 필획: 가로획(橫)';

  @override
  String get theRadical => '부수(部首)';

  @override
  String get water => '물';

  @override
  String get river => '강';

  @override
  String get day5Reminder => '체험 5일 차 알림';

  @override
  String get wePromisedToAlertYou2DaysBeforeYour => '약속드린 대로 무료 체험 종료 2일 전에 미리 안내해 드립니다.';

  @override
  String get continueWithoutReminder => '알림 없이 계속하기';

  @override
  String get masterChineseWithnsinospark => 'SinoSpark와 함께\n중국어를 완벽하게 정복하세요';

  @override
  String get start7dayFreeTrial => '7일 무료 체험 시작하기';

  @override
  String get precisionStrokes => '정밀한 획순 코칭';

  @override
  String get aiPronunciation => 'AI 실시간 발음 교정';

  @override
  String get today => '오늘';

  @override
  String get fullAccess => '모든 기능 무제한 이용';

  @override
  String get day5 => '5일 차';

  @override
  String get reminder => '알림';

  @override
  String get day7 => '7일 차';

  @override
  String get trialBegins => '무료 체험 시작';

  @override
  String get revenuecatIsMissingACurrentOffering => 'RevenueCat에 활성화된 패키지가 없습니다. 대시보드를 구성해 주세요.';

  @override
  String get cameraPermissionRequiredForLiveScan => '실시간 스캔을 사용하려면 카메라 접근 권한이 필요합니다.';

  @override
  String get cameraAccessRequired => '카메라 권한 필요';

  @override
  String get pleaseEnableCameraAccessInYourDevic => '이 기능을 사용하려면 기기 설정에서 카메라 접근을 허용해 주세요.';

  @override
  String get alignChineseTextWithinFrame => '프레임 안에 중국어 텍스트를 맞춰주세요';

  @override
  String get inLibrary => '서재 보관 중';

  @override
  String get novice => '입문자';

  @override
  String get apprentice => '수습생';

  @override
  String get artisan => '숙련가';

  @override
  String get grandmaster => '대가·종사';

  @override
  String get poem => '한시';

  @override
  String get theNarrative => '스토리 본문';

  @override
  String get classicMasterpiece => '고전 명작';

  @override
  String get classicAuthor => '고전 작가';

  @override
  String get classical => '고전';

  @override
  String get classicLiterature => '고전문학';

  @override
  String inThisChapterOf(Object title) {
    return '《$title》의 이번 장에서는';
  }

  @override
  String get asTheNarrativeUnfoldsItIlluminatesT => '이야기가 깊어질수록 삶의 심오한 지혜와 시대를 초월한 감동이 펼쳐집니다.';

  @override
  String get general => '일반·종합';

  @override
  String get mythology => '신화·전설';

  @override
  String get dailyLife => '일상생활';

  @override
  String get tangPoetry => '당시 (당나라 시)';

  @override
  String get classicalLiterature => '고전문학';

  @override
  String get justNow => '방금 전';

  @override
  String get theTerracottaArmyOfQinShiHuang => '진시황릉의 병마용';

  @override
  String get lifeInsideTheForbiddenCity => '자금성의 궁중 생활';

  @override
  String get buyingATicketAndTakingTheHighSpeedT => '중국에서 승차권을 예매하고 고속열차 타기';

  @override
  String get goingToTheHospitalForAColdAndSeeing => '감기 때문에 병원에 방문하여 진료받기';

  @override
  String get goingToALocalRestaurantToOrderJiaoz => '로컬 맛집에서 물만두(자오쯔) 주문하기';

  @override
  String get theTraditionalGongfuTeaCeremony => '전통 궁푸차(工夫茶) 다도 예절';

  @override
  String get theArtOfWritingChineseCharactersWit => '붓으로 한자를 쓰는 전통 서예 예술';

  @override
  String get theLifeAndConservationOfGiantPandas => '자이언트 판다의 생태와 멸종위기 보호 활동';

  @override
  String get storyNotFoundInDatabase => '데이터베이스에서 스토리를 찾을 수 없습니다.';

  @override
  String get storyTextIsEmpty => '스토리 내용이 비어 있습니다.';

  @override
  String get myCustomStories => '내가 만든 스토리';

  @override
  String get userProvidedText => '사용자 입력 텍스트';

  @override
  String get local => '로컬';

  @override
  String get voiceEngineAllowance => '음성 엔진 및 무료 이용량';

  @override
  String get studioHdVsUnlimitedStandardVoice => '스튜디오 HD 음성 vs 무제한 기본 음성';

  @override
  String get standardVoiceIs100UnlimitedFree => '기본 음성은 100% 무제한 무료로 제공됩니다.';

  @override
  String get read => '읽기';

  @override
  String get koreKoreFemaleWarm => 'Kore (여성, 따뜻한 톤)';

  @override
  String get aoedeAoedeFemaleCheerful => 'Aoede (여성, 밝고 경쾌한 톤)';

  @override
  String get fenrirFenrirMaleUpbeat => 'Fenrir (남성, 힘차고 활기찬 톤)';

  @override
  String get charonCharonMaleNewsstyle => 'Charon (남성, 신뢰감 있는 뉴스 톤)';

  @override
  String get puckPuckMaleSporty => 'Puck (남성, 시원시원한 스포츠 톤)';

  @override
  String get localOndevice => '기기 내장 음성';

  @override
  String get localOndeviceTts => '기기 기본 TTS';

  @override
  String get off => '꺼짐';

  @override
  String get endOfCurrentChapter => '현재 장의 끝';

  @override
  String get standardVoice => '기본 음성';

  @override
  String get noNovelsFoundMatchingYourFilter => '필터 조건과 일치하는 소설이 없습니다.';

  @override
  String get noMicroreadsFoundMatchingYourFilter => '필터 조건과 일치하는 마이크로 리딩이 없습니다.';

  @override
  String get noPoemsFoundMatchingYourFilter => '필터 조건과 일치하는 한시가 없습니다.';

  @override
  String get audiobook => '오디오북';

  @override
  String get audio => '오디오';

  @override
  String get continueReading => '이어서 읽기';

  @override
  String get search96FullNovelsAuthorsEpics => '96편의 완역 장편소설, 작가, 고전 서사시 검색...';

  @override
  String get searchClassicalPoemsAuthorsVerses => '고전 한시, 시인, 명구절 검색...';

  @override
  String get allLevelsVal => '전체 급수';

  @override
  String get hsk1BeginnerVal => 'HSK 1급 (입문)';

  @override
  String get hsk2ElementaryVal => 'HSK 2급 (초급)';

  @override
  String get hsk3IntermediateVal => 'HSK 3급 (중급)';

  @override
  String get hsk4UpperIntVal => 'HSK 4급 (중상급)';

  @override
  String get listenToAudiobook => '오디오북 듣기';

  @override
  String get synopsis => '줄거리 및 해제';

  @override
  String get peoplesArtist => '인민예술가';

  @override
  String get kafkaesqueForBureaucraticAbsurdityA => '관료주의적 부조리, 인간 소외, 실존적 고뇌를 뜻하는 \'카프카적(Kafkaesque)\'.';

  @override
  String get bigBrotherAndNewspeak => '\'빅 브라더\'와 \'신어(Newspeak)\'.';

  @override
  String get audiobookIncluded => '오디오북 수록';

  @override
  String get readPoem => '시 읽기';

  @override
  String get studioVoiceAllowance => '스튜디오 HD 음성 이용 한도';

  @override
  String get weeklyHighdefinitionAiRecitation => '주간 고음질 AI 낭독 이용권';

  @override
  String get resetsEveryMondayAt0000 => '매주 월요일 00:00에 리셋됩니다';

  @override
  String get whenYourWeekly4hourStudioAllowanceI => '주간 4시간의 스튜디오 음성을 모두 사용하면, 끊김 없는 무료 청취를 위해 자동으로 기기 내장 음성으로 전환됩니다.';

  @override
  String get localDeviceVoice => '기기 내장 기본 음성';

  @override
  String get classicalVerse => '고전 시구';

  @override
  String get ondeviceVoice4hWeeklyUsed => '기기 내장 음성 (이번 주 4시간 소진됨)';

  @override
  String get generateACustomAiStoryBasedOnYourIn => '내 관심사에 맞춘 AI 스토리 생성';

  @override
  String get insteadOfAFixedHskLevelTheFlowState => '고정된 HSK 급수에 얽매이지 않고, 동적 플로우 엔진이 내 단어장의 어휘 수준을 분석합니다.\n\n';

  @override
  String get we => 'SinoSpark 팀';

  @override
  String get howCanWeHelpYou => '무엇을 도와드릴까요?';

  @override
  String get everythingYouNeedToKnowAboutHanziMa => 'SinoSpark의 기능, 학습법, 개인정보 보호에 대한 모든 것.';

  @override
  String get whoAreTheVoicesSpeakingInTheApp => '앱에 등장하는 음성 성우진 안내';

  @override
  String get howDoesTheWebExplorerWork => '웹 탐색기 기능 활용법';

  @override
  String get whatIsZenMode => '젠(Zen) 집중 모드란?';

  @override
  String get howDoesTheFlashcardSpacedrepetition => '플래시카드 간격 반복(SRS)의 작동 원리';

  @override
  String get traceComplete => '쓰기 연습 완료!';

  @override
  String get traceCharacter => '한자 따라 쓰기';

  @override
  String get analyzingWordRelationships => '단어 간의 연관 관계 분석 중...';

  @override
  String get identifyingUsageContexts => '실전 활용 문맥 파악 중...';

  @override
  String get comparingFormalityLevels => '격식성 수준 비교 분석 중...';

  @override
  String get findingCommonCollocations => '자주 쓰이는 연어(콜로케이션) 검색 중...';

  @override
  String get generatingComparison => '비교 해설을 생성하는 중...';

  @override
  String get generationIsTakingLongerThanExpecte => '생성에 평소보다 시간이 더 걸리고 있습니다. AI 서버가 혼잡할 수 있습니다.';

  @override
  String get generationInterruptedShowingPartial => '생성이 중단되었습니다. 준비된 일부 결과를 표시합니다.';

  @override
  String get sorrySomethingWentWrong => '죄송합니다. 오류가 발생했습니다.';

  @override
  String get usage => '용법:';

  @override
  String get alsoSeenIn => '다음 작품 및 문맥에도 등장';

  @override
  String get quickLook => '미리보기';

  @override
  String get notFound => '찾을 수 없음';

  @override
  String get errorLoadingFromAi => 'AI 데이터를 불러오는 중 오류가 발생했습니다.';

  @override
  String get newLabel => '신규';

  @override
  String get analyzingImage => '이미지 분석 중...';

  @override
  String get extractingChineseText => '중국어 텍스트 추출 중...';

  @override
  String get lookingUpVocabulary => '어휘 사전 검색 중...';

  @override
  String get dreamOfTheRedChamber => '홍루몽 (Dream of the Red Chamber)';

  @override
  String get journeyToTheWest => '서유기 (Journey to the West)';

  @override
  String get romanceOfTheThreeKingdoms => '삼국지연의 (Romance of the Three Kingdoms)';

  @override
  String get mingDynasty => '명나라';

  @override
  String get wuChengEn => '오승은';

  @override
  String get hundredChapters => '전 100회';

  @override
  String get volume1 => '제1권';

  @override
  String bookmarksCount(Object count) {
    return '북마크 ($count)';
  }

  @override
  String get noBookmarksYet => '아직 북마크가 없습니다. 북마크 아이콘을 탭하여 마음에 드는 구절을 저장하세요.';

  @override
  String get sinosparkIsNotResponding => 'SinoSpark가 응답하지 않습니다';

  @override
  String get closeApp => '앱 닫기';

  @override
  String get wait => '대기';

  @override
  String studioHdAllowance(Object hours) {
    return '스튜디오 HD: $hours시간';
  }

  @override
  String bookPercentRead(Object percent) {
    return '완독률 $percent%';
  }

  @override
  String chAbbreviation(Object number) {
    return '제$number장';
  }

  @override
  String booksAndAudiobooks(Object count) {
    return '$count권의 도서 및 오디오북';
  }

  @override
  String sentenceXOfY(Object current, Object total) {
    return '문장 $current / $total';
  }

  @override
  String chapterXOfY(Object current, Object total) {
    return '제$current장 / 총 $total장';
  }

  @override
  String get allLevels => '전체 급수';

  @override
  String get searchGradedMicroStories => '수준별 숏스토리 및 우화 검색...';

  @override
  String gradedStoriesAndMicroReads(Object count) {
    return '$count편의 수준별 스토리 및 일일 독해';
  }

  @override
  String get searchClassicalPoems => '고전 한시, 시인, 명구절 검색...';

  @override
  String classicalPoemsAndVerse(Object count) {
    return '$count편의 고전 한시 및 명구절';
  }

  @override
  String get browseAnyChineseWebsite => '실시간 단어 탭 사전, 병음 주석, 즉석 번역으로 모든 중국어 웹사이트를 탐색하세요.';

  @override
  String get completed => '완료';

  @override
  String get aiIsReading => 'AI가 분석하여 읽는 중...';

  @override
  String get bbcVerify => 'BBC Verify';

  @override
  String get hsk5AdvancedVal => 'HSK 5급 (고급)';

  @override
  String get hsk1Beginner => 'HSK 1급 (입문)';

  @override
  String get hsk4UpperInt => 'HSK 4급 (중상급)';

  @override
  String get extractAllUnknownWords => '모르는 단어를 새 플래시카드 덱으로 모두 추출';

  @override
  String get designCustomAiRoleplay => '나만의 맞춤형 AI 롤플레잉 회화 설계';

  @override
  String get practiceFlashcardVocabulary => '실전 대화에서 단어장 어휘 직접 활용하기';

  @override
  String get surpriseMe => '랜덤 추천 (서프라이즈)';

  @override
  String get rollCharacter => '랜덤 캐릭터 선택';

  @override
  String get historicalCostume => '사극 / 고장극';

  @override
  String get modernYouth => '현대물 & 청춘';

  @override
  String get fantasyMythology => '선협·판타지 & 신화';

  @override
  String get familyDrama => '가족 & 휴먼 드라마';

  @override
  String get fullVersion => '완전판';

  @override
  String episodesCount(Object count) {
    return '총 $count화';
  }

  @override
  String episodeLabel(Object number) {
    return '제$number화';
  }

  @override
  String get translating => '[ 번역 중... ]';

  @override
  String get engSub => '[한국어 자막]';

  @override
  String get standardVocabulary => '표준 어휘';

  @override
  String get characters => '글자';
}
