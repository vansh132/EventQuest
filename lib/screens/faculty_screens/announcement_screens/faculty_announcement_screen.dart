import 'package:eventquest/models/announcement.dart';
import 'package:eventquest/screens/faculty_screens/announcement_screens/add_announcement_screen.dart';
import 'package:eventquest/screens/faculty_screens/announcement_screens/edit_announcement_screen.dart';
import 'package:eventquest/screens/student_screens/announcement_screens/announcement_detail_screen.dart';
import 'package:eventquest/services/announcement_services.dart';
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
  List<Announcement> announcements = [
    // Announcement(
    //   id: "1",
    //   announcementTitle: 'Placement',
    //   announcementDescription:
    //       'Heartiest congratulations to all the brilliant students who have achieved remarkable success and secured placements! Your hard work, dedication, and exceptional skills have paved the way for this significant accomplishment. Wishing you a future filled with continued success, growth, and prosperity. Well done!Heartiest congratulations to all the brilliant students who have achieved remarkable success and secured placements! Your hard work, dedication, and exceptional skills have paved the way for this significant accomplishment. Wishing you a future filled with continued success, growth, and prosperity. Well done!Heartiest congratulations to all the brilliant students who have achieved remarkable success and secured placements! Your hard work, dedication, and exceptional skills have paved the way for this significant accomplishment. Wishing you a future filled with continued success, growth, and prosperity. Well done!',
    //   announcementImages: [
    //     "assets/images/placement.jpeg",
    //   ],
    //   announcementPublishedBy: "Helen K Joy",
    //   announcementPublishedOn: DateTime(2024, 1, 23),
    // ),
    // Announcement(
    //   id: "2",
    //   announcementTitle: 'Gateways',
    //   announcementDescription:
    //       "Hey \n\nHope you're doing awesome! 🌟 We've got some seriously cool updates about Gateways 2023, and we couldn't wait to share the deets with you.\n\n📖 Event Brochure:\nGuess what? The Gateways 2023 Event Brochure just dropped! It's your backstage pass to all the cool stuff lined up. Check it out [https://heyzine.com/flip-book/628b52ff0e.html] and start planning your game plan.\n\n🎨 Event Poster:\nWe went all out on the poster this year, and it's basically a work of art. Seriously, you'll want to frame this. Get a sneak peak here!\n\n🎟️ Registration Link:\nReady to party with us? Hit up the registration link [ https://gateways.christuniversity.in/] and lock in your spot. It's gonna be epic, and we want you there with bells on!\n\nFeel free to spread the word – the more, the merrier! Can't wait to see you at Gateways 2023. 🚀\n\nCheers,\nTeam Gateways 2023.",
    //   announcementImages: [
    //     "assets/images/gateways.jpeg",
    //   ],
    //   announcementPublishedBy: "Dr. Suresh K.",
    //   announcementPublishedOn: DateTime(2024, 1, 23),
    // ),
    // Announcement(
    //   id: "3",
    //   announcementTitle: 'Khristu Fest',
    //   announcementDescription:
    //       'Congratulations to the team from TECHFUSE at Christ Deemed to be University - Central Campus [MCA] for your outstanding achievement as Overall Champions! Your dedication and hard work have truly paid off, showcasing the spirit of excellence and teamwork. May this victory inspire you and your peers to reach new heights in all your future endeavours. Well done to everyone involved in this remarkable accomplishment!',
    //   announcementImages: ["assets/images/kristu.jpeg"],
    //   announcementPublishedBy: "Dr. Sudhakar T",
    //   announcementPublishedOn: DateTime(2024, 1, 10),
    // ),
    // Announcement(
    //   id: "4",
    //   announcementTitle: 'Python Peer Learning',
    //   announcementDescription:
    //       "Peer-to-peer learning is a highly beneficial educational approach where students engage with each other to attain educational goals, sharing knowledge and experiences to enrich their understanding. In this image, we observe a group of individuals in a classroom environment focused on a screen displaying what appears to be Python code, indicating a collaborative learning session on programming.\n\nThe importance of peer learning, especially in contexts such as learning Python or any other programming language, cannot be overstated. It fosters a supportive environment where learners can clarify their doubts, learn from each other\'s strengths, and work collaboratively to solve complex problems. Moreover, peer learning encourages the development of critical thinking and communication skills, as students must articulate their thoughts and ideas clearly.\n\nIt also builds confidence, as students validate their knowledge by teaching others, and it creates a sense of community, promoting a network of support that can be invaluable during the learning process and beyond.\n\nGreat work to all involved in the peer-to-peer learning session. Your collaborative efforts are not only enhancing your individual skills but are also strengthening your collective knowledge. Keep up the excellent work, and continue to support and learn from one another – it's through such shared dedication and teamwork that true learning flourishes. Best wishes on your coding journey!",
    //   announcementImages: ["assets/images/pythonPeer.png"],
    //   announcementPublishedBy: "Dr. Kavitha R",
    //   announcementPublishedOn: DateTime(2024, 1, 10),
    // ),
  ];

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
        onPressed: () {
          Navigator.pushNamed(
            context,
            AddAnnouncementScreen.routeName,
          );
        },
        child: const Icon(Icons.add),
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
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            formatter.format(DateTime.parse(date)),
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
                const SizedBox(
                  height: 8,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AnnouncementDetailScreen.routeName,
                            arguments: announcement,
                          );
                        },
                        child: const Text('View'),
                      ),
                      ElevatedButton(
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
