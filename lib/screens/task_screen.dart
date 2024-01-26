import 'package:eventquest/models/task.dart';
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
        color: Colors.amber,
        child: Column(
          children: [
            TopBar(),
            UserBar(),
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
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(16),
              // color: Colors.greenAccent,
              height: 500,
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) => TaskItem(tasks[index]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget TaskItem(Task task) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white60,
      borderRadius: BorderRadius.circular(12),
    ),
    child: ListTile(
      title: Text(
        task.taskTitle,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),

      subtitle: Column(
        children: [
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Type: ",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: task.taskType,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
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
                          ? TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            )
                          : TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                    ),
                  ],
                ),
              ),
              if (task.file != null)
                Text(
                    'File: ${task.file!.path}'), // Display file path, modify as needed
              if (task.remarks != null) Text('Remarks: ${task.remarks}'),
            ],
          ),
        ],
      ),
      // Additional widgets for file, remarks, etc. can be added here
    ),
  );
}
