import json
import os

translations = {
    "supportAndFeedback": {
        "en": "Support & Feedback",
        "fr": "Support et retours",
        "de": "Support und Feedback",
        "es": "Soporte y comentarios",
        "it": "Supporto e feedback",
        "pt": "Suporte e feedback",
        "ru": "Поддержка и отзывы",
        "ar": "الدعم والملاحظات",
        "hi": "सहायता और प्रतिक्रिया",
        "id": "Dukungan & Masukan",
        "ja": "サポートとフィードバック",
        "ko": "지원 및 피드백",
        "th": "การสนับสนุนและข้อเสนอแนะ",
        "vi": "Hỗ trợ & Phản hồi"
    },
    "rateSinoSpark": {
        "en": "Rate SinoSpark",
        "fr": "Noter SinoSpark",
        "de": "SinoSpark bewerten",
        "es": "Valorar SinoSpark",
        "it": "Valuta SinoSpark",
        "pt": "Avaliar SinoSpark",
        "ru": "Оценить SinoSpark",
        "ar": "تقييم SinoSpark",
        "hi": "SinoSpark को रेट करें",
        "id": "Beri Nilai SinoSpark",
        "ja": "SinoSparkを評価",
        "ko": "SinoSpark 평가하기",
        "th": "ให้คะแนน SinoSpark",
        "vi": "Đánh giá SinoSpark"
    },
    "rateSinoSparkDesc": {
        "en": "Share your love on the App Store",
        "fr": "Partagez votre avis sur l'App Store",
        "de": "Teilen Sie Ihre Meinung im App Store",
        "es": "Comparte tu opinión en App Store",
        "it": "Condividi la tua opinione su App Store",
        "pt": "Compartilhe sua opinião na App Store",
        "ru": "Поделитесь мнением в App Store",
        "ar": "شارك تجربتك في متجر التطبيقات",
        "hi": "ऐप स्टोर पर अपनी राय साझा करें",
        "id": "Bagikan ulasan Anda di App Store",
        "ja": "App Storeでレビューを投稿",
        "ko": "App Store에서 리뷰 남기기",
        "th": "แบ่งปันความคิดเห็นใน App Store",
        "vi": "Chia sẻ đánh giá trên App Store"
    },
    "sendFeedback": {
        "en": "Send Feedback",
        "fr": "Envoyer un message",
        "de": "Feedback senden",
        "es": "Enviar comentarios",
        "it": "Invia feedback",
        "pt": "Enviar feedback",
        "ru": "Отправить отзыв",
        "ar": "إرسال ملاحظات",
        "hi": "प्रतिक्रिया भेजें",
        "id": "Kirim Masukan",
        "ja": "フィードバックを送信",
        "ko": "피드백 보내기",
        "th": "ส่งความคิดเห็น",
        "vi": "Gửi phản hồi"
    },
    "sendFeedbackDesc": {
        "en": "Help us improve or report an issue",
        "fr": "Aidez-nous à nous améliorer ou signalez un problème",
        "de": "Helfen Sie uns, besser zu werden oder melden Sie einen Fehler",
        "es": "Ayúdanos a mejorar o reporta un problema",
        "it": "Aiutaci a migliorare o segnala un problema",
        "pt": "Ajude-nos a melhorar ou relate um problema",
        "ru": "Помогите нам стать лучше или сообщите об ошибке",
        "ar": "ساعدنا على التحسين أو أبلغ عن مشكلة",
        "hi": "सुधार में मदद करें या समस्या की रिपोर्ट करें",
        "id": "Bantu kami berkembang atau laporkan kendala",
        "ja": "改善へのご意見や不具合を報告",
        "ko": "개선 의견이나 문제점 보고하기",
        "th": "ช่วยเราปรับปรุงหรือรายงานปัญหา",
        "vi": "Giúp chúng tôi cải thiện hoặc báo lỗi"
    },
    "enjoyingAppTitle": {
        "en": "Enjoying SinoSpark?",
        "fr": "Vous appréciez SinoSpark ?",
        "de": "Gefällt Ihnen SinoSpark?",
        "es": "¿Disfrutas de SinoSpark?",
        "it": "Ti piace SinoSpark?",
        "pt": "Está gostando do SinoSpark?",
        "ru": "Нравится SinoSpark?",
        "ar": "هل يعجبك SinoSpark؟",
        "hi": "क्या आपको SinoSpark पसंद आ रहा है?",
        "id": "Menikmati SinoSpark?",
        "ja": "SinoSparkを気に入っていただけましたか？",
        "ko": "SinoSpark가 마음에 드시나요?",
        "th": "ชอบ SinoSpark ไหม?",
        "vi": "Bạn có thích SinoSpark không?"
    },
    "enjoyingAppSubtitle": {
        "en": "How has your Chinese learning journey been so far?",
        "fr": "Comment se passe votre apprentissage du chinois jusqu'ici ?",
        "de": "Wie gefällt Ihnen Ihre Chinesisch-Lernreise bisher?",
        "es": "¿Cómo va tu viaje de aprendizaje de chino hasta ahora?",
        "it": "Come sta andando il tuo percorso di apprendimento del cinese?",
        "pt": "Como está sendo sua jornada no aprendizado de chinês?",
        "ru": "Как продвигается ваше изучение китайского языка?",
        "ar": "كيف تسير رحلتك في تعلم اللغة الصينية حتى الآن؟",
        "hi": "अब तक आपकी चीनी सीखने की यात्रा कैसी रही है?",
        "id": "Bagaimana perjalanan belajar bahasa Mandarin Anda sejauh ini?",
        "ja": "ここまでの中国語学習の体験はいかがですか？",
        "ko": "지금까지의 중국어 학습 여정은 어떠셨나요?",
        "th": "การเดินทางเรียนภาษาจีนของคุณเป็นอย่างไรบ้าง?",
        "vi": "Hành trình học tiếng Trung của bạn đến nay thế nào?"
    },
    "ratingLovingIt": {
        "en": "Yes, loving it!",
        "fr": "Oui, j'adore !",
        "de": "Ja, ich liebe es!",
        "es": "¡Sí, me encanta!",
        "it": "Sì, lo adoro!",
        "pt": "Sim, estou adorando!",
        "ru": "Да, очень нравится!",
        "ar": "نعم، يعجبني جداً!",
        "hi": "हाँ, बहुत पसंद आ रहा है!",
        "id": "Ya, saya suka!",
        "ja": "はい、とても気に入っています！",
        "ko": "네, 아주 좋아요!",
        "th": "ใช่ ชอบมาก!",
        "vi": "Vâng, rất thích!"
    },
    "ratingCouldBeBetter": {
        "en": "Could be better",
        "fr": "Pourrait être mieux",
        "de": "Könnte besser sein",
        "es": "Podría ser mejor",
        "it": "Potrebbe essere migliore",
        "pt": "Poderia ser melhor",
        "ru": "Могло быть лучше",
        "ar": "يمكن أن يكون أفضل",
        "hi": "और बेहतर हो सकता है",
        "id": "Bisa lebih baik",
        "ja": "改善してほしい点がある",
        "ko": "아쉬운 점이 있어요",
        "th": "ยังมีจุดที่ควรปรับปรุง",
        "vi": "Có thể tốt hơn"
    },
    "maybeLater": {
        "en": "Maybe Later",
        "fr": "Peut-être plus tard",
        "de": "Vielleicht später",
        "es": "Quizás más tarde",
        "it": "Forse più tardi",
        "pt": "Talvez mais tarde",
        "ru": "Может позже",
        "ar": "ربما لاحقاً",
        "hi": "शायद बाद में",
        "id": "Mungkin Nanti",
        "ja": "また後で",
        "ko": "나중에 하기",
        "th": "ไว้คราวหลัง",
        "vi": "Để sau"
    }
}

l10n_dir = r"c:\Users\simon\Documents\hanzi_master\lib\l10n"
locales = ["en", "fr", "de", "es", "it", "pt", "ru", "ar", "hi", "id", "ja", "ko", "th", "vi"]

for loc in locales:
    file_path = os.path.join(l10n_dir, f"app_{loc}.arb")
    with open(file_path, "r", encoding="utf-8") as f:
        data = json.load(f)
    
    for key, loc_map in translations.items():
        data[key] = loc_map.get(loc, loc_map["en"])
        if loc == "en":
            data[f"@{key}"] = {"description": f"{key} label"}
            
    with open(file_path, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
    print(f"Updated {file_path}")

print("All 14 ARB files updated successfully.")
