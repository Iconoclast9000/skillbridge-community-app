import 'package:flutter/material.dart';

class NavigationUtils {
  static Future<void> navigateToEditUser(
    BuildContext context,
    Map<String, dynamic> user,
  ) async {
    await Navigator.pushNamed(
      context,
      '/admin/users/edit/${user['id']}',
      arguments: user,
    );
  }

  static void navigateToAddSkill(BuildContext context) {
    Navigator.pushNamed(context, '/admin/skills/add');
  }

  static void navigateAndReplace(BuildContext context, String route) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      route,
      (route) => false,
    );
  }

  static Future<bool> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    Color? confirmColor,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelLabel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(confirmLabel),
            style: TextButton.styleFrom(
              foregroundColor: confirmColor ?? Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
