import 'dart:math';
import 'package:eventquest/models/reg_dummy.dart';
import 'package:eventquest/models/registration.dart';
import 'package:flutter/material.dart';

class EventRegistrationDetailScreen extends StatelessWidget {
  static const String routeName = "/event-registration-detail-screen";

  List<DummyReg> dummyRegistrations = [
    DummyReg(registerNumber: "2347151", verify: true),
    DummyReg(registerNumber: "2347156", verify: true),
    DummyReg(registerNumber: "2347202", verify: true),
    DummyReg(registerNumber: "2347224", verify: false),
    DummyReg(registerNumber: "2447254", verify: true),
    DummyReg(registerNumber: "2347143", verify: false),
    DummyReg(registerNumber: "2447138", verify: false),
    DummyReg(registerNumber: "2447256", verify: false),
    DummyReg(registerNumber: "2348101", verify: true),
    DummyReg(registerNumber: "2448109", verify: false),
    DummyReg(registerNumber: "2348110", verify: true),
    DummyReg(registerNumber: "2348111", verify: false),
    DummyReg(registerNumber: "2348112", verify: true),
    DummyReg(registerNumber: "2348113", verify: true),
    DummyReg(registerNumber: "2348114", verify: false),
  ];

  EventRegistrationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the list of registrations passed from the previous screen
    final List<Registration> registrations =
        ModalRoute.of(context)!.settings.arguments as List<Registration>;

    // Get the event name from the first registration (assuming all registrations are for the same event)
    String eventName = registrations.isNotEmpty
        ? registrations.first.eventName
        : "Unknown Event";

    // Generate a random number between 1 and the length of dummyRegistrations
    int randomNumber = Random().nextInt(dummyRegistrations.length) + 1;

    // Limit the dummyRegistrations list to the random number generated
    List<DummyReg> displayedRegistrations =
        dummyRegistrations.take(randomNumber).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(eventName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Action for pending status
                },
                child: Text("No Of Participants: ${randomNumber.toString()}"),
              ),
            ),
            const SizedBox(
                height: 10), // Add some space between the title and the list
            Expanded(
              child: ListView.builder(
                itemCount: displayedRegistrations.length,
                itemBuilder: (context, index) {
                  final registration = displayedRegistrations[index];
                  return ListTile(
                    title: Text(registration.registerNumber),
                    trailing: registration.verify
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Verified',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.green),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              const Icon(Icons.verified, color: Colors.green),
                            ],
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Pending',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.orange)),
                              SizedBox(
                                width: 8,
                              ),
                              const Icon(Icons.timer, color: Colors.orange),
                            ],
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
