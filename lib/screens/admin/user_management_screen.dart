import 'package:flutter/material.dart';

class UserManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Management'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text('JD'),
              ),
              title: Text('John Doe'),
              subtitle: Text('john.doe@example.com'),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit'),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete'),
                  ),
                ],
                onSelected: (value) {
                  // Handle menu item selection
                },
              ),
            ),
          ),
          // Add more user cards here
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new user
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
