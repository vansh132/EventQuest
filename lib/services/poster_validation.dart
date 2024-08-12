import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../screens/constants/utils.dart';

class PosterValidation {
  Future<List<dynamic>> verifyPoster(
      {required BuildContext context, required File posterImage}) async {
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    List<dynamic> result = [];

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://127.0.0.1:8000/upload'),
      );

      request.headers['Content-Type'] = 'multipart/form-data';

      // Add your file
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        posterImage.path,
      ));

      // Send the request
      http.StreamedResponse streamedResponse = await request.send();

      // Convert the StreamedResponse to a Response
      http.Response response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("Poster uploaded successfully...");
        var responseBody = jsonDecode(response.body);
        if (responseBody['status']) {
          print(responseBody['message']);
          result.addAll(responseBody[
              'bounding_boxes']); // responseBody['bounding_boxes'];
          print(result);
        } else {
          print(responseBody['message']);
          result.add(responseBody['message']); // responseBody['message'];
          // print("inside..." + result.toString());
        }
      } else {
        print('Upload failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }

    return result;
  }

  Future<String> verifyLogo({
    required BuildContext context,
    required File posterImage,
    required String xmin,
    required String ymin,
    required String xmax,
    required String ymax,
  }) async {
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    String result = "";

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://127.0.0.1:7000/detect-text-db'),
      );

      request.headers['Content-Type'] = 'multipart/form-data';

      request.fields.addAll({
        "xmin": xmin,
        "ymin": ymin,
        "xmax": xmax,
        "ymax": ymax,
      });
      // Add your file
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        posterImage.path,
      ));

      // Send the request
      http.StreamedResponse streamedResponse = await request.send();

      // Convert the StreamedResponse to a Response
      http.Response response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("Poster uploaded successfully...");
        var responseBody = jsonDecode(response.body);
        if (responseBody['status']) {
          print(responseBody['message']);
          result = responseBody['message'];
        } else {
          print(responseBody['message']);
          result = responseBody['message'];
        }
      } else {
        print('Upload failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }

    return result;
  }
}
