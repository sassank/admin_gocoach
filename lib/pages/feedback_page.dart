import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  FeedbackPageState createState() => FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> {
  List<Map<String, dynamic>> feedbackList = [
    {
      'clientName': 'John Doe',
      'session': 'Séance de Yoga',
      'rating': 5,
      'comment': 'Super séance, très relaxante !'
    },
    {
      'clientName': 'Jane Smith',
      'session': 'Entraînement de force',
      'rating': 4,
      'comment': 'Bon entraînement, mais un peu intense.'
    },
    {
      'clientName': 'Jim Beam',
      'session': 'Cardio Blast',
      'rating': 3,
      'comment': 'Séance correcte, mais j\'aurais préféré plus de variété.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback et Évaluations'),
      ),
      body: ListView.builder(
        itemCount: feedbackList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(feedbackList[index]['clientName']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Session: ${feedbackList[index]['session']}'),
                Text('Note: ${feedbackList[index]['rating']} étoiles'),
                Text('Commentaire: ${feedbackList[index]['comment']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
