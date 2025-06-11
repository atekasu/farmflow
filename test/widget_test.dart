// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:farmflow/main.dart';

void main() {
  testWidgets('Home screen renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Verify the home screen contents.
    expect(find.text('Welcome to the Home Screen!'), findsOneWidget);
    expect(find.text('Go to Details'), findsOneWidget);
  });
}
