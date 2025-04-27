import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/custom_drawer.dart';

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
    // Assign form links based on business type
    String formUrl;
    switch (widget.businessType.toLowerCase()) {
      case 'pg':
        formUrl = 'https://docs.google.com/forms/d/e/1FAIpQLSfJBlqoYBFDEywaaJ1RkZ73yMxRSnyNUYhCdU4VjQTNNsOCWA/viewform?usp=sharing';
        break;
      case 'mess':
        formUrl = 'https://docs.google.com/forms/d/e/1FAIpQLSfJBlqoYBFDEywaaJ1RkZ73yMxRSnyNUYhCdU4VjQTNNsOCWA/viewform?usp=sharing';
        break;
      case 'grocery':
        formUrl = 'https://docs.google.com/forms/d/e/1FAIpQLSfJBlqoYBFDEywaaJ1RkZ73yMxRSnyNUYhCdU4VjQTNNsOCWA/viewform?usp=sharing';
        break;
      default:
        formUrl = 'https://docs.google.com/forms/d/e/1FAIpQLSfJBlqoYBFDEywaaJ1RkZ73yMxRSnyNUYhCdU4VjQTNNsOCWA/viewform?usp=sharing';
    }

    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        final theme = Theme.of(context);
        final isDarkMode = theme.brightness == Brightness.dark;
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          drawer: const CustomDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
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
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ).animate().fadeIn(duration: 600.ms).slideY(),
                    SizedBox(height: 20),
                    Text(
                      'Please fill out the form to complete your registration process. This will help us understand your business better and provide you with the best services.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        color: isDarkMode ? Colors.white70 : Colors.deepPurple.shade700,
                      ),
                    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
                    SizedBox(height: 40),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () async {
                          try {
                            await launchUrl(
                              Uri.parse(formUrl),
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
                          style: theme.textTheme.bodyLarge?.copyWith(
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