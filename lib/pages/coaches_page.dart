import 'package:flutter/material.dart';

class Coach {
  String firstName;
  String lastName;
  String specialty;
  String address;
  String postalCode;
  String phoneNumber;
  String email;
  DateTime hireDate;
  bool isActive;
  bool hasCertification;

  Coach({
    required this.firstName,
    required this.lastName,
    required this.specialty,
    required this.address,
    required this.postalCode,
    required this.phoneNumber,
    required this.email,
    required this.hireDate,
    required this.isActive,
    required this.hasCertification,
  });
}

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
      specialty: 'Cardio',
      address: '123 Fitness St',
      postalCode: '12345',
      phoneNumber: '123-456-7890',
      email: 'alice.johnson@example.com',
      hireDate: DateTime(2020, 1, 1),
      isActive: true,
      hasCertification: true,
    ),
    Coach(
      firstName: 'Bob',
      lastName: 'Smith',
      specialty: 'Musculation',
      address: '456 Strong Ave',
      postalCode: '67890',
      phoneNumber: '098-765-4321',
      email: 'bob.smith@example.com',
      hireDate: DateTime(2019, 2, 1),
      isActive: true,
      hasCertification: false,
    ),
    Coach(
      firstName: 'Charlie',
      lastName: 'Brown',
      specialty: 'Endurance',
      address: '789 Endurance Rd',
      postalCode: '54321',
      phoneNumber: '456-789-0123',
      email: 'charlie.brown@example.com',
      hireDate: DateTime(2021, 3, 1),
      isActive: false,
      hasCertification: true,
    ),
  ];

  void _addCoach(Coach coach) {
    setState(() {
      coaches.add(coach);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coachs'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Prénom')),
            DataColumn(label: Text('Nom de famille')),
            DataColumn(label: Text('Spécialité')),
            DataColumn(label: Text('Adresse')),
            DataColumn(label: Text('Code postal')),
            DataColumn(label: Text('Téléphone')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Date d\'embauche')),
            DataColumn(label: Text('Actif')),
            DataColumn(label: Text('Certification')),
            DataColumn(label: Text('Actions')),
          ],
          rows: coaches.map((coach) {
            return DataRow(
              cells: [
                DataCell(Text(coach.firstName)),
                DataCell(Text(coach.lastName)),
                DataCell(Text(coach.specialty)),
                DataCell(Text(coach.address)),
                DataCell(Text(coach.postalCode)),
                DataCell(Text(coach.phoneNumber)),
                DataCell(Text(coach.email)),
                DataCell(Text(coach.hireDate.toLocal().toString().split(' ')[0])),
                DataCell(Row(
                  children: [
                    const Text('Actif: '),
                    Switch(
                      value: coach.isActive,
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          coach.isActive = value;
                        });
                      },
                    ),
                  ],
                )),
                DataCell(Row(
                  children: [
                    const Text('Certifié: '),
                    Switch(
                      value: coach.hasCertification,
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          coach.hasCertification = value;
                        });
                      },
                    ),
                  ],
                )),
                DataCell(Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _showEditDialog(context, coach, coaches.indexOf(coach));
                      },
                      child: const Icon(Icons.edit),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        _deleteCoach(coaches.indexOf(coach));
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
        heroTag: 'coachesPageFab',
        onPressed: () {
          _showAddCoachDialog(context);
        },
        backgroundColor: Colors.teal,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEditDialog(BuildContext context, Coach coach, int index) {
    final firstNameController = TextEditingController(text: coach.firstName);
    final lastNameController = TextEditingController(text: coach.lastName);
    final specialtyController = TextEditingController(text: coach.specialty);
    final addressController = TextEditingController(text: coach.address);
    final postalCodeController = TextEditingController(text: coach.postalCode);
    final phoneNumberController = TextEditingController(text: coach.phoneNumber);
    final emailController = TextEditingController(text: coach.email);
    final hireDateController = TextEditingController(text: coach.hireDate.toLocal().toString().split(' ')[0]);
    bool isActive = coach.isActive;
    bool hasCertification = coach.hasCertification;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Modifier le coach'),
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
                  controller: specialtyController,
                  decoration: const InputDecoration(labelText: 'Spécialité'),
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
                  controller: hireDateController,
                  decoration: const InputDecoration(labelText: 'Date d\'embauche'),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: coach.hireDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      hireDateController.text = pickedDate.toLocal().toString().split(' ')[0];
                    }
                  },
                ),
                Row(
                  children: [
                    const Text('Actif: '),
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
                    const Text('Certifié: '),
                    Switch(
                      value: hasCertification,
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          hasCertification = value;
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
                    specialtyController.text.isEmpty ||
                    addressController.text.isEmpty ||
                    postalCodeController.text.isEmpty ||
                    phoneNumberController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    hireDateController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Veuillez remplir tous les champs')),
                  );
                  return;
                }
                _editCoach(index, Coach(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  specialty: specialtyController.text,
                  address: addressController.text,
                  postalCode: postalCodeController.text,
                  phoneNumber: phoneNumberController.text,
                  email: emailController.text,
                  hireDate: DateTime.parse(hireDateController.text),
                  isActive: isActive,
                  hasCertification: hasCertification,
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

  void _showAddCoachDialog(BuildContext context) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final specialtyController = TextEditingController();
    final addressController = TextEditingController();
    final postalCodeController = TextEditingController();
    final phoneNumberController = TextEditingController();
    final emailController = TextEditingController();
    final hireDateController = TextEditingController();
    bool isActive = false;
    bool hasCertification = false;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ajouter un nouveau coach'),
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
                  controller: specialtyController,
                  decoration: const InputDecoration(labelText: 'Spécialité'),
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
                  controller: hireDateController,
                  decoration: const InputDecoration(labelText: 'Date d\'embauche'),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      hireDateController.text = pickedDate.toLocal().toString().split(' ')[0];
                    }
                  },
                ),
                Row(
                  children: [
                    const Text('Actif: '),
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
                    const Text('Certifié: '),
                    Switch(
                      value: hasCertification,
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          hasCertification = value;
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
                    specialtyController.text.isEmpty ||
                    addressController.text.isEmpty ||
                    postalCodeController.text.isEmpty ||
                    phoneNumberController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    hireDateController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Veuillez remplir tous les champs')),
                  );
                  return;
                }
                _addCoach(Coach(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  specialty: specialtyController.text,
                  address: addressController.text,
                  postalCode: postalCodeController.text,
                  phoneNumber: phoneNumberController.text,
                  email: emailController.text,
                  hireDate: DateTime.parse(hireDateController.text),
                  isActive: isActive,
                  hasCertification: hasCertification,
                ));
                Navigator.of(context).pop();
              },
              child: const Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }
}
