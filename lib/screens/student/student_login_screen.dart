import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../widgets/google_sign_in_button.dart';
import '../../services/auth_service.dart';

class StudentLoginScreen extends StatefulWidget {
  @override
  _StudentLoginScreenState createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  final AuthService _authService = AuthService();

  Future<void> _signInAsGuest(BuildContext context) async {
    try {
      await _authService.signInAsGuest();
      Navigator.pushReplacementNamed(context, '/studentHome');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF8F9FA),
              Color(0xFFE9ECEF),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  const SizedBox(height: 30),
                  const Text(
                    'Welcome to Livana',
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
                    'Your one-stop solution for student living',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF2A2A2A),
                      fontWeight: FontWeight.w500,
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GoogleSignInButton(),
                  ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () => _signInAsGuest(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C5CE7),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF6C5CE7).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Text(
                        'Continue as Guest',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
