import 'package:flutter/material.dart';

import '../../../models/event.dart';

class AddEventScreen extends StatelessWidget {
  static const String routeName = "add_event_screen";
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
      ),
    );
  }
}
