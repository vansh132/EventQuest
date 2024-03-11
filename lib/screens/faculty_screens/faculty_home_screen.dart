import 'package:eventquest/models/announcement.dart';
import 'package:eventquest/models/event.dart';
import 'package:eventquest/screen_items/highlights.dart';
import 'package:eventquest/screens/student_screens/announcement_screens/announcement_detail_screen.dart';
import 'package:eventquest/screens/student_screens/event_screens/event_detail_screen.dart';
import 'package:eventquest/services/announcement_services.dart';
import 'package:eventquest/services/event_services.dart';
import 'package:eventquest/widgets/top_bar.dart';
import 'package:eventquest/widgets/user_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FacultyHomeScreen extends StatefulWidget {
  static const String routeName = 'home-screen';
  const FacultyHomeScreen({super.key});

  @override
  State<FacultyHomeScreen> createState() => _FacultyHomeScreenState();
}

class _FacultyHomeScreenState extends State<FacultyHomeScreen> {
  List<Event> events = [];
  List<Announcement> announcements = [];
  Future<List<Event>> getAllPost() async {
    EventServices eventServices = EventServices();
    events = await eventServices.getAllEvents(context);
    return events;
  }

  Future<List<Announcement>> getAllAnnouncement() async {
    AnnouncementServices announcementServices = AnnouncementServices();
    announcements = await announcementServices.getAllAnnouncements(context);

    return announcements;
  }

  @override
  void initState() {
    super.initState();
    getAllPost();
    getAllAnnouncement();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            child: FutureBuilder(
                future: getAllAnnouncement(),
                initialData: announcements,
                builder: (context, snapshot) {
                  if (snapshot.data!.length > 5) {
                    snapshot.data!.length = 5;
                  } else {
                    snapshot.data!.length = snapshot.data!.length;
                  }
                  print(snapshot.data!.length);
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) =>
                        AnnouncementItem(context, snapshot.data![index]),
                  );
                }),
          ),
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
            child: FutureBuilder(
                future: getAllPost(),
                initialData: events,
                builder: (context, snapshot) {
                  if (snapshot.data!.length > 5) {
                    snapshot.data!.length = 5;
                  } else {
                    snapshot.data!.length = snapshot.data!.length;
                  }
                  return GridView.builder(
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) =>
                        EventItem(snapshot.data![index], context),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

Widget AnnouncementItem(BuildContext context, Announcement announcement) {
  var date = announcement.announcementPublishedOn.split("T")[0];
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
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
                child: Image.network(
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
                            formatter.format(DateTime.parse(date)),
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
  var date = event.eventRegistrationDeadline.split("T")[0];

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
            child: Image.network(
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
                            date.split(" ")[0].split("-")[2],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            month(int.parse(date.split(" ")[0].split("-")[1])),
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

String month(int? index) {
  switch (index) {
    case 00:
      return '';
    case 01:
      return 'Jan';
    case 02:
      return 'Feb';
    case 03:
      return 'Mar';
    case 04:
      return 'Apr';
    case 05:
      return 'May';
    case 06:
      return 'Jun';
    case 07:
      return 'Jul';
    case 08:
      return 'Aug';
    case 09:
      return 'Sep';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    case 12:
      return 'Dec';

    default:
      return '';
  }
}
