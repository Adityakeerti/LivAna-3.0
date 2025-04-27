import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Drawer(
      backgroundColor: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF6C5CE7),
                  const Color(0xFF6C5CE7).withOpacity(0.8),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/livana_logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'LivAna',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
            ),
            title: Text(
              'My Account',
              style: TextStyle(
                color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/myAccount');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/studentHome');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.forum,
              color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
            ),
            title: Text(
              'Forum',
              style: TextStyle(
                color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/forum');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.help_outline,
              color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
            ),
            title: Text(
              'Help & Support',
              style: TextStyle(
                color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
              ),
            ),
            onTap: () {
              // Navigate to help & support screen
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.info_outline,
              color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
            ),
            title: Text(
              'FAQ',
              style: TextStyle(
                color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
              ),
            ),
            onTap: () {
              // Navigate to FAQ screen
              Navigator.pop(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
            ),
            title: Text(
              isDarkMode ? 'Light Mode' : 'Dark Mode',
              style: TextStyle(
                color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
              ),
            ),
            onTap: () {
              themeProvider.toggleTheme();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                color: isDarkMode ? Colors.white : const Color(0xFF2A2A2A),
              ),
            ),
            onTap: () {
              // Handle logout
              Navigator.pushReplacementNamed(context, '/student');
            },
          ),
        ],
      ),
    );
  }
} 