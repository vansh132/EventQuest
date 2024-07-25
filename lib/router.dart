import 'package:eventquest/screen_items/custom_navigation_botttom_bar.dart';
import 'package:eventquest/screen_items/faculty_custom_navigation_bottom_bar.dart';
import 'package:eventquest/screens/faculty_screens/announcement_screens/add_announcement_screen.dart';
import 'package:eventquest/screens/faculty_screens/announcement_screens/edit_announcement_screen.dart';
import 'package:eventquest/screens/faculty_screens/api_screen.dart';

import 'package:eventquest/screens/faculty_screens/event_screens/add_event_screen.dart';
import 'package:eventquest/screens/faculty_screens/event_screens/edit_event_screen.dart';
import 'package:eventquest/screens/faculty_screens/registration_screen/faculty_registration_screen.dart';
import 'package:eventquest/screens/faculty_screens/task_screens/faculty_add_task_screen.dart';
import 'package:eventquest/screens/faculty_screens/task_screens/faculty_edit_task_screen.dart';
import 'package:eventquest/screens/faculty_screens/task_screens/faculty_task_detail_screen.dart';
import 'package:eventquest/screens/login_screen.dart';
import 'package:eventquest/screens/student_screens/announcement_screens/announcement_detail_screen.dart';
import 'package:eventquest/screens/student_screens/event_screens/editReportScrreen.dart';
import 'package:eventquest/screens/student_screens/event_screens/event_detail_screen.dart';
import 'package:eventquest/screens/student_screens/registration_screens/registration_screen.dart';
import 'package:eventquest/screens/student_screens/task_screens/task_detail_screen.dart';
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
    case AddAnnouncementScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddAnnouncementScreen(),
      );
    case EditAnnouncementScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => EditAnnouncementScreen(),
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
    case FacultyEditTaskScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const FacultyEditTaskScreen(),
      );
    case FacultyAddTaskScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const FacultyAddTaskScreen(),
      );
    case FacultyRegistrationScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const FacultyRegistrationScreen(),
      );
    case ApiScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ApiScreen(),
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
