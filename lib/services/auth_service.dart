import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/admin_user.dart';
import '../middleware/data_middleware.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<AdminUser?> signInAdmin(String email, String password) async {
    try {
      final credentials = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credentials.user;

      if (user == null) return null;

      final adminDoc = await _firestore.collection('admins').doc(user.uid).get();
      
      if (!adminDoc.exists) {
        await _auth.signOut();
        return null;
      }

      return AdminUser(
        id: user.uid,
        email: user.email ?? '',
        name: adminDoc.get('name') ?? 'Admin User',
        permissions: List<String>.from(adminDoc.get('permissions') ?? []),
      );
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print('Error resetting password: $e');
      return false;
    }
  }
}
