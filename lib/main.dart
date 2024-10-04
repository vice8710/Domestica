import 'package:flutter/material.dart';
import 'onboarding_screen.dart'; // Make sure this is the correct import for your onboarding screen
import 'login_page.dart'; // Import your LoginPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Services',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OnboardingScreen(), // Set the OnboardingScreen as the initial screen
    );
  }
}
