import 'package:flutter/material.dart';

void main() {
  runApp(SkillBridgeApp());
}

class SkillBridgeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkillBridge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SkillBridge'),
      ),
      body: Center(
        child: Text('Welcome to SkillBridge!'),
      ),
    );
  }
}