import 'package:flutter/material.dart';
import '../services/skill_service.dart';

class SkillProvider extends ChangeNotifier {
  final SkillService _skillService = SkillService();
  List<Map<String, dynamic>> _skills = [];
  bool _loading = false;
  String? _error;

  List<Map<String, dynamic>> get skills => _skills;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> loadSkills() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _skills = await _skillService.getSkills();
    } catch (e) {
      _error = 'Failed to load skills';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> addSkill(Map<String, dynamic> skillData) async {
    try {
      final success = await _skillService.addSkill(skillData);
      if (success) {
        await loadSkills();
      }
      return success;
    } catch (e) {
      _error = 'Failed to add skill';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateSkill(String skillId, Map<String, dynamic> data) async {
    try {
      final success = await _skillService.updateSkill(skillId, data);
      if (success) {
        await loadSkills();
      }
      return success;
    } catch (e) {
      _error = 'Failed to update skill';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteSkill(String skillId) async {
    try {
      final success = await _skillService.deleteSkill(skillId);
      if (success) {
        await loadSkills();
      }
      return success;
    } catch (e) {
      _error = 'Failed to delete skill';
      notifyListeners();
      return false;
    }
  }
}
