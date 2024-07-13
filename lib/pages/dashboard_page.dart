import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'users_page.dart';
import 'events_page.dart';
import 'profile_page.dart';
import 'sessions_calendar_page.dart'; // Importez la nouvelle page
import '../theme_provider.dart';
import '../locale_provider.dart';
import '../l10n.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isExpanded = false;
  int selectedIndex = 0;
  String searchQuery = '';

  final List<Widget> _pages = [
    const DashboardContent(),
    const UsersPage(searchQuery: ''),
    const EventsPage(searchQuery: ''),
    const SessionsCalendarPage(), // Ajoutez la nouvelle page ici
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: isDarkMode ? Colors.black : Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      'assets/images/gocoach.png',
                      height: 50,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    ' GoCoach Admin',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black87,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AppBar(
            toolbarHeight: 80,
            backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
            title: Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Rechercher un abonné ou une activité",
                          hintStyle: TextStyle(
                            color: isDarkMode ? Colors.white54 : Colors.black54,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                          suffixIcon: Container(
                            decoration: const BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8.0),
                                bottomRight: Radius.circular(8.0),
                              ),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.search, color: Colors.white),
                              onPressed: () {
                                // Handle search action
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications,
                    color: isDarkMode ? Colors.white : Colors.black),
                onPressed: () {
                  // Handle notifications
                },
              ),
              PopupMenuButton<Locale>(
                icon: Icon(Icons.language,
                    color: isDarkMode ? Colors.white : Colors.black),
                onSelected: (Locale locale) {
                  localeProvider.setLocale(locale);
                },
                itemBuilder: (BuildContext context) {
                  return L10n.all.map((Locale locale) {
                    return PopupMenuItem<Locale>(
                      value: locale,
                      child: Text(
                        L10n.getSupportedLanguages()[locale.languageCode]!,
                      ),
                    );
                  }).toList();
                },
              ),
              IconButton(
                icon: Icon(Icons.brightness_6,
                    color: isDarkMode ? Colors.white : Colors.black),
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              ),
              IconButton(
                icon: Icon(Icons.account_circle,
                    color: isDarkMode ? Colors.white : Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage()),
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                NavigationRail(
                  extended: isExpanded,
                  backgroundColor: const Color(0xFF1d9172),
                  unselectedIconTheme: const IconThemeData(color: Colors.white),
                  unselectedLabelTextStyle: const TextStyle(color: Colors.white),
                  selectedIconTheme: const IconThemeData(color: Colors.teal),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.dashboard),
                      label: Text("Dashboard"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.people),
                      label: Text("Abbonnés"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.fitness_center),
                      label: Text("Sessions"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.calendar_today),
                      label: Text("Planning"),
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
                    padding: const EdgeInsets.all(16.0),
                    child: IndexedStack(
                      index: selectedIndex,
                      children: _pages.map((page) {
                        if (page is UsersPage) {
                          return UsersPage(searchQuery: searchQuery);
                        } else if (page is EventsPage) {
                          return EventsPage(searchQuery: searchQuery);
                        } else {
                          return page;
                        }
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Wrap(
        spacing: 20.0, // Espace horizontal entre les cartes
        runSpacing: 20.0, // Espace vertical entre les cartes
        alignment: WrapAlignment.start, // Alignement des éléments en haut
        children: [
          SizedBox(
            width: 300,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(18.0),
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
                padding: EdgeInsets.all(18.0),
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
                padding: EdgeInsets.all(18.0),
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
                padding: EdgeInsets.all(18.0),
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