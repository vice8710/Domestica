import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class HomePage extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Services'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle navigation to the selected service
              switch (value) {
                case 'Cleaning':
                  // Navigate to Cleaning Page
                  break;
                case 'Plumbing':
                  // Navigate to Plumbing Page
                  break;
                case 'Electrical':
                  // Navigate to Electrical Page
                  break;
                // Add other cases as needed
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Cleaning', child: Text('Cleaning')),
              const PopupMenuItem(value: 'Plumbing', child: Text('Plumbing')),
              const PopupMenuItem(value: 'Electrical', child: Text('Electrical')),
              // Add other services as PopupMenuItem
            ],
            icon: const Icon(Icons.menu),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Welcome to the Home Services App!',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Contact Us',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(height: 8),
              Text(
                'Email: support@homeservices.com',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Phone: +123 456 789',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
