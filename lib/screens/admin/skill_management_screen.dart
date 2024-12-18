import 'package:flutter/material.dart';

class SkillManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skill Management'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: 4, // Replace with actual skill count
        itemBuilder: (context, index) {
          return Card(
            child: InkWell(
              onTap: () {
                // Navigate to skill details
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school, size: 48.0),
                  SizedBox(height: 8.0),
                  Text(
                    'Programming',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '24 users',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new skill
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
