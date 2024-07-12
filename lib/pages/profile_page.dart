import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFF1d9172),
      ),
      body: Center(
        child: Text(
          'User Profile Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
