import 'package:eventquest/models/event.dart';
import 'package:eventquest/screens/detailed_screens/event_detail_screen.dart';
import 'package:eventquest/widgets/top_bar.dart';
import 'package:eventquest/widgets/user_info.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatefulWidget {
  static const String routeName = '/event-screen';
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  int? _value;
  List<Event> events = [
    Event(
      eventId: "abc132",
      eventCategory: "UG",
      eventName: "Talent Show",
      description:
          "Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. ",
      publishedOn: DateTime.now(),
      eventImages: [],
      eventLink: "",
      eventAmount: 200,
      contactPerson: "Helen K Joy",
      contactNo: 9099897859,
      noOfParticipants: 2,
      registartionDeadline: DateTime(2024, 1, 31),
    ),
    Event(
      eventId: "def456",
      eventCategory: "PG",
      eventName: "Coding Competition",
      description:
          "Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.Test your coding skills in this competition.",
      publishedOn: DateTime.now().subtract(Duration(days: 5)),
      eventImages: [],
      eventLink: "https://codingcompetition.com",
      eventAmount: 0,
      contactPerson: "John Doe",
      contactNo: 9876543210,
      noOfParticipants: 50,
      registartionDeadline: DateTime(2024, 2, 15),
    ),
    Event(
      eventId: "ghi789",
      eventCategory: "Both",
      eventName: "Art Exhibition",
      description: "Explore the world of art through various exhibits.",
      publishedOn: DateTime.now().subtract(Duration(days: 10)),
      eventImages: [],
      eventLink: "https://artexhibition.com",
      eventAmount: 50,
      contactPerson: "Alice Smith",
      contactNo: 1234567890,
      noOfParticipants: 30,
      registartionDeadline: DateTime(2024, 2, 28),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<Event> filteredEvents = _value == null
        ? events
        : events
            .where((event) => event.eventCategory == getCategory(_value!))
            .toList();

    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: Column(
          children: [
            TopBar(),
            UserBar(),
            filterOption(context),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: filteredEvents.length,
                  itemBuilder: (context, index) {
                    return buildEventCard(filteredEvents[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEventCard(Event event) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, EventDetailsScreen.routeName,
            arguments: event);
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 4.0,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                "https://images.unsplash.com/photo-1616161560417-66d4db5892ec?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", // Placeholder image
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Card(
                    color: Colors.white.withOpacity(0.7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 4.0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.registartionDeadline.day.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            event.registartionDeadline.monthShort,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.eventName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          event.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget filterOption(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      child: Column(
        children: [
          Text('Select your preference:', style: textTheme.headline6),
          const SizedBox(height: 10.0),
          Wrap(
            spacing: 5.0,
            children: List<Widget>.generate(
              3,
              (int index) {
                String optionText = '';

                switch (index) {
                  case 0:
                    optionText = 'UG';
                    break;
                  case 1:
                    optionText = 'PG';
                    break;
                  case 2:
                    optionText = 'Both';
                    break;
                  default:
                    optionText = '';
                    break;
                }

                return ChoiceChip(
                  label: Text(optionText),
                  selected: _value == index,
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected ? index : null;
                    });
                  },
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  String getCategory(int? index) {
    if (index == null) {
      return '';
    }

    switch (index) {
      case 0:
        return 'UG';
      case 1:
        return 'PG';
      case 2:
        return 'Both';
      default:
        return '';
    }
  }
}

extension MonthToString on DateTime {
  String get monthShort {
    return [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ][month];
  }
}
