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
  }
};

const dir = 'C:/Users/simon/Documents/hanzi_master/lib/l10n';

for (const [lang, t] of Object.entries(translations)) {
  const file = path.join(dir, `app_${lang}.arb`);
  if (fs.existsSync(file)) {
    let content = fs.readFileSync(file, 'utf8');
    if (content.charCodeAt(0) === 0xFEFF) {
      content = content.slice(1);
    }
    try {
      const data = JSON.parse(content);
      for (const [k, v] of Object.entries(t)) {
        data[k] = v;
      }
      fs.writeFileSync(file, JSON.stringify(data, null, 2), 'utf8');
      console.log(`Updated ${lang}`);
    } catch (e) {
      console.error(`Error processing ${lang}: ${e.message}`);
    }
  }
}
