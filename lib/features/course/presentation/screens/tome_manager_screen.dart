import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

import '../../../flashcards/domain/entities/flashcard.dart';
import '../../../flashcards/domain/entities/deck.dart';
import '../../../flashcards/presentation/providers/flashcard_controller.dart';
import '../../../flashcards/presentation/providers/deck_controller.dart';
import '../../../flashcards/presentation/utils/haptics_manager.dart';
import '../../../flashcards/presentation/widgets/calligraphy_background.dart';
import '../../../premium/presentation/screens/paywall_sheet.dart';
import '../../../../core/providers.dart';
import '../../../../core/providers/premium_controller.dart';

class TomeManagerScreen extends ConsumerWidget {
  const TomeManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final asyncCards = ref.watch(flashcardControllerProvider);
    final asyncDecks = ref.watch(deckControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final inkColor = isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);

    final List<Map<String, dynamic>> catalog = [
      {
        'id': 'hsk1',
        'title': 'HSK 1: Foundation',
        'cards': '154 cards',
        'level': 1,
      },
      {
        'id': 'hsk2',
        'title': 'HSK 2: Elementary',
        'cards': '162 cards',
        'level': 2,
      },
      {
        'id': 'hsk3',
        'title': 'HSK 3: Intermediate',
        'cards': '299 cards',
        'level': 3,
      },
      {
        'id': 'hsk4',
        'title': 'HSK 4: Upper Intermediate',
        'cards': '602 cards',
        'level': 4,
      },
      {
        'id': 'hsk5',
        'title': 'HSK 5: Advanced',
        'cards': '1300 cards',
        'level': 5,
      },
      {
        'id': 'hsk6',
        'title': 'HSK 6: Mastery',
        'cards': '2500 cards',
        'level': 6,
      }
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
        title: const Text("HSK Collections", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: inkColor),
        titleTextStyle: TextStyle(color: inkColor, fontSize: 20, fontWeight: FontWeight.bold),
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

                return _TomeCard(
                  tome: tome,
                  isInstalled: isInstalled,
                  onInstall: () => installTome(tome),
                  onUninstall: () => uninstallTome(tome),
                  inkColor: inkColor,
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF1A1A1B))),
          error: (err, _) => Center(child: Column(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.library_books_outlined, size: 48, color: Colors.grey), const SizedBox(height: 16), const Text("Oops, we ran into trouble loading the library. Please try again.", style: TextStyle(color: Colors.grey, fontSize: 14)), const SizedBox(height: 8), TextButton(onPressed: () { ref.invalidate(flashcardControllerProvider); ref.invalidate(deckControllerProvider); }, child: Text(l10n?.retry ?? "Retry"))])),
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

  const _TomeCard({
    required this.tome,
    required this.isInstalled,
    required this.onInstall,
    required this.onUninstall,
    required this.inkColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252526) : const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
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
                    color: const Color(0xFFE0F2F1), // Soft teal
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.folder,
                    color: Color(0xFF00897B), // Darker teal
                    size: 28,
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
