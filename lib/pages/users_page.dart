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
      subscription: 'Gold',
      address: '123 Main St',
      postalCode: '12345',
      phoneNumber: '123-456-7890',
      email: 'john.doe@example.com',
      subscriptionStartDate: DateTime(2022, 1, 1),
      subscriptionEndDate: DateTime(2023, 1, 1),
      isActive: true,
      isPaymentUpToDate: true,
    ),
    User(
      firstName: 'Jane',
      lastName: 'Smith',
      subscription: 'Silver',
      address: '456 Elm St',
      postalCode: '67890',
      phoneNumber: '098-765-4321',
      email: 'jane.smith@example.com',
      subscriptionStartDate: DateTime(2022, 2, 1),
      subscriptionEndDate: DateTime(2023, 2, 1),
      isActive: true,
      isPaymentUpToDate: false,
    ),
    User(
      firstName: 'Jim',
      lastName: 'Beam',
      subscription: 'Bronze',
      address: '789 Maple Ave',
      postalCode: '54321',
      phoneNumber: '456-789-0123',
      email: 'jim.beam@example.com',
      subscriptionStartDate: DateTime(2022, 3, 1),
      subscriptionEndDate: DateTime(2023, 3, 1),
      isActive: false,
      isPaymentUpToDate: true,
    ),
  ];

  void _addUser() {
    setState(() {
      users.add(User(
        firstName: 'New',
        lastName: 'User',
        subscription: '',
        address: '',
        postalCode: '',
        phoneNumber: '',
        email: '',
        subscriptionStartDate: DateTime.now(),
        subscriptionEndDate: DateTime.now().add(const Duration(days: 365)),
        isActive: false,
        isPaymentUpToDate: false,
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
            DataColumn(label: Text('Abonnement')),
            DataColumn(label: Text('Adresse')),
            DataColumn(label: Text('Code postal')),
            DataColumn(label: Text('Téléphone')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Début d\'abonnement')),
            DataColumn(label: Text('Fin d\'abonnement')),
            DataColumn(label: Text('Statut')),
            DataColumn(label: Text('Paiement')),
            DataColumn(label: Text('Actions')),
          ],
          rows: filteredUsers.map((user) {
            return DataRow(
              cells: [
                DataCell(Text(user.firstName)),
                DataCell(Text(user.lastName)),
                DataCell(Text(user.subscription)),
                DataCell(Text(user.address)),
                DataCell(Text(user.postalCode)),
                DataCell(Text(user.phoneNumber)),
                DataCell(Text(user.email)),
                DataCell(Text(user.subscriptionStartDate.toLocal().toString().split(' ')[0])),
                DataCell(Text(user.subscriptionEndDate.toLocal().toString().split(' ')[0])),
                DataCell(Row(
                  children: [
                    const Text('Statut: '),
                    Switch(
                      value: user.isActive,
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          user.isActive = value;
                        });
                      },
                    ),
                  ],
                )),
                DataCell(Row(
                  children: [
                    const Text('Paiement à jour: '),
                    Switch(
                      value: user.isPaymentUpToDate,
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          user.isPaymentUpToDate = value;
                        });
                      },
                    ),
                  ],
                )),
                DataCell(Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _showEditDialog(context, user, users.indexOf(user));
                      },
                      child: const Icon(Icons.edit),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        _deleteUser(users.indexOf(user));
                      },
                      child: const Icon(Icons.delete),
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
    final subscriptionController = TextEditingController(text: user.subscription);
    final addressController = TextEditingController(text: user.address);
    final postalCodeController = TextEditingController(text: user.postalCode);
    final phoneNumberController = TextEditingController(text: user.phoneNumber);
    final emailController = TextEditingController(text: user.email);
    final subscriptionStartDateController = TextEditingController(text: user.subscriptionStartDate.toLocal().toString().split(' ')[0]);
    final subscriptionEndDateController = TextEditingController(text: user.subscriptionEndDate.toLocal().toString().split(' ')[0]);
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
                  controller: subscriptionController,
                  decoration: const InputDecoration(labelText: 'Abonnement'),
                ),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: 'Adresse'),
                ),
                TextField(
                  controller: postalCodeController,
                  decoration: const InputDecoration(labelText: 'Code postal'),
                ),
                TextField(
                  controller: phoneNumberController,
                  decoration: const InputDecoration(labelText: 'Téléphone'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: subscriptionStartDateController,
                  decoration: const InputDecoration(labelText: 'Début d\'abonnement'),
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
                  decoration: const InputDecoration(labelText: 'Fin d\'abonnement'),
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
                Row(
                  children: [
                    const Text('Statut: '),
                    Switch(
                      value: isActive,
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          isActive = value;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Paiement à jour: '),
                    Switch(
                      value: isPaymentUpToDate,
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          isPaymentUpToDate = value;
                        });
                      },
                    ),
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
                if (firstNameController.text.isEmpty ||
                    lastNameController.text.isEmpty ||
                    subscriptionController.text.isEmpty ||
                    addressController.text.isEmpty ||
                    postalCodeController.text.isEmpty ||
                    phoneNumberController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    subscriptionStartDateController.text.isEmpty ||
                    subscriptionEndDateController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Veuillez remplir tous les champs')),
                  );
                  return;
                }
                _editUser(index, User(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  subscription: subscriptionController.text,
                  address: addressController.text,
                  postalCode: postalCodeController.text,
                  phoneNumber: phoneNumberController.text,
                  email: emailController.text,
                  subscriptionStartDate: DateTime.parse(subscriptionStartDateController.text),
                  subscriptionEndDate: DateTime.parse(subscriptionEndDateController.text),
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
