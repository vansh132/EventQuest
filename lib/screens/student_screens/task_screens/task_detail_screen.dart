import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eventquest/models/task.dart';
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
  void selectImages() async {
    var res = await pickImages();
    setState(() {
      image = res;
    });
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
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return image;
  }

  @override
  Widget build(BuildContext context) {
    final Task task = ModalRoute.of(context)!.settings.arguments as Task;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopbarTitle(context, task),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              // padding: EdgeInsets.all(8),
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
                    height: 20,
                  ),
                  image.existsSync() == true
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
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                  /* images.isNotEmpty
                      ? CarouselSlider(
                          items: images.map((i) {
                            return Builder(
                              builder: (context) => Image.file(
                                i,
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            );
                          }).toList(),
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 200,
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
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                        ), */
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
    );
  }
}

Widget TopbarTitle(BuildContext context, Task task) {
  return Container(
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    height: 112,
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Color(0xff0D1B2A),
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(72),
      ),
    ),
    child: Text(
      task.taskTitle,
      style: const TextStyle(
        fontSize: 28,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
