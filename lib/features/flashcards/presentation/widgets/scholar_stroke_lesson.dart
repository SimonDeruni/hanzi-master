import 'package:flutter/material.dart';

import 'package:hanzi_master/features/flashcards/presentation/widgets/drawing_canvas.dart';
import 'package:hanzi_master/shared/utils/motion_preferences.dart';

/// A miniature stroke-order lesson the Scholar's Desk can attach to a reply.
///
/// The Bureau du savant could *talk* about stroke order but never *show* it,
/// even though the app already owns both halves: the skeleton data on the card
/// and the animated [DrawingCanvas]. When the reader asks about stroke order the
/// reply now carries this card — a read-only canvas that writes the character
/// stroke by stroke, the stroke count, and a replay control.
class ScholarStrokeLesson extends StatefulWidget {
  const ScholarStrokeLesson({
    super.key,
    required this.hanzi,
    required this.strokePaths,
    this.medianPaths = const <List<Offset>>[],
    this.isFlipped = false,
    required this.isDark,
  });

  final String hanzi;
  final List<String> strokePaths;
  final List<List<Offset>> medianPaths;
  final bool isFlipped;
  final bool isDark;

  @override
  State<ScholarStrokeLesson> createState() => _ScholarStrokeLessonState();
}

class _ScholarStrokeLessonState extends State<ScholarStrokeLesson> {
  /// Bumped by "Replay" to rebuild the canvas, restarting its one-shot stroke
  /// animation from an empty grid.
  int _run = 0;

  int get _strokeCount => widget.strokePaths
      .where((String s) => s != '__CHAR_SEPARATOR__')
      .length;

  @override
  Widget build(BuildContext context) {
    final bool isDark = widget.isDark;
    final Color ink = isDark ? Colors.white : const Color(0xFF1A1A1B);
    final String locale = Localizations.localeOf(context).languageCode;

    return Container(
      key: const ValueKey('scholar-stroke-lesson'),
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.indigo.withValues(alpha: isDark ? 0.16 : 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.indigo.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.draw_outlined, size: 16, color: Colors.indigo),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  _title(locale),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                    color: isDark ? Colors.white70 : Colors.indigo,
                  ),
                ),
              ),
              Text(
                _strokeLabel(locale, _strokeCount),
                style:
                    TextStyle(fontSize: 11, color: ink.withValues(alpha: 0.55)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 132,
                height: 132,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ColoredBox(
                    color: isDark ? Colors.black26 : Colors.white,
                    // A fresh key per run restarts the one-shot animation.
                    child: DrawingCanvas(
                      key: ValueKey<String>('scholar-stroke-canvas-$_run'),
                      strokePaths: widget.strokePaths,
                      medianPaths: widget.medianPaths,
                      isFlipped: widget.isFlipped,
                      readOnly: true,
                      // The canvas does not read the platform preference, so the
                      // reduced-motion case renders the finished character.
                      showAnimation: !context.reduceMotion,
                      showGrade: false,
                      showControls: false,
                      autoCenter: true,
                      autoActiveChar: true,
                      semanticsLabel: widget.hanzi,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _hint(locale),
                      style: TextStyle(
                        fontSize: 12.5,
                        height: 1.4,
                        color: ink.withValues(alpha: 0.72),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        key: const ValueKey('scholar-stroke-replay'),
                        onPressed: () => setState(() => _run++),
                        style: TextButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        icon: const Icon(Icons.replay, size: 16),
                        label: Text(_replayLabel(locale)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Inline locale maps with an English fallback, matching the pattern
/// `DictionaryExpansionPanel` uses to avoid touching 14 ARB files per string.
String _title(String locale) {
  const labels = {
    'zh': '笔顺',
    'ja': '書き順',
    'ko': '필순',
    'fr': 'Ordre des traits',
    'de': 'Strichfolge',
    'es': 'Orden de los trazos',
    'it': 'Ordine dei tratti',
    'pt': 'Ordem dos traços',
    'ru': 'Порядок черт',
    'vi': 'Thứ tự nét',
    'id': 'Urutan guratan',
    'th': 'ลำดับขีด',
    'hi': 'स्ट्रोक क्रम',
    'ar': 'ترتيب الخطوط',
  };
  return labels[locale] ?? 'Stroke order';
}

String _hint(String locale) {
  const labels = {
    'zh': '笔画会一笔一笔写出——跟着轨迹看。',
    'ja': '一画ずつ書かれます。線をたどってみましょう。',
    'ko': '한 획씩 써집니다. 획을 따라가 보세요.',
    'fr': 'Les traits s’écrivent un par un — suivez le tracé.',
    'de': 'Die Striche werden nacheinander geschrieben — folge der Linie.',
    'es': 'Los trazos se escriben uno a uno: sigue el trazo.',
    'it': 'I tratti vengono scritti uno alla volta: segui la traccia.',
    'pt': 'Os traços são escritos um a um — siga o traçado.',
    'ru': 'Черты пишутся по одной — следите за линией.',
  };
  return labels[locale] ??
      'The strokes are written one by one — follow the line.';
}

String _replayLabel(String locale) {
  const labels = {
    'zh': '重播',
    'ja': 'もう一度',
    'ko': '다시 보기',
    'fr': 'Rejouer',
    'de': 'Wiederholen',
    'es': 'Repetir',
    'it': 'Ripeti',
    'pt': 'Repetir',
    'ru': 'Повторить',
  };
  return labels[locale] ?? 'Replay';
}

String _strokeLabel(String locale, int count) {
  const labels = {
    'zh': '{count} 画',
    'ja': '{count} 画',
    'ko': '{count}획',
    'fr': '{count} traits',
    'de': '{count} Striche',
    'es': '{count} trazos',
    'it': '{count} tratti',
    'pt': '{count} traços',
    'ru': 'черт: {count}',
  };
  return (labels[locale] ?? '{count} strokes').replaceAll('{count}', '$count');
}

