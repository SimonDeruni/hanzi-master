import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanzi_master/core/theme/zen_motion.dart';
import 'package:hanzi_master/shared/widgets/zen_expand.dart';
import 'package:hanzi_master/shared/widgets/zen_loader.dart';

/// Hosts [child] with the platform "Reduce Motion" flag controllable.
///
/// The override goes through `MaterialApp.builder`: `MaterialApp` installs its
/// own `MediaQuery`, so wrapping the app from the outside would be discarded.
Widget _host(Widget child, {bool reduceMotion = false}) => MaterialApp(
      builder: (BuildContext context, Widget? inner) => MediaQuery(
        data: MediaQuery.of(context).copyWith(disableAnimations: reduceMotion),
        child: inner!,
      ),
      home: Scaffold(body: Center(child: child)),
    );

/// Removes `//` comments so documentation about a pattern is not mistaken for
/// a real usage of it.
String _withoutLineComments(String source) => source
    .split('\n')
    .map((String line) {
      final int index = line.indexOf('//');
      return index == -1 ? line : line.substring(0, index);
    })
    .join('\n');

/// The fade wrapper's current opacity inside [ZenLoader].
double _loaderOpacity(WidgetTester tester) => tester
    .widget<Opacity>(find.descendant(
      of: find.byType(ZenLoader),
      matching: find.byType(Opacity),
    ))
    .opacity;

void main() {
  group('ZenLoader', () {
    testWidgets('shows a spinner, and a caption when given one',
        (WidgetTester tester) async {
      await tester.pumpWidget(_host(const ZenLoader(label: 'Thinking')));
      // Not pumpAndSettle: a CircularProgressIndicator animates forever.
      await tester.pump(ZenMotion.quick);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Thinking'), findsOneWidget);
    });

    testWidgets('eases in instead of appearing in a single frame',
        (WidgetTester tester) async {
      await tester.pumpWidget(_host(const ZenLoader()));

      // First frame: still fading, so the spinner is not yet fully visible.
      expect(_loaderOpacity(tester), lessThan(1.0));

      await tester.pump(ZenMotion.quick);
      expect(_loaderOpacity(tester), 1.0);
    });

    testWidgets('is shown immediately under reduced motion',
        (WidgetTester tester) async {
      await tester.pumpWidget(_host(const ZenLoader(), reduceMotion: true));
      await tester.pump();

      // No fade wrapper at all: the child is returned untouched.
      expect(
        find.descendant(
          of: find.byType(ZenLoader),
          matching: find.byType(Opacity),
        ),
        findsNothing,
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('ZenExpand', () {
    testWidgets('grows over time instead of snapping to the new height',
        (WidgetTester tester) async {
      bool expanded = false;
      late StateSetter setInnerState;

      await tester.pumpWidget(_host(StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          setInnerState = setState;
          return ZenExpand(
            child: SizedBox(
              width: 60,
              height: expanded ? 120 : 20,
              child: const Text('x'),
            ),
          );
        },
      )));
      await tester.pumpAndSettle();
      expect(tester.getSize(find.byType(ZenExpand)).height, 20);

      setInnerState(() => expanded = true);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 150));

      // Mid-flight: taller than before, but not yet at its final height.
      final double midway = tester.getSize(find.byType(ZenExpand)).height;
      expect(midway, greaterThan(20));
      expect(midway, lessThan(120));

      await tester.pumpAndSettle();
      expect(tester.getSize(find.byType(ZenExpand)).height, 120);
    });

    testWidgets('resizes instantly under reduced motion',
        (WidgetTester tester) async {
      bool expanded = false;
      late StateSetter setInnerState;

      await tester.pumpWidget(_host(
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            setInnerState = setState;
            return ZenExpand(
              child: SizedBox(
                width: 60,
                height: expanded ? 120 : 20,
                child: const Text('x'),
              ),
            );
          },
        ),
        reduceMotion: true,
      ));
      await tester.pumpAndSettle();

      setInnerState(() => expanded = true);
      await tester.pump();

      // No resize animator at all under reduced motion: the new height applies
      // on the very next frame.
      expect(
        find.descendant(
          of: find.byType(ZenExpand),
          matching: find.byType(AnimatedSize),
        ),
        findsNothing,
      );
      expect(tester.getSize(find.byType(ZenExpand)).height, 120);
    });
  });

  group('Gentle loading guard rail', () {
    test('no bare spinner is placed directly inside a Center', () {
      // Full-section loaders must use ZenLoader so they fade in. Tiny in-button
      // spinners are a different pattern (LoadingSwap) and are not matched here.
      final RegExp bare = RegExp(
        r'Center\(\s*child:\s*(?:const\s+)?CircularProgressIndicator',
      );
      final List<String> offenders = <String>[];
      for (final File file
          in Directory('lib').listSync(recursive: true).whereType<File>()) {
        if (!file.path.endsWith('.dart')) {
          continue;
        }
        final String source = _withoutLineComments(file.readAsStringSync());
        if (bare.hasMatch(source)) {
          offenders.add(file.path);
        }
      }
      expect(
        offenders,
        isEmpty,
        reason: 'Use ZenLoader instead of a bare spinner:\n'
            '${offenders.join('\n')}',
      );
    });
  });
}
