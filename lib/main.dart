import 'package:flutter/material.dart';
import 'package:perfect_love_app/screens/home_screen.dart';
import 'package:perfect_love_app/screens/signup_screen.dart';
import 'package:perfect_love_app/screens/splash_screen.dart';
import 'package:perfect_love_app/screens/verification_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/Signup', // Define the startup page of the application
      routes: {
        '/Home': (context) => HomeScreen(),
        '/Splash': (context) => SplashScreen(),
        '/Signup': (context) => SignupScreen(),
        '/Verification': (context) => VerificationScreen()
      },//Defining the main pages of the application as routes
    );
  }
}