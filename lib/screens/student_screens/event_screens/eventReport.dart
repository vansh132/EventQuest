import 'package:eventquest/models/eventReport.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReportForm extends StatefulWidget {
  static const String routeName = '/event-report-screen';
  const ReportForm();

  @override
  _ReportFormState createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  late TextEditingController _typeController;
  late TextEditingController _titleController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  late TextEditingController _venueController;
  late TextEditingController _typeOfParticipantsController;
  late TextEditingController _noOfParticipantsController;
  late TextEditingController _highlightsController;
  late TextEditingController _keyTakeawaysController;
  late TextEditingController _summaryController;
  late TextEditingController _followUpController;
  late TextEditingController _rapporteurNameController;
  late TextEditingController _rapporteurEmailController;
  late TextEditingController _eventDescriptionController;
  late TextEditingController _geoTagController;
  late TextEditingController _feedbackFormController;
  late TextEditingController _activityImagesController;
  late TextEditingController _posterController;
  final List<TextEditingController> _speakerNameControllers = [];
  final List<TextEditingController> _speakerPositionControllers = [];
  final List<TextEditingController> _speakerTitleControllers = [];
  final List<TextEditingController> _speakerOrganizationControllers = [];
  final List<TextEditingController> _speakerBioControllers = [];
  final List<TextEditingController> _speakerImageControllers = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final EventReport eventReport =
        ModalRoute.of(context)!.settings.arguments as EventReport;
    _typeController = TextEditingController(text: eventReport.generalInfo.type);
    _titleController =
        TextEditingController(text: eventReport.generalInfo.title);
    _dateController = TextEditingController(text: eventReport.generalInfo.date);
    _timeController = TextEditingController(text: eventReport.generalInfo.time);
    _venueController =
        TextEditingController(text: eventReport.generalInfo.venue);
    _typeOfParticipantsController = TextEditingController(
        text: eventReport.participantsDetail.typeOfParticipants);
    _noOfParticipantsController = TextEditingController(
        text: eventReport.participantsDetail.noOfParticipants.toString());
    _highlightsController =
        TextEditingController(text: eventReport.eventSynopsis.highlights);
    _keyTakeawaysController =
        TextEditingController(text: eventReport.eventSynopsis.keyTakeaways);
    _summaryController =
        TextEditingController(text: eventReport.eventSynopsis.summary);
    _followUpController =
        TextEditingController(text: eventReport.eventSynopsis.followUp);
    _rapporteurNameController =
        TextEditingController(text: eventReport.rapporteurName);
    _rapporteurEmailController =
        TextEditingController(text: eventReport.rapporteurEmail);
    _eventDescriptionController =
        TextEditingController(text: eventReport.eventDescriptiveReport);
    _geoTagController = TextEditingController(text: eventReport.geoTagPhotos);
    _feedbackFormController =
        TextEditingController(text: eventReport.feedbackForm);
    _activityImagesController =
        TextEditingController(text: eventReport.activityImages);
    _posterController = TextEditingController(text: eventReport.poster);

    for (var speakerDetail in eventReport.speakerDetails) {
      _speakerNameControllers
          .add(TextEditingController(text: speakerDetail.name));
      _speakerPositionControllers
          .add(TextEditingController(text: speakerDetail.position));
      _speakerTitleControllers
          .add(TextEditingController(text: speakerDetail.presentationTitle));
      _speakerOrganizationControllers
          .add(TextEditingController(text: speakerDetail.organization));
    }

    for (var speakerBio in eventReport.speakersProfile) {
      _speakerBioControllers.add(TextEditingController(text: speakerBio.bio));
      _speakerImageControllers
          .add(TextEditingController(text: speakerBio.image));
    }
  }

  List<pw.Widget> _buildSpeakerDetailsPdf() {
    List<pw.Widget> widgets = [];
    for (int i = 0; i < _speakerNameControllers.length; i++) {
      widgets.add(pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Speaker ${i + 1} Details',
              style:
                  pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
          pw.Table(
            border: pw.TableBorder.all(),
            children: [
              _buildTableRow('Name', _speakerNameControllers[i].text),
              _buildTableRow(
                  'Title/Position', _speakerPositionControllers[i].text),
              _buildTableRow(
                  'Organization', _speakerOrganizationControllers[i].text),
              _buildTableRow(
                  'Title of Presentation', _speakerTitleControllers[i].text),
            ],
          ),
          pw.SizedBox(height: 10),
        ],
      ));
    }
    return widgets;
  }

  void _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Center(
              child: pw.Column(
                children: [
                  pw.Text('School of Sciences',
                      style: pw.TextStyle(
                          fontSize: 16, fontWeight: pw.FontWeight.bold)),
                  pw.Text('Department of Computer Science',
                      style: pw.TextStyle(
                          fontSize: 14, fontWeight: pw.FontWeight.bold)),
                  pw.Text('CHRIST (Deemed to be University), Bangalore',
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: 8),
                  pw.Text('Activity Report',
                      style: pw.TextStyle(
                          fontSize: 18, fontWeight: pw.FontWeight.bold)),
                ],
              ),
            ),
            pw.SizedBox(height: 16),
            pw.Text('General Information',
                style:
                    pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                _buildTableRow('Type of Activity', _typeController.text),
                _buildTableRow('Title of the Activity', _titleController.text),
                _buildTableRow('Date/s', _dateController.text),
                _buildTableRow('Time', _timeController.text),
                _buildTableRow('Venue', _venueController.text),
              ],
            ),
            pw.SizedBox(height: 16),
            pw.Text('Speaker/Guest/Presenter Details',
                style:
                    pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            ..._buildSpeakerDetailsPdf(),
            pw.SizedBox(height: 16),
            pw.Text('Participants Profile',
                style:
                    pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                _buildTableRow(
                    'Type of Participants', _typeOfParticipantsController.text),
                _buildTableRow(
                    'No. of Participants', _noOfParticipantsController.text),
              ],
            ),
            pw.SizedBox(height: 16),
            pw.Text('Synopsis of the Activity (Description)',
                style:
                    pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                _buildTableRow(
                    'Highlights of Activity', _highlightsController.text),
                _buildTableRow('Key Takeaways', _keyTakeawaysController.text),
                _buildTableRow('Summary Of Activity', _summaryController.text),
                _buildTableRow(
                    'Follow-up Plan, if any', _followUpController.text),
              ],
            ),
            pw.SizedBox(height: 16),
            pw.Text('Rapporteur',
                style:
                    pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                _buildTableRow(
                    'Rapporteur Name', _rapporteurNameController.text),
                _buildTableRow(
                    'Rapporteur Email', _rapporteurEmailController.text),
              ],
            ),
            _buildTextBlock('Event Report', _eventDescriptionController.text),
            pw.Text('Speakers Profile',
                style:
                    pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            for (int i = 0; i < _speakerBioControllers.length; i++)
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Container(
                        width: 100,
                        height: 100,
                        child: pw.Text(
                          "Image",
                        ),
                      ),
                      pw.SizedBox(width: 20),
                      pw.Expanded(
                        child: pw.Text(
                          _speakerBioControllers[i].text,
                          textAlign: pw.TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 20),
                ],
              ),
            pw.Text('Additional Information',
                style:
                    pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            _buildTextBlock('Geo Tag Photos', _geoTagController.text),
            _buildTextBlock('Feedback Form', _feedbackFormController.text),
            _buildTextBlock('Activity Images', _activityImagesController.text),
            _buildTextBlock('Poster', _posterController.text),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  pw.TableRow _buildTableRow(String label, String value) {
    return pw.TableRow(
      children: [
        pw.Container(
          width: MediaQuery.of(context).size.width * 0.3,
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(label,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ),
        pw.Container(
          width: MediaQuery.of(context).size.width * 0.7,
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(value),
        ),
      ],
    );
  }

  pw.Widget _buildTextBlock(String title, String content) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title,
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 8),
        pw.Text(content),
        pw.SizedBox(height: 16),
      ],
    );
  }

  @override
  void dispose() {
    _typeController.dispose();
    _titleController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _venueController.dispose();
    _typeOfParticipantsController.dispose();
    _noOfParticipantsController.dispose();
    _highlightsController.dispose();
    _keyTakeawaysController.dispose();
    _summaryController.dispose();
    _followUpController.dispose();
    _rapporteurNameController.dispose();
    _rapporteurEmailController.dispose();
    _eventDescriptionController.dispose();
    _geoTagController.dispose();
    _feedbackFormController.dispose();
    _activityImagesController.dispose();
    _posterController.dispose();
    for (var controller in _speakerNameControllers) {
      controller.dispose();
    }
    for (var controller in _speakerPositionControllers) {
      controller.dispose();
    }
    for (var controller in _speakerTitleControllers) {
      controller.dispose();
    }
    for (var controller in _speakerOrganizationControllers) {
      controller.dispose();
    }
    for (var controller in _speakerBioControllers) {
      controller.dispose();
    }
    for (var controller in _speakerImageControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addSpeaker() {
    setState(() {
      _speakerNameControllers.add(TextEditingController());
      _speakerPositionControllers.add(TextEditingController());
      _speakerTitleControllers.add(TextEditingController());
      _speakerOrganizationControllers.add(TextEditingController());
      _speakerBioControllers.add(TextEditingController());
      _speakerImageControllers.add(TextEditingController());
    });
  }

  void _removeSpeaker(int index) {
    setState(() {
      _speakerNameControllers[index].dispose();
      _speakerPositionControllers[index].dispose();
      _speakerTitleControllers[index].dispose();
      _speakerOrganizationControllers[index].dispose();
      _speakerBioControllers[index].dispose();
      _speakerImageControllers[index].dispose();
      _speakerNameControllers.removeAt(index);
      _speakerPositionControllers.removeAt(index);
      _speakerTitleControllers.removeAt(index);
      _speakerOrganizationControllers.removeAt(index);
      _speakerBioControllers.removeAt(index);
      _speakerImageControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Event Report'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(_typeController, 'Event Type', false),
            _buildTextField(_titleController, 'Event Title', false),
            _buildTextField(_dateController, 'Event Date', false),
            _buildTextField(_timeController, 'Event Time', false),
            _buildTextField(_venueController, 'Event Venue', false),
            _buildTextField(
                _typeOfParticipantsController, 'Type of Participants', false),
            _buildTextField(
                _noOfParticipantsController, 'Number of Participants', false),
            _buildTextField(_highlightsController, 'Event Highlights', true),
            _buildTextField(_keyTakeawaysController, 'Key Takeaways', true),
            _buildTextField(_summaryController, 'Event Summary', true),
            _buildTextField(_followUpController, 'Follow-Up', true),
            _buildTextField(
                _rapporteurNameController, 'Rapporteur Name', false),
            _buildTextField(
                _rapporteurEmailController, 'Rapporteur Email', false),
            _buildTextField(
                _eventDescriptionController, 'Event Description', true),
            ..._buildSpeakerDetails(),
            ..._buildSpeakerBios(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addSpeaker,
              child: const Text('Add Speaker'),
            ),
            _buildTextField(_geoTagController, 'Geo Tag Photos', false),
            _buildTextField(_feedbackFormController, 'Feedback Form', false),
            _buildTextField(
                _activityImagesController, 'Activity Images', false),
            _buildTextField(_posterController, 'Poster', false),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _generatePdf();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSpeakerDetails() {
    List<Widget> widgets = [];
    for (int i = 0; i < _speakerNameControllers.length; i++) {
      widgets.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Speaker ${i + 1} Details',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          _buildTextField(_speakerNameControllers[i], 'Speaker Name', false),
          _buildTextField(
              _speakerPositionControllers[i], 'Speaker Position', false),
          _buildTextField(
              _speakerTitleControllers[i], 'Presentation Title', false),
          _buildTextField(
              _speakerOrganizationControllers[i], 'Organization', false),
          ElevatedButton(
            onPressed: () => _removeSpeaker(i),
            child: Text('Remove Speaker ${i + 1}'),
          ),
        ],
      ));
    }
    return widgets;
  }

  List<Widget> _buildSpeakerBios() {
    List<Widget> widgets = [];
    for (int i = 0; i < _speakerBioControllers.length; i++) {
      widgets.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Speaker ${i + 1} Bio',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          _buildTextField(_speakerImageControllers[i], 'Speaker Image', false),
          _buildTextField(_speakerBioControllers[i], 'Speaker Bio', true),
        ],
      ));
    }
    return widgets;
  }

  Widget _buildTextField(
      TextEditingController controller, String labelText, bool maxlines) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        maxLines: maxlines ? 4 : 1,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
        ),
      ),
    );
  }

  void _saveForm() {
    // You can now use the controllers' values to update the eventReport object
    print('Form Saved');
    // Add your save logic here
  }
}
