import 'package:flutter/material.dart';

class AddAnnouncementScreen extends StatelessWidget {
  static const String routeName = '/add-announcement-screen';
  const AddAnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController description = TextEditingController();
    TextEditingController publishBy = TextEditingController();

    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcement Form'),
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
                TextFormField(
                  controller: title,
                  decoration: const InputDecoration(
                    labelText: "Announcement Title",
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                TextFormField(
                  controller: description,
                  decoration: const InputDecoration(
                    labelText: "Description",
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
                TextFormField(
                  controller: publishBy,
                  decoration: const InputDecoration(
                    labelText: "Publish By",
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Center(
                    child:
                        ElevatedButton(onPressed: null, child: Text('Submit')))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
