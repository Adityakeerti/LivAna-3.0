import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class BusinessFormLandingScreen extends StatefulWidget {
  final String businessType;

  BusinessFormLandingScreen({required this.businessType});

  @override
  _BusinessFormLandingScreenState createState() => _BusinessFormLandingScreenState();
}

class _BusinessFormLandingScreenState extends State<BusinessFormLandingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);
    
    _colorAnimation = ColorTween(
      begin: Colors.deepPurple.shade50,
      end: Colors.blue.shade50,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _colorAnimation.value,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage('assets/images/livana_logo.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ).animate().fadeIn(duration: 600.ms).scale(),
                    SizedBox(height: 30),
                    Text(
                      'Complete Your ${widget.businessType} Registration',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ).animate().fadeIn(duration: 600.ms).slideY(),
                    SizedBox(height: 20),
                    Text(
                      'Please fill out the form to complete your registration process. This will help us understand your business better and provide you with the best services.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurple.shade700,
                      ),
                    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
                    SizedBox(height: 40),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () async {
                          const url = 'https://docs.google.com/forms/d/e/1FAIpQLScBSsRexSk-dzmQqv9KjAf4pI3Xeekf3E_U2ayqAMz_53J7Ew/viewform?usp=sharing';
                          try {
                            await launchUrl(
                              Uri.parse(url),
                              mode: LaunchMode.externalApplication,
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Could not open the form: $e')),
                            );
                          }
                        },
                        child: Text(
                          'Open Registration Form',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
} 