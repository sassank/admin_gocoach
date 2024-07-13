// lib/data/fake_feedbacks.dart
import '../models/feedback_model.dart';

List<FeedbackModel> generateFakeFeedbacks() {
  return [
    FeedbackModel(
      clientName: 'John Doe',
      sessionTitle: 'Séance de Yoga',
      rating: 4.5,
      comment: 'Super séance, très relaxante !',
    ),
    FeedbackModel(
      clientName: 'Jane Smith',
      sessionTitle: 'Entraînement de force',
      rating: 4.0,
      comment: 'Bon entraînement, j\'ai beaucoup transpiré.',
    ),
    FeedbackModel(
      clientName: 'Jim Beam',
      sessionTitle: 'Série d\'entraînements',
      rating: 3.5,
      comment: 'Intensif, mais je m\'attendais à plus de variété.',
    ),
    FeedbackModel(
      clientName: 'Alice Johnson',
      sessionTitle: 'Cardio Blast',
      rating: 5.0,
      comment: 'Excellent, j\'ai adoré chaque minute !',
    ),
    FeedbackModel(
      clientName: 'Bob Brown',
      sessionTitle: 'Pilates',
      rating: 4.2,
      comment: 'Bonne séance, pourrait être un peu plus longue.',
    ),
  ];
}
