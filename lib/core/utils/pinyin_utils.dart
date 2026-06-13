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
}
