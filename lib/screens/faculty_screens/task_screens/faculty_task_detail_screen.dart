import 'package:eventquest/widgets/top_bar.dart';
import 'package:eventquest/widgets/user_info.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            TopBar(),
          ],
        )),
      ),
    );
  }
}
