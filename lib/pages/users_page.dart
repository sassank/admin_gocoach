// lib/pages/users_page.dart
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UsersPage extends StatelessWidget {
  final List<User> users = [
    User(firstName: 'John', lastName: 'Doe', subscription: 'Gold'),
    User(firstName: 'Jane', lastName: 'Smith', subscription: 'Silver'),
    User(firstName: 'Jim', lastName: 'Beam', subscription: 'Bronze'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clients'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${users[index].firstName} ${users[index].lastName}'),
            subtitle: Text('Subscription: ${users[index].subscription}'),
          );
        },
      ),
    );
  }
}
