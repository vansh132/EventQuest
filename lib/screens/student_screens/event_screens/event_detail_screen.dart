import 'package:eventquest/models/event.dart';
import 'package:eventquest/models/eventReport.dart';
import 'package:eventquest/provider/user_provider.dart';
import 'package:eventquest/screens/faculty_screens/api_screen.dart';
import 'package:eventquest/screens/student_screens/event_screens/report.dart';
import 'package:eventquest/screens/student_screens/registration_screens/registration_screen.dart';
import 'package:eventquest/services/report_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
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

  List<EventReport> eventReports = [];

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

      _fetchReports(context); // Start _fetchReports
    });
  }

  Future<void> _fetchReports(BuildContext context) async {
    ReportServices service = ReportServices();
    List<EventReport> reports = await service.getAllReports(context);
    setState(() {
      eventReports = reports;
    });
  }

  Future<void> _generateContent(Event event) async {
    final content = [
      Content.text(
          "${event.eventName} Event name and ${event.eventDescription} event description.Please write the report for this event for minimum 700 and maximum 1000 words in single paragraph only.please dont use **"),
    ];
    final response = await model.generateContent(content);
    setState(() {
      generatedContent = response.text!;
    });
  }

  Future<void> _generateHighlightsOfActivity(Event event) async {
    final content = [
      Content.text(
          "${event.eventName} Event name and ${event.eventDescription} event description.Please write the Highlight of the Activity report for this event in simple paragraph with 50 words which should be real.please dont use **"),
    ];
    final response = await model.generateContent(content);
    setState(() {
      generatedHighlightsOfActivity = response.text!;
    });
  }

  Future<void> _generateKeyTakeAways(Event event) async {
    final content = [
      Content.text(
          "${event.eventName} Event name and ${event.eventDescription} event description.Please write the Key Take Aways of event in report in simple 2 bullet points or sometime 40 words one paragraph which should be real.please dont use **"),
    ];
    final response = await model.generateContent(content);
    setState(() {
      generatedKeyTakeAways = response.text!;
    });
  }

  Future<void> _generateActivitySummary(Event event) async {
    final content = [
      Content.text(
          "${event.eventName} Event name and ${event.eventDescription} event description.Please write the Summary of the Activity report for this event in simple paragraph of 70 words which should be real.please dont use **"),
    ];
    final response = await model.generateContent(content);
    setState(() {
      generatedActivitySummary = response.text!;
    });
  }

  Future<void> _generateFollowUp(Event event) async {
    final content = [
      Content.text(
          "${event.eventName} Event name and $generatedActivitySummary.Please write the FollowUp of the Activity for this event in simple one point which should be real.Don't put Title.please dont use **"),
    ];
    final response = await model.generateContent(content);
    setState(() {
      generatedFollowUp = response.text!;
    });
  }

  Future<pw.Document> _createPdf(Event event) async {
    final pdf = pw.Document();

    List<Map<String, String>> speakerDetails = [
      {
        'Name': 'John Doe',
        'Title/Position': 'Professor',
        'Organization': 'Institute',
        'Title of Presentation': 'AI and ML'
      },
      {
        'Name': 'John Doe1',
        'Title/Position': 'Professor1',
        'Organization': 'Institute1',
        'Title of Presentation': 'AI and ML1'
      }
    ];

    List<Map<String, String>> generalInfo = [
      {
        'Type of Activity': 'Workshop/Seminar/Conference/Training/Events *',
        'Title of the Activity': event.eventName,
        'Date/s': event.eventPublishedOn,
        'Time': 'Njkh',
        'Venue': 'Jk',
        'Collaboration/Sponsor (if any)': 'Njk'
      },
    ];

    List<Map<String, String>> participantsProfile = [
      {
        'Type of Participants': 'Student/Faculty/Research Scholar',
        'No. of Participants': 'Nk'
      },
    ];

    List<Map<String, String>> synopsis = [
      {
        'Highlights of the Activity': generatedHighlightsOfActivity,
        'Key Takeaways': generatedKeyTakeAways,
        'Summary of the Activity': generatedActivitySummary,
        'Follow-up Plan, if any': generatedFollowUp
      },
    ];

    List<Map<String, String>> rapporteurDetails = [
      {
        'Name of the Rapporteur': 'Nknkj Nknknl Nlk,m',
        'Email and Contact No': 'Nnknjk'
      },
    ];

    String paragraphText = generatedContent;

    List<Map<String, String>> speakers = [
      {
        'bio': '''
        Dr. John Doe is a renowned expert in computer science with over 20 years of experience in the field. He has contributed significantly to research in artificial intelligence and machine learning. He has published numerous papers in top-tier conferences and journals. He is currently a professor at XYZ University, where he leads a research group focusing on AI advancements.
        ''',
        'image': 'assets/images/placement.jpeg'
      },
      {
        'bio': '''
        Jane Smith is a leading researcher in data science, specializing in big data analytics and machine learning. She works at the ABC Institute, where she heads the Data Science department. Jane has a rich portfolio of research papers and has been a speaker at various international conferences.
        ''',
        'image': 'assets/images/placement.jpeg'
      },
    ];

    List<Uint8List> speakerImages = [];
    for (var speaker in speakers) {
      final imageBytes =
          (await rootBundle.load(speaker['image']!)).buffer.asUint8List();
      speakerImages.add(imageBytes);
    }

    pw.Widget header = pw.Column(
      children: [
        pw.Text('School of Sciences',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.Text('Department of Computer Science',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.Text('CHRIST (Deemed to be University), Bangalore',
            style: const pw.TextStyle(fontSize: 12)),
        pw.SizedBox(height: 30),
        pw.Text('Activity Report',
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 20),
      ],
    );

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Center(
            child: pw.Container(
              width: double.infinity,
              child: header,
            ),
          ),
          _buildTableSection('General Information', generalInfo),
          _buildTableSection('Speaker/Guest/Presenter Details', speakerDetails),
          _buildTableSection('Participants profile', participantsProfile),
          _buildTableSection(
              'Synopsis of the Activity (Description)', synopsis),
          _buildTableSection('Rapporteur', rapporteurDetails),
          pw.SizedBox(height: 20),
          pw.Text('Descriptive Report',
              textAlign: pw.TextAlign.justify,
              style:
                  pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          _buildParagraphSection(paragraphText),
          pw.SizedBox(height: 20),
          pw.Text('Speakers Profile',
              style:
                  pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          for (int i = 0; i < speakers.length; i++)
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      width: 100,
                      height: 100,
                      child: pw.Image(
                        pw.MemoryImage(speakerImages[i]),
                        fit: pw.BoxFit.cover,
                      ),
                    ),
                    pw.SizedBox(width: 20),
                    pw.Expanded(
                      child: pw.Text(
                        speakers[i]['bio']!,
                        textAlign: pw.TextAlign.justify,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
              ],
            ),
        ],
      ),
    );

    return pdf;
  }

  pw.Widget _buildTableSection(String title, List<Map<String, String>> data) {
    if (data.isEmpty) {
      return pw.Container(); // Return an empty container if no data is provided
    }

    // Flatten the data from List<Map<String, String>> to List<Map<String, String>>
    // where each Map contains only one key-value pair
    final flattenedData = data.expand((map) {
      return map.entries.map((entry) => {entry.key: entry.value});
    }).toList();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title,
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.Table(
          border: pw.TableBorder.all(width: 1, color: PdfColors.black),
          columnWidths: {
            0: const pw.FixedColumnWidth(150), // Adjust the width as needed
            1: const pw.FlexColumnWidth(), // Fill remaining space
          },
          children: [
            // Table Data Rows
            ...flattenedData.map((row) {
              final key = row.keys.first;
              final value = row[key] ?? '';
              return pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Text(
                      key,
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Text(
                      value,
                      textAlign: pw.TextAlign.justify,
                    ),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
        pw.SizedBox(height: 20),
      ],
    );
  }

  pw.Widget _buildParagraphSection(String text) {
    return pw.Paragraph(
      text: text,
      textAlign: pw.TextAlign.justify,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context)!.settings.arguments as Event;

    final user = Provider.of<UserProvider>(context, listen: false).user;
    var date = event.eventRegistrationDeadline.split("T")[0];
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
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
                      // if (generatedContent.isEmpty) {
                      //   // Show a message if content is not generated yet
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //         content: Text(
                      //             'Content is still generating, please wait.')),
                      //   );
                      //   return;
                      // }

                      // final pdf = await _createPdf(event);
                      // await Printing.layoutPdf(
                      //   onLayout: (PdfPageFormat format) async => pdf.save(),
                      // );
                      Navigator.of(context).pushNamed(
                        EditEventReportForm.routeName,
                      );
                    },
                    child: const Text(
                      'Generate Report',
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
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
