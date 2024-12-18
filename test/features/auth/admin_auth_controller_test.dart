import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences.dart';
import 'package:skillbridge_community_app/features/auth/admin_auth_controller.dart';

void main() {
  late AdminAuthController authController;
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    authController = AdminAuthController(prefs);
  });

  group('AdminAuthController', () {
    test('initial state is not authenticated', () {
      expect(authController.isAuthenticated, false);
    });

    test('login with correct credentials succeeds', () async {
      final result = await authController.login('admin', 'admin123');
      expect(result, true);
      expect(authController.isAuthenticated, true);
    });

    test('login with incorrect credentials fails', () async {
      final result = await authController.login('wrong', 'wrong');
      expect(result, false);
      expect(authController.isAuthenticated, false);
    });

    test('logout sets authenticated to false', () async {
      await authController.login('admin', 'admin123');
      await authController.logout();
      expect(authController.isAuthenticated, false);
    });
  });
}
