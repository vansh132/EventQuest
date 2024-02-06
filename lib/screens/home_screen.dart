import 'package:eventquest/models/announcement.dart';
import 'package:eventquest/models/event.dart';
import 'package:eventquest/screen_items/highlights.dart';
import 'package:eventquest/screens/detailed_screens/event_detail_screen.dart';
import 'package:eventquest/widgets/top_bar.dart';
import 'package:eventquest/widgets/user_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Announcement> announcements = [
      Announcement(
        title: 'Placement',
        description:
            'Heartiest congratulations to all the brilliant students who have achieved remarkable success and secured placements! Your hard work, dedication, and exceptional skills have paved the way for this significant accomplishment. Wishing you a future filled with continued success, growth, and prosperity. Well done!Heartiest congratulations to all the brilliant students who have achieved remarkable success and secured placements! Your hard work, dedication, and exceptional skills have paved the way for this significant accomplishment. Wishing you a future filled with continued success, growth, and prosperity. Well done!Heartiest congratulations to all the brilliant students who have achieved remarkable success and secured placements! Your hard work, dedication, and exceptional skills have paved the way for this significant accomplishment. Wishing you a future filled with continued success, growth, and prosperity. Well done!',
        image: [
          "https://media.istockphoto.com/id/514363071/photo/just-one-moment-please.webp?b=1&s=170667a&w=0&k=20&c=8xY02WALsH-RYsCz83EBigqH4z3RQg76ZfOhgQjlefU=",
        ],
        publishedBy: "Helen K Joy",
        publishedOn: DateTime(2024, 1, 23),
      ),
      Announcement(
        title: 'ESE Results',
        description:
            'Heartiest congratulations to all the brilliant students who have achieved remarkable success and secured placements! Your hard work, dedication, and exceptional skills have paved the way for this significant accomplishment. Wishing you a future filled with continued success, growth, and prosperity. Well done!Heartiest congratulations to all the brilliant students who have achieved remarkable success and secured placements! Your hard work, dedication, and exceptional skills have paved the way for this significant accomplishment. Wishing you a future filled with continued success, growth, and prosperity. Well done!Heartiest congratulations to all the brilliant students who have achieved remarkable success and secured placements! Your hard work, dedication, and exceptional skills have paved the way for this significant accomplishment. Wishing you a future filled with continued success, growth, and prosperity. Well done!',
        image: [
          "https://media.istockphoto.com/id/514363071/photo/just-one-moment-please.webp?b=1&s=170667a&w=0&k=20&c=8xY02WALsH-RYsCz83EBigqH4z3RQg76ZfOhgQjlefU=",
        ],
        publishedBy: "Helen K Joy",
        publishedOn: DateTime(2024, 1, 23),
      ),
      Announcement(
        title: 'Nexus - Fest 2023',
        description:
            'Kudos to the festival winners for their remarkable achievements! Your dedication and talent have shone brightly, inspiring and captivating everyone. Heartfelt congratulations on your well-deserved success and recognition!Kudos to the festival winners for their remarkable achievements! Your dedication and talent have shone brightly, inspiring and captivating everyone. Heartfelt congratulations on your well-deserved success and recognition!Kudos to the festival winners for their remarkable achievements! Your dedication and talent have shone brightly, inspiring and captivating everyone. Heartfelt congratulations on your well-deserved success and recognition!Kudos to the festival winners for their remarkable achievements! Your dedication and talent have shone brightly, inspiring and captivating everyone. Heartfelt congratulations on your well-deserved success and recognition!Kudos to the festival winners for their remarkable achievements! Your dedication and talent have shone brightly, inspiring and captivating everyone. Heartfelt congratulations on your well-deserved success and recognition!Kudos to the festival winners for their remarkable achievements! Your dedication and talent have shone brightly, inspiring and captivating everyone. Heartfelt congratulations on your well-deserved success and recognition!Kudos to the festival winners for their remarkable achievements! Your dedication and talent have shone brightly, inspiring and captivating everyone. Heartfelt congratulations on your well-deserved success and recognition!Kudos to the festival winners for their remarkable achievements! Your dedication and talent have shone brightly, inspiring and captivating everyone. Heartfelt congratulations on your well-deserved success and recognition!Kudos to the festival winners for their remarkable achievements! Your dedication and talent have shone brightly, inspiring and captivating everyone. Heartfelt congratulations on your well-deserved success and recognition!Kudos to the festival winners for their remarkable achievements! Your dedication and talent have shone brightly, inspiring and captivating everyone. Heartfelt congratulations on your well-deserved success and recognition!Kudos to the festival winners for their remarkable achievements! Your dedication and talent have shone brightly, inspiring and captivating everyone. Heartfelt congratulations on your well-deserved success and recognition!Kudos to the festival winners for their remarkable achievements! Your dedication and talent have shone brightly, inspiring and captivating everyone. Heartfelt congratulations on your well-deserved success and recognition!',
        image: [
          "https://images.unsplash.com/photo-1658581872509-c8d19777bd24?q=80&w=2831&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          "https://media.istockphoto.com/id/514363071/photo/just-one-moment-please.webp?b=1&s=170667a&w=0&k=20&c=8xY02WALsH-RYsCz83EBigqH4z3RQg76ZfOhgQjlefU="
        ],
        publishedBy: "Dr. Sudhakar T",
        publishedOn: DateTime(2024, 1, 10),
      ),
    ];
    List<Event> events = [
      Event(
        eventId: "abc132",
        eventCategory: "UG",
        eventName: "Talent Show",
        description:
            "Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. Fresher's can show their talent. ",
        publishedOn: DateTime.now(),
        eventImages:
            "https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZXZlbnR8ZW58MHx8MHx8fDA%3D",
        eventLink: "https://github.com/",
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
            "Welcome to CodeCraft Challenge, an exciting coding competition tailored for computer science enthusiasts! Whether you are a seasoned coder or a novice programmer, this event is designed to bring out the best in you. Sharpen your problem-solving skills, enhance your algorithmic thinking, and showcase your coding prowess in a thrilling environment.",
        publishedOn: DateTime.now().subtract(const Duration(days: 5)),
        eventImages:
            "https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Y29hZGluZ3xlbnwwfHwwfHx8MA%3D%3D",
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
        publishedOn: DateTime.now().subtract(const Duration(days: 10)),
        eventImages:
            "https://plus.unsplash.com/premium_photo-1661767490975-f31a02946f48?q=80&w=2832&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        eventLink: "https://artexhibition.com",
        eventAmount: 50,
        contactPerson: "Alice Smith",
        contactNo: 1234567890,
        noOfParticipants: 30,
        registartionDeadline: DateTime(2024, 2, 28),
      ),
    ];

    return Scaffold(
      body: Container(
        // color: Color(0xff0D1B2A),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopBar(),
              UserBar(),
              const Highlights(),
              const SizedBox(
                height: 8,
              ),
              RecentEvents(context, events),
              RecentAnnouncements(context, announcements),
            ],
          ),
        ),
      ),
    );
  }
}

