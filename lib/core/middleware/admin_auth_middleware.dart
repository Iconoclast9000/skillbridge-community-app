import 'package:flutter/material.dart';
import '../../features/auth/admin_auth_controller.dart';

class AdminAuthMiddleware extends RouteObserver<PageRoute<dynamic>> {
  final AdminAuthController authController;
  final String loginRoute;
  final List<String> protectedRoutes;

  AdminAuthMiddleware({
    required this.authController,
    this.loginRoute = '/admin/login',
    this.protectedRoutes = const ['/admin/dashboard'],
  });

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _checkAuth(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) _checkAuth(newRoute);
  }

  void _checkAuth(Route<dynamic> route) {
    if (route is PageRoute &&
        protectedRoutes.contains(route.settings.name) &&
        !authController.isAuthenticated) {
      Navigator.of(route.navigator!.context)
          .pushReplacementNamed(loginRoute);
    }
  }
}
