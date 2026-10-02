import 'dart:math' as math;

import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/core/providers.dart';
import 'package:hanzi_master/core/providers/translation_language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/shared/widgets/bouncing_button.dart';
import 'package:hanzi_master/core/utils/pinyin_utils.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:hanzi_master/features/flashcards/domain/entities/flashcard.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/character_detail_provider.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/character_detail_screen.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/flashcard_edit_dialog.dart';
import 'package:hanzi_master/core/services/gemini_service.dart';
import 'package:hanzi_master/shared/widgets/global_blurred_bottom_sheet.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/shadowing_studio_screen.dart'
    as hanzi_shadowing;
import 'package:hanzi_master/core/utils/shadowing_line.dart';
import 'package:hanzi_master/shared/widgets/calligraphy_canvas_sheet.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/ai_explainer_sheet.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/deck_selection_sheet.dart';
import 'package:hanzi_master/shared/routes/swipe_back_route.dart';
import 'package:hanzi_master/core/widgets/translated_definition.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/dictionary_expansion_panel.dart';
import 'package:hanzi_master/shared/widgets/quick_look_positioning.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hanzi_master/shared/widgets/ai_consent_sheet.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';

// ---------------------------------------------------------------------------
// Helpers — clean raw CC-CEDICT strings before display
// ---------------------------------------------------------------------------

/// Converts numeric pinyin to proper tone marks: da4 → dà, jiao1 → jiāo
String _cleanPinyin(String raw) => PinyinUtils.convertNumericToMarks(raw);

/// The reading of [hanzi], derived from the characters themselves.
///
/// The dictionary is the source of truth for pinyin, so this is only used when
/// it has nothing to say. A card whose reading slot was left empty is what
/// "Quick Look shows nothing" looked like: the reading does not depend on the
/// dictionary at all, so the panel can still answer that question while it
/// waits for — or instead of — a definition.
String _derivedPinyin(String hanzi) {
  if (hanzi.isEmpty) return '';
  final String derived = PinyinHelper.getPinyinE(
    hanzi,
    separator: ' ',
    format: PinyinFormat.WITH_TONE_MARK,
  ).trim();
  // Characters the library has no reading for are echoed back unchanged: that
  // is not a reading, so the slot stays empty rather than repeating the hanzi.
  return derived == hanzi ? '' : derived;
}

/// Strips CC-CEDICT embedded annotations like 大姐[da4 jie3] → 大姐
/// and trims the definition to the first 2 meaningful parts.
String _cleanDefinition(String raw) {
  // 1. Remove bracketed pinyin annotations: word[pin1 yin1]
  String s = raw.replaceAll(RegExp(r'\[[a-zA-Z0-9\s:]+\]'), '');
  // 2. Remove standalone numeric pinyin remnants
  s = s.replaceAll(RegExp(r'\b[a-zA-Z]+[1-5]\b'), '');
  // 3. Remove "abbr. for ..." phrases
  s = s.replaceAll(RegExp(r'\babbr\. for [^;]+', caseSensitive: false), '');
  // 4. Split on semicolons and take first 3 distinct parts
  final parts = s
      .split(';')
      .map((p) => p.trim())
      .where((p) => p.isNotEmpty && p.length > 1)
      .toList();
  if (parts.isEmpty) return s.trim();
  // Cap at 3 to avoid walls of text
  final shown = parts.take(3).join('; ');
  final remainder = parts.length > 3 ? '…' : '';
  return shown + remainder;
}

enum QuickLookPresentation { bottomSheet, readingPopover }

/// Shows Quick Look using the presentation explicitly selected by its caller.
Future<void> showQuickLook(
  BuildContext context,
  String hanzi, {
  String? contextText,
  Flashcard? card,
  QuickLookPresentation presentation = QuickLookPresentation.bottomSheet,
  Offset? anchorPosition,
  VoidCallback? onDismiss,
  bool autoExpand = false,
}) async {
  if (hanzi.isEmpty) return;
  if (presentation == QuickLookPresentation.readingPopover &&
      anchorPosition != null) {
    final shown = await _showAnchoredQuickLook(
      context,
      hanzi,
      contextText: contextText,
      card: card,
      anchorPosition: anchorPosition,
      autoExpand: autoExpand,
    );
    if (shown) {
      onDismiss?.call();
      return;
    }
    if (!context.mounted) return;
  }
  await showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useSafeArea: true,
    useRootNavigator: true,
    barrierColor: Colors.black.withValues(alpha: 0.16),
    builder: (sheetContext) => ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(sheetContext).height * 0.72,
      ),
      child: GlobalBlurredBottomSheet(
        child: SingleChildScrollView(
          child: _QuickLookSheet(
            hanzi: hanzi,
            contextText: contextText,
            initialCard: card,
            autoExpand: autoExpand,
          ),
        ),
      ),
    ),
  );
  onDismiss?.call();
}

