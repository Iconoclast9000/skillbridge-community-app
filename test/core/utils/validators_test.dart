import 'package:flutter_test/flutter_test.dart';
import 'package:skillbridge_community_app/core/utils/validators.dart';

void main() {
  group('Validators', () {
    group('required', () {
      test('returns error message for null value', () {
        expect(Validators.required(null), 'Field is required');
      });

      test('returns error message for empty string', () {
        expect(Validators.required(''), 'Field is required');
      });

      test('returns null for non-empty string', () {
        expect(Validators.required('value'), null);
      });
    });

    group('email', () {
      test('returns error for invalid email formats', () {
        expect(Validators.email('invalid'), 'Invalid email format');
        expect(Validators.email('test@'), 'Invalid email format');
        expect(Validators.email('test@domain'), 'Invalid email format');
      });

      test('returns null for valid email formats', () {
        expect(Validators.email('test@domain.com'), null);
        expect(Validators.email('user.name@domain.co.uk'), null);
      });
    });

    group('password', () {
      test('validates password requirements', () {
        expect(Validators.password('weak'), 'Password must be at least 8 characters');
        expect(Validators.password('password123'), 'Password must contain at least one uppercase letter');
        expect(Validators.password('Password'), 'Password must contain at least one number');
        expect(Validators.password('Password1'), 'Password must contain at least one special character');
        expect(Validators.password('Password1!'), null);
      });
    });

    group('confirmPassword', () {
      const password = 'Password1!';

      test('validates password match', () {
        expect(Validators.confirmPassword('', password), 'Please confirm your password');
        expect(Validators.confirmPassword('different', password), 'Passwords do not match');
        expect(Validators.confirmPassword(password, password), null);
      });
    });
  });
}
