import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/providers/app_language_controller.dart';
import 'package:hanzi_master/core/providers/translation_language_provider.dart';
import 'package:hanzi_master/core/widgets/app_reload_boundary.dart';
import 'package:hanzi_master/features/flashcards/presentation/providers/settings_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _StatefulLanguageContent extends StatefulWidget {
  const _StatefulLanguageContent();

  @override
  State<_StatefulLanguageContent> createState() =>
      _StatefulLanguageContentState();
}

class _StatefulLanguageContentState extends State<_StatefulLanguageContent> {
  var value = 0;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => setState(() => value++),
      child: Text('$value'),
    );
  }
}

void main() {
  test('changing app language also updates the translation target', () async {
    SharedPreferences.setMockInitialValues({
      'app_locale': 'en',
      'translation_target_language': 'Japanese',
    });
    final preferences = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(preferences)],
    );
    addTearDown(container.dispose);

    await container.read(appLanguageControllerProvider).setLanguage('fr');

    expect(container.read(settingsProvider).locale, 'fr');
    expect(container.read(translationLanguageProvider), 'French');
    expect(preferences.getString('app_locale'), 'fr');
    expect(preferences.getString('translation_target_language'), 'French');
  });

  testWidgets('language change recreates stateful application content',
      (tester) async {
    Widget buildApp(String locale) {
      return AppReloadBoundary(
        locale: locale,
        child: const MaterialApp(home: _StatefulLanguageContent()),
      );
    }

    await tester.pumpWidget(buildApp('en'));
    await tester.tap(find.text('0'));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    await tester.pumpWidget(buildApp('fr'));
    await tester.pump();

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
  });
}
