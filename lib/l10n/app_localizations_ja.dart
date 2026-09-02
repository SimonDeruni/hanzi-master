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
  String get deleteAccount => 'アカウントを削除';

  @override
  String get deleteAccountSubtitle => 'アカウントを完全に削除します';

  @override
  String get deleteAccountTitle => 'アカウントを完全に削除しますか？';

  @override
  String get accountDataDeletedTitle => 'アカウントデータが削除されます';

  @override
  String get accountDataDeletedBody =>
      'サインインアカウントおよびSinoSparkが保持するすべてのアカウント情報が完全に削除されます。この操作は元に戻せません。';

  @override
  String get localDataKeptTitle => 'この端末上のデータは保持されます';

  @override
  String get localDataKeptBody =>
      'この端末にのみ保存されている学習進捗、ダウンロード済みコンテンツ、環境設定は削除されません。';

  @override
  String get subscriptionNotCanceledTitle => 'サブスクリプションは解約されません';

  @override
  String get subscriptionNotCanceledBody =>
      'アカウントを削除してもApp Storeのサブスクリプションは自動解約されません。Apple側で解約手続きを行わない限り、更新が継続する場合があります。';

  @override
  String get manageSubscription => 'App Storeサブスクリプションを管理';

  @override
  String get subscriptionManagementFailed =>
      'Appleのサブスクリプション管理画面を開けませんでした。「設定」>「ユーザー名」>「サブスクリプション」から管理してください。';

  @override
  String get confirmPassword => '現在のパスワード';

  @override
  String get confirmPasswordToDelete => '本人確認のためパスワードを入力してください。';

  @override
  String get deleteAccountPermanently => 'アカウントを完全に削除';

  @override
  String get deleteAccountFinalTitle => '最終確認';

  @override
  String get deleteAccountFinalWarning =>
      'アカウントが完全に削除され、元に戻すことはできません。この端末にのみ保存されているデータは保持されます。続行しますか？';

  @override
  String get deletingAccount => 'アカウントを削除中...';

  @override
  String get accountPasswordRequired => '続行するには現在のパスワードを入力してください。';

  @override
  String get accountPasswordIncorrect => 'パスワードが正しくありません。もう一度お試しください。';

  @override
  String get accountReauthenticationCanceled =>
      '本人確認がキャンセルされました。アカウントは削除されていません。';

  @override
  String get accountReauthenticationFailed =>
      '本人確認ができませんでした。もう一度お試しの上、サインイン手続きを完了してください。';

  @override
  String get accountAlreadySignedOut => 'すでにサインアウトされています。削除されたアカウントはありません。';

  @override
  String get accountProviderUnsupported =>
      'このサインイン方法はアプリ内で認証できません。アカウント削除についてはサポートまでお問い合わせください。';

  @override
  String get appleDeletionRequiresAppleDevice =>
      'セキュリティ上の理由から、Apple連携アカウントの削除はApple端末から行う必要があります。';

  @override
  String get accountDeletionNetworkError => '通信環境を確認し、再度アカウント削除をお試しください。';

  @override
  String get accountDeletionFailed =>
      'アカウントを削除できませんでした。アカウントは有効なままです。もう一度お試しください。';

  @override
  String get accountDeletedSuccessfully => 'アカウントが完全に削除されました。';

  @override
  String get globalMastery => '全体の習熟度';

  @override
  String get masteredCards => '習得済み';

  @override
  String get hsk1Candidate => 'HSK 1級候補';

  @override
  String get hsk2Candidate => 'HSK 2級候補';

  @override
  String get hsk3Candidate => 'HSK 3級候補';

  @override
  String get hsk4Candidate => 'HSK 4級候補';

  @override
  String get hsk5Candidate => 'HSK 5級候補';

  @override
  String get hsk6Candidate => 'HSK 6級候補';

  @override
  String get hsk6Master => 'HSK 6級マスター';

  @override
  String get currentRank => '現在のランク';

  @override
  String get next => '次へ';

  @override
  String get searchHanziOrPinyin => '漢字やピンインを検索...';

  @override
  String get dailyReview => '本日の復習';

  @override
  String get upcomingForecast => '復習スケジュール';

  @override
  String get laterToday => '今日（後ほど）';

  @override
  String get tomorrow => '明日';

  @override
  String get next7Days => '今後7日間';

  @override
  String get theScholarWay => '学者の道';

  @override
  String get beginJourney => '学習を始める';

  @override
  String get settingsTitle => '設定';

  @override
  String get darkMode => 'ダークモード';

  @override
  String get darkModeDesc => '目に優しい配色';

  @override
  String get voiceSpeed => '音声の速度';

  @override
  String get artAndIntellect => '芸術と知性';

  @override
  String get theDigitalScholar => 'デジタル学者';

  @override
  String get refineBrushVoice => 'AIと共に筆使いと発音を磨く。';

  @override
  String get liveVoiceCall => 'ライブ音声通話';

  @override
  String get immersiveRoleplay => 'AIアバターとの没入型ロールプレイ';

  @override
  String get readingRoom => '読書室';

  @override
  String get shadowingStudio => 'シャドーイングスタジオ';

  @override
  String get errorPrefix => 'エラー: ';

  @override
  String get initializingLibrary => 'ライブラリを初期化中...';

  @override
  String get unlockCharactersToQuiz => 'クイズを始めるには4文字アンロックしてください！';

  @override
  String get practiceQuiz => 'クイズ';

  @override
  String get curriculumPaths => '学習ロードマップ';

  @override
  String get noDecksFound => 'デッキが見つかりません。追加してみましょう！';

  @override
  String get addCardsFirst => 'まずカードを追加してください！';

  @override
  String get aiDraftingPath => 'AIがカリキュラムを作成中...';

  @override
  String get pathReady => '学習パスの準備が整いました！';

  @override
  String get errorGeneratingPath => 'パスの生成エラー';

  @override
  String get brushingCurriculum => 'カリキュラムを構築中...';

  @override
  String get warmUp => 'ウォームアップ';

  @override
  String get lessonComplete => 'レッスン完了！ +10 インクポイント';

  @override
  String get step1Origin => 'ステップ1：起源';

  @override
  String get traceRadical => '部首をなぞる';

  @override
  String get step2Forge => 'ステップ2：鍛造';

  @override
  String get chooseEssence => '本質を選ぶ';

  @override
  String get wrongEssence => '不正解です！もう一度試してください。';

  @override
  String get step3Hunt => 'ステップ3：文字探し';

  @override
  String get findCharacters => '漢字を探す';

  @override
  String get notThatOne => '違います！';

  @override
  String get successfullyInstalled => 'インストール完了:';

  @override
  String get failedToDownload => 'ダウンロードに失敗しました。';

  @override
  String get rescindTitle => '取り消しますか？';

  @override
  String get removeCharactersWarning => 'これらの漢字が削除されます。';

  @override
  String get cancel => 'キャンセル';

  @override
  String get uninstall => 'アンインストール';

  @override
  String get removedLibrary => '削除済み:';

  @override
  String get tomeLibrary => '書物ライブラリ';

  @override
  String get libraryError => 'ライブラリエラー';

  @override
  String get installTome => 'インストール';

  @override
  String get unitIntro => 'ユニット概要';

  @override
  String get constellationCluster => '星座クラスター';

  @override
  String get ok => 'OK';

  @override
  String get divingInto => '読み込み中...';

  @override
  String get keyRadicals => '重要部首';

  @override
  String get noRadicalData => 'データがありません。';

  @override
  String get discovery => '新たな発見';

  @override
  String get startLearning => '学習を始める';

  @override
  String get selectPersona => 'ペルソナを選択';

  @override
  String get customPersona => 'カスタムペルソナ';

  @override
  String get geminiLiveCall => 'ライブ通話';

  @override
  String get returnToMenu => 'メニューに戻る';

  @override
  String get strokeAnalysis => '筆順・筆画の分析';

  @override
  String get excellentWork => '素晴らしい出来栄えです！';

  @override
  String get keepPracticing => 'この調子で練習を続けましょう！';

  @override
  String get drawingSubmitted => '文字を提出しました';

  @override
  String get customPersonaHint => 'カスタムペルソナを設定...';

  @override
  String get stepOneOrigin => 'ステップ1：起源';

  @override
  String get stepTwoForge => 'ステップ2：鍛造';

  @override
  String get toForge => '鍛造する文字';

  @override
  String get whatEssenceDoesNeed => 'どの本質が必要ですか';

  @override
  String get need => '必要';

  @override
  String get forged => '鍛造完了';

  @override
  String get stepThreeHunt => 'ステップ3：文字探し';

  @override
  String get findCharactersWith => '次の要素を含む漢字を探す：';

  @override
  String get uninstallButton => 'アンインストール';

  @override
  String get gradedAiStories => 'レベル別AIストーリー';

  @override
  String get calligraphy => '書道・筆順';

  @override
  String get theScrollOfOrigin => '起源の巻物';

  @override
  String get galaxyOf => '〜の銀河';

  @override
  String get constellationDescription => '星座の解説';

  @override
  String get noRadicalDataAvailable => '利用可能な部首データがありません';

  @override
  String get learningPreferences => '学習設定';

  @override
  String get hardMode => 'ハードモード';

  @override
  String get hardModeDesc => '補助ガイドなしで正確な運筆が求められます。';

  @override
  String get adaptiveGuidance => 'アダプティブガイド';

  @override
  String get dailyGoal => '毎日の目標';

  @override
  String get audioAndHaptics => 'オーディオと触覚フィードバック';

  @override
  String get autoPlayAudio => '音声の自動再生';

  @override
  String get autoPlayDesc => 'カード表示時に発音音声を自動で再生します。';

  @override
  String get haptics => '触覚フィードバック';

  @override
  String get displayAndContent => '表示とコンテンツ';

  @override
  String get useEnglishDefinitions => '英語の語義を表示';

  @override
  String get useEnglishDefinitionsDesc => '英語の解説は語彙のニュアンスがより詳細に記載されています';

  @override
  String get animationSpeed => 'アニメーション速度';

  @override
  String get manageTomes => '書物の管理';

  @override
  String get manageTomesDesc => 'インストール済みの学習書物を管理します。';

  @override
  String get dangerZone => '危険ゾーン';

  @override
  String get resetAllData => 'すべてのデータをリセット';

  @override
  String get resetDataDesc => '学習進捗、統計、設定を含むすべてのデータが完全に削除されます。この操作は取り消せません。';

  @override
  String get areYouSure => '本当によろしいですか？';

  @override
  String get cannotBeUndone => '元に戻すことはできません';

  @override
  String get deleteEverything => 'すべて削除する';

  @override
  String get appLanguage => 'アプリの言語';

  @override
  String get howDidYouDo => '手応えはいかがでしたか？';

  @override
  String get missedItEntirely => '全く思い出せなかった';

  @override
  String get gotItButStruggled => '思い出すのに苦労した';

  @override
  String get gotItClearly => 'しっかり覚えていた';

  @override
  String get perfectAndImmediate => '即座に完璧に答えられた';

  @override
  String get again => 'もう一度';

  @override
  String get hard => '難しい';

  @override
  String get good => '普通';

  @override
  String get easy => '簡単';

  @override
  String get tapToReveal => 'タップして答えを表示';

  @override
  String get howWellDidYouRemember => 'どれくらい記憶していましたか？';

  @override
  String get completelyForgot => '完全に忘れていた';

  @override
  String get gotItWithDifficulty => 'なんとか思い出した';

  @override
  String get recalledCorrectly => '正しく思い出せた';

  @override
  String get perfectRecall => '完璧に記憶していた';

  @override
  String get practiceWriting => '手書き練習';

  @override
  String get hideScratchpad => '練習用キャンバスを隠す';

  @override
  String get whatCharacterMeans => '漢字の意味:';

  @override
  String get tapCardToReveal => 'カードをタップして裏面を表示';

  @override
  String get ratePronunciationConfidence => '発音の自信度を選択してください';

  @override
  String get botchedIt => '全くダメだった';

  @override
  String get struggledWithTones => '声調に苦戦した';

  @override
  String get acceptable => 'おおむね良好';

  @override
  String get perfectlyNatural => '完璧で極めて自然';

  @override
  String get sessionComplete => 'セッション完了！';

  @override
  String get accuracy => '正答率';

  @override
  String get reviewed => '復習済み';

  @override
  String get correct => '正解！';

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
  String get liveTranslation => 'リアルタイム通訳';

  @override
  String get scholarsLibrary => '学者の書庫';

  @override
  String get generate => '生成';

  @override
  String get searchPinyinHanziEnglish => 'ピンイン、漢字、日本語で検索...';

  @override
  String get liveTranslate => 'リアルタイム翻訳';

  @override
  String get travelInterpreter => 'トラベル通訳';

  @override
  String get realTimeSplitScreen => 'ネイティブとの分割画面リアルタイム対話。言葉の壁を瞬時に解消します。';

  @override
  String get whisperEarpiece => 'リアルタイム音声字幕';

  @override
  String get listenToChineseAudio => '中国語音声を聞き取りながら、画面上にリアルタイムで日本語字幕を表示します。';

  @override
  String get dashboardTitle => 'ダッシュボード';

  @override
  String get yourMindIsClear => '今日の課題はすべて完了しています！';

  @override
  String get noReviewsDueToday => '本日予定されている復習はありません。';

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
  String cardsRequireAttention(Object count) {
    return '$count枚のカードに復習が必要です。';
  }

  @override
  String get begin => 'スタート';

  @override
  String get poweredByAi => '最先端AIを搭載。あらゆる場面でスムーズなリアルタイム翻訳を提供します。';

  @override
  String get downloadingModel => 'AIモデルをダウンロード中...';

  @override
  String get soon => '近日公開';

  @override
  String get installed => 'インストール済み';

  @override
  String get premium => 'プレミアム';

  @override
  String get coreModule => 'コアモジュール';

  @override
  String get step6Context => 'ステップ6：文脈・例文';

  @override
  String get tapBuildingBlocksTo => '構成パーツをタップして、その漢字の成り立ちを探りましょう。';

  @override
  String get initiateRadicalSequence => '部首シークエンスを開始';

  @override
  String get holdToTalk => '長押しして話す';

  @override
  String get customScenario => 'カスタムシナリオ';

  @override
  String get voiceCall => '音声通話';

  @override
  String get pronunciation => '発音';

  @override
  String get selectAScenarioTo => 'シナリオを選択して中国語会話を練習しましょう。AI学者が声調と明瞭さを評価します。';

  @override
  String get create => '作成';

  @override
  String get createYourScenario => 'シナリオを作成';

  @override
  String get difficulty => '難易度';

  @override
  String get scholarsVerdict => '学者の判定';

  @override
  String get completeReview => '復習を完了する';

  @override
  String get conversationReview => '会話の振り返り';

  @override
  String get linguisticAnalysis => '言語学的分析';

  @override
  String get examplesInHsk1 => 'HSK 1級での用例';

  @override
  String get characterReference => '漢字リファレンス';

  @override
  String get askTutor => 'チューターに質問';

  @override
  String get addToStudyDeck => '学習デッキに追加';

  @override
  String get startPractice => '練習を開始';

  @override
  String get noOtherHsk1 => 'この部首を持つ他のHSK 1級の漢字はありません。';

  @override
  String get couldNotLoadAi =>
      'AIコンテンツを読み込めませんでした（利用制限または通信エラー）。\n下の更新ボタンをタップして再試行してください。';

  @override
  String get noAvailableCardsFound => '利用可能なカードがありません。';

  @override
  String get addCards => 'カードを追加';

  @override
  String get removeCard => 'カードを削除';

  @override
  String get remove => '削除';

  @override
  String get review => '復習';

  @override
  String get story => 'ストーリー';

  @override
  String get thisDeckIsEmpty => 'このデッキは空です。';

  @override
  String get tapTheAddCards => '「カードを追加」ボタンをタップしてください！';

  @override
  String get noCardsFound => 'カードが見つかりません。';

  @override
  String get addCardsToSee => 'カードを追加して学習統計を表示しましょう。';

  @override
  String get aiGenerated => 'AI生成';

  @override
  String get allCardsCaughtUp => 'すべてのカードの復習が完了しました！素晴らしい達成です。';

  @override
  String get latestDiscoveries => '最近の発見';

  @override
  String get noCharactersInLexicon => '辞書に登録された漢字はまだありません。';

  @override
  String get yourBookshelf => 'あなたの本棚';

  @override
  String get text_1782026184579 => '字';

  @override
  String get searchYourDictionary => '登録辞書を検索...';

  @override
  String get saveCard => 'カードを保存';

  @override
  String get noCharactersFound => '漢字が見つかりません。';

  @override
  String get radicalsIndex => '部首インデックス';

  @override
  String get masteringRadicalsIsThe =>
      '部首のマスターこそが、何千もの漢字を読み解く鍵です。部首を選んで関連する漢字を確認しましょう。';

  @override
  String get noRadicalsFound => '部首が見つかりません。';

  @override
  String get yourDrawing => 'あなたの筆跡';

  @override
  String get reference => 'お手本';

  @override
  String get rateYourRecall => '記憶の定着度を評価';

  @override
  String get contactUs => 'お問い合わせ';

  @override
  String get reportBugsOrRequest => '不具合の報告や新機能のリクエスト';

  @override
  String get allDataHasBeen => 'すべてのデータが消去されました。';

  @override
  String get hanziMasterV100 => 'SinoSpark v1.0.0';

  @override
  String get myProgress => '学習の進捗';

  @override
  String get overview => '概要';

  @override
  String get aiStory => 'AIストーリー';

  @override
  String get usingYourDecksVocabulary => 'デッキ内の語彙を使用中';

  @override
  String get tryAgain => 'もう一度';

  @override
  String get translate => '翻訳';

  @override
  String get pinyin => 'ピンイン';

  @override
  String get fullTranslation => '全文翻訳';

  @override
  String get geminiFlashIsStructuring => 'Gemini Flashがストーリーを構築中...';

  @override
  String get aiDeckGenerator => 'AIデッキジェネレーター';

  @override
  String get whatDoYouWant => '何を学びたいですか？';

  @override
  String get targetDifficulty => '目標難易度';

  @override
  String get focusArea => '重点分野';

  @override
  String get specificContextOrTone => '特定のシチュエーションやトーン（任意）';

  @override
  String get numberOfCards => 'カード枚数';

  @override
  String get generateDeck => 'デッキを生成';

  @override
  String get aiGrammarExplanation => 'AI文法解説';

  @override
  String get scholarsDesk => '学者の机';

  @override
  String get chooseADeck => 'デッキを選択';

  @override
  String get whereWouldYouLike => 'この漢字をどこに保存しますか？';

  @override
  String get addToDefaultStudy => 'デフォルトの学習デッキに追加';

  @override
  String get ifOffItsOnly => 'オフの場合、グローバル辞書にのみ保存されます';

  @override
  String get saveToLibrary => 'ライブラリに保存';

  @override
  String get pleaseEnterValidChinese => '有効な中国語の漢字を入力してください';

  @override
  String get reviewAiCard => 'AIカードの確認';

  @override
  String get pleaseDoublecheckTheAis =>
      'AIの出力内容をご確認ください。保存前にピンインや意味を自由に編集できます。';

  @override
  String get alreadyInYourLibrary => 'すでにライブラリに登録されています！';

  @override
  String get meaningInContext => '文脈での意味';

  @override
  String get explainGrammar => '文法を解説';

  @override
  String get addToLibrary => 'ライブラリに追加';

  @override
  String get masterYourMandarinPronunciation =>
      'ネイティブの発音をリアルタイムで真似ることで、正確な中国語の発音を身につけましょう。';

  @override
  String get startSession => 'セッションを開始';

  @override
  String get sessionHistory => 'セッション履歴';

  @override
  String get noSavedSessions => '保存されたセッションはありません。';

  @override
  String get aiBreakdown => 'AI詳細分析';

  @override
  String get sessionDetails => 'セッション詳細';

  @override
  String partner(Object lang) {
    return '対話パートナー ($lang)';
  }

  @override
  String get youEnglish => 'あなた（日本語）';

  @override
  String get noTranscriptToSave => '保存する文字起こしデータがありません！';

  @override
  String get sessionSaved => 'セッションを保存しました！';

  @override
  String get realtimeBidirectionalTranslationSpeak =>
      'リアルタイム双方向翻訳。日本語または中国語で話しかけると、瞬時にお互いの言語へ翻訳されます。';

  @override
  String get text_1782026184665 => '録音中';

  @override
  String get recording => '録音中';

  @override
  String get yourSilentCompanionListen =>
      'あなたの頼れる語学パートナー。中国語を聞き取ると、リアルタイムで日本語訳を表示します。';

  @override
  String get startListening => '聞き取りを開始';

  @override
  String get skip => 'スキップ';

  @override
  String get independentStars => '単独文字（独体字）';

  @override
  String get notEveryCharacterHas =>
      'すべての漢字に親となる部首があるわけではありません。一部は独自の成り立ちを持つ象形文字です。';

  @override
  String get onTheMapWe => 'マップ上では、これらの独立した文字を「星座（✨）」として分類しています。';

  @override
  String get iUnderstand => '理解しました';

  @override
  String get whatAreRadicals => '部首とは？';

  @override
  String get hanziAreBuiltFrom =>
      '漢字は「部首」と呼ばれるパーツから成り立っています。\n\n部首は漢字の中核となる意味やテーマを示します。';

  @override
  String get continueText => '次へ進む';

  @override
  String get hanziAreNotJust =>
      '漢字は単なる文字ではなく、古代の情景が凝縮された絵画です。\n\n習得するには、筆の運びと線の流れを掴むことが大切です。';

  @override
  String get iAmReady => '準備完了';

  @override
  String get youAreAScholar => 'あなたは学問の探求者です';

  @override
  String get theGalaxyMapAwaitsnmaster =>
      '銀河マップがあなたを待っています。\n太陽（部首）をマスターして惑星（漢字）をアンロックしましょう。';

  @override
  String get enterTheScroll => '巻物を開く';

  @override
  String get openingTheOriginScroll => '起源の巻物を紐解いています...';

  @override
  String get text_1782026184670 => '+';

  @override
  String get theScholarsEdition => '学者エディション';

  @override
  String get weArePreparingThe => '学者エディションの公開準備を進めています。';

  @override
  String get devBypassUnlockNow => '開発者バイパス：今すぐアンロック';

  @override
  String get restorePurchases => '購入を復元';

  @override
  String get welcomeScholarTheScroll => 'ようこそ、探求者よ。巻物はすべてあなたに開かれています。';

  @override
  String get purchasesRestoredSuccessfully => '購入情報が正常に復元されました。';

  @override
  String get noPreviousPurchasesFound => 'このアカウントでの購入履歴は見つかりませんでした。';

  @override
  String get unlockTheFullPotential => '学びの可能性を最大限に解放しましょう。一度の購入で永久にご利用いただけます。';

  @override
  String get universalScanner => '万能スキャナー';

  @override
  String get noChineseCharactersFound => '画像内に中国語の文字が見つかりませんでした。';

  @override
  String get addedNewCharactersTo => '新しい漢字をライブラリに追加しました！';

  @override
  String get extractingTextAndObjects => 'テキストとオブジェクトを抽出中...';

  @override
  String get scanATextbookSign => '教科書、看板、身の回りの物をスキャンして漢字を抽出します。';

  @override
  String get extractedText => '抽出されたテキスト';

  @override
  String get useText => 'このテキストを使用';

  @override
  String get noMatchingDictionaryEntries => '一致する辞書項目が見つかりませんでした。';

  @override
  String get quizComplete => 'クイズ完了！';

  @override
  String get returnToCourse => 'コースに戻る';

  @override
  String get notEnoughCardsFor => 'クイズを開始するカードが足りません（最低4枚必要です）。';

  @override
  String get creatorMode => 'クリエイターモード';

  @override
  String get noStoriesFoundMatching => '検索条件に一致するストーリーが見つかりませんでした。';

  @override
  String get discard => '破棄';

  @override
  String get save => '保存';

  @override
  String get generatingStoryViaDeepseek => 'DeepSeekを通じてストーリーを生成中...';

  @override
  String get storySavedToLibrary => 'ストーリーがライブラリに保存されました！';

  @override
  String get storyNotFound => 'ストーリーが見つかりません。';

  @override
  String get targetHskLevel => '目標HSKレベル';

  @override
  String get wedLoveToHear => 'ご意見・ご要望をお聞かせください！';

  @override
  String get whetherYouveFoundA =>
      '不具合の報告、新機能のご提案、ご感想など、皆様からのフィードバックがSinoSparkの進化につながります。';

  @override
  String get pointYourCameraAt => 'カメラを対象物に向けてください';

  @override
  String get reviewAddToLibrary => '確認してライブラリに追加';

  @override
  String hideStrokeGuideStreak(Object streak) {
    return '$streak回連続正解で書き順ガイドを非表示';
  }

  @override
  String inkPoints(Object points) {
    return '$points インクポイント';
  }

  @override
  String speechRateMultiplier(Object rate) {
    return '$rate倍';
  }

  @override
  String animationSpeedMultiplier(Object rate) {
    return '$rate倍';
  }

  @override
  String get supportAndFeedback => 'サポート＆フィードバック';

  @override
  String get reportBug => '不具合を報告';

  @override
  String get suggestFeature => '新機能をリクエスト';

  @override
  String get generalFeedback => '一般的なご意見・ご感想';

  @override
  String get pleaseDrawSomethingFirst => 'まずキャンバスに文字を描いてください';

  @override
  String get drawThisCharacter => 'この漢字を書いてみましょう：';

  @override
  String followGuideStroke(Object current, Object total) {
    return '青いガイドに従って、全$total画中 $current画目を描きましょう';
  }

  @override
  String get skipCurrentStroke => '現在の画をスキップ';

  @override
  String get submitDrawing => '判定する';

  @override
  String addedToDeck(Object deckName, Object hanzi) {
    return '「$hanzi」を「$deckName」に追加しました';
  }

  @override
  String removedFromDeck(Object hanzi) {
    return '「$hanzi」をデッキから削除しました';
  }

  @override
  String skippedNoStrokeData(Object hanzi) {
    return '「$hanzi」をスキップしました（この文字には筆順データがありません）。';
  }

  @override
  String get startingSession => 'セッションを開始中...';

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
  String get newLabel => '新着';

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
  String get masterBuildingBlocks => '漢字の構成要素をマスターしよう';

  @override
  String get totalWords => '総語彙数';

  @override
  String get newInk => '獲得インク';

  @override
  String get learningStatus => '学習中';

  @override
  String get masteredStatus => '習得済み';

  @override
  String get libraryMastery => 'ライブラリ習熟度';

  @override
  String get accuracyByMode => 'モード別正答率';

  @override
  String get upcomingReviews => '今後の復習（今後7日間）';

  @override
  String get culturalReadingRoom => '文化書房';

  @override
  String storyTitleHsk(Object level, Object title) {
    return '$title (HSK $level級)';
  }

  @override
  String get pleaseEnterTopic => 'トピックを入力してください';

  @override
  String createdDeckCards(Object count, Object name) {
    return 'デッキ「$name」（$count枚）を作成しました！';
  }

  @override
  String gradeResult(Object grade) {
    return '評価: $grade';
  }

  @override
  String get listeningMode => 'リスニングモード';

  @override
  String get readingMode => 'リーディングモード';

  @override
  String get recallMode => 'リコール（想起）モード';

  @override
  String get speakingMode => 'スピーキングモード';

  @override
  String get aiMemoryHook => 'AI記憶フック（語呂合わせ・由来）';

  @override
  String get exampleSentences => '例文';

  @override
  String get ghostCharacters => 'ガイド文字（透かし）';

  @override
  String get commonWords => '頻出語彙';

  @override
  String get personalNotes => 'マイノート';

  @override
  String get addPersonalNotes => '覚え方のコツやメモをここに入力...';

  @override
  String get takePhoto => '写真を撮る';

  @override
  String get gallery => '写真から選択';

  @override
  String get arLens => 'ARレンズ';

  @override
  String addedCharToLibrary(Object char) {
    return '「$char」をライブラリに追加しました';
  }

  @override
  String get scoreText => 'スコア';

  @override
  String get searchDictionaryHint => '漢字、ピンイン、意味で検索...';

  @override
  String get searchDeckHint => 'デッキ内の漢字、ピンインを検索...';

  @override
  String get localRestaurant => '街のローカル食堂';

  @override
  String get taxiToAirport => '空港へタクシーで向かう';

  @override
  String get silkMarketHaggling => 'シルクマーケットでの値切り交渉';

  @override
  String get medicalClinic => 'クリニック・診療所';

  @override
  String get meetingAFriend => '友人との待ち合わせ';

  @override
  String get jobInterview => '採用面接';

  @override
  String get searchRadicalsHint => '部首を検索（例：水、氵）';

  @override
  String get definition => '語義・解説';

  @override
  String get undo => '元に戻す';

  @override
  String get hanziMaster => 'SinoSpark';

  @override
  String get unlockForever => '永久アンロック - \$9.99';

  @override
  String get clear => 'クリア';

  @override
  String get clearChat => 'チャット履歴を消去';

  @override
  String get typeMessage => 'メッセージを入力...';

  @override
  String addedToLibrary(Object hanzi) {
    return '「$hanzi」をライブラリに追加しました';
  }

  @override
  String get generateNewStory => '新しいストーリーを生成';

  @override
  String failedToGenerateStory(Object error) {
    return 'ストーリーの生成に失敗しました:\n$error';
  }

  @override
  String get detail => '詳細';

  @override
  String get scanText => 'テキストをスキャン';

  @override
  String get createMagic => 'AIで作成';

  @override
  String get learning => '学習中';

  @override
  String get upcomingReviews7Days => '今後の復習（今後7日間）';

  @override
  String get askFollowUpQuestion => 'さらに質問する...';

  @override
  String get pasteScanToSimplify => '中国語の文章を貼り付けまたはスキャンして平易化する';

  @override
  String get searchStoriesHint => 'タイトルやタグで物語を検索（例：神話、旅行）';

  @override
  String get importAll => 'すべてインポート';

  @override
  String get ascendAll => 'すべて昇格';

  @override
  String get startAscension => '習熟ステップを開始';

  @override
  String get scenarioLocalRestaurant => 'ローカル食堂';

  @override
  String get scenarioLocalRestaurantDesc => '料理を注文し、おすすめのメニューを尋ねる練習をします。';

  @override
  String get scenarioTaxiAirport => '空港へ向かうタクシー';

  @override
  String get scenarioTaxiAirportDesc => '運転手に行き先を伝え、交通状況について話します。';

  @override
  String get scenarioSilkMarket => 'シルクマーケットでの値切り交渉';

  @override
  String get scenarioSilkMarketDesc => 'お土産の値段交渉をする練習をします。';

  @override
  String get scenarioMedicalClinic => 'クリニック・診療所';

  @override
  String get scenarioMedicalClinicDesc => '漢方医（中医師）に自覚症状を説明します。';

  @override
  String get scenarioMeetingFriend => '友人との待ち合わせ';

  @override
  String get scenarioMeetingFriendDesc => '近況を報告し合って世間話をします。';

  @override
  String get scenarioJobInterview => '採用面接';

  @override
  String get scenarioJobInterviewDesc => '上海のIT・ハイテク企業の採用面接を受けます。';

  @override
  String get createCustomScenario => 'カスタムシナリオを作成';

  @override
  String get customScenarioTitleHint => 'タイトル（例：結婚披露宴）';

  @override
  String get customScenarioDescHint => 'シチュエーション・背景の説明';

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
  String get idiomsTitle => '成語・慣用句（成语）';

  @override
  String get theMonkeyKing => '孫悟空';

  @override
  String get theMonkeyKingDesc => '孫悟空（西遊記）';

  @override
  String get huaMulan => '花木蘭（ムーラン）';

  @override
  String get huaMulanDesc => '父の代わりに軍に入隊する花木蘭の物語';

  @override
  String get confuciusTitle => '孔子';

  @override
  String get confuciusDesc => '孔子の生涯と教え';

  @override
  String get theGreatWall => '万里の長城';

  @override
  String get theGreatWallDesc => '万里の長城の建設とその歴史';

  @override
  String get generateTopic => 'トピックを生成';

  @override
  String get simplifyText => '文章を平易化';

  @override
  String get topicHint => 'トピック（例：北京の宇宙人）';

  @override
  String get tagsHint => 'タグ（カンマ区切り、任意）';

  @override
  String get speakWithMasterLin => '林（リン）先生と話す';

  @override
  String get masterLinGreeting => 'よく来ましたね。墨の準備は整っています。本日はどの文字や表現について探求しましょうか？';

  @override
  String get typeYourMessage => 'メッセージを入力...';

  @override
  String get theMainLibrary => 'メインライブラリ';

  @override
  String get hsk1Foundation => 'HSK 1級: 基礎';

  @override
  String get hsk2Elementary => 'HSK 2級: 初級';

  @override
  String get hsk3Intermediate => 'HSK 3級: 中級';

  @override
  String get inDeckCheck => 'デッキ内 ✓';

  @override
  String get addToDeckPlus => '+ デッキに追加';

  @override
  String get openCardArrow => 'カードを開く →';

  @override
  String get pronunciationPartial => '声調が不正確';

  @override
  String get pronunciationWrong => '不正解';

  @override
  String get toneExpected => '正しい声調';

  @override
  String get toneYouSaid => '発音した声調';

  @override
  String get gotIt => '了解！';

  @override
  String foundNCharacters(int count) {
    return '$count文字見つかりました';
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
  String get duration12Min => '所要時間：1〜2分';

  @override
  String get aClassicTangDynastyPoem => '唐詩の名作';

  @override
  String get aClassicTangDynastyPoemBy => '〜による唐詩の名作';

  @override
  String get aStructuralComponent => '構造パーツ（部首・構成要素）';

  @override
  String get addSelectedToDeck => '選択した項目をデッキに追加';

  @override
  String addTo(Object target) {
    return '〜に追加: ';
  }

  @override
  String addedHanziToYourLibrary(String hanzi) {
    return '「$hanzi」をライブラリに追加しました';
  }

  @override
  String get adjustFontSize => 'フォントサイズを調整';

  @override
  String get againGoodEasyHard => '⬅️ もう一度    ➡️ 正解    ⬆️ 簡単    ⬇️ 難しい';

  @override
  String get aiAnalysisFailed => 'AI分析に失敗しました';

  @override
  String get aiIsThinking => 'AIが思考中…';

  @override
  String get aiSceneAnalysisFailed => 'AIによるシーン分析に失敗しました';

  @override
  String get allLabel => 'すべて';

  @override
  String get allPinyin => 'すべてのピンイン';

  @override
  String get alreadyHaveAccountSignIn => 'すでにアカウントをお持ちですか？ ログイン';

  @override
  String get analysisFailed => '分析失敗：';

  @override
  String get analyzingClassicalCharacters => '古典文字を分析中…';

  @override
  String get anatomy => '解剖・構成分析';

  @override
  String get ancientPhilosophy => '古代哲学';

  @override
  String get articleSavedToMediaHub => '記事をメディアハブに保存しました！';

  @override
  String get askAFollowUp => 'さらに詳しく質問する…';

  @override
  String get audioPrivacyAndHowThingsWork => '音声機能、プライバシー、仕組みについて';

  @override
  String get audiobookPlayer => 'オーディオブックプレーヤー';

  @override
  String get audiobookVoice => 'オーディオブックの音声';

  @override
  String get auntieMaTown =>
      '馬おばさん（马阿姨）：威勢の良い屋台の店主。街で一番サクサクの肉夾饃（ロージャーモー）と涼皮（リャンピー）を作る。';

  @override
  String get back => '戻る';

  @override
  String get baristaKevinNotes =>
      'バリスタの小凱（小凯）：雲南省産コーヒー豆の風味やテイスティングノートについて熱く語る情熱的な若き焙煎士。';

  @override
  String get bbc => 'BBC 中国語ニュース';

  @override
  String get beginYourJourney => '学習を始める';

  @override
  String get bestValue => '一番人気・お得';

  @override
  String get bookLinkCopiedToClipboard => '本のリンクをクリップボードにコピーしました！';

  @override
  String get bookmarkChapter => 'この章をブックマーク';

  @override
  String get bookmarks => 'ブックマーク';

  @override
  String get books => '書籍';

  @override
  String get briefing => '要約・ブリーフィング';

  @override
  String get bugReport => 'バグ報告';

  @override
  String get caoXueqinDecline =>
      '曹雪芹（1715年頃〜1763年）は清朝の小説家。かつて栄華を極めた旗人の名家に生まれるも、雍正帝の時代に没落。困窮した晩年に執筆された『紅楼夢』は、貴族社会の衰退を緻密な心理描写で描き切った中国古典文学の最高峰と称される。';

  @override
  String get cardsTitle => 'カード';

  @override
  String get cc => '字幕（CC）';

  @override
  String get characterOrWord => '漢字 / 単語';

  @override
  String get chatMore => '会話を続ける';

  @override
  String get chefChenShumai =>
      '陳シェフ（陈师傅）：陽気な広東点心シェフ。できたてのエビ蒸し餃子（ハーガオ）と焼売（シューマイ）がおすすめ。';

  @override
  String get chineseEpics => '中国の古典叙事詩';

  @override
  String get chinesePoetry => '漢詩・中国詩';

  @override
  String get chng => 'chéng';

  @override
  String get chongqingSpicyHotpotFeast => '重慶麻辣火鍋の宴';

  @override
  String get chooseAudiobookVoice => 'オーディオブックの音声を選択';

  @override
  String get chooseVoice => '音声を選択';

  @override
  String get compare => '比較';

  @override
  String get compare4Tones => '四声の比較';

  @override
  String get configuration => '設定';

  @override
  String get contemporary => '現代・コンテンポラリー';

  @override
  String get context => '文脈・コンテキスト';

  @override
  String get couldNotLoadLibrary => 'ライブラリを読み込めませんでした';

  @override
  String get couldNotLoadVocabulary => '単語データを読み込めませんでした。';

  @override
  String get couldNotOpenEmailApp => 'メールアプリを開けませんでした。';

  @override
  String get createAccount => 'アカウント作成';

  @override
  String get createNewDeck => '新規デッキを作成';

  @override
  String get createScenario => 'シナリオを作成';

  @override
  String get createStory => 'ストーリーを作成';

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
  String get deleteScenario => 'シナリオを削除';

  @override
  String get deletesAllProgressPermanently => 'すべての学習進捗を完全に消去します';

  @override
  String get developerBackdoorUnlocked => '開発者用メニューを解除しました！';

  @override
  String get doesNotExistInChinese => '中国語に該当する表現がありません';

  @override
  String get dontHaveAccountSignUp => 'アカウントをお持ちでないですか？ 新規登録';

  @override
  String get draftingStoryOutline => 'ストーリーのアウトラインを作成中…';

  @override
  String get dynamicFlowState => 'ダイナミック・フロー状態';

  @override
  String get dynamicFlowStateParenthetical => '動的（フロー状態）';

  @override
  String get editCard => 'カードを編集';

  @override
  String get egAnimeVocab => '例：アニメの語彙';

  @override
  String get egFormalBusinessLanguageSlangForTexting =>
      '例：フォーマルなビジネス表現、SNSのスラング…';

  @override
  String get egOrderingAtARestaurantBusinessVocab => '例：レストランでの注文、ビジネス中国語…';

  @override
  String get egWeddingReceptionTechInterview => '例：結婚披露宴でのスピーチ、技術面接…';

  @override
  String get emailLabel => 'メールアドレス';

  @override
  String get english => '英語';

  @override
  String get englishAndWorld => '英語・世界文学';

  @override
  String get episodes => 'エピソード';

  @override
  String get erase => '消去';

  @override
  String get eraseDeckQuestion => 'デッキを消去しますか？';

  @override
  String errorFetchingTranslationForLabelE(String label, String e) {
    return '$labelの翻訳取得エラー：$e';
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
  String get exitFocus => '集中モードを終了';

  @override
  String get explore => '探索';

  @override
  String get exportToThisDeck => 'このデッキにエクスポート';

  @override
  String get extractAndSimplify => '抽出して平易化';

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
  String get finalizingStoryDetails => 'ストーリーの詳細を仕上げ中…';

  @override
  String get firebaseAuthConsole =>
      'Firebase認証が無効です。Firebaseコンソールで必要なログイン方法を有効にしてください。';

  @override
  String get flashcardDeckTitle => 'フラッシュカードデッキ';

  @override
  String get focus => '集中モード';

  @override
  String get foodAndCooking => '料理・グルメ';

  @override
  String get forward => '進む';

  @override
  String get freeFlow => 'フリーフロー';

  @override
  String get frenchClassics => 'フランス古典';

  @override
  String get full => '全体';

  @override
  String get gamingAndEsports => 'ゲーム＆eスポーツ';

  @override
  String get germanClassics => 'ドイツ古典';

  @override
  String get ghostPinyin => 'ガイドピンイン';

  @override
  String get goodAttempt => '惜しい！良い試みです';

  @override
  String get gotItSimple => '了解';

  @override
  String get grammar => '文法';

  @override
  String get grandmaLiuFilling =>
      '劉おばあちゃん（刘奶奶）：心優しい北国の祖母。水餃子の綺麗な包み方と豚肉と長ネギの餡の作り方を教えてくれる。';

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
  String get hideEnglishTranslations => '英語の訳文を非表示';

  @override
  String get hidePinyin => 'ピンインを非表示';

  @override
  String get highlight => 'ハイライト';

  @override
  String get howWouldYouLikeToStudy => 'どのように学習を進めますか？';

  @override
  String get hsk1 => 'HSK 1級';

  @override
  String get hsk4UpperIntermediate => 'HSK 4級：中上級';

  @override
  String get hsk5Advanced => 'HSK 5級：上級';

  @override
  String get hsk6Mastery => 'HSK 6級：マスター';

  @override
  String get hskCollections => 'HSKコレクション';

  @override
  String hskLevel(String level) {
    return 'HSK $level級';
  }

  @override
  String get hskSimplifySubtitles => 'HSK向け字幕平易化';

  @override
  String get hskVocabularyCollections => 'HSK語彙コレクション';

  @override
  String get i => '私';

  @override
  String get ifTheAgain =>
      'AIが意図の不一致を検知した場合、「〜と言おうとしましたか？」と尋ねます。「はい、再判定してください！」をタップすると、再度発話することなく元の録音から即座に再評価を受けられます。';

  @override
  String get install => 'インストール';

  @override
  String get just => 'わずか \$';

  @override
  String get keyword => 'キーワード';

  @override
  String get knowledgeBase => 'ナレッジベース';

  @override
  String get liRuzhenSubjects =>
      '李汝珍（1763年頃〜1830年）は音韻論、囲碁、宇宙論に精通した清朝の学者。奇想天外な異国を旅する幻想小説『鏡花縁』は、フェミニズム的な先駆的テーマと百科全書的な博識さで高く評価されている。';

  @override
  String get library => '文化書房ライブラリ';

  @override
  String get lifestyleAndVlog => 'ライフスタイル＆Vlog';

  @override
  String get listenInAudiobookMode => 'オーディオブックモードで聴く';

  @override
  String get listenToThisWord => 'この単語の発音を聴く';

  @override
  String get listening => '聞き取り中…';

  @override
  String get liuEEncroachment =>
      '劉鶚（1857〜1909年）は清末の知識人（技術者・医師・小説家）。代表作『老残遊記』は、王朝末期の動乱と列強の進出に揺れる中国を巡る放浪医の旅を描いた、抒情性と政治的批評性に満ちた名作紀行小説。';

  @override
  String get loadingTranslations => '翻訳を読み込み中…';

  @override
  String get luXunVernacular =>
      '魯迅（1881〜1936年、本名・周樹人）は中国現代文学の父。医学を志すも、国民の精神を救うため筆を執った。『狂人日記』や『阿Q正伝』などの短編小説を通じ、白話（口語体）による文学革命を主導した。';

  @override
  String get luoGuanzhongEpic =>
      '羅貫中（1330年頃〜1400年）は元末明初の劇作家・小説家。施耐庵に師事したとされる。正史・民間伝承・講談の妙味を昇華させた『三国志演義』は、中国歴史叙事詩の最高傑作として親しまれている。';

  @override
  String get makeACustomCollection => 'カスタムコレクションを作成';

  @override
  String get manageDailyDropsAndReviewReminders => 'デイリードロップと復習リマインダーの設定';

  @override
  String get managerYuOptions =>
      '余店長（余店长）：熱血な火鍋店長。名物のセンマイや鴨血、さっぱりとした白湯スープなどを提案してくれる。';

  @override
  String get masterGaoRubs =>
      '高師傅（高师傅）：カリスマ炭火焼きマスター。秘伝のクミンスパイスや辛さの調整について気さくに相談に乗ってくれる。';

  @override
  String get masterThisToUnlockItsGalaxy => 'この要素を習得して銀河マップをアンロックしましょう。';

  @override
  String get masterZhaoBrewing =>
      '趙師傅（赵师傅）：穏やかで博識な茶芸師範。伝統的な工夫茶（ゴンフーチャ）の淹れ方を丁寧に指南してくれる。';

  @override
  String get mastery => '習熟度';

  @override
  String get maybeLater => 'あとで';

  @override
  String get memes => 'ミーム・トレンド';

  @override
  String get midnightBbqSkewersInWuhan => '武漢の深夜の炭火串焼き';

  @override
  String get mo => '/月';

  @override
  String get modernChinese => '現代中国語';

  @override
  String get monthly => '月額プラン';

  @override
  String get morningDimSumCartInGuangzhou => '広州の朝の飲茶ワゴン';

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
  String get noKeyWordsFoundForThisStory => 'このストーリーのキーワードが見つかりません。';

  @override
  String get noLabel => 'いいえ';

  @override
  String get noNewWordsFound => '新しい単語は見つかりませんでした！';

  @override
  String get noPinyin => 'ピンインなし';

  @override
  String get noPremiumPackagesAvailable => '現在利用可能なプレミアムプランはありません。';

  @override
  String noResultsFoundForSearchquery(String searchQuery) {
    return '「$searchQuery」に一致する結果は見つかりませんでした';
  }

  @override
  String get noSavedArticlesYet => '保存された記事はまだありません。';

  @override
  String get noShowsAvailable => '利用可能な番組がありません';

  @override
  String get noStoriesFound => 'ストーリーが見つかりません。';

  @override
  String get noWordsSelected => '単語が選択されていません';

  @override
  String get notes => 'メモ';

  @override
  String get notoserifsc => 'NotoSerifSC';

  @override
  String get objectivesTitle => '目標';

  @override
  String get openInYoutube => 'YouTubeで開く';

  @override
  String get orderingHanddripCoffeeInShanghai => '上海のカフェでハンドドリップコーヒーを注文';

  @override
  String get orderingSugarcoatedHawsInWinterBeijing => '冬の北京で糖葫芦（サンザシ飴）を買う';

  @override
  String partnerLang(String lang) {
    return 'パートナー（$lang）';
  }

  @override
  String get partnerListening => 'パートナーが聞き取り中…';

  @override
  String get partnerSpeaking => 'パートナーが発話中…';

  @override
  String get passwordLabel => 'パスワード';

  @override
  String get pause => '一時停止';

  @override
  String get perfect => '完璧！';

  @override
  String get personalizedPathBasedOnDeck => 'あなたのデッキに最適化された学習パス。';

  @override
  String play(Object pinyin) {
    return '発音を再生（$pinyin）';
  }

  @override
  String get pleaseEnterMessageBeforeSending => '送信するメッセージを入力してください。';

  @override
  String get practiceInRoleplay => 'ロールプレイで実践練習';

  @override
  String get practiceModes => '練習モード';

  @override
  String get practicePronouncingWithAiGrading => 'AI発音判定でこの単語を練習';

  @override
  String get preparingReadingInterface => '読書画面を準備中…';

  @override
  String get privacy => 'プライバシー';

  @override
  String get privacyAndAudio => 'プライバシーと音声';

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
      '蒲松齢（1640〜1715年）は清朝の短編小説家。科挙に度々落第するも、各地の民間伝承を収集し『聊斎志異』を完成させた。狐妖、幽霊、書生たちが織りなす怪異譚は、中国怪異文学の最高峰と謳われる。';

  @override
  String get qaFaq => 'よくある質問・FAQ';

  @override
  String get questsTitle => 'クエスト';

  @override
  String get quickBookmarks => 'クイックブックマーク';

  @override
  String get radical => '部首';

  @override
  String get ready => '準備完了';

  @override
  String get readyToInterpret => '通訳の準備完了';

  @override
  String get readyToStart => '開始できます。';

  @override
  String get recentBookmarks => '最近のブックマーク';

  @override
  String get refiningGrammar => '文法を推敲中…';

  @override
  String get refresh => '更新';

  @override
  String get removeFromSaved => '保存済みから削除';

  @override
  String get removeFromSavedScenarios => '保存済みシナリオから削除';

  @override
  String get removed => '削除完了';

  @override
  String get requestPermissions => '権限をリクエスト';

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
  String get reviewIn => '復習：';

  @override
  String get reviewingYourTones => '声調を評価中…';

  @override
  String get saveAll => 'すべて保存';

  @override
  String get saveScenario => 'シナリオを保存';

  @override
  String get saveThisScenario => 'このシナリオを保存';

  @override
  String get saved => '保存済み';

  @override
  String get scanAnother => '他の対象をスキャン';

  @override
  String get scenarioRemoved => 'シナリオを削除しました';

  @override
  String get scenarioSavedFindInCustomTab => 'シナリオを保存しました！「カスタム」タブから確認できます。';

  @override
  String score(Object score, Object total) {
    return 'スコア: $score / $total';
  }

  @override
  String get searchByPinyinOrMeaning => 'ピンインまたは意味で検索…';

  @override
  String get searchByTitleOrTag => 'タイトルまたはタグで検索…';

  @override
  String get searchDictionaryOrTypeCustom => '辞書を検索するか直接入力';

  @override
  String get searchHint => '検索…';

  @override
  String get searchOrEnterUrl => '検索またはURLを入力';

  @override
  String get searchScenariosHint => 'シナリオを検索…';

  @override
  String get searchStoriesIdiomsNews => 'ストーリー、成語、ニュースを検索…';

  @override
  String get searchTopicsEgCookingHistory => 'トピックを検索（例：料理、歴史）';

  @override
  String get seeAll => 'すべて見る';

  @override
  String get selectADeck => 'デッキを選択';

  @override
  String get selectPracticeMode => '練習モードを選択';

  @override
  String get selectingHskVocabulary => 'HSK語彙を選定中…';

  @override
  String get send => '送信';

  @override
  String get sendMessage => 'メッセージを送信';

  @override
  String get serif => '明朝体（セリフ）';

  @override
  String get shadow => 'シャドーイング';

  @override
  String get shiNaianEpic =>
      '施耐庵（1296年頃〜1372年）は元末明初の文人。科挙に合格するも仕官を退き、隠遁生活を送った。豪傑たちの反逆と絆を描いた『水滸伝』は、中国武侠・群像小説の不朽の金字塔となった。';

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
  String get simplifiedArticle => '平易化された記事';

  @override
  String get simplifyingSubtitles => '字幕を平易化中…';

  @override
  String get sincereHonest => '誠実・正直';

  @override
  String get sleepTimer => 'スリープタイマー';

  @override
  String get smartDeck => 'スマートデッキ';

  @override
  String get spanishAndWorld => 'スペイン語・世界文学';

  @override
  String get speaker => 'スピーカー';

  @override
  String get spotifyStylePlayer => 'Spotify風プレーヤー';

  @override
  String get storyBookmarkedInLibrary => 'ストーリーをライブラリに保存しました！';

  @override
  String get streetFoodNightMarketInXian => '西安の屋台夜市';

  @override
  String get strokes => '画数・ストローク';

  @override
  String get studyCharacter => '漢字を学ぶ';

  @override
  String get subtitleOpacity => '字幕の不透明度';

  @override
  String get suggestion => 'おすすめ・提案';

  @override
  String get summary => '要約';

  @override
  String get supernaturalAndFolklore => '怪異・民話';

  @override
  String get swipeToGrade => 'スワイプして評価：';

  @override
  String get tableOfContents => '目次';

  @override
  String get tapToRetry => 'タップして再試行';

  @override
  String get teaTastingInChengdu => '成都での伝統茶テイスティング';

  @override
  String get techAndGadgets => 'テクノロジー＆ガジェット';

  @override
  String get terms => '利用規約';

  @override
  String get theGalaxyCharacters =>
      '銀河マップがあなたを待っています。\n太陽（部首）をマスターして惑星（漢字）をアンロックしましょう。';

  @override
  String get theme => 'テーマ';

  @override
  String get thinking => 'AIが思考中…';

  @override
  String get thisArticleCharacters => 'この記事には繁体字中国語が含まれています。';

  @override
  String get todaysWord => '今日の単語';

  @override
  String get togglePinyin => 'ピンインの表示切替';

  @override
  String get toggleTranslation => '翻訳の表示切替';

  @override
  String get toneDoesNotExistInMandarin => 'この声調は標準中国語には存在しません。';

  @override
  String get toneGraph => '声調ピッチグラフ';

  @override
  String get traceLabel => 'なぞり書き';

  @override
  String get trailer => '予告編';

  @override
  String get translatingAndAddingPinyin => '翻訳およびピンインを付与中…';

  @override
  String get translatingText => 'テキストを翻訳中…';

  @override
  String get turnOn => 'オンにする';

  @override
  String get typeHanziPinyinOrEnglish => '漢字、ピンイン、または日本語を入力…';

  @override
  String get unknown2 => '游戏 实况 王者荣耀 原神';

  @override
  String get unknown3 => '中国 美食 菜谱';

  @override
  String get unknown4 => '中国 科技 测评';

  @override
  String get unrollingTheScroll => '巻物を開いています…';

  @override
  String get upperIntermediate => '中上級';

  @override
  String get vibrationsForInteractions => '操作時の触覚フィードバック';

  @override
  String get video => '動画';

  @override
  String get viewAnswer => '解答を見る';

  @override
  String get viewAsList => 'リスト表示';

  @override
  String get viewBookmarks => 'ブックマーク一覧';

  @override
  String get viewMyDrawing => '書いた文字を確認';

  @override
  String get vlog => '中国 日常 vlog';

  @override
  String get voice => '音声：';

  @override
  String get web => 'Web';

  @override
  String get wedLoveToHearFromYou => 'ご意見・ご感想を\nぜひお聞かせください。';

  @override
  String get welcomeBack => 'おかえりなさい';

  @override
  String get whatDoesThisMean => 'これはどういう意味ですか？';

  @override
  String get whatHappensToMyChatHistory => 'チャット履歴はどう管理されますか？';

  @override
  String get whatIfAiMishears => 'AIが意図した言葉を聞き間違えた場合は？';

  @override
  String get whichCharacterIs => '次の説明に当てはまる漢字はどれですか：';

  @override
  String get wikipedia => 'Wikipedia';

  @override
  String get wordsSavedAndSrsScheduled => '単語を保存し、SRS復習スケジュールを設定しました！';

  @override
  String get writeYourMessageHere => 'メッセージをここに入力…';

  @override
  String get wuChengenLiterature =>
      '呉承恩（1500年頃〜1582年）は明朝の小説家。民間伝承、仏教の寓話、卓越した風刺を融合させ、玄奘のインド巡礼伝説を『西遊記』という一大長編冒険譚へと結実させた。';

  @override
  String get wuJingziClass =>
      '呉敬梓（1701〜1754年）は清朝の小説家。世襲財産を放棄し、畢生の情熱を注いで『儒林外史』を著した。科挙制度の形骸化と知識人階級の虚飾・腐敗を痛烈かつユーモラスに暴いた諷刺文学の傑作。';

  @override
  String get xuZhonglinWarfare =>
      '許仲琳（16〜17世紀）は明朝の作家。『封神演義』の編纂者として知られ、殷周革命の史実に道教の仙界・神魔・超常的な戦闘を織り交ぜた中国神魔小説を代表する金字塔。';

  @override
  String get yearly => '年額プラン';

  @override
  String get yesReGradeMe => 'はい、再判定してください！';

  @override
  String you(Object lang) {
    return 'あなた（$lang）';
  }

  @override
  String get youAreSpeaking => 'あなたが発話中';

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
      'エコーホールでの会話データはお使いの端末にのみ安全にローカル保存されます。個人の会話音声がAIモデルの再学習に使用されることはありません。';

  @override
  String get zhOnly => '中国語のみ';

  @override
  String get hsk_1300_cards => '1300枚のカード';

  @override
  String get hsk_154_cards => '154枚のカード';

  @override
  String get hsk_162_cards => '162枚のカード';

  @override
  String get hsk_2500_cards => '2500枚のカード';

  @override
  String get hsk_299_cards => '299枚のカード';

  @override
  String get hsk_602_cards => '602枚のカード';

  @override
  String get added_to_review_queue => '復習キューに追加しました';

  @override
  String added_cards_to(int cardCount, String deckName) {
    return '「$deckName」に$cardCount枚のカードを追加しました。';
  }

  @override
  String added_to_your_library(Object hanzi) {
    return '「$hanzi」をライブラリに追加しました';
  }

  @override
  String get advanced => '上級';

  @override
  String get ai_stories => 'AIストーリー';

  @override
  String analysis_failed(Object error) {
    return '分析に失敗しました: $error';
  }

  @override
  String get analyzing_pronunciation_with_gemini_ai => 'Gemini AIで発音を分析中...';

  @override
  String get analyzing_your_pronunciation => '発音を分析中…';

  @override
  String are_you_sure_you_want_to(String deckName) {
    return '本当に「$deckName」を完全に削除しますか？この操作は取り消せず、デッキ内のすべてのカードが削除されます。';
  }

  @override
  String ask_about(String hanzi) {
    return '「$hanzi」について質問する...';
  }

  @override
  String get audio_haptics => 'オーディオと触覚フィードバック';

  @override
  String get audio_could_not_start_check_your =>
      '音声を再生できませんでした。通信環境と端末の音声設定をご確認ください。';

  @override
  String get calligraphy_trace => '運筆・なぞり書き練習';

  @override
  String chapters(Object count) {
    return '$count章';
  }

  @override
  String get char => '漢字';

  @override
  String get chinese_character => '中国語の漢字';

  @override
  String get contact_us_and_report_issues => 'お問い合わせ・不具合の報告';

  @override
  String created_smart_deck_with_words(String deckName, int wordCount) {
    return 'スマートデッキ「$deckName」（$wordCount語）を作成しました！';
  }

  @override
  String get custom_ai_generated_story => 'AIが生成したカスタムストーリー。';

  @override
  String get display_content => '表示とコンテンツ';

  @override
  String get do_you_keep_or_store_my => '私の音声録音データは保存されますか？';

  @override
  String get elementary => '初級';

  @override
  String error_creating_scenario(Object error) {
    return 'シナリオ作成エラー: $error';
  }

  @override
  String error_fetching_translation_for(Object error) {
    return '翻訳の取得エラー: $error';
  }

  @override
  String error_loading_chapters(Object error) {
    return '章の読み込みエラー: $error';
  }

  @override
  String get error_loading_decks => 'デッキの読み込みエラー';

  @override
  String error_loading_microreads(Object error) {
    return 'マイクロリーディングの読み込みエラー: $error';
  }

  @override
  String error_loading_novels(Object error) {
    return '小説の読み込みエラー: $error';
  }

  @override
  String error_loading_poetry(Object error) {
    return '詩の読み込みエラー: $error';
  }

  @override
  String get etymology => '語源・成り立ち：';

  @override
  String get explanation => '解説';

  @override
  String get extracted_text_tap_to_lookup => '抽出されたテキスト（タップして調べる）';

  @override
  String extraction_failed(Object error) {
    return '抽出に失敗しました: $error';
  }

  @override
  String get failed_to_download => 'ダウンロードに失敗しました。';

  @override
  String failed_to_generate_scenario(Object error) {
    return 'シナリオの生成に失敗しました: $error';
  }

  @override
  String failed_to_generate_story(Object error) {
    return 'ストーリーの生成に失敗しました:\n$error';
  }

  @override
  String failed_to_load_context(Object error) {
    return 'コンテキストの読み込みに失敗しました: $error';
  }

  @override
  String get feature_request => '機能リクエスト';

  @override
  String get foundation => '基礎・入門';

  @override
  String get how_is_my_pronunciation_scored => '発音はどのように採点されますか？';

  @override
  String hsk(Object level) {
    return 'HSK $level級';
  }

  @override
  String hsk_vocabulary(int hskLevel) {
    return 'HSK $hskLevel級の語彙';
  }

  @override
  String get hsk_level => 'HSKレベル';

  @override
  String get intermediate => '中級';

  @override
  String get learning_stats => '学習統計';

  @override
  String get mandarin => '中国語（普通話）';

  @override
  String get meaning => '意味';

  @override
  String get no_decks_found => 'デッキが見つかりません。';

  @override
  String no_results_found_for(Object searchQuery) {
    return '「$searchQuery」に一致する結果は見つかりませんでした';
  }

  @override
  String get no_when_you_use_echo_hall =>
      'いいえ。エコーホール、学者の判定、シャドーイングスタジオをご利用の際、音声データは発音スコア算出のためリアルタイムで安全に評価された後、直ちに破棄されます。学習進捗を記録するために保存されるのは数値スコアのみです。';

  @override
  String get notification_settings => '通知設定';

  @override
  String get open_settings => '設定を開く';

  @override
  String get phoneme => '音素';

  @override
  String get play_reference_pronunciation => 'お手本の発音を再生';

  @override
  String get please_select_a_deck_to_add => 'カードを追加するデッキを選択してください。';

  @override
  String get point_at_chinese_text_to_translate => 'カメラを中国語のテキストに向けて翻訳';

  @override
  String get practice_writing_the_strokes_by_hand => '手書きで筆順とストロークを練習しましょう';

  @override
  String get preferences_audio_and_display => '環境設定・オーディオ・表示';

  @override
  String get preparing_your_scholars_verdict => '学者の判定結果を作成中…';

  @override
  String get previous => '前へ';

  @override
  String question(Object current, Object total) {
    return '問題 $current/$total';
  }

  @override
  String remove_from_this_deck(String hanzi) {
    return 'このデッキから「$hanzi」を削除しますか？';
  }

  @override
  String revenuecat_error(Object error) {
    return 'RevenueCatエラー: $error';
  }

  @override
  String get review_tomorrow => '明日復習';

  @override
  String get roleplay => 'ロールプレイ';

  @override
  String saving_words_to(int wordCount, String deckName) {
    return '$wordCount件の単語を「$deckName」に保存中...';
  }

  @override
  String get search_radicals_eg_water => '部首を検索（例：水、氵）';

  @override
  String get select_target_hsk_level => '目標HSKレベルを選択';

  @override
  String get sentence => '例文・文章';

  @override
  String get shadowing_studio_is_a_dedicated_space =>
      'シャドーイングスタジオは、ネイティブの発音をリアルタイムで真似て練習するための専用空間です。';

  @override
  String simplify_failed(Object error) {
    return '平易化に失敗しました: $error';
  }

  @override
  String get sinospark_premium => 'SinoSpark プレミアム';

  @override
  String get speaking_pronunciation => 'スピーキングと発音';

  @override
  String get statistics => '学習統計';

  @override
  String get table_of_contents => '目次 · 目录';

  @override
  String get the_ai_evaluates_your_speech_across =>
      'AIは以下の3つの観点から音声を評価します：\n• 正確性：各音節を正確に発音できているか\n• 完全性：単語の抜け落ちや読み飛ばしがないか\n• 流暢さ：自然な間（ポーズ）を取り、正しい声調で話せているか\n音声をネイティブモデルと比較し、100点満点でスコアを算出します。';

  @override
  String get this_cannot_be_undone => 'この操作は元に戻せません。';

  @override
  String get title => 'タイトル';

  @override
  String get to_be_reviewed => '復習待ち';

  @override
  String get traditional => '繁体字';

  @override
  String translation_failed(Object error) {
    return '翻訳に失敗しました: $error';
  }

  @override
  String get type_in => '入力...';

  @override
  String get type_your_message_in => 'メッセージを入力してください...';

  @override
  String get unable_to_open_this_video_please =>
      'この動画を開けませんでした。しばらくしてからもう一度お試しください。';

  @override
  String get view_your_learning_history_and_streaks => '学習履歴と連続達成記録を確認';

  @override
  String get what_is_shadowing_studio => 'シャドーイングスタジオとは何ですか？';

  @override
  String get words => '単語';

  @override
  String your_path_for_is_ready(String deckName) {
    return '「$deckName」の学習パスが完成しました！';
  }

  @override
  String get you_said => '🗣️ あなたの発話';

  @override
  String vocabularyBatch(Object index) {
    return '語彙バッチ $index';
  }

  @override
  String get yourDailyDropIsHere => '本日のデイリードロップが届きました！ ✨';

  @override
  String get timeToReview => '復習の時間です！ 📚';

  @override
  String get neverMissAStroke => '一画一画を大切に！ 🖌️';

  @override
  String get yourTrialEndsTomorrow => '無料トライアルは明日で終了します！ ⏳';

  @override
  String get officialStandardVocabularyTiers => '公式標準語彙レベル';

  @override
  String get failedToLoadCollections => 'コレクションの読み込みに失敗しました。';

  @override
  String unnamedKey(Object tag) {
    return '#$tag';
  }

  @override
  String error(Object error) {
    return 'エラー: $error';
  }

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
  String get dailyDrops => 'デイリードロップ';

  @override
  String get wordOfTheDayNews => '今日の単語＆ニュース';

  @override
  String get reviewReminders => '復習リマインダー';

  @override
  String get flashcardsDueForReview => '復習が必要なフラッシュカード';

  @override
  String get dailyNewCards => '1日の新規カード';

  @override
  String get dailyReviewLimit => '1日の復習上限';

  @override
  String get practiceMode => '練習モード';

  @override
  String get liziqi => '李子柒（Liziqi）: 絹花（シルクフラワー）';

  @override
  String get theLifeOfGarlicTraditional => 'ニンニクの一生：中国伝統の田園生活';

  @override
  String get graceMandarin50Phrases => 'Grace Mandarin: 必須50フレーズ';

  @override
  String get essentialChinesePhrasesForBeginners => '初心者向けの必須中国語フレーズ';

  @override
  String get makingBambooFurniture => '伝統の竹製家具づくり';

  @override
  String get peppaPigChinese => 'ペッパピッグ中国語版：かくれんぼ（躲猫猫）';

  @override
  String get muddyPuddlesBeginnerFriendly => '泥の水たまり（初心者向け）';

  @override
  String get mandarinCorner300Verbs => 'Mandarin Corner: 重要動詞300選';

  @override
  String get mostCommonChineseVerbs => '最もよく使われる中国語の基本動詞';

  @override
  String get graceMandarinOrderFood => 'Grace Mandarin: 料理の注文方法';

  @override
  String get howToOrderFoodIn => '中華料理店での料理の頼み方';

  @override
  String get silkFlowersTraditionalCraft => '絹花：中国の伝統工芸';

  @override
  String get mandarinCorner => 'Mandarin Corner: 中国語で受診する（看病）';

  @override
  String get goingToTheDoctorReal => '病院に行く：リアルな診察会話';

  @override
  String get hideAndSeekBeginnerFriendly => 'かくれんぼ（初心者向け）';

  @override
  String get linGdp6 => '小Lin説：なぜGDP成長率目標は6%なのか？';

  @override
  String get why6GdpGrowthEasy => 'GDP成長率6%の理由：わかりやすい中国経済';

  @override
  String get bbcWorldNews => 'BBC 中文（ワールドニュース）';

  @override
  String get currentEventsInSimplifiedChinese => '簡体字で読む最新時事ニュース';

  @override
  String get baidu => 'Baidu（百度）';

  @override
  String get youtubeDesk => 'YouTubeデスク';

  @override
  String get interactiveTranscriptsShadowing => 'インタラクティブ文字起こし＆シャドーイング';

  @override
  String get showsDramas => 'ドラマ＆バラエティ';

  @override
  String get extractToDeck => 'デッキに単語を抽出';

  @override
  String get autoSimplify => '自動平易化';

  @override
  String get rewriteThisArticleToMatch => 'この記事を自分のHSKレベルに合わせて平易化する';

  @override
  String failedToSaveExtractedWords(Object error) {
    return '抽出した単語の保存に失敗しました: $error';
  }

  @override
  String addToDeck(Object count) {
    return 'デッキに追加 ($count)';
  }

  @override
  String get dailyDiscoveryDrop => 'デイリーディスカバードロップ';

  @override
  String get smartSpacedRepetition => 'スマート分散学習（SRS）';

  @override
  String get trialProtectionAlert => 'トライアル保護アラート';

  @override
  String get masteryLevel => '習熟度レベル';

  @override
  String get targetObjective => '学習目標';

  @override
  String get dailyPractice => '毎日の練習';

  @override
  String get aiSpacedRepetition => 'AI分散学習（間隔反復）';

  @override
  String get iVeGrantedAccess => 'アクセスを許可しました';

  @override
  String get scanner => 'スキャナー';

  @override
  String get interpreter => '通訳';

  @override
  String cards(Object count) {
    return '$count枚のカード';
  }

  @override
  String get nWaMendsTheHeavens => '女媧補天（女媧、天を補う）';

  @override
  String get terracottaArmy => '兵馬俑';

  @override
  String get forbiddenCity => '紫禁城（故宮）';

  @override
  String get aBlessingInDisguise => '人間万事塞翁が馬（塞翁失馬）';

  @override
  String get drawingASnake => '蛇足（画蛇添足）';

  @override
  String get takingTheBulletTrain => '高速鉄道（高鉄）に乗る';

  @override
  String get visitingTheDoctor => '病院にかかる';

  @override
  String get orderingDumplings => '水餃子を注文する';

  @override
  String get theTeaCeremony => '中国茶芸・工夫茶';

  @override
  String get chineseCalligraphy => '中国書道';

  @override
  String get theGiantPanda => 'ジャイアントパンダ';

  @override
  String get simplifiedText => '平易化テキスト';

  @override
  String get novels96 => '小説（96作品）';

  @override
  String get microReads => 'マイクロリーディング';

  @override
  String get poetry => '詩歌・漢詩';

  @override
  String get bookmarkRemoved => '书签已移除 · ブックマークを削除しました';

  @override
  String bookmarkAdded(Object chapter) {
    return '已添加书签 · ブックマークを追加しました: 第$chapter章';
  }

  @override
  String get readingVocabulary => '読解＆語彙';

  @override
  String vocabularyBatchUnitindex1(Object index) {
    return '語彙バッチ $index';
  }

  @override
  String get yourDailyDropIsHere1 => '本日のデイリードロップが届きました！✨';

  @override
  String get timeToReview1 => '復習の時間です！📚';

  @override
  String get neverMissAStroke1 => '一画一画を大切に！🖌️';

  @override
  String get yourTrialEndsTomorrow1 => '無料トライアルは明日で終了します！⏳';

  @override
  String get hskCollections1 => 'HSKコレクション';

  @override
  String get officialStandardVocabularyTiers1 => '公式標準語彙レベル';

  @override
  String get failedToLoadCollections1 => 'コレクションの読み込みに失敗しました。';

  @override
  String ui__transcription(Object transcription) {
    return '「$transcription」';
  }

  @override
  String playPinyinwithtone(Object pinyinWithTone) {
    return '$pinyinWithToneを再生';
  }

  @override
  String errorE(Object e) {
    return 'エラー: $e';
  }

  @override
  String lookalikepinyin(Object pinyin) {
    return '（$pinyin）';
  }

  @override
  String get aiSmartContext1 => 'AIスマートコンテキスト';

  @override
  String get aiSmartContextError1 => 'AIスマートコンテキストエラー';

  @override
  String errorErr(Object err, Object error) {
    return 'エラー: $error';
  }

  @override
  String get downloadOfficialHskCollections1 => '公式HSKコレクションをダウンロード';

  @override
  String get unableToLoadThisSectionPleaseTryAga =>
      'このセクションを読み込めませんでした。もう一度お試しください。';

  @override
  String get searchRadicalsEgWater => '部首を検索（例：水、氵）';

  @override
  String ui__currentstrokeindex1totalstrokes(Object current, Object total) {
    return '$current/$total';
  }

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
  String get flashcardsDueForReview1 => '復習が必要なフラッシュカード';

  @override
  String get accuracyByMode1 => 'モード別正答率';

  @override
  String accuracytostringasfixed1(Object accuracy) {
    return '$accuracy%';
  }

  @override
  String get upcomingReviewsNext7Days => '今後の復習（今後7日間）';

  @override
  String get explaining => '解説：';

  @override
  String entryhanziEntrypinyin(Object hanzi, Object pinyin) {
    return '$hanzi [$pinyin]';
  }

  @override
  String get dailyNewCards1 => '1日の新規カード';

  @override
  String get dailyReviewLimit1 => '1日の復習上限';

  @override
  String get listeningMode1 => 'リスニングモード';

  @override
  String get readingMode1 => 'リーディングモード';

  @override
  String get recallMode1 => 'リコール（想起）モード';

  @override
  String get speakingMode1 => 'スピーキングモード';

  @override
  String get practiceMode1 => '練習モード';

  @override
  String acc(Object acc) {
    return '$acc%';
  }

  @override
  String get partner1 => '対話パートナー';

  @override
  String get partnerSpeaking1 => 'パートナーが発話中…';

  @override
  String get theLifeOfGarlicTraditionalChineseLi => 'ニンニクの一生：中国伝統の田園生活';

  @override
  String get graceMandarin50Phrases1 => 'Grace Mandarin: 必須50フレーズ';

  @override
  String get essentialChinesePhrasesForBeginners1 => '初心者向けの必須中国語フレーズ';

  @override
  String get makingBambooFurniture1 => '伝統の竹製家具づくり';

  @override
  String get muddyPuddlesBeginnerFriendly1 => '泥の水たまり（初心者向け）';

  @override
  String get mandarinCorner300Verbs1 => 'Mandarin Corner: 重要動詞300選';

  @override
  String get mostCommonChineseVerbs1 => '最もよく使われる中国語の基本動詞';

  @override
  String get graceMandarinOrderFood1 => 'Grace Mandarin: 料理の注文方法';

  @override
  String get howToOrderFoodInAChineseRestaurant => '中華料理店での料理の頼み方';

  @override
  String get silkFlowersTraditionalCraft1 => '絹花：中国の伝統工芸';

  @override
  String get goingToTheDoctorRealLifeConversatio => '病院に行く：リアルな診察会話';

  @override
  String get hideAndSeekBeginnerFriendly1 => 'かくれんぼ（初心者向け）';

  @override
  String get lingdp6 => '小Lin説：なぜGDP成長率目標は6%なのか？';

  @override
  String get why6GdpGrowthEasyChineseEconomics => 'GDP成長率6%の理由：わかりやすい中国経済';

  @override
  String get currentEventsInSimplifiedChinese1 => '簡体字で読む最新時事ニュース';

  @override
  String get baidu1 => 'Baidu（百度）';

  @override
  String get youtubeDesk1 => 'YOUTUBE DESK';

  @override
  String get interactiveTranscriptsShadowing1 => 'インタラクティブ文字起こし＆シャドーイング';

  @override
  String get showsDramas1 => 'ドラマ＆バラエティ';

  @override
  String error_error(Object error) {
    return 'エラー: $error';
  }

  @override
  String get extractToDeck1 => 'デッキに単語を抽出';

  @override
  String get autosimplify => '自動平易化';

  @override
  String get rewriteThisArticleToMatchYourHskLev => 'この記事を自分のHSKレベルに合わせて平易化する';

  @override
  String get addToDeck1 => 'デッキに追加';

  @override
  String playbackratex(Object playbackRate) {
    return '$playbackRate倍速';
  }

  @override
  String speedx(Object speed) {
    return '$speed倍速';
  }

  @override
  String get dailyDiscoveryDrop1 => 'デイリーディスカバードロップ';

  @override
  String get smartSpacedRepetition1 => 'スマート分散学習（SRS）';

  @override
  String get trialProtectionAlert1 => 'トライアル保護アラート';

  @override
  String get masteryLevel1 => '習熟度レベル';

  @override
  String get targetObjective1 => '学習目標';

  @override
  String get dailyPractice1 => '毎日の練習';

  @override
  String get aiSpacedRepetition1 => 'AI分散学習（間隔反復）';

  @override
  String get iveGrantedAccess => 'アクセスを許可しました';

  @override
  String addToDeck_selectedwordindiceslength(Object count) {
    return 'デッキに追加 ($count)';
  }

  @override
  String get scanner1 => 'スキャナー';

  @override
  String get interpreter1 => '通訳';

  @override
  String entryvalueCards(Object count) {
    return '$count枚のカード';
  }

  @override
  String score_score_questionslength(Object score, Object total) {
    return 'スコア: $score / $total';
  }

  @override
  String get theMonkeyKing1 => '孫悟空';

  @override
  String get huaMulan1 => '花木蘭（ムーラン）';

  @override
  String get nwaMendsTheHeavens => '女媧補天';

  @override
  String get confucius => '孔子';

  @override
  String get theGreatWall1 => '万里の長城';

  @override
  String get terracottaArmy1 => '兵馬俑';

  @override
  String get forbiddenCity1 => '紫禁城（故宮）';

  @override
  String get aBlessingInDisguise1 => '人間万事塞翁が馬';

  @override
  String get drawingASnake1 => '蛇足（画蛇添足）';

  @override
  String get takingTheBulletTrain1 => '高速鉄道に乗る';

  @override
  String get visitingTheDoctor1 => '病院にかかる';

  @override
  String get orderingDumplings1 => '水餃子を注文する';

  @override
  String get theTeaCeremony1 => '中国茶芸';

  @override
  String get chineseCalligraphy1 => '中国書道';

  @override
  String get theGiantPanda1 => 'ジャイアントパンダ';

  @override
  String get simplifiedText1 => '平易化テキスト';

  @override
  String get novels961 => '小説（96作品）';

  @override
  String get microreads => 'マイクロリーディング';

  @override
  String get poetry1 => '詩歌・漢詩';

  @override
  String get readingVocabulary1 => '読解＆語彙';

  @override
  String get defaultfirebaseoptionsHaveNotBeenCo =>
      'DefaultFirebaseOptionsがLinux用に設定されていません。';

  @override
  String get defaultfirebaseoptionsAreNotSupport =>
      'このプラットフォームではDefaultFirebaseOptionsはサポートされていません。';

  @override
  String get hanziMaster1 => 'SinoSpark';

  @override
  String get strokesCannotBeEmpty => '画数が空になっています。';

  @override
  String get wrongStartPoint => '始点の位置が正しくありません。';

  @override
  String get rightShapeButWrongPlace => '形は合っていますが、位置がずれています！';

  @override
  String get goodFollowTheFlow => '素晴らしい！筆の流れに沿って書き進めましょう。';

  @override
  String get aBitShaky => '線が少し震えています！';

  @override
  String get aBitHesitant => '少し迷いがあるようです...';

  @override
  String get shapeIsOff => '線の形が崩れています。';

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
  String get microphonePermissionDenied => 'マイクへのアクセス権限が拒否されました';

  @override
  String get offset => 'オフセット';

  @override
  String get audioserviceHasBeenDisposed => 'AudioServiceは終了処理されました';

  @override
  String get fenrirZhcnyunxineural => 'Fenrir（zh-CN-YunxiNeural）';

  @override
  String get charonZhcnyunyangneural => 'Charon（zh-CN-YunyangNeural）';

  @override
  String get koreZhcnxiaoxiaoneural => 'Kore（zh-CN-XiaoxiaoNeural）';

  @override
  String get aoedeZhcnxiaoyineural => 'Aoede（zh-CN-XiaoyiNeural）';

  @override
  String get puckZhcnyunjianneural => 'Puck（zh-CN-YunjianNeural）';

  @override
  String get kore => 'Kore（女性・温かみのある声）';

  @override
  String get xmicrosoftoutputformatAudio24khz48k =>
      'audio-24khz-48kbitrate-mono-mp3';

  @override
  String get useragentHanzimasterapp => 'HanziMasterApp';

  @override
  String get anchorWord => '基準単語（アンカーワード）';

  @override
  String get creativeThematicTitle => '創造的なテーマタイトル';

  @override
  String get briefPedagogicalOrSemanticRationale => '教育的・意味論的な選定理由（簡潔に）';

  @override
  String get theSingleMostCentralCharacterFromTh => 'リストの中で最も中核となる漢字';

  @override
  String get aBalancedSetOfCharactersFromYourLib => 'ライブラリからバランスよく選ばれた漢字セット';

  @override
  String get yourNaturalConversationalReplyInChi => '中国語（簡体字）による自然な会話の返答';

  @override
  String get theEnglishTranslationOfYourReply => '返答の日本語訳';

  @override
  String get thePinyinWithToneMarksForYourReply => '返答の声調記号付きピンイン';

  @override
  String get aSuggestedResponseTheUserCouldSayBa => 'ユーザーが返答できるおすすめの表現';

  @override
  String get pinyinForTheSuggestion => 'おすすめ表現のピンイン';

  @override
  String get englishTranslationForTheSuggestion => 'おすすめ表現の日本語訳';

  @override
  String get scholarsCritique => '学者の講評・フィードバック';

  @override
  String get theEchoHallRemainsSilentTryYourBrea =>
      'エコーホールは静まり返っています。一息ついてもう一度お試しください。';

  @override
  String get xtitleHanziMaster => 'SinoSpark';

  @override
  String get noneYet => 'まだありません。';

  @override
  String get exactSentence => '対象の文章：';

  @override
  String get englishTranslation => '日本語訳';

  @override
  String get previouslyGeneratedPhrases => '以前に生成されたフレーズ';

  @override
  String get iLikeDrinkingAppleJuice => '私はりんごジュースを飲むのが好きです。';

  @override
  String get theEnglishMeaningHere => 'ここでの意味を入力...';

  @override
  String get failedToFetchDefinition => '語義の取得に失敗しました。';

  @override
  String get failedToLoadExplanation => '解説の読み込みに失敗しました。';

  @override
  String get failedToLoadComparison => '比較データの読み込みに失敗しました。';

  @override
  String get emptyResponseFromOpenrouter => 'OpenRouterからの応答が空です';

  @override
  String get emptyResponseFromVisionModel => 'Visionモデルからの応答が空です';

  @override
  String get standard => '標準';

  @override
  String get theFullSentenceInChinese => '中国語の全文...';

  @override
  String get theWordOrCharacterInChinese => '中国語の単語または漢字';

  @override
  String get thePinyinForThisSpecificWord => 'この単語のピンイン';

  @override
  String get emptyResponseFromDeepseekApi => 'DeepSeek APIからの応答が空です';

  @override
  String get criticalPutTheEnglishTranslationInT => '重要：日本語訳を以下に入力してください';

  @override
  String get englishTranslationOfTheEntireSenten => '文章全体の日本語訳';

  @override
  String get hanziWord => '漢字・語彙';

  @override
  String get theFullSimplifiedSentenceInChinese => '中国語（簡体字）の全文...';

  @override
  String get lyingFlatACulturalMovement => '寝そべり族（タンピン）：社会現象...';

  @override
  String get theUserYouAreSpeakingToIsNamed => '対話相手のユーザー名：';

  @override
  String get importantRuleDoNotAddressTheUserByA =>
      '重要ルール：ユーザーを特定の名前で呼ばないでください。プレースホルダー名も使用厳禁です：';

  @override
  String get youAreAConciseChineseCalligraphyAnd =>
      'あなたはフラッシュカードアプリ内の的確で分かりやすい中国書道・語源チューターです。';

  @override
  String get theStudentIsStudyingTheCharacter => '学習中の漢字：';

  @override
  String get neverWriteIntroductionsSignoffsOrFi =>
      '前置きや結びの挨拶、不要な前置き表現は一切記述しないでください。';

  @override
  String get beDirectAndInformative => '簡潔かつ有益な情報を提供してください。';

  @override
  String get criticalRuleYouMustRespondEntirelyI =>
      '重要ルール：指定されたISO 639-1コードの言語のみを用いて回答してください。';

  @override
  String get youAreAConciseChineseGrammarTutorIn =>
      'あなたはモバイルアプリ内の的確で分かりやすい中国語文法チューターです。';

  @override
  String get theStudentIsConfusedAboutTheWord => '生徒が疑問に思っている単語：';

  @override
  String get neverWriteIntroductionsSignoffsOrFi1 =>
      '前置きや結びの挨拶、不要な前置き表現は一切記述しないでください。';

  @override
  String get azureSpeechApiKeysAreMissing => 'Azure Speech APIキーが設定されていません。';

  @override
  String get success => '成功';

  @override
  String get granularity => '詳細度（粒度）';

  @override
  String get phoneme1 => '音素';

  @override
  String get dimension => '評価項目（次元）';

  @override
  String get comprehensive => '総合評価';

  @override
  String get weCouldntHearYouClearlyPleaseTryAga =>
      '音声を明瞭に聞き取れませんでした。もう一度お話しください。';

  @override
  String get noNbestResultFound => '最適な認識結果が見つかりませんでした。';

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
  String get omission => '脱落（読み飛ばし）';

  @override
  String get insertion => '余分な発音（挿入）';

  @override
  String get youMissedThisWord => 'この単語が読み飛ばされています。';

  @override
  String get extraWordAddedHere => 'ここに不要な単語が挟まれています。';

  @override
  String get mispronunciation => '発音の誤り';

  @override
  String get pronunciationWasInaccurate => '発音の正確性が不足しています。';

  @override
  String get goodEffortKeepPracticing => '惜しい！この調子で練習を重ねましょう。';

  @override
  String get perfectPronunciationSoundsLikeANati => '完璧な発音です！まるでネイティブのようです。';

  @override
  String get greatJobAFewMinorToneInaccuracies => '素晴らしい出来です！声調にわずかなズレがある程度です。';

  @override
  String get notBadButYourTonesNeedSomeWork => '悪くありませんが、声調をもう少し意識してみましょう。';

  @override
  String get keepPracticingListenToTheNativeAudi => 'お手本を聞いて、繰り返し練習してみましょう！';

  @override
  String get lexical => '語彙';

  @override
  String get chineseHanziHere => '中国語の漢字をここに入力';

  @override
  String get aShortSummaryInEnglish => '日本語での簡潔な要約';

  @override
  String get noCoherentChineseTextFoundInTheScan =>
      'スキャン画像から認識可能な中国語テキストが見つかりませんでした。';

  @override
  String get theFullEnglishTranslationOfTheScann =>
      'スキャンテキストの全文日本語訳... または「認識可能な中国語テキストが見つかりませんでした」';

  @override
  String get aShort24WordTitleForThisScanEgResta =>
      'スキャンの短いタイトル（例：「レストランのメニュー」「道路標識」）';

  @override
  String get china => '中国';

  @override
  String get noTranslationAvailable => '利用可能な翻訳がありません。';

  @override
  String get scanResults => 'スキャン結果';

  @override
  String get whenWasItWrittenAndWhatWasHappening =>
      'いつ執筆され、当時の中国ではどのような歴史的出来事がありましたか？';

  @override
  String get whyIsThisPieceFamousWhatPhilosophic =>
      'なぜこの作品は名作と称されるのですか？どのような哲学的・文化的主題が描かれていますか？';

  @override
  String get aBriefBioOfTheAuthor => '著者の略歴';

  @override
  String get informationUnavailable => '情報は利用できません。';

  @override
  String get noSummaryAvailable => '利用可能な要約がありません。';

  @override
  String get hanziAiPro => 'SinoSpark AI Pro';

  @override
  String get trialNormalIntro => 'トライアル、ノーマル、イントロ';

  @override
  String get dailyDrop => 'デイリードロップ';

  @override
  String get dailyNotificationsForWordOfTheDayAn => '「今日の単語」と最新ニュースの通知';

  @override
  String get aNewWordAndStoryOfTheDayAreWaitingF => '本日の新しい単語とストーリーが待っています！';

  @override
  String get spacedRepetition => '分散学習（間隔反復）';

  @override
  String get remindersForFlashcardsDueForReview => '復習が必要なカードのリマインダー';

  @override
  String get engagementReminders => '学習継続リマインダー';

  @override
  String get trialReminders => 'トライアル期間リマインダー';

  @override
  String get notificationsForYourTrialStatus => 'トライアル利用状況に関する通知';

  @override
  String get comeReviewYourHanziAndTryALiveCallB =>
      '無料期間が終了する前に、漢字の復習やライブ通話をお試しください！';

  @override
  String get scholarsEye => '学者の眼（詳細分析）';

  @override
  String get clMeasureWord => '量詞（助数詞 / CL）：';

  @override
  String get surnameShi => '姓（史）';

  @override
  String get chineseFamilyNameShi => '中国の姓（史）';

  @override
  String get neutralToneLight => '軽声（軽快・弱音）';

  @override
  String get keepYourPitchHighAndSteadyLikeSingi =>
      '歌の音を伸ばすように、高めの音を平らにまっすぐキープします。';

  @override
  String get startInTheMiddleAndSlideYourPitchUp =>
      '中間の高さから始めて、「えっ？」と聞き返すように一気に音を上げます。';

  @override
  String get dipYourVoiceDownLowThenRiseGentlyBa => '声をぐっと低く落としてから、ふわりと持ち上げます。';

  @override
  String get dropYourPitchSharplyAndDecisivelyLi =>
      '「ダメ！」と強く断ち切るように、高い音から一気に鋭く音を落とします。';

  @override
  String get pronounceSoftlyBrieflyAndWithoutEmp => '力を抜いて短く、軽く添えるように発音します。';

  @override
  String get spotOnPitchWasHighFlatAndSteady => '完璧です！高音を平らに安定してキープできています。';

  @override
  String get spotOnUpwardPitchRiseWasClear => '完璧です！下から上への音の切れ上がりが非常に明瞭です。';

  @override
  String get spotOnLowDippingCurveWasAccurate => '完璧です！低音の沈み込みと跳ね上がりが正確です。';

  @override
  String get spotOnSharpFallingDropWasDecisive => '完璧です！高所からの鋭く力強い下降が的確です。';

  @override
  String get spotOnToneWasPronouncedAccurately => '完璧です！声調が正確に発音されています。';

  @override
  String get iAgreeToTheTermsOfServiceAndPrivacy => '利用規約およびプライバシーポリシーに同意します。';

  @override
  String get sendMeOccasionalUpdatesTipsAndOffer => '役立つ学習のコツやお得な最新情報を受け取る。';

  @override
  String get signInToSyncYourProgress => '学習進捗をクラウドに同期するにはサインインしてください。';

  @override
  String get createAnAccountToSaveYourStats => '学習記録を安全に保存するためにアカウントを作成してください。';

  @override
  String get smartSpiral => 'スマートスパイラル';

  @override
  String get origin => '起源';

  @override
  String get elements => '自然・元素';

  @override
  String get humanity => '人間・身体';

  @override
  String get village => '生活・集落';

  @override
  String get journey => '行動・移動';

  @override
  String get city => '都市・社会';

  @override
  String get originTheSimplestShapesTheBeginning => '最も根源的な造形。すべての漢字の始まり。';

  @override
  String get elementsSunMoonWaterAndFireTheNatur => '日・月・水・火。大自然を象る根源の力。';

  @override
  String get humanityTheBodyTheHeartAndTheFamily => '身体・心・家族。人間存在と絆を紡ぐ文字。';

  @override
  String get villageFieldsRoofsAndToolsTheFounda => '田畑・家屋・道具。生活と社会の礎。';

  @override
  String get journeyMovementSpeechAndSustenance => '移動・言葉・食糧。人と世界を繋ぐ営み。';

  @override
  String get cityCommerceClothingAndComplexArtif => '商業・衣服・精巧な文明の遺物。';

  @override
  String get equilibriumAlgorithm => 'バランス調整アルゴリズム';

  @override
  String get misc => 'その他';

  @override
  String get cityOrOriginAs => '「都市」または「起源」として';

  @override
  String get miscToOrigin => '「その他」から「起源」へ';

  @override
  String get constellation => '星座';

  @override
  String get whichOneIsWater => '「水」を意味する文字はどれですか？';

  @override
  String get whatIsThePinyin => '正しいピンインはどれですか？';

  @override
  String get nature => '自然';

  @override
  String get whatEssenceDoes => 'どの本質（部首）が必要ですか：';

  @override
  String get allTiers => 'すべてのレベル';

  @override
  String get active => '有効';

  @override
  String get theScrollOfOrigin1 => '起源の巻物';

  @override
  String galaxyOf1(Object name) {
    return '〜の銀河：$name';
  }

  @override
  String get also => 'また';

  @override
  String get work => '仕事・労力';

  @override
  String get cloud => '雲';

  @override
  String get youArchaic => '汝（古語）';

  @override
  String get suddenly => '突然';

  @override
  String get owner => '主・所有者';

  @override
  String get door => '門・戸';

  @override
  String get occupy => '占める';

  @override
  String get nail => '釘';

  @override
  String get and => '〜と';

  @override
  String get buddhistNun => '尼僧・比丘尼';

  @override
  String get anxious => '焦燥・不安';

  @override
  String get sprout => '芽・新芽';

  @override
  String get exchange => '交換・交流';

  @override
  String get sheep => '羊';

  @override
  String get strange => '奇妙・怪異';

  @override
  String get opposite => '反対・逆';

  @override
  String get shorttailedBird => '短尾の鳥（隹）';

  @override
  String get shoot => '射る・発射';

  @override
  String get small => '小さい・微小';

  @override
  String get gather => '集める・集結';

  @override
  String get order => '順序・秩序';

  @override
  String get flat => '平ら・平坦';

  @override
  String get thePersonWho => '〜する人（者）';

  @override
  String get nobleman => '貴人・君子';

  @override
  String get cause => '原因・由縁';

  @override
  String get pig => '豚・猪';

  @override
  String get bright => '明るい・光輝';

  @override
  String get slowly => 'ゆっくり・緩慢';

  @override
  String get give => '与える・授与';

  @override
  String get arrow => '矢';

  @override
  String get dry => '乾燥・乾く';

  @override
  String get obstacle => '障害・遮る';

  @override
  String get beg => '乞う・請願';

  @override
  String get window => '窓';

  @override
  String get fear => '恐れ・畏怖';

  @override
  String get drum => '鼓・太鼓';

  @override
  String get why => '何故・理由';

  @override
  String get talent => '才能・才覚';

  @override
  String get follow => '従う・追従';

  @override
  String get desert => '砂漠';

  @override
  String get component => '構成要素・パーツ';

  @override
  String divingInto1(Object topic) {
    return '深掘り：$topic';
  }

  @override
  String get unitIntro1 => 'ユニット概要';

  @override
  String get theBlueprint => '設計図（ブループリント）';

  @override
  String get theOrigin => '起源';

  @override
  String get theGalaxy => '銀河';

  @override
  String get theScholarListens => '学者が耳を傾けています...';

  @override
  String get consultingTheScrolls => '古文書を紐解いています...';

  @override
  String get traceWithTheGuide => 'ガイドに沿ってなぞり書き';

  @override
  String get traceTheGhost => '透かしガイドをなぞる';

  @override
  String get connectTheDots => 'ドットを繋ぐ';

  @override
  String get drawFromMemory => '記憶を頼りに書く';

  @override
  String get assistant => 'アシスタント';

  @override
  String get puck => 'Puck（男性・スポーティ）';

  @override
  String get helloWelcomeWhatWouldYouLikeToOrder => 'いらっしゃいませ！何をご注文なさいますか？';

  @override
  String get ni3Hao3Huan1ying2Guang1lin2Qing3wen =>
      'Nǐ hǎo! Huānyíng guānglín. Qǐngwèn nǐ yào diǎn shénme?';

  @override
  String get waiterLi => '店員の李（リー）さん';

  @override
  String get askForTheMenu => 'メニューを頼む';

  @override
  String get orderOneDishAndOneDrink => '料理1品と飲み物1つを注文する';

  @override
  String get askForTheBill => 'お会計を頼む';

  @override
  String get fenrir => 'Fenrir（男性・エネルギッシュ）';

  @override
  String get ni3Qu4Na3rAJi1chang3MaTing3Yuan3De =>
      'Nǐ qù nǎr a? Jīchǎng ma? Tǐng yuǎn de!';

  @override
  String get driverWang => '運転手の王（ワン）さん';

  @override
  String get tellTheDriverYouAreGoingToTheAirpor => '空港へ向かう旨を運転手に伝える';

  @override
  String get askHowLongTheTripWillTake => '到着までにどれくらいかかるか尋ねる';

  @override
  String get complainAboutTheTraffic => '交通渋滞について話す';

  @override
  String get charon => 'Charon（男性・ニュースキャスター風）';

  @override
  String get thisClothingQualityIsEspeciallyGood => 'この服はとても質が良くて、たったの200元ですよ。';

  @override
  String get zhe4Jian4Yi1fuZhi4liang4Te4bie2Hao3 =>
      'Zhè jiàn yīfu zhìliàng tèbié hǎo, zhǐyào liǎng bǎi kuài.';

  @override
  String get auntieChen => '陳（チェン）おばさん';

  @override
  String get askHowMuchTheSilkShirtCosts => 'シルクシャツの値段を尋ねる';

  @override
  String get sayItIsTooExpensive => '高すぎると伝える';

  @override
  String get bargainThePriceDownTo100Rmb => '100元まで値切る';

  @override
  String get ni3Na3li3Bu4Shu1fuFa1shao1LeMa =>
      'Nǐ nǎlǐ bù shūfu? Fāshāo le ma?';

  @override
  String get drZhang => '張（ジャン）医師';

  @override
  String get explainYouHaveHadAHeadacheForTwoDay => '2日前から頭痛が続いていると説明する';

  @override
  String get sayYouHaveASlightFever => '微熱があると伝える';

  @override
  String get askIfYouNeedToTakeMedicine => '薬を飲む必要があるか尋ねる';

  @override
  String get aoede => 'Aoede（女性・朗らか）';

  @override
  String get heyLongTimeNoSeeHowHaveYouBeenLatel => '久しぶり！最近はどう過ごしているの？';

  @override
  String get ni3Hao3Hao3jiu3Bu4jian4Ni3Zui4jin4Z =>
      'Nǐ hǎo! Hǎojiǔ bùjiàn, nǐ zuìjìn zěnmeyàng?';

  @override
  String get pleaseIntroduceYourselfWhyDoYouWant =>
      '簡単に自己紹介をお願いします。弊社を志望した理由は何ですか？';

  @override
  String get qing3Xian1Zi4wo3Jie4shao4Yi1xia4Ni3 =>
      'Qǐng xiān zìwǒ jièshào yíxià. Nǐ wèishénme xiǎng lái wǒmen gōngsī gōngzuò?';

  @override
  String get managerLiu => '劉（リウ）採用担当マネージャー';

  @override
  String get introduceYourProfessionalBackground => 'これまでの職歴・バックグラウンドを簡潔に話す';

  @override
  String get explainWhyYouWantToWorkAtThisCompan => '志望動機を伝える';

  @override
  String get askAPoliteQuestionAboutTheCompanyCu => '企業風土・社風について丁寧に質問する';

  @override
  String get microphoneAccessIsRequiredPleaseEna =>
      'マイクへのアクセス権限が必要です。端末の「設定」から有効にしてください。';

  @override
  String get couldNotStartMicrophonePleaseCheckY =>
      'マイクを起動できませんでした。音声設定をご確認のうえ、もう一度お試しください。';

  @override
  String get weDidntQuiteCatchThatPleaseHoldTheM =>
      'うまく聞き取れませんでした。マイクボタンを長押ししながらもう一度お話しください！';

  @override
  String get recordingWasTooShortHoldTheMicAndSp =>
      '録音時間が短すぎます。マイクボタンをしっかり押してはっきりとお話しください。';

  @override
  String get audioBufferWasEmptyPleaseCheckYourM =>
      '音声データが受信できませんでした。マイクを確認して再試行してください。';

  @override
  String get audioFileIsSilentPleaseSpeakIntoThe =>
      '音声が無音です。マイクに向かって声を出してください。';

  @override
  String get weCouldntUnderstandYourPronunciatio =>
      '発音を認識できませんでした。より明瞭に発音して再試行してください。';

  @override
  String get theServerIsTakingTooLongToRespondPl =>
      'サーバーの応答に時間がかかっています。しばらくしてからもう一度お試しください。';

  @override
  String get noInternetConnectionPleaseCheckYour =>
      'インターネット接続がありません。通信環境をご確認のうえ、再度お試しください。';

  @override
  String get audioProcessingFailedPleaseTryAgain => '音声の処理に失敗しました。もう一度お試しください。';

  @override
  String get permission => '権限';

  @override
  String get couldNotProcessYourRecordingPleaseT =>
      '録音データを処理できませんでした。もう一度お試しください。';

  @override
  String get user => 'ユーザー';

  @override
  String get scholar => '学者';

  @override
  String get ourAiTutorsAreCurrentlyOfflinePleas =>
      'AIチューターは現在オフラインです。しばらくしてからもう一度お試しください。';

  @override
  String get hideTranslation => '翻訳を非表示';

  @override
  String get azureAssessment => 'Azure発音判定中...';

  @override
  String get microphonePermissionRequired => 'マイクのアクセス許可が必要です';

  @override
  String get connectedSpeakNow => '接続しました！今すぐお話しください。';

  @override
  String get initializationErrorCheckPermissions =>
      '初期化エラーが発生しました。アクセス権限をご確認ください。';

  @override
  String get microphoneErrorTapToRetry => 'マイクエラーが発生しました。タップして再試行してください。';

  @override
  String get theTutorReturnedAnEmptyResponse => 'チューターからの応答がありませんでした。';

  @override
  String get connectionInterruptedPleaseSpeakAga => '接続が中断されました。もう一度お話しください。';

  @override
  String get callPausedReviewingTones => '通話一時停止中（声調を確認中）';

  @override
  String get pausedTakeABreak => '一時停止中 - 少し休憩しましょう';

  @override
  String get goodStartPracticing => '素晴らしい滑り出しです！';

  @override
  String get studentCoach => '生徒 / コーチ';

  @override
  String get keepYour1stToneHighAndSteadyOn => '第1声は高く平らにキープしてください：';

  @override
  String get noScenariosFound => 'シナリオが見つかりません。';

  @override
  String get designYourOwnAiRoleplayExperience => '自分だけのAIロールプレイを作成';

  @override
  String get generateFromDeck => 'デッキから生成';

  @override
  String get practiceFlashcardVocabularyInALiveD => 'ライブ対話でフラッシュカードの語彙を練習';

  @override
  String get tapToRoleplay => 'タップしてロールプレイを開始';

  @override
  String get hsk2 => 'HSK 2級';

  @override
  String get hsk3 => 'HSK 3級';

  @override
  String get hsk4 => 'HSK 4級';

  @override
  String get hsk5 => 'HSK 5級';

  @override
  String get hsk6 => 'HSK 6級';

  @override
  String get dinnerWithDad => 'お父さんとの夕食';

  @override
  String get orderingAtAChengduTeahouse => '成都の茶館で注文する';

  @override
  String get buyingTeaAtTheMarket => '市場でお茶を買う';

  @override
  String get meetingAnOldClassmate => '同窓生との再会';

  @override
  String get readyToPractice => '練習の準備はできましたか？';

  @override
  String get letsPracticeChinese => '中国語を練習しましょう';

  @override
  String get areYouReady => '準備はいいですか？';

  @override
  String get discussWhatToHaveForDinner => '夕食のメニューについて話し合う';

  @override
  String get suggestWatchingAMovieAfterwards => '食後に映画を観ることを提案する';

  @override
  String get askIfTheyWouldLikeTea => 'お茶を飲むか尋ねる';

  @override
  String get helloVeryNiceToMeetYou => '初めまして！お会いできて嬉しいです。';

  @override
  String get deckPractice => 'デッキ練習';

  @override
  String get practiceVocabularyWithAnAiPartner => 'AIパートナーと語彙を練習します。';

  @override
  String get designCustomAiRoleplayConversation => 'カスタムAIロールプレイ＆会話を作成';

  @override
  String get random => 'ランダム';

  @override
  String get scenarioTopic => 'シナリオのトピック';

  @override
  String get contextSettingOptional => 'シチュエーション・背景（任意）';

  @override
  String get aiCharacterPersonaOptional => 'AIキャラクターのペルソナ（任意）';

  @override
  String get aQuietBambooCourtyardTeahouseInChen =>
      '成都の静かな竹林の中庭にある茶館。穏やかな古筝の調べが響く。';

  @override
  String get aBustlingSmokyNightMarketFilledWith =>
      '串焼きや肉まん、屋台料理の香ばしい煙と活気に満ちた夜市。';

  @override
  String get aLivelyHotpotRestaurantInChongqingW =>
      '煮えたぎる深紅のスープと唐辛子の刺激的な香りが広がる、重慶の活気あふれる火鍋店。';

  @override
  String get aBustlingTraditionalCantoneseTeahou => '蒸籠から湯気が立ち上る、広州の伝統的な飲茶・茶館。';

  @override
  String get aChicMinimalistCafeInTheFrenchConce =>
      '雨の日曜日の午後、フランス租界にあるシックで洗練されたカフェ。';

  @override
  String get aWarmNorthernHomeKitchenDuringWinte =>
      '冬の北方の温かい家庭の台所。粉が広がる食卓と湯気を立てる水餃子の鍋。';

  @override
  String get anOpenairNightStreetFoodAlleyWithSi =>
      '羊肉串の焼ける音と煙、焼きナス、冷たいビールが並ぶ屋外の夜市通り。';

  @override
  String get aSnowyStreetCornerOutsideTheLamaTem =>
      '雪が舞う雍和宮（ラマ寺院）の門前。氷の上に並ぶ鮮やかな真紅の糖葫芦（サンザシ飴）。';

  @override
  String get craftBeerBreweryInQingdao => '青島のクラフトビール醸造所';

  @override
  String get aLivelyCoastalTaproomWithWoodenBarr =>
      '木樽と心地よい潮風、注ぎたての白ビールが楽しめる海沿いの活気あるタップルーム。';

  @override
  String get sichuanCookingMasterclass => '本場・四川料理マスタークラス';

  @override
  String get aVibrantOpenKitchenWithWoksBlazingC =>
      '豪快に火柱が上がる中華鍋、熱々のラー油、新鮮な花椒が香るオープンキッチン。';

  @override
  String get highspeedRailSeatMixup => '高速鉄道の座席トラブル';

  @override
  String get greatWallSunriseTrekInMutianyu => '慕田峪長城の日の出トレッキング';

  @override
  String get theAncientStoneRampartsOfTheGreatWa =>
      '朝靄に包まれた緑の山々と、夜明けの光を浴びる万里の長城の石造りの城壁。';

  @override
  String get bambooRaftDriftOnGuilinLiRiver => '桂林・漓江の竹筏下り';

  @override
  String get glidingAlongEmeraldKarstWatersBetwe =>
      '陽朔近郊の切り立つ奇岩山水の間を、エメラルドグリーンの水面を滑るように進む。';

  @override
  String get silkRoadCamelTrekInDunhuang => '敦煌・シルクロードのラクダトレッキング';

  @override
  String get theRollingGoldenSandDunesOfMingshaM =>
      '月牙泉のオアシスを抱く、鳴沙山の美しく波打つ黄金の砂丘。';

  @override
  String get bookingACourtyardHomestayInDali => '大理の中庭付き伝統宿（四合院民宿）の予約';

  @override
  String get aSereneBaistyleBoutiqueCourtyardHot =>
      '雲南省・洱海を望む、白（ペー）族建築様式の静謐なブティック宿。';

  @override
  String get potalaPalacePilgrimageInLhasa => 'ラサ・ポタラ宮の巡礼';

  @override
  String get theMajesticSundrenchedStoneStepsOut =>
      '太陽の光を浴びるポタラ宮の荘厳な石段と、静かに回転するマニ車。';

  @override
  String get aSubzeroWonderlandOfIlluminatedCrys =>
      '氷点下の銀世界。ライトアップされた氷の宮殿とそびえ立つ巨大雪像。';

  @override
  String get zhangjiajieAvatarMountainCableCar => '張家界・アバター山のロープウェイ';

  @override
  String get suspendedHighInAGlassCableCarSoarin =>
      '数千本もの珪岩柱の峰々の上空を飛翔する、全面ガラス張りのロープウェイ。';

  @override
  String get gobiDesertStargazingCampInGansu => '甘粛省・ゴビ砂漠の星空観測キャンプ';

  @override
  String get aLuxuryYurtCampUnderACrystalclearMi =>
      '嘉峪関の荒野、澄み渡る天の川の満天の星空の下に広がるラグジュアリーなゲルキャンプ。';

  @override
  String get yangtzeRiverThreeGorgesCruise => '長江三峡クルーズ';

  @override
  String get onTheSunDeckOfARiverCruiseShipPassi =>
      '切り立つ断崖が圧倒的な瞿塘峡を通過するクルーズ船のサンデッキにて。';

  @override
  String get buyingAntiquesInBeijingPanjiayuan => '北京・潘家園での骨董品探し';

  @override
  String get aHistoricPotteryKilnFilledWithDelic =>
      '繊細な素焼きの白磁やコバルトブルーの染付磁器が並ぶ歴史ある窯元。';

  @override
  String get suzhouSilkEmbroideryStudio => '蘇州・伝統シルク刺繍工房';

  @override
  String get aPeacefulCanalsideGardenStudioInSuz =>
      '水路沿いの静かな庭園アトリエ。艶やかな絹糸と木製の刺繍枠が並ぶ。';

  @override
  String get backstageAtATraditionalBeijingOpera =>
      '色鮮やかな衣装、化粧鏡、豪華な冠が並ぶ伝統的な京劇の楽屋裏。';

  @override
  String get traditionalChineseMedicineConsultat => '中医師による問診・診断';

  @override
  String get morningTaiChiInTempleOfHeavenPark => '天壇公園での朝の太極拳';

  @override
  String get beneathAncientCypressTreesAtDawnWit =>
      '夜明けの古松の下、小鳥のさえずりと共に息を合わせて太極拳を行う人々。';

  @override
  String get rentingAHanfuForAPhotoShoot => '漢服レンタル＆記念撮影';

  @override
  String get aTraditionalCostumeBoutiqueNearTheW =>
      '西湖のほとりにある漢服ブティック。唐代・宋代の優美な衣が並ぶ。';

  @override
  String get guqinAncientZitherInstrumentWorksho => '古琴（伝統七弦琴）ワークショップ';

  @override
  String get aQuietPinewoodStudioInHangzhouFille =>
      '杭州の静かな松の木のアトリエ。年代物の桐材と絹弦の楽器が置かれている。';

  @override
  String get shaanxiShadowPuppetTheater => '陝西・伝統皮影戯（影絵芝居）';

  @override
  String get behindAnIlluminatedWhiteSilkScreenW =>
      '白い絹スクリーンの背後で、繊細に彫刻された半透明の牛皮人形が踊る。';

  @override
  String get chineseCalligraphyWorkshop => '中国伝統書道ワークショップ';

  @override
  String get aTranquilStudioScentedWithPineSootI =>
      '松煙墨の清らかな墨香、宣紙の巻物、馥郁たる茶の香りに満ちた静寂の書斎。';

  @override
  String get adoptingACatAtAnAnimalShelter => '動物保護シェルターでの保護猫の譲渡';

  @override
  String get aCozyPetRescueCenterInHangzhouWithE =>
      '杭州のアットホームな保護施設。元気な子猫たちとお茶のサービス。';

  @override
  String get scriptMurderMysteryJubenshaGame => 'マーダーミステリー（劇本殺 / ジュベンシャー）';

  @override
  String get aThemedDetectiveLoungeInShanghaiWit =>
      '上海の本格ミステリーラウンジ。衣装をまとった参加者と揺れる蝋燭の灯り。';

  @override
  String get vintageVinylRecordShopInShanghai => '上海のヴィンテージ・アナログレコード店';

  @override
  String get aHiddenVinylStoreInAnOldLaneHousePa =>
      'レトロな石庫門の路地奥に佇む店。80年代の香港ポップスやジャズの名盤がずらり。';

  @override
  String get ktvKaraokePartyWithFriends => '友人たちとのKTVカラオケパーティー';

  @override
  String get joiningACityBikeCyclingClub => '都市型サイクリングクラブへの参加';

  @override
  String get aGatheringOfCyclistsByTheRiverfront =>
      'ウォーターフロントに集うサイクリストたち。夜景の街並みを巡るナイトライドへ。';

  @override
  String get blindBoxToyTradingMeetup => 'ブラインドボックス（ポップトイ）トレード交流会';

  @override
  String get aColorfulPopcultureToyStoreInChaoya =>
      '朝陽区のポップカルチャートイショップ。ディスプレイ棚と未開封のボックスが並ぶ。';

  @override
  String get droneSkylineVideographyAtTheBund => '外灘（バンド）でのドローン夜景空撮';

  @override
  String get theBundPromenadeAtDuskOverlookingTh =>
      '黄昏時の外灘プロムナード。対岸の浦東にそびえる近未来的な超高層ビル群のイルミネーション。';

  @override
  String get goldenRetrieverCafeInNanjing => '南京のゴールデンレトリバーカフェ';

  @override
  String get aSunnyCheerfulPetCafeWithDozensOfFr =>
      '明るい陽光が差し込むドッグカフェ。人懐っこい大型犬たちが迎えてくれる。';

  @override
  String get boulderingClimbingGymInChengdu => '成都のボルダリングジム';

  @override
  String get aModernIndoorClimbingGymWithVibrant =>
      'カラフルなホールドルートとアップテンポな音楽が流れる最新の屋内クライミングジム。';

  @override
  String get aMassiveConventionHallFilledWithCol =>
      '華やかなゲームブース、撮影ブース、コスプレイヤーで賑わう巨大展示ホール。';

  @override
  String get askingForDirectionsInABeijingHutong => '北京の胡同（路地）で道を尋ねる';

  @override
  String get aMazeOfHistoricGreybrickAlleysWithB =>
      '青煉瓦の古民家、中庭、ザクロの木が連なる歴史ある胡同の路地迷路。';

  @override
  String get buyingFreshFruitAtAWetMarket => '伝統市場（菜市場）で新鮮な果物を買う';

  @override
  String get aLivelyMorningNeighborhoodMarketWit =>
      '採れたてのライチやマンゴー、ドラゴンフルーツが山積みされた活気ある朝の市場。';

  @override
  String get flowerMarketBouquetInKunming => '昆明の花市場で花束を選ぶ';

  @override
  String get theFamousDounanFlowerMarketSurround =>
      '無数のバラやユリ、ユーカリの香りに包まれるアジア最大級の斗南花卉市場。';

  @override
  String get tailorAlterationsInAnOldLaneHouse => '路地裏の仕立て屋でのお直し';

  @override
  String get aTraditionalTailorShopFilledWithSew =>
      'ミシン、色鮮やかな反物、メジャーが所狭しと並ぶ伝統的な仕立て工房。';

  @override
  String get expressParcelLockerRetrieval =>
      'スマート宅配ボックス（巣箱 / Hive Box）での荷物受け取り';

  @override
  String get downstairsAtAResidentialApartmentGa =>
      'マンションのエントランス脇、スマートロッカーシステムの設置場所にて。';

  @override
  String get bicycleFlatTireRepairAtCampusGate => '大学の校門前での自転車パンク修理';

  @override
  String get aSmallOutdoorRoadsideToolkitStandUn =>
      '大きなガジュマルの木陰にある、昔ながらの路上修理スタンド。';

  @override
  String get techCompanyProductDemo => 'ITテクノロジー企業の製品デモ';

  @override
  String get aFuturisticTechConferenceBoothInShe =>
      '最先端のAIハードウェアが展示される深圳の近未来的なテック展示会ブース。';

  @override
  String get ecommerceLivestreamStudio => 'ライブコマース（生配信販売）スタジオ';

  @override
  String get aHighenergyBroadcastStudioWithRingL =>
      'リングライト、商品陳列ラック、リアルタイムコメントモニターが並ぶ熱気あふれる配信ブース。';

  @override
  String get yiwuInternationalTradeMarket => '義烏（イーウー）国際商貿城';

  @override
  String get aVastMultistoryCommercialExhibition =>
      '無数の卸売雑貨や工芸品がどこまでも連なる巨大な多層複合卸売マーケット。';

  @override
  String get universityCampusExchangeProgram => '大学キャンパスでの交換留学プログラム';

  @override
  String get aSunnyLawnOutsideTheUniversityLibra =>
      '大学図書館前の芝生広場。ミルクティーを片手に語り合う学生たち。';

  @override
  String get pleaseEnterAScenarioTopic => 'シナリオのトピックを入力してください。';

  @override
  String get nameTitle => '名前（敬称）';

  @override
  String get aiCharacter => 'AIキャラクター';

  @override
  String get helloWelcomeHereWhatShallWeChatAbou =>
      'こんにちは！ようこそ。本日はどのようなテーマでお話ししましょうか？';

  @override
  String get greetYourConversationPartner => '対話相手に挨拶する';

  @override
  String get askAQuestionInChinese => '中国語で質問する';

  @override
  String get pinyinWithToneMarks => '声調記号付きピンイン';

  @override
  String get goal1InEnglish => '学習目標1（日本語）';

  @override
  String get goal2InEnglish => '学習目標2（日本語）';

  @override
  String get goal3InEnglish => '学習目標3（日本語）';

  @override
  String get beginner => '初級';

  @override
  String get hsk12 => 'HSK 1〜2級';

  @override
  String get hsk34 => 'HSK 3〜4級';

  @override
  String get hsk56 => 'HSK 5〜6級';

  @override
  String get master => 'マスター（上級）';

  @override
  String get azurePronunciationAssessment => 'AZURE 発音評価システム';

  @override
  String get tapToReview => 'タップして振り返る';

  @override
  String get overallScore => '総合スコア';

  @override
  String get toneAccuracy => '声調の正確性';

  @override
  String get fluency => '流暢さ';

  @override
  String get report => 'レポート';

  @override
  String get goodPronunciationButCanBeBetter => '良好な発音です！もう少しでさらに良くなります。';

  @override
  String get didYouMeanToSay => 'もしかして「...」と言おうとしましたか？';

  @override
  String get greatKeepTrying => '素晴らしい！この調子で練習しましょう！';

  @override
  String get completeness => '完全度（欠落なし）';

  @override
  String get targetTone => '目標とする声調';

  @override
  String get k4toneComparisonTapToListen => '四声の比較（タップして試聴）：';

  @override
  String get youSpokeMatch => 'あなたの発音（一致！）';

  @override
  String get youSpoke => 'あなたの発音';

  @override
  String get yourPrimaryCollectionOfCharacters => 'あなたのメイン漢字コレクション。';

  @override
  String get deckNotFound => 'デッキが見つかりません';

  @override
  String get cannotDeleteTheDefaultDeck => 'デフォルトデッキは削除できません';

  @override
  String get hsk4UpperIntermediate1 => 'HSK 4級：中上級';

  @override
  String get theFirst150CharactersToStartYourJou => '第一歩を踏み出すための基本150文字。';

  @override
  String get buildYourVocabularyTo300EssentialWo => '必須の300語で語彙力を身につけましょう。';

  @override
  String get masterConversationalFluencyWith600W => '日常会話を流暢にこなすための600語。';

  @override
  String get readTextsAndConverseFluentlyWith120 => '文章を読み込み自在に会話するための1200語。';

  @override
  String get readNewspapersAndWatchMoviesWith250 => '新聞を読み映画を楽しむための2500語。';

  @override
  String get databaseBoxNotOpen => 'データベースが開かれていません';

  @override
  String get hsk1DataFileIsEmpty => 'HSK 1級のデータファイルが空です';

  @override
  String get gold => 'ゴールド';

  @override
  String get globalDictionaryNotInitialized => 'グローバル辞書が初期化されていません';

  @override
  String get reading => 'リーディング';

  @override
  String get recall => 'リコール（想起）';

  @override
  String get speaking => 'スピーキング';

  @override
  String get listening1 => 'リスニング';

  @override
  String get practiceStrokeOrderWithVisualGuides => '視覚ガイドに沿って正しい筆順を身につけましょう。';

  @override
  String get seeTheCharacterRecallThePinyinAndMe => '漢字を見て、ピンインと意味を思い出しましょう。';

  @override
  String get seeTheMeaningDrawTheCharacterFromMe => '意味を見て、記憶を頼りに漢字を書きましょう。';

  @override
  String get readOutLoudToTestYourPronunciationT =>
      '声に出して読み上げ、発音と声調をチェックしましょう。';

  @override
  String get listenToTheAudioAndIdentifyTheChara => '音声を聞いて正しい漢字を選びましょう。';

  @override
  String get contract => 'インターフェース仕様';

  @override
  String get whoeverImplementsMeMustBeAbleToDoTh =>
      'このインターフェースを実装するクラスは、以下の処理を実装する必要があります。';

  @override
  String get koreFenrirCharonAoedePuckOrLocal =>
      'Kore、Fenrir、Charon、Aoede、Puck、または端末ローカル音声';

  @override
  String get manageDecks => 'デッキの管理';

  @override
  String get weRanIntoTroubleLoadingTheLibraryPl =>
      'ライブラリの読み込みに失敗しました。もう一度お試しください。';

  @override
  String get noCharactersInLexicon1 => '辞書に漢字が登録されていません';

  @override
  String get masterTheBuildingBlocks => '漢字の構成パーツをマスター';

  @override
  String get other => 'その他';

  @override
  String get required => '必須';

  @override
  String get library1 => 'ライブラリ';

  @override
  String get youAreAPremiumMember => 'プレミアム会員です';

  @override
  String get createAccountToSyncProgress => 'アカウントを作成して進捗をクラウド同期';

  @override
  String get signOut => 'サインアウト';

  @override
  String get account => 'アカウント';

  @override
  String get guestScholar => 'ゲスト探求者';

  @override
  String get localAccount => 'ローカルアカウント';

  @override
  String get unknownRadical => '未登録の部首';

  @override
  String get followTheGuideStroke => 'ガイド線に沿って運筆する';

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
  String get today1d2d3d4d5d6d => '今日、1日後、2日後、3日後、4日後、5日後、6日後';

  @override
  String get targetDeck => '追加先デッキ';

  @override
  String get mixed => '総合（ミックス）';

  @override
  String get topicForContext => 'トピック（文脈）';

  @override
  String get nounsOnly => '名詞のみ';

  @override
  String get verbsOnly => '動詞のみ';

  @override
  String get idiomsChengyu => '成語・慣用句（成语）';

  @override
  String get fullSentences => '完全な文章';

  @override
  String get beginnerHsk12 => '初級（HSK 1〜2級）';

  @override
  String get intermediateHsk34 => '中級（HSK 3〜4級）';

  @override
  String get advancedHsk56 => '上級（HSK 5〜6級）';

  @override
  String get generatedByAi => 'AI生成';

  @override
  String get canYouGiveMeTwoMoreExamplesUsingThi =>
      'この単語を使った例文をあと2つ教えていただけますか？';

  @override
  String get whatAreSomeSimilarWordsAndHowDoThey =>
      '類義語にはどのようなものがあり、ニュアンスはどう違いますか？';

  @override
  String get isThisWordUsedInSpokenOrWrittenChin =>
      'この言葉は話し言葉と書き言葉のどちらでよく使われますか？';

  @override
  String get areThereOtherWaysToTranslateThisWor => 'この単語には他にどのような訳語や表現がありますか？';

  @override
  String get whatAreCommonWordsThatGoTogetherWit =>
      'この単語とよく一緒に使われる単語（コロケーション）は何ですか？';

  @override
  String get whatAreCommonMistakesLearnersMakeWi =>
      '学習者がこの単語でよくやってしまう典型的な間違いは何ですか？';

  @override
  String get emptyResponse => '応答がありませんでした';

  @override
  String get whatIsTheOracleBoneScriptOriginOfTh =>
      'この漢字の甲骨文字における起源や成り立ちは何ですか？';

  @override
  String get howDidTheAncientFormOfThisCharacter =>
      'この漢字の古代の字形はどのように変遷・進化しましたか？';

  @override
  String get giveMe3CommonWordsThatContainThisCh => 'この漢字を含む一般的な語彙を3つ挙げてください。';

  @override
  String get whatOtherCharactersShareTheSameRadi => '同じ部首を持つ代表的な漢字には何がありますか？';

  @override
  String get isThereAChineseProverbOrSayingFeatu =>
      'この漢字が含まれる中国のことわざや名言はありますか？';

  @override
  String get explainTheStrokeOrderRulesForThisCh =>
      'この漢字の筆順（書き順）のルールを解説してください。';

  @override
  String get giveMeOneCalligraphyTipForWritingTh =>
      'この漢字を美しく書くための書道のコツを1つ教えてください。';

  @override
  String get isThereAnythingTrickyAboutUsingThis => '文法的な使い方で特に注意すべき点はありますか？';

  @override
  String get whatWordsAreCommonlyConfusedWithThi =>
      'この単語と混同しやすい語彙は何ですか？違いも教えてください。';

  @override
  String get doesThisCharacterCarryCulturalSymbo =>
      'この漢字は中国文化においてどのような象徴的意味を持っていますか？';

  @override
  String get isThisCharacterCommonlySeenInChines =>
      'この漢字は中国の映画、楽曲、現代文学などで頻出しますか？';

  @override
  String get whatDoesTheRadicalOfThisCharacterMe =>
      'この漢字の部首にはどのような意味が込められていますか？';

  @override
  String get breakDownEveryComponentAndItsMeanin =>
      'すべての構成パーツを分解し、それぞれの意味を説明してください。';

  @override
  String get giveMeATrickToRememberTheCorrectTon =>
      'この漢字の正しい声調を覚えるための語呂合わせやコツを教えてください。';

  @override
  String get areThereCommonHomophonesThatAreOfte => '混同しやすい同音異義語はありますか？';

  @override
  String get quotaExceeded => '利用枠の上限に達しました';

  @override
  String get mustProvideEitherCardOrCards => '単一カードまたはカードリストのいずれかを指定する必要があります';

  @override
  String get deckSettings => 'デッキ設定';

  @override
  String get saveSettings => '設定を保存';

  @override
  String get sealRed => '朱印（印泥の赤）';

  @override
  String get sealScript => '篆書体（てんしょたい）';

  @override
  String get startYourStreak => '連続学習記録をスタート';

  @override
  String get traditionalCharacter => '繁体字';

  @override
  String get inQueue => '復習待ち';

  @override
  String get tapToListenAgain => 'タップしてもう一度聴く';

  @override
  String get contextClue => '文脈の手がかり';

  @override
  String get microphonePermissionRequired1 => 'マイクのアクセス許可が必要です。';

  @override
  String get recordingFailedNoFile => '録音に失敗しました（音声ファイルが作成されませんでした）。';

  @override
  String get holdToSpeakOptional => '長押しして発話（任意）';

  @override
  String get microphonePermissionDeniedEnableItI =>
      'マイクの許可が拒否されています。シャドーイングスタジオをご利用いただくには「設定」から許可してください。';

  @override
  String get sessionSummary => 'セッション結果の概要';

  @override
  String get hereAreTheCharactersYouStruggledWit => '今回のセッションで苦手だった漢字：';

  @override
  String get applySessionGradesToSpacedRepetitio =>
      'セッション結果を分散学習システム（スピーキングモード）に反映';

  @override
  String get masterYourMandarinPronunciationnbyM =>
      'ネイティブの音声を真似て、\n中国語の自然な発音をマスターしましょう。';

  @override
  String get aiIsGradingYourPronunciation => 'AIが発音を判定中...';

  @override
  String get holdMicToRecordReleaseToGrade => '長押しして録音。指を離して採点。';

  @override
  String get tapAnySyllableToAuditionAll4Tones => '音節をタップすると4つの声調すべてを試聴できます：';

  @override
  String get freeFlowConversationalPractice => '自由対話形式の会話練習。';

  @override
  String get failedToGeneratePhrasePleaseTryAgai =>
      'フレーズの生成に失敗しました。もう一度お試しください。';

  @override
  String get recordingTooShortHoldTheMicButtonLo =>
      '録音が短すぎます。マイクボタンを長めに押してお話しください。';

  @override
  String get recordingErrorPleaseTryAgain => '録音エラーが発生しました。もう一度お試しください。';

  @override
  String get noRecordingCapturedPleaseTryAgain => '音声が録音されませんでした。もう一度お試しください。';

  @override
  String get recordedAudioIsEmptyPleaseTryAgainA =>
      '録音された音声データが空です。明瞭にお話しください。';

  @override
  String get azureSpeechApiKeysAreMissing1 => 'Azure Speech APIキーが見つかりません';

  @override
  String get azureError401 => 'Azure エラー 401';

  @override
  String get azureAuthenticationFailedCheckYourS =>
      'Azure認証に失敗しました。.envファイルのSpeech APIキーとリージョンを確認してください。';

  @override
  String get azureError429 => 'Azure エラー 429';

  @override
  String get azureQuotaExceededTryAgainLater =>
      'Azure APIのクォータ上限に達しました。しばらくしてからお試しください。';

  @override
  String get azureGradingTimedOutCheckYourIntern =>
      'Azure採点がタイムアウトしました。通信環境をご確認ください。';

  @override
  String get recognitionFailedNull => '音声認識エラー: null';

  @override
  String get couldNotHearYouClearlyPleaseTryAgai =>
      '音声を明瞭に聞き取れませんでした。もう一度お試しください。';

  @override
  String get singlePhrasePractice => 'ワンフレーズ集中練習';

  @override
  String get failedToGeneratePhrase => 'フレーズの生成に失敗しました';

  @override
  String get omitted => '脱落';

  @override
  String get partial => '部分一致';

  @override
  String get mispronounced => '発音ミス';

  @override
  String get startSession1 => 'セッション開始';

  @override
  String get chinese => '中国語';

  @override
  String get paused => '一時停止';

  @override
  String get translationFailed => '翻訳に失敗しました';

  @override
  String get engagingMacroeconomicAndBusinessBre =>
      '生き生きとした語り口で解説される、わかりやすく深いマクロ経済とビジネスの動向。';

  @override
  String get exploresWorldEconomiesBankingHistor =>
      '世界経済、銀行の歴史、グローバル産業の力学を解き明かす。';

  @override
  String get clearArticulateMandarinPerfectForIn =>
      '中級・上級のリスニングに最適な、明瞭で格調高い中国語。';

  @override
  String get chefWang => '王剛（ワンガン）シェフ';

  @override
  String get masterSichuanCulinaryTechniquesTaug =>
      'プロの料理長が直伝する、本場・四川料理の本格調理技術。';

  @override
  String get stepbystepAuthenticChineseRecipesWi =>
      '強火の中華鍋さばきや精緻な包丁使いを学べる、本格中華のステップ別レシピ。';

  @override
  String get conciseCulinaryVocabularyAndClearIn =>
      '簡潔な料理専門語彙と、無駄のない明快な中国語での解説。';

  @override
  String get cinematographyCuttingedgeCameraTech =>
      '映像美、最新の撮影機材、デジタルメディアに関する徹底的なレビュー。';

  @override
  String get highproductionDocumentaryStyleExplo =>
      '動画制作とAIイノベーションを探求する、ハイクオリティなドキュメンタリースタイル。';

  @override
  String get richTechnicalMandarinWithCrystalcle =>
      'クリアな発音と見やすいテロップによる、豊かな専門的中国語表現。';

  @override
  String get indepthInvestigativeJournalismAndCu => '綿密な調査報道と鋭い時事問題の論評。';

  @override
  String get criticalPerspectivesOnSocialPhenome =>
      '社会現象、国際ニュース、歴史を多角的に分析する批評的視点。';

  @override
  String get formalInvestigativeDiscourseIdealFo =>
      '高度な聴解力（リスニング）向上に最適な、知的な論述・報道表現。';

  @override
  String get bitesizedAnimatedScienceDocumentari =>
      '日常の素朴な疑問に答える、テンポの良いショートアニメ科学解説。';

  @override
  String get exploresPhysicsBiologyAndEverydayCu =>
      '物理・生物から身の回りの現象まで、楽しいインフォグラフィックで解明。';

  @override
  String get standardBeijingMandarinWithWellpace =>
      'リズミカルなナレーションと明瞭な字幕による標準的な北京普通話。';

  @override
  String get heartwarmingStreetFoodAdventuresAnd =>
      '心温まる屋台グルメの旅と、中国各地の市井の人々との温かな対話。';

  @override
  String get exploresRegionalHumanStoriesFamilyT => '地域ごとの人間模様、家族の伝統、郷土の味を探る。';

  @override
  String get naturalConversationalMandarinWithDa =>
      '日常の流行語や温かい感情がこもった、自然で生きた日常会話表現。';

  @override
  String get humorousAndHonestConsumerElectronic =>
      '実体験に基づく、ユーモアにあふれた率直なガジェット・家電レビュー。';

  @override
  String get testingSmartphonesSmartHomeGadgetsA =>
      'スマートフォン、スマート家電、最新デジタルグッズの実機検証。';

  @override
  String get relaxedHumorousConversationalDialog =>
      '現代の口語スラングを取り入れた、リラックスした軽妙なトーク。';

  @override
  String get seanKitchen => 'ショーンの台所';

  @override
  String get deliciousHomecookedChineseDishesAnd => '美味しい家庭料理と屋台の定番スナックの再現レシピ。';

  @override
  String get easytofollowKitchenTipsForCookingAu =>
      '本格的なアジア家庭料理を美味しく作るためのわかりやすいコツ。';

  @override
  String get warmInvitingCommentaryWithPractical => '実用的な料理用語を交えた、温かく親しみやすい解説。';

  @override
  String get chineseChannel => 'チャイナ・チャンネル';

  @override
  String get structuredChineseLanguageLessonsAnd =>
      '体系的な中国語レッスンと、文化の魅力を再発見するチュートリアル。';

  @override
  String get grammarPointsHskVocabularyBuildingA =>
      '重要文法、HSK頻出語彙の構築、実用的な会話パターン。';

  @override
  String get clearEducationalPacingTailoredSpeci =>
      '中国語学習者向けに最適化された、分かりやすく丁寧な指導テンポ。';

  @override
  String get oneInABillion => 'ワン・イン・ア・ビリオン（14億分の1の物語）';

  @override
  String get intimatePortraitsAndStoriesOfUnique =>
      '現代中国を生きる個性豊かな人々の素顔と生き様に迫るドキュメンタリー。';

  @override
  String get exploresDiverseLifeChoicesYouthCult =>
      '多様な生き方の選択、若者カルチャー、現代社会の価値観の変遷を探る。';

  @override
  String get deepNarrativeStorytellingWithRichVo =>
      '豊かな語彙と当事者の肉声で紡がれる、深みのあるストーリーテリング。';

  @override
  String get vickySoup => 'ヴィッキーの日常（Vicky Soup）';

  @override
  String get aestheticLifestyleVlogsFashionStyli =>
      'ハイセンスなライフスタイルVlog、ファッションコーデ、日々のルーティン。';

  @override
  String get travelDiariesAndCozyLifeMomentsDocu =>
      '映画のような美しい映像美で切り取る、心地よい旅と日常の記録。';

  @override
  String get naturalCasualMandarinSpokenAtAComfo =>
      '聴き取りやすい適度なスピードで話される、自然で等身大のカジュアル中国語。';

  @override
  String get tededMandarin => 'TED-Ed 中国語版';

  @override
  String get highqualityAnimatedEducationalLesso =>
      '科学・哲学・歴史をテーマにした、高品質なアニメーション教育動画。';

  @override
  String get thoughtprovokingRiddlesClassicLiter =>
      '知的好奇心を刺激する謎解き、古典文学の深層、心理学の不思議。';

  @override
  String get impeccableVoiceoverMandarinWithSync =>
      '同期された日英・中日字幕付きの、極めて美しい標準中国語ナレーション。';

  @override
  String get channel => 'チャンネル';

  @override
  String get curatedCulturalDocumentariesAndChin =>
      '厳選された文化ドキュメンタリーと、現代中国のライフスタイルの精華。';

  @override
  String get exploringTraditionalArtsHeritageCra =>
      '伝統工芸、無形文化遺産、そして現代のトレンドの融合を探る。';

  @override
  String get highQualityAudioWithSynchronizedChi => '中国語字幕が同期された高音質オーディオトラック。';

  @override
  String get interestingStoriesAndCreativeVideoP =>
      '中国のネット空間で話題のユニークなストーリーとクリエイティブ動画。';

  @override
  String get engagingInterviewsStorytellingAndVi =>
      '引き込まれるインタビュー、心揺さぶる語り、美しい映像美。';

  @override
  String get greatListeningMaterialWithStandardP => '標準的な美しい発音で学べる、極上のリスニング教材。';

  @override
  String get xVsY => 'X 対 Y';

  @override
  String get untitled => '無題';

  @override
  String get contemporaryStories => '現代ストーリー';

  @override
  String get history => '歴史';

  @override
  String get advancedReading => '上級読解';

  @override
  String get intermediateReading => '中級読解';

  @override
  String get beginnerReading => '初級読解';

  @override
  String get mandarinBean => 'Mandarin Bean';

  @override
  String get unknown => '不明';

  @override
  String get localDb => 'ローカルデータベース';

  @override
  String get emperorTaizong => '太宗（李世民）';

  @override
  String get emperorXuanzong => '玄宗（李隆基）';

  @override
  String get liBai => '李白';

  @override
  String get gradedReader => 'レベル別リーダー（多読教材）';

  @override
  String get ucj10r97lkwgdtqbt6xzv8gLearnMandari => 'TaiwanPlusで学ぶ中国語';

  @override
  String get ucsxriuqkzzmaqklq0n9xfvwEverydayChi => '日常中国語会話';

  @override
  String get graceMandarinChinese => 'Grace Mandarin Chinese';

  @override
  String get ucolbhvvl5dcjlmzeqbuu1vwTingdailyLi => 'Ting: 中国の日常Vlog';

  @override
  String get xinxin => '欣欣（シンシン）';

  @override
  String get sweetFamilyDailyLife => '心温まる家族の日常';

  @override
  String get chinsunDailyLife => 'チン・サンの日常生活';

  @override
  String get tasteChina => '中国の味覚を巡る旅';

  @override
  String get dawenFoodQuest => 'ダーウェンのグルメ探訪';

  @override
  String get chinaTravelWithCangbao => 'カンバオと巡る中国の旅';

  @override
  String get alinFoodWalk => 'アリンの街角食べ歩き';

  @override
  String get videoOfTheDay => '本日の動画';

  @override
  String get noValidVideoFound => '再生可能な動画が見つかりませんでした。';

  @override
  String get listeningPractice => 'リスニング特訓';

  @override
  String get socialSkills => 'コミュニケーション術';

  @override
  String get culturalContext => '文化的背景';

  @override
  String get realLife => 'リアルな実生活';

  @override
  String get realWorld => '生きた中国語';

  @override
  String get articleOfTheDay => '本日の記事';

  @override
  String get failedToLoadOrParseRssFeed => 'RSSフィードの読み込みまたは解析に失敗しました。';

  @override
  String get drama => 'ドラマ';

  @override
  String get youkugetAppNow => 'YOUKU: アプリを今すぐダウンロード';

  @override
  String get romanceTrailer => 'ロマンス / 予告編';

  @override
  String get romance => '恋愛・ロマンス';

  @override
  String get action => 'アクション';

  @override
  String get mystery => 'サスペンス・ミステリー';

  @override
  String get historical => '時代劇・古装劇';

  @override
  String get historicalAction => '時代劇 / アクション';

  @override
  String get historicalRomance => '時代劇 / ロマンス';

  @override
  String get anYouth => '青春群像劇';

  @override
  String get historicalSliceOfLife => '時代劇 / 日常・ヒューマンドラマ';

  @override
  String get historicalHighlight => '時代劇 / 名場面ハイライト';

  @override
  String get youkuEnglishgetAppNow => 'YOUKU English: アプリを今すぐダウンロード';

  @override
  String get theDouble => '墨雨雲間（The Double）';

  @override
  String get updatesByOshin => 'Oshinによる最新情報';

  @override
  String get backFromTheBrink => '護心（Back From the Brink）';

  @override
  String get fallingIntoYourSmile => '君の笑顔にメロメロ（Falling Into Your Smile）';

  @override
  String get everyoneLovesMe => '誰もが私に恋をする（Everyone Loves Me）';

  @override
  String get tillTheEndOfTheMoon => '長月燼明（Till The End of The Moon）';

  @override
  String get theBestDayOfMyLife => '人生で最高の日（The Best Day of My Life）';

  @override
  String get gikkiChineseDrama => 'GIKKI 中国ドラマ';

  @override
  String get dashingYouth => '少年白馬酔春風（Dashing Youth）';

  @override
  String get rebornChineseDramaEngSub => '重生（Reborn）中国ドラマ';

  @override
  String get ijenwaBenita => 'Ijenwa Benita';

  @override
  String get whenIFlyTowardsYou => '君に向かって羽ばたく時（When I Fly Towards You）';

  @override
  String get mztvExclusiveChineseDrama => 'MZTV独占 中国ドラマ';

  @override
  String get theStarryLove => '星落凝成糖（The Starry Love）';

  @override
  String get comedy => 'コメディ';

  @override
  String get backFromTheBrink1 => '護心';

  @override
  String get dashingYouth1 => '少年白馬酔春風';

  @override
  String get beReborn => '生まれ変わる';

  @override
  String get beautyStrategy => '美の戦略';

  @override
  String get myDivineEmissary => '天降神使';

  @override
  String get theHope => '鳴龍少年（The Hope）';

  @override
  String get ep16In => '第16話';

  @override
  String get everyoneLovesMe1 => '誰もが私に恋をする';

  @override
  String get fallingIntoYourSmile1 => '君の笑顔にメロメロ';

  @override
  String get hiddenLove => '偷偷蔵不住（Hidden Love）';

  @override
  String get loveBetweenFairyAndDevil => '蒼蘭訣（Love Between Fairy and Devil）';

  @override
  String get loveLikeTheGalaxy => '星漢燦爛（Love Like the Galaxy）';

  @override
  String get membersPremiere => 'VIP会員先行配信';

  @override
  String get moonlight => '月光変奏曲（Moonlight）';

  @override
  String get myJourneyToYou => '雲之羽（My Journey to You）';

  @override
  String get mysteriousLotusCasebook => '蓮花楼（Mysterious Lotus Casebook）';

  @override
  String get rebornChineseDramaEngSub1 => '重生（Reborn）';

  @override
  String get reborn => '重生';

  @override
  String get theBestDayOfMyLife1 => '人生で最高の日';

  @override
  String get theDouble1 => '墨雨雲間';

  @override
  String get theLongBallad => '長歌行（The Long Ballad）';

  @override
  String get theStarryLove1 => '星落凝成糖';

  @override
  String get theUntamed => '陳情令（The Untamed）';

  @override
  String get tillTheEndOfTheMoon1 => '長月燼明';

  @override
  String get whenIFlyTowardsYou1 => '君に向かって羽ばたく時';

  @override
  String get wordOfHonor => '山河令（Word of Honor）';

  @override
  String get blossom => '繁花';

  @override
  String get gemini => 'Gemini';

  @override
  String get generationToGeneration => '代々受け継がれるもの';

  @override
  String get brocadeOdyssey => '蜀錦人家（Brocade Odyssey）';

  @override
  String get circleOfLove => '鎖愛三生（Circle of Love）';

  @override
  String get dawnIsBreaking => '黎明の兆し';

  @override
  String get firstRomance => '初恋ロマンス';

  @override
  String get loveInTheClouds => '雲の上の恋';

  @override
  String get secondChanceRomance => '大人のリスタート恋愛';

  @override
  String get mrBad => '私の悪役彼氏（Mr. Bad）';

  @override
  String get pursuitOfJade => '玉を追う者';

  @override
  String get fatedHearts => '運命の糸';

  @override
  String get roadHome => '帰路（Road Home）';

  @override
  String get myDearGuardian => '愛上特種兵（My Dear Guardian）';

  @override
  String get brightEyesInTheDark => '他従火光中走来（Bright Eyes in the Dark）';

  @override
  String get theIngeniousOne => '雲襄伝（The Ingenious One）';

  @override
  String get herPhoenixMajesty => '鳳凰の玉座';

  @override
  String get dreamsNeverEnd => '終わりなき夢';

  @override
  String get theUltimateVowUnknownToYou => '秘められた誓い';

  @override
  String get the300LoyalGhosts => '三百の英霊';

  @override
  String get homelandGuardian => '祖国の守護者';

  @override
  String get loveIsAlwaysOnline => 'オンラインで繋がる恋';

  @override
  String get thePrincessDecree => '王女の勅令';

  @override
  String get aVowInTheDark => '暗闇の誓い';

  @override
  String get aGirlLikeMe => '私のような女子（我就是這般女子）';

  @override
  String get iAmNobody => '異人之下（I Am Nobody）';

  @override
  String get myMamaGo => '母さん、前へ！';

  @override
  String get myWesternRegionPrincess => '西域のお姫様';

  @override
  String get aFlowerOnTheContinent => '大陸に咲く花';

  @override
  String get thePrincess => '王女';

  @override
  String get sweetLoveVersion => '胸キュン・スイート版';

  @override
  String get hilariousFamily2 => 'ドタバタ家族奮闘記 2';

  @override
  String get guYuanMountainHasASchool => '顧源山の学び舎';

  @override
  String get foreverYoung => '永遠の青春';

  @override
  String get theHiddenHeirYeChen => '秘められた後継者・葉辰';

  @override
  String get extraordinary => '非凡なる道';

  @override
  String get sideStoryOfFoxVolant => '飛狐外伝（Side Story of Fox Volant）';

  @override
  String get loveOfTheDivineTree => '神木に宿る恋';

  @override
  String get rebirth => '転生・生まれ変わり';

  @override
  String get moonlitReunion => '月下の再会';

  @override
  String get videoCountsCannotBeNegative => '動画数は0以上の数値を指定してください。';

  @override
  String get publicDomainClassic => '著作権フリーの古典名作';

  @override
  String get idioms => '成語・慣用句';

  @override
  String get news => 'ニュース';

  @override
  String get fairyTales => '童話・おとぎ話';

  @override
  String get hereIsAFascinatingCulturalExplanati => '興味深い文化的背景の解説はこちら：';

  @override
  String get videoFetchTimedOut => '動画の取得がタイムアウトしました';

  @override
  String get aboutChannel => 'チャンネル紹介';

  @override
  String get noVideosFound => '動画が見つかりませんでした';

  @override
  String get failedToLoadVideos => '動画の読み込みに失敗しました';

  @override
  String get highqualityCuratedMandarinContentWi =>
      '生きた語彙を学べる、厳選された高品質な中国語コンテンツ。';

  @override
  String get authenticSpokenChineseAcrossRealwor =>
      '日常のリアルな場面や多彩なトピックで使われる本物の中国語会話。';

  @override
  String get engagingVideoMaterialWithInteractiv =>
      'インタラクティブな同期字幕を備えた魅力的な動画教材。';

  @override
  String get watchVideo => '動画を視聴する';

  @override
  String get culturalInsight => '文化的インサイト';

  @override
  String get aiIsAnalyzingCulturalContext => 'AIが文化的背景を分析中...';

  @override
  String get diveIntoFullContent => 'コンテンツ全文を読む';

  @override
  String get savedArticles => '保存した記事';

  @override
  String get liveOverlay => 'ライブオーバーレイ';

  @override
  String get webExplorer => 'Webエクスプローラー';

  @override
  String get browseAnyChineseWebsiteWithRealtime =>
      'タップ辞書、ピンイン注釈、即時翻訳を活用して、あらゆる中国語Webサイトを快適に閲覧。';

  @override
  String get startExploring => '探索を開始する';

  @override
  String get chineseTvSeriesWithInteractiveSubti => 'インタラクティブ字幕付き中国語ドラマ';

  @override
  String get failedToLoadContent => 'コンテンツの読み込みに失敗しました';

  @override
  String get searchingYoutube => 'YouTubeを検索中...';

  @override
  String get noVideosFoundTryADifferentSearchTer =>
      '動画が見つかりませんでした。別のキーワードをお試しください。';

  @override
  String get searching => '検索中...';

  @override
  String get noShowsFound => '番組が見つかりませんでした';

  @override
  String get bookmarked => 'ブックマーク済み';

  @override
  String get trailer1 => '予告編';

  @override
  String get highlight1 => 'ハイライト';

  @override
  String get noCaptionsAvailable => '利用可能な字幕がありません';

  @override
  String get fetchingSubtitles => '字幕を取得中...';

  @override
  String get generatingAiBriefing => 'AI要約を作成中...';

  @override
  String get noClosedCaptionsCcFoundForThisVideo =>
      'この動画にはデジタル字幕（CC）が含まれていません。';

  @override
  String get videosWithHardcodedOrBurnedinSubtit =>
      '動画自体に焼き付けられた字幕は、YouTubeのテキスト字幕として取得できません。';

  @override
  String get translatingSubtitles => '字幕を翻訳中...';

  @override
  String get processingYourPronunciation => '発音データを処理中...';

  @override
  String get couldntIdentifyLine => '該当の行を特定できませんでした。';

  @override
  String get listeningSpeakNow => '聞き取り中... お話しください。';

  @override
  String get thisVideoDoesNotHaveADigitalClosedC =>
      'この動画にはYouTube上で取得可能なデジタル字幕（CC）がありません。';

  @override
  String get perfect1 => '完璧';

  @override
  String get thisVideoHasBeenRemovedOrIsNoLonger => 'この動画は削除されたか、現在非公開になっています。';

  @override
  String get thisVideoCannotBePlayedInTheAppYouC =>
      'この動画はアプリ内再生に対応していません。YouTubeでご覧いただけます。';

  @override
  String get yourDeviceCannotPlayThisVideoPlease =>
      'お使いの端末ではこの動画を再生できません。別の動画をお試しください。';

  @override
  String get invalidVideoReferencePleaseTryAgain =>
      '動画の参照URLが無効です。もう一度お試しください。';

  @override
  String get unableToLoadThisVideoPleaseTryAnoth =>
      '動画を読み込めませんでした。別の動画をお試しください。';

  @override
  String get startReading => '読書を始める';

  @override
  String get analyzingCulturalContext => '文化的背景を分析中...';

  @override
  String get failedToLoadCulturalInsight => '文化的背景の読み込みに失敗しました。';

  @override
  String get historicalContext => '歴史的背景';

  @override
  String get culturalSignificance => '文化的意義';

  @override
  String get authorBackground => '著者の背景・生涯';

  @override
  String get k80CompleteClassicNovelsWorldEpics => '80作品以上の古典小説・世界叙事詩を完全収録';

  @override
  String get storyOfTheDay => '本日のストーリー';

  @override
  String get tangDynasty => '唐代';

  @override
  String get poetryClassicalVerse => '漢詩・古典詩・韻文';

  @override
  String get allHsk => '全HSKレベル';

  @override
  String get allStories => 'すべてのストーリー';

  @override
  String get keyWords => '重要キーワード';

  @override
  String get openOriginalWebsite => '元のWebサイトを開く';

  @override
  String get aiReadingTools => 'AI読書アシスタント';

  @override
  String get enhanceYourReadingWithAipoweredTool => 'AI搭載ツールで読解力を飛躍的にアップ';

  @override
  String get chooseTheTargetDifficultyForSimplif => '平易化の目標難易度を選択してください';

  @override
  String get chooseDifficultyForSimplification => '平易化の難易度を選択';

  @override
  String get extractAllUnknownWordsToANewFlashca =>
      '未知の単語をすべて新しいフラッシュカードデッキに抽出';

  @override
  String get length => '文字数・長さ';

  @override
  String get m1554846a550010707 => 'M15.54 8.46a5 5 0 0 1 0 7.07';

  @override
  String get m1907493a101000101414 => 'M19.07 4.93a10 10 0 0 1 0 14.14';

  @override
  String get webExtraction => 'Webテキスト抽出';

  @override
  String get aiTools => 'AIツール';

  @override
  String get stop => '停止';

  @override
  String get keepPracticing1 => '練習を続ける';

  @override
  String get aiPrepRoom => 'AI準備室';

  @override
  String get lessonSummary => 'レッスンのまとめ';

  @override
  String get unlockSinosparkPremium => 'SinoSpark プレミアムをアンロック';

  @override
  String get monthYear => '月 / 年';

  @override
  String get enableNotifications => '通知を有効にする';

  @override
  String get notificationsConfigured => '通知が設定されました';

  @override
  String get neverMissAStroke2 => '一画一画を大切に';

  @override
  String get yourDailyDropAndStreakAlertsArePrim =>
      'デイリードロップと連続記録アラートの設定が完了しました。';

  @override
  String get stayConsistentWithDailyRitualDropsA =>
      '毎日の学習コンテンツとタイムリーなリマインダーで、習慣化をサポートします。';

  @override
  String get aNewWordAndStoryWaitingForYourDaily =>
      '毎日の学習習慣に、新しい単語とストーリーが届いています。';

  @override
  String get gentlePromptsBeforeCharactersFadeFr =>
      '記憶が薄れる前に、最適なタイミングで復習をお知らせします。';

  @override
  String get receiveAReminder2DaysBeforeYourFree =>
      '無料トライアル終了の2日前にお知らせリマインダーをお届けします。';

  @override
  String get yourPathTonchineseFluency => '中国語マスターへの道';

  @override
  String get answer3QuickQuestionsSoOurAiCanCraf =>
      '簡単な3つの質問に答えるだけで、\nAIがあなたの生活リズムに合わせた学習カリキュラムを作成します。';

  @override
  String get whatIsYourLevelnwithChinese => 'あなたの中国語レベルは？';

  @override
  String get chooseThePathThatFitsYourDepth => 'あなたの習熟度に合った学習コースを選択してください。';

  @override
  String get whatDrivesYourStudy => '中国語を学ぶ目的は何ですか？';

  @override
  String get purposeFuelsTheBrush => '目的が筆を動かす原動力になる';

  @override
  String get setYourDailyRitual => '毎日の学習習慣を設定しましょう。';

  @override
  String get youCanAdjustYourRitualAnyTime => '学習習慣はいつでも設定から変更できます。';

  @override
  String get letsBegin => 'さあ、始めましょう';

  @override
  String get brandNew => '入門（はじめて学ぶ）';

  @override
  String get iveNeverStudiedChineseBefore => '中国語を学んだことがありません。';

  @override
  String get iKnowBasicCharactersAndPhrases => '基本的な漢字や挨拶フレーズを知っています。';

  @override
  String get iCanHoldConversationsAndRead => '簡単な日常会話ができ、短文を読めます。';

  @override
  String get iWantToRefineAndPerfectMySkills => '表現力を磨き、さらに高度なレベルを目指したいです。';

  @override
  String get confirmSelection => '選択を確定する';

  @override
  String get purposeFuelsTheBrushsMotion => '確固たる目的が、筆の運びを力強く導きます。';

  @override
  String get buildMyPath => 'マイコースを作成';

  @override
  String get hskCertification => 'HSK試験合格・資格取得';

  @override
  String get culturalAppreciation => '中国文化・歴史・芸術への興味';

  @override
  String get yourPlanIsReady => '学習プランが完成しました';

  @override
  String get craftingYourCurriculum => 'オーダーメイドのカリキュラムを作成中...';

  @override
  String get personalizedPathInitialized => 'パーソナライズ学習パスが初期化されました';

  @override
  String get calibratingAiNeuralMasters => 'AIニューラルマスターを調整中...';

  @override
  String get calibrationComplete => '調整が完了しました';

  @override
  String get synthesizingModules => '学習モジュールを統合中...';

  @override
  String get oneAndWater => '「一」と「水」';

  @override
  String get theHorizontalStroke => '基本筆画：横画（ヘン）';

  @override
  String get theRadical => '部首（ブシュ）';

  @override
  String get water => '水';

  @override
  String get river => '川・江';

  @override
  String get day5Reminder => '5日目のお知らせ';

  @override
  String get wePromisedToAlertYou2DaysBeforeYour =>
      '無料トライアル終了の2日前にお知らせするお約束でした。';

  @override
  String get continueWithoutReminder => 'リマインダーなしで続行';

  @override
  String get masterChineseWithnsinospark => 'SinoSparkで中国語を極める';

  @override
  String get start7dayFreeTrial => '7日間の無料トライアルを開始';

  @override
  String get precisionStrokes => '精密な筆順指導';

  @override
  String get aiPronunciation => 'AI発音コーチング';

  @override
  String get today => '今日';

  @override
  String get fullAccess => '全機能フルアクセス';

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
      'RevenueCatに利用可能なプランが設定されていません。管理画面をご確認ください。';

  @override
  String get cameraPermissionRequiredForLiveScan =>
      'リアルタイムスキャンにはカメラのアクセス許可が必要です。';

  @override
  String get cameraAccessRequired => 'カメラへのアクセスが必要です';

  @override
  String get pleaseEnableCameraAccessInYourDevic =>
      'この機能を利用するには、端末の設定でカメラを有効にしてください。';

  @override
  String get alignChineseTextWithinFrame => '枠内に中国語テキストを合わせてください';

  @override
  String get inLibrary => 'ライブラリ登録済み';

  @override
  String get novice => '見習い';

  @override
  String get apprentice => '門下生';

  @override
  String get artisan => '熟練工';

  @override
  String get grandmaster => '達人・宗師';

  @override
  String get poem => '漢詩';

  @override
  String get theNarrative => '物語・本文';

  @override
  String get classicMasterpiece => '古典の最高傑作';

  @override
  String get classicAuthor => '古典作家';

  @override
  String get classical => '古典文学';

  @override
  String get classicLiterature => '古典文学';

  @override
  String inThisChapterOf(Object title) {
    return '『$title』のこの章では';
  }

  @override
  String get asTheNarrativeUnfoldsItIlluminatesT =>
      '物語の展開とともに、人生の深遠な知恵と時代を超えるインスピレーションが鮮やかに浮かび上がります。';

  @override
  String get general => '一般・総合';

  @override
  String get mythology => '神話・伝説';

  @override
  String get dailyLife => '日常生活';

  @override
  String get tangPoetry => '唐詩';

  @override
  String get classicalLiterature => '古典文学';

  @override
  String get justNow => 'たった今';

  @override
  String get theTerracottaArmyOfQinShiHuang => '秦始皇帝の兵馬俑';

  @override
  String get lifeInsideTheForbiddenCity => '紫禁城（故宮）での宮廷生活';

  @override
  String get buyingATicketAndTakingTheHighSpeedT => '中国で切符を購入して高速鉄道に乗る';

  @override
  String get goingToTheHospitalForAColdAndSeeing => '風邪で病院に行き診察を受ける';

  @override
  String get goingToALocalRestaurantToOrderJiaoz => '地元の名物店で水餃子を注文する';

  @override
  String get theTraditionalGongfuTeaCeremony => '伝統的な工夫茶（ゴンフーチャ）の茶芸';

  @override
  String get theArtOfWritingChineseCharactersWit => '毛筆で漢字を書く伝統書道芸術';

  @override
  String get theLifeAndConservationOfGiantPandas => 'ジャイアントパンダの生態と保護活動';

  @override
  String get storyNotFoundInDatabase => 'データベース内にストーリーが見つかりませんでした';

  @override
  String get storyTextIsEmpty => 'ストーリーの本文が空です';

  @override
  String get myCustomStories => '自作ストーリー';

  @override
  String get userProvidedText => 'ユーザー入力テキスト';

  @override
  String get local => 'ローカル';

  @override
  String get voiceEngineAllowance => '音声エンジンと利用枠';

  @override
  String get studioHdVsUnlimitedStandardVoice => 'スタジオ品質HD音声 vs. 無制限スタンダード音声';

  @override
  String get standardVoiceIs100UnlimitedFree => 'スタンダード音声は完全無料で無制限にご利用いただけます';

  @override
  String get read => '読む';

  @override
  String get koreKoreFemaleWarm => 'Kore（女性・温かみのある声）';

  @override
  String get aoedeAoedeFemaleCheerful => 'Aoede（女性・明るく朗らかな声）';

  @override
  String get fenrirFenrirMaleUpbeat => 'Fenrir（男性・元気で力強い声）';

  @override
  String get charonCharonMaleNewsstyle => 'Charon（男性・格調高いニュース調）';

  @override
  String get puckPuckMaleSporty => 'Puck（男性・爽やかでスポーティな声）';

  @override
  String get localOndevice => '端末の内蔵音声';

  @override
  String get localOndeviceTts => '端末標準TTS音声';

  @override
  String get off => 'オフ';

  @override
  String get endOfCurrentChapter => 'この章の終わり';

  @override
  String get standardVoice => 'スタンダード音声';

  @override
  String get noNovelsFoundMatchingYourFilter => '条件に一致する小説は見つかりませんでした。';

  @override
  String get noMicroreadsFoundMatchingYourFilter =>
      '条件に一致するマイクロリーディングは見つかりませんでした。';

  @override
  String get noPoemsFoundMatchingYourFilter => '条件に一致する詩歌は見つかりませんでした。';

  @override
  String get audiobook => 'オーディオブック';

  @override
  String get audio => '音声';

  @override
  String get continueReading => '続きを読む';

  @override
  String get search96FullNovelsAuthorsEpics => '96作品の長編小説、著者、叙事詩を検索...';

  @override
  String get searchClassicalPoemsAuthorsVerses => '古典詩、詩人、名句を検索...';

  @override
  String get allLevelsVal => '全レベル';

  @override
  String get hsk1BeginnerVal => 'HSK 1級（初級）';

  @override
  String get hsk2ElementaryVal => 'HSK 2級（初中級）';

  @override
  String get hsk3IntermediateVal => 'HSK 3級（中級）';

  @override
  String get hsk4UpperIntVal => 'HSK 4級（中上級）';

  @override
  String get listenToAudiobook => 'オーディオブックを聴く';

  @override
  String get synopsis => 'あらすじ・解説';

  @override
  String get peoplesArtist => '人民芸術家';

  @override
  String get kafkaesqueForBureaucraticAbsurdityA =>
      '「カフカ的」は、官僚制の不条理、疎外感、実存的な不安を表現します。';

  @override
  String get bigBrotherAndNewspeak => '「ビッグ・ブラザー」や「ニュースピーク（新語法）」。';

  @override
  String get audiobookIncluded => 'オーディオブック対応';

  @override
  String get readPoem => '詩を読む';

  @override
  String get studioVoiceAllowance => 'スタジオHD音声利用枠';

  @override
  String get weeklyHighdefinitionAiRecitation => '週間・高精細AI朗読枠';

  @override
  String get resetsEveryMondayAt0000 => '毎週月曜日 00:00 にリセットされます';

  @override
  String get whenYourWeekly4hourStudioAllowanceI =>
      '週4時間のスタジオHD音声枠を使い切った後は、自動的に端末の内蔵音声に切り替わり、無料で中断なく聴き続けることができます。';

  @override
  String get localDeviceVoice => '端末の内蔵音声';

  @override
  String get classicalVerse => '古典詩句';

  @override
  String get ondeviceVoice4hWeeklyUsed => '端末内蔵音声（今週4時間使用済み）';

  @override
  String get generateACustomAiStoryBasedOnYourIn =>
      'あなたの興味に合わせたオリジナルAIストーリーを生成';

  @override
  String get insteadOfAFixedHskLevelTheFlowState =>
      '画一的なHSKレベルに縛られず、ダイナミック・フロー状態エンジンがあなたのフラッシュカードデッキの習熟語彙を分析します。';

  @override
  String get we => '私たち';

  @override
  String get howCanWeHelpYou => 'どのようなご用件でしょうか？';

  @override
  String get everythingYouNeedToKnowAboutHanziMa =>
      'SinoSparkの機能、使い方、プライバシー保護のすべて。';

  @override
  String get whoAreTheVoicesSpeakingInTheApp => 'アプリ内の音声キャストについて';

  @override
  String get howDoesTheWebExplorerWork => 'Webエクスプローラーの使い方';

  @override
  String get whatIsZenMode => '禅モード（集中モード）とは？';

  @override
  String get howDoesTheFlashcardSpacedrepetition => 'フラッシュカードの分散学習（間隔反復）の仕組み';

  @override
  String get traceComplete => '運筆完了！';

  @override
  String get traceCharacter => '漢字をなぞる';

  @override
  String get analyzingWordRelationships => '語彙の関連性を分析中...';

  @override
  String get identifyingUsageContexts => '使用文脈を特定中...';

  @override
  String get comparingFormalityLevels => 'フォーマル度の違いを比較中...';

  @override
  String get findingCommonCollocations => '一般的な連語（コロケーション）を検索中...';

  @override
  String get generatingComparison => '比較解説を生成中...';

  @override
  String get generationIsTakingLongerThanExpecte =>
      '生成に通常より時間がかかっています。AIサーバーが混雑している可能性があります。';

  @override
  String get generationInterruptedShowingPartial =>
      '処理が中断されました。取得できた一部の結果を表示します。';

  @override
  String get sorrySomethingWentWrong => '申し訳ありません。問題が発生しました。';

  @override
  String get usage => '用法：';

  @override
  String get alsoSeenIn => '以下の作品・場面にも登場';

  @override
  String get quickLook => 'クイックプレビュー';

  @override
  String get notFound => '見つかりません';

  @override
  String get errorLoadingFromAi => 'AIからのデータ読み込みに失敗しました。';

  @override
  String get analyzingImage => '画像を解析中...';

  @override
  String get extractingChineseText => '中国語テキストを抽出中...';

  @override
  String get lookingUpVocabulary => '単語の意味を検索中...';

  @override
  String get dreamOfTheRedChamber => '紅楼夢（Dream of the Red Chamber）';

  @override
  String get journeyToTheWest => '西遊記（Journey to the West）';

  @override
  String get romanceOfTheThreeKingdoms =>
      '三国志演義（Romance of the Three Kingdoms）';

  @override
  String get mingDynasty => '明代';

  @override
  String get wuChengEn => '呉承恩';

  @override
  String get hundredChapters => '全100回';

  @override
  String get volume1 => '第1巻';

  @override
  String bookmarksCount(Object count) {
    return 'ブックマーク（$count件）';
  }

  @override
  String get noBookmarksYet => 'ブックマークはまだありません。アイコンをタップして気になる箇所を保存しましょう。';

  @override
  String get sinosparkIsNotResponding => 'SinoSparkが応答していません';

  @override
  String get closeApp => 'アプリを閉じる';

  @override
  String get wait => '待機';

  @override
  String studioHdAllowance(Object hours) {
    return 'スタジオHD枠: $hours時間';
  }

  @override
  String bookPercentRead(Object percent) {
    return '読了率 $percent%';
  }

  @override
  String chAbbreviation(Object number) {
    return '第$number章';
  }

  @override
  String booksAndAudiobooks(Object count) {
    return '$count作品の書籍＆オーディオブック';
  }

  @override
  String sentenceXOfY(Object current, Object total) {
    return '$current / $total 文';
  }

  @override
  String chapterXOfY(Object current, Object total) {
    return '第$current章 / 全$total章';
  }

  @override
  String get allLevels => 'すべてのレベル';

  @override
  String get searchGradedMicroStories => 'レベル別ショートストーリーや寓話を検索...';

  @override
  String gradedStoriesAndMicroReads(Object count) {
    return '$count作品のレベル別ストーリー＆デイリー読解';
  }

  @override
  String get searchClassicalPoems => '漢詩、詩人、名句を検索...';

  @override
  String classicalPoemsAndVerse(Object count) {
    return '$count編の古典詩・名句';
  }

  @override
  String get browseAnyChineseWebsite =>
      'タップ辞書、ピンイン注釈、リアルタイム翻訳で、あらゆる中国語Webサイトを快適に閲覧。';

  @override
  String get completed => '完了';

  @override
  String get aiIsReading => 'AIが読み取り中...';

  @override
  String get bbcVerify => 'BBC Verify';

  @override
  String get hsk5AdvancedVal => 'HSK 5級（上級）';

  @override
  String get hsk1Beginner => 'HSK 1級（初級）';

  @override
  String get hsk4UpperInt => 'HSK 4級（中上級）';

  @override
  String get extractAllUnknownWords => '未知の単語をすべて新しいフラッシュカードデッキに抽出';

  @override
  String get designCustomAiRoleplay => '自分だけのオリジナルAIロールプレイ会話を作成';

  @override
  String get practiceFlashcardVocabulary => 'ライブ対話でフラッシュカードの語彙を実践練習';

  @override
  String get surpriseMe => 'おまかせ（サプライズ）';

  @override
  String get rollCharacter => 'キャラクターをランダム選択';

  @override
  String get historicalCostume => '時代劇・古装劇';

  @override
  String get modernYouth => '現代・トレンディ・青春';

  @override
  String get fantasyMythology => 'ファンタジー・仙侠・神話';

  @override
  String get familyDrama => 'ホームドラマ・家族';

  @override
  String get fullVersion => '完全版';

  @override
  String episodesCount(Object count) {
    return '全$count話';
  }

  @override
  String episodeLabel(Object number) {
    return '第$number話';
  }

  @override
  String get translating => '[ 翻訳中... ]';

  @override
  String get engSub => '[日本語字幕]';

  @override
  String get standardVocabulary => '標準語彙';

  @override
  String get characters => '漢字';

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
