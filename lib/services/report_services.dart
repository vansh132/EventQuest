import 'dart:convert';

import 'package:event_quest/constants/error_handling.dart';
import 'package:event_quest/constants/global_variable.dart';
import 'package:event_quest/models/eventReport.dart';
import 'package:event_quest/screens/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReportServices {
  Future<List<EventReport>> getAllReports(BuildContext context) async {
    List<EventReport> eventReportList = [];

    try {
      final res = await http.get(Uri.parse("$url/api/v1/reports"), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });

      httpErrorHandle(
          response: res,
          onError: (errMessage) {
            showSnackBar(context, errMessage);
          },
          onSuccess: () {
            final jsonData = jsonDecode(res.body) as List;
            eventReportList =
                jsonData.map((item) => EventReport.fromJson(item)).toList();
          });
    } catch (e) {
      final errorMessage = "Error occurred: ${e.toString()}";
      showSnackBar(context, errorMessage);
    }
    return eventReportList;
  }

  Future<void> addEventReport(EventReport eventReport) async {
    final url = Uri.parse('/api/v1/reports');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(eventReport.toJson()),
    );

    if (response.statusCode == 200) {
      print('Event report added successfully');
    } else {
      throw Exception('Failed to add event report');
    }
  }
}
