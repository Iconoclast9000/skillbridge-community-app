import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skillbridge_community_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    
    await tester.pumpWidget(SkillBridgeApp(prefs: prefs));
    expect(find.text('Login'), findsOneWidget);
  });
}
