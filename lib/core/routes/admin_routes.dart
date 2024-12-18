import 'package:flutter/material.dart';
import '../../screens/admin/admin_login_screen.dart';
import '../../screens/admin/admin_dashboard_screen.dart';
import '../../screens/admin/change_password_screen.dart';

class AdminRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/admin/login': (context) => const AdminLoginScreen(),
    '/admin/dashboard': (context) => const AdminDashboardScreen(),
    '/admin/change-password': (context) => const ChangePasswordScreen(),
  };
}
