// lib/pages/events_page.dart
import 'package:flutter/material.dart';
import '../models/event_model.dart';

class EventsPage extends StatelessWidget {
  final List<Event> events = [
    Event(title: 'Yoga Session', description: 'A relaxing yoga session', date: DateTime.now().add(Duration(days: 1))),
    Event(title: 'HIIT Workout', description: 'High-intensity interval training', date: DateTime.now().add(Duration(days: 2))),
    Event(title: 'Strength Training', description: 'Build muscle strength', date: DateTime.now().add(Duration(days: 3))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sessions'),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(events[index].title),
            subtitle: Text('${events[index].description}\nDate: ${events[index].date.toLocal()}'.split(' ')[0]),
          );
        },
      ),
    );
  }
}
