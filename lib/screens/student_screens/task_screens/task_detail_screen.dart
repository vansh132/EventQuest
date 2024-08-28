import 'dart:async';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:event_quest/models/task.dart';
import 'package:event_quest/screens/constants/utils.dart';
import 'package:event_quest/services/poster_validation.dart';
import 'package:event_quest/services/task_services.dart';
import 'package:event_quest/theme/theme_ext.dart';
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
  String posterValidationMessage = '';
  bool posterValidationStatus = false;
  late bool taskSubmission;

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
  PosterValidation posterValidation = PosterValidation();

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      image = res;
    });
  }

  void disabledButton() {
    showSnackBar(context, "Submission disabled");
  }

  void clearImage() {
    setState(() {
      posterValidationMessage = "";
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
        context: context,
        taskId: task.taskId,
        posterImage: image,
        taskSubmission: true,
      );
    }
    Navigator.of(context).pop();
  }

  Future<String> verifyLogo(
      File posterImage, int xmin, int xmax, int ymin, int ymax) async {
    var result = await posterValidation.verifyLogo(
      context: context,
      posterImage: posterImage,
      xmin: xmin.toString(),
      ymin: ymin.toString(),
      xmax: xmax.toString(),
      ymax: ymax.toString(),
    );
    return result;
  }

  Future<File> pickImages() async {
    bool logoDetected = false;
    File image = File("");
    try {
      var files = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (files != null && files.files.isNotEmpty) {
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

        image = File(files.files[0].path!);
        var result = await posterValidation.verifyPoster(
            context: context, posterImage: image);
        print("after detecting logo");
        var resultBody = result[0];
        print(resultBody);
        if (resultBody['status']) {
          logoDetected = true;
        } else {
          logoDetected = false;
        }

        String logoVerificationStatus = "";
        if (logoDetected) {
          List<dynamic> boundings = resultBody['bounding_boxes'];
          if (boundings.isEmpty) {
            logoVerificationStatus = "blur logo";
          } else {
            var result = verifyLogo(
              image,
              boundings[0]['xmin'],
              boundings[0]['xmax'],
              boundings[0]['ymin'],
              boundings[0]['ymax'],
            );
            await result.then((data) {
              setState(() {
                logoVerificationStatus = data;
              });
            });
          }
        } else {
          logoVerificationStatus = "no logo";
        }

        // Adding delay of 2 seconds
        await Future.delayed(const Duration(seconds: 2));

        Navigator.pop(context); // Dismiss the dialog
        print("verification status");
        print(logoVerificationStatus);
        if (logoVerificationStatus == "valid poster") {
          posterValidationStatus = true;
          posterValidationMessage = "Hurray, Poster validated successfully...";
        } else if (logoVerificationStatus == "poster not valid") {
          posterValidationStatus = false;
          posterValidationMessage =
              "OOPS, Use valid CHRIST Logo. Please read guidelines...";
        } else if (logoVerificationStatus == "no logo") {
          posterValidationStatus = false;
          posterValidationMessage = "No logo found";
        } else if (logoVerificationStatus == 'blur logo') {
          posterValidationStatus = false;
          posterValidationMessage = "Logo is blur";
        } else {
          posterValidationMessage = "Something went wrong...";
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
    taskSubmission = task.taskSubmission;
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          task.taskTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // topbarTitle(context, task),
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
                      height: 20,
                    ),
                    // Guidelines
                    Text(
                      "Guidelines",
                      style: Theme.of(context).textTheme.titleMedium,
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
                    SizedBox(
                      height: 12,
                    ),
                    posterValidationMessage == ''
                        ? const SizedBox(
                            height: 12,
                          )
                        : Container(
                            padding: const EdgeInsets.all(8),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: posterValidationStatus
                                  ? appColors.success
                                  : appColors.error.withOpacity(0.8),
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              posterValidationMessage,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: appColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                    SizedBox(
                      height: 12,
                    ),
                    task.taskStatus
                        ? const SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton.icon(
                                onPressed: task.taskSubmission == true
                                    ? () {
                                        customSnackbar(context, "Note:",
                                            "Poster in under still review.");
                                      }
                                    : clearImage,
                                label: Text(
                                  task.taskFile != ""
                                      ? "Clear"
                                      : "Clear Submission",
                                ),
                                icon: const Icon(Icons.cancel_outlined),
                              ),
                              ElevatedButton.icon(
                                onPressed: posterValidationStatus == false
                                    ? () {
                                        customSnackbar(context, "Note:",
                                            "Poster in under still review.");
                                      }
                                    : task.taskSubmission == true
                                        ? () {
                                            customSnackbar(context, "Note:",
                                                "Poster in under still review. ");
                                          }
                                        : submitImage,
                                icon: const Icon(
                                    Icons.playlist_add_check_circle_outlined),
                                label: const Text("Submit"),
                              )
                            ],
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Remarks",
                      style: Theme.of(context).textTheme.titleMedium,
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
                      child: (task.remarks != null)
                          ? Text(
                              task.remarks.toString(),
                              textAlign: TextAlign.justify,
                              style:
                                  Theme.of(context).primaryTextTheme.labelSmall,
                            )
                          : Text(
                              "No Remarks",
                              style:
                                  Theme.of(context).primaryTextTheme.labelSmall,
                            ),
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
  final appColors = context.appColors;
  return Container(
    // height: MediaQuery.of(context).size.height * 0.06,
    width: double.maxFinite,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      // borderRadius: const BorderRadius.only(
      //   bottomLeft: Radius.circular(24),
      //   bottomRight: Radius.circular(24),
      // ),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 1,
          offset: const Offset(0, 1),
        ),
      ],
      color: appColors.white,
    ),
    child: Text(
      task.taskTitle,
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: appColors.primary,
      ),
    ),
  );
}

Widget guidelines(BuildContext context) {
  final appColors = context.appColors;
  TextStyle? listTileTextStyle = Theme.of(context).primaryTextTheme.labelSmall;
  ScrollController scrollController = ScrollController();
  return Container(
    height: 128,
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: appColors.accent,
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
        children: [
          ListTile(
            leading: const Icon(Icons.arrow_right),
            title: const Text(
              "Christ (Deemed to be University) logo should be on Top - Right.",
              textAlign: TextAlign.justify,
            ),
            titleTextStyle: listTileTextStyle,
          ),
          ListTile(
            leading: const Icon(Icons.arrow_right),
            title: const Text(
              "\"School of Science\" should be on Bottom - Center.",
              textAlign: TextAlign.justify,
            ),
            titleTextStyle: listTileTextStyle,
          ),
          ListTile(
            leading: const Icon(Icons.arrow_right),
            title: const Text(
              "\"Designed By: (Name) (Register no) (class)\" should be on Bottom - Right.",
              textAlign: TextAlign.justify,
            ),
            titleTextStyle: listTileTextStyle,
          ),
        ],
      ),
    ),
  );
}
