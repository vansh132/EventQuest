import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  static const String routeName = '/registration-screen';
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Registration Screen"),
      ),
    );
  }
}
