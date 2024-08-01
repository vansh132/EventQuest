import 'package:eventquest/models/task.dart';
import 'package:eventquest/screens/student_screens/task_screens/task_detail_screen.dart';
import 'package:eventquest/services/task_services.dart';
import 'package:eventquest/theme/theme_ext.dart';
import 'package:eventquest/widgets/top_bar.dart';
import 'package:eventquest/widgets/user_info.dart';
import 'package:flutter/material.dart';

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
    // getAllTask();
  }

  ButtonStyle selectedButtonStyle = const ButtonStyle(
    padding: MaterialStatePropertyAll(EdgeInsets.all(16)),
    backgroundColor: MaterialStatePropertyAll(
      Colors.black,
    ),
  );

  ButtonStyle unselectedButtonStyle = const ButtonStyle(
    padding: MaterialStatePropertyAll(EdgeInsets.all(16)),
  );

  TextStyle selectedTextStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.3,
    fontSize: 14,
  );

  TextStyle unselectedTextStyle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.3,
    fontSize: 14,
  );

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.amber,
          child: Column(
            children: [
              TopBar(),
              UserBar(context),
              //TODO: Search bar can be added (last)
              Container(
                // color: Colors.tealAccent,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: selected
                                ? selectedButtonStyle
                                : unselectedButtonStyle,
                            onPressed: () {
                              setState(() {
                                selected = true;
                              });
                            },
                            child: Text(
                              "Assigned Tasks",
                              style: selected
                                  ? selectedTextStyle
                                  : unselectedTextStyle,
                            ),
                          ),
                          const SizedBox(
                            width: 72,
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                selected = false;
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
              ),
              Container(
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
              Container(
                width: double.infinity,
                color: colors.accent,
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Create Task"),
                ),
              ),
              Container(
                width: double.infinity,
                color: colors.accent,
                padding: EdgeInsets.all(8),
                child: Text(
                  "Manage your tasks",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Container(
                width: double.infinity,
                color: colors.accent,
                padding: EdgeInsets.all(8),
                child: Text(
                  "Gateways 2023",
                  style: Theme.of(context).primaryTextTheme.labelLarge,
                ),
              ),
              Container(
                width: double.infinity,
                color: colors.accent,
                padding: EdgeInsets.all(8),
                child: Text(
                  textAlign: TextAlign.justify,
                  "Heartiest congratulations to all the brilliant students who have achieved remarkable success and secured placements! Your hard work, dedication, and exceptional skills have paved the way for this significant accomplishment. Wishing you a future filled with continued success, growth, and prosperity. Well done!Heartiest congratulations to all the brilliant students who have achieved remarkable success and secured placements! Your hard work, dedication, and exceptional skills have paved the way for this significant accomplishment. Wishing you a future filled with continued success, growth, and prosperity. Well done!Heartiest congratulations to all the brilliant students who have achieved remarkable success and secured placements! Your hard work, dedication, and exceptional skills have paved the way for this significant accomplishment. Wishing you a future filled with continued success, growth, and prosperity. Well done!",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
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
