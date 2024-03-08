import 'dart:io';

import 'package:eventquest/constants/global_variable.dart';
import 'package:eventquest/models/task.dart';
import 'package:eventquest/screens/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TaskServices {
  Future<void> addTask({
    required BuildContext context,
    required String taskTitle,
    required String taskDescription,
    required String taskType,
    required String assignedTo,
    required String assignedBy,
    required File file,
    required String remarks,
    required bool taskStatus,
  }) async {
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    try {
      Task task = Task(
        taskTitle: taskTitle,
        taskDescription: taskDescription,
        taskType: taskType,
        assignedTo: assignedTo,
        assignedBy: assignedBy,
        taskStatus: taskStatus,
      );
      // Event event = Event(
      //     eventId: '',
      //     eventName: eventName,
      //     eventDescription: eventDescription,
      //     eventAmount: eventAmount,
      //     eventImage: imageUrl,
      //     eventCategory: eventCategory,
      //     eventPublishedOn: eventPublishedOn.toString(),
      //     eventNoOfParticipants: eventNoOfParticipants,
      //     eventLink: eventLink,
      //     eventContactPerson: eventContactPerson,
      //     eventContactPersonNo: eventContactNo,
      //     eventRegistrationDeadline: eventRegistartionDeadline.toString());
      // print(event.toJson());
      // http.Response res = await http.post(
      //   Uri.parse('$url/api/add-task'),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8'
      //   },
      //   body: task.toJson(),
      // );

      // httpErrorHandle(
      //     response: res,
      //     onError: (errMessage) {
      //       showSnackBar(context, errMessage);
      //     },
      //     onSuccess: () {
      //       showSnackBar(context, "Event Added Successfully");
      //       Navigator.pop(context);
      //     });
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
  }
}
