import 'package:flutter/material.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';

class AppLanguageOption {
  const AppLanguageOption({
    required this.code,
    required this.name,
    required this.symbol,
  });

  final String code;
  final String name;
  final String symbol;
}

const appLanguageOptions = <AppLanguageOption>[
  AppLanguageOption(code: 'en', name: 'English', symbol: 'EN'),
  AppLanguageOption(code: 'de', name: 'Deutsch', symbol: 'DE'),
  AppLanguageOption(code: 'es', name: 'Español', symbol: 'ES'),
  AppLanguageOption(code: 'fr', name: 'Français', symbol: 'FR'),
  AppLanguageOption(code: 'hi', name: 'हिन्दी', symbol: 'हि'),
  AppLanguageOption(code: 'id', name: 'Bahasa Indonesia', symbol: 'ID'),
  AppLanguageOption(code: 'it', name: 'Italiano', symbol: 'IT'),
  AppLanguageOption(code: 'ja', name: '日本語', symbol: '日'),
  AppLanguageOption(code: 'ko', name: '한국어', symbol: '한'),
  AppLanguageOption(code: 'pt', name: 'Português', symbol: 'PT'),
  AppLanguageOption(code: 'ru', name: 'Русский', symbol: 'РУ'),
  AppLanguageOption(code: 'th', name: 'ไทย', symbol: 'TH'),
  AppLanguageOption(code: 'vi', name: 'Tiếng Việt', symbol: 'VI'),
];

String appLanguageName(String locale) {
  return appLanguageOptions
      .firstWhere(
        (language) => language.code == locale,
        orElse: () => appLanguageOptions.first,
      )
      .name;
}

class AppLanguagePickerSheet extends StatelessWidget {
  const AppLanguagePickerSheet({
    super.key,
    required this.title,
    required this.selectedLocale,
    required this.onSelected,
  });

  final String title;
  final String selectedLocale;
  final Future<void> Function(String locale) onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    // Same palette as the audiobook-voice sheet, so the two pickers in Settings
    // read as one component rather than two eras of the app.
    final accent = isDark ? AppTheme.accentDark : AppTheme.accentLight;
    final gold = isDark ? Colors.amber.shade700 : const Color(0xFFD4AF37);
    final selectedBackground = accent.withValues(alpha: isDark ? 0.14 : 0.07);
    final unselectedBackground =
        isDark ? AppTheme.cardBgDark : AppTheme.cardBgLight;

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.82,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 10, 24, 18),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : const Color(0xFF1A1A1B),
              ),
            ),
          ),
          Divider(height: 1, color: gold.withValues(alpha: 0.3)),
          Expanded(
            child: ListView.separated(
              key: const ValueKey('app-language-list'),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              itemCount: appLanguageOptions.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final language = appLanguageOptions[index];
                final isSelected = language.code == selectedLocale;

                return Semantics(
                  selected: isSelected,
                  button: true,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      // The voice sheet's ink well: accent when chosen, gold
                      // hairline when not.
                      border: Border.all(
                        color:
                            isSelected ? accent : gold.withValues(alpha: 0.28),
                        width: isSelected ? 1.6 : 1,
                      ),
                    ),
                    child: Material(
                      color: isSelected
                          ? selectedBackground
                          : unselectedBackground,
                      borderRadius: BorderRadius.circular(18),
                      child: InkWell(
                        key: ValueKey('app-language-${language.code}'),
                        borderRadius: BorderRadius.circular(18),
                        onTap: () async {
                          if (isSelected) {
                            Navigator.of(context).pop();
                            return;
                          }
                          await onSelected(language.code);
                          if (context.mounted) Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: accent.withValues(alpha: 0.14),
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  language.symbol,
                                  style: TextStyle(
                                    color: accent,
                                    fontSize:
                                        language.symbol.length > 1 ? 12 : 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  language.name,
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.white
                                        : const Color(0xFF1A1A1B),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              AnimatedContainer(
                                duration: ZenMotion.of(context, ZenMotion.swap),
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                  color:
                                      isSelected ? accent : Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? accent
                                        : gold.withValues(alpha: 0.5),
                                    width: 1.6,
                                  ),
                                ),
                                child: isSelected
                                    ? Icon(Icons.check_rounded,
                                        size: 18,
                                        color: isDark
                                            ? const Color(0xFF1A1A1B)
                                            : Colors.white)
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
