import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

import '../../../../core/personal/her_account.dart';
import '../../../../core/personal/widgets/her_deck_library.dart';
import '../../../../core/presentation/widgets/zen_search_bar.dart';
import '../../../../core/providers.dart';
import '../../../../shared/widgets/bouncing_button.dart';
import '../../../../shared/widgets/global_sliver_app_bar.dart';
import '../../../flashcards/domain/entities/deck.dart';
import '../../../flashcards/presentation/providers/deck_controller.dart';
import '../../../auth/presentation/providers/auth_controller.dart';
import '../../../flashcards/presentation/providers/flashcard_controller.dart';
import 'package:hanzi_master/core/services/haptics_manager.dart';
import '../../../flashcards/presentation/widgets/calligraphy_background.dart';
import '../../../../shared/utils/hero_transition.dart';
import '../../../../shared/widgets/zen_filter_pill.dart';
import '../../data/thematic_decks_data.dart';
import '../../../../core/services/character_lookup_service.dart';
import '../../../../core/services/localized_deck_service.dart';
import '../../../../core/widgets/translated_definition.dart';
import '../widgets/calligraphic_deck_cover.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';
import 'package:hanzi_master/shared/widgets/zen_toast.dart';
import 'package:hanzi_master/shared/widgets/network_notice.dart';
import 'package:hanzi_master/shared/widgets/zen_overlay.dart';

class _HskCollection {
  final int level;
  final String title;
  final String titleHanzi;
  final String cardCount;
  final Color color;
  final List<Color> gradientColors;
  final String watermarkHanzi;
  final String description;
  final List<Map<String, String>> sampleWords;

  const _HskCollection({
    required this.level,
    required this.title,
    required this.titleHanzi,
    required this.cardCount,
    required this.color,
    required this.gradientColors,
    required this.watermarkHanzi,
    required this.description,
    required this.sampleWords,
  });
}

class TomeManagerScreen extends ConsumerStatefulWidget {
  const TomeManagerScreen({super.key});

  @override
  ConsumerState<TomeManagerScreen> createState() => _TomeManagerScreenState();
}

class _TomeManagerScreenState extends ConsumerState<TomeManagerScreen> {
  int? _busyHskLevel;
  String? _busyThematicId;
  String _selectedCategory = 'ALL';
  final TextEditingController _searchController = TextEditingController();

