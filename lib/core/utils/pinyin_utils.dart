import 'package:flutter/material.dart';

class PinyinUtils {
  /// Standard tone colors for the "Zen & Ink" theme.
  static const Map<int, Color> toneColors = {
    1: Color(0xFFD32F2F), // Tone 1: Flat/Red
    2: Color(0xFFF57C00), // Tone 2: Rising/Amber
    3: Color(0xFF388E3C), // Tone 3: Falling-Rising/Green
    4: Color(0xFF1976D2), // Tone 4: Falling/Blue
    5: Color(0xFF1A1A1B), // Tone 5 (Neutral): Ink/Grey
  };

  /// Unicode diacritics for each tone.
  static const String tone1Chars = 'āēīōūǖ';
  static const String tone2Chars = 'áéíóúǘ';
  static const String tone3Chars = 'ǎěǐǒǔǚ';
  static const String tone4Chars = 'àèìòùǜ';

  /// Determines the tone (1-5) of a single pinyin syllable.
  static int getTone(String syllable) {
    String lower = syllable.toLowerCase();
    
    for (int i = 0; i < lower.length; i++) {
      String char = lower[i];
      if (tone1Chars.contains(char)) return 1;
      if (tone2Chars.contains(char)) return 2;
      if (tone3Chars.contains(char)) return 3;
      if (tone4Chars.contains(char)) return 4;
    }
    
    return 5; // Neutral tone
  }

  static const Map<String, String> _vowelMap = {
    'a1': 'ā', 'a2': 'á', 'a3': 'ǎ', 'a4': 'à',
    'e1': 'ē', 'e2': 'é', 'e3': 'ě', 'e4': 'è',
    'i1': 'ī', 'i2': 'í', 'i3': 'ǐ', 'i4': 'ì',
    'o1': 'ō', 'o2': 'ó', 'o3': 'ǒ', 'o4': 'ò',
    'u1': 'ū', 'u2': 'ú', 'u3': 'ǔ', 'u4': 'ù',
    'ü1': 'ǖ', 'ü2': 'ǘ', 'ü3': 'ǚ', 'ü4': 'ǜ',
  };

  /// Converts numeric pinyin (e.g. "jian4", "lu:4") to tone marks (e.g. "jiàn", "lǜ")
  static String convertNumericToMarks(String text) {
    // CC-CEDICT uses u: for ü
    String processed = text.replaceAll('u:', 'ü');
    
    return processed.replaceAllMapped(RegExp(r'([a-zA-ZüÜ]+)([1-5])'), (match) {
      String word = match.group(1)!;
      int tone = int.parse(match.group(2)!);
      
      if (tone == 5) return word; // Neutral tone has no mark
      
      String lowerWord = word.toLowerCase();
      int targetIdx = -1;
      
      if (lowerWord.contains('a')) {
        targetIdx = lowerWord.indexOf('a');
      } else if (lowerWord.contains('e')) {
        targetIdx = lowerWord.indexOf('e');
      } else if (lowerWord.contains('ou')) {
        targetIdx = lowerWord.indexOf('o');
      } else {
        // Find the last vowel
        for (int i = lowerWord.length - 1; i >= 0; i--) {
          if ('aeiouü'.contains(lowerWord[i])) {
            targetIdx = i;
            break;
          }
        }
      }
      
      if (targetIdx != -1) {
        String vowel = word[targetIdx];
        bool isUpper = vowel == vowel.toUpperCase();
        String vKey = "${vowel.toLowerCase()}$tone";
        String markedVowel = _vowelMap[vKey] ?? vowel;
        if (isUpper) markedVowel = markedVowel.toUpperCase();
        
        return word.substring(0, targetIdx) + markedVowel + word.substring(targetIdx + 1);
      }
      
      return word;
    });
  }

  /// Removes tone diacritics from pinyin (e.g., "hé lì" -> "he li").
  static String removeToneMarks(String text) {
    String stripped = text;
    final Map<String, String> stripMap = {
      'ā': 'a', 'á': 'a', 'ǎ': 'a', 'à': 'a',
      'ē': 'e', 'é': 'e', 'ě': 'e', 'è': 'e',
      'ī': 'i', 'í': 'i', 'ǐ': 'i', 'ì': 'i',
      'ō': 'o', 'ó': 'o', 'ǒ': 'o', 'ò': 'o',
      'ū': 'u', 'ú': 'u', 'ǔ': 'u', 'ù': 'u',
      'ǖ': 'ü', 'ǘ': 'ü', 'ǚ': 'ü', 'ǜ': 'ü',
      'Ā': 'A', 'Á': 'A', 'Ǎ': 'A', 'À': 'A',
      'Ē': 'E', 'É': 'E', 'Ě': 'E', 'È': 'E',
      'Ī': 'I', 'Í': 'I', 'Ǐ': 'I', 'Ì': 'I',
      'Ō': 'O', 'Ó': 'O', 'Ǒ': 'O', 'Ò': 'O',
      'Ū': 'U', 'Ú': 'U', 'Ǔ': 'U', 'Ù': 'U',
      'Ǖ': 'Ü', 'Ǘ': 'Ü', 'Ǚ': 'Ü', 'Ǜ': 'Ü',
    };
    stripMap.forEach((key, value) {
      stripped = stripped.replaceAll(key, value);
    });
    return stripped;
  }

