import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UsersPage extends StatefulWidget {
  final String searchQuery;

  const UsersPage({super.key, required this.searchQuery});

  @override
  UsersPageState createState() => UsersPageState();
}

class UsersPageState extends State<UsersPage> {
  List<User> users = [
    User(firstName: 'John', lastName: 'Doe', subscription: 'Gold'),
    User(firstName: 'Jane', lastName: 'Smith', subscription: 'Silver'),
    User(firstName: 'Jim', lastName: 'Beam', subscription: 'Bronze'),
  ];

  void _addUser() {
    setState(() {
      users.add(User(firstName: 'New', lastName: 'User', subscription: ''));
    });
  }

  void _editUser(int index, User updatedUser) {
    setState(() {
      users[index] = updatedUser;
    });
  }

  void _deleteUser(int index) {
    setState(() {
      users.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<User> filteredUsers = users.where((user) {
      return user.firstName.toLowerCase().contains(widget.searchQuery.toLowerCase()) ||
          user.lastName.toLowerCase().contains(widget.searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clients'),
      ),
      body: ListView.builder(
        itemCount: filteredUsers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${filteredUsers[index].firstName} ${filteredUsers[index].lastName}'),
            subtitle: Text('Subscription: ${filteredUsers[index].subscription}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _showEditDialog(context, filteredUsers[index], index);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _deleteUser(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addUser,
        backgroundColor: Colors.teal,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEditDialog(BuildContext context, User user, int index) {
    final firstNameController = TextEditingController(text: user.firstName);
    final lastNameController = TextEditingController(text: user.lastName);
    final subscriptionController = TextEditingController(text: user.subscription);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: subscriptionController,
                decoration: const InputDecoration(labelText: 'Subscription'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _editUser(index, User(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  subscription: subscriptionController.text,
                ));
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}