import 'package:eventquest/models/announcement.dart';
import 'package:eventquest/models/event.dart';
import 'package:eventquest/provider/user_provider.dart';
import 'package:eventquest/screen_items/faculty_custom_navigation_bottom_bar.dart';
import 'package:eventquest/screen_items/highlights.dart';
import 'package:eventquest/screens/student_screens/announcement_screens/announcement_detail_screen.dart';
import 'package:eventquest/screens/student_screens/event_screens/event_detail_screen.dart';
import 'package:eventquest/widgets/top_bar.dart';
import 'package:eventquest/widgets/user_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Announcement> announcements = [

    ];
    List<Event> events = [

    ];

    final user = Provider.of<UserProvider>(context, listen: false);


    return Scaffold(
      body: Container(
        // color: Color(0xff0D1B2A),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopBar(),
              UserBar(context),
              const Highlights(),
              const SizedBox(
                height: 8,
              ),
              recentEvents(context, events),
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
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    FacultyCustomBottomBar.routeName,
                  );
                },
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

Widget recentEvents(BuildContext context, List<Event> events) {
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
  return GestureDetector(
    onTap: () => Navigator.pushNamed(
        context, AnnouncementDetailScreen.routeName,
        arguments: announcement),
    child: Container(
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
            flex: 2,
            child: SizedBox(
              height: 100, // Set the desired height
              width: 100, // Set the desired width
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  announcement.announcementImages![0],
                  fit: BoxFit.cover,
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
                          announcement.announcementTitle,
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
                            announcement.announcementPublishedBy,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            announcement.announcementPublishedOn.toString(),
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
    ),
  );
}

Widget EventItem(Event event, BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pushNamed(context, EventDetailsScreen.routeName,
        arguments: event),
    child: Container(
      // margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      child: Stack(children: [
        SizedBox(
          height: double.infinity, // Set the desired height
          width: double.infinity, // Set the desired width
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.asset(
              event.eventImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              // margin: const EdgeInsets.only(top: 95),
              child: Row(
                children: [
                  Card(
                    color: Colors.white.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 4.0,
                    child: Container(
                      padding: const EdgeInsets.all(
                          7), //TODO: needs to make it responsive
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.eventRegistrationDeadline.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            event.eventRegistrationDeadline.toString(),
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
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black54),
                          child: Text(
                            event.eventName,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ]),
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
