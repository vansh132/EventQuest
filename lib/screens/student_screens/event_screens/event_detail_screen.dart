import 'package:eventquest/models/event.dart';
import 'package:eventquest/screens/student_screens/registration_screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsScreen extends StatelessWidget {
  static const String routeName = '/event-detail-screen';

  const EventDetailsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context)!.settings.arguments as Event;
    return Scaffold(
      appBar: AppBar(
        title: Text(event.eventName),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Event Image with Hero Animation
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HeroImageScreen(image: event.eventImage),
                    ),
                  );
                },
                child: Hero(
                  tag: event.eventImage, // Unique tag for the hero animation
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    child: Image.network(
                      event.eventImage,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),

              // Event Amount and Registration Deadline
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text("Participation Instructions",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 65,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Registration Fees:",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Registration Deadline:",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "No Of Participation:",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(event.eventAmount.toString()),
                              const SizedBox(height: 8),
                              Text(
                                event.eventRegistrationDeadline.split("T")[0],
                              ),
                              const SizedBox(height: 8),
                              Text(event.eventNoOfParticipants.toString()),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Event Link
              InkWell(
                onTap: () {
                  _launchURL(event.eventLink);
                },
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    children: [
                      const TextSpan(
                        text: 'Event Link:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                          text: ' ${event.eventLink}',
                          style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.redAccent)),
                    ],
                  ),
                ),
              ),

              // Description
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Description:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text: event.eventDescription),
                          ],
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),

              // Contact Person and Contact Number
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                        children: [
                          const TextSpan(
                            text: 'Contact Person:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: ' ${event.eventContactPerson}'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                        children: [
                          const TextSpan(
                            text: 'Contact Number:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: ' ${event.eventContactPersonNo}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Registration Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff003049),
                      foregroundColor: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.routeName);
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}

class HeroImageScreen extends StatelessWidget {
  final String image;

  const HeroImageScreen({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context); // Go back when tapped on the image
        },
        child: Center(
          child: Hero(
            tag: image, // Same tag as used in the source screen
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
