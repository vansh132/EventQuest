import 'package:eventquest/models/event.dart';
import 'package:eventquest/providers/event_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditEventScreen extends ConsumerStatefulWidget {
  static const String routeName = "edit_event_screen";
  const EditEventScreen({super.key});

  @override
  ConsumerState<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends ConsumerState<EditEventScreen> {
  final _formKey = GlobalKey<FormState>();

  String dropdownValue = 'UG';

  late TextEditingController eventName;
  late TextEditingController description;
  late TextEditingController eventAmount;
  late TextEditingController noOfParticipants;
  late TextEditingController eventLink;
  late TextEditingController contactPerson;
  late TextEditingController contactNo;
  late TextEditingController registrationDeadline;
  late Event eventData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    eventData = ModalRoute.of(context)!.settings.arguments as Event;
    eventName = TextEditingController(text: eventData.eventName);
    description = TextEditingController(text: eventData.description);

    eventAmount = TextEditingController(text: eventData.eventAmount.toString());

    noOfParticipants =
        TextEditingController(text: eventData.noOfParticipants.toString());
    eventLink = TextEditingController(text: eventData.eventLink);
    contactPerson = TextEditingController(text: eventData.contactPerson);
    contactNo = TextEditingController(text: eventData.contactNo.toString());
    registrationDeadline =
        TextEditingController(text: eventData.registartionDeadline.toString());
  }

  @override
  void dispose() {
    eventName.dispose();
    description.dispose();
    eventAmount.dispose();
    noOfParticipants.dispose();
    eventLink.dispose();
    contactPerson.dispose();
    contactNo.dispose();
    registrationDeadline.dispose();
    super.dispose();
  }

  void _updateEvent() {
    final enteredEventName = eventName.text;
    final enteredDescription = description.text;
    final enteredEventAmount = eventAmount.text;
    final enteredNoOfParticipants = noOfParticipants.text;
    final enteredEventLink = eventLink.text;
    final enteredContactName = contactPerson.text;
    final enteredContactNo = contactNo.text;
    // final enteredRegistrationDeadline = registrationDeadline.text;
    final event = Event(
        eventId: "1",
        eventName: enteredEventName,
        description: enteredDescription,
        eventAmount: double.parse(enteredEventAmount),
        noOfParticipants: int.parse(enteredNoOfParticipants),
        eventLink: enteredEventLink,
        contactPerson: enteredContactName,
        contactNo: int.parse(enteredContactNo),
        eventImages: "assets/images/PRAYAS.jpeg",
        eventCategory: dropdownValue,
        publishedOn: DateTime(2024, 3, 3),
        registartionDeadline: DateTime(2024, 3, 3)); // Needs to be dynamic

    ref.read(eventProvider.notifier).updateEvent(event);

    Navigator.pop(context, true);
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
                  controller: description,
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
                  controller: noOfParticipants,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: eventData.noOfParticipants.toString(),
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
                  controller: contactNo,
                  decoration: InputDecoration(
                    hintText: eventData.contactPerson,
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
                  controller: contactPerson,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: eventData.contactNo.toString(),
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
                        onPressed: _updateEvent, child: Text('Submit')))
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
        '${eventData.registartionDeadline.day} / ${eventData.registartionDeadline.month} / ${eventData.registartionDeadline.year}',
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
        eventData.registartionDeadline = pickedDate;
      });
    }
  }
}
