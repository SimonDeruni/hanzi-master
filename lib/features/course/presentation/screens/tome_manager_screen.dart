import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

import '../../../flashcards/domain/entities/deck.dart';
import '../../../flashcards/presentation/providers/flashcard_controller.dart';
import '../../../flashcards/presentation/providers/deck_controller.dart';
import '../../../flashcards/presentation/utils/haptics_manager.dart';
import '../../../flashcards/presentation/widgets/calligraphy_background.dart';
import '../../../../core/providers.dart';

class _LevelTheme {
  final String label;

  const _LevelTheme({
    required this.label,
  });
}

class TomeManagerScreen extends ConsumerWidget {
  const TomeManagerScreen({super.key});



  static const Map<int, _LevelTheme> _levelThemes = {
    1: _LevelTheme(label: 'Foundation'),
    2: _LevelTheme(label: 'Elementary'),
    3: _LevelTheme(label: 'Intermediate'),
    4: _LevelTheme(label: 'Upper Int.'),
    5: _LevelTheme(label: 'Advanced'),
    6: _LevelTheme(label: 'Mastery'),
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final asyncDecks = ref.watch(deckControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final inkColor = isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);

    final List<Map<String, dynamic>> catalog = [
      {'id': 'hsk1', 'title': 'HSK 1: Foundation',  'cards': '154 cards',  'level': 1},
      {'id': 'hsk2', 'title': 'HSK 2: Elementary',   'cards': '162 cards',  'level': 2},
      {'id': 'hsk3', 'title': 'HSK 3: Intermediate', 'cards': '299 cards',  'level': 3},
      {'id': 'hsk4', 'title': 'HSK 4: Upper Int.',   'cards': '602 cards',  'level': 4},
      {'id': 'hsk5', 'title': 'HSK 5: Advanced',     'cards': '1300 cards', 'level': 5},
      {'id': 'hsk6', 'title': 'HSK 6: Mastery',      'cards': '2500 cards', 'level': 6},
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
          backgroundColor: const Color(0xFFFDFCF0),
          title: Text("${l10n?.rescindTitle ?? 'Rescind'} ${tome['title']}?",
              style: const TextStyle(fontFamily: 'NotoSansSC', fontWeight: FontWeight.bold)),
          content: Text(l10n?.removeCharactersWarning ??
              "This will remove these characters from your library and reset your mastery progress."),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false),
                child: Text(l10n?.cancel ?? "Cancel", style: const TextStyle(color: Colors.grey))),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(l10n?.uninstall ?? "Uninstall",
                  style: const TextStyle(color: Color(0xFFE53935), fontWeight: FontWeight.bold)),
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
          data: (decks) => CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 60, 24, 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Library",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24, color: inkColor, letterSpacing: -0.5)),
                      const SizedBox(height: 2),
                      Text("HSK vocabulary collections",
                          style: TextStyle(fontSize: 14, color: inkColor.withValues(alpha: 0.45))),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 48,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    physics: const BouncingScrollPhysics(),
                    itemCount: catalog.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (_, i) {
                      final tome = catalog[i];
                      final lvl = tome['level'] as int;
                      final installed = isLevelInstalled(lvl, decks);
                      final theme = _levelThemes[lvl]!;
                      return _LevelChip(level: lvl, label: theme.label, isInstalled: installed, isDark: isDark);
                    },
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, i) {
                      final tome = catalog[i];
                      final lvl = tome['level'] as int;
                      final installed = isLevelInstalled(lvl, decks);
                      return _TomeCard(
                        tome: tome, isInstalled: installed,
                        onInstall: () => installTome(tome),
                        onUninstall: () => uninstallTome(tome),
                        isDark: isDark,
                      );
                    },
                    childCount: catalog.length,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
          loading: () => CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SizedBox(height: 160)),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, __) => const _ShimmerCard(),
                    childCount: 6,
                  ),
                ),
              ),
            ],
          ),
          error: (err, _) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.library_books_outlined, size: 48, color: inkColor.withValues(alpha: 0.3)),
                const SizedBox(height: 16),
                Text("Couldn't load the library",
                    style: TextStyle(color: inkColor.withValues(alpha: 0.6), fontSize: 14)),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    ref.invalidate(flashcardControllerProvider);
                    ref.invalidate(deckControllerProvider);
                  },
                  child: Text("Retry",
                      style: TextStyle(color: const Color(0xFFFB8C00), fontWeight: FontWeight.bold)),
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
  final bool isInstalled;
  final VoidCallback onInstall;
  final VoidCallback onUninstall;
  final bool isDark;

  const _TomeCard({
    required this.tome,
    required this.isInstalled,
    required this.onInstall,
    required this.onUninstall,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final cardCount = tome['cards'] as String;
    final level = tome['level'] as int;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1F) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06),
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: isInstalled ? onUninstall : onInstall,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tome['title'] as String,
                          style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : const Color(0xFF1A1A1B),
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text('$cardCount • HSK $level',
                            style: TextStyle(fontSize: 12,
                                color: isDark ? Colors.white38 : Colors.black45,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: isInstalled ? onUninstall : onInstall,
                    style: TextButton.styleFrom(
                      foregroundColor: isInstalled ? (isDark ? Colors.white54 : Colors.black54) : const Color(0xFF5B6ABF),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      isInstalled ? 'Remove' : 'Install',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
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
class _LevelChip extends StatelessWidget {
  final int level;
  final String label;
  final bool isInstalled;
  final bool isDark;

  const _LevelChip({
    required this.level,
    required this.label,
    required this.isInstalled,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isDark ? const Color(0xFF2C2C2E) : const Color(0xFFF2F2F4);
    final fg = isDark ? Colors.white70 : const Color(0xFF3A3A3C);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'HSK $level',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: fg, letterSpacing: 0.2),
          ),
          if (isInstalled) ...[
            const SizedBox(width: 6),
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0xFF5B6ABF),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ShimmerCard extends StatelessWidget {
  const _ShimmerCard();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final shimmer = isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.06);

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Container(
        height: 88,
        decoration: BoxDecoration(
          color: shimmer,
          borderRadius: BorderRadius.circular(16),
          border: Border(left: BorderSide(color: shimmer, width: 4)),
        ),
      ),
    );
  }
}
