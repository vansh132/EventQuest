import 'package:eventquest/models/task.dart';
import 'package:eventquest/screens/student_screens/task_screens/task_detail_screen.dart';
import 'package:eventquest/services/task_services.dart';
import 'package:eventquest/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool selected = true;

  List<Task> assignedTasks = [
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
    //   taskDescription:
    //       "Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it Create poster for it",
    //   taskType: "Poster",
    //   assignedTo: "2347152",
    //   assignedBy: "Helen K Joy",
    //   taskStatus: true,
    //   remarks: ["feefef"],
    // ),
  ];

  TaskServices taskServices = TaskServices();

  Future<List<Task>> getAllTask() async {
    if (selected) {
      assignedTasks = await taskServices.getAllTasks(context);
    } else {
      assignedTasks = await taskServices.getAllCompletedTasks(context);
    }

    return assignedTasks;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getAllTask();
    // TODO: implement didChangeDependencies
  }

  @override
  Widget build(BuildContext context) {
    print(assignedTasks);
    print(assignedTasks.isEmpty.toString() + "dede");
    print(selected);
    final appColors = context.appColors;

    ButtonStyle selectedButtonStyle = ButtonStyle(
      padding: const WidgetStatePropertyAll(EdgeInsets.all(16)),
      backgroundColor: WidgetStatePropertyAll(
        appColors.primary,
      ),
    );

    ButtonStyle unselectedButtonStyle = ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(appColors.white),
      padding: const WidgetStatePropertyAll(EdgeInsets.all(16)),
    );

    TextStyle selectedTextStyle =
        Theme.of(context).textTheme.titleSmall!.copyWith(
              color: appColors.white,
            );

    TextStyle unselectedTextStyle =
        Theme.of(context).textTheme.titleSmall as TextStyle;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.white,
        title: Text(
          "Manage Your Tasks",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          child: Column(
            children: [
              Text(
                "\"The harder you work for something, the greater you'll feel when you achieve it.\"",
                style: GoogleFonts.raleway(
                  fontSize: 14,
                  color: appColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                          style: selected
                              ? selectedButtonStyle
                              : unselectedButtonStyle,
                          onPressed: () {
                            setState(() {
                              selected = true;
                              // getAllTask();
                            });
                          },
                          child: Text(
                            "Assigned Tasks",
                            style: selected
                                ? selectedTextStyle
                                : unselectedTextStyle,
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            setState(() {
                              selected = false;
                              // getAllTask();
                            });
                          },
                          style: selected
                              ? unselectedButtonStyle
                              : selectedButtonStyle,
                          child: Text(
                            "History",
                            style: selected
                                ? unselectedTextStyle
                                : selectedTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              assignedTasks.isEmpty
                  ? Center(
                      child: Text("data"),
                    )
                  : Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(16),
                      // color: Colors.greenAccent,
                      height: 400,
                      child: FutureBuilder(
                        future: getAllTask(),
                        initialData: assignedTasks,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemBuilder: (context, index) =>
                                  TaskItem(snapshot.data![index], context),
                              itemCount: snapshot.data!.length,
                            );
                          } else if (snapshot.data == null) {
                            return const Center(
                              child: Text("No data found"),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),

              // Container(
              //   margin: const EdgeInsets.all(8),
              //   padding: const EdgeInsets.all(16),
              //   // color: Colors.greenAccent,
              //   height: 400,
              //   child: FutureBuilder(
              //     future: getAllTask(),
              //     initialData: assignedTasks,
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return ListView.builder(
              //           itemBuilder: (context, index) =>
              //               TaskItem(snapshot.data![index], context),
              //           itemCount: snapshot.data!.length,
              //         );
              //       } else if (snapshot.data == null) {
              //         return const Center(
              //           child: Text("No data found"),
              //         );
              //       } else {
              //         return const CircularProgressIndicator();
              //       }
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget TaskItem(Task task, BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pushNamed(
      context,
      TaskDetailScreen.routeName,
      arguments: task,
    ),
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white60,
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
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        subtitle: Column(
          children: [
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 3,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Type: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: task.taskType,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Status: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: task.taskStatus ? "Completed" : "Incompleted",
                          style: !task.taskStatus
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
