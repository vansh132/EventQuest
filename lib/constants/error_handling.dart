import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required void Function(String) onError,
  required VoidCallback onSuccess,
}) {
  print("object");
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
