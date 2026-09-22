"""One-off: add `dictionarySearchFailed` to every locale's ARB file.

Minimal diff on purpose - only one line is inserted before the closing brace of
each `.arb`, so the rest of the file is byte-identical.
"""
import json
from pathlib import Path

TRANSLATIONS = {
    "en": "Dictionary search failed. Please try again.",
    "fr": "La recherche dans le dictionnaire a \u00e9chou\u00e9. Veuillez r\u00e9essayer.",
    "de": "Die W\u00f6rterbuchsuche ist fehlgeschlagen. Bitte erneut versuchen.",
    "es": "La b\u00fasqueda en el diccionario ha fallado. Vuelve a intentarlo.",
    "it": "La ricerca nel dizionario non \u00e8 riuscita. Riprova.",
    "pt": "A pesquisa no dicion\u00e1rio falhou. Tente novamente.",
    "ru": "\u041d\u0435 \u0443\u0434\u0430\u043b\u043e\u0441\u044c \u0432\u044b\u043f\u043e\u043b\u043d\u0438\u0442\u044c \u043f\u043e\u0438\u0441\u043a \u043f\u043e \u0441\u043b\u043e\u0432\u0430\u0440\u044e. \u041f\u043e\u043f\u0440\u043e\u0431\u0443\u0439\u0442\u0435 \u0435\u0449\u0451 \u0440\u0430\u0437.",
    "ja": "\u8f9e\u66f8\u306e\u691c\u7d22\u306b\u5931\u6557\u3057\u307e\u3057\u305f\u3002\u3082\u3046\u4e00\u5ea6\u304a\u8a66\u3057\u304f\u3060\u3055\u3044\u3002",
    "ko": "\uc0ac\uc804 \uac80\uc0c9\uc5d0 \uc2e4\ud328\ud588\uc2b5\ub2c8\ub2e4. \ub2e4\uc2dc \uc2dc\ub3c4\ud574 \uc8fc\uc138\uc694.",
    "vi": "T\u00ecm ki\u1ebfm t\u1eeb \u0111i\u1ec3n kh\u00f4ng th\u00e0nh c\u00f4ng. Vui l\u00f2ng th\u1eed l\u1ea1i.",
    "id": "Pencarian kamus gagal. Silakan coba lagi.",
    "hi": "\u0936\u092c\u094d\u0926\u0915\u094b\u0936 \u0916\u094b\u091c \u0935\u093f\u092b\u0932 \u0930\u0939\u0940\u0964 \u0915\u0943\u092a\u092f\u093e \u092a\u0941\u0928\u0903 \u092a\u094d\u0930\u092f\u093e\u0938 \u0915\u0930\u0947\u0902\u0964",
    "th": "\u0e01\u0e32\u0e23\u0e04\u0e49\u0e19\u0e2b\u0e32\u0e1e\u0e08\u0e19\u0e32\u0e19\u0e38\u0e01\u0e23\u0e21\u0e25\u0e49\u0e21\u0e40\u0e2b\u0e25\u0e27 \u0e42\u0e1b\u0e23\u0e14\u0e25\u0e2d\u0e07\u0e2d\u0e35\u0e01\u0e04\u0e23\u0e31\u0e49\u0e07",
    "ar": "\u0641\u0634\u0644 \u0627\u0644\u0628\u062d\u062b \u0641\u064a \u0627\u0644\u0642\u0627\u0645\u0648\u0633. \u064a\u0631\u062c\u0649 \u0627\u0644\u0645\u062d\u0627\u0648\u0644\u0629 \u0645\u0631\u0629 \u0623\u062e\u0631\u0649.",
}

KEY = "dictionarySearchFailed"
ARB_DIR = Path("lib/l10n")

for code, value in TRANSLATIONS.items():
    path = ARB_DIR / f"app_{code}.arb"
    text = path.read_text(encoding="utf-8")
    body = text.rstrip()
    if not body.endswith("}"):
        raise SystemExit(f"{path}: unexpected ARB shape")
    inner = body[:-1].rstrip()
    if not inner.endswith((",", "{")):
        inner += ","
    entry = f'\n  {json.dumps(KEY)}: {json.dumps(value, ensure_ascii=False)}'
    updated = f"{inner}{entry}\n}}\n"
    # Fail loudly rather than write invalid JSON.
    parsed = json.loads(updated)
    assert parsed[KEY] == value, path
    path.write_text(updated, encoding="utf-8")
    print(f"{code}: ok")
