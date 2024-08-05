import 'package:eventquest/models/registration.dart';
import 'package:flutter/material.dart';

class EventRegistrationDetailScreen extends StatelessWidget {
  static const String routeName = "/event-registration-detail-screen";

  @override
  Widget build(BuildContext context) {
    // Get the list of registrations passed from the previous screen
    final List<Registration> registrations =
        ModalRoute.of(context)!.settings.arguments as List<Registration>;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrations Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: registrations.map((registration) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(
                  registration.userName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Event Amount: ${registration.eventAmount}'),
                    Text('Event Category: ${registration.eventCategory}'),
                    Text(
                        'Number of Participants: ${registration.eventNoOfParticipants}'),
                    Text(
                        'Participants Names: ${registration.participantsName.join(', ')}'),
                    Text(
                        'Participants Categories: ${registration.participantsCategory.join(', ')}'),
                    Text(
                        'Participants Register No: ${registration.participantsRegisterNo.join(', ')}'),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
