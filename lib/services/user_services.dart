import 'package:eventquest/constants/error_handling.dart';
import 'package:eventquest/constants/global_variable.dart';
import 'package:eventquest/provider/user_provider.dart';
import 'package:eventquest/screens/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class UserService {
  void signIn(
      {required BuildContext context,
      required String username,
      required String password}) async {
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    try {
      final uri = Uri.parse("$url/api/v1/signin").replace(queryParameters: {
        'username': username,
        'password': password,
      });
      http.Response res = await http.post(uri, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });

      httpErrorHandle(
        response: res,
        onSuccess: () async {
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
        },
        onError: (errorMessage) {
          showSnackBar(context, errorMessage);
        },
      );
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
  }
}
