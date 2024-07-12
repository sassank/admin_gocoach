// lib/pages/dashboard_page.dart
import 'package:flutter/material.dart';
import 'users_page.dart';
import 'events_page.dart';
import 'login_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isExpanded = false;
  int selectedIndex = 0;

  final List<Widget> _pages = [
    HomeContent(),
    UsersPage(),
    EventsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: isExpanded,
            backgroundColor: Colors.teal,
            unselectedIconTheme: IconThemeData(color: Colors.white, opacity: 1),
            unselectedLabelTextStyle: TextStyle(color: Colors.white),
            selectedIconTheme: IconThemeData(color: Colors.teal),
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                label: Text("Dashboard"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.people),
                label: Text("Clients"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.fitness_center),
                label: Text("Sessions"),
              ),
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: _pages[selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bienvenue sur le pannel d'administration de l'application GoCoach",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          Wrap(
            spacing: 20.0, // Espace horizontal entre les cartes
            runSpacing: 20.0, // Espace vertical entre les cartes
            alignment: WrapAlignment.start, // Alignement des éléments en haut
            children: [
              SizedBox(
                width: 300,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.show_chart, size: 26.0),
                            SizedBox(width: 15.0),
                            Text(
                              "Performance",
                              style: TextStyle(
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          "78%",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.comment, size: 26.0, color: Colors.red),
                            SizedBox(width: 15.0),
                            Text(
                              "Feedback",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          "32 Comments",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.people, size: 26.0, color: Colors.amber),
                            SizedBox(width: 15.0),
                            Text(
                              "Clients",
                              style: TextStyle(
                                fontSize: 26.0,
                                color: Colors.amber,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          "150",
                          style: TextStyle(
                            fontSize: 36,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
