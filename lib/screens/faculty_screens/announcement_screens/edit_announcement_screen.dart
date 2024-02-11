import 'package:eventquest/models/announcement.dart';
import 'package:eventquest/providers/announcement_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditAnnouncementScreen extends ConsumerStatefulWidget {
  static const String routeName = "edit_announcement_screen";
  const EditAnnouncementScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EditAnnouncementScreen> createState() =>
      _EditAnnouncementScreenState();
}

class _EditAnnouncementScreenState
    extends ConsumerState<EditAnnouncementScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController title;
  late TextEditingController description;
  late TextEditingController publishBy;
  late Announcement announcementData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    announcementData =
        ModalRoute.of(context)!.settings.arguments as Announcement;
    title = TextEditingController(text: announcementData.title);
    description = TextEditingController(text: announcementData.description);
    publishBy = TextEditingController(text: announcementData.publishedBy);
  }

  void _updateAnnouncement() {
    final enteredTitle = title.text;
    final enteredDescription = description.text;
    final enteredPublishBy = publishBy.text;
    final enteredPublishOn = DateTime(2024, 1, 23);
    // final enteredImage = image;

    final announcement = Announcement(
      id: "1",
      title: enteredTitle,
      description: enteredDescription,
      publishedBy: enteredPublishBy,
      publishedOn: enteredPublishOn,
    );

    ref.read(announcementProvider.notifier).editAnnouncement(announcement);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    publishBy.dispose();
    super.dispose();
  }

  bool isDataChanged() {
    return title.text != announcementData.title ||
        description.text != announcementData.description ||
        publishBy.text != announcementData.publishedBy;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Announcement'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Announcement Title",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextField(
                  controller: title,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    hintText: "Enter announcement title",
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                const Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextField(
                  controller: description,
                  onChanged: (value) {
                    setState(() {});
                  },
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Enter announcement description",
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                //TODO: add update file field
                const Text(
                  "Upload File yet to be added",
                  style: TextStyle(color: Colors.red),
                ),
                const Text(
                  "Publish By",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextField(
                  controller: publishBy,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                    hintText: "Enter publisher name",
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: isDataChanged()
                        ? () {
                            _updateAnnouncement();
                          }
                        : null,
                    child: Text('Submit'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
