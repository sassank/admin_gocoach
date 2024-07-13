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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmer la suppression'),
        content: const Text('Êtes-vous sûr de vouloir supprimer cet utilisateur ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                users.removeAt(index);
              });
              Navigator.of(context).pop();
            },
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
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
            subtitle: Text('Abonnement: ${filteredUsers[index].subscription}'),
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
        heroTag: 'usersPageFab', // Add a unique heroTag here
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
          title: const Text('Modifier l\'utilisateur'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(labelText: 'Prénom'),
              ),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: 'Nom de famille'),
              ),
              TextField(
                controller: subscriptionController,
                decoration: const InputDecoration(labelText: 'Abonnement'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                if (firstNameController.text.isEmpty || lastNameController.text.isEmpty || subscriptionController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Veuillez remplir tous les champs')),
                  );
                  return;
                }
                _editUser(index, User(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  subscription: subscriptionController.text,
                ));
                Navigator.of(context).pop();
              },
              child: const Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }
}