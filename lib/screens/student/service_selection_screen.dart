import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ServiceSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Select Service',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF2A2A2A),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF5F5F5),
              Color(0xFFE0E0E0),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose Your Service',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2A2A2A),
                    shadows: [
                      Shadow(
                        color: Colors.white,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 600.ms).slideY(),
                const SizedBox(height: 20),
                const Text(
                  'Select from our range of services to get started',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF2A2A2A),
                    fontWeight: FontWeight.w500,
                  ),
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
                const SizedBox(height: 30),
                _buildServiceCard(
                  context,
                  'PGs',
                  Icons.home_work,
                  'Find the perfect PG accommodation',
                  '/pgs',
                  [const Color(0xFFFF6B6B), const Color(0xFFFF8E8E)],
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3),
                const SizedBox(height: 20),
                _buildServiceCard(
                  context,
                  'Mess',
                  Icons.restaurant,
                  'Discover nearby mess facilities',
                  '/mess',
                  [const Color(0xFF4ECDC4), const Color(0xFF45B7AF)],
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.4),
                const SizedBox(height: 20),
                _buildServiceCard(
                  context,
                  'Grocery Store',
                  Icons.shopping_cart,
                  'Shop for daily essentials',
                  '/grocery',
                  [const Color(0xFFFFD166), const Color(0xFFFFB700)],
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    String title,
    IconData icon,
    String description,
    String route,
    List<Color> gradientColors,
  ) {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(25),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: gradientColors[0].withOpacity(0.5),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: Colors.white,
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
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
