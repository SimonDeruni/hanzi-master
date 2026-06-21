const fs = require('fs');
const path = require('path');

const translations = {
  ar: {
    "foundNCharacters": "{count} حرف تم العثور عليه",
    "lookingUpCharacters": "جارٍ البحث عن الأحرف…",
    "importAll": "استيراد الكل",
    "practiceAll": "التدرب على الكل",
    "startAscension": "بدء التعلم",
    "arLensObjects": "الكائنات",
    "arLensText": "نص",
    "arLensDetectedText": "النص المكتشف"
  },
  de: {
    "foundNCharacters": "{count} Zeichen gefunden",
    "lookingUpCharacters": "Zeichen werden gesucht…",
    "importAll": "Alle importieren",
    "practiceAll": "Alle üben",
    "startAscension": "Aufstieg starten",
    "arLensObjects": "Objekte",
    "arLensText": "Text",
    "arLensDetectedText": "Erkannter Text"
  },
  es: {
    "foundNCharacters": "{count} caracteres encontrados",
    "lookingUpCharacters": "Buscando caracteres…",
    "importAll": "Importar todo",
    "practiceAll": "Practicar todo",
    "startAscension": "Iniciar ascenso",
    "arLensObjects": "Objetos",
    "arLensText": "Texto",
    "arLensDetectedText": "Texto detectado"
  },
  fr: {
    "foundNCharacters": "{count} caractères trouvés",
    "lookingUpCharacters": "Recherche des caractères…",
    "importAll": "Tout importer",
    "practiceAll": "Tout pratiquer",
    "startAscension": "Démarrer l'ascension",
    "arLensObjects": "Objets",
    "arLensText": "Texte",
    "arLensDetectedText": "Texte détecté"
  },
  hi: {
    "foundNCharacters": "{count} वर्ण मिले",
    "lookingUpCharacters": "वर्ण खोजे जा रहे हैं…",
    "importAll": "सभी आयात करें",
    "practiceAll": "सभी का अभ्यास करें",
    "startAscension": "आरोहण शुरू करें",
    "arLensObjects": "वस्तुएं",
    "arLensText": "पाठ",
    "arLensDetectedText": "पहचाना गया पाठ"
  },
  id: {
    "foundNCharacters": "{count} karakter ditemukan",
    "lookingUpCharacters": "Mencari karakter…",
    "importAll": "Impor semua",
    "practiceAll": "Latih semua",
    "startAscension": "Mulai kenaikan",
    "arLensObjects": "Objek",
    "arLensText": "Teks",
    "arLensDetectedText": "Teks terdeteksi"
  },
  it: {
    "foundNCharacters": "{count} caratteri trovati",
    "lookingUpCharacters": "Ricerca caratteri…",
    "importAll": "Importa tutto",
    "practiceAll": "Pratica tutto",
    "startAscension": "Inizia l'ascensione",
    "arLensObjects": "Oggetti",
    "arLensText": "Testo",
    "arLensDetectedText": "Testo rilevato"
  },
  ja: {
    "foundNCharacters": "{count}文字が見つかりました",
    "lookingUpCharacters": "文字を検索中…",
    "importAll": "すべてインポート",
    "practiceAll": "すべて練習",
    "startAscension": "上達を開始",
    "arLensObjects": "オブジェクト",
    "arLensText": "テキスト",
    "arLensDetectedText": "検出されたテキスト"
  },
  ko: {
    "foundNCharacters": "{count}자 찾음",
    "lookingUpCharacters": "문자 검색 중…",
    "importAll": "모두 가져오기",
    "practiceAll": "모두 연습",
    "startAscension": "수련 시작",
    "arLensObjects": "객체",
    "arLensText": "텍스트",
    "arLensDetectedText": "감지된 텍스트"
  },
  pt: {
    "foundNCharacters": "{count} caracteres encontrados",
    "lookingUpCharacters": "Procurando caracteres…",
    "importAll": "Importar tudo",
    "practiceAll": "Praticar tudo",
    "startAscension": "Iniciar ascensão",
    "arLensObjects": "Objetos",
    "arLensText": "Texto",
    "arLensDetectedText": "Texto detectado"
  },
  ru: {
    "foundNCharacters": "Найдено {count} иероглифов",
    "lookingUpCharacters": "Поиск иероглифов…",
    "importAll": "Импортировать всё",
    "practiceAll": "Практиковать всё",
    "startAscension": "Начать восхождение",
    "arLensObjects": "Объекты",
    "arLensText": "Текст",
    "arLensDetectedText": "Обнаруженный текст"
  },
  vi: {
    "foundNCharacters": "Tìm thấy {count} ký tự",
    "lookingUpCharacters": "Đang tra cứu ký tự…",
    "importAll": "Nhập tất cả",
    "practiceAll": "Luyện tập tất cả",
    "startAscension": "Bắt đầu thăng tiến",
    "arLensObjects": "Đối tượng",
    "arLensText": "Văn bản",
    "arLensDetectedText": "Văn bản được phát hiện"
  }
};

const dir = 'C:/Users/simon/Documents/hanzi_master/lib/l10n';

for (const [lang, t] of Object.entries(translations)) {
  const file = path.join(dir, `app_${lang}.arb`);
  if (fs.existsSync(file)) {
    const content = fs.readFileSync(file, 'utf8');
    try {
      const data = JSON.parse(content);
      // add the translations
      for (const [k, v] of Object.entries(t)) {
        data[k] = v;
      }
      fs.writeFileSync(file, JSON.stringify(data, null, 2), 'utf8');
      console.log(`Updated ${lang}`);
    } catch (e) {
      console.error(`Error processing ${lang}: ${e.message}`);
    }
  } else {
    console.warn(`File not found: ${file}`);
  }
}
