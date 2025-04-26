import 'package:flutter/material.dart';

class ShopDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Dashboard'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text(
          'Manage your Grocery Orders here!',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
