import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/utils/definition_formatter.dart';
import 'package:hanzi_master/core/widgets/translated_definition.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('splitMeanings uses semicolons and lines but preserves commas', () {
    expect(
      DefinitionFormatter.splitMeanings(
          'to open, unfold; to turn on\n to make public'),
      ['to open, unfold', 'to turn on', 'to make public'],
    );
  });

  test('splitMeanings preserves legacy plain text as one meaning', () {
    expect(
      DefinitionFormatter.splitMeanings('a single legacy definition'),
      ['a single legacy definition'],
    );
  });

  testWidgets('full detail lists meanings and expands after six',
      (tester) async {
    SharedPreferences.setMockInitialValues({'use_english_definitions': true});
    final preferences = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: TranslatedDefinition(
              definition: 'one; two; three; four; five; six; seven; eight',
              presentation: DefinitionPresentation.fullDetail,
            ),
          ),
        ),
      ),
    );

    expect(find.text('1'), findsOneWidget);
    expect(find.text('six'), findsOneWidget);
    expect(find.text('seven'), findsNothing);
    expect(find.text('Show 2 more meanings'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('definition-expansion-button')));
    await tester.pump();

    expect(find.text('seven'), findsOneWidget);
    expect(find.text('eight'), findsOneWidget);
    expect(find.text('Show fewer'), findsOneWidget);
  });

  testWidgets('plain presentation remains a single text widget',
      (tester) async {
    SharedPreferences.setMockInitialValues({'use_english_definitions': true});
    final preferences = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: TranslatedDefinition(definition: 'one; two; three'),
          ),
        ),
      ),
    );

    expect(find.text('one; two; three'), findsOneWidget);
    expect(find.text('1'), findsNothing);
  });
}
