import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:eventquest/constants/error_handling.dart';
import 'package:eventquest/constants/global_variable.dart';
import 'package:eventquest/models/event.dart';
import 'package:eventquest/provider/user_provider.dart';
import 'package:eventquest/screens/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class EventServices {
  Future<List<Event>> getAllEvents(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    // Event List
    List<Event> eventList = [];

    try {
      http.Response res = await http.get(Uri.parse("$url/api/events"),
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
              eventList
                  .add(Event.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
    return eventList;
  }

  Future<void> addEvent(
      {required BuildContext context,
      required String eventName,
      required String eventDescription,
      required double eventAmount,
      required File eventImage,
      required String eventCategory,
      required DateTime eventPublishedOn,
      required int eventNoOfParticipants,
      required String eventLink,
      required String eventContactPerson,
      required int eventContactNo,
      required DateTime eventRegistartionDeadline}) async {
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    String imageUrl = "";
    try {
      final cloudinary = CloudinaryPublic('dq1q5mtdo', 'fwsfdscu');
      CloudinaryResponse cloudinaryRes = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          eventImage.path,
          folder: "Events",
        ),
      );
      imageUrl = cloudinaryRes.secureUrl;
      Event event = Event(
          eventId: '',
          eventName: eventName,
          eventDescription: eventDescription,
          eventAmount: eventAmount,
          eventImage: imageUrl,
          eventCategory: eventCategory,
          eventPublishedOn: eventPublishedOn.toString(),
          eventNoOfParticipants: eventNoOfParticipants,
          eventLink: eventLink,
          eventContactPerson: eventContactPerson,
          eventContactPersonNo: eventContactNo,
          eventRegistrationDeadline: eventRegistartionDeadline.toString());
      print(event.toJson());
      http.Response res = await http.post(
        Uri.parse('$url/api/add-event'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: event.toJson(),
      );

      httpErrorHandle(
          response: res,
          onError: (errMessage) {
            showSnackBar(context, errMessage);
          },
          onSuccess: () {
            showSnackBar(context, "Event Added Successfully");
            Navigator.pop(context);
          });
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
  }
}
