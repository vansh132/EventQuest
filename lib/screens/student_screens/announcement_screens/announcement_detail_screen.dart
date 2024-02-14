import 'package:carousel_slider/carousel_slider.dart';
import 'package:eventquest/models/announcement.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  static const String routeName = '/announcement_detail';

  const AnnouncementDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Announcement announcement =
        ModalRoute.of(context)!.settings.arguments as Announcement;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcement Details'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnnouncementCarouselSlider(announcement: announcement),
            AnnouncementDetailContent(announcement: announcement),
          ],
        ),
      ),
    );
  }
}

class AnnouncementDetailContent extends StatelessWidget {
  const AnnouncementDetailContent({
    super.key,
    required this.announcement,
  });

  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              announcement.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Date: ${DateFormat('MMM d, y').format(DateTime.now().toLocal())}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  announcement.description,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnnouncementCarouselSlider extends StatelessWidget {
  const AnnouncementCarouselSlider({
    super.key,
    required this.announcement,
  });

  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        autoPlay: true,
        aspectRatio: 2.0,
      ),
      items: announcement.image!.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                        opacity: animation,
                        child: FullScreenImage(url: url),
                      );
                    },
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Hero(
                    tag: 'announcement_image_${url.hashCode}',
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.asset(
                          url,
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String url;

  const FullScreenImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context); // Navigate back to the detail screen
        },
        child: PhotoView(
          imageProvider: AssetImage(url),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
          backgroundDecoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
