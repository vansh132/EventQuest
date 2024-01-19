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
        eventCategory: "UG",
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
      Event(
        eventId: "1",
        eventCategory: "PG",
        eventName: "Music Concert",
        description: "Enjoy a night of live music performances.",
        publishedOn: DateTime.now(),
        eventAmount: 50.0,
        contactPerson: "John Doe",
        contactNo: 1234567890,
        noOfParticipants: 100,
        registartionDeadline: DateTime(2024, 2, 15),
      ),
      Event(
        eventId: "2",
        eventCategory: "Both",
        eventName: "Art Exhibition",
        description: "Explore the world of contemporary art.",
        publishedOn: DateTime.now().add(Duration(days: 5)),
        eventAmount: 20.0,
        contactPerson: "Alice Smith",
        contactNo: 9876543210,
        noOfParticipants: 50,
        registartionDeadline: DateTime(2024, 2, 20),
      ),
      Event(
        eventId: "3",
        eventCategory: "UG",
        eventName: "Tech Conference",
        description: "Stay updated with the latest in technology.",
        publishedOn: DateTime.now().add(Duration(days: 10)),
        eventAmount: 75.0,
        contactPerson: "Bob Johnson",
        contactNo: 5555555555,
        noOfParticipants: 200,
        registartionDeadline: DateTime(2024, 2, 25),
      ),
      Event(
        eventId: "4",
        eventCategory: "PG",
        eventName: "Food Festival",
        description: "Savor delicious cuisines from around the world.",
        publishedOn: DateTime.now().add(Duration(days: 15)),
        eventAmount: 30.0,
        contactPerson: "Eva Brown",
        contactNo: 7778889999,
        noOfParticipants: 75,
        registartionDeadline: DateTime(2024, 3, 1),
      ),
      Event(
        eventId: "5",
        eventCategory: "Both",
        eventName: "Fitness Challenge",
        description: "Join us for a day of fitness and wellness activities.",
        publishedOn: DateTime.now().add(Duration(days: 20)),
        eventAmount: 10.0,
        contactPerson: "Mike Davis",
        contactNo: 1231231234,
        noOfParticipants: 50,
        registartionDeadline: DateTime(2024, 3, 5),
      ),
      Event(
        eventId: "6",
        eventCategory: "UG",
        eventName: "Science Fair",
        description: "Discover the wonders of science through experiments.",
        publishedOn: DateTime.now().add(Duration(days: 25)),
        eventAmount: 15.0,
        contactPerson: "Dr. Sarah White",
        contactNo: 9998887777,
        noOfParticipants: 30,
        registartionDeadline: DateTime(2024, 3, 10),
      ),
      Event(
        eventId: "7",
        eventCategory: "UG",
        eventName: "Fashion Show",
        description: "Witness the latest trends in fashion and style.",
        publishedOn: DateTime.now().add(Duration(days: 30)),
        eventAmount: 40.0,
        contactPerson: "Olivia Taylor",
        contactNo: 4567890123,
        noOfParticipants: 60,
        registartionDeadline: DateTime(2024, 3, 15),
      ),
      Event(
        eventId: "8",
        eventCategory: "UG",
        eventName: "Comedy Night",
        description: "Laugh out loud with top stand-up comedians.",
        publishedOn: DateTime.now().add(Duration(days: 35)),
        eventAmount: 25.0,
        contactPerson: "Chris Miller",
        contactNo: 9876543210,
        noOfParticipants: 40,
        registartionDeadline: DateTime(2024, 3, 20),
      ),
      // Add two more events here...
      Event(
        eventId: "9",
        eventCategory: "UG",
        eventName: "Dance Competition",
        description: "Showcase your dance skills and creativity.",
        publishedOn: DateTime.now().add(Duration(days: 40)),
        eventAmount: 35.0,
        contactPerson: "Sophie Green",
        contactNo: 1112223333,
        noOfParticipants: 50,
        registartionDeadline: DateTime(2024, 3, 25),
      ),
      Event(
        eventId: "10",
        eventCategory: "UG",
        eventName: "Film Screening",
        description: "Enjoy a night of cinematic masterpieces.",
        publishedOn: DateTime.now().add(Duration(days: 45)),
        eventAmount: 18.0,
        contactPerson: "Daniel Lee",
        contactNo: 9990001111,
        noOfParticipants: 70,
        registartionDeadline: DateTime(2024, 3, 30),
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
    padding: const EdgeInsets.all(16),
    color: Colors.deepOrange,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recent Events",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          height: 200,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
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
  return Container(
    decoration: BoxDecoration(
      color: Colors.pinkAccent,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(event.eventName),
        Text(
          event.description,
          overflow: TextOverflow.ellipsis,
        ),
        Text(event.eventAmount.toString()),
        Text(event.noOfParticipants.toString())
      ],
    ),
  );
}
