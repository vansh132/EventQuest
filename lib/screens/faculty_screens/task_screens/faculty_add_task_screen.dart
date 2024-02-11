import 'package:flutter/material.dart';

class FacultyAddTaskScreen extends StatefulWidget {
  static const String routeName = "/faculty-add-task-screen";
  const FacultyAddTaskScreen({super.key});

  @override
  State<FacultyAddTaskScreen> createState() => _FacultyAddTaskScreenState();
}

class _FacultyAddTaskScreenState extends State<FacultyAddTaskScreen> {
  final _facultyTaskFormKey = GlobalKey<FormState>();

  TextEditingController taskTitle = TextEditingController();
  TextEditingController taskdescription = TextEditingController();
  TextEditingController taskAssignedTo = TextEditingController();

  String dropdownValue = "Poster";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
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
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      controller: taskdescription,
                      decoration: const InputDecoration(
                        labelText: "Description",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "Event Type",
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(10),
                        items: const [
                          DropdownMenuItem<String>(
                            value: 'Poster',
                            child: Text('Poster'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Report',
                            child: Text('Report'),
                          ),
                        ],
                        value: dropdownValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                      ),
                    ),
                    TextFormField(
                      controller: taskAssignedTo,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Register no (2347152)",
                        labelText: "Assign to",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text("Create Task")),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
