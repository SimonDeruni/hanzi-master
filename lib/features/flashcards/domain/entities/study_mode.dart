enum StudyMode {
  calligraphy, // 🖌️ Draw the character
  reading,     // 📖 See Hanzi, type Pinyin & Meaning
  recall,      // 🧠 See Meaning, draw Hanzi from memory
  speaking,    // 🎙️ Speak the character aloud (AI graded)
  listening,   // 🎧 Hear the audio, select/draw the Hanzi
}

extension StudyModeExtension on StudyMode {
  String get title {
    switch (this) {
      case StudyMode.calligraphy:
        return 'Calligraphy';
      case StudyMode.reading:
        return 'Reading';
      case StudyMode.recall:
        return 'Recall';
      case StudyMode.speaking:
        return 'Speaking';
      case StudyMode.listening:
        return 'Listening';
    }
  }

  String get description {
    switch (this) {
      case StudyMode.calligraphy:
        return 'Practice stroke order with visual guides.';
      case StudyMode.reading:
        return 'See the character, recall the Pinyin and Meaning.';
      case StudyMode.recall:
        return 'See the meaning, draw the character from memory.';
      case StudyMode.speaking:
        return 'Read out loud to test your pronunciation tones.';
      case StudyMode.listening:
        return 'Listen to the audio and identify the character.';
    }
  }
}
