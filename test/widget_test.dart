// AlphaZoo Widget Tests
//
// Basic widget tests for the AlphaZoo app.
// To run tests: flutter test

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:alpha_zoo/main.dart';

void main() {
  testWidgets('AlphaZoo app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AlphaZooApp());

    // Verify that the app starts (splash screen should be visible)
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('AlphaZoo app has correct title', (WidgetTester tester) async {
    await tester.pumpWidget(const AlphaZooApp());

    // Find the MaterialApp widget
    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

    // Verify the app title
    expect(materialApp.title, 'AlphaZoo');
  });
}
