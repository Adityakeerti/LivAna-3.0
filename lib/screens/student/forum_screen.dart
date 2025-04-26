import 'package:flutter/material.dart';

class ForumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Forum'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text(
          'Community Discussions will be here.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
