import 'package:eventquest/models/task.dart';
import 'package:eventquest/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class FacultyTaskScreen extends StatefulWidget {
  const FacultyTaskScreen({super.key});

  @override
  State<FacultyTaskScreen> createState() => _FacultyTaskScreenState();
}

class _FacultyTaskScreenState extends State<FacultyTaskScreen> {
  List<Task> tasks = [
    Task(
      taskTitle: "Talent Show",
      taskDescription: "Create poster for it",
      taskType: "Poster",
      assignedTo: "2347152",
      assignedBy: "Helen K Joy",
      taskStatus: "Incomplete",
    ),
    Task(
      taskTitle: "Talent Show",
      taskDescription:
          "Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it",
      taskType: "Poster",
      assignedTo: "2347152",
      assignedBy: "Helen K Joy",
      taskStatus: "Completed",
      remarks: "feefef",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            TopBar(),
            SizedBox(
              height: 16,
            ),
            Text(
              "Tasks Created",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.2,
              ),
            ),
            Divider(
              color: Colors.grey,
              indent: 36,
              endIndent: 36,
            ),
            Container(
              height: 500,
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: ListView.builder(
                itemBuilder: (context, index) => TaskItem(tasks[index]),
                itemCount: tasks.length,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

Widget TaskItem(Task task) {
  return Container(
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white70,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3), // Shadow color
          spreadRadius: 5, // Spread radius
          blurRadius: 7, // Blur radius
          offset: const Offset(0, 3), // Offset in the x, y direction
        ),
      ],
    ),
    child: ListTile(
      title: Text(
        task.taskTitle,
      ),
      trailing: Text(
        task.taskStatus,
        style: task.taskStatus == "Incomplete"
            ? const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              )
            : const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
      ),
    ),
  );
}
