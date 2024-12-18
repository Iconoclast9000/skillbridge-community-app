import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Reports'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Users'),
              Tab(text: 'Skills'),
              Tab(text: 'Activity'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildUserStats(),
            _buildSkillStats(),
            _buildActivityStats(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserStats() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Users',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '1,234',
                    style: TextStyle(fontSize: 36),
                  ),
                ],
              ),
            ),
          ),
          // Add more user statistics
        ],
      ),
    );
  }

  Widget _buildSkillStats() {
    return Center(child: Text('Skill statistics coming soon'));
  }

  Widget _buildActivityStats() {
    return Center(child: Text('Activity statistics coming soon'));
  }
}
