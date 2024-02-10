import 'package:eventquest/models/event.dart';
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
  @override
  Widget build(BuildContext context) {
    TextEditingController eventName = TextEditingController();
    TextEditingController description = TextEditingController();
    TextEditingController eventAmount = TextEditingController();
    TextEditingController noOfParticipants = TextEditingController();
    TextEditingController eventLink = TextEditingController();
    TextEditingController contactPerson = TextEditingController();
    TextEditingController contactName = TextEditingController();
    Event eventData = ModalRoute.of(context)!.settings.arguments as Event;
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
                  decoration: InputDecoration(
                    hintText: eventData.eventName,
                  ),
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
                  decoration: InputDecoration(
                      hintText: eventData.description, hintMaxLines: 5),
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
                  decoration: InputDecoration(
                    hintText: eventData.eventAmount == 0.0
                        ? 'Free'
                        : eventData.eventAmount.toString(),
                  ),
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
                  controller: contactName,
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

  Widget RegistartionDeadline() {
    Event eventData = ModalRoute.of(context)!.settings.arguments as Event;
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
    Event eventData = ModalRoute.of(context)!.settings.arguments as Event;
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
