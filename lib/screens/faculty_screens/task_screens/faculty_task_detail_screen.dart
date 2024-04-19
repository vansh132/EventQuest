import 'package:eventquest/models/task.dart';
import 'package:eventquest/screens/faculty_screens/task_screens/faculty_edit_task_screen.dart';
import 'package:eventquest/services/task_services.dart';
import 'package:eventquest/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FacultyTaskDetailScreen extends StatefulWidget {
  static const String routeName = "/faculty-task-detail-screen";
  const FacultyTaskDetailScreen({super.key});

  @override
  State<FacultyTaskDetailScreen> createState() =>
      _FacultyTaskDetailScreenState();
}

class _FacultyTaskDetailScreenState extends State<FacultyTaskDetailScreen> {
  TextEditingController remarkController = TextEditingController();

  Task task = Task(
      taskTitle: "",
      taskDescription: "",
      taskType: "",
      assignedTo: "",
      assignedBy: "",
      taskStatus: false);
  TaskServices taskServices = TaskServices();

  void addRemark() async {
    await taskServices.addRemarks(
        context: context, taskId: task.taskId, remarks: remarkController.text);
  }

  void markAsCompleted() async {
    await taskServices.markAsCompleted(
        context: context, taskId: task.taskId, taskStatus: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    task = ModalRoute.of(context)!.settings.arguments as Task;
  }

  @override
  void initState() {
    super.initState();
    remarkController.text = "";
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    // final Task tempTask = ModalRoute.of(context)!.settings.arguments as Task;
    return Scaffold(
      floatingActionButton: task.taskStatus
          ? const IconButton(onPressed: null, icon: Icon(Icons.edit))
          : IconButton.filled(
              onPressed: () {
                Navigator.pushNamed(context, FacultyEditTaskScreen.routeName,
                    arguments: task);
              },
              icon: const Icon(
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
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Scaffold(
                              body: Center(
                                child: PhotoView(
                                  imageProvider: NetworkImage(
                                    task.taskFile ??
                                        "https://res.cloudinary.com/dq1q5mtdo/image/upload/f_auto,q_auto/v1/Dummy-images/uo2rk3gkixuyqdznlhqs",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image(
                            image: NetworkImage(task.taskFile ??
                                "https://res.cloudinary.com/dq1q5mtdo/image/upload/f_auto,q_auto/v1/Dummy-images/uo2rk3gkixuyqdznlhqs"),
                          ),
                        ),
                      ),
                    ),

                    //NetworkImage(task.taskFile ??
                    //"https://res.cloudinary.com/dq1q5mtdo/image/upload/f_auto,q_auto/v1/Dummy-images/uo2rk3gkixuyqdznlhqs"))
                    const SizedBox(
                      height: 16,
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
                              color:
                                  Colors.grey.withOpacity(0.3), // Shadow color
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
                            const Divider(
                              indent: 16,
                              endIndent: 16,
                              color: Colors.grey,
                            ),
                            task.remarks != null
                                ? Text(
                                    task.remarks.toString(),
                                    textAlign: TextAlign.justify,
                                  )
                                : const Text("No Remarks"),
                            const SizedBox(
                              height: 4,
                            ),
                            task.taskStatus
                                ? const SizedBox()
                                : ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            child: Container(
                                              padding: const EdgeInsets.all(16),
                                              height: 200,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                        "Give Remarks: "),
                                                    TextFormField(
                                                      controller:
                                                          remarkController,
                                                      minLines: 1,
                                                      maxLines: 3,
                                                    ),
                                                    ElevatedButton(
                                                        onPressed: addRemark,
                                                        child: const Text(
                                                            "Add Remark"))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Text("Add Remarks"),
                                  ),
                          ],
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    task.taskStatus
                        ? const ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.green)),
                            onPressed: null,
                            child: Text(
                              "Task Completed",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ))
                        : ElevatedButton.icon(
                            onPressed: markAsCompleted,
                            icon: const Icon(Icons.done_all_outlined),
                            label: const Text("Mark as Completed"),
                          )
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
