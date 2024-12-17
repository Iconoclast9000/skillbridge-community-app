import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/admin_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream of auth state changes
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  // Get current user
  User? get currentUser => _auth.currentUser;

  Future<AdminUser?> signInAdmin(String email, String password) async {
    try {
      // Sign in with email and password
      final UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? user = result.user;

      if (user == null) return null;

      // Check if user is an admin
      final adminDoc = await _firestore.collection('admins').doc(user.uid).get();
      
      if (!adminDoc.exists) {
        await _auth.signOut(); // Sign out if not an admin
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
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
      throw e;
    }
  }

  // Check if user has admin access
  Future<bool> hasAdminAccess() async {
    final user = currentUser;
    if (user == null) return false;

    try {
      final adminDoc = await _firestore.collection('admins').doc(user.uid).get();
      return adminDoc.exists;
    } catch (e) {
      print('Error checking admin access: $e');
      return false;
    }
  }
}
