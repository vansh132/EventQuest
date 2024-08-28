import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:event_quest/models/announcement.dart';
import 'package:event_quest/services/announcement_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class EditAnnouncementScreen extends StatefulWidget {
  static const String routeName = "edit_announcement_screen";
  const EditAnnouncementScreen({Key? key}) : super(key: key);

  @override
  State<EditAnnouncementScreen> createState() => _EditAnnouncementScreenState();
}

class _EditAnnouncementScreenState extends State<EditAnnouncementScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController announcementTitle;
  late TextEditingController announcementDescription;
  bool updateImageFlag = false;
  late Announcement announcementData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    announcementData =
        ModalRoute.of(context)!.settings.arguments as Announcement;
    announcementTitle =
        TextEditingController(text: announcementData.announcementTitle);
    announcementDescription =
        TextEditingController(text: announcementData.announcementDescription);
  }

  @override
  void dispose() {
    announcementTitle.dispose();
    announcementDescription.dispose();

    super.dispose();
  }

  bool isDataChanged() {
    return announcementTitle.text != announcementData.announcementTitle ||
        announcementDescription.text !=
            announcementData.announcementDescription ||
        announcementImages != announcementData.announcementImages;
  }

  List<File> announcementImages = [];
  bool submitted = false;
  void selectImages() async {
    var res = await pickImages();
    setState(() {
      announcementImages = res;
    });
  }

  Future<List<File>> pickImages() async {
    List<File> announcementImages = [];
    try {
      var files = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (files != null && files.files.isNotEmpty) {
        for (int i = 0; i < files.files.length; i++) {
          announcementImages.add(File(files.files[i].path!));
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return announcementImages;
  }

  void clearImage() {
    setState(() {
      updateImageFlag = true;
      announcementImages = [];
    });
  }

  AnnouncementServices announcementServices = AnnouncementServices();

  void updateAnnouncement() {
    announcementServices.updateAnnouncement(
        context: context,
        existingImages: announcementData.announcementImages as List<String>,
        imageUpdateFlag: updateImageFlag,
        announcementId: announcementData.announcementId,
        announcementTitle: announcementTitle.text,
        announcementDescription: announcementDescription.text,
        announcementImages: announcementImages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Announcement'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Announcement Title",
                    style: Theme.of(context).textTheme.titleMedium),
                TextFormField(
                  controller: announcementTitle,
                  onChanged: (value) {
                    setState(() {});
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Announcement Title';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Enter announcement title",
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Text("Description",
                    style: Theme.of(context).textTheme.titleMedium),
                TextFormField(
                  controller: announcementDescription,
                  onChanged: (value) {
                    setState(() {});
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Announcement Description';
                    }
                    return null;
                  },
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: "Enter announcement description",
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Announcement Image",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 16,
                ),
                updateImageFlag == false
                    ? CarouselSlider(
                        items: announcementData.announcementImages!.map((i) {
                          return Builder(
                            builder: (context) => Image.network(
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
                    : announcementImages.isNotEmpty
                        ? CarouselSlider(
                            items: announcementImages.map((i) {
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
                const SizedBox(
                  height: 16,
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
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: isDataChanged()
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              updateAnnouncement();
                            }
                          }
                        : null,
                    child: const Text('Update'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
