import 'dart:convert';
import 'dart:io';

void main() {
  final correctEnglishStrings = {
    "aiHubTitle": "AI Hub",
    "textChat": "Text Chat",
    "scholarlyPersonas": "Scholarly Personas",
    "shadowing": "Shadowing",
    "liveTranslation": "Live Translation",
    "scholarsLibrary": "The Scholar's Library",
    "generate": "Generate",
    "searchPinyinHanziEnglish": "Search Pinyin, Hanzi, or English...",
    "liveTranslate": "Live Translate",
    "poweredByGemini": "Powered by Gemini 3.5. Seamless real-time translation for any scenario.",
    "travelInterpreter": "Travel Interpreter",
    "realTimeSplitScreen": "Real-time split-screen conversation with a native speaker. Breaks down language barriers instantly.",
    "whisperEarpiece": "Whisper Earpiece",
    "listenToChineseAudio": "Listen to Chinese audio and get real-time English subtitles directly on your screen.",
    "dashboardTitle": "Dashboard",
    "yourMindIsClear": "Your mind is clear.",
    "noReviewsDueToday": "No reviews due today.",
    "done": "Done",
    "hskLevel1": "HSK Level 1",
    "hskLevel2": "HSK Level 2",
    "hskLevel3": "HSK Level 3",
    "hskLevel4": "HSK Level 4",
    "hskLevel5": "HSK Level 5",
    "hskLevel6": "HSK Level 6",
    "generalVocabulary": "General Vocabulary",
    "cardsRequireAttention": "cards require attention.",
    "begin": "Begin"
  };

  final enFile = File('lib/l10n/app_en.arb');
  final enContent = enFile.readAsStringSync();
  final Map<String, dynamic> enData = jsonDecode(enContent);

  for (final entry in correctEnglishStrings.entries) {
    if (enData.containsKey(entry.key)) {
      enData[entry.key] = entry.value;
    }
  }

  enFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(enData));

  final dir = Directory('lib/l10n');
  final arbFiles = dir.listSync().whereType<File>().where((f) => f.path.endsWith('.arb'));

  for (final file in arbFiles) {
    final fileName = file.path.split(Platform.pathSeparator).last;
    if (fileName == 'app_en.arb') continue;

    final content = file.readAsStringSync();
    final Map<String, dynamic> data = jsonDecode(content);

    bool changed = false;
    for (final key in correctEnglishStrings.keys) {
      if (data.containsKey(key)) {
        data.remove(key);
        changed = true;
      }
    }

    if (changed) {
      file.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(data));
    }
  }

  print("Arb files fixed!");
}
