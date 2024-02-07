import 'package:eventquest/models/event.dart';
import 'package:flutter/material.dart';

class EditEventScreen extends StatelessWidget {
  static const String routeName = "edit_event_screen";
  const EditEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context)!.settings.arguments as Event;
    return Scaffold(
      appBar: AppBar(
        title: Text(event.eventName),
      ),
    );
  }
}
