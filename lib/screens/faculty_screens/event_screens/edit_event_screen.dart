import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:eventquest/models/event.dart';
import 'package:eventquest/services/event_services.dart';
import 'package:eventquest/theme/theme_ext.dart';
import 'package:eventquest/themes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class EditEventScreen extends StatefulWidget {
  static const String routeName = "edit_event_screen";
  const EditEventScreen({super.key});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final _formKey = GlobalKey<FormState>();

  String dropdownValue = 'UG';

  late TextEditingController eventName;
  late TextEditingController eventDescription;
  late TextEditingController eventAmount;
  late TextEditingController eventNoOfParticipants;
  late TextEditingController eventLink;
  late TextEditingController eventContactPerson;
  late TextEditingController eventContactNo;
  late Event eventData;
  EventServices eventServices = EventServices();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    eventData = ModalRoute.of(context)!.settings.arguments as Event;
    eventName = TextEditingController(text: eventData.eventName);
    eventDescription = TextEditingController(text: eventData.eventDescription);

    eventAmount = TextEditingController(text: eventData.eventAmount.toString());

    eventNoOfParticipants =
        TextEditingController(text: eventData.eventNoOfParticipants.toString());
    eventLink = TextEditingController(text: eventData.eventLink);
    eventContactPerson =
        TextEditingController(text: eventData.eventContactPerson);
    eventContactNo =
        TextEditingController(text: eventData.eventContactPersonNo.toString());
  }

  File image = File("");

  bool submitted = false;
  bool updateImageFlag = false;

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      image = res;
    });
  }

  void clearImage() {
    setState(() {
      updateImageFlag = true;
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

  void updateEvent() {
    eventServices.updateEvent(
        context: context,
        existImage: eventData.eventImage,
        imageUpdateFlag: updateImageFlag,
        eventId: eventData.eventId,
        eventName: eventName.text,
        eventDescription: eventDescription.text,
        eventAmount: double.parse(eventAmount.text),
        eventImage: image,
        eventCategory: dropdownValue,
        eventPublishedOn: DateTime.parse(eventData.eventPublishedOn),
        eventNoOfParticipants: int.parse(eventNoOfParticipants.text),
        eventLink: eventLink.text,
        eventContactPerson: eventContactPerson.text,
        eventContactNo: int.parse(eventContactNo.text),
        eventRegistartionDeadline:
            DateTime.parse(eventData.eventRegistrationDeadline));
  }

  @override
  void dispose() {
    eventName.dispose();
    eventDescription.dispose();
    eventAmount.dispose();
    eventNoOfParticipants.dispose();
    eventLink.dispose();
    eventContactPerson.dispose();
    eventContactNo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColor = context.appColors;
    eventData = ModalRoute.of(context)!.settings.arguments as Event;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor.accent,
        title: const Text('Update Event'),
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
                Text("Event Name",
                    style: Theme.of(context).textTheme.titleMedium),
                TextFormField(
                  controller: eventName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Event Title';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 14,
                ),
                Text(
                  "Description",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextFormField(
                  controller: eventDescription,
                  maxLines: 10,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Event Description';
                    }
                    return null;
                  },
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text("Event Type",
                    style: Theme.of(context).textTheme.titleMedium),
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
                      DropdownMenuItem<String>(
                        value: 'Both',
                        child: Text('Both'),
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
                Text("Event Image",
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(
                  height: 8,
                ),
                updateImageFlag == false
                    ? Image(image: NetworkImage(eventData.eventImage))
                    : image.existsSync() == true
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
                const SizedBox(
                  height: 8,
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
                  height: 13,
                ),
                Text("Event Amount",
                    style: Theme.of(context).textTheme.titleMedium),
                TextFormField(
                  controller: eventAmount,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Event Amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 14,
                ),
                Text("No Of Participants",
                    style: Theme.of(context).textTheme.titleMedium),
                TextFormField(
                  controller: eventNoOfParticipants,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter No Of Participants';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: eventData.eventNoOfParticipants.toString(),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Text("Event Link",
                    style: Theme.of(context).textTheme.titleMedium),
                TextFormField(
                  controller: eventLink,
                  decoration: InputDecoration(
                    hintText: eventData.eventLink,
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Text("Contact Name",
                    style: Theme.of(context).textTheme.titleMedium),
                TextFormField(
                  controller: eventContactPerson,
                  decoration: InputDecoration(
                    hintText: eventData.eventContactPerson,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Contact Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 14,
                ),
                Text("Contact No",
                    style: Theme.of(context).textTheme.titleMedium),
                TextFormField(
                  controller: eventContactNo,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: eventData.eventContactPersonNo.toString(),
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
                Text("Registration Deadline",
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(
                  height: 10,
                ),

                InkWell(
                    onTap: () {
                      _pickRegistrationDeadline();
                    },
                    child: RegistartionDeadline()),
                const SizedBox(
                  height: 14,
                ),
                Center(
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            updateEvent();
                          }
                        },
                        child: const Text('Submit')))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget RegistartionDeadline() {
    var date = eventData.eventRegistrationDeadline.split("T")[0];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        date,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  void _pickRegistrationDeadline() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.parse(eventData.eventRegistrationDeadline),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
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
        eventData.eventRegistrationDeadline = pickedDate.toString();
      });
    }
  }
}
