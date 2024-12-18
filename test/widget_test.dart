import 'package:flutter_test/flutter_test.dart';
import 'package:skillbridge_community_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Welcome to SkillBridge'), findsOneWidget);
  });
}
