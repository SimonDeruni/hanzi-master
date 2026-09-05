import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/onboarding/presentation/onboarding_design.dart';
import 'package:hanzi_master/features/onboarding/presentation/screens/onboarding_screen.dart';

void main() {
  testWidgets('questionnaire uses the shared onboarding top inset',
      (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: OnboardingScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text("Let's Begin"));
    await tester.pumpAndSettle();

    final title = find.text('What is your level\nwith Chinese?');
    expect(title, findsOneWidget);
    expect(tester.getTopLeft(title).dy, OnboardingDesign.topPadding);
    expect(tester.widget<Text>(title).style?.fontSize,
        OnboardingDesign.titleFontSize);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Build My Path transitions into the connected mini lesson',
      (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: OnboardingScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text("Let's Begin"));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Brand New'));
    await tester.pump();
    await tester.tap(find.text('Confirm Selection'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Business &\nCareer'));
    await tester.pump();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('05'));
    await tester.pump();
    await tester.tap(find.text('Build My Path'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Crafting Your Curriculum'), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.text('Your Plan is Ready'), findsOneWidget);
    expect(find.text('Begin First Lesson'), findsOneWidget);

    await tester.tap(find.text('Begin First Lesson'));
    await tester.pumpAndSettle();

    expect(find.text('YOUR FIRST LESSON  •  1 OF 6'), findsOneWidget);
    expect(find.text('Listen'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
