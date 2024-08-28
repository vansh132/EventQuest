import 'package:event_quest/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class ApiScreen extends StatefulWidget {
  static const String routeName = '/api-screen';
  const ApiScreen({Key? key}) : super(key: key);

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  @override
  Widget build(BuildContext context) {
    final String generatedText =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              // Text(
              //   _event.eventName + " Report",
              //   style: Theme.of(context).textTheme.titleLarge,
              // ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: CustomColors.textBlackColor,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: CustomColors.bgLight.withOpacity(0.8),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      generatedText,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
