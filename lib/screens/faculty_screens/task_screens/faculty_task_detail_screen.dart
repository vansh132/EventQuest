import 'package:eventquest/models/task.dart';
import 'package:eventquest/screens/faculty_screens/task_screens/faculty_edit_task_screen.dart';
import 'package:eventquest/services/task_services.dart';
import 'package:eventquest/theme/theme_ext.dart';
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
    taskStatus: false,
    taskSubmission: false,
  );
  TaskServices taskServices = TaskServices();

  void addRemark() async {
    await taskServices.addRemarks(
      context: context,
      taskId: task.taskId,
      remarks: remarkController.text,
      taskSubmission: false,
    );
    Navigator.of(context).pop();
  }

  void markAsCompleted() async {
    await taskServices.markAsCompleted(
        context: context, taskId: task.taskId, taskStatus: true);

    Navigator.of(context).pop();
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
    final appColors = context.appColors;
    // final Task tempTask = ModalRoute.of(context)!.settings.arguments as Task;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          task.taskTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      floatingActionButton: task.taskStatus
          ? const FloatingActionButton(onPressed: null, child: Icon(Icons.edit))
          : FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, FacultyEditTaskScreen.routeName,
                    arguments: task);
              },
              tooltip: "Edit",
              child: const Icon(
                Icons.edit,
              ),
            ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                        color: appColors.accent,
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
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    // Task Status
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: appColors.accent,
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
                          TextSpan(
                            text: "Status: ",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: appColors.richBlack,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          TextSpan(
                            text: task.taskStatus ? "Completed" : "Incompleted",
                            style: !task.taskStatus
                                ? Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      color: appColors.error,
                                      fontWeight: FontWeight.w500,
                                    )
                                : Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      color: appColors.success,
                                    ),
                          ),
                        ]),
                        textAlign: TextAlign.justify,
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Uploaded Poster",
                      style: Theme.of(context).textTheme.titleMedium,
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
                          color: appColors.accent,
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
                            Text(
                              "Remarks",
                              style: Theme.of(context).textTheme.titleMedium,
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
                                : Text(
                                    "No Remarks",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .labelSmall,
                                  ),
                            const SizedBox(
                              height: 8,
                            ),
                            task.taskStatus
                                ? const SizedBox()
                                : ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            backgroundColor: appColors.accent,
                                            child: Container(
                                              margin: EdgeInsets.all(16),
                                              padding: const EdgeInsets.all(16),
                                              height: 200,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Give Remarks: ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium,
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          remarkController,
                                                      minLines: 1,
                                                      maxLines: 3,
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Center(
                                                      child: ElevatedButton(
                                                          onPressed: addRemark,
                                                          child: const Text(
                                                              "Add Remark")),
                                                    )
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
