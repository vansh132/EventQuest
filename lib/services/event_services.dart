import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:eventquest/constants/error_handling.dart';
import 'package:eventquest/constants/global_variable.dart';
import 'package:eventquest/models/event.dart';

import 'package:eventquest/screens/constants/utils.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class EventServices {
  //GET ALL EVENTS
  Future<List<Event>> getAllEvents(BuildContext context) async {
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    // Event List
    List<Event> eventList = [];

    try {
      http.Response res = await http.get(Uri.parse("$url/api/v1/events"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
          response: res,
          onError: (errMessage) {
            showSnackBar(context, errMessage);
          },
          onSuccess: () {
            // print(jsonEncode(jsonDecode(res.body)['data']));
            for (int i = 0; i < jsonDecode(res.body)['data'].length; i++) {
              eventList.add(
                  Event.fromJson(jsonEncode(jsonDecode(res.body)['data'][i])));
            }
          });
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
    return eventList;
  }

  //GET ALL UG EVENTS
  Future<List<Event>> getAllUgEvents(BuildContext context) async {
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    // Event List
    List<Event> eventList = [];

    try {
      http.Response res = await http.get(Uri.parse("$url/api/v1/ug/events"),
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

  //GET ALL PG EVENTS
  Future<List<Event>> getAllPgEvents(BuildContext context) async {
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    // Event List
    List<Event> eventList = [];

    try {
      http.Response res = await http.get(Uri.parse("$url/api/v1/pg/events"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
          response: res,
          onError: (errMessage) {
            showSnackBar(context, errMessage);
          },
          onSuccess: () {
            print(jsonDecode(res.body)['data']);
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

  //ADD AN EVENTS
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
      // print(event.toJson());
      http.Response res = await http.post(
        Uri.parse('$url/api/v1/add/event'),
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
            // showSnackBar(context, "Event Added Successfully");
            Navigator.pop(context);
          });
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
  }

  //UPDATE AN EVENTS
  void updateEvent(
      {required BuildContext context,
      required String existImage,
      required bool imageUpdateFlag,
      required String eventId,
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
    String imageUrl = "";
    if (imageUpdateFlag == true) {
      final cloudinary = CloudinaryPublic('dq1q5mtdo', 'fwsfdscu');
      CloudinaryResponse cloudinaryRes = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          eventImage.path,
          folder: "Events",
        ),
      );
      imageUrl = cloudinaryRes.secureUrl;
    } else {
      imageUrl = existImage;
    }

    final eventData = {
      "_id": eventId,
      "eventName": eventName,
      "eventDescription": eventDescription,
      "eventAmount": eventAmount,
      "eventImage": imageUrl,
      "eventCategory": eventCategory,
      "eventPublishedOn": eventPublishedOn.toString(),
      "eventNoOfParticipants": eventNoOfParticipants,
      "eventLink": eventLink,
      "eventContactPerson": eventContactPerson,
      "eventContactPersonNo": eventContactNo,
      "eventRegistrationDeadline": eventRegistartionDeadline.toString()
    };

    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    try {
      http.Response res =
          await http.post(Uri.parse("$url/api/v1/update/event?id=$eventId"),
              headers: <String, String>{
                "Content-Type": 'application/json; charset=UTF-8',
                // 'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode(eventData));
      httpErrorHandle(
          response: res,
          onError: (errMessage) {
            showSnackBar(context, errMessage);
          },
          onSuccess: () {
            // showSnackBar(context, "Event Updated!! ");
            // Navigator.of(context).pop();
          });
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
  }

  //DELETE AN EVENT
  void deleteEvent({
    required BuildContext context,
    required Event event,
    required VoidCallback onSuccess,
  }) async {
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    try {
      http.Response res = await http.post(
        Uri.parse('$url/api/v1/delete/event?id=${event.eventId}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          // 'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
          response: res,
          onError: (errMessage) {
            showSnackBar(context, errMessage);
          },
          onSuccess: () {
            // showSnackBar(context, "Event Deleted!!");
            Navigator.of(context).pop();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
