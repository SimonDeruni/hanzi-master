/// iPad-size sweep for the adaptive kit (F9.1 of `docs/IPAD_ADAPTIVE_PLAN.md`).
///
/// Tagged `ipad-sweep`: the per-change gate stays the fast phone matrix, while
/// CI can run this (and Phase 3 will move the real screens onto it). It exists
/// because the harness used to ignore its viewports entirely — see the harness
/// comment — so "green" proved 800x600 and nothing else.
@Tags(<String>['ipad-sweep'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/layout/zen_adaptive_scaffold.dart';
import 'package:hanzi_master/core/layout/zen_layout.dart';
import 'package:hanzi_master/core/layout/zen_two_pane.dart';

import '../support/locale_layout_harness.dart';

/// The longest realistic labels, in the languages that expand the most.
const Map<String, List<String>> _labels = <String, List<String>>{
  'de': <String>['Übersicht', 'Bibliothek', 'Wörterbuch', 'Zeichenübung'],
  'ru': <String>['Обзор', 'Библиотека', 'Словарь', 'Упражнение'],
  'th': <String>['ภาพรวม', 'ห้องสมุด', 'พจนานุกรม', 'แบบฝึกหัด'],
};

Widget _railShell(String locale) {
  final List<String> labels = _labels[locale] ?? _labels['de']!;
  return Scaffold(
    body: Row(
      children: <Widget>[
        ZenNavigationRail(
          destinations: <ZenDestination>[
            for (final String label in labels)
              ZenDestination(
                icon: Icons.home_outlined,
                selectedIcon: Icons.home,
                label: label,
              ),
          ],
          selectedIndex: 0,
          onDestinationSelected: (_) {},
          footer: const Icon(Icons.play_arrow),
        ),
        Expanded(
          child: ZenContentPane(
            maxWidth: ZenContentWidth.reading,
            child: ListView(
              children: <Widget>[
                for (final String label in labels)
                  ListTile(title: Text(label), subtitle: Text(label)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _twoPaneShell(String locale) {
  final List<String> labels = _labels[locale] ?? _labels['de']!;
  return Scaffold(
    body: ZenTwoPaneScaffold(
      listPane: ListView(
        children: <Widget>[
          for (final String label in labels) ListTile(title: Text(label)),
        ],
      ),
      detailPane: ZenContentPane(
        maxWidth: ZenContentWidth.form,
        child: Column(
          children: <Widget>[
            for (final String label in labels) Text(label),
          ],
        ),
      ),
      emptyDetail: const Text('—'),
    ),
  );
}

void main() {
  group('adaptive kit at iPad sizes', () {
    testWidgets('the rail shell holds up on every iPad viewport',
        (WidgetTester tester) async {
      await expectNoOverflowAcrossLocales(
        tester,
        (BuildContext context) =>
            _railShell(Localizations.localeOf(context).languageCode),
        locales: const <String>['de', 'ru', 'th'],
        viewports: kIpadViewports,
      );
    });

    testWidgets('the two-pane shell holds up on every iPad viewport',
        (WidgetTester tester) async {
      await expectNoOverflowAcrossLocales(
        tester,
        (BuildContext context) =>
            _twoPaneShell(Localizations.localeOf(context).languageCode),
        locales: const <String>['de', 'ru', 'th'],
        viewports: kIpadViewports,
      );
    });

    testWidgets('the phone shell still holds up in landscape',
        (WidgetTester tester) async {
      await expectNoOverflowAcrossLocales(
        tester,
        (BuildContext context) =>
            _railShell(Localizations.localeOf(context).languageCode),
        locales: const <String>['de', 'ru', 'th'],
        viewports: kLandscapePhoneViewports,
      );
    });
  });
}
