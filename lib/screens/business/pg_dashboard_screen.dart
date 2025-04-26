import 'package:flutter/material.dart';

class PgDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PG Dashboard'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text(
          'Manage your PG rooms here!',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