Future<bool> _showAnchoredQuickLook(
  BuildContext context,
  String hanzi, {
  required Offset anchorPosition,
  String? contextText,
  Flashcard? card,
  bool autoExpand = false,
}) async {
  final mediaQuery = MediaQuery.of(context);
  final anchorRect = Rect.fromCircle(center: anchorPosition, radius: 12);
  final effectiveSafePadding = EdgeInsets.only(
    top: math.max(mediaQuery.padding.top, mediaQuery.viewPadding.top),
    bottom: math.max(
      math.max(mediaQuery.padding.bottom, mediaQuery.viewPadding.bottom),
      mediaQuery.viewInsets.bottom,
    ),
    left: math.max(mediaQuery.padding.left, mediaQuery.viewPadding.left),
    right: math.max(mediaQuery.padding.right, mediaQuery.viewPadding.right),
  );
  final layout = calculateQuickLookPopoverLayout(
    viewportSize: mediaQuery.size,
    safePadding: effectiveSafePadding,
    anchorRect: anchorRect,
    textScaleFactor: mediaQuery.textScaler.scale(1),
  );
  if (layout == null) return false;

  await showGeneralDialog<void>(
    context: context,
    useRootNavigator: true,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black.withValues(alpha: 0.16),
    transitionDuration: ZenMotion.swap,
    pageBuilder: (dialogContext, _, __) => Stack(
      children: [
        Positioned(
          left: layout.left,
          top: layout.top,
          bottom: layout.bottom,
          width: layout.width,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: layout.maxHeight),
            child: _QuickLookPopover(
              child: _QuickLookSheet(
                hanzi: hanzi,
                contextText: contextText,
                initialCard: card,
                autoExpand: autoExpand,
              ),
            ),
          ),
        ),
      ],
    ),
    transitionBuilder: (_, animation, __, child) => FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: ZenMotion.enter),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.97, end: 1).animate(animation),
        alignment:
            layout.isAboveAnchor ? Alignment.bottomCenter : Alignment.topCenter,
        child: child,
      ),
    ),
  );
  return true;
}

/// A **non-modal** hover peek: the same body as the tap path, in an overlay entry
/// rather than a route, so hovering never blocks the page underneath and repeated
/// hovers cannot stack modal routes.
///
/// It is deliberately a *peek*: the overlay ignores pointers, so the page stays
/// fully interactive and a tap still opens the real sheet with its actions.
///
/// The caller owns the lifecycle — [QuickLookPeekHandle.dismiss] removes it.
class QuickLookPeekHandle {
  QuickLookPeekHandle._(this._entry);

  final OverlayEntry _entry;
  bool _dismissed = false;

  void dismiss() {
    if (_dismissed) return;
    _dismissed = true;
    if (_entry.mounted) _entry.remove();
  }
}

