// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get originStoryChip => '📜 成り立ち';

  @override
  String get ancientFormChip => '🏺 古代文字';

  @override
  String get threeMoreWordsChip => '📖 さらに3語';

  @override
  String get wordFamilyChip => '🔗 関連語';

  @override
  String get idiomChip => '🀄 成語';

  @override
  String get proverbChip => '💬 ことわざ';

  @override
  String get isThereAChineseIdiomFeaturingThisCharacter =>
      'この漢字を含む中国語の成語（成语）はありますか？';

  @override
  String get strokeOrderChip => '✏️ 筆順';

  @override
  String get calligraphyTipChip => '🎨 書道のコツ';

  @override
  String get grammarNoteChip => '📝 文法ノート';

  @override
  String get similarWordsChip => '🔄 類義語';

  @override
  String get culturalNoteChip => '🏮 文化ノート';

  @override
  String get inMediaChip => '🀄 メディアでの例';

  @override
  String get radicalMeaningChip => '🧩 部首の意味';

  @override
  String get componentBreakdownChip => '🔍 構成の分解';

  @override
  String get toneTipChip => '🎵 声調のコツ';

  @override
  String get homophonesChip => '👯 同音異義語';

  @override
  String askMeAnythingAbout(String hanzi) {
    return '$hanziについて何でも聞いてください...';
  }

  @override
  String aiTutorError(String error) {
    return 'AIチューターのエラー: $error';
  }

  @override
  String get aiTutorRateLimit => 'AIチューターが混雑しています。少し時間をおいて再度お試しください。';

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
  String get studySession => '学習セッション';

  @override
  String get readyToStudy => '学習の準備ができました';

  @override
  String get studyQueuePreviewDescription => '今日のスケジュールとデッキの制限に基づくセッションです。';

  @override
  String get notNow => '後で';

  @override
  String get newLabel => '新着';

  @override
  String get studyDeckEmpty => 'このデッキは空です';

  @override
  String get studyDeckEmptyDescription => '学習を始める前にカードを追加してください。';

  @override
  String get studyDailyLimitReached => '今日の上限に達しました';

  @override
  String get studyDailyLimitReachedDescription =>
      'このデッキの本日の新規カードまたは復習の枠を使い切りました。';

  @override
  String get studyCaughtUpDescription => '本日の予定はすべて完了しました。また次回の復習でお会いしましょう。';

  @override
  String get noCardsAvailable => '利用可能なカードがありません';

  @override
  String get studyNoEligibleCardsDescription => '現在この学習モードで対象となるカードはありません。';

  @override
  String get studySessionLoadFailed => '学習セッションを読み込めませんでした。もう一度お試しください。';

  @override
  String get retryLimitReached => 'このカードは次回のセッションで再度出題されます。';

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
    return '$targetに追加';
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
  String get warringStates => '戦国時代';

  @override
  String get hanFeiLegalism =>
      '韓非（紀元前280年頃〜紀元前233年）は、韓の公子であり、中国の法家思想を代表する思想家でした。法、行政技術（術）、権威（勢）の概念を統合した著書『韓非子』は、中国帝国期の政治哲学や制度に深い影響を与えました。';

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
      '文字起こしが発言内容と異なる場合は、意図したフレーズを選び、「はい、再採点してください」をタップしてください。話し直さずに元の録音を再評価できます。';

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
  String get libraryLabel => 'ライブラリ';

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
  String get play => '発音を再生（）';

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
  String get aiDataPrivacyTitle => 'AIデータとプライバシー';

  @override
  String get aiDataPrivacySettingsSubtitle => 'AI機能のデータ送信内容、目的、送信先を確認';

  @override
  String get aiDataPrivacyOverviewTitle => 'AIが使用されるタイミング';

  @override
  String get aiDataPrivacyOverviewBody =>
      'SinoSparkは、AIチャット、解説、翻訳、画像解析、音声認識、発音評価、クラウド音声など、必要とする機能を選択した場合にのみクラウドAIを使用します。AIの出力は不正確な場合があるため、重要な結果は必ずご確認ください。';

  @override
  String get aiDataPrivacyProvidersTitle => 'AIサービス提供事業者';

  @override
  String get aiDataPrivacyProvidersBody =>
      'Google Geminiは生成テキストおよび画像のリクエストを処理します。OpenRouterは一部の生成リクエストをGoogle GeminiまたはDeepSeekにルーティングします。Microsoft Azure AI Speechは音声認識、発音評価、クラウド音声合成用のテキストを処理します。';

  @override
  String get aiDataPrivacySentTitle => '送信される可能性のあるデータ';

  @override
  String get aiDataPrivacySentBody =>
      '機能に応じて、入力または選択したテキスト、会話やレッスンの文脈、AI解析用に選択した画像、録音データ、およびIPアドレスやデバイス・ネットワークのメタデータなどの技術情報を送信します。AIプロンプトにお客様の氏名やメールアドレスを意図的に含めることはありません。';

  @override
  String get aiDataPrivacyControlsTitle => 'お客様の選択肢';

  @override
  String get aiDataPrivacyControlsBody =>
      '指定の提供事業者にデータを送信したくない場合は、該当するAI機能のご利用をお控えください。デバイスの設定でカメラ、写真、マイクのアクセス許可を拒否できます。音声読み上げを端末内にとどめるにはローカル音声を選択してください。機密情報や個人情報の送信はお控えください。';

  @override
  String get aiDataPrivacyRetentionTitle => 'データの保存と保持';

  @override
  String get aiDataPrivacyRetentionBody =>
      'SinoSparkは処理完了後、自社サーバーに未加工のAIプロンプト、送信画像、音声録音を意図的に保存することはありません。生成された結果は、保存を選択した場合にお使いの端末またはアカウントに保存されます。提供事業者は利用規約および設定されたデータ保持規則に従ってデータを処理します。詳細はプライバシーポリシーをご確認ください。';

  @override
  String get readFullPrivacyPolicy => 'プライバシーポリシー全文を読む';

  @override
  String get linkOpenFailed => 'リンクを開けませんでした。もう一度お試しください。';

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
  String get vlog => '中国の日常vlog';

  @override
  String get voice => '音声：';

  @override
  String get web => 'ウェブ';

  @override
  String get wedLoveToHearFromYou => 'ご意見・ご感想を\nぜひお聞かせください。';

  @override
  String get welcomeBack => 'おかえりなさい';

  @override
  String get whatDoesThisMean => 'これはどういう意味ですか？';

  @override
  String get whatHappensToMyChatHistory => 'チャット履歴はどう管理されますか？';

  @override
  String get whatIfAiMishears => 'AIが発言を誤って解釈した場合はどうすればよいですか？';

  @override
  String get whichCharacterIs => '次の説明に当てはまる漢字はどれですか：';

  @override
  String get wikipedia => 'ウィキペディア';

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
      '保存したロールプレイの会話履歴は、後から確認できるよう端末内に保存されます。個人的な会話をAIモデルの学習に使用することはありません。';

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
      '発音評価のために送信された録音は安全に処理され、処理完了後にSinoSparkが保持することはありません。保存を選択したロールプレイ履歴は端末に残る場合があり、アプリ内で削除できます。';

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
  String get requiredLabel => '必須';

  @override
  String get library1 => 'ライブラリ';

  @override
  String get youAreAPremiumMember => 'プレミアム会員です';

  @override
  String get createAccountToSyncProgress => 'アカウントを作成して進捗をクラウド同期';

  @override
  String get signOut => 'ログアウト';

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
  String get ijenwaBenita => 'イジェンワ・ベニータ';

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
  String get liveOverlay => 'リアルタイム読解アシスト';

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
  String get todayDashboard => '今日';

  @override
  String get studyToday => '今日のカードを学習';

  @override
  String get studyAhead => '先取り学習';

  @override
  String get studyAheadDescription =>
      '本日の上限を消費せずに、直近の復習予定を練習します。新しいカードは追加されません。';

  @override
  String get studyAheadComplete => '先取り学習完了';

  @override
  String get dueNow => '要復習';

  @override
  String get scheduled => '予定';

  @override
  String get sevenDayForecast => '7日間の復習予測';

  @override
  String get reviews => '復習';

  @override
  String get newCardsLabel => '新規カード';

  @override
  String get attempts => '試行回数';

  @override
  String get duration => '時間';

  @override
  String get answerBreakdown => '回答の内訳';

  @override
  String get reviewCards => '復習カード';

  @override
  String get retries => '再試行';

  @override
  String get needsPractice => '要練習';

  @override
  String get uniqueCardsStudied => 'カード数';

  @override
  String get dartConvert => 'dart:convert';

  @override
  String get env => '.env';

  @override
  String get dartUi => 'dart:ui';

  @override
  String get dartMath => 'dart:math';

  @override
  String get drawInTheOtherDirection => '反対方向に描きましよう ➔';

  @override
  String get fastClean => '速くてキレイ！';

  @override
  String get good2 => 'いいですね！';

  @override
  String get followTheFlow => '流れに沿って書きましょう。';

  @override
  String get masterful => '見事！';

  @override
  String get missingTheHookEnd => 'はね・止めが不足しています。';

  @override
  String get thai => 'タイ語';

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
  String get ink => '墨、';

  @override
  String get stroke => '筆画、';

  @override
  String get breath => '呼吸。';

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
  String get theExactSentenceProvided => '入力された正確な文';

  @override
  String get pinyinWithToneMarks2 => '声調記号付きピンイン';

  @override
  String get wXHuNH => 'Wǒ xǐhuān hē píngguǒzhī.';

  @override
  String get extractAllChineseCharactersFrom =>
      'この画像からすべての漢字を抽出してください。解説、フォーマット、翻訳は含めず、抽出したテキストのみを返してください。改行は維持してください。漢字がない場合は空の文字列を返してください。';

  @override
  String get householdObject => '日用品';

  @override
  String get genericLabelFromTheList => 'リストの一般的なラベル';

  @override
  String get gNgS => 'gōng sī';

  @override
  String get measureWord => '量詞';

  @override
  String get zenInk => '禅と墨';

  @override
  String get cRITICALPutTheEnglishTranslation =>
      '重要：「english」JSONキーに英語訳を設定してください！';

  @override
  String get definitionInEnglish => '英語での定義';

  @override
  String get simplifiedLine0 => '簡体字の行 0';

  @override
  String get simplifiedLine1 => '簡体字の行 1';

  @override
  String get iMPORTANTRULEDoNotAddress =>
      '重要ルール：ユーザーの名前を呼ばないでください。「John」などの仮名も使用しないでください。名前を使わずに直接対話してください。';

  @override
  String get rULESAnswerIn23 => 'ルール：最大2〜3文で回答してください。リストは箇条書きを優先してください。';

  @override
  String get neverWriteIntroductionsSignOffs =>
      '前置き、終わりの挨拶、「素晴らしい質問ですね！」や「もちろんです！」などの定型文は絶対に書かないでください。';

  @override
  String get useBoldForChineseCharacters => '漢字とキーワードには**太字**を使用してください。';

  @override
  String get rULESAnswerIn232 => 'ルール：最大2〜3文で回答してください。';

  @override
  String get accept => '同意する';

  @override
  String get pronunciationAssessment => '発音評価';

  @override
  String get nBest => 'Nベスト';

  @override
  String get none => 'なし';

  @override
  String get theCorrectedChineseText => '修正された中国語テキスト';

  @override
  String get thePinyinForTheCorrected => '修正されたテキストのピンイン';

  @override
  String get theEnglishMeaningOfThe => '修正されたテキストの英語の意味';

  @override
  String get pNyNWithTone => '声調記号付きピンイン';

  @override
  String get englishTranslation2 => '英語訳';

  @override
  String get zhNggu => 'Zhōngguó';

  @override
  String get youAreAChineseClassical =>
      'あなたは中国古典文学の専門家です。中国古典詩のわかりやすく詳細な要約を提供してください。';

  @override
  String get youAreAChineseCulture =>
      'あなたは中国文化と文学の専門家です。魅力的に書かれた美しい文化的考察を提供してください。';

  @override
  String get english2 => '英語:';

  @override
  String get remindersWhenYouHavenT => '数日間アプリを使用していないときのリマインダー';

  @override
  String get itSBeenAFew => 'お久しぶりです！今日も5分間、新しい漢字を学んでみましょう。';

  @override
  String get abbreviationFor => '～の略称';

  @override
  String get cL => '量詞:';

  @override
  String get measureWord2 => '量詞:';

  @override
  String get lu => 'lu:';

  @override
  String get luE => 'lu:e';

  @override
  String get nu => 'nu:';

  @override
  String get nuE => 'nu:e';

  @override
  String get noUser => 'ユーザーが見つかりません';

  @override
  String get passwordRequired => 'パスワードが必要です';

  @override
  String get unsupportedProvider => 'サポートされていないプロバイダーです';

  @override
  String get appleRevocationUnavailable => 'Apple連携の取り消しを利用できません';

  @override
  String get appleCredentialMissing => 'Appleの認証情報が見つかりません';

  @override
  String get authenticationDidNotReturnA => '認証でユーザー情報を取得できませんでした。';

  @override
  String get viewSubscriptionPlans => 'サブスクリプションプランを見る';

  @override
  String get wrongPassword => 'パスワードが違います';

  @override
  String get invalidCredential => '無効な認証情報です';

  @override
  String get networkRequestFailed => '通信に失敗しました';

  @override
  String get requiresRecentLogin => '再ログインが必要です';

  @override
  String get userMismatch => 'ユーザーが一致しません';

  @override
  String get deleteAccountPassword => 'アカウント削除用パスワード';

  @override
  String get deleteAccountError => 'アカウント削除エラー';

  @override
  String get deleteAccountSubmit => 'アカウントを削除';

  @override
  String get theSimplestShapesTheBeginning => '最もシンプルな形。すべての始まり。';

  @override
  String get sunMoonWaterAndFire => '日、月、水、火。自然の世界。';

  @override
  String get theBodyTheHeartAnd => '身体、心、そして家族。';

  @override
  String get fieldsRoofsAndToolsThe => '田畑、屋根、道具。社会の礎。';

  @override
  String get movementSpeechAndSustenance => '動作、言語、そして生活。';

  @override
  String get commerceClothingAndComplexArtifacts => '商業、衣服、そして複雑な工芸品。';

  @override
  String get fastTrackSimpleCharacterMastered => '🚀 ファストトラック！簡単な漢字をマスターしました。';

  @override
  String get excellentPrecisionGhostTraceSkipped =>
      '⚡ 素晴らしい精度！ゴーストトレースをスキップしました。';

  @override
  String get sample => 'サンプル:';

  @override
  String get itsThat => 'それ/あれ';

  @override
  String get iMe => '私/僕';

  @override
  String get stillTough => 'まだ/困難';

  @override
  String get partDecide => '部分/決定';

  @override
  String get selectTheCharacterFor => '次を示す漢字を選択:';

  @override
  String get selectThePinyinFor => '次を示すピンインを選択:';

  @override
  String get whereAreYouGoingThe => 'どこに行くのですか？空港ですか？かなりの移動ですね！';

  @override
  String get youAreAuntieChenA =>
      'あなたはシルクや生地を売る商売上手の陳おばさんです。あなたの唯一の役割は市場の露天商です。中国語で強気かつ公平に価格交渉をしてください。絶対にキャラを崩したり、露天商以外の自己紹介をしないでください。高めの価格から始めて、値引き交渉に応じましょう。';

  @override
  String get youAreDrZhangA =>
      'あなたは診療所の穏やかでプロフェッショナルな張医師です。あなたの唯一の役割は医師です。中国語で症状について尋ね、医療的なアドバイスを提供してください。絶対にキャラを崩したり、医師以外の自己紹介をしないでください。安心感を与えつつ、丁寧に対応してください。';

  @override
  String get whereDoYouFeelUncomfortable => 'どこが調子悪いですか？発熱はありますか？';

  @override
  String get youAreACloseFriend =>
      'あなたはずっと久しぶりに再会した親しい友人です。あなたの唯一の役割は友人です。中国語でカジュアルに、温かく、短く返答してください。絶対にキャラを崩したり、友人以外の自己紹介をしないでください。親しい友人に適したタメ口を使ってください。';

  @override
  String get noNbest => 'N-bestなし';

  @override
  String get timedOut => 'タイムアウト';

  @override
  String get grading => '採点中...';

  @override
  String get label1st => '第1声 ˉ';

  @override
  String get label2nd => '第2声 ˊ';

  @override
  String get label3rd => '第3声 ˇ';

  @override
  String get label4th => '第4声 ˋ';

  @override
  String get speaking2 => '発話中...';

  @override
  String get sessionCompletedInYourNext =>
      'セッションが完了しました。次回の練習では、完全な文章で発話すると、詳細な発音と声調の診断を受けられます。';

  @override
  String get craneSoaring => '鶴の飛翔';

  @override
  String get gentleStream => '穏やかな小川';

  @override
  String get brushAndInk => '筆と墨';

  @override
  String get myStudent => '私の生徒';

  @override
  String get honoredDisciple => '誉れ高き弟子';

  @override
  String get notEnoughInformation => '情報が不足しています';

  @override
  String get asAnAi => 'AIとして';

  @override
  String get goodPracticeSessionContinueFocusing =>
      '良い練習セッションでした。明確な声調の抑揚と自然な会話のテンポを引き続き意識しましょう。';

  @override
  String get insideASleekFuxingBullet => '時速350kmで北京から上海へ向かう洗練された復興号の車内。';

  @override
  String get harbinIceSnowWorldWonder => 'ハルビン氷雪大世界';

  @override
  String get theFamousPanjiayuanWeekendFlea =>
      '書道の掛け軸、翡翠、ヴィンテージの骨董品で賑わう有名な潘家園の週末フリーマーケット。';

  @override
  String get jingdezhenBlueWhitePorcelainStudio => '景徳鎮の青花磁器工房';

  @override
  String get pekingOperaDressingRoomMakeup => '京劇の楽屋とメイク';

  @override
  String get aHistoricTongrentangApothecaryScented =>
      '高麗人参やクコの実、数百もの木製薬棚の香りが漂う歴史ある同仁堂の漢方薬局。';

  @override
  String get aVibrantPrivateNeonLit =>
      'マイク、フルーツ盛り合わせ、操作画面を備えた、深センの華やかなネオン輝くカラオケ個室。';

  @override
  String get animeCosplayExpoInGuangzhou => '広州アニメ・コスプレエキスポ';

  @override
  String get nHOHuNy =>
      'Nǐ hǎo! Huānyíng lái dào zhèlǐ, jīntiān wǒmen liáo xiē shénme ne?';

  @override
  String get surpriseMe2 => '🎲 おまかせ';

  @override
  String get eGALivelyBanquet => '例：上海で開催される賑やかな宴会…';

  @override
  String get rollCharacter2 => '🎲 キャラクターをランダム選択';

  @override
  String get eGACuriousCousin => '例：あなたの仕事について興味津々に尋ねる従兄弟…';

  @override
  String get keepTrying => 'その調子で頑張りましょう！';

  @override
  String get pending => '保留中…';

  @override
  String get expected => '🎯 模範解答';

  @override
  String get hSK2Elementary => 'HSK 2級：初級';

  @override
  String get hSK3Intermediate => 'HSK 3：中級';

  @override
  String get hSK5Advanced => 'HSK 5：上級';

  @override
  String get expressYourselfFullyWith5000 => '5000語以上の語彙で自由に表現しましょう。';

  @override
  String get hanziWriter => 'hanzi-writer';

  @override
  String get hvg => 'hvg:';

  @override
  String get unlimited => '無制限';

  @override
  String get dueToday => '本日の復習';

  @override
  String get newAvailable => '新規学習可能';

  @override
  String get deleteAccountTile => 'delete-account-tile';

  @override
  String get giveASingleShortPractical =>
      'うまく書けていない画の形、位置、長さを改善するための短く実践的なアドバイスを1つだけ提示してください。詩的・比喩的な表現は避け、簡潔で役立つ内容にしてください。マークダウンは使用しないでください。';

  @override
  String get localOnDeviceTTS => 'ローカル — デバイス内TTS';

  @override
  String get espaOl => 'スペイン語';

  @override
  String get franAis => 'フランス語';

  @override
  String get portuguS => 'ポルトガル語';

  @override
  String get tiNgViT => 'ベトナム語';

  @override
  String get koreFemaleWarm => 'Kore — 女性、温かい';

  @override
  String get aoedeFemaleCheerful => 'Aoede — 女性、明るい';

  @override
  String get fenrirMaleUpbeat => 'Fenrir — 男性、陽気';

  @override
  String get charonMaleNewsStyle => 'Charon — 男性、ニュース風';

  @override
  String get puckMaleSporty => 'Puck — 男性、スポーティ';

  @override
  String get systemVoice => 'システム音声';

  @override
  String get generateAdd => '生成して追加';

  @override
  String get moreExamples => '📝 その他の例文';

  @override
  String get usage2 => '❓ 使い方';

  @override
  String get translation => '💬 翻訳';

  @override
  String get collocations => '📚 コロケーション';

  @override
  String get mistakes => '❌ 間違い';

  @override
  String get decrease => '減らす';

  @override
  String get increase => '増やす';

  @override
  String get label0MeansThisCardType => '0に設定すると、このカードタイプは無効になります。';

  @override
  String get tapTheValueToEnter => '値をタップして正確な上限を入力します。';

  @override
  String get exactDailyLimit => '1日の正確な上限';

  @override
  String get enter0ToDisable => '無効にするには0を入力';

  @override
  String get apply => '適用';

  @override
  String get selectDeck => 'デッキを選択';

  @override
  String get azureSpeechKeysNotConfigured =>
      'Azure Speechのキーが設定されていません。.envにAZURE_SPEECH_KEYとAZURE_SPEECH_REGIONを追加してください。';

  @override
  String get sTARTING => '開始中…';

  @override
  String get sTARTSESSION => 'セッションを開始';

  @override
  String get translating2 => '翻訳中...';

  @override
  String get chai => '柴知道Chai...';

  @override
  String get oneInABillion2 => '@One-In-a-Billion';

  @override
  String get businessEconomics => 'ビジネス・経済';

  @override
  String get hskPreparation => 'HSK対策';

  @override
  String get liveInChina => '中国での生活';

  @override
  String get comprehensiveExercise => '総合練習';

  @override
  String get howToUse => '使い方';

  @override
  String get usesOf => '〜の用法';

  @override
  String get appearedFirstOnMandarinBean => 'Mandarin Beanに最初に掲載';

  @override
  String get news2 => 'ニュース:';

  @override
  String get joke => 'ジョーク:';

  @override
  String get jokes => 'ジョーク:';

  @override
  String get academicScience => '学術・科学';

  @override
  String get politicsCommunism => '政治・共産主義';

  @override
  String get foodDining => 'グルメ・食事';

  @override
  String get sciFi => 'SF';

  @override
  String get scienceFictionTech => 'SF・テクノロジー';

  @override
  String get travelPlaces => '旅行・スポット';

  @override
  String get mythologyFantasy => '神話・ファンタジー';

  @override
  String get cultureTraditions => '文化・伝統';

  @override
  String get businessEconomy => 'ビジネス・経済';

  @override
  String get natureAnimals => '自然・動物';

  @override
  String get articleImg => '記事画像';

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
      '西嘻影業公式チャンネル (XiXi Pictures Official Channel)';

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
  String get getTheWeTVAPP => '腾讯视频 - WeTVアプリを入手';

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
  String get learnMandarinWithTaiwanPlus => 'TaiwanPlusで中国語を学ぶ';

  @override
  String get everydayChinese => '日常中国語';

  @override
  String get uCCFdR7zZ5SUXuOrEdKw => 'UCC_fdR7zZ_5SU--xuOrEdKw';

  @override
  String get tingDailyLifeInChina => 'Ting - 中国での日常生活';

  @override
  String get tFTFOODTRAVEL => 'TFT - グルメ＆トラベル';

  @override
  String get uCsHMiBJ9r87fRH7VAWZw => 'UCs_h_miBJ9r8-7fRH7VAWZw';

  @override
  String get liziqi3 => '李子柒 Liziqi：ニンニクの一生';

  @override
  String get label2MINCULTURALCONTEXT => '2分でわかる文化解説';

  @override
  String get liziqi4 => '李子柒 Liziqi：竹家具';

  @override
  String get peppaPigChinese2 => 'ペッパピッグ中国語：泥の水たまり';

  @override
  String get noBBCLeadArticleIs => '現在利用できるBBCのトップ記事はありません。';

  @override
  String get mediaThumbnail => 'media:thumbnail';

  @override
  String get bBC => 'BBC 中文';

  @override
  String get siJin2 => '似錦 Si Jin';

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
  String get sIXSISTERS2 => '六姉妹 SIX SISTERS';

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
  String get shineOnMe => '驕陽似我 Shine on Me';

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
  String get thoseDays => '四喜 あの日々';

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
  String get noFunnyNoMoney => '面白くなければ野宿 No Funny No Money';

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
  String get getTheWeTVAPP2 => 'テンセントビデオ - アニメ - WeTVアプリを入手';

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
      '『诡秘之主』Lord of Mysteries 烏賊アフレコVlog最終版 テンセントビデオ - アニメ';

  @override
  String get lordOfMysteries =>
      '『诡秘之主』Lord of Mysteries オカルト講座 第8期 テンセントビデオ - アニメ';

  @override
  String get lordOfMysteries2 =>
      '『诡秘之主』Lord of Mysteries オカルト講座 第7期 テンセントビデオ - アニメ';

  @override
  String get lordOfMysteries3 =>
      '『诡秘之主』Lord of Mysteries オカルト講座 第6期 テンセントビデオ - アニメ';

  @override
  String get lordOfMysteries4 =>
      '『诡秘之主』Lord of Mysteries オカルト講座 第5期 テンセントビデオ - アニメ';

  @override
  String get lordOfMysteries5 =>
      '『诡秘之主』Lord of Mysteries オカルト講座 第4期 テンセントビデオ - アニメ';

  @override
  String get lordOfMysteries6 =>
      '『诡秘之主』Lord of Mysteries オカルト講座 第3期 テンセントビデオ - アニメ';

  @override
  String get pakhctn6g6A => 'Pakhctn6g6A';

  @override
  String get lordOfMysteries7 =>
      '『诡秘之主』Lord of Mysteries オカルト講座 第2期 テンセントビデオ - アニメ';

  @override
  String get lordOfMysteries8 =>
      '『诡秘之主』Lord of Mysteries オカルト講座 第1期 テンセントビデオ - アニメ';

  @override
  String get g5fLWO98axs => 'G5fLWO98axs';

  @override
  String get gK0eOTF2s4c => 'GK0eOTF2s4c';

  @override
  String get oSTLordOfMysteries =>
      '【OST】『诡秘之主』Lord of Mysteries 終幕曲『勿忘我』 テンセントビデオ - アニメ';

  @override
  String get membersPremiere2 => '会員限定先行配信';

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
  String get eightHundred => '方円八百米 Eight Hundred';

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
      'メイキング：賀思慕と段胥の本名は見つからず愛称が続々【白日提灯 Love Beyond the Grave】';

  @override
  String get label5MVET41ATY => '5MVET41A-tY';

  @override
  String get bTSLoveBeyondTheGrave =>
      'メイキング｜【鵝劇パーティー】ディリラバとチェン・フェイユーらキャスト陣の息ぴったりな五感5連写！【白日提灯 Love Beyond the Grave】';

  @override
  String get bTSLoveBeyondTheGrave2 =>
      'メイキング｜【鵝劇パーティー】ディリラバとチェン・フェイユーが登場、鋭い眼光で魅了！【白日提灯 Love Beyond the Grave】';

  @override
  String get herBlaze => 'Her Blaze';

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
  String get aboutLove => '『玫瑰叢生』About Love';

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
  String get tA => '『玫瑰叢生』全員が愛の迷宮へ、二人はどう打開するのか？｜主演：王子文、劉宇寧';

  @override
  String get pLMX26aiIvX5rSLe74r7sARps4oOqaBWD =>
      'PLMX26aiIvX5rSLe74r7sA-Rps4oOqaBWD';

  @override
  String get generationToGeneration2 => '『江湖夜雨十年灯』Generation to Generation';

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
  String get loveStoryInThe1970s => '純真年代の愛 Love Story in the 1970s';

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
  String get whyIsHeStillSingle => '彼はなぜ今も独身なのか Why Is He Still Single';

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
  String get theGlamorousNight => '夜色正濃 The Glamorous Night';

  @override
  String get theGlamorousNightE03 =>
      '【夜色正濃 The Glamorous Night】E03 堂々の反撃！趙枚の絶地反撃（ジャン・シューイン、トン・ダーウェイ）';

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
      'ハイライト04：ありえないシステムが勝手に介入！ティッシュがナプキンに？大気まずい展開！【突然的喜欢 My Page in the 90s】';

  @override
  String get label03MyPageInThe =>
      'ハイライト03：親友の代わりにお見合いに行ったら、相手はまさかの主人公本物？【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSXXMyPage =>
      'メイキング｜「NG集 X チェン・シンシュー X ワン・ユーウェン」高社長と歓児、シュールなのはどっち？【突然的喜欢 My Page in the 90s】';

  @override
  String get label02MyPageInThe =>
      'ハイライト02：主人公を攻略するはずが、まさかの勘違い？【突然的喜欢 My Page in the 90s】';

  @override
  String get label01MyPageInThe =>
      'ハイライト01：ありえない！突然小説の世界に転生？この展開どう演じればいいの？【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSMyPageInThe =>
      'メイキング｜チェン・シンシューとワン・ユーウェンがスケートで激突【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSMyPageInThe2 =>
      'メイキング｜チェン・シンシューとワン・ユーウェンの甘いカウントダウン【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSMyPageInThe3 =>
      'メイキング｜チェン・シンシューとワン・ユーウェン、七夕の甘い瞬間【突然的喜欢 My Page in the 90s】';

  @override
  String get bTSMyPageInThe4 =>
      'メイキング｜チェン・シンシューとワン・ユーウェンの楽しい遊園地【突然的喜欢 My Page in the 90s】';

  @override
  String get myPageInThe90s2 =>
      '『突然的喜欢 My Page in the 90s』本日配信開始！チェン・シンシューとワン・ユーウェンが贈るシステム恋愛劇';

  @override
  String get myPageInThe90s3 =>
      '『突然的喜欢 My Page in the 90s』1月22日配信開始！チェン・シンシューとワン・ユーウェンの王道破りの恋';

  @override
  String get myPageInThe90s4 =>
      '『突然的喜欢 My Page in the 90s』1月22日配信決定！チェン・シンシューとワン・ユーウェンの時代を超えた熱愛';

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
  String get label2TheImperialCoronerS2 => '御賜小仵作2 The Imperial Coroner S2';

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
      '【轻年 Forever Young】E23 マーティンが胡同に戻り兄弟に釘付けにされる（霍建華、田雨、張雪迎、喬振宇）';

  @override
  String get foreverYoungE25 =>
      '【轻年 Forever Young】E25 的確かつ容赦なし！マーティンが義姉に夫のあしらい方を伝授（霍建華、田雨、張雪迎、喬振宇）';

  @override
  String get foreverYoungE24 =>
      '【轻年 Forever Young】E24 恋のライバル？マーティンが青二才におじさん呼ばわりされる（霍建華、田雨、張雪迎、喬振宇）';

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
  String get hOMELANDGUARDIAN => '守誠者|HOMELAND GUARDIAN🚔';

  @override
  String get iQIYIGetTheIQIYIAPP => 'iQIYI 懸疑社 - iQIYIアプリを入手';

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
  String get loveHasFireworks => '愛情有煙火 Love Has Fireworks';

  @override
  String get getTheWeTVAPP3 => 'テンセントビデオ - 青春劇場 - WeTVアプリを入手';

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
  String get theHiddenHeirYeChen2 => '進撃の葉辰 The Hidden Heir Ye Chen';

  @override
  String get xtTr8ZBDpG => 'XtTr8ZBDp-g';

  @override
  String get dresmsNeverEnd => '荒野の風を聴け Dreams Never End';

  @override
  String get mamaGo => '私のママはマドンナ Mama Go!';

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
      '『純真年代の愛 Love Story in the 1970s』ダブルライン編年史ショートフィルム、心温まる公開〜';

  @override
  String get loveStoryInThe1970s3 =>
      '『純真年代の愛 Love Story in the 1970s』ペアショートフィルム正式公開〜五感で綴るラブレター〜';

  @override
  String get bTSLoveStoryInThe =>
      'メイキング｜全キャストクランクアップ、またの再会を楽しみに【純真年代の愛 Love Story in the 1970s】';

  @override
  String get loveStoryInThe1970s4 =>
      '『純真年代の愛 Love Story in the 1970s』愛は日常の暮らしの中に潜む詩〜';

  @override
  String get sGX3zNIuzM => 'SGX-3zNIuzM';

  @override
  String get loveStoryInThe1970s5 =>
      '『純真年代の愛 Love Story in the 1970s』2月21日より放送決定〜';

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
  String get theTruth => '『風過留痕 The Truth』';

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
      'BTS｜「Out of Character Duo Interview 」メイキング：高社長と歓児のカオス対決、勝者はどちら？『突然の好き My Page in the 90s』テンセントビデオ-青春劇場';

  @override
  String get rEk9xALNODE => 'REk9xALNODE';

  @override
  String get label04MyPageInThe2 =>
      'ハイライト04 とんでもないシステムが勝手にストーリーを追加！ティッシュが生理用ナプキンに？大気まずい展開に！『突然の好き My Page in the 90s』テンセントビデオ-青春劇場';

  @override
  String get label03MyPageInThe2 =>
      'ハイライト03 親友の代わりに代理お見合いしたら、まさかの男主本人！？『突然の好き My Page in the 90s』テンセントビデオ-青春劇場';

  @override
  String get xsb7BJppy0 => 'Xsb7B-Jppy0';

  @override
  String get label02MyPageInThe2 =>
      'ハイライト02 男主を攻略しようとしたら、まさかの人違い！？『突然の好き My Page in the 90s』テンセントビデオ-青春劇場';

  @override
  String get label01MyPageInThe2 =>
      'ハイライト01 ありえない！突然本の世界に転移！？このストーリー、どう演じればいいの？『突然の好き My Page in the 90s』テンセントビデオ-青春劇場';

  @override
  String get zSpXoH9ok => 'Z_SpXo-H9ok';

  @override
  String get myPageInThe90s5 =>
      '『突然の好き My Page in the 90s』BTS｜チェン・シンシューとワン・ユーウェンがスケートで激突';

  @override
  String get myPageInThe90s6 =>
      '『突然の好き My Page in the 90s』本日配信開始！チェン・シンシューとワン・ユーウェンがシステムを駆使して甘いラブラブ恋模様';

  @override
  String get bTSMyPageInThe5 =>
      'BTS｜チェン・シンシューとワン・ユーウェンのコミカルな掛け合い＆胸キュン度MAX【突然の好き My Page in the 90s】';

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
  String get dearSecretary => '親愛なる秘書へ Dear Secretary';

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
  String get lightOfDawn => '人之初 夜明けの光';

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
  String get sniperButterfly => '狙撃の蝶 Sniper Butterfly';

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
      '『狙撃蝴蝶 Sniper Butterfly』12月4日配信決定！愛のために一線を越える';

  @override
  String get sniperButterflyFullVersion1 =>
      '『狙撃蝴蝶 Sniper Butterfly』フルバージョン 1-15｜主演：陳妍希、周柯宇 テンセントビデオ - 青春劇場';

  @override
  String get sniperButterflyFullVersion16 =>
      '『狙撃蝴蝶 Sniper Butterfly』フルバージョン 16-30｜主演：陳妍希、周柯宇 テンセントビデオ - 青春劇場';

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
  String get allRise => '即刻上場 All Rise';

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
  String get loveIsAlwaysOnline2 => '対的時間対的人 Love is Always Online';

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
  String get loveOnTheTurquoiseLand => '梟起青壤 Love on the Turquoise Land';

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
      '『Why Is He Still Single』11/16配信決定！ウォレス・フォ＆ジュー・ジューがおくる大人のラブロマンス！';

  @override
  String get whyIsHeStillSingle3 =>
      '『Why Is He Still Single』フルバージョン｜主演：ウォレス・フォ、ジュー・ジュー テンセントビデオ-青春劇場';

  @override
  String get ijgFlHRPHw => 'Ijg-FlHRPHw';

  @override
  String get whyIsHeStillSingle4 =>
      '『Why Is He Still Single』フルバージョン 1｜主演：ウォレス・フォ、ジュー・ジュー テンセントビデオ-青春劇場';

  @override
  String get whyIsHeStillSingle5 =>
      '『Why Is He Still Single』フルバージョン 2｜主演：ウォレス・フォ、ジュー・ジュー テンセントビデオ-青春劇場';

  @override
  String get yVGKe9xonY => 'YV-GKe9xonY';

  @override
  String get qKftsk37mXo => 'QKftsk37mXo';

  @override
  String get ccxy931pac => 'ccxy9-31pac';

  @override
  String get uc5hawjBFU => 'Uc5hawj_bFU';

  @override
  String get fightForLove => '『山河枕 Fight for Love』';

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
  String get iMNobody => '『我本无名』I\'m Nobody';

  @override
  String get persona => '重影 ペルソナ';

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
  String get thePrisonerOfBeauty => '『折腰』ダイジェスト版 The Prisoner of Beauty';

  @override
  String get wsGeYBRO => 'wsGeYB_-r_o';

  @override
  String get thePrisonerOfBeauty2 =>
      '『折腰』ダイジェスト版 The Prisoner of Beauty：姉の代わりに宿敵へ嫁いだ小喬、初日から夫と衝突｜主演：宋祖児、劉宇寧 テンセントビデオ-青春劇場';

  @override
  String get thePrisonerOfBeauty3 =>
      '『折腰』ダイジェスト版 The Prisoner of Beauty：小喬が劉琰の運河爆破の陰謀を阻止、魏劭とお互いを守り合う関係に｜主演：宋祖児、劉宇寧 テンセントビデオ-青春劇場';

  @override
  String get thePrisonerOfBeauty4 =>
      '『折腰』ダイジェスト版 The Prisoner of Beauty：小喬が病のふりをして本院を守り、魏劭は人前で妻を庇い側室拒否｜主演：宋祖児、劉宇寧 テンセントビデオ-青春劇場';

  @override
  String get thePrisonerOfBeauty5 =>
      '『折腰』ダイジェスト版 The Prisoner of Beauty：小喬が木箱の罠を見破り、魏劭は彼女を我が家の女君と認める｜主演：宋祖児、劉宇寧 テンセントビデオ-青春劇場';

  @override
  String get thePrisonerOfBeauty6 =>
      '『折腰』ダイジェスト版 The Prisoner of Beauty：小喬が知恵で無実を証明、魏劭は妻を認め庇い姑との対立も激化｜主演：宋祖児、劉宇寧 テンセントビデオ-青春劇場';

  @override
  String get thePrisonerOfBeauty7 =>
      '『折腰』ダイジェスト版 The Prisoner of Beauty：魏儼が偽手紙で仕掛け、玉ペンダントを巡り小喬と魏劭に信頼の危機｜主演：宋祖児、劉宇寧 テンセントビデオ-青春劇場';

  @override
  String get thePrisonerOfBeauty8 =>
      '『折腰』ダイジェスト版 The Prisoner of Beauty：蘇娥皇が熟麦で小喬を陥れるも、魏劭が妻を守り真相を解き明かし二人の絆が深まる｜主演：宋祖児、劉宇寧 テンセントビデオ-青春劇場';

  @override
  String get thePrisonerOfBeauty9 =>
      '『折腰』ダイジェスト版 The Prisoner of Beauty：刺客に襲われ毒を盛られた小喬と魏劭、小喬の機転で夫を救い仲が深まる｜主演：宋祖児、劉宇寧 テンセントビデオ-青春劇場';

  @override
  String get rNYFWNcb8o => 'RNYFW-Ncb8o';

  @override
  String get thePrisonerOfBeauty10 =>
      '『折腰』ダイジェスト版 The Prisoner of Beauty：魏劭が軍馬の後に簪を贈り、行方不明になった妻を探して焦りまくる｜主演：宋祖児、劉宇寧 テンセントビデオ-青春劇場';

  @override
  String get thePrisonerOfBeauty11 =>
      '『折腰』ダイジェスト版 The Prisoner of Beauty：小喬の逃亡を恐れて嫉妬し庇う魏劭、引っ越すも後悔して彼女を恋しがる｜主演：宋祖児、劉宇寧 テンセントビデオ-青春劇場';

  @override
  String get thePrisonerOfBeauty12 =>
      '『折腰』ダイジェスト版 The Prisoner of Beauty：嫉妬した魏劭が小喬をおんぶ、木箱の謎が解けて二人の距離が急接近｜主演：宋祖児、劉宇寧 テンセントビデオ-青春劇場';

  @override
  String get thePrisonerOfBeauty13 =>
      '『折腰』ダイジェスト版 The Prisoner of Beauty：喬慈の訪問で嫉妬する魏劭、小喬夫婦が本音を明かし一生を誓い合う｜主演：宋祖児、劉宇寧 テンセントビデオ-青春劇場';

  @override
  String get thePrisonerOfBeauty14 =>
      '『折腰 ダイジェスト版 The Prisoner of Beauty』魏儼は小喬のために故郷を離れ、魏劭と小喬は喧嘩の末仲直り｜主演：ソン・ズーアル、リウ・ユーニン Tencent Video - 青春劇場';

  @override
  String get ry1BWClaV0 => 'ry1BWCla-V0';

  @override
  String get thePrisonerOfBeauty15 =>
      '『折腰 ダイジェスト版 The Prisoner of Beauty』新婚の夜の兵変で姉妹反目、小喬の機智で敵を退け魏劭は非を認める｜主演：ソン・ズーアル、リウ・ユーニン Tencent Video - 青春劇場';

  @override
  String get o8nFcvzyvM => 'O8n-FcvzyvM';

  @override
  String get thePrisonerOfBeauty16 =>
      '『折腰 ダイジェスト版 The Prisoner of Beauty』魏劭は小喬に付き添い康郡へ戻りわだかまりを解く、喬父は義理の息子と認め夫婦は初夜を迎える｜主演：ソン・ズーアル、リウ・ユーニン Tencent Video - 青春劇場';

  @override
  String get krsrk6wSAy8 => 'Krsrk6wSAy8';

  @override
  String get thePrisonerOfBeauty17 =>
      '『折腰 ダイジェスト版 The Prisoner of Beauty』喬越の裏切りで魏梁は命を落とし、大喬が拉致され比彘は決死の反撃｜主演：ソン・ズーアル、リウ・ユーニン Tencent Video - 青春劇場';

  @override
  String get v26fn6w270 => 'V-26fn6w270';

  @override
  String get thePrisonerOfBeauty18 =>
      '『折腰 ダイジェスト版 The Prisoner of Beauty』魏梁は戦死し魏渠は片腕を失い、大喬は転落し劉琰は滅亡｜主演：ソン_ズーアル、リウ・ユーニン Tencent Video - 青春劇場';

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
      'グループ課題が遅いと文句？俺様社長が深夜に窓からPPTを届けて警備員に追われる Tencent Video - 青春劇場';

  @override
  String get zPBZ1KRQ3hY => 'ZPBZ1KRQ3hY';

  @override
  String get aThousandMilesToYour =>
      '千の街を越えてあなたに出会う A Thousand Miles to Your Heart';

  @override
  String get getTheWeTVAPP4 => 'Tencent Video - 時代劇劇場 - WeTVアプリをダウンロード';

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
  String get theInescapable => '鎖簪 The Inescapable';

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
      '『江湖夜雨十年灯 Generation to Generation』2月22日配信決定！江湖最強の次世代コンビ、慕慕と昭昭と共に冒険に出かけよう！';

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
  String get the300LoyalGhosts2 => '大明暗影 三百忠魂 The 300 Loyal Ghosts';

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
  String get danceOfThePhoenix => '『鳳舞伝』 Dance of The Phoenix';

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
      '『宮廷恋士官2 The Imperial Coroner S2』1月15日配信決定！楚瑜夫妻が心温まるカムバック！';

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
  String get rebirthForYou => '嘉南伝 Rebirth For You';

  @override
  String get f9eLAZQDUds => 'F9eLAZQDUds';

  @override
  String get aVowInTheDark2 => '恋恋風陵渡 A Vow in the Dark';

  @override
  String get theUltimateVowUnknownTo => '君不知 The Ultimate Vow, Unknown to You';

  @override
  String get duMRGzTeKs => 'DuM-rGzTeKs';

  @override
  String get pLs3DOuT3JlGTynSBKz3Z5DcDzwwmqSOf =>
      'PLs3DOuT3JlGTynSBKz3-z5DcDzwwmqSOf';

  @override
  String get theChangAnYouth => '長安少年行 The Chang\'An Youth';

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
  String get babysitter => '我在冷宮做月嫂 Babysitter';

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
  String get herPhoenixMajesty2 => '鳳凰伝 Her Phoenix Majesty';

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
      '【有花在洲 A Flower On The Continent】人質となった若き王爺、花娘に無理やり姫扱いされて同居するはめに';

  @override
  String get aFlowerOnTheContinent4 =>
      '【有花在洲 A Flower On The Continent】正体がバレた花娘、若き王爺は命がけで庇うも逆に罪を着せられる';

  @override
  String get aFlowerOnTheContinent5 =>
      '【有花在洲 A Flower On The Continent】花惜玉は父の仇が寧玄洲の父だと知り、その場で態度を一変させる';

  @override
  String get aFlowerOnTheContinent6 =>
      '【有花在洲 A Flower On The Continent】花惜玉は花嫁衣装で敵陣に乗り込み、命懸けで寧玄洲を救おうとして命を落としかける';

  @override
  String get aFlowerOnTheContinent7 =>
      '【有花在洲 A Flower On The Continent】両国が和親条約を結ぶ中、寧玄洲は詔書を破り捨てて花惜玉と結婚すると言い張る';

  @override
  String get aFlowerOnTheContinent8 =>
      '【有花在洲 A Flower On The Continent】花惜玉は手首を切って血を放ち薬を作り、寧玄洲は父皇が彼女の父を殺したことを告発する';

  @override
  String get aFlowerOnTheContinent9 =>
      '【有花在洲 A Flower On The Continent】花惜玉は父を殺したのが寧玄洲の父だと知り、花畑で愛の証の枝を切り落とす';

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
  String get hilariousFamily22 => 'Hilarious Family 2';

  @override
  String get sliceOfLife => '日常';

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
      'ハイライト名場面集【錦月如歌 Legend of The Female General】';

  @override
  String get a40F2TEZrms => 'A40F2TEZrms';

  @override
  String get lYQ5iND4 => 'lYQ5iN-d-_4';

  @override
  String get bTSLegendOfTheFemale =>
      'メイキング 周也の誕生日スペシャル🎂！【錦月如歌 Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale2 =>
      'メイキング 肖都督役・丞磊の誕生日スペシャル🎂！【錦月如歌 Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale3 =>
      'メイキング 戦場で魅せる見事なアクション、大魏の双星【錦月如歌 Legend of The Female General】';

  @override
  String get bTS520LegendOfThe =>
      'メイキング 520デートプラン【錦月如歌 Legend of The Female General】';

  @override
  String get bTSLegendOfTheFemale4 =>
      'メイキング 酔った周也が可愛すぎる〜剣舞のギャップ萌え全開〜隣の丞磊もニヤケ顔が隠せない！【錦月如歌 Legend of The Female General】';

  @override
  String get pLs3DOuT3JlGRucYIZLqmT7FO5IWDWrP =>
      'PLs3DOuT3JlGRuc_yIZLqmT7FO5IWD-WrP';

  @override
  String get thePrincessSGambit => '桃花映江山 The Princess\'s Gambit';

  @override
  String get highlightThePrincessSGambit =>
      'ハイライト名場面集【桃花映江山 The Princess\'s Gambit】';

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
      'クリップ 白雪に映える赤い衣装！姜桃花は弟を守るため祈国へ嫁ぐ【桃花映江山 The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit2 =>
      'クリップ 婚礼の日に沈家の側室たちが騒ぎ立てる？桃花は冷静に対処【桃花映江山 The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit3 =>
      'クリップ 桃花の首吊り狂言と気絶が見破られる！沈在野が針で刺して起こす【桃花映江山 The Princess\'s Gambit】';

  @override
  String get clipThePrincessSGambit4 =>
      'クリップ 沈宰相の厳しい捜査！偽金事件を徹底追究【桃花映江山 The Princess\'s Gambit】';

  @override
  String get eDrJjtCRF0 => 'eDr-jjtCRF0';

  @override
  String get clipThePrincessSGambit5 =>
      'クリップ 変装した刺客も見破る！名探偵桃花：足元が見え見えよ！【桃花映江山 The Princess\'s Gambit】';

  @override
  String get clipPlayThePrincessS =>
      'クリップ 簪を使った取調べ！沈在野が桃花の顎を持ち上げ問いただす【桃花映江山 The Princess\'s Gambit】';

  @override
  String get label58K8GxhXlQ => '58K8-gxhXlQ';

  @override
  String get clipThePrincessSGambit6 =>
      'クリップ 初対面からまさかの展開！合歓散（媚薬）に侵され見つめ合う沈在野と桃花【桃花映江山 The Princess\'s Gambit】';

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
      '【期間限定全話】雲襄伝 | The Ingenious One | iQIYI 👑メンバーシップに加入して、今すぐ全話を視聴しよう！';

  @override
  String get iQIYIGetTheIQIYIAPP2 => 'iQIYI 爱奇艺 - iQIYIアプリを入手';

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
      '【全話】👮ROAD HOME💕 | ジン・ボーラン、タン・ソンユン | iQIYI フィリピン';

  @override
  String get iQIYIPhilippinesGetTheIQIYI => 'iQIYI フィリピン - iQIYIアプリを入手';

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
      '【AI英語吹き替え】Mr. BAD | チェン・ジャーユエン、ユー・シェン | iQIYI フィリピン';

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
      '🌸【奇幻仙侠】🎋Love of the Divine Tree 仙台有樹 | 鄧為 × 向涵之 | FULL本編 | iQIYI 👑メンバーシップに登録して今すぐ全話を楽しもう！';

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
      '【全話】🕊️愛上特種兵（My Dear Guardian）| ホアン・ジンユー、リー・チン | iQIYI Philippines';

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
      '🌸【癒やしの恋】🎋The Best Thing 愛你 | ジャン・リンホー × シュー・ルーハン | 本編フル | iQIYI 👑メンバーシップに登録して今すぐ全話視聴！';

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
      '📽️【第1話 2026】中国ドラマ『冰湖重生』英語字幕 | リー・ユンルイ / ファンヤン・ティエンティエン / ジャン・カンラー ⛵😍 時代劇 2026 #冰湖重生';

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
      '【全話】🏹Fated Hearts | Li Qin, Chen Zheyuan | iQIYI Philippines';

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
      '【全話】Bright Eyes in the Dark | ホアン・ジンユー、ジャン・ジンイー | iQIYI Philippines';

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
      '🎥✨【英語字幕】中国ファンタジー映画 | ファンタジー、アドベンチャー【iQIYI MOVIE THEATER - チャンネル登録はこちら】';

  @override
  String get iQIYIMOVIETHEATERGetThe =>
      '爱奇艺大电影 iQIYI MOVIE THEATER - iQIYIアプリをダウンロード';

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
      '🎀【ショートドラマ】英語字幕 | 全話コレクション | WeTV / Tencent Videoアプリでさらに視聴';

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
      '【全話】Beauty of Resilience | ジュー・ジンイー、フィクション | iQIYI Philippines';

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
      '🔥話題作【子夜帰 Moonlit Reunion】全話 | 人間と妖怪が怪事件を解決しながら恋に落ちる | シュー・カイ、ティエン・シーウェイ | 英語字幕';

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
  String get fallInLove => '恋に落ちる';

  @override
  String get myGirl => 'マイ・ガール';

  @override
  String get firstRomance2 => '初恋';

  @override
  String get fallFor => '恋に落ちる';

  @override
  String get uCD83JhUFQXRDwC6S8caCQ => 'UCD_83Jh-UFQXRDwC6S8caCQ';

  @override
  String get uCFh5x5AZHQQ6FaGKnGQXDA => 'UCFh5x5AZHQQ6FaGKnG-QXDA';

  @override
  String get uCRABdhiBHX4BieJfPCd2pg => 'UCRABdhiBHX4Bie-jfPCd2pg';

  @override
  String get hiddenLove2 => '偷偷藏不住';

  @override
  String get loveBetweenFairyAndDevil2 => '蒼蘭訣';

  @override
  String get loveLikeTheGalaxy2 => '星漢燦爛';

  @override
  String get myJourneyToYou2 => '雲之羽';

  @override
  String get mysteriousLotusCasebook2 => '蓮花楼';

  @override
  String get reset => 'リセット';

  @override
  String get theLongBallad2 => '長歌行';

  @override
  String get theUntamed2 => '陳情令';

  @override
  String get wordOfHonor2 => '山河令';

  @override
  String get lightOfDawn2 => '人之初 夜明けの光';

  @override
  String get hOMELANDGUARDIAN2 => '守誠者|故郷の守護者';

  @override
  String get searching2 => '検索中...';

  @override
  String get verse => '詩節';

  @override
  String get allStories2 => 'すべてのストーリー';

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
  String get char2 => '+ 文字 +';

  @override
  String get sentenceText2 => '.sentence-text';

  @override
  String get ttsBtn => 'tts-btn';

  @override
  String get hanziTranslateBtn => 'hanzi-translate-btn';

  @override
  String get label10px16px => '10px 16px';

  @override
  String get articleArticlePostContentMain => '記事、.article、.post、.content、メイン';

  @override
  String get ttsActiveWord => '.tts-active-word';

  @override
  String get ttsActiveWord2 => 'tts-active-word';

  @override
  String get upperIntermediate2 => '中上級';

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
  String get processing => '処理中…';

  @override
  String get keepItUp => '好！その調子';

  @override
  String get minutesDay => '分 / 日';

  @override
  String get consistencyIsTheInkThat => '「継続こそが漢字を形作る墨となる。」';

  @override
  String get businessCareer => 'ビジネス＆キャリア';

  @override
  String get travelSurvival => '旅行・サバイバル';

  @override
  String get label05MinDay => '5分 / 日';

  @override
  String get label10MinDay => '10分 / 日';

  @override
  String get label20MinDay => '20分 / 日';

  @override
  String get label30MinDay => '30分 / 日';

  @override
  String get dynamicDecksStrokeAnalysis => 'ダイナミック単語帳＆筆順解析';

  @override
  String get subscriptionsAreTemporarilyUnavailablePl =>
      '現在サブスクリプションをご利用いただけません。もう一度お試しください。';

  @override
  String get trialReminder => '無料体験のリマインダー';

  @override
  String get turnOnNotificationsIfYou =>
      '無料体験の終了前に通知を受け取りたい場合は、通知をオンにしてください。正確な契約内容はApp Storeのサブスクリプション設定をご確認ください。';

  @override
  String get label2Months => '2ヶ月';

  @override
  String get label3Months => '3ヶ月';

  @override
  String get label6Months => '6ヶ月';

  @override
  String get billingPeriod => '請求期間';

  @override
  String get chooseASubscription => 'サブスクリプションを選択';

  @override
  String get startFreeTrial => '無料体験を開始';

  @override
  String get smartNewsDict => 'スマートニュース＆辞書';

  @override
  String get hSK16AIDecks => 'HSK 1〜6＆AI単語帳';

  @override
  String get continueWithTemporaryPremium => '一時的なプレミアムで継続';

  @override
  String get testProductUnavailable => 'テスト商品は利用できません';

  @override
  String get paymentIsChargedToYour => 'お支払いはApp Storeアカウントに課金されます。';

  @override
  String get subscriptionsRenewAutomaticallyUnlessCan =>
      'キャンセルされない限り、サブスクリプションは自動更新されます';

  @override
  String get atLeast24HoursBefore => '現在の期間終了の24時間以上前までに。';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get closePurchaseOffer => 'オファーを閉じる';

  @override
  String get loading => '読み込み中...';

  @override
  String get analyzingImage2 => '画像を解析中…';

  @override
  String get extractingChineseText2 => '中国語テキストを抽出中…';

  @override
  String get lookingUpVocabulary2 => '単語を検索中…';

  @override
  String get deselectAll => '選択をすべて解除';

  @override
  String get selectAll => 'すべて選択';

  @override
  String get worldChineseLiteraryMasterpiece => '世界と中国の文学的名作。';

  @override
  String get classic => '古典';

  @override
  String get literature => '文学';

  @override
  String get theOriginAwakening => '起源と覚醒';

  @override
  String get turbulentHorizonsTheJourney => '波乱の地平と旅路';

  @override
  String get trialsTribulationsDevotion => '試練と苦難、そして献身';

  @override
  String get theClashOfWitsBravery => '知略と勇気の激突';

  @override
  String get theGrandClimaxResolution => '大クライマックスと決着';

  @override
  String get everlastingLegacyEpilogue => '不滅の遺産とエピローグ';

  @override
  String get acrossTheVastExpanseOf =>
      '広大な天地の中で、登場人物たちは過酷な試練を通じて自らの運命と信念を追い求めていきます。';

  @override
  String get everyDialogueAndEncounterWithin =>
      '物語の中のあらゆる対話と出会いには、人間の精神の輝きと時代の刻印が込められています。';

  @override
  String get followingTheFlowOfProse =>
      '文章の流れを追いながら、読者は幾世紀もの時を超え、伝説的人物たちの栄光と哀しみを共にします。';

  @override
  String get preQin => '先秦';

  @override
  String get theGoddessNWaRepairing => '女媧の補天';

  @override
  String get artsTraditions => '芸術と伝統';

  @override
  String get femaleWarm => '女性（温かい）';

  @override
  String get femaleCheerful => '女性（明るい）';

  @override
  String get maleUpbeat => '男性（陽気）';

  @override
  String get maleNewsStyle => '男性（ニュース風）';

  @override
  String get maleSporty => '男性（スポーティー）';

  @override
  String get onDevice => 'オンデバイス';

  @override
  String get label15Minutes => '15分';

  @override
  String get label30Minutes => '30分';

  @override
  String get label45Minutes => '45分';

  @override
  String get selectChapter => '章を選択';

  @override
  String get andContinuesToBeStudied => '世代を超えて多くの読者に学び親しまれ続けています。';

  @override
  String get label1Poem => '1つの詩';

  @override
  String get label1Chapter => '1章';

  @override
  String get localDeviceVoice2 => '端末の音声';

  @override
  String get weeklyAzureQuotaReachedSwitching =>
      '週間のAzure上限に達したため、端末の音声に切り替えます';

  @override
  String get sleepTimer2 => 'スリープタイマー';

  @override
  String get tableOfContents2 => '目次';

  @override
  String get hanziMaster10 => 'HanziMaster/1.0';

  @override
  String get spanishItalianRussianClassics => 'スペイン・イタリア・ロシアの古典';

  @override
  String get englishAmericanGlobalClassics => '英米・世界の名作';

  @override
  String get whileStrategicallyEmbeddingWordsYou =>
      '苦手な単語を効果的に組み込み、文脈の中で学習できるようにします。';

  @override
  String get poetryPainting => '詩画';

  @override
  String get contactSinosparkCom => 'contact@sinospark.com';

  @override
  String get shadowingStudioIsADedicated =>
      'シャドーイングスタジオは、ネイティブの発音を模倣して練習するための専用機能です。フレーズを聴いて自分の声を録音し、波形や発音スコアを比較してアクセントを磨くことができます。';

  @override
  String get theVoicesInAIStories =>
      'AIストーリーとロールプレイでは、高度な音声合成モデルによる合成音声を使用し、明瞭で自然な中国語の発音になるよう調整しています。一部の機能では端末内の音声も利用できます。';

  @override
  String get theWebExplorerAllowsYou =>
      'Webエクスプローラーでは、任意の中国語ウェブサイトを閲覧できます。難しい単語をタップするだけでクイックルックカードが開き、ピンイン、意味、HSKレベルが瞬時に表示されます。';

  @override
  String get zenModeStripsAwayDistracting =>
      '禅モードは、記事から余分なウェブ要素や広告、複雑なレイアウトを取り除き、テキストだけに集中できるシンプルで美しい読書環境を提供します。';

  @override
  String get weUseAnIntelligentAlgorithm =>
      '単語を忘れそうになるタイミングを予測するスマートなアルゴリズムを使用しています。苦手な単語は頻繁に出題され、よく覚えている単語は復習間隔が長く設定されます。';

  @override
  String get usage3 => '使用例:';

  @override
  String get tutorialOneExplanation => 'これは「一（Yī）」です。常に左から右に向かって書きます。';

  @override
  String get tutorialWaterExplanation =>
      'これは漢字の「水（Shuǐ）」です。偏（へん）として使われると、「氵（さんずい）」に姿を変えます！';

  @override
  String get tutorialRadicalsExplanation =>
      '漢字は「部首」と呼ばれる要素で構成されています。部首は漢字の根本的な意味やテーマを表します。';

  @override
  String get tutorialLettersExplanation =>
      '漢字は単なる文字ではなく、時間を切り取った絵画です。マスターするには、その筆順の流れを身につけましょう。';

  @override
  String get tutorialGalaxyExplanation =>
      '銀河マップがあなたを待っています。太陽（部首）をマスターして、惑星（漢字）を解放しましょう。';

  @override
  String get onboardingDailyLifeTravel => '日常会話・旅行';

  @override
  String get onboardingPhilosophyIdioms => '哲学・成語';

  @override
  String get onboardingBusinessCareerMulti => 'ビジネス＆\nキャリア';

  @override
  String get onboardingTravelSurvivalMulti => '旅行＆\nサバイバル';

  @override
  String get onboardingHskCertificationMulti => 'HSK\n対策';

  @override
  String get onboardingCulturalAppreciationMulti => '文化\n鑑賞';

  @override
  String get practiceReminders => '練習リマインダー';

  @override
  String get oneOptionalDailyReminderTo => '中国語を練習するための1日1回の通知（設定任意）';

  @override
  String get aFewMinutesOfChinese => '少しだけ中国語を練習しませんか？🌱';

  @override
  String get keepYourProgressMovingWith => '短時間の練習で、日々の学習を進めましょう。';

  @override
  String get xuX => 'xué xí';

  @override
  String get toStudyToLearn => '学ぶ・学習する';

  @override
  String get pNgYou => 'péng you';

  @override
  String get fXiN => 'fā xiàn';

  @override
  String get toDiscover => '発見する';

  @override
  String get jiNCh => 'jiān chí';

  @override
  String get toPersist => 'やり抜く';

  @override
  String get yNgQ => 'yǒng qì';

  @override
  String get zhHu => 'zhì huì';

  @override
  String get chNgZhNg => 'chéng zhǎng';

  @override
  String get toGrow => '成長する';

  @override
  String get pNgJNg => 'píng jìng';

  @override
  String get calmPeaceful => '穏やか・平和';

  @override
  String get xWNg => 'xī wàng';

  @override
  String get lJi => 'lǐ jiě';

  @override
  String get toUnderstand => '理解する';

  @override
  String get xGuN => 'xí guàn';

  @override
  String get wNNuN => 'wēn nuǎn';

  @override
  String get warmthWarm => '温もり・暖かい';

  @override
  String get zhuNZh => 'zhuān zhù';

  @override
  String get toFocus => '集中する';

  @override
  String get definitionExpansionButton => '定義展開ボタン';

  @override
  String get wenigerAnzeigen => '表示を減らす';

  @override
  String get mostrarMenos => '表示を減らす';

  @override
  String get afficherMoins => '表示を減らす';

  @override
  String get mostraMeno => '表示を減らす';

  @override
  String get showFewer => '表示を減らす';

  @override
  String get masterLin => 'マスター・リン';

  @override
  String get xiaoMei => 'シャオメイ';

  @override
  String get thePoet => '詩人';

  @override
  String get aQiang => '阿強';

  @override
  String get vivian => 'ヴィヴィアン';

  @override
  String get formalWise => '礼儀正しく知性的';

  @override
  String get casualFriendly => '気さくで親しみやすい';

  @override
  String get poeticAncient => '詩的で古風';

  @override
  String get slangInternet => 'ネット＆スラング';

  @override
  String get trendyModern => 'トレンディ＆現代的';

  @override
  String get designYourOwn => '自分専用を作成';

  @override
  String get theBambooSwaysAndThe => '竹がそよぎ、学者は朝の雨のようにあなたの言葉を待っています…';

  @override
  String get yourCustomPersonaIsActive =>
      'カスタムペルソナが有効です。メッセージを入力して会話を開始してください。';

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
  String get staleDictionaryExpansionResponse => '古い辞書拡張レスポンス';

  @override
  String get dictionaryExpansionWasEmpty => '辞書拡張レスポンスが空です';

  @override
  String get explicationDTaillEDisponible => '詳細な解説があります';

  @override
  String get ausfHrlicheErklRungVerf => '詳細な解説があります';

  @override
  String get explicaciNDetalladaDisponible => '詳細な解説があります';

  @override
  String get spiegazioneDettagliataDisponibile => '詳細な解説があります';

  @override
  String get explicaODetalhadaDisponVel => '詳細な解説があります';

  @override
  String get detailedExplanationAvailable => '詳細な解説があります';

  @override
  String get oneOptionalDailyPracticeReminder => '毎日の学習リマインダー（任意・1回）';

  @override
  String get chooseOneOptionalDailyPractice => '毎日の学習リマインダーを1つ選択してください（任意）。';

  @override
  String get practiceReminder => '学習リマインダー';

  @override
  String get oneGentleReminderADay => 'リマインダーは必要な時に1日1回だけ';

  @override
  String get finishingPracticeSilencesTodayS => '練習を完了すると本日の通知は届きません。復習と';

  @override
  String get reEngagementAlertsAreCombined => '再開通知はまとめられるため、重複して届くことはありません。';

  @override
  String get processing2 => '処理中…';

  @override
  String get wDKIChu => 'wǒ dǎ kāi chuāng hu';

  @override
  String get listen => '聴く';

  @override
  String get notice => '注目';

  @override
  String get fourTones => '四声';

  @override
  String get write => '書く';

  @override
  String get recap => 'おさらい';

  @override
  String get playbackDidNotStart => '再生が開始されませんでした';

  @override
  String get audioIsUnavailableYouCan => '音声を利用できません。このまま読み進めることができます。';

  @override
  String get microphoneAccessWasNotGranted =>
      'マイクへのアクセスが許可されていません。「設定」から有効にできます。';

  @override
  String get recordingIsUnavailableRightNow => '現在、録音を利用できません。';

  @override
  String get listeningToYourTones => '声調を聴き取っています…';

  @override
  String get noRecording => '録音なし';

  @override
  String get weCouldNotScoreThat => '録音を採点できなかったため、サンプル声調の比較を表示します。';

  @override
  String get listenForTheLowDipping => '低く下がる第三声に注目して聴いてみましょう。';

  @override
  String get firstHearATinyMoment => 'まずは短い中国語を聴いてみましょう。暗記はまだ不要です。';

  @override
  String get loadingAudio => '音声を読み込み中…';

  @override
  String get listenToThePassage => '文章を聴く';

  @override
  String get continueAction => '次へ';

  @override
  String get noticeHowMeaningSoundAnd => '意味、発音、漢字がどのように結びついているかに注目しましょう。';

  @override
  String get shadowOneSentence => '1文をシャドーイング';

  @override
  String get listenOnceThenHoldThe => '一度聴いてから、マイクを押しながら発音してみましょう。';

  @override
  String get hearItAgain => 'もう一度聞く';

  @override
  String get stopAndCheckMyTones => '一時停止して声調を確認';

  @override
  String get useMicrophone => 'マイクを使用';

  @override
  String get iCanTSpeakRight => '今は話せない';

  @override
  String get tapACharacterToCompare => '文字をタップして発音した声調と目標を比較し、第1〜4声を聞けます。';

  @override
  String get tryHandwriting => '手書きを試す';

  @override
  String get seeWhatYouLearned => '学習内容を確認';

  @override
  String get inAFewMinutesYou => 'わずか数分で、レッスンと同じ学習サイクルを体験できました。';

  @override
  String get listenedToChineseInContext => '文脈の中で中国語を聴いた';

  @override
  String get shadowedASentence => '文をシャドーイングした';

  @override
  String get comparedMandarinTones => '中国語の声調を比較した';

  @override
  String get practicedARealCharacter => '実際の漢字を練習した';

  @override
  String get qNgchNXiOy =>
      'Qīngchén, xiǎoyǔ tíng le. Wǒ dǎkāi chuānghu, tīngjiàn niǎor zài shù shàng chànggē. Xīn de yì tiān kāishǐ le.';

  @override
  String get atDawnTheLightRain =>
      '早朝、小雨が上がりました。窓を開けると、木々で鳥が鳴いているのが聞こえました。新しい一日の始まりです。';

  @override
  String get learnThroughRealVideos => '実践的な動画で学ぶ';

  @override
  String get followInteractiveSubtitlesLookUp =>
      'インタラクティブ字幕を見ながら即座に単語を検索し、あらゆる動画をレッスンに変えましょう。';

  @override
  String get videoLearningScreenshot => '動画学習のスクリーンショット';

  @override
  String get turnAnyBookIntoA => 'あらゆる本をレッスン＆オーディオブックに';

  @override
  String get readNaturallyWithPronunciationDefinition =>
      '発音、意味、翻訳をいつでも参照しながら、自然に読み進められます。';

  @override
  String get bookReaderScreenshot => 'ブックリーダーのスクリーンショット';

  @override
  String get speakWithTheRightRhythm => 'AIとリアルタイム声調で自由に会話';

  @override
  String get shadowNativeAudioAndVisualize =>
      'ネイティブ音声でシャドーイングし、4つの声調を視覚化して発音を磨きましょう。';

  @override
  String get shadowingAndTonesScreenshot => 'シャドーイングと声調のスクリーンショット';

  @override
  String get understandEveryCharacter => 'すべての漢字を理解する';

  @override
  String get exploreMeaningPronunciationComponentsStr =>
      '意味、発音、構成要素、書き順、役立つ語彙をひとつの場所で確認できます。';

  @override
  String get characterDictionaryScreenshot => '漢字辞典のスクリーンショット';

  @override
  String get learnChineseWithoutLimits => '制限なしで中国語を学ぶ';

  @override
  String get watchReadSpeakAndUnderstand =>
      '観る、読む、話す、理解する。これひとつで完結する中国語学習パートナー。';

  @override
  String get seeWhatPremiumUnlocks => 'プレミアムの特典を見る';

  @override
  String get scrollToExploreTheComplete => 'スクロールしてすべての学習機能をチェック';

  @override
  String get cOMINGSOON => '近日公開';

  @override
  String get guidedHandwritingPractice => 'ガイド付き手書き練習';

  @override
  String get scannerAndLiveTranslation => 'スキャナーとリアルタイム翻訳';

  @override
  String get hSK16AndAI => 'HSK 1〜6とAI単語帳';

  @override
  String get smartSpacedRepetition2 => 'スマート分散学習';

  @override
  String get progressAndStreakTracking => '進捗と連続記録の追跡';

  @override
  String get learningToolsInOnePlace => '学習ツールをひとつに';

  @override
  String get everythingIncluded => 'すべてが含まれています';

  @override
  String get paymentIsChargedToYour2 =>
      'お支払いはApp Storeアカウントに請求されます。現在の期間が終了する少なくとも24時間前にキャンセルされない限り、サブスクリプションは自動更新されます。';

  @override
  String get yourFirstWeekOfTracked => '練習記録の最初の1週間';

  @override
  String get sameNumberOfCardsAs => '先週と同じカード数';

  @override
  String cardsComparedWithLastWeek(String change) {
    return '先週比 $change カード';
  }

  @override
  String get todaySPractice => '今日の練習';

  @override
  String get goalCompleteAnythingMoreIs => '目標達成！ここからはボーナスです。';

  @override
  String get aSmallAchievableTargetNo => '無理のない達成可能な目標。休んでもペナルティはありません。';

  @override
  String get thisWeek => '今週';

  @override
  String get minutes => '分';

  @override
  String get activeDays => '学習日数';

  @override
  String dayStreakCount(int count) {
    return '$count日連続';
  }

  @override
  String get masterChineseOneStrokeAt => '一画ずつ、中国語をマスターしよう';

  @override
  String get dictionaryExpansionButton => '辞書拡張ボタン';

  @override
  String get kIErweiterterWRterbucheintrag => 'AI拡張辞書エントリー';

  @override
  String get detalleAmpliadoPorIA => 'AIによる詳細解説';

  @override
  String get dTailEnrichiParL => 'AIによる詳細解説';

  @override
  String get aI => 'AIによる辞書詳細';

  @override
  String get detailKamusYangDiperluasAI => 'AIによる辞書詳細';

  @override
  String get dettaglioDelDizionarioAmpliatoDall => 'AIによる辞書詳細';

  @override
  String get aI2 => 'AIによる辞書の補足';

  @override
  String get aI3 => 'AIによる辞書詳細';

  @override
  String get detalheDeDicionRioExpandido => 'AIによる辞書詳細';

  @override
  String get aI4 => 'AIによる辞書詳細';

  @override
  String get chiTiTTI => 'AIによる辞書詳細';

  @override
  String get aI5 => 'AIによる辞書詳細';

  @override
  String get aIExpandedDictionaryDetail => 'AIによる辞書詳細';

  @override
  String get cetteEntrEEstBr => 'この項目は簡略的です。詳細な説明を利用できます。';

  @override
  String get dieserEintragIstKurzEine => 'この項目は簡略的です。詳細な説明を利用できます。';

  @override
  String get estaEntradaEsBreveHay => 'この項目は簡略的です。詳細な説明を利用できます。';

  @override
  String get questaVoceBreveDisponibileUna => 'この項目は簡略的です。詳細な説明を利用できます。';

  @override
  String get estaEntradaBreveEstDispon => 'この項目は簡略的です。詳細な説明を利用できます。';

  @override
  String get thisDictionaryEntryIsBrief => 'この辞書項目は簡略的です。詳細な説明を利用できます。';

  @override
  String get dVelopperEnFranAis => 'フランス語で拡張';

  @override
  String get aufDeutschErweitern => 'ドイツ語で拡張';

  @override
  String get ampliarEnEspaOl => 'スペイン語で拡張';

  @override
  String get approfondisciInItaliano => 'イタリア語で拡張';

  @override
  String get expandirEmPortuguS => 'ポルトガル語で拡張';

  @override
  String get expandDefinition => '定義を拡張';

  @override
  String get impossibleDeChargerLExplication => '説明を読み込めませんでした。';

  @override
  String get dieErklRungKonnteNicht => '解説を読み込めませんでした。';

  @override
  String get noSePudoCargarLa => '解説を読み込めませんでした。';

  @override
  String get impossibileCaricareLaSpiegazione => '解説を読み込めませんでした。';

  @override
  String get nOFoiPossVel => '解説を読み込めませんでした。';

  @override
  String get unableToLoadTheExplanation => '解説を読み込めませんでした。';

  @override
  String get failedToGenerateStoryN => 'ストーリーの生成に失敗しました：\\n\$e';

  @override
  String get thematic => 'テーマ別';

  @override
  String get deckFlashcards => 'デッキ (フラッシュカード)';

  @override
  String get searchLibraryOrTypeCustom => 'ライブラリを検索またはカスタム入力';

  @override
  String get hSKLevel => 'HSK \$level';

  @override
  String get analysisFailedE => '分析に失敗しました: \$e';

  @override
  String get extractionFailedE => '抽出に失敗しました: \$e';

  @override
  String get simplifyFailedE => '簡略化に失敗しました: \$e';

  @override
  String get translationFailedE => '翻訳に失敗しました: \$e';

  @override
  String get failedToSaveExtractedWords2 => '抽出された単語の保存に失敗しました: \$error';

  @override
  String youActualTargetExpected(String actual, String expected) {
    return 'あなた: $actual  ·  お手本: $expected';
  }

  @override
  String get improveTheLocalVoice => 'ローカル音声を改善する';

  @override
  String get higherQualityOfflineMandarin => '高品質オフライン中国語';

  @override
  String get removeDownload => 'ダウンロードを削除しますか？';

  @override
  String get removeDownload2 => 'ダウンロードを削除';

  @override
  String get tag => '#\$tag';

  @override
  String get voiceFemaleWarm => '女性、温かみのある声';

  @override
  String get voiceFemaleCheerful => '女性、明るい声';

  @override
  String get voiceMaleUpbeat => '男性、アップビートな声';

  @override
  String get voiceMaleNewsStyle => '男性、ニュース調の声';

  @override
  String get voiceMaleSporty => '男性、快活な声';

  @override
  String get voiceOnDeviceTts => '端末内音声合成';

  @override
  String get voiceSystemVoice => 'システム音声';

  @override
  String get applySessionGradesToSpacedRepetition =>
      'セッション結果を分散学習システム（スピーキングモード）に反映';

  @override
  String get unableToLoadThisSectionPleaseTryAgain =>
      'このセクションを読み込めませんでした。もう一度お試しください。';

  @override
  String get removeDownloadQuestion => 'ダウンロードを削除しますか？';

  @override
  String get removeDownloadContent => 'Remove downloaded content?';

  @override
  String get removeDownloadAction => 'ダウンロードを削除';

  @override
  String get removeDownloadButton => 'ダウンロードを削除';

  @override
  String cardsCount(num count) {
    return '$count Cards';
  }

  @override
  String get aiSummary => 'AI要約';

  @override
  String get readability => '読みやすさ';

  @override
  String get translateAction => '翻訳';

  @override
  String get checkingDownload => '??????????';

  @override
  String downloadingBook(int percent) {
    return '????????$percent%';
  }

  @override
  String get retryDownload => '??????????';

  @override
  String get downloadBook => '????????';

  @override
  String continueChapter(int chapter) {
    return '?$chapter????????';
  }

  @override
  String get downloadBookError => '???????????????????????????????????????';

  @override
  String downloadBookOffline(int count) {
    return '?$count????????????????????????????';
  }

  @override
  String poemCount(int count) {
    return '$count?';
  }

  @override
  String get americanLiterature => '??????';

  @override
  String get ancientChina => '????';

  @override
  String get britishLiterature => '??????';

  @override
  String get frenchLiterature => '??????';

  @override
  String get germanLiterature => '?????';

  @override
  String get italianLiterature => '??????';

  @override
  String get jinDynasty => '??';

  @override
  String get preQinEra => '????';

  @override
  String get qingDynasty => '??';

  @override
  String get republicOfChinaEra => '?????';

  @override
  String get russianLiterature => '?????';

  @override
  String get spanishLiterature => '??????';

  @override
  String get springAndAutumn => '????';

  @override
  String get westernHan => '??';

  @override
  String get roleplayCreatorContextPlaceholder => '例：上海で開かれるにぎやかなお祝いの宴会...';

  @override
  String get roleplayCreatorPersonaPlaceholder =>
      '例：あなたのキャリアについて尋ねる好奇心旺盛ないとこ...';

  @override
  String get beginFirstLesson => '最初のレッスンを始める';

  @override
  String onboardingLessonProgress(Object current, Object total) {
    return '最初のレッスン  •  $current / $total';
  }

  @override
  String get onboardingListenInstruction =>
      'まずは、中国文学の名篇から響く一節をお聴きください。まだ暗記する必要はありません。';

  @override
  String get onboardingFromGrandLibrary => '古典文庫より';

  @override
  String get onboardingArtOfWarTitleAuthor => '『孫子』 · 孫武';

  @override
  String get onboardingArtOfWarChapter => '謀攻篇 · 第三章';

  @override
  String get onboardingClassicLineLabel => '至高の一句';

  @override
  String get onboardingArtOfWarTranslation => '「彼を知り己を知れば、百戦危うからず。」';

  @override
  String get onboardingNoticeMeaning => '彼を知り己を知れば、';

  @override
  String get onboardingShadowMeaning => '百戦してあやうからず。';

  @override
  String get onboardingPracticeThisLabel => '練習する文字';

  @override
  String get onboardingFromArtOfWarLabel => '『孫子』より';

  @override
  String get onboardingYourPronunciationLabel => 'あなたの発音';

  @override
  String get onboardingTapACharacter => '文字をタップ';

  @override
  String onboardingWordAndPinyin(String word, String pinyin) {
    return '$word · $pinyin';
  }

  @override
  String get onboardingToneMatched => '一致';

  @override
  String get onboardingCompareTones => '声調を比較';

  @override
  String get onboardingToneOneHigh => '第1声 · 高平調';

  @override
  String get onboardingToneTwoRising => '第2声 · 昇調';

  @override
  String get onboardingToneThreeDipping => '第3声 · 屈曲調';

  @override
  String get onboardingToneFourFalling => '第4声 · 降調';

  @override
  String get onboardingToneNotDetected => '検出されませんでした';

  @override
  String get onboardingFeedbackGreatThirdTone => '見事な第3声（屈曲調）です。';

  @override
  String get onboardingFeedbackFourthToneFall => '第4声は力強く、素早く下降させましょう。';

  @override
  String get onboardingFeedbackClearFourthTone => '明瞭な第4声（降調）です。';

  @override
  String get onboardingFeedbackStrongFourthTone => '力強い第4声（降調）です。';

  @override
  String onboardingTraceInstruction(
      String character, String pinyin, String meaning) {
    return '薄い運筆ガイドに沿って「$character」（$pinyin・「$meaning」）をなぞりましょう。';
  }

  @override
  String billingDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count日',
    );
    return '$_temp0';
  }

  @override
  String billingWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count週間',
    );
    return '$_temp0';
  }

  @override
  String billingMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countヶ月',
    );
    return '$_temp0';
  }

  @override
  String billingYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count年',
    );
    return '$_temp0';
  }

  @override
  String startPeriodFreeTrial(String period) {
    return '$period間の無料体験を開始';
  }

  @override
  String subscribeForPricePeriod(String price, String period) {
    return '$price / $period';
  }

  @override
  String eligibleTrialRenewalNotice(String price, String period) {
    return '対象の無料体験が含まれています。体験期間終了後は、キャンセルされない限り $period ごとに $price で自動更新されます。';
  }

  @override
  String pricePerPeriod(String price, String period) {
    return '$price / $period';
  }

  @override
  String get learn => '学ぶ';

  @override
  String get booksAndStudioQualityAudiobooks => '86冊の古典書籍とスタジオ品質のオーディオブック';

  @override
  String get aiConversationsAndLiveToneFeedback => 'AI会話とライブ声調フィードバック';

  @override
  String get interactiveVideoAndWebImmersion => 'インタラクティブ動画とWebイマージョン';

  @override
  String get characterInsightsAndHandwritingPractice => '文字のインサイトと手書き練習';

  @override
  String get hskDecksAndSmartSpacedRepetition => 'HSKデッキとスマート間隔反復学習';

  @override
  String get termsOfUseEula => '利用規約 (EULA)';

  @override
  String get masterEveryStroke => 'すべての筆画をマスターする';

  @override
  String get exploreTheChineseWeb => '中国のウェブを探索する';

  @override
  String get tone1Description => '音符を歌うように、高くて安定したピッチを保ちます。';

  @override
  String get tone2Description => '真ん中から始めて、「何？」と尋ねるようにピッチを上げます。';

  @override
  String get tone3Description => '声を低く下げてから、ゆっくりと元に戻します。';

  @override
  String get tone4Description => 'きっぱりとした「だめ！」のように、ピッチを鋭く決定的に下げます。';

  @override
  String get toneNeutralDescription => '柔らかく、短く、強調せずに発音します。';

  @override
  String get toneDiagMatch1 => '完璧です！音の高さは高く、平坦で安定していました。';

  @override
  String get toneDiagMatch2 => '完璧です！音の高さの上昇が明確でした。';

  @override
  String get toneDiagMatch3 => '完璧です！低い下降曲線が正確でした。';

  @override
  String get toneDiagMatch4 => '完璧です！鋭い下降が決定打でした。';

  @override
  String get toneDiagMatchDefault => '完璧です！声調は正確に発音されました。';

  @override
  String get toneDiag1vs2 => '音の高さが上がりました（2声 /）。音節全体で声を平坦に高く保ちましょう（1声 ˉ）。';

  @override
  String get toneDiag1vs3 => '声が下がりました（3声 ˇ）。音の高さが下がらないように、安定して高く保ちましょう（1声 ˉ）。';

  @override
  String get toneDiag1vs4 =>
      '音の高さが下がりました（4声 \\）。音符を歌うように、高く平坦な音の高さを維持しましょう（1声 ˉ）。';

  @override
  String get toneDiag2vs1 =>
      '平坦なままでした（1声 ˉ）。「何？」と尋ねるように、音の高さを上にスライドさせましょう（2声 /）。';

  @override
  String get toneDiag2vs3 =>
      '下がりすぎました（3声 ˇ）。中程度の高さから始めて、底に触れずにスムーズに上昇させましょう（2声 /）。';

  @override
  String get toneDiag2vs4 => '音の高さが下がりました（4声 \\）。質問するように上に上げましょう（2声 /）。';

  @override
  String get toneDiag3vs1 =>
      '高く平坦なままでした（1声 ˉ）。上がる前に、音の高さを胸のレジスターまで低く下げましょう（3声 ˇ）。';

  @override
  String get toneDiag3vs2 => 'すぐに上がりました（2声 /）。上がる前に、まず低く下がるようにしましょう（3声 ˇ）。';

  @override
  String get toneDiag3vs4 =>
      '上がらずに急激に下がりました（4声 \\）。最後に音の高さが優しく跳ね返るようにしましょう（3声 ˇ）。';

  @override
  String get toneDiag4vs1 =>
      '平坦なままでした（1声 ˉ）。きっぱりと「いいえ！」と言うように、音の高さを鋭く決定的に下げましょう（4声 \\）。';

  @override
  String get toneDiag4vs2 => '音の高さが上がりました（2声 /）。高く始めて、鋭く下に下げましょう（4声 \\）。';

  @override
  String get toneDiag4vs3 => '下がって上がりました（3声 ˇ）。上がらずにまっすぐ下に下げましょう（4声 \\）。';

  @override
  String get toneDiagListenDiff => '以下の4つの声調を聞いて違いを確認してください。';

  @override
  String get liveCallSpeaking => '話しています…';

  @override
  String get toneAccurate => '声調 正確';

  @override
  String get toneNeedsWork => '声調 要練習';

  @override
  String get liveCallSessionCompletedFallback =>
      'セッション完了。次の練習では、完全な文章で話すと詳しい発音と声調の診断を受けられます。';

  @override
  String liveCallGoodStartPracticingWord(String word) {
    return '「$word」の良い練習ができました。次のセッションでは、声調の移り変わりや自然な抑揚を意識して、完全な文章で話してみましょう。';
  }

  @override
  String get liveCallSolidEffortFallback =>
      'しっかりとした会話の練習ができました。第1声は高く平らに（55）、第4声は鋭く下げる（51）ことを意識すると、より自然でクリアな発音になります。';

  @override
  String get liveCallGoodPracticeFallback =>
      '良い練習セッションでした。声調の高低差を明確にし、自然な会話のテンポを意識していきましょう。';

  @override
  String sentenceNumber(Object number) {
    return '第$number文';
  }

  @override
  String endlessAiStreamSentence(Object count) {
    return 'AIエンドレスストリーム • 第$count文';
  }

  @override
  String get aiConsentTitle => 'AI練習とプライバシー';

  @override
  String get aiConsentSubtitle =>
      'SinoSparkは音声発音評価、対話ロールプレイ、学習ツールに安全なサードパーティAIサービスを使用しています。';

  @override
  String get aiConsentDataSentTitle => '送信されるデータ';

  @override
  String get aiConsentDataSentBody => '音声録音、発話テキスト、学習用プロンプト。';

  @override
  String get aiConsentProvidersTitle => 'サードパーティAIサービス';

  @override
  String get aiConsentProvidersBody =>
      '• Microsoft Azure AI Speech（発音評価・音声合成）\n• Google Gemini & DeepSeek（会話対話・単語帳生成）';

  @override
  String get aiConsentGuaranteesTitle => 'プライバシー保証';

  @override
  String get aiConsentGuaranteesBody =>
      'データは送信時に暗号化され、一時的にのみ処理され、販売されることはなく、公開AIモデルの学習に使用されることもありません。';

  @override
  String get aiConsentAgree => '同意してAIを使用';

  @override
  String get aiConsentLearnMore => '詳細を見る';

  @override
  String get viewPlans => 'プランを見る';

  @override
  String get authInvalidCredentials =>
      'メールアドレスまたはパスワードが正しくありません。アカウントをお持ちでない場合は登録してください。';

  @override
  String get authInvalidEmail => '有効なメールアドレスを入力してください。';

  @override
  String get authEmailAlreadyInUse => 'このメールアドレスのアカウントは既に存在します。';

  @override
  String get authWeakPassword => 'パスワードは6文字以上にする必要があります。';

  @override
  String get authTooManyRequests => '試行回数が多すぎます。後でもう一度お試しください。';

  @override
  String get authNetworkError => 'ネットワークエラー。接続を確認してください。';

  @override
  String get subscriptionRequired => 'サブスクリプションが必要です';

  @override
  String get subscriptionRequiredDesc =>
      'すべてのレッスン、書籍、AI音声ツールにアクセスするには、SinoSparkの有効なメンバーシップが必要です。';

  @override
  String signedInAs(String email) {
    return '$email としてログイン中';
  }

  @override
  String get battle => '戦い';

  @override
  String addedWordsAndUpdatedWords(
      int addedCount, int updatedCount, String deckName) {
    return '$addedCount件の新しい単語を追加し、「$deckName」の既存の$updatedCount件の単語を更新しました';
  }

  @override
  String addedWordsToDeck(int count, String deckName) {
    return '「$deckName」に$count語を追加しました';
  }

  @override
  String updatedWordsInDeck(int count, String deckName) {
    return '「$deckName」の既存の$count語を更新しました';
  }

  @override
  String addedCardToDeck(String hanzi, String deckName) {
    return '「$hanzi」を「$deckName」に追加しました';
  }

  @override
  String get callCategory => 'ライブ通話';

  @override
  String get aiCallFluencyTitle => '流暢さを高めるAI通話';

  @override
  String get aiCallFluencyDesc =>
      'AIチューターと実践的な音声会話を行い、リアルタイムで声調判定を受け、スピーキングの流暢さを向上させます。';

  @override
  String get decksCategory => '単語帳';

  @override
  String get decksSpacedRepetitionTitle => '間隔反復学習対応の単語帳';

  @override
  String get decksSpacedRepetitionDesc =>
      '科学的に実証された間隔反復アルゴリズムで、HSK 1〜6級およびカスタム単語帳をマスターします。';

  @override
  String get booksCategory => '書籍';

  @override
  String get classicalBooksPoemsTitle => '古典名作86冊と詩100選';

  @override
  String get classicalBooksPoemsDesc =>
      '音声同期と二言語対訳注釈で、時代を超えた名作文学や漢詩の世界に没入できます。';

  @override
  String get scanCategory => 'スキャナー';

  @override
  String get scannerScanCardsTitle => '画像をスキャンして単語帳に追加';

  @override
  String get scannerScanCardsDesc =>
      'カメラを中国語のテキスト、メニュー、看板に向けるだけで、瞬時に単語を抽出して単語帳に保存できます。';

  @override
  String get smartDictionaryStrokeOrderTitle => '筆順付きスマート辞書';

  @override
  String get liveAiVoiceCallsAndToneGrading => 'ライブAI音声通話とリアルタイム声調判定';

  @override
  String get shadowingStudioAndToneAnalysis => 'シャドーイングスタジオと声調ピッチの視覚分析';

  @override
  String get startMy7DaysFreeTrial => '7日間の無料体験を開始';

  @override
  String trialSubtextUnderCta(String price, String period) {
    return 'その後は$periodあたり$price。設定からいつでも解約可能。';
  }
}
