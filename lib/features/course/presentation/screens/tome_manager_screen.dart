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
  final Color color;
  final Color gradientStart;
  final Color gradientEnd;
  final String label;
  final String emoji;

  const _LevelTheme({
    required this.color,
    required this.gradientStart,
    required this.gradientEnd,
    required this.label,
    required this.emoji,
  });
}

class TomeManagerScreen extends ConsumerWidget {
  const TomeManagerScreen({super.key});

  static const Map<int, _LevelTheme> _levelThemes = {
    1: _LevelTheme(
      color: Color(0xFF43A047),
      gradientStart: Color(0xFFE8F5E9),
      gradientEnd: Color(0xFFC8E6C9),
      label: 'Foundation',
      emoji: '🌱',
    ),
    2: _LevelTheme(
      color: Color(0xFF1E88E5),
      gradientStart: Color(0xFFE3F2FD),
      gradientEnd: Color(0xFFBBDEFB),
      label: 'Elementary',
      emoji: '🌿',
    ),
    3: _LevelTheme(
      color: Color(0xFFFB8C00),
      gradientStart: Color(0xFFFFF3E0),
      gradientEnd: Color(0xFFFFE0B2),
      label: 'Intermediate',
      emoji: '🌳',
    ),
    4: _LevelTheme(
      color: Color(0xFFE53935),
      gradientStart: Color(0xFFFFEBEE),
      gradientEnd: Color(0xFFFFCDD2),
      label: 'Upper Int.',
      emoji: '🔥',
    ),
    5: _LevelTheme(
      color: Color(0xFF8E24AA),
      gradientStart: Color(0xFFF3E5F5),
      gradientEnd: Color(0xFFE1BEE7),
      label: 'Advanced',
      emoji: '💎',
    ),
    6: _LevelTheme(
      color: Color(0xFF3949AB),
      gradientStart: Color(0xFFE8EAF6),
      gradientEnd: Color(0xFFC5CAE9),
      label: 'Mastery',
      emoji: '👑',
    ),
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

    bool isLevelInstalled(int level, List<Deck> decks) {
      return decks.any((d) => d.id == 'hsk$level');
    }

    Future<void> installTome(Map<String, dynamic> tome) async {
      try {
        HapticsManager.medium();
        
        await ref.read(flashcardControllerProvider.notifier).importLevel(tome['level'] as int);
        
        // Only proceed if flashcard import succeeded
        final flashcardState = ref.read(flashcardControllerProvider);
        if (flashcardState.hasError) {
          throw Exception(flashcardState.error);
        }
        
        await ref.read(deckRepositoryProvider).ensureHSKDeckExists(tome['level'] as int);
        ref.invalidate(deckControllerProvider);

        HapticsManager.success();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${l10n?.successfullyInstalled ?? 'Successfully installed'} ${tome['title']}"),
              backgroundColor: const Color(0xFF1A1A1B),
            ),
          );
        }
      } catch (e) {
        debugPrint("Installation Error: $e");
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n?.failedToDownload ?? "Failed to download module.")),
          );
        }
      }
    }

    Future<void> uninstallTome(Map<String, dynamic> tome) async {
      final bool? confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFFFDFCF0),
          title: Text("${l10n?.rescindTitle ?? 'Rescind'} ${tome['title']}?", style: const TextStyle(fontFamily: 'NotoSansSC', fontWeight: FontWeight.bold)),
          content: Text(l10n?.removeCharactersWarning ?? "This will remove these characters from your library and reset your mastery progress."),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n?.cancel ?? "Cancel", style: const TextStyle(color: Colors.grey))),
            TextButton(
              onPressed: () => Navigator.pop(context, true), 
              child: Text(l10n?.uninstall ?? "Uninstall", style: const TextStyle(color: Color(0xFFE53935), fontWeight: FontWeight.bold)),
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
              content: Text("${l10n?.removedLibrary ?? 'Removed Library'} ${tome['title']}."),
              backgroundColor: const Color(0xFF1A1A1B),
            ),
          );
        }
      } catch (e) {
        debugPrint("Uninstallation Error: $e");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("HSK Collections", style: TextStyle(fontWeight: FontWeight.bold, color: inkColor)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: inkColor),
      ),
      body: CalligraphyBackground(
        child: asyncDecks.when(
          data: (decks) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              itemCount: catalog.length,
              itemBuilder: (context, index) {
                final tome = catalog[index];
                final isInstalled = isLevelInstalled(tome['level'], decks);
                final theme = _levelThemes[tome['level'] as int];

                return _TomeCard(
                  tome: tome,
                  isInstalled: isInstalled,
                  onInstall: () => installTome(tome),
                  onUninstall: () => uninstallTome(tome),
                  inkColor: inkColor,
                  levelTheme: theme,
                );
              },
            );
          },
          loading: () => Center(child: CircularProgressIndicator(color: inkColor)),
          error: (err, _) => Center(child: Column(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.library_books_outlined, size: 48, color: Colors.grey), const SizedBox(height: 16), Text("Oops, we ran into trouble loading the library. Please try again.", style: TextStyle(color: isDark ? Colors.white70 : Colors.grey, fontSize: 14)), const SizedBox(height: 8), TextButton(onPressed: () { ref.invalidate(flashcardControllerProvider); ref.invalidate(deckControllerProvider); }, child: const Text("Retry"))])),
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
  final Color inkColor;
  final _LevelTheme? levelTheme;

  const _TomeCard({
    required this.tome,
    required this.isInstalled,
    required this.onInstall,
    required this.onUninstall,
    required this.inkColor,
    this.levelTheme,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    final accentColor = levelTheme?.color ?? const Color(0xFF00897B);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252526) : const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.12 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: isInstalled ? onUninstall : onInstall,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    levelTheme?.emoji ?? '📁',
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tome['title'],
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tome['cards'],
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark ? Colors.white54 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isInstalled)
                  const Icon(Icons.check_circle, color: Color(0xFF43A047), size: 24)
                else
                  Icon(Icons.arrow_forward_ios_rounded, size: 16, color: isDark ? Colors.white38 : Colors.black26),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
