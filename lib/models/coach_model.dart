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
