import 'package:event_quest/models/task.dart';
import 'package:event_quest/screens/student_screens/task_screens/task_detail_screen.dart';
import 'package:event_quest/services/task_services.dart';
import 'package:event_quest/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool selected = true;

  List<Task> assignedTasks = [];

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
    getAllTask();
  }

  @override
  Widget build(BuildContext context) {
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
      // appBar: AppBar(
      //   backgroundColor: appColors.white,
      //   title: Text(
      //     "Manage Your Tasks",
      //     style: Theme.of(context).textTheme.displayMedium,
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
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
                  fontSize: 15,
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
              Container(
                // width: 500,
                // margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                // color: Colors.greenAccent,
                height: 400,
                child: FutureBuilder(
                  future: getAllTask(),
                  initialData: assignedTasks,
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
                            "All tasks completed!",
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
                        itemCount: snapshot.data!.length,
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget taskItem(Task task, BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pushNamed(
      context,
      TaskDetailScreen.routeName,
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
          "Assigned By: ${task.assignedBy}",
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