  /// Tokenizes a string (which may contain multiple syllables, punctuation, and spaces)
  /// into a list of Map objects containing the text and its tone.
  static List<Map<String, dynamic>> tokenize(String rawText) {
    final String text = convertNumericToMarks(rawText);
    final List<Map<String, dynamic>> tokens = [];
    
    // Improved Regex to match individual pinyin syllables more accurately.
    // Group 1: Matches a pinyin syllable (consonants + vowels + nasal ending)
    // Group 2: Catch-all for spaces, punctuation, or individual non-syllable letters.
    final RegExp regExp = RegExp(
      r'([bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ]*[aeiouvüAEIOUVÜāēīōūǖáéíóúǘǎěǐǒǔǚàèìòùǜ]+(?:ng?|r)?)|(.)',
      caseSensitive: true,
    );
    
    final Iterable<RegExpMatch> matches = regExp.allMatches(text);
    
    for (final match in matches) {
      String matchedText = match.group(0)!;
      bool isSyllable = match.group(1) != null;
      
      if (isSyllable) {
        tokens.add({
          'text': matchedText,
          'tone': getTone(matchedText),
        });
      } else {
        // This handles spaces, punctuation, or extra letters
        tokens.add({
          'text': matchedText,
          'tone': 5, // Neutral
        });
      }
    }
    
    return tokens;
  }

  /// Generates the 4 (or 5) tone variations for a given pinyin syllable.
  /// E.g. "mā" -> {1: "mā", 2: "má", 3: "mǎ", 4: "mà", 5: "ma"}
  static Map<int, String> getAllTonesForSyllable(String pinyinWithTone) {
    final base = removeToneMarks(pinyinWithTone).trim();
    if (base.isEmpty) return {};
    return {
      1: convertNumericToMarks('${base}1'),
      2: convertNumericToMarks('${base}2'),
      3: convertNumericToMarks('${base}3'),
      4: convertNumericToMarks('${base}4'),
      5: base,
    };
  }

  /// Human-readable name for each tone (e.g. "1st Tone (High Flat)").
  static String getToneName(int tone) {
    switch (tone) {
      case 1:
        return "1st Tone (High Flat — 55)";
      case 2:
        return "2nd Tone (Rising — 35)";
      case 3:
        return "3rd Tone (Falling-Rising — 214)";
      case 4:
        return "4th Tone (Falling — 51)";
      default:
        return "Neutral Tone (Light)";
    }
  }

  /// Description of the pitch shape for each tone.
  static String getToneDescription(int tone) {
    switch (tone) {
      case 1:
        return "Keep your pitch high and steady like singing a note.";
      case 2:
        return "Start in the middle and slide your pitch upward like asking 'What?'";
      case 3:
        return "Dip your voice down low, then rise gently back up.";
      case 4:
        return "Drop your pitch sharply and decisively like a firm 'No!'";
      default:
        return "Pronounce softly, briefly, and without emphasis.";
    }
  }

  /// Generates a concise diagnostic summary comparing expected tone vs actual spoken tone.
  static String getToneDiagnostic(int expectedTone, int actualTone) {
    if (expectedTone == actualTone && expectedTone > 0) {
      switch (expectedTone) {
        case 1:
          return "Spot on! Pitch was high, flat, and steady.";
        case 2:
          return "Spot on! Upward pitch rise was clear.";
        case 3:
          return "Spot on! Low dipping curve was accurate.";
        case 4:
          return "Spot on! Sharp falling drop was decisive.";
        default:
          return "Spot on! Tone was pronounced accurately.";
      }
    }

    // Specific diagnostic guidance based on the error pair
    if (expectedTone == 1 && actualTone == 2) {
      return "You rose your pitch (2nd tone /). Keep your voice flat and high across the whole syllable (1st tone ˉ).";
    } else if (expectedTone == 1 && actualTone == 3) {
      return "You dipped your voice (3rd tone ˇ). Keep your pitch steady and high without dipping (1st tone ˉ).";
    } else if (expectedTone == 1 && actualTone == 4) {
      return "You dropped your pitch (4th tone \\). Sustain a high, level pitch like singing a note (1st tone ˉ).";
    } else if (expectedTone == 2 && actualTone == 1) {
      return "You stayed flat (1st tone ˉ). Slide your pitch upward like asking 'What?' (2nd tone /).";
    } else if (expectedTone == 2 && actualTone == 3) {
      return "You dipped too deep (3rd tone ˇ). Start mid-level and rise smoothly without bottoming out (2nd tone /).";
    } else if (expectedTone == 2 && actualTone == 4) {
      return "You dropped your pitch (4th tone \\). Rise upward like asking a question (2nd tone /).";
    } else if (expectedTone == 3 && actualTone == 1) {
      return "You stayed high and flat (1st tone ˉ). Let your pitch drop low into your chest register before rising (3rd tone ˇ).";
    } else if (expectedTone == 3 && actualTone == 2) {
      return "You rose immediately (2nd tone /). Make sure to dip down low first before rising back up (3rd tone ˇ).";
    } else if (expectedTone == 3 && actualTone == 4) {
      return "You dropped sharply without rising (4th tone \\). Allow your pitch to bounce gently back up at the end (3rd tone ˇ).";
    } else if (expectedTone == 4 && actualTone == 1) {
      return "You stayed flat (1st tone ˉ). Drop your pitch sharply and decisively like a firm 'No!' (4th tone \\).";
    } else if (expectedTone == 4 && actualTone == 2) {
      return "You rose your pitch (2nd tone /). Start high and snap sharply downward (4th tone \\).";
    } else if (expectedTone == 4 && actualTone == 3) {
      return "You dipped and rose (3rd tone ˇ). Drop straight down without rising back up (4th tone \\).";
    }

    return "Target was ${getToneName(expectedTone)}. Listen to the 4 tones below to hear the difference.";
  }
}
