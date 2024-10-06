import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'email_sign_up.dart';
import 'login_screen.dart';
import 'HomePage.dart';
import 'dart:async';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<String> _images = [
    'assets/cleaning.jpg',
    'assets/plumbing.jpg',
    'assets/electrical.jpg',
    'assets/painting.png',
    'assets/gardening.jpg',
  ];
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: "402282842058-4tdopn0bllvncqua77hnldua6tbpjbsp.apps.googleusercontent.com",
  );

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (mounted) {
        setState(() {
          _currentPage = (_currentPage + 1) % _images.length;
        });
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            itemBuilder: (context, index) => Image.asset(
              _images[index],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to Home Services',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                _buildEmailSignUpButton(),
                const SizedBox(height: 10),
                _buildGoogleSignInButton(),
                const SizedBox(height: 20),
                _buildLoginTextButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton _buildEmailSignUpButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => EmailSignUp()));
      },
      child: const Text('Sign up with Email'),
    );
  }

  ElevatedButton _buildGoogleSignInButton() {
    return ElevatedButton.icon(
      onPressed: () => _signInWithGoogle(),
      icon: const Icon(Icons.account_circle),
      label: const Text('Sign in with Google'),
    );
  }

  TextButton _buildLoginTextButton() {
    return TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: const Text(
        'Already have an account? Login',
        style: TextStyle(decoration: TextDecoration.underline, color: Colors.white),
      ),
    );
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // The user canceled the sign-in

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User? user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      if (user != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }
}
