import 'package:eventquest/models/announcement.dart';
import 'package:eventquest/widgets/top_bar.dart';
import 'package:eventquest/widgets/user_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  static const String routeName = '/announcement_detail';

  @override
  Widget build(BuildContext context) {
    final Announcement announcement =
        ModalRoute.of(context)!.settings.arguments as Announcement;

    return Scaffold(
      appBar: AppBar(
        title: Text('Announcement Detail'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200, // Set a specific height for the image container
            width: double.infinity,
            child: Hero(
              tag: 'announcement_image_${announcement.hashCode}',
              child: Image.network(
                announcement.image!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  announcement.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  announcement.description,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Date: ${DateFormat('MMM d, y').format(DateTime.now().toLocal())}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
