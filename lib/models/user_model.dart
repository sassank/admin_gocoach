class User {
  String firstName;
  String lastName;
  String subscription;
  String address;
  String postalCode;
  String phoneNumber;
  String email;
  DateTime subscriptionStartDate;
  DateTime subscriptionEndDate;
  bool isActive;
  bool isPaymentUpToDate;
  String role; // Ajout du champ de rôle

  User({
    required this.firstName,
    required this.lastName,
    required this.subscription,
    required this.address,
    required this.postalCode,
    required this.phoneNumber,
    required this.email,
    required this.subscriptionStartDate,
    required this.subscriptionEndDate,
    required this.isActive,
    required this.isPaymentUpToDate,
    required this.role, // Initialisation du champ de rôle
  });
}
