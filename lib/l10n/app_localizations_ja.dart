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
  String get loading => '読み込み中...';

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
      'The voices in AI Stories and Echo Hall are powered by advanced Neural Text-to-Speech models. They are specifically tuned to provide authentic native Chinese accents, appropriate emotional inflection, and natural pacing.';

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
}
