import 'package:flutter/widgets.dart';

/// A widget that enforces Left-to-Right [TextDirection.ltr] on its child subtree.
///
/// In SinoSpark, when the user's interface is set to an RTL language like Arabic ('ar'),
/// Chinese calligraphic elements (Hanzi character anatomy, Makemeahanzi stroke
/// drawing canvases, Pinyin phonetic spellings with diacritic tone marks, and
/// audio tone pitch contours) MUST NEVER be horizontally mirrored.
///
/// Wrapping those learning components inside an [LtrSanctuary] guarantees that
/// their coordinate systems, writing directions, and temporal pitch contours
/// remain strictly Left-to-Right, while allowing the surrounding app UI to
/// comfortably mirror for RTL speakers.
class LtrSanctuary extends StatelessWidget {
  final Widget child;

  const LtrSanctuary({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: child,
    );
  }
}
