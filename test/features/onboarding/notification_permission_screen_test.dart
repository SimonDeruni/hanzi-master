import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/onboarding/presentation/screens/notification_permission_screen.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

void main() {
  testWidgets('renders the onboarding notification prompt on a small screen',
      (tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: NotificationPermissionScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Never Miss a Stroke'), findsOneWidget);
    expect(find.text('Daily Drop'), findsOneWidget);
    expect(find.text('Review Reminders'), findsOneWidget);
    expect(find.text('Enable Notifications'), findsOneWidget);
    expect(find.text('Maybe Later'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
