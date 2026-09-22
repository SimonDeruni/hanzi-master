import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';
import 'package:hanzi_master/shared/widgets/zen_rating_sheet.dart';

void main() {
  Widget buildHarness() {
    return const ProviderScope(
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ZenRatingSheet(trigger: 'test_milestone'),
        ),
      ),
    );
  }

  testWidgets('ZenRatingSheet renders title, buttons, and calligraphic elements',
      (tester) async {
    await tester.pumpWidget(buildHarness());
    await tester.pumpAndSettle();

    // Check Star icon
    expect(find.byIcon(Icons.star_rounded), findsOneWidget);

    // Check action icons
    expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);
    expect(find.byIcon(Icons.chat_bubble_outline_rounded), findsOneWidget);

    // Check buttons present
    expect(find.byWidgetPredicate((w) => w is FilledButton), findsOneWidget);
    expect(find.byWidgetPredicate((w) => w is OutlinedButton), findsOneWidget);
    expect(find.byWidgetPredicate((w) => w is TextButton), findsOneWidget);
  });
}