/// Marker around the peek overlay, so a test can assert presence/absence without
/// depending on the body's loading state.
class QuickLookPeekOverlay extends StatelessWidget {
  const QuickLookPeekOverlay({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}

/// Shows the hover peek for [hanzi] near [anchorPosition]. Returns `null` when
/// there is no room (or no overlay), in which case the caller can fall back to
/// the tap path.
QuickLookPeekHandle? showQuickLookPeek(
  BuildContext context,
  String hanzi, {
  required Offset anchorPosition,
  String? contextText,
  Flashcard? card,
}) {
  if (hanzi.isEmpty) return null;
  final OverlayState? overlay = Overlay.maybeOf(context, rootOverlay: true);
  if (overlay == null) return null;

  final MediaQueryData mediaQuery = MediaQuery.of(context);
  final QuickLookPopoverLayout? layout = calculateQuickLookPopoverLayout(
    viewportSize: mediaQuery.size,
    safePadding: EdgeInsets.only(
      top: math.max(mediaQuery.padding.top, mediaQuery.viewPadding.top),
      bottom:
          math.max(mediaQuery.padding.bottom, mediaQuery.viewPadding.bottom),
      left: math.max(mediaQuery.padding.left, mediaQuery.viewPadding.left),
      right: math.max(mediaQuery.padding.right, mediaQuery.viewPadding.right),
    ),
    anchorRect: Rect.fromCircle(center: anchorPosition, radius: 12),
    textScaleFactor: mediaQuery.textScaler.scale(1),
  );
  if (layout == null) return null;

  final OverlayEntry entry = OverlayEntry(
    builder: (BuildContext overlayContext) => Positioned(
      left: layout.left,
      top: layout.top,
      bottom: layout.bottom,
      width: layout.width,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: layout.maxHeight),
        child: QuickLookPeekOverlay(
          // A peek, not a dialog: the pointer goes straight through it.
          child: IgnorePointer(
            child: _QuickLookPopover(
              child: _QuickLookSheet(
                hanzi: hanzi,
                contextText: contextText,
                initialCard: card,
              ),
            ),
          ),
        ),
      ),
    ),
  );
  overlay.insert(entry);
  return QuickLookPeekHandle._(entry);
}

class _QuickLookPopover extends StatelessWidget {
  final Widget child;

  const _QuickLookPopover({required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: isDark ? const Color(0xFF1C1C1E) : const Color(0xFFFDFCF0),
      elevation: 18,
      shadowColor: Colors.black.withValues(alpha: 0.32),
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(22),
      child: SingleChildScrollView(child: child),
    );
  }
}

// ---------------------------------------------------------------------------
// Shell — handles loading / error / found states
// ---------------------------------------------------------------------------

