import 'package:flutter/material.dart';
import '../screens/admin_login_screen.dart';
import '../screens/admin_dashboard_screen.dart';
import '../screens/admin/user_management_screen.dart';
import '../screens/admin/skill_management_screen.dart';
import '../screens/admin/reports_screen.dart';
import '../screens/admin/add_skill_screen.dart';
import '../screens/admin/edit_user_screen.dart';
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
    '/admin/skills/add': (context) => ProtectedRoute(
          child: AddSkillScreen(),
        ),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name?.startsWith('/admin/users/edit/') ?? false) {
      final userId = settings.name!.split('/').last;
      final arguments = settings.arguments as Map<String, dynamic>?;
      
      if (arguments != null) {
        return MaterialPageRoute(
          builder: (context) => ProtectedRoute(
            child: EditUserScreen(user: arguments),
          ),
          settings: settings,
        );
      }
    }
    return null;
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red),
                SizedBox(height: 16),
                Text(
                  'Page not found',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 8),
                Text(
                  'The requested page does not exist.',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/admin/dashboard',
                    (route) => false,
                  ),
                  child: Text('Go to Dashboard'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
