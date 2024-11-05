import 'package:classico/Token Manager.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _showSplashAndCheckLoginStatus();
  }

  Future<void> _showSplashAndCheckLoginStatus() async {
    await Future.delayed(Duration(seconds: 4));

    TokenManager tokenManager = TokenManager();
    try {
      final token = await tokenManager.getToken();
      // Navigate to the appropriate screen based on token validity
      if (token != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DashboardScreen(showBottomNavigation: true)),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    } catch (e) {
      print("Error checking login status: $e");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          height: 80,
        ),
      ),
    );
  }
}
