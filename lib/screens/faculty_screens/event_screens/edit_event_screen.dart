import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:eventquest/models/event.dart';
import 'package:eventquest/services/event_services.dart';
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
        eventId: eventData.eventId,
        eventName: eventName.text,
        eventDescription: eventDescription.text,
        eventAmount: double.parse(eventAmount.text),
        eventImage: image,
        eventCategory: dropdownValue,
        eventPublishedOn: DateTime.now(),
        eventNoOfParticipants: int.parse(eventNoOfParticipants.text),
        eventLink: eventLink.text,
        eventContactPerson: eventContactPerson.text,
        eventContactNo: int.parse(eventContactNo.text),
        eventRegistartionDeadline: DateTime.now());
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
    eventData = ModalRoute.of(context)!.settings.arguments as Event;

    return Scaffold(
      appBar: AppBar(
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
                const Text(
                  "Event Name",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextFormField(
                  controller: eventName,
                ),
                const SizedBox(
                  height: 14,
                ),
                const Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextFormField(
                  controller: eventDescription,
                  maxLines: 10,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Event Type",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
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
                const SizedBox(
                  height: 8,
                ),
                updateImageFlag == false ?
                Image(image: NetworkImage(eventData.eventImage))
                :
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
                  height: 13,
                ),
                const Text(
                  "Event Amount",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextFormField(
                  controller: eventAmount,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 14,
                ),
                const Text(
                  "No Of Participants",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextFormField(
                  controller: eventNoOfParticipants,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: eventData.eventNoOfParticipants.toString(),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                const Text(
                  "Event Link",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextFormField(
                  controller: eventLink,
                  decoration: InputDecoration(
                    hintText: eventData.eventLink,
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                const Text(
                  "Contact Name",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextFormField(
                  controller: eventContactNo,
                  decoration: InputDecoration(
                    hintText: eventData.eventContactPerson,
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                const Text(
                  "Contact No",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextFormField(
                  controller: eventContactPerson,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: eventData.eventContactPersonNo.toString(),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                // Date picker for Registration Deadline
                const Text(
                  "Registration Deadline",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
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
                        onPressed: updateEvent, child: Text('Submit')))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget RegistartionDeadline() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        eventData.eventRegistrationDeadline,
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
        eventData.eventRegistrationDeadline = pickedDate.toString();
      });
    }
  }
}
