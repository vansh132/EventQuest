import 'package:eventquest/models/event.dart';
import 'package:flutter/material.dart';

class EventDetailsScreen extends StatelessWidget {
  static const String routeName = '/event-detail-screen';

  EventDetailsScreen();

  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context)!.settings.arguments as Event;
    return Scaffold(
      appBar: AppBar(
        title: Text(event.eventName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Event Image
            Image.network(
              event.eventImages,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),

            // Event Amount and Registration Deadline
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      event.eventAmount == 0
                          ? 'Event Amount: Free'
                          : 'Event Amount: \₹${event.eventAmount}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Registration Deadline: ${event.registartionDeadline.day}/${event.registartionDeadline.month}/${event.registartionDeadline.year}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),

            // Event Link

            Text(
              'Event Link: ${event.eventLink}',
              style: TextStyle(fontSize: 18),
            ),

            // Description
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description:",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 18,
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
                  Text(
                    'Contact Person: ${event.contactPerson}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Contact Number: ${event.contactNo}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),

            // Registration Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Add your registration logic here
                },
                child: Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
