import 'package:eventquest/models/task.dart';
import 'package:eventquest/widgets/top_bar.dart';
import 'package:eventquest/widgets/user_info.dart';
import 'package:flutter/material.dart';

class TaskDetailScreen extends StatefulWidget {
  static const String routeName = '/task-detail-screen';
  const TaskDetailScreen({
    super.key,
  });

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final Task task = ModalRoute.of(context)!.settings.arguments as Task;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopbarTitle(context, task),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              // padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3), // Shadow color
                          spreadRadius: 1, // Spread radius
                          blurRadius: 1, // Blur radius
                          offset: const Offset(
                              0, 3), // Offset in the x, y direction
                        ),
                      ],
                    ),
                    child: Text(
                      task.taskDescription,
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget TopbarTitle(BuildContext context, Task task) {
  return Container(
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    height: 112,
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Color(0xff0D1B2A),
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(72),
      ),
    ),
    child: Text(
      task.taskTitle,
      style: const TextStyle(
        fontSize: 28,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
