import 'package:eventquest/custome_navigation_botttom_bar.dart';
import 'package:eventquest/screens/detailed_screens/announcement_detail_screen.dart';
import 'package:eventquest/screens/detailed_screens/event_detail_screen.dart';
import 'package:eventquest/screens/event_screen.dart';
import 'package:eventquest/screens/home_screen.dart';
import 'package:eventquest/screens/login_screen.dart';
import 'package:eventquest/screens/registration_screen.dart';
import 'package:eventquest/screens/signup_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case EventScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => EventScreen(),
      );
    case EventDetailsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => EventDetailsScreen(),
      );
    case AnnouncementDetailScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AnnouncementDetailScreen(),
      );
    case RegistrationScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => RegistrationScreen(),
      );
    case CustomBottomNavigationBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CustomBottomNavigationBar(),
      );
    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => LoginScreen(),
      );
    case SignupScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SignupScreen(),
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
