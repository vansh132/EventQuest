import 'package:eventquest/custom_navigation_botttom_bar.dart';
import 'package:eventquest/screens/detailed_screens/announcement_detail_screen.dart';
import 'package:eventquest/screens/detailed_screens/event_detail_screen.dart';
import 'package:eventquest/screens/detailed_screens/task_detail_screen.dart';
import 'package:eventquest/screens/faculty_screens/custom_navigation_bottom_bar.dart';
import 'package:eventquest/screens/faculty_screens/event_screens/add_event_screen.dart';
import 'package:eventquest/screens/faculty_screens/event_screens/edit_event_screen.dart';
import 'package:eventquest/screens/faculty_screens/screens/task_screens/f_task_detail_screen.dart';
import 'package:eventquest/screens/student_screens/login_screen.dart';
import 'package:eventquest/screens/student_screens/registration_screen.dart';
// import 'package:eventquest/screens/signup_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case EventDetailsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const EventDetailsScreen(),
      );
    case TaskDetailScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const TaskDetailScreen(),
      );
    case AnnouncementDetailScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AnnouncementDetailScreen(),
      );
    case RegistrationScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const RegistrationScreen(),
      );
    case CustomBottomNavigationBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CustomBottomNavigationBar(),
      );
    case AddEventScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddEventScreen(),
      );
    case EditEventScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const EditEventScreen(),
      );
    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );
    //faculty screeens navigation
    case FacultyCustomBottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const FacultyCustomBottomBar(),
      );
    case FacultyTaskDetailScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const FacultyTaskDetailScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
