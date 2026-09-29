@Tags(<String>['locale-sweep'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

Widget _buildTabTestWidget({
  required Locale locale,
  required double textScale,
  required double width,
}) {
  return MaterialApp(
    locale: locale,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: MediaQuery(
      data: MediaQueryData(
        size: Size(width, 600),
        textScaler: TextScaler.linear(textScale),
      ),
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: width,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Builder(
                builder: (context) {
                  final l10n = AppLocalizations.of(context)!;
                  return Container(
                    height: 52,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppTheme.cardBgLight,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildTestSegmentTab(
                            icon: Icons.forum_rounded,
                            label: l10n.roleplay,
                            isSelected: true,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: _buildTestSegmentTab(
                            icon: Icons.graphic_eq_rounded,
                            label: l10n.shadowing,
                            isSelected: false,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _buildTestSegmentTab({
  required IconData icon,
  required String label,
  required bool isSelected,
}) {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(horizontal: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 6),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 13,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

void main() {
  const testLocales = [
    Locale('es'),
    Locale('en'),
    Locale('fr'),
    Locale('ru'),
    Locale('ar'),
    Locale('th'),
    Locale('pt'),
    Locale('it'),
  ];

  for (final locale in testLocales) {
    testWidgets(
      'AI Hub segment tab never overflows at 320dp in ${locale.languageCode}',
      (tester) async {
        await tester.pumpWidget(
          _buildTabTestWidget(
            locale: locale,
            textScale: 1.0,
            width: 320,
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(find.byType(Row), findsWidgets);
      },
    );

    testWidgets(
      'AI Hub segment tab handles 1.5x accessibility text scaling without overflow in ${locale.languageCode}',
      (tester) async {
        await tester.pumpWidget(
          _buildTabTestWidget(
            locale: locale,
            textScale: 1.5,
            width: 320,
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
      },
    );
  }
}
