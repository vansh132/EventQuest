import 'package:eventquest/screens/faculty_screens/announcement_screens/faculty_announcement_screen.dart';
import 'package:eventquest/screens/faculty_screens/event_screens/faculty_event_screen.dart';
import 'package:eventquest/screens/faculty_screens/event_screens/faculty_registration_details_screen.dart';
import 'package:eventquest/screens/faculty_screens/faculty_home_screen.dart';

import 'package:eventquest/screens/faculty_screens/task_screens/faculty_task_screen.dart';
import 'package:flutter/material.dart';

class FacultyCustomBottomBar extends StatefulWidget {
  static const String routeName = "/faculty-custom-navigation-bottom-bar";
  const FacultyCustomBottomBar({super.key});

  @override
  State<FacultyCustomBottomBar> createState() => _FacultyCustomBottomBarState();
}

int _selectedIndex = 0;

class _FacultyCustomBottomBarState extends State<FacultyCustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      const FacultyHomeScreen(),
      FacultyEventScreen(),
      FacultyAnnouncementScreen(),
      const FacultyTaskScreen(),
      RegistrationDetailsScreen(),
    ];

    void onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      body: SafeArea(child: widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_rounded),
            label: 'Announcements',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_rounded),
            label: 'Tasks',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Registrations',
            backgroundColor: Colors.black,
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.amber[800],
        onTap: onItemTapped,
      ),
    );
  }
}
