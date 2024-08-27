import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:eventquest/constants/error_handling.dart';
import 'package:eventquest/constants/global_variable.dart';
import 'package:eventquest/models/announcement.dart';
import 'package:eventquest/provider/user_provider.dart';
import 'package:eventquest/screens/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AnnouncementServices {
  Future<List<Announcement>> getAllAnnouncements(BuildContext context) async {
    // final userProvider = Provider.of<UserProvider>(context, listen: false);

    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    // Announcement List
    List<Announcement> announcementList = [];

    try {
      http.Response res = await http.get(Uri.parse("$url/api/v1/announcements"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });

      httpErrorHandle(
          response: res,
          onError: (errMessage) {
            showSnackBar(context, errMessage);
          },
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body)['data'].length; i++) {
              announcementList.add(Announcement.fromJson(
                  jsonEncode(jsonDecode(res.body)['data'][i])));
            }
          });
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
    return announcementList.reversed.toList();
  }

  Future<void> addAnnouncement({
    required BuildContext context,
    required String announcementTitle,
    required String announcementDescription,
    required List<File> announcementImages,
    required String announcementPublishedOn,
  }) async {
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    final user = Provider.of<UserProvider>(context, listen: false);

    try {
      final cloudinary = CloudinaryPublic("dq1q5mtdo", "fwsfdscu");
      List<String> imageUrl = [];
      for (var i = 0; i < announcementImages.length; i++) {
        CloudinaryResponse cloudinaryRes = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            announcementImages[i].path,
            folder: "Announcements",
          ),
        );
        imageUrl.add(cloudinaryRes.secureUrl);
      }
      Announcement announcement = Announcement(
          announcementId: '',
          announcementTitle: announcementTitle,
          announcementDescription: announcementDescription,
          announcementImages: imageUrl,
          announcementPublishedBy: user.user.username,
          announcementPublishedOn: announcementPublishedOn);

      http.Response res = await http.post(
        Uri.parse('$url/api/v1/announcements'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: announcement.toJson(),
      );

      httpErrorHandle(
          response: res,
          onError: (errMessage) {
            customSnackbar(context, "Error", 'Failed to Add Announcement!!');
          },
          onSuccess: () {
            Timer(const Duration(seconds: 4), () {
              Navigator.pop(context); // Go back to previous screen
            });
            customSnackbar(
                context, "Success", "Announcement Added Successfully!!");
          });
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
  }

  void updateAnnouncement({
    required BuildContext context,
    required bool imageUpdateFlag,
    required List<String> existingImages,
    required String announcementId,
    required String announcementTitle,
    required String announcementDescription,
    required List<File> announcementImages,
  }) async {
    final cloudinary = CloudinaryPublic("dq1q5mtdo", "fwsfdscu");
    List<String> imageUrl = [];

    if (imageUpdateFlag == true) {
      for (var i = 0; i < announcementImages.length; i++) {
        CloudinaryResponse cloudinaryRes = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            announcementImages[i].path,
            folder: "Announcements",
          ),
        );
        imageUrl.add(cloudinaryRes.secureUrl);
      }
    } else {
      imageUrl = existingImages;
    }

    print(imageUrl);
    final announcementData = {
      "_id": announcementId,
      "announcementTitle": announcementTitle,
      "announcementDescription": announcementDescription,
      "announcementImages": imageUrl,
    };
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    try {
      http.Response res =
          await http.put(Uri.parse("$url/api/v1/announcements/$announcementId"),
              headers: <String, String>{
                "Content-Type": 'application/json; charset=UTF-8',
                // 'x-auth-token': userProvider.user.token,
              },
              body: jsonEncode(announcementData));

      httpErrorHandle(
          response: res,
          onError: (errMessage) {
            customSnackbar(context, "Error", 'Failed to Update Announcement!!');
          },
          onSuccess: () {
            customSnackbar(
                context, "Success", 'Announcement Updated Successfully!!');
            Timer(const Duration(seconds: 3), () {
              Navigator.pop(context); // Go back to previous screen
            });
          });
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
  }

  void deleteAnnouncement(
      {required BuildContext context,
      required Announcement announcement,
      required VoidCallback onSuccess}) async {
    void handleHttpError(String errorMessage) {
      showSnackBar(context, errorMessage);
    }

    try {
      http.Response res = await http.delete(
        Uri.parse('$url/api/v1/announcements/${announcement.announcementId}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          // 'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
          response: res,
          onError: (errMessage) {
            customSnackbar(context, "Error", "Failed to Delete Announcement!!");
          },
          onSuccess: () {
            customSnackbar(
                context, "Success", "Announcement Deleted Successfully!!");
            Navigator.of(context).pop();
          });
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      handleHttpError(errorMessage);
    }
  }
}
