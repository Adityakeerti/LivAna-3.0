import 'package:flutter/material.dart';

class GroceryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grocery Stores'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text(
          'Available Grocery Shops will be shown here.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
