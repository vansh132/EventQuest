import 'package:eventquest/screens/faculty_screens/announcement_screens/faculty_announcement_screen.dart';
import 'package:eventquest/screens/faculty_screens/event_screens/faculty_event_screen.dart';

import 'package:eventquest/screens/faculty_screens/faculty_home_screen.dart';
import 'package:eventquest/screens/faculty_screens/registration_screen/faculty_registration_screen.dart';

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
      FacultyRegistrationScreen(),
    ];

    void onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      body: SafeArea(child: widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff012a4a),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color(0xff002848),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
            backgroundColor: Color(0xff002848),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_rounded),
            label: 'Announcements',
            backgroundColor: Color(0xff002848),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_rounded),
            label: 'Tasks',
            backgroundColor: Color(0xff002848),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Registrations',
            backgroundColor: Color(0xff002848),
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.amber[800],
        onTap: onItemTapped,
      ),
    );
  }
}
