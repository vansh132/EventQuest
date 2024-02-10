import 'package:eventquest/models/event.dart';
import 'package:eventquest/screens/student_screens/event_screens/event_detail_screen.dart';

import 'package:eventquest/widgets/top_bar.dart';
import 'package:eventquest/widgets/user_info.dart';
import 'package:flutter/material.dart';

class EventScreen extends StatefulWidget {
  static const String routeName = '/event-screen';
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  int? _value;
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

  @override
  Widget build(BuildContext context) {
    List<Event> filteredEvents = _value == null
        ? events
        : events
            .where((event) => event.eventCategory == getCategory(_value!))
            .toList();

    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            TopBar(),
            UserBar(),
            const SizedBox(
              height: 8,
            ),
            filterOption(context),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: filteredEvents.length,
                  itemBuilder: (context, index) {
                    return buildEventCard(filteredEvents[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEventCard(Event event) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, EventDetailsScreen.routeName,
            arguments: event);
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 4.0,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                event.eventImages,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Card(
                    color: Colors.white.withOpacity(0.7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 4.0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
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
                      children: [
                        Text(
                          event.eventName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          event.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget filterOption(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const Text(
            'Select your preference:',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10.0),
          Wrap(
            spacing: 20.0,
            children: List<Widget>.generate(
              2,
              (int index) {
                String optionText = '';

                switch (index) {
                  case 0:
                    optionText = 'UG';
                    break;
                  case 1:
                    optionText = 'PG';
                    break;

                  default:
                    optionText = '';
                    break;
                }

                return ChoiceChip(
                  label: Text(
                    optionText,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  selected: _value == index,
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected ? index : null;
                    });
                  },
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  String getCategory(int? index) {
    if (index == null) {
      return '';
    }

    switch (index) {
      case 0:
        return 'UG';
      case 1:
        return 'PG';

      default:
        return '';
    }
  }
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
