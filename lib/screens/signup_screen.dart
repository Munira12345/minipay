import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: ()
                  {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const DashboardScreen()),
                    );

                  },
                  child: const Text('Sign Up'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to LoginScreen
                  },
                  child: const Text("Already have an account? Log in"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
