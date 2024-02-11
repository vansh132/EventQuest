import 'package:eventquest/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class FacultyEditTaskScreen extends StatefulWidget {
  static const String routeName = '/faculty-edit-task-screen';
  const FacultyEditTaskScreen({super.key});

  @override
  State<FacultyEditTaskScreen> createState() => _FacultyEditTaskScreenState();
}

class _FacultyEditTaskScreenState extends State<FacultyEditTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          TopBar(),
          Container(
            child: Form(
                child: Column(
              children: [
                TextFormField(),
              ],
            )),
          )
        ],
      )),
    );
  }
}
