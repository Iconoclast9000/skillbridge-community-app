import 'package:flutter/material.dart';
import '../../screens/admin/admin_login_screen.dart';
import '../../screens/admin/admin_dashboard_screen.dart';

class AdminRoutes {
  static Map<String, WidgetBuilder> get routes => {
        '/admin/login': (context) => const AdminLoginScreen(),
        '/admin/dashboard': (context) => const AdminDashboardScreen(),
      };
}
