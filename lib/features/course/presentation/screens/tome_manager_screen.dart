import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

import '../../../flashcards/domain/entities/deck.dart';
import '../../../flashcards/presentation/providers/flashcard_controller.dart';
import '../../../flashcards/presentation/providers/deck_controller.dart';
import '../../../flashcards/presentation/utils/haptics_manager.dart';
import '../../../flashcards/presentation/widgets/calligraphy_background.dart';
import '../../../../core/providers.dart';
import '../../../../shared/widgets/global_sliver_app_bar.dart';

class _LevelMeta {
  final String label;
  final String chineseLabel;
  final String numeral;
  final int count;
  final List<String> sampleChars;
  final Color primaryColor;
  final Color secondaryColor;

  const _LevelMeta({
    required this.label,
    required this.chineseLabel,
    required this.numeral,
    required this.count,
    required this.sampleChars,
    required this.primaryColor,
    required this.secondaryColor,
  });
}

class TomeManagerScreen extends ConsumerStatefulWidget {
  const TomeManagerScreen({super.key});

  @override
  ConsumerState<TomeManagerScreen> createState() => _TomeManagerScreenState();
}

class _TomeManagerScreenState extends ConsumerState<TomeManagerScreen> {
  int? _selectedLevelFilter;

  static const Map<int, _LevelMeta> _levelData = {
    1: _LevelMeta(
      label: 'Foundation',
      chineseLabel: '基础',
      numeral: '一',
      count: 154,
      sampleChars: ['你', '好', '我', '是', '爱', '家'],
      primaryColor: Color(0xFF15803D), // Emerald Jade
      secondaryColor: Color(0xFF22C55E),
    ),
    2: _LevelMeta(
      label: 'Elementary',
      chineseLabel: '初级',
      numeral: '二',
      count: 162,
      sampleChars: ['起', '走', '看', '听', '懂', '远'],
      primaryColor: Color(0xFF0F766E), // Deep Teal
      secondaryColor: Color(0xFF14B8A6),
    ),
    3: _LevelMeta(
      label: 'Intermediate',
      chineseLabel: '中级',
      numeral: '三',
      count: 299,
      sampleChars: ['经', '选', '帮', '容', '极', '愿'],
      primaryColor: Color(0xFFB45309), // Warm Amber Ochre
      secondaryColor: Color(0xFFF59E0B),
    ),
    4: _LevelMeta(
      label: 'Upper Int.',
      chineseLabel: '中高',
      numeral: '四',
      count: 602,
      sampleChars: ['境', '质', '概', '符', '辨', '释'],
      primaryColor: Color(0xFFBE123C), // Vermilion Crimson
      secondaryColor: Color(0xFFF43F5E),
    ),
    5: _LevelMeta(
      label: 'Advanced',
      chineseLabel: '高级',
      numeral: '五',
      count: 1300,
      sampleChars: ['辩', '哲', '律', '范', '筹', '策'],
      primaryColor: Color(0xFF4338CA), // Deep Indigo
      secondaryColor: Color(0xFF6366F1),
    ),
    6: _LevelMeta(
      label: 'Mastery',
      chineseLabel: '精通',
      numeral: '六',
      count: 2500,
      sampleChars: ['渊', '邃', '博', '浩', '瀚', '粹'],
      primaryColor: Color(0xFF6D28D9), // Imperial Violet
      secondaryColor: Color(0xFFA855F7),
    ),
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final asyncDecks = ref.watch(deckControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final inkColor = isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);

    final List<Map<String, dynamic>> catalog = [
      {'id': 'hsk1', 'title': 'HSK 1: Foundation', 'cards': '154 cards', 'level': 1},
      {'id': 'hsk2', 'title': 'HSK 2: Elementary', 'cards': '162 cards', 'level': 2},
      {'id': 'hsk3', 'title': 'HSK 3: Intermediate', 'cards': '299 cards', 'level': 3},
      {'id': 'hsk4', 'title': 'HSK 4: Upper Int.', 'cards': '602 cards', 'level': 4},
      {'id': 'hsk5', 'title': 'HSK 5: Advanced', 'cards': '1300 cards', 'level': 5},
      {'id': 'hsk6', 'title': 'HSK 6: Mastery', 'cards': '2500 cards', 'level': 6},
    ];

    bool isLevelInstalled(int level, List<Deck> decks) =>
        decks.any((d) => d.id == 'hsk$level');

    Future<void> installTome(Map<String, dynamic> tome) async {
      try {
        HapticsManager.medium();
        await ref.read(flashcardControllerProvider.notifier).importLevel(tome['level'] as int);
        final flashcardState = ref.read(flashcardControllerProvider);
        if (flashcardState.hasError) throw Exception(flashcardState.error);
        await ref.read(deckRepositoryProvider).ensureHSKDeckExists(tome['level'] as int);
        ref.invalidate(deckControllerProvider);
        HapticsManager.success();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${l10n?.successfullyInstalled ?? 'Installed'} ${tome['title']}"),
              backgroundColor: const Color(0xFF1A1A1B),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
      } catch (e) {
        debugPrint("Installation Error: $e");
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n?.failedToDownload ?? "Failed to download.")),
          );
        }
      }
    }

    Future<void> uninstallTome(Map<String, dynamic> tome) async {
      final bool? confirm = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: isDark ? const Color(0xFF1E1E24) : const Color(0xFFFDFCF0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            "${l10n?.rescindTitle ?? 'Remove'} ${tome['title']}?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF1A1A1B),
            ),
          ),
          content: Text(
            l10n?.removeCharactersWarning ??
                "This will remove these characters from your library and reset your mastery progress.",
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.black87,
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l10n?.cancel ?? "Cancel", style: const TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(l10n?.uninstall ?? "Remove"),
            ),
          ],
        ),
      );
      if (confirm != true) return;
      try {
        HapticsManager.light();
        await ref.read(flashcardControllerProvider.notifier).uninstallLevel(tome['level'] as int);
        await ref.read(deckRepositoryProvider).deleteDeck('hsk${tome['level']}');
        ref.invalidate(deckControllerProvider);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${l10n?.removedLibrary ?? 'Removed'} ${tome['title']}."),
              backgroundColor: const Color(0xFF1A1A1B),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
      } catch (e) {
        debugPrint("Uninstallation Error: $e");
      }
    }

    return Scaffold(
      body: CalligraphyBackground(
        child: asyncDecks.when(
          data: (decks) {
            final installedCount = catalog.where((t) => isLevelInstalled(t['level'] as int, decks)).length;
            final totalInstalledCards = catalog
                .where((t) => isLevelInstalled(t['level'] as int, decks))
                .fold<int>(0, (sum, t) => sum + _levelData[t['level']]!.count);

            final displayCatalog = _selectedLevelFilter == null
                ? catalog
                : catalog.where((t) => t['level'] == _selectedLevelFilter).toList();

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                const GlobalSliverAppBar(
                  title: "HSK Collections",
                  subtitle: "Official standard vocabulary tiers",
                  showBackButton: true,
                ),
                
                // Summary Stats Banner
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E212B) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark ? Colors.white12 : const Color(0xFFE2E0D4),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: isDark
                                    ? [const Color(0xFF374151), const Color(0xFF1F2937)]
                                    : [const Color(0xFFF3EFE0), const Color(0xFFE5DECC)],
                              ),
                              border: Border.all(
                                color: isDark ? Colors.white24 : const Color(0xFFC4B99D),
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "字",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? const Color(0xFFFFD54F) : const Color(0xFF8C6B1C),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$installedCount of 6 Collections Active",
                                  style: TextStyle(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "$totalInstalledCards total characters available in library",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark ? Colors.white60 : Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: installedCount > 0
                                  ? const Color(0xFF10B981).withValues(alpha: 0.15)
                                  : (isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05)),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: installedCount > 0
                                    ? const Color(0xFF10B981).withValues(alpha: 0.4)
                                    : Colors.transparent,
                              ),
                            ),
                            child: Text(
                              installedCount > 0 ? "Active" : "Ready",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: installedCount > 0
                                    ? const Color(0xFF10B981)
                                    : (isDark ? Colors.white60 : Colors.black45),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Horizontal Interactive Level Chips
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 42,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      physics: const BouncingScrollPhysics(),
                      itemCount: catalog.length + 1,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (_, i) {
                        if (i == 0) {
                          final isSelected = _selectedLevelFilter == null;
                          return GestureDetector(
                            onTap: () {
                              HapticsManager.light();
                              setState(() => _selectedLevelFilter = null);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? (isDark ? Colors.white : const Color(0xFF1A1A1B))
                                    : (isDark ? const Color(0xFF262833) : const Color(0xFFEDE9DC)),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.transparent
                                      : (isDark ? Colors.white12 : const Color(0xFFDED8C6))),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "All Tiers",
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                  color: isSelected
                                      ? (isDark ? const Color(0xFF1A1A1B) : Colors.white)
                                      : (isDark ? Colors.white70 : const Color(0xFF4B4A45)),
                                ),
                              ),
                            ),
                          );
                        }

                        final tome = catalog[i - 1];
                        final lvl = tome['level'] as int;
                        final installed = isLevelInstalled(lvl, decks);
                        final meta = _levelData[lvl]!;
                        final isSelected = _selectedLevelFilter == lvl;

                        return GestureDetector(
                          onTap: () {
                            HapticsManager.light();
                            setState(() {
                              _selectedLevelFilter = _selectedLevelFilter == lvl ? null : lvl;
                            });
                          },
                          child: _LevelChip(
                            level: lvl,
                            numeral: meta.numeral,
                            label: meta.label,
                            isInstalled: installed,
                            isSelected: isSelected,
                            accentColor: meta.primaryColor,
                            isDark: isDark,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 16)),

                // Collection Cards List
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, i) {
                        final tome = displayCatalog[i];
                        final lvl = tome['level'] as int;
                        final installed = isLevelInstalled(lvl, decks);
                        final meta = _levelData[lvl]!;

                        return _TomeCard(
                          tome: tome,
                          meta: meta,
                          isInstalled: installed,
                          onInstall: () => installTome(tome),
                          onUninstall: () => uninstallTome(tome),
                          isDark: isDark,
                        );
                      },
                      childCount: displayCatalog.length,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 48)),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFD4AF37))),
          error: (e, _) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Failed to load collections.", style: TextStyle(color: inkColor)),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    ref.invalidate(flashcardControllerProvider);
                    ref.invalidate(deckControllerProvider);
                  },
                  child: const Text(
                    "Retry",
                    style: TextStyle(color: Color(0xFFFB8C00), fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TomeCard extends StatelessWidget {
  final Map<String, dynamic> tome;
  final _LevelMeta meta;
  final bool isInstalled;
  final VoidCallback onInstall;
  final VoidCallback onUninstall;
  final bool isDark;

  const _TomeCard({
    required this.tome,
    required this.meta,
    required this.isInstalled,
    required this.onInstall,
    required this.onUninstall,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final level = tome['level'] as int;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E212B) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isInstalled
                ? meta.primaryColor.withValues(alpha: isDark ? 0.45 : 0.35)
                : (isDark ? Colors.white10 : const Color(0xFFE5E2D5)),
            width: isInstalled ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: isInstalled
                  ? meta.primaryColor.withValues(alpha: isDark ? 0.12 : 0.06)
                  : Colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row: Seal + Title + Install Pill
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Calligraphic Seal Badge
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          meta.primaryColor.withValues(alpha: isDark ? 0.3 : 0.15),
                          meta.secondaryColor.withValues(alpha: isDark ? 0.15 : 0.08),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: meta.primaryColor.withValues(alpha: 0.5),
                        width: 1.2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        meta.numeral,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: isDark ? meta.secondaryColor : meta.primaryColor,
                          fontFamily: 'serif',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Title & Level Subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "HSK $level: ${meta.label}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                                letterSpacing: -0.2,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                              decoration: BoxDecoration(
                                color: meta.primaryColor.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                meta.chineseLabel,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? meta.secondaryColor : meta.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          "${meta.count} characters • Standard Vocabulary",
                          style: TextStyle(
                            fontSize: 12.5,
                            color: isDark ? Colors.white54 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Action Button
                  GestureDetector(
                    onTap: isInstalled ? onUninstall : onInstall,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: isInstalled
                            ? (isDark
                                ? const Color(0xFF064E3B).withValues(alpha: 0.5)
                                : const Color(0xFFECFDF5))
                            : (isDark ? Colors.white : const Color(0xFF1A1A1B)),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isInstalled
                              ? const Color(0xFF10B981).withValues(alpha: 0.6)
                              : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isInstalled ? Icons.check_circle_rounded : Icons.add_rounded,
                            size: 14,
                            color: isInstalled
                                ? const Color(0xFF10B981)
                                : (isDark ? const Color(0xFF1A1A1B) : Colors.white),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            isInstalled ? 'Installed' : 'Install',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isInstalled
                                  ? (isDark ? const Color(0xFF34D399) : const Color(0xFF065F46))
                                  : (isDark ? const Color(0xFF1A1A1B) : Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Sample Characters Preview Pill Row
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.2)
                      : const Color(0xFFFAF8F0),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFEDE9DC),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      "Sample:",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white38 : Colors.black38,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Wrap(
                        spacing: 8,
                        children: meta.sampleChars.map((char) {
                          return Text(
                            char,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white70 : const Color(0xFF2C2C2E),
                              fontFamily: 'NotoSansSC',
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    if (isInstalled)
                      GestureDetector(
                        onTap: onUninstall,
                        child: Text(
                          "Remove",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: isDark ? Colors.white38 : Colors.black38,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LevelChip extends StatelessWidget {
  final int level;
  final String numeral;
  final String label;
  final bool isInstalled;
  final bool isSelected;
  final Color accentColor;
  final bool isDark;

  const _LevelChip({
    required this.level,
    required this.numeral,
    required this.label,
    required this.isInstalled,
    required this.isSelected,
    required this.accentColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isSelected
        ? (isDark ? Colors.white : const Color(0xFF1A1A1B))
        : (isDark ? const Color(0xFF262833) : const Color(0xFFEDE9DC));
    final fg = isSelected
        ? (isDark ? const Color(0xFF1A1A1B) : Colors.white)
        : (isDark ? Colors.white70 : const Color(0xFF3A3A3C));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : (isInstalled
                  ? accentColor.withValues(alpha: 0.5)
                  : (isDark ? Colors.white12 : const Color(0xFFDED8C6))),
          width: isInstalled ? 1.2 : 1.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'HSK $level',
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              color: fg,
            ),
          ),
          if (isInstalled) ...[
            const SizedBox(width: 5),
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF10B981) : accentColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
