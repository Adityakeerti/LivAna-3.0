import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home_screen.dart';
import 'screens/business/pg_dashboard_screen.dart';
import 'screens/business/mess_dashboard_screen.dart';
import 'screens/business/shop_dashboard_screen.dart';
import 'screens/student/student_login_screen.dart';
import 'screens/student/student_home_screen.dart';
import 'screens/student/service_selection_screen.dart';
import 'screens/student/pgs_screen.dart';
import 'screens/student/mess_screen.dart';
import 'screens/student/grocery_screen.dart';
import 'screens/forum_screen.dart';
import 'screens/business/business_login_screen.dart';
import 'screens/business/business_selection_screen.dart';
import 'screens/business/business_form_landing_screen.dart';
import 'screens/student/student_name_screen.dart';
import 'screens/business/business_name_screen.dart';
import 'screens/student/my_account_screen.dart';


// Student Screens
import 'screens/student/student_login_screen.dart';
import 'screens/student/student_home_screen.dart';

// Business Screens
import 'screens/business/business_login_screen.dart';
import 'screens/business/business_selection_screen.dart';
import 'screens/business/business_detail_entry_screen.dart';
import 'screens/business/pg_dashboard_screen.dart';
import 'screens/business/mess_dashboard_screen.dart';
import 'screens/business/shop_dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const LivAnaApp(),
    ),
  );
}

class LivAnaApp extends StatelessWidget {
  const LivAnaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return MaterialApp(
      title: 'LivAna',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.themeData,
      home: HomeScreen(),
      routes: {
        // Student Routes
        '/student': (context) => StudentLoginScreen(),
        '/studentName': (context) => StudentNameScreen(),
        '/studentHome': (context) => StudentHomeScreen(),
        '/serviceSelection': (context) => ServiceSelectionScreen(),
        '/pgs': (context) => PgsScreen(),
        '/mess': (context) => MessScreen(),
        '/grocery': (context) => GroceryScreen(),
        '/forum': (context) => ForumScreen(),
        '/myAccount': (context) => const MyAccountScreen(),

        // Business Routes
        '/business': (context) => BusinessLoginScreen(),
        '/businessName': (context) => BusinessNameScreen(),
        '/businessSelect': (context) => BusinessSelectionScreen(),
        '/businessForm': (context) => BusinessFormLandingScreen(businessType: ''),
        '/businessDetails': (context) => BusinessDetailEntryScreen(),
        '/pgDashboard': (context) => PgDashboardScreen(),
        '/messDashboard': (context) => MessDashboardScreen(),
        '/shopDashboard': (context) => ShopDashboardScreen(),
      },
    );
  }
}
