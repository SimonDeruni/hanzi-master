/// Ratchets that keep the iPad/adaptive work from regressing.
///
/// Same philosophy as `test/core/locale_layout_guard_test.dart`: every rule is a
/// baseline that can only go **down**, and a failure prints the exact worklist.
/// Baselines were measured on 2026-09-26 and are documented in
/// `docs/IPAD_ADAPTIVE_PLAN.md` (F9.2).
library;

import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/layout/zen_device.dart';
import 'package:hanzi_master/core/layout/zen_layout.dart';

import '../support/locale_layout_harness.dart';

List<File> _libSources() => Directory('lib')
    .listSync(recursive: true)
    .whereType<File>()
    .where((File file) => file.path.endsWith('.dart'))
    .toList();

/// File → occurrence count for [pattern], skipping [ignore] (suffix match).
Map<String, int> _hits(String pattern,
    {Set<String> ignore = const <String>{}}) {
  final RegExp regex = RegExp(pattern);
  final Map<String, int> perFile = <String, int>{};
  for (final File file in _libSources()) {
    final String path = file.path.replaceAll(r'\', '/');
    if (ignore.any(path.endsWith)) continue;
    final int count = regex.allMatches(file.readAsStringSync()).length;
    if (count > 0) perFile[path] = count;
  }
  return perFile;
}

int _total(Map<String, int> hits) =>
    hits.values.fold(0, (int sum, int n) => sum + n);

List<String> _worklist(Map<String, int> hits) => hits.entries
    .map((MapEntry<String, int> e) => '  ${e.value}x ${e.key}')
    .toList()
  ..sort();

void main() {
  // ZenDevice reads the platform view, which needs a binding even in the pure
  // `test()` cases below.
  TestWidgetsFlutterBinding.ensureInitialized();

  group('adaptive layout ratchets', () {
    test('no grid hardcodes its column count', () {
      // Ratchet reached 0 on 2026-09-26 (scratch/ipad_grids.py converted the
      // last 10): a fixed count gives the same 3 columns on a 320dp phone and a
      // 1366dp iPad. Use ZenGrid.tiles/covers/media — density-driven.
      final Map<String, int> hits = _hits(r'crossAxisCount');
      expect(
        _total(hits),
        0,
        reason: 'Fixed-column grids found (${_total(hits)}). Use '
            'ZenGrid.tiles/covers/media instead:\n${_worklist(hits)}',
      );
    });

    test('no screen reads the raw window size inline', () {
      // Ratchet reached 0 on 2026-09-26 (scratch/ipad_adoption.py): raw reads
      // rebuild on every metric change and hide the intent. Use
      // MediaQuery.sizeOf(context) or, better, context.zenWindow.
      final Map<String, int> hits = _hits(r'MediaQuery\.of\(context\)\.size');
      expect(
        _total(hits),
        0,
        reason: 'Raw window-size reads found (${_total(hits)}). Use '
            'context.zenWindow / MediaQuery.sizeOf:\n${_worklist(hits)}',
      );
    });

    test('no modal surface bypasses the overlay helpers', () {
      // Ratchet reached 0 outside the allow-list on 2026-09-26
      // (scratch/ipad_adoption.py converted 39 of 46). A full-width bottom
      // sheet on a 1366dp iPad reads as a stretched phone; zenSheet keeps the
      // sheet on phones and shows a width-capped dialog on tablets.
      final Map<String, int> hits = _hits(
        r'showModalBottomSheet',
        ignore: <String>{
          // The helper itself (and its docs).
          'shared/widgets/zen_overlay.dart',
          // The motion-tokenised wrapper that predates zenSheet and owns the
          // sheet timing vocabulary; zenSheet should delegate to it eventually.
          'shared/widgets/global_blurred_bottom_sheet.dart',
          // Deliberately anchored to the word it previews, not a modal.
          'shared/widgets/quick_look_sheet.dart',
        },
      );
      expect(
        _total(hits),
        0,
        reason: 'Direct bottom sheets found (${_total(hits)}) outside the '
            'allow-list. Route them through zenSheet/zenDialog/zenPicker:\n'
            '${_worklist(hits)}',
      );
    });

    test('every orientation lock is device-class aware', () {
      // The bug this prevents: a feature locking portrait for the whole app, so
      // an iPad could never rotate (blocker B3 in the plan). A lock is allowed
      // only when the same file asks ZenDevice (or uses ZenOrientationLock),
      // i.e. the lock is conditional on the device class.
      final RegExp lock =
          RegExp(r'(setPreferredOrientations|lockCaptureOrientation)');
      final List<String> offenders = <String>[];
      for (final File file in _libSources()) {
        final String path = file.path.replaceAll(r'\', '/');
        if (path.endsWith('core/layout/zen_device.dart')) continue;
        final String source = file.readAsStringSync();
        if (!lock.hasMatch(source)) continue;
        if (source.contains('ZenDevice.isTabletWindow') ||
            source.contains('ZenDevice.applyStartupOrientation') ||
            source.contains('ZenOrientationLock.')) {
          continue;
        }
        offenders.add(path);
      }
      expect(
        offenders,
        isEmpty,
        reason: 'These files lock orientation without checking the device '
            'class; an iPad would be unable to rotate:\n'
            '${offenders.map((String p) => '  $p').join('\n')}',
      );
    });
  });

  group('iPad screen adoption ledger', () {
    // Phase 2 of docs/IPAD_ADAPTIVE_PLAN.md. Each entry pins the *gate* (so a
    // wide branch can never start firing on a phone) and the marker of the wide
    // layout itself. When a screen is adopted, add its row here.
    const Map<String, List<String>> adopted = <String, List<String>>{
      'lib/features/flashcards/presentation/screens/deck_detail_screen.dart':
          <String>[
        'if (!context.zenWindow.isExpanded) return deckBody;',
        '_DeckInsightRail(',
      ],
      'lib/features/flashcards/presentation/screens/settings_screen.dart':
          <String>['maxWidth: 760'],
      'lib/features/flashcards/presentation/screens/dictionary_screen.dart':
          <String>['maxWidth: 1100'],
      'lib/features/reading/presentation/screens/book_catalog_screen.dart':
          <String>[
        'if (context.zenWindow.isExpanded &&',
        '(_previewBook != null || _previewStory != null)) ...<Widget>[',
        'embedded: true',
        // The pane owns no route, so the catalogue must hand it the way out —
        // for the book pane and the story pane alike.
        'onClose: _closeDetailPane,',
      ],
      'lib/features/reading/presentation/screens/book_detail_screen.dart':
          <String>[
        'final bool embedded;',
        'automaticallyImplyLeading: false',
        // Dismissal for the embedded pane, and the reason its cover drops the
        // shared-element tag while embedded (the catalogue's card still has it).
        'widget.embedded && widget.onClose != null',
        'enabled: !widget.embedded',
      ],
      // Part 2b: the Pencil plumbing and the iPad writing surface.
      'lib/features/flashcards/presentation/widgets/drawing_canvas.dart':
          <String>[
        'final bool palmRejection;',
        'final bool stylusInput;',
        'livePressures: _livePressures',
      ],
      'lib/features/course/presentation/widgets/lesson_steps/drawing_step.dart':
          <String>['zenValue(context, compact: 300.0, expanded: 460.0)'],
      // Part 2b: the writing bench — the surface and the context pane.
      'lib/features/flashcards/presentation/screens/writing_bench_screen.dart':
          <String>[
        'window.isExpanded',
        'class _WritingSurface extends StatelessWidget',
        'static const double maxSide = 560;',
      ],
      // Part 2b: the listen-and-read desk — the transport beside the text, with
      // the audio as the clock. Its two hosts were promoted to real panes (no
      // app bar of their own, no route of their own), which is why all three
      // files are pinned here.
      'lib/features/reading/presentation/screens/listen_and_read_screen.dart':
          <String>[
        'ZenTwoPaneScaffold(',
        'onLocationChanged: _onAudioLocation',
        'key: ValueKey<String>(\'reader-\$_chapterIndex-\$_readerEpoch\')',
      ],
      'lib/features/reading/presentation/screens/audiobook_player_screen.dart':
          <String>[
        'final bool embedded;',
        'widget.onLocationChanged?.call(',
        'if (context.zenWindow.isExpanded) {',
      ],
      'lib/features/reading/presentation/screens/book_reader_screen.dart':
          <String>[
        'final bool embedded;',
        'appBar: widget.embedded',
      ],
      // Phase 2, last screen: the character reference. The wide layout already
      // existed; what changed is *when* it fires (window class, never a raw
      // width). The sections are now always two columns beside the card, so
      // every entry point — floating Quick Look or the dictionary sheet — lands
      // on the same page and the pill bar is never built here.
      'lib/features/flashcards/presentation/screens/character_detail_screen.dart':
          <String>[
        'window.isAtLeastMedium',
        'ZenBreakpoints.compactMax',
        '_buildDetailColumns(context, isDark)',
      ],
      // Phase 3, first slice: the video subtitles ramp with the window class so
      // a tablet's viewing distance is not a phone's.
      'lib/features/media/presentation/widgets/premium_subtitles_overlay.dart':
          <String>[
        'zenValue(context,',
        'compact: 36, medium: 40, expanded: 44',
        'compact: 22, medium: 24, expanded: 26',
      ],
      // Phase 3: the browser's extracted-words review as a pane beside the page
      // instead of a sheet over it (#48). The sheet keeps its modal path — the
      // pane hands it an `onConfirm` — so a phone is unchanged.
      'lib/features/media/presentation/screens/web_browser_screen.dart':
          <String>[
        'if (context.zenWindow.isExpanded) {',
        'onConfirm: (List<AiWord> words) {',
        'Future<bool> _addSelectedWordsToDeck(',
        'void _dismissExtracted(List<AiWord>? value) {',
      ],
      // Phase 3: the scanner's adaptive full-screen preview (#71) — full-screen
      // camera preview on iPad and phone, with BoxFit.cover and centered controls.
      'lib/features/premium/presentation/screens/universal_scanner_screen.dart':
          <String>[
        'Positioned.fill(child: _buildCameraPreview())',
        'Widget _buildCameraPreview() {',
        'Widget _buildBottomControls(',
        'Widget _buildZoomSlider()',
      ],
      // Phase 3: the media desk's landscape split (#44) — video + transport left,
      // AI prep + transcript right, with the phone column expressed once.
      'lib/features/media/presentation/screens/smart_media_desk_screen.dart':
          <String>[
        'final bool split = context.zenWindow.isExpanded;',
        'Widget _buildVideoPane() {',
        'Expanded(flex: 2, child: contentPane)',
      ],
      // Phase 3, same family: the transcript line's reading text ramps too.
      'lib/features/media/presentation/widgets/premium_transcript_line.dart':
          <String>[
        'zenValue(context, compact: 22, medium: 24, expanded: 26)',
      ],
    };

    adopted.forEach((String path, List<String> markers) {
      test('$path keeps its iPad branch gated', () {
        final File file = File(path);
        expect(file.existsSync(), isTrue, reason: '$path is missing');
        final String source = file.readAsStringSync();
        for (final String marker in markers) {
          expect(
            source,
            contains(marker),
            reason: '$path no longer contains `$marker`. The iPad treatment is '
                'documented in docs/IPAD_ADAPTIVE_PLAN.md (Phase 2) — if it was '
                'removed on purpose, delete its row here too.',
          );
        }
      });
    });

    test('no adopted screen branches on a raw width comparison', () {
      // The gate must be the window class, never `size.width > 800` or similar:
      // a Split View slice must keep the phone layout whatever the device is.
      final RegExp raw = RegExp(r'(width|shortestSide)\s*[><]=?\s*\d{3}');
      final List<String> offenders = <String>[];
      for (final String path in adopted.keys) {
        final String source = File(path).readAsStringSync();
        for (final RegExpMatch m in raw.allMatches(source)) {
          // Ignore the content caps, which are legitimate fixed numbers.
          if (source.substring(m.start, m.end).contains('maxWidth')) continue;
          offenders.add('$path: ${source.substring(m.start, m.end)}');
        }
      }
      expect(
        offenders,
        isEmpty,
        reason: 'These screens compare the window to a magic number instead of '
            'gating on context.zenWindow:\n${offenders.join('\n')}',
      );
    });
  });

  group('adaptive coverage', () {
    test('the layout harness still carries iPad and landscape viewports', () {
      expect(kIpadViewports, isNotEmpty);
      expect(
        kIpadViewports.any((Size s) => s.width > s.height),
        isTrue,
        reason: 'At least one iPad landscape viewport must stay in the matrix',
      );
      expect(
        kLandscapePhoneViewports.any((Size s) => s.width > s.height),
        isTrue,
      );
      expect(
        kAllViewports.length,
        greaterThanOrEqualTo(kTightViewports.length + 6),
        reason: 'The full matrix must keep the phone, landscape and iPad sets',
      );
    });

    test('the documented breakpoints classify real iPad sizes correctly', () {
      expect(ZenBreakpoints.classify(390), ZenWindowClass.compact);
      expect(ZenBreakpoints.classify(600), ZenWindowClass.medium);
      expect(ZenBreakpoints.classify(744), ZenWindowClass.medium,
          reason: 'iPad mini portrait');
      expect(ZenBreakpoints.classify(834), ZenWindowClass.medium,
          reason: 'iPad Air portrait (Split View half)');
      expect(ZenBreakpoints.classify(1024), ZenWindowClass.expanded);
      expect(ZenBreakpoints.classify(1194), ZenWindowClass.expanded,
          reason: 'iPad Air landscape');
      expect(ZenBreakpoints.classify(1366), ZenWindowClass.large,
          reason: 'iPad Pro 12.9 landscape');
      expect(ZenBreakpoints.classify(1600), ZenWindowClass.extraLarge);
    });

    test('tablet detection matches the smallest iPad', () {
      // 744dp (iPad mini portrait) is the smallest tablet window we support, and
      // no phone may slip in.
      expect(ZenBreakpoints.tabletShortestSide, lessThanOrEqualTo(744.0),
          reason: 'iPad mini portrait must count as a tablet');
      expect(ZenBreakpoints.tabletShortestSide, greaterThan(568.0),
          reason: 'No phone may be classified as a tablet');
    });

    test('the orientation API the app calls from main() is exposed', () {
      expect(ZenDevice.isTabletWindow, isA<bool>());
      expect(ZenDevice.applyStartupOrientation, isA<Function>());
      expect(ZenOrientationLock.isLocked, isFalse);
    });
  });
}
