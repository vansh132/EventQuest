import 'dart:convert';

import 'package:eventquest/constants/error_handling.dart';
import 'package:eventquest/constants/global_variable.dart';
import 'package:eventquest/models/registration.dart';
import 'package:eventquest/screens/constants/utils.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrationServices {
  Future<List<Registration>> getAllRegistrations(BuildContext context) async {
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    // Event List
    List<Registration> registrationList = [];

    try {
      http.Response res = await http.get(Uri.parse("$url/api/registrations"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
          response: res,
          onError: (errMessage) {
            showSnackBar(context, errMessage);
          },
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              registrationList.add(
                  Registration.fromJson(jsonEncode(jsonDecode(res.body)[i])));
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
    required String eventName,
    required String userName,
    required String eventAmount,
    required List<String> participantsName,
    required List<String> participantsCategory,
    required List<String> participantsRegisterNo,
  }) async {
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    try {
      Registration registration = Registration(
        registrationId: '',
        eventName: eventName,
        userName: userName,
        eventAmount: eventAmount,
        participantsName: participantsName,
        participantsCategory: participantsCategory,
        participantsRegisterNo: participantsRegisterNo,
      );

      http.Response res = await http.post(
        Uri.parse('$url/api/add-registration'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: registration.toJson(),
      );
      print(registration);
      httpErrorHandle(
          response: res,
          onError: (errMessage) {
            showSnackBar(context, errMessage);
          },
          onSuccess: () {
            showSnackBar(context, "Task Added Successfully");
            // Navigator.pop(context);
          });
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
  }
}
