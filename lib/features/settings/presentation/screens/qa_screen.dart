import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

class QAScreen extends ConsumerWidget {
  const QAScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Zen & Ink Mandate Colors
    final bgColor = AppTheme.surfaceOf(context);
    final textColor =
        isDark ? const Color(0xFFFDFCF0) : const Color(0xFF1A1A1B);
    final cardColor = AppTheme.cardBgOf(context);
    final accentColor = AppTheme.accentOf(context);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          l10n.knowledgeBase,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        physics: const BouncingScrollPhysics(),
        children: [
          _buildHeader(
            title: l10n.howCanWeHelpYou,
            subtitle: l10n.everythingYouNeedToKnowAboutHanziMa,
            textColor: textColor,
            accentColor: accentColor,
          ),
          const SizedBox(height: 32),
          _buildCategory(
            title: l10n.privacyAndAudio,
            icon: Icons.security_outlined,
            cardColor: cardColor,
            textColor: textColor,
            accentColor: accentColor,
            items: [
              _FaqItem(
                question: l10n.do_you_keep_or_store_my,
                answer: l10n.no_when_you_use_echo_hall,
              ),
              _FaqItem(
                question: l10n.whatHappensToMyChatHistory,
                answer: l10n.yourEchoModels,
              ),
            ],
          ),
          _buildCategory(
            title: l10n.speaking_pronunciation,
            icon: Icons.mic_none_outlined,
            cardColor: cardColor,
            textColor: textColor,
            accentColor: accentColor,
            items: [
              _FaqItem(
                question: l10n.how_is_my_pronunciation_scored,
                answer: l10n.the_ai_evaluates_your_speech_across,
              ),
              _FaqItem(
                question: l10n.whatIfAiMishears,
                answer: l10n.ifTheAgain,
              ),
              _FaqItem(
                question: l10n.what_is_shadowing_studio,
                answer: l10n.shadowingStudioIsADedicated,
              ),
              _FaqItem(
                question: l10n.whoAreTheVoicesSpeakingInTheApp,
                answer: l10n.theVoicesInAIStories,
              ),
            ],
          ),
          _buildCategory(
            title: l10n.readingVocabulary,
            icon: Icons.menu_book_outlined,
            cardColor: cardColor,
            textColor: textColor,
            accentColor: accentColor,
            items: [
              _FaqItem(
                question: l10n.howDoesTheWebExplorerWork,
                answer: l10n.theWebExplorerAllowsYou,
              ),
              _FaqItem(
                question: l10n.whatIsZenMode,
                answer: l10n.zenModeStripsAwayDistracting,
              ),
              _FaqItem(
                question: l10n.howDoesTheFlashcardSpacedrepetition,
                answer: l10n.weUseAnIntelligentAlgorithm,
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildHeader({
    required String title,
    required String subtitle,
    required Color textColor,
    required Color accentColor,
  }) {
    return Column(
      children: [
        Icon(
          Icons.auto_stories_outlined,
          size: 48,
          color: accentColor.withValues(alpha: 0.5),
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: textColor,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: textColor.withValues(alpha: 0.6),
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCategory({
    required String title,
    required IconData icon,
    required Color cardColor,
    required Color textColor,
    required Color accentColor,
    required List<_FaqItem> items,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Row(
              children: [
                Icon(icon, size: 20, color: accentColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: items.asMap().entries.map((entry) {
                final isLast = entry.key == items.length - 1;
                return Column(
                  children: [
                    Theme(
                      data: ThemeData(
                        dividerColor: Colors.transparent,
                        splashColor: accentColor.withValues(alpha: 0.1),
                        highlightColor: accentColor.withValues(alpha: 0.05),
                      ),
                      child: ExpansionTile(
                        tilePadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 4),
                        title: Text(
                          entry.value.question,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: textColor.withValues(alpha: 0.9),
                            height: 1.3,
                          ),
                        ),
                        iconColor: accentColor,
                        collapsedIconColor: textColor.withValues(alpha: 0.4),
                        childrenPadding:
                            const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.value.answer,
                            style: TextStyle(
                              height: 1.6,
                              fontSize: 14,
                              color: textColor.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isLast)
                      Divider(
                        height: 1,
                        indent: 20,
                        endIndent: 20,
                        color: textColor.withValues(alpha: 0.08),
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqItem {
  final String question;
  final String answer;

  _FaqItem({required this.question, required this.answer});
}
