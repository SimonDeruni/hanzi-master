/// The Echo Hall roleplay's **text chat** — the transcript you land on after
/// choosing "Text Chat" in the launcher.
///
/// It now follows the Bureau du savant, the app's other AI conversation:
///
///  1. **The iPad gets a desk, not a stretched transcript.** At expanded the
///     transcript keeps a column of its own, centred on a readable measure, and
///     the persona, the description and the objectives move into a panel beside
///     it — replacing the floating quests badge, which a phone-sized badge
///     cannot express.
///  2. **The measure is measured, not assumed.** The bubble width used to be 80%
///     of the *window*: on a 1366dp iPad that is a 1093dp bubble, one sentence of
///     Chinese per line. It now comes from the column's own `LayoutBuilder`,
///     capped at `ZenContentWidth.reading`.
///  3. **Messages animate, but only once.** Every bubble rises in through the
///     shared `ChatMessageEntrance`, memoised by id — a `SliverList` recycles the
///     elements it scrolls past, so without the memo a transcript would replay
///     every entrance on the way back up.
///
/// The screen needs the AI services to render, so these decisions are pinned in
/// source rather than faked into a widget tree — the same approach as
/// `character_detail_ipad_layout_test.dart`.
@Tags(<String>['ipad-sweep'])
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

const String _screenPath =
    'lib/features/echo_hall/presentation/screens/conversation_screen.dart';

