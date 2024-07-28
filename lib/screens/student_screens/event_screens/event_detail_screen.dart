import 'package:eventquest/models/event.dart';
import 'package:eventquest/models/eventReport.dart';
import 'package:eventquest/models/eventSynopsis.dart';
import 'package:eventquest/models/generalInfo.dart';
import 'package:eventquest/models/participantsDetail.dart';
import 'package:eventquest/models/speakerBio.dart';
import 'package:eventquest/models/speakerDetails.dart';
import 'package:eventquest/provider/user_provider.dart';
import 'package:eventquest/screens/student_screens/event_screens/eventReport.dart';
import 'package:eventquest/screens/student_screens/registration_screens/registration_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsScreen extends StatefulWidget {
  static const String routeName = '/event-detail-screen';

  const EventDetailsScreen({Key? key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final model = GenerativeModel(
      model: 'gemini-pro', apiKey: 'AIzaSyBXpwcezV-uPCUrHJAeWHkGBlTgSZ0kdQ4');
  String generatedContent = '';
  String generatedHighlightsOfActivity = '';
  String generatedKeyTakeAways = '';
  String generatedActivitySummary = '';
  String generatedFollowUp = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final Event event = ModalRoute.of(context)!.settings.arguments as Event;

      await _generateContent(event); // Wait for _generateContent to complete
      await _generateHighlightsOfActivity(
          event); // Wait for _generateC to complete
      await _generateKeyTakeAways(event); // Wait for _generateC to complete
      await _generateActivitySummary(event); // Wait for _generateC to complete
      await _generateFollowUp(event); // Wait for _generateC to complete
    });
  }

  Future<void> _generateContent(Event event) async {
    final content = [
      Content.text(
          "${event.eventName} Event name and ${event.eventDescription} event description.Please write the report for this event for perfect 800 words only in single paragraph only.please dont use **. Don't write title"),
    ];
    final response = await model.generateContent(content);
    setState(() {
      generatedContent = response.text!;
    });
  }

  Future<void> _generateHighlightsOfActivity(Event event) async {
    final content = [
      Content.text(
          "${event.eventName} Event name and ${event.eventDescription} event description.Please write the Highlight of the Activity report for this event in simple paragraph with perfect 50 words only which should be real.please dont use **"),
    ];
    final response = await model.generateContent(content);
    setState(() {
      generatedHighlightsOfActivity = response.text!;
    });
  }

  Future<void> _generateKeyTakeAways(Event event) async {
    final content = [
      Content.text(
          "${event.eventName} Event name and ${event.eventDescription} event description.Please write the Key Take Aways of event in report in simple 2 bullet points which should be real.please dont use **"),
    ];
    final response = await model.generateContent(content);
    setState(() {
      generatedKeyTakeAways = response.text!;
    });
  }

  Future<void> _generateActivitySummary(Event event) async {
    final content = [
      Content.text(
          "${event.eventName} Event name and ${event.eventDescription} event description.Please write the Summary of the Activity report for this event in simple paragraph of perfect 70 words which should be real.please dont use **"),
    ];
    final response = await model.generateContent(content);
    setState(() {
      generatedActivitySummary = response.text!;
    });
  }

  Future<void> _generateFollowUp(Event event) async {
    final content = [
      Content.text(
          "${event.eventName} Event name and $generatedActivitySummary.Please write the FollowUp of the Activity for this event in simple one point 20 words only which should be real.please dont use **"),
    ];
    final response = await model.generateContent(content);
    setState(() {
      generatedFollowUp = response.text!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context)!.settings.arguments as Event;

    final user = Provider.of<UserProvider>(context, listen: false).user;
    var date = event.eventRegistrationDeadline.split("T")[0];
    final DateFormat formatter = DateFormat('dd-MM-yyyy');

    List<SpeakerDetails> speakerDetails = [];

    GeneralInfo generalInfo = GeneralInfo(
        type: '',
        title: event.eventName,
        date: formatter
            .format(DateTime.parse(event.eventPublishedOn.split(" ")[0])),
        time: '',
        venue: '');

    ParticipantsDetail participantsProfile =
        ParticipantsDetail(typeOfParticipants: '', noOfParticipants: 5);

    EventSynopsis synopsis = EventSynopsis(
        highlights: generatedHighlightsOfActivity,
        keyTakeaways: generatedKeyTakeAways,
        summary: generatedActivitySummary,
        followUp: generatedFollowUp);

    String rapporteurName = '';
    String raporteurEmail = '';
    String geoTag = '';
    String feedbackForm = '';
    String activityImage = '';

    List<SpeakersBio> speakersProfile = [];

    final EventReport eventReport = EventReport(
        generalInfo: generalInfo,
        speakerDetails: speakerDetails,
        participantsDetail: participantsProfile,
        eventSynopsis: synopsis,
        rapporteurName: rapporteurName,
        rapporteurEmail: raporteurEmail,
        eventDescriptiveReport: generatedContent,
        speakersProfile: speakersProfile,
        geoTagPhotos: geoTag,
        feedbackForm: feedbackForm,
        activityImages: activityImage,
        poster: event.eventImage);
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
                    borderRadius: const BorderRadius.only(
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
                              Text(event.eventAmount == 0
                                  ? 'Free'
                                  : event.eventAmount.toString()),
                              const SizedBox(height: 8),
                              Text(
                                formatter
                                    .format(DateTime.parse(date.split(" ")[0])),
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
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  children: [
                    const TextSpan(
                      text: 'Event Link:',
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                            color: Colors.redAccent)),
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
              if (user.type == 'Student')
                // Registration Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff003049),
                        foregroundColor: Colors.white),
                    onPressed: () {
                      Navigator.pushNamed(context, RegistrationScreen.routeName,
                          arguments: event);
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff003049),
                        foregroundColor: Colors.white),
                    onPressed: () async {
                      if (generatedActivitySummary.isEmpty ||
                          generatedContent.isEmpty ||
                          generatedFollowUp.isEmpty ||
                          generatedFollowUp.isEmpty ||
                          generatedHighlightsOfActivity.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Please complete all generated content before proceeding.'),
                          ),
                        );
                      } else {
                        Navigator.of(context).pushNamed(ReportForm.routeName,
                            arguments: eventReport);
                      }
                    },
                    child: const Text(
                      'Edit Report',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
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
