import 'package:flutter/material.dart';
import '../services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();
  List<Map<String, dynamic>> _users = [];
  bool _loading = false;
  String? _error;

  List<Map<String, dynamic>> get users => _users;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> loadUsers() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _users = await _userService.getUsers();
    } catch (e) {
      _error = 'Failed to load users';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> updateUser(String userId, Map<String, dynamic> data) async {
    try {
      final success = await _userService.updateUser(userId, data);
      if (success) {
        await loadUsers();
      }
      return success;
    } catch (e) {
      _error = 'Failed to update user';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteUser(String userId) async {
    try {
      final success = await _userService.deleteUser(userId);
      if (success) {
        await loadUsers();
      }
      return success;
    } catch (e) {
      _error = 'Failed to delete user';
      notifyListeners();
      return false;
    }
  }
}
