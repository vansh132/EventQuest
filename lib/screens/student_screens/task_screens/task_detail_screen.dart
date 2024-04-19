import 'dart:async';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:eventquest/models/task.dart';
import 'package:eventquest/screens/constants/utils.dart';
import 'package:eventquest/services/task_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class TaskDetailScreen extends StatefulWidget {
  static const String routeName = '/task-detail-screen';
  const TaskDetailScreen({
    super.key,
  });

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  File image = File("");
  bool submitted = false;
  int validation = 0;
  Task task = Task(
      taskTitle: "",
      taskDescription: "",
      taskType: "",
      assignedTo: "",
      assignedBy: "",
      taskStatus: false);
  TaskServices taskServices = TaskServices();

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      image = res;
    });
  }

  void clearImage() {
    setState(() {
      validation = 0;
      task.taskFile = "";
      image = File("");
    });
  }

  void submitImage() async {
    final Task task = ModalRoute.of(context)!.settings.arguments as Task;
    if (image.existsSync() == false) {
      showSnackBar(context, "Please upload file");
      return;
    } else {
      await taskServices.addPoster(
          context: context, taskId: task.taskId, posterImage: image);
    }
    setState(() {
      submitted = true;
    });
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
          content: const Text('Poster Submitted successfully.'),
        );
      },
    );
  }

  Future<File> pickImages() async {
    File image = File("");
    try {
      var files = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (files != null && files.files.isNotEmpty) {
        image = File(files.files[0].path!);
        // image file name
        print("vansh132" + files.files[0].name);
        if (files.files[0].name.split("-")[0] == "christ") {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text(
                        "Processing...",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );

          // Adding delay of 2 seconds
          await Future.delayed(const Duration(seconds: 2));

          Navigator.pop(context); // Dismiss the dialog
          setState(() {
            validation = 1;
          });
        } else {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text(
                        "Processing...",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );

          // Adding delay of 2 seconds
          await Future.delayed(const Duration(seconds: 2));
          Navigator.pop(context); // Dismiss the dialog
          setState(() {
            validation = 2;
            // task.taskFile = "";
            // image = File("");
          });
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return image;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    task = ModalRoute.of(context)!.settings.arguments as Task;
  }

  @override
  Widget build(BuildContext context) {
    Task temptask = ModalRoute.of(context)!.settings.arguments as Task;

    print(temptask);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              topbarTitle(context, task),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                // padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    // Task Description
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
                    // Task Status
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
                      height: 20,
                    ),
                    // Guidelines
                    const Text(
                      "Guidelines",
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
                    guidelines(context),
                    const SizedBox(
                      height: 16,
                    ),
                    //TODO: add hero widget here...
                    //Poster
                    task.taskStatus
                        ? Image(
                            height: 224,
                            image: NetworkImage(task.taskFile ??
                                "https://res.cloudinary.com/dq1q5mtdo/image/upload/f_auto,q_auto/v1/Dummy-images/uo2rk3gkixuyqdznlhqs"))
                        : task.taskFile != ""
                            ? Image(
                                height: 224,
                                image: NetworkImage(task.taskFile ??
                                    "https://res.cloudinary.com/dq1q5mtdo/image/upload/f_auto,q_auto/v1/Dummy-images/uo2rk3gkixuyqdznlhqs"))
                            : image.existsSync() == true
                                ? SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: Image(
                                      image: FileImage(image),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: selectImages,
                                    child: DottedBorder(
                                      radius: const Radius.circular(10),
                                      dashPattern: const [10, 4],
                                      borderType: BorderType.RRect,
                                      strokeCap: StrokeCap.round,
                                      child: Container(
                                        width: double.infinity,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          // color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.folder_open_outlined,
                                              size: 40,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              "Upload Poster",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey.shade400,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                    const SizedBox(
                      height: 12,
                    ),
                    validation == 0
                        ? SizedBox()
                        : validation == 1
                            ? Container(
                                padding: EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  "Poster Validated",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  "One of the guidelines have been violated",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                    task.taskStatus
                        ? const SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton.icon(
                                onPressed:
                                    submitted == true ? null : clearImage,
                                label: Text(
                                  task.taskFile == ""
                                      ? "Clear"
                                      : "Clear Submission",
                                ),
                                icon: const Icon(Icons.cancel_outlined),
                              ),
                              ElevatedButton.icon(
                                onPressed: submitted == true
                                    ? null
                                    : validation == 2
                                        ? null
                                        : submitImage,
                                icon: const Icon(
                                    Icons.playlist_add_check_circle_outlined),
                                label: const Text("Submit"),
                              )
                            ],
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

Widget topbarTitle(BuildContext context, Task task) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.1,
    width: double.maxFinite,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
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

Widget guidelines(BuildContext context) {
  ScrollController scrollController = ScrollController();
  return Container(
    height: 128,
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white70,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3), // Shadow color
          spreadRadius: 1, // Spread radius
          blurRadius: 1, // Blur radius
          offset: const Offset(0, 3), // Offset in the x, y direction
        ),
      ],
    ),
    child: Scrollbar(
      controller: scrollController,
      thumbVisibility: true,
      child: ListView(
        controller: scrollController,
        children: const [
          ListTile(
            leading: Icon(Icons.arrow_right),
            title: Text(
              "Christ (Deemed to be University) logo should be on Top - Right.",
              textAlign: TextAlign.justify,
            ),
            titleTextStyle: TextStyle(
              fontSize: 14,
              letterSpacing: 0.2,
              color: Colors.black,
            ),
          ),
          ListTile(
            leading: Icon(Icons.arrow_right),
            title: Text(
              "\"School of Science\" should be on Bottom - Center.",
              textAlign: TextAlign.justify,
            ),
            titleTextStyle: TextStyle(
              fontSize: 14,
              letterSpacing: 0.2,
              color: Colors.black,
            ),
          ),
          ListTile(
            leading: Icon(Icons.arrow_right),
            title: Text(
              "\"Designed By: (Name) (Register no) (class)\" should be on Bottom - Right.",
              textAlign: TextAlign.justify,
            ),
            titleTextStyle: TextStyle(
              fontSize: 14,
              letterSpacing: 0.2,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
}
