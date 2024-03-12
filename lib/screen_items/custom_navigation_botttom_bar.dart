import 'package:eventquest/screens/student_screens/announcement_screens/announcement_screen.dart';
import 'package:eventquest/screens/student_screens/event_screens/event_screen.dart';
import 'package:eventquest/screens/student_screens/home_screen.dart';
import 'package:eventquest/screens/student_screens/task_screens/task_screen.dart';

import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  static const String routeName = 'custom-navigation-screen';
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

int _selectedIndex = 0;

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      const HomeScreen(),
      const EventScreen(),
      AnnouncementScreen(),
      const TaskScreen(),
    ];

    void onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      body: SafeArea(child: widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff002848),
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
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.amber[800],
        onTap: onItemTapped,
      ),
    );
  }
}
