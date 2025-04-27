import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'business_form_landing_screen.dart';
import '../../widgets/custom_drawer.dart';

class BusinessSelectionScreen extends StatefulWidget {
  @override
  _BusinessSelectionScreenState createState() => _BusinessSelectionScreenState();
}

class _BusinessSelectionScreenState extends State<BusinessSelectionScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  String? selectedBusinessType;

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
        final theme = Theme.of(context);
        final isDarkMode = theme.brightness == Brightness.dark;
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          drawer: const CustomDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select your Business Type',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideY(),
                  SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildBusinessTypeCard(
                          'PG',
                          Icons.home_work,
                          'pg',
                        ),
                        Divider(height: 1),
                        _buildBusinessTypeCard(
                          'Mess',
                          Icons.restaurant,
                          'mess',
                        ),
                        Divider(height: 1),
                        _buildBusinessTypeCard(
                          'Grocery Store',
                          Icons.shopping_cart,
                          'grocery',
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2),
                  SizedBox(height: 30),
                  if (selectedBusinessType != null)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        backgroundColor: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BusinessFormLandingScreen(
                              businessType: selectedBusinessType!.toUpperCase(),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Continue',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBusinessTypeCard(String title, IconData icon, String value) {
    final theme = Theme.of(context);
    final isSelected = selectedBusinessType == value;
    return InkWell(
      onTap: () {
        setState(() {
          selectedBusinessType = value;
        });
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? theme.primaryColor.withOpacity(0.1) : theme.cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
              color: theme.primaryColor,
            ),
            SizedBox(width: 15),
            Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: theme.primaryColor,
              ),
            ),
            Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: theme.primaryColor,
              ),
          ],
        ),
      ),
    );
  }
}
