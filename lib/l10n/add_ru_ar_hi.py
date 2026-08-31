import json, os
BASE = "C:/Users/simon/Documents/hanzi_master/lib/l10n"
with open(os.path.join(BASE, "all_translations.json"), "r", encoding="utf-8") as f:
    T = json.load(f)

T["ru"] = {
    "calligraphy": "Каллиграфия",
    "reading": "Чтение",
    "recall": "Вспоминание",
    "speaking": "Говорение",
    "listening1": "Аудирование",
    "today": "Сегодня",
    "emailLabel": "Эл. почта",
    "audioAndHaptics": "Аудио и тактильные ощущения",
    "displayAndContent": "Экран и содержимое",
    "appLanguage": "Язык приложения",
    "translationLanguage": "Язык перевода",
    "french": "Французский",
    "animationSpeed": "Скорость анимации",
    "notifications": "Уведомления",
    "notification_settings": "Настройки уведомлений",
    "dangerZone": "Опасная зона",
    "resetAllData": "Сбросить все данные",
    "resetDataDesc": "Это навсегда удалит все ваши данные прогресса, статистику и настройки. Это действие нельзя отменить."
}

T["ar"] = {
    "calligraphy": "الخط",
    "reading": "القراءة",
    "recall": "التذكر",
    "speaking": "التحدث",
    "listening1": "الاستماع",
    "today": "اليوم",
    "emailLabel": "البريد الإلكتروني",
    "audioAndHaptics": "الصوت واللمس",
    "displayAndContent": "الشاشة والمحتوى",
    "appLanguage": "لغة التطبيق",
    "translationLanguage": "لغة الترجمة",
    "french": "الفرنسية",
    "animationSpeed": "سرعة الحركة",
    "notifications": "الإشعارات",
    "notification_settings": "إعدادات الإشعارات",
    "dangerZone": "منطقة الخطر",
    "resetAllData": "إعادة تعيين جميع البيانات",
    "resetDataDesc": "سيؤدي هذا إلى حذف جميع بيانات التقدم والإحصائيات والإعدادات بشكل دائم. لا يمكن التراجع عن هذا الإجراء."
}

T["hi"] = {
    "calligraphy": "सुलेख",
    "reading": "पढ़ना",
    "recall": "याद करना",
    "speaking": "बोलना",
    "listening1": "सुनना",
    "today": "आज",
    "emailLabel": "ईमेल",
    "audioAndHaptics": "ऑडियो और हैप्टिक्स",
    "displayAndContent": "प्रदर्शन और सामग्री",
    "appLanguage": "ऐप भाषा",
    "translationLanguage": "अनुवाद भाषा",
    "french": "फ़्रेंच",
    "animationSpeed": "एनिमेशन गति",
    "notifications": "सूचनाएं",
    "notification_settings": "सूचना सेटिंग्स",
    "dangerZone": "खतरे का क्षेत्र",
    "resetAllData": "सभी डेटा रीसेट करें",
    "resetDataDesc": "यह आपके सभी प्रगति डेटा, आँकड़े और सेटिंग्स को स्थायी रूप से हटा देगा। यह क्रिया पूर्ववत नहीं की जा सकती।"
}

with open(os.path.join(BASE, "all_translations.json"), "w", encoding="utf-8") as f:
    json.dump(T, f, ensure_ascii=False, indent=2)
print("Added ru, ar, hi")