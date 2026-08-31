import json, os
BASE = "C:/Users/simon/Documents/hanzi_master/lib/l10n"
with open(os.path.join(BASE, "all_translations.json"), "r", encoding="utf-8") as f:
    T = json.load(f)

T["id"] = {
    "calligraphy": "Kaligrafi",
    "reading": "Membaca",
    "recall": "Mengingat",
    "speaking": "Berbicara",
    "listening1": "Mendengarkan",
    "today": "Hari ini",
    "emailLabel": "Email",
    "audioAndHaptics": "Audio dan Haptik",
    "displayAndContent": "Tampilan dan Konten",
    "appLanguage": "Bahasa Aplikasi",
    "translationLanguage": "Bahasa Terjemahan",
    "french": "Perancis",
    "animationSpeed": "Kecepatan Animasi",
    "notifications": "Notifikasi",
    "notification_settings": "Pengaturan Notifikasi",
    "dangerZone": "Zona Berbahaya",
    "resetAllData": "Setel Ulang Semua Data",
    "resetDataDesc": "Ini akan menghapus semua data progres, statistik, dan pengaturan Anda secara permanen. Tindakan ini tidak dapat dibatalkan.",
    "kore": "Kore (perempuan, hangat)",
    "aoede": "Aoede (perempuan, ceria)",
    "fenrir": "Fenrir (laki-laki, bersemangat)",
    "charon": "Charon (laki-laki, gaya berita)",
    "puck": "Puck (laki-laki, sporty)",
    "localOndevice": "Lokal (suara perangkat)",
    "localOndeviceTts": "TTS lokal perangkat",
    "koreFenrirCharonAoedePuckOrLocal": "Kore, Fenrir, Charon, Aoede, Puck, atau lokal"
}

T["ja"] = {
    "calligraphy": "書道",
    "reading": "読解",
    "recall": "想起",
    "speaking": "スピーキング",
    "listening1": "リスニング",
    "today": "今日",
    "emailLabel": "メール",
    "audioAndHaptics": "オーディオとハプティクス",
    "displayAndContent": "表示とコンテンツ",
    "appLanguage": "アプリ言語",
    "translationLanguage": "翻訳言語",
    "french": "フランス語",
    "animationSpeed": "アニメーション速度",
    "notifications": "通知",
    "notification_settings": "通知設定",
    "dangerZone": "危険ゾーン",
    "resetAllData": "全データをリセット",
    "resetDataDesc": "これにより、進行データ、統計、設定がすべて完全に削除されます。この操作は元に戻せません。"
}

T["ko"] = {
    "calligraphy": "서예",
    "reading": "읽기",
    "recall": "회상",
    "speaking": "말하기",
    "listening1": "듣기",
    "today": "오늘",
    "emailLabel": "이메일",
    "audioAndHaptics": "오디오 및 햅틱",
    "displayAndContent": "디스플레이 및 콘텐츠",
    "appLanguage": "앱 언어",
    "translationLanguage": "번역 언어",
    "french": "프랑스어",
    "animationSpeed": "애니메이션 속도",
    "notifications": "알림",
    "notification_settings": "알림 설정",
    "dangerZone": "위험 구역",
    "resetAllData": "모든 데이터 재설정",
    "resetDataDesc": "이 작업은 진행 데이터, 통계 및 설정을 영구적으로 삭제합니다. 이 작업은 취소할 수 없습니다.",
    "kore": "Kore (여성, 따뜻함)",
    "localOndevice": "로컬 (기기 음성)",
    "localOndeviceTts": "로컬 기기 TTS"
}

T["vi"] = {
    "calligraphy": "Thư pháp",
    "reading": "Đọc",
    "recall": "Ghi nhớ",
    "speaking": "Nói",
    "listening1": "Nghe",
    "today": "Hôm nay",
    "emailLabel": "Email",
    "audioAndHaptics": "Âm thanh và xúc giác",
    "displayAndContent": "Hiển thị và Nội dung",
    "appLanguage": "Ngôn ngữ ứng dụng",
    "translationLanguage": "Ngôn ngữ dịch thuật",
    "french": "Tiếng Pháp",
    "animationSpeed": "Tốc độ hoạt ảnh",
    "notifications": "Thông báo",
    "notification_settings": "Cài đặt thông báo",
    "dangerZone": "Vùng nguy hiểm",
    "resetAllData": "Đặt lại tất cả dữ liệu",
    "resetDataDesc": "Thao tác này sẽ xóa vĩnh viễn tất cả dữ liệu tiến trình, thống kê và cài đặt của bạn. Hành động này không thể hoàn tác.",
    "kore": "Kore (nữ, ấm áp)",
    "aoede": "Aoede (nữ, vui vẻ)",
    "fenrir": "Fenrir (nam, sôi nổi)",
    "charon": "Charon (nam, phong cách tin tức)",
    "puck": "Puck (nam, thể thao)",
    "localOndevice": "Cục bộ (giọng nói trên thiết bị)",
    "localOndeviceTts": "TTS cục bộ trên thiết bị",
    "koreFenrirCharonAoedePuckOrLocal": "Kore, Fenrir, Charon, Aoede, Puck hoặc cục bộ"
}

with open(os.path.join(BASE, "all_translations.json"), "w", encoding="utf-8") as f:
    json.dump(T, f, ensure_ascii=False, indent=2)
print("Added id, ja, ko, vi. Total langs:", list(T.keys()))