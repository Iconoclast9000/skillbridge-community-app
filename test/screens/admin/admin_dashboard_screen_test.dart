import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences.dart';
import 'package:skillbridge_community_app/features/auth/admin_auth_controller.dart';
import 'package:skillbridge_community_app/screens/admin/admin_dashboard_screen.dart';

void main() {
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });

  testWidgets('AdminDashboardScreen shows all menu items',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => AdminAuthController(prefs),
          child: const AdminDashboardScreen(),
        ),
      ),
    );

    expect(find.text('Admin Dashboard'), findsOneWidget);
    expect(find.text('Users'), findsOneWidget);
    expect(find.text('Skills'), findsOneWidget);
    expect(find.text('Reports'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });

  testWidgets('Logout button is present', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => AdminAuthController(prefs),
          child: const AdminDashboardScreen(),
        ),
      ),
    );

    expect(find.byIcon(Icons.logout), findsOneWidget);
  });
});
