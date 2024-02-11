import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddEventScreen extends StatefulWidget {
  static const String routeName = "add-event-screen";
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();

  String dropdownValue = "UG";

  DateTime? _registrationDeadline;

//
  File image = File("");
  bool submitted = false;
  void selectImages() async {
    var res = await pickImages();
    setState(() {
      image = res;
    });
  }

  void clearImage() {
    setState(() {
      image = File("");
    });
  }

  // void submitImage() {
  //   if (image.existsSync() == false) {
  //     showSnackBar(context, "Please upload file");
  //     return;
  //   }
  //   setState(() {
  //     submitted = true;
  //   });
  // }

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
    TextEditingController eventName = TextEditingController();
    TextEditingController description = TextEditingController();
    TextEditingController eventAmount = TextEditingController();
    TextEditingController noOfParticipants = TextEditingController();
    TextEditingController eventLink = TextEditingController();
    TextEditingController contactPerson = TextEditingController();
    TextEditingController contactName = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Form'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          // Form
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: eventName,
                  decoration: const InputDecoration(
                    labelText: "Event Name",
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
                  "Event Type",
                  style: TextStyle(fontSize: 18),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(10),
                    items: const [
                      DropdownMenuItem<String>(
                        value: 'UG',
                        child: Text('UG'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'PG',
                        child: Text('PG'),
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
                                  "Upload Event Image",
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
                    // ElevatedButton.icon(
                    //   onPressed: submitted == true ? null : submitImage,
                    //   icon:
                    //       const Icon(Icons.playlist_add_check_circle_outlined),
                    //   label: const Text("Submit"),
                    // )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),

                TextFormField(
                  controller: eventAmount,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Event Amount",
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                TextFormField(
                  controller: noOfParticipants,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "No Of Participant",
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                TextFormField(
                  controller: eventLink,
                  decoration: const InputDecoration(
                    labelText: "Event Link",
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                TextFormField(
                  controller: contactName,
                  decoration: const InputDecoration(
                    labelText: "Contact Name",
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                TextFormField(
                  controller: contactPerson,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Contact Person",
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                // Date picker for Registration Deadline
                const Text(
                  "Registration Deadline",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                    onTap: () {
                      _pickRegistrationDeadline();
                    },
                    child: registartionDeadline()),
                const SizedBox(
                  height: 14,
                ),
                const Center(
                    child:
                        ElevatedButton(onPressed: null, child: Text('Submit')))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget registartionDeadline() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        _registrationDeadline == null
            ? 'Select Registration Deadline'
            : '${_registrationDeadline!.day} / ${_registrationDeadline!.month} / ${_registrationDeadline!.year}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  void _pickRegistrationDeadline() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _registrationDeadline = pickedDate;
      });
    }
  }
}
