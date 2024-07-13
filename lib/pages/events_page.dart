import 'package:flutter/material.dart';
import '../models/event_model.dart';

class EventsPage extends StatefulWidget {
  final String searchQuery;

  const EventsPage({super.key, required this.searchQuery});

  @override
  EventsPageState createState() => EventsPageState();
}

class EventsPageState extends State<EventsPage> {
  List<Event> events = [
    Event(title: 'Séance de Yoga', description: 'Une séance de yoga relaxante', date: DateTime.now().add(const Duration(days: 1))),
    Event(title: 'Série d\'entraînements', description: 'Entraînement par intervalles à haute intensité', date: DateTime.now().add(const Duration(days: 2))),
    Event(title: 'Entraînement de force', description: 'Développer la force musculaire', date: DateTime.now().add(const Duration(days: 3))),
  ];

  void _addEvent() {
    setState(() {
      events.add(Event(title: 'Nouvel événement', description: '', date: DateTime.now()));
    });
  }

  void _editEvent(int index, Event updatedEvent) {
    setState(() {
      events[index] = updatedEvent;
    });
  }

  void _deleteEvent(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmer la suppression'),
        content: const Text('Êtes-vous sûr de vouloir supprimer cet événement ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                events.removeAt(index);
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
    List<Event> filteredEvents = events.where((event) {
      return event.title.toLowerCase().contains(widget.searchQuery.toLowerCase()) ||
          event.description.toLowerCase().contains(widget.searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sessions proposés'),
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
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _showEditDialog(context, filteredEvents[index], index);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
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
        heroTag: 'eventsPageFab', // Add a unique heroTag here
        onPressed: _addEvent,
        backgroundColor: Colors.teal,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEditDialog(BuildContext context, Event event, int index) {
    final titleController = TextEditingController(text: event.title);
    final descriptionController = TextEditingController(text: event.description);
    final dateController = TextEditingController(text: event.date.toLocal().toString().split(' ')[0]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Modifier l\'événement'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Titre'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(labelText: 'Date'),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: event.date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    dateController.text = pickedDate.toLocal().toString().split(' ')[0];
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
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isEmpty || descriptionController.text.isEmpty || dateController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Veuillez remplir tous les champs')),
                  );
                  return;
                }
                _editEvent(index, Event(
                  title: titleController.text,
                  description: descriptionController.text,
                  date: DateTime.parse(dateController.text),
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
}