import 'package:eventquest/provider/user_provider.dart';
import 'package:eventquest/router.dart';
import 'package:eventquest/screen_items/custom_navigation_botttom_bar.dart';
import 'package:eventquest/screen_items/faculty_custom_navigation_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(fontFamily: 'Roboto'),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.type == "Student"
          ? CustomBottomNavigationBar()
          : Provider.of<UserProvider>(context).user.type == "Faculty"
              ? FacultyCustomBottomBar()
              : LoginScreen(),
    );
  }
}
