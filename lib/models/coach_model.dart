// lib/models/coach_model.dart
class Coach {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String profilePicture;
  List<String> certificates;

  Coach({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.certificates,
  });
}
