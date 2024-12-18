import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences.dart';
import 'package:skillbridge_community_app/features/auth/admin_auth_controller.dart';
import 'package:skillbridge_community_app/screens/admin/admin_login_screen.dart';

void main() {
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });

  testWidgets('AdminLoginScreen shows login form', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => AdminAuthController(prefs),
          child: const AdminLoginScreen(),
        ),
      ),
    );

    expect(find.text('Admin Login'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
});
