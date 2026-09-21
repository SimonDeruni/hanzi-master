import 'package:flutter/material.dart';

/// Represents the grading classification for a flashcard with Hanko seal attributes.
class HankoSealData {
  final int grade;
  final String sealCharacters;
  final String label;
  final Color primaryColor;

  const HankoSealData({
    required this.grade,
    required this.sealCharacters,
    required this.label,
    required this.primaryColor,
  });

  static const HankoSealData again = HankoSealData(
    grade: 0,
    sealCharacters: '重来',
    label: 'AGAIN',
    primaryColor: Color(0xFF9E1B1B), // Traditional Deep Cinnabar
  );

  static const HankoSealData hard = HankoSealData(
    grade: 2,
    sealCharacters: '困难',
    label: 'HARD',
    primaryColor: Color(0xFFC2410C), // Imperial Ochre / Amber
  );

  static const HankoSealData good = HankoSealData(
    grade: 4,
    sealCharacters: '熟练',
    label: 'GOOD',
    primaryColor: Color(0xFF1E7E34), // Scholar Pine / Jade
  );

  static const HankoSealData easy = HankoSealData(
    grade: 5,
    sealCharacters: '极佳',
    label: 'EASY',
    primaryColor: Color(0xFFB45309), // Emperor's Gold
  );

  static HankoSealData fromGrade(int grade) {
    switch (grade) {
      case 0:
        return again;
      case 2:
        return hard;
      case 5:
        return easy;
      case 4:
      default:
        return good;
    }
  }
}

/// An authentic Chinese scholar's Hanko seal stamp (印章).
///
/// Features a traditional double-line vermilion box, authentic Chinese
/// seal characters, and a scholarly subtext label.
class HankoSealStamp extends StatelessWidget {
  final HankoSealData data;
  final double scale;
  final double opacity;
  final double angle;

  const HankoSealStamp({
    super.key,
    required this.data,
    this.scale = 1.0,
    this.opacity = 1.0,
    this.angle = -0.07,
  });

  @override
  Widget build(BuildContext context) {
    final color = data.primaryColor;

    return Transform.rotate(
      angle: angle,
      child: Transform.scale(
        scale: scale,
        child: Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: color, width: 3.5),
              color: color.withValues(alpha: 0.10),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.25),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                border: Border.all(
                  color: color.withValues(alpha: 0.75),
                  width: 1.2,
                ),
                color: color.withValues(alpha: 0.05),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data.sealCharacters,
                    style: TextStyle(
                      fontFamily: 'NotoSerifSC',
                      fontWeight: FontWeight.w900,
                      fontSize: 26,
                      color: color,
                      height: 1.1,
                      letterSpacing: 3.0,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    data.label,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 9.5,
                      color: color,
                      letterSpacing: 2.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
