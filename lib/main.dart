import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBIvsbvO3sfmT1r6-QEZlyN3fvgnLA83uc",
      authDomain: "domestica-bb2da.firebaseapp.com",
      projectId: "domestica-bb2da",
      storageBucket: "domestica-bb2da.appspot.com",
      messagingSenderId: "402282842058",
      appId: "1:402282842058:web:f4bc973e5555fca6cff133",
    ),
  );
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
      debugShowCheckedModeBanner: false, 
      home: OnboardingScreen(), // Start with onboarding screen
    );
  }
}
