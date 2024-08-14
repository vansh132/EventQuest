import 'package:eventquest/models/event.dart';
import 'package:eventquest/models/eventReport.dart';
import 'package:eventquest/models/eventSynopsis.dart';
import 'package:eventquest/models/generalInfo.dart';
import 'package:eventquest/models/participantsDetail.dart';
import 'package:eventquest/screens/faculty_screens/event_screens/reportgenerator.dart';
import 'package:eventquest/screens/student_screens/event_screens/eventReport.dart';
import 'package:eventquest/theme/theme_ext.dart';
import 'package:eventquest/themes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class FacultyEventDetailsScreen extends StatefulWidget {
  static const String routeName = '/faculty-event-detail-screen';

  const FacultyEventDetailsScreen({Key? key});

  @override
  State<FacultyEventDetailsScreen> createState() =>
      _FacultyEventDetailsScreenState();
}

class _FacultyEventDetailsScreenState extends State<FacultyEventDetailsScreen> {
  final EventReportGenerator reportGenerator = EventReportGenerator();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final Event event = ModalRoute.of(context)!.settings.arguments as Event;

      await reportGenerator.generateContent(event);
      await reportGenerator.generateHighlightsOfActivity(event);
      await reportGenerator.generateKeyTakeAways(event);
      await reportGenerator.generateActivitySummary(event);
      await reportGenerator.generateFollowUp(event);

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    final Event event = ModalRoute.of(context)!.settings.arguments as Event;
    var date = event.eventRegistrationDeadline.split("T")[0];
    final DateFormat formatter = DateFormat('dd-MM-yyyy');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.accent,
        title: Text(event.eventName),
        actions: [
          IconButton(
            icon: Icon(
              Icons.file_download_outlined,
              color: AppColors.primaryColor,
              size: 30,
            ),
            onPressed: () async {
              if (reportGenerator.generatedActivitySummary.isEmpty ||
                  reportGenerator.generatedContent.isEmpty ||
                  reportGenerator.generatedFollowUp.isEmpty ||
                  reportGenerator.generatedHighlightsOfActivity.isEmpty) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text(
                              "Processing...",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );

                // Wait for the content generation to finish
                await Future.wait([
                  reportGenerator.generateContent(event),
                  reportGenerator.generateHighlightsOfActivity(event),
                  reportGenerator.generateKeyTakeAways(event),
                  reportGenerator.generateActivitySummary(event),
                  reportGenerator.generateFollowUp(event),
                ]);

                Navigator.of(context).pop(); // Dismiss the loading dialog

                // Check again if the content is generated after the process
                if (reportGenerator.generatedActivitySummary.isNotEmpty &&
                    reportGenerator.generatedContent.isNotEmpty &&
                    reportGenerator.generatedFollowUp.isNotEmpty &&
                    reportGenerator.generatedHighlightsOfActivity.isNotEmpty) {
                  final EventReport eventReport = EventReport(
                    generalInfo: GeneralInfo(
                      type: '',
                      title: event.eventName,
                      date: date,
                      time: '',
                      venue: '',
                    ),
                    speakerDetails: [],
                    participantsDetail: ParticipantsDetail(
                        typeOfParticipants: '', noOfParticipants: 5),
                    eventSynopsis: EventSynopsis(
                      highlights: reportGenerator.generatedHighlightsOfActivity,
                      keyTakeaways: reportGenerator.generatedKeyTakeAways,
                      summary: reportGenerator.generatedActivitySummary,
                      followUp: reportGenerator.generatedFollowUp,
                    ),
                    rapporteurName: '',
                    rapporteurEmail: '',
                    eventDescriptiveReport: reportGenerator.generatedContent,
                    speakersProfile: [],
                    geoTagPhotos: '',
                    feedbackForm: '',
                    activityImages: '',
                    poster: event.eventImage,
                  );

                  Navigator.of(context)
                      .pushNamed(ReportForm.routeName, arguments: eventReport);
                }
              } else {
                // Directly navigate to the Report Form if everything is already generated
                final EventReport eventReport = EventReport(
                  generalInfo: GeneralInfo(
                    type: '',
                    title: event.eventName,
                    date: date,
                    time: '',
                    venue: '',
                  ),
                  speakerDetails: [],
                  participantsDetail: ParticipantsDetail(
                      typeOfParticipants: '', noOfParticipants: 5),
                  eventSynopsis: EventSynopsis(
                    highlights: reportGenerator.generatedHighlightsOfActivity,
                    keyTakeaways: reportGenerator.generatedKeyTakeAways,
                    summary: reportGenerator.generatedActivitySummary,
                    followUp: reportGenerator.generatedFollowUp,
                  ),
                  rapporteurName: '',
                  rapporteurEmail: '',
                  eventDescriptiveReport: reportGenerator.generatedContent,
                  speakersProfile: [],
                  geoTagPhotos: '',
                  feedbackForm: '',
                  activityImages: '',
                  poster: event.eventImage,
                );

                Navigator.of(context)
                    .pushNamed(ReportForm.routeName, arguments: eventReport);
              }
            },
          ),
        ],
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
                        padding: const EdgeInsets.all(
                            8.0), // Padding around the image
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
                      )),
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
              event.eventLink!.isEmpty
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.all(16),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
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
                                    if (url == null) {
                                      url = '';
                                    } else {
                                      if (!await launchUrl(Uri.parse(url))) {
                                        throw Exception(
                                            'Could not launch $url');
                                      }
                                    }
                                  },
                                style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color(0xff0B3F63))),
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
                    const SizedBox(
                      height: 16,
                    )
                  ],
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
