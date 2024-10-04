import 'package:flutter/material.dart';
import 'auth_service.dart'; // Import AuthService to handle logout
import 'login_page.dart';  // Import LoginPage for navigation after logout

class HomePage extends StatelessWidget {
  final AuthService _authService = AuthService(); // Instance of AuthService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut(); // Call the sign out function
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()), // Go back to LoginPage after logout
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Welcome to the Home Page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
