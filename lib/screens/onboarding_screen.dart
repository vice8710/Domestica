import 'package:flutter/material.dart';
import 'email_sign_up.dart';  // Import the email sign-up page
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'login_screen.dart'; // Import LoginPage

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Home Services',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Navigate to email signup page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmailSignUp()),
                );
              },
              child: Text('Sign up with Email'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                signInWithGoogle(context);
              },
              icon: Icon(Icons.account_circle),
              label: Text('Sign in with Google'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                signInWithFacebook(context);
              },
              icon: Icon(Icons.facebook),
              label: Text('Sign in with Facebook'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Navigate to login page if already signed up
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text(
                'Already have an account? Login',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Google Sign-In
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      User? user = await FirebaseAuth.instance.signInWithCredential(credential).then((user) => user.user);
      
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()), // Navigate to HomePage
        );
      }
    } catch (e) {
      print('Error signing in with Google: $e');
      // Handle error, e.g., show a Snackbar
    }
  }

  // Facebook Sign-In
  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      final result = await FacebookAuth.instance.login();
      final credential = FacebookAuthProvider.credential(result.accessToken!.token);
      User? user = await FirebaseAuth.instance.signInWithCredential(credential).then((user) => user.user);
      
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()), // Navigate to HomePage
        );
      }
    } catch (e) {
      print('Error signing in with Facebook: $e');
      // Handle error, e.g., show a Snackbar
    }
  }
}
