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

  /// Tokenizes a string (which may contain multiple syllables, punctuation, and spaces)
  /// into a list of Map objects containing the text and its tone.
  static List<Map<String, dynamic>> tokenize(String text) {
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
