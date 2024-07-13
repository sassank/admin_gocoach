// lib/models/feedback_model.dart
class FeedbackModel {
  final String clientName;
  final String sessionTitle;
  final double rating;
  final String comment;

  FeedbackModel({
    required this.clientName,
    required this.sessionTitle,
    required this.rating,
    required this.comment,
  });
}
