import 'package:eventquest/models/event.dart';
import 'package:eventquest/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsScreen extends StatelessWidget {
  static const String routeName = '/event-detail-screen';

  EventDetailsScreen();

  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context)!.settings.arguments as Event;
    print(event.eventLink);
    return Scaffold(
      appBar: AppBar(
        title: Text(event.eventName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Event Image
            Image.network(
              event.eventImages!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),

            // Event Amount and Registration Deadline
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text("Participation Instructions",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 65,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Registration Fees:",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Registration Deadline:",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "No Of Participation:",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(event.eventAmount.toString()),
                            const SizedBox(height: 8),
                            Text(
                              "${event.registartionDeadline.day}/${event.registartionDeadline.month}/${event.registartionDeadline.year}",
                            ),
                            const SizedBox(height: 8),
                            Text(event.noOfParticipants.toString()),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Event Link

            InkWell(
              onTap: () {
                _launchURL(event.eventLink!);
              },
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  children: [
                    const TextSpan(
                      text: 'Event Link:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                        text: ' ${event.eventLink}',
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.redAccent)),
                  ],
                ),
              ),
            ),

            // Description
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Description:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black, // Set your preferred text color
                        ),
                        children: [
                          TextSpan(text: event.description),
                        ],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),

            // Contact Person and Contact Number
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      children: [
                        const TextSpan(
                          text: 'Contact Person:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' ${event.contactPerson}'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8), // Adjust the height for spacing
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      children: [
                        const TextSpan(
                          text: 'Contact Number:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' ${event.contactNo}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Registration Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff003049),
                    foregroundColor: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.routeName);
                },
                child: const Text(
                  'Register',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      // Print the error or handle it appropriately
      print('Could not launch $url');
    }
  }
}
