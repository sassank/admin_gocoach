class User {
  String firstName;
  String lastName;
  DateTime dateOfBirth;
  String gender;
  String address;
  String phoneNumber;
  String email;
  String subscription;
  DateTime subscriptionStartDate;
  DateTime subscriptionEndDate;
  double subscriptionPrice;
  bool isActive;
  bool isPaymentUpToDate;

  User({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.subscription,
    required this.subscriptionStartDate,
    required this.subscriptionEndDate,
    required this.subscriptionPrice,
    required this.isActive,
    required this.isPaymentUpToDate,
  });
}
