import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/media/domain/models/daily_media_item.dart';
import 'package:hanzi_master/features/media/presentation/screens/cultural_context_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  final item = DailyMediaItem(
    title: '测试文章标题',
    subtitle: 'BBC 中文',
    url: 'https://www.bbc.com/zhongwen/articles/test',
    imageUrl: '',
    tag: 'ARTICLE OF THE DAY',
  );

  Future<void> pumpSummary(WidgetTester tester, Brightness brightness) async {
    await tester.binding.setSurfaceSize(const Size(430, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: brightness == Brightness.dark
              ? AppTheme.darkTheme
              : AppTheme.lightTheme,
          locale: const Locale('fr'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: CulturalContextScreen(mediaItem: item),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('Article summary screen uses the canonical surface colour',
      (tester) async {
    await pumpSummary(tester, Brightness.light);

    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold).first);
    expect(scaffold.backgroundColor, AppTheme.surfaceLight);

    final appBar = tester.widget<SliverAppBar>(find.byType(SliverAppBar));
    expect(appBar.backgroundColor, AppTheme.surfaceLight);
  });

  testWidgets('Article summary CTA uses the book-screen primary button style',
      (tester) async {
    await pumpSummary(tester, Brightness.light);

    final ctaFinder = find.ancestor(
      of: find.text('Plonger dans le Contenu Complet'),
      matching: find.byType(ElevatedButton),
    );
    expect(ctaFinder, findsOneWidget,
        reason: 'CTA must be an ElevatedButton like BookDetailScreen');

    final button = tester.widget<ElevatedButton>(ctaFinder);
    final style = button.style!;

    // Ink background on light theme, matching the book screen's primary CTA.
    expect(style.backgroundColor?.resolve({}), const Color(0xFF1A1A1B));
    expect(style.foregroundColor?.resolve({}), Colors.white);

    final shape = style.shape?.resolve({}) as RoundedRectangleBorder;
    expect(shape.borderRadius, BorderRadius.circular(16));
    expect(style.elevation?.resolve({}), 4);

    // Fixed 52px height matching the book screen's action button.
    final sizedBox = tester.widget<SizedBox>(
      find
          .ancestor(
            of: ctaFinder,
            matching: find.byType(SizedBox),
          )
          .first,
    );
    expect(sizedBox.height, 52);
  });

  testWidgets('Tag badge follows the book-screen pill vocabulary',
      (tester) async {
    await pumpSummary(tester, Brightness.light);

    final badge = tester.widget<Container>(
      find
          .ancestor(
            of: find.text('ARTICLE OF THE DAY'),
            matching: find.byType(Container),
          )
          .first,
    );
    final decoration = badge.decoration! as BoxDecoration;

    expect(decoration.borderRadius, BorderRadius.circular(20));
    expect(decoration.border, isNotNull,
        reason: 'Book badges always carry a tinted border');
  });
}
