import 'dart:io';

import 'package:eventquest/models/event.dart';
import 'package:eventquest/services/event_services.dart';
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

  void updateEvent() {
    eventServices.updateEvent(
        context: context,
        eventId: eventData.eventId,
        eventName: eventName.text,
        eventDescription: eventDescription.text,
        eventAmount: double.parse(eventAmount.text),
        eventImage: File(""),
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
                //TODO: add update file field
                const Text(
                  "Upload File yet to be added",
                  style: TextStyle(color: Colors.red),
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
