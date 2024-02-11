import 'package:eventquest/models/task.dart';
import 'package:eventquest/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class FacultyTaskDetailScreen extends StatefulWidget {
  static const String routeName = "/faculty-task-detail-screen";
  const FacultyTaskDetailScreen({super.key});

  @override
  State<FacultyTaskDetailScreen> createState() =>
      _FacultyTaskDetailScreenState();
}

class _FacultyTaskDetailScreenState extends State<FacultyTaskDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final Task task = ModalRoute.of(context)!.settings.arguments as Task;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopBar(),
              facultyTopbarTitle(context, task),
            ],
          ),
        ),
      ),
    );
  }
}

Widget facultyTopbarTitle(BuildContext context, Task task) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.1,
    width: double.maxFinite,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(3, 7),
        ),
      ],
      color: const Color(0xff0D1B2A),
    ),
    child: Text(
      task.taskTitle,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}
