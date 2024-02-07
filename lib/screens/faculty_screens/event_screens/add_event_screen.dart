import 'package:flutter/material.dart';

class AddEventScreen extends StatefulWidget {
  static const String routeName = "add-event-screen";
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();

  // void _pickRegistrationDeadline() async {
  //   DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime.now(),
  //     lastDate: DateTime(2100),
  //   );

  //   if (pickedDate != null) {
  //     setState(() {
  //       _registartionDeadline = pickedDate;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    TextEditingController eventName = new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: eventName,
                  decoration: const InputDecoration(
                    label: Text("Event Name"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
