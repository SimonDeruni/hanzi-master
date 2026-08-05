import pathlib, re

base = pathlib.Path('lib/l10n')

# Lang -> new string (without "Gemini Flash" prefix)
translations = {
    'en': 'Crafting your custom story...',
    'de': 'Ihre Geschichte wird erstellt...',
    'fr': 'Elaboration de votre histoire...',
    'es': 'Creando tu historia personalizada...',
    'it': 'Creazione della tua storia...',
    'pt': 'Criando sua historia personalizada...',
    'ru': 'Создаём вашу историю...',
    'ja': 'カスタムストーリーを作成中...',
    'ko': '맞춤형 이야기를 만드는 중...',
    'vi': 'Đang tạo câu chuyện của bạn...',
    'id': 'Membuat cerita kustom Anda...',
    'hi': 'आपकी कस्टम कहानी बन रही है...',
    'ar': 'جارٍ صياغة قصتك المخصصة...',
}

results = []

for lang, new_text in translations.items():
    fname = base / f'app_{lang}.arb'
    if not fname.exists():
        results.append(f'{lang}: FILE NOT FOUND')
        continue
    
    content = fname.read_text(encoding='utf-8')
    
    # Match: "geminiFlashIsStructuring": "...old..."
    pattern = r'("geminiFlashIsStructuring"\s*:\s*)"[^"]*"'
    m = re.search(pattern, content)
    if m:
        updated = re.sub(pattern, rf'\1"{new_text}"', content)
        fname.write_text(updated, encoding='utf-8')
        results.append(f'{lang}: UPDATED')
    else:
        results.append(f'{lang}: NOT FOUND')

with open('scratch/arb_update_log.txt', 'w', encoding='utf-8') as f:
    f.write('\n'.join(results))

print(f'Processed {len(translations)} ARB files. See scratch/arb_update_log.txt')