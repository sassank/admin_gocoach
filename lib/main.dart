import 'package:flutter/material.dart';
import 'package:admin_panel_gocoach/pages/dashboard_page.dart';
import 'package:admin_panel_gocoach/pages/users_page.dart';
import 'package:admin_panel_gocoach/pages/events_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AdminDashboard(),
      routes: {
        '/dashboard': (context) => DashboardPage(),
        '/users': (context) => UsersPage(),
        '/events': (context) => EventsPage(),
      },
    );
  }
}

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pushNamed(context, '/dashboard');
              },
            ),
            ListTile(
              title: Text('Users'),
              onTap: () {
                Navigator.pushNamed(context, '/users');
              },
            ),
            ListTile(
              title: Text('Events'),
              onTap: () {
                Navigator.pushNamed(context, '/events');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Welcome to the Admin Panel'),
      ),
    );
  }
}
