import 'package:eventquest/models/task.dart';
import 'package:eventquest/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class FacultyTaskDetailScreen extends StatefulWidget {
  static const String routeName = "/faculty-task-detail-screen";
  const FacultyTaskDetailScreen({super.key});

  @override
  State<FacultyTaskDetailScreen> createState() =>
      _FacultyTaskDetailScreenState();
}

class _FacultyTaskDetailScreenState extends State<FacultyTaskDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final Task task = ModalRoute.of(context)!.settings.arguments as Task;

    return Scaffold(
      floatingActionButton: IconButton.filled(
        onPressed: () {},
        icon: Icon(
          Icons.edit,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopBar(),
              facultyTopbarTitle(context, task),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
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
                      child: Text(
                        task.taskDescription,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
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
                      child: RichText(
                        text: TextSpan(children: [
                          const TextSpan(
                              text: "Status: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              )),
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
                        ]),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "Uploaded Poster",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff0D1B2A),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: const Image(
                          image: AssetImage("assets/images/INHSA.jpeg"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "Remarks",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff0D1B2A),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                      alignment: task.remarks != null
                          ? Alignment.centerLeft
                          : Alignment.center,
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
                      child: task.remarks != null
                          ? Text(
                              task.remarks.toString(),
                              textAlign: TextAlign.justify,
                            )
                          : const Text("No Remarks"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget facultyTopbarTitle(BuildContext context, Task task) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.1,
    width: double.maxFinite,
    margin: const EdgeInsets.all(12),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(3, 7),
        ),
      ],
      color: const Color(0xff0D1B2A),
    ),
    child: Text(
      task.taskTitle,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}