  /// Deck titles, descriptions and word definitions are localized **data**: they
  /// are preloaded once per locale rather than awaited per widget, because the
  /// shelves build a whole row of cards in a single pass.
  String _deckLocale = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final String locale = Localizations.localeOf(context).languageCode;
    if (locale == _deckLocale) return;
    _deckLocale = locale;
    LocalizedDeckService.ensureLoaded(locale).then((_) {
      if (mounted) setState(() {});
    });
  }

  static const List<String> _categoryFilterKeys = [
    'ALL',
    'Official HSK',
    'Culture',
    'Sports',
    'Education',
    'Travel',
    'Business',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_HskCollection> _collections(AppLocalizations l10n) => [
        _HskCollection(
          level: 1,
          title: l10n.foundation,
          titleHanzi: '一级·基础',
          cardCount: l10n.hsk_154_cards,
          color: const Color(0xFF15803D),
          gradientColors: const [Color(0xFF15803D), Color(0xFF052E16)],
          watermarkHanzi: '壹',
          description:
              l10n.hskDescription1,
          sampleWords: const [
            {"hanzi": "你", "pinyin": "nǐ", "definition": "you"},
            {"hanzi": "好", "pinyin": "hǎo", "definition": "good; well"},
            {"hanzi": "谢谢", "pinyin": "xiè xie", "definition": "thank you"},
            {"hanzi": "再见", "pinyin": "zài jiàn", "definition": "goodbye"},
            {"hanzi": "中国", "pinyin": "zhōng guó", "definition": "China"},
            {"hanzi": "朋友", "pinyin": "péng you", "definition": "friend"},
            {"hanzi": "喝茶", "pinyin": "hē chá", "definition": "drink tea"},
            {"hanzi": "高兴", "pinyin": "gāo xìng", "definition": "happy; glad"},
          ],
        ),
        _HskCollection(
          level: 2,
          title: l10n.elementary,
          titleHanzi: '二级·初级',
          cardCount: l10n.hsk_162_cards,
          color: const Color(0xFF0F766E),
          gradientColors: const [Color(0xFF0F766E), Color(0xFF042F2E)],
          watermarkHanzi: '贰',
          description:
              l10n.hskDescription2,
          sampleWords: const [
            {
              "hanzi": "准备",
              "pinyin": "zhǔn bèi",
              "definition": "prepare; get ready"
            },
            {
              "hanzi": "介绍",
              "pinyin": "jiè shào",
              "definition": "introduce; recommend"
            },
            {"hanzi": "时间", "pinyin": "shí jiān", "definition": "time; period"},
            {"hanzi": "帮助", "pinyin": "bāng zhù", "definition": "help; assist"},
            {"hanzi": "希望", "pinyin": "xī wàng", "definition": "hope; wish"},
            {"hanzi": "欢迎", "pinyin": "huān yíng", "definition": "welcome"},
            {"hanzi": "身体", "pinyin": "shēn tǐ", "definition": "body; health"},
            {"hanzi": "跑步", "pinyin": "pǎo bù", "definition": "run; jog"},
          ],
        ),
        _HskCollection(
          level: 3,
          title: l10n.intermediate,
          titleHanzi: '三级·中级',
          cardCount: l10n.hsk_299_cards,
          color: const Color(0xFFB45309),
          gradientColors: const [Color(0xFFB45309), Color(0xFF451A03)],
          watermarkHanzi: '叁',
          description:
              l10n.hskDescription3,
          sampleWords: const [
            {
              "hanzi": "解决",
              "pinyin": "jiě jué",
              "definition": "resolve; solve"
            },
            {
              "hanzi": "影响",
              "pinyin": "yǐng xiǎng",
              "definition": "influence; effect"
            },
            {"hanzi": "提高", "pinyin": "tí gāo", "definition": "improve; raise"},
            {"hanzi": "习惯", "pinyin": "xí guàn", "definition": "habit; custom"},
            {
              "hanzi": "机会",
              "pinyin": "jī huì",
              "definition": "opportunity; chance"
            },
            {
              "hanzi": "选择",
              "pinyin": "xuǎn zé",
              "definition": "choose; choice"
            },
            {
              "hanzi": "努力",
              "pinyin": "nǔ lì",
              "definition": "diligent; hard-working"
            },
            {
              "hanzi": "完成",
              "pinyin": "wán chéng",
              "definition": "complete; finish"
            },
          ],
        ),
        _HskCollection(
          level: 4,
          title: l10n.upperIntermediate,
          titleHanzi: '四级·进阶',
          cardCount: l10n.hsk_602_cards,
          color: const Color(0xFFBE123C),
          gradientColors: const [Color(0xFFBE123C), Color(0xFF4C0519)],
          watermarkHanzi: '肆',
          description:
              l10n.hskDescription4,
          sampleWords: const [
            {
              "hanzi": "坚持",
              "pinyin": "jiān chí",
              "definition": "persist; persevere"
            },
            {
              "hanzi": "甚至",
              "pinyin": "shèn zhì",
              "definition": "even; so much that"
            },
            {
              "hanzi": "交流",
              "pinyin": "jiāo liú",
              "definition": "exchange; communicate"
            },
            {
              "hanzi": "关键",
              "pinyin": "guān jiàn",
              "definition": "crucial; key"
            },
            {
              "hanzi": "态度",
              "pinyin": "tài du",
              "definition": "attitude; demeanor"
            },
            {"hanzi": "经验", "pinyin": "jīng yàn", "definition": "experience"},
            {
              "hanzi": "适应",
              "pinyin": "shì yìng",
              "definition": "adapt; adjust to"
            },
            {
              "hanzi": "根据",
              "pinyin": "gēn jù",
              "definition": "according to; basis"
            },
          ],
        ),
        _HskCollection(
          level: 5,
          title: l10n.advanced,
          titleHanzi: '五级·高级',
          cardCount: l10n.hsk_1300_cards,
          color: const Color(0xFF4338CA),
          gradientColors: const [Color(0xFF4338CA), Color(0xFF1E1B4B)],
          watermarkHanzi: '伍',
          description:
              l10n.hskDescription5,
          sampleWords: const [
            {
              "hanzi": "综合",
              "pinyin": "zōng hé",
              "definition": "comprehensive; synthesize"
            },
            {"hanzi": "逻辑", "pinyin": "luó ji", "definition": "logic"},
            {
              "hanzi": "优势",
              "pinyin": "yōu shì",
              "definition": "advantage; superiority"
            },
            {
              "hanzi": "趋势",
              "pinyin": "qū shì",
              "definition": "trend; tendency"
            },
            {
              "hanzi": "本质",
              "pinyin": "běn zhì",
              "definition": "essence; nature"
            },
            {
              "hanzi": "概念",
              "pinyin": "gài niàn",
              "definition": "concept; notion"
            },
            {
              "hanzi": "比例",
              "pinyin": "bǐ lì",
              "definition": "proportion; scale"
            },
            {
              "hanzi": "把握",
              "pinyin": "bǎ wò",
              "definition": "grasp; hold; certainty"
            },
          ],
        ),
        _HskCollection(
          level: 6,
          title: l10n.mastery,
          titleHanzi: '六级·精通',
          cardCount: l10n.hsk_2500_cards,
          color: const Color(0xFF6D28D9),
          gradientColors: const [Color(0xFF6D28D9), Color(0xFF2E1065)],
          watermarkHanzi: '陆',
          description:
              l10n.hskDescription6,
          sampleWords: const [
            {
              "hanzi": "领悟",
              "pinyin": "lǐng wù",
              "definition": "comprehend; grasp"
            },
            {
              "hanzi": "造诣",
              "pinyin": "zào yì",
              "definition": "scholarly attainment"
            },
            {
              "hanzi": "渊博",
              "pinyin": "yuān bó",
              "definition": "broad and profound"
            },
            {
              "hanzi": "博大精深",
              "pinyin": "bó dà jīng shēn",
              "definition": "wide-ranging and profound"
            },
            {
              "hanzi": "琢磨",
              "pinyin": "zhuó mó",
              "definition": "ponder; deliberate"
            },
            {
              "hanzi": "精益求精",
              "pinyin": "jīng yì qiú jīng",
              "definition": "strive for perfection"
            },
            {
              "hanzi": "千方百计",
              "pinyin": "qiān fāng bǎi jì",
              "definition": "by every possible means"
            },
            {
              "hanzi": "锲而不舍",
              "pinyin": "qiè ér bù shě",
              "definition": "persevere relentlessly"
            },
          ],
        ),
      ];

  /// Human label for a filter key.
  ///
  /// The keys themselves stay English (and stable) because they are also the
  /// comparison values used for filtering; only what the pill *shows* is
  /// translated. See `_categoryFilterKeys`.
  String _categoryLabel(AppLocalizations l10n, String key) {
    switch (key) {
      case 'ALL':
        return l10n.allLabel;
      case 'Official HSK':
        return l10n.libraryFilterOfficialHsk;
      case 'Culture':
        return l10n.libraryFilterCulture;
      case 'Sports':
        return l10n.libraryFilterSports;
      case 'Education':
        return l10n.libraryFilterEducation;
      case 'Travel':
        return l10n.libraryFilterTravel;
      case 'Business':
        return l10n.libraryFilterBusiness;
      default:
        return key;
    }
  }

  bool _isLevelInstalled(int level, List<Deck> decks) =>
      decks.any((deck) => deck.id == 'hsk$level');

  bool _isThematicInstalled(String thematicId, List<Deck> decks) =>
      decks.any((deck) => deck.id == thematicId);

  Future<void> _installCollection(_HskCollection collection) async {
    if (_busyHskLevel != null || _busyThematicId != null) return;
    setState(() => _busyHskLevel = collection.level);

    try {
      HapticsManager.medium();
      final importResult = await ref
          .read(flashcardControllerProvider.notifier)
          .importLevel(collection.level);
      importResult.fold(
        (error) => throw StateError(error),
        (_) {},
      );

      final deckResult = await ref
          .read(deckRepositoryProvider)
          .ensureHSKDeckExists(collection.level);
      deckResult.fold(
        (error) => throw StateError(error),
        (_) {},
      );
      ref.invalidate(deckControllerProvider);
      HapticsManager.success();

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        _showMessage(
          '${l10n.successfullyInstalled} ${l10n.hskLevel(collection.level.toString())}',
          tone: ZenToastTone.success,
        );
      }
    } catch (error) {
      debugPrint('Installation Error: $error');
      if (mounted) {
        // Installing pulls the shelf down over the network, so a lost
        // connection is the likeliest cause and the one worth naming.
        if (!NetworkNotice.showIfOffline(context, error)) {
          _showMessage(
            AppLocalizations.of(context)!.failedToDownload,
            tone: ZenToastTone.error,
          );
        }
      }
    } finally {
      if (mounted) setState(() => _busyHskLevel = null);
    }
  }

  Future<void> _uninstallCollection(_HskCollection collection) async {
    if (_busyHskLevel != null || _busyThematicId != null) return;
    final l10n = AppLocalizations.of(context)!;
    final levelName = l10n.hskLevel(collection.level.toString());
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor:
            isDark ? const Color(0xFF1E1E24) : const Color(0xFFFDFCF0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('${l10n.remove} $levelName?'),
        content: Text(l10n.removeCharactersWarning),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.uninstall),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() => _busyHskLevel = collection.level);
    try {
      HapticsManager.light();
      final uninstallResult = await ref
          .read(flashcardControllerProvider.notifier)
          .uninstallLevel(collection.level);
      uninstallResult.fold(
        (error) => throw StateError(error),
        (_) {},
      );
      await ref
          .read(deckRepositoryProvider)
          .deleteDeck('hsk${collection.level}');
      ref.invalidate(deckControllerProvider);

      if (mounted) {
        _showMessage('${l10n.removedLibrary} $levelName.',
            tone: ZenToastTone.success);
      }
    } catch (error) {
      debugPrint('Uninstallation Error: $error');
      if (mounted) {
        _showMessage(l10n.failedToDownload, tone: ZenToastTone.error);
      }
    } finally {
      if (mounted) setState(() => _busyHskLevel = null);
    }
  }

  Future<void> _installThematic(ThematicDeckDefinition thematic) async {
    if (_busyHskLevel != null || _busyThematicId != null) return;
    setState(() => _busyThematicId = thematic.id);

    try {
      HapticsManager.medium();
      final result = await ref
          .read(flashcardControllerProvider.notifier)
          .importThematicDeck(thematic.id);
      result.fold(
        (error) => throw StateError(error),
        (_) {},
      );
      ref.invalidate(deckControllerProvider);
      HapticsManager.success();

      if (mounted) {
        _showMessage(
            AppLocalizations.of(context)!.shelfAddedThematic(LocalizedDeckService.deckTitle(deckId: thematic.id, fallbackEn: thematic.title)),
            tone: ZenToastTone.success);
      }
    } catch (error) {
      debugPrint('Thematic Install Error: $error');
      if (mounted) {
        if (!NetworkNotice.showIfOffline(context, error)) {
          _showMessage(
            AppLocalizations.of(context)!.failedToDownload,
            tone: ZenToastTone.error,
          );
        }
      }
    } finally {
      if (mounted) setState(() => _busyThematicId = null);
    }
  }

  Future<void> _uninstallThematic(ThematicDeckDefinition thematic) async {
    if (_busyHskLevel != null || _busyThematicId != null) return;
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor:
            isDark ? const Color(0xFF1E1E24) : const Color(0xFFFDFCF0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('${l10n.remove} ${LocalizedDeckService.deckTitle(deckId: thematic.id, fallbackEn: thematic.title)}?'),
        content: Text(l10n.removeCharactersWarning),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.uninstall),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() => _busyThematicId = thematic.id);
    try {
      HapticsManager.light();
      final result = await ref
          .read(flashcardControllerProvider.notifier)
          .uninstallThematicDeck(thematic.id);
      result.fold(
        (error) => throw StateError(error),
        (_) {},
      );
      ref.invalidate(deckControllerProvider);

      if (mounted) {
        _showMessage(AppLocalizations.of(context)!.shelfRemovedThematic(LocalizedDeckService.deckTitle(deckId: thematic.id, fallbackEn: thematic.title)),
            tone: ZenToastTone.success);
      }
    } catch (error) {
      debugPrint('Thematic Uninstall Error: $error');
      if (mounted) {
        _showMessage(l10n.failedToDownload, tone: ZenToastTone.error);
      }
    } finally {
      if (mounted) setState(() => _busyThematicId = null);
    }
  }

  void _showMessage(String message, {ZenToastTone tone = ZenToastTone.info}) {
    // Root-overlay toast: a download confirmation stays legible even while a
    // sheet is closing over it.
    ZenToast.show(context, message, tone: tone);
  }

  void _showDeckPreviewSheet({
    required BuildContext context,
    required String title,
    required String titleHanzi,
    required String subtitle,
    required String description,
    required String watermarkHanzi,
    required List<Color> gradientColors,
    required String badgeText,
    required Color color,
    required List<Map<String, String>> sampleWords,
    required bool isInstalled,
    required bool isBusy,
    required VoidCallback onInstall,
    required VoidCallback onUninstall,
    String? heroId,
  }) async {
    HapticsManager.light();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Word meanings come from storage (`dictionary.db`), in the reader's own
    // language, instead of being carried as hardcoded English in the deck data.
    // Only the words actually rendered are looked up.
    //
    // The lookup answers in two shapes and the chip has to handle both. When
    // `definition_<locale>` is filled the database has already given the reader
    // their own language and the gloss is printed verbatim. When it is not —
    // 15,555 rows hold an empty string rather than NULL, and CC-CEDICT has no
    // entry at all for 33 of the headwords these decks teach (弓步, 刀法, 棍术,
    // 武当, 微信支付, 远程办公 …) — the row's English, or the deck's own English,
    // is only a *source*: the gloss goes through the same `TranslatedDefinition`
    // every other definition surface uses, which is what stops a French reader
    // being shown "bow stance" and "Wudang Mountain martial lineage".
    Map<String, CharacterInfo> lookups = const <String, CharacterInfo>{};
    try {
      final localeCode = Localizations.localeOf(context).languageCode;
      final infos = await ref.read(characterLookupServiceProvider).lookupAll(
            sampleWords
                .take(12)
                .map((word) => word['hanzi'] ?? '')
                .where((hanzi) => hanzi.isNotEmpty),
            targetLanguage: localeCode,
          );
      lookups = <String, CharacterInfo>{
        for (final info in infos) info.hanzi: info,
      };
    } catch (_) {
      lookups = const <String, CharacterInfo>{};
    }
    if (!context.mounted) return;
    final bgColor = isDark ? const Color(0xFF1E1E24) : const Color(0xFFFDFCF0);
    final cardBg = isDark ? const Color(0xFF28282E) : Colors.white;
    final primaryText = isDark ? Colors.white : const Color(0xFF1A1A1B);

    zenSheet(
      context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.85,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border.all(
            color: isDark
                ? Colors.white12
                : const Color(0xFFD4AF37).withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag Handle
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white24 : Colors.black12,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Banner with Calligraphic Deck Cover
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeroTransition.wrap(
                          context: sheetContext,
                          tag: heroId == null
                              ? '__nohero__'
                              : HeroTransition.heroTag('deck_shelf', heroId),
                          enabled: heroId != null,
                          child: CalligraphicDeckCover(
                            title: title,
                            titleHanzi: titleHanzi,
                            watermarkHanzi: watermarkHanzi,
                            gradientColors: gradientColors,
                            badgeText: badgeText,
                            isInstalled: isInstalled,
                            width: 110,
                            height: 155,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 3),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: color.withValues(alpha: 0.3),
                                    width: 0.8,
                                  ),
                                ),
                                child: Text(
                                  titleHanzi,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: color,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryText,
                                  letterSpacing: 0.3,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                subtitle,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      isDark ? Colors.white60 : Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isInstalled
                                      ? const Color(0xFF10B981)
                                          .withValues(alpha: 0.12)
                                      : Colors.amber.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      isInstalled
                                          ? Icons.check_circle_rounded
                                          : Icons.library_add_rounded,
                                      size: 13,
                                      color: isInstalled
                                          ? const Color(0xFF10B981)
                                          : Colors.amber.shade800,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      isInstalled
                                          ? AppLocalizations.of(context)!.shelfInstalled
                                          : AppLocalizations.of(context)!.shelfAvailable,
                                      style: TextStyle(
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.bold,
                                        color: isInstalled
                                            ? const Color(0xFF10B981)
                                            : Colors.amber.shade800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
const SizedBox(height: 16),
                    // Description
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.45,
                        color:
                            isDark ? Colors.white70 : const Color(0xFF374151),
                      ),
                    ),
const SizedBox(height: 20),
                    // Sample Vocabulary Section
                    Row(
                      children: [
                        Icon(
                          Icons.menu_book_rounded,
                          size: 16,
                          color: isDark
                              ? Colors.amber.shade400
                              : const Color(0xFF8B0000),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          AppLocalizations.of(context)!.shelfSampleVocabulary(sampleWords.length),
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                            color: primaryText,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
// Vocabulary Cards
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: sampleWords.take(12).map((word) {
                        // The gloss the database served, if it served one.
                        final CharacterInfo? known = lookups[word['hanzi']];
                        final TextStyle glossStyle = TextStyle(
                          fontSize: 10.5,
                          color: isDark ? Colors.white60 : Colors.black54,
                        );
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 7),
                          decoration: BoxDecoration(
                            color: cardBg,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white10
                                  : Colors.black.withValues(alpha: 0.07),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    word['hanzi'] ?? '',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: primaryText,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    word['pinyin'] ?? '',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: color,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              // Database local definition first, and only what
                              // the database cannot answer for goes to the
                              // translator. Passing the language the database
                              // used is what makes that distinction: a French
                              // row prints as-is, an English row (or a word with
                              // no row at all) is translated like every other
                              // definition in the app instead of being printed
                              // at a reader who asked for French.
                              TranslatedDefinition(
                                definition:
                                    known?.definition ?? word['definition'] ?? '',
                                definitionLanguage: known?.definitionLanguage,
                                hanzi: word['hanzi'],
                                originalStyle: glossStyle,
                                translationStyle: glossStyle,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
const SizedBox(height: 28),
// Primary Action Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: isBusy
                          ? const Center(child: ZenLoader())
                          : isInstalled
                              ? OutlinedButton.icon(
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: const Color(0xFFDC2626),
                                    side: const BorderSide(
                                        color: Color(0xFFDC2626), width: 1.2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(sheetContext);
                                    onUninstall();
                                  },
                                  icon: const Icon(Icons.delete_outline_rounded,
                                      size: 18),
                                  label: Text(
                                    AppLocalizations.of(context)!.shelfRemoveFromBookshelf,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : FilledButton.icon(
                                  style: FilledButton.styleFrom(
                                    backgroundColor: color,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    elevation: 2,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(sheetContext);
                                    onInstall();
                                  },
                                  icon: const Icon(Icons.download_rounded,
                                      size: 18),
                                  label: Text(
                                    AppLocalizations.of(context)!.shelfDownloadInstall,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // One account's library is a single deck, so the catalogue is not hers to browse:
    // six HSK tiers and twenty curated shelves would be noise around the deck she has.
    // The gate is the first line of `build` so that for everyone else this screen is
    // exactly what it was.
    if (HerAccount.isHer(ref.watch(currentUserProvider)?.email)) {
      return const HerDeckLibrary();
    }

    final l10n = AppLocalizations.of(context)!;
    final collections = _collections(l10n);
    const thematicDecks = ThematicDecksData.collections;
    final asyncDecks = ref.watch(deckControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? Colors.white : const Color(0xFF1A1A1B);
    final cardBg = isDark ? const Color(0xFF1E1E24) : Colors.white;

    return Scaffold(
      body: CalligraphyBackground(
        child: asyncDecks.when(
          data: (decks) {
            final query = _searchController.text.trim().toLowerCase();

            // Filter HSK
            final filteredHsk = collections.where((c) {
              if (_selectedCategory != 'ALL' &&
                  _selectedCategory != 'Official HSK') {
                return false;
              }
              if (query.isEmpty) return true;
              return c.title.toLowerCase().contains(query) ||
                  c.titleHanzi.toLowerCase().contains(query) ||
                  c.description.toLowerCase().contains(query) ||
                  c.cardCount.toLowerCase().contains(query) ||
                  c.sampleWords.any((w) =>
                      (w['hanzi']?.toLowerCase().contains(query) ?? false) ||
                      (w['pinyin']?.toLowerCase().contains(query) ?? false) ||
                      (w['definition']?.toLowerCase().contains(query) ??
                          false));
            }).toList();

            // Filter Thematic by category and search
            final filteredThematic = thematicDecks.where((t) {
              if (_selectedCategory != 'ALL' &&
                  _selectedCategory != t.category) {
                return false;
              }
              if (query.isEmpty) return true;
              return t.title.toLowerCase().contains(query) ||
                  t.titleHanzi.toLowerCase().contains(query) ||
                  t.description.toLowerCase().contains(query) ||
                  t.category.toLowerCase().contains(query) ||
                  t.vocabulary.any((w) =>
                      (w['hanzi']?.toLowerCase().contains(query) ?? false) ||
                      (w['pinyin']?.toLowerCase().contains(query) ?? false) ||
                      (w['definition']?.toLowerCase().contains(query) ??
                          false));
            }).toList();

            // Group thematic by categories
            final cultureDecks =
                filteredThematic.where((t) => t.category == 'Culture').toList();
            final sportsDecks =
                filteredThematic.where((t) => t.category == 'Sports').toList();
            final educationDecks = filteredThematic
                .where((t) => t.category == 'Education')
                .toList();
            final travelDecks =
                filteredThematic.where((t) => t.category == 'Travel').toList();
            final businessDecks = filteredThematic
                .where((t) => t.category == 'Business')
                .toList();

            final bool hasAnyResults = filteredHsk.isNotEmpty ||
                cultureDecks.isNotEmpty ||
                sportsDecks.isNotEmpty ||
                educationDecks.isNotEmpty ||
                travelDecks.isNotEmpty ||
                businessDecks.isNotEmpty;

            return ZenFadeIn(
                child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                GlobalSliverAppBar(
                  title: AppLocalizations.of(context)!.deckLibraryTitle,
                  subtitle: AppLocalizations.of(context)!.deckLibrarySubtitle,
                  showBackButton: true,
                ),
// Top Controls: Search Bar, Status Card, and Category Filter Pills
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Zen Search Bar
                        ZenSearchBar(
                          controller: _searchController,
                          hintText: AppLocalizations.of(context)!.librarySearchHint,
                          onChanged: (_) => setState(() {}),
                        ),
const SizedBox(height: 12),
// Horizontal Category Filter Pills (like BookCatalogScreen)
                        SizedBox(
                          height: 34,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: _categoryFilterKeys.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              final catKey = _categoryFilterKeys[index];
                              final isSelected = _selectedCategory == catKey;
                              return ZenFilterPill(
                                label: _categoryLabel(AppLocalizations.of(context)!, catKey),
                                isSelected: isSelected,
                                isDark: isDark,
                                background: cardBg,
                                onTap: () =>
                                    setState(() => _selectedCategory = catKey),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  ),
                ),
if (!hasAnyResults)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 48,
                            color: isDark ? Colors.white30 : Colors.black26,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            AppLocalizations.of(context)!.libraryNoMatch(query),
                            style: TextStyle(
                              color: isDark ? Colors.white54 : Colors.black54,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextButton(
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _selectedCategory = 'ALL');
                            },
                            child: Text(AppLocalizations.of(context)!.libraryResetFilters),
                          ),
                        ],
                      ),
                    ),
                  )
                else ...[
                  // ==========================================
                  // 1. OFFICIAL HSK SHELF ROW
                  // ==========================================
                  if (filteredHsk.isNotEmpty)
                    SliverToBoxAdapter(
                      child: _buildCategoryShelf(
                        title: l10n.shelfHskTitle,
                        titleHanzi: '官方HSK分级',
                        subtitle:
                            l10n.shelfHskSubtitle,
                        icon: Icons.workspace_premium_rounded,
                        accentColor: const Color(0xFF0F766E),
                        itemCount: filteredHsk.length,
                        isDark: isDark,
                        cardBg: cardBg,
                        primaryText: primaryText,
                        itemBuilder: (context, index) {
                          final collection = filteredHsk[index];
                          final isInstalled =
                              _isLevelInstalled(collection.level, decks);
                          final isBusy = _busyHskLevel == collection.level;

                          return _buildShelfCard(
                            heroId: 'hsk-${collection.level}',
                            title: l10n.hskLevel(collection.level.toString()),
                            titleHanzi: collection.titleHanzi,
                            subtitle:
                                '${collection.title} · ${collection.cardCount}',
                            description: collection.description,
                            watermarkHanzi: collection.watermarkHanzi,
                            gradientColors: collection.gradientColors,
                            badgeText: l10n.hskLevel(collection.level.toString()),
                            accentColor: collection.color,
                            isInstalled: isInstalled,
                            isBusy: isBusy,
                            actionsDisabled: _busyHskLevel != null ||
                                _busyThematicId != null,
                            isDark: isDark,
                            cardBg: cardBg,
                            primaryText: primaryText,
                            onTapCard: () => _showDeckPreviewSheet(
                              context: context,
                              heroId: 'hsk-${collection.level}',
                              title: l10n.hskLevel(collection.level.toString()),
                              titleHanzi: collection.titleHanzi,
                              subtitle:
                                  '${collection.title} · ${collection.cardCount}',
                              description: collection.description,
                              watermarkHanzi: collection.watermarkHanzi,
                              gradientColors: collection.gradientColors,
                              badgeText: l10n.hskLevel(collection.level.toString()),
                              color: collection.color,
                              sampleWords: collection.sampleWords,
                              isInstalled: isInstalled,
                              isBusy: isBusy,
                              onInstall: () => _installCollection(collection),
                              onUninstall: () =>
                                  _uninstallCollection(collection),
                            ),
                            onInstall: () => _installCollection(collection),
                            onUninstall: () => _uninstallCollection(collection),
                          );
                        },
                      ),
                    ),
// ==========================================
                  // 2. CULTURE & HERITAGE SHELF ROW
                  // ==========================================
                  if (cultureDecks.isNotEmpty)
                    SliverToBoxAdapter(
                      child: _buildThematicShelf(
                        title: l10n.shelfCultureTitle,
                        titleHanzi: '文化与传统',
                        subtitle:
                            l10n.shelfCultureSubtitle,
                        icon: Icons.palette_rounded,
                        accentColor: const Color(0xFFB91C1C),
                        decks: cultureDecks,
                        installedDecks: decks,
                        isDark: isDark,
                        cardBg: cardBg,
                        primaryText: primaryText,
                      ),
                    ),
// ==========================================
                  // 3. SPORTS & MARTIAL ARTS SHELF ROW
                  // ==========================================
                  if (sportsDecks.isNotEmpty)
                    SliverToBoxAdapter(
                      child: _buildThematicShelf(
                        title: l10n.shelfSportsTitle,
                        titleHanzi: '运动与竞技',
                        subtitle:
                            l10n.shelfSportsSubtitle,
                        icon: Icons.sports_martial_arts_rounded,
                        accentColor: const Color(0xFF0F766E),
                        decks: sportsDecks,
                        installedDecks: decks,
                        isDark: isDark,
                        cardBg: cardBg,
                        primaryText: primaryText,
                      ),
                    ),
// ==========================================
                  // 4. EDUCATION & ACADEMICS SHELF ROW
                  // ==========================================
                  if (educationDecks.isNotEmpty)
                    SliverToBoxAdapter(
                      child: _buildThematicShelf(
                        title: l10n.shelfEducationTitle,
                        titleHanzi: '教育与学术',
                        subtitle:
                            l10n.shelfEducationSubtitle,
                        icon: Icons.school_rounded,
                        accentColor: const Color(0xFF4338CA),
                        decks: educationDecks,
                        installedDecks: decks,
                        isDark: isDark,
                        cardBg: cardBg,
                        primaryText: primaryText,
                      ),
                    ),
// ==========================================
                  // 5. TRAVEL & CITY LIFE SHELF ROW
                  // ==========================================
                  if (travelDecks.isNotEmpty)
                    SliverToBoxAdapter(
                      child: _buildThematicShelf(
                        title: l10n.shelfTravelTitle,
                        titleHanzi: '旅行与出行',
                        subtitle:
                            l10n.shelfTravelSubtitle,
                        icon: Icons.flight_takeoff_rounded,
                        accentColor: const Color(0xFF0284C7),
                        decks: travelDecks,
                        installedDecks: decks,
                        isDark: isDark,
                        cardBg: cardBg,
                        primaryText: primaryText,
                      ),
                    ),
// ==========================================
                  // 6. BUSINESS & PROFESSIONAL SHELF ROW
                  // ==========================================
                  if (businessDecks.isNotEmpty)
                    SliverToBoxAdapter(
                      child: _buildThematicShelf(
                        title: l10n.shelfBusinessTitle,
                        titleHanzi: '商务与职场',
                        subtitle:
                            l10n.shelfBusinessSubtitle,
                        icon: Icons.business_center_rounded,
                        accentColor: const Color(0xFFD97706),
                        decks: businessDecks,
                        installedDecks: decks,
                        isDark: isDark,
                        cardBg: cardBg,
                        primaryText: primaryText,
                      ),
                    ),
const SliverToBoxAdapter(
                    child: SizedBox(height: 36),
                  ),
                ],
              ],
            ));
          },
          loading: () => const Center(child: ZenLoader()),
          error: (error, stackTrace) => _LoadError(
            message: l10n.failedToLoadCollections,
            retryLabel: l10n.retry,
            onRetry: () {
              ref.invalidate(flashcardControllerProvider);
              ref.invalidate(deckControllerProvider);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildThematicShelf({
    required String title,
    required String titleHanzi,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
    required List<ThematicDeckDefinition> decks,
    required List<Deck> installedDecks,
    required bool isDark,
    required Color cardBg,
    required Color primaryText,
  }) {
    return _buildCategoryShelf(
      title: title,
      titleHanzi: titleHanzi,
      subtitle: subtitle,
      icon: icon,
      accentColor: accentColor,
      itemCount: decks.length,
      isDark: isDark,
      cardBg: cardBg,
      primaryText: primaryText,
      itemBuilder: (context, index) {
        final thematic = decks[index];
        final isInstalled = _isThematicInstalled(thematic.id, installedDecks);
        final isBusy = _busyThematicId == thematic.id;

        return _buildShelfCard(
          heroId: 'thematic-${thematic.id}',
          title: LocalizedDeckService.deckTitle(deckId: thematic.id, fallbackEn: thematic.title),
          titleHanzi: thematic.titleHanzi,
          subtitle:
              '${thematic.vocabulary.length} words · ${thematic.category}',
          description: LocalizedDeckService.deckDescription(deckId: thematic.id, fallbackEn: thematic.description),
          watermarkHanzi: thematic.watermarkHanzi,
          gradientColors: thematic.gradientColors,
          badgeText: '${thematic.vocabulary.length} 词',
          accentColor: thematic.color,
          isInstalled: isInstalled,
          isBusy: isBusy,
          actionsDisabled: _busyHskLevel != null || _busyThematicId != null,
          isDark: isDark,
          cardBg: cardBg,
          primaryText: primaryText,
          onTapCard: () => _showDeckPreviewSheet(
            context: context,
            heroId: 'thematic-${thematic.id}',
            title: LocalizedDeckService.deckTitle(deckId: thematic.id, fallbackEn: thematic.title),
            titleHanzi: thematic.titleHanzi,
            subtitle:
                '${thematic.vocabulary.length} words · ${thematic.category}',
            description: LocalizedDeckService.deckDescription(deckId: thematic.id, fallbackEn: thematic.description),
            watermarkHanzi: thematic.watermarkHanzi,
            gradientColors: thematic.gradientColors,
            badgeText: '${thematic.vocabulary.length} 词',
            color: thematic.color,
            sampleWords: thematic.vocabulary,
            isInstalled: isInstalled,
            isBusy: isBusy,
            onInstall: () => _installThematic(thematic),
            onUninstall: () => _uninstallThematic(thematic),
          ),
          onInstall: () => _installThematic(thematic),
          onUninstall: () => _uninstallThematic(thematic),
        );
      },
    );
  }

  Widget _buildCategoryShelf({
    required String title,
    required String titleHanzi,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
    required int itemCount,
    required bool isDark,
    required Color cardBg,
    required Color primaryText,
    required Widget Function(BuildContext, int) itemBuilder,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shelf Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 16, color: accentColor),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: primaryText,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            titleHanzi,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: accentColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? Colors.white54 : Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white10
                        : Colors.black.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.shelfDeckCount(itemCount),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white60 : Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
// Horizontal Shelf Row
          SizedBox(
            height: 255,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: itemCount,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: itemBuilder,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShelfCard({
    required String title,
    required String titleHanzi,
    required String subtitle,
    required String description,
    required String watermarkHanzi,
    required List<Color> gradientColors,
    required String badgeText,
    required Color accentColor,
    required bool isInstalled,
    required bool isBusy,
    required bool actionsDisabled,
    required bool isDark,
    required Color cardBg,
    required Color primaryText,
    required VoidCallback onTapCard,
    required VoidCallback onInstall,
    required VoidCallback onUninstall,
    String? heroId,
  }) {
    return BouncingButton(
      scaleFactor: 0.96,
      onPressed: onTapCard,
      child: Container(
        width: 172,
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isInstalled
                ? accentColor.withValues(alpha: 0.5)
                : (isDark
                    ? Colors.white12
                    : Colors.black.withValues(alpha: 0.07)),
            width: isInstalled ? 1.4 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.28 : 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Cover (height 148)
            HeroTransition.wrap(
              context: context,
              tag: heroId == null
                  ? '__nohero__'
                  : HeroTransition.heroTag('deck_shelf', heroId),
              enabled: heroId != null,
              child: CalligraphicDeckCover(
                title: title,
                titleHanzi: titleHanzi,
                watermarkHanzi: watermarkHanzi,
                gradientColors: gradientColors,
                badgeText: badgeText,
                badgeColor: accentColor,
                isInstalled: isInstalled,
                width: double.infinity,
                height: 148,
              ),
            ),
// Bottom Text & Action Info (height 105)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: primaryText,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            color: primaryText.withValues(alpha: 0.65),
                            height: 1.15,
                          ),
                        ),
                      ],
                    ),
// Action Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Flexible: the word-count badge yields width to the
                        // install/delete action instead of overflowing the row.
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              color: accentColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              badgeText,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.bold,
                                color: accentColor,
                              ),
                            ),
                          ),
                        ),
// Action Button (Install / Delete)
                        if (isBusy)
                          const SizedBox.square(
                            dimension: 22,
                            child: Padding(
                              padding: EdgeInsets.all(3),
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        else if (isInstalled)
                          GestureDetector(
                            onTap: actionsDisabled ? null : onUninstall,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.delete_outline_rounded,
                                size: 16,
                                color: Color(0xFFDC2626),
                              ),
                            ),
                          )
                        else
                          GestureDetector(
                            onTap: actionsDisabled ? null : onInstall,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: accentColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: accentColor.withValues(alpha: 0.35),
                                    blurRadius: 4,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.download_rounded,
                                      size: 12, color: Colors.white),
                                  const SizedBox(width: 3),
                                  Text(
                                    AppLocalizations.of(context)!.shelfGetButton,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadError extends StatelessWidget {
  final String message;
  final String retryLabel;
  final VoidCallback onRetry;

  const _LoadError({
    required this.message,
    required this.retryLabel,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_off_outlined,
              size: 36,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            TextButton(onPressed: onRetry, child: Text(retryLabel)),
          ],
        ),
      ),
    );
  }
}
