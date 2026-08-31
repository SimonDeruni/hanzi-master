#!/usr/bin/env python3
"""Update ARB translations for placeholder keys."""
import json, os

BASE = "C:/Users/simon/Documents/hanzi_master/lib/l10n"

def update_arb(lang, replacements, out):
    path = os.path.join(BASE, f"app_{lang}.arb")
    with open(path, "r", encoding="utf-8") as f:
        data = json.load(f)
    changed = 0
    for key, new_val in replacements.items():
        if key in data and data[key] != new_val:
            out.write(f"    {key}: {data[key][:40]} -> {new_val}\n")
            data[key] = new_val
            changed += 1
    if changed:
        with open(path, "w", encoding="utf-8") as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
            f.write("\n")
        out.write(f"  [{lang.upper()}] Updated {changed} key(s)\n\n")
    else:
        out.write(f"  [{lang.upper()}] No changes needed\n\n")

outpath = "C:/Users/simon/Documents/hanzi_master/lib/l10n/apply_result.txt"
with open(outpath, "w", encoding="utf-8") as out:
    for lang, updates in [
        ("de", {"learning_stats": "Lernstatistiken", "view_your_learning_history_and_streaks": "Lernverlauf und Serien anzeigen", "premium": "PREMIUM"}),
        ("es", {"learning_stats": "Estadisticas de aprendizaje", "view_your_learning_history_and_streaks": "Ver tu historial de aprendizaje y rachas", "premium": "PREMIUM"}),
        ("fr", {"learning_stats": "Statistiques d'apprentissage", "view_your_learning_history_and_streaks": "Consultez votre historique d'apprentissage et vos series", "premium": "PREMIUM"}),
        ("it", {"account": "Account", "learning_stats": "Statistiche di apprendimento", "view_your_learning_history_and_streaks": "Visualizza la cronologia di apprendimento e le serie", "premium": "PREMIUM"}),
        ("pt", {"learning_stats": "Estatisticas de aprendizado", "view_your_learning_history_and_streaks": "Veja seu historico de aprendizado e sequencias", "premium": "PREMIUM"}),
        ("ru", {"learning_stats": "Statistika obucheniya", "view_your_learning_history_and_streaks": "Prosmotrite svoyu istoriyu obucheniya i serii"}),
        ("ar", {"learning_stats": "Ihsa'iyat al-ta'allum", "view_your_learning_history_and_streaks": "Arad sajil al-ta'allum wa-al-salasil al-khassa bik"}),
        ("hi", {"learning_stats": "Sikhene ke aankde", "view_your_learning_history_and_streaks": "Apna sikhne ka itihaas aur streaks dekhen"}),
        ("id", {"learning_stats": "Statistik Belajar", "view_your_learning_history_and_streaks": "Lihat riwayat belajar dan streak Anda", "premium": "PREMIUM"}),
        ("ja", {"learning_stats": "Gakushu tokei", "view_your_learning_history_and_streaks": "Gakushu rireki to renzoku kiroku o hyoji"}),
        ("ko", {"learning_stats": "Hakseup tonggye", "view_your_learning_history_and_streaks": "Hakseup giryeok mit yeonsok giryeok bogi"}),
        ("vi", {"learning_stats": "Thong ke hoc tap", "view_your_learning_history_and_streaks": "Xem lich su hoc tap va chuoi cua ban", "premium": "PREMIUM"}),
    ]:
        update_arb(lang, updates, out)
    
    out.write("DONE!\n")

print(f"Result written to {outpath}")