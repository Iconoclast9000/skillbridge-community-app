import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthMiddleware {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<bool> isValidAdmin(String uid) async {
    try {
      final adminDoc = await _firestore
          .collection('admins')
          .doc(uid)
          .get();
      
      if (!adminDoc.exists) {
        return false;
      }

      final lastLoginUpdate = await _firestore
          .collection('admin_logs')
          .doc(uid)
          .set({
        'lastLogin': FieldValue.serverTimestamp(),
        'deviceInfo': await _getDeviceInfo(),
      }, SetOptions(merge: true));

      return true;
    } catch (e) {
      print('Error checking admin status: $e');
      return false;
    }
  }

  static Future<Map<String, dynamic>> _getDeviceInfo() async {
    // Implementation for getting device info
    return {
      'timestamp': DateTime.now().toIso8601String(),
      'platform': 'mobile', // This should be dynamic based on platform
    };
  }

  static Future<void> logAdminAction({
    required String adminId,
    required String action,
    required String targetType,
    required String targetId,
    Map<String, dynamic>? additionalInfo,
  }) async {
    try {
      await _firestore.collection('admin_actions').add({
        'adminId': adminId,
        'action': action,
        'targetType': targetType,
        'targetId': targetId,
        'timestamp': FieldValue.serverTimestamp(),
        'info': additionalInfo,
      });
    } catch (e) {
      print('Error logging admin action: $e');
    }
  }

  static Stream<DocumentSnapshot> adminStatusStream(String uid) {
    return _firestore.collection('admins').doc(uid).snapshots();
  }
}
