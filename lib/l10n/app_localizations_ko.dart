// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get originStoryChip => '📜 유래';

  @override
  String get ancientFormChip => '🏺 고대 자형';

  @override
  String get threeMoreWordsChip => '📖 단어 3개 더보기';

  @override
  String get wordFamilyChip => '🔗 어휘 그룹';

  @override
  String get idiomChip => '🀄 성어';

  @override
  String get proverbChip => '💬 속담';

  @override
  String get isThereAChineseIdiomFeaturingThisCharacter =>
      '이 한자가 들어간 중국 성어(成语)가 있나요?';

  @override
  String get strokeOrderChip => '✏️ 획순';

  @override
  String get calligraphyTipChip => '🎨 서예 팁';

  @override
  String get grammarNoteChip => '📝 문법 노트';

  @override
  String get similarWordsChip => '🔄 유의어';

  @override
  String get culturalNoteChip => '🏮 문화 노트';

  @override
  String get inMediaChip => '🀄 미디어 활용';

  @override
  String get radicalMeaningChip => '🧩 부수 의미';

  @override
  String get componentBreakdownChip => '🔍 구성 요소 분석';

  @override
  String get toneTipChip => '🎵 성조 팁';

  @override
  String get homophonesChip => '👯 동음이의어';

  @override
  String askMeAnythingAbout(String hanzi) {
    return '$hanzi에 대해 무엇이든 물어보세요...';
  }

  @override
  String aiTutorError(String error) {
    return 'AI 튜터 오류: $error';
  }

  @override
  String get aiTutorRateLimit => 'AI 튜터가 현재 응답하기 어렵습니다. 잠시 후 다시 시도해 주세요.';

  @override
  String get deleteAccount => '계정 삭제';

  @override
  String get deleteAccountSubtitle => '계정을 영구적으로 삭제합니다';

  @override
  String get deleteAccountTitle => '계정을 완전히 삭제하시겠습니까?';

  @override
  String get accountDataDeletedTitle => '계정 데이터가 삭제됩니다';

  @override
  String get accountDataDeletedBody =>
      'SinoSpark에 저장된 회원님의 로그인 계정 및 모든 계정 정보가 영구적으로 삭제됩니다. 이 작업은 실행 취소할 수 없습니다.';

  @override
  String get localDataKeptTitle => '이 기기의 데이터는 유지됩니다';

  @override
  String get localDataKeptBody =>
      '이 기기에만 로컬 저장된 학습 진행도, 다운로드한 콘텐츠 및 환경설정은 삭제되지 않습니다.';

  @override
  String get subscriptionNotCanceledTitle => '구독은 자동으로 취소되지 않습니다';

  @override
  String get subscriptionNotCanceledBody =>
      '계정을 삭제해도 App Store 구독은 자동으로 취소되지 않습니다. Apple 설정에서 직접 구독을 취소하지 않으면 정기 결제가 계속될 수 있습니다.';

  @override
  String get manageSubscription => 'App Store 구독 관리';

  @override
  String get subscriptionManagementFailed =>
      'Apple 구독 관리 화면을 열 수 없습니다. \'설정\' > \'사용자 이름\' > \'구독\'에서 직접 관리해 주세요.';

  @override
  String get confirmPassword => '현재 비밀번호';

  @override
  String get confirmPasswordToDelete => '본인 확인을 위해 비밀번호를 입력해 주세요.';

  @override
  String get deleteAccountPermanently => '계정 영구 삭제';

  @override
  String get deleteAccountFinalTitle => '최종 확인';

  @override
  String get deleteAccountFinalWarning =>
      '계정이 영구적으로 삭제되며 되돌릴 수 없습니다. 이 기기에만 저장된 데이터는 유지됩니다. 계속하시겠습니까?';

  @override
  String get deletingAccount => '계정 삭제 중...';

  @override
  String get accountPasswordRequired => '계속하려면 현재 비밀번호를 입력해 주세요.';

  @override
  String get accountPasswordIncorrect => '비밀번호가 올바르지 않습니다. 다시 시도해 주세요.';

  @override
  String get accountReauthenticationCanceled =>
      '본인 확인이 취소되었습니다. 계정이 삭제되지 않았습니다.';

  @override
  String get accountReauthenticationFailed =>
      '본인 확인에 실패했습니다. 다시 시도하여 로그인 절차를 완료해 주세요.';

  @override
  String get accountAlreadySignedOut => '이미 로그아웃되었습니다. 삭제된 로그인 계정이 없습니다.';

  @override
  String get accountProviderUnsupported =>
      '해당 로그인 방식은 앱 내에서 확인할 수 없습니다. 계정 삭제 지원을 위해 고객센터에 문의해 주세요.';

  @override
  String get appleDeletionRequiresAppleDevice =>
      '보안을 위해 Apple 연동 계정은 Apple 기기에서 삭제해야 합니다.';

  @override
  String get accountDeletionNetworkError => '인터넷 연결을 확인한 후 계정 삭제를 다시 시도해 주세요.';

  @override
  String get accountDeletionFailed =>
      '계정을 삭제하지 못했습니다. 계정은 활성 상태로 유지됩니다. 다시 시도해 주세요.';

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
  String get selectAScenarioTo =>
      '시나리오를 선택하여 중국어 회화를 연습하세요. AI 학자가 성조와 명확도를 평가합니다.';

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
  String get couldNotLoadAi =>
      'AI 콘텐츠를 불러오지 못했습니다 (요청 한도 초과 또는 네트워크 오류).\n아래 새로고침 버튼을 탭하여 다시 시도해 주세요.';

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
  String get masteringRadicalsIsThe =>
      '부수를 마스터하는 것은 수천 개의 한자를 익히는 열쇠입니다. 부수를 선택하여 해당 부수가 쓰인 모든 한자를 확인하세요.';

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
  String get pleaseDoublecheckTheAis =>
      '생성된 AI 내용을 확인하세요. 영구 서재에 저장하기 전에 병음이나 뜻을 자유롭게 수정할 수 있습니다.';

  @override
  String get alreadyInYourLibrary => '이미 라이브러리에 있습니다!';

  @override
  String get meaningInContext => '문맥 속 의미';

  @override
  String get explainGrammar => '문법 설명';

  @override
  String get addToLibrary => '라이브러리에 추가';

  @override
  String get masterYourMandarinPronunciation =>
      '원어민의 억양과 발음을 실시간으로 따라 하며 중국어 발음을 완벽하게 마스터하세요.';

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
  String get realtimeBidirectionalTranslationSpeak =>
      '실시간 양방향 번역. 한국어 또는 중국어로 말하면 대화 상대에게 즉시 번역됩니다.';

  @override
  String get text_1782026184665 => '녹음 중';

  @override
  String get recording => '녹음 중';

  @override
  String get yourSilentCompanionListen =>
      '든든한 언어 파트너. 중국어 음성을 들으면 한국어 번역이 화면에 실시간으로 표시됩니다.';

  @override
  String get startListening => '듣기 시작';

  @override
  String get skip => '건너뛰기';

  @override
  String get independentStars => '독체자 (독립 한자)';

  @override
  String get notEveryCharacterHas =>
      '모든 한자가 특정 부수에서 파생된 것은 아닙니다. 일부는 독립적인 상형 문자이거나 단독으로 구성됩니다.';

  @override
  String get onTheMapWe => '지도에서 이러한 독립 한자들을 \'별자리(✨)\'로 분류해 두었습니다.';

  @override
  String get iUnderstand => '이해했습니다';

  @override
  String get whatAreRadicals => '부수란 무엇인가요?';

  @override
  String get hanziAreBuiltFrom =>
      '한자는 \'부수\'라고 불리는 기본 구성 요소로 이루어져 있습니다.\n\n부수는 한자의 핵심 의미나 주제를 결정합니다.';

  @override
  String get continueText => '계속하기';

  @override
  String get hanziAreNotJust =>
      '한자는 단순한 글자가 아니라, 시간이 빚어낸 그림입니다.\n\n한자를 마스터하려면 붓의 흐름과 획을 익혀야 합니다.';

  @override
  String get iAmReady => '준비 완료';

  @override
  String get youAreAScholar => '당신은 탐구하는 학자입니다';

  @override
  String get theGalaxyMapAwaitsnmaster =>
      '은하 지도가 기다리고 있습니다.\n태양(부수)을 마스터하여 행성(한자)을 해제하세요.';

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
  String get unlockTheFullPotential =>
      '학습의 잠재력을 무한히 펼쳐보세요. 한 번의 구매로 평생 소장할 수 있습니다.';

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
  String get whetherYouveFoundA =>
      '버그 제보, 기능 요청, 간단한 인사 등 여러분의 피드백은 SinoSpark 발전에 큰 힘이 됩니다.';

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
  String get studySession => '학습 세션';

  @override
  String get readyToStudy => '학습 준비 완료';

  @override
  String get studyQueuePreviewDescription => '오늘의 일정과 덱 제한을 바탕으로 세션이 구성됩니다.';

  @override
  String get notNow => '나중에';

  @override
  String get newLabel => '신규';

  @override
  String get studyDeckEmpty => '이 덱은 비어 있습니다';

  @override
  String get studyDeckEmptyDescription => '학습 세션을 시작하기 전에 카드를 추가해 주세요.';

  @override
  String get studyDailyLimitReached => '오늘의 학습 분량 완료';

  @override
  String get studyDailyLimitReachedDescription =>
      '오늘 이 덱에서 할당된 새 카드 및 복습 카드를 모두 마쳤습니다.';

  @override
  String get studyCaughtUpDescription => '오늘 예정된 학습이 없습니다. 다음 복습 때 다시 찾아와 주세요.';

  @override
  String get noCardsAvailable => '학습할 카드 없음';

  @override
  String get studyNoEligibleCardsDescription => '현재 이 학습 모드에 적합한 카드가 없습니다.';

  @override
  String get studySessionLoadFailed => '학습 세션을 불러올 수 없습니다. 다시 시도해 주세요.';

  @override
  String get retryLimitReached => '이 카드는 다음 세션에 다시 등장합니다.';

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
  String get masterLinGreeting =>
      '어서 오너라. 묵향이 준비되었으니, 오늘은 어떤 글자나 표현을 함께 탐구해 볼까?';

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
    return '$target에 추가';
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
  String get warringStates => '전국시대';

  @override
  String get hanFeiLegalism =>
      '한비(기원전 약 280년~기원전 233년)는 한나라의 공자이자 중국 법가 사상을 대표하는 사상가였다. 법, 통치 기술, 권위의 개념을 모아 정리한 그의 저서 《한비자》는 중국 제국 시대의 정치 철학과 제도에 지대한 영향을 미쳤다.';

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
  String get auntieMaTown =>
      '마 이모(马阿姨): 활기찬 성격의 노점상 주인. 마을에서 가장 바삭한 로우자모(肉夹馍)와 량피(凉皮)의 달인.';

  @override
  String get back => '뒤로';

  @override
  String get baristaKevinNotes =>
      '바리스타 샤오카이(小凯): 윈난산 스페셜티 원두의 풍미와 아로마에 열정적인 청년 로스터.';

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
  String get caoXueqinDecline =>
      '조설근(曹雪芹, 약 1715~1763)은 청나라의 소설가입니다. 한때 명문 귀족이었으나 옹정제 시기 몰락한 가문 출신으로, 가난한 말년에 집필한 《홍루몽》은 귀족 사회의 쇠락을 치밀한 심리 묘사로 그려낸 중국 고전문학의 독보적 금자탑입니다.';

  @override
  String get cardsTitle => '카드';

  @override
  String get cc => '자막 (CC)';

  @override
  String get characterOrWord => '한자 / 단어';

  @override
  String get chatMore => '대화 계속하기';

  @override
  String get chefChenShumai =>
      '천 셰프(陈师傅): 신선한 하가우(새우 딤섬)와 샤오마이를 추천하는 유쾌한 광둥 딤섬 장인.';

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
  String get egFormalBusinessLanguageSlangForTexting =>
      '예: 격식 있는 비즈니스 표현, 메신저 신조어...';

  @override
  String get egOrderingAtARestaurantBusinessVocab =>
      '예: 식당에서 주문하기, 비즈니스 실무 어휘...';

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
  String get firebaseAuthConsole =>
      'Firebase 인증이 활성화되지 않았습니다. Firebase 콘솔에서 로그인 방식을 활성화해 주세요.';

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
  String get grandmaLiuFilling =>
      '류 할머니(刘奶奶): 물만두 예쁘게 빚는 법과 돼지고기 파 속 만드는 비법을 알려주는 정 많은 북방 할머니.';

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
  String get ifTheAgain =>
      '전사 내용이 실제로 말한 내용과 다르면 의도한 문장을 선택한 뒤 “예, 다시 채점해 주세요!”를 탭하세요. 다시 말하지 않아도 원래 녹음을 재평가할 수 있습니다.';

  @override
  String get install => '설치';

  @override
  String get just => '단 \$';

  @override
  String get keyword => '키워드';

  @override
  String get knowledgeBase => '지식 베이스';

  @override
  String get liRuzhenSubjects =>
      '이여진(李汝珍, 약 1763~1830)은 음운학, 바둑, 천문학에 조예가 깊었던 청나라 학자입니다. 기상천외한 나라들을 여행하는 상인의 이야기를 담은 환상 소설 《경화연(鏡花緣)》은 시대를 앞선 페미니즘적 문제의식과 백과사전적 박학다식함으로 높은 평가를 받습니다.';

  @override
  String get libraryLabel => '서재';

  @override
  String get lifestyleAndVlog => '라이프스타일 및 브이로그';

  @override
  String get listenInAudiobookMode => '오디오북 모드로 듣기';

  @override
  String get listenToThisWord => '이 단어 발음 듣기';

  @override
  String get listening => '듣는 중...';

  @override
  String get liuEEncroachment =>
      '유악(劉鶚, 1857~1909)은 엔지니어, 의사, 소설가로 활약한 청말의 박식가입니다. 유일한 소설 《노잔유기(老殘遊記)》는 왕조의 몰락과 외세의 침탈 속에서 고통받는 중국을 순회하는 방랑 의사의 여정을 서정적이면서도 날카로운 비판 의식으로 담아낸 명작입니다.';

  @override
  String get loadingTranslations => '번역을 불러오는 중...';

  @override
  String get luXunVernacular =>
      '루쉰(魯迅, 1881~1936, 본명 저우수런)은 중국 현대 문학의 아버지입니다. 국민의 정신을 일깨우기 위해 의학을 버리고 문필가가 되었으며, 《광인일기》와 《아Q정전》 등의 소설을 통해 백화문 문학 혁명을 이끌었습니다.';

  @override
  String get luoGuanzhongEpic =>
      '나관중(羅貫中, 약 1330~1400)은 원말명초의 극작가이자 소설가로, 시내암에게 수학한 것으로 전해집니다. 정사와 민간 설화, 극적 서사를 집대성한 그의 대작 《삼국지연의(三國志演義)》는 중국 역사 서사 문학의 최고봉으로 꼽힙니다.';

  @override
  String get makeACustomCollection => '나만의 맞춤 단어장 만들기';

  @override
  String get manageDailyDropsAndReviewReminders => '일일 학습 및 복습 알림 관리';

  @override
  String get managerYuOptions =>
      '위 매니저(余店长): 천엽, 오리 선지, 담백한 백탕 육수 등 인기 메뉴를 센스 있게 추천하는 열정적인 훠궈 전문점 지배인.';

  @override
  String get masterGaoRubs =>
      '가오 사부(高师傅): 숯불 꼬치구이의 달인. 손님들과 맵기 조절과 비법 쯔란 가루에 대해 유쾌하게 이야기를 나눕니다.';

  @override
  String get masterThisToUnlockItsGalaxy => '이 요소를 마스터하여 은하 맵을 잠금 해제하세요.';

  @override
  String get masterZhaoBrewing =>
      '자오 사부(赵师傅): 다도에 조예가 깊은 차(茶) 전문가. 전통 궁푸차(工夫茶) 우려내는 법을 친절하게 전수합니다.';

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
  String get orderingSugarcoatedHawsInWinterBeijing =>
      '겨울철 베이징에서 탕후루(산사나무 열매 사탕) 사 먹기';

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
  String get play => '발음 재생 )';

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
  String get aiDataPrivacyTitle => 'AI 데이터 및 개인정보 보호';

  @override
  String get aiDataPrivacySettingsSubtitle =>
      'AI 기능이 데이터를 전송하는 항목, 이유 및 대상을 확인하세요';

  @override
  String get aiDataPrivacyOverviewTitle => 'AI 사용 시점';

  @override
  String get aiDataPrivacyOverviewBody =>
      'SinoSpark는 AI 채팅, 설명, 번역, 이미지 분석, 음성 인식, 발음 평가, 클라우드 음성과 같이 필요한 기능을 선택할 때만 클라우드 AI를 사용합니다. AI 결과는 부정확할 수 있으므로 중요한 내용은 직접 확인하세요.';

  @override
  String get aiDataPrivacyProvidersTitle => 'AI 서비스 제공업체';

  @override
  String get aiDataPrivacyProvidersBody =>
      'Google Gemini는 생성형 텍스트 및 이미지 요청을 처리합니다. OpenRouter는 일부 생성형 요청을 Google Gemini 또는 DeepSeek로 전달합니다. Microsoft Azure AI Speech는 음성 인식, 발음 평가 및 클라우드 음성 합성용 텍스트를 처리합니다.';

  @override
  String get aiDataPrivacySentTitle => '전송될 수 있는 데이터';

  @override
  String get aiDataPrivacySentBody =>
      '기능에 따라 입력하거나 선택한 텍스트, 관련 대화/학습 맥락, AI 분석용 이미지, 제출한 음성 녹음, IP 주소 및 기기/네트워크 메타데이터 등 기술적 요청 데이터를 전송합니다. AI 프롬프트에 사용자의 이름이나 이메일을 의도적으로 포함하지 않습니다.';

  @override
  String get aiDataPrivacyControlsTitle => '사용자 선택권';

  @override
  String get aiDataPrivacyControlsBody =>
      '해당 제공업체에 데이터가 전송되는 것을 원하지 않는 경우 AI 기능을 사용하지 마세요. 기기 설정에서 카메라, 사진 또는 마이크 권한을 거부할 수 있습니다. 텍스트 음성 변환을 기기 내에서 처리하려면 \'로컬 음성\'을 선택하세요. 민감하거나 기밀인 정보는 제출하지 마세요.';

  @override
  String get aiDataPrivacyRetentionTitle => '저장 및 보관 기간';

  @override
  String get aiDataPrivacyRetentionBody =>
      'SinoSpark는 처리 완료 후 원본 AI 프롬프트, 제출된 이미지, 음성 녹음을 자체 서버에 의도적으로 저장하지 않습니다. 생성된 결과는 사용자가 저장을 선택할 때 기기나 계정에 저장될 수 있습니다. 제공업체는 자체 약관 및 보관 설정에 따라 데이터를 처리합니다. 자세한 내용은 전체 처리방침을 확인하세요.';

  @override
  String get readFullPrivacyPolicy => '전체 개인정보 처리방침 읽기';

  @override
  String get linkOpenFailed => '링크를 열 수 없습니다. 다시 시도해 주세요.';

  @override
  String get puSonglingLiterature =>
      '포송령(蒲松齡, 1640~1715)은 과거 시험에 거듭 낙방한 후 평생에 걸쳐 민간 설화를 수집해 《요재지이(聊齋志異)》를 완성한 청나라의 문인입니다. 여우 요괴, 귀신, 선비가 등장하는 그의 기이한 이야기들은 동양 기이 문학의 최고 걸작으로 손꼽힙니다.';

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
  String get shiNaianEpic =>
      '시내암(施耐庵, 약 1296~1372)은 과거에 급제했으나 관직을 버리고 은둔의 길을 택한 원말명초의 문인입니다. 의로운 호걸들의 반란과 활약을 그린 그의 걸작 《수호전(水滸傳)》은 중국 무협 군상극의 효시가 되었습니다.';

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
  String get theGalaxyCharacters =>
      '은하 지도가 기다리고 있습니다.\n태양(부수)을 마스터하여 행성(한자)을 해제하세요.';

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
  String get whatIfAiMishears => 'AI가 제 말을 잘못 해석하면 어떻게 하나요?';

  @override
  String get whichCharacterIs => '다음 설명에 해당하는 글자는 무엇인가요:';

  @override
  String get wikipedia => '위키백과';

  @override
  String get wordsSavedAndSrsScheduled => '단어가 저장되고 SRS 복습 주기가 등록되었습니다!';

  @override
  String get writeYourMessageHere => '여기에 메시지를 작성하세요...';

  @override
  String get wuChengenLiterature =>
      '오승은(吳承恩, 약 1500~1582)은 장쑤성 화이안 출신의 명나라 소설가입니다. 오랜 세월 전해 내려온 민간 설화, 불교적 우화, 번뜩이는 풍자 정신을 결합하여 현장 법사의 인도 순례 설화를 대작 《서유기(西遊記)》로 승화시켰습니다.';

  @override
  String get wuJingziClass =>
      '오경재(吳敬梓, 1701~1754)는 안후이성 출신의 청나라 소설가입니다. 물려받은 가산을 털어 평생을 《유림외사(儒林外史)》 집필에 바쳤으며, 과거 시험의 폐해와 사대부 계층의 위선과 부패를 신랄하게 풍자했습니다.';

  @override
  String get xuZhonglinWarfare =>
      '허중림(許仲琳, 16~17세기 활동)은 명나라의 문인으로, 대작 신마 소설 《봉신연의(封神演義)》의 편찬자로 널리 알려져 있습니다. 은주 교체기의 역사에 도교의 신선 사상과 천상계의 전투를 화려하게 엮어낸 고전입니다.';

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
  String get yourEchoModels =>
      '저장한 롤플레잉 대화 기록은 나중에 복습할 수 있도록 기기에 로컬로 보관됩니다. 개인 대화를 AI 모델 학습에 사용하지 않습니다.';

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
  String get analyzing_pronunciation_with_gemini_ai =>
      'Gemini AI로 발음을 분석하는 중...';

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
  String get audio_could_not_start_check_your =>
      '오디오를 시작할 수 없습니다. 인터넷 연결과 기기의 오디오 설정을 확인하세요.';

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
  String get no_when_you_use_echo_hall =>
      '발음 평가를 위해 제출한 녹음은 안전하게 처리되며 처리가 끝난 뒤 SinoSpark가 보관하지 않습니다. 저장하도록 선택한 롤플레잉 기록은 기기에 남을 수 있으며 앱에서 삭제할 수 있습니다.';

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
  String get shadowing_studio_is_a_dedicated_space =>
      '섀도잉 스튜디오는 원어민의 음성을 실시간으로 따라 하며 자연스러운 억양과 발음을 익히는 전용 훈련 공간입니다.';

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
  String get the_ai_evaluates_your_speech_across =>
      'AI가 다음 3가지 요소를 종합 평가합니다:\n• 정확도: 각 음절을 올바르게 발음했는가\n• 완성도: 누락되거나 건너뛴 단어가 없는가\n• 유창성: 자연스러운 호흡과 올바른 성조로 발화했는가\n원어민 발음 모델과 비교하여 100점 만점으로 점수를 환산합니다.';

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
  String get unable_to_open_this_video_please =>
      '이 동영상을 열 수 없습니다. 잠시 후 다시 시도해 주세요.';

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
  String get unableToLoadThisSectionPleaseTryAga =>
      '이 섹션을 불러올 수 없습니다. 다시 시도해 주세요.';

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
  String get defaultfirebaseoptionsHaveNotBeenCo =>
      'DefaultFirebaseOptions가 Linux용으로 구성되지 않았습니다.';

  @override
  String get defaultfirebaseoptionsAreNotSupport =>
      '이 플랫폼에서는 DefaultFirebaseOptions가 지원되지 않습니다.';

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
  String get xmicrosoftoutputformatAudio24khz48k =>
      'audio-24khz-48kbitrate-mono-mp3';

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
  String get theEchoHallRemainsSilentTryYourBrea =>
      '에코 홀이 고요합니다. 숨을 가다듬고 다시 시도해 보세요.';

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
  String get importantRuleDoNotAddressTheUserByA =>
      '중요 규칙: 사용자를 임의의 이름으로 부르지 마세요. 다음과 같은 플레이스홀더 이름은 절대 사용 금지입니다:';

  @override
  String get youAreAConciseChineseCalligraphyAnd =>
      '당신은 플래시카드 앱 내에서 중국어 서예와 자원(字源)을 명쾌하게 가르쳐 주는 튜터입니다.';

  @override
  String get theStudentIsStudyingTheCharacter => '학생이 학습 중인 한자:';

  @override
  String get neverWriteIntroductionsSignoffsOrFi =>
      '서론, 맺음말 또는 불필요한 군더더기 표현을 절대 작성하지 마세요.';

  @override
  String get beDirectAndInformative => '간결하고 유익하게 설명하세요.';

  @override
  String get criticalRuleYouMustRespondEntirelyI =>
      '중요 규칙: 지정된 ISO 639-1 언어 코드로만 답변해야 합니다.';

  @override
  String get youAreAConciseChineseGrammarTutorIn =>
      '당신은 모바일 앱 내에서 중국어 문법을 핵심만 명쾌하게 가르쳐 주는 튜터입니다.';

  @override
  String get theStudentIsConfusedAboutTheWord => '학생이 헷갈려하는 단어:';

  @override
  String get neverWriteIntroductionsSignoffsOrFi1 =>
      '서론, 맺음말 또는 불필요한 미사여구를 절대 작성하지 마세요.';

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
  String get weCouldntHearYouClearlyPleaseTryAga =>
      '음성이 선명하게 들리지 않았습니다. 다시 말씀해 주세요.';

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
  String get greatJobAFewMinorToneInaccuracies =>
      '아주 잘하셨어요! 성조에 아주 미세한 오차가 있을 뿐입니다.';

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
  String get noCoherentChineseTextFoundInTheScan =>
      '스캔 이미지에서 유효한 중국어 텍스트를 찾을 수 없습니다.';

  @override
  String get theFullEnglishTranslationOfTheScann =>
      '스캔된 텍스트의 전체 한국어 번역... 또는 \'유효한 중국어 텍스트를 찾을 수 없습니다.\'';

  @override
  String get aShort24WordTitleForThisScanEgResta =>
      '이 스캔에 대한 2~4단어의 짧은 제목 (예: \'식당 메뉴판\', \'도로 표지판\')';

  @override
  String get china => '중국';

  @override
  String get noTranslationAvailable => '번역을 사용할 수 없습니다.';

  @override
  String get scanResults => '스캔 결과';

  @override
  String get whenWasItWrittenAndWhatWasHappening =>
      '언제 쓰였으며, 당시 중국에서는 어떤 역사적 사건이 있었나요?';

  @override
  String get whyIsThisPieceFamousWhatPhilosophic =>
      '이 작품이 유명한 이유는 무엇이며, 어떤 철학적·문화적 주제를 다루나요?';

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
  String get comeReviewYourHanziAndTryALiveCallB =>
      '무료 이용 기간이 끝나기 전에 한자를 복습하고 라이브 통화를 체험해 보세요!';

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
  String get keepYourPitchHighAndSteadyLikeSingi =>
      '노래하듯 높은 음을 평평하고 일정하게 유지하세요.';

  @override
  String get startInTheMiddleAndSlideYourPitchUp =>
      '중간 음높이에서 시작해 \'뭐?\'라고 되묻듯 위로 올리세요.';

  @override
  String get dipYourVoiceDownLowThenRiseGentlyBa => '목소리를 낮게 내렸다가 부드럽게 끌어올리세요.';

  @override
  String get dropYourPitchSharplyAndDecisivelyLi =>
      '단호하게 \'안 돼!\'라고 외치듯 높음에서 아래로 날카롭게 내리꽂으세요.';

  @override
  String get pronounceSoftlyBrieflyAndWithoutEmp => '힘을 빼고 짧고 가볍게 얹듯이 발음하세요.';

  @override
  String get spotOnPitchWasHighFlatAndSteady =>
      '완벽합니다! 음높이가 높고 평평하게 잘 유지되었습니다.';

  @override
  String get spotOnUpwardPitchRiseWasClear =>
      '완벽합니다! 아래에서 위로 치고 올라가는 소리가 명확했습니다.';

  @override
  String get spotOnLowDippingCurveWasAccurate =>
      '완벽합니다! 저음으로 꺾였다가 올라가는 굴곡이 정확했습니다.';

  @override
  String get spotOnSharpFallingDropWasDecisive =>
      '완벽합니다! 단호하게 떨어지는 하강음이 명확했습니다.';

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
  String get ni3Hao3Huan1ying2Guang1lin2Qing3wen =>
      'Nǐ hǎo! Huānyíng guānglín. Qǐngwèn nǐ yào diǎn shénme?';

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
  String get ni3Qu4Na3rAJi1chang3MaTing3Yuan3De =>
      'Nǐ qù nǎr a? Jīchǎng ma? Tǐng yuǎn de!';

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
  String get thisClothingQualityIsEspeciallyGood =>
      '이 옷은 원단이 아주 좋은데, 200위안밖에 안 해요.';

  @override
  String get zhe4Jian4Yi1fuZhi4liang4Te4bie2Hao3 =>
      'Zhè jiàn yīfu zhìliàng tèbié hǎo, zhǐyào liǎng bǎi kuài.';

  @override
  String get auntieChen => '첸(陳) 이모';

  @override
  String get askHowMuchTheSilkShirtCosts => '실크 셔츠 가격 묻기';

  @override
  String get sayItIsTooExpensive => '너무 비싸다고 말하기';

  @override
  String get bargainThePriceDownTo100Rmb => '100위안으로 가격 흥정하기';

  @override
  String get ni3Na3li3Bu4Shu1fuFa1shao1LeMa =>
      'Nǐ nǎlǐ bù shūfu? Fāshāo le ma?';

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
  String get ni3Hao3Hao3jiu3Bu4jian4Ni3Zui4jin4Z =>
      'Nǐ hǎo! Hǎojiǔ bùjiàn, nǐ zuìjìn zěnmeyàng?';

  @override
  String get pleaseIntroduceYourselfWhyDoYouWant =>
      '간단한 자기소개와 함께 저희 회사에 지원한 동기를 말씀해 주세요.';

  @override
  String get qing3Xian1Zi4wo3Jie4shao4Yi1xia4Ni3 =>
      'Qǐng xiān zìwǒ jièshào yíxià. Nǐ wèishénme xiǎng lái wǒmen gōngsī gōngzuò?';

  @override
  String get managerLiu => '류(劉) 인사담당자';

  @override
  String get introduceYourProfessionalBackground => '자신의 전문 경력을 간략히 소개하기';

  @override
  String get explainWhyYouWantToWorkAtThisCompan => '지원 동기를 설명하기';

  @override
  String get askAPoliteQuestionAboutTheCompanyCu => '기업 문화에 대해 정중히 질문하기';

  @override
  String get microphoneAccessIsRequiredPleaseEna =>
      '마이크 접근 권한이 필요합니다. 기기 설정에서 활성화해 주세요.';

  @override
  String get couldNotStartMicrophonePleaseCheckY =>
      '마이크를 시작할 수 없습니다. 오디오 설정을 확인하고 다시 시도해 주세요.';

  @override
  String get weDidntQuiteCatchThatPleaseHoldTheM =>
      '음성을 잘 알아듣지 못했습니다. 마이크를 누른 상태에서 다시 말씀해 주세요!';

  @override
  String get recordingWasTooShortHoldTheMicAndSp =>
      '녹음 시간이 너무 짧습니다. 마이크를 길게 누르고 또렷하게 말씀해 주세요.';

  @override
  String get audioBufferWasEmptyPleaseCheckYourM =>
      '음성 버퍼가 비어 있습니다. 마이크 상태를 확인하고 다시 시도해 주세요.';

  @override
  String get audioFileIsSilentPleaseSpeakIntoThe =>
      '녹음된 음성이 없습니다. 마이크에 대고 말씀해 주세요.';

  @override
  String get weCouldntUnderstandYourPronunciatio =>
      '발음을 인식하지 못했습니다. 더 또렷하게 발음하고 다시 시도해 주세요.';

  @override
  String get theServerIsTakingTooLongToRespondPl =>
      '서버 응답이 지연되고 있습니다. 잠시 후 다시 시도해 주세요.';

  @override
  String get noInternetConnectionPleaseCheckYour =>
      '인터넷 연결이 끊겼습니다. 네트워크 환경을 확인하고 다시 시도해 주세요.';

  @override
  String get audioProcessingFailedPleaseTryAgain =>
      '오디오 처리에 실패했습니다. 다시 시도해 주세요.';

  @override
  String get permission => '권한';

  @override
  String get couldNotProcessYourRecordingPleaseT =>
      '녹음을 처리하지 못했습니다. 다시 시도해 주세요.';

  @override
  String get user => '사용자';

  @override
  String get scholar => '학자';

  @override
  String get ourAiTutorsAreCurrentlyOfflinePleas =>
      'AI 튜터가 현재 오프라인 상태입니다. 잠시 후 다시 시도해 주세요.';

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
  String get aQuietBambooCourtyardTeahouseInChen =>
      '은은한 고쟁 선율이 흐르는 청두의 고즈넉한 대나무 찻집.';

  @override
  String get aBustlingSmokyNightMarketFilledWith =>
      '양꼬치와 만두, 길거리 음식 노점으로 활기와 연기가 가득한 야시장.';

  @override
  String get aLivelyHotpotRestaurantInChongqingW =>
      '새빨간 육수가 끓어오르고 알싸한 고추 향이 진동하는 충칭의 활기찬 훠궈 전문점.';

  @override
  String get aBustlingTraditionalCantoneseTeahou =>
      '대나무 찜통에서 김이 피어오르는 광저우의 활기찬 전통 딤섬 찻집.';

  @override
  String get aChicMinimalistCafeInTheFrenchConce =>
      '비 내리는 일요일 오후, 프랑스 조계지의 세련되고 미니멀한 카페.';

  @override
  String get aWarmNorthernHomeKitchenDuringWinte =>
      '겨울철 밀가루 가루 날리는 식탁과 김 나는 만둣국이 있는 따뜻한 북방 가정집 주방.';

  @override
  String get anOpenairNightStreetFoodAlleyWithSi =>
      '지글거리는 양꼬치와 구운 가지, 시원한 맥주가 있는 야외 야시장 골목.';

  @override
  String get aSnowyStreetCornerOutsideTheLamaTem =>
      '눈 덮인 라마사(옹화궁) 문 앞, 얼음 위에 놓인 윤기 나는 빨간 탕후루 꼬치.';

  @override
  String get craftBeerBreweryInQingdao => '칭다오 수제 맥주 브루어리';

  @override
  String get aLivelyCoastalTaproomWithWoodenBarr =>
      '오크통과 시원한 바닷바람, 신선한 밀맥주가 있는 해변가 펍.';

  @override
  String get sichuanCookingMasterclass => '정통 사천요리 마스터클래스';

  @override
  String get aVibrantOpenKitchenWithWoksBlazingC =>
      '웍에서 불길이 솟구치고 고추기름이 끓어오르며 신선한 화자오 향이 가득한 활기찬 오픈 키친.';

  @override
  String get highspeedRailSeatMixup => '고속열차 좌석 혼동';

  @override
  String get greatWallSunriseTrekInMutianyu => '무톈위 만리장성 일출 트레킹';

  @override
  String get theAncientStoneRampartsOfTheGreatWa =>
      '안개 낀 푸른 산세에 둘러싸여 새벽빛을 머금은 만리장성의 고대 석조 성벽.';

  @override
  String get bambooRaftDriftOnGuilinLiRiver => '구이린 리강 대나무 뗏목 유람';

  @override
  String get glidingAlongEmeraldKarstWatersBetwe =>
      '양숴 인근, 물안개 자욱한 석회암 기암괴석 사이로 에메랄드빛 카르스트 수면을 미끄러지듯 나아가며.';

  @override
  String get silkRoadCamelTrekInDunhuang => '둔황 실크로드 낙타 트레킹';

  @override
  String get theRollingGoldenSandDunesOfMingshaM =>
      '월아천 오아시스 곁에 끝없이 펼쳐진 명사산의 굽이치는 황금빛 사구.';

  @override
  String get bookingACourtyardHomestayInDali => '다리 전통 안뜰 사합원 숙소 예약하기';

  @override
  String get aSereneBaistyleBoutiqueCourtyardHot =>
      '윈난성 얼하이호를 내려다보는 고즈넉한 바이족 양식의 부티크 안뜰 호텔.';

  @override
  String get potalaPalacePilgrimageInLhasa => '라싸 포탈라궁 순례';

  @override
  String get theMajesticSundrenchedStoneStepsOut =>
      '따스한 햇살이 내리쬐는 포탈라궁 앞 웅장한 돌계단과 돌아가는 마니차.';

  @override
  String get aSubzeroWonderlandOfIlluminatedCrys =>
      '화려한 조명으로 수놓인 얼음 궁전과 웅장한 눈 조각이 가득한 영하의 환상적인 얼음 왕국.';

  @override
  String get zhangjiajieAvatarMountainCableCar => '장자제 아바타 산 케이블카';

  @override
  String get suspendedHighInAGlassCableCarSoarin =>
      '수천 개의 웅장한 사암 석주 봉우리 위를 가로지르는 통유리 케이블카에 높이 올라.';

  @override
  String get gobiDesertStargazingCampInGansu => '간쑤성 고비 사막 은하수 별 관측 캠핑';

  @override
  String get aLuxuryYurtCampUnderACrystalclearMi =>
      '자위관 인근 사막, 맑고 청명한 밤하늘의 은하수 아래 펼쳐진 럭셔리 게르 캠프.';

  @override
  String get yangtzeRiverThreeGorgesCruise => '양쯔강 삼협(싼샤) 유람선 크루즈';

  @override
  String get onTheSunDeckOfARiverCruiseShipPassi =>
      '우뚝 솟은 웅장한 구당협(취탕샤)을 가로지르는 리버 크루즈선의 선데크에서.';

  @override
  String get buyingAntiquesInBeijingPanjiayuan => '베이징 판자위안 골동품 시장 탐방';

  @override
  String get aHistoricPotteryKilnFilledWithDelic =>
      '섬세한 미완성 백자 화병과 코발트블루 청화 유약이 가득한 유서 깊은 도자기 가마.';

  @override
  String get suzhouSilkEmbroideryStudio => '쑤저우 전통 비단 자수 공방';

  @override
  String get aPeacefulCanalsideGardenStudioInSuz =>
      '고운 비단실과 원목 자수 수틀이 놓인 쑤저우 수로 옆 한적한 정원 공방.';

  @override
  String get backstageAtATraditionalBeijingOpera =>
      '화려한 무대 의상, 화장대 거울, 정교한 머리 장식으로 가득한 전통 경극 분장실.';

  @override
  String get traditionalChineseMedicineConsultat => '중의학(한의학) 진료 상담';

  @override
  String get morningTaiChiInTempleOfHeavenPark => '천단공원에서의 아침 태극권 수련';

  @override
  String get beneathAncientCypressTreesAtDawnWit =>
      '새벽녘 울창한 측백나무 아래, 새들의 지저귐 속에 어르신들이 호흡을 맞춰 태극권을 수련하는 풍경.';

  @override
  String get rentingAHanfuForAPhotoShoot => '스냅 사진 촬영을 위한 한푸(전통 의상) 대여';

  @override
  String get aTraditionalCostumeBoutiqueNearTheW =>
      '서호 근처 당나라와 송나라 양식의 우아한 예복이 가득한 전통 의상점.';

  @override
  String get guqinAncientZitherInstrumentWorksho => '고금(구친, 전통 7현금) 공방 체험';

  @override
  String get aQuietPinewoodStudioInHangzhouFille =>
      '오래된 오동나무와 명주실 현악기로 가득 찬 항저우의 고즈넉한 소나무 공방.';

  @override
  String get shaanxiShadowPuppetTheater => '산시성 전통 그림자 인형극(피영희)';

  @override
  String get behindAnIlluminatedWhiteSilkScreenW =>
      '조명을 밝힌 하얀 비단 스크린 뒤편에서 섬세하게 조각된 반투명 소가죽 인형들이 춤추는 무대.';

  @override
  String get chineseCalligraphyWorkshop => '중국 전통 서예 워크숍';

  @override
  String get aTranquilStudioScentedWithPineSootI =>
      '송연묵의 그윽한 묵향, 선지 두루마리, 은은한 차 향기가 맴도는 고요한 서실.';

  @override
  String get adoptingACatAtAnAnimalShelter => '동물 보호소에서 고양이 입양하기';

  @override
  String get aCozyPetRescueCenterInHangzhouWithE =>
      '활발한 구조 아기 고양이들과 방문객을 위한 따뜻한 차가 준비된 항저우의 아늑한 동물 구조 센터.';

  @override
  String get scriptMurderMysteryJubenshaGame => '추리 롤플레잉 게임 (쥐번샤 / 剧本杀)';

  @override
  String get aThemedDetectiveLoungeInShanghaiWit =>
      '코스튬을 입은 플레이어들과 촛불이 은은하게 켜진 상하이의 테마 추리 라운지.';

  @override
  String get vintageVinylRecordShopInShanghai => '상하이 빈티지 바이닐 레코드 샵';

  @override
  String get aHiddenVinylStoreInAnOldLaneHousePa =>
      '80년대 클래식 홍콩 팝과 재즈 음반으로 가득한 오래된 스쿠먼 골목 안 숨은 LP 샵.';

  @override
  String get ktvKaraokePartyWithFriends => '친구들과 즐기는 KTV 노래방 파티';

  @override
  String get joiningACityBikeCyclingClub => '도심 자전거 라이딩 클럽 참가';

  @override
  String get aGatheringOfCyclistsByTheRiverfront =>
      '도심 스카이라인을 배경으로 야간 라이딩을 준비하는 강변의 라이더 모임.';

  @override
  String get blindBoxToyTradingMeetup => '블라인드 박스 아트토이 교환 모임';

  @override
  String get aColorfulPopcultureToyStoreInChaoya =>
      '전시 진열장과 미개봉 한정판 컬렉션이 가득한 차오양구의 다채로운 팝 컬처 토이 샵.';

  @override
  String get droneSkylineVideographyAtTheBund => '와이탄 도심 스카이라인 드론 항공 촬영';

  @override
  String get theBundPromenadeAtDuskOverlookingTh =>
      '푸둥의 미래지향적인 마천루 야경이 한눈에 내려다보이는 해 질 녘 와이탄 산책로.';

  @override
  String get goldenRetrieverCafeInNanjing => '난징 골든 리트리버 카페';

  @override
  String get aSunnyCheerfulPetCafeWithDozensOfFr =>
      '수십 마리의 순하고 사랑스러운 대형견들이 반갑게 맞아주는 햇살 가득한 애견 카페.';

  @override
  String get boulderingClimbingGymInChengdu => '청두 실내 볼더링 클라이밍 짐';

  @override
  String get aModernIndoorClimbingGymWithVibrant =>
      '알록달록한 홀드 루트와 신나는 음악이 흐르는 트렌디한 최신 실내 클라이밍 센터.';

  @override
  String get aMassiveConventionHallFilledWithCol =>
      '다채로운 게임 부스, 포토존, 코스프레 크리에이터들로 가득 찬 초대형 컨벤션 홀.';

  @override
  String get askingForDirectionsInABeijingHutong => '베이징 후퉁 골목에서 길 묻기';

  @override
  String get aMazeOfHistoricGreybrickAlleysWithB =>
      '자전거와 안뜰, 석류나무가 어우러진 역사적인 회색 벽돌 후퉁 골목의 미로.';

  @override
  String get buyingFreshFruitAtAWetMarket => '전통 재래시장에서 신선한 과일 사기';

  @override
  String get aLivelyMorningNeighborhoodMarketWit =>
      '싱싱한 리치, 망고, 용과가 수북이 쌓여 있는 활기 넘치는 아침 동네 청과 시장.';

  @override
  String get flowerMarketBouquetInKunming => '쿤밍 꽃 시장 꽃다발 고르기';

  @override
  String get theFamousDounanFlowerMarketSurround =>
      '수만 송이의 싱싱한 장미, 백합, 유칼립투스 향기로 가득 찬 아시아 최대의 더우난 꽃 시장.';

  @override
  String get tailorAlterationsInAnOldLaneHouse => '골목길 옛 가옥의 전통 수선집';

  @override
  String get aTraditionalTailorShopFilledWithSew =>
      '재봉틀, 원단 두루마리, 줄자가 가득한 정겨운 전통 양복 수선점.';

  @override
  String get expressParcelLockerRetrieval => '스마트 무인 택배함에서 택배 찾기';

  @override
  String get downstairsAtAResidentialApartmentGa =>
      '아파트 정문 1층, 하이브 박스(Hive Box) 스마트 무인 택배함 앞.';

  @override
  String get bicycleFlatTireRepairAtCampusGate => '대학교 정문 앞 자전거 펑크 수리';

  @override
  String get aSmallOutdoorRoadsideToolkitStandUn =>
      '우거진 벵골보리수 나무 그늘 아래 자리 잡은 소박한 길거리 수리 노점.';

  @override
  String get techCompanyProductDemo => 'IT 테크 기업 신제품 데모 시연';

  @override
  String get aFuturisticTechConferenceBoothInShe =>
      '최첨단 AI 하드웨어를 선보이는 선전의 미래지향적인 테크 컨퍼런스 부스.';

  @override
  String get ecommerceLivestreamStudio => '라이브 커머스(생방송 판매) 스튜디오';

  @override
  String get aHighenergyBroadcastStudioWithRingL =>
      '링 라이트 조명, 제품 진열대, 실시간 반응 모니터가 갖춰진 열기 넘치는 방송 스튜디오.';

  @override
  String get yiwuInternationalTradeMarket => '이우(Yiwu) 국제 상무성';

  @override
  String get aVastMultistoryCommercialExhibition =>
      '수백만 종의 도매 공산품과 공예품이 끝없이 늘어선 거대한 다층 무역 전시관.';

  @override
  String get universityCampusExchangeProgram => '대학교 캠퍼스 교환학생 프로그램';

  @override
  String get aSunnyLawnOutsideTheUniversityLibra =>
      '학생들이 삼삼오오 모여 공부하고 밀크티를 마시는 대학 도서관 앞 잔디밭.';

  @override
  String get pleaseEnterAScenarioTopic => '시나리오 주제를 입력해 주세요.';

  @override
  String get nameTitle => '이름 (호칭)';

  @override
  String get aiCharacter => 'AI 캐릭터';

  @override
  String get helloWelcomeHereWhatShallWeChatAbou =>
      '안녕하세요! 환영합니다. 오늘 어떤 주제로 대화를 나눠볼까요?';

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
  String get masterConversationalFluencyWith600W =>
      '600개 단어로 일상 회화를 유창하게 구사하세요.';

  @override
  String get readTextsAndConverseFluentlyWith120 =>
      '1,200개 단어로 글을 읽고 유창하게 소통하세요.';

  @override
  String get readNewspapersAndWatchMoviesWith250 =>
      '2,500개 단어로 신문을 읽고 영화를 감상하세요.';

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
  String get seeTheMeaningDrawTheCharacterFromMe =>
      '뜻을 보고 기억을 더듬어 직접 한자를 써보세요.';

  @override
  String get readOutLoudToTestYourPronunciationT => '소리 내어 읽으며 발음과 성조를 테스트하세요.';

  @override
  String get listenToTheAudioAndIdentifyTheChara => '음성을 듣고 알맞은 한자를 찾아보세요.';

  @override
  String get contract => '인터페이스 명세';

  @override
  String get whoeverImplementsMeMustBeAbleToDoTh =>
      '이 인터페이스를 구현하는 모든 클래스는 다음 기능을 제공해야 합니다.';

  @override
  String get koreFenrirCharonAoedePuckOrLocal =>
      'Kore, Fenrir, Charon, Aoede, Puck 또는 기기 로컬 음성';

  @override
  String get manageDecks => '덱 관리';

  @override
  String get weRanIntoTroubleLoadingTheLibraryPl =>
      '라이브러리를 불러오는 중 문제가 발생했습니다. 다시 시도해 주세요.';

  @override
  String get noCharactersInLexicon1 => '어휘장에 등록된 한자가 없습니다';

  @override
  String get masterTheBuildingBlocks => '한자의 기본 부수를 마스터하세요';

  @override
  String get other => '기타';

  @override
  String get requiredLabel => '필수';

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
  String get canYouGiveMeTwoMoreExamplesUsingThi =>
      '이 단어를 사용한 예문을 2개 더 알려주실 수 있나요?';

  @override
  String get whatAreSomeSimilarWordsAndHowDoThey =>
      '유사한 단어에는 무엇이 있으며, 뉘앙스는 어떻게 다른가요?';

  @override
  String get isThisWordUsedInSpokenOrWrittenChin =>
      '이 단어는 구어체와 문어체 중 어디에 더 자주 쓰이나요?';

  @override
  String get areThereOtherWaysToTranslateThisWor =>
      '이 단어를 번역할 수 있는 다른 표현이 있나요?';

  @override
  String get whatAreCommonWordsThatGoTogetherWit =>
      '이 단어와 함께 자주 결합하는 연어(콜로케이션)는 무엇인가요?';

  @override
  String get whatAreCommonMistakesLearnersMakeWi =>
      '학습자들이 이 단어를 쓸 때 가장 자주 범하는 실수는 무엇인가요?';

  @override
  String get emptyResponse => '응답이 없습니다';

  @override
  String get whatIsTheOracleBoneScriptOriginOfTh =>
      '이 한자의 갑골문 기원과 자원(字源)은 무엇인가요?';

  @override
  String get howDidTheAncientFormOfThisCharacter =>
      '이 한자의 고대 자형은 세월에 따라 어떻게 변천되었나요?';

  @override
  String get giveMe3CommonWordsThatContainThisCh =>
      '이 한자가 포함된 대표적인 단어 3개를 알려주세요.';

  @override
  String get whatOtherCharactersShareTheSameRadi =>
      '이 한자와 같은 부수를 사용하는 다른 한자에는 무엇이 있나요?';

  @override
  String get isThereAChineseProverbOrSayingFeatu =>
      '이 한자가 들어간 중국 속담이나 사자성어가 있나요?';

  @override
  String get explainTheStrokeOrderRulesForThisCh => '이 한자의 필순(획순) 규칙을 설명해 주세요.';

  @override
  String get giveMeOneCalligraphyTipForWritingTh =>
      '이 한자를 균형감 있게 잘 쓰기 위한 서예 팁을 알려주세요.';

  @override
  String get isThereAnythingTrickyAboutUsingThis =>
      '이 단어를 문법적으로 활용할 때 유의할 점이 있나요?';

  @override
  String get whatWordsAreCommonlyConfusedWithThi =>
      '이 단어와 헷갈리기 쉬운 단어는 무엇이며, 이유는 무엇인가요?';

  @override
  String get doesThisCharacterCarryCulturalSymbo =>
      '이 한자는 중국 문화에서 특별한 상징적 의미가 있나요?';

  @override
  String get isThisCharacterCommonlySeenInChines =>
      '이 한자는 현대 중국의 영화, 노래, 문학에서 자주 쓰이나요?';

  @override
  String get whatDoesTheRadicalOfThisCharacterMe =>
      '이 한자의 부수는 어떤 고유한 의미를 나타내나요?';

  @override
  String get breakDownEveryComponentAndItsMeanin =>
      '글자의 각 구성 요소를 분해하여 그 뜻을 설명해 주세요.';

  @override
  String get giveMeATrickToRememberTheCorrectTon =>
      '이 한자의 성조를 쉽게 외울 수 있는 암기 팁을 알려주세요.';

  @override
  String get areThereCommonHomophonesThatAreOfte =>
      '발음이 같아 혼동하기 쉬운 동음이의어가 있나요?';

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
  String get microphonePermissionDeniedEnableItI =>
      '마이크 권한이 거부되었습니다. 섀도잉 스튜디오를 사용하려면 기기 설정에서 활성화해 주세요.';

  @override
  String get sessionSummary => '세션 학습 요약';

  @override
  String get hereAreTheCharactersYouStruggledWit => '이번 세션에서 어려워했던 한자 목록입니다:';

  @override
  String get applySessionGradesToSpacedRepetitio =>
      '세션 채점 결과를 간격 반복 시스템(말하기 모드)에 반영';

  @override
  String get masterYourMandarinPronunciationnbyM =>
      '원어민 발음을 그림자처럼 따라 하며\n자연스러운 중국어 성조를 완성하세요.';

  @override
  String get aiIsGradingYourPronunciation => 'AI가 발음을 정밀 분석 중입니다...';

  @override
  String get holdMicToRecordReleaseToGrade => '마이크를 길게 누르고 말하세요. 손을 떼면 채점됩니다.';

  @override
  String get tapAnySyllableToAuditionAll4Tones => '음절을 탭하여 4가지 성조를 모두 들어보세요:';

  @override
  String get freeFlowConversationalPractice => '자유 대화형 실전 회화 연습';

  @override
  String get failedToGeneratePhrasePleaseTryAgai =>
      '문장 생성에 실패했습니다. 다시 시도해 주세요.';

  @override
  String get recordingTooShortHoldTheMicButtonLo =>
      '녹음이 너무 짧습니다. 마이크 버튼을 길게 누르고 말씀해 주세요.';

  @override
  String get recordingErrorPleaseTryAgain => '녹음 중 오류가 발생했습니다. 다시 시도해 주세요.';

  @override
  String get noRecordingCapturedPleaseTryAgain => '녹음된 음성이 없습니다. 다시 시도해 주세요.';

  @override
  String get recordedAudioIsEmptyPleaseTryAgainA =>
      '녹음 파일에 음성이 감지되지 않았습니다. 또렷하게 말씀해 주세요.';

  @override
  String get azureSpeechApiKeysAreMissing1 => 'Azure Speech API 키가 설정되지 않았습니다';

  @override
  String get azureError401 => 'Azure 인증 오류 401';

  @override
  String get azureAuthenticationFailedCheckYourS =>
      'Azure 인증에 실패했습니다. .env 파일의 Speech API 키와 리전을 확인하세요.';

  @override
  String get azureError429 => 'Azure 요청 한도 초과 오류 429';

  @override
  String get azureQuotaExceededTryAgainLater =>
      'Azure API 호출 할당량이 초과되었습니다. 잠시 후 다시 시도해 주세요.';

  @override
  String get azureGradingTimedOutCheckYourIntern =>
      'Azure 발음 채점 시간이 초과되었습니다. 인터넷 연결을 확인하세요.';

  @override
  String get recognitionFailedNull => '음성 인식 실패: null';

  @override
  String get couldNotHearYouClearlyPleaseTryAgai =>
      '음성을 명확하게 인식하지 못했습니다. 다시 말씀해 주세요.';

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
  String get engagingMacroeconomicAndBusinessBre =>
      '생생한 스토리텔링으로 쉽게 풀어내는 거시 경제 및 비즈니스 트렌드 분석.';

  @override
  String get exploresWorldEconomiesBankingHistor =>
      '세계 경제, 금융의 역사, 글로벌 산업 생태계를 심층 탐구합니다.';

  @override
  String get clearArticulateMandarinPerfectForIn =>
      '중·고급 학습자의 듣기 실력 향상에 최적화된 명확하고 수려한 표준 보통화.';

  @override
  String get chefWang => '왕강(王剛) 셰프';

  @override
  String get masterSichuanCulinaryTechniquesTaug =>
      '전문 헤드 셰프가 직접 전수하는 정통 사천요리 조리 기술.';

  @override
  String get stepbystepAuthenticChineseRecipesWi =>
      '강한 불맛의 웍 조절과 정교한 칼질을 배울 수 있는 단계별 정통 중식 레시피.';

  @override
  String get conciseCulinaryVocabularyAndClearIn =>
      '간결한 조리 용어와 군더더기 없이 명쾌한 보통화 설명.';

  @override
  String get cinematographyCuttingedgeCameraTech =>
      '시네마틱 영상미, 첨단 카메라 장비 및 디지털 미디어 심층 리뷰.';

  @override
  String get highproductionDocumentaryStyleExplo =>
      '영상 제작 기법과 최신 AI 혁신 기술을 다루는 고품격 다큐멘터리.';

  @override
  String get richTechnicalMandarinWithCrystalcle =>
      '정확한 딕션과 시각 자막으로 배우는 풍부한 IT 전문 중국어.';

  @override
  String get indepthInvestigativeJournalismAndCu =>
      '심도 있는 탐사 보도와 날카로운 시사 이슈 해설.';

  @override
  String get criticalPerspectivesOnSocialPhenome =>
      '사회 현상, 국제 뉴스, 역사적 사건을 조명하는 비판적 통찰.';

  @override
  String get formalInvestigativeDiscourseIdealFo =>
      '고급 시사 듣기 학습에 이상적인 격식 있는 시사 담화.';

  @override
  String get bitesizedAnimatedScienceDocumentari =>
      '일상 속 호기심을 명쾌하게 풀어주는 숏폼 애니메이션 과학 다큐.';

  @override
  String get exploresPhysicsBiologyAndEverydayCu =>
      '물리학, 생물학, 일상 속 미스터리를 흥미진진한 인포그래픽으로 탐구.';

  @override
  String get standardBeijingMandarinWithWellpace =>
      '듣기 편안한 속도의 내레이션과 명확한 자막이 돋보이는 표준 베이징 보통화.';

  @override
  String get heartwarmingStreetFoodAdventuresAnd =>
      '중국 전역의 정겨운 길거리 음식과 현지인들의 따스한 삶의 이야기.';

  @override
  String get exploresRegionalHumanStoriesFamilyT =>
      '각 지역의 사람 냄새 나는 이야기, 가족의 전통, 향토 미식을 조명.';

  @override
  String get naturalConversationalMandarinWithDa =>
      '일상 유행어와 사람 냄새가 묻어나는 자연스러운 생활 중국어 회화.';

  @override
  String get humorousAndHonestConsumerElectronic =>
      '실제 사용기를 바탕으로 한 솔직하고 유쾌한 전자기기 테크 리뷰.';

  @override
  String get testingSmartphonesSmartHomeGadgetsA =>
      '스마트폰, 스마트홈 기기, 라이프스타일 테크 장비 실전 테스트.';

  @override
  String get relaxedHumorousConversationalDialog =>
      '최신 신조어가 녹아든 편안하고 위트 넘치는 일상 대화.';

  @override
  String get seanKitchen => '션의 주방 (Sean\'s Kitchen)';

  @override
  String get deliciousHomecookedChineseDishesAnd =>
      '맛있는 중국 가정식 요리와 인기 길거리 간식 홈메이드 레시피.';

  @override
  String get easytofollowKitchenTipsForCookingAu =>
      '정통 아시아 요리를 집에서 손쉽게 완성하는 실용적인 요리 꿀팁.';

  @override
  String get warmInvitingCommentaryWithPractical =>
      '실용적인 주방 어휘와 함께하는 다정하고 친근한 설명.';

  @override
  String get chineseChannel => '차이나 채널';

  @override
  String get structuredChineseLanguageLessonsAnd =>
      '체계적인 단계별 중국어 강의와 문화 탐색 튜토리얼.';

  @override
  String get grammarPointsHskVocabularyBuildingA =>
      '핵심 문법 포인트, HSK 필수 단어 완성, 실전 대화 패턴 훈련.';

  @override
  String get clearEducationalPacingTailoredSpeci =>
      '외국인 학습자의 눈높이에 맞춘 명확하고 체계적인 수업 진도.';

  @override
  String get oneInABillion => '14억 분의 1의 이야기 (One in a Billion)';

  @override
  String get intimatePortraitsAndStoriesOfUnique =>
      '현대 중국을 살아가는 특별한 인물들의 진솔한 삶과 자화상.';

  @override
  String get exploresDiverseLifeChoicesYouthCult =>
      '다양한 삶의 방식, 청년 서브컬처, 현대 사회의 가치관 변화를 조명.';

  @override
  String get deepNarrativeStorytellingWithRichVo =>
      '풍부한 어휘와 진정성 있는 목소리로 전하는 깊이 있는 스토리텔링.';

  @override
  String get vickySoup => '비키의 일상 (Vicky Soup)';

  @override
  String get aestheticLifestyleVlogsFashionStyli =>
      '감각적인 라이프스타일 브이로그, 패션 스타일링, 일상 루틴.';

  @override
  String get travelDiariesAndCozyLifeMomentsDocu =>
      '영화 같은 따스한 영상미로 담아낸 감성 여행과 아늑한 일상의 순간들.';

  @override
  String get naturalCasualMandarinSpokenAtAComfo =>
      '듣기 편안하고 감정 표현이 풍부한 자연스러운 캐주얼 보통화.';

  @override
  String get tededMandarin => 'TED-Ed 중국어';

  @override
  String get highqualityAnimatedEducationalLesso =>
      '과학, 철학, 역사를 아우르는 고품격 애니메이션 교양 수업.';

  @override
  String get thoughtprovokingRiddlesClassicLiter =>
      '생각을 깨우는 수수께끼, 고전 문학의 정수, 심리학의 미스터리.';

  @override
  String get impeccableVoiceoverMandarinWithSync =>
      '동기화된 2개 국어 자막과 완벽한 딕션의 표준 보통화 내레이션.';

  @override
  String get channel => '채널';

  @override
  String get curatedCulturalDocumentariesAndChin =>
      '엄선된 문화 다큐멘터리와 현대 중국의 라이프스타일 하이라이트.';

  @override
  String get exploringTraditionalArtsHeritageCra =>
      '전통 예술, 무형 문화유산, 현대적 트렌드의 조화를 탐색.';

  @override
  String get highQualityAudioWithSynchronizedChi =>
      '실시간 동기화 중국어 자막이 제공되는 고음질 오디오 트랙.';

  @override
  String get interestingStoriesAndCreativeVideoP =>
      '중국 인터넷에서 화제가 된 흥미진진한 이야기와 창의적인 영상 프로젝트.';

  @override
  String get engagingInterviewsStorytellingAndVi =>
      '몰입도 높은 인터뷰, 감동적인 스토리텔링, 아름다운 영상미.';

  @override
  String get greatListeningMaterialWithStandardP =>
      '정확한 표준 발음으로 학습하는 최고의 듣기 훈련 자료.';

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
  String get mandarinBean => '만다린 빈';

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
  String get ijenwaBenita => '이젠와 베니타';

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
  String get gemini => '제미니';

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
  String get highqualityCuratedMandarinContentWi =>
      '생생한 어휘로 엄선된 고품격 중국어 학습 콘텐츠.';

  @override
  String get authenticSpokenChineseAcrossRealwor =>
      '실제 일상과 다양한 주제를 아우르는 진짜 중국어 회화.';

  @override
  String get engagingVideoMaterialWithInteractiv =>
      '실시간 동기화 자막이 지원되는 몰입도 높은 영상 학습 자료.';

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
  String get liveOverlay => '실시간 번역 오버레이';

  @override
  String get webExplorer => '웹 탐색기';

  @override
  String get browseAnyChineseWebsiteWithRealtime =>
      '단어 탭 사전, 병음 주석, 실시간 번역으로 중국어 웹사이트를 자유롭게 서핑하세요.';

  @override
  String get startExploring => '탐색 시작하기';

  @override
  String get chineseTvSeriesWithInteractiveSubti => '인터랙티브 자막과 함께 보는 중국 드라마';

  @override
  String get failedToLoadContent => '콘텐츠를 불러오지 못했습니다';

  @override
  String get searchingYoutube => 'YouTube 검색 중...';

  @override
  String get noVideosFoundTryADifferentSearchTer =>
      '검색된 동영상이 없습니다. 다른 검색어로 시도해 보세요.';

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
  String get videosWithHardcodedOrBurnedinSubtit =>
      '영상 화면에 자체 인쇄된 자막은 디지털 텍스트로 추출할 수 없습니다.';

  @override
  String get translatingSubtitles => '자막을 번역하는 중...';

  @override
  String get processingYourPronunciation => '발음 데이터를 분석하는 중...';

  @override
  String get couldntIdentifyLine => '해당 문장을 인식하지 못했습니다.';

  @override
  String get listeningSpeakNow => '듣고 있습니다... 지금 말씀하세요.';

  @override
  String get thisVideoDoesNotHaveADigitalClosedC =>
      '이 동영상은 디지털 자막(CC)을 지원하지 않습니다.';

  @override
  String get perfect1 => '완벽해요';

  @override
  String get thisVideoHasBeenRemovedOrIsNoLonger =>
      '이 동영상은 삭제되었거나 더 이상 재생할 수 없습니다.';

  @override
  String get thisVideoCannotBePlayedInTheAppYouC =>
      '이 동영상은 앱 내 재생을 지원하지 않습니다. YouTube에서 시청해 주세요.';

  @override
  String get yourDeviceCannotPlayThisVideoPlease =>
      '현재 기기에서 지원하지 않는 동영상 형식입니다. 다른 영상을 선택해 주세요.';

  @override
  String get invalidVideoReferencePleaseTryAgain =>
      '올바르지 않은 동영상 링크입니다. 다시 시도해 주세요.';

  @override
  String get unableToLoadThisVideoPleaseTryAnoth =>
      '동영상을 불러올 수 없습니다. 다른 영상을 시도해 주세요.';

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
  String get k80CompleteClassicNovelsWorldEpics =>
      '80편 이상의 완역 고전 소설 및 세계 서사시 수록';

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
  String get yourDailyDropAndStreakAlertsArePrim =>
      '일일 데일리 드롭과 연속 학습 알림이 준비되었습니다.';

  @override
  String get stayConsistentWithDailyRitualDropsA =>
      '매일 주어지는 학습 루틴과 알림을 통해 학습 습관을 꾸준히 유지하세요.';

  @override
  String get aNewWordAndStoryWaitingForYourDaily =>
      '매일의 학습 루틴을 위한 새로운 단어와 스토리가 준비되어 있습니다.';

  @override
  String get gentlePromptsBeforeCharactersFadeFr =>
      '기억에서 잊히기 전에 최적의 타이밍에 복습 알림을 드립니다.';

  @override
  String get receiveAReminder2DaysBeforeYourFree =>
      '무료 체험 종료 2일 전에 사전 알림을 받아보세요.';

  @override
  String get yourPathTonchineseFluency => '중국어 마스터를 향한 맞춤 길';

  @override
  String get answer3QuickQuestionsSoOurAiCanCraf =>
      '간단한 3가지 질문에 답하시면,\nAI가 회원님의 라이프스타일에 맞춘 최적의 커리큘럼을 설계합니다.';

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
  String get iCanHoldConversationsAndRead =>
      '간단한 일상 대화가 가능하며 짧은 문장을 읽을 수 있습니다.';

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
  String get wePromisedToAlertYou2DaysBeforeYour =>
      '약속드린 대로 무료 체험 종료 2일 전에 미리 안내해 드립니다.';

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
  String get revenuecatIsMissingACurrentOffering =>
      'RevenueCat에 활성화된 패키지가 없습니다. 대시보드를 구성해 주세요.';

  @override
  String get cameraPermissionRequiredForLiveScan =>
      '실시간 스캔을 사용하려면 카메라 접근 권한이 필요합니다.';

  @override
  String get cameraAccessRequired => '카메라 권한 필요';

  @override
  String get pleaseEnableCameraAccessInYourDevic =>
      '이 기능을 사용하려면 기기 설정에서 카메라 접근을 허용해 주세요.';

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
  String get asTheNarrativeUnfoldsItIlluminatesT =>
      '이야기가 깊어질수록 삶의 심오한 지혜와 시대를 초월한 감동이 펼쳐집니다.';

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
  String get noMicroreadsFoundMatchingYourFilter =>
      '필터 조건과 일치하는 마이크로 리딩이 없습니다.';

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
  String get kafkaesqueForBureaucraticAbsurdityA =>
      '관료주의적 부조리, 인간 소외, 실존적 고뇌를 뜻하는 \'카프카적(Kafkaesque)\'.';

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
  String get whenYourWeekly4hourStudioAllowanceI =>
      '주간 4시간의 스튜디오 음성을 모두 사용하면, 끊김 없는 무료 청취를 위해 자동으로 기기 내장 음성으로 전환됩니다.';

  @override
  String get localDeviceVoice => '기기 내장 기본 음성';

  @override
  String get classicalVerse => '고전 시구';

  @override
  String get ondeviceVoice4hWeeklyUsed => '기기 내장 음성 (이번 주 4시간 소진됨)';

  @override
  String get generateACustomAiStoryBasedOnYourIn => '내 관심사에 맞춘 AI 스토리 생성';

  @override
  String get insteadOfAFixedHskLevelTheFlowState =>
      '고정된 HSK 급수에 얽매이지 않고, 동적 플로우 엔진이 내 단어장의 어휘 수준을 분석합니다.\n\n';

  @override
  String get we => 'SinoSpark 팀';

  @override
  String get howCanWeHelpYou => '무엇을 도와드릴까요?';

  @override
  String get everythingYouNeedToKnowAboutHanziMa =>
      'SinoSpark의 기능, 학습법, 개인정보 보호에 대한 모든 것.';

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
  String get generationIsTakingLongerThanExpecte =>
      '생성에 평소보다 시간이 더 걸리고 있습니다. AI 서버가 혼잡할 수 있습니다.';

  @override
  String get generationInterruptedShowingPartial =>
      '생성이 중단되었습니다. 준비된 일부 결과를 표시합니다.';

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
  String get romanceOfTheThreeKingdoms =>
      '삼국지연의 (Romance of the Three Kingdoms)';

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
  String get browseAnyChineseWebsite =>
      '실시간 단어 탭 사전, 병음 주석, 즉석 번역으로 모든 중국어 웹사이트를 탐색하세요.';

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

  @override
  String get todayDashboard => '오늘';

  @override
  String get studyToday => '오늘의 카드 학습하기';

  @override
  String get studyAhead => '선행 학습';

  @override
  String get studyAheadDescription =>
      '오늘 할당량을 사용하지 않고 예정된 복습을 미리 연습합니다. 새 카드는 추가되지 않습니다.';

  @override
  String get studyAheadComplete => '선행 학습 완료';

  @override
  String get dueNow => '지금 복습';

  @override
  String get scheduled => '예정됨';

  @override
  String get sevenDayForecast => '7일 복습 예측';

  @override
  String get reviews => '복습';

  @override
  String get newCardsLabel => '새 카드';

  @override
  String get attempts => '시도 횟수';

  @override
  String get duration => '시간';

  @override
  String get answerBreakdown => '정답 분석';

  @override
  String get reviewCards => '복습 카드';

  @override
  String get retries => '재시도';

  @override
  String get needsPractice => '연습 필요';

  @override
  String get uniqueCardsStudied => '학습한 카드';

  @override
  String get dartConvert => 'dart:convert';

  @override
  String get env => '.env';

  @override
  String get dartUi => 'dart:ui';

  @override
  String get dartMath => 'dart:math';

  @override
  String get drawInTheOtherDirection => '반대 방향으로 그리세요 ➔';

  @override
  String get fastClean => '빠르고 깔끔해요!';

  @override
  String get good2 => '좋아요!';

  @override
  String get followTheFlow => '획순을 따라 그리세요.';

  @override
  String get masterful => '완벽해요!';

  @override
  String get missingTheHookEnd => '갈고리/끝처리가 빠졌습니다.';

  @override
  String get thai => '태국어';

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
  String get ink => '먹물,';

  @override
  String get stroke => '획,';

  @override
  String get breath => '호흡.';

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
  String get theExactSentenceProvided => '제공된 정확한 문장';

  @override
  String get pinyinWithToneMarks2 => '성조가 표시된 병음';

  @override
  String get wXHuNH => 'Wǒ xǐhuān hē píngguǒzhī.';

  @override
  String get extractAllChineseCharactersFrom =>
      '이 이미지에서 모든 한자를 추출하세요. 주석, 서식, 번역 없이 추출된 텍스트만 반환하세요. 줄바꿈을 유지하세요. 한자가 없으면 빈 문자열을 반환하세요.';

  @override
  String get householdObject => '생활용품';

  @override
  String get genericLabelFromTheList => '목록의 일반 레이블';

  @override
  String get gNgS => 'gōng sī';

  @override
  String get measureWord => '양사';

  @override
  String get zenInk => '선과 먹';

  @override
  String get cRITICALPutTheEnglishTranslation =>
      '중요: 영어 번역을 \"english\" JSON 키에 입력하세요!';

  @override
  String get definitionInEnglish => '영어 정의';

  @override
  String get simplifiedLine0 => '간체자 줄 0';

  @override
  String get simplifiedLine1 => '간체자 줄 1';

  @override
  String get iMPORTANTRULEDoNotAddress =>
      '중요 규칙: 사용자의 이름을 부르지 마세요. \"John\"과 같은 임시 이름을 절대 사용하지 마세요. 이름 없이 직접 대화하세요.';

  @override
  String get rULESAnswerIn23 => '규칙: 최대 2~3문장으로 답하세요. 목록은 글머리 기호를 권장합니다.';

  @override
  String get neverWriteIntroductionsSignOffs =>
      '도입부, 맺음말 또는 \"좋은 질문입니다!\", \"당연하죠!\"와 같은 추임새를 절대 쓰지 마세요.';

  @override
  String get useBoldForChineseCharacters => '한자와 핵심 용어에는 **굵은 글씨**를 사용하세요.';

  @override
  String get rULESAnswerIn232 => '규칙: 최대 2~3문장으로 답하세요.';

  @override
  String get accept => '수락';

  @override
  String get pronunciationAssessment => '발음 평가';

  @override
  String get nBest => 'N-Best';

  @override
  String get none => '없음';

  @override
  String get theCorrectedChineseText => '수정된 중국어 텍스트';

  @override
  String get thePinyinForTheCorrected => '수정된 텍스트의 병음';

  @override
  String get theEnglishMeaningOfThe => '수정된 텍스트의 영어 뜻';

  @override
  String get pNyNWithTone => '성조가 표시된 병음';

  @override
  String get englishTranslation2 => '영어 번역';

  @override
  String get zhNggu => 'Zhōngguó';

  @override
  String get youAreAChineseClassical =>
      '당신은 중국 고전 시에 대한 상세하고 이해하기 쉬운 요약을 제공하는 중국 고전 문학 전문가입니다.';

  @override
  String get youAreAChineseCulture =>
      '당신은 중국 문화 및 문학 전문가입니다. 매우 흥미롭고 유려하게 작성된 문화적 통찰을 제공하세요.';

  @override
  String get english2 => '영어:';

  @override
  String get remindersWhenYouHavenT => '며칠 동안 앱을 사용하지 않았을 때의 알림';

  @override
  String get itSBeenAFew => '며칠 만이네요! 오늘 5분만 투자해서 새로운 한자를 배워보세요.';

  @override
  String get abbreviationFor => '~의 약어';

  @override
  String get cL => '양사:';

  @override
  String get measureWord2 => '양사:';

  @override
  String get lu => 'lu:';

  @override
  String get luE => 'lu:e';

  @override
  String get nu => 'nu:';

  @override
  String get nuE => 'nu:e';

  @override
  String get noUser => '사용자 없음';

  @override
  String get passwordRequired => '비밀번호 필요';

  @override
  String get unsupportedProvider => '지원되지 않는 제공업체';

  @override
  String get appleRevocationUnavailable => 'Apple 취소 불가';

  @override
  String get appleCredentialMissing => 'Apple 자격 증명 누락';

  @override
  String get authenticationDidNotReturnA => '인증에서 사용자를 찾을 수 없습니다.';

  @override
  String get viewSubscriptionPlans => '구독 요금제 보기';

  @override
  String get wrongPassword => '잘못된 비밀번호';

  @override
  String get invalidCredential => '유효하지 않은 자격 증명';

  @override
  String get networkRequestFailed => '네트워크 요청 실패';

  @override
  String get requiresRecentLogin => '최근 로그인 필요';

  @override
  String get userMismatch => '사용자 불일치';

  @override
  String get deleteAccountPassword => '계정 삭제 비밀번호';

  @override
  String get deleteAccountError => '계정 삭제 오류';

  @override
  String get deleteAccountSubmit => '계정 삭제';

  @override
  String get theSimplestShapesTheBeginning => '가장 단순한 형상. 모든 것의 시작.';

  @override
  String get sunMoonWaterAndFire => '해, 달, 물, 불. 자연의 세계.';

  @override
  String get theBodyTheHeartAnd => '몸, 마음, 그리고 가족.';

  @override
  String get fieldsRoofsAndToolsThe => '밭, 지붕, 그리고 도구. 사회의 기초.';

  @override
  String get movementSpeechAndSustenance => '이동, 언어, 그리고 식생활.';

  @override
  String get commerceClothingAndComplexArtifacts => '상업, 의복, 그리고 복합 공예품.';

  @override
  String get fastTrackSimpleCharacterMastered => '🚀 패스트 트랙! 쉬운 글자를 마스터했습니다.';

  @override
  String get excellentPrecisionGhostTraceSkipped => '⚡ 뛰어난 정확도! 획 가이드를 건너뜁니다.';

  @override
  String get sample => '예시:';

  @override
  String get itsThat => '그것의/저것';

  @override
  String get iMe => '나/저';

  @override
  String get stillTough => '여전히/힘든';

  @override
  String get partDecide => '부분/결정';

  @override
  String get selectTheCharacterFor => '다음 항목의 한자를 선택하세요:';

  @override
  String get selectThePinyinFor => '다음 항목의 병음을 선택하세요:';

  @override
  String get whereAreYouGoingThe => '어디 가시나요? 공항이요? 제법 먼 거리네요!';

  @override
  String get youAreAuntieChenA =>
      '당신은 비단과 직물을 파는 수완 좋은 시장 상인인 첸 아줌마입니다. 당신의 유일한 역할은 시장 상인입니다. 중국어로 단호하지만 공정하게 가격을 협상하세요. 절대로 캐릭터에서 벗어나거나 상인이 아닌 다른 사람으로 자신을 소개하지 마세요. 높은 가격으로 시작하되 흥정할 의향을 보이세요.';

  @override
  String get youAreDrZhangA =>
      '당신은 의원의 차분하고 전문적인 의사인 장 선생님입니다. 당신의 유일한 역할은 의사입니다. 건강 증상에 대해 묻고 중국어로 의학적 조언을 제공하세요. 절대로 캐릭터에서 벗어나거나 의사가 아닌 다른 사람으로 자신을 소개하지 마세요. 안심시키되 철저하게 진료하세요.';

  @override
  String get whereDoYouFeelUncomfortable => '어디가 불편하신가요? 열이 있으신가요?';

  @override
  String get youAreACloseFriend =>
      '당신은 오랜만에 안부를 묻는 친한 친구입니다. 당신의 유일한 역할은 친구입니다. 중국어로 편안하고 따뜻하며 짧게 답변하세요. 절대로 캐릭터에서 벗어나거나 친구가 아닌 다른 사람으로 자신을 소개하지 마세요. 친한 친구 사이에 어울리는 대화체를 사용하세요.';

  @override
  String get noNbest => '결과 없음';

  @override
  String get timedOut => '시간 초과됨';

  @override
  String get grading => '채점 중...';

  @override
  String get label1st => '1성 ˉ';

  @override
  String get label2nd => '2성 ˊ';

  @override
  String get label3rd => '3성 ˇ';

  @override
  String get label4th => '4성 ˋ';

  @override
  String get speaking2 => '말하는 중...';

  @override
  String get sessionCompletedInYourNext =>
      '세션이 완료되었습니다. 다음 연습에서는 완전한 문장으로 말하여 자세한 발음 및 성조 진단을 받아보세요.';

  @override
  String get craneSoaring => '비상하는 학';

  @override
  String get gentleStream => '잔잔한 개울';

  @override
  String get brushAndInk => '붓과 먹';

  @override
  String get myStudent => '나의 제자';

  @override
  String get honoredDisciple => '자랑스러운 제자';

  @override
  String get notEnoughInformation => '정보 부족';

  @override
  String get asAnAi => 'AI로서';

  @override
  String get goodPracticeSessionContinueFocusing =>
      '훌륭한 연습이었습니다. 명확한 성조 대비와 자연스러운 대화 호흡에 계속 집중해 보세요.';

  @override
  String get insideASleekFuxingBullet =>
      '베이징에서 상하이까지 시속 350km로 달리는 세련된 푸싱호 고속열차 안.';

  @override
  String get harbinIceSnowWorldWonder => '하얼빈 빙설대세계의 경관';

  @override
  String get theFamousPanjiayuanWeekendFlea =>
      '서예 족자, 옥, 빈티지 골동품으로 북적이는 유명한 판자위안 주말 벼룩시장.';

  @override
  String get jingdezhenBlueWhitePorcelainStudio => '징더전 청화백자 공방';

  @override
  String get pekingOperaDressingRoomMakeup => '경극 분장실 및 메이크업';

  @override
  String get aHistoricTongrentangApothecaryScented =>
      '인삼, 구기자 향과 수백 개의 나무 약재 서랍이 맞아주는 역사적인 동인당 한약방.';

  @override
  String get aVibrantPrivateNeonLit =>
      '마이크, 과일 안주, 화면 컨트롤러가 갖춰진 선전의 활기찬 네온 프라이빗 노래방.';

  @override
  String get animeCosplayExpoInGuangzhou => '광저우 애니메이션 & 코스프레 엑스포';

  @override
  String get nHOHuNy =>
      'Nǐ hǎo! Huānyíng lái dào zhèlǐ, jīntiān wǒmen liáo xiē shénme ne?';

  @override
  String get surpriseMe2 => '🎲 랜덤 추천';

  @override
  String get eGALivelyBanquet => '예: 상하이에서 열리는 활기찬 축하 연회...';

  @override
  String get rollCharacter2 => '🎲 캐릭터 랜덤 선택';

  @override
  String get eGACuriousCousin => '예: 당신의 커리어에 대해 이것저것 묻는 사촌...';

  @override
  String get keepTrying => '계속 도전하세요!';

  @override
  String get pending => '대기 중...';

  @override
  String get expected => '🎯 예상';

  @override
  String get hSK2Elementary => 'HSK 2급: 초급';

  @override
  String get hSK3Intermediate => 'HSK 3: 중급';

  @override
  String get hSK5Advanced => 'HSK 5: 고급';

  @override
  String get expressYourselfFullyWith5000 => '5,000개 이상의 단어로 마음껏 표현해 보세요.';

  @override
  String get hanziWriter => 'hanzi-writer';

  @override
  String get hvg => 'hvg:';

  @override
  String get unlimited => '무제한';

  @override
  String get dueToday => '오늘 복습 예정';

  @override
  String get newAvailable => '신규 학습 가능';

  @override
  String get deleteAccountTile => 'delete-account-tile';

  @override
  String get giveASingleShortPractical =>
      '잘못 그려진 획의 모양, 위치, 길이를 개선할 수 있는 짧고 실용적인 팁을 하나만 제공하세요. 시적이거나 비유적인 표현을 사용하지 말고 직관적이고 유용하게 작성하세요. 마크다운은 사용하지 마세요.';

  @override
  String get localOnDeviceTTS => '로컬 — 기기 내 TTS';

  @override
  String get espaOl => '스페인어';

  @override
  String get franAis => '프랑스어';

  @override
  String get portuguS => '포르투갈어';

  @override
  String get tiNgViT => '베트남어';

  @override
  String get koreFemaleWarm => 'Kore — 여성, 따뜻한 톤';

  @override
  String get aoedeFemaleCheerful => 'Aoede — 여성, 밝은 톤';

  @override
  String get fenrirMaleUpbeat => 'Fenrir — 남성, 활기찬 톤';

  @override
  String get charonMaleNewsStyle => 'Charon — 남성, 뉴스 스타일';

  @override
  String get puckMaleSporty => 'Puck — 남성, 스포티한 톤';

  @override
  String get systemVoice => '시스템 음성';

  @override
  String get generateAdd => '생성 및 추가';

  @override
  String get moreExamples => '📝 추가 예문';

  @override
  String get usage2 => '❓ 용법';

  @override
  String get translation => '💬 번역';

  @override
  String get collocations => '📚 연어';

  @override
  String get mistakes => '❌ 오답';

  @override
  String get decrease => '줄이기';

  @override
  String get increase => '늘리기';

  @override
  String get label0MeansThisCardType => '0은 이 카드 유형을 비활성화함을 의미합니다.';

  @override
  String get tapTheValueToEnter => '값을 탭하여 정확한 한도를 입력하세요.';

  @override
  String get exactDailyLimit => '일일 정확한 한도';

  @override
  String get enter0ToDisable => '비활성화하려면 0을 입력하세요.';

  @override
  String get apply => '적용';

  @override
  String get selectDeck => '덱 선택';

  @override
  String get azureSpeechKeysNotConfigured =>
      'Azure Speech 키가 설정되지 않았습니다. .env에 AZURE_SPEECH_KEY 및 AZURE_SPEECH_REGION을 추가하세요.';

  @override
  String get sTARTING => '시작 중…';

  @override
  String get sTARTSESSION => '세션 시작';

  @override
  String get translating2 => '번역 중...';

  @override
  String get chai => '柴知道Chai...';

  @override
  String get oneInABillion2 => '@One-In-a-Billion';

  @override
  String get businessEconomics => '비즈니스 및 경제';

  @override
  String get hskPreparation => 'HSK 대비';

  @override
  String get liveInChina => '중국 생활';

  @override
  String get comprehensiveExercise => '종합 연습';

  @override
  String get howToUse => '사용 방법';

  @override
  String get usesOf => '용법';

  @override
  String get appearedFirstOnMandarinBean => 'Mandarin Bean에 처음 게재됨';

  @override
  String get news2 => '뉴스:';

  @override
  String get joke => '유머:';

  @override
  String get jokes => '유머:';

  @override
  String get academicScience => '학술 / 과학';

  @override
  String get politicsCommunism => '정치 및 공산주의';

  @override
  String get foodDining => '음식 및 외식';

  @override
  String get sciFi => 'SF';

  @override
  String get scienceFictionTech => 'SF 및 테크';

  @override
  String get travelPlaces => '여행 및 명소';

  @override
  String get mythologyFantasy => '신화 및 판타지';

  @override
  String get cultureTraditions => '문화 및 전통';

  @override
  String get businessEconomy => '비즈니스 및 경제';

  @override
  String get natureAnimals => '자연 및 동물';

  @override
  String get articleImg => '기사 이미지';

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
      '시시 픽처스 공식 채널 (XiXi Pictures Official Channel)';

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
  String get getTheWeTVAPP => 'WeTV 앱 다운로드';

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
  String get learnMandarinWithTaiwanPlus => 'TaiwanPlus와 함께 중국어 배우기';

  @override
  String get everydayChinese => '일상 중국어';

  @override
  String get uCCFdR7zZ5SUXuOrEdKw => 'UCC_fdR7zZ_5SU--xuOrEdKw';

  @override
  String get tingDailyLifeInChina => 'Ting - 중국에서의 일상';

  @override
  String get tFTFOODTRAVEL => 'TFT - 음식 & 여행';

  @override
  String get uCsHMiBJ9r87fRH7VAWZw => 'UCs_h_miBJ9r8-7fRH7VAWZw';

  @override
  String get liziqi3 => '리쯔치 Liziqi: 마늘의 일생';

  @override
  String get label2MINCULTURALCONTEXT => '2분 문화 상식';

  @override
  String get liziqi4 => '리쯔치 Liziqi: 대나무 가구';

  @override
  String get peppaPigChinese2 => '페파피그 중국어: 진흙 웅덩이';

  @override
  String get noBBCLeadArticleIs => '현재 이용 가능한 BBC 헤드라인 기사가 없습니다.';

  @override
  String get mediaThumbnail => '미디어 썸네일';

  @override
  String get bBC => 'BBC 중국어';

  @override
  String get siJin2 => '사금 Si Jin';

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
  String get sIXSISTERS2 => '육자매 SIX SISTERS';

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
  String get shineOnMe => '교양사아 Shine on Me';

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
  String get thoseDays => '四喜 그 시절';

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
  String get noFunnyNoMoney => '재미없으면 노숙 No Funny No Money';

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
  String get getTheWeTVAPP2 => '텐센트 비디오 - 애니메이션 - WeTV 앱 받기';

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
      '《신비의 제왕》 Lord of Mysteries 오징어 더빙 Vlog 최종판 텐센트 비디오 - 애니메이션';

  @override
  String get lordOfMysteries =>
      '《신비의 제왕》 Lord of Mysteries 신비학 클래스 8화 텐센트 비디오 - 애니메이션';

  @override
  String get lordOfMysteries2 =>
      '《신비의 제왕》 Lord of Mysteries 신비학 클래스 7화 텐센트 비디오 - 애니메이션';

  @override
  String get lordOfMysteries3 =>
      '《신비의 제왕》 Lord of Mysteries 신비학 클래스 6화 텐센트 비디오 - 애니메이션';

  @override
  String get lordOfMysteries4 =>
      '《신비의 제왕》 Lord of Mysteries 신비학 클래스 5화 텐센트 비디오 - 애니메이션';

  @override
  String get lordOfMysteries5 =>
      '《신비의 제왕》 Lord of Mysteries 신비학 클래스 4화 텐센트 비디오 - 애니메이션';

  @override
  String get lordOfMysteries6 =>
      '《신비의 제왕》 Lord of Mysteries 신비학 클래스 3화 텐센트 비디오 - 애니메이션';

  @override
  String get pakhctn6g6A => 'Pakhctn6g6A';

  @override
  String get lordOfMysteries7 =>
      '《신비의 제왕》 Lord of Mysteries 신비학 클래스 2화 텐센트 비디오 - 애니메이션';

  @override
  String get lordOfMysteries8 =>
      '《신비의 제왕》 Lord of Mysteries 신비학 클래스 1화 텐센트 비디오 - 애니메이션';

  @override
  String get g5fLWO98axs => 'G5fLWO98axs';

  @override
  String get gK0eOTF2s4c => 'GK0eOTF2s4c';

  @override
  String get oSTLordOfMysteries =>
      '【OST】 《신비의 제왕》 Lord of Mysteries 엔딩곡 《물망초》 텐센트 비디오 - 애니메이션';

  @override
  String get membersPremiere2 => '회원 선공개';

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
  String get eightHundred => '반경 800m Eight Hundred';

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
  String get loveBeyondTheGrave => '백일제등 Love Beyond the Grave';

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
      '촬영장 비하인드: 허사모와 단서, 본명은 찾기 힘들고 별명만 수두룩【백일제등 Love Beyond the Grave】';

  @override
  String get label5MVET41ATY => '5MVET41A-tY';

  @override
  String get bTSLoveBeyondTheGrave =>
      '메이킹｜[텐센트 드라마 파티] 디리러바, 천페이위와 주연진의 찰떡궁합 오감 5연사!【백일제등 Love Beyond the Grave】';

  @override
  String get bTSLoveBeyondTheGrave2 =>
      '메이킹｜[텐센트 드라마 파티] 디리러바, 천페이위 등장! 레전드 눈빛 연기【백일제등 Love Beyond the Grave】';

  @override
  String get herBlaze => '그녀의 불꽃 Her Blaze';

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
  String get aboutLove => '장미총생 About Love';

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
      '《장미총생》 전원이 사랑의 안개 속에 빠졌다. 과연 어떻게 난국을 헤쳐 나갈 것인가? | 주연: 왕자문, 유우녕';

  @override
  String get pLMX26aiIvX5rSLe74r7sARps4oOqaBWD =>
      'PLMX26aiIvX5rSLe74r7sA-Rps4oOqaBWD';

  @override
  String get generationToGeneration2 => '강호야우십년등 Generation to Generation';

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
  String get loveStoryInThe1970s => '1970년대의 순수한 사랑';

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
  String get whyIsHeStillSingle => '그는 왜 아직도 싱글일까';

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
  String get theGlamorousNight => '야색정농 (The Glamorous Night)';

  @override
  String get theGlamorousNightE03 =>
      '【야색정농 The Glamorous Night】3화 압도적인 한 수! 자오메이의 절체절명 반격 (장수잉, 퉁따웨이)';

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
  String get myPageInThe90s => '갑작스러운 사랑 My Page in the 90s';

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
      '하이라이트 04: 황당한 시스템의 개입! 휴지가 생리대로? 대형 민망 사건! 【갑작스러운 사랑 My Page in the 90s】';

  @override
  String get label03MyPageInThe =>
      '하이라이트 03: 친구 대신 나간 소개팅, 상대가 남주 본인? 【갑작스러운 사랑 My Page in the 90s】';

  @override
  String get bTSXXMyPage =>
      '메이킹｜[비하인드 X 천싱쉬 X 왕위원] 가오 대표와 환얼 중 누구의 엉뚱함이 한 수 위일까? 【갑작스러운 사랑 My Page in the 90s】';

  @override
  String get label02MyPageInThe =>
      '하이라이트 02: 남주를 공략하려다 사람을 잘못 알아봤다? 【갑작스러운 사랑 My Page in the 90s】';

  @override
  String get label01MyPageInThe =>
      '하이라이特 01: 황당해! 갑자기 책 속으로 빙의? 이 스토리 어떻게 연기하지? 【갑작스러운 사랑 My Page in the 90s】';

  @override
  String get bTSMyPageInThe =>
      '메이킹｜천싱쉬와 왕위원의 스케이트장 달콤한 충돌 【갑작스러운 사랑 My Page in the 90s】';

  @override
  String get bTSMyPageInThe2 =>
      '메이킹｜천싱쉬와 왕위원의 달콤한 새해맞이 【갑작스러운 사랑 My Page in the 90s】';

  @override
  String get bTSMyPageInThe3 =>
      '메이킹｜천싱쉬와 왕위원의 칠석 순간 포착 【갑작스러운 사랑 My Page in the 90s】';

  @override
  String get bTSMyPageInThe4 =>
      '메이킹｜천싱쉬와 왕위원의 즐거운 놀이공원 【갑작스러운 사랑 My Page in the 90s】';

  @override
  String get myPageInThe90s2 =>
      '《갑작스러운 사랑 My Page in the 90s》 오늘 첫 방송, 천싱쉬와 왕위원의 시스템 활용 달콤 로맨스';

  @override
  String get myPageInThe90s3 =>
      '《갑작스러운 사랑 My Page in the 90s》 1월 22일 달콤한 첫 방송, 천싱쉬와 왕위원의 반전 연애';

  @override
  String get myPageInThe90s4 =>
      '《갑작스러운 사랑 My Page in the 90s》 1월 22일 공개 확정! 천싱쉬와 왕위원의 시대를 초월한 열애';

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
  String get label2TheImperialCoronerS2 => '어사소오작2 The Imperial Coroner S2';

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
  String get theDreamMaker => '소성대사 The Dream Maker';

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
      '【경년 Forever Young】E23 마틴이 후퉁으로 돌아와 형제들에게 꽉 잡히다 (곽건화, 전우, 장설영, 교진우)';

  @override
  String get foreverYoungE25 =>
      '【경년 Forever Young】E25 침착·정확·단호! 마틴이 형수에게 남편 길들이는 법을 가르치다 (곽건화, 전우, 장설영, 교진우)';

  @override
  String get foreverYoungE24 =>
      '【경년 Forever Young】E24 연적 등장? 마틴이 풋내기에게 아저씨 소리를 듣다 (곽건화, 전우, 장설영, 교진우)';

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
  String get iQIYIGetTheIQIYIAPP => 'iQIYI 悬疑社 - iQIYI 앱 다운로드';

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
  String get getTheWeTVAPP3 => '腾讯视频 - 青春剧场 - WeTV 앱 다운로드';

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
  String get theHiddenHeirYeChen2 => '진격의 예천 The Hidden Heir Ye Chen';

  @override
  String get xtTr8ZBDpG => 'XtTr8ZBDp-g';

  @override
  String get dresmsNeverEnd => '들판의 바람을 들으러 Dreams Never End';

  @override
  String get mamaGo => '우리 엄마는 캠퍼스 여신 Mama Go!';

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
      '《순수시대의 사랑 Love Story in the 1970s》 듀얼 스토리 연대기 영상 공개~';

  @override
  String get loveStoryInThe1970s3 =>
      '《순수시대의 사랑 Love Story in the 1970s》 커플 영상 정식 공개~ 감각으로 써 내려가는 러브레터';

  @override
  String get bTSLoveStoryInThe =>
      '메이킹｜전원 촬영 종료, 다음 재회를 기대하며 【순진시대의 사랑 Love Story in the 1970s】';

  @override
  String get loveStoryInThe1970s4 =>
      '《순진시대의 사랑 Love Story in the 1970s》 사랑은 일상 속에 숨어 있는 시~';

  @override
  String get sGX3zNIuzM => 'SGX-3zNIuzM';

  @override
  String get loveStoryInThe1970s5 =>
      '《순진시대의 사랑 Love Story in the 1970s》 2월 21일 첫 방송 확정~';

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
  String get theTruth => '풍과유흔 The Truth';

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
      'BTS｜「배역 탈출 인터뷰」 고 대표와 환어, 과연 누구의 4차원이 한 수 위일까? 《갑작스러운 사랑 My Page in the 90s》 텐센트 비디오 - 청춘극장';

  @override
  String get rEk9xALNODE => 'REk9xALNODE';

  @override
  String get label04MyPageInThe2 =>
      '하이라이트 04 황당한 시스템의 억지 연출! 휴지가 생리대로? 이거 진짜 민망하네! 《갑작스러운 사랑 My Page in the 90s》 텐센트 비디오 - 청춘극장';

  @override
  String get label03MyPageInThe2 =>
      '하이라이트 03 절친 대신 나간 맞선, 알고 보니 남주 본인? 《갑작스러운 사랑 My Page in the 90s》 텐센트 비디오 - 청춘극장';

  @override
  String get xsb7BJppy0 => 'Xsb7B-Jppy0';

  @override
  String get label02MyPageInThe2 =>
      '하이라이트 02 남주를 공략하려다 사람을 잘못 봤다? 《갑작스러운 사랑 My Page in the 90s》 텐센트 비디오 - 청춘극장';

  @override
  String get label01MyPageInThe2 =>
      '하이라이트 01 말도 안 돼! 갑자기 책 속에 빙의했다고? 이 스토리를 어떻게 연기해? 《갑작스러운 사랑 My Page in the 90s》 텐센트 비디오 - 청춘극장';

  @override
  String get zSpXoH9ok => 'Z_SpXo-H9ok';

  @override
  String get myPageInThe90s5 =>
      '《갑작스러운 사랑 My Page in the 90s》BTS｜스케이트 타다 정면 충돌한 천싱쉬와 왕위원';

  @override
  String get myPageInThe90s6 =>
      '《갑작스러운 사랑 My Page in the 90s》 오늘 첫 방송! 천싱쉬와 왕위원의 달콤한 시스템 로맨스';

  @override
  String get bTSMyPageInThe5 =>
      'BTS｜천싱쉬와 왕위원의 장난기 가득한 케미, 썸 지수 초과 【갑작스러운 사랑 My Page in the 90s】';

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
  String get dearSecretary => '친애하는 나의 비서 Dear Secretary';

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
  String get foreverYoung2 => '轻年 영원한 청춘';

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
  String get lightOfDawn => '人之初 새벽의 빛';

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
  String get sniperButterfly => '狙击蝴蝶 스나이퍼 버터플라이';

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
      '《스나이퍼 버터플라이 Sniper Butterfly》 12월 4일 공개! 사랑을 위해 선을 넘다';

  @override
  String get sniperButterflyFullVersion1 =>
      '《스나이퍼 버터플라이 Sniper Butterfly》 풀버전 1-15｜주연: 천옌시, 저우커위 텐센트 비디오-청춘극장';

  @override
  String get sniperButterflyFullVersion16 =>
      '《스나이퍼 버터플라이 Sniper Butterfly》 풀버전 16-30｜주연: 천옌시, 저우커위 텐센트 비디오-청춘극장';

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
  String get allRise => '즉시 출전 All Rise';

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
  String get loveIsAlwaysOnline2 => '알맞은 때, 알맞은 사람 Love is Always Online';

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
      '《그는 왜 아직 싱글인가 Why Is He Still Single》 11월 16일 공개 확정! 곽건화, 주주 성숙한 남녀의 동화 같은 로맨스!';

  @override
  String get whyIsHeStillSingle3 =>
      '《그는 왜 아직 싱글인가 Why Is He Still Single》 풀버전｜주연: 곽건화, 주주 텐센트 비디오-청춘극장';

  @override
  String get ijgFlHRPHw => 'Ijg-FlHRPHw';

  @override
  String get whyIsHeStillSingle4 =>
      '《그는 왜 아직 싱글인가 Why Is He Still Single》 풀버전 1｜주연: 곽건화, 주주 텐센트 비디오-청춘극장';

  @override
  String get whyIsHeStillSingle5 =>
      '《그는 왜 아직 싱글인가 Why Is He Still Single》 풀버전 2｜주연: 곽건화, 주주 텐센트 비디오-청춘극장';

  @override
  String get yVGKe9xonY => 'YV-GKe9xonY';

  @override
  String get qKftsk37mXo => 'QKftsk37mXo';

  @override
  String get ccxy931pac => 'ccxy9-31pac';

  @override
  String get uc5hawjBFU => 'Uc5hawj_bFU';

  @override
  String get fightForLove => '산하침 Fight for Love';

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
  String get iMNobody => '아본무명 I\'m Nobody';

  @override
  String get persona => '중영 페르소나';

  @override
  String get d5CPVc0EIY => 'D5CPVc0E-IY';

  @override
  String get pJsHXm9ZsC => 'pJsHXm9Zs-c';

  @override
  String get vYRvNE7Yk => '-VYRvNE-7Yk';

  @override
  String get lightBeyondTheReed => '여생유애 Light Beyond the Reed';

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
  String get thePrisonerOfBeauty => '절요 요약본 The Prisoner of Beauty';

  @override
  String get wsGeYBRO => 'wsGeYB_-r_o';

  @override
  String get thePrisonerOfBeauty2 =>
      '《절요 요약본 The Prisoner of Beauty》 소교가 언니 대신 원수 집안으로 시집가 첫날부터 남편과 기싸움을 벌이다 | 주연: 송조아, 유우녕 텐센트 비디오-청춘극장';

  @override
  String get thePrisonerOfBeauty3 =>
      '《절요 요약본 The Prisoner of Beauty》 소교가 유염의 운하 폭파 음모를 저지하고 위소와 숙적에서 서로를 지켜주는 사이가 되다 | 주연: 송조아, 유우녕 텐센트 비디오-청춘극장';

  @override
  String get thePrisonerOfBeauty4 =>
      '《절요 요약본 The Prisoner of Beauty》 소교가 꾀병으로 안채를 차지하고 위소가 사람들 앞에서 아내를 싸고돌며 첩 두기를 거절하다 | 주연: 송조아, 유우녕 텐센트 비디오-청춘극장';

  @override
  String get thePrisonerOfBeauty5 =>
      '《절요 요약본 The Prisoner of Beauty》 소교가 나무 상자 모함 공작을 파헤치고 위소가 그녀를 집안의 안주인으로 인정하다 | 주연: 송조아, 유우녕 텐센트 비디오-청춘극장';

  @override
  String get thePrisonerOfBeauty6 =>
      '《절요 요약본 The Prisoner of Beauty》 소교가 지혜로 모함 공작을 파헤치고 위소가 아내를 인정하고 지키자 고부 갈등이 타오르다 | 주연: 송조아, 유우녕 텐센트 비디오-청춘극장';

  @override
  String get thePrisonerOfBeauty7 =>
      '《절요 요약본 The Prisoner of Beauty》 위엄이 가짜 편지로 도발하고 소교와 위소가 옥노리개 때문에 신뢰 위기에 빠지다 | 주연: 송조아, 유우녕 텐센트 비디오-청춘극장';

  @override
  String get thePrisonerOfBeauty8 =>
      '《절요 요약본 The Prisoner of Beauty》 서아황이 익힌 보리로 소교를 함정에 빠뜨리고 위소가 아내를 지키며 사건을 해결해 둘의 사이가 더욱 가까워지다 | 주연: 송조아, 유우녕 텐센트 비디오-청춘극장';

  @override
  String get thePrisonerOfBeauty9 =>
      '《절요 요약본 The Prisoner of Beauty》 소교와 위소가 암살 시도와 중독을 겪고 소교가 지혜로 음모를 파헤쳐 남편을 구하며 더욱 친밀해지다 | 주연: 송조아, 유우녕 텐센트 비디오-청춘극장';

  @override
  String get rNYFWNcb8o => 'RNYFW-Ncb8o';

  @override
  String get thePrisonerOfBeauty10 =>
      '《절요 요약본 The Prisoner of Beauty》 위소가 전마를 선물한 후 비녀를 챙겨주고 아내가 실종되자 안절부절못하다 | 주연: 송조아, 유우녕 텐센트 비디오-청춘극장';

  @override
  String get thePrisonerOfBeauty11 =>
      '《절요 요약본 The Prisoner of Beauty》 위소가 소교가 도망칠까 봐 질투하며 아내를 감싸고 이사 나갔다가 후회하며 그녀를 그리워하다 | 주연: 송조아, 유우녕 텐센트 비디오-청춘극장';

  @override
  String get thePrisonerOfBeauty12 =>
      '《절요 요약본 The Prisoner of Beauty》 위소가 질투하며 소교를 업어주고 나무 상자 의문이 풀리며 둘 사이가 더욱 가까워지다 | 주연: 송조아, 유우녕 텐센트 비디오-청춘극장';

  @override
  String get thePrisonerOfBeauty13 =>
      '《절요 요약본 The Prisoner of Beauty》 교자가 누나를 찾아와 위소의 질투를 유발하고 소교 부부가 진심을 터놓으며 평생을 약속하다 | 주연: 송조아, 유우녕 텐센트 비디오-청춘극장';

  @override
  String get thePrisonerOfBeauty14 =>
      '《절요 축약본 The Prisoner of Beauty》 웨이옌은 소교를 위해 고향을 떠나고, 샤오와 교는 다툰 후 화해함｜주연: 송조아, 유우녕 텐센트 비디오 - 청춘극장';

  @override
  String get ry1BWClaV0 => 'ry1BWCla-V0';

  @override
  String get thePrisonerOfBeauty15 =>
      '《절요 축약본 The Prisoner of Beauty》 첫날밤 군사 반란으로 자매가 대립하고, 소교는 지혜로 적을 물리치고 웨이샤오는 잘못을 인정함｜주연: 송조아, 유우녕 텐센트 비디오 - 청춘극장';

  @override
  String get o8nFcvzyvM => 'O8n-FcvzyvM';

  @override
  String get thePrisonerOfBeauty16 =>
      '《절요 축약본 The Prisoner of Beauty》 웨이샤오가 소교와 함께 강군으로 돌아가 앙금을 풀고, 교 아버지가 사위를 인정해 두 사람이 합방함｜주연: 송조아, 유우녕 텐센트 비디오 - 청춘극장';

  @override
  String get krsrk6wSAy8 => 'Krsrk6wSAy8';

  @override
  String get thePrisonerOfBeauty17 =>
      '《절요 축약본 The Prisoner of Beauty》 교월의 반란으로 웨이량이 목숨을 잃고, 대교가 납치되자 비치가 목숨 걸고 반격함｜주연: 송조아, 유우녕 텐센트 비디오 - 청춘극장';

  @override
  String get v26fn6w270 => 'V-26fn6w270';

  @override
  String get thePrisonerOfBeauty18 =>
      '《절요 축약본 The Prisoner of Beauty》 웨이량이 전사하고 웨이취는 팔을 잃으며, 대교가 추락하고 유염이 멸망함｜주연: 송조아, 유우녕 텐센트 비디오 - 청춘극장';

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
      '조별 과제가 느리다고 구박받으니? 재벌 대표가 한밤중에 창문으로 PPT 전해주다 경비원한테 쫓김 텐센트 비디오 - 청춘극장';

  @override
  String get zPBZ1KRQ3hY => 'ZPBZ1KRQ3hY';

  @override
  String get aThousandMilesToYour =>
      '수많은 도시를 지나 비로소 당신을 알았네 A Thousand Miles to Your Heart';

  @override
  String get getTheWeTVAPP4 => '텐센트 비디오 - 사극극장 - WeTV 앱 받기';

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
  String get theInescapable => '쇄잠 The Inescapable';

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
      '《강호야우십년등 Generation to Generation》 2월 22일 공개 확정! 강호 최강의 신세대 무무와 소소의 강호 모험을 확인하세요!';

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
  String get the300LoyalGhosts2 => '대명암영 삼백충혼 The 300 Loyal Ghosts';

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
  String get danceOfThePhoenix => '차청봉명 Dance of The Phoenix';

  @override
  String get f0uIRYSOwo => 'F0uIRY_SOwo';

  @override
  String get extraordinary2 => '비범 Extraordinary';

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
      '<어사소오작2 The Imperial Coroner S2> 1월 15일 공개 확정, 초유 부부의 따뜻한 컴백!';

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
  String get rebirthForYou => '가남전 Rebirth For You';

  @override
  String get f9eLAZQDUds => 'F9eLAZQDUds';

  @override
  String get aVowInTheDark2 => '연연풍릉도 A Vow in the Dark';

  @override
  String get theUltimateVowUnknownTo => '군부지 The Ultimate Vow, Unknown to You';

  @override
  String get duMRGzTeKs => 'DuM-rGzTeKs';

  @override
  String get pLs3DOuT3JlGTynSBKz3Z5DcDzwwmqSOf =>
      'PLs3DOuT3JlGTynSBKz3-z5DcDzwwmqSOf';

  @override
  String get theChangAnYouth => '장안소년행 The Chang\'An Youth';

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
  String get thePrincessDecree2 => '평응유령 The Princess Decree';

  @override
  String get ppiNYsUwOA => 'PpiNYs-uwOA';

  @override
  String get label83tIjIiqM => '-_83tIjIiqM';

  @override
  String get p4cKjzSHFw => 'P4cKjz-sHFw';

  @override
  String get babysitter => '냉궁의 산후도우미 Babysitter';

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
  String get herPhoenixMajesty2 => '봉황전 Her Phoenix Majesty';

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
  String get aGirlLikeMe2 => '아취시적반녀자 A Girl Like Me';

  @override
  String get p4YsJ5WtBw => 'p4YsJ5Wt-bw';

  @override
  String get pIg2oXFWS8 => 'pIg2oXFWS-8';

  @override
  String get hrJz2C0Fxs => 'hrJz-2C0Fxs';

  @override
  String get mL0phSCWJY => 'mL0phSC-wJY';

  @override
  String get sideStoryOfFoxVolant2 => '비호외전 Side Story of Fox Volant';

  @override
  String get pLs3DOuT3JlGQCkd77fhalA8WxMD3OT4Q =>
      'PLs3DOuT3JlGQCkd77fhalA8Wx-mD3OT4Q';

  @override
  String get aFlowerOnTheContinent2 => '유화재주 A Flower On The Continent';

  @override
  String get aFlowerOnTheContinent3 =>
      '【유화재주 A Flower On The Continent】 인질이 된 소왕야, 화 낭자에게 억지로 공주 취급받으며 한방 생활까지';

  @override
  String get aFlowerOnTheContinent4 =>
      '【유화재주 A Flower On The Continent】 화 낭자의 여장이 들통나고, 소왕야는 목숨 걸고 그녀를 지켰으나 도리어 누명을 쓰다';

  @override
  String get aFlowerOnTheContinent5 =>
      '【유화재주 A Flower On The Continent】 화석옥은 아버지를 죽인 원수가 닝쉬안저우의 부친임을 알고 그 자리에서 분노한다';

  @override
  String get aFlowerOnTheContinent6 =>
      '【유화재주 A Flower On The Continent】 화석옥은 혼례복을 입고 적진에 침투해 목숨을 걸고 닝쉬안저우를 구하다 목숨을 잃을 뻔한다';

  @override
  String get aFlowerOnTheContinent7 =>
      '【유화재주 A Flower On The Continent】 양국이 화친 조약을 맺자, 닝쉬안저우는 조서를 찢으며 화석옥과 결혼하겠다고 고집한다';

  @override
  String get aFlowerOnTheContinent8 =>
      '【유화재주 A Flower On The Continent】 화석옥은 손목을 그어 약을 만들고, 닝쉬안저우는 부황이 그녀의 아버지를 죽였음을 고발한다';

  @override
  String get aFlowerOnTheContinent9 =>
      '【유화재주 A Flower On The Continent】 화석옥은 아버지를 죽인 자가 닝쉬안저우의 부친임을 알고 꽃밭에서 정표 나뭇가지를 잘라버린다';

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
  String get hilariousFamily22 => '분방희사 Hilarious Family 2';

  @override
  String get sliceOfLife => '일상';

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
  String get legendOfTheFemaleGeneral => '금월어가 Legend of The Female General';

  @override
  String get highlightLegendOfTheFemale =>
      '하이라이트 모음 【금월여가 Legend of The Female General】';

  @override
  String get a40F2TEZrms => 'A40F2TEZrms';

  @override
  String get lYQ5iND4 => 'lYQ5iN-d-_4';

  @override
  String get bTSLegendOfTheFemale =>
      '[메이킹] 저우예의 생일 비하인드 🎂! 【금월여가 Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale2 =>
      '[메이킹] 소 도독 청레이의 생일 비하인드 🎂! 【금월여가 Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale3 =>
      '[메이킹] 전장에서의 멋진 합동 액션, 걸크러시 넘치는 대위의 두 별 【금월여가 Legend of The Female General】';

  @override
  String get bTS520LegendOfThe =>
      '[메이킹] 희소안개의 520 데이트 코스 【금월여가 Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale4 =>
      '[메이킹] 취한 저우예의 심쿵 귀여움~ 검무 출 때 반전 매력 폭발! 옆에서 웃음 못 참는 청레이 【금월여가 Legend of The Female General】';

  @override
  String get pLs3DOuT3JlGRucYIZLqmT7FO5IWDWrP =>
      'PLs3DOuT3JlGRuc_yIZLqmT7FO5IWD-WrP';

  @override
  String get thePrincessSGambit => '도화영강산 The Princess\'s Gambit';

  @override
  String get highlightThePrincessSGambit =>
      '하이라이트 모음 【도화영강산 The Princess\'s Gambit】';

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
      '[클립] 붉은 옷으로 흰 눈을 물들이다! 장도화, 어린 남동생을 지키려 고향을 떠나 기국으로 시집가다 【도화영강산 The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit2 =>
      '[클립] 혼인날 심부의 처첩들이 떼지어 행패? 도화, 후퇴를 전진 삼아 담담히 응수 【도화영강산 The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit3 =>
      '[클립] 도화의 기절 자작극 간파한 심재야, 침으로 깨우며: 어디 계속 연기해보시지! 【도화영강산 The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit4 =>
      '[클립] 심 재상의 지독한 수사! 위조화폐 사건을 신속히 철저 수사하자 덜덜 떠는 탐관오리들 【도화영강산 The Princess\'s Gambit】';

  @override
  String get eDrJjtCRF0 => 'eDr-jjtCRF0';

  @override
  String get clipThePrincessSGambit5 =>
      '[클립] 자객의 완벽 위장도 못 피한 처벌, 명탐정 도화: 네 발이 덜미를 잡았어! 【도화영강산 The Princess\'s Gambit】';

  @override
  String get clipPlayThePrincessS =>
      '[클립] 비녀 심문 PLAY! 심재야, 비녀로 도화의 턱을 치켜들며 차갑게 취조 【도화영강산 The Princess\'s Gambit】';

  @override
  String get label58K8GxhXlQ => '58K8-gxhXlQ';

  @override
  String get clipThePrincessSGambit6 =>
      '클립 첫 만남부터 이렇게 파격적이라니! 심재야와 도화, 합환산에 중독된 채 서로를 바라보다【도화영강산 The Princess\'s Gambit】';

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
      '【한정 전편 공개】운향전 | The Ingenious One | iQIYI 👑지금 멤버십에 가입하고 전편을 시청해보세요!';

  @override
  String get iQIYIGetTheIQIYIAPP2 => 'iQIYI 아이치이 - iQIYI 앱 다운로드';

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
  String get fULLROADHOMEBoranJingSeven => '【전편】👮귀로💕 | 정백연, 담송운 | iQIYI 필리핀';

  @override
  String get iQIYIPhilippinesGetTheIQIYI => 'iQIYI 필리핀 - iQIYI 앱 다운로드';

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
  String get aIEnglishDubMrBAD => '【AI 영어 더빙】Mr. BAD | 진철원, 심월 | iQIYI 필리핀';

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
      '🌸【판타지 선협】🎋선대유수 Love of the Divine Tree 仙台有树 | 덩웨이 × 샹한즈 | FULL 정편 | iQIYI 👑지금 멤버십에 가입하고 전편을 즐기세요!';

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
  String get fULLMyDearGuardianJohnny => '【전편】🕊️친애적융장 | 황징위, 리친 | iQIYI 필리핀';

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
      '🌸【힐링 로맨스】🎋애니 (The Best Thing) | 장링허 × 쉬뤄한 | FULL 본편 | iQIYI 👑지금 멤버십에 가입하고 전편을 감상하세요!';

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
      '📽️【EP01 2026】빙호중생 중국 드라마 영문자막 | 리윈루이 / 황양톈톈 / 장캉러 ⛵😍 사극 2026 #빙호중생';

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
      '【전편】🏹Fated Hearts | 리친, 천쩌위안 | iQIYI 필리핀';

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
      '【전편】 Bright Eyes in the Dark | 황징위, 장징이 | iQIYI 필리핀';

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
      '🎥✨【영어 자막】 중국 판타지 영화 | 판타지, 모험 【아이치이 영화관 - 구독을 환영합니다】';

  @override
  String get iQIYIMOVIETHEATERGetThe =>
      '아이치이 영화관 iQIYI MOVIE THEATER - iQIYI 앱 받기';

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
      '🎀【미니 드라마 Mini Drama】영어 자막 | 전편 모음집 | WeTV / Tencent Video 앱에서 더 보기';

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
      '【전편】화융(Beauty of Resilience) | 쥐징이, 궈쥔천 | iQIYI Philippines';

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
      '🔥인기 급상승【자야귀 Moonlit Reunion】전편 | 사건을 해결하며 사랑에 빠지는 인간과 요괴 | 쉬카이, 톈시웨이 | 영어 자막';

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
  String get fallInLove => '사랑에 빠지다';

  @override
  String get myGirl => '마이 걸';

  @override
  String get firstRomance2 => '첫 로맨스';

  @override
  String get fallFor => '반하다';

  @override
  String get uCD83JhUFQXRDwC6S8caCQ => 'UCD_83Jh-UFQXRDwC6S8caCQ';

  @override
  String get uCFh5x5AZHQQ6FaGKnGQXDA => 'UCFh5x5AZHQQ6FaGKnG-QXDA';

  @override
  String get uCRABdhiBHX4BieJfPCd2pg => 'UCRABdhiBHX4Bie-jfPCd2pg';

  @override
  String get hiddenLove2 => '투투장부주';

  @override
  String get loveBetweenFairyAndDevil2 => '창란결';

  @override
  String get loveLikeTheGalaxy2 => '성한찬란';

  @override
  String get myJourneyToYou2 => '운지깃';

  @override
  String get mysteriousLotusCasebook2 => '연화루';

  @override
  String get reset => '초기화';

  @override
  String get theLongBallad2 => '장가행';

  @override
  String get theUntamed2 => '진정령';

  @override
  String get wordOfHonor2 => '산하령';

  @override
  String get lightOfDawn2 => '人之初 새벽의 빛';

  @override
  String get hOMELANDGUARDIAN2 => '守诚者|조국 수호자';

  @override
  String get searching2 => '검색 중...';

  @override
  String get verse => '시구';

  @override
  String get allStories2 => '모든 이야기';

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
  String get char2 => '+ 글자 +';

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
      '기사, .article, .post, .content, 메인';

  @override
  String get ttsActiveWord => '.tts-active-word';

  @override
  String get ttsActiveWord2 => 'tts-active-word';

  @override
  String get upperIntermediate2 => '중상급';

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
  String get processing => '처리 중…';

  @override
  String get keepItUp => '好！ 계속 힘내세요';

  @override
  String get minutesDay => '분 / 일';

  @override
  String get consistencyIsTheInkThat => '\"꾸준함은 한자를 완성하는 먹물입니다.\"';

  @override
  String get businessCareer => '비즈니스 및 커리어';

  @override
  String get travelSurvival => '여행 및 필수 회화';

  @override
  String get label05MinDay => '05분 / 일';

  @override
  String get label10MinDay => '10분 / 일';

  @override
  String get label20MinDay => '20분 / 일';

  @override
  String get label30MinDay => '30분 / 일';

  @override
  String get dynamicDecksStrokeAnalysis => '동적 덱 및 획순 분석';

  @override
  String get subscriptionsAreTemporarilyUnavailablePl =>
      '구독 서비스를 일시적으로 사용할 수 없습니다. 다시 시도해 주세요.';

  @override
  String get trialReminder => '무료 체험 알림';

  @override
  String get turnOnNotificationsIfYou =>
      '무료 체험 기간이 만료되기 전에 알림을 받으려면 알림을 켜세요. 최종 구독 정보는 App Store 구독 설정에서 확인하실 수 있습니다.';

  @override
  String get label2Months => '2개월';

  @override
  String get label3Months => '3개월';

  @override
  String get label6Months => '6개월';

  @override
  String get billingPeriod => '결제 주기';

  @override
  String get chooseASubscription => '구독 플랜 선택';

  @override
  String get startFreeTrial => '무료 체험 시작';

  @override
  String get smartNewsDict => '스마트 뉴스 및 사전';

  @override
  String get hSK16AIDecks => 'HSK 1~6 및 AI 덱';

  @override
  String get continueWithTemporaryPremium => '임시 프리미엄으로 계속하기';

  @override
  String get testProductUnavailable => '테스트 상품을 사용할 수 없습니다';

  @override
  String get paymentIsChargedToYour => '결제 금액은 App Store 계정으로 청구됩니다.';

  @override
  String get subscriptionsRenewAutomaticallyUnlessCan =>
      '취소하지 않으면 구독이 자동으로 갱신됩니다';

  @override
  String get atLeast24HoursBefore => '현재 기간 종료 최소 24시간 전에.';

  @override
  String get privacyPolicy => '개인정보 처리방침';

  @override
  String get closePurchaseOffer => '구매 제안 닫기';

  @override
  String get loading => '로딩 중...';

  @override
  String get analyzingImage2 => '이미지 분석 중…';

  @override
  String get extractingChineseText2 => '중국어 텍스트 추출 중…';

  @override
  String get lookingUpVocabulary2 => '어휘 검색 중…';

  @override
  String get deselectAll => '전체 선택 해제';

  @override
  String get selectAll => '전체 선택';

  @override
  String get worldChineseLiteraryMasterpiece => '세계 및 중국 문학의 명작.';

  @override
  String get classic => '고전';

  @override
  String get literature => '문학';

  @override
  String get theOriginAwakening => '기원과 깨어남';

  @override
  String get turbulentHorizonsTheJourney => '격동의 지평과 여정';

  @override
  String get trialsTribulationsDevotion => '시련, 고난, 그리고 헌신';

  @override
  String get theClashOfWitsBravery => '지혜와 용기의 대결';

  @override
  String get theGrandClimaxResolution => '대단원과 결말';

  @override
  String get everlastingLegacyEpilogue => '영원한 유산과 에필로그';

  @override
  String get acrossTheVastExpanseOf =>
      '광활한 천지 속에서, 등장인물들은 깊은 시련을 거치며 자신만의 운명과 신념을 좇아갑니다.';

  @override
  String get everyDialogueAndEncounterWithin =>
      '이야기 속 모든 대화와 만남에는 인간 정신의 빛나는 가치와 시대의 흔적이 새겨져 있습니다.';

  @override
  String get followingTheFlowOfProse =>
      '글의 흐름을 따라 독자는 수백 년의 세월을 넘어 전설적 인물들의 영광과 슬픔을 함께합니다.';

  @override
  String get preQin => '선진';

  @override
  String get theGoddessNWaRepairing => '하늘을 메우는 여와 여신';

  @override
  String get artsTraditions => '예술 및 전통';

  @override
  String get femaleWarm => '여성, 따뜻함';

  @override
  String get femaleCheerful => '여성, 밝음';

  @override
  String get maleUpbeat => '남성, 경쾌함';

  @override
  String get maleNewsStyle => '남성, 뉴스 스타일';

  @override
  String get maleSporty => '남성, 스포티';

  @override
  String get onDevice => '온디바이스';

  @override
  String get label15Minutes => '15분';

  @override
  String get label30Minutes => '30분';

  @override
  String get label45Minutes => '45분';

  @override
  String get selectChapter => '챕터 선택';

  @override
  String get andContinuesToBeStudied => '또한 세대를 넘어 독자들에게 계속 연구되고 사랑받고 있습니다.';

  @override
  String get label1Poem => '시 1편';

  @override
  String get label1Chapter => '1개 챕터';

  @override
  String get localDeviceVoice2 => '기기 로컬 음성';

  @override
  String get weeklyAzureQuotaReachedSwitching =>
      '주간 Azure 한도 도달 — 기기 로컬 음성으로 전환합니다';

  @override
  String get sleepTimer2 => '취침 타이머';

  @override
  String get tableOfContents2 => '목차';

  @override
  String get hanziMaster10 => 'HanziMaster/1.0';

  @override
  String get spanishItalianRussianClassics => '스페인·이탈리아·러시아 고전';

  @override
  String get englishAmericanGlobalClassics => '영미 및 세계 고전';

  @override
  String get whileStrategicallyEmbeddingWordsYou =>
      '현재 어려워하는 단어를 문맥 속에서 학습할 수 있도록 전략적으로 배치합니다.';

  @override
  String get poetryPainting => '시화';

  @override
  String get contactSinosparkCom => 'contact@sinospark.com';

  @override
  String get shadowingStudioIsADedicated =>
      '섀도잉 스튜디오는 원어민 따라 말하기를 연습하는 전용 공간입니다. 문장을 듣고 녹음한 후, 파형과 발음 점수를 비교하여 억양을 교정할 수 있습니다.';

  @override
  String get theVoicesInAIStories =>
      'AI 스토리와 롤플레잉은 명확하고 자연스러운 중국어 발음에 맞게 조정된 고급 음성 합성 모델의 합성 음성을 사용합니다. 일부 기능에서는 기기의 로컬 음성도 사용할 수 있습니다.';

  @override
  String get theWebExplorerAllowsYou =>
      '웹 탐색기를 사용하여 모든 중국어 웹사이트를 탐색할 수 있습니다. 어려운 단어를 발견하면 탭하여 퀵 룩 카드를 열고 병음, 번역, HSK 등급을 즉시 확인해보세요.';

  @override
  String get zenModeStripsAwayDistracting =>
      '선(Zen) 모드는 기사의 산만한 웹 요소, 광고, 복잡한 레이아웃을 제거하여 텍스트에만 집중할 수 있는 깔끔한 서예 스타일의 독서 환경을 제공합니다.';

  @override
  String get weUseAnIntelligentAlgorithm =>
      '지능형 알고리즘을 통해 단어를 잊어버릴 시점을 예측합니다. 어려운 단어는 더 자주 나타나고, 잘 아는 단어는 나중에 복습하도록 일정이 조정됩니다.';

  @override
  String get usage3 => '용례:';

  @override
  String get tutorialOneExplanation =>
      '이것은 숫자 \'一(Yī)\'입니다. 항상 왼쪽에서 오른쪽으로 획을 그으세요.';

  @override
  String get tutorialWaterExplanation =>
      '이것은 \'水(Shuǐ)\' 글자입니다. 왼쪽에 부수로 사용될 때는 \'氵\'(삼수변) 형태로 변형됩니다!';

  @override
  String get tutorialRadicalsExplanation =>
      '한자는 \'부수\'라는 기본 요소로 구성됩니다. 부수는 한자의 핵심 의미나 주제를 나타냅니다.';

  @override
  String get tutorialLettersExplanation =>
      '한자는 단순한 글자가 아닌 시간 속에 멈춘 그림입니다. 한자를 마스터하려면 획의 흐름을 익혀야 합니다.';

  @override
  String get tutorialGalaxyExplanation =>
      '은하수 지도가 기다리고 있습니다. 항성(부수)을 마스터하여 행성(한자)을 해금해보세요.';

  @override
  String get onboardingDailyLifeTravel => '일상생활 및 여행';

  @override
  String get onboardingPhilosophyIdioms => '철학 및 성어';

  @override
  String get onboardingBusinessCareerMulti => '비즈니스 및\n커리어';

  @override
  String get onboardingTravelSurvivalMulti => '여행 및\n필수 표현';

  @override
  String get onboardingHskCertificationMulti => 'HSK\n자격증';

  @override
  String get onboardingCulturalAppreciationMulti => '문화\n이해';

  @override
  String get practiceReminders => '연습 알림';

  @override
  String get oneOptionalDailyReminderTo => '중국어 학습을 위한 매일 알림 (선택 사항)';

  @override
  String get aFewMinutesOfChinese => '잠시 중국어 공부해보실래요? 🌱';

  @override
  String get keepYourProgressMovingWith => '짧은 연습으로 꾸준히 실력을 쌓아보세요.';

  @override
  String get xuX => 'xué xí';

  @override
  String get toStudyToLearn => '공부하다 · 배우다';

  @override
  String get pNgYou => 'péng you';

  @override
  String get fXiN => 'fā xiàn';

  @override
  String get toDiscover => '발견하다';

  @override
  String get jiNCh => 'jiān chí';

  @override
  String get toPersist => '지속하다';

  @override
  String get yNgQ => 'yǒng qì';

  @override
  String get zhHu => 'zhì huì';

  @override
  String get chNgZhNg => 'chéng zhǎng';

  @override
  String get toGrow => '성장하다';

  @override
  String get pNgJNg => 'píng jìng';

  @override
  String get calmPeaceful => '차분함 · 평온함';

  @override
  String get xWNg => 'xī wàng';

  @override
  String get lJi => 'lǐ jiě';

  @override
  String get toUnderstand => '이해하다';

  @override
  String get xGuN => 'xí guàn';

  @override
  String get wNNuN => 'wēn nuǎn';

  @override
  String get warmthWarm => '온기 · 따뜻함';

  @override
  String get zhuNZh => 'zhuān zhù';

  @override
  String get toFocus => '집중하다';

  @override
  String get definitionExpansionButton => '정의 확장 버튼';

  @override
  String get wenigerAnzeigen => '간략히 보기';

  @override
  String get mostrarMenos => '간략히 보기';

  @override
  String get afficherMoins => '간략히 보기';

  @override
  String get mostraMeno => '간략히 보기';

  @override
  String get showFewer => '간략히 보기';

  @override
  String get masterLin => '마스터 린';

  @override
  String get xiaoMei => '샤오메이';

  @override
  String get thePoet => '시인';

  @override
  String get aQiang => '아창';

  @override
  String get vivian => '비비안';

  @override
  String get formalWise => '격식 있고 지혜로운';

  @override
  String get casualFriendly => '편안하고 친근한';

  @override
  String get poeticAncient => '시적이고 고전적인';

  @override
  String get slangInternet => '신조어 및 인터넷 용어';

  @override
  String get trendyModern => '트렌디하고 현대적인';

  @override
  String get designYourOwn => '직접 만들기';

  @override
  String get theBambooSwaysAndThe => '대나무가 흔들리고, 선비는 단비 같은 당신의 말을 기다립니다...';

  @override
  String get yourCustomPersonaIsActive => '맞춤 페르소나가 활성화되었습니다. 대화를 시작하려면 입력하세요.';

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
  String get staleDictionaryExpansionResponse => '만료된 사전 확장 응답';

  @override
  String get dictionaryExpansionWasEmpty => '사전 확장 내용이 없습니다';

  @override
  String get explicationDTaillEDisponible => '상세 설명 이용 가능';

  @override
  String get ausfHrlicheErklRungVerf => '상세 설명 이용 가능';

  @override
  String get explicaciNDetalladaDisponible => '상세 설명 이용 가능';

  @override
  String get spiegazioneDettagliataDisponibile => '상세 설명 이용 가능';

  @override
  String get explicaODetalhadaDisponVel => '상세 설명 이용 가능';

  @override
  String get detailedExplanationAvailable => '상세 설명 이용 가능';

  @override
  String get oneOptionalDailyPracticeReminder => '선택 가능한 매일 연습 알림 1개';

  @override
  String get chooseOneOptionalDailyPractice => '매일 연습 알림을 선택하세요.';

  @override
  String get practiceReminder => '연습 알림';

  @override
  String get oneGentleReminderADay => '필요할 때만 전해지는 하루 한 번의 다정한 알림';

  @override
  String get finishingPracticeSilencesTodayS => '연습을 완료하면 오늘 알림이 꺼집니다. 복습 및';

  @override
  String get reEngagementAlertsAreCombined => '재참여 알림이 하나로 통합되어 겹치지 않습니다.';

  @override
  String get processing2 => '처리 중…';

  @override
  String get wDKIChu => 'wǒ dǎ kāi chuāng hu';

  @override
  String get listen => '듣기';

  @override
  String get notice => '살펴보기';

  @override
  String get fourTones => '4가지 성조';

  @override
  String get write => '쓰기';

  @override
  String get recap => '정리';

  @override
  String get playbackDidNotStart => '재생이 시작되지 않았습니다';

  @override
  String get audioIsUnavailableYouCan =>
      '오디오를 사용할 수 없습니다. 글을 읽고 계속 진행하실 수 있습니다.';

  @override
  String get microphoneAccessWasNotGranted =>
      '마이크 접근 권한이 허용되지 않았습니다. 설정에서 활성화할 수 있습니다.';

  @override
  String get recordingIsUnavailableRightNow => '지금은 녹음을 사용할 수 없습니다.';

  @override
  String get listeningToYourTones => '성조를 듣고 있습니다…';

  @override
  String get noRecording => '녹음 없음';

  @override
  String get weCouldNotScoreThat => '녹음 결과를 채점할 수 없어 샘플 성조 비교를 보여드립니다.';

  @override
  String get listenForTheLowDipping => '낮게 내려갔다 올라가는 3성을 들어보세요.';

  @override
  String get firstHearATinyMoment => '먼저 짧은 중국어를 들어보세요. 아직 암기할 필요는 없습니다.';

  @override
  String get loadingAudio => '오디오 불러오는 중…';

  @override
  String get listenToThePassage => '지문 듣기';

  @override
  String get continueAction => '계속하기';

  @override
  String get noticeHowMeaningSoundAnd => '의미와 소리, 한자가 어떻게 함께 연결되는지 살펴보세요.';

  @override
  String get shadowOneSentence => '한 문장 따라 말하기';

  @override
  String get listenOnceThenHoldThe => '한 번 듣고 마이크 버튼을 누른 채 문장을 따라 말해보세요.';

  @override
  String get hearItAgain => '다시 듣기';

  @override
  String get stopAndCheckMyTones => '멈추고 성조 확인하기';

  @override
  String get useMicrophone => '마이크 사용';

  @override
  String get iCanTSpeakRight => '지금은 말할 수 없음';

  @override
  String get tapACharacterToCompare =>
      '글자를 탭하여 녹음한 성조와 목표 성조를 비교하고 1~4성을 들어보세요.';

  @override
  String get tryHandwriting => '직접 써보기';

  @override
  String get seeWhatYouLearned => '학습 내용 확인하기';

  @override
  String get inAFewMinutesYou => '몇 분 만에 레슨의 핵심 학습 루프를 직접 경험하셨습니다.';

  @override
  String get listenedToChineseInContext => '문맥 속 중국어 듣기';

  @override
  String get shadowedASentence => '문장 따라 말하기(쉐도잉)';

  @override
  String get comparedMandarinTones => '중국어 성조 비교하기';

  @override
  String get practicedARealCharacter => '실제 한자 연습하기';

  @override
  String get qNgchNXiOy =>
      'Qīngchén, xiǎoyǔ tíng le. Wǒ dǎkāi chuānghu, tīngjiàn niǎor zài shù shàng chànggē. Xīn de yì tiān kāishǐ le.';

  @override
  String get atDawnTheLightRain =>
      '이른 아침, 가랑비가 그쳤습니다. 창문을 열자 나무에서 새들이 지저귀는 소리가 들렸습니다. 새로운 하루가 시작되었습니다.';

  @override
  String get learnThroughRealVideos => '생생한 영상으로 학습하기';

  @override
  String get followInteractiveSubtitlesLookUp =>
      '대화형 자막을 따라가며 단어를 즉시 검색하고, 모든 영상을 레슨으로 활용해 보세요.';

  @override
  String get videoLearningScreenshot => '영상 학습 스크린샷';

  @override
  String get turnAnyBookIntoA => '모든 책을 레슨과 오디오북으로 활용하기';

  @override
  String get readNaturallyWithPronunciationDefinition =>
      '필요할 때 언제든 발음, 뜻, 번역을 확인하며 자연스럽게 읽어 보세요.';

  @override
  String get bookReaderScreenshot => '도서 리더 스크린샷';

  @override
  String get speakWithTheRightRhythm => 'AI 및 실시간 성조로 자유롭게 대화하기';

  @override
  String get shadowNativeAudioAndVisualize =>
      '원어민 오디오를 따라 말하며 발음 변화에 맞춰 4개 성조를 시각적으로 확인해 보세요.';

  @override
  String get shadowingAndTonesScreenshot => '쉐도잉 및 성조 스크린샷';

  @override
  String get understandEveryCharacter => '모든 글자 완벽하게 이해하기';

  @override
  String get exploreMeaningPronunciationComponentsStr =>
      '뜻, 발음, 부수, 획순, 유용한 어휘까지 한곳에서 탐색해 보세요.';

  @override
  String get characterDictionaryScreenshot => '한자 사전 스크린샷';

  @override
  String get learnChineseWithoutLimits => '제한 없는 중국어 학습';

  @override
  String get watchReadSpeakAndUnderstand =>
      '하나의 올인원 학습 파트너로 중국어를 보고, 읽고, 말하고, 이해해 보세요.';

  @override
  String get seeWhatPremiumUnlocks => '프리미엄 혜택 확인하기';

  @override
  String get scrollToExploreTheComplete => '스크롤하여 전체 학습 기능을 둘러보세요';

  @override
  String get cOMINGSOON => '출시 예정';

  @override
  String get guidedHandwritingPractice => '가이드형 쓰기 연습';

  @override
  String get scannerAndLiveTranslation => '스캐너 및 실시간 번역';

  @override
  String get hSK16AndAI => 'HSK 1–6 및 AI 덱';

  @override
  String get smartSpacedRepetition2 => '스마트 간격 반복 학습';

  @override
  String get progressAndStreakTracking => '진도 및 연속 학습 추적';

  @override
  String get learningToolsInOnePlace => '모든 학습 도구를 한곳에서';

  @override
  String get everythingIncluded => '모든 기능 포함';

  @override
  String get paymentIsChargedToYour2 =>
      '결제는 App Store 계정으로 청구됩니다. 현재 기간이 끝나기 최소 24시간 전에 취소하지 않으면 구독이 자동으로 갱신됩니다.';

  @override
  String get yourFirstWeekOfTracked => '기록된 첫 주 연습';

  @override
  String get sameNumberOfCardsAs => '지난주와 동일한 카드 수';

  @override
  String cardsComparedWithLastWeek(String change) {
    return '지난주 대비 카드 $change';
  }

  @override
  String get todaySPractice => '오늘의 연습';

  @override
  String get goalCompleteAnythingMoreIs => '목표 달성 — 추가 학습은 보너스입니다.';

  @override
  String get aSmallAchievableTargetNo => '달성 가능한 작은 목표. 쉬어가는 날도 부담 없이.';

  @override
  String get thisWeek => '이번 주';

  @override
  String get minutes => '분';

  @override
  String get activeDays => '학습한 날';

  @override
  String dayStreakCount(int count) {
    return '$count일 연속';
  }

  @override
  String get masterChineseOneStrokeAt => '한 획씩 완성하는 중국어';

  @override
  String get dictionaryExpansionButton => '사전 확장 버튼';

  @override
  String get kIErweiterterWRterbucheintrag => 'AI 확장 사전 항목';

  @override
  String get detalleAmpliadoPorIA => 'AI 확장 사전 설명';

  @override
  String get dTailEnrichiParL => 'AI 확장 사전 설명';

  @override
  String get aI => 'AI 확장 사전 설명';

  @override
  String get detailKamusYangDiperluasAI => 'AI 확장 사전 설명';

  @override
  String get dettaglioDelDizionarioAmpliatoDall => 'AI 확장 사전 설명';

  @override
  String get aI2 => 'AI 확장 사전 설명';

  @override
  String get aI3 => 'AI 확장 사전 설명';

  @override
  String get detalheDeDicionRioExpandido => 'AI 확장 사전 설명';

  @override
  String get aI4 => 'AI 확장 사전 설명';

  @override
  String get chiTiTTI => 'AI 확장 사전 설명';

  @override
  String get aI5 => 'AI 확장 사전 설명';

  @override
  String get aIExpandedDictionaryDetail => 'AI 확장 사전 설명';

  @override
  String get cetteEntrEEstBr => '사전 내용이 간략합니다. 상세 설명을 확인할 수 있습니다.';

  @override
  String get dieserEintragIstKurzEine => '사전 내용이 간략합니다. 상세 설명을 확인할 수 있습니다.';

  @override
  String get estaEntradaEsBreveHay => '사전 내용이 간략합니다. 상세 설명을 확인할 수 있습니다.';

  @override
  String get questaVoceBreveDisponibileUna =>
      '사전 내용이 간략합니다. 상세 설명을 확인할 수 있습니다.';

  @override
  String get estaEntradaBreveEstDispon => '사전 내용이 간략합니다. 상세 설명을 확인할 수 있습니다.';

  @override
  String get thisDictionaryEntryIsBrief => '사전 내용이 간략합니다. 상세 설명을 확인할 수 있습니다.';

  @override
  String get dVelopperEnFranAis => '프랑스어로 확장';

  @override
  String get aufDeutschErweitern => '독일어로 확장';

  @override
  String get ampliarEnEspaOl => '스페인어로 확장';

  @override
  String get approfondisciInItaliano => '이탈리아어로 확장';

  @override
  String get expandirEmPortuguS => '포르투갈어로 확장';

  @override
  String get expandDefinition => '정의 확장';

  @override
  String get impossibleDeChargerLExplication => '설명을 불러올 수 없습니다.';

  @override
  String get dieErklRungKonnteNicht => '설명을 불러올 수 없습니다.';

  @override
  String get noSePudoCargarLa => '설명을 불러올 수 없습니다.';

  @override
  String get impossibileCaricareLaSpiegazione => '설명을 불러올 수 없습니다.';

  @override
  String get nOFoiPossVel => '설명을 불러올 수 없습니다.';

  @override
  String get unableToLoadTheExplanation => '설명을 불러올 수 없습니다.';

  @override
  String get failedToGenerateStoryN => '스토리 생성 실패:\\n\$e';

  @override
  String get thematic => '주제별';

  @override
  String get deckFlashcards => '덱 (플래시카드)';

  @override
  String get searchLibraryOrTypeCustom => '라이브러리 검색 또는 직접 입력';

  @override
  String get hSKLevel => 'HSK \$level';

  @override
  String get analysisFailedE => '분석 실패: \$e';

  @override
  String get extractionFailedE => '추출 실패: \$e';

  @override
  String get simplifyFailedE => '간소화 실패: \$e';

  @override
  String get translationFailedE => '번역 실패: \$e';

  @override
  String get failedToSaveExtractedWords2 => '추출된 단어 저장 실패: \$error';

  @override
  String youActualTargetExpected(String actual, String expected) {
    return '나: $actual  ·  목표: $expected';
  }

  @override
  String get improveTheLocalVoice => '로컬 음성 개선';

  @override
  String get higherQualityOfflineMandarin => '고품질 오프라인 만다린';

  @override
  String get removeDownload => '다운로드를 삭제하시겠습니까?';

  @override
  String get removeDownload2 => '다운로드 삭제';

  @override
  String get tag => '#\$tag';

  @override
  String get voiceFemaleWarm => '여성, 따뜻한 톤';

  @override
  String get voiceFemaleCheerful => '여성, 쾌활한 톤';

  @override
  String get voiceMaleUpbeat => '남성, 경쾌한 톤';

  @override
  String get voiceMaleNewsStyle => '남성, 뉴스 스타일';

  @override
  String get voiceMaleSporty => '남성, 스포티한 톤';

  @override
  String get voiceOnDeviceTts => '기기 내 음성 합성';

  @override
  String get voiceSystemVoice => '시스템 음성';

  @override
  String get applySessionGradesToSpacedRepetition =>
      '세션 채점 결과를 간격 반복 시스템(말하기 모드)에 반영';

  @override
  String get unableToLoadThisSectionPleaseTryAgain =>
      '이 섹션을 불러올 수 없습니다. 다시 시도해 주세요.';

  @override
  String get removeDownloadQuestion => '다운로드를 삭제하시겠습니까?';

  @override
  String get removeDownloadContent => 'Remove downloaded content?';

  @override
  String get removeDownloadAction => '다운로드 삭제';

  @override
  String get removeDownloadButton => '다운로드 삭제';

  @override
  String cardsCount(num count) {
    return '$count Cards';
  }

  @override
  String get aiSummary => 'AI 요약';

  @override
  String get readability => '가독성';

  @override
  String get translateAction => '번역';

  @override
  String get checkingDownload => '???? ?? ?';

  @override
  String downloadingBook(int percent) {
    return '???? ?: $percent%';
  }

  @override
  String get retryDownload => '???? ?? ??';

  @override
  String get downloadBook => '? ????';

  @override
  String continueChapter(int chapter) {
    return '$chapter??? ?? ??';
  }

  @override
  String get downloadBookError => '? ?? ????? ? ????. ??? ??? ? ?? ?????.';

  @override
  String downloadBookOffline(int count) {
    return '$count? ?? ?????? ???? ?? ???????.';
  }

  @override
  String poemCount(int count) {
    return '$count?';
  }

  @override
  String get americanLiterature => '?? ??';

  @override
  String get ancientChina => '?? ??';

  @override
  String get britishLiterature => '?? ??';

  @override
  String get frenchLiterature => '??? ??';

  @override
  String get germanLiterature => '?? ??';

  @override
  String get italianLiterature => '???? ??';

  @override
  String get jinDynasty => '???';

  @override
  String get preQinEra => '?? ??';

  @override
  String get qingDynasty => '???';

  @override
  String get republicOfChinaEra => '???? ??';

  @override
  String get russianLiterature => '??? ??';

  @override
  String get spanishLiterature => '??? ??';

  @override
  String get springAndAutumn => '?? ??';

  @override
  String get westernHan => '??';

  @override
  String get roleplayCreatorContextPlaceholder => '예: 상하이에서 열리는 활기찬 축하 연회...';

  @override
  String get roleplayCreatorPersonaPlaceholder => '예: 진로에 관해 묻는 호기심 많은 사촌...';

  @override
  String get beginFirstLesson => '첫 번째 수업 시작하기';

  @override
  String get exploreLibraryDirectly => '라이브러리 바로 둘러보기';

  @override
  String onboardingLessonProgress(Object current, Object total) {
    return '첫 번째 수업  •  $current / $total';
  }

  @override
  String get onboardingListenInstruction =>
      '먼저 중국 문학에서 가장 널리 알려진 명구절을 들어보세요. 아직 암기할 필요는 없습니다.';

  @override
  String get onboardingFromGrandLibrary => '대서고에서';

  @override
  String get onboardingArtOfWarTitleAuthor => '손자병법 · 손자';

  @override
  String get onboardingArtOfWarChapter => '谋攻篇 · 제3장';

  @override
  String get onboardingClassicLineLabel => '고전 명구';

  @override
  String get onboardingArtOfWarTranslation => '“적을 알고 나를 알면 백 번 싸워도 위태롭지 않다.”';

  @override
  String get onboardingNoticeMeaning => '적을 알고 나를 알면,';

  @override
  String get onboardingShadowMeaning => '백 번 싸워도 위태롭지 않다.';

  @override
  String get onboardingPracticeThisLabel => '연습할 구절';

  @override
  String get onboardingFromArtOfWarLabel => '손자병법 출전';

  @override
  String get onboardingYourPronunciationLabel => '나의 발음';

  @override
  String get onboardingTapACharacter => '한자를 탭하세요';

  @override
  String onboardingWordAndPinyin(String word, String pinyin) {
    return '$word · $pinyin';
  }

  @override
  String get onboardingToneMatched => '일치함';

  @override
  String get onboardingCompareTones => '성조 비교';

  @override
  String get onboardingToneOneHigh => '1성 · 높음';

  @override
  String get onboardingToneTwoRising => '2성 · 오름';

  @override
  String get onboardingToneThreeDipping => '3성 · 꺾임';

  @override
  String get onboardingToneFourFalling => '4성 · 내림';

  @override
  String get onboardingToneNotDetected => '감지되지 않음';

  @override
  String get onboardingFeedbackGreatThirdTone => '3성의 꺾이는 성조를 훌륭하게 구현했습니다.';

  @override
  String get onboardingFeedbackFourthToneFall => '4성은 단호하고 빠르게 떨어뜨리듯 발음해 보세요.';

  @override
  String get onboardingFeedbackClearFourthTone => '명확하고 단호한 4성 발음입니다.';

  @override
  String get onboardingFeedbackStrongFourthTone => '힘있고 명확한 4성 발음입니다.';

  @override
  String onboardingTraceInstruction(
      String character, String pinyin, String meaning) {
    return '$character($pinyin, “$meaning”) 글자를 따라 써 보세요. 흐릿하게 표시된 획순 가이드를 따르시면 됩니다.';
  }

  @override
  String billingDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count일',
    );
    return '$_temp0';
  }

  @override
  String billingWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count주',
    );
    return '$_temp0';
  }

  @override
  String billingMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count개월',
    );
    return '$_temp0';
  }

  @override
  String billingYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count년',
    );
    return '$_temp0';
  }

  @override
  String startPeriodFreeTrial(String period) {
    return '$period 무료 체험 시작';
  }

  @override
  String subscribeForPricePeriod(String price, String period) {
    return '$price / $period에 구독하기';
  }

  @override
  String eligibleTrialRenewalNotice(String price, String period) {
    return '선택하신 상품에는 무료 체험 혜택이 포함되어 있습니다. 체험 기간이 끝나면 취소하지 않는 한 $period마다 $price로 자동 갱신됩니다.';
  }

  @override
  String pricePerPeriod(String price, String period) {
    return '$price / $period';
  }

  @override
  String get learn => '학습';

  @override
  String get booksAndStudioQualityAudiobooks => '고전 도서 86권 및 스튜디오 품질의 오디오북';

  @override
  String get aiConversationsAndLiveToneFeedback => 'AI 대화 및 실시간 성조 피드백';

  @override
  String get interactiveVideoAndWebImmersion => '인터랙티브 동영상 및 웹 몰입 학습';

  @override
  String get characterInsightsAndHandwritingPractice => '글자 인사이트 및 손글씨 연습';

  @override
  String get hskDecksAndSmartSpacedRepetition => 'HSK 덱 및 스마트 간격 반복 학습';

  @override
  String get termsOfUseEula => '이용 약관 (EULA)';

  @override
  String get masterEveryStroke => '모든 획을 마스터하세요';

  @override
  String get exploreTheChineseWeb => '중국 웹을 탐색해보세요';

  @override
  String get tone1Description => '음표를 부르듯이 높고 안정적인 음조를 유지하세요.';

  @override
  String get tone2Description => '중간에서 시작하여 \'뭐라고요?\'라고 묻는 것처럼 음조를 위로 올리세요.';

  @override
  String get tone3Description => '목소리를 낮게 내렸다가 부드럽게 다시 올리세요.';

  @override
  String get tone4Description => '단호한 \'안 돼!\'처럼 음조를 날카롭고 단호하게 내리세요.';

  @override
  String get toneNeutralDescription => '부드럽고 짧게, 강조 없이 발음하세요.';

  @override
  String get toneDiagMatch1 => '정확해요! 음높이가 높고 평탄하며 안정적이었어요.';

  @override
  String get toneDiagMatch2 => '정확해요! 음높이 상승이 명확했어요.';

  @override
  String get toneDiagMatch3 => '정확해요! 낮은 하강 곡선이 정확했어요.';

  @override
  String get toneDiagMatch4 => '정확해요! 날카로운 하강이 단호했어요.';

  @override
  String get toneDiagMatchDefault => '정확해요! 성조가 정확하게 발음되었어요.';

  @override
  String get toneDiag1vs2 =>
      '음높이가 올라갔어요 (2성 /). 음절 전체에서 목소리를 평탄하고 높게 유지하세요 (1성 ˉ).';

  @override
  String get toneDiag1vs3 =>
      '목소리가 내려갔어요 (3성 ˇ). 음높이를 내리지 않고 안정적이고 높게 유지하세요 (1성 ˉ).';

  @override
  String get toneDiag1vs4 =>
      '음높이가 내려갔어요 (4성 \\). 음을 노래하듯이 높고 평탄한 음높이를 유지하세요 (1성 ˉ).';

  @override
  String get toneDiag2vs1 =>
      '평탄하게 유지했어요 (1성 ˉ). \'뭐라고?\' 묻듯이 음높이를 위로 미끄러뜨리세요 (2성 /).';

  @override
  String get toneDiag2vs3 =>
      '너무 깊게 내려갔어요 (3성 ˇ). 중간 높이에서 시작하여 바닥을 치지 않고 부드럽게 올리세요 (2성 /).';

  @override
  String get toneDiag2vs4 => '음높이가 내려갔어요 (4성 \\). 질문하듯이 위로 올리세요 (2성 /).';

  @override
  String get toneDiag3vs1 =>
      '높고 평탄하게 유지했어요 (1성 ˉ). 올라가기 전에 음높이를 가슴 소리까지 낮게 떨어뜨리세요 (3성 ˇ).';

  @override
  String get toneDiag3vs2 =>
      '즉시 올라갔어요 (2성 /). 다시 올라가기 전에 먼저 낮게 내려가는지 확인하세요 (3성 ˇ).';

  @override
  String get toneDiag3vs4 =>
      '올라가지 않고 급격히 내려갔어요 (4성 \\). 마지막에 음높이가 부드럽게 다시 튀어 오르도록 하세요 (3성 ˇ).';

  @override
  String get toneDiag4vs1 =>
      '평탄하게 유지했어요 (1성 ˉ). 단호한 \'안 돼!\'처럼 음높이를 날카롭고 단호하게 내리세요 (4성 \\).';

  @override
  String get toneDiag4vs2 =>
      '음높이가 올라갔어요 (2성 /). 높게 시작하여 날카롭게 아래로 내리세요 (4성 \\).';

  @override
  String get toneDiag4vs3 =>
      '내려갔다가 올라갔어요 (3성 ˇ). 다시 올라가지 않고 곧바로 아래로 내리세요 (4성 \\).';

  @override
  String get toneDiagListenDiff => '아래 4가지 성조를 듣고 차이점을 확인하세요.';

  @override
  String get liveCallSpeaking => '말하는 중...';

  @override
  String get toneAccurate => '정확한 성조';

  @override
  String get toneNeedsWork => '성조 연습 필요';

  @override
  String get liveCallSessionCompletedFallback =>
      '세션이 완료되었습니다. 다음 연습에서는 완전한 문장으로 말하여 상세한 발음 및 성조 진단을 받아보세요.';

  @override
  String liveCallGoodStartPracticingWord(String word) {
    return '\'$word\'을(를) 연습하는 좋은 출발입니다. 다음 세션에서는 완전한 문장을 이어서 말해보며 성조 전환과 자연스러운 흐름을 연습해보세요.';
  }

  @override
  String get liveCallSolidEffortFallback =>
      '훌륭한 대화 연습이었습니다. 제1성은 높고 평평하게(55), 제4성은 날카롭고 단호하게 내려(51) 연습하면 원어민에 가까운 명확성을 갖출 수 있습니다.';

  @override
  String get liveCallGoodPracticeFallback =>
      '좋은 연습 세션이었습니다. 명확한 성조 높낮이 대비와 자연스러운 대화 속도에 계속 집중해보세요.';

  @override
  String sentenceNumber(Object number) {
    return '문장 $number';
  }

  @override
  String endlessAiStreamSentence(Object count) {
    return '무한 AI 스트림 • 문장 $count';
  }

  @override
  String get aiConsentTitle => 'AI 학습 및 개인정보 보호';

  @override
  String get aiConsentSubtitle =>
      'SinoSpark는 음성 발음 평가, 대화 롤플레잉 및 학습 도구를 위해 안전한 타사 AI 서비스를 사용합니다.';

  @override
  String get aiConsentDataSentTitle => '전송되는 데이터';

  @override
  String get aiConsentDataSentBody => '음성 오디오 녹음, 구어 텍스트 변환 및 학습 프롬프트.';

  @override
  String get aiConsentProvidersTitle => '타사 AI 서비스';

  @override
  String get aiConsentProvidersBody =>
      '• Microsoft Azure AI Speech (발음 평가 및 음성 합성)\n• Google Gemini & DeepSeek (대화형 다이얼로그 및 덱 생성)';

  @override
  String get aiConsentGuaranteesTitle => '개인정보 보호 보장';

  @override
  String get aiConsentGuaranteesBody =>
      '귀하의 데이터는 전송 중 암호화되며, 일시적으로만 처리되고, 판매되지 않으며, 공개 AI 모델 훈련에 사용되지 않습니다.';

  @override
  String get aiConsentAgree => '동의하고 AI 사용';

  @override
  String get aiConsentLearnMore => '자세히 알아보기';

  @override
  String get viewPlans => '요금제 보기';

  @override
  String get authInvalidCredentials =>
      '이메일 또는 비밀번호가 올바르지 않습니다. 계정이 없다면 회원가입을 해주세요.';

  @override
  String get authInvalidEmail => '올바른 이메일 주소를 입력해 주세요.';

  @override
  String get authEmailAlreadyInUse => '이 이메일 주소로 등록된 계정이 이미 존재합니다.';

  @override
  String get authWeakPassword => '비밀번호는 최소 6자 이상이어야 합니다.';

  @override
  String get authTooManyRequests => '로그인 시도가 너무 많습니다. 나중에 다시 시도해 주세요.';

  @override
  String get authNetworkError => '네트워크 오류입니다. 연결을 확인해 주세요.';

  @override
  String get subscriptionRequired => '구독이 필요합니다';

  @override
  String get subscriptionRequiredDesc =>
      '모든 레슨, 도서 및 AI 음성 도구를 이용하려면 유효한 SinoSpark 구독이 필요합니다.';

  @override
  String signedInAs(String email) {
    return '$email 계정으로 로그인됨';
  }

  @override
  String get battle => '전투';

  @override
  String addedWordsAndUpdatedWords(
      int addedCount, int updatedCount, String deckName) {
    return '새 단어 $addedCount개 추가, 「$deckName」의 기존 단어 $updatedCount개 업데이트됨';
  }

  @override
  String addedWordsToDeck(int count, String deckName) {
    return '「$deckName」에 단어 $count개가 추가되었습니다';
  }

  @override
  String updatedWordsInDeck(int count, String deckName) {
    return '「$deckName」의 기존 단어 $count개가 업데이트되었습니다';
  }

  @override
  String addedCardToDeck(String hanzi, String deckName) {
    return '「$hanzi」을(를) 「$deckName」에 추가했습니다';
  }

  @override
  String get callCategory => '라이브 통화';

  @override
  String get aiCallFluencyTitle => '유창성을 기르는 AI 음성 통화';

  @override
  String get aiCallFluencyDesc =>
      'AI 튜터와 현실적인 음성 대화를 나누고, 즉각적인 성조 평가를 받아 자연스러운 회화 유창성을 기르세요.';

  @override
  String get decksCategory => '단어장';

  @override
  String get decksSpacedRepetitionTitle => '간격 반복 학습 단어장';

  @override
  String get decksSpacedRepetitionDesc =>
      '과학적으로 입증된 간격 반복 알고리즘으로 HSK 1~6급 및 맞춤형 단어장을 정복하세요.';

  @override
  String get booksCategory => '도서';

  @override
  String get classicalBooksPoemsTitle => '고전 도서 86권 및 시 100편';

  @override
  String get classicalBooksPoemsDesc =>
      '동기화된 오디오와 이중 언어 해설과 함께 시대를 초월한 고전 문학과 시를 탐독하세요.';

  @override
  String get scanCategory => '스캐너';

  @override
  String get scannerScanCardsTitle => '이미지 스캔 및 단어장 카드 추가';

  @override
  String get scannerScanCardsDesc =>
      '카메라로 중국어 텍스트, 메뉴판, 표지판을 비추면 즉시 단어를 추출하여 단어장에 저장합니다.';

  @override
  String get smartDictionaryStrokeOrderTitle => '획순 지원 스마트 사전';

  @override
  String get liveAiVoiceCallsAndToneGrading => '실시간 AI 음성 통화 및 즉각적인 성조 평가';

  @override
  String get shadowingStudioAndToneAnalysis => '섀도잉 스튜디오 및 성조 피치 시각 분석';

  @override
  String get startMy7DaysFreeTrial => '7일 무료 체험 시작하기';

  @override
  String trialSubtextUnderCta(String price, String period) {
    return '이후 $period당 $price. 설정에서 언제든지 취소 가능.';
  }

  @override
  String get deckLibraryTitle => '덱 라이브러리';

  @override
  String get deckLibrarySubtitle => 'HSK, 문화, 스포츠, 학술 분야의 엄선된 컬렉션';

  @override
  String get downloadOfficialDecks => '공식 HSK 및 주제별 덱 다운로드';

  @override
  String wordsSelectedCount(int selected, int total) {
    return '$total개 중 $selected개 단어 선택됨';
  }

  @override
  String get comparisonLabel => '비교';

  @override
  String get ambientSoundscape => '배경 음향';

  @override
  String get ambientSoundscapeDesc => '독서와 듣기를 위한 차분한 배경 분위기';

  @override
  String get ambientSoundscapeOff => '끄기 (무음)';

  @override
  String get soundscapeCourtyardRain => '안뜰의 빗소리';

  @override
  String get soundscapeGuqinWind => '고금과 대나무 바람';

  @override
  String get soundscapeMidnightZen => '한밤의 명상';

  @override
  String get ambientVolume => '배경 음량';

  @override
  String get rateSinoSpark => 'SinoSpark 평가하기';

  @override
  String get rateSinoSparkDesc => 'App Store에서 리뷰 남기기';

  @override
  String get sendFeedback => '피드백 보내기';

  @override
  String get sendFeedbackDesc => '개선 의견이나 문제점 보고하기';

  @override
  String get enjoyingAppTitle => 'SinoSpark가 마음에 드시나요?';

  @override
  String get enjoyingAppSubtitle => '지금까지의 중국어 학습 여정은 어떠셨나요?';

  @override
  String get ratingLovingIt => '네, 아주 좋아요!';

  @override
  String get ratingCouldBeBetter => '아쉬운 점이 있어요';

  @override
  String get dictionarySearchFailed => '사전 검색에 실패했습니다. 다시 시도해 주세요.';
}
