import 'package:eventquest/models/event.dart';
import 'package:eventquest/screens/constants/utils.dart';
import 'package:eventquest/screens/student_screens/registration_screens/registration_screen.dart';
import 'package:eventquest/theme/theme_ext.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsScreen extends StatefulWidget {
  static const String routeName = '/event-detail-screen';

  const EventDetailsScreen({Key? key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final Event event = ModalRoute.of(context)!.settings.arguments as Event;
    var date = event.eventRegistrationDeadline.split("T")[0];
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final DateTime registrationDeadline = DateTime.parse(date);
    final bool isRegistrationOpen =
        DateTime.now().isBefore(registrationDeadline);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.accent,
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
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.all(8.0), // Padding around the image
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            16.0), // Adjust the radius for desired roundness
                        child: Image.network(
                          event.eventImage,
                          height: 250,
                          width: double.infinity, // Fill available width
                          fit: BoxFit.contain, // Cover the entire area
                        ),
                      ),
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
                    color: appColors.accent,
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
                      Text("Participation Instructions",
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Registration Fees:",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              const SizedBox(height: 8),
                              Text("Registration Deadline:",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              const SizedBox(height: 8),
                              Text("No Of Participation:",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.eventAmount == 0
                                    ? 'Free'
                                    : event.eventAmount.toString(),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                style: Theme.of(context).textTheme.bodyMedium,
                                formatter.format(
                                  DateTime.parse(date.split(" ")[0]),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                event.eventNoOfParticipants.toString(),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              // Event Link
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Event Link: ',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextSpan(
                        text: ' ${event.eventLink}',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            var url = event.eventLink;
                            if (!await launchUrl(Uri.parse(url))) {
                              throw Exception('Could not launch $url');
                            }
                          },
                        style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0xff0B3F63))),
                  ],
                ),
              ),

              // Description
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description :",
                        style: Theme.of(context).textTheme.titleMedium,
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
                            TextSpan(
                                text: event.eventDescription,
                                style: Theme.of(context).textTheme.bodyMedium),
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
                          TextSpan(
                            text: 'Contact Person:',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          TextSpan(
                              text: ' ${event.eventContactPerson}',
                              style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    RichText(
                      text: TextSpan(
                        style:
                            const TextStyle(fontSize: 18, color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Contact Number:',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          TextSpan(
                              text: ' ${event.eventContactPersonNo}',
                              style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Registration Button
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: isRegistrationOpen
                            ? appColors.primary
                            : Color(0xffAACCE4)),
                    onPressed: isRegistrationOpen
                        ? () {
                            Navigator.pushNamed(
                                context, RegistrationScreen.routeName,
                                arguments: event);
                          }
                        : () {
                            customSnackbar(context, "Failed",
                                "Sorry!! Registration Closed.");
                          }, // Disable button if registration is closed
                    child: const Text(
                      'Register',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeroImageScreen extends StatelessWidget {
  final String image;

  const HeroImageScreen({super.key, required this.image});

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
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
