import 'dart:convert';

import 'package:event_quest/constants/error_handling.dart';
import 'package:event_quest/constants/global_variable.dart';
import 'package:event_quest/models/event.dart';
import 'package:event_quest/models/registration.dart';
import 'package:event_quest/provider/user_provider.dart';
import 'package:event_quest/screens/constants/utils.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class RegistrationServices {
  Future<List<Registration>> getAllRegistrations(BuildContext context) async {
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    // Event List
    List<Registration> registrationList = [];

    try {
      http.Response res = await http.get(Uri.parse("$url/api/v1/registrations"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
          response: res,
          onError: (errMessage) {
            showSnackBar(context, errMessage);
          },
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body)['data'].length; i++) {
              registrationList.add(Registration.fromJson(
                  jsonEncode(jsonDecode(res.body)['data'][i])));
            }
          });
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
    return registrationList;
  }

  Future<void> addRegistration({
    required BuildContext context,
    required List<String> participantsName,
    required List<String> participantsCategory,
    required List<String> participantsRegisterNo,
  }) async {
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    final user = Provider.of<UserProvider>(context, listen: false);
    final Event event = ModalRoute.of(context)!.settings.arguments as Event;
    try {
      Registration registration = Registration(
        registrationId: '',
        eventName: event.eventName,
        userName: user.user.username,
        eventAmount: event.eventAmount.toString(),
        eventCategory: event.eventCategory,
        eventNoOfParticipants: event.eventNoOfParticipants.toString(),
        participantsName: participantsName,
        participantsCategory: participantsCategory,
        participantsRegisterNo: participantsRegisterNo,
      );

      http.Response res = await http.post(
        Uri.parse('$url/api/v1/registrations'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: registration.toJson(),
      );
      print(registration);
      httpErrorHandle(
          response: res,
          onError: (errMessage) {
            customSnackbar(context, "Error", 'Failed to Register!!');
          },
          onSuccess: () {
            customSnackbar(context, "Success", 'Registered Successfully!!');

            Navigator.pop(context);
          });
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
  }
}
