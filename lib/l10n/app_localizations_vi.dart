// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get originStoryChip => '📜 Nguồn gốc';

  @override
  String get ancientFormChip => '🏺 Cổ tự';

  @override
  String get threeMoreWordsChip => '📖 3 từ vựng khác';

  @override
  String get wordFamilyChip => '🔗 Từ cùng gốc';

  @override
  String get idiomChip => '🀄 Thành ngữ';

  @override
  String get proverbChip => '💬 Tục ngữ';

  @override
  String get isThereAChineseIdiomFeaturingThisCharacter =>
      'Có thành ngữ Trung Quốc (成语) nào chứa chữ Hán này không?';

  @override
  String get strokeOrderChip => '✏️ Thứ tự nét';

  @override
  String get calligraphyTipChip => '🎨 Mẹo thư pháp';

  @override
  String get grammarNoteChip => '📝 Ghi chú ngữ pháp';

  @override
  String get similarWordsChip => '🔄 Từ tương tự';

  @override
  String get culturalNoteChip => '🏮 Ghi chú văn hóa';

  @override
  String get inMediaChip => '🀄 Trong truyền thông';

  @override
  String get radicalMeaningChip => '🧩 Ý nghĩa bộ thủ';

  @override
  String get componentBreakdownChip => '🔍 Phân tích cấu tạo';

  @override
  String get toneTipChip => '🎵 Mẹo về thanh điệu';

  @override
  String get homophonesChip => '👯 Từ đồng âm';

  @override
  String askMeAnythingAbout(String hanzi) {
    return 'Hỏi tôi bất cứ điều gì về $hanzi...';
  }

  @override
  String aiTutorError(String error) {
    return 'Lỗi gia sư AI: $error';
  }

  @override
  String get aiTutorRateLimit =>
      'Gia sư AI hiện đang bận. Vui lòng đợi một chút và thử lại.';

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
  String get supportAndFeedback => 'Hỗ trợ & Phản hồi';

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
  String get studySession => 'Phiên học';

  @override
  String get readyToStudy => 'Sẵn sàng học';

  @override
  String get studyQueuePreviewDescription =>
      'Phiên học dựa trên lịch trình và giới hạn bộ thẻ hôm nay.';

  @override
  String get notNow => 'Để sau';

  @override
  String get newLabel => 'Mới';

  @override
  String get studyDeckEmpty => 'Bộ thẻ trống';

  @override
  String get studyDeckEmptyDescription =>
      'Hãy thêm thẻ trước khi bắt đầu phiên học.';

  @override
  String get studyDailyLimitReached => 'Đã đạt giới hạn hôm nay';

  @override
  String get studyDailyLimitReachedDescription =>
      'Bạn đã dùng hết hạn mức thẻ mới hoặc thẻ ôn tập cho hôm nay.';

  @override
  String get studyCaughtUpDescription =>
      'Không còn lịch học cho hôm nay. Hãy quay lại vào lần ôn tập tới.';

  @override
  String get noCardsAvailable => 'Không có thẻ nào';

  @override
  String get studyNoEligibleCardsDescription =>
      'Hiện không có thẻ nào phù hợp với chế độ học này.';

  @override
  String get studySessionLoadFailed =>
      'Không thể tải phiên học này. Vui lòng thử lại.';

  @override
  String get retryLimitReached =>
      'Thẻ này sẽ xuất hiện trong phiên học tiếp theo của bạn.';

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
    return 'Thêm vào $target';
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
  String get warringStates => 'Thời Chiến Quốc';

  @override
  String get hanFeiLegalism =>
      'Hàn Phi (khoảng 280–233 TCN) là một công tử của nước Hàn và là nhà tư tưởng hàng đầu của Pháp gia Trung Hoa. Kết hợp các tư tưởng về pháp luật, thuật trị quốc và quyền lực, các tác phẩm của ông trong cuốn Hàn Phi Tử đã ảnh hưởng sâu sắc đến triết học chính trị và các thể chế của Trung Hoa đế chế.';

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
      'Nếu bản chép lời không khớp với lời bạn nói, hãy chọn cụm từ bạn muốn nói rồi nhấn “Có, hãy chấm lại!” để đánh giá lại bản ghi âm ban đầu mà không cần nói lại.';

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
  String get libraryLabel => 'Thư viện Văn hóa';

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
  String get play => 'Phát âm )';

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
  String get aiDataPrivacyTitle => 'Dữ liệu AI & Quyền riêng tư';

  @override
  String get aiDataPrivacySettingsSubtitle =>
      'Xem dữ liệu nào được gửi cho AI, lý do và đơn vị nhận';

  @override
  String get aiDataPrivacyOverviewTitle => 'Khi nào AI được sử dụng';

  @override
  String get aiDataPrivacyOverviewBody =>
      'SinoSpark chỉ sử dụng AI trên đám mây khi bạn chọn các tính năng cần thiết, như trò chuyện với AI, giải thích, dịch thuật, phân tích hình ảnh, nhận dạng giọng nói, chấm điểm phát âm hoặc giọng đọc đám mây. Kết quả từ AI có thể không chính xác, vui lòng kiểm tra lại các thông tin quan trọng.';

  @override
  String get aiDataPrivacyProvidersTitle => 'Các nhà cung cấp dịch vụ AI';

  @override
  String get aiDataPrivacyProvidersBody =>
      'Google Gemini xử lý các yêu cầu tạo văn bản và hình ảnh. OpenRouter điều hướng một số yêu cầu tạo nội dung đến Google Gemini hoặc DeepSeek. Microsoft Azure AI Speech xử lý nhận dạng giọng nói, đánh giá phát âm và văn bản được gửi để tổng hợp giọng nói trên đám mây.';

  @override
  String get aiDataPrivacySentTitle => 'Dữ liệu có thể được gửi đi';

  @override
  String get aiDataPrivacySentBody =>
      'Tùy thuộc vào tính năng, chúng tôi gửi văn bản bạn nhập hoặc chọn, ngữ cảnh bài học hoặc cuộc hội thoại liên quan, hình ảnh bạn chọn để AI phân tích, bản ghi âm bạn gửi và dữ liệu kỹ thuật như địa chỉ IP cùng siêu dữ liệu thiết bị/mạng. Chúng tôi không cố ý đưa tên hoặc email của bạn vào các câu lệnh AI.';

  @override
  String get aiDataPrivacyControlsTitle => 'Lựa chọn của bạn';

  @override
  String get aiDataPrivacyControlsBody =>
      'Vui lòng không sử dụng tính năng AI nếu bạn không muốn dữ liệu đầu vào được gửi cho nhà cung cấp. Bạn có thể từ chối quyền truy cập camera, ảnh hoặc micro trong phần Cài đặt của thiết bị. Chọn giọng đọc \'Cục bộ\' (Local) để giữ tính năng chuyển văn bản thành giọng nói trên thiết bị của bạn. Tránh gửi các thông tin nhạy cảm hoặc bảo mật.';

  @override
  String get aiDataPrivacyRetentionTitle => 'Lưu trữ và bảo quản';

  @override
  String get aiDataPrivacyRetentionBody =>
      'SinoSpark không cố ý lưu trữ các câu lệnh AI thô, hình ảnh hoặc bản ghi âm đã gửi trên máy chủ của mình sau khi xử lý. Kết quả tạo ra có thể được lưu trên thiết bị hoặc tài khoản của bạn khi bạn chọn lưu chúng. Các nhà cung cấp xử lý dữ liệu theo điều khoản và chính sách lưu trữ riêng của họ; vui lòng xem chính sách đầy đủ để biết chi tiết.';

  @override
  String get readFullPrivacyPolicy => 'Đọc toàn bộ Chính sách Quyền riêng tư';

  @override
  String get linkOpenFailed => 'Không thể mở liên kết. Vui lòng thử lại.';

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
  String get trailer => 'PHIM GIỚI THIỆU';

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
  String get whatIfAiMishears => 'Tôi nên làm gì nếu AI hiểu sai lời mình nói?';

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
      'Lịch sử hội thoại Nhập vai mà bạn lưu chỉ nằm trên thiết bị để bạn có thể xem lại. Chúng tôi không dùng các cuộc trò chuyện cá nhân của bạn để huấn luyện mô hình AI.';

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
      'Bản ghi gửi để đánh giá phát âm được xử lý an toàn và SinoSpark không lưu giữ sau khi xử lý xong. Lịch sử Nhập vai mà bạn chọn lưu có thể vẫn nằm trên thiết bị và có thể được xóa trong ứng dụng.';

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
  String get requiredLabel => 'Bắt buộc';

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
  String get liveOverlay => 'TRỢ THỦ ĐỌC THỜI GIAN THỰC';

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
  String get todayDashboard => 'Hôm nay';

  @override
  String get studyToday => 'Học thẻ hôm nay';

  @override
  String get studyAhead => 'Học trước';

  @override
  String get studyAheadDescription =>
      'Luyện tập các thẻ sắp đến hạn mà không dùng hạn mức của hôm nay. Không có thẻ mới nào được thêm vào.';

  @override
  String get studyAheadComplete => 'Hoàn thành luyện tập học trước';

  @override
  String get dueNow => 'Đến hạn';

  @override
  String get scheduled => 'Đã lên lịch';

  @override
  String get sevenDayForecast => 'Dự báo ôn tập 7 ngày';

  @override
  String get reviews => 'Ôn tập';

  @override
  String get newCardsLabel => 'Thẻ mới';

  @override
  String get attempts => 'Số lần thử';

  @override
  String get duration => 'Thời gian';

  @override
  String get answerBreakdown => 'Phân tích đáp án';

  @override
  String get reviewCards => 'Ôn tập thẻ';

  @override
  String get retries => 'Số lần thử lại';

  @override
  String get needsPractice => 'Cần luyện tập';

  @override
  String get uniqueCardsStudied => 'Thẻ đã học';

  @override
  String get dartConvert => 'dart:convert';

  @override
  String get env => '.env';

  @override
  String get dartUi => 'dart:ui';

  @override
  String get dartMath => 'dart:math';

  @override
  String get drawInTheOtherDirection => 'Vẽ theo hướng ngược lại ➔';

  @override
  String get fastClean => 'Nhanh & Gọn!';

  @override
  String get good2 => 'Tốt!';

  @override
  String get followTheFlow => 'Theo đúng nét.';

  @override
  String get masterful => 'Tuyệt vời!';

  @override
  String get missingTheHookEnd => 'Thiếu nét móc/kết thúc.';

  @override
  String get thai => 'Tiếng Thái';

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
  String get ink => 'mực,';

  @override
  String get stroke => 'nét,';

  @override
  String get breath => 'hơi thở.';

  @override
  String get deepseekDeepseekChat => 'deepseek/deepseek-chat';

  @override
  String get hTTPReferer => 'HTTP-Referer';

  @override
  String get xTitle => 'X-Title';

  @override
  String get data => 'data:';

  @override
  String get shadowingModeCustomSentence =>
      'Chế độ luyện nói theo câu tùy chỉnh';

  @override
  String get theExactSentenceProvided => 'câu được cung cấp chính xác';

  @override
  String get pinyinWithToneMarks2 => 'pinyin kèm dấu thanh';

  @override
  String get wXHuNH => 'Wǒ xǐhuān hē píngguǒzhī.';

  @override
  String get extractAllChineseCharactersFrom =>
      'Trích xuất tất cả ký tự Hán từ hình ảnh này. Chỉ trả về văn bản đã trích xuất — không bình luận, không định dạng, không dịch. Giữ nguyên ngắt dòng. Nếu không có ký tự Hán, trả về chuỗi trống.';

  @override
  String get householdObject => 'đồ vật trong nhà';

  @override
  String get genericLabelFromTheList => 'nhãn chung từ danh sách';

  @override
  String get gNgS => 'gōng sī';

  @override
  String get measureWord => 'lượng từ';

  @override
  String get zenInk => 'Zen & Ink';

  @override
  String get cRITICALPutTheEnglishTranslation =>
      'QUAN TRỌNG: Đặt bản dịch tiếng Anh vào khóa JSON \"english\"!';

  @override
  String get definitionInEnglish => 'định nghĩa bằng tiếng Anh';

  @override
  String get simplifiedLine0 => 'dòng giản thể 0';

  @override
  String get simplifiedLine1 => 'dòng giản thể 1';

  @override
  String get iMPORTANTRULEDoNotAddress =>
      'QUY TẮC QUAN TRỌNG: Không gọi tên người dùng. Không bao giờ sử dụng tên giả định như \"John\". Hãy nói trực tiếp với họ mà không dùng tên.';

  @override
  String get rULESAnswerIn23 =>
      'QUY TẮC: Trả lời tối đa 2–3 câu. Ưu tiên sử dụng danh sách gạch đầu dòng.';

  @override
  String get neverWriteIntroductionsSignOffs =>
      'Không bao giờ viết lời chào hỏi, kết thúc hoặc các cụm từ đệm như \"Câu hỏi hay đấy!\" hoặc \"Chắc chắn rồi!\".';

  @override
  String get useBoldForChineseCharacters =>
      'Sử dụng **in đậm** cho các ký tự Hán và thuật ngữ chính.';

  @override
  String get rULESAnswerIn232 => 'QUY TẮC: Trả lời tối đa 2–3 câu.';

  @override
  String get accept => 'Chấp nhận';

  @override
  String get pronunciationAssessment => 'Đánh giá phát âm';

  @override
  String get nBest => 'N-Tốt nhất';

  @override
  String get none => 'Không có';

  @override
  String get theCorrectedChineseText => 'văn bản tiếng Trung đã sửa';

  @override
  String get thePinyinForTheCorrected => 'pinyin cho văn bản đã sửa';

  @override
  String get theEnglishMeaningOfThe => 'nghĩa tiếng Anh của văn bản đã sửa';

  @override
  String get pNyNWithTone => 'pīnyīn kèm dấu thanh';

  @override
  String get englishTranslation2 => 'bản dịch tiếng Anh';

  @override
  String get zhNggu => 'Zhōngguó';

  @override
  String get youAreAChineseClassical =>
      'Bạn là chuyên gia văn học cổ điển Trung Quốc, cung cấp các bản tóm tắt dễ hiểu về thơ ca cổ điển Trung Quốc.';

  @override
  String get youAreAChineseCulture =>
      'Bạn là chuyên gia về văn hóa và văn học Trung Hoa. Hãy chia sẻ những hiểu biết văn hóa đầy lôi cuốn và tinh tế.';

  @override
  String get english2 => 'Tiếng Anh:';

  @override
  String get remindersWhenYouHavenT =>
      'Nhắc nhở khi bạn không sử dụng ứng dụng trong vài ngày';

  @override
  String get itSBeenAFew =>
      'Đã vài ngày rồi! Hãy dành 5 phút để học một chữ Hán mới hôm nay nhé.';

  @override
  String get abbreviationFor => 'viết tắt của';

  @override
  String get cL => 'Lượng từ:';

  @override
  String get measureWord2 => 'Lượng từ:';

  @override
  String get lu => 'lǚ:';

  @override
  String get luE => 'lǚ:e';

  @override
  String get nu => 'nǚ:';

  @override
  String get nuE => 'nǚ:e';

  @override
  String get noUser => 'không-có-người-dùng';

  @override
  String get passwordRequired => 'yêu-cầu-mật-khẩu';

  @override
  String get unsupportedProvider => 'nhà-cung-cấp-không-được-hỗ-trợ';

  @override
  String get appleRevocationUnavailable => 'không-thể-thu-hồi-apple';

  @override
  String get appleCredentialMissing => 'thiếu-thông-tin-xác-thực-apple';

  @override
  String get authenticationDidNotReturnA => 'Xác thực không trả về người dùng.';

  @override
  String get viewSubscriptionPlans => 'Xem các gói đăng ký';

  @override
  String get wrongPassword => 'sai-mật-khẩu';

  @override
  String get invalidCredential => 'thông-tin-xác-thực-không-hợp-lệ';

  @override
  String get networkRequestFailed => 'yêu-cầu-mạng-thất-bại';

  @override
  String get requiresRecentLogin => 'yêu-cầu-đăng-nhập-gần-đây';

  @override
  String get userMismatch => 'người-dùng-không-khớp';

  @override
  String get deleteAccountPassword => 'mật-khẩu-xóa-tài-khoản';

  @override
  String get deleteAccountError => 'lỗi-xóa-tài-khoản';

  @override
  String get deleteAccountSubmit => 'xác-nhận-xóa-tài-khoản';

  @override
  String get theSimplestShapesTheBeginning =>
      'Những hình thái đơn giản nhất. Khởi nguồn của vạn vật.';

  @override
  String get sunMoonWaterAndFire =>
      'Mặt trời, Mặt trăng, Nước và Lửa. Thế giới tự nhiên.';

  @override
  String get theBodyTheHeartAnd => 'Cơ thể, trái tim và gia đình.';

  @override
  String get fieldsRoofsAndToolsThe =>
      'Đồng ruộng, mái nhà và công cụ. Nền tảng của xã hội.';

  @override
  String get movementSpeechAndSustenance =>
      'Chuyển động, ngôn ngữ và sự nuôi dưỡng.';

  @override
  String get commerceClothingAndComplexArtifacts =>
      'Thương mại, y phục và vật phẩm phức tạp.';

  @override
  String get fastTrackSimpleCharacterMastered =>
      '🚀 Tăng tốc! Đã nắm vững chữ Hán cơ bản.';

  @override
  String get excellentPrecisionGhostTraceSkipped =>
      '⚡ Độ chính xác tuyệt vời! Đã bỏ qua nét mờ.';

  @override
  String get sample => 'Ví dụ:';

  @override
  String get itsThat => 'Nó/Đó';

  @override
  String get iMe => 'Tôi/Mình';

  @override
  String get stillTough => 'Vẫn/Khó';

  @override
  String get partDecide => 'Phần/Quyết định';

  @override
  String get selectTheCharacterFor => 'Chọn chữ Hán cho:';

  @override
  String get selectThePinyinFor => 'Chọn Pinyin cho:';

  @override
  String get whereAreYouGoingThe =>
      'Bạn định đi đâu? Sân bay ư? Chuyến đi khá xa đấy!';

  @override
  String get youAreAuntieChenA =>
      'Bạn là dì Trần, một người bán hàng sắc sảo chuyên kinh doanh lụa và vải vóc. Vai trò DUY NHẤT của bạn là người bán hàng. Hãy thương lượng giá cả một cách kiên quyết nhưng công bằng bằng tiếng Trung. KHÔNG BAO GIỜ thoát vai hoặc giới thiệu bản thân với bất kỳ vai trò nào khác. Hãy bắt đầu với giá cao và sẵn sàng thương lượng.';

  @override
  String get youAreDrZhangA =>
      'Bạn là bác sĩ Trương, một bác sĩ điềm tĩnh và chuyên nghiệp tại phòng khám. Vai trò DUY NHẤT của bạn là bác sĩ. Hãy hỏi về các triệu chứng và đưa ra lời khuyên y tế bằng tiếng Trung. KHÔNG BAO GIỜ thoát vai hoặc giới thiệu bản thân với bất kỳ vai trò nào khác. Hãy trấn an nhưng kỹ lưỡng.';

  @override
  String get whereDoYouFeelUncomfortable =>
      'Bạn cảm thấy khó chịu ở đâu? Bạn có bị sốt không?';

  @override
  String get youAreACloseFriend =>
      'Bạn là một người bạn thân lâu ngày gặp lại. Vai trò DUY NHẤT của bạn là bạn bè. Hãy giữ phản hồi tự nhiên, ấm áp và ngắn gọn bằng tiếng Trung. KHÔNG BAO GIỜ thoát vai hoặc giới thiệu bản thân với bất kỳ vai trò nào khác. Sử dụng ngôn ngữ thân mật phù hợp với bạn bè.';

  @override
  String get noNbest => 'không có kết quả tốt nhất';

  @override
  String get timedOut => 'hết thời gian';

  @override
  String get grading => 'Đang chấm điểm...';

  @override
  String get label1st => 'Thanh 1 ˉ';

  @override
  String get label2nd => 'Thanh 2 ˊ';

  @override
  String get label3rd => 'Thanh 3 ˇ';

  @override
  String get label4th => 'Thanh 4 ˋ';

  @override
  String get speaking2 => 'Đang nói...';

  @override
  String get sessionCompletedInYourNext =>
      'Đã hoàn thành phiên. Trong lần luyện tập tới, hãy nói câu hoàn chỉnh để nhận chẩn đoán chi tiết về phát âm và thanh điệu.';

  @override
  String get craneSoaring => 'hạc bay cao';

  @override
  String get gentleStream => 'dòng suối dịu dàng';

  @override
  String get brushAndInk => 'bút và mực';

  @override
  String get myStudent => 'học trò của tôi';

  @override
  String get honoredDisciple => 'đệ tử đáng kính';

  @override
  String get notEnoughInformation => 'Không đủ thông tin';

  @override
  String get asAnAi => 'Với tư cách là AI';

  @override
  String get goodPracticeSessionContinueFocusing =>
      'Phiên luyện tập tốt. Hãy tiếp tục tập trung vào sự tương phản cao độ rõ ràng và nhịp điệu hội thoại tự nhiên.';

  @override
  String get insideASleekFuxingBullet =>
      'Bên trong tàu cao tốc Fuxing bóng bẩy đang di chuyển với vận tốc 350 km/h từ Bắc Kinh đến Thượng Hải.';

  @override
  String get harbinIceSnowWorldWonder =>
      'Kỳ quan Thế giới Băng tuyết Cáp Nhĩ Tân';

  @override
  String get theFamousPanjiayuanWeekendFlea =>
      'Chợ trời cuối tuần Panjiayuan nổi tiếng với đầy những cuộn thư pháp, ngọc bích và đồ cổ.';

  @override
  String get jingdezhenBlueWhitePorcelainStudio =>
      'Xưởng gốm sứ xanh trắng Cảnh Đức Trấn';

  @override
  String get pekingOperaDressingRoomMakeup =>
      'Phòng thay đồ và trang điểm Kinh kịch';

  @override
  String get aHistoricTongrentangApothecaryScented =>
      'Một hiệu thuốc Đồng Nhân Đường lịch sử với hương thơm của nhân sâm, kỷ tử và hàng trăm ngăn kéo thảo dược bằng gỗ.';

  @override
  String get aVibrantPrivateNeonLit =>
      'Một phòng karaoke riêng tư rực rỡ ánh đèn neon ở Thâm Quyến với micro, đĩa trái cây và bảng điều khiển màn hình.';

  @override
  String get animeCosplayExpoInGuangzhou =>
      'Triển lãm Anime & Cosplay tại Quảng Châu';

  @override
  String get nHOHuNy =>
      'Nǐ hǎo! Huānyíng lái dào zhèlǐ, jīntiān wǒmen liáo xiē shénme ne?';

  @override
  String get surpriseMe2 => '🎲 Ngẫu nhiên';

  @override
  String get eGALivelyBanquet =>
      'ví dụ: Một bữa tiệc sôi động tại Thượng Hải...';

  @override
  String get rollCharacter2 => '🎲 Chọn nhân vật';

  @override
  String get eGACuriousCousin =>
      'ví dụ: Một người anh họ tò mò hỏi về sự nghiệp của bạn...';

  @override
  String get keepTrying => 'Cố gắng lên!';

  @override
  String get pending => 'Đang chờ...';

  @override
  String get expected => '🎯 Dự kiến';

  @override
  String get hSK2Elementary => 'HSK 2: Sơ cấp';

  @override
  String get hSK3Intermediate => 'HSK 3: Trung cấp';

  @override
  String get hSK5Advanced => 'HSK 5: Cao cấp';

  @override
  String get expressYourselfFullyWith5000 =>
      'Diễn đạt trọn vẹn với hơn 5000 từ.';

  @override
  String get hanziWriter => 'hanzi-writer';

  @override
  String get hvg => 'hvg:';

  @override
  String get unlimited => 'Không giới hạn';

  @override
  String get dueToday => 'Đến hạn hôm nay';

  @override
  String get newAvailable => 'Có bài mới';

  @override
  String get deleteAccountTile => 'delete-account-tile';

  @override
  String get giveASingleShortPractical =>
      'Đưa ra một mẹo ngắn gọn, thiết thực về cách cải thiện hình dạng, vị trí hoặc độ dài của các nét vẽ chưa chuẩn. Hãy trực tiếp và hữu ích, không dùng ngôn từ hoa mỹ hay ẩn dụ. Không sử dụng định dạng markdown.';

  @override
  String get localOnDeviceTTS => 'Cục bộ — TTS trên thiết bị';

  @override
  String get espaOl => 'Tiếng Tây Ban Nha';

  @override
  String get franAis => 'Tiếng Pháp';

  @override
  String get portuguS => 'Tiếng Bồ Đào Nha';

  @override
  String get tiNgViT => 'Tiếng Việt';

  @override
  String get koreFemaleWarm => 'Kore — Nữ, ấm áp';

  @override
  String get aoedeFemaleCheerful => 'Aoede — Nữ, vui tươi';

  @override
  String get fenrirMaleUpbeat => 'Fenrir — Nam, sôi nổi';

  @override
  String get charonMaleNewsStyle => 'Charon — Nam, phong cách bản tin';

  @override
  String get puckMaleSporty => 'Puck — Nam, năng động';

  @override
  String get systemVoice => 'Giọng hệ thống';

  @override
  String get generateAdd => 'Tạo & Thêm';

  @override
  String get moreExamples => '📝 Thêm ví dụ';

  @override
  String get usage2 => '❓ Cách dùng';

  @override
  String get translation => '💬 Dịch';

  @override
  String get collocations => '📚 Kết hợp từ';

  @override
  String get mistakes => '❌ Lỗi sai';

  @override
  String get decrease => 'Giảm';

  @override
  String get increase => 'Tăng';

  @override
  String get label0MeansThisCardType => '0 nghĩa là loại thẻ này đã bị tắt.';

  @override
  String get tapTheValueToEnter =>
      'Chạm vào giá trị để nhập giới hạn chính xác.';

  @override
  String get exactDailyLimit => 'Giới hạn hàng ngày chính xác';

  @override
  String get enter0ToDisable => 'Nhập 0 để tắt.';

  @override
  String get apply => 'Áp dụng';

  @override
  String get selectDeck => 'Chọn bộ thẻ';

  @override
  String get azureSpeechKeysNotConfigured =>
      'Chưa cấu hình khóa Azure Speech. Hãy thêm AZURE_SPEECH_KEY và AZURE_SPEECH_REGION vào tệp .env';

  @override
  String get sTARTING => 'ĐANG KHỞI ĐỘNG...';

  @override
  String get sTARTSESSION => 'BẮT ĐẦU PHIÊN HỌC';

  @override
  String get translating2 => 'Đang dịch...';

  @override
  String get chai => 'Chai biết tuốt...';

  @override
  String get oneInABillion2 => '@Một-trong-một-tỷ';

  @override
  String get businessEconomics => 'kinh doanh & kinh tế';

  @override
  String get hskPreparation => 'luyện thi HSK';

  @override
  String get liveInChina => 'sống tại Trung Quốc';

  @override
  String get comprehensiveExercise => 'bài tập tổng hợp';

  @override
  String get howToUse => 'cách sử dụng';

  @override
  String get usesOf => 'cách dùng của';

  @override
  String get appearedFirstOnMandarinBean =>
      'xuất hiện lần đầu trên Mandarin Bean';

  @override
  String get news2 => 'tin tức:';

  @override
  String get joke => 'truyện cười:';

  @override
  String get jokes => 'truyện cười:';

  @override
  String get academicScience => 'học thuật / khoa học';

  @override
  String get politicsCommunism => 'chính trị & chủ nghĩa cộng sản';

  @override
  String get foodDining => 'Ẩm thực & Ăn uống';

  @override
  String get sciFi => 'khoa học viễn tưởng';

  @override
  String get scienceFictionTech => 'Khoa học Viễn tưởng & Công nghệ';

  @override
  String get travelPlaces => 'Du lịch & Địa điểm';

  @override
  String get mythologyFantasy => 'Thần thoại & Kỳ ảo';

  @override
  String get cultureTraditions => 'Văn hóa & Truyền thống';

  @override
  String get businessEconomy => 'Kinh doanh & Kinh tế';

  @override
  String get natureAnimals => 'Thiên nhiên & Động vật';

  @override
  String get articleImg => 'ảnh bài viết';

  @override
  String get entryContentImg => '.entry-content img';

  @override
  String get zhHans => 'Giản thể';

  @override
  String get zhHant => 'Phồn thể';

  @override
  String get pLDpUVcjhvJisQCVw4YJVNTxTDrVQUgbr =>
      'PLDpUVcjhvJisQCVw4YJVNTxT-DrVQUgbr';

  @override
  String get siJin => '【Tựa Cẩm Si Jin】Phim chính | #TrươngVãnÝ #CảnhĐiềm';

  @override
  String get xiXiPicturesOfficialChannel => 'Kênh chính thức của XiXi Pictures';

  @override
  String get pLDpUVcjhvJitpknWzhJbWevf7VSVWXk2 =>
      'PLDpUVcjhvJitpknWzhJb-wevf7VSVWXk2';

  @override
  String get sIXSISTERS =>
      '【Sáu Chị Em SIX SISTERS】Phim chính | #MaiĐình #LụcNghị #ỔQuânMai #HềMỹQuyên';

  @override
  String get shineOnMeENGSUB =>
      '【骄阳似我 Shine On Me】Phụ đề Anh | #TốngUyLong #TriệuKimMạch';

  @override
  String get eNGSUBThoseDays =>
      'Phụ đề Anh【四喜 Those Days】| Đồng Dao, Tưởng Hân, Hoàng Minh Hạo, Hứa Đệ';

  @override
  String get getTheWeTVAPP => 'Tencent Video - Tải ứng dụng WeTV';

  @override
  String get liziqi2 => 'Lý Tử Thất Liziqi';

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
  String get learnMandarinWithTaiwanPlus => 'Học tiếng Trung cùng TaiwanPlus';

  @override
  String get everydayChinese => 'Tiếng Trung mỗi ngày';

  @override
  String get uCCFdR7zZ5SUXuOrEdKw => 'UCC_fdR7zZ_5SU--xuOrEdKw';

  @override
  String get tingDailyLifeInChina =>
      'Ting - Đời sống thường nhật tại Trung Quốc';

  @override
  String get tFTFOODTRAVEL => 'TFT - ẨM THỰC & DU LỊCH';

  @override
  String get uCsHMiBJ9r87fRH7VAWZw => 'UCs_h_miBJ9r8-7fRH7VAWZw';

  @override
  String get liziqi3 => 'Lý Tử Thất Liziqi: Đời một củ tỏi';

  @override
  String get label2MINCULTURALCONTEXT => '2 PHÚT BỐI CẢNH VĂN HÓA';

  @override
  String get liziqi4 => 'Lý Tử Thất Liziqi: Đồ nội thất tre';

  @override
  String get peppaPigChinese2 => 'Heo Peppa tiếng Trung: Vũng bùn';

  @override
  String get noBBCLeadArticleIs => 'Hiện không có bài viết chính nào từ BBC.';

  @override
  String get mediaThumbnail => 'media:thumbnail';

  @override
  String get bBC => 'BBC Tiếng Trung';

  @override
  String get siJin2 => 'Tự Cẩm Si Jin';

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
  String get sIXSISTERS2 => 'Sáu chị em';

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
  String get shineOnMe => 'Tỏa sáng cùng tôi';

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
  String get thoseDays => 'Những ngày ấy';

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
  String get noFunnyNoMoney => 'Không hài hước thì không có tiền';

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
  String get getTheWeTVAPP2 => 'Tải ứng dụng WeTV';

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
      'Vlog lồng tiếng Lord of Mysteries - WeTV Anime';

  @override
  String get lordOfMysteries => 'Lord of Mysteries: Lớp học huyền bí - Tập 8';

  @override
  String get lordOfMysteries2 => 'Lord of Mysteries: Lớp học huyền bí - Tập 7';

  @override
  String get lordOfMysteries3 => 'Lord of Mysteries: Lớp học huyền bí - Tập 6';

  @override
  String get lordOfMysteries4 => 'Lord of Mysteries: Lớp học huyền bí - Tập 5';

  @override
  String get lordOfMysteries5 => 'Lord of Mysteries: Lớp học huyền bí - Tập 4';

  @override
  String get lordOfMysteries6 => 'Lord of Mysteries: Lớp học huyền bí - Tập 3';

  @override
  String get pakhctn6g6A => 'Pakhctn6g6A';

  @override
  String get lordOfMysteries7 => 'Lord of Mysteries: Lớp học huyền bí - Tập 2';

  @override
  String get lordOfMysteries8 => 'Lord of Mysteries: Lớp học huyền bí - Tập 1';

  @override
  String get g5fLWO98axs => 'G5fLWO98axs';

  @override
  String get gK0eOTF2s4c => 'GK0eOTF2s4c';

  @override
  String get oSTLordOfMysteries =>
      '【OST】《Lord of Mysteries》Nhạc kết thúc《Forget-Me-Not》 Tencent Video - Anime';

  @override
  String get membersPremiere2 => 'Xem trước dành cho hội viên';

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
  String get eightHundred => 'Bát bách phương viên (Eight Hundred)';

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
  String get loveBeyondTheGrave => 'Đèn lồng ban ngày (Love Beyond the Grave)';

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
      'Hậu trường: Bí ẩn tên thật của He Simu và Duan Xu (Đèn lồng ban ngày - Love Beyond the Grave)';

  @override
  String get label5MVET41ATY => '5MVET41A-tY';

  @override
  String get bTSLoveBeyondTheGrave =>
      'Hậu trường｜Tiệc phim: Địch Lệ Nhiệt Ba và Trần Phi Vũ cùng dàn diễn viên (Đèn lồng ban ngày - Love Beyond the Grave)';

  @override
  String get bTSLoveBeyondTheGrave2 =>
      'Hậu trường｜Tiệc phim: Địch Lệ Nhiệt Ba và Trần Phi Vũ xuất hiện (Đèn lồng ban ngày - Love Beyond the Grave)';

  @override
  String get herBlaze => 'Ngọn lửa của cô ấy (Her Blaze)';

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
  String get aboutLove => 'Về tình yêu';

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
      'Tất cả đều lạc lối trong mê cung tình yêu, liệu TA sẽ phá giải thế nào? | Diễn viên: Vương Tử Văn, Lưu Vũ Ninh';

  @override
  String get pLMX26aiIvX5rSLe74r7sARps4oOqaBWD =>
      'PLMX26aiIvX5rSLe74r7sA-Rps4oOqaBWD';

  @override
  String get generationToGeneration2 => 'Đời đời kiếp kiếp';

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
  String get loveStoryInThe1970s => 'Chuyện tình thập niên 70';

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
  String get whyIsHeStillSingle => 'Tại sao anh ấy vẫn độc thân';

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
  String get theGlamorousNight => 'Đêm quyến rũ';

  @override
  String get theGlamorousNightE03 =>
      '【Đêm quyến rũ】Tập 03: Phản đòn ngoạn mục! (Giang Sơ Ảnh, Đồng Đại Vi)';

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
  String get myPageInThe90s => 'Ký ức thập niên 90';

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
      'Trích đoạn 04: Hệ thống oái oăm! Khăn giấy biến thành băng vệ sinh? Ngượng chín mặt! 【My Page in the 90s】';

  @override
  String get label03MyPageInThe =>
      'Trích đoạn 03: Đi xem mắt hộ bạn thân, ai ngờ gặp ngay nam chính? 【My Page in the 90s】';

  @override
  String get bTSXXMyPage =>
      'Hậu trường｜「Xuyên không X Trần Tinh Húc X Vương Ngọc Văn」Ai mới là người lầy lội hơn? 【My Page in the 90s】';

  @override
  String get label02MyPageInThe =>
      'Trích đoạn 02: Định chinh phục nam chính, ai ngờ nhận nhầm người? 【My Page in the 90s】';

  @override
  String get label01MyPageInThe =>
      'Trích đoạn 01: Vô lý! Tự nhiên xuyên không vào sách? Phải diễn sao đây? 【My Page in the 90s】';

  @override
  String get bTSMyPageInThe =>
      'Hậu trường｜Trần Tinh Húc và Vương Ngọc Văn va vào nhau khi trượt băng 【My Page in the 90s】';

  @override
  String get bTSMyPageInThe2 =>
      'Hậu trường｜Trần Tinh Húc và Vương Ngọc Văn đón năm mới ngọt ngào 【My Page in the 90s】';

  @override
  String get bTSMyPageInThe3 =>
      'Hậu trường｜Khoảnh khắc ngọt ngào của Trần Tinh Húc và Vương Ngọc Văn ngày Thất Tịch 【My Page in the 90s】';

  @override
  String get bTSMyPageInThe4 =>
      'Hậu trường｜Trần Tinh Húc và Vương Ngọc Văn vui chơi tại công viên giải trí 【My Page in the 90s】';

  @override
  String get myPageInThe90s2 =>
      '《My Page in the 90s》 lên sóng hôm nay, Trần Tinh Húc và Vương Ngọc Văn yêu đương ngọt ngào';

  @override
  String get myPageInThe90s3 =>
      '《My Page in the 90s》 lên sóng 22/01, chuyện tình phá cách của Trần Tinh Húc và Vương Ngọc Văn';

  @override
  String get myPageInThe90s4 =>
      '《My Page in the 90s》 ấn định ngày 22/01! Mối tình xuyên thời đại của Trần Tinh Húc và Vương Ngọc Văn';

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
      'Ngự Tứ Tiểu Ngỗ Tác 2 (The Imperial Coroner S2)';

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
  String get theDreamMaker => 'Tiểu Thành Đại Sự (The Dream Maker)';

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
      '【Tuổi Trẻ Mãi Mãi】Tập 23: Martin trở về ngõ nhỏ, bị anh em giữ chân (Hoắc Kiến Hoa, Điền Vũ, Trương Tuyết Nghênh, Kiều Chấn Vũ)';

  @override
  String get foreverYoungE25 =>
      '【Tuổi Trẻ Mãi Mãi】Tập 25: Chuẩn xác và quyết đoán! Martin dạy chị dâu cách quản lý chồng (Hoắc Kiến Hoa, Điền Vũ, Trương Tuyết Nghênh, Kiều Chấn Vũ)';

  @override
  String get foreverYoungE24 =>
      '【Tuổi Trẻ Mãi Mãi】Tập 24: Có tình địch? Martin bị cậu nhóc gọi là chú (Hoắc Kiến Hoa, Điền Vũ, Trương Tuyết Nghênh, Kiều Chấn Vũ)';

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
  String get hOMELANDGUARDIAN => 'Người Bảo Vệ|HOMELAND GUARDIAN🚔';

  @override
  String get iQIYIGetTheIQIYIAPP => 'iQIYI Suspense - Tải ứng dụng iQIYI';

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
  String get loveHasFireworks => 'Tình Yêu Có Pháo Hoa (Love Has Fireworks)';

  @override
  String get getTheWeTVAPP3 =>
      'Tencent Video - Phim Thanh Xuân - Tải ứng dụng WeTV';

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
  String get theHiddenHeirYeChen2 => 'Người Thừa Kế Bí Ẩn Diệp Thần';

  @override
  String get xtTr8ZBDpG => 'XtTr8ZBDp-g';

  @override
  String get dresmsNeverEnd => 'Lắng Nghe Gió Ngàn Dresms Never End';

  @override
  String get mamaGo => 'Mẹ Tôi Là Hoa Khôi Mama Go!';

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
      'Phim ngắn biên niên sử song tuyến 《Chuyện tình thời thanh xuân 1970》 đã ra mắt đầy ấm áp~';

  @override
  String get loveStoryInThe1970s3 =>
      'Phim ngắn 《Chuyện tình thời thanh xuân 1970》 chính thức phát hành~ Hãy cùng viết một bức thư tình bằng mọi giác quan';

  @override
  String get bTSLoveStoryInThe =>
      'BTS｜Đóng máy toàn bộ, hẹn ngày tái ngộ 【Chuyện tình thời thanh xuân 1970】';

  @override
  String get loveStoryInThe1970s4 =>
      '《Chuyện tình thời thanh xuân 1970》 Tình yêu là bài thơ ẩn giấu trong pháo hoa~';

  @override
  String get sGX3zNIuzM => 'SGX-3zNIuzM';

  @override
  String get loveStoryInThe1970s5 =>
      '《Chuyện tình thời thanh xuân 1970》 chính thức ấn định ngày phát sóng 21 tháng 2~';

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
  String get theTruth => 'Dấu vết thời gian (The Truth)';

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
      'Hậu trường｜Phỏng vấn cặp đôi \"Out of Character\"—Ai mới là người kỳ quặc hơn? 《My Page in the 90s》 Tencent Video';

  @override
  String get rEk9xALNODE => 'REk9xALNODE';

  @override
  String get label04MyPageInThe2 =>
      'Trích đoạn 04 Hệ thống ép buộc thêm tình tiết! Khăn giấy biến thành băng vệ sinh? Thật là xấu hổ! 《My Page in the 90s》 Tencent Video';

  @override
  String get label03MyPageInThe2 =>
      'Trích đoạn 03 Đi xem mắt hộ bạn thân, ai ngờ gặp ngay nam chính? 《My Page in the 90s》 Tencent Video';

  @override
  String get xsb7BJppy0 => 'Xsb7B-Jppy0';

  @override
  String get label02MyPageInThe2 =>
      'Trích đoạn 02 Định chinh phục nam chính, ai ngờ lại nhận nhầm người? 《My Page in the 90s》 Tencent Video';

  @override
  String get label01MyPageInThe2 =>
      'Trích đoạn 01 Vô lý! Xuyên không vào sách? Tôi phải diễn vở kịch này thế nào đây? 《My Page in the 90s》 Tencent Video';

  @override
  String get zSpXoH9ok => 'Z_SpXo-H9ok';

  @override
  String get myPageInThe90s5 =>
      '《My Page in the 90s》Hậu trường｜Trần Tinh Húc và Vương Ngọc Văn va vào nhau khi trượt băng';

  @override
  String get myPageInThe90s6 =>
      '《My Page in the 90s》Phát sóng hôm nay! Trần Tinh Húc và Vương Ngọc Văn cùng hệ thống tình yêu ngọt ngào';

  @override
  String get bTSMyPageInThe5 =>
      'Hậu trường｜Tương tác hài hước của Trần Tinh Húc và Vương Ngọc Văn【My Page in the 90s】';

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
  String get dearSecretary => 'Thư ký thân yêu của tôi';

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
  String get mKLZpubV04 => 'Thẻ ghi nhớ';

  @override
  String get wXevXICxAQ => 'Thứ tự nét';

  @override
  String get xRRUT4fbgQ => 'Lặp lại ngắt quãng';

  @override
  String get q5WMmVzsGQ => 'Thư viện cổ văn';

  @override
  String get dOFDys0lAJ0 => 'Đọc trực tiếp';

  @override
  String get wadaICY1qo => 'Từ vựng HSK';

  @override
  String get label44PA4p4dXY => 'Gia sư AI';

  @override
  String get pLyX50Z72L2xbAikt1CHmEyvZrQv1XJu => 'Bắt đầu bài học';

  @override
  String get foreverYoung2 => 'Tuổi trẻ';

  @override
  String get omVSnG9O8g => 'Cài đặt';

  @override
  String get label2qKWcz2zU0 => 'Hồ sơ của tôi';

  @override
  String get label1WMYcdS8oE => 'Tiến độ học tập';

  @override
  String get u0fCO4W9LHg => 'Phiên âm Pinyin';

  @override
  String get m9xLRZlwO => 'Hán tự';

  @override
  String get vo5jCUWPNAo => 'Thanh điệu';

  @override
  String get vb1N5r3zZFo => 'Luyện viết';

  @override
  String get lightOfDawn => 'Bình minh';

  @override
  String get teDx70IJcw => 'Bài học mới';

  @override
  String get mF2299T610 => 'Ôn tập';

  @override
  String get yLNGIsWlU => 'Danh sách từ';

  @override
  String get mUZMDrFnNw => 'Cấu trúc chữ';

  @override
  String get pi2b8VYkM8 => 'Phát âm';

  @override
  String get pLyX50Z72L2xDQ9d02geVDYSbkol6u9Z => 'Tiếp tục học';

  @override
  String get wWy3IO1E9cw => 'Chế độ tối';

  @override
  String get wW9DI00Rx3w => 'Chế độ sáng';

  @override
  String get a6Y3wzD0I => 'Thông báo';

  @override
  String get wXEkwsviSA => 'Trợ giúp';

  @override
  String get uq15J34lYB0 => 'Đăng xuất';

  @override
  String get sc7Fg23kmUM => 'Chia sẻ';

  @override
  String get kaJ2rw9Aqk => 'Phản hồi';

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
  String get sniperButterfly => 'Bướm Xạ Thủ (Sniper Butterfly)';

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
      '《Bướm Xạ Thủ》 khởi chiếu 04/12! Vượt giới hạn vì tình yêu';

  @override
  String get sniperButterflyFullVersion1 =>
      '《Bướm Xạ Thủ》 Bản đầy đủ 1-15 | Diễn viên: Trần Nghiên Hy, Châu Kha Vũ - Tencent Video';

  @override
  String get sniperButterflyFullVersion16 =>
      '《Bướm Xạ Thủ》 Bản đầy đủ 16-30 | Diễn viên: Trần Nghiên Hy, Châu Kha Vũ - Tencent Video';

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
  String get allRise => 'Bắt đầu ngay All Rise';

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
      'Đúng người đúng thời điểm Love is Always Online';

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
  String get loveOnTheTurquoiseLand =>
      'Kiêu Khởi Thanh Nhưỡng Love on the Turquoise Land';

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
      '《Tại sao anh ấy vẫn độc thân》 khởi chiếu 16/11! Câu chuyện tình yêu trưởng thành của Hoắc Kiến Hoa và Chu Châu.';

  @override
  String get whyIsHeStillSingle3 =>
      '《Tại sao anh ấy vẫn độc thân》 Bản đầy đủ | Diễn viên: Hoắc Kiến Hoa, Chu Châu - Tencent Video';

  @override
  String get ijgFlHRPHw => 'Ijg-FlHRPHw';

  @override
  String get whyIsHeStillSingle4 =>
      '《Tại sao anh ấy vẫn độc thân》 Bản đầy đủ 1 | Diễn viên: Hoắc Kiến Hoa, Chu Châu - Tencent Video';

  @override
  String get whyIsHeStillSingle5 =>
      '《Tại sao anh ấy vẫn độc thân》 Bản đầy đủ 2 | Diễn viên: Hoắc Kiến Hoa, Chu Châu - Tencent Video';

  @override
  String get yVGKe9xonY => 'YV-GKe9xonY';

  @override
  String get qKftsk37mXo => 'QKftsk37mXo';

  @override
  String get ccxy931pac => 'ccxy9-31pac';

  @override
  String get uc5hawjBFU => 'Uc5hawj_bFU';

  @override
  String get fightForLove => 'Gối đầu sơn hà (Fight for Love)';

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
  String get iMNobody => 'Dị Nhân Chi Hạ (I\'m Nobody)';

  @override
  String get persona => 'Nhân vật Persona';

  @override
  String get d5CPVc0EIY => 'D5CPVc0E-IY';

  @override
  String get pJsHXm9ZsC => 'pJsHXm9Zs-c';

  @override
  String get vYRvNE7Yk => '-VYRvNE-7Yk';

  @override
  String get lightBeyondTheReed => 'Ánh sáng bên kia lau sậy';

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
  String get thePrisonerOfBeauty => 'Chiết Yêu (Bản tóm tắt)';

  @override
  String get wsGeYBRO => 'wsGeYB_-r_o';

  @override
  String get thePrisonerOfBeauty2 =>
      'Chiết Yêu: Tiểu Kiều thay chị gả cho kẻ thù, đêm tân hôn đã đối đầu với phu quân';

  @override
  String get thePrisonerOfBeauty3 =>
      'Chiết Yêu: Tiểu Kiều phá âm mưu phá đê, từ đối đầu chuyển sang bảo vệ lẫn nhau';

  @override
  String get thePrisonerOfBeauty4 =>
      'Chiết Yêu: Tiểu Kiều giả bệnh tranh giành chủ quyền, Ngụy Thiệu công khai bảo vệ vợ';

  @override
  String get thePrisonerOfBeauty5 =>
      'Chiết Yêu: Tiểu Kiều phá giải âm mưu hãm hại, Ngụy Thiệu thừa nhận nàng là nữ quân';

  @override
  String get thePrisonerOfBeauty6 =>
      'Chiết Yêu: Tiểu Kiều phá giải kế ly gián, Ngụy Thiệu bảo vệ vợ trước mẹ chồng';

  @override
  String get thePrisonerOfBeauty7 =>
      'Chiết Yêu: Ngụy Nghiễm gây chuyện, Tiểu Kiều và Ngụy Thiệu nảy sinh khủng hoảng lòng tin';

  @override
  String get thePrisonerOfBeauty8 =>
      'Chiết Yêu: Tô Nga Hoàng hãm hại Tiểu Kiều, Ngụy Thiệu phá án giúp tình cảm thêm gắn kết';

  @override
  String get thePrisonerOfBeauty9 =>
      'Chiết Yêu: Tiểu Kiều và Ngụy Thiệu trúng độc, nàng dùng trí tuệ cứu phu quân';

  @override
  String get rNYFWNcb8o => 'RNYFW-Ncb8o';

  @override
  String get thePrisonerOfBeauty10 =>
      'Chiết Yêu: Ngụy Thiệu tặng chiến mã và trâm cài, lo lắng khi vợ mất tích';

  @override
  String get thePrisonerOfBeauty11 =>
      'Chiết Yêu: Ngụy Thiệu ghen tuông bảo vệ vợ, sau khi xa cách lại thấy nhớ nhung';

  @override
  String get thePrisonerOfBeauty12 =>
      'Chiết Yêu: Ngụy Thiệu cõng Tiểu Kiều, giải tỏa hiểu lầm giúp tình cảm thêm sâu đậm';

  @override
  String get thePrisonerOfBeauty13 =>
      'Chiết Yêu: Kiều Từ thăm chị khiến Ngụy Thiệu ghen, hai vợ chồng thề nguyện trọn đời';

  @override
  String get thePrisonerOfBeauty14 =>
      'Chiết Yêu: Ngụy Nghiễm rời quê vì Tiểu Kiều, Thiệu - Kiều làm hòa sau tranh cãi';

  @override
  String get ry1BWClaV0 => 'ry1BWCla-V0';

  @override
  String get thePrisonerOfBeauty15 =>
      'Chiết Yêu: Biến cố đêm tân hôn, Tiểu Kiều dùng trí lui địch, Ngụy Thiệu nhận lỗi';

  @override
  String get o8nFcvzyvM => 'O8n-FcvzyvM';

  @override
  String get thePrisonerOfBeauty16 =>
      'Chiết Yêu: Ngụy Thiệu cùng Tiểu Kiều về quê nhà, cha vợ chấp nhận con rể';

  @override
  String get krsrk6wSAy8 => 'Krsrk6wSAy8';

  @override
  String get thePrisonerOfBeauty17 =>
      '《Chiết Yêu - Bản rút gọn》 Kiều Việt phản bội, Ngụy Lương tử trận, Đại Kiều bị bắt cóc, liều mình phản sát | Diễn viên: Tống Tổ Nhi, Lưu Vũ Ninh - Tencent Video';

  @override
  String get v26fn6w270 => 'V-26fn6w270';

  @override
  String get thePrisonerOfBeauty18 =>
      '《Chiết Yêu - Bản rút gọn》 Ngụy Lương tử trận, Ngụy Cừ đứt tay, Đại Kiều rơi lầu, Lưu Diễm diệt vong | Diễn viên: Tống Tổ Nhi, Lưu Vũ Ninh - Tencent Video';

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
      'Nhóm làm bài chê tôi chậm? Tổng tài nửa đêm leo cửa sổ gửi PPT, bảo vệ đuổi theo | Tencent Video';

  @override
  String get zPBZ1KRQ3hY => 'ZPBZ1KRQ3hY';

  @override
  String get aThousandMilesToYour =>
      'Quá Biến Thiên Thành Tài Thức Quân (Ngàn dặm tìm người)';

  @override
  String get getTheWeTVAPP4 =>
      'Tencent Video - Phim cổ trang - Tải ứng dụng WeTV';

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
  String get theInescapable => 'Tỏa Trâm (Không thể thoát)';

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
  String get pursuitOfJade2 => 'Trục Ngọc (Truy tìm ngọc quý)';

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
  String get label2M3Ls74gZY => 'Thẻ ghi nhớ';

  @override
  String get p8DW4Gef70o => 'Thứ tự nét';

  @override
  String get d4duxTP0FDE => 'Lặp lại ngắt quãng';

  @override
  String get b1T03rs9WGI => 'Thư viện Hán văn cổ';

  @override
  String get ruBRX68XPg => 'Đọc trực tiếp';

  @override
  String get aX5eShfmFk => 'Từ vựng HSK';

  @override
  String get fCsjHXbBlE => 'Gia sư AI';

  @override
  String get m9xKlm95oc => 'Phiên âm Pinyin';

  @override
  String get xh0z4YV9v2s => 'Hán tự';

  @override
  String get iufzj2MLPs => 'Thanh điệu';

  @override
  String get x6uXEQgWuM => 'Cài đặt';

  @override
  String get wlz3IhZptM => 'Hồ sơ học tập';

  @override
  String get p10GCq30oNI => 'Bắt đầu học';

  @override
  String get b65UYuRtpE => 'Tiếp tục';

  @override
  String get generationToGeneration222 =>
      '《Giang hồ dạ vũ thập niên đăng》 khởi chiếu 22/02! Cùng theo dõi hành trình của thế hệ mới.';

  @override
  String get label6yOPycBAyU => 'Lịch sử';

  @override
  String get lIAUBGNQM => 'Yêu thích';

  @override
  String get sU12uaTtBg => 'Tìm kiếm';

  @override
  String get label05nLbIKPkQ => 'Cấp độ';

  @override
  String get rKGFPIzgpO => 'Bài kiểm tra';

  @override
  String get shO2wXA6U => 'Chia sẻ';

  @override
  String get dNsDNXcJgM => 'Tải xuống';

  @override
  String get w0NMLE9Hw => 'Thông báo';

  @override
  String get lTtwLNkDHY => 'Trợ giúp';

  @override
  String get the300LoyalGhosts2 => '300 Trung hồn Đại Minh';

  @override
  String get zj1Mh0bRE => 'Đăng nhập';

  @override
  String get kj6122rOzW => 'Đăng ký';

  @override
  String get ftgF1Hu9Ko => 'Chỉnh sửa';

  @override
  String get cnFIQ9QT4M => 'Xóa';

  @override
  String get ajdFKQ4uq8 => 'Lưu';

  @override
  String get danceOfThePhoenix => 'Thả Thính Phượng Minh';

  @override
  String get f0uIRYSOwo => 'F0uIRY_SOwo';

  @override
  String get extraordinary2 => 'Phi Phàm';

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
      '《Ngự Tứ Tiểu Ngỗ Tác 2》 khởi chiếu 15/01, cặp đôi Sở Du trở lại!';

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
  String get rebirthForYou => 'Gia Nam Truyện';

  @override
  String get f9eLAZQDUds => 'F9eLAZQDUds';

  @override
  String get aVowInTheDark2 => 'Luyến Luyến Phong Lăng Độ';

  @override
  String get theUltimateVowUnknownTo => 'Quân Bất Tri';

  @override
  String get duMRGzTeKs => 'DuM-rGzTeKs';

  @override
  String get pLs3DOuT3JlGTynSBKz3Z5DcDzwwmqSOf =>
      'PLs3DOuT3JlGTynSBKz3-z5DcDzwwmqSOf';

  @override
  String get theChangAnYouth => 'Trường An Thiếu Niên Hành';

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
  String get thePrincessDecree2 => 'Sắc lệnh Công chúa';

  @override
  String get ppiNYsUwOA => 'PpiNYs-uwOA';

  @override
  String get label83tIjIiqM => '-_83tIjIiqM';

  @override
  String get p4cKjzSHFw => 'P4cKjz-sHFw';

  @override
  String get babysitter => 'Bảo mẫu';

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
  String get herPhoenixMajesty2 => 'Phượng Hoàng Truyện';

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
  String get aGirlLikeMe2 => 'Ta Là Nữ Nhân Như Thế (A Girl Like Me)';

  @override
  String get p4YsJ5WtBw => 'p4YsJ5Wt-bw';

  @override
  String get pIg2oXFWS8 => 'pIg2oXFWS-8';

  @override
  String get hrJz2C0Fxs => 'hrJz-2C0Fxs';

  @override
  String get mL0phSCWJY => 'mL0phSC-wJY';

  @override
  String get sideStoryOfFoxVolant2 =>
      'Phi Hồ Ngoại Truyện (Side Story of Fox Volant)';

  @override
  String get pLs3DOuT3JlGQCkd77fhalA8WxMD3OT4Q =>
      'PLs3DOuT3JlGQCkd77fhalA8Wx-mD3OT4Q';

  @override
  String get aFlowerOnTheContinent2 =>
      'Hữu Hoa Tại Châu (A Flower On The Continent)';

  @override
  String get aFlowerOnTheContinent3 =>
      '[Hữu Hoa Tại Châu] Tiểu vương gia làm con tin bị Hoa cô nương ép làm công chúa, còn phải ở chung';

  @override
  String get aFlowerOnTheContinent4 =>
      '[Hữu Hoa Tại Châu] Hoa cô nương lộ tẩy khi giả gái, tiểu vương gia liều mạng bảo vệ lại bị vu oan';

  @override
  String get aFlowerOnTheContinent5 =>
      '[Hữu Hoa Tại Châu] Hoa Tích Ngọc phát hiện kẻ thù giết cha là cha của Ninh Huyền Châu, lập tức trở mặt';

  @override
  String get aFlowerOnTheContinent6 =>
      '[Hữu Hoa Tại Châu] Hoa Tích Ngọc mặc áo cưới xông vào doanh trại địch, liều mạng cứu Ninh Huyền Châu suýt mất mạng';

  @override
  String get aFlowerOnTheContinent7 =>
      '[Hữu Hoa Tại Châu] Hai nước ký hòa ước, Ninh Huyền Châu xé chiếu chỉ nhất quyết đòi cưới Hoa Tích Ngọc';

  @override
  String get aFlowerOnTheContinent8 =>
      '[Hữu Hoa Tại Châu] Hoa Tích Ngọc cắt tay lấy máu làm thuốc, Ninh Huyền Châu tố cáo hoàng đế giết cha nàng';

  @override
  String get aFlowerOnTheContinent9 =>
      '[Hữu Hoa Tại Châu] Hoa Tích Ngọc biết cha bị cha Ninh Huyền Châu giết, chặt đứt cành cây đính ước giữa rừng hoa';

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
  String get hilariousFamily22 => 'Gia đình vui nhộn 2';

  @override
  String get sliceOfLife => 'Đời thường';

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
  String get legendOfTheFemaleGeneral => 'Cẩm Nguyệt Như Ca';

  @override
  String get highlightLegendOfTheFemale => 'Điểm nhấn 【Cẩm Nguyệt Như Ca】';

  @override
  String get a40F2TEZrms => 'A40F2TEZrms';

  @override
  String get lYQ5iND4 => 'lYQ5iN-d-_4';

  @override
  String get bTSLegendOfTheFemale =>
      'Hậu trường: Chúc mừng sinh nhật Chu Dã 🎂! 【Cẩm Nguyệt Như Ca】';

  @override
  String get bTSLegendOfTheFemale2 =>
      'Hậu trường: Chúc mừng sinh nhật Thừa Lỗi 🎂! 【Cẩm Nguyệt Như Ca】';

  @override
  String get bTSLegendOfTheFemale3 =>
      'Hậu trường: Cảnh chiến đấu mãn nhãn của cặp đôi Đại Ngụy 【Cẩm Nguyệt Như Ca】';

  @override
  String get bTS520LegendOfThe =>
      'Hậu trường: Kế hoạch hẹn hò 520 của Tiêu Yến 【Cẩm Nguyệt Như Ca】';

  @override
  String get bTSLegendOfTheFemale4 =>
      'Hậu trường: Khoảnh khắc đáng yêu của Chu Dã khi say rượu 【Cẩm Nguyệt Như Ca】';

  @override
  String get pLs3DOuT3JlGRucYIZLqmT7FO5IWDWrP =>
      'PLs3DOuT3JlGRuc_yIZLqmT7FO5IWD-WrP';

  @override
  String get thePrincessSGambit => 'Đào Hoa Ánh Giang Sơn';

  @override
  String get highlightThePrincessSGambit =>
      'Tuyển tập nổi bật 【Mưu Kế Của Công Chúa】';

  @override
  String get qJRbuw2hJ3s => 'qJRbuw2hJ3s';

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
      'Clip Áo đỏ nhuốm tuyết trắng! Giang Đào Hoa từ biệt quê hương vì em trai 【Mưu Kế Của Công Chúa】';

  @override
  String get clipThePrincessSGambit2 =>
      'Clip Vợ lẽ gây khó dễ ngày tân hôn? Đào Hoa bình tĩnh đối phó 【Mưu Kế Của Công Chúa】';

  @override
  String get clipThePrincessSGambit3 =>
      'Clip Giả treo cổ bị vạch trần, Thẩm Tại Dã châm kim: Diễn tiếp đi! 【Mưu Kế Của Công Chúa】';

  @override
  String get clipThePrincessSGambit4 =>
      'Clip Thẩm Tướng xử án tàn nhẫn! Truy quét vụ án tiền giả, tham quan run sợ 【Mưu Kế Của Công Chúa】';

  @override
  String get eDrJjtCRF0 => 'eDr-jjtCRF0';

  @override
  String get clipThePrincessSGambit5 =>
      'Clip Sát thủ đeo mặt nạ lộ tẩy, Đào Hoa phá án: Đôi chân đã bán đứng ngươi! 【Mưu Kế Của Công Chúa】';

  @override
  String get clipPlayThePrincessS =>
      'Clip Thẩm Tại Dã dùng trâm cài ép hỏi Đào Hoa 【Mưu Kế Của Công Chúa】';

  @override
  String get label58K8GxhXlQ => '58K8-gxhXlQ';

  @override
  String get clipThePrincessSGambit6 =>
      'Clip Lần đầu gặp gỡ đầy kịch tính! Thẩm Tại Dã và Đào Hoa trúng độc 【Mưu Kế Của Công Chúa】';

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
      '【Bản đầy đủ giới hạn】Vân Tương Truyện | The Ingenious One | iQIYI 👑Tham gia hội viên để xem trọn bộ ngay!';

  @override
  String get iQIYIGetTheIQIYIAPP2 => 'iQIYI 爱奇艺 - Tải ứng dụng iQIYI';

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
      '【TRỌN BỘ】👮ĐƯỜNG VỀ💕 | Tỉnh Bách Nhiên, Đàm Tùng Vận | iQIYI Philippines';

  @override
  String get iQIYIPhilippinesGetTheIQIYI =>
      'iQIYI Philippines - Tải ứng dụng iQIYI';

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
      '【Lồng tiếng AI】Mr. BAD | Trần Triết Viễn, Thẩm Nguyệt | iQIYI Philippines';

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
      '🌸【Tiên hiệp kỳ ảo】🎋Love of the Divine Tree (Tiên Đài Hữu Thụ) | Đặng Vi × Hướng Hàm Chi | Trọn bộ | iQIYI 👑Đăng ký hội viên để xem trọn bộ ngay!';

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
  String get pLIPiKkSFpK9MiE3quPZjNnu7RgviYDy => 'Danh sách phát';

  @override
  String get fYFcg3qNJE => 'Học tập';

  @override
  String get uWRVG89Kn8M => 'Thẻ ghi nhớ';

  @override
  String get iBUh0B2XAMQ => 'Nét chữ';

  @override
  String get wQlTnSp5s => 'Lặp lại ngắt quãng';

  @override
  String get edAqyr6ieU => 'Thư viện cổ văn';

  @override
  String get pLIPiKkSFpK8wb8Yzzh4eptkOEn2LPtDf => 'Đọc trực tiếp';

  @override
  String get label93ckJe0R6c => 'Từ vựng HSK';

  @override
  String get vzb1BHRshM => 'Gia sư AI';

  @override
  String get yC69yjVyOo => 'Cài đặt';

  @override
  String get pLIPiKkSFpK8MdPQg72ceDNUGjf0mhENz => 'Lịch sử học tập';

  @override
  String get iEC4DBbzBI => 'Phiên âm';

  @override
  String get yf7VWSAbOU => 'Hán tự';

  @override
  String get sF0QfbuHtQ => 'Thanh điệu';

  @override
  String get yPcsflr52s => 'Cấu trúc';

  @override
  String get md04meyJlA => 'Bài kiểm tra';

  @override
  String get iof4jeN6LG4 => 'Thông tin';

  @override
  String get label8FjmZttLM => 'Cấp độ';

  @override
  String get cCnli0HQ3IE => 'Đang tải';

  @override
  String get label8EXPB74Dyc => 'Hoàn thành';

  @override
  String get fULLMyDearGuardianJohnny =>
      '【TRỌN BỘ】🕊️Quân Trang Thân Yêu | Hoàng Cảnh Du, Lý Thấm | iQIYI';

  @override
  String get fN0lxPL4Qa0 => 'Chia sẻ';

  @override
  String get bjlqxe76Cc => 'Yêu thích';

  @override
  String get pLIPiKkSFpKHKjDQgjOj98MaZq0gm => 'Thư viện của tôi';

  @override
  String get tcWqflGCUY => 'Bắt đầu';

  @override
  String get rZfxh4rSg => 'Tiếp tục';

  @override
  String get label1ORyfeHBGG => 'Thoát';

  @override
  String get pLIPiKkSFpK9cwfQqamjvymbElQlrV6do => 'Cài đặt tài khoản';

  @override
  String get vKvu1urDSps => 'Trợ giúp';

  @override
  String get dB2fAHAIw30 => 'Đăng xuất';

  @override
  String get pLlCrV9TCfzMYJebfwvzDDQzDFbY9XqvE =>
      'PLlCrV9TCfzMYJebfwvzDDQzDFbY-9XqvE';

  @override
  String get theBestThingZhangLinghe =>
      '🌸【Tình yêu chữa lành】🎋The Best Thing - Yêu em | Zhang Linghe × Xu Ruohan | FULL | iQIYI 👑Tham gia Hội viên để xem trọn bộ ngay!';

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
      '📽️【Tập 01 2026】Phim bộ Trung Quốc: Tái Sinh | Li Yunrui / Huangyang Tiantian / Zhang Kangle ⛵😍 Phim cổ trang 2026 #冰湖重生';

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
      '【TRỌN BỘ】🏹Fated Hearts | Lý Thấm, Trần Triết Viễn | iQIYI Philippines';

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
  String get shHZmbjrqI => 'Nhật ký học tập';

  @override
  String get label7X5IzmrLCw => 'Thẻ ghi nhớ';

  @override
  String get nI1kp3v97O => 'Thứ tự nét';

  @override
  String get ea8enhWKTo0 => 'Lặp lại ngắt quãng';

  @override
  String get yL0RBWIo2iw => 'Thư viện cổ văn';

  @override
  String get hX1u0R19FY => 'Đọc trực tiếp';

  @override
  String get cEGtoc5chDc => 'Từ vựng HSK';

  @override
  String get qXKk36teGLc => 'Gia sư AI';

  @override
  String get pLIPiKkSFpKZTWsxZO5xUAlAsUEFOl3K =>
      'Đăng nhập để đồng bộ tiến trình học tập của bạn';

  @override
  String get mtO6K9Y59Q => 'Cài đặt';

  @override
  String get kVop5QZCM => 'Hồ sơ';

  @override
  String get lX8cA1yLAg => 'Bắt đầu học';

  @override
  String get v7m8WNX1gxE => 'Xem lại';

  @override
  String get bGf1clBUq0 => 'Thêm từ mới';

  @override
  String get lPA6cWd9vqA => 'Thống kê';

  @override
  String get pfckLVY64 => 'Phát âm';

  @override
  String get pLIPiKkSFpKN3T51FbkSIbF5IQ0RxhVm =>
      'Đăng ký gói Premium để mở khóa toàn bộ tính năng';

  @override
  String get aH80GizsvY => 'Bài học';

  @override
  String get jI2ISWehQ => 'Tìm kiếm';

  @override
  String get label7rwGdyAl0g => 'Cấp độ HSK';

  @override
  String get kF4rfnm9qdo => 'Luyện viết';

  @override
  String get v1ae2rgrl70 => 'Phiên âm Pinyin';

  @override
  String get c9D8kCt3k => 'Hán tự';

  @override
  String get zY4ALWb5lw => 'Thanh điệu';

  @override
  String get qUvwUdI73Y => 'Gợi ý';

  @override
  String get iT670fTpFQ => 'Kiểm tra';

  @override
  String get b6t7LGBPK => 'Danh sách từ';

  @override
  String get w9QYDN3nxTc => 'Chế độ tối';

  @override
  String get w9NPQe4Z5kE => 'Thông báo';

  @override
  String get tQSHAlsaxqw => 'Trợ giúp';

  @override
  String get tN0ATkrc2zw => 'Thẻ ghi nhớ';

  @override
  String get label7tsZeZfLtI => 'Thứ tự nét';

  @override
  String get w59SaAa6Ck => 'Lặp lại ngắt quãng';

  @override
  String get lSBiko45p8U => 'Thư viện Hán văn cổ';

  @override
  String get t2PwfV1JIE => 'Đọc trực tiếp';

  @override
  String get bz75CXZ3c => 'Từ vựng HSK';

  @override
  String get nEEt9D9uR4g => 'Gia sư AI';

  @override
  String get dFv86C0wEg8 => 'Hán tự';

  @override
  String get nWijSsYBUI => 'Phiên âm Pinyin';

  @override
  String get ui2O9fffvWM => 'Thanh điệu';

  @override
  String get kMK9ZIL5vIE => 'Cài đặt';

  @override
  String get pZxPXGSNk => 'Hồ sơ';

  @override
  String get lGe1BEo7wL8 => 'Thống kê';

  @override
  String get wtVVEt4NxI => 'Bài học';

  @override
  String get ggXL7dEPA => 'Kiểm tra';

  @override
  String get mPO0drxj4XI => 'Lịch sử';

  @override
  String get qYkUzAJo => 'Yêu thích';

  @override
  String get mU4PJGdOxg => 'Tìm kiếm';

  @override
  String get hOWSRDXSjb4 => 'Đăng nhập';

  @override
  String get nttqxJL3ES => 'Đăng ký';

  @override
  String get tJCmewUT4O => 'Quên mật khẩu';

  @override
  String get sp7QFdPm3o => 'Bắt đầu học';

  @override
  String get qI7c50Jcxbk => 'Tiếp tục';

  @override
  String get tM0RxsWCms => 'Hoàn thành';

  @override
  String get pLIPiKkSFpK6Iyv3Gsa1hZqwSLQ4z34u => 'Nâng cấp lên Premium';

  @override
  String get p1c9AW9VNY => 'Chia sẻ';

  @override
  String get eTwGAe5RiM => 'Phản hồi';

  @override
  String get vSDFc4ivKU => 'Trợ giúp';

  @override
  String get label2UNAa30mF0 => 'Thông báo';

  @override
  String get iLP6X3nSYE => 'Chỉnh sửa';

  @override
  String get mo4kd8rg3yU => 'Thẻ ghi nhớ';

  @override
  String get xt8m39rI9o => 'Thứ tự nét';

  @override
  String get oFLWTHOJJo => 'Lặp lại ngắt quãng';

  @override
  String get pLlRMBKO6RkY69nj6AJ051lj7vSGrkNxZ => 'Thư viện Hán văn cổ';

  @override
  String get label3gTpyQenT0 => 'Đọc trực tiếp';

  @override
  String get nM3BDMI4YS => 'Từ vựng HSK';

  @override
  String get hudgy0oFTz4 => 'Gia sư AI';

  @override
  String get lVc0U1sJIBU => 'Phiên âm Pinyin';

  @override
  String get gBTqOwTPTU => 'Hán tự';

  @override
  String get tN0iGRSk => 'Thanh điệu';

  @override
  String get gkEBMyB9TM => 'Cài đặt';

  @override
  String get bw3XWYzoI => 'Hồ sơ cá nhân';

  @override
  String get fullBrightEyesInThe =>
      '【Trọn bộ】Bright Eyes in the Dark | Johnny Huang, Zhang Jing Yi | iQIYI Philippines';

  @override
  String get jalmOqeImY => 'Bắt đầu học';

  @override
  String get vUuzPUBkas => 'Tiếp tục';

  @override
  String get ni1jN2ECMY => 'Lịch sử';

  @override
  String get v5qeq2caORg => 'Thống kê';

  @override
  String get cB64rYJ2tX4 => 'Yêu thích';

  @override
  String get qwyz2k6oymc => 'Tìm kiếm';

  @override
  String get gQYaqUf4 => 'Chế độ luyện tập';

  @override
  String get tqHC6KtyoI => 'Kiểm tra';

  @override
  String get hvsJOV10Q => 'Bài học mới';

  @override
  String get label9LFPEXffyQ => 'Ôn tập';

  @override
  String get bMbhR77eps => 'Cấp độ';

  @override
  String get olkxX4m0m4 => 'Cài đặt âm thanh';

  @override
  String get vE8nY1UC2zo => 'Thông báo';

  @override
  String get pLIPiKkSFpKZjc5dsVYfFD44oWYA1YZ => 'Đăng xuất';

  @override
  String get gZDlH6PN3M => 'Trợ giúp';

  @override
  String get iw4jJBB5z7A => 'Phản hồi';

  @override
  String get hOTu6yklewA => 'Chia sẻ';

  @override
  String get vJqSl1U6CE => 'Thẻ ghi nhớ';

  @override
  String get yF3ZBEnNaA => 'Thứ tự nét';

  @override
  String get at8v7Xp7XX4 => 'Lặp lại ngắt quãng';

  @override
  String get ctXWz6p3RI => 'Thư viện Hán văn';

  @override
  String get gsuEr3Rwo => 'Đọc trực tiếp';

  @override
  String get cvkAplxMt0 => 'Từ vựng HSK';

  @override
  String get ssQiWv0MEA => 'Gia sư AI';

  @override
  String get aaDlYQswEc => 'Hán tự';

  @override
  String get oaDLF7MQF0 => 'Phiên âm Pinyin';

  @override
  String get pLIPiKkSFpK9jSaLiXXKZUvwfh7ROuLy =>
      'Bạn đã hoàn thành __PH0__ từ hôm nay!';

  @override
  String get g0nqbugnDI => 'Bắt đầu học';

  @override
  String get tnHgUzjPNQ => 'Cài đặt';

  @override
  String get nM7ZeWM1g => 'Hồ sơ';

  @override
  String get sUqbEIap2M => 'Lịch sử';

  @override
  String get x0qW6MwABw => 'Thống kê';

  @override
  String get lANXfM0Hmc => 'Đánh dấu';

  @override
  String get y84UUFKMZf4 => 'Thêm vào danh sách';

  @override
  String get mGPFI2bfKPE => 'Xóa';

  @override
  String get f3wSwhf0z8 => 'Chỉnh sửa';

  @override
  String get qFITVBXVj2g => 'Chia sẻ';

  @override
  String get pLyT8L9yeLXCR7t2xuK0L7L4qIRBTnA2n =>
      'Bạn có chắc chắn muốn xóa __PH0__ không?';

  @override
  String get aY1Wv805lUw => 'Xác nhận';

  @override
  String get w44Q3K2QJY => 'Hủy';

  @override
  String get kJn1gifAmok => 'Tiếp theo';

  @override
  String get xwEsWU6WI => 'Quay lại';

  @override
  String get gt93TaUaco => 'Tìm kiếm';

  @override
  String get label0C62qBO6o => 'Cấp độ HSK';

  @override
  String get label7DqIz7YqcA => 'Thanh điệu';

  @override
  String get xh5K9iCMoo => 'Phát âm';

  @override
  String get aKGp1lOCRTI => 'Hoàn tất';

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
      '🎥✨【Phụ đề Anh】Phim Giả tưởng Trung Quốc | Giả tưởng, Phiêu lưu【 iQIYI MOVIE THEATER-Đăng ký ngay】';

  @override
  String get iQIYIMOVIETHEATERGetThe =>
      'iQIYI MOVIE THEATER - Tải ứng dụng iQIYI';

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
      '🎀【Phim ngắn】Phụ đề Anh | Trọn bộ | Tải ứng dụng WeTV / Tencent Video để xem thêm';

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
      '【Trọn bộ】Vẻ Đẹp Của Sự Kiên Cường | Cúc Tịnh Y, Phim bộ | iQIYI';

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
      '🔥Đang thịnh hành【Tử Dạ Quy】Trọn bộ | Chuyện tình người và yêu cùng phá án | Hứa Khải, Điền Hi Vi | Phụ đề Việt';

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
  String get gNiRWpeMws => 'Thẻ ghi nhớ';

  @override
  String get cVO0hA3P8O => 'Thứ tự nét';

  @override
  String get label9afZnkZaPs => 'Lặp lại ngắt quãng';

  @override
  String get pLIPiKkSFpK9cUoS9l5spDGFvN2Crmdn => 'Thư viện Hán văn cổ';

  @override
  String get nLMKI6PT3o => 'Đọc trực tiếp';

  @override
  String get zR7i5LASYI => 'Từ vựng HSK';

  @override
  String get keKMrR1Yss => 'Gia sư AI';

  @override
  String get juRTPVpVXA => 'Phiên âm Pinyin';

  @override
  String get yzSy3klEQU => 'Hán tự';

  @override
  String get label8A7WTDaaGs => 'Thanh điệu';

  @override
  String get pLIPiKkSFpK8hIu32ZhKKsO2wlADWaCBU => 'Luyện viết chữ Hán';

  @override
  String get oVN1y6LPWD4 => 'Cài đặt';

  @override
  String get qU7t6C4Gc => 'Hồ sơ cá nhân';

  @override
  String get fk9JXDCOG4 => 'Tiến độ học tập';

  @override
  String get uC7Mnd3qJc => 'Danh sách từ vựng';

  @override
  String get glHm8Zs8Ac => 'Bài học mới';

  @override
  String get l2w4TUDxmsg => 'Ôn tập';

  @override
  String get cPLU864rP14 => 'Tìm kiếm';

  @override
  String get a4mUs48UAU => 'Cộng đồng';

  @override
  String get bVmda5m2mN4 => 'Trợ giúp';

  @override
  String get mZUf8J2gZA4 => 'Nâng cấp tài khoản';

  @override
  String get tQiZtftwY => 'Cài đặt âm thanh';

  @override
  String get bR38d9KJoos => 'Chế độ ngoại tuyến';

  @override
  String get pLIPiKkSFpKOHffjOp4RqWHtE2OYq => 'Lịch sử học tập';

  @override
  String get fyuHVqsXMI => 'Thông báo';

  @override
  String get yJB0nFJNw0 => 'Chia sẻ';

  @override
  String get label21RxwDPr8k => 'Phản hồi';

  @override
  String get zZTZ149pQ => 'Đăng xuất';

  @override
  String get o5qvwYEyQ0 => 'Chủ đề';

  @override
  String get bGGDIBw4TIw => 'Thông tin ứng dụng';

  @override
  String get gU0lbFUBwg8 => 'GU0lbFUBwg8';

  @override
  String get yTfshUkXmG => 'yTfshUkXm-g';

  @override
  String get yOUTUBEAPIKEY => 'YOUTUBE_API_KEY=';

  @override
  String get partContentDetails => '?part=contentDetails';

  @override
  String get fallInLove => 'Phải lòng';

  @override
  String get myGirl => 'Cô gái của tôi';

  @override
  String get firstRomance2 => 'Mối tình đầu';

  @override
  String get fallFor => 'Say đắm';

  @override
  String get uCD83JhUFQXRDwC6S8caCQ => 'UCD_83Jh-UFQXRDwC6S8caCQ';

  @override
  String get uCFh5x5AZHQQ6FaGKnGQXDA => 'UCFh5x5AZHQQ6FaGKnG-QXDA';

  @override
  String get uCRABdhiBHX4BieJfPCd2pg => 'UCRABdhiBHX4Bie-jfPCd2pg';

  @override
  String get hiddenLove2 => 'Vụng Trộm Không Thể Giấu';

  @override
  String get loveBetweenFairyAndDevil2 => 'Thương Lan Quyết';

  @override
  String get loveLikeTheGalaxy2 => 'Tinh Hán Xán Lạn';

  @override
  String get myJourneyToYou2 => 'Vân Chi Vũ';

  @override
  String get mysteriousLotusCasebook2 => 'Liên Hoa Lâu';

  @override
  String get reset => 'Đặt lại';

  @override
  String get theLongBallad2 => 'Trường Ca Hành';

  @override
  String get theUntamed2 => 'Trần Tình Lệnh';

  @override
  String get wordOfHonor2 => 'Sơn Hà Lệnh';

  @override
  String get lightOfDawn2 => 'Nhân Chi Sơ | Ánh Bình Minh';

  @override
  String get hOMELANDGUARDIAN2 => 'Thủ Thành Giả | Người Bảo Vệ Quê Hương';

  @override
  String get searching2 => 'Đang tìm kiếm...';

  @override
  String get verse => 'Câu thơ';

  @override
  String get allStories2 => 'Tất cả câu chuyện';

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
  String get char2 => '+ Hán tự +';

  @override
  String get sentenceText2 => '.văn-bản-câu';

  @override
  String get ttsBtn => 'nút-tts';

  @override
  String get hanziTranslateBtn => 'nút-dịch-hán-tự';

  @override
  String get label10px16px => '10px 16px';

  @override
  String get articleArticlePostContentMain =>
      'bài-viết, .bài-viết, .bài-đăng, .nội-dung, chính';

  @override
  String get ttsActiveWord => '.từ-tts-đang-chạy';

  @override
  String get ttsActiveWord2 => 'từ-tts-đang-chạy';

  @override
  String get upperIntermediate2 => 'Trung-Cao cấp';

  @override
  String get hanziDarkModeStyle => 'kiểu-chế-độ-tối-hán-tự';

  @override
  String get sharedaddyJpPostFlairEntry =>
      '.sharedaddy, #jp-post-flair, .thông-tin-bài-viết, .wpcnt, .thông-tin-tác-giả, #bình-luận, .bình-luận, .chân-trang-bài-viết, chân-trang, .bài-viết-liên-quan, .nút-chia-sẻ';

  @override
  String get aiInsightBanner => 'biểu-ngữ-ai-insight';

  @override
  String get summaryToggleBtn => 'nút-bật-tắt-tóm-tắt';

  @override
  String get toggleChevron => 'biểu-tượng-bật-tắt';

  @override
  String get summaryText => 'văn-bản-tóm-tắt';

  @override
  String get documentBodyInnerText => 'document.body.innerText';

  @override
  String get documentTitle => 'document.title';

  @override
  String get processing => 'Đang xử lý...';

  @override
  String get keepItUp => 'Tốt lắm! Hãy tiếp tục phát huy';

  @override
  String get minutesDay => 'Phút / Ngày';

  @override
  String get consistencyIsTheInkThat =>
      '\"Sự kiên trì là nét mực tạo nên nhân cách.\"';

  @override
  String get businessCareer => 'Kinh doanh & Sự nghiệp';

  @override
  String get travelSurvival => 'Du lịch & Sinh tồn';

  @override
  String get label05MinDay => '05 Phút / Ngày';

  @override
  String get label10MinDay => '10 Phút / Ngày';

  @override
  String get label20MinDay => '20 Phút / Ngày';

  @override
  String get label30MinDay => '30 Phút / Ngày';

  @override
  String get dynamicDecksStrokeAnalysis => 'Bộ thẻ động & Phân tích nét chữ';

  @override
  String get subscriptionsAreTemporarilyUnavailablePl =>
      'Đăng ký hiện tạm thời không khả dụng. Vui lòng thử lại sau.';

  @override
  String get trialReminder => 'Nhắc nhở dùng thử';

  @override
  String get turnOnNotificationsIfYou =>
      'Bật thông báo nếu bạn muốn nhận nhắc nhở trước khi thời gian dùng thử kết thúc. Cài đặt đăng ký trên App Store của bạn là nguồn thông tin chính xác nhất.';

  @override
  String get label2Months => '2 tháng';

  @override
  String get label3Months => '3 tháng';

  @override
  String get label6Months => '6 tháng';

  @override
  String get billingPeriod => 'chu kỳ thanh toán';

  @override
  String get chooseASubscription => 'Chọn gói đăng ký';

  @override
  String get startFreeTrial => 'Bắt đầu dùng thử miễn phí';

  @override
  String get smartNewsDict => 'Tin tức & Từ điển thông minh';

  @override
  String get hSK16AIDecks => 'HSK 1-6 & Bộ thẻ AI';

  @override
  String get continueWithTemporaryPremium => 'Tiếp tục với Premium tạm thời';

  @override
  String get testProductUnavailable => 'Sản phẩm thử nghiệm không khả dụng';

  @override
  String get paymentIsChargedToYour =>
      'Khoản thanh toán sẽ được tính vào tài khoản App Store của bạn.';

  @override
  String get subscriptionsRenewAutomaticallyUnlessCan =>
      'Gói đăng ký tự động gia hạn trừ khi bị hủy';

  @override
  String get atLeast24HoursBefore =>
      'ít nhất 24 giờ trước khi kết thúc chu kỳ hiện tại.';

  @override
  String get privacyPolicy => 'Chính sách bảo mật';

  @override
  String get closePurchaseOffer => 'Đóng ưu đãi mua hàng';

  @override
  String get loading => 'Đang tải...';

  @override
  String get analyzingImage2 => 'Đang phân tích hình ảnh…';

  @override
  String get extractingChineseText2 => 'Đang trích xuất văn bản tiếng Trung…';

  @override
  String get lookingUpVocabulary2 => 'Đang tra cứu từ vựng…';

  @override
  String get deselectAll => 'Bỏ chọn tất cả';

  @override
  String get selectAll => 'Chọn tất cả';

  @override
  String get worldChineseLiteraryMasterpiece =>
      'Kiệt tác văn học thế giới & Trung Hoa.';

  @override
  String get classic => 'Cổ điển';

  @override
  String get literature => 'Văn học';

  @override
  String get theOriginAwakening => 'Nguồn gốc & Sự thức tỉnh';

  @override
  String get turbulentHorizonsTheJourney => 'Chân trời biến động & Hành trình';

  @override
  String get trialsTribulationsDevotion => 'Thử thách, Gian nan & Tận tâm';

  @override
  String get theClashOfWitsBravery => 'Cuộc đấu trí & Lòng dũng cảm';

  @override
  String get theGrandClimaxResolution => 'Cao trào & Kết thúc';

  @override
  String get everlastingLegacyEpilogue => 'Di sản vĩnh cửu & Đoạn kết';

  @override
  String get acrossTheVastExpanseOf =>
      'Trải dài khắp đất trời bao la, các nhân vật theo đuổi định mệnh và niềm tin qua những thử thách sâu sắc.';

  @override
  String get everyDialogueAndEncounterWithin =>
      'Mỗi cuộc đối thoại và gặp gỡ trong câu chuyện đều mang theo vẻ đẹp của tinh thần nhân loại và dấu ấn của thời đại.';

  @override
  String get followingTheFlowOfProse =>
      'Theo dòng văn chương, độc giả vượt qua hàng thế kỷ để cùng chia sẻ những thăng trầm của các nhân vật huyền thoại.';

  @override
  String get preQin => 'Tiền Tần';

  @override
  String get theGoddessNWaRepairing => 'Nữ Oa vá trời';

  @override
  String get artsTraditions => 'Nghệ thuật & Truyền thống';

  @override
  String get femaleWarm => 'Nữ, ấm áp';

  @override
  String get femaleCheerful => 'Nữ, vui tươi';

  @override
  String get maleUpbeat => 'Nam, sôi nổi';

  @override
  String get maleNewsStyle => 'Nam, phong cách bản tin';

  @override
  String get maleSporty => 'Nam, năng động';

  @override
  String get onDevice => 'Trên thiết bị';

  @override
  String get label15Minutes => '15 Phút';

  @override
  String get label30Minutes => '30 Phút';

  @override
  String get label45Minutes => '45 Phút';

  @override
  String get selectChapter => 'Chọn chương';

  @override
  String get andContinuesToBeStudied =>
      'và tiếp tục được nghiên cứu, tôn vinh qua nhiều thế hệ độc giả.';

  @override
  String get label1Poem => '1 Bài thơ';

  @override
  String get label1Chapter => '1 Chương';

  @override
  String get localDeviceVoice2 => 'Giọng đọc trên thiết bị';

  @override
  String get weeklyAzureQuotaReachedSwitching =>
      'Đã đạt hạn mức Azure hàng tuần — chuyển sang giọng đọc trên thiết bị';

  @override
  String get sleepTimer2 => 'Hẹn giờ tắt · Sleep Timer';

  @override
  String get tableOfContents2 => 'Mục lục · Table of Contents';

  @override
  String get hanziMaster10 => 'HanziMaster/1.0';

  @override
  String get spanishItalianRussianClassics => 'Kinh điển Tây Ban Nha, Ý & Nga';

  @override
  String get englishAmericanGlobalClassics => 'Kinh điển Anh, Mỹ & Thế giới';

  @override
  String get whileStrategicallyEmbeddingWordsYou =>
      'đồng thời lồng ghép chiến lược các từ bạn đang gặp khó khăn để bạn có thể học chúng trong ngữ cảnh.';

  @override
  String get poetryPainting => 'thơ-họa';

  @override
  String get contactSinosparkCom => 'contact@sinospark.com';

  @override
  String get shadowingStudioIsADedicated =>
      'Shadowing Studio là không gian chuyên biệt để luyện tập bắt chước người bản ngữ. Bạn hãy nghe một cụm từ, ghi âm lại giọng mình và so sánh sóng âm cũng như điểm phát âm để hoàn thiện ngữ điệu.';

  @override
  String get theVoicesInAIStories =>
      'Truyện AI và Nhập vai sử dụng giọng tổng hợp do các mô hình chuyển văn bản thành giọng nói tiên tiến tạo ra, được tinh chỉnh để phát âm tiếng Trung rõ ràng và tự nhiên. Một số tính năng cũng có thể dùng giọng cục bộ của thiết bị.';

  @override
  String get theWebExplorerAllowsYou =>
      'Web Explorer cho phép bạn duyệt bất kỳ trang web tiếng Trung nào. Khi gặp từ khó, chỉ cần chạm vào từ đó để mở thẻ Quick Look, cung cấp ngay phiên âm Pinyin, bản dịch và cấp độ HSK.';

  @override
  String get zenModeStripsAwayDistracting =>
      'Zen Mode loại bỏ các yếu tố gây xao nhãng, quảng cáo và bố cục phức tạp trên trang web, mang đến cho bạn môi trường đọc thư pháp tinh gọn, tập trung hoàn toàn vào văn bản.';

  @override
  String get weUseAnIntelligentAlgorithm =>
      'Chúng tôi sử dụng thuật toán thông minh để dự đoán thời điểm bạn sắp quên một từ. Những từ bạn thấy khó sẽ xuất hiện thường xuyên hơn, trong khi những từ bạn đã nắm vững sẽ được lên lịch ôn tập xa hơn trong tương lai.';

  @override
  String get usage3 => 'Cách dùng:';

  @override
  String get tutorialOneExplanation =>
      'Đây là số MỘT (Yī). Luôn viết từ Trái sang Phải.';

  @override
  String get tutorialWaterExplanation =>
      'Đây là chữ NƯỚC (Shuǐ) đầy đủ. Khi làm bộ thủ bên trái, nó biến đổi thành \'氵\' (Bộ Chấm Thủy)!';

  @override
  String get tutorialRadicalsExplanation =>
      'Hán tự được xây dựng từ các khối cơ bản gọi là BỘ THỦ. Chúng mang lại ý nghĩa hoặc chủ đề cốt lõi cho chữ đó.';

  @override
  String get tutorialLettersExplanation =>
      'Hán tự không chỉ là các chữ cái. Chúng là những bức tranh được lưu giữ theo thời gian. Để làm chủ chúng, bạn phải học cách theo sát nét viết.';

  @override
  String get tutorialGalaxyExplanation =>
      'Bản đồ Thiên hà đang chờ đợi. Hãy làm chủ các Mặt trời (Bộ thủ) để mở khóa các Hành tinh (Hán tự).';

  @override
  String get onboardingDailyLifeTravel => 'Đời sống & Du lịch';

  @override
  String get onboardingPhilosophyIdioms => 'Triết học & Thành ngữ';

  @override
  String get onboardingBusinessCareerMulti => 'Kinh doanh &\nSự nghiệp';

  @override
  String get onboardingTravelSurvivalMulti => 'Du lịch &\nSinh tồn';

  @override
  String get onboardingHskCertificationMulti => 'Chứng chỉ\nHSK';

  @override
  String get onboardingCulturalAppreciationMulti => 'Tìm hiểu\nVăn hóa';

  @override
  String get practiceReminders => 'Nhắc nhở luyện tập';

  @override
  String get oneOptionalDailyReminderTo =>
      'Một thông báo nhắc nhở hàng ngày để luyện tiếng Trung';

  @override
  String get aFewMinutesOfChinese => 'Dành vài phút học tiếng Trung nhé? 🌱';

  @override
  String get keepYourProgressMovingWith =>
      'Duy trì tiến độ của bạn với một phiên luyện tập ngắn.';

  @override
  String get xuX => 'xué xí';

  @override
  String get toStudyToLearn => 'học tập';

  @override
  String get pNgYou => 'péng you';

  @override
  String get fXiN => 'fā xiàn';

  @override
  String get toDiscover => 'khám phá';

  @override
  String get jiNCh => 'jiān chí';

  @override
  String get toPersist => 'kiên trì';

  @override
  String get yNgQ => 'yǒng qì';

  @override
  String get zhHu => 'zhì huì';

  @override
  String get chNgZhNg => 'chéng zhǎng';

  @override
  String get toGrow => 'phát triển';

  @override
  String get pNgJNg => 'píng jìng';

  @override
  String get calmPeaceful => 'bình lặng · an yên';

  @override
  String get xWNg => 'xī wàng';

  @override
  String get lJi => 'lǐ jiě';

  @override
  String get toUnderstand => 'thấu hiểu';

  @override
  String get xGuN => 'xí guàn';

  @override
  String get wNNuN => 'wēn nuǎn';

  @override
  String get warmthWarm => 'ấm áp';

  @override
  String get zhuNZh => 'zhuān zhù';

  @override
  String get toFocus => 'tập trung';

  @override
  String get definitionExpansionButton => 'nút-mở-rộng-định-nghĩa';

  @override
  String get wenigerAnzeigen => 'Thu gọn';

  @override
  String get mostrarMenos => 'Thu gọn';

  @override
  String get afficherMoins => 'Thu gọn';

  @override
  String get mostraMeno => 'Thu gọn';

  @override
  String get showFewer => 'Thu gọn';

  @override
  String get masterLin => 'Sư phụ Lâm';

  @override
  String get xiaoMei => 'Tiểu Mỹ';

  @override
  String get thePoet => 'Thi nhân';

  @override
  String get aQiang => 'A Cường';

  @override
  String get vivian => 'Vivian';

  @override
  String get formalWise => 'Trang trọng & uyên bác';

  @override
  String get casualFriendly => 'Gần gũi & thân thiện';

  @override
  String get poeticAncient => 'Thi vị & cổ kính';

  @override
  String get slangInternet => 'Tiếng lóng & internet';

  @override
  String get trendyModern => 'Hiện đại & thời thượng';

  @override
  String get designYourOwn => 'Tự thiết kế';

  @override
  String get theBambooSwaysAndThe =>
      'Trúc lay trong gió, học giả đợi chờ lời bạn như cơn mưa sớm mai...';

  @override
  String get yourCustomPersonaIsActive =>
      'Nhân vật tùy chỉnh của bạn đã được kích hoạt. Hãy nhập tin nhắn để bắt đầu trò chuyện.';

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
  String get staleDictionaryExpansionResponse =>
      'Phản hồi mở rộng từ điển đã cũ';

  @override
  String get dictionaryExpansionWasEmpty => 'Không có dữ liệu mở rộng từ điển';

  @override
  String get explicationDTaillEDisponible => 'Có sẵn giải thích chi tiết';

  @override
  String get ausfHrlicheErklRungVerf => 'Có sẵn giải thích chi tiết';

  @override
  String get explicaciNDetalladaDisponible => 'Có sẵn giải thích chi tiết';

  @override
  String get spiegazioneDettagliataDisponibile => 'Có sẵn giải thích chi tiết';

  @override
  String get explicaODetalhadaDisponVel => 'Có giải thích chi tiết';

  @override
  String get detailedExplanationAvailable => 'Có giải thích chi tiết';

  @override
  String get oneOptionalDailyPracticeReminder =>
      'Một lời nhắc luyện tập hàng ngày tùy chọn';

  @override
  String get chooseOneOptionalDailyPractice =>
      'Chọn một lời nhắc luyện tập hàng ngày tùy chọn.';

  @override
  String get practiceReminder => 'Lời nhắc luyện tập';

  @override
  String get oneGentleReminderADay =>
      'Một lời nhắc nhẹ nhàng mỗi ngày, chỉ khi bạn cần';

  @override
  String get finishingPracticeSilencesTodayS =>
      'Hoàn thành bài tập sẽ tắt lời nhắc hôm nay. Xem lại và';

  @override
  String get reEngagementAlertsAreCombined =>
      'các thông báo nhắc nhở được kết hợp để không bị chồng chéo.';

  @override
  String get processing2 => 'Đang xử lý…';

  @override
  String get wDKIChu => 'wǒ dǎ kāi chuāng hu';

  @override
  String get listen => 'Nghe';

  @override
  String get notice => 'Lưu ý';

  @override
  String get fourTones => 'Bốn thanh điệu';

  @override
  String get write => 'Viết';

  @override
  String get recap => 'Tóm tắt';

  @override
  String get playbackDidNotStart => 'Không thể phát âm thanh';

  @override
  String get audioIsUnavailableYouCan =>
      'Âm thanh hiện không khả dụng. Bạn vẫn có thể đọc và tiếp tục.';

  @override
  String get microphoneAccessWasNotGranted =>
      'Quyền truy cập micrô chưa được cấp. Bạn có thể bật trong Cài đặt.';

  @override
  String get recordingIsUnavailableRightNow =>
      'Tính năng ghi âm hiện không khả dụng.';

  @override
  String get listeningToYourTones => 'Đang lắng nghe thanh điệu của bạn…';

  @override
  String get noRecording => 'Không có bản ghi âm';

  @override
  String get weCouldNotScoreThat =>
      'Chúng tôi không thể chấm điểm bản ghi này, đây là bản so sánh thanh điệu mẫu.';

  @override
  String get listenForTheLowDipping =>
      'Hãy lắng nghe thanh 3 trầm và xuống giọng.';

  @override
  String get firstHearATinyMoment =>
      'Trước tiên, hãy nghe một đoạn tiếng Trung ngắn. Chưa cần ghi nhớ vội.';

  @override
  String get loadingAudio => 'Đang tải âm thanh…';

  @override
  String get listenToThePassage => 'Nghe đoạn văn';

  @override
  String get continueAction => 'Tiếp tục';

  @override
  String get noticeHowMeaningSoundAnd =>
      'Hãy chú ý cách ý nghĩa, âm thanh và chữ Hán kết hợp với nhau.';

  @override
  String get shadowOneSentence => 'Nhại lại một câu';

  @override
  String get listenOnceThenHoldThe =>
      'Nghe một lần, sau đó giữ nút micro và đọc lại câu đó.';

  @override
  String get hearItAgain => 'Nghe lại';

  @override
  String get stopAndCheckMyTones => 'Dừng và kiểm tra thanh điệu của tôi';

  @override
  String get useMicrophone => 'Sử dụng micro';

  @override
  String get iCanTSpeakRight => 'Hiện tại tôi không thể nói';

  @override
  String get tapACharacterToCompare =>
      'Chạm vào một chữ Hán để so sánh thanh điệu của bạn với mẫu, sau đó nghe các thanh 1–4.';

  @override
  String get tryHandwriting => 'Thử viết tay';

  @override
  String get seeWhatYouLearned => 'Xem lại những gì bạn đã học';

  @override
  String get inAFewMinutesYou =>
      'Chỉ trong vài phút, bạn đã sử dụng chính phương pháp tạo nên các bài học của mình.';

  @override
  String get listenedToChineseInContext => 'Đã nghe tiếng Trung trong ngữ cảnh';

  @override
  String get shadowedASentence => 'Đã nhại lại một câu';

  @override
  String get comparedMandarinTones => 'Đã so sánh thanh điệu tiếng Trung';

  @override
  String get practicedARealCharacter => 'Đã luyện tập một chữ Hán thực tế';

  @override
  String get qNgchNXiOy =>
      'Qīngchén, xiǎoyǔ tíng le. Wǒ dǎkāi chuānghu, tīngjiàn niǎor zài shù shàng chànggē. Xīn de yì tiān kāishǐ le.';

  @override
  String get atDawnTheLightRain =>
      'Rạng sáng, mưa phùn đã tạnh. Tôi mở cửa sổ, nghe tiếng chim hót trên cây. Một ngày mới bắt đầu.';

  @override
  String get learnThroughRealVideos => 'Học qua video thực tế';

  @override
  String get followInteractiveSubtitlesLookUp =>
      'Theo dõi phụ đề tương tác, tra từ tức thì và biến mọi video thành một bài học.';

  @override
  String get videoLearningScreenshot => 'Ảnh chụp màn hình học qua video';

  @override
  String get turnAnyBookIntoA =>
      'Biến bất kỳ cuốn sách nào thành bài học và sách nói';

  @override
  String get readNaturallyWithPronunciationDefinition =>
      'Đọc tự nhiên với phát âm, định nghĩa và bản dịch luôn sẵn sàng khi bạn cần.';

  @override
  String get bookReaderScreenshot => 'Ảnh chụp màn hình trình đọc sách';

  @override
  String get speakWithTheRightRhythm =>
      'Tự do trò chuyện cùng AI và thanh điệu trực tiếp';

  @override
  String get shadowNativeAudioAndVisualize =>
      'Nhại theo âm thanh bản ngữ và hình ảnh hóa cả bốn thanh điệu khi khả năng phát âm của bạn cải thiện.';

  @override
  String get shadowingAndTonesScreenshot =>
      'Ảnh chụp màn hình luyện nhại và thanh điệu';

  @override
  String get understandEveryCharacter => 'Hiểu rõ từng chữ Hán';

  @override
  String get exploreMeaningPronunciationComponentsStr =>
      'Khám phá ý nghĩa, cách phát âm, bộ thủ, thứ tự nét và từ vựng hữu ích tại một nơi.';

  @override
  String get characterDictionaryScreenshot =>
      'Ảnh chụp màn hình từ điển chữ Hán';

  @override
  String get learnChineseWithoutLimits => 'Học tiếng Trung không giới hạn';

  @override
  String get watchReadSpeakAndUnderstand =>
      'Xem, đọc, nói và hiểu tiếng Trung với một người bạn đồng hành học tập toàn diện.';

  @override
  String get seeWhatPremiumUnlocks => 'Xem các tính năng mở khóa bởi Premium';

  @override
  String get scrollToExploreTheComplete =>
      'Cuộn để khám phá trải nghiệm học tập trọn vẹn';

  @override
  String get cOMINGSOON => 'SẮP RA MẮT';

  @override
  String get guidedHandwritingPractice => 'Luyện viết chữ Hán có hướng dẫn';

  @override
  String get scannerAndLiveTranslation => 'Quét và dịch trực tiếp';

  @override
  String get hSK16AndAI => 'Bộ thẻ HSK 1–6 và AI';

  @override
  String get smartSpacedRepetition2 => 'Lặp lại ngắt quãng thông minh';

  @override
  String get progressAndStreakTracking => 'Theo dõi tiến độ và chuỗi ngày học';

  @override
  String get learningToolsInOnePlace => 'Công cụ học tập tại một nơi';

  @override
  String get everythingIncluded => 'Bao gồm tất cả';

  @override
  String get paymentIsChargedToYour2 =>
      'Thanh toán sẽ được tính vào tài khoản App Store của bạn. Gói đăng ký tự động gia hạn trừ khi bị hủy ít nhất 24 giờ trước khi kết thúc kỳ hiện tại.';

  @override
  String get yourFirstWeekOfTracked => 'Tuần đầu tiên luyện tập có theo dõi';

  @override
  String get sameNumberOfCardsAs => 'Số lượng thẻ bằng tuần trước';

  @override
  String cardsComparedWithLastWeek(String change) {
    return '$change thẻ so với tuần trước';
  }

  @override
  String get todaySPractice => 'Luyện tập hôm nay';

  @override
  String get goalCompleteAnythingMoreIs =>
      'Đã đạt mục tiêu — học thêm là một điểm cộng.';

  @override
  String get aSmallAchievableTargetNo =>
      'Một mục tiêu nhỏ, dễ đạt được. Không bị phạt nếu nghỉ một ngày.';

  @override
  String get thisWeek => 'Tuần này';

  @override
  String get minutes => 'Phút';

  @override
  String get activeDays => 'Ngày hoạt động';

  @override
  String dayStreakCount(int count) {
    return 'Chuỗi $count ngày';
  }

  @override
  String get masterChineseOneStrokeAt => 'Làm chủ tiếng Trung, từng nét một';

  @override
  String get dictionaryExpansionButton => 'nút-mở-rộng-từ-điển';

  @override
  String get kIErweiterterWRterbucheintrag => 'Chi tiết từ điển mở rộng bởi AI';

  @override
  String get detalleAmpliadoPorIA => 'Chi tiết từ điển mở rộng bởi AI';

  @override
  String get dTailEnrichiParL => 'Chi tiết từ điển mở rộng bởi AI';

  @override
  String get aI => 'Chi tiết từ điển mở rộng bởi AI';

  @override
  String get detailKamusYangDiperluasAI => 'Chi tiết từ điển mở rộng bởi AI';

  @override
  String get dettaglioDelDizionarioAmpliatoDall =>
      'Chi tiết từ điển mở rộng bởi AI';

  @override
  String get aI2 => 'Chi tiết từ điển mở rộng bởi AI';

  @override
  String get aI3 => 'Chi tiết từ điển mở rộng bởi AI';

  @override
  String get detalheDeDicionRioExpandido => 'Chi tiết từ điển mở rộng bởi AI';

  @override
  String get aI4 => 'Chi tiết từ điển mở rộng bởi AI';

  @override
  String get chiTiTTI => 'Chi tiết từ điển mở rộng bởi AI';

  @override
  String get aI5 => 'Chi tiết từ điển mở rộng bởi AI';

  @override
  String get aIExpandedDictionaryDetail => 'Chi tiết từ điển mở rộng bởi AI';

  @override
  String get cetteEntrEEstBr =>
      'Mục từ này khá ngắn. Bạn có thể xem giải thích chi tiết.';

  @override
  String get dieserEintragIstKurzEine =>
      'Mục từ này khá ngắn. Bạn có thể xem giải thích chi tiết.';

  @override
  String get estaEntradaEsBreveHay =>
      'Mục từ này khá ngắn. Bạn có thể xem giải thích chi tiết.';

  @override
  String get questaVoceBreveDisponibileUna =>
      'Mục từ này khá ngắn. Bạn có thể xem giải thích chi tiết.';

  @override
  String get estaEntradaBreveEstDispon =>
      'Mục từ này khá ngắn. Bạn có thể xem giải thích chi tiết.';

  @override
  String get thisDictionaryEntryIsBrief =>
      'Mục từ này khá ngắn. Bạn có thể xem giải thích chi tiết.';

  @override
  String get dVelopperEnFranAis => 'Mở rộng giải thích';

  @override
  String get aufDeutschErweitern => 'Mở rộng giải thích';

  @override
  String get ampliarEnEspaOl => 'Mở rộng giải thích';

  @override
  String get approfondisciInItaliano => 'Mở rộng giải thích';

  @override
  String get expandirEmPortuguS => 'Mở rộng giải thích';

  @override
  String get expandDefinition => 'Mở rộng giải thích';

  @override
  String get impossibleDeChargerLExplication => 'Không thể tải giải thích.';

  @override
  String get dieErklRungKonnteNicht => 'Không thể tải giải thích.';

  @override
  String get noSePudoCargarLa => 'Không thể tải giải thích.';

  @override
  String get impossibileCaricareLaSpiegazione => 'Không thể tải giải thích.';

  @override
  String get nOFoiPossVel => 'Không thể tải giải thích.';

  @override
  String get unableToLoadTheExplanation => 'Không thể tải phần giải thích.';

  @override
  String get failedToGenerateStoryN => 'Không thể tạo câu chuyện:\\n\$e';

  @override
  String get thematic => 'Theo chủ đề';

  @override
  String get deckFlashcards => 'Bộ thẻ (Flashcards)';

  @override
  String get searchLibraryOrTypeCustom =>
      'Tìm kiếm thư viện hoặc nhập tùy chỉnh';

  @override
  String get hSKLevel => 'HSK \$level';

  @override
  String get analysisFailedE => 'Phân tích thất bại: \$e';

  @override
  String get extractionFailedE => 'Trích xuất thất bại: \$e';

  @override
  String get simplifyFailedE => 'Đơn giản hóa thất bại: \$e';

  @override
  String get translationFailedE => 'Dịch thất bại: \$e';

  @override
  String get failedToSaveExtractedWords2 =>
      'Không thể lưu các từ đã trích xuất: \$error';

  @override
  String youActualTargetExpected(String actual, String expected) {
    return 'Bạn: $actual  ·  Mục tiêu: $expected';
  }

  @override
  String get improveTheLocalVoice => 'Cải thiện giọng đọc cục bộ';

  @override
  String get higherQualityOfflineMandarin =>
      'Tiếng Trung ngoại tuyến chất lượng cao hơn';

  @override
  String get removeDownload => 'Xóa bản tải xuống?';

  @override
  String get removeDownload2 => 'Xóa tải xuống';

  @override
  String get tag => '#\$tag';

  @override
  String get voiceFemaleWarm => 'Nữ, ấm áp';

  @override
  String get voiceFemaleCheerful => 'Nữ, vui tươi';

  @override
  String get voiceMaleUpbeat => 'Nam, sôi nổi';

  @override
  String get voiceMaleNewsStyle => 'Nam, phong cách tin tức';

  @override
  String get voiceMaleSporty => 'Nam, thể thao';

  @override
  String get voiceOnDeviceTts => 'TTS trên thiết bị';

  @override
  String get voiceSystemVoice => 'Giọng hệ thống';

  @override
  String get applySessionGradesToSpacedRepetition =>
      'Áp dụng kết quả phiên học vào hệ thống Lặp lại ngắt quãng (Chế độ Nói)';

  @override
  String get unableToLoadThisSectionPleaseTryAgain =>
      'Không thể tải phần này. Vui lòng thử lại.';

  @override
  String get removeDownloadQuestion => 'Xóa bản tải xuống?';

  @override
  String get removeDownloadContent => 'Remove downloaded content?';

  @override
  String get removeDownloadAction => 'Xóa tải xuống';

  @override
  String get removeDownloadButton => 'Xóa tải xuống';

  @override
  String cardsCount(num count) {
    return '$count Cards';
  }

  @override
  String get aiSummary => 'Tóm tắt AI';

  @override
  String get readability => 'Độ dễ đọc';

  @override
  String get translateAction => 'Dịch';

  @override
  String get checkingDownload => '?ang ki?m tra b?n t?i xu?ng';

  @override
  String downloadingBook(int percent) {
    return '?ang t?i xu?ng: $percent%';
  }

  @override
  String get retryDownload => 'Th? t?i l?i';

  @override
  String get downloadBook => 'T?i s?ch xu?ng';

  @override
  String continueChapter(int chapter) {
    return '??c ti?p t? ch??ng $chapter';
  }

  @override
  String get downloadBookError =>
      'Kh?ng th? t?i cu?n s?ch n?y. H?y ki?m tra k?t n?i r?i th? l?i.';

  @override
  String downloadBookOffline(int count) {
    return 'T?i s?ch xu?ng ?? ??c $count ch??ng khi kh?ng c? m?ng.';
  }

  @override
  String poemCount(int count) {
    return '$count b?i th?';
  }

  @override
  String get americanLiterature => 'V?n h?c M?';

  @override
  String get ancientChina => 'Trung Hoa c? ??i';

  @override
  String get britishLiterature => 'V?n h?c Anh';

  @override
  String get frenchLiterature => 'V?n h?c Ph?p';

  @override
  String get germanLiterature => 'V?n h?c ??c';

  @override
  String get italianLiterature => 'V?n h?c ?';

  @override
  String get jinDynasty => 'Nh? T?n';

  @override
  String get preQinEra => 'Th?i Ti?n T?n';

  @override
  String get qingDynasty => 'Nh? Thanh';

  @override
  String get republicOfChinaEra => 'Trung Hoa D?n Qu?c';

  @override
  String get russianLiterature => 'V?n h?c Nga';

  @override
  String get spanishLiterature => 'V?n h?c T?y Ban Nha';

  @override
  String get springAndAutumn => 'Th?i Xu?n Thu';

  @override
  String get westernHan => 'T?y H?n';

  @override
  String get roleplayCreatorContextPlaceholder =>
      'ví dụ: Một bữa tiệc ăn mừng sôi động ở Thượng Hải...';

  @override
  String get roleplayCreatorPersonaPlaceholder =>
      'ví dụ: Một người anh em họ tò mò hỏi về sự nghiệp của bạn...';

  @override
  String get beginFirstLesson => 'Bắt đầu bài học đầu tiên';

  @override
  String get exploreLibraryDirectly => 'Khám phá thư viện trực tiếp';

  @override
  String onboardingLessonProgress(Object current, Object total) {
    return 'BÀI HỌC ĐẦU TIÊN  •  $current / $total';
  }

  @override
  String get onboardingListenInstruction =>
      'Trước tiên, hãy lắng nghe một trong những câu văn nổi tiếng nhất của văn học Trung Hoa. Chưa cần ghi nhớ.';

  @override
  String get onboardingFromGrandLibrary => 'Từ Đại Thư Viện';

  @override
  String get onboardingArtOfWarTitleAuthor => 'Tôn Tử Binh Pháp · Tôn Tử';

  @override
  String get onboardingArtOfWarChapter => 'Mưu Công Thiên · Chương 3';

  @override
  String get onboardingClassicLineLabel => 'CÂU VĂN KINH ĐIỂN';

  @override
  String get onboardingArtOfWarTranslation =>
      '“Biết người biết ta, trăm trận không nguy.”';

  @override
  String get onboardingNoticeMeaning => 'Biết người biết ta,';

  @override
  String get onboardingShadowMeaning => 'Trăm trận không nguy.';

  @override
  String get onboardingPracticeThisLabel => 'BẠN SẼ LUYỆN TẬP CÂU NÀY';

  @override
  String get onboardingFromArtOfWarLabel => 'TRÍCH TỪ TÔN TỬ BINH PHÁP';

  @override
  String get onboardingYourPronunciationLabel => 'PHÁT ÂM CỦA BẠN';

  @override
  String get onboardingTapACharacter => 'Chạm vào một chữ';

  @override
  String onboardingWordAndPinyin(String word, String pinyin) {
    return '$word · $pinyin';
  }

  @override
  String get onboardingToneMatched => 'Đã khớp';

  @override
  String get onboardingCompareTones => 'So sánh thanh điệu';

  @override
  String get onboardingToneOneHigh => 'thanh 1 · cao bằng';

  @override
  String get onboardingToneTwoRising => 'thanh 2 · vút lên';

  @override
  String get onboardingToneThreeDipping => 'thanh 3 · trầm uốn';

  @override
  String get onboardingToneFourFalling => 'thanh 4 · hạ dứt khoát';

  @override
  String get onboardingToneNotDetected => 'không nhận diện được';

  @override
  String get onboardingFeedbackGreatThirdTone =>
      'Thanh 3 trầm uốn rất chuẩn xác.';

  @override
  String get onboardingFeedbackFourthToneFall =>
      'Hãy phát âm thanh 4 hạ xuống nhanh và dứt khoát.';

  @override
  String get onboardingFeedbackClearFourthTone =>
      'Thanh 4 hạ dứt khoát và rõ ràng.';

  @override
  String get onboardingFeedbackStrongFourthTone =>
      'Thanh 4 hạ dứt khoát đầy uy lực.';

  @override
  String onboardingTraceInstruction(
      String character, String pinyin, String meaning) {
    return 'Viết chữ $character ($pinyin, “$meaning”). Mài nét theo hướng dẫn mờ.';
  }

  @override
  String billingDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ngày',
    );
    return '$_temp0';
  }

  @override
  String billingWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tuần',
    );
    return '$_temp0';
  }

  @override
  String billingMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tháng',
    );
    return '$_temp0';
  }

  @override
  String billingYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count năm',
    );
    return '$_temp0';
  }

  @override
  String startPeriodFreeTrial(String period) {
    return 'Bắt đầu $period dùng thử miễn phí';
  }

  @override
  String subscribeForPricePeriod(String price, String period) {
    return 'Đăng ký với giá $price / $period';
  }

  @override
  String eligibleTrialRenewalNotice(String price, String period) {
    return 'Sản phẩm StoreKit bạn chọn đi kèm thời gian dùng thử miễn phí hợp lệ. Sau khi hết dùng thử, gói sẽ tự động gia hạn với giá $price mỗi $period trừ khi bị hủy.';
  }

  @override
  String pricePerPeriod(String price, String period) {
    return '$price / $period';
  }

  @override
  String get learn => 'Học';

  @override
  String get booksAndStudioQualityAudiobooks =>
      '86 cuốn sách kinh điển và sách nói chất lượng phòng thu';

  @override
  String get aiConversationsAndLiveToneFeedback =>
      'Trò chuyện AI và phản hồi thanh điệu trực tiếp';

  @override
  String get interactiveVideoAndWebImmersion =>
      'Video tương tác và đắm chìm trên web';

  @override
  String get characterInsightsAndHandwritingPractice =>
      'Phân tích chữ viết và luyện viết tay';

  @override
  String get hskDecksAndSmartSpacedRepetition =>
      'Bộ thẻ HSK và lặp lại ngắt quãng thông minh';

  @override
  String get termsOfUseEula => 'Điều khoản sử dụng (EULA)';

  @override
  String get masterEveryStroke => 'Làm chủ từng nét chữ';

  @override
  String get exploreTheChineseWeb => 'Khám phá web tiếng Trung';

  @override
  String get tone1Description =>
      'Giữ cao độ của bạn cao và ổn định như khi hát một nốt nhạc.';

  @override
  String get tone2Description =>
      'Bắt đầu ở giữa và lướt cao độ của bạn lên trên như khi hỏi \'Cái gì?\'';

  @override
  String get tone3Description =>
      'Hạ giọng xuống thấp, sau đó nhẹ nhàng nâng lên trở lại.';

  @override
  String get tone4Description =>
      'Hạ cao độ của bạn một cách sắc bén và dứt khoát như một tiếng \'Không!\' kiên quyết.';

  @override
  String get toneNeutralDescription =>
      'Phát âm nhẹ nhàng, ngắn gọn và không nhấn mạnh.';

  @override
  String get toneDiagMatch1 => 'Chính xác! Cao độ cao, bằng phẳng và ổn định.';

  @override
  String get toneDiagMatch2 => 'Chính xác! Cao độ tăng rõ ràng.';

  @override
  String get toneDiagMatch3 => 'Chính xác! Đường cong thấp xuống chính xác.';

  @override
  String get toneDiagMatch4 => 'Chính xác! Giảm mạnh dứt khoát.';

  @override
  String get toneDiagMatchDefault =>
      'Chính xác! Thanh điệu được phát âm chuẩn xác.';

  @override
  String get toneDiag1vs2 =>
      'Bạn đã nâng cao độ (thanh 2 /). Giữ giọng bằng phẳng và cao trên toàn bộ âm tiết (thanh 1 ˉ).';

  @override
  String get toneDiag1vs3 =>
      'Bạn đã hạ giọng (thanh 3 ˇ). Giữ cao độ ổn định và cao mà không hạ xuống (thanh 1 ˉ).';

  @override
  String get toneDiag1vs4 =>
      'Bạn đã hạ cao độ (thanh 4 \\). Duy trì cao độ cao, đều như hát một nốt nhạc (thanh 1 ˉ).';

  @override
  String get toneDiag2vs1 =>
      'Bạn giữ bằng phẳng (thanh 1 ˉ). Trượt cao độ lên trên như hỏi \'Cái gì?\' (thanh 2 /).';

  @override
  String get toneDiag2vs3 =>
      'Bạn đã hạ quá sâu (thanh 3 ˇ). Bắt đầu ở mức trung bình và tăng đều mà không chạm đáy (thanh 2 /).';

  @override
  String get toneDiag2vs4 =>
      'Bạn đã hạ cao độ (thanh 4 \\). Tăng lên trên như đặt câu hỏi (thanh 2 /).';

  @override
  String get toneDiag3vs1 =>
      'Bạn giữ cao và bằng phẳng (thanh 1 ˉ). Để cao độ hạ thấp xuống giọng ngực trước khi tăng lên (thanh 3 ˇ).';

  @override
  String get toneDiag3vs2 =>
      'Bạn đã tăng ngay lập tức (thanh 2 /). Đảm bảo hạ thấp xuống trước khi tăng trở lại (thanh 3 ˇ).';

  @override
  String get toneDiag3vs4 =>
      'Bạn đã hạ mạnh mà không tăng (thanh 4 \\). Cho phép cao độ nảy nhẹ nhàng trở lại ở cuối (thanh 3 ˇ).';

  @override
  String get toneDiag4vs1 =>
      'Bạn giữ bằng phẳng (thanh 1 ˉ). Hạ cao độ mạnh và dứt khoát như một tiếng \'Không!\' kiên quyết (thanh 4 \\).';

  @override
  String get toneDiag4vs2 =>
      'Bạn đã nâng cao độ (thanh 2 /). Bắt đầu cao và hạ mạnh xuống (thanh 4 \\).';

  @override
  String get toneDiag4vs3 =>
      'Bạn đã hạ và tăng (thanh 3 ˇ). Hạ thẳng xuống mà không tăng trở lại (thanh 4 \\).';

  @override
  String get toneDiagListenDiff =>
      'Nghe 4 thanh điệu dưới đây để nghe sự khác biệt.';

  @override
  String get liveCallSpeaking => 'Đang nói...';

  @override
  String get toneAccurate => 'Thanh điệu chuẩn';

  @override
  String get toneNeedsWork => 'Cần luyện thanh điệu';

  @override
  String get liveCallSessionCompletedFallback =>
      'Phiên luyện tập hoàn tất. Lần tới, hãy nói cả câu hoàn chỉnh để nhận chẩn đoán phát âm và thanh điệu chi tiết.';

  @override
  String liveCallGoodStartPracticingWord(String word) {
    return 'Khởi đầu tốt khi luyện tập \'$word\'. Trong buổi tiếp theo, hãy thử ghép các câu hoàn chỉnh để rèn luyện sự chuyển đổi thanh điệu và độ lưu loát tự nhiên.';
  }

  @override
  String get liveCallSolidEffortFallback =>
      'Nỗ lực giao tiếp rất tốt. Hãy chú ý giữ thanh 1 cao và đều (55), thanh 4 dứt khoát và đi xuống (51) để phát âm tự nhiên và rõ ràng hơn.';

  @override
  String get liveCallGoodPracticeFallback =>
      'Buổi luyện tập tốt. Hãy tiếp tục tập trung vào sự phân biệt cao độ thanh điệu rõ ràng và nhịp điệu giao tiếp tự nhiên.';

  @override
  String sentenceNumber(Object number) {
    return 'Câu $number';
  }

  @override
  String endlessAiStreamSentence(Object count) {
    return 'Luồng AI vô tận • Câu $count';
  }

  @override
  String get aiConsentTitle => 'Thực hành AI & Quyền riêng tư';

  @override
  String get aiConsentSubtitle =>
      'SinoSpark sử dụng các dịch vụ AI bên thứ ba an toàn để đánh giá phát âm giọng nói, nhập vai đối thoại và các công cụ học tập.';

  @override
  String get aiConsentDataSentTitle => 'Dữ liệu được truyền';

  @override
  String get aiConsentDataSentBody =>
      'Bản ghi âm giọng nói, bản ghi lời nói và gợi ý học tập.';

  @override
  String get aiConsentProvidersTitle => 'Dịch vụ AI bên thứ ba';

  @override
  String get aiConsentProvidersBody =>
      '• Microsoft Azure AI Speech (đánh giá phát âm & tổng hợp giọng nói)\n• Google Gemini & DeepSeek (đối thoại đàm thoại & tạo bộ thẻ)';

  @override
  String get aiConsentGuaranteesTitle => 'Bảo đảm quyền riêng tư';

  @override
  String get aiConsentGuaranteesBody =>
      'Dữ liệu của bạn được mã hóa khi truyền tải, xử lý tạm thời, không bao giờ bị bán và không bao giờ được dùng để huấn luyện mô hình AI công cộng.';

  @override
  String get aiConsentAgree => 'Đồng ý & Sử dụng AI';

  @override
  String get aiConsentLearnMore => 'Tìm hiểu thêm';

  @override
  String get viewPlans => 'Xem các gói';

  @override
  String get authInvalidCredentials =>
      'Email hoặc mật khẩu không chính xác. Nếu chưa có tài khoản, vui lòng đăng ký.';

  @override
  String get authInvalidEmail => 'Vui lòng nhập địa chỉ email hợp lệ.';

  @override
  String get authEmailAlreadyInUse =>
      'Đã có tài khoản tồn tại với địa chỉ email này.';

  @override
  String get authWeakPassword => 'Mật khẩu phải có ít nhất 6 ký tự.';

  @override
  String get authTooManyRequests =>
      'Quá nhiều lần thử không thành công. Vui lòng thử lại sau.';

  @override
  String get authNetworkError => 'Lỗi mạng. Vui lòng kiểm tra kết nối của bạn.';

  @override
  String get subscriptionRequired => 'Yêu cầu đăng ký';

  @override
  String get subscriptionRequiredDesc =>
      'Cần có gói thành viên SinoSpark đang hoạt động để truy cập tất cả các bài học, sách và công cụ giọng nói AI.';

  @override
  String signedInAs(String email) {
    return 'Đã đăng nhập với tư cách $email';
  }

  @override
  String get battle => 'Trận chiến';

  @override
  String addedWordsAndUpdatedWords(
      int addedCount, int updatedCount, String deckName) {
    return 'Đã thêm $addedCount từ mới, cập nhật $updatedCount từ hiện có vào «$deckName»';
  }

  @override
  String addedWordsToDeck(int count, String deckName) {
    return 'Đã thêm $count từ vào «$deckName»';
  }

  @override
  String updatedWordsInDeck(int count, String deckName) {
    return 'Đã cập nhật $count từ hiện có trong «$deckName»';
  }

  @override
  String addedCardToDeck(String hanzi, String deckName) {
    return 'Đã thêm «$hanzi» vào «$deckName»';
  }

  @override
  String get callCategory => 'CUỘC GỌI TRỰC TIẾP';

  @override
  String get aiCallFluencyTitle => 'Cuộc gọi AI nâng cao độ lưu loát';

  @override
  String get aiCallFluencyDesc =>
      'Tham gia các cuộc trò chuyện giọng nói thực tế với gia sư AI, nhận chấm điểm thanh điệu tức thì và xây dựng sự tự tin khi nói.';

  @override
  String get decksCategory => 'BỘ THẺ';

  @override
  String get decksSpacedRepetitionTitle => 'Bộ thẻ với lặp lại ngắt quãng';

  @override
  String get decksSpacedRepetitionDesc =>
      'Làm chủ HSK 1–6 và các bộ thẻ tùy chỉnh với thuật toán lặp lại ngắt quãng đã được chứng minh khoa học.';

  @override
  String get booksCategory => 'SÁCH';

  @override
  String get classicalBooksPoemsTitle =>
      '86 cuốn sách kinh điển và 100 bài thơ';

  @override
  String get classicalBooksPoemsDesc =>
      'Đắm mình vào văn học và thơ ca kinh điển với âm thanh đồng bộ và chú thích song ngữ.';

  @override
  String get scanCategory => 'MÁY QUÉT';

  @override
  String get scannerScanCardsTitle => 'Quét hình ảnh và thêm thẻ vào bộ';

  @override
  String get scannerScanCardsDesc =>
      'Hướng máy ảnh vào văn bản tiếng Trung, thực đơn hoặc biển hiệu để trích xuất từ ngay lập tức và lưu vào bộ thẻ của bạn.';

  @override
  String get smartDictionaryStrokeOrderTitle =>
      'Từ điển thông minh kèm thứ tự nét';

  @override
  String get liveAiVoiceCallsAndToneGrading =>
      'Cuộc gọi thoại AI trực tiếp và chấm điểm thanh điệu tức thì';

  @override
  String get shadowingStudioAndToneAnalysis =>
      'Phòng luyện Shadowing và phân tích trực quan cao độ thanh điệu';

  @override
  String get startMy7DaysFreeTrial => 'Bắt đầu 7 ngày dùng thử miễn phí';

  @override
  String trialSubtextUnderCta(String price, String period) {
    return 'Sau đó $price / $period. Hủy bất cứ lúc nào trong Cài đặt.';
  }

  @override
  String get deckLibraryTitle => 'Thư viện bộ thẻ';

  @override
  String get deckLibrarySubtitle =>
      'Bộ sưu tập chọn lọc về HSK, văn hóa, thể thao và học thuật';

  @override
  String get downloadOfficialDecks =>
      'Tải bộ thẻ HSK chính thức và theo chủ đề';

  @override
  String wordsSelectedCount(int selected, int total) {
    return 'Đã chọn $selected trong $total từ';
  }

  @override
  String get comparisonLabel => 'SO SÁNH';

  @override
  String get ambientSoundscape => 'Âm thanh nền';

  @override
  String get ambientSoundscapeDesc => 'Không gian êm dịu để đọc và nghe';

  @override
  String get ambientSoundscapeOff => 'Tắt (Im lặng)';

  @override
  String get soundscapeCourtyardRain => 'Mưa rơi sân đình';

  @override
  String get soundscapeGuqinWind => 'Cổ cầm & Gió trúc';

  @override
  String get soundscapeMidnightZen => 'Thiền đêm thanh tịnh';

  @override
  String get ambientVolume => 'Âm lượng nền';

  @override
  String get rateSinoSpark => 'Đánh giá SinoSpark';

  @override
  String get rateSinoSparkDesc => 'Chia sẻ đánh giá trên App Store';

  @override
  String get sendFeedback => 'Gửi phản hồi';

  @override
  String get sendFeedbackDesc => 'Giúp chúng tôi cải thiện hoặc báo lỗi';

  @override
  String get enjoyingAppTitle => 'Bạn có thích SinoSpark không?';

  @override
  String get enjoyingAppSubtitle =>
      'Hành trình học tiếng Trung của bạn đến nay thế nào?';

  @override
  String get ratingLovingIt => 'Vâng, rất thích!';

  @override
  String get ratingCouldBeBetter => 'Có thể tốt hơn';

  @override
  String get dictionarySearchFailed =>
      'Tìm kiếm từ điển không thành công. Vui lòng thử lại.';
}
