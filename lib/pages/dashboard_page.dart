import 'package:flutter/material.dart';
import 'users_page.dart';
import 'events_page.dart';
import 'profile_page.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Administration GoCoach', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // Handle notifications
            },
          ),
          IconButton(
            icon: Icon(Icons.language, color: Colors.black),
            onPressed: () {
              // Handle language change
            },
          ),
          IconButton(
            icon: Icon(Icons.brightness_6, color: Colors.black),
            onPressed: () {
              // Handle theme change
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            extended: isExpanded,
            backgroundColor: Color(0xFF1d9172),
            unselectedIconTheme: IconThemeData(color: Colors.white),
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
      child: Wrap(
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
                        Icon(Icons.attach_money, size: 26.0, color: Colors.green),
                        SizedBox(width: 15.0),
                        Text(
                          "Revenue",
                          style: TextStyle(
                            fontSize: 26.0,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      "2,300 \$",
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.green,
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
    );
  }
}
