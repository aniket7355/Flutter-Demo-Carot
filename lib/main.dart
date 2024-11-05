import 'package:classico/login_screen.dart';
import 'package:classico/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CarotApp());
}

class CarotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/login":(context) => LoginScreen()
      },
      title: 'Carot App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SplashScreen(),
    );
  }
}
