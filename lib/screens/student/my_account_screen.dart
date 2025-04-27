import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/custom_drawer.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

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
        title: Text(
          'My Account',
          style: TextStyle(
            color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDarkMode ? Colors.white30 : Colors.grey.shade300,
                      width: 2,
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/livana_logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Guest User',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              _buildInfoCard(
                context,
                'Account Information',
                [
                  _buildInfoRow('Email', 'guest@example.com'),
                  _buildInfoRow('Phone', 'Not provided'),
                  _buildInfoRow('Account Type', 'Guest'),
                ],
                isDarkMode,
              ),
              const SizedBox(height: 20),
              _buildInfoCard(
                context,
                'Preferences',
                [
                  _buildInfoRow('Theme', isDarkMode ? 'Dark Mode' : 'Light Mode'),
                  _buildInfoRow('Notifications', 'Enabled'),
                ],
                isDarkMode,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    String title,
    List<Widget> children,
    bool isDarkMode,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
              ),
            ),
            const SizedBox(height: 15),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
} 