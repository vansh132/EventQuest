import 'dart:convert';

import 'package:eventquest/screens/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart'; // Import for VoidCallback

void httpErrorHandle({
  required http.Response response,
  required void Function(String) onError,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      onError(jsonDecode(response.body)['msg']);
      break;
    case 500:
      onError(jsonDecode(response.body)['error']);
      break;
    default:
      onError(response.body);
  }
}
