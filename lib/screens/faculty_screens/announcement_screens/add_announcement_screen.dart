import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:eventquest/models/announcement.dart';
import 'package:eventquest/providers/announcement_notifier.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddAnnouncementScreen extends ConsumerStatefulWidget {
  static const String routeName = '/add-announcement-screen';
  const AddAnnouncementScreen({super.key});

  @override
  ConsumerState<AddAnnouncementScreen> createState() =>
      _AddAnnouncementScreenState();
}

class _AddAnnouncementScreenState extends ConsumerState<AddAnnouncementScreen> {
  final title = TextEditingController();
  final description = TextEditingController();
  final publishBy = TextEditingController();

  // TODO: Do it for multiple images
  File image = File("");
  bool submitted = false;
  void selectImages() async {
    var res = await pickImages();
    setState(() {
      image = res;
    });
  }

  void _saveAnnouncement() {
    final enteredTitle = title.text;
    final enteredDescription = description.text;
    final enteredPublishBy = publishBy.text;
    final enteredPublishOn = DateTime(2024, 1, 23);
    // final enteredImage = image;
    final announcement = Announcement(
      id: "1",
      title: enteredTitle,
      description: enteredDescription,
      publishedBy: enteredPublishBy,
      publishedOn: enteredPublishOn,
    );

    ref.read(announcementProvider.notifier).addAnnouncement(announcement);
    Navigator.of(context).pop();
  }

  Future<File> pickImages() async {
    File image = File("");
    try {
      var files = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (files != null && files.files.isNotEmpty) {
        image = File(files.files[0].path!);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return image;
  }

  void clearImage() {
    setState(() {
      image = File("");
    });
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcement Form'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: title,
                  decoration: const InputDecoration(
                    labelText: "Announcement Title",
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                TextFormField(
                  controller: description,
                  decoration: const InputDecoration(
                    labelText: "Description",
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Upload Image",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 8,
                ),
                image.existsSync() == true
                    ? Center(
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: Image(
                            image: FileImage(image),
                          ),
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
                                  "Upload Announcement Images",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      onPressed: submitted == true ? null : clearImage,
                      label: const Text(
                        "Clear",
                      ),
                      icon: const Icon(Icons.cancel_outlined),
                    ),
                  ],
                ),
                TextFormField(
                  controller: publishBy,
                  decoration: const InputDecoration(
                    labelText: "Publish By",
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Center(
                    child: ElevatedButton(
                        onPressed: _saveAnnouncement, child: Text('Submit')))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
