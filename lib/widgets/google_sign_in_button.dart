import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class GoogleSignInButton extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          final userCredential = await _authService.signInWithGoogle();
          if (userCredential != null && userCredential.user != null) {
            print('Successfully signed in: ${userCredential.user?.email}');
            // Check if we're in student or business flow
            final isStudentFlow = ModalRoute.of(context)?.settings.name == '/student';
            // Navigate to the appropriate name input screen
            Navigator.pushReplacementNamed(
              context,
              isStudentFlow ? '/studentName' : '/businessName',
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Sign in was cancelled')),
            );
          }
        } catch (e) {
          print('Error during sign in: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error signing in with Google: ${e.toString()}')),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/google_logo.png',
            height: 24,
          ),
          SizedBox(width: 12),
          Text(
            'Sign in with Google',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
} 