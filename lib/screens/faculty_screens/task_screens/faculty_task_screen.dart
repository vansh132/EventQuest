import 'package:eventquest/models/task.dart';
import 'package:eventquest/screens/faculty_screens/task_screens/faculty_add_task_screen.dart';
import 'package:eventquest/screens/faculty_screens/task_screens/faculty_task_detail_screen.dart';
import 'package:eventquest/services/task_services.dart';
import 'package:eventquest/themes.dart';
import 'package:eventquest/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class FacultyTaskScreen extends StatefulWidget {
  const FacultyTaskScreen({super.key});

  @override
  State<FacultyTaskScreen> createState() => _FacultyTaskScreenState();
}

class _FacultyTaskScreenState extends State<FacultyTaskScreen> {
  List<Task> tasks = [
    // Task(
    //   taskTitle: "Talent Show",
    //   taskDescription:
    //       "Continuing our tradition, we are pleased to announce the forthcoming Talent Show scheduled for February 20th, 2024. This esteemed event will take place at 911, Central Block, providing an esteemed platform for our fresher students to exhibit their talents. The Talent Show serves as an avenue for showcasing diverse skills and abilities, fostering a culture of creativity and expression within our academic community. ",
    //   taskType: "Poster",
    //   assignedTo: "2347152",
    //   assignedBy: "Helen K Joy",
    //   taskStatus: false,
    // ),
    // Task(
    //   taskTitle: "Talent Show",
    //   taskDescription: "Create poster for it",
    //   taskType: "Poster",
    //   assignedTo: "2347152",
    //   assignedBy: "Helen K Joy",
    //   taskStatus: false,
    // ),
    // Task(
    //   taskTitle: "Talent Show",
    //   taskDescription:
    //       "Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it",
    //   taskType: "Poster",
    //   assignedTo: "2347152",
    //   assignedBy: "Helen K Joy",
    //   taskStatus: true,
    //   remarks: "feefef",
    // ),
  ];

  TaskServices taskServices = TaskServices();

  Future<List<Task>> getAllTask() async {
    tasks = await taskServices.getAllTasksForFaculty(context);

    return tasks;
  }

  @override
  void initState() {
    super.initState();

    getAllTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              TopBar(),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Tasks Created",
                style: TextStyle(
                  color: Color(0xff012a4a),
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
                child: FutureBuilder(
                  future: getAllTask(),
                  initialData: tasks,
                  builder: (context, snapshot) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("No data found"),
                      );
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemBuilder: (context, index) =>
                            taskItem(context, snapshot.data![index]),
                        itemCount: tasks.length,
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        onPressed: () {
          Navigator.pushNamed(context, FacultyAddTaskScreen.routeName);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
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
        color: const Color(0xfffbfcf8),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2), // Shadow color
            spreadRadius: 5, // Spread radius
            blurRadius: 7, // Blur radius
            offset: const Offset(0, 3), // Offset in the x, y direction
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          task.taskTitle,
          style: const TextStyle(
            color: Color(0xff012a4a),
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Text(
          task.taskStatus ? "Completed" : "Incompleted",
          style: !task.taskStatus
              ? const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )
              : const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
        ),
      ),
    ),
  );
}
