import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AdminDashboardScreen extends StatelessWidget {
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut();
              Navigator.pushReplacementNamed(context, '/admin/login');
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, Admin',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 24),
            _buildDashboardTile(
              context,
              'Manage Users',
              Icons.people,
              () => Navigator.pushNamed(context, '/admin/users'),
            ),
            _buildDashboardTile(
              context,
              'Manage Skills',
              Icons.school,
              () => Navigator.pushNamed(context, '/admin/skills'),
            ),
            _buildDashboardTile(
              context,
              'View Reports',
              Icons.bar_chart,
              () => Navigator.pushNamed(context, '/admin/reports'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardTile(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
