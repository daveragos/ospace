import 'package:flutter/material.dart';
import 'package:ospace/publisher/controllers/auth/auth.dart';
import 'package:ospace/publisher/screens/auth/signin.dart';

class PublisherStatusScreen extends StatelessWidget {
  final String userName;
  final String status;

  const PublisherStatusScreen({
    super.key,
    required this.userName,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    // Choose icon and message based on status
    IconData icon;
    String message;

    if (status == 'PENDING') {
      icon = Icons.hourglass_empty;
      message = 'Your account is currently pending approval. We will notify you once it has been reviewed.';
    } else if (status == 'SUSPENDED') {
      icon = Icons.block;
      message = 'Your account has been suspended. Please contact support for more information.';
    } else {
      icon = Icons.error;
      message = 'Your account status is unknown.';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: status == 'PENDING' ? Colors.orange : Colors.red, size: 100),
              const SizedBox(height: 20),
              Text(
                'Welcome, $userName!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                message,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          await AuthService().logout();
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
            return const LoginScreen();
          }));
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.logout),
      ),
    );
  }
}
