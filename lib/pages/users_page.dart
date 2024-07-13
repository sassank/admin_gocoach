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
    User(
      firstName: 'John',
      lastName: 'Doe',
      dateOfBirth: DateTime(1990, 5, 15),
      gender: 'Male',
      address: '123 Main St',
      phoneNumber: '123-456-7890',
      email: 'john.doe@example.com',
      subscription: 'Gold',
      subscriptionStartDate: DateTime(2023, 1, 1),
      subscriptionEndDate: DateTime(2023, 12, 31),
      subscriptionPrice: 1200.00,
      isActive: true,
      isPaymentUpToDate: true,
    ),
    User(
      firstName: 'Jane',
      lastName: 'Smith',
      dateOfBirth: DateTime(1985, 7, 20),
      gender: 'Female',
      address: '456 Elm St',
      phoneNumber: '987-654-3210',
      email: 'jane.smith@example.com',
      subscription: 'Silver',
      subscriptionStartDate: DateTime(2023, 1, 1),
      subscriptionEndDate: DateTime(2023, 12, 31),
      subscriptionPrice: 1000.00,
      isActive: false,
      isPaymentUpToDate: false,
    ),
    User(
      firstName: 'Jim',
      lastName: 'Beam',
      dateOfBirth: DateTime(1975, 3, 10),
      gender: 'Male',
      address: '789 Oak St',
      phoneNumber: '555-555-5555',
      email: 'jim.beam@example.com',
      subscription: 'Bronze',
      subscriptionStartDate: DateTime(2023, 1, 1),
      subscriptionEndDate: DateTime(2023, 12, 31),
      subscriptionPrice: 800.00,
      isActive: true,
      isPaymentUpToDate: true,
    ),
  ];

  void _addUser() {
    setState(() {
      users.add(User(
        firstName: 'New',
        lastName: 'User',
        dateOfBirth: DateTime(2000, 1, 1),
        gender: 'Other',
        address: '',
        phoneNumber: '',
        email: '',
        subscription: '',
        subscriptionStartDate: DateTime.now(),
        subscriptionEndDate: DateTime.now().add(const Duration(days: 365)),
        subscriptionPrice: 0.00,
        isActive: true,
        isPaymentUpToDate: true,
      ));
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
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Prénom')),
            DataColumn(label: Text('Nom de famille')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Téléphone')),
            DataColumn(label: Text('Abonnement')),
            DataColumn(label: Text('Début Abonnement')),
            DataColumn(label: Text('Fin Abonnement')),
            DataColumn(label: Text('Prix Abonnement')),
            DataColumn(label: Text('Statut')),
            DataColumn(label: Text('Paiement')),
            DataColumn(label: Text('Actions')),
          ],
          rows: filteredUsers.map((user) {
            return DataRow(
              cells: [
                DataCell(Text(user.firstName)),
                DataCell(Text(user.lastName)),
                DataCell(Text(user.email)),
                DataCell(Text(user.phoneNumber)),
                DataCell(Text(user.subscription)),
                DataCell(Text(user.subscriptionStartDate.toLocal().toString().split(' ')[0])),
                DataCell(Text(user.subscriptionEndDate.toLocal().toString().split(' ')[0])),
                DataCell(Text(user.subscriptionPrice.toString())),
                DataCell(Text(
                  user.isActive ? 'Actif' : 'Non Actif',
                  style: TextStyle(
                    color: user.isActive ? Colors.green : Colors.red,
                  ),
                )),
                DataCell(Text(
                  user.isPaymentUpToDate ? 'À jour' : 'En retard',
                  style: TextStyle(
                    color: user.isPaymentUpToDate ? Colors.green : Colors.red,
                  ),
                )),
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        _showEditDialog(context, user, users.indexOf(user));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _deleteUser(users.indexOf(user));
                      },
                    ),
                  ],
                )),
              ],
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'usersPageFab',
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
    final emailController = TextEditingController(text: user.email);
    final phoneNumberController = TextEditingController(text: user.phoneNumber);
    final subscriptionController = TextEditingController(text: user.subscription);
    final subscriptionStartDateController = TextEditingController(text: user.subscriptionStartDate.toLocal().toString().split(' ')[0]);
    final subscriptionEndDateController = TextEditingController(text: user.subscriptionEndDate.toLocal().toString().split(' ')[0]);
    final subscriptionPriceController = TextEditingController(text: user.subscriptionPrice.toString());
    bool isActive = user.isActive;
    bool isPaymentUpToDate = user.isPaymentUpToDate;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Modifier l\'utilisateur'),
          content: SingleChildScrollView(
            child: Column(
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
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: phoneNumberController,
                  decoration: const InputDecoration(labelText: 'Téléphone'),
                ),
                TextField(
                  controller: subscriptionController,
                  decoration: const InputDecoration(labelText: 'Abonnement'),
                ),
                TextField(
                  controller: subscriptionStartDateController,
                  decoration: const InputDecoration(labelText: 'Début Abonnement'),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: user.subscriptionStartDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      subscriptionStartDateController.text = pickedDate.toLocal().toString().split(' ')[0];
                    }
                  },
                ),
                TextField(
                  controller: subscriptionEndDateController,
                  decoration: const InputDecoration(labelText: 'Fin Abonnement'),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: user.subscriptionEndDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      subscriptionEndDateController.text = pickedDate.toLocal().toString().split(' ')[0];
                    }
                  },
                ),
                TextField(
                  controller: subscriptionPriceController,
                  decoration: const InputDecoration(labelText: 'Prix Abonnement'),
                  keyboardType: TextInputType.number,
                ),
                Row(
                  children: [
                    const Text('Statut: '),
                    Switch(
                      value: isActive,
                      onChanged: (value) {
                        setState(() {
                          isActive = value;
                        });
                      },
                    ),
                    Text(isActive ? 'Actif' : 'Non Actif'),
                  ],
                ),
                Row(
                  children: [
                    const Text('Paiement: '),
                    Switch(
                      value: isPaymentUpToDate,
                      onChanged: (value) {
                        setState(() {
                          isPaymentUpToDate = value;
                        });
                      },
                    ),
                    Text(isPaymentUpToDate ? 'À jour' : 'En retard'),
                  ],
                ),
              ],
            ),
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
                if (firstNameController.text.isEmpty || lastNameController.text.isEmpty || emailController.text.isEmpty || phoneNumberController.text.isEmpty || subscriptionController.text.isEmpty || subscriptionPriceController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Veuillez remplir tous les champs')),
                  );
                  return;
                }
                _editUser(index, User(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  dateOfBirth: user.dateOfBirth,
                  gender: user.gender,
                  address: user.address,
                  phoneNumber: phoneNumberController.text,
                  email: emailController.text,
                  subscription: subscriptionController.text,
                  subscriptionStartDate: DateTime.parse(subscriptionStartDateController.text),
                  subscriptionEndDate: DateTime.parse(subscriptionEndDateController.text),
                  subscriptionPrice: double.parse(subscriptionPriceController.text),
                  isActive: isActive,
                  isPaymentUpToDate: isPaymentUpToDate,
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