class _QuickLookSheet extends ConsumerWidget {
  final String hanzi;
  final String? contextText;
  final Flashcard? initialCard;
  final bool autoExpand;
  const _QuickLookSheet({
    required this.hanzi,
    this.contextText,
    this.initialCard,
    this.autoExpand = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final allCards = ref.watch(flashcardControllerProvider).value ?? [];
    Flashcard? localCard;
    try {
      localCard = allCards.firstWhere(
        (c) =>
            c.hanzi == hanzi ||
            (initialCard != null && c.id == initialCard!.id),
      );
    } catch (_) {
      localCard = null;
    }
    final inDeck = localCard != null || allCards.any((c) => c.hanzi == hanzi);

    final wordId =
        initialCard?.dictionaryWordId ?? localCard?.dictionaryWordId;
    final AsyncValue<Flashcard?> asyncCard;
    if (wordId != null) {
      asyncCard = ref.watch(dictionaryWordProvider(wordId)).whenData((fresh) {
        final base = localCard ?? initialCard;
        if (fresh == null || base == null) return base;
        // Keep the saved card identity/study state while refreshing all
        // dictionary-owned fields for the currently selected language.
        return base.copyWith(
          pinyin: fresh.pinyin,
          definition: fresh.definition,
          definitionLanguage: fresh.definitionLanguage,
          dictionaryWordId: fresh.dictionaryWordId,
          englishDefinition: fresh.englishDefinition,
          localizedDefinitionQuality: fresh.localizedDefinitionQuality,
          isExpansionEligible: fresh.isExpansionEligible,
          sourceDefinitionHash: fresh.sourceDefinitionHash,
          hskLevel: base.hskLevel > 0 ? base.hskLevel : fresh.hskLevel,
          strokePaths: base.strokePaths.isNotEmpty
              ? base.strokePaths
              : (fresh.strokePaths.isNotEmpty
                  ? fresh.strokePaths
                  : base.strokePaths),
          medianPaths: base.medianPaths.isNotEmpty
              ? base.medianPaths
              : (fresh.medianPaths.isNotEmpty
                  ? fresh.medianPaths
                  : base.medianPaths),
        );
      });
    } else if (initialCard == null && localCard == null) {
      asyncCard = ref.watch(quickLookProvider(hanzi));
    } else {
      // Custom and legacy cards have no stable global-dictionary identity.
      final base = localCard ?? initialCard;
      asyncCard = AsyncValue<Flashcard?>.data(base);
    }
    final asyncCommon = ref.watch(commonWordsProvider(hanzi));

    return asyncCard.when(
      loading: () => _LoadingBody(isDark: isDark),
      error: (_, __) => _NotFoundBody(hanzi: hanzi, isDark: isDark),
      data: (card) => ZenFadeIn(
          child: card == null
              ? _NotFoundBody(hanzi: hanzi, isDark: isDark)
              : _FoundBody(
                  card: card,
                  isDark: isDark,
                  inDeck: inDeck,
                  asyncCommon: asyncCommon,
                  contextText: contextText,
                  tappedHanzi: hanzi,
                  autoExpand: autoExpand,
                )),
    );
  }
}

// ---------------------------------------------------------------------------
// Loading state
// ---------------------------------------------------------------------------

class _LoadingBody extends StatelessWidget {
  final bool isDark;
  const _LoadingBody({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 56),
      child: Center(
        child: ZenLoader(
          color: Colors.indigo,
          strokeWidth: 2,
          // Labelled for the same reason the not-found card is: a thin,
          // unlabelled arc in an otherwise empty panel reads as a rendering
          // fault rather than as a wait.
          label: AppLocalizations.of(context)!.loading,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Not found state
// ---------------------------------------------------------------------------

class _NotFoundBody extends ConsumerStatefulWidget {
  final String hanzi;
  final bool isDark;
  const _NotFoundBody({required this.hanzi, required this.isDark});

  @override
  ConsumerState<_NotFoundBody> createState() => _NotFoundBodyState();
}

class _NotFoundBodyState extends ConsumerState<_NotFoundBody> {
  bool _isLoadingAi = true;
  String? _aiPinyin;
  String? _aiDefinition;
  bool _aiFailed = false;

  @override
  void initState() {
    super.initState();
    _fetchAiDefinition();
  }

  Future<void> _fetchAiDefinition() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(AiConsentSheet.prefKey) != true) {
      // Without consent there is no answer to wait for. The card states what it
      // knows (the character and its reading) instead of spinning forever.
      if (mounted) setState(() => _isLoadingAi = false);
      return;
    }

    try {
      final aiDef = await ref
          .read(geminiServiceProvider)
          .defineWord(widget.hanzi)
          // A card that waits on the network indefinitely is indistinguishable
          // from a broken one, which is how this one was reported. Bound the
          // wait, then say the answer did not arrive.
          .timeout(const Duration(seconds: 15));
      if (!mounted) return;
      setState(() {
        _aiPinyin = aiDef['pinyin'];
        _aiDefinition = aiDef['meaning'];
        _isLoadingAi = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _aiFailed = true;
        _isLoadingAi = false;
      });
    }
  }

  /// Retries the lookup, repairing the dictionary first when it failed to read.
  ///
  /// A card the reader cannot act on is worse than a slow one: the retry is the
  /// only place a damaged local dictionary copy can be replaced, because the
  /// copy is otherwise only rebuilt while the app starts.
  Future<void> _retry() async {
    final repository = ref.read(globalDictionaryRepositoryProvider);
    final bool repair = !repository.isReady || repository.lastFailure != null;
    setState(() {
      _aiFailed = false;
      _isLoadingAi = _aiDefinition == null;
    });
    if (repair) {
      try {
        await repository.init(forceRepair: repository.lastFailure != null);
      } catch (_) {
        // The failure is recorded on the repository; the card keeps its honest
        // "unavailable" line rather than claiming the retry worked.
      }
    }
    ref.invalidate(quickLookProvider(widget.hanzi));
    if (mounted) await _fetchAiDefinition();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final repository = ref.watch(globalDictionaryRepositoryProvider);
    // The AI answer is English and needs translating; the status lines below are
    // already in the reader's language, so telling TranslatedDefinition that is
    // what keeps them on screen instead of hiding them behind a translation
    // round-trip.
    final String? definitionLanguage = _aiDefinition != null
        ? 'English'
        : ref.watch(translationLanguageProvider);
    final String status;
    if (_aiDefinition != null) {
      status = _aiDefinition!;
    } else if (_aiFailed) {
      status = l10n.errorLoadingFromAi;
    } else if (!repository.isReady) {
      status = l10n.informationUnavailable;
    } else {
      status = l10n.notFound;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _CharacterHero(
            hanzi: widget.hanzi,
            isDark: widget.isDark,
            // The dictionary has no entry, but the reading is derivable from
            // the character itself. Leaving this slot empty is what made a
            // missing definition look like a broken card.
            pinyin: _aiPinyin ?? _derivedPinyin(widget.hanzi),
            hskLevel: 0,
            definition: _isLoadingAi ? '' : status,
            definitionLanguage: definitionLanguage,
          ),
          const SizedBox(height: 16),
          if (_isLoadingAi)
            ZenLoader(
              color: Colors.indigo,
              strokeWidth: 2,
              // Labelled, so the thin arc under the character reads as "still
              // asking" rather than as a stray glyph.
              label: l10n.loading,
            )
          else
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add_box),
                    label: Text(l10n.reviewAddToLibrary),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    onPressed: () {
                      FlashcardEditDialog.show(
                        context,
                        hanzi: widget.hanzi,
                        pinyin: _cleanPinyin(
                            _aiPinyin ?? _derivedPinyin(widget.hanzi)),
                        definition: _cleanDefinition(status),
                      );
                    },
                  ),
                  TextButton.icon(
                    onPressed: _retry,
                    icon: const Icon(Icons.refresh, size: 18),
                    label: Text(l10n.retry),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Main content when character is found
// ---------------------------------------------------------------------------

class _FoundBody extends ConsumerWidget {
  final Flashcard card;
  final bool isDark;
  final bool inDeck;
  final AsyncValue<List<Flashcard>> asyncCommon;
  final String? contextText;
  final String tappedHanzi;
  final bool autoExpand;

  const _FoundBody({
    required this.card,
    required this.isDark,
    required this.inDeck,
    required this.asyncCommon,
    this.contextText,
    required this.tappedHanzi,
    this.autoExpand = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textColor = isDark ? Colors.white : const Color(0xFF1A1A1B);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Character hero panel ─────────────────────────────────────
          _CharacterHero(
            hanzi: card.hanzi,
            isDark: isDark,
            pinyin: card.pinyin,
            hskLevel: card.hskLevel,
            definition: card.definition,
            definitionLanguage: card.definitionLanguage,
          ),

          if (DictionaryExpansionPanel.isAvailableFor(card))
            DictionaryExpansionPanel(
              card: card,
              isDark: isDark,
              autoExpand: autoExpand,
              presentation: DictionaryExpansionPresentation.compact,
            ),

          // ── Compound words ───────────────────────────────────────────
          asyncCommon.maybeWhen(
            data: (words) {
              if (words.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Container(
                        width: 3,
                        height: 13,
                        decoration: BoxDecoration(
                          color: Colors.indigo.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 7),
                      Text(
                        AppLocalizations.of(context)!.alsoSeenIn,
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.6,
                          color: isDark
                              ? Colors.white70
                              : textColor.withValues(alpha: 0.45),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: words.take(5).length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (ctx, i) {
                        final w = words.toList()[i];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            showQuickLook(context, w.hanzi);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.indigo
                                  .withValues(alpha: isDark ? 0.18 : 0.08),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.indigo
                                      .withValues(alpha: isDark ? 0.3 : 0.18)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  w.hanzi,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: isDark
                                        ? Colors.blue.shade100
                                        : Colors.indigo,
                                    fontWeight: FontWeight.w600,
                                    height: 1,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  _cleanPinyin(w.pinyin),
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    color: isDark
                                        ? Colors.blue.shade200
                                        : Colors.indigo.withValues(alpha: 0.65),
                                    height: 1,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
            orElse: () => const SizedBox.shrink(),
          ),

          const SizedBox(height: 20),

          // ── Action buttons ────────────────────────────────────────────
          Row(
            children: [
              // Add / In Deck button
              Expanded(
                child: _ActionButton(
                  label: inDeck
                      ? AppLocalizations.of(context)!.inDeckCheck
                      : AppLocalizations.of(context)!.addToDeckPlus,
                  icon: inDeck ? Icons.check : Icons.add,
                  isPrimary: false,
                  isDisabled: false, // Make it always clickable
                  onTap: () async {
                    Navigator.pop(context);
                    await DeckSelectionSheet.show(context,
                        card: card.copyWith(sourceSentence: contextText));
                  },
                ),
              ),
              const SizedBox(width: 6),
              // Shadowing button
              Expanded(
                child: _ActionButton(
                  label: AppLocalizations.of(context)!.shadow,
                  icon: Icons.mic_outlined,
                  isPrimary: false,
                  isDisabled: false,
                  onTap: () {
                    final hasContext = contextText != null &&
                        contextText!.trim().isNotEmpty &&
                        contextText!.trim() != tappedHanzi.trim();
                    // A paragraph is not shadowable: keep the clause around the
                    // tapped word instead of whatever block arrived.
                    final effectiveSentence =
                        hasContext ? shadowingLine(contextText!, tappedHanzi) : null;
                    final effectivePinyin = hasContext
                        ? PinyinHelper.getPinyinE(effectiveSentence!,
                            separator: ' ', format: PinyinFormat.WITH_TONE_MARK)
                        : card.pinyin;
                    final effectiveTranslation =
                        hasContext ? null : card.definition;

                    Navigator.pop(context);
                    final isLandscape = MediaQuery.of(context).orientation ==
                        Orientation.landscape;
                    if (isLandscape) {
                      showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          backgroundColor: Colors.transparent,
                          insetPadding: const EdgeInsets.all(24),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                                maxWidth: 400, maxHeight: 500),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Container(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? const Color(0xFF1A1A1B)
                                    : const Color(0xFFFDFCF0),
                                child: hanzi_shadowing.ShadowingStudioScreen(
                                  initialHanzi: tappedHanzi,
                                  initialPinyin: effectivePinyin,
                                  initialTranslation: effectiveTranslation,
                                  initialContextSentence: effectiveSentence,
                                  isCompact: true,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      showModalBottomSheet(
                        context: context,
                        useRootNavigator: true,
                        isScrollControlled: true,
                        useSafeArea: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(24)),
                          child: hanzi_shadowing.ShadowingStudioScreen(
                            initialHanzi: tappedHanzi,
                            initialPinyin: effectivePinyin,
                            initialTranslation: effectiveTranslation,
                            initialContextSentence: effectiveSentence,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(width: 6),
              // Trace button
              Expanded(
                child: _ActionButton(
                  label: AppLocalizations.of(context)!.traceLabel,
                  icon: Icons.draw_outlined,
                  isPrimary: false,
                  isDisabled: false,
                  onTap: () {
                    Navigator.pop(context);
                    showCalligraphyCanvas(context, card);
                  },
                ),
              ),
              if (contextText != null && contextText!.isNotEmpty) ...[
                const SizedBox(width: 6),
                Expanded(
                  child: _ActionButton(
                    label: AppLocalizations.of(context)!.grammar,
                    icon: Icons.auto_awesome,
                    isPrimary: false,
                    isDisabled: false,
                    onTap: () {
                      Navigator.pop(context);
                      final aiWord = AiWord(
                          hanzi: card.hanzi,
                          pinyin: card.pinyin,
                          meaning: card.definition);
                      final aiSentence = AiSentence(
                          chinese: contextText!, english: '', words: []);
                      AiExplainerSheet.show(context, aiWord, aiSentence);
                    },
                  ),
                ),
              ],
              const SizedBox(width: 6),
              // Full card button
              Expanded(
                child: _ActionButton(
                  label: AppLocalizations.of(context)!.openCardArrow,
                  icon: Icons.open_in_new_rounded,
                  isPrimary: true,
                  isDisabled: false,
                  onTap: () {
                    final nav = Navigator.of(context, rootNavigator: true);
                    nav.pop();
                    nav.push(
                      SwipeBackPageRoute(
                          builder: (_) => CharacterDetailScreen(card: card)),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Character Hero — the gradient spotlight panel
// ---------------------------------------------------------------------------

class _CharacterHero extends StatelessWidget {
  final String hanzi;
  final String pinyin;
  final int hskLevel;
  final bool isDark;
  final String definition;
  final String? definitionLanguage;

  const _CharacterHero({
    required this.hanzi,
    required this.pinyin,
    required this.hskLevel,
    required this.isDark,
    required this.definition,
    this.definitionLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  Colors.indigo.shade900.withValues(alpha: 0.6),
                  Colors.indigo.shade800.withValues(alpha: 0.2),
                ]
              : [
                  Colors.indigo.shade50,
                  Colors.indigo.shade100.withValues(alpha: 0.3),
                ],
        ),
        border: Border.all(
          color: Colors.indigo.withValues(alpha: isDark ? 0.3 : 0.15),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Faint Calligraphy Watermark on the far right
            Positioned(
              right: -30,
              top: -20,
              bottom: -20,
              child: Opacity(
                opacity: isDark ? 0.04 : 0.06,
                child: Center(
                  child: Text(
                    hanzi,
                    style: TextStyle(
                      fontSize: 140,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.indigo.shade900,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ),

            // Foreground Content
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Large character
                  Text(
                    hanzi,
                    style: TextStyle(
                      fontSize:
                          (72.0 - (hanzi.length - 1) * 12).clamp(36.0, 72.0),
                      fontWeight: FontWeight.w100,
                      color: isDark ? Colors.white : Colors.indigo.shade800,
                      height: 1,
                      shadows: [
                        Shadow(
                          color: Colors.indigo
                              .withValues(alpha: isDark ? 0.4 : 0.15),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 18),

                  // Pinyin + Definition + Badges
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (pinyin.isNotEmpty)
                          Text(
                            _cleanPinyin(pinyin),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: isDark
                                  ? Colors.white70
                                  : Colors.indigo.shade700,
                              fontStyle: FontStyle.italic,
                              letterSpacing: 0.5,
                            ),
                          ),
                        const SizedBox(height: 6),

                        // Definition integrated into the card
                        if (definition.isNotEmpty)
                          TranslatedDefinition(
                            definition: definition,
                            definitionLanguage: definitionLanguage,
                            hanzi: hanzi,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            originalStyle: TextStyle(
                              fontSize: 14,
                              color: isDark
                                  ? Colors.white.withValues(alpha: 0.75)
                                  : const Color(0xFF1A1A1B)
                                      .withValues(alpha: 0.75),
                              height: 1.3,
                            ),
                          ),
                        const SizedBox(height: 10),

                        Row(
                          children: [
                            if (hskLevel > 0)
                              _Badge(
                                label: "HSK $hskLevel",
                                color: Colors.indigo,
                                isDark: isDark,
                              ),
                            if (ChineseHelper.isTraditionalChinese(hanzi)) ...[
                              if (hskLevel > 0) const SizedBox(width: 6),
                              _Badge(
                                label:
                                    AppLocalizations.of(context)!.traditional,
                                color: Colors.orange,
                                isDark: isDark,
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Small badge chip
// ---------------------------------------------------------------------------

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  final bool isDark;
  const _Badge(
      {required this.label, required this.color, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.25 : 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: isDark ? 0.5 : 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: isDark ? Colors.white70 : color,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Action button — primary (indigo filled) or secondary (outlined)
// ---------------------------------------------------------------------------

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isPrimary;
  final bool isDisabled;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.label,
    this.icon,
    required this.isPrimary,
    required this.isDisabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveColor = isDisabled ? Colors.grey : Colors.indigo;
    final disabledBg = isDark ? Colors.grey.shade800 : Colors.grey.shade300;

    return BouncingButton(
      onPressed: onTap,
      child: AnimatedContainer(
        duration: ZenMotion.of(context, ZenMotion.swap),
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isPrimary
              ? (isDisabled ? disabledBg : Colors.indigo)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: isPrimary
              ? null
              : Border.all(
                  color: effectiveColor.withValues(alpha: 0.35),
                  width: 1.5,
                ),
          boxShadow: isPrimary && !isDisabled
              ? [
                  BoxShadow(
                    color: Colors.indigo.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Icon(
                icon,
                size: 16,
                color: isPrimary
                    ? Colors.white
                    : (isDisabled ? Colors.grey : Colors.indigo),
              ),
            if (icon != null) const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isPrimary
                    ? Colors.white
                    : (isDisabled ? Colors.grey : Colors.indigo),
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
