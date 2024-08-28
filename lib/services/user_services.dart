import 'package:event_quest/constants/global_variable.dart';
import 'package:event_quest/provider/user_provider.dart';
import 'package:event_quest/screens/constants/utils.dart';
import 'package:event_quest/theme/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class UserService {
  void signIn(
      {required BuildContext context,
      required String username,
      required String password}) async {
    void handleHttpError(String errorMessage) {
      customSnackbar(context, "Error", errorMessage);
    }

    void onSuccessOperation(http.Response res) {
      customSnackbar(context, "Success", "Authentication successful");

      Provider.of<UserProvider>(context, listen: false).setUser(res.body);
      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    }

    void onSuccess(http.Response res) async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final appColors = context.appColors;
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: appColors.primary,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Authenticating...",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
      await Future.delayed(const Duration(seconds: 2));
      onSuccessOperation(res);
    }

    try {
      final uri = Uri.parse("$url/api/v1/signin").replace(queryParameters: {
        'username': username,
        'password': password,
      });
      http.Response res = await http.post(uri, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });

      if (res.statusCode == 404) {
        const errorMessage = "Invalid username";
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
