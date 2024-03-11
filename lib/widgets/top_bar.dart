import 'package:flutter/material.dart';

Widget TopBar() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: const BoxDecoration(
      color: Color(0xff002848),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "EventQuest",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xffefefd0),
            fontFamily: 'Roboto-Black',
          ),
        ),
        Image.asset(
          scale: 1,
          height: 48,
          "assets/images/christ-logo-color.png",
          fit: BoxFit.cover,
        ),
      ],
    ),
  );
}
