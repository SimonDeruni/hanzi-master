import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/app_language_picker_sheet.dart';

void main() {
  Widget buildPicker({
    required String selectedLocale,
    required Future<void> Function(String) onSelected,
  }) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: AppLanguagePickerSheet(
          title: 'App Language',
          selectedLocale: selectedLocale,
          onSelected: onSelected,
        ),
      ),
    );
  }

  testWidgets('shows a spacious, scrollable list with the current selection',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(buildPicker(
      selectedLocale: 'en',
      onSelected: (_) async {},
    ));

    expect(find.byKey(const ValueKey('app-language-list')), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(find.byIcon(Icons.check_rounded), findsOneWidget);

    final englishText = tester.widget<Text>(find.text('English'));
    expect(englishText.style?.fontSize, 17);

    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('app-language-vi')),
      300,
      scrollable: find.byType(Scrollable),
    );
    expect(find.text('Tiếng Việt'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('app-language-th')),
      300,
      scrollable: find.byType(Scrollable),
    );
    expect(find.text('ไทย'), findsOneWidget);
  });

  testWidgets('returns the selected locale and dismisses the sheet',
      (tester) async {
    String? selectedLocale;

    await tester.pumpWidget(MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () => showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (_) => AppLanguagePickerSheet(
                  title: 'App Language',
                  selectedLocale: 'en',
                  onSelected: (locale) async => selectedLocale = locale,
                ),
              ),
              child: const Text('Open'),
            ),
          ),
        );
      }),
    ));

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('app-language-fr')));
    await tester.pumpAndSettle();

    expect(selectedLocale, 'fr');
    expect(find.text('App Language'), findsNothing);
  });
}
