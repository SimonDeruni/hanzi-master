// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

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
  String get deleteAccount => 'Xóa tài khoản';

  @override
  String get deleteAccountSubtitle => 'Xóa vĩnh viễn tài khoản của bạn';

  @override
  String get deleteAccountTitle => 'Xóa vĩnh viễn tài khoản?';

  @override
  String get accountDataDeletedTitle => 'Dữ liệu tài khoản sẽ bị xóa';

  @override
  String get accountDataDeletedBody =>
      'Tài khoản đăng nhập và toàn bộ thông tin tài khoản được lưu trữ tại SinoSpark sẽ bị xóa vĩnh viễn. Hành động này không thể hoàn tác.';

  @override
  String get localDataKeptTitle => 'Dữ liệu trên thiết bị này sẽ được giữ lại';

  @override
  String get localDataKeptBody =>
      'Tiến độ học tập, nội dung đã tải xuống và các tùy chọn chỉ lưu trên thiết bị này sẽ không bị xóa.';

  @override
  String get subscriptionNotCanceledTitle => 'Gói đăng ký không tự động hủy';

  @override
  String get subscriptionNotCanceledBody =>
      'Xóa tài khoản không tự động hủy gói đăng ký trên App Store. Gói có thể tiếp tục gia hạn cho đến khi bạn hủy trong phần cài đặt của Apple.';

  @override
  String get manageSubscription => 'Quản lý gói đăng ký App Store';

  @override
  String get subscriptionManagementFailed =>
      'Không thể mở trang quản lý gói đăng ký của Apple. Vui lòng mở Cài đặt > chạm vào tên bạn > Gói đăng ký.';

  @override
  String get confirmPassword => 'Mật khẩu hiện tại';

  @override
  String get confirmPasswordToDelete =>
      'Nhập mật khẩu để xác minh danh tính của bạn.';

  @override
  String get deleteAccountPermanently => 'Xóa tài khoản vĩnh viễn';

  @override
  String get deleteAccountFinalTitle => 'Xác nhận lần cuối';

  @override
  String get deleteAccountFinalWarning =>
      'Thao tác này sẽ xóa vĩnh viễn tài khoản của bạn và không thể hoàn tác. Dữ liệu chỉ lưu trên thiết bị này sẽ được giữ lại. Bạn có muốn tiếp tục?';

  @override
  String get deletingAccount => 'Đang xóa tài khoản...';

  @override
  String get accountPasswordRequired => 'Nhập mật khẩu hiện tại để tiếp tục.';

  @override
  String get accountPasswordIncorrect =>
      'Mật khẩu không chính xác. Vui lòng thử lại.';

  @override
  String get accountReauthenticationCanceled =>
      'Xác thực danh tính đã bị hủy. Tài khoản của bạn chưa bị xóa.';

  @override
  String get accountReauthenticationFailed =>
      'Không thể xác minh danh tính. Vui lòng thử lại và hoàn tất yêu cầu đăng nhập.';

  @override
  String get accountAlreadySignedOut =>
      'Bạn đã đăng xuất. Không có tài khoản đăng nhập nào bị xóa.';

  @override
  String get accountProviderUnsupported =>
      'Phương thức đăng nhập này không thể xác minh trong ứng dụng. Vui lòng liên hệ bộ phận hỗ trợ để được trợ giúp xóa tài khoản.';

  @override
  String get appleDeletionRequiresAppleDevice =>
      'Vì lý do bảo mật, tài khoản liên kết với Apple phải được xóa trên thiết bị Apple.';

  @override
  String get accountDeletionNetworkError =>
      'Vui lòng kiểm tra kết nối mạng và thử xóa lại tài khoản.';

  @override
  String get accountDeletionFailed =>
      'Không thể xóa tài khoản. Tài khoản của bạn vẫn hoạt động. Vui lòng thử lại.';

  @override
  String get accountDeletedSuccessfully =>
      'Tài khoản của bạn đã được xóa vĩnh viễn.';

  @override
  String get globalMastery => 'MỨC ĐỘ THÀNH THẠO CHUNG';

  @override
  String get masteredCards => 'Đã thành thạo';

  @override
  String get hsk1Candidate => 'Ứng viên HSK 1';

  @override
  String get hsk2Candidate => 'Ứng viên HSK 2';

  @override
  String get hsk3Candidate => 'Ứng viên HSK 3';

  @override
  String get hsk4Candidate => 'Ứng viên HSK 4';

  @override
  String get hsk5Candidate => 'Ứng viên HSK 5';

  @override
  String get hsk6Candidate => 'Ứng viên HSK 6';

  @override
  String get hsk6Master => 'Bậc thầy HSK 6';

  @override
  String get currentRank => 'HẠNG HIỆN TẠI';

  @override
  String get next => 'Tiếp theo';

  @override
  String get searchHanziOrPinyin => 'Tìm chữ Hán hoặc Pinyin...';

  @override
  String get dailyReview => 'Ôn tập hằng ngày';

  @override
  String get upcomingForecast => 'Lịch ôn tập sắp tới';

  @override
  String get laterToday => 'Lát nữa hôm nay';

  @override
  String get tomorrow => 'Ngày mai';

  @override
  String get next7Days => '7 ngày tới';

  @override
  String get theScholarWay => 'Đạo Học Giả';

  @override
  String get beginJourney => 'Bắt đầu hành trình';

  @override
  String get settingsTitle => 'Cài đặt';

  @override
  String get darkMode => 'Giao diện tối';

  @override
  String get darkModeDesc => 'Dịu mắt hơn';

  @override
  String get voiceSpeed => 'Tốc độ giọng đọc';

  @override
  String get artAndIntellect => 'NGHỆ THUẬT & TRÍ TUỆ';

  @override
  String get theDigitalScholar => 'Học Giả Kỹ Thuật Số';

  @override
  String get refineBrushVoice => 'Rèn nét bút và giọng đọc cùng AI.';

  @override
  String get liveVoiceCall => 'Gọi thoại trực tiếp';

  @override
  String get immersiveRoleplay => 'Nhập vai đắm chìm cùng AI';

  @override
  String get readingRoom => 'Phòng đọc sách';

  @override
  String get shadowingStudio => 'Phòng luyện Shadowing';

  @override
  String get errorPrefix => 'Lỗi: ';

  @override
  String get initializingLibrary => 'Đang khởi tạo thư viện...';

  @override
  String get unlockCharactersToQuiz => 'Mở khóa 4 chữ Hán để làm quiz!';

  @override
  String get practiceQuiz => 'QUIZ LUYỆN TẬP';

  @override
  String get curriculumPaths => 'LỘ TRÌNH HỌC';

  @override
  String get noDecksFound => 'Chưa có bộ thẻ nào. Hãy thêm ngay!';

  @override
  String get addCardsFirst => 'Hãy thêm thẻ trước!';

  @override
  String get aiDraftingPath => 'AI đang phác thảo lộ trình...';

  @override
  String get pathReady => 'Lộ trình đã sẵn sàng!';

  @override
  String get errorGeneratingPath => 'Lỗi tạo lộ trình';

  @override
  String get brushingCurriculum => 'Đang tạo giáo trình...';

  @override
  String get warmUp => 'KHỞI ĐỘNG';

  @override
  String get lessonComplete => 'Hoàn thành bài học! +10 Điểm Mực';

  @override
  String get step1Origin => 'BƯỚC 1: NGUỒN GỐC';

  @override
  String get traceRadical => 'Tô nét bộ thủ';

  @override
  String get step2Forge => 'BƯỚC 2: RÈN LUYỆN';

  @override
  String get chooseEssence => 'Chọn bản chất';

  @override
  String get wrongEssence => 'Chưa đúng! Thử lại nhé.';

  @override
  String get step3Hunt => 'BƯỚC 3: TRUY TÌM';

  @override
  String get findCharacters => 'Tìm chữ Hán';

  @override
  String get notThatOne => 'Không phải chữ này!';

  @override
  String get successfullyInstalled => 'Cài đặt thành công:';

  @override
  String get failedToDownload => 'Tải xuống thất bại.';

  @override
  String get rescindTitle => 'Gỡ bỏ?';

  @override
  String get removeCharactersWarning => 'Thao tác này sẽ xóa các chữ Hán này.';

  @override
  String get cancel => 'Hủy';

  @override
  String get uninstall => 'Gỡ cài đặt';

  @override
  String get removedLibrary => 'Đã xóa khỏi thư viện:';

  @override
  String get tomeLibrary => 'Thư Viện Thư Tịch';

  @override
  String get libraryError => 'Lỗi Thư Viện';

  @override
  String get installTome => 'CÀI ĐẶT';

  @override
  String get unitIntro => 'GIỚI THIỆU BÀI HỌC';

  @override
  String get constellationCluster => 'Cụm Chòm Sao';

  @override
  String get ok => 'OK';

  @override
  String get divingInto => 'Đang khám phá sâu...';

  @override
  String get keyRadicals => 'BỘ THỦ CHÍNH';

  @override
  String get noRadicalData => 'Không có dữ liệu bộ thủ.';

  @override
  String get discovery => 'KHÁM PHÁ';

  @override
  String get startLearning => 'BẮT ĐẦU HỌC';

  @override
  String get selectPersona => 'Chọn nhân vật';

  @override
  String get customPersona => 'Nhân vật tùy chỉnh';

  @override
  String get geminiLiveCall => 'GỌI TRỰC TIẾP';

  @override
  String get returnToMenu => 'Quay lại';

  @override
  String get strokeAnalysis => 'Phân tích thứ tự nét';

  @override
  String get excellentWork => 'Làm tốt lắm!';

  @override
  String get keepPracticing => 'Tiếp tục luyện tập nhé!';

  @override
  String get drawingSubmitted => 'Đã gửi nét vẽ';

  @override
  String get customPersonaHint => 'Mô tả tính cách nhân vật...';

  @override
  String get stepOneOrigin => 'BƯỚC 1: NGUỒN GỐC';

  @override
  String get stepTwoForge => 'BƯỚC 2: RÈN LUYỆN';

  @override
  String get toForge => 'Để tạo chữ';

  @override
  String get whatEssenceDoesNeed => 'chữ này cần yếu tố nào';

  @override
  String get need => 'cần';

  @override
  String get forged => 'ĐÃ TẠO THÀNH';

  @override
  String get stepThreeHunt => 'BƯỚC 3: TRUY TÌM';

  @override
  String get findCharactersWith => 'Tìm chữ Hán chứa';

  @override
  String get uninstallButton => 'GỠ CÀI ĐẶT';

  @override
  String get gradedAiStories => 'Truyện AI phân cấp';

  @override
  String get calligraphy => 'Thư pháp';

  @override
  String get theScrollOfOrigin => 'Cuộn Giấy Khởi Nguyên';

  @override
  String get galaxyOf => 'Thiên hà của';

  @override
  String get constellationDescription => 'Mô tả chòm sao';

  @override
  String get noRadicalDataAvailable => 'Không có dữ liệu bộ thủ';

  @override
  String get learningPreferences => 'Tùy chọn học tập';

  @override
  String get hardMode => 'Chế độ khó';

  @override
  String get hardModeDesc =>
      'Yêu cầu viết chính xác mà không có nét mẫu hướng dẫn.';

  @override
  String get adaptiveGuidance => 'Hướng dẫn thích ứng';

  @override
  String get dailyGoal => 'Mục tiêu hằng ngày';

  @override
  String get audioAndHaptics => 'Âm thanh & Phản hồi xúc giác';

  @override
  String get autoPlayAudio => 'Tự động phát âm thanh';

  @override
  String get autoPlayDesc => 'Tự động phát âm khi lật thẻ.';

  @override
  String get haptics => 'Rung xúc giác (Haptic)';

  @override
  String get displayAndContent => 'Hiển thị & Nội dung';

  @override
  String get useEnglishDefinitions => 'Dùng định nghĩa tiếng Anh';

  @override
  String get useEnglishDefinitionsDesc =>
      'Định nghĩa tiếng Anh thường có sắc thái chi tiết và chính xác hơn';

  @override
  String get animationSpeed => 'Tốc độ hoạt ảnh';

  @override
  String get manageTomes => 'Quản lý thư tịch';

  @override
  String get manageTomesDesc => 'Quản lý các tập tài liệu học đã cài đặt.';

  @override
  String get dangerZone => 'Vùng nguy hiểm';

  @override
  String get resetAllData => 'Đặt lại tất cả dữ liệu';

  @override
  String get resetDataDesc =>
      'Thao tác này sẽ xóa vĩnh viễn toàn bộ tiến trình học, thống kê và cài đặt của bạn. Hành động này không thể hoàn tác.';

  @override
  String get areYouSure => 'Bạn có chắc chắn không?';

  @override
  String get cannotBeUndone => 'Không thể hoàn tác';

  @override
  String get deleteEverything => 'Xóa tất cả';

  @override
  String get appLanguage => 'Ngôn ngữ ứng dụng';

  @override
  String get howDidYouDo => 'Bạn làm bài thế nào?';

  @override
  String get missedItEntirely => 'Quên hoàn toàn';

  @override
  String get gotItButStruggled => 'Nhớ nhưng còn chật vật';

  @override
  String get gotItClearly => 'Nhớ rõ ràng';

  @override
  String get perfectAndImmediate => 'Hoàn hảo & tức thì';

  @override
  String get again => 'Học lại';

  @override
  String get hard => 'Khó';

  @override
  String get good => 'Tốt';

  @override
  String get easy => 'Dễ';

  @override
  String get tapToReveal => 'Chạm để xem đáp án';

  @override
  String get howWellDidYouRemember => 'Khả năng ghi nhớ của bạn thế nào?';

  @override
  String get completelyForgot => 'Hoàn toàn quên';

  @override
  String get gotItWithDifficulty => 'Nhớ ra một cách khó khăn';

  @override
  String get recalledCorrectly => 'Nhớ chính xác';

  @override
  String get perfectRecall => 'Nhớ bài hoàn hảo';

  @override
  String get practiceWriting => 'Luyện viết chữ';

  @override
  String get hideScratchpad => 'Ẩn bảng nháp';

  @override
  String get whatCharacterMeans => 'Ý nghĩa của chữ Hán:';

  @override
  String get tapCardToReveal => 'Chạm vào thẻ để lật mặt sau';

  @override
  String get ratePronunciationConfidence => 'Đánh giá mức độ tự tin phát âm';

  @override
  String get botchedIt => 'Phát âm sai nhiều';

  @override
  String get struggledWithTones => 'Khó khăn với thanh điệu';

  @override
  String get acceptable => 'Tạm ổn';

  @override
  String get perfectlyNatural => 'Rất tự nhiên và chuẩn xác';

  @override
  String get sessionComplete => 'Hoàn thành phiên học!';

  @override
  String get accuracy => 'Độ chính xác';

  @override
  String get reviewed => 'Đã ôn tập';

  @override
  String get correct => 'Đúng';

  @override
  String get backToLibrary => 'Quay lại thư viện';

  @override
  String get revealAnswer => 'Xem đáp án';

  @override
  String get aiHubTitle => 'Trung tâm AI';

  @override
  String get textChat => 'Nhắn tin';

  @override
  String get scholarlyPersonas => 'Học Giả Đàm Đạo';

  @override
  String get shadowing => 'Luyện Shadowing';

  @override
  String get liveTranslation => 'Dịch trực tiếp';

  @override
  String get scholarsLibrary => 'Thư viện Học Giả';

  @override
  String get generate => 'Tạo';

  @override
  String get searchPinyinHanziEnglish => 'Tìm kiếm Pinyin, Hanzi hoặc nghĩa...';

  @override
  String get liveTranslate => 'Dịch trực tiếp';

  @override
  String get travelInterpreter => 'Thông dịch viên du lịch';

  @override
  String get realTimeSplitScreen =>
      'Trò chuyện chia đôi màn hình theo thời gian thực với người bản xứ, xóa nhòa rào cản ngôn ngữ tức thì.';

  @override
  String get whisperEarpiece => 'Phụ đề giọng nói trực tiếp';

  @override
  String get listenToChineseAudio =>
      'Lắng nghe âm thanh tiếng Trung và nhận phụ đề tiếng Việt thời gian thực ngay trên màn hình.';

  @override
  String get dashboardTitle => 'Bảng điều khiển';

  @override
  String get yourMindIsClear => 'Tâm trí bạn rất sáng suốt và sẵn sàng!';

  @override
  String get noReviewsDueToday => 'Hôm nay không có thẻ nào cần ôn tập.';

  @override
  String get done => 'Xong';

  @override
  String get hskLevel1 => 'HSK Cấp 1';

  @override
  String get hskLevel2 => 'HSK Cấp 2';

  @override
  String get hskLevel3 => 'HSK Cấp 3';

  @override
  String get hskLevel4 => 'HSK Cấp 4';

  @override
  String get hskLevel5 => 'HSK Cấp 5';

  @override
  String get hskLevel6 => 'HSK Cấp 6';

  @override
  String get generalVocabulary => 'Từ vựng chung';

  @override
  String cardsRequireAttention(Object count) {
    return '$count thẻ cần ôn tập lại.';
  }

  @override
  String get begin => 'Bắt đầu';

  @override
  String get poweredByAi =>
      'Tích hợp công nghệ AI tiên tiến. Dịch thuật thời gian thực mượt mà cho mọi tình huống.';

  @override
  String get downloadingModel => 'Đang tải mô hình AI...';

  @override
  String get soon => 'SẮP RA MẮT';

  @override
  String get installed => 'ĐÃ CÀI ĐẶT';

  @override
  String get premium => 'PREMIUM';

  @override
  String get coreModule => 'MÔ-ĐUN CỐT LÕI';

  @override
  String get step6Context => 'BƯỚC 6: BỐI CẢNH & VÍ DỤ';

  @override
  String get tapBuildingBlocksTo =>
      'Chạm vào các thành phần để khám phá nguồn gốc của chữ Hán.';

  @override
  String get initiateRadicalSequence => 'BẮT ĐẦU CHUỖI BỘ THỦ';

  @override
  String get holdToTalk => 'Nhấn giữ để nói';

  @override
  String get customScenario => 'Tình huống tùy chỉnh';

  @override
  String get voiceCall => 'Gọi thoại';

  @override
  String get pronunciation => 'Phát âm';

  @override
  String get selectAScenarioTo =>
      'Chọn tình huống để luyện đàm thoại tiếng Trung. AI Học Giả sẽ đánh giá thanh điệu và độ rõ ràng của bạn.';

  @override
  String get create => 'Tạo';

  @override
  String get createYourScenario => 'Tạo tình huống của bạn';

  @override
  String get difficulty => 'Độ khó';

  @override
  String get scholarsVerdict => 'PHÁN QUYẾT CỦA HỌC GIẢ';

  @override
  String get completeReview => 'Hoàn tất đánh giá';

  @override
  String get conversationReview => 'XEM LẠI ĐỐI THOẠI';

  @override
  String get linguisticAnalysis => 'Phân tích ngôn ngữ';

  @override
  String get examplesInHsk1 => 'VÍ DỤ TRONG HSK 1';

  @override
  String get characterReference => 'Tra cứu chữ Hán';

  @override
  String get askTutor => 'Hỏi gia sư';

  @override
  String get addToStudyDeck => 'Thêm vào bộ thẻ học';

  @override
  String get startPractice => 'BẮT ĐẦU LUYỆN TẬP';

  @override
  String get noOtherHsk1 =>
      'Không có chữ HSK 1 nào khác dùng chung bộ thủ này.';

  @override
  String get couldNotLoadAi =>
      'Không thể tải nội dung AI (vượt giới hạn yêu cầu hoặc lỗi mạng).\nChạm nút làm mới bên dưới để thử lại.';

  @override
  String get noAvailableCardsFound => 'Không tìm thấy thẻ nào khả dụng.';

  @override
  String get addCards => 'Thêm thẻ';

  @override
  String get removeCard => 'Xóa thẻ';

  @override
  String get remove => 'Xóa';

  @override
  String get review => 'Ôn tập';

  @override
  String get story => 'Câu chuyện';

  @override
  String get thisDeckIsEmpty => 'Bộ thẻ này đang trống.';

  @override
  String get tapTheAddCards => 'Chạm vào nút \'Thêm thẻ\'!';

  @override
  String get noCardsFound => 'Không tìm thấy thẻ nào.';

  @override
  String get addCardsToSee => 'Thêm thẻ để xem thống kê học tập.';

  @override
  String get aiGenerated => 'Do AI tạo';

  @override
  String get allCardsCaughtUp => 'Đã ôn tập hết các thẻ! Bạn làm rất tốt.';

  @override
  String get latestDiscoveries => 'Khám phá gần đây';

  @override
  String get noCharactersInLexicon =>
      'Chưa có chữ Hán nào trong vốn từ vựng của bạn.';

  @override
  String get yourBookshelf => 'Giá sách của bạn';

  @override
  String get text_1782026184579 => 'Chữ';

  @override
  String get searchYourDictionary => 'Tìm kiếm trong từ điển cá nhân...';

  @override
  String get saveCard => 'Lưu thẻ';

  @override
  String get noCharactersFound => 'Không tìm thấy chữ Hán nào.';

  @override
  String get radicalsIndex => 'Mục lục bộ thủ';

  @override
  String get masteringRadicalsIsThe =>
      'Nắm vững bộ thủ là chìa khóa để giải mã hàng ngàn chữ Hán. Hãy chọn một bộ thủ để xem toàn bộ các chữ Hán liên quan.';

  @override
  String get noRadicalsFound => 'Không tìm thấy bộ thủ nào.';

  @override
  String get yourDrawing => 'Nét vẽ của bạn';

  @override
  String get reference => 'Mẫu chuẩn';

  @override
  String get rateYourRecall => 'Đánh giá mức độ ghi nhớ';

  @override
  String get contactUs => 'Liên hệ chúng tôi';

  @override
  String get reportBugsOrRequest => 'Báo lỗi hoặc yêu cầu tính năng';

  @override
  String get allDataHasBeen => 'Tất cả dữ liệu đã được xóa hoàn toàn.';

  @override
  String get hanziMasterV100 => 'SinoSpark v1.0.0';

  @override
  String get myProgress => 'Tiến độ của tôi';

  @override
  String get overview => 'Tổng quan';

  @override
  String get aiStory => 'Truyện đọc AI';

  @override
  String get usingYourDecksVocabulary => 'Sử dụng từ vựng trong bộ thẻ của bạn';

  @override
  String get tryAgain => 'Thử lại';

  @override
  String get translate => 'Dịch';

  @override
  String get pinyin => 'Pinyin';

  @override
  String get fullTranslation => 'Bản dịch đầy đủ';

  @override
  String get geminiFlashIsStructuring =>
      'Gemini Flash đang xây dựng câu chuyện của bạn...';

  @override
  String get aiDeckGenerator => 'Tạo bộ thẻ bằng AI';

  @override
  String get whatDoYouWant => 'Bạn muốn học chủ đề gì?';

  @override
  String get targetDifficulty => 'Độ khó mục tiêu';

  @override
  String get focusArea => 'Lĩnh vực trọng tâm';

  @override
  String get specificContextOrTone =>
      'Ngữ cảnh hoặc văn phong cụ thể (Tùy chọn)';

  @override
  String get numberOfCards => 'Số lượng thẻ';

  @override
  String get generateDeck => 'Tạo bộ thẻ';

  @override
  String get aiGrammarExplanation => 'Giải thích ngữ pháp bằng AI';

  @override
  String get scholarsDesk => 'Bàn Học Giả';

  @override
  String get chooseADeck => 'Chọn bộ thẻ';

  @override
  String get whereWouldYouLike => 'Bạn muốn lưu chữ Hán này vào đâu?';

  @override
  String get addToDefaultStudy => 'Thêm vào bộ học mặc định';

  @override
  String get ifOffItsOnly => 'Nếu tắt, chữ chỉ được lưu vào từ điển chung';

  @override
  String get saveToLibrary => 'Lưu vào thư viện';

  @override
  String get pleaseEnterValidChinese => 'Vui lòng nhập chữ Hán hợp lệ';

  @override
  String get reviewAiCard => 'Kiểm tra thẻ AI';

  @override
  String get pleaseDoublecheckTheAis =>
      'Vui lòng kiểm tra lại kết quả AI bên dưới. Bạn có thể thoải mái sửa pinyin hoặc nghĩa trước khi lưu vào thư viện vĩnh viễn.';

  @override
  String get alreadyInYourLibrary => 'Đã có trong thư viện của bạn!';

  @override
  String get meaningInContext => 'Nghĩa trong ngữ cảnh';

  @override
  String get explainGrammar => 'Giải thích ngữ pháp';

  @override
  String get addToLibrary => 'Thêm vào thư viện';

  @override
  String get masterYourMandarinPronunciation =>
      'Làm chủ phát âm tiếng Trung chuẩn xác bằng cách nhại giọng bản xứ theo thời gian thực.';

  @override
  String get startSession => 'BẮT ĐẦU PHIÊN HỌC';

  @override
  String get sessionHistory => 'Lịch sử học tập';

  @override
  String get noSavedSessions => 'Chưa có phiên học nào được lưu.';

  @override
  String get aiBreakdown => 'Phân tích chi tiết của AI';

  @override
  String get sessionDetails => 'Chi tiết phiên học';

  @override
  String partner(Object lang) {
    return 'Bạn đối thoại ($lang)';
  }

  @override
  String get youEnglish => 'Bạn (Tiếng Việt)';

  @override
  String get noTranscriptToSave => 'Không có nội dung đối thoại để lưu!';

  @override
  String get sessionSaved => 'Đã lưu phiên học!';

  @override
  String get realtimeBidirectionalTranslationSpeak =>
      'Dịch hai chiều thời gian thực. Nói tiếng Việt hoặc tiếng Trung, hệ thống sẽ dịch tức thì cho bạn và người đối thoại.';

  @override
  String get text_1782026184665 => 'Đang ghi âm';

  @override
  String get recording => 'Đang ghi âm';

  @override
  String get yourSilentCompanionListen =>
      'Trợ thủ đắc lực của bạn. Lắng nghe tiếng Trung và nhận ngay bản dịch tiếng Việt tức thì.';

  @override
  String get startListening => 'BẮT ĐẦU LẮNG NGHE';

  @override
  String get skip => 'Bỏ qua';

  @override
  String get independentStars => 'CHỮ ĐỘC THỂ';

  @override
  String get notEveryCharacterHas =>
      'Không phải chữ Hán nào cũng ghép từ bộ thủ. Một số chữ là chữ tượng hình độc lập (độc thể tự).';

  @override
  String get onTheMapWe =>
      'Trên bản đồ, chúng tôi nhóm các chữ độc thể này thành các CHÒM SAO (✨).';

  @override
  String get iUnderstand => 'ĐÃ HIỂU';

  @override
  String get whatAreRadicals => 'BỘ THỦ LÀ GÌ?';

  @override
  String get hanziAreBuiltFrom =>
      'Chữ Hán được cấu tạo từ các thành phần cơ bản gọi là BỘ THỦ.\n\nBộ thủ quyết định ý nghĩa cốt lõi hoặc chủ đề của chữ.';

  @override
  String get continueText => 'TIẾP TỤC';

  @override
  String get hanziAreNotJust =>
      'Chữ Hán không chỉ là ký tự. Chúng là những bức tranh sống động đọng lại qua thời gian.\n\nĐể làm chủ chữ Hán, bạn cần cảm nhận dòng chảy của từng nét bút.';

  @override
  String get iAmReady => 'TÔI ĐÃ SẴN SÀNG';

  @override
  String get youAreAScholar => 'BẠN LÀ MỘT HỌC GIẢ';

  @override
  String get theGalaxyMapAwaitsnmaster =>
      'Bản đồ Thiên Hà đang chờ đón bạn.\nLàm chủ các Mặt Trời (Bộ thủ) để mở khóa các Hành Tinh (Chữ Hán).';

  @override
  String get enterTheScroll => 'MỞ CUỘN GIẤY';

  @override
  String get openingTheOriginScroll => 'Đang mở Cuộn Giấy Khởi Nguyên...';

  @override
  String get text_1782026184670 => '+';

  @override
  String get theScholarsEdition => 'Phiên Bản Học Giả';

  @override
  String get weArePreparingThe =>
      'Chúng tôi đang chuẩn bị ra mắt Phiên Bản Học Giả.';

  @override
  String get devBypassUnlockNow => 'DEV BYPASS: MỞ KHÓA NGAY';

  @override
  String get restorePurchases => 'Khôi phục gói mua';

  @override
  String get welcomeScholarTheScroll =>
      'Chào mừng Học giả. Cuộn giấy cổ đã mở rộng trước mắt bạn.';

  @override
  String get purchasesRestoredSuccessfully =>
      'Đã khôi phục giao dịch mua thành công.';

  @override
  String get noPreviousPurchasesFound =>
      'Không tìm thấy lịch sử mua hàng cho tài khoản này.';

  @override
  String get unlockTheFullPotential =>
      'Mở khóa toàn bộ tiềm năng học tập của bạn. Mua một lần, sở hữu trọn đời.';

  @override
  String get universalScanner => 'Máy quét vạn năng';

  @override
  String get noChineseCharactersFound =>
      'Không tìm thấy chữ Hán nào trong hình ảnh.';

  @override
  String get addedNewCharactersTo =>
      'Đã thêm chữ Hán mới vào thư viện của bạn!';

  @override
  String get extractingTextAndObjects =>
      'Đang trích xuất văn bản và vật thể...';

  @override
  String get scanATextbookSign =>
      'Quét trang sách, biển hiệu hoặc đồ vật để trích xuất chữ Hán.';

  @override
  String get extractedText => 'Văn bản đã trích xuất';

  @override
  String get useText => 'Sử dụng văn bản này';

  @override
  String get noMatchingDictionaryEntries =>
      'Không tìm thấy mục từ điển phù hợp.';

  @override
  String get quizComplete => 'Hoàn thành bài quiz!';

  @override
  String get returnToCourse => 'Quay lại khóa học';

  @override
  String get notEnoughCardsFor =>
      'Không đủ thẻ để làm bài kiểm tra! Cần tối thiểu 4 thẻ.';

  @override
  String get creatorMode => 'Chế độ Sáng tạo';

  @override
  String get noStoriesFoundMatching =>
      'Không tìm thấy câu chuyện nào phù hợp với tìm kiếm.';

  @override
  String get discard => 'Hủy bỏ';

  @override
  String get save => 'Lưu';

  @override
  String get generatingStoryViaDeepseek =>
      'Đang tạo câu chuyện qua DeepSeek...';

  @override
  String get storySavedToLibrary => 'Đã lưu câu chuyện vào thư viện!';

  @override
  String get storyNotFound => 'Không tìm thấy câu chuyện.';

  @override
  String get targetHskLevel => 'Cấp độ HSK mục tiêu';

  @override
  String get wedLoveToHear => 'Chúng tôi rất mong nhận được phản hồi từ bạn!';

  @override
  String get whetherYouveFoundA =>
      'Dù bạn phát hiện lỗi, muốn đề xuất tính năng mới hay chỉ là gửi lời chào, phản hồi của bạn đều giúp SinoSpark hoàn thiện hơn mỗi ngày.';

  @override
  String get pointYourCameraAt => 'Hướng camera vào đồ vật';

  @override
  String get reviewAddToLibrary => 'Xem lại và thêm vào thư viện';

  @override
  String hideStrokeGuideStreak(Object streak) {
    return 'Ẩn nét hướng dẫn khi đạt chuỗi đúng $streak lần';
  }

  @override
  String inkPoints(Object points) {
    return '$points Điểm Mực';
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
  String get supportAndFeedback => 'Hỗ trợ & Góp ý';

  @override
  String get reportBug => 'Báo lỗi';

  @override
  String get suggestFeature => 'Gợi ý tính năng';

  @override
  String get generalFeedback => 'Góp ý chung';

  @override
  String get pleaseDrawSomethingFirst => 'Vui lòng viết chữ lên bảng trước';

  @override
  String get drawThisCharacter => 'Viết chữ Hán này:';

  @override
  String followGuideStroke(Object current, Object total) {
    return 'Làm theo nét hướng dẫn màu xanh để viết nét $current trong tổng số $total nét';
  }

  @override
  String get skipCurrentStroke => 'Bỏ qua nét hiện tại';

  @override
  String get submitDrawing => 'Gửi chấm điểm';

  @override
  String addedToDeck(Object deckName, Object hanzi) {
    return 'Đã thêm «$hanzi» vào bộ «$deckName»';
  }

  @override
  String removedFromDeck(Object hanzi) {
    return 'Đã xóa «$hanzi» khỏi bộ thẻ';
  }

  @override
  String skippedNoStrokeData(Object hanzi) {
    return 'Đã bỏ qua «$hanzi» — Chưa có dữ liệu nét viết cho chữ này.';
  }

  @override
  String get startingSession => 'Đang khởi động phiên học...';

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
  String get newLabel => 'Mới';

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
  String get masterBuildingBlocks => 'Làm chủ các bộ thủ nền tảng của chữ Hán';

  @override
  String get totalWords => 'Tổng số từ';

  @override
  String get newInk => 'Mực mới tích lũy';

  @override
  String get learningStatus => 'Đang học';

  @override
  String get masteredStatus => 'Đã thành thạo';

  @override
  String get libraryMastery => 'Độ thành thạo thư viện';

  @override
  String get accuracyByMode => 'Độ chính xác theo chế độ';

  @override
  String get upcomingReviews => 'Ôn tập sắp tới (7 ngày tới)';

  @override
  String get culturalReadingRoom => 'Văn Hóa Thư Phòng (文化书房)';

  @override
  String storyTitleHsk(Object level, Object title) {
    return '$title (HSK $level)';
  }

  @override
  String get pleaseEnterTopic => 'Vui lòng nhập chủ đề';

  @override
  String createdDeckCards(Object count, Object name) {
    return 'Đã tạo bộ «$name» với $count thẻ!';
  }

  @override
  String gradeResult(Object grade) {
    return 'Đánh giá: $grade';
  }

  @override
  String get listeningMode => 'Chế độ Nghe';

  @override
  String get readingMode => 'Chế độ Đọc';

  @override
  String get recallMode => 'Chế độ Hồi tưởng';

  @override
  String get speakingMode => 'Chế độ Nói';

  @override
  String get aiMemoryHook => 'Mẹo nhớ bằng AI';

  @override
  String get exampleSentences => 'Câu ví dụ';

  @override
  String get ghostCharacters => 'Chữ mẫu mờ';

  @override
  String get commonWords => 'Từ ghép thông dụng';

  @override
  String get personalNotes => 'Ghi chú cá nhân';

  @override
  String get addPersonalNotes =>
      'Thêm mẹo nhớ hoặc ghi chú riêng của bạn tại đây...';

  @override
  String get takePhoto => 'Chụp ảnh';

  @override
  String get gallery => 'Chọn từ thư viện ảnh';

  @override
  String get arLens => 'Ống kính AR';

  @override
  String addedCharToLibrary(Object char) {
    return 'Đã thêm «$char» vào thư viện';
  }

  @override
  String get scoreText => 'Điểm';

  @override
  String get searchDictionaryHint => 'Tìm theo chữ Hán, pinyin hoặc nghĩa...';

  @override
  String get searchDeckHint => 'Tìm trong bộ thẻ theo chữ Hán, pinyin...';

  @override
  String get localRestaurant => 'Quán ăn địa phương';

  @override
  String get taxiToAirport => 'Bắt taxi ra sân bay';

  @override
  String get silkMarketHaggling => 'Mặc cả ở chợ lụa';

  @override
  String get medicalClinic => 'Phòng khám y tế / Khám bệnh';

  @override
  String get meetingAFriend => 'Gặp gỡ bạn bè';

  @override
  String get jobInterview => 'Phỏng vấn xin việc';

  @override
  String get searchRadicalsHint => 'Tìm bộ thủ (ví dụ: Thủy, 水, 氵)';

  @override
  String get definition => 'Định nghĩa & Ý nghĩa';

  @override
  String get undo => 'HOÀN TÁC';

  @override
  String get hanziMaster => 'SinoSpark';

  @override
  String get unlockForever => 'Mở khóa trọn đời - \$9.99';

  @override
  String get clear => 'Xóa';

  @override
  String get clearChat => 'Xóa đoạn chat';

  @override
  String get typeMessage => 'Nhập tin nhắn...';

  @override
  String addedToLibrary(Object hanzi) {
    return 'Đã thêm «$hanzi» vào thư viện của bạn';
  }

  @override
  String get generateNewStory => 'Tạo câu chuyện mới';

  @override
  String failedToGenerateStory(Object error) {
    return 'Không thể tạo câu chuyện:\n$error';
  }

  @override
  String get detail => 'Chi tiết';

  @override
  String get scanText => 'Quét văn bản';

  @override
  String get createMagic => 'Tạo bằng AI';

  @override
  String get learning => 'Đang học';

  @override
  String get upcomingReviews7Days => 'Ôn tập sắp tới (7 ngày tới)';

  @override
  String get askFollowUpQuestion => 'Hỏi thêm câu hỏi...';

  @override
  String get pasteScanToSimplify =>
      'Dán hoặc quét văn bản tiếng Trung để chuyển thành văn bản dễ hiểu';

  @override
  String get searchStoriesHint =>
      'Tìm kiếm truyện theo tiêu đề hoặc thẻ (ví dụ: thần thoại, du lịch)';

  @override
  String get importAll => 'Nhập tất cả';

  @override
  String get ascendAll => 'Thăng cấp tất cả';

  @override
  String get startAscension => 'Bắt đầu thăng tiến';

  @override
  String get scenarioLocalRestaurant => 'Quán ăn địa phương';

  @override
  String get scenarioLocalRestaurantDesc =>
      'Luyện gọi món và hỏi xin gợi ý món ngon từ quán.';

  @override
  String get scenarioTaxiAirport => 'Bắt taxi ra sân bay';

  @override
  String get scenarioTaxiAirportDesc =>
      'Nói điểm đến cho tài xế và trò chuyện về tình hình giao thông.';

  @override
  String get scenarioSilkMarket => 'Mặc cả ở chợ lụa';

  @override
  String get scenarioSilkMarketDesc =>
      'Thương lượng để có giá tốt nhất khi mua quà lưu niệm.';

  @override
  String get scenarioMedicalClinic => 'Phòng khám y tế';

  @override
  String get scenarioMedicalClinicDesc =>
      'Mô tả triệu chứng sức khỏe với bác sĩ đông y/tây y.';

  @override
  String get scenarioMeetingFriend => 'Gặp gỡ bạn cũ';

  @override
  String get scenarioMeetingFriendDesc =>
      'Chào hỏi, hỏi thăm sức khỏe và trò chuyện thân mật.';

  @override
  String get scenarioJobInterview => 'Phỏng vấn xin việc';

  @override
  String get scenarioJobInterviewDesc =>
      'Ứng tuyển vào một vị trí tại công ty công nghệ ở Thượng Hải.';

  @override
  String get createCustomScenario => 'Tạo tình huống tùy chỉnh';

  @override
  String get customScenarioTitleHint => 'Tiêu đề (ví dụ: Tiệc cưới)';

  @override
  String get customScenarioDescHint => 'Mô tả ngữ cảnh tình huống';

  @override
  String get customScenarioPersonaHint =>
      'Vai diễn AI (ví dụ: Đồng nghiệp tò mò)';

  @override
  String get customScenarioDifficulty => 'Độ khó';

  @override
  String get createAction => 'Tạo';

  @override
  String get cancelAction => 'Hủy';

  @override
  String get mythsAndLegends => 'Thần thoại & Truyền thuyết';

  @override
  String get historyAndCulture => 'Lịch sử & Văn hóa';

  @override
  String get idiomsTitle => 'Thành ngữ (成语)';

  @override
  String get theMonkeyKing => 'Tôn Ngộ Không';

  @override
  String get theMonkeyKingDesc => 'Tôn Ngộ Không (Tây Du Ký)';

  @override
  String get huaMulan => 'Hoa Mộc Lan';

  @override
  String get huaMulanDesc => 'Hoa Mộc Lan thay cha tòng quân';

  @override
  String get confuciusTitle => 'Khổng Tử';

  @override
  String get confuciusDesc => 'Cuộc đời và tư tưởng giáo dục của Khổng Tử';

  @override
  String get theGreatWall => 'Vạn Lý Trường Thành';

  @override
  String get theGreatWallDesc => 'Lịch sử xây dựng Vạn Lý Trường Thành';

  @override
  String get generateTopic => 'Tạo chủ đề';

  @override
  String get simplifyText => 'Chuyển thành văn bản dễ hiểu';

  @override
  String get topicHint => 'Chủ đề (ví dụ: Người ngoài hành tinh ở Bắc Kinh)';

  @override
  String get tagsHint => 'Thẻ (cách nhau bằng dấu phẩy, tùy chọn)';

  @override
  String get speakWithMasterLin => 'Trò chuyện với Thầy Lâm';

  @override
  String get masterLinGreeting =>
      'Chào mừng con. Nghiên mực đã sẵn sàng, hôm nay chúng ta cùng đàm đạo về chữ Hán hay câu văn nào?';

  @override
  String get typeYourMessage => 'Nhập tin nhắn của bạn...';

  @override
  String get theMainLibrary => 'Thư viện chính';

  @override
  String get hsk1Foundation => 'HSK 1: Căn bản';

  @override
  String get hsk2Elementary => 'HSK 2: Sơ cấp';

  @override
  String get hsk3Intermediate => 'HSK 3: Trung cấp';

  @override
  String get inDeckCheck => 'Đã có trong bộ thẻ ✓';

  @override
  String get addToDeckPlus => '+ Thêm vào bộ thẻ';

  @override
  String get openCardArrow => 'Mở thẻ →';

  @override
  String get pronunciationPartial => 'Thanh điệu chưa chuẩn';

  @override
  String get pronunciationWrong => 'Phát âm chưa đúng';

  @override
  String get toneExpected => 'Thanh điệu chuẩn';

  @override
  String get toneYouSaid => 'Bạn đã phát âm';

  @override
  String get gotIt => 'Đã hiểu!';

  @override
  String foundNCharacters(int count) {
    return 'Tìm thấy $count chữ Hán';
  }

  @override
  String get lookingUpCharacters => 'Đang tra cứu chữ Hán…';

  @override
  String get practiceAll => 'Luyện tập tất cả';

  @override
  String get arLensObjects => 'Đồ vật';

  @override
  String get arLensText => 'Văn bản';

  @override
  String get arLensDetectedText => 'Văn bản nhận diện được';

  @override
  String get duration12Min => '1–2 phút';

  @override
  String get aClassicTangDynastyPoem => 'Một bài thơ Đường kinh điển';

  @override
  String get aClassicTangDynastyPoemBy => 'Một bài thơ Đường kinh điển của';

  @override
  String get aStructuralComponent => 'Một thành phần cấu tạo chữ Hán.';

  @override
  String get addSelectedToDeck => 'Thêm mục đã chọn vào bộ thẻ';

  @override
  String addTo(Object target) {
    return 'Thêm vào ';
  }

  @override
  String addedHanziToYourLibrary(String hanzi) {
    return 'Đã thêm «$hanzi» vào thư viện của bạn';
  }

  @override
  String get adjustFontSize => 'Điều chỉnh cỡ chữ';

  @override
  String get againGoodEasyHard => '⬅️ Học lại    ➡️ Tốt    ⬆️ Dễ    ⬇️ Khó';

  @override
  String get aiAnalysisFailed => 'Phân tích AI thất bại';

  @override
  String get aiIsThinking => 'AI đang suy nghĩ...';

  @override
  String get aiSceneAnalysisFailed => 'Phân tích bối cảnh bằng AI thất bại';

  @override
  String get allLabel => 'Tất cả';

  @override
  String get allPinyin => 'Tất cả Pinyin';

  @override
  String get alreadyHaveAccountSignIn => 'Đã có tài khoản? Đăng nhập';

  @override
  String get analysisFailed => 'Phân tích thất bại: ';

  @override
  String get analyzingClassicalCharacters =>
      'Đang phân tích chữ Hán cổ điển...';

  @override
  String get anatomy => 'Cấu tạo chữ Hán';

  @override
  String get ancientPhilosophy => 'Triết học cổ đại';

  @override
  String get articleSavedToMediaHub => 'Đã lưu bài viết vào Media Hub!';

  @override
  String get askAFollowUp => 'Đặt câu hỏi tiếp theo...';

  @override
  String get audioPrivacyAndHowThingsWork =>
      'Âm thanh, quyền riêng tư và cơ chế hoạt động';

  @override
  String get audiobookPlayer => 'Trình phát sách nói';

  @override
  String get audiobookVoice => 'Giọng đọc sách nói';

  @override
  String get auntieMaTown =>
      'Dì Mã (马阿姨): chủ quầy hàng xởi lởi, người làm món bánh kẹp thịt Roujiamo và mì lạnh Liangpi giòn ngon nhất thị trấn.';

  @override
  String get back => 'Quay lại';

  @override
  String get baristaKevinNotes =>
      'Barista Kevin (小凯): thợ rang cà phê trẻ đầy nhiệt huyết, say mê chia sẻ về hạt cà phê Vân Nam và hương vị đặc trưng.';

  @override
  String get bbc => 'BBC Trung văn (BBC 中文)';

  @override
  String get beginYourJourney => 'Bắt đầu hành trình';

  @override
  String get bestValue => 'Lựa chọn tốt nhất';

  @override
  String get bookLinkCopiedToClipboard =>
      'Đã sao chép liên kết sách vào bộ nhớ tạm!';

  @override
  String get bookmarkChapter => 'Đánh dấu chương này';

  @override
  String get bookmarks => 'Dấu trang';

  @override
  String get books => 'Sách';

  @override
  String get briefing => 'Tóm tắt';

  @override
  String get bugReport => 'Báo lỗi';

  @override
  String get caoXueqinDecline =>
      'Tào Tuyết Cần (khoảng 1715–1763) là tiểu thuyết gia thời nhà Thanh, xuất thân trong một gia tộc quý tộc suy tàn dưới triều Ung Chính. \'Hồng Lâu Mộng\', được viết trong những năm cuối đời cơ cực, được coi là đỉnh cao của tiểu thuyết cổ điển Trung Quốc — một bức tranh toàn cảnh sâu sắc về sự suy vong của tầng lớp quý tộc.';

  @override
  String get cardsTitle => 'THẺ HỌC';

  @override
  String get cc => 'Phụ đề (CC)';

  @override
  String get characterOrWord => 'Chữ Hán / Từ vựng';

  @override
  String get chatMore => 'Trò chuyện tiếp';

  @override
  String get chefChenShumai =>
      'Đầu bếp Trần (陈师傅): nghệ nhân dim sum Quảng Đông vui vẻ, chuyên gợi ý món há cảo tôm tươi Har Gow và xíu mại thơm ngon.';

  @override
  String get chineseEpics => 'Sử thi Trung Quốc';

  @override
  String get chinesePoetry => 'Thơ ca Trung Quốc';

  @override
  String get chng => 'chéng';

  @override
  String get chongqingSpicyHotpotFeast => 'Đại tiệc lẩu cay Trùng Khánh';

  @override
  String get chooseAudiobookVoice => 'Chọn giọng đọc sách nói';

  @override
  String get chooseVoice => 'Chọn giọng đọc';

  @override
  String get compare => 'So sánh';

  @override
  String get compare4Tones => 'So sánh 4 thanh điệu';

  @override
  String get configuration => 'Cấu hình';

  @override
  String get contemporary => 'Đương đại';

  @override
  String get context => 'Bối cảnh';

  @override
  String get couldNotLoadLibrary => 'Không thể tải thư viện';

  @override
  String get couldNotLoadVocabulary => 'Không thể tải từ vựng.';

  @override
  String get couldNotOpenEmailApp => 'Không thể mở ứng dụng email.';

  @override
  String get createAccount => 'Tạo tài khoản';

  @override
  String get createNewDeck => 'Tạo bộ thẻ mới';

  @override
  String get createScenario => 'Tạo tình huống';

  @override
  String get createStory => 'Tạo câu chuyện';

  @override
  String get customLabel => 'Tùy chỉnh';

  @override
  String get customWord => 'Từ tùy chỉnh';

  @override
  String get days => 'ngày';

  @override
  String get deck => 'Bộ thẻ';

  @override
  String get deckName => 'Tên bộ thẻ';

  @override
  String get deckStory => 'Câu chuyện bộ thẻ';

  @override
  String get deepAnalysis => 'Phân tích sâu';

  @override
  String get defaultDeck => 'Bộ thẻ mặc định';

  @override
  String get deleteLabel => 'Xóa';

  @override
  String get deleteScenario => 'Xóa tình huống';

  @override
  String get deletesAllProgressPermanently =>
      'Xóa vĩnh viễn toàn bộ tiến trình học';

  @override
  String get developerBackdoorUnlocked => 'Đã mở khóa menu nhà phát triển!';

  @override
  String get doesNotExistInChinese => 'Không tồn tại trong tiếng Trung';

  @override
  String get dontHaveAccountSignUp => 'Chưa có tài khoản? Đăng ký ngay';

  @override
  String get draftingStoryOutline => 'Đang phác thảo cốt truyện...';

  @override
  String get dynamicFlowState => 'Trạng thái dòng chảy động';

  @override
  String get dynamicFlowStateParenthetical => 'Động (Trạng thái dòng chảy)';

  @override
  String get editCard => 'Chỉnh sửa thẻ';

  @override
  String get egAnimeVocab => 'Ví dụ: Từ vựng anime';

  @override
  String get egFormalBusinessLanguageSlangForTexting =>
      'Ví dụ: tiếng Trung thương mại trang trọng, tiếng lóng mạng xã hội...';

  @override
  String get egOrderingAtARestaurantBusinessVocab =>
      'Ví dụ: Gọi món nhà hàng, từ vựng kinh doanh...';

  @override
  String get egWeddingReceptionTechInterview =>
      'Ví dụ: Tiệc cưới, phỏng vấn kỹ thuật...';

  @override
  String get emailLabel => 'Email';

  @override
  String get english => 'Tiếng Anh';

  @override
  String get englishAndWorld => 'Tiếng Anh & Văn học thế giới';

  @override
  String get episodes => 'tập';

  @override
  String get erase => 'Xóa sạch';

  @override
  String get eraseDeckQuestion => 'Xóa sạch bộ thẻ?';

  @override
  String errorFetchingTranslationForLabelE(String label, String e) {
    return 'Lỗi khi lấy bản dịch cho $label: $e';
  }

  @override
  String errorLoadingMicroreadsE(String e) {
    return 'Lỗi khi tải bài đọc ngắn: $e';
  }

  @override
  String errorLoadingNovelsE(String e) {
    return 'Lỗi khi tải tiểu thuyết: $e';
  }

  @override
  String errorLoadingPoetryE(String e) {
    return 'Lỗi khi tải thơ ca: $e';
  }

  @override
  String get exitFocus => 'Thoát chế độ tập trung';

  @override
  String get explore => 'Khám phá';

  @override
  String get exportToThisDeck => 'Xuất sang bộ thẻ này';

  @override
  String get extractAndSimplify => 'Trích xuất & chuyển thành văn bản dễ hiểu';

  @override
  String get failedToCreateDeck => 'Không thể tạo bộ thẻ';

  @override
  String get failedToLoadDailyContent => 'Không thể tải nội dung hằng ngày';

  @override
  String get failedToLoadEpisodes => 'Không thể tải các tập phim';

  @override
  String get failedToLoadShows => 'Không thể tải chương trình';

  @override
  String get finalizingDetails => 'Đang hoàn tất chi tiết...';

  @override
  String get finalizingStoryDetails => 'Đang hoàn thiện chi tiết câu chuyện...';

  @override
  String get firebaseAuthConsole =>
      'Chưa bật xác thực Firebase. Vui lòng bật phương thức đăng nhập cần thiết trong Firebase Console.';

  @override
  String get flashcardDeckTitle => 'BỘ THẺ FLASHCARD';

  @override
  String get focus => 'Tập trung';

  @override
  String get foodAndCooking => 'Ẩm thực & Nấu ăn';

  @override
  String get forward => 'Tiến tới';

  @override
  String get freeFlow => 'Đối thoại tự do';

  @override
  String get frenchClassics => 'Tác phẩm kinh điển Pháp';

  @override
  String get full => 'Đầy đủ';

  @override
  String get gamingAndEsports => 'Game & Thể thao điện tử';

  @override
  String get germanClassics => 'Tác phẩm kinh điển Đức';

  @override
  String get ghostPinyin => 'Pinyin mẫu mờ';

  @override
  String get goodAttempt => 'Cố gắng lắm!';

  @override
  String get gotItSimple => 'Đã hiểu';

  @override
  String get grammar => 'Ngữ pháp';

  @override
  String get grandmaLiuFilling =>
      'Bà Lưu (刘奶奶): người bà phương Bắc hiền hậu chỉ bạn cách gấp nếp sủi cảo và làm nhân thịt heo hành lá thơm ngon.';

  @override
  String get great => 'Tuyệt vời!';

  @override
  String get handmadeDumplingFeastInHarbin =>
      'Bữa tiệc sủi cảo tự làm ở Cáp Nhĩ Tân';

  @override
  String get hanziCharacter => 'Chữ Hán (Hanzi)';

  @override
  String get hapticFeedback => 'Rung phản hồi xúc giác';

  @override
  String get helpAndSupport => 'Trợ giúp & Hỗ trợ';

  @override
  String get hidden => 'Đã ẩn';

  @override
  String get hideEnglishTranslations => 'Ẩn bản dịch tiếng Anh';

  @override
  String get hidePinyin => 'Ẩn Pinyin';

  @override
  String get highlight => 'NỔI BẬT';

  @override
  String get howWouldYouLikeToStudy => 'Bạn muốn học theo hình thức nào?';

  @override
  String get hsk1 => 'HSK 1';

  @override
  String get hsk4UpperIntermediate => 'HSK 4: Trung cấp cao';

  @override
  String get hsk5Advanced => 'HSK 5: Cao cấp';

  @override
  String get hsk6Mastery => 'HSK 6: Thành thạo';

  @override
  String get hskCollections => 'Bộ sưu tập HSK';

  @override
  String hskLevel(String level) {
    return 'HSK cấp $level';
  }

  @override
  String get hskSimplifySubtitles => 'Đơn giản hóa phụ đề theo HSK';

  @override
  String get hskVocabularyCollections => 'Bộ sưu tập từ vựng HSK';

  @override
  String get i => 'Tôi';

  @override
  String get ifTheAgain =>
      'Nếu AI phát hiện sự không khớp, hệ thống sẽ hỏi \'Ý bạn có phải là...?\'. Bạn có thể nhấn \'Có, hãy chấm lại!\' để đánh giá lại tệp ghi âm ban đầu theo đúng ý định mà không cần nói lại.';

  @override
  String get install => 'Cài đặt';

  @override
  String get just => 'Chỉ \$';

  @override
  String get keyword => 'từ khóa';

  @override
  String get knowledgeBase => 'Kho tri thức';

  @override
  String get liRuzhenSubjects =>
      'Lý Nhữ Trân (khoảng 1763–1830) là học giả thời nhà Thanh am hiểu ngữ âm học, cờ vây và vũ trụ học. \'Kính Hoa Duyên\', cuốn tiểu thuyết kỳ ảo về hành trình qua những xứ sở kỳ lạ, nổi bật với tư tưởng nữ quyền tiến bộ và kiến thức bách khoa phong phú.';

  @override
  String get library => 'Thư viện Văn Hóa Thư Phòng';

  @override
  String get lifestyleAndVlog => 'Phong cách sống & Vlog';

  @override
  String get listenInAudiobookMode => 'Nghe ở chế độ sách nói';

  @override
  String get listenToThisWord => 'Nghe phát âm từ này';

  @override
  String get listening => 'Đang lắng nghe...';

  @override
  String get liuEEncroachment =>
      'Lưu Ngạc (1857–1909) là học giả cuối thời Thanh (kỹ sư, thầy thuốc, tiểu thuyết gia). Tiểu thuyết \'Lão Tàn du ký\' là tập du ký trữ tình mang đậm tính phê phán xã hội của một danh y phiêu bạt giữa thời kỳ suy tàn và ngoại xâm.';

  @override
  String get loadingTranslations => 'Đang tải bản dịch...';

  @override
  String get luXunVernacular =>
      'Lỗ Tấn (1881–1936), tên thật là Chu Thụ Nhân, là cha đẻ của văn học Trung Quốc hiện đại. Từ bỏ ngành y để cầm bút thức tỉnh tinh thần dân tộc, các tập truyện như \'Nhật ký người điên\' và \'AQ chính truyện\' đã tiên phong dùng văn bạch thoại.';

  @override
  String get luoGuanzhongEpic =>
      'La Quán Trung (khoảng 1330–1400) là nhà soạn kịch và tiểu thuyết gia thời Nguyên-Minh, tương truyền từng học Thi Nại Am. \'Tam Quốc Diễn Nghĩa\' của ông đã đúc kết sử liệu, truyện kể dân gian và kịch nghệ thành pho sử thi kinh điển của Trung Hoa.';

  @override
  String get makeACustomCollection => 'Tạo bộ sưu tập tùy chỉnh';

  @override
  String get manageDailyDropsAndReviewReminders =>
      'Quản lý bài học hằng ngày và nhắc nhở ôn tập';

  @override
  String get managerYuOptions =>
      'Quản lý Dư (余店长): nữ quản lý nhà hàng lẩu nhiệt tình, chuyên gợi ý lá sách bò, tiết vịt và các loại nước lẩu thanh ngọt.';

  @override
  String get masterGaoRubs =>
      'Sư phụ Cao (高师傅): bậc thầy nướng than hoa vui tính, thường trò chuyện với khách về độ cay và công thức ướp thì là bí truyền.';

  @override
  String get masterThisToUnlockItsGalaxy =>
      'Thành thạo chữ này để mở khóa thiên hà tương ứng.';

  @override
  String get masterZhaoBrewing =>
      'Sư phụ Triệu (赵师傅): chuyên gia trà đạo kiên nhẫn, say mê hướng dẫn nghệ thuật pha trà Công phu (Gongfu).';

  @override
  String get mastery => 'Độ thành thạo';

  @override
  String get maybeLater => 'Để sau';

  @override
  String get memes => 'Meme & Xu hướng';

  @override
  String get midnightBbqSkewersInWuhan => 'Xiên nướng than đêm khuya ở Vũ Hán';

  @override
  String get mo => '/tháng';

  @override
  String get modernChinese => 'Tiếng Trung hiện đại';

  @override
  String get monthly => 'Hằng tháng';

  @override
  String get morningDimSumCartInGuangzhou =>
      'Xe đẩy dim sum buổi sáng ở Quảng Châu';

  @override
  String get nameLabel => 'Tên';

  @override
  String get native => 'Bản ngữ';

  @override
  String get newCard => 'Thẻ mới';

  @override
  String get newDeck => 'Bộ thẻ mới';

  @override
  String get newDeckName => 'Tên bộ thẻ mới';

  @override
  String get noActiveSubscriptionFound =>
      'Không tìm thấy gói đăng ký nào đang hoạt động.';

  @override
  String get noEpisodesFound => 'Không tìm thấy tập phim nào';

  @override
  String get noKeyWordsFoundForThisStory =>
      'Chưa có từ khóa nào cho câu chuyện này.';

  @override
  String get noLabel => 'Không';

  @override
  String get noNewWordsFound => 'Không có từ mới nào!';

  @override
  String get noPinyin => 'Không có Pinyin';

  @override
  String get noPremiumPackagesAvailable => 'Hiện chưa có gói Premium khả dụng.';

  @override
  String noResultsFoundForSearchquery(String searchQuery) {
    return 'Không tìm thấy kết quả nào cho «$searchQuery»';
  }

  @override
  String get noSavedArticlesYet => 'Chưa có bài viết nào được lưu.';

  @override
  String get noShowsAvailable => 'Không có chương trình nào';

  @override
  String get noStoriesFound => 'Không tìm thấy câu chuyện nào.';

  @override
  String get noWordsSelected => 'Chưa chọn từ nào';

  @override
  String get notes => 'Ghi chú';

  @override
  String get notoserifsc => 'NotoSerifSC';

  @override
  String get objectivesTitle => 'MỤC TIÊU HỌC TẬP';

  @override
  String get openInYoutube => 'Mở trên YouTube';

  @override
  String get orderingHanddripCoffeeInShanghai =>
      'Gọi cà phê pha thủ công (pour-over) ở Thượng Hải';

  @override
  String get orderingSugarcoatedHawsInWinterBeijing =>
      'Mua kẹo hồ lô rim đường giữa mùa đông Bắc Kinh';

  @override
  String partnerLang(String lang) {
    return 'Bạn đối thoại ($lang)';
  }

  @override
  String get partnerListening => 'Đối tác đang nghe...';

  @override
  String get partnerSpeaking => 'Đối tác đang nói...';

  @override
  String get passwordLabel => 'Mật khẩu';

  @override
  String get pause => 'Tạm dừng';

  @override
  String get perfect => 'Hoàn hảo!';

  @override
  String get personalizedPathBasedOnDeck =>
      'Lộ trình học cá nhân hóa dựa trên bộ thẻ của bạn.';

  @override
  String play(Object pinyin) {
    return 'Phát âm ($pinyin)';
  }

  @override
  String get pleaseEnterMessageBeforeSending =>
      'Vui lòng nhập tin nhắn trước khi gửi.';

  @override
  String get practiceInRoleplay => 'Luyện tập qua nhập vai';

  @override
  String get practiceModes => 'Chế độ luyện tập';

  @override
  String get practicePronouncingWithAiGrading =>
      'Luyện phát âm từ này với AI chấm điểm';

  @override
  String get preparingReadingInterface => 'Đang chuẩn bị giao diện đọc...';

  @override
  String get privacy => 'Quyền riêng tư';

  @override
  String get privacyAndAudio => 'Quyền riêng tư & Âm thanh';

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
      'Bồ Tùng Linh (1640–1715) là văn nhân thời nhà Thanh, dành nhiều thập kỷ sưu tầm \'Liêu trai chí dị\' sau nhiều lần thi trượt. Những câu chuyện kỳ ảo về hồ ly, ma quỷ và thư sinh của ông là đỉnh cao của văn học chí dị Trung Hoa.';

  @override
  String get qaFaq => 'Hỏi & Đáp / FAQ';

  @override
  String get questsTitle => 'NHIỆM VỤ';

  @override
  String get quickBookmarks => 'Dấu trang nhanh';

  @override
  String get radical => 'Bộ thủ';

  @override
  String get ready => 'Sẵn sàng';

  @override
  String get readyToInterpret => 'Sẵn sàng phiên dịch';

  @override
  String get readyToStart => 'Sẵn sàng bắt đầu.';

  @override
  String get recentBookmarks => 'Dấu trang gần đây';

  @override
  String get refiningGrammar => 'Đang trau chuốt ngữ pháp...';

  @override
  String get refresh => 'Làm mới';

  @override
  String get removeFromSaved => 'Xóa khỏi mục đã lưu';

  @override
  String get removeFromSavedScenarios => 'Xóa khỏi tình huống đã lưu';

  @override
  String get removed => 'Đã xóa';

  @override
  String get requestPermissions => 'Yêu cầu cấp quyền';

  @override
  String get rescind => 'Thu hồi';

  @override
  String get restore => 'Khôi phục';

  @override
  String get results => 'Kết quả';

  @override
  String get resume => 'Tiếp tục';

  @override
  String get retry => 'Thử lại';

  @override
  String get revenuecatError => 'Lỗi RevenueCat: ';

  @override
  String revenuecatErrorE(String e) {
    return 'Lỗi RevenueCat: $e';
  }

  @override
  String get reviewExtractedDeck => 'Ôn tập bộ thẻ vừa trích xuất';

  @override
  String get reviewIn => 'Ôn tập trong';

  @override
  String get reviewingYourTones => 'Đang đánh giá thanh điệu...';

  @override
  String get saveAll => 'Lưu tất cả';

  @override
  String get saveScenario => 'Lưu tình huống';

  @override
  String get saveThisScenario => 'Lưu tình huống này';

  @override
  String get saved => 'Đã lưu';

  @override
  String get scanAnother => 'Quét mục khác';

  @override
  String get scenarioRemoved => 'Đã xóa tình huống';

  @override
  String get scenarioSavedFindInCustomTab =>
      'Đã lưu tình huống! Bạn có thể xem lại trong tab Tùy chỉnh.';

  @override
  String score(Object score, Object total) {
    return 'Điểm: $score / $total';
  }

  @override
  String get searchByPinyinOrMeaning => 'Tìm theo pinyin hoặc nghĩa...';

  @override
  String get searchByTitleOrTag => 'Tìm theo tiêu đề hoặc thẻ...';

  @override
  String get searchDictionaryOrTypeCustom =>
      'Tra từ điển hoặc nhập từ tùy chỉnh';

  @override
  String get searchHint => 'Tìm kiếm...';

  @override
  String get searchOrEnterUrl => 'Tìm kiếm hoặc nhập URL';

  @override
  String get searchScenariosHint => 'Tìm kiếm tình huống...';

  @override
  String get searchStoriesIdiomsNews => 'Tìm câu chuyện, thành ngữ, tin tức...';

  @override
  String get searchTopicsEgCookingHistory =>
      'Tìm chủ đề (ví dụ: Nấu ăn, Lịch sử)';

  @override
  String get seeAll => 'Xem tất cả';

  @override
  String get selectADeck => 'Chọn một bộ thẻ';

  @override
  String get selectPracticeMode => 'Chọn chế độ luyện tập';

  @override
  String get selectingHskVocabulary => 'Đang chọn lọc từ vựng HSK...';

  @override
  String get send => 'Gửi';

  @override
  String get sendMessage => 'Gửi tin nhắn';

  @override
  String get serif => 'Có chân (Serif)';

  @override
  String get shadow => 'Shadowing';

  @override
  String get shiNaianEpic =>
      'Thi Nại Am (khoảng 1296–1372) là văn nhân thời Nguyên, dù đỗ tiến sĩ nhưng chọn lui về ẩn dật. Kiệt tác \'Thủy Hử\' về các anh hùng Lương Sơn Bạc tụ nghĩa chống lại áp bức đã định hình nền sử thi võ hiệp Trung Quốc.';

  @override
  String get showEnglish => 'Hiện tiếng Anh';

  @override
  String get showEnglishTranslations => 'Hiện bản dịch tiếng Anh';

  @override
  String get showHanzi => 'Hiện chữ Hán';

  @override
  String get showPinyin => 'Hiện Pinyin';

  @override
  String get showTranslation => 'Hiện bản dịch';

  @override
  String get shows => 'Chương trình';

  @override
  String get signIn => 'Đăng nhập';

  @override
  String get simplifiedArticle => 'Bài viết đã chuyển sang dạng dễ hiểu';

  @override
  String get simplifyingSubtitles => 'Đang đơn giản hóa phụ đề...';

  @override
  String get sincereHonest => 'chân thành và trung thực';

  @override
  String get sleepTimer => 'Hẹn giờ tắt';

  @override
  String get smartDeck => 'Bộ thẻ thông minh';

  @override
  String get spanishAndWorld => 'Tiếng Tây Ban Nha & Thế giới';

  @override
  String get speaker => 'Loa phát';

  @override
  String get spotifyStylePlayer => 'Trình phát kiểu Spotify';

  @override
  String get storyBookmarkedInLibrary => 'Đã lưu câu chuyện vào thư viện!';

  @override
  String get streetFoodNightMarketInXian =>
      'Chợ đêm ẩm thực đường phố ở Tây An';

  @override
  String get strokes => 'Nét chữ';

  @override
  String get studyCharacter => 'Học chữ Hán';

  @override
  String get subtitleOpacity => 'Độ trong suốt của phụ đề';

  @override
  String get suggestion => 'Gợi ý';

  @override
  String get summary => 'Tóm tắt';

  @override
  String get supernaturalAndFolklore => 'Chí dị & Dân gian';

  @override
  String get swipeToGrade => 'Vuốt để chấm điểm:';

  @override
  String get tableOfContents => 'Mục lục';

  @override
  String get tapToRetry => 'Chạm để thử lại';

  @override
  String get teaTastingInChengdu => 'Thưởng trà truyền thống ở Thành Đô';

  @override
  String get techAndGadgets => 'Công nghệ & Thiết bị';

  @override
  String get terms => 'Điều khoản';

  @override
  String get theGalaxyCharacters =>
      'Bản đồ Ngân Hà đang chờ bạn.\nHãy làm chủ các Mặt Trời (Bộ thủ) để mở khóa các Hành Tinh (Chữ Hán).';

  @override
  String get theme => 'Chủ đề';

  @override
  String get thinking => 'Đang suy nghĩ...';

  @override
  String get thisArticleCharacters => 'Bài viết này chứa chữ Hán phồn thể.';

  @override
  String get todaysWord => 'TỪ VỰNG HÔM NAY';

  @override
  String get togglePinyin => 'Bật/Tắt Pinyin';

  @override
  String get toggleTranslation => 'Bật/Tắt bản dịch';

  @override
  String get toneDoesNotExistInMandarin =>
      'Thanh điệu này không tồn tại trong tiếng Quan thoại chuẩn.';

  @override
  String get toneGraph => 'Biểu đồ cao độ thanh điệu';

  @override
  String get traceLabel => 'Tập viết chữ';

  @override
  String get trailer => 'TRAILER';

  @override
  String get translatingAndAddingPinyin => 'Đang dịch và gắn Pinyin...';

  @override
  String get translatingText => 'Đang dịch văn bản...';

  @override
  String get turnOn => 'Bật';

  @override
  String get typeHanziPinyinOrEnglish => 'Nhập Hanzi, Pinyin hoặc nghĩa...';

  @override
  String get unknown2 => 'Trực tiếp game, Vương Giả Vinh Diệu, Genshin Impact';

  @override
  String get unknown3 => 'Ẩm thực Trung Hoa, Công thức nấu ăn';

  @override
  String get unknown4 => 'Đánh giá công nghệ Trung Quốc';

  @override
  String get unrollingTheScroll => 'Đang mở cuộn giấy...';

  @override
  String get upperIntermediate => 'Trung cấp cao';

  @override
  String get vibrationsForInteractions => 'Rung phản hồi khi tương tác';

  @override
  String get video => 'Video';

  @override
  String get viewAnswer => 'Xem đáp án';

  @override
  String get viewAsList => 'Xem dạng danh sách';

  @override
  String get viewBookmarks => 'Xem các dấu trang';

  @override
  String get viewMyDrawing => 'Xem nét vẽ của tôi';

  @override
  String get vlog => 'Vlog cuộc sống hằng ngày ở Trung Quốc';

  @override
  String get voice => 'Giọng đọc:';

  @override
  String get web => 'Web';

  @override
  String get wedLoveToHearFromYou =>
      'Chúng tôi rất mong\nnhận được phản hồi từ bạn.';

  @override
  String get welcomeBack => 'Chào mừng bạn trở lại';

  @override
  String get whatDoesThisMean => 'Điều này có nghĩa là gì?';

  @override
  String get whatHappensToMyChatHistory =>
      'Lịch sử trò chuyện của tôi được quản lý ra sao?';

  @override
  String get whatIfAiMishears => 'Nếu AI nghe nhầm điều tôi muốn nói thì sao?';

  @override
  String get whichCharacterIs => 'Chữ Hán nào tương ứng với:';

  @override
  String get wikipedia => 'Wikipedia';

  @override
  String get wordsSavedAndSrsScheduled =>
      'Đã lưu từ vựng và lên lịch lặp lại ngắt quãng (SRS)!';

  @override
  String get writeYourMessageHere => 'Nhập tin nhắn của bạn tại đây...';

  @override
  String get wuChengenLiterature =>
      'Ngô Thừa Ân (khoảng 1500–1582) là tiểu thuyết gia thời nhà Minh, quê ở Hoài An, Giang Tô. Dựa trên truyện kể dân gian, ngụ ngôn Phật giáo và ngòi bút châm biếm sâu sắc, ông đã sáng tác nên tuyệt tác \'Tây Du Ký\' — một trong những tác phẩm giàu trí tưởng tượng và được yêu thích nhất nền văn học thế giới.';

  @override
  String get wuJingziClass =>
      'Ngô Kính Tử (1701–1754) là tiểu thuyết gia thời nhà Thanh, quê ở An Huy. Ông đã từ bỏ gia sản thừa kế để dành trọn đời viết nên \'Nho Lâm Ngoại Sử\' — kiệt tác châm biếm bóc trần thói hư danh, mục nát và sự phi lý của chế độ khoa cử cùng tầng lớp sĩ đại phu.';

  @override
  String get xuZhonglinWarfare =>
      'Hứa Trọng Lâm (thế kỷ 16–17) là tác giả thời nhà Minh được ghi nhận biên soạn \'Phong Thần Diễn Nghĩa\', tác phẩm thần ma hoành tráng kết hợp lịch sử Thương-Chu với vũ trụ quan Đạo giáo, thần tiên thiên giới và những trận chiến huyền ảo.';

  @override
  String get yearly => 'Gói năm';

  @override
  String get yesReGradeMe => 'Có, hãy chấm lại!';

  @override
  String you(Object lang) {
    return 'Bạn ($lang)';
  }

  @override
  String get youAreSpeaking => 'Bạn đang nói';

  @override
  String get youLabel => 'Bạn';

  @override
  String youLang(String lang) {
    return 'Bạn ($lang)';
  }

  @override
  String get youMustAccount =>
      'Bạn cần đồng ý với Điều khoản dịch vụ và Chính sách quyền riêng tư để tạo tài khoản.';

  @override
  String get yourEchoModels =>
      'Các đoạn hội thoại Echo Hall chỉ được lưu cục bộ trên thiết bị của bạn để bạn ôn tập bất cứ lúc nào. Chúng tôi không dùng giọng nói cá nhân của bạn để huấn luyện mô hình AI.';

  @override
  String get zhOnly => 'Chỉ tiếng Trung (ZH)';

  @override
  String get hsk_1300_cards => '1300 thẻ';

  @override
  String get hsk_154_cards => '154 thẻ';

  @override
  String get hsk_162_cards => '162 thẻ';

  @override
  String get hsk_2500_cards => '2500 thẻ';

  @override
  String get hsk_299_cards => '299 thẻ';

  @override
  String get hsk_602_cards => '602 thẻ';

  @override
  String get added_to_review_queue => 'Đã thêm vào hàng đợi ôn tập';

  @override
  String added_cards_to(int cardCount, String deckName) {
    return 'Đã thêm $cardCount thẻ vào bộ «$deckName».';
  }

  @override
  String added_to_your_library(Object hanzi) {
    return 'Đã thêm «$hanzi» vào thư viện của bạn';
  }

  @override
  String get advanced => 'Cao cấp';

  @override
  String get ai_stories => 'Truyện AI';

  @override
  String analysis_failed(Object error) {
    return 'Phân tích thất bại: $error';
  }

  @override
  String get analyzing_pronunciation_with_gemini_ai =>
      'Đang phân tích phát âm với Gemini AI...';

  @override
  String get analyzing_your_pronunciation =>
      'Đang phân tích phát âm của bạn...';

  @override
  String are_you_sure_you_want_to(String deckName) {
    return 'Bạn có chắc chắn muốn xóa vĩnh viễn bộ «$deckName»? Thao tác này không thể hoàn tác và sẽ xóa tất cả thẻ bên trong.';
  }

  @override
  String ask_about(String hanzi) {
    return 'Hỏi về chữ «$hanzi»...';
  }

  @override
  String get audio_haptics => 'Âm thanh & Phản hồi xúc giác';

  @override
  String get audio_could_not_start_check_your =>
      'Không thể phát âm thanh. Vui lòng kiểm tra kết nối mạng và cài đặt giọng đọc trên thiết bị.';

  @override
  String get calligraphy_trace => 'Luyện viết nét thư pháp';

  @override
  String chapters(Object count) {
    return '$count chương';
  }

  @override
  String get char => 'Chữ Hán';

  @override
  String get chinese_character => 'CHỮ HÁN';

  @override
  String get contact_us_and_report_issues => 'Liên hệ với chúng tôi và báo lỗi';

  @override
  String created_smart_deck_with_words(String deckName, int wordCount) {
    return 'Đã tạo bộ thẻ thông minh: «$deckName» với $wordCount từ!';
  }

  @override
  String get custom_ai_generated_story => 'Truyện do AI tạo theo yêu cầu.';

  @override
  String get display_content => 'Hiển thị & Nội dung';

  @override
  String get do_you_keep_or_store_my =>
      'Ứng dụng có lưu trữ các đoạn ghi âm giọng nói của tôi không?';

  @override
  String get elementary => 'Sơ cấp';

  @override
  String error_creating_scenario(Object error) {
    return 'Lỗi tạo tình huống: $error';
  }

  @override
  String error_fetching_translation_for(Object error) {
    return 'Lỗi khi lấy bản dịch: $error';
  }

  @override
  String error_loading_chapters(Object error) {
    return 'Lỗi tải danh sách chương: $error';
  }

  @override
  String get error_loading_decks => 'Lỗi khi tải bộ thẻ';

  @override
  String error_loading_microreads(Object error) {
    return 'Lỗi tải bài đọc ngắn: $error';
  }

  @override
  String error_loading_novels(Object error) {
    return 'Lỗi tải tiểu thuyết: $error';
  }

  @override
  String error_loading_poetry(Object error) {
    return 'Lỗi tải thơ ca: $error';
  }

  @override
  String get etymology => 'Etimology (Nguồn gốc & Chiết tự): ';

  @override
  String get explanation => 'Giải thích';

  @override
  String get extracted_text_tap_to_lookup =>
      'Văn bản trích xuất (Chạm để tra cứu)';

  @override
  String extraction_failed(Object error) {
    return 'Trích xuất thất bại: $error';
  }

  @override
  String get failed_to_download => 'Tải xuống thất bại.';

  @override
  String failed_to_generate_scenario(Object error) {
    return 'Không thể tạo tình huống: $error';
  }

  @override
  String failed_to_generate_story(Object error) {
    return 'Không thể tạo câu chuyện:\n$error';
  }

  @override
  String failed_to_load_context(Object error) {
    return 'Không thể tải ngữ cảnh: $error';
  }

  @override
  String get feature_request => 'Yêu cầu tính năng';

  @override
  String get foundation => 'Căn bản';

  @override
  String get how_is_my_pronunciation_scored =>
      'Điểm phát âm của tôi được tính như thế nào?';

  @override
  String hsk(Object level) {
    return 'HSK $level';
  }

  @override
  String hsk_vocabulary(int hskLevel) {
    return 'Từ vựng HSK $hskLevel';
  }

  @override
  String get hsk_level => 'CẤP ĐỘ HSK';

  @override
  String get intermediate => 'Trung cấp';

  @override
  String get learning_stats => 'Thống kê học tập';

  @override
  String get mandarin => 'Tiếng Quan thoại (Phổ thông)';

  @override
  String get meaning => 'Ý nghĩa';

  @override
  String get no_decks_found => 'Không tìm thấy bộ thẻ nào.';

  @override
  String no_results_found_for(Object searchQuery) {
    return 'Không tìm thấy kết quả nào cho «$searchQuery»';
  }

  @override
  String get no_when_you_use_echo_hall =>
      'Không. Khi bạn sử dụng Echo Hall, Phán Quyết của Học Giả hoặc Phòng Luyện Shadowing, âm thanh của bạn được chấm điểm bảo mật theo thời gian thực rồi xóa ngay lập tức. Chúng tôi chỉ lưu lại điểm số để theo dõi tiến trình học tập của bạn.';

  @override
  String get notification_settings => 'Cài đặt thông báo';

  @override
  String get open_settings => 'Mở Cài đặt';

  @override
  String get phoneme => 'Âm vị';

  @override
  String get play_reference_pronunciation => 'Phát âm mẫu chuẩn';

  @override
  String get please_select_a_deck_to_add => 'Vui lòng chọn bộ thẻ để thêm vào.';

  @override
  String get point_at_chinese_text_to_translate =>
      'Hướng camera vào văn bản tiếng Trung để dịch';

  @override
  String get practice_writing_the_strokes_by_hand =>
      'Luyện tập viết các nét chữ bằng tay';

  @override
  String get preferences_audio_and_display => 'Tùy chọn, âm thanh và hiển thị';

  @override
  String get preparing_your_scholars_verdict =>
      'Đang chuẩn bị Phán quyết của Học Giả...';

  @override
  String get previous => 'Trước';

  @override
  String question(Object current, Object total) {
    return 'Câu hỏi $current/$total';
  }

  @override
  String remove_from_this_deck(String hanzi) {
    return 'Xóa «$hanzi» khỏi bộ thẻ này?';
  }

  @override
  String revenuecat_error(Object error) {
    return 'Lỗi RevenueCat: $error';
  }

  @override
  String get review_tomorrow => 'Ôn tập vào ngày mai';

  @override
  String get roleplay => 'Nhập vai';

  @override
  String saving_words_to(int wordCount, String deckName) {
    return 'Đang lưu $wordCount từ vào bộ «$deckName»...';
  }

  @override
  String get search_radicals_eg_water => 'Tìm kiếm bộ thủ (ví dụ: Thủy, 水, 氵)';

  @override
  String get select_target_hsk_level => 'Chọn cấp độ HSK mục tiêu';

  @override
  String get sentence => 'Câu';

  @override
  String get shadowing_studio_is_a_dedicated_space =>
      'Phòng luyện Shadowing là không gian chuyên biệt giúp bạn luyện tập nhại giọng theo người bản xứ theo thời gian thực.';

  @override
  String simplify_failed(Object error) {
    return 'Chuyển đổi thất bại: $error';
  }

  @override
  String get sinospark_premium => 'SinoSpark Premium';

  @override
  String get speaking_pronunciation => 'Khả năng nói & Phát âm';

  @override
  String get statistics => 'Thống kê';

  @override
  String get table_of_contents => 'Mục lục · 目录';

  @override
  String get the_ai_evaluates_your_speech_across =>
      'AI đánh giá giọng nói của bạn qua 3 tiêu chí:\n• Độ chính xác: Bạn có phát âm đúng từng âm tiết không?\n• Độ hoàn thiện: Bạn có bỏ sót từ nào không?\n• Độ lưu loát: Bạn có ngắt nghỉ tự nhiên và đúng thanh điệu không?\nHệ thống so sánh với giọng người bản xứ để đưa ra thang điểm 100.';

  @override
  String get this_cannot_be_undone => 'Thao tác này không thể hoàn tác.';

  @override
  String get title => 'Tiêu đề';

  @override
  String get to_be_reviewed => 'Cần ôn tập';

  @override
  String get traditional => 'Phồn thể';

  @override
  String translation_failed(Object error) {
    return 'Dịch thất bại: $error';
  }

  @override
  String get type_in => 'Nhập...';

  @override
  String get type_your_message_in => 'Nhập tin nhắn của bạn...';

  @override
  String get unable_to_open_this_video_please =>
      'Không thể mở video này. Vui lòng thử lại sau.';

  @override
  String get view_your_learning_history_and_streaks =>
      'Xem lịch sử học tập và chuỗi ngày rèn luyện';

  @override
  String get what_is_shadowing_studio => 'Phòng luyện Shadowing là gì?';

  @override
  String get words => 'từ';

  @override
  String your_path_for_is_ready(String deckName) {
    return 'Lộ trình cho bộ «$deckName» đã sẵn sàng!';
  }

  @override
  String get you_said => '🗣️ Bạn đã nói';

  @override
  String vocabularyBatch(Object index) {
    return 'Lô từ vựng $index';
  }

  @override
  String get yourDailyDropIsHere => 'Bài học hằng ngày của bạn đã sẵn sàng! ✨';

  @override
  String get timeToReview => 'Đến giờ ôn tập rồi! 📚';

  @override
  String get neverMissAStroke => 'Đừng bỏ lỡ nét bút nào! 🖌️';

  @override
  String get yourTrialEndsTomorrow =>
      'Thời gian dùng thử của bạn sẽ kết thúc vào ngày mai! ⏳';

  @override
  String get officialStandardVocabularyTiers =>
      'Cấp độ từ vựng tiêu chuẩn chính thức';

  @override
  String get failedToLoadCollections => 'Không thể tải bộ sưu tập.';

  @override
  String unnamedKey(Object tag) {
    return '#$tag';
  }

  @override
  String error(Object error) {
    return 'Lỗi: $error';
  }

  @override
  String get aiSmartContext => 'Ngữ cảnh thông minh AI';

  @override
  String get aiSmartContextError => 'Lỗi ngữ cảnh thông minh AI';

  @override
  String get downloadOfficialHskCollections =>
      'Tải xuống bộ sưu tập HSK chính thức';

  @override
  String get unableToLoadThisSection =>
      'Không thể tải phần này. Vui lòng thử lại.';

  @override
  String get translationLanguage => 'Ngôn ngữ dịch';

  @override
  String get dailyDrops => 'Bài học hằng ngày';

  @override
  String get wordOfTheDayNews => 'Từ vựng hôm nay & Tin tức';

  @override
  String get reviewReminders => 'Nhắc nhở ôn tập';

  @override
  String get flashcardsDueForReview => 'Thẻ ghi nhớ đến hạn ôn tập';

  @override
  String get dailyNewCards => 'Thẻ mới hằng ngày';

  @override
  String get dailyReviewLimit => 'Giới hạn ôn tập hằng ngày';

  @override
  String get practiceMode => 'Chế độ luyện tập';

  @override
  String get liziqi => 'Lý Tử Thất (李子柒): Nghệ thuật hoa lụa';

  @override
  String get theLifeOfGarlicTraditional =>
      'Vòng đời của tỏi: Nếp sống nông thôn truyền thống Trung Hoa';

  @override
  String get graceMandarin50Phrases => 'Grace Mandarin: 50 mẫu câu thiết yếu';

  @override
  String get essentialChinesePhrasesForBeginners =>
      'Mẫu câu tiếng Trung căn bản cho người mới bắt đầu';

  @override
  String get makingBambooFurniture => 'Nghề làm đồ nội thất bằng tre';

  @override
  String get peppaPigChinese => 'Peppa Pig tiếng Trung: Trốn tìm (躲猫猫)';

  @override
  String get muddyPuddlesBeginnerFriendly =>
      'Vũng bùn lầy (Dành cho người mới bắt đầu)';

  @override
  String get mandarinCorner300Verbs =>
      'Mandarin Corner: 300 động từ thông dụng';

  @override
  String get mostCommonChineseVerbs => 'Các động từ tiếng Trung phổ biến nhất';

  @override
  String get graceMandarinOrderFood => 'Grace Mandarin: Cách gọi món ăn';

  @override
  String get howToOrderFoodIn => 'Cách gọi món ăn trong nhà hàng Trung Quốc';

  @override
  String get silkFlowersTraditionalCraft =>
      'Hoa lụa: Nghề thủ công truyền thống';

  @override
  String get mandarinCorner => 'Mandarin Corner: Tiếng Trung khi đi khám bệnh';

  @override
  String get goingToTheDoctorReal => 'Đi khám bệnh: Hội thoại đời thực';

  @override
  String get hideAndSeekBeginnerFriendly =>
      'Trò chơi trốn tìm (Dành cho người mới bắt đầu)';

  @override
  String get linGdp6 =>
      'Tiểu Lâm giải thích: Vì sao mục tiêu tăng trưởng GDP là 6%?';

  @override
  String get why6GdpGrowthEasy =>
      'Vì sao GDP tăng trưởng 6%: Kinh tế Trung Quốc dễ hiểu';

  @override
  String get bbcWorldNews => 'BBC 中文 (Tin tức thế giới)';

  @override
  String get currentEventsInSimplifiedChinese =>
      'Tin tức thời sự bằng chữ Hán giản thể';

  @override
  String get baidu => 'Baidu (Bách Độ)';

  @override
  String get youtubeDesk => 'GÓC HỌC TẬP YOUTUBE';

  @override
  String get interactiveTranscriptsShadowing =>
      'Bản chép lời tương tác & Luyện Shadowing';

  @override
  String get showsDramas => 'PHIM TRUYỀN HÌNH & CHƯƠNG TRÌNH';

  @override
  String get extractToDeck => 'Trích xuất vào bộ thẻ';

  @override
  String get autoSimplify => 'Tự động chuyển thành văn bản dễ hiểu';

  @override
  String get rewriteThisArticleToMatch =>
      'Viết lại bài viết này cho phù hợp với cấp độ HSK của bạn';

  @override
  String failedToSaveExtractedWords(Object error) {
    return 'Không thể lưu các từ đã trích xuất: $error';
  }

  @override
  String addToDeck(Object count) {
    return 'Thêm vào bộ thẻ ($count)';
  }

  @override
  String get dailyDiscoveryDrop => 'Bài học khám phá hằng ngày';

  @override
  String get smartSpacedRepetition => 'Lặp lại ngắt quãng thông minh (SRS)';

  @override
  String get trialProtectionAlert => 'Cảnh báo bảo vệ gói dùng thử';

  @override
  String get masteryLevel => 'Mức độ thành thạo';

  @override
  String get targetObjective => 'Mục tiêu học tập';

  @override
  String get dailyPractice => 'Luyện tập hằng ngày';

  @override
  String get aiSpacedRepetition => 'Lặp lại ngắt quãng bằng AI';

  @override
  String get iVeGrantedAccess => 'Tôi đã cấp quyền truy cập';

  @override
  String get scanner => 'Máy quét';

  @override
  String get interpreter => 'Thông dịch viên';

  @override
  String cards(Object count) {
    return '$count thẻ';
  }

  @override
  String get nWaMendsTheHeavens => 'Nữ Oa vá trời (女娲补天)';

  @override
  String get terracottaArmy => 'Đội quân đất nung';

  @override
  String get forbiddenCity => 'Tử Cấm Thành (Cố Cung)';

  @override
  String get aBlessingInDisguise =>
      'Tái ông thất mã (Trong cái rủi có cái may)';

  @override
  String get drawingASnake => 'Vẽ rắn thêm chân (Họa xà thiêm túc)';

  @override
  String get takingTheBulletTrain => 'Đi tàu cao tốc (Gaotie)';

  @override
  String get visitingTheDoctor => 'Đi khám bác sĩ';

  @override
  String get orderingDumplings => 'Gọi món sủi cảo (Jiaozi)';

  @override
  String get theTeaCeremony => 'Nghệ thuật trà đạo Gongfu truyền thống';

  @override
  String get chineseCalligraphy => 'Thư pháp Trung Hoa';

  @override
  String get theGiantPanda => 'Gấu trúc lớn';

  @override
  String get simplifiedText => 'Văn bản giản thể dễ đọc';

  @override
  String get novels96 => 'Tiểu thuyết (96 tác phẩm)';

  @override
  String get microReads => 'Bài đọc ngắn';

  @override
  String get poetry => 'Thơ ca cổ điển';

  @override
  String get bookmarkRemoved => '书签已移除 · Đã gỡ dấu trang';

  @override
  String bookmarkAdded(Object chapter) {
    return '已添加书签 · Đã thêm dấu trang: Chương $chapter';
  }

  @override
  String get readingVocabulary => 'Đọc hiểu & Từ vựng';

  @override
  String vocabularyBatchUnitindex1(Object index) {
    return 'Lô từ vựng $index';
  }

  @override
  String get yourDailyDropIsHere1 => 'Bài học hằng ngày của bạn đã sẵn sàng! ✨';

  @override
  String get timeToReview1 => 'Đến lúc ôn tập rồi! 📚';

  @override
  String get neverMissAStroke1 => 'Đừng bỏ lỡ nét bút nào! 🖌️';

  @override
  String get yourTrialEndsTomorrow1 =>
      'Gói dùng thử miễn phí sẽ kết thúc vào ngày mai! ⏳';

  @override
  String get hskCollections1 => 'Bộ sưu tập HSK';

  @override
  String get officialStandardVocabularyTiers1 =>
      'Các cấp độ từ vựng chuẩn HSK chính thức';

  @override
  String get failedToLoadCollections1 => 'Không thể tải bộ sưu tập.';

  @override
  String ui__transcription(Object transcription) {
    return '\"$transcription\"';
  }

  @override
  String playPinyinwithtone(Object pinyinWithTone) {
    return 'Phát âm $pinyinWithTone';
  }

  @override
  String errorE(Object e) {
    return 'Lỗi: $e';
  }

  @override
  String lookalikepinyin(Object pinyin) {
    return '($pinyin)';
  }

  @override
  String get aiSmartContext1 => 'Ngữ cảnh thông minh AI';

  @override
  String get aiSmartContextError1 => 'Lỗi ngữ cảnh thông minh AI';

  @override
  String errorErr(Object err, Object error) {
    return 'Lỗi: $error';
  }

  @override
  String get downloadOfficialHskCollections1 =>
      'Tải xuống bộ sưu tập HSK chính thức';

  @override
  String get unableToLoadThisSectionPleaseTryAga =>
      'Không thể tải phần này. Vui lòng thử lại.';

  @override
  String get searchRadicalsEgWater => 'Tìm kiếm bộ thủ (ví dụ: Thủy, 水, 氵)';

  @override
  String ui__currentstrokeindex1totalstrokes(Object current, Object total) {
    return '$current/$total';
  }

  @override
  String get translationLanguage1 => 'Ngôn ngữ dịch';

  @override
  String get appLanguage1 => 'Ngôn ngữ ứng dụng';

  @override
  String get dailyDrops1 => 'Bài học hằng ngày';

  @override
  String get wordOfTheDayNews1 => 'Từ vựng hôm nay & Tin tức';

  @override
  String get reviewReminders1 => 'Nhắc nhở ôn tập';

  @override
  String get flashcardsDueForReview1 => 'Thẻ flashcard đến hạn ôn tập';

  @override
  String get accuracyByMode1 => 'Độ chính xác theo chế độ';

  @override
  String accuracytostringasfixed1(Object accuracy) {
    return '$accuracy%';
  }

  @override
  String get upcomingReviewsNext7Days => 'Lịch ôn tập sắp tới (7 ngày tới)';

  @override
  String get explaining => 'Giải thích:';

  @override
  String entryhanziEntrypinyin(Object hanzi, Object pinyin) {
    return '$hanzi [$pinyin]';
  }

  @override
  String get dailyNewCards1 => 'Thẻ mới hằng ngày';

  @override
  String get dailyReviewLimit1 => 'Giới hạn ôn tập hằng ngày';

  @override
  String get listeningMode1 => 'Chế độ Nghe';

  @override
  String get readingMode1 => 'Chế độ Đọc';

  @override
  String get recallMode1 => 'Chế độ Hồi tưởng';

  @override
  String get speakingMode1 => 'Chế độ Nói';

  @override
  String get practiceMode1 => 'Chế độ Luyện tập';

  @override
  String acc(Object acc) {
    return '$acc%';
  }

  @override
  String get partner1 => 'Bạn đối thoại';

  @override
  String get partnerSpeaking1 => 'Đối tác đang nói…';

  @override
  String get theLifeOfGarlicTraditionalChineseLi =>
      'Vòng đời của tỏi: Nếp sống nông thôn truyền thống Trung Hoa';

  @override
  String get graceMandarin50Phrases1 => 'Grace Mandarin: 50 mẫu câu thiết yếu';

  @override
  String get essentialChinesePhrasesForBeginners1 =>
      'Mẫu câu tiếng Trung căn bản cho người mới bắt đầu';

  @override
  String get makingBambooFurniture1 => 'Nghề làm đồ nội thất bằng tre';

  @override
  String get muddyPuddlesBeginnerFriendly1 =>
      'Vũng bùn lầy (Dành cho người mới bắt đầu)';

  @override
  String get mandarinCorner300Verbs1 =>
      'Mandarin Corner: 300 động từ thông dụng';

  @override
  String get mostCommonChineseVerbs1 => 'Các động từ tiếng Trung phổ biến nhất';

  @override
  String get graceMandarinOrderFood1 => 'Grace Mandarin: Cách gọi món ăn';

  @override
  String get howToOrderFoodInAChineseRestaurant =>
      'Cách gọi món ăn trong nhà hàng Trung Quốc';

  @override
  String get silkFlowersTraditionalCraft1 =>
      'Hoa lụa: Nghề thủ công truyền thống';

  @override
  String get goingToTheDoctorRealLifeConversatio =>
      'Đi khám bệnh: Hội thoại đời thực';

  @override
  String get hideAndSeekBeginnerFriendly1 =>
      'Trò chơi trốn tìm (Dành cho người mới bắt đầu)';

  @override
  String get lingdp6 => 'Tiểu Lâm giải thích: Vì sao GDP tăng trưởng 6%?';

  @override
  String get why6GdpGrowthEasyChineseEconomics =>
      'Vì sao GDP tăng trưởng 6%: Kinh tế Trung Quốc dễ hiểu';

  @override
  String get currentEventsInSimplifiedChinese1 =>
      'Tin tức thời sự bằng chữ Hán giản thể';

  @override
  String get baidu1 => 'Baidu (Bách Độ)';

  @override
  String get youtubeDesk1 => 'GÓC HỌC TẬP YOUTUBE';

  @override
  String get interactiveTranscriptsShadowing1 =>
      'Bản chép lời tương tác & Luyện Shadowing';

  @override
  String get showsDramas1 => 'PHIM TRUYỀN HÌNH & CHƯƠNG TRÌNH';

  @override
  String error_error(Object error) {
    return 'Lỗi: $error';
  }

  @override
  String get extractToDeck1 => 'Trích xuất vào bộ thẻ';

  @override
  String get autosimplify => 'Tự động chuyển thành văn bản dễ hiểu';

  @override
  String get rewriteThisArticleToMatchYourHskLev =>
      'Viết lại bài viết này cho phù hợp với cấp độ HSK của bạn';

  @override
  String get addToDeck1 => 'Thêm vào bộ thẻ';

  @override
  String playbackratex(Object playbackRate) {
    return '${playbackRate}x';
  }

  @override
  String speedx(Object speed) {
    return '${speed}x';
  }

  @override
  String get dailyDiscoveryDrop1 => 'Bài học khám phá hằng ngày';

  @override
  String get smartSpacedRepetition1 => 'Lặp lại ngắt quãng thông minh (SRS)';

  @override
  String get trialProtectionAlert1 => 'Cảnh báo bảo vệ gói dùng thử';

  @override
  String get masteryLevel1 => 'Mức độ thành thạo';

  @override
  String get targetObjective1 => 'Mục tiêu học tập';

  @override
  String get dailyPractice1 => 'Luyện tập hằng ngày';

  @override
  String get aiSpacedRepetition1 => 'Lặp lại ngắt quãng bằng AI';

  @override
  String get iveGrantedAccess => 'Tôi đã cấp quyền truy cập';

  @override
  String addToDeck_selectedwordindiceslength(Object count) {
    return 'Thêm vào bộ thẻ ($count)';
  }

  @override
  String get scanner1 => 'Máy quét';

  @override
  String get interpreter1 => 'Thông dịch viên';

  @override
  String entryvalueCards(Object count) {
    return '$count thẻ';
  }

  @override
  String score_score_questionslength(Object score, Object total) {
    return 'Điểm: $score / $total';
  }

  @override
  String get theMonkeyKing1 => 'Tôn Ngộ Không';

  @override
  String get huaMulan1 => 'Hoa Mộc Lan';

  @override
  String get nwaMendsTheHeavens => 'Nữ Oa vá trời';

  @override
  String get confucius => 'Khổng Tử';

  @override
  String get theGreatWall1 => 'Vạn Lý Trường Thành';

  @override
  String get terracottaArmy1 => 'Đội quân đất nung';

  @override
  String get forbiddenCity1 => 'Tử Cấm Thành';

  @override
  String get aBlessingInDisguise1 =>
      'Trong cái rủi có cái may (Tái ông thất mã)';

  @override
  String get drawingASnake1 => 'Vẽ rắn thêm chân';

  @override
  String get takingTheBulletTrain1 => 'Đi tàu cao tốc';

  @override
  String get visitingTheDoctor1 => 'Đi khám bác sĩ';

  @override
  String get orderingDumplings1 => 'Gọi sủi cảo';

  @override
  String get theTeaCeremony1 => 'Nghi lễ trà đạo';

  @override
  String get chineseCalligraphy1 => 'Thư pháp Trung Hoa';

  @override
  String get theGiantPanda1 => 'Gấu trúc lớn';

  @override
  String get simplifiedText1 => 'Văn bản giản thể dễ đọc';

  @override
  String get novels961 => 'Tiểu thuyết (96 tác phẩm)';

  @override
  String get microreads => 'Bài đọc ngắn';

  @override
  String get poetry1 => 'Thơ ca cổ điển';

  @override
  String get readingVocabulary1 => 'Đọc hiểu & Từ vựng';

  @override
  String get defaultfirebaseoptionsHaveNotBeenCo =>
      'DefaultFirebaseOptions chưa được cấu hình cho Linux.';

  @override
  String get defaultfirebaseoptionsAreNotSupport =>
      'DefaultFirebaseOptions không được hỗ trợ trên nền tảng này.';

  @override
  String get hanziMaster1 => 'SinoSpark';

  @override
  String get strokesCannotBeEmpty => 'Nét chữ không được để trống.';

  @override
  String get wrongStartPoint => 'Điểm bắt đầu chưa chính xác.';

  @override
  String get rightShapeButWrongPlace =>
      'Nét vẽ đúng hình dạng nhưng sai vị trí!';

  @override
  String get goodFollowTheFlow =>
      'Tốt lắm! Hãy viết theo dòng chảy tự nhiên của nét bút.';

  @override
  String get aBitShaky => 'Nét vẽ hơi bị run tay!';

  @override
  String get aBitHesitant => 'Còn một chút do dự trong nét bút...';

  @override
  String get shapeIsOff => 'Hình dạng nét chưa chuẩn.';

  @override
  String get arabic => 'Tiếng Ả Rập';

  @override
  String get german => 'Tiếng Đức';

  @override
  String get spanish => 'Tiếng Tây Ban Nha';

  @override
  String get french => 'Tiếng Pháp';

  @override
  String get hindi => 'Tiếng Hindi';

  @override
  String get indonesian => 'Tiếng Indonesia';

  @override
  String get italian => 'Tiếng Ý';

  @override
  String get japanese => 'Tiếng Nhật';

  @override
  String get korean => 'Tiếng Hàn';

  @override
  String get portuguese => 'Tiếng Bồ Đào Nha';

  @override
  String get russian => 'Tiếng Nga';

  @override
  String get vietnamese => 'Tiếng Việt';

  @override
  String get microphonePermissionDenied => 'Quyền truy cập micro đã bị từ chối';

  @override
  String get offset => 'Độ lệch';

  @override
  String get audioserviceHasBeenDisposed => 'AudioService đã được giải phóng';

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
  String get kore => 'Kore (nữ, ấm áp)';

  @override
  String get xmicrosoftoutputformatAudio24khz48k =>
      'audio-24khz-48kbitrate-mono-mp3';

  @override
  String get useragentHanzimasterapp => 'HanziMasterApp';

  @override
  String get anchorWord => 'Từ mỏ neo';

  @override
  String get creativeThematicTitle => 'Tiêu đề chủ đề sáng tạo';

  @override
  String get briefPedagogicalOrSemanticRationale =>
      'Giải thích ngắn gọn về mặt sư phạm hoặc ngữ nghĩa';

  @override
  String get theSingleMostCentralCharacterFromTh =>
      'Chữ Hán cốt lõi và đại diện nhất trong danh sách';

  @override
  String get aBalancedSetOfCharactersFromYourLib =>
      'Một bộ chữ Hán cân đối được chọn lọc từ thư viện của bạn.';

  @override
  String get yourNaturalConversationalReplyInChi =>
      'Câu trả lời đối thoại tự nhiên bằng chữ Hán.';

  @override
  String get theEnglishTranslationOfYourReply =>
      'Bản dịch tiếng Việt của câu trả lời.';

  @override
  String get thePinyinWithToneMarksForYourReply =>
      'Pinyin có dấu thanh điệu cho câu trả lời.';

  @override
  String get aSuggestedResponseTheUserCouldSayBa =>
      'Gợi ý câu phản hồi mà người học có thể nói lại với bạn.';

  @override
  String get pinyinForTheSuggestion => 'Pinyin cho câu gợi ý.';

  @override
  String get englishTranslationForTheSuggestion =>
      'Bản dịch tiếng Việt cho câu gợi ý.';

  @override
  String get scholarsCritique => 'Nhận xét & Đánh giá của Học Giả';

  @override
  String get theEchoHallRemainsSilentTryYourBrea =>
      'Hành Lang Tiếng Vọng vẫn im lặng. Hãy lấy hơi và thử lại nhé.';

  @override
  String get xtitleHanziMaster => 'SinoSpark';

  @override
  String get noneYet => 'Chưa có.';

  @override
  String get exactSentence => 'Câu văn chính xác:';

  @override
  String get englishTranslation => 'Bản dịch tiếng Việt';

  @override
  String get previouslyGeneratedPhrases => 'Các câu đã tạo trước đó';

  @override
  String get iLikeDrinkingAppleJuice => 'Tôi thích uống nước ép táo.';

  @override
  String get theEnglishMeaningHere => 'Ý nghĩa tiếng Việt tại đây...';

  @override
  String get failedToFetchDefinition => 'Không thể lấy định nghĩa từ vựng.';

  @override
  String get failedToLoadExplanation => 'Không thể tải phần giải thích.';

  @override
  String get failedToLoadComparison => 'Không thể tải phần so sánh đối chiếu.';

  @override
  String get emptyResponseFromOpenrouter => 'Phản hồi trống từ OpenRouter';

  @override
  String get emptyResponseFromVisionModel =>
      'Phản hồi trống từ mô hình thị giác (Vision)';

  @override
  String get standard => 'Tiêu chuẩn';

  @override
  String get theFullSentenceInChinese => 'Toàn bộ câu bằng tiếng Trung...';

  @override
  String get theWordOrCharacterInChinese => 'Từ hoặc chữ Hán bằng tiếng Trung';

  @override
  String get thePinyinForThisSpecificWord => 'Pinyin cho từ cụ thể này';

  @override
  String get emptyResponseFromDeepseekApi => 'Phản hồi trống từ DeepSeek API';

  @override
  String get criticalPutTheEnglishTranslationInT =>
      'QUAN TRỌNG: Đặt bản dịch tiếng Việt vào mục';

  @override
  String get englishTranslationOfTheEntireSenten =>
      'Bản dịch tiếng Việt của toàn bộ câu';

  @override
  String get hanziWord => 'Từ chữ Hán';

  @override
  String get theFullSimplifiedSentenceInChinese =>
      'Toàn bộ câu bằng chữ Hán giản thể...';

  @override
  String get lyingFlatACulturalMovement =>
      'Thoái trào nằm yên (Tang Ping): Một hiện tượng xã hội...';

  @override
  String get theUserYouAreSpeakingToIsNamed => 'Tên người dùng đang đàm thoại:';

  @override
  String get importantRuleDoNotAddressTheUserByA =>
      'QUY TẮC QUAN TRỌNG: Không xưng hô với người dùng bằng tên tùy tiện. Tuyệt đối không dùng tên mẫu như';

  @override
  String get youAreAConciseChineseCalligraphyAnd =>
      'Bạn là gia sư súc tích và am hiểu về thư pháp, chiết tự chữ Hán trong ứng dụng flashcard di động.';

  @override
  String get theStudentIsStudyingTheCharacter => 'Người học đang học chữ Hán';

  @override
  String get neverWriteIntroductionsSignoffsOrFi =>
      'Tuyệt đối không viết lời chào mở đầu, lời kết hay các câu đệm rườm rà như';

  @override
  String get beDirectAndInformative =>
      'Hãy trả lời trực diện, súc tích và giàu thông tin.';

  @override
  String get criticalRuleYouMustRespondEntirelyI =>
      'QUY TẮC BẮT BUỘC: Bạn phải trả lời HOÀN TOÀN bằng ngôn ngữ tương ứng với mã ISO 639-1';

  @override
  String get youAreAConciseChineseGrammarTutorIn =>
      'Bạn là gia sư ngữ pháp tiếng Trung súc tích và chuẩn mực trong ứng dụng di động.';

  @override
  String get theStudentIsConfusedAboutTheWord =>
      'Người học đang thắc mắc về từ';

  @override
  String get neverWriteIntroductionsSignoffsOrFi1 =>
      'Tuyệt đối không viết lời chào mở đầu, lời kết hay câu đệm rườm rà.';

  @override
  String get azureSpeechApiKeysAreMissing => 'Thiếu khóa API Azure Speech.';

  @override
  String get success => 'Thành công';

  @override
  String get granularity => 'Mức độ chi tiết';

  @override
  String get phoneme1 => 'Âm vị';

  @override
  String get dimension => 'Tiêu chí đánh giá';

  @override
  String get comprehensive => 'Đánh giá toàn diện';

  @override
  String get weCouldntHearYouClearlyPleaseTryAga =>
      'Không thể nghe rõ giọng của bạn. Vui lòng thử lại.';

  @override
  String get noNbestResultFound => 'Không tìm thấy kết quả nhận diện tối ưu.';

  @override
  String get words1 => 'Từ vựng';

  @override
  String get word => 'Từ';

  @override
  String get phonemes => 'Âm vị';

  @override
  String get syllables => 'Âm tiết';

  @override
  String get syllable => 'Âm tiết';

  @override
  String get omission => 'Bỏ sót từ';

  @override
  String get insertion => 'Âm thừa (Thêm từ)';

  @override
  String get youMissedThisWord => 'Bạn đã đọc sót từ này.';

  @override
  String get extraWordAddedHere => 'Có từ thừa được thêm vào ở đây.';

  @override
  String get mispronunciation => 'Phát âm chưa chuẩn';

  @override
  String get pronunciationWasInaccurate => 'Phát âm chưa hoàn toàn chính xác.';

  @override
  String get goodEffortKeepPracticing =>
      'Cố gắng rất tốt! Hãy tiếp tục luyện tập nhé.';

  @override
  String get perfectPronunciationSoundsLikeANati =>
      'Phát âm chuẩn xác tuyệt đối! Giống hệt người bản xứ.';

  @override
  String get greatJobAFewMinorToneInaccuracies =>
      'Làm rất tốt! Chỉ có một vài chỗ thanh điệu hơi lệch nhẹ.';

  @override
  String get notBadButYourTonesNeedSomeWork =>
      'Khá tốt, nhưng thanh điệu cần trau chuốt thêm một chút.';

  @override
  String get keepPracticingListenToTheNativeAudi =>
      'Hãy tiếp tục luyện tập! Nghe kỹ phát âm mẫu và thử lại nhé.';

  @override
  String get lexical => 'Thuộc về từ vựng';

  @override
  String get chineseHanziHere => 'Nhập chữ Hán tại đây';

  @override
  String get aShortSummaryInEnglish => 'Tóm tắt ngắn gọn bằng tiếng Việt';

  @override
  String get noCoherentChineseTextFoundInTheScan =>
      'Không tìm thấy văn bản tiếng Trung rõ ràng nào trong bản quét.';

  @override
  String get theFullEnglishTranslationOfTheScann =>
      'Bản dịch tiếng Việt hoàn chỉnh của văn bản đã quét... HOẶC \'Không tìm thấy văn bản tiếng Trung rõ ràng nào.\'';

  @override
  String get aShort24WordTitleForThisScanEgResta =>
      'Tiêu đề ngắn 2–4 từ cho bản quét này (ví dụ: \'Thực đơn nhà hàng\', \'Biển báo giao thông\')';

  @override
  String get china => 'Trung Quốc';

  @override
  String get noTranslationAvailable => 'Chưa có bản dịch.';

  @override
  String get scanResults => 'Kết quả quét';

  @override
  String get whenWasItWrittenAndWhatWasHappening =>
      'Tác phẩm được sáng tác khi nào và bối cảnh lịch sử Trung Quốc lúc bấy giờ ra sao?';

  @override
  String get whyIsThisPieceFamousWhatPhilosophic =>
      'Vì sao tác phẩm này nổi tiếng? Tác phẩm khám phá những chủ đề triết học hay văn hóa nào?';

  @override
  String get aBriefBioOfTheAuthor => 'Tiểu sử tóm tắt của tác giả';

  @override
  String get informationUnavailable => 'Thông tin không khả dụng.';

  @override
  String get noSummaryAvailable => 'Không có bản tóm tắt.';

  @override
  String get hanziAiPro => 'SinoSpark AI Pro';

  @override
  String get trialNormalIntro => 'Dùng thử, Tiêu chuẩn, Giới thiệu';

  @override
  String get dailyDrop => 'Bài học hằng ngày';

  @override
  String get dailyNotificationsForWordOfTheDayAn =>
      'Thông báo hằng ngày về Từ vựng hôm nay và tin tức';

  @override
  String get aNewWordAndStoryOfTheDayAreWaitingF =>
      'Từ vựng và câu chuyện mới của ngày hôm nay đang chờ bạn!';

  @override
  String get spacedRepetition => 'Lặp lại ngắt quãng (SRS)';

  @override
  String get remindersForFlashcardsDueForReview =>
      'Nhắc nhở về các thẻ đến hạn ôn tập';

  @override
  String get engagementReminders => 'Nhắc nhở duy trì học tập';

  @override
  String get trialReminders => 'Nhắc nhở về gói dùng thử';

  @override
  String get notificationsForYourTrialStatus =>
      'Thông báo về trạng thái gói dùng thử của bạn';

  @override
  String get comeReviewYourHanziAndTryALiveCallB =>
      'Hãy vào ôn tập chữ Hán và trải nghiệm Gọi thoại trực tiếp trước khi hết hạn dùng thử miễn phí!';

  @override
  String get scholarsEye => 'Mắt Nhìn Học Giả';

  @override
  String get clMeasureWord => 'Lượng từ (CL):';

  @override
  String get surnameShi => 'Họ Sử (Shi)';

  @override
  String get chineseFamilyNameShi => 'Họ tiếng Trung (Sử / Shi)';

  @override
  String get neutralToneLight => 'Thanh nhẹ (Đọc nhẹ và lướt)';

  @override
  String get keepYourPitchHighAndSteadyLikeSingi =>
      'Giữ cao độ cao và đều đặn như khi ngân một nốt nhạc.';

  @override
  String get startInTheMiddleAndSlideYourPitchUp =>
      'Bắt đầu ở cao độ trung bình rồi vuốt giọng lên cao, giống như khi hỏi \'Gì cơ?\'';

  @override
  String get dipYourVoiceDownLowThenRiseGentlyBa =>
      'Hạ giọng xuống trầm rồi nhẹ nhàng nâng cao độ lên.';

  @override
  String get dropYourPitchSharplyAndDecisivelyLi =>
      'Hạ giọng thật nhanh và dứt khoát, giống như khi dứt khoát nói \'Không!\'';

  @override
  String get pronounceSoftlyBrieflyAndWithoutEmp =>
      'Phát âm nhẹ nhàng, ngắn gọn và không nhấn mạnh.';

  @override
  String get spotOnPitchWasHighFlatAndSteady =>
      'Chuẩn xác! Cao độ giữ được mức cao, phẳng và rất đều.';

  @override
  String get spotOnUpwardPitchRiseWasClear =>
      'Chuẩn xác! Nét vuốt giọng lên cao rất rõ ràng.';

  @override
  String get spotOnLowDippingCurveWasAccurate =>
      'Chuẩn xác! Độ uốn trầm xuống rồi nâng lên rất đúng chuẩn.';

  @override
  String get spotOnSharpFallingDropWasDecisive =>
      'Chuẩn xác! Nét rơi giọng dứt khoát và mạnh mẽ.';

  @override
  String get spotOnToneWasPronouncedAccurately =>
      'Chuẩn xác! Thanh điệu được phát âm vô cùng chuẩn mực.';

  @override
  String get iAgreeToTheTermsOfServiceAndPrivacy =>
      'Tôi đồng ý với Điều khoản dịch vụ và Chính sách quyền riêng tư.';

  @override
  String get sendMeOccasionalUpdatesTipsAndOffer =>
      'Gửi cho tôi các cập nhật định kỳ, mẹo học tập và ưu đãi.';

  @override
  String get signInToSyncYourProgress =>
      'Đăng nhập để đồng bộ tiến độ học tập trên đám mây.';

  @override
  String get createAnAccountToSaveYourStats =>
      'Tạo tài khoản để lưu giữ an toàn các thống kê học tập.';

  @override
  String get smartSpiral => 'XOẮN ỐC THÔNG MINH';

  @override
  String get origin => 'Khởi Nguyên';

  @override
  String get elements => 'Nguyên Tố Tự Nhiên';

  @override
  String get humanity => 'Nhân Thân & Con Người';

  @override
  String get village => 'Thôn Làng & Sinh Hoạt';

  @override
  String get journey => 'Hành Trình & Vận Động';

  @override
  String get city => 'Đô Thị & Văn Minh';

  @override
  String get originTheSimplestShapesTheBeginning =>
      'Những hình dạng khởi thủy đơn sơ nhất. Khởi đầu của vạn vật.';

  @override
  String get elementsSunMoonWaterAndFireTheNatur =>
      'Mặt trời, Mặt trăng, Nước và Lửa. Thế giới tự nhiên bao la.';

  @override
  String get humanityTheBodyTheHeartAndTheFamily =>
      'Cơ thể, trái tim và mối dây gia đình.';

  @override
  String get villageFieldsRoofsAndToolsTheFounda =>
      'Ruộng đồng, mái nhà và công cụ. Nền tảng của đời sống xã hội.';

  @override
  String get journeyMovementSpeechAndSustenance =>
      'Chuyển động, ngôn ngữ và nguồn sống.';

  @override
  String get cityCommerceClothingAndComplexArtif =>
      'Thương mại, trang phục và những tinh hoa văn minh phức hợp.';

  @override
  String get equilibriumAlgorithm => 'Thuật toán cân bằng';

  @override
  String get misc => 'Khác';

  @override
  String get cityOrOriginAs => '«Đô Thị» hoặc «Khởi Nguyên» là';

  @override
  String get miscToOrigin => 'Từ «Khác» sang «Khởi Nguyên»';

  @override
  String get constellation => 'Chòm sao';

  @override
  String get whichOneIsWater => 'Chữ nào có nghĩa là \'Nước\'?';

  @override
  String get whatIsThePinyin => 'Pinyin chính xác là gì?';

  @override
  String get nature => 'Tự nhiên';

  @override
  String get whatEssenceDoes => 'Cần bộ thủ (bản chất) nào cho';

  @override
  String get allTiers => 'Tất cả các cấp';

  @override
  String get active => 'Đang hoạt động';

  @override
  String get theScrollOfOrigin1 => 'CUỘN SÁCH KHỞI NGUYÊN';

  @override
  String galaxyOf1(Object name) {
    return 'THIÊN HÀ CỦA $name';
  }

  @override
  String get also => 'Cũng / Lại';

  @override
  String get work => 'Công việc / Lao động';

  @override
  String get cloud => 'Mây (Vân)';

  @override
  String get youArchaic => 'Ngươi / Nàng (cổ)';

  @override
  String get suddenly => 'Đột ngột (Hốt)';

  @override
  String get owner => 'Chủ nhân';

  @override
  String get door => 'Cửa / Cổng (Môn)';

  @override
  String get occupy => 'Chiếm giữ (Chiêm)';

  @override
  String get nail => 'Đinh';

  @override
  String get and => 'Và (Cập)';

  @override
  String get buddhistNun => 'Ni cô / Tỳ-kheo-ni';

  @override
  String get anxious => 'Lo lắng (Tiêu)';

  @override
  String get sprout => 'Mầm cây (Mầm)';

  @override
  String get exchange => 'Trao đổi (Giao)';

  @override
  String get sheep => 'Dê / Cừu (Dương)';

  @override
  String get strange => 'Kỳ lạ (Quái)';

  @override
  String get opposite => 'Đối lập / Phản';

  @override
  String get shorttailedBird => 'Chim đuôi ngắn (Chuy)';

  @override
  String get shoot => 'Bắn / Măng tre (Xạ/Duẫn)';

  @override
  String get small => 'Nhỏ (Tiểu)';

  @override
  String get gather => 'Tập hợp (Tập)';

  @override
  String get order => 'Thứ tự / Lệnh';

  @override
  String get flat => 'Bằng phẳng (Bình)';

  @override
  String get thePersonWho => 'Người mà... (Giả)';

  @override
  String get nobleman => 'Người quý tộc / Quân tử';

  @override
  String get cause => 'Nguyên nhân (Nhân)';

  @override
  String get pig => 'Lợn / Heo (Trư)';

  @override
  String get bright => 'Tươi sáng (Minh)';

  @override
  String get slowly => 'Chậm rãi (Hằng/Từ)';

  @override
  String get give => 'Cho / Tặng (Dữ)';

  @override
  String get arrow => 'Mũi tên (Thỉ)';

  @override
  String get dry => 'Khô ráo (Can)';

  @override
  String get obstacle => 'Trở ngại (Chướng)';

  @override
  String get beg => 'Cầu xin (Khất)';

  @override
  String get window => 'Cửa sổ (Song)';

  @override
  String get fear => 'Sợ hãi (Cụ)';

  @override
  String get drum => 'Trống (Cổ)';

  @override
  String get why => 'Vì sao / Tại sao (Hà)';

  @override
  String get talent => 'Tài năng (Tài)';

  @override
  String get follow => 'Đi theo / Dõi theo (Tùy)';

  @override
  String get desert => 'Sa mạc';

  @override
  String get component => 'Thành phần (Bộ thủ)';

  @override
  String divingInto1(Object topic) {
    return 'Khám phá chuyên sâu: $topic';
  }

  @override
  String get unitIntro1 => 'Giới thiệu bài học';

  @override
  String get theBlueprint => 'BẢN THIẾT KẾ';

  @override
  String get theOrigin => 'NGUỒN GỐC';

  @override
  String get theGalaxy => 'THIÊN HÀ';

  @override
  String get theScholarListens => 'Học giả đang lắng nghe...';

  @override
  String get consultingTheScrolls => 'Đang tra cứu cổ thư...';

  @override
  String get traceWithTheGuide => 'Viết theo nét hướng dẫn';

  @override
  String get traceTheGhost => 'Viết đè lên chữ mờ';

  @override
  String get connectTheDots => 'Nối các điểm chuẩn';

  @override
  String get drawFromMemory => 'Viết chữ từ trí nhớ';

  @override
  String get assistant => 'Trợ lý';

  @override
  String get puck => 'Puck (nam, năng động)';

  @override
  String get helloWelcomeWhatWouldYouLikeToOrder =>
      'Xin chào! Kính chào quý khách. Quý khách muốn gọi món gì ạ?';

  @override
  String get ni3Hao3Huan1ying2Guang1lin2Qing3wen =>
      'Nǐ hǎo! Huānyíng guānglín. Qǐngwèn nǐ yào diǎn shénme?';

  @override
  String get waiterLi => 'Phục vụ Lý';

  @override
  String get askForTheMenu => 'Xin thực đơn';

  @override
  String get orderOneDishAndOneDrink => 'Gọi một món ăn và một đồ uống';

  @override
  String get askForTheBill => 'Xin hóa đơn thanh toán';

  @override
  String get fenrir => 'Fenrir (nam, sôi nổi)';

  @override
  String get ni3Qu4Na3rAJi1chang3MaTing3Yuan3De =>
      'Nǐ qù nǎr a? Jīchǎng ma? Tǐng yuǎn de!';

  @override
  String get driverWang => 'Tài xế Vương';

  @override
  String get tellTheDriverYouAreGoingToTheAirpor =>
      'Nói với tài xế rằng bạn muốn đến sân bay';

  @override
  String get askHowLongTheTripWillTake => 'Hỏi xem đi hết bao nhiêu thời gian';

  @override
  String get complainAboutTheTraffic => 'Than phiền về tình trạng kẹt xe';

  @override
  String get charon => 'Charon (nam, phong cách thời sự)';

  @override
  String get thisClothingQualityIsEspeciallyGood =>
      'Chất lượng bộ quần áo này rất tốt, chỉ có 200 tệ thôi.';

  @override
  String get zhe4Jian4Yi1fuZhi4liang4Te4bie2Hao3 =>
      'Zhè jiàn yīfu zhìliàng tèbié hǎo, zhǐyào liǎng bǎi kuài.';

  @override
  String get auntieChen => 'Dì Trần';

  @override
  String get askHowMuchTheSilkShirtCosts => 'Hỏi giá chiếc áo lụa';

  @override
  String get sayItIsTooExpensive => 'Nói rằng giá quá đắt';

  @override
  String get bargainThePriceDownTo100Rmb => 'Mặc cả giá xuống còn 100 tệ';

  @override
  String get ni3Na3li3Bu4Shu1fuFa1shao1LeMa =>
      'Nǐ nǎlǐ bù shūfu? Fāshāo le ma?';

  @override
  String get drZhang => 'Bác sĩ Trương';

  @override
  String get explainYouHaveHadAHeadacheForTwoDay =>
      'Trình bày rằng bạn bị đau đầu suốt hai ngày nay';

  @override
  String get sayYouHaveASlightFever => 'Nói rằng bạn đang bị sốt nhẹ';

  @override
  String get askIfYouNeedToTakeMedicine =>
      'Hỏi xem có cần phải uống thuốc không';

  @override
  String get aoede => 'Aoede (nữ, trong trẻo)';

  @override
  String get heyLongTimeNoSeeHowHaveYouBeenLatel =>
      'Chào bạn! Lâu lắm không gặp, dạo này bạn thế nào rồi?';

  @override
  String get ni3Hao3Hao3jiu3Bu4jian4Ni3Zui4jin4Z =>
      'Nǐ hǎo! Hǎojiǔ bùjiàn, nǐ zuìjìn zěnmeyàng?';

  @override
  String get pleaseIntroduceYourselfWhyDoYouWant =>
      'Vui lòng giới thiệu bản thân. Vì sao bạn muốn ứng tuyển vào công ty chúng tôi?';

  @override
  String get qing3Xian1Zi4wo3Jie4shao4Yi1xia4Ni3 =>
      'Qǐng xiān zìwǒ jièshào yíxià. Nǐ wèishénme xiǎng lái wǒmen gōngsī gōngzuò?';

  @override
  String get managerLiu => 'Trưởng phòng nhân sự Lưu';

  @override
  String get introduceYourProfessionalBackground =>
      'Tóm tắt kinh nghiệm làm việc chuyên môn của bạn';

  @override
  String get explainWhyYouWantToWorkAtThisCompan =>
      'Trình bày lý do bạn mong muốn làm việc tại công ty';

  @override
  String get askAPoliteQuestionAboutTheCompanyCu =>
      'Đặt một câu hỏi lịch sự về văn hóa doanh nghiệp';

  @override
  String get microphoneAccessIsRequiredPleaseEna =>
      'Ứng dụng cần quyền truy cập micro. Vui lòng bật trong phần Cài đặt của thiết bị.';

  @override
  String get couldNotStartMicrophonePleaseCheckY =>
      'Không thể khởi động micro. Vui lòng kiểm tra cài đặt âm thanh và thử lại.';

  @override
  String get weDidntQuiteCatchThatPleaseHoldTheM =>
      'Chưa nghe rõ giọng của bạn. Hãy nhấn giữ micro và nói lại nhé!';

  @override
  String get recordingWasTooShortHoldTheMicAndSp =>
      'Đoạn ghi âm quá ngắn. Vui lòng giữ micro và phát âm rõ ràng.';

  @override
  String get audioBufferWasEmptyPleaseCheckYourM =>
      'Dữ liệu âm thanh trống. Vui lòng kiểm tra lại micro và thử lại.';

  @override
  String get audioFileIsSilentPleaseSpeakIntoThe =>
      'Tệp âm thanh không có tiếng. Vui lòng nói trực tiếp vào micro.';

  @override
  String get weCouldntUnderstandYourPronunciatio =>
      'Chưa nhận diện được phát âm của bạn. Vui lòng nói rõ ràng và thử lại.';

  @override
  String get theServerIsTakingTooLongToRespondPl =>
      'Máy chủ phản hồi lâu hơn bình thường. Vui lòng thử lại.';

  @override
  String get noInternetConnectionPleaseCheckYour =>
      'Không có kết nối mạng. Vui lòng kiểm tra đường truyền và thử lại.';

  @override
  String get audioProcessingFailedPleaseTryAgain =>
      'Xử lý âm thanh thất bại. Vui lòng thử lại.';

  @override
  String get permission => 'Quyền truy cập';

  @override
  String get couldNotProcessYourRecordingPleaseT =>
      'Không thể xử lý bản ghi âm của bạn. Vui lòng thử lại.';

  @override
  String get user => 'Người dùng';

  @override
  String get scholar => 'Học giả';

  @override
  String get ourAiTutorsAreCurrentlyOfflinePleas =>
      'Gia sư AI hiện đang ngoại tuyến. Vui lòng quay lại sau.';

  @override
  String get hideTranslation => 'Ẩn bản dịch';

  @override
  String get azureAssessment => 'Đang đánh giá phát âm Azure...';

  @override
  String get microphonePermissionRequired => 'Cần cấp quyền truy cập micro';

  @override
  String get connectedSpeakNow => 'Đã kết nối! Bạn có thể nói ngay bây giờ.';

  @override
  String get initializationErrorCheckPermissions =>
      'Lỗi khởi tạo. Vui lòng kiểm tra các quyền đã cấp.';

  @override
  String get microphoneErrorTapToRetry => 'Lỗi micro. Chạm để thử lại.';

  @override
  String get theTutorReturnedAnEmptyResponse =>
      'Gia sư không phản hồi nội dung.';

  @override
  String get connectionInterruptedPleaseSpeakAga =>
      'Kết nối bị gián đoạn. Vui lòng phát âm lại.';

  @override
  String get callPausedReviewingTones =>
      'Cuộc gọi tạm dừng (Đang xem xét thanh điệu)';

  @override
  String get pausedTakeABreak => 'Tạm dừng - Hãy nghỉ ngơi đôi chút';

  @override
  String get goodStartPracticing => 'Khởi đầu luyện tập rất tốt!';

  @override
  String get studentCoach => 'Học viên / Huấn luyện viên';

  @override
  String get keepYour1stToneHighAndSteadyOn =>
      'Giữ thanh 1 cao và phẳng đều ở âm';

  @override
  String get noScenariosFound => 'Không tìm thấy tình huống nào.';

  @override
  String get designYourOwnAiRoleplayExperience =>
      'Tự thiết kế tình huống nhập vai cùng AI';

  @override
  String get generateFromDeck => 'Tạo từ bộ thẻ học';

  @override
  String get practiceFlashcardVocabularyInALiveD =>
      'Luyện từ vựng trong bộ thẻ qua hội thoại thực tế';

  @override
  String get tapToRoleplay => 'Chạm để bắt đầu nhập vai';

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
  String get dinnerWithDad => 'Bữa tối ấm cúng cùng bố';

  @override
  String get orderingAtAChengduTeahouse =>
      'Gọi trà tại quán trà truyền thống Thành Đô';

  @override
  String get buyingTeaAtTheMarket => 'Mua trà tại chợ truyền thống';

  @override
  String get meetingAnOldClassmate => 'Hội ngộ bạn học cũ';

  @override
  String get readyToPractice => 'Bạn đã sẵn sàng luyện tập chưa?';

  @override
  String get letsPracticeChinese => 'Cùng luyện nói tiếng Trung nào';

  @override
  String get areYouReady => 'Bạn đã sẵn sàng chưa?';

  @override
  String get discussWhatToHaveForDinner => 'Bàn luận xem tối nay ăn món gì';

  @override
  String get suggestWatchingAMovieAfterwards => 'Gợi ý đi xem phim sau bữa ăn';

  @override
  String get askIfTheyWouldLikeTea =>
      'Hỏi xem đối phương có muốn dùng trà không';

  @override
  String get helloVeryNiceToMeetYou =>
      'Xin chào! Rất vui được làm quen với bạn.';

  @override
  String get deckPractice => 'Luyện tập theo bộ thẻ';

  @override
  String get practiceVocabularyWithAnAiPartner =>
      'Luyện từ vựng đàm thoại cùng bạn học AI.';

  @override
  String get designCustomAiRoleplayConversation =>
      'Thiết kế tình huống và đối thoại nhập vai AI tùy chỉnh';

  @override
  String get random => 'Ngẫu nhiên';

  @override
  String get scenarioTopic => 'Chủ đề tình huống';

  @override
  String get contextSettingOptional => 'Bối cảnh & Không gian (Tùy chọn)';

  @override
  String get aiCharacterPersonaOptional =>
      'Vai diễn / Tính cách của AI (Tùy chọn)';

  @override
  String get aQuietBambooCourtyardTeahouseInChen =>
      'Một quán trà sân vườn tre thanh tịnh ở Thành Đô, văng vẳng tiếng đàn tranh guzheng êm dịu.';

  @override
  String get aBustlingSmokyNightMarketFilledWith =>
      'Chợ đêm nhộn nhịp khói tỏa nghi ngút với xiên nướng, bánh bao nóng hổi và món ăn đường phố.';

  @override
  String get aLivelyHotpotRestaurantInChongqingW =>
      'Quán lẩu Trùng Khánh sôi động với nồi nước dùng đỏ rực sùng sục và thơm nồng hương ớt hoa tiêu.';

  @override
  String get aBustlingTraditionalCantoneseTeahou =>
      'Quán trà dim sum truyền thống Quảng Châu tấp nập với những xửng tre nghi ngút khói thơm.';

  @override
  String get aChicMinimalistCafeInTheFrenchConce =>
      'Quán cà phê tối giản thanh lịch tại Khu Tô giới Pháp vào một chiều Chủ nhật mưa bay.';

  @override
  String get aWarmNorthernHomeKitchenDuringWinte =>
      'Căn bếp gia đình miền Bắc ấm cúng mùa đông, vương bột mì trên bàn và nồi sủi cảo bốc khói.';

  @override
  String get anOpenairNightStreetFoodAlleyWithSi =>
      'Hẻm ẩm thực đêm ngoài trời với xiên thịt cừu nướng xèo xèo, cà tím nướng tỏi và bia mát lạnh.';

  @override
  String get aSnowyStreetCornerOutsideTheLamaTem =>
      'Góc phố tuyết rơi ngoài cổng Ung Hòa Cung (Chùa Lạt Ma) với những xiên kẹo hồ lô đỏ bóng trên đá.';

  @override
  String get craftBeerBreweryInQingdao => 'Xưởng bia thủ công tại Thanh Đảo';

  @override
  String get aLivelyCoastalTaproomWithWoodenBarr =>
      'Quán bia ven biển sôi động với thùng gỗ sồi, gió biển mát lành và vòi rót bia lúa mì tươi.';

  @override
  String get sichuanCookingMasterclass => 'Lớp học nấu món Tứ Xuyên chuyên sâu';

  @override
  String get aVibrantOpenKitchenWithWoksBlazingC =>
      'Gian bếp mở rực lửa với chảo wok bốc khói, dầu ớt sùng sục và hạt hoa tiêu tươi thơm nồng.';

  @override
  String get highspeedRailSeatMixup => 'Nhầm chỗ ngồi trên tàu cao tốc';

  @override
  String get greatWallSunriseTrekInMutianyu =>
      'Trekking ngắm bình minh trên Vạn Lý Trường Thành tại Mộ Điền Dục';

  @override
  String get theAncientStoneRampartsOfTheGreatWa =>
      'Những bức tường thành cổ kính của Vạn Lý Trường Thành lúc bình minh giữa núi non xanh mờ sương.';

  @override
  String get bambooRaftDriftOnGuilinLiRiver =>
      'Du ngoạn bè tre trên dòng sông Ly Giang ở Quế Lâm';

  @override
  String get glidingAlongEmeraldKarstWatersBetwe =>
      'Lướt nhẹ trên dòng nước ngọc bích giữa những rặng núi đá vôi karst kỳ vĩ gần Dương Sóc.';

  @override
  String get silkRoadCamelTrekInDunhuang =>
      'Cưỡi lạc đà khám phá Con đường Tơ lụa ở Đôn Hoàng';

  @override
  String get theRollingGoldenSandDunesOfMingshaM =>
      'Những đồi cát vàng óng ả nhấp nhô của Núi Minh Sa bên cạnh ốc đảo Hồ Bán Nguyệt (Nguyệt Nha Tuyền).';

  @override
  String get bookingACourtyardHomestayInDali =>
      'Đặt phòng homestay tứ hợp viện truyền thống tại Đại Lý';

  @override
  String get aSereneBaistyleBoutiqueCourtyardHot =>
      'Khách sạn boutique sân vườn mang phong cách người Bạch yên bình nhìn ra Hồ Nhĩ Hải ở Vân Nam.';

  @override
  String get potalaPalacePilgrimageInLhasa =>
      'Hành hương chiêm bái Cung điện Potala ở Lhasa';

  @override
  String get theMajesticSundrenchedStoneStepsOut =>
      'Những bậc thang đá uy nghiêm ngập tràn ánh nắng ngoài Cung điện Potala cùng bánh xe cầu nguyện luân chuyển.';

  @override
  String get aSubzeroWonderlandOfIlluminatedCrys =>
      'Xứ sở băng tuyết kỳ ảo dưới 0 độ với cung điện băng lung linh ánh đèn và những bức tượng tuyết khổng lồ.';

  @override
  String get zhangjiajieAvatarMountainCableCar =>
      'Cáp treo dãy núi Avatar Trương Gia Giới';

  @override
  String get suspendedHighInAGlassCableCarSoarin =>
      'Treo mình trên cáp treo đáy kính, lướt qua hàng ngàn cột đá sa thạch kỳ vĩ.';

  @override
  String get gobiDesertStargazingCampInGansu =>
      'Cắm trại ngắm sao trên sa mạc Gobi ở Cam Túc';

  @override
  String get aLuxuryYurtCampUnderACrystalclearMi =>
      'Khu lều yurt sang trọng dưới bầu trời đêm dải Ngân Hà trong vắt giữa sa mạc ngoài Gia Dục Quan.';

  @override
  String get yangtzeRiverThreeGorgesCruise =>
      'Du thuyền Tam Hiệp trên sông Dương Tử';

  @override
  String get onTheSunDeckOfARiverCruiseShipPassi =>
      'Trên boong tắm nắng của du thuyền xuôi dòng qua hẻm núi Cù Đường Hiệp hiểm trở và hùng vĩ.';

  @override
  String get buyingAntiquesInBeijingPanjiayuan =>
      'Mua sắm đồ cổ tại Phan Gia Viên, Bắc Kinh';

  @override
  String get aHistoricPotteryKilnFilledWithDelic =>
      'Lò gốm cổ kính chứa đầy những bình sứ mộc tinh xảo và men lam cô-ban.';

  @override
  String get suzhouSilkEmbroideryStudio => 'Xưởng thêu tơ lụa Tô Châu';

  @override
  String get aPeacefulCanalsideGardenStudioInSuz =>
      'Xưởng thêu sân vườn thanh bình bên bờ kênh Tô Châu với những sợi tơ óng ả và khung thêu gỗ.';

  @override
  String get backstageAtATraditionalBeijingOpera =>
      'Hậu trường rực rỡ của nhà hát Kinh kịch với trang phục lộng lẫy, gương trang điểm và mũ mão.';

  @override
  String get traditionalChineseMedicineConsultat =>
      'Tư vấn và khám chữa bệnh Đông y';

  @override
  String get morningTaiChiInTempleOfHeavenPark =>
      'Tập Thái Cực Quyền buổi sớm tại Công viên Thiên Đàn';

  @override
  String get beneathAncientCypressTreesAtDawnWit =>
      'Dưới bóng bách cổ thụ lúc rạng đông, hòa cùng tiếng chim hót và các bậc cao niên múa quyền nhịp nhàng.';

  @override
  String get rentingAHanfuForAPhotoShoot =>
      'Thuê trang phục Hán phục để chụp ảnh kỷ niệm';

  @override
  String get aTraditionalCostumeBoutiqueNearTheW =>
      'Tiệm cổ phục bên bờ Tây Hồ với những giá treo đầy áo choàng thời Đường và Tống.';

  @override
  String get guqinAncientZitherInstrumentWorksho =>
      'Xưởng đàm đạo và chế tác đàn Cổ Cầm (Guqin)';

  @override
  String get aQuietPinewoodStudioInHangzhouFille =>
      'Không gian gỗ thông tĩnh lặng tại Hàng Châu, thơm mùi gỗ ngô đồng lâu năm và dây tơ óng mượt.';

  @override
  String get shaanxiShadowPuppetTheater =>
      'Nhà hát múa rối bóng da (Bì ảnh hí) Thiểm Tây';

  @override
  String get behindAnIlluminatedWhiteSilkScreenW =>
      'Phía sau tấm màn lụa trắng rực sáng, nơi những con rối da trong suốt chuyển động sống động.';

  @override
  String get chineseCalligraphyWorkshop => 'Xưởng thực hành thư pháp Trung Hoa';

  @override
  String get aTranquilStudioScentedWithPineSootI =>
      'Thư phòng thanh tịnh đượm hương mực thông, cuộn giấy xuyến chỉ và thoang thoảng vị trà.';

  @override
  String get adoptingACatAtAnAnimalShelter =>
      'Nhận nuôi mèo tại trạm cứu hộ động vật';

  @override
  String get aCozyPetRescueCenterInHangzhouWithE =>
      'Trạm cứu hộ thú cưng ấm áp ở Hàng Châu với những chú mèo con tinh nghịch và trà ấm mời khách.';

  @override
  String get scriptMurderMysteryJubenshaGame =>
      'Trò chơi nhập vai phá án theo kịch bản (Jubensha / 剧本杀)';

  @override
  String get aThemedDetectiveLoungeInShanghaiWit =>
      'Phòng trinh thám theo chủ đề ở Thượng Hải với người chơi hóa trang bên ánh nến lung linh.';

  @override
  String get vintageVinylRecordShopInShanghai =>
      'Tiệm đĩa than cổ điển tại Thượng Hải';

  @override
  String get aHiddenVinylStoreInAnOldLaneHousePa =>
      'Tiệm đĩa than ẩn mình trong ngõ hẻm shikumen cổ kính, đầy ắp đĩa Cantopop và Jazz thập niên 80.';

  @override
  String get ktvKaraokePartyWithFriends =>
      'Hát karaoke KTV tưng bừng cùng bạn bè';

  @override
  String get joiningACityBikeCyclingClub =>
      'Tham gia câu lạc bộ đạp xe dạo phố';

  @override
  String get aGatheringOfCyclistsByTheRiverfront =>
      'Nhóm bạn yêu xe đạp tụ họp ven bờ sông chuẩn bị cho chuyến đạp xe đêm ngắm toàn cảnh thành phố.';

  @override
  String get blindBoxToyTradingMeetup =>
      'Buổi giao lưu trao đổi đồ chơi hộp mù (Blind Box)';

  @override
  String get aColorfulPopcultureToyStoreInChaoya =>
      'Cửa hàng đồ chơi pop-culture rực rỡ ở Triều Dương với kệ trưng bày đầy hộp sưu tầm.';

  @override
  String get droneSkylineVideographyAtTheBund =>
      'Quay phim toàn cảnh bằng flycam tại Bến Thượng Hải';

  @override
  String get theBundPromenadeAtDuskOverlookingTh =>
      'Đại lộ Bến Thượng Hải lúc hoàng hôn phóng tầm mắt sang những tòa tháp chọc trời rực rỡ của Phố Đông.';

  @override
  String get goldenRetrieverCafeInNanjing =>
      'Quán cà phê cún Golden Retriever ở Nam Kinh';

  @override
  String get aSunnyCheerfulPetCafeWithDozensOfFr =>
      'Quán cà phê thú cưng ngập nắng, nơi hàng chục chú cún lông xù thân thiện vẫy đuôi đón khách.';

  @override
  String get boulderingClimbingGymInChengdu =>
      'Phòng tập leo núi trong nhà (Bouldering) tại Thành Đô';

  @override
  String get aModernIndoorClimbingGymWithVibrant =>
      'Khu leo núi hiện đại trong nhà với những mấu bám rực rỡ sắc màu và âm nhạc sôi động.';

  @override
  String get aMassiveConventionHallFilledWithCol =>
      'Hội trường triển lãm quy mô lớn tràn ngập gian hàng game, góc check-in và các cosplayer.';

  @override
  String get askingForDirectionsInABeijingHutong =>
      'Hỏi đường trong ngõ ngách Hutong ở Bắc Kinh';

  @override
  String get aMazeOfHistoricGreybrickAlleysWithB =>
      'Mê cung ngõ nhỏ gạch xám lịch sử với xe đạp dựng bên thềm, sân trong và cây lựu trĩu quả.';

  @override
  String get buyingFreshFruitAtAWetMarket =>
      'Mua trái cây tươi tại chợ truyền thống';

  @override
  String get aLivelyMorningNeighborhoodMarketWit =>
      'Khu chợ dân sinh buổi sớm nhộn nhịp với những sạp vải thiều tươi, xoài chín và thanh long ruột đỏ.';

  @override
  String get flowerMarketBouquetInKunming => 'Bó hoa tươi tại chợ hoa Côn Minh';

  @override
  String get theFamousDounanFlowerMarketSurround =>
      'Chợ hoa Đấu Nam nổi tiếng ngập tràn hương sắc giữa hàng triệu cành hoa hồng, hoa ly và khuynh diệp.';

  @override
  String get tailorAlterationsInAnOldLaneHouse =>
      'Sửa trang phục tại tiệm may ngõ cổ';

  @override
  String get aTraditionalTailorShopFilledWithSew =>
      'Tiệm may đo truyền thống đầy ắp máy may, súc vải lụa và thước dây.';

  @override
  String get expressParcelLockerRetrieval =>
      'Nhận bưu kiện tại tủ khóa thông minh (Hive Box)';

  @override
  String get downstairsAtAResidentialApartmentGa =>
      'Dưới chân cổng khu chung cư, ngay bên cạnh hệ thống tủ gửi đồ thông minh Hive Box.';

  @override
  String get bicycleFlatTireRepairAtCampusGate =>
      'Vá săm xe đạp trước cổng trường đại học';

  @override
  String get aSmallOutdoorRoadsideToolkitStandUn =>
      'Góc sửa xe ven đường bình dị dưới bóng mát của cây đa cổ thụ.';

  @override
  String get techCompanyProductDemo =>
      'Buổi demo giới thiệu sản phẩm công nghệ';

  @override
  String get aFuturisticTechConferenceBoothInShe =>
      'Gian hàng công nghệ tương lai tại hội nghị Thâm Quyến trình diễn phần cứng AI tiên tiến.';

  @override
  String get ecommerceLivestreamStudio =>
      'Phòng livestream bán hàng thương mại điện tử';

  @override
  String get aHighenergyBroadcastStudioWithRingL =>
      'Trường quay livestream sôi động với đèn tròn ring light, kệ hàng mẫu và màn hình bình luận trực tiếp.';

  @override
  String get yiwuInternationalTradeMarket =>
      'Chợ đầu mối Thương mại Quốc tế Nghĩa Ô (Yiwu)';

  @override
  String get aVastMultistoryCommercialExhibition =>
      'Trung tâm thương mại bán buôn nhiều tầng rộng lớn với hàng triệu mặt hàng và đồ thủ công mỹ nghệ.';

  @override
  String get universityCampusExchangeProgram =>
      'Chương trình trao đổi sinh viên tại khuôn viên đại học';

  @override
  String get aSunnyLawnOutsideTheUniversityLibra =>
      'Bãi cỏ ngập nắng trước thư viện trường đại học nơi sinh viên tụ họp học bài và uống trà sữa.';

  @override
  String get pleaseEnterAScenarioTopic => 'Vui lòng nhập chủ đề tình huống.';

  @override
  String get nameTitle => 'Tên (Danh xưng)';

  @override
  String get aiCharacter => 'Nhân vật AI';

  @override
  String get helloWelcomeHereWhatShallWeChatAbou =>
      'Xin chào! Rất vui được đón tiếp bạn. Hôm nay chúng ta sẽ trò chuyện về chủ đề gì?';

  @override
  String get greetYourConversationPartner => 'Chào hỏi bạn đối thoại';

  @override
  String get askAQuestionInChinese => 'Đặt một câu hỏi bằng tiếng Trung';

  @override
  String get pinyinWithToneMarks => 'Pinyin có đầy đủ dấu thanh điệu';

  @override
  String get goal1InEnglish => 'Mục tiêu 1 (tiếng Việt)';

  @override
  String get goal2InEnglish => 'Mục tiêu 2 (tiếng Việt)';

  @override
  String get goal3InEnglish => 'Mục tiêu 3 (tiếng Việt)';

  @override
  String get beginner => 'Sơ cấp';

  @override
  String get hsk12 => 'HSK 1-2';

  @override
  String get hsk34 => 'HSK 3-4';

  @override
  String get hsk56 => 'HSK 5-6';

  @override
  String get master => 'Thành thạo';

  @override
  String get azurePronunciationAssessment => 'HỆ THỐNG ĐÁNH GIÁ PHÁT ÂM AZURE';

  @override
  String get tapToReview => 'Chạm để xem lại';

  @override
  String get overallScore => 'Điểm tổng thể';

  @override
  String get toneAccuracy => 'Độ chuẩn xác thanh điệu';

  @override
  String get fluency => 'Độ lưu loát';

  @override
  String get report => 'Báo cáo chi tiết';

  @override
  String get goodPronunciationButCanBeBetter =>
      'Phát âm khá tốt, nhưng vẫn có thể trau chuốt hơn nữa!';

  @override
  String get didYouMeanToSay => 'Có phải bạn muốn nói...?';

  @override
  String get greatKeepTrying => 'Rất tốt! Hãy tiếp tục rèn luyện nhé!';

  @override
  String get completeness => 'Độ hoàn chỉnh';

  @override
  String get targetTone => 'Thanh điệu chuẩn';

  @override
  String get k4toneComparisonTapToListen =>
      'So sánh 4 thanh điệu (Chạm để nghe mẫu):';

  @override
  String get youSpokeMatch => 'Bạn đã phát âm (Chuẩn xác!)';

  @override
  String get youSpoke => 'Bạn đã phát âm';

  @override
  String get yourPrimaryCollectionOfCharacters =>
      'Bộ sưu tập chữ Hán nền tảng của bạn.';

  @override
  String get deckNotFound => 'Không tìm thấy bộ thẻ';

  @override
  String get cannotDeleteTheDefaultDeck => 'Không thể xóa bộ thẻ mặc định';

  @override
  String get hsk4UpperIntermediate1 => 'HSK 4: Trung cấp cao';

  @override
  String get theFirst150CharactersToStartYourJou =>
      '150 chữ Hán đầu tiên để bắt đầu hành trình chinh phục tiếng Trung.';

  @override
  String get buildYourVocabularyTo300EssentialWo =>
      'Mở rộng vốn từ vựng với 300 từ ngữ thiết yếu.';

  @override
  String get masterConversationalFluencyWith600W =>
      'Làm chủ giao tiếp trôi chảy với 600 từ vựng căn bản.';

  @override
  String get readTextsAndConverseFluentlyWith120 =>
      'Đọc hiểu văn bản và đối thoại lưu loát với 1.200 từ vựng.';

  @override
  String get readNewspapersAndWatchMoviesWith250 =>
      'Đọc báo và thưởng thức phim ảnh thoải mái với 2.500 từ vựng.';

  @override
  String get databaseBoxNotOpen => 'Cơ sở dữ liệu chưa mở';

  @override
  String get hsk1DataFileIsEmpty => 'Tệp dữ liệu HSK 1 đang trống';

  @override
  String get gold => 'Vàng';

  @override
  String get globalDictionaryNotInitialized =>
      'Từ điển toàn cục chưa được khởi tạo';

  @override
  String get reading => 'Đọc hiểu';

  @override
  String get recall => 'Hồi tưởng';

  @override
  String get speaking => 'Khẩu ngữ';

  @override
  String get listening1 => 'Luyện nghe';

  @override
  String get practiceStrokeOrderWithVisualGuides =>
      'Luyện thứ tự nét bút với hướng dẫn trực quan.';

  @override
  String get seeTheCharacterRecallThePinyinAndMe =>
      'Nhìn chữ Hán, nhớ lại Pinyin và ý nghĩa.';

  @override
  String get seeTheMeaningDrawTheCharacterFromMe =>
      'Nhìn ý nghĩa, tự tay viết chữ Hán từ trí nhớ.';

  @override
  String get readOutLoudToTestYourPronunciationT =>
      'Đọc to để kiểm tra độ chuẩn xác của thanh điệu và phát âm.';

  @override
  String get listenToTheAudioAndIdentifyTheChara =>
      'Lắng nghe âm thanh và chọn đúng chữ Hán tương ứng.';

  @override
  String get contract => 'Đặc tả giao diện';

  @override
  String get whoeverImplementsMeMustBeAbleToDoTh =>
      'Bất kỳ lớp nào triển khai interface này BẮT BUỘC phải hỗ trợ các thao tác sau.';

  @override
  String get koreFenrirCharonAoedePuckOrLocal =>
      'Kore, Fenrir, Charon, Aoede, Puck hoặc giọng đọc thiết bị';

  @override
  String get manageDecks => 'Quản lý bộ thẻ';

  @override
  String get weRanIntoTroubleLoadingTheLibraryPl =>
      'Gặp sự cố khi tải thư viện. Vui lòng thử lại.';

  @override
  String get noCharactersInLexicon1 => 'Chưa có chữ Hán nào trong vốn từ vựng';

  @override
  String get masterTheBuildingBlocks => 'Nắm vững các bộ thủ căn bản';

  @override
  String get other => 'Khác';

  @override
  String get required => 'Bắt buộc';

  @override
  String get library1 => 'Thư viện';

  @override
  String get youAreAPremiumMember => 'Bạn là thành viên Premium';

  @override
  String get createAccountToSyncProgress =>
      'Tạo tài khoản để đồng bộ tiến độ học tập';

  @override
  String get signOut => 'Đăng xuất';

  @override
  String get account => 'Tài khoản';

  @override
  String get guestScholar => 'Học giả Khách';

  @override
  String get localAccount => 'Tài khoản cục bộ';

  @override
  String get unknownRadical => 'Bộ thủ chưa phân loại';

  @override
  String get followTheGuideStroke => 'Viết theo nét hướng dẫn';

  @override
  String get strokeAnimationSpeed => 'Tốc độ hoạt ảnh nét bút';

  @override
  String get notifications => 'Thông báo';

  @override
  String get deutsch => 'Tiếng Đức';

  @override
  String get bahasaIndonesia => 'Tiếng Indonesia';

  @override
  String get italiano => 'Tiếng Ý';

  @override
  String get today1d2d3d4d5d6d =>
      'Hôm nay, 1 ngày, 2 ngày, 3 ngày, 4 ngày, 5 ngày, 6 ngày';

  @override
  String get targetDeck => 'Bộ thẻ đích';

  @override
  String get mixed => 'Hỗn hợp';

  @override
  String get topicForContext => 'Chủ đề (để tạo ngữ cảnh)';

  @override
  String get nounsOnly => 'Chỉ danh từ';

  @override
  String get verbsOnly => 'Chỉ động từ';

  @override
  String get idiomsChengyu => 'Thành ngữ (Thành ngữ 4 chữ / Chengyu)';

  @override
  String get fullSentences => 'Câu hoàn chỉnh';

  @override
  String get beginnerHsk12 => 'Sơ cấp (HSK 1-2)';

  @override
  String get intermediateHsk34 => 'Trung cấp (HSK 3-4)';

  @override
  String get advancedHsk56 => 'Cao cấp (HSK 5-6)';

  @override
  String get generatedByAi => 'Do AI tạo';

  @override
  String get canYouGiveMeTwoMoreExamplesUsingThi =>
      'Bạn có thể cho tôi thêm hai câu ví dụ sử dụng từ này không?';

  @override
  String get whatAreSomeSimilarWordsAndHowDoThey =>
      'Có những từ nào đồng nghĩa hoặc gần nghĩa và sắc thái khác nhau ra sao?';

  @override
  String get isThisWordUsedInSpokenOrWrittenChin =>
      'Từ này thường dùng trong văn nói hay văn viết nhiều hơn?';

  @override
  String get areThereOtherWaysToTranslateThisWor =>
      'Còn cách nào khác để dịch từ này không?';

  @override
  String get whatAreCommonWordsThatGoTogetherWit =>
      'Những từ nào thường đi kèm (kết hợp từ) với từ này?';

  @override
  String get whatAreCommonMistakesLearnersMakeWi =>
      'Những lỗi sai phổ biến mà người học hay mắc phải với từ này là gì?';

  @override
  String get emptyResponse => 'Phản hồi trống';

  @override
  String get whatIsTheOracleBoneScriptOriginOfTh =>
      'Nguồn gốc giáp cốt văn của chữ Hán này bắt nguồn từ đâu?';

  @override
  String get howDidTheAncientFormOfThisCharacter =>
      'Hình thể cổ xưa của chữ Hán này đã biến đổi và phát triển ra sao qua các thời kỳ?';

  @override
  String get giveMe3CommonWordsThatContainThisCh =>
      'Hãy cho tôi 3 từ ghép thông dụng có chứa chữ Hán này.';

  @override
  String get whatOtherCharactersShareTheSameRadi =>
      'Những chữ Hán nào khác có chung bộ thủ này?';

  @override
  String get isThereAChineseProverbOrSayingFeatu =>
      'Có câu tục ngữ, thành ngữ hay danh ngôn tiếng Trung nào chứa chữ Hán này không?';

  @override
  String get explainTheStrokeOrderRulesForThisCh =>
      'Giải thích quy tắc thứ tự nét viết (thuận bút) cho chữ Hán này.';

  @override
  String get giveMeOneCalligraphyTipForWritingTh =>
      'Cho tôi một mẹo thư pháp để viết chữ Hán này thật cân đối và đẹp mắt.';

  @override
  String get isThereAnythingTrickyAboutUsingThis =>
      'Có điểm ngữ pháp đặc biệt hay bẫy nào cần lưu ý khi dùng từ này không?';

  @override
  String get whatWordsAreCommonlyConfusedWithThi =>
      'Những từ nào dễ bị nhầm lẫn với từ này và lý do tại sao?';

  @override
  String get doesThisCharacterCarryCulturalSymbo =>
      'Chữ Hán này có mang ý nghĩa biểu tượng văn hóa đặc biệt nào ở Trung Quốc không?';

  @override
  String get isThisCharacterCommonlySeenInChines =>
      'Chữ Hán này có thường xuất hiện trong phim ảnh, bài hát hay văn học hiện đại không?';

  @override
  String get whatDoesTheRadicalOfThisCharacterMe =>
      'Bộ thủ của chữ Hán này biểu thị ý nghĩa gì?';

  @override
  String get breakDownEveryComponentAndItsMeanin =>
      'Hãy chiết tự từng thành phần cấu tạo và giải nghĩa chi tiết.';

  @override
  String get giveMeATrickToRememberTheCorrectTon =>
      'Hãy mách tôi một mẹo ghi nhớ thanh điệu chuẩn xác của chữ Hán này.';

  @override
  String get areThereCommonHomophonesThatAreOfte =>
      'Có những từ đồng âm nào dễ gây nhầm lẫn với chữ này không?';

  @override
  String get quotaExceeded => 'Đã vượt quá hạn mức sử dụng';

  @override
  String get mustProvideEitherCardOrCards =>
      'Cần cung cấp một thẻ hoặc danh sách các thẻ';

  @override
  String get deckSettings => 'Cài đặt bộ thẻ';

  @override
  String get saveSettings => 'Lưu cài đặt';

  @override
  String get sealRed => 'Đỏ chu sa (Ấn triện)';

  @override
  String get sealScript => 'Chữ Triện (Triện thư)';

  @override
  String get startYourStreak => 'BẮT ĐẦU CHUỖI HỌC TẬP';

  @override
  String get traditionalCharacter => 'Chữ Phồn thể';

  @override
  String get inQueue => 'Trong hàng đợi ôn tập';

  @override
  String get tapToListenAgain => 'Chạm để nghe lại';

  @override
  String get contextClue => 'Manh mối ngữ cảnh';

  @override
  String get microphonePermissionRequired1 => 'Cần cấp quyền truy cập micro.';

  @override
  String get recordingFailedNoFile =>
      'Ghi âm thất bại (Không tạo được tệp âm thanh).';

  @override
  String get holdToSpeakOptional => 'Nhấn giữ để nói (Tùy chọn)';

  @override
  String get microphonePermissionDeniedEnableItI =>
      'Quyền micro bị từ chối. Vui lòng bật quyền trong phần Cài đặt để sử dụng Phòng luyện Shadowing.';

  @override
  String get sessionSummary => 'Tổng kết phiên học';

  @override
  String get hereAreTheCharactersYouStruggledWit =>
      'Dưới đây là những chữ Hán bạn cần chú ý luyện tập thêm:';

  @override
  String get applySessionGradesToSpacedRepetitio =>
      'Áp dụng kết quả phiên học vào hệ thống Lặp lại ngắt quãng (Chế độ Nói)';

  @override
  String get masterYourMandarinPronunciationnbyM =>
      'Làm chủ phát âm tiếng Quan thoại chuẩn xác\nbằng cách nhại giọng người bản xứ.';

  @override
  String get aiIsGradingYourPronunciation =>
      'AI đang phân tích và chấm điểm phát âm...';

  @override
  String get holdMicToRecordReleaseToGrade =>
      'Nhấn giữ micro để ghi âm. Thả tay ra để chấm điểm.';

  @override
  String get tapAnySyllableToAuditionAll4Tones =>
      'Chạm vào âm tiết bất kỳ để nghe mẫu cả 4 thanh điệu:';

  @override
  String get freeFlowConversationalPractice => 'Thực hành đàm thoại tự do.';

  @override
  String get failedToGeneratePhrasePleaseTryAgai =>
      'Không thể tạo mẫu câu. Vui lòng thử lại.';

  @override
  String get recordingTooShortHoldTheMicButtonLo =>
      'Bản ghi âm quá ngắn. Vui lòng giữ nút micro lâu hơn.';

  @override
  String get recordingErrorPleaseTryAgain => 'Lỗi ghi âm. Vui lòng thử lại.';

  @override
  String get noRecordingCapturedPleaseTryAgain =>
      'Chưa thu được giọng nói. Vui lòng thử lại.';

  @override
  String get recordedAudioIsEmptyPleaseTryAgainA =>
      'Tệp ghi âm không có âm thanh. Vui lòng nói rõ ràng vào micro.';

  @override
  String get azureSpeechApiKeysAreMissing1 => 'Thiếu khóa API Azure Speech';

  @override
  String get azureError401 => 'Lỗi xác thực Azure 401';

  @override
  String get azureAuthenticationFailedCheckYourS =>
      'Xác thực Azure thất bại. Kiểm tra khóa Speech API và khu vực (region) trong tệp .env';

  @override
  String get azureError429 => 'Lỗi giới hạn Azure 429';

  @override
  String get azureQuotaExceededTryAgainLater =>
      'Hạn mức API Azure đã hết. Vui lòng thử lại sau.';

  @override
  String get azureGradingTimedOutCheckYourIntern =>
      'Đánh giá Azure bị quá thời gian. Vui lòng kiểm tra kết nối internet.';

  @override
  String get recognitionFailedNull => 'Nhận diện thất bại: null';

  @override
  String get couldNotHearYouClearlyPleaseTryAgai =>
      'Không thể nghe rõ phát âm. Vui lòng thử lại.';

  @override
  String get singlePhrasePractice => 'Luyện phát âm câu đơn';

  @override
  String get failedToGeneratePhrase => 'Không thể tạo câu';

  @override
  String get omitted => 'Bỏ sót';

  @override
  String get partial => 'Khớp một phần';

  @override
  String get mispronounced => 'Phát âm sai';

  @override
  String get startSession1 => 'Bắt đầu phiên học';

  @override
  String get chinese => 'Tiếng Trung';

  @override
  String get paused => 'Đang tạm dừng';

  @override
  String get translationFailed => 'Dịch thất bại';

  @override
  String get engagingMacroeconomicAndBusinessBre =>
      'Phân tích kinh tế vĩ mô và kinh doanh sâu sắc được truyền tải qua lối kể chuyện sống động.';

  @override
  String get exploresWorldEconomiesBankingHistor =>
      'Khám phá các nền kinh tế thế giới, lịch sử ngành ngân hàng và động lực phát triển toàn cầu.';

  @override
  String get clearArticulateMandarinPerfectForIn =>
      'Tiếng Trung chuẩn xác, phát âm rõ ràng, lý tưởng cho người học trung cấp và cao cấp rèn luyện kỹ năng nghe.';

  @override
  String get chefWang => 'Đầu bếp Vương Cương (Chef Wang)';

  @override
  String get masterSichuanCulinaryTechniquesTaug =>
      'Nắm vững kỹ thuật ẩm thực Tứ Xuyên chính thống được truyền dạy trực tiếp từ đầu bếp chuyên nghiệp.';

  @override
  String get stepbystepAuthenticChineseRecipesWi =>
      'Công thức nấu ăn Trung Hoa chuẩn vị từng bước với kỹ thuật điều khiển lửa chảo và dùng dao điêu luyện.';

  @override
  String get conciseCulinaryVocabularyAndClearIn =>
      'Từ vựng ẩm thực cô đọng cùng hướng dẫn rõ ràng bằng tiếng Trung tự nhiên.';

  @override
  String get cinematographyCuttingedgeCameraTech =>
      'Nghệ thuật quay phim, công nghệ máy quay tối tân và đánh giá truyền thông số chuyên sâu.';

  @override
  String get highproductionDocumentaryStyleExplo =>
      'Phong cách phim tài liệu chất lượng cao khám phá sáng tạo video và đột phá công nghệ AI.';

  @override
  String get richTechnicalMandarinWithCrystalcle =>
      'Vốn từ vựng công nghệ phong phú với phát âm chuẩn xác và phụ đề trực quan.';

  @override
  String get indepthInvestigativeJournalismAndCu =>
      'Báo chí điều tra chuyên sâu và bình luận sắc sảo về các sự kiện thời sự nổi bật.';

  @override
  String get criticalPerspectivesOnSocialPhenome =>
      'Góc nhìn phản biện đa chiều về các hiện tượng xã hội, tin tức quốc tế và lịch sử.';

  @override
  String get formalInvestigativeDiscourseIdealFo =>
      'Văn phong học thuật, chính luận trang trọng, lý tưởng để nâng cao kỹ năng nghe hiểu nâng cao.';

  @override
  String get bitesizedAnimatedScienceDocumentari =>
      'Phim tài liệu khoa học hoạt hình ngắn gọn, giải đáp thú vị các thắc mắc đời thường.';

  @override
  String get exploresPhysicsBiologyAndEverydayCu =>
      'Khám phá vật lý, sinh học và những điều kỳ thú quanh ta qua các hình ảnh đồ họa sinh động.';

  @override
  String get standardBeijingMandarinWithWellpace =>
      'Tiếng Quan thoại Bắc Kinh chuẩn với nhịp điệu đọc vừa phải và phụ đề rõ ràng.';

  @override
  String get heartwarmingStreetFoodAdventuresAnd =>
      'Hành trình ẩm thực đường phố ấm áp và những cuộc trò chuyện chân thành khắp mọi miền Trung Hoa.';

  @override
  String get exploresRegionalHumanStoriesFamilyT =>
      'Lắng nghe những câu chuyện đời thường, phong tục gia đình và các món ngon đặc sản từng vùng miền.';

  @override
  String get naturalConversationalMandarinWithDa =>
      'Tiếng Trung giao tiếp đời thường tự nhiên kết hợp tiếng lóng hiện đại và cảm xúc gần gũi.';

  @override
  String get humorousAndHonestConsumerElectronic =>
      'Đánh giá đồ điện tử tiêu dùng hài hước, thẳng thắn và sát thực tế trải nghiệm.';

  @override
  String get testingSmartphonesSmartHomeGadgetsA =>
      'Đánh giá thực tế smartphone, thiết bị nhà thông minh và đồ công nghệ phục vụ đời sống.';

  @override
  String get relaxedHumorousConversationalDialog =>
      'Đối thoại thường ngày dí dỏm, thư giãn với các cách diễn đạt đậm chất khẩu ngữ hiện đại.';

  @override
  String get seanKitchen => 'Bếp Nhà Sean (Sean\'s Kitchen)';

  @override
  String get deliciousHomecookedChineseDishesAnd =>
      'Các món ăn gia đình Trung Hoa thơm ngon và bí quyết nấu các món ăn vặt đường phố nổi tiếng.';

  @override
  String get easytofollowKitchenTipsForCookingAu =>
      'Mẹo nhà bếp đơn giản, dễ làm để nấu các món ăn châu Á đậm đà, ấm lòng chuẩn vị.';

  @override
  String get warmInvitingCommentaryWithPractical =>
      'Lời bình truyền cảm, ấm áp đan xen vốn từ vựng nhà bếp vô cùng thực tế.';

  @override
  String get chineseChannel => 'Kênh Học Tiếng Trung';

  @override
  String get structuredChineseLanguageLessonsAnd =>
      'Bài học tiếng Trung bài bản theo lộ trình và các video khám phá văn hóa bổ ích.';

  @override
  String get grammarPointsHskVocabularyBuildingA =>
      'Tổng hợp điểm ngữ pháp, tích lũy từ vựng HSK và mẫu câu đối thoại thực dụng.';

  @override
  String get clearEducationalPacingTailoredSpeci =>
      'Nhịp độ bài giảng mạch lạc, được thiết kế chuyên biệt cho người học tiếng Trung.';

  @override
  String get oneInABillion => 'Một Trong Một Tỷ (One in a Billion)';

  @override
  String get intimatePortraitsAndStoriesOfUnique =>
      'Chân dung chân thực và những câu chuyện lay động lòng người của các cá nhân đặc biệt tại Trung Quốc đương đại.';

  @override
  String get exploresDiverseLifeChoicesYouthCult =>
      'Khám phá những lựa chọn cuộc sống đa dạng, văn hóa giới trẻ và sự chuyển mình của xã hội hiện đại.';

  @override
  String get deepNarrativeStorytellingWithRichVo =>
      'Lối kể chuyện giàu chiều sâu với vốn từ vựng phong phú cùng giọng dẫn truyền cảm.';

  @override
  String get vickySoup => 'Vicky Soup Vlog';

  @override
  String get aestheticLifestyleVlogsFashionStyli =>
      'Vlog phong cách sống thẩm mỹ, phối đồ thời trang và nhịp sống hằng ngày tinh tế.';

  @override
  String get travelDiariesAndCozyLifeMomentsDocu =>
      'Nhật ký du lịch và những khoảnh khắc ấm cúng đời thường được ghi lại bằng thước phim điện ảnh.';

  @override
  String get naturalCasualMandarinSpokenAtAComfo =>
      'Tiếng Trung giao tiếp tự nhiên với tốc độ vừa phải, dễ nghe và biểu cảm phong phú.';

  @override
  String get tededMandarin => 'TED-Ed Tiếng Trung';

  @override
  String get highqualityAnimatedEducationalLesso =>
      'Bài học hoạt hình giáo dục chất lượng cao về khoa học, triết học và lịch sử nhân loại.';

  @override
  String get thoughtprovokingRiddlesClassicLiter =>
      'Những câu đố tư duy kích thích trí tuệ, tinh hoa văn học kinh điển và bí ẩn tâm lý học.';

  @override
  String get impeccableVoiceoverMandarinWithSync =>
      'Giọng lồng tiếng chuẩn xác tuyệt đối với phụ đề song ngữ đồng bộ mượt mà.';

  @override
  String get channel => 'Kênh';

  @override
  String get curatedCulturalDocumentariesAndChin =>
      'Phim tài liệu văn hóa chọn lọc và những nét đặc sắc trong phong cách sống Trung Hoa.';

  @override
  String get exploringTraditionalArtsHeritageCra =>
      'Khám phá nghệ thuật cổ truyền, di sản thủ công và những xu hướng thời thượng hiện đại.';

  @override
  String get highQualityAudioWithSynchronizedChi =>
      'Âm thanh chất lượng cao có phụ đề tiếng Trung đồng bộ chính xác.';

  @override
  String get interestingStoriesAndCreativeVideoP =>
      'Những câu chuyện độc đáo và dự án video sáng tạo nổi bật từ không gian mạng Trung Quốc.';

  @override
  String get engagingInterviewsStorytellingAndVi =>
      'Các cuộc phỏng vấn sâu sắc, lối kể chuyện cuốn hút cùng hình ảnh nghệ thuật.';

  @override
  String get greatListeningMaterialWithStandardP =>
      'Nguồn tài liệu luyện nghe xuất sắc với phát âm giọng đọc tiêu chuẩn.';

  @override
  String get xVsY => 'X so với Y';

  @override
  String get untitled => 'Chưa có tiêu đề';

  @override
  String get contemporaryStories => 'Truyện ngắn đương đại';

  @override
  String get history => 'Lịch sử';

  @override
  String get advancedReading => 'Đọc hiểu cao cấp';

  @override
  String get intermediateReading => 'Đọc hiểu trung cấp';

  @override
  String get beginnerReading => 'Đọc hiểu sơ cấp';

  @override
  String get mandarinBean => 'Mandarin Bean';

  @override
  String get unknown => 'Không rõ';

  @override
  String get localDb => 'Cơ sở dữ liệu cục bộ';

  @override
  String get emperorTaizong => 'Đường Thái Tông (Lý Thế Dân)';

  @override
  String get emperorXuanzong => 'Đường Huyền Tông (Lý Long Cơ)';

  @override
  String get liBai => 'Lý Bạch (Lý Thái Bạch)';

  @override
  String get gradedReader => 'Sách đọc phân cấp';

  @override
  String get ucj10r97lkwgdtqbt6xzv8gLearnMandari =>
      'Học tiếng Trung cùng TaiwanPlus';

  @override
  String get ucsxriuqkzzmaqklq0n9xfvwEverydayChi =>
      'Tiếng Trung giao tiếp hằng ngày';

  @override
  String get graceMandarinChinese => 'Grace Mandarin Chinese';

  @override
  String get ucolbhvvl5dcjlmzeqbuu1vwTingdailyLi =>
      'Ting: Nhịp sống thường nhật ở Trung Quốc';

  @override
  String get xinxin => 'Hân Hân (Xinxin)';

  @override
  String get sweetFamilyDailyLife => 'Cuộc sống gia đình ngọt ngào';

  @override
  String get chinsunDailyLife => 'Nhật ký thường ngày của Chin-Sun';

  @override
  String get tasteChina => 'Mỹ vị Trung Hoa';

  @override
  String get dawenFoodQuest => 'Hành trình ẩm thực của Đại Văn';

  @override
  String get chinaTravelWithCangbao => 'Du lịch Trung Quốc cùng Thương Bảo';

  @override
  String get alinFoodWalk => 'Hành trình ẩm thực đường phố cùng A Lâm';

  @override
  String get videoOfTheDay => 'VIDEO HÔM NAY';

  @override
  String get noValidVideoFound => 'Không tìm thấy video hợp lệ nào.';

  @override
  String get listeningPractice => 'LUYỆN NGHE CHUYÊN SÂU';

  @override
  String get socialSkills => 'KỸ NĂNG GIAO TIẾP';

  @override
  String get culturalContext => 'BỐI CẢNH VĂN HÓA';

  @override
  String get realLife => 'ĐỜI SỐNG THỰC TẾ';

  @override
  String get realWorld => 'ỨNG DỤNG THỰC TẾ';

  @override
  String get articleOfTheDay => 'BÀI ĐỌC HÔM NAY';

  @override
  String get failedToLoadOrParseRssFeed =>
      'Không thể tải hoặc phân tích nguồn cấp dữ liệu RSS.';

  @override
  String get drama => 'Phim truyền hình (Phim bộ)';

  @override
  String get youkugetAppNow => 'YOUKU: Tải ứng dụng ngay';

  @override
  String get romanceTrailer => 'Tình cảm / Trailer';

  @override
  String get romance => 'Tình cảm / Lãng mạn';

  @override
  String get action => 'Hành động / Võ thuật';

  @override
  String get mystery => 'Trinh thám / Bí ẩn';

  @override
  String get historical => 'Cổ trang / Lịch sử';

  @override
  String get historicalAction => 'Cổ trang / Hành động';

  @override
  String get historicalRomance => 'Cổ trang / Tình cảm';

  @override
  String get anYouth => 'Thanh xuân / Tuổi trẻ';

  @override
  String get historicalSliceOfLife => 'Cổ trang / Đời thường';

  @override
  String get historicalHighlight => 'Cổ trang / Trích đoạn nổi bật';

  @override
  String get youkuEnglishgetAppNow => 'YOUKU English: Tải ứng dụng ngay';

  @override
  String get theDouble => 'Mặc Vũ Vân Gian (The Double)';

  @override
  String get updatesByOshin => 'Cập nhật bởi Oshin';

  @override
  String get backFromTheBrink => 'Hộ Tâm (Back From the Brink)';

  @override
  String get fallingIntoYourSmile =>
      'Khi Em Mỉm Cười Rất Đẹp (Falling Into Your Smile)';

  @override
  String get everyoneLovesMe => 'Đừng Rung Động Vì Anh (Everyone Loves Me)';

  @override
  String get tillTheEndOfTheMoon =>
      'Trường Nguyệt Tẫn Minh (Till The End Of The Moon)';

  @override
  String get theBestDayOfMyLife =>
      'Ngày Tuyệt Vời Nhất Của Tôi (The Best Day of My Life)';

  @override
  String get gikkiChineseDrama => 'Phim truyền hình Trung Quốc GIKKI';

  @override
  String get dashingYouth =>
      'Thiếu Niên Bạch Mã Túy Xuân Phong (Dashing Youth)';

  @override
  String get rebornChineseDramaEngSub => 'Phim Trung Quốc Trùng Sinh (Reborn)';

  @override
  String get ijenwaBenita => 'Ijenwa Benita';

  @override
  String get whenIFlyTowardsYou =>
      'Khi Anh Chạy Về Phía Em (When I Fly Towards You)';

  @override
  String get mztvExclusiveChineseDrama => 'Phim truyền hình độc quyền MZTV';

  @override
  String get theStarryLove => 'Tinh Lạc Ngưng Thành Đường (The Starry Love)';

  @override
  String get comedy => 'Hài kịch';

  @override
  String get backFromTheBrink1 => 'Hộ Tâm';

  @override
  String get dashingYouth1 => 'Thiếu Niên Bạch Mã Túy Xuân Phong';

  @override
  String get beReborn => 'Trùng sinh / Tái sinh';

  @override
  String get beautyStrategy => 'Mỹ nhân mưu lược';

  @override
  String get myDivineEmissary => 'Thiên giáng thần sứ (My Divine Emissary)';

  @override
  String get theHope => 'Minh Long Thiếu Niên (The Hope)';

  @override
  String get ep16In => 'Tập 16';

  @override
  String get everyoneLovesMe1 => 'Đừng Rung Động Vì Anh';

  @override
  String get fallingIntoYourSmile1 => 'Khi Em Mỉm Cười Rất Đẹp';

  @override
  String get hiddenLove => 'Vụng Trộm Không Thể Giấu (Hidden Love)';

  @override
  String get loveBetweenFairyAndDevil =>
      'Thương Lan Quyết (Love Between Fairy and Devil)';

  @override
  String get loveLikeTheGalaxy => 'Tinh Hán Xán Lạn (Love Like the Galaxy)';

  @override
  String get membersPremiere => 'Tập phát sớm cho hội viên VIP';

  @override
  String get moonlight => 'Khúc Biến Tấu Ánh Trăng (Moonlight)';

  @override
  String get myJourneyToYou => 'Vân Chi Vũ (My Journey to You)';

  @override
  String get mysteriousLotusCasebook =>
      'Liên Hoa Lâu (Mysterious Lotus Casebook)';

  @override
  String get rebornChineseDramaEngSub1 => 'Trùng Sinh (Reborn)';

  @override
  String get reborn => 'Trùng sinh';

  @override
  String get theBestDayOfMyLife1 => 'Ngày Tuyệt Vời Nhất Của Tôi';

  @override
  String get theDouble1 => 'Mặc Vũ Vân Gian';

  @override
  String get theLongBallad => 'Trường Ca Hành (The Long Ballad)';

  @override
  String get theStarryLove1 => 'Tinh Lạc Ngưng Thành Đường';

  @override
  String get theUntamed => 'Trần Tình Lệnh (The Untamed)';

  @override
  String get tillTheEndOfTheMoon1 => 'Trường Nguyệt Tẫn Minh';

  @override
  String get whenIFlyTowardsYou1 => 'Khi Anh Chạy Về Phía Em';

  @override
  String get wordOfHonor => 'Sơn Hà Lệnh (Word of Honor)';

  @override
  String get blossom => 'Phồn Hoa (Blossoms Shanghai)';

  @override
  String get gemini => 'Gemini';

  @override
  String get generationToGeneration => 'Truyền thừa qua các thế hệ';

  @override
  String get brocadeOdyssey => 'Thục Cẩm Nhân Gia (Brocade Odyssey)';

  @override
  String get circleOfLove => 'Tỏa Ái Tam Sinh (Circle of Love)';

  @override
  String get dawnIsBreaking => 'Bình Minh Đang Đến';

  @override
  String get firstRomance => 'Mối Tình Đầu';

  @override
  String get loveInTheClouds => 'Tình Yêu Nơi Chín Tầng Mây';

  @override
  String get secondChanceRomance => 'Cơ Hội Thứ Hai Cho Tình Yêu';

  @override
  String get mrBad => 'Bạn Trai Phản Diện Của Tôi (Mr. Bad)';

  @override
  String get pursuitOfJade => 'Truy Tìm Ngọc Quý';

  @override
  String get fatedHearts => 'Tơ Duyên Tiền Định';

  @override
  String get roadHome => 'Đường Về Nhà (Quy Lộ / Road Home)';

  @override
  String get myDearGuardian => 'Quân Trang Thân Yêu (My Dear Guardian)';

  @override
  String get brightEyesInTheDark =>
      'Anh Ấy Bước Ra Từ Ánh Lửa (Bright Eyes in the Dark)';

  @override
  String get theIngeniousOne => 'Vân Tương Truyện (The Ingenious One)';

  @override
  String get herPhoenixMajesty => 'Phượng Hoàng Vương Tọa';

  @override
  String get dreamsNeverEnd => 'Giấc Mơ Bất Tận';

  @override
  String get theUltimateVowUnknownToYou => 'Lời Thề Bí Mật';

  @override
  String get the300LoyalGhosts => '300 Anh Linh Trung Liệt';

  @override
  String get homelandGuardian => 'Người Vệ Quốc';

  @override
  String get loveIsAlwaysOnline => 'Tình Yêu Luôn Trực Tuyến';

  @override
  String get thePrincessDecree => 'Chiếu Chỉ Của Công Chúa';

  @override
  String get aVowInTheDark => 'Lời Thề Trong Bóng Tối';

  @override
  String get aGirlLikeMe => 'Ta Chính Là Cô Nương Như Thế (A Girl Like Me)';

  @override
  String get iAmNobody => 'Dị Nhân Chi Hạ (I Am Nobody)';

  @override
  String get myMamaGo => 'Mẹ Ơi, Cố Lên!';

  @override
  String get myWesternRegionPrincess => 'Công Chúa Tây Vực Của Ta';

  @override
  String get aFlowerOnTheContinent => 'Đóa Hoa Trên Lục Địa';

  @override
  String get thePrincess => 'Công Chúa';

  @override
  String get sweetLoveVersion => 'Bản Ngọt Ngào Say Đắm';

  @override
  String get hilariousFamily2 => 'Gia Đình Hài Hước 2';

  @override
  String get guYuanMountainHasASchool => 'Học Đường Núi Cố Nguyên';

  @override
  String get foreverYoung => 'Mãi Mãi Tuổi Thanh Xuân';

  @override
  String get theHiddenHeirYeChen => 'Người Thừa Kế Ẩn Danh Diệp Thần';

  @override
  String get extraordinary => 'Phi Thường';

  @override
  String get sideStoryOfFoxVolant => 'Phi Hồ Ngoại Truyện (Fox Volant)';

  @override
  String get loveOfTheDivineTree => 'Tình Yêu Thần Mộc';

  @override
  String get rebirth => 'Tái sinh';

  @override
  String get moonlitReunion => 'Tương Phùng Dưới Ánh Trăng';

  @override
  String get videoCountsCannotBeNegative =>
      'Số lượng video không được là số âm.';

  @override
  String get publicDomainClassic =>
      'Tác phẩm kinh điển thuộc phạm vi công cộng';

  @override
  String get idioms => 'Thành ngữ & Điển tích';

  @override
  String get news => 'Tin tức thời sự';

  @override
  String get fairyTales => 'Truyện cổ tích & Ngụ ngôn';

  @override
  String get hereIsAFascinatingCulturalExplanati =>
      'Dưới đây là lời giải thích văn hóa thú vị:';

  @override
  String get videoFetchTimedOut => 'Hết thời gian tải video';

  @override
  String get aboutChannel => 'GIỚI THIỆU KÊNH';

  @override
  String get noVideosFound => 'Không tìm thấy video nào';

  @override
  String get failedToLoadVideos => 'Không thể tải video';

  @override
  String get highqualityCuratedMandarinContentWi =>
      'Nội dung tiếng Trung chọn lọc chất lượng cao với vốn từ vựng tự nhiên.';

  @override
  String get authenticSpokenChineseAcrossRealwor =>
      'Tiếng Trung giao tiếp chuẩn xác qua các chủ đề và tình huống thực tế.';

  @override
  String get engagingVideoMaterialWithInteractiv =>
      'Tài liệu video sinh động với phụ đề tương tác được đồng bộ chuẩn xác.';

  @override
  String get watchVideo => 'Xem video';

  @override
  String get culturalInsight => 'Góc Nhìn Văn Hóa';

  @override
  String get aiIsAnalyzingCulturalContext =>
      'AI đang phân tích bối cảnh văn hóa...';

  @override
  String get diveIntoFullContent => 'Khám phá toàn bộ nội dung';

  @override
  String get savedArticles => 'Bài viết đã lưu';

  @override
  String get liveOverlay => 'LỚP PHỦ TRỰC TIẾP';

  @override
  String get webExplorer => 'TRÌNH DUYỆT WEB';

  @override
  String get browseAnyChineseWebsiteWithRealtime =>
      'Duyệt bất kỳ trang web tiếng Trung nào với từ điển chạm tức thì, phiên âm pinyin và dịch thuật trực tiếp.';

  @override
  String get startExploring => 'BẮT ĐẦU KHÁM PHÁ';

  @override
  String get chineseTvSeriesWithInteractiveSubti =>
      'Phim bộ Trung Quốc kèm phụ đề tương tác';

  @override
  String get failedToLoadContent => 'Không thể tải nội dung';

  @override
  String get searchingYoutube => 'Đang tìm kiếm trên YouTube...';

  @override
  String get noVideosFoundTryADifferentSearchTer =>
      'Không tìm thấy video nào. Hãy thử bằng từ khóa khác.';

  @override
  String get searching => 'Đang tìm kiếm...';

  @override
  String get noShowsFound => 'Không tìm thấy chương trình nào';

  @override
  String get bookmarked => 'Đã lưu vào dấu trang';

  @override
  String get trailer1 => 'Trailer';

  @override
  String get highlight1 => 'Đoạn nổi bật';

  @override
  String get noCaptionsAvailable => 'Không có phụ đề khả dụng';

  @override
  String get fetchingSubtitles => 'Đang tải phụ đề...';

  @override
  String get generatingAiBriefing => 'Đang tạo bản tóm tắt bằng AI...';

  @override
  String get noClosedCaptionsCcFoundForThisVideo =>
      'Không tìm thấy phụ đề kỹ thuật số (CC) cho video này.';

  @override
  String get videosWithHardcodedOrBurnedinSubtit =>
      'Video có phụ đề gắn cứng vào hình ảnh sẽ không có luồng văn bản kỹ thuật số trên YouTube.';

  @override
  String get translatingSubtitles => 'Đang dịch phụ đề...';

  @override
  String get processingYourPronunciation => 'Đang phân tích phát âm của bạn...';

  @override
  String get couldntIdentifyLine => 'Không thể nhận diện dòng thoại này.';

  @override
  String get listeningSpeakNow => 'Đang lắng nghe... Hãy nói ngay bây giờ.';

  @override
  String get thisVideoDoesNotHaveADigitalClosedC =>
      'Video này không có phụ đề kỹ thuật số (CC) trên YouTube.';

  @override
  String get perfect1 => 'Tuyệt vời';

  @override
  String get thisVideoHasBeenRemovedOrIsNoLonger =>
      'Video này đã bị gỡ bỏ hoặc không còn khả dụng.';

  @override
  String get thisVideoCannotBePlayedInTheAppYouC =>
      'Video này không thể phát trực tiếp trong ứng dụng. Bạn có thể xem trên YouTube.';

  @override
  String get yourDeviceCannotPlayThisVideoPlease =>
      'Thiết bị của bạn không hỗ trợ phát video này. Vui lòng thử video khác.';

  @override
  String get invalidVideoReferencePleaseTryAgain =>
      'Liên kết video không hợp lệ. Vui lòng thử lại.';

  @override
  String get unableToLoadThisVideoPleaseTryAnoth =>
      'Không thể tải video này. Vui lòng thử video khác.';

  @override
  String get startReading => 'Bắt đầu đọc';

  @override
  String get analyzingCulturalContext => 'Đang phân tích bối cảnh văn hóa...';

  @override
  String get failedToLoadCulturalInsight => 'Không thể tải thông tin văn hóa.';

  @override
  String get historicalContext => 'Bối cảnh lịch sử';

  @override
  String get culturalSignificance => 'Ý nghĩa văn hóa';

  @override
  String get authorBackground => 'Tiểu sử & Phong cách tác giả';

  @override
  String get k80CompleteClassicNovelsWorldEpics =>
      'Hơn 80 bộ tiểu thuyết kinh điển nguyên bản và sử thi thế giới';

  @override
  String get storyOfTheDay => 'CÂU CHUYỆN HÔM NAY';

  @override
  String get tangDynasty => 'Thời nhà Đường';

  @override
  String get poetryClassicalVerse => 'Thơ Đường & Thi ca cổ điển';

  @override
  String get allHsk => 'Tất cả cấp độ HSK';

  @override
  String get allStories => 'Tất cả câu chuyện';

  @override
  String get keyWords => 'Từ khóa cốt lõi';

  @override
  String get openOriginalWebsite => 'Mở trang web gốc';

  @override
  String get aiReadingTools => 'Công cụ đọc hiểu AI';

  @override
  String get enhanceYourReadingWithAipoweredTool =>
      'Nâng cao kỹ năng đọc hiểu với các công cụ hỗ trợ bởi AI';

  @override
  String get chooseTheTargetDifficultyForSimplif =>
      'Chọn cấp độ khó mục tiêu để chuyển văn bản sang dạng dễ hiểu';

  @override
  String get chooseDifficultyForSimplification => 'Chọn độ khó để đơn giản hóa';

  @override
  String get extractAllUnknownWordsToANewFlashca =>
      'Trích xuất toàn bộ từ mới vào một bộ thẻ flashcard mới';

  @override
  String get length => 'Độ dài';

  @override
  String get m1554846a550010707 => 'M15.54 8.46a5 5 0 0 1 0 7.07';

  @override
  String get m1907493a101000101414 => 'M19.07 4.93a10 10 0 0 1 0 14.14';

  @override
  String get webExtraction => 'Trích xuất văn bản từ Web';

  @override
  String get aiTools => 'Bộ công cụ AI';

  @override
  String get stop => 'Dừng lại';

  @override
  String get keepPracticing1 => 'Tiếp tục luyện tập';

  @override
  String get aiPrepRoom => 'Phòng Chuẩn Bị Cùng AI';

  @override
  String get lessonSummary => 'TỔNG KẾT BÀI HỌC';

  @override
  String get unlockSinosparkPremium => 'Mở khóa SinoSpark Premium';

  @override
  String get monthYear => 'Tháng / Năm';

  @override
  String get enableNotifications => 'Bật thông báo';

  @override
  String get notificationsConfigured => 'Đã thiết lập thông báo';

  @override
  String get neverMissAStroke2 => 'Không bỏ sót nét chữ nào';

  @override
  String get yourDailyDropAndStreakAlertsArePrim =>
      'Nhắc nhở bài học hằng ngày và chuỗi ngày rèn luyện đã sẵn sàng.';

  @override
  String get stayConsistentWithDailyRitualDropsA =>
      'Duy trì tính kỷ luật với bài học mỗi ngày và thông báo dùng thử kịp thời.';

  @override
  String get aNewWordAndStoryWaitingForYourDaily =>
      'Từ vựng và câu chuyện mới đang chờ đón bạn trong bài học hằng ngày.';

  @override
  String get gentlePromptsBeforeCharactersFadeFr =>
      'Những lời nhắc nhở tinh tế trước khi chữ Hán phai mờ khỏi trí nhớ của bạn.';

  @override
  String get receiveAReminder2DaysBeforeYourFree =>
      'Nhận thông báo nhắc nhở 2 ngày trước khi gói dùng thử miễn phí kết thúc.';

  @override
  String get yourPathTonchineseFluency =>
      'Lộ trình chinh phục\ntiếng Trung lưu loát';

  @override
  String get answer3QuickQuestionsSoOurAiCanCraf =>
      'Trả lời 3 câu hỏi nhanh để AI thiết kế\ngiáo trình cá nhân hóa phù hợp với quỹ thời gian của bạn.';

  @override
  String get whatIsYourLevelnwithChinese =>
      'Trình độ tiếng Trung\ncủa bạn hiện tại ra sao?';

  @override
  String get chooseThePathThatFitsYourDepth =>
      'Chọn lộ trình phù hợp với năng lực hiện tại của bạn.';

  @override
  String get whatDrivesYourStudy => 'Động lực học tiếng Trung của bạn là gì?';

  @override
  String get purposeFuelsTheBrush => 'Mục tiêu định hướng ngọn bút';

  @override
  String get setYourDailyRitual => 'Thiết lập thói quen học tập hằng ngày.';

  @override
  String get youCanAdjustYourRitualAnyTime =>
      'Bạn có thể điều chỉnh thói quen học bất cứ lúc nào.';

  @override
  String get letsBegin => 'Bắt đầu ngay';

  @override
  String get brandNew => 'Mới bắt đầu hoàn toàn';

  @override
  String get iveNeverStudiedChineseBefore =>
      'Tôi chưa từng học tiếng Trung trước đây.';

  @override
  String get iKnowBasicCharactersAndPhrases =>
      'Tôi biết một số chữ Hán và câu chào hỏi căn bản.';

  @override
  String get iCanHoldConversationsAndRead =>
      'Tôi có thể giao tiếp đơn giản và đọc hiểu văn bản ngắn.';

  @override
  String get iWantToRefineAndPerfectMySkills =>
      'Tôi muốn trau dồi và nâng tầm kỹ năng giao tiếp như người bản xứ.';

  @override
  String get confirmSelection => 'Xác nhận lựa chọn';

  @override
  String get purposeFuelsTheBrushsMotion =>
      'Mục đích rõ ràng tiếp thêm sức mạnh cho từng nét bút.';

  @override
  String get buildMyPath => 'Tạo lộ trình cho tôi';

  @override
  String get hskCertification => 'Chứng chỉ & Kỳ thi HSK';

  @override
  String get culturalAppreciation => 'Đam mê văn hóa, lịch sử và nghệ thuật';

  @override
  String get yourPlanIsReady => 'Lộ trình học của bạn đã sẵn sàng';

  @override
  String get craftingYourCurriculum =>
      'Đang thiết kế giáo trình riêng cho bạn...';

  @override
  String get personalizedPathInitialized => 'ĐÃ KHỞI TẠO LỘ TRÌNH CÁ NHÂN HÓA';

  @override
  String get calibratingAiNeuralMasters =>
      'ĐANG HIỆU CHỈNH GIA SƯ AI NƠ-RON...';

  @override
  String get calibrationComplete => 'Hiệu chỉnh hoàn tất';

  @override
  String get synthesizingModules => 'Đang tổng hợp các mô-đun học tập...';

  @override
  String get oneAndWater => '«Nhất (一)» và «Thủy (水)»';

  @override
  String get theHorizontalStroke => 'NÉT NGANG (HÉNG)';

  @override
  String get theRadical => 'BỘ THỦ (RADICAL)';

  @override
  String get water => 'Thủy (Nước)';

  @override
  String get river => 'Giang (Sông)';

  @override
  String get day5Reminder => 'Nhắc nhở Ngày thứ 5';

  @override
  String get wePromisedToAlertYou2DaysBeforeYour =>
      'Đúng như đã hẹn, chúng tôi nhắc bạn 2 ngày trước khi gói dùng thử kết thúc để bạn chủ động quyết định.';

  @override
  String get continueWithoutReminder => 'Tiếp tục không cần nhắc nhở';

  @override
  String get masterChineseWithnsinospark =>
      'Làm chủ tiếng Trung cùng\nSinoSpark';

  @override
  String get start7dayFreeTrial => 'Bắt đầu 7 ngày dùng thử miễn phí';

  @override
  String get precisionStrokes => 'Chuẩn xác từng nét bút';

  @override
  String get aiPronunciation => 'Luyện phát âm chuẩn cùng AI';

  @override
  String get today => 'Hôm nay';

  @override
  String get fullAccess => 'Truy cập toàn bộ tính năng';

  @override
  String get day5 => 'Ngày 5';

  @override
  String get reminder => 'Nhắc nhở';

  @override
  String get day7 => 'Ngày 7';

  @override
  String get trialBegins => 'Bắt đầu dùng thử';

  @override
  String get revenuecatIsMissingACurrentOffering =>
      'RevenueCat chưa có gói ưu đãi hoặc sản phẩm nào. Vui lòng cấu hình trong Dashboard.';

  @override
  String get cameraPermissionRequiredForLiveScan =>
      'Cần cấp quyền camera để quét trực tiếp trong thời gian thực.';

  @override
  String get cameraAccessRequired => 'Yêu cầu quyền truy cập máy ảnh';

  @override
  String get pleaseEnableCameraAccessInYourDevic =>
      'Vui lòng bật quyền truy cập máy ảnh trong Cài đặt thiết bị để sử dụng tính năng này.';

  @override
  String get alignChineseTextWithinFrame =>
      'Căn chỉnh văn bản tiếng Trung nằm gọn trong khung quét';

  @override
  String get inLibrary => 'Đã có trong thư viện';

  @override
  String get novice => 'Nhập môn';

  @override
  String get apprentice => 'Học trò';

  @override
  String get artisan => 'Thợ lành nghề';

  @override
  String get grandmaster => 'Đại tông sư';

  @override
  String get poem => 'Bài thơ';

  @override
  String get theNarrative => 'Tác phẩm tường thuật';

  @override
  String get classicMasterpiece => 'Kiệt tác cổ điển';

  @override
  String get classicAuthor => 'Tác gia kinh điển';

  @override
  String get classical => 'Cổ điển';

  @override
  String get classicLiterature => 'Văn học cổ điển';

  @override
  String inThisChapterOf(Object title) {
    return 'Trong chương này của tác phẩm «$title»';
  }

  @override
  String get asTheNarrativeUnfoldsItIlluminatesT =>
      'Khi câu chuyện mở ra, nó soi rọi những bài học nhân sinh sâu sắc cùng nguồn cảm hứng trường tồn.';

  @override
  String get general => 'Tổng quát';

  @override
  String get mythology => 'Thần thoại';

  @override
  String get dailyLife => 'Đời sống thường nhật';

  @override
  String get tangPoetry => 'Thơ Đường';

  @override
  String get classicalLiterature => 'Văn học cổ điển';

  @override
  String get justNow => 'Vừa xong';

  @override
  String get theTerracottaArmyOfQinShiHuang =>
      'Đội quân đất nung của Tần Thủy Hoàng';

  @override
  String get lifeInsideTheForbiddenCity =>
      'Đời sống hoàng cung trong Tử Cấm Thành';

  @override
  String get buyingATicketAndTakingTheHighSpeedT =>
      'Mua vé và trải nghiệm đi tàu cao tốc tại Trung Quốc';

  @override
  String get goingToTheHospitalForAColdAndSeeing =>
      'Đi bệnh viện khám bác sĩ khi bị cảm lạnh';

  @override
  String get goingToALocalRestaurantToOrderJiaoz =>
      'Ghé quán ăn bản địa gọi món sủi cảo jiaozi';

  @override
  String get theTraditionalGongfuTeaCeremony =>
      'Nghi thức trà đạo Gongfu truyền thống';

  @override
  String get theArtOfWritingChineseCharactersWit =>
      'Nghệ thuật viết chữ Hán bằng bút lông';

  @override
  String get theLifeAndConservationOfGiantPandas =>
      'Đời sống và công tác bảo tồn loài gấu trúc lớn';

  @override
  String get storyNotFoundInDatabase =>
      'Không tìm thấy câu chuyện trong cơ sở dữ liệu';

  @override
  String get storyTextIsEmpty => 'Nội dung câu chuyện đang trống';

  @override
  String get myCustomStories => 'Truyện tự tạo của tôi';

  @override
  String get userProvidedText => 'Văn bản do người dùng cung cấp';

  @override
  String get local => 'Cục bộ';

  @override
  String get voiceEngineAllowance => 'Bộ chuyển giọng đọc & Hạn mức';

  @override
  String get studioHdVsUnlimitedStandardVoice =>
      'Giọng đọc Studio HD vs Giọng đọc tiêu chuẩn không giới hạn';

  @override
  String get standardVoiceIs100UnlimitedFree =>
      'Giọng đọc tiêu chuẩn hoàn toàn miễn phí và không giới hạn';

  @override
  String get read => 'Đọc';

  @override
  String get koreKoreFemaleWarm => 'Kore (nữ, ấm áp)';

  @override
  String get aoedeAoedeFemaleCheerful => 'Aoede (nữ, trong trẻo)';

  @override
  String get fenrirFenrirMaleUpbeat => 'Fenrir (nam, sôi nổi)';

  @override
  String get charonCharonMaleNewsstyle => 'Charon (nam, thời sự)';

  @override
  String get puckPuckMaleSporty => 'Puck (nam, năng động)';

  @override
  String get localOndevice => 'Giọng đọc trên thiết bị';

  @override
  String get localOndeviceTts => 'TTS cục bộ trên thiết bị';

  @override
  String get off => 'Tắt';

  @override
  String get endOfCurrentChapter => 'Hết chương hiện tại';

  @override
  String get standardVoice => 'Giọng đọc tiêu chuẩn';

  @override
  String get noNovelsFoundMatchingYourFilter =>
      'Không tìm thấy tiểu thuyết nào phù hợp với bộ lọc.';

  @override
  String get noMicroreadsFoundMatchingYourFilter =>
      'Không tìm thấy bài đọc ngắn nào phù hợp với bộ lọc.';

  @override
  String get noPoemsFoundMatchingYourFilter =>
      'Không tìm thấy bài thơ nào phù hợp với bộ lọc.';

  @override
  String get audiobook => 'Sách nói';

  @override
  String get audio => 'Âm thanh';

  @override
  String get continueReading => 'Tiếp tục đọc';

  @override
  String get search96FullNovelsAuthorsEpics =>
      'Tìm trong 96 tiểu thuyết nguyên bản, tác giả, sử thi...';

  @override
  String get searchClassicalPoemsAuthorsVerses =>
      'Tìm thơ cổ điển, thi nhân, câu thơ...';

  @override
  String get allLevelsVal => 'Tất cả cấp độ';

  @override
  String get hsk1BeginnerVal => 'HSK 1 (Sơ cấp)';

  @override
  String get hsk2ElementaryVal => 'HSK 2 (Căn bản)';

  @override
  String get hsk3IntermediateVal => 'HSK 3 (Trung cấp)';

  @override
  String get hsk4UpperIntVal => 'HSK 4 (Trung cấp cao)';

  @override
  String get listenToAudiobook => 'Nghe sách nói';

  @override
  String get synopsis => 'Tóm tắt nội dung';

  @override
  String get peoplesArtist => 'Nghệ sĩ Nhân dân';

  @override
  String get kafkaesqueForBureaucraticAbsurdityA =>
      '«Chất Kafka» diễn tả sự phi lý của bộ máy quan liêu, cảm giác tha hóa và nỗi âu lo hiện sinh.';

  @override
  String get bigBrotherAndNewspeak =>
      '«Anh Cả (Big Brother)» và «Tân ngữ (Newspeak)».';

  @override
  String get audiobookIncluded => 'Có kèm sách nói';

  @override
  String get readPoem => 'Đọc thơ';

  @override
  String get studioVoiceAllowance => 'Hạn mức giọng đọc Studio HD';

  @override
  String get weeklyHighdefinitionAiRecitation =>
      'Thời lượng nghe AI ngâm thơ chất lượng cao hằng tuần';

  @override
  String get resetsEveryMondayAt0000 =>
      'Tự động làm mới vào 00:00 thứ Hai hằng tuần';

  @override
  String get whenYourWeekly4hourStudioAllowanceI =>
      'Khi dùng hết 4 giờ giọng đọc Studio mỗi tuần, ứng dụng sẽ tự động chuyển sang giọng đọc trên thiết bị để bạn tiếp tục nghe miễn phí không giới hạn.';

  @override
  String get localDeviceVoice => 'Giọng đọc thiết bị';

  @override
  String get classicalVerse => 'Thi ca cổ điển';

  @override
  String get ondeviceVoice4hWeeklyUsed =>
      'Giọng đọc thiết bị (Đã dùng 4h tuần này)';

  @override
  String get generateACustomAiStoryBasedOnYourIn =>
      'Tạo câu chuyện AI tùy chỉnh dựa trên sở thích của bạn';

  @override
  String get insteadOfAFixedHskLevelTheFlowState =>
      'Thay vì chỉ gò bó trong một cấp độ HSK cố định, công cụ dòng chảy động sẽ tự động phân tích vốn từ trong bộ thẻ của bạn.\n\n';

  @override
  String get we => 'Chúng tôi';

  @override
  String get howCanWeHelpYou => 'Chúng tôi có thể giúp gì cho bạn?';

  @override
  String get everythingYouNeedToKnowAboutHanziMa =>
      'Tất cả những điều bạn cần biết về SinoSpark, các tính năng và chính sách bảo mật.';

  @override
  String get whoAreTheVoicesSpeakingInTheApp =>
      'Ai là người lồng tiếng cho các nhân vật trong ứng dụng?';

  @override
  String get howDoesTheWebExplorerWork =>
      'Trình duyệt Web thông minh hoạt động như thế nào?';

  @override
  String get whatIsZenMode => 'Chế độ Zen (Tập trung) là gì?';

  @override
  String get howDoesTheFlashcardSpacedrepetition =>
      'Hệ thống Lặp lại ngắt quãng (SRS) của Flashcard hoạt động ra sao?';

  @override
  String get traceComplete => 'Đã hoàn thành nét viết!';

  @override
  String get traceCharacter => 'Tô nét chữ Hán';

  @override
  String get analyzingWordRelationships =>
      'Đang phân tích mối liên hệ giữa các từ...';

  @override
  String get identifyingUsageContexts => 'Đang xác định ngữ cảnh sử dụng...';

  @override
  String get comparingFormalityLevels => 'Đang so sánh sắc thái trang trọng...';

  @override
  String get findingCommonCollocations =>
      'Đang tìm các cụm từ kết hợp thông dụng...';

  @override
  String get generatingComparison => 'Đang tổng hợp phân tích so sánh...';

  @override
  String get generationIsTakingLongerThanExpecte =>
      'Quá trình tạo đang mất nhiều thời gian hơn dự kiến do máy chủ AI đang bận.';

  @override
  String get generationInterruptedShowingPartial =>
      'Quá trình bị gián đoạn. Đang hiển thị kết quả từng phần.';

  @override
  String get sorrySomethingWentWrong => 'Rất tiếc, đã có lỗi xảy ra.';

  @override
  String get usage => 'Cách dùng:';

  @override
  String get alsoSeenIn => 'Cũng xuất hiện trong';

  @override
  String get quickLook => 'Xem nhanh';

  @override
  String get notFound => 'Không tìm thấy';

  @override
  String get errorLoadingFromAi => 'Lỗi khi tải dữ liệu từ AI.';

  @override
  String get analyzingImage => 'Đang phân tích hình ảnh...';

  @override
  String get extractingChineseText => 'Đang trích xuất chữ Hán...';

  @override
  String get lookingUpVocabulary => 'Đang tra cứu từ vựng...';

  @override
  String get dreamOfTheRedChamber => 'Hồng Lâu Mộng (Dream of the Red Chamber)';

  @override
  String get journeyToTheWest => 'Tây Du Ký (Journey to the West)';

  @override
  String get romanceOfTheThreeKingdoms =>
      'Tam Quốc Diễn Nghĩa (Romance of the Three Kingdoms)';

  @override
  String get mingDynasty => 'Triều nhà Minh';

  @override
  String get wuChengEn => 'Ngô Thừa Ân';

  @override
  String get hundredChapters => '100 hồi';

  @override
  String get volume1 => 'Tập 1';

  @override
  String bookmarksCount(Object count) {
    return 'Dấu trang ($count)';
  }

  @override
  String get noBookmarksYet =>
      'Chưa có dấu trang nào. Chạm vào biểu tượng dấu trang để lưu lại đoạn văn bạn yêu thích.';

  @override
  String get sinosparkIsNotResponding => 'SinoSpark không phản hồi';

  @override
  String get closeApp => 'Đóng ứng dụng';

  @override
  String get wait => 'Chờ';

  @override
  String studioHdAllowance(Object hours) {
    return 'Studio HD: ${hours}h';
  }

  @override
  String bookPercentRead(Object percent) {
    return 'Đã đọc $percent%';
  }

  @override
  String chAbbreviation(Object number) {
    return 'Chương $number';
  }

  @override
  String booksAndAudiobooks(Object count) {
    return '$count sách & sách nói';
  }

  @override
  String sentenceXOfY(Object current, Object total) {
    return 'Câu $current / $total';
  }

  @override
  String chapterXOfY(Object current, Object total) {
    return 'Chương $current / $total';
  }

  @override
  String get allLevels => 'Tất cả cấp độ';

  @override
  String get searchGradedMicroStories =>
      'Tìm truyện ngắn phân cấp và truyện ngụ ngôn...';

  @override
  String gradedStoriesAndMicroReads(Object count) {
    return '$count truyện phân cấp & bài đọc ngắn hằng ngày';
  }

  @override
  String get searchClassicalPoems => 'Tìm thơ cổ điển, tác gia, câu thơ...';

  @override
  String classicalPoemsAndVerse(Object count) {
    return '$count bài thơ cổ & khúc ngâm';
  }

  @override
  String get browseAnyChineseWebsite =>
      'Duyệt bất kỳ trang web tiếng Trung nào với từ điển chạm tức thì, phiên âm pinyin và dịch thuật trực tiếp.';

  @override
  String get completed => 'ĐÃ HOÀN THÀNH';

  @override
  String get aiIsReading => 'AI đang đọc...';

  @override
  String get bbcVerify => 'BBC Verify';

  @override
  String get hsk5AdvancedVal => 'HSK 5 (Cao cấp)';

  @override
  String get hsk1Beginner => 'HSK 1 (Sơ cấp)';

  @override
  String get hsk4UpperInt => 'HSK 4 (Trung cấp cao)';

  @override
  String get extractAllUnknownWords =>
      'Trích xuất toàn bộ từ mới vào một bộ thẻ flashcard mới';

  @override
  String get designCustomAiRoleplay =>
      'Thiết kế tình huống và đối thoại nhập vai AI tùy chỉnh';

  @override
  String get practiceFlashcardVocabulary =>
      'Luyện tập từ vựng bộ thẻ qua hội thoại thực tế';

  @override
  String get surpriseMe => 'Chọn ngẫu nhiên cho tôi';

  @override
  String get rollCharacter => 'Quay chọn nhân vật';

  @override
  String get historicalCostume => 'Cổ trang / Lịch sử';

  @override
  String get modernYouth => 'Hiện đại & Tuổi trẻ';

  @override
  String get fantasyMythology => 'Tiên hiệp, Huyền huyễn & Thần thoại';

  @override
  String get familyDrama => 'Gia đình & Tâm lý xã hội';

  @override
  String get fullVersion => 'Bản trọn vẹn';

  @override
  String episodesCount(Object count) {
    return '$count tập';
  }

  @override
  String episodeLabel(Object number) {
    return 'Tập $number';
  }

  @override
  String get translating => '[ Đang dịch... ]';

  @override
  String get engSub => '[Phụ đề: Tiếng Việt]';

  @override
  String get standardVocabulary => 'Từ vựng chuẩn';

  @override
  String get characters => 'chữ';

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
  String get loading => 'Loading...';

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
