import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/presentation/widgets/hanzi_text_field.dart';
import 'package:hanzi_master/core/theme/app_theme.dart';
import 'package:hanzi_master/features/echo_hall/presentation/widgets/custom_scenario_dialog.dart';
import 'package:hanzi_master/l10n/app_localizations.dart';

/// Guards the book-screen parity of the scenario creator.
///
/// The creator used to speak its own dialect: an amber `#FFB300` seal tile and
/// difficulty pills, `#FFD54F`/`#B8860B` inline links, borderless black-tinted
/// fields at radius 16, an elevated radius-16 primary button with a bare
/// `CircularProgressIndicator`, and grey `SnackBar`s that render *behind* the
/// modal barrier. These guards keep it on the shared vocabulary.
void main() {
  const parchmentFill = Color(0xFFF7F3E9); // AppTheme's Xuan-paper row fill.
  final hairline = Colors.black.withValues(alpha: 0.08);

  Future<void> pumpSheet(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(430, 1100));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          locale: const Locale('en'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: CustomScenarioDialog()),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('fields wear the parchment fill and the book-screen radius',
      (tester) async {
    await pumpSheet(tester);

    final fields =
        tester.widgetList<HanziTextField>(find.byType(HanziTextField)).toList();
    expect(fields.length, 3, reason: 'Topic, context and persona');

    for (final field in fields) {
      final decoration = field.decoration!;
      expect(decoration.filled, isTrue);
      expect(decoration.fillColor, parchmentFill,
          reason: 'Book and deck screens fill inputs with parchment, not a '
              'black-tinted box');
      final border = decoration.enabledBorder! as OutlineInputBorder;
      expect(border.borderRadius, BorderRadius.circular(14));
      expect(border.borderSide.color, hairline,
          reason: 'Book cards and fields carry a hairline');
    }
  });

  testWidgets('the selected difficulty wears the accent, the rest are cards',
      (tester) async {
    await pumpSheet(tester);

    final segments = tester
        .widgetList<AnimatedContainer>(find.byType(AnimatedContainer))
        .toList();
    expect(segments.length, 4,
        reason: 'Beginner, Intermediate, Advanced and Native');

    for (var index = 0; index < segments.length; index++) {
      final decoration = segments[index].decoration! as BoxDecoration;
      final borderColor = (decoration.border! as Border).top.color;
      if (index == 1) {
        // `_difficultyIndex` starts on Intermediate.
        expect(decoration.color, AppTheme.accentLight.withValues(alpha: 0.12));
        expect(borderColor, AppTheme.accentLight);
      } else {
        expect(decoration.color, parchmentFill);
        expect(borderColor, hairline);
      }
    }
  });

  testWidgets('the primary action is the book-screen button family',
      (tester) async {
    await pumpSheet(tester);

    final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
    final style = button.style!;
    expect(style.backgroundColor!.resolve(<WidgetState>{}),
        AppTheme.carbonInkLight,
        reason: 'Deep Carbon Ink in light mode');
    expect(style.elevation!.resolve(<WidgetState>{}), 0);
    expect(
      (style.shape!.resolve(<WidgetState>{})! as RoundedRectangleBorder)
          .borderRadius,
      BorderRadius.circular(14),
    );
  });

  test('no foreign palette, Material feedback or bare spinner survives', () {
    // `//` comments are stripped first: documenting an idiom is not using it,
    // the same rule the locale-layout guard applies.
    final source = File(
      'lib/features/echo_hall/presentation/widgets/custom_scenario_dialog.dart',
    ).readAsStringSync().split('\n').map((String line) {
      final int index = line.indexOf('//');
      return index == -1 ? line : line.substring(0, index);
    }).join('\n');

    for (final literal in const ['0xFFFFB300', '0xFFFFD54F', '0xFFB8860B']) {
      expect(source, isNot(contains(literal)),
          reason: '$literal is not part of the Zen & Ink palette');
    }
    expect(source, isNot(contains('showSnackBar')),
        reason: 'A SnackBar renders behind the modal barrier: use ZenToast');
    expect(source, isNot(contains('CircularProgressIndicator')),
        reason: 'Use LoadingSwap so the label never shifts');
    expect(source, contains('ZenToast.'),
        reason: 'Feedback floats on ZenToast');
    expect(source, contains('LoadingSwap('));
    expect(source, contains('class _InkPalette'),
        reason: 'One palette, resolved from AppTheme');

    // The persona the user invents gets no portrait either: only the voice is
    // taken from `pickAvatarAndVoice`, never the stock `assets/mascot/...` face.
    expect(source, contains('avatarAssetPath: ConversationScenario.noAvatar'),
        reason: 'A user-written persona must not wear an image that already '
            'exists');
    expect(source, isNot(contains('pickedAvatar')),
        reason: 'Only the voice is taken from pickAvatarAndVoice');
  });
}
