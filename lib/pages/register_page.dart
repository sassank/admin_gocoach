import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'login_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _subscriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String _selectedRole = 'member'; // Default role

  void _register() async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _passwordController.text == _confirmPasswordController.text) {
      final response = await http.post(
        Uri.parse('http://localhost:8080/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': _emailController.text,
          'password': _passwordController.text,
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'subscription': _subscriptionController.text,
          'address': _addressController.text,
          'postalCode': _postalCodeController.text,
          'phoneNumber': _phoneNumberController.text,
          'role': _selectedRole, // Include the role
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erreur lors de l\'inscription')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir correctement tous les champs')),
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
                    "Créer un compte",
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
                  // First name field
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        labelText: 'Prénom',
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
                  // Last name field
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        labelText: 'Nom de famille',
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
                  // Subscription field
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _subscriptionController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.card_membership),
                        labelText: 'Abonnement',
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
                  // Address field
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.home),
                        labelText: 'Adresse',
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
                  // Postal code field
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _postalCodeController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.location_on),
                        labelText: 'Code postal',
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
                  // Phone number field
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        labelText: 'Téléphone',
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
                  // Email field
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
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
                  // Confirm Password field
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        labelText: 'Confirmer le mot de passe',
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
                  // Role dropdown
                  SizedBox(
                    width: 300,
                    child: DropdownButtonFormField<String>(
                      value: _selectedRole,
                      items: <String>['member', 'coach', 'admin']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRole = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        labelText: 'Role',
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
                  // Register button
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF1d9172), // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text('S\'inscrire'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Already have an account
                  TextButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      "Vous avez déjà un compte ? Connectez-vous",
                      style: TextStyle(color: Color(0xFF1d9172)),
                    ),
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
