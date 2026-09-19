import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/live_translate/presentation/screens/shadowing_studio_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  testWidgets('Shadowing Studio hub has NeverScrollableScrollPhysics and does not scroll on standard phone viewport',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(375, 667));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          locale: Locale('fr'),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: ShadowingStudioScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Mode de pratique'), findsOneWidget);
    expect(find.text('Configuration'), findsOneWidget);
    expect(find.byKey(const Key('shadowing_start_session')), findsOneWidget);

    final scrollViewFinder = find.byType(SingleChildScrollView);
    expect(scrollViewFinder, findsOneWidget);
    final scrollView = tester.widget<SingleChildScrollView>(scrollViewFinder);
    expect(scrollView.physics, isA<NeverScrollableScrollPhysics>());

    final initialOffset = tester.getTopLeft(find.text('Mode de pratique'));
    await tester.drag(scrollViewFinder, const Offset(0, -200));
    await tester.pump();
    final afterDragOffset = tester.getTopLeft(find.text('Mode de pratique'));
    expect(afterDragOffset.dy, equals(initialOffset.dy));
  });
}
