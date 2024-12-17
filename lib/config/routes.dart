import 'package:flutter/material.dart';
import '../screens/admin_login_screen.dart';
import '../screens/admin_dashboard_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/admin/login': (context) => AdminLoginScreen(),
    '/admin/dashboard': (context) => AdminDashboardScreen(),
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
