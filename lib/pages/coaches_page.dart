// lib/pages/coaches_page.dart
import 'package:flutter/material.dart';
import '../models/coach_model.dart';

class CoachesPage extends StatefulWidget {
  const CoachesPage({super.key});

  @override
  CoachesPageState createState() => CoachesPageState();
}

class CoachesPageState extends State<CoachesPage> {
  List<Coach> coaches = [
    Coach(
      firstName: 'Alice',
      lastName: 'Johnson',
      email: 'alice@example.com',
      phoneNumber: '123-456-7890',
      profilePicture: 'assets/images/profile1.png',
      certificates: ['Certificat A', 'Certificat B'],
    ),
    Coach(
      firstName: 'Bob',
      lastName: 'Smith',
      email: 'bob@example.com',
      phoneNumber: '987-654-3210',
      profilePicture: 'assets/images/profile2.png',
      certificates: ['Certificat C'],
    ),
  ];

  void _addCoach() {
    setState(() {
      coaches.add(Coach(
        firstName: 'New',
        lastName: 'Coach',
        email: '',
        phoneNumber: '',
        profilePicture: '',
        certificates: [],
      ));
    });
  }

  void _editCoach(int index, Coach updatedCoach) {
    setState(() {
      coaches[index] = updatedCoach;
    });
  }

  void _deleteCoach(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmer la suppression'),
        content: const Text('Êtes-vous sûr de vouloir supprimer ce coach ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                coaches.removeAt(index);
              });
              Navigator.of(context).pop();
            },
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, Coach coach, int index) {
    final firstNameController = TextEditingController(text: coach.firstName);
    final lastNameController = TextEditingController(text: coach.lastName);
    final emailController = TextEditingController(text: coach.email);
    final phoneNumberController = TextEditingController(text: coach.phoneNumber);
    final certificatesController = TextEditingController(text: coach.certificates.join(', '));

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Modifier le coach'),
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
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(labelText: 'Numéro de téléphone'),
              ),
              TextField(
                controller: certificatesController,
                decoration: const InputDecoration(labelText: 'Certificats (séparés par des virgules)'),
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
                if (firstNameController.text.isEmpty ||
                    lastNameController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    phoneNumberController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Veuillez remplir tous les champs')),
                  );
                  return;
                }
                _editCoach(
                  index,
                  Coach(
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    email: emailController.text,
                    phoneNumber: phoneNumberController.text,
                    profilePicture: coach.profilePicture,
                    certificates: certificatesController.text.split(',').map((s) => s.trim()).toList(),
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des Coachs'),
      ),
      body: ListView.builder(
        itemCount: coaches.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(coaches[index].profilePicture),
            ),
            title: Text('${coaches[index].firstName} ${coaches[index].lastName}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email: ${coaches[index].email}'),
                Text('Téléphone: ${coaches[index].phoneNumber}'),
                Text('Certificats: ${coaches[index].certificates.join(', ')}'),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _showEditDialog(context, coaches[index], index);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _deleteCoach(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'coachesPageFab',
        onPressed: _addCoach,
        backgroundColor: Colors.teal,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
