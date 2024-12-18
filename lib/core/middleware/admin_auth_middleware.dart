import 'package:flutter/material.dart';
import '../../features/auth/admin_auth_controller.dart';

class AdminAuthMiddleware extends RouteObserver<PageRoute<dynamic>> {
  final AdminAuthController authController;
  final String loginRoute;

  AdminAuthMiddleware({
    required this.authController,
    this.loginRoute = '/admin/login',
  });

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _checkAuth(route);
  }

  void _checkAuth(Route<dynamic> route) {
    if (route is PageRoute &&
        route.settings.name?.startsWith('/admin') == true &&
        route.settings.name != loginRoute &&
        !authController.isAuthenticated) {
      route.navigator?.pushReplacementNamed(loginRoute);
    }
  }
}
