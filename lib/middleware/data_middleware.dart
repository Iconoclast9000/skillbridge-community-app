import 'package:cloud_firestore/cloud_firestore.dart';

class DataMiddleware {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<bool> validateUserData(Map<String, dynamic> userData) async {
    // Basic validation rules
    if (!userData.containsKey('email') || 
        !userData.containsKey('name') ||
        userData['email'].toString().isEmpty ||
        userData['name'].toString().isEmpty) {
      return false;
    }

    // Email format validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(userData['email'].toString())) {
      return false;
    }

    // Check for duplicate email
    final existingUser = await _firestore
        .collection('users')
        .where('email', isEqualTo: userData['email'])
        .get();

    return existingUser.docs.isEmpty;
  }

  static Future<bool> validateSkillData(Map<String, dynamic> skillData) async {
    // Basic validation rules
    if (!skillData.containsKey('name') ||
        !skillData.containsKey('description') ||
        skillData['name'].toString().isEmpty ||
        skillData['description'].toString().isEmpty) {
      return false;
    }

    // Check for duplicate skill name
    final existingSkill = await _firestore
        .collection('skills')
        .where('name', isEqualTo: skillData['name'])
        .get();

    return existingSkill.docs.isEmpty;
  }

  static Future<void> sanitizeData(Map<String, dynamic> data) async {
    // Remove any null values
    data.removeWhere((key, value) => value == null);

    // Trim string values
    data.forEach((key, value) {
      if (value is String) {
        data[key] = value.trim();
      }
    });

    // Convert timestamps to proper format
    data.forEach((key, value) {
      if (value is DateTime) {
        data[key] = Timestamp.fromDate(value);
      }
    });
  }
}
