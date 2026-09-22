import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Regressions for the "Comparer" sheet opened from the Deck Library.
///
/// Two bugs:
///  1. "Continuer la discussion" called `_enterChatMode()`, which started a
///     *fresh* `AiChatSession` and never seeded `_chatMessages`. The chat view
///     therefore opened visually empty and the AI had no memory of the
///     comparison it was supposed to be continuing.
///  2. `_buildFormattedContent` ran the numeric→diacritic pinyin converter over
///     the entire AI response, so digits in ordinary English prose were
///     rewritten ("weird" output). It also mutated `block` while looping over
///     the highlight targets, making which word got bolded depend on iteration
///     order.
///
/// Verified against source because the sheet streams from a live AI session.
void main() {
  late String sheetSource;
  late String formattedContent;
  late String enterChatMode;

  setUpAll(() {
    sheetSource = File(
      'lib/shared/widgets/nuance_compare_sheet.dart',
    ).readAsStringSync();

    final fmtStart = sheetSource.indexOf(
        'Widget _buildFormattedContent(String rawText, ThemeData theme, bool isDark) {');
    expect(fmtStart, greaterThan(-1));
    formattedContent = sheetSource.substring(
      fmtStart,
      sheetSource.indexOf('Widget _buildContent('),
    );

    final chatStart = sheetSource.indexOf('void _enterChatMode() {');
    expect(chatStart, greaterThan(-1));
    enterChatMode = sheetSource.substring(
      chatStart,
      sheetSource.indexOf('Future<void> _sendChatMessage('),
    );
  });

  group('continue-chat keeps the previous comparison', () {
    test('the chat transcript is seeded before entering chat mode', () {
      expect(enterChatMode, contains('_chatMessages.add('),
          reason: 'Without seeding, the chat panel opens empty');
      expect(enterChatMode, contains('_streamedText.trim()'),
          reason: 'The comparison just read is the content to carry over');
      expect(enterChatMode, contains('isContext: true'),
          reason: 'Carried-over text must render as reference, not a bubble');
    });

    test('seeding only happens when there is a comparison to carry', () {
      expect(enterChatMode, contains('_streamedText.trim().isNotEmpty'),
          reason: 'An empty or errored comparison must not be seeded');
      expect(enterChatMode, contains('_chatMessages.isEmpty'),
          reason: 'Re-entering chat must not duplicate the comparison');
    });

    test('the chat opens scrolled to the seeded context', () {
      expect(enterChatMode, contains('_scrollToBottom()'),
          reason: 'The carried-over comparison should be visible on entry');
    });

    test('the response language follows the app locale', () {
      expect(enterChatMode, contains('Localizations.localeOf(context)'),
          reason: 'The language used to be hardcoded to English');
      expect(
          enterChatMode,
          isNot(contains("startCharacterChat(wordNames, 'en')")),
          reason: 'Hardcoded en ignored the user language');
    });

    test('the context message is flagged as reference content', () {
      expect(sheetSource, contains('bool isContext'),
          reason: '_ChatMessage must model the seeded comparison');
      expect(sheetSource, contains('if (msg.isContext)'),
          reason: 'The chat list must render context separately');
    });

    test('the context label is localized', () {
      expect(sheetSource, contains('AppLocalizations.of(context)!.comparisonLabel'),
          reason: 'The COMPARISON label must not be hardcoded English');
      expect(sheetSource, isNot(contains("'Comparison',")),
          reason: 'Hardcoded label bypassed localization');
    });
  });

  group('comparison formatting does not corrupt prose', () {
    test('pinyin conversion is gated on the text containing Chinese', () {
      expect(formattedContent, contains('_normalizePinyin('),
          reason: 'Conversion must go through the guarded helper');
      expect(
        formattedContent,
        isNot(contains('PinyinUtils.convertNumericToMarks(rawText)')),
        reason: 'Converting the whole response rewrote digits in prose',
      );
      expect(formattedContent, contains('hasMatch(text)'),
          reason: 'The guard must detect Han characters');
    });

    test('the original response is not converted as a whole', () {
      expect(formattedContent, contains('rawText.split('),
          reason: 'Blocks should come from the untouched raw text');
      expect(formattedContent, isNot(contains("processed.split(")));
      expect(formattedContent, isNot(contains('String processed =')));
    });

    test('word highlighting is order-independent', () {
      expect(formattedContent, contains('_leadingWordOf('),
          reason: 'The target word must be resolved once from the raw line');
      expect(
        formattedContent,
        isNot(contains('block.replaceFirst(hanzi')),
        reason: 'Mutating block mid-loop made bolding order-dependent',
      );
      // The word loop must live in the helper, not the render path, so one
      // substitution can never change what the next word matches.
      final loopIndex =
          formattedContent.indexOf('for (final w in widget.words)');
      final helperIndex = formattedContent.indexOf('String? _leadingWordOf(');
      expect(helperIndex, greaterThan(-1));
      expect(loopIndex, greaterThan(helperIndex),
          reason: 'Iteration belongs in the helper, after the render body');
    });

    test('highlighted characters are regex-escaped', () {
      expect(formattedContent, contains('RegExp.escape(leadingWord)'),
          reason: 'Stored hanzi must not be treated as a pattern');
    });

    test('bullets are still bolded for the leading word', () {
      expect(formattedContent, contains(r'**$leadingWord**'));
      expect(formattedContent, contains(r"RegExp(r'^([\*\-•]\s+)')"),
          reason: 'The *, - and bullet forms must all be handled');
    });
  });
}

