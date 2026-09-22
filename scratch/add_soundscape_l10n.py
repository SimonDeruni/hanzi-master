import json
import os

translations = {
    "en": {
        "ambientSoundscape": "Ambient Soundscape",
        "ambientSoundscapeDesc": "Soothing background atmosphere for reading & listening",
        "ambientSoundscapeOff": "Off (Silent)",
        "soundscapeCourtyardRain": "Courtyard Rain",
        "soundscapeGuqinWind": "Guqin & Bamboo Wind",
        "soundscapeMidnightZen": "Midnight Zen Drone",
        "ambientVolume": "Background Volume"
    },
    "fr": {
        "ambientSoundscape": "Ambiance sonore",
        "ambientSoundscapeDesc": "Atmosphère apaisante pour la lecture et l'écoute",
        "ambientSoundscapeOff": "Désactivé (Silencieux)",
        "soundscapeCourtyardRain": "Pluie de cour",
        "soundscapeGuqinWind": "Guqin & Vent de bambou",
        "soundscapeMidnightZen": "Méditation nocturne",
        "ambientVolume": "Volume d'ambiance"
    },
    "de": {
        "ambientSoundscape": "Klanglandschaft",
        "ambientSoundscapeDesc": "Beruhigende Hintergrundatmosphäre zum Lesen & Hören",
        "ambientSoundscapeOff": "Aus (Lautlos)",
        "soundscapeCourtyardRain": "Hofregen",
        "soundscapeGuqinWind": "Guqin & Bambuswind",
        "soundscapeMidnightZen": "Mitternachts-Zen",
        "ambientVolume": "Hintergrundlautstärke"
    },
    "es": {
        "ambientSoundscape": "Ambiente sonoro",
        "ambientSoundscapeDesc": "Atmósfera relajante para leer y escuchar",
        "ambientSoundscapeOff": "Desactivado (Silencio)",
        "soundscapeCourtyardRain": "Lluvia de patio",
        "soundscapeGuqinWind": "Guqin y viento de bambú",
        "soundscapeMidnightZen": "Meditación nocturna",
        "ambientVolume": "Volumen de fondo"
    },
    "it": {
        "ambientSoundscape": "Paesaggio sonoro",
        "ambientSoundscapeDesc": "Atmosfera rilassante per leggere e ascoltare",
        "ambientSoundscapeOff": "Disattivato (Silenzioso)",
        "soundscapeCourtyardRain": "Pioggia nel cortile",
        "soundscapeGuqinWind": "Guqin e vento di bambù",
        "soundscapeMidnightZen": "Meditazione notturna",
        "ambientVolume": "Volume di sottofondo"
    },
    "pt": {
        "ambientSoundscape": "Ambiente sonoro",
        "ambientSoundscapeDesc": "Atmosfera relaxante para ler e ouvir",
        "ambientSoundscapeOff": "Desativado (Silencioso)",
        "soundscapeCourtyardRain": "Chuva no pátio",
        "soundscapeGuqinWind": "Guqin e vento de bambu",
        "soundscapeMidnightZen": "Meditação noturna",
        "ambientVolume": "Volume de fundo"
    },
    "ru": {
        "ambientSoundscape": "Фоновые звуки",
        "ambientSoundscapeDesc": "Успокаивающая атмосфера для чтения и прослушивания",
        "ambientSoundscapeOff": "Выключено (Без звука)",
        "soundscapeCourtyardRain": "Дождь во внутреннем дворике",
        "soundscapeGuqinWind": "Гуцинь и бамбуковый ветер",
        "soundscapeMidnightZen": "Ночной дзен",
        "ambientVolume": "Громкость фона"
    },
    "ar": {
        "ambientSoundscape": "المشهد الصوتي المحيط",
        "ambientSoundscapeDesc": "أجواء مهدئة للقراءة والاستماع",
        "ambientSoundscapeOff": "إيقاف (صامت)",
        "soundscapeCourtyardRain": "مطر الفناء",
        "soundscapeGuqinWind": "الغوتشين ورياح الخيزران",
        "soundscapeMidnightZen": "تأمل منتصف الليل",
        "ambientVolume": "مستوى صوت الخلفية"
    },
    "hi": {
        "ambientSoundscape": "शांत पृष्ठभूमि संगीत",
        "ambientSoundscapeDesc": "पढ़ने और सुनने के लिए सुखदायक माहौल",
        "ambientSoundscapeOff": "बंद (शांत)",
        "soundscapeCourtyardRain": "आंगन की बारिश",
        "soundscapeGuqinWind": "गुकिन और बांस की हवा",
        "soundscapeMidnightZen": "मध्यरात्रि ध्यान",
        "ambientVolume": "पृष्ठभूमि की आवाज़"
    },
    "id": {
        "ambientSoundscape": "Latar Suara Menenangkan",
        "ambientSoundscapeDesc": "Suasana santai untuk membaca & mendengarkan",
        "ambientSoundscapeOff": "Mati (Hening)",
        "soundscapeCourtyardRain": "Hujan di Halaman",
        "soundscapeGuqinWind": "Guqin & Angin Bambu",
        "soundscapeMidnightZen": "Zen Tengah Malam",
        "ambientVolume": "Volume Latar"
    },
    "ja": {
        "ambientSoundscape": "環境音",
        "ambientSoundscapeDesc": "読書とリスニングのための穏やかな環境音",
        "ambientSoundscapeOff": "オフ（消音）",
        "soundscapeCourtyardRain": "中庭の雨",
        "soundscapeGuqinWind": "古琴と竹林の風",
        "soundscapeMidnightZen": "静夜の瞑想",
        "ambientVolume": "環境音の音量"
    },
    "ko": {
        "ambientSoundscape": "배경 음향",
        "ambientSoundscapeDesc": "독서와 듣기를 위한 차분한 배경 분위기",
        "ambientSoundscapeOff": "끄기 (무음)",
        "soundscapeCourtyardRain": "안뜰의 빗소리",
        "soundscapeGuqinWind": "고금과 대나무 바람",
        "soundscapeMidnightZen": "한밤의 명상",
        "ambientVolume": "배경 음량"
    },
    "th": {
        "ambientSoundscape": "เสียงบรรยากาศ",
        "ambientSoundscapeDesc": "บรรยากาศที่ผ่อนคลายสำหรับการอ่านและการฟัง",
        "ambientSoundscapeOff": "ปิด (เงียบ)",
        "soundscapeCourtyardRain": "สายฝนในลานบ้าน",
        "soundscapeGuqinWind": "กู่ฉินและสายลมไผ่",
        "soundscapeMidnightZen": "ความสงบยามค่ำคืน",
        "ambientVolume": "ระดับเสียงบรรยากาศ"
    },
    "vi": {
        "ambientSoundscape": "Âm thanh nền",
        "ambientSoundscapeDesc": "Không gian êm dịu để đọc và nghe",
        "ambientSoundscapeOff": "Tắt (Im lặng)",
        "soundscapeCourtyardRain": "Mưa rơi sân đình",
        "soundscapeGuqinWind": "Cổ cầm & Gió trúc",
        "soundscapeMidnightZen": "Thiền đêm thanh tịnh",
        "ambientVolume": "Âm lượng nền"
    }
}

l10n_dir = 'lib/l10n'
for lang, keys in translations.items():
    filepath = os.path.join(l10n_dir, f'app_{lang}.arb')
    if not os.path.exists(filepath):
        print(f"File not found: {filepath}")
        continue
    
    with open(filepath, 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    # Add keys
    for k, v in keys.items():
        data[k] = v
        if lang == 'en':
            # Add descriptions for en
            data[f'@{k}'] = {"description": f"{k} label"}
            
    with open(filepath, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
    print(f"Updated {filepath} with {len(keys)} keys")

print("Done updating arb files.")
