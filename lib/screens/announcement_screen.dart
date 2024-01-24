import 'package:eventquest/models/announcement.dart';
import 'package:eventquest/screens/detailed_screens/announcement_detail_screen.dart';
import 'package:eventquest/widgets/top_bar.dart';
import 'package:eventquest/widgets/user_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnnouncementScreen extends StatelessWidget {
  final List<Announcement> announcements = [
    Announcement(
      title: 'Placement',
      description: 'Congratulations to all the students who got placed.',
      image:
          "https://media.istockphoto.com/id/514363071/photo/just-one-moment-please.webp?b=1&s=170667a&w=0&k=20&c=8xY02WALsH-RYsCz83EBigqH4z3RQg76ZfOhgQjlefU=",
    ),
    Announcement(
      title: 'Nexus - Fest',
      description: 'Congratulations to all the winners!!',
      image:
          "https://images.unsplash.com/photo-1658581872509-c8d19777bd24?q=80&w=2831&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: Column(
          children: [
            TopBar(),
            UserBar(),
            Expanded(
              child: ListView.builder(
                itemCount: announcements.length,
                itemBuilder: (context, index) {
                  return buildAnnouncementCard(announcements[index], context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAnnouncementCard(
      Announcement announcement, BuildContext context) {
    String formattedDate =
        DateFormat('MMM d, y').format(DateTime.now().toLocal());

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AnnouncementDetailScreen.routeName,
            arguments: announcement);
      },
      child: Hero(
        tag: 'announcement_image_${announcement.hashCode}',
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        announcement.image!,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          announcement.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          announcement.description,
                          style: TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 65,
                        ),
                        Text(
                          "Date",
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
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
