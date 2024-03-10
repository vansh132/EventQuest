import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:eventquest/constants/error_handling.dart';
import 'package:eventquest/constants/global_variable.dart';
import 'package:eventquest/models/image.dart';
import 'package:eventquest/models/task.dart';
import 'package:eventquest/provider/user_provider.dart';
import 'package:eventquest/screens/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class TaskServices {
  Future<void> addTask({
    required BuildContext context,
    required String taskTitle,
    required String taskDescription,
    required String taskType,
    required String assignedTo,
  }) async {
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    //add assigned by through provider
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    try {
      Task task = Task(
        taskTitle: taskTitle,
        taskDescription: taskDescription,
        taskType: taskType,
        assignedTo: assignedTo,
        assignedBy: userProvider.username,
        taskStatus: false,
      );

      http.Response res = await http.post(
        Uri.parse('$url/api/add-task'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: task.toJson(),
      );

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

  Future<List<Task>> getAllTasks(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    // Event List
    List<Task> taskList = [];

    try {
      http.Response res = await http.get(
          Uri.parse("$url/api/tasks/assignedTo/${userProvider.username}"),
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
              taskList.add(Task.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
    return taskList;
  }

  Future<List<Task>> getAllTasksForFaculty(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    // Event List
    List<Task> taskList = [];

    try {
      http.Response res = await http.get(
          Uri.parse("$url/api/tasks/${userProvider.username}"),
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
              taskList.add(Task.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
    return taskList;
  }

  Future<List<Task>> getAllCompletedTasks(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    // Event List
    List<Task> taskList = [];

    try {
      http.Response res = await http.get(
          Uri.parse(
              "$url/api/tasks/assignedTo/history/${userProvider.username}"),
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
              taskList.add(Task.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
    return taskList;
  }

  Future<List<ImageClass>> getAllImages(BuildContext context) async {
    // final userProvider = Provider.of<UserProvider>(context, listen: false);

    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    // Announcement List
    List<ImageClass> images = [];

    try {
      http.Response res = await http.get(Uri.parse("$url/api/highlights"),
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
              images.add(
                  ImageClass.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
      print(images);
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
    return images;
  }

  Future<void> addPoster({
    required BuildContext context,
    required String taskId,
    required File posterImage,
  }) async {
    String imageUrl = "";
    final cloudinary = CloudinaryPublic('dq1q5mtdo', 'fwsfdscu');
    CloudinaryResponse cloudinaryRes = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(
        posterImage.path,
        folder: "Task - Poster",
      ),
    );
    imageUrl = cloudinaryRes.secureUrl;
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    final posterImages = {"taskFile": imageUrl};
    print(taskId);
    try {
      http.Response res =
          await http.post(Uri.parse("$url/api/add-poster/$taskId"),
              headers: <String, String>{
                "Content-Type": 'application/json; charset=UTF-8',
                // 'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode(posterImages));
      httpErrorHandle(
          response: res,
          onError: (errMessage) {
            showSnackBar(context, errMessage);
          },
          onSuccess: () {
            showSnackBar(context, "Poster Uploaded!! ");
          });
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
  }
}
