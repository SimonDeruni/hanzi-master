import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/flashcards/presentation/screens/profile_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  Future<void> pumpAccount(WidgetTester tester,
      {Brightness brightness = Brightness.light}) async {
    await tester.binding.setSurfaceSize(const Size(430, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: brightness == Brightness.dark
              ? AppTheme.darkTheme
              : AppTheme.lightTheme,
          locale: const Locale('en'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ProfileScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('account screen background uses the canonical surface',
      (tester) async {
    await pumpAccount(tester);

    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold).first);
    expect(scaffold.backgroundColor, AppTheme.surfaceLight);

    final appBar = tester.widget<AppBar>(find.byType(AppBar));
    expect(appBar.backgroundColor, AppTheme.surfaceLight);
    expect(appBar.surfaceTintColor, Colors.transparent);
  });

  testWidgets('the indigo accent is gone: a tappable row uses the app accent',
      (tester) async {
    await pumpAccount(tester);

    // "Learning Stats" is a normal navigable row with no explicit accentColor,
    // so its circular icon chip must use the canonical accent (cinnabar).
    final chips = tester
        .widgetList<Container>(find.byType(Container))
        .where((c) {
      final d = c.decoration;
      return d is BoxDecoration && d.shape == BoxShape.circle;
    });

    expect(chips, isNotEmpty,
        reason: 'Account rows should render circular icon chips');

    final tinted = chips.where((c) {
      final d = c.decoration! as BoxDecoration;
      return d.color == AppTheme.accentLight.withValues(alpha: 0.12);
    });
    expect(tinted, isNotEmpty,
        reason: 'Rows without an explicit accent must fall back to '
            'AppTheme.accentLight, not indigo');
  });

  testWidgets('no row title is tinted with the accent colour',
      (tester) async {
    await pumpAccount(tester);

    // Only ICONS may be tinted. Titles must use readable ink in every row,
    // including the Premium (gold) and Delete Account (red) rows.
    for (final label in ['Learning Stats', 'SinoSpark Premium', 'Settings']) {
      final title = tester.widget<Text>(find.text(label));
      final color = title.style?.color;
      expect(color, isNot(AppTheme.accentLight),
          reason: '"$label" title must not be accent-tinted');
      expect(color, isNot(const Color(0xFFC62828)),
          reason: '"$label" title must not be destructive-red');
    }
  });

  testWidgets('the Premium row is a status row, not a dead button',
      (tester) async {
    await pumpAccount(tester);

    final premiumTile = tester.widget<ListTile>(
      find.ancestor(
        of: find.text('SinoSpark Premium'),
        matching: find.byType(ListTile),
      ),
    );

    expect(premiumTile.onTap, isNull,
        reason: 'A row with no destination must not present a tap affordance');
    expect(premiumTile.trailing, isNotNull,
        reason: 'It should still show the premium check badge');
  });

  testWidgets('navigable rows keep a chevron and a tap handler',
      (tester) async {
    await pumpAccount(tester);

    final statsTile = tester.widget<ListTile>(
      find.ancestor(
        of: find.text('Learning Stats'),
        matching: find.byType(ListTile),
      ),
    );

    expect(statsTile.onTap, isNotNull);
    expect(statsTile.trailing, isNotNull,
        reason: 'Navigable rows keep their chevron affordance');
  });

  testWidgets('sign-in CTA uses the book-screen primary button vocabulary',
      (tester) async {
    await pumpAccount(tester);

    final cta = find.byType(ElevatedButton);
    expect(cta, findsOneWidget,
        reason: 'Logged-out account screen shows the sign-in CTA');

    final style = tester.widget<ElevatedButton>(cta).style!;
    expect(style.backgroundColor?.resolve({}), const Color(0xFF1A1A1B));
    expect(style.foregroundColor?.resolve({}), Colors.white);
    expect(style.elevation?.resolve({}), 4);

    final shape = style.shape?.resolve({}) as RoundedRectangleBorder;
    expect(shape.borderRadius, BorderRadius.circular(16));

    final box = tester.widget<SizedBox>(
      find.ancestor(of: cta, matching: find.byType(SizedBox)).first,
    );
    expect(box.height, 52, reason: 'Book-screen buttons are 52px tall');
  });
}
