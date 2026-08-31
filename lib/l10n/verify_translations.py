#!/usr/bin/env python3
"""Verify all translations were applied correctly."""
import json, os

BASE = "C:/Users/simon/Documents/hanzi_master/lib/l10n"

with open(os.path.join(BASE, "app_en.arb"), "r", encoding="utf-8") as f:
    en = json.load(f)

# Expected translations (non-English values)
expected = {
    "de": {"learning_stats": "Lernstatistiken", "view_your_learning_history_and_streaks": "Lernverlauf und Serien anzeigen", "premium": "PREMIUM"},
    "es": {"learning_stats": "Estadisticas de aprendizaje", "view_your_learning_history_and_streaks": "Ver tu historial de aprendizaje y rachas", "premium": "PREMIUM"},
    "fr": {"learning_stats": "Statistiques d'apprentissage", "view_your_learning_history_and_streaks": "Consultez votre historique d'apprentissage et vos series", "premium": "PREMIUM"},
    "it": {"account": "Account", "learning_stats": "Statistiche di apprendimento", "view_your_learning_history_and_streaks": "Visualizza la cronologia di apprendimento e le serie", "premium": "PREMIUM"},
    "pt": {"learning_stats": "Estatisticas de aprendizado", "view_your_learning_history_and_streaks": "Veja seu historico de aprendizado e sequencias", "premium": "PREMIUM"},
    "ru": {"learning_stats": "Статистика обучения", "view_your_learning_history_and_streaks": "Просмотрите свою историю обучения и серии"},
    "ar": {"learning_stats": "إحصائيات التعلم", "view_your_learning_history_and_streaks": "عرض سجل التعلم والسلاسل الخاصة بك"},
    "hi": {"learning_stats": "सीखने के आँकड़े", "view_your_learning_history_and_streaks": "अपना सीखने का इतिहास और स्ट्रीक्स देखें"},
    "id": {"learning_stats": "Statistik Belajar", "view_your_learning_history_and_streaks": "Lihat riwayat belajar dan streak Anda", "premium": "PREMIUM"},
    "ja": {"learning_stats": "学習統計", "view_your_learning_history_and_streaks": "学習履歴と連続記録を表示"},
    "ko": {"learning_stats": "학습 통계", "view_your_learning_history_and_streaks": "학습 기록 및 연속 기록 보기"},
    "vi": {"learning_stats": "Thống kê học tập", "view_your_learning_history_and_streaks": "Xem lịch sử học tập và chuỗi của bạn", "premium": "PREMIUM"},
}

# Write result to file to avoid encoding issues
outpath = os.path.join(BASE, "verify_result.txt")
with open(outpath, "w", encoding="utf-8") as out:
    all_ok = True
    for lang in ["de", "es", "fr", "it", "pt", "ru", "ar", "hi", "id", "ja", "ko", "vi"]:
        path = os.path.join(BASE, f"app_{lang}.arb")
        with open(path, "r", encoding="utf-8") as f:
            data = json.load(f)
        
        out.write(f"\n=== {lang.upper()} ===\n")
        lang_ok = True
        if lang in expected:
            for key, expected_val in expected[lang].items():
                actual = data.get(key, "[MISSING]")
                # For non-Latin scripts, compare raw strings
                if actual == expected_val:
                    out.write(f"  OK  {key}: {actual[:50]}\n")
                else:
                    all_ok = False
                    lang_ok = False
                    en_val = en.get(key, "?")
                    out.write(f"  FAIL {key}: expected='{expected_val[:50]}', got='{actual[:50]}' (en='{en_val}')\n")
        
        if lang_ok:
            out.write(f"  All translations OK!\n")
    
    out.write(f"\n{'='*50}\n")
    if all_ok:
        out.write("ALL VERIFIED: All translations applied correctly!\n")
    else:
        out.write("SOME FAILURES: Check details above.\n")
    out.write(f"{'='*50}\n")

print(f"Verification written to {outpath}")