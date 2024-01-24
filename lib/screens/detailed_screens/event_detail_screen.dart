import 'package:flutter/material.dart';

class EventDetailsScreen extends StatelessWidget {
  static const String routeName = '/event-detail-screen';
  const EventDetailsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: const Center(child: Text("Detail Screen")),
      ),
    );
  }
}
