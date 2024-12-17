import 'package:cloud_firestore/cloud_firestore.dart';

class SkillService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getSkills() async {
    try {
      final snapshot = await _firestore.collection('skills').get();
      return snapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data()})
          .toList();
    } catch (e) {
      print('Error fetching skills: $e');
      return [];
    }
  }

  Future<bool> addSkill(Map<String, dynamic> skillData) async {
    try {
      await _firestore.collection('skills').add(skillData);
      return true;
    } catch (e) {
      print('Error adding skill: $e');
      return false;
    }
  }

  Future<bool> updateSkill(String skillId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('skills').doc(skillId).update(data);
      return true;
    } catch (e) {
      print('Error updating skill: $e');
      return false;
    }
  }

  Future<bool> deleteSkill(String skillId) async {
    try {
      await _firestore.collection('skills').doc(skillId).delete();
      return true;
    } catch (e) {
      print('Error deleting skill: $e');
      return false;
    }
  }

  Stream<QuerySnapshot> skillsStream() {
    return _firestore.collection('skills').snapshots();
  }
}
