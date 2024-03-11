import 'package:eventquest/models/announcement.dart';
import 'package:eventquest/screens/faculty_screens/announcement_screens/add_announcement_screen.dart';
import 'package:eventquest/screens/faculty_screens/announcement_screens/edit_announcement_screen.dart';
import 'package:eventquest/screens/student_screens/announcement_screens/announcement_detail_screen.dart';
import 'package:eventquest/services/announcement_services.dart';
import 'package:eventquest/themes.dart';
import 'package:intl/intl.dart';
import 'package:eventquest/widgets/top_bar.dart';
import 'package:eventquest/widgets/user_info.dart';
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
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            TopBar(),
            UserBar(context),
            FutureBuilder(
                future: getAllAnnouncement(),
                initialData: announcements,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return buildAnnouncementCard(snapshot.data![index]);
                          },
                        ),
                      ),
                    );
                  } else if (snapshot.data == null) {
                    return const Center(
                      child: Text("No data found"),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
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
    var date = announcement.announcementPublishedOn.split("T")[0];
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return Hero(
      tag: 'announcement_image_${announcement.hashCode}',
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Card(
          color: Color(0xfffbfcf8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Wrap the image with a Container to set fixed size
                    Container(
                      height: 100, // Set the desired height
                      width: 100, // Set the desired width
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
                          Text(
                            announcement.announcementTitle,
                            style: const TextStyle(
                              color: Color(0xff012a4a), // Background color,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                          Text(
                            "By: ${announcement.announcementPublishedBy}",
                            style: const TextStyle(
                              color: Color(0xff012a4a),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 65,
                          ),
                          const Text(
                            "Date: ",
                            style: TextStyle(
                              color: Color(0xff012a4a),
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            formatter.format(DateTime.parse(date)),
                            style: const TextStyle(
                              color: Color(0xff012a4a),
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffd4d7df),
                            foregroundColor:
                                AppColors.mainColor // Background color
                            ),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AnnouncementDetailScreen.routeName,
                            arguments: announcement,
                          );
                        },
                        child: Text('View'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffd4d7df),
                            foregroundColor:
                                AppColors.mainColor // Background color
                            ),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            EditAnnouncementScreen.routeName,
                            arguments: announcement,
                          );
                        },
                        child: const Text('Edit'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffd4d7df),
                            foregroundColor:
                                AppColors.mainColor // Background color
                            ),
                        onPressed: () {
                          announcementServices.deleteAnnouncement(
                              context: context,
                              announcement: announcement,
                              onSuccess: () {
                                setState(() {
                                  announcements;
                                });
                              });
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
