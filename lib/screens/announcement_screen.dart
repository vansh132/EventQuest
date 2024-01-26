import 'package:eventquest/models/announcement.dart';
import 'package:eventquest/screens/detailed_screens/announcement_detail_screen.dart';
import 'package:eventquest/widgets/top_bar.dart';
import 'package:eventquest/widgets/user_info.dart';
import 'package:flutter/material.dart';

class AnnouncementScreen extends StatelessWidget {
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
      title: 'Nexus - Fest',
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

   AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Colors.amber,
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
    String primaryImage = announcement.image!.isNotEmpty
        ? announcement.image!.first
        : "https://placeholder.com/80"; // Replace with your default image URL

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AnnouncementDetailScreen.routeName,
            arguments: announcement);
      },
      child: Hero(
        tag: 'announcement_image_${announcement.hashCode}',
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                        primaryImage,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          announcement.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          announcement.description,
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "By: ${announcement.publishedBy}",
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 65,
                        ),
                        const Text(
                          "Date: ",
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${announcement.publishedOn.day}/${announcement.publishedOn.month}/${announcement.publishedOn.year}",
                          style: const TextStyle(
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
