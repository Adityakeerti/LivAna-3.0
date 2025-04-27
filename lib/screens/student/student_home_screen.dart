import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/custom_drawer.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({Key? key}) : super(key: key);

  @override
  _StudentHomeScreenState createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
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

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFF8F9FA),
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDarkMode
                ? [const Color(0xFF1A1A1A), const Color(0xFF2A2A2A)]
                : [const Color(0xFFF8F9FA), const Color(0xFFE9ECEF)],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/livana_logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ).animate().fadeIn(duration: 600.ms).scale(),
                const SizedBox(height: 20),
                Text(
                  'Welcome to LivAna',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                    shadows: [
                      Shadow(
                        color: isDarkMode ? Colors.black26 : Colors.white,
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 600.ms).slideY(),
                const SizedBox(height: 20),
                Text(
                  'Your one-stop solution for student living',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.white70 : const Color(0xFF2A2A2A),
                    fontWeight: FontWeight.w500,
                  ),
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
                const SizedBox(height: 30),
                Text(
                  'Choose Your Service',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                    shadows: [
                      Shadow(
                        color: isDarkMode ? Colors.black26 : Colors.white,
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3),
                const SizedBox(height: 20),
                _buildServiceCard(
                  context,
                  'PGs',
                  Icons.home_work,
                  'Find the perfect PG accommodation',
                  '/pgs',
                  [const Color(0xFFFF6B6B), const Color(0xFFFF8E8E)],
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.4),
                const SizedBox(height: 20),
                _buildServiceCard(
                  context,
                  'Mess',
                  Icons.restaurant,
                  'Discover nearby mess facilities',
                  '/mess',
                  [const Color(0xFF4ECDC4), const Color(0xFF45B7AF)],
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.5),
                const SizedBox(height: 20),
                _buildServiceCard(
                  context,
                  'Grocery Store',
                  Icons.shopping_cart,
                  'Shop for daily essentials',
                  '/grocery',
                  [const Color(0xFFFFD166), const Color(0xFFFFB700)],
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.6),
                const SizedBox(height: 20),
                _buildServiceCard(
                  context,
                  'Forum',
                  Icons.forum,
                  'Join student discussions and share experiences',
                  '/forum',
                  [const Color(0xFF9B5DE5), const Color(0xFF7B2CBF)],
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.7),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
