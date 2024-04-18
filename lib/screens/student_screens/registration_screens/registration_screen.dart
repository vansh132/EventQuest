import 'package:eventquest/models/event.dart';
import 'package:eventquest/services/registration_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeName = '/registration-screen';
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  List<TextEditingController> participantsNameControllers = [];
  List<TextEditingController> participantsRegisterNoControllers = [];
  List<TextEditingController> participantsCategoryController = [];
  List<String> participantsName = [];
  List<String> participantsRegisterNo = [];
  List<String> participantsCategory = [];

  RegistrationServices registrationServices = RegistrationServices();

  void addRegistration() {
    registrationServices.addRegistration(
        context: context,
        participantsName: participantsName,
        participantsCategory: participantsCategory,
        participantsRegisterNo: participantsRegisterNo);
  }

  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context)!.settings.arguments as Event;
    final user = Provider.of<UserProvider>(context, listen: false).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Form'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: event.eventName),
                enabled: false,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(labelText: user.username),
                enabled: false,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration:
                    InputDecoration(labelText: event.eventAmount.toString()),
                enabled: false,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                    labelText:
                        'No Of Participants: ${event.eventNoOfParticipants}'),
                enabled: false,
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  const Text('Participants Details'),
                  const SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (participantsNameControllers.length <
                          event.eventNoOfParticipants) {
                        _addRow();
                      } else {
                        _showGoBackDialog(context);
                      }
                    },
                    child: const Icon(
                      Icons.add,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Column(
                children: _buildRows(event.eventNoOfParticipants),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _printDetails(event.eventCategory);
                  print(event.eventName);
                  print(user.username);
                  print(event.eventAmount);
                  print(event.eventNoOfParticipants);
                  addRegistration();
                },
                child: const Center(child: Text('Submit')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addRow() {
    setState(() {
      participantsNameControllers.add(TextEditingController());
      participantsRegisterNoControllers.add(TextEditingController());
      participantsCategoryController.add(TextEditingController());
    });
  }

  List<Widget> _buildRows(int no) {
    List<Widget> rows = [];

    for (int i = 0; i < participantsNameControllers.length; i++) {
      if (i < no) {
        rows.add(Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: participantsNameControllers[i],
                decoration: const InputDecoration(labelText: 'Name'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: participantsRegisterNoControllers[i],
                decoration: const InputDecoration(labelText: 'Roll Number'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: participantsCategoryController[i],
                decoration: const InputDecoration(labelText: 'UG or PG'),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _deleteRow(i);
              },
            ),
          ],
        ));
      } else {
        return [];
      }
    }
    return rows;
  }

  void _deleteRow(int index) {
    setState(() {
      participantsNameControllers.removeAt(index);
      participantsRegisterNoControllers.removeAt(index);
      participantsCategoryController.removeAt(index);
    });
  }

  void _printDetails(String event) {
    participantsName.clear();
    participantsRegisterNo.clear();
    participantsCategory.clear(); // Clear the list to ensure no duplicates

    for (int i = 0; i < participantsNameControllers.length; i++) {
      participantsName.add(participantsNameControllers[i].text);
      participantsRegisterNo.add(participantsRegisterNoControllers[i].text);

      if (event == participantsCategoryController[i].text.toUpperCase()) {
        participantsCategory
            .add(participantsCategoryController[i].text.toUpperCase());
      } else {
// Show a dialog box to inform the user about successful submission
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Submission Failed'),
              content: Text(
                  'It is $event level participation. You can not participate it.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }

    print('Names: $participantsName');
    print('Roll Numbers: $participantsRegisterNo');
    print('Category: $participantsCategory');
  }

  void _showGoBackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cannot Add More Participants'),
          content:
              const Text('You cannot add more participants than specified.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Go Back'),
            ),
          ],
        );
      },
    );
  }
}
