import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/session_service.dart';
import '../services/analytics_service.dart';

class SessionWrapper extends StatefulWidget {
  final Widget child;

  const SessionWrapper({Key? key, required this.child}) : super(key: key);

  @override
  _SessionWrapperState createState() => _SessionWrapperState();
}

class _SessionWrapperState extends State<SessionWrapper> with WidgetsBindingObserver {
  DateTime? _lastInteraction;
  bool _showingDialog = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _updateLastInteraction();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkSession();
    }
  }

  void _updateLastInteraction() {
    _lastInteraction = DateTime.now();
    SessionService.updateLastActivity();
  }

  Future<void> _checkSession() async {
    final authProvider = context.read<AuthProvider>();
    if (!authProvider.isAuthenticated) return;

    if (SessionService.isSessionExpired() && !_showingDialog) {
      _showingDialog = true;
      await _showSessionExpiredDialog();
      _showingDialog = false;
    }
  }

  Future<void> _showSessionExpiredDialog() async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Session Expired'),
        content: Text('Your session has expired. Please log in again.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('OK'),
          ),
        ],
      ),
    );

    if (result ?? false) {
      final authProvider = context.read<AuthProvider>();
      if (authProvider.adminUser != null) {
        await AnalyticsService.logAdminAction(
          adminId: authProvider.adminUser!.id,
          action: 'session_expired',
          targetType: 'session',
        );
      }
      await authProvider.signOut();
      Navigator.pushReplacementNamed(context, '/admin/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        _updateLastInteraction();
      },
      child: widget.child,
    );
  }
}
