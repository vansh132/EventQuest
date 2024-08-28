import 'dart:async';

import 'package:event_quest/services/task_services.dart';
import 'package:flutter/material.dart';

class FacultyAddTaskScreen extends StatefulWidget {
  static const String routeName = "/faculty-add-task-screen";
  const FacultyAddTaskScreen({super.key});

  @override
  State<FacultyAddTaskScreen> createState() => _FacultyAddTaskScreenState();
}

class _FacultyAddTaskScreenState extends State<FacultyAddTaskScreen> {
  final _facultyTaskFormKey = GlobalKey<FormState>();
  final TaskServices taskServices = TaskServices();

  void addTask() {
    taskServices.addTask(
      context: context,
      taskTitle: taskTitle.text,
      taskDescription: taskdescription.text,
      taskType: dropdownValue,
      assignedTo: taskAssignedTo.text,
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
          content: const Text('Task has been Assigned successfully.'),
        );
      },
    );
    Timer(const Duration(seconds: 3), () {
      Navigator.pop(context); // Go back to previous screen
    });
  }

  TextEditingController taskTitle = TextEditingController();
  TextEditingController taskdescription = TextEditingController();
  TextEditingController taskAssignedTo = TextEditingController();

  String dropdownValue = "Poster";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Task"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Form(
                key: _facultyTaskFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: taskTitle,
                      decoration: const InputDecoration(
                        labelText: "Task Title",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Task Title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      controller: taskdescription,
                      decoration: const InputDecoration(
                        labelText: "Description",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Task Description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // const Text(
                    //   "Event Type",
                    //   style: TextStyle(fontSize: 16),
                    // ),
                    // Container(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: DropdownButton<String>(
                    //     isExpanded: true,
                    //     borderRadius: BorderRadius.circular(10),
                    //     items: const [
                    //       DropdownMenuItem<String>(
                    //         value: 'Poster',
                    //         child: Text('Poster'),
                    //       ),
                    //       // DropdownMenuItem<String>(
                    //       //   value: 'Report',
                    //       //   child: Text('Report'),
                    //       // ),
                    //     ],
                    //     value: dropdownValue,
                    //     onChanged: (String? newValue) {
                    //       setState(() {
                    //         dropdownValue = newValue!;
                    //       });
                    //     },
                    //   ),
                    // ),
                    TextFormField(
                      controller: taskAssignedTo,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: "Register no (2347152)",
                          labelText: "Assign to",
                          hintStyle: TextStyle(
                            color: Color(0xffd4dcdf),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Register Number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {
                            if (_facultyTaskFormKey.currentState!.validate()) {
                              addTask();
                            }
                          },
                          child: const Text("Create Task")),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
