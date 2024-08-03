import 'package:eventquest/constants/custom_colors.dart';
import 'package:eventquest/models/announcement.dart';
import 'package:eventquest/models/event.dart';
import 'package:eventquest/screen_items/highlights.dart';
import 'package:eventquest/screens/student_screens/announcement_screens/announcement_detail_screen.dart';
import 'package:eventquest/screens/student_screens/event_screens/event_detail_screen.dart';
import 'package:eventquest/services/announcement_services.dart';
import 'package:eventquest/services/event_services.dart';
import 'package:eventquest/theme/theme_ext.dart';
import 'package:eventquest/widgets/top_bar.dart';
import 'package:eventquest/widgets/user_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            branding(context),
            userDetails(context),
            const Highlights(),
            const SizedBox(
              height: 12,
            ),
            recentEvents(context, events),
            recentAnnouncements(context, announcements),
          ],
        ),
      ),
    );
  }

  Widget recentAnnouncements(
      BuildContext context, List<Announcement> announcements) {
    final appColors = context.appColors;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(12),
      // color: Colors.greenAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Achievements",
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: appColors.primary,
                ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 200,
            child: FutureBuilder(
                future: getAllAnnouncement(),
                initialData: announcements,
                builder: (context, snapshot) {
                  if (snapshot.data!.length > 5) {
                    snapshot.data!.length = 5;
                  } else {
                    snapshot.data!.length = snapshot.data!.length;
                  }
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) =>
                        announcementItem(context, snapshot.data![index]),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget recentEvents(BuildContext context, List<Event> events) {
    final appColors = context.appColors;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(12),
      // color: Colors.deepOrange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Events",
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: appColors.primary,
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
                        eventItem(snapshot.data![index], context),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

Widget announcementItem(BuildContext context, Announcement announcement) {
  final appColors = context.appColors;
  var date = announcement.announcementPublishedOn.split("T")[0];
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  return GestureDetector(
    onTap: () => Navigator.pushNamed(
        context, AnnouncementDetailScreen.routeName,
        arguments: announcement),
    child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: Colors.grey,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1), // Shadow color with opacity
            spreadRadius: 2, // The spread radius
            blurRadius: 3, // The blur radius
            offset: const Offset(1, 2), // The offset in x and y directions
          ),
        ],
        color: appColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 100,
              width: 100,
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
                height: MediaQuery.of(context).size.height * 0.1,
                margin: const EdgeInsets.symmetric(horizontal: 6),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          announcement.announcementTitle,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: appColors.richBlack,
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
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: appColors.richBlack,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                          ),
                          Text(
                            formatter.format(DateTime.parse(date)),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  fontSize: 10,
                                  color: appColors.richBlack,
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

Widget eventItem(Event event, BuildContext context) {
  var date = event.eventRegistrationDeadline.split("T")[0];

  return GestureDetector(
    onTap: () => Navigator.pushNamed(context, EventDetailsScreen.routeName,
        arguments: event),
    child: Container(
      margin: const EdgeInsets.only(right: 12),
      // padding: const EdgeInsets.all(8),
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
                    color: CustomColors.bgLight,
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
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black54),
                          child: Text(
                            event.eventName,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white),
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
