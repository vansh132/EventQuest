import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:event_quest/services/event_services.dart';
import 'package:event_quest/theme/theme_ext.dart';
import 'package:event_quest/themes.dart';
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

  EventServices eventServices = EventServices();

  TextEditingController eventName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController eventAmount = TextEditingController();
  TextEditingController noOfParticipants = TextEditingController();
  TextEditingController eventLink = TextEditingController();
  TextEditingController contactPerson = TextEditingController();
  TextEditingController contactName = TextEditingController();

  void addEvent() {
    eventServices.addEvent(
        context: context,
        eventName: eventName.text,
        eventDescription: description.text,
        eventAmount: double.parse(eventAmount.text),
        eventImage: image,
        eventCategory: dropdownValue,
        eventPublishedOn: DateTime.now(),
        eventNoOfParticipants: int.parse(noOfParticipants.text),
        eventLink: eventLink.text,
        eventContactPerson: contactName.text,
        eventContactNo: int.parse(contactPerson.text),
        eventRegistartionDeadline: _registrationDeadline!);
  }

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
    final appColor = context.appColors;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor.accent,
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
                  style: Theme.of(context).textTheme.bodyLarge,
                  controller: eventName,
                  decoration: InputDecoration(
                    labelText: "Event Name",
                    labelStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Event Title';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  controller: description,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Event Description';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Text("Event Type",
                    style: Theme.of(context).textTheme.bodyLarge),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    dropdownColor: appColor.accent,
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(20),
                    items: [
                      DropdownMenuItem<String>(
                        value: 'UG',
                        child: Text(
                          'UG',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: 'PG',
                        child: Text(
                          'PG',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Both',
                        child: Text(
                          'Both',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
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
                const SizedBox(
                  height: 8,
                ),
                Text("Upload Image",
                    style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(
                  height: 16,
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
                                  style: Theme.of(context).textTheme.bodyLarge,
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

                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  controller: eventAmount,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Event Amount",
                    labelStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Event Amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  controller: noOfParticipants,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelStyle: Theme.of(context).textTheme.bodyLarge,
                    labelText: "No Of Participant",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter No Of Participants';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  controller: eventLink,
                  decoration: InputDecoration(
                    labelText: "Event Link",
                    labelStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  controller: contactName,
                  decoration: InputDecoration(
                    labelText: "Contact Name",
                    labelStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Contact Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  controller: contactPerson,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Contact No",
                    labelStyle: Theme.of(context).textTheme.bodyLarge,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter contact number';
                    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return 'Contact number must be exactly 10 digits';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 14,
                ),
                // Date picker for Registration Deadline
                Text(
                  "Registration Deadline",
                  style: Theme.of(context).textTheme.bodyLarge,
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
                Center(
                    child: ElevatedButton(
                        onPressed: () {
                          // Validate the form
                          if (_formKey.currentState!.validate()) {
                            if (image.path.isEmpty) {
                              // If no image selected, show an alert dialog
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: appColor.accent,
                                  title: Text(
                                    'Image Required',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  content: const Text(
                                      'Please select an image to upload.'),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: appColor.primary,
                                          foregroundColor: appColor.white),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            } // Check if the registration deadline is selected
                            else if (_registrationDeadline == null) {
                              // If no deadline is selected, show an alert dialog
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: appColor.accent,
                                  title: Text(
                                    'Registration Deadline Required',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  content: const Text(
                                      'Please select a registration deadline.'),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: appColor.primary,
                                          foregroundColor: appColor.white),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              // If the image is selected, proceed to add the event
                              addEvent();
                            }
                          }
                        },
                        child: const Text('Add Event')))
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
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: AppColors.primaryColor, // Header background color
              colorScheme: ColorScheme.light(primary: AppColors.primaryColor),
              buttonTheme: const ButtonThemeData(
                textTheme: ButtonTextTheme.primary, // Button text color
              ),
            ),
            child: child!,
          );
        });

    if (pickedDate != null) {
      setState(() {
        _registrationDeadline = pickedDate;
      });
    }
  }
}
