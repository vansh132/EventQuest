import 'package:eventquest/custom_navigation_botttom_bar.dart';
import 'package:eventquest/screens/detailed_screens/announcement_detail_screen.dart';
import 'package:eventquest/screens/detailed_screens/event_detail_screen.dart';
import 'package:eventquest/screens/detailed_screens/task_detail_screen.dart';
import 'package:eventquest/screens/faculty_screens/custom_navigation_bottom_bar.dart';
import 'package:eventquest/screens/login_screen.dart';
import 'package:eventquest/screens/registration_screen.dart';
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
