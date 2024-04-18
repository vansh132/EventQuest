import 'dart:async';

import 'package:eventquest/models/task.dart';
import 'package:eventquest/services/task_services.dart';
import 'package:eventquest/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class FacultyEditTaskScreen extends StatefulWidget {
  static const String routeName = '/faculty-edit-task-screen';
  const FacultyEditTaskScreen({super.key});

  @override
  State<FacultyEditTaskScreen> createState() => _FacultyEditTaskScreenState();
}

class _FacultyEditTaskScreenState extends State<FacultyEditTaskScreen> {
  final _taskFormKey = GlobalKey<FormState>();

  late TextEditingController title;
  late TextEditingController description;
  TaskServices taskServices = TaskServices();

  late Task taskData;

  void editTask() async {
    taskServices.editTask(
      context: context,
      taskId: taskData.taskId,
      taskName: title.text,
      taskDescription: description.text,
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'))
          ],
          title: const Text('Status'),
          content: const Text('Task has edited successfully.'),
        );
      },
    );
    Timer(const Duration(seconds: 3), () {
      Navigator.pop(context); // Go back to previous screen
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    taskData = ModalRoute.of(context)!.settings.arguments as Task;
    title = TextEditingController(text: taskData.taskTitle);
    description = TextEditingController(text: taskData.taskDescription);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: editTask,
        child: const Icon(
          Icons.save,
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            TopBar(),
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Form(
                key: _taskFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Title",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      controller: title,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      controller: description,
                      maxLines: 10,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16),
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
                      child: Column(
                        children: [
                          const Text(
                            "Assigned By:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            taskData.assignedBy,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16),
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
                      child: Column(
                        children: [
                          const Text(
                            "Assigned To:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            taskData.assignedTo,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
