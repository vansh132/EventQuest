import 'package:eventquest/models/announcement.dart';
import 'package:eventquest/models/event.dart';
import 'package:eventquest/screen_items/faculty_custom_navigation_bottom_bar.dart';
import 'package:eventquest/screen_items/highlights.dart';
import 'package:eventquest/screens/student_screens/announcement_screens/announcement_detail_screen.dart';
import 'package:eventquest/screens/student_screens/event_screens/event_detail_screen.dart';
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
          "assets/images/placement.jpeg",
        ],
        publishedBy: "Helen K Joy",
        publishedOn: DateTime(2024, 1, 23),
      ),
      Announcement(
        title: 'Gateways',
        description:
            "Hey \n\nHope you're doing awesome! 🌟 We've got some seriously cool updates about Gateways 2023, and we couldn't wait to share the deets with you.\n\n📖 Event Brochure:\nGuess what? The Gateways 2023 Event Brochure just dropped! It's your backstage pass to all the cool stuff lined up. Check it out [https://heyzine.com/flip-book/628b52ff0e.html] and start planning your game plan.\n\n🎨 Event Poster:\nWe went all out on the poster this year, and it's basically a work of art. Seriously, you'll want to frame this. Get a sneak peak here!\n\n🎟️ Registration Link:\nReady to party with us? Hit up the registration link [ https://gateways.christuniversity.in/] and lock in your spot. It's gonna be epic, and we want you there with bells on!\n\nFeel free to spread the word – the more, the merrier! Can't wait to see you at Gateways 2023. 🚀\n\nCheers,\nTeam Gateways 2023.",
        image: [
          "assets/images/gateways.jpeg",
        ],
        publishedBy: "Dr. Suresh K.",
        publishedOn: DateTime(2024, 1, 23),
      ),
      Announcement(
        title: 'Khristu Fest',
        description:
            'Congratulations to the team from TECHFUSE at Christ Deemed to be University - Central Campus [MCA] for your outstanding achievement as Overall Champions! Your dedication and hard work have truly paid off, showcasing the spirit of excellence and teamwork. May this victory inspire you and your peers to reach new heights in all your future endeavours. Well done to everyone involved in this remarkable accomplishment!',
        image: ["assets/images/kristu.jpeg"],
        publishedBy: "Dr. Sudhakar T",
        publishedOn: DateTime(2024, 1, 10),
      ),
      Announcement(
        title: 'Python Peer Learning',
        description:
            "Peer-to-peer learning is a highly beneficial educational approach where students engage with each other to attain educational goals, sharing knowledge and experiences to enrich their understanding. In this image, we observe a group of individuals in a classroom environment focused on a screen displaying what appears to be Python code, indicating a collaborative learning session on programming.\n\nThe importance of peer learning, especially in contexts such as learning Python or any other programming language, cannot be overstated. It fosters a supportive environment where learners can clarify their doubts, learn from each other\'s strengths, and work collaboratively to solve complex problems. Moreover, peer learning encourages the development of critical thinking and communication skills, as students must articulate their thoughts and ideas clearly.\n\nIt also builds confidence, as students validate their knowledge by teaching others, and it creates a sense of community, promoting a network of support that can be invaluable during the learning process and beyond.\n\nGreat work to all involved in the peer-to-peer learning session. Your collaborative efforts are not only enhancing your individual skills but are also strengthening your collective knowledge. Keep up the excellent work, and continue to support and learn from one another – it's through such shared dedication and teamwork that true learning flourishes. Best wishes on your coding journey!",
        image: ["assets/images/pythonPeer.png"],
        publishedBy: "Helen K Joy",
        publishedOn: DateTime(2024, 1, 10),
      ),
    ];
    List<Event> events = [
      Event(
        eventId: "abc132",
        eventCategory: "UG",
        eventName: "BASIC FIRST AI",
        description:
            "Hi there! 👋\nExciting news! We're hosting a Certificate Programme in Basic First Aid on Thursday, 25 January 2024. It's a fantastic opportunity to learn life-saving skills, presented in collaboration with St. John's National Academy of Health Sciences and Christ University, Bangalore.\n🚀 Key Details:\nFee: Rs. 250/- only\nTime: 1:30 PM - 4:30 PM\nVenue: St. John's Medical College\nPlaces are limited to 35 per batch, so make sure to secure your spot ASAP!\n🔗 Scan the QR codes in the attached poster to register for Batch 2 or Batch 3.\nDon't miss out on this chance to become a part of the Rapid Action First Aid Team (RAFT) and make a difference! 🚑\nSee you there!",
        eventLink: "https://basicfirstaid.org",
        publishedOn: DateTime.now(),
        eventImages: "assets/images/BASICFIRSTAI.jpeg",
        eventAmount: 200,
        contactPerson: "Helen K Joy",
        contactNo: 9099897859,
        noOfParticipants: 2,
        registartionDeadline: DateTime(2024, 2, 15),
      ),
      Event(
        eventId: "def456",
        eventCategory: "PG",
        eventName: "NRITTA",
        description:
            "Greetings from Student Welfare Office✨✨\n🕺💃 Ready to groove and show off your moves? We're hosting auditions for NRITTA, and we want YOU to be a part of the rhythm! 🌟 \n📅 Date: 12th, 13th and 14th  February 2024\n🕰️ Time: 4pm onwards \n📍 Location: Dance Studio, IVY Basement, Audi block \nDon't miss your chance to shine and be a part of Nritta! Spread the word, bring your friends, and let's make this audition a dance party to remember!",
        publishedOn: DateTime.now().subtract(const Duration(days: 5)),
        eventImages: "assets/images/NRITTA.jpeg",
        eventLink: "https://codingcompetition.com",
        eventAmount: 0,
        contactPerson: "John Doe",
        contactNo: 9876543210,
        noOfParticipants: 6,
        registartionDeadline: DateTime(2024, 2, 18),
      ),
      Event(
        eventId: "ghi789",
        eventCategory: "PG",
        eventName: "INHSA",
        description:
            "🚀 INHSA 2024: Digital Health Innovation Conclave \nCalling all healthtech startups!\nUnlock your potential at the Innovate Health South Asia 2024 conclave and compete for The Best Startup Award!\n🗓️ Date: 3rd February 2024\n Venue: VRR Hotels & Convention Hall, E-City Phase 1, Bangalore\nBenefits include:\nStage time for presentation\nCash reward\nOpportunity to exhibit\nNetworking with investors and industry leaders\nMentorship and incubation support\nDon't miss this chance to shine amongst the best in the digital healthcare industry.\n👉 Register now by scanning the QR code or contact us at +91 9606904387 or admire.dighealth@iihmrbangalore.edu.in\nBest of luck, and we hope to see you there!",
        publishedOn: DateTime.now().subtract(const Duration(days: 10)),
        eventImages: "assets/images/INHSA.jpeg",
        eventLink: "https://artexhibition.com",
        eventAmount: 50,
        contactPerson: "Alice Smith",
        contactNo: 1234567890,
        noOfParticipants: 30,
        registartionDeadline: DateTime(2024, 2, 20),
      ),
      Event(
        eventId: "ghi789",
        eventCategory: "UG",
        eventName: "PITCHFIRK",
        description:
            "🚀 Pitchfork Event Alert at CHRIST University!\n🎓 The Department of Economics and Agasthya - The Entrepreneurship Cell presents an incredible opportunity for innovative minds!\n📍 *Venue:* Skyview Central Block\n *Date:* 15th February 2024\n⏰ *Submission Deadline:* 8th February 2024\n💡 Get ready to pitch your groundbreaking ideas and stand a chance to win amazing cash prizes:\n🥇 1st Place: ₹3500 INR\n🥈 2nd Place: ₹2500 INR\n🥉 3rd Place: ₹1500 INR\nFor more information and to submit your ideas, scan the QR code on the poster or contact:\n- Chaitanya: 7489813136\n- Swastika: 9438733368\n\nDon't miss out on this chance to showcase your entrepreneurial talent and win big! 🏆",
        publishedOn: DateTime.now().subtract(const Duration(days: 10)),
        eventImages: "assets/images/PITCHFIRK.jpeg",
        eventLink: "https://artexhibition.com",
        eventAmount: 50,
        contactPerson: "Alice Smith",
        contactNo: 1234567890,
        noOfParticipants: 30,
        registartionDeadline: DateTime(2024, 2, 28),
      ),
      Event(
        eventId: "ghi789",
        eventCategory: "UG",
        eventName: "PRAYAS",
        description:
            "🌟 *PRAYAS 2024 at CHRIST University presents KALEIDO-QUEST!*\n\n✨ Join the Department of Commerce for a thrilling adventure and a variety of exciting events:\n\n🚀 *Among Us IRL* - 29th January\n🔴 *Red Light, Green Light* - 30th January\n⚪ *Monochrome Hues* - 31st January\n🎲 *Gganbu* - 1st February\n🔓 *Escape Room* - 2nd February\nGet ready to level up with these immersive experiences!\n\n📣 *Register Now* for an unforgettable journey filled with challenges and fun!\n\n🚀 Don't miss out on the action - seize the opportunity to be part of something extraordinary!\n\nFor additional details and registration, make sure to get in touch or follow the updates. Let's make PRAYAS 2024 a remarkable event together! 🌌",
        publishedOn: DateTime.now().subtract(const Duration(days: 10)),
        eventImages: "assets/images/PRAYAS.jpeg",
        eventLink: "https://artexhibition.com",
        eventAmount: 50,
        contactPerson: "Alice Smith",
        contactNo: 1234567890,
        noOfParticipants: 30,
        registartionDeadline: DateTime(2024, 2, 29),
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
              child: Image.asset(
                announcement.image![0],
                fit: BoxFit.cover,
              )),
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
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            event.eventImages,
            fit: BoxFit.cover,
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
