import 'package:eventquest/models/announcement.dart';
import 'package:eventquest/screens/student_screens/announcement_screens/announcement_detail_screen.dart';
import 'package:eventquest/services/announcement_services.dart';
import 'package:eventquest/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class AnnouncementScreen extends StatefulWidget {
  AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
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
    final height = MediaQuery.of(context).size.height;

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
            SizedBox(
              height: height * 0.66,
              child: FutureBuilder(
                future: Future.delayed(
                    const Duration(seconds: 1), () => getAllAnnouncement()),
                initialData: announcements,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: buildShimmerAnnouncementCard(),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.data!.isEmpty) {
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return buildAnnouncementCard(snapshot.data![index]);
                        },
                      ),
                    );
                  } else if (snapshot.data == null) {
                    return const Center(
                      child: Text("No data found"),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildShimmerAnnouncementCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 100,
              color: Colors.grey[300],
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 20,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    height: 16,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 80,
                    height: 16,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 50,
                    height: 16,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 65),
                  Container(
                    width: 40,
                    height: 8,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 40,
                    height: 8,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAnnouncementCard(Announcement announcement) {
    final appColors = context.appColors;
    var date = announcement.announcementPublishedOn.split("T")[0];
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AnnouncementDetailScreen.routeName,
          arguments: announcement,
        );
      },
      child: Hero(
        tag: 'announcement_image_${announcement.hashCode}',
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Card(
            color: appColors.accent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Wrap the image with a Container to set fixed size
                  Container(
                    height: 130, // Set the desired height
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
                  const SizedBox(width: 8),
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
                          style: const TextStyle(fontSize: 13),
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
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
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
                  SizedBox(
                    height: 8,
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
