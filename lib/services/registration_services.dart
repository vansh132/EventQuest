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
}
