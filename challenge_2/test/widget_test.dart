import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:challenge_2/main.dart';

void main() {
  testWidgets('menu opens, closes, and handles menu actions', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byKey(const ValueKey('open-menu')));
    await tester.pumpAndSettle();
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Log Out'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('close-menu')));
    await tester.pumpAndSettle();
    expect(find.text('Settings'), findsNothing);

    await tester.tap(find.byKey(const ValueKey('open-menu')));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(10, 200));
    await tester.pumpAndSettle();
    expect(find.text('Settings'), findsNothing);

    await tester.tap(find.byKey(const ValueKey('open-menu')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Settings selected'), findsOneWidget);
    expect(find.text('Menu'), findsNothing);
  });

  testWidgets('content tabs update selected content', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    final initialGrid = tester.widget<GridView>(
      find.byKey(const ValueKey(ProfileTab.posts)),
    );
    expect(initialGrid.childrenDelegate.estimatedChildCount, 12);

    await tester.tap(find.byKey(const ValueKey('profile-tab-saved')));
    await tester.pumpAndSettle();
    final savedGrid = tester.widget<GridView>(
      find.byKey(const ValueKey(ProfileTab.saved)),
    );
    expect(savedGrid.childrenDelegate.estimatedChildCount, 6);

    await tester.tap(find.byKey(const ValueKey('profile-tab-tagged')));
    await tester.pumpAndSettle();
    final taggedGrid = tester.widget<GridView>(
      find.byKey(const ValueKey(ProfileTab.tagged)),
    );
    expect(taggedGrid.childrenDelegate.estimatedChildCount, 4);
  });
}
