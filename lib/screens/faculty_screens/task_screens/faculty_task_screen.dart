import 'package:eventquest/models/task.dart';
import 'package:eventquest/screens/faculty_screens/task_screens/faculty_add_task_screen.dart';
import 'package:eventquest/screens/faculty_screens/task_screens/faculty_task_detail_screen.dart';
import 'package:eventquest/services/task_services.dart';
import 'package:eventquest/theme/theme_ext.dart';
import 'package:eventquest/themes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final appColors = context.appColors;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                "Manage Your Tasks",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "\"The harder you work for something, the greater you'll feel when you achieve it.\"",
                style: GoogleFonts.raleway(
                  fontSize: 16,
                  color: appColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              // const Divider(
              //   color: Colors.grey,
              //   indent: 36,
              //   endIndent: 36,
              // ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Assigned Tasks",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Container(
                height: 500,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: FutureBuilder(
                  future: getAllTask(),
                  initialData: tasks,
                  builder: (context, snapshot) {
                    if (snapshot.data!.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/task.gif",
                            height: 72,
                            width: 72,
                          ),
                          Text(
                            "No Pending Tasks!",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            "Take this moment to relax and recharge!",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemBuilder: (context, index) =>
                            taskItem(snapshot.data![index], context),
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

Widget taskItem(Task task, BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pushNamed(
      context,
      FacultyTaskDetailScreen.routeName,
      arguments: task,
    ),
    child: Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Shadow color
            spreadRadius: 1, // Spread radius
            blurRadius: 3, // Blur radius
            offset: const Offset(2, 2), // Offset in the x, y direction
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          task.taskTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        subtitle: Text(
          "Assigned To: ${task.assignedTo}",
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.blueGrey.withOpacity(0.8),
              ),
        ),
      ),
    ),
  );
}
