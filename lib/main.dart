import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences.dart';
import 'features/auth/admin_auth_controller.dart';
import 'screens/admin/admin_login_screen.dart';
import 'screens/admin/admin_dashboard_screen.dart';
import 'core/middleware/admin_auth_middleware.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AdminAuthController(prefs),
        ),
      ],
      child: MaterialApp(
        title: 'SkillBridge Community',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        navigatorObservers: [
          AdminAuthMiddleware(
            authController: Provider.of<AdminAuthController>(
              context,
              listen: false,
            ),
          ),
        ],
        routes: {
          '/admin/login': (context) => const AdminLoginScreen(),
          '/admin/dashboard': (context) => const AdminDashboardScreen(),
        },
        initialRoute: '/admin/login',
      ),
    );
  }
}
