import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dashboard_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      final response = await http.post(
        Uri.parse('http://localhost:8080/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': _usernameController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid credentials. Please try again.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to login. Please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez saisir vos identifiants')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with opacity
          Opacity(
            opacity: 0.5,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/gym.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Foreground content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  // Title
                  const Text(
                    "Administration de l'application",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.5,
                      shadows: [
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 7.0,
                          color: Color.fromARGB(128, 0, 0, 0),
                        ),
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 18.0,
                          color: Color.fromARGB(128, 0, 0, 0),
                        ),
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 7.0,
                          color: Color.fromARGB(128, 0, 0, 0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30.0),
                  // Logo
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      "assets/images/gocoach.png",
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  // Username field
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        labelText: 'Email',
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF1d9172)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black54),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Password field
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        labelText: 'Mot de passe',
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Color(0xFF1d9172)),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black54),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Login button
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF1d9172), // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text('Se connecter'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Register and forgot password
                  Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterPage()),
                          );
                        },
                        child: const Text(
                          "Vous n'avez pas de compte ?",
                          style: TextStyle(color: Color(0xFF1d9172)),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle password reset
                        },
                        child: const Text(
                          "Mot de passe oublié",
                          style: TextStyle(color: Color(0xFF1d9172)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
