import 'package:flutter/material.dart';

Widget TopBar() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.redAccent,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "EventQuest",
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Roboto-Black',
          ),
        ),
        Text("christ logo"),
      ],
    ),
  );
}
