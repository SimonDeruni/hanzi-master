import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/features/flashcards/presentation/widgets/dictionary_expansion_panel.dart';

void main() {
  const explanation =
      'This is a deliberately long dictionary explanation that provides enough '
      'context to exceed the compact preview threshold. It continues with usage '
      'notes, nuance, and additional details that belong on the full card.';

  Widget app({required bool compact}) => MaterialApp(
        home: Scaffold(
          body: DictionaryExpansionText(
            text: explanation,
            compact: compact,
          ),
        ),
      );

  testWidgets('compact explanation is limited and can be expanded',
      (tester) async {
    await tester.pumpWidget(app(compact: true));

    Text text = tester.widget(
      find.byKey(const ValueKey('dictionary-expansion-text')),
    );
    expect(text.maxLines, 2);
    expect(text.overflow, TextOverflow.ellipsis);
    expect(text.style?.fontSize, 14);
    expect(find.text('Show more'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('dictionary-expansion-toggle')));
    await tester.pump();

    text = tester.widget(
      find.byKey(const ValueKey('dictionary-expansion-text')),
    );
    expect(text.maxLines, isNull);
    expect(text.overflow, TextOverflow.visible);
    expect(text.style?.fontSize, 14);
    expect(find.text('Show less'), findsOneWidget);
  });

  testWidgets('full explanation is never truncated', (tester) async {
    await tester.pumpWidget(app(compact: false));

    final text = tester.widget<Text>(
      find.byKey(const ValueKey('dictionary-expansion-text')),
    );
    expect(text.maxLines, isNull);
    expect(text.overflow, TextOverflow.visible);
    expect(text.style?.fontSize, 14);
    expect(find.byKey(const ValueKey('dictionary-expansion-toggle')),
        findsNothing);
  });
}
