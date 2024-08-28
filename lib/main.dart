import 'package:event_quest/provider/user_provider.dart';
import 'package:event_quest/router.dart';
import 'package:event_quest/screen_items/custom_navigation_botttom_bar.dart';
import 'package:event_quest/screen_items/faculty_custom_navigation_bottom_bar.dart';
import 'package:event_quest/theme/app_theme.dart';
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
    final theme = AppTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme.light,
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.type == "Student"
          ? const CustomBottomNavigationBar()
          : Provider.of<UserProvider>(context).user.type == "Faculty"
              ? const FacultyCustomBottomBar()
              : const LoginScreen(),
    );
  }
}
