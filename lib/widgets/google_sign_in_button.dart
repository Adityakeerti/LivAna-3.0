import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';

class GoogleSignInButton extends StatelessWidget {
  final AuthService _authService = AuthService();

  Future<void> _handleSignIn(BuildContext context) async {
    try {
      final userCredential = await _authService.signInWithGoogle();
      
      if (userCredential == null || userCredential.user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign in was cancelled')),
        );
        return;
      }

      final user = userCredential.user!;
      print('Successfully signed in: ${user.email}');

      // Store user data in Firestore
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': user.email,
          'name': user.displayName,
          'photoUrl': user.photoURL,
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      } catch (e) {
        print('Error storing user data: $e');
        // Continue with navigation even if storing data fails
      }

      // Check if we're in student or business flow
      final isStudentFlow = ModalRoute.of(context)?.settings.name == '/student';
      
      // Navigate to the appropriate screen
      if (isStudentFlow) {
        Navigator.pushReplacementNamed(context, '/studentName');
      } else {
        Navigator.pushReplacementNamed(context, '/businessSelection');
      }
    } catch (e) {
      print('Error during sign in: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing in with Google: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _handleSignIn(context),
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