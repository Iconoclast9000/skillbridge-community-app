import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import '../providers/skill_provider.dart';
import '../widgets/stats_card.dart';

class AdminDashboardScreen extends StatefulWidget {
  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final userProvider = context.read<UserProvider>();
    final skillProvider = context.read<SkillProvider>();
    await Future.wait([
      userProvider.loadUsers(),
      skillProvider.loadSkills(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadData,
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await context.read<AuthProvider>().signOut();
              Navigator.pushReplacementNamed(context, '/admin/login');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard Overview',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 16),
              Consumer2<UserProvider, SkillProvider>(
                builder: (context, userProvider, skillProvider, child) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: StatsCard(
                              title: 'Total Users',
                              value: userProvider.users.length.toString(),
                              icon: Icons.people,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: StatsCard(
                              title: 'Total Skills',
                              value: skillProvider.skills.length.toString(),
                              icon: Icons.school,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      _buildQuickActions(context),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 16),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.people),
                title: Text('Manage Users'),
                trailing: Icon(Icons.chevron_right),
                onTap: () => Navigator.pushNamed(context, '/admin/users'),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.school),
                title: Text('Manage Skills'),
                trailing: Icon(Icons.chevron_right),
                onTap: () => Navigator.pushNamed(context, '/admin/skills'),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.bar_chart),
                title: Text('View Reports'),
                trailing: Icon(Icons.chevron_right),
                onTap: () => Navigator.pushNamed(context, '/admin/reports'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
