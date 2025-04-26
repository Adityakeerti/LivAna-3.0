// mess_dashboard_screen.dart
import 'package:flutter/material.dart';

class MessDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mess Dashboard'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text(
          'Manage your Mess orders here!',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
