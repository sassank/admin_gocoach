import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF1d9172),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/avatar.jpg'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Nom: John Doe',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 10),
              Text(
                'Email: johndoe@example.com',
                style: TextStyle(fontSize: 20, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}