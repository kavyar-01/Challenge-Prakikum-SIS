// Smoke test sederhana untuk alur Splash -> MainScreen -> Keranjang.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tugas_3/main.dart';

void main() {
  testWidgets('Splash lalu tambah ke keranjang', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Lewati splash screen (4 detik).
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    expect(find.text('Espresso'), findsOneWidget);

    // Pesan cepat item pertama.
    await tester.tap(find.text('Pesan').first);
    await tester.pumpAndSettle();

    // Pindah ke tab Keranjang.
    await tester.tap(find.byIcon(Icons.shopping_cart));
    await tester.pumpAndSettle();

    expect(find.text('Espresso'), findsOneWidget);
    expect(find.text('Checkout'), findsOneWidget);
  });
}
