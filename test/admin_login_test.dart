import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../lib/services/auth_service.dart';
import '../lib/models/admin_user.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
  });

  group('Admin Authentication Tests', () {
    test('successful login returns AdminUser', () async {
      final expectedAdmin = AdminUser(
        id: '1',
        email: 'admin@test.com',
        name: 'Test Admin',
        permissions: ['read', 'write'],
      );

      when(mockAuthService.signInAdmin('admin@test.com', 'password'))
          .thenAnswer((_) async => expectedAdmin);

      final result = await mockAuthService.signInAdmin(
        'admin@test.com',
        'password',
      );

      expect(result, equals(expectedAdmin));
    });

    test('failed login returns null', () async {
      when(mockAuthService.signInAdmin('wrong@email.com', 'wrongpass'))
          .thenAnswer((_) async => null);

      final result = await mockAuthService.signInAdmin(
        'wrong@email.com',
        'wrongpass',
      );

      expect(result, isNull);
    });
  });
}
