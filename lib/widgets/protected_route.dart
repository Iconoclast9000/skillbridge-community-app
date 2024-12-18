import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class ProtectedRoute extends StatelessWidget {
  final Widget child;
  final AuthService _authService = AuthService();

  ProtectedRoute({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _authService.authStateChanges().map((user) => user != null),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasData && snapshot.data == true) {
          return child;
        }

        // Redirect to login if not authenticated
        return AdminLoginScreen();
      },
    );
  }
}
