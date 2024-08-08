import 'dart:async';

import 'package:eventquest/models/announcement.dart';
import 'package:eventquest/screens/faculty_screens/announcement_screens/add_announcement_screen.dart';
import 'package:eventquest/screens/faculty_screens/announcement_screens/edit_announcement_screen.dart';
import 'package:eventquest/screens/student_screens/announcement_screens/announcement_detail_screen.dart';
import 'package:eventquest/services/announcement_services.dart';
import 'package:eventquest/theme/theme_ext.dart';
import 'package:eventquest/themes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class FacultyAnnouncementScreen extends StatefulWidget {
  FacultyAnnouncementScreen({super.key});

  @override
  State<FacultyAnnouncementScreen> createState() =>
      _FacultyAnnouncementScreenState();
}

class _FacultyAnnouncementScreenState extends State<FacultyAnnouncementScreen> {
  List<Announcement> announcements = [];

  AnnouncementServices announcementServices = AnnouncementServices();

  Future<List<Announcement>> getAllAnnouncement() async {
    announcements = await announcementServices.getAllAnnouncements(context);
    return announcements;
  }

  @override
  void initState() {
    getAllAnnouncement();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Achievements",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "\"You don't have to be great to start, but you have to start to be great.\"",
                style: GoogleFonts.raleway(
                  fontSize: 14,
                  color: appColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 500,
              child: FutureBuilder(
                  future: getAllAnnouncement(),
                  initialData: announcements,
                  builder: (context, snapshot) {
                    if (snapshot.data!.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/noDataFound.gif',
                            height: 100,
                          ),
                          Text(
                            'No Announcements found',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      );
                    } else if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return buildAnnouncementCard(snapshot.data![index]);
                          },
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        onPressed: () {
          Navigator.pushNamed(
            context,
            AddAnnouncementScreen.routeName,
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildAnnouncementCard(Announcement announcement) {
    final appColor = context.appColors;
    var date = announcement.announcementPublishedOn.split("T")[0];
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return Hero(
      tag: 'announcement_image_${announcement.hashCode}',
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            AnnouncementDetailScreen.routeName,
            arguments: announcement,
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Card(
            color: appColor.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Wrap the image with a Container to set fixed size
                      SizedBox(
                        height: 100, // Set the desired height
                        width: 90, // Set the desired width
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: announcement.announcementImages!.isEmpty
                              ? const Text("No image")
                              : Image.network(
                                  announcement.announcementImages![0],
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(announcement.announcementTitle,
                                style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 8),
                            Text(
                              announcement.announcementDescription,
                              style: const TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "By: ${announcement.announcementPublishedBy}",
                                  style: const TextStyle(
                                    color: Color(0xff012a4a),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: appColor.accent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    formatter.format(DateTime.parse(date)),
                                    style: const TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appColor.accent,
                              foregroundColor: AppColors.mainColor,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                EditAnnouncementScreen.routeName,
                                arguments: announcement,
                              );
                            },
                            child: Text('Edit',
                                style: Theme.of(context).textTheme.titleSmall),
                          ),
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appColor.accent,
                              foregroundColor: AppColors.mainColor,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          announcementServices
                                              .deleteAnnouncement(
                                            context: context,
                                            announcement: announcement,
                                            onSuccess: () {
                                              setState(() {
                                                announcements;
                                              });
                                            },
                                          );
                                        },
                                        child: const Text('Yes'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('No'),
                                      ),
                                    ],
                                    title: const Text('Status'),
                                    content: const Text(
                                        'Are you sure to delete Announcement?'),
                                  );
                                },
                              );
                            },
                            child: Text(
                              'Delete',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
