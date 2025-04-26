import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ServiceSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      appBar: AppBar(
        title: const Text(
          'Select Service',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Your Service',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ).animate().fadeIn(duration: 600.ms).slideY(),
              const SizedBox(height: 20),
              const Text(
                'Select from our range of services to get started',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurple,
                ),
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
              const SizedBox(height: 30),
              _buildServiceCard(
                context,
                'PGs',
                Icons.home_work,
                'Find the perfect PG accommodation',
                '/pgs',
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3),
              const SizedBox(height: 20),
              _buildServiceCard(
                context,
                'Mess',
                Icons.restaurant,
                'Discover nearby mess facilities',
                '/mess',
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.4),
              const SizedBox(height: 20),
              _buildServiceCard(
                context,
                'Grocery Store',
                Icons.shopping_cart,
                'Shop for daily essentials',
                '/grocery',
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.5),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String title, IconData icon, String description, String route) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.deepPurple.withOpacity(0.1),
                Colors.white,
              ],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Colors.deepPurple.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
