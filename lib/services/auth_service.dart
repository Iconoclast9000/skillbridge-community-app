import 'package:firebase_auth/firebase_auth.dart';
import '../models/admin_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AdminUser?> signInAdmin(String email, String password) async {
    try {
      // Sign in with email and password
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = result.user;

      if (user == null) return null;

      // Here you would typically check if the user has admin privileges
      // For testing purposes, we'll create a mock admin user
      return AdminUser(
        id: user.uid,
        email: user.email ?? '',
        name: user.displayName ?? 'Admin User',
        permissions: ['read', 'write', 'manage_users'],
      );
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
