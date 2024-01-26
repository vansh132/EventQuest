import 'package:flutter/material.dart';

Widget TopBar() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: const BoxDecoration(
      color: Color(0xff0D1B2A),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "EventQuest",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
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
