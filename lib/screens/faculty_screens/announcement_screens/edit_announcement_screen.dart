import 'package:eventquest/models/announcement.dart';
import 'package:flutter/material.dart';

class EditAnnouncementScreen extends StatefulWidget {
  static const String routeName = "edit_announcement_screen";
  const EditAnnouncementScreen({super.key});

  @override
  State<EditAnnouncementScreen> createState() => _EditAnnouncementScreenState();
}

class _EditAnnouncementScreenState extends State<EditAnnouncementScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController description = TextEditingController();
    TextEditingController publishBy = TextEditingController();
    Announcement announcementData =
        ModalRoute.of(context)!.settings.arguments as Announcement;
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
                Text(
                  "Announcement Title",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextFormField(
                  controller: title,
                  decoration: InputDecoration(
                    hintText: announcementData.title,
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextFormField(
                  controller: description,
                  decoration: InputDecoration(
                    hintText: announcementData.description,
                    hintMaxLines: 5,
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
                Text(
                  "Publish By",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextFormField(
                  controller: publishBy,
                  decoration: InputDecoration(
                    hintText: announcementData.publishedBy,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Center(
                  child: ElevatedButton(
                    onPressed: null,
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
