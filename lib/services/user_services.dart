import 'package:event_quest/constants/error_handling.dart';
import 'package:event_quest/constants/global_variable.dart';
import 'package:event_quest/provider/user_provider.dart';
import 'package:event_quest/screens/constants/utils.dart';
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

    void onSuccess(http.Response res) {
      Provider.of<UserProvider>(context, listen: false).setUser(res.body);
      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    }

    try {
      final uri = Uri.parse("$url/api/v1/signin").replace(queryParameters: {
        'username': username,
        'password': password,
      });
      http.Response res = await http.post(uri, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });

      print(res.statusCode);

      if (res.statusCode == 404) {
        const errorMessage = "User not found";
        handleHttpError(errorMessage);
        return;
      } else if (res.statusCode == 401) {
        const errorMessage = "Invalid password";
        handleHttpError(errorMessage);
        return;
      } else if (res.statusCode != 200) {
        const errorMessage = "Error occurred";
        handleHttpError(errorMessage);
        return;
      }

      if (res.statusCode == 200) {
        onSuccess(res);
      }

      // httpErrorHandle(
      //   response: res,
      //   onSuccess: () async {

      //     Provider.of<UserProvider>(context, listen: false).setUser(res.body);
      //     Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
      //   },
      //   onError: (errorMessage) {
      //     showSnackBar(context, errorMessage);
      //   },
      // );
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
  }
}
