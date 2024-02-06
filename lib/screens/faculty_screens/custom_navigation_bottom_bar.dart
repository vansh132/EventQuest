import 'package:flutter/material.dart';

class FacultyCustomBottomBar extends StatefulWidget {
  static const String routeName = "/faculty-custom-navigation-bottom-bar";
  const FacultyCustomBottomBar({super.key});

  @override
  State<FacultyCustomBottomBar> createState() => _FacultyCustomBottomBarState();
}

class _FacultyCustomBottomBarState extends State<FacultyCustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("data"),
      ),
    );
  }
}
