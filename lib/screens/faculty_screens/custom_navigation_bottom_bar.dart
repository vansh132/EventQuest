import 'package:eventquest/screens/faculty_screens/screens/f_announcement_screen.dart';
import 'package:eventquest/screens/faculty_screens/screens/f_event_screen.dart';
import 'package:eventquest/screens/faculty_screens/screens/f_home_screen.dart';
import 'package:eventquest/screens/faculty_screens/screens/f_registration_details_screen.dart';
import 'package:eventquest/screens/faculty_screens/screens/f_task_screen.dart';
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
      const FacultyEventScreen(),
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
            label: 'fHome',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'fEvents',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_rounded),
            label: 'fAnnouncements',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_rounded),
            label: 'fTasks',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'sRegistrations',
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
