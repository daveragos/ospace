import 'package:flutter/material.dart';
import 'package:ospace/publisher/home_publisher.dart';
import 'package:ospace/publisher/screens/auth/signup.dart';
import 'package:ospace/publisher/screens/controllers/auth/auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final response = await _authService.login(
        username: _emailController.text,
        password: _passwordController.text,
      );
      if (response != null) {
        Navigator.of(context).pushReplacement( MaterialPageRoute(builder: (context) =>  HomePublisher()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login failed'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Image.asset('assets/img.png', width: 100, height: 100),
            Text(
              'OmniSpace',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Welcome Back',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Card(
              margin: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: 'Username'),
                        validator: (value) =>
                            value!.isEmpty ? 'Username required' : null,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) =>
                            value!.isEmpty ? 'Password required' : null,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _login,
                        child: Text('Login'),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  SignupScreen())),
                        child: Text('Don’t have an account? Sign Up'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
