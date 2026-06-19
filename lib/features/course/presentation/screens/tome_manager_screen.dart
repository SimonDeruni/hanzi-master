import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

import '../../../flashcards/domain/entities/flashcard.dart';
import '../../../flashcards/presentation/providers/flashcard_controller.dart';
import '../../../flashcards/presentation/utils/haptics_manager.dart';
import '../../../flashcards/presentation/widgets/calligraphy_background.dart';
import '../../../premium/presentation/screens/paywall_sheet.dart';
import '../../../../core/providers/premium_controller.dart';

class TomeManagerScreen extends ConsumerWidget {
  const TomeManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final asyncCards = ref.watch(flashcardControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final inkColor = isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);

    final List<Map<String, dynamic>> catalog = [
      {
        'id': 'hsk1',
        'title': 'HSK 1: The Foundation',
        'description': '150 core characters to begin your journey. Essential concepts of water, fire, and sky.',
        'size': 'Built-in',
        'level': 1,
        'isPremium': false,
      },
      {
        'id': 'hsk2',
        'title': 'HSK 2: The Expansion',
        'description': '162 new words to unlock the next level of fluency in modern communication.',
        'size': '78 KB',
        'level': 2,
        'isPremium': true,
      },
      {
        'id': 'hsk3',
        'title': 'HSK 3: The Intermediate',
        'description': '300 new words to express deeper thoughts and hold engaging conversations.',
        'size': '150 KB',
        'level': 3,
        'isPremium': true,
      },
      {
        'id': 'hsk4',
        'title': 'HSK 4: The Advanced',
        'description': '600 new words to master advanced topics and read authentic materials.',
        'size': '250 KB',
        'level': 4,
        'isPremium': true,
      },
      {
        'id': 'hsk5',
        'title': 'HSK 5: The Proficient',
        'description': '1300 new words to achieve fluency and communicate naturally like a native.',
        'size': '500 KB',
        'level': 5,
        'isPremium': true,
      },
      {
        'id': 'hsk6',
        'title': 'HSK 6: The Master',
        'description': '2500 new words. True mastery of the language and culture.',
        'size': '1 MB',
        'level': 6,
        'isPremium': true,
      }
    ];

    bool isLevelInstalled(int level, List<Flashcard> cards) {
      return cards.any((c) => c.hskLevel == level);
    }

    Future<void> installTome(Map<String, dynamic> tome) async {
      final isPremium = ref.read(premiumControllerProvider).valueOrNull ?? false;
      
      if (tome['isPremium'] && !isPremium) {
        PaywallSheet.show(context);
        return;
      }

      try {
        HapticsManager.medium();
        
        await ref.read(flashcardControllerProvider.notifier).importLevel(tome['level'] as int);

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
        title: Text(l10n?.tomeLibrary ?? "Tome Library"),
      ),
      body: CalligraphyBackground(
        child: asyncCards.when(
          data: (allCards) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              itemCount: catalog.length,
              itemBuilder: (context, index) {
                final tome = catalog[index];
                final isInstalled = isLevelInstalled(tome['level'], allCards);

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
          error: (err, _) => Center(child: Text("${l10n?.libraryError ?? 'Library Error'}: $err")),
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
    final l10n = AppLocalizations.of(context);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF252526) : Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: inkColor.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: inkColor.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isInstalled)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 4),
                color: const Color(0xFF43A047),
                child: const Text(
                  "INSTALLED",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          tome['title'].toUpperCase(),
                          style: TextStyle(
                            fontSize: 18, 
                            fontWeight: FontWeight.w900, 
                            letterSpacing: 0.5,
                            color: inkColor
                          ),
                        ),
                      ),
                      if (tome['isPremium'])
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade700,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            "PREMIUM",
                            style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    tome['description'],
                    style: TextStyle(
                      color: inkColor.withValues(alpha: 0.6),
                      fontSize: 14,
                      height: 1.5,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "SIZE: ${tome['size']}",
                        style: TextStyle(
                          fontSize: 11, 
                          fontWeight: FontWeight.bold, 
                          color: inkColor.withValues(alpha: 0.4)
                        ),
                      ),
                      
                      if (tome['level'] == 1)
                        Text(
                          "CORE MODULE",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey.shade400
                          ),
                        )
                      else if (isInstalled)
                        TextButton.icon(
                          onPressed: onUninstall,
                          icon: const Icon(Icons.delete_outline, size: 16),
                          label: Text(l10n?.uninstallButton ?? "UNINSTALL"),
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFFE53935),
                            textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        )
                      else
                        ElevatedButton.icon(
                          onPressed: onInstall,
                          icon: const Icon(Icons.file_download_outlined, size: 18),
                          label: Text(l10n?.installTome ?? "INSTALL TOME"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: inkColor,
                            foregroundColor: isDark ? const Color(0xFF1A1A1B) : const Color(0xFFFDFCF0),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
