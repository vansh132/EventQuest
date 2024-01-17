import 'package:eventquest/models/event.dart';
import 'package:eventquest/screen_items/highlights.dart';
import 'package:eventquest/widgets/top_bar.dart';
import 'package:eventquest/widgets/user_info.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Event> events = [
      Event(
        eventId: "abc132",
        eventName: "Talent Show",
        description: "Fresher's can show their talent",
        publishedOn: DateTime.now(),
        eventImages: [],
        eventLink: "",
        eventAmount: 200,
        contactPerson: "Helen K Joy",
        contactNo: 9099897859,
        noOfParticipants: 2,
        registartionDeadline: DateTime(2024, 1, 31),
      ),
    ];

    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: Column(
          children: [
            TopBar(),
            UserBar(),
            Highlights(),
            RecentEvents(context, events),
          ],
        ),
      ),
    );
  }
}

Widget RecentEvents(BuildContext context, List<Event> events) {
  return Container(
    width: MediaQuery.of(context).size.width,
    color: Colors.deepOrange,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Recent Events"),
        SizedBox(
          height: 12,
        ),
        Container(
          height: 200,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: events.length,
            itemBuilder: (context, index) => EventItem(events[index]),
          ),
        )
      ],
    ),
  );
}

Widget EventItem(Event event) {
  return Text(event.eventName);
}
