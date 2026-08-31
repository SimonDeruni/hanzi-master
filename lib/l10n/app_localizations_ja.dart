// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

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
  String get globalMastery => '全体的な習熟度';

  @override
  String get masteredCards => 'マスター';

  @override
  String get hsk1Candidate => 'HSK 1 候補';

  @override
  String get hsk2Candidate => 'HSK 2 候補';

  @override
  String get hsk3Candidate => 'HSK 3 候補';

  @override
  String get hsk4Candidate => 'HSK 4 候補';

  @override
  String get hsk5Candidate => 'HSK 5 候補';

  @override
  String get hsk6Candidate => 'HSK 6 候補';

  @override
  String get hsk6Master => 'HSK 6 マスター';

  @override
  String get currentRank => '現在のランク';

  @override
  String get next => 'Siguiente';

  @override
  String get searchHanziOrPinyin => '検索...';

  @override
  String get dailyReview => '毎日の復習';

  @override
  String get upcomingForecast => '今後の予定';

  @override
  String get laterToday => '今日の後半';

  @override
  String get tomorrow => '明日';

  @override
  String get next7Days => '次の7日間';

  @override
  String get theScholarWay => '学者の道';

  @override
  String get beginJourney => '始める';

  @override
  String get settingsTitle => '設定';

  @override
  String get darkMode => 'ダークモード';

  @override
  String get darkModeDesc => '目に優しい';

  @override
  String get voiceSpeed => '音声の速度';

  @override
  String get artAndIntellect => '芸術と知性';

  @override
  String get theDigitalScholar => 'デジタル学者';

  @override
  String get refineBrushVoice => 'AIで筆と声を磨く。';

  @override
  String get liveVoiceCall => 'ライブ音声通話';

  @override
  String get immersiveRoleplay => '没入型ロールプレイ';

  @override
  String get readingRoom => '読書室';

  @override
  String get shadowingStudio => 'シャドーイング';

  @override
  String get errorPrefix => 'エラー: ';

  @override
  String get initializingLibrary => '初期化中...';

  @override
  String get unlockCharactersToQuiz => 'クイズのために4文字ロック解除！';

  @override
  String get practiceQuiz => 'クイズ';

  @override
  String get curriculumPaths => '学習経路';

  @override
  String get noDecksFound => 'デッキがありません。';

  @override
  String get addCardsFirst => 'カードを追加してください！';

  @override
  String get aiDraftingPath => 'AIが経路を準備中...';

  @override
  String get pathReady => '経路の準備ができました！';

  @override
  String get errorGeneratingPath => 'エラー';

  @override
  String get brushingCurriculum => '経路を作成中...';

  @override
  String get warmUp => 'ウォームアップ';

  @override
  String get lessonComplete => 'レッスン完了！ +10ポイント';

  @override
  String get step1Origin => 'ステップ1：起源';

  @override
  String get traceRadical => '部首をなぞる';

  @override
  String get step2Forge => 'ステップ2：鍛造';

  @override
  String get chooseEssence => '本質を選ぶ';

  @override
  String get wrongEssence => '間違い！もう一度。';

  @override
  String get step3Hunt => 'ステップ3：狩り';

  @override
  String get findCharacters => '文字を探す';

  @override
  String get notThatOne => 'それじゃない！';

  @override
  String get successfullyInstalled => 'インストール成功:';

  @override
  String get failedToDownload => 'ダウンロード失敗。';

  @override
  String get rescindTitle => '取り消しますか？';

  @override
  String get removeCharactersWarning => 'これらの文字を削除します。';

  @override
  String get cancel => 'Cancelar';

  @override
  String get uninstall => 'アンインストール';

  @override
  String get removedLibrary => '削除しました:';

  @override
  String get tomeLibrary => 'ライブラリ';

  @override
  String get libraryError => 'ライブラリエラー';

  @override
  String get installTome => 'インストール';

  @override
  String get unitIntro => 'ユニット紹介';

  @override
  String get constellationCluster => '星座クラスター';

  @override
  String get ok => 'Aceptar';

  @override
  String get divingInto => '深く潜る...';

  @override
  String get keyRadicals => '主要な部首';

  @override
  String get noRadicalData => 'データなし。';

  @override
  String get discovery => '発見';

  @override
  String get startLearning => '学習を開始';

  @override
  String get selectPersona => 'ペルソナを選択';

  @override
  String get customPersona => 'カスタムペルソナ';

  @override
  String get geminiLiveCall => 'ライブ通話';

  @override
  String get returnToMenu => '戻る';

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
  String get gradedAiStories => 'AIの物語';

  @override
  String get calligraphy => '書道';

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
  String get audioAndHaptics => 'オーディオとハプティクス';

  @override
  String get autoPlayAudio => 'Auto Play Audio';

  @override
  String get autoPlayDesc => 'Auto Play Desc';

  @override
  String get haptics => 'Haptics';

  @override
  String get displayAndContent => '表示とコンテンツ';

  @override
  String get useEnglishDefinitions => '英語の定義を使用する';

  @override
  String get useEnglishDefinitionsDesc => '英語の定義は一般に、より正確で詳しい内容です';

  @override
  String get animationSpeed => 'アニメーション速度';

  @override
  String get manageTomes => 'Manage Tomes';

  @override
  String get manageTomesDesc => 'Manage Tomes Desc';

  @override
  String get dangerZone => '危険ゾーン';

  @override
  String get resetAllData => '全データをリセット';

  @override
  String get resetDataDesc => 'これにより、進行データ、統計、設定がすべて完全に削除されます。この操作は元に戻せません。';

  @override
  String get areYouSure => 'Are You Sure';

  @override
  String get cannotBeUndone => 'Cannot Be Undone';

  @override
  String get deleteEverything => 'Delete Everything';

  @override
  String get appLanguage => 'アプリ言語';

  @override
  String get howDidYouDo => '学習結果はいかがでしたか？';

  @override
  String get missedItEntirely => '全く分からなかった';

  @override
  String get gotItButStruggled => '分かったが、苦戦した';

  @override
  String get gotItClearly => 'はっきり理解した';

  @override
  String get perfectAndImmediate => '完璧に即答';

  @override
  String get again => 'もう一度';

  @override
  String get hard => '難しい';

  @override
  String get good => '普通';

  @override
  String get easy => '簡単';

  @override
  String get tapToReveal => 'タップして表示';

  @override
  String get howWellDidYouRemember => '記憶度はいかがでしたか？';

  @override
  String get completelyForgot => '完全に忘れた';

  @override
  String get gotItWithDifficulty => 'かろうじて思い出した';

  @override
  String get recalledCorrectly => '正しく思い出した';

  @override
  String get perfectRecall => '完璧に記憶';

  @override
  String get practiceWriting => 'ライティング練習';

  @override
  String get hideScratchpad => 'メモ帳を隠す';

  @override
  String get whatCharacterMeans => '文字の意味:';

  @override
  String get tapCardToReveal => 'カードをタップして表示';

  @override
  String get ratePronunciationConfidence => '発音の自信度を評価';

  @override
  String get botchedIt => '全くダメだった';

  @override
  String get struggledWithTones => '声調に苦戦した';

  @override
  String get acceptable => '許容範囲';

  @override
  String get perfectlyNatural => '完璧に自然';

  @override
  String get sessionComplete => 'セッション完了！';

  @override
  String get accuracy => '正答率';

  @override
  String get reviewed => '復習済み';

  @override
  String get correct => '¡Correcto!';

  @override
  String get backToLibrary => 'ライブラリに戻る';

  @override
  String get revealAnswer => '答えを表示';

  @override
  String get aiHubTitle => 'AIハブ';

  @override
  String get textChat => 'テキストチャット';

  @override
  String get scholarlyPersonas => '学者ペルソナ';

  @override
  String get shadowing => 'シャドーイング';

  @override
  String get liveTranslation => 'リアルタイム翻訳';

  @override
  String get scholarsLibrary => '学者の書庫';

  @override
  String get generate => '生成';

  @override
  String get searchPinyinHanziEnglish => 'ピンイン、漢字、英語で検索...';

  @override
  String get liveTranslate => 'ライブ翻訳';

  @override
  String get travelInterpreter => '旅行通訳';

  @override
  String get realTimeSplitScreen => 'ネイティブスピーカーとのリアルタイム分割画面会話。瞬時に言葉の壁を打ち破ります。';

  @override
  String get whisperEarpiece => 'ウィスパーイヤホン';

  @override
  String get listenToChineseAudio => '中国語の音声を聞き、画面上でリアルタイムの英語字幕を表示します。';

  @override
  String get dashboardTitle => 'ダッシュボード';

  @override
  String get yourMindIsClear => '頭はすっきりしています。';

  @override
  String get noReviewsDueToday => '今日の復習はありません。';

  @override
  String get done => '完了';

  @override
  String get hskLevel1 => 'HSK 1級';

  @override
  String get hskLevel2 => 'HSK 2級';

  @override
  String get hskLevel3 => 'HSK 3級';

  @override
  String get hskLevel4 => 'HSK 4級';

  @override
  String get hskLevel5 => 'HSK 5級';

  @override
  String get hskLevel6 => 'HSK 6級';

  @override
  String get generalVocabulary => '一般語彙';

  @override
  String get cardsRequireAttention => '枚のカードに注意が必要です。';

  @override
  String get begin => '開始';

  @override
  String get poweredByAi => '最先端AIを搭載。どんな場面でもシームレスなリアルタイム翻訳を。';

  @override
  String get downloadingModel => 'モデルをダウンロード中...';

  @override
  String get soon => 'まもなく';

  @override
  String get installed => 'インストール済み';

  @override
  String get premium => 'プレミアム';

  @override
  String get coreModule => 'CORE MODULE';

  @override
  String get step6Context => 'ステップ6: 文脈';

  @override
  String get tapBuildingBlocksTo => '構成要素をタップして、その起源を探りましょう。';

  @override
  String get initiateRadicalSequence => '部首シークエンスを開始';

  @override
  String get holdToTalk => '長押しして話す';

  @override
  String get customScenario => 'カスタムシナリオ';

  @override
  String get voiceCall => '音声通話';

  @override
  String get pronunciation => 'Pronunciación';

  @override
  String get selectAScenarioTo =>
      'シナリオを選択して、中国語の会話を練習しましょう。Scholarが声調と明瞭さを評価します。';

  @override
  String get create => '作成';

  @override
  String get createYourScenario => 'シナリオを作成';

  @override
  String get difficulty => '難易度';

  @override
  String get scholarsVerdict => 'SCHOLARの判定';

  @override
  String get completeReview => 'レビューを完了';

  @override
  String get conversationReview => '会話レビュー';

  @override
  String get linguisticAnalysis => '言語分析';

  @override
  String get examplesInHsk1 => 'HSK 1の例';

  @override
  String get characterReference => '文字リファレンス';

  @override
  String get askTutor => 'チューターに質問';

  @override
  String get addToStudyDeck => '学習デッキに追加';

  @override
  String get startPractice => '練習を開始';

  @override
  String get noOtherHsk1 => 'この部首を使用する他のHSK 1文字はありません。';

  @override
  String get couldNotLoadAi =>
      'AIコンテキストを読み込めませんでした。(レート制限またはネットワークエラー)\n下の更新ボタンをタップして、後でもう一度お試しください。';

  @override
  String get noAvailableCardsFound => '利用可能なカードが見つかりません。';

  @override
  String get addCards => 'カードを追加';

  @override
  String get removeCard => 'カードを削除';

  @override
  String get remove => '削除';

  @override
  String get review => '復習';

  @override
  String get story => '物語';

  @override
  String get thisDeckIsEmpty => 'このデッキは空です。';

  @override
  String get tapTheAddCards => 'カード追加ボタンをタップ！';

  @override
  String get noCardsFound => 'カードが見つかりません。';

  @override
  String get addCardsToSee => '統計を見るにはカードを追加してください。';

  @override
  String get aiGenerated => 'AI生成';

  @override
  String get allCardsCaughtUp => 'すべてのカードを復習しました！素晴らしい。';

  @override
  String get latestDiscoveries => '最新の発見';

  @override
  String get noCharactersInLexicon => 'まだ辞書に文字がありません。';

  @override
  String get yourBookshelf => 'あなたの本棚';

  @override
  String get text_1782026184579 => '字';

  @override
  String get searchYourDictionary => '辞書を検索...';

  @override
  String get saveCard => 'カードを保存';

  @override
  String get noCharactersFound => '文字が見つかりません。';

  @override
  String get radicalsIndex => '部首索引';

  @override
  String get masteringRadicalsIsThe =>
      '部首をマスターすることは、何千もの漢字を解き放つ鍵です。部首を選択して、それを使用するすべての文字を表示します。';

  @override
  String get noRadicalsFound => '部首が見つかりません。';

  @override
  String get yourDrawing => 'あなたの描画';

  @override
  String get reference => '参照';

  @override
  String get rateYourRecall => '記憶度を評価';

  @override
  String get contactUs => 'お問い合わせ';

  @override
  String get reportBugsOrRequest => 'バグを報告するか、機能をリクエスト';

  @override
  String get allDataHasBeen => 'すべてのデータが消去されました。';

  @override
  String get hanziMasterV100 => 'SinoSpark v1.0.0';

  @override
  String get myProgress => '私の進捗';

  @override
  String get overview => '概要';

  @override
  String get aiStory => 'AIストーリー';

  @override
  String get usingYourDecksVocabulary => 'デッキの語彙を使用中';

  @override
  String get tryAgain => 'もう一度';

  @override
  String get translate => '翻訳';

  @override
  String get pinyin => 'ピンイン';

  @override
  String get fullTranslation => '完全な翻訳';

  @override
  String get geminiFlashIsStructuring => 'Gemini Flashがストーリーを構築しています...';

  @override
  String get aiDeckGenerator => 'AIデッキジェネレーター';

  @override
  String get whatDoYouWant => '何を学びたいですか？';

  @override
  String get targetDifficulty => '目標難易度';

  @override
  String get focusArea => '重点分野';

  @override
  String get specificContextOrTone => '特定の文脈やトーン（オプション）';

  @override
  String get numberOfCards => 'カードの枚数';

  @override
  String get generateDeck => 'デッキを生成';

  @override
  String get aiGrammarExplanation => 'AI文法説明';

  @override
  String get scholarsDesk => 'Scholarの机';

  @override
  String get chooseADeck => 'デッキを選択';

  @override
  String get whereWouldYouLike => 'この文字をどこに保存しますか？';

  @override
  String get addToDefaultStudy => 'デフォルトの学習デッキに追加';

  @override
  String get ifOffItsOnly => 'オフの場合、グローバル辞書にのみ保存されます';

  @override
  String get saveToLibrary => 'ライブラリに保存';

  @override
  String get pleaseEnterValidChinese => '有効な中国語の文字を入力してください';

  @override
  String get reviewAiCard => 'AIカードをレビュー';

  @override
  String get pleaseDoublecheckTheAis =>
      '以下のAIの出力をもう一度確認してください。永久ライブラリに保存する前に、ピンインや定義を自由に調整してください。';

  @override
  String get alreadyInYourLibrary => 'すでにライブラリにあります！';

  @override
  String get meaningInContext => '文脈における意味';

  @override
  String get explainGrammar => '文法を説明';

  @override
  String get addToLibrary => 'ライブラリに追加';

  @override
  String get masterYourMandarinPronunciation =>
      'ネイティブの会話をリアルタイムで模倣して、中国語の発音をマスターしましょう。';

  @override
  String get startSession => 'セッションを開始';

  @override
  String get sessionHistory => 'セッション履歴';

  @override
  String get noSavedSessions => '保存されたセッションはありません。';

  @override
  String get aiBreakdown => 'AI分析';

  @override
  String get sessionDetails => 'セッション詳細';

  @override
  String get partner => 'パートナー ((lang))';

  @override
  String get youEnglish => 'あなた (英語)';

  @override
  String get noTranscriptToSave => '保存する文字起こしがありません！';

  @override
  String get sessionSaved => 'セッションが保存されました！';

  @override
  String get realtimeBidirectionalTranslationSpeak =>
      'リアルタイム双方向翻訳。英語または中国語を話すと、あなたと相手のために瞬時に翻訳されます。';

  @override
  String get text_1782026184665 => '録音中';

  @override
  String get recording => '録音中';

  @override
  String get yourSilentCompanionListen => 'あなたの静かな相棒。中国語を聞くと、英語の翻訳が瞬時に聞こえます。';

  @override
  String get startListening => '聞き始める';

  @override
  String get skip => 'スキップ';

  @override
  String get independentStars => '独立した星';

  @override
  String get notEveryCharacterHas => 'すべての文字に親部首があるわけではありません。一部は独立した象形文字です。';

  @override
  String get onTheMapWe => 'マップ上では、これらの独立した文字を星座（✨）にグループ化しています。';

  @override
  String get iUnderstand => '分かりました';

  @override
  String get whatAreRadicals => '部首とは？';

  @override
  String get hanziAreBuiltFrom =>
      '漢字は部首と呼ばれる構成要素から作られています。\n\nそれらは文字にその核心的な意味やテーマを与えます。';

  @override
  String get continueText => 'Continuar';

  @override
  String get hanziAreNotJust =>
      '漢字は単なる文字ではありません。それらは時間に凍結された絵です。\n\nそれらをマスターするには、その流れをたどることを学ばなければなりません。';

  @override
  String get iAmReady => '準備ができました';

  @override
  String get youAreAScholar => 'あなたはSCHOLARです';

  @override
  String get theGalaxyMapAwaitsnmaster =>
      'ギャラクシーマップが待っています。\n太陽（部首）をマスターして惑星（文字）をアンロックしましょう。';

  @override
  String get enterTheScroll => '巻物に入る';

  @override
  String get openingTheOriginScroll => '起源の巻物を開いています...';

  @override
  String get text_1782026184670 => '+';

  @override
  String get theScholarsEdition => 'Scholar\'s Edition';

  @override
  String get weArePreparingThe => 'Scholar\'s Editionの発売準備を進めています。';

  @override
  String get devBypassUnlockNow => '開発者バイパス：今すぐアンロック';

  @override
  String get restorePurchases => '購入を復元';

  @override
  String get welcomeScholarTheScroll => 'Scholar様、ようこそ。巻物は完全に開かれています。';

  @override
  String get purchasesRestoredSuccessfully => '購入が正常に復元されました。';

  @override
  String get noPreviousPurchasesFound => 'このアカウントで以前の購入は見つかりませんでした。';

  @override
  String get unlockTheFullPotential =>
      '旅の可能性を最大限に引き出しましょう。一度購入すれば、永久にあなたのものです。';

  @override
  String get universalScanner => 'ユニバーサルスキャナー';

  @override
  String get noChineseCharactersFound => '画像から中国語の文字は見つかりませんでした。';

  @override
  String get addedNewCharactersTo => '新しい文字をライブラリに追加しました！';

  @override
  String get extractingTextAndObjects => 'テキストとオブジェクトを抽出中...';

  @override
  String get scanATextbookSign => '教科書、看板、またはオブジェクトをスキャンして中国語の文字を抽出します。';

  @override
  String get extractedText => '抽出されたテキスト';

  @override
  String get useText => 'テキストを使用';

  @override
  String get noMatchingDictionaryEntries => '一致する辞書エントリが見つかりません。';

  @override
  String get quizComplete => 'クイズ完了！';

  @override
  String get returnToCourse => 'コースに戻る';

  @override
  String get notEnoughCardsFor => 'クイズにはカードが足りません！少なくとも4枚必要です。';

  @override
  String get creatorMode => 'クリエーターモード';

  @override
  String get noStoriesFoundMatching => '検索に一致するストーリーが見つかりません。';

  @override
  String get discard => '破棄';

  @override
  String get save => 'Guardar';

  @override
  String get generatingStoryViaDeepseek => 'DeepSeek経由でストーリーを生成中...';

  @override
  String get storySavedToLibrary => 'ストーリーがライブラリに保存されました！';

  @override
  String get storyNotFound => 'ストーリーが見つかりません。';

  @override
  String get targetHskLevel => '目標HSKレベル';

  @override
  String get wedLoveToHear => 'ご意見をお聞かせください！';

  @override
  String get whetherYouveFoundA =>
      'バグを見つけた場合でも、機能のリクエストがある場合でも、単に挨拶したい場合でも、皆様のフィードバックがSinoSparkの改善に役立ちます。';

  @override
  String get pointYourCameraAt => 'カメラをオブジェクトに向けてください';

  @override
  String get reviewAddToLibrary => 'レビューしてライブラリに追加';

  @override
  String get hideStrokeGuideStreak => '連続記録: (streak)で書き順ガイドを非表示';

  @override
  String get inkPoints => '(points)インクポイント';

  @override
  String get speechRateMultiplier => '(rate)倍';

  @override
  String get animationSpeedMultiplier => '(rate)倍';

  @override
  String get supportAndFeedback => 'サポート＆フィードバック';

  @override
  String get reportBug => 'バグを報告';

  @override
  String get suggestFeature => '機能を提案';

  @override
  String get generalFeedback => '一般的なフィードバック';

  @override
  String get pleaseDrawSomethingFirst => 'まず何か描いてください';

  @override
  String get drawThisCharacter => 'この文字を描く:';

  @override
  String get followGuideStroke => '青いガイドに従って(total)画中(current)画目を描きましょう';

  @override
  String get skipCurrentStroke => '現在の画をスキップ';

  @override
  String get submitDrawing => '描画を提出';

  @override
  String get addedToDeck => '(hanzi)を(deckName)に追加しました';

  @override
  String get removedFromDeck => 'デッキから(hanzi)を削除しました';

  @override
  String get skippedNoStrokeData =>
      '\"(hanzi)\"をスキップしました - このAI文字には書き順データがありません。';

  @override
  String get startingSession => 'セッションを開始しています...';

  @override
  String get masterBuildingBlocks => '漢字の構成要素をマスターしよう';

  @override
  String get totalWords => '総単語数';

  @override
  String get newInk => '新しいインク';

  @override
  String get learningStatus => '学習中';

  @override
  String get masteredStatus => '習得済み';

  @override
  String get libraryMastery => 'ライブラリ習熟度';

  @override
  String get accuracyByMode => 'モード別精度';

  @override
  String get upcomingReviews => '今後の復習（今後7日間）';

  @override
  String get culturalReadingRoom => '文化書房';

  @override
  String get storyTitleHsk => '(title) (HSK (level))';

  @override
  String get pleaseEnterTopic => 'トピックを入力してください';

  @override
  String get createdDeckCards => '(name)を(count)枚のカードで作成しました！';

  @override
  String get gradeResult => '評価: (grade)';

  @override
  String get listeningMode => 'リスニングモード';

  @override
  String get readingMode => 'リーディングモード';

  @override
  String get recallMode => 'リコールモード';

  @override
  String get speakingMode => 'スピーキングモード';

  @override
  String get aiMemoryHook => 'AI記憶フック';

  @override
  String get exampleSentences => '例文';

  @override
  String get ghostCharacters => 'ゴースト文字';

  @override
  String get commonWords => '頻出単語';

  @override
  String get personalNotes => '個人メモ';

  @override
  String get addPersonalNotes => '独自のニーモニックやメモをここに追加...';

  @override
  String get takePhoto => '写真を撮る';

  @override
  String get gallery => 'ギャラリー';

  @override
  String get arLens => 'ARレンズ';

  @override
  String get addedCharToLibrary => '(char) をライブラリに追加しました';

  @override
  String get scoreText => 'スコア';

  @override
  String get searchDictionaryHint => '文字、ピンイン、意味を検索...';

  @override
  String get searchDeckHint => '文字、ピンインを検索...';

  @override
  String get localRestaurant => '地元レストラン';

  @override
  String get taxiToAirport => '空港までタクシー';

  @override
  String get silkMarketHaggling => 'シルク市場での値切り';

  @override
  String get medicalClinic => '診療所';

  @override
  String get meetingAFriend => '友達と会う';

  @override
  String get jobInterview => '面接';

  @override
  String get searchRadicalsHint => '部首を検索（例：水、氵）';

  @override
  String get definition => '定義';

  @override
  String get undo => '元に戻す';

  @override
  String get hanziMaster => '漢字マスター';

  @override
  String get unlockForever => '永久アンロック - .99';

  @override
  String get clear => 'クリア';

  @override
  String get clearChat => 'チャットをクリア';

  @override
  String get typeMessage => 'メッセージを入力...';

  @override
  String get addedToLibrary => 'ライブラリに「(hanzi)」を追加しました';

  @override
  String get generateNewStory => '新しいストーリーを生成';

  @override
  String get failedToGenerateStory => 'ストーリーの生成に失敗しました:\\n(error)';

  @override
  String get detail => '詳細';

  @override
  String get scanText => 'テキストをスキャン';

  @override
  String get createMagic => '魔法を作成';

  @override
  String get learning => '学習中';

  @override
  String get upcomingReviews7Days => '今後の復習（今後7日間）';

  @override
  String get askFollowUpQuestion => '追加質問をする...';

  @override
  String get pasteScanToSimplify => '中国語の文章を貼り付けまたはスキャンして簡素化する';

  @override
  String get searchStoriesHint => 'タイトルやタグで物語を検索 (例: 神話, 旅行)';

  @override
  String get importAll => 'すべてインポート';

  @override
  String get ascendAll => 'すべて昇格';

  @override
  String get startAscension => '上達を開始';

  @override
  String get scenarioLocalRestaurant => '地元のレストラン';

  @override
  String get scenarioLocalRestaurantDesc => '料理を注文し、おすすめを尋ねる練習をします。';

  @override
  String get scenarioTaxiAirport => '空港へタクシー';

  @override
  String get scenarioTaxiAirportDesc => '運転手に行き先を伝え、交通状況について話します。';

  @override
  String get scenarioSilkMarket => 'シルクマーケットでの値切り';

  @override
  String get scenarioSilkMarketDesc => 'お土産の値段交渉をします。';

  @override
  String get scenarioMedicalClinic => '診療所';

  @override
  String get scenarioMedicalClinicDesc => '伝統的な医師に症状を説明します。';

  @override
  String get scenarioMeetingFriend => '友達と会う';

  @override
  String get scenarioMeetingFriendDesc => '自己紹介をして世間話をします。';

  @override
  String get scenarioJobInterview => '就職の面接';

  @override
  String get scenarioJobInterviewDesc => '上海のハイテク企業での役割に応募します。';

  @override
  String get createCustomScenario => 'カスタムシナリオを作成';

  @override
  String get customScenarioTitleHint => 'タイトル（例：結婚披露宴）';

  @override
  String get customScenarioDescHint => '説明（状況）';

  @override
  String get customScenarioPersonaHint => 'AIペルソナ（例：好奇心旺盛な同僚）';

  @override
  String get customScenarioDifficulty => '難易度';

  @override
  String get createAction => '作成';

  @override
  String get cancelAction => 'キャンセル';

  @override
  String get mythsAndLegends => '神話と伝説';

  @override
  String get historyAndCulture => '歴史と文化';

  @override
  String get idiomsTitle => '慣用句（成語）';

  @override
  String get theMonkeyKing => '孫悟空';

  @override
  String get theMonkeyKingDesc => '孫悟空（西遊記）';

  @override
  String get huaMulan => '花木蘭';

  @override
  String get huaMulanDesc => '花木蘭が父の代わりに軍に入隊する話';

  @override
  String get confuciusTitle => '孔子';

  @override
  String get confuciusDesc => '孔子の生涯と教え';

  @override
  String get theGreatWall => '万里の長城';

  @override
  String get theGreatWallDesc => '万里の長城の建設';

  @override
  String get generateTopic => 'トピックを生成';

  @override
  String get simplifyText => 'テキストを簡略化';

  @override
  String get topicHint => 'トピック（例：北京のエイリアン）';

  @override
  String get tagsHint => 'タグ（コンマ区切り、オプション）';

  @override
  String get speakWithMasterLin => 'リン先生と話す';

  @override
  String get masterLinGreeting => 'ご挨拶、学生よ。墨は用意できています。今日はどの文字やフレーズを考察しましょうか？';

  @override
  String get typeYourMessage => 'メッセージを入力...';

  @override
  String get theMainLibrary => 'メインライブラリ';

  @override
  String get hsk1Foundation => 'HSK 1: 基礎';

  @override
  String get hsk2Elementary => 'HSK 2: 初級';

  @override
  String get hsk3Intermediate => 'HSK 3: 中級';

  @override
  String get inDeckCheck => 'デッキ内 ✓';

  @override
  String get addToDeckPlus => '+ デッキに追加';

  @override
  String get openCardArrow => 'カードを開く →';

  @override
  String get pronunciationPartial => '声調は不正確';

  @override
  String get pronunciationWrong => '不正解';

  @override
  String get toneExpected => '正しい声調';

  @override
  String get toneYouSaid => 'あなたの声調';

  @override
  String get gotIt => '了解！';

  @override
  String foundNCharacters(int count) {
    return '(count)文字が見つかりました';
  }

  @override
  String get lookingUpCharacters => '文字を検索中…';

  @override
  String get practiceAll => 'すべて練習';

  @override
  String get arLensObjects => 'オブジェクト';

  @override
  String get arLensText => 'テキスト';

  @override
  String get arLensDetectedText => '検出されたテキスト';

  @override
  String get duration12Min => '1～2分';

  @override
  String get aClassicTangDynastyPoem => '唐詩の名作';

  @override
  String get aClassicTangDynastyPoemBy => '～による唐詩の名作';

  @override
  String get aStructuralComponent => '構造部品。';

  @override
  String get addSelectedToDeck => '選択をデッキに追加';

  @override
  String get addTo => ' に追加';

  @override
  String addedHanziToYourLibrary(String hanzi) {
    return '「$hanzi」をライブラリに追加しました';
  }

  @override
  String get adjustFontSize => 'フォントサイズ調整';

  @override
  String get againGoodEasyHard => '⬅️ もう一度    ➡️ 良い    ⬆️ 簡単    ⬇️ 難しい';

  @override
  String get aiAnalysisFailed => 'AI分析失敗';

  @override
  String get aiIsThinking => 'AIが考えています…';

  @override
  String get aiSceneAnalysisFailed => 'AIシーン分析失敗';

  @override
  String get allLabel => 'すべて';

  @override
  String get allPinyin => 'すべてのピンイン';

  @override
  String get alreadyHaveAccountSignIn => 'すでにアカウントをお持ちですか？ サインイン';

  @override
  String get analysisFailed => '分析失敗：';

  @override
  String get analyzingClassicalCharacters => '古典文字を分析中…';

  @override
  String get anatomy => '解剖学';

  @override
  String get ancientPhilosophy => '古代哲学';

  @override
  String get articleSavedToMediaHub => '記事をメディアハブに保存しました！';

  @override
  String get askAFollowUp => 'フォローアップをする…';

  @override
  String get audioPrivacyAndHowThingsWork => '音声、プライバシー、仕組みについて';

  @override
  String get audiobookPlayer => 'オーディオブックプレーヤー';

  @override
  String get audiobookVoice => 'オーディオブックの声';

  @override
  String get auntieMaTown => '馬おばさん（马阿姨）、元気いっぱいの屋台店主。町で一番サクサクの肉夹馍と涼皮を作る。';

  @override
  String get back => '戻る';

  @override
  String get baristaKevinNotes =>
      'バリスタの小凱さん（小凯）、雲南コーヒー豆の風味について熱く語る情熱的な若きコーヒーロースター。';

  @override
  String get bbc => 'BBC 中国語ウェブサイト';

  @override
  String get beginYourJourney => '旅を始める';

  @override
  String get bestValue => 'お得';

  @override
  String get bookLinkCopiedToClipboard => 'ブックリンクをクリップボードにコピーしました！';

  @override
  String get bookmarkChapter => 'チャプターをブックマーク';

  @override
  String get bookmarks => 'ブックマーク';

  @override
  String get books => '本';

  @override
  String get briefing => 'ブリーフィング';

  @override
  String get bugReport => 'バグ報告';

  @override
  String get caoXueqinDecline =>
      '曹雪芹（1715年頃～1763年）は清朝の小説家。雍正帝の時代に没落した裕福な旗人の家系に生まれ、貧困の中にあった晩年に『紅楼夢』を執筆。貴族社会の衰退を描いた心理描写豊かな一大叙事詩は、中国小説の最高峰と広く見なされている。';

  @override
  String get cardsTitle => 'カード';

  @override
  String get cc => '字幕';

  @override
  String get characterOrWord => '文字／単語';

  @override
  String get chatMore => 'さらにチャット';

  @override
  String get chefChenShumai => '陳シェフ（陈师傅）、陽気な広東点心シェフ。新鮮なエビ蒸し餃子とシューマイを推奨。';

  @override
  String get chineseEpics => '中国の叙事詩';

  @override
  String get chinesePoetry => '中国詩';

  @override
  String get chng => 'chéng';

  @override
  String get chongqingSpicyHotpotFeast => '重慶激辛火鍋の宴';

  @override
  String get chooseAudiobookVoice => 'オーディオブックの声を選択';

  @override
  String get chooseVoice => '声を選択';

  @override
  String get compare => '比較';

  @override
  String get compare4Tones => '四声を比較';

  @override
  String get configuration => '設定';

  @override
  String get contemporary => '現代';

  @override
  String get context => '文脈';

  @override
  String get couldNotLoadLibrary => 'ライブラリを読み込めませんでした';

  @override
  String get couldNotLoadVocabulary => '語彙を読み込めませんでした。';

  @override
  String get couldNotOpenEmailApp => 'メールアプリを開けませんでした。';

  @override
  String get createAccount => 'アカウント作成';

  @override
  String get createNewDeck => '新規デッキ作成';

  @override
  String get createScenario => 'シナリオ作成';

  @override
  String get createStory => 'ストーリー作成';

  @override
  String get customLabel => 'カスタム';

  @override
  String get customWord => 'カスタム単語';

  @override
  String get days => '日';

  @override
  String get deck => 'デッキ';

  @override
  String get deckName => 'デッキ名';

  @override
  String get deckStory => 'デッキストーリー';

  @override
  String get deepAnalysis => '詳細分析';

  @override
  String get defaultDeck => 'デフォルトデッキ';

  @override
  String get deleteLabel => '削除';

  @override
  String get deleteScenario => 'シナリオ削除';

  @override
  String get deletesAllProgressPermanently => 'すべての進行状況を完全に削除します';

  @override
  String get developerBackdoorUnlocked => '開発者バックドア解除！';

  @override
  String get doesNotExistInChinese => '中国語に存在しません';

  @override
  String get dontHaveAccountSignUp => 'アカウントをお持ちでないですか？ サインアップ';

  @override
  String get draftingStoryOutline => 'ストーリーの概要を作成中…';

  @override
  String get dynamicFlowState => '動的フロー状態';

  @override
  String get dynamicFlowStateParenthetical => '動的（フロー状態）';

  @override
  String get editCard => 'カードを編集';

  @override
  String get egAnimeVocab => '例：アニメ語彙';

  @override
  String get egFormalBusinessLanguageSlangForTexting => '例：ビジネス用語、テキスト用スラング…';

  @override
  String get egOrderingAtARestaurantBusinessVocab => '例：レストランでの注文、ビジネス語彙…';

  @override
  String get egWeddingReceptionTechInterview => '例：結婚披露宴、技術面接…';

  @override
  String get emailLabel => 'メール';

  @override
  String get english => '英語';

  @override
  String get englishAndWorld => '英語と世界';

  @override
  String get episodes => 'エピソード';

  @override
  String get erase => '消去';

  @override
  String get eraseDeckQuestion => 'デッキを消去しますか？';

  @override
  String errorFetchingTranslationForLabelE(String label, String e) {
    return '$labelの翻訳の取得エラー：$e';
  }

  @override
  String errorLoadingMicroreadsE(String e) {
    return 'マイクロリーディングの読み込みエラー：$e';
  }

  @override
  String errorLoadingNovelsE(String e) {
    return '小説の読み込みエラー：$e';
  }

  @override
  String errorLoadingPoetryE(String e) {
    return '詩の読み込みエラー：$e';
  }

  @override
  String get exitFocus => 'フォーカス終了';

  @override
  String get explore => '探索';

  @override
  String get exportToThisDeck => 'このデッキにエクスポート';

  @override
  String get extractAndSimplify => '抽出と簡略化';

  @override
  String get failedToCreateDeck => 'デッキの作成に失敗しました';

  @override
  String get failedToLoadDailyContent => 'デイリーコンテンツの読み込みに失敗しました';

  @override
  String get failedToLoadEpisodes => 'エピソードの読み込みに失敗しました';

  @override
  String get failedToLoadShows => '番組の読み込みに失敗しました';

  @override
  String get finalizingDetails => '詳細を確定中…';

  @override
  String get finalizingStoryDetails => 'ストーリー詳細を確定中…';

  @override
  String get firebaseAuthConsole =>
      'Firebase認証が有効になっていません。Firebaseコンソールで必要なサインイン方法を有効にしてください。';

  @override
  String get flashcardDeckTitle => 'フラッシュカードデッキ';

  @override
  String get focus => 'フォーカス';

  @override
  String get foodAndCooking => '料理とグルメ';

  @override
  String get forward => '進む';

  @override
  String get freeFlow => 'フリーフロー';

  @override
  String get frenchClassics => 'フランス古典';

  @override
  String get full => '完全';

  @override
  String get gamingAndEsports => 'ゲームとeスポーツ';

  @override
  String get germanClassics => 'ドイツ古典';

  @override
  String get ghostPinyin => 'ゴーストピンイン';

  @override
  String get goodAttempt => '良い試み';

  @override
  String get gotItSimple => '了解';

  @override
  String get grammar => 'Gramática';

  @override
  String get grandmaLiuFilling =>
      '劉おばあちゃん（刘奶奶）、優しい北国の祖母。餃子のひだの作り方と豚ネギあんを教えてくれる。';

  @override
  String get great => '素晴らしい！';

  @override
  String get handmadeDumplingFeastInHarbin => 'ハルビン手作り餃子の宴';

  @override
  String get hanziCharacter => '漢字（文字）';

  @override
  String get hapticFeedback => '触覚フィードバック';

  @override
  String get helpAndSupport => 'ヘルプ＆サポート';

  @override
  String get hidden => '非表示';

  @override
  String get hideEnglishTranslations => '英語翻訳を隠す';

  @override
  String get hidePinyin => 'ピンインを隠す';

  @override
  String get highlight => 'ハイライト';

  @override
  String get howWouldYouLikeToStudy => 'どのように学習しますか？';

  @override
  String get hsk1 => 'HSK 1';

  @override
  String get hsk4UpperIntermediate => 'HSK 4：中上級';

  @override
  String get hsk5Advanced => 'HSK 5：上級';

  @override
  String get hsk6Mastery => 'HSK 6：熟達';

  @override
  String get hskCollections => 'HSKコレクション';

  @override
  String hskLevel(String level) {
    return 'HSK $level';
  }

  @override
  String get hskSimplifySubtitles => 'HSK字幕簡略化';

  @override
  String get hskVocabularyCollections => 'HSK語彙コレクション';

  @override
  String get i => '私\\';

  @override
  String get ifTheAgain =>
      'AIが不一致を検出した場合、「～と言いたかったのですか？」と尋ねます。「はい、再評価してください！」ボタンをタップすると、もう一度話すことなく、元の音声を意図に基づいて即座に再評価できます。';

  @override
  String get install => 'インストール';

  @override
  String get just => 'わずか\\\$';

  @override
  String get keyword => 'キーワード';

  @override
  String get knowledgeBase => '知識ベース';

  @override
  String get liRuzhenSubjects =>
      '李汝珍（1763年頃～1830年）は清朝の学者で、音韻論、囲碁、宇宙論に深い関心を持っていた。彼の幻想小説『鏡花縁』は、商人が不可能な王国を旅する物語で、フェミニズム的主題と百科全書的な知識の幅で特筆される。';

  @override
  String get library => '文化書房ライブラリ';

  @override
  String get lifestyleAndVlog => 'ライフスタイル＆ブログ';

  @override
  String get listenInAudiobookMode => 'オーディオブックモードで聴く';

  @override
  String get listenToThisWord => 'この単語を聴く';

  @override
  String get listening => '聴いています…';

  @override
  String get liuEEncroachment =>
      '劉鶚（1857～1909年）は清末の博学者——技術者、医者、そして小説家。唯一の小説『老残遊記』は、抒情性に富みながらも政治色の強い旅日記であり、王朝の崩壊と外国の侵食に苦しむ中国を巡る放浪の治療者の物語である。';

  @override
  String get loadingTranslations => '翻訳を読み込み中…';

  @override
  String get luXunVernacular =>
      '魯迅（1881～1936年）、周樹人の筆名。現代中国文学の父。医者から転じて中国の精神を癒すために筆を執り、彼の短編集——『狂人日記』と『阿Q正伝』——は口語';

  @override
  String get luoGuanzhongEpic =>
      '羅貫中（1330年頃～1400年）は元末明初の劇作家・小説家で、施耐庵に師事したとされる。『三国志演義』は歴史書、口承伝統、劇的な語りを融合させ、中国歴史叙事詩の決定版を創り上げた。';

  @override
  String get makeACustomCollection => 'カスタムコレクションを作成';

  @override
  String get manageDailyDropsAndReviewReminders => 'デイリードロップと復習リマインダーを管理';

  @override
  String get managerYuOptions =>
      '余店長（余店长）、熱血火鍋店長。名物のハチノス、鴨血、マイルドなスープのオプションを推奨。';

  @override
  String get masterGaoRubs =>
      '高師傅（高师傅）、カリスマ的な炭火焼きマスター。お客とスパイスレベルや秘密のクミンの効き具合について冗談を交わす。';

  @override
  String get masterThisToUnlockItsGalaxy => 'これを習得して銀河を解除しよう。';

  @override
  String get masterZhaoBrewing => '趙師傅（赵师傅）、忍耐強く知識豊富な茶ソムリエ。工夫茶の淹れ方を情熱的に解説する。';

  @override
  String get mastery => '熟達度';

  @override
  String get maybeLater => '後で';

  @override
  String get memes => 'ミーム';

  @override
  String get midnightBbqSkewersInWuhan => '武漢深夜の焼き串';

  @override
  String get mo => '/mo';

  @override
  String get modernChinese => '現代中国語';

  @override
  String get monthly => '月額';

  @override
  String get morningDimSumCartInGuangzhou => '広州朝の点心カート';

  @override
  String get nameLabel => '名前';

  @override
  String get native => 'ネイティブ';

  @override
  String get newCard => '新規カード';

  @override
  String get newDeck => '新規デッキ';

  @override
  String get newDeckName => '新規デッキ名';

  @override
  String get noActiveSubscriptionFound => '有効なサブスクリプションが見つかりません。';

  @override
  String get noEpisodesFound => 'エピソードが見つかりません';

  @override
  String get noKeyWordsFoundForThisStory => 'このストーリーのキーワードは見つかりません。';

  @override
  String get noLabel => 'いいえ';

  @override
  String get noNewWordsFound => '新しい単語は見つかりません！';

  @override
  String get noPinyin => 'ピンインなし';

  @override
  String get noPremiumPackagesAvailable => '現在利用可能なプレミアムパッケージはありません。';

  @override
  String noResultsFoundForSearchquery(String searchQuery) {
    return '「$searchQuery」の検索結果は見つかりません';
  }

  @override
  String get noSavedArticlesYet => '保存された記事はまだありません。';

  @override
  String get noShowsAvailable => '利用可能な番組はありません';

  @override
  String get noStoriesFound => 'ストーリーが見つかりません。';

  @override
  String get noWordsSelected => '単語が選択されていません';

  @override
  String get notes => 'ノート';

  @override
  String get notoserifsc => 'NotoSerifSC';

  @override
  String get objectivesTitle => '目標';

  @override
  String get openInYoutube => 'YouTubeで開く';

  @override
  String get orderingHanddripCoffeeInShanghai => '上海でハンドドリップコーヒーを注文';

  @override
  String get orderingSugarcoatedHawsInWinterBeijing => '冬の北京で糖葫芦を注文';

  @override
  String partnerLang(String lang) {
    return 'パートナー（$lang）';
  }

  @override
  String get partnerListening => 'パートナー聴取中…';

  @override
  String get partnerSpeaking => 'パートナー発話中…';

  @override
  String get passwordLabel => 'パスワード';

  @override
  String get pause => '一時停止';

  @override
  String get perfect => '完璧！';

  @override
  String get personalizedPathBasedOnDeck => 'デッキに基づいたパーソナライズされた学習パス。';

  @override
  String get play => '(pinyin) を再生';

  @override
  String get pleaseEnterMessageBeforeSending => '送信前にメッセージを入力してください。';

  @override
  String get practiceInRoleplay => 'ロールプレイで練習';

  @override
  String get practiceModes => '練習モード';

  @override
  String get practicePronouncingWithAiGrading => 'AI採点でこの単語の発音を練習';

  @override
  String get preparingReadingInterface => '読書インターフェースを準備中…';

  @override
  String get privacy => 'プライバシー';

  @override
  String get privacyAndAudio => 'プライバシーと音声';

  @override
  String get puSonglingLiterature =>
      '蒲松齢（1640～1715年）は清朝の作家。科挙に何度も落第した後、長年にわたり『聊斎志異』を編纂。狐の精、幽霊、学者たちを描いた彼の怪異譚は、中国ゴシック文学の最高峰であり続けている。';

  @override
  String get qaFaq => 'Q&A／FAQ';

  @override
  String get questsTitle => 'クエスト';

  @override
  String get quickBookmarks => 'クイックブックマーク';

  @override
  String get radical => '部首';

  @override
  String get ready => '準備完了';

  @override
  String get readyToInterpret => '解釈の準備完了';

  @override
  String get readyToStart => '開始する準備ができました。';

  @override
  String get recentBookmarks => '最近のブックマーク';

  @override
  String get refiningGrammar => '文法を精査中…';

  @override
  String get refresh => '更新';

  @override
  String get removeFromSaved => '保存から削除';

  @override
  String get removeFromSavedScenarios => '保存シナリオから削除';

  @override
  String get removed => '削除済み';

  @override
  String get requestPermissions => '許可をリクエスト';

  @override
  String get rescind => '取り消す';

  @override
  String get restore => '復元';

  @override
  String get results => '結果';

  @override
  String get resume => '再開';

  @override
  String get retry => '再試行';

  @override
  String get revenuecatError => 'RevenueCatエラー：';

  @override
  String revenuecatErrorE(String e) {
    return 'RevenueCatエラー：$e';
  }

  @override
  String get reviewExtractedDeck => '抽出したデッキを復習';

  @override
  String get reviewIn => '復習予定';

  @override
  String get reviewingYourTones => '声調を確認中…';

  @override
  String get saveAll => 'すべて保存';

  @override
  String get saveScenario => 'シナリオを保存';

  @override
  String get saveThisScenario => 'このシナリオを保存';

  @override
  String get saved => '保存済み';

  @override
  String get scanAnother => '別をスキャン';

  @override
  String get scenarioRemoved => 'シナリオを削除しました';

  @override
  String get scenarioSavedFindInCustomTab => 'シナリオを保存しました！カスタムタブで見つけてください。';

  @override
  String get score => 'スコア: (score) / (total)';

  @override
  String get searchByPinyinOrMeaning => 'ピンインまたは意味で検索…';

  @override
  String get searchByTitleOrTag => 'タイトルまたはタグで検索…';

  @override
  String get searchDictionaryOrTypeCustom => '辞書を検索するかカスタム文字を入力';

  @override
  String get searchHint => '検索…';

  @override
  String get searchOrEnterUrl => '検索またはURLを入力';

  @override
  String get searchScenariosHint => 'シナリオを検索…';

  @override
  String get searchStoriesIdiomsNews => 'ストーリー、慣用句、ニュースを検索…';

  @override
  String get searchTopicsEgCookingHistory => 'トピックを検索（例：料理、歴史）';

  @override
  String get seeAll => 'すべて表示';

  @override
  String get selectADeck => 'デッキを選択';

  @override
  String get selectPracticeMode => '練習モードを選択';

  @override
  String get selectingHskVocabulary => 'HSK語彙を選択中…';

  @override
  String get send => '送信';

  @override
  String get sendMessage => 'メッセージを送信';

  @override
  String get serif => 'セリフ';

  @override
  String get shadow => 'シャドー';

  @override
  String get shiNaianEpic =>
      '施耐庵（1296年頃～1372年）は元朝の文人。科挙に合格したと伝えられるが、隠遁生活を選んだ。彼の傑作『水滸伝』は、義侠の英雄たちと正義の反逆を描き、中国武侠叙事詩の原型を確立した。';

  @override
  String get showEnglish => '英語を表示';

  @override
  String get showEnglishTranslations => '英語翻訳を表示';

  @override
  String get showHanzi => '漢字を表示';

  @override
  String get showPinyin => 'ピンインを表示';

  @override
  String get showTranslation => '翻訳を表示';

  @override
  String get shows => '番組';

  @override
  String get signIn => 'サインイン';

  @override
  String get simplifiedArticle => '簡略化記事';

  @override
  String get simplifyingSubtitles => '字幕を簡略化中…';

  @override
  String get sincereHonest => '誠実な；正直な';

  @override
  String get sleepTimer => 'スリープタイマー';

  @override
  String get smartDeck => 'スマートデッキ';

  @override
  String get spanishAndWorld => 'スペイン語と世界';

  @override
  String get speaker => '話者';

  @override
  String get spotifyStylePlayer => 'Spotifyスタイルプレーヤー';

  @override
  String get storyBookmarkedInLibrary => 'ストーリーをライブラリにブックマークしました！';

  @override
  String get streetFoodNightMarketInXian => '西安の屋台ナイトマーケット';

  @override
  String get strokes => '画数';

  @override
  String get studyCharacter => '文字を学習';

  @override
  String get subtitleOpacity => '字幕の不透明度';

  @override
  String get suggestion => '提案';

  @override
  String get summary => '要約';

  @override
  String get supernaturalAndFolklore => '超自然と民話';

  @override
  String get swipeToGrade => 'スワイプで評価：';

  @override
  String get tableOfContents => '目次';

  @override
  String get tapToRetry => 'タップして再試行';

  @override
  String get teaTastingInChengdu => '成都での茶葉テイスティング';

  @override
  String get techAndGadgets => 'テクノロジーとガジェット';

  @override
  String get terms => '利用規約';

  @override
  String get theGalaxyCharacters =>
      '銀河マップがあなたを待っています。\n太陽（部首）を制覇して、惑星（文字）を解放しよう。';

  @override
  String get theme => 'テーマ';

  @override
  String get thinking => '考え中…';

  @override
  String get thisArticleCharacters => 'この記事は繁体字中国語を含みます。';

  @override
  String get todaysWord => '今日の単語';

  @override
  String get togglePinyin => 'ピンイン切替';

  @override
  String get toggleTranslation => '翻訳切替';

  @override
  String get toneDoesNotExistInMandarin => 'この声調は標準中国語には存在しません。';

  @override
  String get toneGraph => '声調グラフ';

  @override
  String get traceLabel => 'なぞり書き';

  @override
  String get trailer => '予告編';

  @override
  String get translatingAndAddingPinyin => '翻訳とピンイン追加中…';

  @override
  String get translatingText => 'テキストを翻訳中…';

  @override
  String get turnOn => 'オンにする';

  @override
  String get typeHanziPinyinOrEnglish => '漢字、ピンイン、または英語を入力…';

  @override
  String get unknown2 => '游戏 实况 王者荣耀 原神';

  @override
  String get unknown3 => '中国 美食 菜谱';

  @override
  String get unknown4 => '中国 科技 测评';

  @override
  String get unrollingTheScroll => '巻物を広げています…';

  @override
  String get upperIntermediate => '中上級';

  @override
  String get vibrationsForInteractions => '操作時のバイブレーション';

  @override
  String get video => '動画';

  @override
  String get viewAnswer => '答えを見る';

  @override
  String get viewAsList => 'リスト表示';

  @override
  String get viewBookmarks => 'ブックマークを見る';

  @override
  String get viewMyDrawing => '描いたものを見る';

  @override
  String get vlog => '中国 日常 vlog';

  @override
  String get voice => '声：';

  @override
  String get web => 'ウェブ';

  @override
  String get wedLoveToHearFromYou => 'ぜひご意見を\nお聞かせください。';

  @override
  String get welcomeBack => 'おかえりなさい';

  @override
  String get whatDoesThisMean => 'これはどういう意味ですか？';

  @override
  String get whatHappensToMyChatHistory => 'チャット履歴はどうなりますか？';

  @override
  String get whatIfAiMishears => 'AIが言おうとしたことを聞き間違えた場合は？';

  @override
  String get whichCharacterIs => '次の文字はどれですか：';

  @override
  String get wikipedia => 'Wikipedia';

  @override
  String get wordsSavedAndSrsScheduled => '単語を保存し、SRSをスケジュールしました！';

  @override
  String get writeYourMessageHere => 'ここにメッセージを書く…';

  @override
  String get wuChengenLiterature =>
      '呉承恩（1500年頃～1582年）は明朝の小説家、江蘇淮安出身。数十年にわたる民間伝承、仏教の寓意、風刺的機知を基に、唐の巡礼神話を『西遊記』に織り上げた——世界文学の中でも最も独創的で愛される作品の一つである。';

  @override
  String get wuJingziClass =>
      '呉敬梓（1701～1754年）は清朝の小説家、安徽出身。相続した財産を捨て、生涯をかけて『儒林外史』を執筆。科挙制度と知識人階級の虚栄、腐敗、不条理を痛烈に風刺した傑作である。';

  @override
  String get xuZhonglinWarfare =>
      '許仲琳（16～17世紀）は明朝の著者。『封神演義』の編纂者として知られ、殷周の歴史と道教の宇宙観、天界の官僚機構、英雄的な戦争を融合させた神話小説の記念碑的作品である。';

  @override
  String get yearly => '年間';

  @override
  String get yesReGradeMe => 'はい、再評価してください！';

  @override
  String get you => 'あなた ((lang))';

  @override
  String get youAreSpeaking => 'あなたは話しています';

  @override
  String get youLabel => 'あなた';

  @override
  String youLang(String lang) {
    return 'あなた（$lang）';
  }

  @override
  String get youMustAccount => 'アカウントを作成するには、利用規約とプライバシーポリシーに同意する必要があります。';

  @override
  String get yourEchoModels =>
      'あなたのエコーホールの会話は、いつでも見直せるようデバイスにローカル保存されます。個人の会話がAIモデルのトレーニングに使用されることはありません。';

  @override
  String get zhOnly => '中文のみ';

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
  String get learning_stats => '学習統計';

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
  String get notification_settings => '通知設定';

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
  String get previous => 'Anterior';

  @override
  String get question => '質問 (current)/(total)';

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
  String get view_your_learning_history_and_streaks => '学習履歴と連続記録を表示';

  @override
  String get what_is_shadowing_studio => 'What is Shadowing Studio?';

  @override
  String get words => 'words';

  @override
  String your_path_for_is_ready(String deckName) {
    return 'Your path for \'(deckName)\' is ready!';
  }

  @override
  String get you_said => '🗣️ You Said';

  @override
  String get vocabularyBatch => '語彙バッチ (index)';

  @override
  String get yourDailyDropIsHere => '今日のドロップが届きました！ ✨';

  @override
  String get timeToReview => '復習の時間です！ 📚';

  @override
  String get neverMissAStroke => '一画たりともお見逃しなく！ 🖌️';

  @override
  String get yourTrialEndsTomorrow => '体験期間は明日までです！ ⏳';

  @override
  String get officialStandardVocabularyTiers => '公式標準語彙レベル';

  @override
  String get failedToLoadCollections => 'コレクションの読み込みに失敗しました。';

  @override
  String get unnamedKey => '#(tag)';

  @override
  String get error => 'エラー: (error)';

  @override
  String get aiSmartContext => 'AIスマートコンテキスト';

  @override
  String get aiSmartContextError => 'AIスマートコンテキストエラー';

  @override
  String get downloadOfficialHskCollections => '公式HSKコレクションをダウンロード';

  @override
  String get unableToLoadThisSection => 'このセクションを読み込めませんでした。もう一度お試しください。';

  @override
  String get translationLanguage => '翻訳言語';

  @override
  String get dailyDrops => '今日のドロップ';

  @override
  String get wordOfTheDayNews => '今日の単語とニュース';

  @override
  String get reviewReminders => '復習リマインダー';

  @override
  String get flashcardsDueForReview => '復習期限のフラッシュカード';

  @override
  String get dailyNewCards => '毎日の新規カード';

  @override
  String get dailyReviewLimit => '毎日の復習制限';

  @override
  String get practiceMode => '練習モード';

  @override
  String get liziqi => '李子柒 Liziqi: 絹花';

  @override
  String get theLifeOfGarlicTraditional => 'ニンニクの生活 - 伝統的な中国の暮らし';

  @override
  String get graceMandarin50Phrases => 'Grace Mandarin: 50フレーズ';

  @override
  String get essentialChinesePhrasesForBeginners => '初心者向け必須中国語フレーズ';

  @override
  String get makingBambooFurniture => '竹製家具作り';

  @override
  String get peppaPigChinese => 'ペッパピッグ 中国語: 躲猫猫';

  @override
  String get muddyPuddlesBeginnerFriendly => '泥だらけの水たまり - 初心者向け';

  @override
  String get mandarinCorner300Verbs => 'Mandarin Corner: 300の動詞';

  @override
  String get mostCommonChineseVerbs => '最も一般的な中国語の動詞';

  @override
  String get graceMandarinOrderFood => 'Grace Mandarin: 食べ物を注文する';

  @override
  String get howToOrderFoodIn => '中華料理店で食べ物を注文する方法';

  @override
  String get silkFlowersTraditionalCraft => '絹の花 - 伝統工芸';

  @override
  String get mandarinCorner => 'Mandarin Corner: 中国語で医者にかかる';

  @override
  String get goingToTheDoctorReal => '医者に行く - 実生活の会話';

  @override
  String get hideAndSeekBeginnerFriendly => 'かくれんぼ - 初心者向け';

  @override
  String get linGdp6 => '小Linが語る: なぜGDPが6%成長するのか';

  @override
  String get why6GdpGrowthEasy => 'なぜGDPが6%成長するのか - やさしい中国経済';

  @override
  String get bbcWorldNews => 'BBC 中国語 (ワールドニュース)';

  @override
  String get currentEventsInSimplifiedChinese => '簡体字中国語の時事問題';

  @override
  String get baidu => 'Baidu';

  @override
  String get youtubeDesk => 'YouTubeデスク';

  @override
  String get interactiveTranscriptsShadowing => 'インタラクティブなトランスクリプトとシャドーイング';

  @override
  String get showsDramas => '番組とドラマ';

  @override
  String get extractToDeck => 'デッキに抽出';

  @override
  String get autoSimplify => '自動簡略化';

  @override
  String get rewriteThisArticleToMatch => 'この記事をあなたのHSKレベルに合わせて書き直す';

  @override
  String get failedToSaveExtractedWords => '抽出された単語の保存に失敗しました: (error)';

  @override
  String get addToDeck => 'デッキに追加 ((count))';

  @override
  String get dailyDiscoveryDrop => '毎日のおすすめ';

  @override
  String get smartSpacedRepetition => 'スマート間隔反復';

  @override
  String get trialProtectionAlert => 'トライアル保護アラート';

  @override
  String get masteryLevel => '習熟度レベル';

  @override
  String get targetObjective => '目標';

  @override
  String get dailyPractice => '毎日の練習';

  @override
  String get aiSpacedRepetition => 'AI間隔反復';

  @override
  String get iVeGrantedAccess => 'アクセスを許可しました';

  @override
  String get scanner => 'スキャナー';

  @override
  String get interpreter => '通訳';

  @override
  String get cards => '(count) カード';

  @override
  String get nWaMendsTheHeavens => '女媧、天を補修する';

  @override
  String get terracottaArmy => '兵馬俑';

  @override
  String get forbiddenCity => '紫禁城';

  @override
  String get aBlessingInDisguise => '災い転じて福となす';

  @override
  String get drawingASnake => '蛇を描く';

  @override
  String get takingTheBulletTrain => '新幹線に乗る';

  @override
  String get visitingTheDoctor => '医者に行く';

  @override
  String get orderingDumplings => '餃子を注文する';

  @override
  String get theTeaCeremony => '茶道';

  @override
  String get chineseCalligraphy => '中国書道';

  @override
  String get theGiantPanda => 'ジャイアントパンダ';

  @override
  String get simplifiedText => '簡体字テキスト';

  @override
  String get novels96 => '小説 (96)';

  @override
  String get microReads => 'マイクロリーディング';

  @override
  String get poetry => '詩';

  @override
  String get bookmarkRemoved => '书签已移除 · ブックマークを削除しました';

  @override
  String get bookmarkAdded => '已添加书签 · ブックマークを追加しました: 第(chapter)回';

  @override
  String get readingVocabulary => '読解と語彙';

  @override
  String get vocabularyBatchUnitindex1 => '語彙バッチ \$(unitIndex + 1)';

  @override
  String get yourDailyDropIsHere1 => '今日のデイリードロップが届きました！✨';

  @override
  String get timeToReview1 => '復習の時間です！📚';

  @override
  String get neverMissAStroke1 => '書き順を見逃さないで！🖌️';

  @override
  String get yourTrialEndsTomorrow1 => 'トライアルは明日終了します！⏳';

  @override
  String get hskCollections1 => 'HSKコレクション';

  @override
  String get officialStandardVocabularyTiers1 => '公式標準語彙レベル';

  @override
  String get failedToLoadCollections1 => 'コレクションの読み込みに失敗しました。';

  @override
  String get ui__transcription => '「\$_transcription」';

  @override
  String get playPinyinwithtone => '\$pinyinWithToneを再生';

  @override
  String get errorE => 'エラー: \$e';

  @override
  String get lookalikepinyin => '（\$(lookAlike.pinyin)）';

  @override
  String get aiSmartContext1 => 'AIスマートコンテキスト';

  @override
  String get aiSmartContextError1 => 'AIスマートコンテキストエラー';

  @override
  String get errorErr => 'エラー: \$err';

  @override
  String get downloadOfficialHskCollections1 => '公式HSKコレクションをダウンロード';

  @override
  String get unableToLoadThisSectionPleaseTryAga =>
      'このセクションを読み込めませんでした。もう一度お試しください。';

  @override
  String get searchRadicalsEgWater => '部首を検索（例：水、氵）';

  @override
  String get ui__currentstrokeindex1totalstrokes =>
      '\$(_currentStrokeIndex + 1)/\$totalStrokes';

  @override
  String get translationLanguage1 => '翻訳言語';

  @override
  String get appLanguage1 => 'アプリの言語';

  @override
  String get dailyDrops1 => 'デイリードロップ';

  @override
  String get wordOfTheDayNews1 => '今日の単語＆ニュース';

  @override
  String get reviewReminders1 => '復習リマインダー';

  @override
  String get flashcardsDueForReview1 => '復習するフラッシュカード';

  @override
  String get accuracyByMode1 => 'モード別正答率';

  @override
  String get accuracytostringasfixed1 => '\$(accuracy.toStringAsFixed(1))%';

  @override
  String get upcomingReviewsNext7Days => '今後の復習（今後7日間）';

  @override
  String get explaining => '説明中：';

  @override
  String get entryhanziEntrypinyin => '\$(entry.hanzi) [\$(entry.pinyin)]';

  @override
  String get dailyNewCards1 => '1日の新規カード';

  @override
  String get dailyReviewLimit1 => '1日の復習制限';

  @override
  String get listeningMode1 => 'リスニングモード';

  @override
  String get readingMode1 => 'リーディングモード';

  @override
  String get recallMode1 => '想起モード';

  @override
  String get speakingMode1 => 'スピーキングモード';

  @override
  String get practiceMode1 => '練習モード';

  @override
  String get acc => '\$acc%';

  @override
  String get partner1 => 'パートナー';

  @override
  String get partnerSpeaking1 => 'パートナーが話しています…';

  @override
  String get theLifeOfGarlicTraditionalChineseLi => 'ニンニクの一生 - 中国の伝統的な生活';

  @override
  String get graceMandarin50Phrases1 => 'Grace Mandarin: 50フレーズ';

  @override
  String get essentialChinesePhrasesForBeginners1 => '初心者向け必須中国語フレーズ';

  @override
  String get makingBambooFurniture1 => '竹の家具作り';

  @override
  String get muddyPuddlesBeginnerFriendly1 => '泥だらけの水たまり - 初心者向け';

  @override
  String get mandarinCorner300Verbs1 => 'Mandarin Corner: 300動詞';

  @override
  String get mostCommonChineseVerbs1 => '最も一般的な中国語動詞';

  @override
  String get graceMandarinOrderFood1 => 'Grace Mandarin: 食べ物を注文する';

  @override
  String get howToOrderFoodInAChineseRestaurant => '中華料理店での注文方法';

  @override
  String get silkFlowersTraditionalCraft1 => '絹の花 - 伝統工芸';

  @override
  String get goingToTheDoctorRealLifeConversatio => '医者にかかる - 実生活での会話';

  @override
  String get hideAndSeekBeginnerFriendly1 => 'かくれんぼ - 初心者向け';

  @override
  String get lingdp6 => '小Lin说: なぜGDPが6%成長するのか';

  @override
  String get why6GdpGrowthEasyChineseEconomics => 'なぜGDPが6%成長するのか - わかりやすい中国経済';

  @override
  String get currentEventsInSimplifiedChinese1 => '簡体字中国語の時事問題';

  @override
  String get baidu1 => 'Baidu';

  @override
  String get youtubeDesk1 => 'YOUTUBE DESK';

  @override
  String get interactiveTranscriptsShadowing1 => 'インタラクティブなトランスクリプト＆シャドーイング';

  @override
  String get showsDramas1 => '番組＆ドラマ';

  @override
  String get error_error => 'エラー: \$_error';

  @override
  String get extractToDeck1 => 'デッキに抽出';

  @override
  String get autosimplify => '自動簡略化';

  @override
  String get rewriteThisArticleToMatchYourHskLev => 'この記事をあなたのHSKレベルに合わせて書き換える';

  @override
  String get addToDeck1 => 'デッキに追加';

  @override
  String get playbackratex => '\$(playbackRate)倍速';

  @override
  String get speedx => '\$(speed)倍速';

  @override
  String get dailyDiscoveryDrop1 => 'デイリーディスカバードロップ';

  @override
  String get smartSpacedRepetition1 => 'スマート間隔反復';

  @override
  String get trialProtectionAlert1 => 'トライアル保護アラート';

  @override
  String get masteryLevel1 => '習熟度レベル';

  @override
  String get targetObjective1 => '目標';

  @override
  String get dailyPractice1 => '毎日の練習';

  @override
  String get aiSpacedRepetition1 => 'AI間隔反復';

  @override
  String get iveGrantedAccess => 'アクセスを許可しました';

  @override
  String get addToDeck_selectedwordindiceslength =>
      'デッキに追加 (\$(_selectedWordIndices.length))';

  @override
  String get scanner1 => 'スキャナー';

  @override
  String get interpreter1 => '通訳';

  @override
  String get entryvalueCards => '\$(entry.value)枚のカード';

  @override
  String get score_score_questionslength =>
      'スコア: \$_score / \$(_questions.length)';

  @override
  String get theMonkeyKing1 => '孫悟空';

  @override
  String get huaMulan1 => '花木蘭';

  @override
  String get nwaMendsTheHeavens => '女媧補天';

  @override
  String get confucius => '孔子';

  @override
  String get theGreatWall1 => '万里の長城';

  @override
  String get terracottaArmy1 => '兵馬俑';

  @override
  String get forbiddenCity1 => '紫禁城';

  @override
  String get aBlessingInDisguise1 => '人間万事塞翁が馬';

  @override
  String get drawingASnake1 => '蛇足';

  @override
  String get takingTheBulletTrain1 => '高速鉄道に乗る';

  @override
  String get visitingTheDoctor1 => '医者にかかる';

  @override
  String get orderingDumplings1 => '餃子を注文する';

  @override
  String get theTeaCeremony1 => '中国茶芸';

  @override
  String get chineseCalligraphy1 => '中国書道';

  @override
  String get theGiantPanda1 => 'ジャイアントパンダ';

  @override
  String get simplifiedText1 => '簡体字テキスト';

  @override
  String get novels961 => '小説 (96)';

  @override
  String get microreads => 'マイクロリーディング';

  @override
  String get poetry1 => '詩';

  @override
  String get readingVocabulary1 => '読解＆語彙';

  @override
  String get defaultfirebaseoptionsHaveNotBeenCo =>
      'DefaultFirebaseOptionsがLinux用に設定されていません -';

  @override
  String get defaultfirebaseoptionsAreNotSupport =>
      'このプラットフォームではDefaultFirebaseOptionsはサポートされていません。';

  @override
  String get hanziMaster1 => '漢字マスター';

  @override
  String get strokesCannotBeEmpty => '画数は空にできません。';

  @override
  String get wrongStartPoint => '開始点が間違っています。';

  @override
  String get rightShapeButWrongPlace => '形は正しいですが、場所が違います！';

  @override
  String get goodFollowTheFlow => '良いです！\') : \'流れに沿って書きましょう。';

  @override
  String get aBitShaky => '少し不安定です！';

  @override
  String get aBitHesitant => '少しためらいがあります...';

  @override
  String get shapeIsOff => '形がずれています。';

  @override
  String get arabic => 'アラビア語';

  @override
  String get german => 'ドイツ語';

  @override
  String get spanish => 'スペイン語';

  @override
  String get french => 'フランス語';

  @override
  String get hindi => 'ヒンディー語';

  @override
  String get indonesian => 'インドネシア語';

  @override
  String get italian => 'イタリア語';

  @override
  String get japanese => '日本語';

  @override
  String get korean => '韓国語';

  @override
  String get portuguese => 'ポルトガル語';

  @override
  String get russian => 'ロシア語';

  @override
  String get vietnamese => 'ベトナム語';

  @override
  String get microphonePermissionDenied => 'マイクの許可が拒否されました';

  @override
  String get offset => 'オフセット';

  @override
  String get audioserviceHasBeenDisposed => 'AudioServiceは破棄されました';

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
  String get kore => 'コレ';

  @override
  String get xmicrosoftoutputformatAudio24khz48k =>
      'X-Microsoft-OutputFormat\': \'audio-24khz-48kbitrate-mono-mp3';

  @override
  String get useragentHanzimasterapp => 'User-Agent\': \'HanziMasterApp';

  @override
  String get anchorWord => 'アンカーワード';

  @override
  String get creativeThematicTitle => '独創的なテーマタイトル';

  @override
  String get briefPedagogicalOrSemanticRationale => '簡潔な教育的または意味的根拠';

  @override
  String get theSingleMostCentralCharacterFromTh => 'リストの中で最も中心となる文字';

  @override
  String get aBalancedSetOfCharactersFromYourLib => 'あなたのライブラリからバランスの取れた文字セット';

  @override
  String get yourNaturalConversationalReplyInChi => '中国語の漢字による自然な会話の返答';

  @override
  String get theEnglishTranslationOfYourReply => 'あなたの返答の英語訳';

  @override
  String get thePinyinWithToneMarksForYourReply => 'あなたの返答の声調記号付きピンイン';

  @override
  String get aSuggestedResponseTheUserCouldSayBa => 'ユーザーが返答できる提案';

  @override
  String get pinyinForTheSuggestion => '提案のピンイン';

  @override
  String get englishTranslationForTheSuggestion => '提案の英語訳';

  @override
  String get scholarsCritique => '学者の批評';

  @override
  String get theEchoHallRemainsSilentTryYourBrea =>
      'エコーホールは沈黙したままです。もう一度息を試してください。';

  @override
  String get xtitleHanziMaster => 'X-Title\': \'Hanzi Master';

  @override
  String get noneYet => 'まだありません。';

  @override
  String get exactSentence => '正確な文：';

  @override
  String get englishTranslation => '英語訳';

  @override
  String get previouslyGeneratedPhrases => '以前に生成されたフレーズ';

  @override
  String get iLikeDrinkingAppleJuice => '私はリンゴジュースを飲むのが好きです。';

  @override
  String get theEnglishMeaningHere => 'ここでの英語の意味...';

  @override
  String get failedToFetchDefinition => '定義の取得に失敗しました。';

  @override
  String get failedToLoadExplanation => '説明の読み込みに失敗しました。';

  @override
  String get failedToLoadComparison => '比較の読み込みに失敗しました。';

  @override
  String get emptyResponseFromOpenrouter => 'OpenRouterからの空の応答';

  @override
  String get emptyResponseFromVisionModel => 'Visionモデルからの空の応答';

  @override
  String get standard => '標準';

  @override
  String get theFullSentenceInChinese => '中国語の全文...';

  @override
  String get theWordOrCharacterInChinese => '中国語の単語または文字';

  @override
  String get thePinyinForThisSpecificWord => 'この特定の単語のピンイン';

  @override
  String get emptyResponseFromDeepseekApi => 'DeepSeek APIからの空の応答';

  @override
  String get criticalPutTheEnglishTranslationInT => '重要：英語訳を以下に記述してください';

  @override
  String get englishTranslationOfTheEntireSenten => '文全体の英語訳';

  @override
  String get hanziWord => '漢字単語';

  @override
  String get theFullSimplifiedSentenceInChinese => '中国語の簡体字の全文...';

  @override
  String get lyingFlatACulturalMovement => '寝そべり族：文化運動...';

  @override
  String get theUserYouAreSpeakingToIsNamed => 'あなたが話しているユーザーの名前は';

  @override
  String get importantRuleDoNotAddressTheUserByA =>
      '重要ルール：ユーザーを名前で呼ばないでください。以下のようなプレースホルダー名も絶対に使用しないでください';

  @override
  String get youAreAConciseChineseCalligraphyAnd =>
      'あなたはモバイルフラッシュカードアプリ内の簡潔な中国書道・語源チューターです。';

  @override
  String get theStudentIsStudyingTheCharacter => '学生は文字を学習しています';

  @override
  String get neverWriteIntroductionsSignoffsOrFi =>
      '導入、結び、または「〜のような」といった埋め草のフレーズは決して書かないでください。';

  @override
  String get beDirectAndInformative => '直接的かつ情報を提供してください。';

  @override
  String get criticalRuleYouMustRespondEntirelyI =>
      '重要なルール：ISO 639-1コードに対応する言語で完全に回答してください。';

  @override
  String get youAreAConciseChineseGrammarTutorIn =>
      'あなたはモバイルアプリ内の簡潔な中国語文法チューターです。';

  @override
  String get theStudentIsConfusedAboutTheWord => '学生は「〜」という単語について混乱しています';

  @override
  String get neverWriteIntroductionsSignoffsOrFi1 =>
      '導入、結び、または埋め草のフレーズは決して書かないでください。';

  @override
  String get azureSpeechApiKeysAreMissing => 'Azure Speech APIキーが見つかりません。';

  @override
  String get success => '成功';

  @override
  String get granularity => '粒度';

  @override
  String get phoneme1 => '音素';

  @override
  String get dimension => '次元';

  @override
  String get comprehensive => '包括的';

  @override
  String get weCouldntHearYouClearlyPleaseTryAga => '音声が不明瞭でした。もう一度お試しください。';

  @override
  String get noNbestResultFound => 'NBest結果が見つかりませんでした。';

  @override
  String get words1 => '単語';

  @override
  String get word => '単語';

  @override
  String get phonemes => '音素';

  @override
  String get syllables => '音節';

  @override
  String get syllable => '音節';

  @override
  String get omission => '脱落';

  @override
  String get insertion => '挿入';

  @override
  String get youMissedThisWord => 'この単語が抜けています。';

  @override
  String get extraWordAddedHere => 'ここに余分な単語が追加されました。';

  @override
  String get mispronunciation => '誤発音';

  @override
  String get pronunciationWasInaccurate => '発音が不正確でした。';

  @override
  String get goodEffortKeepPracticing => 'よくできました！練習を続けてください。';

  @override
  String get perfectPronunciationSoundsLikeANati => '完璧な発音です！ネイティブスピーカーのようです。';

  @override
  String get greatJobAFewMinorToneInaccuracies =>
      '素晴らしい！いくつかの声調にわずかな不正確さがあります。';

  @override
  String get notBadButYourTonesNeedSomeWork => '悪くありませんが、声調の練習が必要です。';

  @override
  String get keepPracticingListenToTheNativeAudi =>
      '練習を続けてください！ネイティブの音声を聞いて、もう一度試してください。';

  @override
  String get lexical => '語彙的';

  @override
  String get chineseHanziHere => '中国語の漢字はこちら';

  @override
  String get aShortSummaryInEnglish => '英語での短い要約';

  @override
  String get noCoherentChineseTextFoundInTheScan =>
      'スキャンから意味のある中国語のテキストは見つかりませんでした。';

  @override
  String get theFullEnglishTranslationOfTheScann =>
      'スキャンされたテキストの完全な英語翻訳... または「意味のある中国語のテキストは見つかりませんでした。」';

  @override
  String get aShort24WordTitleForThisScanEgResta =>
      'このスキャンに2〜4語の短いタイトル（例：「レストランメニュー」、「道路標識」）';

  @override
  String get china => '中国';

  @override
  String get noTranslationAvailable => '翻訳はありません。';

  @override
  String get scanResults => 'スキャン結果';

  @override
  String get whenWasItWrittenAndWhatWasHappening => 'いつ書かれ、当時の中国では何が起こっていましたか？';

  @override
  String get whyIsThisPieceFamousWhatPhilosophic =>
      'この作品が有名なのはなぜですか？どのような哲学的または文化的テーマを探求していますか？';

  @override
  String get aBriefBioOfTheAuthor => '著者の略歴。';

  @override
  String get informationUnavailable => '情報はありません。';

  @override
  String get noSummaryAvailable => '要約はありません。';

  @override
  String get hanziAiPro => '漢字AIプロ';

  @override
  String get trialNormalIntro => 'トライアル、ノーマル、イントロ';

  @override
  String get dailyDrop => 'デイリードロップ';

  @override
  String get dailyNotificationsForWordOfTheDayAn => '今日の単語とニュースのデイリー通知';

  @override
  String get aNewWordAndStoryOfTheDayAreWaitingF =>
      '新しい今日の単語とストーリーがあなたを待っています！';

  @override
  String get spacedRepetition => '間隔反復';

  @override
  String get remindersForFlashcardsDueForReview => '復習期限のフラッシュカードのリマインダー';

  @override
  String get engagementReminders => 'エンゲージメントリマインダー';

  @override
  String get trialReminders => 'トライアルリマインダー';

  @override
  String get notificationsForYourTrialStatus => 'トライアルステータスの通知';

  @override
  String get comeReviewYourHanziAndTryALiveCallB =>
      '無料アクセスが終了する前に、漢字を復習し、ライブコールを試してみましょう！';

  @override
  String get scholarsEye => '学者の目';

  @override
  String get clMeasureWord => 'CL:、量詞:';

  @override
  String get surnameShi => '姓：史';

  @override
  String get chineseFamilyNameShi => '中国の姓（史）';

  @override
  String get neutralToneLight => '軽声（軽い）';

  @override
  String get keepYourPitchHighAndSteadyLikeSingi => '音符を歌うように、高くて安定したピッチを保ちます。';

  @override
  String get startInTheMiddleAndSlideYourPitchUp =>
      '中間から始めて、「何？」と尋ねるようにピッチを上げます。';

  @override
  String get dipYourVoiceDownLowThenRiseGentlyBa => '声を低く下げてから、ゆっくりと元に戻します。';

  @override
  String get dropYourPitchSharplyAndDecisivelyLi =>
      'きっぱりと「いいえ！」と言うように、ピッチを鋭く決定的に下げます。';

  @override
  String get pronounceSoftlyBrieflyAndWithoutEmp => '柔らかく、短く、強調せずに発音します。';

  @override
  String get spotOnPitchWasHighFlatAndSteady => '完璧です！ピッチは高く、平坦で、安定していました。';

  @override
  String get spotOnUpwardPitchRiseWasClear => '完璧です！上昇するピッチは明確でした。';

  @override
  String get spotOnLowDippingCurveWasAccurate => '完璧です！低い下降曲線は正確でした。';

  @override
  String get spotOnSharpFallingDropWasDecisive => '完璧です！鋭い落としが決め手でした。';

  @override
  String get spotOnToneWasPronouncedAccurately => '完璧です！声調が正確に発音されました。';

  @override
  String get iAgreeToTheTermsOfServiceAndPrivacy => '利用規約とプライバシーポリシーに同意します。';

  @override
  String get sendMeOccasionalUpdatesTipsAndOffer => '最新情報、ヒント、お得な情報を時々受け取る。';

  @override
  String get signInToSyncYourProgress => '進行状況を同期するためにサインインしてください。';

  @override
  String get createAnAccountToSaveYourStats => '統計を保存するためにアカウントを作成してください。';

  @override
  String get smartSpiral => 'スマートスパイラル';

  @override
  String get origin => '起源';

  @override
  String get elements => '要素';

  @override
  String get humanity => '人間性';

  @override
  String get village => '村';

  @override
  String get journey => '旅';

  @override
  String get city => '都市';

  @override
  String get originTheSimplestShapesTheBeginning => '起源：最も単純な形。万物の始まり。';

  @override
  String get elementsSunMoonWaterAndFireTheNatur => '要素：太陽、月、水、そして火。自然の世界。';

  @override
  String get humanityTheBodyTheHeartAndTheFamily => '人間性：体、心、そして家族。';

  @override
  String get villageFieldsRoofsAndToolsTheFounda => '村：畑、屋根、そして道具。社会の基盤。';

  @override
  String get journeyMovementSpeechAndSustenance => '旅：動き、言葉、そして糧。';

  @override
  String get cityCommerceClothingAndComplexArtif => '都市：商業、衣服、そして複雑な人工物。';

  @override
  String get equilibriumAlgorithm => '平衡アルゴリズム';

  @override
  String get misc => 'その他';

  @override
  String get cityOrOriginAs => '「都市」または「起源」として';

  @override
  String get miscToOrigin => '「その他」から「起源」へ';

  @override
  String get constellation => '星座';

  @override
  String get whichOneIsWater => '「水」はどれですか？';

  @override
  String get whatIsThePinyin => 'ピンインは何ですか？';

  @override
  String get nature => '自然';

  @override
  String get whatEssenceDoes => 'どのような本質が';

  @override
  String get allTiers => '全てのティア';

  @override
  String get active => 'アクティブ';

  @override
  String get theScrollOfOrigin1 => '起源の巻物';

  @override
  String get galaxyOf1 => 'ギャラクシー・オブ';

  @override
  String get also => 'また';

  @override
  String get work => '仕事';

  @override
  String get cloud => '雲';

  @override
  String get youArchaic => '汝';

  @override
  String get suddenly => '突然';

  @override
  String get owner => '所有者';

  @override
  String get door => '門';

  @override
  String get occupy => '占める';

  @override
  String get nail => '釘';

  @override
  String get and => 'と';

  @override
  String get buddhistNun => '尼僧';

  @override
  String get anxious => '不安な';

  @override
  String get sprout => '芽';

  @override
  String get exchange => '交換';

  @override
  String get sheep => '羊';

  @override
  String get strange => '奇妙な';

  @override
  String get opposite => '反対';

  @override
  String get shorttailedBird => '短尾の鳥';

  @override
  String get shoot => '射る';

  @override
  String get small => '小さい';

  @override
  String get gather => '集める';

  @override
  String get order => '順序';

  @override
  String get flat => '平らな';

  @override
  String get thePersonWho => '～する人';

  @override
  String get nobleman => '貴族';

  @override
  String get cause => '原因';

  @override
  String get pig => '豚';

  @override
  String get bright => '明るい';

  @override
  String get slowly => 'ゆっくりと';

  @override
  String get give => '与える';

  @override
  String get arrow => '矢';

  @override
  String get dry => '乾燥';

  @override
  String get obstacle => '障害';

  @override
  String get beg => '懇願する';

  @override
  String get window => '窓';

  @override
  String get fear => '恐れ';

  @override
  String get drum => '太鼓';

  @override
  String get why => 'なぜ';

  @override
  String get talent => '才能';

  @override
  String get follow => 'フォロー';

  @override
  String get desert => '砂漠';

  @override
  String get component => '要素';

  @override
  String get divingInto1 => '深掘り';

  @override
  String get unitIntro1 => 'ユニット紹介';

  @override
  String get theBlueprint => '青写真';

  @override
  String get theOrigin => '起源';

  @override
  String get theGalaxy => '銀河';

  @override
  String get theScholarListens => '学者が耳を傾ける...';

  @override
  String get consultingTheScrolls => '巻物を紐解く...';

  @override
  String get traceWithTheGuide => 'ガイドと共に辿る';

  @override
  String get traceTheGhost => '幽霊を辿る';

  @override
  String get connectTheDots => '点と点を結ぶ';

  @override
  String get drawFromMemory => '記憶から描く';

  @override
  String get assistant => 'アシスタント';

  @override
  String get puck => 'パック';

  @override
  String get helloWelcomeWhatWouldYouLikeToOrder =>
      'こんにちは！いらっしゃいませ。ご注文は何になさいますか？';

  @override
  String get ni3Hao3Huan1ying2Guang1lin2Qing3wen =>
      'Ni3 hao3! Huan1ying2 guang1lin2. Qing3wen4 ni3 yao4 dian3 shen2me?';

  @override
  String get waiterLi => 'ウェイターの李さん';

  @override
  String get askForTheMenu => 'メニューをお願いする';

  @override
  String get orderOneDishAndOneDrink => '料理を一品と飲み物を一つ注文する';

  @override
  String get askForTheBill => 'お会計をお願いする';

  @override
  String get fenrir => 'フェンリル';

  @override
  String get ni3Qu4Na3rAJi1chang3MaTing3Yuan3De =>
      'Ni3 qu4 na3r a? Ji1chang3 ma? Ting3 yuan3 de!';

  @override
  String get driverWang => '王運転手';

  @override
  String get tellTheDriverYouAreGoingToTheAirpor => '運転手に空港へ行くことを伝える';

  @override
  String get askHowLongTheTripWillTake => '所要時間を尋ねる';

  @override
  String get complainAboutTheTraffic => '交通渋滞について不平を言う';

  @override
  String get charon => 'カロン';

  @override
  String get thisClothingQualityIsEspeciallyGood => 'この服の品質は特に良いです、たった200元です。';

  @override
  String get zhe4Jian4Yi1fuZhi4liang4Te4bie2Hao3 =>
      'Zhe4 jian4 yi1fu zhi4liang4 te4bie2 hao3, zhi3yao4 liang3 bai3 kuai4.';

  @override
  String get auntieChen => '陳おばさん';

  @override
  String get askHowMuchTheSilkShirtCosts => 'シルクのシャツがいくらか尋ねる';

  @override
  String get sayItIsTooExpensive => '高すぎると言う';

  @override
  String get bargainThePriceDownTo100Rmb => '値段を100元まで値切る';

  @override
  String get ni3Na3li3Bu4Shu1fuFa1shao1LeMa =>
      'Ni3 na3li3 bu4 shu1fu? Fa1shao1 le ma?';

  @override
  String get drZhang => '張先生';

  @override
  String get explainYouHaveHadAHeadacheForTwoDay => '二日間頭痛が続いていると説明する';

  @override
  String get sayYouHaveASlightFever => '微熱があると伝える';

  @override
  String get askIfYouNeedToTakeMedicine => '薬を飲む必要があるか尋ねる';

  @override
  String get aoede => 'アオエデ';

  @override
  String get heyLongTimeNoSeeHowHaveYouBeenLatel => 'やあ！久しぶり、最近どうしてる？';

  @override
  String get ni3Hao3Hao3jiu3Bu4jian4Ni3Zui4jin4Z =>
      'Ni3 hao3! Hao3jiu3 bu4jian4, ni3 zui4jin4 zen3me yang4?';

  @override
  String get pleaseIntroduceYourselfWhyDoYouWant =>
      '自己紹介をお願いします。なぜ弊社で働きたいのですか？';

  @override
  String get qing3Xian1Zi4wo3Jie4shao4Yi1xia4Ni3 =>
      'Qing3 xian1 zi4wo3 jie4shao4 yi1xia4. Ni3 wei4shen2me xiang3 lai2 wo3men gong1si1 gong1zuo4?';

  @override
  String get managerLiu => '劉部長';

  @override
  String get introduceYourProfessionalBackground => '職務経歴を簡潔に説明する';

  @override
  String get explainWhyYouWantToWorkAtThisCompan => 'この会社で働きたい理由を説明する';

  @override
  String get askAPoliteQuestionAboutTheCompanyCu => '企業文化について丁寧に質問する';

  @override
  String get microphoneAccessIsRequiredPleaseEna =>
      'マイクへのアクセスが必要です。デバイスの設定で有効にしてください。';

  @override
  String get couldNotStartMicrophonePleaseCheckY =>
      'マイクを開始できませんでした。オーディオ設定を確認して、もう一度お試しください。';

  @override
  String get weDidntQuiteCatchThatPleaseHoldTheM =>
      '聞き取れませんでした。マイクを近づけてもう一度お試しください！';

  @override
  String get recordingWasTooShortHoldTheMicAndSp =>
      '録音が短すぎました。マイクを近づけてはっきりと話してください。';

  @override
  String get audioBufferWasEmptyPleaseCheckYourM =>
      'オーディオバッファが空でした。マイクを確認して、もう一度お試しください。';

  @override
  String get audioFileIsSilentPleaseSpeakIntoThe =>
      '音声ファイルが無音です。マイクに向かって話してください。';

  @override
  String get weCouldntUnderstandYourPronunciatio =>
      '発音を理解できませんでした。はっきりと話して、もう一度お試しください。';

  @override
  String get theServerIsTakingTooLongToRespondPl =>
      'サーバーの応答に時間がかかりすぎています。もう一度お試しください。';

  @override
  String get noInternetConnectionPleaseCheckYour =>
      'インターネット接続がありません。ネットワークを確認して、もう一度お試しください。';

  @override
  String get audioProcessingFailedPleaseTryAgain => '音声処理に失敗しました。もう一度お試しください。';

  @override
  String get permission => '許可';

  @override
  String get couldNotProcessYourRecordingPleaseT =>
      '録音を処理できませんでした。もう一度お試しください。';

  @override
  String get user => 'ユーザー';

  @override
  String get scholar => '学者';

  @override
  String get ourAiTutorsAreCurrentlyOfflinePleas =>
      'AIチューターは現在オフラインです。後でもう一度お試しください。';

  @override
  String get hideTranslation => '翻訳を非表示';

  @override
  String get azureAssessment => 'Azure評価中...';

  @override
  String get microphonePermissionRequired => 'マイクの許可が必要です';

  @override
  String get connectedSpeakNow => '接続しました！今すぐ話してください。';

  @override
  String get initializationErrorCheckPermissions => '初期化エラー。許可を確認してください。';

  @override
  String get microphoneErrorTapToRetry => 'マイクエラーです。タップして再試行してください。';

  @override
  String get theTutorReturnedAnEmptyResponse => 'チューターから空の応答が返されました。';

  @override
  String get connectionInterruptedPleaseSpeakAga => '接続が中断されました。もう一度お話しください。';

  @override
  String get callPausedReviewingTones => '通話一時停止中 (声調を確認中)';

  @override
  String get pausedTakeABreak => '一時停止中 - 休憩しましょう';

  @override
  String get goodStartPracticing => '良い練習の始まりです';

  @override
  String get studentCoach => '生徒 : コーチ';

  @override
  String get keepYour1stToneHighAndSteadyOn => '第1声は高く安定させてください。';

  @override
  String get noScenariosFound => 'シナリオが見つかりません。';

  @override
  String get designYourOwnAiRoleplayExperience => '自分だけのAIロールプレイ体験をデザイン';

  @override
  String get generateFromDeck => 'デッキから生成';

  @override
  String get practiceFlashcardVocabularyInALiveD => 'ライブ対話でフラッシュカードの語彙を練習';

  @override
  String get tapToRoleplay => 'タップしてロールプレイ';

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
  String get dinnerWithDad => 'お父さんとの夕食';

  @override
  String get orderingAtAChengduTeahouse => '成都の茶館で注文';

  @override
  String get buyingTeaAtTheMarket => '市場でお茶を買う';

  @override
  String get meetingAnOldClassmate => '旧友との再会';

  @override
  String get readyToPractice => '練習の準備はできましたか？';

  @override
  String get letsPracticeChinese => '中国語を練習しましょう';

  @override
  String get areYouReady => '準備はいいですか？';

  @override
  String get discussWhatToHaveForDinner => '夕食に何を食べるか話し合う';

  @override
  String get suggestWatchingAMovieAfterwards => 'その後、映画を見ることを提案する';

  @override
  String get askIfTheyWouldLikeTea => 'お茶はいかがですかと尋ねる';

  @override
  String get helloVeryNiceToMeetYou => 'こんにちは！お会いできて嬉しいです。';

  @override
  String get deckPractice => 'デッキ練習';

  @override
  String get practiceVocabularyWithAnAiPartner => 'AIパートナーと語彙を練習。';

  @override
  String get designCustomAiRoleplayConversation => 'カスタムAIロールプレイ＆会話をデザイン';

  @override
  String get random => 'ランダム';

  @override
  String get scenarioTopic => 'シナリオのトピック';

  @override
  String get contextSettingOptional => '状況と設定（任意）';

  @override
  String get aiCharacterPersonaOptional => 'AIキャラクター／ペルソナ（任意）';

  @override
  String get aQuietBambooCourtyardTeahouseInChen =>
      '成都の静かな竹林の中庭にある茶館。優しい古筝の音楽が流れる。';

  @override
  String get aBustlingSmokyNightMarketFilledWith =>
      '串焼き、肉まん、屋台料理で賑わう、煙が立ち込める活気ある夜市。';

  @override
  String get aLivelyHotpotRestaurantInChongqingW =>
      '沸騰する深紅のスープと香ばしい唐辛子の香りが漂う、重慶の活気ある火鍋レストラン。';

  @override
  String get aBustlingTraditionalCantoneseTeahou =>
      '蒸し器の竹籠が並ぶ、広州の賑やかな伝統的な広東茶館。';

  @override
  String get aChicMinimalistCafeInTheFrenchConce =>
      '雨の降る日曜の午後、フランス租界にあるシックでミニマリストなカフェ。';

  @override
  String get aWarmNorthernHomeKitchenDuringWinte =>
      '冬の北部の温かい家庭のキッチン。テーブルには小麦粉、蒸し餃子の鍋からは湯気が立つ。';

  @override
  String get anOpenairNightStreetFoodAlleyWithSi =>
      '羊肉の串焼きがジュージューと音を立て、焼きナスと冷たいビールが楽しめる屋外の夜の屋台街。';

  @override
  String get aSnowyStreetCornerOutsideTheLamaTem =>
      'ラマ寺院の外の雪降る街角。氷の上に真っ赤に輝くサンザシ飴の串が並ぶ。';

  @override
  String get craftBeerBreweryInQingdao => '青島のクラフトビール醸造所';

  @override
  String get aLivelyCoastalTaproomWithWoodenBarr =>
      '木樽、潮風、そして新鮮な小麦ビールのタップが並ぶ活気ある海岸沿いのタップルーム。';

  @override
  String get sichuanCookingMasterclass => '四川料理マスタークラス';

  @override
  String get aVibrantOpenKitchenWithWoksBlazingC =>
      '鍋が炎を上げ、ラー油が煮立ち、新鮮な花椒が香る活気あるオープンキッチン。';

  @override
  String get highspeedRailSeatMixup => '高速鉄道の座席間違い';

  @override
  String get greatWallSunriseTrekInMutianyu => '慕田峪長城での日の出トレッキング';

  @override
  String get theAncientStoneRampartsOfTheGreatWa =>
      '霧深い緑の山々に囲まれた、夜明けの長城の古代の石の城壁。';

  @override
  String get bambooRaftDriftOnGuilinLiRiver => '桂林漓江での竹筏下り';

  @override
  String get glidingAlongEmeraldKarstWatersBetwe =>
      '陽朔近くの劇的な霧深い石灰岩の峰々の間を、エメラルド色のカルスト水域を滑るように進む。';

  @override
  String get silkRoadCamelTrekInDunhuang => '敦煌でのシルクロードラクダトレッキング';

  @override
  String get theRollingGoldenSandDunesOfMingshaM =>
      '月牙泉オアシスの隣に広がる、鳴沙山のうねるような黄金の砂丘。';

  @override
  String get bookingACourtyardHomestayInDali => '大理での中庭ホームステイ予約';

  @override
  String get aSereneBaistyleBoutiqueCourtyardHot =>
      '雲南省の洱海を見下ろす、静かな白族様式のブティック中庭ホテル。';

  @override
  String get potalaPalacePilgrimageInLhasa => 'ラサのポタラ宮巡礼';

  @override
  String get theMajesticSundrenchedStoneStepsOut =>
      'ポタラ宮の外にある、陽光降り注ぐ壮大な石段と回転するマニ車。';

  @override
  String get aSubzeroWonderlandOfIlluminatedCrys =>
      '氷点下のワンダーランド。ライトアップされたクリスタルの氷の宮殿とそびえ立つ雪像。';

  @override
  String get zhangjiajieAvatarMountainCableCar => '張家界アバター山ケーブルカー';

  @override
  String get suspendedHighInAGlassCableCarSoarin =>
      '数千もの砂岩の柱峰の上を舞う、ガラス張りのケーブルカーに高く吊るされて。';

  @override
  String get gobiDesertStargazingCampInGansu => '甘粛省ゴビ砂漠の星空観察キャンプ';

  @override
  String get aLuxuryYurtCampUnderACrystalclearMi =>
      '嘉峪関郊外の砂漠で、澄み切った天の川の空の下にある豪華なゲルキャンプ。';

  @override
  String get yangtzeRiverThreeGorgesCruise => '長江三峡クルーズ';

  @override
  String get onTheSunDeckOfARiverCruiseShipPassi =>
      '雄大な瞿塘峡を通過するリバークルーズ船のサンデッキにて。';

  @override
  String get buyingAntiquesInBeijingPanjiayuan => '北京潘家園で骨董品を買う';

  @override
  String get aHistoricPotteryKilnFilledWithDelic =>
      '繊細な素焼きの磁器の花瓶とコバルトブルーの釉薬で満たされた歴史ある陶器窯。';

  @override
  String get suzhouSilkEmbroideryStudio => '蘇州シルク刺繍工房';

  @override
  String get aPeacefulCanalsideGardenStudioInSuz =>
      '蘇州の運河沿いにある静かな庭園スタジオ。上質な絹糸と木製の刺繍枠が並ぶ。';

  @override
  String get backstageAtATraditionalBeijingOpera =>
      '伝統的な京劇劇場の舞台裏。色鮮やかな衣装、鏡、頭飾りが並ぶ。';

  @override
  String get traditionalChineseMedicineConsultat => '漢方診察';

  @override
  String get morningTaiChiInTempleOfHeavenPark => '天壇公園での朝の太極拳';

  @override
  String get beneathAncientCypressTreesAtDawnWit =>
      '夜明けの古木の下、鳥がさえずる中、高齢者たちが揃って太極拳をする。';

  @override
  String get rentingAHanfuForAPhotoShoot => '漢服レンタル（写真撮影用）';

  @override
  String get aTraditionalCostumeBoutiqueNearTheW =>
      '西湖近くの伝統衣装ブティック。唐・宋時代のローブが並ぶ。';

  @override
  String get guqinAncientZitherInstrumentWorksho => '古琴ワークショップ';

  @override
  String get aQuietPinewoodStudioInHangzhouFille =>
      '杭州の静かな松材スタジオ。古びた桐材と絹弦の楽器が並ぶ。';

  @override
  String get shaanxiShadowPuppetTheater => '陝西影絵芝居';

  @override
  String get behindAnIlluminatedWhiteSilkScreenW =>
      '光る白い絹のスクリーンの後ろで、繊細な半透明の革製影絵人形が動く。';

  @override
  String get chineseCalligraphyWorkshop => '中国書道ワークショップ';

  @override
  String get aTranquilStudioScentedWithPineSootI =>
      '松煙墨、和紙の巻物、ほのかなお茶の香りが漂う静かなスタジオ。';

  @override
  String get adoptingACatAtAnAnimalShelter => '動物保護施設で猫を飼う';

  @override
  String get aCozyPetRescueCenterInHangzhouWithE =>
      '杭州の居心地の良い保護センター。元気な子猫と訪問者向けのお茶がある。';

  @override
  String get scriptMurderMysteryJubenshaGame => 'スクリプト殺人ミステリー（ジュベンシャ）';

  @override
  String get aThemedDetectiveLoungeInShanghaiWit =>
      '上海のテーマ探偵ラウンジ。コスチュームのプレイヤーとキャンドルライト。';

  @override
  String get vintageVinylRecordShopInShanghai => '上海のヴィンテージレコード店';

  @override
  String get aHiddenVinylStoreInAnOldLaneHousePa =>
      '古い路地裏の隠れたレコード店。80年代の広東ポップとジャズのクラシックレコードがぎっしり。';

  @override
  String get ktvKaraokePartyWithFriends => '友達とのKTVカラオケパーティー';

  @override
  String get joiningACityBikeCyclingClub => 'シティバイクサイクリングクラブに参加';

  @override
  String get aGatheringOfCyclistsByTheRiverfront =>
      '川沿いに集まったサイクリストたち。街のスカイラインを巡る夜のライドに備える。';

  @override
  String get blindBoxToyTradingMeetup => 'ブラインドボックスおもちゃ交換会';

  @override
  String get aColorfulPopcultureToyStoreInChaoya =>
      '朝陽のカラフルなポップカルチャーおもちゃ屋。ディスプレイ棚と未開封のコレクターズボックスが並ぶ。';

  @override
  String get droneSkylineVideographyAtTheBund => '外灘でのドローンによるスカイライン撮影';

  @override
  String get theBundPromenadeAtDuskOverlookingTh =>
      '夕暮れ時の外灘プロムナード。未来的な光り輝く浦東の超高層ビル群を見下ろす。';

  @override
  String get goldenRetrieverCafeInNanjing => '南京のゴールデンレトリバーカフェ';

  @override
  String get aSunnyCheerfulPetCafeWithDozensOfFr =>
      '陽気で明るいペットカフェ。何十匹もの人懐っこいふわふわの犬たちが訪問者を迎える。';

  @override
  String get boulderingClimbingGymInChengdu => '成都のボルダリングジム';

  @override
  String get aModernIndoorClimbingGymWithVibrant =>
      '鮮やかな色のホールドルートとエネルギッシュな音楽が流れるモダンな屋内クライミングジム。';

  @override
  String get aMassiveConventionHallFilledWithCol =>
      'カラフルなゲームブース、フォトウォール、コスチュームのクリエイターでいっぱいの巨大なコンベンションホール。';

  @override
  String get askingForDirectionsInABeijingHutong => '北京の胡同で道を聞く';

  @override
  String get aMazeOfHistoricGreybrickAlleysWithB =>
      '自転車、中庭、ザクロの木がある歴史的な灰色のレンガの路地の迷路。';

  @override
  String get buyingFreshFruitAtAWetMarket => '露店市場で新鮮な果物を買う';

  @override
  String get aLivelyMorningNeighborhoodMarketWit =>
      '新鮮なライチ、マンゴー、ドラゴンフルーツが山積みにされた活気ある朝の近所の市場。';

  @override
  String get flowerMarketBouquetInKunming => '昆明の花市場のブーケ';

  @override
  String get theFamousDounanFlowerMarketSurround =>
      '何千もの新鮮なバラ、ユリ、ユーカリの茎に囲まれた有名な斗南花市場。';

  @override
  String get tailorAlterationsInAnOldLaneHouse => '古い路地裏の家での仕立て直し';

  @override
  String get aTraditionalTailorShopFilledWithSew =>
      'ミシン、生地、メジャーでいっぱいの伝統的な仕立て屋。';

  @override
  String get expressParcelLockerRetrieval => '宅配ロッカーからの荷物受け取り';

  @override
  String get downstairsAtAResidentialApartmentGa =>
      '住宅アパートのゲート階下。スマートなHiveボックスロッカーシステムの隣。';

  @override
  String get bicycleFlatTireRepairAtCampusGate => '大学の門での自転車のパンク修理';

  @override
  String get aSmallOutdoorRoadsideToolkitStandUn =>
      '大きな葉の茂ったガジュマルの木の下にある小さな屋外の修理スタンド。';

  @override
  String get techCompanyProductDemo => 'テック企業の製品デモ';

  @override
  String get aFuturisticTechConferenceBoothInShe =>
      '最先端のAIハードウェアを展示する深圳の未来的なテックカンファレンスブース。';

  @override
  String get ecommerceLivestreamStudio => 'Eコマースライブストリームスタジオ';

  @override
  String get aHighenergyBroadcastStudioWithRingL =>
      'リングライト、製品ディスプレイラック、ライブコメントモニターを備えた高エネルギーの放送スタジオ。';

  @override
  String get yiwuInternationalTradeMarket => '義烏国際貿易市場';

  @override
  String get aVastMultistoryCommercialExhibition =>
      '何百万もの卸売品や工芸品でいっぱいの広大な多層商業展示モール。';

  @override
  String get universityCampusExchangeProgram => '大学キャンパス交換プログラム';

  @override
  String get aSunnyLawnOutsideTheUniversityLibra =>
      '大学図書館の外にある日当たりの良い芝生。学生たちが勉強したり、ミルクティーを飲んだりしている。';

  @override
  String get pleaseEnterAScenarioTopic => 'シナリオのトピックを入力してください。';

  @override
  String get nameTitle => '名前（タイトル）';

  @override
  String get aiCharacter => 'AIキャラクター';

  @override
  String get helloWelcomeHereWhatShallWeChatAbou => 'こんにちは！ようこそ。今日は何を話しましょうか？';

  @override
  String get greetYourConversationPartner => '会話相手に挨拶する';

  @override
  String get askAQuestionInChinese => '中国語で質問する';

  @override
  String get pinyinWithToneMarks => '声調記号付きピンイン';

  @override
  String get goal1InEnglish => '目標1（英語）';

  @override
  String get goal2InEnglish => '目標2（英語）';

  @override
  String get goal3InEnglish => '目標3（英語）';

  @override
  String get beginner => '初級';

  @override
  String get hsk12 => 'HSK 1-2';

  @override
  String get hsk34 => 'HSK 3-4';

  @override
  String get hsk56 => 'HSK 5-6';

  @override
  String get master => '上級';

  @override
  String get azurePronunciationAssessment => 'AZURE 発音評価';

  @override
  String get tapToReview => 'タップしてレビュー';

  @override
  String get overallScore => '総合スコア';

  @override
  String get toneAccuracy => '声調の正確さ';

  @override
  String get fluency => '流暢さ';

  @override
  String get report => '報告';

  @override
  String get goodPronunciationButCanBeBetter => '発音は良好ですが、改善の余地があります。';

  @override
  String get didYouMeanToSay => '...という意味でしたか？';

  @override
  String get greatKeepTrying => '素晴らしい！\' : \'続けて頑張りましょう！';

  @override
  String get completeness => '完了度';

  @override
  String get targetTone => '目標声調';

  @override
  String get k4toneComparisonTapToListen => '4声調比較（タップして聞く）：';

  @override
  String get youSpokeMatch => 'あなたの発音（一致！）';

  @override
  String get youSpoke => 'あなたの発音';

  @override
  String get yourPrimaryCollectionOfCharacters => 'あなたの主要な漢字集。';

  @override
  String get deckNotFound => 'デッキが見つかりません';

  @override
  String get cannotDeleteTheDefaultDeck => 'デフォルトデッキは削除できません';

  @override
  String get hsk4UpperIntermediate1 => 'HSK 4：中上級';

  @override
  String get theFirst150CharactersToStartYourJou => '学習を始めるための最初の150字。';

  @override
  String get buildYourVocabularyTo300EssentialWo => '300の必須単語で語彙を構築しましょう。';

  @override
  String get masterConversationalFluencyWith600W => '600語で会話の流暢さを習得しましょう。';

  @override
  String get readTextsAndConverseFluentlyWith120 => '1200語で文章を読み、流暢に会話しましょう。';

  @override
  String get readNewspapersAndWatchMoviesWith250 => '2500語で新聞を読み、映画を鑑賞しましょう。';

  @override
  String get databaseBoxNotOpen => 'データベースボックスが開いていません';

  @override
  String get hsk1DataFileIsEmpty => 'HSK1データファイルが空です';

  @override
  String get gold => 'ゴールド';

  @override
  String get globalDictionaryNotInitialized => 'グローバル辞書が初期化されていません';

  @override
  String get reading => '読解';

  @override
  String get recall => '想起';

  @override
  String get speaking => 'スピーキング';

  @override
  String get listening1 => 'リスニング';

  @override
  String get practiceStrokeOrderWithVisualGuides => '視覚的なガイドで筆順を練習しましょう。';

  @override
  String get seeTheCharacterRecallThePinyinAndMe => '漢字を見て、ピンインと意味を思い出しましょう。';

  @override
  String get seeTheMeaningDrawTheCharacterFromMe => '意味を見て、記憶から漢字を書きましょう。';

  @override
  String get readOutLoudToTestYourPronunciationT => '声に出して読み、発音の音調をテストしましょう。';

  @override
  String get listenToTheAudioAndIdentifyTheChara => '音声を聞いて、漢字を特定しましょう。';

  @override
  String get contract => '契約';

  @override
  String get whoeverImplementsMeMustBeAbleToDoTh =>
      'これを実装する者は、これらのことを実行できなければなりません。';

  @override
  String get koreFenrirCharonAoedePuckOrLocal =>
      'Kore\'、\'Fenrir\'、\'Charon\'、\'Aoede\'、\'Puck\'、または\'local\'';

  @override
  String get manageDecks => 'デッキを管理';

  @override
  String get weRanIntoTroubleLoadingTheLibraryPl =>
      'ライブラリの読み込み中に問題が発生しました。もう一度お試しください。';

  @override
  String get noCharactersInLexicon1 => '辞書に漢字がありません';

  @override
  String get masterTheBuildingBlocks => '基礎を習得しましょう';

  @override
  String get other => 'その他';

  @override
  String get required => '必須';

  @override
  String get library1 => 'ライブラリ';

  @override
  String get youAreAPremiumMember => 'あなたはプレミアム会員です';

  @override
  String get createAccountToSyncProgress => '進捗を同期するためにアカウントを作成';

  @override
  String get signOut => 'サインアウト';

  @override
  String get account => 'アカウント';

  @override
  String get guestScholar => 'ゲスト学者';

  @override
  String get localAccount => 'ローカルアカウント';

  @override
  String get unknownRadical => '不明な部首';

  @override
  String get followTheGuideStroke => 'ガイドの筆順に従う';

  @override
  String get strokeAnimationSpeed => '筆順アニメーション速度';

  @override
  String get notifications => '通知';

  @override
  String get deutsch => 'ドイツ語';

  @override
  String get bahasaIndonesia => 'インドネシア語';

  @override
  String get italiano => 'イタリア語';

  @override
  String get today1d2d3d4d5d6d =>
      '今日\'、\'1日\'、\'2日\'、\'3日\'、\'4日\'、\'5日\'、\'6日';

  @override
  String get targetDeck => '対象デッキ';

  @override
  String get mixed => 'ミックス';

  @override
  String get topicForContext => 'トピック（文脈用）';

  @override
  String get nounsOnly => '名詞のみ';

  @override
  String get verbsOnly => '動詞のみ';

  @override
  String get idiomsChengyu => '慣用句（成語）';

  @override
  String get fullSentences => '全文';

  @override
  String get beginnerHsk12 => '初心者（HSK 1-2）';

  @override
  String get intermediateHsk34 => '中級（HSK 3-4）';

  @override
  String get advancedHsk56 => '上級（HSK 5-6）';

  @override
  String get generatedByAi => 'AIが生成';

  @override
  String get canYouGiveMeTwoMoreExamplesUsingThi =>
      'この単語を使った例文をあと2つ教えていただけますか？';

  @override
  String get whatAreSomeSimilarWordsAndHowDoThey =>
      '似たような単語にはどのようなものがあり、それらはどう違いますか？';

  @override
  String get isThisWordUsedInSpokenOrWrittenChin =>
      'この単語は、話し言葉と書き言葉のどちらでより多く使われますか？';

  @override
  String get areThereOtherWaysToTranslateThisWor => 'この単語を他に翻訳する方法はありますか？';

  @override
  String get whatAreCommonWordsThatGoTogetherWit => 'この単語と一緒によく使われる単語は何ですか？';

  @override
  String get whatAreCommonMistakesLearnersMakeWi => 'この単語で学習者がよくする間違いは何ですか？';

  @override
  String get emptyResponse => '応答なし';

  @override
  String get whatIsTheOracleBoneScriptOriginOfTh => 'この漢字の甲骨文字の起源は何ですか？';

  @override
  String get howDidTheAncientFormOfThisCharacter =>
      'この漢字の古代の形は時間とともにどのように進化しましたか？';

  @override
  String get giveMe3CommonWordsThatContainThisCh => 'この漢字を含む一般的な単語を3つ教えてください。';

  @override
  String get whatOtherCharactersShareTheSameRadi => '同じ部首を持つ他の漢字は何ですか？';

  @override
  String get isThereAChineseProverbOrSayingFeatu => 'この漢字を使った中国のことわざや格言はありますか？';

  @override
  String get explainTheStrokeOrderRulesForThisCh => 'この漢字の筆順の規則を説明してください。';

  @override
  String get giveMeOneCalligraphyTipForWritingTh =>
      'この漢字を美しく書くための書道のヒントを1つ教えてください。';

  @override
  String get isThereAnythingTrickyAboutUsingThis => 'これを文法的に使う上で何か難しい点はありますか？';

  @override
  String get whatWordsAreCommonlyConfusedWithThi =>
      'この単語とよく混同される単語は何ですか、そしてそれはなぜですか？';

  @override
  String get doesThisCharacterCarryCulturalSymbo => 'この漢字は中国で文化的な象徴性を持っていますか？';

  @override
  String get isThisCharacterCommonlySeenInChines => 'この漢字は中国の映画、歌、文章でよく見られますか？';

  @override
  String get whatDoesTheRadicalOfThisCharacterMe => 'この漢字の部首は何を意味しますか？';

  @override
  String get breakDownEveryComponentAndItsMeanin => 'すべての構成要素とその意味を分解してください。';

  @override
  String get giveMeATrickToRememberTheCorrectTon =>
      'この漢字の正しい声調を覚えるためのコツを教えてください。';

  @override
  String get areThereCommonHomophonesThatAreOfte => 'これとよく混同される同音異義語はありますか？';

  @override
  String get quotaExceeded => '割り当てを超過しました';

  @override
  String get mustProvideEitherCardOrCards => 'カードまたは複数のカードを指定してください';

  @override
  String get deckSettings => 'デッキ設定';

  @override
  String get saveSettings => '設定を保存';

  @override
  String get sealRed => '朱色';

  @override
  String get sealScript => '篆書体';

  @override
  String get startYourStreak => '連続記録を開始';

  @override
  String get traditionalCharacter => '繁体字';

  @override
  String get inQueue => '待機中';

  @override
  String get tapToListenAgain => 'タップしてもう一度聞く';

  @override
  String get contextClue => '文脈の手がかり';

  @override
  String get microphonePermissionRequired1 => 'マイクの許可が必要です。';

  @override
  String get recordingFailedNoFile => '録音に失敗しました（ファイルなし）。';

  @override
  String get holdToSpeakOptional => '長押しして話す（任意）';

  @override
  String get microphonePermissionDeniedEnableItI =>
      'マイクの許可が拒否されました。シャドーイングスタジオを使用するには、設定で有効にしてください。';

  @override
  String get sessionSummary => 'セッション概要';

  @override
  String get hereAreTheCharactersYouStruggledWit => 'あなたが苦戦した漢字は以下の通りです。';

  @override
  String get applySessionGradesToSpacedRepetitio =>
      'セッションの評価を間隔反復学習（スピーキングモード）に適用する';

  @override
  String get masterYourMandarinPronunciationnbyM =>
      'ネイティブの発音を真似て、\\n中国語の発音をマスターしましょう。';

  @override
  String get aiIsGradingYourPronunciation => 'AIがあなたの発音を採点しています...';

  @override
  String get holdMicToRecordReleaseToGrade => 'マイクを長押しして録音。離して採点。';

  @override
  String get tapAnySyllableToAuditionAll4Tones =>
      'いずれかの音節をタップして、4つの声調すべてを試聴してください。';

  @override
  String get freeFlowConversationalPractice => '自由形式の会話練習';

  @override
  String get failedToGeneratePhrasePleaseTryAgai =>
      'フレーズの生成に失敗しました。もう一度お試しください。';

  @override
  String get recordingTooShortHoldTheMicButtonLo =>
      '録音が短すぎます。マイクボタンを長く押してください。';

  @override
  String get recordingErrorPleaseTryAgain => '録音エラーです。もう一度お試しください。';

  @override
  String get noRecordingCapturedPleaseTryAgain => '録音されませんでした。もう一度お試しください。';

  @override
  String get recordedAudioIsEmptyPleaseTryAgainA =>
      '録音された音声が空です。もう一度お試しになり、はっきりと話してください。';

  @override
  String get azureSpeechApiKeysAreMissing1 => 'Azure Speech APIキーがありません';

  @override
  String get azureError401 => 'Azure エラー 401';

  @override
  String get azureAuthenticationFailedCheckYourS =>
      'Azure認証に失敗しました。.envファイルでSpeech APIキーとリージョンを確認してください。';

  @override
  String get azureError429 => 'Azure エラー 429';

  @override
  String get azureQuotaExceededTryAgainLater =>
      'Azureの割り当てを超過しました。後でもう一度お試しください。';

  @override
  String get azureGradingTimedOutCheckYourIntern =>
      'Azureの採点がタイムアウトしました。インターネット接続を確認してください。';

  @override
  String get recognitionFailedNull => '認識に失敗しました: null';

  @override
  String get couldNotHearYouClearlyPleaseTryAgai =>
      'はっきりと聞き取れませんでした。もう一度お試しください。';

  @override
  String get singlePhrasePractice => '単一フレーズ練習';

  @override
  String get failedToGeneratePhrase => 'フレーズの生成に失敗しました';

  @override
  String get omitted => '省略';

  @override
  String get partial => '一部';

  @override
  String get mispronounced => '誤発音';

  @override
  String get startSession1 => 'セッションを開始';

  @override
  String get chinese => '中国語';

  @override
  String get paused => '一時停止中';

  @override
  String get translationFailed => '翻訳に失敗しました';

  @override
  String get engagingMacroeconomicAndBusinessBre =>
      '生き生きとしたストーリーテリングで解説される、魅力的なマクロ経済とビジネスの分析。';

  @override
  String get exploresWorldEconomiesBankingHistor =>
      '世界の経済、銀行の歴史、そしてグローバルな産業の動向を探求します。';

  @override
  String get clearArticulateMandarinPerfectForIn =>
      '中級者および上級者に最適な、明瞭で分かりやすい中国語。';

  @override
  String get chefWang => '王シェフ';

  @override
  String get masterSichuanCulinaryTechniquesTaug => 'プロの料理長から直接学ぶ、四川料理の技術を習得。';

  @override
  String get stepbystepAuthenticChineseRecipesWi =>
      '鍋の扱い方や包丁さばきを含む、本格的な中華料理のステップバイステップのレシピ。';

  @override
  String get conciseCulinaryVocabularyAndClearIn => '簡潔な料理用語と、自然な中国語による明確な指示。';

  @override
  String get cinematographyCuttingedgeCameraTech =>
      '映画撮影、最先端のカメラ技術、そして深いデジタルメディア評価。';

  @override
  String get highproductionDocumentaryStyleExplo =>
      '高画質ドキュメンタリースタイルで、動画制作とAIの革新を探る。';

  @override
  String get richTechnicalMandarinWithCrystalcle => '明瞭な発音と視覚字幕による、専門的で豊かな中国語。';

  @override
  String get indepthInvestigativeJournalismAndCu => '深掘りする調査報道と時事問題の解説。';

  @override
  String get criticalPerspectivesOnSocialPhenome => '社会現象、世界ニュース、歴史に対する批判的視点。';

  @override
  String get formalInvestigativeDiscourseIdealFo => '上級者向けリスニングに最適な、フォーマルな調査論。';

  @override
  String get bitesizedAnimatedScienceDocumentari =>
      '日常の疑問に答える、短編アニメ科学ドキュメンタリー。';

  @override
  String get exploresPhysicsBiologyAndEverydayCu =>
      '物理学、生物学、日常の好奇心を楽しいインフォグラフィックで探求。';

  @override
  String get standardBeijingMandarinWithWellpace =>
      'テンポの良いナレーションと明瞭な字幕による標準北京語。';

  @override
  String get heartwarmingStreetFoodAdventuresAnd =>
      '心温まるストリートフードの冒険と、中国各地での本音の会話。';

  @override
  String get exploresRegionalHumanStoriesFamilyT => '地域の人間ドラマ、家族の伝統、郷土料理を探求。';

  @override
  String get naturalConversationalMandarinWithDa => '日常スラングと温かみのある、自然な会話中国語。';

  @override
  String get humorousAndHonestConsumerElectronic =>
      '実体験に基づいた、ユーモラスで正直な家電製品レビュー。';

  @override
  String get testingSmartphonesSmartHomeGadgetsA =>
      'スマートフォン、スマートホーム機器、テクノロジーライフスタイル製品のテスト。';

  @override
  String get relaxedHumorousConversationalDialog =>
      '現代の口語表現を用いた、リラックスしたユーモラスな会話。';

  @override
  String get seanKitchen => 'ショーン・キッチン';

  @override
  String get deliciousHomecookedChineseDishesAnd =>
      '美味しい家庭料理の中国料理と、ストリートスナックの再現。';

  @override
  String get easytofollowKitchenTipsForCookingAu =>
      '本格的なアジアの家庭料理を作るための、分かりやすいキッチンのヒント。';

  @override
  String get warmInvitingCommentaryWithPractical => '実用的なキッチン用語を用いた、温かく魅力的な解説。';

  @override
  String get chineseChannel => 'チャイニーズ・チャンネル';

  @override
  String get structuredChineseLanguageLessonsAnd => '体系的な中国語レッスンと文化発見チュートリアル。';

  @override
  String get grammarPointsHskVocabularyBuildingA => '文法ポイント、HSK語彙構築、会話パターン。';

  @override
  String get clearEducationalPacingTailoredSpeci => '中国語学習者向けに特化した、明瞭な教育ペース。';

  @override
  String get oneInABillion => 'ワン・イン・ア・ビリオン';

  @override
  String get intimatePortraitsAndStoriesOfUnique =>
      '現代中国におけるユニークな人々の親密なポートレートと物語。';

  @override
  String get exploresDiverseLifeChoicesYouthCult => '多様な生き方、若者文化、現代社会の変化を探求。';

  @override
  String get deepNarrativeStorytellingWithRichVo => '豊かな語彙と本物の声による、深みのある物語。';

  @override
  String get vickySoup => 'ヴィッキー・スープ';

  @override
  String get aestheticLifestyleVlogsFashionStyli =>
      '美しいライフスタイルVlog、ファッションスタイリング、日常のルーティン。';

  @override
  String get travelDiariesAndCozyLifeMomentsDocu =>
      '映画のような温かさで記録された旅行記と心地よい日常の瞬間。';

  @override
  String get naturalCasualMandarinSpokenAtAComfo =>
      '快適で表現豊かなペースで話される、自然でカジュアルな中国語。';

  @override
  String get tededMandarin => 'TED-Edマンダリン';

  @override
  String get highqualityAnimatedEducationalLesso =>
      '科学、哲学、歴史に関する高品質なアニメーション教育レッスン。';

  @override
  String get thoughtprovokingRiddlesClassicLiter => '示唆に富むなぞなぞ、古典文学、心理学の謎。';

  @override
  String get impeccableVoiceoverMandarinWithSync =>
      '完璧なナレーション中国語と同期されたバイリンガル字幕。';

  @override
  String get channel => 'チャンネル';

  @override
  String get curatedCulturalDocumentariesAndChin =>
      '厳選された文化ドキュメンタリーと中国のライフスタイルハイライト。';

  @override
  String get exploringTraditionalArtsHeritageCra => '伝統芸術、伝統工芸、現代のトレンドを探求。';

  @override
  String get highQualityAudioWithSynchronizedChi =>
      '同期された中国語クローズドキャプション付きの高品質オーディオ。';

  @override
  String get interestingStoriesAndCreativeVideoP =>
      '中国のウェブ上の興味深い物語とクリエイティブな動画プロジェクト。';

  @override
  String get engagingInterviewsStorytellingAndVi =>
      '魅力的なインタビュー、ストーリーテリング、視覚的探求。';

  @override
  String get greatListeningMaterialWithStandardP => '標準的な発音による優れたリスニング教材。';

  @override
  String get xVsY => 'X対Y';

  @override
  String get untitled => '無題';

  @override
  String get contemporaryStories => '現代の物語';

  @override
  String get history => '歴史';

  @override
  String get advancedReading => '上級読解';

  @override
  String get intermediateReading => '中級読解';

  @override
  String get beginnerReading => '初級読解';

  @override
  String get mandarinBean => 'マンダリン・ビーン';

  @override
  String get unknown => '不明';

  @override
  String get localDb => 'ローカルDB';

  @override
  String get emperorTaizong => '太宗皇帝';

  @override
  String get emperorXuanzong => '玄宗皇帝';

  @override
  String get liBai => '李白';

  @override
  String get gradedReader => 'グレーデッドリーダー';

  @override
  String get ucj10r97lkwgdtqbt6xzv8gLearnMandari =>
      'UCJ10R97LkwGdTqBT6xz-v8g\': \'台湾プラスで中国語を学ぶ';

  @override
  String get ucsxriuqkzzmaqklq0n9xfvwEverydayChi =>
      'UCSXriUqkzZmAQklQ0N9XFVw\': \'日常中国語';

  @override
  String get graceMandarinChinese => 'グレース・マンダリン・チャイニーズ';

  @override
  String get ucolbhvvl5dcjlmzeqbuu1vwTingdailyLi =>
      'UCOLBhVvL5dcJLMZeQBUu1Vw\': \'ティン - 中国の日常';

  @override
  String get xinxin => 'シンシン';

  @override
  String get sweetFamilyDailyLife => '甘い家族の日常';

  @override
  String get chinsunDailyLife => 'チンサン - 日常生活';

  @override
  String get tasteChina => 'テイスト・チャイナ';

  @override
  String get dawenFoodQuest => 'ダーウェン・フード・クエスト';

  @override
  String get chinaTravelWithCangbao => 'カンバオと行く中国旅行';

  @override
  String get alinFoodWalk => 'アリンの食べ歩き';

  @override
  String get videoOfTheDay => '今日の動画';

  @override
  String get noValidVideoFound => '有効な動画が見つかりませんでした。';

  @override
  String get listeningPractice => 'リスニング練習';

  @override
  String get socialSkills => 'ソーシャルスキル';

  @override
  String get culturalContext => '文化背景';

  @override
  String get realLife => '実生活';

  @override
  String get realWorld => '現実世界';

  @override
  String get articleOfTheDay => '今日の記事';

  @override
  String get failedToLoadOrParseRssFeed => 'RSSフィードの読み込みまたは解析に失敗しました。';

  @override
  String get drama => 'ドラマ';

  @override
  String get youkugetAppNow => 'YOUKU - アプリを今すぐ入手';

  @override
  String get romanceTrailer => 'ロマンス\', \'予告編';

  @override
  String get romance => 'ロマンス';

  @override
  String get action => 'アクション';

  @override
  String get mystery => 'ミステリー';

  @override
  String get historical => '時代劇';

  @override
  String get historicalAction => '時代劇\', \'アクション';

  @override
  String get historicalRomance => '時代劇\', \'ロマンス';

  @override
  String get anYouth => '青春';

  @override
  String get historicalSliceOfLife => '時代劇\', \'日常系';

  @override
  String get historicalHighlight => '時代劇\', \'ハイライト';

  @override
  String get youkuEnglishgetAppNow => 'YOUKU English - アプリを今すぐ入手';

  @override
  String get theDouble => 'ザ・ダブル';

  @override
  String get updatesByOshin => 'Oshinによる更新';

  @override
  String get backFromTheBrink => '崖っぷちからの生還';

  @override
  String get fallingIntoYourSmile => '君の笑顔に恋をする';

  @override
  String get everyoneLovesMe => 'みんな私を愛してる';

  @override
  String get tillTheEndOfTheMoon => '月が昇るまで';

  @override
  String get theBestDayOfMyLife => '人生最高の日';

  @override
  String get gikkiChineseDrama => 'GIKKI 中国ドラマ';

  @override
  String get dashingYouth => '華麗なる青春';

  @override
  String get rebornChineseDramaEngSub => 'Reborn 中国ドラマ 英語字幕';

  @override
  String get ijenwaBenita => 'イジェンワ・ベニータ';

  @override
  String get whenIFlyTowardsYou => '君に飛んでいく時';

  @override
  String get mztvExclusiveChineseDrama => 'MZTV独占 中国ドラマ';

  @override
  String get theStarryLove => '星降る愛';

  @override
  String get comedy => 'コメディ';

  @override
  String get backFromTheBrink1 => '崖っぷちからの生還\':';

  @override
  String get dashingYouth1 => '華麗なる青春\':';

  @override
  String get beReborn => '生まれ変わる';

  @override
  String get beautyStrategy => '美の戦略';

  @override
  String get myDivineEmissary => '私の神聖な使者';

  @override
  String get theHope => '希望';

  @override
  String get ep16In => 'EP16\': \'イン';

  @override
  String get everyoneLovesMe1 => 'みんな私を愛してる\': \'';

  @override
  String get fallingIntoYourSmile1 => '君の笑顔に恋をする\':';

  @override
  String get hiddenLove => '隠された愛\':';

  @override
  String get loveBetweenFairyAndDevil => '仙人と悪魔の恋\':';

  @override
  String get loveLikeTheGalaxy => '銀河の如き愛\':';

  @override
  String get membersPremiere => '会員先行公開';

  @override
  String get moonlight => '月光';

  @override
  String get myJourneyToYou => '君への旅\':';

  @override
  String get mysteriousLotusCasebook => '神秘の蓮の事件簿\':';

  @override
  String get rebornChineseDramaEngSub1 => 'Reborn 中国ドラマ 英語字幕\': \'';

  @override
  String get reborn => 'リボーン';

  @override
  String get theBestDayOfMyLife1 => '人生最高の日\': \'';

  @override
  String get theDouble1 => 'ザ・ダブル\':';

  @override
  String get theLongBallad => '長歌行\':';

  @override
  String get theStarryLove1 => '星降る愛\':';

  @override
  String get theUntamed => '陳情令\':';

  @override
  String get tillTheEndOfTheMoon1 => '月が昇るまで\':';

  @override
  String get whenIFlyTowardsYou1 => '君に飛んでいく時\':';

  @override
  String get wordOfHonor => '山河令\':';

  @override
  String get blossom => '開花';

  @override
  String get gemini => 'ジェミニ';

  @override
  String get generationToGeneration => '世代から世代へ';

  @override
  String get brocadeOdyssey => '錦のオデッセイ';

  @override
  String get circleOfLove => '愛の輪';

  @override
  String get dawnIsBreaking => '夜明けが来る';

  @override
  String get firstRomance => '初恋';

  @override
  String get loveInTheClouds => '雲の中の愛';

  @override
  String get secondChanceRomance => '二度目のロマンス';

  @override
  String get mrBad => 'ミスター・バッド';

  @override
  String get pursuitOfJade => '翡翠を求めて';

  @override
  String get fatedHearts => '運命の恋';

  @override
  String get roadHome => '帰路';

  @override
  String get myDearGuardian => '親愛なる守護者';

  @override
  String get brightEyesInTheDark => '闇夜の輝く瞳';

  @override
  String get theIngeniousOne => '稀代の才人';

  @override
  String get herPhoenixMajesty => '鳳凰の女王';

  @override
  String get dreamsNeverEnd => '夢は終わらない';

  @override
  String get theUltimateVowUnknownToYou => 'あなたに知られざる究極の誓い';

  @override
  String get the300LoyalGhosts => '300人の忠実な亡霊';

  @override
  String get homelandGuardian => '故郷の守護者';

  @override
  String get loveIsAlwaysOnline => '愛はいつもオンライン';

  @override
  String get thePrincessDecree => '王女の勅令';

  @override
  String get aVowInTheDark => '闇の中の誓い';

  @override
  String get aGirlLikeMe => '私のような少女';

  @override
  String get iAmNobody => '私は何者でもない';

  @override
  String get myMamaGo => '私のママ、行く！';

  @override
  String get myWesternRegionPrincess => '私の西域の王女';

  @override
  String get aFlowerOnTheContinent => '大陸の花';

  @override
  String get thePrincess => '王女';

  @override
  String get sweetLoveVersion => 'スイートラブバージョン';

  @override
  String get hilariousFamily2 => '爆笑家族2';

  @override
  String get guYuanMountainHasASchool => '顧源山に学校がある';

  @override
  String get foreverYoung => '永遠の若さ';

  @override
  String get theHiddenHeirYeChen => '隠された後継者、葉辰';

  @override
  String get extraordinary => '非凡な';

  @override
  String get sideStoryOfFoxVolant => '飛狐外伝';

  @override
  String get loveOfTheDivineTree => '神木の愛';

  @override
  String get rebirth => '転生';

  @override
  String get moonlitReunion => '月下の再会';

  @override
  String get videoCountsCannotBeNegative => '動画のカウントは負の値にできません。';

  @override
  String get publicDomainClassic => 'パブリックドメイン名作';

  @override
  String get idioms => '慣用句';

  @override
  String get news => 'ニュース';

  @override
  String get fairyTales => 'おとぎ話';

  @override
  String get hereIsAFascinatingCulturalExplanati => '魅力的な文化解説はこちら';

  @override
  String get videoFetchTimedOut => '動画の取得がタイムアウトしました';

  @override
  String get aboutChannel => 'チャンネルについて';

  @override
  String get noVideosFound => '動画が見つかりませんでした';

  @override
  String get failedToLoadVideos => '動画の読み込みに失敗しました';

  @override
  String get highqualityCuratedMandarinContentWi => '自然な語彙で厳選された高品質な中国語コンテンツ';

  @override
  String get authenticSpokenChineseAcrossRealwor => '実世界のテーマやトピックにわたる本格的な中国語会話';

  @override
  String get engagingVideoMaterialWithInteractiv => 'インタラクティブな同期字幕付きの魅力的な動画教材';

  @override
  String get watchVideo => '動画を見る';

  @override
  String get culturalInsight => '文化の洞察';

  @override
  String get aiIsAnalyzingCulturalContext => 'AIが文化的な背景を分析中...';

  @override
  String get diveIntoFullContent => '全コンテンツを見る';

  @override
  String get savedArticles => '保存済み記事';

  @override
  String get liveOverlay => 'ライブオーバーレイ';

  @override
  String get webExplorer => 'ウェブエクスプローラー';

  @override
  String get browseAnyChineseWebsiteWithRealtime =>
      'リアルタイムのタップ辞書、ピンイン注釈、即時翻訳で、あらゆる中国語ウェブサイトを閲覧';

  @override
  String get startExploring => '探索を開始';

  @override
  String get chineseTvSeriesWithInteractiveSubti => 'インタラクティブ字幕付き中国語ドラマ';

  @override
  String get failedToLoadContent => 'コンテンツの読み込みに失敗しました';

  @override
  String get searchingYoutube => 'YouTubeを検索中...';

  @override
  String get noVideosFoundTryADifferentSearchTer =>
      '動画が見つかりませんでした。別の検索語をお試しください。';

  @override
  String get searching => '検索中';

  @override
  String get noShowsFound => '番組が見つかりませんでした';

  @override
  String get bookmarked => 'ブックマーク済み';

  @override
  String get trailer1 => '予告編';

  @override
  String get highlight1 => 'ハイライト';

  @override
  String get noCaptionsAvailable => '字幕はありません';

  @override
  String get fetchingSubtitles => '字幕を取得中...';

  @override
  String get generatingAiBriefing => 'AIブリーフィングを生成中...';

  @override
  String get noClosedCaptionsCcFoundForThisVideo =>
      'この動画にはクローズドキャプション（CC）が見つかりませんでした。';

  @override
  String get videosWithHardcodedOrBurnedinSubtit =>
      'ハードコードまたは焼き付けられた字幕付きの動画には、YouTubeで利用可能なデジタルテキストトラックがありません。';

  @override
  String get translatingSubtitles => '字幕を翻訳中...';

  @override
  String get processingYourPronunciation => '発音を処理中...';

  @override
  String get couldntIdentifyLine => '行を特定できませんでした。';

  @override
  String get listeningSpeakNow => '聞き取り中... 今話してください。';

  @override
  String get thisVideoDoesNotHaveADigitalClosedC =>
      'この動画にはYouTubeで利用可能なデジタルクローズドキャプション（CC）トラックがありません。';

  @override
  String get perfect1 => '完璧';

  @override
  String get thisVideoHasBeenRemovedOrIsNoLonger => 'この動画は削除されたか、現在利用できません。';

  @override
  String get thisVideoCannotBePlayedInTheAppYouC =>
      'この動画はアプリ内では再生できません。YouTubeで視聴できます。';

  @override
  String get yourDeviceCannotPlayThisVideoPlease =>
      'お使いのデバイスではこの動画を再生できません。別の動画をお試しください。';

  @override
  String get invalidVideoReferencePleaseTryAgain => '無効な動画参照です。もう一度お試しください。';

  @override
  String get unableToLoadThisVideoPleaseTryAnoth =>
      'この動画を読み込めませんでした。別の動画をお試しください。';

  @override
  String get startReading => '読書を開始';

  @override
  String get analyzingCulturalContext => '文化的背景を分析中...';

  @override
  String get failedToLoadCulturalInsight => '文化的洞察の読み込みに失敗しました。';

  @override
  String get historicalContext => '歴史的背景';

  @override
  String get culturalSignificance => '文化的意義';

  @override
  String get authorBackground => '著者情報';

  @override
  String get k80CompleteClassicNovelsWorldEpics => '80以上の古典小説と世界叙事詩';

  @override
  String get storyOfTheDay => '今日の物語';

  @override
  String get tangDynasty => '唐代';

  @override
  String get poetryClassicalVerse => '詩\', \'古典\', \'韻文';

  @override
  String get allHsk => 'HSK全レベル';

  @override
  String get allStories => '全ての物語\' :';

  @override
  String get keyWords => 'キーワード';

  @override
  String get openOriginalWebsite => '元のウェブサイトを開く';

  @override
  String get aiReadingTools => 'AI読書ツール';

  @override
  String get enhanceYourReadingWithAipoweredTool => 'AI搭載ツールで読書を強化';

  @override
  String get chooseTheTargetDifficultyForSimplif => '簡素化の目標難易度を選択';

  @override
  String get chooseDifficultyForSimplification => '簡素化の難易度を選択';

  @override
  String get extractAllUnknownWordsToANewFlashca =>
      '未知の単語をすべて新しいフラッシュカードデッキに抽出';

  @override
  String get length => '長さ';

  @override
  String get m1554846a550010707 => 'M15.54 8.46a5 5 0 0 1 0 7.07';

  @override
  String get m1907493a101000101414 => 'M19.07 4.93a10 10 0 0 1 0 14.14';

  @override
  String get webExtraction => 'ウェブ抽出';

  @override
  String get aiTools => 'AIツール';

  @override
  String get stop => '停止';

  @override
  String get keepPracticing1 => '練習を続ける';

  @override
  String get aiPrepRoom => 'AI準備室';

  @override
  String get lessonSummary => 'レッスン概要';

  @override
  String get unlockSinosparkPremium => 'SinoSparkプレミアムをアンロック';

  @override
  String get monthYear => '月\' : \'年';

  @override
  String get enableNotifications => '通知を有効にする';

  @override
  String get notificationsConfigured => '通知設定済み';

  @override
  String get neverMissAStroke2 => '一画も逃さない';

  @override
  String get yourDailyDropAndStreakAlertsArePrim => '毎日のドロップと連続記録アラートが設定されました。';

  @override
  String get stayConsistentWithDailyRitualDropsA =>
      '毎日の習慣ドロップとタイムリーなトライアルリマインダーで継続しましょう。';

  @override
  String get aNewWordAndStoryWaitingForYourDaily =>
      '毎日の習慣に、新しい単語と物語があなたを待っています。';

  @override
  String get gentlePromptsBeforeCharactersFadeFr =>
      '文字が記憶から薄れる前に、やさしいヒントをお届けします。';

  @override
  String get receiveAReminder2DaysBeforeYourFree =>
      '無料トライアル終了の2日前にリマインダーを受け取ります。';

  @override
  String get yourPathTonchineseFluency => '中国語流暢への道\\n';

  @override
  String get answer3QuickQuestionsSoOurAiCanCraf =>
      '3つの簡単な質問に答えて、AIがあなたの生活に合った\\nカリキュラムを作成します。';

  @override
  String get whatIsYourLevelnwithChinese => '中国語のレベルは？\\n';

  @override
  String get chooseThePathThatFitsYourDepth => 'あなたのレベルに合った道を選んでください。';

  @override
  String get whatDrivesYourStudy => '学習の目的は何ですか？';

  @override
  String get purposeFuelsTheBrush => '目的が筆を動かす';

  @override
  String get setYourDailyRitual => '毎日の習慣を設定してください。';

  @override
  String get youCanAdjustYourRitualAnyTime => '習慣はいつでも調整できます。';

  @override
  String get letsBegin => '始めましょう';

  @override
  String get brandNew => '全くの初心者';

  @override
  String get iveNeverStudiedChineseBefore => '中国語を学んだことがありません。';

  @override
  String get iKnowBasicCharactersAndPhrases => '基本的な漢字やフレーズを知っています。';

  @override
  String get iCanHoldConversationsAndRead => '会話ができ、読むことができます。';

  @override
  String get iWantToRefineAndPerfectMySkills => 'スキルを磨き、完璧にしたいです。';

  @override
  String get confirmSelection => '選択を確定';

  @override
  String get purposeFuelsTheBrushsMotion => '目的が筆の動きを促します。';

  @override
  String get buildMyPath => '私のパスを作成';

  @override
  String get hskCertification => 'HSK認定';

  @override
  String get culturalAppreciation => '文化理解';

  @override
  String get yourPlanIsReady => 'プランの準備ができました。';

  @override
  String get craftingYourCurriculum => 'カリキュラムを作成中';

  @override
  String get personalizedPathInitialized => 'パーソナライズされたパスを初期化しました';

  @override
  String get calibratingAiNeuralMasters => 'AIニューラルマスターを調整中...';

  @override
  String get calibrationComplete => '調整完了';

  @override
  String get synthesizingModules => 'モジュールを統合中...';

  @override
  String get oneAndWater => '一\' と \'水';

  @override
  String get theHorizontalStroke => '横画';

  @override
  String get theRadical => '部首';

  @override
  String get water => '水';

  @override
  String get river => '川';

  @override
  String get day5Reminder => '5日目のリマインダー';

  @override
  String get wePromisedToAlertYou2DaysBeforeYour =>
      'トライアル終了の2日前にお知らせするとお約束しました。これにより、';

  @override
  String get continueWithoutReminder => 'リマインダーなしで続行';

  @override
  String get masterChineseWithnsinospark => 'SinoSparkで中国語をマスター\\nしましょう';

  @override
  String get start7dayFreeTrial => '7日間無料トライアルを開始';

  @override
  String get precisionStrokes => '精密な筆画';

  @override
  String get aiPronunciation => 'AI発音';

  @override
  String get today => '今日';

  @override
  String get fullAccess => 'フルアクセス';

  @override
  String get day5 => '5日目';

  @override
  String get reminder => 'リマインダー';

  @override
  String get day7 => '7日目';

  @override
  String get trialBegins => 'トライアル開始';

  @override
  String get revenuecatIsMissingACurrentOffering =>
      'RevenueCatに現在のオファリングまたはパッケージがありません。ダッシュボードを設定してください。';

  @override
  String get cameraPermissionRequiredForLiveScan => 'ライブスキャンにはカメラの許可が必要です。';

  @override
  String get cameraAccessRequired => 'カメラアクセスが必要です';

  @override
  String get pleaseEnableCameraAccessInYourDevic =>
      'この機能を使用するには、デバイス設定でカメラアクセスを有効にしてください。';

  @override
  String get alignChineseTextWithinFrame => 'フレーム内に中国語テキストを配置';

  @override
  String get inLibrary => 'ライブラリ内';

  @override
  String get novice => '初心者';

  @override
  String get apprentice => '見習い';

  @override
  String get artisan => '熟練者';

  @override
  String get grandmaster => '達人';

  @override
  String get poem => '詩';

  @override
  String get theNarrative => '物語';

  @override
  String get classicMasterpiece => '古典名作';

  @override
  String get classicAuthor => '古典作家';

  @override
  String get classical => '古典';

  @override
  String get classicLiterature => '古典文学';

  @override
  String get inThisChapterOf => 'この章では';

  @override
  String get asTheNarrativeUnfoldsItIlluminatesT =>
      '物語が展開するにつれて、人生の根本的な知恵と永続的なインスピレーションが明らかになります。';

  @override
  String get general => '一般';

  @override
  String get mythology => '神話';

  @override
  String get dailyLife => '日常生活';

  @override
  String get tangPoetry => '唐詩';

  @override
  String get classicalLiterature => '古典文学';

  @override
  String get justNow => '今';

  @override
  String get theTerracottaArmyOfQinShiHuang => '秦始皇の兵馬俑';

  @override
  String get lifeInsideTheForbiddenCity => '紫禁城での生活';

  @override
  String get buyingATicketAndTakingTheHighSpeedT => '中国で切符を買い、高速鉄道に乗る';

  @override
  String get goingToTheHospitalForAColdAndSeeing => '風邪で病院に行き、医者に診てもらう';

  @override
  String get goingToALocalRestaurantToOrderJiaoz => '地元のレストランで餃子を注文する';

  @override
  String get theTraditionalGongfuTeaCeremony => '伝統的な工夫茶の儀式';

  @override
  String get theArtOfWritingChineseCharactersWit => '筆で漢字を書く芸術';

  @override
  String get theLifeAndConservationOfGiantPandas => 'ジャイアントパンダの生態と保護';

  @override
  String get storyNotFoundInDatabase => 'データベースに物語が見つかりません';

  @override
  String get storyTextIsEmpty => '物語のテキストが空です';

  @override
  String get myCustomStories => 'マイカスタムストーリー';

  @override
  String get userProvidedText => 'ユーザー提供テキスト';

  @override
  String get local => 'ローカル';

  @override
  String get voiceEngineAllowance => '音声エンジンと利用枠';

  @override
  String get studioHdVsUnlimitedStandardVoice => 'Studio HD vs. 無制限スタンダード音声';

  @override
  String get standardVoiceIs100UnlimitedFree => 'スタンダード音声は100%無制限で無料です';

  @override
  String get read => '読む';

  @override
  String get koreKoreFemaleWarm => 'コレ\', \'コレ\', \'女性、温かい';

  @override
  String get aoedeAoedeFemaleCheerful => 'アオイデ\', \'アオイデ\', \'女性、陽気';

  @override
  String get fenrirFenrirMaleUpbeat => 'フェンリル\', \'フェンリル\', \'男性、陽気';

  @override
  String get charonCharonMaleNewsstyle => 'カロン\', \'カロン\', \'男性、ニューススタイル';

  @override
  String get puckPuckMaleSporty => 'パック\', \'パック\', \'男性、スポーティー';

  @override
  String get localOndevice => 'ローカル\', \'デバイス内';

  @override
  String get localOndeviceTts => 'ローカルデバイス内TTS';

  @override
  String get off => 'オフ';

  @override
  String get endOfCurrentChapter => '現在の章の終わり';

  @override
  String get standardVoice => 'スタンダード音声';

  @override
  String get noNovelsFoundMatchingYourFilter => 'フィルターに一致する小説は見つかりませんでした。';

  @override
  String get noMicroreadsFoundMatchingYourFilter =>
      'フィルターに一致するマイクロリードは見つかりませんでした。';

  @override
  String get noPoemsFoundMatchingYourFilter => 'フィルターに一致する詩は見つかりませんでした。';

  @override
  String get audiobook => 'オーディオブック';

  @override
  String get audio => '音声';

  @override
  String get continueReading => '続きを読む';

  @override
  String get search96FullNovelsAuthorsEpics => '96の長編小説、著者、叙事詩を検索...';

  @override
  String get searchClassicalPoemsAuthorsVerses => '古典詩、著者、詩句を検索...';

  @override
  String get allLevelsVal => 'すべてのレベル\', \'val';

  @override
  String get hsk1BeginnerVal => 'HSK 1 (初心者)\', \'val';

  @override
  String get hsk2ElementaryVal => 'HSK 2 (初級)\', \'val';

  @override
  String get hsk3IntermediateVal => 'HSK 3 (中級)\', \'val';

  @override
  String get hsk4UpperIntVal => 'HSK 4 (中上級)\', \'val';

  @override
  String get listenToAudiobook => 'オーディオブックを聴く';

  @override
  String get synopsis => 'あらすじ';

  @override
  String get peoplesArtist => '人民芸術家\'.';

  @override
  String get kafkaesqueForBureaucraticAbsurdityA =>
      'カフカ的\' は、官僚的な不条理、疎外感、実存的な不安を表す。';

  @override
  String get bigBrotherAndNewspeak => 'ビッグ・ブラザー\' と \'ニュースピーク\'.';

  @override
  String get audiobookIncluded => 'オーディオブック付属';

  @override
  String get readPoem => '詩を読む';

  @override
  String get studioVoiceAllowance => 'スタジオ音声利用枠';

  @override
  String get weeklyHighdefinitionAiRecitation => '毎週の高精細AI朗読';

  @override
  String get resetsEveryMondayAt0000 => '毎週月曜日00:00にリセットされます';

  @override
  String get whenYourWeekly4hourStudioAllowanceI =>
      '毎週4時間のスタジオ利用枠を使い切ると、アプリは自動的にオンデバイス音声に切り替わり、中断なしで無制限に無料で聴くことができます。';

  @override
  String get localDeviceVoice => 'ローカルデバイス音声\' :';

  @override
  String get classicalVerse => '古典詩句';

  @override
  String get ondeviceVoice4hWeeklyUsed => 'オンデバイス音声 (毎週4時間使用済み)';

  @override
  String get generateACustomAiStoryBasedOnYourIn => 'あなたの興味に基づいてカスタムAIストーリーを生成';

  @override
  String get insteadOfAFixedHskLevelTheFlowState =>
      '固定されたHSKレベルの代わりに、フロー状態エンジンがあなたのフラッシュカードライブラリを分析します。\n\n';

  @override
  String get we => '私たち';

  @override
  String get howCanWeHelpYou => '何かお手伝いできますか？';

  @override
  String get everythingYouNeedToKnowAboutHanziMa =>
      'Hanzi Master、その機能、およびプライバシーについて知っておくべきことすべて。';

  @override
  String get whoAreTheVoicesSpeakingInTheApp => 'アプリ内の音声は誰ですか？';

  @override
  String get howDoesTheWebExplorerWork => 'ウェブエクスプローラーはどのように機能しますか？';

  @override
  String get whatIsZenMode => '禅モードとは何ですか？';

  @override
  String get howDoesTheFlashcardSpacedrepetition =>
      'フラッシュカードの間隔反復学習はどのように機能しますか？';

  @override
  String get traceComplete => 'トレース完了！';

  @override
  String get traceCharacter => '文字をトレース';

  @override
  String get analyzingWordRelationships => '単語の関係性を分析中...';

  @override
  String get identifyingUsageContexts => '使用状況の文脈を特定中...';

  @override
  String get comparingFormalityLevels => '丁寧さのレベルを比較中...';

  @override
  String get findingCommonCollocations => '一般的なコロケーションを検索中...';

  @override
  String get generatingComparison => '比較を生成中...';

  @override
  String get generationIsTakingLongerThanExpecte =>
      '生成に予想よりも時間がかかっています。AIが過負荷状態かもしれません。';

  @override
  String get generationInterruptedShowingPartial => '生成が中断されました。部分的な結果を表示します。';

  @override
  String get sorrySomethingWentWrong => '申し訳ありません、問題が発生しました。';

  @override
  String get usage => '使用法:\', \'';

  @override
  String get alsoSeenIn => '以下でも見られます';

  @override
  String get quickLook => 'クイックルック';

  @override
  String get notFound => '見つかりません';

  @override
  String get errorLoadingFromAi => 'AIからの読み込みエラー。';

  @override
  String get newLabel => '新規';

  @override
  String get analyzingImage => '画像を解析中...';

  @override
  String get extractingChineseText => '中国語テキストを抽出中...';

  @override
  String get lookingUpVocabulary => '単語を調べ中...';

  @override
  String get dreamOfTheRedChamber => '紅楼夢';

  @override
  String get journeyToTheWest => '西遊記';

  @override
  String get romanceOfTheThreeKingdoms => '三国志演義';

  @override
  String get mingDynasty => '明代';

  @override
  String get wuChengEn => '吳承恩';

  @override
  String get hundredChapters => '100話';

  @override
  String get volume1 => '第1巻';

  @override
  String bookmarksCount(Object count) {
    return 'しおり ($count)';
  }

  @override
  String get noBookmarksYet => 'まだしおりがありません。しおりアイコンをタップして節を保存してください。';

  @override
  String get sinosparkIsNotResponding => 'SinoSparkが応答していません';

  @override
  String get closeApp => 'アプリを閉じる';

  @override
  String get wait => '待つ';

  @override
  String studioHdAllowance(Object hours) {
    return 'Studio HD: $hours時間';
  }

  @override
  String bookPercentRead(Object percent) {
    return '本 $percent%';
  }

  @override
  String chAbbreviation(Object number) {
    return '第$number話';
  }

  @override
  String booksAndAudiobooks(Object count) {
    return '$count冊の本と音声書籍';
  }

  @override
  String sentenceXOfY(Object current, Object total) {
    return '$current文目 / 全$total文目';
  }

  @override
  String chapterXOfY(Object current, Object total) {
    return '$current話 / 全$total話';
  }

  @override
  String get allLevels => 'すべてのレベル';

  @override
  String get searchGradedMicroStories => 'レベル別マイクロストーリー・寓話を検索...';

  @override
  String gradedStoriesAndMicroReads(Object count) {
    return '$countのレベル別ストーリーと毎日マイクロリーディング';
  }

  @override
  String get searchClassicalPoems => '古典詩、著者、詩節を検索...';

  @override
  String classicalPoemsAndVerse(Object count) {
    return '$countの古典詩と詩節';
  }

  @override
  String get browseAnyChineseWebsite =>
      'リアルタイムタップ辞書、ピンイン注釈、即時翻訳であらゆる中国語ウェブサイトをブラウズできます。';

  @override
  String get completed => '完了';

  @override
  String get aiIsReading => 'AIが読み取っています...';

  @override
  String get bbcVerify => 'BBC VERIFY';

  @override
  String get hsk5AdvancedVal => 'HSK 5 (上級)';

  @override
  String get hsk1Beginner => 'HSK 1 (初心者)';

  @override
  String get hsk4UpperInt => 'HSK 4 (上中級)';

  @override
  String get extractAllUnknownWords => '未知の単語をすべて新しいフラッシュカードデッキに抽出する';

  @override
  String get designCustomAiRoleplay => 'カスタムAIロールプレイと会話体験を設計する';

  @override
  String get practiceFlashcardVocabulary => 'ライブ会話でフラッシュカードの語彙を練習する';

  @override
  String get surpriseMe => 'たまにはサプライズして';

  @override
  String get rollCharacter => 'キャラクターロール';

  @override
  String get historicalCostume => '歴史 / 時代衣装';

  @override
  String get modernYouth => 'モダン & 若者';

  @override
  String get fantasyMythology => 'ファンタジー & 神話';

  @override
  String get familyDrama => 'ファミリー & ドラマ';

  @override
  String get fullVersion => '完全版';

  @override
  String episodesCount(Object count) {
    return '$count 話';
  }

  @override
  String episodeLabel(Object number) {
    return '第$number話';
  }

  @override
  String get translating => '[ 翻訳中... ]';

  @override
  String get engSub => '[英語字幕]';

  @override
  String get standardVocabulary => '標準語彙';

  @override
  String get characters => '字';
}
