import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';

void main() {
  testWidgets('Basic app test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(SkillBridgeApp());

    // Verify that our app shows the welcome message
    expect(find.text('Welcome to SkillBridge!'), findsOneWidget);

    // Verify that we have an AppBar with the correct title
    expect(find.text('SkillBridge'), findsOneWidget);
  });
}
