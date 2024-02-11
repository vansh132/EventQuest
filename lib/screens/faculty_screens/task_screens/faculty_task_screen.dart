import 'package:eventquest/models/task.dart';
import 'package:eventquest/screens/faculty_screens/task_screens/faculty_add_task_screen.dart';
import 'package:eventquest/screens/faculty_screens/task_screens/faculty_task_detail_screen.dart';
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
      taskDescription:
          "Continuing our tradition, we are pleased to announce the forthcoming Talent Show scheduled for February 20th, 2024. This esteemed event will take place at 911, Central Block, providing an esteemed platform for our fresher students to exhibit their talents. The Talent Show serves as an avenue for showcasing diverse skills and abilities, fostering a culture of creativity and expression within our academic community. ",
      taskType: "Poster",
      assignedTo: "2347152",
      assignedBy: "Helen K Joy",
      taskStatus: "Incomplete",
    ),
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
      body: Column(
        children: [
          TopBar(),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Tasks Created",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
            ),
          ),
          const Divider(
            color: Colors.grey,
            indent: 36,
            endIndent: 36,
          ),
          Container(
            height: 500,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
              itemBuilder: (context, index) => taskItem(context, tasks[index]),
              itemCount: tasks.length,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, FacultyAddTaskScreen.routeName);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

Widget taskItem(BuildContext context, Task task) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, FacultyTaskDetailScreen.routeName,
          arguments: task);
    },
    child: Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
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
    ),
  );
}