Widget RecentAnnouncements(
    BuildContext context, List<Announcement> announcements) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.all(16),
    // color: Colors.greenAccent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recent Announcements",
          style: TextStyle(
            fontSize: 24,
            color: Color(0xff0D1B2A),
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          // color: Colors.greenAccent,
          height: 200,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3), // Shadow color
                spreadRadius: 5, // Spread radius
                blurRadius: 7, // Blur radius
                offset: const Offset(0, 3), // Offset in the x, y direction
              ),
            ],
          ),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: announcements.length,
            itemBuilder: (context, index) =>
                AnnouncementItem(context, announcements[index]),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: 16,
          ),
          child: const Column(
            children: [
              ElevatedButton(
                onPressed: null,
                child: Text(
                  "Faculty - Home Screen",
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget RecentEvents(BuildContext context, List<Event> events) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.all(16),
    // color: Colors.deepOrange,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recent Events",
          style: TextStyle(
            fontSize: 24,
            color: Color(0xff0D1B2A),
            fontWeight: FontWeight.bold,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        SizedBox(
          // color: Colors.greenAccent,
          height: 200,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: events.length,
            itemBuilder: (context, index) => EventItem(events[index], context),
          ),
        ),
      ],
    ),
  );
}

Widget AnnouncementItem(BuildContext context, Announcement announcement) {
  return Container(
    // width: 180,
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            height: 128,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: NetworkImage(
                  scale: 1,
                  "https://img.freepik.com/free-photo/business-job-interview-concept_1421-77.jpg",
                ),
                fit: BoxFit.cover,
                // scale: 140,
              ),
            ),
          ),
        ),
        Expanded(
            flex: 4,
            child: Container(
              height: 128,
              // color: Colors.amber,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        announcement.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const Divider(
                    indent: 16,
                    color: Colors.black38,
                    endIndent: 16,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          announcement.publishedBy,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          DateFormat('MMM d, y')
                              .format(announcement.publishedOn),
                          style: const TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ))
      ],
    ),
  );
}

Widget EventItem(Event event, BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pushNamed(context, EventDetailsScreen.routeName,
        arguments: event),
    child: Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            event.eventImages!,
          ),
          fit: BoxFit.cover,
        ),
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft, // Gradient direction
        //   end: Alignment.bottomRight,
        //   colors: [
        //     Colors.amberAccent, // Black
        //     Colors.grey, // Darker shade of gray
        //   ],
        // ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 95),
        child: Row(
          children: [
            Card(
              color: Colors.white.withOpacity(0.9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 4.0,
              child: Container(
                padding:
                    const EdgeInsets.all(7), //TODO: needs to make it responsive
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
                mainAxisAlignment: MainAxisAlignment.center,
                //
                children: [
                  Text(
                    event.eventName,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
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
