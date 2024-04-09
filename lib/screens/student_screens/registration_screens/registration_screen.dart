import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  static const String routeName = '/registration-screen';
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Event Name'),
                enabled: false,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Participant Name'),
                enabled: false,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Amount'),
                enabled: false,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Event Publish On'),
                enabled: false,
                keyboardType: TextInputType.datetime,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Handle form submission
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
