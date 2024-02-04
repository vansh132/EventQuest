import 'package:eventquest/models/task.dart';
import 'package:eventquest/screens/detailed_screens/task_detail_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    List<Task> assignedTasks = [
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
      ),
    ];

    List<Task> historyTasks = [
      Task(
        taskTitle: "XYZ Show",
        taskDescription: "Create poster for it",
        taskType: "Poster",
        assignedTo: "2347152",
        assignedBy: "Helen K Joy",
        taskStatus: "Incomplete",
      ),
      Task(
        taskTitle: "ABC Show",
        taskDescription: "Create poster for it",
        taskType: "Poster",
        assignedTo: "2347152",
        assignedBy: "Helen K Joy",
        taskStatus: "Completed",
      ),
    ];

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

    return Scaffold(
      body: Container(
        // color: Colors.amber,
        child: Column(
          children: [
            TopBar(),
            UserBar(),
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
              child: ListView.builder(
                itemCount:
                    selected ? assignedTasks.length : historyTasks.length,
                itemBuilder: (context, index) => TaskItem(
                  selected ? assignedTasks[index] : historyTasks[index],
                  context,
                ),
              ),
            )
          ],
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
                          text: task.taskStatus,
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
