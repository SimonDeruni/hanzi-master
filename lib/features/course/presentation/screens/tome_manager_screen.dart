import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

import '../../../../core/providers.dart';
import '../../../../shared/widgets/global_sliver_app_bar.dart';
import '../../../flashcards/domain/entities/deck.dart';
import '../../../flashcards/presentation/providers/deck_controller.dart';
import '../../../flashcards/presentation/providers/flashcard_controller.dart';
import '../../../flashcards/presentation/utils/haptics_manager.dart';
import '../../../flashcards/presentation/widgets/calligraphy_background.dart';
import '../../data/thematic_decks_data.dart';

class _HskCollection {
  final int level;
  final String title;
  final String cardCount;
  final Color color;

  const _HskCollection({
    required this.level,
    required this.title,
    required this.cardCount,
    required this.color,
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
  int _selectedTab = 0; // 0 = Thematic, 1 = Official HSK

  List<_HskCollection> _collections(AppLocalizations l10n) => [
        _HskCollection(
          level: 1,
          title: l10n.foundation,
          cardCount: l10n.hsk_154_cards,
          color: const Color(0xFF15803D),
        ),
        _HskCollection(
          level: 2,
          title: l10n.elementary,
          cardCount: l10n.hsk_162_cards,
          color: const Color(0xFF0F766E),
        ),
        _HskCollection(
          level: 3,
          title: l10n.intermediate,
          cardCount: l10n.hsk_299_cards,
          color: const Color(0xFFB45309),
        ),
        _HskCollection(
          level: 4,
          title: l10n.upperIntermediate,
          cardCount: l10n.hsk_602_cards,
          color: const Color(0xFFBE123C),
        ),
        _HskCollection(
          level: 5,
          title: l10n.advanced,
          cardCount: l10n.hsk_1300_cards,
          color: const Color(0xFF4338CA),
        ),
        _HskCollection(
          level: 6,
          title: l10n.mastery,
          cardCount: l10n.hsk_2500_cards,
          color: const Color(0xFF6D28D9),
        ),
      ];

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
        );
      }
    } catch (error) {
      debugPrint('Installation Error: $error');
      if (mounted) {
        _showMessage(AppLocalizations.of(context)!.failedToDownload);
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
        _showMessage('${l10n.removedLibrary} $levelName.');
      }
    } catch (error) {
      debugPrint('Uninstallation Error: $error');
      if (mounted) _showMessage(l10n.failedToDownload);
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
        _showMessage('Successfully added "${thematic.title}" to your Bookshelf.');
      }
    } catch (error) {
      debugPrint('Thematic Install Error: $error');
      if (mounted) {
        _showMessage(AppLocalizations.of(context)!.failedToDownload);
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
        title: Text('${l10n.remove} ${thematic.title}?'),
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
        _showMessage('Removed "${thematic.title}".');
      }
    } catch (error) {
      debugPrint('Thematic Uninstall Error: $error');
      if (mounted) _showMessage(l10n.failedToDownload);
    } finally {
      if (mounted) setState(() => _busyThematicId = null);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final collections = _collections(l10n);
    const thematicDecks = ThematicDecksData.collections;
    final asyncDecks = ref.watch(deckControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CalligraphyBackground(
        child: asyncDecks.when(
          data: (decks) {
            final installedHskCount = collections
                .where(
                  (collection) => _isLevelInstalled(collection.level, decks),
                )
                .length;

            final installedThematicCount = thematicDecks
                .where(
                  (thematic) => _isThematicInstalled(thematic.id, decks),
                )
                .length;

            final totalInstalled = installedHskCount + installedThematicCount;
            final totalAvailable = collections.length + thematicDecks.length;

            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                const GlobalSliverAppBar(
                  title: "Master Deck Library",
                  subtitle: "Standard HSK tiers and curated thematic collections",
                  showBackButton: true,
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
                  sliver: SliverList.list(
                    children: [
                      _DownloadSummary(
                        installedCount: totalInstalled,
                        totalCount: totalAvailable,
                        label: "Installed Collections",
                      ),
                      const SizedBox(height: 16),
                      // Segment switcher
                      Container(
                        height: 48,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF2C2C2E)
                              : Colors.black.withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildSegmentButton(
                                index: 0,
                                label: "Thematic Paths (${thematicDecks.length})",
                                isSelected: _selectedTab == 0,
                                isDark: isDark,
                              ),
                            ),
                            Expanded(
                              child: _buildSegmentButton(
                                index: 1,
                                label: "Official HSK (${collections.length})",
                                isSelected: _selectedTab == 1,
                                isDark: isDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (_selectedTab == 0) ...[
                        ...thematicDecks.map(
                          (thematic) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _ThematicRow(
                              thematic: thematic,
                              installed: _isThematicInstalled(thematic.id, decks),
                              busy: _busyThematicId == thematic.id,
                              actionsDisabled: _busyThematicId != null || _busyHskLevel != null,
                              onInstall: () => _installThematic(thematic),
                              onUninstall: () => _uninstallThematic(thematic),
                            ),
                          ),
                        ),
                      ] else ...[
                        ...collections.map(
                          (collection) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: _CollectionRow(
                              collection: collection,
                              installed: _isLevelInstalled(
                                collection.level,
                                decks,
                              ),
                              busy: _busyHskLevel == collection.level,
                              actionsDisabled: _busyHskLevel != null || _busyThematicId != null,
                              onInstall: () => _installCollection(collection),
                              onUninstall: () => _uninstallCollection(collection),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
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

  Widget _buildSegmentButton({
    required int index,
    required String label,
    required bool isSelected,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: () {
        HapticsManager.light();
        setState(() => _selectedTab = index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xFF1E1E24) : Colors.white)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected
                ? (isDark ? Colors.white : Colors.black87)
                : (isDark ? Colors.white54 : Colors.black54),
          ),
        ),
      ),
    );
  }
}

class _DownloadSummary extends StatelessWidget {
  final int installedCount;
  final int totalCount;
  final String label;

  const _DownloadSummary({
    required this.installedCount,
    required this.totalCount,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(Icons.download_done_rounded, color: colors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Text(
            '$installedCount / $totalCount',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}

class _ThematicRow extends StatelessWidget {
  final ThematicDeckDefinition thematic;
  final bool installed;
  final bool busy;
  final bool actionsDisabled;
  final VoidCallback onInstall;
  final VoidCallback onUninstall;

  const _ThematicRow({
    required this.thematic,
    required this.installed,
    required this.busy,
    required this.actionsDisabled,
    required this.onInstall,
    required this.onUninstall,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: installed
              ? thematic.color.withValues(alpha: 0.45)
              : colors.outlineVariant,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: thematic.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              thematic.icon,
              color: thematic.color,
              size: 26,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  thematic.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${thematic.vocabulary.length} words · ${thematic.description}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          if (busy)
            const SizedBox.square(
              dimension: 32,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: CircularProgressIndicator(strokeWidth: 2.5),
              ),
            )
          else if (installed)
            IconButton.outlined(
              tooltip: l10n.uninstall,
              onPressed: actionsDisabled ? null : onUninstall,
              icon: const Icon(Icons.delete_outline_rounded),
              color: colors.error,
            )
          else
            FilledButton(
              onPressed: actionsDisabled ? null : onInstall,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                minimumSize: const Size(0, 42),
                backgroundColor: thematic.color,
              ),
              child: Text(l10n.install),
            ),
        ],
      ),
    );
  }
}

class _CollectionRow extends StatelessWidget {
  final _HskCollection collection;
  final bool installed;
  final bool busy;
  final bool actionsDisabled;
  final VoidCallback onInstall;
  final VoidCallback onUninstall;

  const _CollectionRow({
    required this.collection,
    required this.installed,
    required this.busy,
    required this.actionsDisabled,
    required this.onInstall,
    required this.onUninstall,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: installed
              ? collection.color.withValues(alpha: 0.45)
              : colors.outlineVariant,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: collection.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Text(
              '${collection.level}',
              style: theme.textTheme.titleLarge?.copyWith(
                color: collection.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.hskLevel(collection.level.toString()),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${collection.title} · ${collection.cardCount}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          if (busy)
            const SizedBox.square(
              dimension: 32,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: CircularProgressIndicator(strokeWidth: 2.5),
              ),
            )
          else if (installed)
            IconButton.outlined(
              tooltip: l10n.uninstall,
              onPressed: actionsDisabled ? null : onUninstall,
              icon: const Icon(Icons.delete_outline_rounded),
              color: colors.error,
            )
          else
            FilledButton(
              onPressed: actionsDisabled ? null : onInstall,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                minimumSize: const Size(0, 42),
              ),
              child: Text(l10n.install),
            ),
        ],
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
