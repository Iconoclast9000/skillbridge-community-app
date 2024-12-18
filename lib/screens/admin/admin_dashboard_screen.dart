import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/auth/admin_auth_controller.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await context.read<AdminAuthController>().logout();
              Navigator.pushReplacementNamed(context, '/admin/login');
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: [
          _AdminDashboardCard(
            title: 'Users',
            icon: Icons.people,
            onTap: () => Navigator.pushNamed(context, '/admin/users'),
          ),
          _AdminDashboardCard(
            title: 'Skills',
            icon: Icons.school,
            onTap: () => Navigator.pushNamed(context, '/admin/skills'),
          ),
          _AdminDashboardCard(
            title: 'Reports',
            icon: Icons.assessment,
            onTap: () => Navigator.pushNamed(context, '/admin/reports'),
          ),
          _AdminDashboardCard(
            title: 'Settings',
            icon: Icons.settings,
            onTap: () => Navigator.pushNamed(context, '/admin/settings'),
          ),
        ],
      ),
    );
  }
}

class _AdminDashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _AdminDashboardCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48),
            const SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
