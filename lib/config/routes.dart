import 'package:flutter/material.dart';
import '../screens/admin_login_screen.dart';
import '../screens/admin_dashboard_screen.dart';
import '../screens/admin/user_management_screen.dart';
import '../screens/admin/skill_management_screen.dart';
import '../screens/admin/reports_screen.dart';
import '../widgets/protected_route.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/admin/login': (context) => AdminLoginScreen(),
    '/admin/dashboard': (context) => ProtectedRoute(
          child: AdminDashboardScreen(),
        ),
    '/admin/users': (context) => ProtectedRoute(
          child: UserManagementScreen(),
        ),
    '/admin/skills': (context) => ProtectedRoute(
          child: SkillManagementScreen(),
        ),
    '/admin/reports': (context) => ProtectedRoute(
          child: ReportsScreen(),
        ),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // Add any dynamic route handling here
    return null;
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Text('Page not found'),
        ),
      ),
    );
  }
}
