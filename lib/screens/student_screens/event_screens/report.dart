import 'package:eventquest/models/eventReport.dart';
import 'package:flutter/material.dart';

class EditEventReportForm extends StatefulWidget {
  static const String routeName = '/report-screen';

  @override
  _EditEventReportFormState createState() => _EditEventReportFormState();
}

class _EditEventReportFormState extends State<EditEventReportForm> {
  final _formKey = GlobalKey<FormState>();

  // Sample data extracted from the screenshots
  String typeOfActivity = 'Workshop/Seminar/Conference/Training/Events';
  String titleOfActivity = 'Revalation 2024';
  String date = '2024-04-19T05:20:48.206Z';
  String time = 'N/A';
  String venue = 'Jk';
  String collaboration = 'N/A';
  String participantType = 'Student/Faculty/Research Scholar';
  String noOfParticipants = 'N/A';
  String highlights =
      'Revelation 2024 concluded with thrilling final rounds...';
  String keyTakeaways =
      'The final round of Revelation 2024 events will be held...';
  String summary = 'The Revelation 2024 event concluded with a series...';
  String followUpPlan = 'Attendees expressed positive feedback...';
  String rapporteurName = 'N/A';
  String rapporteurContact = 'N/A';
  String descriptiveReport =
      'Revelation 2024: A Day of Triumph and Academic Excellence...';

  // List to hold multiple speaker details
  List<Map<String, String>> speakers = [
    {
      'name': 'John Doe',
      'title': 'Professor',
      'organization': 'Institute',
      'presentation': 'AI and ML'
    },
  ];

  void _addSpeaker() {
    setState(() {
      speakers.add(
          {'name': '', 'title': '', 'organization': '', 'presentation': ''});
    });
  }

  void _removeSpeaker(int index) {
    setState(() {
      speakers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final EventReport report =
        ModalRoute.of(context)!.settings.arguments as EventReport;
    return Scaffold(
      appBar: AppBar(title: Text('Edit Event Report')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: typeOfActivity,
                decoration: InputDecoration(labelText: 'Type of Activity'),
                onChanged: (value) => typeOfActivity = value,
              ),
              TextFormField(
                initialValue: titleOfActivity,
                decoration: InputDecoration(labelText: 'Title of the Activity'),
                onChanged: (value) => titleOfActivity = value,
              ),
              TextFormField(
                initialValue: date,
                decoration: InputDecoration(labelText: 'Date/s'),
                onChanged: (value) => date = value,
              ),
              TextFormField(
                initialValue: time,
                decoration: InputDecoration(labelText: 'Time'),
                onChanged: (value) => time = value,
              ),
              TextFormField(
                initialValue: venue,
                decoration: InputDecoration(labelText: 'Venue'),
                onChanged: (value) => venue = value,
              ),
              TextFormField(
                initialValue: collaboration,
                decoration: InputDecoration(
                    labelText: 'Collaboration/Sponsor (if any)'),
                onChanged: (value) => collaboration = value,
              ),
              // Participant details fields...
              TextFormField(
                initialValue: participantType,
                decoration: InputDecoration(labelText: 'Type of Participants'),
                onChanged: (value) => participantType = value,
              ),
              TextFormField(
                initialValue: noOfParticipants,
                decoration: InputDecoration(labelText: 'No. of Participants'),
                onChanged: (value) => noOfParticipants = value,
              ),
              // Event description fields...
              TextFormField(
                initialValue: highlights,
                decoration:
                    InputDecoration(labelText: 'Highlights of the Activity'),
                onChanged: (value) => highlights = value,
              ),
              TextFormField(
                initialValue: keyTakeaways,
                decoration: InputDecoration(labelText: 'Key Takeaways'),
                onChanged: (value) => keyTakeaways = value,
              ),
              TextFormField(
                initialValue: summary,
                decoration:
                    InputDecoration(labelText: 'Summary of the Activity'),
                onChanged: (value) => summary = value,
              ),
              TextFormField(
                initialValue: followUpPlan,
                decoration:
                    InputDecoration(labelText: 'Follow-up Plan, if any'),
                onChanged: (value) => followUpPlan = value,
              ),
              // Rapporteur details fields...
              TextFormField(
                initialValue: rapporteurName,
                decoration:
                    InputDecoration(labelText: 'Name of the Rapporteur'),
                onChanged: (value) => rapporteurName = value,
              ),
              TextFormField(
                initialValue: rapporteurContact,
                decoration: InputDecoration(labelText: 'Email and Contact No'),
                onChanged: (value) => rapporteurContact = value,
              ),
              TextFormField(
                initialValue: descriptiveReport,
                decoration: InputDecoration(labelText: 'Descriptive Report'),
                onChanged: (value) => descriptiveReport = value,
                maxLines: 5,
              ),
              // Dynamic speaker details fields
              ...speakers.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, String> speaker = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Speaker ${index + 1}',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextFormField(
                      initialValue: speaker['name'],
                      decoration: InputDecoration(labelText: 'Name'),
                      onChanged: (value) => speaker['name'] = value,
                    ),
                    TextFormField(
                      initialValue: speaker['title'],
                      decoration: InputDecoration(labelText: 'Title/Position'),
                      onChanged: (value) => speaker['title'] = value,
                    ),
                    TextFormField(
                      initialValue: speaker['organization'],
                      decoration: InputDecoration(labelText: 'Organization'),
                      onChanged: (value) => speaker['organization'] = value,
                    ),
                    TextFormField(
                      initialValue: speaker['presentation'],
                      decoration:
                          InputDecoration(labelText: 'Title of Presentation'),
                      onChanged: (value) => speaker['presentation'] = value,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: _addSpeaker,
                          child: Text('Add Speaker'),
                        ),
                        if (speakers.length > 1)
                          ElevatedButton(
                            onPressed: () => _removeSpeaker(index),
                            child: Text('Remove Speaker'),
                          ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                );
              }).toList(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle form submission and update report
                    print('Form submitted');
                    print('Speakers: $speakers');
                  }
                },
                child: Text('Update Report'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