void main() {
  late String screen;

  setUpAll(() {
    screen = File(_screenPath).readAsStringSync().replaceAll('\r\n', '\n');
  });

  /// The body of a method, bounded by its closing brace at method indentation.
  String body(String signature) {
    final int start = screen.indexOf(signature);
    expect(start, greaterThan(-1), reason: '$signature not found');
    final int end = screen.indexOf('\n  }\n', start);
    expect(end, greaterThan(start), reason: 'could not bound $signature');
    return screen.substring(start, end);
  }

  group('the iPad desk', () {
    test('the split is gated on the window class, never a raw width', () {
      final String build = body('Widget build(BuildContext context) {');
      expect(build, contains('context.zenWindow.isExpanded'));
      expect(build, contains('_buildScenarioDesk('));
      expect(
        RegExp(r'(width|shortestSide)\s*[><]=?\s*\d{3}').hasMatch(screen),
        isFalse,
        reason: 'A raw pixel comparison is what hands a Split View half the '
            'iPad layout',
      );
    });

    test('both arrangements share one transcript column', () {
      final String build = body('Widget build(BuildContext context) {');
      expect(RegExp(r'_buildChatColumn\(').allMatches(build).length, 2,
          reason: 'The phone and the iPad must not drift apart');
    });

    test('the phone keeps the floating badge and the desk does not', () {
      final String column = body('Widget _buildChatColumn(');
      expect(column, contains('showQuestsButton && quests.isNotEmpty'));
      expect(body('Widget _buildScenarioDesk('),
          contains('_buildObjectivesCard('),
          reason: 'The desk carries the objectives as a titled card instead');
    });

    test('the desk carries the persona, the scenario and its words', () {
      final String desk = body('Widget _buildScenarioDesk(');
      expect(desk, contains('_buildPersonaChip('));
      expect(desk, contains('widget.scenario.description'));
    });

    test('the desk width steps with the window class', () {
      final String desk = body('Widget _buildScenarioDesk(');
      expect(desk, contains('zenValue(context'),
          reason: 'One width for every iPad ignores the 13" class');
      expect(desk, contains('width: deskWidth'));
      expect(desk, contains('boxShadow:'),
          reason: 'A soft edge is what makes it a docked pane');
    });
  });

  group('the measured transcript', () {
    test('the measure comes from the column, not the window', () {
      final String column = body('Widget _buildChatColumn(');
      expect(column, contains('LayoutBuilder('));
      expect(column, contains('constraints.maxWidth'));
      expect(column, contains('ZenContentWidth.reading'));
      expect(screen, isNot(contains('width * 0.8')),
          reason: '80% of the window on a 1366dp iPad is a 1093dp bubble');
      expect(screen, isNot(contains('MediaQuery.of(context).size')));
    });

    test('the bubble is capped by that measure', () {
      expect(body('Widget _buildMessage('), contains('maxBubbleWidth'));
    });

    test('a slow reply shows the shared typing dots', () {
      final String column = body('Widget _buildChatColumn(');
      expect(column, contains('state.isProcessing ? 1 : 0'),
          reason: 'The dots are an extra row, not a queued message');
      expect(body('Widget _buildTypingRow('), contains('ChatTypingDots('));
    });

    test('an empty transcript explains itself', () {
      final String column = body('Widget _buildChatColumn(');
      expect(column, contains('_buildOpeningState('));
      expect(body('Widget _buildOpeningState('), contains('ZenLoader('));
    });
  });

  group('the animated transcript', () {
    test('every message rises in through the shared entrance, once', () {
      final String message = body('Widget _buildMessage(');
      expect(message, contains('ChatMessageEntrance('));
      expect(message, contains('animate: !_enteredMessages.contains'));
      expect(message, contains('_enteredMessages.add('),
          reason: 'The id is memoised where the entrance reports itself');
    });

    test('a reply leads with the persona and keeps one action row', () {
      final String message = body('Widget _buildMessage(');
      expect(message, contains('_buildPersonaChip(theme)'));
      expect(message, contains('_buildSpeakButton(message, theme)'),
          reason: 'The speaker belongs with the translate toggle, not in front '
              'of the persona');
    });

    test('the composer animates between its two modes', () {
      final String input = body('Widget _buildInputArea(');
      expect(input, contains('AnimatedSwitcher('));
      expect(input, contains('AnimatedContainer('));
      expect(input, contains('_hasText'));
      expect(input, contains('_buildSendButton('));
      expect(input, contains('_buildMicButton('));
    });

    test('the quests badge grows open instead of appearing', () {
      final String badge =
          screen.substring(screen.indexOf('class _QuestsFloatingButtonState'));
      expect(badge, contains('AnimatedSize('));
    });

    test('a stranded reader gets an animated way back', () {
      final String column = body('Widget _buildChatColumn(');
      expect(column, contains('_buildJumpToLatest('));
      expect(column, contains('AnimatedScale('));
      expect(column, contains('AnimatedOpacity('));
      expect(column, contains('_isNearBottom'));
      expect(screen, contains('_syncScrollAffordance'),
          reason: 'The pill is driven by the scroll position, not a timer');
    });

    test('the suggested reply is one tap, one beat behind the bubble', () {
      final String message = body('Widget _buildMessage(');
      expect(message, contains('_buildSuggestionCard('));

      final String card = body('Widget _buildSuggestionCard(');
      expect(card, contains('ChatMessageEntrance('),
          reason: 'The chip follows the bubble rather than landing with it');
      expect(card, contains('delay: ZenMotion.beat'));
      expect(card, contains('_buildSuggestionChip('));

      expect(body('Widget _buildSuggestionChip('),
          contains('BouncingButton('));
      expect(screen, contains('void _sendSuggestion('));
    });
  });

  group('the paper transcript', () {
    test('a reply sits on the Bureau du savant\'s paper', () {
      final String message = body('Widget _buildMessage(');
      expect(message, contains('_bubblePaper(theme)'),
          reason: 'The two AI conversations should read as one product');
      expect(screen, contains('Color(0xFFFFF8EE)'));
      expect(screen, contains('Color(0xFF252525)'));
      expect(message, isNot(contains('theme.cardTheme.color')),
          reason: 'The raw card colour is what made the bubbles look pasted on');
    });

    test('the score is a chip, not three bare fragments', () {
      final String badge = body('Widget _buildScoreBadge(');
      expect(badge, contains('BorderRadius.circular(20)'));
      expect(badge, contains('l10n.grading'));
      expect(badge, contains('l10n.scoreText'));
      expect(badge, contains('Icons.graphic_eq_rounded'));
    });

    test('the composer keeps the transcript measure', () {
      final String input = body('Widget _buildInputArea(');
      expect(input, contains('_readingInset(constraints.maxWidth)'),
          reason: 'Spanning a 1000dp iPad column reads as a stretched phone');
      expect(body('Widget _buildChatColumn('), contains('_readingInset('));
      expect(screen, contains('double _readingInset('));
    });
  });

  group('localisation', () {
    test('the composer no longer hardcodes English at the user', () {
      final String input = body('Widget _buildInputArea(');
      expect(input, contains('l10n.thinking'));
      expect(input, contains('l10n.listening'));
      expect(input, contains('l10n.typeYourMessage'));
      for (final String literal in <String>[
        '"Thinking..."',
        '"Listening..."',
        '"Type your message..."',
        '"QUESTS"',
        '"Suggestion"',
      ]) {
        expect(screen, isNot(contains(literal)),
            reason:
                '$literal is still a bare English string in a localised app');
      }
    });

    test('the score badge and the bookmark speak the interface language', () {
      // The composer's hints were localised with the redesign; these two blocks
      // sit a few dozen lines further down the same screen and were left behind.
      final String badge = body('Widget _buildScoreBadge(');
      expect(badge, contains('l10n.grading'));
      expect(badge, contains('l10n.scoreText'));

      final String bookmark = body('Widget _buildBookmarkButton(');
      expect(bookmark, contains('l10n.removeFromSavedScenarios'));
      expect(bookmark, contains('l10n.saveScenario'));
      expect(bookmark, contains('l10n.scenarioRemoved'));
      expect(bookmark, contains('l10n.scenarioSavedFindInCustomTab'));

      for (final String literal in <String>[
        "'Grading...'",
        "'Remove from saved scenarios'",
        "'Save this scenario'",
        "'Scenario removed'",
        "'Scenario saved! Find it in the Custom tab.'",
      ]) {
        expect(screen, isNot(contains(literal)),
            reason:
                '$literal is still a bare English string in a localised app');
      }
    });
  });
}
