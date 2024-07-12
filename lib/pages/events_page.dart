import 'package:flutter/material.dart';
import '../models/event_model.dart';

class EventsPage extends StatefulWidget {
  final String searchQuery;

  EventsPage({required this.searchQuery});

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List<Event> events = [
    Event(title: 'Yoga Session', description: 'A relaxing yoga session', date: DateTime.now().add(Duration(days: 1))),
    Event(title: 'HIIT Workout', description: 'High-intensity interval training', date: DateTime.now().add(Duration(days: 2))),
    Event(title: 'Strength Training', description: 'Build muscle strength', date: DateTime.now().add(Duration(days: 3))),
  ];

  void _addEvent() {
    setState(() {
      events.add(Event(title: 'New Event', description: '', date: DateTime.now()));
    });
  }

  void _editEvent(int index, Event updatedEvent) {
    setState(() {
      events[index] = updatedEvent;
    });
  }

  void _deleteEvent(int index) {
    setState(() {
      events.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Event> filteredEvents = events.where((event) {
      return event.title.toLowerCase().contains(widget.searchQuery.toLowerCase()) ||
          event.description.toLowerCase().contains(widget.searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Sessions'),
      ),
      body: ListView.builder(
        itemCount: filteredEvents.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(filteredEvents[index].title),
            subtitle: Text('${filteredEvents[index].description}\nDate: ${filteredEvents[index].date.toLocal()}'.split(' ')[0]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _showEditDialog(context, filteredEvents[index], index);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteEvent(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent,
        backgroundColor: Colors.teal,
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, Event event, int index) {
    final _titleController = TextEditingController(text: event.title);
    final _descriptionController = TextEditingController(text: event.description);
    final _dateController = TextEditingController(text: event.date.toLocal().toString().split(' ')[0]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date'),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: event.date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    _dateController.text = pickedDate.toLocal().toString().split(' ')[0];
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _editEvent(index, Event(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  date: DateTime.parse(_dateController.text),
                ));
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}