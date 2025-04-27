import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';

class ShopDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Dashboard', style: Theme.of(context).textTheme.titleLarge),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: const CustomDrawer(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Text(
          'Manage your Shop orders here!',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
