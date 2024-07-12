import 'package:flutter/material.dart';
import 'pages/dashboard_page.dart';
import 'pages/users_page.dart';
import 'pages/events_page.dart';
import 'pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Panel GoCoach',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0x5ADEFFE1), // Set the background color here
      ),
      home: LoginPage(),
      routes: {
        '/dashboard': (context) => DashboardPage(),
        '/users': (context) => UsersPage(),
        '/events': (context) => EventsPage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}
